import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';

/// Dialog for creating a new Localizer project.
///
/// Allows the user to select a folder and enter a project name.
class CreateProjectDialog extends StatefulWidget {
  const CreateProjectDialog({super.key});

  /// Shows the create project dialog and returns the folder path if created.
  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => const CreateProjectDialog(),
    );
  }

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _selectedFolderPath;
  bool _isCreating = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickFolder() async {
    final result = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select Project Folder',
    );

    if (result != null) {
      setState(() {
        _selectedFolderPath = result;
        // Suggest a name based on folder if name is empty
        if (_nameController.text.isEmpty) {
          final folderName = result.split(RegExp(r'[/\\]')).last;
          _nameController.text = folderName;
        }
      });
    }
  }

  void _createProject() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedFolderPath == null) {
      ToastService.showWarning(context, 'Please select a project folder.');
      return;
    }

    setState(() => _isCreating = true);

    context.read<ProjectBloc>().add(CreateProject(
          folderPath: _selectedFolderPath!,
          projectName: _nameController.text.trim(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state.status == ProjectStatus.loaded) {
          Navigator.of(context).pop();
          ToastService.showSuccess(
            context,
            'Project "${state.currentProject!.name}" created successfully!',
          );
        } else if (state.status == ProjectStatus.error) {
          setState(() => _isCreating = false);
          ToastService.showError(
              context, state.errorMessage ?? 'Failed to create project.');
        }
      },
      child: AlertDialog(
        title: Row(
          children: [
            Icon(Icons.create_new_folder_outlined, color: colorScheme.primary),
            const SizedBox(width: 12),
            const Text('Create Project'),
          ],
        ),
        content: SizedBox(
          width: 400,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A project lets you save custom settings for a specific folder. '
                  'A ".localizer" folder will be created to store your project configuration.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 24),

                // Folder Selection
                Text(
                  'Project Folder',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _isCreating ? null : _pickFolder,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: colorScheme.outline),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _selectedFolderPath != null
                              ? Icons.folder
                              : Icons.folder_outlined,
                          color: _selectedFolderPath != null
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _selectedFolderPath ?? 'Click to select folder...',
                            style: TextStyle(
                              color: _selectedFolderPath != null
                                  ? colorScheme.onSurface
                                  : colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Project Name
                Text(
                  'Project Name',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  enabled: !_isCreating,
                  decoration: const InputDecoration(
                    hintText: 'e.g., My App Translations',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a project name';
                    }
                    if (value.trim().length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _createProject(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _isCreating ? null : () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: _isCreating ? null : _createProject,
            icon: _isCreating
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorScheme.onPrimary,
                    ),
                  )
                : const Icon(Icons.check, size: 18),
            label: Text(_isCreating ? 'Creating...' : 'Create Project'),
          ),
        ],
      ),
    );
  }
}
