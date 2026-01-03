import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:localizer_app_main/business_logic/blocs/directory_comparison_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/data/models/file_pair.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/views/comparison_result_dialog.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:path/path.dart' as p;
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/app_command_service.dart';

class FilesView extends StatefulWidget {
  const FilesView({super.key});

  @override
  State<FilesView> createState() => _FilesViewState();
}

class _FilesViewState extends State<FilesView>
    with SingleTickerProviderStateMixin {
  String? _sourceDirectory;
  String? _targetDirectory;
  bool _isDraggingSource = false;
  bool _isDraggingTarget = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  StreamSubscription<AppCommand>? _appCommandSubscription;
  void Function(VoidCallback)? _exportDialogSetState;

  // Export state
  bool _isExporting = false;
  int _exportedCount = 0;
  int _totalToExport = 0;
  String? _currentExportFile;

  @override
  void initState() {
    super.initState();
    _appCommandSubscription =
        sl<AppCommandService>().stream.listen(_handleAppCommand);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _appCommandSubscription?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickDirectory(bool isSource) async {
    String? result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      setState(() {
        if (isSource) {
          _sourceDirectory = result;
        } else {
          _targetDirectory = result;
        }
      });
    }
  }

  void _startDirectoryComparison() {
    if (_sourceDirectory != null && _targetDirectory != null) {
      context.read<DirectoryComparisonBloc>().add(
            CompareDirectoriesRequested(_sourceDirectory!, _targetDirectory!),
          );
    } else {
      ToastService.showWarning(
          context, 'Please select both a source and target directory.');
    }
  }

  void _handleAppCommand(AppCommand command) {
    if (command.type != AppCommandType.openFolder) {
      return;
    }
    _openFoldersFromCommand();
  }

  Future<void> _openFoldersFromCommand() async {
    final source = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select Source Folder',
    );
    if (!mounted || source == null) {
      return;
    }

    final target = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select Target Folder',
    );
    if (!mounted || target == null) {
      return;
    }

    setState(() {
      _sourceDirectory = source;
      _targetDirectory = target;
    });

    _startDirectoryComparison();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    // AMOLED detection
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = isDark &&
        settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    // AMOLED-aware color helpers
    Color getCardColor() => isAmoled
        ? AppThemeV2.amoledCard
        : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard);
    Color getSurfaceColor() => isAmoled
        ? AppThemeV2.amoledSurface
        : (isDark ? AppThemeV2.darkSurface : AppThemeV2.lightSurface);
    Color getBorderColor() => isAmoled
        ? AppThemeV2.amoledBorder
        : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder);
    Color getBorderSubtleColor() => isAmoled
        ? AppThemeV2.amoledBorderSubtle
        : (isDark ? AppThemeV2.darkBorderSubtle : AppThemeV2.lightBorderSubtle);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Header
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.folders,
                    size: 28,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Directory Comparison',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Directory Selection Cards
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildDirectoryDropZone(
                    context: context,
                    title: 'Source Directory',
                    subtitle: 'Original/Reference files',
                    directory: _sourceDirectory,
                    isDragging: _isDraggingSource,
                    icon: LucideIcons.folderInput,
                    accentColor: Theme.of(context).colorScheme.primary,
                    onBrowse: () => _pickDirectory(true),
                    onDragEnter: () => setState(() => _isDraggingSource = true),
                    onDragExit: () => setState(() => _isDraggingSource = false),
                    onDrop: (path) => setState(() {
                      _sourceDirectory = path;
                      _isDraggingSource = false;
                    }),
                    isAmoled: isAmoled,
                  ),
                ),
                const SizedBox(width: 16),
                // Arrow indicator between cards
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Icon(
                    LucideIcons.arrowRight,
                    size: 32,
                    color: isDark
                        ? AppThemeV2.darkTextMuted
                        : AppThemeV2.lightTextMuted,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDirectoryDropZone(
                    context: context,
                    title: 'Target Directory',
                    subtitle: 'Translation/Comparison files',
                    directory: _targetDirectory,
                    isDragging: _isDraggingTarget,
                    icon: LucideIcons.folderOutput,
                    accentColor: Theme.of(context).colorScheme.secondary,
                    onBrowse: () => _pickDirectory(false),
                    onDragEnter: () => setState(() => _isDraggingTarget = true),
                    onDragExit: () => setState(() => _isDraggingTarget = false),
                    onDrop: (path) => setState(() {
                      _targetDirectory = path;
                      _isDraggingTarget = false;
                    }),
                    isAmoled: isAmoled,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Action Buttons
            BlocBuilder<DirectoryComparisonBloc, DirectoryComparisonState>(
              builder: (context, state) {
                bool canCompare = false;
                bool canExport = false;
                List<FilePair> pairedFiles = [];
                Map<FilePair, ComparisonResult> comparisonResults = {};

                if (state is DirectoryComparisonSuccess) {
                  canCompare = state.pairedFiles.isNotEmpty;
                  pairedFiles = state.pairedFiles;
                  comparisonResults = state.comparisonResults;
                  // Can export if at least one pair has comparison results
                  canExport = comparisonResults.isNotEmpty;
                }
                final hasDirectories =
                    _sourceDirectory != null && _targetDirectory != null;

                return Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        icon: LucideIcons.search,
                        label: 'Discover Files',
                        onPressed:
                            hasDirectories ? _startDirectoryComparison : null,
                        isPrimary: !canCompare,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        icon: LucideIcons.arrowRightLeft,
                        label: 'Compare All',
                        onPressed: canCompare
                            ? () {
                                final settingsState =
                                    context.read<SettingsBloc>().state;
                                if (settingsState.status ==
                                    SettingsStatus.loaded) {
                                  context.read<DirectoryComparisonBloc>().add(
                                        ComparePairedFilesRequested(
                                            settingsState.appSettings),
                                      );
                                  ToastService.showInfo(
                                      context, 'Comparison started...');
                                }
                              }
                            : null,
                        isPrimary: canCompare && !canExport,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        icon: LucideIcons.download,
                        label: 'Export All',
                        onPressed: canExport && !_isExporting
                            ? () => _exportAllResults(
                                pairedFiles, comparisonResults)
                            : null,
                        isPrimary: canExport,
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // Results Panel
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: getCardColor(),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: getBorderColor(),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BlocBuilder<DirectoryComparisonBloc,
                      DirectoryComparisonState>(
                    builder: (context, state) {
                      if (state is DirectoryComparisonInitial) {
                        return _buildEmptyState(context);
                      }
                      if (state is DirectoryComparisonLoading) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                strokeWidth: 3,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Discovering files...',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: isDark
                                      ? AppThemeV2.darkTextSecondary
                                      : AppThemeV2.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is DirectoryComparisonSuccess) {
                        if (state.pairedFiles.isEmpty &&
                            state.unmatchedSourceFiles.isEmpty &&
                            state.unmatchedTargetFiles.isEmpty) {
                          return _buildEmptyState(context,
                              message:
                                  'No files found in selected directories.');
                        }
                        return _buildResultsList(context, state);
                      }
                      if (state is DirectoryComparisonFailure) {
                        return _buildErrorState(context, state.error);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectoryDropZone({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String? directory,
    required bool isDragging,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onBrowse,
    required VoidCallback onDragEnter,
    required VoidCallback onDragExit,
    required Function(String) onDrop,
    bool isAmoled = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hasDirectory = directory != null;

    // AMOLED-aware colors
    final cardColor = isAmoled
        ? AppThemeV2.amoledCard
        : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard);
    final borderColor = isAmoled
        ? AppThemeV2.amoledBorder
        : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder);
    final surfaceColor = isAmoled
        ? AppThemeV2.amoledSurface
        : (isDark ? AppThemeV2.darkSurface : AppThemeV2.lightSurface);
    final borderSubtleColor = isAmoled
        ? AppThemeV2.amoledBorderSubtle
        : (isDark ? AppThemeV2.darkBorderSubtle : AppThemeV2.lightBorderSubtle);

    return DropRegion(
      formats: Formats.standardFormats,
      onDropOver: (event) {
        // Check if we have a file/folder being dragged
        if (event.session.items.isNotEmpty) {
          onDragEnter();
          return DropOperation.copy;
        }
        return DropOperation.none;
      },
      onDropLeave: (event) => onDragExit(),
      onPerformDrop: (event) async {
        for (final item in event.session.items) {
          final reader = item.dataReader;
          if (reader == null) continue;

          // Try to get file URI
          if (reader.canProvide(Formats.fileUri)) {
            reader.getValue<Uri>(Formats.fileUri, (uri) {
              if (uri != null) {
                final path = uri.toFilePath();
                if (FileSystemEntity.isDirectorySync(path)) {
                  onDrop(path);
                }
              }
            });
            break; // Only process first item
          }
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDragging ? accentColor.withOpacity(0.1) : cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDragging
                ? accentColor
                : hasDirectory
                    ? accentColor.withOpacity(0.5)
                    : borderColor,
            width: isDragging ? 2 : 1,
          ),
          boxShadow: isDragging
              ? [
                  BoxShadow(
                    color: accentColor.withOpacity(0.2),
                    blurRadius: 12,
                    spreadRadius: 2,
                  )
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: accentColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Directory path display
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isDark
                    ? AppThemeV2.darkSurface.withValues(alpha: 0.5)
                    : AppThemeV2.lightSurface.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDark
                      ? AppThemeV2.darkBorderSubtle
                      : AppThemeV2.lightBorderSubtle,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    hasDirectory ? LucideIcons.folder : LucideIcons.folderOpen,
                    color: hasDirectory
                        ? accentColor
                        : (isDark
                            ? AppThemeV2.darkTextMuted
                            : AppThemeV2.lightTextMuted),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      hasDirectory
                          ? _formatPath(directory)
                          : 'Drop folder here or browse...',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: hasDirectory
                            ? null
                            : (isDark
                                ? AppThemeV2.darkTextMuted
                                : AppThemeV2.lightTextMuted),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (hasDirectory)
                    Tooltip(
                      message: directory,
                      child: Icon(
                        LucideIcons.info,
                        size: 16,
                        color: isDark
                            ? AppThemeV2.darkTextMuted
                            : AppThemeV2.lightTextMuted,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Browse button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onBrowse,
                icon: const Icon(LucideIcons.folderOpen, size: 18),
                label: const Text('Browse'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(
                    color: accentColor.withValues(alpha: 0.5),
                  ),
                  foregroundColor: accentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPath(String path) {
    final separator = Platform.isWindows ? '\\' : '/';
    final parts = path.split(separator);
    if (parts.length > 3) {
      return '...${separator}${parts.skip(parts.length - 3).join(separator)}';
    }
    return path;
  }

  Widget _buildEmptyState(BuildContext context, {String? message}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.folders,
            size: 64,
            color:
                isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? 'Select directories to start comparison',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isDark
                  ? AppThemeV2.darkTextSecondary
                  : AppThemeV2.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Drag & drop folders above or use the Browse buttons',
            style: theme.textTheme.bodySmall?.copyWith(
              color:
                  isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.alertCircle,
            size: 64,
            color: AppThemeV2.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Error occurred',
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppThemeV2.error,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(
      BuildContext context, DirectoryComparisonSuccess state) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (state.pairedFiles.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildSummaryBar(
                context, state.pairedFiles, state.comparisonResults),
          ),
        _buildPairedFilesSection(
          context,
          state.pairedFiles,
          state.comparisonResults,
          state.comparisonErrors,
        ),
        if (state.unmatchedSourceFiles.isNotEmpty)
          _buildUnmatchedFilesSection(
            context,
            'Unmatched Source Files',
            state.unmatchedSourceFiles,
            state.unmatchedTargetFiles,
            AppThemeV2.warning,
          ),
        if (state.unmatchedTargetFiles.isNotEmpty)
          _buildUnmatchedFilesSection(
            context,
            'Unmatched Target Files',
            state.unmatchedTargetFiles,
            null,
            AppThemeV2.info,
          ),
      ],
    );
  }

  Widget _buildSummaryBar(
    BuildContext context,
    List<FilePair> pairs,
    Map<FilePair, ComparisonResult> results,
  ) {
    int totalAdded = 0;
    int totalRemoved = 0;
    int totalModified = 0;

    for (var pair in pairs) {
      if (results.containsKey(pair)) {
        final result = results[pair]!;
        totalAdded += result.diff.values
            .where((d) => d.status == StringComparisonStatus.added)
            .length;
        totalRemoved += result.diff.values
            .where((d) => d.status == StringComparisonStatus.removed)
            .length;
        totalModified += result.diff.values
            .where((d) => d.status == StringComparisonStatus.modified)
            .length;
      }
    }

    final theme = Theme.of(context);
    final themeState = context.watch<ThemeBloc>().state;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppThemeV2.darkSurface : AppThemeV2.lightSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark
              ? AppThemeV2.darkBorderSubtle
              : AppThemeV2.lightBorderSubtle,
        ),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.activity,
              size: 20,
              color: isDark
                  ? AppThemeV2.darkTextSecondary
                  : AppThemeV2.lightTextSecondary),
          const SizedBox(width: 8),
          Text(
            '${pairs.length} file pairs',
            style: theme.textTheme.titleMedium,
          ),
          const Spacer(),
          _StatChip(
              label: 'A', count: totalAdded, color: themeState.diffAddedColor),
          const SizedBox(width: 8),
          _StatChip(
              label: 'R',
              count: totalRemoved,
              color: themeState.diffRemovedColor),
          const SizedBox(width: 8),
          _StatChip(
              label: 'M',
              count: totalModified,
              color: themeState.diffModifiedColor),
        ],
      ),
    );
  }

  Widget _buildPairedFilesSection(
    BuildContext context,
    List<FilePair> pairs,
    Map<FilePair, ComparisonResult> results,
    Map<FilePair, String> errors,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(LucideIcons.link, size: 18, color: AppThemeV2.success),
              const SizedBox(width: 8),
              Text(
                'Paired Files (${pairs.length})',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        ...pairs.map((pair) {
          final result = results[pair];
          final errorMessage = errors[pair];
          final hasResult = result != null;
          final added = result?.diff.values
                  .where((d) => d.status == StringComparisonStatus.added)
                  .length ??
              0;
          final removed = result?.diff.values
                  .where((d) => d.status == StringComparisonStatus.removed)
                  .length ??
              0;
          final modified = result?.diff.values
                  .where((d) => d.status == StringComparisonStatus.modified)
                  .length ??
              0;

          final themeState = context.watch<ThemeBloc>().state;
          final statusColor = errorMessage != null
              ? AppThemeV2.error
              : hasResult
                  ? AppThemeV2.success
                  : AppThemeV2.warning;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppThemeV2.darkSurface : AppThemeV2.lightSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark
                    ? AppThemeV2.darkBorderSubtle
                    : AppThemeV2.lightBorderSubtle,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.basename(pair.sourceFile.path),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '→ ${p.basename(pair.targetFile.path)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                if (result != null) ...[
                  _StatChip(
                      label: 'A',
                      count: added,
                      color: themeState.diffAddedColor),
                  const SizedBox(width: 4),
                  _StatChip(
                      label: 'R',
                      count: removed,
                      color: themeState.diffRemovedColor),
                  const SizedBox(width: 4),
                  _StatChip(
                      label: 'M',
                      count: modified,
                      color: themeState.diffModifiedColor),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => ComparisonResultDialog(result: result),
                      );
                    },
                    icon: const Icon(LucideIcons.eye, size: 16),
                    label: const Text('View'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                  ),
                ] else if (errorMessage != null) ...[
                  Tooltip(
                    message: errorMessage,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          size: 18,
                          color: AppThemeV2.error,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Failed',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppThemeV2.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else
                  Icon(
                    Icons.hourglass_empty_rounded,
                    size: 20,
                    color: isDark
                        ? AppThemeV2.darkTextMuted
                        : AppThemeV2.lightTextMuted,
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildUnmatchedFilesSection(
    BuildContext context,
    String title,
    List<File> files,
    List<File>? availableToPair,
    Color accentColor,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(Icons.help_outline_rounded, size: 18, color: accentColor),
              const SizedBox(width: 8),
              Text(
                '$title (${files.length})',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        ...files.map((file) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppThemeV2.darkSurface : AppThemeV2.lightSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark
                    ? AppThemeV2.darkBorderSubtle
                    : AppThemeV2.lightBorderSubtle,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 32,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    p.basename(file.path),
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                if (availableToPair != null)
                  OutlinedButton(
                    onPressed: () =>
                        _showPairingDialog(context, file, availableToPair),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    child: const Text('Pair...'),
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Future<void> _showPairingDialog(
    BuildContext context,
    File sourceFile,
    List<File> availableTargets,
  ) async {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Pair "${p.basename(sourceFile.path)}" with:'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableTargets.length,
              itemBuilder: (context, index) {
                final targetFile = availableTargets[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDark
                          ? AppThemeV2.darkBorder
                          : AppThemeV2.lightBorder,
                    ),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(p.basename(targetFile.path)),
                    trailing: const Icon(Icons.add_link_rounded),
                    onTap: () {
                      context.read<DirectoryComparisonBloc>().add(
                            ManuallyPairFile(
                                sourceFile: sourceFile, targetFile: targetFile),
                          );
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }

  /// Export all comparison results to CSV files
  Future<void> _exportAllResults(
    List<FilePair> pairedFiles,
    Map<FilePair, ComparisonResult> results,
  ) async {
    // Filter pairs that have comparison results
    final pairsWithResults =
        pairedFiles.where((pair) => results.containsKey(pair)).toList();

    if (pairsWithResults.isEmpty) {
      if (mounted) {
        ToastService.showWarning(context,
            'No comparison results to export. Run "Compare All" first.');
      }
      return;
    }

    // Ask user to select export directory
    final exportPath = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select Export Folder',
    );

    if (exportPath == null) return; // User cancelled

    // Create timestamped subfolder
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final exportDir = Directory('$exportPath/export_$timestamp');

    try {
      await exportDir.create(recursive: true);
    } catch (e) {
      if (mounted) {
        ToastService.showError(context, 'Failed to create export folder: $e');
      }
      return;
    }

    // Start export with progress
    setState(() {
      _isExporting = true;
      _exportedCount = 0;
      _totalToExport = pairsWithResults.length;
      _currentExportFile = null;
    });
    _refreshExportDialog();

    // Show progress dialog
    if (mounted) {
      _showExportProgressDialog();
    }

    // Summary data for the summary file
    final summaryData = <Map<String, dynamic>>[];

    try {
      for (int i = 0; i < pairsWithResults.length; i++) {
        final pair = pairsWithResults[i];
        final result = results[pair]!;
        final fileName = p.basenameWithoutExtension(pair.sourceFile.path);

        setState(() {
          _exportedCount = i;
          _currentExportFile = fileName;
        });
        _refreshExportDialog();

        // Generate CSV content for this pair
        final csvContent = _generateCsvForPair(pair, result);

        // Write to file
        final csvFile = File('${exportDir.path}/${fileName}_comparison.csv');
        await csvFile.writeAsString(csvContent);

        // Collect summary data
        final added = result.diff.values
            .where((d) => d.status == StringComparisonStatus.added)
            .length;
        final removed = result.diff.values
            .where((d) => d.status == StringComparisonStatus.removed)
            .length;
        final modified = result.diff.values
            .where((d) => d.status == StringComparisonStatus.modified)
            .length;

        summaryData.add({
          'filename': fileName,
          'added': added,
          'removed': removed,
          'modified': modified,
          'total': added + removed + modified,
        });
      }

      // Generate and write summary file
      final summaryCsv = _generateSummaryCsv(summaryData);
      final summaryFile = File('${exportDir.path}/_summary.csv');
      await summaryFile.writeAsString(summaryCsv);

      setState(() {
        _exportedCount = pairsWithResults.length;
        _currentExportFile = null;
      });
      _refreshExportDialog();

      // Close progress dialog and show success
      if (mounted) {
        _exportDialogSetState = null;
        Navigator.of(context).pop(); // Close progress dialog
        _showExportCompleteDialog(exportDir.path, pairsWithResults.length);
      }
    } catch (e) {
      if (mounted) {
        _exportDialogSetState = null;
        Navigator.of(context).pop(); // Close progress dialog
        ToastService.showError(context, 'Export failed: $e');
      }
    } finally {
      setState(() {
        _isExporting = false;
        _exportedCount = 0;
        _totalToExport = 0;
        _currentExportFile = null;
      });
      _refreshExportDialog();
    }
  }

  String _generateCsvForPair(FilePair pair, ComparisonResult result) {
    final csvData = <List<dynamic>>[
      [
        'Status',
        'String Key',
        'Old Value (Source)',
        'New Value (Target)',
        'Similarity'
      ],
    ];

    for (final entry in result.diff.entries) {
      final key = entry.key;
      final status = entry.value.status;
      final similarity = entry.value.similarity;
      final file1Value = result.file1Data[key] ?? '';
      final file2Value = result.file2Data[key] ?? '';

      String statusText;
      switch (status) {
        case StringComparisonStatus.added:
          statusText = 'ADDED';
          break;
        case StringComparisonStatus.removed:
          statusText = 'REMOVED';
          break;
        case StringComparisonStatus.modified:
          statusText = 'MODIFIED';
          break;
        case StringComparisonStatus.identical:
          statusText = 'IDENTICAL';
          break;
      }

      String simText =
          similarity != null ? '${(similarity * 100).toStringAsFixed(1)}%' : '';

      csvData.add([
        statusText,
        key,
        status == StringComparisonStatus.added ? '' : file1Value,
        status == StringComparisonStatus.removed ? '' : file2Value,
        simText,
      ]);
    }

    // Convert to CSV string with UTF-8 BOM for Excel compatibility
    final csvString = const ListToCsvConverter().convert(csvData);
    return '\uFEFF$csvString';
  }

  String _generateSummaryCsv(List<Map<String, dynamic>> summaryData) {
    final csvData = <List<dynamic>>[
      ['Filename', 'Added', 'Removed', 'Modified', 'Total Changes'],
    ];

    int totalAdded = 0;
    int totalRemoved = 0;
    int totalModified = 0;
    int grandTotal = 0;

    for (final entry in summaryData) {
      csvData.add([
        entry['filename'],
        entry['added'],
        entry['removed'],
        entry['modified'],
        entry['total'],
      ]);
      totalAdded += entry['added'] as int;
      totalRemoved += entry['removed'] as int;
      totalModified += entry['modified'] as int;
      grandTotal += entry['total'] as int;
    }

    // Add totals row
    csvData.add(['TOTAL', totalAdded, totalRemoved, totalModified, grandTotal]);

    final csvString = const ListToCsvConverter().convert(csvData);
    return '\uFEFF$csvString';
  }

  void _refreshExportDialog() {
    _exportDialogSetState?.call(() {});
  }

  void _showExportProgressDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            _exportDialogSetState = setDialogState;
            // Update dialog state when parent state changes
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.download_rounded,
                      color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 12),
                  const Text('Exporting Results'),
                ],
              ),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_currentExportFile != null)
                      Text(
                        'Processing: $_currentExportFile',
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: _totalToExport > 0
                          ? _exportedCount / _totalToExport
                          : null,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppThemeV2.darkBorder
                              : AppThemeV2.lightBorder,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$_exportedCount of $_totalToExport files exported',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppThemeV2.darkTextMuted
                                    : AppThemeV2.lightTextMuted,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showExportCompleteDialog(String exportPath, int fileCount) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle_rounded, color: AppThemeV2.success),
              const SizedBox(width: 12),
              const Text('Export Complete'),
            ],
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Successfully exported $fileCount comparison files plus summary.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppThemeV2.darkSurface
                        : AppThemeV2.lightSurface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark
                          ? AppThemeV2.darkBorder
                          : AppThemeV2.lightBorder,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.folder_rounded,
                        size: 20,
                        color: isDark
                            ? AppThemeV2.darkTextMuted
                            : AppThemeV2.lightTextMuted,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          exportPath,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(label),
      );
    }
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _StatChip({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$label: $count',
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
