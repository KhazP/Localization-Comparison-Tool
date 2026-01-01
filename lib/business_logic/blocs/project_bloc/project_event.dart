import 'package:equatable/equatable.dart';
import 'package:localizer_app_main/data/models/project_settings.dart';
import 'package:localizer_app_main/data/models/glossary_item.dart';
import 'package:localizer_app_main/data/models/translation_memory_reference.dart';

/// Base class for all project-related events.
abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object?> get props => [];
}

/// Event to create a new project in the specified folder.
class CreateProject extends ProjectEvent {
  final String folderPath;
  final String projectName;

  const CreateProject({
    required this.folderPath,
    required this.projectName,
  });

  @override
  List<Object?> get props => [folderPath, projectName];
}

/// Event to open an existing project from a folder.
class OpenProject extends ProjectEvent {
  final String folderPath;

  const OpenProject(this.folderPath);

  @override
  List<Object?> get props => [folderPath];
}

/// Event to close the current project.
class CloseProject extends ProjectEvent {
  const CloseProject();
}

/// Event to validate that the current project still exists.
class ValidateCurrentProject extends ProjectEvent {
  const ValidateCurrentProject();
}

/// Event to load the last opened project (auto-open).
class LoadLastProject extends ProjectEvent {
  const LoadLastProject();
}

/// Event to update project settings (save overrides).
class UpdateProjectSettings extends ProjectEvent {
  final ProjectSettings settings;

  const UpdateProjectSettings(this.settings);

  @override
  List<Object?> get props => [settings];
}

/// Event to update project glossary.
class UpdateProjectGlossary extends ProjectEvent {
  final List<GlossaryItem> glossary;

  const UpdateProjectGlossary(this.glossary);

  @override
  List<Object?> get props => [glossary];
}

/// Event to update project translation memories.
class UpdateProjectTMs extends ProjectEvent {
  final List<TranslationMemoryReference> translationMemories;

  const UpdateProjectTMs(this.translationMemories);

  @override
  List<Object?> get props => [translationMemories];
}
