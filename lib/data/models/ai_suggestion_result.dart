/// Result types for AI-assisted translation operations.
///
/// These models support the review workflow where users can accept/reject
/// AI suggestions before they are applied.

/// Represents a translation suggestion from an AI service.
class TranslationSuggestion {
  const TranslationSuggestion({
    required this.originalText,
    required this.translatedText,
    this.confidence,
    this.alternatives,
    this.providerName,
  });

  /// The original text that was translated.
  final String originalText;

  /// The suggested translation.
  final String translatedText;

  /// Optional confidence score (0.0 to 1.0).
  final double? confidence;

  /// Optional alternative translations.
  final List<String>? alternatives;

  /// Name of the provider that generated this suggestion.
  final String? providerName;

  @override
  String toString() =>
      'TranslationSuggestion(original: "$originalText", translated: "$translatedText", confidence: $confidence)';
}

/// Represents a rephrase result from an AI service.
class RephraseResult {
  const RephraseResult({
    required this.originalText,
    required this.rephrasedText,
    this.alternatives,
    this.providerName,
  });

  /// The original text that was rephrased.
  final String originalText;

  /// The rephrased text.
  final String rephrasedText;

  /// Optional alternative phrasings.
  final List<String>? alternatives;

  /// Name of the provider that generated this result.
  final String? providerName;

  @override
  String toString() =>
      'RephraseResult(original: "$originalText", rephrased: "$rephrasedText")';
}
