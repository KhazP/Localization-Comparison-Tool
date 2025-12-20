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

class SwitchComparisonMode extends GitEvent {
  final ComparisonMode mode;
  SwitchComparisonMode(this.mode);
}

class LoadCommits extends GitEvent {
  final String? branchName; // Optional filter
  final int limit;
  LoadCommits({this.branchName, this.limit = 50});
}

class CompareBranches extends GitEvent {
  final String baseBranch;
  final String targetBranch;
  CompareBranches(this.baseBranch, this.targetBranch);
}

class CompareCommits extends GitEvent {
  final String baseSha;
  final String targetSha;
  CompareCommits(this.baseSha, this.targetSha);
}

// States
enum ComparisonMode { branch, commit }

abstract class GitState {
  String? get repoPath;
}

class GitInitial extends GitState {
  @override
  String? get repoPath => null;
}

class GitRepositorySelected extends GitState {
  @override
  final String repoPath;
  final bool isValid;
  GitRepositorySelected(this.repoPath, this.isValid);
}

class GitLoading extends GitState {
  @override
  final String repoPath; // Keep repoPath for context
  GitLoading(this.repoPath);
}

class GitBranchesLoaded extends GitState {
  @override
  final String repoPath;
  final List<GitBranch> branches;
  final ComparisonMode mode;
  // Cache for commits - specific to Commit Mode
  final List<GitCommit> commits;
  final bool isLoadingCommits;

  GitBranchesLoaded(
    this.repoPath, 
    this.branches, {
    this.mode = ComparisonMode.branch,
    this.commits = const [],
    this.isLoadingCommits = false,
  });

  GitBranchesLoaded copyWith({
    String? repoPath,
    List<GitBranch>? branches,
    ComparisonMode? mode,
    List<GitCommit>? commits,
    bool? isLoadingCommits,
  }) {
    return GitBranchesLoaded(
      repoPath ?? this.repoPath,
      branches ?? this.branches,
      mode: mode ?? this.mode,
      commits: commits ?? this.commits,
      isLoadingCommits: isLoadingCommits ?? this.isLoadingCommits,
    );
  }
}

class GitComparisonInProgress extends GitState {
    @override
    final String repoPath;
    GitComparisonInProgress(this.repoPath);
}

class GitComparisonResult extends GitState {
  @override
  final String repoPath;
  final List<GitDiffFile> diffFiles;
  final String base; // Branch Name or Commit SHA
  final String target; // Branch Name or Commit SHA
  final ComparisonMode mode;

  GitComparisonResult(this.repoPath, this.diffFiles, this.base, this.target, {this.mode = ComparisonMode.branch});
}

class GitError extends GitState {
  @override
  final String? repoPath; // repoPath might not be set if error is early
  final String message;
  GitError(this.message, {this.repoPath});
}

// BLoC
class GitBloc extends Bloc<GitEvent, GitState> {
  final GitService gitService;
  String? _currentRepoPath;
  
  // Internal cache to persist state during mode switches if needed
  List<GitBranch> _cachedBranches = [];
  List<GitCommit> _cachedCommits = [];
  ComparisonMode _currentMode = ComparisonMode.branch;

  GitBloc({required this.gitService}) : super(GitInitial()) {
    on<SelectRepository>(_onSelectRepository);
    on<LoadBranches>(_onLoadBranches);
    on<SwitchComparisonMode>(_onSwitchComparisonMode);
    on<LoadCommits>(_onLoadCommits);
    on<CompareBranches>(_onCompareBranches);
    on<CompareCommits>(_onCompareCommits);
  }

  Future<void> _onSelectRepository(SelectRepository event, Emitter<GitState> emit) async {
    // Reset caches on new repo
    _cachedBranches = [];
    _cachedCommits = [];
    _currentMode = ComparisonMode.branch;

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
      _cachedBranches = branches;
      emit(GitBranchesLoaded(_currentRepoPath!, branches, mode: _currentMode, commits: _cachedCommits));
    } catch (e) {
      emit(GitError('Failed to load branches: ${e.toString()}', repoPath: _currentRepoPath));
    }
  }

  void _onSwitchComparisonMode(SwitchComparisonMode event, Emitter<GitState> emit) {
    if (_currentRepoPath == null) return;
    _currentMode = event.mode;
    
    // If switching to commit mode and we don't have commits, load them
    if (_currentMode == ComparisonMode.commit && _cachedCommits.isEmpty) {
      add(LoadCommits());
    }

    // Re-emit Loaded state with new mode
    emit(GitBranchesLoaded(_currentRepoPath!, _cachedBranches, mode: _currentMode, commits: _cachedCommits));
  }

  Future<void> _onLoadCommits(LoadCommits event, Emitter<GitState> emit) async {
    if (_currentRepoPath == null) return;
    
    // Emit loading state for commits specifically - preserve existing branches/mode
    emit(GitBranchesLoaded(
      _currentRepoPath!, 
      _cachedBranches, 
      mode: _currentMode, 
      commits: _cachedCommits, 
      isLoadingCommits: true
    ));

    try {
      final commits = await gitService.getCommits(_currentRepoPath!, branchName: event.branchName, limit: event.limit);
      _cachedCommits = commits;
      emit(GitBranchesLoaded(
        _currentRepoPath!, 
        _cachedBranches, 
        mode: _currentMode, 
        commits: commits, 
        isLoadingCommits: false
      ));
    } catch (e) {
      // Don't error the whole screen, just stop loading
      print('Error loading commits: $e');
      emit(GitBranchesLoaded(
        _currentRepoPath!, 
        _cachedBranches, 
        mode: _currentMode, 
        commits: _cachedCommits, // Keep old if fail
        isLoadingCommits: false
      ));
      // Optionally could emit a side-effect or snackbar via listener but keeping it simple
    }
  }

  Future<void> _onCompareBranches(CompareBranches event, Emitter<GitState> emit) async {
    if (_currentRepoPath == null) return;
    emit(GitComparisonInProgress(_currentRepoPath!));
    try {
      final diffFiles = await gitService.compareBranches(_currentRepoPath!, event.baseBranch, event.targetBranch);
      emit(GitComparisonResult(_currentRepoPath!, diffFiles, event.baseBranch, event.targetBranch, mode: ComparisonMode.branch));
    } catch (e) {
      emit(GitError('Failed to compare branches: ${e.toString()}', repoPath: _currentRepoPath));
    }
  }

  Future<void> _onCompareCommits(CompareCommits event, Emitter<GitState> emit) async {
    if (_currentRepoPath == null) return;
    emit(GitComparisonInProgress(_currentRepoPath!));
    try {
      final diffFiles = await gitService.compareCommits(_currentRepoPath!, event.baseSha, event.targetSha);
      emit(GitComparisonResult(_currentRepoPath!, diffFiles, event.baseSha, event.targetSha, mode: ComparisonMode.commit));
    } catch (e) {
      emit(GitError('Failed to compare commits: ${e.toString()}', repoPath: _currentRepoPath));
    }
  }
} 