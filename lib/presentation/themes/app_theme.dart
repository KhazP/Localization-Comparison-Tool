import 'package:flutter/material.dart';

class AppTheme {
  // Define light theme specific colors for settings page structure
  static const Color lightSettingsNavBackground = Color(0xFFF5F5F5); // Very light grey
  static const Color lightSettingsContentBackground = Color(0xFFFFFFFF); // White
  static const Color lightSettingsCardBackground = Color(0xFFFAFAFA); // Slightly off-white for cards
  static const Color lightSettingsTextColor = Color(0xFF212121); // Dark grey for text
  static const Color lightSettingsMutedTextColor = Color(0xFF757575); // Medium grey for muted text
  static const Color lightSettingsBorderColor = Color(0xFFE0E0E0); // Light grey for borders

  static ThemeData getLightTheme(Color accentColor) {
    final base = ThemeData.light();
    final colorScheme = ColorScheme.fromSeed(
      seedColor: accentColor,
      brightness: Brightness.light,
    );
    return base.copyWith(
      brightness: Brightness.light,
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: Colors.grey[50], // Even lighter scaffold background
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white, // White AppBar for light theme
        elevation: 0.8, // Subtle shadow
        iconTheme: IconThemeData(color: colorScheme.onSurface), // Dark icons
        titleTextStyle: TextStyle(color: colorScheme.onSurface, fontSize: 20, fontWeight: FontWeight.w500), // Dark title
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary, // Accent color for buttons
          foregroundColor: colorScheme.onPrimary, // Text/icon on buttons
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[300], 
        disabledColor: Colors.grey[400],
        selectedColor: colorScheme.primary, 
        secondarySelectedColor: colorScheme.primary, 
        labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.87)), 
        secondaryLabelStyle: TextStyle(color: colorScheme.onPrimary), 
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        shape: const StadiumBorder(), 
        iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant.withOpacity(0.7), size: 18),
        brightness: Brightness.light,
      ),
      cardColor: lightSettingsCardBackground,
      canvasColor: Colors.grey[100],
      dividerColor: lightSettingsBorderColor,
    );
  }

  static ThemeData getDarkTheme(Color accentColor, {bool isAmoled = false}) {
    final base = ThemeData.dark();
    final colorScheme = ColorScheme.fromSeed(
      seedColor: accentColor,
      brightness: Brightness.dark,
    );
    return base.copyWith(
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: isAmoled ? Colors.black : const Color(0xFF121212), 
      canvasColor: isAmoled ? Colors.black : const Color(0xFF121212), 
      cardColor: isAmoled ? Colors.black : const Color(0xFF1E1E1E),
      appBarTheme: AppBarTheme(
        backgroundColor: isAmoled ? Colors.black : colorScheme.surface,
        elevation: 0.5,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        titleTextStyle: TextStyle(color: colorScheme.onSurface, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: isAmoled ? const Color(0xFF1A1A1A) : colorScheme.surfaceContainerHighest,
        disabledColor: Colors.grey[700],
        selectedColor: colorScheme.primary, 
        secondarySelectedColor: colorScheme.primary,
        labelStyle: TextStyle(color: isAmoled ? Colors.grey[300] : colorScheme.onSurfaceVariant), 
        secondaryLabelStyle: TextStyle(color: colorScheme.onPrimary), 
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        shape: const StadiumBorder(),
        iconTheme: IconThemeData(color: isAmoled ? Colors.grey[400] : colorScheme.onSurfaceVariant.withOpacity(0.7), size: 18),
        brightness: Brightness.dark,
      ),
      dividerColor: isAmoled ? Colors.grey[850] : Colors.grey[700],
    );
  }

  // Specific getter for Amoled if preferred, or use the flag in getDarkTheme
  // static ThemeData getAmoledDarkTheme(Color accentColor) {
  //   return getDarkTheme(accentColor, isAmoled: true);
  // }
} 