import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'translation_memory_reference.g.dart';

@JsonSerializable()
class TranslationMemoryReference extends Equatable {
  final String id;
  final String name;
  final String path;
  final String type; // 'tmx', 'json', etc.
  final bool isEnabled;

  const TranslationMemoryReference({
    required this.id,
    required this.name,
    required this.path,
    this.type = 'tmx',
    this.isEnabled = true,
  });

  factory TranslationMemoryReference.fromJson(Map<String, dynamic> json) =>
      _$TranslationMemoryReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationMemoryReferenceToJson(this);

  @override
  List<Object?> get props => [id, name, path, type, isEnabled];

  TranslationMemoryReference copyWith({
    String? id,
    String? name,
    String? path,
    String? type,
    bool? isEnabled,
  }) {
    return TranslationMemoryReference(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      type: type ?? this.type,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
