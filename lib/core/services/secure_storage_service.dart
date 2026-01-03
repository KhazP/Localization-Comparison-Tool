import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(
                encryptedSharedPreferences: true,
              ),
            );

  static const _googleApiKey = 'google_translate_api_key';
  static const _deeplApiKey = 'deepl_api_key';
  static const _geminiApiKey = 'gemini_api_key';
  static const _openaiApiKey = 'openai_api_key';
  static const _lastProjectPath = 'last_project_path';
  static const _recentProjectsKey = 'recent_projects_list';

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

  Future<void> storeLastProject(String path) async {
    await _storage.write(key: _lastProjectPath, value: path);
  }

  Future<String?> getLastProject() async {
    return await _storage.read(key: _lastProjectPath);
  }

  Future<void> clearLastProject() async {
    await _storage.delete(key: _lastProjectPath);
  }

  Future<void> storeRecentProjectPaths(List<String> paths) async {
    final jsonString = jsonEncode(paths);
    await _storage.write(key: _recentProjectsKey, value: jsonString);
  }

  Future<List<String>> getRecentProjectPaths() async {
    final jsonString = await _storage.read(key: _recentProjectsKey);
    if (jsonString == null) {
      return [];
    }
    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.cast<String>();
    } catch (e) {
      return [];
    }
  }

  Future<void> clearAllKeys() async {
    await _storage.delete(key: _googleApiKey);
    await _storage.delete(key: _deeplApiKey);
    await _storage.delete(key: _geminiApiKey);
    await _storage.delete(key: _openaiApiKey);
  }
}
