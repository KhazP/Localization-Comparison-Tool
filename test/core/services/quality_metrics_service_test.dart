import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/core/services/quality_metrics_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';

void main() {
  group('QualityMetricsService', () {
    test('calculates coverage counts from maps', () {
      final service = QualityMetricsService();
      final settings = AppSettings.defaultSettings();
      final sourceData = {
        'hello': 'Hello world',
        'bye': 'Goodbye',
      };
      final targetData = {
        'hello': 'Hola mundo',
        'bye': '',
      };

      final coverage = service.calculateCoverageFromMaps(
        sourceData: sourceData,
        targetData: targetData,
        settings: settings,
      );

      expect(coverage.sourceKeyCount, 2);
      expect(coverage.translatedKeyCount, 1);
      expect(coverage.sourceWordCount, 3);
      expect(coverage.translatedWordCount, 2);
    });

    test('detects placeholder, length, and duplicate issues', () {
      final service = QualityMetricsService();
      final settings = AppSettings.defaultSettings();
      final sourceData = {
        'greeting': 'Hello {name}',
        'short': 'Welcome to the app',
        'duplicate1': 'Save',
        'duplicate2': 'Cancel',
      };
      final targetData = {
        'greeting': 'Hola {nombre}',
        'short': 'Ok',
        'duplicate1': 'Guardar',
        'duplicate2': 'Guardar',
      };

      final issues = service.detectIssuesFromMaps(
        sourceData: sourceData,
        targetData: targetData,
        settings: settings,
      );

      expect(issues.placeholderMismatchCount, 1);
      expect(issues.lengthOutlierCount, 1);
      expect(issues.duplicateValueCount, 2);
    });
  });
}
