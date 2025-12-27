import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:xml/xml.dart' as xml;
import 'package:localizer_app_main/data/parsers/localization_parser.dart';

class XliffParser extends LocalizationParser {
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
        debugPrint('Info: XLIFF file ${file.path} is empty.');
        return translations;
      }
      final xml.XmlDocument document = xml.XmlDocument.parse(content);

      final xliffRoot = document.rootElement;
      String? sourceLanguage = xliffRoot.getAttribute('srcLang') ??
          xliffRoot.getAttribute('source-language');
      String? targetLanguage = xliffRoot.getAttribute('trgLang') ??
          xliffRoot.getAttribute('target-language');

      // Find all <file> elements.
      // According to XLIFF 2.0 spec, they are typically under /xliff/file/unit
      // However, to be more robust, we can search for them anywhere if the structure is flatter
      // or if there are multiple <file> elements.
      // For now, let's assume a standard structure for XLIFF 2.0: xliff -> file -> unit
      
      final fileElements = document.findAllElements('file');
      if (fileElements.isEmpty) {
        debugPrint('Warning: No <file> elements found in XLIFF: ${file.path}');
        // Try finding unit elements directly under xliff if no <file> elements are present
        // This is not standard but provides some resilience
        _parseUnits(
          xliffRoot.findElements('unit'),
          translations,
          file.path,
          extractionMode: extractionMode,
        );

      } else {
         for (final fileElement in fileElements) {
          sourceLanguage ??= fileElement.getAttribute('srcLang') ??
              fileElement.getAttribute('source-language');
          targetLanguage ??= fileElement.getAttribute('trgLang') ??
              fileElement.getAttribute('target-language');
          _parseUnits(
            fileElement.findElements('unit'),
            translations,
            file.path,
            extractionMode: extractionMode,
          );
        }
      }
      
      if (translations.isEmpty && fileElements.isNotEmpty) {
        // If still no translations but <file> elements existed, maybe units are directly under <xliff>?
        // This is less common but could be a fallback.
        final directUnits = xliffRoot.findElements('unit').where((unit) => 
            !fileElements.any((fe) => fe.descendants.contains(unit))
        ).toList();
        if (directUnits.isNotEmpty) {
           debugPrint('Info: Found <unit> elements directly under <xliff> in ${file.path}');
          _parseUnits(
            directUnits,
            translations,
            file.path,
            extractionMode: extractionMode,
          );
        }
      }

      if (requireBilingual) {
        if (sourceLanguage == null || sourceLanguage.isEmpty) {
          debugPrint(
              'Warning: Missing source language in XLIFF headers: ${file.path}');
        }
        if (targetLanguage == null || targetLanguage.isEmpty) {
          debugPrint(
              'Warning: Missing target language in XLIFF headers: ${file.path}');
        }
        if (!_hasBilingualElements(document)) {
          throw InvalidBilingualFileException(
            'This file does not include both the original text and the '
            'translation.',
          );
        }
      }

      if (translations.isEmpty) {
          debugPrint('Warning: No translation units found or parsed in XLIFF file: ${file.path}');
      }

    } catch (e) {
      debugPrint('Error parsing XLIFF file ${file.path}: $e');
      // Return empty map or throw a more specific error
      // For now, returning empty allows comparison to proceed with other file if it's valid
      return {}; 
    }
    return translations;
  }

  bool _hasBilingualElements(xml.XmlDocument document) {
    final hasSource = document.findAllElements('source').isNotEmpty;
    final hasTarget = document.findAllElements('target').isNotEmpty;
    return hasSource && hasTarget;
  }

  void _parseUnits(
    Iterable<xml.XmlElement> units,
    Map<String, String> translations,
    String filePath, {
    required ExtractionMode extractionMode,
  }) {
    for (final unitElement in units) {
        final String? id = unitElement.getAttribute('id');
        if (id != null && id.isNotEmpty) {
          // Find <segment> then <target>
          final segments = unitElement.findElements('segment');
          if (segments.isNotEmpty) {
            // Typically, we process the first segment's target.
            // Some complex XLIFFs might have multiple segments per unit.
            // For this tool, we'll assume the first <segment> and its <target> is primary.
            final segment = segments.first;
            final sourceElement = segment.findElements('source').firstOrNull;
            final targetElement = segment.findElements('target').firstOrNull;
            if (extractionMode == ExtractionMode.source) {
              translations[id] = sourceElement?.innerText.trim() ?? '';
              if (sourceElement == null) {
                debugPrint(
                    'Warning: No <source> found for unit id "$id" in $filePath');
              }
            } else {
              translations[id] = targetElement?.innerText.trim() ?? '';
              if (targetElement == null) {
                debugPrint(
                    'Warning: No <target> found for unit id "$id" in $filePath');
              }
            }
          } else {
            // Fallback for XLIFF 1.2 style where <target> might be directly under <trans-unit> (equivalent of <unit>)
            // This parser is primarily for XLIFF 2.0, but this adds a little flexibility.
            // For XLIFF 2.0, <unit> contains <segment>, which contains <source> and <target>.
            // If no <segment>, it implies a structural issue for XLIFF 2.0.
             final directSourceElement =
                 unitElement.findElements('source').firstOrNull;
             final directTargetElement =
                 unitElement.findElements('target').firstOrNull;
             if (extractionMode == ExtractionMode.source) {
               translations[id] = directSourceElement?.innerText.trim() ?? '';
               if (directSourceElement != null) {
                 debugPrint(
                     'Info: Found direct <source> for unit id "$id" in $filePath');
               } else {
                 debugPrint(
                     'Warning: No <segment> or direct <source> found for unit id "$id" in $filePath');
               }
             } else {
               if (directTargetElement != null) {
                 translations[id] = directTargetElement.innerText.trim();
                 debugPrint(
                     'Info: Found direct <target> for unit id "$id" in $filePath');
               } else {
                 translations[id] = '';
                 debugPrint(
                     'Warning: No <segment> or direct <target> found for unit id "$id" in $filePath');
               }
             }
          }
        } else {
          debugPrint('Warning: Found <unit> element without an id in $filePath');
        }
      }
  }

  @override
  bool get supportsBilingualExtraction => true;

  @override
  List<String> getSupportedExtensions() {
    return ['.xlf', '.xliff'];
  }
}
