import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/business_logic/blocs/translation_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/services/translation_memory_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockTranslationService mockTranslationService;
  late MockTranslationCache mockCache;
  late MockTranslationMemoryService mockTmService;
  late MockSettingsRepository mockSettingsRepo;

  setUp(() {
    mockTranslationService = MockTranslationService();
    mockCache = MockTranslationCache();
    mockTmService = MockTranslationMemoryService();
    mockSettingsRepo = MockSettingsRepository();
  });

  TranslationBloc buildBloc() => TranslationBloc(
        translationService: mockTranslationService,
        translationCache: mockCache,
        translationMemoryService: mockTmService,
        settingsRepository: mockSettingsRepo,
      );

  group('TranslationBloc', () {
    test('initial state is TranslationInitial', () {
      final bloc = buildBloc();
      expect(bloc.state, isA<TranslationInitial>());
      bloc.close();
    });

    blocTest<TranslationBloc, TranslationState>(
      'TranslateText emits inProgress then success',
      setUp: () {
        when(() => mockCache.getCachedTranslation(any(), any(), any()))
            .thenAnswer((_) async => null);
        when(() => mockSettingsRepo.loadSettings())
            .thenAnswer((_) async => AppSettings.defaultSettings());
        when(() => mockTmService.findBestMatch(
              sourceText: any(named: 'sourceText'),
              sourceLang: any(named: 'sourceLang'),
              targetLang: any(named: 'targetLang'),
            )).thenAnswer((_) async => null);
        when(() => mockTranslationService.translate(any(), any(),
                sourceLanguage: any(named: 'sourceLanguage')))
            .thenAnswer((_) async => 'Hola');
        when(() => mockCache.cacheTranslation(any(), any(), any(), any()))
            .thenAnswer((_) async {});
      },
      build: buildBloc,
      act: (bloc) => bloc.add(TranslateText(
        text: 'Hello',
        targetLanguage: 'es',
        textKey: 'greeting',
      )),
      expect: () => [
        isA<TranslationInProgress>()
            .having((s) => s.translations['greeting'], 'loading', isNull),
        isA<TranslationSuccess>()
            .having((s) => s.translations['greeting'], 'translated', 'Hola'),
      ],
    );

    blocTest<TranslationBloc, TranslationState>(
      'TranslateText returns cached value when available',
      setUp: () {
        when(() => mockCache.getCachedTranslation(any(), any(), any()))
            .thenAnswer((_) async => 'Cached Hola');
      },
      build: buildBloc,
      act: (bloc) => bloc.add(TranslateText(
        text: 'Hello',
        targetLanguage: 'es',
        textKey: 'greeting',
      )),
      expect: () => [
        isA<TranslationInProgress>(),
        isA<TranslationSuccess>()
            .having((s) => s.translations['greeting'], 'cached', 'Cached Hola'),
      ],
    );

    blocTest<TranslationBloc, TranslationState>(
      'TranslateText returns translation memory match',
      setUp: () {
        when(() => mockCache.getCachedTranslation(any(), any(), any()))
            .thenAnswer((_) async => null);
        when(() => mockSettingsRepo.loadSettings()).thenAnswer((_) async =>
            AppSettings.defaultSettings()
                .copyWith(enableTranslationMemory: true));
        when(() => mockTmService.findBestMatch(
              sourceText: any(named: 'sourceText'),
              sourceLang: any(named: 'sourceLang'),
              targetLang: any(named: 'targetLang'),
            )).thenAnswer((_) async => const TranslationMemoryMatch(
              sourceText: 'Hello',
              targetText: 'TM Hola',
              score: 0.95,
            ));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(TranslateText(
        text: 'Hello',
        targetLanguage: 'es',
        textKey: 'greeting',
      )),
      expect: () => [
        isA<TranslationInProgress>(),
        isA<TranslationSuccess>()
            .having((s) => s.translations['greeting'], 'tm', 'TM Hola'),
      ],
    );

    blocTest<TranslationBloc, TranslationState>(
      'TranslateText emits failure on MissingApiKeyException',
      setUp: () {
        when(() => mockCache.getCachedTranslation(any(), any(), any()))
            .thenAnswer((_) async => null);
        when(() => mockSettingsRepo.loadSettings())
            .thenAnswer((_) async => AppSettings.defaultSettings());
        when(() => mockTmService.findBestMatch(
              sourceText: any(named: 'sourceText'),
              sourceLang: any(named: 'sourceLang'),
              targetLang: any(named: 'targetLang'),
            )).thenAnswer((_) async => null);
        when(() => mockTranslationService.translate(any(), any(),
                sourceLanguage: any(named: 'sourceLanguage')))
            .thenThrow(MissingApiKeyException('No API key configured'));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(TranslateText(
        text: 'Hello',
        targetLanguage: 'es',
        textKey: 'greeting',
      )),
      expect: () => [
        isA<TranslationInProgress>(),
        isA<TranslationFailure>()
            .having((s) => s.error, 'error', 'No API key configured')
            .having((s) => s.errorTextKey, 'key', 'greeting'),
      ],
    );

    blocTest<TranslationBloc, TranslationState>(
      'ClearTranslation removes entry and returns to initial when empty',
      setUp: () {
        when(() => mockCache.getCachedTranslation(any(), any(), any()))
            .thenAnswer((_) async => 'Hola');
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(TranslateText(
          text: 'Hello',
          targetLanguage: 'es',
          textKey: 'greeting',
        ));
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.add(ClearTranslation(textKey: 'greeting'));
      },
      expect: () => [
        isA<TranslationInProgress>(),
        isA<TranslationSuccess>(),
        isA<TranslationInitial>(),
      ],
    );
  });
}
