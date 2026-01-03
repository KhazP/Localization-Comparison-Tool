import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Modern Color Palette
  // Light Theme
  static const Color lightSurface = Colors.white;
  static const Color lightBackground = Color(0xFFF8FAFC); // Slate 50
  static const Color lightPrimary = Color(0xFF4F46E5); // Indigo 600
  static const Color lightTextPrimary = Color(0xFF1E293B); // Slate 800
  static const Color lightTextSecondary = Color(0xFF64748B); // Slate 500
  static const Color lightBorder = Color(0xFFE2E8F0); // Slate 200

  // Dark Theme
  static const Color darkSurface = Color(0xFF1E293B); // Slate 800
  static const Color darkBackground = Color(0xFF0F172A); // Slate 900
  static const Color darkPrimary = Color(0xFF6366F1); // Indigo 500
  static const Color darkTextPrimary = Color(0xFFF8FAFC); // Slate 50
  static const Color darkTextSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color darkBorder = Color(0xFF334155); // Slate 700

  // Legacy Settings View Colors (for backward compatibility)
  static const Color lightSettingsNavBackground = Color(0xFFF5F5F5);
  static const Color lightSettingsContentBackground = Colors.white;
  static const Color lightSettingsCardBackground = Color(0xFFFAFAFA);
  static const Color lightSettingsTextColor = Color(0xFF212121);
  static const Color lightSettingsMutedTextColor = Color(0xFF757575);
  static const Color lightSettingsBorderColor = Color(0xFFE0E0E0);

  static TextTheme _buildTextTheme(
      TextTheme base, Color primaryColor, Color secondaryColor) {
    return GoogleFonts.interTextTheme(base).copyWith(
      displayLarge:
          GoogleFonts.inter(color: primaryColor, fontWeight: FontWeight.bold),
      displayMedium:
          GoogleFonts.inter(color: primaryColor, fontWeight: FontWeight.bold),
      displaySmall:
          GoogleFonts.inter(color: primaryColor, fontWeight: FontWeight.w600),
      headlineLarge:
          GoogleFonts.inter(color: primaryColor, fontWeight: FontWeight.bold),
      headlineMedium:
          GoogleFonts.inter(color: primaryColor, fontWeight: FontWeight.w600),
      headlineSmall:
          GoogleFonts.inter(color: primaryColor, fontWeight: FontWeight.w600),
      titleLarge:
          GoogleFonts.inter(color: primaryColor, fontWeight: FontWeight.w600),
      titleMedium:
          GoogleFonts.inter(color: primaryColor, fontWeight: FontWeight.w500),
      titleSmall:
          GoogleFonts.inter(color: primaryColor, fontWeight: FontWeight.w500),
      bodyLarge: GoogleFonts.inter(color: primaryColor),
      bodyMedium: GoogleFonts.inter(color: primaryColor),
      bodySmall: GoogleFonts.inter(color: secondaryColor),
      labelLarge:
          GoogleFonts.inter(color: primaryColor, fontWeight: FontWeight.w500),
    );
  }

  static ThemeData getLightTheme() {
    final base = ThemeData.light();

    return base.copyWith(
      brightness: Brightness.light,
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: lightBackground,
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        secondary: lightPrimary,
        surface: lightSurface,
        onPrimary: Colors.white,
        onSurface: lightTextPrimary,
      ),
      textTheme:
          _buildTextTheme(base.textTheme, lightTextPrimary, lightTextSecondary),
      appBarTheme: AppBarTheme(
        backgroundColor: lightSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: lightTextPrimary),
        titleTextStyle: GoogleFonts.inter(
          color: lightTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        shape: Border(bottom: BorderSide(color: lightBorder, width: 1)),
      ),
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: lightBorder, width: 1),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightPrimary,
          side: const BorderSide(color: lightBorder),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: lightPrimary, width: 2),
        ),
        labelStyle: TextStyle(color: lightTextSecondary),
        hintStyle: TextStyle(color: lightTextSecondary.withValues(alpha: 0.7)),
      ),
      dividerTheme: const DividerThemeData(
        color: lightBorder,
        thickness: 1,
        space: 1,
      ),
      iconTheme: const IconThemeData(color: lightTextSecondary),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: lightSurface,
        selectedIconTheme: const IconThemeData(color: lightPrimary),
        unselectedIconTheme: const IconThemeData(color: lightTextSecondary),
        selectedLabelTextStyle: GoogleFonts.inter(
          color: lightPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelTextStyle: GoogleFonts.inter(
          color: lightTextSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        indicatorColor: lightPrimary.withValues(alpha: 0.1),
      ),
    );
  }

  static ThemeData getDarkTheme({bool isAmoled = false}) {
    final base = ThemeData.dark();
    final bgColor = isAmoled ? Colors.black : darkBackground;
    final surfaceColor = isAmoled ? const Color(0xFF121212) : darkSurface;

    return base.copyWith(
      brightness: Brightness.dark,
      primaryColor: darkPrimary,
      scaffoldBackgroundColor: bgColor,
      canvasColor: bgColor,
      colorScheme: ColorScheme.dark(
        primary: darkPrimary,
        secondary: darkPrimary,
        surface: surfaceColor,
        onPrimary: Colors.white,
        onSurface: darkTextPrimary,
      ),
      textTheme:
          _buildTextTheme(base.textTheme, darkTextPrimary, darkTextSecondary),
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: darkTextPrimary),
        titleTextStyle: GoogleFonts.inter(
          color: darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        shape: Border(bottom: BorderSide(color: darkBorder, width: 1)),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: darkBorder, width: 1),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkPrimary,
          side: const BorderSide(color: darkBorder),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkPrimary, width: 2),
        ),
        labelStyle: TextStyle(color: darkTextSecondary),
        hintStyle: TextStyle(color: darkTextSecondary.withValues(alpha: 0.7)),
      ),
      dividerTheme: const DividerThemeData(
        color: darkBorder,
        thickness: 1,
        space: 1,
      ),
      iconTheme: const IconThemeData(color: darkTextSecondary),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surfaceColor,
        selectedIconTheme: const IconThemeData(color: darkPrimary),
        unselectedIconTheme: const IconThemeData(color: darkTextSecondary),
        selectedLabelTextStyle: GoogleFonts.inter(
          color: darkPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelTextStyle: GoogleFonts.inter(
          color: darkTextSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        indicatorColor: darkPrimary.withValues(alpha: 0.2),
      ),
    );
  }
}
