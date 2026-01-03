import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/data/models/glossary_item.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings.dart';
import 'package:localizer_app_main/core/services/dialog_service.dart';
import 'package:uuid/uuid.dart';

class ProjectGlossaryCard extends StatelessWidget {
  const ProjectGlossaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final projectState = context.watch<ProjectBloc>().state;
    final project = projectState.currentProject;

    if (project == null) return const SizedBox.shrink();

    return SettingsCard(
      title: 'Project Glossary',
      children: [
        const SettingsDescription(
          'Define terms that should be treated consistently or never translated.',
        ),
        const SizedBox(height: 16),

        // List of terms
        if (project.glossary.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'No glossary terms yet.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: project.glossary.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = project.glossary[index];
              return ListTile(
                title: Text(item.term),
                subtitle: Text(item.forbidTranslation
                    ? 'Do not translate'
                    : (item.preferredTranslation ?? 'No specific translation')),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _deleteTerm(context, item.id),
                ),
                onTap: () => _editTerm(context, item),
              );
            },
          ),

        const SizedBox(height: 16),
        Center(
          child: FilledButton.icon(
            onPressed: () => _addTerm(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Term'),
          ),
        ),
      ],
    );
  }

  void _addTerm(BuildContext context) async {
    final newItem = await _showGlossaryDialog(context);
    if (newItem != null && context.mounted) {
      final projectBloc = context.read<ProjectBloc>();
      final currentProject = projectBloc.state.currentProject;
      if (currentProject != null) {
        final updatedGlossary = List<GlossaryItem>.from(currentProject.glossary)
          ..add(newItem);
        projectBloc.add(UpdateProjectGlossary(updatedGlossary));
      }
    }
  }

  void _editTerm(BuildContext context, GlossaryItem item) async {
    final updatedItem = await _showGlossaryDialog(context, item: item);
    if (updatedItem != null && context.mounted) {
      final projectBloc = context.read<ProjectBloc>();
      final currentProject = projectBloc.state.currentProject;
      if (currentProject != null) {
        final updatedGlossary = currentProject.glossary.map((g) {
          return g.id == item.id ? updatedItem : g;
        }).toList();
        projectBloc.add(UpdateProjectGlossary(updatedGlossary));
      }
    }
  }

  void _deleteTerm(BuildContext context, String id) {
    final projectBloc = context.read<ProjectBloc>();
    final currentProject = projectBloc.state.currentProject;
    if (currentProject != null) {
      final updatedGlossary = List<GlossaryItem>.from(currentProject.glossary)
        ..removeWhere((g) => g.id == id);
      projectBloc.add(UpdateProjectGlossary(updatedGlossary));
    }
  }

  Future<GlossaryItem?> _showGlossaryDialog(BuildContext context,
      {GlossaryItem? item}) {
    final isEditing = item != null;
    final termController = TextEditingController(text: item?.term);
    final definitionController = TextEditingController(text: item?.definition);
    final translationController =
        TextEditingController(text: item?.preferredTranslation);
    bool forbidTranslation = item?.forbidTranslation ?? true;
    bool caseSensitive = item?.caseSensitive ?? false;

    return showDialog<GlossaryItem>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(isEditing ? 'Edit Term' : 'Add Term'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: termController,
                  decoration: const InputDecoration(
                    labelText: 'Term',
                    hintText: 'e.g., brand name, specialized term',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: definitionController,
                  decoration: const InputDecoration(
                    labelText: 'Definition (Optional)',
                    hintText: 'Context for the translator',
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Do Not Translate'),
                  subtitle: const Text('Keep term exactly as is in target'),
                  value: forbidTranslation,
                  onChanged: (val) => setState(() => forbidTranslation = val),
                  contentPadding: EdgeInsets.zero,
                ),
                if (!forbidTranslation)
                  TextField(
                    controller: translationController,
                    decoration: const InputDecoration(
                      labelText: 'Preferred Translation',
                    ),
                  ),
                SwitchListTile(
                  title: const Text('Case Sensitive'),
                  value: caseSensitive,
                  onChanged: (val) => setState(() => caseSensitive = val),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (termController.text.isEmpty) return;

                final newItem = GlossaryItem(
                  id: item?.id ?? const Uuid().v4(),
                  term: termController.text,
                  definition: definitionController.text,
                  caseSensitive: caseSensitive,
                  forbidTranslation: forbidTranslation,
                  preferredTranslation:
                      forbidTranslation ? null : translationController.text,
                );
                Navigator.pop(context, newItem);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
