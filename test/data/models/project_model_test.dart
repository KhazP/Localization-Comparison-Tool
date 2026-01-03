import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/data/models/project.dart';

void main() {
  group('Project Model', () {
    final testDate = DateTime(2026, 1, 1, 12, 0, 0);

    Project createTestProject() {
      return Project(
        id: 'test-uuid-1234',
        name: 'Test Project',
        rootPath: '/path/to/project',
        createdAt: testDate,
        lastOpenedAt: testDate,
      );
    }

    test('constructor creates valid project', () {
      final project = createTestProject();

      expect(project.id, 'test-uuid-1234');
      expect(project.name, 'Test Project');
      expect(project.rootPath, '/path/to/project');
      expect(project.createdAt, testDate);
      expect(project.lastOpenedAt, testDate);
    });

    test('configFolderPath returns correct path', () {
      final project = createTestProject();
      expect(project.configFolderPath, '/path/to/project/.localizer');
    });

    test('projectFilePath returns correct path', () {
      final project = createTestProject();
      expect(
          project.projectFilePath, '/path/to/project/.localizer/project.json');
    });

    group('toJson', () {
      test('produces valid JSON with all fields', () {
        final project = createTestProject();
        final json = project.toJson();

        expect(json['id'], 'test-uuid-1234');
        expect(json['name'], 'Test Project');
        expect(json['createdAt'], testDate.toIso8601String());
        expect(json['lastOpenedAt'], testDate.toIso8601String());
        expect(json['version'], 2); // v2 adds settings field
      });

      test('does not include rootPath in JSON', () {
        final project = createTestProject();
        final json = project.toJson();

        expect(json.containsKey('rootPath'), isFalse);
      });
    });

    group('fromJson', () {
      test('correctly parses JSON back to Project', () {
        final json = {
          'id': 'test-uuid-1234',
          'name': 'Test Project',
          'createdAt': testDate.toIso8601String(),
          'lastOpenedAt': testDate.toIso8601String(),
          'version': 1,
        };

        final project = Project.fromJson(json, '/path/to/project');

        expect(project.id, 'test-uuid-1234');
        expect(project.name, 'Test Project');
        expect(project.rootPath, '/path/to/project');
        expect(project.createdAt, testDate);
        expect(project.lastOpenedAt, testDate);
      });
    });

    group('round-trip serialization', () {
      test('preserves data through toJson/fromJson cycle', () {
        final original = createTestProject();
        final json = original.toJson();
        final restored = Project.fromJson(json, original.rootPath);

        expect(restored.id, original.id);
        expect(restored.name, original.name);
        expect(restored.rootPath, original.rootPath);
        expect(restored.createdAt, original.createdAt);
        expect(restored.lastOpenedAt, original.lastOpenedAt);
      });
    });

    group('toJsonString', () {
      test('produces formatted JSON string', () {
        final project = createTestProject();
        final jsonString = project.toJsonString();

        expect(jsonString, contains('"id": "test-uuid-1234"'));
        expect(jsonString, contains('"name": "Test Project"'));
        expect(jsonString, contains('"version": 2')); // v2 adds settings field
      });
    });

    group('copyWith', () {
      test('creates copy with updated fields', () {
        final original = createTestProject();
        final newDate = DateTime(2026, 6, 15);

        final updated = original.copyWith(
          name: 'Updated Name',
          lastOpenedAt: newDate,
        );

        expect(updated.id, original.id);
        expect(updated.name, 'Updated Name');
        expect(updated.rootPath, original.rootPath);
        expect(updated.createdAt, original.createdAt);
        expect(updated.lastOpenedAt, newDate);
      });

      test('preserves all fields when no changes specified', () {
        final original = createTestProject();
        final copy = original.copyWith();

        expect(copy.id, original.id);
        expect(copy.name, original.name);
        expect(copy.rootPath, original.rootPath);
        expect(copy.createdAt, original.createdAt);
        expect(copy.lastOpenedAt, original.lastOpenedAt);
      });
    });

    group('equality', () {
      test('projects with same id are equal', () {
        final project1 = createTestProject();
        final project2 = Project(
          id: 'test-uuid-1234',
          name: 'Different Name',
          rootPath: '/different/path',
          createdAt: DateTime.now(),
          lastOpenedAt: DateTime.now(),
        );

        expect(project1, equals(project2));
        expect(project1.hashCode, project2.hashCode);
      });

      test('projects with different ids are not equal', () {
        final project1 = createTestProject();
        final project2 = project1.copyWith(id: 'different-uuid');

        expect(project1, isNot(equals(project2)));
      });
    });

    group('toString', () {
      test('returns readable string representation', () {
        final project = createTestProject();
        final string = project.toString();

        expect(string, contains('test-uuid-1234'));
        expect(string, contains('Test Project'));
        expect(string, contains('/path/to/project'));
      });
    });
  });
}
