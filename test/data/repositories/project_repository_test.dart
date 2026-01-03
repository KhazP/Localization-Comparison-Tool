import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/data/repositories/project_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';

class MockSecureStorageService extends Mock implements SecureStorageService {}

void main() {
  late ProjectRepository repository;
  late MockSecureStorageService mockSecureStorageService;
  late Directory tempDir;

  setUp(() {
    mockSecureStorageService = MockSecureStorageService();
    // Stub common calls to avoid null errors
    when(() => mockSecureStorageService.storeLastProject(any()))
        .thenAnswer((_) async {});
    when(() => mockSecureStorageService.getRecentProjectPaths())
        .thenAnswer((_) async => []);
    when(() => mockSecureStorageService.storeRecentProjectPaths(any()))
        .thenAnswer((_) async {});

    repository =
        ProjectRepository(secureStorageService: mockSecureStorageService);
  });

  setUpAll(() async {
    // Create a temporary directory for testing
    tempDir = await Directory.systemTemp.createTemp('localizer_test_');
  });

  tearDownAll(() async {
    // Clean up temporary directory
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('ProjectRepository', () {
    group('createProject', () {
      test('creates .localizer folder and project.json', () async {
        final testFolder = Directory('${tempDir.path}/create_test');
        await testFolder.create();

        final project = await repository.createProject(
          folderPath: testFolder.path,
          projectName: 'Test Project',
        );

        // Verify project was created with correct data
        expect(project.name, 'Test Project');
        expect(project.rootPath, testFolder.path);
        expect(project.id, isNotEmpty);
        expect(project.createdAt, isNotNull);
        expect(project.lastOpenedAt, isNotNull);

        // Verify .localizer folder exists
        final configFolder = Directory('${testFolder.path}/.localizer');
        expect(await configFolder.exists(), isTrue);

        // Verify project.json exists
        final projectFile = File('${testFolder.path}/.localizer/project.json');
        expect(await projectFile.exists(), isTrue);

        // Clean up
        await testFolder.delete(recursive: true);
      });

      test('throws ProjectCreationException if project already exists',
          () async {
        final testFolder = Directory('${tempDir.path}/existing_test');
        await testFolder.create();

        // Create first project
        await repository.createProject(
          folderPath: testFolder.path,
          projectName: 'First Project',
        );

        // Try to create second project in same folder
        expect(
          () => repository.createProject(
            folderPath: testFolder.path,
            projectName: 'Second Project',
          ),
          throwsA(isA<ProjectCreationException>()),
        );

        // Clean up
        await testFolder.delete(recursive: true);
      });
    });

    group('loadProject', () {
      test('returns Project when marker exists', () async {
        final testFolder = Directory('${tempDir.path}/load_test');
        await testFolder.create();

        // Create a project first
        final createdProject = await repository.createProject(
          folderPath: testFolder.path,
          projectName: 'Load Test Project',
        );

        // Load the project
        final loadedProject = await repository.loadProject(testFolder.path);

        expect(loadedProject, isNotNull);
        expect(loadedProject!.id, createdProject.id);
        expect(loadedProject.name, 'Load Test Project');
        expect(loadedProject.rootPath, testFolder.path);

        // Clean up
        await testFolder.delete(recursive: true);
      });

      test('returns null when no marker exists', () async {
        final testFolder = Directory('${tempDir.path}/no_marker_test');
        await testFolder.create();

        final project = await repository.loadProject(testFolder.path);

        expect(project, isNull);

        // Clean up
        await testFolder.delete(recursive: true);
      });
    });

    group('isProjectFolder', () {
      test('returns true for folder with .localizer/project.json', () async {
        final testFolder = Directory('${tempDir.path}/is_project_test');
        await testFolder.create();

        // Create a project
        await repository.createProject(
          folderPath: testFolder.path,
          projectName: 'Is Project Test',
        );

        final isProject = await repository.isProjectFolder(testFolder.path);
        expect(isProject, isTrue);

        // Clean up
        await testFolder.delete(recursive: true);
      });

      test('returns false for folder without project marker', () async {
        final testFolder = Directory('${tempDir.path}/not_project_test');
        await testFolder.create();

        final isProject = await repository.isProjectFolder(testFolder.path);
        expect(isProject, isFalse);

        // Clean up
        await testFolder.delete(recursive: true);
      });
    });

    group('saveProject', () {
      test('updates lastOpenedAt timestamp', () async {
        final testFolder = Directory('${tempDir.path}/save_test');
        await testFolder.create();

        // Create a project
        final project = await repository.createProject(
          folderPath: testFolder.path,
          projectName: 'Save Test Project',
        );

        final originalLastOpened = project.lastOpenedAt;

        // Wait a moment to ensure time difference
        await Future.delayed(const Duration(milliseconds: 10));

        // Save the project
        final savedProject = await repository.saveProject(project);

        // Verify lastOpenedAt was updated
        expect(
          savedProject.lastOpenedAt.isAfter(originalLastOpened),
          isTrue,
        );

        // Clean up
        await testFolder.delete(recursive: true);
      });
    });

    group('openProject', () {
      test('loads and updates lastOpenedAt', () async {
        final testFolder = Directory('${tempDir.path}/open_test');
        await testFolder.create();

        // Create a project
        await repository.createProject(
          folderPath: testFolder.path,
          projectName: 'Open Test Project',
        );

        // Wait a moment
        await Future.delayed(const Duration(milliseconds: 10));

        // Open the project
        final project = await repository.openProject(testFolder.path);

        expect(project, isNotNull);
        expect(project!.name, 'Open Test Project');

        // Clean up
        await testFolder.delete(recursive: true);
      });

      test('returns null for non-project folder', () async {
        final testFolder = Directory('${tempDir.path}/open_nonproject_test');
        await testFolder.create();

        final project = await repository.openProject(testFolder.path);
        expect(project, isNull);

        // Clean up
        await testFolder.delete(recursive: true);
      });
    });

    group('validateProject', () {
      test('returns true for valid project', () async {
        final testFolder = Directory('${tempDir.path}/validate_test');
        await testFolder.create();

        final project = await repository.createProject(
          folderPath: testFolder.path,
          projectName: 'Validate Test Project',
        );

        final isValid = await repository.validateProject(project);
        expect(isValid, isTrue);

        // Clean up
        await testFolder.delete(recursive: true);
      });

      test('returns false when project folder is deleted', () async {
        final testFolder = Directory('${tempDir.path}/validate_deleted_test');
        await testFolder.create();

        final project = await repository.createProject(
          folderPath: testFolder.path,
          projectName: 'Deleted Test Project',
        );

        // Delete the folder
        await testFolder.delete(recursive: true);

        final isValid = await repository.validateProject(project);
        expect(isValid, isFalse);
      });
    });
  });
}
