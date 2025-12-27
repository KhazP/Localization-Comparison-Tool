import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:win32_registry/win32_registry.dart';

/// Service for Windows-specific OS integrations.
/// Handles context menu, file associations, and protocol handlers.
class WindowsIntegrationService {
  static const String _appName = 'LocalizerApp';
  static const String _appDisplayName = 'Localizer';
  static const String _fileExtension = '.loc';
  static const String _protocolScheme = 'localizer';

  /// Check if running on Windows
  static bool get isWindows => Platform.isWindows;

  // ============ Context Menu Integration ============

  /// Add "Open with Localizer" to folder context menu
  static Future<bool> addToContextMenu() async {
    if (!isWindows) return false;

    try {
      final exePath = Platform.resolvedExecutable;

      // Add to Directory context menu (right-click on folder)
      final dirKey = Registry.openPath(
        RegistryHive.currentUser,
        path: r'Software\Classes\Directory\shell',
        desiredAccessRights: AccessRights.allAccess,
      );

      final appKey = dirKey.createKey(_appName);
      appKey.createValue(const RegistryValue(
        '',
        RegistryValueType.string,
        'Open with $_appDisplayName',
      ));
      appKey.createValue(RegistryValue(
        'Icon',
        RegistryValueType.string,
        exePath,
      ));

      final commandKey = appKey.createKey('command');
      commandKey.createValue(RegistryValue(
        '',
        RegistryValueType.string,
        '"$exePath" "%V"',
      ));

      commandKey.close();
      appKey.close();
      dirKey.close();

      // Add to Directory Background (right-click on empty space in folder)
      final bgKey = Registry.openPath(
        RegistryHive.currentUser,
        path: r'Software\Classes\Directory\Background\shell',
        desiredAccessRights: AccessRights.allAccess,
      );

      final bgAppKey = bgKey.createKey(_appName);
      bgAppKey.createValue(const RegistryValue(
        '',
        RegistryValueType.string,
        'Open with $_appDisplayName',
      ));
      bgAppKey.createValue(RegistryValue(
        'Icon',
        RegistryValueType.string,
        exePath,
      ));

      final bgCommandKey = bgAppKey.createKey('command');
      bgCommandKey.createValue(RegistryValue(
        '',
        RegistryValueType.string,
        '"$exePath" "%V"',
      ));

      bgCommandKey.close();
      bgAppKey.close();
      bgKey.close();

      debugPrint('Context menu entries added successfully');
      return true;
    } catch (e) {
      debugPrint('Failed to add context menu: $e');
      return false;
    }
  }

  /// Remove "Open with Localizer" from folder context menu
  static Future<bool> removeFromContextMenu() async {
    if (!isWindows) return false;

    try {
      // Remove from Directory context menu
      final dirKey = Registry.openPath(
        RegistryHive.currentUser,
        path: r'Software\Classes\Directory\shell',
        desiredAccessRights: AccessRights.allAccess,
      );
      dirKey.deleteKey(_appName, recursive: true);
      dirKey.close();

      // Remove from Directory Background
      final bgKey = Registry.openPath(
        RegistryHive.currentUser,
        path: r'Software\Classes\Directory\Background\shell',
        desiredAccessRights: AccessRights.allAccess,
      );
      bgKey.deleteKey(_appName, recursive: true);
      bgKey.close();

      debugPrint('Context menu entries removed successfully');
      return true;
    } catch (e) {
      debugPrint('Failed to remove context menu: $e');
      return false;
    }
  }

  /// Check if context menu is registered
  static bool isContextMenuRegistered() {
    if (!isWindows) return false;

    try {
      final key = Registry.openPath(
        RegistryHive.currentUser,
        path: r'Software\Classes\Directory\shell\LocalizerApp',
      );
      key.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  // ============ File Association Integration ============

  /// Register file extension association
  static Future<bool> registerFileAssociation() async {
    if (!isWindows) return false;

    try {
      final exePath = Platform.resolvedExecutable;

      // Register the file extension
      final extKey = Registry.openPath(
        RegistryHive.currentUser,
        path: r'Software\Classes',
        desiredAccessRights: AccessRights.allAccess,
      );

      final locKey = extKey.createKey(_fileExtension);
      locKey.createValue(RegistryValue(
        '',
        RegistryValueType.string,
        '$_appName.Document',
      ));
      locKey.close();

      // Register the file type
      final typeKey = extKey.createKey('$_appName.Document');
      typeKey.createValue(const RegistryValue(
        '',
        RegistryValueType.string,
        'Localizer Project File',
      ));

      // Default icon
      final iconKey = typeKey.createKey('DefaultIcon');
      iconKey.createValue(RegistryValue(
        '',
        RegistryValueType.string,
        '"$exePath",0',
      ));
      iconKey.close();

      // Shell open command
      final shellKey = typeKey.createKey(r'shell\open\command');
      shellKey.createValue(RegistryValue(
        '',
        RegistryValueType.string,
        '"$exePath" "%1"',
      ));
      shellKey.close();

      typeKey.close();
      extKey.close();

      debugPrint('File association registered successfully');
      return true;
    } catch (e) {
      debugPrint('Failed to register file association: $e');
      return false;
    }
  }

  /// Unregister file extension association
  static Future<bool> unregisterFileAssociation() async {
    if (!isWindows) return false;

    try {
      final extKey = Registry.openPath(
        RegistryHive.currentUser,
        path: r'Software\Classes',
        desiredAccessRights: AccessRights.allAccess,
      );

      extKey.deleteKey(_fileExtension, recursive: true);
      extKey.deleteKey('$_appName.Document', recursive: true);
      extKey.close();

      debugPrint('File association unregistered successfully');
      return true;
    } catch (e) {
      debugPrint('Failed to unregister file association: $e');
      return false;
    }
  }

  /// Check if file association is registered
  static bool isFileAssociationRegistered() {
    if (!isWindows) return false;

    try {
      final key = Registry.openPath(
        RegistryHive.currentUser,
        path: r'Software\Classes\.loc',
      );
      key.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  // ============ Protocol Handler Integration ============

  /// Register protocol handler (localizer://)
  static Future<bool> registerProtocolHandler() async {
    if (!isWindows) return false;

    try {
      final exePath = Platform.resolvedExecutable;

      final classesKey = Registry.openPath(
        RegistryHive.currentUser,
        path: r'Software\Classes',
        desiredAccessRights: AccessRights.allAccess,
      );

      final protocolKey = classesKey.createKey(_protocolScheme);
      protocolKey.createValue(const RegistryValue(
        '',
        RegistryValueType.string,
        'URL:Localizer Protocol',
      ));
      protocolKey.createValue(const RegistryValue(
        'URL Protocol',
        RegistryValueType.string,
        '',
      ));

      // Default icon
      final iconKey = protocolKey.createKey('DefaultIcon');
      iconKey.createValue(RegistryValue(
        '',
        RegistryValueType.string,
        '"$exePath",0',
      ));
      iconKey.close();

      // Shell open command
      final commandKey = protocolKey.createKey(r'shell\open\command');
      commandKey.createValue(RegistryValue(
        '',
        RegistryValueType.string,
        '"$exePath" "%1"',
      ));
      commandKey.close();

      protocolKey.close();
      classesKey.close();

      debugPrint('Protocol handler registered successfully');
      return true;
    } catch (e) {
      debugPrint('Failed to register protocol handler: $e');
      return false;
    }
  }

  /// Unregister protocol handler
  static Future<bool> unregisterProtocolHandler() async {
    if (!isWindows) return false;

    try {
      final classesKey = Registry.openPath(
        RegistryHive.currentUser,
        path: r'Software\Classes',
        desiredAccessRights: AccessRights.allAccess,
      );

      classesKey.deleteKey(_protocolScheme, recursive: true);
      classesKey.close();

      debugPrint('Protocol handler unregistered successfully');
      return true;
    } catch (e) {
      debugPrint('Failed to unregister protocol handler: $e');
      return false;
    }
  }

  /// Check if protocol handler is registered
  static bool isProtocolHandlerRegistered() {
    if (!isWindows) return false;

    try {
      final key = Registry.openPath(
        RegistryHive.currentUser,
        path: r'Software\Classes\localizer',
      );
      key.close();
      return true;
    } catch (e) {
      return false;
    }
  }
}
