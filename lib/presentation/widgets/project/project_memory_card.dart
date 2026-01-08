import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/data/models/translation_memory_reference.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings.dart';
import 'package:localizer_app_main/core/services/dialog_service.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/core/services/dialog_service.dart';
import 'package:localizer_app_main/presentation/widgets/settings/global_translation_memory_card.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/services/translation_memory_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';

class ProjectTranslationMemoryCard extends StatelessWidget {
  final TranslationMemoryService? translationMemoryService;
  final Future<TranslationMemoryStats>? translationMemoryStatsFuture;
  final VoidCallback onRefreshStats;
  final AppSettings settings;
  final bool isDark;
  final bool isAmoled;

  const ProjectTranslationMemoryCard({
    super.key,
    this.translationMemoryService,
    this.translationMemoryStatsFuture,
    required this.onRefreshStats,
    required this.settings,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  Widget build(BuildContext context) {
    final projectState = context.watch<ProjectBloc>().state;
    final project = projectState.currentProject;

    if (project == null) return const SizedBox.shrink();

    return Column(
      children: [
        SettingsCard(
          title: context.t.projects.tm.title,
          children: [
            SettingsDescription(
              context.t.projects.tm.description,
            ),
            const SizedBox(height: 16),
            // Global TM Toggle
            SwitchListTile(
              title: Text(context.t.projects.tm.globalTm),
              subtitle: Text(context.t.projects.tm.globalTmDescription),
              value: settings.enableTranslationMemory,
              onChanged: (val) {
                context
                    .read<SettingsBloc>()
                    .add(UpdateEnableTranslationMemory(val));
              },
              secondary: const Icon(Icons.public),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              context.t.projects.tm.linkedFiles,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            if (project.translationMemories.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.history_edu,
                        size: 48,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        context.t.projects.tm.noLinkedFiles,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 16),
                      // Only show "Add TM File" if lists are empty
                      FilledButton.icon(
                        onPressed: () => _addTM(context),
                        icon: const Icon(Icons.add),
                        label: Text(context.t.projects.tm.addTmFile),
                      ),
                      // If Global TM is NOT enabled, show the suggestion button
                      if (!settings.enableTranslationMemory) ...[
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () => _enableGlobalTM(context),
                          icon: const Icon(Icons.public),
                          label: Text(context.t.projects.tm.useGlobalTm),
                        ),
                      ],
                    ],
                  ),
                ),
              )
            else ...[
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: project.translationMemories.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final tm = project.translationMemories[index];
                  return SwitchListTile(
                    title: Text(tm.name),
                    subtitle: Text(tm.path),
                    value: tm.isEnabled,
                    onChanged: (val) => _toggleTM(context, tm, val),
                    secondary: const Icon(Icons.history_edu),
                  );
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: FilledButton.icon(
                  onPressed: () => _addTM(context),
                  icon: const Icon(Icons.add),
                  label: Text(context.t.projects.tm.addTmFile),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  void _addTM(BuildContext context) async {
    final file = await DialogService.pickFile(
      allowedExtensions: ['tmx', 'json', 'xml'],
      dialogTitle: context.t.projects.tm.selectTm,
    );

    if (file != null &&
        file.files.isNotEmpty &&
        file.files.single.path != null &&
        context.mounted) {
      final path = file.files.single.path!;
      final name = path.split(Platform.pathSeparator).last;
      final extension = file.files.single.extension ?? '';
      final newTM = TranslationMemoryReference(
        id: const Uuid().v4(),
        name: name,
        path: path,
        type: extension.toLowerCase().replaceAll('.', ''),
      );

      final projectBloc = context.read<ProjectBloc>();
      final currentProject = projectBloc.state.currentProject;
      if (currentProject != null) {
        final updatedTMs = List<TranslationMemoryReference>.from(
            currentProject.translationMemories)
          ..add(newTM);
        projectBloc.add(UpdateProjectTMs(updatedTMs));
      }
    }
  }

  void _toggleTM(
      BuildContext context, TranslationMemoryReference tm, bool isEnabled) {
    final projectBloc = context.read<ProjectBloc>();
    final currentProject = projectBloc.state.currentProject;
    if (currentProject != null) {
      final updatedTMs = currentProject.translationMemories.map((t) {
        return t.id == tm.id ? t.copyWith(isEnabled: isEnabled) : t;
      }).toList();
      projectBloc.add(UpdateProjectTMs(updatedTMs));
    }
  }

  void _enableGlobalTM(BuildContext context) {
    context.read<SettingsBloc>().add(const UpdateEnableTranslationMemory(true));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.t.projects.tm.globalTmEnabled),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
