import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:localizer_app_main/core/services/dio_client.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';

abstract class TranslationService {
  Future<String> translate(String text, String targetLanguage,
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

  GoogleTranslationService({
    required SecureStorageService secureStorage,
    DioClient? dioClient,
  })  : _secureStorage = secureStorage,
        _dioClient = dioClient ?? DioClient();

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
          return translations.first['translatedText'];
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
}
