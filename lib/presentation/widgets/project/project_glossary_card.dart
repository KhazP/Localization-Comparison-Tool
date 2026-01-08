import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/data/models/glossary_item.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
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
      title: context.t.projects.glossary.title,
      children: [
        SettingsDescription(
          context.t.projects.glossary.description,
        ),
        const SizedBox(height: 16),

        // List of terms
        if (project.glossary.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    size: 48,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.t.projects.glossary.noTerms,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.t.projects.glossary.noTermsDesc,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withValues(alpha: 0.7)),
                  ),
                ],
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
                    ? context.t.projects.glossary.doNotTranslate
                    : (item.preferredTranslation ??
                        context.t.projects.glossary.noSpecificTranslation)),
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
            label: Text(context.t.projects.glossary.addTerm),
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
          title: Text(isEditing
              ? context.t.projects.glossary.editTerm
              : context.t.projects.glossary.addTerm),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: termController,
                  decoration: InputDecoration(
                    labelText: context.t.projects.glossary.term,
                    hintText: context.t.projects.glossary.termHint,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: definitionController,
                  decoration: InputDecoration(
                    labelText: context.t.projects.glossary.definition,
                    hintText: context.t.projects.glossary.definitionHint,
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: Text(context.t.projects.glossary.doNotTranslateLabel),
                  subtitle:
                      Text(context.t.projects.glossary.doNotTranslateDesc),
                  value: forbidTranslation,
                  onChanged: (val) => setState(() => forbidTranslation = val),
                  contentPadding: EdgeInsets.zero,
                ),
                if (!forbidTranslation)
                  TextField(
                    controller: translationController,
                    decoration: InputDecoration(
                      labelText:
                          context.t.projects.glossary.preferredTranslation,
                    ),
                  ),
                SwitchListTile(
                  title: Text(context.t.projects.glossary.caseSensitive),
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
              child: Text(context.t.common.cancel),
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
              child: Text(context.t.common.save),
            ),
          ],
        ),
      ),
    );
  }
}
