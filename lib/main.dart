import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/presentation/app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:localizer_app_main/core/services/macos_integration_service.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_single_instance/windows_single_instance.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Windows: Enforce single instance
  if (Platform.isWindows) {
    await WindowsSingleInstance.ensureSingleInstance(
      args,
      'localizer_app_single_instance_mutex',
      onSecondWindow: (args) {
        // Bring existing window to front
        windowManager.show();
        windowManager.focus();
      },
    );
  }

  final appDocumentDir = await getApplicationDocumentsDirectory();
  
  // Initialize Hive with error handling for corrupted boxes
  await Hive.initFlutter(appDocumentDir.path);

  // Register Hive adapters
  Hive.registerAdapter(ComparisonSessionAdapter());
  Hive.registerAdapter(AppSettingsAdapter());

  // Initialize all services via service locator
  await setupServiceLocator();

  // Load initial settings for theme and startup options
  final initialAppSettings = await sl<SettingsRepository>().loadSettings();

  // Initialize window manager for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();

    // macOS: Initialize specific integrations
    if (Platform.isMacOS) {
      await MacOSIntegrationService.initializeWindowStyling();
      await MacOSIntegrationService.initializeSystemTray();
    }

    // Windows: Initialize Acrylic/Mica effect
    if (Platform.isWindows && initialAppSettings.useMicaEffect) {
      await Window.initialize();
      final isDark = initialAppSettings.appThemeMode == 'Dark' || 
                     initialAppSettings.appThemeMode == 'Amoled' ||
                     initialAppSettings.appThemeMode == 'System'; // Assume dark for system on Windows
      
      // Set transparent background to allow Mica effect to show through
      await windowManager.setBackgroundColor(Colors.transparent);
      
      // Apply Mica effect (Windows 11+) with Acrylic fallback (Windows 10)
      await Window.setEffect(
        effect: WindowEffect.mica,
        dark: isDark,
      );
      
      // Make title bar match the window effect
      await windowManager.setTitleBarStyle(
        TitleBarStyle.normal,
        windowButtonVisibility: true,
      );
      // Set dark title bar for Windows
      if (isDark) {
        await windowManager.setBrightness(Brightness.dark);
      }
    }

    // Restore window position if enabled
    if (initialAppSettings.rememberWindowPosition) {
      final x = initialAppSettings.lastWindowX;
      final y = initialAppSettings.lastWindowY;
      final width = initialAppSettings.lastWindowWidth;
      final height = initialAppSettings.lastWindowHeight;

      if (x != null && y != null && width != null && height != null) {
        await windowManager.setBounds(Rect.fromLTWH(x, y, width, height));
      }
    }

    // Handle start minimized option
    if (initialAppSettings.startMinimizedToTray) {
      await windowManager.minimize();
    } else {
      await windowManager.show();
      await windowManager.focus();
    }
  }

  runApp(MyApp(initialAppSettings: initialAppSettings));

  // Initialize bitsdojo_window for custom title bar (desktop only)
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    doWhenWindowReady(() {
      final win = appWindow;
      const initialSize = Size(1280, 720);
      win.minSize = const Size(800, 600);
      win.size = initialSize;
      win.alignment = Alignment.center;
      win.title = 'Localizer';
      win.show();
    });
  }
}