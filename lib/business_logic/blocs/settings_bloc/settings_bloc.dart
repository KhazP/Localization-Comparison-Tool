import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;

  SettingsBloc({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(SettingsState.initial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateDefaultSourceFormat>(_onUpdateDefaultSourceFormat);
    on<UpdateDefaultTargetFormat>(_onUpdateDefaultTargetFormat);
    on<AddIgnorePattern>(_onAddIgnorePattern);
    on<RemoveIgnorePattern>(_onRemoveIgnorePattern);
    on<UpdateIgnoreCase>(_onUpdateIgnoreCase);
    on<UpdateIgnoreWhitespace>(_onUpdateIgnoreWhitespace);
    on<UpdateAppLanguage>(_onUpdateAppLanguage);
    on<UpdateDefaultViewOnStartup>(_onUpdateDefaultViewOnStartup);
    on<UpdateAutoCheckForUpdates>(_onUpdateAutoCheckForUpdates);
    on<UpdateAppThemeMode>(_onUpdateAppThemeMode);
    on<UpdateAccentColor>(_onUpdateAccentColor);
    on<UpdateDiffAddedColor>(_onUpdateDiffAddedColor);
    on<UpdateDiffRemovedColor>(_onUpdateDiffRemovedColor);
    on<UpdateDiffModifiedColor>(_onUpdateDiffModifiedColor);
    on<UpdateDefaultSourceEncoding>(_onUpdateDefaultSourceEncoding);
    on<UpdateDefaultTargetEncoding>(_onUpdateDefaultTargetEncoding);
    on<UpdateAutoDetectEncoding>(_onUpdateAutoDetectEncoding);
    on<UpdateCsvDelimiter>(_onUpdateCsvDelimiter);
    on<UpdateHandleByteOrderMark>(_onUpdateHandleByteOrderMark);
    on<UpdateAutoReloadOnChange>(_onUpdateAutoReloadOnChange);
    on<UpdateDefaultExportDirectory>(_onUpdateDefaultExportDirectory);
    on<ResetFileHandlingSettings>(_onResetFileHandlingSettings);
    on<ResetGeneralSettings>(_onResetGeneralSettings);
    on<ResetComparisonSettings>(_onResetComparisonSettings);
    on<ResetAppearanceSettings>(_onResetAppearanceSettings);
    on<ResetAllSettings>(_onResetAllSettings);
  }

  Future<void> _onLoadSettings(
      LoadSettings event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: SettingsStatus.loading));
    try {
      final settings = await _settingsRepository.loadSettings();
      emit(state.copyWith(appSettings: settings, status: SettingsStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
          status: SettingsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateDefaultSourceFormat(
      UpdateDefaultSourceFormat event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(defaultSourceFormat: event.newFormat);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultTargetFormat(
      UpdateDefaultTargetFormat event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(defaultTargetFormat: event.newFormat);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onAddIgnorePattern(
      AddIgnorePattern event, Emitter<SettingsState> emit) async {
    final updatedPatterns = List<String>.from(state.appSettings.ignorePatterns)..add(event.pattern);
    final newSettings = state.appSettings.copyWith(ignorePatterns: updatedPatterns);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onRemoveIgnorePattern(
      RemoveIgnorePattern event, Emitter<SettingsState> emit) async {
    final updatedPatterns = List<String>.from(state.appSettings.ignorePatterns)..remove(event.pattern);
    final newSettings = state.appSettings.copyWith(ignorePatterns: updatedPatterns);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateIgnoreCase(
      UpdateIgnoreCase event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(ignoreCase: event.ignoreCase);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateIgnoreWhitespace(
      UpdateIgnoreWhitespace event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(ignoreWhitespace: event.ignoreWhitespace);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAppLanguage(
      UpdateAppLanguage event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(appLanguage: event.appLanguage);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultViewOnStartup(
      UpdateDefaultViewOnStartup event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(defaultViewOnStartup: event.defaultView);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAutoCheckForUpdates(
      UpdateAutoCheckForUpdates event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(autoCheckForUpdates: event.autoCheck);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAppThemeMode(
      UpdateAppThemeMode event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(appThemeMode: event.themeMode);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAccentColor(
      UpdateAccentColor event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(accentColorValue: event.colorValue);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffAddedColor(
      UpdateDiffAddedColor event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(diffAddedColor: event.colorValue);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffRemovedColor(
      UpdateDiffRemovedColor event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(diffRemovedColor: event.colorValue);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffModifiedColor(
      UpdateDiffModifiedColor event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(diffModifiedColor: event.colorValue);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultSourceEncoding(
      UpdateDefaultSourceEncoding event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultSourceEncoding: event.encoding);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultTargetEncoding(
      UpdateDefaultTargetEncoding event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultTargetEncoding: event.encoding);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAutoDetectEncoding(
      UpdateAutoDetectEncoding event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(autoDetectEncoding: event.autoDetect);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateCsvDelimiter(
      UpdateCsvDelimiter event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(csvDelimiter: event.delimiter);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateHandleByteOrderMark(
      UpdateHandleByteOrderMark event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(handleByteOrderMark: event.handle);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAutoReloadOnChange(
      UpdateAutoReloadOnChange event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(autoReloadOnChange: event.enabled);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultExportDirectory(
      UpdateDefaultExportDirectory event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultExportDirectory: event.directory);
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onResetFileHandlingSettings(
      ResetFileHandlingSettings event, Emitter<SettingsState> emit) async {
    final defaultSettings = AppSettings.defaultSettings();
    final newSettings = state.appSettings.copyWith(
      defaultSourceEncoding: defaultSettings.defaultSourceEncoding,
      defaultTargetEncoding: defaultSettings.defaultTargetEncoding,
      autoDetectEncoding: defaultSettings.autoDetectEncoding,
      csvDelimiter: defaultSettings.csvDelimiter,
      handleByteOrderMark: defaultSettings.handleByteOrderMark,
      autoReloadOnChange: defaultSettings.autoReloadOnChange,
      defaultExportDirectory: defaultSettings.defaultExportDirectory,
    );
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onResetGeneralSettings(
      ResetGeneralSettings event, Emitter<SettingsState> emit) async {
    final defaultSettings = AppSettings.defaultSettings();
    final newSettings = state.appSettings.copyWith(
      appLanguage: defaultSettings.appLanguage,
      defaultViewOnStartup: defaultSettings.defaultViewOnStartup,
      autoCheckForUpdates: defaultSettings.autoCheckForUpdates,
    );
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onResetComparisonSettings(
      ResetComparisonSettings event, Emitter<SettingsState> emit) async {
    final defaultSettings = AppSettings.defaultSettings();
    final newSettings = state.appSettings.copyWith(
      ignoreCase: defaultSettings.ignoreCase,
      ignoreWhitespace: defaultSettings.ignoreWhitespace,
      ignorePatterns: List<String>.from(defaultSettings.ignorePatterns),
    );
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onResetAppearanceSettings(
      ResetAppearanceSettings event, Emitter<SettingsState> emit) async {
    final defaultSettings = AppSettings.defaultSettings();
    final newSettings = state.appSettings.copyWith(
      appThemeMode: defaultSettings.appThemeMode,
      accentColorValue: defaultSettings.accentColorValue,
      diffAddedColor: defaultSettings.diffAddedColor,
      diffRemovedColor: defaultSettings.diffRemovedColor,
      diffModifiedColor: defaultSettings.diffModifiedColor,
    );
    await _settingsRepository.saveSettings(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onResetAllSettings(
      ResetAllSettings event, Emitter<SettingsState> emit) async {
    final defaultSettings = AppSettings.defaultSettings();
    await _settingsRepository.saveSettings(defaultSettings);
    emit(state.copyWith(appSettings: defaultSettings));
  }
}

// Extension to add copyWith to AppSettings if not already present (or ensure it is)
// This is a common pattern but AppSettings is a HiveObject, so it should handle its own persistence.
// However, for updating state within the BLoC before saving, a copyWith is useful.
// Let's assume AppSettings will get its own copyWith or we manage it carefully.
// For now, the BLoC manually reconstructs where needed or relies on HiveObject's nature.
// Actually, it's better to add copyWith to AppSettings itself for cleaner BLoC logic. 