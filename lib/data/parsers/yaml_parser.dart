import 'dart:convert';
import 'dart:io';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:yaml/yaml.dart';

class YamlParser extends LocalizationParser {
  @override
  Future<Map<String, String>> parse(File file, AppSettings settings) async {
    final Map<String, String> translations = {};
    try {
      final encoding = Encoding.getByName(settings.defaultSourceEncoding) ?? utf8;
      final String content = await file.readAsString(encoding: encoding);
      if (content.trim().isEmpty) {
        print('Info: YAML file ${file.path} is empty.');
        return translations;
      }
      final dynamic yamlData = loadYaml(content);

      if (yamlData is YamlMap) {
        _flattenYaml(yamlData, '', translations, file.path);
      } else if (yamlData == null) {
        print('Info: YAML file ${file.path} is empty or contains only null.');
      }
      else {
        print('Warning: YAML content in ${file.path} did not parse to a YamlMap (root type: ${yamlData.runtimeType}). Only root maps are supported.');
      }

      if (translations.isEmpty && yamlData is YamlMap && yamlData.isNotEmpty) {
          print('Warning: Parsed YAML file ${file.path} but no valid string translations were extracted (check structure).');
      }

    } catch (e) {
      print('Error parsing YAML file ${file.path}: $e');
      // This can include YamlException
      return {};
    }
    return translations;
  }

  void _flattenYaml(YamlMap yamlMap, String prefix, Map<String, String> translations, String filePath) {
    yamlMap.nodes.forEach((dynamic keyNode, dynamic valueNode) {
      // Keys in YamlMap.nodes are YamlScalar, need .value to get actual key
      final String key = keyNode is YamlScalar ? keyNode.value.toString() : keyNode.toString();
      final String newKey = prefix.isEmpty ? key : '$prefix.$key';
      
      final dynamic value = valueNode is YamlScalar ? valueNode.value : valueNode;

      if (value is String) {
        translations[newKey] = value;
      } else if (value is YamlMap) { // YamlMap from valueNode directly
        _flattenYaml(value, newKey, translations, filePath);
      } else if (valueNode is YamlMap) { // Check valueNode if value isn't YamlMap
         _flattenYaml(valueNode, newKey, translations, filePath);
      }
       else if (value is num || value is bool) {
        translations[newKey] = value.toString();
        print('Info: YAML value for key "$newKey" in $filePath is num/bool, converted to string.');
      } else if (value == null) {
        translations[newKey] = ''; // Null value becomes empty string
        print('Info: YAML value for key "$newKey" in $filePath is null, converted to empty string.');
      }
      // else if (value is YamlList) {
      //   // print('Warning: YAML List found for key "$newKey" in ${filePath}. Converted to string. Consider specific handling.');
      //   // translations[newKey] = value.toString();
      // } 
      else {
        print('Warning: Unsupported YAML value type (${value?.runtimeType}) for key "$newKey" in $filePath. Value: $value');
        // translations[newKey] = value.toString(); // Optional
      }
    });
  }

  @override
  List<String> getSupportedExtensions() {
    return ['.yaml', '.yml'];
  }
} 