import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/models/ai_suggestion_result.dart';
import 'package:localizer_app_main/data/services/ai_assistance_service.dart';
import 'package:localizer_app_main/data/services/gemini_translation_service.dart';
import 'package:localizer_app_main/data/services/translation_exceptions.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';

/// Gemini implementation of [AiAssistanceService].
///
/// Provides AI-assisted translation and text manipulation using Google's
/// Gemini 2.5 Flash model with structured output for the review workflow.
class GeminiAiAssistanceService implements AiAssistanceService {
  GeminiAiAssistanceService({
    required SecureStorageService secureStorage,
    required LocalTranslationCache cache,
    required TalkerService talkerService,
    GeminiTranslationConfig? config,
  })  : _secureStorage = secureStorage,
        _cache = cache,
        _talker = talkerService,
        _config = config ?? const GeminiTranslationConfig();

  final SecureStorageService _secureStorage;
  final LocalTranslationCache _cache;
  final TalkerService _talker;
  GeminiTranslationConfig _config;

  static const _modelName = 'gemini-2.5-flash';

  GenerativeModel? _model;
  GeminiTranslationConfig? _cachedConfig;

  @override
  String get providerName => 'Gemini';

  /// Updates the configuration.
  void updateConfig(GeminiTranslationConfig newConfig) {
    if (_config != newConfig) {
      _config = newConfig;
      _model = null;
      _cachedConfig = null;
      _talker.debug('Gemini AI assistance config updated');
    }
  }

  Future<GenerativeModel> _getModel({String? systemInstruction}) async {
    // Rebuild model if config changed or different system instruction needed
    if (_model != null &&
        _cachedConfig == _config &&
        systemInstruction == null) {
      return _model!;
    }

    final apiKey = await _secureStorage.getGeminiApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw MissingApiKeyException(
        'Add your Gemini API key in Settings to enable AI features.',
      );
    }

    final prompt = systemInstruction ?? _defaultTranslationPrompt;

    final model = GenerativeModel(
      model: _modelName,
      apiKey: apiKey,
      systemInstruction: Content.text(prompt),
      generationConfig: GenerationConfig(
        temperature: _config.temperature,
        topP: _config.topP,
        topK: _config.topK,
        maxOutputTokens: _config.maxOutputTokens,
      ),
    );

    // Cache only if using default prompt
    if (systemInstruction == null) {
      _model = model;
      _cachedConfig = _config;
    }

    return model;
  }

  static const _defaultTranslationPrompt = '''You are a professional translator.
Translate the provided text accurately and naturally.

RULES:
- Return ONLY the translated text, nothing else
- No explanations, notes, or commentary
- Preserve formatting: newlines, quotes, HTML tags,
  placeholders like {name} or %s
- Preserve technical terminology
- Maintain the original tone and style
- If translation is impossible, respond with exactly: TRANSLATION_FAILED''';

  static const _rephrasePrompt = '''You are a professional editor.
Rephrase the provided text to improve clarity and naturalness while
preserving the original meaning.

RULES:
- Return ONLY the rephrased text, nothing else
- No explanations, notes, or commentary
- Preserve formatting: newlines, quotes, HTML tags,
  placeholders like {name} or %s
- Preserve technical terminology
- Maintain the original tone unless a specific style is requested
- Provide an alternative wording (do not repeat the input text)''';

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

    // Check cache first
    final sourceLang = sourceLanguage ?? 'auto';
    final cached =
        await _cache.getCachedTranslation(text, sourceLang, targetLanguage);
    if (cached != null) {
      _talker.debug('AI suggestion cache hit');
      return TranslationSuggestion(
        originalText: text,
        translatedText: cached,
        confidence: 1.0, // Cached translations are considered high confidence
        providerName: providerName,
      );
    }

    final stopwatch = Stopwatch()..start();

    try {
      final model = await _getModel();
      final prompt = _buildTranslationPrompt(
          text, targetLanguage, sourceLanguage, contextStrings);
      final response = await model.generateContent([Content.text(prompt)]);

      final resultText = response.text?.trim();
      if (resultText == null ||
          resultText.isEmpty ||
          resultText == 'TRANSLATION_FAILED') {
        throw EmptyResponseException(
            message: 'Gemini returned empty or failed response');
      }

      stopwatch.stop();
      _talker.info(
          'AI translation suggestion completed in ${stopwatch.elapsedMilliseconds}ms');

      // Cache the result
      await _cache.cacheTranslation(
          text, sourceLang, targetLanguage, resultText);

      return TranslationSuggestion(
        originalText: text,
        translatedText: resultText,
        confidence: 0.9, // High confidence for direct AI response
        providerName: providerName,
      );
    } on GenerativeAIException catch (e) {
      _talker.error('AI translation suggestion failed: ${e.message}');
      if (e.message.contains('429') ||
          e.message.toLowerCase().contains('rate')) {
        throw RateLimitException(cause: e);
      }
      throw TranslationException('AI translation failed: ${e.message}',
          cause: e);
    }
  }

  String _buildTranslationPrompt(
    String text,
    String targetLanguage,
    String? sourceLanguage,
    List<String>? contextStrings,
  ) {
    final buffer = StringBuffer();

    if (contextStrings != null && contextStrings.isNotEmpty) {
      buffer.writeln('CONTEXT (surrounding strings for reference):');
      for (final ctx in contextStrings) {
        buffer.writeln('- $ctx');
      }
      buffer.writeln();
    }

    if (sourceLanguage != null) {
      buffer
          .write('Translate from $sourceLanguage to $targetLanguage:\n\n$text');
    } else {
      buffer.write('Translate to $targetLanguage:\n\n$text');
    }

    return buffer.toString();
  }

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

    final stopwatch = Stopwatch()..start();

    try {
      final model = await _getModel(systemInstruction: _rephrasePrompt);
      final prompt = _buildRephrasePrompt(
        text,
        targetLanguage,
        style,
        sourceText,
      );
      var response = await model.generateContent([Content.text(prompt)]);

      var resultText = response.text?.trim();
      if (resultText == null || resultText.isEmpty) {
        throw EmptyResponseException(
            message: 'Gemini returned empty response for rephrase');
      }

      if (resultText.trim() == text.trim()) {
        final retryPrompt = _buildRephrasePrompt(
          text,
          targetLanguage,
          style,
          sourceText,
          forceAlternate: true,
        );
        response = await model.generateContent([Content.text(retryPrompt)]);
        final retryText = response.text?.trim();
        if (retryText != null && retryText.isNotEmpty) {
          resultText = retryText;
        }
      }

      stopwatch.stop();
      _talker
          .info('AI rephrase completed in ${stopwatch.elapsedMilliseconds}ms');

      return RephraseResult(
        originalText: text,
        rephrasedText: resultText,
        providerName: providerName,
      );
    } on GenerativeAIException catch (e) {
      _talker.error('AI rephrase failed: ${e.message}');
      if (e.message.contains('429') ||
          e.message.toLowerCase().contains('rate')) {
        throw RateLimitException(cause: e);
      }
      throw TranslationException('AI rephrase failed: ${e.message}', cause: e);
    }
  }

  String _buildRephrasePrompt(
    String text,
    String? targetLanguage,
    String? style,
    String? sourceText, {
    bool forceAlternate = false,
  }) {
    final buffer = StringBuffer();

    if (style != null) {
      buffer.writeln('Rephrase the following text in a $style style:');
    } else {
      buffer.writeln('Rephrase the following text for improved clarity:');
    }

    if (targetLanguage != null) {
      buffer.writeln('(Target language: $targetLanguage)');
    }

    if (sourceText != null && sourceText.trim().isNotEmpty) {
      buffer.writeln('Original source text: "$sourceText"');
    }

    if (forceAlternate) {
      buffer.writeln(
        'Provide an alternative wording that is clearly different.',
      );
    }

    buffer.writeln();
    buffer.write(text);

    return buffer.toString();
  }

  @override
  Stream<String> translateStream({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  }) async* {
    if (text.trim().isEmpty) {
      yield text;
      return;
    }

    // Check cache first
    final sourceLang = sourceLanguage ?? 'auto';
    final cached =
        await _cache.getCachedTranslation(text, sourceLang, targetLanguage);
    if (cached != null) {
      _talker.debug('AI streaming cache hit');
      yield cached;
      return;
    }

    final model = await _getModel();
    final prompt =
        _buildTranslationPrompt(text, targetLanguage, sourceLanguage, null);

    final stopwatch = Stopwatch()..start();
    final buffer = StringBuffer();

    try {
      final responseStream =
          model.generateContentStream([Content.text(prompt)]);

      await for (final chunk in responseStream) {
        final chunkText = chunk.text;
        if (chunkText != null && chunkText.isNotEmpty) {
          buffer.write(chunkText);
          yield chunkText;
        }
      }

      stopwatch.stop();
      final fullResult = buffer.toString().trim();

      if (fullResult.isNotEmpty && fullResult != 'TRANSLATION_FAILED') {
        await _cache.cacheTranslation(
            text, sourceLang, targetLanguage, fullResult);
        _talker.info(
            'AI streaming translation completed in ${stopwatch.elapsedMilliseconds}ms');
      }
    } on GenerativeAIException catch (e) {
      _talker.error('AI streaming error: ${e.message}');
      if (e.message.contains('429') ||
          e.message.toLowerCase().contains('rate')) {
        throw RateLimitException(cause: e);
      }
      throw TranslationException('AI streaming failed: ${e.message}', cause: e);
    }
  }
}
