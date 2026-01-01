import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Repository for managing "Don't show again" preferences for warnings.
/// 
/// Currently supports suppressing the large file warning per file path.
/// Preferences are persisted using Hive.
class WarningSuppressionsRepository {
  static const String _boxName = 'warning_suppressions_box';
  static const String _largeFileWarningsKey = 'suppressed_large_file_warnings';

  Box<List<String>>? _box;

  /// Initialize the repository. Must be called before other methods.
  Future<void> init() async {
    if (_box?.isOpen == true) return;
    
    try {
      _box = await Hive.openBox<List<String>>(_boxName);
    } catch (e) {
      debugPrint('WarningSuppressionsRepository: Error opening box, resetting: $e');
      await Hive.deleteBoxFromDisk(_boxName);
      _box = await Hive.openBox<List<String>>(_boxName);
    }
  }

  /// Get the set of file paths that have the large file warning suppressed.
  Set<String> getSuppressedLargeFileWarnings() {
    final list = _box?.get(_largeFileWarningsKey, defaultValue: <String>[]) ?? <String>[];
    return list.toSet();
  }

  /// Check if the large file warning is suppressed for the given file path.
  bool isLargeFileWarningSuppressed(String filePath) {
    return getSuppressedLargeFileWarnings().contains(_normalizePath(filePath));
  }

  /// Suppress the large file warning for the given file path.
  Future<void> suppressLargeFileWarning(String filePath) async {
    await init();
    final suppressedPaths = getSuppressedLargeFileWarnings();
    suppressedPaths.add(_normalizePath(filePath));
    await _box?.put(_largeFileWarningsKey, suppressedPaths.toList());
    debugPrint('WarningSuppressionsRepository: Suppressed large file warning for $filePath');
  }

  /// Remove the suppression for the given file path (re-enable the warning).
  Future<void> unsuppressLargeFileWarning(String filePath) async {
    await init();
    final suppressedPaths = getSuppressedLargeFileWarnings();
    suppressedPaths.remove(_normalizePath(filePath));
    await _box?.put(_largeFileWarningsKey, suppressedPaths.toList());
  }

  /// Clear all suppressed warnings.
  Future<void> clearAllSuppressions() async {
    await init();
    await _box?.delete(_largeFileWarningsKey);
  }

  /// Normalize the file path to ensure consistent matching.
  /// Converts to lowercase on Windows for case-insensitive comparison.
  String _normalizePath(String filePath) {
    // Normalize path separators and case for consistent matching
    String normalized = filePath.replaceAll('\\', '/');
    // On Windows, paths are case-insensitive
    if (defaultTargetPlatform == TargetPlatform.windows) {
      normalized = normalized.toLowerCase();
    }
    return normalized;
  }

  /// Close the repository.
  Future<void> close() async {
    if (_box?.isOpen == true) {
      await _box?.close();
    }
  }
}
