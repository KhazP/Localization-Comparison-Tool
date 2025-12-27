import 'package:localizer_app_main/data/models/comparison_status_detail.dart';

/// Encapsulates rules for applying fuzzy fill matches to target entries.
class FuzzyFillRules {
  /// Creates a set of fuzzy fill rules.
  const FuzzyFillRules({
    required this.minScore,
    required this.onlyEmptyTargets,
    required this.applyToAdded,
    required this.applyToModified,
  });

  /// The minimum score required to apply a match.
  final double minScore;

  /// Whether only empty targets should be filled.
  final bool onlyEmptyTargets;

  /// Whether added entries are eligible.
  final bool applyToAdded;

  /// Whether modified entries are eligible.
  final bool applyToModified;

  /// Returns true when the current entry can receive a match.
  bool canApply({
    required StringComparisonStatus status,
    required String? currentTarget,
    required double score,
  }) {
    if (score < minScore) {
      return false;
    }
    if (status == StringComparisonStatus.added && !applyToAdded) {
      return false;
    }
    if (status == StringComparisonStatus.modified && !applyToModified) {
      return false;
    }
    if (status != StringComparisonStatus.added &&
        status != StringComparisonStatus.modified) {
      return false;
    }
    if (onlyEmptyTargets && (currentTarget?.trim().isNotEmpty ?? false)) {
      return false;
    }
    return true;
  }
}
