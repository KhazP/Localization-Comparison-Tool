import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/arb_parser.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late ArbParser parser;
  late AppSettings settings;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('arb_parser_test_');
    parser = ArbParser();
    settings = AppSettings.defaultSettings();
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  group('ArbParser', () {
    group('basic parsing', () {
      test('parses valid ARB file', () async {
        final file = File('${tempDir.path}/valid.arb');
        await file.writeAsString('''
{
  "@@locale": "en",
  "hello": "Hello",
  "@hello": {
    "description": "Greeting message"
  },
  "goodbye": "Goodbye"
}
''');
        final result = await parser.parse(file, settings);

        expect(result, {
          'hello': 'Hello',
          'goodbye': 'Goodbye',
        });
      });

      test('skips all metadata keys starting with @', () async {
        final file = File('${tempDir.path}/metadata.arb');
        await file.writeAsString('''
{
  "@@locale": "en",
  "@@last_modified": "2024-01-01",
  "@title": {"description": "Title"},
  "title": "My App"
}
''');
        final result = await parser.parse(file, settings);

        expect(result.length, 1);
        expect(result['title'], 'My App');
      });
    });

    group('nested structures', () {
      test('flattens nested ARB with dot notation', () async {
        final file = File('${tempDir.path}/nested.arb');
        await file.writeAsString('''
{
  "messages": {
    "greeting": "Hello",
    "farewell": "Bye"
  }
}
''');
        final result = await parser.parse(file, settings);

        expect(result, {
          'messages.greeting': 'Hello',
          'messages.farewell': 'Bye',
        });
      });
    });

    group('type handling', () {
      test('converts numeric and boolean values to strings', () async {
        final file = File('${tempDir.path}/types.arb');
        await file.writeAsString('''
{
  "count": 42,
  "enabled": true
}
''');
        final result = await parser.parse(file, settings);

        expect(result['count'], '42');
        expect(result['enabled'], 'true');
      });

      test('converts null values to empty strings', () async {
        final file = File('${tempDir.path}/nulls.arb');
        await file.writeAsString('''
{
  "missing": null,
  "present": "value"
}
''');
        final result = await parser.parse(file, settings);

        expect(result['missing'], '');
        expect(result['present'], 'value');
      });
    });

    group('edge cases', () {
      test('returns empty map for empty ARB file', () async {
        final file = File('${tempDir.path}/empty.arb');
        await file.writeAsString('');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });

      test('returns empty map for malformed JSON', () async {
        final file = File('${tempDir.path}/malformed.arb');
        await file.writeAsString('{ not valid json');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });

      test('returns empty map for empty JSON object', () async {
        final file = File('${tempDir.path}/empty_obj.arb');
        await file.writeAsString('{}');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });
    });

    group('supported extensions', () {
      test('returns correct supported extensions', () {
        expect(parser.getSupportedExtensions(), ['.arb']);
      });
    });
  });
}
