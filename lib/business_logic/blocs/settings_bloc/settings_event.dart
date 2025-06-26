part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class UpdateDefaultSourceFormat extends SettingsEvent {
  final String newFormat;
  const UpdateDefaultSourceFormat(this.newFormat);
  @override
  List<Object?> get props => [newFormat];
}

class UpdateDefaultTargetFormat extends SettingsEvent {
  final String newFormat;
  const UpdateDefaultTargetFormat(this.newFormat);
  @override
  List<Object?> get props => [newFormat];
}

class AddIgnorePattern extends SettingsEvent {
  final String pattern;
  const AddIgnorePattern(this.pattern);
  @override
  List<Object?> get props => [pattern];
}

class RemoveIgnorePattern extends SettingsEvent {
  final String pattern;
  const RemoveIgnorePattern(this.pattern);
  @override
  List<Object?> get props => [pattern];
}

class UpdateIgnoreCase extends SettingsEvent {
  final bool ignoreCase;
  const UpdateIgnoreCase(this.ignoreCase);
  @override
  List<Object?> get props => [ignoreCase];
}

class UpdateIgnoreWhitespace extends SettingsEvent {
  final bool ignoreWhitespace;
  const UpdateIgnoreWhitespace(this.ignoreWhitespace);
  @override
  List<Object?> get props => [ignoreWhitespace];
}

class UpdateAppLanguage extends SettingsEvent {
  final String appLanguage;
  const UpdateAppLanguage(this.appLanguage);
  @override
  List<Object?> get props => [appLanguage];
}

class UpdateDefaultViewOnStartup extends SettingsEvent {
  final String defaultView;
  const UpdateDefaultViewOnStartup(this.defaultView);
  @override
  List<Object?> get props => [defaultView];
}

class UpdateAutoCheckForUpdates extends SettingsEvent {
  final bool autoCheck;
  const UpdateAutoCheckForUpdates(this.autoCheck);
  @override
  List<Object?> get props => [autoCheck];
}

class UpdateAppThemeMode extends SettingsEvent {
  final String themeMode;
  const UpdateAppThemeMode(this.themeMode);
  @override
  List<Object?> get props => [themeMode];
}

class UpdateAccentColor extends SettingsEvent {
  final int colorValue;
  const UpdateAccentColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffAddedColor extends SettingsEvent {
  final int colorValue;
  const UpdateDiffAddedColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffRemovedColor extends SettingsEvent {
  final int colorValue;
  const UpdateDiffRemovedColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffModifiedColor extends SettingsEvent {
  final int colorValue;
  const UpdateDiffModifiedColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDefaultSourceEncoding extends SettingsEvent {
  final String encoding;
  const UpdateDefaultSourceEncoding(this.encoding);
  @override
  List<Object> get props => [encoding];
}

class UpdateDefaultTargetEncoding extends SettingsEvent {
  final String encoding;
  const UpdateDefaultTargetEncoding(this.encoding);
  @override
  List<Object> get props => [encoding];
}

class UpdateAutoDetectEncoding extends SettingsEvent {
  final bool autoDetect;
  const UpdateAutoDetectEncoding(this.autoDetect);
  @override
  List<Object> get props => [autoDetect];
}

class UpdateCsvDelimiter extends SettingsEvent {
  final String delimiter;
  const UpdateCsvDelimiter(this.delimiter);
  @override
  List<Object> get props => [delimiter];
}

class UpdateHandleByteOrderMark extends SettingsEvent {
  final bool handle;
  const UpdateHandleByteOrderMark(this.handle);
  @override
  List<Object> get props => [handle];
}

class UpdateAutoReloadOnChange extends SettingsEvent {
  final bool enabled;
  const UpdateAutoReloadOnChange(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateDefaultExportDirectory extends SettingsEvent {
  final String directory;
  const UpdateDefaultExportDirectory(this.directory);
  @override
  List<Object> get props => [directory];
}

class ResetFileHandlingSettings extends SettingsEvent {}

class ResetGeneralSettings extends SettingsEvent {}

class ResetComparisonSettings extends SettingsEvent {}

class ResetAppearanceSettings extends SettingsEvent {}

class ResetAllSettings extends SettingsEvent {} 