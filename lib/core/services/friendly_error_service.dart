import 'dart:io';

/// A helper class to map technical exceptions to user-friendly messages.
class FriendlyErrorService {
  FriendlyErrorService._();

  /// Returns a user-friendly error message for a given exception.
  static FriendlyError getFriendlyMessage(dynamic error) {
    final errorString = error.toString().toLowerCase();

    // File system errors
    if (error is FileSystemException ||
        errorString.contains('filesystemexception')) {
      if (errorString.contains('no such file') ||
          errorString.contains('cannot find')) {
        return FriendlyError(
          message: 'The file or folder could not be found.',
          suggestion: 'Check if the file was moved or deleted.',
        );
      }
      if (errorString.contains('access denied') ||
          errorString.contains('permission denied')) {
        return FriendlyError(
          message: 'Access to the file was denied.',
          suggestion:
              'Try running the app as administrator or check file permissions.',
        );
      }
      if (errorString.contains('is a directory')) {
        return FriendlyError(
          message: 'A folder was selected instead of a file.',
          suggestion: 'Please select a valid file.',
        );
      }
      return FriendlyError(
        message: 'There was a problem accessing the file.',
        suggestion: 'Try closing other programs that might be using it.',
      );
    }

    // Unsupported format errors
    if (error is UnsupportedError ||
        errorString.contains('unsupportederror') ||
        errorString.contains('not supported') ||
        errorString.contains('unsupported file type')) {
      return FriendlyError(
        message: 'This file format or operation is not supported.',
        suggestion: 'Check the file extension or try a different format.',
      );
    }

    // Network errors
    if (errorString.contains('socket') ||
        errorString.contains('network') ||
        errorString.contains('connection')) {
      return FriendlyError(
        message: 'Could not connect to the server.',
        suggestion: 'Check your internet connection and try again.',
      );
    }

    // Git errors
    if (errorString.contains('git')) {
      if (errorString.contains('not a git repository')) {
        return FriendlyError(
          message: 'This folder is not a Git project.',
          suggestion: 'Navigate to a folder that contains a .git directory.',
        );
      }
      if (errorString.contains('merge conflict') ||
          errorString.contains('conflict')) {
        return FriendlyError(
          message: 'There are merge conflicts in the repository.',
          suggestion: 'Resolve the conflicts before continuing.',
        );
      }
      if (errorString.contains('authentication') ||
          errorString.contains('credentials')) {
        return FriendlyError(
          message: 'Git authentication failed.',
          suggestion: 'Check your credentials in Settings > Version Control.',
        );
      }
      return FriendlyError(
        message: 'A Git operation failed.',
        suggestion: 'Check the Git view for more details.',
      );
    }

    // JSON parsing errors
    if (errorString.contains('json') ||
        errorString.contains('formatexception')) {
      return FriendlyError(
        message: 'The file format is invalid or corrupted.',
        suggestion: 'Ensure the file contains valid JSON content.',
      );
    }

    // Translation/API errors
    if (errorString.contains('api') || errorString.contains('translation')) {
      if (errorString.contains('rate limit') || errorString.contains('quota')) {
        return FriendlyError(
          message: 'Translation limit reached.',
          suggestion: 'Wait a few minutes or check your API plan limits.',
        );
      }
      if (errorString.contains('invalid key') ||
          errorString.contains('unauthorized')) {
        return FriendlyError(
          message: 'Invalid API key.',
          suggestion: 'Go to Settings > AI Translation to update your API key.',
        );
      }
      return FriendlyError(
        message: 'Translation service error.',
        suggestion: 'Check your API key and internet connection.',
      );
    }

    // Out of memory
    if (errorString.contains('out of memory') ||
        errorString.contains('memory')) {
      return FriendlyError(
        message: 'Not enough memory to complete this operation.',
        suggestion: 'Try closing other applications or using smaller files.',
      );
    }

    // Generic fallback
    return FriendlyError(
      message: 'Something went wrong.',
      suggestion: 'Please try again. If the problem persists, restart the app.',
    );
  }
}

/// Data class holding a friendly error message and optional recovery suggestion.
class FriendlyError {
  final String message;
  final String? suggestion;

  const FriendlyError({
    required this.message,
    this.suggestion,
  });

  @override
  String toString() => suggestion != null ? '$message $suggestion' : message;
}
