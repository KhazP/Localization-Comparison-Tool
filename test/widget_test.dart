import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' hide ComparisonResult;
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppSettings', () {
    test('defaultSettings returns valid instance', () {
      final settings = AppSettings.defaultSettings();
      expect(settings.appLanguage, isNotEmpty);
      expect(settings.csvDelimiter, ',');
      expect(settings.ignoreCase, isTrue);
    });

    test('copyWith preserves other fields', () {
      final original = AppSettings.defaultSettings();
      final modified = original.copyWith(ignoreCase: false);
      expect(modified.ignoreCase, isFalse);
      expect(modified.csvDelimiter, original.csvDelimiter);
    });
  });

  group('ComparisonResult', () {
    test('diff contains expected entries', () {
      final diff = IMap<String, ComparisonStatusDetail>({
        'key1': const ComparisonStatusDetail.added(),
        'key2': const ComparisonStatusDetail.removed(),
        'key3': const ComparisonStatusDetail.modified(0.8),
        'key4': const ComparisonStatusDetail.identical(),
      });

      final result = ComparisonResult(
        {'key2': 'old', 'key3': 'hello', 'key4': 'same'},
        {'key1': 'new', 'key3': 'hola', 'key4': 'same'},
        diff,
      );

      expect(result.diff.length, 4);
      expect(result.file1Data['key2'], 'old');
      expect(result.file2Data['key1'], 'new');
    });
  });

  group('ComparisonStatusDetail', () {
    test('added creates correct type', () {
      const detail = ComparisonStatusDetail.added();
      expect(detail, isA<ComparisonStatusDetailAdded>());
    });

    test('removed creates correct type', () {
      const detail = ComparisonStatusDetail.removed();
      expect(detail, isA<ComparisonStatusDetailRemoved>());
    });

    test('modified stores similarity score', () {
      const detail = ComparisonStatusDetail.modified(0.75);
      expect(detail, isA<ComparisonStatusDetailModified>());
      expect((detail as ComparisonStatusDetailModified).similarity, 0.75);
    });

    test('identical creates correct type', () {
      const detail = ComparisonStatusDetail.identical();
      expect(detail, isA<ComparisonStatusDetailIdentical>());
    });
  });
}
