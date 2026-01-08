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
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_event.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_scope.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/translation_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/file_watcher_bloc/file_watcher_bloc.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/core/services/file_discovery_service.dart';
import 'package:localizer_app_main/core/services/file_watcher_service.dart';
import 'package:localizer_app_main/core/services/project_import_service.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/repositories/history_repository.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/repositories/project_repository.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/data/repositories/warning_suppressions_repository.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';
import 'package:localizer_app_main/data/services/translation_memory_service.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/views/home_view.dart';
import 'package:window_manager/window_manager.dart';
import 'package:localizer_app_main/presentation/widgets/window/custom_title_bar.dart';
import 'package:localizer_app_main/core/input/app_shortcuts.dart';
import 'package:localizer_app_main/core/input/app_actions.dart';
import 'package:localizer_app_main/core/input/app_intents.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
    final projectImportService = sl<ProjectImportService>();
    final settingsRepository = sl<SettingsRepository>();
    final historyRepository = sl<LocalHistoryRepository>();
    final projectRepository = sl<ProjectRepository>();
    final apiKeyValidationService = sl<ApiKeyValidationService>();
    final warningSuppressionsRepository = sl<WarningSuppressionsRepository>();
    final talkerService = sl<TalkerService>();

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
              warningSuppressionsRepository: warningSuppressionsRepository,
              onProgress: (percentage, stage, {bytesProcessed, totalBytes}) {
                final progressBloc = context.read<ProgressBloc>();
                if (percentage <= 0) {
                  progressBloc.add(ComparisonStarted(initialMessage: stage));
                  return;
                }
                progressBloc.add(ProgressUpdated(
                  percentage: percentage,
                  stage: stage,
                  bytesProcessed: bytesProcessed,
                  totalBytes: totalBytes,
                ));
              },
            ),
          ),
          BlocProvider<HistoryBloc>(
            create: (context) =>
                HistoryBloc(historyRepository: historyRepository)
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
            create: (context) => GitBloc(
              gitService: gitService,
              historyRepository: historyRepository,
            ),
          ),
          BlocProvider<DirectoryComparisonBloc>(
            create: (context) => DirectoryComparisonBloc(
              fileDiscoveryService: fileDiscoveryService,
              comparisonEngine: comparisonEngine,
              historyRepository: historyRepository,
            ),
          ),
          BlocProvider<FileWatcherBloc>(
            create: (context) => FileWatcherBloc(fileWatcherService),
          ),
          BlocProvider<ProjectBloc>(
            create: (context) => ProjectBloc(
              projectRepository: projectRepository,
              projectImportService: projectImportService,
            )..add(const LoadLastProject()),
          ),
        ],
        child: TranslationProvider(
          child: _WindowAwareApp(
            openLastProject: initialAppSettings.openLastProjectOnStartup,
            talkerService: talkerService,
          ),
        ),
      ),
    );
  }
}

/// A widget that wraps the app and listens to window events to save position.
class _WindowAwareApp extends StatefulWidget {
  final bool openLastProject;
  final TalkerService talkerService;

  const _WindowAwareApp({
    required this.openLastProject,
    required this.talkerService,
  });

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
    // ProjectBloc → SettingsBloc: Load/clear project settings when project state changes
    return BlocListener<ProjectBloc, ProjectState>(
      listenWhen: (previous, current) {
        // Listen when project is loaded or closed
        return previous.currentProject != current.currentProject;
      },
      listener: (context, projectState) {
        final settingsBloc = context.read<SettingsBloc>();

        if (projectState.hasProject) {
          // Project opened - load its settings into SettingsBloc
          final project = projectState.currentProject!;
          settingsBloc.add(LoadProjectSettings(
            projectId: project.id,
            projectName: project.name,
            settings: project.settings,
          ));
        } else {
          // Project closed - clear project settings from SettingsBloc
          settingsBloc.add(const ClearProjectSettings());
        }
      },
      // SettingsBloc → ProjectBloc: Save project settings when they change
      child: BlocListener<SettingsBloc, SettingsState>(
        listenWhen: (previous, current) {
          // Only listen when in project scope and project settings actually changed
          return current.scope == SettingsScope.project &&
              current.hasProject &&
              previous.projectSettings != current.projectSettings;
        },
        listener: (context, settingsState) {
          // Persist project settings changes back to ProjectBloc
          if (settingsState.projectSettings != null) {
            context.read<ProjectBloc>().add(
                  UpdateProjectSettings(settingsState.projectSettings!),
                );
          }
        },
        child: BlocListener<HistoryBloc, HistoryState>(
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
                context
                    .read<ThemeBloc>()
                    .add(UpdateThemeSettings(settingsState.appSettings));
              }
            },
            child: BlocBuilder<ThemeBloc, AppThemeState>(
              builder: (context, themeState) {
                final settingsState = context.watch<SettingsBloc>().state;
                bool useAmoled = false;
                bool useMica = false;
                if (settingsState.status == SettingsStatus.loaded) {
                  useAmoled =
                      settingsState.appSettings.appThemeMode.toLowerCase() ==
                          'amoled';
                  useMica = Platform.isWindows &&
                      settingsState.appSettings.useMicaEffect;
                }

                // Determine dark theme: Mica > Amoled > Standard Dark
                ThemeData darkTheme;
                if (useMica) {
                  darkTheme =
                      AppThemeV2.createMicaTheme(themeState.accentColor);
                } else if (useAmoled) {
                  darkTheme =
                      AppThemeV2.createAmoledTheme(themeState.accentColor);
                } else {
                  darkTheme =
                      AppThemeV2.createDarkTheme(themeState.accentColor);
                }

                Widget app = Shortcuts(
                  shortcuts: AppShortcuts.defaults,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: kDebugMode,
                    showPerformanceOverlay:
                        settingsState.appSettings.showPerformanceOverlay,
                    showSemanticsDebugger:
                        settingsState.appSettings.showSemanticsDebugger,
                    debugShowMaterialGrid:
                        settingsState.appSettings.debugShowMaterialGrid,
                    checkerboardRasterCacheImages:
                        settingsState.appSettings.checkerboardRasterCacheImages,
                    checkerboardOffscreenLayers:
                        settingsState.appSettings.checkerboardOffscreenLayers,
                    title: context.t.app.title,
                    locale: TranslationProvider.of(context).flutterLocale,
                    supportedLocales: AppLocaleUtils.supportedLocales,
                    localizationsDelegates:
                        GlobalMaterialLocalizations.delegates,
                    theme: AppThemeV2.createLightTheme(themeState.accentColor),
                    darkTheme: darkTheme,
                    themeMode: themeState.themeMode,
                    builder: (context, child) {
                      final backgroundColor =
                          Theme.of(context).scaffoldBackgroundColor;
                      return ColoredBox(
                        color: backgroundColor,
                        child: Column(
                          children: [
                            const CustomTitleBar(),
                            Expanded(
                              child: Actions(
                                actions: GlobalActions.getActions(context),
                                child: child ?? const SizedBox.shrink(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    home: MyHomePage(
                      initialSession: _initialSession,
                      talkerService: widget.talkerService,
                    ),
                  ),
                );

                // TalkerWrapper error alerts disabled - they cause large UI overlay issues
                // Errors are still logged to console via TalkerService

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
            label: context.t.menu.about(appName: context.t.app.name),
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
        label: context.t.menu.file,
        menus: [
          PlatformMenuItem(
            label: context.t.menu.openFiles,
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyO, meta: true),
            onSelected: () {
              Actions.invoke(context, const OpenFileIntent());
            },
          ),
          PlatformMenuItem(
            label: context.t.menu.openFolder,
            shortcut: const SingleActivator(LogicalKeyboardKey.keyO,
                meta: true, shift: true),
            onSelected: () {
              Actions.invoke(context, const OpenFolderIntent());
            },
          ),
          const PlatformMenuItemGroup(members: []),
          PlatformMenuItem(
            label: context.t.menu.exportResults,
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyE, meta: true),
            onSelected: () {
              Actions.invoke(context, const ExportIntent());
            },
          ),
        ],
      ),
      // Edit Menu
      // Note: Some PlatformProvidedMenuItemType values (undo, redo, cut, copy, paste)
      // are only available in newer Flutter versions. Using custom items for compatibility.
      PlatformMenu(
        label: context.t.menu.edit,
        menus: [
          PlatformMenuItem(
            label: context.t.menu.undo,
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyZ, meta: true),
            onSelected: null, // System handles this
          ),
          PlatformMenuItem(
            label: context.t.menu.redo,
            shortcut: SingleActivator(LogicalKeyboardKey.keyZ,
                meta: true, shift: true),
            onSelected: null,
          ),
          const PlatformMenuItemGroup(members: []),
          PlatformMenuItem(
            label: context.t.menu.cut,
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyX, meta: true),
            onSelected: null,
          ),
          PlatformMenuItem(
            label: context.t.common.copyText,
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyC, meta: true),
            onSelected: null,
          ),
          PlatformMenuItem(
            label: context.t.menu.paste,
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyV, meta: true),
            onSelected: null,
          ),
          PlatformMenuItem(
            label: context.t.menu.selectAll,
            shortcut: SingleActivator(LogicalKeyboardKey.keyA, meta: true),
            onSelected: null,
          ),
        ],
      ),
      // View Menu
      PlatformMenu(
        label: context.t.menu.view,
        menus: [
          if (Platform.isMacOS)
            const PlatformProvidedMenuItem(
              type: PlatformProvidedMenuItemType.toggleFullScreen,
            ),
          PlatformMenuItem(
            label: context.t.menu.zoomIn,
            shortcut:
                const SingleActivator(LogicalKeyboardKey.equal, meta: true),
            onSelected: () {
              Actions.invoke(context, const ZoomInIntent());
            },
          ),
          PlatformMenuItem(
            label: context.t.menu.zoomOut,
            shortcut:
                const SingleActivator(LogicalKeyboardKey.minus, meta: true),
            onSelected: () {
              Actions.invoke(context, const ZoomOutIntent());
            },
          ),
          PlatformMenuItem(
            label: context.t.menu.resetZoom,
            shortcut:
                const SingleActivator(LogicalKeyboardKey.digit0, meta: true),
            onSelected: () {
              Actions.invoke(context, const ResetZoomIntent());
            },
          ),
        ],
      ),
      // Help Menu
      PlatformMenu(
        label: context.t.menu.help,
        menus: [
          PlatformMenuItem(
            label: context.t.menu.documentation,
            onSelected: () {
              debugPrint('Documentation triggered');
            },
          ),
          PlatformMenuItem(
            label: context.t.menu.reportIssue,
            onSelected: () {
              debugPrint('Report Issue triggered');
            },
          ),
        ],
      ),
    ];
  }
}
