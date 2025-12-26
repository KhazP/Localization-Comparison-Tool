import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/presentation/app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
}