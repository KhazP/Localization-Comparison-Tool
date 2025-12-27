import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:macos_window_utils/macos_window_utils.dart';
import 'package:macos_dock_progress/macos_dock_progress.dart';
import 'package:tray_manager/tray_manager.dart';

/// Service for macOS-specific OS integrations.
/// Handles window styling, dock interactions, and native menu support.
///
/// Note: File associations and protocol handlers are configured via Info.plist
/// on macOS, not at runtime like on Windows.
class MacOSIntegrationService {
  /// Check if running on macOS
  static bool get isMacOS => Platform.isMacOS;

  static final _dockProgress = DockProgress();

  // ============ Window Styling Integration ============

  /// Initialize macOS window styling with vibrancy/translucency effects.
  /// This is the macOS equivalent of Windows Mica effect.
  /// 
  /// Call this during app initialization on macOS.
  static Future<void> initializeWindowStyling() async {
    if (!isMacOS) return;

    try {
      await WindowManipulator.initialize();
      await WindowManipulator.makeTitlebarTransparent();
      await WindowManipulator.enableFullSizeContentView();
      
      // Set default material
      await WindowManipulator.setMaterial(NSVisualEffectViewMaterial.sidebar);
      
      debugPrint('macOS window styling initialized');
    } catch (e) {
      debugPrint('Failed to initialize macOS window styling: $e');
    }
  }

  /// Set the window's vibrancy effect material.
  /// Common materials: sidebar, headerView, menu, popover, sheet, etc.
  static Future<void> setWindowMaterial(NSVisualEffectViewMaterial material) async {
    if (!isMacOS) return;

    try {
      await WindowManipulator.setMaterial(material);
      debugPrint('macOS window material set to: $material');
    } catch (e) {
      debugPrint('Failed to set window material: $e');
    }
  }

  // ============ Dock Integration ============

  /// Show a progress indicator on the dock icon.
  /// Value should be between 0.0 and 1.0.
  static Future<void> setDockProgress(double progress) async {
    if (!isMacOS) return;

    try {
      await _dockProgress.setProgress(progress);
      debugPrint('macOS dock progress set to: ${(progress * 100).toStringAsFixed(0)}%');
    } catch (e) {
      debugPrint('Failed to set dock progress: $e');
    }
  }

  /// Hide the dock progress indicator.
  static Future<void> hideDockProgress() async {
    if (!isMacOS) return;

    try {
      await _dockProgress.resetProgress();
      debugPrint('macOS dock progress hidden');
    } catch (e) {
      debugPrint('Failed to hide dock progress: $e');
    }
  }

  /// Show a badge on the dock icon (e.g., error count).
  static Future<void> setDockBadge(int value) async {
    if (!isMacOS) return;

    try {
      await _dockProgress.setBadgeValue(value);
      if (value > 0) {
        debugPrint('macOS dock badge set to: $value');
      } else {
        debugPrint('macOS dock badge cleared');
      }
    } catch (e) {
      debugPrint('Failed to set dock badge: $e');
    }
  }

  // ============ System Tray Integration ============

  /// Initialize system tray icon and menu
  static Future<void> initializeSystemTray() async {
    if (!isMacOS) return;

    try {
      await trayManager.setIcon(
        Platform.isWindows ? 'assets/logo/logo.ico' : 'assets/logo/logo.png',
      );
      
      final Menu menu = Menu(
        items: [
          MenuItem(
            key: 'show_window',
            label: 'Show Localizer',
          ),
          MenuItem.separator(),
          MenuItem(
            key: 'exit_app',
            label: 'Exit',
          ),
        ],
      );
      await trayManager.setContextMenu(menu);
      debugPrint('macOS system tray initialized');
    } catch (e) {
      debugPrint('Failed to initialize system tray: $e');
    }
  }
}
