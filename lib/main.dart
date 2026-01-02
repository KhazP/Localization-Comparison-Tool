import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/presentation/app.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:localizer_app_main/core/services/macos_integration_service.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_single_instance/windows_single_instance.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/core/services/talker_bloc_observer.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

bool _resolveDarkMode(AppSettings settings) {
  final mode = settings.appThemeMode.toLowerCase();
  if (mode == 'dark' || mode == 'amoled') {
    return true;
  }
  if (mode == 'light') {
    return false;
  }
  final brightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  return brightness == Brightness.dark;
}

Future<void> _applyWindowsVisuals(AppSettings settings) async {
  if (!Platform.isWindows) {
    return;
  }

  final isDark = _resolveDarkMode(settings);
  final fallbackBackground =
      isDark ? AppThemeV2.darkBackground : AppThemeV2.lightBackground;

  await windowManager.setBackgroundColor(fallbackBackground);
  if (!settings.useMicaEffect) {
    return;
  }

  try {
    await Window.initialize();
    await windowManager.setBackgroundColor(Colors.transparent);
    await Window.setEffect(
      effect: WindowEffect.mica,
      dark: isDark,
    );
    if (isDark) {
      await windowManager.setBrightness(Brightness.dark);
    }
  } catch (error, stackTrace) {
    developer.log(
      'Mica effect failed. Using solid background.',
      name: 'main',
      error: error,
      stackTrace: stackTrace,
    );
    await windowManager.setBackgroundColor(fallbackBackground);
  }
}

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

  // Get Talker instance
  final talker = sl<TalkerService>().talker;

  // Handle Flutter errors
  FlutterError.onError = (details) => talker.handle(
        details.exception,
        details.stack,
        'Flutter Error: ${details.context?.toDescription()}',
      );

  // Handle Platform errors (async errors not caught by Flutter)
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'Platform Error');
    return true; // Sent to Talker, so handled
  };

  // Setup Bloc Observer
  Bloc.observer = TalkerBlocObserver(talker: talker);

  // Load initial settings for theme and startup options
  final initialAppSettings = await sl<SettingsRepository>().loadSettings();

  // Initialize window manager for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();

    final isDark = _resolveDarkMode(initialAppSettings);
    final fallbackBackground =
        isDark ? AppThemeV2.darkBackground : AppThemeV2.lightBackground;

    if (Platform.isWindows) {
      await windowManager.setBackgroundColor(fallbackBackground);
    }

    // macOS: Initialize specific integrations
    if (Platform.isMacOS) {
      await MacOSIntegrationService.initializeWindowStyling();
      await MacOSIntegrationService.initializeSystemTray();
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
      unawaited(_applyWindowsVisuals(initialAppSettings));
      if (initialAppSettings.startMinimizedToTray) {
        unawaited(windowManager.minimize());
      } else {
        win.show();
        unawaited(windowManager.focus());
      }
    });
  }
}
