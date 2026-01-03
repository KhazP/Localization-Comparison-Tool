import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/views/basic_comparison_view.dart';
import 'package:localizer_app_main/presentation/views/files_view.dart';
import 'package:localizer_app_main/presentation/views/history_view.dart';
import 'package:localizer_app_main/presentation/views/settings_view.dart';
import 'package:localizer_app_main/presentation/views/git_view.dart';
import 'package:localizer_app_main/presentation/views/quality_dashboard_view.dart';
import 'package:localizer_app_main/presentation/views/projects_view.dart';
import 'package:localizer_app_main/presentation/widgets/project/project_indicator.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/app_tab_service.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:localizer_app_main/data/models/comparison_history.dart';

class MyHomePage extends StatefulWidget {
  final ComparisonSession? initialSession;
  final TalkerService? talkerService;

  const MyHomePage({super.key, this.initialSession, this.talkerService});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _fabAnimationController;
  late final AppTabService _tabService;

  // Cached pages to prevent recreation on tab switch (performance optimization)
  late final List<Widget> _pages;

  // Hover states for navigation items
  final List<bool> _hoverStates = List.filled(7, false);

  @override
  void initState() {
    super.initState();
    final settingsBloc = context.read<SettingsBloc>();
    _selectedIndex = _getInitialTabIndex(
        settingsBloc.state.appSettings.defaultViewOnStartup);
    _tabService = sl<AppTabService>();
    _tabService.selectedIndex.addListener(_handleTabServiceChange);
    _tabService.select(_selectedIndex);
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fabAnimationController.forward();

    // Initialize pages once to avoid recreation on every tab switch
    _pages = <Widget>[
      const ProjectsView(),
      BasicComparisonView(
        onNavigateToTab: _onDestinationSelected,
        initialSession: widget.initialSession,
      ),
      HistoryView(onNavigateToTab: _onDestinationSelected),
      const QualityDashboardView(),
      const FilesView(),
      const GitView(),
      const SettingsView(),
    ];
  }

  @override
  void dispose() {
    _tabService.selectedIndex.removeListener(_handleTabServiceChange);
    _fabAnimationController.dispose();
    super.dispose();
  }

  int _getInitialTabIndex(String defaultView) {
    switch (defaultView) {
      case 'Basic Comparison':
        return 1;
      case 'History View':
        return 2;
      case 'Quality Dashboard':
        return 3;
      case 'Files':
        return 4;
      case 'Settings':
        return 6;
      case 'Last Used View':
        return 1;
      default:
        return 1;
    }
  }

  // _widgetOptions getter removed - using cached _pages list instead

  void _onDestinationSelected(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
    _tabService.select(index);
  }

  void _handleTabServiceChange() {
    final index = _tabService.selectedIndex.value;
    if (!mounted || index == _selectedIndex) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleTheme() {
    final settingsBloc = context.read<SettingsBloc>();
    final currentMode = settingsBloc.state.appSettings.appThemeMode;

    // Cycle through: light -> dark -> amoled -> system -> light
    String nextMode;
    switch (currentMode.toLowerCase()) {
      case 'light':
        nextMode = 'Dark';
        break;
      case 'dark':
        nextMode = 'Amoled';
        break;
      case 'amoled':
        nextMode = 'System';
        break;
      case 'system':
      default:
        nextMode = 'Light';
        break;
    }

    settingsBloc.add(UpdateAppThemeMode(nextMode));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final settingsState = context.watch<SettingsBloc>().state;
    final isAmoled =
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    return Scaffold(
      body: Padding(
        // Add top padding on macOS to prevent window buttons from overlapping with nav rail
        padding: EdgeInsets.only(top: Platform.isMacOS ? 28.0 : 0.0),
        child: Row(
          children: [
            // Navigation Rail
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).navigationRailTheme.backgroundColor ??
                    (isAmoled
                        ? AppThemeV2.amoledSurface
                        : (isDarkMode
                            ? AppThemeV2.darkCard
                            : AppThemeV2.lightCard)),
                border: Border(
                  right: BorderSide(
                    color: isAmoled
                        ? AppThemeV2.amoledBorder
                        : Theme.of(context).dividerColor,
                  ),
                ),
              ),
              child: NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: _onDestinationSelected,
                backgroundColor: Colors.transparent,
                indicatorColor: colorScheme.primary.withValues(alpha: 0.15),
                labelType: NavigationRailLabelType.all,
                destinations: [
                  _buildNavDestination(
                    index: 0,
                    icon: LucideIcons.layoutGrid,
                    selectedIcon: LucideIcons.layoutGrid,
                    label: 'Projects',
                    colorScheme: colorScheme,
                  ),
                  _buildNavDestination(
                    index: 1,
                    icon: LucideIcons.arrowLeftRight,
                    selectedIcon: LucideIcons.arrowLeftRight,
                    label: 'Compare',
                    colorScheme: colorScheme,
                  ),
                  _buildNavDestination(
                    index: 2,
                    icon: LucideIcons.clock3,
                    selectedIcon: LucideIcons.clock3,
                    label: 'History',
                    colorScheme: colorScheme,
                  ),
                  _buildNavDestination(
                    index: 3,
                    icon: LucideIcons.barChart3,
                    selectedIcon: LucideIcons.barChart3,
                    label: 'Dashboard',
                    colorScheme: colorScheme,
                  ),
                  _buildNavDestination(
                    index: 4,
                    icon: LucideIcons.folderOpen,
                    selectedIcon: LucideIcons.folderOpen,
                    label: 'Files',
                    colorScheme: colorScheme,
                  ),
                  _buildNavDestination(
                    index: 5,
                    icon: LucideIcons.gitBranch,
                    selectedIcon: LucideIcons.gitBranch,
                    label: 'Git',
                    colorScheme: colorScheme,
                  ),
                  _buildNavDestination(
                    index: 6,
                    icon: LucideIcons.settings,
                    selectedIcon: LucideIcons.settings,
                    label: 'Settings',
                    colorScheme: colorScheme,
                  ),
                ],
                trailing: Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Project indicator/create button
                          const ProjectIndicator(),
                          const SizedBox(height: 12),
                          // Theme toggle button
                          Tooltip(
                            message:
                                'Toggle Theme (Light > Dark > AMOLED > System)',
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _toggleTheme,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: colorScheme.surface,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Theme.of(context).dividerColor,
                                    ),
                                  ),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    transitionBuilder: (child, animation) {
                                      return RotationTransition(
                                        turns: Tween(begin: 0.5, end: 1.0)
                                            .animate(animation),
                                        child: FadeTransition(
                                            opacity: animation, child: child),
                                      );
                                    },
                                    child: Icon(
                                      isDarkMode
                                          ? LucideIcons.sun
                                          : LucideIcons.moon,
                                      key: ValueKey(isDarkMode),
                                      size: 20,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Debug Console button (only in debug mode)
                          if (kDebugMode && widget.talkerService != null) ...[
                            const SizedBox(height: 8),
                            Tooltip(
                              message: 'Debug Console',
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TalkerScreen(
                                          talker: widget.talkerService!.talker,
                                          theme: TalkerScreenTheme(
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            textColor: colorScheme.onSurface,
                                            cardColor:
                                                Theme.of(context).cardColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: colorScheme.surface,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Theme.of(context).dividerColor,
                                      ),
                                    ),
                                    child: Icon(
                                      LucideIcons.terminal,
                                      size: 20,
                                      color: colorScheme.tertiary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Main content - using IndexedStack to preserve widget state across tab switches
            // This prevents heavy views from being recreated when navigating tabs
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: _pages,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a navigation destination with hover animation effects
  NavigationRailDestination _buildNavDestination({
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required ColorScheme colorScheme,
  }) {
    final isSelected = _selectedIndex == index;
    final isHovered = _hoverStates[index];

    // Helper to build icon with consistent hover effects
    Widget buildIconWidget(IconData iconData, {bool forSelected = false}) {
      return MouseRegion(
        onEnter: (_) => setState(() => _hoverStates[index] = true),
        onExit: (_) => setState(() => _hoverStates[index] = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: forSelected
                ? colorScheme.primary.withValues(alpha: 0.15)
                : (isHovered
                    ? colorScheme.primary.withValues(alpha: 0.12)
                    : Colors.transparent),
          ),
          child: AnimatedScale(
            scale: isHovered && !forSelected ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOutCubic,
            child: Icon(
              iconData,
              size: 22,
              color: forSelected
                  ? colorScheme.primary
                  : (isHovered
                      ? colorScheme.primary.withValues(alpha: 0.85)
                      : colorScheme.onSurface.withValues(alpha: 0.6)),
            ),
          ),
        ),
      );
    }

    return NavigationRailDestination(
      padding: const EdgeInsets.symmetric(vertical: 4),
      icon: buildIconWidget(icon, forSelected: false),
      selectedIcon: buildIconWidget(selectedIcon, forSelected: true),
      label: MouseRegion(
        onEnter: (_) => setState(() => _hoverStates[index] = true),
        onExit: (_) => setState(() => _hoverStates[index] = false),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? colorScheme.primary
                : (isHovered
                    ? colorScheme.primary.withValues(alpha: 0.85)
                    : colorScheme.onSurface.withValues(alpha: 0.7)),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}
