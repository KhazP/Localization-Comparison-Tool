import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import 'package:localizer_app_main/core/services/dio_client.dart';

/// Supported providers for API key validation.
enum ApiProvider {
  googleTranslate,
  deepl,
  gemini,
  openAi,
}

/// Result of an API key validation attempt.
class ApiKeyValidationResult {
  /// Creates a validation result.
  const ApiKeyValidationResult({
    required this.success,
    required this.message,
    this.usage,
  });

  /// Whether the key was accepted.
  final bool success;

  /// Plain-language status message for the user.
  final String message;

  /// Optional usage or quota text when provided by the service.
  final String? usage;
}

/// Validates API keys against provider endpoints.
class ApiKeyValidationService {
  /// Creates a validator with an optional DioClient.
  ApiKeyValidationService({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  final DioClient _dioClient;

  /// Tests a key with the selected provider.
  Future<ApiKeyValidationResult> testApiKey(
    ApiProvider provider,
    String apiKey,
  ) {
    switch (provider) {
      case ApiProvider.googleTranslate:
        return _testGoogleTranslate(apiKey);
      case ApiProvider.deepl:
        return _testDeepL(apiKey);
      case ApiProvider.gemini:
        return _testGemini(apiKey);
      case ApiProvider.openAi:
        return _testOpenAi(apiKey);
    }
  }

  Future<ApiKeyValidationResult> _testGoogleTranslate(String apiKey) async {
    const baseUrl = 'https://translation.googleapis.com';
    return _getAndEvaluate(
      '$baseUrl/language/translate/v2',
      queryParameters: {
        'q': 'Hello',
        'target': 'en',
        'key': apiKey,
        'format': 'text',
      },
      successMessage: 'Connected.',
    );
  }

  Future<ApiKeyValidationResult> _testDeepL(String apiKey) async {
    final host = apiKey.endsWith(':fx')
        ? 'api-free.deepl.com'
        : 'api.deepl.com';
    final url = 'https://$host/v2/usage';

    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        url,
        headers: {'Authorization': 'DeepL-Auth-Key $apiKey'},
        timeout: const Duration(seconds: 10),
      );

      if (response.statusCode == 200 && response.data != null) {
        final payload = response.data!;
        final used = payload['character_count'] as int? ?? 0;
        final limit = payload['character_limit'] as int? ?? 0;
        final usageText = 'Usage: ${_formatNumber(used)} / '
            '${_formatNumber(limit)} characters.';
        return ApiKeyValidationResult(
          success: true,
          message: 'Connected.',
          usage: usageText,
        );
      }

      return ApiKeyValidationResult(
        success: false,
        message: _messageForStatus(response.statusCode ?? 500),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const ApiKeyValidationResult(
          success: false,
          message: 'Connection timed out. Please try again.',
        );
      }
      return ApiKeyValidationResult(
        success: false,
        message: _messageForStatus(e.response?.statusCode ?? 500),
      );
    } catch (e, stackTrace) {
      developer.log(
        'API key test failed.',
        name: 'api_key_validation',
        error: e,
        stackTrace: stackTrace,
      );
      return const ApiKeyValidationResult(
        success: false,
        message: 'Could not connect. Please try again.',
      );
    }
  }

  Future<ApiKeyValidationResult> _testGemini(String apiKey) async {
    const baseUrl = 'https://generativelanguage.googleapis.com';
    return _getAndEvaluate(
      '$baseUrl/v1beta/models',
      queryParameters: {'key': apiKey},
      successMessage: 'Connected.',
    );
  }

  Future<ApiKeyValidationResult> _testOpenAi(String apiKey) async {
    const url = 'https://api.openai.com/v1/models';
    return _getAndEvaluate(
      url,
      headers: {'Authorization': 'Bearer $apiKey'},
      successMessage: 'Connected.',
    );
  }

  Future<ApiKeyValidationResult> _getAndEvaluate(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required String successMessage,
  }) async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        url,
        queryParameters: queryParameters,
        headers: headers,
        timeout: const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        return ApiKeyValidationResult(
          success: true,
          message: successMessage,
        );
      }

      return ApiKeyValidationResult(
        success: false,
        message: _messageForStatus(response.statusCode ?? 500),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const ApiKeyValidationResult(
          success: false,
          message: 'Connection timed out. Please try again.',
        );
      }
      return ApiKeyValidationResult(
        success: false,
        message: _messageForStatus(e.response?.statusCode ?? 500),
      );
    } catch (e, stackTrace) {
      developer.log(
        'API key test failed.',
        name: 'api_key_validation',
        error: e,
        stackTrace: stackTrace,
      );
      return const ApiKeyValidationResult(
        success: false,
        message: 'Could not connect. Please try again.',
      );
    }
  }

  String _messageForStatus(int statusCode) {
    if (statusCode == 401 || statusCode == 403) {
      return 'Could not connect. Please check the key and try again.';
    }
    if (statusCode == 429) {
      return 'Could not connect right now. Please try again later.';
    }
    if (statusCode >= 500) {
      return 'Service is unavailable right now. Please try again later.';
    }
    return 'Could not connect. Please try again.';
  }

  String _formatNumber(int value) {
    final raw = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < raw.length; i++) {
      final reverseIndex = raw.length - i;
      buffer.write(raw[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write(',');
      }
    }
    return buffer.toString();
  }

  /// Fetches available models for the provider.
  Future<List<String>> fetchAvailableModels(
    ApiProvider provider,
    String apiKey,
  ) async {
    try {
      switch (provider) {
        case ApiProvider.gemini:
          return await _fetchGeminiModels(apiKey);
        case ApiProvider.openAi:
          return await _fetchOpenAiModels(apiKey);
        default:
          return [];
      }
    } catch (e) {
      developer.log('Failed to fetch models: $e', name: 'api_key_validation');
      return [];
    }
  }

  Future<List<String>> _fetchGeminiModels(String apiKey) async {
    const baseUrl = 'https://generativelanguage.googleapis.com';
    final response = await _dioClient.get<Map<String, dynamic>>(
      '$baseUrl/v1beta/models',
      queryParameters: {'key': apiKey},
    );
    if (response.statusCode == 200 && response.data != null) {
      final models = (response.data!['models'] as List<dynamic>?) ?? [];
      return models
          .map((m) => m['name'] as String)
          .where((name) =>
              name.contains('gemini') &&
              !name.contains('vision')) // Filter for text/chat models if needed
          .map((name) => name.replaceFirst('models/', ''))
          .toList();
    }
    return [];
  }

  Future<List<String>> _fetchOpenAiModels(String apiKey) async {
    const url = 'https://api.openai.com/v1/models';
    final response = await _dioClient.get<Map<String, dynamic>>(
      url,
      headers: {'Authorization': 'Bearer $apiKey'},
    );
    if (response.statusCode == 200 && response.data != null) {
      final models = (response.data!['data'] as List<dynamic>?) ?? [];
      return models
          .map((m) => m['id'] as String)
          .where((id) =>
              id.startsWith('gpt-4') ||
              id.startsWith('gpt-3.5')) // Filter for GPT models
          .toList();
    }
    return [];
  }

  /// Closes the underlying HTTP client.
  void dispose() {
    _dioClient.close();
  }
}
