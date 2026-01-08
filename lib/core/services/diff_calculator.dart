import 'package:string_similarity/string_similarity.dart';
import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';

/// Progress callback for reporting diff calculation progress.
typedef DiffProgressCallback = void Function(int processed, int total);

/// Cache for string similarity calculations to avoid redundant computation.
/// This is especially important for Smart Match mode which can have O(n²) comparisons.
class _SimilarityCache {
  final Map<String, double> _cache = {};
  static const int _maxSize = 50000;

  String _makeKey(String a, String b) {
    // Ensure consistent key regardless of order
    return a.hashCode < b.hashCode ? '$a\n---\n$b' : '$b\n---\n$a';
  }

  double? get(String a, String b) => _cache[_makeKey(a, b)];

  void set(String a, String b, double similarity) {
    if (_cache.length >= _maxSize) {
      // Clear half the cache when full
      final keysToRemove = _cache.keys.take(_maxSize ~/ 2).toList();
      for (final key in keysToRemove) {
        _cache.remove(key);
      }
    }
    _cache[_makeKey(a, b)] = similarity;
  }

  void clear() => _cache.clear();
}

class DiffCalculator {
  // Similarity cache for avoiding redundant calculations
  static final _similarityCache = _SimilarityCache();

  /// Clears the similarity cache. Call when starting a new comparison.
  static void clearCache() {
    _similarityCache.clear();
  }

  /// Calculates diff between two data maps based on the comparison mode.
  ///
  /// - `Key-based`: Matches entries by key name (traditional approach).
  /// - `Order-based`: Matches entries by position in file (index-based).
  /// - `Smart Match`: Key-based first, then attempts to detect renamed keys.
  ///
  /// [onProgress] is an optional callback for reporting progress during calculation.
  static Map<String, ComparisonStatusDetail> calculateDiff({
    required Map<String, String> sourceData,
    required Map<String, String> targetData,
    required AppSettings settings,
    DiffProgressCallback? onProgress,
  }) {
    // Clear cache at start of new comparison
    _similarityCache.clear();

    final mode = settings.comparisonMode;

    switch (mode) {
      case 'Order-based':
        return _calculateOrderBasedDiff(
          sourceData: sourceData,
          targetData: targetData,
          ignoreCase: settings.ignoreCase,
          ignorePatterns: settings.ignorePatterns,
          ignoreWhitespace: settings.ignoreWhitespace,
          similarityThreshold: settings.similarityThreshold,
          onProgress: onProgress,
        );
      case 'Smart Match':
        return _calculateSmartMatchDiff(
          sourceData: sourceData,
          targetData: targetData,
          ignoreCase: settings.ignoreCase,
          ignorePatterns: settings.ignorePatterns,
          ignoreWhitespace: settings.ignoreWhitespace,
          similarityThreshold: settings.similarityThreshold,
          onProgress: onProgress,
        );
      case 'Key-based':
      default:
        return _calculateKeyBasedDiff(
          sourceData: sourceData,
          targetData: targetData,
          ignoreCase: settings.ignoreCase,
          ignorePatterns: settings.ignorePatterns,
          ignoreWhitespace: settings.ignoreWhitespace,
          similarityThreshold: settings.similarityThreshold,
          onProgress: onProgress,
        );
    }
  }

  /// Key-based matching: matches entries by their key name.
  static Map<String, ComparisonStatusDetail> _calculateKeyBasedDiff({
    required Map<String, String> sourceData,
    required Map<String, String> targetData,
    required bool ignoreCase,
    required List<String> ignorePatterns,
    required bool ignoreWhitespace,
    required double similarityThreshold,
    DiffProgressCallback? onProgress,
  }) {
    final diff = <String, ComparisonStatusDetail>{};
    final allKeys = {...sourceData.keys, ...targetData.keys}.toList();
    final totalKeys = allKeys.length;
    int processedKeys = 0;
    int lastReportedPercent = 0;

    for (final key in allKeys) {
      if (_shouldIgnoreKey(key, ignorePatterns)) {
        processedKeys++;
        continue;
      }

      String? value1 = sourceData[key];
      String? value2 = targetData[key];

      value1 = _normalizeValue(value1, ignoreCase, ignoreWhitespace);
      value2 = _normalizeValue(value2, ignoreCase, ignoreWhitespace);

      diff[key] = _compareValues(value1, value2, similarityThreshold);

      processedKeys++;

      // Report progress every 1% to avoid too many callbacks
      if (onProgress != null && totalKeys > 0) {
        final currentPercent = (processedKeys * 100 / totalKeys).floor();
        if (currentPercent > lastReportedPercent) {
          lastReportedPercent = currentPercent;
          onProgress(processedKeys, totalKeys);
        }
      }
    }

    // Final progress report
    onProgress?.call(totalKeys, totalKeys);
    return diff;
  }

  /// Order-based matching: matches entries by their position (index).
  static Map<String, ComparisonStatusDetail> _calculateOrderBasedDiff({
    required Map<String, String> sourceData,
    required Map<String, String> targetData,
    required bool ignoreCase,
    required List<String> ignorePatterns,
    required bool ignoreWhitespace,
    required double similarityThreshold,
    DiffProgressCallback? onProgress,
  }) {
    final diff = <String, ComparisonStatusDetail>{};
    final keys1 = sourceData.keys
        .where((k) => !_shouldIgnoreKey(k, ignorePatterns))
        .toList();
    final keys2 = targetData.keys
        .where((k) => !_shouldIgnoreKey(k, ignorePatterns))
        .toList();

    final maxLength = keys1.length > keys2.length ? keys1.length : keys2.length;
    int lastReportedPercent = 0;

    for (int i = 0; i < maxLength; i++) {
      final key1 = i < keys1.length ? keys1[i] : null;
      final key2 = i < keys2.length ? keys2[i] : null;

      // Use key2 as the primary key for display (target file), fallback to key1
      final displayKey = key2 ?? key1!;

      String? value1 = key1 != null ? sourceData[key1] : null;
      String? value2 = key2 != null ? targetData[key2] : null;

      value1 = _normalizeValue(value1, ignoreCase, ignoreWhitespace);
      value2 = _normalizeValue(value2, ignoreCase, ignoreWhitespace);

      diff[displayKey] = _compareValues(value1, value2, similarityThreshold);

      // Report progress every 1%
      if (onProgress != null && maxLength > 0) {
        final currentPercent = ((i + 1) * 100 / maxLength).floor();
        if (currentPercent > lastReportedPercent) {
          lastReportedPercent = currentPercent;
          onProgress(i + 1, maxLength);
        }
      }
    }

    onProgress?.call(maxLength, maxLength);
    return diff;
  }

  /// Smart Match: Key-based first, then detects potential key renames.
  static Map<String, ComparisonStatusDetail> _calculateSmartMatchDiff({
    required Map<String, String> sourceData,
    required Map<String, String> targetData,
    required bool ignoreCase,
    required List<String> ignorePatterns,
    required bool ignoreWhitespace,
    required double similarityThreshold,
    DiffProgressCallback? onProgress,
  }) {
    final diff = <String, ComparisonStatusDetail>{};
    final matchedKeys1 = <String>{};
    final matchedKeys2 = <String>{};

    // Calculate total work: phase1 + phase2 + phase3 + phase4
    final totalKeys = sourceData.length + targetData.length;
    int processedKeys = 0;
    int lastReportedPercent = 0;

    void reportProgress() {
      if (onProgress != null && totalKeys > 0) {
        final currentPercent = (processedKeys * 100 / totalKeys).floor();
        if (currentPercent > lastReportedPercent) {
          lastReportedPercent = currentPercent;
          onProgress(processedKeys, totalKeys);
        }
      }
    }

    // Phase 1: Exact key matches
    for (final key in sourceData.keys) {
      if (_shouldIgnoreKey(key, ignorePatterns)) {
        processedKeys++;
        continue;
      }

      if (targetData.containsKey(key)) {
        String? value1 =
            _normalizeValue(sourceData[key], ignoreCase, ignoreWhitespace);
        String? value2 =
            _normalizeValue(targetData[key], ignoreCase, ignoreWhitespace);
        diff[key] = _compareValues(value1, value2, similarityThreshold);
        matchedKeys1.add(key);
        matchedKeys2.add(key);
      }
      processedKeys++;
      reportProgress();
    }

    // Phase 2: Find unmatched keys
    final unmatchedKeys1 = sourceData.keys
        .where((k) =>
            !matchedKeys1.contains(k) && !_shouldIgnoreKey(k, ignorePatterns))
        .toList();
    final unmatchedKeys2 = targetData.keys
        .where((k) =>
            !matchedKeys2.contains(k) && !_shouldIgnoreKey(k, ignorePatterns))
        .toList();

    // Phase 3: Try to match by value similarity (detect renames)
    // Uses cached similarity to avoid O(n²) redundant calculations
    final usedKeys2 = <String>{};
    for (final key1 in unmatchedKeys1) {
      String? value1 =
          _normalizeValue(sourceData[key1], ignoreCase, ignoreWhitespace);
      String? bestMatch;
      double bestSimilarity = 0.0;

      for (final key2 in unmatchedKeys2) {
        if (usedKeys2.contains(key2)) continue;
        String? value2 =
            _normalizeValue(targetData[key2], ignoreCase, ignoreWhitespace);

        if (value1 != null && value2 != null) {
          // Use cached similarity calculation
          final similarity = _getCachedSimilarity(value1, value2);
          if (similarity >= similarityThreshold &&
              similarity > bestSimilarity) {
            bestSimilarity = similarity;
            bestMatch = key2;
          }
        }
      }

      if (bestMatch != null) {
        // Found a rename: key changed but value is similar
        // Mark as modified with the new key, showing the similarity
        diff[bestMatch] = ComparisonStatusDetail.modified(bestSimilarity);
        usedKeys2.add(bestMatch);
      } else {
        // No match found - it's removed
        diff[key1] = ComparisonStatusDetail.removed();
      }
    }

    // Phase 4: Mark remaining unmatched keys2 as added
    for (final key2 in unmatchedKeys2) {
      if (!usedKeys2.contains(key2)) {
        diff[key2] = ComparisonStatusDetail.added();
      }
      processedKeys++;
      reportProgress();
    }

    onProgress?.call(totalKeys, totalKeys);
    return diff;
  }

  // Helper methods
  static bool _shouldIgnoreKey(String key, List<String> ignorePatterns) {
    for (final pattern in ignorePatterns) {
      try {
        if (RegExp(pattern).hasMatch(key)) return true;
      } catch (e) {
        debugPrint('Invalid regex pattern: $pattern. Error: $e');
      }
    }
    return false;
  }

  static String? _normalizeValue(
      String? value, bool ignoreCase, bool ignoreWhitespace) {
    if (value == null) return null;
    var result = value;
    if (ignoreWhitespace) {
      result = result.trim().replaceAll(RegExp(r'\s+'), ' ');
    }
    if (ignoreCase) {
      result = result.toLowerCase();
    }
    return result;
  }

  static ComparisonStatusDetail _compareValues(
      String? value1, String? value2, double similarityThreshold) {
    if (value1 == null && value2 != null) {
      return ComparisonStatusDetail.added();
    } else if (value1 != null && value2 == null) {
      return ComparisonStatusDetail.removed();
    } else if (value1 != value2) {
      final similarityScore = _getCachedSimilarity(value1!, value2!);
      return ComparisonStatusDetail.modified(similarityScore);
    } else {
      return ComparisonStatusDetail.identical();
    }
  }

  /// Gets similarity score with caching to avoid redundant calculations.
  static double _getCachedSimilarity(String value1, String value2) {
    // Check cache first
    final cached = _similarityCache.get(value1, value2);
    if (cached != null) {
      return cached;
    }

    // Calculate and cache
    final similarity = value1.similarityTo(value2);
    _similarityCache.set(value1, value2, similarity);
    return similarity;
  }
}
