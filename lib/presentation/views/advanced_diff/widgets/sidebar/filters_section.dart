import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';

import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_enums.dart';

class FiltersSection extends StatelessWidget {
  const FiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvancedDiffController>(
      builder: (context, controller, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('View Filters',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            _buildCheckbox(
              'Show All',
              controller.selectedFilters.contains(AdvancedDiffFilter.all),
              (v) => controller.toggleViewFilter(AdvancedDiffFilter.all),
            ),
            _buildCheckbox(
              'Added',
              controller.selectedFilters.contains(AdvancedDiffFilter.added),
              (v) => controller.toggleViewFilter(AdvancedDiffFilter.added),
            ),
            _buildCheckbox(
              'Removed',
              controller.selectedFilters.contains(AdvancedDiffFilter.removed),
              (v) => controller.toggleViewFilter(AdvancedDiffFilter.removed),
            ),
            _buildCheckbox(
              'Modified',
              controller.selectedFilters.contains(AdvancedDiffFilter.modified),
              (v) => controller.toggleViewFilter(AdvancedDiffFilter.modified),
            ),
            const Divider(height: 24),
            const Text('Action Scope',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            _buildCheckbox(
              'Apply to Added',
              controller.applyToAdded,
              (v) {
                controller.applyToAdded = v;
                controller.notifyListeners();
              },
            ),
            _buildCheckbox(
              'Apply to Modified',
              controller.applyToModified,
              (v) {
                controller.applyToModified = v;
                controller.notifyListeners();
              },
            ),
            _buildCheckbox(
              'Only fill empty targets',
              controller.onlyFillEmpty,
              (v) {
                controller.onlyFillEmpty = v;
                controller.notifyListeners();
              },
            ),
            _buildCheckbox(
              'Limit to visible',
              controller.limitToVisible,
              (v) {
                controller.limitToVisible = v;
                controller.notifyListeners();
              },
            ),
            const Divider(height: 24),
            const Text('Edit Mode',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Dialog', style: TextStyle(fontSize: 12)),
                    selected: !controller.useInlineEditing,
                    onSelected: (_) => controller.setInlineEditing(false),
                    selectedColor:
                        Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Inline', style: TextStyle(fontSize: 12)),
                    selected: controller.useInlineEditing,
                    onSelected: (_) => controller.setInlineEditing(true),
                    selectedColor:
                        Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: value,
            activeColor: Colors.orange,
            onChanged: (v) => onChanged(v ?? false),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
