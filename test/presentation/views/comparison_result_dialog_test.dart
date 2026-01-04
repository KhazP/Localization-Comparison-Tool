import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart'
    as engine;
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/presentation/views/comparison_result_dialog.dart';

void main() {
  testWidgets(
      'ComparisonResultDialog renders table with correct data and syntax highlighting',
      (WidgetTester tester) async {
    // 1. Setup Data
    final file1Data = {
      'section.key1': 'Source Value 1',
      'section.key2': 'Source Value 2'
    };
    final file2Data = {
      'section.key1': 'Target Value 1',
      'section.key3': 'Target Value 3'
    };
    final diff = IMap<String, ComparisonStatusDetail>({
      'section.key1': const ComparisonStatusDetail.modified(0.8),
      'section.key2': const ComparisonStatusDetail.removed(),
      'section.key3': const ComparisonStatusDetail.added(),
    });

    final result = engine.ComparisonResult(file1Data, file2Data, diff);

    // 2. Pump Widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ComparisonResultDialog(result: result),
      ),
    ));

    // 3. Verify Header
    expect(find.text('Comparison Details'), findsOneWidget);
    // Columns headers
    expect(find.text('Key'), findsOneWidget);
    expect(find.text('Source'), findsOneWidget);
    expect(find.text('Target'), findsOneWidget);
    expect(find.text('Status'), findsOneWidget);

    // 4. Verify Rows Data
    // Key 1 (Modified)
    expect(find.text('Source Value 1'), findsOneWidget);
    expect(find.text('Target Value 1'), findsOneWidget);

    // Key 2 (Removed)
    expect(find.text('Source Value 2'), findsOneWidget);

    // Key 3 (Added)
    expect(find.text('Target Value 3'), findsOneWidget);

    // 5. Verify Syntax Highlighting (RichText for keys)
    // We expect 'section.' to be one style and 'key1' to be another
    final richTextFinder = find.byType(RichText);
    expect(richTextFinder,
        findsWidgets); // Should have multiple RichText widgets for keys

    // Helper to check if a specific key part is present in RichText
    bool hasText(String text) {
      final richTexts = tester.widgetList<RichText>(richTextFinder);
      for (final widget in richTexts) {
        if (widget.text.toPlainText().contains(text)) {
          return true;
        }
      }
      return false;
    }

    expect(hasText('section.'), isTrue, reason: 'Path should be visible');
    expect(hasText('key1'), isTrue, reason: 'Key entry should be visible');
  });
}
