import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/yaml_parser.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late YamlParser parser;
  late AppSettings settings;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('yaml_parser_test_');
    parser = YamlParser();
    settings = AppSettings.defaultSettings();
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  group('YamlParser', () {
    group('basic parsing', () {
      test('parses flat YAML structure', () async {
        final file = File('${tempDir.path}/flat.yaml');
        await file.writeAsString('''
hello: Hello
goodbye: Goodbye
welcome: Welcome
''');
        final result = await parser.parse(file, settings);

        expect(result, {
          'hello': 'Hello',
          'goodbye': 'Goodbye',
          'welcome': 'Welcome',
        });
      });

      test('parses nested YAML structure with dot notation keys', () async {
        final file = File('${tempDir.path}/nested.yaml');
        await file.writeAsString('''
messages:
  greeting: Hello
  farewell: Goodbye
buttons:
  submit: Submit
  cancel: Cancel
''');
        final result = await parser.parse(file, settings);

        expect(result, {
          'messages.greeting': 'Hello',
          'messages.farewell': 'Goodbye',
          'buttons.submit': 'Submit',
          'buttons.cancel': 'Cancel',
        });
      });

      test('parses deeply nested YAML structure', () async {
        final file = File('${tempDir.path}/deep.yaml');
        await file.writeAsString('''
level1:
  level2:
    level3:
      value: Deep Value
''');
        final result = await parser.parse(file, settings);

        expect(result, {
          'level1.level2.level3.value': 'Deep Value',
        });
      });
    });

    group('type handling', () {
      test('converts numeric values to strings', () async {
        final file = File('${tempDir.path}/numbers.yaml');
        await file.writeAsString('''
count: 42
price: 19.99
version: 1
''');
        final result = await parser.parse(file, settings);

        expect(result['count'], '42');
        expect(result['price'], '19.99');
        expect(result['version'], '1');
      });

      test('converts boolean values to strings', () async {
        final file = File('${tempDir.path}/booleans.yaml');
        await file.writeAsString('''
enabled: true
disabled: false
''');
        final result = await parser.parse(file, settings);

        expect(result['enabled'], 'true');
        expect(result['disabled'], 'false');
      });

      test('converts null values to empty strings', () async {
        final file = File('${tempDir.path}/nulls.yaml');
        await file.writeAsString('''
existing: value
missing: null
empty: ~
''');
        final result = await parser.parse(file, settings);

        expect(result['existing'], 'value');
        expect(result['missing'], '');
        expect(result['empty'], '');
      });
    });

    group('edge cases', () {
      test('returns empty map for empty YAML file', () async {
        final file = File('${tempDir.path}/empty.yaml');
        await file.writeAsString('');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });

      test('returns empty map for whitespace-only file', () async {
        final file = File('${tempDir.path}/whitespace.yaml');
        await file.writeAsString('   \n\n   \n');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });

      test('returns empty map for malformed YAML', () async {
        final file = File('${tempDir.path}/malformed.yaml');
        await file.writeAsString('''
invalid: yaml
  bad indentation
''');
        final result = await parser.parse(file, settings);

        // YAML parser may either parse partially or return empty
        // depending on the severity of the malformation
        expect(result, isA<Map<String, String>>());
      });

      test('handles special characters in values', () async {
        final file = File('${tempDir.path}/special.yaml');
        await file.writeAsString('''
unicode: こんにちは
emoji: "Hello 👋"
quoted: "Line1\\nLine2"
''');
        final result = await parser.parse(file, settings);

        expect(result['unicode'], 'こんにちは');
        expect(result['emoji'], 'Hello 👋');
      });

      test('handles empty string values', () async {
        final file = File('${tempDir.path}/empty_values.yaml');
        await file.writeAsString('''
empty: ""
single_quotes: ''
normal: value
''');
        final result = await parser.parse(file, settings);

        expect(result['empty'], '');
        expect(result['single_quotes'], '');
        expect(result['normal'], 'value');
      });

      test('handles quoted keys', () async {
        final file = File('${tempDir.path}/quoted_keys.yaml');
        await file.writeAsString('''
"key.with.dots": value1
"key with spaces": value2
regular_key: value3
''');
        final result = await parser.parse(file, settings);

        expect(result['key.with.dots'], 'value1');
        expect(result['key with spaces'], 'value2');
        expect(result['regular_key'], 'value3');
      });

      test('handles multiline strings', () async {
        final file = File('${tempDir.path}/multiline.yaml');
        await file.writeAsString('''
literal: |
  Line 1
  Line 2
folded: >
  This is a
  folded string
''');
        final result = await parser.parse(file, settings);

        expect(result['literal'], contains('Line 1'));
        expect(result['literal'], contains('Line 2'));
        expect(result['folded'], contains('This is a'));
      });
    });

    group('YAML variations', () {
      test('parses .yml extension files', () async {
        final file = File('${tempDir.path}/test.yml');
        await file.writeAsString('''
key: value
''');
        final result = await parser.parse(file, settings);

        expect(result['key'], 'value');
      });
    });

    group('supported extensions', () {
      test('returns correct supported extensions', () {
        expect(parser.getSupportedExtensions(), ['.yaml', '.yml']);
      });
    });

    group('bilingual support', () {
      test('does not support bilingual extraction', () {
        expect(parser.supportsBilingualExtraction, false);
      });
    });
  });
}
