import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:localizer_app_main/data/parsers/tmx_parser.dart';
import 'package:localizer_app_main/data/parsers/xliff_parser.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('localizer_test_');
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  test('XLIFF bilingual extraction returns source and target values', () async {
    final file = File('${tempDir.path}/sample.xlf');
    await file.writeAsString('''
<?xml version="1.0" encoding="utf-8"?>
<xliff version="2.0" srcLang="en" trgLang="fr">
  <file id="f1">
    <unit id="greeting">
      <segment>
        <source>Hello</source>
        <target>Bonjour</target>
      </segment>
    </unit>
    <unit id="missing">
      <segment>
        <source>Hi</source>
      </segment>
    </unit>
  </file>
</xliff>
''');
    final settings = AppSettings.defaultSettings();
    final parser = XliffParser();

    final source = await parser.parse(
      file,
      settings,
      extractionMode: ExtractionMode.source,
      requireBilingual: true,
    );
    final target = await parser.parse(
      file,
      settings,
      extractionMode: ExtractionMode.target,
      requireBilingual: true,
    );

    expect(source['greeting'], 'Hello');
    expect(source['missing'], 'Hi');
    expect(target['greeting'], 'Bonjour');
    expect(target['missing'], '');
  });

  test('TMX bilingual extraction uses srclang', () async {
    final file = File('${tempDir.path}/sample.tmx');
    await file.writeAsString('''
<?xml version="1.0" encoding="utf-8"?>
<tmx version="1.4">
  <header srclang="en" />
  <body>
    <tu tuid="welcome">
      <tuv xml:lang="en"><seg>Welcome</seg></tuv>
      <tuv xml:lang="fr"><seg>Bienvenue</seg></tuv>
    </tu>
    <tu>
      <tuv xml:lang="en"><seg>Goodbye</seg></tuv>
      <tuv xml:lang="fr"><seg>Au revoir</seg></tuv>
    </tu>
  </body>
</tmx>
''');
    final settings = AppSettings.defaultSettings();
    final parser = TmxParser();

    final source = await parser.parse(
      file,
      settings,
      extractionMode: ExtractionMode.source,
      requireBilingual: true,
    );
    final target = await parser.parse(
      file,
      settings,
      extractionMode: ExtractionMode.target,
      requireBilingual: true,
    );

    expect(source['welcome'], 'Welcome');
    expect(target['welcome'], 'Bienvenue');
    expect(source['Goodbye'], 'Goodbye');
    expect(target['Goodbye'], 'Au revoir');
  });

  test('Bilingual comparison rejects non-bilingual files', () async {
    final file = File('${tempDir.path}/en.json');
    await file.writeAsString('{"hello":"Hello"}');
    final settings = AppSettings.defaultSettings();
    final engine = ComparisonEngine();

    expect(
      () => engine.compareBilingualFile(file, settings),
      throwsA(isA<InvalidBilingualFileException>()),
    );
  });
}
