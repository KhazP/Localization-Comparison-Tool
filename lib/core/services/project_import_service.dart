import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:localizer_app_main/core/utils/drag_drop_utils.dart';

/// Summary of an import operation into a project folder.
class ProjectImportResult {
  final int importedCount;
  final int skippedUnsupportedCount;
  final int skippedMissingCount;
  final int skippedInProjectCount;
  final int failedCount;

  const ProjectImportResult({
    required this.importedCount,
    required this.skippedUnsupportedCount,
    required this.skippedMissingCount,
    required this.skippedInProjectCount,
    required this.failedCount,
  });

  const ProjectImportResult.empty()
      : importedCount = 0,
        skippedUnsupportedCount = 0,
        skippedMissingCount = 0,
        skippedInProjectCount = 0,
        failedCount = 0;
}

/// Copies supported files into a project's import folder.
class ProjectImportService {
  static const String _importsFolderName = 'imports';

  /// Imports files into the project root under an `imports/` folder.
  Future<ProjectImportResult> importFiles({
    required String projectRoot,
    required List<String> filePaths,
  }) async {
    final rootDir = Directory(projectRoot);
    if (!await rootDir.exists()) {
      throw ProjectImportException(
        'Project folder not found. Please open the project again.',
      );
    }

    if (filePaths.isEmpty) {
      return const ProjectImportResult.empty();
    }

    int importedCount = 0;
    int skippedUnsupportedCount = 0;
    int skippedMissingCount = 0;
    int skippedInProjectCount = 0;
    int failedCount = 0;

    final normalizedProjectRoot = p.normalize(projectRoot);
    Directory? importsDir;

    for (final filePath in filePaths.toSet()) {
      if (filePath.trim().isEmpty) {
        skippedMissingCount++;
        continue;
      }

      final normalizedPath = p.normalize(filePath);
      if (_isWithinProject(normalizedProjectRoot, normalizedPath)) {
        skippedInProjectCount++;
        continue;
      }

      if (!DragDropUtils.isValidFilePath(normalizedPath)) {
        skippedUnsupportedCount++;
        continue;
      }

      final entityType = await FileSystemEntity.type(normalizedPath);
      if (entityType != FileSystemEntityType.file) {
        skippedMissingCount++;
        continue;
      }

      final file = File(normalizedPath);
      if (!await file.exists()) {
        skippedMissingCount++;
        continue;
      }

      try {
        importsDir ??=
            await _ensureImportsDir(projectRoot, _importsFolderName);
        final destinationPath =
            await _resolveDestinationPath(importsDir.path, file);
        await file.copy(destinationPath);
        importedCount++;
      } catch (_) {
        failedCount++;
      }
    }

    return ProjectImportResult(
      importedCount: importedCount,
      skippedUnsupportedCount: skippedUnsupportedCount,
      skippedMissingCount: skippedMissingCount,
      skippedInProjectCount: skippedInProjectCount,
      failedCount: failedCount,
    );
  }

  bool _isWithinProject(String projectRoot, String filePath) {
    return p.equals(projectRoot, filePath) ||
        p.isWithin(projectRoot, filePath);
  }

  Future<String> _resolveDestinationPath(
    String importsDir,
    File sourceFile,
  ) async {
    final baseName = p.basenameWithoutExtension(sourceFile.path);
    final extension = p.extension(sourceFile.path);
    var candidate = p.join(importsDir, '$baseName$extension');
    var counter = 1;

    while (await File(candidate).exists()) {
      candidate = p.join(importsDir, '$baseName ($counter)$extension');
      counter++;
    }

    return candidate;
  }

  Future<Directory> _ensureImportsDir(
    String projectRoot,
    String folderName,
  ) async {
    final importsDir = Directory(p.join(projectRoot, folderName));
    if (!await importsDir.exists()) {
      await importsDir.create(recursive: true);
    }
    return importsDir;
  }
}

/// Exception thrown when project import fails.
class ProjectImportException implements Exception {
  final String message;

  ProjectImportException(this.message);

  @override
  String toString() => message;
}
