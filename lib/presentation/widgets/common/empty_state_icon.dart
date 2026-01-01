import 'package:flutter/material.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';

class EmptyStateIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const EmptyStateIcon({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 64,
                color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
              ),
              const SizedBox(height: 16),
              Text(
                text,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppThemeV2.darkTextSecondary : AppThemeV2.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
