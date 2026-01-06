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
  static const Color amoledSurface = Color(0xFF000000);
  static const Color amoledCard = Color(0xFF000000);
  static const Color amoledCardHover = Color(0xFF181818);
  static const Color amoledBorder = Color(0xFF333333);
  static const Color amoledBorderSubtle = Color(0xFF222222);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF8F9FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardHover = Color(0xFFF3F4F8);
  static const Color lightBorder = Color(0xFFE2E4EA);
  static const Color lightBorderSubtle = Color(0xFFEEEFF3);

  // Semantic Colors
  static const Color added = Color(0xFF22C55E); // Green
  static const Color addedBg = Color(0x3322C55E); // 20% alpha green
  static const Color removed = Color(0xFFEF4444); // Red
  static const Color removedBg = Color(0x33EF4444); // 20% alpha red
  static const Color modified = Color(0xFFF59E0B); // Amber
  static const Color modifiedBg = Color(0x33F59E0B); // 20% alpha amber
  static const Color info = Color(0xFF3B82F6); // Blue
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color success = Color(0xFF22C55E); // Green

  // Additional M3 Accent Colors
  static const Color outline = Color(0xFF6B7280); // Gray
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

  // ═══════════════════════════════════════════════════════════════════════════
  // THEME FACTORIES
  // ═══════════════════════════════════════════════════════════════════════════

  static ThemeData createDarkTheme(Color accentColor) {
    final primary = accentColor;
    final primaryDark = HSLColor.fromColor(accentColor)
        .withLightness(0.5)
        .toColor(); // Slightly darker
    final secondary = HSLColor.fromColor(accentColor)
        .withHue((HSLColor.fromColor(accentColor).hue + 30) % 360)
        .toColor(); // Analogous
    final tertiary = HSLColor.fromColor(accentColor)
        .withHue((HSLColor.fromColor(accentColor).hue + 180) % 360)
        .toColor(); // Complementary
    final tertiaryContainer =
        HSLColor.fromColor(tertiary).withLightness(0.3).toColor();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primary,
      colorScheme: ColorScheme.dark(
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
      cardTheme: _buildCardTheme(isDark: true, isAmoled: false),
      elevatedButtonTheme: _buildElevatedButtonTheme(primary),
      outlinedButtonTheme:
          _buildOutlinedButtonTheme(isDark: true, primaryColor: primary),
      textButtonTheme: _buildTextButtonTheme(primary),
      iconButtonTheme:
          _buildIconButtonTheme(isDark: true, primaryColor: primary),
      filledButtonTheme: _buildFilledButtonTheme(primary),
      inputDecorationTheme: _buildInputTheme(
          isDark: true, isAmoled: false, primaryColor: primary),
      dividerTheme: const DividerThemeData(
        color: darkBorder,
        thickness: 1,
      ),
      navigationRailTheme: _buildNavRailTheme(
          isDark: true, isAmoled: false, primaryColor: primary),
      chipTheme: _buildChipTheme(isDark: true, primaryColor: primary),
      snackBarTheme: _buildSnackBarTheme(isDark: true),
      dialogTheme: _buildDialogTheme(isDark: true, isAmoled: false),
      tooltipTheme: _buildTooltipTheme(isDark: true),
      scrollbarTheme: _buildScrollbarTheme(
          isDark: true, isAmoled: false, primaryColor: primary),
    );
  }

  /// Mica-enabled dark theme with transparent backgrounds for Windows 11
  static ThemeData createMicaTheme(Color accentColor) {
    final primary = accentColor;
    final primaryDark =
        HSLColor.fromColor(accentColor).withLightness(0.5).toColor();
    final secondary = HSLColor.fromColor(accentColor)
        .withHue((HSLColor.fromColor(accentColor).hue + 30) % 360)
        .toColor();
    final tertiary = HSLColor.fromColor(accentColor)
        .withHue((HSLColor.fromColor(accentColor).hue + 180) % 360)
        .toColor();
    final tertiaryContainer =
        HSLColor.fromColor(tertiary).withLightness(0.3).toColor();

    // Semi-transparent colors for Mica effect
    // Higher alpha values for darker overlays that still show Mica blur but are readable
    const micaBackground = Color(0xFA0F0F14); // 98% opacity
    const micaSurface = Color(0xFC1A1A22); // 99% opacity
    const micaCard = Color(0xFE22222C); // 99.5% opacity
    const micaNavRail = Color(0xFD1A1A22); // 99% opacity

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: micaBackground,
      canvasColor: micaBackground, // Used by some Material widgets
      primaryColor: primary,
      colorScheme: ColorScheme.dark(
        primary: primary,
        primaryContainer: primaryDark,
        secondary: secondary,
        secondaryContainer: secondary,
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        surface: micaSurface,
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
      cardTheme: CardThemeData(
        color: micaCard,
        elevation: 0,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: darkBorder.withAlpha(150),
            width: 1,
          ),
        ),
      ),
      elevatedButtonTheme: _buildElevatedButtonTheme(primary),
      outlinedButtonTheme:
          _buildOutlinedButtonTheme(isDark: true, primaryColor: primary),
      textButtonTheme: _buildTextButtonTheme(primary),
      iconButtonTheme:
          _buildIconButtonTheme(isDark: true, primaryColor: primary),
      filledButtonTheme: _buildFilledButtonTheme(primary),
      inputDecorationTheme: _buildInputTheme(
          isDark: true, isAmoled: false, primaryColor: primary),
      dividerTheme: DividerThemeData(
        color: darkBorder.withAlpha(150),
        thickness: 1,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: micaNavRail,
        elevation: 0,
        indicatorColor: primary.withAlpha(40),
        selectedIconTheme: IconThemeData(
          color: primary,
          size: 24,
        ),
        unselectedIconTheme: IconThemeData(
          color: darkTextMuted,
          size: 22,
        ),
      ),
      chipTheme: _buildChipTheme(isDark: true, primaryColor: primary),
      snackBarTheme: _buildSnackBarTheme(isDark: true),
      dialogTheme: DialogThemeData(
        backgroundColor: micaCard,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      tooltipTheme: _buildTooltipTheme(isDark: true),
      scrollbarTheme: _buildScrollbarTheme(
          isDark: true, isAmoled: false, primaryColor: primary),
    );
  }

  /// AMOLED theme with pure black backgrounds for OLED displays
  static ThemeData createAmoledTheme(Color accentColor) {
    final primary = accentColor;
    final primaryDark =
        HSLColor.fromColor(accentColor).withLightness(0.5).toColor();
    final secondary = HSLColor.fromColor(accentColor)
        .withHue((HSLColor.fromColor(accentColor).hue + 30) % 360)
        .toColor();
    final tertiary = HSLColor.fromColor(accentColor)
        .withHue((HSLColor.fromColor(accentColor).hue + 180) % 360)
        .toColor();
    final tertiaryContainer =
        HSLColor.fromColor(tertiary).withLightness(0.3).toColor();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: amoledBackground,
      primaryColor: primary,
      colorScheme: ColorScheme.dark(
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
      elevatedButtonTheme: _buildElevatedButtonTheme(primary),
      outlinedButtonTheme:
          _buildOutlinedButtonTheme(isDark: true, primaryColor: primary),
      textButtonTheme: _buildTextButtonTheme(primary),
      iconButtonTheme:
          _buildIconButtonTheme(isDark: true, primaryColor: primary),
      filledButtonTheme: _buildFilledButtonTheme(primary),
      inputDecorationTheme:
          _buildInputTheme(isDark: true, isAmoled: true, primaryColor: primary),
      dividerTheme: const DividerThemeData(
        color: amoledBorder,
        thickness: 1,
      ),
      navigationRailTheme: _buildNavRailTheme(
          isDark: true, isAmoled: true, primaryColor: primary),
      chipTheme: _buildChipTheme(isDark: true, primaryColor: primary),
      snackBarTheme: _buildSnackBarTheme(isDark: true),
      dialogTheme: _buildDialogTheme(isDark: true, isAmoled: true),
      tooltipTheme: _buildTooltipTheme(isDark: true),
      scrollbarTheme: _buildScrollbarTheme(
          isDark: true, isAmoled: true, primaryColor: primary),
    );
  }

  static ThemeData createLightTheme(Color accentColor) {
    final primary = accentColor;
    final primaryLight =
        HSLColor.fromColor(accentColor).withLightness(0.7).toColor();
    final secondary = HSLColor.fromColor(accentColor)
        .withHue((HSLColor.fromColor(accentColor).hue + 30) % 360)
        .toColor();
    final tertiary = HSLColor.fromColor(accentColor)
        .withHue((HSLColor.fromColor(accentColor).hue + 180) % 360)
        .toColor();
    final tertiaryContainer =
        HSLColor.fromColor(tertiary).withLightness(0.8).toColor();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: primary,
      colorScheme: ColorScheme.light(
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
      elevatedButtonTheme: _buildElevatedButtonTheme(primary),
      outlinedButtonTheme:
          _buildOutlinedButtonTheme(isDark: false, primaryColor: primary),
      textButtonTheme: _buildTextButtonTheme(primary),
      iconButtonTheme:
          _buildIconButtonTheme(isDark: false, primaryColor: primary),
      filledButtonTheme: _buildFilledButtonTheme(primary),
      inputDecorationTheme:
          _buildInputTheme(isDark: false, primaryColor: primary),
      dividerTheme: const DividerThemeData(
        color: lightBorder,
        thickness: 1,
      ),
      navigationRailTheme:
          _buildNavRailTheme(isDark: false, primaryColor: primary),
      chipTheme: _buildChipTheme(isDark: false, primaryColor: primary),
      snackBarTheme: _buildSnackBarTheme(isDark: false),
      dialogTheme: _buildDialogTheme(isDark: false),
      tooltipTheme: _buildTooltipTheme(isDark: false),
      scrollbarTheme:
          _buildScrollbarTheme(isDark: false, primaryColor: primary),
    );
  }

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

  static CardThemeData _buildCardTheme(
      {required bool isDark, bool isAmoled = false}) {
    final cardColor = isAmoled ? amoledCard : (isDark ? darkCard : lightCard);
    final borderColor =
        isAmoled ? amoledBorder : (isDark ? darkBorder : lightBorder);
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

  static ElevatedButtonThemeData _buildElevatedButtonTheme(Color primaryColor) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return primaryColor.withAlpha(100);
          }
          if (states.contains(WidgetState.hovered)) {
            return HSLColor.fromColor(primaryColor)
                .withLightness(
                  (HSLColor.fromColor(primaryColor).lightness * 1.1)
                      .clamp(0.0, 1.0),
                )
                .toColor();
          }
          if (states.contains(WidgetState.pressed)) {
            return HSLColor.fromColor(primaryColor)
                .withLightness(
                  (HSLColor.fromColor(primaryColor).lightness * 0.9)
                      .clamp(0.0, 1.0),
                )
                .toColor();
          }
          return primaryColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.white.withAlpha(150);
          }
          return Colors.white;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return Colors.white.withAlpha(30);
          }
          return Colors.white.withAlpha(20);
        }),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
        minimumSize: WidgetStateProperty.all(const Size(64, 44)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        animationDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(
      {required bool isDark, required Color primaryColor}) {
    final borderColor = isDark ? darkBorder : lightBorder;
    final textColor = isDark ? darkTextPrimary : lightTextPrimary;

    return OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return textColor.withAlpha(100);
          }
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return primaryColor;
          }
          return textColor;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return primaryColor.withAlpha(15);
          }
          if (states.contains(WidgetState.pressed)) {
            return primaryColor.withAlpha(25);
          }
          return Colors.transparent;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return primaryColor.withAlpha(20);
          }
          return primaryColor.withAlpha(10);
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: borderColor.withAlpha(80), width: 1.5);
          }
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return BorderSide(color: primaryColor.withAlpha(180), width: 1.5);
          }
          return BorderSide(color: borderColor, width: 1.5);
        }),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
        minimumSize: WidgetStateProperty.all(const Size(64, 44)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        animationDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme(Color primaryColor) {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return primaryColor.withAlpha(100);
          }
          if (states.contains(WidgetState.hovered)) {
            return HSLColor.fromColor(primaryColor)
                .withLightness(
                  (HSLColor.fromColor(primaryColor).lightness * 1.1)
                      .clamp(0.0, 1.0),
                )
                .toColor();
          }
          return primaryColor;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return primaryColor.withAlpha(15);
          }
          if (states.contains(WidgetState.pressed)) {
            return primaryColor.withAlpha(25);
          }
          return Colors.transparent;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return primaryColor.withAlpha(30);
          }
          return primaryColor.withAlpha(15);
        }),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        minimumSize: WidgetStateProperty.all(const Size(48, 36)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        animationDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static IconButtonThemeData _buildIconButtonTheme(
      {required bool isDark, required Color primaryColor}) {
    final iconColor = isDark ? darkTextSecondary : lightTextSecondary;

    return IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return iconColor.withAlpha(80);
          }
          if (states.contains(WidgetState.hovered)) {
            return primaryColor;
          }
          return iconColor;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return primaryColor.withAlpha(20);
          }
          if (states.contains(WidgetState.pressed)) {
            return primaryColor.withAlpha(30);
          }
          return Colors.transparent;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return primaryColor.withAlpha(30);
          }
          return primaryColor.withAlpha(15);
        }),
        minimumSize: WidgetStateProperty.all(const Size(40, 40)),
        iconSize: WidgetStateProperty.all(20),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        animationDuration: const Duration(milliseconds: 150),
      ),
    );
  }

  static FilledButtonThemeData _buildFilledButtonTheme(Color primaryColor) {
    return FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return primaryColor.withAlpha(100);
          }
          if (states.contains(WidgetState.hovered)) {
            return HSLColor.fromColor(primaryColor)
                .withLightness(
                  (HSLColor.fromColor(primaryColor).lightness * 1.1)
                      .clamp(0.0, 1.0),
                )
                .toColor();
          }
          if (states.contains(WidgetState.pressed)) {
            return HSLColor.fromColor(primaryColor)
                .withLightness(
                  (HSLColor.fromColor(primaryColor).lightness * 0.9)
                      .clamp(0.0, 1.0),
                )
                .toColor();
          }
          return primaryColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.white.withAlpha(150);
          }
          return Colors.white;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return Colors.white.withAlpha(30);
          }
          return Colors.white.withAlpha(20);
        }),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
        minimumSize: WidgetStateProperty.all(const Size(64, 44)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        animationDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static InputDecorationTheme _buildInputTheme(
      {required bool isDark,
      bool isAmoled = false,
      required Color primaryColor}) {
    final borderColor =
        isAmoled ? amoledBorder : (isDark ? darkBorder : lightBorder);
    final fillColor =
        isAmoled ? amoledSurface : (isDark ? darkSurface : lightSurface);
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
        borderSide: BorderSide(color: primaryColor, width: 2),
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

  static NavigationRailThemeData _buildNavRailTheme(
      {required bool isDark,
      bool isAmoled = false,
      required Color primaryColor}) {
    final bgColor =
        isAmoled ? amoledSurface : (isDark ? darkSurface : lightSurface);
    return NavigationRailThemeData(
      backgroundColor: bgColor,
      elevation: 0,
      indicatorColor: primaryColor.withAlpha(40),
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 24,
      ),
      unselectedIconTheme: IconThemeData(
        color: isDark ? darkTextMuted : lightTextMuted,
        size: 22,
      ),
      selectedLabelTextStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      unselectedLabelTextStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: isDark ? darkTextMuted : lightTextMuted,
      ),
    );
  }

  static ChipThemeData _buildChipTheme(
      {required bool isDark, required Color primaryColor}) {
    return ChipThemeData(
      backgroundColor: isDark ? darkCard : lightCard,
      selectedColor: primaryColor.withAlpha(30),
      disabledColor: isDark ? darkBorder : lightBorder,
      labelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: isDark ? darkTextPrimary : lightTextPrimary,
      ),
      secondaryLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: primaryColor,
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

  static DialogThemeData _buildDialogTheme(
      {required bool isDark, bool isAmoled = false}) {
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
      waitDuration:
          const Duration(milliseconds: 500), // Faster for desktop hover
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

  static ScrollbarThemeData _buildScrollbarTheme(
      {required bool isDark,
      bool isAmoled = false,
      required Color primaryColor}) {
    final thumbColor = isDark ? darkTextMuted : lightTextMuted;
    final trackColor =
        isAmoled ? amoledSurface : (isDark ? darkSurface : lightBackground);
    return ScrollbarThemeData(
      thumbVisibility: WidgetStateProperty.all(true),
      thickness: WidgetStateProperty.all(8.0),
      radius: const Radius.circular(4),
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.dragged)) {
          return primaryColor.withAlpha(200);
        }
        return thumbColor.withAlpha(150);
      }),
      trackColor: WidgetStateProperty.all(trackColor.withAlpha(50)),
      trackBorderColor: WidgetStateProperty.all(Colors.transparent),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER METHODS FOR CARD DECORATION
  // ═══════════════════════════════════════════════════════════════════════════

  /// Returns a BoxDecoration for cards with optional hover state
  /// Standardizes card styling across the application
  static BoxDecoration cardDecoration({
    required bool isDark,
    bool isAmoled = false,
    bool isHovered = false,
    Color? accentColor,
    double borderRadius = 12.0,
  }) {
    final cardColor = isAmoled
        ? (isHovered ? amoledCardHover : amoledCard)
        : (isDark
            ? (isHovered ? darkCardHover : darkCard)
            : (isHovered ? lightCardHover : lightCard));

    final borderColor = isHovered && accentColor != null
        ? accentColor.withAlpha(100)
        : (isAmoled ? amoledBorder : (isDark ? darkBorder : lightBorder));

    return BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor),
      boxShadow: isHovered
          ? [
              BoxShadow(
                color: (accentColor ?? (isDark ? Colors.white : Colors.black))
                    .withAlpha(15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
          : null,
    );
  }

  /// Returns colors for card states
  static Color getCardColor({
    required bool isDark,
    bool isAmoled = false,
    bool isHovered = false,
  }) {
    if (isAmoled) return isHovered ? amoledCardHover : amoledCard;
    return isDark
        ? (isHovered ? darkCardHover : darkCard)
        : (isHovered ? lightCardHover : lightCard);
  }

  /// Returns border color for card states
  static Color getBorderColor({
    required bool isDark,
    bool isAmoled = false,
  }) {
    if (isAmoled) return amoledBorder;
    return isDark ? darkBorder : lightBorder;
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
