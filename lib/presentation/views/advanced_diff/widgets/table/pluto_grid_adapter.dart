import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';

/// Converts comparison diff data to PlutoGrid format.
class PlutoGridAdapter {
  /// Creates column definitions for the diff grid.
  static List<PlutoColumn> createColumns({
    required BuildContext context,
    required void Function(String key) onAddToTM,
    required void Function(String key) onMarkReviewed,
    required void Function(String key) onRevert,
    required void Function(String key) onDelete,
    required Set<String> reviewedKeys,
    required bool useInlineEditing,
    required void Function(String key) onEditCell,
  }) {
    final theme = Theme.of(context);

    return [
      // Row number column
      PlutoColumn(
        title: '#',
        field: 'index',
        type: PlutoColumnType.number(),
        width: 60,
        minWidth: 50,
        frozen: PlutoColumnFrozen.start,
        readOnly: true,
        enableSorting: false,
        enableContextMenu: false,
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              rendererContext.cell.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
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

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionIconButton(
                icon: Icons.psychology,
                tooltip: 'Add to TM',
                onPressed: () => onAddToTM(rowKey),
              ),
              _ActionIconButton(
                icon: isReviewed
                    ? Icons.visibility_off
                    : Icons.check_circle_outline,
                tooltip: isReviewed ? 'Unmark Reviewed' : 'Mark Reviewed',
                onPressed: () => onMarkReviewed(rowKey),
              ),
              _ActionIconButton(
                icon: Icons.undo,
                tooltip: 'Revert to Source',
                onPressed: () => onRevert(rowKey),
              ),
              _ActionIconButton(
                icon: Icons.delete_outline,
                tooltip: 'Delete Entry',
                color: Colors.red,
                onPressed: () => onDelete(rowKey),
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
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            size: 16,
            color: color ?? Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}
