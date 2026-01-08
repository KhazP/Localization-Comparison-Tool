// TODO: Implement with Hive for local persistence
import 'dart:collection';
import 'package:flutter/foundation.dart';

abstract class TranslationCache {
  Future<String?> getCachedTranslation(
      String sourceText, String sourceLang, String targetLang);
  Future<void> cacheTranslation(String sourceText, String sourceLang,
      String targetLang, String translatedText);
  Future<void> clearCache();
}

/// In-memory translation cache with LRU eviction.
///
/// Caches translation results to avoid redundant API calls.
/// Uses LRU (Least Recently Used) eviction when cache is full.
class LocalTranslationCache implements TranslationCache {
  // LinkedHashMap maintains insertion order for efficient LRU
  final LinkedHashMap<String, String> _cache = LinkedHashMap();

  /// Maximum number of cached translations (prevents unbounded memory growth)
  static const int _maxCacheSize = 5000;

  @override
  Future<String?> getCachedTranslation(
      String sourceText, String sourceLang, String targetLang) async {
    final key = '$sourceLang:$targetLang:$sourceText';
    final cached = _cache[key];
    if (cached != null) {
      // Move to end (most recently used) for LRU
      _cache.remove(key);
      _cache[key] = cached;
      debugPrint(
          'Translation cache hit for: ${key.substring(0, key.length.clamp(0, 50))}...');
    }
    return cached;
  }

  @override
  Future<void> cacheTranslation(String sourceText, String sourceLang,
      String targetLang, String translatedText) async {
    final key = '$sourceLang:$targetLang:$sourceText';

    // Remove if exists to update position
    _cache.remove(key);

    // Evict LRU entries if full
    while (_cache.length >= _maxCacheSize) {
      final oldestKey = _cache.keys.first;
      _cache.remove(oldestKey);
    }

    _cache[key] = translatedText;
    debugPrint('Translation cached (${_cache.length}/$_maxCacheSize entries)');
  }

  @override
  Future<void> clearCache() async {
    _cache.clear();
    debugPrint('Translation cache cleared');
  }

  /// Returns cache statistics for debugging
  Map<String, dynamic> get stats => {
        'size': _cache.length,
        'maxSize': _maxCacheSize,
      };
}
