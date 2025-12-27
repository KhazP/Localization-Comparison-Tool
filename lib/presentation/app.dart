import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/comparison_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/directory_comparison_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/git_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/progress_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/translation_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/file_watcher_bloc/file_watcher_bloc.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/core/services/file_discovery_service.dart';
import 'package:localizer_app_main/core/services/file_watcher_service.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/repositories/history_repository.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';
import 'package:localizer_app_main/data/services/'
    'translation_memory_service.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/views/home_view.dart';
import 'package:window_manager/window_manager.dart';

class MyApp extends StatelessWidget {
  final AppSettings initialAppSettings;

  const MyApp({
    super.key,
    required this.initialAppSettings,
  });

  @override
  Widget build(BuildContext context) {
    // Get all services from service locator instead of creating them here
    final comparisonEngine = sl<ComparisonEngine>();
    final secureStorageService = sl<SecureStorageService>();
    final translationService = sl<TranslationService>();
    final translationCache = sl<LocalTranslationCache>();
    final translationMemoryService = sl<TranslationMemoryService>();
    final gitService = sl<GitService>();
    final fileDiscoveryService = sl<FileDiscoveryService>();
    final fileWatcherService = sl<FileWatcherService>();
    final settingsRepository = sl<SettingsRepository>();
    final historyRepository = sl<LocalHistoryRepository>();
    final apiKeyValidationService = sl<ApiKeyValidationService>();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: settingsRepository),
        RepositoryProvider.value(value: historyRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(
              settingsRepository: settingsRepository,
              secureStorageService: secureStorageService,
              apiKeyValidationService: apiKeyValidationService,
            )..add(LoadSettings()),
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
              translationMemoryService: translationMemoryService,
              settingsRepository: settingsRepository,
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
        child: _WindowAwareApp(openLastProject: initialAppSettings.openLastProjectOnStartup),
      ),
    );
  }
}

/// A widget that wraps the app and listens to window events to save position.
class _WindowAwareApp extends StatefulWidget {
  final bool openLastProject;

  const _WindowAwareApp({required this.openLastProject});

  @override
  State<_WindowAwareApp> createState() => _WindowAwareAppState();
}

class _WindowAwareAppState extends State<_WindowAwareApp> with WindowListener {
  ComparisonSession? _initialSession;
  bool _hasLoadedInitialSession = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      windowManager.addListener(this);
    }
  }

  @override
  void dispose() {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      windowManager.removeListener(this);
    }
    super.dispose();
  }

  Future<void> _saveWindowBounds() async {
    if (!mounted) return;
    final settingsBloc = context.read<SettingsBloc>();
    if (settingsBloc.state.appSettings.rememberWindowPosition) {
      final bounds = await windowManager.getBounds();
      settingsBloc.add(UpdateWindowBounds(
        x: bounds.left,
        y: bounds.top,
        width: bounds.width,
        height: bounds.height,
      ));
    }
  }

  @override
  void onWindowResized() {
    _saveWindowBounds();
  }

  @override
  void onWindowMoved() {
    _saveWindowBounds();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryBloc, HistoryState>(
      listener: (context, historyState) {
        // Load initial session once when history first loads
        if (!_hasLoadedInitialSession && 
            widget.openLastProject && 
            historyState is HistoryLoaded && 
            historyState.history.isNotEmpty) {
          setState(() {
            _initialSession = historyState.history.first;
            _hasLoadedInitialSession = true;
          });
        }
      },
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
            bool useMica = false;
            if (settingsState.status == SettingsStatus.loaded) {
              useAmoled = settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';
              useMica = Platform.isWindows && settingsState.appSettings.useMicaEffect;
            }

            // Determine dark theme: Mica > Amoled > Standard Dark
            ThemeData darkTheme;
            if (useMica) {
              darkTheme = AppThemeV2.createMicaTheme(themeState.accentColor);
            } else if (useAmoled) {
              darkTheme = AppThemeV2.createAmoledTheme(themeState.accentColor);
            } else {
              darkTheme = AppThemeV2.createDarkTheme(themeState.accentColor);
            }

            final app = MaterialApp(
              debugShowCheckedModeBanner: kDebugMode,
              title: 'Localization Comparison Tool',
              theme: AppThemeV2.createLightTheme(themeState.accentColor),
              darkTheme: darkTheme,
              themeMode: themeState.themeMode,
              home: MyHomePage(initialSession: _initialSession),
            );

            // PlatformMenuBar is only supported on macOS
            if (Platform.isMacOS) {
              return PlatformMenuBar(
                menus: _buildPlatformMenus(context),
                child: app,
              );
            }
            return app;
          },
        ),
      ),
    );
  }

  /// Build platform-native menus for macOS (and other desktop platforms).
  /// This provides the standard App, File, Edit, View, Help menu structure.
  List<PlatformMenu> _buildPlatformMenus(BuildContext context) {
    return [
      // App Menu (macOS only - automatically uses app name)
      PlatformMenu(
        label: 'Localizer',
        menus: [
          PlatformMenuItem(
            label: 'About Localizer',
            onSelected: () {
              showAboutDialog(
                context: context,
                applicationName: 'Localizer',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2024 Localizer',
              );
            },
          ),
          const PlatformMenuItemGroup(members: []),
          if (Platform.isMacOS)
            const PlatformProvidedMenuItem(
              type: PlatformProvidedMenuItemType.hide,
            ),
          if (Platform.isMacOS)
            const PlatformProvidedMenuItem(
              type: PlatformProvidedMenuItemType.hideOtherApplications,
            ),
          if (Platform.isMacOS)
            const PlatformProvidedMenuItem(
              type: PlatformProvidedMenuItemType.showAllApplications,
            ),
          const PlatformMenuItemGroup(members: []),
          const PlatformProvidedMenuItem(
            type: PlatformProvidedMenuItemType.quit,
          ),
        ],
      ),
      // File Menu
      PlatformMenu(
        label: 'File',
        menus: [
          PlatformMenuItem(
            label: 'Open Files...',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyO, meta: true),
            onSelected: () {
              // Trigger file open - this would need to communicate with HomeView
              debugPrint('Open Files triggered from menu');
            },
          ),
          PlatformMenuItem(
            label: 'Open Folder...',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyO, meta: true, shift: true),
            onSelected: () {
              debugPrint('Open Folder triggered from menu');
            },
          ),
          const PlatformMenuItemGroup(members: []),
          PlatformMenuItem(
            label: 'Export Results...',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyE, meta: true),
            onSelected: () {
              debugPrint('Export triggered from menu');
            },
          ),
        ],
      ),
      // Edit Menu
      // Note: Some PlatformProvidedMenuItemType values (undo, redo, cut, copy, paste)
      // are only available in newer Flutter versions. Using custom items for compatibility.
      PlatformMenu(
        label: 'Edit',
        menus: [
          PlatformMenuItem(
            label: 'Undo',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyZ, meta: true),
            onSelected: null, // System handles this
          ),
          PlatformMenuItem(
            label: 'Redo',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyZ, meta: true, shift: true),
            onSelected: null,
          ),
          const PlatformMenuItemGroup(members: []),
          PlatformMenuItem(
            label: 'Cut',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyX, meta: true),
            onSelected: null,
          ),
          PlatformMenuItem(
            label: 'Copy',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyC, meta: true),
            onSelected: null,
          ),
          PlatformMenuItem(
            label: 'Paste',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyV, meta: true),
            onSelected: null,
          ),
          PlatformMenuItem(
            label: 'Select All',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyA, meta: true),
            onSelected: null,
          ),
        ],
      ),
      // View Menu
      PlatformMenu(
        label: 'View',
        menus: [
          if (Platform.isMacOS)
            const PlatformProvidedMenuItem(
              type: PlatformProvidedMenuItemType.toggleFullScreen,
            ),
          PlatformMenuItem(
            label: 'Zoom In',
            shortcut: const SingleActivator(LogicalKeyboardKey.equal, meta: true),
            onSelected: () {
              debugPrint('Zoom In triggered');
            },
          ),
          PlatformMenuItem(
            label: 'Zoom Out',
            shortcut: const SingleActivator(LogicalKeyboardKey.minus, meta: true),
            onSelected: () {
              debugPrint('Zoom Out triggered');
            },
          ),
          PlatformMenuItem(
            label: 'Reset Zoom',
            shortcut: const SingleActivator(LogicalKeyboardKey.digit0, meta: true),
            onSelected: () {
              debugPrint('Reset Zoom triggered');
            },
          ),
        ],
      ),
      // Help Menu
      PlatformMenu(
        label: 'Help',
        menus: [
          PlatformMenuItem(
            label: 'Documentation',
            onSelected: () {
              debugPrint('Documentation triggered');
            },
          ),
          PlatformMenuItem(
            label: 'Report an Issue',
            onSelected: () {
              debugPrint('Report Issue triggered');
            },
          ),
        ],
      ),
    ];
  }
}
