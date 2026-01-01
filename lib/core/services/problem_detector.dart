class ProblemDetector {
  /// Checks if the target value is empty or null, which is a common problem.
  static bool hasEmptyTarget(String? target) {
    return target == null || target.trim().isEmpty;
  }

  /// Checks for placeholder mismatches between source and target.
  /// This supports simple curly brace placeholders like `{name}`, `{0}`.
  static bool hasPlaceholderMismatch(String source, String? target) {
    if (target == null) {
      return false;
    }

    // Regex to find things like {name}, {0}, {count}, etc.
    // Handles alphanumeric and underscores inside braces.
    final placeholderRegex = RegExp(r'\{[a-zA-Z0-9_]+\}');

    final sourcePlaceholders =
        placeholderRegex.allMatches(source).map((m) => m.group(0)).toList();
    final targetPlaceholders =
        placeholderRegex.allMatches(target).map((m) => m.group(0)).toList();

    // Sort to compare regardless of order, though strict order might be desired
    // later. For now, simple count and existence check.

    // 1. Count mismatch
    if (sourcePlaceholders.length != targetPlaceholders.length) {
      return true;
    }

    // 2. Content mismatch - check if all source placeholders exist in target.
    // We create a mutable copy of target placeholders to handle duplicates.
    final targetList = List<String>.from(targetPlaceholders);

    for (final placeholder in sourcePlaceholders) {
      if (placeholder != null && targetList.contains(placeholder)) {
        targetList.remove(placeholder); // Remove one instance
      } else {
        return true; // Missing a placeholder
      }
    }

    return false;
  }

  /// Checks if the target length looks unusually short or long.
  static bool hasSuspiciousLength(
    String source,
    String? target, {
    double minRatio = 0.7, // 30% deviation
    double maxRatio = 1.3, // 30% deviation
    int minSourceLength = 3,
  }) {
    if (target == null) {
      return false;
    }
    final sourceTrimmed = source.trim();
    final targetTrimmed = target.trim();
    if (sourceTrimmed.length < minSourceLength || targetTrimmed.isEmpty) {
      return false;
    }

    // Microcopy check: if source has 1-2 words, afford simpler 2x rule
    final wordCount = sourceTrimmed.split(RegExp(r'\s+')).length;
    final effectiveMax = wordCount <= 2 ? 2.0 : maxRatio;
    
    // For very short text (e.g. "Ok"), 30% is just 1 char. 
    // Let's enforce the ratio strictness only if length > 5 or so?
    // User credentials -> "minSourceLength" handles extremely short stuff.
    // Let's stick to the requested ratios.

    final ratio = targetTrimmed.length / sourceTrimmed.length;
    return ratio < minRatio || ratio > effectiveMax;
  }
}
