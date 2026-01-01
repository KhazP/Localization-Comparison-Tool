import 'dart:convert';

/// Represents project-specific settings overrides.
/// 
/// This model stores only settings that are explicitly overridden for a project.
/// Settings that are `null` inherit from global defaults.
/// 
/// Per the spec, only these settings can be overridden per-project:
/// - System Context / Instructions (different tone/style per project)
/// - AI Service Provider (different API for different clients)
/// - AI Model (GPT-4 for complex content, lighter model for simple)
class ProjectSettings {
  /// Custom AI instructions/system context for this project.
  /// If null, uses global default.
  final String? systemTranslationContext;
  
  /// Override AI service provider (e.g., 'Google Translate', 'OpenAI').
  /// If null, uses global default.
  final String? aiTranslationService;
  
  /// Override AI model (e.g., 'gpt-4o', 'gemini-1.5-pro').
  /// If null, uses global default.
  final String? defaultAiModel;
  
  // Comparison Overrides
  final double? similarityThreshold;
  final List<String>? ignorePatterns;
  final bool? ignoreCase;
  final bool? ignoreWhitespace;

  // File Handling Overrides
  final String? defaultSourceFormat;
  final String? defaultTargetFormat;
  final String? defaultSourceEncoding;
  final String? defaultTargetEncoding;
  final bool? autoDetectEncoding;

  const ProjectSettings({
    this.systemTranslationContext,
    this.aiTranslationService,
    this.defaultAiModel,
    this.similarityThreshold,
    this.ignorePatterns,
    this.ignoreCase,
    this.ignoreWhitespace,
    this.defaultSourceFormat,
    this.defaultTargetFormat,
    this.defaultSourceEncoding,
    this.defaultTargetEncoding,
    this.autoDetectEncoding,
  });

  /// Creates empty settings with no overrides (all inherited).
  const ProjectSettings.empty()
      : systemTranslationContext = null,
        aiTranslationService = null,
        defaultAiModel = null,
        similarityThreshold = null,
        ignorePatterns = null,
        ignoreCase = null,
        ignoreWhitespace = null,
        defaultSourceFormat = null,
        defaultTargetFormat = null,
        defaultSourceEncoding = null,
        defaultTargetEncoding = null,
        autoDetectEncoding = null;

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
    if (similarityThreshold != null) overrides.add('similarityThreshold');
    if (ignorePatterns != null) overrides.add('ignorePatterns');
    if (ignoreCase != null) overrides.add('ignoreCase');
    if (ignoreWhitespace != null) overrides.add('ignoreWhitespace');
    if (defaultSourceFormat != null) overrides.add('defaultSourceFormat');
    if (defaultTargetFormat != null) overrides.add('defaultTargetFormat');
    if (defaultSourceEncoding != null) overrides.add('defaultSourceEncoding');
    if (defaultTargetEncoding != null) overrides.add('defaultTargetEncoding');
    if (autoDetectEncoding != null) overrides.add('autoDetectEncoding');
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
    if (json == null) return const ProjectSettings.empty();
    
    return ProjectSettings(
      systemTranslationContext: json['systemTranslationContext'] as String?,
      aiTranslationService: json['aiTranslationService'] as String?,
      defaultAiModel: json['defaultAiModel'] as String?,
      similarityThreshold: (json['similarityThreshold'] as num?)?.toDouble(),
      ignorePatterns: (json['ignorePatterns'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
    if (similarityThreshold != null) json['similarityThreshold'] = similarityThreshold;
    if (ignorePatterns != null) json['ignorePatterns'] = ignorePatterns;
    if (ignoreCase != null) json['ignoreCase'] = ignoreCase;
    if (ignoreWhitespace != null) json['ignoreWhitespace'] = ignoreWhitespace;
    if (defaultSourceFormat != null) json['defaultSourceFormat'] = defaultSourceFormat;
    if (defaultTargetFormat != null) json['defaultTargetFormat'] = defaultTargetFormat;
    if (defaultSourceEncoding != null) json['defaultSourceEncoding'] = defaultSourceEncoding;
    if (defaultTargetEncoding != null) json['defaultTargetEncoding'] = defaultTargetEncoding;
    if (autoDetectEncoding != null) json['autoDetectEncoding'] = autoDetectEncoding;
    
    return json;
  }

  /// Converts to formatted JSON string.
  String toJsonString() {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(toJson());
  }

  /// Creates a copy with updated fields.
  /// Pass explicit null to clear an override (revert to global).
  ProjectSettings copyWith({
    String? systemTranslationContext,
    String? aiTranslationService,
    String? defaultAiModel,
    double? similarityThreshold,
    List<String>? ignorePatterns,
    bool? ignoreCase,
    bool? ignoreWhitespace,
    String? defaultSourceFormat,
    String? defaultTargetFormat,
    String? defaultSourceEncoding,
    String? defaultTargetEncoding,
    bool? autoDetectEncoding,
    bool clearSystemTranslationContext = false,
    bool clearAiTranslationService = false,
    bool clearDefaultAiModel = false,
    bool clearSimilarityThreshold = false,
    bool clearIgnorePatterns = false,
    bool clearIgnoreCase = false,
    bool clearIgnoreWhitespace = false,
    bool clearDefaultSourceFormat = false,
    bool clearDefaultTargetFormat = false,
    bool clearDefaultSourceEncoding = false,
    bool clearDefaultTargetEncoding = false,
    bool clearAutoDetectEncoding = false,
  }) {
    return ProjectSettings(
      systemTranslationContext: clearSystemTranslationContext 
          ? null 
          : (systemTranslationContext ?? this.systemTranslationContext),
      aiTranslationService: clearAiTranslationService 
          ? null 
          : (aiTranslationService ?? this.aiTranslationService),
      defaultAiModel: clearDefaultAiModel 
          ? null 
          : (defaultAiModel ?? this.defaultAiModel),
      similarityThreshold: clearSimilarityThreshold ? null : (similarityThreshold ?? this.similarityThreshold),
      ignorePatterns: clearIgnorePatterns ? null : (ignorePatterns ?? this.ignorePatterns),
      ignoreCase: clearIgnoreCase ? null : (ignoreCase ?? this.ignoreCase),
      ignoreWhitespace: clearIgnoreWhitespace ? null : (ignoreWhitespace ?? this.ignoreWhitespace),
      defaultSourceFormat: clearDefaultSourceFormat ? null : (defaultSourceFormat ?? this.defaultSourceFormat),
      defaultTargetFormat: clearDefaultTargetFormat ? null : (defaultTargetFormat ?? this.defaultTargetFormat),
      defaultSourceEncoding: clearDefaultSourceEncoding ? null : (defaultSourceEncoding ?? this.defaultSourceEncoding),
      defaultTargetEncoding: clearDefaultTargetEncoding ? null : (defaultTargetEncoding ?? this.defaultTargetEncoding),
      autoDetectEncoding: clearAutoDetectEncoding ? null : (autoDetectEncoding ?? this.autoDetectEncoding),
    );
  }

  /// Clears a specific setting override (reverts to global).
  ProjectSettings clearOverride(String settingKey) {
    switch (settingKey) {
      case 'systemTranslationContext':
        return copyWith(clearSystemTranslationContext: true);
      case 'aiTranslationService':
        return copyWith(clearAiTranslationService: true);
      case 'defaultAiModel':
        return copyWith(clearDefaultAiModel: true);
      case 'similarityThreshold':
        return copyWith(clearSimilarityThreshold: true);
      case 'ignorePatterns':
        return copyWith(clearIgnorePatterns: true);
      case 'ignoreCase':
        return copyWith(clearIgnoreCase: true);
      case 'ignoreWhitespace':
        return copyWith(clearIgnoreWhitespace: true);
      case 'defaultSourceFormat':
        return copyWith(clearDefaultSourceFormat: true);
      case 'defaultTargetFormat':
        return copyWith(clearDefaultTargetFormat: true);
      case 'defaultSourceEncoding':
        return copyWith(clearDefaultSourceEncoding: true);
      case 'defaultTargetEncoding':
        return copyWith(clearDefaultTargetEncoding: true);
      case 'autoDetectEncoding':
        return copyWith(clearAutoDetectEncoding: true);
      default:
        return this;
    }
  }

  /// Clears all overrides for a specific category.
  /// Currently only 'aiServices' category has overridable settings.
  ProjectSettings clearCategoryOverrides(String category) {
    if (category == 'aiServices') {
      return const ProjectSettings.empty();
    }
    if (category == 'comparison') {
      return copyWith(
        clearSimilarityThreshold: true,
        clearIgnorePatterns: true,
        clearIgnoreCase: true,
        clearIgnoreWhitespace: true,
      );
    }
    if (category == 'fileHandling') {
      return copyWith(
        clearDefaultSourceFormat: true,
        clearDefaultTargetFormat: true,
        clearDefaultSourceEncoding: true,
        clearDefaultTargetEncoding: true,
        clearAutoDetectEncoding: true,
      );
    }
    return this;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProjectSettings &&
        other.systemTranslationContext == systemTranslationContext &&
        other.aiTranslationService == aiTranslationService &&
        other.defaultAiModel == defaultAiModel;
  }

  @override
  int get hashCode => Object.hash(
        systemTranslationContext,
        aiTranslationService,
        defaultAiModel,
        similarityThreshold,
        ignorePatterns,
        ignoreCase,
        ignoreWhitespace,
        defaultSourceFormat,
        defaultTargetFormat,
        defaultSourceEncoding,
        defaultTargetEncoding,
        autoDetectEncoding,
      );

  @override
  String toString() => 'ProjectSettings(overrides: ${overriddenSettings.join(', ')})';
}
