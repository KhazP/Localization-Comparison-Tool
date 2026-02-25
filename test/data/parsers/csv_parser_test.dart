import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/csv_parser.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late CsvParser parser;
  late AppSettings settings;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('csv_parser_test_');
    parser = CsvParser();
    settings = AppSettings.defaultSettings();
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  group('CsvParser', () {
    group('comma delimiter', () {
      test('parses standard CSV with header row', () async {
        final file = File('${tempDir.path}/standard.csv');
        await file
            .writeAsString('key,value\r\nhello,Hello\r\ngoodbye,Goodbye\r\n');

        final result = await parser.parse(file, settings);

        expect(result, {
          'hello': 'Hello',
          'goodbye': 'Goodbye',
        });
      });

      test('parses single-row CSV as data (no header skip)', () async {
        final file = File('${tempDir.path}/single.csv');
        await file.writeAsString('hello,Hello\r\n');

        final result = await parser.parse(file, settings);

        expect(result, {'hello': 'Hello'});
      });
    });

    group('semicolon delimiter', () {
      test('parses semicolon-separated CSV', () async {
        final file = File('${tempDir.path}/semicolon.csv');
        await file
            .writeAsString('key;value\r\nhello;Hello\r\ngoodbye;Goodbye\r\n');

        final semiSettings = settings.copyWith(csvDelimiter: ';');
        final result = await parser.parse(file, semiSettings);

        expect(result, {
          'hello': 'Hello',
          'goodbye': 'Goodbye',
        });
      });
    });

    group('BOM handling', () {
      test('parses CSV with UTF-8 BOM', () async {
        final file = File('${tempDir.path}/bom.csv');
        // Write BOM + content
        await file.writeAsBytes([
          0xEF, 0xBB, 0xBF, // UTF-8 BOM
          ...('key,value\r\nhello,Hello\r\n'.codeUnits),
        ]);

        final result = await parser.parse(file, settings);

        expect(result, {'hello': 'Hello'});
      });
    });

    group('edge cases', () {
      test('returns empty map for empty file', () async {
        final file = File('${tempDir.path}/empty.csv');
        await file.writeAsString('');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });

      test('skips rows with fewer than 2 columns', () async {
        final file = File('${tempDir.path}/short_rows.csv');
        await file.writeAsString('key,value\r\nhello,Hello\r\norphan\r\n');

        final result = await parser.parse(file, settings);

        expect(result, {'hello': 'Hello'});
      });

      test('skips rows with empty keys', () async {
        final file = File('${tempDir.path}/empty_keys.csv');
        await file.writeAsString('key,value\r\n,EmptyKey\r\nhello,Hello\r\n');

        final result = await parser.parse(file, settings);

        expect(result, {'hello': 'Hello'});
      });

      test('handles duplicate keys (last wins)', () async {
        final file = File('${tempDir.path}/dupes.csv');
        await file
            .writeAsString('key,value\r\nhello,First\r\nhello,Second\r\n');

        final result = await parser.parse(file, settings);

        expect(result['hello'], 'Second');
      });
    });

    group('supported extensions', () {
      test('returns correct supported extensions', () {
        expect(parser.getSupportedExtensions(), ['.csv']);
      });
    });
  });
}
