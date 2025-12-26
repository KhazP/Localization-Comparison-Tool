import 'package:string_similarity/string_similarity.dart';
import 'package:flutter/foundation.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';

class DiffCalculator {
  static Map<String, ComparisonStatusDetail> calculateDiff({
    required Map<String, String> data1,
    required Map<String, String> data2,
    required bool ignoreCase,
    required List<String> ignorePatterns,
    required bool ignoreWhitespace,
  }) {
    final diff = <String, ComparisonStatusDetail>{};
    final allKeys = {...data1.keys, ...data2.keys}.toList();

    for (final key in allKeys) {
      // --- Implement ignorePatterns logic ---
      bool shouldIgnoreKey = false;
      for (final pattern in ignorePatterns) {
        try {
          if (RegExp(pattern).hasMatch(key)) {
            shouldIgnoreKey = true;
            break;
          }
        } catch (e) {
          // Log regex compilation error or handle it if necessary
          // For now, if a pattern is invalid, we'll effectively ignore that specific pattern
          debugPrint('Invalid regex pattern in ignorePatterns: $pattern. Error: $e');
        }
      }

      if (shouldIgnoreKey) {
        continue; // Skip this key entirely
      }
      // --- End ignorePatterns logic ---

      String? value1 = data1[key];
      String? value2 = data2[key];

      // --- Implement ignoreWhitespace logic ---
      if (ignoreWhitespace) {
        if (value1 != null) {
          value1 = value1.trim().replaceAll(RegExp(r'\s+'), ' ');
        }
        if (value2 != null) {
          value2 = value2.trim().replaceAll(RegExp(r'\s+'), ' ');
        }
      }
      // --- End ignoreWhitespace logic ---

      // --- Implement ignoreCase logic ---
      if (ignoreCase) {
        if (value1 != null) {
          value1 = value1.toLowerCase();
        }
        if (value2 != null) {
          value2 = value2.toLowerCase();
        }
      }
      // --- End ignoreCase logic ---

      // Actual comparison logic (will use potentially modified value1 and value2)
      if (value1 == null && value2 != null) {
        diff[key] = ComparisonStatusDetail.added();
      } else if (value1 != null && value2 == null) {
        diff[key] = ComparisonStatusDetail.removed();
      } else if (value1 != value2) {
        final similarityScore = value1!.similarityTo(value2!);
        diff[key] = ComparisonStatusDetail.modified(similarityScore);
      } else { // value1 == value2 (including if both are null, or after transformations they become equal)
        diff[key] = ComparisonStatusDetail.identical();
      }
    }
    return diff;
  }
} 