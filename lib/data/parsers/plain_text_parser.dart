import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';

class PlainTextParser extends LocalizationParser {
  // Pattern to detect XML-style localization strings: <string name="key">value</string>
  static final RegExp _xmlStringPattern = RegExp(
    r'<string\s+name="([^"]+)"[^>]*>([^<]*)</string>',
    multiLine: true,
  );

  @override
  Future<Map<String, String>> parse(
    File file,
    AppSettings settings, {
    ExtractionMode extractionMode = ExtractionMode.target,
    bool requireBilingual = false,
    ParseProgressCallback? onProgress,
  }) async {
    final Map<String, String> translations = {};
    try {
      // SECURITY: Validate file size before reading
      await validateFileSize(file);

      final encoding = resolveEncoding(settings, extractionMode);
      final String content = await file.readAsString(encoding: encoding);

      // Check if this is an XML-style .lang file
      if (_xmlStringPattern.hasMatch(content)) {
        // Parse as XML-style localization file
        for (final match in _xmlStringPattern.allMatches(content)) {
          final String? key = match.group(1);
          final String? value = match.group(2);
          if (key != null && key.isNotEmpty) {
            translations[key] = value?.trim() ?? '';
          }
        }
        if (translations.isEmpty) {
          debugPrint(
              'Warning: Detected XML-style .lang file ${file.path} but no valid <string name="key">value</string> entries found.');
        }
      } else {
        // Fall back to plain text parsing (key=value or list-of-phrases format)
        final lines = content.split('\n');
        for (final line in lines) {
          final trimmedLine = line.trim();
          // Skip empty lines and comments (lines starting with // or #)
          if (trimmedLine.isEmpty ||
              trimmedLine.startsWith('//') ||
              trimmedLine.startsWith('#')) {
            continue;
          }
          // Check for key=value format (common in .lang and .properties files)
          final equalsIndex = trimmedLine.indexOf('=');
          if (equalsIndex > 0) {
            final key = trimmedLine.substring(0, equalsIndex).trim();
            final value = trimmedLine.substring(equalsIndex + 1).trim();
            if (key.isNotEmpty) {
              translations[key] = value;
            }
          } else {
            // For list-of-phrases format, use the line itself as the key and value.
            translations[trimmedLine] = trimmedLine;
          }
        }
        if (translations.isEmpty && content.trim().isNotEmpty) {
          debugPrint(
              'Warning: Parsed ${file.path} but no valid phrases extracted (all lines might be empty or comments).');
        }
      }
    } catch (e) {
      debugPrint('Error parsing ${file.path}: $e');
      return {};
    }
    return translations;
  }

  @override
  List<String> getSupportedExtensions() {
    return ['.txt', '.lang'];
  }
}
