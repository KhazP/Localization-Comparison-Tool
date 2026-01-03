import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';

part 'theme_bloc.freezed.dart';

// --- State ---
@freezed
class AppThemeState with _$AppThemeState {
  const AppThemeState._();

  const factory AppThemeState({
    required ThemeMode themeMode,
    required Color accentColor,
    required Color diffAddedColor,
    required Color diffRemovedColor,
    required Color diffModifiedColor,
  }) = _AppThemeState;

  factory AppThemeState.initial(AppSettings initialSettings) {
    return AppThemeState(
      themeMode: _themeModeFromString(initialSettings.appThemeMode),
      accentColor: Color(initialSettings.accentColorValue),
      diffAddedColor: Color(initialSettings.diffAddedColor),
      diffRemovedColor: Color(initialSettings.diffRemovedColor),
      diffModifiedColor: Color(initialSettings.diffModifiedColor),
    );
  }
}

// Helper to convert string to ThemeMode
ThemeMode _themeModeFromString(String themeModeString) {
  switch (themeModeString.toLowerCase()) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    case 'amoled': // Amoled will be handled as dark by ThemeMode, custom theming will apply specifics
      return ThemeMode.dark;
    case 'system':
    default:
      return ThemeMode.system;
  }
}

// --- Events ---
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object> get props => [];
}

// Event to update theme based on AppSettings
class UpdateThemeSettings extends ThemeEvent {
  final AppSettings appSettings;
  const UpdateThemeSettings(this.appSettings);
  @override
  List<Object> get props => [appSettings];
}

// This event is removed as theme changes will now be driven by settings updates.
// class ThemeToggleRequested extends ThemeEvent {}

// --- BLoC ---
class ThemeBloc extends Bloc<ThemeEvent, AppThemeState> {
  ThemeBloc({required AppSettings initialSettings})
      : super(AppThemeState.initial(initialSettings)) {
    on<UpdateThemeSettings>(_onUpdateThemeSettings);
  }

  void _onUpdateThemeSettings(
      UpdateThemeSettings event, Emitter<AppThemeState> emit) {
    emit(state.copyWith(
      themeMode: _themeModeFromString(event.appSettings.appThemeMode),
      accentColor: Color(event.appSettings.accentColorValue),
      diffAddedColor: Color(event.appSettings.diffAddedColor),
      diffRemovedColor: Color(event.appSettings.diffRemovedColor),
      diffModifiedColor: Color(event.appSettings.diffModifiedColor),
    ));
  }
}
