import 'package:flutter/material.dart';

/// Shows whether a setting is inherited from global or customized for the project.
///
/// Displays:
/// - "Inherited" chip (subtle, gray) when using global default
/// - "Custom" chip (accent color) when overridden for project
/// - Reset button to clear override when customized
class SettingOverrideIndicator extends StatelessWidget {
  /// Whether this setting is overridden in the project.
  final bool isOverridden;

  /// Callback when user wants to reset to global default.
  final VoidCallback? onReset;

  /// Whether to show in compact mode (just icon, no text).
  final bool compact;

  const SettingOverrideIndicator({
    super.key,
    required this.isOverridden,
    this.onReset,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (isOverridden) {
      return _buildCustomIndicator(context, colorScheme);
    } else {
      return _buildInheritedIndicator(context, colorScheme);
    }
  }

  Widget _buildCustomIndicator(BuildContext context, ColorScheme colorScheme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 6 : 8,
            vertical: compact ? 2 : 4,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.edit_rounded,
                size: compact ? 12 : 14,
                color: colorScheme.primary,
              ),
              if (!compact) ...[
                const SizedBox(width: 4),
                Text(
                  'Custom',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (onReset != null) ...[
          const SizedBox(width: 4),
          Tooltip(
            message: 'Reset to global default',
            child: InkWell(
              onTap: onReset,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.refresh_rounded,
                  size: compact ? 14 : 16,
                  color: colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInheritedIndicator(
      BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 8,
        vertical: compact ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: colorScheme.onSurface.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.link_rounded,
            size: compact ? 12 : 14,
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          if (!compact) ...[
            const SizedBox(width: 4),
            Text(
              'Inherited',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A wrapper for settings that can be project-overridable.
/// Shows the setting control with an override indicator.
class OverridableSetting extends StatelessWidget {
  /// The setting control widget (e.g., dropdown, text field).
  final Widget child;

  /// Whether this setting is overridden in the project.
  final bool isOverridden;

  /// Whether to show the override indicator (only in project scope).
  final bool showIndicator;

  /// Callback to reset to global default.
  final VoidCallback? onReset;

  /// Label for the setting.
  final String? label;

  const OverridableSetting({
    super.key,
    required this.child,
    required this.isOverridden,
    required this.showIndicator,
    this.onReset,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    if (!showIndicator) {
      return child;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Text(
                label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(width: 8),
              SettingOverrideIndicator(
                isOverridden: isOverridden,
                onReset: onReset,
                compact: true,
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        child,
      ],
    );
  }
}
