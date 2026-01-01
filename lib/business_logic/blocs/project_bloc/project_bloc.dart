import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/data/repositories/project_repository.dart';

/// BLoC for managing project state.
/// 
/// Handles project creation, opening, closing, and validation.
/// Only one project can be open at a time.
class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository _projectRepository;

  ProjectBloc({
    required ProjectRepository projectRepository,
  })  : _projectRepository = projectRepository,
        super(ProjectState.initial()) {
    on<CreateProject>(_onCreateProject);
    on<OpenProject>(_onOpenProject);
    on<CloseProject>(_onCloseProject);
    on<ValidateCurrentProject>(_onValidateCurrentProject);
    on<LoadLastProject>(_onLoadLastProject);
    on<UpdateProjectSettings>(_onUpdateProjectSettings);
    on<UpdateProjectGlossary>(_onUpdateProjectGlossary);
    on<UpdateProjectTMs>(_onUpdateProjectTMs);
  }

  /// Handles project creation.
  Future<void> _onCreateProject(
    CreateProject event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectState.loading());

    try {
      final project = await _projectRepository.createProject(
        folderPath: event.folderPath,
        projectName: event.projectName,
      );
      emit(ProjectState.loaded(project));
      debugPrint('ProjectBloc: Created project "${project.name}"');
    } on ProjectCreationException catch (e) {
      emit(ProjectState.error(e.message));
    } catch (e) {
      emit(ProjectState.error(
        'Something went wrong while creating the project. Please try again.',
      ));
      debugPrint('ProjectBloc: Unexpected error creating project: $e');
    }
  }

  /// Handles opening an existing project.
  Future<void> _onOpenProject(
    OpenProject event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectState.loading());

    try {
      final project = await _projectRepository.openProject(event.folderPath);
      
      if (project != null) {
        emit(ProjectState.loaded(project));
        debugPrint('ProjectBloc: Opened project "${project.name}"');
      } else {
        emit(ProjectState.error(
          'No project found in this folder. '
          'Would you like to create a new project here?',
        ));
      }
    } on ProjectLoadException catch (e) {
      emit(ProjectState.error(e.message));
    } catch (e) {
      emit(ProjectState.error(
        'Something went wrong while opening the project. Please try again.',
      ));
      debugPrint('ProjectBloc: Unexpected error opening project: $e');
    }
  }

  /// Handles closing the current project.
  Future<void> _onCloseProject(
    CloseProject event,
    Emitter<ProjectState> emit,
  ) async {
    if (state.currentProject != null) {
      debugPrint('ProjectBloc: Closed project "${state.currentProject!.name}"');
    }
    emit(ProjectState.initial());
  }

  /// Validates that the current project still exists on disk.
  Future<void> _onValidateCurrentProject(
    ValidateCurrentProject event,
    Emitter<ProjectState> emit,
  ) async {
    final project = state.currentProject;
    if (project == null) return;

    final isValid = await _projectRepository.validateProject(project);
    
    if (!isValid) {
      emit(ProjectState.error(
        'The project folder has been moved or deleted. '
        'Please open the project from its new location.',
      ));
      debugPrint('ProjectBloc: Project "${project.name}" no longer valid');
    }
  }

  /// Updates project settings and saves to disk.
  Future<void> _onUpdateProjectSettings(
    UpdateProjectSettings event,
    Emitter<ProjectState> emit,
  ) async {
    final project = state.currentProject;
    if (project == null) return;

    try {
      // Create updated project with new settings
      final updatedProject = project.copyWith(settings: event.settings);
      
      // Save to disk
      await _projectRepository.saveProject(updatedProject);
      
      // Update state
      emit(state.copyWith(currentProject: updatedProject));
      debugPrint('ProjectBloc: Saved settings for "${project.name}"');
    } catch (e) {
      debugPrint('ProjectBloc: Error saving project settings: $e');
      // The settings were already applied in memory
    }
  }


  /// Updates project glossary and saves to disk.
  Future<void> _onUpdateProjectGlossary(
    UpdateProjectGlossary event,
    Emitter<ProjectState> emit,
  ) async {
    final project = state.currentProject;
    if (project == null) return;

    try {
      final updatedProject = project.copyWith(glossary: event.glossary);
      await _projectRepository.saveProject(updatedProject);
      emit(state.copyWith(currentProject: updatedProject));
      debugPrint('ProjectBloc: Saved glossary for "${project.name}"');
    } catch (e) {
      debugPrint('ProjectBloc: Error saving project glossary: $e');
    }
  }

  /// Updates project translation memories and saves to disk.
  Future<void> _onUpdateProjectTMs(
    UpdateProjectTMs event,
    Emitter<ProjectState> emit,
  ) async {
    final project = state.currentProject;
    if (project == null) return;

    try {
      final updatedProject = project.copyWith(translationMemories: event.translationMemories);
      await _projectRepository.saveProject(updatedProject);
      emit(state.copyWith(currentProject: updatedProject));
      debugPrint('ProjectBloc: Saved TMs for "${project.name}"');
    } catch (e) {
      debugPrint('ProjectBloc: Error saving project TMs: $e');
    }
  }

  /// Attempts to load the last opened project path and open it.
  Future<void> _onLoadLastProject(
    LoadLastProject event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      final lastPath = await _projectRepository.getLastProjectPath();
      if (lastPath != null) {
        debugPrint('ProjectBloc: Found last project at $lastPath. Opening...');
        add(OpenProject(lastPath));
      }
    } catch (e) {
      debugPrint('ProjectBloc: Failed to load last project path: $e');
    }
  }
}
