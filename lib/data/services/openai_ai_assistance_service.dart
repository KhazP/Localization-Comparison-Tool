import 'package:localizer_app_main/core/services/ai_usage_service.dart';
import 'package:localizer_app_main/core/services/dio_client.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/models/ai_suggestion_result.dart';
import 'package:localizer_app_main/data/services/ai_assistance_service.dart';
import 'package:localizer_app_main/data/services/translation_exceptions.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';

/// Configuration for OpenAI translation requests.
class OpenAiTranslationConfig {
  /// Creates an OpenAI translation config.
  const OpenAiTranslationConfig({
    this.model = 'gpt-4o-mini',
    this.temperature = 0.7,
    this.maxOutputTokens = 2048,
    this.systemInstructions,
  });

  /// Model name to use for translations.
  final String model;

  /// Controls randomness in output.
  final double temperature;

  /// Maximum tokens to return in the response.
  final int maxOutputTokens;

  /// Optional custom system instructions.
  final String? systemInstructions;

  /// Creates a copy with the given fields replaced.
  OpenAiTranslationConfig copyWith({
    String? model,
    double? temperature,
    int? maxOutputTokens,
    String? systemInstructions,
  }) {
    return OpenAiTranslationConfig(
      model: model ?? this.model,
      temperature: temperature ?? this.temperature,
      maxOutputTokens: maxOutputTokens ?? this.maxOutputTokens,
      systemInstructions: systemInstructions ?? this.systemInstructions,
    );
  }
}

/// OpenAI implementation of [AiAssistanceService].
class OpenAiAiAssistanceService implements AiAssistanceService {
  OpenAiAiAssistanceService({
    required SecureStorageService secureStorage,
    required LocalTranslationCache cache,
    required DioClient dioClient,
    required TalkerService talkerService,
    required AiUsageService usageService,
    OpenAiTranslationConfig? config,
  })  : _secureStorage = secureStorage,
        _cache = cache,
        _dioClient = dioClient,
        _talker = talkerService,
        _usageService = usageService,
        _config = config ?? const OpenAiTranslationConfig();

  final SecureStorageService _secureStorage;
  final LocalTranslationCache _cache;
  final DioClient _dioClient;
  final TalkerService _talker;
  final AiUsageService _usageService;
  OpenAiTranslationConfig _config;

  static const _endpoint = 'https://api.openai.com/v1/chat/completions';

  @override
  String get providerName => 'OpenAI';

  /// Updates the configuration.
  void updateConfig(OpenAiTranslationConfig newConfig) {
    _config = newConfig;
  }

  static const _defaultTranslationPrompt = '''You are a professional
translator. Translate the provided text accurately and naturally.

RULES:
- Return ONLY the translated text, nothing else
- No explanations, notes, or commentary
- Preserve formatting: newlines, quotes, HTML tags,
  placeholders like {name} or %s
- Preserve technical terminology
- Maintain the original tone and style
- If translation is impossible, respond with exactly: TRANSLATION_FAILED''';

  static const _defaultRephrasePrompt = '''You are a professional editor.
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

  /// Translates text using OpenAI for suggestion workflows.
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
    final cached =
        await _cache.getCachedTranslation(text, sourceLang, targetLanguage);
    if (cached != null) {
      _talker.debug('OpenAI suggestion cache hit');
      return TranslationSuggestion(
        originalText: text,
        translatedText: cached,
        confidence: 1.0,
        providerName: providerName,
      );
    }

    final stopwatch = Stopwatch()..start();
    final prompt = _buildTranslationPrompt(
      text: text,
      targetLanguage: targetLanguage,
      sourceLanguage: sourceLanguage,
      contextStrings: contextStrings,
    );

    try {
      final response = await _createCompletion(
        systemPrompt: _buildSystemPrompt(_defaultTranslationPrompt),
        userPrompt: prompt,
      );

      stopwatch.stop();
      await _recordUsage(response, stopwatch.elapsedMilliseconds);

      await _cache.cacheTranslation(
        text,
        sourceLang,
        targetLanguage,
        response.text,
      );

      return TranslationSuggestion(
        originalText: text,
        translatedText: response.text,
        confidence: 0.9,
        providerName: providerName,
      );
    } catch (e, stackTrace) {
      _talker.handle(e, stackTrace, 'OpenAI translation failed');
      rethrow;
    }
  }

  /// Rephrases text using OpenAI.
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
    final prompt = _buildRephrasePrompt(
      text: text,
      targetLanguage: targetLanguage,
      style: style,
      sourceText: sourceText,
    );

    try {
      final response = await _createCompletion(
        systemPrompt: _buildSystemPrompt(_defaultRephrasePrompt),
        userPrompt: prompt,
      );

      stopwatch.stop();
      await _recordUsage(response, stopwatch.elapsedMilliseconds);

      return RephraseResult(
        originalText: text,
        rephrasedText: response.text,
        providerName: providerName,
      );
    } catch (e, stackTrace) {
      _talker.handle(e, stackTrace, 'OpenAI rephrase failed');
      rethrow;
    }
  }

  /// Streams translated text (non-streaming fallback).
  @override
  Stream<String> translateStream({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  }) async* {
    final suggestion = await suggestTranslation(
      text: text,
      targetLanguage: targetLanguage,
      sourceLanguage: sourceLanguage,
    );
    yield suggestion.translatedText;
  }

  String _buildTranslationPrompt({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
    List<String>? contextStrings,
  }) {
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

  String _buildRephrasePrompt({
    required String text,
    String? targetLanguage,
    String? style,
    String? sourceText,
  }) {
    final buffer = StringBuffer();

    if (style != null && style.trim().isNotEmpty) {
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

    buffer.writeln();
    buffer.write(text);

    return buffer.toString();
  }

  String _buildSystemPrompt(String basePrompt) {
    final custom = _config.systemInstructions;
    if (custom == null || custom.trim().isEmpty) {
      return basePrompt;
    }
    return '$basePrompt\n\nPROJECT NOTES:\n$custom';
  }

  Future<
      ({
        String text,
        int promptTokens,
        int completionTokens,
        int totalTokens,
        String? model,
      })> _createCompletion({
    required String systemPrompt,
    required String userPrompt,
  }) async {
    final apiKey = await _secureStorage.getOpenAiApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw MissingApiKeyException(
        'Add your OpenAI API key in Settings to enable AI features.',
      );
    }

    final response = await _dioClient.post<Map<String, dynamic>>(
      _endpoint,
      data: {
        'model': _config.model,
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': userPrompt},
        ],
        'temperature': _config.temperature,
        'max_tokens': _config.maxOutputTokens,
      },
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
    );

    final status = response.statusCode ?? 0;
    if (status == 401 || status == 403) {
      throw MissingApiKeyException(
        'Add your OpenAI API key in Settings to enable AI features.',
      );
    }
    if (status == 429) {
      throw RateLimitException();
    }

    if (status != 200 || response.data == null) {
      throw TranslationException('OpenAI request failed.');
    }

    final data = response.data!;
    final choices = data['choices'] as List<dynamic>? ?? [];
    final first = choices.isNotEmpty ? choices.first : null;
    final message = first is Map<String, dynamic> ? first['message'] : null;
    final content = message is Map<String, dynamic> ? message['content'] : null;
    final text = content is String ? content.trim() : '';

    if (text.isEmpty || text == 'TRANSLATION_FAILED') {
      throw EmptyResponseException(
        message: 'OpenAI returned empty or failed response',
      );
    }

    final usage = data['usage'] as Map<String, dynamic>? ?? const {};
    return (
      text: text,
      promptTokens: usage['prompt_tokens'] as int? ?? 0,
      completionTokens: usage['completion_tokens'] as int? ?? 0,
      totalTokens: usage['total_tokens'] as int? ?? 0,
      model: data['model'] as String?,
    );
  }

  Future<void> _recordUsage(
    ({
      String text,
      int promptTokens,
      int completionTokens,
      int totalTokens,
      String? model,
    }) response,
    int latencyMs,
  ) async {
    await _usageService.recordUsage(
      providerName: providerName,
      promptTokens: response.promptTokens,
      completionTokens: response.completionTokens,
      totalTokens: response.totalTokens,
      model: response.model ?? _config.model,
      latencyMs: latencyMs,
    );
  }
}
