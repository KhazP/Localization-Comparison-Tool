import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/advanced_diff_sidebar.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/table/pluto_grid_diff_table.dart';
import 'package:localizer_app_main/core/input/app_intents.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:open_file_plus/open_file_plus.dart';

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

  void _handleSaveChanges(
      BuildContext context, AdvancedDiffController controller) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t.advancedDiff.saveAllChanges),
        content: Text(context.t.advancedDiff
            .saveConfirmation(count: controller.dirtyKeys.length)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.t.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.t.common.save),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      final settings = context.read<SettingsBloc>().state.appSettings;
      await controller.saveChanges(widget.targetFile, settings);
      if (context.mounted) {
        ToastService.showSuccess(context, context.t.advancedDiff.changesSaved);
      }
    }
  }

  Future<void> _handleExport(
      BuildContext context, AdvancedDiffController controller) async {
    final path = await controller.exportData();
    if (path != null && context.mounted) {
      ToastService.showSuccessWithAction(
        context,
        context.t.advancedDiff.csvExported,
        actionLabel: context.t.common.open,
        onAction: () => OpenFile.open(path),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final settings = context.read<SettingsBloc>().state.appSettings;
        return AdvancedDiffController(
          // Convert IMap to mutable Map for editing (controller mutates this)
          fullDiff: Map<String, ComparisonStatusDetail>.from(
              widget.comparisonResult.diff.unlock),
          // Create copies so discarding changes doesn't mutate original
          sourceData:
              Map<String, String>.from(widget.comparisonResult.file1Data),
          targetData:
              Map<String, String>.from(widget.comparisonResult.file2Data),
          targetFilePath: widget.targetFile.path,
          sourceFileExtension: p.extension(widget.sourceFile.path),
          targetFileExtension: p.extension(widget.targetFile.path),
          initialUseInlineEditing: settings.advancedDiffUseInlineEditing,
          project: context.read<ProjectBloc>().state.currentProject,
        );
      },
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
                const SingleActivator(LogicalKeyboardKey.arrowUp, alt: true):
                    () {
                  controller.previousPage();
                  // ToastService.showInfo(context, 'Previous Page');
                },
                const SingleActivator(LogicalKeyboardKey.arrowDown, alt: true):
                    () {
                  controller.nextPage();
                  // ToastService.showInfo(context, 'Next Page');
                },
              },
              child: PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) async {
                  if (didPop) return;

                  if (controller.dirtyKeys.isNotEmpty) {
                    final shouldPop = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(context.t.advancedDiff.unsavedChanges),
                        content:
                            Text(context.t.advancedDiff.unsavedChangesWarning),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(context.t.common.cancel),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.red),
                            child: Text(context.t.advancedDiff.discardChanges),
                          ),
                        ],
                      ),
                    );

                    if (shouldPop == true && context.mounted) {
                      Navigator.pop(context);
                    }
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Scaffold(
                  body: Column(
                    children: [
                      // Toolbar
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        color: Theme.of(context).cardColor,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(LucideIcons.arrowLeft, size: 24),
                              onPressed: () => Navigator.maybePop(context),
                              tooltip: context.t.advancedDiff.goBack,
                              padding: const EdgeInsets.all(8),
                            ),
                            const SizedBox(width: 4),
                            Text(context.t.advancedDiff.breadcrumbs),
                            const Spacer(),
                            // Unsaved changes indicator
                            if (controller.dirtyKeys.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.orange.withValues(alpha: 0.4),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      context.t.advancedDiff.unsaved(
                                          count: controller.dirtyKeys.length),
                                      style: TextStyle(
                                        color: Colors.orange[800],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            // Reviewed count indicator
                            if (controller.reviewedKeys.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: Colors.green.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.check_circle,
                                        size: 14, color: Colors.green[600]),
                                    const SizedBox(width: 4),
                                    Text(
                                      context.t.advancedDiff.reviewed(
                                          count:
                                              controller.reviewedKeys.length),
                                      style: TextStyle(
                                        color: Colors.green[700],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Tooltip(
                              message: context.t.advancedDiff.saveAllTooltip,
                              child: FilledButton(
                                  onPressed: controller.dirtyKeys.isEmpty
                                      ? null
                                      : () => _handleSaveChanges(
                                          context, controller),
                                  child: Text(controller.dirtyKeys.isEmpty
                                      ? context.t.advancedDiff.allSaved
                                      : context.t.advancedDiff.saveAll(
                                          count: controller.dirtyKeys.length))),
                            ),
                            const SizedBox(width: 8),
                            Tooltip(
                              message: context.t.advancedDiff.exportTooltip,
                              child: OutlinedButton(
                                  onPressed: () =>
                                      _handleExport(context, controller),
                                  child: Text(context.t.common.export)),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: Row(
                          children: [
                            AdvancedDiffSidebar(
                                searchFocusNode: _searchFocusNode),
                            VerticalDivider(
                                width: 1,
                                color: Theme.of(context).dividerColor),
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
            ),
          );
        },
      ),
    );
  }
}
