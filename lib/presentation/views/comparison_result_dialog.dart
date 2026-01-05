import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';

class ComparisonResultDialog extends StatefulWidget {
  final ComparisonResult result;

  const ComparisonResultDialog({super.key, required this.result});

  @override
  State<ComparisonResultDialog> createState() => _ComparisonResultDialogState();
}

class _ComparisonResultDialogState extends State<ComparisonResultDialog> {
  // Scroll controllers for synchronized scrolling
  final ScrollController _sourceScrollController = ScrollController();
  final ScrollController _targetScrollController = ScrollController();
  bool _isSyncingScroll = false;

  // Filter states - Added and Removed are on by default, Modified is off
  bool _showAdded = true;
  bool _showRemoved = true;
  bool _showModified = false;

  @override
  void initState() {
    super.initState();
    _sourceScrollController.addListener(_onSourceScroll);
    _targetScrollController.addListener(_onTargetScroll);
  }

  @override
  void dispose() {
    _sourceScrollController.removeListener(_onSourceScroll);
    _targetScrollController.removeListener(_onTargetScroll);
    _sourceScrollController.dispose();
    _targetScrollController.dispose();
    super.dispose();
  }

  void _onSourceScroll() {
    if (_isSyncingScroll) return;
    _isSyncingScroll = true;
    if (_targetScrollController.hasClients) {
      _targetScrollController.jumpTo(_sourceScrollController.offset);
    }
    _isSyncingScroll = false;
  }

  void _onTargetScroll() {
    if (_isSyncingScroll) return;
    _isSyncingScroll = true;
    if (_sourceScrollController.hasClients) {
      _sourceScrollController.jumpTo(_targetScrollController.offset);
    }
    _isSyncingScroll = false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeState = context.watch<ThemeBloc>().state;

    // Collect all keys and sort them
    final allKeys = widget.result.diff.keys.toList()..sort();

    // Build source and target lines from the data (filtered)
    final sourceLines = <_DiffLine>[];
    final targetLines = <_DiffLine>[];

    // Count stats
    int addedCount = 0;
    int removedCount = 0;
    int modifiedCount = 0;

    for (final detail in widget.result.diff.values) {
      switch (detail.status) {
        case StringComparisonStatus.added:
          addedCount++;
          break;
        case StringComparisonStatus.removed:
          removedCount++;
          break;
        case StringComparisonStatus.modified:
          modifiedCount++;
          break;
        case StringComparisonStatus.identical:
          break;
      }
    }

    int lineNumber = 0;
    for (int i = 0; i < allKeys.length; i++) {
      final key = allKeys[i];
      final detail = widget.result.diff[key]!;
      final sourceValue = widget.result.file1Data[key];
      final targetValue = widget.result.file2Data[key];

      // Check if this entry should be shown based on filters
      bool shouldShow = true; // Default to showing all
      switch (detail.status) {
        case StringComparisonStatus.added:
          shouldShow = _showAdded;
          break;
        case StringComparisonStatus.removed:
          shouldShow = _showRemoved;
          break;
        case StringComparisonStatus.modified:
          shouldShow = _showModified;
          break;
        case StringComparisonStatus.identical:
          shouldShow = true; // Always show identical entries for context
          break;
      }

      if (!shouldShow) continue;

      lineNumber++;

      // Format as XML-like string for display
      final sourceText = sourceValue != null
          ? '<string name="$key">$sourceValue</string>'
          : '';
      final targetText = targetValue != null
          ? '<string name="$key">$targetValue</string>'
          : '';

      _LineStatus sourceStatus = _LineStatus.unchanged;
      _LineStatus targetStatus = _LineStatus.unchanged;

      switch (detail.status) {
        case StringComparisonStatus.added:
          sourceStatus = _LineStatus.empty;
          targetStatus = _LineStatus.added;
          break;
        case StringComparisonStatus.removed:
          sourceStatus = _LineStatus.removed;
          targetStatus = _LineStatus.empty;
          break;
        case StringComparisonStatus.modified:
          sourceStatus = _LineStatus.modified;
          targetStatus = _LineStatus.modified;
          break;
        case StringComparisonStatus.identical:
          sourceStatus = _LineStatus.unchanged;
          targetStatus = _LineStatus.unchanged;
          break;
      }

      sourceLines.add(_DiffLine(
        lineNumber: lineNumber,
        content: sourceText,
        status: sourceStatus,
      ));
      targetLines.add(_DiffLine(
        lineNumber: lineNumber,
        content: targetText,
        status: targetStatus,
      ));
    }

    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: SizedBox(
        width: 1400,
        height: 850,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Diff Viewer', style: theme.textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _FilterBadge(
                            icon: LucideIcons.plus,
                            count: addedCount,
                            color: themeState.diffAddedColor,
                            label: 'Added',
                            isActive: _showAdded,
                            onTap: () =>
                                setState(() => _showAdded = !_showAdded),
                          ),
                          const SizedBox(width: 8),
                          _FilterBadge(
                            icon: LucideIcons.trash2,
                            count: removedCount,
                            color: themeState.diffRemovedColor,
                            label: 'Removed',
                            isActive: _showRemoved,
                            onTap: () =>
                                setState(() => _showRemoved = !_showRemoved),
                          ),
                          const SizedBox(width: 8),
                          _FilterBadge(
                            icon: LucideIcons.pencil,
                            count: modifiedCount,
                            color: themeState.diffModifiedColor,
                            label: 'Modified',
                            isActive: _showModified,
                            onTap: () =>
                                setState(() => _showModified = !_showModified),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Content - Side by side diff
            Expanded(
              child: sourceLines.isEmpty
                  ? _buildEmptyState(context)
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Source Side
                        Expanded(
                          child: Column(
                            children: [
                              _buildPaneHeader(context, isSource: true),
                              Expanded(
                                child: _buildDiffPane(
                                  context,
                                  sourceLines,
                                  isSource: true,
                                  scrollController: _sourceScrollController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, color: theme.dividerColor),
                        // Target Side
                        Expanded(
                          child: Column(
                            children: [
                              _buildPaneHeader(context, isSource: false),
                              Expanded(
                                child: _buildDiffPane(
                                  context,
                                  targetLines,
                                  isSource: false,
                                  scrollController: _targetScrollController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.filter,
            size: 64,
            color:
                isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
          ),
          const SizedBox(height: 16),
          Text(
            'No entries match the current filters',
            style: theme.textTheme.titleMedium?.copyWith(
              color: isDark
                  ? AppThemeV2.darkTextSecondary
                  : AppThemeV2.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Click the badges above to toggle filters',
            style: theme.textTheme.bodyMedium?.copyWith(
              color:
                  isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaneHeader(BuildContext context, {required bool isSource}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              isSource ? LucideIcons.fileInput : LucideIcons.fileOutput,
              size: 18,
              color: isSource
                  ? theme.colorScheme.primary
                  : theme.colorScheme.secondary,
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (isSource
                        ? theme.colorScheme.primary
                        : theme.colorScheme.secondary)
                    .withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isSource ? 'SOURCE' : 'TARGET',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  letterSpacing: 0.5,
                  color: isSource
                      ? theme.colorScheme.primary
                      : theme.colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isSource
                    ? 'Original/Reference file'
                    : 'Translation/Comparison file',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark
                      ? AppThemeV2.darkTextMuted
                      : AppThemeV2.lightTextMuted,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiffPane(
    BuildContext context,
    List<_DiffLine> lines, {
    required bool isSource,
    required ScrollController scrollController,
  }) {
    final theme = Theme.of(context);
    final themeState = context.watch<ThemeBloc>().state;

    // Get font settings
    final settingsState = context.watch<SettingsBloc>().state;
    String fontFamily = 'Consolas, Monaco, monospace';
    double fontSize = 12.0;
    if (settingsState.status == SettingsStatus.loaded) {
      try {
        final ff = settingsState.appSettings.diffFontFamily;
        if (ff.isNotEmpty && ff != 'System Default') fontFamily = ff;
        fontSize = settingsState.appSettings.diffFontSize;
      } catch (_) {}
    }

    // Colors
    final addedColor = themeState.diffAddedColor;
    final removedColor = themeState.diffRemovedColor;
    final modifiedColor = themeState.diffModifiedColor;

    return Row(
      children: [
        // Main content ListView
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.all(8),
            itemCount: lines.length,
            itemBuilder: (context, index) {
              final line = lines[index];

              // Determine background color based on status
              Color? bgColor;
              Color minimapColor = Colors.transparent;

              switch (line.status) {
                case _LineStatus.added:
                  bgColor = addedColor.withValues(alpha: 0.25);
                  minimapColor = addedColor;
                  break;
                case _LineStatus.removed:
                  bgColor = removedColor.withValues(alpha: 0.25);
                  minimapColor = removedColor;
                  break;
                case _LineStatus.modified:
                  bgColor = modifiedColor.withValues(alpha: 0.25);
                  minimapColor = modifiedColor;
                  break;
                case _LineStatus.empty:
                  bgColor = theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.3);
                  break;
                case _LineStatus.unchanged:
                  bgColor = null;
                  break;
              }

              return Container(
                color: bgColor,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Line number
                    SizedBox(
                      width: 40,
                      child: Text(
                        '${line.lineNumber}',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: fontSize,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                    // Status indicator bar
                    Container(
                      width: 4,
                      height: fontSize + 4,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: minimapColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Content
                    Expanded(
                      child: line.content.isEmpty
                          ? Text(
                              ' ',
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: fontSize,
                                fontStyle: FontStyle.italic,
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3),
                              ),
                            )
                          : SelectableText(
                              line.content,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: fontSize,
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Minimap / Overview Bar
        Container(
          width: 12,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final totalHeight = constraints.maxHeight;
              final totalLines = lines.length;

              if (totalLines == 0) return const SizedBox.shrink();

              return CustomPaint(
                size: Size(12, totalHeight),
                painter: _MinimapPainter(
                  lines: lines,
                  totalLines: totalLines,
                  addedColor: addedColor,
                  removedColor: removedColor,
                  modifiedColor: modifiedColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

enum _LineStatus {
  unchanged,
  added,
  removed,
  modified,
  empty,
}

class _DiffLine {
  final int lineNumber;
  final String content;
  final _LineStatus status;

  _DiffLine({
    required this.lineNumber,
    required this.content,
    required this.status,
  });
}

class _FilterBadge extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color color;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterBadge({
    required this.icon,
    required this.count,
    required this.color,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final activeColor = color;
    final inactiveColor = isDark
        ? AppThemeV2.darkTextMuted.withValues(alpha: 0.5)
        : AppThemeV2.lightTextMuted.withValues(alpha: 0.5);

    final displayColor = isActive ? activeColor : inactiveColor;

    return Tooltip(
      message:
          '$label: $count${isActive ? ' (click to hide)' : ' (click to show)'}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: displayColor.withValues(alpha: isActive ? 0.2 : 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: displayColor.withValues(alpha: isActive ? 0.5 : 0.2),
                width: isActive ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 14, color: displayColor),
                const SizedBox(width: 6),
                Text(
                  '$count',
                  style: TextStyle(
                    color: displayColor,
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom painter for the minimap/overview bar
class _MinimapPainter extends CustomPainter {
  final List<_DiffLine> lines;
  final int totalLines;
  final Color addedColor;
  final Color removedColor;
  final Color modifiedColor;

  _MinimapPainter({
    required this.lines,
    required this.totalLines,
    required this.addedColor,
    required this.removedColor,
    required this.modifiedColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (totalLines == 0) return;

    final lineHeight = size.height / totalLines;
    const minHeight = 2.0;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      Color? color;

      switch (line.status) {
        case _LineStatus.added:
          color = addedColor;
          break;
        case _LineStatus.removed:
          color = removedColor;
          break;
        case _LineStatus.modified:
          color = modifiedColor;
          break;
        default:
          continue;
      }

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      final y = (i / totalLines) * size.height;
      final h = lineHeight < minHeight ? minHeight : lineHeight;

      canvas.drawRect(
        Rect.fromLTWH(0, y, size.width, h),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MinimapPainter oldDelegate) {
    return lines != oldDelegate.lines || totalLines != oldDelegate.totalLines;
  }
}
