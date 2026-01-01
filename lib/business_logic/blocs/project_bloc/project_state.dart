import 'package:equatable/equatable.dart';
import 'package:localizer_app_main/data/models/project.dart';

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

/// State for project management.
class ProjectState extends Equatable {
  /// Current status of the project state.
  final ProjectStatus status;
  
  /// The currently open project, if any.
  final Project? currentProject;
  
  /// Error message, if status is error.
  final String? errorMessage;

  const ProjectState({
    this.status = ProjectStatus.initial,
    this.currentProject,
    this.errorMessage,
  });

  /// Initial state with no project.
  factory ProjectState.initial() => const ProjectState();

  /// Loading state.
  factory ProjectState.loading() => const ProjectState(status: ProjectStatus.loading);

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

  ProjectState copyWith({
    ProjectStatus? status,
    Project? currentProject,
    String? errorMessage,
    bool clearProject = false,
    bool clearError = false,
  }) {
    return ProjectState(
      status: status ?? this.status,
      currentProject: clearProject ? null : (currentProject ?? this.currentProject),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, currentProject, errorMessage];
}
