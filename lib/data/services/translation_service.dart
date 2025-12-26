import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:localizer_app_main/core/services/secure_storage_service.dart';

abstract class TranslationService {
  Future<String> translate(String text, String targetLanguage, {String? sourceLanguage});
}

class GoogleTranslationService implements TranslationService {
  final String _baseUrl = "translation.googleapis.com";
  final SecureStorageService _secureStorage;

  GoogleTranslationService({required SecureStorageService secureStorage})
      : _secureStorage = secureStorage;

  @override
  Future<String> translate(String text, String targetLanguage, {String? sourceLanguage}) async {
    final apiKey = await _secureStorage.getGoogleApiKey();

    if (apiKey == null || apiKey.isEmpty || apiKey == "YOUR_GOOGLE_TRANSLATE_API_KEY") {
      debugPrint("Warning: API key is missing or invalid. Real translations will fail.");
      return "Translated: $text (Preview - API Key Needed)";
    }

    final queryParameters = {
      'q': text,
      'target': targetLanguage,
      if (sourceLanguage != null) 'source': sourceLanguage,
      'key': apiKey,
      'format': 'text',
    };

    final uri = Uri.https(_baseUrl, '/language/translate/v2', queryParameters);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final translations = body['data']['translations'] as List;
        if (translations.isNotEmpty) {
          return translations.first['translatedText'];
        }
        throw Exception('No translation found in response');
      } else {
        debugPrint('Error from Google Translate API: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        throw Exception('Failed to translate text. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error calling Google Translate API: $e');
      throw Exception('Failed to translate text: $e');
    }
  }
}
 