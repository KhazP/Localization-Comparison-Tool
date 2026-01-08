import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';

/// A widget that displays the current theme's colors and typography.
class ThemePlaygroundSection extends StatelessWidget {
  final bool isDark;
  final bool isAmoled;

  const ThemePlaygroundSection({
    super.key,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ExpansionTile(
      leading: Icon(LucideIcons.palette, color: colorScheme.primary),
      title: Text(context.t.settings.developer.themePlayground),
      subtitle: Text(context.t.settings.developer.themePlaygroundDescription),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategory(
                  context.t.settings.developer.themePlaygroundSection.colors,
                  isDark),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.primary,
                      color: colorScheme.primary),
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.onPrimary,
                      color: colorScheme.onPrimary),
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.secondary,
                      color: colorScheme.secondary),
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.onSecondary,
                      color: colorScheme.onSecondary),
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.surface,
                      color: colorScheme.surface),
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.onSurface,
                      color: colorScheme.onSurface),
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.error,
                      color: colorScheme.error),
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.onError,
                      color: colorScheme.onError),
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.outline,
                      color: colorScheme.outline),
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.shadow,
                      color: colorScheme.shadow),
                ],
              ),
              const Divider(height: 24),
              _buildCategory('App Custom Colors', isDark),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.success,
                      color: AppThemeV2.success),
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.warning,
                      color: AppThemeV2.warning),
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.error,
                      color: AppThemeV2.error),
                  _ColorChip(
                      label: context.t.settings.developer.themePlaygroundSection
                          .palette.info,
                      color: AppThemeV2.info),
                ],
              ),
              const Divider(height: 24),
              _buildCategory(
                  context
                      .t.settings.developer.themePlaygroundSection.typography,
                  isDark),
              const SizedBox(height: 8),
              _TypographyRow(
                  name: 'headlineLarge', style: textTheme.headlineLarge),
              _TypographyRow(
                  name: 'headlineMedium', style: textTheme.headlineMedium),
              _TypographyRow(
                  name: 'headlineSmall', style: textTheme.headlineSmall),
              _TypographyRow(name: 'titleLarge', style: textTheme.titleLarge),
              _TypographyRow(name: 'titleMedium', style: textTheme.titleMedium),
              _TypographyRow(name: 'titleSmall', style: textTheme.titleSmall),
              _TypographyRow(name: 'bodyLarge', style: textTheme.bodyLarge),
              _TypographyRow(name: 'bodyMedium', style: textTheme.bodyMedium),
              _TypographyRow(name: 'bodySmall', style: textTheme.bodySmall),
              _TypographyRow(name: 'labelLarge', style: textTheme.labelLarge),
              _TypographyRow(name: 'labelMedium', style: textTheme.labelMedium),
              _TypographyRow(name: 'labelSmall', style: textTheme.labelSmall),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategory(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: isDark
            ? AppThemeV2.darkTextSecondary
            : AppThemeV2.lightTextSecondary,
      ),
    );
  }
}

class _ColorChip extends StatelessWidget {
  final String label;
  final Color color;

  const _ColorChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    final brightness = ThemeData.estimateBrightnessForColor(color);
    final textColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    return Tooltip(
      message:
          '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400, width: 0.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _TypographyRow extends StatelessWidget {
  final String name;
  final TextStyle? style;

  const _TypographyRow({required this.name, required this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: Theme.of(context).hintColor,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              'The quick brown fox',
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
