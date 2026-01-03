
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
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
            final path = await context.read<AdvancedDiffController>().exportData();
            if (path != null && context.mounted) {
              ToastService.showSuccessWithAction(
                context,
                'CSV exported',
                actionLabel: 'Open',
                onAction: () => OpenFile.open(path),
              );
            }
          },
          icon: const Icon(Icons.download, size: 16),
          label: const Text('Export matches'),
          style: TextButton.styleFrom(
            alignment: Alignment.centerLeft,
            foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
         TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.visibility, size: 16),
          label: const Text('Preview'),
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
                 title: const Text('Fill from Translation Memory?'),
                 content: const Text('This will attempt to fill empty target values using matches from the Translation Memory. Existing values will NOT be overwritten.'),
                 actions: [
                   TextButton(
                     onPressed: () => Navigator.of(context).pop(false),
                     child: const Text('Cancel'),
                   ),
                   FilledButton(
                     onPressed: () => Navigator.of(context).pop(true),
                     child: const Text('Fill'),
                   ),
                 ],
               ),
             );

             if (confirm == true && context.mounted) {
                 final controller = context.read<AdvancedDiffController>();
                 final count = await controller.fillMissingFromTM();
                 if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Filled $count items from Translation Memory.'))
                    );
                 }
             }
          },
          icon: const Icon(Icons.auto_fix_high, color: Colors.white),
          label: const Text('Fill from Memory', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[800],
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
