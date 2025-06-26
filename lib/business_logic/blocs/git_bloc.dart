import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/data/services/git_service.dart';

// Events
abstract class GitEvent {}

class SelectRepository extends GitEvent {
  final String path;
  SelectRepository(this.path);
}

class LoadBranches extends GitEvent {
  // final String repoPath; // Or get from state
}

class CompareBranches extends GitEvent {
  final String baseBranch;
  final String targetBranch;
  CompareBranches(this.baseBranch, this.targetBranch);
}

// States
abstract class GitState {}

class GitInitial extends GitState {}

class GitRepositorySelected extends GitState {
  final String repoPath;
  final bool isValid;
  GitRepositorySelected(this.repoPath, this.isValid);
}

class GitLoading extends GitState {
  final String repoPath; // Keep repoPath for context
  GitLoading(this.repoPath);
}

class GitBranchesLoaded extends GitState {
  final String repoPath;
  final List<GitBranch> branches;
  GitBranchesLoaded(this.repoPath, this.branches);
}

class GitComparisonInProgress extends GitState {
    final String repoPath;
    GitComparisonInProgress(this.repoPath);
}

class GitComparisonResult extends GitState {
  final String repoPath;
  final List<GitDiffFile> diffFiles;
  // final File baseFileContent; // For showing actual diff - more complex
  // final File targetFileContent;
  GitComparisonResult(this.repoPath, this.diffFiles);
}

class GitError extends GitState {
  final String? repoPath; // repoPath might not be set if error is early
  final String message;
  GitError(this.message, {this.repoPath});
}

// BLoC
class GitBloc extends Bloc<GitEvent, GitState> {
  final GitService gitService;
  String? _currentRepoPath;

  GitBloc({required this.gitService}) : super(GitInitial()) {
    on<SelectRepository>(_onSelectRepository);
    on<LoadBranches>(_onLoadBranches);
    on<CompareBranches>(_onCompareBranches);
  }

  Future<void> _onSelectRepository(SelectRepository event, Emitter<GitState> emit) async {
    // No loading state here, it's a quick check
    try {
      final isValid = await gitService.isValidRepository(event.path);
      if (isValid) {
        _currentRepoPath = event.path;
        emit(GitRepositorySelected(event.path, true));
        add(LoadBranches()); // Auto-load branches on valid selection
      } else {
        _currentRepoPath = null;
        emit(GitRepositorySelected(event.path, false));
      }
    } catch (e) {
      _currentRepoPath = null;
      emit(GitError('Error validating repository: ${e.toString()}', repoPath: event.path));
    }
  }

  Future<void> _onLoadBranches(LoadBranches event, Emitter<GitState> emit) async {
    if (_currentRepoPath == null) {
      emit(GitError('No repository selected to load branches from.'));
      return;
    }
    emit(GitLoading(_currentRepoPath!));
    try {
      final branches = await gitService.getBranches(_currentRepoPath!);
      emit(GitBranchesLoaded(_currentRepoPath!, branches));
    } catch (e) {
      emit(GitError('Failed to load branches: ${e.toString()}', repoPath: _currentRepoPath));
    }
  }

  Future<void> _onCompareBranches(CompareBranches event, Emitter<GitState> emit) async {
    if (_currentRepoPath == null) {
      emit(GitError('No repository selected for branch comparison.'));
      return;
    }
    emit(GitComparisonInProgress(_currentRepoPath!));
    try {
      final diffFiles = await gitService.compareBranches(_currentRepoPath!, event.baseBranch, event.targetBranch);
      // For MVP, we just get the list of changed files.
      // A full diff view would require fetching content of each file from both branches.
      emit(GitComparisonResult(_currentRepoPath!, diffFiles));
    } catch (e) {
      emit(GitError('Failed to compare branches: ${e.toString()}', repoPath: _currentRepoPath));
    }
  }
} 