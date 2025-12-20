import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/presentation/app.dart';
import 'package:path_provider/path_provider.dart';

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

  // Load initial settings for theme
  final initialAppSettings = await sl<SettingsRepository>().loadSettings();

  runApp(MyApp(initialAppSettings: initialAppSettings));
}