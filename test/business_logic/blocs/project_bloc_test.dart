import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/core/services/project_import_service.dart';
import 'package:localizer_app_main/data/models/project.dart';
import 'package:localizer_app_main/data/repositories/project_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockProjectRepository extends Mock implements ProjectRepository {}

class MockProjectImportService extends Mock implements ProjectImportService {}

void main() {
  late MockProjectRepository mockRepository;
  late MockProjectImportService mockImportService;
  late ProjectBloc projectBloc;

  final testProject = Project(
    id: 'test-uuid',
    name: 'Test Project',
    rootPath: '/path/to/project',
    createdAt: DateTime.now(),
    lastOpenedAt: DateTime.now(),
  );

  setUpAll(() {
    // Register fallback value for Project type
    registerFallbackValue(testProject);
  });

  setUp(() {
    mockRepository = MockProjectRepository();
    mockImportService = MockProjectImportService();
    projectBloc = ProjectBloc(
      projectRepository: mockRepository,
      projectImportService: mockImportService,
    );
  });

  tearDown(() {
    projectBloc.close();
  });

  group('ProjectBloc', () {
    test('initial state is correct', () {
      expect(projectBloc.state.status, ProjectStatus.initial);
      expect(projectBloc.state.currentProject, isNull);
      expect(projectBloc.state.hasProject, isFalse);
    });

    group('CreateProject', () {
      blocTest<ProjectBloc, ProjectState>(
        'emits [loading, loaded] when project creation succeeds',
        build: () {
          when(() => mockRepository.createProject(
                folderPath: any(named: 'folderPath'),
                projectName: any(named: 'projectName'),
              )).thenAnswer((_) async => testProject);
          return projectBloc;
        },
        act: (bloc) => bloc.add(const CreateProject(
          folderPath: '/path/to/project',
          projectName: 'Test Project',
        )),
        expect: () => [
          isA<ProjectState>()
              .having((s) => s.status, 'status', ProjectStatus.loading),
          isA<ProjectState>()
              .having((s) => s.status, 'status', ProjectStatus.loaded)
              .having((s) => s.currentProject, 'project', testProject)
              .having((s) => s.hasProject, 'hasProject', true),
        ],
      );

      blocTest<ProjectBloc, ProjectState>(
        'emits [loading, error] when project creation fails',
        build: () {
          when(() => mockRepository.createProject(
                folderPath: any(named: 'folderPath'),
                projectName: any(named: 'projectName'),
              )).thenThrow(ProjectCreationException('Already exists'));
          return projectBloc;
        },
        act: (bloc) => bloc.add(const CreateProject(
          folderPath: '/path/to/project',
          projectName: 'Test Project',
        )),
        expect: () => [
          isA<ProjectState>()
              .having((s) => s.status, 'status', ProjectStatus.loading),
          isA<ProjectState>()
              .having((s) => s.status, 'status', ProjectStatus.error)
              .having((s) => s.errorMessage, 'message', 'Already exists'),
        ],
      );
    });

    group('OpenProject', () {
      blocTest<ProjectBloc, ProjectState>(
        'emits [loading, loaded] when project exists',
        build: () {
          when(() => mockRepository.openProject(any()))
              .thenAnswer((_) async => testProject);
          return projectBloc;
        },
        act: (bloc) => bloc.add(const OpenProject('/path/to/project')),
        expect: () => [
          isA<ProjectState>()
              .having((s) => s.status, 'status', ProjectStatus.loading),
          isA<ProjectState>()
              .having((s) => s.status, 'status', ProjectStatus.loaded)
              .having((s) => s.currentProject?.name, 'name', 'Test Project'),
        ],
      );

      blocTest<ProjectBloc, ProjectState>(
        'emits [loading, error] when no project found',
        build: () {
          when(() => mockRepository.openProject(any()))
              .thenAnswer((_) async => null);
          return projectBloc;
        },
        act: (bloc) => bloc.add(const OpenProject('/path/to/project')),
        expect: () => [
          isA<ProjectState>()
              .having((s) => s.status, 'status', ProjectStatus.loading),
          isA<ProjectState>()
              .having((s) => s.status, 'status', ProjectStatus.error)
              .having((s) => s.errorMessage, 'message',
                  contains('No project found')),
        ],
      );
    });

    group('CloseProject', () {
      blocTest<ProjectBloc, ProjectState>(
        'emits initial state when closing project',
        build: () => projectBloc,
        seed: () => ProjectState.loaded(testProject),
        act: (bloc) => bloc.add(const CloseProject()),
        expect: () => [
          isA<ProjectState>()
              .having((s) => s.status, 'status', ProjectStatus.initial)
              .having((s) => s.currentProject, 'project', isNull),
        ],
      );
    });

    group('ValidateCurrentProject', () {
      blocTest<ProjectBloc, ProjectState>(
        'does nothing when no project is open',
        build: () => projectBloc,
        act: (bloc) => bloc.add(const ValidateCurrentProject()),
        expect: () => [],
      );

      blocTest<ProjectBloc, ProjectState>(
        'emits error when project is no longer valid',
        build: () {
          when(() => mockRepository.validateProject(any()))
              .thenAnswer((_) async => false);
          return projectBloc;
        },
        seed: () => ProjectState.loaded(testProject),
        act: (bloc) => bloc.add(const ValidateCurrentProject()),
        expect: () => [
          isA<ProjectState>()
              .having((s) => s.status, 'status', ProjectStatus.error)
              .having((s) => s.errorMessage, 'message',
                  contains('moved or deleted')),
        ],
      );

      blocTest<ProjectBloc, ProjectState>(
        'does not emit when project is still valid',
        build: () {
          when(() => mockRepository.validateProject(any()))
              .thenAnswer((_) async => true);
          return projectBloc;
        },
        seed: () => ProjectState.loaded(testProject),
        act: (bloc) => bloc.add(const ValidateCurrentProject()),
        expect: () => [],
      );
    });
  });
}
