import 'package:hive_flutter/hive_flutter.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';

class SettingsRepository {
  static const String _boxName = 'app_settings_box';

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<AppSettings>(_boxName);
    }
  }

  Future<AppSettings> loadSettings() async {
    await init(); // Ensure box is open
    final box = Hive.box<AppSettings>(_boxName);
    // Load settings; if not found, return default settings
    // We store only one AppSettings object in the box, using a fixed key.
    AppSettings? settings = box.get('current_settings');
    if (settings == null) {
      settings = AppSettings.defaultSettings();
      await saveSettings(settings); // Save defaults if nothing is there
    }
    return settings;
  }

  Future<void> saveSettings(AppSettings settings) async {
    await init(); // Ensure box is open
    final box = Hive.box<AppSettings>(_boxName);
    // Store the AppSettings object with a fixed key
    await box.put('current_settings', settings);
  }

  Future<void> close() async {
    final box = Hive.box<AppSettings>(_boxName);
    if (box.isOpen) {
      await box.close();
    }
  }
} 