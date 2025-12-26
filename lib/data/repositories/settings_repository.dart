import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';

class SettingsRepository {
  static const String _boxName = 'app_settings_box';

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      try {
        await Hive.openBox<AppSettings>(_boxName);
      } catch (e) {
        // If box fails to open (likely due to schema mismatch/Null cast error),
        // delete it and start fresh with defaults.
        await Hive.deleteBoxFromDisk(_boxName);
        await Hive.openBox<AppSettings>(_boxName);
      }
    }
  }

  Future<AppSettings> loadSettings() async {
    await init(); // Ensure box is open
    final box = Hive.box<AppSettings>(_boxName);
    
    try {
      AppSettings? settings = box.get('current_settings');
      if (settings == null) {
        settings = AppSettings.defaultSettings();
        await saveSettings(settings); 
      }
      return settings;
    } catch (e) {
      debugPrint('SettingsRepository: Error loading settings (likely migration issue): $e');
      // Corrupted data - delete and reset
      await Hive.deleteBoxFromDisk(_boxName);
      await init(); // Re-open fresh
      final defaults = AppSettings.defaultSettings();
      await saveSettings(defaults);
      return defaults;
    }
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