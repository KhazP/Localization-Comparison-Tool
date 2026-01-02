/// Utility helpers for super_drag_and_drop integration.
class DragDropUtils {
  /// Supported localization file extensions (lowercase, without dot).
  static const supportedExtensions = {
    'json',
    'xml',
    'xliff',
    'xlf',
    'tmx',
    'csv',
    'yaml',
    'yml',
    'properties',
    'resx',
    'txt',
    'docx',
    'lang',
    'arb',
  };

  /// Returns true if [fileName] has a supported extension.
  static bool isValidFileName(String? fileName) {
    if (fileName == null || fileName.isEmpty) return false;
    final ext = fileName.split('.').last.toLowerCase();
    return supportedExtensions.contains(ext);
  }

  /// Returns true if the path points to a supported file.
  static bool isValidFilePath(String? path) {
    if (path == null || path.isEmpty) return false;
    final fileName = path.split(RegExp(r'[/\\]')).last;
    return isValidFileName(fileName);
  }
}
