import 'dart:developer' as developer;
import 'dart:io';

import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:path/path.dart' as path;

class BackupService {
  Future<void> createBackupIfNeeded({
    required String targetPath,
    required AppSettings settings,
  }) async {
    if (!settings.autoBackup) {
      return;
    }

    final targetFile = File(targetPath);
    if (!await targetFile.exists()) {
      return;
    }

    final backupRoot = settings.backupDirectory.trim().isEmpty
        ? targetFile.parent.path
        : settings.backupDirectory.trim();
    final backupDir = Directory(backupRoot);

    try {
      await backupDir.create(recursive: true);
      final baseName = path.basename(targetPath);
      final backupName = '$baseName.backup.${_timestamp()}.bak';
      final backupPath = path.join(backupDir.path, backupName);

      await targetFile.copy(backupPath);
      await _pruneBackups(backupDir, baseName, settings.backupsToKeep);
    } catch (e, s) {
      developer.log(
        'Failed to create backup for $targetPath',
        name: 'BackupService',
        error: e,
        stackTrace: s,
      );
    }
  }

  String _timestamp() {
    final now = DateTime.now();
    return '${now.year.toString().padLeft(4, '0')}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}_'
        '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}'
        '${now.second.toString().padLeft(2, '0')}';
  }

  Future<void> _pruneBackups(
    Directory backupDir,
    String baseName,
    int keepCount,
  ) async {
    if (keepCount <= 0) {
      return;
    }

    try {
      final prefix = '$baseName.backup.';
      final backupFiles = await backupDir
          .list()
          .where((entity) => entity is File)
          .cast<File>()
          .where((file) => path.basename(file.path).startsWith(prefix))
          .toList();

      if (backupFiles.length <= keepCount) {
        return;
      }

      backupFiles.sort((a, b) {
        final aModified = a.statSync().modified;
        final bModified = b.statSync().modified;
        return aModified.compareTo(bModified);
      });

      final removeCount = backupFiles.length - keepCount;
      for (var i = 0; i < removeCount; i++) {
        await backupFiles[i].delete();
      }
    } catch (e, s) {
      developer.log(
        'Failed to prune backups for $baseName',
        name: 'BackupService',
        error: e,
        stackTrace: s,
      );
    }
  }
}
