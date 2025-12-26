import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:desktop_drop/desktop_drop.dart';
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

// Enum for filter status in Basic View
enum BasicDiffFilter { all, added, removed, modified }

class BasicComparisonView extends StatefulWidget {
  final Function(int)? onNavigateToTab;

  const BasicComparisonView({
    super.key,
    this.onNavigateToTab,
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
        const SnackBar(content: Text('Navigation to AI Settings not available')),
      );
    }
  }
  File? _file1;
  File? _file2;
  // Store the latest comparison results for the analytics bar
  ComparisonResult? _latestComparisonResult;
  BasicDiffFilter _currentFilter = BasicDiffFilter.all;
  
  // Drag & drop state
  bool _isDraggingOverFile1 = false;
  bool _isDraggingOverFile2 = false;

  // Search/filter state
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _pickFile(int fileNumber) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        if (fileNumber == 1) {
          _file1 = File(result.files.single.path!);
        } else {
          _file2 = File(result.files.single.path!);
        }
      });
      
      // Update file watcher when files change
      _updateFileWatcher();
    }
  }

  void _toggleFileWatching(bool enabled) {
    context.read<SettingsBloc>().add(UpdateAutoReloadOnChange(enabled));
  }

  void _startComparison() {
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

  void _updateFileWatcher() {
    final settingsState = context.read<SettingsBloc>().state;
    final isAutoReloadEnabled = settingsState.status == SettingsStatus.loaded &&
                                settingsState.appSettings.autoReloadOnChange;

    if (isAutoReloadEnabled && _file1 != null && _file2 != null) {
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
          } else {
            _file2 = file;
          }
        });
        
        // Update file watcher when files change
        _updateFileWatcher();
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File ${fileNumber == 1 ? "1" : "2"} selected: ${file.path.split(Platform.pathSeparator).last}'),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        // Show error for invalid file type
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid file type. Please select a supported localization file.'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  bool _isValidFileType(String filePath) {
    final extension = filePath.toLowerCase().split('.').last;
    const supportedExtensions = [
      'json', 'xml', 'xliff', 'xlf', 'tmx', 'csv', 'yaml', 'yml', 
      'properties', 'resx', 'txt', 'docx', 'lang'
    ];
    return supportedExtensions.contains(extension);
  }

  void _navigateToAdvancedView() {
    if (_latestComparisonResult != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdvancedDiffView(comparisonResult: _latestComparisonResult!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please perform a comparison first to see advanced details.')),
      );
    }
  }



  Color _getColorForStatus(BuildContext context, StringComparisonStatus status) {
    // Get colors from the theme, which is updated by ThemeBloc
    final themeState = context.watch<ThemeBloc>().state;
    switch (status) {
      case StringComparisonStatus.added:
        return themeState.diffAddedColor.withOpacity(0.2);
      case StringComparisonStatus.removed:
        return themeState.diffRemovedColor.withOpacity(0.2);
      case StringComparisonStatus.modified:
        return themeState.diffModifiedColor.withOpacity(0.2);
      case StringComparisonStatus.identical:
      default:
        return Colors.transparent;
    }
  }

 @override
  Widget build(BuildContext context) {
    // Determine if Amoled mode is active
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = settingsState.status == SettingsStatus.loaded &&
                        Theme.of(context).brightness == Brightness.dark &&
                        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    return MultiBlocListener(
      listeners: [
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
                context.read<ComparisonBloc>().add(
                  CompareFilesRequested(
                    file1: File(state.file1Path),
                    file2: File(state.file2Path),
                    settings: settingsStateForReload.appSettings,
                  ),
                );
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
                color: isAmoled ? Colors.grey[850]! : Theme.of(context).dividerColor.withOpacity(0.5),
              ),
            ),
            margin: const EdgeInsets.only(bottom: 12.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
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
                      ),
                      const SizedBox(width: 12),
                      _buildFilePicker(
                        context: context,
                        title: 'Target File',
                        file: _file2,
                        fileNumber: 2,
                        onPressed: () => _pickFile(2),
                        isDraggingOver: _isDraggingOverFile2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.compare_arrows, size: 18),
                      label: const Text('Compare Files'),
                      onPressed: (_file1 != null && _file2 != null) ? _startComparison : null,
                    ),
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
                double progress = state.total > 0 ? state.current / state.total : 0.0;
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
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Text('Error during processing: ${state.error}', style: const TextStyle(color: Colors.red))
                  );
              }
              return const SizedBox.shrink();
            },
          ),
          Expanded(
            child: BlocConsumer<ComparisonBloc, ComparisonState>(
              listener: (context, state) {
                 if (state is ComparisonSuccess) {
                    // Update file references in the UI
                    setState(() {
                      _file1 = state.file1;
                      _file2 = state.file2;
                      _latestComparisonResult = state.result;
                    });

                    // Only add to history if it wasn't loaded from history
                    if (!state.wasLoadedFromHistory) {
                      final result = state.result;
                      int added = 0, removed = 0, modified = 0, identical = 0;
                      result.diff.forEach((key, statusDetail) {
                          switch (statusDetail.status) {
                              case StringComparisonStatus.added: added++; break;
                              case StringComparisonStatus.removed: removed++; break;
                              case StringComparisonStatus.modified: modified++; break;
                              case StringComparisonStatus.identical: identical++; break;
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
                        SnackBar(content: Text('Comparison failed: ${state.error}')),
                      );
                 }
              },
              builder: (context, state) {
                final theme = Theme.of(context);
                if (state is ComparisonLoading) {
                  return const Center(child: Text('Comparison in progress...'));
                }
                if (state is ComparisonSuccess) {
                  var diffEntries = state.result.diff.entries.toList();

                  // Apply filter
                  if (_currentFilter != BasicDiffFilter.all) {
                    diffEntries = diffEntries.where((entry) {
                      switch (_currentFilter) {
                        case BasicDiffFilter.added:
                          return entry.value.status == StringComparisonStatus.added;
                        case BasicDiffFilter.removed:
                          return entry.value.status == StringComparisonStatus.removed;
                        case BasicDiffFilter.modified:
                           return entry.value.status == StringComparisonStatus.modified;
                        default:
                          return true;
                      }
                    }).toList();
                  }

                  // Hide identical entries if setting is disabled and we are in 'All' filter
                  final showIdentical = settingsState.appSettings.showIdenticalEntries;
                  int hiddenIdenticalCount = 0;
                  if (!showIdentical && _currentFilter == BasicDiffFilter.all) {
                    final identicals = diffEntries.where((entry) => entry.value.status == StringComparisonStatus.identical).toList();
                    hiddenIdenticalCount = identicals.length;
                    if (hiddenIdenticalCount > 0) {
                       diffEntries = diffEntries.where((entry) => entry.value.status != StringComparisonStatus.identical).toList();
                    }
                  }

                  // Apply text search filter
                  final int totalBeforeSearch = diffEntries.length;
                  if (_searchQuery.isNotEmpty) {
                    final query = _searchQuery.toLowerCase();
                    diffEntries = diffEntries.where((entry) {
                      final key = entry.key.toLowerCase();
                      final value1 = (state.result.file1Data[entry.key] ?? '').toLowerCase();
                      final value2 = (state.result.file2Data[entry.key] ?? '').toLowerCase();
                      return key.contains(query) || value1.contains(query) || value2.contains(query);
                    }).toList();
                  }

                  if (diffEntries.isEmpty) {
                    if (_searchQuery.isNotEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search_off, size: 48, color: theme.colorScheme.onSurface.withAlpha(100)),
                            const SizedBox(height: 12),
                            Text(
                              'No matches found for "$_searchQuery"',
                              style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(150)),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Showing 0 of $totalBeforeSearch entries',
                              style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withAlpha(100)),
                            ),
                          ],
                        ),
                      );

                    }
                    if (_searchQuery.isEmpty && !state.result.diff.values.any((e) => e.status != StringComparisonStatus.identical)) {
                         return const Center(child: Text('Files are identical.'));
                    }
                     // If we hid everything (e.g. only identicals existed and we hid them), show that state
                    if (diffEntries.isEmpty && hiddenIdenticalCount > 0) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text('$hiddenIdenticalCount identical entries hidden', style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(150))),
                             const SizedBox(height: 8),
                             TextButton(
                               onPressed: () {
                                 context.read<SettingsBloc>().add(const UpdateShowIdenticalEntries(true));
                               },
                               child: const Text('Show Identical Entries'),
                             )
                          ],
                        );
                    }
                    return const Center(child: Text('No differences found based on keys.'));
                  }
                  
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hidden entries summary
                      if (hiddenIdenticalCount > 0)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.visibility_off_outlined, size: 16, color: theme.colorScheme.onSurfaceVariant),
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
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                   context.read<SettingsBloc>().add(const UpdateShowIdenticalEntries(true));
                                },
                                child: const Text('Show'),
                              ),
                            ],
                          ),
                        ),

                      // Result count header when search is active
                      if (_searchQuery.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                          child: Text(
                            'Showing ${diffEntries.length} of $totalBeforeSearch entries',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface.withAlpha(150),
                            ),
                          ),
                        ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: diffEntries.length,
                          itemBuilder: (context, index) {
                            final entry = diffEntries[index];
                            final key = entry.key;
                            final statusDetail = entry.value;
                            final status = statusDetail.status;
                            final value1 = state.result.file1Data[key];
                            final value2 = state.result.file2Data[key];

                            final lineNumber = (index + 1).toString().padLeft(3, '0');

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 48,
                                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  child: Text(
                                    lineNumber,
                                    style: TextStyle(
                                      color: theme.colorScheme.outline,
                                      fontFamily: 'monospace',
                                      fontSize: 12,
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
                    ],
                  );
                }
                if (state is ComparisonFailure) {
                  return Center(child: Text('Comparison Failed: ${state.error}', style: const TextStyle(color: Colors.red)));
                }
                return _buildEmptyState(context, isAmoled);
              },
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildFilePicker({
    required BuildContext context,
    required String title,
    required File? file,
    required int fileNumber,
    required VoidCallback onPressed,
    required bool isDraggingOver,
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
      fileExtension = fileName.contains('.') ? fileName.split('.').last.toUpperCase() : null;
      
      // Abbreviate long paths: show .../<parent>/<filename>
      if (parts.length > 2 && file.path.length > 40) {
        displayText = '.../${parts[parts.length - 2]}/$fileName';
      } else {
        displayText = fileName;
      }
    } else {
      displayText = isDraggingOver ? 'Drop file here' : 'Drop file or click to browse';
    }

    Color borderColor = isDraggingOver 
        ? theme.colorScheme.primary 
        : (hasFile ? theme.colorScheme.primary.withOpacity(0.3) : theme.dividerColor);
    Color backgroundColor = isDraggingOver 
        ? theme.colorScheme.primary.withOpacity(0.08) 
        : (hasFile 
            ? theme.colorScheme.primary.withOpacity(0.04) 
            : theme.cardColor.withOpacity(0.5));

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
            } else {
              _isDraggingOverFile2 = true;
            }
          });
        },
        onDragExited: (details) {
          setState(() {
            if (fileNumber == 1) {
              _isDraggingOverFile1 = false;
            } else {
              _isDraggingOverFile2 = false;
            }
          });
        },
        child: GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
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
                  hasFile ? Icons.description_rounded : Icons.cloud_upload_outlined,
                  color: isDraggingOver 
                      ? theme.colorScheme.primary
                      : (hasFile ? theme.colorScheme.primary : theme.colorScheme.primary.withOpacity(0.5)),
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
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
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
                            fontWeight: hasFile ? FontWeight.w600 : FontWeight.w400,
                            color: hasFile 
                                ? theme.colorScheme.onSurface 
                                : theme.colorScheme.onSurface.withOpacity(0.6),
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
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
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
                    color: theme.colorScheme.onSurface.withOpacity(0.4),
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

    final Color cardBg = isAmoled
        ? Colors.black
        : (isDarkMode ? const Color(0xFF1A1A22) : Colors.white);
    final Color borderColor = isAmoled
        ? Colors.grey[850]!
        : (isDarkMode ? const Color(0xFF2E2E38) : Colors.grey[200]!);

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
                _buildStatsChart(addedCount, removedCount, modifiedCount),
                const SizedBox(width: 16),
                _buildCompactStat('Total', totalKeys, theme.colorScheme.onSurface.withAlpha(180)),
                const SizedBox(width: 16),
                _buildCompactStat('+${addedCount}', null, const Color(0xFF22C55E)),
                const SizedBox(width: 12),
                _buildCompactStat('-${removedCount}', null, const Color(0xFFEF4444)),
                const SizedBox(width: 12),
                _buildCompactStat('~${modifiedCount}', null, const Color(0xFFF59E0B)),
                const SizedBox(width: 12),
                _buildFileWatcherStatus(settingsState, isAmoled, isDarkMode),
              ],
            ),
          ),

          // Search Field
          Container(
            width: 200,
            height: 32,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _searchController,
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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
                  borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
                ),
                filled: true,
                fillColor: isAmoled ? Colors.grey[900] : (isDarkMode ? const Color(0xFF252530) : Colors.grey[50]),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),

          // Filter Toggle Buttons (icon-only to prevent overflow)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFilterIconButton(
                  BasicDiffFilter.added,
                  Icons.add_circle_outline,
                  const Color(0xFF22C55E),
                  'Show Added',
                ),
                _buildFilterIconButton(
                  BasicDiffFilter.removed,
                  Icons.remove_circle_outline,
                  const Color(0xFFEF4444),
                  'Show Removed',
                ),
                _buildFilterIconButton(
                  BasicDiffFilter.modified,
                  Icons.edit_outlined,
                  const Color(0xFFF59E0B),
                  'Show Modified',
                ),
                const SizedBox(width: 8),
                // Toggle Identical Logic
                IconButton(
                  icon: Icon(
                    settingsState.appSettings.showIdenticalEntries ? Icons.visibility : Icons.visibility_off,
                    color: settingsState.appSettings.showIdenticalEntries 
                        ? theme.colorScheme.onSurface.withAlpha(180) 
                        : theme.colorScheme.onSurface.withAlpha(100),
                    size: 20,
                  ),
                  tooltip: settingsState.appSettings.showIdenticalEntries ? 'Hide identical entries' : 'Show identical entries',
                  onPressed: () {
                    context.read<SettingsBloc>().add(UpdateShowIdenticalEntries(!settingsState.appSettings.showIdenticalEntries));
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
                icon: Icons.zoom_in_map,
                label: 'Advanced',
                onPressed: _navigateToAdvancedView,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              _buildCompactActionButton(
                icon: Icons.psychology_outlined,
                label: 'AI',
                onPressed: _navigateToAiSettings,
                color: theme.colorScheme.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsChart(int added, int removed, int modified) {
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
              color: const Color(0xFF22C55E),
              radius: 6,
              showTitle: false,
            ),
            PieChartSectionData(
              value: removed.toDouble(),
              color: const Color(0xFFEF4444),
              radius: 6,
              showTitle: false,
            ),
            PieChartSectionData(
              value: modified.toDouble(),
              color: const Color(0xFFF59E0B),
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
                ? Border.all(color: color.withAlpha(isDark ? 150 : 100), width: 1.5)
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

  Widget _buildFileWatcherStatus(SettingsState settingsState, bool isAmoled, bool isDarkMode) {
    final isAutoReloadEnabled = settingsState.status == SettingsStatus.loaded &&
                                settingsState.appSettings.autoReloadOnChange;
    
    // Check actual watcher status
    // Note: We're inside a method, not a BlocBuilder for the Chip content specifically,
    // so we rely on parent rebuilds or we need to wrap the Chip in BlocBuilder if we want 
    // real-time "active" status visualization beyond just the setting.
    // However, the toggle mainly controls the setting.
    
    return BlocBuilder<FileWatcherBloc, FileWatcherState>(
      builder: (context, watcherState) {
        final isWatching = watcherState is FileWatcherActive && watcherState.isEnabled;
        
        return InputChip(
          avatar: Icon(
            isWatching ? Icons.visibility : Icons.visibility_off,
            size: 16,
            color: isWatching 
                ? (isDarkMode ? Colors.green[400] : Colors.green[700])
                : (isDarkMode ? Colors.grey[500] : Colors.grey[600]),
          ),
          label: Text(isWatching ? 'Watching' : 'Watch Off'),
          selected: isAutoReloadEnabled,
          showCheckmark: false,
          onSelected: (value) => _toggleFileWatching(value),
          tooltip: 'Automatically recompare when files change on disk',
          backgroundColor: Colors.transparent,
          selectedColor: isDarkMode ? Colors.green.withOpacity(0.15) : Colors.green.withOpacity(0.1),
          side: BorderSide(
            color: isWatching
                ? (isDarkMode ? Colors.green[700]! : Colors.green[600]!)
                : (isDarkMode ? Colors.grey[800]! : Colors.grey[300]!),
          ),
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: isWatching ? FontWeight.bold : FontWeight.normal,
            color: isWatching
                ? (isDarkMode ? Colors.green[400] : Colors.green[800])
                : (isDarkMode ? Colors.grey[400] : Colors.grey[700]),
          ),
          padding: const EdgeInsets.all(0),
          visualDensity: VisualDensity.compact,
        );
      },
    );
  }

  Widget _buildAnalyticsItem(String label, String value, Color valueColor, {bool compact = false}) {
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = Theme.of(context).brightness == Brightness.dark &&
                        settingsState.status == SettingsStatus.loaded &&
                        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    final Color currentLabelColor = isAmoled 
        ? Colors.grey[500]! 
        : (Theme.of(context).textTheme.bodySmall?.color ?? Theme.of(context).colorScheme.onSurface.withOpacity(0.7));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: compact ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          label, 
          style: compact 
              ? Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11, color: currentLabelColor)
              : Theme.of(context).textTheme.bodySmall?.copyWith(color: currentLabelColor),
        ),
        SizedBox(height: compact ? 2 : 4),
        Text(
          value,
          style: TextStyle(
            fontSize: compact ? 20 : 24, 
            fontWeight: FontWeight.bold,
            color: valueColor, // Value colors (red, green, blueGrey) should be distinct enough or made slightly lighter for Amoled
          ),
        ),
      ],
    );
  }

  Widget _buildDiffListItem({
    required String key,
    required StringComparisonStatus status,
    String? value1,
    String? value2,
    required bool isAmoled,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Status-based colors and labels
    Color statusColor;
    Color bgColor;
    String statusLabel;

    switch (status) {
      case StringComparisonStatus.added:
        statusColor = const Color(0xFF22C55E);
        bgColor = statusColor.withAlpha(isDark ? 15 : 10);
        statusLabel = 'ADDED';
        break;
      case StringComparisonStatus.removed:
        statusColor = const Color(0xFFEF4444);
        bgColor = statusColor.withAlpha(isDark ? 15 : 10);
        statusLabel = 'REMOVED';
        break;
      case StringComparisonStatus.modified:
        statusColor = const Color(0xFFF59E0B);
        bgColor = statusColor.withAlpha(isDark ? 15 : 10);
        statusLabel = 'MODIFIED';
        break;
      case StringComparisonStatus.identical:
      default:
        statusColor = isDark ? Colors.grey[600]! : Colors.grey[400]!;
        bgColor = Colors.transparent;
        statusLabel = 'IDENTICAL';
    }

    final borderColor = isAmoled ? Colors.grey[850]! : (isDark ? const Color(0xFF2E2E38) : Colors.grey[200]!);
    final textMuted = isDark ? Colors.grey[500]! : Colors.grey[500]!;
    
    // Monospace text style for values
    const monoStyle = TextStyle(
      fontFamily: 'Consolas, Monaco, monospace',
      fontSize: 12,
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                                color: const Color(0xFFEF4444).withAlpha(isDark ? 20 : 15),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: const Color(0xFFEF4444).withAlpha(isDark ? 40 : 30),
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
                                      color: theme.colorScheme.onSurface.withAlpha(220),
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: const Color(0xFFEF4444).withAlpha(150),
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
                                color: const Color(0xFF22C55E).withAlpha(isDark ? 20 : 15),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: const Color(0xFF22C55E).withAlpha(isDark ? 40 : 30),
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
                                      color: theme.colorScheme.onSurface.withAlpha(220),
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
                          Text('Source: ', style: TextStyle(fontSize: 11, color: textMuted, fontWeight: FontWeight.w500)),
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
                          Text('Value: ', style: TextStyle(fontSize: 11, color: textMuted, fontWeight: FontWeight.w500)),
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
                          Text('Value: ', style: TextStyle(fontSize: 11, color: textMuted, fontWeight: FontWeight.w500)),
                          Expanded(
                            child: Text(
                              value1 ?? '--',
                              style: monoStyle.copyWith(
                                color: theme.colorScheme.onSurface.withAlpha(180),
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

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.compare_arrows_rounded,
                size: 48,
                color: theme.colorScheme.primary.withOpacity(0.7),
              ),
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
              children: ['.lang', '.json', '.xml', '.xliff', '.properties', '.yaml']
                  .map((ext) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.colorScheme.primary.withOpacity(0.15),
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
          ],
        ),
      ),
    );
  }
} 