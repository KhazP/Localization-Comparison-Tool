import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:xml/xml.dart' as xml_package; // Renamed to avoid conflict

class XmlParser extends LocalizationParser {
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
      if (content.trim().isEmpty) {
        debugPrint('Info: XML file ${file.path} is empty.');
        return translations;
      }
      final xml_package.XmlDocument document = xml_package.XmlDocument.parse(content);

      // Attempt 1: Android strings.xml style: <string name="key">value</string>
      document.findAllElements('string').forEach((element) {
        final String? name = element.getAttribute('name');
        if (name != null && name.isNotEmpty) {
          translations[name] = element.innerText.trim();
        }
      });

      // Attempt 2: If first attempt yielded nothing, try simple <key>value</key>
      if (translations.isEmpty && document.rootElement.children.isNotEmpty) {
        debugPrint('Info: No <string name="key"> elements found in ${file.path}. Attempting <key>value</key> structure.');
        for (var node in document.rootElement.children) {
          if (node is xml_package.XmlElement) {
            // Ensure the element has exactly one child and that child is text
            // Also check that the element itself doesn't have attributes that might signify a more complex structure
            if (node.children.length == 1 && node.children.first is xml_package.XmlText && node.attributes.isEmpty) {
              final String key = node.name.local;
              final String value = node.innerText.trim();
              if (key.isNotEmpty) {
                if (translations.containsKey(key)) {
                     debugPrint('Warning: Duplicate key "$key" found in XML file ${file.path} (generic structure). Overwriting.');
                }
                translations[key] = value;
              }
            }
          }
        }
      }
      
      if (translations.isEmpty) {
        debugPrint("Warning: XML file ${file.path} could not be parsed into key-value pairs with common generic structures.");
      }

    } catch (e) {
      debugPrint('Error parsing generic XML file ${file.path}: $e');
      return {};
    }
    return translations;
  }

  @override
  List<String> getSupportedExtensions() {
    return ['.xml'];
  }
} 
