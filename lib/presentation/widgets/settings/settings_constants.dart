import 'package:flutter/material.dart';

/// Settings categories for navigation
enum SettingsCategory {
  general,
  comparisonEngine,
  appearance,
  fileHandling,
  aiServices,
  versionControl,
  systemIntegrations,
  projectResources,
  about,
}

/// Theme preset for diff colors
class ThemePreset {
  final Color added;
  final Color removed;
  final Color modified;

  const ThemePreset({
    required this.added,
    required this.removed,
    required this.modified,
  });
}

/// Constants used throughout settings
class SettingsConstants {
  SettingsConstants._();

  static const List<String> fileFormats = [
    'json',
    'xml',
    'yaml',
    'yml',
    'csv',
    'arb',
    'xliff',
    'properties',
    'resx',
    'lang',
    'txt',
    'docx'
  ];

  static const List<String> appLanguages = [
    'Auto-Detect',
    'English (US)',
    'Español (ES)',
    'Français (FR)',
    'Deutsch (DE)',
    'Italiano (IT)',
    'Português (BR)',
    'Türkçe (TR)',
    '日本語 (JP)',
    '中文 (ZH)',
    '한국어 (KR)',
  ];

  static const List<String> defaultViews = [
    'Basic Comparison',
    'History View',
    'Quality Dashboard',
    'Files',
    'Last Used View'
  ];

  static const List<String> encodings = [
    'UTF-8',
    'UTF-16',
    'UTF-16BE',
    'UTF-16LE',
    'ASCII',
    'ISO-8859-1'
  ];

  static const List<String> themeModes = ['System', 'Light', 'Dark', 'Amoled'];

  static const List<String> comparisonModes = [
    'Key-based',
    'Order-based',
    'Smart Match'
  ];

  static const List<String> fontFamilies = [
    'System Default',
    'JetBrains Mono',
    'Fira Code',
    'Source Code Pro',
    'Cascadia Code',
    'Roboto Mono',
  ];

  static const Map<String, ThemePreset> themePresets = {
    'Default': ThemePreset(
      added: Color(0xFF4CAF50),
      removed: Color(0xFFF44336),
      modified: Color(0xFFFFC107),
    ),
    'Colorblind-Friendly': ThemePreset(
      added: Color(0xFF0077BB),
      removed: Color(0xFFEE7733),
      modified: Color(0xFF009988),
    ),
    'High Contrast': ThemePreset(
      added: Colors.greenAccent,
      removed: Colors.redAccent,
      modified: Colors.yellowAccent,
    ),
    'Nord': ThemePreset(
      added: Color(0xFFA3BE8C),
      removed: Color(0xFFBF616A),
      modified: Color(0xFFEBCB8B),
    ),
    'Solarized': ThemePreset(
      added: Color(0xFF859900),
      removed: Color(0xFFDC322F),
      modified: Color(0xFFB58900),
    ),
    'Monokai': ThemePreset(
      added: Color(0xFFA6E22E),
      removed: Color(0xFFF92672),
      modified: Color(0xFFFD971F),
    ),
  };

  static const Map<String, List<String>> patternPresets = {
    'Comments': ['^//.*', '^#.*'],
    'Temp Keys': ['^temp_.*', '^test_.*'],
    'Placeholders': ['^TODO_.*', '^PLACEHOLDER_.*'],
    'Dev Only': ['^DEBUG_.*', '^DEV_.*'],
  };

  /// Data structure for searchable settings
  static const Map<SettingsCategory, List<String>> searchableSettings = {
    SettingsCategory.general: [
      'Language',
      'Default View',
      'Recent Files Count',
      'Open Last Project',
      'Confirm Before Exit',
      'Show Notifications',
    ],
    SettingsCategory.comparisonEngine: [
      'Comparison Mode',
      'Similarity Threshold',
      'Case Sensitive',
      'Ignore Whitespace',
      'Ignore Empty Lines',
      'Ignore Comments',
      'Ignore Patterns',
    ],
    SettingsCategory.appearance: [
      'Theme',
      'Theme Mode',
      'Accent Color',
      'Diff Font Size',
      'Diff Font Family',
      'Diff Colors',
      'Added Color',
      'Removed Color',
      'Modified Color',
      'Identical Color',
      'Color Presets',
      'Preview',
    ],
    SettingsCategory.fileHandling: [
      'Source Format',
      'Target Format',
      'Default Encoding',
      'Recent Project Count',
      'Translation Memory',
      'Import Memory',
      'Export Memory',
      'Clear Memory',
    ],
    SettingsCategory.aiServices: [
      'OpenAI API Key',
      'Anthropic API Key',
      'Google AI API Key',
      'AI Model',
      'Temperature',
      'Custom Prompt',
    ],
    SettingsCategory.versionControl: [
      'Default Branch',
      'Auto Stage',
      'Commit Template',
      'SSH Key',
    ],
    SettingsCategory.systemIntegrations: [
      'System Tray',
      'Start Minimized',
      'File Associations',
      'Mica Effect',
      'Vibrancy',
      'Window Material',
      'Dock Badge',
      'Untranslated Count',
    ],
    SettingsCategory.projectResources: [
      'Glossary',
      'Translation Memory',
      'Terminology',
    ],
    SettingsCategory.about: [
      'Version',
      'Check Updates',
      'Auto Update',
      'Changelog',
      'License',
      'Privacy Policy',
      'Telemetry',
      'Crash Reporting',
      'Developer Options',
    ],
  };

  /// Get the icon for a settings category
  static IconData getCategoryIcon(SettingsCategory category) {
    switch (category) {
      case SettingsCategory.general:
        return Icons.tune_rounded;
      case SettingsCategory.comparisonEngine:
        return Icons.compare_arrows_rounded;
      case SettingsCategory.appearance:
        return Icons.palette_rounded;
      case SettingsCategory.fileHandling:
        return Icons.folder_rounded;
      case SettingsCategory.aiServices:
        return Icons.auto_awesome_rounded;
      case SettingsCategory.versionControl:
        return Icons.history_rounded;
      case SettingsCategory.systemIntegrations:
        return Icons.desktop_windows_rounded;
      case SettingsCategory.projectResources:
        return Icons.library_books_rounded;
      case SettingsCategory.about:
        return Icons.info_rounded;
    }
  }

  /// Get the navigation label for a settings category
  static String getCategoryLabel(SettingsCategory category) {
    switch (category) {
      case SettingsCategory.general:
        return 'General';
      case SettingsCategory.comparisonEngine:
        return 'Comparison';
      case SettingsCategory.appearance:
        return 'Appearance';
      case SettingsCategory.fileHandling:
        return 'File Handling';
      case SettingsCategory.aiServices:
        return 'AI Services';
      case SettingsCategory.versionControl:
        return 'Version History';
      case SettingsCategory.systemIntegrations:
        return 'System Integrations';
      case SettingsCategory.projectResources:
        return 'Project Resources';
      case SettingsCategory.about:
        return 'About';
    }
  }

  /// Get the full title for a settings category
  static String getCategoryTitle(SettingsCategory category) {
    switch (category) {
      case SettingsCategory.general:
        return 'General Settings';
      case SettingsCategory.comparisonEngine:
        return 'Comparison Engine';
      case SettingsCategory.appearance:
        return 'Appearance';
      case SettingsCategory.fileHandling:
        return 'File Handling';
      case SettingsCategory.aiServices:
        return 'AI Services';
      case SettingsCategory.versionControl:
        return 'Version History (Git)';
      case SettingsCategory.systemIntegrations:
        return 'System Integrations';
      case SettingsCategory.projectResources:
        return 'Project Resources (Glossary & TM)';
      case SettingsCategory.about:
        return 'About';
    }
  }
}

