import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/services/translation_exceptions.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';

/// Configuration for Gemini translation model parameters.
///
/// Based on Google Generative AI Interactions API parameters.
class GeminiTranslationConfig {
  const GeminiTranslationConfig({
    this.temperature = 0.3,
    this.topP = 0.95,
    this.topK,
    this.maxOutputTokens = 8192,
    this.presencePenalty,
    this.frequencyPenalty,
    this.systemInstructions,
    this.contextStrings,
  });

  /// Controls randomness in generation. Lower values (0.0-0.5) produce more
  /// deterministic, consistent translations. Higher values (0.7-1.0) produce
  /// more creative, varied outputs. Default: 0.3 for translation consistency.
  final double temperature;

  /// Nucleus sampling: considers tokens with top_p cumulative probability.
  /// Range: 0.0-1.0. Default: 0.95.
  final double topP;

  /// Top-K sampling: considers only the K most likely tokens.
  /// Optional, not set by default for translations.
  final int? topK;

  /// Maximum number of tokens in the response.
  /// Default: 8192 tokens.
  final int maxOutputTokens;

  /// Penalizes tokens that have already appeared in the response.
  /// Range: -2.0 to 2.0. Positive values reduce repetition.
  /// Optional for translations.
  final double? presencePenalty;

  /// Penalizes tokens based on their frequency in the response.
  /// Range: -2.0 to 2.0. Positive values reduce repetition.
  /// Optional for translations.
  final double? frequencyPenalty;

  /// Custom system instructions for the AI model.
  /// Overrides the default translation prompt when provided.
  final String? systemInstructions;

  /// Additional context strings to include for better context.
  /// These are appended to the prompt for surrounding context awareness.
  final List<String>? contextStrings;

  /// Creates a copy with the given fields replaced.
  GeminiTranslationConfig copyWith({
    double? temperature,
    double? topP,
    int? topK,
    int? maxOutputTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    String? systemInstructions,
    List<String>? contextStrings,
  }) {
    return GeminiTranslationConfig(
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
      topK: topK ?? this.topK,
      maxOutputTokens: maxOutputTokens ?? this.maxOutputTokens,
      presencePenalty: presencePenalty ?? this.presencePenalty,
      frequencyPenalty: frequencyPenalty ?? this.frequencyPenalty,
      systemInstructions: systemInstructions ?? this.systemInstructions,
      contextStrings: contextStrings ?? this.contextStrings,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GeminiTranslationConfig &&
        other.temperature == temperature &&
        other.topP == topP &&
        other.topK == topK &&
        other.maxOutputTokens == maxOutputTokens &&
        other.presencePenalty == presencePenalty &&
        other.frequencyPenalty == frequencyPenalty &&
        other.systemInstructions == systemInstructions;
  }

  @override
  int get hashCode => Object.hash(
        temperature,
        topP,
        topK,
        maxOutputTokens,
        presencePenalty,
        frequencyPenalty,
        systemInstructions,
      );
}

/// Gemini 3 Flash translation service with streaming, caching, and retry logic.
///
/// Features:
/// - Real-time streaming via `generateContentStream()`
/// - Exponential backoff retry (1s, 2s, 4s)
/// - Response validation with [EmptyResponseException]
/// - Integration with [LocalTranslationCache]
/// - Timing metrics via [TalkerService]
/// - Configurable parameters via [GeminiTranslationConfig]
class GeminiTranslationService implements TranslationService {
  GeminiTranslationService({
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

  // Retry configuration
  static const _maxRetries = 3;
  static const _initialDelayMs = 1000;

  // Model configuration - Gemini 3 Flash
  static const _modelName = 'gemini-2.5-flash';

  /// Default system instruction that ensures only translated text is returned.
  static const _defaultSystemInstruction = '''You are a professional translator.
Translate the provided text accurately and naturally.

RULES:
- Return ONLY the translated text, nothing else
- No explanations, notes, or commentary
- Preserve formatting: newlines, quotes, HTML tags, placeholders like {name} or %s
- Preserve technical terminology
- Maintain the original tone and style
- If translation is impossible, respond with exactly: TRANSLATION_FAILED''';

  GenerativeModel? _model;
  GeminiTranslationConfig? _cachedConfig;

  /// Current configuration.
  GeminiTranslationConfig get config => _config;

  /// Updates the configuration and clears the model cache.
  void updateConfig(GeminiTranslationConfig newConfig) {
    if (_config != newConfig) {
      _config = newConfig;
      clearModelCache();
      _talker.debug('Gemini translation config updated');
    }
  }

  /// Gets or creates the Gemini model with the API key from secure storage.
  Future<GenerativeModel> _getModel() async {
    // Rebuild model if config changed
    if (_model != null && _cachedConfig == _config) {
      return _model!;
    }

    final apiKey = await _secureStorage.getGeminiApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw MissingApiKeyException(
        'Add your Gemini API key in Settings to enable AI translations.',
      );
    }

    final systemPrompt =
        _config.systemInstructions ?? _defaultSystemInstruction;

    _model = GenerativeModel(
      model: _modelName,
      apiKey: apiKey,
      systemInstruction: Content.text(systemPrompt),
      generationConfig: GenerationConfig(
        temperature: _config.temperature,
        topP: _config.topP,
        topK: _config.topK,
        maxOutputTokens: _config.maxOutputTokens,
        // Note: presencePenalty and frequencyPenalty are available in newer
        // versions of the API but not yet in google_generative_ai 0.4.x
      ),
    );
    _cachedConfig = _config;

    return _model!;
  }

  @override
  Future<String> translate(
    String text,
    String targetLanguage, {
    String? sourceLanguage,
  }) async {
    if (text.trim().isEmpty) {
      return text;
    }

    // Check cache first
    final sourceLang = sourceLanguage ?? 'auto';
    final cached =
        await _cache.getCachedTranslation(text, sourceLang, targetLanguage);
    if (cached != null) {
      _talker.debug(
          'Gemini translation cache hit for: ${text.substring(0, text.length.clamp(0, 50))}...');
      return cached;
    }

    final stopwatch = Stopwatch()..start();
    String? result;
    Exception? lastError;

    // Retry loop with exponential backoff
    for (var attempt = 0; attempt < _maxRetries; attempt++) {
      try {
        result =
            await _performTranslation(text, targetLanguage, sourceLanguage);
        break;
      } on RateLimitException catch (e) {
        lastError = e;
        if (attempt < _maxRetries - 1) {
          final delayMs = _initialDelayMs * (1 << attempt); // 1s, 2s, 4s
          _talker.warning(
              'Rate limited, retrying in ${delayMs}ms (attempt ${attempt + 1}/$_maxRetries)');
          await Future.delayed(Duration(milliseconds: delayMs));
        }
      } on EmptyResponseException catch (e) {
        lastError = e;
        if (attempt < _maxRetries - 1) {
          final delayMs = _initialDelayMs * (1 << attempt);
          _talker.warning(
              'Empty response, retrying in ${delayMs}ms (attempt ${attempt + 1}/$_maxRetries)');
          await Future.delayed(Duration(milliseconds: delayMs));
        }
      } catch (e) {
        // Non-retryable error
        _talker.error('Translation failed: $e');
        rethrow;
      }
    }

    stopwatch.stop();

    if (result == null) {
      _talker.error('Translation failed after $_maxRetries attempts');
      throw lastError ??
          TranslationException(
              'Translation failed after $_maxRetries attempts');
    }

    // Validate result
    if (result == 'TRANSLATION_FAILED') {
      throw TranslationException('Model indicated translation failure');
    }

    _talker.info(
        'Gemini translation completed in ${stopwatch.elapsedMilliseconds}ms');

    // Cache the result
    await _cache.cacheTranslation(text, sourceLang, targetLanguage, result);

    return result;
  }

  Future<String> _performTranslation(
    String text,
    String targetLanguage,
    String? sourceLanguage,
  ) async {
    final model = await _getModel();
    final prompt = _buildPrompt(text, targetLanguage, sourceLanguage);

    try {
      final response = await model.generateContent([Content.text(prompt)]);

      final resultText = response.text;
      if (resultText == null || resultText.trim().isEmpty) {
        throw EmptyResponseException(
          message: 'Gemini returned empty response',
        );
      }

      return resultText.trim();
    } on GenerativeAIException catch (e) {
      if (e.message.contains('429') ||
          e.message.toLowerCase().contains('rate')) {
        throw RateLimitException(cause: e);
      }
      throw TranslationException('Gemini API error: ${e.message}', cause: e);
    }
  }

  /// Builds the translation prompt with optional context strings.
  String _buildPrompt(
      String text, String targetLanguage, String? sourceLanguage) {
    final buffer = StringBuffer();

    // Add context strings if enabled
    if (_config.contextStrings != null && _config.contextStrings!.isNotEmpty) {
      buffer.writeln('CONTEXT (surrounding strings for reference):');
      for (final ctx in _config.contextStrings!) {
        buffer.writeln('- $ctx');
      }
      buffer.writeln();
    }

    // Build main translation request
    if (sourceLanguage != null) {
      buffer
          .write('Translate from $sourceLanguage to $targetLanguage:\n\n$text');
    } else {
      buffer.write('Translate to $targetLanguage:\n\n$text');
    }

    return buffer.toString();
  }

  @override
  Stream<String> translateStream(
    String text,
    String targetLanguage, {
    String? sourceLanguage,
  }) async* {
    if (text.trim().isEmpty) {
      yield text;
      return;
    }

    // Check cache first - if cached, yield full result
    final sourceLang = sourceLanguage ?? 'auto';
    final cached =
        await _cache.getCachedTranslation(text, sourceLang, targetLanguage);
    if (cached != null) {
      _talker.debug('Gemini translation cache hit (streaming)');
      yield cached;
      return;
    }

    final model = await _getModel();
    final prompt = _buildPrompt(text, targetLanguage, sourceLanguage);

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

      if (fullResult.isEmpty) {
        throw EmptyResponseException(
            message: 'Gemini streaming returned empty response');
      }

      if (fullResult != 'TRANSLATION_FAILED') {
        // Cache the complete result
        await _cache.cacheTranslation(
            text, sourceLang, targetLanguage, fullResult);
        _talker.info(
            'Gemini streaming translation completed in ${stopwatch.elapsedMilliseconds}ms');
      }
    } on GenerativeAIException catch (e) {
      _talker.error('Gemini streaming error: ${e.message}');
      if (e.message.contains('429') ||
          e.message.toLowerCase().contains('rate')) {
        throw RateLimitException(cause: e);
      }
      throw TranslationException('Gemini API error: ${e.message}', cause: e);
    }
  }

  /// Clears the cached model (useful when API key changes).
  void clearModelCache() {
    _model = null;
  }
}
