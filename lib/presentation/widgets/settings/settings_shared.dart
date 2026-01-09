import 'package:flutter/material.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';

/// Helper functions for theming shared across all settings cards
class SettingsThemeHelper {
  final bool isDark;
  final bool isAmoled;

  const SettingsThemeHelper({
    required this.isDark,
    required this.isAmoled,
  });

  Color get surfaceColor {
    if (isAmoled) return AppThemeV2.amoledSurface;
    return isDark ? AppThemeV2.darkSurface : AppThemeV2.lightSurface;
  }

  Color get cardColor {
    if (isAmoled) return AppThemeV2.amoledCard;
    return isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard;
  }

  Color get borderColor {
    if (isAmoled) return AppThemeV2.amoledBorder;
    return isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder;
  }

  Color get textMutedColor {
    return isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted;
  }

  Color get textSecondaryColor {
    return isDark
        ? AppThemeV2.darkTextSecondary
        : AppThemeV2.lightTextSecondary;
  }

  Color get textColor {
    return isDark ? AppThemeV2.darkTextPrimary : AppThemeV2.lightTextPrimary;
  }
}

/// A reusable settings card container
class SettingsCardContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool isDark;
  final bool isAmoled;
  final VoidCallback? onReset;
  final Widget? trailing;

  const SettingsCardContainer({
    super.key,
    required this.title,
    required this.children,
    this.isDark = false,
    this.isAmoled = false,
    this.onReset,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.textSecondaryColor,
                        ),
                  ),
                ),
                if (trailing != null) trailing!,
                if (onReset != null)
                  Tooltip(
                    message: 'Reset to defaults',
                    child: InkWell(
                      onTap: onReset,
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.refresh_rounded,
                          size: 16,
                          color: theme.textMutedColor,
                          semanticLabel: 'Reset to defaults',
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(color: theme.borderColor, height: 1),
          ...children,
        ],
      ),
    );
  }
}

/// A reusable settings row with label and control
class SettingsRow extends StatelessWidget {
  final String label;
  final Widget control;
  final String? description;
  final bool isDark;
  final bool isAmoled;
  final bool showDivider;
  final Widget? trailing;

  const SettingsRow({
    super.key,
    required this.label,
    required this.control,
    this.description,
    this.isDark = false,
    this.isAmoled = false,
    this.showDivider = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);

    final labelSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (trailing != null) trailing!,
          ],
        ),
        if (description != null) ...[
          const SizedBox(height: 2),
          Text(
            description!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: theme.textMutedColor,
                ),
          ),
        ],
      ],
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(child: labelSection),
              const SizedBox(width: 12),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: control,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            color: theme.borderColor,
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}

/// A styled dropdown for settings
class SettingsDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final bool isDark;
  final bool isAmoled;

  const SettingsDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isDark = false,
    this.isAmoled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: theme.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: theme.textColor,
              ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

/// A text field row for settings
class SettingsTextFieldRow extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final bool isDark;
  final bool isAmoled;
  final bool showDivider;
  final String? hintText;

  const SettingsTextFieldRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.isDark = false,
    this.isAmoled = false,
    this.showDivider = true,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              TextField(
                controller: TextEditingController(text: value),
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: hintText,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  filled: true,
                  fillColor: theme.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.borderColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            color: theme.borderColor,
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}

/// An info row for displaying read-only information
class SettingsInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;
  final bool isAmoled;
  final bool showDivider;

  const SettingsInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.isDark = false,
    this.isAmoled = false,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: theme.textMutedColor,
                    ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            color: theme.borderColor,
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}

/// A clickable link row for settings
class SettingsLinkRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;
  final bool isAmoled;
  final bool showDivider;

  const SettingsLinkRow({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDark = false,
    this.isAmoled = false,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, size: 18, color: colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                        ),
                  ),
                ),
                Icon(
                  Icons.open_in_new_rounded,
                  size: 16,
                  color: theme.textMutedColor,
                  semanticLabel: 'Opens in new window',
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            color: theme.borderColor,
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}

/// A description text for settings
class SettingsDescription extends StatelessWidget {
  final String text;
  final bool isDark;
  final bool isAmoled;

  const SettingsDescription(
    this.text, {
    super.key,
    this.isDark = false,
    this.isAmoled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SettingsThemeHelper(isDark: isDark, isAmoled: isAmoled);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: theme.textSecondaryColor,
              height: 1.5,
            ),
      ),
    );
  }
}
