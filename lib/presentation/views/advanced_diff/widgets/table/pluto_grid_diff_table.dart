import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/'
    'advanced_diff_controller.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/'
    'table/pluto_grid_adapter.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/'
    'dialogs/detail_edit_dialog.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/presentation/utils/ai_error_mapper.dart';
import 'package:localizer_app_main/presentation/widgets/dialogs/'
    'ai_suggestion_dialog.dart';

/// Excel-like data grid for the Advanced Diff View using PlutoGrid.
///
/// Features:
/// - Frozen Key and Source columns
/// - Toggle between inline and dialog editing
/// - Keyboard navigation (arrow keys, Tab, Enter)
/// - Copy-paste support (Ctrl+C)
/// - Bulk action support for selected rows
/// - Visual highlights for modified cells
/// - Auto-expanding columns
class PlutoGridDiffTable extends StatefulWidget {
  const PlutoGridDiffTable({super.key});

  @override
  State<PlutoGridDiffTable> createState() => _PlutoGridDiffTableState();
}

class _PlutoGridDiffTableState extends State<PlutoGridDiffTable> {
  PlutoGridStateManager? _stateManager;
  List<PlutoRow> _rows = [];
  List<PlutoColumn> _columns = [];
  bool _initialized = false;
  AdvancedDiffController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = context.read<AdvancedDiffController>();
    if (_controller != controller) {
      _controller?.removeListener(_handleControllerUpdate);
      _controller = controller;
      _controller?.addListener(_handleControllerUpdate);
    }
    if (!_initialized) {
      _initializeGrid();
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_handleControllerUpdate);
    super.dispose();
  }

  void _initializeGrid() {
    final controller = context.read<AdvancedDiffController>();
    _updateGridData(
      controller,
      isCloudTranslation: _isCloudTranslationFromSettings(),
    );
  }

  void _handleControllerUpdate() {
    final controller = _controller;
    if (!mounted || controller == null) return;

    _updateGridData(
      controller,
      isCloudTranslation: _isCloudTranslationFromSettings(),
    );

    if (_stateManager == null) {
      setState(() {});
      return;
    }

    if (_stateManager?.isEditing == true) {
      return;
    }

    _stateManager?.removeAllRows();
    _stateManager?.appendRows(_rows);
    _stateManager?.notifyListeners();
    setState(() {});
  }

  void _updateGridData(
    AdvancedDiffController controller, {
    required bool isCloudTranslation,
  }) {
    _columns = PlutoGridAdapter.createColumns(
      context: context,
      isCloudTranslation: isCloudTranslation,
      onAddToTM: (key) => _handleAddToTM(controller, key),
      onMarkReviewed: (key) => _handleMarkReviewed(controller, key),
      onRevert: (key) => _handleRevert(controller, key),
      onDelete: (key) => _handleDelete(controller, key),
      onAiTranslate: (key) => _handleAiTranslate(controller, key),
      onAiSuggest: (key) => _handleAiSuggest(controller, key),
      onAiRephrase: (key) => _handleAiRephrase(controller, key),
      reviewedKeys: controller.reviewedKeys,
      useInlineEditing: controller.useInlineEditing,
      onEditCell: (key) => _showEditDialog(controller, key),
    );

    _rows = PlutoGridAdapter.createRows(
      context: context,
      entries: controller.processedEntries,
      sourceData: controller.sourceData,
      targetData: controller.targetData,
      dirtyKeys: controller.dirtyKeys,
    );
  }

  void _handleAddToTM(AdvancedDiffController controller, String key) {
    final source = controller.getSourceValue(key);
    final target = controller.getTargetValue(key);
    controller.addToTM(key, source, target);
    ToastService.showSuccess(context, context.t.advancedDiff.table.addedToTM);
  }

  void _handleMarkReviewed(AdvancedDiffController controller, String key) {
    final wasReviewed = controller.reviewedKeys.contains(key);
    controller.toggleReviewed(key);
    _refreshGrid(controller);
    // Provide immediate visual feedback
    if (!wasReviewed) {
      ToastService.showSuccess(
          context, context.t.advancedDiff.table.markedReviewed);
    } else {
      ToastService.showInfo(
          context, context.t.advancedDiff.table.unmarkedReview);
    }
  }

  void _handleRevert(AdvancedDiffController controller, String key) {
    controller.revertEntry(key);
    _refreshGrid(controller);
    ToastService.showSuccess(context, context.t.advancedDiff.table.reverted);
  }

  void _handleDelete(AdvancedDiffController controller, String key) {
    controller.deleteEntry(key);
    _refreshGrid(controller);
    ToastService.showSuccess(
        context, context.t.advancedDiff.table.entryDeleted);
  }

  void _refreshGrid(AdvancedDiffController controller) {
    setState(() {
      _updateGridData(
        controller,
        isCloudTranslation: _isCloudTranslationFromSettings(),
      );
    });
  }

  Future<void> _handleAiTranslate(
    AdvancedDiffController controller,
    String key,
  ) async {
    final isCloud = _isCloudTranslationFromSettings();
    await _runTranslationSuggestion(
      controller,
      key,
      titleOverride: _translationTitle(isCloud),
      successMessage: _translationAppliedMessage(isCloud),
    );
  }

  Future<void> _handleAiSuggest(
    AdvancedDiffController controller,
    String key,
  ) async {
    final isCloud = _isCloudTranslationFromSettings();
    await _runTranslationSuggestion(
      controller,
      key,
      titleOverride: _translationTitle(isCloud),
      successMessage: _suggestionAppliedMessage(isCloud),
    );
  }

  Future<void> _runTranslationSuggestion(
    AdvancedDiffController controller,
    String key, {
    String? titleOverride,
    required String successMessage,
  }) async {
    final sourceValue = controller.getSourceValue(key);
    if (sourceValue.trim().isEmpty) {
      ToastService.showInfo(context, context.t.advancedDiff.table.noSourceText);
      return;
    }

    try {
      final suggestion = await controller.suggestTranslation(key);
      if (!context.mounted) return;

      final decision = await AiSuggestionDialog.showForTranslation(
        context,
        keyName: key,
        suggestion: suggestion,
        titleOverride: titleOverride,
      );

      if (!context.mounted || decision == null) return;
      if (decision.action == AiSuggestionAction.accept &&
          decision.text != null) {
        controller.applyAiSuggestion(key, decision.text!);
        _refreshGrid(controller);
        ToastService.showSuccess(context, successMessage);
      }
    } catch (e, stackTrace) {
      sl<TalkerService>().handle(
        e,
        stackTrace,
        'AI translation failed for "$key"',
      );
      if (context.mounted) {
        ToastService.showError(
          context,
          aiUserMessageForError(e),
          onRetry: () => _runTranslationSuggestion(
            controller,
            key,
            titleOverride: titleOverride,
            successMessage: successMessage,
          ),
        );
      }
    }
  }

  Future<void> _handleAiRephrase(
    AdvancedDiffController controller,
    String key,
  ) async {
    final targetValue = controller.getTargetValue(key);
    if (targetValue.trim().isEmpty) {
      ToastService.showInfo(context, context.t.advancedDiff.table.noTargetText);
      return;
    }

    try {
      final result = await controller.rephraseTarget(key);
      if (!context.mounted) return;

      final isCloud = _isCloudTranslationFromSettings();
      final decision = await AiSuggestionDialog.showForRephrase(
        context,
        keyName: key,
        result: result,
        titleOverride: _rephraseTitle(isCloud),
      );

      if (!context.mounted || decision == null) return;
      if (decision.action == AiSuggestionAction.accept &&
          decision.text != null) {
        controller.applyAiSuggestion(key, decision.text!);
        _refreshGrid(controller);
        ToastService.showSuccess(context, _rephraseAppliedMessage(isCloud));
      }
    } catch (e, stackTrace) {
      sl<TalkerService>().handle(
        e,
        stackTrace,
        'AI rephrase failed for "$key"',
      );
      if (context.mounted) {
        ToastService.showError(
          context,
          aiUserMessageForError(e),
          onRetry: () => _handleAiRephrase(controller, key),
        );
      }
    }
  }

  void _handleCellChanged(PlutoGridOnChangedEvent event) {
    if (event.column.field == 'target') {
      final controller = context.read<AdvancedDiffController>();
      final key = event.row.cells['key']?.value as String?;
      final newValue = event.value?.toString() ?? '';

      if (key != null && key.isNotEmpty) {
        controller.updateEntry(key, newValue);
        // Mark the row as modified visually
        event.row.cells['_isModified']?.value = true;
      }
    }
  }

  /// Shows the edit dialog for dialog mode editing
  Future<void> _showEditDialog(
      AdvancedDiffController controller, String key) async {
    final source = controller.getSourceValue(key);
    final target = controller.getTargetValue(key);

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => DetailEditDialog(
        keyName: key,
        sourceValue: source,
        targetValue: target,
        fileExtension: controller.targetFileExtension,
        onSave: (newValue) {
          // Basic update
          if (newValue != target) {
            controller.updateEntry(key, newValue);
            controller.addToTM(key, source, newValue);
            _refreshGrid(controller);
          }
        },
      ),
    );
  }

  void _handleBulkMarkReviewed() {
    final controller = context.read<AdvancedDiffController>();
    // Use checkedRows from checkbox selection
    final checkedRows = _stateManager?.checkedRows ?? [];

    if (checkedRows.isEmpty) {
      ToastService.showInfo(
          context, context.t.advancedDiff.table.checkRowsFirst);
      return;
    }

    for (final row in checkedRows) {
      final key = row.cells['key']?.value as String?;
      if (key != null) {
        controller.toggleReviewed(key);
      }
    }

    // Uncheck all rows after action
    _stateManager?.toggleAllRowChecked(false);
    _refreshGrid(controller);
    ToastService.showSuccess(
        context,
        context.t.advancedDiff.table
            .markedRowsReviewed(count: checkedRows.length));
  }

  void _handleBulkRevert() {
    final controller = context.read<AdvancedDiffController>();
    // Use checkedRows from checkbox selection
    final checkedRows = _stateManager?.checkedRows ?? [];

    if (checkedRows.isEmpty) {
      ToastService.showInfo(
          context, context.t.advancedDiff.table.checkRowsFirst);
      return;
    }

    for (final row in checkedRows) {
      final key = row.cells['key']?.value as String?;
      if (key != null) {
        controller.revertEntry(key);
      }
    }

    // Uncheck all rows after action
    _stateManager?.toggleAllRowChecked(false);
    _refreshGrid(controller);
    ToastService.showSuccess(context,
        context.t.advancedDiff.table.revertedRows(count: checkedRows.length));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCloud = _isCloudStrategy(
      context.watch<SettingsBloc>().state.appSettings.translationStrategy,
    );

    return Consumer<AdvancedDiffController>(
      builder: (context, controller, _) {
        // Rebuild columns and rows when controller changes
        _columns = PlutoGridAdapter.createColumns(
          context: context,
          isCloudTranslation: isCloud,
          onAddToTM: (key) => _handleAddToTM(controller, key),
          onMarkReviewed: (key) => _handleMarkReviewed(controller, key),
          onRevert: (key) => _handleRevert(controller, key),
          onDelete: (key) => _handleDelete(controller, key),
          onAiTranslate: (key) => _handleAiTranslate(controller, key),
          onAiSuggest: (key) => _handleAiSuggest(controller, key),
          onAiRephrase: (key) => _handleAiRephrase(controller, key),
          reviewedKeys: controller.reviewedKeys,
          useInlineEditing: controller.useInlineEditing,
          onEditCell: (key) => _showEditDialog(controller, key),
        );

        _rows = PlutoGridAdapter.createRows(
          context: context,
          entries: controller.processedEntries,
          sourceData: controller.sourceData,
          targetData: controller.targetData,
          dirtyKeys: controller.dirtyKeys,
        );

        return Column(
          children: [
            // Bulk Actions Toolbar
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: theme.cardColor,
                border: Border(bottom: BorderSide(color: theme.dividerColor)),
              ),
              child: Row(
                children: [
                  Text(
                    context.t.advancedDiff.table.entriesCount(
                        count: controller.processedEntries.length),
                    style: theme.textTheme.bodySmall,
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _handleBulkMarkReviewed,
                    icon: const Icon(Icons.check_circle_outline, size: 16),
                    label:
                        Text(context.t.advancedDiff.table.markSelectedReviewed),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: _handleBulkRevert,
                    icon: const Icon(Icons.undo, size: 16),
                    label: Text(context.t.advancedDiff.table.revertSelected),
                  ),
                ],
              ),
            ),
            // PlutoGrid
            Expanded(
              child: _rows.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.compare_arrows,
                            size: 64,
                            color: theme.disabledColor,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            context.t.advancedDiff.table.noDifferences,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.disabledColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            context.t.advancedDiff.table.adjustFilters,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : PlutoGrid(
                      // Key forces rebuild when edit mode changes
                      key: ValueKey(
                          'pluto_grid_inline_${controller.useInlineEditing}'),
                      columns: _columns,
                      rows: _rows,
                      onLoaded: (PlutoGridOnLoadedEvent event) {
                        _stateManager = event.stateManager;
                        // Enable row selection for bulk actions
                        _stateManager
                            ?.setSelectingMode(PlutoGridSelectingMode.row);
                      },
                      onChanged: _handleCellChanged,
                      mode: PlutoGridMode.normal,
                      configuration: PlutoGridConfiguration(
                        // Style
                        style: PlutoGridStyleConfig(
                          gridBackgroundColor: theme.scaffoldBackgroundColor,
                          rowColor: theme.cardColor,
                          activatedColor:
                              theme.colorScheme.primary.withValues(alpha: 0.05),
                          activatedBorderColor:
                              theme.colorScheme.primary.withValues(alpha: 0.3),
                          gridBorderColor: theme.dividerColor,
                          borderColor: theme.dividerColor,
                          // Make edit cell seamless - same as row background
                          cellColorInEditState: theme.cardColor,
                          cellColorInReadOnlyState: theme.cardColor,
                          // Match font size for editing (12px like display)
                          cellTextStyle: TextStyle(
                            fontSize: 12,
                            fontFamily: 'RobotoMono',
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                          columnTextStyle:
                              (theme.textTheme.titleSmall ?? const TextStyle())
                                  .copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          iconColor: theme.iconTheme.color ?? Colors.grey,
                          enableCellBorderVertical: true,
                          enableCellBorderHorizontal: true,
                          enableColumnBorderVertical: true,
                          oddRowColor: theme.brightness == Brightness.dark
                              ? Colors.white.withValues(alpha: 0.02)
                              : Colors.black.withValues(alpha: 0.02),
                          // Taller rows for multi-line text
                          rowHeight: 84,
                          columnHeight: 48,
                          defaultCellPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                        // Column settings - auto expand to fill width
                        columnSize: const PlutoGridColumnSizeConfig(
                          autoSizeMode: PlutoAutoSizeMode.scale,
                          resizeMode: PlutoResizeMode.normal,
                        ),
                        // Editing - enable on single tap/click
                        enterKeyAction:
                            PlutoGridEnterKeyAction.editingAndMoveDown,
                        // Scrollbar
                        scrollbar: const PlutoGridScrollbarConfig(
                          isAlwaysShown: true,
                          scrollbarThickness: 8,
                          scrollbarThicknessWhileDragging: 10,
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  bool _isCloudTranslationFromSettings() {
    final strategy =
        context.read<SettingsBloc>().state.appSettings.translationStrategy;
    return _isCloudStrategy(strategy);
  }

  bool _isCloudStrategy(String value) {
    return value.toLowerCase().contains('cloud');
  }

  String _translationTitle(bool isCloud) {
    return isCloud
        ? context.t.advancedDiff.sidebar.cloudTranslation
        : context.t.advancedDiff.sidebar.aiTranslation;
  }

  String _rephraseTitle(bool isCloud) {
    return isCloud
        ? context.t.advancedDiff.table.rephrase
        : context.t.advancedDiff.table.aiRephrase;
  }

  String _translationAppliedMessage(bool isCloud) {
    return isCloud
        ? context.t.advancedDiff.table.cloudTranslationApplied
        : context.t.advancedDiff.table.aiTranslationApplied;
  }

  String _suggestionAppliedMessage(bool isCloud) {
    return isCloud
        ? context.t.advancedDiff.table.suggestionApplied
        : context.t.advancedDiff.table.aiSuggestionApplied;
  }

  String _rephraseAppliedMessage(bool isCloud) {
    return isCloud
        ? context.t.advancedDiff.table.rephraseApplied
        : context.t.advancedDiff.table.aiRephraseApplied;
  }
}
