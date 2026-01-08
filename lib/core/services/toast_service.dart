import 'package:flutter/material.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/presentation/widgets/common/premium_toast.dart';
import 'package:toastification/toastification.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';

/// Types of toast notifications
enum ToastType { success, error, info, warning }

/// A service for showing standardized toast notifications throughout the app.
/// Uses `toastification` under the hood for consistent, premium-style feedback.
class ToastService {
  ToastService._();

  static Alignment _getAlignment() {
    try {
      final box = Hive.box<AppSettings>('settings');
      // If box is not open or empty, return default
      if (!box.isOpen || box.isEmpty) return Alignment.bottomRight;

      final settings = box.getAt(0);
      return switch (settings?.toastPosition) {
        'TopLeft' => Alignment.topLeft,
        'TopRight' => Alignment.topRight,
        'BottomLeft' => Alignment.bottomLeft,
        // Default to bottomRight
        _ => Alignment.bottomRight,
      };
    } catch (_) {
      return Alignment.bottomRight;
    }
  }

  static bool _isCompact() {
    try {
      final box = Hive.box<AppSettings>('settings');
      // If box is not open or empty, return default
      if (!box.isOpen || box.isEmpty) return true;

      final settings = box.getAt(0);
      return settings?.toastStyle == 'Compact';
    } catch (_) {
      return true;
    }
  }

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

  /// Shows a success toast with a custom action button.
  static void showSuccessWithAction(
    BuildContext context,
    String message, {
    required String actionLabel,
    required VoidCallback onAction,
    Duration duration = const Duration(seconds: 6),
  }) {
    _show(
      context,
      message: message,
      type: ToastType.success,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
    );
  }

  /// Shows an error toast with a red warning icon.
  /// Optionally provide a recovery suggestion for actionable feedback.
  /// When [onRetry] is provided, a "Retry" button is shown and the toast
  /// uses expanded (non-compact) mode to prevent message truncation.
  static void showError(
    BuildContext context,
    String message, {
    String? recoverySuggestion,
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 6),
  }) {
    final fullMessage =
        recoverySuggestion != null ? '$message\n$recoverySuggestion' : message;
    _show(
      context,
      message: fullMessage,
      type: ToastType.error,
      duration: duration,
      actionLabel: onRetry != null ? context.t.common.retry : null,
      onAction: onRetry,
      forceExpanded: onRetry != null,
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
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
    bool forceExpanded = false,
  }) {
    final alignment = _getAlignment();
    final isCompact = forceExpanded ? false : _isCompact();

    toastification.showCustom(
      context: context,
      autoCloseDuration: duration,
      alignment: alignment,
      direction: TextDirection.ltr,
      builder: (BuildContext context, ToastificationItem holder) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: PremiumToast(
                message: message,
                type: type,
                isCompact: isCompact,
                onDismiss: () {
                  toastification.dismiss(holder);
                },
                onUndo: onUndo != null
                    ? () {
                        onUndo();
                        toastification.dismiss(holder);
                      }
                    : null,
                actionLabel: actionLabel,
                onAction: onAction != null
                    ? () {
                        onAction();
                        toastification.dismiss(holder);
                      }
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
