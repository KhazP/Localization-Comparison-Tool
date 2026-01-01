import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'app_intents.dart';
import 'dart:io';

class AppShortcuts {
  static Map<ShortcutActivator, Intent> get defaults {
    return {
      // File Operations
      const SingleActivator(LogicalKeyboardKey.keyO, control: true): const OpenFileIntent(),
      const SingleActivator(LogicalKeyboardKey.keyO, control: true, shift: true): const OpenFolderIntent(),
      const SingleActivator(LogicalKeyboardKey.keyS, control: true): const SaveIntent(), // Ctrl+S for Save
      const SingleActivator(LogicalKeyboardKey.keyE, control: true): const ExportIntent(), // Ctrl+E for Export
      
      // Navigation
      const SingleActivator(LogicalKeyboardKey.comma, control: true): const OpenSettingsIntent(),
      
      // View Control
      const SingleActivator(LogicalKeyboardKey.equal, control: true): const ZoomInIntent(),
      const SingleActivator(LogicalKeyboardKey.minus, control: true): const ZoomOutIntent(),
      const SingleActivator(LogicalKeyboardKey.digit0, control: true): const ResetZoomIntent(),
      const SingleActivator(LogicalKeyboardKey.numpadAdd, control: true): const ZoomInIntent(),
      const SingleActivator(LogicalKeyboardKey.numpadSubtract, control: true): const ZoomOutIntent(),
      const SingleActivator(LogicalKeyboardKey.numpad0, control: true): const ResetZoomIntent(),
      
      // Global Search
      const SingleActivator(LogicalKeyboardKey.keyF, control: true): const FocusSearchIntent(),
    };
  }
}
