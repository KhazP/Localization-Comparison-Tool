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
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/views/home_view.dart';

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
              // Optional: Add progress callback if needed
              // onProgress: (completed, total, message) {
              //   BlocProvider.of<ProgressBloc>(context).add(ProgressUpdated(completed, message));
              // },
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
                debugShowCheckedModeBanner: kDebugMode,
                title: 'Localization Comparison Tool',
                theme: AppThemeV2.lightTheme,
                darkTheme: useAmoled ? AppThemeV2.amoledTheme : AppThemeV2.darkTheme,
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
