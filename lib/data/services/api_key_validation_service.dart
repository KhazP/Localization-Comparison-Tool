import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;

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
  /// Creates a validator with an optional HTTP client.
  ApiKeyValidationService({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

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
    final uri = Uri.https(
      'translation.googleapis.com',
      '/language/translate/v2',
      {
        'q': 'Hello',
        'target': 'en',
        'key': apiKey,
        'format': 'text',
      },
    );

    return _getAndEvaluate(
      uri,
      const {},
      successMessage: 'Connected.',
    );
  }

  Future<ApiKeyValidationResult> _testDeepL(String apiKey) async {
    final host = apiKey.endsWith(':fx')
        ? 'api-free.deepl.com'
        : 'api.deepl.com';
    final uri = Uri.https(host, '/v2/usage');

    final response = await _getWithTimeout(
      uri,
      {'Authorization': 'DeepL-Auth-Key $apiKey'},
    );
    if (response == null) {
      return const ApiKeyValidationResult(
        success: false,
        message: 'Connection timed out. Please try again.',
      );
    }

    if (response.statusCode == 200) {
      final payload = json.decode(response.body) as Map<String, dynamic>;
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
      message: _messageForStatus(response.statusCode),
    );
  }

  Future<ApiKeyValidationResult> _testGemini(String apiKey) async {
    final uri = Uri.https(
      'generativelanguage.googleapis.com',
      '/v1beta/models',
      {'key': apiKey},
    );

    return _getAndEvaluate(
      uri,
      const {},
      successMessage: 'Connected.',
    );
  }

  Future<ApiKeyValidationResult> _testOpenAi(String apiKey) async {
    final uri = Uri.https('api.openai.com', '/v1/models');

    return _getAndEvaluate(
      uri,
      {'Authorization': 'Bearer $apiKey'},
      successMessage: 'Connected.',
    );
  }

  Future<ApiKeyValidationResult> _getAndEvaluate(
    Uri uri,
    Map<String, String> headers, {
    required String successMessage,
  }) async {
    final response = await _getWithTimeout(uri, headers);
    if (response == null) {
      return const ApiKeyValidationResult(
        success: false,
        message: 'Connection timed out. Please try again.',
      );
    }

    if (response.statusCode == 200) {
      return ApiKeyValidationResult(
        success: true,
        message: successMessage,
      );
    }

    return ApiKeyValidationResult(
      success: false,
      message: _messageForStatus(response.statusCode),
    );
  }

  Future<http.Response?> _getWithTimeout(
    Uri uri,
    Map<String, String> headers,
  ) async {
    try {
      return await _client
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 10));
    } catch (e, stackTrace) {
      developer.log(
        'API key test failed.',
        name: 'api_key_validation',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
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
    final uri = Uri.https(
      'generativelanguage.googleapis.com',
      '/v1beta/models',
      {'key': apiKey},
    );
    final response = await _client.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final models = (data['models'] as List<dynamic>?) ?? [];
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
    final uri = Uri.https('api.openai.com', '/v1/models');
    final response = await _client.get(
      uri,
      headers: {'Authorization': 'Bearer $apiKey'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final models = (data['data'] as List<dynamic>?) ?? [];
      return models
          .map((m) => m['id'] as String)
          .where((id) =>
              id.startsWith('gpt-4') ||
              id.startsWith('gpt-3.5')) // Filter for GPT models
          .toList();
    }
    return [];
  }
}

