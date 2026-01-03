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
