import 'package:flutter/foundation.dart';

/// Holds translation coverage counts for a single comparison.
@immutable
class CoverageMetrics {
  /// Creates coverage metrics for a comparison.
  const CoverageMetrics({
    required this.sourceKeyCount,
    required this.translatedKeyCount,
    required this.sourceWordCount,
    required this.translatedWordCount,
  });

  /// Total number of source entries.
  final int sourceKeyCount;

  /// Number of source entries with a non-empty translation.
  final int translatedKeyCount;

  /// Total words in the source entries.
  final int sourceWordCount;

  /// Total words in the translated entries.
  final int translatedWordCount;

  /// Translation coverage as a percentage (0 to 100).
  double get coveragePercent {
    if (sourceKeyCount == 0) {
      return 0;
    }
    return (translatedKeyCount / sourceKeyCount) * 100;
  }
}

/// Categorizes the type of quality issue that was detected.
enum QualityIssueType {
  /// Placeholder markers do not match between source and translation.
  placeholderMismatch,

  /// The translation length is much shorter or longer than the source.
  lengthOutlier,

  /// The same translation text appears under multiple keys.
  duplicateValue,
}

/// Describes a specific quality issue found in a translation.
@immutable
class QualityIssue {
  /// Creates a quality issue record.
  const QualityIssue({
    required this.key,
    required this.sourceValue,
    required this.targetValue,
    required this.description,
    required this.type,
    this.relatedKeys,
  });

  /// The localization key tied to the issue.
  final String key;

  /// The expected source text, when available.
  final String? sourceValue;

  /// The translated text, when available.
  final String? targetValue;

  /// A short description of the specific error.
  final String description;

  /// The category of issue detected.
  final QualityIssueType type;

  /// For duplicate value issues, this list contains all keys sharing the value.
  final List<String>? relatedKeys;
}

/// Holds issue counts and detailed issue lists.
@immutable
class IssueMetrics {
  /// Creates issue metrics for a comparison.
  const IssueMetrics({
    required this.placeholderMismatchCount,
    required this.lengthOutlierCount,
    required this.duplicateValueCount,
    required this.placeholderMismatchIssues,
    required this.lengthOutlierIssues,
    required this.duplicateValueIssues,
  });

  /// Creates an empty issue report.
  const IssueMetrics.empty()
      : placeholderMismatchCount = 0,
        lengthOutlierCount = 0,
        duplicateValueCount = 0,
        placeholderMismatchIssues = const [],
        lengthOutlierIssues = const [],
        duplicateValueIssues = const [];

  /// Count of placeholder mismatches.
  final int placeholderMismatchCount;

  /// Count of unusually short or long translations.
  final int lengthOutlierCount;

  /// Count of entries that share the same translation value.
  final int duplicateValueCount;

  /// Detailed placeholder mismatch issues.
  final List<QualityIssue> placeholderMismatchIssues;

  /// Detailed length outlier issues.
  final List<QualityIssue> lengthOutlierIssues;

  /// Detailed duplicate value issues.
  final List<QualityIssue> duplicateValueIssues;

  /// Total number of issues across all categories.
  int get totalIssues {
    return placeholderMismatchCount + lengthOutlierCount + duplicateValueCount;
  }

  /// Returns true when no issues are recorded.
  bool get isEmpty => totalIssues == 0;
}

/// Bundles coverage and issue data for a language.
@immutable
class LanguageQualityReport {
  /// Creates a quality report for a language.
  const LanguageQualityReport({
    required this.languageCode,
    required this.languageLabel,
    required this.coverage,
    required this.issues,
  });

  /// Language code (for example, "en" or "fr").
  final String languageCode;

  /// Friendly language label for display.
  final String languageLabel;

  /// Translation coverage counts.
  final CoverageMetrics coverage;

  /// Detected issues for the language.
  final IssueMetrics issues;
}

/// Represents a point in the word trend chart.
@immutable
class WordTrendPoint {
  /// Creates a trend point.
  const WordTrendPoint({
    required this.timestamp,
    required this.words,
    required this.coveragePercent,
  });

  /// Time of the comparison.
  final DateTime timestamp;

  /// Number of translated words at that time.
  final int words;

  /// Coverage percentage at that time (0-100).
  final double coveragePercent;
}

/// Represents a point in the activity trend chart (churn).
@immutable
class ActivityTrendPoint {
  /// Creates an activity trend point.
  const ActivityTrendPoint({
    required this.timestamp,
    required this.added,
    required this.modified,
    required this.removed,
  });

  /// Time of the comparison.
  final DateTime timestamp;

  /// Number of added keys.
  final int added;

  /// Number of modified keys.
  final int modified;

  /// Number of removed keys.
  final int removed;
}

/// Represents a point in the burn-up chart (completion vs scope).
@immutable
class BurnUpPoint {
  /// Creates a burn-up point.
  const BurnUpPoint({
    required this.timestamp,
    required this.totalKeys,
    required this.translatedKeys,
  });

  /// Time of the comparison.
  final DateTime timestamp;

  /// Total number of keys (Scope).
  final int totalKeys;

  /// Number of translated keys (Progress).
  final int translatedKeys;
}


/// Aggregated data used by the quality dashboard.
@immutable
class QualityDashboardData {
  /// Creates dashboard data.
  const QualityDashboardData({
    required this.languages,
    required this.wordTrend,
    required this.activityTrend,
    required this.burnUpTrend,
    required this.warnings,
    required this.generatedAt,
  });



  /// Per-language quality reports.
  final List<LanguageQualityReport> languages;

  /// Trend points for translated words and coverage over time.
  final List<WordTrendPoint> wordTrend;

  /// Trend points for activity (added/modified/removed) over time.
  final List<ActivityTrendPoint> activityTrend;

  /// Trend points for completion versus scope over time.
  final List<BurnUpPoint> burnUpTrend;

  /// User-facing warnings about skipped files.
  final List<String> warnings;

  /// Timestamp when the data was generated.
  final DateTime generatedAt;

  /// Total number of languages with data.
  int get totalLanguages => languages.length;

  /// Average coverage percentage across languages.
  double get averageCoveragePercent {
    if (languages.isEmpty) {
      return 0;
    }
    final total = languages.fold<double>(
      0,
      (sum, report) => sum + report.coverage.coveragePercent,
    );
    return total / languages.length;
  }

  /// Total number of issues across all languages.
  int get totalIssues {
    return languages.fold<int>(
      0,
      (sum, report) => sum + report.issues.totalIssues,
    );
  }

  /// Total translated words across all languages.
  int get totalTranslatedWords {
    return languages.fold<int>(
      0,
      (sum, report) => sum + report.coverage.translatedWordCount,
    );
  }

  /// Total translated entries across all languages.
  int get totalTranslatedKeys {
    return languages.fold<int>(
      0,
      (sum, report) => sum + report.coverage.translatedKeyCount,
    );
  }

  /// Total source entries across all languages.
  int get totalSourceKeys {
    return languages.fold<int>(
      0,
      (sum, report) => sum + report.coverage.sourceKeyCount,
    );
  }
}
