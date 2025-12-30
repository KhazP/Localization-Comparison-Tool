
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/advanced_diff_sidebar.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart'; // Import SettingsBloc
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/table/diff_data_table.dart';

class AdvancedDiffView extends StatelessWidget {
  final ComparisonResult comparisonResult;
  final File sourceFile;
  final File targetFile;

  const AdvancedDiffView({
    super.key,
    required this.comparisonResult,
    required this.sourceFile,
    required this.targetFile,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdvancedDiffController(
        fullDiff: comparisonResult.diff,
        file1Data: comparisonResult.file1Data,
        file2Data: comparisonResult.file2Data,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advanced Localization Editor'),
          actions: [
            // Global Actions
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8.0),
               child: SizedBox(
                   width: 300,
                   child: Builder(
                     builder: (context) {
                       return TextField(
                         decoration: InputDecoration(
                           hintText: 'Search keys & values...',
                           prefixIcon: const Icon(Icons.search), 
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                           contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                         ),
                         onChanged: (value) {
                           context.read<AdvancedDiffController>().updateSearch(value);
                         },
                       );
                     }
                   ),
               ),
             ),
             const SizedBox(width: 16),
             const SizedBox(width: 16),
             // const SizedBox(width: 8), // Debug removed
             // const SizedBox(width: 16),
             const SizedBox(width: 16),
          ],
        ),
        body: Column(
          children: [
             // Breadcrumb / Secondary Toolbar
             Container(
               height: 40,
               padding: const EdgeInsets.symmetric(horizontal: 16),
               color: Theme.of(context).cardColor,
               child: Row(
                 children: [
                   const Icon(Icons.arrow_back, size: 16),
                   const SizedBox(width: 8),
                   const Text('Home  >  Diff View: en -> tr'),
                   const Spacer(),
                   FilledButton(
                     onPressed: () async {
                       final confirm = await showDialog<bool>(
                         context: context,
                         builder: (context) => AlertDialog(
                           title: const Text('Save Changes?'),
                           content: const Text('This will overwrite the target file with the current values in the editor. This action cannot be undone.'),
                           actions: [
                             TextButton(
                               onPressed: () => Navigator.of(context).pop(false),
                               child: const Text('Cancel'),
                             ),
                             FilledButton(
                               onPressed: () => Navigator.of(context).pop(true),
                               child: const Text('Save'),
                             ),
                           ],
                         ),
                       );

                       if (confirm == true && context.mounted) {
                         final settings = context.read<SettingsBloc>().state.appSettings;
                         await context.read<AdvancedDiffController>().saveChanges(targetFile, settings);
                         if (context.mounted) {
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes saved.')));
                         }
                       }
                     }, 
                     child: const Text('Save Changes')
                   ),
                   const SizedBox(width: 8),
                   OutlinedButton(
                     onPressed: () {
                       context.read<AdvancedDiffController>().exportData();
                     }, 
                     child: const Text('Export')
                   ),
                 ],
               ),
             ),
             const Divider(height: 1),
            Expanded(
              child: Row(
                children: [
                  const AdvancedDiffSidebar(),
                   VerticalDivider(width: 1, color: Theme.of(context).dividerColor),
                  const Expanded(
                    child: DiffDataTable(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
