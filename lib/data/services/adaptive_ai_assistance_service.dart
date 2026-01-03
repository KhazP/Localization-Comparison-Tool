import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/models/ai_suggestion_result.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/data/services/ai_assistance_service.dart';
import 'package:localizer_app_main/data/services/cloud_translation_ai_assistance_service.dart';
import 'package:localizer_app_main/data/services/deepl_translation_service.dart';
import 'package:localizer_app_main/data/services/gemini_ai_assistance_service.dart';
import 'package:localizer_app_main/data/services/gemini_translation_service.dart';
import 'package:localizer_app_main/data/services/openai_ai_assistance_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';

/// Routes AI requests to the provider selected in settings.
class AdaptiveAiAssistanceService implements AiAssistanceService {
  AdaptiveAiAssistanceService({
    required SettingsRepository settingsRepository,
    required SecureStorageService secureStorage,
    required LocalTranslationCache cache,
    required GeminiAiAssistanceService geminiService,
    required OpenAiAiAssistanceService openAiService,
    required TranslationService googleTranslateService,
    required DeepLTranslationService deeplTranslationService,
  })  : _settingsRepository = settingsRepository,
        _secureStorage = secureStorage,
        _geminiService = geminiService,
        _openAiService = openAiService,
        _googleTranslateService = CloudTranslationAiAssistanceService(
          translationService: googleTranslateService,
          providerDisplayName: 'Google Translate',
          cache: cache,
        ),
        _deepLService = CloudTranslationAiAssistanceService(
          translationService: deeplTranslationService,
          providerDisplayName: 'DeepL',
          cache: cache,
        );

  final SettingsRepository _settingsRepository;
  final SecureStorageService _secureStorage;
  final GeminiAiAssistanceService _geminiService;
  final OpenAiAiAssistanceService _openAiService;
  final CloudTranslationAiAssistanceService _googleTranslateService;
  final CloudTranslationAiAssistanceService _deepLService;

  @override
  String get providerName => 'Adaptive';

  @override
  Future<TranslationSuggestion> suggestTranslation({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
    List<String>? contextStrings,
  }) async {
    final service = await _resolveService();
    return service.suggestTranslation(
      text: text,
      targetLanguage: targetLanguage,
      sourceLanguage: sourceLanguage,
      contextStrings: contextStrings,
    );
  }

  @override
  Future<RephraseResult> rephrase({
    required String text,
    String? targetLanguage,
    String? style,
    String? sourceText,
  }) async {
    final service = await _resolveService();
    return service.rephrase(
      text: text,
      targetLanguage: targetLanguage,
      style: style,
      sourceText: sourceText,
    );
  }

  @override
  Stream<String> translateStream({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  }) async* {
    final service = await _resolveService();
    yield* service.translateStream(
      text: text,
      targetLanguage: targetLanguage,
      sourceLanguage: sourceLanguage,
    );
  }

  Future<AiAssistanceService> _resolveService() async {
    final settings = await _settingsRepository.loadSettings();
    if (_shouldUseCloud(settings)) {
      return await _resolveCloudProvider(settings);
    }
    _applyLlmSettings(settings);
    return _resolveLlmProvider(settings);
  }

  bool _shouldUseCloud(AppSettings settings) {
    final strategy = settings.translationStrategy.toLowerCase();
    if (strategy.contains('cloud')) {
      return true;
    }
    if (strategy.contains('llm') || strategy.contains('ai')) {
      return false;
    }
    final service = settings.aiTranslationService.toLowerCase();
    return service.contains('translate') || service.contains('deepl');
  }

  Future<AiAssistanceService> _resolveCloudProvider(
    AppSettings settings,
  ) async {
    final service = settings.aiTranslationService.toLowerCase();
    if (service.contains('deepl')) {
      return _deepLService;
    }
    final deeplKey = await _secureStorage.getDeepLApiKey();
    final googleKey = await _secureStorage.getGoogleApiKey();
    final hasDeepl = deeplKey != null && deeplKey.trim().isNotEmpty;
    final hasGoogle = googleKey != null && googleKey.trim().isNotEmpty;
    if (hasDeepl && !hasGoogle) {
      return _deepLService;
    }
    return _googleTranslateService;
  }

  AiAssistanceService _resolveLlmProvider(AppSettings settings) {
    final service = settings.aiTranslationService.toLowerCase();
    if (service.contains('openai') || service.contains('gpt')) {
      return _openAiService;
    }
    return _geminiService;
  }

  void _applyLlmSettings(AppSettings settings) {
    final customPrompt = settings.systemTranslationContext.trim();
    final systemInstructions =
        customPrompt.isEmpty ? null : settings.systemTranslationContext;

    _geminiService.updateConfig(
      GeminiTranslationConfig(
        temperature: settings.aiTemperature,
        maxOutputTokens: settings.maxTokens,
        systemInstructions: systemInstructions,
      ),
    );

    _openAiService.updateConfig(
      OpenAiTranslationConfig(
        model: _resolveOpenAiModel(settings),
        temperature: settings.aiTemperature,
        maxOutputTokens: settings.maxTokens,
        systemInstructions: systemInstructions,
      ),
    );
  }

  String _resolveOpenAiModel(AppSettings settings) {
    final model = settings.defaultAiModel.trim();
    if (model.isEmpty) {
      return const OpenAiTranslationConfig().model;
    }
    final normalized = model.toLowerCase();
    if (normalized.contains('gpt') || normalized.startsWith('o')) {
      return model;
    }
    return const OpenAiTranslationConfig().model;
  }
}
