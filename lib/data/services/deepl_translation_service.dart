import 'package:localizer_app_main/core/services/ai_usage_service.dart';
import 'package:localizer_app_main/core/services/dio_client.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';

/// Translation service for DeepL.
class DeepLTranslationService implements TranslationService {
  DeepLTranslationService({
    required SecureStorageService secureStorage,
    required DioClient dioClient,
    required TalkerService talkerService,
    AiUsageService? usageService,
  })  : _secureStorage = secureStorage,
        _dioClient = dioClient,
        _talker = talkerService,
        _usageService = usageService;

  final SecureStorageService _secureStorage;
  final DioClient _dioClient;
  final TalkerService _talker;
  final AiUsageService? _usageService;

  /// Translates text using DeepL.
  @override
  Future<String> translate(
    String text,
    String targetLanguage, {
    String? sourceLanguage,
  }) async {
    if (text.trim().isEmpty) {
      return text;
    }

    final apiKey = await _secureStorage.getDeepLApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw MissingApiKeyException(
        'Add your DeepL API key in Settings to turn on translations.',
      );
    }

    final host =
        apiKey.endsWith(':fx') ? 'api-free.deepl.com' : 'api.deepl.com';
    final url = 'https://$host/v2/translate';

    final payload = <String, dynamic>{
      'text': text,
      'target_lang': _normalizeLanguage(targetLanguage),
      if (sourceLanguage != null && sourceLanguage.trim().isNotEmpty)
        'source_lang': _normalizeLanguage(sourceLanguage),
    };

    try {
      final response = await _dioClient.post<Map<String, dynamic>>(
        url,
        data: payload,
        headers: {'Authorization': 'DeepL-Auth-Key $apiKey'},
      );

      if (response.statusCode == 200 && response.data != null) {
        final translations = response.data!['translations'] as List<dynamic>?;
        if (translations != null && translations.isNotEmpty) {
          final first = translations.first as Map<String, dynamic>;
          final translatedText = first['text'] as String?;
          if (translatedText != null) {
            // Record character usage for cost tracking
            await _usageService?.recordUsage(
              providerName: 'DeepL',
              characters: text.length,
            );

            return translatedText;
          }
        }
        throw Exception('No translation found in response');
      }

      throw Exception(
          'Failed to translate text. Status code: ${response.statusCode}');
    } catch (e, stackTrace) {
      _talker.handle(
        e,
        stackTrace,
        'DeepL translation failed',
      );
      throw Exception('Failed to translate text.');
    }
  }

  /// Streams DeepL translation results.
  @override
  Stream<String> translateStream(
    String text,
    String targetLanguage, {
    String? sourceLanguage,
  }) async* {
    final result = await translate(
      text,
      targetLanguage,
      sourceLanguage: sourceLanguage,
    );
    yield result;
  }

  String _normalizeLanguage(String languageCode) {
    final cleaned = languageCode.replaceAll('_', '-');
    final parts = cleaned.split('-');
    if (parts.length == 2) {
      return '${parts[0].toUpperCase()}-${parts[1].toUpperCase()}';
    }
    return cleaned.toUpperCase();
  }
}
