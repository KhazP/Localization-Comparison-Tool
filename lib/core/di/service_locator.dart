import 'package:get_it/get_it.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/core/services/file_discovery_service.dart';
import 'package:localizer_app_main/core/services/file_watcher_service.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/repositories/history_repository.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';

/// Global service locator instance
final GetIt sl = GetIt.instance;

/// Initialize all services and dependencies
/// 
/// Call this once at app startup, before runApp()
Future<void> setupServiceLocator() async {
  // Core services - singletons
  sl.registerLazySingleton<ComparisonEngine>(() => ComparisonEngine());
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<FileWatcherService>(() => FileWatcherService());
  sl.registerLazySingleton<FileDiscoveryService>(() => FileDiscoveryService());
  
  // Translation services
  sl.registerLazySingleton<LocalTranslationCache>(() => LocalTranslationCache());
  sl.registerLazySingleton<TranslationService>(
    () => GoogleTranslationService(secureStorage: sl<SecureStorageService>()),
  );
  sl.registerLazySingleton<ApiKeyValidationService>(
    () => ApiKeyValidationService(),
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
}

/// Reset service locator - useful for testing
Future<void> resetServiceLocator() async {
  await sl.reset();
}
