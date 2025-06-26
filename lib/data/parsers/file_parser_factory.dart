import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:localizer_app_main/data/parsers/csv_parser.dart';
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

  FileParserFactory() : _parsers = [
    XliffParser(),
    TmxParser(),
    CsvParser(),
    JsonParser(),
    YamlParser(),
    PropertiesParser(),
    ResxParser(),
    PlainTextParser(),
    XmlParser(),
    DocxParser(),
    // Add other parsers here as they are implemented
  ];

  LocalizationParser?getParserForFile(File file) {
    final extension = p.extension(file.path).toLowerCase();
    for (final parser in _parsers) {
      if (parser.getSupportedExtensions().contains(extension)) {
        return parser;
      }
    }
    print('No parser found for file extension: $extension');
    return null; // Or throw an exception, or return a default/dummy parser
  }
} 