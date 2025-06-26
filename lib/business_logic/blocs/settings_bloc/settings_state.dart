part of 'settings_bloc.dart';

enum SettingsStatus { initial, loading, loaded, error }

class SettingsState extends Equatable {
  final AppSettings appSettings;
  final SettingsStatus status;
  final String? errorMessage;

  const SettingsState({
    required this.appSettings,
    this.status = SettingsStatus.initial,
    this.errorMessage,
  });

  factory SettingsState.initial() {
    return SettingsState(appSettings: AppSettings.defaultSettings());
  }

  SettingsState copyWith({
    AppSettings? appSettings,
    SettingsStatus? status,
    String? errorMessage,
  }) {
    return SettingsState(
      appSettings: appSettings ?? this.appSettings,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [appSettings, status, errorMessage];
} 