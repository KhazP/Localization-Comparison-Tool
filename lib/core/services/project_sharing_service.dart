import 'dart:io';
import 'dart:convert';
import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as path;
import 'package:localizer_app_main/data/models/project.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';

class ProjectSharingService {
  // Files/Directories to ignore during export
  static const List<String> _ignorePatterns = [
    '.git',
    '.DS_Store',
    'node_modules',
    'build',
    'dist',
    '.dart_tool',
    '.idea',
    '.vscode',
    'Thumbs.db',
  ];

  /// Exports a project to a zip file.
  ///
  /// [project]: The project to export.
  /// [destinationZipPath]: The full path where the zip file should be created.
  /// [projectHistory]: List of history items belonging to this project.
  Future<void> exportProject({
    required Project project,
    required String destinationZipPath,
    required List<ComparisonSession> projectHistory,
  }) async {
    final rootDir = Directory(project.rootPath);
    if (!await rootDir.exists()) {
      throw Exception(
          'Project root directory does not exist: ${project.rootPath}');
    }

    final encoder = ZipFileEncoder();
    encoder.create(destinationZipPath);

    // 1. Add project files
    await _addDirectoryToZip(encoder, rootDir, '', rootDir.path);

    // 2. Add history export
    if (projectHistory.isNotEmpty) {
      final historyJson = jsonEncode(
          projectHistory.map((e) => _serializeSessionInternal(e)).toList());
      encoder.addArchiveFile(
        ArchiveFile(
          '.localizer/history_export.json',
          historyJson.length,
          utf8.encode(historyJson),
        ),
      );
    }

    encoder.close();
  }

  /// Imports a project from a zip file.
  ///
  /// [zipPath]: The path to the zip file.
  /// [extractToPath]: The folder where the project should be extracted.
  ///
  /// Returns the imported Project object and any history items found.
  Future<({Project project, List<ComparisonSession> history})> importProject({
    required String zipPath,
    required String extractToPath,
  }) async {
    final zipFile = File(zipPath);
    if (!await zipFile.exists()) {
      throw Exception('Zip file not found: $zipPath');
    }

    // 1. Extract Zip
    final inputStream = InputFileStream(zipPath);
    final archive = ZipDecoder().decodeBuffer(inputStream);

    final extractDir = Directory(extractToPath);
    if (!await extractDir.exists()) {
      await extractDir.create(recursive: true);
    }

    // We assume the zip contains the *contents* of the project, not a single root folder.
    // If it contains a single root folder, we might need to handle that, but for now assuming direct mapping.
    for (var file in archive.files) {
      if (file.isFile) {
        final outFile = File(path.join(extractToPath, file.name));
        await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content as List<int>);
      }
    }
    await inputStream.close();

    // 2. Validate Project
    final projectFile =
        File(path.join(extractToPath, '.localizer', 'project.json'));
    if (!await projectFile.exists()) {
      throw Exception(
          'Invalid project archive: missing .localizer/project.json');
    }

    final projectJson = jsonDecode(await projectFile.readAsString());
    // Create Project object (rootPath is the extraction path)
    final project = Project.fromJson(projectJson, extractToPath);

    // 3. Load History (if any)
    List<ComparisonSession> history = [];
    final historyFile =
        File(path.join(extractToPath, '.localizer', 'history_export.json'));
    if (await historyFile.exists()) {
      try {
        final historyList =
            jsonDecode(await historyFile.readAsString()) as List;
        history = historyList
            .map((e) => _deserializeSessionInternal(e, project.id))
            .toList();
      } catch (e) {
        // Log error but don't fail the import?
        print('Error parsing imported history: $e');
      }
    }

    return (project: project, history: history);
  }

  Future<void> _addDirectoryToZip(
    ZipFileEncoder encoder,
    Directory dir,
    String zipRelativePath,
    String projectRoot,
  ) async {
    await for (final entity in dir.list(followLinks: false)) {
      final name = path.basename(entity.path);

      // Check ignore patterns
      if (_ignorePatterns.contains(name)) continue;

      // Skip hidden files/folders (except .localizer)
      if (name.startsWith('.') && name != '.localizer') continue;

      if (entity is Directory) {
        await _addDirectoryToZip(
          encoder,
          entity,
          path.join(zipRelativePath, name),
          projectRoot,
        );
      } else if (entity is File) {
        // Calculate relative path for zip structure
        // zipRelativePath is empty for root items.
        // We use addFile but need to specify the name in the archive.
        final relativeFilePath = path.join(zipRelativePath, name);
        // Important: Normalize separators to forward slashes for ZIP compatibility
        final zipName = relativeFilePath.replaceAll(r'\', '/');

        await encoder.addFile(entity, zipName);
      }
    }
  }

  // Custom serialization for ComparisonSession to handle Hive objects without Hive
  // We can't use HiveAdapter here easily without Hive context, so manual JSON is safer/easier for portability.
  Map<String, dynamic> _serializeSessionInternal(ComparisonSession session) {
    return {
      'id': session.id, // We might want to generate new IDs on import?
      'timestamp': session.timestamp.toIso8601String(),
      'file1Path': session.file1Path, // Note: Absolute paths!
      'file2Path': session.file2Path,
      'stringsAdded': session.stringsAdded,
      'stringsRemoved': session.stringsRemoved,
      'stringsModified': session.stringsModified,
      'stringsIdentical': session.stringsIdentical,
      'sourceKeyCount': session.sourceKeyCount,
      'translatedKeyCount': session.translatedKeyCount,
      'sourceWordCount': session.sourceWordCount,
      'translatedWordCount': session.translatedWordCount,
      'projectId': session.projectId,
    };
  }

  ComparisonSession _deserializeSessionInternal(
      Map<String, dynamic> json, String newProjectId) {
    return ComparisonSession(
      id: json['id'], // Keep ID or generate new? Keep for now.
      timestamp: DateTime.parse(json['timestamp']),
      file1Path: json['file1Path'], // Needs usage-time correction potentially
      file2Path: json['file2Path'],
      stringsAdded: json['stringsAdded'],
      stringsRemoved: json['stringsRemoved'],
      stringsModified: json['stringsModified'],
      stringsIdentical: json['stringsIdentical'],
      sourceKeyCount: json['sourceKeyCount'],
      translatedKeyCount: json['translatedKeyCount'],
      sourceWordCount: json['sourceWordCount'],
      translatedWordCount: json['translatedWordCount'],
      projectId: newProjectId, // Ensure it links to the imported project ID
    );
  }
}
