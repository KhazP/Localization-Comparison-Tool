import 'package:equatable/equatable.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';

enum AppearanceStatus { initial, loading, loaded, error }

class AppearanceState extends Equatable {
  final String appThemeMode;
  final int accentColorValue;
  final int diffAddedColor;
  final int diffRemovedColor;
  final int diffModifiedColor;
  final int diffIdenticalColor;
  final double diffFontSize;
  final String diffFontFamily;
  final bool advancedDiffUseInlineEditing;
  final bool useMicaEffect;
  final bool showIdenticalEntries;
  final AppearanceStatus status;
  final String? errorMessage;

  const AppearanceState({
    required this.appThemeMode,
    required this.accentColorValue,
    required this.diffAddedColor,
    required this.diffRemovedColor,
    required this.diffModifiedColor,
    required this.diffIdenticalColor,
    required this.diffFontSize,
    required this.diffFontFamily,
    required this.advancedDiffUseInlineEditing,
    required this.useMicaEffect,
    required this.showIdenticalEntries,
    this.status = AppearanceStatus.initial,
    this.errorMessage,
  });

  factory AppearanceState.initial() {
    final defaults = AppSettings.defaultSettings();
    return AppearanceState(
      appThemeMode: defaults.appThemeMode,
      accentColorValue: defaults.accentColorValue,
      diffAddedColor: defaults.diffAddedColor,
      diffRemovedColor: defaults.diffRemovedColor,
      diffModifiedColor: defaults.diffModifiedColor,
      diffIdenticalColor: defaults.diffIdenticalColor,
      diffFontSize: defaults.diffFontSize,
      diffFontFamily: defaults.diffFontFamily,
      advancedDiffUseInlineEditing: defaults.advancedDiffUseInlineEditing,
      useMicaEffect: defaults.useMicaEffect,
      showIdenticalEntries: defaults.showIdenticalEntries,
    );
  }

  factory AppearanceState.fromAppSettings(AppSettings settings) {
    return AppearanceState(
      appThemeMode: settings.appThemeMode,
      accentColorValue: settings.accentColorValue,
      diffAddedColor: settings.diffAddedColor,
      diffRemovedColor: settings.diffRemovedColor,
      diffModifiedColor: settings.diffModifiedColor,
      diffIdenticalColor: settings.diffIdenticalColor,
      diffFontSize: settings.diffFontSize,
      diffFontFamily: settings.diffFontFamily,
      advancedDiffUseInlineEditing: settings.advancedDiffUseInlineEditing,
      useMicaEffect: settings.useMicaEffect,
      showIdenticalEntries: settings.showIdenticalEntries,
      status: AppearanceStatus.loaded,
    );
  }

  AppearanceState copyWith({
    String? appThemeMode,
    int? accentColorValue,
    int? diffAddedColor,
    int? diffRemovedColor,
    int? diffModifiedColor,
    int? diffIdenticalColor,
    double? diffFontSize,
    String? diffFontFamily,
    bool? advancedDiffUseInlineEditing,
    bool? useMicaEffect,
    bool? showIdenticalEntries,
    AppearanceStatus? status,
    String? errorMessage,
  }) {
    return AppearanceState(
      appThemeMode: appThemeMode ?? this.appThemeMode,
      accentColorValue: accentColorValue ?? this.accentColorValue,
      diffAddedColor: diffAddedColor ?? this.diffAddedColor,
      diffRemovedColor: diffRemovedColor ?? this.diffRemovedColor,
      diffModifiedColor: diffModifiedColor ?? this.diffModifiedColor,
      diffIdenticalColor: diffIdenticalColor ?? this.diffIdenticalColor,
      diffFontSize: diffFontSize ?? this.diffFontSize,
      diffFontFamily: diffFontFamily ?? this.diffFontFamily,
      advancedDiffUseInlineEditing:
          advancedDiffUseInlineEditing ?? this.advancedDiffUseInlineEditing,
      useMicaEffect: useMicaEffect ?? this.useMicaEffect,
      showIdenticalEntries: showIdenticalEntries ?? this.showIdenticalEntries,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        appThemeMode,
        accentColorValue,
        diffAddedColor,
        diffRemovedColor,
        diffModifiedColor,
        diffIdenticalColor,
        diffFontSize,
        diffFontFamily,
        advancedDiffUseInlineEditing,
        useMicaEffect,
        showIdenticalEntries,
        status,
        errorMessage,
      ];
}
