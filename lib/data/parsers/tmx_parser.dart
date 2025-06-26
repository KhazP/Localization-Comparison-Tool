import 'dart:convert';
import 'dart:io';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:xml/xml.dart' as xml;
import 'package:localizer_app_main/data/parsers/localization_parser.dart';

class TmxParser extends LocalizationParser {
  @override
  Future<Map<String, String>> parse(File file, AppSettings settings) async {
    final Map<String, String> translations = {};
    try {
      final encoding = Encoding.getByName(settings.defaultSourceEncoding) ?? utf8;
      final String content = await file.readAsString(encoding: encoding);
      if (content.trim().isEmpty) {
        print('Info: TMX file ${file.path} is empty.');
        return translations;
      }
      final xml.XmlDocument document = xml.XmlDocument.parse(content);

      final bodyElement = document.findAllElements('body').firstOrNull;
      if (bodyElement == null) {
        print('Warning: No <body> element found in TMX file: ${file.path}');
        return {};
      }

      final tuElements = bodyElement.findElements('tu');

      for (final tuElement in tuElements) {
        String? key;
        String? value;

        final String? tuid = tuElement.getAttribute('tuid');

        final tuvElements = tuElement.findElements('tuv').toList();

        if (tuvElements.length >= 2) {
          // First TUV is source, second TUV is target
          final sourceTuv = tuvElements[0];
          final targetTuv = tuvElements[1];

          final sourceSeg = sourceTuv.findElements('seg').firstOrNull;
          final targetSeg = targetTuv.findElements('seg').firstOrNull;

          if (sourceSeg != null && targetSeg != null) {
            final String sourceText = sourceSeg.innerText.trim();
            final String targetText = targetSeg.innerText.trim();

            if (tuid != null && tuid.isNotEmpty) {
              key = tuid;
            } else if (sourceText.isNotEmpty) {
              key = sourceText;
            }

            value = targetText;
          } else {
            print('Warning: Missing <seg> in <tuv> for tuid "$tuid" or equivalent in ${file.path}');
          }
        } else if (tuvElements.length == 1 && (tuid != null && tuid.isNotEmpty)) {
          // If only one TUV but has a TUID, could be a source-only entry.
          // Store with empty value, assuming it's a key that needs translation.
          final sourceTuv = tuvElements[0];
          final sourceSeg = sourceTuv.findElements('seg').firstOrNull;
          if (sourceSeg != null) {
              key = tuid;
              value = sourceSeg.innerText.trim(); // Or value = ""; if we strictly want target
              print('Info: TMX <tu> with tuid "$tuid" has only one <tuv>. Using its text as value. In file: ${file.path}');
          }
        }
        
        else {
          print('Warning: TMX <tu> element does not have at least two <tuv> children or a single <tuv> with a tuid. Skipping. ID: "$tuid", File: ${file.path}');
        }

        if (key != null && key.isNotEmpty && value != null) {
          if (translations.containsKey(key)) {
            print('Warning: Duplicate key "$key" found in TMX file ${file.path}. Overwriting previous value.');
          }
          translations[key] = value;
        } else if (key != null && key.isNotEmpty && value == null) {
            // Key was determined (e.g. tuid) but no valid value found from TUVs
            translations[key] = ''; // Store with empty value
            print('Warning: Key "$key" determined for TMX but no valid value found from TUVs. Storing with empty value. File: ${file.path}');
        }
      }
      if (translations.isEmpty && tuElements.isNotEmpty) {
          print('Warning: Parsed TMX file ${file.path} but no valid translation entries were extracted.');
      } else if (tuElements.isEmpty) {
          print('Warning: No <tu> elements found in TMX file: ${file.path}');
      }

    } catch (e) {
      print('Error parsing TMX file ${file.path}: $e');
      return {};
    }
    return translations;
  }

  @override
  List<String> getSupportedExtensions() {
    return ['.tmx'];
  }
} 