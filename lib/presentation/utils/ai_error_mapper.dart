import 'package:localizer_app_main/data/services/translation_exceptions.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';

/// Returns a friendly message for AI-related errors.
String aiUserMessageForError(Object error) {
  if (error is MissingApiKeyException) {
    return 'Add your key in Settings to turn on AI.';
  }
  if (error is RateLimitException) {
    return 'Too many requests right now. Please try again soon.';
  }
  if (error is TranslationException) {
    return 'We could not create a suggestion. Please try again.';
  }
  return 'We could not create a suggestion. Please try again.';
}
