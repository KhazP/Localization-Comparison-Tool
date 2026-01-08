import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:open_file_plus/open_file_plus.dart';

class ActionsSection extends StatelessWidget {
  const ActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Export & Preview Row? Or stacked? Image shows them inline or stacked.
        // Image shows "Export matches" and "Preview" as lines.

        TextButton.icon(
          onPressed: () async {
            final path =
                await context.read<AdvancedDiffController>().exportData();
            if (path != null && context.mounted) {
              ToastService.showSuccessWithAction(
                context,
                context.t.advancedDiff.csvExported,
                actionLabel: context.t.common.open,
                onAction: () => OpenFile.open(path),
              );
            }
          },
          icon: const Icon(Icons.download, size: 16),
          label:
              Text(context.t.advancedDiff.sidebar.actionsSection.exportMatches),
          style: TextButton.styleFrom(
            alignment: Alignment.centerLeft,
            foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.visibility, size: 16),
          label: Text(context.t.advancedDiff.sidebar.actionsSection.preview),
          style: TextButton.styleFrom(
            alignment: Alignment.centerLeft,
            foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),

        const SizedBox(height: 12),

        ElevatedButton.icon(
          onPressed: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(context
                    .t.advancedDiff.sidebar.actionsSection.fillFromTmTitle),
                content: Text(context
                    .t.advancedDiff.sidebar.actionsSection.fillFromTmContent),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(context.t.common.cancel),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                        context.t.advancedDiff.sidebar.actionsSection.fill),
                  ),
                ],
              ),
            );

            if (confirm == true && context.mounted) {
              final controller = context.read<AdvancedDiffController>();
              final count = await controller.fillMissingFromTM();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(context.t.advancedDiff.sidebar.actionsSection
                        .filledFromTm(count: count))));
              }
            }
          },
          icon: const Icon(Icons.auto_fix_high, color: Colors.white),
          label: Text(
              context.t.advancedDiff.sidebar.actionsSection.fillFromMemory,
              style: const TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[800],
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
