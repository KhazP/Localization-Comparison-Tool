import 'package:flutter/material.dart';
import 'package:diff_match_patch/diff_match_patch.dart';

enum DiffRenderMode { unified, sourceOnly, targetOnly }

/// Utility for calculating and rendering granular diffs.
///
/// Includes caching of diff calculations to avoid redundant computation
/// when the same text pairs are compared multiple times (e.g., during scrolling).
class DiffUtils {
  static final _dmp = DiffMatchPatch();

  // Cache for diff results to avoid recomputation during scrolling/rebuilds
  static final Map<String, List<Diff>> _diffCache = {};
  static const int _maxCacheSize = 1000;

  /// Clears the diff cache. Call when comparison data changes.
  static void clearCache() {
    _diffCache.clear();
  }

  /// Gets or computes diffs between two texts with caching.
  static List<Diff> _getCachedDiffs(String text1, String text2) {
    final cacheKey = '$text1\n---DIFF---\n$text2';

    final cached = _diffCache[cacheKey];
    if (cached != null) {
      return cached;
    }

    final diffs = _dmp.diff(text1, text2);
    _dmp.diffCleanupSemantic(diffs);

    // Manage cache size with simple eviction
    if (_diffCache.length >= _maxCacheSize) {
      // Remove oldest entries (first 200)
      final keysToRemove = _diffCache.keys.take(200).toList();
      for (final key in keysToRemove) {
        _diffCache.remove(key);
      }
    }

    _diffCache[cacheKey] = diffs;
    return diffs;
  }

  /// Calculates the difference between [text1] (old) and [text2] (new)
  /// and returns a list of [TextSpan]s for rendering.
  static List<TextSpan> getDiffSpans({
    required String text1,
    required String text2,
    required TextStyle baseStyle,
    Color? addedColor,
    Color? deletedColor,
    DiffRenderMode mode = DiffRenderMode.unified,
  }) {
    // If strings are identical, return plain text
    if (text1 == text2) {
      return [
        TextSpan(
            text: mode == DiffRenderMode.targetOnly ? text2 : text1,
            style: baseStyle)
      ];
    }

    // Performance protection for very large strings
    if (text1.length > 5000 || text2.length > 5000) {
      if (mode == DiffRenderMode.sourceOnly) {
        return [TextSpan(text: text1, style: baseStyle)];
      } else if (mode == DiffRenderMode.targetOnly) {
        return [TextSpan(text: text2, style: baseStyle)];
      }
      return [TextSpan(text: text2, style: baseStyle)];
    }

    final diffs = _getCachedDiffs(text1, text2);

    final spans = <TextSpan>[];
    final addColor = addedColor ?? Colors.green.withValues(alpha: 0.25);
    final delColor = deletedColor ?? Colors.red.withValues(alpha: 0.25);

    for (final diff in diffs) {
      switch (diff.operation) {
        case DIFF_EQUAL:
          spans.add(TextSpan(text: diff.text, style: baseStyle));
          break;
        case DIFF_INSERT:
          if (mode != DiffRenderMode.sourceOnly) {
            spans.add(
              TextSpan(
                text: diff.text,
                style: baseStyle.copyWith(
                  backgroundColor: addColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          break;
        case DIFF_DELETE:
          if (mode != DiffRenderMode.targetOnly) {
            spans.add(
              TextSpan(
                text: diff.text,
                style: baseStyle.copyWith(
                  backgroundColor: delColor,
                  decoration: TextDecoration.lineThrough,
                  color: baseStyle.color?.withValues(alpha: 0.7),
                ),
              ),
            );
          }
          break;
      }
    }

    return spans;
  }
}
