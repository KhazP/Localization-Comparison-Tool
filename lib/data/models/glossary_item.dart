import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'glossary_item.g.dart';

@JsonSerializable()
class GlossaryItem extends Equatable {
  final String id;
  final String term;
  final String definition;
  final bool caseSensitive;
  final bool forbidTranslation;
  final String? preferredTranslation;

  const GlossaryItem({
    required this.id,
    required this.term,
    this.definition = '',
    this.caseSensitive = false,
    this.forbidTranslation = true,
    this.preferredTranslation,
  });

  factory GlossaryItem.fromJson(Map<String, dynamic> json) =>
      _$GlossaryItemFromJson(json);

  Map<String, dynamic> toJson() => _$GlossaryItemToJson(this);

  @override
  List<Object?> get props => [
        id,
        term,
        definition,
        caseSensitive,
        forbidTranslation,
        preferredTranslation
      ];

  GlossaryItem copyWith({
    String? id,
    String? term,
    String? definition,
    bool? caseSensitive,
    bool? forbidTranslation,
    String? preferredTranslation,
  }) {
    return GlossaryItem(
      id: id ?? this.id,
      term: term ?? this.term,
      definition: definition ?? this.definition,
      caseSensitive: caseSensitive ?? this.caseSensitive,
      forbidTranslation: forbidTranslation ?? this.forbidTranslation,
      preferredTranslation: preferredTranslation ?? this.preferredTranslation,
    );
  }
}
