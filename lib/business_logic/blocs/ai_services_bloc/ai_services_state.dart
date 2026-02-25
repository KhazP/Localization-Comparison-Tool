import 'package:equatable/equatable.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';

enum AiServicesStatus { initial, loading, loaded, error }

enum ApiKeyTestStatus { idle, testing, success, failure }

class ApiKeyTestResult extends Equatable {
  final ApiKeyTestStatus status;
  final String message;
  final String? usage;

  const ApiKeyTestResult({
    required this.status,
    required this.message,
    this.usage,
  });

  static const ApiKeyTestResult idle = ApiKeyTestResult(
    status: ApiKeyTestStatus.idle,
    message: '',
    usage: null,
  );

  @override
  List<Object?> get props => [status, message, usage];
}

class AiServicesState extends Equatable {
  final String aiTranslationService;
  final String googleTranslateApiKey;
  final String deeplApiKey;
  final bool enableAiTranslation;
  final double translationConfidenceThreshold;
  final String geminiApiKey;
  final String openaiApiKey;
  final String defaultAiModel;
  final String systemTranslationContext;
  final int contextStringsCount;
  final bool includeContextStrings;
  final bool enableTranslationMemory;
  final bool enableFuzzyFill;
  final double fuzzyFillMinScore;
  final bool fuzzyFillAutoApply;
  final bool fuzzyFillOnlyEmptyTargets;
  final int fuzzyFillMatchLimit;
  final bool fuzzyFillExactMatchesOnly;
  final double aiTemperature;
  final int maxTokens;
  final String translationStrategy;
  final Map<ApiProvider, ApiKeyTestResult> apiKeyTests;
  final Map<ApiProvider, List<String>> availableModels;
  final AiServicesStatus status;
  final String? errorMessage;

  const AiServicesState({
    required this.aiTranslationService,
    required this.googleTranslateApiKey,
    required this.deeplApiKey,
    required this.enableAiTranslation,
    required this.translationConfidenceThreshold,
    required this.geminiApiKey,
    required this.openaiApiKey,
    required this.defaultAiModel,
    required this.systemTranslationContext,
    required this.contextStringsCount,
    required this.includeContextStrings,
    required this.enableTranslationMemory,
    required this.enableFuzzyFill,
    required this.fuzzyFillMinScore,
    required this.fuzzyFillAutoApply,
    required this.fuzzyFillOnlyEmptyTargets,
    required this.fuzzyFillMatchLimit,
    required this.fuzzyFillExactMatchesOnly,
    required this.aiTemperature,
    required this.maxTokens,
    required this.translationStrategy,
    required this.apiKeyTests,
    required this.availableModels,
    this.status = AiServicesStatus.initial,
    this.errorMessage,
  });

  factory AiServicesState.initial() {
    final defaults = AppSettings.defaultSettings();
    return AiServicesState(
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
      enableTranslationMemory: defaults.enableTranslationMemory,
      enableFuzzyFill: defaults.enableFuzzyFill,
      fuzzyFillMinScore: defaults.fuzzyFillMinScore,
      fuzzyFillAutoApply: defaults.fuzzyFillAutoApply,
      fuzzyFillOnlyEmptyTargets: defaults.fuzzyFillOnlyEmptyTargets,
      fuzzyFillMatchLimit: defaults.fuzzyFillMatchLimit,
      fuzzyFillExactMatchesOnly: defaults.fuzzyFillExactMatchesOnly,
      aiTemperature: defaults.aiTemperature,
      maxTokens: defaults.maxTokens,
      translationStrategy: defaults.translationStrategy,
      apiKeyTests: {
        ApiProvider.googleTranslate: ApiKeyTestResult.idle,
        ApiProvider.deepl: ApiKeyTestResult.idle,
        ApiProvider.gemini: ApiKeyTestResult.idle,
        ApiProvider.openAi: ApiKeyTestResult.idle,
      },
      availableModels: const {
        ApiProvider.gemini: [
          'gemini-1.5-flash',
          'gemini-1.5-pro',
          'gemini-1.0-pro',
        ],
        ApiProvider.openAi: [
          'gpt-4o',
          'gpt-4o-mini',
          'gpt-4-turbo',
          'gpt-3.5-turbo',
        ],
      },
    );
  }

  AiServicesState copyWith({
    String? aiTranslationService,
    String? googleTranslateApiKey,
    String? deeplApiKey,
    bool? enableAiTranslation,
    double? translationConfidenceThreshold,
    String? geminiApiKey,
    String? openaiApiKey,
    String? defaultAiModel,
    String? systemTranslationContext,
    int? contextStringsCount,
    bool? includeContextStrings,
    bool? enableTranslationMemory,
    bool? enableFuzzyFill,
    double? fuzzyFillMinScore,
    bool? fuzzyFillAutoApply,
    bool? fuzzyFillOnlyEmptyTargets,
    int? fuzzyFillMatchLimit,
    bool? fuzzyFillExactMatchesOnly,
    double? aiTemperature,
    int? maxTokens,
    String? translationStrategy,
    Map<ApiProvider, ApiKeyTestResult>? apiKeyTests,
    Map<ApiProvider, List<String>>? availableModels,
    AiServicesStatus? status,
    String? errorMessage,
  }) {
    return AiServicesState(
      aiTranslationService: aiTranslationService ?? this.aiTranslationService,
      googleTranslateApiKey:
          googleTranslateApiKey ?? this.googleTranslateApiKey,
      deeplApiKey: deeplApiKey ?? this.deeplApiKey,
      enableAiTranslation: enableAiTranslation ?? this.enableAiTranslation,
      translationConfidenceThreshold:
          translationConfidenceThreshold ?? this.translationConfidenceThreshold,
      geminiApiKey: geminiApiKey ?? this.geminiApiKey,
      openaiApiKey: openaiApiKey ?? this.openaiApiKey,
      defaultAiModel: defaultAiModel ?? this.defaultAiModel,
      systemTranslationContext:
          systemTranslationContext ?? this.systemTranslationContext,
      contextStringsCount: contextStringsCount ?? this.contextStringsCount,
      includeContextStrings:
          includeContextStrings ?? this.includeContextStrings,
      enableTranslationMemory:
          enableTranslationMemory ?? this.enableTranslationMemory,
      enableFuzzyFill: enableFuzzyFill ?? this.enableFuzzyFill,
      fuzzyFillMinScore: fuzzyFillMinScore ?? this.fuzzyFillMinScore,
      fuzzyFillAutoApply: fuzzyFillAutoApply ?? this.fuzzyFillAutoApply,
      fuzzyFillOnlyEmptyTargets:
          fuzzyFillOnlyEmptyTargets ?? this.fuzzyFillOnlyEmptyTargets,
      fuzzyFillMatchLimit: fuzzyFillMatchLimit ?? this.fuzzyFillMatchLimit,
      fuzzyFillExactMatchesOnly:
          fuzzyFillExactMatchesOnly ?? this.fuzzyFillExactMatchesOnly,
      aiTemperature: aiTemperature ?? this.aiTemperature,
      maxTokens: maxTokens ?? this.maxTokens,
      translationStrategy: translationStrategy ?? this.translationStrategy,
      apiKeyTests: apiKeyTests ?? this.apiKeyTests,
      availableModels: availableModels ?? this.availableModels,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        aiTranslationService,
        googleTranslateApiKey,
        deeplApiKey,
        enableAiTranslation,
        translationConfidenceThreshold,
        geminiApiKey,
        openaiApiKey,
        defaultAiModel,
        systemTranslationContext,
        contextStringsCount,
        includeContextStrings,
        enableTranslationMemory,
        enableFuzzyFill,
        fuzzyFillMinScore,
        fuzzyFillAutoApply,
        fuzzyFillOnlyEmptyTargets,
        fuzzyFillMatchLimit,
        fuzzyFillExactMatchesOnly,
        aiTemperature,
        maxTokens,
        translationStrategy,
        apiKeyTests,
        availableModels,
        status,
        errorMessage,
      ];
}
