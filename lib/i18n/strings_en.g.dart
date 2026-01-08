///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsAppEn app = TranslationsAppEn.internal(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn.internal(_root);
	late final TranslationsMenuEn menu = TranslationsMenuEn.internal(_root);
	late final TranslationsNavEn nav = TranslationsNavEn.internal(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn.internal(_root);
	late final TranslationsFileComparisonEn fileComparison = TranslationsFileComparisonEn.internal(_root);
	late final TranslationsDirectoryComparisonEn directoryComparison = TranslationsDirectoryComparisonEn.internal(_root);
	late final TranslationsGitComparisonEn gitComparison = TranslationsGitComparisonEn.internal(_root);
	late final TranslationsAdvancedComparisonEn advancedComparison = TranslationsAdvancedComparisonEn.internal(_root);
	late final TranslationsAdvancedDiffEn advancedDiff = TranslationsAdvancedDiffEn.internal(_root);
	late final TranslationsIssueDetailsEn issueDetails = TranslationsIssueDetailsEn.internal(_root);
	late final TranslationsImportReviewEn importReview = TranslationsImportReviewEn.internal(_root);
	late final TranslationsHistoryViewEn historyView = TranslationsHistoryViewEn.internal(_root);
	late final TranslationsCompareEn compare = TranslationsCompareEn.internal(_root);
	late final TranslationsHistoryEn history = TranslationsHistoryEn.internal(_root);
	late final TranslationsProjectsEn projects = TranslationsProjectsEn.internal(_root);
	late final TranslationsDiffEn diff = TranslationsDiffEn.internal(_root);
	late final TranslationsGitEn git = TranslationsGitEn.internal(_root);
	late final TranslationsQualityEn quality = TranslationsQualityEn.internal(_root);
	late final TranslationsErrorsEn errors = TranslationsErrorsEn.internal(_root);
	late final TranslationsWizardsEn wizards = TranslationsWizardsEn.internal(_root);
	late final TranslationsDialogsEn dialogs = TranslationsDialogsEn.internal(_root);
	late final TranslationsGridEn grid = TranslationsGridEn.internal(_root);
	late final TranslationsTutorialEn tutorial = TranslationsTutorialEn.internal(_root);
	late final TranslationsFriendlyErrorsEn friendlyErrors = TranslationsFriendlyErrorsEn.internal(_root);
	late final TranslationsSystemTrayEn systemTray = TranslationsSystemTrayEn.internal(_root);
	late final TranslationsValidationEn validation = TranslationsValidationEn.internal(_root);
	late final TranslationsStatusEn status = TranslationsStatusEn.internal(_root);
	late final TranslationsAiServicesEn aiServices = TranslationsAiServicesEn.internal(_root);
}

// Path: app
class TranslationsAppEn {
	TranslationsAppEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Localization Comparison Tool'
	String get title => 'Localization Comparison Tool';

	/// en: 'Localizer'
	String get name => 'Localizer';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Undo'
	String get undo => 'Undo';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Success'
	String get success => 'Success';

	/// en: 'Warning'
	String get warning => 'Warning';

	/// en: 'Info'
	String get info => 'Info';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Yes'
	String get yes => 'Yes';

	/// en: 'No'
	String get no => 'No';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Copy'
	String get copyText => 'Copy';

	/// en: 'Localizer'
	String get appName => 'Localizer';

	/// en: 'Copied!'
	String get copied => 'Copied!';

	/// en: 'Enabled'
	String get enabled => 'Enabled';

	/// en: 'Disabled'
	String get disabled => 'Disabled';

	/// en: 'Browse'
	String get browse => 'Browse';

	/// en: 'Clear'
	String get clear => 'Clear';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'Reset'
	String get reset => 'Reset';

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Export'
	String get export => 'Export';

	/// en: 'Import'
	String get import => 'Import';

	/// en: 'Select'
	String get select => 'Select';

	/// en: 'Select All'
	String get selectAll => 'Select All';

	/// en: 'Deselect All'
	String get deselectAll => 'Deselect All';

	/// en: 'No results found'
	String get noResults => 'No results found';

	/// en: 'Nothing here yet'
	String get emptyState => 'Nothing here yet';

	/// en: 'Open'
	String get open => 'Open';

	/// en: 'Change'
	String get change => 'Change';

	/// en: 'Original'
	String get original => 'Original';

	/// en: 'New'
	String get kNew => 'New';

	/// en: 'Remove'
	String get remove => 'Remove';

	/// en: 'Auto'
	String get auto => 'Auto';

	/// en: 'Execute'
	String get execute => 'Execute';

	/// en: 'Run'
	String get run => 'Run';

	/// en: 'Unknown'
	String get unknown => 'Unknown';

	/// en: 'Download'
	String get download => 'Download';

	/// en: 'Dropdown arrow'
	String get dropdownArrow => 'Dropdown arrow';

	/// en: 'Opens in new window'
	String get openInNewWindow => 'Opens in new window';

	/// en: 'Reset to defaults'
	String get resetToDefaults => 'Reset to defaults';
}

// Path: menu
class TranslationsMenuEn {
	TranslationsMenuEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'File'
	String get file => 'File';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'View'
	String get view => 'View';

	/// en: 'Help'
	String get help => 'Help';

	/// en: 'Open Files...'
	String get openFiles => 'Open Files...';

	/// en: 'Open Folder...'
	String get openFolder => 'Open Folder...';

	/// en: 'Export Results...'
	String get exportResults => 'Export Results...';

	/// en: 'Undo'
	String get undo => 'Undo';

	/// en: 'Redo'
	String get redo => 'Redo';

	/// en: 'Cut'
	String get cut => 'Cut';

	/// en: 'Paste'
	String get paste => 'Paste';

	/// en: 'Select All'
	String get selectAll => 'Select All';

	/// en: 'Zoom In'
	String get zoomIn => 'Zoom In';

	/// en: 'Zoom Out'
	String get zoomOut => 'Zoom Out';

	/// en: 'Reset Zoom'
	String get resetZoom => 'Reset Zoom';

	/// en: 'Documentation'
	String get documentation => 'Documentation';

	/// en: 'Report an Issue'
	String get reportIssue => 'Report an Issue';

	/// en: 'About ${appName}'
	String about({required Object appName}) => 'About ${appName}';
}

// Path: nav
class TranslationsNavEn {
	TranslationsNavEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Compare'
	String get compare => 'Compare';

	/// en: 'History'
	String get history => 'History';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Projects'
	String get projects => 'Projects';

	/// en: 'Dashboard'
	String get dashboard => 'Dashboard';

	/// en: 'Directory'
	String get directory => 'Directory';

	/// en: 'Repository'
	String get repository => 'Repository';

	/// en: 'Compare localization files'
	String get tooltipCompare => 'Compare localization files';

	/// en: 'View comparison history'
	String get tooltipHistory => 'View comparison history';

	/// en: 'App settings'
	String get tooltipSettings => 'App settings';

	/// en: 'Manage projects'
	String get tooltipProjects => 'Manage projects';

	/// en: 'Toggle Theme'
	String get tooltipThemeToggle => 'Toggle Theme';

	/// en: 'Debug Console'
	String get tooltipDebugConsole => 'Debug Console';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'App Settings'
	String get appSettings => 'App Settings';

	/// en: 'Project Settings'
	String get projectSettings => 'Project Settings';

	late final TranslationsSettingsAppearanceEn appearance = TranslationsSettingsAppearanceEn.internal(_root);
	late final TranslationsSettingsGeneralEn general = TranslationsSettingsGeneralEn.internal(_root);
	late final TranslationsSettingsScopeEn scope = TranslationsSettingsScopeEn.internal(_root);
	late final TranslationsSettingsSearchKeywordsEn searchKeywords = TranslationsSettingsSearchKeywordsEn.internal(_root);
	late final TranslationsSettingsComparisonEn comparison = TranslationsSettingsComparisonEn.internal(_root);
	late final TranslationsSettingsFileHandlingEn fileHandling = TranslationsSettingsFileHandlingEn.internal(_root);
	late final TranslationsSettingsTranslationMemoryEn translationMemory = TranslationsSettingsTranslationMemoryEn.internal(_root);
	late final TranslationsSettingsBackupEn backup = TranslationsSettingsBackupEn.internal(_root);
	late final TranslationsSettingsAiEn ai = TranslationsSettingsAiEn.internal(_root);
	late final TranslationsSettingsIntegrationsEn integrations = TranslationsSettingsIntegrationsEn.internal(_root);
	late final TranslationsSettingsDeveloperEn developer = TranslationsSettingsDeveloperEn.internal(_root);
	late final TranslationsSettingsAboutEn about = TranslationsSettingsAboutEn.internal(_root);
	late final TranslationsSettingsOnboardingEn onboarding = TranslationsSettingsOnboardingEn.internal(_root);
	late final TranslationsSettingsSettingsViewEn settingsView = TranslationsSettingsSettingsViewEn.internal(_root);
}

// Path: fileComparison
class TranslationsFileComparisonEn {
	TranslationsFileComparisonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'File Comparison'
	String get title => 'File Comparison';

	/// en: 'Open Files'
	String get openFiles => 'Open Files';

	/// en: 'Export Results'
	String get exportResults => 'Export Results';

	/// en: 'Restart Tutorial'
	String get restartTutorial => 'Restart Tutorial';

	/// en: 'Tutorial restart is available in developer mode only.'
	String get restartTutorialDevOnly => 'Tutorial restart is available in developer mode only.';

	/// en: 'Unsupported file type.'
	String get unsupportedFileType => 'Unsupported file type.';

	/// en: 'Please select a supported localization file.'
	String get unsupportedFileTypeSuggestion => 'Please select a supported localization file.';

	/// en: 'Some files are not supported.'
	String get someFilesUnsupported => 'Some files are not supported.';

	/// en: 'Pick supported localization files only.'
	String get pickSupportedFiles => 'Pick supported localization files only.';

	/// en: 'Pick two files to compare.'
	String get pickTwoFiles => 'Pick two files to compare.';

	/// en: 'Please select a bilingual file to compare.'
	String get pickBilingualFile => 'Please select a bilingual file to compare.';

	/// en: 'No results to export yet.'
	String get noResultsToExport => 'No results to export yet.';

	/// en: 'Perform a comparison first to export results.'
	String get performComparisonFirst => 'Perform a comparison first to export results.';

	/// en: 'Please perform a comparison first to see advanced details.'
	String get performComparisonFirstEditor => 'Please perform a comparison first to see advanced details.';

	/// en: 'Sample data loaded successfully'
	String get sampleDataLoaded => 'Sample data loaded successfully';

	/// en: 'Failed to load sample data: ${error}'
	String loadSampleDataError({required Object error}) => 'Failed to load sample data: ${error}';

	/// en: 'Invalid file type.'
	String get invalidFileType => 'Invalid file type.';

	/// en: '${label} selected: ${fileName}'
	String fileSelected({required Object label, required Object fileName}) => '${label} selected: ${fileName}';

	/// en: 'Source file'
	String get sourceFile => 'Source file';

	/// en: 'Target file'
	String get targetFile => 'Target file';

	/// en: 'Bilingual file'
	String get bilingualFile => 'Bilingual file';

	/// en: 'Compare Files'
	String get compareFiles => 'Compare Files';

	/// en: 'Compare File'
	String get compareFile => 'Compare File';

	/// en: 'Bilingual Mode'
	String get bilingualMode => 'Bilingual Mode';

	/// en: 'Two Files'
	String get twoFilesMode => 'Two Files';

	/// en: 'Processing...'
	String get processing => 'Processing...';

	/// en: '${time} remaining'
	String remaining({required Object time}) => '${time} remaining';

	/// en: 'Comparison in progress...'
	String get comparisonInProgress => 'Comparison in progress...';

	/// en: 'Comparison Failed: ${error}'
	String comparisonFailed({required Object error}) => 'Comparison Failed: ${error}';

	/// en: 'File changed: ${fileName}. Recomparing...'
	String fileChanged({required Object fileName}) => 'File changed: ${fileName}. Recomparing...';

	/// en: 'Drop file here'
	String get dropFileHere => 'Drop file here';

	/// en: 'Drop file or click to browse'
	String get dropFileOrBrowse => 'Drop file or click to browse';

	/// en: 'Upload file'
	String get fileUpload => 'Upload file';

	/// en: 'Change file'
	String get changeFile => 'Change file';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Show'
	String get show => 'Show';

	/// en: 'Show All'
	String get showAll => 'Show All';

	/// en: 'No matches found for "${query}"'
	String noMatches({required Object query}) => 'No matches found for "${query}"';

	/// en: 'Showing ${count} of ${total} entries'
	String showingEntries({required Object count, required Object total}) => 'Showing ${count} of ${total} entries';

	/// en: 'Files are identical.'
	String get filesIdentical => 'Files are identical.';

	/// en: '${count} identical entries hidden'
	String hiddenIdentical({required Object count}) => '${count} identical entries hidden';

	/// en: 'Show Identical Entries'
	String get showIdentical => 'Show Identical Entries';

	/// en: 'Hide identical entries'
	String get hideIdentical => 'Hide identical entries';

	/// en: 'No differences found based on keys.'
	String get noDiff => 'No differences found based on keys.';

	/// en: 'Source'
	String get source => 'Source';

	/// en: 'Target'
	String get target => 'Target';

	/// en: 'Value'
	String get value => 'Value';

	/// en: 'Ready to Compare Files'
	String get readyToCompare => 'Ready to Compare Files';

	/// en: 'Drop localization files above or use the browse buttons to select files for comparison.'
	String get readyToCompareDesc => 'Drop localization files above or use the browse buttons\nto select files for comparison.';

	/// en: 'Recent Comparisons'
	String get recentComparisons => 'Recent Comparisons';

	/// en: 'Bilingual file: ${name}'
	String bilingualFileLabel({required Object name}) => 'Bilingual file: ${name}';

	/// en: '${source} ↔ ${target}'
	String comparisonLabel({required Object source, required Object target}) => '${source} ↔ ${target}';

	/// en: 'One or both files from this session no longer exist.'
	String get fileNotExist => 'One or both files from this session no longer exist.';

	/// en: 'Large File Detected'
	String get largeFileTitle => 'Large File Detected';

	/// en: 'The comparison result contains ${count} entries. Displaying all of them might cause performance issues. Do you want to proceed?'
	String largeFileContent({required Object count}) => 'The comparison result contains ${count} entries.\nDisplaying all of them might cause performance issues.\n\nDo you want to proceed?';

	/// en: 'Don't show again for this file'
	String get dontShowAgain => 'Don\'t show again for this file';

	/// en: 'Proceed'
	String get proceed => 'Proceed';

	/// en: 'Save ${format} Report'
	String exportReport({required Object format}) => 'Save ${format} Report';

	/// en: '${format} saved'
	String saved({required Object format}) => '${format} saved';

	/// en: 'Failed to save ${format} file.'
	String saveError({required Object format}) => 'Failed to save ${format} file.';

	/// en: 'Failed to save ${format}: ${error}'
	String saveErrorDetailed({required Object format, required Object error}) => 'Failed to save ${format}: ${error}';

	/// en: 'Watching'
	String get watching => 'Watching';

	/// en: 'Watch Off'
	String get watchOff => 'Watch Off';

	/// en: 'File Watching: ${status} Automatically recompare when files change on disk'
	String watchingTooltip({required Object status}) => 'File Watching: ${status}\nAutomatically recompare when files change on disk';

	/// en: 'Navigation to AI Settings not available'
	String get aiSettingsNotAvailable => 'Navigation to AI Settings not available';
}

// Path: directoryComparison
class TranslationsDirectoryComparisonEn {
	TranslationsDirectoryComparisonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Directory Comparison'
	String get title => 'Directory Comparison';

	/// en: 'Source Directory'
	String get sourceDirectory => 'Source Directory';

	/// en: 'Target Directory'
	String get targetDirectory => 'Target Directory';

	/// en: 'Original/Reference files'
	String get sourceSubtitle => 'Original/Reference files';

	/// en: 'Translation/Comparison files'
	String get targetSubtitle => 'Translation/Comparison files';

	/// en: 'Please select both a source and target directory.'
	String get selectBothDirectories => 'Please select both a source and target directory.';

	/// en: 'Select Source Folder'
	String get selectSourceFolder => 'Select Source Folder';

	/// en: 'Select Target Folder'
	String get selectTargetFolder => 'Select Target Folder';

	/// en: 'Drop folder here or browse...'
	String get dropFolderHere => 'Drop folder here or browse...';

	/// en: 'Folder Path'
	String get folderPath => 'Folder Path';

	/// en: 'Ready to Compare Directories'
	String get readyToCompare => 'Ready to Compare Directories';

	/// en: 'Drop folders above or use the browse buttons to select directories for comparison.'
	String get readyToCompareDesc => 'Drop folders above or use the browse buttons\nto select directories for comparison.';

	/// en: 'Nested folders'
	String get nestedFolders => 'Nested folders';

	/// en: 'Recursively compares all nested directories'
	String get nestedFoldersTooltip => 'Recursively compares all nested directories';

	/// en: 'File matching'
	String get fileMatching => 'File matching';

	/// en: 'Automatically pairs files by name'
	String get fileMatchingTooltip => 'Automatically pairs files by name';

	/// en: 'Bulk export'
	String get bulkExport => 'Bulk export';

	/// en: 'Export all comparison results at once'
	String get bulkExportTooltip => 'Export all comparison results at once';

	/// en: 'This is not a directory comparison.'
	String get notDirectoryComparison => 'This is not a directory comparison.';

	/// en: 'One or both directories no longer exist.'
	String get directoriesNotExist => 'One or both directories no longer exist.';

	/// en: 'Error occurred'
	String get errorOccurred => 'Error occurred';

	/// en: 'No files found in selected directories.'
	String get noFilesFound => 'No files found in selected directories.';

	/// en: 'Unmatched Source Files'
	String get unmatchedSourceFiles => 'Unmatched Source Files';

	/// en: 'Unmatched Target Files'
	String get unmatchedTargetFiles => 'Unmatched Target Files';

	/// en: '${count} file pairs'
	String filePairs({required Object count}) => '${count} file pairs';

	/// en: 'Paired Files (${count})'
	String pairedFiles({required Object count}) => 'Paired Files (${count})';

	/// en: 'View'
	String get view => 'View';

	/// en: 'Failed'
	String get failed => 'Failed';

	/// en: 'Pair...'
	String get pair => 'Pair...';

	/// en: 'Pair "${name}" with:'
	String pairDialogTitle({required Object name}) => 'Pair "${name}" with:';

	/// en: 'Discover Files'
	String get discoverFiles => 'Discover Files';

	/// en: 'Compare All'
	String get compareAll => 'Compare All';

	/// en: 'Export All'
	String get exportAll => 'Export All';

	/// en: 'Comparison started...'
	String get comparisonStarted => 'Comparison started...';

	/// en: 'Discovering files...'
	String get discoveringFiles => 'Discovering files...';

	/// en: 'No comparison results to export. Run "Compare All" first.'
	String get noResultsToExport => 'No comparison results to export. Run "Compare All" first.';

	/// en: 'Select Export Folder'
	String get selectExportFolder => 'Select Export Folder';

	/// en: 'Failed to create export folder: ${error}'
	String createExportFolderError({required Object error}) => 'Failed to create export folder: ${error}';

	/// en: 'Exporting Results'
	String get exportingResults => 'Exporting Results';

	/// en: 'Processing: ${file}'
	String processingFile({required Object file}) => 'Processing: ${file}';

	/// en: '${current} of ${total} files exported'
	String exportProgress({required Object current, required Object total}) => '${current} of ${total} files exported';

	/// en: 'Export Complete'
	String get exportComplete => 'Export Complete';

	/// en: 'Successfully exported ${count} comparison files plus summary.'
	String exportSuccessMessage({required Object count}) => 'Successfully exported ${count} comparison files plus summary.';

	/// en: 'Export failed: ${error}'
	String exportFailed({required Object error}) => 'Export failed: ${error}';

	/// en: 'Close'
	String get close => 'Close';
}

// Path: gitComparison
class TranslationsGitComparisonEn {
	TranslationsGitComparisonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.'
	String get _translatorNote => 'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.';

	/// en: 'Repository Comparison'
	String get title => 'Repository Comparison';

	/// en: 'Create / Open Repository'
	String get repoSelector => 'Create / Open Repository';

	/// en: 'No repository selected'
	String get noRepoSelected => 'No repository selected';

	/// en: 'Open'
	String get open => 'Open';

	/// en: 'Refresh Commits'
	String get refreshCommits => 'Refresh Commits';

	/// en: 'No commits found or loaded. Select a branch to load commits.'
	String get noCommits => 'No commits found or loaded. Select a branch to load commits.';

	/// en: 'Base Commit (Older)'
	String get baseCommit => 'Base Commit (Older)';

	/// en: 'Target Commit (Newer)'
	String get targetCommit => 'Target Commit (Newer)';

	/// en: 'Filter Commits by Branch'
	String get filterCommitsByBranch => 'Filter Commits by Branch';

	/// en: 'Conflict detection'
	String get conflictDetection => 'Conflict detection';

	/// en: 'Detect and resolve merge conflicts'
	String get conflictDetectionTooltip => 'Detect and resolve merge conflicts';

	/// en: 'Actions:'
	String get actions => 'Actions:';

	/// en: 'Checkout'
	String get checkout => 'Checkout';

	/// en: 'Merge'
	String get merge => 'Merge';

	/// en: 'Pull'
	String get pull => 'Pull';

	/// en: 'Checkout Branch'
	String get checkoutBranch => 'Checkout Branch';

	/// en: 'Merge Branch into Current'
	String get mergeBranch => 'Merge Branch into Current';

	/// en: 'Merge ${branch}?'
	String mergeConfirmation({required Object branch}) => 'Merge ${branch}?';

	/// en: 'This will merge changes into your current working branch. Conflicts may occur.'
	String get mergeWarning => 'This will merge changes into your current working branch. Conflicts may occur.';

	/// en: 'Select Export Folder'
	String get selectExportFolder => 'Select Export Folder';

	/// en: 'Failed to create export folder: ${error}'
	String createExportFolderError({required Object error}) => 'Failed to create export folder: ${error}';

	/// en: 'Exporting Files'
	String get exportingFiles => 'Exporting Files';

	/// en: 'Processing: ${file}'
	String processingFile({required Object file}) => 'Processing: ${file}';

	/// en: '${current} of ${total} files exported'
	String exportProgress({required Object current, required Object total}) => '${current} of ${total} files exported';

	/// en: 'Export Complete'
	String get exportComplete => 'Export Complete';

	/// en: 'Successfully exported ${count} files with full content.'
	String exportSuccessMessage({required Object count}) => 'Successfully exported ${count} files with full content.';

	/// en: 'Each file's diff is saved in the "files" subfolder.'
	String get exportDetail => 'Each file\'s diff is saved in the "files" subfolder.';

	/// en: 'Diff Viewer'
	String get diffViewer => 'Diff Viewer';

	/// en: 'BASE'
	String get base => 'BASE';

	/// en: 'TARGET'
	String get target => 'TARGET';

	/// en: 'No lines to display'
	String get noLines => 'No lines to display';

	/// en: 'Search files...'
	String get searchFiles => 'Search files...';

	/// en: 'No files match "${query}"'
	String noFilesMatch({required Object query}) => 'No files match "${query}"';

	/// en: '${count} files'
	String filesCount({required Object count}) => '${count} files';

	/// en: 'Select Base File'
	String get selectBaseFile => 'Select Base File';

	/// en: 'Select Target File'
	String get selectTargetFile => 'Select Target File';

	/// en: 'Comparison Results'
	String get comparisonResults => 'Comparison Results';

	/// en: 'No changes found between selected refs.'
	String get noChanges => 'No changes found between selected refs.';

	/// en: 'Lines Added'
	String get linesAdded => 'Lines Added';

	/// en: 'Lines Removed'
	String get linesRemoved => 'Lines Removed';

	/// en: 'Commit'
	String get commit => 'Commit';

	/// en: 'Branch'
	String get branch => 'Branch';

	/// en: 'No repository selected'
	String get noRepositorySelected => 'No repository selected';

	/// en: 'Not a Git comparison'
	String get notGitComparison => 'Not a Git comparison';

	/// en: 'Repository does not exist'
	String get repositoryNotExist => 'Repository does not exist';

	/// en: 'main'
	String get mainBranch => 'main';

	/// en: 'master'
	String get masterBranch => 'master';

	/// en: 'Back to comparison controls'
	String get backToControls => 'Back to comparison controls';
}

// Path: advancedComparison
class TranslationsAdvancedComparisonEn {
	TranslationsAdvancedComparisonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Advanced Comparison View - Placeholder'
	String get placeholder => 'Advanced Comparison View - Placeholder';
}

// Path: advancedDiff
class TranslationsAdvancedDiffEn {
	TranslationsAdvancedDiffEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Save All Changes?'
	String get saveAllChanges => 'Save All Changes?';

	/// en: 'This will save all ${count} modified entries to the target file. This action cannot be undone.'
	String saveConfirmation({required Object count}) => 'This will save all ${count} modified entries to the target file. This action cannot be undone.';

	/// en: 'Changes saved successfully.'
	String get changesSaved => 'Changes saved successfully.';

	/// en: 'CSV exported'
	String get csvExported => 'CSV exported';

	/// en: 'Unsaved Changes'
	String get unsavedChanges => 'Unsaved Changes';

	/// en: 'You have unsaved changes. Are you sure you want to discard them?'
	String get unsavedChangesWarning => 'You have unsaved changes. Are you sure you want to discard them?';

	/// en: 'Discard Changes'
	String get discardChanges => 'Discard Changes';

	/// en: 'Go back'
	String get goBack => 'Go back';

	/// en: 'Home > Editor'
	String get breadcrumbs => 'Home  >  Editor';

	/// en: '${count} unsaved'
	String unsaved({required Object count}) => '${count} unsaved';

	/// en: '${count} reviewed'
	String reviewed({required Object count}) => '${count} reviewed';

	/// en: 'Save All (${count})'
	String saveAll({required Object count}) => 'Save All (${count})';

	/// en: 'All Saved'
	String get allSaved => 'All Saved';

	/// en: 'Save All Changes (Ctrl+S)'
	String get saveAllTooltip => 'Save All Changes (Ctrl+S)';

	/// en: 'Export Data (Ctrl+E)'
	String get exportTooltip => 'Export Data (Ctrl+E)';

	late final TranslationsAdvancedDiffAiSuggestionEn aiSuggestion = TranslationsAdvancedDiffAiSuggestionEn.internal(_root);
	late final TranslationsAdvancedDiffDetailEditEn detailEdit = TranslationsAdvancedDiffDetailEditEn.internal(_root);
	late final TranslationsAdvancedDiffTableEn table = TranslationsAdvancedDiffTableEn.internal(_root);
	late final TranslationsAdvancedDiffDiffRowEn diffRow = TranslationsAdvancedDiffDiffRowEn.internal(_root);
	late final TranslationsAdvancedDiffStatusEn status = TranslationsAdvancedDiffStatusEn.internal(_root);
	late final TranslationsAdvancedDiffSidebarEn sidebar = TranslationsAdvancedDiffSidebarEn.internal(_root);
}

// Path: issueDetails
class TranslationsIssueDetailsEn {
	TranslationsIssueDetailsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Issue Details'
	String get title => 'Issue Details';

	/// en: 'Showing ${count} of ${total} issues'
	String showingIssues({required Object count, required Object total}) => 'Showing ${count} of ${total} issues';

	/// en: 'Search by key, text, or error...'
	String get searchPlaceholder => 'Search by key, text, or error...';

	/// en: 'No details available.'
	String get noDetails => 'No details available.';

	/// en: 'No matches found.'
	String get noMatches => 'No matches found.';

	/// en: 'Show More'
	String get showMore => 'Show More';

	/// en: 'Copy ${count} Items'
	String copyItems({required Object count}) => 'Copy ${count} Items';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Copied to clipboard'
	String get copied => 'Copied to clipboard';

	/// en: 'Copied ${count} items'
	String copiedCount({required Object count}) => 'Copied ${count} items';

	late final TranslationsIssueDetailsDuplicateValueEn duplicateValue = TranslationsIssueDetailsDuplicateValueEn.internal(_root);
	late final TranslationsIssueDetailsLengthOutlierEn lengthOutlier = TranslationsIssueDetailsLengthOutlierEn.internal(_root);
	late final TranslationsIssueDetailsStandardEn standard = TranslationsIssueDetailsStandardEn.internal(_root);

	/// en: 'Review'
	String get review => 'Review';

	late final TranslationsIssueDetailsTypesEn types = TranslationsIssueDetailsTypesEn.internal(_root);
	late final TranslationsIssueDetailsNotesEn notes = TranslationsIssueDetailsNotesEn.internal(_root);
	late final TranslationsIssueDetailsFallbacksEn fallbacks = TranslationsIssueDetailsFallbacksEn.internal(_root);
}

// Path: importReview
class TranslationsImportReviewEn {
	TranslationsImportReviewEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Review Project Import'
	String get title => 'Review Project Import';

	/// en: 'Project Name'
	String get projectName => 'Project Name';

	/// en: 'Created'
	String get created => 'Created';

	/// en: 'History Items'
	String get historyItems => 'History Items';

	/// en: 'Custom Settings Detected'
	String get customSettingsTitle => 'Custom Settings Detected';

	/// en: 'This project contains custom settings that will override your defaults while this project is open.'
	String get customSettingsWarning => 'This project contains custom settings that will override your defaults while this project is open.';

	/// en: 'This project uses standard global settings.'
	String get standardSettings => 'This project uses standard global settings.';

	/// en: 'Cancel Import'
	String get cancelImport => 'Cancel Import';

	/// en: 'Trust & Open Project'
	String get trustOpen => 'Trust & Open Project';
}

// Path: historyView
class TranslationsHistoryViewEn {
	TranslationsHistoryViewEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Comparison History'
	String get title => 'Comparison History';

	/// en: 'Clear all history'
	String get clearAll => 'Clear all history';

	/// en: 'Search by file name...'
	String get searchPlaceholder => 'Search by file name...';

	/// en: 'Sort by'
	String get sortBy => 'Sort by';

	/// en: 'Date'
	String get sortDate => 'Date';

	/// en: 'Source File'
	String get sortSource => 'Source File';

	/// en: 'Target File'
	String get sortTarget => 'Target File';

	/// en: 'Showing: Current Project'
	String get showCurrentProject => 'Showing: Current Project';

	/// en: 'Showing: All History'
	String get showAllHistory => 'Showing: All History';

	/// en: 'Group by folder'
	String get groupByFolder => 'Group by folder';

	/// en: 'Disable folder grouping'
	String get disableGrouping => 'Disable folder grouping';

	/// en: 'All'
	String get filterAll => 'All';

	/// en: 'Files'
	String get filterFiles => 'Files';

	/// en: 'Directories'
	String get filterDirectories => 'Directories';

	/// en: 'Git'
	String get filterGit => 'Git';

	/// en: 'No comparison history yet'
	String get noHistory => 'No comparison history yet';

	/// en: 'Your file comparisons will appear here'
	String get historyDescription => 'Your file comparisons will appear here';

	/// en: 'No results found'
	String get noResults => 'No results found';

	/// en: 'Try adjusting your search'
	String get adjustSearch => 'Try adjusting your search';

	/// en: 'Clear All History?'
	String get clearConfirmationTitle => 'Clear All History?';

	/// en: 'This will permanently delete all comparison history. This action cannot be undone.'
	String get clearConfirmationContent => 'This will permanently delete all comparison history. This action cannot be undone.';

	/// en: 'Clear All'
	String get clearAction => 'Clear All';

	/// en: 'History item deleted'
	String get deletedMessage => 'History item deleted';

	/// en: 'Undo'
	String get undo => 'Undo';

	/// en: 'View Details'
	String get viewDetails => 'View Details';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Open file location'
	String get openLocation => 'Open file location';

	/// en: 'Bilingual'
	String get bilingual => 'Bilingual';

	/// en: 'File Pair'
	String get filePair => 'File Pair';

	/// en: 'Directory'
	String get directory => 'Directory';

	/// en: 'Git'
	String get git => 'Git';

	/// en: 'Repo'
	String get repo => 'Repo';

	/// en: 'Source Dir'
	String get sourceDir => 'Source Dir';

	/// en: 'Target Dir'
	String get targetDir => 'Target Dir';

	/// en: 'Source'
	String get source => 'Source';

	/// en: 'Target'
	String get target => 'Target';

	/// en: 'No changes detected'
	String get noChanges => 'No changes detected';

	/// en: 'Added'
	String get added => 'Added';

	/// en: 'Removed'
	String get removed => 'Removed';

	/// en: 'Modified'
	String get modified => 'Modified';

	/// en: 'Same'
	String get same => 'Same';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Current Project'
	String get currentProject => 'Current Project';

	/// en: 'Unassigned'
	String get unassigned => 'Unassigned';

	/// en: 'Project'
	String get project => 'Project';
}

// Path: compare
class TranslationsCompareEn {
	TranslationsCompareEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Compare Files'
	String get title => 'Compare Files';

	/// en: 'Source File'
	String get sourceFile => 'Source File';

	/// en: 'Target File'
	String get targetFile => 'Target File';

	/// en: 'Source Folder'
	String get sourceFolder => 'Source Folder';

	/// en: 'Target Folder'
	String get targetFolder => 'Target Folder';

	/// en: 'Drop localization files here or use the browse buttons to select files for comparison.'
	String get dropFilesHint => 'Drop localization files here or use the browse buttons to select files for comparison.';

	/// en: 'Select source file'
	String get selectSourceFile => 'Select source file';

	/// en: 'Select target file'
	String get selectTargetFile => 'Select target file';

	/// en: 'Start Comparison'
	String get startComparison => 'Start Comparison';

	/// en: 'Comparing...'
	String get comparing => 'Comparing...';

	/// en: 'Comparison complete'
	String get comparisonComplete => 'Comparison complete';

	/// en: 'No changes detected'
	String get noChanges => 'No changes detected';

	/// en: 'Files are identical'
	String get filesIdentical => 'Files are identical';

	/// en: '${count} changes found'
	String changesFound({required Object count}) => '${count} changes found';

	late final TranslationsCompareTabsEn tabs = TranslationsCompareTabsEn.internal(_root);
	late final TranslationsCompareFileTypesEn fileTypes = TranslationsCompareFileTypesEn.internal(_root);
}

// Path: history
class TranslationsHistoryEn {
	TranslationsHistoryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'History'
	String get title => 'History';

	/// en: 'Recent Comparisons'
	String get recentComparisons => 'Recent Comparisons';

	/// en: 'No comparison history yet'
	String get noHistory => 'No comparison history yet';

	/// en: 'Your comparison history will appear here'
	String get noHistoryDescription => 'Your comparison history will appear here';

	/// en: 'Clear History'
	String get clearHistory => 'Clear History';

	/// en: 'Are you sure you want to clear all history?'
	String get clearHistoryConfirm => 'Are you sure you want to clear all history?';

	/// en: 'Delete Entry'
	String get deleteEntry => 'Delete Entry';

	/// en: 'Open Comparison'
	String get openComparison => 'Open Comparison';

	late final TranslationsHistoryTimeAgoEn timeAgo = TranslationsHistoryTimeAgoEn.internal(_root);
}

// Path: projects
class TranslationsProjectsEn {
	TranslationsProjectsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Projects'
	String get title => 'Projects';

	/// en: 'Create Project'
	String get createProject => 'Create Project';

	/// en: 'Import Project'
	String get importProject => 'Import Project';

	/// en: 'No projects yet'
	String get noProjects => 'No projects yet';

	/// en: 'Create a project to organize your localization files'
	String get noProjectsDescription => 'Create a project to organize your localization files';

	/// en: 'Project Name'
	String get projectName => 'Project Name';

	/// en: 'Project Path'
	String get projectPath => 'Project Path';

	/// en: 'Last opened'
	String get lastOpened => 'Last opened';

	/// en: 'Open Project'
	String get openProject => 'Open Project';

	/// en: 'Close Project'
	String get closeProject => 'Close Project';

	/// en: 'Delete Project'
	String get deleteProject => 'Delete Project';

	/// en: 'Are you sure you want to delete this project?'
	String get deleteProjectConfirm => 'Are you sure you want to delete this project?';

	/// en: 'Export Project'
	String get exportProject => 'Export Project';

	/// en: 'Create a portable zip file containing source files, configuration, and history.'
	String get exportDescription => 'Create a portable zip file containing source files, configuration, and history.';

	/// en: 'Exporting project...'
	String get exporting => 'Exporting project...';

	/// en: 'Project exported'
	String get exportSuccess => 'Project exported';

	/// en: 'Export failed: ${error}'
	String exportError({required Object error}) => 'Export failed: ${error}';

	/// en: 'Create New Project'
	String get createNewProject => 'Create New Project';

	/// en: 'Open Existing Project'
	String get openExistingProject => 'Open Existing Project';

	/// en: 'Import Project Zip'
	String get importProjectZip => 'Import Project Zip';

	/// en: 'Project Resources'
	String get projectResources => 'Project Resources';

	/// en: 'Recent Projects'
	String get recentProjects => 'Recent Projects';

	/// en: 'No recent projects'
	String get noRecentProjects => 'No recent projects';

	/// en: 'Select Project Zip'
	String get selectProjectZip => 'Select Project Zip';

	/// en: 'Select Destination Folder for Import'
	String get selectDestination => 'Select Destination Folder for Import';

	/// en: 'Importing project...'
	String get importing => 'Importing project...';

	/// en: 'Project imported successfully'
	String get importSuccess => 'Project imported successfully';

	/// en: 'Import failed: ${error}'
	String importFailed({required Object error}) => 'Import failed: ${error}';

	/// en: 'Importing files...'
	String get importingFiles => 'Importing files...';

	/// en: 'No supported files were dropped.'
	String get noSupportedFiles => 'No supported files were dropped.';

	late final TranslationsProjectsStatsEn stats = TranslationsProjectsStatsEn.internal(_root);

	/// en: 'Open a project first to manage its resources.'
	String get openProjectFirst => 'Open a project first to manage its resources.';

	/// en: 'Remove from recent'
	String get removeFromRecent => 'Remove from recent';

	late final TranslationsProjectsSelectionEn selection = TranslationsProjectsSelectionEn.internal(_root);
	late final TranslationsProjectsCreateDialogEn createDialog = TranslationsProjectsCreateDialogEn.internal(_root);
	late final TranslationsProjectsIndicatorEn indicator = TranslationsProjectsIndicatorEn.internal(_root);
	late final TranslationsProjectsGlossaryEn glossary = TranslationsProjectsGlossaryEn.internal(_root);
	late final TranslationsProjectsConflictsEn conflicts = TranslationsProjectsConflictsEn.internal(_root);
	late final TranslationsProjectsTmEn tm = TranslationsProjectsTmEn.internal(_root);
}

// Path: diff
class TranslationsDiffEn {
	TranslationsDiffEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Added'
	String get added => 'Added';

	/// en: 'Removed'
	String get removed => 'Removed';

	/// en: 'Modified'
	String get modified => 'Modified';

	/// en: 'Unchanged'
	String get unchanged => 'Unchanged';

	/// en: 'Missing'
	String get missing => 'Missing';

	/// en: 'Extra'
	String get extra => 'Extra';

	/// en: 'Source Value'
	String get sourceValue => 'Source Value';

	/// en: 'Target Value'
	String get targetValue => 'Target Value';

	/// en: 'Key'
	String get key => 'Key';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'Actions'
	String get actions => 'Actions';

	/// en: 'Copy to Target'
	String get copyToTarget => 'Copy to Target';

	/// en: 'Accept Change'
	String get acceptChange => 'Accept Change';

	/// en: 'Reject Change'
	String get rejectChange => 'Reject Change';

	/// en: 'View Details'
	String get viewDetails => 'View Details';
}

// Path: git
class TranslationsGitEn {
	TranslationsGitEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Git Comparison'
	String get title => 'Git Comparison';

	/// en: 'Select Repository'
	String get selectRepository => 'Select Repository';

	/// en: 'Select Branch'
	String get selectBranch => 'Select Branch';

	/// en: 'Select Commit'
	String get selectCommit => 'Select Commit';

	/// en: 'Compare Branches'
	String get compareBranches => 'Compare Branches';

	/// en: 'Compare Commits'
	String get compareCommits => 'Compare Commits';

	/// en: 'Base Branch'
	String get baseBranch => 'Base Branch';

	/// en: 'Compare Branch'
	String get compareBranch => 'Compare Branch';

	/// en: 'No Git repositories found'
	String get noRepositories => 'No Git repositories found';

	/// en: 'Open a folder containing a Git repository'
	String get noRepositoriesDescription => 'Open a folder containing a Git repository';

	/// en: '${count} files changed'
	String filesChanged({required Object count}) => '${count} files changed';

	/// en: '${count} additions'
	String additions({required Object count}) => '${count} additions';

	/// en: '${count} deletions'
	String deletions({required Object count}) => '${count} deletions';

	late final TranslationsGitConflictsEn conflicts = TranslationsGitConflictsEn.internal(_root);
}

// Path: quality
class TranslationsQualityEn {
	TranslationsQualityEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.'
	String get _translatorNote => 'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.';

	/// en: 'Quality Dashboard'
	String get title => 'Quality Dashboard';

	/// en: 'Overall Score'
	String get overallScore => 'Overall Score';

	/// en: 'Issues'
	String get issues => 'Issues';

	/// en: 'Warnings'
	String get warnings => 'Warnings';

	/// en: 'Suggestions'
	String get suggestions => 'Suggestions';

	/// en: 'Placeholder Mismatch'
	String get placeholderMismatch => 'Placeholder Mismatch';

	/// en: 'Placeholders like {name} don't match between source and target'
	String get placeholderMismatchDescription => 'Placeholders like {name} don\'t match between source and target';

	/// en: 'Length Outlier'
	String get lengthOutlier => 'Length Outlier';

	/// en: 'Translation length significantly differs from source'
	String get lengthOutlierDescription => 'Translation length significantly differs from source';

	/// en: 'Duplicate Value'
	String get duplicateValue => 'Duplicate Value';

	/// en: 'Same translation used for multiple keys'
	String get duplicateValueDescription => 'Same translation used for multiple keys';

	/// en: 'Missing Translation'
	String get missingTranslation => 'Missing Translation';

	/// en: 'Translation is missing for this key'
	String get missingTranslationDescription => 'Translation is missing for this key';

	/// en: 'Loading dashboard...'
	String get loading => 'Loading dashboard...';

	/// en: 'We could not load your history. Try again.'
	String get errorLoading => 'We could not load your history. Try again.';

	/// en: 'Run a comparison to see your dashboard.'
	String get emptyState => 'Run a comparison to see your dashboard.';

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Building insights...'
	String get buildingInsights => 'Building insights...';

	/// en: 'Crunching the numbers...'
	String get crunchingNumbers => 'Crunching the numbers...';

	/// en: 'We could not build the dashboard. Try again.'
	String get errorBuilding => 'We could not build the dashboard. Try again.';

	/// en: 'No usable data was found yet.'
	String get noUsableData => 'No usable data was found yet.';

	/// en: 'Languages'
	String get languages => 'Languages';

	/// en: 'Average coverage'
	String get averageCoverage => 'Average coverage';

	/// en: 'Potential issues'
	String get potentialIssues => 'Potential issues';

	/// en: 'Translation coverage'
	String get translationCoverage => 'Translation coverage';

	/// en: '${translated} of ${total} entries translated'
	String entriesTranslated({required Object translated, required Object total}) => '${translated} of ${total} entries translated';

	/// en: 'Words added over time'
	String get wordsAddedOverTime => 'Words added over time';

	/// en: 'Completion vs Scope'
	String get completionVsScope => 'Completion vs Scope';

	/// en: 'Scope vs Progress'
	String get scopeVsProgress => 'Scope vs Progress';

	/// en: 'Coverage %'
	String get coveragePercent => 'Coverage %';

	/// en: 'Words Added'
	String get wordsAdded => 'Words Added';

	/// en: 'Words'
	String get words => 'Words';

	/// en: 'Coverage'
	String get coverage => 'Coverage';

	/// en: 'Scope'
	String get scope => 'Scope';

	/// en: 'Latest'
	String get latest => 'Latest';

	/// en: 'Added'
	String get added => 'Added';

	/// en: 'Change'
	String get change => 'Change';

	/// en: 'Total Scope'
	String get totalScope => 'Total Scope';

	/// en: 'Scope Growth'
	String get scopeGrowth => 'Scope Growth';

	/// en: 'Range'
	String get range => 'Range';

	/// en: 'AI & Translation Usage'
	String get aiUsage => 'AI & Translation Usage';

	/// en: 'Last used ${date}'
	String lastUsed({required Object date}) => 'Last used ${date}';

	/// en: 'No issues found in the latest comparisons.'
	String get noIssuesFound => 'No issues found in the latest comparisons.';

	/// en: 'Placeholder mismatches'
	String get placeholderMismatches => 'Placeholder mismatches';

	/// en: 'Markers like {name} do not match.'
	String get placeholderMismatchesDesc => 'Markers like {name} do not match.';

	/// en: 'Very short or long translations'
	String get lengthOutliers => 'Very short or long translations';

	/// en: 'Length looks unusual compared to the source.'
	String get lengthOutliersDesc => 'Length looks unusual compared to the source.';

	/// en: 'Duplicate values'
	String get duplicateValues => 'Duplicate values';

	/// en: 'The same translation is used many times.'
	String get duplicateValuesDesc => 'The same translation is used many times.';

	/// en: 'Placeholder Mismatches'
	String get placeholderDialogTitle => 'Placeholder Mismatches';

	/// en: 'These translations have different placeholders ({name}) than the source.'
	String get placeholderDialogDesc => 'These translations have different placeholders ({name}) than the source.';

	/// en: 'Length Outliers'
	String get lengthDialogTitle => 'Length Outliers';

	/// en: 'These translations are significantly shorter or longer than the source.'
	String get lengthDialogDesc => 'These translations are significantly shorter or longer than the source.';

	/// en: 'Duplicate Values'
	String get duplicateDialogTitle => 'Duplicate Values';

	/// en: 'These translations appear multiple times.'
	String get duplicateDialogDesc => 'These translations appear multiple times.';

	/// en: 'Duplicate: "${value}"'
	String duplicateSample({required Object value}) => 'Duplicate: "${value}"';

	/// en: 'Could not build the report. Please try again.'
	String get exportError => 'Could not build the report. Please try again.';

	/// en: 'No data to export'
	String get noDataToExport => 'No data to export';

	/// en: 'Export failed'
	String get exportFailed => 'Export failed';

	/// en: 'Export Quality Report'
	String get exportDialogTitle => 'Export Quality Report';

	/// en: 'Report saved'
	String get reportSaved => 'Report saved';

	/// en: 'Export'
	String get export => 'Export';

	/// en: 'Requests'
	String get requests => 'Requests';

	/// en: 'Tokens'
	String get tokens => 'Tokens';

	/// en: 'Characters'
	String get characters => 'Characters';

	/// en: 'Est. Cost'
	String get estCost => 'Est. Cost';

	/// en: 'Prompt'
	String get prompt => 'Prompt';

	/// en: 'Completion'
	String get completion => 'Completion';

	/// en: 'Showing: Current Project'
	String get showingCurrentProject => 'Showing: Current Project';

	/// en: 'Showing: All History'
	String get showingAllHistory => 'Showing: All History';

	/// en: 'Some files were skipped because they were not found.'
	String get filesSkipped => 'Some files were skipped because they were not found.';
}

// Path: errors
class TranslationsErrorsEn {
	TranslationsErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'An error occurred'
	String get genericError => 'An error occurred';

	/// en: 'File not found'
	String get fileNotFound => 'File not found';

	/// en: 'Invalid file format'
	String get invalidFormat => 'Invalid file format';

	/// en: 'Failed to parse file'
	String get parseError => 'Failed to parse file';

	/// en: 'Network error. Please check your connection.'
	String get networkError => 'Network error. Please check your connection.';

	/// en: 'Permission denied'
	String get permissionDenied => 'Permission denied';

	/// en: 'An unknown error occurred'
	String get unknownError => 'An unknown error occurred';
}

// Path: wizards
class TranslationsWizardsEn {
	TranslationsWizardsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsWizardsFirstRunEn firstRun = TranslationsWizardsFirstRunEn.internal(_root);
}

// Path: dialogs
class TranslationsDialogsEn {
	TranslationsDialogsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsDialogsAddIgnorePatternEn addIgnorePattern = TranslationsDialogsAddIgnorePatternEn.internal(_root);
	late final TranslationsDialogsDiffViewerEn diffViewer = TranslationsDialogsDiffViewerEn.internal(_root);
}

// Path: grid
class TranslationsGridEn {
	TranslationsGridEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsGridColumnsEn columns = TranslationsGridColumnsEn.internal(_root);
}

// Path: tutorial
class TranslationsTutorialEn {
	TranslationsTutorialEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SKIP TUTORIAL'
	String get skipTutorial => 'SKIP TUTORIAL';

	/// en: 'You're all set! Tap anywhere to finish.'
	String get finishMessage => 'You\'re all set! Tap anywhere to finish.';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Load Sample Data'
	String get loadSampleData => 'Load Sample Data';

	/// en: 'Browse Source File'
	String get browseSourceFile => 'Browse Source File';

	/// en: 'Browse Target File'
	String get browseTargetFile => 'Browse Target File';

	/// en: 'Compare Files'
	String get compareFiles => 'Compare Files';

	/// en: 'Next: filters, search, advanced view, and export.'
	String get hintPhase2 => 'Next: filters, search, advanced view, and export.';

	late final TranslationsTutorialStepsEn steps = TranslationsTutorialStepsEn.internal(_root);
}

// Path: friendlyErrors
class TranslationsFriendlyErrorsEn {
	TranslationsFriendlyErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsFriendlyErrorsFileNotFoundEn fileNotFound = TranslationsFriendlyErrorsFileNotFoundEn.internal(_root);
	late final TranslationsFriendlyErrorsAccessDeniedEn accessDenied = TranslationsFriendlyErrorsAccessDeniedEn.internal(_root);
	late final TranslationsFriendlyErrorsIsDirectoryEn isDirectory = TranslationsFriendlyErrorsIsDirectoryEn.internal(_root);
	late final TranslationsFriendlyErrorsFileAccessEn fileAccess = TranslationsFriendlyErrorsFileAccessEn.internal(_root);
	late final TranslationsFriendlyErrorsUnsupportedFormatEn unsupportedFormat = TranslationsFriendlyErrorsUnsupportedFormatEn.internal(_root);
	late final TranslationsFriendlyErrorsNetworkErrorEn networkError = TranslationsFriendlyErrorsNetworkErrorEn.internal(_root);
	late final TranslationsFriendlyErrorsNotGitRepoEn notGitRepo = TranslationsFriendlyErrorsNotGitRepoEn.internal(_root);
	late final TranslationsFriendlyErrorsMergeConflictEn mergeConflict = TranslationsFriendlyErrorsMergeConflictEn.internal(_root);
	late final TranslationsFriendlyErrorsGitAuthFailedEn gitAuthFailed = TranslationsFriendlyErrorsGitAuthFailedEn.internal(_root);
	late final TranslationsFriendlyErrorsGitOperationFailedEn gitOperationFailed = TranslationsFriendlyErrorsGitOperationFailedEn.internal(_root);
	late final TranslationsFriendlyErrorsInvalidJsonEn invalidJson = TranslationsFriendlyErrorsInvalidJsonEn.internal(_root);
	late final TranslationsFriendlyErrorsRateLimitReachedEn rateLimitReached = TranslationsFriendlyErrorsRateLimitReachedEn.internal(_root);
	late final TranslationsFriendlyErrorsInvalidApiKeyEn invalidApiKey = TranslationsFriendlyErrorsInvalidApiKeyEn.internal(_root);
	late final TranslationsFriendlyErrorsTranslationServiceErrorEn translationServiceError = TranslationsFriendlyErrorsTranslationServiceErrorEn.internal(_root);
	late final TranslationsFriendlyErrorsOutOfMemoryEn outOfMemory = TranslationsFriendlyErrorsOutOfMemoryEn.internal(_root);
	late final TranslationsFriendlyErrorsGenericErrorEn genericError = TranslationsFriendlyErrorsGenericErrorEn.internal(_root);
}

// Path: systemTray
class TranslationsSystemTrayEn {
	TranslationsSystemTrayEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Show Localizer'
	String get showLocalizer => 'Show Localizer';

	/// en: 'Exit'
	String get exit => 'Exit';
}

// Path: validation
class TranslationsValidationEn {
	TranslationsValidationEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connected.'
	String get connected => 'Connected.';

	/// en: 'Connection timed out. Please try again.'
	String get connectionTimeout => 'Connection timed out. Please try again.';

	/// en: 'Could not connect. Please try again.'
	String get couldNotConnect => 'Could not connect. Please try again.';

	/// en: 'Could not connect. Please check the key and try again.'
	String get checkKeyAndTryAgain => 'Could not connect. Please check the key and try again.';

	/// en: 'Could not connect right now. Please try again later.'
	String get tryAgainLater => 'Could not connect right now. Please try again later.';

	/// en: 'Service is unavailable right now. Please try again later.'
	String get serviceUnavailable => 'Service is unavailable right now. Please try again later.';

	/// en: 'Please enter a key first.'
	String get enterKeyFirst => 'Please enter a key first.';

	/// en: 'Checking...'
	String get checking => 'Checking...';

	/// en: 'Usage: ${used} / ${limit} characters.'
	String deeplUsage({required Object used, required Object limit}) => 'Usage: ${used} / ${limit} characters.';
}

// Path: status
class TranslationsStatusEn {
	TranslationsStatusEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Starting comparison...'
	String get startingComparison => 'Starting comparison...';

	/// en: 'Loading files from history...'
	String get loadingFromHistory => 'Loading files from history...';

	/// en: 'Comparison complete'
	String get comparisonComplete => 'Comparison complete';

	/// en: 'Could not import the files. Please try again.'
	String get couldNotImportFiles => 'Could not import the files. Please try again.';

	/// en: 'One or both files from history not found at original paths.'
	String get historyFilesNotFound => 'One or both files from history not found at original paths.';
}

// Path: aiServices
class TranslationsAiServicesEn {
	TranslationsAiServicesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Gemini returned empty response'
	String get geminiEmptyResponse => 'Gemini returned empty response';

	/// en: 'Gemini streaming returned empty response'
	String get geminiStreamingEmpty => 'Gemini streaming returned empty response';

	/// en: 'Gemini returned empty response for rephrase'
	String get geminiRephraseEmpty => 'Gemini returned empty response for rephrase';

	/// en: 'OpenAI returned empty or failed response'
	String get openaiEmptyResponse => 'OpenAI returned empty or failed response';
}

// Path: settings.appearance
class TranslationsSettingsAppearanceEn {
	TranslationsSettingsAppearanceEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Appearance'
	String get title => 'Appearance';

	/// en: 'Customize the look and feel of the app'
	String get description => 'Customize the look and feel of the app';

	/// en: 'Theme Mode'
	String get theme => 'Theme Mode';

	/// en: 'Choose between light, dark, or system theme'
	String get themeDescription => 'Choose between light, dark, or system theme';

	/// en: 'System'
	String get themeSystem => 'System';

	/// en: 'Light'
	String get themeLight => 'Light';

	/// en: 'Dark'
	String get themeDark => 'Dark';

	/// en: 'AMOLED'
	String get themeAmoled => 'AMOLED';

	/// en: 'Accent Color'
	String get accentColor => 'Accent Color';

	/// en: 'Choose your preferred accent color'
	String get accentColorDescription => 'Choose your preferred accent color';

	/// en: 'Use Mica Effect'
	String get useMicaEffect => 'Use Mica Effect';

	/// en: 'Enable Windows 11 Mica transparency effect for a modern look'
	String get micaDescription => 'Enable Windows 11 Mica transparency effect for a modern look';

	/// en: 'Diff Font Size'
	String get diffFontSize => 'Diff Font Size';

	/// en: 'Adjust the font size of the comparison view'
	String get diffFontSizeDescription => 'Adjust the font size of the comparison view';

	/// en: 'Diff Font Family'
	String get diffFontFamily => 'Diff Font Family';

	/// en: 'Font for comparison view'
	String get diffFontFamilyDescription => 'Font for comparison view';

	/// en: 'System Default'
	String get systemDefault => 'System Default';

	/// en: 'Pick Accent Color'
	String get pickAccentColor => 'Pick Accent Color';

	/// en: 'Diff Colors'
	String get diffColors => 'Diff Colors';

	/// en: 'Presets'
	String get presetsTitle => 'Presets';

	late final TranslationsSettingsAppearancePresetsEn presets = TranslationsSettingsAppearancePresetsEn.internal(_root);

	/// en: 'Identical'
	String get identical => 'Identical';

	/// en: 'Pick Color for ${label}'
	String pickColorFor({required Object label}) => 'Pick Color for ${label}';

	/// en: 'Live Preview'
	String get livePreview => 'Live Preview';

	late final TranslationsSettingsAppearancePreviewEn preview = TranslationsSettingsAppearancePreviewEn.internal(_root);
}

// Path: settings.general
class TranslationsSettingsGeneralEn {
	TranslationsSettingsGeneralEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'General'
	String get title => 'General';

	/// en: 'General application settings'
	String get description => 'General application settings';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Choose your preferred language'
	String get languageDescription => 'Choose your preferred language';

	/// en: 'Start Minimized to Tray'
	String get startMinimized => 'Start Minimized to Tray';

	/// en: 'Start the app minimized to the system tray'
	String get startMinimizedDescription => 'Start the app minimized to the system tray';

	/// en: 'Remember Window Position'
	String get rememberWindowPosition => 'Remember Window Position';

	/// en: 'Restore window size and position on startup'
	String get rememberWindowPositionDescription => 'Restore window size and position on startup';

	/// en: 'Open Last Project on Startup'
	String get openLastProject => 'Open Last Project on Startup';

	/// en: 'Automatically open the last used project when the app starts'
	String get openLastProjectDescription => 'Automatically open the last used project when the app starts';

	/// en: 'Application'
	String get application => 'Application';

	/// en: 'Default View'
	String get defaultView => 'Default View';

	/// en: 'View to show on startup'
	String get defaultViewDescription => 'View to show on startup';

	/// en: 'Auto-Check Updates'
	String get autoCheckUpdates => 'Auto-Check Updates';

	/// en: 'Check for updates on startup'
	String get autoCheckUpdatesDescription => 'Check for updates on startup';

	/// en: 'Startup Options'
	String get startupOptions => 'Startup Options';

	/// en: 'Auto-Detect'
	String get languageAuto => 'Auto-Detect';

	/// en: 'File Comparison'
	String get viewBasic => 'File Comparison';

	/// en: 'History'
	String get viewHistory => 'History';

	/// en: 'Quality Dashboard'
	String get viewDashboard => 'Quality Dashboard';

	/// en: 'Directory Comparison'
	String get viewDirectory => 'Directory Comparison';

	/// en: 'Last Used View'
	String get viewLastUsed => 'Last Used View';
}

// Path: settings.scope
class TranslationsSettingsScopeEn {
	TranslationsSettingsScopeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings Scope'
	String get title => 'Settings Scope';

	/// en: 'Global Defaults'
	String get global => 'Global Defaults';

	/// en: 'Project'
	String get project => 'Project';

	/// en: 'Reset Project to Global Defaults'
	String get reset => 'Reset Project to Global Defaults';

	/// en: 'This will clear all overrides for this project and revert to global defaults. This action cannot be undone.'
	String get resetConfirmation => 'This will clear all overrides for this project and revert to global defaults. This action cannot be undone.';

	/// en: 'Changes apply to all projects unless overridden.'
	String get globalDescription => 'Changes apply to all projects unless overridden.';

	/// en: 'Changes apply only to "${name}". Other settings inherit from global defaults.'
	String projectDescription({required Object name}) => 'Changes apply only to "${name}". Other settings inherit from global defaults.';

	/// en: 'Create a project to customize settings for specific folders'
	String get createPrompt => 'Create a project to customize settings for specific folders';
}

// Path: settings.searchKeywords
class TranslationsSettingsSearchKeywordsEn {
	TranslationsSettingsSearchKeywordsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	List<String> get general => [
		'Language',
		'Default View',
		'Recent Files Count',
		'Open Last Project',
		'Confirm Before Exit',
		'Show Notifications',
	];
	List<String> get comparisonEngine => [
		'Comparison Mode',
		'Similarity Threshold',
		'Case Sensitive',
		'Ignore Whitespace',
		'Ignore Empty Lines',
		'Ignore Comments',
		'Ignore Patterns',
	];
	List<String> get appearance => [
		'Theme',
		'Theme Mode',
		'Accent Color',
		'Diff Font Size',
		'Diff Font Family',
		'Diff Colors',
		'Added Color',
		'Removed Color',
		'Modified Color',
		'Identical Color',
		'Color Presets',
		'Preview',
	];
	List<String> get fileHandling => [
		'Source Format',
		'Target Format',
		'Default Encoding',
		'Recent Project Count',
		'Translation Memory',
		'Import Memory',
		'Export Memory',
		'Clear Memory',
	];
	List<String> get aiServices => [
		'OpenAI API Key',
		'Anthropic API Key',
		'Google AI API Key',
		'AI Model',
		'Temperature',
		'Custom Prompt',
	];
	List<String> get systemIntegrations => [
		'System Tray',
		'Start Minimized',
		'File Associations',
		'Mica Effect',
		'Vibrancy',
		'Window Material',
		'Dock Badge',
		'Untranslated Count',
	];
	List<String> get projectResources => [
		'Glossary',
		'Translation Memory',
		'Terminology',
	];
	List<String> get about => [
		'Version',
		'Check Updates',
		'Auto Update',
		'Changelog',
		'License',
		'Privacy Policy',
		'Telemetry',
		'Crash Reporting',
	];
	List<String> get developer => [
		'Performance Overlay',
		'Semantics Debugger',
		'Material Grid',
		'Raster Cache',
		'Restart Tutorial',
		'Factory Reset',
	];
}

// Path: settings.comparison
class TranslationsSettingsComparisonEn {
	TranslationsSettingsComparisonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Comparison'
	String get title => 'Comparison';

	/// en: 'Configure comparison behavior'
	String get description => 'Configure comparison behavior';

	/// en: 'Case Sensitive'
	String get caseSensitive => 'Case Sensitive';

	/// en: 'Treat uppercase and lowercase letters as different'
	String get caseSensitiveDescription => 'Treat uppercase and lowercase letters as different';

	/// en: 'Ignore Whitespace'
	String get ignoreWhitespace => 'Ignore Whitespace';

	/// en: 'Ignore leading/trailing whitespace when comparing'
	String get ignoreWhitespaceDescription => 'Ignore leading/trailing whitespace when comparing';

	/// en: 'Show Line Numbers'
	String get showLineNumbers => 'Show Line Numbers';

	/// en: 'Display line numbers in the diff view'
	String get showLineNumbersDescription => 'Display line numbers in the diff view';

	/// en: 'Comparison Behavior'
	String get behavior => 'Comparison Behavior';

	/// en: 'Ignore Case'
	String get ignoreCase => 'Ignore Case';

	/// en: 'Treat "Key" and "key" as the same'
	String get ignoreCaseDescription => 'Treat "Key" and "key" as the same';

	/// en: 'Similarity Threshold'
	String get similarityThreshold => 'Similarity Threshold';

	/// en: 'Minimum similarity for "Modified" detection'
	String get similarityThresholdDescription => 'Minimum similarity for "Modified" detection';

	/// en: 'Comparison Mode'
	String get mode => 'Comparison Mode';

	/// en: 'How to match entries between files'
	String get modeDescription => 'How to match entries between files';

	/// en: 'Key-based'
	String get modeKey => 'Key-based';

	/// en: 'Matches by key name (default).'
	String get modeKeyDescription => 'Matches by key name (default).';

	/// en: 'Order-based'
	String get modeOrder => 'Order-based';

	/// en: 'Matches by position in file.'
	String get modeOrderDescription => 'Matches by position in file.';

	/// en: 'Smart Match'
	String get modeSmart => 'Smart Match';

	/// en: 'Detects moved/renamed keys.'
	String get modeSmartDescription => 'Detects moved/renamed keys.';

	/// en: 'Ignore Patterns'
	String get ignorePatterns => 'Ignore Patterns';

	/// en: 'No ignore patterns set.'
	String get noIgnorePatterns => 'No ignore patterns set.';

	/// en: 'Add Pattern'
	String get addPattern => 'Add Pattern';

	/// en: 'Reset all comparison settings to global defaults'
	String get resetToGlobal => 'Reset all comparison settings to global defaults';

	late final TranslationsSettingsComparisonPatternPresetsEn patternPresets = TranslationsSettingsComparisonPatternPresetsEn.internal(_root);
	late final TranslationsSettingsComparisonPreviewMatchEn previewMatch = TranslationsSettingsComparisonPreviewMatchEn.internal(_root);
	late final TranslationsSettingsComparisonColorPresetsEn colorPresets = TranslationsSettingsComparisonColorPresetsEn.internal(_root);
}

// Path: settings.fileHandling
class TranslationsSettingsFileHandlingEn {
	TranslationsSettingsFileHandlingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'File Formats'
	String get fileFormats => 'File Formats';

	/// en: 'Source Format'
	String get sourceFormat => 'Source Format';

	/// en: 'Target Format'
	String get targetFormat => 'Target Format';

	/// en: 'Encoding'
	String get encoding => 'Encoding';

	/// en: 'Source Encoding'
	String get sourceEncoding => 'Source Encoding';

	/// en: 'Target Encoding'
	String get targetEncoding => 'Target Encoding';

	/// en: 'Auto-Detect'
	String get autoDetect => 'Auto-Detect';

	/// en: 'Automatically detect file encoding'
	String get autoDetectEncodingDescription => 'Automatically detect file encoding';

	/// en: 'Export Settings'
	String get exportSettings => 'Export Settings';

	/// en: 'Default Export Format'
	String get defaultExportFormat => 'Default Export Format';

	/// en: 'Include UTF-8 BOM'
	String get includeUtf8Bom => 'Include UTF-8 BOM';

	/// en: 'Required for Excel compatibility'
	String get includeUtf8BomDescription => 'Required for Excel compatibility';

	/// en: 'Open Folder After Export'
	String get openFolderAfterExport => 'Open Folder After Export';

	/// en: 'File Safety'
	String get fileSafety => 'File Safety';

	/// en: 'Automatic local copies for disaster recovery.'
	String get fileSafetyDescription => 'Automatic local copies for disaster recovery.';

	/// en: 'Reset all file handling settings to global defaults'
	String get resetToGlobal => 'Reset all file handling settings to global defaults';
}

// Path: settings.translationMemory
class TranslationsSettingsTranslationMemoryEn {
	TranslationsSettingsTranslationMemoryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Global Translation Memory'
	String get title => 'Global Translation Memory';

	/// en: 'Auto-learn'
	String get autoLearn => 'Auto-learn';

	/// en: 'Save translations to local memory for future reuse'
	String get autoLearnDescription => 'Save translations to local memory for future reuse';

	/// en: 'Confidence Threshold'
	String get confidenceThreshold => 'Confidence Threshold';

	/// en: 'Minimum score to auto-apply (${percent}%)'
	String confidenceThresholdDescription({required Object percent}) => 'Minimum score to auto-apply (${percent}%)';

	/// en: 'Entries'
	String get entries => 'Entries';

	/// en: 'Size'
	String get size => 'Size';

	/// en: 'Memory Size: ${size}'
	String memorySize({required Object size}) => 'Memory Size: ${size}';

	/// en: 'Import'
	String get import => 'Import';

	/// en: 'Export TMX'
	String get exportTmx => 'Export TMX';

	/// en: 'Export CSV'
	String get exportCsv => 'Export CSV';

	/// en: 'Clear Memory'
	String get clearMemory => 'Clear Memory';

	/// en: 'Imported ${count} items into memory.'
	String importedItems({required Object count}) => 'Imported ${count} items into memory.';

	/// en: 'No items were added.'
	String get noItemsAdded => 'No items were added.';

	/// en: 'Nothing to export yet.'
	String get nothingToExport => 'Nothing to export yet.';

	/// en: 'TMX saved'
	String get tmxSaved => 'TMX saved';

	/// en: 'CSV saved'
	String get csvSaved => 'CSV saved';

	/// en: 'Clear translation memory?'
	String get clearConfirmTitle => 'Clear translation memory?';

	/// en: 'This removes all saved translation pairs on this device. This action cannot be undone.'
	String get clearConfirmContent => 'This removes all saved translation pairs on this device. This action cannot be undone.';

	/// en: 'Translation memory cleared.'
	String get cleared => 'Translation memory cleared.';

	/// en: 'Could not clear memory.'
	String get couldNotClear => 'Could not clear memory.';
}

// Path: settings.backup
class TranslationsSettingsBackupEn {
	TranslationsSettingsBackupEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Auto-Backup'
	String get title => 'Auto-Backup';

	/// en: 'Automatic backup settings'
	String get description => 'Automatic backup settings';

	/// en: 'Enable Auto-Backup'
	String get enabled => 'Enable Auto-Backup';

	/// en: 'Automatically backup files before making changes'
	String get enabledDescription => 'Automatically backup files before making changes';

	/// en: 'Maximum Backup Copies'
	String get maxCopies => 'Maximum Backup Copies';

	/// en: 'Number of backup copies to keep per file'
	String get maxCopiesDescription => 'Number of backup copies to keep per file';

	/// en: 'Active · Keeping ${count} copies'
	String activeStatus({required Object count}) => 'Active · Keeping ${count} copies';

	/// en: 'Backup Folder'
	String get folder => 'Backup Folder';

	/// en: 'Leave empty to use the same folder'
	String get folderDescription => 'Leave empty to use the same folder';

	/// en: 'Use original file folder'
	String get useOriginalFolder => 'Use original file folder';
}

// Path: settings.ai
class TranslationsSettingsAiEn {
	TranslationsSettingsAiEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'AI Services'
	String get title => 'AI Services';

	/// en: 'Configure AI translation and assistance'
	String get description => 'Configure AI translation and assistance';

	/// en: 'AI Provider'
	String get provider => 'AI Provider';

	/// en: 'Choose your preferred AI service provider'
	String get providerDescription => 'Choose your preferred AI service provider';

	/// en: 'API Key'
	String get apiKey => 'API Key';

	/// en: 'Enter your API key for the selected provider'
	String get apiKeyDescription => 'Enter your API key for the selected provider';

	/// en: 'Enter API key...'
	String get apiKeyPlaceholder => 'Enter API key...';

	/// en: 'Test Connection'
	String get testConnection => 'Test Connection';

	/// en: 'Connection successful!'
	String get connectionSuccess => 'Connection successful!';

	/// en: 'Connection failed. Please check your API key.'
	String get connectionFailed => 'Connection failed. Please check your API key.';

	/// en: 'Translation Strategy'
	String get translationStrategy => 'Translation Strategy';

	/// en: 'Strategy'
	String get strategy => 'Strategy';

	/// en: 'Select how you want to translate strings'
	String get strategyDescription => 'Select how you want to translate strings';

	/// en: 'Generative AI (LLM)'
	String get strategyLLM => 'Generative AI (LLM)';

	/// en: 'Cloud Translation'
	String get strategyCloud => 'Cloud Translation';

	/// en: 'Enable AI Translation'
	String get enableAiTranslation => 'Enable AI Translation';

	/// en: 'Allow the app to use AI for translation suggestions'
	String get enableAiTranslationDescription => 'Allow the app to use AI for translation suggestions';

	/// en: 'LLM Service Provider'
	String get llmProvider => 'LLM Service Provider';

	/// en: 'Service'
	String get service => 'Service';

	/// en: 'Provider for Generative AI'
	String get serviceDescription => 'Provider for Generative AI';

	/// en: 'Google Gemini'
	String get providerGemini => 'Google Gemini';

	/// en: 'OpenAI'
	String get providerOpenAI => 'OpenAI';

	/// en: 'Gemini API Key'
	String get geminiApiKey => 'Gemini API Key';

	/// en: 'OpenAI API Key'
	String get openAiApiKey => 'OpenAI API Key';

	/// en: 'Model'
	String get model => 'Model';

	/// en: 'Select which model to use'
	String get modelDescription => 'Select which model to use';

	/// en: 'Advanced Parameters'
	String get advancedParameters => 'Advanced Parameters';

	/// en: 'Parameters'
	String get parameters => 'Parameters';

	/// en: 'Temperature, Context, and more'
	String get parametersDescription => 'Temperature, Context, and more';

	/// en: 'Temperature'
	String get temperature => 'Temperature';

	/// en: 'Higher values make output more creative'
	String get temperatureDescription => 'Higher values make output more creative';

	/// en: 'Max Tokens'
	String get maxTokens => 'Max Tokens';

	/// en: 'Limit context window length'
	String get maxTokensDescription => 'Limit context window length';

	/// en: 'System Context / Instructions'
	String get systemContext => 'System Context / Instructions';

	/// en: 'You are a professional localizer. Maintain the tone and intent of the source string...'
	String get systemContextHint => 'You are a professional localizer. Maintain the tone and intent of the source string...';

	/// en: 'Provide specific instructions to the AI about your project's style and terminology.'
	String get systemContextHelper => 'Provide specific instructions to the AI about your project\'s style and terminology.';

	/// en: 'Context Strings'
	String get contextStrings => 'Context Strings';

	/// en: 'Include surrounding strings for better context'
	String get contextStringsDescription => 'Include surrounding strings for better context';

	/// en: 'Context Count'
	String get contextCount => 'Context Count';

	/// en: 'Number of surrounding strings to include'
	String get contextCountDescription => 'Number of surrounding strings to include';

	/// en: 'Cloud Translation Services'
	String get cloudServices => 'Cloud Translation Services';

	/// en: 'Google Translate API Key'
	String get googleTranslateApiKey => 'Google Translate API Key';

	/// en: 'DeepL API Key'
	String get deeplApiKey => 'DeepL API Key';

	/// en: 'Test'
	String get test => 'Test';

	/// en: 'Reset all AI settings to global defaults'
	String get resetToGlobal => 'Reset all AI settings to global defaults';
}

// Path: settings.integrations
class TranslationsSettingsIntegrationsEn {
	TranslationsSettingsIntegrationsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Platform Notice'
	String get platformNotice => 'Platform Notice';

	/// en: 'System integrations are not available for this platform.'
	String get platformNoticeDescription => 'System integrations are not available for this platform.';

	/// en: 'Visual Effects'
	String get visualEffects => 'Visual Effects';

	/// en: 'Explorer Integration'
	String get explorerIntegration => 'Explorer Integration';

	/// en: 'Add "Open with Localizer" to the Windows Explorer right-click menu for folders.'
	String get explorerIntegrationDescription => 'Add "Open with Localizer" to the Windows Explorer right-click menu for folders.';

	/// en: 'Add to Context Menu'
	String get addToContextMenu => 'Add to Context Menu';

	/// en: 'Context menu added!'
	String get contextMenuAdded => 'Context menu added!';

	/// en: 'Failed to add context menu'
	String get contextMenuAddError => 'Failed to add context menu';

	/// en: 'Context menu removed!'
	String get contextMenuRemoved => 'Context menu removed!';

	/// en: 'Failed to remove context menu'
	String get contextMenuRemoveError => 'Failed to remove context menu';

	/// en: 'File Associations'
	String get fileAssociations => 'File Associations';

	/// en: 'Register file types to open with Localizer when double-clicked in Explorer.'
	String get fileAssociationsDescription => 'Register file types to open with Localizer when double-clicked in Explorer.';

	/// en: 'Registered'
	String get registered => 'Registered';

	/// en: 'Not Registered'
	String get notRegistered => 'Not Registered';

	/// en: '${ext} registered!'
	String extRegistered({required Object ext}) => '${ext} registered!';

	/// en: '${ext} unregistered!'
	String extUnregistered({required Object ext}) => '${ext} unregistered!';

	/// en: 'Failed to ${action} ${ext}'
	String extError({required Object action, required Object ext}) => 'Failed to ${action} ${ext}';

	/// en: 'Register All'
	String get registerAll => 'Register All';

	/// en: 'Unregister All'
	String get unregisterAll => 'Unregister All';

	/// en: 'Registered ${success} of ${total} file types'
	String registerAllResult({required Object success, required Object total}) => 'Registered ${success} of ${total} file types';

	/// en: 'Unregistered ${success} of ${total} file types'
	String unregisterAllResult({required Object success, required Object total}) => 'Unregistered ${success} of ${total} file types';

	/// en: 'Protocol Handler'
	String get protocolHandler => 'Protocol Handler';

	/// en: 'Register localizer:// URLs to open this application. Allows opening projects directly from browser links or other apps.'
	String get protocolHandlerDescription => 'Register localizer:// URLs to open this application. Allows opening projects directly from browser links or other apps.';

	/// en: 'Protocol handler is registered'
	String get protocolRegistered => 'Protocol handler is registered';

	/// en: 'Protocol handler not registered'
	String get protocolNotRegistered => 'Protocol handler not registered';

	/// en: 'Register Protocol'
	String get registerProtocol => 'Register Protocol';

	/// en: 'Unregister'
	String get unregister => 'Unregister';

	/// en: 'Protocol handler registered!'
	String get protocolRegisteredSuccess => 'Protocol handler registered!';

	/// en: 'Protocol handler removed!'
	String get protocolRemovedSuccess => 'Protocol handler removed!';

	/// en: 'Failed to register'
	String get protocolRegisterError => 'Failed to register';

	/// en: 'Failed to remove'
	String get protocolRemoveError => 'Failed to remove';

	/// en: 'Window Material'
	String get windowMaterial => 'Window Material';

	/// en: 'Select the macOS vibrancy material style'
	String get windowMaterialDescription => 'Select the macOS vibrancy material style';

	/// en: 'Dock Integration'
	String get dockIntegration => 'Dock Integration';

	/// en: 'Show Untranslated Count'
	String get showDockBadge => 'Show Untranslated Count';

	/// en: 'Display untranslated string count on the dock icon badge'
	String get showDockBadgeDescription => 'Display untranslated string count on the dock icon badge';

	late final TranslationsSettingsIntegrationsMaterialsEn materials = TranslationsSettingsIntegrationsMaterialsEn.internal(_root);
	late final TranslationsSettingsIntegrationsFileTypesEn fileTypes = TranslationsSettingsIntegrationsFileTypesEn.internal(_root);
}

// Path: settings.developer
class TranslationsSettingsDeveloperEn {
	TranslationsSettingsDeveloperEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Developer Settings'
	String get title => 'Developer Settings';

	/// en: 'Advanced settings for developers'
	String get description => 'Advanced settings for developers';

	/// en: 'Show Localization Keys'
	String get showLocalizationKeys => 'Show Localization Keys';

	/// en: 'When enabled, all translated text will show their localization keys instead of the translated value. Useful for verifying which key is used where.'
	String get localizationKeysDescription => 'When enabled, all translated text will show their localization keys instead of the translated value. Useful for verifying which key is used where.';

	/// en: 'Show Performance Overlay'
	String get showPerformanceOverlay => 'Show Performance Overlay';

	/// en: 'Display FPS and frame timing information'
	String get performanceOverlayDescription => 'Display FPS and frame timing information';

	/// en: 'Debug Mode'
	String get debugMode => 'Debug Mode';

	/// en: 'Enable additional logging and debug features'
	String get debugModeDescription => 'Enable additional logging and debug features';

	/// en: 'Debugging Tools'
	String get debuggingTools => 'Debugging Tools';

	/// en: 'Semantics Debugger'
	String get semanticsDebugger => 'Semantics Debugger';

	/// en: 'Visualize semantics tree'
	String get semanticsDebuggerDescription => 'Visualize semantics tree';

	/// en: 'Material Grid'
	String get materialGrid => 'Material Grid';

	/// en: 'Overlay material layout grid'
	String get materialGridDescription => 'Overlay material layout grid';

	/// en: 'Raster Cache Images'
	String get rasterCache => 'Raster Cache Images';

	/// en: 'Checkerboard raster cache images'
	String get rasterCacheDescription => 'Checkerboard raster cache images';

	/// en: 'Actions'
	String get actions => 'Actions';

	/// en: 'Show App Logs'
	String get showLogs => 'Show App Logs';

	/// en: 'Open Talker debug console'
	String get showLogsDescription => 'Open Talker debug console';

	/// en: 'Restart Onboarding Tutorial'
	String get restartTutorial => 'Restart Onboarding Tutorial';

	/// en: 'Reset flags and launch tutorial again'
	String get restartTutorialDescription => 'Reset flags and launch tutorial again';

	/// en: 'Tutorial restart requested.'
	String get restartRequested => 'Tutorial restart requested.';

	/// en: 'Throw Test Exception'
	String get throwException => 'Throw Test Exception';

	/// en: 'Trigger a test exception for crash reporting'
	String get throwExceptionDescription => 'Trigger a test exception for crash reporting';

	/// en: 'Test Exception triggered from Developer Options'
	String get testExceptionMessage => 'Test Exception triggered from Developer Options';

	/// en: 'Clear Translation Memory'
	String get clearTM => 'Clear Translation Memory';

	/// en: 'Delete all cached translations'
	String get clearTMDescription => 'Delete all cached translations';

	/// en: 'Clear Translation Memory?'
	String get clearTMConfirmation => 'Clear Translation Memory?';

	/// en: 'This will delete all learned translations. This cannot be undone.'
	String get clearTMWarning => 'This will delete all learned translations. This cannot be undone.';

	/// en: 'Translation memory cleared'
	String get tmCleared => 'Translation memory cleared';

	/// en: 'Clear API Keys'
	String get clearApiKeys => 'Clear API Keys';

	/// en: 'Remove all stored API keys'
	String get clearApiKeysDescription => 'Remove all stored API keys';

	/// en: 'Clear API Keys?'
	String get clearApiKeysConfirmation => 'Clear API Keys?';

	/// en: 'This will remove all API keys from secure storage.'
	String get clearApiKeysWarning => 'This will remove all API keys from secure storage.';

	/// en: 'API keys cleared'
	String get apiKeysCleared => 'API keys cleared';

	/// en: 'Hide Developer Options'
	String get hideOptions => 'Hide Developer Options';

	/// en: 'Disable developer mode (requires 7 taps to re-enable)'
	String get hideOptionsDescription => 'Disable developer mode (requires 7 taps to re-enable)';

	/// en: 'Developer options disabled'
	String get optionsDisabled => 'Developer options disabled';

	/// en: 'Danger Zone'
	String get dangerZone => 'Danger Zone';

	/// en: 'Factory Reset'
	String get factoryReset => 'Factory Reset';

	/// en: 'Reset all settings and clear data'
	String get factoryResetDescription => 'Reset all settings and clear data';

	/// en: 'Are you sure you want to reset all settings? This action cannot be undone.'
	String get factoryResetWarning => 'Are you sure you want to reset all settings? This action cannot be undone.';

	/// en: 'Inspection Tools'
	String get inspectionTools => 'Inspection Tools';

	/// en: 'Search settings...'
	String get searchHint => 'Search settings...';

	/// en: 'Reset to defaults'
	String get resetToDefault => 'Reset to defaults';

	/// en: 'Reset to global default'
	String get resetToGlobal => 'Reset to global default';

	/// en: 'Storage Inspector'
	String get storageInspector => 'Storage Inspector';

	/// en: 'View Hive & Secure Storage contents'
	String get storageInspectorDescription => 'View Hive & Secure Storage contents';

	/// en: 'Device & Environment'
	String get deviceEnvironment => 'Device & Environment';

	/// en: 'Screen, platform, and build info'
	String get deviceEnvironmentDescription => 'Screen, platform, and build info';

	/// en: 'Theme Playground'
	String get themePlayground => 'Theme Playground';

	/// en: 'Color palette & typography'
	String get themePlaygroundDescription => 'Color palette & typography';

	late final TranslationsSettingsDeveloperThemePlaygroundSectionEn themePlaygroundSection = TranslationsSettingsDeveloperThemePlaygroundSectionEn.internal(_root);

	/// en: 'Localization Inspector'
	String get localizationInspector => 'Localization Inspector';

	/// en: 'Debug translation strings'
	String get localizationInspectorDescription => 'Debug translation strings';

	/// en: 'Hive (AppSettings)'
	String get hiveAppSettings => 'Hive (AppSettings)';

	/// en: 'Secure Storage (Masked)'
	String get secureStorageMasked => 'Secure Storage (Masked)';

	late final TranslationsSettingsDeveloperFeatureFlagsEn featureFlags = TranslationsSettingsDeveloperFeatureFlagsEn.internal(_root);
	late final TranslationsSettingsDeveloperStorageInspectorSectionEn storageInspectorSection = TranslationsSettingsDeveloperStorageInspectorSectionEn.internal(_root);
	late final TranslationsSettingsDeveloperDeviceInfoSectionEn deviceInfoSection = TranslationsSettingsDeveloperDeviceInfoSectionEn.internal(_root);
	late final TranslationsSettingsDeveloperLocalizationInspectorSectionEn localizationInspectorSection = TranslationsSettingsDeveloperLocalizationInspectorSectionEn.internal(_root);
}

// Path: settings.about
class TranslationsSettingsAboutEn {
	TranslationsSettingsAboutEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About'
	String get title => 'About';

	/// en: 'Version'
	String get version => 'Version';

	/// en: 'Build Number'
	String get buildNumber => 'Build Number';

	/// en: 'Author'
	String get author => 'Author';

	/// en: 'License'
	String get license => 'License';

	/// en: 'Source Code'
	String get sourceCode => 'Source Code';

	/// en: 'Report a Bug'
	String get reportBug => 'Report a Bug';

	/// en: 'Request a Feature'
	String get requestFeature => 'Request a Feature';

	/// en: 'Check for Updates'
	String get checkForUpdates => 'Check for Updates';

	/// en: 'You're up to date!'
	String get upToDate => 'You\'re up to date!';

	/// en: 'Update available: ${version}'
	String updateAvailable({required Object version}) => 'Update available: ${version}';

	/// en: 'Update Available!'
	String get updateAvailableBadge => 'Update Available!';

	/// en: 'You are ${count} steps away from being a developer.'
	String developerSteps({required Object count}) => 'You are ${count} steps away from being a developer.';

	/// en: 'You are now a developer!'
	String get developerActivated => 'You are now a developer!';

	/// en: 'Never'
	String get neverChecked => 'Never';

	/// en: 'Application Info'
	String get applicationInfo => 'Application Info';

	/// en: 'Platform'
	String get platform => 'Platform';

	/// en: 'Update Information'
	String get updateInformation => 'Update Information';

	/// en: 'Current Version'
	String get currentVersion => 'Current Version';

	/// en: 'Latest Version'
	String get latestVersion => 'Latest Version';

	/// en: 'Last Checked'
	String get lastChecked => 'Last Checked';

	/// en: 'Checking...'
	String get checkingForUpdates => 'Checking...';

	/// en: 'What's New'
	String get whatsNew => 'What\'s New';

	/// en: 'System Information'
	String get systemInformation => 'System Information';

	/// en: 'Dart Version'
	String get dartVersion => 'Dart Version';

	/// en: 'Available Disk Space'
	String get diskSpace => 'Available Disk Space';

	/// en: 'Memory Usage'
	String get memoryUsage => 'Memory Usage';

	/// en: 'Privacy & Telemetry'
	String get privacyTitle => 'Privacy & Telemetry';

	/// en: 'Anonymous Usage Statistics'
	String get usageStats => 'Anonymous Usage Statistics';

	/// en: 'Requires Firebase configuration'
	String get requiresFirebase => 'Requires Firebase configuration';

	/// en: 'Feature currently unavailable (Requires Firebase)'
	String get featureUnavailable => 'Feature currently unavailable (Requires Firebase)';

	/// en: 'Settings Management'
	String get settingsManagement => 'Settings Management';

	/// en: 'Export your settings to a file to back them up or share with other machines.'
	String get settingsManagementDescription => 'Export your settings to a file to back them up or share with other machines.';

	/// en: 'Reset All'
	String get resetAll => 'Reset All';

	/// en: 'Links'
	String get links => 'Links';

	/// en: 'GitHub Repository'
	String get githubRepo => 'GitHub Repository';

	/// en: 'Privacy Policy'
	String get privacyPolicy => 'Privacy Policy';

	/// en: 'Crash Reporting'
	String get crashReporting => 'Crash Reporting';
}

// Path: settings.onboarding
class TranslationsSettingsOnboardingEn {
	TranslationsSettingsOnboardingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Skip Tutorial'
	String get skipTutorial => 'Skip Tutorial';

	/// en: 'Getting Started'
	String get gettingStarted => 'Getting Started';

	/// en: '${current} of ${total}'
	String stepProgress({required Object current, required Object total}) => '${current} of ${total}';

	/// en: 'Load Sample Data'
	String get loadSampleData => 'Load Sample Data';

	late final TranslationsSettingsOnboardingStepsEn steps = TranslationsSettingsOnboardingStepsEn.internal(_root);
}

// Path: settings.settingsView
class TranslationsSettingsSettingsViewEn {
	TranslationsSettingsSettingsViewEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reset ${category}?'
	String resetCategoryTitle({required Object category}) => 'Reset ${category}?';

	/// en: 'This will reset all settings in this category to their default values.'
	String get resetCategoryContent => 'This will reset all settings in this category to their default values.';

	/// en: 'Reset All Settings?'
	String get resetAllTitle => 'Reset All Settings?';

	/// en: 'This will permanently reset all settings to their factory defaults. This action cannot be undone.'
	String get resetAllContent => 'This will permanently reset all settings to their factory defaults. This action cannot be undone.';

	/// en: 'Reset All'
	String get resetAll => 'Reset All';

	/// en: '${category} reset to defaults'
	String resetSuccess({required Object category}) => '${category} reset to defaults';

	/// en: 'Error loading settings'
	String get errorLoading => 'Error loading settings';

	/// en: 'Settings saved'
	String get settingsSaved => 'Settings saved';

	/// en: 'Update available: v${version}'
	String updateAvailable({required Object version}) => 'Update available: v${version}';

	/// en: 'You are using the latest version'
	String get latestVersion => 'You are using the latest version';

	/// en: 'What's New in v${version}'
	String whatsNew({required Object version}) => 'What\'s New in v${version}';

	/// en: 'Download Update'
	String get downloadUpdate => 'Download Update';

	/// en: 'Export Settings'
	String get exportSettings => 'Export Settings';

	/// en: 'Settings exported'
	String get settingsExported => 'Settings exported';

	/// en: 'Failed to export settings: ${error}'
	String exportFail({required Object error}) => 'Failed to export settings: ${error}';

	/// en: 'Import Settings'
	String get importSettings => 'Import Settings';

	/// en: 'Import Settings?'
	String get importTitle => 'Import Settings?';

	/// en: 'This will replace all your current settings with the imported ones. This action cannot be undone.'
	String get importContent => 'This will replace all your current settings with the imported ones. This action cannot be undone.';

	/// en: 'Settings imported successfully!'
	String get importSuccess => 'Settings imported successfully!';

	/// en: 'Failed to import settings: ${error}'
	String importFail({required Object error}) => 'Failed to import settings: ${error}';

	/// en: 'Invalid settings file format'
	String get invalidFormat => 'Invalid settings file format';

	late final TranslationsSettingsSettingsViewCategoriesEn categories = TranslationsSettingsSettingsViewCategoriesEn.internal(_root);
	late final TranslationsSettingsSettingsViewCategoryLabelsEn categoryLabels = TranslationsSettingsSettingsViewCategoryLabelsEn.internal(_root);
}

// Path: advancedDiff.aiSuggestion
class TranslationsAdvancedDiffAiSuggestionEn {
	TranslationsAdvancedDiffAiSuggestionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'AI Translation'
	String get aiTranslation => 'AI Translation';

	/// en: 'AI Rephrase'
	String get aiRephrase => 'AI Rephrase';

	/// en: 'Key: ${key}'
	String key({required Object key}) => 'Key: ${key}';

	/// en: 'Original:'
	String get original => 'Original:';

	/// en: 'Suggestion:'
	String get suggestion => 'Suggestion:';

	/// en: 'AI Confidence'
	String get confidence => 'AI Confidence';

	/// en: 'Cancel edit'
	String get cancelEdit => 'Cancel edit';

	/// en: 'Edit suggestion'
	String get editSuggestion => 'Edit suggestion';

	/// en: 'Alternatives:'
	String get alternatives => 'Alternatives:';

	/// en: 'Accept'
	String get accept => 'Accept';

	/// en: 'Reject'
	String get reject => 'Reject';

	/// en: 'Stop'
	String get stop => 'Stop';
}

// Path: advancedDiff.detailEdit
class TranslationsAdvancedDiffDetailEditEn {
	TranslationsAdvancedDiffDetailEditEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit: ${key}'
	String title({required Object key}) => 'Edit: ${key}';

	/// en: 'SOURCE (Original)'
	String get sourceLabel => 'SOURCE (Original)';

	/// en: 'TARGET (Translation)'
	String get targetLabel => 'TARGET (Translation)';

	/// en: 'Translate with Cloud'
	String get translateWithCloud => 'Translate with Cloud';

	/// en: 'Translate with AI'
	String get translateWithAi => 'Translate with AI';

	/// en: 'Translating...'
	String get translating => 'Translating...';

	/// en: 'Apply'
	String get applyAndTm => 'Apply';

	/// en: 'Entry applied & added to TM'
	String get entryApplied => 'Entry applied & added to TM';

	/// en: 'Translation suggestion added.'
	String get translationAdded => 'Translation suggestion added.';

	/// en: 'AI suggestion added.'
	String get aiSuggestionAdded => 'AI suggestion added.';
}

// Path: advancedDiff.table
class TranslationsAdvancedDiffTableEn {
	TranslationsAdvancedDiffTableEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Added to Translation Memory'
	String get addedToTM => 'Added to Translation Memory';

	/// en: 'Marked as reviewed ✓'
	String get markedReviewed => 'Marked as reviewed ✓';

	/// en: 'Unmarked review'
	String get unmarkedReview => 'Unmarked review';

	/// en: 'Reverted to source value'
	String get reverted => 'Reverted to source value';

	/// en: 'Entry deleted'
	String get entryDeleted => 'Entry deleted';

	/// en: 'No source text to translate.'
	String get noSourceText => 'No source text to translate.';

	/// en: 'AI translation failed for "${key}"'
	String aiTranslationFailed({required Object key}) => 'AI translation failed for "${key}"';

	/// en: 'No target text to rephrase.'
	String get noTargetText => 'No target text to rephrase.';

	/// en: 'AI rephrase failed for "${key}"'
	String aiRephraseFailed({required Object key}) => 'AI rephrase failed for "${key}"';

	/// en: 'Check rows using checkboxes first'
	String get checkRowsFirst => 'Check rows using checkboxes first';

	/// en: 'Marked ${count} rows as reviewed'
	String markedRowsReviewed({required Object count}) => 'Marked ${count} rows as reviewed';

	/// en: 'Reverted ${count} rows'
	String revertedRows({required Object count}) => 'Reverted ${count} rows';

	/// en: '${count} entries'
	String entriesCount({required Object count}) => '${count} entries';

	/// en: 'Mark Selected Reviewed'
	String get markSelectedReviewed => 'Mark Selected Reviewed';

	/// en: 'Revert Selected'
	String get revertSelected => 'Revert Selected';

	/// en: 'No differences found'
	String get noDifferences => 'No differences found';

	/// en: 'Try adjusting your filters'
	String get adjustFilters => 'Try adjusting your filters';

	/// en: 'Cloud translation applied.'
	String get cloudTranslationApplied => 'Cloud translation applied.';

	/// en: 'AI translation applied.'
	String get aiTranslationApplied => 'AI translation applied.';

	/// en: 'Suggestion applied.'
	String get suggestionApplied => 'Suggestion applied.';

	/// en: 'AI suggestion applied.'
	String get aiSuggestionApplied => 'AI suggestion applied.';

	/// en: 'Rephrase applied.'
	String get rephraseApplied => 'Rephrase applied.';

	/// en: 'AI rephrase applied.'
	String get aiRephraseApplied => 'AI rephrase applied.';

	/// en: 'Rephrase'
	String get rephrase => 'Rephrase';

	/// en: 'AI Rephrase'
	String get aiRephrase => 'AI Rephrase';

	/// en: 'TARGET (Click to edit)'
	String get targetClickToEdit => 'TARGET (Click to edit)';

	/// en: 'TARGET (Click for dialog)'
	String get targetClickForDialog => 'TARGET (Click for dialog)';

	/// en: '(Empty - Click to edit)'
	String get emptyClickToEdit => '(Empty - Click to edit)';

	/// en: 'Unmark reviewed'
	String get unmarkReviewed => 'Unmark reviewed';

	/// en: 'Mark as reviewed'
	String get markReviewed => 'Mark as reviewed';

	/// en: 'Revert to source'
	String get revertToSource => 'Revert to source';

	/// en: 'Translate with Cloud'
	String get translateWithCloud => 'Translate with Cloud';

	/// en: 'Translate with AI'
	String get translateWithAi => 'Translate with AI';

	/// en: 'Rephrase with AI'
	String get rephraseWithAi => 'Rephrase with AI';

	/// en: 'More actions'
	String get moreActions => 'More actions';

	/// en: 'Edit details'
	String get editDetails => 'Edit details';

	/// en: 'Suggest translation'
	String get suggestTranslation => 'Suggest translation';

	/// en: 'Add to TM'
	String get addToTm => 'Add to TM';

	/// en: 'Delete entry'
	String get deleteEntry => 'Delete entry';
}

// Path: advancedDiff.diffRow
class TranslationsAdvancedDiffDiffRowEn {
	TranslationsAdvancedDiffDiffRowEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Copy source text'
	String get copySource => 'Copy source text';

	/// en: 'Actions'
	String get actions => 'Actions';
}

// Path: advancedDiff.status
class TranslationsAdvancedDiffStatusEn {
	TranslationsAdvancedDiffStatusEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'ADDED'
	String get added => 'ADDED';

	/// en: 'MISSING'
	String get missing => 'MISSING';

	/// en: 'CHG ${percent}%'
	String changed({required Object percent}) => 'CHG ${percent}%';

	/// en: 'SAME'
	String get same => 'SAME';
}

// Path: advancedDiff.sidebar
class TranslationsAdvancedDiffSidebarEn {
	TranslationsAdvancedDiffSidebarEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Widgets'
	String get widgets => 'Widgets';

	/// en: 'Search keys & values... (Ctrl+F)'
	String get searchPlaceholder => 'Search keys & values... (Ctrl+F)';

	/// en: 'Fuzzy Search (typo-tolerant)'
	String get fuzzySearchTooltip => 'Fuzzy Search (typo-tolerant)';

	/// en: 'Regex Search'
	String get regexSearchTooltip => 'Regex Search';

	/// en: 'Cloud Translation'
	String get cloudTranslation => 'Cloud Translation';

	/// en: 'AI Translation'
	String get aiTranslation => 'AI Translation';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'Translation Memory'
	String get tm => 'Translation Memory';

	/// en: 'Filters'
	String get filters => 'Filters';

	/// en: 'Actions'
	String get actions => 'Actions';

	/// en: 'Similarity'
	String get similarity => 'Similarity';

	late final TranslationsAdvancedDiffSidebarActionsSectionEn actionsSection = TranslationsAdvancedDiffSidebarActionsSectionEn.internal(_root);
	late final TranslationsAdvancedDiffSidebarAiSectionEn aiSection = TranslationsAdvancedDiffSidebarAiSectionEn.internal(_root);
	late final TranslationsAdvancedDiffSidebarTmSectionEn tmSection = TranslationsAdvancedDiffSidebarTmSectionEn.internal(_root);
	late final TranslationsAdvancedDiffSidebarFiltersSectionEn filtersSection = TranslationsAdvancedDiffSidebarFiltersSectionEn.internal(_root);
	late final TranslationsAdvancedDiffSidebarSimilaritySectionEn similaritySection = TranslationsAdvancedDiffSidebarSimilaritySectionEn.internal(_root);
	late final TranslationsAdvancedDiffSidebarStatusSectionEn statusSection = TranslationsAdvancedDiffSidebarStatusSectionEn.internal(_root);
}

// Path: issueDetails.duplicateValue
class TranslationsIssueDetailsDuplicateValueEn {
	TranslationsIssueDetailsDuplicateValueEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'REPEATED TRANSLATION'
	String get label => 'REPEATED TRANSLATION';

	/// en: 'Different source texts use this same translation. Check context.'
	String get warning => 'Different source texts use this same translation. Check context.';

	/// en: 'AFFECTED KEYS (${count})'
	String affectedKeys({required Object count}) => 'AFFECTED KEYS (${count})';

	/// en: 'Identical Sources'
	String get identicalSources => 'Identical Sources';

	/// en: '+${count} more keys'
	String moreKeys({required Object count}) => '+${count} more keys';
}

// Path: issueDetails.lengthOutlier
class TranslationsIssueDetailsLengthOutlierEn {
	TranslationsIssueDetailsLengthOutlierEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SOURCE'
	String get source => 'SOURCE';

	/// en: 'TRANSLATION'
	String get translation => 'TRANSLATION';

	/// en: '${count} chars'
	String chars({required Object count}) => '${count} chars';
}

// Path: issueDetails.standard
class TranslationsIssueDetailsStandardEn {
	TranslationsIssueDetailsStandardEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'KEY'
	String get key => 'KEY';

	/// en: 'SOURCE TEXT'
	String get sourceText => 'SOURCE TEXT';

	/// en: 'TRANSLATION'
	String get translation => 'TRANSLATION';

	/// en: 'ERROR DETAILS'
	String get errorDetails => 'ERROR DETAILS';

	/// en: 'NOTE'
	String get note => 'NOTE';
}

// Path: issueDetails.types
class TranslationsIssueDetailsTypesEn {
	TranslationsIssueDetailsTypesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Duplicate Values'
	String get duplicateValue => 'Duplicate Values';

	/// en: 'Length Mismatch'
	String get lengthOutlier => 'Length Mismatch';

	/// en: 'Broken Placeholders'
	String get placeholderMismatch => 'Broken Placeholders';
}

// Path: issueDetails.notes
class TranslationsIssueDetailsNotesEn {
	TranslationsIssueDetailsNotesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Markers like {name} should match the source.'
	String get placeholderMismatch => 'Markers like {name} should match the source.';

	/// en: 'Big length changes can affect how text fits on screen.'
	String get lengthOutlier => 'Big length changes can affect how text fits on screen.';

	/// en: 'Same translation is used for different keys.'
	String get duplicateValue => 'Same translation is used for different keys.';
}

// Path: issueDetails.fallbacks
class TranslationsIssueDetailsFallbacksEn {
	TranslationsIssueDetailsFallbacksEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Multiple source texts'
	String get multipleSources => 'Multiple source texts';

	/// en: 'Source text not available'
	String get sourceNotAvailable => 'Source text not available';

	/// en: 'Shared translation not available'
	String get sharedTranslationNotAvailable => 'Shared translation not available';

	/// en: 'Translation not available'
	String get translationNotAvailable => 'Translation not available';
}

// Path: compare.tabs
class TranslationsCompareTabsEn {
	TranslationsCompareTabsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Files'
	String get files => 'Files';

	/// en: 'Directories'
	String get directories => 'Directories';

	/// en: 'Git'
	String get git => 'Git';
}

// Path: compare.fileTypes
class TranslationsCompareFileTypesEn {
	TranslationsCompareFileTypesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'JSON localization files (i18next, Flutter, etc.)'
	String get json => 'JSON localization files (i18next, Flutter, etc.)';

	/// en: 'YAML localization files (Rails, Flutter)'
	String get yaml => 'YAML localization files (Rails, Flutter)';

	/// en: 'XML localization files (Android, .NET)'
	String get xml => 'XML localization files (Android, .NET)';

	/// en: 'Properties files (Java)'
	String get properties => 'Properties files (Java)';

	/// en: 'RESX files (.NET)'
	String get resx => 'RESX files (.NET)';

	/// en: 'XLIFF files'
	String get xliff => 'XLIFF files';
}

// Path: history.timeAgo
class TranslationsHistoryTimeAgoEn {
	TranslationsHistoryTimeAgoEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'just now'
	String get justNow => 'just now';

	/// en: '${count} seconds ago'
	String secondsAgo({required Object count}) => '${count} seconds ago';

	/// en: '1 minute ago'
	String get oneMinuteAgo => '1 minute ago';

	/// en: '${count} minutes ago'
	String minutesAgo({required Object count}) => '${count} minutes ago';

	/// en: '1 hour ago'
	String get oneHourAgo => '1 hour ago';

	/// en: '${count} hours ago'
	String hoursAgo({required Object count}) => '${count} hours ago';

	/// en: 'yesterday'
	String get yesterday => 'yesterday';

	/// en: '${count} days ago'
	String daysAgo({required Object count}) => '${count} days ago';

	/// en: '1 week ago'
	String get oneWeekAgo => '1 week ago';

	/// en: '${count} weeks ago'
	String weeksAgo({required Object count}) => '${count} weeks ago';

	/// en: '1 month ago'
	String get oneMonthAgo => '1 month ago';

	/// en: '${count} months ago'
	String monthsAgo({required Object count}) => '${count} months ago';

	/// en: '1 year ago'
	String get oneYearAgo => '1 year ago';

	/// en: '${count} years ago'
	String yearsAgo({required Object count}) => '${count} years ago';

	/// en: 'in the future'
	String get inTheFuture => 'in the future';
}

// Path: projects.stats
class TranslationsProjectsStatsEn {
	TranslationsProjectsStatsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Empty project'
	String get empty => 'Empty project';

	/// en: '(one) {1 translation file} (other) {${count} translation files}'
	String files({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '1 translation file',
		other: '${count} translation files',
	);

	/// en: '(one) {1 language} (other) {${count} languages}'
	String languages({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '1 language',
		other: '${count} languages',
	);
}

// Path: projects.selection
class TranslationsProjectsSelectionEn {
	TranslationsProjectsSelectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select Project Folder'
	String get selectFolder => 'Select Project Folder';

	/// en: 'Select Project Archive'
	String get selectArchive => 'Select Project Archive';

	/// en: 'Open Project'
	String get openProject => 'Open Project';

	/// en: 'Browse Folder...'
	String get browseFolder => 'Browse Folder...';

	/// en: 'Create New'
	String get createNew => 'Create New';

	/// en: 'Import from Zip...'
	String get importFromZip => 'Import from Zip...';
}

// Path: projects.createDialog
class TranslationsProjectsCreateDialogEn {
	TranslationsProjectsCreateDialogEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create Project'
	String get title => 'Create Project';

	/// en: 'A project lets you save custom settings for a specific folder. A ".localizer" folder will be created to store your project configuration.'
	String get description => 'A project lets you save custom settings for a specific folder. A ".localizer" folder will be created to store your project configuration.';

	/// en: 'Project Folder'
	String get folderLabel => 'Project Folder';

	/// en: 'Click to select folder...'
	String get folderHint => 'Click to select folder...';

	/// en: 'Project Name'
	String get nameLabel => 'Project Name';

	/// en: 'e.g., My App Translations'
	String get nameHint => 'e.g., My App Translations';

	/// en: 'Please select a project folder.'
	String get selectFolderWarning => 'Please select a project folder.';

	/// en: 'Please enter a project name'
	String get enterNameError => 'Please enter a project name';

	/// en: 'Name must be at least 2 characters'
	String get nameLengthError => 'Name must be at least 2 characters';

	/// en: 'Project "${name}" created successfully!'
	String success({required Object name}) => 'Project "${name}" created successfully!';

	/// en: 'Failed to create project.'
	String get failure => 'Failed to create project.';

	/// en: 'Creating...'
	String get creating => 'Creating...';

	/// en: 'Create Project'
	String get createAction => 'Create Project';
}

// Path: projects.indicator
class TranslationsProjectsIndicatorEn {
	TranslationsProjectsIndicatorEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create a project to save custom settings for a folder'
	String get tooltipNoProject => 'Create a project to save custom settings for a folder';

	/// en: 'Project: ${name} Click to see options'
	String tooltipProject({required Object name}) => 'Project: ${name}\nClick to see options';

	/// en: 'Location'
	String get location => 'Location';

	/// en: 'Created'
	String get created => 'Created';

	/// en: 'Switch Project'
	String get switchProject => 'Switch Project';

	/// en: 'Done'
	String get done => 'Done';
}

// Path: projects.glossary
class TranslationsProjectsGlossaryEn {
	TranslationsProjectsGlossaryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Project Glossary'
	String get title => 'Project Glossary';

	/// en: 'Define terms that should be treated consistently or never translated.'
	String get description => 'Define terms that should be treated consistently or never translated.';

	/// en: 'No glossary terms yet.'
	String get noTerms => 'No glossary terms yet.';

	/// en: 'Add terms that should stay consistent across translations, or mark brand names that should never be translated.'
	String get noTermsDesc => 'Add terms that should stay consistent across translations,\nor mark brand names that should never be translated.';

	/// en: 'Do not translate'
	String get doNotTranslate => 'Do not translate';

	/// en: 'No specific translation'
	String get noSpecificTranslation => 'No specific translation';

	/// en: 'Add Term'
	String get addTerm => 'Add Term';

	/// en: 'Edit Term'
	String get editTerm => 'Edit Term';

	/// en: 'Term'
	String get term => 'Term';

	/// en: 'e.g., brand name, specialized term'
	String get termHint => 'e.g., brand name, specialized term';

	/// en: 'Definition (Optional)'
	String get definition => 'Definition (Optional)';

	/// en: 'Context for the translator'
	String get definitionHint => 'Context for the translator';

	/// en: 'Do Not Translate'
	String get doNotTranslateLabel => 'Do Not Translate';

	/// en: 'Keep term exactly as is in target'
	String get doNotTranslateDesc => 'Keep term exactly as is in target';

	/// en: 'Preferred Translation'
	String get preferredTranslation => 'Preferred Translation';

	/// en: 'Case Sensitive'
	String get caseSensitive => 'Case Sensitive';
}

// Path: projects.conflicts
class TranslationsProjectsConflictsEn {
	TranslationsProjectsConflictsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Missing API key for ${service}'
	String missingApiKeyTitle({required Object service}) => 'Missing API key for ${service}';

	/// en: 'This project uses ${service} but no API key is configured. Add your API key in Settings > AI Services, or the app will use the global default.'
	String missingApiKeyMessage({required Object service}) => 'This project uses ${service} but no API key is configured. Add your API key in Settings > AI Services, or the app will use the global default.';

	/// en: 'Dismiss'
	String get dismiss => 'Dismiss';
}

// Path: projects.tm
class TranslationsProjectsTmEn {
	TranslationsProjectsTmEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Translation Memories'
	String get title => 'Translation Memories';

	/// en: 'Manage translation memory sources for this project.'
	String get description => 'Manage translation memory sources for this project.';

	/// en: 'Global Translation Memory'
	String get globalTm => 'Global Translation Memory';

	/// en: 'Use the shared translation memory from your app settings'
	String get globalTmDescription => 'Use the shared translation memory from your app settings';

	/// en: 'Linked Files (Project Specific)'
	String get linkedFiles => 'Linked Files (Project Specific)';

	/// en: 'No project-specific files linked.'
	String get noLinkedFiles => 'No project-specific files linked.';

	/// en: 'Add TM File'
	String get addTmFile => 'Add TM File';

	/// en: 'Use Global TM'
	String get useGlobalTm => 'Use Global TM';

	/// en: 'Select Translation Memory'
	String get selectTm => 'Select Translation Memory';

	/// en: 'Global Translation Memory enabled'
	String get globalTmEnabled => 'Global Translation Memory enabled';
}

// Path: git.conflicts
class TranslationsGitConflictsEn {
	TranslationsGitConflictsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Merge Conflicts Detected'
	String get title => 'Merge Conflicts Detected';

	/// en: 'You must resolve these conflicts before you can continue.'
	String get description => 'You must resolve these conflicts before you can continue.';

	/// en: 'Abort Merge?'
	String get abortMergeTitle => 'Abort Merge?';

	/// en: 'This will revert all merge changes and return to the state before the merge. This cannot be undone.'
	String get abortMergeContent => 'This will revert all merge changes and return to the state before the merge. This cannot be undone.';

	/// en: 'Abort Merge'
	String get abortMergeAction => 'Abort Merge';

	/// en: 'Staging ${file} for commit...'
	String stagingFile({required Object file}) => 'Staging ${file} for commit...';

	/// en: 'Conflicted Files (${count})'
	String conflictedFilesCount({required Object count}) => 'Conflicted Files (${count})';

	/// en: 'Select a file to resolve'
	String get selectFileToResolve => 'Select a file to resolve';

	/// en: 'Resolving: ${file}'
	String resolvingFile({required Object file}) => 'Resolving: ${file}';

	/// en: 'Keep All Ours'
	String get keepAllOurs => 'Keep All Ours';

	/// en: 'Accept All Theirs'
	String get acceptAllTheirs => 'Accept All Theirs';

	/// en: 'All conflicts in this file have been resolved!'
	String get allResolved => 'All conflicts in this file have been resolved!';

	/// en: 'Mark as Resolved'
	String get markResolved => 'Mark as Resolved';

	/// en: 'This will stage the file for commit.'
	String get stageForCommit => 'This will stage the file for commit.';

	/// en: 'Conflict #${index}'
	String conflictIndex({required Object index}) => 'Conflict #${index}';

	/// en: 'OURS (Current)'
	String get ours => 'OURS (Current)';

	/// en: 'THEIRS (Incoming)'
	String get theirs => 'THEIRS (Incoming)';

	/// en: 'Keep Ours'
	String get keepOurs => 'Keep Ours';

	/// en: 'Accept Theirs'
	String get acceptTheirs => 'Accept Theirs';

	/// en: '(Empty)'
	String get empty => '(Empty)';
}

// Path: wizards.firstRun
class TranslationsWizardsFirstRunEn {
	TranslationsWizardsFirstRunEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome to Localizer'
	String get welcome => 'Welcome to Localizer';

	/// en: 'Compare your localization files in seconds.'
	String get description => 'Compare your localization files in seconds.';

	/// en: 'Source File'
	String get sourceFile => 'Source File';

	/// en: 'Target File'
	String get targetFile => 'Target File';

	/// en: 'Compare Now'
	String get compareNow => 'Compare Now';

	/// en: 'Try with Sample Data'
	String get trySample => 'Try with Sample Data';

	/// en: 'Skip Setup'
	String get skip => 'Skip Setup';

	/// en: 'Click to browse'
	String get browse => 'Click to browse';

	/// en: 'Failed to load sample data: ${error}'
	String error({required Object error}) => 'Failed to load sample data: ${error}';
}

// Path: dialogs.addIgnorePattern
class TranslationsDialogsAddIgnorePatternEn {
	TranslationsDialogsAddIgnorePatternEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add Ignore Pattern'
	String get title => 'Add Ignore Pattern';

	/// en: 'Pattern (regex)'
	String get patternLabel => 'Pattern (regex)';

	/// en: 'e.g., ^temp_.*'
	String get hint => 'e.g., ^temp_.*';

	/// en: 'Invalid regex pattern'
	String get invalid => 'Invalid regex pattern';

	/// en: 'Test String'
	String get testStringLabel => 'Test String';

	/// en: 'Enter a key to test against pattern'
	String get testHint => 'Enter a key to test against pattern';

	/// en: '✓ Pattern matches test string'
	String get match => '✓ Pattern matches test string';

	/// en: '✗ Pattern does not match'
	String get noMatch => '✗ Pattern does not match';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Cancel'
	String get cancel => 'Cancel';
}

// Path: dialogs.diffViewer
class TranslationsDialogsDiffViewerEn {
	TranslationsDialogsDiffViewerEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Diff Viewer'
	String get title => 'Diff Viewer';

	/// en: 'Original/Reference file'
	String get originalFile => 'Original/Reference file';

	/// en: 'Translation/Comparison file'
	String get translationFile => 'Translation/Comparison file';

	/// en: 'BASE'
	String get base => 'BASE';

	/// en: 'TARGET'
	String get target => 'TARGET';

	/// en: 'Added'
	String get added => 'Added';

	/// en: 'Removed'
	String get removed => 'Removed';

	/// en: 'Modified'
	String get modified => 'Modified';

	/// en: 'No entries match the current filters'
	String get noMatches => 'No entries match the current filters';

	/// en: 'Click the badges above to toggle filters'
	String get clickToggle => 'Click the badges above to toggle filters';
}

// Path: grid.columns
class TranslationsGridColumnsEn {
	TranslationsGridColumnsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Key'
	String get key => 'Key';

	/// en: 'Source'
	String get source => 'Source';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'Actions'
	String get actions => 'Actions';
}

// Path: tutorial.steps
class TranslationsTutorialStepsEn {
	TranslationsTutorialStepsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsTutorialStepsImportSourceEn importSource = TranslationsTutorialStepsImportSourceEn.internal(_root);
	late final TranslationsTutorialStepsImportTargetEn importTarget = TranslationsTutorialStepsImportTargetEn.internal(_root);
	late final TranslationsTutorialStepsCompareEn compare = TranslationsTutorialStepsCompareEn.internal(_root);
	late final TranslationsTutorialStepsFilterEn filter = TranslationsTutorialStepsFilterEn.internal(_root);
	late final TranslationsTutorialStepsSearchEn search = TranslationsTutorialStepsSearchEn.internal(_root);
	late final TranslationsTutorialStepsAdvancedEn advanced = TranslationsTutorialStepsAdvancedEn.internal(_root);
	late final TranslationsTutorialStepsExportEn export = TranslationsTutorialStepsExportEn.internal(_root);
}

// Path: friendlyErrors.fileNotFound
class TranslationsFriendlyErrorsFileNotFoundEn {
	TranslationsFriendlyErrorsFileNotFoundEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The file or folder could not be found.'
	String get message => 'The file or folder could not be found.';

	/// en: 'Check if the file was moved or deleted.'
	String get suggestion => 'Check if the file was moved or deleted.';
}

// Path: friendlyErrors.accessDenied
class TranslationsFriendlyErrorsAccessDeniedEn {
	TranslationsFriendlyErrorsAccessDeniedEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Access to the file was denied.'
	String get message => 'Access to the file was denied.';

	/// en: 'Try running the app as administrator or check file permissions.'
	String get suggestion => 'Try running the app as administrator or check file permissions.';
}

// Path: friendlyErrors.isDirectory
class TranslationsFriendlyErrorsIsDirectoryEn {
	TranslationsFriendlyErrorsIsDirectoryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'A folder was selected instead of a file.'
	String get message => 'A folder was selected instead of a file.';

	/// en: 'Please select a valid file.'
	String get suggestion => 'Please select a valid file.';
}

// Path: friendlyErrors.fileAccess
class TranslationsFriendlyErrorsFileAccessEn {
	TranslationsFriendlyErrorsFileAccessEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'There was a problem accessing the file.'
	String get message => 'There was a problem accessing the file.';

	/// en: 'Try closing other programs that might be using it.'
	String get suggestion => 'Try closing other programs that might be using it.';
}

// Path: friendlyErrors.unsupportedFormat
class TranslationsFriendlyErrorsUnsupportedFormatEn {
	TranslationsFriendlyErrorsUnsupportedFormatEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This file format or operation is not supported.'
	String get message => 'This file format or operation is not supported.';

	/// en: 'Check the file extension or try a different format.'
	String get suggestion => 'Check the file extension or try a different format.';
}

// Path: friendlyErrors.networkError
class TranslationsFriendlyErrorsNetworkErrorEn {
	TranslationsFriendlyErrorsNetworkErrorEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Could not connect to the server.'
	String get message => 'Could not connect to the server.';

	/// en: 'Check your internet connection and try again.'
	String get suggestion => 'Check your internet connection and try again.';
}

// Path: friendlyErrors.notGitRepo
class TranslationsFriendlyErrorsNotGitRepoEn {
	TranslationsFriendlyErrorsNotGitRepoEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This folder is not a Git project.'
	String get message => 'This folder is not a Git project.';

	/// en: 'Navigate to a folder that contains a .git directory.'
	String get suggestion => 'Navigate to a folder that contains a .git directory.';
}

// Path: friendlyErrors.mergeConflict
class TranslationsFriendlyErrorsMergeConflictEn {
	TranslationsFriendlyErrorsMergeConflictEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'There are merge conflicts in the repository.'
	String get message => 'There are merge conflicts in the repository.';

	/// en: 'Resolve the conflicts before continuing.'
	String get suggestion => 'Resolve the conflicts before continuing.';
}

// Path: friendlyErrors.gitAuthFailed
class TranslationsFriendlyErrorsGitAuthFailedEn {
	TranslationsFriendlyErrorsGitAuthFailedEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Git authentication failed.'
	String get message => 'Git authentication failed.';

	/// en: 'Check your credentials in Settings > Version Control.'
	String get suggestion => 'Check your credentials in Settings > Version Control.';
}

// Path: friendlyErrors.gitOperationFailed
class TranslationsFriendlyErrorsGitOperationFailedEn {
	TranslationsFriendlyErrorsGitOperationFailedEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'A Git operation failed.'
	String get message => 'A Git operation failed.';

	/// en: 'Check the Git view for more details.'
	String get suggestion => 'Check the Git view for more details.';
}

// Path: friendlyErrors.invalidJson
class TranslationsFriendlyErrorsInvalidJsonEn {
	TranslationsFriendlyErrorsInvalidJsonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The file format is invalid or corrupted.'
	String get message => 'The file format is invalid or corrupted.';

	/// en: 'Ensure the file contains valid JSON content.'
	String get suggestion => 'Ensure the file contains valid JSON content.';
}

// Path: friendlyErrors.rateLimitReached
class TranslationsFriendlyErrorsRateLimitReachedEn {
	TranslationsFriendlyErrorsRateLimitReachedEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Translation limit reached.'
	String get message => 'Translation limit reached.';

	/// en: 'Wait a few minutes or check your API plan limits.'
	String get suggestion => 'Wait a few minutes or check your API plan limits.';
}

// Path: friendlyErrors.invalidApiKey
class TranslationsFriendlyErrorsInvalidApiKeyEn {
	TranslationsFriendlyErrorsInvalidApiKeyEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Invalid API key.'
	String get message => 'Invalid API key.';

	/// en: 'Go to Settings > AI Translation to update your API key.'
	String get suggestion => 'Go to Settings > AI Translation to update your API key.';
}

// Path: friendlyErrors.translationServiceError
class TranslationsFriendlyErrorsTranslationServiceErrorEn {
	TranslationsFriendlyErrorsTranslationServiceErrorEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Translation service error.'
	String get message => 'Translation service error.';

	/// en: 'Check your API key and internet connection.'
	String get suggestion => 'Check your API key and internet connection.';
}

// Path: friendlyErrors.outOfMemory
class TranslationsFriendlyErrorsOutOfMemoryEn {
	TranslationsFriendlyErrorsOutOfMemoryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Not enough memory to complete this operation.'
	String get message => 'Not enough memory to complete this operation.';

	/// en: 'Try closing other applications or using smaller files.'
	String get suggestion => 'Try closing other applications or using smaller files.';
}

// Path: friendlyErrors.genericError
class TranslationsFriendlyErrorsGenericErrorEn {
	TranslationsFriendlyErrorsGenericErrorEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Something went wrong.'
	String get message => 'Something went wrong.';

	/// en: 'Please try again. If the problem persists, restart the app.'
	String get suggestion => 'Please try again. If the problem persists, restart the app.';
}

// Path: settings.appearance.presets
class TranslationsSettingsAppearancePresetsEn {
	TranslationsSettingsAppearancePresetsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Default'
	String get presetDefault => 'Default';

	/// en: 'Colorblind-Friendly'
	String get presetColorblind => 'Colorblind-Friendly';

	/// en: 'High Contrast'
	String get presetHighContrast => 'High Contrast';

	/// en: 'Nord'
	String get presetNord => 'Nord';

	/// en: 'Solarized'
	String get presetSolarized => 'Solarized';

	/// en: 'Monokai'
	String get presetMonokai => 'Monokai';
}

// Path: settings.appearance.preview
class TranslationsSettingsAppearancePreviewEn {
	TranslationsSettingsAppearancePreviewEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'onboarding.step3.title'
	String get step3Title => 'onboarding.step3.title';

	/// en: '"Connect Your Account"'
	String get connectAccount => '"Connect Your Account"';

	/// en: 'deprecated.login_hint_v1'
	String get loginHint => 'deprecated.login_hint_v1';

	/// en: '"Enter credentials"'
	String get enterCredentials => '"Enter credentials"';

	/// en: 'checkout.cta_button'
	String get ctaButton => 'checkout.cta_button';

	/// en: '"Buy Now"'
	String get buyNow => '"Buy Now"';

	/// en: '"Complete Purchase"'
	String get completePurchase => '"Complete Purchase"';

	/// en: 'common.app_name'
	String get appNameKey => 'common.app_name';

	/// en: '"Localizer"'
	String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class TranslationsSettingsComparisonPatternPresetsEn {
	TranslationsSettingsComparisonPatternPresetsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Comments'
	String get comments => 'Comments';

	/// en: 'Temp Keys'
	String get tempKeys => 'Temp Keys';

	/// en: 'Placeholders'
	String get placeholders => 'Placeholders';

	/// en: 'Dev Only'
	String get devOnly => 'Dev Only';
}

// Path: settings.comparison.previewMatch
class TranslationsSettingsComparisonPreviewMatchEn {
	TranslationsSettingsComparisonPreviewMatchEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Preview Match'
	String get title => 'Preview Match';

	/// en: 'Test how your current settings affect matching logic.'
	String get description => 'Test how your current settings affect matching logic.';

	/// en: 'String A'
	String get stringA => 'String A';

	/// en: 'String B'
	String get stringB => 'String B';

	/// en: 'Enter text...'
	String get enterText => 'Enter text...';

	/// en: 'Similarity'
	String get similarity => 'Similarity';

	/// en: 'Identical'
	String get identical => 'Identical';

	/// en: 'Strings match exactly after normalization.'
	String get identicalDescription => 'Strings match exactly after normalization.';

	/// en: 'Ignored'
	String get ignored => 'Ignored';

	/// en: 'Input matches an ignore pattern.'
	String get ignoredDescription => 'Input matches an ignore pattern.';

	/// en: 'Different'
	String get different => 'Different';

	/// en: 'One value is empty.'
	String get differentDescription => 'One value is empty.';

	/// en: 'Similar / Modified'
	String get similarModified => 'Similar / Modified';

	/// en: 'Match score is above threshold (${threshold}%).'
	String similarModifiedDescription({required Object threshold}) => 'Match score is above threshold (${threshold}%).';

	/// en: 'New / Different'
	String get newDifferent => 'New / Different';

	/// en: 'Match score is below threshold (${threshold}%).'
	String newDifferentDescription({required Object threshold}) => 'Match score is below threshold (${threshold}%).';
}

// Path: settings.comparison.colorPresets
class TranslationsSettingsComparisonColorPresetsEn {
	TranslationsSettingsComparisonColorPresetsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Default'
	String get kDefault => 'Default';

	/// en: 'Colorblind-Friendly'
	String get colorblindFriendly => 'Colorblind-Friendly';

	/// en: 'High Contrast'
	String get highContrast => 'High Contrast';

	/// en: 'Nord'
	String get nord => 'Nord';

	/// en: 'Solarized'
	String get solarized => 'Solarized';

	/// en: 'Monokai'
	String get monokai => 'Monokai';

	/// en: 'Default'
	String get presetDefault => 'Default';

	/// en: 'Colorblind-Friendly'
	String get presetColorblind => 'Colorblind-Friendly';

	/// en: 'High Contrast'
	String get presetHighContrast => 'High Contrast';

	/// en: 'Nord'
	String get presetNord => 'Nord';

	/// en: 'Solarized'
	String get presetSolarized => 'Solarized';

	/// en: 'Monokai'
	String get presetMonokai => 'Monokai';
}

// Path: settings.integrations.materials
class TranslationsSettingsIntegrationsMaterialsEn {
	TranslationsSettingsIntegrationsMaterialsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sidebar'
	String get sidebar => 'Sidebar';

	/// en: 'Menu'
	String get menu => 'Menu';

	/// en: 'Popover'
	String get popover => 'Popover';

	/// en: 'Titlebar'
	String get titlebar => 'Titlebar';

	/// en: 'Page Background'
	String get underPageBackground => 'Page Background';

	/// en: 'Content'
	String get contentBackground => 'Content';
}

// Path: settings.integrations.fileTypes
class TranslationsSettingsIntegrationsFileTypesEn {
	TranslationsSettingsIntegrationsFileTypesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Localizer Project File'
	String get loc => 'Localizer Project File';

	/// en: 'Language File'
	String get lang => 'Language File';

	/// en: 'JSON Localization File'
	String get json => 'JSON Localization File';

	/// en: 'XML Localization File'
	String get xml => 'XML Localization File';
}

// Path: settings.developer.themePlaygroundSection
class TranslationsSettingsDeveloperThemePlaygroundSectionEn {
	TranslationsSettingsDeveloperThemePlaygroundSectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Colors'
	String get colors => 'Colors';

	/// en: 'Typography'
	String get typography => 'Typography';

	late final TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn palette = TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn.internal(_root);
}

// Path: settings.developer.featureFlags
class TranslationsSettingsDeveloperFeatureFlagsEn {
	TranslationsSettingsDeveloperFeatureFlagsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Experimental Features'
	String get title => 'Experimental Features';

	/// en: 'Toggle feature flags locally for testing. These overrides persist across app restarts.'
	String get description => 'Toggle feature flags locally for testing. These overrides persist across app restarts.';

	/// en: 'Override experimental features'
	String get subtitle => 'Override experimental features';

	late final TranslationsSettingsDeveloperFeatureFlagsFlagsEn flags = TranslationsSettingsDeveloperFeatureFlagsFlagsEn.internal(_root);

	/// en: 'Reset All Flags'
	String get reset => 'Reset All Flags';

	/// en: 'Local Overrides'
	String get overrides => 'Local Overrides';

	/// en: 'Default'
	String get defaultVal => 'Default';

	/// en: 'ON'
	String get on => 'ON';

	/// en: 'OFF'
	String get off => 'OFF';
}

// Path: settings.developer.storageInspectorSection
class TranslationsSettingsDeveloperStorageInspectorSectionEn {
	TranslationsSettingsDeveloperStorageInspectorSectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Hive Data'
	String get hiveData => 'Hive Data';

	/// en: 'Secure Storage'
	String get secureStorage => 'Secure Storage';
}

// Path: settings.developer.deviceInfoSection
class TranslationsSettingsDeveloperDeviceInfoSectionEn {
	TranslationsSettingsDeveloperDeviceInfoSectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Copy to Clipboard'
	String get copy => 'Copy to Clipboard';

	/// en: 'Computer Name'
	String get computerName => 'Computer Name';

	/// en: 'OS Version'
	String get osVersion => 'OS Version';
}

// Path: settings.developer.localizationInspectorSection
class TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
	TranslationsSettingsDeveloperLocalizationInspectorSectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Show Keys Instead of Values'
	String get showKeys => 'Show Keys Instead of Values';

	/// en: 'Keys visible'
	String get keysVisible => 'Keys visible';

	/// en: 'Normal display'
	String get normalDisplay => 'Normal display';

	/// en: 'Note: This feature requires app localization to use a wrapper that respects this setting.'
	String get note => 'Note: This feature requires app localization to use a wrapper that respects this setting.';
}

// Path: settings.onboarding.steps
class TranslationsSettingsOnboardingStepsEn {
	TranslationsSettingsOnboardingStepsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSettingsOnboardingStepsImportFilesEn importFiles = TranslationsSettingsOnboardingStepsImportFilesEn.internal(_root);
	late final TranslationsSettingsOnboardingStepsRunComparisonEn runComparison = TranslationsSettingsOnboardingStepsRunComparisonEn.internal(_root);
	late final TranslationsSettingsOnboardingStepsReviewMissingEn reviewMissing = TranslationsSettingsOnboardingStepsReviewMissingEn.internal(_root);
	late final TranslationsSettingsOnboardingStepsUseFiltersEn useFilters = TranslationsSettingsOnboardingStepsUseFiltersEn.internal(_root);
	late final TranslationsSettingsOnboardingStepsSearchResultsEn searchResults = TranslationsSettingsOnboardingStepsSearchResultsEn.internal(_root);
	late final TranslationsSettingsOnboardingStepsAdvancedViewEn advancedView = TranslationsSettingsOnboardingStepsAdvancedViewEn.internal(_root);
	late final TranslationsSettingsOnboardingStepsEditCellEn editCell = TranslationsSettingsOnboardingStepsEditCellEn.internal(_root);
	late final TranslationsSettingsOnboardingStepsExportResultsEn exportResults = TranslationsSettingsOnboardingStepsExportResultsEn.internal(_root);
}

// Path: settings.settingsView.categories
class TranslationsSettingsSettingsViewCategoriesEn {
	TranslationsSettingsSettingsViewCategoriesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'General Settings'
	String get general => 'General Settings';

	/// en: 'Comparison Engine'
	String get comparisonEngine => 'Comparison Engine';

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: 'File Handling'
	String get fileHandling => 'File Handling';

	/// en: 'AI Services'
	String get aiServices => 'AI Services';

	/// en: 'System Integrations'
	String get systemIntegrations => 'System Integrations';

	/// en: 'Project Resources (Glossary & TM)'
	String get projectResources => 'Project Resources (Glossary & TM)';

	/// en: 'Developer Options'
	String get developer => 'Developer Options';

	/// en: 'About'
	String get about => 'About';
}

// Path: settings.settingsView.categoryLabels
class TranslationsSettingsSettingsViewCategoryLabelsEn {
	TranslationsSettingsSettingsViewCategoryLabelsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'General'
	String get general => 'General';

	/// en: 'Comparison'
	String get comparisonEngine => 'Comparison';

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: 'File Handling'
	String get fileHandling => 'File Handling';

	/// en: 'AI Services'
	String get aiServices => 'AI Services';

	/// en: 'System Integrations'
	String get systemIntegrations => 'System Integrations';

	/// en: 'Project Resources'
	String get projectResources => 'Project Resources';

	/// en: 'Developer Options'
	String get developer => 'Developer Options';

	/// en: 'About'
	String get about => 'About';
}

// Path: advancedDiff.sidebar.actionsSection
class TranslationsAdvancedDiffSidebarActionsSectionEn {
	TranslationsAdvancedDiffSidebarActionsSectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Export matches'
	String get exportMatches => 'Export matches';

	/// en: 'Preview'
	String get preview => 'Preview';

	/// en: 'Fill from Translation Memory?'
	String get fillFromTmTitle => 'Fill from Translation Memory?';

	/// en: 'This will attempt to fill empty target values using matches from the Translation Memory. Existing values will NOT be overwritten.'
	String get fillFromTmContent => 'This will attempt to fill empty target values using matches from the Translation Memory. Existing values will NOT be overwritten.';

	/// en: 'Fill'
	String get fill => 'Fill';

	/// en: 'Fill from Memory'
	String get fillFromMemory => 'Fill from Memory';

	/// en: 'Filled ${count} items from Translation Memory.'
	String filledFromTm({required Object count}) => 'Filled ${count} items from Translation Memory.';
}

// Path: advancedDiff.sidebar.aiSection
class TranslationsAdvancedDiffSidebarAiSectionEn {
	TranslationsAdvancedDiffSidebarAiSectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Uses cloud translation to translate empty target values from source.'
	String get infoCloud => 'Uses cloud translation to translate empty target values from source.';

	/// en: 'Uses AI to translate empty target values from source.'
	String get infoAi => 'Uses AI to translate empty target values from source.';

	/// en: 'Translation Settings'
	String get translationSettings => 'Translation Settings';

	/// en: 'AI Settings'
	String get aiSettings => 'AI Settings';

	/// en: 'Source'
	String get source => 'Source';

	/// en: 'Target'
	String get target => 'Target';

	/// en: 'Translating... ${percent}%'
	String translatingProgress({required Object percent}) => 'Translating... ${percent}%';

	/// en: 'Translating...'
	String get translating => 'Translating...';

	/// en: 'Translate All Missing'
	String get translateAllMissing => 'Translate All Missing';

	/// en: 'Translate All Missing?'
	String get translateAllTitle => 'Translate All Missing?';

	/// en: 'This will use ${service} to translate all entries with empty target values from ${source} to ${target}. You can review each suggestion or apply all at once.'
	String translateAllContent({required Object service, required Object source, required Object target}) => 'This will use ${service} to translate all entries with empty target values from ${source} to ${target}.\n\nYou can review each suggestion or apply all at once.';

	/// en: 'Translate All'
	String get translateAll => 'Translate All';

	/// en: 'Review Each'
	String get reviewEach => 'Review Each';

	/// en: 'Translated ${count} entries with cloud translation.'
	String cloudTranslated({required Object count}) => 'Translated ${count} entries with cloud translation.';

	/// en: 'Translated ${count} entries with AI.'
	String aiTranslated({required Object count}) => 'Translated ${count} entries with AI.';

	/// en: 'AI translate all failed'
	String get aiTranslateFailed => 'AI translate all failed';

	/// en: 'No missing entries to translate.'
	String get noMissingEntries => 'No missing entries to translate.';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Stop'
	String get stop => 'Stop';

	/// en: 'Applied ${count} suggestions.'
	String cloudApplied({required Object count}) => 'Applied ${count} suggestions.';

	/// en: 'Applied ${count} AI suggestions.'
	String aiApplied({required Object count}) => 'Applied ${count} AI suggestions.';
}

// Path: advancedDiff.sidebar.tmSection
class TranslationsAdvancedDiffSidebarTmSectionEn {
	TranslationsAdvancedDiffSidebarTmSectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enable TM Fill'
	String get enableTmFill => 'Enable TM Fill';

	/// en: 'Auto-apply above minimum'
	String get autoApplyAboveMinimum => 'Auto-apply above minimum';

	/// en: 'Match Settings'
	String get matchSettings => 'Match Settings';

	/// en: 'Min match:'
	String get minMatch => 'Min match:';

	/// en: 'Limit:'
	String get limit => 'Limit:';

	/// en: 'Exact'
	String get exact => 'Exact';
}

// Path: advancedDiff.sidebar.filtersSection
class TranslationsAdvancedDiffSidebarFiltersSectionEn {
	TranslationsAdvancedDiffSidebarFiltersSectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'View Filters'
	String get viewFilters => 'View Filters';

	/// en: 'Show All'
	String get showAll => 'Show All';

	/// en: 'Added'
	String get added => 'Added';

	/// en: 'Removed'
	String get removed => 'Removed';

	/// en: 'Modified'
	String get modified => 'Modified';

	/// en: 'Action Scope'
	String get actionScope => 'Action Scope';

	/// en: 'Apply to Added'
	String get applyToAdded => 'Apply to Added';

	/// en: 'Apply to Modified'
	String get applyToModified => 'Apply to Modified';

	/// en: 'Only fill empty targets'
	String get onlyFillEmptyTargets => 'Only fill empty targets';

	/// en: 'Limit to visible'
	String get limitToVisible => 'Limit to visible';

	/// en: 'Edit Mode'
	String get editMode => 'Edit Mode';

	/// en: 'Dialog'
	String get dialog => 'Dialog';

	/// en: 'Inline'
	String get inline => 'Inline';
}

// Path: advancedDiff.sidebar.similaritySection
class TranslationsAdvancedDiffSidebarSimilaritySectionEn {
	TranslationsAdvancedDiffSidebarSimilaritySectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Current Filter:'
	String get currentFilter => 'Current Filter:';

	/// en: 'ANY'
	String get any => 'ANY';

	/// en: 'HIGH'
	String get high => 'HIGH';

	/// en: 'MEDIUM'
	String get medium => 'MEDIUM';

	/// en: 'LOW'
	String get low => 'LOW';
}

// Path: advancedDiff.sidebar.statusSection
class TranslationsAdvancedDiffSidebarStatusSectionEn {
	TranslationsAdvancedDiffSidebarStatusSectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${count} total'
	String total({required Object count}) => '${count} total';

	/// en: '${count} extra'
	String extra({required Object count}) => '${count} extra';

	/// en: '${count} missing'
	String missing({required Object count}) => '${count} missing';

	/// en: '${count} changed'
	String changed({required Object count}) => '${count} changed';
}

// Path: tutorial.steps.importSource
class TranslationsTutorialStepsImportSourceEn {
	TranslationsTutorialStepsImportSourceEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '1. Import Source File'
	String get title => '1. Import Source File';

	/// en: 'Use the button below to browse for a file, or drag & drop onto the highlighted area.'
	String get description => 'Use the button below to browse for a file, or drag & drop onto the highlighted area.';
}

// Path: tutorial.steps.importTarget
class TranslationsTutorialStepsImportTargetEn {
	TranslationsTutorialStepsImportTargetEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '2. Import Target File'
	String get title => '2. Import Target File';

	/// en: 'Use the button below to browse for a file, or drag & drop onto the highlighted area.'
	String get description => 'Use the button below to browse for a file, or drag & drop onto the highlighted area.';
}

// Path: tutorial.steps.compare
class TranslationsTutorialStepsCompareEn {
	TranslationsTutorialStepsCompareEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '3. Compare Files'
	String get title => '3. Compare Files';

	/// en: 'Tap the button below to run the comparison and see the results.'
	String get description => 'Tap the button below to run the comparison and see the results.';
}

// Path: tutorial.steps.filter
class TranslationsTutorialStepsFilterEn {
	TranslationsTutorialStepsFilterEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '4. Filter Results'
	String get title => '4. Filter Results';

	/// en: 'Use these filters to view Added, Removed, or Modified strings.'
	String get description => 'Use these filters to view Added, Removed, or Modified strings.';
}

// Path: tutorial.steps.search
class TranslationsTutorialStepsSearchEn {
	TranslationsTutorialStepsSearchEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '5. Search Results'
	String get title => '5. Search Results';

	/// en: 'Find specific keys or values using the search bar.'
	String get description => 'Find specific keys or values using the search bar.';
}

// Path: tutorial.steps.advanced
class TranslationsTutorialStepsAdvancedEn {
	TranslationsTutorialStepsAdvancedEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '6. Advanced View'
	String get title => '6. Advanced View';

	/// en: 'Open the detailed diff view with editing, AI translation, and more.'
	String get description => 'Open the detailed diff view with editing, AI translation, and more.';
}

// Path: tutorial.steps.export
class TranslationsTutorialStepsExportEn {
	TranslationsTutorialStepsExportEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '7. Export Results'
	String get title => '7. Export Results';

	/// en: 'Save your comparison as CSV, JSON, or Excel file.'
	String get description => 'Save your comparison as CSV, JSON, or Excel file.';
}

// Path: settings.developer.themePlaygroundSection.palette
class TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
	TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Primary'
	String get primary => 'Primary';

	/// en: 'On Primary'
	String get onPrimary => 'On Primary';

	/// en: 'Secondary'
	String get secondary => 'Secondary';

	/// en: 'On Secondary'
	String get onSecondary => 'On Secondary';

	/// en: 'Surface'
	String get surface => 'Surface';

	/// en: 'On Surface'
	String get onSurface => 'On Surface';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'On Error'
	String get onError => 'On Error';

	/// en: 'Outline'
	String get outline => 'Outline';

	/// en: 'Shadow'
	String get shadow => 'Shadow';

	/// en: 'Success'
	String get success => 'Success';

	/// en: 'Warning'
	String get warning => 'Warning';

	/// en: 'Info'
	String get info => 'Info';
}

// Path: settings.developer.featureFlags.flags
class TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
	TranslationsSettingsDeveloperFeatureFlagsFlagsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn experimental_ai_batch = TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn.internal(_root);
	late final TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn new_diff_algorithm = TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn.internal(_root);
	late final TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn enhanced_search = TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn.internal(_root);
	late final TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn auto_save = TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn.internal(_root);
}

// Path: settings.onboarding.steps.importFiles
class TranslationsSettingsOnboardingStepsImportFilesEn {
	TranslationsSettingsOnboardingStepsImportFilesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Import Files'
	String get title => 'Import Files';

	/// en: 'Load source & target files'
	String get description => 'Load source & target files';
}

// Path: settings.onboarding.steps.runComparison
class TranslationsSettingsOnboardingStepsRunComparisonEn {
	TranslationsSettingsOnboardingStepsRunComparisonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Run Comparison'
	String get title => 'Run Comparison';

	/// en: 'Click "Compare Files"'
	String get description => 'Click "Compare Files"';
}

// Path: settings.onboarding.steps.reviewMissing
class TranslationsSettingsOnboardingStepsReviewMissingEn {
	TranslationsSettingsOnboardingStepsReviewMissingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Review Missing Keys'
	String get title => 'Review Missing Keys';

	/// en: 'Notice red MISSING items'
	String get description => 'Notice red MISSING items';
}

// Path: settings.onboarding.steps.useFilters
class TranslationsSettingsOnboardingStepsUseFiltersEn {
	TranslationsSettingsOnboardingStepsUseFiltersEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Use Filters'
	String get title => 'Use Filters';

	/// en: 'Filter by type'
	String get description => 'Filter by type';
}

// Path: settings.onboarding.steps.searchResults
class TranslationsSettingsOnboardingStepsSearchResultsEn {
	TranslationsSettingsOnboardingStepsSearchResultsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search Results'
	String get title => 'Search Results';

	/// en: 'Find specific keys'
	String get description => 'Find specific keys';
}

// Path: settings.onboarding.steps.advancedView
class TranslationsSettingsOnboardingStepsAdvancedViewEn {
	TranslationsSettingsOnboardingStepsAdvancedViewEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Advanced View'
	String get title => 'Advanced View';

	/// en: 'Explore detailed analysis'
	String get description => 'Explore detailed analysis';
}

// Path: settings.onboarding.steps.editCell
class TranslationsSettingsOnboardingStepsEditCellEn {
	TranslationsSettingsOnboardingStepsEditCellEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit a Cell'
	String get title => 'Edit a Cell';

	/// en: 'Click to edit a value'
	String get description => 'Click to edit a value';
}

// Path: settings.onboarding.steps.exportResults
class TranslationsSettingsOnboardingStepsExportResultsEn {
	TranslationsSettingsOnboardingStepsExportResultsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Export'
	String get title => 'Export';

	/// en: 'Save your report'
	String get description => 'Save your report';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
	TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Experimental AI Batch'
	String get name => 'Experimental AI Batch';

	/// en: 'Enable batch AI translation for multiple rows'
	String get description => 'Enable batch AI translation for multiple rows';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
	TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New Diff Algorithm'
	String get name => 'New Diff Algorithm';

	/// en: 'Use improved diffing algorithm for comparisons'
	String get description => 'Use improved diffing algorithm for comparisons';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
	TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enhanced Search'
	String get name => 'Enhanced Search';

	/// en: 'Enable fuzzy search in translation files'
	String get description => 'Enable fuzzy search in translation files';
}

// Path: settings.developer.featureFlags.flags.auto_save
class TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
	TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Auto Save'
	String get name => 'Auto Save';

	/// en: 'Automatically save changes after edits'
	String get description => 'Automatically save changes after edits';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'Localization Comparison Tool',
			'app.name' => 'Localizer',
			'common.save' => 'Save',
			'common.cancel' => 'Cancel',
			'common.close' => 'Close',
			'common.delete' => 'Delete',
			'common.edit' => 'Edit',
			'common.add' => 'Add',
			'common.search' => 'Search',
			'common.undo' => 'Undo',
			'common.loading' => 'Loading...',
			'common.error' => 'Error',
			'common.success' => 'Success',
			'common.warning' => 'Warning',
			'common.info' => 'Info',
			'common.confirm' => 'Confirm',
			'common.yes' => 'Yes',
			'common.no' => 'No',
			'common.ok' => 'OK',
			'common.retry' => 'Retry',
			'common.copyText' => 'Copy',
			'common.appName' => 'Localizer',
			'common.copied' => 'Copied!',
			'common.enabled' => 'Enabled',
			'common.disabled' => 'Disabled',
			'common.browse' => 'Browse',
			'common.clear' => 'Clear',
			'common.apply' => 'Apply',
			'common.reset' => 'Reset',
			'common.refresh' => 'Refresh',
			'common.export' => 'Export',
			'common.import' => 'Import',
			'common.select' => 'Select',
			'common.selectAll' => 'Select All',
			'common.deselectAll' => 'Deselect All',
			'common.noResults' => 'No results found',
			'common.emptyState' => 'Nothing here yet',
			'common.open' => 'Open',
			'common.change' => 'Change',
			'common.original' => 'Original',
			'common.kNew' => 'New',
			'common.remove' => 'Remove',
			'common.auto' => 'Auto',
			'common.execute' => 'Execute',
			'common.run' => 'Run',
			'common.unknown' => 'Unknown',
			'common.download' => 'Download',
			'common.dropdownArrow' => 'Dropdown arrow',
			'common.openInNewWindow' => 'Opens in new window',
			'common.resetToDefaults' => 'Reset to defaults',
			'menu.file' => 'File',
			'menu.edit' => 'Edit',
			'menu.view' => 'View',
			'menu.help' => 'Help',
			'menu.openFiles' => 'Open Files...',
			'menu.openFolder' => 'Open Folder...',
			'menu.exportResults' => 'Export Results...',
			'menu.undo' => 'Undo',
			'menu.redo' => 'Redo',
			'menu.cut' => 'Cut',
			'menu.paste' => 'Paste',
			'menu.selectAll' => 'Select All',
			'menu.zoomIn' => 'Zoom In',
			'menu.zoomOut' => 'Zoom Out',
			'menu.resetZoom' => 'Reset Zoom',
			'menu.documentation' => 'Documentation',
			'menu.reportIssue' => 'Report an Issue',
			'menu.about' => ({required Object appName}) => 'About ${appName}',
			'nav.compare' => 'Compare',
			'nav.history' => 'History',
			'nav.settings' => 'Settings',
			'nav.projects' => 'Projects',
			'nav.dashboard' => 'Dashboard',
			'nav.directory' => 'Directory',
			'nav.repository' => 'Repository',
			'nav.tooltipCompare' => 'Compare localization files',
			'nav.tooltipHistory' => 'View comparison history',
			'nav.tooltipSettings' => 'App settings',
			'nav.tooltipProjects' => 'Manage projects',
			'nav.tooltipThemeToggle' => 'Toggle Theme',
			'nav.tooltipDebugConsole' => 'Debug Console',
			'settings.title' => 'Settings',
			'settings.appSettings' => 'App Settings',
			'settings.projectSettings' => 'Project Settings',
			'settings.appearance.title' => 'Appearance',
			'settings.appearance.description' => 'Customize the look and feel of the app',
			'settings.appearance.theme' => 'Theme Mode',
			'settings.appearance.themeDescription' => 'Choose between light, dark, or system theme',
			'settings.appearance.themeSystem' => 'System',
			'settings.appearance.themeLight' => 'Light',
			'settings.appearance.themeDark' => 'Dark',
			'settings.appearance.themeAmoled' => 'AMOLED',
			'settings.appearance.accentColor' => 'Accent Color',
			'settings.appearance.accentColorDescription' => 'Choose your preferred accent color',
			'settings.appearance.useMicaEffect' => 'Use Mica Effect',
			'settings.appearance.micaDescription' => 'Enable Windows 11 Mica transparency effect for a modern look',
			'settings.appearance.diffFontSize' => 'Diff Font Size',
			'settings.appearance.diffFontSizeDescription' => 'Adjust the font size of the comparison view',
			'settings.appearance.diffFontFamily' => 'Diff Font Family',
			'settings.appearance.diffFontFamilyDescription' => 'Font for comparison view',
			'settings.appearance.systemDefault' => 'System Default',
			'settings.appearance.pickAccentColor' => 'Pick Accent Color',
			'settings.appearance.diffColors' => 'Diff Colors',
			'settings.appearance.presetsTitle' => 'Presets',
			'settings.appearance.presets.presetDefault' => 'Default',
			'settings.appearance.presets.presetColorblind' => 'Colorblind-Friendly',
			'settings.appearance.presets.presetHighContrast' => 'High Contrast',
			'settings.appearance.presets.presetNord' => 'Nord',
			'settings.appearance.presets.presetSolarized' => 'Solarized',
			'settings.appearance.presets.presetMonokai' => 'Monokai',
			'settings.appearance.identical' => 'Identical',
			'settings.appearance.pickColorFor' => ({required Object label}) => 'Pick Color for ${label}',
			'settings.appearance.livePreview' => 'Live Preview',
			'settings.appearance.preview.step3Title' => 'onboarding.step3.title',
			'settings.appearance.preview.connectAccount' => '"Connect Your Account"',
			'settings.appearance.preview.loginHint' => 'deprecated.login_hint_v1',
			'settings.appearance.preview.enterCredentials' => '"Enter credentials"',
			'settings.appearance.preview.ctaButton' => 'checkout.cta_button',
			'settings.appearance.preview.buyNow' => '"Buy Now"',
			'settings.appearance.preview.completePurchase' => '"Complete Purchase"',
			'settings.appearance.preview.appNameKey' => 'common.app_name',
			'settings.appearance.preview.appNameValue' => '"Localizer"',
			'settings.general.title' => 'General',
			'settings.general.description' => 'General application settings',
			'settings.general.language' => 'Language',
			'settings.general.languageDescription' => 'Choose your preferred language',
			'settings.general.startMinimized' => 'Start Minimized to Tray',
			'settings.general.startMinimizedDescription' => 'Start the app minimized to the system tray',
			'settings.general.rememberWindowPosition' => 'Remember Window Position',
			'settings.general.rememberWindowPositionDescription' => 'Restore window size and position on startup',
			'settings.general.openLastProject' => 'Open Last Project on Startup',
			'settings.general.openLastProjectDescription' => 'Automatically open the last used project when the app starts',
			'settings.general.application' => 'Application',
			'settings.general.defaultView' => 'Default View',
			'settings.general.defaultViewDescription' => 'View to show on startup',
			'settings.general.autoCheckUpdates' => 'Auto-Check Updates',
			'settings.general.autoCheckUpdatesDescription' => 'Check for updates on startup',
			'settings.general.startupOptions' => 'Startup Options',
			'settings.general.languageAuto' => 'Auto-Detect',
			'settings.general.viewBasic' => 'File Comparison',
			'settings.general.viewHistory' => 'History',
			'settings.general.viewDashboard' => 'Quality Dashboard',
			'settings.general.viewDirectory' => 'Directory Comparison',
			'settings.general.viewLastUsed' => 'Last Used View',
			'settings.scope.title' => 'Settings Scope',
			'settings.scope.global' => 'Global Defaults',
			'settings.scope.project' => 'Project',
			'settings.scope.reset' => 'Reset Project to Global Defaults',
			'settings.scope.resetConfirmation' => 'This will clear all overrides for this project and revert to global defaults. This action cannot be undone.',
			'settings.scope.globalDescription' => 'Changes apply to all projects unless overridden.',
			'settings.scope.projectDescription' => ({required Object name}) => 'Changes apply only to "${name}". Other settings inherit from global defaults.',
			'settings.scope.createPrompt' => 'Create a project to customize settings for specific folders',
			'settings.searchKeywords.general.0' => 'Language',
			'settings.searchKeywords.general.1' => 'Default View',
			'settings.searchKeywords.general.2' => 'Recent Files Count',
			'settings.searchKeywords.general.3' => 'Open Last Project',
			'settings.searchKeywords.general.4' => 'Confirm Before Exit',
			'settings.searchKeywords.general.5' => 'Show Notifications',
			'settings.searchKeywords.comparisonEngine.0' => 'Comparison Mode',
			'settings.searchKeywords.comparisonEngine.1' => 'Similarity Threshold',
			'settings.searchKeywords.comparisonEngine.2' => 'Case Sensitive',
			'settings.searchKeywords.comparisonEngine.3' => 'Ignore Whitespace',
			'settings.searchKeywords.comparisonEngine.4' => 'Ignore Empty Lines',
			'settings.searchKeywords.comparisonEngine.5' => 'Ignore Comments',
			'settings.searchKeywords.comparisonEngine.6' => 'Ignore Patterns',
			'settings.searchKeywords.appearance.0' => 'Theme',
			'settings.searchKeywords.appearance.1' => 'Theme Mode',
			'settings.searchKeywords.appearance.2' => 'Accent Color',
			'settings.searchKeywords.appearance.3' => 'Diff Font Size',
			'settings.searchKeywords.appearance.4' => 'Diff Font Family',
			'settings.searchKeywords.appearance.5' => 'Diff Colors',
			'settings.searchKeywords.appearance.6' => 'Added Color',
			'settings.searchKeywords.appearance.7' => 'Removed Color',
			'settings.searchKeywords.appearance.8' => 'Modified Color',
			'settings.searchKeywords.appearance.9' => 'Identical Color',
			'settings.searchKeywords.appearance.10' => 'Color Presets',
			'settings.searchKeywords.appearance.11' => 'Preview',
			'settings.searchKeywords.fileHandling.0' => 'Source Format',
			'settings.searchKeywords.fileHandling.1' => 'Target Format',
			'settings.searchKeywords.fileHandling.2' => 'Default Encoding',
			'settings.searchKeywords.fileHandling.3' => 'Recent Project Count',
			'settings.searchKeywords.fileHandling.4' => 'Translation Memory',
			'settings.searchKeywords.fileHandling.5' => 'Import Memory',
			'settings.searchKeywords.fileHandling.6' => 'Export Memory',
			'settings.searchKeywords.fileHandling.7' => 'Clear Memory',
			'settings.searchKeywords.aiServices.0' => 'OpenAI API Key',
			'settings.searchKeywords.aiServices.1' => 'Anthropic API Key',
			'settings.searchKeywords.aiServices.2' => 'Google AI API Key',
			'settings.searchKeywords.aiServices.3' => 'AI Model',
			'settings.searchKeywords.aiServices.4' => 'Temperature',
			'settings.searchKeywords.aiServices.5' => 'Custom Prompt',
			'settings.searchKeywords.systemIntegrations.0' => 'System Tray',
			'settings.searchKeywords.systemIntegrations.1' => 'Start Minimized',
			'settings.searchKeywords.systemIntegrations.2' => 'File Associations',
			'settings.searchKeywords.systemIntegrations.3' => 'Mica Effect',
			'settings.searchKeywords.systemIntegrations.4' => 'Vibrancy',
			'settings.searchKeywords.systemIntegrations.5' => 'Window Material',
			'settings.searchKeywords.systemIntegrations.6' => 'Dock Badge',
			'settings.searchKeywords.systemIntegrations.7' => 'Untranslated Count',
			'settings.searchKeywords.projectResources.0' => 'Glossary',
			'settings.searchKeywords.projectResources.1' => 'Translation Memory',
			'settings.searchKeywords.projectResources.2' => 'Terminology',
			'settings.searchKeywords.about.0' => 'Version',
			'settings.searchKeywords.about.1' => 'Check Updates',
			'settings.searchKeywords.about.2' => 'Auto Update',
			'settings.searchKeywords.about.3' => 'Changelog',
			'settings.searchKeywords.about.4' => 'License',
			'settings.searchKeywords.about.5' => 'Privacy Policy',
			'settings.searchKeywords.about.6' => 'Telemetry',
			'settings.searchKeywords.about.7' => 'Crash Reporting',
			'settings.searchKeywords.developer.0' => 'Performance Overlay',
			'settings.searchKeywords.developer.1' => 'Semantics Debugger',
			'settings.searchKeywords.developer.2' => 'Material Grid',
			'settings.searchKeywords.developer.3' => 'Raster Cache',
			'settings.searchKeywords.developer.4' => 'Restart Tutorial',
			'settings.searchKeywords.developer.5' => 'Factory Reset',
			'settings.comparison.title' => 'Comparison',
			'settings.comparison.description' => 'Configure comparison behavior',
			'settings.comparison.caseSensitive' => 'Case Sensitive',
			'settings.comparison.caseSensitiveDescription' => 'Treat uppercase and lowercase letters as different',
			'settings.comparison.ignoreWhitespace' => 'Ignore Whitespace',
			'settings.comparison.ignoreWhitespaceDescription' => 'Ignore leading/trailing whitespace when comparing',
			'settings.comparison.showLineNumbers' => 'Show Line Numbers',
			'settings.comparison.showLineNumbersDescription' => 'Display line numbers in the diff view',
			'settings.comparison.behavior' => 'Comparison Behavior',
			'settings.comparison.ignoreCase' => 'Ignore Case',
			'settings.comparison.ignoreCaseDescription' => 'Treat "Key" and "key" as the same',
			'settings.comparison.similarityThreshold' => 'Similarity Threshold',
			'settings.comparison.similarityThresholdDescription' => 'Minimum similarity for "Modified" detection',
			'settings.comparison.mode' => 'Comparison Mode',
			'settings.comparison.modeDescription' => 'How to match entries between files',
			'settings.comparison.modeKey' => 'Key-based',
			'settings.comparison.modeKeyDescription' => 'Matches by key name (default).',
			'settings.comparison.modeOrder' => 'Order-based',
			'settings.comparison.modeOrderDescription' => 'Matches by position in file.',
			'settings.comparison.modeSmart' => 'Smart Match',
			'settings.comparison.modeSmartDescription' => 'Detects moved/renamed keys.',
			'settings.comparison.ignorePatterns' => 'Ignore Patterns',
			'settings.comparison.noIgnorePatterns' => 'No ignore patterns set.',
			'settings.comparison.addPattern' => 'Add Pattern',
			'settings.comparison.resetToGlobal' => 'Reset all comparison settings to global defaults',
			'settings.comparison.patternPresets.comments' => 'Comments',
			'settings.comparison.patternPresets.tempKeys' => 'Temp Keys',
			'settings.comparison.patternPresets.placeholders' => 'Placeholders',
			'settings.comparison.patternPresets.devOnly' => 'Dev Only',
			'settings.comparison.previewMatch.title' => 'Preview Match',
			'settings.comparison.previewMatch.description' => 'Test how your current settings affect matching logic.',
			'settings.comparison.previewMatch.stringA' => 'String A',
			'settings.comparison.previewMatch.stringB' => 'String B',
			'settings.comparison.previewMatch.enterText' => 'Enter text...',
			'settings.comparison.previewMatch.similarity' => 'Similarity',
			'settings.comparison.previewMatch.identical' => 'Identical',
			'settings.comparison.previewMatch.identicalDescription' => 'Strings match exactly after normalization.',
			'settings.comparison.previewMatch.ignored' => 'Ignored',
			'settings.comparison.previewMatch.ignoredDescription' => 'Input matches an ignore pattern.',
			'settings.comparison.previewMatch.different' => 'Different',
			'settings.comparison.previewMatch.differentDescription' => 'One value is empty.',
			'settings.comparison.previewMatch.similarModified' => 'Similar / Modified',
			'settings.comparison.previewMatch.similarModifiedDescription' => ({required Object threshold}) => 'Match score is above threshold (${threshold}%).',
			'settings.comparison.previewMatch.newDifferent' => 'New / Different',
			'settings.comparison.previewMatch.newDifferentDescription' => ({required Object threshold}) => 'Match score is below threshold (${threshold}%).',
			'settings.comparison.colorPresets.kDefault' => 'Default',
			'settings.comparison.colorPresets.colorblindFriendly' => 'Colorblind-Friendly',
			'settings.comparison.colorPresets.highContrast' => 'High Contrast',
			'settings.comparison.colorPresets.nord' => 'Nord',
			'settings.comparison.colorPresets.solarized' => 'Solarized',
			'settings.comparison.colorPresets.monokai' => 'Monokai',
			'settings.comparison.colorPresets.presetDefault' => 'Default',
			'settings.comparison.colorPresets.presetColorblind' => 'Colorblind-Friendly',
			'settings.comparison.colorPresets.presetHighContrast' => 'High Contrast',
			'settings.comparison.colorPresets.presetNord' => 'Nord',
			'settings.comparison.colorPresets.presetSolarized' => 'Solarized',
			'settings.comparison.colorPresets.presetMonokai' => 'Monokai',
			'settings.fileHandling.fileFormats' => 'File Formats',
			'settings.fileHandling.sourceFormat' => 'Source Format',
			'settings.fileHandling.targetFormat' => 'Target Format',
			'settings.fileHandling.encoding' => 'Encoding',
			'settings.fileHandling.sourceEncoding' => 'Source Encoding',
			'settings.fileHandling.targetEncoding' => 'Target Encoding',
			'settings.fileHandling.autoDetect' => 'Auto-Detect',
			'settings.fileHandling.autoDetectEncodingDescription' => 'Automatically detect file encoding',
			'settings.fileHandling.exportSettings' => 'Export Settings',
			'settings.fileHandling.defaultExportFormat' => 'Default Export Format',
			'settings.fileHandling.includeUtf8Bom' => 'Include UTF-8 BOM',
			'settings.fileHandling.includeUtf8BomDescription' => 'Required for Excel compatibility',
			'settings.fileHandling.openFolderAfterExport' => 'Open Folder After Export',
			'settings.fileHandling.fileSafety' => 'File Safety',
			'settings.fileHandling.fileSafetyDescription' => 'Automatic local copies for disaster recovery.',
			'settings.fileHandling.resetToGlobal' => 'Reset all file handling settings to global defaults',
			'settings.translationMemory.title' => 'Global Translation Memory',
			'settings.translationMemory.autoLearn' => 'Auto-learn',
			'settings.translationMemory.autoLearnDescription' => 'Save translations to local memory for future reuse',
			'settings.translationMemory.confidenceThreshold' => 'Confidence Threshold',
			'settings.translationMemory.confidenceThresholdDescription' => ({required Object percent}) => 'Minimum score to auto-apply (${percent}%)',
			'settings.translationMemory.entries' => 'Entries',
			'settings.translationMemory.size' => 'Size',
			'settings.translationMemory.memorySize' => ({required Object size}) => 'Memory Size: ${size}',
			'settings.translationMemory.import' => 'Import',
			'settings.translationMemory.exportTmx' => 'Export TMX',
			'settings.translationMemory.exportCsv' => 'Export CSV',
			'settings.translationMemory.clearMemory' => 'Clear Memory',
			'settings.translationMemory.importedItems' => ({required Object count}) => 'Imported ${count} items into memory.',
			'settings.translationMemory.noItemsAdded' => 'No items were added.',
			'settings.translationMemory.nothingToExport' => 'Nothing to export yet.',
			'settings.translationMemory.tmxSaved' => 'TMX saved',
			'settings.translationMemory.csvSaved' => 'CSV saved',
			'settings.translationMemory.clearConfirmTitle' => 'Clear translation memory?',
			'settings.translationMemory.clearConfirmContent' => 'This removes all saved translation pairs on this device. This action cannot be undone.',
			'settings.translationMemory.cleared' => 'Translation memory cleared.',
			'settings.translationMemory.couldNotClear' => 'Could not clear memory.',
			'settings.backup.title' => 'Auto-Backup',
			'settings.backup.description' => 'Automatic backup settings',
			'settings.backup.enabled' => 'Enable Auto-Backup',
			'settings.backup.enabledDescription' => 'Automatically backup files before making changes',
			'settings.backup.maxCopies' => 'Maximum Backup Copies',
			'settings.backup.maxCopiesDescription' => 'Number of backup copies to keep per file',
			'settings.backup.activeStatus' => ({required Object count}) => 'Active · Keeping ${count} copies',
			'settings.backup.folder' => 'Backup Folder',
			'settings.backup.folderDescription' => 'Leave empty to use the same folder',
			'settings.backup.useOriginalFolder' => 'Use original file folder',
			'settings.ai.title' => 'AI Services',
			'settings.ai.description' => 'Configure AI translation and assistance',
			'settings.ai.provider' => 'AI Provider',
			'settings.ai.providerDescription' => 'Choose your preferred AI service provider',
			'settings.ai.apiKey' => 'API Key',
			'settings.ai.apiKeyDescription' => 'Enter your API key for the selected provider',
			'settings.ai.apiKeyPlaceholder' => 'Enter API key...',
			'settings.ai.testConnection' => 'Test Connection',
			'settings.ai.connectionSuccess' => 'Connection successful!',
			'settings.ai.connectionFailed' => 'Connection failed. Please check your API key.',
			'settings.ai.translationStrategy' => 'Translation Strategy',
			'settings.ai.strategy' => 'Strategy',
			'settings.ai.strategyDescription' => 'Select how you want to translate strings',
			'settings.ai.strategyLLM' => 'Generative AI (LLM)',
			'settings.ai.strategyCloud' => 'Cloud Translation',
			'settings.ai.enableAiTranslation' => 'Enable AI Translation',
			'settings.ai.enableAiTranslationDescription' => 'Allow the app to use AI for translation suggestions',
			'settings.ai.llmProvider' => 'LLM Service Provider',
			'settings.ai.service' => 'Service',
			'settings.ai.serviceDescription' => 'Provider for Generative AI',
			'settings.ai.providerGemini' => 'Google Gemini',
			'settings.ai.providerOpenAI' => 'OpenAI',
			'settings.ai.geminiApiKey' => 'Gemini API Key',
			'settings.ai.openAiApiKey' => 'OpenAI API Key',
			'settings.ai.model' => 'Model',
			'settings.ai.modelDescription' => 'Select which model to use',
			'settings.ai.advancedParameters' => 'Advanced Parameters',
			'settings.ai.parameters' => 'Parameters',
			'settings.ai.parametersDescription' => 'Temperature, Context, and more',
			'settings.ai.temperature' => 'Temperature',
			'settings.ai.temperatureDescription' => 'Higher values make output more creative',
			'settings.ai.maxTokens' => 'Max Tokens',
			'settings.ai.maxTokensDescription' => 'Limit context window length',
			'settings.ai.systemContext' => 'System Context / Instructions',
			'settings.ai.systemContextHint' => 'You are a professional localizer. Maintain the tone and intent of the source string...',
			'settings.ai.systemContextHelper' => 'Provide specific instructions to the AI about your project\'s style and terminology.',
			'settings.ai.contextStrings' => 'Context Strings',
			'settings.ai.contextStringsDescription' => 'Include surrounding strings for better context',
			'settings.ai.contextCount' => 'Context Count',
			'settings.ai.contextCountDescription' => 'Number of surrounding strings to include',
			'settings.ai.cloudServices' => 'Cloud Translation Services',
			'settings.ai.googleTranslateApiKey' => 'Google Translate API Key',
			'settings.ai.deeplApiKey' => 'DeepL API Key',
			'settings.ai.test' => 'Test',
			'settings.ai.resetToGlobal' => 'Reset all AI settings to global defaults',
			'settings.integrations.platformNotice' => 'Platform Notice',
			'settings.integrations.platformNoticeDescription' => 'System integrations are not available for this platform.',
			'settings.integrations.visualEffects' => 'Visual Effects',
			'settings.integrations.explorerIntegration' => 'Explorer Integration',
			'settings.integrations.explorerIntegrationDescription' => 'Add "Open with Localizer" to the Windows Explorer right-click menu for folders.',
			'settings.integrations.addToContextMenu' => 'Add to Context Menu',
			'settings.integrations.contextMenuAdded' => 'Context menu added!',
			'settings.integrations.contextMenuAddError' => 'Failed to add context menu',
			'settings.integrations.contextMenuRemoved' => 'Context menu removed!',
			'settings.integrations.contextMenuRemoveError' => 'Failed to remove context menu',
			'settings.integrations.fileAssociations' => 'File Associations',
			'settings.integrations.fileAssociationsDescription' => 'Register file types to open with Localizer when double-clicked in Explorer.',
			'settings.integrations.registered' => 'Registered',
			'settings.integrations.notRegistered' => 'Not Registered',
			'settings.integrations.extRegistered' => ({required Object ext}) => '${ext} registered!',
			'settings.integrations.extUnregistered' => ({required Object ext}) => '${ext} unregistered!',
			'settings.integrations.extError' => ({required Object action, required Object ext}) => 'Failed to ${action} ${ext}',
			'settings.integrations.registerAll' => 'Register All',
			'settings.integrations.unregisterAll' => 'Unregister All',
			'settings.integrations.registerAllResult' => ({required Object success, required Object total}) => 'Registered ${success} of ${total} file types',
			'settings.integrations.unregisterAllResult' => ({required Object success, required Object total}) => 'Unregistered ${success} of ${total} file types',
			'settings.integrations.protocolHandler' => 'Protocol Handler',
			'settings.integrations.protocolHandlerDescription' => 'Register localizer:// URLs to open this application. Allows opening projects directly from browser links or other apps.',
			'settings.integrations.protocolRegistered' => 'Protocol handler is registered',
			'settings.integrations.protocolNotRegistered' => 'Protocol handler not registered',
			'settings.integrations.registerProtocol' => 'Register Protocol',
			'settings.integrations.unregister' => 'Unregister',
			'settings.integrations.protocolRegisteredSuccess' => 'Protocol handler registered!',
			'settings.integrations.protocolRemovedSuccess' => 'Protocol handler removed!',
			'settings.integrations.protocolRegisterError' => 'Failed to register',
			'settings.integrations.protocolRemoveError' => 'Failed to remove',
			'settings.integrations.windowMaterial' => 'Window Material',
			'settings.integrations.windowMaterialDescription' => 'Select the macOS vibrancy material style',
			'settings.integrations.dockIntegration' => 'Dock Integration',
			'settings.integrations.showDockBadge' => 'Show Untranslated Count',
			'settings.integrations.showDockBadgeDescription' => 'Display untranslated string count on the dock icon badge',
			'settings.integrations.materials.sidebar' => 'Sidebar',
			'settings.integrations.materials.menu' => 'Menu',
			'settings.integrations.materials.popover' => 'Popover',
			'settings.integrations.materials.titlebar' => 'Titlebar',
			'settings.integrations.materials.underPageBackground' => 'Page Background',
			'settings.integrations.materials.contentBackground' => 'Content',
			'settings.integrations.fileTypes.loc' => 'Localizer Project File',
			'settings.integrations.fileTypes.lang' => 'Language File',
			'settings.integrations.fileTypes.json' => 'JSON Localization File',
			'settings.integrations.fileTypes.xml' => 'XML Localization File',
			'settings.developer.title' => 'Developer Settings',
			'settings.developer.description' => 'Advanced settings for developers',
			'settings.developer.showLocalizationKeys' => 'Show Localization Keys',
			'settings.developer.localizationKeysDescription' => 'When enabled, all translated text will show their localization keys instead of the translated value. Useful for verifying which key is used where.',
			'settings.developer.showPerformanceOverlay' => 'Show Performance Overlay',
			'settings.developer.performanceOverlayDescription' => 'Display FPS and frame timing information',
			'settings.developer.debugMode' => 'Debug Mode',
			'settings.developer.debugModeDescription' => 'Enable additional logging and debug features',
			'settings.developer.debuggingTools' => 'Debugging Tools',
			'settings.developer.semanticsDebugger' => 'Semantics Debugger',
			'settings.developer.semanticsDebuggerDescription' => 'Visualize semantics tree',
			'settings.developer.materialGrid' => 'Material Grid',
			'settings.developer.materialGridDescription' => 'Overlay material layout grid',
			'settings.developer.rasterCache' => 'Raster Cache Images',
			'settings.developer.rasterCacheDescription' => 'Checkerboard raster cache images',
			'settings.developer.actions' => 'Actions',
			'settings.developer.showLogs' => 'Show App Logs',
			'settings.developer.showLogsDescription' => 'Open Talker debug console',
			'settings.developer.restartTutorial' => 'Restart Onboarding Tutorial',
			'settings.developer.restartTutorialDescription' => 'Reset flags and launch tutorial again',
			'settings.developer.restartRequested' => 'Tutorial restart requested.',
			'settings.developer.throwException' => 'Throw Test Exception',
			'settings.developer.throwExceptionDescription' => 'Trigger a test exception for crash reporting',
			'settings.developer.testExceptionMessage' => 'Test Exception triggered from Developer Options',
			'settings.developer.clearTM' => 'Clear Translation Memory',
			'settings.developer.clearTMDescription' => 'Delete all cached translations',
			'settings.developer.clearTMConfirmation' => 'Clear Translation Memory?',
			'settings.developer.clearTMWarning' => 'This will delete all learned translations. This cannot be undone.',
			'settings.developer.tmCleared' => 'Translation memory cleared',
			'settings.developer.clearApiKeys' => 'Clear API Keys',
			'settings.developer.clearApiKeysDescription' => 'Remove all stored API keys',
			'settings.developer.clearApiKeysConfirmation' => 'Clear API Keys?',
			'settings.developer.clearApiKeysWarning' => 'This will remove all API keys from secure storage.',
			'settings.developer.apiKeysCleared' => 'API keys cleared',
			'settings.developer.hideOptions' => 'Hide Developer Options',
			'settings.developer.hideOptionsDescription' => 'Disable developer mode (requires 7 taps to re-enable)',
			'settings.developer.optionsDisabled' => 'Developer options disabled',
			'settings.developer.dangerZone' => 'Danger Zone',
			'settings.developer.factoryReset' => 'Factory Reset',
			'settings.developer.factoryResetDescription' => 'Reset all settings and clear data',
			'settings.developer.factoryResetWarning' => 'Are you sure you want to reset all settings? This action cannot be undone.',
			'settings.developer.inspectionTools' => 'Inspection Tools',
			'settings.developer.searchHint' => 'Search settings...',
			'settings.developer.resetToDefault' => 'Reset to defaults',
			'settings.developer.resetToGlobal' => 'Reset to global default',
			'settings.developer.storageInspector' => 'Storage Inspector',
			'settings.developer.storageInspectorDescription' => 'View Hive & Secure Storage contents',
			'settings.developer.deviceEnvironment' => 'Device & Environment',
			'settings.developer.deviceEnvironmentDescription' => 'Screen, platform, and build info',
			'settings.developer.themePlayground' => 'Theme Playground',
			'settings.developer.themePlaygroundDescription' => 'Color palette & typography',
			'settings.developer.themePlaygroundSection.colors' => 'Colors',
			'settings.developer.themePlaygroundSection.typography' => 'Typography',
			'settings.developer.themePlaygroundSection.palette.primary' => 'Primary',
			'settings.developer.themePlaygroundSection.palette.onPrimary' => 'On Primary',
			'settings.developer.themePlaygroundSection.palette.secondary' => 'Secondary',
			'settings.developer.themePlaygroundSection.palette.onSecondary' => 'On Secondary',
			'settings.developer.themePlaygroundSection.palette.surface' => 'Surface',
			'settings.developer.themePlaygroundSection.palette.onSurface' => 'On Surface',
			'settings.developer.themePlaygroundSection.palette.error' => 'Error',
			'settings.developer.themePlaygroundSection.palette.onError' => 'On Error',
			'settings.developer.themePlaygroundSection.palette.outline' => 'Outline',
			'settings.developer.themePlaygroundSection.palette.shadow' => 'Shadow',
			'settings.developer.themePlaygroundSection.palette.success' => 'Success',
			'settings.developer.themePlaygroundSection.palette.warning' => 'Warning',
			'settings.developer.themePlaygroundSection.palette.info' => 'Info',
			'settings.developer.localizationInspector' => 'Localization Inspector',
			'settings.developer.localizationInspectorDescription' => 'Debug translation strings',
			'settings.developer.hiveAppSettings' => 'Hive (AppSettings)',
			'settings.developer.secureStorageMasked' => 'Secure Storage (Masked)',
			'settings.developer.featureFlags.title' => 'Experimental Features',
			'settings.developer.featureFlags.description' => 'Toggle feature flags locally for testing. These overrides persist across app restarts.',
			'settings.developer.featureFlags.subtitle' => 'Override experimental features',
			'settings.developer.featureFlags.flags.experimental_ai_batch.name' => 'Experimental AI Batch',
			'settings.developer.featureFlags.flags.experimental_ai_batch.description' => 'Enable batch AI translation for multiple rows',
			'settings.developer.featureFlags.flags.new_diff_algorithm.name' => 'New Diff Algorithm',
			'settings.developer.featureFlags.flags.new_diff_algorithm.description' => 'Use improved diffing algorithm for comparisons',
			'settings.developer.featureFlags.flags.enhanced_search.name' => 'Enhanced Search',
			'settings.developer.featureFlags.flags.enhanced_search.description' => 'Enable fuzzy search in translation files',
			'settings.developer.featureFlags.flags.auto_save.name' => 'Auto Save',
			'settings.developer.featureFlags.flags.auto_save.description' => 'Automatically save changes after edits',
			'settings.developer.featureFlags.reset' => 'Reset All Flags',
			'settings.developer.featureFlags.overrides' => 'Local Overrides',
			'settings.developer.featureFlags.defaultVal' => 'Default',
			'settings.developer.featureFlags.on' => 'ON',
			'settings.developer.featureFlags.off' => 'OFF',
			'settings.developer.storageInspectorSection.refresh' => 'Refresh',
			'settings.developer.storageInspectorSection.hiveData' => 'Hive Data',
			'settings.developer.storageInspectorSection.secureStorage' => 'Secure Storage',
			'settings.developer.deviceInfoSection.refresh' => 'Refresh',
			'settings.developer.deviceInfoSection.copy' => 'Copy to Clipboard',
			'settings.developer.deviceInfoSection.computerName' => 'Computer Name',
			'settings.developer.deviceInfoSection.osVersion' => 'OS Version',
			'settings.developer.localizationInspectorSection.showKeys' => 'Show Keys Instead of Values',
			'settings.developer.localizationInspectorSection.keysVisible' => 'Keys visible',
			'settings.developer.localizationInspectorSection.normalDisplay' => 'Normal display',
			'settings.developer.localizationInspectorSection.note' => 'Note: This feature requires app localization to use a wrapper that respects this setting.',
			'settings.about.title' => 'About',
			'settings.about.version' => 'Version',
			'settings.about.buildNumber' => 'Build Number',
			'settings.about.author' => 'Author',
			_ => null,
		} ?? switch (path) {
			'settings.about.license' => 'License',
			'settings.about.sourceCode' => 'Source Code',
			'settings.about.reportBug' => 'Report a Bug',
			'settings.about.requestFeature' => 'Request a Feature',
			'settings.about.checkForUpdates' => 'Check for Updates',
			'settings.about.upToDate' => 'You\'re up to date!',
			'settings.about.updateAvailable' => ({required Object version}) => 'Update available: ${version}',
			'settings.about.updateAvailableBadge' => 'Update Available!',
			'settings.about.developerSteps' => ({required Object count}) => 'You are ${count} steps away from being a developer.',
			'settings.about.developerActivated' => 'You are now a developer!',
			'settings.about.neverChecked' => 'Never',
			'settings.about.applicationInfo' => 'Application Info',
			'settings.about.platform' => 'Platform',
			'settings.about.updateInformation' => 'Update Information',
			'settings.about.currentVersion' => 'Current Version',
			'settings.about.latestVersion' => 'Latest Version',
			'settings.about.lastChecked' => 'Last Checked',
			'settings.about.checkingForUpdates' => 'Checking...',
			'settings.about.whatsNew' => 'What\'s New',
			'settings.about.systemInformation' => 'System Information',
			'settings.about.dartVersion' => 'Dart Version',
			'settings.about.diskSpace' => 'Available Disk Space',
			'settings.about.memoryUsage' => 'Memory Usage',
			'settings.about.privacyTitle' => 'Privacy & Telemetry',
			'settings.about.usageStats' => 'Anonymous Usage Statistics',
			'settings.about.requiresFirebase' => 'Requires Firebase configuration',
			'settings.about.featureUnavailable' => 'Feature currently unavailable (Requires Firebase)',
			'settings.about.settingsManagement' => 'Settings Management',
			'settings.about.settingsManagementDescription' => 'Export your settings to a file to back them up or share with other machines.',
			'settings.about.resetAll' => 'Reset All',
			'settings.about.links' => 'Links',
			'settings.about.githubRepo' => 'GitHub Repository',
			'settings.about.privacyPolicy' => 'Privacy Policy',
			'settings.about.crashReporting' => 'Crash Reporting',
			'settings.onboarding.skipTutorial' => 'Skip Tutorial',
			'settings.onboarding.gettingStarted' => 'Getting Started',
			'settings.onboarding.stepProgress' => ({required Object current, required Object total}) => '${current} of ${total}',
			'settings.onboarding.loadSampleData' => 'Load Sample Data',
			'settings.onboarding.steps.importFiles.title' => 'Import Files',
			'settings.onboarding.steps.importFiles.description' => 'Load source & target files',
			'settings.onboarding.steps.runComparison.title' => 'Run Comparison',
			'settings.onboarding.steps.runComparison.description' => 'Click "Compare Files"',
			'settings.onboarding.steps.reviewMissing.title' => 'Review Missing Keys',
			'settings.onboarding.steps.reviewMissing.description' => 'Notice red MISSING items',
			'settings.onboarding.steps.useFilters.title' => 'Use Filters',
			'settings.onboarding.steps.useFilters.description' => 'Filter by type',
			'settings.onboarding.steps.searchResults.title' => 'Search Results',
			'settings.onboarding.steps.searchResults.description' => 'Find specific keys',
			'settings.onboarding.steps.advancedView.title' => 'Advanced View',
			'settings.onboarding.steps.advancedView.description' => 'Explore detailed analysis',
			'settings.onboarding.steps.editCell.title' => 'Edit a Cell',
			'settings.onboarding.steps.editCell.description' => 'Click to edit a value',
			'settings.onboarding.steps.exportResults.title' => 'Export',
			'settings.onboarding.steps.exportResults.description' => 'Save your report',
			'settings.settingsView.resetCategoryTitle' => ({required Object category}) => 'Reset ${category}?',
			'settings.settingsView.resetCategoryContent' => 'This will reset all settings in this category to their default values.',
			'settings.settingsView.resetAllTitle' => 'Reset All Settings?',
			'settings.settingsView.resetAllContent' => 'This will permanently reset all settings to their factory defaults. This action cannot be undone.',
			'settings.settingsView.resetAll' => 'Reset All',
			'settings.settingsView.resetSuccess' => ({required Object category}) => '${category} reset to defaults',
			'settings.settingsView.errorLoading' => 'Error loading settings',
			'settings.settingsView.settingsSaved' => 'Settings saved',
			'settings.settingsView.updateAvailable' => ({required Object version}) => 'Update available: v${version}',
			'settings.settingsView.latestVersion' => 'You are using the latest version',
			'settings.settingsView.whatsNew' => ({required Object version}) => 'What\'s New in v${version}',
			'settings.settingsView.downloadUpdate' => 'Download Update',
			'settings.settingsView.exportSettings' => 'Export Settings',
			'settings.settingsView.settingsExported' => 'Settings exported',
			'settings.settingsView.exportFail' => ({required Object error}) => 'Failed to export settings: ${error}',
			'settings.settingsView.importSettings' => 'Import Settings',
			'settings.settingsView.importTitle' => 'Import Settings?',
			'settings.settingsView.importContent' => 'This will replace all your current settings with the imported ones. This action cannot be undone.',
			'settings.settingsView.importSuccess' => 'Settings imported successfully!',
			'settings.settingsView.importFail' => ({required Object error}) => 'Failed to import settings: ${error}',
			'settings.settingsView.invalidFormat' => 'Invalid settings file format',
			'settings.settingsView.categories.general' => 'General Settings',
			'settings.settingsView.categories.comparisonEngine' => 'Comparison Engine',
			'settings.settingsView.categories.appearance' => 'Appearance',
			'settings.settingsView.categories.fileHandling' => 'File Handling',
			'settings.settingsView.categories.aiServices' => 'AI Services',
			'settings.settingsView.categories.systemIntegrations' => 'System Integrations',
			'settings.settingsView.categories.projectResources' => 'Project Resources (Glossary & TM)',
			'settings.settingsView.categories.developer' => 'Developer Options',
			'settings.settingsView.categories.about' => 'About',
			'settings.settingsView.categoryLabels.general' => 'General',
			'settings.settingsView.categoryLabels.comparisonEngine' => 'Comparison',
			'settings.settingsView.categoryLabels.appearance' => 'Appearance',
			'settings.settingsView.categoryLabels.fileHandling' => 'File Handling',
			'settings.settingsView.categoryLabels.aiServices' => 'AI Services',
			'settings.settingsView.categoryLabels.systemIntegrations' => 'System Integrations',
			'settings.settingsView.categoryLabels.projectResources' => 'Project Resources',
			'settings.settingsView.categoryLabels.developer' => 'Developer Options',
			'settings.settingsView.categoryLabels.about' => 'About',
			'fileComparison.title' => 'File Comparison',
			'fileComparison.openFiles' => 'Open Files',
			'fileComparison.exportResults' => 'Export Results',
			'fileComparison.restartTutorial' => 'Restart Tutorial',
			'fileComparison.restartTutorialDevOnly' => 'Tutorial restart is available in developer mode only.',
			'fileComparison.unsupportedFileType' => 'Unsupported file type.',
			'fileComparison.unsupportedFileTypeSuggestion' => 'Please select a supported localization file.',
			'fileComparison.someFilesUnsupported' => 'Some files are not supported.',
			'fileComparison.pickSupportedFiles' => 'Pick supported localization files only.',
			'fileComparison.pickTwoFiles' => 'Pick two files to compare.',
			'fileComparison.pickBilingualFile' => 'Please select a bilingual file to compare.',
			'fileComparison.noResultsToExport' => 'No results to export yet.',
			'fileComparison.performComparisonFirst' => 'Perform a comparison first to export results.',
			'fileComparison.performComparisonFirstEditor' => 'Please perform a comparison first to see advanced details.',
			'fileComparison.sampleDataLoaded' => 'Sample data loaded successfully',
			'fileComparison.loadSampleDataError' => ({required Object error}) => 'Failed to load sample data: ${error}',
			'fileComparison.invalidFileType' => 'Invalid file type.',
			'fileComparison.fileSelected' => ({required Object label, required Object fileName}) => '${label} selected: ${fileName}',
			'fileComparison.sourceFile' => 'Source file',
			'fileComparison.targetFile' => 'Target file',
			'fileComparison.bilingualFile' => 'Bilingual file',
			'fileComparison.compareFiles' => 'Compare Files',
			'fileComparison.compareFile' => 'Compare File',
			'fileComparison.bilingualMode' => 'Bilingual Mode',
			'fileComparison.twoFilesMode' => 'Two Files',
			'fileComparison.processing' => 'Processing...',
			'fileComparison.remaining' => ({required Object time}) => '${time} remaining',
			'fileComparison.comparisonInProgress' => 'Comparison in progress...',
			'fileComparison.comparisonFailed' => ({required Object error}) => 'Comparison Failed: ${error}',
			'fileComparison.fileChanged' => ({required Object fileName}) => 'File changed: ${fileName}. Recomparing...',
			'fileComparison.dropFileHere' => 'Drop file here',
			'fileComparison.dropFileOrBrowse' => 'Drop file or click to browse',
			'fileComparison.fileUpload' => 'Upload file',
			'fileComparison.changeFile' => 'Change file',
			'fileComparison.total' => 'Total',
			'fileComparison.show' => 'Show',
			'fileComparison.showAll' => 'Show All',
			'fileComparison.noMatches' => ({required Object query}) => 'No matches found for "${query}"',
			'fileComparison.showingEntries' => ({required Object count, required Object total}) => 'Showing ${count} of ${total} entries',
			'fileComparison.filesIdentical' => 'Files are identical.',
			'fileComparison.hiddenIdentical' => ({required Object count}) => '${count} identical entries hidden',
			'fileComparison.showIdentical' => 'Show Identical Entries',
			'fileComparison.hideIdentical' => 'Hide identical entries',
			'fileComparison.noDiff' => 'No differences found based on keys.',
			'fileComparison.source' => 'Source',
			'fileComparison.target' => 'Target',
			'fileComparison.value' => 'Value',
			'fileComparison.readyToCompare' => 'Ready to Compare Files',
			'fileComparison.readyToCompareDesc' => 'Drop localization files above or use the browse buttons\nto select files for comparison.',
			'fileComparison.recentComparisons' => 'Recent Comparisons',
			'fileComparison.bilingualFileLabel' => ({required Object name}) => 'Bilingual file: ${name}',
			'fileComparison.comparisonLabel' => ({required Object source, required Object target}) => '${source} ↔ ${target}',
			'fileComparison.fileNotExist' => 'One or both files from this session no longer exist.',
			'fileComparison.largeFileTitle' => 'Large File Detected',
			'fileComparison.largeFileContent' => ({required Object count}) => 'The comparison result contains ${count} entries.\nDisplaying all of them might cause performance issues.\n\nDo you want to proceed?',
			'fileComparison.dontShowAgain' => 'Don\'t show again for this file',
			'fileComparison.proceed' => 'Proceed',
			'fileComparison.exportReport' => ({required Object format}) => 'Save ${format} Report',
			'fileComparison.saved' => ({required Object format}) => '${format} saved',
			'fileComparison.saveError' => ({required Object format}) => 'Failed to save ${format} file.',
			'fileComparison.saveErrorDetailed' => ({required Object format, required Object error}) => 'Failed to save ${format}: ${error}',
			'fileComparison.watching' => 'Watching',
			'fileComparison.watchOff' => 'Watch Off',
			'fileComparison.watchingTooltip' => ({required Object status}) => 'File Watching: ${status}\nAutomatically recompare when files change on disk',
			'fileComparison.aiSettingsNotAvailable' => 'Navigation to AI Settings not available',
			'directoryComparison.title' => 'Directory Comparison',
			'directoryComparison.sourceDirectory' => 'Source Directory',
			'directoryComparison.targetDirectory' => 'Target Directory',
			'directoryComparison.sourceSubtitle' => 'Original/Reference files',
			'directoryComparison.targetSubtitle' => 'Translation/Comparison files',
			'directoryComparison.selectBothDirectories' => 'Please select both a source and target directory.',
			'directoryComparison.selectSourceFolder' => 'Select Source Folder',
			'directoryComparison.selectTargetFolder' => 'Select Target Folder',
			'directoryComparison.dropFolderHere' => 'Drop folder here or browse...',
			'directoryComparison.folderPath' => 'Folder Path',
			'directoryComparison.readyToCompare' => 'Ready to Compare Directories',
			'directoryComparison.readyToCompareDesc' => 'Drop folders above or use the browse buttons\nto select directories for comparison.',
			'directoryComparison.nestedFolders' => 'Nested folders',
			'directoryComparison.nestedFoldersTooltip' => 'Recursively compares all nested directories',
			'directoryComparison.fileMatching' => 'File matching',
			'directoryComparison.fileMatchingTooltip' => 'Automatically pairs files by name',
			'directoryComparison.bulkExport' => 'Bulk export',
			'directoryComparison.bulkExportTooltip' => 'Export all comparison results at once',
			'directoryComparison.notDirectoryComparison' => 'This is not a directory comparison.',
			'directoryComparison.directoriesNotExist' => 'One or both directories no longer exist.',
			'directoryComparison.errorOccurred' => 'Error occurred',
			'directoryComparison.noFilesFound' => 'No files found in selected directories.',
			'directoryComparison.unmatchedSourceFiles' => 'Unmatched Source Files',
			'directoryComparison.unmatchedTargetFiles' => 'Unmatched Target Files',
			'directoryComparison.filePairs' => ({required Object count}) => '${count} file pairs',
			'directoryComparison.pairedFiles' => ({required Object count}) => 'Paired Files (${count})',
			'directoryComparison.view' => 'View',
			'directoryComparison.failed' => 'Failed',
			'directoryComparison.pair' => 'Pair...',
			'directoryComparison.pairDialogTitle' => ({required Object name}) => 'Pair "${name}" with:',
			'directoryComparison.discoverFiles' => 'Discover Files',
			'directoryComparison.compareAll' => 'Compare All',
			'directoryComparison.exportAll' => 'Export All',
			'directoryComparison.comparisonStarted' => 'Comparison started...',
			'directoryComparison.discoveringFiles' => 'Discovering files...',
			'directoryComparison.noResultsToExport' => 'No comparison results to export. Run "Compare All" first.',
			'directoryComparison.selectExportFolder' => 'Select Export Folder',
			'directoryComparison.createExportFolderError' => ({required Object error}) => 'Failed to create export folder: ${error}',
			'directoryComparison.exportingResults' => 'Exporting Results',
			'directoryComparison.processingFile' => ({required Object file}) => 'Processing: ${file}',
			'directoryComparison.exportProgress' => ({required Object current, required Object total}) => '${current} of ${total} files exported',
			'directoryComparison.exportComplete' => 'Export Complete',
			'directoryComparison.exportSuccessMessage' => ({required Object count}) => 'Successfully exported ${count} comparison files plus summary.',
			'directoryComparison.exportFailed' => ({required Object error}) => 'Export failed: ${error}',
			'directoryComparison.close' => 'Close',
			'gitComparison._translatorNote' => 'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.',
			'gitComparison.title' => 'Repository Comparison',
			'gitComparison.repoSelector' => 'Create / Open Repository',
			'gitComparison.noRepoSelected' => 'No repository selected',
			'gitComparison.open' => 'Open',
			'gitComparison.refreshCommits' => 'Refresh Commits',
			'gitComparison.noCommits' => 'No commits found or loaded. Select a branch to load commits.',
			'gitComparison.baseCommit' => 'Base Commit (Older)',
			'gitComparison.targetCommit' => 'Target Commit (Newer)',
			'gitComparison.filterCommitsByBranch' => 'Filter Commits by Branch',
			'gitComparison.conflictDetection' => 'Conflict detection',
			'gitComparison.conflictDetectionTooltip' => 'Detect and resolve merge conflicts',
			'gitComparison.actions' => 'Actions:',
			'gitComparison.checkout' => 'Checkout',
			'gitComparison.merge' => 'Merge',
			'gitComparison.pull' => 'Pull',
			'gitComparison.checkoutBranch' => 'Checkout Branch',
			'gitComparison.mergeBranch' => 'Merge Branch into Current',
			'gitComparison.mergeConfirmation' => ({required Object branch}) => 'Merge ${branch}?',
			'gitComparison.mergeWarning' => 'This will merge changes into your current working branch. Conflicts may occur.',
			'gitComparison.selectExportFolder' => 'Select Export Folder',
			'gitComparison.createExportFolderError' => ({required Object error}) => 'Failed to create export folder: ${error}',
			'gitComparison.exportingFiles' => 'Exporting Files',
			'gitComparison.processingFile' => ({required Object file}) => 'Processing: ${file}',
			'gitComparison.exportProgress' => ({required Object current, required Object total}) => '${current} of ${total} files exported',
			'gitComparison.exportComplete' => 'Export Complete',
			'gitComparison.exportSuccessMessage' => ({required Object count}) => 'Successfully exported ${count} files with full content.',
			'gitComparison.exportDetail' => 'Each file\'s diff is saved in the "files" subfolder.',
			'gitComparison.diffViewer' => 'Diff Viewer',
			'gitComparison.base' => 'BASE',
			'gitComparison.target' => 'TARGET',
			'gitComparison.noLines' => 'No lines to display',
			'gitComparison.searchFiles' => 'Search files...',
			'gitComparison.noFilesMatch' => ({required Object query}) => 'No files match "${query}"',
			'gitComparison.filesCount' => ({required Object count}) => '${count} files',
			'gitComparison.selectBaseFile' => 'Select Base File',
			'gitComparison.selectTargetFile' => 'Select Target File',
			'gitComparison.comparisonResults' => 'Comparison Results',
			'gitComparison.noChanges' => 'No changes found between selected refs.',
			'gitComparison.linesAdded' => 'Lines Added',
			'gitComparison.linesRemoved' => 'Lines Removed',
			'gitComparison.commit' => 'Commit',
			'gitComparison.branch' => 'Branch',
			'gitComparison.noRepositorySelected' => 'No repository selected',
			'gitComparison.notGitComparison' => 'Not a Git comparison',
			'gitComparison.repositoryNotExist' => 'Repository does not exist',
			'gitComparison.mainBranch' => 'main',
			'gitComparison.masterBranch' => 'master',
			'gitComparison.backToControls' => 'Back to comparison controls',
			'advancedComparison.placeholder' => 'Advanced Comparison View - Placeholder',
			'advancedDiff.saveAllChanges' => 'Save All Changes?',
			'advancedDiff.saveConfirmation' => ({required Object count}) => 'This will save all ${count} modified entries to the target file. This action cannot be undone.',
			'advancedDiff.changesSaved' => 'Changes saved successfully.',
			'advancedDiff.csvExported' => 'CSV exported',
			'advancedDiff.unsavedChanges' => 'Unsaved Changes',
			'advancedDiff.unsavedChangesWarning' => 'You have unsaved changes. Are you sure you want to discard them?',
			'advancedDiff.discardChanges' => 'Discard Changes',
			'advancedDiff.goBack' => 'Go back',
			'advancedDiff.breadcrumbs' => 'Home  >  Editor',
			'advancedDiff.unsaved' => ({required Object count}) => '${count} unsaved',
			'advancedDiff.reviewed' => ({required Object count}) => '${count} reviewed',
			'advancedDiff.saveAll' => ({required Object count}) => 'Save All (${count})',
			'advancedDiff.allSaved' => 'All Saved',
			'advancedDiff.saveAllTooltip' => 'Save All Changes (Ctrl+S)',
			'advancedDiff.exportTooltip' => 'Export Data (Ctrl+E)',
			'advancedDiff.aiSuggestion.aiTranslation' => 'AI Translation',
			'advancedDiff.aiSuggestion.aiRephrase' => 'AI Rephrase',
			'advancedDiff.aiSuggestion.key' => ({required Object key}) => 'Key: ${key}',
			'advancedDiff.aiSuggestion.original' => 'Original:',
			'advancedDiff.aiSuggestion.suggestion' => 'Suggestion:',
			'advancedDiff.aiSuggestion.confidence' => 'AI Confidence',
			'advancedDiff.aiSuggestion.cancelEdit' => 'Cancel edit',
			'advancedDiff.aiSuggestion.editSuggestion' => 'Edit suggestion',
			'advancedDiff.aiSuggestion.alternatives' => 'Alternatives:',
			'advancedDiff.aiSuggestion.accept' => 'Accept',
			'advancedDiff.aiSuggestion.reject' => 'Reject',
			'advancedDiff.aiSuggestion.stop' => 'Stop',
			'advancedDiff.detailEdit.title' => ({required Object key}) => 'Edit: ${key}',
			'advancedDiff.detailEdit.sourceLabel' => 'SOURCE (Original)',
			'advancedDiff.detailEdit.targetLabel' => 'TARGET (Translation)',
			'advancedDiff.detailEdit.translateWithCloud' => 'Translate with Cloud',
			'advancedDiff.detailEdit.translateWithAi' => 'Translate with AI',
			'advancedDiff.detailEdit.translating' => 'Translating...',
			'advancedDiff.detailEdit.applyAndTm' => 'Apply',
			'advancedDiff.detailEdit.entryApplied' => 'Entry applied & added to TM',
			'advancedDiff.detailEdit.translationAdded' => 'Translation suggestion added.',
			'advancedDiff.detailEdit.aiSuggestionAdded' => 'AI suggestion added.',
			'advancedDiff.table.addedToTM' => 'Added to Translation Memory',
			'advancedDiff.table.markedReviewed' => 'Marked as reviewed ✓',
			'advancedDiff.table.unmarkedReview' => 'Unmarked review',
			'advancedDiff.table.reverted' => 'Reverted to source value',
			'advancedDiff.table.entryDeleted' => 'Entry deleted',
			'advancedDiff.table.noSourceText' => 'No source text to translate.',
			'advancedDiff.table.aiTranslationFailed' => ({required Object key}) => 'AI translation failed for "${key}"',
			'advancedDiff.table.noTargetText' => 'No target text to rephrase.',
			'advancedDiff.table.aiRephraseFailed' => ({required Object key}) => 'AI rephrase failed for "${key}"',
			'advancedDiff.table.checkRowsFirst' => 'Check rows using checkboxes first',
			'advancedDiff.table.markedRowsReviewed' => ({required Object count}) => 'Marked ${count} rows as reviewed',
			'advancedDiff.table.revertedRows' => ({required Object count}) => 'Reverted ${count} rows',
			'advancedDiff.table.entriesCount' => ({required Object count}) => '${count} entries',
			'advancedDiff.table.markSelectedReviewed' => 'Mark Selected Reviewed',
			'advancedDiff.table.revertSelected' => 'Revert Selected',
			'advancedDiff.table.noDifferences' => 'No differences found',
			'advancedDiff.table.adjustFilters' => 'Try adjusting your filters',
			'advancedDiff.table.cloudTranslationApplied' => 'Cloud translation applied.',
			'advancedDiff.table.aiTranslationApplied' => 'AI translation applied.',
			'advancedDiff.table.suggestionApplied' => 'Suggestion applied.',
			'advancedDiff.table.aiSuggestionApplied' => 'AI suggestion applied.',
			'advancedDiff.table.rephraseApplied' => 'Rephrase applied.',
			'advancedDiff.table.aiRephraseApplied' => 'AI rephrase applied.',
			'advancedDiff.table.rephrase' => 'Rephrase',
			'advancedDiff.table.aiRephrase' => 'AI Rephrase',
			'advancedDiff.table.targetClickToEdit' => 'TARGET (Click to edit)',
			'advancedDiff.table.targetClickForDialog' => 'TARGET (Click for dialog)',
			'advancedDiff.table.emptyClickToEdit' => '(Empty - Click to edit)',
			'advancedDiff.table.unmarkReviewed' => 'Unmark reviewed',
			'advancedDiff.table.markReviewed' => 'Mark as reviewed',
			'advancedDiff.table.revertToSource' => 'Revert to source',
			'advancedDiff.table.translateWithCloud' => 'Translate with Cloud',
			'advancedDiff.table.translateWithAi' => 'Translate with AI',
			'advancedDiff.table.rephraseWithAi' => 'Rephrase with AI',
			'advancedDiff.table.moreActions' => 'More actions',
			'advancedDiff.table.editDetails' => 'Edit details',
			'advancedDiff.table.suggestTranslation' => 'Suggest translation',
			'advancedDiff.table.addToTm' => 'Add to TM',
			'advancedDiff.table.deleteEntry' => 'Delete entry',
			'advancedDiff.diffRow.copySource' => 'Copy source text',
			'advancedDiff.diffRow.actions' => 'Actions',
			'advancedDiff.status.added' => 'ADDED',
			'advancedDiff.status.missing' => 'MISSING',
			'advancedDiff.status.changed' => ({required Object percent}) => 'CHG ${percent}%',
			'advancedDiff.status.same' => 'SAME',
			'advancedDiff.sidebar.widgets' => 'Widgets',
			'advancedDiff.sidebar.searchPlaceholder' => 'Search keys & values... (Ctrl+F)',
			'advancedDiff.sidebar.fuzzySearchTooltip' => 'Fuzzy Search (typo-tolerant)',
			'advancedDiff.sidebar.regexSearchTooltip' => 'Regex Search',
			'advancedDiff.sidebar.cloudTranslation' => 'Cloud Translation',
			'advancedDiff.sidebar.aiTranslation' => 'AI Translation',
			'advancedDiff.sidebar.status' => 'Status',
			'advancedDiff.sidebar.tm' => 'Translation Memory',
			'advancedDiff.sidebar.filters' => 'Filters',
			'advancedDiff.sidebar.actions' => 'Actions',
			'advancedDiff.sidebar.similarity' => 'Similarity',
			'advancedDiff.sidebar.actionsSection.exportMatches' => 'Export matches',
			'advancedDiff.sidebar.actionsSection.preview' => 'Preview',
			'advancedDiff.sidebar.actionsSection.fillFromTmTitle' => 'Fill from Translation Memory?',
			'advancedDiff.sidebar.actionsSection.fillFromTmContent' => 'This will attempt to fill empty target values using matches from the Translation Memory. Existing values will NOT be overwritten.',
			'advancedDiff.sidebar.actionsSection.fill' => 'Fill',
			'advancedDiff.sidebar.actionsSection.fillFromMemory' => 'Fill from Memory',
			'advancedDiff.sidebar.actionsSection.filledFromTm' => ({required Object count}) => 'Filled ${count} items from Translation Memory.',
			'advancedDiff.sidebar.aiSection.infoCloud' => 'Uses cloud translation to translate empty target values from source.',
			'advancedDiff.sidebar.aiSection.infoAi' => 'Uses AI to translate empty target values from source.',
			'advancedDiff.sidebar.aiSection.translationSettings' => 'Translation Settings',
			'advancedDiff.sidebar.aiSection.aiSettings' => 'AI Settings',
			'advancedDiff.sidebar.aiSection.source' => 'Source',
			'advancedDiff.sidebar.aiSection.target' => 'Target',
			'advancedDiff.sidebar.aiSection.translatingProgress' => ({required Object percent}) => 'Translating... ${percent}%',
			'advancedDiff.sidebar.aiSection.translating' => 'Translating...',
			'advancedDiff.sidebar.aiSection.translateAllMissing' => 'Translate All Missing',
			'advancedDiff.sidebar.aiSection.translateAllTitle' => 'Translate All Missing?',
			'advancedDiff.sidebar.aiSection.translateAllContent' => ({required Object service, required Object source, required Object target}) => 'This will use ${service} to translate all entries with empty target values from ${source} to ${target}.\n\nYou can review each suggestion or apply all at once.',
			'advancedDiff.sidebar.aiSection.translateAll' => 'Translate All',
			'advancedDiff.sidebar.aiSection.reviewEach' => 'Review Each',
			'advancedDiff.sidebar.aiSection.cloudTranslated' => ({required Object count}) => 'Translated ${count} entries with cloud translation.',
			'advancedDiff.sidebar.aiSection.aiTranslated' => ({required Object count}) => 'Translated ${count} entries with AI.',
			'advancedDiff.sidebar.aiSection.aiTranslateFailed' => 'AI translate all failed',
			'advancedDiff.sidebar.aiSection.noMissingEntries' => 'No missing entries to translate.',
			'advancedDiff.sidebar.aiSection.skip' => 'Skip',
			'advancedDiff.sidebar.aiSection.stop' => 'Stop',
			'advancedDiff.sidebar.aiSection.cloudApplied' => ({required Object count}) => 'Applied ${count} suggestions.',
			'advancedDiff.sidebar.aiSection.aiApplied' => ({required Object count}) => 'Applied ${count} AI suggestions.',
			'advancedDiff.sidebar.tmSection.enableTmFill' => 'Enable TM Fill',
			'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' => 'Auto-apply above minimum',
			'advancedDiff.sidebar.tmSection.matchSettings' => 'Match Settings',
			'advancedDiff.sidebar.tmSection.minMatch' => 'Min match:',
			'advancedDiff.sidebar.tmSection.limit' => 'Limit:',
			'advancedDiff.sidebar.tmSection.exact' => 'Exact',
			'advancedDiff.sidebar.filtersSection.viewFilters' => 'View Filters',
			'advancedDiff.sidebar.filtersSection.showAll' => 'Show All',
			'advancedDiff.sidebar.filtersSection.added' => 'Added',
			'advancedDiff.sidebar.filtersSection.removed' => 'Removed',
			'advancedDiff.sidebar.filtersSection.modified' => 'Modified',
			'advancedDiff.sidebar.filtersSection.actionScope' => 'Action Scope',
			'advancedDiff.sidebar.filtersSection.applyToAdded' => 'Apply to Added',
			'advancedDiff.sidebar.filtersSection.applyToModified' => 'Apply to Modified',
			'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' => 'Only fill empty targets',
			'advancedDiff.sidebar.filtersSection.limitToVisible' => 'Limit to visible',
			'advancedDiff.sidebar.filtersSection.editMode' => 'Edit Mode',
			'advancedDiff.sidebar.filtersSection.dialog' => 'Dialog',
			'advancedDiff.sidebar.filtersSection.inline' => 'Inline',
			'advancedDiff.sidebar.similaritySection.currentFilter' => 'Current Filter:',
			'advancedDiff.sidebar.similaritySection.any' => 'ANY',
			'advancedDiff.sidebar.similaritySection.high' => 'HIGH',
			'advancedDiff.sidebar.similaritySection.medium' => 'MEDIUM',
			'advancedDiff.sidebar.similaritySection.low' => 'LOW',
			'advancedDiff.sidebar.statusSection.total' => ({required Object count}) => '${count} total',
			'advancedDiff.sidebar.statusSection.extra' => ({required Object count}) => '${count} extra',
			'advancedDiff.sidebar.statusSection.missing' => ({required Object count}) => '${count} missing',
			'advancedDiff.sidebar.statusSection.changed' => ({required Object count}) => '${count} changed',
			'issueDetails.title' => 'Issue Details',
			'issueDetails.showingIssues' => ({required Object count, required Object total}) => 'Showing ${count} of ${total} issues',
			'issueDetails.searchPlaceholder' => 'Search by key, text, or error...',
			'issueDetails.noDetails' => 'No details available.',
			'issueDetails.noMatches' => 'No matches found.',
			'issueDetails.showMore' => 'Show More',
			'issueDetails.copyItems' => ({required Object count}) => 'Copy ${count} Items',
			'issueDetails.close' => 'Close',
			'issueDetails.copied' => 'Copied to clipboard',
			'issueDetails.copiedCount' => ({required Object count}) => 'Copied ${count} items',
			'issueDetails.duplicateValue.label' => 'REPEATED TRANSLATION',
			'issueDetails.duplicateValue.warning' => 'Different source texts use this same translation. Check context.',
			'issueDetails.duplicateValue.affectedKeys' => ({required Object count}) => 'AFFECTED KEYS (${count})',
			'issueDetails.duplicateValue.identicalSources' => 'Identical Sources',
			'issueDetails.duplicateValue.moreKeys' => ({required Object count}) => '+${count} more keys',
			'issueDetails.lengthOutlier.source' => 'SOURCE',
			'issueDetails.lengthOutlier.translation' => 'TRANSLATION',
			'issueDetails.lengthOutlier.chars' => ({required Object count}) => '${count} chars',
			'issueDetails.standard.key' => 'KEY',
			'issueDetails.standard.sourceText' => 'SOURCE TEXT',
			'issueDetails.standard.translation' => 'TRANSLATION',
			'issueDetails.standard.errorDetails' => 'ERROR DETAILS',
			'issueDetails.standard.note' => 'NOTE',
			'issueDetails.review' => 'Review',
			'issueDetails.types.duplicateValue' => 'Duplicate Values',
			'issueDetails.types.lengthOutlier' => 'Length Mismatch',
			'issueDetails.types.placeholderMismatch' => 'Broken Placeholders',
			'issueDetails.notes.placeholderMismatch' => 'Markers like {name} should match the source.',
			'issueDetails.notes.lengthOutlier' => 'Big length changes can affect how text fits on screen.',
			'issueDetails.notes.duplicateValue' => 'Same translation is used for different keys.',
			'issueDetails.fallbacks.multipleSources' => 'Multiple source texts',
			'issueDetails.fallbacks.sourceNotAvailable' => 'Source text not available',
			'issueDetails.fallbacks.sharedTranslationNotAvailable' => 'Shared translation not available',
			'issueDetails.fallbacks.translationNotAvailable' => 'Translation not available',
			'importReview.title' => 'Review Project Import',
			'importReview.projectName' => 'Project Name',
			'importReview.created' => 'Created',
			'importReview.historyItems' => 'History Items',
			'importReview.customSettingsTitle' => 'Custom Settings Detected',
			'importReview.customSettingsWarning' => 'This project contains custom settings that will override your defaults while this project is open.',
			'importReview.standardSettings' => 'This project uses standard global settings.',
			'importReview.cancelImport' => 'Cancel Import',
			'importReview.trustOpen' => 'Trust & Open Project',
			'historyView.title' => 'Comparison History',
			'historyView.clearAll' => 'Clear all history',
			'historyView.searchPlaceholder' => 'Search by file name...',
			'historyView.sortBy' => 'Sort by',
			'historyView.sortDate' => 'Date',
			'historyView.sortSource' => 'Source File',
			'historyView.sortTarget' => 'Target File',
			'historyView.showCurrentProject' => 'Showing: Current Project',
			'historyView.showAllHistory' => 'Showing: All History',
			'historyView.groupByFolder' => 'Group by folder',
			'historyView.disableGrouping' => 'Disable folder grouping',
			'historyView.filterAll' => 'All',
			'historyView.filterFiles' => 'Files',
			'historyView.filterDirectories' => 'Directories',
			'historyView.filterGit' => 'Git',
			'historyView.noHistory' => 'No comparison history yet',
			'historyView.historyDescription' => 'Your file comparisons will appear here',
			'historyView.noResults' => 'No results found',
			'historyView.adjustSearch' => 'Try adjusting your search',
			'historyView.clearConfirmationTitle' => 'Clear All History?',
			'historyView.clearConfirmationContent' => 'This will permanently delete all comparison history. This action cannot be undone.',
			'historyView.clearAction' => 'Clear All',
			'historyView.deletedMessage' => 'History item deleted',
			'historyView.undo' => 'Undo',
			'historyView.viewDetails' => 'View Details',
			'historyView.delete' => 'Delete',
			'historyView.openLocation' => 'Open file location',
			'historyView.bilingual' => 'Bilingual',
			'historyView.filePair' => 'File Pair',
			'historyView.directory' => 'Directory',
			'historyView.git' => 'Git',
			'historyView.repo' => 'Repo',
			'historyView.sourceDir' => 'Source Dir',
			'historyView.targetDir' => 'Target Dir',
			'historyView.source' => 'Source',
			'historyView.target' => 'Target',
			'historyView.noChanges' => 'No changes detected',
			'historyView.added' => 'Added',
			'historyView.removed' => 'Removed',
			'historyView.modified' => 'Modified',
			'historyView.same' => 'Same',
			'historyView.total' => 'Total',
			'historyView.currentProject' => 'Current Project',
			'historyView.unassigned' => 'Unassigned',
			'historyView.project' => 'Project',
			'compare.title' => 'Compare Files',
			'compare.sourceFile' => 'Source File',
			'compare.targetFile' => 'Target File',
			'compare.sourceFolder' => 'Source Folder',
			'compare.targetFolder' => 'Target Folder',
			'compare.dropFilesHint' => 'Drop localization files here or use the browse buttons to select files for comparison.',
			'compare.selectSourceFile' => 'Select source file',
			'compare.selectTargetFile' => 'Select target file',
			'compare.startComparison' => 'Start Comparison',
			'compare.comparing' => 'Comparing...',
			'compare.comparisonComplete' => 'Comparison complete',
			'compare.noChanges' => 'No changes detected',
			'compare.filesIdentical' => 'Files are identical',
			'compare.changesFound' => ({required Object count}) => '${count} changes found',
			'compare.tabs.files' => 'Files',
			'compare.tabs.directories' => 'Directories',
			'compare.tabs.git' => 'Git',
			'compare.fileTypes.json' => 'JSON localization files (i18next, Flutter, etc.)',
			'compare.fileTypes.yaml' => 'YAML localization files (Rails, Flutter)',
			'compare.fileTypes.xml' => 'XML localization files (Android, .NET)',
			'compare.fileTypes.properties' => 'Properties files (Java)',
			'compare.fileTypes.resx' => 'RESX files (.NET)',
			_ => null,
		} ?? switch (path) {
			'compare.fileTypes.xliff' => 'XLIFF files',
			'history.title' => 'History',
			'history.recentComparisons' => 'Recent Comparisons',
			'history.noHistory' => 'No comparison history yet',
			'history.noHistoryDescription' => 'Your comparison history will appear here',
			'history.clearHistory' => 'Clear History',
			'history.clearHistoryConfirm' => 'Are you sure you want to clear all history?',
			'history.deleteEntry' => 'Delete Entry',
			'history.openComparison' => 'Open Comparison',
			'history.timeAgo.justNow' => 'just now',
			'history.timeAgo.secondsAgo' => ({required Object count}) => '${count} seconds ago',
			'history.timeAgo.oneMinuteAgo' => '1 minute ago',
			'history.timeAgo.minutesAgo' => ({required Object count}) => '${count} minutes ago',
			'history.timeAgo.oneHourAgo' => '1 hour ago',
			'history.timeAgo.hoursAgo' => ({required Object count}) => '${count} hours ago',
			'history.timeAgo.yesterday' => 'yesterday',
			'history.timeAgo.daysAgo' => ({required Object count}) => '${count} days ago',
			'history.timeAgo.oneWeekAgo' => '1 week ago',
			'history.timeAgo.weeksAgo' => ({required Object count}) => '${count} weeks ago',
			'history.timeAgo.oneMonthAgo' => '1 month ago',
			'history.timeAgo.monthsAgo' => ({required Object count}) => '${count} months ago',
			'history.timeAgo.oneYearAgo' => '1 year ago',
			'history.timeAgo.yearsAgo' => ({required Object count}) => '${count} years ago',
			'history.timeAgo.inTheFuture' => 'in the future',
			'projects.title' => 'Projects',
			'projects.createProject' => 'Create Project',
			'projects.importProject' => 'Import Project',
			'projects.noProjects' => 'No projects yet',
			'projects.noProjectsDescription' => 'Create a project to organize your localization files',
			'projects.projectName' => 'Project Name',
			'projects.projectPath' => 'Project Path',
			'projects.lastOpened' => 'Last opened',
			'projects.openProject' => 'Open Project',
			'projects.closeProject' => 'Close Project',
			'projects.deleteProject' => 'Delete Project',
			'projects.deleteProjectConfirm' => 'Are you sure you want to delete this project?',
			'projects.exportProject' => 'Export Project',
			'projects.exportDescription' => 'Create a portable zip file containing source files, configuration, and history.',
			'projects.exporting' => 'Exporting project...',
			'projects.exportSuccess' => 'Project exported',
			'projects.exportError' => ({required Object error}) => 'Export failed: ${error}',
			'projects.createNewProject' => 'Create New Project',
			'projects.openExistingProject' => 'Open Existing Project',
			'projects.importProjectZip' => 'Import Project Zip',
			'projects.projectResources' => 'Project Resources',
			'projects.recentProjects' => 'Recent Projects',
			'projects.noRecentProjects' => 'No recent projects',
			'projects.selectProjectZip' => 'Select Project Zip',
			'projects.selectDestination' => 'Select Destination Folder for Import',
			'projects.importing' => 'Importing project...',
			'projects.importSuccess' => 'Project imported successfully',
			'projects.importFailed' => ({required Object error}) => 'Import failed: ${error}',
			'projects.importingFiles' => 'Importing files...',
			'projects.noSupportedFiles' => 'No supported files were dropped.',
			'projects.stats.empty' => 'Empty project',
			'projects.stats.files' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '1 translation file', other: '${count} translation files', ), 
			'projects.stats.languages' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '1 language', other: '${count} languages', ), 
			'projects.openProjectFirst' => 'Open a project first to manage its resources.',
			'projects.removeFromRecent' => 'Remove from recent',
			'projects.selection.selectFolder' => 'Select Project Folder',
			'projects.selection.selectArchive' => 'Select Project Archive',
			'projects.selection.openProject' => 'Open Project',
			'projects.selection.browseFolder' => 'Browse Folder...',
			'projects.selection.createNew' => 'Create New',
			'projects.selection.importFromZip' => 'Import from Zip...',
			'projects.createDialog.title' => 'Create Project',
			'projects.createDialog.description' => 'A project lets you save custom settings for a specific folder. A ".localizer" folder will be created to store your project configuration.',
			'projects.createDialog.folderLabel' => 'Project Folder',
			'projects.createDialog.folderHint' => 'Click to select folder...',
			'projects.createDialog.nameLabel' => 'Project Name',
			'projects.createDialog.nameHint' => 'e.g., My App Translations',
			'projects.createDialog.selectFolderWarning' => 'Please select a project folder.',
			'projects.createDialog.enterNameError' => 'Please enter a project name',
			'projects.createDialog.nameLengthError' => 'Name must be at least 2 characters',
			'projects.createDialog.success' => ({required Object name}) => 'Project "${name}" created successfully!',
			'projects.createDialog.failure' => 'Failed to create project.',
			'projects.createDialog.creating' => 'Creating...',
			'projects.createDialog.createAction' => 'Create Project',
			'projects.indicator.tooltipNoProject' => 'Create a project to save custom settings for a folder',
			'projects.indicator.tooltipProject' => ({required Object name}) => 'Project: ${name}\nClick to see options',
			'projects.indicator.location' => 'Location',
			'projects.indicator.created' => 'Created',
			'projects.indicator.switchProject' => 'Switch Project',
			'projects.indicator.done' => 'Done',
			'projects.glossary.title' => 'Project Glossary',
			'projects.glossary.description' => 'Define terms that should be treated consistently or never translated.',
			'projects.glossary.noTerms' => 'No glossary terms yet.',
			'projects.glossary.noTermsDesc' => 'Add terms that should stay consistent across translations,\nor mark brand names that should never be translated.',
			'projects.glossary.doNotTranslate' => 'Do not translate',
			'projects.glossary.noSpecificTranslation' => 'No specific translation',
			'projects.glossary.addTerm' => 'Add Term',
			'projects.glossary.editTerm' => 'Edit Term',
			'projects.glossary.term' => 'Term',
			'projects.glossary.termHint' => 'e.g., brand name, specialized term',
			'projects.glossary.definition' => 'Definition (Optional)',
			'projects.glossary.definitionHint' => 'Context for the translator',
			'projects.glossary.doNotTranslateLabel' => 'Do Not Translate',
			'projects.glossary.doNotTranslateDesc' => 'Keep term exactly as is in target',
			'projects.glossary.preferredTranslation' => 'Preferred Translation',
			'projects.glossary.caseSensitive' => 'Case Sensitive',
			'projects.conflicts.missingApiKeyTitle' => ({required Object service}) => 'Missing API key for ${service}',
			'projects.conflicts.missingApiKeyMessage' => ({required Object service}) => 'This project uses ${service} but no API key is configured. Add your API key in Settings > AI Services, or the app will use the global default.',
			'projects.conflicts.dismiss' => 'Dismiss',
			'projects.tm.title' => 'Translation Memories',
			'projects.tm.description' => 'Manage translation memory sources for this project.',
			'projects.tm.globalTm' => 'Global Translation Memory',
			'projects.tm.globalTmDescription' => 'Use the shared translation memory from your app settings',
			'projects.tm.linkedFiles' => 'Linked Files (Project Specific)',
			'projects.tm.noLinkedFiles' => 'No project-specific files linked.',
			'projects.tm.addTmFile' => 'Add TM File',
			'projects.tm.useGlobalTm' => 'Use Global TM',
			'projects.tm.selectTm' => 'Select Translation Memory',
			'projects.tm.globalTmEnabled' => 'Global Translation Memory enabled',
			'diff.added' => 'Added',
			'diff.removed' => 'Removed',
			'diff.modified' => 'Modified',
			'diff.unchanged' => 'Unchanged',
			'diff.missing' => 'Missing',
			'diff.extra' => 'Extra',
			'diff.sourceValue' => 'Source Value',
			'diff.targetValue' => 'Target Value',
			'diff.key' => 'Key',
			'diff.status' => 'Status',
			'diff.actions' => 'Actions',
			'diff.copyToTarget' => 'Copy to Target',
			'diff.acceptChange' => 'Accept Change',
			'diff.rejectChange' => 'Reject Change',
			'diff.viewDetails' => 'View Details',
			'git.title' => 'Git Comparison',
			'git.selectRepository' => 'Select Repository',
			'git.selectBranch' => 'Select Branch',
			'git.selectCommit' => 'Select Commit',
			'git.compareBranches' => 'Compare Branches',
			'git.compareCommits' => 'Compare Commits',
			'git.baseBranch' => 'Base Branch',
			'git.compareBranch' => 'Compare Branch',
			'git.noRepositories' => 'No Git repositories found',
			'git.noRepositoriesDescription' => 'Open a folder containing a Git repository',
			'git.filesChanged' => ({required Object count}) => '${count} files changed',
			'git.additions' => ({required Object count}) => '${count} additions',
			'git.deletions' => ({required Object count}) => '${count} deletions',
			'git.conflicts.title' => 'Merge Conflicts Detected',
			'git.conflicts.description' => 'You must resolve these conflicts before you can continue.',
			'git.conflicts.abortMergeTitle' => 'Abort Merge?',
			'git.conflicts.abortMergeContent' => 'This will revert all merge changes and return to the state before the merge. This cannot be undone.',
			'git.conflicts.abortMergeAction' => 'Abort Merge',
			'git.conflicts.stagingFile' => ({required Object file}) => 'Staging ${file} for commit...',
			'git.conflicts.conflictedFilesCount' => ({required Object count}) => 'Conflicted Files (${count})',
			'git.conflicts.selectFileToResolve' => 'Select a file to resolve',
			'git.conflicts.resolvingFile' => ({required Object file}) => 'Resolving: ${file}',
			'git.conflicts.keepAllOurs' => 'Keep All Ours',
			'git.conflicts.acceptAllTheirs' => 'Accept All Theirs',
			'git.conflicts.allResolved' => 'All conflicts in this file have been resolved!',
			'git.conflicts.markResolved' => 'Mark as Resolved',
			'git.conflicts.stageForCommit' => 'This will stage the file for commit.',
			'git.conflicts.conflictIndex' => ({required Object index}) => 'Conflict #${index}',
			'git.conflicts.ours' => 'OURS (Current)',
			'git.conflicts.theirs' => 'THEIRS (Incoming)',
			'git.conflicts.keepOurs' => 'Keep Ours',
			'git.conflicts.acceptTheirs' => 'Accept Theirs',
			'git.conflicts.empty' => '(Empty)',
			'quality._translatorNote' => 'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.',
			'quality.title' => 'Quality Dashboard',
			'quality.overallScore' => 'Overall Score',
			'quality.issues' => 'Issues',
			'quality.warnings' => 'Warnings',
			'quality.suggestions' => 'Suggestions',
			'quality.placeholderMismatch' => 'Placeholder Mismatch',
			'quality.placeholderMismatchDescription' => 'Placeholders like {name} don\'t match between source and target',
			'quality.lengthOutlier' => 'Length Outlier',
			'quality.lengthOutlierDescription' => 'Translation length significantly differs from source',
			'quality.duplicateValue' => 'Duplicate Value',
			'quality.duplicateValueDescription' => 'Same translation used for multiple keys',
			'quality.missingTranslation' => 'Missing Translation',
			'quality.missingTranslationDescription' => 'Translation is missing for this key',
			'quality.loading' => 'Loading dashboard...',
			'quality.errorLoading' => 'We could not load your history. Try again.',
			'quality.emptyState' => 'Run a comparison to see your dashboard.',
			'quality.refresh' => 'Refresh',
			'quality.buildingInsights' => 'Building insights...',
			'quality.crunchingNumbers' => 'Crunching the numbers...',
			'quality.errorBuilding' => 'We could not build the dashboard. Try again.',
			'quality.noUsableData' => 'No usable data was found yet.',
			'quality.languages' => 'Languages',
			'quality.averageCoverage' => 'Average coverage',
			'quality.potentialIssues' => 'Potential issues',
			'quality.translationCoverage' => 'Translation coverage',
			'quality.entriesTranslated' => ({required Object translated, required Object total}) => '${translated} of ${total} entries translated',
			'quality.wordsAddedOverTime' => 'Words added over time',
			'quality.completionVsScope' => 'Completion vs Scope',
			'quality.scopeVsProgress' => 'Scope vs Progress',
			'quality.coveragePercent' => 'Coverage %',
			'quality.wordsAdded' => 'Words Added',
			'quality.words' => 'Words',
			'quality.coverage' => 'Coverage',
			'quality.scope' => 'Scope',
			'quality.latest' => 'Latest',
			'quality.added' => 'Added',
			'quality.change' => 'Change',
			'quality.totalScope' => 'Total Scope',
			'quality.scopeGrowth' => 'Scope Growth',
			'quality.range' => 'Range',
			'quality.aiUsage' => 'AI & Translation Usage',
			'quality.lastUsed' => ({required Object date}) => 'Last used ${date}',
			'quality.noIssuesFound' => 'No issues found in the latest comparisons.',
			'quality.placeholderMismatches' => 'Placeholder mismatches',
			'quality.placeholderMismatchesDesc' => 'Markers like {name} do not match.',
			'quality.lengthOutliers' => 'Very short or long translations',
			'quality.lengthOutliersDesc' => 'Length looks unusual compared to the source.',
			'quality.duplicateValues' => 'Duplicate values',
			'quality.duplicateValuesDesc' => 'The same translation is used many times.',
			'quality.placeholderDialogTitle' => 'Placeholder Mismatches',
			'quality.placeholderDialogDesc' => 'These translations have different placeholders ({name}) than the source.',
			'quality.lengthDialogTitle' => 'Length Outliers',
			'quality.lengthDialogDesc' => 'These translations are significantly shorter or longer than the source.',
			'quality.duplicateDialogTitle' => 'Duplicate Values',
			'quality.duplicateDialogDesc' => 'These translations appear multiple times.',
			'quality.duplicateSample' => ({required Object value}) => 'Duplicate: "${value}"',
			'quality.exportError' => 'Could not build the report. Please try again.',
			'quality.noDataToExport' => 'No data to export',
			'quality.exportFailed' => 'Export failed',
			'quality.exportDialogTitle' => 'Export Quality Report',
			'quality.reportSaved' => 'Report saved',
			'quality.export' => 'Export',
			'quality.requests' => 'Requests',
			'quality.tokens' => 'Tokens',
			'quality.characters' => 'Characters',
			'quality.estCost' => 'Est. Cost',
			'quality.prompt' => 'Prompt',
			'quality.completion' => 'Completion',
			'quality.showingCurrentProject' => 'Showing: Current Project',
			'quality.showingAllHistory' => 'Showing: All History',
			'quality.filesSkipped' => 'Some files were skipped because they were not found.',
			'errors.genericError' => 'An error occurred',
			'errors.fileNotFound' => 'File not found',
			'errors.invalidFormat' => 'Invalid file format',
			'errors.parseError' => 'Failed to parse file',
			'errors.networkError' => 'Network error. Please check your connection.',
			'errors.permissionDenied' => 'Permission denied',
			'errors.unknownError' => 'An unknown error occurred',
			'wizards.firstRun.welcome' => 'Welcome to Localizer',
			'wizards.firstRun.description' => 'Compare your localization files in seconds.',
			'wizards.firstRun.sourceFile' => 'Source File',
			'wizards.firstRun.targetFile' => 'Target File',
			'wizards.firstRun.compareNow' => 'Compare Now',
			'wizards.firstRun.trySample' => 'Try with Sample Data',
			'wizards.firstRun.skip' => 'Skip Setup',
			'wizards.firstRun.browse' => 'Click to browse',
			'wizards.firstRun.error' => ({required Object error}) => 'Failed to load sample data: ${error}',
			'dialogs.addIgnorePattern.title' => 'Add Ignore Pattern',
			'dialogs.addIgnorePattern.patternLabel' => 'Pattern (regex)',
			'dialogs.addIgnorePattern.hint' => 'e.g., ^temp_.*',
			'dialogs.addIgnorePattern.invalid' => 'Invalid regex pattern',
			'dialogs.addIgnorePattern.testStringLabel' => 'Test String',
			'dialogs.addIgnorePattern.testHint' => 'Enter a key to test against pattern',
			'dialogs.addIgnorePattern.match' => '✓ Pattern matches test string',
			'dialogs.addIgnorePattern.noMatch' => '✗ Pattern does not match',
			'dialogs.addIgnorePattern.add' => 'Add',
			'dialogs.addIgnorePattern.cancel' => 'Cancel',
			'dialogs.diffViewer.title' => 'Diff Viewer',
			'dialogs.diffViewer.originalFile' => 'Original/Reference file',
			'dialogs.diffViewer.translationFile' => 'Translation/Comparison file',
			'dialogs.diffViewer.base' => 'BASE',
			'dialogs.diffViewer.target' => 'TARGET',
			'dialogs.diffViewer.added' => 'Added',
			'dialogs.diffViewer.removed' => 'Removed',
			'dialogs.diffViewer.modified' => 'Modified',
			'dialogs.diffViewer.noMatches' => 'No entries match the current filters',
			'dialogs.diffViewer.clickToggle' => 'Click the badges above to toggle filters',
			'grid.columns.key' => 'Key',
			'grid.columns.source' => 'Source',
			'grid.columns.status' => 'Status',
			'grid.columns.actions' => 'Actions',
			'tutorial.skipTutorial' => 'SKIP TUTORIAL',
			'tutorial.finishMessage' => 'You\'re all set! Tap anywhere to finish.',
			'tutorial.next' => 'Next',
			'tutorial.loadSampleData' => 'Load Sample Data',
			'tutorial.browseSourceFile' => 'Browse Source File',
			'tutorial.browseTargetFile' => 'Browse Target File',
			'tutorial.compareFiles' => 'Compare Files',
			'tutorial.hintPhase2' => 'Next: filters, search, advanced view, and export.',
			'tutorial.steps.importSource.title' => '1. Import Source File',
			'tutorial.steps.importSource.description' => 'Use the button below to browse for a file, or drag & drop onto the highlighted area.',
			'tutorial.steps.importTarget.title' => '2. Import Target File',
			'tutorial.steps.importTarget.description' => 'Use the button below to browse for a file, or drag & drop onto the highlighted area.',
			'tutorial.steps.compare.title' => '3. Compare Files',
			'tutorial.steps.compare.description' => 'Tap the button below to run the comparison and see the results.',
			'tutorial.steps.filter.title' => '4. Filter Results',
			'tutorial.steps.filter.description' => 'Use these filters to view Added, Removed, or Modified strings.',
			'tutorial.steps.search.title' => '5. Search Results',
			'tutorial.steps.search.description' => 'Find specific keys or values using the search bar.',
			'tutorial.steps.advanced.title' => '6. Advanced View',
			'tutorial.steps.advanced.description' => 'Open the detailed diff view with editing, AI translation, and more.',
			'tutorial.steps.export.title' => '7. Export Results',
			'tutorial.steps.export.description' => 'Save your comparison as CSV, JSON, or Excel file.',
			'friendlyErrors.fileNotFound.message' => 'The file or folder could not be found.',
			'friendlyErrors.fileNotFound.suggestion' => 'Check if the file was moved or deleted.',
			'friendlyErrors.accessDenied.message' => 'Access to the file was denied.',
			'friendlyErrors.accessDenied.suggestion' => 'Try running the app as administrator or check file permissions.',
			'friendlyErrors.isDirectory.message' => 'A folder was selected instead of a file.',
			'friendlyErrors.isDirectory.suggestion' => 'Please select a valid file.',
			'friendlyErrors.fileAccess.message' => 'There was a problem accessing the file.',
			'friendlyErrors.fileAccess.suggestion' => 'Try closing other programs that might be using it.',
			'friendlyErrors.unsupportedFormat.message' => 'This file format or operation is not supported.',
			'friendlyErrors.unsupportedFormat.suggestion' => 'Check the file extension or try a different format.',
			'friendlyErrors.networkError.message' => 'Could not connect to the server.',
			'friendlyErrors.networkError.suggestion' => 'Check your internet connection and try again.',
			'friendlyErrors.notGitRepo.message' => 'This folder is not a Git project.',
			'friendlyErrors.notGitRepo.suggestion' => 'Navigate to a folder that contains a .git directory.',
			'friendlyErrors.mergeConflict.message' => 'There are merge conflicts in the repository.',
			'friendlyErrors.mergeConflict.suggestion' => 'Resolve the conflicts before continuing.',
			'friendlyErrors.gitAuthFailed.message' => 'Git authentication failed.',
			'friendlyErrors.gitAuthFailed.suggestion' => 'Check your credentials in Settings > Version Control.',
			'friendlyErrors.gitOperationFailed.message' => 'A Git operation failed.',
			'friendlyErrors.gitOperationFailed.suggestion' => 'Check the Git view for more details.',
			'friendlyErrors.invalidJson.message' => 'The file format is invalid or corrupted.',
			'friendlyErrors.invalidJson.suggestion' => 'Ensure the file contains valid JSON content.',
			'friendlyErrors.rateLimitReached.message' => 'Translation limit reached.',
			'friendlyErrors.rateLimitReached.suggestion' => 'Wait a few minutes or check your API plan limits.',
			'friendlyErrors.invalidApiKey.message' => 'Invalid API key.',
			'friendlyErrors.invalidApiKey.suggestion' => 'Go to Settings > AI Translation to update your API key.',
			'friendlyErrors.translationServiceError.message' => 'Translation service error.',
			'friendlyErrors.translationServiceError.suggestion' => 'Check your API key and internet connection.',
			'friendlyErrors.outOfMemory.message' => 'Not enough memory to complete this operation.',
			'friendlyErrors.outOfMemory.suggestion' => 'Try closing other applications or using smaller files.',
			'friendlyErrors.genericError.message' => 'Something went wrong.',
			'friendlyErrors.genericError.suggestion' => 'Please try again. If the problem persists, restart the app.',
			'systemTray.showLocalizer' => 'Show Localizer',
			'systemTray.exit' => 'Exit',
			'validation.connected' => 'Connected.',
			'validation.connectionTimeout' => 'Connection timed out. Please try again.',
			'validation.couldNotConnect' => 'Could not connect. Please try again.',
			'validation.checkKeyAndTryAgain' => 'Could not connect. Please check the key and try again.',
			'validation.tryAgainLater' => 'Could not connect right now. Please try again later.',
			'validation.serviceUnavailable' => 'Service is unavailable right now. Please try again later.',
			'validation.enterKeyFirst' => 'Please enter a key first.',
			'validation.checking' => 'Checking...',
			'validation.deeplUsage' => ({required Object used, required Object limit}) => 'Usage: ${used} / ${limit} characters.',
			'status.startingComparison' => 'Starting comparison...',
			'status.loadingFromHistory' => 'Loading files from history...',
			'status.comparisonComplete' => 'Comparison complete',
			'status.couldNotImportFiles' => 'Could not import the files. Please try again.',
			'status.historyFilesNotFound' => 'One or both files from history not found at original paths.',
			'aiServices.geminiEmptyResponse' => 'Gemini returned empty response',
			'aiServices.geminiStreamingEmpty' => 'Gemini streaming returned empty response',
			'aiServices.geminiRephraseEmpty' => 'Gemini returned empty response for rephrase',
			'aiServices.openaiEmptyResponse' => 'OpenAI returned empty or failed response',
			_ => null,
		};
	}
}
