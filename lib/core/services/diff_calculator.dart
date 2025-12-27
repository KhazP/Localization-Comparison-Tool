import 'package:string_similarity/string_similarity.dart';
import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';

class DiffCalculator {
  /// Calculates diff between two data maps based on the comparison mode.
  ///
  /// - `Key-based`: Matches entries by key name (traditional approach).
  /// - `Order-based`: Matches entries by position in file (index-based).
  /// - `Smart Match`: Key-based first, then attempts to detect renamed keys.
  static Map<String, ComparisonStatusDetail> calculateDiff({
    required Map<String, String> data1,
    required Map<String, String> data2,
    required bool ignoreCase,
    required List<String> ignorePatterns,
    required bool ignoreWhitespace,
    required String comparisonMode,
    required double similarityThreshold,
  }) {
    switch (comparisonMode) {
      case 'Order-based':
        return _calculateOrderBasedDiff(
          data1: data1,
          data2: data2,
          ignoreCase: ignoreCase,
          ignorePatterns: ignorePatterns,
          ignoreWhitespace: ignoreWhitespace,
          similarityThreshold: similarityThreshold,
        );
      case 'Smart Match':
        return _calculateSmartMatchDiff(
          data1: data1,
          data2: data2,
          ignoreCase: ignoreCase,
          ignorePatterns: ignorePatterns,
          ignoreWhitespace: ignoreWhitespace,
          similarityThreshold: similarityThreshold,
        );
      case 'Key-based':
      default:
        return _calculateKeyBasedDiff(
          data1: data1,
          data2: data2,
          ignoreCase: ignoreCase,
          ignorePatterns: ignorePatterns,
          ignoreWhitespace: ignoreWhitespace,
          similarityThreshold: similarityThreshold,
        );
    }
  }

  /// Key-based matching: matches entries by their key name.
  static Map<String, ComparisonStatusDetail> _calculateKeyBasedDiff({
    required Map<String, String> data1,
    required Map<String, String> data2,
    required bool ignoreCase,
    required List<String> ignorePatterns,
    required bool ignoreWhitespace,
    required double similarityThreshold,
  }) {
    final diff = <String, ComparisonStatusDetail>{};
    final allKeys = {...data1.keys, ...data2.keys}.toList();

    for (final key in allKeys) {
      if (_shouldIgnoreKey(key, ignorePatterns)) continue;

      String? value1 = data1[key];
      String? value2 = data2[key];

      value1 = _normalizeValue(value1, ignoreCase, ignoreWhitespace);
      value2 = _normalizeValue(value2, ignoreCase, ignoreWhitespace);

      diff[key] = _compareValues(value1, value2, similarityThreshold);
    }
    return diff;
  }

  /// Order-based matching: matches entries by their position (index).
  static Map<String, ComparisonStatusDetail> _calculateOrderBasedDiff({
    required Map<String, String> data1,
    required Map<String, String> data2,
    required bool ignoreCase,
    required List<String> ignorePatterns,
    required bool ignoreWhitespace,
    required double similarityThreshold,
  }) {
    final diff = <String, ComparisonStatusDetail>{};
    final keys1 = data1.keys.where((k) => !_shouldIgnoreKey(k, ignorePatterns)).toList();
    final keys2 = data2.keys.where((k) => !_shouldIgnoreKey(k, ignorePatterns)).toList();

    final maxLength = keys1.length > keys2.length ? keys1.length : keys2.length;

    for (int i = 0; i < maxLength; i++) {
      final key1 = i < keys1.length ? keys1[i] : null;
      final key2 = i < keys2.length ? keys2[i] : null;

      // Use key2 as the primary key for display (target file), fallback to key1
      final displayKey = key2 ?? key1!;

      String? value1 = key1 != null ? data1[key1] : null;
      String? value2 = key2 != null ? data2[key2] : null;

      value1 = _normalizeValue(value1, ignoreCase, ignoreWhitespace);
      value2 = _normalizeValue(value2, ignoreCase, ignoreWhitespace);

      diff[displayKey] = _compareValues(value1, value2, similarityThreshold);
    }
    return diff;
  }

  /// Smart Match: Key-based first, then detects potential key renames.
  static Map<String, ComparisonStatusDetail> _calculateSmartMatchDiff({
    required Map<String, String> data1,
    required Map<String, String> data2,
    required bool ignoreCase,
    required List<String> ignorePatterns,
    required bool ignoreWhitespace,
    required double similarityThreshold,
  }) {
    final diff = <String, ComparisonStatusDetail>{};
    final matchedKeys1 = <String>{};
    final matchedKeys2 = <String>{};

    // Phase 1: Exact key matches
    for (final key in data1.keys) {
      if (_shouldIgnoreKey(key, ignorePatterns)) continue;

      if (data2.containsKey(key)) {
        String? value1 = _normalizeValue(data1[key], ignoreCase, ignoreWhitespace);
        String? value2 = _normalizeValue(data2[key], ignoreCase, ignoreWhitespace);
        diff[key] = _compareValues(value1, value2, similarityThreshold);
        matchedKeys1.add(key);
        matchedKeys2.add(key);
      }
    }

    // Phase 2: Find unmatched keys
    final unmatchedKeys1 = data1.keys.where((k) => !matchedKeys1.contains(k) && !_shouldIgnoreKey(k, ignorePatterns)).toList();
    final unmatchedKeys2 = data2.keys.where((k) => !matchedKeys2.contains(k) && !_shouldIgnoreKey(k, ignorePatterns)).toList();

    // Phase 3: Try to match by value similarity (detect renames)
    final usedKeys2 = <String>{};
    for (final key1 in unmatchedKeys1) {
      String? value1 = _normalizeValue(data1[key1], ignoreCase, ignoreWhitespace);
      String? bestMatch;
      double bestSimilarity = 0.0;

      for (final key2 in unmatchedKeys2) {
        if (usedKeys2.contains(key2)) continue;
        String? value2 = _normalizeValue(data2[key2], ignoreCase, ignoreWhitespace);

        if (value1 != null && value2 != null) {
          final similarity = value1.similarityTo(value2);
          if (similarity >= similarityThreshold && similarity > bestSimilarity) {
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
    }

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

  static String? _normalizeValue(String? value, bool ignoreCase, bool ignoreWhitespace) {
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

  static ComparisonStatusDetail _compareValues(String? value1, String? value2, double similarityThreshold) {
    if (value1 == null && value2 != null) {
      return ComparisonStatusDetail.added();
    } else if (value1 != null && value2 == null) {
      return ComparisonStatusDetail.removed();
    } else if (value1 != value2) {
      final similarityScore = value1!.similarityTo(value2!);
      return ComparisonStatusDetail.modified(similarityScore);
    } else {
      return ComparisonStatusDetail.identical();
    }
  }
}
