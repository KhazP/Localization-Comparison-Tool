import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/business_logic/blocs/git_bloc.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockGitService mockGitService;
  late MockHistoryRepository mockHistoryRepo;

  setUpAll(() {
    registerFallbackValue(ComparisonSession(
      id: 'fallback',
      timestamp: DateTime.now(),
      file1Path: '',
      file2Path: '',
      stringsAdded: 0,
      stringsRemoved: 0,
      stringsModified: 0,
      stringsIdentical: 0,
      type: ComparisonType.file,
    ));
  });

  setUp(() {
    mockGitService = MockGitService();
    mockHistoryRepo = MockHistoryRepository();
  });

  GitBloc buildBloc() => GitBloc(
        gitService: mockGitService,
        historyRepository: mockHistoryRepo,
      );

  group('GitBloc', () {
    test('initial state is GitInitial', () {
      final bloc = buildBloc();
      expect(bloc.state, const GitInitial());
      bloc.close();
    });

    test('SelectRepository emits repositorySelected when valid', () async {
      when(() => mockGitService.isValidRepository(any()))
          .thenAnswer((_) async => true);
      when(() => mockGitService.getConflictedFiles(any()))
          .thenAnswer((_) async => []);
      when(() => mockGitService.getBranches(any())).thenAnswer((_) async => []);

      final bloc = buildBloc();
      final states = <GitState>[];
      final sub = bloc.stream.listen(states.add);

      bloc.add(SelectRepository('/repo'));
      // Wait for all cascaded events to settle
      await Future.delayed(const Duration(milliseconds: 500));

      // First state should be repositorySelected
      expect(
          states.first,
          isA<GitRepositorySelected>()
              .having((s) => s.isValid, 'isValid', true));
      // Should eventually reach branchesLoaded
      expect(states.any((s) => s is GitBranchesLoaded), isTrue);

      await sub.cancel();
      await bloc.close();
    });

    blocTest<GitBloc, GitState>(
      'SelectRepository emits invalid state for non-repo path',
      setUp: () {
        when(() => mockGitService.isValidRepository(any()))
            .thenAnswer((_) async => false);
      },
      build: buildBloc,
      act: (bloc) => bloc.add(SelectRepository('/not-a-repo')),
      expect: () => [
        isA<GitRepositorySelected>().having((s) => s.isValid, 'isValid', false),
      ],
    );

    blocTest<GitBloc, GitState>(
      'LoadBranches emits branchesLoaded with branches',
      setUp: () {
        when(() => mockGitService.getBranches(any())).thenAnswer((_) async => [
              GitBranch('main', 'abc123'),
              GitBranch('develop', 'def456'),
            ]);
      },
      build: buildBloc,
      seed: () => const GitRepositorySelected('/repo', true),
      act: (bloc) => bloc.add(LoadBranches()),
      expect: () => [
        isA<GitLoading>(),
        isA<GitBranchesLoaded>().having((s) => s.branches.length, 'count', 2),
      ],
    );

    blocTest<GitBloc, GitState>(
      'LoadBranches emits error when no repo selected',
      build: buildBloc,
      act: (bloc) => bloc.add(LoadBranches()),
      expect: () => [
        isA<GitError>(),
      ],
    );

    blocTest<GitBloc, GitState>(
      'CompareBranches emits comparison result on success',
      setUp: () {
        when(() => mockGitService.compareBranches(any(), any(), any()))
            .thenAnswer((_) async => [
                  GitDiffFile('file1.json', 'modified',
                      additions: 5, deletions: 2),
                ]);
        when(() => mockHistoryRepo.addComparisonToHistory(any()))
            .thenAnswer((_) async {});
      },
      build: buildBloc,
      seed: () => GitBranchesLoaded(
        '/repo',
        [GitBranch('main', 'abc'), GitBranch('develop', 'def')],
      ),
      act: (bloc) => bloc.add(CompareBranches('main', 'develop')),
      expect: () => [
        isA<GitComparisonInProgress>(),
        isA<GitComparisonResult>()
            .having((s) => s.diffFiles.length, 'files', 1)
            .having((s) => s.base, 'base', 'main')
            .having((s) => s.target, 'target', 'develop'),
      ],
    );

    blocTest<GitBloc, GitState>(
      'CompareBranches emits error on failure',
      setUp: () {
        when(() => mockGitService.compareBranches(any(), any(), any()))
            .thenThrow(Exception('Git error'));
      },
      build: buildBloc,
      seed: () => GitBranchesLoaded(
        '/repo',
        [GitBranch('main', 'abc')],
      ),
      act: (bloc) => bloc.add(CompareBranches('main', 'nonexistent')),
      expect: () => [
        isA<GitComparisonInProgress>(),
        isA<GitError>(),
      ],
    );
  });
}
