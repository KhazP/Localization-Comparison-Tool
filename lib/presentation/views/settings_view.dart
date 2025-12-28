import 'dart:developer' as developer;
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';
import 'package:localizer_app_main/data/services/translation_memory_service.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:localizer_app_main/core/services/windows_integration_service.dart';
import 'package:localizer_app_main/data/services/update_checker_service.dart';
import 'package:localizer_app_main/data/services/system_info_service.dart';
import 'package:intl/intl.dart';

enum SettingsCategory {
  general,
  comparisonEngine,
  appearance,
  fileHandling,
  aiServices,
  versionControl,
  windowsIntegrations,
  about,
}

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with SingleTickerProviderStateMixin {
  SettingsCategory _selectedCategory = SettingsCategory.general;
  final TextEditingController _newPatternController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _navScrollController = ScrollController();
  final ScrollController _contentScrollController = ScrollController();
  String _searchQuery = '';
  TranslationMemoryService? _translationMemoryService;
  Future<TranslationMemoryStats>? _translationMemoryStatsFuture;
  bool _translationMemoryBusy = false;

  PackageInfo? _packageInfo;
  String _platformInfo = 'Loading...';

  // Update checker state
  UpdateCheckerService? _updateCheckerService;
  UpdateCheckResult? _updateCheckResult;
  bool _isCheckingForUpdates = false;

  // System info state
  SystemInfoService? _systemInfoService;
  SystemInfo? _systemInfo;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _fileFormats = [
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
  final List<String> _appLanguages = [
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
  final List<String> _defaultViews = [
    'Basic Comparison',
    'History View',
    'Quality Dashboard',
    'Files',
    'Last Used View'
  ];
  final List<String> _encodings = [
    'UTF-8',
    'UTF-16',
    'UTF-16BE',
    'UTF-16LE',
    'ASCII',
    'ISO-8859-1'
  ];
  final List<String> _themeModes = ['System', 'Light', 'Dark', 'Amoled'];
  final List<String> _comparisonModes = [
    'Key-based',
    'Order-based',
    'Smart Match'
  ];
  final List<String> _fontFamilies = [
    'System Default',
    'JetBrains Mono',
    'Fira Code',
    'Source Code Pro',
    'Cascadia Code',
    'Roboto Mono',
  ];

  final Map<String, _ThemePreset> _themePresets = {
    'Default': const _ThemePreset(
      added: Color(0xFF4CAF50),
      removed: Color(0xFFF44336),
      modified: Color(0xFFFFC107),
    ),
    'Colorblind-Friendly': const _ThemePreset(
      added: Color(0xFF0077BB), // Blue
      removed: Color(0xFFEE7733), // Orange
      modified: Color(0xFF009988), // Teal
    ),
    'High Contrast': const _ThemePreset(
      added: Colors.greenAccent,
      removed: Colors.redAccent,
      modified: Colors.yellowAccent,
    ),
    'Nord': const _ThemePreset(
      added: Color(0xFFA3BE8C), // Nord green
      removed: Color(0xFFBF616A), // Nord red
      modified: Color(0xFFEBCB8B), // Nord yellow
    ),
    'Solarized': const _ThemePreset(
      added: Color(0xFF859900), // Solarized green
      removed: Color(0xFFDC322F), // Solarized red
      modified: Color(0xFFB58900), // Solarized yellow
    ),
    'Monokai': const _ThemePreset(
      added: Color(0xFFA6E22E), // Monokai green
      removed: Color(0xFFF92672), // Monokai pink/red
      modified: Color(0xFFFD971F), // Monokai orange
    ),
  };

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
    if (sl.isRegistered<TranslationMemoryService>()) {
      _translationMemoryService = sl<TranslationMemoryService>();
      _translationMemoryStatsFuture = _translationMemoryService?.getStats();
    }
    _updateCheckerService = UpdateCheckerService();
    _systemInfoService = SystemInfoService();
    _loadSystemInfo();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // AMOLED-AWARE COLOR HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  Color _getSurfaceColor(bool isDark, bool isAmoled) {
    if (isAmoled) return AppThemeV2.amoledSurface;
    return isDark ? AppThemeV2.darkSurface : AppThemeV2.lightSurface;
  }

  Color _getCardColor(bool isDark, bool isAmoled) {
    if (isAmoled) return AppThemeV2.amoledCard;
    return isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard;
  }

  Color _getBorderColor(bool isDark, bool isAmoled) {
    if (isAmoled) return AppThemeV2.amoledBorder;
    return isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder;
  }

  Color _getTextMutedColor(bool isDark) {
    return isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted;
  }

  Color _getTextSecondaryColor(bool isDark) {
    return isDark
        ? AppThemeV2.darkTextSecondary
        : AppThemeV2.lightTextSecondary;
  }

  @override
  void dispose() {
    _newPatternController.dispose();
    _searchController.dispose();
    _navScrollController.dispose();
    _contentScrollController.dispose();
    _animationController.dispose();
    _updateCheckerService?.dispose();
    super.dispose();
  }

  Future<void> _loadAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final platformInfo = await _getPlatformInfo();
      if (mounted) {
        setState(() {
          _packageInfo = packageInfo;
          _platformInfo = platformInfo;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _platformInfo = 'Unknown Platform';
        });
      }
    }
  }

  Future<void> _loadSystemInfo() async {
    try {
      final info = await _systemInfoService?.getSystemInfo();
      if (mounted && info != null) {
        setState(() {
          _systemInfo = info;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _systemInfo = SystemInfo.error();
        });
      }
    }
  }

  Future<String> _getPlatformInfo() async {
    if (Platform.isWindows) {
      final deviceInfo = DeviceInfoPlugin();
      final windowsInfo = await deviceInfo.windowsInfo;
      return 'Windows ${windowsInfo.majorVersion}.${windowsInfo.minorVersion}';
    } else if (Platform.isMacOS) {
      return 'macOS';
    } else if (Platform.isLinux) {
      return 'Linux';
    }
    return 'Unknown';
  }

  Future<void> _refreshTranslationMemoryStats() async {
    if (_translationMemoryService == null) {
      return;
    }
    setState(() {
      _translationMemoryStatsFuture = _translationMemoryService?.getStats();
    });
  }

  String _formatMemorySize(int bytes) {
    if (bytes <= 0) {
      return '0 KB';
    }
    final kb = bytes / 1024;
    if (kb < 1024) {
      return '${kb.toStringAsFixed(1)} KB';
    }
    final mb = kb / 1024;
    return '${mb.toStringAsFixed(1)} MB';
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _runTranslationMemoryAction(
    Future<void> Function() action,
  ) async {
    if (_translationMemoryBusy) {
      return;
    }
    setState(() => _translationMemoryBusy = true);
    try {
      await action();
    } finally {
      if (mounted) {
        setState(() => _translationMemoryBusy = false);
      }
    }
  }

  Future<void> _importTranslationMemory(BuildContext context) async {
    final service = _translationMemoryService;
    if (service == null) {
      return;
    }
    await _runTranslationMemoryAction(() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['tmx', 'csv'],
      );
      if (result == null || result.files.single.path == null) {
        return;
      }
      final file = File(result.files.single.path!);
      final imported = await service.importFromFile(file);
      await _refreshTranslationMemoryStats();
      if (!mounted) {
        return;
      }
      final message = imported > 0
          ? 'Imported $imported items into memory.'
          : 'No items were added.';
      _showSnackBar(context, message);
    });
  }

  Future<void> _exportTranslationMemoryTmx(BuildContext context) async {
    final service = _translationMemoryService;
    if (service == null) {
      return;
    }
    await _runTranslationMemoryAction(() async {
      final stats = await service.getStats();
      if (stats.entryCount == 0) {
        if (mounted) {
          _showSnackBar(context, 'Nothing to export yet.');
        }
        return;
      }
      final outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Export TMX',
        fileName: 'translation_memory.tmx',
        type: FileType.custom,
        allowedExtensions: ['tmx'],
      );
      if (outputPath == null) {
        return;
      }
      await service.exportToTmx(File(outputPath));
      if (mounted) {
        _showSnackBar(context, 'TMX saved.');
      }
    });
  }

  Future<void> _exportTranslationMemoryCsv(BuildContext context) async {
    final service = _translationMemoryService;
    if (service == null) {
      return;
    }
    await _runTranslationMemoryAction(() async {
      final stats = await service.getStats();
      if (stats.entryCount == 0) {
        if (mounted) {
          _showSnackBar(context, 'Nothing to export yet.');
        }
        return;
      }
      final outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Export CSV',
        fileName: 'translation_memory.csv',
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );
      if (outputPath == null) {
        return;
      }
      await service.exportToCsv(File(outputPath));
      if (mounted) {
        _showSnackBar(context, 'CSV saved.');
      }
    });
  }

  Future<void> _confirmClearTranslationMemory(BuildContext context) async {
    final service = _translationMemoryService;
    if (service == null) {
      return;
    }
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear translation memory?'),
        content: const Text(
          'This removes all saved translation pairs on this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirm != true) {
      return;
    }

    await _runTranslationMemoryAction(() async {
      try {
        await service.clearMemory();
        await _refreshTranslationMemoryStats();
        if (mounted) {
          _showSnackBar(context, 'Translation memory cleared.');
        }
      } catch (e, s) {
        developer.log(
          'Failed to clear translation memory.',
          name: 'translation_memory.clear',
          error: e,
          stackTrace: s,
        );
        if (mounted) {
          _showSnackBar(context, 'Could not clear memory.');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            // Determine if AMOLED mode is active
            final bool isAmoled = isDark &&
                state.appSettings.appThemeMode.toLowerCase() == 'amoled';

            if (state.status == SettingsStatus.loading ||
                state.status == SettingsStatus.initial) {
              return Row(
                children: [
                  _buildNavigationPanel(context, isDark, isAmoled, colorScheme),
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state.status == SettingsStatus.error) {
              return Row(
                children: [
                  _buildNavigationPanel(context, isDark, isAmoled, colorScheme),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.error_outline,
                              size: 48, color: AppThemeV2.error),
                          const SizedBox(height: 16),
                          Text('Error loading settings',
                              style: theme.textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Row(
              children: [
                _buildNavigationPanel(context, isDark, isAmoled, colorScheme),
                Expanded(
                  child:
                      _buildSettingsContent(context, state, isDark, isAmoled),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SETTINGS SEARCH DATA
  // ═══════════════════════════════════════════════════════════════════════════

  /// Data structure for searchable settings
  static const Map<SettingsCategory, List<String>> _searchableSettings = {
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
    SettingsCategory.windowsIntegrations: [
      'System Tray',
      'Start Minimized',
      'File Associations',
      'Mica Effect',
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
    ],
  };

  /// Search settings and return matching categories with their matching terms
  Map<SettingsCategory, List<String>> _getSearchResults() {
    if (_searchQuery.isEmpty) {
      return {};
    }
    final query = _searchQuery.toLowerCase();
    final results = <SettingsCategory, List<String>>{};

    for (final entry in _searchableSettings.entries) {
      final matches = entry.value
          .where((setting) => setting.toLowerCase().contains(query))
          .toList();
      if (matches.isNotEmpty) {
        results[entry.key] = matches;
      }
    }
    return results;
  }

  /// Get filtered categories based on search query
  List<SettingsCategory> _getFilteredCategories() {
    if (_searchQuery.isEmpty) {
      return SettingsCategory.values.toList();
    }
    final results = _getSearchResults();
    if (results.isEmpty) {
      return SettingsCategory.values.toList();
    }
    return results.keys.toList();
  }

  Widget _buildNavigationPanel(BuildContext context, bool isDark, bool isAmoled,
      ColorScheme colorScheme) {
    final filteredCategories = _getFilteredCategories();
    final searchResults = _getSearchResults();

    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: _getSurfaceColor(isDark, isAmoled),
        border: Border(
          right: BorderSide(
            color: _getBorderColor(isDark, isAmoled),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colorScheme.primary, colorScheme.secondary],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.settings_rounded,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              controller: _searchController,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Search settings...',
                hintStyle: TextStyle(
                  color: _getTextMutedColor(isDark),
                  fontSize: 13,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 18,
                  color: _getTextMutedColor(isDark),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 16,
                          color: _getTextMutedColor(isDark),
                        ),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                filled: true,
                fillColor: _getCardColor(isDark, isAmoled),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: _getBorderColor(isDark, isAmoled),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: _getBorderColor(isDark, isAmoled),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 1.5,
                  ),
                ),
              ),
              onChanged: (query) => setState(() => _searchQuery = query),
            ),
          ),
          Divider(
            color: _getBorderColor(isDark, isAmoled),
            height: 1,
          ),
          // Search results hint
          if (_searchQuery.isNotEmpty && searchResults.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                '${searchResults.values.fold<int>(0, (sum, list) => sum + list.length)} results found',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          if (_searchQuery.isNotEmpty && searchResults.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'No matching settings',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getTextMutedColor(isDark),
                    ),
              ),
            ),
          // Navigation Items
          Expanded(
            child: Scrollbar(
              controller: _navScrollController,
              thumbVisibility: true,
              child: ListView(
                controller: _navScrollController,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                children: filteredCategories.map((category) {
                  final matchCount = searchResults[category]?.length;
                  return _buildNavItem(
                    context,
                    category,
                    isDark,
                    matchCount: matchCount,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    SettingsCategory category,
    bool isDark, {
    int? matchCount,
  }) {
    final isSelected = _selectedCategory == category;
    final theme = Theme.of(context);
    final hasMatch = matchCount != null && matchCount > 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () => setState(() => _selectedCategory = category),
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary.withAlpha(25)
                  : hasMatch
                      ? theme.colorScheme.primary.withAlpha(10)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? theme.colorScheme.primary.withAlpha(50)
                    : hasMatch
                        ? theme.colorScheme.primary.withAlpha(30)
                        : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _getCategoryIcon(category),
                  size: 20,
                  color: isSelected || hasMatch
                      ? theme.colorScheme.primary
                      : (isDark
                          ? AppThemeV2.darkTextMuted
                          : AppThemeV2.lightTextMuted),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _getCategoryLabel(category),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : hasMatch
                              ? theme.colorScheme.primary.withAlpha(200)
                              : (isDark
                                  ? AppThemeV2.darkTextSecondary
                                  : AppThemeV2.lightTextSecondary),
                    ),
                  ),
                ),
                // Match count badge
                if (hasMatch)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withAlpha(30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$matchCount',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(SettingsCategory category) {
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
      case SettingsCategory.windowsIntegrations:
        return Icons.window_rounded;
      case SettingsCategory.about:
        return Icons.info_rounded;
    }
  }

  String _getCategoryLabel(SettingsCategory category) {
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
        return 'Version Control';
      case SettingsCategory.windowsIntegrations:
        return 'Windows';
      case SettingsCategory.about:
        return 'About';
    }
  }

  String _getCategoryTitle(SettingsCategory category) {
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
        return 'Version Control (Git)';
      case SettingsCategory.windowsIntegrations:
        return 'Windows Integrations';
      case SettingsCategory.about:
        return 'About';
    }
  }

  Widget _buildSettingsContent(
    BuildContext context,
    SettingsState state,
    bool isDark,
    bool isAmoled,
  ) {
    final theme = Theme.of(context);
    final settings = state.appSettings;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                _getCategoryIcon(_selectedCategory),
                size: 28,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _getCategoryTitle(_selectedCategory),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (_selectedCategory != SettingsCategory.about)
                TextButton.icon(
                  onPressed: () =>
                      _showResetCategoryDialog(context, _selectedCategory),
                  icon: Icon(Icons.refresh_rounded,
                      size: 18, color: _getTextMutedColor(isDark)),
                  label: Text(
                    'Reset',
                    style: TextStyle(color: _getTextMutedColor(isDark)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),

          // Content
          Expanded(
            child: Scrollbar(
              controller: _contentScrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _contentScrollController,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  layoutBuilder: (currentChild, previousChildren) {
                    return Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        ...previousChildren,
                        if (currentChild != null) currentChild,
                      ],
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey(_selectedCategory),
                    child:
                        _buildCategoryContent(context, state, isDark, isAmoled),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryContent(
    BuildContext context,
    SettingsState state,
    bool isDark,
    bool isAmoled,
  ) {
    final settings = state.appSettings;
    switch (_selectedCategory) {
      case SettingsCategory.general:
        return _buildGeneralSettings(context, settings, isDark, isAmoled);
      case SettingsCategory.comparisonEngine:
        return _buildComparisonSettings(context, settings, isDark, isAmoled);
      case SettingsCategory.appearance:
        return _buildAppearanceSettings(context, settings, isDark, isAmoled);
      case SettingsCategory.fileHandling:
        return _buildFileHandlingSettings(context, settings, isDark, isAmoled);
      case SettingsCategory.aiServices:
        return _buildAiServicesSettings(context, state, isDark, isAmoled);
      case SettingsCategory.versionControl:
        return _buildVersionControlSettings(
            context, settings, isDark, isAmoled);
      case SettingsCategory.windowsIntegrations:
        return _buildWindowsIntegrationsSettings(
            context, settings, isDark, isAmoled);
      case SettingsCategory.about:
        return _buildAboutSettings(context, isDark, isAmoled);
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SETTINGS CARDS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildSettingsCard({
    required BuildContext context,
    required String title,
    required List<Widget> children,
    bool isDark = false,
    bool isAmoled = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _getCardColor(isDark, isAmoled),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _getBorderColor(isDark, isAmoled),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: _getTextSecondaryColor(isDark),
                  ),
            ),
          ),
          Divider(
            color: _getBorderColor(isDark, isAmoled),
            height: 1,
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingRow({
    required BuildContext context,
    required String label,
    required Widget control,
    String? description,
    bool isDark = false,
    bool isAmoled = false,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: _getTextMutedColor(isDark),
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              control,
            ],
          ),
        ),
        if (showDivider)
          Divider(
            color: _getBorderColor(isDark, isAmoled),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }

  Widget _buildDropdown(
    BuildContext context,
    String? value,
    List<String> items,
    ValueChanged<String?> onChanged,
    bool isDark,
    bool isAmoled,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: _getSurfaceColor(isDark, isAmoled),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getBorderColor(isDark, isAmoled),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyMedium,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // GENERAL SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildGeneralSettings(
      BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
    return Column(
      children: [
        _buildSettingsCard(
          context: context,
          title: 'Application',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Language',
              description: 'Application interface language',
              control: _buildDropdown(
                  context, settings.appLanguage, _appLanguages, (val) {
                if (val != null)
                  context.read<SettingsBloc>().add(UpdateAppLanguage(val));
              }, isDark, isAmoled),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Default View',
              description: 'View to show on startup',
              control: _buildDropdown(
                  context, settings.defaultViewOnStartup, _defaultViews, (val) {
                if (val != null)
                  context
                      .read<SettingsBloc>()
                      .add(UpdateDefaultViewOnStartup(val));
              }, isDark, isAmoled),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Auto-Check Updates',
              description: 'Check for updates on startup',
              control: Switch(
                value: settings.autoCheckForUpdates,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateAutoCheckForUpdates(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Startup Options',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Remember Window Position',
              description: 'Restore window size and position on startup',
              control: Switch(
                value: settings.rememberWindowPosition,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateRememberWindowPosition(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Open Last Project',
              description: 'Automatically load the last comparison on startup',
              control: Switch(
                value: settings.openLastProjectOnStartup,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateOpenLastProjectOnStartup(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Start Minimized to Tray',
              description: 'Minimize window to system tray on startup',
              control: Switch(
                value: settings.startMinimizedToTray,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateStartMinimizedToTray(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Danger Zone',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  FilledButton.icon(
                    onPressed: () => _showResetAllSettingsDialog(context),
                    icon: const Icon(Icons.restart_alt_rounded, size: 18),
                    label: const Text('Reset All Settings'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppThemeV2.error,
                      minimumSize: const Size(double.infinity, 44),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This will reset all settings to their default values',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // COMPARISON SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildComparisonSettings(
      BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
    return Column(
      children: [
        _buildSettingsCard(
          context: context,
          title: 'Comparison Behavior',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Ignore Case',
              description: 'Treat "Key" and "key" as the same',
              control: Switch(
                key: const Key('settings_ignoreCase_switch'),
                value: settings.ignoreCase,
                onChanged: (val) =>
                    context.read<SettingsBloc>().add(UpdateIgnoreCase(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Ignore Whitespace',
              description: 'Ignore leading/trailing spaces',
              control: Switch(
                key: const Key('settings_ignoreWhitespace_switch'),
                value: settings.ignoreWhitespace,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateIgnoreWhitespace(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Similarity Threshold',
              description:
                  'Minimum similarity for "Modified" detection (${(settings.similarityThreshold * 100).round()}%)',
              control: SizedBox(
                width: 200,
                child: Slider(
                  value: settings.similarityThreshold,
                  min: 0.5,
                  max: 1.0,
                  divisions: 10,
                  label: '${(settings.similarityThreshold * 100).round()}%',
                  onChanged: (val) => context
                      .read<SettingsBloc>()
                      .add(UpdateSimilarityThreshold(val)),
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Comparison Mode',
              description: 'How to match entries between files',
              control: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDropdown(
                      context, settings.comparisonMode, _comparisonModes,
                      (val) {
                    if (val != null)
                      context
                          .read<SettingsBloc>()
                          .add(UpdateComparisonMode(val));
                  }, isDark, isAmoled),
                  const SizedBox(width: 8),
                  Tooltip(
                    richMessage: const TextSpan(
                      children: [
                        TextSpan(
                            text: 'Key-based: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Matches by key name (default).\n\n'),
                        TextSpan(
                            text: 'Order-based: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Matches by position in file.\n\n'),
                        TextSpan(
                            text: 'Smart Match: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Detects moved/renamed keys.'),
                      ],
                    ),
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                      color: isDark
                          ? AppThemeV2.darkTextMuted
                          : AppThemeV2.lightTextMuted,
                    ),
                  ),
                ],
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Ignore Patterns',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            if (settings.ignorePatterns.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'No ignore patterns set.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppThemeV2.darkTextMuted
                            : AppThemeV2.lightTextMuted,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              )
            else
              ...settings.ignorePatterns.map(
                  (pattern) => _buildPatternItem(context, pattern, isDark)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildPatternPresets(context),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton.icon(
                key: const Key('settings_addPattern_button'),
                onPressed: () => _showAddPatternDialog(context, isDark),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add Pattern'),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPatternItem(BuildContext context, String pattern, bool isDark) {
    return Padding(
      key: Key('ignorePattern_tile_$pattern'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            Icons.code_rounded,
            size: 16,
            color:
                isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              pattern,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                  ),
            ),
          ),
          IconButton(
            key: Key('ignorePattern_delete_$pattern'),
            icon: Icon(Icons.delete_outline_rounded,
                size: 18, color: AppThemeV2.error),
            onPressed: () =>
                context.read<SettingsBloc>().add(RemoveIgnorePattern(pattern)),
            tooltip: 'Remove pattern',
          ),
        ],
      ),
    );
  }

  Widget _buildPatternPresets(BuildContext context) {
    final presets = {
      'Comments': ['^//.*', '^#.*'],
      'Temp Keys': ['^temp_.*', '^test_.*'],
      'Placeholders': ['^TODO_.*', '^PLACEHOLDER_.*'],
      'Dev Only': ['^DEBUG_.*', '^DEV_.*'],
    };

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: presets.entries
          .map(
            (entry) => OutlinedButton.icon(
              icon: const Icon(Icons.add, size: 16),
              label: Text(entry.key),
              onPressed: () {
                for (final pattern in entry.value) {
                  context.read<SettingsBloc>().add(AddIgnorePattern(pattern));
                }
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildPresetButtons(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _themePresets.entries.map((entry) {
        return OutlinedButton(
          onPressed: () {
            final preset = entry.value;
            context.read<SettingsBloc>().add(UpdateDiffColors(
                  addedColor: preset.added.toARGB32(),
                  removedColor: preset.removed.toARGB32(),
                  modifiedColor: preset.modified.toARGB32(),
                ));
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            visualDensity: VisualDensity.compact,
          ),
          child: Text(entry.key),
        );
      }).toList(),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // APPEARANCE SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildAppearanceSettings(
      BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
    return Column(
      children: [
        _buildSettingsCard(
          context: context,
          title: 'Theme',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Application Theme',
              description: 'Choose light, dark, or AMOLED',
              control: _buildDropdown(
                  context, settings.appThemeMode, _themeModes, (val) {
                if (val != null)
                  context.read<SettingsBloc>().add(UpdateAppThemeMode(val));
              }, isDark, isAmoled),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Diff Font Size',
              description: 'Adjust the font size of the comparison view',
              control: SizedBox(
                width: 200,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Slider(
                        value: settings.diffFontSize,
                        min: 10,
                        max: 18,
                        divisions: 8,
                        label: '${settings.diffFontSize.round()}px',
                        onChanged: (value) => context
                            .read<SettingsBloc>()
                            .add(UpdateDiffFontSize(value)),
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${settings.diffFontSize.round()}px',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Diff Font Family',
              description: 'Font for comparison view',
              control: Builder(
                builder: (context) {
                  // Safe getter for diffFontFamily - handles old data gracefully
                  String fontFamily;
                  try {
                    fontFamily = settings.diffFontFamily;
                    if (fontFamily.isEmpty) fontFamily = 'System Default';
                  } catch (_) {
                    fontFamily = 'System Default';
                  }
                  return _buildDropdown(
                    context,
                    fontFamily,
                    _fontFamilies,
                    (val) {
                      if (val != null) {
                        context
                            .read<SettingsBloc>()
                            .add(UpdateDiffFontFamily(val));
                      }
                    },
                    isDark,
                    isAmoled,
                  );
                },
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Accent Color',
              control: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Color(settings.accentColorValue),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _getBorderColor(isDark, isAmoled),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () => _showAccentColorPicker(
                        context, Color(settings.accentColorValue)),
                    child: const Text('Change'),
                  ),
                ],
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Diff Colors',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                'Presets',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: _buildPresetButtons(context),
            ),
            Divider(
              color: _getBorderColor(isDark, isAmoled),
              height: 1,
              indent: 16,
              endIndent: 16,
            ),
            _buildColorRow(context, 'Added', Color(settings.diffAddedColor),
                (color) {
              context
                  .read<SettingsBloc>()
                  .add(UpdateDiffAddedColor(color.toARGB32()));
            }, isDark, isAmoled),
            _buildColorRow(context, 'Removed', Color(settings.diffRemovedColor),
                (color) {
              context
                  .read<SettingsBloc>()
                  .add(UpdateDiffRemovedColor(color.toARGB32()));
            }, isDark, isAmoled),
            _buildColorRow(
                context, 'Modified', Color(settings.diffModifiedColor),
                (color) {
              context
                  .read<SettingsBloc>()
                  .add(UpdateDiffModifiedColor(color.toARGB32()));
            }, isDark, isAmoled),
            _buildColorRow(
                context, 'Identical', Color(settings.diffIdenticalColor),
                (color) {
              context
                  .read<SettingsBloc>()
                  .add(UpdateDiffIdenticalColor(color.toARGB32()));
            }, isDark, isAmoled, showDivider: false),
          ],
        ),
        _buildPreviewPanel(context, settings, isDark, isAmoled),
      ],
    );
  }

  Widget _buildColorRow(
    BuildContext context,
    String label,
    Color color,
    ValueChanged<Color> onChanged,
    bool isDark,
    bool isAmoled, {
    bool showDivider = true,
  }) {
    return _buildSettingRow(
      context: context,
      label: label,
      control: InkWell(
        onTap: () => _showColorPicker(context, color, onChanged),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 40,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _getBorderColor(isDark, isAmoled),
            ),
          ),
        ),
      ),
      isDark: isDark,
      showDivider: showDivider,
    );
  }

  Widget _buildPreviewPanel(
      BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
    // Get font family with safe fallback
    String fontFamily;
    try {
      fontFamily = settings.diffFontFamily;
      if (fontFamily.isEmpty) fontFamily = 'System Default';
    } catch (_) {
      fontFamily = 'System Default';
    }
    final String actualFontFamily = fontFamily == 'System Default'
        ? 'Consolas, Monaco, monospace'
        : fontFamily;
    final double fontSize = settings.diffFontSize;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _getCardColor(isDark, isAmoled),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _getBorderColor(isDark, isAmoled),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Icon(
                  Icons.visibility_rounded,
                  size: 16,
                  color: _getTextMutedColor(isDark),
                ),
                const SizedBox(width: 8),
                Text(
                  'Live Preview',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _getTextSecondaryColor(isDark),
                      ),
                ),
              ],
            ),
          ),
          Divider(
            color: _getBorderColor(isDark, isAmoled),
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildPreviewEntry(
                  context: context,
                  lineNumber: 42,
                  status: 'ADDED',
                  color: Color(settings.diffAddedColor),
                  key: 'welcome_message',
                  value: '"Hello, welcome to our app!"',
                  isDark: isDark,
                  isAmoled: isAmoled,
                  fontFamily: actualFontFamily,
                  fontSize: fontSize,
                ),
                const SizedBox(height: 8),
                _buildPreviewEntry(
                  context: context,
                  lineNumber: 58,
                  status: 'REMOVED',
                  color: Color(settings.diffRemovedColor),
                  key: 'old_greeting',
                  value: '"Greetings, user"',
                  isDark: isDark,
                  isAmoled: isAmoled,
                  fontFamily: actualFontFamily,
                  fontSize: fontSize,
                ),
                const SizedBox(height: 8),
                _buildPreviewEntry(
                  context: context,
                  lineNumber: 73,
                  status: 'MODIFIED',
                  color: Color(settings.diffModifiedColor),
                  key: 'button_label',
                  value: '"Submit" → "Continue"',
                  isDark: isDark,
                  isAmoled: isAmoled,
                  fontFamily: actualFontFamily,
                  fontSize: fontSize,
                ),
                const SizedBox(height: 8),
                _buildPreviewEntry(
                  context: context,
                  lineNumber: 89,
                  status: 'IDENTICAL',
                  color: Color(settings.diffIdenticalColor),
                  key: 'app_name',
                  value: '"Localizer Tool"',
                  isDark: isDark,
                  isAmoled: isAmoled,
                  fontFamily: actualFontFamily,
                  fontSize: fontSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewEntry({
    required BuildContext context,
    required int lineNumber,
    required String status,
    required Color color,
    required String key,
    required String value,
    required bool isDark,
    required bool isAmoled,
    required String fontFamily,
    required double fontSize,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          // Line number
          Container(
            width: 28,
            alignment: Alignment.center,
            child: Text(
              '$lineNumber',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppThemeV2.darkTextMuted
                        : AppThemeV2.lightTextMuted,
                    fontFamily: fontFamily,
                    fontSize: 11,
                  ),
            ),
          ),
          const SizedBox(width: 8),
          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Key and value
          Expanded(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontFamily: fontFamily,
                      fontSize: fontSize,
                    ),
                children: [
                  TextSpan(
                    text: key,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ': ',
                    style: TextStyle(
                      color: isDark
                          ? AppThemeV2.darkTextMuted
                          : AppThemeV2.lightTextMuted,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      color: isDark
                          ? AppThemeV2.darkTextSecondary
                          : AppThemeV2.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FILE HANDLING SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> _pickBackupDirectory() async {
    final selected = await FilePicker.platform.getDirectoryPath();
    if (!mounted || selected == null) {
      return;
    }
    context.read<SettingsBloc>().add(UpdateBackupDirectory(selected));
  }

  Widget _buildFileHandlingSettings(
      BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
    return Column(
      children: [
        _buildSettingsCard(
          context: context,
          title: 'File Formats',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Source Format',
              control: _buildDropdown(context, settings.defaultSourceFormat,
                  ['Auto', ..._fileFormats], (val) {
                if (val != null)
                  context
                      .read<SettingsBloc>()
                      .add(UpdateDefaultSourceFormat(val));
              }, isDark, isAmoled),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Target Format',
              control: _buildDropdown(context, settings.defaultTargetFormat,
                  ['Auto', ..._fileFormats], (val) {
                if (val != null)
                  context
                      .read<SettingsBloc>()
                      .add(UpdateDefaultTargetFormat(val));
              }, isDark, isAmoled),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Encoding',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Source Encoding',
              control: _buildDropdown(
                  context, settings.defaultSourceEncoding, _encodings, (val) {
                if (val != null)
                  context
                      .read<SettingsBloc>()
                      .add(UpdateDefaultSourceEncoding(val));
              }, isDark, isAmoled),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Target Encoding',
              control: _buildDropdown(
                  context, settings.defaultTargetEncoding, _encodings, (val) {
                if (val != null)
                  context
                      .read<SettingsBloc>()
                      .add(UpdateDefaultTargetEncoding(val));
              }, isDark, isAmoled),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Auto-Detect',
              description: 'Automatically detect file encoding',
              control: Switch(
                value: settings.autoDetectEncoding,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateAutoDetectEncoding(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Export Settings',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Default Export Format',
              control: _buildDropdown(context, settings.defaultExportFormat,
                  ['CSV', 'JSON', 'Excel'], (val) {
                if (val != null)
                  context
                      .read<SettingsBloc>()
                      .add(UpdateDefaultExportFormat(val));
              }, isDark, isAmoled),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Include UTF-8 BOM',
              description: 'Required for Excel compatibility',
              control: Switch(
                value: settings.includeUtf8Bom,
                onChanged: (val) =>
                    context.read<SettingsBloc>().add(UpdateIncludeUtf8Bom(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Open Folder After Export',
              control: Switch(
                value: settings.openFolderAfterExport,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateOpenFolderAfterExport(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Backup',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Auto-Backup',
              description: 'Create backup before overwriting files',
              control: Switch(
                value: settings.autoBackup,
                onChanged: (val) =>
                    context.read<SettingsBloc>().add(UpdateAutoBackup(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Backup Folder',
              description: 'Leave empty to use the same folder',
              control: SizedBox(
                width: 320,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(
                          text: settings.backupDirectory,
                        ),
                        onChanged: (value) => context
                            .read<SettingsBloc>()
                            .add(UpdateBackupDirectory(value)),
                        decoration: InputDecoration(
                          hintText: 'Use original file folder',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: _pickBackupDirectory,
                      icon: const Icon(
                        Icons.folder_open_rounded,
                        size: 18,
                      ),
                      label: const Text('Browse'),
                    ),
                  ],
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Backups to Keep',
              description: 'Number of backup copies to retain',
              control: SizedBox(
                width: 150,
                child: Slider(
                  value: settings.backupsToKeep.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: settings.backupsToKeep.toString(),
                  onChanged: (val) => context
                      .read<SettingsBloc>()
                      .add(UpdateBackupsToKeep(val.round())),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // AI SERVICES SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildAiServicesSettings(
    BuildContext context,
    SettingsState state,
    bool isDark,
    bool isAmoled,
  ) {
    final settings = state.appSettings;

    // Determine available models based on selected service
    List<String> validModels = [];
    if (settings.aiTranslationService == 'Gemini') {
      validModels = state.availableModels[ApiProvider.gemini] ?? [];
      if (validModels.isEmpty) {
        validModels = ['gemini-1.5-flash', 'gemini-1.5-pro', 'gemini-1.0-pro'];
      }
    } else if (settings.aiTranslationService == 'OpenAI') {
      validModels = state.availableModels[ApiProvider.openAi] ?? [];
      if (validModels.isEmpty) {
        validModels = ['gpt-4o', 'gpt-4o-mini', 'gpt-4-turbo', 'gpt-3.5-turbo'];
      }
    }

    // Ensure current model is in list or add default/placeholder
    final List<String> dropdownItems = ['Select model...', ...validModels];
    if (!dropdownItems.contains(settings.defaultAiModel) &&
        settings.defaultAiModel.isNotEmpty) {
      dropdownItems.add(settings.defaultAiModel);
    }

    return Column(
      children: [
        // -----------------------------------------------------------
        // LLM TRANSLATION (Modern)
        // -----------------------------------------------------------
        _buildSettingsCard(
          context: context,
          title: 'AI Translation (LLM)',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Enable AI Translation',
              control: Switch(
                value: settings.enableAiTranslation,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateEnableAiTranslation(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Service Provider',
              control: _buildDropdown(
                context,
                settings.aiTranslationService,
                ['Gemini', 'OpenAI'],
                (val) {
                  if (val != null) {
                    context
                        .read<SettingsBloc>()
                        .add(UpdateAiTranslationService(val));
                  }
                },
                isDark,
                isAmoled,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            if (settings.aiTranslationService == 'Gemini' ||
                settings.aiTranslationService == 'OpenAI')
              _buildSettingRow(
                context: context,
                label: 'Default Model',
                description: 'Required for fast translate',
                control: _buildDropdown(
                  context,
                  dropdownItems.contains(settings.defaultAiModel)
                      ? settings.defaultAiModel
                      : dropdownItems.first,
                  dropdownItems,
                  (val) {
                    if (val != null && val != 'Select model...') {
                      context
                          .read<SettingsBloc>()
                          .add(UpdateDefaultAiModel(val));
                    }
                  },
                  isDark,
                  isAmoled,
                ),
                isDark: isDark,
                isAmoled: isAmoled,
              ),
            _buildSettingRow(
              context: context,
              label: 'Confidence Threshold',
              description:
                  '${(settings.translationConfidenceThreshold * 100).round()}%',
              control: SizedBox(
                width: 150,
                child: Slider(
                  value: settings.translationConfidenceThreshold,
                  min: 0.0,
                  max: 1.0,
                  divisions: 20,
                  onChanged: (val) => context
                      .read<SettingsBloc>()
                      .add(UpdateTranslationConfidenceThreshold(val)),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: true,
            ),
            const SizedBox(height: 8),
            if (settings.aiTranslationService == 'Gemini')
              _buildApiKeyRowWithTest(
                context: context,
                label: 'Gemini API Key',
                value: settings.geminiApiKey,
                onChanged: (val) {
                  context.read<SettingsBloc>().add(UpdateGeminiApiKey(val));
                },
                onTest: () {
                  context.read<SettingsBloc>().add(TestApiKey(
                        provider: ApiProvider.gemini,
                        apiKey: settings.geminiApiKey,
                      ));
                },
                testResult: state.apiKeyTests[ApiProvider.gemini] ??
                    const ApiKeyTestResult.idle(),
                isDark: isDark,
                isAmoled: isAmoled,
              ),
            if (settings.aiTranslationService == 'OpenAI')
              _buildApiKeyRowWithTest(
                context: context,
                label: 'OpenAI API Key',
                value: settings.openaiApiKey,
                onChanged: (val) {
                  context.read<SettingsBloc>().add(UpdateOpenAiApiKey(val));
                },
                onTest: () {
                  context.read<SettingsBloc>().add(TestApiKey(
                        provider: ApiProvider.openAi,
                        apiKey: settings.openaiApiKey,
                      ));
                },
                testResult: state.apiKeyTests[ApiProvider.openAi] ??
                    const ApiKeyTestResult.idle(),
                isDark: isDark,
                isAmoled: isAmoled,
                showDivider: false,
              ),
          ],
        ),

        // -----------------------------------------------------------
        // MODEL PARAMETERS
        // -----------------------------------------------------------
        if (settings.aiTranslationService == 'Gemini' ||
            settings.aiTranslationService == 'OpenAI')
          _buildSettingsCard(
            context: context,
            title: 'Model Parameters',
            isDark: isDark,
            isAmoled: isAmoled,
            children: [
              _buildSettingRow(
                context: context,
                label: 'Temperature',
                description:
                    'Creativity vs consistency (${settings.aiTemperature.toStringAsFixed(1)})',
                control: SizedBox(
                  width: 150,
                  child: Slider(
                    value: settings.aiTemperature,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    onChanged: (val) => context
                        .read<SettingsBloc>()
                        .add(UpdateAiTemperature(val)),
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                isDark: isDark,
                isAmoled: isAmoled,
              ),
              _buildSettingRow(
                context: context,
                label: 'Max Tokens',
                description: 'Maximum response length',
                control: _buildDropdown(context, settings.maxTokens.toString(),
                    ['256', '512', '1024', '2048', '4096', '8192'], (val) {
                  if (val != null)
                    context
                        .read<SettingsBloc>()
                        .add(UpdateMaxTokens(int.parse(val)));
                }, isDark, isAmoled),
                isDark: isDark,
                isAmoled: isAmoled,
              ),
            ],
          ),

        // -----------------------------------------------------------
        // TRANSLATION CONTEXT
        // -----------------------------------------------------------
        _buildSettingsCard(
          context: context,
          title: 'Translation Context',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'System Context',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 3,
                    controller: TextEditingController(
                        text: settings.systemTranslationContext),
                    onChanged: (val) => context
                        .read<SettingsBloc>()
                        .add(UpdateSystemTranslationContext(val)),
                    decoration: InputDecoration(
                      hintText:
                          'e.g., This is a fantasy RPG game. Use informal tone and "gamer" terminology.',
                      hintStyle: TextStyle(
                          color: isDark ? Colors.grey[600] : Colors.grey[400]),
                      filled: true,
                      fillColor: isAmoled
                          ? AppThemeV2.amoledSurface
                          : (isDark
                              ? AppThemeV2.darkSurface
                              : AppThemeV2.lightBackground),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: _getBorderColor(isDark, isAmoled),
                        ),
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Divider(
              color: _getBorderColor(isDark, isAmoled),
              height: 24,
              indent: 16,
              endIndent: 16,
            ),
            _buildSettingRow(
              context: context,
              label: 'Include Neighbor Context',
              description: 'Add prev/next strings to prompt',
              control: Switch(
                value: settings.includeContextStrings,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateIncludeContextStrings(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isAmoled: isAmoled,
            ),
            if (settings.includeContextStrings)
              _buildSettingRow(
                context: context,
                label: 'Context Range',
                description: '±${settings.contextStringsCount} strings',
                control: SizedBox(
                  width: 150,
                  child: Slider(
                    value: settings.contextStringsCount.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: settings.contextStringsCount.toString(),
                    onChanged: (val) => context
                        .read<SettingsBloc>()
                        .add(UpdateContextStringsCount(val.round())),
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                isAmoled: isAmoled,
                showDivider: false,
              ),
          ],
        ),

        // -----------------------------------------------------------
        // TRANSLATION MEMORY
        // -----------------------------------------------------------
        _buildSettingsCard(
          context: context,
          title: 'Translation Memory',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Enable Translation Memory',
              description: 'Suggest translations from local history',
              control: Switch(
                value: settings.enableTranslationMemory,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateEnableTranslationMemory(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
            if (_translationMemoryService == null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                child: Text(
                  'Translation memory is unavailable.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _getTextMutedColor(isDark),
                      ),
                ),
              )
            else if (settings.enableTranslationMemory) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Statistics',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    FutureBuilder<TranslationMemoryStats>(
                      future: _translationMemoryStatsFuture,
                      builder: (context, snapshot) {
                        final stats = snapshot.data;
                        final entries = stats?.entryCount ?? 0;
                        final size = stats == null
                            ? '0 KB'
                            : _formatMemorySize(stats.storageBytes);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Entries: $entries'),
                            Text('Size: $size'),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.file_upload),
                    label: const Text('Import TMX/CSV'),
                    onPressed: _translationMemoryBusy
                        ? null
                        : () => _importTranslationMemory(context),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.download),
                    label: const Text('Export TMX'),
                    onPressed: _translationMemoryBusy
                        ? null
                        : () => _exportTranslationMemoryTmx(context),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.table_chart_outlined),
                    label: const Text('Export CSV'),
                    onPressed: _translationMemoryBusy
                        ? null
                        : () => _exportTranslationMemoryCsv(context),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    onPressed: _translationMemoryBusy
                        ? null
                        : () => _confirmClearTranslationMemory(context),
                    child: const Text('Clear Memory'),
                  ),
                ],
              ),
            ],
          ],
        ),

        // -----------------------------------------------------------
        // CLASSIC APIs (Legacy)
        // -----------------------------------------------------------
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text('Classic Translation APIs (Legacy)',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isDark ? Colors.grey[400] : Colors.grey[600])),
            tilePadding: EdgeInsets.zero,
            children: [
              _buildSettingsCard(
                context: context,
                title: 'DeepL & Google',
                isDark: isDark,
                isAmoled: isAmoled,
                children: [
                  _buildSettingRow(
                    context: context,
                    label: 'Legacy Service Provider',
                    control: _buildDropdown(
                        context,
                        settings.aiTranslationService,
                        ['Google Translate', 'DeepL', 'Azure Translator'],
                        (val) {
                      if (val != null)
                        context
                            .read<SettingsBloc>()
                            .add(UpdateAiTranslationService(val));
                    }, isDark, isAmoled),
                    isAmoled: isAmoled,
                  ),
                  _buildApiKeyRowWithTest(
                    context: context,
                    label: 'Google Translate API',
                    value: settings.googleTranslateApiKey,
                    onChanged: (val) {
                      context
                          .read<SettingsBloc>()
                          .add(UpdateGoogleTranslateApiKey(val));
                    },
                    onTest: () {
                      context.read<SettingsBloc>().add(TestApiKey(
                            provider: ApiProvider.googleTranslate,
                            apiKey: settings.googleTranslateApiKey,
                          ));
                    },
                    testResult:
                        state.apiKeyTests[ApiProvider.googleTranslate] ??
                            const ApiKeyTestResult.idle(),
                    isDark: isDark,
                    isAmoled: isAmoled,
                  ),
                  _buildApiKeyRowWithTest(
                    context: context,
                    label: 'DeepL API Key',
                    value: settings.deeplApiKey,
                    onChanged: (val) {
                      context.read<SettingsBloc>().add(UpdateDeeplApiKey(val));
                    },
                    onTest: () {
                      context.read<SettingsBloc>().add(TestApiKey(
                            provider: ApiProvider.deepl,
                            apiKey: settings.deeplApiKey,
                          ));
                    },
                    testResult: state.apiKeyTests[ApiProvider.deepl] ??
                        const ApiKeyTestResult.idle(),
                    isDark: isDark,
                    isAmoled: isAmoled,
                    showDivider: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildApiKeyRowWithTest({
    required BuildContext context,
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    required VoidCallback onTest,
    required ApiKeyTestResult testResult,
    required bool isDark,
    required bool isAmoled,
    bool showDivider = true,
  }) {
    final statusWidget = _buildApiKeyStatus(
      context: context,
      result: testResult,
      isDark: isDark,
    );
    final isTesting = testResult.status == ApiKeyTestStatus.testing;

    return Column(
      children: [
        _buildSettingRow(
          context: context,
          label: label,
          control: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: TextEditingController(text: value),
                  obscureText: true,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: 'Enter API key',
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: value.isNotEmpty && !isTesting ? onTest : null,
                child: Text(isTesting ? 'Testing...' : 'Test'),
              ),
            ],
          ),
          isDark: isDark,
          isAmoled: isAmoled,
          showDivider: showDivider,
        ),
        if (statusWidget != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: statusWidget,
          ),
      ],
    );
  }

  Widget? _buildApiKeyStatus({
    required BuildContext context,
    required ApiKeyTestResult result,
    required bool isDark,
  }) {
    if (result.status == ApiKeyTestStatus.idle) {
      return null;
    }

    Color statusColor;
    switch (result.status) {
      case ApiKeyTestStatus.testing:
        statusColor = isDark ? Colors.grey[400]! : Colors.grey[700]!;
        break;
      case ApiKeyTestStatus.success:
        statusColor = Colors.green;
        break;
      case ApiKeyTestStatus.failure:
        statusColor = Colors.redAccent;
        break;
      case ApiKeyTestStatus.idle:
        statusColor = isDark ? Colors.grey[400]! : Colors.grey[700]!;
        break;
    }

    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          result.message,
          style: textTheme.bodySmall?.copyWith(color: statusColor),
        ),
        if (result.usage != null && result.usage!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              result.usage!,
              style: textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.grey[400] : Colors.grey[700],
              ),
            ),
          ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // VERSION CONTROL SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildVersionControlSettings(
      BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
    return Column(
      children: [
        _buildSettingsCard(
          context: context,
          title: 'Git Integration',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Enable Git',
              description: 'Enable version control features',
              control: Switch(
                value: settings.enableGitIntegration,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateEnableGitIntegration(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Auto-Commit',
              description: 'Commit changes on save',
              control: Switch(
                value: settings.autoCommitOnSave,
                onChanged: (val) => context
                    .read<SettingsBloc>()
                    .add(UpdateAutoCommitOnSave(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Git User',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildTextFieldRow(context, 'Name', settings.gitUserName, (val) {
              context.read<SettingsBloc>().add(UpdateGitUserName(val));
            }, isDark, isAmoled),
            _buildTextFieldRow(context, 'Email', settings.gitUserEmail, (val) {
              context.read<SettingsBloc>().add(UpdateGitUserEmail(val));
            }, isDark, isAmoled, showDivider: false),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Git Defaults',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Default Branch',
              description: 'Branch to use for new comparisons',
              control: SizedBox(
                width: 150,
                child: TextField(
                  controller:
                      TextEditingController(text: settings.defaultBranch),
                  onChanged: (val) => context
                      .read<SettingsBloc>()
                      .add(UpdateDefaultBranch(val)),
                  decoration: const InputDecoration(
                    hintText: 'main',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Default Remote',
              description: 'Remote to use for push/pull operations',
              control: SizedBox(
                width: 150,
                child: TextField(
                  controller:
                      TextEditingController(text: settings.defaultRemote),
                  onChanged: (val) => context
                      .read<SettingsBloc>()
                      .add(UpdateDefaultRemote(val)),
                  decoration: const InputDecoration(
                    hintText: 'origin',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Commit Templates',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    maxLines: 2,
                    controller: TextEditingController(
                        text: settings.commitMessageTemplate),
                    onChanged: (val) => context
                        .read<SettingsBloc>()
                        .add(UpdateCommitMessageTemplate(val)),
                    decoration: InputDecoration(
                      labelText: 'Commit Message Template',
                      hintText: 'Update localization: {files}',
                      helperText:
                          'Variables: {date}, {files}, {added}, {removed}, {modified}',
                      helperMaxLines: 2,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Presets',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.grey[400] : Colors.grey[700],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildCommitPresetChip(
                        context: context,
                        label: 'Simple',
                        template: 'Update localization: {files}',
                        isDark: isDark,
                      ),
                      _buildCommitPresetChip(
                        context: context,
                        label: 'Detailed',
                        template:
                            '[{date}] Localization update\n\nModified: {modified}\nAdded: {added}\nRemoved: {removed}',
                        isDark: isDark,
                      ),
                      _buildCommitPresetChip(
                        context: context,
                        label: 'Conventional',
                        template:
                            'chore(i18n): update translations\n\nFiles: {files}',
                        isDark: isDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'SSH Configuration',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller:
                              TextEditingController(text: settings.sshKeyPath),
                          onChanged: (val) => context
                              .read<SettingsBloc>()
                              .add(UpdateSshKeyPath(val)),
                          decoration: InputDecoration(
                            labelText: 'SSH Key Path',
                            hintText: Platform.isWindows
                                ? 'C:\\Users\\....\\.ssh\\id_rsa'
                                : '~/.ssh/id_rsa',
                            helperText:
                                'Path to your private SSH key for Git operations',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.folder_open),
                        tooltip: 'Browse...',
                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles(
                            dialogTitle: 'Select SSH Private Key',
                            type: FileType.any,
                          );
                          if (result != null && result.files.isNotEmpty) {
                            final path = result.files.first.path;
                            if (path != null && context.mounted) {
                              context
                                  .read<SettingsBloc>()
                                  .add(UpdateSshKeyPath(path));
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        icon: const Icon(Icons.content_copy, size: 18),
                        label: const Text('Copy Public Key'),
                        onPressed: settings.sshKeyPath.isEmpty
                            ? null
                            : () async {
                                final pubKeyPath = '${settings.sshKeyPath}.pub';
                                try {
                                  final file = File(pubKeyPath);
                                  if (await file.exists()) {
                                    final content = await file.readAsString();
                                    await Clipboard.setData(
                                        ClipboardData(text: content.trim()));
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Public key copied to clipboard!'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    }
                                  } else {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Public key not found: $pubKeyPath'),
                                          backgroundColor: AppThemeV2.error,
                                        ),
                                      );
                                    }
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Error reading public key: $e'),
                                        backgroundColor: AppThemeV2.error,
                                      ),
                                    );
                                  }
                                }
                              },
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Copies {key}.pub to clipboard',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color:
                                  isDark ? Colors.grey[500] : Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // WINDOWS INTEGRATIONS SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildWindowsIntegrationsSettings(
      BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
    final isWindows = Platform.isWindows;

    return Column(
      children: [
        if (!isWindows)
          _buildSettingsCard(
            context: context,
            title: 'Platform Notice',
            isDark: isDark,
            isAmoled: isAmoled,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Windows integrations are only available when running on Windows.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        _buildSettingsCard(
          context: context,
          title: 'Visual Effects',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Use Mica Effect',
              description:
                  'Enable Windows 11 Mica transparency (requires restart)',
              control: Switch(
                value: settings.useMicaEffect,
                onChanged: isWindows
                    ? (val) => context
                        .read<SettingsBloc>()
                        .add(UpdateUseMicaEffect(val))
                    : null,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: false,
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Explorer Integration',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add "Open with Localizer" to the Windows Explorer right-click menu for folders.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows
                              ? () async {
                                  final success =
                                      await WindowsIntegrationService
                                          .addToContextMenu();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(success
                                            ? 'Context menu added!'
                                            : 'Failed to add context menu'),
                                        backgroundColor: success
                                            ? Colors.green
                                            : AppThemeV2.error,
                                      ),
                                    );
                                  }
                                }
                              : null,
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: const Text('Add to Context Menu'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows
                              ? () async {
                                  final success =
                                      await WindowsIntegrationService
                                          .removeFromContextMenu();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(success
                                            ? 'Context menu removed!'
                                            : 'Failed to remove context menu'),
                                        backgroundColor: success
                                            ? Colors.green
                                            : AppThemeV2.error,
                                      ),
                                    );
                                  }
                                }
                              : null,
                          icon: const Icon(Icons.remove_rounded, size: 18),
                          label: const Text('Remove'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'File Associations',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Register file types to open with Localizer when double-clicked in Explorer.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppThemeV2.darkTextMuted
                          : AppThemeV2.lightTextMuted,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            // Per-extension toggles
            ...WindowsIntegrationService.supportedExtensions.entries
                .map((entry) {
              final ext = entry.key;
              final description = entry.value;
              final isRegistered = isWindows &&
                  WindowsIntegrationService.isFileExtensionRegistered(ext);

              return _buildSettingRow(
                context: context,
                label: ext,
                description: description,
                control: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isRegistered ? Colors.green : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isRegistered ? 'Registered' : 'Not Registered',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? AppThemeV2.darkTextMuted
                                : AppThemeV2.lightTextMuted,
                          ),
                    ),
                    const SizedBox(width: 12),
                    Switch(
                      value: isRegistered,
                      onChanged: isWindows
                          ? (val) async {
                              final success = val
                                  ? await WindowsIntegrationService
                                      .registerFileExtension(ext)
                                  : await WindowsIntegrationService
                                      .unregisterFileExtension(ext);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(success
                                        ? (val
                                            ? '$ext registered!'
                                            : '$ext unregistered!')
                                        : 'Failed to ${val ? 'register' : 'unregister'} $ext'),
                                    backgroundColor: success
                                        ? Colors.green
                                        : AppThemeV2.error,
                                  ),
                                );
                                // Trigger rebuild to update status
                                setState(() {});
                              }
                            }
                          : null,
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                isDark: isDark,
                isAmoled: isAmoled,
                showDivider: ext !=
                    WindowsIntegrationService.supportedExtensions.keys.last,
              );
            }),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: isWindows
                          ? () async {
                              final results = await WindowsIntegrationService
                                  .registerAllExtensions();
                              final successCount =
                                  results.values.where((v) => v).length;
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Registered $successCount of ${results.length} file types'),
                                    backgroundColor:
                                        successCount == results.length
                                            ? Colors.green
                                            : Colors.orange,
                                  ),
                                );
                                setState(() {});
                              }
                            }
                          : null,
                      icon: const Icon(Icons.check_circle_outline_rounded,
                          size: 18),
                      label: const Text('Register All'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: isWindows
                          ? () async {
                              final results = await WindowsIntegrationService
                                  .unregisterAllExtensions();
                              final successCount =
                                  results.values.where((v) => v).length;
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Unregistered $successCount of ${results.length} file types'),
                                    backgroundColor:
                                        successCount == results.length
                                            ? Colors.green
                                            : Colors.orange,
                                  ),
                                );
                                setState(() {});
                              }
                            }
                          : null,
                      icon: const Icon(Icons.remove_circle_outline_rounded,
                          size: 18),
                      label: const Text('Unregister All'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Protocol Handler',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register localizer:// URLs to open this application.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows
                              ? () async {
                                  final success =
                                      await WindowsIntegrationService
                                          .registerProtocolHandler();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(success
                                            ? 'Protocol handler registered!'
                                            : 'Failed to register'),
                                        backgroundColor: success
                                            ? Colors.green
                                            : AppThemeV2.error,
                                      ),
                                    );
                                  }
                                }
                              : null,
                          icon: const Icon(Icons.public_rounded, size: 18),
                          label: const Text('Register Protocol'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows
                              ? () async {
                                  final success =
                                      await WindowsIntegrationService
                                          .unregisterProtocolHandler();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(success
                                            ? 'Protocol handler removed!'
                                            : 'Failed to remove'),
                                        backgroundColor: success
                                            ? Colors.green
                                            : AppThemeV2.error,
                                      ),
                                    );
                                  }
                                }
                              : null,
                          icon: const Icon(Icons.public_off_rounded, size: 18),
                          label: const Text('Unregister'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextFieldRow(
    BuildContext context,
    String label,
    String value,
    ValueChanged<String> onChanged,
    bool isDark,
    bool isAmoled, {
    bool showDivider = true,
    String? hintText,
  }) {
    return _buildSettingRow(
      context: context,
      label: label,
      control: SizedBox(
        width: 200,
        child: TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText ?? 'Enter $label',
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      isDark: isDark,
      isAmoled: isAmoled,
      showDivider: showDivider,
    );
  }

  Widget _buildCommitPresetChip({
    required BuildContext context,
    required String label,
    required String template,
    required bool isDark,
  }) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        context.read<SettingsBloc>().add(UpdateCommitMessageTemplate(template));
      },
      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
      side: BorderSide.none,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ABOUT SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildAboutSettings(BuildContext context, bool isDark, bool isAmoled) {
    final settings = context.read<SettingsBloc>().state.appSettings;
    final theme = Theme.of(context);

    return Column(
      children: [
        _buildSettingsCard(
          context: context,
          title: 'Application Info',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildInfoRow(context, 'Version',
                _packageInfo?.version ?? 'Loading...', isDark, isAmoled),
            _buildInfoRow(context, 'Build',
                _packageInfo?.buildNumber ?? 'Loading...', isDark, isAmoled),
            _buildInfoRow(context, 'Platform', _platformInfo, isDark, isAmoled,
                showDivider: false),
          ],
        ),
        // Update Information Card
        _buildSettingsCard(
          context: context,
          title: 'Update Information',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            // Version status row
            _buildSettingRow(
              context: context,
              label: 'Current Version',
              control: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _packageInfo?.version ?? 'Loading...',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: _getTextMutedColor(isDark),
                    ),
                  ),
                  if (_updateCheckResult?.updateAvailable == true) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppThemeV2.success.withAlpha(25),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppThemeV2.success.withAlpha(100),
                        ),
                      ),
                      child: Text(
                        'Update Available!',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppThemeV2.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            // Latest version row (only show if checked)
            if (_updateCheckResult != null)
              _buildSettingRow(
                context: context,
                label: 'Latest Version',
                control: Text(
                  _updateCheckResult!.latestVersion,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: _updateCheckResult!.updateAvailable
                        ? AppThemeV2.success
                        : _getTextMutedColor(isDark),
                    fontWeight: _updateCheckResult!.updateAvailable
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
                isDark: isDark,
                isAmoled: isAmoled,
              ),
            // Last checked row
            _buildSettingRow(
              context: context,
              label: 'Last Checked',
              control: Text(
                _formatLastChecked(settings.lastUpdateCheckTime),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: _getTextMutedColor(isDark),
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            // Check for updates button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _isCheckingForUpdates
                          ? null
                          : () => _checkForUpdates(context),
                      icon: _isCheckingForUpdates
                          ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: theme.colorScheme.onPrimary,
                              ),
                            )
                          : const Icon(Icons.refresh_rounded, size: 18),
                      label: Text(
                        _isCheckingForUpdates
                            ? 'Checking...'
                            : 'Check for Updates',
                      ),
                    ),
                  ),
                  if (_updateCheckResult?.changelog != null &&
                      _updateCheckResult!.changelog!.isNotEmpty) ...[
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () => _showChangelogDialog(context, isDark),
                      icon: const Icon(Icons.notes_rounded, size: 18),
                      label: const Text("What's New"),
                    ),
                  ],
                  if (_updateCheckResult?.updateAvailable == true &&
                      _updateCheckResult?.downloadUrl != null) ...[
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: () =>
                          _launchUrl(_updateCheckResult!.downloadUrl!),
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text('Download'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppThemeV2.success,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Divider(
              color: _getBorderColor(isDark, isAmoled),
              height: 1,
              indent: 16,
              endIndent: 16,
            ),
            // Auto check for updates toggle
            _buildSettingRow(
              context: context,
              label: 'Auto-check for updates',
              description: 'Check for updates when the app starts',
              control: Switch(
                value: settings.autoCheckForUpdates,
                onChanged: (value) {
                  context
                      .read<SettingsBloc>()
                      .add(UpdateAutoCheckForUpdates(value));
                },
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            // Error message if update check failed
            if (_updateCheckResult?.error != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppThemeV2.error.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppThemeV2.error.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          size: 18, color: AppThemeV2.error),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Could not check for updates. Please check your internet connection.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppThemeV2.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        // System Information Card
        _buildSettingsCard(
          context: context,
          title: 'System Information',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildInfoRow(
              context,
              'Dart Version',
              _systemInfo?.dartVersion ?? 'Loading...',
              isDark,
              isAmoled,
            ),
            _buildInfoRow(
              context,
              'Available Disk Space',
              _systemInfo?.availableDiskSpace ?? 'Loading...',
              isDark,
              isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Memory Usage',
              control: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _systemInfo != null
                        ? '${_systemInfo!.memoryUsage} / ${_systemInfo!.totalMemory}'
                        : 'Loading...',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: _getTextMutedColor(isDark),
                    ),
                  ),
                ],
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: OutlinedButton.icon(
                onPressed: () async {
                  setState(() {
                    _systemInfo = null;
                  });
                  await _loadSystemInfo();
                },
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Refresh'),
              ),
            ),
          ],
        ),
        // Privacy & Telemetry Card
        _buildSettingsCard(
          context: context,
          title: 'Privacy & Telemetry',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildSettingRow(
              context: context,
              label: 'Anonymous Usage Statistics',
              description:
                  'Help improve the app by sending anonymous usage data',
              control: Switch(
                value: settings.enableAnonymousUsageStatistics,
                onChanged: (value) {
                  context
                      .read<SettingsBloc>()
                      .add(UpdateEnableAnonymousUsageStatistics(value));
                },
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Crash Reporting',
              description:
                  'Automatically send crash reports to help fix issues',
              control: Switch(
                value: settings.enableCrashReporting,
                onChanged: (value) {
                  context
                      .read<SettingsBloc>()
                      .add(UpdateEnableCrashReporting(value));
                },
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildLinkRow(
              context,
              'Privacy Policy',
              Icons.privacy_tip_rounded,
              () => _launchUrl(
                  'https://github.com/KhazP/LocalizerAppMain/blob/main/PRIVACY.md'),
              isDark,
              isAmoled,
              showDivider: false,
            ),
          ],
        ),
        // Settings Management Card
        _buildSettingsCard(
          context: context,
          title: 'Settings Management',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Export your settings to a file to back them up or share with other machines. Import settings from a previously exported file.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getTextMutedColor(isDark),
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.upload_rounded, size: 18),
                          label: const Text('Export Settings'),
                          onPressed: () => _exportSettings(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.download_rounded, size: 18),
                          label: const Text('Import Settings'),
                          onPressed: () => _importSettings(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Links',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildLinkRow(
                context,
                'GitHub Repository',
                Icons.code_rounded,
                () => _launchUrl('https://github.com/KhazP/LocalizerAppMain'),
                isDark,
                isAmoled),
            _buildLinkRow(
                context,
                'Report Issue',
                Icons.bug_report_rounded,
                () => _launchUrl(
                    'https://github.com/KhazP/LocalizerAppMain/issues'),
                isDark,
                isAmoled),
            _buildLinkRow(context, 'Licenses', Icons.article_rounded,
                () => _showLicensesDialog(context, isDark), isDark, isAmoled,
                showDivider: false),
          ],
        ),
      ],
    );
  }

  String _formatLastChecked(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) {
      return 'Never';
    }
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inDays < 1) {
        return '${difference.inHours} hours ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return DateFormat('MMM d, yyyy').format(dateTime);
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  Future<void> _checkForUpdates(BuildContext context) async {
    if (_updateCheckerService == null || _isCheckingForUpdates) return;

    setState(() {
      _isCheckingForUpdates = true;
    });

    try {
      final result = await _updateCheckerService!.checkForUpdates();
      if (mounted) {
        setState(() {
          _updateCheckResult = result;
          _isCheckingForUpdates = false;
        });

        // Update the last check time in settings
        context.read<SettingsBloc>().add(
              UpdateLastUpdateCheckTime(DateTime.now().toIso8601String()),
            );

        // Show a snackbar with the result
        final message = result.error != null
            ? 'Could not check for updates'
            : result.updateAvailable
                ? 'Update available: v${result.latestVersion}'
                : 'You are using the latest version';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCheckingForUpdates = false;
        });
      }
    }
  }

  void _showChangelogDialog(BuildContext context, bool isDark) {
    if (_updateCheckResult?.changelog == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.notes_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Text("What's New in v${_updateCheckResult!.latestVersion}"),
          ],
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: SelectableText(
              _updateCheckResult!.changelog!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        actions: [
          if (_updateCheckResult?.downloadUrl != null)
            FilledButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                _launchUrl(_updateCheckResult!.downloadUrl!);
              },
              icon: const Icon(Icons.download_rounded, size: 18),
              label: const Text('Download Update'),
              style: FilledButton.styleFrom(
                backgroundColor: AppThemeV2.success,
              ),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportSettings(BuildContext context) async {
    try {
      final settings = context.read<SettingsBloc>().state.appSettings;
      final jsonString =
          const JsonEncoder.withIndent('  ').convert(settings.toJson());

      // Generate default filename with timestamp
      final timestamp = DateFormat('yyyy-MM-dd_HHmmss').format(DateTime.now());
      final defaultFileName = 'localizer_settings_$timestamp.json';

      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Export Settings',
        fileName: defaultFileName,
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        final file = File(result);
        await file.writeAsString(jsonString);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Settings exported successfully!'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: AppThemeV2.success,
            ),
          );
        }
      }
    } catch (e) {
      developer.log('Error exporting settings: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to export settings: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: AppThemeV2.error,
          ),
        );
      }
    }
  }

  Future<void> _importSettings(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Import Settings',
        type: FileType.custom,
        allowedExtensions: ['json'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final filePath = result.files.first.path;
        if (filePath == null) return;

        final file = File(filePath);
        final jsonString = await file.readAsString();
        final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

        // Validate the JSON has expected structure
        if (!jsonMap.containsKey('appThemeMode') ||
            !jsonMap.containsKey('defaultSourceFormat')) {
          throw const FormatException('Invalid settings file format');
        }

        // Show confirmation dialog
        if (context.mounted) {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.amber),
                  SizedBox(width: 12),
                  Text('Import Settings?'),
                ],
              ),
              content: const Text(
                'This will replace all your current settings with the imported ones. '
                'This action cannot be undone.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  child: const Text('Import'),
                ),
              ],
            ),
          );

          if (confirmed != true) return;

          // Parse and apply the settings
          final importedSettings = AppSettings.fromJson(jsonMap);

          // Apply all settings through the bloc
          // Apply all settings through the bloc - use the new atomic event
          context
              .read<SettingsBloc>()
              .add(ReplaceAllSettings(importedSettings));

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Settings imported successfully!'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: AppThemeV2.success,
              ),
            );
          }
        }
      }
    } catch (e) {
      developer.log('Error importing settings: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to import settings: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: AppThemeV2.error,
          ),
        );
      }
    }
  }

  Widget _buildInfoRow(BuildContext context, String label, String value,
      bool isDark, bool isAmoled,
      {bool showDivider = true}) {
    return _buildSettingRow(
      context: context,
      label: label,
      control: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color:
                  isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
            ),
      ),
      isDark: isDark,
      isAmoled: isAmoled,
      showDivider: showDivider,
    );
  }

  Widget _buildLinkRow(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
    bool isDark,
    bool isAmoled, {
    bool showDivider = true,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon,
                    size: 20, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                    child: Text(label,
                        style: Theme.of(context).textTheme.bodyMedium)),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: isDark
                      ? AppThemeV2.darkTextMuted
                      : AppThemeV2.lightTextMuted,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            color: _getBorderColor(isDark, isAmoled),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DIALOGS
  // ═══════════════════════════════════════════════════════════════════════════

  void _showColorPicker(BuildContext context, Color initialColor,
      ValueChanged<Color> onColorSelected) {
    Color pickerColor = initialColor;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) => pickerColor = color,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              onColorSelected(pickerColor);
              Navigator.of(context).pop();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showAccentColorPicker(BuildContext context, Color initialColor) {
    _showColorPicker(context, initialColor, (color) {
      context.read<SettingsBloc>().add(UpdateAccentColor(color.toARGB32()));
    });
  }

  void _showAddPatternDialog(BuildContext context, bool isDark) {
    _newPatternController.clear();
    String? errorMessage;
    String testString = '';
    bool? matchResult;
    final settingsBloc = context.read<SettingsBloc>();

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          void submitPattern() {
            if (_newPatternController.text.isNotEmpty && errorMessage == null) {
              settingsBloc.add(AddIgnorePattern(_newPatternController.text));
              Navigator.of(dialogContext).pop();
            }
          }

          void validateAndTest(String pattern) {
            try {
              final regex = RegExp(pattern);
              setState(() {
                errorMessage = null;
                if (testString.isNotEmpty && pattern.isNotEmpty) {
                  matchResult = regex.hasMatch(testString);
                } else {
                  matchResult = null;
                }
              });
            } catch (e) {
              setState(() {
                errorMessage = 'Invalid regex pattern';
                matchResult = null;
              });
            }
          }

          return AlertDialog(
            title: const Text('Add Ignore Pattern'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  key: const Key('addPattern_textField'),
                  controller: _newPatternController,
                  decoration: InputDecoration(
                    hintText: 'e.g., ^temp_.*',
                    labelText: 'Pattern (regex)',
                    errorText: errorMessage,
                  ),
                  autofocus: true,
                  onChanged: (value) => validateAndTest(value),
                  onSubmitted: (_) => submitPattern(),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Test String',
                    hintText: 'Enter a key to test against pattern',
                    suffixIcon: matchResult == null
                        ? null
                        : Icon(
                            matchResult! ? Icons.check_circle : Icons.cancel,
                            color: matchResult! ? Colors.green : Colors.red,
                          ),
                  ),
                  onChanged: (value) {
                    testString = value;
                    validateAndTest(_newPatternController.text);
                  },
                ),
                if (matchResult != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      matchResult!
                          ? '✓ Pattern matches test string'
                          : '✗ Pattern does not match',
                      style: TextStyle(
                        color: matchResult! ? Colors.green : Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                key: const Key('addPattern_cancelButton'),
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Cancel'),
              ),
              FilledButton(
                key: const Key('addPattern_addButton'),
                onPressed: errorMessage == null &&
                        _newPatternController.text.isNotEmpty
                    ? submitPattern
                    : null,
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showResetCategoryDialog(
      BuildContext context, SettingsCategory category) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Reset ${_getCategoryTitle(category)}?'),
        content: const Text(
            'This will reset all settings in this category to their default values.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              final bloc = context.read<SettingsBloc>();
              switch (category) {
                case SettingsCategory.general:
                  bloc.add(ResetGeneralSettings());
                  break;
                case SettingsCategory.comparisonEngine:
                  bloc.add(ResetComparisonSettings());
                  break;
                case SettingsCategory.appearance:
                  bloc.add(ResetAppearanceSettings());
                  break;
                case SettingsCategory.fileHandling:
                  bloc.add(ResetFileHandlingSettings());
                  break;
                case SettingsCategory.aiServices:
                  bloc.add(ResetAiServicesSettings());
                  break;
                case SettingsCategory.versionControl:
                  bloc.add(ResetVersionControlSettings());
                  break;
                case SettingsCategory.windowsIntegrations:
                  break; // No reset event for Windows Integrations
                case SettingsCategory.about:
                  break; // No reset for About
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('${_getCategoryTitle(category)} reset to defaults'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: AppThemeV2.warning),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showResetAllSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reset All Settings?'),
        content: const Text(
            'This will permanently reset all settings to their factory defaults. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<SettingsBloc>().add(ResetAllSettings());
            },
            style: FilledButton.styleFrom(backgroundColor: AppThemeV2.error),
            child: const Text('Reset All'),
          ),
        ],
      ),
    );
  }

  void _showLicensesDialog(BuildContext context, bool isDark) {
    showLicensePage(
      context: context,
      applicationName: _packageInfo?.appName ?? 'Localizer',
      applicationVersion: _packageInfo?.version ?? '',
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _ThemePreset {
  final Color added;
  final Color removed;
  final Color modified;

  const _ThemePreset({
    required this.added,
    required this.removed,
    required this.modified,
  });
}
