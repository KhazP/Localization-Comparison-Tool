import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;
  final SecureStorageService _secureStorageService;

  SettingsBloc({
    required SettingsRepository settingsRepository,
    required SecureStorageService secureStorageService,
  })  : _settingsRepository = settingsRepository,
        _secureStorageService = secureStorageService,
        super(SettingsState.initial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateDefaultSourceFormat>(_onUpdateDefaultSourceFormat);
    on<UpdateDefaultTargetFormat>(_onUpdateDefaultTargetFormat);
    on<AddIgnorePattern>(_onAddIgnorePattern);
    on<RemoveIgnorePattern>(_onRemoveIgnorePattern);
    on<UpdateIgnoreCase>(_onUpdateIgnoreCase);
    on<UpdateIgnoreWhitespace>(_onUpdateIgnoreWhitespace);
    on<UpdateAppLanguage>(_onUpdateAppLanguage);
    on<UpdateDefaultViewOnStartup>(_onUpdateDefaultViewOnStartup);
    on<UpdateAutoCheckForUpdates>(_onUpdateAutoCheckForUpdates);
    on<UpdateAppThemeMode>(_onUpdateAppThemeMode);
    on<UpdateAccentColor>(_onUpdateAccentColor);
    on<UpdateDiffAddedColor>(_onUpdateDiffAddedColor);
    on<UpdateDiffRemovedColor>(_onUpdateDiffRemovedColor);
    on<UpdateDiffModifiedColor>(_onUpdateDiffModifiedColor);
    on<UpdateDiffFontSize>(_onUpdateDiffFontSize);
    on<UpdateDiffColors>(_onUpdateDiffColors);
    on<UpdateDefaultSourceEncoding>(_onUpdateDefaultSourceEncoding);
    on<UpdateDefaultTargetEncoding>(_onUpdateDefaultTargetEncoding);
    on<UpdateAutoDetectEncoding>(_onUpdateAutoDetectEncoding);
    on<UpdateCsvDelimiter>(_onUpdateCsvDelimiter);
    on<UpdateHandleByteOrderMark>(_onUpdateHandleByteOrderMark);
    on<UpdateAutoReloadOnChange>(_onUpdateAutoReloadOnChange);
    on<UpdateDefaultExportDirectory>(_onUpdateDefaultExportDirectory);
    on<ResetFileHandlingSettings>(_onResetFileHandlingSettings);
    on<ResetGeneralSettings>(_onResetGeneralSettings);
    on<ResetComparisonSettings>(_onResetComparisonSettings);
    on<ResetAppearanceSettings>(_onResetAppearanceSettings);
    on<ResetAllSettings>(_onResetAllSettings);
    // AI Services Events
    on<UpdateAiTranslationService>(_onUpdateAiTranslationService);
    on<UpdateGoogleTranslateApiKey>(_onUpdateGoogleTranslateApiKey);
    on<UpdateDeeplApiKey>(_onUpdateDeeplApiKey);
    on<UpdateEnableAiTranslation>(_onUpdateEnableAiTranslation);
    on<UpdateTranslationConfidenceThreshold>(_onUpdateTranslationConfidenceThreshold);

    on<UpdateGeminiApiKey>(_onUpdateGeminiApiKey);
    on<UpdateOpenAiApiKey>(_onUpdateOpenAiApiKey);
    on<UpdateDefaultAiModel>(_onUpdateDefaultAiModel);
    on<UpdateSystemTranslationContext>(_onUpdateSystemTranslationContext);
    on<UpdateContextStringsCount>(_onUpdateContextStringsCount);
    on<UpdateIncludeContextStrings>(_onUpdateIncludeContextStrings);
    // Version Control Events
    on<UpdateDefaultGitRepositoryPath>(_onUpdateDefaultGitRepositoryPath);
    on<UpdateAutoCommitOnSave>(_onUpdateAutoCommitOnSave);
    on<UpdateGitUserName>(_onUpdateGitUserName);
    on<UpdateGitUserEmail>(_onUpdateGitUserEmail);
    on<UpdateEnableGitIntegration>(_onUpdateEnableGitIntegration);
    on<UpdateShowIdenticalEntries>(_onUpdateShowIdenticalEntries);
    // Reset events for new categories
    on<ResetAiServicesSettings>(_onResetAiServicesSettings);
    on<ResetVersionControlSettings>(_onResetVersionControlSettings);
    // Startup Options Events
    on<UpdateStartMinimizedToTray>(_onUpdateStartMinimizedToTray);
    on<UpdateOpenLastProjectOnStartup>(_onUpdateOpenLastProjectOnStartup);
    on<UpdateRememberWindowPosition>(_onUpdateRememberWindowPosition);
    on<UpdateWindowBounds>(_onUpdateWindowBounds);
    on<UpdateSimilarityThreshold>(_onUpdateSimilarityThreshold);
    on<UpdateComparisonMode>(_onUpdateComparisonMode);
  }

  Future<void> _onLoadSettings(
      LoadSettings event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: SettingsStatus.loading));
    try {
      var settings = await _settingsRepository.loadSettings();
      
      // Load API keys from secure storage
      final googleKey = await _secureStorageService.getGoogleApiKey();
      final deeplKey = await _secureStorageService.getDeepLApiKey();
      final geminiKey = await _secureStorageService.getGeminiApiKey();
      final openaiKey = await _secureStorageService.getOpenAiApiKey();

      // Migration: If keys are in Hive but not in SecureStorage, move them
      if (googleKey == null && settings.googleTranslateApiKey.isNotEmpty) {
        await _secureStorageService.storeGoogleApiKey(settings.googleTranslateApiKey);
      }
      if (deeplKey == null && settings.deeplApiKey.isNotEmpty) {
        await _secureStorageService.storeDeepLApiKey(settings.deeplApiKey);
      }
      if (geminiKey == null && settings.geminiApiKey.isNotEmpty) {
        await _secureStorageService.storeGeminiApiKey(settings.geminiApiKey);
      }
      if (openaiKey == null && settings.openaiApiKey.isNotEmpty) {
        await _secureStorageService.storeOpenAiApiKey(settings.openaiApiKey);
      }

      // Update settings with keys from SecureStorage (or keep existing if just migrated)
      settings = settings.copyWith(
        googleTranslateApiKey: googleKey ?? settings.googleTranslateApiKey,
        deeplApiKey: deeplKey ?? settings.deeplApiKey,
        geminiApiKey: geminiKey ?? settings.geminiApiKey,
        openaiApiKey: openaiKey ?? settings.openaiApiKey,
      );

      emit(state.copyWith(appSettings: settings, status: SettingsStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
          status: SettingsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _saveSettingsToRepository(AppSettings settings) async {
    // Create a copy for storage that has empty API keys to avoid saving them to Hive
    final storageSettings = settings.copyWith(
      googleTranslateApiKey: '',
      deeplApiKey: '',
      geminiApiKey: '',
      openaiApiKey: '',
    );
    await _settingsRepository.saveSettings(storageSettings);
  }

  Future<void> _onUpdateDefaultSourceFormat(
      UpdateDefaultSourceFormat event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(defaultSourceFormat: event.newFormat);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultTargetFormat(
      UpdateDefaultTargetFormat event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(defaultTargetFormat: event.newFormat);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onAddIgnorePattern(
      AddIgnorePattern event, Emitter<SettingsState> emit) async {
    final updatedPatterns = List<String>.from(state.appSettings.ignorePatterns)..add(event.pattern);
    final newSettings = state.appSettings.copyWith(ignorePatterns: updatedPatterns);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onRemoveIgnorePattern(
      RemoveIgnorePattern event, Emitter<SettingsState> emit) async {
    final updatedPatterns = List<String>.from(state.appSettings.ignorePatterns)..remove(event.pattern);
    final newSettings = state.appSettings.copyWith(ignorePatterns: updatedPatterns);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateIgnoreCase(
      UpdateIgnoreCase event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(ignoreCase: event.ignoreCase);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateIgnoreWhitespace(
      UpdateIgnoreWhitespace event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(ignoreWhitespace: event.ignoreWhitespace);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAppLanguage(
      UpdateAppLanguage event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(appLanguage: event.appLanguage);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultViewOnStartup(
      UpdateDefaultViewOnStartup event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(defaultViewOnStartup: event.defaultView);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAutoCheckForUpdates(
      UpdateAutoCheckForUpdates event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(autoCheckForUpdates: event.autoCheck);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAppThemeMode(
      UpdateAppThemeMode event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(appThemeMode: event.themeMode);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAccentColor(
      UpdateAccentColor event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(accentColorValue: event.colorValue);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffAddedColor(
      UpdateDiffAddedColor event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(diffAddedColor: event.colorValue);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffRemovedColor(
      UpdateDiffRemovedColor event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(diffRemovedColor: event.colorValue);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffModifiedColor(
      UpdateDiffModifiedColor event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(diffModifiedColor: event.colorValue);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffFontSize(
      UpdateDiffFontSize event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(diffFontSize: event.fontSize);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffColors(
      UpdateDiffColors event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(
      diffAddedColor: event.addedColor ?? state.appSettings.diffAddedColor,
      diffRemovedColor: event.removedColor ?? state.appSettings.diffRemovedColor,
      diffModifiedColor: event.modifiedColor ?? state.appSettings.diffModifiedColor,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultSourceEncoding(
      UpdateDefaultSourceEncoding event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultSourceEncoding: event.encoding);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultTargetEncoding(
      UpdateDefaultTargetEncoding event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultTargetEncoding: event.encoding);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAutoDetectEncoding(
      UpdateAutoDetectEncoding event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(autoDetectEncoding: event.autoDetect);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateCsvDelimiter(
      UpdateCsvDelimiter event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(csvDelimiter: event.delimiter);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateHandleByteOrderMark(
      UpdateHandleByteOrderMark event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(handleByteOrderMark: event.handle);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAutoReloadOnChange(
      UpdateAutoReloadOnChange event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(autoReloadOnChange: event.enabled);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultExportDirectory(
      UpdateDefaultExportDirectory event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultExportDirectory: event.directory);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onResetFileHandlingSettings(
      ResetFileHandlingSettings event, Emitter<SettingsState> emit) async {
    final defaultSettings = AppSettings.defaultSettings();
    final newSettings = state.appSettings.copyWith(
      defaultSourceEncoding: defaultSettings.defaultSourceEncoding,
      defaultTargetEncoding: defaultSettings.defaultTargetEncoding,
      autoDetectEncoding: defaultSettings.autoDetectEncoding,
      csvDelimiter: defaultSettings.csvDelimiter,
      handleByteOrderMark: defaultSettings.handleByteOrderMark,
      autoReloadOnChange: defaultSettings.autoReloadOnChange,
      defaultExportDirectory: defaultSettings.defaultExportDirectory,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onResetGeneralSettings(
      ResetGeneralSettings event, Emitter<SettingsState> emit) async {
    final defaultSettings = AppSettings.defaultSettings();
    final newSettings = state.appSettings.copyWith(
      appLanguage: defaultSettings.appLanguage,
      defaultViewOnStartup: defaultSettings.defaultViewOnStartup,
      autoCheckForUpdates: defaultSettings.autoCheckForUpdates,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onResetComparisonSettings(
      ResetComparisonSettings event, Emitter<SettingsState> emit) async {
    final defaultSettings = AppSettings.defaultSettings();
    final newSettings = state.appSettings.copyWith(
      ignoreCase: defaultSettings.ignoreCase,
      ignoreWhitespace: defaultSettings.ignoreWhitespace,
      ignorePatterns: List<String>.from(defaultSettings.ignorePatterns),
      similarityThreshold: defaultSettings.similarityThreshold,
      comparisonMode: defaultSettings.comparisonMode,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onResetAppearanceSettings(
      ResetAppearanceSettings event, Emitter<SettingsState> emit) async {
    final defaultSettings = AppSettings.defaultSettings();
    final newSettings = state.appSettings.copyWith(
      appThemeMode: defaultSettings.appThemeMode,
      accentColorValue: defaultSettings.accentColorValue,
      diffAddedColor: defaultSettings.diffAddedColor,
      diffRemovedColor: defaultSettings.diffRemovedColor,
      diffModifiedColor: defaultSettings.diffModifiedColor,
      diffFontSize: defaultSettings.diffFontSize,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onResetAllSettings(
      ResetAllSettings event, Emitter<SettingsState> emit) async {
    await _secureStorageService.clearAllKeys();
    final defaultSettings = AppSettings.defaultSettings();
    await _saveSettingsToRepository(defaultSettings);
    emit(state.copyWith(appSettings: defaultSettings));
  }

  // AI Services Event Handlers
  Future<void> _onUpdateAiTranslationService(
      UpdateAiTranslationService event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(aiTranslationService: event.service);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateGoogleTranslateApiKey(
      UpdateGoogleTranslateApiKey event, Emitter<SettingsState> emit) async {
    await _secureStorageService.storeGoogleApiKey(event.apiKey);
    final newSettings = state.appSettings.copyWith(googleTranslateApiKey: event.apiKey);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDeeplApiKey(
      UpdateDeeplApiKey event, Emitter<SettingsState> emit) async {
    await _secureStorageService.storeDeepLApiKey(event.apiKey);
    final newSettings = state.appSettings.copyWith(deeplApiKey: event.apiKey);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateEnableAiTranslation(
      UpdateEnableAiTranslation event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(enableAiTranslation: event.enabled);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateTranslationConfidenceThreshold(
      UpdateTranslationConfidenceThreshold event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(translationConfidenceThreshold: event.threshold);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateGeminiApiKey(
      UpdateGeminiApiKey event, Emitter<SettingsState> emit) async {
    await _secureStorageService.storeGeminiApiKey(event.apiKey);
    final newSettings = state.appSettings.copyWith(geminiApiKey: event.apiKey);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateOpenAiApiKey(
      UpdateOpenAiApiKey event, Emitter<SettingsState> emit) async {
    await _secureStorageService.storeOpenAiApiKey(event.apiKey);
    final newSettings = state.appSettings.copyWith(openaiApiKey: event.apiKey);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultAiModel(
      UpdateDefaultAiModel event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(defaultAiModel: event.model);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateSystemTranslationContext(
      UpdateSystemTranslationContext event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(systemTranslationContext: event.context);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateContextStringsCount(
      UpdateContextStringsCount event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(contextStringsCount: event.count);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateIncludeContextStrings(
      UpdateIncludeContextStrings event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(includeContextStrings: event.include);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  // Version Control Event Handlers
  Future<void> _onUpdateDefaultGitRepositoryPath(
      UpdateDefaultGitRepositoryPath event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(defaultGitRepositoryPath: event.path);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAutoCommitOnSave(
      UpdateAutoCommitOnSave event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(autoCommitOnSave: event.enabled);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateGitUserName(
      UpdateGitUserName event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(gitUserName: event.userName);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateGitUserEmail(
      UpdateGitUserEmail event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(gitUserEmail: event.userEmail);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateEnableGitIntegration(
      UpdateEnableGitIntegration event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(enableGitIntegration: event.enabled);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateShowIdenticalEntries(
      UpdateShowIdenticalEntries event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(showIdenticalEntries: event.show);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  // Reset Category Event Handlers
  Future<void> _onResetAiServicesSettings(
      ResetAiServicesSettings event, Emitter<SettingsState> emit) async {
    await _secureStorageService.clearAllKeys();
    final defaultSettings = AppSettings.defaultSettings();
    final newSettings = state.appSettings.copyWith(
      aiTranslationService: defaultSettings.aiTranslationService,
      googleTranslateApiKey: defaultSettings.googleTranslateApiKey,
      deeplApiKey: defaultSettings.deeplApiKey,
      enableAiTranslation: defaultSettings.enableAiTranslation,
      translationConfidenceThreshold: defaultSettings.translationConfidenceThreshold,
      geminiApiKey: defaultSettings.geminiApiKey,
      openaiApiKey: defaultSettings.openaiApiKey,
      defaultAiModel: defaultSettings.defaultAiModel,
      systemTranslationContext: defaultSettings.systemTranslationContext,
      contextStringsCount: defaultSettings.contextStringsCount,
      includeContextStrings: defaultSettings.includeContextStrings,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onResetVersionControlSettings(
      ResetVersionControlSettings event, Emitter<SettingsState> emit) async {
    final defaultSettings = AppSettings.defaultSettings();
    final newSettings = state.appSettings.copyWith(
      defaultGitRepositoryPath: defaultSettings.defaultGitRepositoryPath,
      autoCommitOnSave: defaultSettings.autoCommitOnSave,
      gitUserName: defaultSettings.gitUserName,
      gitUserEmail: defaultSettings.gitUserEmail,
      enableGitIntegration: defaultSettings.enableGitIntegration,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  // Startup Options Event Handlers
  Future<void> _onUpdateStartMinimizedToTray(
      UpdateStartMinimizedToTray event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(startMinimizedToTray: event.minimized);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateOpenLastProjectOnStartup(
      UpdateOpenLastProjectOnStartup event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(openLastProjectOnStartup: event.open);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateRememberWindowPosition(
      UpdateRememberWindowPosition event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(rememberWindowPosition: event.remember);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateWindowBounds(
      UpdateWindowBounds event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(
      lastWindowX: event.x,
      lastWindowY: event.y,
      lastWindowWidth: event.width,
      lastWindowHeight: event.height,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateSimilarityThreshold(
      UpdateSimilarityThreshold event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(similarityThreshold: event.threshold);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateComparisonMode(
      UpdateComparisonMode event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(comparisonMode: event.mode);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }
}

// Extension to add copyWith to AppSettings if not already present (or ensure it is)
// This is a common pattern but AppSettings is a HiveObject, so it should handle its own persistence.
// However, for updating state within the BLoC before saving, a copyWith is useful.
// Let's assume AppSettings will get its own copyWith or we manage it carefully.
// For now, the BLoC manually reconstructs where needed or relies on HiveObject's nature.
// Actually, it's better to add copyWith to AppSettings itself for cleaner BLoC logic. 