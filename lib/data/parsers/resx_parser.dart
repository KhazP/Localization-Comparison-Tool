import 'dart:convert';
import 'dart:io';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:xml/xml.dart' as xml; // Explicitly use alias

class ResxParser extends LocalizationParser {
  @override
  Future<Map<String, String>> parse(File file, AppSettings settings) async {
    final Map<String, String> translations = {};
    try {
      final encoding = Encoding.getByName(settings.defaultSourceEncoding) ?? utf8;
      final String content = await file.readAsString(encoding: encoding);
      if (content.trim().isEmpty) {
        print('Info: RESX file ${file.path} is empty.');
        return translations;
      }
      final xml.XmlDocument document = xml.XmlDocument.parse(content);
      
      final dataElements = document.findAllElements('data');
      for (final element in dataElements) {
        final String? name = element.getAttribute('name');
        // Ensure that we are not looking inside <comment> for <value>
        if (name != null && name.isNotEmpty) {
            final valueElement = element.findElements('value').firstOrNull;
            if (valueElement != null) {
                translations[name] = valueElement.innerText.trim();
            } else {
                // Some RESX entries might not have a <value> if they are for other types (e.g. file links)
                // For string comparison, we can treat these as empty or skip them.
                // Let's store with empty value if name exists but value doesn't for string resource.
                translations[name] = '';
                print('Warning: RESX <data> element with name "$name" in ${file.path} has no <value> child. Stored as empty string.');
            }
        } else {
            // This case should be rare for valid RESX string resources
            final comment = element.findElements('comment').firstOrNull?.innerText ?? "N/A";
            print('Warning: RESX <data> element in ${file.path} is missing a "name" attribute. Comment: "$comment". Skipping element.');
        }
      }
      if (translations.isEmpty && dataElements.isNotEmpty) {
          print('Warning: Parsed RESX file ${file.path} but no valid data entries (name/value pairs) were extracted.');
      } else if (dataElements.isEmpty) {
          print('Info: No <data> elements found in RESX file: ${file.path}');
      }
    } catch (e) {
      print('Error parsing RESX file ${file.path}: $e');
      return {};
    }
    return translations;
  }

  @override
  List<String> getSupportedExtensions() {
    return ['.resx'];
  }
} 