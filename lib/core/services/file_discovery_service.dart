import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:localizer_app_main/data/models/file_pair.dart';

class FileDiscoveryResult {
  final List<FilePair> pairedFiles;
  final List<File> unmatchedSourceFiles;
  final List<File> unmatchedTargetFiles;

  const FileDiscoveryResult({
    required this.pairedFiles,
    required this.unmatchedSourceFiles,
    required this.unmatchedTargetFiles,
  });
}

class FileDiscoveryService {
  Future<FileDiscoveryResult> findMatchingFiles(
    String sourceDirPath,
    String targetDirPath,
  ) async {
    final sourceDir = Directory(sourceDirPath);
    final targetDir = Directory(targetDirPath);

    if (!await sourceDir.exists()) {
      throw DirectoryNotFoundException('Source directory not found: $sourceDirPath');
    }
    if (!await targetDir.exists()) {
      throw DirectoryNotFoundException('Target directory not found: $targetDirPath');
    }

    final List<FilePair> pairedFiles = [];
    final List<File> unmatchedSourceFiles = [];
    
    final allSourceFiles = (await sourceDir.list(recursive: true).toList()).whereType<File>();
    final allTargetFiles = (await targetDir.list(recursive: true).toList()).whereType<File>().toList();

    for (final sourceFile in allSourceFiles) {
      final relativePath = p.relative(sourceFile.path, from: sourceDirPath);
      
      try {
        final matchingTargetFile = allTargetFiles.firstWhere(
          (targetFile) => p.relative(targetFile.path, from: targetDirPath) == relativePath,
        );
        pairedFiles.add(FilePair(sourceFile: sourceFile, targetFile: matchingTargetFile));
        allTargetFiles.remove(matchingTargetFile); // Remove from list to mark as matched
      } catch (e) {
        // .firstWhere throws if no element is found
        unmatchedSourceFiles.add(sourceFile);
      }
    }

    // Any remaining files in allTargetFiles are unmatched target files
    final List<File> unmatchedTargetFiles = allTargetFiles;

    // Sort all lists alphabetically for consistent UI
    pairedFiles.sort((a, b) => a.sourceFile.path.compareTo(b.sourceFile.path));
    unmatchedSourceFiles.sort((a, b) => a.path.compareTo(b.path));
    unmatchedTargetFiles.sort((a, b) => a.path.compareTo(b.path));

    return FileDiscoveryResult(
      pairedFiles: pairedFiles,
      unmatchedSourceFiles: unmatchedSourceFiles,
      unmatchedTargetFiles: unmatchedTargetFiles,
    );
  }
}

class DirectoryNotFoundException implements Exception {
  final String message;
  DirectoryNotFoundException(this.message);

  @override
  String toString() => 'DirectoryNotFoundException: $message';
} 