import 'dart:convert';
import 'dart:io';
import 'package:localizer_app_main/data/models/app_settings.dart';

/// Identifies which side of a bilingual file should be extracted.
enum ExtractionMode { source, target }

/// Callback for reporting parsing progress.
/// [bytesRead] is the number of bytes processed so far.
/// [totalBytes] is the total file size (may be 0 if unknown).
/// [stage] describes the current operation (e.g., "Reading file", "Parsing").
typedef ParseProgressCallback = void Function(
  int bytesRead,
  int totalBytes,
  String stage,
);

/// Thrown when a file does not include both source and target text.
class InvalidBilingualFileException implements Exception {
  InvalidBilingualFileException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Thrown when a file exceeds the maximum allowed size.
/// SECURITY: Prevents DoS attacks via extremely large files.
class FileTooLargeException implements Exception {
  FileTooLargeException(this.fileSize, this.maxSize);

  final int fileSize;
  final int maxSize;

  @override
  String toString() =>
      'File too large: ${_formatBytes(fileSize)} (max: ${_formatBytes(maxSize)})';

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

/// Maximum file size for parsing (50 MB).
/// SECURITY: Prevents memory exhaustion from extremely large files.
const int maxParseFileSize = 50 * 1024 * 1024;

/// Validates that a file does not exceed the maximum allowed size.
/// Throws [FileTooLargeException] if the file is too large.
Future<void> validateFileSize(File file, {int? maxSize}) async {
  final size = await file.length();
  final limit = maxSize ?? maxParseFileSize;
  if (size > limit) {
    throw FileTooLargeException(size, limit);
  }
}

/// Base contract for localization parsers.
abstract class LocalizationParser {
  /// Parses a localization file into key/value pairs.
  ///
  /// [onProgress] is an optional callback for reporting parsing progress.
  /// Parsers may call this periodically during file reading and parsing
  /// to provide real-time feedback to the UI.
  Future<Map<String, String>> parse(
    File file,
    AppSettings settings, {
    ExtractionMode extractionMode = ExtractionMode.target,
    bool requireBilingual = false,
    ParseProgressCallback? onProgress,
  });

  /// Whether this parser can extract source and target from a single file.
  bool get supportsBilingualExtraction => false;
  List<String> getSupportedExtensions();
}

/// Returns the encoding to use for the requested extraction side.
Encoding resolveEncoding(
  AppSettings settings,
  ExtractionMode extractionMode,
) {
  final encodingName = extractionMode == ExtractionMode.source
      ? settings.defaultSourceEncoding
      : settings.defaultTargetEncoding;
  return Encoding.getByName(encodingName) ?? utf8;
}
