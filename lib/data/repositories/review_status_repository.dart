import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';

/// Repository for persisting "Reviewed" status of translation keys.
/// Uses Hive for local storage.
class ReviewStatusRepository {
  static const String _boxName = 'review_status';
  late Box<List<String>> _box;

  /// Initialize the Hive box.
  /// Must be called before accessing data.
  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<List<String>>(_boxName);
    } else {
      _box = Hive.box<List<String>>(_boxName);
    }
  }

  /// Get list of reviewed keys for a given file path.
  List<String> getReviewedKeys(String targetFilePath) {
    try {
      final keys = _box.get(targetFilePath);
      return keys ?? [];
    } catch (e) {
      debugPrint('Error loading reviewed keys: $e');
      return [];
    }
  }

  /// Save list of reviewed keys for a given file path.
  Future<void> saveReviewedKeys(
      String targetFilePath, List<String> keys) async {
    try {
      await _box.put(targetFilePath, keys);
    } catch (e) {
      debugPrint('Error saving reviewed keys: $e');
    }
  }

  /// Clear all data (useful for testing or full reset)
  Future<void> clear() async {
    await _box.clear();
  }
}
