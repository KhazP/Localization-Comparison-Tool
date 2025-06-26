import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localizer_app_main/business_logic/blocs/comparison_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/directory_comparison_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/git_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/progress_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/translation_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/file_watcher_bloc/file_watcher_bloc.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/core/services/file_discovery_service.dart';
import 'package:localizer_app_main/core/services/file_watcher_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/repositories/history_repository.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';
import 'package:localizer_app_main/presentation/themes/app_theme.dart';
import 'package:localizer_app_main/presentation/views/basic_comparison_view.dart';
import 'package:localizer_app_main/presentation/views/files_view.dart';
import 'package:localizer_app_main/presentation/views/history_view.dart';
import 'package:localizer_app_main/presentation/views/settings_view.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  // TEMPORARY: Delete the box to handle breaking changes in the AppSettings model.
  // This ensures the app doesn't crash on startup due to a corrupted box.
  // In a production app, a more sophisticated migration strategy would be needed.
  await Hive.deleteBoxFromDisk('app_settings_box', path: appDocumentDir.path);
  
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(ComparisonSessionAdapter());
  Hive.registerAdapter(AppSettingsAdapter());

  final settingsRepository = SettingsRepository();
  await settingsRepository.init();

  final historyRepository = LocalHistoryRepository();
  await historyRepository.init();

  final initialAppSettings = await settingsRepository.loadSettings();

  runApp(MyApp(
    settingsRepository: settingsRepository,
    historyRepository: historyRepository,
    initialAppSettings: initialAppSettings,
  ));
}

class MyApp extends StatelessWidget {
  final SettingsRepository settingsRepository;
  final LocalHistoryRepository historyRepository;
  final AppSettings initialAppSettings;

  const MyApp({
    super.key,
    required this.settingsRepository,
    required this.historyRepository,
    required this.initialAppSettings,
  });

  @override
  Widget build(BuildContext context) {
    final comparisonEngine = ComparisonEngine();
    final translationService = GoogleTranslationService();
    final translationCache = LocalTranslationCache();
    final gitService = LibGit2DartService();
    final fileDiscoveryService = FileDiscoveryService();
    final fileWatcherService = FileWatcherService();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: settingsRepository),
        RepositoryProvider.value(value: historyRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(settingsRepository: settingsRepository)
              ..add(LoadSettings()),
          ),
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(initialSettings: initialAppSettings),
          ),
          BlocProvider<ProgressBloc>(
            create: (context) => ProgressBloc(),
          ),
          BlocProvider<ComparisonBloc>(
            create: (context) => ComparisonBloc(
              comparisonEngine: comparisonEngine,
              progressBloc: BlocProvider.of<ProgressBloc>(context),
              settingsBloc: BlocProvider.of<SettingsBloc>(context),
            ),
          ),
          BlocProvider<HistoryBloc>(
            create: (context) => HistoryBloc(historyRepository: historyRepository)
              ..add(LoadHistory()),
          ),
          BlocProvider<TranslationBloc>(
            create: (context) => TranslationBloc(
              translationService: translationService,
              translationCache: translationCache,
            ),
          ),
          BlocProvider<GitBloc>(
            create: (context) => GitBloc(gitService: gitService),
          ),
          BlocProvider<DirectoryComparisonBloc>(
            create: (context) => DirectoryComparisonBloc(
              fileDiscoveryService: fileDiscoveryService,
              comparisonEngine: comparisonEngine,
            ),
          ),
          BlocProvider<FileWatcherBloc>(
            create: (context) => FileWatcherBloc(fileWatcherService),
          ),
        ],
        child: BlocListener<SettingsBloc, SettingsState>(
          listener: (context, settingsState) {
            if (settingsState.status == SettingsStatus.loaded) {
              context.read<ThemeBloc>().add(UpdateThemeSettings(settingsState.appSettings));
            }
          },
          child: BlocBuilder<ThemeBloc, AppThemeState>(
            builder: (context, themeState) {
              final settingsState = context.watch<SettingsBloc>().state;
              bool useAmoled = false;
              if (settingsState.status == SettingsStatus.loaded) {
                useAmoled = settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';
              }

              return MaterialApp(
                title: 'Localization Comparison Tool',
                theme: AppTheme.getLightTheme(themeState.accentColor),
                darkTheme: AppTheme.getDarkTheme(themeState.accentColor, isAmoled: useAmoled),
                themeMode: themeState.themeMode,
                home: const MyHomePage(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const int _numberOfTabs = 4; // Reduced number of tabs

  @override
  void initState() {
    super.initState();
    // Determine initial tab based on settings
    final settingsBloc = context.read<SettingsBloc>();
    final initialTabIndex = _getInitialTabIndex(settingsBloc.state.appSettings.defaultViewOnStartup);
    
    _tabController = TabController(length: _numberOfTabs, vsync: this, initialIndex: initialTabIndex);
    // Add listener to call setState when tab changes, to update tab content style
    _tabController.addListener(() {
      if (mounted && (_tabController.indexIsChanging || _tabController.index != _tabController.previousIndex)) {
        setState(() {});
      }
    });
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
        // For now, default to Basic Comparison. In future, could store last used tab
        return 0;
      default:
        return 0; // Default to Basic Comparison
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(() {}); // Clean up listener
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> get _widgetOptions => <Widget>[
        const BasicComparisonView(),
        HistoryView(onNavigateToTab: (index) => _tabController.animateTo(index)),
        const FilesView(), // Placeholder for "Files" tab
        const SettingsView(),
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsState = context.watch<SettingsBloc>().state;
    // Access accent color from ThemeBloc for UI elements if needed, e.g., for the AppBar icon
    final currentAccentColor = context.watch<ThemeBloc>().state.accentColor;
    final isDarkMode = theme.brightness == Brightness.dark;
    
    // Use dynamic AppBar background based on theme and accent, or a fixed color from settings if preferred
    final Color appBarBackgroundColor;
    if (isDarkMode && settingsState.status == SettingsStatus.loaded) {
        appBarBackgroundColor = settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled' ? Colors.black : const Color(0xFF2A2D3E);
    } else {
        appBarBackgroundColor = theme.appBarTheme.backgroundColor ?? theme.primaryColor;
    }
      
    // The selectedTabIndicatorColor in the image is a distinct blue, not directly from accent.
    // If this should also be dynamic with accent, AppTheme needs to expose more colors from ColorScheme.
    final Color selectedTabIndicatorColor = Theme.of(context).colorScheme.primary;
    final Color selectedTabContentColor = isDarkMode ? Colors.white : theme.colorScheme.onPrimary; 
    final Color unselectedTabContentColor = isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBackgroundColor,
        title: const Text('Localization Comparison Tool'),
        actions: [
          IconButton(
            // Icon color should adapt based on AppBar's effective background
            icon: Icon(theme.brightness == Brightness.dark 
                ? Icons.light_mode_outlined 
                : Icons.dark_mode_outlined),
            onPressed: () {
              // This button now needs to update the setting in SettingsBloc
              final settingsBloc = context.read<SettingsBloc>();
              if (settingsBloc.state.status == SettingsStatus.loaded) {
                final currentSettings = settingsBloc.state.appSettings;
                String newThemeModeString;
                if (currentSettings.appThemeMode.toLowerCase() == 'light') {
                  newThemeModeString = 'Dark';
                } else if (currentSettings.appThemeMode.toLowerCase() == 'dark') {
                  newThemeModeString = 'Amoled';
                } else if (currentSettings.appThemeMode.toLowerCase() == 'amoled') {
                  newThemeModeString = 'System';
                } else { // System or other
                  newThemeModeString = 'Light';
                }
                settingsBloc.add(UpdateAppThemeMode(newThemeModeString));
              }
            },
            tooltip: 'Toggle Theme',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          indicator: BoxDecoration(
             color: selectedTabIndicatorColor, 
             borderRadius: BorderRadius.circular(8.0),
          ),
          indicatorSize: TabBarIndicatorSize.label, 
          labelPadding: const EdgeInsets.symmetric(horizontal: 4.0), 
          tabs: [
            _buildTab(icon: Icons.list_alt_outlined, text: 'Basic', isSelected: _tabController.index == 0, selectedColor: selectedTabContentColor, unselectedColor: unselectedTabContentColor),
            _buildTab(icon: Icons.history_outlined, text: 'History', isSelected: _tabController.index == 1, selectedColor: selectedTabContentColor, unselectedColor: unselectedTabContentColor),
            _buildTab(icon: Icons.folder_outlined, text: 'Files', isSelected: _tabController.index == 2, selectedColor: selectedTabContentColor, unselectedColor: unselectedTabContentColor),
            _buildTab(icon: Icons.settings_outlined, text: 'Settings', isSelected: _tabController.index == 3, selectedColor: selectedTabContentColor, unselectedColor: unselectedTabContentColor),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _widgetOptions,
      ),
    );
  }

  Widget _buildTab({
    required IconData icon,
    required String text,
    required bool isSelected,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    final Color contentColor = isSelected ? selectedColor : unselectedColor;
    return Tab(
      child: Padding( 
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: contentColor, size: 18),
            const SizedBox(width: 8),
            Text(text, style: TextStyle(color: contentColor, fontSize: 14)),
          ],
        ),
      ),
    );
  }
} 