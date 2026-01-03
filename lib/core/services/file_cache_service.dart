import 'dart:io';

class _CachedFile {
  final Map<String, String> data;
  final DateTime modifiedTime;

  _CachedFile(this.data, this.modifiedTime);
}

class FileCacheService {
  static final FileCacheService _instance = FileCacheService._internal();
  factory FileCacheService() => _instance;
  FileCacheService._internal();

  final Map<String, _CachedFile> _cache = {};
  static const int _maxCacheSize = 10;

  Future<Map<String, String>?> getCached(File file, {String? keySuffix}) async {
    final key = file.path + (keySuffix ?? '');
    final cached = _cache[key];
    if (cached == null) return null;

    try {
      if (!await file.exists()) {
        _cache.remove(key);
        return null;
      }

      final stat = await file.stat();
      // Truncate to seconds for safety
      if (stat.modified.difference(cached.modifiedTime).abs().inSeconds < 2) {
        return cached.data;
      }
    } catch (e) {
      // If error (e.g. file access), just invalidate cache
    }

    _cache.remove(key);
    return null;
  }

  void cache(File file, Map<String, String> data, DateTime modifiedTime,
      {String? keySuffix}) {
    // Evict oldest if full
    if (_cache.length >= _maxCacheSize) {
      _cache.remove(_cache.keys.first);
    }
    final key = file.path + (keySuffix ?? '');
    _cache[key] = _CachedFile(data, modifiedTime);
  }

  void clear() {
    _cache.clear();
  }
}
