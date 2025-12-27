import 'dart:convert';
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
  }) async {
    final Map<String, String> translations = {};
    try {
      final encoding = Encoding.getByName(settings.defaultSourceEncoding) ?? utf8;
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
          debugPrint('Warning: Detected XML-style .lang file ${file.path} but no valid <string name="key">value</string> entries found.');
        }
      } else {
        // Fall back to plain text parsing (list-of-phrases format)
        final lines = content.split('\n');
        for (final line in lines) {
          final trimmedLine = line.trim();
          // Skip empty lines and comments (lines starting with // or #)
          if (trimmedLine.isEmpty || trimmedLine.startsWith('//') || trimmedLine.startsWith('#')) {
            continue;
          }
          // For list-of-phrases format, use the line itself as the key and value.
          translations[trimmedLine] = trimmedLine;
        }
        if (translations.isEmpty && content.trim().isNotEmpty) {
          debugPrint('Warning: Parsed ${file.path} but no valid phrases extracted (all lines might be empty or comments).');
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

// The StringExtension below is no longer used as .lang files are now parsed as plain text lists,
// and the original key=value logic it supported is not the current format for .lang.
// Removing it to clean up the codebase.

// Helper extension StringExtension can be removed if not used elsewhere after this change.
// For now, keeping it in case other parsers might still use it, or for future refactoring.
// If it was solely for the old .lang parsing logic, it can be cleaned up.
// extension StringExtension on String {
//   List<String> splitN(String pattern, int n) {
//     var parts = <String>[];
//     var current = this;
//     for (var i = 0; i < n - 1; i++) {
//       var index = current.indexOf(pattern);
//       if (index == -1) {
//         break;
//       }
//       parts.add(current.substring(0, index));
//       current = current.substring(index + pattern.length);
//     }
//     parts.add(current);
//     return parts;
//   }
// } 
