import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';

/// Error types for categorization and localization.
enum FriendlyErrorType {
  fileNotFound,
  accessDenied,
  isDirectory,
  fileAccess,
  unsupportedFormat,
  networkError,
  notGitRepo,
  mergeConflict,
  gitAuthFailed,
  gitOperationFailed,
  invalidJson,
  rateLimitReached,
  invalidApiKey,
  translationServiceError,
  outOfMemory,
  genericError,
}

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
        return const FriendlyError(
          type: FriendlyErrorType.fileNotFound,
        );
      }
      if (errorString.contains('access denied') ||
          errorString.contains('permission denied')) {
        return const FriendlyError(
          type: FriendlyErrorType.accessDenied,
        );
      }
      if (errorString.contains('is a directory')) {
        return const FriendlyError(
          type: FriendlyErrorType.isDirectory,
        );
      }
      return const FriendlyError(
        type: FriendlyErrorType.fileAccess,
      );
    }

    // Unsupported format errors
    if (error is UnsupportedError ||
        errorString.contains('unsupportederror') ||
        errorString.contains('not supported') ||
        errorString.contains('unsupported file type')) {
      return const FriendlyError(
        type: FriendlyErrorType.unsupportedFormat,
      );
    }

    // Network errors
    if (errorString.contains('socket') ||
        errorString.contains('network') ||
        errorString.contains('connection')) {
      return const FriendlyError(
        type: FriendlyErrorType.networkError,
      );
    }

    // Git errors
    if (errorString.contains('git')) {
      if (errorString.contains('not a git repository')) {
        return const FriendlyError(
          type: FriendlyErrorType.notGitRepo,
        );
      }
      if (errorString.contains('merge conflict') ||
          errorString.contains('conflict')) {
        return const FriendlyError(
          type: FriendlyErrorType.mergeConflict,
        );
      }
      if (errorString.contains('authentication') ||
          errorString.contains('credentials')) {
        return const FriendlyError(
          type: FriendlyErrorType.gitAuthFailed,
        );
      }
      return const FriendlyError(
        type: FriendlyErrorType.gitOperationFailed,
      );
    }

    // JSON parsing errors
    if (errorString.contains('json') ||
        errorString.contains('formatexception')) {
      return const FriendlyError(
        type: FriendlyErrorType.invalidJson,
      );
    }

    // Translation/API errors
    if (errorString.contains('api') || errorString.contains('translation')) {
      if (errorString.contains('rate limit') || errorString.contains('quota')) {
        return const FriendlyError(
          type: FriendlyErrorType.rateLimitReached,
        );
      }
      if (errorString.contains('invalid key') ||
          errorString.contains('unauthorized')) {
        return const FriendlyError(
          type: FriendlyErrorType.invalidApiKey,
        );
      }
      return const FriendlyError(
        type: FriendlyErrorType.translationServiceError,
      );
    }

    // Out of memory
    if (errorString.contains('out of memory') ||
        errorString.contains('memory')) {
      return const FriendlyError(
        type: FriendlyErrorType.outOfMemory,
      );
    }

    // Generic fallback
    return const FriendlyError(
      type: FriendlyErrorType.genericError,
    );
  }
}

/// Data class holding a friendly error type for localization.
class FriendlyError {
  final FriendlyErrorType type;

  const FriendlyError({
    required this.type,
  });

  /// Get localized message using BuildContext.
  String getLocalizedMessage(BuildContext context) {
    final t = context.t.friendlyErrors;
    switch (type) {
      case FriendlyErrorType.fileNotFound:
        return t.fileNotFound.message;
      case FriendlyErrorType.accessDenied:
        return t.accessDenied.message;
      case FriendlyErrorType.isDirectory:
        return t.isDirectory.message;
      case FriendlyErrorType.fileAccess:
        return t.fileAccess.message;
      case FriendlyErrorType.unsupportedFormat:
        return t.unsupportedFormat.message;
      case FriendlyErrorType.networkError:
        return t.networkError.message;
      case FriendlyErrorType.notGitRepo:
        return t.notGitRepo.message;
      case FriendlyErrorType.mergeConflict:
        return t.mergeConflict.message;
      case FriendlyErrorType.gitAuthFailed:
        return t.gitAuthFailed.message;
      case FriendlyErrorType.gitOperationFailed:
        return t.gitOperationFailed.message;
      case FriendlyErrorType.invalidJson:
        return t.invalidJson.message;
      case FriendlyErrorType.rateLimitReached:
        return t.rateLimitReached.message;
      case FriendlyErrorType.invalidApiKey:
        return t.invalidApiKey.message;
      case FriendlyErrorType.translationServiceError:
        return t.translationServiceError.message;
      case FriendlyErrorType.outOfMemory:
        return t.outOfMemory.message;
      case FriendlyErrorType.genericError:
        return t.genericError.message;
    }
  }

  /// Get localized suggestion using BuildContext.
  String? getLocalizedSuggestion(BuildContext context) {
    final t = context.t.friendlyErrors;
    switch (type) {
      case FriendlyErrorType.fileNotFound:
        return t.fileNotFound.suggestion;
      case FriendlyErrorType.accessDenied:
        return t.accessDenied.suggestion;
      case FriendlyErrorType.isDirectory:
        return t.isDirectory.suggestion;
      case FriendlyErrorType.fileAccess:
        return t.fileAccess.suggestion;
      case FriendlyErrorType.unsupportedFormat:
        return t.unsupportedFormat.suggestion;
      case FriendlyErrorType.networkError:
        return t.networkError.suggestion;
      case FriendlyErrorType.notGitRepo:
        return t.notGitRepo.suggestion;
      case FriendlyErrorType.mergeConflict:
        return t.mergeConflict.suggestion;
      case FriendlyErrorType.gitAuthFailed:
        return t.gitAuthFailed.suggestion;
      case FriendlyErrorType.gitOperationFailed:
        return t.gitOperationFailed.suggestion;
      case FriendlyErrorType.invalidJson:
        return t.invalidJson.suggestion;
      case FriendlyErrorType.rateLimitReached:
        return t.rateLimitReached.suggestion;
      case FriendlyErrorType.invalidApiKey:
        return t.invalidApiKey.suggestion;
      case FriendlyErrorType.translationServiceError:
        return t.translationServiceError.suggestion;
      case FriendlyErrorType.outOfMemory:
        return t.outOfMemory.suggestion;
      case FriendlyErrorType.genericError:
        return t.genericError.suggestion;
    }
  }

  /// Get full localized error (message + suggestion) using BuildContext.
  String toLocalizedString(BuildContext context) {
    final message = getLocalizedMessage(context);
    final suggestion = getLocalizedSuggestion(context);
    return suggestion != null ? '$message $suggestion' : message;
  }

  /// Fallback English message for logging/debugging (no context needed).
  String get fallbackMessage {
    switch (type) {
      case FriendlyErrorType.fileNotFound:
        return 'The file or folder could not be found.';
      case FriendlyErrorType.accessDenied:
        return 'Access to the file was denied.';
      case FriendlyErrorType.isDirectory:
        return 'A folder was selected instead of a file.';
      case FriendlyErrorType.fileAccess:
        return 'There was a problem accessing the file.';
      case FriendlyErrorType.unsupportedFormat:
        return 'This file format or operation is not supported.';
      case FriendlyErrorType.networkError:
        return 'Could not connect to the server.';
      case FriendlyErrorType.notGitRepo:
        return 'This folder is not a Git project.';
      case FriendlyErrorType.mergeConflict:
        return 'There are merge conflicts in the repository.';
      case FriendlyErrorType.gitAuthFailed:
        return 'Git authentication failed.';
      case FriendlyErrorType.gitOperationFailed:
        return 'A Git operation failed.';
      case FriendlyErrorType.invalidJson:
        return 'The file format is invalid or corrupted.';
      case FriendlyErrorType.rateLimitReached:
        return 'Translation limit reached.';
      case FriendlyErrorType.invalidApiKey:
        return 'Invalid API key.';
      case FriendlyErrorType.translationServiceError:
        return 'Translation service error.';
      case FriendlyErrorType.outOfMemory:
        return 'Not enough memory to complete this operation.';
      case FriendlyErrorType.genericError:
        return 'Something went wrong.';
    }
  }

  @override
  String toString() => fallbackMessage;
}
