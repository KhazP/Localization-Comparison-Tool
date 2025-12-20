import 'dart:io';
import 'package:flutter/material.dart';
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
            elevation: isAmoled ? 0.3 : 2.0, 
            shape: isAmoled 
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Assuming a common radius, adjust if needed
                    side: BorderSide(color: Colors.grey[850]!)
                  )
                : null, // Default shape otherwise
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                      const SizedBox(width: 10),
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
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.compare_arrows),
                    label: const Text('Compare Files'),
                    onPressed: (_file1 != null && _file2 != null) ? _startComparison : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      padding: const EdgeInsets.symmetric(vertical: 12),
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

                  if (diffEntries.isEmpty) {
                     return const Center(child: Text('No differences found based on keys.'));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: diffEntries.length,
                    itemBuilder: (context, index) {
                      final entry = diffEntries[index];
                      final key = entry.key;
                      final statusDetail = entry.value;
                      final status = statusDetail.status;
                      final value1 = state.result.file1Data[key];
                      final value2 = state.result.file2Data[key];

                      return _buildDiffListItem(
                        key: key,
                        status: status,
                        value1: value1,
                        value2: value2,
                        isAmoled: isAmoled,
                      );
                    },
                  );
                }
                if (state is ComparisonFailure) {
                  return Center(child: Text('Comparison Failed: ${state.error}', style: const TextStyle(color: Colors.red)));
                }
                return const Center(child: Text('Select two files and click Compare.'));
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
    final isDarkMode = theme.brightness == Brightness.dark;

    String displayText;
    String tooltipPath = '';

    if (file != null) {
      tooltipPath = file.path;
      displayText = file.path.split(Platform.isWindows ? '\\' : '/').last;
    } else {
      displayText = isDraggingOver ? 'Drop file here' : 'Click to browse or drop file here';
    }

    Color borderColor = isDraggingOver 
        ? theme.colorScheme.primary 
        : theme.dividerColor;
    Color backgroundColor = isDraggingOver 
        ? theme.colorScheme.primary.withOpacity(0.05) 
        : theme.cardColor;

    if (file != null) {
        backgroundColor = theme.colorScheme.surface.withOpacity(0.5);
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface.withOpacity(0.7)
          )),
          const SizedBox(height: 8.0),
          DropTarget(
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
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: borderColor,
                    width: isDraggingOver ? 2.0 : 1.0,
                    style: BorderStyle.solid, // Dotted border requires custom painter, solid is fine for now
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      file != null 
                          ? Icons.description_outlined
                          : Icons.cloud_upload_outlined,
                      color: isDraggingOver 
                          ? theme.colorScheme.primary
                          : theme.colorScheme.primary.withOpacity(0.7),
                      size: 32,
                    ),
                    const SizedBox(height: 12),
                    file != null
                        ? Tooltip(
                            message: tooltipPath,
                            child: Text(
                              displayText,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onSurface
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : Text(
                            displayText,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
    
    return BlocBuilder<FileWatcherBloc, FileWatcherState>(
      builder: (context, watcherState) {
        final isWatching = watcherState is FileWatcherActive && watcherState.isEnabled;
        final iconColor = isWatching ? Colors.green : 
                         (isAutoReloadEnabled ? Colors.orange : Colors.grey);
        final statusText = isWatching ? 'ON' : 
                          (isAutoReloadEnabled ? 'OFF' : 'DIS');
        
        return Tooltip(
          message: isWatching ? 'Auto-reload is active' :
                   (isAutoReloadEnabled ? 'Auto-reload enabled but no files watched' : 'Auto-reload disabled'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.visibility_outlined,
                size: 16,
                color: iconColor,
              ),
              const SizedBox(height: 2),
              Text(
                statusText,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
            ],
          ),
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

    // Status-based colors
    Color statusColor;
    Color bgColor;
    IconData statusIcon;
    String statusLabel;

    switch (status) {
      case StringComparisonStatus.added:
        statusColor = const Color(0xFF22C55E);
        bgColor = statusColor.withAlpha(isDark ? 20 : 15);
        statusIcon = Icons.add_circle_outline;
        statusLabel = 'ADDED';
        break;
      case StringComparisonStatus.removed:
        statusColor = const Color(0xFFEF4444);
        bgColor = statusColor.withAlpha(isDark ? 20 : 15);
        statusIcon = Icons.remove_circle_outline;
        statusLabel = 'REMOVED';
        break;
      case StringComparisonStatus.modified:
        statusColor = const Color(0xFFF59E0B);
        bgColor = statusColor.withAlpha(isDark ? 20 : 15);
        statusIcon = Icons.edit_outlined;
        statusLabel = 'MODIFIED';
        break;
      case StringComparisonStatus.identical:
      default:
        statusColor = isDark ? Colors.grey[600]! : Colors.grey[400]!;
        bgColor = Colors.transparent;
        statusIcon = Icons.check_circle_outline;
        statusLabel = 'IDENTICAL';
    }

    final cardBg = isAmoled ? Colors.black : (isDark ? const Color(0xFF1A1A22) : Colors.white);
    final borderColor = isAmoled ? Colors.grey[850]! : (isDark ? const Color(0xFF2E2E38) : Colors.grey[200]!);
    final textMuted = isDark ? Colors.grey[400]! : Colors.grey[600]!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor.withAlpha(isDark ? 80 : 100)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status indicator bar
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Key row with status chip
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            key,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Status chip
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(isDark ? 40 : 30),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(statusIcon, size: 12, color: statusColor),
                              const SizedBox(width: 4),
                              Text(
                                statusLabel,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Values
                    if (status == StringComparisonStatus.removed || status == StringComparisonStatus.modified) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Source: ', style: TextStyle(fontSize: 12, color: textMuted, fontWeight: FontWeight.w500)),
                          Expanded(
                            child: Text(
                              value1 ?? '--',
                              style: TextStyle(
                                fontSize: 12,
                                color: status == StringComparisonStatus.removed 
                                    ? statusColor.withAlpha(200) 
                                    : theme.colorScheme.onSurface.withAlpha(200),
                                decoration: status == StringComparisonStatus.removed 
                                    ? TextDecoration.lineThrough 
                                    : null,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (status == StringComparisonStatus.added || status == StringComparisonStatus.modified) ...[
                      if (status == StringComparisonStatus.modified) const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Target: ', style: TextStyle(fontSize: 12, color: textMuted, fontWeight: FontWeight.w500)),
                          Expanded(
                            child: Text(
                              value2 ?? '--',
                              style: TextStyle(
                                fontSize: 12,
                                color: status == StringComparisonStatus.added 
                                    ? statusColor.withAlpha(200) 
                                    : theme.colorScheme.onSurface.withAlpha(200),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (status == StringComparisonStatus.identical) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Value: ', style: TextStyle(fontSize: 12, color: textMuted, fontWeight: FontWeight.w500)),
                          Expanded(
                            child: Text(
                              value1 ?? '--',
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.onSurface.withAlpha(180),
                              ),
                              maxLines: 2,
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
} 