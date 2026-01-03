import 'package:freezed_annotation/freezed_annotation.dart';

part 'glossary_item.freezed.dart';
part 'glossary_item.g.dart';

/// Represents a glossary term used for translation guidance.
@freezed
class GlossaryItem with _$GlossaryItem {
  /// Creates a glossary term.
  const factory GlossaryItem({
    /// Unique identifier for the term.
    required String id,

    /// The term as it appears in the source language.
    required String term,

    /// Optional definition or usage guidance.
    @Default('') String definition,

    /// Whether the term is case-sensitive.
    @Default(false) bool caseSensitive,

    /// Whether the term should be preserved in translations.
    @Default(true) bool forbidTranslation,

    /// Suggested translation when provided.
    String? preferredTranslation,
  }) = _GlossaryItem;

  /// Builds a glossary item from JSON.
  factory GlossaryItem.fromJson(Map<String, dynamic> json) =>
      _$GlossaryItemFromJson(json);
}
