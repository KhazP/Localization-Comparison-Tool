import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_enums.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';

class FiltersSection extends StatelessWidget {
  const FiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvancedDiffController>(
      builder: (context, controller, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.t.advancedDiff.sidebar.filtersSection.viewFilters,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            _buildCheckbox(
              context.t.advancedDiff.sidebar.filtersSection.showAll,
              controller.selectedFilters.contains(AdvancedDiffFilter.all),
              (v) => controller.toggleViewFilter(AdvancedDiffFilter.all),
            ),
            _buildCheckbox(
              context.t.advancedDiff.sidebar.filtersSection.added,
              controller.selectedFilters.contains(AdvancedDiffFilter.added),
              (v) => controller.toggleViewFilter(AdvancedDiffFilter.added),
            ),
            _buildCheckbox(
              context.t.advancedDiff.sidebar.filtersSection.removed,
              controller.selectedFilters.contains(AdvancedDiffFilter.removed),
              (v) => controller.toggleViewFilter(AdvancedDiffFilter.removed),
            ),
            _buildCheckbox(
              context.t.advancedDiff.sidebar.filtersSection.modified,
              controller.selectedFilters.contains(AdvancedDiffFilter.modified),
              (v) => controller.toggleViewFilter(AdvancedDiffFilter.modified),
            ),
            const Divider(height: 24),
            Text(context.t.advancedDiff.sidebar.filtersSection.actionScope,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            _buildCheckbox(
              context.t.advancedDiff.sidebar.filtersSection.applyToAdded,
              controller.applyToAdded,
              (v) {
                controller.applyToAdded = v;
                controller.notifyListeners();
              },
            ),
            _buildCheckbox(
              context.t.advancedDiff.sidebar.filtersSection.applyToModified,
              controller.applyToModified,
              (v) {
                controller.applyToModified = v;
                controller.notifyListeners();
              },
            ),
            _buildCheckbox(
              context
                  .t.advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets,
              controller.onlyFillEmpty,
              (v) {
                controller.onlyFillEmpty = v;
                controller.notifyListeners();
              },
            ),
            _buildCheckbox(
              context.t.advancedDiff.sidebar.filtersSection.limitToVisible,
              controller.limitToVisible,
              (v) {
                controller.limitToVisible = v;
                controller.notifyListeners();
              },
            ),
            const Divider(height: 24),
            Text(context.t.advancedDiff.sidebar.filtersSection.editMode,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: Text(
                        context.t.advancedDiff.sidebar.filtersSection.dialog,
                        style: const TextStyle(fontSize: 12)),
                    selected: !controller.useInlineEditing,
                    onSelected: (_) {
                      controller.setInlineEditing(false);
                      context.read<SettingsBloc>().add(
                            const UpdateAdvancedDiffEditMode(false),
                          );
                    },
                    selectedColor:
                        Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ChoiceChip(
                    label: Text(
                        context.t.advancedDiff.sidebar.filtersSection.inline,
                        style: const TextStyle(fontSize: 12)),
                    selected: controller.useInlineEditing,
                    onSelected: (_) {
                      controller.setInlineEditing(true);
                      context.read<SettingsBloc>().add(
                            const UpdateAdvancedDiffEditMode(true),
                          );
                    },
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
