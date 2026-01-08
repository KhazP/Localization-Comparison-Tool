import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/data/models/project.dart';
import 'package:localizer_app_main/data/repositories/project_repository.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:localizer_app_main/presentation/widgets/project/create_project_dialog.dart';
import 'package:localizer_app_main/core/services/project_sharing_service.dart';
import 'package:localizer_app_main/presentation/widgets/dialogs/import_review_dialog.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';

/// Dialog that shows recent projects and allows opening/creating new ones.
class ProjectSelectionDialog extends StatefulWidget {
  const ProjectSelectionDialog({super.key});

  @override
  State<ProjectSelectionDialog> createState() => _ProjectSelectionDialogState();
}

class _ProjectSelectionDialogState extends State<ProjectSelectionDialog> {
  List<Project>? _recentProjects;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecentProjects();
  }

  Future<void> _loadRecentProjects() async {
    try {
      final repository = sl<ProjectRepository>();
      final projects = await repository.getRecentProjects();
      if (mounted) {
        setState(() {
          _recentProjects = projects;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _recentProjects = [];
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _pickAndOpenProject() async {
    final String? selectedDirectory =
        await FilePicker.platform.getDirectoryPath(
      dialogTitle: context.t.projects.selection.selectFolder,
      lockParentWindow: true,
    );

    if (selectedDirectory != null && mounted) {
      context.read<ProjectBloc>().add(OpenProject(selectedDirectory));
      Navigator.pop(context);
    }
  }

  Future<void> _importProject() async {
    // 1. Pick Zip
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
      dialogTitle: context.t.projects.selection.selectArchive,
    );

    if (result == null || result.files.single.path == null) return;
    final zipPath = result.files.single.path!;

    if (!mounted) return;

    // 2. Pick Destination
    final destDir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: context.t.projects.selectDestination,
      lockParentWindow: true,
    );

    if (destDir == null) return;
    if (!mounted) return;

    try {
      ToastService.showInfo(context, context.t.projects.importing);

      final sharingService = ProjectSharingService();
      // 3. Unzip & Validate
      final importResult = await sharingService.importProject(
        zipPath: zipPath,
        extractToPath: destDir,
      );

      if (!mounted) return;

      // 4. Review
      final accepted = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => ImportReviewDialog(
          project: importResult.project,
          historyItemCount: importResult.history.length,
        ),
      );

      if (accepted == true && mounted) {
        // 5. Import History
        if (importResult.history.isNotEmpty) {
          context.read<HistoryBloc>().add(ImportHistory(importResult.history));
        }

        // 6. Open Project
        context
            .read<ProjectBloc>()
            .add(OpenProject(importResult.project.rootPath));

        if (mounted) {
          Navigator.pop(context); // Close selection dialog
          ToastService.showSuccess(context, context.t.projects.importSuccess);
        }
      }
    } catch (e) {
      if (mounted) {
        ToastService.showError(
            context, context.t.projects.importFailed(error: e));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: Text(context.t.projects.selection.openProject),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isLoading)
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ))
            else if (_recentProjects != null &&
                _recentProjects!.isNotEmpty) ...[
              Text(
                context.t.projects.recentProjects,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _recentProjects!.length,
                  itemBuilder: (context, index) {
                    final project = _recentProjects![index];
                    return ListTile(
                      leading: const Icon(Icons.folder_outlined),
                      title: Text(project.name),
                      subtitle: Text(
                        project.rootPath,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        context
                            .read<ProjectBloc>()
                            .add(OpenProject(project.rootPath));
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    );
                  },
                ),
              ),
              const Divider(height: 24),
            ] else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Text(context.t.projects.noRecentProjects),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickAndOpenProject,
                    icon: const Icon(Icons.folder_open),
                    label: Text(context.t.projects.selection.browseFolder),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      CreateProjectDialog.show(context);
                    },
                    icon: const Icon(Icons.create_new_folder),
                    label: Text(context.t.projects.selection.createNew),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _importProject,
                icon: const Icon(Icons.unarchive),
                label: Text(context.t.projects.selection.importFromZip),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.t.common.cancel),
        ),
      ],
    );
  }
}
