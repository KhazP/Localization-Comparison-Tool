
class ProblemDetector {
  /// Checks if the target value is empty or null, which is a common problem.
  static bool hasEmptyTarget(String? target) {
    return target == null || target.trim().isEmpty;
  }

  /// Checks for placeholder mismatches between source and target.
  /// This supports simple curly brace placeholders like `{name}`, `{0}`.
  static bool hasPlaceholderMismatch(String source, String? target) {
    if (target == null) return false;

    // Regex to find things like {name}, {0}, {count}, etc.
    // Handles alphanumeric and underscores inside braces.
    final placeholderRegex = RegExp(r'\{[a-zA-Z0-9_]+\}');

    final sourcePlaceholders = placeholderRegex.allMatches(source).map((m) => m.group(0)).toList();
    final targetPlaceholders = placeholderRegex.allMatches(target).map((m) => m.group(0)).toList();

    // Sort to compare regardless of order, though strict order might be desired later.
    // For now, simple count and existence check.
    
    // 1. Count mismatch
    if (sourcePlaceholders.length != targetPlaceholders.length) {
      return true;
    }

    // 2. Content mismatch - check if all source placeholders exist in target
    // We create a mutable copy of target placeholders to handle duplicates correctly
    final targetList = List<String>.from(targetPlaceholders);
    
    for (var ph in sourcePlaceholders) {
      if (ph != null && targetList.contains(ph)) {
        targetList.remove(ph); // Remove one instance
      } else {
        return true; // Missing a placeholder
      }
    }

    return false;
  }
}
