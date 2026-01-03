import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:localizer_app_main/data/parsers/csv_parser.dart';
import 'package:localizer_app_main/data/parsers/arb_parser.dart';
import 'package:localizer_app_main/data/parsers/json_parser.dart';
import 'package:localizer_app_main/data/parsers/plain_text_parser.dart';
import 'package:localizer_app_main/data/parsers/properties_parser.dart';
import 'package:localizer_app_main/data/parsers/resx_parser.dart';
import 'package:localizer_app_main/data/parsers/tmx_parser.dart';
import 'package:localizer_app_main/data/parsers/xliff_parser.dart';
import 'package:localizer_app_main/data/parsers/xml_parser.dart';
import 'package:localizer_app_main/data/parsers/yaml_parser.dart';
import 'package:localizer_app_main/data/parsers/docx_parser.dart';

class FileParserFactory {
  final List<LocalizationParser> _parsers;

  FileParserFactory()
      : _parsers = [
          XliffParser(),
          TmxParser(),
          CsvParser(),
          ArbParser(),
          JsonParser(),
          YamlParser(),
          PropertiesParser(),
          ResxParser(),
          PlainTextParser(),
          XmlParser(),
          DocxParser(),
          // Add other parsers here as they are implemented
        ];

  LocalizationParser? getParserForFile(File file, {String? format}) {
    // If format is provided and is not 'Auto', attempt to find a parser that supports that format (mapped to extension)
    if (format != null && format != 'Auto') {
      final targetExt = '.${format.toLowerCase()}';
      for (final parser in _parsers) {
        if (parser.getSupportedExtensions().contains(targetExt)) {
          return parser;
        }
      }
      debugPrint(
          'No parser found for forced format: $format (`$targetExt`). Falling back to file extension.');
    }

    final extension = p.extension(file.path).toLowerCase();
    for (final parser in _parsers) {
      if (parser.getSupportedExtensions().contains(extension)) {
        return parser;
      }
    }
    debugPrint('No parser found for file extension: $extension');
    return null;
  }
}
