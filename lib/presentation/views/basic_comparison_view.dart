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
  const BasicComparisonView({super.key});

  @override
  State<BasicComparisonView> createState() => _BasicComparisonViewState();
}

class _BasicComparisonViewState extends State<BasicComparisonView> {
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
      context.read<ComparisonBloc>().add(CompareFilesRequested(_file1!, _file2!));
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

  void _navigateToAiSettings() {
    // TODO: Implement navigation to AI Translation Settings screen/window
    // For now, show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('AI Translation Settings navigation (not yet implemented).')),
    );
    // Navigator.push(context, MaterialPageRoute(builder: (context) => AiTranslationSettingsView()));
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

    return BlocListener<FileWatcherBloc, FileWatcherState>(
      listener: (context, state) {
        if (state is FileChangedDetected) {
          // Show a snackbar notification about file change
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'File changed: ${state.changedFilePath.split(Platform.pathSeparator).last}. Recomparing...'
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          
          // Trigger automatic recomparison
          context.read<ComparisonBloc>().add(
            CompareFilesRequested(File(state.file1Path), File(state.file2Path)),
          );
        }
      },
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
                  return ListView.separated(
                    itemCount: diffEntries.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1, 
                      color: (isAmoled ? Colors.grey[850] : Theme.of(context).dividerColor)
                    ),
                    itemBuilder: (context, index) {
                      final entry = diffEntries[index];
                      final key = entry.key;
                      final statusDetail = entry.value;
                      final status = statusDetail.status;
                      final value1 = state.result.file1Data[key];
                      final value2 = state.result.file2Data[key];

                      return Container(
                        color: _getColorForStatus(context, status),
                        child: ListTile(
                          title: Text(key, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (status == StringComparisonStatus.removed || status == StringComparisonStatus.modified)
                                Text('File 1: ${value1 ?? "--"}', style: TextStyle(decoration: status == StringComparisonStatus.removed ? TextDecoration.lineThrough : null)),
                              if (status == StringComparisonStatus.added || status == StringComparisonStatus.modified)
                                Text('File 2: ${value2 ?? "--"}'),
                              if (status == StringComparisonStatus.identical)
                                Text('Value: ${value1 ?? "--"}'),
                            ],
                          ),
                          trailing: Icon(
                            status == StringComparisonStatus.added ? Icons.add_circle_outline :
                            status == StringComparisonStatus.removed ? Icons.remove_circle_outline :
                            status == StringComparisonStatus.modified ? Icons.edit_outlined :
                            Icons.check_circle_outline, // Identical
                            color: status == StringComparisonStatus.added ? Colors.green :
                                   status == StringComparisonStatus.removed ? Colors.red :
                                   status == StringComparisonStatus.modified ? Colors.orange :
                                   Colors.grey,
                          ),
                        ),
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
    final settingsState = context.read<SettingsBloc>().state;
    final bool isAmoled = settingsState.status == SettingsStatus.loaded &&
                        theme.brightness == Brightness.dark &&
                        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    String displayText;
    String tooltipPath = '';

    if (file != null) {
      tooltipPath = file.path;
      displayText = file.path.split(Platform.isWindows ? '\\' : '/').last;
    } else {
      displayText = isDraggingOver ? 'Drop file here' : 'Click to browse or drop file here';
    }

    // Define colors based on state
    Color borderColor;
    Color backgroundColor;
    
    if (isDraggingOver) {
      // Drag hover state
      borderColor = theme.colorScheme.primary;
      backgroundColor = theme.colorScheme.primary.withOpacity(0.1);
    } else if (file != null) {
      // File selected state  
      borderColor = isAmoled ? Colors.grey[800]! : theme.dividerColor;
      backgroundColor = isAmoled ? const Color(0xFF1E1E1E) : theme.colorScheme.surface.withOpacity(0.5);
    } else {
      // Default state
      borderColor = isAmoled ? Colors.grey[700]! : theme.dividerColor;
      backgroundColor = isAmoled ? const Color(0xFF1E1E1E) : theme.colorScheme.surface.withOpacity(0.5);
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isAmoled ? Colors.white70 : theme.textTheme.titleMedium?.color
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
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: borderColor,
                    width: isDraggingOver ? 2.0 : 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      file != null 
                          ? Icons.insert_drive_file_outlined
                          : (isDraggingOver 
                              ? Icons.file_download_outlined 
                              : Icons.file_open_outlined),
                      color: isDraggingOver 
                          ? theme.colorScheme.primary
                          : (isAmoled ? Colors.white70 : theme.iconTheme.color),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: file != null
                          ? Tooltip(
                              message: tooltipPath,
                              child: Text(
                                displayText,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: isAmoled ? Colors.white70 : theme.textTheme.bodyMedium?.color
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : Text(
                              displayText,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isDraggingOver 
                                    ? theme.colorScheme.primary
                                    : (isAmoled ? Colors.grey[400]! : Colors.grey[600]!),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
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
    // Determine if Amoled mode is active (can also pass as parameter if preferred)
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = Theme.of(context).brightness == Brightness.dark &&
                        settingsState.status == SettingsStatus.loaded &&
                        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    int totalKeys = 0;
    int missingInTarget = 0;
    int missingInSource = 0;

    if (_latestComparisonResult != null) {
      final allKeys = Set<String>.from(_latestComparisonResult!.file1Data.keys);
      allKeys.addAll(_latestComparisonResult!.file2Data.keys);
      totalKeys = allKeys.length; 
      _latestComparisonResult!.diff.forEach((key, statusDetail) {
        if (statusDetail.status == StringComparisonStatus.added) missingInSource++; 
        if (statusDetail.status == StringComparisonStatus.removed) missingInTarget++; 
      });
    }
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark; // Still useful for non-Amoled dark conditional logic
    final Color separatorColor = isDarkMode ? (isAmoled ? Colors.grey[800]! : Colors.grey[700]!) : Colors.grey[300]!;

    return Card(
      color: isAmoled ? Colors.black : Theme.of(context).cardColor, // Amoled check for card color
      elevation: isAmoled ? 0.3 : 2.0, 
      shape: isAmoled 
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Consistent radius
              side: BorderSide(color: Colors.grey[850]!)
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, 
                children: [
                  _buildAnalyticsItem('Total Keys', totalKeys.toString(), isAmoled ? Colors.grey[400]! : Colors.blueGrey, compact: true),
                  _buildAnalyticsItem('Missing Target', missingInTarget.toString(), Colors.redAccent[100]!, compact: true), // Lighter red for Amoled
                  _buildAnalyticsItem('Missing Source', missingInSource.toString(), Colors.lightGreenAccent[400]!, compact: true), // Lighter green for Amoled
                  _buildFileWatcherStatus(settingsState, isAmoled, isDarkMode),
                ],
              ),
            ),
            SizedBox(
              height: 30, 
              child: VerticalDivider(color: separatorColor, thickness: 1, indent: 4, endIndent: 4)
            ),
            _buildFilterButton(BasicDiffFilter.added, 'Added', Icons.add_circle_outline, Colors.green, isDarkMode), // isDarkMode is fine here, FilterChip theme handles Amoled
            _buildFilterButton(BasicDiffFilter.removed, 'Removed', Icons.remove_circle_outline, Colors.red, isDarkMode),
            _buildFilterButton(BasicDiffFilter.modified, 'Modified', Icons.edit_outlined, Colors.orange, isDarkMode),
            _buildFilterButton(BasicDiffFilter.all, 'All', Icons.filter_list_off_outlined, isAmoled ? Colors.grey[600]! : (isDarkMode ? Colors.grey[300]! : Colors.grey[700]!), isDarkMode),
            SizedBox(
              height: 30,
              child: VerticalDivider(color: separatorColor, thickness: 1, indent: 4, endIndent: 4)
            ),
            Flexible(
              flex: 3, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.zoom_in_map, size: 18),
                    label: const Text('Advanced'),
                    onPressed: _navigateToAdvancedView,
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), 
                        foregroundColor: theme.colorScheme.primary, // Should be fine
                    ),
                  ),
                  const SizedBox(width: 4), 
                  TextButton.icon(
                    icon: const Icon(Icons.model_training_outlined, size: 18),
                    label: const Text('AI Settings'), 
                    onPressed: _navigateToAiSettings,
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        foregroundColor: theme.colorScheme.secondary, // Should be fine
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(BasicDiffFilter filter, String label, IconData icon, Color defaultIconColor, bool isDarkMode) {
    final bool isActive = _currentFilter == filter;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
        selected: isActive,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: isActive ? BorderSide.none : BorderSide(color: isDarkMode ? Colors.grey[700]! : Colors.grey[400]!)
        ),
        onSelected: (bool selected) {
          if (selected) {
            setState(() {
              _currentFilter = filter;
            });
          }
        },
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
        : (Theme.of(context).textTheme.bodySmall?.color ?? Theme.of(context).colorScheme.onSurfaceVariant);

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
} 