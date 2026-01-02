import 'package:get_it/get_it.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/core/services/dio_client.dart';
import 'package:localizer_app_main/core/services/file_discovery_service.dart';
import 'package:localizer_app_main/core/services/file_watcher_service.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/core/services/app_command_service.dart';
import 'package:localizer_app_main/core/services/app_tab_service.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/repositories/history_repository.dart';
import 'package:localizer_app_main/data/repositories/project_repository.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/data/repositories/warning_suppressions_repository.dart';
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';
import 'package:localizer_app_main/data/services/update_checker_service.dart';
import 'package:localizer_app_main/data/services/'
    'translation_memory_service.dart';

/// Global service locator instance
final GetIt sl = GetIt.instance;

/// Initialize all services and dependencies
/// 
/// Call this once at app startup, before runApp()
Future<void> setupServiceLocator() async {
  // Talker - register first so other services can use it for logging
  sl.registerLazySingleton<TalkerService>(() => TalkerService());

  // Core services - singletons
  sl.registerLazySingleton<ComparisonEngine>(() => ComparisonEngine());
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<FileWatcherService>(() => FileWatcherService());
  sl.registerLazySingleton<FileDiscoveryService>(() => FileDiscoveryService());
  sl.registerLazySingleton<AppCommandService>(() => AppCommandService());
  sl.registerLazySingleton<AppTabService>(() => AppTabService());

  // HTTP client - shared across services, with Talker logging
  sl.registerLazySingleton<DioClient>(
    () => DioClient(talkerService: sl<TalkerService>()),
  );

  // Translation services
  sl.registerLazySingleton<LocalTranslationCache>(() => LocalTranslationCache());
  sl.registerLazySingleton<TranslationMemoryService>(
    () => TranslationMemoryService(),
  );
  sl.registerLazySingleton<TranslationService>(
    () => GoogleTranslationService(
      secureStorage: sl<SecureStorageService>(),
      dioClient: sl<DioClient>(),
    ),
  );
  sl.registerLazySingleton<ApiKeyValidationService>(
    () => ApiKeyValidationService(dioClient: sl<DioClient>()),
  );
  sl.registerLazySingleton<UpdateCheckerService>(
    () => UpdateCheckerService(dioClient: sl<DioClient>()),
  );

  // Git service
  sl.registerLazySingleton<GitService>(() => LibGit2DartService());
  
  // Repositories - require async initialization
  final settingsRepository = SettingsRepository();
  await settingsRepository.init();
  sl.registerSingleton<SettingsRepository>(settingsRepository);
  
  final historyRepository = LocalHistoryRepository();
  await historyRepository.init();
  sl.registerSingleton<LocalHistoryRepository>(historyRepository);
  
  // Project repository (no async init needed)
  sl.registerLazySingleton<ProjectRepository>(
    () => ProjectRepository(secureStorageService: sl<SecureStorageService>()),
  );

  // Warning suppressions repository (async init needed)
  final warningSuppressionsRepository = WarningSuppressionsRepository();
  await warningSuppressionsRepository.init();
  sl.registerSingleton<WarningSuppressionsRepository>(warningSuppressionsRepository);
}

/// Reset service locator - useful for testing
Future<void> resetServiceLocator() async {
  await sl.reset();
}
