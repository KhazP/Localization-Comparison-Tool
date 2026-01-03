import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/models/ai_suggestion_result.dart';
import 'package:localizer_app_main/data/services/ai_assistance_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';

/// Adapts a cloud translation provider to the AI assistance interface.
class CloudTranslationAiAssistanceService implements AiAssistanceService {
  CloudTranslationAiAssistanceService({
    required TranslationService translationService,
    required String providerDisplayName,
    LocalTranslationCache? cache,
  })  : _translationService = translationService,
        _providerDisplayName = providerDisplayName,
        _cache = cache;

  final TranslationService _translationService;
  final String _providerDisplayName;
  final LocalTranslationCache? _cache;

  /// Provider display name for UI.
  @override
  String get providerName => _providerDisplayName;

  /// Translates text using the configured cloud provider.
  @override
  Future<TranslationSuggestion> suggestTranslation({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
    List<String>? contextStrings,
  }) async {
    if (text.trim().isEmpty) {
      return TranslationSuggestion(
        originalText: text,
        translatedText: text,
        providerName: providerName,
      );
    }

    final sourceLang = sourceLanguage ?? 'auto';
    final cached = await _cache?.getCachedTranslation(
      text,
      sourceLang,
      targetLanguage,
    );
    if (cached != null) {
      return TranslationSuggestion(
        originalText: text,
        translatedText: cached,
        confidence: 1.0,
        providerName: providerName,
      );
    }

    final translated = await _translationService.translate(
      text,
      targetLanguage,
      sourceLanguage: sourceLanguage,
    );

    await _cache?.cacheTranslation(
      text,
      sourceLang,
      targetLanguage,
      translated,
    );

    return TranslationSuggestion(
      originalText: text,
      translatedText: translated,
      providerName: providerName,
    );
  }

  /// Rephrases text by re-translating with the cloud provider.
  @override
  Future<RephraseResult> rephrase({
    required String text,
    String? targetLanguage,
    String? style,
    String? sourceText,
  }) async {
    if (text.trim().isEmpty) {
      return RephraseResult(
        originalText: text,
        rephrasedText: text,
        providerName: providerName,
      );
    }

    if (sourceText != null &&
        sourceText.trim().isNotEmpty &&
        targetLanguage != null) {
      final translated = await _translationService.translate(
        sourceText,
        targetLanguage,
      );
      return RephraseResult(
        originalText: text,
        rephrasedText: translated,
        providerName: providerName,
      );
    }

    if (targetLanguage == null) {
      return RephraseResult(
        originalText: text,
        rephrasedText: text,
        providerName: providerName,
      );
    }

    final translated = await _translationService.translate(
      text,
      targetLanguage,
      sourceLanguage: targetLanguage,
    );

    return RephraseResult(
      originalText: text,
      rephrasedText: translated,
      providerName: providerName,
    );
  }

  /// Streams translated text when available.
  @override
  Stream<String> translateStream({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  }) {
    return _translationService.translateStream(
      text,
      targetLanguage,
      sourceLanguage: sourceLanguage,
    );
  }
}
