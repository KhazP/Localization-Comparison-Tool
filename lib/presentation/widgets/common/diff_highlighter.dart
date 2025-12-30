import 'package:flutter/material.dart';
import 'package:diff_match_patch/diff_match_patch.dart';

/// A utility class for generating highlighted TextSpans showing character-level
/// differences between two strings.
class DiffHighlighter {
  // Cache for diff results to avoid recomputation
  static final Map<String, List<Diff>> _diffCache = {};
  static const int _maxCacheSize = 500;

  /// Clears the diff cache
  static void clearCache() {
    _diffCache.clear();
  }

  /// Gets or computes diffs between two texts
  static List<Diff> _getDiffs(String oldText, String newText) {
    final cacheKey = '$oldText\n---\n$newText';
    
    if (_diffCache.containsKey(cacheKey)) {
      return _diffCache[cacheKey]!;
    }

    final dmp = DiffMatchPatch();
    final diffs = dmp.diff(oldText, newText);
    dmp.diffCleanupSemantic(diffs);

    // Manage cache size
    if (_diffCache.length >= _maxCacheSize) {
      // Remove oldest entries (first 100)
      final keysToRemove = _diffCache.keys.take(100).toList();
      for (final key in keysToRemove) {
        _diffCache.remove(key);
      }
    }

    _diffCache[cacheKey] = diffs;
    return diffs;
  }

  /// Generates a list of [TextSpan]s highlighting the differences between
  /// [oldText] and [newText].
  ///
  /// If [isSource] is true, this shows the OLD text with deletions highlighted
  /// (subtle red background). If false, it shows the NEW text with
  /// insertions highlighted (subtle green background).
  static List<TextSpan> highlightDiff(
    String oldText,
    String newText, {
    required bool isSource,
    TextStyle? baseStyle,
    Color? deletionColor,
    Color? insertionColor,
  }) {
    final diffs = _getDiffs(oldText, newText);

    final effectiveDeletionColor = deletionColor ?? Colors.red;
    final effectiveInsertionColor = insertionColor ?? Colors.green;

    List<TextSpan> spans = [];

    for (final diff in diffs) {
      TextStyle? style;

      if (diff.operation == DIFF_DELETE) {
        if (isSource) {
          // Show deletions only in the source (old) column
          // Softer styling: subtle background, no strikethrough
          style = (baseStyle ?? const TextStyle()).copyWith(
            backgroundColor: effectiveDeletionColor.withValues(alpha: 0.25),
            fontWeight: FontWeight.w500,
          );
          spans.add(TextSpan(text: diff.text, style: style));
        }
        // Skip deletions when showing target
      } else if (diff.operation == DIFF_INSERT) {
        if (!isSource) {
          // Show insertions only in the target (new) column
          // Softer styling: subtle background
          style = (baseStyle ?? const TextStyle()).copyWith(
            backgroundColor: effectiveInsertionColor.withValues(alpha: 0.25),
            fontWeight: FontWeight.w500,
          );
          spans.add(TextSpan(text: diff.text, style: style));
        }
        // Skip insertions when showing source
      } else {
        // DIFF_EQUAL - show in both columns
        spans.add(TextSpan(text: diff.text, style: baseStyle));
      }
    }

    return spans;
  }

  /// Convenience widget that wraps highlightDiff in a Text widget.
  /// Set [selectable] to true to allow text selection, false to allow parent tap handling.
  static Widget buildDiffText(
    String oldText,
    String newText, {
    required bool isSource,
    TextStyle? baseStyle,
    int? maxLines,
    Color? deletionColor,
    Color? insertionColor,
    bool selectable = false,
  }) {
    final spans = highlightDiff(
      oldText,
      newText,
      isSource: isSource,
      baseStyle: baseStyle,
      deletionColor: deletionColor,
      insertionColor: insertionColor,
    );

    if (selectable) {
      return SelectableText.rich(
        TextSpan(children: spans),
        maxLines: maxLines,
      );
    } else {
      return Text.rich(
        TextSpan(children: spans),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}
