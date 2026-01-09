import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

/// Interceptor that redacts sensitive headers from logs.
/// SECURITY: Prevents API keys from being logged.
class _SensitiveHeaderRedactionInterceptor extends Interceptor {
  static const _sensitiveHeaders = [
    'authorization',
    'x-api-key',
    'api-key',
    'x-goog-api-key',
  ];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Create a copy of headers with redacted sensitive values for logging
    final redactedHeaders = Map<String, dynamic>.from(options.headers);
    for (final header in _sensitiveHeaders) {
      // Check case-insensitive
      final matchingKey = redactedHeaders.keys.firstWhere(
        (k) => k.toLowerCase() == header,
        orElse: () => '',
      );
      if (matchingKey.isNotEmpty) {
        redactedHeaders[matchingKey] = '[REDACTED]';
      }
    }

    // Log the request with redacted headers if in debug mode
    if (kDebugMode) {
      debugPrint('DioClient Request: ${options.method} ${options.uri}');
      debugPrint('Headers (redacted): $redactedHeaders');
    }

    handler.next(options);
  }
}

/// Centralized Dio HTTP client with common configuration.
///
/// Provides consistent timeout handling, default headers, and optional
/// logging across all network requests in the app.
class DioClient {
  /// Creates a DioClient with standard configuration.
  ///
  /// If [talkerService] is provided, HTTP requests will be logged to the
  /// in-app debug console via TalkerDioLogger. If null, no logging occurs.
  DioClient({Dio? dio, TalkerService? talkerService})
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
                sendTimeout: const Duration(seconds: 10),
                headers: {
                  'Accept': 'application/json',
                },
                // SECURITY: Only treat 2xx as success, handle errors explicitly
                validateStatus: (status) =>
                    status != null && status >= 200 && status < 300,
              ),
            ) {
    // SECURITY: Add header redaction interceptor first
    _dio.interceptors.add(_SensitiveHeaderRedactionInterceptor());

    // Add Talker logging interceptor in debug mode only
    if (kDebugMode && talkerService != null) {
      _dio.interceptors.add(
        TalkerDioLogger(
          talker: talkerService.talker,
          settings: const TalkerDioLoggerSettings(
            // SECURITY: Disable header logging to prevent API key exposure
            printRequestHeaders: false,
            printResponseHeaders: false,
            printResponseMessage: true,
            printRequestData: true,
            printResponseData: false, // Can be verbose for large responses
          ),
        ),
      );
    }
  }

  final Dio _dio;

  /// The underlying Dio instance for advanced use cases.
  Dio get dio => _dio;

  /// Performs a GET request.
  ///
  /// [path] can be a full URL or a path relative to [baseUrl].
  /// [queryParameters] are appended to the URL.
  /// [headers] override or extend the default headers.
  /// [cancelToken] can be used to cancel the request.
  /// [onReceiveProgress] reports download progress for large responses.
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    CancelToken? cancelToken,
    void Function(int received, int total)? onReceiveProgress,
    Duration? timeout,
  }) async {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
        receiveTimeout: timeout,
      ),
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Performs a POST request.
  ///
  /// [data] is the request body (JSON maps are auto-encoded).
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) async {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
      cancelToken: cancelToken,
    );
  }

  /// Downloads a file with progress reporting.
  ///
  /// [urlPath] is the URL to download from.
  /// [savePath] is the local file path to save to.
  /// [onReceiveProgress] reports download progress.
  /// [cancelToken] can be used to cancel the download.
  Future<Response> download(
    String urlPath,
    String savePath, {
    void Function(int received, int total)? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    return _dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  /// Closes the client and releases resources.
  void close({bool force = false}) {
    _dio.close(force: force);
  }
}
