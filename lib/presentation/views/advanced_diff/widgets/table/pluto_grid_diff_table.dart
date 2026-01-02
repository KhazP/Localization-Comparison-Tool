import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/table/pluto_grid_adapter.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initializeGrid();
      _initialized = true;
    }
  }

  void _initializeGrid() {
    final controller = context.read<AdvancedDiffController>();
    _updateGridData(controller);
  }

  void _updateGridData(AdvancedDiffController controller) {
    _columns = PlutoGridAdapter.createColumns(
      context: context,
      onAddToTM: (key) => _handleAddToTM(controller, key),
      onMarkReviewed: (key) => _handleMarkReviewed(controller, key),
      onRevert: (key) => _handleRevert(controller, key),
      onDelete: (key) => _handleDelete(controller, key),
      reviewedKeys: controller.reviewedKeys,
      useInlineEditing: controller.useInlineEditing,
      onEditCell: (key) => _showEditDialog(controller, key),
    );

    _rows = PlutoGridAdapter.createRows(
      entries: controller.processedEntries,
      sourceData: controller.file1Data,
      targetData: controller.file2Data,
      dirtyKeys: controller.dirtyKeys,
    );
  }

  void _handleAddToTM(AdvancedDiffController controller, String key) {
    final source = controller.getSourceValue(key);
    final target = controller.getTargetValue(key);
    controller.addToTM(key, source, target);
    ToastService.showSuccess(context, 'Added to Translation Memory');
  }

  void _handleMarkReviewed(AdvancedDiffController controller, String key) {
    controller.toggleReviewed(key);
    _refreshGrid(controller);
  }

  void _handleRevert(AdvancedDiffController controller, String key) {
    controller.revertEntry(key);
    _refreshGrid(controller);
    ToastService.showSuccess(context, 'Reverted to source value');
  }

  void _handleDelete(AdvancedDiffController controller, String key) {
    controller.deleteEntry(key);
    _refreshGrid(controller);
    ToastService.showSuccess(context, 'Entry deleted');
  }

  void _refreshGrid(AdvancedDiffController controller) {
    setState(() {
      _updateGridData(controller);
    });
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
  Future<void> _showEditDialog(AdvancedDiffController controller, String key) async {
    final source = controller.getSourceValue(key);
    final target = controller.getTargetValue(key);
    final textController = TextEditingController(text: target);
    final theme = Theme.of(context);

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.edit, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Edit: $key',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 700,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Source (read-only)
              Text(
                'SOURCE (Original)',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.disabledColor,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  border: Border.all(color: theme.dividerColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  source.isEmpty ? '(empty)' : source,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'RobotoMono',
                    color: source.isEmpty ? theme.disabledColor : null,
                    fontStyle: source.isEmpty ? FontStyle.italic : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Target (editable)
              Text(
                'TARGET (Translation)',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: textController,
                maxLines: 6,
                minLines: 3,
                autofocus: true,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'RobotoMono',
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Enter translation...',
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pop(textController.text);
              controller.addToTM(key, source, textController.text);
              ToastService.showSuccess(context, 'Saved & Added to TM');
            },
            icon: const Icon(Icons.psychology, size: 16),
            label: const Text('Save & Add to TM'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(textController.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result != null && result != target) {
      controller.updateEntry(key, result);
      _refreshGrid(controller);
    }
  }

  void _handleBulkMarkReviewed() {
    final controller = context.read<AdvancedDiffController>();
    final selectedRows = _stateManager?.currentSelectingRows ?? [];
    
    if (selectedRows.isEmpty) {
      ToastService.showInfo(context, 'Select rows first (Shift+Click or Ctrl+Click)');
      return;
    }

    for (final row in selectedRows) {
      final key = row.cells['key']?.value as String?;
      if (key != null) {
        controller.toggleReviewed(key);
      }
    }
    
    _refreshGrid(controller);
    ToastService.showSuccess(context, 'Marked ${selectedRows.length} rows as reviewed');
  }

  void _handleBulkRevert() {
    final controller = context.read<AdvancedDiffController>();
    final selectedRows = _stateManager?.currentSelectingRows ?? [];
    
    if (selectedRows.isEmpty) {
      ToastService.showInfo(context, 'Select rows first (Shift+Click or Ctrl+Click)');
      return;
    }

    for (final row in selectedRows) {
      final key = row.cells['key']?.value as String?;
      if (key != null) {
        controller.revertEntry(key);
      }
    }
    
    _refreshGrid(controller);
    ToastService.showSuccess(context, 'Reverted ${selectedRows.length} rows');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Consumer<AdvancedDiffController>(
      builder: (context, controller, _) {
        // Rebuild columns and rows when controller changes
        _columns = PlutoGridAdapter.createColumns(
          context: context,
          onAddToTM: (key) => _handleAddToTM(controller, key),
          onMarkReviewed: (key) => _handleMarkReviewed(controller, key),
          onRevert: (key) => _handleRevert(controller, key),
          onDelete: (key) => _handleDelete(controller, key),
          reviewedKeys: controller.reviewedKeys,
          useInlineEditing: controller.useInlineEditing,
          onEditCell: (key) => _showEditDialog(controller, key),
        );
        
        _rows = PlutoGridAdapter.createRows(
          entries: controller.processedEntries,
          sourceData: controller.file1Data,
          targetData: controller.file2Data,
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
                    '${controller.processedEntries.length} entries',
                    style: theme.textTheme.bodySmall,
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _handleBulkMarkReviewed,
                    icon: const Icon(Icons.check_circle_outline, size: 16),
                    label: const Text('Mark Selected Reviewed'),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: _handleBulkRevert,
                    icon: const Icon(Icons.undo, size: 16),
                    label: const Text('Revert Selected'),
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
                            'No differences found',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.disabledColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your filters',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : PlutoGrid(
                      // Key forces rebuild when edit mode changes
                      key: ValueKey('pluto_grid_inline_${controller.useInlineEditing}'),
                      columns: _columns,
                      rows: _rows,
                      onLoaded: (PlutoGridOnLoadedEvent event) {
                        _stateManager = event.stateManager;
                        // Enable row selection for bulk actions
                        _stateManager?.setSelectingMode(PlutoGridSelectingMode.row);
                      },
                      onChanged: _handleCellChanged,
                      mode: PlutoGridMode.normal,
                      configuration: PlutoGridConfiguration(
                        // Style
                        style: PlutoGridStyleConfig(
                          gridBackgroundColor: theme.scaffoldBackgroundColor,
                          rowColor: theme.cardColor,
                          activatedColor: theme.colorScheme.primary.withValues(alpha: 0.05),
                          activatedBorderColor: theme.colorScheme.primary.withValues(alpha: 0.3),
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
                          columnTextStyle: (theme.textTheme.titleSmall ?? const TextStyle()).copyWith(
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
                          rowHeight: 72,
                          columnHeight: 48,
                          defaultCellPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        ),
                        // Column settings - auto expand to fill width
                        columnSize: const PlutoGridColumnSizeConfig(
                          autoSizeMode: PlutoAutoSizeMode.scale,
                          resizeMode: PlutoResizeMode.normal,
                        ),
                        // Editing - enable on single tap/click
                        enterKeyAction: PlutoGridEnterKeyAction.editingAndMoveDown,
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
}
