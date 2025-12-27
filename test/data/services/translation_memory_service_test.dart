import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/data/services/translation_memory_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late TranslationMemoryService service;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('tm_test_');
    service = TranslationMemoryService(
      getDocumentsDirectory: () async => tempDir,
    );
    await service.clearMemory();
  });

  tearDown(() async {
    await service.close();
    await tempDir.delete(recursive: true);
  });

  test('findMatches returns sorted results and respects limit', () async {
    await service.addTranslationUnit(
      sourceLang: 'en',
      targetLang: 'fr',
      sourceText: 'Hello world',
      targetText: 'Bonjour le monde',
    );
    await service.addTranslationUnit(
      sourceLang: 'en',
      targetLang: 'fr',
      sourceText: 'Hello there',
      targetText: 'Salut',
    );

    final matches = await service.findMatches(
      sourceText: 'Hello world',
      sourceLang: 'en',
      targetLang: 'fr',
      minScore: 0.0,
      limit: 1,
    );

    expect(matches.length, 1);
    expect(matches.first.targetText, 'Bonjour le monde');
  });

  test('findMatches honors minimum score', () async {
    await service.addTranslationUnit(
      sourceLang: 'en',
      targetLang: 'es',
      sourceText: 'Good morning',
      targetText: 'Buenos dias',
    );
    await service.addTranslationUnit(
      sourceLang: 'en',
      targetLang: 'es',
      sourceText: 'Good evening',
      targetText: 'Buenas noches',
    );

    final matches = await service.findMatches(
      sourceText: 'Good morning',
      sourceLang: 'en',
      targetLang: 'es',
      minScore: 0.95,
      limit: 5,
    );

    expect(matches.length, 1);
    expect(matches.first.targetText, 'Buenos dias');
  });
}
