import 'package:equatable/equatable.dart';

abstract class AppearanceEvent extends Equatable {
  const AppearanceEvent();

  @override
  List<Object?> get props => [];
}

class LoadAppearanceSettings extends AppearanceEvent {}

class UpdateAppThemeMode extends AppearanceEvent {
  final String themeMode;
  const UpdateAppThemeMode(this.themeMode);
  @override
  List<Object?> get props => [themeMode];
}

class UpdateAccentColor extends AppearanceEvent {
  final int colorValue;
  const UpdateAccentColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffAddedColor extends AppearanceEvent {
  final int colorValue;
  const UpdateDiffAddedColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffRemovedColor extends AppearanceEvent {
  final int colorValue;
  const UpdateDiffRemovedColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffModifiedColor extends AppearanceEvent {
  final int colorValue;
  const UpdateDiffModifiedColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffIdenticalColor extends AppearanceEvent {
  final int colorValue;
  const UpdateDiffIdenticalColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffColors extends AppearanceEvent {
  final int? addedColor;
  final int? removedColor;
  final int? modifiedColor;
  const UpdateDiffColors(
      {this.addedColor, this.removedColor, this.modifiedColor});
  @override
  List<Object?> get props => [addedColor, removedColor, modifiedColor];
}

class UpdateDiffFontSize extends AppearanceEvent {
  final double fontSize;
  const UpdateDiffFontSize(this.fontSize);
  @override
  List<Object> get props => [fontSize];
}

class UpdateDiffFontFamily extends AppearanceEvent {
  final String fontFamily;
  const UpdateDiffFontFamily(this.fontFamily);
  @override
  List<Object> get props => [fontFamily];
}

class UpdateAdvancedDiffEditMode extends AppearanceEvent {
  final bool useInlineEditing;
  const UpdateAdvancedDiffEditMode(this.useInlineEditing);
  @override
  List<Object> get props => [useInlineEditing];
}

class ResetDiffColors extends AppearanceEvent {}

class ResetAppearanceSettings extends AppearanceEvent {}

class ApplyThemePreset extends AppearanceEvent {
  final int added;
  final int removed;
  final int modified;
  const ApplyThemePreset({
    required this.added,
    required this.removed,
    required this.modified,
  });
  @override
  List<Object?> get props => [added, removed, modified];
}

class UpdateUseMicaEffect extends AppearanceEvent {
  final bool enabled;
  const UpdateUseMicaEffect(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateShowIdenticalEntries extends AppearanceEvent {
  final bool show;
  const UpdateShowIdenticalEntries(this.show);
  @override
  List<Object> get props => [show];
}
