import 'package:freezed_annotation/freezed_annotation.dart';

part 'quality_metrics.freezed.dart';

/// Holds translation coverage counts for a single comparison.
@freezed
class CoverageMetrics with _$CoverageMetrics {
  const CoverageMetrics._();

  /// Creates coverage metrics for a comparison.
  const factory CoverageMetrics({
    /// Total number of source entries.
    required int sourceKeyCount,

    /// Number of source entries with a non-empty translation.
    required int translatedKeyCount,

    /// Total words in the source entries.
    required int sourceWordCount,

    /// Total words in the translated entries.
    required int translatedWordCount,
  }) = _CoverageMetrics;

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
@freezed
class QualityIssue with _$QualityIssue {
  /// Creates a quality issue record.
  const factory QualityIssue({
    /// The localization key tied to the issue.
    required String key,

    /// The expected source text, when available.
    String? sourceValue,

    /// The translated text, when available.
    String? targetValue,

    /// A short description of the specific error.
    required String description,

    /// The category of issue detected.
    required QualityIssueType type,

    /// For duplicate value issues, this list contains all keys sharing
    /// the value.
    List<String>? relatedKeys,

    /// For duplicate values, maps each key to its source text (if available).
    Map<String, String>? relatedSources,
  }) = _QualityIssue;
}

/// Holds issue counts and detailed issue lists.
@freezed
class IssueMetrics with _$IssueMetrics {
  const IssueMetrics._();

  /// Creates issue metrics for a comparison.
  const factory IssueMetrics({
    /// Count of placeholder mismatches.
    required int placeholderMismatchCount,

    /// Count of unusually short or long translations.
    required int lengthOutlierCount,

    /// Count of entries that share the same translation value.
    required int duplicateValueCount,

    /// Detailed placeholder mismatch issues.
    required List<QualityIssue> placeholderMismatchIssues,

    /// Detailed length outlier issues.
    required List<QualityIssue> lengthOutlierIssues,

    /// Detailed duplicate value issues.
    required List<QualityIssue> duplicateValueIssues,
  }) = _IssueMetrics;

  /// Creates an empty issue report.
  factory IssueMetrics.empty() => const IssueMetrics(
        placeholderMismatchCount: 0,
        lengthOutlierCount: 0,
        duplicateValueCount: 0,
        placeholderMismatchIssues: [],
        lengthOutlierIssues: [],
        duplicateValueIssues: [],
      );

  /// Total number of issues across all categories.
  int get totalIssues {
    return placeholderMismatchCount + lengthOutlierCount + duplicateValueCount;
  }

  /// Returns true when no issues are recorded.
  bool get isEmpty => totalIssues == 0;
}

/// Bundles coverage and issue data for a language.
@freezed
class LanguageQualityReport with _$LanguageQualityReport {
  /// Creates a quality report for a language.
  const factory LanguageQualityReport({
    /// Language code (for example, "en" or "fr").
    required String languageCode,

    /// Friendly language label for display.
    required String languageLabel,

    /// Translation coverage counts.
    required CoverageMetrics coverage,

    /// Detected issues for the language.
    required IssueMetrics issues,
  }) = _LanguageQualityReport;
}

/// Represents a point in the word trend chart.
@freezed
class WordTrendPoint with _$WordTrendPoint {
  /// Creates a trend point.
  const factory WordTrendPoint({
    /// Time of the comparison.
    required DateTime timestamp,

    /// Number of translated words at that time.
    required int words,

    /// Coverage percentage at that time (0-100).
    required double coveragePercent,
  }) = _WordTrendPoint;
}

/// Represents a point in the activity trend chart (churn).
@freezed
class ActivityTrendPoint with _$ActivityTrendPoint {
  /// Creates an activity trend point.
  const factory ActivityTrendPoint({
    /// Time of the comparison.
    required DateTime timestamp,

    /// Number of added keys.
    required int added,

    /// Number of modified keys.
    required int modified,

    /// Number of removed keys.
    required int removed,
  }) = _ActivityTrendPoint;
}

/// Represents a point in the burn-up chart (completion vs scope).
@freezed
class BurnUpPoint with _$BurnUpPoint {
  /// Creates a burn-up point.
  const factory BurnUpPoint({
    /// Time of the comparison.
    required DateTime timestamp,

    /// Total number of keys (Scope).
    required int totalKeys,

    /// Number of translated keys (Progress).
    required int translatedKeys,
  }) = _BurnUpPoint;
}

/// Aggregated data used by the quality dashboard.
@freezed
class QualityDashboardData with _$QualityDashboardData {
  const QualityDashboardData._();

  /// Creates dashboard data.
  const factory QualityDashboardData({
    /// Per-language quality reports.
    required List<LanguageQualityReport> languages,

    /// Trend points for translated words and coverage over time.
    required List<WordTrendPoint> wordTrend,

    /// Trend points for activity (added/modified/removed) over time.
    required List<ActivityTrendPoint> activityTrend,

    /// Trend points for completion versus scope over time.
    required List<BurnUpPoint> burnUpTrend,

    /// User-facing warnings about skipped files.
    required List<String> warnings,

    /// Timestamp when the data was generated.
    required DateTime generatedAt,
  }) = _QualityDashboardData;

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
