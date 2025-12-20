import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:localizer_app_main/business_logic/blocs/directory_comparison_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/data/models/file_pair.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/views/comparison_result_dialog.dart';
import 'package:path/path.dart' as p;

class FilesView extends StatefulWidget {
  const FilesView({super.key});

  @override
  State<FilesView> createState() => _FilesViewState();
}

class _FilesViewState extends State<FilesView> with SingleTickerProviderStateMixin {
  String? _sourceDirectory;
  String? _targetDirectory;
  bool _isDraggingSource = false;
  bool _isDraggingTarget = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select both a source and target directory.'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

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
                    Icons.folder_copy_rounded,
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
                    icon: Icons.source_rounded,
                    accentColor: AppThemeV2.primary,
                    onBrowse: () => _pickDirectory(true),
                    onDragEnter: () => setState(() => _isDraggingSource = true),
                    onDragExit: () => setState(() => _isDraggingSource = false),
                    onDrop: (path) => setState(() {
                      _sourceDirectory = path;
                      _isDraggingSource = false;
                    }),
                  ),
                ),
                const SizedBox(width: 16),
                // Arrow indicator between cards
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 32,
                    color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
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
                    icon: Icons.compare_arrows_rounded,
                    accentColor: AppThemeV2.secondary,
                    onBrowse: () => _pickDirectory(false),
                    onDragEnter: () => setState(() => _isDraggingTarget = true),
                    onDragExit: () => setState(() => _isDraggingTarget = false),
                    onDrop: (path) => setState(() {
                      _targetDirectory = path;
                      _isDraggingTarget = false;
                    }),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Action Buttons
            BlocBuilder<DirectoryComparisonBloc, DirectoryComparisonState>(
              builder: (context, state) {
                bool canCompare = false;
                if (state is DirectoryComparisonSuccess) {
                  canCompare = state.pairedFiles.isNotEmpty;
                }
                final hasDirectories = _sourceDirectory != null && _targetDirectory != null;

                return Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.search_rounded,
                        label: 'Discover Files',
                        onPressed: hasDirectories ? _startDirectoryComparison : null,
                        isPrimary: !canCompare,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.compare_arrows_rounded,
                        label: 'Compare All',
                        onPressed: canCompare
                            ? () {
                                final settingsState = context.read<SettingsBloc>().state;
                                if (settingsState.status == SettingsStatus.loaded) {
                                  context.read<DirectoryComparisonBloc>().add(
                                    ComparePairedFilesRequested(settingsState.appSettings),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Comparison started...'),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  );
                                }
                              }
                            : null,
                        isPrimary: canCompare,
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
                  color: isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BlocBuilder<DirectoryComparisonBloc, DirectoryComparisonState>(
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
                                  color: isDark ? AppThemeV2.darkTextSecondary : AppThemeV2.lightTextSecondary,
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
                          return _buildEmptyState(context, message: 'No files found in selected directories.');
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
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hasDirectory = directory != null;

    return DropTarget(
      onDragEntered: (_) => onDragEnter(),
      onDragExited: (_) => onDragExit(),
      onDragDone: (details) {
        if (details.files.isNotEmpty) {
          final path = details.files.first.path;
          if (FileSystemEntity.isDirectorySync(path)) {
            onDrop(path);
          }
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDragging
              ? accentColor.withOpacity(0.1)
              : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDragging
                ? accentColor
                : hasDirectory
                    ? accentColor.withOpacity(0.5)
                    : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder),
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
                    color: accentColor.withOpacity(0.15),
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
                          color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
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
                    ? AppThemeV2.darkSurface.withOpacity(0.5)
                    : AppThemeV2.lightSurface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDark ? AppThemeV2.darkBorderSubtle : AppThemeV2.lightBorderSubtle,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    hasDirectory ? Icons.folder_rounded : Icons.folder_open_outlined,
                    color: hasDirectory
                        ? accentColor
                        : (isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      hasDirectory ? _formatPath(directory) : 'Drop folder here or browse...',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: hasDirectory
                            ? null
                            : (isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (hasDirectory)
                    Tooltip(
                      message: directory,
                      child: Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                        color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
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
                icon: const Icon(Icons.folder_open_rounded, size: 18),
                label: const Text('Browse'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(
                    color: accentColor.withOpacity(0.5),
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
            Icons.folder_copy_outlined,
            size: 64,
            color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? 'Select directories to start comparison',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isDark ? AppThemeV2.darkTextSecondary : AppThemeV2.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Drag & drop folders above or use the Browse buttons',
            style: theme.textTheme.bodySmall?.copyWith(
              color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
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
            Icons.error_outline_rounded,
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

  Widget _buildResultsList(BuildContext context, DirectoryComparisonSuccess state) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildPairedFilesSection(context, state.pairedFiles, state.comparisonResults),
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

  Widget _buildPairedFilesSection(
    BuildContext context,
    List<FilePair> pairs,
    Map<FilePair, ComparisonResult> results,
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
              Icon(Icons.link_rounded, size: 18, color: AppThemeV2.success),
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
          final added = result?.diff.values.where((d) => d.status == StringComparisonStatus.added).length ?? 0;
          final removed = result?.diff.values.where((d) => d.status == StringComparisonStatus.removed).length ?? 0;
          final modified = result?.diff.values.where((d) => d.status == StringComparisonStatus.modified).length ?? 0;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppThemeV2.darkSurface : AppThemeV2.lightSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? AppThemeV2.darkBorderSubtle : AppThemeV2.lightBorderSubtle,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: result != null ? AppThemeV2.success : AppThemeV2.warning,
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
                          color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                if (result != null) ...[
                  _StatChip(label: 'A', count: added, color: AppThemeV2.added),
                  const SizedBox(width: 4),
                  _StatChip(label: 'R', count: removed, color: AppThemeV2.removed),
                  const SizedBox(width: 4),
                  _StatChip(label: 'M', count: modified, color: AppThemeV2.modified),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => ComparisonResultDialog(result: result),
                      );
                    },
                    icon: const Icon(Icons.visibility_rounded, size: 16),
                    label: const Text('View'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ] else
                  Icon(
                    Icons.hourglass_empty_rounded,
                    size: 20,
                    color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
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
                color: isDark ? AppThemeV2.darkBorderSubtle : AppThemeV2.lightBorderSubtle,
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
                    onPressed: () => _showPairingDialog(context, file, availableToPair),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                      color: isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder,
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
                            ManuallyPairFile(sourceFile: sourceFile, targetFile: targetFile),
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
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      );
    }
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
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
        color: color.withOpacity(0.15),
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