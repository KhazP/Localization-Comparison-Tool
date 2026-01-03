import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/data/models/translation_memory_reference.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings.dart';
import 'package:localizer_app_main/core/services/dialog_service.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/core/services/dialog_service.dart';

class ProjectTranslationMemoryCard extends StatelessWidget {
  const ProjectTranslationMemoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final projectState = context.watch<ProjectBloc>().state;
    final project = projectState.currentProject;

    if (project == null) return const SizedBox.shrink();

    return SettingsCard(
      title: 'Translation Memory',
      children: [
        const SettingsDescription(
          'Select Translation Memory (TM) files to reuse past translations.',
        ),
        const SizedBox(height: 16),
        if (project.translationMemories.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'No Translation Memories selected.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          )
        else
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
            label: const Text('Add TM File'),
          ),
        ),
      ],
    );
  }

  void _addTM(BuildContext context) async {
    final file = await DialogService.pickFile(
      allowedExtensions: ['tmx', 'json', 'xml'],
      dialogTitle: 'Select Translation Memory',
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
}
