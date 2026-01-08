import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_enums.dart'; // Enum
import 'package:localizer_app_main/i18n/strings.g.dart';

class SimilaritySection extends StatelessWidget {
  const SimilaritySection({super.key});

  String _getFilterLabel(
      BuildContext context, AdvancedDiffSimilarityFilter filter) {
    switch (filter) {
      case AdvancedDiffSimilarityFilter.any:
        return context.t.advancedDiff.sidebar.similaritySection.any;
      case AdvancedDiffSimilarityFilter.high:
        return context.t.advancedDiff.sidebar.similaritySection.high;
      case AdvancedDiffSimilarityFilter.medium:
        return context.t.advancedDiff.sidebar.similaritySection.medium;
      case AdvancedDiffSimilarityFilter.low:
        return context.t.advancedDiff.sidebar.similaritySection.low;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvancedDiffController>(
      builder: (context, controller, child) {
        return Row(
          children: [
            Text(context.t.advancedDiff.sidebar.similaritySection.currentFilter,
                style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 8),
            DropdownButton<AdvancedDiffSimilarityFilter>(
              value: controller.similarityFilter,
              isDense: true,
              underline: const SizedBox(),
              items: AdvancedDiffSimilarityFilter.values.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(_getFilterLabel(context, e)),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  controller.similarityFilter = val;
                  controller.notifyListeners();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
