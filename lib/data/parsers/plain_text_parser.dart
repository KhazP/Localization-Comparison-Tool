import 'dart:convert';
import 'dart:io';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';

class PlainTextParser extends LocalizationParser {
  @override
  Future<Map<String, String>> parse(File file, AppSettings settings) async {
    // Parsing TXT file (list-of-phrases format)
    final Map<String, String> translations = {};
    try {
      final encoding = Encoding.getByName(settings.defaultSourceEncoding) ?? utf8;
      final lines = await file.readAsLines(encoding: encoding);
      for (final line in lines) {
        final trimmedLine = line.trim();
        // Skip empty lines and comments (lines starting with // or #)
        if (trimmedLine.isEmpty || trimmedLine.startsWith('//') || trimmedLine.startsWith('#')) {
          continue;
        }
        // For list-of-phrases format, use the line itself as the key and value.
        translations[trimmedLine] = trimmedLine;
      }
      if (translations.isEmpty && lines.any((l) => l.trim().isNotEmpty && !l.trim().startsWith('//') && !l.trim().startsWith('#'))) {
        print('Warning: Parsed ${file.path} but no valid phrases extracted (all lines might be empty or comments).');
      }
    } catch (e) {
        print('Error parsing ${file.path}: $e');
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