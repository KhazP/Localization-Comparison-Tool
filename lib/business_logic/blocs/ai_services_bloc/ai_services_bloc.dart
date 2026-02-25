import 'package:bloc/bloc.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';

import 'ai_services_event.dart';
import 'ai_services_state.dart';

export 'ai_services_event.dart';
export 'ai_services_state.dart';

class AiServicesBloc extends Bloc<AiServicesEvent, AiServicesState> {
  final SettingsRepository _settingsRepository;
  final SecureStorageService _secureStorageService;
  final ApiKeyValidationService _apiKeyValidationService;

  AiServicesBloc({
    required SettingsRepository settingsRepository,
    required SecureStorageService secureStorageService,
    required ApiKeyValidationService apiKeyValidationService,
  })  : _settingsRepository = settingsRepository,
        _secureStorageService = secureStorageService,
        _apiKeyValidationService = apiKeyValidationService,
        super(AiServicesState.initial()) {
    on<LoadAiServicesSettings>(_onLoadAiServicesSettings);
    on<UpdateAiTranslationService>(_onUpdateAiTranslationService);
    on<UpdateGoogleTranslateApiKey>(_onUpdateGoogleTranslateApiKey);
    on<UpdateDeeplApiKey>(_onUpdateDeeplApiKey);
    on<UpdateEnableAiTranslation>(_onUpdateEnableAiTranslation);
    on<UpdateTranslationConfidenceThreshold>(
        _onUpdateTranslationConfidenceThreshold);
    on<UpdateGeminiApiKey>(_onUpdateGeminiApiKey);
    on<UpdateOpenAiApiKey>(_onUpdateOpenAiApiKey);
    on<TestApiKey>(_onTestApiKey);
    on<FetchAvailableModels>(_onFetchAvailableModels);
    on<UpdateAiTemperature>(_onUpdateAiTemperature);
    on<UpdateMaxTokens>(_onUpdateMaxTokens);
    on<UpdateDefaultAiModel>(_onUpdateDefaultAiModel);
    on<UpdateSystemTranslationContext>(_onUpdateSystemTranslationContext);
    on<UpdateContextStringsCount>(_onUpdateContextStringsCount);
    on<UpdateIncludeContextStrings>(_onUpdateIncludeContextStrings);
    on<UpdateEnableTranslationMemory>(_onUpdateEnableTranslationMemory);
    on<UpdateEnableFuzzyFill>(_onUpdateEnableFuzzyFill);
    on<UpdateFuzzyFillMinScore>(_onUpdateFuzzyFillMinScore);
    on<UpdateFuzzyFillAutoApply>(_onUpdateFuzzyFillAutoApply);
    on<UpdateFuzzyFillOnlyEmptyTargets>(_onUpdateFuzzyFillOnlyEmptyTargets);
    on<UpdateFuzzyFillMatchLimit>(_onUpdateFuzzyFillMatchLimit);
    on<UpdateFuzzyFillExactMatchesOnly>(_onUpdateFuzzyFillExactMatchesOnly);
    on<UpdateTranslationStrategy>(_onUpdateTranslationStrategy);
    on<ResetAiServicesSettings>(_onResetAiServicesSettings);
  }

  Future<void> _saveSettings(AppSettings Function(AppSettings) updater) async {
    final settings = await _settingsRepository.loadSettings();
    final newSettings = updater(settings);
    // Clear API keys before saving to Hive
    final storageSettings = newSettings.copyWith(
      googleTranslateApiKey: '',
      deeplApiKey: '',
      geminiApiKey: '',
      openaiApiKey: '',
    );
    await _settingsRepository.saveSettings(storageSettings);
  }

  Map<ApiProvider, ApiKeyTestResult> _updateApiKeyTest(
    ApiProvider provider,
    ApiKeyTestResult result,
  ) {
    final updated = Map<ApiProvider, ApiKeyTestResult>.from(state.apiKeyTests);
    updated[provider] = result;
    return updated;
  }

  Map<ApiProvider, ApiKeyTestResult> _initialApiKeyTests() {
    return {
      ApiProvider.googleTranslate: ApiKeyTestResult.idle,
      ApiProvider.deepl: ApiKeyTestResult.idle,
      ApiProvider.gemini: ApiKeyTestResult.idle,
      ApiProvider.openAi: ApiKeyTestResult.idle,
    };
  }

  Future<void> _onLoadAiServicesSettings(
    LoadAiServicesSettings event,
    Emitter<AiServicesState> emit,
  ) async {
    emit(state.copyWith(status: AiServicesStatus.loading));
    try {
      var settings = await _settingsRepository.loadSettings();

      // Load API keys from secure storage
      final googleKey = await _secureStorageService.getGoogleApiKey();
      final deeplKey = await _secureStorageService.getDeepLApiKey();
      final geminiKey = await _secureStorageService.getGeminiApiKey();
      final openaiKey = await _secureStorageService.getOpenAiApiKey();

      emit(state.copyWith(
        aiTranslationService: settings.aiTranslationService,
        googleTranslateApiKey: googleKey ?? settings.googleTranslateApiKey,
        deeplApiKey: deeplKey ?? settings.deeplApiKey,
        enableAiTranslation: settings.enableAiTranslation,
        translationConfidenceThreshold: settings.translationConfidenceThreshold,
        geminiApiKey: geminiKey ?? settings.geminiApiKey,
        openaiApiKey: openaiKey ?? settings.openaiApiKey,
        defaultAiModel: settings.defaultAiModel,
        systemTranslationContext: settings.systemTranslationContext,
        contextStringsCount: settings.contextStringsCount,
        includeContextStrings: settings.includeContextStrings,
        enableTranslationMemory: settings.enableTranslationMemory,
        enableFuzzyFill: settings.enableFuzzyFill,
        fuzzyFillMinScore: settings.fuzzyFillMinScore,
        fuzzyFillAutoApply: settings.fuzzyFillAutoApply,
        fuzzyFillOnlyEmptyTargets: settings.fuzzyFillOnlyEmptyTargets,
        fuzzyFillMatchLimit: settings.fuzzyFillMatchLimit,
        fuzzyFillExactMatchesOnly: settings.fuzzyFillExactMatchesOnly,
        aiTemperature: settings.aiTemperature,
        maxTokens: settings.maxTokens,
        translationStrategy: settings.translationStrategy,
        status: AiServicesStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AiServicesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateAiTranslationService(
    UpdateAiTranslationService event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(aiTranslationService: event.service));
    emit(state.copyWith(aiTranslationService: event.service));
  }

  Future<void> _onUpdateGoogleTranslateApiKey(
    UpdateGoogleTranslateApiKey event,
    Emitter<AiServicesState> emit,
  ) async {
    await _secureStorageService.storeGoogleApiKey(event.apiKey);
    await _saveSettings((s) => s.copyWith(googleTranslateApiKey: event.apiKey));
    emit(state.copyWith(
      googleTranslateApiKey: event.apiKey,
      apiKeyTests:
          _updateApiKeyTest(ApiProvider.googleTranslate, ApiKeyTestResult.idle),
    ));
  }

  Future<void> _onUpdateDeeplApiKey(
    UpdateDeeplApiKey event,
    Emitter<AiServicesState> emit,
  ) async {
    await _secureStorageService.storeDeepLApiKey(event.apiKey);
    await _saveSettings((s) => s.copyWith(deeplApiKey: event.apiKey));
    emit(state.copyWith(
      deeplApiKey: event.apiKey,
      apiKeyTests: _updateApiKeyTest(ApiProvider.deepl, ApiKeyTestResult.idle),
    ));
  }

  Future<void> _onUpdateEnableAiTranslation(
    UpdateEnableAiTranslation event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(enableAiTranslation: event.enabled));
    emit(state.copyWith(enableAiTranslation: event.enabled));
  }

  Future<void> _onUpdateTranslationConfidenceThreshold(
    UpdateTranslationConfidenceThreshold event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings(
        (s) => s.copyWith(translationConfidenceThreshold: event.threshold));
    emit(state.copyWith(translationConfidenceThreshold: event.threshold));
  }

  Future<void> _onUpdateGeminiApiKey(
    UpdateGeminiApiKey event,
    Emitter<AiServicesState> emit,
  ) async {
    await _secureStorageService.storeGeminiApiKey(event.apiKey);
    await _saveSettings((s) => s.copyWith(geminiApiKey: event.apiKey));
    emit(state.copyWith(
      geminiApiKey: event.apiKey,
      apiKeyTests: _updateApiKeyTest(ApiProvider.gemini, ApiKeyTestResult.idle),
    ));
  }

  Future<void> _onUpdateOpenAiApiKey(
    UpdateOpenAiApiKey event,
    Emitter<AiServicesState> emit,
  ) async {
    await _secureStorageService.storeOpenAiApiKey(event.apiKey);
    await _saveSettings((s) => s.copyWith(openaiApiKey: event.apiKey));
    emit(state.copyWith(
      openaiApiKey: event.apiKey,
      apiKeyTests: _updateApiKeyTest(ApiProvider.openAi, ApiKeyTestResult.idle),
    ));
  }

  Future<void> _onTestApiKey(
    TestApiKey event,
    Emitter<AiServicesState> emit,
  ) async {
    final trimmedKey = event.apiKey.trim();
    if (trimmedKey.isEmpty) {
      emit(state.copyWith(
        apiKeyTests: _updateApiKeyTest(
          event.provider,
          const ApiKeyTestResult(
            status: ApiKeyTestStatus.failure,
            message: 'Please enter a key first.',
          ),
        ),
      ));
      return;
    }

    emit(state.copyWith(
      apiKeyTests: _updateApiKeyTest(
        event.provider,
        const ApiKeyTestResult(
          status: ApiKeyTestStatus.testing,
          message: 'Checking...',
        ),
      ),
    ));

    final result = await _apiKeyValidationService.testApiKey(
      event.provider,
      trimmedKey,
    );

    emit(state.copyWith(
      apiKeyTests: _updateApiKeyTest(
        event.provider,
        ApiKeyTestResult(
          status: result.success
              ? ApiKeyTestStatus.success
              : ApiKeyTestStatus.failure,
          message: result.message,
          usage: result.usage,
        ),
      ),
    ));

    if (result.success &&
        (event.provider == ApiProvider.gemini ||
            event.provider == ApiProvider.openAi)) {
      add(FetchAvailableModels(event.provider));
    }
  }

  Future<void> _onFetchAvailableModels(
    FetchAvailableModels event,
    Emitter<AiServicesState> emit,
  ) async {
    String? apiKey;
    if (event.provider == ApiProvider.gemini) {
      apiKey = await _secureStorageService.getGeminiApiKey();
    } else if (event.provider == ApiProvider.openAi) {
      apiKey = await _secureStorageService.getOpenAiApiKey();
    }

    if (apiKey == null || apiKey.isEmpty) return;

    final models = await _apiKeyValidationService.fetchAvailableModels(
      event.provider,
      apiKey,
    );

    if (models.isNotEmpty) {
      final updatedAvailableModels =
          Map<ApiProvider, List<String>>.from(state.availableModels);
      updatedAvailableModels[event.provider] = models;
      emit(state.copyWith(availableModels: updatedAvailableModels));

      if (state.defaultAiModel.isEmpty) {
        add(UpdateDefaultAiModel(models.first));
      }
    }
  }

  Future<void> _onUpdateAiTemperature(
    UpdateAiTemperature event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(aiTemperature: event.temperature));
    emit(state.copyWith(aiTemperature: event.temperature));
  }

  Future<void> _onUpdateMaxTokens(
    UpdateMaxTokens event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(maxTokens: event.maxTokens));
    emit(state.copyWith(maxTokens: event.maxTokens));
  }

  Future<void> _onUpdateDefaultAiModel(
    UpdateDefaultAiModel event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(defaultAiModel: event.model));
    emit(state.copyWith(defaultAiModel: event.model));
  }

  Future<void> _onUpdateSystemTranslationContext(
    UpdateSystemTranslationContext event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings(
        (s) => s.copyWith(systemTranslationContext: event.context));
    emit(state.copyWith(systemTranslationContext: event.context));
  }

  Future<void> _onUpdateContextStringsCount(
    UpdateContextStringsCount event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(contextStringsCount: event.count));
    emit(state.copyWith(contextStringsCount: event.count));
  }

  Future<void> _onUpdateIncludeContextStrings(
    UpdateIncludeContextStrings event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings(
        (s) => s.copyWith(includeContextStrings: event.include));
    emit(state.copyWith(includeContextStrings: event.include));
  }

  Future<void> _onUpdateEnableTranslationMemory(
    UpdateEnableTranslationMemory event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings(
        (s) => s.copyWith(enableTranslationMemory: event.enabled));
    emit(state.copyWith(enableTranslationMemory: event.enabled));
  }

  Future<void> _onUpdateEnableFuzzyFill(
    UpdateEnableFuzzyFill event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(enableFuzzyFill: event.enabled));
    emit(state.copyWith(enableFuzzyFill: event.enabled));
  }

  Future<void> _onUpdateFuzzyFillMinScore(
    UpdateFuzzyFillMinScore event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(fuzzyFillMinScore: event.minScore));
    emit(state.copyWith(fuzzyFillMinScore: event.minScore));
  }

  Future<void> _onUpdateFuzzyFillAutoApply(
    UpdateFuzzyFillAutoApply event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(fuzzyFillAutoApply: event.enabled));
    emit(state.copyWith(fuzzyFillAutoApply: event.enabled));
  }

  Future<void> _onUpdateFuzzyFillOnlyEmptyTargets(
    UpdateFuzzyFillOnlyEmptyTargets event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings(
        (s) => s.copyWith(fuzzyFillOnlyEmptyTargets: event.enabled));
    emit(state.copyWith(fuzzyFillOnlyEmptyTargets: event.enabled));
  }

  Future<void> _onUpdateFuzzyFillMatchLimit(
    UpdateFuzzyFillMatchLimit event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings((s) => s.copyWith(fuzzyFillMatchLimit: event.limit));
    emit(state.copyWith(fuzzyFillMatchLimit: event.limit));
  }

  Future<void> _onUpdateFuzzyFillExactMatchesOnly(
    UpdateFuzzyFillExactMatchesOnly event,
    Emitter<AiServicesState> emit,
  ) async {
    await _saveSettings(
        (s) => s.copyWith(fuzzyFillExactMatchesOnly: event.enabled));
    emit(state.copyWith(fuzzyFillExactMatchesOnly: event.enabled));
  }

  Future<void> _onUpdateTranslationStrategy(
    UpdateTranslationStrategy event,
    Emitter<AiServicesState> emit,
  ) async {
    String aiTranslationService = state.aiTranslationService;

    // Auto-switch service if needed based on strategy
    if (event.strategy == 'llm') {
      if (aiTranslationService != 'Gemini' &&
          aiTranslationService != 'OpenAI') {
        aiTranslationService = 'Gemini';
      }
    } else if (event.strategy == 'cloud') {
      if (aiTranslationService != 'Google Translate' &&
          aiTranslationService != 'DeepL' &&
          aiTranslationService != 'Azure') {
        aiTranslationService = 'Google Translate';
      }
    }

    await _saveSettings((s) => s.copyWith(
          translationStrategy: event.strategy,
          aiTranslationService: aiTranslationService,
        ));
    emit(state.copyWith(
      translationStrategy: event.strategy,
      aiTranslationService: aiTranslationService,
    ));
  }

  Future<void> _onResetAiServicesSettings(
    ResetAiServicesSettings event,
    Emitter<AiServicesState> emit,
  ) async {
    await _secureStorageService.clearAllKeys();
    final defaults = AppSettings.defaultSettings();
    await _saveSettings((s) => s.copyWith(
          aiTranslationService: defaults.aiTranslationService,
          googleTranslateApiKey: defaults.googleTranslateApiKey,
          deeplApiKey: defaults.deeplApiKey,
          enableAiTranslation: defaults.enableAiTranslation,
          translationConfidenceThreshold:
              defaults.translationConfidenceThreshold,
          geminiApiKey: defaults.geminiApiKey,
          openaiApiKey: defaults.openaiApiKey,
          defaultAiModel: defaults.defaultAiModel,
          systemTranslationContext: defaults.systemTranslationContext,
          contextStringsCount: defaults.contextStringsCount,
          includeContextStrings: defaults.includeContextStrings,
        ));
    emit(state.copyWith(
      aiTranslationService: defaults.aiTranslationService,
      googleTranslateApiKey: defaults.googleTranslateApiKey,
      deeplApiKey: defaults.deeplApiKey,
      enableAiTranslation: defaults.enableAiTranslation,
      translationConfidenceThreshold: defaults.translationConfidenceThreshold,
      geminiApiKey: defaults.geminiApiKey,
      openaiApiKey: defaults.openaiApiKey,
      defaultAiModel: defaults.defaultAiModel,
      systemTranslationContext: defaults.systemTranslationContext,
      contextStringsCount: defaults.contextStringsCount,
      includeContextStrings: defaults.includeContextStrings,
      apiKeyTests: _initialApiKeyTests(),
    ));
  }
}
