import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/views/basic_comparison_view.dart';
import 'package:localizer_app_main/presentation/views/files_view.dart';
import 'package:localizer_app_main/presentation/views/history_view.dart';
import 'package:localizer_app_main/presentation/views/settings_view.dart';
import 'package:localizer_app_main/presentation/views/git_view.dart';

import 'package:localizer_app_main/data/models/comparison_history.dart';

class MyHomePage extends StatefulWidget {
  final ComparisonSession? initialSession;

  const MyHomePage({super.key, this.initialSession});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _fabAnimationController;

  @override
  void initState() {
    super.initState();
    final settingsBloc = context.read<SettingsBloc>();
    _selectedIndex = _getInitialTabIndex(settingsBloc.state.appSettings.defaultViewOnStartup);
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  int _getInitialTabIndex(String defaultView) {
    switch (defaultView) {
      case 'Basic Comparison':
        return 0;
      case 'History View':
        return 1;
      case 'Files':
        return 2;
      case 'Settings':
        return 3;
      case 'Last Used View':
        return 0;
      default:
        return 0;
    }
  }

  List<Widget> get _widgetOptions => <Widget>[
    BasicComparisonView(
      onNavigateToTab: _onDestinationSelected,
      initialSession: widget.initialSession,
    ),
    HistoryView(onNavigateToTab: (index) => setState(() => _selectedIndex = index)),
    const FilesView(),
    const GitView(),
    const SettingsView(),
  ];

  void _onDestinationSelected(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
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
    final isAmoled = settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    return Scaffold(
      body: Row(
        children: [
          // Navigation Rail
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).navigationRailTheme.backgroundColor ??
                  (isAmoled
                      ? AppThemeV2.amoledSurface
                      : (isDarkMode ? AppThemeV2.darkCard : AppThemeV2.lightCard)),
              border: Border(
                right: BorderSide(
                  color: isAmoled ? AppThemeV2.amoledBorder : Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
              backgroundColor: Colors.transparent,
              indicatorColor: colorScheme.primary.withValues(alpha: 0.15),
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.compare_arrows_outlined),
                  selectedIcon: Icon(Icons.compare_arrows),
                  label: Text('Compare'),
                  padding: EdgeInsets.symmetric(vertical: 4),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.history_outlined),
                  selectedIcon: Icon(Icons.history),
                  label: Text('History'),
                  padding: EdgeInsets.symmetric(vertical: 4),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.folder_outlined),
                  selectedIcon: Icon(Icons.folder),
                  label: Text('Files'),
                  padding: EdgeInsets.symmetric(vertical: 4),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.source_outlined),
                  selectedIcon: Icon(Icons.source),
                  label: Text('Git'),
                  padding: EdgeInsets.symmetric(vertical: 4),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: Text('Settings'),
                  padding: EdgeInsets.symmetric(vertical: 4),
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
                        // Theme toggle button
                        Tooltip(
                          message: 'Toggle Theme (Light → Dark → AMOLED → System)',
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
                                      turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                                      child: FadeTransition(opacity: animation, child: child),
                                    );
                                  },
                                  child: Icon(
                                    isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                                    key: ValueKey(isDarkMode),
                                    size: 20,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Main content with animated transitions
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.02, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey(_selectedIndex),
                child: _widgetOptions[_selectedIndex],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
