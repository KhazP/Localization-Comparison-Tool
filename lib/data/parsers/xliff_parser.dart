import 'dart:convert';
import 'dart:io';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:xml/xml.dart' as xml;
import 'package:localizer_app_main/data/parsers/localization_parser.dart';

class XliffParser extends LocalizationParser {
  @override
  Future<Map<String, String>> parse(File file, AppSettings settings) async {
    final Map<String, String> translations = {};
    try {
      final encoding = Encoding.getByName(settings.defaultSourceEncoding) ?? utf8;
      final String content = await file.readAsString(encoding: encoding);
      if (content.trim().isEmpty) {
        print('Info: XLIFF file ${file.path} is empty.');
        return translations;
      }
      final xml.XmlDocument document = xml.XmlDocument.parse(content);

      // Find all <file> elements.
      // According to XLIFF 2.0 spec, they are typically under /xliff/file/unit
      // However, to be more robust, we can search for them anywhere if the structure is flatter
      // or if there are multiple <file> elements.
      // For now, let's assume a standard structure for XLIFF 2.0: xliff -> file -> unit
      
      final fileElements = document.findAllElements('file');
      if (fileElements.isEmpty) {
        print('Warning: No <file> elements found in XLIFF: ${file.path}');
        // Try finding unit elements directly under xliff if no <file> elements are present
        // This is not standard but provides some resilience
        final xliffRoot = document.rootElement; // <xliff>
        _parseUnits(xliffRoot.findElements('unit'), translations, file.path);

      } else {
         for (final fileElement in fileElements) {
          _parseUnits(fileElement.findElements('unit'), translations, file.path);
        }
      }
      
      if (translations.isEmpty && fileElements.isNotEmpty) {
        // If still no translations but <file> elements existed, maybe units are directly under <xliff>?
        // This is less common but could be a fallback.
        final xliffRoot = document.rootElement;
        final directUnits = xliffRoot.findElements('unit').where((unit) => 
            !fileElements.any((fe) => fe.descendants.contains(unit))
        ).toList();
        if (directUnits.isNotEmpty) {
           print('Info: Found <unit> elements directly under <xliff> in ${file.path}');
          _parseUnits(directUnits, translations, file.path);
        }
      }


      if (translations.isEmpty) {
          print('Warning: No translation units found or parsed in XLIFF file: ${file.path}');
      }

    } catch (e) {
      print('Error parsing XLIFF file ${file.path}: $e');
      // Return empty map or throw a more specific error
      // For now, returning empty allows comparison to proceed with other file if it's valid
      return {}; 
    }
    return translations;
  }

  void _parseUnits(Iterable<xml.XmlElement> units, Map<String, String> translations, String filePath) {
    for (final unitElement in units) {
        final String? id = unitElement.getAttribute('id');
        if (id != null && id.isNotEmpty) {
          // Find <segment> then <target>
          final segments = unitElement.findElements('segment');
          if (segments.isNotEmpty) {
            // Typically, we process the first segment's target.
            // Some complex XLIFFs might have multiple segments per unit.
            // For this tool, we'll assume the first <segment> and its <target> is primary.
            final targetElement = segments.first.findElements('target').firstOrNull;
            if (targetElement != null) {
              translations[id] = targetElement.innerText.trim();
            } else {
              // If target is missing, store key with empty string or some placeholder?
              // Empty string is consistent with how other parsers might handle missing values.
              translations[id] = ''; 
              print('Warning: No <target> found for unit id "$id" in segment in $filePath');
            }
          } else {
            // Fallback for XLIFF 1.2 style where <target> might be directly under <trans-unit> (equivalent of <unit>)
            // This parser is primarily for XLIFF 2.0, but this adds a little flexibility.
            // For XLIFF 2.0, <unit> contains <segment>, which contains <source> and <target>.
            // If no <segment>, it implies a structural issue for XLIFF 2.0.
             final directTargetElement = unitElement.findElements('target').firstOrNull;
             if (directTargetElement != null) {
                translations[id] = directTargetElement.innerText.trim();
                 print('Info: Found direct <target> for unit id "$id" (possibly XLIFF 1.2 style or simplified 2.0) in $filePath');
             } else {
                translations[id] = '';
                print('Warning: No <segment> or direct <target> found for unit id "$id" in $filePath');
             }
          }
        } else {
          print('Warning: Found <unit> element without an id in $filePath');
        }
      }
  }


  @override
  List<String> getSupportedExtensions() {
    return ['.xlf', '.xliff'];
  }
} 