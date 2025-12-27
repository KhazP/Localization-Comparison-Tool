import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/core/services/fuzzy_fill_rules.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';

void main() {
  test('allows added entries when target is empty and score is high', () {
    const rules = FuzzyFillRules(
      minScore: 0.7,
      onlyEmptyTargets: true,
      applyToAdded: true,
      applyToModified: true,
    );

    final canApply = rules.canApply(
      status: StringComparisonStatus.added,
      currentTarget: '',
      score: 0.9,
    );

    expect(canApply, isTrue);
  });

  test('blocks modified entries when replacements are disabled', () {
    const rules = FuzzyFillRules(
      minScore: 0.6,
      onlyEmptyTargets: true,
      applyToAdded: true,
      applyToModified: true,
    );

    final canApply = rules.canApply(
      status: StringComparisonStatus.modified,
      currentTarget: 'Existing text',
      score: 0.8,
    );

    expect(canApply, isFalse);
  });
}
