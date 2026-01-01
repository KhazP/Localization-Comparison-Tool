import 'package:flutter/material.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:file_picker/file_picker.dart';

class DialogService {
  /// Shows a standardized confirmation dialog.
  /// 
  /// Returns `true` if the user confirms, `false` otherwise.
  static Future<bool> showConfirmation({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
    IconData? icon,
  }) async {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titlePadding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
        contentPadding: const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 24),
        actionsPadding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        backgroundColor: isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard,
        surfaceTintColor: Colors.transparent, // Disable material 3 tint
        title: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: isDestructive ? AppThemeV2.error : theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          content,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? AppThemeV2.darkTextSecondary : AppThemeV2.lightTextSecondary,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            style: TextButton.styleFrom(
              foregroundColor: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: Text(cancelText),
          ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: isDestructive ? AppThemeV2.error : theme.colorScheme.primary,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  /// Shows a standardized information dialog.
  static Future<void> showInfo({
    required BuildContext context,
    required String title,
    required String content,
    String buttonText = 'OK',
  }) async {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard,
        surfaceTintColor: Colors.transparent,
        title: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          content,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? AppThemeV2.darkTextSecondary : AppThemeV2.lightTextSecondary,
            height: 1.5,
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  /// Picks a single file using the system file picker.
  static Future<FilePickerResult?> pickFile({
    List<String>? allowedExtensions,
    String? dialogTitle,
  }) async {
    return await FilePicker.platform.pickFiles(
      type: allowedExtensions != null ? FileType.custom : FileType.any,
      allowedExtensions: allowedExtensions,
      dialogTitle: dialogTitle,
      lockParentWindow: true,
    );
  }

  /// Picks a directory using the system folder picker.
  static Future<String?> pickFolder({
    String? dialogTitle,
    String? initialDirectory,
  }) async {
    return await FilePicker.platform.getDirectoryPath(
      dialogTitle: dialogTitle,
      initialDirectory: initialDirectory,
      lockParentWindow: true,
    );
  }
}
