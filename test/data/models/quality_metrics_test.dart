import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/data/models/quality_metrics.dart';

void main() {
  group('CoverageMetrics', () {
    test('copyWith preserves other fields', () {
      const metric = CoverageMetrics(
        sourceKeyCount: 10,
        translatedKeyCount: 5,
        sourceWordCount: 100,
        translatedWordCount: 50,
      );

      final updated = metric.copyWith(sourceKeyCount: 20);

      expect(updated.sourceKeyCount, 20);
      expect(updated.translatedKeyCount, 5);
      expect(updated.sourceWordCount, 100);
      expect(updated.translatedWordCount, 50);
    });

    test('equality works correctly', () {
      const a = CoverageMetrics(
        sourceKeyCount: 10,
        translatedKeyCount: 5,
        sourceWordCount: 100,
        translatedWordCount: 50,
      );
      const b = CoverageMetrics(
        sourceKeyCount: 10,
        translatedKeyCount: 5,
        sourceWordCount: 100,
        translatedWordCount: 50,
      );

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
    });

    test('coveragePercent calculates correctly', () {
      const metric = CoverageMetrics(
        sourceKeyCount: 100,
        translatedKeyCount: 75,
        sourceWordCount: 1000,
        translatedWordCount: 750,
      );

      expect(metric.coveragePercent, 75.0);
    });

    test('coveragePercent returns 0 when source is empty', () {
      const metric = CoverageMetrics(
        sourceKeyCount: 0,
        translatedKeyCount: 0,
        sourceWordCount: 0,
        translatedWordCount: 0,
      );

      expect(metric.coveragePercent, 0.0);
    });
  });

  group('IssueMetrics', () {
    test('empty factory creates zeroed metrics', () {
      final empty = IssueMetrics.empty();

      expect(empty.totalIssues, 0);
      expect(empty.isEmpty, true);
      expect(empty.placeholderMismatchIssues, isEmpty);
    });
  });
}
