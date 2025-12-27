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

  const SettingsState({
    required this.appSettings,
    this.status = SettingsStatus.initial,
    this.errorMessage,
    required this.apiKeyTests,
    this.availableModels = const {},
  });

  factory SettingsState.initial() {
    return SettingsState(
      appSettings: AppSettings.defaultSettings(),
      apiKeyTests: {
        ApiProvider.googleTranslate: const ApiKeyTestResult.idle(),
        ApiProvider.deepl: const ApiKeyTestResult.idle(),
        ApiProvider.gemini: const ApiKeyTestResult.idle(),
        ApiProvider.openAi: const ApiKeyTestResult.idle(),
        ApiProvider.openAi: const ApiKeyTestResult.idle(),
      },
      availableModels: const {
        ApiProvider.gemini: ['gemini-1.5-flash', 'gemini-1.5-pro', 'gemini-1.0-pro'], // Default fallbacks
        ApiProvider.openAi: ['gpt-4o', 'gpt-4o-mini', 'gpt-4-turbo', 'gpt-3.5-turbo'], // Default fallbacks
      },
    );
  }

  SettingsState copyWith({
    AppSettings? appSettings,
    SettingsStatus? status,
    String? errorMessage,
    Map<ApiProvider, ApiKeyTestResult>? apiKeyTests,
    Map<ApiProvider, List<String>>? availableModels,
  }) {
    return SettingsState(
      appSettings: appSettings ?? this.appSettings,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      apiKeyTests: apiKeyTests ?? this.apiKeyTests,
      availableModels: availableModels ?? this.availableModels,
    );
  }

  @override
  List<Object?> get props => [appSettings, status, errorMessage, apiKeyTests, availableModels];
} 
