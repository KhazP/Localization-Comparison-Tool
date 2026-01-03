import 'package:flutter/material.dart';

/// Centralized theme colors for consistent styling across the app
class AppColors {
  // Light theme colors
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Colors.white;
  static const Color lightNavBackground = Color(0xFFFAFAFA);
  static const Color lightText = Color(0xFF212121);
  static Color lightMutedText = Colors.grey[600]!;
  static Color lightBorder = Colors.grey[300]!;

  // Dark theme colors
  static const Color darkBackground = Color(0xFF161622);
  static const Color darkSurface = Color(0xFF2A2D3E);
  static const Color darkNavBackground = Color(0xFF1E1E2D);
  static const Color darkText = Colors.white;
  static Color darkMutedText = Colors.grey[400]!;
  static Color darkBorder = Colors.grey[700]!;

  // AMOLED theme colors
  static const Color amoledBackground = Colors.black;
  static const Color amoledSurface = Color(0xFF0D0D0D);
  static const Color amoledNavBackground = Color(0xFF050505);
  static Color amoledText = Colors.grey[300]!;
  static Color amoledMutedText = Colors.grey[500]!;
  static Color amoledBorder = Colors.grey[850]!;

  // Semantic colors
  static const Color added = Color(0xFF4CAF50);
  static const Color removed = Color(0xFFF44336);
  static const Color modified = Color(0xFFFF9800);
  static const Color danger = Color(0xFFD32F2F);

  /// Get appropriate background color based on theme
  static Color getBackground(BuildContext context, {bool isAmoled = false}) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    if (isLight) return lightBackground;
    return isAmoled ? amoledBackground : darkBackground;
  }

  /// Get appropriate surface color based on theme
  static Color getSurface(BuildContext context, {bool isAmoled = false}) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    if (isLight) return lightSurface;
    return isAmoled ? amoledSurface : darkSurface;
  }

  /// Get appropriate navigation background color based on theme
  static Color getNavBackground(BuildContext context, {bool isAmoled = false}) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    if (isLight) return lightNavBackground;
    return isAmoled ? amoledNavBackground : darkNavBackground;
  }

  /// Get appropriate text color based on theme
  static Color getText(BuildContext context, {bool isAmoled = false}) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    if (isLight) return lightText;
    return isAmoled ? amoledText : darkText;
  }

  /// Get appropriate muted text color based on theme
  static Color getMutedText(BuildContext context, {bool isAmoled = false}) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    if (isLight) return lightMutedText;
    return isAmoled ? amoledMutedText : darkMutedText;
  }

  /// Get appropriate border color based on theme
  static Color getBorder(BuildContext context, {bool isAmoled = false}) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    if (isLight) return lightBorder;
    return isAmoled ? amoledBorder : darkBorder;
  }
}

/// Centralized spacing constants
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

/// Centralized border radius constants
class AppRadius {
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 12.0;
  static const double xl = 16.0;
  static const double circular = 999.0;
}
