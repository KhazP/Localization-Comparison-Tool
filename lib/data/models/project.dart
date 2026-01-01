import 'dart:convert';

import 'package:localizer_app_main/data/models/project_settings.dart';
import 'package:localizer_app_main/data/models/glossary_item.dart';
import 'package:localizer_app_main/data/models/translation_memory_reference.dart';

/// Represents a Localizer project.
/// 
/// A project stores its identity and configuration in a `.localizer/` folder
/// within the project directory. This enables per-project settings overrides.
class Project {
  /// Unique identifier (UUID) for this project.
  final String id;
  
  /// User-defined project name displayed throughout the UI.
  final String name;
  
  /// Absolute path to the project's root folder.
  final String rootPath;
  
  /// When this project was first created.
  final DateTime createdAt;
  
  /// When this project was last opened in the app.
  DateTime lastOpenedAt;
  
  /// Project-specific settings overrides.
  /// Settings not overridden here inherit from global defaults.
  final ProjectSettings settings;

  /// Project-specific glossary terms.
  final List<GlossaryItem> glossary;

  /// References to translation memories used by this project.
  final List<TranslationMemoryReference> translationMemories;

  Project({
    required this.id,
    required this.name,
    required this.rootPath,
    required this.createdAt,
    required this.lastOpenedAt,
    this.settings = const ProjectSettings.empty(),
    this.glossary = const [],
    this.translationMemories = const [],
  });

  /// The path to the `.localizer` configuration folder.
  String get configFolderPath => '$rootPath/.localizer';
  
  /// The path to the `project.json` file.
  String get projectFilePath => '$configFolderPath/project.json';

  /// Creates a Project from JSON data stored in project.json.
  factory Project.fromJson(Map<String, dynamic> json, String rootPath) {
    return Project(
      id: json['id'] as String,
      name: json['name'] as String,
      rootPath: rootPath,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastOpenedAt: DateTime.parse(json['lastOpenedAt'] as String),
      settings: ProjectSettings.fromJson(
        json['settings'] as Map<String, dynamic>?,
      ),
      glossary: (json['glossary'] as List<dynamic>?)
              ?.map((e) => GlossaryItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      translationMemories: (json['translationMemories'] as List<dynamic>?)
              ?.map((e) => TranslationMemoryReference.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Converts this Project to JSON for storage in project.json.
  /// 
  /// Note: rootPath is not stored in JSON as it's derived from the file location.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'lastOpenedAt': lastOpenedAt.toIso8601String(),
      'version': 2, // Schema version - v2 adds settings
    };
    
    // Only include settings if there are overrides
    if (settings.hasOverrides) {
      json['settings'] = settings.toJson();
    }

    if (glossary.isNotEmpty) {
      json['glossary'] = glossary.map((e) => e.toJson()).toList();
    }

    if (translationMemories.isNotEmpty) {
      json['translationMemories'] =
          translationMemories.map((e) => e.toJson()).toList();
    }
    
    return json;
  }

  /// Converts this Project to a formatted JSON string.
  String toJsonString() {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(toJson());
  }

  /// Creates a copy of this Project with updated fields.
  Project copyWith({
    String? id,
    String? name,
    String? rootPath,
    DateTime? createdAt,
    DateTime? lastOpenedAt,
    ProjectSettings? settings,
    List<GlossaryItem>? glossary,
    List<TranslationMemoryReference>? translationMemories,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      rootPath: rootPath ?? this.rootPath,
      createdAt: createdAt ?? this.createdAt,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      settings: settings ?? this.settings,
      glossary: glossary ?? this.glossary,
      translationMemories: translationMemories ?? this.translationMemories,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Project && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Project(id: $id, name: $name, rootPath: $rootPath)';
}
