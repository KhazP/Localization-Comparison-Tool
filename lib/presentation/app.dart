import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';
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
    final gitService = sl<GitService>();
    final fileDiscoveryService = sl<FileDiscoveryService>();
    final fileWatcherService = sl<FileWatcherService>();
    final settingsRepository = sl<SettingsRepository>();
    final historyRepository = sl<LocalHistoryRepository>();

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
            if (settingsState.status == SettingsStatus.loaded) {
              useAmoled = settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';
            }

            return MaterialApp(
              debugShowCheckedModeBanner: kDebugMode,
              title: 'Localization Comparison Tool',
              theme: AppThemeV2.createLightTheme(themeState.accentColor),
              darkTheme: useAmoled ? AppThemeV2.createAmoledTheme(themeState.accentColor) : AppThemeV2.createDarkTheme(themeState.accentColor),
              themeMode: themeState.themeMode,
              home: MyHomePage(initialSession: _initialSession),
            );
          },
        ),
      ),
    );
  }
}
