
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/advanced_diff_sidebar.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/table/pluto_grid_diff_table.dart';
import 'package:localizer_app_main/core/input/app_intents.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';

class AdvancedDiffView extends StatefulWidget {
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
  State<AdvancedDiffView> createState() => _AdvancedDiffViewState();
}

class _AdvancedDiffViewState extends State<AdvancedDiffView> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleSaveChanges(BuildContext context, AdvancedDiffController controller) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Changes?'),
        content: const Text(
            'This will overwrite the target file with the current values in the editor. This action cannot be undone.'),
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
      await controller.saveChanges(widget.targetFile, settings);
      if (context.mounted) {
        ToastService.showSuccess(context, 'Changes saved successfully.');
      }
    }
  }

  Future<void> _handleExport(BuildContext context, AdvancedDiffController controller) async {
    await controller.exportData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdvancedDiffController(
        fullDiff: widget.comparisonResult.diff,
        file1Data: widget.comparisonResult.file1Data,
        file2Data: widget.comparisonResult.file2Data,
        sourceFileExtension: p.extension(widget.sourceFile.path),
        targetFileExtension: p.extension(widget.targetFile.path),
      ),
      child: Consumer<AdvancedDiffController>(
        builder: (context, controller, child) {
          return Actions(
            actions: {
              FocusSearchIntent: CallbackAction<FocusSearchIntent>(
                onInvoke: (intent) {
                  _searchFocusNode.requestFocus();
                  return null;
                },
              ),
              SaveIntent: CallbackAction<SaveIntent>(
                onInvoke: (intent) {
                  _handleSaveChanges(context, controller);
                  return null;
                },
              ),
              ExportIntent: CallbackAction<ExportIntent>(
                onInvoke: (intent) {
                  _handleExport(context, controller);
                  return null;
                },
              ),
            },
            child: CallbackShortcuts(
              bindings: {
                const SingleActivator(LogicalKeyboardKey.arrowUp, alt: true): () {
                  controller.previousPage();
                  // ToastService.showInfo(context, 'Previous Page');
                },
                const SingleActivator(LogicalKeyboardKey.arrowDown, alt: true): () {
                  controller.nextPage();
                  // ToastService.showInfo(context, 'Next Page');
                },
              },
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Advanced Localization Editor'),
                  actions: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          focusNode: _searchFocusNode,
                          decoration: InputDecoration(
                            hintText: 'Search keys & values... (Ctrl+F)',
                            prefixIcon: const Icon(LucideIcons.search, size: 18),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          onChanged: (value) {
                            controller.updateSearch(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
                body: Column(
                  children: [
                    // Toolbar
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      color: Theme.of(context).cardColor,
                      child: Row(
                        children: [
                          const Icon(LucideIcons.arrowLeft, size: 16),
                          const SizedBox(width: 8),
                          const Text('Home  >  Diff View'),
                          const Spacer(),
                          Tooltip(
                            message: 'Save Changes (Ctrl+S)',
                            child: FilledButton(
                                onPressed: () => _handleSaveChanges(context, controller), 
                                child: const Text('Save Changes')
                            ),
                          ),
                          const SizedBox(width: 8),
                          Tooltip(
                            message: 'Export Data (Ctrl+E)',
                            child: OutlinedButton(
                                onPressed: () => _handleExport(context, controller), 
                                child: const Text('Export')
                            ),
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
                            child: PlutoGridDiffTable(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
