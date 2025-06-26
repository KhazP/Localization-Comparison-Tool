import 'dart:io';
import 'dart:convert'; // For utf8 and potentially latin1
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';

class PropertiesParser extends LocalizationParser {
  @override
  Future<Map<String, String>> parse(File file, AppSettings settings) async {
    final Map<String, String> translations = {};
    List<String> lines;
    try {
      // Use encoding from settings, default to utf8 if not found
      final encoding = Encoding.getByName(settings.defaultSourceEncoding) ?? utf8;
      lines = await file.readAsLines(encoding: encoding);
    } catch (e) {
      print('Error reading properties file ${file.path} with specified encoding (${settings.defaultSourceEncoding}): $e');
      return {};
    }
    
    String currentLineBuffer = "";

    for (String line in lines) {
      String trimmedLine = line.trim();

      if (trimmedLine.endsWith('\\')) {
        // Line continuation
        currentLineBuffer += trimmedLine.substring(0, trimmedLine.length - 1);
        continue; 
      } else {
        currentLineBuffer += line; // Add the non-trimmed line if it's the end of a logical line
      }
      
      String logicalLine = currentLineBuffer.trimLeft(); // Trim only left for processing, right trim later
      currentLineBuffer = ""; // Reset buffer

      if (logicalLine.isEmpty || logicalLine.startsWith('#') || logicalLine.startsWith('!')) {
        continue;
      }

      int separatorIndex = -1;
      List<String> possibleSeparators = ['=', ':']; // Whitespace as separator is more complex

      for (String sep in possibleSeparators) {
        int index = logicalLine.indexOf(sep);
        if (index != -1) {
            // Ensure this is not an escaped separator
            if (index == 0 || logicalLine[index-1] != '\\') {
                 separatorIndex = index;
                 break;
            }
        }
      }
      // Fallback to whitespace separator if no = or : found (simplistic)
      if (separatorIndex == -1) {
          separatorIndex = logicalLine.indexOf(RegExp(r'\\s+')); // First whitespace sequence
          if (separatorIndex != -1 && logicalLine.substring(0, separatorIndex).contains(RegExp(r'[=:]'))) {
            separatorIndex = -1; // Invalid if key part already had = or :
          }
      }


      if (separatorIndex != -1) {
        String key = logicalLine.substring(0, separatorIndex).trim();
        String value = logicalLine.substring(separatorIndex + 1).trimLeft(); // Only trim left of value initially

        key = _unescapePropertiesString(key);
        value = _unescapePropertiesString(value);
        
        if (key.isNotEmpty) {
            if (translations.containsKey(key)) {
                 print('Warning: Duplicate key "$key" found in .properties file ${file.path}. Overwriting.');
            }
          translations[key] = value;
        }
      } else if (logicalLine.isNotEmpty) {
        // Line without separator, could be a key with empty value if allowed
        String key = _unescapePropertiesString(logicalLine.trim());
         if (key.isNotEmpty) {
            if (translations.containsKey(key)) {
                 print('Warning: Duplicate key "$key" (no separator) found in .properties file ${file.path}. Overwriting with empty value.');
            }
           translations[key] = '';
           print('Info: Line without separator in ${file.path} treated as key "$key" with empty value: "$logicalLine"');
         }
      }
    }
     if (translations.isEmpty && lines.any((l) => l.trim().isNotEmpty && !l.trim().startsWith('#') && !l.trim().startsWith('!'))) {
        print('Warning: Parsed .properties file ${file.path} but no key-value pairs extracted (check format).');
    }

    return translations;
  }

  String _unescapePropertiesString(String str) {
    // Handle \t, \n, \r, \f, \\, \ , \=, \:, \#, \!
    // And \uXXXX unicode escapes
    str = str.replaceAllMapped(RegExp(r'\\u([0-9a-fA-F]{4})'), (match) {
      return String.fromCharCode(int.parse(match.group(1)!, radix: 16));
    });
    str = str.replaceAll(r'\t', '	'); // Tab - actual tab character
    str = str.replaceAll(r'\n', '\x0A'); // Newline
    str = str.replaceAll(r'\r', '\x0D'); // Carriage return
    str = str.replaceAll(r'\f', ''); // Form feed - actual form feed character
    
    str = str.replaceAll(r'\\', '\uE000'); // Use a private use area char as temp

    // Unescape characters that might have been separators or comment markers
    str = str.replaceAll(r'\=', '=');
    str = str.replaceAll(r'\:', ':');
    str = str.replaceAll(r'\#', '#');
    str = str.replaceAll(r'\!', '!');
    str = str.replaceAll(r'\ ', ' '); // Unescape significant space

    str = str.replaceAll('\uE000', r'\'); 
    return str;
  }

  @override
  List<String> getSupportedExtensions() {
    return ['.properties'];
  }
} 