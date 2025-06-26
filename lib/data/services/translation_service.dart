import 'package:http/http.dart' as http;
import 'dart:convert';

// TODO: Implement API key secure storage and retrieval
const String _apiKey = "YOUR_GOOGLE_TRANSLATE_API_KEY"; // Placeholder

abstract class TranslationService {
  Future<String> translate(String text, String targetLanguage, {String? sourceLanguage});
}

class GoogleTranslationService implements TranslationService {
  final String _baseUrl = "translation.googleapis.com";

  @override
  Future<String> translate(String text, String targetLanguage, {String? sourceLanguage}) async {
    if (_apiKey == "YOUR_GOOGLE_TRANSLATE_API_KEY") {
      print("Warning: API key is a placeholder. Real translations will fail.");
      return "Translated: $text (Preview - API Key Needed)";
    }

    final queryParameters = {
      'q': text,
      'target': targetLanguage,
      if (sourceLanguage != null) 'source': sourceLanguage,
      'key': _apiKey,
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
        print('Error from Google Translate API: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to translate text. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error calling Google Translate API: $e');
      throw Exception('Failed to translate text: $e');
    }
  }
}

// TODO: Implement local caching of frequent translations using Hive (lib/data/cache/translation_cache.dart)
// TODO: Implement secure API key storage (e.g., using flutter_secure_storage) 