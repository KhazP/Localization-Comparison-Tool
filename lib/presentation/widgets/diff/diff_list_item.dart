import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';

/// A single diff list item showing a localization key and its comparison status.
///
/// Displays the key name, status indicator, and values based on the comparison
/// status (added, removed, modified, identical). Preserves accessibility prefix
/// text ("+", "-", "~", "=") for screen readers.
class DiffListItem extends StatelessWidget {
  final String diffKey;
  final StringComparisonStatus status;
  final String? value1;
  final String? value2;
  final bool isAmoled;
  final SettingsState settingsState;
  final AppThemeState themeState;

  const DiffListItem({
    super.key,
    required this.diffKey,
    required this.status,
    this.value1,
    this.value2,
    required this.isAmoled,
    required this.settingsState,
    required this.themeState,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Status-based colors, labels, and non-color prefix indicators
    Color statusColor;
    Color bgColor;
    String statusLabel;
    String statusPrefix;

    switch (status) {
      case StringComparisonStatus.added:
        statusColor = themeState.diffAddedColor;
        bgColor = statusColor.withAlpha(isDark ? 15 : 10);
        statusLabel = context.t.diff.extra.toUpperCase();
        statusPrefix = '+ ';
        break;
      case StringComparisonStatus.removed:
        statusColor = themeState.diffRemovedColor;
        bgColor = statusColor.withAlpha(isDark ? 15 : 10);
        statusLabel = context.t.diff.missing.toUpperCase();
        statusPrefix = '- ';
        break;
      case StringComparisonStatus.modified:
        statusColor = themeState.diffModifiedColor;
        bgColor = statusColor.withAlpha(isDark ? 15 : 10);
        statusLabel = context.t.diff.modified.toUpperCase();
        statusPrefix = '~ ';
        break;
      case StringComparisonStatus.identical:
        statusColor = isDark ? Colors.grey[600]! : Colors.grey[400]!;
        bgColor = Colors.transparent;
        statusLabel = context.t.settings.appearance.identical.toUpperCase();
        statusPrefix = '= ';
    }

    final borderColor = isAmoled
        ? Colors.grey[850]!
        : (isDark ? const Color(0xFF2E2E38) : Colors.grey[200]!);
    final textMuted = isDark ? Colors.grey[500]! : Colors.grey[500]!;

    // Get font family from settings, with safe fallback for old data
    String fontFamily;
    try {
      fontFamily = settingsState.status == SettingsStatus.loaded
          ? settingsState.appSettings.diffFontFamily
          : 'System Default';
      if (fontFamily.isEmpty) fontFamily = 'System Default';
    } catch (_) {
      fontFamily = 'System Default';
    }
    // Map font family name to actual font family string
    final String actualFontFamily = fontFamily == 'System Default'
        ? 'Consolas, Monaco, monospace'
        : fontFamily;

    // Monospace text style for values
    final monoStyle = TextStyle(
      fontFamily: actualFontFamily,
      fontSize: settingsState.status == SettingsStatus.loaded
          ? settingsState.appSettings.diffFontSize
          : 14.0,
      height: 1.4,
    );

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {}, // Enable hover effect
        hoverColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor.withAlpha(isDark ? 60 : 80)),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Status indicator bar (thin 3px)
                Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Key row with compact status chip
                        Row(
                          children: [
                            Text(
                              statusPrefix,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: statusColor.withAlpha(180),
                                fontSize: 13,
                                fontFamily: 'monospace',
                              ),
                            ),
                            Expanded(
                              child: Text(
                                diffKey,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Compact status chip (just dot + label)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(isDark ? 35 : 25),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    statusLabel,
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Values section - different layouts based on status
                        ..._buildValueSection(
                          context: context,
                          theme: theme,
                          isDark: isDark,
                          statusColor: statusColor,
                          textMuted: textMuted,
                          monoStyle: monoStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildValueSection({
    required BuildContext context,
    required ThemeData theme,
    required bool isDark,
    required Color statusColor,
    required Color textMuted,
    required TextStyle monoStyle,
  }) {
    if (status == StringComparisonStatus.modified) {
      // Side-by-side layout for modified items
      return [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Source (left column)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color:
                      themeState.diffRemovedColor.withAlpha(isDark ? 20 : 15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color:
                        themeState.diffRemovedColor.withAlpha(isDark ? 40 : 30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.t.fileComparison.source,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: textMuted,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value1 ?? '--',
                      style: monoStyle.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(220),
                        decoration: TextDecoration.lineThrough,
                        decorationColor:
                            themeState.diffRemovedColor.withAlpha(150),
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Arrow indicator
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Icon(
                LucideIcons.arrowRight,
                size: 14,
                color: textMuted,
              ),
            ),
            const SizedBox(width: 8),
            // Target (right column)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: themeState.diffAddedColor.withAlpha(isDark ? 20 : 15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color:
                        themeState.diffAddedColor.withAlpha(isDark ? 40 : 30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.t.fileComparison.target,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: textMuted,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value2 ?? '--',
                      style: monoStyle.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(220),
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ];
    } else if (status == StringComparisonStatus.removed) {
      // Single row for removed items
      return [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${context.t.fileComparison.source}: ',
                style: TextStyle(
                    fontSize: 11,
                    color: textMuted,
                    fontWeight: FontWeight.w500)),
            Expanded(
              child: Text(
                value1 ?? '--',
                style: monoStyle.copyWith(
                  color: statusColor.withAlpha(220),
                  decoration: TextDecoration.lineThrough,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ];
    } else if (status == StringComparisonStatus.added) {
      // Single row for added items
      return [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${context.t.fileComparison.value}: ',
                style: TextStyle(
                    fontSize: 11,
                    color: textMuted,
                    fontWeight: FontWeight.w500)),
            Expanded(
              child: Text(
                value2 ?? '--',
                style: monoStyle.copyWith(
                  color: statusColor.withAlpha(220),
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ];
    } else {
      // Single row for identical items
      return [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${context.t.fileComparison.value}: ',
                style: TextStyle(
                    fontSize: 11,
                    color: textMuted,
                    fontWeight: FontWeight.w500)),
            Expanded(
              child: Text(
                value1 ?? '--',
                style: monoStyle.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha(180),
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ];
    }
  }
}
