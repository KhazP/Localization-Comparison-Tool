import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/repositories/settings_repository.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;
  final SecureStorageService _secureStorageService;
  final ApiKeyValidationService _apiKeyValidationService;

  SettingsBloc({
    required SettingsRepository settingsRepository,
    required SecureStorageService secureStorageService,
    required ApiKeyValidationService apiKeyValidationService,
  })  : _settingsRepository = settingsRepository,
        _secureStorageService = secureStorageService,
        _apiKeyValidationService = apiKeyValidationService,
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
    on<UpdateDiffIdenticalColor>(_onUpdateDiffIdenticalColor);
    on<UpdateDiffFontSize>(_onUpdateDiffFontSize);
    on<UpdateDiffFontFamily>(_onUpdateDiffFontFamily);
    on<UpdateDiffColors>(_onUpdateDiffColors);
    on<UpdateDefaultSourceEncoding>(_onUpdateDefaultSourceEncoding);
    on<UpdateDefaultTargetEncoding>(_onUpdateDefaultTargetEncoding);
    on<UpdateAutoDetectEncoding>(_onUpdateAutoDetectEncoding);
    on<UpdateCsvDelimiter>(_onUpdateCsvDelimiter);
    on<UpdateHandleByteOrderMark>(_onUpdateHandleByteOrderMark);
    on<UpdateAutoReloadOnChange>(_onUpdateAutoReloadOnChange);
    on<UpdateDefaultExportDirectory>(_onUpdateDefaultExportDirectory);
    on<UpdateDefaultExportFormat>(_onUpdateDefaultExportFormat);
    on<UpdateIncludeUtf8Bom>(_onUpdateIncludeUtf8Bom);
    on<UpdateOpenFolderAfterExport>(_onUpdateOpenFolderAfterExport);
    on<UpdateAutoBackup>(_onUpdateAutoBackup);
    on<UpdateBackupDirectory>(_onUpdateBackupDirectory);
    on<UpdateBackupsToKeep>(_onUpdateBackupsToKeep);
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
    on<UpdateTranslationConfidenceThreshold>(
        _onUpdateTranslationConfidenceThreshold);

    on<UpdateGeminiApiKey>(_onUpdateGeminiApiKey);
    on<UpdateOpenAiApiKey>(_onUpdateOpenAiApiKey);
    on<TestApiKey>(_onTestApiKey);
    on<UpdateDefaultAiModel>(_onUpdateDefaultAiModel);
    on<UpdateSystemTranslationContext>(_onUpdateSystemTranslationContext);
    on<UpdateContextStringsCount>(_onUpdateContextStringsCount);
    on<UpdateIncludeContextStrings>(_onUpdateIncludeContextStrings);
    on<UpdateEnableTranslationMemory>(_onUpdateEnableTranslationMemory);
    on<UpdateEnableFuzzyFill>(_onUpdateEnableFuzzyFill);
    on<UpdateFuzzyFillMinScore>(_onUpdateFuzzyFillMinScore);
    on<UpdateFuzzyFillAutoApply>(_onUpdateFuzzyFillAutoApply);
    on<UpdateFuzzyFillOnlyEmptyTargets>(_onUpdateFuzzyFillOnlyEmptyTargets);
    on<UpdateFuzzyFillMatchLimit>(_onUpdateFuzzyFillMatchLimit);
    on<UpdateFuzzyFillExactMatchesOnly>(_onUpdateFuzzyFillExactMatchesOnly);
    // Version Control Events
    on<UpdateDefaultGitRepositoryPath>(_onUpdateDefaultGitRepositoryPath);
    on<UpdateAutoCommitOnSave>(_onUpdateAutoCommitOnSave);
    on<UpdateGitUserName>(_onUpdateGitUserName);
    on<UpdateGitUserEmail>(_onUpdateGitUserEmail);
    on<UpdateEnableGitIntegration>(_onUpdateEnableGitIntegration);
    on<UpdateDefaultBranch>(_onUpdateDefaultBranch);
    on<UpdateDefaultRemote>(_onUpdateDefaultRemote);
    on<UpdateCommitMessageTemplate>(_onUpdateCommitMessageTemplate);
    on<UpdateSshKeyPath>(_onUpdateSshKeyPath);
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
    // Windows Integration Events
    on<UpdateUseMicaEffect>(_onUpdateUseMicaEffect);

    // AI Model Parameters
    on<UpdateAiTemperature>(_onUpdateAiTemperature);
    on<UpdateMaxTokens>(_onUpdateMaxTokens);
    on<FetchAvailableModels>(_onFetchAvailableModels);
    // Update Settings Events
    on<UpdateAutoDownloadUpdate>(_onUpdateAutoDownloadUpdate);
    on<UpdateLastUpdateCheckTime>(_onUpdateLastUpdateCheckTime);
    on<UpdateSkipVersion>(_onUpdateSkipVersion);
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
        await _secureStorageService
            .storeGoogleApiKey(settings.googleTranslateApiKey);
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

      await _saveSettingsToRepository(settings);

      emit(
          state.copyWith(appSettings: settings, status: SettingsStatus.loaded));
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

  Map<ApiProvider, ApiKeyTestResult> _initialApiKeyTests() {
    return {
      ApiProvider.googleTranslate: const ApiKeyTestResult.idle(),
      ApiProvider.deepl: const ApiKeyTestResult.idle(),
      ApiProvider.gemini: const ApiKeyTestResult.idle(),
      ApiProvider.openAi: const ApiKeyTestResult.idle(),
    };
  }

  Map<ApiProvider, ApiKeyTestResult> _updateApiKeyTest(
    ApiProvider provider,
    ApiKeyTestResult result,
  ) {
    final updated = Map<ApiProvider, ApiKeyTestResult>.from(state.apiKeyTests);
    updated[provider] = result;
    return updated;
  }

  Future<void> _onUpdateDefaultSourceFormat(
      UpdateDefaultSourceFormat event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultSourceFormat: event.newFormat);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultTargetFormat(
      UpdateDefaultTargetFormat event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultTargetFormat: event.newFormat);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onAddIgnorePattern(
      AddIgnorePattern event, Emitter<SettingsState> emit) async {
    final updatedPatterns = List<String>.from(state.appSettings.ignorePatterns)
      ..add(event.pattern);
    final newSettings =
        state.appSettings.copyWith(ignorePatterns: updatedPatterns);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onRemoveIgnorePattern(
      RemoveIgnorePattern event, Emitter<SettingsState> emit) async {
    final updatedPatterns = List<String>.from(state.appSettings.ignorePatterns)
      ..remove(event.pattern);
    final newSettings =
        state.appSettings.copyWith(ignorePatterns: updatedPatterns);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateIgnoreCase(
      UpdateIgnoreCase event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(ignoreCase: event.ignoreCase);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateIgnoreWhitespace(
      UpdateIgnoreWhitespace event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(ignoreWhitespace: event.ignoreWhitespace);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAppLanguage(
      UpdateAppLanguage event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(appLanguage: event.appLanguage);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultViewOnStartup(
      UpdateDefaultViewOnStartup event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultViewOnStartup: event.defaultView);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAutoCheckForUpdates(
      UpdateAutoCheckForUpdates event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(autoCheckForUpdates: event.autoCheck);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAppThemeMode(
      UpdateAppThemeMode event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(appThemeMode: event.themeMode);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAccentColor(
      UpdateAccentColor event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(accentColorValue: event.colorValue);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffAddedColor(
      UpdateDiffAddedColor event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(diffAddedColor: event.colorValue);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffRemovedColor(
      UpdateDiffRemovedColor event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(diffRemovedColor: event.colorValue);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffModifiedColor(
      UpdateDiffModifiedColor event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(diffModifiedColor: event.colorValue);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffIdenticalColor(
      UpdateDiffIdenticalColor event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(diffIdenticalColor: event.colorValue);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffFontSize(
      UpdateDiffFontSize event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(diffFontSize: event.fontSize);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffFontFamily(
      UpdateDiffFontFamily event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(diffFontFamily: event.fontFamily);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDiffColors(
      UpdateDiffColors event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(
      diffAddedColor: event.addedColor ?? state.appSettings.diffAddedColor,
      diffRemovedColor:
          event.removedColor ?? state.appSettings.diffRemovedColor,
      diffModifiedColor:
          event.modifiedColor ?? state.appSettings.diffModifiedColor,
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
    final newSettings =
        state.appSettings.copyWith(csvDelimiter: event.delimiter);
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

  Future<void> _onUpdateDefaultExportFormat(
      UpdateDefaultExportFormat event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultExportFormat: event.format);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateIncludeUtf8Bom(
      UpdateIncludeUtf8Bom event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(includeUtf8Bom: event.enable);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateOpenFolderAfterExport(
      UpdateOpenFolderAfterExport event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(openFolderAfterExport: event.enable);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAutoBackup(
      UpdateAutoBackup event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(autoBackup: event.enable);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateBackupDirectory(
      UpdateBackupDirectory event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(
      backupDirectory: event.directory.trim(),
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateBackupsToKeep(
      UpdateBackupsToKeep event, Emitter<SettingsState> emit) async {
    final clampedCount = event.count < 1
        ? 1
        : event.count > 10
            ? 10
            : event.count;
    final newSettings = state.appSettings.copyWith(
      backupsToKeep: clampedCount,
    );
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
      defaultExportFormat: defaultSettings.defaultExportFormat,
      includeUtf8Bom: defaultSettings.includeUtf8Bom,
      openFolderAfterExport: defaultSettings.openFolderAfterExport,
      autoBackup: defaultSettings.autoBackup,
      backupDirectory: defaultSettings.backupDirectory,
      backupsToKeep: defaultSettings.backupsToKeep,
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
      enableFuzzyFill: defaultSettings.enableFuzzyFill,
      fuzzyFillMinScore: defaultSettings.fuzzyFillMinScore,
      fuzzyFillAutoApply: defaultSettings.fuzzyFillAutoApply,
      fuzzyFillOnlyEmptyTargets: defaultSettings.fuzzyFillOnlyEmptyTargets,
      fuzzyFillMatchLimit: defaultSettings.fuzzyFillMatchLimit,
      fuzzyFillExactMatchesOnly: defaultSettings.fuzzyFillExactMatchesOnly,
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
      diffIdenticalColor: defaultSettings.diffIdenticalColor,
      diffFontSize: defaultSettings.diffFontSize,
      diffFontFamily: defaultSettings.diffFontFamily,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onResetAllSettings(
      ResetAllSettings event, Emitter<SettingsState> emit) async {
    await _secureStorageService.clearAllKeys();
    final defaultSettings = AppSettings.defaultSettings();
    await _saveSettingsToRepository(defaultSettings);
    emit(state.copyWith(
      appSettings: defaultSettings,
      apiKeyTests: _initialApiKeyTests(),
    ));
  }

  // AI Services Event Handlers
  Future<void> _onUpdateAiTranslationService(
      UpdateAiTranslationService event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(aiTranslationService: event.service);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateGoogleTranslateApiKey(
      UpdateGoogleTranslateApiKey event, Emitter<SettingsState> emit) async {
    await _secureStorageService.storeGoogleApiKey(event.apiKey);
    final newSettings =
        state.appSettings.copyWith(googleTranslateApiKey: event.apiKey);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(
      appSettings: newSettings,
      apiKeyTests: _updateApiKeyTest(
        ApiProvider.googleTranslate,
        const ApiKeyTestResult.idle(),
      ),
    ));
  }

  Future<void> _onUpdateDeeplApiKey(
      UpdateDeeplApiKey event, Emitter<SettingsState> emit) async {
    await _secureStorageService.storeDeepLApiKey(event.apiKey);
    final newSettings = state.appSettings.copyWith(deeplApiKey: event.apiKey);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(
      appSettings: newSettings,
      apiKeyTests: _updateApiKeyTest(
        ApiProvider.deepl,
        const ApiKeyTestResult.idle(),
      ),
    ));
  }

  Future<void> _onUpdateEnableAiTranslation(
      UpdateEnableAiTranslation event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(enableAiTranslation: event.enabled);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateTranslationConfidenceThreshold(
      UpdateTranslationConfidenceThreshold event,
      Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings
        .copyWith(translationConfidenceThreshold: event.threshold);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateGeminiApiKey(
      UpdateGeminiApiKey event, Emitter<SettingsState> emit) async {
    await _secureStorageService.storeGeminiApiKey(event.apiKey);
    final newSettings = state.appSettings.copyWith(geminiApiKey: event.apiKey);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(
      appSettings: newSettings,
      apiKeyTests: _updateApiKeyTest(
        ApiProvider.gemini,
        const ApiKeyTestResult.idle(),
      ),
    ));
  }

  Future<void> _onUpdateOpenAiApiKey(
      UpdateOpenAiApiKey event, Emitter<SettingsState> emit) async {
    await _secureStorageService.storeOpenAiApiKey(event.apiKey);
    final newSettings = state.appSettings.copyWith(openaiApiKey: event.apiKey);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(
      appSettings: newSettings,
      apiKeyTests: _updateApiKeyTest(
        ApiProvider.openAi,
        const ApiKeyTestResult.idle(),
      ),
    ));
  }

  Future<void> _onTestApiKey(
      TestApiKey event, Emitter<SettingsState> emit) async {
    final trimmedKey = event.apiKey.trim();
    if (trimmedKey.isEmpty) {
      emit(state.copyWith(
        apiKeyTests: _updateApiKeyTest(
          event.provider,
          const ApiKeyTestResult(
            status: ApiKeyTestStatus.failure,
            message: 'Please enter a key first.',
          ),
        ),
      ));
      return;
    }

    emit(state.copyWith(
      apiKeyTests: _updateApiKeyTest(
        event.provider,
        const ApiKeyTestResult(
          status: ApiKeyTestStatus.testing,
          message: 'Checking...',
        ),
      ),
    ));

    final result =
        await _apiKeyValidationService.testApiKey(event.provider, trimmedKey);
    emit(state.copyWith(
      apiKeyTests: _updateApiKeyTest(
        event.provider,
        ApiKeyTestResult(
          status: result.success
              ? ApiKeyTestStatus.success
              : ApiKeyTestStatus.failure,
          message: result.message,
          usage: result.usage,
        ),
      ),
    ));

    if (result.success &&
        (event.provider == ApiProvider.gemini ||
            event.provider == ApiProvider.openAi)) {
      add(FetchAvailableModels(event.provider));
    }
  }

  Future<void> _onUpdateDefaultAiModel(
      UpdateDefaultAiModel event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(defaultAiModel: event.model);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateSystemTranslationContext(
      UpdateSystemTranslationContext event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(systemTranslationContext: event.context);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateContextStringsCount(
      UpdateContextStringsCount event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(contextStringsCount: event.count);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateIncludeContextStrings(
      UpdateIncludeContextStrings event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(includeContextStrings: event.include);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateEnableTranslationMemory(
      UpdateEnableTranslationMemory event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(
      enableTranslationMemory: event.enabled,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateEnableFuzzyFill(
      UpdateEnableFuzzyFill event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(enableFuzzyFill: event.enabled);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateFuzzyFillMinScore(
      UpdateFuzzyFillMinScore event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(fuzzyFillMinScore: event.minScore);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateFuzzyFillAutoApply(
      UpdateFuzzyFillAutoApply event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(fuzzyFillAutoApply: event.enabled);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateFuzzyFillOnlyEmptyTargets(
      UpdateFuzzyFillOnlyEmptyTargets event,
      Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(fuzzyFillOnlyEmptyTargets: event.enabled);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateFuzzyFillMatchLimit(
      UpdateFuzzyFillMatchLimit event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(fuzzyFillMatchLimit: event.limit);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateFuzzyFillExactMatchesOnly(
      UpdateFuzzyFillExactMatchesOnly event,
      Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(
      fuzzyFillExactMatchesOnly: event.enabled,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  // Version Control Event Handlers
  Future<void> _onUpdateDefaultGitRepositoryPath(
      UpdateDefaultGitRepositoryPath event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultGitRepositoryPath: event.path);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAutoCommitOnSave(
      UpdateAutoCommitOnSave event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(autoCommitOnSave: event.enabled);
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
    final newSettings =
        state.appSettings.copyWith(gitUserEmail: event.userEmail);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateEnableGitIntegration(
      UpdateEnableGitIntegration event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(enableGitIntegration: event.enabled);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultBranch(
      UpdateDefaultBranch event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultBranch: event.branch);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateDefaultRemote(
      UpdateDefaultRemote event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(defaultRemote: event.remote);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateCommitMessageTemplate(
      UpdateCommitMessageTemplate event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(commitMessageTemplate: event.template);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateSshKeyPath(
      UpdateSshKeyPath event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(sshKeyPath: event.path);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateShowIdenticalEntries(
      UpdateShowIdenticalEntries event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(showIdenticalEntries: event.show);
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
      translationConfidenceThreshold:
          defaultSettings.translationConfidenceThreshold,
      geminiApiKey: defaultSettings.geminiApiKey,
      openaiApiKey: defaultSettings.openaiApiKey,
      defaultAiModel: defaultSettings.defaultAiModel,
      systemTranslationContext: defaultSettings.systemTranslationContext,
      contextStringsCount: defaultSettings.contextStringsCount,
      includeContextStrings: defaultSettings.includeContextStrings,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(
      appSettings: newSettings,
      apiKeyTests: _initialApiKeyTests(),
    ));
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
      defaultBranch: defaultSettings.defaultBranch,
      defaultRemote: defaultSettings.defaultRemote,
    );
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  // Startup Options Event Handlers
  Future<void> _onUpdateStartMinimizedToTray(
      UpdateStartMinimizedToTray event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(startMinimizedToTray: event.minimized);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateOpenLastProjectOnStartup(
      UpdateOpenLastProjectOnStartup event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(openLastProjectOnStartup: event.open);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateRememberWindowPosition(
      UpdateRememberWindowPosition event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(rememberWindowPosition: event.remember);
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
    final newSettings =
        state.appSettings.copyWith(similarityThreshold: event.threshold);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateComparisonMode(
      UpdateComparisonMode event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(comparisonMode: event.mode);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  // Windows Integration Event Handlers
  Future<void> _onUpdateUseMicaEffect(
      UpdateUseMicaEffect event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(useMicaEffect: event.enabled);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateAiTemperature(
      UpdateAiTemperature event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(aiTemperature: event.temperature);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateMaxTokens(
      UpdateMaxTokens event, Emitter<SettingsState> emit) async {
    final newSettings = state.appSettings.copyWith(maxTokens: event.maxTokens);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onFetchAvailableModels(
      FetchAvailableModels event, Emitter<SettingsState> emit) async {
    String? apiKey;
    if (event.provider == ApiProvider.gemini) {
      apiKey = await _secureStorageService.getGeminiApiKey();
    } else if (event.provider == ApiProvider.openAi) {
      apiKey = await _secureStorageService.getOpenAiApiKey();
    }

    if (apiKey == null || apiKey.isEmpty) return;

    final models = await _apiKeyValidationService.fetchAvailableModels(
      event.provider,
      apiKey,
    );

    if (models.isNotEmpty) {
      final updatedAvailableModels =
          Map<ApiProvider, List<String>>.from(state.availableModels);
      updatedAvailableModels[event.provider] = models;
      emit(state.copyWith(availableModels: updatedAvailableModels));

      // Select first model if default is empty
      if (state.appSettings.defaultAiModel.isEmpty) {
        add(UpdateDefaultAiModel(models.first));
      }
    }
  }

  // Update Settings Event Handlers
  Future<void> _onUpdateAutoDownloadUpdate(
      UpdateAutoDownloadUpdate event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(autoDownloadUpdate: event.enabled);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateLastUpdateCheckTime(
      UpdateLastUpdateCheckTime event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(lastUpdateCheckTime: event.timestamp);
    await _saveSettingsToRepository(newSettings);
    emit(state.copyWith(appSettings: newSettings));
  }

  Future<void> _onUpdateSkipVersion(
      UpdateSkipVersion event, Emitter<SettingsState> emit) async {
    final newSettings =
        state.appSettings.copyWith(skipVersion: event.version);
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
