import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';

/// Parses ARB localization files while skipping metadata entries.
class ArbParser extends LocalizationParser {
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
      final content = await file.readAsString(encoding: encoding);
      if (content.isEmpty) {
        debugPrint('Info: ARB file ${file.path} is empty.');
        return translations;
      }
      final Map<String, dynamic> jsonData = json.decode(content);
      _flattenArb(jsonData, '', translations, file.path);

      if (translations.isEmpty && jsonData.isNotEmpty) {
        debugPrint(
          'Warning: Parsed ARB file ${file.path} but no valid translations '
          'were extracted.',
        );
      } else if (jsonData.isEmpty) {
        debugPrint('Info: ARB file ${file.path} has no entries.');
      }
    } catch (error) {
      debugPrint('Error parsing ARB file ${file.path}: $error');
      return {};
    }
    return translations;
  }

  void _flattenArb(
    Map<String, dynamic> jsonMap,
    String prefix,
    Map<String, String> translations,
    String filePath,
  ) {
    jsonMap.forEach((key, value) {
      if (key.startsWith('@')) {
        return;
      }
      final newKey = prefix.isEmpty ? key : '$prefix.$key';
      if (value is String) {
        translations[newKey] = value;
      } else if (value is Map<String, dynamic>) {
        _flattenArb(value, newKey, translations, filePath);
      } else if (value is num || value is bool) {
        translations[newKey] = value.toString();
        debugPrint(
          'Info: ARB value for key "$newKey" in $filePath is num/bool, '
          'converted to string.',
        );
      } else if (value == null) {
        translations[newKey] = '';
        debugPrint(
          'Info: ARB value for key "$newKey" in $filePath is null, '
          'converted to empty string.',
        );
      } else {
        debugPrint(
          'Warning: Unsupported ARB value type (${value.runtimeType}) for '
          'key "$newKey" in $filePath. Skipping.',
        );
      }
    });
  }

  @override
  List<String> getSupportedExtensions() {
    return ['.arb'];
  }
}
