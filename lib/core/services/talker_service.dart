import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Centralized logging service using Talker.
///
/// Provides a global [Talker] instance for logging throughout the app.
/// In debug mode, logs appear in both the console and the in-app
/// TalkerScreen overlay. In release mode, logging is minimal.
class TalkerService {
  /// Creates a TalkerService with an optional custom Talker instance
  /// (useful for testing).
  TalkerService({Talker? talker})
      : _talker = talker ??
            TalkerFlutter.init(
              settings: TalkerSettings(
                enabled: kDebugMode,
                useConsoleLogs: kDebugMode,
                maxHistoryItems: 1000,
              ),
              logger: TalkerLogger(
                settings: TalkerLoggerSettings(
                  enableColors: true,
                ),
              ),
            );

  final Talker _talker;

  /// The underlying Talker instance for advanced use cases
  /// (e.g., passing to TalkerDioLogger or TalkerScreen).
  Talker get talker => _talker;

  /// Log an info message.
  void info(String message, [Object? exception, StackTrace? stackTrace]) {
    _talker.info(message, exception, stackTrace);
  }

  /// Log a debug message.
  void debug(String message, [Object? exception, StackTrace? stackTrace]) {
    _talker.debug(message, exception, stackTrace);
  }

  /// Log a warning message.
  void warning(String message, [Object? exception, StackTrace? stackTrace]) {
    _talker.warning(message, exception, stackTrace);
  }

  /// Log an error message.
  void error(String message, [Object? exception, StackTrace? stackTrace]) {
    _talker.error(message, exception, stackTrace);
  }

  /// Log a critical error message.
  void critical(String message, [Object? exception, StackTrace? stackTrace]) {
    _talker.critical(message, exception, stackTrace);
  }

  /// Handle an exception with automatic logging.
  void handle(Object exception, [StackTrace? stackTrace, String? message]) {
    _talker.handle(exception, stackTrace, message);
  }

  /// Log a custom message with a specific log level.
  void log(String message, {LogLevel logLevel = LogLevel.info}) {
    _talker.log(message, logLevel: logLevel);
  }
}
