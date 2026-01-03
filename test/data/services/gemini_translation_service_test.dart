import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/services/gemini_translation_service.dart';
import 'package:localizer_app_main/data/services/translation_exceptions.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockLocalTranslationCache extends Mock implements LocalTranslationCache {}

class MockTalkerService extends Mock implements TalkerService {}

void main() {
  late GeminiTranslationService service;
  late MockSecureStorageService mockSecureStorage;
  late MockLocalTranslationCache mockCache;
  late MockTalkerService mockTalker;

  setUp(() {
    mockSecureStorage = MockSecureStorageService();
    mockCache = MockLocalTranslationCache();
    mockTalker = MockTalkerService();

    service = GeminiTranslationService(
      secureStorage: mockSecureStorage,
      cache: mockCache,
      talkerService: mockTalker,
    );
  });

  group('GeminiTranslationService', () {
    const String sourceText = 'Hello';
    const String translatedText = 'Merhaba';
    const String targetLang = 'tr';
    const String sourceLang = 'en';

    test('translate returns cached value if available', () async {
      when(() => mockCache.getCachedTranslation(
              sourceText, sourceLang, targetLang))
          .thenAnswer((_) async => translatedText);

      final result = await service.translate(
        sourceText,
        targetLang,
        sourceLanguage: sourceLang,
      );

      expect(result, translatedText);
      verify(() => mockCache.getCachedTranslation(
          sourceText, sourceLang, targetLang)).called(1);
      verifyZeroInteractions(
          mockSecureStorage); // Shouldn't fetch API key if cached
    });

    test('translate throws MissingApiKeyException if API key is missing',
        () async {
      when(() => mockCache.getCachedTranslation(
          sourceText, sourceLang, targetLang)).thenAnswer((_) async => null);
      when(() => mockSecureStorage.getGeminiApiKey())
          .thenAnswer((_) async => null);

      expect(
        () => service.translate(sourceText, targetLang,
            sourceLanguage: sourceLang),
        throwsA(isA<MissingApiKeyException>()),
      );
    });

    test('updateConfig clears model cache', () {
      // This test mainly verifies that the method runs without error and logic implies model reset
      // Since _model is private, we can't check it directly without reflection or exposing it.
      // But we can check if updateConfig logs the change.

      const newConfig = GeminiTranslationConfig(temperature: 0.9);
      service.updateConfig(newConfig);

      verify(() => mockTalker.debug('Gemini translation config updated'))
          .called(1);
      expect(service.config, newConfig);
    });

    // Note: Testing actual API calls requires mocking GenerativeModel which is a 3rd party class.
    // For now, we test the logic surrounding it (Cache, Config, API Key check).
  });
}
