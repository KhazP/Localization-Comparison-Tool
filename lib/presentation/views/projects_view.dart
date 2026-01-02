import 'dart:io';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:localizer_app_main/core/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/project/create_project_dialog.dart';
import 'package:localizer_app_main/presentation/widgets/dialogs/import_review_dialog.dart';
import 'package:localizer_app_main/presentation/widgets/common/empty_state_icon.dart';
import 'package:localizer_app_main/presentation/widgets/project/project_indicator.dart';
import 'package:localizer_app_main/core/services/project_sharing_service.dart';
import 'package:localizer_app_main/core/services/project_stats_service.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/core/utils/drag_drop_utils.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final settingsState = context.watch<SettingsBloc>().state;
    final recentProjects = settingsState.appSettings.recentProjects;

    return BlocListener<ProjectBloc, ProjectState>(
      listenWhen: (previous, current) =>
          current.importFeedback != null &&
          previous.importFeedback?.id != current.importFeedback?.id,
      listener: (context, state) {
        final feedback = state.importFeedback;
        if (feedback == null) return;

        switch (feedback.status) {
          case ProjectImportStatus.success:
            ToastService.showSuccess(context, feedback.message);
            break;
          case ProjectImportStatus.warning:
            ToastService.showWarning(context, feedback.message);
            break;
          case ProjectImportStatus.error:
            ToastService.showError(context, feedback.message);
            break;
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
           Row(
              children: [
                Icon(
                  Icons.folder_special_rounded,
                  size: 32,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Text(
                  'Projects',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Actions
            Row(
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.add_rounded,
                  label: 'Create New Project',
                  color: theme.colorScheme.primary,
                  onTap: () => _showCreateProjectDialog(context),
                ),
                const SizedBox(width: 16),
                _buildActionButton(
                  context,
                  icon: Icons.folder_open_rounded,
                  label: 'Open Project Settings',
                  isOutlined: true,
                  onTap: () => _pickProjectFolder(context),
                ),
                const SizedBox(width: 16),
                _buildActionButton(
                  context,
                  icon: Icons.file_upload_outlined,
                  label: 'Import Project Zip',
                  isOutlined: true,
                  onTap: () => _importProjectZip(context),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Recent Projects List
            Text(
              'Recent Projects',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            if (recentProjects.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EmptyStateIcon(
                        icon: Icons.history_edu_rounded,
                        text: 'No recent projects',
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No recent projects',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: isDark ? AppThemeV2.darkTextSecondary : AppThemeV2.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: recentProjects.length,
                  itemBuilder: (context, index) {
                    final path = recentProjects[index];
                    // Use folder name as project name fallback
                    final name = path.split(Platform.pathSeparator).last;
                    
                    return _ProjectListTile(
                      name: name,
                      path: path,
                      onTap: () => _openProject(context, path),
                      onRemove: () => _removeRecentProject(context, path),
                      onFilesDropped: (paths) =>
                          _importFilesToProject(context, path, paths),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
    bool isOutlined = false,
  }) {
    final theme = Theme.of(context);
    
    if (isOutlined) {
      return OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
    
    return FilledButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _showCreateProjectDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const CreateProjectDialog(),
    );
  }

  Future<void> _pickProjectFolder(BuildContext context) async {
    final folderPath = await DialogService.pickFolder();
    if (folderPath != null && context.mounted) {
      _openProject(context, folderPath);
    }
  }

  Future<void> _importProjectZip(BuildContext context) async {
     final result = await DialogService.pickFile(
      allowedExtensions: ['zip'],
      dialogTitle: 'Select Project Zip',
    );

    if (result != null && result.files.isNotEmpty && result.files.single.path != null && context.mounted) {
       final zipPath = result.files.single.path!;
       try {
         // Pick destination
         final destDir = await DialogService.pickFolder(
           dialogTitle: 'Select Destination Folder for Import',
         );
         
         if (destDir == null || !context.mounted) return;

         ToastService.showInfo(context, 'Importing project...');

         final sharingService = ProjectSharingService();
         final importResult = await sharingService.importProject(
            zipPath: zipPath,
            extractToPath: destDir,
         );

         if (!context.mounted) return;

         final accepted = await showDialog<bool>(
          context: context,
          builder: (context) => ImportReviewDialog(
            project: importResult.project,
            historyItemCount: importResult.history.length,
          ),
        );

        if (accepted == true && context.mounted) {
           // Import History if present
           if (importResult.history.isNotEmpty) {
             context.read<HistoryBloc>().add(ImportHistory(importResult.history));
           }

           // Open Project
           _openProject(context, importResult.project.rootPath);
           ToastService.showSuccess(context, 'Project imported successfully');
        }
       } catch (e) {
         ToastService.showError(context, 'Import failed: $e');
       }
    }
  }

  void _openProject(BuildContext context, String path) {
    context.read<ProjectBloc>().add(OpenProject(path));
    // Also update settings to move this to top of recent list
     final settingsBloc = context.read<SettingsBloc>();
     final currentRecent = List<String>.from(settingsBloc.state.appSettings.recentProjects);
     
     currentRecent.remove(path);
     currentRecent.insert(0, path); // Add to top
     
     // Limit to 10
     if (currentRecent.length > 10) {
       currentRecent.removeRange(10, currentRecent.length);
     }
     
     settingsBloc.add(UpdateRecentProjects(currentRecent));
  }

  void _removeRecentProject(BuildContext context, String path) {
     final settingsBloc = context.read<SettingsBloc>();
     final recentProjects = List<String>.from(settingsBloc.state.appSettings.recentProjects);
     
     recentProjects.remove(path);
     
     settingsBloc.add(UpdateRecentProjects(recentProjects));
  }

  void _importFilesToProject(
    BuildContext context,
    String projectPath,
    List<String> filePaths,
  ) {
    if (filePaths.isEmpty) {
      ToastService.showWarning(context, 'No supported files were dropped.');
      return;
    }

    ToastService.showInfo(context, 'Importing files...');
    context.read<ProjectBloc>().add(
          ImportFilesToProject(
            projectPath: projectPath,
            filePaths: filePaths,
          ),
        );
  }
}

class _ProjectListTile extends StatefulWidget {
  final String name;
  final String path;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final void Function(List<String> filePaths)? onFilesDropped;

  const _ProjectListTile({
    required this.name,
    required this.path,
    required this.onTap,
    required this.onRemove,
    this.onFilesDropped,
  });

  @override
  State<_ProjectListTile> createState() => _ProjectListTileState();
}

class _ProjectListTileState extends State<_ProjectListTile> {
  bool _isHovered = false;
  bool _isDragOver = false;
  ProjectStats? _stats;
  bool _loadingStats = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final service = ProjectStatsService();
    final stats = await service.getStats(widget.path);
    if (mounted) {
      setState(() {
        _stats = stats;
        _loadingStats = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Check if AMOLED
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = isDark && 
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    final cardColor = isAmoled 
        ? AppThemeV2.amoledCard 
        : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard);
        
    final hoverColor = isAmoled
        ? AppThemeV2.amoledCardHover
        : (isDark ? AppThemeV2.darkCardHover : AppThemeV2.lightCardHover);

    return DropRegion(
      formats: Formats.standardFormats,
      onDropOver: (event) async {
        for (final item in event.session.items) {
          final localData = item.localData;
          if (localData is String &&
              DragDropUtils.isValidFilePath(localData)) {
            setState(() => _isDragOver = true);
            return DropOperation.copy;
          }

          final reader = item.dataReader;
          if (reader == null) continue;
          final suggestedName = await reader.getSuggestedName();
          if (DragDropUtils.isValidFileName(suggestedName)) {
            setState(() => _isDragOver = true);
            return DropOperation.copy;
          }
        }
        setState(() => _isDragOver = false);
        return DropOperation.none;
      },
      onDropLeave: (_) => setState(() => _isDragOver = false),
      onPerformDrop: (event) async {
        setState(() => _isDragOver = false);
        final List<String> paths = [];
        for (final item in event.session.items) {
          final localData = item.localData;
          if (localData is String &&
              DragDropUtils.isValidFilePath(localData)) {
            paths.add(localData);
            continue;
          }

          final reader = item.dataReader;
          if (reader == null) continue;
          if (reader.canProvide(Formats.fileUri)) {
            reader.getValue<Uri>(Formats.fileUri, (uri) {
              if (uri != null) {
                final path = uri.toFilePath();
                if (DragDropUtils.isValidFilePath(path)) {
                  paths.add(path);
                }
              }
            });
          }
        }
        // Delay to let async getValue complete
        await Future.delayed(const Duration(milliseconds: 150));
        final uniquePaths = paths.toSet().toList();
        if (uniquePaths.isNotEmpty && widget.onFilesDropped != null) {
          widget.onFilesDropped!(uniquePaths);
        }
      },
      child: MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _isHovered ? hoverColor : cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isDragOver
                  ? theme.colorScheme.secondary
                  : _isHovered 
                      ? theme.colorScheme.primary.withAlpha(100)
                      : (isAmoled ? AppThemeV2.amoledBorder : theme.dividerColor),
              width: _isDragOver ? 2 : 1,
            ),
             boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withAlpha(isDark ? 50 : 20),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.folder_shared_rounded,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Stats row
                    if (_loadingStats)
                      SizedBox(
                        height: 14,
                        width: 100,
                        child: LinearProgressIndicator(
                          backgroundColor: theme.colorScheme.primary.withAlpha(20),
                          minHeight: 2,
                        ),
                      )
                    else if (_stats != null)
                      Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            size: 12,
                            color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              _stats!.displayString,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isDark ? AppThemeV2.darkTextSecondary : AppThemeV2.lightTextSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 2),
                    Text(
                      widget.path,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
                        fontFamily: 'Consolas', 
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (_isHovered)
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 20),
                  onPressed: widget.onRemove,
                  tooltip: 'Remove from recent',
                ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

