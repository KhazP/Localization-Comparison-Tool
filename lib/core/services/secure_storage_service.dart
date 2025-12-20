import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
        );

  static const _googleApiKey = 'google_translate_api_key';
  static const _deeplApiKey = 'deepl_api_key';
  static const _geminiApiKey = 'gemini_api_key';
  static const _openaiApiKey = 'openai_api_key';

  Future<void> storeGoogleApiKey(String key) async {
    await _storage.write(key: _googleApiKey, value: key);
  }

  Future<String?> getGoogleApiKey() async {
    return await _storage.read(key: _googleApiKey);
  }

  Future<void> storeDeepLApiKey(String key) async {
    await _storage.write(key: _deeplApiKey, value: key);
  }

  Future<String?> getDeepLApiKey() async {
    return await _storage.read(key: _deeplApiKey);
  }

  Future<void> storeGeminiApiKey(String key) async {
    await _storage.write(key: _geminiApiKey, value: key);
  }

  Future<String?> getGeminiApiKey() async {
    return await _storage.read(key: _geminiApiKey);
  }

  Future<void> storeOpenAiApiKey(String key) async {
    await _storage.write(key: _openaiApiKey, value: key);
  }

  Future<String?> getOpenAiApiKey() async {
    return await _storage.read(key: _openaiApiKey);
  }

  Future<void> clearAllKeys() async {
    await _storage.delete(key: _googleApiKey);
    await _storage.delete(key: _deeplApiKey);
    await _storage.delete(key: _geminiApiKey);
    await _storage.delete(key: _openaiApiKey);
  }
}
