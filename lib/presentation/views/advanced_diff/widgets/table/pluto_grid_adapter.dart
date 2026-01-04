import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';

/// Converts comparison diff data to PlutoGrid format.
class PlutoGridAdapter {
  /// Creates column definitions for the diff grid.
  static List<PlutoColumn> createColumns({
    required BuildContext context,
    required bool isCloudTranslation,
    required void Function(String key) onAddToTM,
    required void Function(String key) onMarkReviewed,
    required void Function(String key) onRevert,
    required void Function(String key) onDelete,
    void Function(String key)? onAiTranslate,
    void Function(String key)? onAiSuggest,
    void Function(String key)? onAiRephrase,
    required Set<String> reviewedKeys,
    required bool useInlineEditing,
    required void Function(String key) onEditCell,
  }) {
    final theme = Theme.of(context);

    return [
      // Row number column with checkbox for multi-select
      PlutoColumn(
        title: '#',
        field: 'index',
        type: PlutoColumnType.number(),
        width: 80, // Increased to fit checkbox + number
        minWidth: 60,
        frozen: PlutoColumnFrozen.start,
        readOnly: true,
        enableSorting:
            false, // Sorting + Checkbox can sometimes conflict visually in header
        enableContextMenu: false,
        enableRowChecked: true, // Enable checkbox for multi-select
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      // Status column
      PlutoColumn(
        title: 'STATUS',
        field: 'status',
        type: PlutoColumnType.text(),
        width: 90,
        minWidth: 80,
        frozen: PlutoColumnFrozen.start,
        readOnly: true,
        enableSorting: true,
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (rendererContext) {
          return _buildStatusBadge(rendererContext.cell.value as String, theme);
        },
      ),
      // Key column (frozen)
      PlutoColumn(
        title: 'KEY',
        field: 'key',
        type: PlutoColumnType.text(),
        width: 200,
        minWidth: 120,
        frozen: PlutoColumnFrozen.start,
        readOnly: true,
        enableSorting: true,
        renderer: (rendererContext) {
          final isModified =
              rendererContext.row.cells['_isModified']?.value == true;
          final rowKey = rendererContext.row.cells['key']?.value as String?;
          final isReviewed = rowKey != null && reviewedKeys.contains(rowKey);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                // Dirty marker (orange dot)
                if (isModified)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                // Reviewed marker (green checkmark)
                if (isReviewed && !isModified)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      Icons.check_circle,
                      size: 14,
                      color: Colors.green[600],
                    ),
                  ),
                Expanded(
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isReviewed ? Colors.grey : null,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // Source column (frozen)
      PlutoColumn(
        title: 'SOURCE',
        field: 'source',
        type: PlutoColumnType.text(),
        width: 400,
        minWidth: 200,
        frozen: PlutoColumnFrozen.start,
        readOnly: true,
        enableSorting: false,
        renderer: (rendererContext) {
          final text = rendererContext.cell.value?.toString() ?? '';
          return Tooltip(
            message: text,
            waitDuration: const Duration(milliseconds: 500),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'RobotoMono',
                  color: theme.textTheme.bodyMedium?.color,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          );
        },
      ),
      // Target column (editable - inline or dialog based on setting)
      PlutoColumn(
        title: useInlineEditing
            ? 'TARGET (click to edit)'
            : 'TARGET (click for dialog)',
        field: 'target',
        type: PlutoColumnType.text(),
        width: 400,
        minWidth: 200,
        frozen: PlutoColumnFrozen
            .end, // Freeze to end so it stays connected to ACTIONS
        readOnly: !useInlineEditing, // Only editable if inline mode
        enableSorting: false,
        enableEditingMode:
            useInlineEditing, // Enable editing mode only for inline
        renderer: (rendererContext) {
          final text = rendererContext.cell.value?.toString() ?? '';
          final isModified =
              rendererContext.row.cells['_isModified']?.value == true;
          final rowKey = rendererContext.row.cells['key']?.value as String?;

          Widget content = Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: isModified
                  ? theme.colorScheme.primary.withValues(alpha: 0.1)
                  : null,
              border: isModified
                  ? Border(
                      left: BorderSide(
                          color: theme.colorScheme.primary, width: 3))
                  : null,
            ),
            child: Text(
              text.isEmpty ? '(empty)' : text,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'RobotoMono',
                color: text.isEmpty
                    ? theme.disabledColor
                    : theme.textTheme.bodyMedium?.color,
                fontWeight: isModified ? FontWeight.w500 : FontWeight.normal,
                fontStyle: text.isEmpty ? FontStyle.italic : FontStyle.normal,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          );

          // Wrap with GestureDetector for dialog mode
          if (!useInlineEditing && rowKey != null) {
            content = MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onEditCell(rowKey),
                child: content,
              ),
            );
          }

          return Tooltip(
            message: text.isEmpty ? '(empty - click to edit)' : text,
            waitDuration: const Duration(milliseconds: 500),
            child: content,
          );
        },
      ),
      // Actions column
      PlutoColumn(
        title: 'ACTIONS',
        field: 'actions',
        type: PlutoColumnType.text(),
        width: 140,
        minWidth: 120,
        readOnly: true,
        enableSorting: false,
        enableContextMenu: false,
        frozen: PlutoColumnFrozen.end,
        renderer: (rendererContext) {
          final rowKey = rendererContext.row.cells['key']?.value as String?;
          if (rowKey == null) return const SizedBox.shrink();

          final isReviewed = reviewedKeys.contains(rowKey);

          final sourceValue =
              rendererContext.row.cells['source']?.value?.toString() ?? '';
          final targetValue =
              rendererContext.row.cells['target']?.value?.toString() ?? '';
          final hasSource = sourceValue.trim().isNotEmpty;
          final hasTarget = targetValue.trim().isNotEmpty;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Primary action: Mark as Reviewed
              _ActionIconButton(
                icon: isReviewed
                    ? Icons.visibility_off
                    : Icons.check_circle_outline,
                tooltip: isReviewed ? 'Unmark Reviewed' : 'Mark Reviewed',
                color: isReviewed ? Colors.green : null,
                onPressed: () => onMarkReviewed(rowKey),
              ),
              // Primary action: Revert
              _ActionIconButton(
                icon: Icons.undo,
                tooltip: 'Revert to Source',
                onPressed: () => onRevert(rowKey),
              ),
              // Overflow menu with all other actions
              _buildOverflowMenu(
                context: context,
                rowKey: rowKey,
                isReviewed: isReviewed,
                hasSource: hasSource,
                hasTarget: hasTarget,
                isCloudTranslation: isCloudTranslation,
                onAddToTM: onAddToTM,
                onEdit: onEditCell,
                onDelete: onDelete,
                onAiTranslate: onAiTranslate,
                onAiSuggest: onAiSuggest,
                onAiRephrase: onAiRephrase,
              ),
            ],
          );
        },
      ),
    ];
  }

  /// Converts diff entries to PlutoGrid rows.
  static List<PlutoRow> createRows({
    required List<MapEntry<String, ComparisonStatusDetail>> entries,
    required Map<String, String> sourceData,
    required Map<String, String> targetData,
    required Set<String> dirtyKeys,
  }) {
    return entries.asMap().entries.map((indexedEntry) {
      final index = indexedEntry.key;
      final entry = indexedEntry.value;
      final key = entry.key;
      final detail = entry.value;

      final statusLabel = _getStatusLabel(detail);
      final source = sourceData[key] ?? '';
      final target = targetData[key] ?? '';
      final isModified = dirtyKeys.contains(key);

      return PlutoRow(
        cells: {
          'index': PlutoCell(value: index + 1),
          'status': PlutoCell(value: statusLabel),
          'key': PlutoCell(value: key),
          'source': PlutoCell(value: source),
          'target': PlutoCell(value: target),
          'actions': PlutoCell(value: ''), // Placeholder for actions renderer
          '_isModified': PlutoCell(value: isModified), // Hidden flag
          '_similarity': PlutoCell(value: detail.similarity), // Hidden data
        },
      );
    }).toList();
  }

  static String _getStatusLabel(ComparisonStatusDetail detail) {
    switch (detail.status) {
      case StringComparisonStatus.added:
        return 'ADDED';
      case StringComparisonStatus.removed:
        return 'MISSING';
      case StringComparisonStatus.modified:
        final percent = ((1.0 - (detail.similarity ?? 0)) * 100).toInt();
        return 'CHG $percent%';
      case StringComparisonStatus.identical:
        return 'SAME';
    }
  }

  static Widget _buildStatusBadge(String label, ThemeData theme) {
    Color bg;
    Color fg;

    if (label == 'ADDED') {
      bg = Colors.green.withValues(alpha: 0.2);
      fg = Colors.green;
    } else if (label == 'MISSING') {
      bg = Colors.red.withValues(alpha: 0.2);
      fg = Colors.red;
    } else if (label.startsWith('CHG')) {
      bg = Colors.amber.withValues(alpha: 0.2);
      fg = Colors.amber[800]!;
    } else {
      bg = Colors.grey.withValues(alpha: 0.2);
      fg = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

enum _OverflowAction {
  edit,
  aiTranslate,
  aiSuggest,
  aiRephrase,
  addToTM,
  delete,
}

/// Builds the overflow "..." menu with AI actions and secondary operations.
Widget _buildOverflowMenu({
  required BuildContext context,
  required String rowKey,
  required bool isReviewed,
  required bool hasSource,
  required bool hasTarget,
  required bool isCloudTranslation,
  required void Function(String key) onAddToTM,
  required void Function(String key) onEdit,
  required void Function(String key) onDelete,
  void Function(String key)? onAiTranslate,
  void Function(String key)? onAiSuggest,
  void Function(String key)? onAiRephrase,
}) {
  final theme = Theme.of(context);
  final translateLabel =
      isCloudTranslation ? 'Translate with Cloud' : 'Translate with AI';
  final rephraseLabel = isCloudTranslation ? 'Rephrase' : 'Rephrase with AI';

  return Tooltip(
    message: 'More actions',
    child: SizedBox(
      width: 32,
      height: 32,
      child: PopupMenuButton<_OverflowAction>(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.more_vert,
          size: 18,
          color: theme.iconTheme.color,
        ),
        tooltip: '',
        onSelected: (action) {
          switch (action) {
            case _OverflowAction.edit:
              onEdit(rowKey);
              break;
            case _OverflowAction.aiTranslate:
              onAiTranslate?.call(rowKey);
              break;
            case _OverflowAction.aiSuggest:
              onAiSuggest?.call(rowKey);
              break;
            case _OverflowAction.aiRephrase:
              onAiRephrase?.call(rowKey);
              break;
            case _OverflowAction.addToTM:
              onAddToTM(rowKey);
              break;
            case _OverflowAction.delete:
              onDelete(rowKey);
              break;
          }
        },
        itemBuilder: (context) => [
          // Edit Action
          const PopupMenuItem(
            value: _OverflowAction.edit,
            child: Row(
              children: [
                Icon(Icons.edit_outlined, size: 16),
                SizedBox(width: 8),
                Text('Edit Details'),
              ],
            ),
          ),
          const PopupMenuDivider(),
          // AI Actions section
          if (hasSource && onAiTranslate != null)
            PopupMenuItem(
              value: _OverflowAction.aiTranslate,
              child: Row(
                children: [
                  const Icon(LucideIcons.sparkles,
                      size: 16, color: Colors.purple),
                  const SizedBox(width: 8),
                  Text(translateLabel),
                ],
              ),
            ),
          if (hasSource && hasTarget && onAiSuggest != null)
            PopupMenuItem(
              value: _OverflowAction.aiSuggest,
              child: Row(
                children: const [
                  Icon(LucideIcons.lightbulb, size: 16, color: Colors.amber),
                  SizedBox(width: 8),
                  Text('Suggest Translation'),
                ],
              ),
            ),
          if (hasTarget && onAiRephrase != null)
            PopupMenuItem(
              value: _OverflowAction.aiRephrase,
              child: Row(
                children: [
                  const Icon(LucideIcons.wand2, size: 16, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(rephraseLabel),
                ],
              ),
            ),
          // Divider if AI actions exist
          if ((hasSource && onAiTranslate != null) ||
              (hasSource && hasTarget && onAiSuggest != null) ||
              (hasTarget && onAiRephrase != null))
            const PopupMenuDivider(),
          // Standard actions
          const PopupMenuItem(
            value: _OverflowAction.addToTM,
            child: Row(
              children: [
                Icon(Icons.psychology, size: 16),
                SizedBox(width: 8),
                Text('Add to TM'),
              ],
            ),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem(
            value: _OverflowAction.delete,
            child: Row(
              children: [
                Icon(Icons.delete_outline, size: 16, color: Colors.red),
                SizedBox(width: 8),
                Text('Delete Entry', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _ActionIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color? color;

  const _ActionIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            icon,
            size: 18,
            color: color ?? Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}
