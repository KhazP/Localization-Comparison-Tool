import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/data/services/'
    'translation_memory_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';

part 'translation_bloc.freezed.dart';

// Events
abstract class TranslationEvent {}

class TranslateText extends TranslationEvent {
  final String text;
  final String targetLanguage;
  final String? sourceLanguage;
  // Identifies which text field/item this translation is for.
  final String textKey;

  TranslateText({
    required this.text,
    required this.targetLanguage,
    this.sourceLanguage,
    required this.textKey,
  });
}

class ClearTranslation extends TranslationEvent {
  final String textKey;
  ClearTranslation({required this.textKey});
}

// States
@freezed
class TranslationState with _$TranslationState {
  const factory TranslationState.initial() = TranslationInitial;

  /// Using a map to store translations for multiple items if needed on a
  /// screen.
  const factory TranslationState.inProgress(
    Map<String, String?> translations,
  ) = TranslationInProgress;

  /// key: textKey, value: translated text
  const factory TranslationState.success(
    Map<String, String?> translations,
  ) = TranslationSuccess;

  /// key: textKey, value: error message or previous value
  const factory TranslationState.failure(
    Map<String, String?> translations,
    String error,
    String errorTextKey,
  ) = TranslationFailure;
}

// BLoC
class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  final TranslationService translationService;
  final TranslationCache translationCache;
  final TranslationMemoryService translationMemoryService;
  final SettingsRepository settingsRepository;

  // Internal map to hold the current state of translations.
  final Map<String, String?> _currentTranslations = {};

  TranslationBloc({
    required this.translationService,
    required this.translationCache,
    required this.translationMemoryService,
    required this.settingsRepository,
  }) : super(TranslationInitial()) {
    on<TranslateText>(_onTranslateText);
    on<ClearTranslation>(_onClearTranslation);
  }

  Future<void> _onTranslateText(
    TranslateText event,
    Emitter<TranslationState> emit,
  ) async {
    final previousValue = _currentTranslations[event.textKey];
    // Indicate loading for this specific key.
    _currentTranslations[event.textKey] = null;
    emit(TranslationInProgress(Map.from(_currentTranslations)));

    try {
      String? translatedText;
      // 1. Check cache
      translatedText = await translationCache.getCachedTranslation(
        event.text,
        event.sourceLanguage ?? 'auto',
        event.targetLanguage,
      );

      if (translatedText != null && _isPreviewTranslation(translatedText)) {
        translatedText = null;
      }

      if (translatedText == null) {
        final settings = await settingsRepository.loadSettings();
        if (settings.enableTranslationMemory) {
          try {
            final match = await translationMemoryService.findBestMatch(
              sourceText: event.text,
              sourceLang: event.sourceLanguage ?? 'auto',
              targetLang: event.targetLanguage,
            );
            translatedText = match?.targetText;
          } catch (e, s) {
            developer.log(
              'Translation memory lookup failed.',
              name: 'translation.memory',
              error: e,
              stackTrace: s,
            );
          }
        }
      }

      if (translatedText == null) {
        translatedText = await translationService.translate(
          event.text,
          event.targetLanguage,
          sourceLanguage: event.sourceLanguage,
        );
        if (!_isPreviewTranslation(translatedText)) {
          // Cache the new translation
          await translationCache.cacheTranslation(
            event.text,
            event.sourceLanguage ?? 'auto',
            event.targetLanguage,
            translatedText,
          );
        }
      }

      _currentTranslations[event.textKey] = translatedText;
      emit(TranslationSuccess(Map.from(_currentTranslations)));
    } catch (e, s) {
      developer.log(
        'Translation failed.',
        name: 'translation',
        error: e,
        stackTrace: s,
      );
      if (previousValue != null) {
        _currentTranslations[event.textKey] = previousValue;
      } else {
        _currentTranslations.remove(event.textKey);
      }
      final errorMessage = e is MissingApiKeyException
          ? e.message
          : 'We could not translate that text. Try again.';
      emit(
        TranslationFailure(
          Map.from(_currentTranslations),
          errorMessage,
          event.textKey,
        ),
      );
    }
  }

  void _onClearTranslation(
    ClearTranslation event,
    Emitter<TranslationState> emit,
  ) {
    _currentTranslations.remove(event.textKey);
    if (_currentTranslations.isEmpty) {
      emit(TranslationInitial());
    } else {
      // Re-emit success with the item removed.
      emit(TranslationSuccess(Map.from(_currentTranslations)));
    }
  }

  bool _isPreviewTranslation(String text) {
    return text.contains('(Preview - API Key Needed)');
  }
}
