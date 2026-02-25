import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/repositories/history_repository.dart';
import 'package:uuid/uuid.dart';

part 'git_bloc.freezed.dart';

// Events
abstract class GitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectRepository extends GitEvent {
  final String path;
  SelectRepository(this.path);

  @override
  List<Object?> get props => [path];
}

class LoadBranches extends GitEvent {}

class SwitchComparisonMode extends GitEvent {
  final ComparisonMode mode;
  SwitchComparisonMode(this.mode);

  @override
  List<Object?> get props => [mode];
}

class LoadCommits extends GitEvent {
  final String? branchName; // Optional filter
  final int limit;
  LoadCommits({this.branchName, this.limit = 50});

  @override
  List<Object?> get props => [branchName, limit];
}

class CompareBranches extends GitEvent {
  final String baseBranch;
  final String targetBranch;
  CompareBranches(this.baseBranch, this.targetBranch);

  @override
  List<Object?> get props => [baseBranch, targetBranch];
}

class CompareCommits extends GitEvent {
  final String baseSha;
  final String targetSha;
  CompareCommits(this.baseSha, this.targetSha);

  @override
  List<Object?> get props => [baseSha, targetSha];
}

class CheckConflicts extends GitEvent {
  final String repoPath;
  CheckConflicts(this.repoPath);

  @override
  List<Object?> get props => [repoPath];
}

class ResolveConflict extends GitEvent {
  final String repoPath;
  final String filePath;
  final ResolutionStrategy strategy;
  ResolveConflict(this.repoPath, this.filePath, this.strategy);

  @override
  List<Object?> get props => [repoPath, filePath, strategy];
}

class AbortMerge extends GitEvent {
  final String repoPath;
  AbortMerge(this.repoPath);

  @override
  List<Object?> get props => [repoPath];
}

class ResolveSingleConflict extends GitEvent {
  final String repoPath;
  final String filePath;
  final ConflictMarker marker;
  final ResolutionStrategy strategy;
  ResolveSingleConflict(
      this.repoPath, this.filePath, this.marker, this.strategy);

  @override
  List<Object?> get props => [repoPath, filePath, marker, strategy];
}

class MarkFileResolved extends GitEvent {
  final String repoPath;
  final String filePath;
  MarkFileResolved(this.repoPath, this.filePath);

  @override
  List<Object?> get props => [repoPath, filePath];
}

class CheckoutBranch extends GitEvent {
  final String branchName;
  CheckoutBranch(this.branchName);

  @override
  List<Object?> get props => [branchName];
}

class MergeBranch extends GitEvent {
  final String branchName;
  MergeBranch(this.branchName);

  @override
  List<Object?> get props => [branchName];
}

class PullChanges extends GitEvent {}

// States
enum ComparisonMode { branch, commit }

@freezed
class GitState with _$GitState {
  const GitState._();

  const factory GitState.initial() = GitInitial;

  const factory GitState.repositorySelected(
    String repoPath,
    bool isValid,
  ) = GitRepositorySelected;

  const factory GitState.loading(
    String repoPath,
  ) = GitLoading;

  const factory GitState.branchesLoaded(
    String repoPath,
    List<GitBranch> branches, {
    @Default(ComparisonMode.branch) ComparisonMode mode,
    @Default(<GitCommit>[]) List<GitCommit> commits,
    @Default(false) bool isLoadingCommits,
  }) = GitBranchesLoaded;

  const factory GitState.comparisonInProgress(
    String repoPath,
  ) = GitComparisonInProgress;

  const factory GitState.comparisonResult(
    String repoPath,
    List<GitDiffFile> diffFiles,
    String base,
    String target, {
    @Default(ComparisonMode.branch) ComparisonMode mode,
  }) = GitComparisonResult;

  const factory GitState.error(
    String message, {
    String? repoPath,
  }) = GitError;

  const factory GitState.conflictsDetected(
    String repoPath,
    List<String> conflictedFiles,
  ) = GitConflictsDetected;

  const factory GitState.operationSuccess(
    String repoPath,
    String message,
  ) = GitOperationSuccess;

  String? get repoPath => mapOrNull(
        repositorySelected: (state) => state.repoPath,
        loading: (state) => state.repoPath,
        branchesLoaded: (state) => state.repoPath,
        comparisonInProgress: (state) => state.repoPath,
        comparisonResult: (state) => state.repoPath,
        error: (state) => state.repoPath,
        conflictsDetected: (state) => state.repoPath,
        operationSuccess: (state) => state.repoPath,
      );
}

// BLoC
class GitBloc extends Bloc<GitEvent, GitState> {
  final GitService gitService;
  final HistoryRepository _historyRepository;

  /// Reads the current repo path from the current state.
  String? get _currentRepoPath => state.repoPath;

  /// Reads cached branches from the current state.
  List<GitBranch> get _cachedBranches =>
      state.mapOrNull(
        branchesLoaded: (s) => s.branches,
      ) ??
      [];

  /// Reads cached commits from the current state.
  List<GitCommit> get _cachedCommits =>
      state.mapOrNull(
        branchesLoaded: (s) => s.commits,
      ) ??
      [];

  /// Reads the current comparison mode from the current state.
  ComparisonMode get _currentMode =>
      state.mapOrNull(
        branchesLoaded: (s) => s.mode,
        comparisonResult: (s) => s.mode,
      ) ??
      ComparisonMode.branch;

  GitBloc(
      {required this.gitService, required HistoryRepository historyRepository})
      : _historyRepository = historyRepository,
        super(const GitInitial()) {
    on<SelectRepository>(_onSelectRepository);
    on<LoadBranches>(_onLoadBranches);
    on<SwitchComparisonMode>(_onSwitchComparisonMode);
    on<LoadCommits>(_onLoadCommits);
    on<CompareBranches>(_onCompareBranches);
    on<CompareCommits>(_onCompareCommits);
    on<CheckConflicts>(_onCheckConflicts);
    on<ResolveConflict>(_onResolveConflict);
    on<ResolveSingleConflict>(_onResolveSingleConflict);
    on<MarkFileResolved>(_onMarkFileResolved);
    on<AbortMerge>(_onAbortMerge);
    on<CheckoutBranch>(_onCheckoutBranch);
    on<MergeBranch>(_onMergeBranch);
    on<PullChanges>(_onPullChanges);
  }

  Future<void> _onSelectRepository(
      SelectRepository event, Emitter<GitState> emit) async {
    try {
      final isValid = await gitService.isValidRepository(event.path);
      if (isValid) {
        emit(GitRepositorySelected(event.path, true));
        add(CheckConflicts(event.path)); // Check for conflicts first
        add(LoadBranches()); // Auto-load branches on valid selection
      } else {
        emit(GitRepositorySelected(event.path, false));
      }
    } catch (e) {
      emit(GitError('Error validating repository: ${e.toString()}',
          repoPath: event.path));
    }
  }

  Future<void> _onLoadBranches(
      LoadBranches event, Emitter<GitState> emit) async {
    final repoPath = _currentRepoPath;
    if (repoPath == null) {
      emit(GitError('No repository selected to load branches from.'));
      return;
    }
    final cachedCommits = _cachedCommits;
    final currentMode = _currentMode;
    emit(GitLoading(repoPath));
    try {
      final branches = await gitService.getBranches(repoPath);
      emit(GitBranchesLoaded(repoPath, branches,
          mode: currentMode, commits: cachedCommits));
    } catch (e) {
      emit(GitError('Failed to load branches: ${e.toString()}',
          repoPath: repoPath));
    }
  }

  void _onSwitchComparisonMode(
      SwitchComparisonMode event, Emitter<GitState> emit) {
    final repoPath = _currentRepoPath;
    if (repoPath == null) return;
    final newMode = event.mode;

    // If switching to commit mode and we don't have commits, load them
    if (newMode == ComparisonMode.commit && _cachedCommits.isEmpty) {
      add(LoadCommits());
    }

    // Re-emit Loaded state with new mode
    emit(GitBranchesLoaded(repoPath, _cachedBranches,
        mode: newMode, commits: _cachedCommits));
  }

  Future<void> _onLoadCommits(LoadCommits event, Emitter<GitState> emit) async {
    final repoPath = _currentRepoPath;
    if (repoPath == null) return;

    final cachedBranches = _cachedBranches;
    final currentMode = _currentMode;
    final cachedCommits = _cachedCommits;

    // Emit loading state for commits specifically - preserve existing branches/mode
    emit(GitBranchesLoaded(repoPath, cachedBranches,
        mode: currentMode, commits: cachedCommits, isLoadingCommits: true));

    try {
      final commits = await gitService.getCommits(repoPath,
          branchName: event.branchName, limit: event.limit);
      emit(GitBranchesLoaded(repoPath, cachedBranches,
          mode: currentMode, commits: commits, isLoadingCommits: false));
    } catch (e) {
      // Don't error the whole screen, just stop loading
      debugPrint('Error loading commits: $e');
      emit(GitBranchesLoaded(repoPath, cachedBranches,
          mode: currentMode,
          commits: cachedCommits, // Keep old if fail
          isLoadingCommits: false));
    }
  }

  Future<void> _onCompareBranches(
      CompareBranches event, Emitter<GitState> emit) async {
    final repoPath = _currentRepoPath;
    if (repoPath == null) return;
    emit(GitComparisonInProgress(repoPath));
    try {
      final diffFiles = await gitService.compareBranches(
          repoPath, event.baseBranch, event.targetBranch);
      emit(GitComparisonResult(
          repoPath, diffFiles, event.baseBranch, event.targetBranch,
          mode: ComparisonMode.branch));

      // Save to history
      try {
        final totalChanges = diffFiles.length;

        final session = ComparisonSession(
          id: const Uuid().v4(),
          timestamp: DateTime.now(),
          file1Path: repoPath,
          file2Path: repoPath,
          stringsAdded: 0,
          stringsRemoved: 0,
          stringsModified: 0,
          stringsIdentical: 0,
          type: ComparisonType.git,
          gitRepoPath: repoPath,
          gitBranch1: event.baseBranch,
          gitBranch2: event.targetBranch,
          fileCount: totalChanges,
        );
        await _historyRepository.addComparisonToHistory(session);
      } catch (e) {
        debugPrint('Failed to save git history: $e');
      }
    } catch (e) {
      emit(GitError('Failed to compare branches: ${e.toString()}',
          repoPath: repoPath));
    }
  }

  Future<void> _onCompareCommits(
      CompareCommits event, Emitter<GitState> emit) async {
    final repoPath = _currentRepoPath;
    if (repoPath == null) return;
    emit(GitComparisonInProgress(repoPath));
    try {
      final diffFiles = await gitService.compareCommits(
          repoPath, event.baseSha, event.targetSha);
      emit(GitComparisonResult(
          repoPath, diffFiles, event.baseSha, event.targetSha,
          mode: ComparisonMode.commit));

      // Save to history
      try {
        final totalChanges = diffFiles.length;

        final session = ComparisonSession(
          id: const Uuid().v4(),
          timestamp: DateTime.now(),
          file1Path: repoPath,
          file2Path: repoPath,
          stringsAdded: 0,
          stringsRemoved: 0,
          stringsModified: 0,
          stringsIdentical: 0,
          type: ComparisonType.git,
          gitRepoPath: repoPath,
          gitCommit1: event.baseSha,
          gitCommit2: event.targetSha,
          fileCount: totalChanges,
        );
        await _historyRepository.addComparisonToHistory(session);
      } catch (e) {
        debugPrint('Failed to save git history: $e');
      }
    } catch (e) {
      emit(GitError('Failed to compare commits: ${e.toString()}',
          repoPath: repoPath));
    }
  }

  Future<void> _onCheckConflicts(
      CheckConflicts event, Emitter<GitState> emit) async {
    try {
      final conflicts = await gitService.getConflictedFiles(event.repoPath);
      if (conflicts.isNotEmpty) {
        emit(GitConflictsDetected(event.repoPath, conflicts));
      } else {
        // All conflicts resolved - emit success and refresh branches
        debugPrint('All conflicts resolved, refreshing state');
        emit(GitOperationSuccess(
            event.repoPath, 'All conflicts resolved! Ready to commit.'));
        add(LoadBranches()); // Refresh to normal state
      }
    } catch (e) {
      debugPrint('Error checking conflicts: $e');
      // Non-blocking error
    }
  }

  Future<void> _onResolveConflict(
      ResolveConflict event, Emitter<GitState> emit) async {
    try {
      await gitService.resolveConflict(
          event.repoPath, event.filePath, event.strategy);
      add(CheckConflicts(event.repoPath)); // Re-check to see if all cleared
    } catch (e) {
      emit(
          GitError('Failed to resolve conflict: $e', repoPath: event.repoPath));
    }
  }

  Future<void> _onResolveSingleConflict(
      ResolveSingleConflict event, Emitter<GitState> emit) async {
    try {
      await gitService.resolveSingleConflict(
          event.repoPath, event.filePath, event.marker, event.strategy);
      // The caller (UI) should refresh markers after this
    } catch (e) {
      emit(GitError('Failed to resolve single conflict: $e',
          repoPath: event.repoPath));
    }
  }

  Future<void> _onMarkFileResolved(
      MarkFileResolved event, Emitter<GitState> emit) async {
    try {
      await gitService.markFileResolved(event.repoPath, event.filePath);
      add(CheckConflicts(event.repoPath)); // Refresh conflict list
    } catch (e) {
      emit(GitError('Failed to mark file as resolved: $e',
          repoPath: event.repoPath));
    }
  }

  Future<void> _onAbortMerge(AbortMerge event, Emitter<GitState> emit) async {
    try {
      await gitService.abortMerge(event.repoPath);
      add(CheckConflicts(event.repoPath)); // Should be clear now
      add(LoadBranches()); // Refresh valid state
    } catch (e) {
      emit(GitError('Failed to abort merge: $e', repoPath: event.repoPath));
    }
  }

  Future<void> _onCheckoutBranch(
      CheckoutBranch event, Emitter<GitState> emit) async {
    final repoPath = _currentRepoPath;
    if (repoPath == null) return;
    try {
      await gitService.checkoutBranch(repoPath, event.branchName);
      add(LoadBranches()); // Refresh branches/head
      add(CheckConflicts(repoPath));
      emit(GitOperationSuccess(repoPath, 'Checked out ${event.branchName}'));
    } catch (e) {
      emit(GitError('Failed to checkout branch: $e', repoPath: repoPath));
    }
  }

  Future<void> _onMergeBranch(MergeBranch event, Emitter<GitState> emit) async {
    final repoPath = _currentRepoPath;
    if (repoPath == null) return;
    try {
      await gitService.mergeBranch(repoPath, event.branchName);
      add(CheckConflicts(repoPath)); // Check if merge caused conflict
      add(LoadBranches());
      emit(GitOperationSuccess(repoPath, 'Merged ${event.branchName}'));
    } catch (e) {
      // Even if failed, check for conflicts (handled inside service mostly but safe to double check)
      add(CheckConflicts(repoPath));
      emit(GitError('Merge failed: $e', repoPath: repoPath));
    }
  }

  Future<void> _onPullChanges(PullChanges event, Emitter<GitState> emit) async {
    final repoPath = _currentRepoPath;
    if (repoPath == null) return;
    try {
      await gitService.pull(repoPath);
      add(CheckConflicts(repoPath));
      add(LoadBranches());
      emit(GitOperationSuccess(repoPath, 'Pull successful'));
    } catch (e) {
      add(CheckConflicts(repoPath));
      emit(GitError('Pull failed: $e', repoPath: repoPath));
    }
  }
}
