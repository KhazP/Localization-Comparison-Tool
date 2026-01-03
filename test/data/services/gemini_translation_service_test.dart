import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/services/gemini_translation_service.dart';
import 'package:localizer_app_main/data/services/translation_exceptions.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';

// Mocks
class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockLocalTranslationCache extends Mock implements LocalTranslationCache {}

class MockTalkerService extends Mock implements TalkerService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSecureStorageService mockSecureStorage;
  late MockLocalTranslationCache mockCache;
  late MockTalkerService mockTalker;

  setUp(() {
    mockSecureStorage = MockSecureStorageService();
    mockCache = MockLocalTranslationCache();
    mockTalker = MockTalkerService();

    // Default mock behaviors
    when(() => mockTalker.debug(any())).thenReturn(null);
    when(() => mockTalker.info(any())).thenReturn(null);
    when(() => mockTalker.warning(any())).thenReturn(null);
    when(() => mockTalker.error(any())).thenReturn(null);
  });

  group('GeminiTranslationService', () {
    test('implements TranslationService interface', () {
      when(() => mockSecureStorage.getGeminiApiKey())
          .thenAnswer((_) async => 'test-api-key');
      when(() => mockCache.getCachedTranslation(any(), any(), any()))
          .thenAnswer((_) async => null);

      final service = GeminiTranslationService(
        secureStorage: mockSecureStorage,
        cache: mockCache,
        talkerService: mockTalker,
      );

      expect(service, isA<TranslationService>());
    });

    test('returns cached translation when available', () async {
      when(() => mockSecureStorage.getGeminiApiKey())
          .thenAnswer((_) async => 'test-api-key');
      when(() => mockCache.getCachedTranslation('Hello', 'auto', 'fr'))
          .thenAnswer((_) async => 'Bonjour');

      final service = GeminiTranslationService(
        secureStorage: mockSecureStorage,
        cache: mockCache,
        talkerService: mockTalker,
      );

      final result = await service.translate('Hello', 'fr');
      expect(result, 'Bonjour');

      // Verify cache was checked
      verify(() => mockCache.getCachedTranslation('Hello', 'auto', 'fr'))
          .called(1);
    });

    test('throws MissingApiKeyException when API key is null', () async {
      when(() => mockSecureStorage.getGeminiApiKey())
          .thenAnswer((_) async => null);
      when(() => mockCache.getCachedTranslation(any(), any(), any()))
          .thenAnswer((_) async => null);

      final service = GeminiTranslationService(
        secureStorage: mockSecureStorage,
        cache: mockCache,
        talkerService: mockTalker,
      );

      expect(
        () => service.translate('Hello', 'fr'),
        throwsA(isA<MissingApiKeyException>()),
      );
    });

    test('throws MissingApiKeyException when API key is empty', () async {
      when(() => mockSecureStorage.getGeminiApiKey())
          .thenAnswer((_) async => '');
      when(() => mockCache.getCachedTranslation(any(), any(), any()))
          .thenAnswer((_) async => null);

      final service = GeminiTranslationService(
        secureStorage: mockSecureStorage,
        cache: mockCache,
        talkerService: mockTalker,
      );

      expect(
        () => service.translate('Hello', 'fr'),
        throwsA(isA<MissingApiKeyException>()),
      );
    });

    test('returns empty text unchanged', () async {
      final service = GeminiTranslationService(
        secureStorage: mockSecureStorage,
        cache: mockCache,
        talkerService: mockTalker,
      );

      final result = await service.translate('', 'fr');
      expect(result, '');

      // Verify no cache or API calls were made
      verifyNever(() => mockCache.getCachedTranslation(any(), any(), any()));
      verifyNever(() => mockSecureStorage.getGeminiApiKey());
    });

    test('translateStream returns cached translation when available', () async {
      when(() => mockSecureStorage.getGeminiApiKey())
          .thenAnswer((_) async => 'test-api-key');
      when(() => mockCache.getCachedTranslation('Hello', 'auto', 'fr'))
          .thenAnswer((_) async => 'Bonjour');

      final service = GeminiTranslationService(
        secureStorage: mockSecureStorage,
        cache: mockCache,
        talkerService: mockTalker,
      );

      final chunks = await service.translateStream('Hello', 'fr').toList();

      expect(chunks, ['Bonjour']);
    });

    test('translateStream returns empty text unchanged', () async {
      final service = GeminiTranslationService(
        secureStorage: mockSecureStorage,
        cache: mockCache,
        talkerService: mockTalker,
      );

      final chunks = await service.translateStream('   ', 'fr').toList();

      expect(chunks, ['   ']);
    });
  });

  group('TranslationExceptions', () {
    test('TranslationException contains message and cause', () {
      final cause = Exception('Root cause');
      final exception = TranslationException('Test error', cause: cause);

      expect(exception.message, 'Test error');
      expect(exception.cause, cause);
      expect(exception.toString(), contains('Test error'));
      expect(exception.toString(), contains('Root cause'));
    });

    test('RateLimitException has default message', () {
      final exception = RateLimitException();

      expect(exception.message, contains('rate limit'));
      expect(exception, isA<TranslationException>());
    });

    test('EmptyResponseException has default message', () {
      final exception = EmptyResponseException();

      expect(exception.message, contains('empty'));
      expect(exception, isA<TranslationException>());
    });
  });
}
