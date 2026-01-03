import 'package:localizer_app_main/data/models/ai_suggestion_result.dart';

/// Abstract interface for AI-assisted translation and text manipulation.
///
/// This extends beyond basic translation to support:
/// - Translation suggestions with confidence scores
/// - Text rephrasing for style/clarity improvements
/// - Future: Grammar checking, length adjustment, etc.
///
/// Providers: Gemini, OpenAI (future), DeepL (future)
abstract class AiAssistanceService {
  /// Provider name for display purposes.
  String get providerName;

  /// Translates text and returns a suggestion for user review.
  ///
  /// Unlike [translate], this returns structured data with confidence
  /// and alternatives for the review workflow.
  Future<TranslationSuggestion> suggestTranslation({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
    List<String>? contextStrings,
  });

  /// Rephrases text for improved clarity or style.
  ///
  /// Useful for making translations more natural or adjusting tone.
  Future<RephraseResult> rephrase({
    required String text,
    String? targetLanguage,
    String? style,
    String? sourceText,
  });

  /// Streams translation chunks for real-time preview.
  ///
  /// Yields text chunks as they become available.
  Stream<String> translateStream({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  });
}
