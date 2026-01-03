import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_enums.dart'; // Enum

class SimilaritySection extends StatelessWidget {
  const SimilaritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvancedDiffController>(
      builder: (context, controller, child) {
        return Row(
          children: [
            const Text('Current Filter:', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 8),
            DropdownButton<AdvancedDiffSimilarityFilter>(
              value: controller.similarityFilter,
              isDense: true,
              underline: const SizedBox(),
              items: AdvancedDiffSimilarityFilter.values.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e.name.toUpperCase()),
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
