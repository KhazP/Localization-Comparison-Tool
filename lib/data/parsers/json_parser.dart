import 'dart:io';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';

class JsonParser extends LocalizationParser {
  @override
  Future<Map<String, String>> parse(File file, AppSettings settings) async {
    final Map<String, String> translations = {};
    try {
      final encoding = Encoding.getByName(settings.defaultSourceEncoding) ?? utf8;
      final String content = await file.readAsString(encoding: encoding);
      if (content.isEmpty) {
        debugPrint('Info: JSON file ${file.path} is empty.');
        return translations;
      }
      final Map<String, dynamic> jsonData = json.decode(content);
      
      _flattenJson(jsonData, '', translations, file.path);

      if (translations.isEmpty && jsonData.isNotEmpty) {
          debugPrint('Warning: Parsed JSON file ${file.path} but no valid string translations were extracted (check structure).');
      } else if (jsonData.isEmpty) {
          debugPrint('Info: JSON file ${file.path} is empty or contains no top-level entries.');
      }

    } catch (e) {
      debugPrint('Error parsing JSON file ${file.path}: $e');
      return {};
    }
    return translations;
  }

  void _flattenJson(Map<String, dynamic> jsonMap, String prefix, Map<String, String> translations, String filePath) {
    jsonMap.forEach((key, value) {
      final String newKey = prefix.isEmpty ? key : '$prefix.$key';
      if (value is String) {
        translations[newKey] = value;
      } else if (value is Map<String, dynamic>) {
        _flattenJson(value, newKey, translations, filePath);
      } else if (value is num || value is bool) {
        translations[newKey] = value.toString();
         debugPrint('Info: JSON value for key "$newKey" in $filePath is num/bool, converted to string.');
      } else if (value == null) {
        translations[newKey] = ''; // Null value becomes empty string
        debugPrint('Info: JSON value for key "$newKey" in $filePath is null, converted to empty string.');
      }
      // else if (value is List) {
      //   // Decide how to handle lists. For now, convert to string or ignore.
      //   // translations[newKey] = value.toString(); 
      //   // print('Warning: JSON List found for key "$newKey" in ${filePath}. Converted to string. Consider specific handling.');
      // } 
      else {
         // For other types, including List for now, treat as non-translatable string or skip.
         debugPrint('Warning: Unsupported JSON value type (${value.runtimeType}) for key "$newKey" in $filePath. Skipping or using toString(). Value: $value');
         // translations[newKey] = value.toString(); // Optional: convert everything else to string
      }
    });
  }

  @override
  List<String> getSupportedExtensions() {
    return ['.json'];
  }
} 