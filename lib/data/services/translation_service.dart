import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:localizer_app_main/core/services/ai_usage_service.dart';
import 'package:localizer_app_main/core/services/dio_client.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';

abstract class TranslationService {
  /// Translates text to the target language.
  Future<String> translate(String text, String targetLanguage,
      {String? sourceLanguage});

  /// Streams translation chunks in real-time.
  ///
  /// Yields translation text as it becomes available.
  /// For services that don't support streaming, this yields the full result once.
  Stream<String> translateStream(String text, String targetLanguage,
      {String? sourceLanguage});
}

/// Thrown when a translation request is missing a required key.
class MissingApiKeyException implements Exception {
  MissingApiKeyException(this.message);

  final String message;

  @override
  String toString() => message;
}

class GoogleTranslationService implements TranslationService {
  static const String _baseUrl = 'https://translation.googleapis.com';
  final SecureStorageService _secureStorage;
  final DioClient _dioClient;
  final AiUsageService? _usageService;

  GoogleTranslationService({
    required SecureStorageService secureStorage,
    DioClient? dioClient,
    AiUsageService? usageService,
  })  : _secureStorage = secureStorage,
        _dioClient = dioClient ?? DioClient(),
        _usageService = usageService;

  @override
  Future<String> translate(String text, String targetLanguage,
      {String? sourceLanguage}) async {
    final apiKey = await _secureStorage.getGoogleApiKey();

    if (apiKey == null ||
        apiKey.isEmpty ||
        apiKey == "YOUR_GOOGLE_TRANSLATE_API_KEY") {
      throw MissingApiKeyException(
        'Add your key in Settings to turn on translations.',
      );
    }

    final queryParameters = <String, dynamic>{
      'q': text,
      'target': targetLanguage,
      if (sourceLanguage != null) 'source': sourceLanguage,
      'key': apiKey,
      'format': 'text',
    };

    try {
      final response = await _dioClient.get<Map<String, dynamic>>(
        '$_baseUrl/language/translate/v2',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 && response.data != null) {
        final translations = response.data!['data']['translations'] as List;
        if (translations.isNotEmpty) {
          final translatedText = translations.first['translatedText'] as String;

          // Record character usage for cost tracking
          await _usageService?.recordUsage(
            providerName: 'Google Translate',
            characters: text.length,
          );

          return translatedText;
        }
        throw Exception('No translation found in response');
      } else {
        debugPrint('Error from Google Translate API: ${response.statusCode}');
        throw Exception(
            'Failed to translate text. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      debugPrint('Error calling Google Translate API: ${e.message}');
      throw Exception('Failed to translate text: ${e.message}');
    } catch (e) {
      debugPrint('Error calling Google Translate API: $e');
      throw Exception('Failed to translate text: $e');
    }
  }

  @override
  Stream<String> translateStream(String text, String targetLanguage,
      {String? sourceLanguage}) async* {
    // Google Translate API doesn't support streaming, yield full result
    final result =
        await translate(text, targetLanguage, sourceLanguage: sourceLanguage);
    yield result;
  }
}
