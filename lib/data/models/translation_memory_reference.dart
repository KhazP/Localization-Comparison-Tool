import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_memory_reference.freezed.dart';
part 'translation_memory_reference.g.dart';

/// References a translation memory file used by a project.
@freezed
class TranslationMemoryReference with _$TranslationMemoryReference {
  /// Creates a translation memory reference.
  const factory TranslationMemoryReference({
    /// Unique identifier for the translation memory.
    required String id,

    /// Friendly display name.
    required String name,

    /// File path to the translation memory.
    required String path,

    /// File type (for example, "tmx" or "json").
    @Default('tmx') String type,

    /// Whether the translation memory is currently enabled.
    @Default(true) bool isEnabled,
  }) = _TranslationMemoryReference;

  /// Builds a translation memory reference from JSON.
  factory TranslationMemoryReference.fromJson(Map<String, dynamic> json) =>
      _$TranslationMemoryReferenceFromJson(json);
}
