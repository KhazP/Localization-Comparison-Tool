import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/resx_parser.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late ResxParser parser;
  late AppSettings settings;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('resx_parser_test_');
    parser = ResxParser();
    settings = AppSettings.defaultSettings();
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  group('ResxParser', () {
    group('basic parsing', () {
      test('parses standard RESX file', () async {
        final file = File('${tempDir.path}/basic.resx');
        await file.writeAsString('''<?xml version="1.0" encoding="utf-8"?>
<root>
  <data name="hello" xml:space="preserve">
    <value>Hello</value>
  </data>
  <data name="goodbye" xml:space="preserve">
    <value>Goodbye</value>
  </data>
</root>
''');

        final result = await parser.parse(file, settings);

        expect(result, {
          'hello': 'Hello',
          'goodbye': 'Goodbye',
        });
      });

      test('parses RESX with comments in data elements', () async {
        final file = File('${tempDir.path}/comments.resx');
        await file.writeAsString('''<?xml version="1.0" encoding="utf-8"?>
<root>
  <data name="title" xml:space="preserve">
    <value>My Title</value>
    <comment>This is a title</comment>
  </data>
</root>
''');

        final result = await parser.parse(file, settings);

        expect(result, {'title': 'My Title'});
      });
    });

    group('missing value node', () {
      test('stores empty string when value element is missing', () async {
        final file = File('${tempDir.path}/no_value.resx');
        await file.writeAsString('''<?xml version="1.0" encoding="utf-8"?>
<root>
  <data name="icon_ref" type="System.Resources.ResXFileRef">
    <comment>An icon reference without value</comment>
  </data>
</root>
''');

        final result = await parser.parse(file, settings);

        expect(result['icon_ref'], '');
      });

      test('skips data elements without name attribute', () async {
        final file = File('${tempDir.path}/no_name.resx');
        await file.writeAsString('''<?xml version="1.0" encoding="utf-8"?>
<root>
  <data>
    <value>Orphan value</value>
  </data>
  <data name="valid">
    <value>Valid</value>
  </data>
</root>
''');

        final result = await parser.parse(file, settings);

        expect(result.length, 1);
        expect(result['valid'], 'Valid');
      });
    });

    group('encoding and edge cases', () {
      test('returns empty map for empty RESX file', () async {
        final file = File('${tempDir.path}/empty.resx');
        await file.writeAsString('');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });

      test('returns empty map for malformed XML', () async {
        final file = File('${tempDir.path}/malformed.resx');
        await file.writeAsString('<root><data name="broken"');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });

      test('handles RESX with no data elements', () async {
        final file = File('${tempDir.path}/no_data.resx');
        await file.writeAsString('''<?xml version="1.0" encoding="utf-8"?>
<root>
  <resheader name="resmimetype">
    <value>text/microsoft-resx</value>
  </resheader>
</root>
''');

        final result = await parser.parse(file, settings);

        expect(result, isEmpty);
      });

      test('trims whitespace from values', () async {
        final file = File('${tempDir.path}/whitespace.resx');
        await file.writeAsString('''<?xml version="1.0" encoding="utf-8"?>
<root>
  <data name="padded" xml:space="preserve">
    <value>  Hello World  </value>
  </data>
</root>
''');

        final result = await parser.parse(file, settings);

        expect(result['padded'], 'Hello World');
      });
    });

    group('supported extensions', () {
      test('returns correct supported extensions', () {
        expect(parser.getSupportedExtensions(), ['.resx']);
      });
    });
  });
}
