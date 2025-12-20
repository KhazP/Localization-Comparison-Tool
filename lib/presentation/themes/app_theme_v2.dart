import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Modern theme system for LocalizerApp v2
/// Features: Dark-first design, glassmorphism, vibrant accents
class AppThemeV2 {
  // ═══════════════════════════════════════════════════════════════════════════
  // COLOR PALETTE
  // ═══════════════════════════════════════════════════════════════════════════

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F0F14);
  static const Color darkSurface = Color(0xFF1A1A22);
  static const Color darkCard = Color(0xFF22222C);
  static const Color darkCardHover = Color(0xFF2A2A36);
  static const Color darkBorder = Color(0xFF2E2E38);
  static const Color darkBorderSubtle = Color(0xFF24242E);

  // AMOLED Theme Colors (Pure black for OLED displays)
  static const Color amoledBackground = Color(0xFF000000);
  static const Color amoledSurface = Color(0xFF0A0A0A);
  static const Color amoledCard = Color(0xFF121212);
  static const Color amoledCardHover = Color(0xFF1A1A1A);
  static const Color amoledBorder = Color(0xFF1E1E1E);
  static const Color amoledBorderSubtle = Color(0xFF151515);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF8F9FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardHover = Color(0xFFF3F4F8);
  static const Color lightBorder = Color(0xFFE2E4EA);
  static const Color lightBorderSubtle = Color(0xFFEEEFF3);

  // Accent Colors
  static const Color primary = Color(0xFF6366F1);          // Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color secondary = Color(0xFF8B5CF6);        // Violet

  // Semantic Colors
  static const Color added = Color(0xFF22C55E);            // Green
  static const Color addedBg = Color(0x3322C55E);          // 20% alpha green
  static const Color removed = Color(0xFFEF4444);          // Red
  static const Color removedBg = Color(0x33EF4444);        // 20% alpha red
  static const Color modified = Color(0xFFF59E0B);         // Amber
  static const Color modifiedBg = Color(0x33F59E0B);       // 20% alpha amber
  static const Color info = Color(0xFF3B82F6);             // Blue
  static const Color warning = Color(0xFFF59E0B);          // Amber
  static const Color error = Color(0xFFEF4444);            // Red
  static const Color success = Color(0xFF22C55E);          // Green

  // Additional M3 Accent Colors
  static const Color tertiary = Color(0xFF06B6D4);         // Cyan
  static const Color tertiaryContainer = Color(0xFF22D3EE);
  static const Color outline = Color(0xFF6B7280);          // Gray
  static const Color outlineVariant = Color(0xFF4B5563);

  // Text Colors - Dark
  static const Color darkTextPrimary = Color(0xFFF1F1F4);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkTextMuted = Color(0xFF6B7280);

  // Text Colors - Light
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF4B5563);
  static const Color lightTextMuted = Color(0xFF9CA3AF);

  // ═══════════════════════════════════════════════════════════════════════════
  // THEME DATA
  // ═══════════════════════════════════════════════════════════════════════════

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      primaryContainer: primaryDark,
      secondary: secondary,
      secondaryContainer: secondary,
      tertiary: tertiary,
      tertiaryContainer: tertiaryContainer,
      surface: darkSurface,
      error: error,
      outline: outline,
      outlineVariant: outlineVariant,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      onSurface: darkTextPrimary,
      onError: Colors.white,
    ),
    textTheme: _buildTextTheme(isDark: true),
    cardTheme: _buildCardTheme(isDark: true),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    outlinedButtonTheme: _buildOutlinedButtonTheme(isDark: true),
    textButtonTheme: _buildTextButtonTheme(),
    inputDecorationTheme: _buildInputTheme(isDark: true),
    dividerTheme: const DividerThemeData(
      color: darkBorder,
      thickness: 1,
    ),
    navigationRailTheme: _buildNavRailTheme(isDark: true),
    chipTheme: _buildChipTheme(isDark: true),
    snackBarTheme: _buildSnackBarTheme(isDark: true),
    dialogTheme: _buildDialogTheme(isDark: true),
    tooltipTheme: _buildTooltipTheme(isDark: true),
    scrollbarTheme: _buildScrollbarTheme(isDark: true),
  );

  /// AMOLED theme with pure black backgrounds for OLED displays
  static ThemeData get amoledTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: amoledBackground,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      primaryContainer: primaryDark,
      secondary: secondary,
      secondaryContainer: secondary,
      tertiary: tertiary,
      tertiaryContainer: tertiaryContainer,
      surface: amoledSurface,
      error: error,
      outline: outline,
      outlineVariant: outlineVariant,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      onSurface: darkTextPrimary,
      onError: Colors.white,
    ),
    textTheme: _buildTextTheme(isDark: true),
    cardTheme: _buildCardTheme(isDark: true, isAmoled: true),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    outlinedButtonTheme: _buildOutlinedButtonTheme(isDark: true),
    textButtonTheme: _buildTextButtonTheme(),
    inputDecorationTheme: _buildInputTheme(isDark: true, isAmoled: true),
    dividerTheme: const DividerThemeData(
      color: amoledBorder,
      thickness: 1,
    ),
    navigationRailTheme: _buildNavRailTheme(isDark: true, isAmoled: true),
    chipTheme: _buildChipTheme(isDark: true),
    snackBarTheme: _buildSnackBarTheme(isDark: true),
    dialogTheme: _buildDialogTheme(isDark: true, isAmoled: true),
    tooltipTheme: _buildTooltipTheme(isDark: true),
    scrollbarTheme: _buildScrollbarTheme(isDark: true, isAmoled: true),
  );

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: const ColorScheme.light(
      primary: primary,
      primaryContainer: primaryLight,
      secondary: secondary,
      secondaryContainer: secondary,
      tertiary: tertiary,
      tertiaryContainer: tertiaryContainer,
      surface: lightSurface,
      error: error,
      outline: outline,
      outlineVariant: lightBorder,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      onSurface: lightTextPrimary,
      onError: Colors.white,
    ),
    textTheme: _buildTextTheme(isDark: false),
    cardTheme: _buildCardTheme(isDark: false),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    outlinedButtonTheme: _buildOutlinedButtonTheme(isDark: false),
    textButtonTheme: _buildTextButtonTheme(),
    inputDecorationTheme: _buildInputTheme(isDark: false),
    dividerTheme: const DividerThemeData(
      color: lightBorder,
      thickness: 1,
    ),
    navigationRailTheme: _buildNavRailTheme(isDark: false),
    chipTheme: _buildChipTheme(isDark: false),
    snackBarTheme: _buildSnackBarTheme(isDark: false),
    dialogTheme: _buildDialogTheme(isDark: false),
    tooltipTheme: _buildTooltipTheme(isDark: false),
    scrollbarTheme: _buildScrollbarTheme(isDark: false),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // COMPONENT THEMES
  // ═══════════════════════════════════════════════════════════════════════════

  static TextTheme _buildTextTheme({required bool isDark}) {
    final baseColor = isDark ? darkTextPrimary : lightTextPrimary;
    final mutedColor = isDark ? darkTextSecondary : lightTextSecondary;

    return GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: baseColor,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: baseColor,
        letterSpacing: -0.5,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: mutedColor,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: baseColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: baseColor,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: mutedColor,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: baseColor,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: mutedColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: mutedColor,
        letterSpacing: 0.5,
      ),
    );
  }

  static CardThemeData _buildCardTheme({required bool isDark, bool isAmoled = false}) {
    final cardColor = isAmoled ? amoledCard : (isDark ? darkCard : lightCard);
    final borderColor = isAmoled ? amoledBorder : (isDark ? darkBorder : lightBorder);
    return CardThemeData(
      color: cardColor,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme({required bool isDark}) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: isDark ? darkTextPrimary : lightTextPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        side: BorderSide(
          color: isDark ? darkBorder : lightBorder,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static InputDecorationTheme _buildInputTheme({required bool isDark, bool isAmoled = false}) {
    final borderColor = isAmoled ? amoledBorder : (isDark ? darkBorder : lightBorder);
    final fillColor = isAmoled ? amoledSurface : (isDark ? darkSurface : lightSurface);
    final textColor = isDark ? darkTextPrimary : lightTextPrimary;
    final hintColor = isDark ? darkTextMuted : lightTextMuted;

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: error),
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        color: hintColor,
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        color: textColor,
      ),
    );
  }

  static NavigationRailThemeData _buildNavRailTheme({required bool isDark, bool isAmoled = false}) {
    final bgColor = isAmoled ? amoledSurface : (isDark ? darkSurface : lightSurface);
    return NavigationRailThemeData(
      backgroundColor: bgColor,
      elevation: 0,
      indicatorColor: primary.withAlpha(40),
      selectedIconTheme: const IconThemeData(
        color: primary,
        size: 24,
      ),
      unselectedIconTheme: IconThemeData(
        color: isDark ? darkTextMuted : lightTextMuted,
        size: 22,
      ),
      selectedLabelTextStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      unselectedLabelTextStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: isDark ? darkTextMuted : lightTextMuted,
      ),
    );
  }

  static ChipThemeData _buildChipTheme({required bool isDark}) {
    return ChipThemeData(
      backgroundColor: isDark ? darkCard : lightCard,
      selectedColor: primary.withAlpha(30),
      disabledColor: isDark ? darkBorder : lightBorder,
      labelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: isDark ? darkTextPrimary : lightTextPrimary,
      ),
      secondaryLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: primary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isDark ? darkBorder : lightBorder,
        ),
      ),
    );
  }

  static SnackBarThemeData _buildSnackBarTheme({required bool isDark}) {
    return SnackBarThemeData(
      backgroundColor: isDark ? darkCard : lightTextPrimary,
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        color: isDark ? darkTextPrimary : lightSurface,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
    );
  }

  static DialogThemeData _buildDialogTheme({required bool isDark, bool isAmoled = false}) {
    final bgColor = isAmoled ? amoledCard : (isDark ? darkCard : lightCard);
    return DialogThemeData(
      backgroundColor: bgColor,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: isDark ? darkTextPrimary : lightTextPrimary,
      ),
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        color: isDark ? darkTextSecondary : lightTextSecondary,
      ),
    );
  }

  static TooltipThemeData _buildTooltipTheme({required bool isDark}) {
    return TooltipThemeData(
      waitDuration: const Duration(milliseconds: 500), // Faster for desktop hover
      decoration: BoxDecoration(
        color: isDark ? darkCard : lightTextPrimary,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 12,
        color: isDark ? darkTextPrimary : lightSurface,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  static ScrollbarThemeData _buildScrollbarTheme({required bool isDark, bool isAmoled = false}) {
    final thumbColor = isDark ? darkTextMuted : lightTextMuted;
    final trackColor = isAmoled ? amoledSurface : (isDark ? darkSurface : lightBackground);
    return ScrollbarThemeData(
      thumbVisibility: WidgetStateProperty.all(true),
      thickness: WidgetStateProperty.all(8.0),
      radius: const Radius.circular(4),
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered) || states.contains(WidgetState.dragged)) {
          return primary.withAlpha(200);
        }
        return thumbColor.withAlpha(150);
      }),
      trackColor: WidgetStateProperty.all(trackColor.withAlpha(50)),
      trackBorderColor: WidgetStateProperty.all(Colors.transparent),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// THEME EXTENSION FOR CUSTOM COLORS
// ═══════════════════════════════════════════════════════════════════════════

/// Custom theme extension providing diff colors and background variants.
/// Named AppThemeColors to avoid confusion with Flutter's ThemeExtension type.
extension AppThemeColors on ThemeData {
  // Diff foreground colors
  Color get diffAdded => AppThemeV2.added;
  Color get diffRemoved => AppThemeV2.removed;
  Color get diffModified => AppThemeV2.modified;

  // Diff background colors (reduced alpha for comfortable contrast)
  Color get diffAddedBg => AppThemeV2.addedBg;
  Color get diffRemovedBg => AppThemeV2.removedBg;
  Color get diffModifiedBg => AppThemeV2.modifiedBg;

  // Background variants
  Color get cardBackground => brightness == Brightness.dark
      ? AppThemeV2.darkCard
      : AppThemeV2.lightCard;

  Color get cardHoverBackground => brightness == Brightness.dark
      ? AppThemeV2.darkCardHover
      : AppThemeV2.lightCardHover;

  Color get subtleBorder => brightness == Brightness.dark
      ? AppThemeV2.darkBorderSubtle
      : AppThemeV2.lightBorderSubtle;

  // Text color helpers
  Color get mutedText => brightness == Brightness.dark
      ? AppThemeV2.darkTextMuted
      : AppThemeV2.lightTextMuted;

  Color get secondaryText => brightness == Brightness.dark
      ? AppThemeV2.darkTextSecondary
      : AppThemeV2.lightTextSecondary;
}
