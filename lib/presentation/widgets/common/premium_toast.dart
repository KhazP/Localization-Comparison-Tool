import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';

class PremiumToast extends StatelessWidget {
  final String message;
  final ToastType type;
  final VoidCallback? onDismiss;
  final VoidCallback? onUndo;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool isCompact;

  const PremiumToast({
    super.key,
    required this.message,
    required this.type,
    this.onDismiss,
    this.onUndo,
    this.actionLabel,
    this.onAction,
    this.isCompact = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final targetWidth = isCompact ? 360.0 : 480.0;
    final availableWidth =
        screenWidth > 32.0 ? screenWidth - 32.0 : screenWidth;
    final maxWidth =
        availableWidth < targetWidth ? availableWidth : targetWidth;

    final Color backgroundColor;
    final Color foregroundColor;
    final IconData icon;

    switch (type) {
      case ToastType.success:
        backgroundColor = isDark
            ? AppThemeV2.success.withAlpha(40)
            : AppThemeV2.success.withAlpha(230);
        foregroundColor = isDark ? AppThemeV2.success : Colors.white;
        icon = Icons.check_circle_rounded;
        break;
      case ToastType.error:
        backgroundColor = isDark
            ? AppThemeV2.error.withAlpha(40)
            : AppThemeV2.error.withAlpha(230);
        foregroundColor = isDark ? AppThemeV2.error : Colors.white;
        icon = Icons.error_rounded;
        break;
      case ToastType.info:
        backgroundColor = isDark
            ? AppThemeV2.info.withAlpha(40)
            : AppThemeV2.info.withAlpha(230);
        foregroundColor = isDark ? AppThemeV2.info : Colors.white;
        icon = Icons.info_rounded;
        break;
      case ToastType.warning:
        backgroundColor = isDark
            ? AppThemeV2.warning.withAlpha(40)
            : AppThemeV2.warning.withAlpha(230);
        foregroundColor = isDark ? AppThemeV2.warning : Colors.white;
        icon = Icons.warning_rounded;
        break;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? AppThemeV2.darkCard.withOpacity(0.8)
                    : backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: isDark
                    ? Border.all(color: foregroundColor.withOpacity(0.2))
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: foregroundColor, size: 20),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      message,
                      style: TextStyle(
                        color:
                            isDark ? AppThemeV2.darkTextPrimary : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      // Error toasts get more lines to show full error messages
                      maxLines:
                          isCompact ? (type == ToastType.error ? 4 : 2) : null,
                      overflow: isCompact ? TextOverflow.ellipsis : null,
                    ),
                  ),
                  if (!isCompact ||
                      (actionLabel != null || onUndo != null)) ...[
                    const SizedBox(width: 12),
                    if (actionLabel != null && onAction != null)
                      _ActionButton(
                        label: actionLabel!,
                        onPressed: onAction!,
                        foregroundColor: foregroundColor,
                        isDark: isDark,
                      )
                    else if (onUndo != null)
                      _ActionButton(
                        label: 'Undo',
                        onPressed: onUndo!,
                        foregroundColor: foregroundColor,
                        isDark: isDark,
                      ),
                  ],
                  if (onDismiss != null) ...[
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: onDismiss,
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: isDark
                              ? AppThemeV2.darkTextSecondary
                              : Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color foregroundColor;
  final bool isDark;

  const _ActionButton({
    required this.label,
    required this.onPressed,
    required this.foregroundColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: isDark
            ? foregroundColor.withOpacity(0.1)
            : Colors.white.withOpacity(0.2),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
