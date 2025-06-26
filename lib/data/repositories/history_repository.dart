import 'package:hive/hive.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';

const String _historyBoxName = 'comparison_history_box';

abstract class HistoryRepository {
  Future<void> init(); // Ensure Hive is initialized and box is open
  Future<void> addComparisonToHistory(ComparisonSession session);
  Future<List<ComparisonSession>> getComparisonHistory();
  Future<void> clearHistory();
  Future<void> close(); // Close the Hive box
}

class LocalHistoryRepository implements HistoryRepository {
  Box<ComparisonSession>? _historyBox;

  @override
  Future<void> init() async {
    if (_historyBox == null || !_historyBox!.isOpen) {
      _historyBox = await Hive.openBox<ComparisonSession>(_historyBoxName);
      print('Comparison history Hive box opened.');
    }
  }

  Future<Box<ComparisonSession>> _getBox() async {
    if (_historyBox == null || !_historyBox!.isOpen) {
      await init();
    }
    return _historyBox!;
  }

  @override
  Future<void> addComparisonToHistory(ComparisonSession session) async {
    final box = await _getBox();
    await box.put(session.id, session); // Using session.id as the key
    print('Comparison session added to Hive: ${session.id}');
  }

  @override
  Future<List<ComparisonSession>> getComparisonHistory() async {
    final box = await _getBox();
    final historyList = box.values.toList();
    // Sort by timestamp, newest first
    historyList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    print('Retrieved ${historyList.length} sessions from Hive.');
    return historyList;
  }

  @override
  Future<void> clearHistory() async {
    final box = await _getBox();
    await box.clear();
    print('Comparison history Hive box cleared.');
  }

  @override
  Future<void> close() async {
    if (_historyBox != null && _historyBox!.isOpen) {
      await _historyBox!.close();
      print('Comparison history Hive box closed.');
    }
  }
} 