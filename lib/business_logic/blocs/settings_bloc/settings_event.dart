part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class UpdateDefaultSourceFormat extends SettingsEvent {
  final String newFormat;
  const UpdateDefaultSourceFormat(this.newFormat);
  @override
  List<Object?> get props => [newFormat];
}

class UpdateDefaultTargetFormat extends SettingsEvent {
  final String newFormat;
  const UpdateDefaultTargetFormat(this.newFormat);
  @override
  List<Object?> get props => [newFormat];
}

class AddIgnorePattern extends SettingsEvent {
  final String pattern;
  const AddIgnorePattern(this.pattern);
  @override
  List<Object?> get props => [pattern];
}

class RemoveIgnorePattern extends SettingsEvent {
  final String pattern;
  const RemoveIgnorePattern(this.pattern);
  @override
  List<Object?> get props => [pattern];
}

class UpdateIgnoreCase extends SettingsEvent {
  final bool ignoreCase;
  const UpdateIgnoreCase(this.ignoreCase);
  @override
  List<Object?> get props => [ignoreCase];
}

class UpdateIgnoreWhitespace extends SettingsEvent {
  final bool ignoreWhitespace;
  const UpdateIgnoreWhitespace(this.ignoreWhitespace);
  @override
  List<Object?> get props => [ignoreWhitespace];
}

class UpdateAppLanguage extends SettingsEvent {
  final String appLanguage;
  const UpdateAppLanguage(this.appLanguage);
  @override
  List<Object?> get props => [appLanguage];
}

class UpdateDefaultViewOnStartup extends SettingsEvent {
  final String defaultView;
  const UpdateDefaultViewOnStartup(this.defaultView);
  @override
  List<Object?> get props => [defaultView];
}

class UpdateAutoCheckForUpdates extends SettingsEvent {
  final bool autoCheck;
  const UpdateAutoCheckForUpdates(this.autoCheck);
  @override
  List<Object?> get props => [autoCheck];
}

class UpdateAppThemeMode extends SettingsEvent {
  final String themeMode;
  const UpdateAppThemeMode(this.themeMode);
  @override
  List<Object?> get props => [themeMode];
}

class UpdateAccentColor extends SettingsEvent {
  final int colorValue;
  const UpdateAccentColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffAddedColor extends SettingsEvent {
  final int colorValue;
  const UpdateDiffAddedColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffRemovedColor extends SettingsEvent {
  final int colorValue;
  const UpdateDiffRemovedColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffModifiedColor extends SettingsEvent {
  final int colorValue;
  const UpdateDiffModifiedColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffIdenticalColor extends SettingsEvent {
  final int colorValue;
  const UpdateDiffIdenticalColor(this.colorValue);
  @override
  List<Object> get props => [colorValue];
}

class UpdateDiffColors extends SettingsEvent {
  final int? addedColor;
  final int? removedColor;
  final int? modifiedColor;
  const UpdateDiffColors(
      {this.addedColor, this.removedColor, this.modifiedColor});
  @override
  List<Object?> get props => [addedColor, removedColor, modifiedColor];
}

class UpdateDiffFontSize extends SettingsEvent {
  final double fontSize;
  const UpdateDiffFontSize(this.fontSize);
  @override
  List<Object> get props => [fontSize];
}

class UpdateDiffFontFamily extends SettingsEvent {
  final String fontFamily;
  const UpdateDiffFontFamily(this.fontFamily);
  @override
  List<Object> get props => [fontFamily];
}

class UpdateDefaultSourceEncoding extends SettingsEvent {
  final String encoding;
  const UpdateDefaultSourceEncoding(this.encoding);
  @override
  List<Object> get props => [encoding];
}

class UpdateDefaultTargetEncoding extends SettingsEvent {
  final String encoding;
  const UpdateDefaultTargetEncoding(this.encoding);
  @override
  List<Object> get props => [encoding];
}

class UpdateAutoDetectEncoding extends SettingsEvent {
  final bool autoDetect;
  const UpdateAutoDetectEncoding(this.autoDetect);
  @override
  List<Object> get props => [autoDetect];
}

class UpdateCsvDelimiter extends SettingsEvent {
  final String delimiter;
  const UpdateCsvDelimiter(this.delimiter);
  @override
  List<Object> get props => [delimiter];
}

class UpdateHandleByteOrderMark extends SettingsEvent {
  final bool handle;
  const UpdateHandleByteOrderMark(this.handle);
  @override
  List<Object> get props => [handle];
}

class UpdateAutoReloadOnChange extends SettingsEvent {
  final bool enabled;
  const UpdateAutoReloadOnChange(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateDefaultExportDirectory extends SettingsEvent {
  final String directory;
  const UpdateDefaultExportDirectory(this.directory);
  @override
  List<Object> get props => [directory];
}

class UpdateDefaultExportFormat extends SettingsEvent {
  final String format;
  const UpdateDefaultExportFormat(this.format);
  @override
  List<Object> get props => [format];
}

class UpdateIncludeUtf8Bom extends SettingsEvent {
  final bool enable;
  const UpdateIncludeUtf8Bom(this.enable);
  @override
  List<Object> get props => [enable];
}

class UpdateOpenFolderAfterExport extends SettingsEvent {
  final bool enable;
  const UpdateOpenFolderAfterExport(this.enable);
  @override
  List<Object> get props => [enable];
}

class UpdateAutoBackup extends SettingsEvent {
  final bool enable;
  const UpdateAutoBackup(this.enable);
  @override
  List<Object> get props => [enable];
}

class UpdateBackupDirectory extends SettingsEvent {
  final String directory;
  const UpdateBackupDirectory(this.directory);
  @override
  List<Object> get props => [directory];
}

class UpdateBackupsToKeep extends SettingsEvent {
  final int count;
  const UpdateBackupsToKeep(this.count);
  @override
  List<Object> get props => [count];
}

class ResetFileHandlingSettings extends SettingsEvent {}

class ResetGeneralSettings extends SettingsEvent {}

class ResetComparisonSettings extends SettingsEvent {}

class ResetAppearanceSettings extends SettingsEvent {}

class ResetAllSettings extends SettingsEvent {}

/// Status for API key validation.
enum ApiKeyTestStatus { idle, testing, success, failure }

// AI Services Events
class UpdateAiTranslationService extends SettingsEvent {
  final String service;
  const UpdateAiTranslationService(this.service);
  @override
  List<Object> get props => [service];
}

class UpdateGoogleTranslateApiKey extends SettingsEvent {
  final String apiKey;
  const UpdateGoogleTranslateApiKey(this.apiKey);
  @override
  List<Object> get props => [apiKey];
}

class UpdateDeeplApiKey extends SettingsEvent {
  final String apiKey;
  const UpdateDeeplApiKey(this.apiKey);
  @override
  List<Object> get props => [apiKey];
}

class UpdateEnableAiTranslation extends SettingsEvent {
  final bool enabled;
  const UpdateEnableAiTranslation(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateTranslationConfidenceThreshold extends SettingsEvent {
  final double threshold;
  const UpdateTranslationConfidenceThreshold(this.threshold);
  @override
  List<Object> get props => [threshold];
}

class UpdateGeminiApiKey extends SettingsEvent {
  final String apiKey;
  const UpdateGeminiApiKey(this.apiKey);
  @override
  List<Object> get props => [apiKey];
}

class UpdateOpenAiApiKey extends SettingsEvent {
  final String apiKey;
  const UpdateOpenAiApiKey(this.apiKey);
  @override
  List<Object> get props => [apiKey];
}

/// Triggers validation for a specific provider key.
class TestApiKey extends SettingsEvent {
  final ApiProvider provider;
  final String apiKey;
  const TestApiKey({
    required this.provider,
    required this.apiKey,
  });

  @override
  List<Object> get props => [provider, apiKey];
}

class FetchAvailableModels extends SettingsEvent {
  final ApiProvider provider;
  const FetchAvailableModels(this.provider);
  @override
  List<Object> get props => [provider];
}

class UpdateAiTemperature extends SettingsEvent {
  final double temperature;
  const UpdateAiTemperature(this.temperature);
  @override
  List<Object> get props => [temperature];
}

class UpdateMaxTokens extends SettingsEvent {
  final int maxTokens;
  const UpdateMaxTokens(this.maxTokens);
  @override
  List<Object> get props => [maxTokens];
}

class UpdateDefaultAiModel extends SettingsEvent {
  final String model;
  const UpdateDefaultAiModel(this.model);
  @override
  List<Object> get props => [model];
}

class UpdateSystemTranslationContext extends SettingsEvent {
  final String context;
  const UpdateSystemTranslationContext(this.context);
  @override
  List<Object> get props => [context];
}

class UpdateContextStringsCount extends SettingsEvent {
  final int count;
  const UpdateContextStringsCount(this.count);
  @override
  List<Object> get props => [count];
}

class UpdateIncludeContextStrings extends SettingsEvent {
  final bool include;
  const UpdateIncludeContextStrings(this.include);
  @override
  List<Object> get props => [include];
}

class UpdateEnableTranslationMemory extends SettingsEvent {
  final bool enabled;
  const UpdateEnableTranslationMemory(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateEnableFuzzyFill extends SettingsEvent {
  final bool enabled;
  const UpdateEnableFuzzyFill(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateFuzzyFillMinScore extends SettingsEvent {
  final double minScore;
  const UpdateFuzzyFillMinScore(this.minScore);
  @override
  List<Object> get props => [minScore];
}

class UpdateFuzzyFillAutoApply extends SettingsEvent {
  final bool enabled;
  const UpdateFuzzyFillAutoApply(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateFuzzyFillOnlyEmptyTargets extends SettingsEvent {
  final bool enabled;
  const UpdateFuzzyFillOnlyEmptyTargets(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateFuzzyFillMatchLimit extends SettingsEvent {
  final int limit;
  const UpdateFuzzyFillMatchLimit(this.limit);
  @override
  List<Object> get props => [limit];
}

class UpdateFuzzyFillExactMatchesOnly extends SettingsEvent {
  final bool enabled;
  const UpdateFuzzyFillExactMatchesOnly(this.enabled);
  @override
  List<Object> get props => [enabled];
}

// Version Control Events
class UpdateDefaultGitRepositoryPath extends SettingsEvent {
  final String path;
  const UpdateDefaultGitRepositoryPath(this.path);
  @override
  List<Object> get props => [path];
}

class UpdateAutoCommitOnSave extends SettingsEvent {
  final bool enabled;
  const UpdateAutoCommitOnSave(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateGitUserName extends SettingsEvent {
  final String userName;
  const UpdateGitUserName(this.userName);
  @override
  List<Object> get props => [userName];
}

class UpdateGitUserEmail extends SettingsEvent {
  final String userEmail;
  const UpdateGitUserEmail(this.userEmail);
  @override
  List<Object> get props => [userEmail];
}

class UpdateEnableGitIntegration extends SettingsEvent {
  final bool enabled;
  const UpdateEnableGitIntegration(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateDefaultBranch extends SettingsEvent {
  final String branch;
  const UpdateDefaultBranch(this.branch);
  @override
  List<Object> get props => [branch];
}

class UpdateDefaultRemote extends SettingsEvent {
  final String remote;
  const UpdateDefaultRemote(this.remote);
  @override
  List<Object> get props => [remote];
}

class UpdateCommitMessageTemplate extends SettingsEvent {
  final String template;
  const UpdateCommitMessageTemplate(this.template);
  @override
  List<Object> get props => [template];
}

class UpdateSshKeyPath extends SettingsEvent {
  final String path;
  const UpdateSshKeyPath(this.path);
  @override
  List<Object> get props => [path];
}

class UpdateShowIdenticalEntries extends SettingsEvent {
  final bool show;
  const UpdateShowIdenticalEntries(this.show);
  @override
  List<Object> get props => [show];
}

// Reset events for new categories
class ResetAiServicesSettings extends SettingsEvent {}

class ResetVersionControlSettings extends SettingsEvent {}

// Startup Options Events
class UpdateStartMinimizedToTray extends SettingsEvent {
  final bool minimized;
  const UpdateStartMinimizedToTray(this.minimized);
  @override
  List<Object> get props => [minimized];
}

class UpdateOpenLastProjectOnStartup extends SettingsEvent {
  final bool open;
  const UpdateOpenLastProjectOnStartup(this.open);
  @override
  List<Object> get props => [open];
}

class UpdateRememberWindowPosition extends SettingsEvent {
  final bool remember;
  const UpdateRememberWindowPosition(this.remember);
  @override
  List<Object> get props => [remember];
}

class UpdateWindowBounds extends SettingsEvent {
  final double? x;
  final double? y;
  final double? width;
  final double? height;
  const UpdateWindowBounds({this.x, this.y, this.width, this.height});
  @override
  List<Object?> get props => [x, y, width, height];
}

class UpdateSimilarityThreshold extends SettingsEvent {
  final double threshold;
  const UpdateSimilarityThreshold(this.threshold);
  @override
  List<Object> get props => [threshold];
}

class UpdateComparisonMode extends SettingsEvent {
  final String mode;
  const UpdateComparisonMode(this.mode);
  @override
  List<Object> get props => [mode];
}

// Windows Integration Events
class UpdateUseMicaEffect extends SettingsEvent {
  final bool enabled;
  const UpdateUseMicaEffect(this.enabled);
  @override
  List<Object> get props => [enabled];
}

// Update Settings Events
class UpdateAutoDownloadUpdate extends SettingsEvent {
  final bool enabled;
  const UpdateAutoDownloadUpdate(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateLastUpdateCheckTime extends SettingsEvent {
  final String? timestamp;
  const UpdateLastUpdateCheckTime(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

class UpdateSkipVersion extends SettingsEvent {
  final String version;
  const UpdateSkipVersion(this.version);
  @override
  List<Object> get props => [version];
}
