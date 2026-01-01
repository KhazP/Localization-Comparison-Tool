part of 'settings_bloc.dart';

enum SettingsStatus { initial, loading, loaded, error }

/// Stores the latest validation state for an API key.
class ApiKeyTestResult extends Equatable {
  final ApiKeyTestStatus status;
  final String message;
  final String? usage;

  const ApiKeyTestResult({
    required this.status,
    required this.message,
    this.usage,
  });

  const ApiKeyTestResult.idle()
      : status = ApiKeyTestStatus.idle,
        message = '',
        usage = null;

  ApiKeyTestResult copyWith({
    ApiKeyTestStatus? status,
    String? message,
    String? usage,
  }) {
    return ApiKeyTestResult(
      status: status ?? this.status,
      message: message ?? this.message,
      usage: usage ?? this.usage,
    );
  }

  @override
  List<Object?> get props => [status, message, usage];
}

class SettingsState extends Equatable {
  final AppSettings appSettings;
  final SettingsStatus status;
  final String? errorMessage;
  final Map<ApiProvider, ApiKeyTestResult> apiKeyTests;
  final Map<ApiProvider, List<String>> availableModels;
  
  // Project settings scope (Phase 2)
  final SettingsScope scope;
  final ProjectSettings? projectSettings;
  final String? currentProjectId;
  final String? currentProjectName;

  const SettingsState({
    required this.appSettings,
    this.status = SettingsStatus.initial,
    this.errorMessage,
    required this.apiKeyTests,
    this.availableModels = const {},
    this.scope = SettingsScope.global,
    this.projectSettings,
    this.currentProjectId,
    this.currentProjectName,
  });

  factory SettingsState.initial() {
    return SettingsState(
      appSettings: AppSettings.defaultSettings(),
      apiKeyTests: {
        ApiProvider.googleTranslate: const ApiKeyTestResult.idle(),
        ApiProvider.deepl: const ApiKeyTestResult.idle(),
        ApiProvider.gemini: const ApiKeyTestResult.idle(),
        ApiProvider.openAi: const ApiKeyTestResult.idle(),
      },
      availableModels: const {
        ApiProvider.gemini: ['gemini-1.5-flash', 'gemini-1.5-pro', 'gemini-1.0-pro'], // Default fallbacks
        ApiProvider.openAi: ['gpt-4o', 'gpt-4o-mini', 'gpt-4-turbo', 'gpt-3.5-turbo'], // Default fallbacks
      },
    );
  }
  
  /// Whether a project is currently loaded (has settings available).
  bool get hasProject => projectSettings != null;
  
  /// Whether we're currently editing project-specific settings.
  bool get isProjectScope => scope == SettingsScope.project;
  
  /// Check if a specific setting is overridden in the project.
  bool isOverridden(String settingKey) {
    if (projectSettings == null) return false;
    return projectSettings!.isOverridden(settingKey);
  }
  
  /// Get the effective value for a project-overridable setting.
  /// Returns project override if exists, otherwise global default.
  String getEffectiveSystemTranslationContext() {
    if (projectSettings?.systemTranslationContext != null) {
      return projectSettings!.systemTranslationContext!;
    }
    return appSettings.systemTranslationContext;
  }
  
  String getEffectiveAiTranslationService() {
    if (projectSettings?.aiTranslationService != null) {
      return projectSettings!.aiTranslationService!;
    }
    return appSettings.aiTranslationService;
  }
  
  String getEffectiveDefaultAiModel() {
    if (projectSettings?.defaultAiModel != null) {
      return projectSettings!.defaultAiModel!;
    }
    if (projectSettings?.defaultAiModel != null) {
      return projectSettings!.defaultAiModel!;
    }
    return appSettings.defaultAiModel;
  }

  double getEffectiveSimilarityThreshold() {
    if (projectSettings?.similarityThreshold != null) {
      return projectSettings!.similarityThreshold!;
    }
    return appSettings.similarityThreshold;
  }
  
  List<String> getEffectiveIgnorePatterns() {
    if (projectSettings?.ignorePatterns != null) {
      return projectSettings!.ignorePatterns!;
    }
    return appSettings.ignorePatterns;
  }
  
  bool getEffectiveIgnoreCase() {
    if (projectSettings?.ignoreCase != null) {
      return projectSettings!.ignoreCase!;
    }
    return appSettings.ignoreCase;
  }
  
  bool getEffectiveIgnoreWhitespace() {
    if (projectSettings?.ignoreWhitespace != null) {
      return projectSettings!.ignoreWhitespace!;
    }
    return appSettings.ignoreWhitespace;
  }
  
  String getEffectiveDefaultSourceFormat() {
    if (projectSettings?.defaultSourceFormat != null) {
      return projectSettings!.defaultSourceFormat!;
    }
    return appSettings.defaultSourceFormat;
  }
  
  String getEffectiveDefaultTargetFormat() {
    if (projectSettings?.defaultTargetFormat != null) {
      return projectSettings!.defaultTargetFormat!;
    }
    return appSettings.defaultTargetFormat;
  }
  
  String getEffectiveDefaultSourceEncoding() {
    if (projectSettings?.defaultSourceEncoding != null) {
      return projectSettings!.defaultSourceEncoding!;
    }
    return appSettings.defaultSourceEncoding;
  }
  
  String getEffectiveDefaultTargetEncoding() {
    if (projectSettings?.defaultTargetEncoding != null) {
      return projectSettings!.defaultTargetEncoding!;
    }
    return appSettings.defaultTargetEncoding;
  }
  
  bool getEffectiveAutoDetectEncoding() {
    if (projectSettings?.autoDetectEncoding != null) {
      return projectSettings!.autoDetectEncoding!;
    }
    return appSettings.autoDetectEncoding;
  }
  
  /// Get the display value for a setting (considers scope and inheritance).
  /// When in project scope, shows effective value.
  /// When in global scope, shows global value.
  String getDisplayValue(String settingKey) {
    switch (settingKey) {
      case 'systemTranslationContext':
        return scope == SettingsScope.project
            ? getEffectiveSystemTranslationContext()
            : appSettings.systemTranslationContext;
      case 'aiTranslationService':
        return scope == SettingsScope.project
            ? getEffectiveAiTranslationService()
            : appSettings.aiTranslationService;
      case 'defaultAiModel':
        return scope == SettingsScope.project
            ? getEffectiveDefaultAiModel()
            : appSettings.defaultAiModel;
      default:
        return '';
    }
  }

  SettingsState copyWith({
    AppSettings? appSettings,
    SettingsStatus? status,
    String? errorMessage,
    Map<ApiProvider, ApiKeyTestResult>? apiKeyTests,
    Map<ApiProvider, List<String>>? availableModels,
    SettingsScope? scope,
    ProjectSettings? projectSettings,
    String? currentProjectId,
    String? currentProjectName,
    bool clearProjectSettings = false,
  }) {
    return SettingsState(
      appSettings: appSettings ?? this.appSettings,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      apiKeyTests: apiKeyTests ?? this.apiKeyTests,
      availableModels: availableModels ?? this.availableModels,
      scope: scope ?? this.scope,
      projectSettings: clearProjectSettings ? null : (projectSettings ?? this.projectSettings),
      currentProjectId: clearProjectSettings ? null : (currentProjectId ?? this.currentProjectId),
      currentProjectName: clearProjectSettings ? null : (currentProjectName ?? this.currentProjectName),
    );
  }

  @override
  List<Object?> get props => [
    appSettings, 
    status, 
    errorMessage, 
    apiKeyTests, 
    availableModels,
    scope,
    projectSettings,
    currentProjectId,
    currentProjectName,
  ];
} 
