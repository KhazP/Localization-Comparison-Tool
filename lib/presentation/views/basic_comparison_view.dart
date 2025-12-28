import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart' hide Border;
import 'dart:convert';
import 'package:cross_file/cross_file.dart';
import 'package:localizer_app_main/business_logic/blocs/comparison_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/progress_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/file_watcher_bloc/file_watcher_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/file_watcher_bloc/file_watcher_event.dart';
import 'package:localizer_app_main/business_logic/blocs/file_watcher_bloc/file_watcher_state.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart'; // For ComparisonResult
import 'package:localizer_app_main/data/models/comparison_status_detail.dart'; // Import new model
import 'package:uuid/uuid.dart'; // For generating unique IDs for history
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff_view.dart';
// import 'package:localizer_app_main/presentation/views/ai_translation_settings_view.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/core/services/backup_service.dart';
import 'package:localizer_app_main/core/services/problem_detector.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:flutter/services.dart';

// Enum for filter status in Basic View

enum BasicDiffFilter { all, added, removed, modified, problems }

class BasicComparisonView extends StatefulWidget {
  final Function(int)? onNavigateToTab;
  final ComparisonSession? initialSession;

  const BasicComparisonView({
    super.key,
    this.onNavigateToTab,
    this.initialSession,
  });

  @override
  State<BasicComparisonView> createState() => _BasicComparisonViewState();
}

class _BasicComparisonViewState extends State<BasicComparisonView> {
  // ... existing fields ...

  void _navigateToAiSettings() {
    // Navigate to Settings tab (index 4)
    if (widget.onNavigateToTab != null) {
      widget.onNavigateToTab!(4);
    } else {
      // Fallback if callback not provided
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Navigation to AI Settings not available')),
      );
    }
  }

  File? _file1;
  File? _file2;
  File? _bilingualFile;
  bool _isBilingualMode = false;
  // Store the latest comparison results for the analytics bar
  ComparisonResult? _latestComparisonResult;
  BasicDiffFilter _currentFilter = BasicDiffFilter.all;

  // Drag & drop state
  bool _isDraggingOverFile1 = false;
  bool _isDraggingOverFile2 = false;
  bool _isDraggingOverBilingualFile = false;

  // Search/filter state
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';
  bool _isRegexEnabled = false;
  bool _isFuzzyEnabled = false;

  // Flag to ensure we only auto-load the last project once
  bool _hasAutoLoadedLastProject = false;
  // Flag to show loading state while we determine if we should auto-load
  bool _isCheckingAutoLoad = true;

  @override
  void initState() {
    super.initState();
    // Check if we should auto-load the last project on startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tryAutoLoadLastProject();
    });
  }

  void _tryAutoLoadLastProject() {
    if (_hasAutoLoadedLastProject) return;

    final settingsState = context.read<SettingsBloc>().state;
    final historyState = context.read<HistoryBloc>().state;

    // If settings or history aren't ready (and history isn't error), wait
    if (settingsState.status != SettingsStatus.loaded) {
      return;
    }

    // If feature disabled, stop checking
    if (!settingsState.appSettings.openLastProjectOnStartup) {
      if (mounted) setState(() => _isCheckingAutoLoad = false);
      return;
    }

    // Feature is enabled. Check history.
    if (historyState is HistoryLoading) return; // Wait for history

    if (historyState is HistoryLoaded) {
      if (historyState.history.isNotEmpty) {
        _hasAutoLoadedLastProject = true;
        _loadRecentComparison(historyState.history.first);
        // Keeps _isCheckingAutoLoad = true until comparison starts/succeeds
      } else {
        // History empty, stop checking
        if (mounted) setState(() => _isCheckingAutoLoad = false);
      }
    } else if (historyState is HistoryError) {
      // Error loading history, stop checking
      if (mounted) setState(() => _isCheckingAutoLoad = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  bool _detectProblem(String source, String? target) {
    if (ProblemDetector.hasEmptyTarget(target)) return true;
    if (ProblemDetector.hasPlaceholderMismatch(source, target)) return true;
    return false;
  }

  Future<void> _pickFile(int fileNumber) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        if (fileNumber == 1) {
          _file1 = File(result.files.single.path!);
        } else if (fileNumber == 2) {
          _file2 = File(result.files.single.path!);
        } else {
          _bilingualFile = File(result.files.single.path!);
        }
      });

      // Update file watcher when files change
      _updateFileWatcher();
    }
  }

  void _toggleFileWatching(bool enabled) {
    context.read<SettingsBloc>().add(UpdateAutoReloadOnChange(enabled));
  }

  void _toggleComparisonMode() {
    setState(() {
      _isBilingualMode = !_isBilingualMode;
    });
    _updateFileWatcher();
  }

  void _startComparison() {
    if (_isBilingualMode) {
      _startBilingualComparison();
      return;
    }
    if (_file1 != null && _file2 != null) {
      setState(() {
        _currentFilter = BasicDiffFilter.all; // Reset filter on new comparison
      });
      final settingsState = context.read<SettingsBloc>().state;
      if (settingsState.status == SettingsStatus.loaded) {
        context.read<ComparisonBloc>().add(CompareFilesRequested(
              file1: _file1!,
              file2: _file2!,
              settings: settingsState.appSettings,
            ));
      }
      _updateFileWatcher();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select two files to compare.')),
      );
    }
  }

  void _startBilingualComparison() {
    if (_bilingualFile != null) {
      setState(() {
        _currentFilter = BasicDiffFilter.all; // Reset filter on new comparison
      });
      final settingsState = context.read<SettingsBloc>().state;
      if (settingsState.status == SettingsStatus.loaded) {
        context.read<ComparisonBloc>().add(
              CompareBilingualFileRequested(
                file: _bilingualFile!,
                settings: settingsState.appSettings,
              ),
            );
      }
      _updateFileWatcher();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a bilingual file to compare.')),
      );
    }
  }

  void _updateFileWatcher() {
    final settingsState = context.read<SettingsBloc>().state;
    final isAutoReloadEnabled = settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.autoReloadOnChange;

    if (!isAutoReloadEnabled) {
      context.read<FileWatcherBloc>().add(StopWatchingFiles());
      return;
    }

    if (_isBilingualMode && _bilingualFile != null) {
      context.read<FileWatcherBloc>().add(
            StartWatchingFiles(
              _bilingualFile!.path,
              _bilingualFile!.path,
            ),
          );
      return;
    }

    if (!_isBilingualMode && _file1 != null && _file2 != null) {
      context.read<FileWatcherBloc>().add(
            StartWatchingFiles(_file1!.path, _file2!.path),
          );
    } else {
      context.read<FileWatcherBloc>().add(StopWatchingFiles());
    }
  }

  void _onFileDropped(List<XFile> files, int fileNumber) {
    if (files.isNotEmpty) {
      final file = File(files.first.path);

      // Validate file extension
      if (_isValidFileType(file.path)) {
        setState(() {
          if (fileNumber == 1) {
            _file1 = file;
          } else if (fileNumber == 2) {
            _file2 = file;
          } else {
            _bilingualFile = file;
          }
        });

        // Update file watcher when files change
        _updateFileWatcher();

        // Show success message
        final fileName = file.path.split(Platform.pathSeparator).last;
        final selectionLabel = fileNumber == 1
            ? 'Source file'
            : fileNumber == 2
                ? 'Target file'
                : 'Bilingual file';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$selectionLabel selected: $fileName'),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        // Show error for invalid file type
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Invalid file type. Please select a supported localization file.'),
            backgroundColor: Theme.of(context).colorScheme.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  bool _isValidFileType(String filePath) {
    final extension = filePath.toLowerCase().split('.').last;
    const supportedExtensions = [
      'json',
      'xml',
      'xliff',
      'xlf',
      'tmx',
      'csv',
      'yaml',
      'yml',
      'properties',
      'resx',
      'txt',
      'docx',
      'lang'
    ];
    return supportedExtensions.contains(extension);
  }

  void _navigateToAdvancedView() {
    if (_latestComparisonResult != null && _file1 != null && _file2 != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdvancedDiffView(
            comparisonResult: _latestComparisonResult!,
            sourceFile: _file1!,
            targetFile: _file2!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please perform a comparison first to see advanced details.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine if Amoled mode is active
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = settingsState.status == SettingsStatus.loaded &&
        Theme.of(context).brightness == Brightness.dark &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyF, control: true): () {
          _searchFocusNode.requestFocus();
        },
      },
      child: Focus(
        autofocus: true,
        child: MultiBlocListener(
      listeners: [
        // Auto-load last project on startup if setting is enabled
        BlocListener<HistoryBloc, HistoryState>(
          listenWhen: (previous, current) =>
              !_hasAutoLoadedLastProject && current is HistoryLoaded,
          listener: (context, historyState) {
            _tryAutoLoadLastProject();
          },
        ),
        // Also try auto-load when settings first load (in case history loaded first)
        BlocListener<SettingsBloc, SettingsState>(
          listenWhen: (previous, current) =>
              !_hasAutoLoadedLastProject &&
              previous.status != SettingsStatus.loaded &&
              current.status == SettingsStatus.loaded,
          listener: (context, state) {
            _tryAutoLoadLastProject();
          },
        ),
        BlocListener<SettingsBloc, SettingsState>(
          listenWhen: (previous, current) =>
              previous.status == SettingsStatus.loaded &&
              current.status == SettingsStatus.loaded &&
              previous.appSettings.autoReloadOnChange !=
                  current.appSettings.autoReloadOnChange,
          listener: (context, state) {
            _updateFileWatcher();
          },
        ),
        BlocListener<FileWatcherBloc, FileWatcherState>(
          listener: (context, state) {
            if (state is FileChangedDetected) {
              // Show a snackbar notification about file change
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'File changed: ${state.changedFilePath.split(Platform.pathSeparator).last}. Recomparing...'),
                  duration: const Duration(seconds: 2),
                ),
              );

              // Trigger automatic recomparison
              final settingsStateForReload = context.read<SettingsBloc>().state;
              if (settingsStateForReload.status == SettingsStatus.loaded) {
                if (_isBilingualMode) {
                  context.read<ComparisonBloc>().add(
                        CompareBilingualFileRequested(
                          file: File(state.file1Path),
                          settings: settingsStateForReload.appSettings,
                        ),
                      );
                } else {
                  context.read<ComparisonBloc>().add(
                        CompareFilesRequested(
                          file1: File(state.file1Path),
                          file2: File(state.file2Path),
                          settings: settingsStateForReload.appSettings,
                        ),
                      );
                }
              }
            }
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // File Selection Section
            Card(
              color: isAmoled ? Colors.black : Theme.of(context).cardColor,
              elevation: isAmoled ? 0.3 : 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: isAmoled
                      ? Colors.grey[850]!
                      : Theme.of(context).dividerColor.withValues(alpha: 0.5),
                ),
              ),
              margin: const EdgeInsets.only(bottom: 12.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    if (_isBilingualMode)
                      Row(
                        children: [
                          _buildFilePicker(
                            context: context,
                            title: 'Bilingual File',
                            file: _bilingualFile,
                            fileNumber: 3,
                            onPressed: () => _pickFile(3),
                            isDraggingOver: _isDraggingOverBilingualFile,
                            isAmoled: isAmoled,
                          ),
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _buildFilePicker(
                            context: context,
                            title: 'Source File',
                            file: _file1,
                            fileNumber: 1,
                            onPressed: () => _pickFile(1),
                            isDraggingOver: _isDraggingOverFile1,
                            isAmoled: isAmoled,
                          ),
                          const SizedBox(width: 12),
                          _buildFilePicker(
                            context: context,
                            title: 'Target File',
                            file: _file2,
                            fileNumber: 2,
                            onPressed: () => _pickFile(2),
                            isDraggingOver: _isDraggingOverFile2,
                            isAmoled: isAmoled,
                          ),
                        ],
                      ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.compare_arrows, size: 18),
                              label: Text(_isBilingualMode
                                  ? 'Compare File'
                                  : 'Compare Files'),
                              onPressed: _isBilingualMode
                                  ? (_bilingualFile != null
                                      ? _startComparison
                                      : null)
                                  : (_file1 != null && _file2 != null
                                      ? _startComparison
                                      : null),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 40,
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.translate_rounded, size: 18),
                            label: Text(_isBilingualMode
                                ? 'Two Files'
                                : 'Bilingual Mode'),
                            onPressed: _toggleComparisonMode,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Analytics and Actions Bar - Modified Layout
            _buildAnalyticsAndActionsBar(),
            const SizedBox(height: 16.0), // Reduced bottom margin
            BlocBuilder<ProgressBloc, ProgressState>(
              builder: (context, state) {
                if (state is ProgressLoading) {
                  double progress =
                      state.total > 0 ? state.current / state.total : 0.0;
                  return Column(
                    children: [
                      LinearProgressIndicator(value: progress),
                      const SizedBox(height: 8),
                      Text(state.message ?? 'Processing...'),
                      const SizedBox(height: 8), // Space before diff list
                    ],
                  );
                }
                if (state is ProgressFailure) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Error during processing: ${state.error}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error)));
                }
                return const SizedBox.shrink();
              },
            ),
            Expanded(
              child: BlocConsumer<ComparisonBloc, ComparisonState>(
                listener: (context, state) {
                  // When comparison state changes, we are definitely no longer checking auto load
                  if (state is ComparisonLoading ||
                      state is ComparisonSuccess ||
                      state is ComparisonFailure) {
                    if (_isCheckingAutoLoad) {
                      setState(() => _isCheckingAutoLoad = false);
                    }
                  }

                  if (state is ComparisonSuccess) {
                    // Update file references in the UI
                    final isBilingualResult =
                        state.file1.path == state.file2.path;
                    setState(() {
                      _isBilingualMode = isBilingualResult;
                      _file1 = state.file1;
                      _file2 = state.file2;
                      if (isBilingualResult) {
                        _bilingualFile = state.file1;
                      }
                      _latestComparisonResult = state.result;
                    });
                    _updateFileWatcher();

                    // Only add to history if it wasn't loaded from history
                    if (!state.wasLoadedFromHistory) {
                      final result = state.result;
                      int added = 0, removed = 0, modified = 0, identical = 0;
                      result.diff.forEach((key, statusDetail) {
                        switch (statusDetail.status) {
                          case StringComparisonStatus.added:
                            added++;
                            break;
                          case StringComparisonStatus.removed:
                            removed++;
                            break;
                          case StringComparisonStatus.modified:
                            modified++;
                            break;
                          case StringComparisonStatus.identical:
                            identical++;
                            break;
                        }
                      });
                      // Ensure file paths from the state are used for history
                      final session = ComparisonSession(
                        id: const Uuid().v4(),
                        timestamp: DateTime.now(),
                        file1Path: state.file1.path, // Use path from state
                        file2Path: state.file2.path, // Use path from state
                        stringsAdded: added,
                        stringsRemoved: removed,
                        stringsModified: modified,
                        stringsIdentical: identical,
                      );
                      context.read<HistoryBloc>().add(AddToHistory(session));
                    }
                  } else if (state is ComparisonFailure) {
                    // Optionally, clear _file1, _file2, _latestComparisonResult if a history load failed?
                    // Or just show the error via ProgressBloc/Snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Comparison failed: ${state.error}')),
                    );
                  }
                },
                builder: (context, state) {
                  final theme = Theme.of(context);

                  Widget content;
                  if (_isCheckingAutoLoad) {
                    content = const Center(
                        key: ValueKey('checking'),
                        child: CircularProgressIndicator());
                  } else if (state is ComparisonLoading) {
                    content = const Center(
                        key: ValueKey('loading'),
                        child: Text('Comparison in progress...'));
                  } else if (state is ComparisonSuccess) {
                    var diffEntries = state.result.diff.entries.toList();

                    // Apply filter

                    if (_currentFilter != BasicDiffFilter.all) {
                      diffEntries = diffEntries.where((entry) {
                        switch (_currentFilter) {
                          case BasicDiffFilter.added:
                            return entry.value.status ==
                                StringComparisonStatus.added;
                          case BasicDiffFilter.removed:
                            return entry.value.status ==
                                StringComparisonStatus.removed;
                          case BasicDiffFilter.modified:
                            return entry.value.status ==
                                StringComparisonStatus.modified;
                          case BasicDiffFilter.problems:
                            final key = entry.key;
                            final value1 = state.result.file1Data[key] ?? '';
                            final value2 = state.result.file2Data[key];
                            return _detectProblem(value1, value2);
                          default:
                            return true;
                        }
                      }).toList();
                    }

                    // Hide identical entries if setting is disabled and we are in 'All' filter
                    final showIdentical =
                        settingsState.appSettings.showIdenticalEntries;
                    int hiddenIdenticalCount = 0;
                    if (!showIdentical &&
                        _currentFilter == BasicDiffFilter.all) {
                      final identicals = diffEntries
                          .where((entry) =>
                              entry.value.status ==
                              StringComparisonStatus.identical)
                          .toList();
                      hiddenIdenticalCount = identicals.length;
                      if (hiddenIdenticalCount > 0) {
                        diffEntries = diffEntries
                            .where((entry) =>
                                entry.value.status !=
                                StringComparisonStatus.identical)
                            .toList();
                      }
                    }

                    // Apply text search filter
                    final int totalBeforeSearch = diffEntries.length;
                    if (_searchQuery.isNotEmpty) {
                      final query = _isRegexEnabled ? _searchQuery : _searchQuery.toLowerCase();
                      diffEntries = diffEntries.where((entry) {
                        final key = entry.key; // Keys are case-sensitive usually, but let's be generous
                        final value1 = (state.result.file1Data[entry.key] ?? '');
                        final value2 = (state.result.file2Data[entry.key] ?? '');
                        
                        // Regex Search
                        if (_isRegexEnabled) {
                          try {
                            final regex = RegExp(query, caseSensitive: false);
                            return regex.hasMatch(key) || 
                                   regex.hasMatch(value1) || 
                                   regex.hasMatch(value2);
                          } catch (e) {
                            return false; // Invalid regex
                          }
                        }

                        // Fuzzy Search
                        if (_isFuzzyEnabled) {
                           // Check key normally
                           if (key.toLowerCase().contains(query)) return true;
                           
                           if (value1.toLowerCase().contains(query) || value2.toLowerCase().contains(query)) return true;
                           
                           // If not found by contains, try similarity
                           if (value1.similarityTo(query) > 0.4 || value2.similarityTo(query) > 0.4) return true;
                           
                           return false;
                        }

                        // Standard Search
                        return key.toLowerCase().contains(query) ||
                            value1.toLowerCase().contains(query) ||
                            value2.toLowerCase().contains(query);
                      }).toList();
                    }

                    if (diffEntries.isEmpty) {
                      if (_searchQuery.isNotEmpty) {
                        content = Center(
                          key: const ValueKey('empty_search'),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.search_off,
                                  size: 48,
                                  color: theme.colorScheme.onSurface
                                      .withAlpha(100)),
                              const SizedBox(height: 12),
                              Text(
                                'No matches found for "$_searchQuery"',
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface
                                        .withAlpha(150)),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Showing 0 of $totalBeforeSearch entries',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurface
                                        .withAlpha(100)),
                              ),
                            ],
                          ),
                        );
                      } else if (_searchQuery.isEmpty &&
                          !state.result.diff.values.any((e) =>
                              e.status != StringComparisonStatus.identical)) {
                        content = const Center(
                            key: ValueKey('identical'),
                            child: Text('Files are identical.'));
                      } else if (diffEntries.isEmpty &&
                          hiddenIdenticalCount > 0) {
                        // If we hid everything (e.g. only identicals existed and we hid them)
                        content = Column(
                          key: const ValueKey('hidden_identical'),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '$hiddenIdenticalCount identical entries hidden',
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface
                                        .withAlpha(150))),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                context.read<SettingsBloc>().add(
                                    const UpdateShowIdenticalEntries(true));
                              },
                              child: const Text('Show Identical Entries'),
                            )
                          ],
                        );
                      } else {
                        content = const Center(
                            key: ValueKey('no_diff'),
                            child: Text('No differences found based on keys.'));
                      }
                    } else {
                      content = Column(
                        key: const ValueKey('results'),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Hidden entries summary
                          if (hiddenIdenticalCount > 0)
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: theme.dividerColor
                                        .withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.visibility_off_outlined,
                                      size: 16,
                                      color:
                                          theme.colorScheme.onSurfaceVariant),
                                  const SizedBox(width: 8),
                                  Text(
                                    '$hiddenIdenticalCount identical entries hidden',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(60, 24),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {
                                      context.read<SettingsBloc>().add(
                                          const UpdateShowIdenticalEntries(
                                              true));
                                    },
                                    child: const Text('Show'),
                                  ),
                                ],
                              ),
                            ),

                          // Result count header when search is active
                          if (_searchQuery.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8),
                              child: Text(
                                'Showing ${diffEntries.length} of $totalBeforeSearch entries',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: theme.colorScheme.onSurface
                                      .withAlpha(150),
                                ),
                              ),
                            ),
                          Expanded(
                            child: Scrollbar(
                              controller: _scrollController,
                              thumbVisibility: true,
                              child: ListView.builder(
                                controller: _scrollController,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                itemCount: diffEntries.length,
                                itemBuilder: (context, index) {
                                  final entry = diffEntries[index];
                                  final key = entry.key;
                                  final statusDetail = entry.value;
                                  final status = statusDetail.status;
                                  final value1 = state.result.file1Data[key];
                                  final value2 = state.result.file2Data[key];

                                  final lineNumber =
                                      (index + 1).toString().padLeft(3, '0');

                                  // Get font family from settings
                                  final lineSettingsState =
                                      context.watch<SettingsBloc>().state;
                                  String lineFontFamily =
                                      'Consolas, Monaco, monospace';
                                  double lineFontSize = 12.0;
                                  if (lineSettingsState.status ==
                                      SettingsStatus.loaded) {
                                    try {
                                      final ff = lineSettingsState
                                          .appSettings.diffFontFamily;
                                      if (ff.isNotEmpty &&
                                          ff != 'System Default')
                                        lineFontFamily = ff;
                                      lineFontSize = lineSettingsState
                                          .appSettings.diffFontSize;
                                    } catch (_) {}
                                  }

                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 48,
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 4, 8, 4),
                                        child: Text(
                                          lineNumber,
                                          style: TextStyle(
                                            color: theme.colorScheme.outline,
                                            fontFamily: lineFontFamily,
                                            fontSize: lineFontSize,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildDiffListItem(
                                          key: key,
                                          status: status,
                                          value1: value1,
                                          value2: value2,
                                          isAmoled: isAmoled,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  } else if (state is ComparisonFailure) {
                    content = Center(
                        key: const ValueKey('failure'),
                        child: Text('Comparison Failed: ${state.error}',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error)));
                  } else {
                    content = _buildEmptyState(context, isAmoled);
                  }

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: content,
                  );
                },
              ),
            ),
          ],
        ),
      ),
        ),
      ),
    );
  }

  Future<void> _exportResult() async {
    if (_latestComparisonResult == null) return;

    final settings = context.read<SettingsBloc>().state.appSettings;
    final format = settings.defaultExportFormat;

    if (format == 'Excel') {
      await _exportToExcel();
    } else if (format == 'JSON') {
      await _exportToJson();
    } else {
      await _exportToCsv();
    }
  }

  Future<void> _exportToExcel() async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Header
    sheetObject.appendRow([
      TextCellValue('Status'),
      TextCellValue('String Key'),
      TextCellValue('Old Value (Source)'),
      TextCellValue('New Value (Target)'),
      TextCellValue('Similarity')
    ]);

    for (var entry in _latestComparisonResult!.diff.entries) {
      final key = entry.key;
      final status = entry.value.status;
      final similarity = entry.value.similarity;
      final file1Value = _latestComparisonResult!.file1Data[key] ?? '';
      final file2Value = _latestComparisonResult!.file2Data[key] ?? '';

      String statusText = status == StringComparisonStatus.added
          ? 'EXTRA'
          : status == StringComparisonStatus.removed
              ? 'MISSING'
              : 'CHANGED';
      String simText =
          similarity != null ? '${(similarity * 100).toStringAsFixed(1)}%' : '';

      sheetObject.appendRow([
        TextCellValue(statusText),
        TextCellValue(key),
        TextCellValue(status == StringComparisonStatus.added ? '' : file1Value),
        TextCellValue(
            status == StringComparisonStatus.removed ? '' : file2Value),
        TextCellValue(simText)
      ]);
    }

    // Save
    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Excel Report',
      fileName: 'comparison_report.xlsx',
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (outputPath != null) {
      try {
        final settings = context.read<SettingsBloc>().state.appSettings;
        await BackupService().createBackupIfNeeded(
          targetPath: outputPath,
          settings: settings,
        );
        var fileBytes = excel.save();
        if (fileBytes != null) {
          File(outputPath)
            ..createSync(recursive: true)
            ..writeAsBytesSync(fileBytes);

          if (mounted) {
            if (settings.openFolderAfterExport && Platform.isWindows) {
              Process.run('explorer.exe', [File(outputPath).parent.path]);
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Excel saved to: $outputPath'),
                  behavior: SnackBarBehavior.floating),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to save Excel: $e'),
                backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  Future<void> _exportToJson() async {
    List<Map<String, dynamic>> jsonData = [];
    for (var entry in _latestComparisonResult!.diff.entries) {
      final key = entry.key;
      final status = entry.value.status;
      final similarity = entry.value.similarity;
      final file1Value = _latestComparisonResult!.file1Data[key] ?? '';
      final file2Value = _latestComparisonResult!.file2Data[key] ?? '';

      jsonData.add({
        'status': status == StringComparisonStatus.added
            ? 'extra'
            : status == StringComparisonStatus.removed
                ? 'missing'
                : status.name,
        'key': key,
        'old_value': status == StringComparisonStatus.added ? null : file1Value,
        'new_value':
            status == StringComparisonStatus.removed ? null : file2Value,
        'similarity': similarity
      });
    }

    String jsonString = const JsonEncoder.withIndent('  ').convert(jsonData);

    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save JSON Report',
      fileName: 'comparison_report.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (outputPath != null) {
      try {
        final settings = context.read<SettingsBloc>().state.appSettings;
        await BackupService().createBackupIfNeeded(
          targetPath: outputPath,
          settings: settings,
        );
        await File(outputPath).writeAsString(jsonString);
        if (mounted) {
          if (settings.openFolderAfterExport && Platform.isWindows) {
            Process.run('explorer.exe', [File(outputPath).parent.path]);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('JSON saved to: $outputPath'),
                behavior: SnackBarBehavior.floating),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to save JSON: $e'),
                backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  Future<void> _exportToCsv() async {
    List<List<dynamic>> csvData = [
      [
        'Status',
        'String Key',
        'Old Value (Source)',
        'New Value (Target)',
        'Similarity'
      ]
    ];
    for (var entry in _latestComparisonResult!.diff.entries) {
      final key = entry.key;
      final status = entry.value.status;
      final similarity = entry.value.similarity;
      final file1Value = _latestComparisonResult!.file1Data[key] ?? '';
      final file2Value = _latestComparisonResult!.file2Data[key] ?? '';

      String statusText = status == StringComparisonStatus.added
          ? 'EXTRA'
          : status == StringComparisonStatus.removed
              ? 'MISSING'
              : 'CHANGED';
      String simText =
          similarity != null ? '${(similarity * 100).toStringAsFixed(1)}%' : '';

      csvData.add([
        statusText,
        key,
        status == StringComparisonStatus.added ? '' : file1Value,
        status == StringComparisonStatus.removed ? '' : file2Value,
        simText
      ]);
    }

    String csvString = const ListToCsvConverter().convert(csvData);

    final settings = context.read<SettingsBloc>().state.appSettings;
    if (settings.includeUtf8Bom) {
      csvString = '\uFEFF$csvString';
    }

    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save CSV Report',
      fileName: 'comparison_report.csv',
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (outputPath != null) {
      try {
        await BackupService().createBackupIfNeeded(
          targetPath: outputPath,
          settings: settings,
        );
        await File(outputPath).writeAsString(csvString);
        if (mounted) {
          if (settings.openFolderAfterExport && Platform.isWindows) {
            Process.run('explorer.exe', [File(outputPath).parent.path]);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('CSV saved to: $outputPath'),
                behavior: SnackBarBehavior.floating),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to save CSV: $e'),
                backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  Widget _buildFilePicker({
    required BuildContext context,
    required String title,
    required File? file,
    required int fileNumber,
    required VoidCallback onPressed,
    required bool isDraggingOver,
    required bool isAmoled,
  }) {
    final theme = Theme.of(context);
    // isDarkMode is implicit in theme.brightness
    final hasFile = file != null;

    // Abbreviated path display for long paths
    String displayText;
    String tooltipPath = '';
    String? fileExtension;

    if (hasFile) {
      tooltipPath = file.path;
      final parts = file.path.split(Platform.isWindows ? '\\' : '/');
      final fileName = parts.last;
      fileExtension = fileName.contains('.')
          ? fileName.split('.').last.toUpperCase()
          : null;

      // Abbreviate long paths: show .../<parent>/<filename>
      if (parts.length > 2 && file.path.length > 40) {
        displayText = '.../${parts[parts.length - 2]}/$fileName';
      } else {
        displayText = fileName;
      }
    } else {
      displayText =
          isDraggingOver ? 'Drop file here' : 'Drop file or click to browse';
    }

    Color borderColor = isDraggingOver
        ? theme.colorScheme.primary
        : (hasFile
            ? theme.colorScheme.primary.withValues(alpha: 0.3)
            : theme.dividerColor);
    Color backgroundColor = isDraggingOver
        ? theme.colorScheme.primary.withValues(alpha: 0.08)
        : (isAmoled
            ? (hasFile ? Colors.grey[900]! : Colors.transparent)
            : (hasFile
                ? theme.colorScheme.primary.withValues(alpha: 0.04)
                : theme.cardColor.withValues(alpha: 0.5)));

    // Active state (file loaded): compact inline layout ~44px
    // Idle state (empty): slightly larger ~70px for easy drop
    final double verticalPadding = hasFile ? 10.0 : 16.0;
    final double horizontalPadding = 14.0;

    return Expanded(
      child: DropTarget(
        onDragDone: (details) => _onFileDropped(details.files, fileNumber),
        onDragEntered: (details) {
          setState(() {
            if (fileNumber == 1) {
              _isDraggingOverFile1 = true;
            } else if (fileNumber == 2) {
              _isDraggingOverFile2 = true;
            } else {
              _isDraggingOverBilingualFile = true;
            }
          });
        },
        onDragExited: (details) {
          setState(() {
            if (fileNumber == 1) {
              _isDraggingOverFile1 = false;
            } else if (fileNumber == 2) {
              _isDraggingOverFile2 = false;
            } else {
              _isDraggingOverBilingualFile = false;
            }
          });
        },
        child: GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: borderColor,
                width: isDraggingOver ? 2.0 : 1.0,
              ),
            ),
            child: Row(
              children: [
                // Icon
                Icon(
                  hasFile
                      ? Icons.description_rounded
                      : Icons.cloud_upload_outlined,
                  color: isDraggingOver
                      ? theme.colorScheme.primary
                      : (hasFile
                          ? theme.colorScheme.primary
                          : theme.colorScheme.primary.withValues(alpha: 0.5)),
                  size: hasFile ? 20 : 24,
                ),
                const SizedBox(width: 12),
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title label (small, muted)
                      Text(
                        title,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.5),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      // Filename or placeholder
                      Tooltip(
                        message: hasFile ? tooltipPath : '',
                        waitDuration: const Duration(milliseconds: 400),
                        child: Text(
                          displayText,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight:
                                hasFile ? FontWeight.w600 : FontWeight.w400,
                            color: hasFile
                                ? theme.colorScheme.onSurface
                                : theme.colorScheme.onSurface
                                    .withValues(alpha: 0.6),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                // File extension badge (when file is loaded)
                if (hasFile && fileExtension != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      fileExtension,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
                // Change button (when file is loaded)
                if (hasFile) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.swap_horiz_rounded,
                    size: 18,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsAndActionsBar() {
    final settingsState = context.watch<SettingsBloc>().state;
    final themeState = context.watch<ThemeBloc>().state;
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final bool isAmoled = isDarkMode &&
        settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    int totalKeys = 0;
    int addedCount = 0;
    int removedCount = 0;
    int modifiedCount = 0;

    if (_latestComparisonResult != null) {
      final allKeys = Set<String>.from(_latestComparisonResult!.file1Data.keys);
      allKeys.addAll(_latestComparisonResult!.file2Data.keys);
      totalKeys = allKeys.length;
      _latestComparisonResult!.diff.forEach((key, statusDetail) {
        switch (statusDetail.status) {
          case StringComparisonStatus.added:
            addedCount++;
            break;
          case StringComparisonStatus.removed:
            removedCount++;
            break;
          case StringComparisonStatus.modified:
            modifiedCount++;
            break;
          default:
            break;
        }
      });
    }

    final Color cardBg =
        isAmoled ? Colors.black : (theme.cardTheme.color ?? theme.cardColor);
    final Color borderColor = isAmoled ? Colors.grey[850]! : theme.dividerColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          // Stats Section
          Expanded(
            flex: 3,
            child: Row(
              children: [
                _buildStatsChart(
                    addedCount, removedCount, modifiedCount, themeState),
                const SizedBox(width: 16),
                _buildCompactStat('Total', totalKeys,
                    theme.colorScheme.onSurface.withAlpha(180)),
                const SizedBox(width: 16),
                _buildCompactStat(
                    '+${addedCount}', null, themeState.diffAddedColor),
                const SizedBox(width: 12),
                _buildCompactStat(
                    '-${removedCount}', null, themeState.diffRemovedColor),
                const SizedBox(width: 12),
                _buildCompactStat(
                    '~${modifiedCount}', null, themeState.diffModifiedColor),
              // File watcher removed (moved to settings)
              ],
            ),
          ),

          // Search Field
          Container(
            width: 320,
            height: 32,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              style: TextStyle(
                fontSize: 13,
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: 'Search keys or values...',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withAlpha(100),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 18,
                  color: theme.colorScheme.onSurface.withAlpha(120),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          size: 16,
                          color: theme.colorScheme.onSurface.withAlpha(120),
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: theme.colorScheme.primary, width: 1.5),
                ),
                filled: true,
                fillColor: isAmoled
                    ? Colors.grey[900]
                    : (isDarkMode ? const Color(0xFF252530) : Colors.grey[50]),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          
          // Search Toggles
          _buildSearchToggle(
            'Regex', 
            '.*', 
            _isRegexEnabled, 
            (val) => setState(() {
              _isRegexEnabled = val;
              if (val) _isFuzzyEnabled = false;
            }),
            theme
          ),
          const SizedBox(width: 4),
          _buildSearchToggle(
            'Fuzzy', 
            '~', 
            _isFuzzyEnabled, 
            (val) => setState(() {
              _isFuzzyEnabled = val;
              if (val) _isRegexEnabled = false;
            }),
            theme
          ),
          const SizedBox(width: 8),

          // Filter Toggle Buttons (icon-only to prevent overflow)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFilterIconButton(
                  BasicDiffFilter.added,
                  Icons.add_circle_outline,
                  context.watch<ThemeBloc>().state.diffAddedColor,
                  'Show Extra',
                ),
                _buildFilterIconButton(
                  BasicDiffFilter.removed,
                  Icons.remove_circle_outline,
                  context.watch<ThemeBloc>().state.diffRemovedColor,
                  'Show Missing',
                ),
                _buildFilterIconButton(
                  BasicDiffFilter.modified,
                  Icons.edit_outlined,
                  context.watch<ThemeBloc>().state.diffModifiedColor,
                  'Show Changed',
                ),
                _buildFilterIconButton(
                  BasicDiffFilter.problems,
                  Icons.warning_amber_rounded,
                  Colors.orange,
                  'Show Problems',
                ),
                const SizedBox(width: 8),
                // Toggle Identical Logic
                IconButton(
                  icon: Icon(
                    settingsState.appSettings.showIdenticalEntries
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: settingsState.appSettings.showIdenticalEntries
                        ? theme.colorScheme.onSurface.withAlpha(180)
                        : theme.colorScheme.onSurface.withAlpha(100),
                    size: 20,
                  ),
                  tooltip: settingsState.appSettings.showIdenticalEntries
                      ? 'Hide identical entries'
                      : 'Show identical entries',
                  onPressed: () {
                    context.read<SettingsBloc>().add(UpdateShowIdenticalEntries(
                        !settingsState.appSettings.showIdenticalEntries));
                  },
                ),
                _buildFilterIconButton(
                  BasicDiffFilter.all,
                  Icons.filter_list_off,
                  theme.colorScheme.onSurface.withAlpha(150),
                  'Show All',
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 28,
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: borderColor,
          ),

          // Action Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCompactActionButton(
                icon: Icons.download_outlined,
                label: 'Export',
                onPressed: _exportResult,
                color: theme.colorScheme.onSurface,
              ),
              const SizedBox(width: 8),
              _buildCompactActionButton(
                icon: Icons.zoom_in_map,
                label: 'Advanced',
                onPressed: _navigateToAdvancedView,
                color: theme.colorScheme.primary,
              ),
              // AI button moved to Advanced view
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchToggle(String tooltip, String label, bool value, Function(bool) onChanged, ThemeData theme) {
    // Determine active color
    final isActive = value;
    final activeColor = theme.colorScheme.primary;
    final inactiveColor = theme.colorScheme.onSurface.withValues(alpha: 0.5);

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: isActive ? activeColor.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isActive ? activeColor : Colors.transparent,
            )
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsChart(
      int added, int removed, int modified, AppThemeState themeState) {
    final total = added + removed + modified;
    if (total == 0) return const SizedBox.shrink();

    return SizedBox(
      width: 40,
      height: 40,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: added.toDouble(),
              color: themeState.diffAddedColor,
              radius: 6,
              showTitle: false,
            ),
            PieChartSectionData(
              value: removed.toDouble(),
              color: themeState.diffRemovedColor,
              radius: 6,
              showTitle: false,
            ),
            PieChartSectionData(
              value: modified.toDouble(),
              color: themeState.diffModifiedColor,
              radius: 6,
              showTitle: false,
            ),
          ],
          sectionsSpace: 2,
          centerSpaceRadius: 10,
          startDegreeOffset: 270,
        ),
      ),
    );
  }

  Widget _buildCompactStat(String label, int? value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value != null ? '$label: $value' : label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterIconButton(
    BasicDiffFilter filter,
    IconData icon,
    Color color,
    String tooltip,
  ) {
    final bool isActive = _currentFilter == filter;
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => setState(() => _currentFilter = filter),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isActive
                ? color.withAlpha(isDark ? 50 : 30)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isActive
                ? Border.all(
                    color: color.withAlpha(isDark ? 150 : 100), width: 1.5)
                : null,
          ),
          child: Icon(
            icon,
            size: 18,
            color: isActive ? color : color.withAlpha(isDark ? 120 : 150),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 13)),
      style: TextButton.styleFrom(
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildFileWatcherStatus(
      SettingsState settingsState, bool isAmoled, bool isDarkMode) {
    final isAutoReloadEnabled = settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.autoReloadOnChange;

    return BlocBuilder<FileWatcherBloc, FileWatcherState>(
      builder: (context, watcherState) {
        final isWatching =
            watcherState is FileWatcherActive && watcherState.isEnabled;

        return Tooltip(
          message:
              'File Watching: ${isWatching ? "ON" : "OFF"}\nAutomatically recompare when files change on disk',
          waitDuration: const Duration(milliseconds: 500),
          child: InputChip(
            avatar: isWatching
                ? const _PulsingIndicator()
                : Icon(
                    Icons.visibility_off,
                    size: 16,
                    color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                  ),
            label: Text(
              isWatching ? 'Watching' : 'Watch Off',
              style: TextStyle(
                fontSize: 12,
                fontWeight: isWatching ? FontWeight.bold : FontWeight.normal,
                color: isWatching
                    ? (isDarkMode ? Colors.green[400] : Colors.green[800])
                    : (isDarkMode ? Colors.grey[400] : Colors.grey[700]),
              ),
            ),
            selected: isAutoReloadEnabled,
            showCheckmark: false,
            onSelected: (value) => _toggleFileWatching(value),
            backgroundColor: Colors.transparent,
            selectedColor: isDarkMode
                ? Colors.green.withValues(alpha: 0.15)
                : Colors.green.withValues(alpha: 0.1),
            side: BorderSide(
              color: isWatching
                  ? (isDarkMode ? Colors.green[700]! : Colors.green[600]!)
                  : (isDarkMode ? Colors.grey[800]! : Colors.grey[300]!),
            ),
            padding: const EdgeInsets.all(0),
            visualDensity: VisualDensity.compact,
          ),
        );
      },
    );
  }

  Widget _buildDiffListItem({
    required String key,
    required StringComparisonStatus status,
    String? value1,
    String? value2,
    required bool isAmoled,
  }) {
    final themeState = context.watch<ThemeBloc>().state;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Status-based colors and labels
    Color statusColor;
    Color bgColor;
    String statusLabel;

    switch (status) {
      case StringComparisonStatus.added:
        statusColor = themeState.diffAddedColor;
        bgColor = statusColor.withAlpha(isDark ? 15 : 10);
        statusLabel = 'EXTRA';
        break;
      case StringComparisonStatus.removed:
        statusColor = themeState.diffRemovedColor;
        bgColor = statusColor.withAlpha(isDark ? 15 : 10);
        statusLabel = 'MISSING';
        break;
      case StringComparisonStatus.modified:
        statusColor = themeState.diffModifiedColor;
        bgColor = statusColor.withAlpha(isDark ? 15 : 10);
        statusLabel = 'CHANGED';
        break;
      case StringComparisonStatus.identical:
        statusColor = isDark ? Colors.grey[600]! : Colors.grey[400]!;
        bgColor = Colors.transparent;
        statusLabel = 'IDENTICAL';
    }

    final borderColor = isAmoled
        ? Colors.grey[850]!
        : (isDark ? const Color(0xFF2E2E38) : Colors.grey[200]!);
    final textMuted = isDark ? Colors.grey[500]! : Colors.grey[500]!;

    final settingsState = context.watch<SettingsBloc>().state;
    // Get font family from settings, with safe fallback for old data
    String fontFamily;
    try {
      fontFamily = settingsState.status == SettingsStatus.loaded
          ? settingsState.appSettings.diffFontFamily
          : 'System Default';
      if (fontFamily.isEmpty) fontFamily = 'System Default';
    } catch (_) {
      fontFamily = 'System Default';
    }
    // Map font family name to actual font family string
    final String actualFontFamily = fontFamily == 'System Default'
        ? 'Consolas, Monaco, monospace'
        : fontFamily;

    // Monospace text style for values
    final monoStyle = TextStyle(
      fontFamily: actualFontFamily,
      fontSize: settingsState.status == SettingsStatus.loaded
          ? settingsState.appSettings.diffFontSize
          : 14.0,
      height: 1.4,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor.withAlpha(isDark ? 60 : 80)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status indicator bar (thin 3px)
            Container(
              width: 3,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Key row with compact status chip
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            key,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Compact status chip (just dot + label)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(isDark ? 35 : 25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                statusLabel,
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Values section - different layouts based on status
                    if (status == StringComparisonStatus.modified) ...[
                      // Side-by-side layout for modified items
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Source (left column)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: themeState.diffRemovedColor
                                    .withAlpha(isDark ? 20 : 15),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: themeState.diffRemovedColor
                                      .withAlpha(isDark ? 40 : 30),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Source',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: textMuted,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    value1 ?? '--',
                                    style: monoStyle.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withAlpha(220),
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: themeState
                                          .diffRemovedColor
                                          .withAlpha(150),
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Arrow indicator
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: 14,
                              color: textMuted,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Target (right column)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: themeState.diffAddedColor
                                    .withAlpha(isDark ? 20 : 15),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: themeState.diffAddedColor
                                      .withAlpha(isDark ? 40 : 30),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Target',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: textMuted,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    value2 ?? '--',
                                    style: monoStyle.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withAlpha(220),
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else if (status == StringComparisonStatus.removed) ...[
                      // Single row for removed items
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Source: ',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: textMuted,
                                  fontWeight: FontWeight.w500)),
                          Expanded(
                            child: Text(
                              value1 ?? '--',
                              style: monoStyle.copyWith(
                                color: statusColor.withAlpha(220),
                                decoration: TextDecoration.lineThrough,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ] else if (status == StringComparisonStatus.added) ...[
                      // Single row for added items
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Value: ',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: textMuted,
                                  fontWeight: FontWeight.w500)),
                          Expanded(
                            child: Text(
                              value2 ?? '--',
                              style: monoStyle.copyWith(
                                color: statusColor.withAlpha(220),
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      // Single row for identical items
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Value: ',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: textMuted,
                                  fontWeight: FontWeight.w500)),
                          Expanded(
                            child: Text(
                              value1 ?? '--',
                              style: monoStyle.copyWith(
                                color:
                                    theme.colorScheme.onSurface.withAlpha(180),
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isAmoled) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final textSecondary = isDark ? Colors.grey[400]! : Colors.grey[600]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: const _AnimatedEmptyStateIcon(),
              ),
              const SizedBox(height: 24),
              // Headline
              Text(
                'Ready to Compare Files',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              // Description
              Text(
                'Drop localization files above or use the browse buttons\nto select files for comparison.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              // Supported formats
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children:
                    ['.lang', '.json', '.xml', '.xliff', '.properties', '.yaml']
                        .map((ext) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary
                                    .withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: theme.colorScheme.primary
                                      .withValues(alpha: 0.15),
                                ),
                              ),
                              child: Text(
                                ext,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: theme.colorScheme.primary,
                                  fontFamily: 'Consolas, Monaco, monospace',
                                ),
                              ),
                            ))
                        .toList(),
              ),
              const SizedBox(height: 32),
              // Quick Tutorial Link
              TextButton.icon(
                onPressed: () => _showQuickTutorialDialog(context),
                icon: Icon(Icons.lightbulb_outline,
                    size: 18, color: theme.colorScheme.secondary),
                label: Text(
                  'Quick Tutorial',
                  style: TextStyle(color: theme.colorScheme.secondary),
                ),
              ),
              const SizedBox(height: 24),
              // Recent Comparisons Section
              BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, historyState) {
                  if (historyState is HistoryLoaded &&
                      historyState.history.isNotEmpty) {
                    final recentItems = historyState.history.take(5).toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                            color: theme.dividerColor.withValues(alpha: 0.5)),
                        const SizedBox(height: 12),
                        Text(
                          'Recent Comparisons',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...recentItems.map((session) =>
                            _buildRecentComparisonItem(
                                context, session, theme, textSecondary)),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentComparisonItem(BuildContext context,
      ComparisonSession session, ThemeData theme, Color textSecondary) {
    final sourceName = session.file1Path.split(Platform.pathSeparator).last;
    final targetName = session.file2Path.split(Platform.pathSeparator).last;
    final isBilingualSession = session.file1Path == session.file2Path;
    final title = isBilingualSession
        ? 'Bilingual file: $sourceName'
        : '$sourceName ↔ $targetName';

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.history,
          color: theme.colorScheme.primary.withValues(alpha: 0.7)),
      title: Text(
        title,
        style:
            theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        _timeAgo(session.timestamp),
        style: theme.textTheme.bodySmall?.copyWith(color: textSecondary),
      ),
      onTap: () => _loadRecentComparison(session),
    );
  }

  void _loadRecentComparison(ComparisonSession session) {
    final file1 = File(session.file1Path);
    final file2 = File(session.file2Path);
    final isBilingualSession = session.file1Path == session.file2Path;

    final shouldCheckBoth = !isBilingualSession;
    if (!file1.existsSync() || (shouldCheckBoth && !file2.existsSync())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('One or both files from this session no longer exist.')),
      );
      return;
    }

    setState(() {
      _isBilingualMode = isBilingualSession;
      if (isBilingualSession) {
        _bilingualFile = file1;
      } else {
        _file1 = file1;
        _file2 = file2;
      }
    });
    _startComparison();
  }

  String _timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  void _showQuickTutorialDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.lightbulb, color: theme.colorScheme.secondary),
            const SizedBox(width: 8),
            const Text('Quick Tutorial'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '1. Drag & drop two files, or use Bilingual Mode for a single file with both languages.'),
            SizedBox(height: 8),
            Text('2. Click Compare to see the differences.'),
            SizedBox(height: 8),
            Text('3. Use filters to focus on Extra, Missing, or Changed keys.'),
            SizedBox(height: 8),
            Text('4. Enable File Watching to auto-recompare on file changes.'),
            SizedBox(height: 8),
            Text('5. Use "Advanced" view for detailed diff analysis.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}

class _PulsingIndicator extends StatefulWidget {
  const _PulsingIndicator();

  @override
  State<_PulsingIndicator> createState() => _PulsingIndicatorState();
}

class _PulsingIndicatorState extends State<_PulsingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FadeTransition(
      opacity: _animation,
      child: Icon(
        Icons.visibility,
        size: 16,
        color: isDark ? Colors.green[400] : Colors.green[700],
      ),
    );
  }
}

class _AnimatedEmptyStateIcon extends StatefulWidget {
  const _AnimatedEmptyStateIcon();

  @override
  State<_AnimatedEmptyStateIcon> createState() =>
      _AnimatedEmptyStateIconState();
}

class _AnimatedEmptyStateIconState extends State<_AnimatedEmptyStateIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _rotationAnimation =
        Tween<double>(begin: -0.05, end: 0.05).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation =
        Tween<double>(begin: 0.95, end: 1.05).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(
              Icons.compare_arrows_rounded,
              size: 48,
              color: theme.colorScheme.primary.withValues(alpha: 0.7),
            ),
          ),
        );
      },
    );
  }
}
