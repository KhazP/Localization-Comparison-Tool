import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:xml/xml.dart' as xml;
import 'package:localizer_app_main/data/parsers/localization_parser.dart';

class TmxParser extends LocalizationParser {
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
        debugPrint('Info: TMX file ${file.path} is empty.');
        return translations;
      }
      final xml.XmlDocument document = xml.XmlDocument.parse(content);

      final headerElement = document.findAllElements('header').firstOrNull;
      final sourceLanguage = headerElement?.getAttribute('srclang');

      final bodyElement = document.findAllElements('body').firstOrNull;
      if (bodyElement == null) {
        debugPrint('Warning: No <body> element found in TMX file: ${file.path}');
        return {};
      }

      final tuElements = bodyElement.findElements('tu');
      final targetLanguage = _detectTargetLanguage(
        tuElements,
        sourceLanguage,
      );

      if (requireBilingual) {
        if (sourceLanguage == null || sourceLanguage.isEmpty) {
          throw InvalidBilingualFileException(
            'This file does not include both the original text and the '
            'translation.',
          );
        }
        if (targetLanguage == null || targetLanguage.isEmpty) {
          throw InvalidBilingualFileException(
            'This file does not include both the original text and the '
            'translation.',
          );
        }
      }

      for (final tuElement in tuElements) {
        String? key;
        String? value;

        final String? tuid = tuElement.getAttribute('tuid');

        final tuvElements = tuElement.findElements('tuv').toList();

        if (tuvElements.isNotEmpty) {
          final sourceTuv =
              _findTuvForLanguage(tuvElements, sourceLanguage);
          final targetTuv =
              _findTuvForLanguage(tuvElements, targetLanguage);

          final sourceSeg = sourceTuv.findElements('seg').firstOrNull;
          final targetSeg = targetTuv.findElements('seg').firstOrNull;

          final sourceText = sourceSeg?.innerText.trim() ?? '';
          final targetText = targetSeg?.innerText.trim() ?? '';

          if (tuid != null && tuid.isNotEmpty) {
            key = tuid;
          } else if (sourceText.isNotEmpty) {
            key = sourceText;
          }

          if (extractionMode == ExtractionMode.source) {
            value = sourceText;
          } else {
            value = targetText;
          }

          if (sourceSeg == null && sourceLanguage != null) {
            debugPrint(
                'Warning: Missing source <seg> for tuid "$tuid" in ${file.path}');
          }
          if (targetSeg == null && targetLanguage != null) {
            debugPrint(
                'Warning: Missing target <seg> for tuid "$tuid" in ${file.path}');
          }
        } else {
          debugPrint('Warning: TMX <tu> element does not have at least two <tuv> children or a single <tuv> with a tuid. Skipping. ID: "$tuid", File: ${file.path}');
        }

        if (key != null && key.isNotEmpty && value != null) {
          if (translations.containsKey(key)) {
            debugPrint('Warning: Duplicate key "$key" found in TMX file ${file.path}. Overwriting previous value.');
          }
          translations[key] = value;
        } else if (key != null && key.isNotEmpty && value == null) {
            // Key was determined (e.g. tuid) but no valid value found from TUVs
            translations[key] = ''; // Store with empty value
            debugPrint('Warning: Key "$key" determined for TMX but no valid value found from TUVs. Storing with empty value. File: ${file.path}');
        }
      }
      if (translations.isEmpty && tuElements.isNotEmpty) {
          debugPrint('Warning: Parsed TMX file ${file.path} but no valid translation entries were extracted.');
      } else if (tuElements.isEmpty) {
          debugPrint('Warning: No <tu> elements found in TMX file: ${file.path}');
      }

    } catch (e) {
      debugPrint('Error parsing TMX file ${file.path}: $e');
      return {};
    }
    return translations;
  }

  String? _detectTargetLanguage(
    Iterable<xml.XmlElement> tuElements,
    String? sourceLanguage,
  ) {
    if (sourceLanguage == null || sourceLanguage.isEmpty) {
      return null;
    }

    for (final tuElement in tuElements) {
      for (final tuvElement in tuElement.findElements('tuv')) {
        final language = _readLanguage(tuvElement);
        if (language != null &&
            language.isNotEmpty &&
            !_matchesLanguage(language, sourceLanguage)) {
          return language;
        }
      }
    }

    return null;
  }

  xml.XmlElement _findTuvForLanguage(
    List<xml.XmlElement> tuvElements,
    String? language,
  ) {
    if (language == null || language.isEmpty) {
      return tuvElements.first;
    }

    return tuvElements.firstWhere(
      (element) => _matchesLanguage(_readLanguage(element), language),
      orElse: () => tuvElements.first,
    );
  }

  String? _readLanguage(xml.XmlElement element) {
    return element.getAttribute('xml:lang') ?? element.getAttribute('lang');
  }

  bool _matchesLanguage(String? value, String other) {
    if (value == null) {
      return false;
    }
    return value.toLowerCase() == other.toLowerCase();
  }

  @override
  bool get supportsBilingualExtraction => true;

  @override
  List<String> getSupportedExtensions() {
    return ['.tmx'];
  }
}
