import 'package:flutter/material.dart';
import 'package:diff_match_patch/diff_match_patch.dart';

enum DiffRenderMode { unified, sourceOnly, targetOnly }

/// Utility for calculating and rendering granular diffs.
class DiffUtils {
  static final _dmp = DiffMatchPatch();

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

    final diffs = _dmp.diff(text1, text2);
    _dmp.diffCleanupSemantic(diffs);

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
                  // If unified, maybe underline?
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
                  // Make deleted text slightly lighter
                  color: baseStyle.color?.withOpacity(0.7),
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
