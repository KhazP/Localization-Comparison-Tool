import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/dio_client.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/data/cache/translation_cache.dart';
import 'package:localizer_app_main/data/services/gemini_translation_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';

/// Supported translation providers.
enum TranslationProvider {
  googleTranslate,
  gemini,
}

/// Factory for creating translation service instances.
///
/// Provides a unified way to create provider-specific translation services
/// with all required dependencies injected.
class TranslationServiceFactory {
  TranslationServiceFactory._();

  /// Creates a translation service for the specified provider.
  ///
  /// Uses the service locator to inject dependencies.
  static TranslationService create(TranslationProvider provider) {
    switch (provider) {
      case TranslationProvider.googleTranslate:
        return createGoogleTranslationService();
      case TranslationProvider.gemini:
        return createGeminiTranslationService();
    }
  }

  /// Creates a Google Translation Service instance.
  static GoogleTranslationService createGoogleTranslationService() {
    return GoogleTranslationService(
      secureStorage: sl<SecureStorageService>(),
      dioClient: sl<DioClient>(),
    );
  }

  /// Creates a Gemini Translation Service instance.
  static GeminiTranslationService createGeminiTranslationService() {
    return GeminiTranslationService(
      secureStorage: sl<SecureStorageService>(),
      cache: sl<LocalTranslationCache>(),
      talkerService: sl<TalkerService>(),
    );
  }
}
