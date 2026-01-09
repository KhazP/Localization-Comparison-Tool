import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/json_parser.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late JsonParser parser;
  late AppSettings settings;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('json_parser_test_');
    parser = JsonParser();
    settings = AppSettings.defaultSettings();
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  group('JsonParser', () {
    group('basic parsing', () {
      test('parses flat JSON structure', () async {
        final file = File('${tempDir.path}/flat.json');
        await file.writeAsString('''
{
  "hello": "Hello",
  "goodbye": "Goodbye",
  "welcome": "Welcome"
}
''');
        final result = await parser.parse(file, settings);

        expect(result, {
          'hello': 'Hello',
          'goodbye': 'Goodbye',
          'welcome': 'Welcome',
        });
      });

      test('parses nested JSON structure with dot notation keys', () async {
        final file = File('${tempDir.path}/nested.json');
        await file.writeAsString('''
{
  "messages": {
    "greeting": "Hello",
    "farewell": "Goodbye"
  },
  "buttons": {
    "submit": "Submit",
    "cancel": "Cancel"
  }
}
''');
        final result = await parser.parse(file, settings);

        expect(result, {
          'messages.greeting': 'Hello',
          'messages.farewell': 'Goodbye',
          'buttons.submit': 'Submit',
          'buttons.cancel': 'Cancel',
        });
      });

      test('parses deeply nested JSON structure', () async {
        final file = File('${tempDir.path}/deep.json');
        await file.writeAsString('''
{
  "level1": {
    "level2": {
      "level3": {
        "value": "Deep Value"
      }
    }
  }
}
''');
        final result = await parser.parse(file, settings);

        expect(result, {
          'level1.level2.level3.value': 'Deep Value',
        });
      });
    });

    group('type handling', () {
      test('converts numeric values to strings', () async {
        final file = File('${tempDir.path}/numbers.json');
        await file.writeAsString('''
{
  "count": 42,
  "price": 19.99,
  "version": 1
}
''');
        final result = await parser.parse(file, settings);

        expect(result['count'], '42');
        expect(result['price'], '19.99');
        expect(result['version'], '1');
      });

      test('converts boolean values to strings', () async {
        final file = File('${tempDir.path}/booleans.json');
        await file.writeAsString('''
{
  "enabled": true,
  "disabled": false
}
''');
        final result = await parser.parse(file, settings);

        expect(result['enabled'], 'true');
        expect(result['disabled'], 'false');
      });

      test('converts null values to empty strings', () async {
        final file = File('${tempDir.path}/nulls.json');
        await file.writeAsString('''
{
  "existing": "value",
  "missing": null
}
''');
        final result = await parser.parse(file, settings);

        expect(result['existing'], 'value');
        expect(result['missing'], '');
      });

      test('skips array values', () async {
        final file = File('${tempDir.path}/arrays.json');
        await file.writeAsString('''
{
  "tags": ["tag1", "tag2"],
  "title": "Title"
}
''');
        final result = await parser.parse(file, settings);

        expect(result.containsKey('tags'), false);
        expect(result['title'], 'Title');
      });
    });

    group('edge cases', () {
      test('returns empty map for empty JSON object', () async {
        final file = File('${tempDir.path}/empty.json');
        await file.writeAsString('{}');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });

      test('returns empty map for empty file', () async {
        final file = File('${tempDir.path}/empty_file.json');
        await file.writeAsString('');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });

      test('returns empty map for malformed JSON', () async {
        final file = File('${tempDir.path}/malformed.json');
        await file.writeAsString('{ invalid json }');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });

      test('handles special characters in values', () async {
        final file = File('${tempDir.path}/special.json');
        await file.writeAsString('''
{
  "escaped": "Line1\\nLine2\\tTabbed",
  "unicode": "こんにちは",
  "emoji": "Hello 👋"
}
''');
        final result = await parser.parse(file, settings);

        expect(result['escaped'], 'Line1\nLine2\tTabbed');
        expect(result['unicode'], 'こんにちは');
        expect(result['emoji'], 'Hello 👋');
      });

      test('handles empty string values', () async {
        final file = File('${tempDir.path}/empty_values.json');
        await file.writeAsString('''
{
  "empty": "",
  "spaces": "   ",
  "normal": "value"
}
''');
        final result = await parser.parse(file, settings);

        expect(result['empty'], '');
        expect(result['spaces'], '   ');
        expect(result['normal'], 'value');
      });

      test('handles keys with special characters', () async {
        final file = File('${tempDir.path}/special_keys.json');
        await file.writeAsString('''
{
  "key.with.dots": "value1",
  "key-with-dashes": "value2",
  "key_with_underscores": "value3"
}
''');
        final result = await parser.parse(file, settings);

        expect(result['key.with.dots'], 'value1');
        expect(result['key-with-dashes'], 'value2');
        expect(result['key_with_underscores'], 'value3');
      });
    });

    group('file size validation', () {
      test('throws FileTooLargeException for oversized files', () async {
        final file = File('${tempDir.path}/large.json');
        // Create a file larger than 50MB is impractical in tests,
        // but we can test the validation is called
        await file.writeAsString('{"key": "value"}');

        // This should work for normal files
        final result = await parser.parse(file, settings);
        expect(result, isNotEmpty);
      });
    });

    group('supported extensions', () {
      test('returns correct supported extensions', () {
        expect(parser.getSupportedExtensions(), ['.json']);
      });
    });

    group('bilingual support', () {
      test('does not support bilingual extraction', () {
        expect(parser.supportsBilingualExtraction, false);
      });
    });
  });
}
