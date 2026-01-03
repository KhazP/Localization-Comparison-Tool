import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_settings.freezed.dart';

/// Represents project-specific settings overrides.
///
/// This model stores only settings that are explicitly overridden for a
/// project. Settings that are `null` inherit from global defaults.
///
/// Per the spec, only these settings can be overridden per-project:
/// - System Context / Instructions (different tone/style per project)
/// - AI Service Provider (different API for different clients)
/// - AI Model (model choice per project)
@Freezed(toStringOverride: false)
class ProjectSettings with _$ProjectSettings {
  const ProjectSettings._();

  /// Creates project-specific settings overrides.
  const factory ProjectSettings({
    /// Custom AI instructions/system context for this project.
    /// If null, uses global default.
    String? systemTranslationContext,

    /// Override AI service provider (for example, "Google Translate").
    /// If null, uses global default.
    String? aiTranslationService,

    /// Override AI model (for example, "gpt-4o").
    /// If null, uses global default.
    String? defaultAiModel,

    /// Similarity threshold override for comparisons.
    double? similarityThreshold,

    /// Patterns to ignore while comparing files.
    List<String>? ignorePatterns,

    /// Whether comparisons should ignore casing.
    bool? ignoreCase,

    /// Whether comparisons should ignore whitespace.
    bool? ignoreWhitespace,

    /// Default source format override.
    String? defaultSourceFormat,

    /// Default target format override.
    String? defaultTargetFormat,

    /// Default source encoding override.
    String? defaultSourceEncoding,

    /// Default target encoding override.
    String? defaultTargetEncoding,

    /// Whether encoding auto-detection is enabled.
    bool? autoDetectEncoding,
  }) = _ProjectSettings;

  /// Returns the set of setting keys that are overridden.
  Set<String> get overriddenSettings {
    final overrides = <String>{};
    if (systemTranslationContext != null) {
      overrides.add('systemTranslationContext');
    }
    if (aiTranslationService != null) {
      overrides.add('aiTranslationService');
    }
    if (defaultAiModel != null) {
      overrides.add('defaultAiModel');
    }
    if (similarityThreshold != null) {
      overrides.add('similarityThreshold');
    }
    if (ignorePatterns != null) {
      overrides.add('ignorePatterns');
    }
    if (ignoreCase != null) {
      overrides.add('ignoreCase');
    }
    if (ignoreWhitespace != null) {
      overrides.add('ignoreWhitespace');
    }
    if (defaultSourceFormat != null) {
      overrides.add('defaultSourceFormat');
    }
    if (defaultTargetFormat != null) {
      overrides.add('defaultTargetFormat');
    }
    if (defaultSourceEncoding != null) {
      overrides.add('defaultSourceEncoding');
    }
    if (defaultTargetEncoding != null) {
      overrides.add('defaultTargetEncoding');
    }
    if (autoDetectEncoding != null) {
      overrides.add('autoDetectEncoding');
    }
    return overrides;
  }

  /// Whether any settings are overridden.
  bool get hasOverrides => overriddenSettings.isNotEmpty;

  /// Check if a specific setting is overridden.
  bool isOverridden(String settingKey) {
    switch (settingKey) {
      case 'systemTranslationContext':
        return systemTranslationContext != null;
      case 'aiTranslationService':
        return aiTranslationService != null;
      case 'defaultAiModel':
        return defaultAiModel != null;
      case 'similarityThreshold':
        return similarityThreshold != null;
      case 'ignorePatterns':
        return ignorePatterns != null;
      case 'ignoreCase':
        return ignoreCase != null;
      case 'ignoreWhitespace':
        return ignoreWhitespace != null;
      case 'defaultSourceFormat':
        return defaultSourceFormat != null;
      case 'defaultTargetFormat':
        return defaultTargetFormat != null;
      case 'defaultSourceEncoding':
        return defaultSourceEncoding != null;
      case 'defaultTargetEncoding':
        return defaultTargetEncoding != null;
      case 'autoDetectEncoding':
        return autoDetectEncoding != null;
      default:
        return false;
    }
  }

  /// Creates ProjectSettings from JSON stored in project.json.
  factory ProjectSettings.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const ProjectSettings();

    return ProjectSettings(
      systemTranslationContext: json['systemTranslationContext'] as String?,
      aiTranslationService: json['aiTranslationService'] as String?,
      defaultAiModel: json['defaultAiModel'] as String?,
      similarityThreshold: (json['similarityThreshold'] as num?)?.toDouble(),
      ignorePatterns: (json['ignorePatterns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ignoreCase: json['ignoreCase'] as bool?,
      ignoreWhitespace: json['ignoreWhitespace'] as bool?,
      defaultSourceFormat: json['defaultSourceFormat'] as String?,
      defaultTargetFormat: json['defaultTargetFormat'] as String?,
      defaultSourceEncoding: json['defaultSourceEncoding'] as String?,
      defaultTargetEncoding: json['defaultTargetEncoding'] as String?,
      autoDetectEncoding: json['autoDetectEncoding'] as bool?,
    );
  }

  /// Converts to JSON for storage in project.json.
  /// Only includes non-null (overridden) values to keep the file clean.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (systemTranslationContext != null) {
      json['systemTranslationContext'] = systemTranslationContext;
    }
    if (aiTranslationService != null) {
      json['aiTranslationService'] = aiTranslationService;
    }
    if (defaultAiModel != null) {
      json['defaultAiModel'] = defaultAiModel;
    }
    if (similarityThreshold != null) {
      json['similarityThreshold'] = similarityThreshold;
    }
    if (ignorePatterns != null) {
      json['ignorePatterns'] = ignorePatterns;
    }
    if (ignoreCase != null) {
      json['ignoreCase'] = ignoreCase;
    }
    if (ignoreWhitespace != null) {
      json['ignoreWhitespace'] = ignoreWhitespace;
    }
    if (defaultSourceFormat != null) {
      json['defaultSourceFormat'] = defaultSourceFormat;
    }
    if (defaultTargetFormat != null) {
      json['defaultTargetFormat'] = defaultTargetFormat;
    }
    if (defaultSourceEncoding != null) {
      json['defaultSourceEncoding'] = defaultSourceEncoding;
    }
    if (defaultTargetEncoding != null) {
      json['defaultTargetEncoding'] = defaultTargetEncoding;
    }
    if (autoDetectEncoding != null) {
      json['autoDetectEncoding'] = autoDetectEncoding;
    }

    return json;
  }

  /// Converts to formatted JSON string.
  String toJsonString() {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(toJson());
  }

  /// Clears a specific setting override (reverts to global).
  ProjectSettings clearOverride(String settingKey) {
    switch (settingKey) {
      case 'systemTranslationContext':
        return copyWith(systemTranslationContext: null);
      case 'aiTranslationService':
        return copyWith(aiTranslationService: null);
      case 'defaultAiModel':
        return copyWith(defaultAiModel: null);
      case 'similarityThreshold':
        return copyWith(similarityThreshold: null);
      case 'ignorePatterns':
        return copyWith(ignorePatterns: null);
      case 'ignoreCase':
        return copyWith(ignoreCase: null);
      case 'ignoreWhitespace':
        return copyWith(ignoreWhitespace: null);
      case 'defaultSourceFormat':
        return copyWith(defaultSourceFormat: null);
      case 'defaultTargetFormat':
        return copyWith(defaultTargetFormat: null);
      case 'defaultSourceEncoding':
        return copyWith(defaultSourceEncoding: null);
      case 'defaultTargetEncoding':
        return copyWith(defaultTargetEncoding: null);
      case 'autoDetectEncoding':
        return copyWith(autoDetectEncoding: null);
      default:
        return this;
    }
  }

  /// Clears all overrides for a specific category.
  /// Currently only 'aiServices' category has overridable settings.
  ProjectSettings clearCategoryOverrides(String category) {
    if (category == 'aiServices') {
      return const ProjectSettings();
    }
    if (category == 'comparison') {
      return copyWith(
        similarityThreshold: null,
        ignorePatterns: null,
        ignoreCase: null,
        ignoreWhitespace: null,
      );
    }
    if (category == 'fileHandling') {
      return copyWith(
        defaultSourceFormat: null,
        defaultTargetFormat: null,
        defaultSourceEncoding: null,
        defaultTargetEncoding: null,
        autoDetectEncoding: null,
      );
    }
    return this;
  }

  @override
  String toString() {
    return 'ProjectSettings(overrides: '
        '${overriddenSettings.join(', ')})';
  }
}
