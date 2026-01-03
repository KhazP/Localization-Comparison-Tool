/// Custom exceptions for translation services.
///
/// Provides granular error handling for translation operations.

/// General translation failure exception.
class TranslationException implements Exception {
  TranslationException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() =>
      'TranslationException: $message${cause != null ? ' (caused by: $cause)' : ''}';
}

/// Exception thrown when API rate limit is exceeded.
class RateLimitException extends TranslationException {
  RateLimitException({
    String message = 'API rate limit exceeded. Please try again later.',
    super.cause,
  }) : super(message);

  @override
  String toString() => 'RateLimitException: $message';
}

/// Exception thrown when the translation response is empty or null.
class EmptyResponseException extends TranslationException {
  EmptyResponseException({
    String message =
        'Received empty or null response from translation service.',
    super.cause,
  }) : super(message);

  @override
  String toString() => 'EmptyResponseException: $message';
}
