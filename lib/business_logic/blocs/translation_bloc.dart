import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';

// Events
abstract class TranslationEvent {}

class TranslateText extends TranslationEvent {
  final String text;
  final String targetLanguage;
  final String? sourceLanguage;
  final String textKey; // To identify which text field/item this translation is for

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
abstract class TranslationState {}

class TranslationInitial extends TranslationState {}

// Using a map to store translations for multiple items if needed on a screen
class TranslationInProgress extends TranslationState {
  final Map<String, String?> translations; // key: textKey, value: null (loading)
  TranslationInProgress(this.translations);
}

class TranslationSuccess extends TranslationState {
  final Map<String, String?> translations; // key: textKey, value: translated text
  TranslationSuccess(this.translations);
}

class TranslationFailure extends TranslationState {
  final Map<String, String?> translations; // key: textKey, value: error message or previous value
  final String error;
  final String errorTextKey; // Which key specifically failed
  TranslationFailure(this.translations, this.error, this.errorTextKey);
}

// BLoC
class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  final TranslationService translationService;
  final TranslationCache translationCache;

  // Internal map to hold the current state of translations being managed by the BLoC instance
  final Map<String, String?> _currentTranslations = {};

  TranslationBloc({
    required this.translationService,
    required this.translationCache,
  }) : super(TranslationInitial()) {
    on<TranslateText>(_onTranslateText);
    on<ClearTranslation>(_onClearTranslation);
  }

  Future<void> _onTranslateText(TranslateText event, Emitter<TranslationState> emit) async {
    _currentTranslations[event.textKey] = null; // Indicate loading for this specific key
    emit(TranslationInProgress(Map.from(_currentTranslations)));

    try {
      String? translatedText;
      // 1. Check cache
      translatedText = await translationCache.getCachedTranslation(event.text, event.sourceLanguage ?? 'auto', event.targetLanguage);
      
      _currentTranslations[event.textKey] = translatedText;
      emit(TranslationSuccess(Map.from(_currentTranslations)));
    } catch (e) {
      _currentTranslations[event.textKey] = "Error"; // Or keep previous value / null
      emit(TranslationFailure(Map.from(_currentTranslations), 'Failed to translate ${event.textKey}: ${e.toString()}', event.textKey));
    }
  }

  void _onClearTranslation(ClearTranslation event, Emitter<TranslationState> emit) {
    _currentTranslations.remove(event.textKey);
    if (_currentTranslations.isEmpty) {
        emit(TranslationInitial());
    } else {
        // Re-emit success with the item removed, or a new state like TranslationItemCleared
        emit(TranslationSuccess(Map.from(_currentTranslations)));
    }
  }
} 