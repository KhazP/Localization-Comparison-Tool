import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

import 'package:localizer_app_main/core/utils/drag_drop_utils.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';

/// A file picker area that supports drag-and-drop and click-to-browse.
///
/// Manages its own drag-hover visual state. When a file is dropped or the user
/// clicks, [onFilePicked] is called with the file path.
class FilePickerDropZone extends StatefulWidget {
  /// Title label displayed above the file name (e.g., "Source File").
  final String title;

  /// The currently selected file, or null if none selected.
  final File? file;

  /// Called when the user clicks the zone to browse for a file.
  final VoidCallback onPressed;

  /// Called when the user drops a valid file path.
  final ValueChanged<String> onFilePicked;

  /// Whether the parent is using AMOLED theme.
  final bool isAmoled;

  /// Optional keyboard shortcut hint (e.g., "Ctrl+O").
  final String? shortcutHint;

  const FilePickerDropZone({
    super.key,
    required this.title,
    required this.file,
    required this.onPressed,
    required this.onFilePicked,
    required this.isAmoled,
    this.shortcutHint,
  });

  @override
  State<FilePickerDropZone> createState() => _FilePickerDropZoneState();
}

class _FilePickerDropZoneState extends State<FilePickerDropZone> {
  bool _isDraggingOver = false;

  Future<bool> _hasValidDropItem(List<DropItem> items) async {
    for (final item in items) {
      final localData = item.localData;
      if (localData is String && DragDropUtils.isValidFilePath(localData)) {
        return true;
      }

      final reader = item.dataReader;
      if (reader == null) continue;
      final suggestedName = await reader.getSuggestedName();
      if (DragDropUtils.isValidFileName(suggestedName)) {
        return true;
      }
    }

    return false;
  }

  Widget _wrapWithFileDrag(File? file, Widget child) {
    if (file == null) {
      return child;
    }

    final filePath = file.path;
    final fileName = filePath.split(Platform.pathSeparator).last;

    return DragItemWidget(
      allowedOperations: () => [DropOperation.copy],
      dragItemProvider: (request) async {
        final item = DragItem(
          localData: filePath,
          suggestedName: fileName,
        );
        item.add(Formats.fileUri(Uri.file(filePath)));
        return item;
      },
      child: DraggableWidget(
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final file = widget.file;
    final hasFile = file != null;

    // Abbreviated path display for long paths
    String displayText = '';
    String tooltipPath = '';
    String? fileExtension;

    if (hasFile) {
      tooltipPath = file.path;
      final parts = file.path.split(Platform.isWindows ? '\\' : '/');
      final fileName = parts.last;
      fileExtension = fileName.contains('.')
          ? fileName.split('.').last.toUpperCase()
          : null;

      // Abbreviate long paths: show .../<parent>/<filename>
      if (parts.length > 2 && file.path.length > 40) {
        displayText = '.../${parts[parts.length - 2]}/$fileName';
      } else {
        displayText = fileName;
      }
    } else {
      displayText = _isDraggingOver
          ? context.t.fileComparison.dropFileHere
          : context.t.fileComparison.dropFileOrBrowse;
    }

    Color borderColor = _isDraggingOver
        ? theme.colorScheme.primary
        : (hasFile
            ? theme.colorScheme.primary.withValues(alpha: 0.3)
            : theme.dividerColor);
    Color backgroundColor = _isDraggingOver
        ? theme.colorScheme.primary.withValues(alpha: 0.08)
        : (widget.isAmoled
            ? (hasFile ? Colors.grey[900]! : Colors.transparent)
            : (hasFile
                ? theme.colorScheme.primary.withValues(alpha: 0.04)
                : theme.cardColor.withValues(alpha: 0.5)));

    // Active state (file loaded): compact inline layout ~44px
    // Idle state (empty): slightly larger ~70px for easy drop
    final double verticalPadding = hasFile ? 10.0 : 16.0;
    const double horizontalPadding = 14.0;

    return Expanded(
      child: DropRegion(
        formats: Formats.standardFormats,
        onDropOver: (event) async {
          final hasValidFile = await _hasValidDropItem(event.session.items);
          if (hasValidFile) {
            setState(() => _isDraggingOver = true);
            return DropOperation.copy;
          }
          setState(() => _isDraggingOver = false);
          return DropOperation.none;
        },
        onDropLeave: (event) {
          setState(() => _isDraggingOver = false);
        },
        onPerformDrop: (event) async {
          setState(() => _isDraggingOver = false);
          for (final item in event.session.items) {
            final localData = item.localData;
            if (localData is String &&
                DragDropUtils.isValidFilePath(localData)) {
              widget.onFilePicked(localData);
              return;
            }

            final reader = item.dataReader;
            if (reader == null) continue;

            if (reader.canProvide(Formats.fileUri)) {
              reader.getValue<Uri>(Formats.fileUri, (uri) {
                if (uri != null) {
                  final path = uri.toFilePath();
                  widget.onFilePicked(path);
                }
              });
              break;
            }
          }
        },
        child: _wrapWithFileDrag(
          file,
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: borderColor,
                width: _isDraggingOver ? 2.0 : 1.0,
              ),
            ),
            child: Material(
              type: MaterialType.transparency,
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: widget.onPressed,
                borderRadius: BorderRadius.circular(10.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding, vertical: verticalPadding),
                  child: Row(
                    children: [
                      // Icon
                      Icon(
                        hasFile ? LucideIcons.fileText : LucideIcons.upload,
                        color: _isDraggingOver
                            ? theme.colorScheme.primary
                            : (hasFile
                                ? theme.colorScheme.primary
                                : theme.colorScheme.primary
                                    .withValues(alpha: 0.5)),
                        size: hasFile ? 20 : 24,
                        semanticLabel: hasFile
                            ? context.t.fileComparison
                                .fileSelected(label: '', fileName: '')
                                .split(':')[0]
                            : context.t.fileComparison.fileUpload,
                      ),
                      const SizedBox(width: 12),
                      // Text content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Title label (small, muted)
                            Text(
                              widget.title,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.5),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 2),
                            // Filename or placeholder
                            Tooltip(
                              message: hasFile
                                  ? tooltipPath
                                  : (widget.shortcutHint ?? ''),
                              waitDuration: const Duration(milliseconds: 400),
                              child: Text(
                                displayText,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: hasFile
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: hasFile
                                      ? theme.colorScheme.onSurface
                                      : theme.colorScheme.onSurface
                                          .withValues(alpha: 0.6),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // File extension badge (when file is loaded)
                      if (hasFile && fileExtension != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            fileExtension,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primary,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                      // Change button (when file is loaded)
                      if (hasFile) ...[
                        const SizedBox(width: 8),
                        Icon(
                          LucideIcons.arrowRightLeft,
                          size: 18,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.4),
                          semanticLabel: context.t.fileComparison.changeFile,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
