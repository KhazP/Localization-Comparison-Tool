import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:localizer_app_main/data/models/project.dart';

part 'project_state.freezed.dart';

/// Status of the project state.
enum ProjectStatus {
  /// No project operations in progress.
  initial,

  /// Project is being loaded or created.
  loading,

  /// A project is currently open.
  loaded,

  /// An error occurred during project operations.
  error,
}

/// Feedback for a project import action.
enum ProjectImportStatus { success, warning, error }

/// One-time feedback message for project imports.
@freezed
class ProjectImportFeedback with _$ProjectImportFeedback {
  /// Creates a feedback message for project import.
  const factory ProjectImportFeedback({
    required int id,
    required ProjectImportStatus status,
    required String message,
  }) = _ProjectImportFeedback;
}

/// State for project management.
@freezed
class ProjectState with _$ProjectState {
  const ProjectState._();

  /// Creates a project state.
  const factory ProjectState({
    /// Current status of the project state.
    @Default(ProjectStatus.initial) ProjectStatus status,

    /// The currently open project, if any.
    Project? currentProject,

    /// Error message, if status is error.
    String? errorMessage,

    /// Latest import feedback message, if any.
    ProjectImportFeedback? importFeedback,
  }) = _ProjectState;

  /// Initial state with no project.
  factory ProjectState.initial() => const ProjectState();

  /// Loading state.
  factory ProjectState.loading() =>
      const ProjectState(status: ProjectStatus.loading);

  /// State with a loaded project.
  factory ProjectState.loaded(Project project) => ProjectState(
        status: ProjectStatus.loaded,
        currentProject: project,
      );

  /// Error state with a message.
  factory ProjectState.error(String message) => ProjectState(
        status: ProjectStatus.error,
        errorMessage: message,
      );

  /// Whether a project is currently open.
  bool get hasProject => currentProject != null;

  /// Convenience getter for project name.
  String? get projectName => currentProject?.name;
}
