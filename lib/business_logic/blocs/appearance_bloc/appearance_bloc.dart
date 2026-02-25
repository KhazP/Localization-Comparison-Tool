import 'package:bloc/bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';

import 'appearance_event.dart';
import 'appearance_state.dart';

export 'appearance_event.dart';
export 'appearance_state.dart';

class AppearanceBloc extends Bloc<AppearanceEvent, AppearanceState> {
  final SettingsRepository _settingsRepository;

  AppearanceBloc({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(AppearanceState.initial()) {
    on<LoadAppearanceSettings>(_onLoadAppearanceSettings);
    on<UpdateAppThemeMode>(_onUpdateAppThemeMode);
    on<UpdateAccentColor>(_onUpdateAccentColor);
    on<UpdateDiffAddedColor>(_onUpdateDiffAddedColor);
    on<UpdateDiffRemovedColor>(_onUpdateDiffRemovedColor);
    on<UpdateDiffModifiedColor>(_onUpdateDiffModifiedColor);
    on<UpdateDiffIdenticalColor>(_onUpdateDiffIdenticalColor);
    on<UpdateDiffColors>(_onUpdateDiffColors);
    on<UpdateDiffFontSize>(_onUpdateDiffFontSize);
    on<UpdateDiffFontFamily>(_onUpdateDiffFontFamily);
    on<UpdateAdvancedDiffEditMode>(_onUpdateAdvancedDiffEditMode);
    on<ResetDiffColors>(_onResetDiffColors);
    on<ResetAppearanceSettings>(_onResetAppearanceSettings);
    on<ApplyThemePreset>(_onApplyThemePreset);
    on<UpdateUseMicaEffect>(_onUpdateUseMicaEffect);
    on<UpdateShowIdenticalEntries>(_onUpdateShowIdenticalEntries);
  }

  Future<void> _updateAppSettings(
    Emitter<AppearanceState> emit,
    AppSettings Function(AppSettings) updater,
  ) async {
    final settings = await _settingsRepository.loadSettings();
    final newSettings = updater(settings);
    await _settingsRepository.saveSettings(newSettings);
  }

  Future<void> _onLoadAppearanceSettings(
    LoadAppearanceSettings event,
    Emitter<AppearanceState> emit,
  ) async {
    emit(state.copyWith(status: AppearanceStatus.loading));
    try {
      final settings = await _settingsRepository.loadSettings();
      emit(AppearanceState.fromAppSettings(settings));
    } catch (e) {
      emit(state.copyWith(
        status: AppearanceStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateAppThemeMode(
    UpdateAppThemeMode event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
        emit, (s) => s.copyWith(appThemeMode: event.themeMode));
    emit(state.copyWith(appThemeMode: event.themeMode));
  }

  Future<void> _onUpdateAccentColor(
    UpdateAccentColor event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
        emit, (s) => s.copyWith(accentColorValue: event.colorValue));
    emit(state.copyWith(accentColorValue: event.colorValue));
  }

  Future<void> _onUpdateDiffAddedColor(
    UpdateDiffAddedColor event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
        emit, (s) => s.copyWith(diffAddedColor: event.colorValue));
    emit(state.copyWith(diffAddedColor: event.colorValue));
  }

  Future<void> _onUpdateDiffRemovedColor(
    UpdateDiffRemovedColor event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
        emit, (s) => s.copyWith(diffRemovedColor: event.colorValue));
    emit(state.copyWith(diffRemovedColor: event.colorValue));
  }

  Future<void> _onUpdateDiffModifiedColor(
    UpdateDiffModifiedColor event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
        emit, (s) => s.copyWith(diffModifiedColor: event.colorValue));
    emit(state.copyWith(diffModifiedColor: event.colorValue));
  }

  Future<void> _onUpdateDiffIdenticalColor(
    UpdateDiffIdenticalColor event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
        emit, (s) => s.copyWith(diffIdenticalColor: event.colorValue));
    emit(state.copyWith(diffIdenticalColor: event.colorValue));
  }

  Future<void> _onUpdateDiffColors(
    UpdateDiffColors event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
      emit,
      (s) => s.copyWith(
        diffAddedColor: event.addedColor ?? s.diffAddedColor,
        diffRemovedColor: event.removedColor ?? s.diffRemovedColor,
        diffModifiedColor: event.modifiedColor ?? s.diffModifiedColor,
      ),
    );
    emit(state.copyWith(
      diffAddedColor: event.addedColor ?? state.diffAddedColor,
      diffRemovedColor: event.removedColor ?? state.diffRemovedColor,
      diffModifiedColor: event.modifiedColor ?? state.diffModifiedColor,
    ));
  }

  Future<void> _onUpdateDiffFontSize(
    UpdateDiffFontSize event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
        emit, (s) => s.copyWith(diffFontSize: event.fontSize));
    emit(state.copyWith(diffFontSize: event.fontSize));
  }

  Future<void> _onUpdateDiffFontFamily(
    UpdateDiffFontFamily event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
        emit, (s) => s.copyWith(diffFontFamily: event.fontFamily));
    emit(state.copyWith(diffFontFamily: event.fontFamily));
  }

  Future<void> _onUpdateAdvancedDiffEditMode(
    UpdateAdvancedDiffEditMode event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
        emit,
        (s) =>
            s.copyWith(advancedDiffUseInlineEditing: event.useInlineEditing));
    emit(state.copyWith(advancedDiffUseInlineEditing: event.useInlineEditing));
  }

  Future<void> _onResetDiffColors(
    ResetDiffColors event,
    Emitter<AppearanceState> emit,
  ) async {
    final defaults = AppSettings.defaultSettings();
    await _updateAppSettings(
      emit,
      (s) => s.copyWith(
        diffAddedColor: defaults.diffAddedColor,
        diffRemovedColor: defaults.diffRemovedColor,
        diffModifiedColor: defaults.diffModifiedColor,
        diffIdenticalColor: defaults.diffIdenticalColor,
      ),
    );
    emit(state.copyWith(
      diffAddedColor: defaults.diffAddedColor,
      diffRemovedColor: defaults.diffRemovedColor,
      diffModifiedColor: defaults.diffModifiedColor,
      diffIdenticalColor: defaults.diffIdenticalColor,
    ));
  }

  Future<void> _onResetAppearanceSettings(
    ResetAppearanceSettings event,
    Emitter<AppearanceState> emit,
  ) async {
    final defaults = AppSettings.defaultSettings();
    await _updateAppSettings(
      emit,
      (s) => s.copyWith(
        appThemeMode: defaults.appThemeMode,
        accentColorValue: defaults.accentColorValue,
        diffAddedColor: defaults.diffAddedColor,
        diffRemovedColor: defaults.diffRemovedColor,
        diffModifiedColor: defaults.diffModifiedColor,
        diffIdenticalColor: defaults.diffIdenticalColor,
        diffFontSize: defaults.diffFontSize,
        diffFontFamily: defaults.diffFontFamily,
      ),
    );
    emit(AppearanceState.fromAppSettings(defaults).copyWith(
      status: AppearanceStatus.loaded,
    ));
  }

  Future<void> _onApplyThemePreset(
    ApplyThemePreset event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
      emit,
      (s) => s.copyWith(
        diffAddedColor: event.added,
        diffRemovedColor: event.removed,
        diffModifiedColor: event.modified,
      ),
    );
    emit(state.copyWith(
      diffAddedColor: event.added,
      diffRemovedColor: event.removed,
      diffModifiedColor: event.modified,
    ));
  }

  Future<void> _onUpdateUseMicaEffect(
    UpdateUseMicaEffect event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
        emit, (s) => s.copyWith(useMicaEffect: event.enabled));
    emit(state.copyWith(useMicaEffect: event.enabled));
  }

  Future<void> _onUpdateShowIdenticalEntries(
    UpdateShowIdenticalEntries event,
    Emitter<AppearanceState> emit,
  ) async {
    await _updateAppSettings(
        emit, (s) => s.copyWith(showIdenticalEntries: event.show));
    emit(state.copyWith(showIdenticalEntries: event.show));
  }
}
