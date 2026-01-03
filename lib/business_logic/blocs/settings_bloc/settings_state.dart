part of 'settings_bloc.dart';

enum SettingsStatus { initial, loading, loaded, error }

/// Stores the latest validation state for an API key.
@freezed
class ApiKeyTestResult with _$ApiKeyTestResult {
  const factory ApiKeyTestResult({
    required ApiKeyTestStatus status,
    required String message,
    String? usage,
  }) = _ApiKeyTestResult;

  static const ApiKeyTestResult idle = ApiKeyTestResult(
    status: ApiKeyTestStatus.idle,
    message: '',
    usage: null,
  );
}

@freezed
class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    required AppSettings appSettings,
    @Default(SettingsStatus.initial) SettingsStatus status,
    String? errorMessage,
    required Map<ApiProvider, ApiKeyTestResult> apiKeyTests,
    @Default(<ApiProvider, List<String>>{})
    Map<ApiProvider, List<String>> availableModels,
    @Default(SettingsScope.global) SettingsScope scope,
    ProjectSettings? projectSettings,
    String? currentProjectId,
    String? currentProjectName,
  }) = _SettingsState;

  factory SettingsState.initial() {
    return SettingsState(
      appSettings: AppSettings.defaultSettings(),
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
}
