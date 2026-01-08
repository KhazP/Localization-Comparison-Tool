import 'dart:io';
import 'dart:collection';

class _CachedFile {
  final Map<String, String> data;
  final DateTime modifiedTime;
  DateTime lastAccessed;

  _CachedFile(this.data, this.modifiedTime) : lastAccessed = DateTime.now();

  void touch() {
    lastAccessed = DateTime.now();
  }
}

/// File cache service with LRU eviction policy.
///
/// Caches parsed file data to avoid re-parsing unchanged files.
/// Uses LRU (Least Recently Used) eviction when cache is full.
class FileCacheService {
  static final FileCacheService _instance = FileCacheService._internal();
  factory FileCacheService() => _instance;
  FileCacheService._internal();

  // LinkedHashMap maintains insertion order for efficient LRU
  final LinkedHashMap<String, _CachedFile> _cache = LinkedHashMap();
  static const int _maxCacheSize = 50; // Increased from 10 for better hit rate

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
        // Move to end (most recently used) for LRU
        _cache.remove(key);
        cached.touch();
        _cache[key] = cached;
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
    final key = file.path + (keySuffix ?? '');

    // If key exists, remove it first to update position
    _cache.remove(key);

    // Evict LRU entries if full (remove from front)
    while (_cache.length >= _maxCacheSize) {
      _cache.remove(_cache.keys.first);
    }

    _cache[key] = _CachedFile(data, modifiedTime);
  }

  void clear() {
    _cache.clear();
  }

  /// Returns cache statistics for debugging
  Map<String, dynamic> get stats => {
        'size': _cache.length,
        'maxSize': _maxCacheSize,
      };
}
