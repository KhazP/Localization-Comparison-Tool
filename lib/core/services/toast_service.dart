import 'package:flutter/material.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';

/// Types of toast notifications
enum ToastType { success, error, info, warning }

/// A service for showing standardized toast notifications throughout the app.
/// Uses `ScaffoldMessenger` under the hood for consistent, Material-style feedback.
class ToastService {
  ToastService._();

  /// Shows a success toast with a green checkmark icon.
  static void showSuccess(
    BuildContext context,
    String message, {
    VoidCallback? onUndo,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      context,
      message: message,
      type: ToastType.success,
      onUndo: onUndo,
      duration: duration,
    );
  }

  /// Shows an error toast with a red warning icon.
  /// Optionally provide a recovery suggestion for actionable feedback.
  static void showError(
    BuildContext context,
    String message, {
    String? recoverySuggestion,
    Duration duration = const Duration(seconds: 6),
  }) {
    final fullMessage = recoverySuggestion != null
        ? '$message\n$recoverySuggestion'
        : message;
    _show(
      context,
      message: fullMessage,
      type: ToastType.error,
      duration: duration,
    );
  }

  /// Shows an informational toast with a blue info icon.
  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      context,
      message: message,
      type: ToastType.info,
      duration: duration,
    );
  }

  /// Shows a warning toast with an amber warning icon.
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 5),
  }) {
    _show(
      context,
      message: message,
      type: ToastType.warning,
      duration: duration,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required ToastType type,
    VoidCallback? onUndo,
    Duration duration = const Duration(seconds: 4),
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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

    // Clear any existing snackbars before showing the new one
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: foregroundColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: isDark ? AppThemeV2.darkTextPrimary : Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isDark
            ? AppThemeV2.darkCard
            : backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: isDark
              ? BorderSide(color: foregroundColor.withAlpha(100), width: 1)
              : BorderSide.none,
        ),
        duration: duration,
        margin: const EdgeInsets.all(16),
        action: onUndo != null
            ? SnackBarAction(
                label: 'Undo',
                textColor: foregroundColor,
                onPressed: onUndo,
              )
            : null,
      ),
    );
  }
}
