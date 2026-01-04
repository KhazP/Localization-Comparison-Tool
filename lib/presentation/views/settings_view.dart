import 'dart:async';
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
import 'package:localizer_app_main/presentation/widgets/settings/settings.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:localizer_app_main/presentation/widgets/settings/system_integrations_card.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/core/services/dialog_service.dart';
import 'package:localizer_app_main/data/services/update_checker_service.dart';
import 'package:localizer_app_main/data/services/system_info_service.dart';
import 'package:localizer_app_main/core/services/friendly_error_service.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_scope_selector.dart';
import 'package:intl/intl.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/presentation/widgets/project/project_glossary_card.dart';
import 'package:localizer_app_main/presentation/widgets/project/project_memory_card.dart';
import 'package:localizer_app_main/presentation/widgets/project/project_conflict_banner.dart';

// Re-export SettingsCategory for external use
export 'package:localizer_app_main/presentation/widgets/settings/settings_constants.dart'
    show SettingsCategory;

class SettingsView extends StatefulWidget {
  const SettingsView({
    super.key,
    this.initialCategory = SettingsCategory.general,
    this.showBackButton = false,
  });

  final SettingsCategory initialCategory;
  final bool showBackButton;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with SingleTickerProviderStateMixin {
  late SettingsCategory _selectedCategory;
  final TextEditingController _newPatternController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _navScrollController = ScrollController();
  final ScrollController _contentScrollController = ScrollController();
  String _searchQuery = '';
  TranslationMemoryService? _translationMemoryService;
  Future<TranslationMemoryStats>? _translationMemoryStatsFuture;
  PackageInfo? _packageInfo;
  String _platformInfo = 'Loading...';

  // Update checker state
  UpdateCheckerService? _updateCheckerService;
  UpdateCheckResult? _updateCheckResult;
  bool _isCheckingForUpdates = false;

  // System info state
  SystemInfoService? _systemInfoService;
  SystemInfo? _systemInfo;

  // Save confirmation debounce timer
  Timer? _saveConfirmationTimer;
  AppSettings? _previousSettings;
  bool _hasInitialized = false; // Suppress save toast during startup

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
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

    // Delay initialization flag to suppress save toast during startup
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _hasInitialized = true;
      }
    });
  }

  @override
  void dispose() {
    _newPatternController.dispose();
    _searchController.dispose();
    _navScrollController.dispose();
    _contentScrollController.dispose();
    _animationController.dispose();
    _updateCheckerService?.dispose();
    _saveConfirmationTimer?.cancel();
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

  void _refreshTranslationMemoryStats() {
    if (_translationMemoryService != null && mounted) {
      setState(() {
        _translationMemoryStatsFuture = _translationMemoryService?.getStats();
      });
    }
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
        appBar: widget.showBackButton
            ? AppBar(
                title: const Text('Settings'),
                leading: IconButton(
                  icon: const Icon(LucideIcons.arrowLeft),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              )
            : null,
        body: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (context, state) {
            // Debounced save confirmation - only show after user stops changing settings
            // Skip during startup to avoid false positives from initial load
            if (!_hasInitialized) {
              _previousSettings = state.appSettings;
              return;
            }
            // Exclude window position fields from comparison to avoid toast on resize/move
            if (state.status == SettingsStatus.loaded &&
                _previousSettings != null) {
              final current = state.appSettings;
              final previous = _previousSettings!;

              // Helper to get comparable map without window bounds
              Map<String, dynamic> getComparableMap(AppSettings settings) {
                final map = settings.toJson();
                map.remove('lastWindowX');
                map.remove('lastWindowY');
                map.remove('lastWindowWidth');
                map.remove('lastWindowHeight');
                return map;
              }

              final currentMap = getComparableMap(current);
              final previousMap = getComparableMap(previous);

              // Use jsonEncode to compare maps deeply (handles lists and nested objects)
              final hasUserSettingChanged =
                  jsonEncode(currentMap) != jsonEncode(previousMap);

              if (hasUserSettingChanged) {
                _saveConfirmationTimer?.cancel();
                _saveConfirmationTimer =
                    Timer(const Duration(milliseconds: 800), () {
                  if (mounted) {
                    ToastService.showSuccess(context, 'Settings saved');
                  }
                });
              }
            }
            _previousSettings = state.appSettings;
          },
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
                          Icon(LucideIcons.alertCircle,
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

  /// Search settings and return matching categories with their matching terms
  Map<SettingsCategory, List<String>> _getSearchResults() {
    if (_searchQuery.isEmpty) {
      return {};
    }
    final query = _searchQuery.toLowerCase();
    final results = <SettingsCategory, List<String>>{};

    for (final entry in SettingsConstants.searchableSettings.entries) {
      final matches = entry.value
          .where((setting) => setting.toLowerCase().contains(query))
          .toList();
      if (matches.isNotEmpty) {
        results[entry.key] = matches;
      }
    }
    return results;
  }

  /// Get filtered categories based on search query and platform
  List<SettingsCategory> _getFilteredCategories() {
    // Get the settings to check developer options
    final settings = context.read<SettingsBloc>().state.appSettings;

    // Start with all categories
    var categories = SettingsCategory.values.toList();

    // Filter out platform-specific categories unless developer options enabled
    // System Integrations category handles platform specifics internally

    final projectState = context.read<ProjectBloc>().state;
    if (!projectState.hasProject) {
      categories.remove(SettingsCategory.projectResources);
    }

    // Apply search filtering
    if (_searchQuery.isEmpty) {
      return categories;
    }
    final results = _getSearchResults();
    if (results.isEmpty) {
      return categories;
    }
    return categories.where((c) => results.containsKey(c)).toList();
  }

  Widget _buildNavigationPanel(BuildContext context, bool isDark, bool isAmoled,
      ColorScheme colorScheme) {
    final filteredCategories = _getFilteredCategories();
    final searchResults = _getSearchResults();

    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: isAmoled
            ? AppThemeV2.amoledSurface
            : (isDark ? AppThemeV2.darkSurface : AppThemeV2.lightSurface),
        border: Border(
          right: BorderSide(
            color: isAmoled
                ? AppThemeV2.amoledBorder
                : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder),
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
                  child: const Icon(LucideIcons.settings,
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
                  color: isDark
                      ? AppThemeV2.darkTextMuted
                      : AppThemeV2.lightTextMuted,
                  fontSize: 13,
                ),
                prefixIcon: Icon(
                  LucideIcons.search,
                  size: 18,
                  color: isDark
                      ? AppThemeV2.darkTextMuted
                      : AppThemeV2.lightTextMuted,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          LucideIcons.x,
                          size: 16,
                          color: isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted,
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
                fillColor: isAmoled
                    ? AppThemeV2.amoledCard
                    : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: isAmoled
                        ? AppThemeV2.amoledBorder
                        : (isDark
                            ? AppThemeV2.darkBorder
                            : AppThemeV2.lightBorder),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: isAmoled
                        ? AppThemeV2.amoledBorder
                        : (isDark
                            ? AppThemeV2.darkBorder
                            : AppThemeV2.lightBorder),
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
            color: isAmoled
                ? AppThemeV2.amoledBorder
                : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder),
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
                      color: isDark
                          ? AppThemeV2.darkTextMuted
                          : AppThemeV2.lightTextMuted,
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
                  SettingsConstants.getCategoryIcon(category),
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
                    SettingsConstants.getCategoryLabel(category),
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

  Widget _buildSettingsContent(
    BuildContext context,
    SettingsState state,
    bool isDark,
    bool isAmoled,
  ) {
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
                SettingsConstants.getCategoryIcon(_selectedCategory),
                size: 28,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  SettingsConstants.getCategoryTitle(_selectedCategory),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (_selectedCategory != SettingsCategory.about)
                TextButton.icon(
                  onPressed: () =>
                      _showResetCategoryDialog(context, _selectedCategory),
                  icon: Icon(LucideIcons.refreshCcw,
                      size: 18,
                      color: isDark
                          ? AppThemeV2.darkTextMuted
                          : AppThemeV2.lightTextMuted),
                  label: Text(
                    'Reset',
                    style: TextStyle(
                        color: isDark
                            ? AppThemeV2.darkTextMuted
                            : AppThemeV2.lightTextMuted),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),

          // Scope selector (only for AI Services category which has overridable settings)
          if (_selectedCategory == SettingsCategory.aiServices) ...[
            const ProjectConflictBanner(),
            const SettingsScopeSelector(),
          ],

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
        return GeneralSettingsCard(
          settings: settings,
          isDark: isDark,
          isAmoled: isAmoled,
        );
      case SettingsCategory.comparisonEngine:
        return ComparisonSettingsCard(
          settings: settings,
          state: state,
          isDark: isDark,
          isAmoled: isAmoled,
          onShowAddPatternDialog: () => _showAddPatternDialog(context, isDark),
        );
      case SettingsCategory.appearance:
        return AppearanceSettingsCard(
          settings: settings,
          isDark: isDark,
          isAmoled: isAmoled,
        );
      case SettingsCategory.fileHandling:
        return FileHandlingSettingsCard(
          settings: settings,
          state: state,
          isDark: isDark,
          isAmoled: isAmoled,
        );
      case SettingsCategory.aiServices:
        return AiServicesSettingsCard(
          settings: settings,
          state: state,
          translationMemoryService: _translationMemoryService,
          translationMemoryStatsFuture: _translationMemoryStatsFuture,
          onRefreshStats: _refreshTranslationMemoryStats,
          isDark: isDark,
          isAmoled: isAmoled,
        );
      case SettingsCategory.versionControl:
        return VersionControlSettingsCard(
          settings: settings,
          isDark: isDark,
          isAmoled: isAmoled,
        );
      case SettingsCategory.systemIntegrations:
        return SystemIntegrationsCard(
          settings: settings,
          isDark: isDark,
          isAmoled: isAmoled,
        );
      case SettingsCategory.projectResources:
        return Column(
          children: [
            ProjectGlossaryCard(),
            const SizedBox(height: 16),
            ProjectTranslationMemoryCard(),
          ],
        );
      case SettingsCategory.about:
        return AboutSettingsCard(
          settings: settings,
          packageInfo: _packageInfo,
          updateCheckResult: _updateCheckResult,
          isCheckingForUpdates: _isCheckingForUpdates,
          systemInfo: _systemInfo,
          isDark: isDark,
          isAmoled: isAmoled,
          onCheckForUpdates: () => _checkForUpdates(context),
          onShowChangelog: () => _showChangelogDialog(context, isDark),
          onLaunchUrl: _launchUrl,
          onRefreshSystemInfo: () async {
            setState(() => _systemInfo = null);
            await _loadSystemInfo();
          },
          onExportSettings: () => _exportSettings(context),
          onImportSettings: () => _importSettings(context),
          onResetAllSettings: () => _showResetAllSettingsDialog(context),
          onShowLicenses: () => _showLicensesDialog(context, isDark),
        );
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // GENERAL SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

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
      BuildContext context, SettingsCategory category) async {
    final confirmed = await DialogService.showConfirmation(
      context: context,
      title: 'Reset ${SettingsConstants.getCategoryTitle(category)}?',
      content:
          'This will reset all settings in this category to their default values.',
      confirmText: 'Reset',
      isDestructive: true,
      icon: Icons.restore_rounded,
    );

    if (confirmed == true && context.mounted) {
      switch (category) {
        case SettingsCategory.projectResources:
          context
              .read<SettingsBloc>()
              .add(ResetCategoryToGlobal('project_resources'));
          break;
        case SettingsCategory.about:
          // No reset for about
          break;
        case SettingsCategory.general:
          context.read<SettingsBloc>().add(ResetGeneralSettings());
          break;
        case SettingsCategory.comparisonEngine:
          context.read<SettingsBloc>().add(ResetComparisonSettings());
          break;
        case SettingsCategory.appearance:
          context.read<SettingsBloc>().add(ResetAppearanceSettings());
          break;
        case SettingsCategory.fileHandling:
          context.read<SettingsBloc>().add(ResetFileHandlingSettings());
          break;
        case SettingsCategory.aiServices:
          context.read<SettingsBloc>().add(ResetAiServicesSettings());
          break;
        case SettingsCategory.versionControl:
          context.read<SettingsBloc>().add(ResetVersionControlSettings());
          break;
        case SettingsCategory.systemIntegrations:
          // System integrations often toggle immediate settings (like registry keys)
          // rather than holding state in the bloc, or have their own specific resets.
          // For now, no specific reset action in the bloc for this whole category.
          break;
        case SettingsCategory.about:
          break;
      }
      ToastService.showSuccess(context,
          '${SettingsConstants.getCategoryTitle(category)} reset to defaults');
    }
  }

  void _showResetAllSettingsDialog(BuildContext context) async {
    final confirmed = await DialogService.showConfirmation(
      context: context,
      title: 'Reset All Settings?',
      content:
          'This will permanently reset all settings to their factory defaults. This action cannot be undone.',
      confirmText: 'Reset All',
      isDestructive: true,
      icon: Icons.delete_forever_rounded,
    );

    if (confirmed == true && context.mounted) {
      context.read<SettingsBloc>().add(ResetAllSettings());
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

        if (result.error != null) {
          final friendlyError =
              FriendlyErrorService.getFriendlyMessage(result.error);
          ToastService.showError(context, friendlyError.toString());
        } else if (result.updateAvailable) {
          ToastService.showSuccess(
              context, 'Update available: v${result.latestVersion}');
        } else {
          ToastService.showInfo(context, 'You are using the latest version');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCheckingForUpdates = false;
        });
        final friendlyError = FriendlyErrorService.getFriendlyMessage(e);
        ToastService.showError(context, friendlyError.toString());
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
          ToastService.showSuccessWithAction(
            context,
            'Settings exported',
            actionLabel: 'Open',
            onAction: () => OpenFile.open(result),
          );
        }
      }
    } catch (e) {
      developer.log('Error exporting settings: $e');
      if (context.mounted) {
        ToastService.showError(
            context, 'Failed to export settings: ${e.toString()}');
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
        final knownKeys = AppSettings.defaultSettings().toJson().keys.toSet();
        final hasKnownKey = jsonMap.keys.any(knownKeys.contains);
        if (!hasKnownKey) {
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
          context
              .read<SettingsBloc>()
              .add(ReplaceAllSettings(importedSettings));

          if (context.mounted) {
            ToastService.showSuccess(
                context, 'Settings imported successfully!');
          }
        }
      }
    } catch (e) {
      developer.log('Error importing settings: $e');
      if (context.mounted) {
        ToastService.showError(
            context, 'Failed to import settings: ${e.toString()}');
      }
    }
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
