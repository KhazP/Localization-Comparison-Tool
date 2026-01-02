import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/core/services/project_import_service.dart';
import 'package:localizer_app_main/data/repositories/project_repository.dart';

/// BLoC for managing project state.
/// 
/// Handles project creation, opening, closing, and validation.
/// Only one project can be open at a time.
class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository _projectRepository;
  final ProjectImportService _projectImportService;

  ProjectBloc({
    required ProjectRepository projectRepository,
    required ProjectImportService projectImportService,
  })  : _projectRepository = projectRepository,
        _projectImportService = projectImportService,
        super(ProjectState.initial()) {
    on<CreateProject>(_onCreateProject);
    on<OpenProject>(_onOpenProject);
    on<CloseProject>(_onCloseProject);
    on<ValidateCurrentProject>(_onValidateCurrentProject);
    on<LoadLastProject>(_onLoadLastProject);
    on<UpdateProjectSettings>(_onUpdateProjectSettings);
    on<UpdateProjectGlossary>(_onUpdateProjectGlossary);
    on<UpdateProjectTMs>(_onUpdateProjectTMs);
    on<ImportFilesToProject>(_onImportFilesToProject);
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

  /// Imports files into a project folder.
  Future<void> _onImportFilesToProject(
    ImportFilesToProject event,
    Emitter<ProjectState> emit,
  ) async {
    if (event.filePaths.isEmpty) return;

    try {
      final result = await _projectImportService.importFiles(
        projectRoot: event.projectPath,
        filePaths: event.filePaths,
      );

      final feedback = _buildImportFeedback(result);
      emit(state.copyWith(importFeedback: feedback));
    } on ProjectImportException catch (e) {
      emit(state.copyWith(
        importFeedback: ProjectImportFeedback(
          id: DateTime.now().millisecondsSinceEpoch,
          status: ProjectImportStatus.error,
          message: e.message,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        importFeedback: ProjectImportFeedback(
          id: DateTime.now().millisecondsSinceEpoch,
          status: ProjectImportStatus.error,
          message: 'Could not import the files. Please try again.',
        ),
      ));
      debugPrint('ProjectBloc: Error importing files: $e');
    }
  }

  ProjectImportFeedback _buildImportFeedback(ProjectImportResult result) {
    final parts = <String>[];

    if (result.importedCount > 0) {
      parts.add(
        'Imported ${result.importedCount} '
        'file${result.importedCount == 1 ? '' : 's'}.',
      );
    }
    if (result.skippedUnsupportedCount > 0) {
      parts.add(
        'Skipped ${result.skippedUnsupportedCount} not supported '
        'file${result.skippedUnsupportedCount == 1 ? '' : 's'}.',
      );
    }
    if (result.skippedInProjectCount > 0) {
      parts.add(
        'Skipped ${result.skippedInProjectCount} '
        'file${result.skippedInProjectCount == 1 ? '' : 's'} already '
        'in the project.',
      );
    }
    if (result.skippedMissingCount > 0) {
      parts.add(
        'Skipped ${result.skippedMissingCount} missing '
        'file${result.skippedMissingCount == 1 ? '' : 's'}.',
      );
    }
    if (result.failedCount > 0) {
      parts.add(
        '${result.failedCount} '
        'file${result.failedCount == 1 ? '' : 's'} could not be copied.',
      );
    }

    final message =
        parts.isEmpty ? 'No files were imported.' : parts.join(' ');

    final skippedCount = result.skippedUnsupportedCount +
        result.skippedMissingCount +
        result.skippedInProjectCount;

    final status = result.importedCount == 0
        ? (result.failedCount > 0
            ? ProjectImportStatus.error
            : ProjectImportStatus.warning)
        : (result.failedCount > 0 || skippedCount > 0
            ? ProjectImportStatus.warning
            : ProjectImportStatus.success);

    return ProjectImportFeedback(
      id: DateTime.now().millisecondsSinceEpoch,
      status: status,
      message: message,
    );
  }
}
