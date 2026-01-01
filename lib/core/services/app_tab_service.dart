import 'package:flutter/foundation.dart';

/// Tracks the active tab for global navigation actions.
class AppTabService {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  void select(int index) {
    if (selectedIndex.value == index) return;
    selectedIndex.value = index;
  }
}
