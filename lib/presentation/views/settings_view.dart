import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:localizer_app_main/core/services/windows_integration_service.dart';

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

class _SettingsViewState extends State<SettingsView> with SingleTickerProviderStateMixin {
  SettingsCategory _selectedCategory = SettingsCategory.general;
  final TextEditingController _newPatternController = TextEditingController();
  final ScrollController _navScrollController = ScrollController();
  final ScrollController _contentScrollController = ScrollController();
  
  PackageInfo? _packageInfo;
  String _platformInfo = 'Loading...';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _fileFormats = [
    'json', 'xml', 'yaml', 'yml', 'csv', 'arb', 'xliff', 'properties', 'resx', 'lang', 'txt', 'docx'
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
  final List<String> _defaultViews = ['Basic Comparison', 'History View', 'Files', 'Last Used View'];
  final List<String> _encodings = ['UTF-8', 'UTF-16', 'UTF-16BE', 'UTF-16LE', 'ASCII', 'ISO-8859-1'];
  final List<String> _themeModes = ['System', 'Light', 'Dark', 'Amoled'];
  final List<String> _comparisonModes = ['Key-based', 'Order-based', 'Smart Match'];
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
      added: Color(0xFF0077BB),    // Blue
      removed: Color(0xFFEE7733),  // Orange
      modified: Color(0xFF009988), // Teal
    ),
    'High Contrast': const _ThemePreset(
      added: Colors.greenAccent,
      removed: Colors.redAccent,
      modified: Colors.yellowAccent,
    ),
    'Nord': const _ThemePreset(
      added: Color(0xFFA3BE8C),    // Nord green
      removed: Color(0xFFBF616A),  // Nord red
      modified: Color(0xFFEBCB8B), // Nord yellow
    ),
    'Solarized': const _ThemePreset(
      added: Color(0xFF859900),    // Solarized green
      removed: Color(0xFFDC322F),  // Solarized red
      modified: Color(0xFFB58900), // Solarized yellow
    ),
    'Monokai': const _ThemePreset(
      added: Color(0xFFA6E22E),    // Monokai green
      removed: Color(0xFFF92672),  // Monokai pink/red
      modified: Color(0xFFFD971F), // Monokai orange
    ),
  };

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
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
    return isDark ? AppThemeV2.darkTextSecondary : AppThemeV2.lightTextSecondary;
  }

  @override
  void dispose() {
    _newPatternController.dispose();
    _navScrollController.dispose();
    _contentScrollController.dispose();
    _animationController.dispose();
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
            
            if (state.status == SettingsStatus.loading || state.status == SettingsStatus.initial) {
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
                          Icon(Icons.error_outline, size: 48, color: AppThemeV2.error),
                          const SizedBox(height: 16),
                          Text('Error loading settings', style: theme.textTheme.titleMedium),
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
                  child: _buildSettingsContent(context, state.appSettings, isDark, isAmoled),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavigationPanel(BuildContext context, bool isDark, bool isAmoled, ColorScheme colorScheme) {
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
                  child: const Icon(Icons.settings_rounded, color: Colors.white, size: 20),
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
          Divider(
            color: _getBorderColor(isDark, isAmoled),
            height: 1,
          ),
          // Navigation Items
          Expanded(
            child: Scrollbar(
              controller: _navScrollController,
              thumbVisibility: true,
              child: ListView(
                controller: _navScrollController,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                children: SettingsCategory.values.map((category) {
                  return _buildNavItem(context, category, isDark);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, SettingsCategory category, bool isDark) {
    final isSelected = _selectedCategory == category;
    final theme = Theme.of(context);
    
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
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? theme.colorScheme.primary.withAlpha(50)
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _getCategoryIcon(category),
                  size: 20,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : (isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _getCategoryLabel(category),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : (isDark ? AppThemeV2.darkTextSecondary : AppThemeV2.lightTextSecondary),
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

  Widget _buildSettingsContent(BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
    final theme = Theme.of(context);
    
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
                  onPressed: () => _showResetCategoryDialog(context, _selectedCategory),
                  icon: Icon(Icons.refresh_rounded, size: 18, color: _getTextMutedColor(isDark)),
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
                    child: _buildCategoryContent(context, settings, isDark, isAmoled),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryContent(BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
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
        return _buildAiServicesSettings(context, settings, isDark, isAmoled);
      case SettingsCategory.versionControl:
        return _buildVersionControlSettings(context, settings, isDark, isAmoled);
      case SettingsCategory.windowsIntegrations:
        return _buildWindowsIntegrationsSettings(context, settings, isDark, isAmoled);
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
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
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

  Widget _buildGeneralSettings(BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
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
              control: _buildDropdown(context, settings.appLanguage, _appLanguages, (val) {
                if (val != null) context.read<SettingsBloc>().add(UpdateAppLanguage(val));
              }, isDark, isAmoled),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Default View',
              description: 'View to show on startup',
              control: _buildDropdown(context, settings.defaultViewOnStartup, _defaultViews, (val) {
                if (val != null) context.read<SettingsBloc>().add(UpdateDefaultViewOnStartup(val));
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
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateAutoCheckForUpdates(val)),
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
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateRememberWindowPosition(val)),
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
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateOpenLastProjectOnStartup(val)),
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
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateStartMinimizedToTray(val)),
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
                      color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
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

  Widget _buildComparisonSettings(BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
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
                value: settings.ignoreCase,
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateIgnoreCase(val)),
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
                value: settings.ignoreWhitespace,
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateIgnoreWhitespace(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Similarity Threshold',
              description: 'Minimum similarity for "Modified" detection (${(settings.similarityThreshold * 100).round()}%)',
              control: SizedBox(
                width: 200,
                child: Slider(
                  value: settings.similarityThreshold,
                  min: 0.5,
                  max: 1.0,
                  divisions: 10,
                  label: '${(settings.similarityThreshold * 100).round()}%',
                  onChanged: (val) => context.read<SettingsBloc>().add(UpdateSimilarityThreshold(val)),
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
                  _buildDropdown(context, settings.comparisonMode, _comparisonModes, (val) {
                    if (val != null) context.read<SettingsBloc>().add(UpdateComparisonMode(val));
                  }, isDark, isAmoled),
                  const SizedBox(width: 8),
                  Tooltip(
                    richMessage: const TextSpan(
                      children: [
                        TextSpan(text: 'Key-based: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Matches by key name (default).\n\n'),
                        TextSpan(text: 'Order-based: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Matches by position in file.\n\n'),
                        TextSpan(text: 'Smart Match: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Detects moved/renamed keys.'),
                      ],
                    ),
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                      color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
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
                  'No patterns configured',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              ...settings.ignorePatterns.map((pattern) => _buildPatternItem(context, pattern, isDark)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildPatternPresets(context),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton.icon(
                onPressed: () => _showAddPatternDialog(context, isDark),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add Pattern'),
                style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPatternItem(BuildContext context, String pattern, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            Icons.code_rounded,
            size: 16,
            color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
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
            icon: Icon(Icons.delete_outline_rounded, size: 18, color: AppThemeV2.error),
            onPressed: () => context.read<SettingsBloc>().add(RemoveIgnorePattern(pattern)),
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
      children: presets.entries.map((entry) => 
        OutlinedButton.icon(
          icon: const Icon(Icons.add, size: 16),
          label: Text(entry.key),
          onPressed: () {
            for (final pattern in entry.value) {
              context.read<SettingsBloc>().add(AddIgnorePattern(pattern));
            }
          },
        ),
      ).toList(),
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

  Widget _buildAppearanceSettings(BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
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
              control: _buildDropdown(context, settings.appThemeMode, _themeModes, (val) {
                if (val != null) context.read<SettingsBloc>().add(UpdateAppThemeMode(val));
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
                              onChanged: (value) => context.read<SettingsBloc>().add(UpdateDiffFontSize(value)),
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
                              context.read<SettingsBloc>().add(UpdateDiffFontFamily(val));
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
                    onPressed: () => _showAccentColorPicker(context, Color(settings.accentColorValue)),
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
            _buildColorRow(context, 'Added', Color(settings.diffAddedColor), (color) {
              context.read<SettingsBloc>().add(UpdateDiffAddedColor(color.toARGB32()));
            }, isDark, isAmoled),
            _buildColorRow(context, 'Removed', Color(settings.diffRemovedColor), (color) {
              context.read<SettingsBloc>().add(UpdateDiffRemovedColor(color.toARGB32()));
            }, isDark, isAmoled),
            _buildColorRow(context, 'Modified', Color(settings.diffModifiedColor), (color) {
              context.read<SettingsBloc>().add(UpdateDiffModifiedColor(color.toARGB32()));
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

  Widget _buildPreviewPanel(BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
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
                color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
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
                      color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      color: isDark ? AppThemeV2.darkTextSecondary : AppThemeV2.lightTextSecondary,
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

  Widget _buildFileHandlingSettings(BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
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
              control: _buildDropdown(context, settings.defaultSourceFormat, _fileFormats, (val) {
                if (val != null) context.read<SettingsBloc>().add(UpdateDefaultSourceFormat(val));
              }, isDark, isAmoled),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Target Format',
              control: _buildDropdown(context, settings.defaultTargetFormat, _fileFormats, (val) {
                if (val != null) context.read<SettingsBloc>().add(UpdateDefaultTargetFormat(val));
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
              control: _buildDropdown(context, settings.defaultSourceEncoding, _encodings, (val) {
                if (val != null) context.read<SettingsBloc>().add(UpdateDefaultSourceEncoding(val));
              }, isDark, isAmoled),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Target Encoding',
              control: _buildDropdown(context, settings.defaultTargetEncoding, _encodings, (val) {
                if (val != null) context.read<SettingsBloc>().add(UpdateDefaultTargetEncoding(val));
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
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateAutoDetectEncoding(val)),
                activeColor: Theme.of(context).colorScheme.primary,
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

  Widget _buildAiServicesSettings(BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
    final llmModels = ['Gemini 1.5 Flash', 'Gemini 1.5 Pro', 'GPT-4o', 'GPT-4o-mini', 'Claude 3.5 Sonnet', 'DeepSeek-V3'];

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
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateEnableAiTranslation(val)),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              isDark: isDark,
              isAmoled: isAmoled,
            ),
            _buildSettingRow(
              context: context,
              label: 'Default Model',
              description: 'Required for fast translate',
              control: _buildDropdown(
                context,
                settings.defaultAiModel.isEmpty ? 'Select model...' : settings.defaultAiModel,
                ['Select model...', ...llmModels],
                (val) {
                  if (val != null && val != 'Select model...') {
                    context.read<SettingsBloc>().add(UpdateDefaultAiModel(val));
                  }
                },
                isDark,
                isAmoled,
              ),
              isAmoled: isAmoled,
            ),
             _buildSettingRow(
              context: context,
              label: 'Confidence Threshold',
              description: '${(settings.translationConfidenceThreshold * 100).round()}%',
              control: SizedBox(
                width: 150,
                child: Slider(
                  value: settings.translationConfidenceThreshold,
                  min: 0.0,
                  max: 1.0,
                  divisions: 20,
                  onChanged: (val) => context.read<SettingsBloc>().add(UpdateTranslationConfidenceThreshold(val)),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              isDark: isDark,
              isAmoled: isAmoled,
              showDivider: true,
            ),
            const SizedBox(height: 8),
            _buildApiKeyRow(
              context,
              'Gemini API Key',
              settings.geminiApiKey,
              (val) {
                context.read<SettingsBloc>().add(UpdateGeminiApiKey(val));
              },
              isDark,
              isAmoled,
            ),
            _buildApiKeyRow(
              context,
              'OpenAI API Key',
              settings.openaiApiKey,
              (val) {
                context.read<SettingsBloc>().add(UpdateOpenAiApiKey(val));
              },
              isDark,
              isAmoled,
              showDivider: false,
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
                    controller: TextEditingController(text: settings.systemTranslationContext),
                    onChanged: (val) => context.read<SettingsBloc>().add(UpdateSystemTranslationContext(val)),
                    decoration: InputDecoration(
                      hintText: 'e.g., This is a fantasy RPG game. Use informal tone and "gamer" terminology.',
                      hintStyle: TextStyle(color: isDark ? Colors.grey[600] : Colors.grey[400]),
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
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateIncludeContextStrings(val)),
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
                    onChanged: (val) => context.read<SettingsBloc>().add(UpdateContextStringsCount(val.round())),
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
            isAmoled: isAmoled,
                showDivider: false,
              ),
          ],
        ),

        // -----------------------------------------------------------
        // CLASSIC APIs (Legacy)
        // -----------------------------------------------------------
        Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(
                'Classic Translation APIs (Legacy)', 
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: isDark ? Colors.grey[400] : Colors.grey[600]
                )
              ),
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
                       control: _buildDropdown(context, settings.aiTranslationService, ['Google Translate', 'DeepL', 'Azure Translator'], (val) {
                        if (val != null) context.read<SettingsBloc>().add(UpdateAiTranslationService(val));
                      }, isDark, isAmoled),
                  isAmoled: isAmoled,
                    ),
                    _buildApiKeyRow(context, 'Google Translate API', settings.googleTranslateApiKey, (val) {
                      context.read<SettingsBloc>().add(UpdateGoogleTranslateApiKey(val));
                    }, isDark, isAmoled),
                    _buildApiKeyRow(context, 'DeepL API Key', settings.deeplApiKey, (val) {
                      context.read<SettingsBloc>().add(UpdateDeeplApiKey(val));
                    }, isDark, isAmoled, showDivider: false),
                  ],
                ),
              ],
            ),
        ),
      ],
    );
  }

  Widget _buildApiKeyRow(
    BuildContext context,
    String label,
    String value,
    ValueChanged<String> onChanged,
    bool isDark,
    bool isAmoled, {
    bool showDivider = true,
  }) {
    return Column(
      children: [
        _buildTextFieldRow(
          context, 
          label, 
          value, 
          onChanged, 
          isDark, 
          isAmoled, 
          showDivider: showDivider,
          hintText: 'Paste your $label here',
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // VERSION CONTROL SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildVersionControlSettings(BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
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
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateEnableGitIntegration(val)),
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
                onChanged: (val) => context.read<SettingsBloc>().add(UpdateAutoCommitOnSave(val)),
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
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // WINDOWS INTEGRATIONS SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildWindowsIntegrationsSettings(BuildContext context, AppSettings settings, bool isDark, bool isAmoled) {
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
                    Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
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
              description: 'Enable Windows 11 Mica transparency (requires restart)',
              control: Switch(
                value: settings.useMicaEffect,
                onChanged: isWindows ? (val) => context.read<SettingsBloc>().add(UpdateUseMicaEffect(val)) : null,
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
                      color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows ? () async {
                            final success = await WindowsIntegrationService.addToContextMenu();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(success ? 'Context menu added!' : 'Failed to add context menu'),
                                  backgroundColor: success ? Colors.green : AppThemeV2.error,
                                ),
                              );
                            }
                          } : null,
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: const Text('Add to Context Menu'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows ? () async {
                            final success = await WindowsIntegrationService.removeFromContextMenu();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(success ? 'Context menu removed!' : 'Failed to remove context menu'),
                                  backgroundColor: success ? Colors.green : AppThemeV2.error,
                                ),
                              );
                            }
                          } : null,
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register .loc files to open with Localizer when double-clicked.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows ? () async {
                            final success = await WindowsIntegrationService.registerFileAssociation();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(success ? 'File association registered!' : 'Failed to register'),
                                  backgroundColor: success ? Colors.green : AppThemeV2.error,
                                ),
                              );
                            }
                          } : null,
                          icon: const Icon(Icons.link_rounded, size: 18),
                          label: const Text('Register .loc Files'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows ? () async {
                            final success = await WindowsIntegrationService.unregisterFileAssociation();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(success ? 'File association removed!' : 'Failed to remove'),
                                  backgroundColor: success ? Colors.green : AppThemeV2.error,
                                ),
                              );
                            }
                          } : null,
                          icon: const Icon(Icons.link_off_rounded, size: 18),
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
                      color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows ? () async {
                            final success = await WindowsIntegrationService.registerProtocolHandler();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(success ? 'Protocol handler registered!' : 'Failed to register'),
                                  backgroundColor: success ? Colors.green : AppThemeV2.error,
                                ),
                              );
                            }
                          } : null,
                          icon: const Icon(Icons.public_rounded, size: 18),
                          label: const Text('Register Protocol'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isWindows ? () async {
                            final success = await WindowsIntegrationService.unregisterProtocolHandler();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(success ? 'Protocol handler removed!' : 'Failed to remove'),
                                  backgroundColor: success ? Colors.green : AppThemeV2.error,
                                ),
                              );
                            }
                          } : null,
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      isDark: isDark,
      isAmoled: isAmoled,
      showDivider: showDivider,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ABOUT SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildAboutSettings(BuildContext context, bool isDark, bool isAmoled) {
    return Column(
      children: [
        _buildSettingsCard(
          context: context,
          title: 'Application Info',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildInfoRow(context, 'Version', _packageInfo?.version ?? 'Loading...', isDark, isAmoled),
            _buildInfoRow(context, 'Build', _packageInfo?.buildNumber ?? 'Loading...', isDark, isAmoled),
            _buildInfoRow(context, 'Platform', _platformInfo, isDark, isAmoled, showDivider: false),
          ],
        ),
        _buildSettingsCard(
          context: context,
          title: 'Links',
          isDark: isDark,
          isAmoled: isAmoled,
          children: [
            _buildLinkRow(context, 'GitHub Repository', Icons.code_rounded, () => _launchUrl('https://github.com/KhazP/LocalizerAppMain'), isDark, isAmoled),
            _buildLinkRow(context, 'Report Issue', Icons.bug_report_rounded, () => _launchUrl('https://github.com/KhazP/LocalizerAppMain/issues'), isDark, isAmoled),
            _buildLinkRow(context, 'Licenses', Icons.article_rounded, () => _showLicensesDialog(context, isDark), isDark, isAmoled, showDivider: false),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, bool isDark, bool isAmoled, {bool showDivider = true}) {
    return _buildSettingRow(
      context: context,
      label: label,
      control: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
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
                Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
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

  void _showColorPicker(BuildContext context, Color initialColor, ValueChanged<Color> onColorSelected) {
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
    
    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          void submitPattern() {
            if (_newPatternController.text.isNotEmpty && errorMessage == null) {
              context.read<SettingsBloc>().add(AddIgnorePattern(_newPatternController.text));
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
                      matchResult! ? '✓ Pattern matches test string' : '✗ Pattern does not match',
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
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: errorMessage == null && _newPatternController.text.isNotEmpty ? submitPattern : null,
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }


  void _showResetCategoryDialog(BuildContext context, SettingsCategory category) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Reset ${_getCategoryTitle(category)}?'),
        content: const Text('This will reset all settings in this category to their default values.'),
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
                  content: Text('${_getCategoryTitle(category)} reset to defaults'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
        content: const Text('This will permanently reset all settings to their factory defaults. This action cannot be undone.'),
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
