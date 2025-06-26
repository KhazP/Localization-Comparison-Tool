import 'dart:convert';
import 'dart:io';
// For utf8
import 'package:csv/csv.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
// It's good practice to use a robust CSV parsing library for production
// For this MVP, we'll do a simple split, assuming a simple Key,Value structure

class CsvParser extends LocalizationParser {
  @override
  Future<Map<String, String>> parse(File file, AppSettings settings) async {
    final Map<String, String> translations = {};
    try {
      // Respect the encoding setting from AppSettings
      final encoding = Encoding.getByName(settings.defaultSourceEncoding) ?? utf8;

      // Read file content with the specified encoding
      // Note: BOM handling is often automatic with Dart's File.readAsString,
      // but being explicit can be safer if issues arise.
      final String content = await file.readAsString(encoding: encoding);
      
      // Use the CsvToListConverter from the csv package, configured with settings
      final converter = CsvToListConverter(
        fieldDelimiter: settings.csvDelimiter,
        shouldParseNumbers: false,
        // The 'csv' package handles BOM automatically when reading the string.
        // If specific manual handling for `settings.handleByteOrderMark` were needed,
        // it would involve pre-processing the `content` string, but it's typically not required.
      );
      final List<List<dynamic>> rowsAsListOfValues = converter.convert(content);

      if (rowsAsListOfValues.isEmpty) {
        print('Warning: CSV file is empty or could not be parsed: ${file.path}');
        return translations;
      }

      // Skip header row (optional, but common)
      // Start from index 1 if there's more than one row
      final startIndex = rowsAsListOfValues.length > 1 ? 1 : 0;

      for (int i = startIndex; i < rowsAsListOfValues.length; i++) {
        final row = rowsAsListOfValues[i];
        if (row.length >= 2) {
          final String key = row[0].toString().trim();
          final String value = row[1].toString().trim();

          if (key.isNotEmpty) {
            if (translations.containsKey(key)) {
              print('Warning: Duplicate key "$key" found in CSV file ${file.path} (row ${i+1}). Overwriting previous value.');
            }
            translations[key] = value;
          } else {
            print('Warning: Empty key found in CSV file ${file.path} (row ${i+1}). Skipping entry.');
          }
        } else {
          print('Warning: Row ${i+1} in CSV file ${file.path} does not have at least two columns. Skipping row.');
        }
      }
       if (translations.isEmpty && rowsAsListOfValues.isNotEmpty) {
          print('Warning: Parsed CSV file ${file.path} but no valid key-value pairs were extracted (check header or column count).');
      }
    } catch (e) {
      print('Error parsing CSV file ${file.path}: $e');
      // Consider if specific CsvParserException types from the package need special handling
      return {};
    }
    return translations;
  }

  @override
  List<String> getSupportedExtensions() {
    return ['.csv'];
  }
} 