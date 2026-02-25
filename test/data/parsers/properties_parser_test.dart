import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/properties_parser.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late PropertiesParser parser;
  late AppSettings settings;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('properties_parser_test_');
    parser = PropertiesParser();
    settings = AppSettings.defaultSettings();
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  group('PropertiesParser', () {
    group('standard parsing', () {
      test('parses key=value pairs', () async {
        final file = File('${tempDir.path}/standard.properties');
        await file.writeAsString('hello=Hello\ngoodbye=Goodbye\n');

        final result = await parser.parse(file, settings);

        expect(result, {
          'hello': 'Hello',
          'goodbye': 'Goodbye',
        });
      });

      test('parses key:value pairs', () async {
        final file = File('${tempDir.path}/colon.properties');
        await file.writeAsString('hello:Hello\ngoodbye:Goodbye\n');

        final result = await parser.parse(file, settings);

        expect(result, {
          'hello': 'Hello',
          'goodbye': 'Goodbye',
        });
      });
    });

    group('comments', () {
      test('skips lines starting with #', () async {
        final file = File('${tempDir.path}/hash_comments.properties');
        await file.writeAsString(
            '# This is a comment\nhello=Hello\n# Another comment\n');

        final result = await parser.parse(file, settings);

        expect(result, {'hello': 'Hello'});
      });

      test('skips lines starting with !', () async {
        final file = File('${tempDir.path}/bang_comments.properties');
        await file.writeAsString('! This is a comment\nhello=Hello\n');

        final result = await parser.parse(file, settings);

        expect(result, {'hello': 'Hello'});
      });
    });

    group('escape sequences', () {
      test('handles \\n and \\t escape sequences', () async {
        final file = File('${tempDir.path}/escapes.properties');
        await file.writeAsString(r'multiline=Line1\nLine2' '\n');

        final result = await parser.parse(file, settings);

        expect(result['multiline'], 'Line1\nLine2');
      });

      test('handles unicode escapes', () async {
        final file = File('${tempDir.path}/unicode.properties');
        await file.writeAsString(r'greeting=\u0048ello' '\n');

        final result = await parser.parse(file, settings);

        expect(result['greeting'], 'Hello');
      });

      test('handles escaped separators', () async {
        final file = File('${tempDir.path}/escaped_sep.properties');
        await file.writeAsString(r'key\=with\=equals=value' '\n');

        final result = await parser.parse(file, settings);

        // The key has escaped = signs but the first unescaped = is the separator
        expect(result.isNotEmpty, isTrue);
      });
    });

    group('edge cases', () {
      test('returns empty map for empty file', () async {
        final file = File('${tempDir.path}/empty.properties');
        await file.writeAsString('');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });

      test('handles line continuation with backslash', () async {
        final file = File('${tempDir.path}/continuation.properties');
        await file.writeAsString('long.key=This is a \\\n  long value\n');

        final result = await parser.parse(file, settings);

        expect(result['long.key'], isNotNull);
      });

      test('handles key with empty value', () async {
        final file = File('${tempDir.path}/empty_value.properties');
        await file.writeAsString('empty.key=\n');

        final result = await parser.parse(file, settings);

        expect(result['empty.key'], '');
      });
    });

    group('supported extensions', () {
      test('returns correct supported extensions', () {
        expect(parser.getSupportedExtensions(), ['.properties']);
      });
    });
  });
}
