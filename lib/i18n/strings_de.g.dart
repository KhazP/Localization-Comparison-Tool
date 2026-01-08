///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsDe with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAppDe app = _TranslationsAppDe._(_root);
	@override late final _TranslationsCommonDe common = _TranslationsCommonDe._(_root);
	@override late final _TranslationsMenuDe menu = _TranslationsMenuDe._(_root);
	@override late final _TranslationsNavDe nav = _TranslationsNavDe._(_root);
	@override late final _TranslationsSettingsDe settings = _TranslationsSettingsDe._(_root);
	@override late final _TranslationsFileComparisonDe fileComparison = _TranslationsFileComparisonDe._(_root);
	@override late final _TranslationsDirectoryComparisonDe directoryComparison = _TranslationsDirectoryComparisonDe._(_root);
	@override late final _TranslationsGitComparisonDe gitComparison = _TranslationsGitComparisonDe._(_root);
	@override late final _TranslationsAdvancedComparisonDe advancedComparison = _TranslationsAdvancedComparisonDe._(_root);
	@override late final _TranslationsAdvancedDiffDe advancedDiff = _TranslationsAdvancedDiffDe._(_root);
	@override late final _TranslationsIssueDetailsDe issueDetails = _TranslationsIssueDetailsDe._(_root);
	@override late final _TranslationsImportReviewDe importReview = _TranslationsImportReviewDe._(_root);
	@override late final _TranslationsHistoryViewDe historyView = _TranslationsHistoryViewDe._(_root);
	@override late final _TranslationsCompareDe compare = _TranslationsCompareDe._(_root);
	@override late final _TranslationsHistoryDe history = _TranslationsHistoryDe._(_root);
	@override late final _TranslationsProjectsDe projects = _TranslationsProjectsDe._(_root);
	@override late final _TranslationsDiffDe diff = _TranslationsDiffDe._(_root);
	@override late final _TranslationsGitDe git = _TranslationsGitDe._(_root);
	@override late final _TranslationsQualityDe quality = _TranslationsQualityDe._(_root);
	@override late final _TranslationsErrorsDe errors = _TranslationsErrorsDe._(_root);
	@override late final _TranslationsWizardsDe wizards = _TranslationsWizardsDe._(_root);
	@override late final _TranslationsDialogsDe dialogs = _TranslationsDialogsDe._(_root);
	@override late final _TranslationsGridDe grid = _TranslationsGridDe._(_root);
	@override late final _TranslationsTutorialDe tutorial = _TranslationsTutorialDe._(_root);
	@override late final _TranslationsFriendlyErrorsDe friendlyErrors = _TranslationsFriendlyErrorsDe._(_root);
	@override late final _TranslationsSystemTrayDe systemTray = _TranslationsSystemTrayDe._(_root);
	@override late final _TranslationsValidationDe validation = _TranslationsValidationDe._(_root);
	@override late final _TranslationsStatusDe status = _TranslationsStatusDe._(_root);
	@override late final _TranslationsAiServicesDe aiServices = _TranslationsAiServicesDe._(_root);
}

// Path: app
class _TranslationsAppDe implements TranslationsAppEn {
	_TranslationsAppDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lokalisierungs-Vergleichstool';
	@override String get name => 'Localizer';
}

// Path: common
class _TranslationsCommonDe implements TranslationsCommonEn {
	_TranslationsCommonDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get save => 'Speichern';
	@override String get cancel => 'Abbrechen';
	@override String get close => 'Schließen';
	@override String get delete => 'Löschen';
	@override String get edit => 'Bearbeiten';
	@override String get add => 'Hinzufügen';
	@override String get search => 'Suchen';
	@override String get undo => 'Rückgängig';
	@override String get loading => 'Laden...';
	@override String get error => 'Fehler';
	@override String get success => 'Erfolg';
	@override String get warning => 'Warnung';
	@override String get info => 'Info';
	@override String get confirm => 'Bestätigen';
	@override String get yes => 'Ja';
	@override String get no => 'Nein';
	@override String get ok => 'OK';
	@override String get retry => 'Wiederholen';
	@override String get copyText => 'Kopieren';
	@override String get appName => 'Localizer';
	@override String get copied => 'Kopiert!';
	@override String get enabled => 'Aktiviert';
	@override String get disabled => 'Deaktiviert';
	@override String get browse => 'Durchsuchen';
	@override String get clear => 'Leeren';
	@override String get apply => 'Anwenden';
	@override String get reset => 'Zurücksetzen';
	@override String get refresh => 'Aktualisieren';
	@override String get export => 'Exportieren';
	@override String get import => 'Importieren';
	@override String get select => 'Auswählen';
	@override String get selectAll => 'Alles auswählen';
	@override String get deselectAll => 'Alles abwählen';
	@override String get noResults => 'Keine Ergebnisse gefunden';
	@override String get emptyState => 'Hier ist noch nichts';
	@override String get open => 'Öffnen';
	@override String get change => 'Ändern';
	@override String get original => 'Original';
	@override String get kNew => 'Neu';
	@override String get remove => 'Entfernen';
	@override String get auto => 'Auto';
	@override String get execute => 'Ausführen';
	@override String get run => 'Starten';
	@override String get unknown => 'Unbekannt';
	@override String get download => 'Herunterladen';
	@override String get dropdownArrow => 'Dropdown-Pfeil';
	@override String get openInNewWindow => 'Öffnet in neuem Fenster';
	@override String get resetToDefaults => 'Auf Standards zurücksetzen';
}

// Path: menu
class _TranslationsMenuDe implements TranslationsMenuEn {
	_TranslationsMenuDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get file => 'Datei';
	@override String get edit => 'Bearbeiten';
	@override String get view => 'Ansicht';
	@override String get help => 'Hilfe';
	@override String get openFiles => 'Dateien öffnen...';
	@override String get openFolder => 'Ordner öffnen...';
	@override String get exportResults => 'Ergebnisse exportieren...';
	@override String get undo => 'Rückgängig';
	@override String get redo => 'Wiederholen';
	@override String get cut => 'Ausschneiden';
	@override String get paste => 'Einfügen';
	@override String get selectAll => 'Alles auswählen';
	@override String get zoomIn => 'Vergrößern';
	@override String get zoomOut => 'Verkleinern';
	@override String get resetZoom => 'Zoom zurücksetzen';
	@override String get documentation => 'Dokumentation';
	@override String get reportIssue => 'Problem melden';
	@override String about({required Object appName}) => 'Über ${appName}';
}

// Path: nav
class _TranslationsNavDe implements TranslationsNavEn {
	_TranslationsNavDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get compare => 'Vergleichen';
	@override String get history => 'Verlauf';
	@override String get settings => 'Einstellungen';
	@override String get projects => 'Projekte';
	@override String get dashboard => 'Dashboard';
	@override String get directory => 'Verzeichnis';
	@override String get repository => 'Repository';
	@override String get tooltipCompare => 'Lokalisierungsdateien vergleichen';
	@override String get tooltipHistory => 'Vergleichsverlauf anzeigen';
	@override String get tooltipSettings => 'App-Einstellungen';
	@override String get tooltipProjects => 'Projekte verwalten';
	@override String get tooltipThemeToggle => 'Design umschalten';
	@override String get tooltipDebugConsole => 'Debug-Konsole';
}

// Path: settings
class _TranslationsSettingsDe implements TranslationsSettingsEn {
	_TranslationsSettingsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Settings';
	@override String get appSettings => 'App Settings';
	@override String get projectSettings => 'Project Settings';
	@override late final _TranslationsSettingsAppearanceDe appearance = _TranslationsSettingsAppearanceDe._(_root);
	@override late final _TranslationsSettingsGeneralDe general = _TranslationsSettingsGeneralDe._(_root);
	@override late final _TranslationsSettingsScopeDe scope = _TranslationsSettingsScopeDe._(_root);
	@override late final _TranslationsSettingsSearchKeywordsDe searchKeywords = _TranslationsSettingsSearchKeywordsDe._(_root);
	@override late final _TranslationsSettingsComparisonDe comparison = _TranslationsSettingsComparisonDe._(_root);
	@override late final _TranslationsSettingsFileHandlingDe fileHandling = _TranslationsSettingsFileHandlingDe._(_root);
	@override late final _TranslationsSettingsTranslationMemoryDe translationMemory = _TranslationsSettingsTranslationMemoryDe._(_root);
	@override late final _TranslationsSettingsBackupDe backup = _TranslationsSettingsBackupDe._(_root);
	@override late final _TranslationsSettingsAiDe ai = _TranslationsSettingsAiDe._(_root);
	@override late final _TranslationsSettingsIntegrationsDe integrations = _TranslationsSettingsIntegrationsDe._(_root);
	@override late final _TranslationsSettingsDeveloperDe developer = _TranslationsSettingsDeveloperDe._(_root);
	@override late final _TranslationsSettingsAboutDe about = _TranslationsSettingsAboutDe._(_root);
	@override late final _TranslationsSettingsOnboardingDe onboarding = _TranslationsSettingsOnboardingDe._(_root);
	@override late final _TranslationsSettingsSettingsViewDe settingsView = _TranslationsSettingsSettingsViewDe._(_root);
}

// Path: fileComparison
class _TranslationsFileComparisonDe implements TranslationsFileComparisonEn {
	_TranslationsFileComparisonDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dateivergleich';
	@override String get openFiles => 'Dateien öffnen';
	@override String get exportResults => 'Ergebnisse exportieren';
	@override String get restartTutorial => 'Tutorial neu starten';
	@override String get restartTutorialDevOnly => 'Tutorial-Neustart ist nur im Entwicklermodus verfügbar.';
	@override String get unsupportedFileType => 'Nicht unterstützter Dateityp.';
	@override String get unsupportedFileTypeSuggestion => 'Bitte wählen Sie eine unterstützte Lokalisierungsdatei.';
	@override String get someFilesUnsupported => 'Einige Dateien werden nicht unterstützt.';
	@override String get pickSupportedFiles => 'Wählen Sie nur unterstützte Lokalisierungsdateien.';
	@override String get pickTwoFiles => 'Wählen Sie zwei Dateien zum Vergleichen.';
	@override String get pickBilingualFile => 'Bitte wählen Sie eine zweisprachige Datei zum Vergleichen.';
	@override String get noResultsToExport => 'Noch keine Ergebnisse zum Exportieren.';
	@override String get performComparisonFirst => 'Führen Sie zuerst einen Vergleich durch, um Ergebnisse zu exportieren.';
	@override String get performComparisonFirstEditor => 'Bitte führen Sie zuerst einen Vergleich durch, um Details zu sehen.';
	@override String get sampleDataLoaded => 'Beispieldaten erfolgreich geladen';
	@override String loadSampleDataError({required Object error}) => 'Fehler beim Laden der Beispieldaten: ${error}';
	@override String get invalidFileType => 'Ungültiger Dateityp.';
	@override String fileSelected({required Object label, required Object fileName}) => '${label} ausgewählt: ${fileName}';
	@override String get sourceFile => 'Quelldatei';
	@override String get targetFile => 'Zieldatei';
	@override String get bilingualFile => 'Zweisprachige Datei';
	@override String get compareFiles => 'Dateien vergleichen';
	@override String get compareFile => 'Datei vergleichen';
	@override String get bilingualMode => 'Bilingualer Modus';
	@override String get twoFilesMode => 'Zwei Dateien';
	@override String get processing => 'Verarbeitung...';
	@override String remaining({required Object time}) => '${time} verbleibend';
	@override String get comparisonInProgress => 'Vergleich läuft...';
	@override String comparisonFailed({required Object error}) => 'Vergleich fehlgeschlagen: ${error}';
	@override String fileChanged({required Object fileName}) => 'Datei geändert: ${fileName}. Vergleiche neu...';
	@override String get dropFileHere => 'Datei hier ablegen';
	@override String get dropFileOrBrowse => 'Datei ablegen oder klicken zum Durchsuchen';
	@override String get fileUpload => 'Datei hochladen';
	@override String get changeFile => 'Datei ändern';
	@override String get total => 'Gesamt';
	@override String get show => 'Zeigen';
	@override String get showAll => 'Alle zeigen';
	@override String noMatches({required Object query}) => 'Keine Treffer für "${query}"';
	@override String showingEntries({required Object count, required Object total}) => 'Zeige ${count} von ${total} Einträgen';
	@override String get filesIdentical => 'Dateien sind identisch.';
	@override String hiddenIdentical({required Object count}) => '${count} identische Einträge ausgeblendet';
	@override String get showIdentical => 'Identische Einträge anzeigen';
	@override String get hideIdentical => 'Identische Einträge ausblenden';
	@override String get noDiff => 'Keine Unterschiede basierend auf Schlüsseln gefunden.';
	@override String get source => 'Quelle';
	@override String get target => 'Ziel';
	@override String get value => 'Wert';
	@override String get readyToCompare => 'Bereit zum Dateivergleich';
	@override String get readyToCompareDesc => 'Lokalisierungsdateien oben ablegen oder Durchsuchen-Buttons nutzen\num Dateien für den Vergleich auszuwählen.';
	@override String get recentComparisons => 'Letzte Vergleiche';
	@override String bilingualFileLabel({required Object name}) => 'Zweisprachige Datei: ${name}';
	@override String comparisonLabel({required Object source, required Object target}) => '${source} ↔ ${target}';
	@override String get fileNotExist => 'Eine oder beide Dateien aus dieser Sitzung existieren nicht mehr.';
	@override String get largeFileTitle => 'Große Datei erkannt';
	@override String largeFileContent({required Object count}) => 'Das Vergleichsergebnis enthält ${count} Einträge.\nAlle anzuzeigen könnte zu Leistungsproblemen führen.\n\nMöchten Sie fortfahren?';
	@override String get dontShowAgain => 'Nicht mehr anzeigen für diese Datei';
	@override String get proceed => 'Fortfahren';
	@override String exportReport({required Object format}) => '${format} Bericht speichern';
	@override String saved({required Object format}) => '${format} gespeichert';
	@override String saveError({required Object format}) => 'Fehler beim Speichern der ${format} Datei.';
	@override String saveErrorDetailed({required Object format, required Object error}) => 'Fehler beim Speichern von ${format}: ${error}';
	@override String get watching => 'Beobachten';
	@override String get watchOff => 'Beobachten Aus';
	@override String watchingTooltip({required Object status}) => 'Dateiüberwachung: ${status}\nBei Dateiänderungen automatisch neu vergleichen';
	@override String get aiSettingsNotAvailable => 'Navigation zu KI-Einstellungen nicht verfügbar';
}

// Path: directoryComparison
class _TranslationsDirectoryComparisonDe implements TranslationsDirectoryComparisonEn {
	_TranslationsDirectoryComparisonDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verzeichnisvergleich';
	@override String get sourceDirectory => 'Quellverzeichnis';
	@override String get targetDirectory => 'Zielverzeichnis';
	@override String get sourceSubtitle => 'Original-/Referenzdateien';
	@override String get targetSubtitle => 'Übersetzungs-/Vergleichsdateien';
	@override String get selectBothDirectories => 'Bitte wählen Sie sowohl ein Quell- als auch ein Zielverzeichnis aus.';
	@override String get selectSourceFolder => 'Quellordner wählen';
	@override String get selectTargetFolder => 'Zielordner wählen';
	@override String get dropFolderHere => 'Ordner hier ablegen oder durchsuchen...';
	@override String get folderPath => 'Ordnerpfad';
	@override String get readyToCompare => 'Bereit zum Verzeichnisvergleich';
	@override String get readyToCompareDesc => 'Ordner oben ablegen oder Durchsuchen-Buttons nutzen\num Verzeichnisse für den Vergleich auszuwählen.';
	@override String get nestedFolders => 'Verschachtelte Ordner';
	@override String get nestedFoldersTooltip => 'Vergleicht rekursiv alle Unterverzeichnisse';
	@override String get fileMatching => 'Dateizuordnung';
	@override String get fileMatchingTooltip => 'Paart Dateien automatisch nach Namen';
	@override String get bulkExport => 'Massenexport';
	@override String get bulkExportTooltip => 'Alle Vergleichsergebnisse auf einmal exportieren';
	@override String get notDirectoryComparison => 'Dies ist kein Verzeichnisvergleich.';
	@override String get directoriesNotExist => 'Eines oder beide Verzeichnisse existieren nicht mehr.';
	@override String get errorOccurred => 'Ein Fehler ist aufgetreten';
	@override String get noFilesFound => 'Keine Dateien in den ausgewählten Verzeichnissen gefunden.';
	@override String get unmatchedSourceFiles => 'Nicht zugeordnete Quelldateien';
	@override String get unmatchedTargetFiles => 'Nicht zugeordnete Zieldateien';
	@override String filePairs({required Object count}) => '${count} Dateipaare';
	@override String pairedFiles({required Object count}) => 'Gepaarte Dateien (${count})';
	@override String get view => 'Ansicht';
	@override String get failed => 'Fehlgeschlagen';
	@override String get pair => 'Paaren...';
	@override String pairDialogTitle({required Object name}) => 'Paare "${name}" mit:';
	@override String get discoverFiles => 'Dateien entdecken';
	@override String get compareAll => 'Alle vergleichen';
	@override String get exportAll => 'Alle exportieren';
	@override String get comparisonStarted => 'Vergleich gestartet...';
	@override String get discoveringFiles => 'Entdecke Dateien...';
	@override String get noResultsToExport => 'Keine Vergleichsergebnisse zum Exportieren. Führen Sie zuerst "Alle vergleichen" aus.';
	@override String get selectExportFolder => 'Exportordner wählen';
	@override String createExportFolderError({required Object error}) => 'Fehler beim Erstellen des Exportordners: ${error}';
	@override String get exportingResults => 'Ergebnisse werden exportiert';
	@override String processingFile({required Object file}) => 'Verarbeite: ${file}';
	@override String exportProgress({required Object current, required Object total}) => '${current} von ${total} Dateien exportiert';
	@override String get exportComplete => 'Export abgeschlossen';
	@override String exportSuccessMessage({required Object count}) => 'Erfolgreich ${count} Vergleichsdateien plus Zusammenfassung exportiert.';
	@override String exportFailed({required Object error}) => 'Export fehlgeschlagen: ${error}';
	@override String get close => 'Schließen';
}

// Path: gitComparison
class _TranslationsGitComparisonDe implements TranslationsGitComparisonEn {
	_TranslationsGitComparisonDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get _translatorNote => 'Git-Begriffe (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) sollten auf Englisch bleiben, um Verwirrung bei Entwicklern zu vermeiden.';
	@override String get title => 'Repository-Vergleich';
	@override String get repoSelector => 'Repository erstellen / öffnen';
	@override String get noRepoSelected => 'Kein Repository ausgewählt';
	@override String get open => 'Öffnen';
	@override String get refreshCommits => 'Commits aktualisieren';
	@override String get noCommits => 'Keine Commits gefunden oder geladen. Wählen Sie einen Branch, um Commits zu laden.';
	@override String get baseCommit => 'Basis-Commit (Älter)';
	@override String get targetCommit => 'Ziel-Commit (Neuer)';
	@override String get filterCommitsByBranch => 'Commits nach Branch filtern';
	@override String get conflictDetection => 'Konflikterkennung';
	@override String get conflictDetectionTooltip => 'Merge-Konflikte erkennen und lösen';
	@override String get actions => 'Aktionen:';
	@override String get checkout => 'Checkout';
	@override String get merge => 'Merge';
	@override String get pull => 'Pull';
	@override String get checkoutBranch => 'Branch auschecken (Checkout)';
	@override String get mergeBranch => 'Branch in aktuellen mergen';
	@override String mergeConfirmation({required Object branch}) => '${branch} mergen?';
	@override String get mergeWarning => 'Dies wird Änderungen in Ihren aktuellen Arbeits-Branch mergen. Konflikte können auftreten.';
	@override String get selectExportFolder => 'Exportordner wählen';
	@override String createExportFolderError({required Object error}) => 'Fehler beim Erstellen des Exportordners: ${error}';
	@override String get exportingFiles => 'Dateien werden exportiert';
	@override String processingFile({required Object file}) => 'Verarbeite: ${file}';
	@override String exportProgress({required Object current, required Object total}) => '${current} von ${total} Dateien exportiert';
	@override String get exportComplete => 'Export abgeschlossen';
	@override String exportSuccessMessage({required Object count}) => 'Erfolgreich ${count} Dateien mit vollständigem Inhalt exportiert.';
	@override String get exportDetail => 'Das Diff jeder Datei wird im Unterordner "files" gespeichert.';
	@override String get diffViewer => 'Diff Viewer';
	@override String get base => 'BASE';
	@override String get target => 'TARGET';
	@override String get noLines => 'Keine Zeilen anzuzeigen';
	@override String get searchFiles => 'Dateien suchen...';
	@override String noFilesMatch({required Object query}) => 'Keine Dateien entsprechen "${query}"';
	@override String filesCount({required Object count}) => '${count} Dateien';
	@override String get selectBaseFile => 'Basisdatei wählen';
	@override String get selectTargetFile => 'Zieldatei wählen';
	@override String get comparisonResults => 'Vergleichsergebnisse';
	@override String get noChanges => 'Keine Änderungen zwischen ausgewählten Refs gefunden.';
	@override String get linesAdded => 'Zeilen hinzugefügt';
	@override String get linesRemoved => 'Zeilen entfernt';
	@override String get commit => 'Commit';
	@override String get branch => 'Branch';
	@override String get noRepositorySelected => 'Kein Repository ausgewählt';
	@override String get notGitComparison => 'Kein Git-Vergleich';
	@override String get repositoryNotExist => 'Repository existiert nicht';
	@override String get mainBranch => 'main';
	@override String get masterBranch => 'master';
	@override String get backToControls => 'Zurück zu Vergleichssteuerungen';
}

// Path: advancedComparison
class _TranslationsAdvancedComparisonDe implements TranslationsAdvancedComparisonEn {
	_TranslationsAdvancedComparisonDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get placeholder => 'Advanced Comparison View - Placeholder';
}

// Path: advancedDiff
class _TranslationsAdvancedDiffDe implements TranslationsAdvancedDiffEn {
	_TranslationsAdvancedDiffDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get saveAllChanges => 'Alle Änderungen speichern?';
	@override String saveConfirmation({required Object count}) => 'Dies speichert alle ${count} geänderten Einträge in die Zieldatei. Dies kann nicht rückgängig gemacht werden.';
	@override String get changesSaved => 'Änderungen erfolgreich gespeichert.';
	@override String get csvExported => 'CSV exportiert';
	@override String get unsavedChanges => 'Ungespeicherte Änderungen';
	@override String get unsavedChangesWarning => 'Sie haben ungespeicherte Änderungen. Sind Sie sicher, dass Sie diese verwerfen wollen?';
	@override String get discardChanges => 'Änderungen verwerfen';
	@override String get goBack => 'Zurück';
	@override String get breadcrumbs => 'Home  >  Editor';
	@override String unsaved({required Object count}) => '${count} ungesichert';
	@override String reviewed({required Object count}) => '${count} geprüft';
	@override String saveAll({required Object count}) => 'Alle speichern (${count})';
	@override String get allSaved => 'Alle gespeichert';
	@override String get saveAllTooltip => 'Alle Änderungen speichern (Ctrl+S)';
	@override String get exportTooltip => 'Daten exportieren (Ctrl+E)';
	@override late final _TranslationsAdvancedDiffAiSuggestionDe aiSuggestion = _TranslationsAdvancedDiffAiSuggestionDe._(_root);
	@override late final _TranslationsAdvancedDiffDetailEditDe detailEdit = _TranslationsAdvancedDiffDetailEditDe._(_root);
	@override late final _TranslationsAdvancedDiffTableDe table = _TranslationsAdvancedDiffTableDe._(_root);
	@override late final _TranslationsAdvancedDiffDiffRowDe diffRow = _TranslationsAdvancedDiffDiffRowDe._(_root);
	@override late final _TranslationsAdvancedDiffStatusDe status = _TranslationsAdvancedDiffStatusDe._(_root);
	@override late final _TranslationsAdvancedDiffSidebarDe sidebar = _TranslationsAdvancedDiffSidebarDe._(_root);
}

// Path: issueDetails
class _TranslationsIssueDetailsDe implements TranslationsIssueDetailsEn {
	_TranslationsIssueDetailsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Problem Details';
	@override String showingIssues({required Object count, required Object total}) => 'Zeige ${count} von ${total} Problemen';
	@override String get searchPlaceholder => 'Suchen nach Schlüssel, Text oder Fehler...';
	@override String get noDetails => 'Keine Details verfügbar.';
	@override String get noMatches => 'Keine Treffer gefunden.';
	@override String get showMore => 'Mehr anzeigen';
	@override String copyItems({required Object count}) => '${count} Elemente kopieren';
	@override String get close => 'Schließen';
	@override String get copied => 'In Zwischenablage kopiert';
	@override String copiedCount({required Object count}) => '${count} Elemente kopiert';
	@override late final _TranslationsIssueDetailsDuplicateValueDe duplicateValue = _TranslationsIssueDetailsDuplicateValueDe._(_root);
	@override late final _TranslationsIssueDetailsLengthOutlierDe lengthOutlier = _TranslationsIssueDetailsLengthOutlierDe._(_root);
	@override late final _TranslationsIssueDetailsStandardDe standard = _TranslationsIssueDetailsStandardDe._(_root);
	@override String get review => 'Prüfen';
	@override late final _TranslationsIssueDetailsTypesDe types = _TranslationsIssueDetailsTypesDe._(_root);
	@override late final _TranslationsIssueDetailsNotesDe notes = _TranslationsIssueDetailsNotesDe._(_root);
	@override late final _TranslationsIssueDetailsFallbacksDe fallbacks = _TranslationsIssueDetailsFallbacksDe._(_root);
}

// Path: importReview
class _TranslationsImportReviewDe implements TranslationsImportReviewEn {
	_TranslationsImportReviewDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Projektimport prüfen';
	@override String get projectName => 'Projektname';
	@override String get created => 'Erstellt';
	@override String get historyItems => 'Verlaufselemente';
	@override String get customSettingsTitle => 'Benutzerdefinierte Einstellungen erkannt';
	@override String get customSettingsWarning => 'Dieses Projekt enthält benutzerdefinierte Einstellungen, die Ihre Standards überschreiben, solange dieses Projekt geöffnet ist.';
	@override String get standardSettings => 'Dieses Projekt verwendet globale Standardeinstellungen.';
	@override String get cancelImport => 'Import abbrechen';
	@override String get trustOpen => 'Vertrauen & Projekt öffnen';
}

// Path: historyView
class _TranslationsHistoryViewDe implements TranslationsHistoryViewEn {
	_TranslationsHistoryViewDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vergleichsverlauf';
	@override String get clearAll => 'Gesamten Verlauf löschen';
	@override String get searchPlaceholder => 'Nach Dateinamen suchen...';
	@override String get sortBy => 'Sortieren nach';
	@override String get sortDate => 'Datum';
	@override String get sortSource => 'Quelldatei';
	@override String get sortTarget => 'Zieldatei';
	@override String get showCurrentProject => 'Zeige: Aktuelles Projekt';
	@override String get showAllHistory => 'Zeige: Gesamten Verlauf';
	@override String get groupByFolder => 'Nach Ordner gruppieren';
	@override String get disableGrouping => 'Gruppierung deaktivieren';
	@override String get filterAll => 'Alle';
	@override String get filterFiles => 'Dateien';
	@override String get filterDirectories => 'Verzeichnisse';
	@override String get filterGit => 'Git';
	@override String get noHistory => 'Noch kein Vergleichsverlauf';
	@override String get historyDescription => 'Ihre Dateivergleiche erscheinen hier';
	@override String get noResults => 'Keine Ergebnisse gefunden';
	@override String get adjustSearch => 'Versuchen Sie, Ihre Suche anzupassen';
	@override String get clearConfirmationTitle => 'Gesamten Verlauf löschen?';
	@override String get clearConfirmationContent => 'Dies löscht den gesamten Vergleichsverlauf dauerhaft. Dies kann nicht rückgängig gemacht werden.';
	@override String get clearAction => 'Alles löschen';
	@override String get deletedMessage => 'Verlaufselement gelöscht';
	@override String get undo => 'Rückgängig';
	@override String get viewDetails => 'Details anzeigen';
	@override String get delete => 'Löschen';
	@override String get openLocation => 'Dateipfad öffnen';
	@override String get bilingual => 'Bilingual';
	@override String get filePair => 'Dateipaar';
	@override String get directory => 'Verzeichnis';
	@override String get git => 'Git';
	@override String get repo => 'Repo';
	@override String get sourceDir => 'Quell-Verz.';
	@override String get targetDir => 'Ziel-Verz.';
	@override String get source => 'Quelle';
	@override String get target => 'Ziel';
	@override String get noChanges => 'Keine Änderungen erkannt';
	@override String get added => 'Hinzugefügt';
	@override String get removed => 'Entfernt';
	@override String get modified => 'Geändert';
	@override String get same => 'Gleich';
	@override String get total => 'Gesamt';
	@override String get currentProject => 'Aktuelles Projekt';
	@override String get unassigned => 'Nicht zugewiesen';
	@override String get project => 'Projekt';
}

// Path: compare
class _TranslationsCompareDe implements TranslationsCompareEn {
	_TranslationsCompareDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dateien vergleichen';
	@override String get sourceFile => 'Quelldatei';
	@override String get targetFile => 'Zieldatei';
	@override String get sourceFolder => 'Quellordner';
	@override String get targetFolder => 'Zielordner';
	@override String get dropFilesHint => 'Lokalisierungsdateien hier ablegen oder Durchsuchen-Buttons nutzen, um Dateien für den Vergleich auszuwählen.';
	@override String get selectSourceFile => 'Quelldatei wählen';
	@override String get selectTargetFile => 'Zieldatei wählen';
	@override String get startComparison => 'Vergleich starten';
	@override String get comparing => 'Vergleiche...';
	@override String get comparisonComplete => 'Vergleich abgeschlossen';
	@override String get noChanges => 'Keine Änderungen erkannt';
	@override String get filesIdentical => 'Dateien sind identisch';
	@override String changesFound({required Object count}) => '${count} Änderungen gefunden';
	@override late final _TranslationsCompareTabsDe tabs = _TranslationsCompareTabsDe._(_root);
	@override late final _TranslationsCompareFileTypesDe fileTypes = _TranslationsCompareFileTypesDe._(_root);
}

// Path: history
class _TranslationsHistoryDe implements TranslationsHistoryEn {
	_TranslationsHistoryDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verlauf';
	@override String get recentComparisons => 'Letzte Vergleiche';
	@override String get noHistory => 'Noch kein Vergleichsverlauf';
	@override String get noHistoryDescription => 'Ihr Vergleichsverlauf wird hier erscheinen';
	@override String get clearHistory => 'Verlauf löschen';
	@override String get clearHistoryConfirm => 'Sind Sie sicher, dass Sie den gesamten Verlauf löschen wollen?';
	@override String get deleteEntry => 'Eintrag löschen';
	@override String get openComparison => 'Vergleich öffnen';
	@override late final _TranslationsHistoryTimeAgoDe timeAgo = _TranslationsHistoryTimeAgoDe._(_root);
}

// Path: projects
class _TranslationsProjectsDe implements TranslationsProjectsEn {
	_TranslationsProjectsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Projekte';
	@override String get createProject => 'Projekt erstellen';
	@override String get importProject => 'Projekt importieren';
	@override String get noProjects => 'Noch keine Projekte';
	@override String get noProjectsDescription => 'Erstellen Sie ein Projekt, um Ihre Lokalisierungsdateien zu organisieren';
	@override String get projectName => 'Projektname';
	@override String get projectPath => 'Projektpfad';
	@override String get lastOpened => 'Zuletzt geöffnet';
	@override String get openProject => 'Projekt öffnen';
	@override String get closeProject => 'Projekt schließen';
	@override String get deleteProject => 'Projekt löschen';
	@override String get deleteProjectConfirm => 'Sind Sie sicher, dass Sie dieses Projekt löschen wollen?';
	@override String get exportProject => 'Projekt exportieren';
	@override String get exportDescription => 'Erstellen Sie eine portable ZIP-Datei mit Quelldateien, Konfiguration und Verlauf.';
	@override String get exporting => 'Exportiere Projekt...';
	@override String get exportSuccess => 'Projekt exportiert';
	@override String exportError({required Object error}) => 'Export fehlgeschlagen: ${error}';
	@override String get createNewProject => 'Neues Projekt erstellen';
	@override String get openExistingProject => 'Vorhandenes Projekt öffnen';
	@override String get importProjectZip => 'Projekt-ZIP importieren';
	@override String get projectResources => 'Projektressourcen';
	@override String get recentProjects => 'Letzte Projekte';
	@override String get noRecentProjects => 'Keine letzten Projekte';
	@override String get selectProjectZip => 'Projekt-ZIP wählen';
	@override String get selectDestination => 'Zielordner für Import wählen';
	@override String get importing => 'Importiere Projekt...';
	@override String get importSuccess => 'Projekt erfolgreich importiert';
	@override String importFailed({required Object error}) => 'Import fehlgeschlagen: ${error}';
	@override String get importingFiles => 'Importiere Dateien...';
	@override String get noSupportedFiles => 'Keine unterstützten Dateien abgelegt.';
	@override late final _TranslationsProjectsStatsDe stats = _TranslationsProjectsStatsDe._(_root);
	@override String get openProjectFirst => 'Öffnen Sie zuerst ein Projekt, um dessen Ressourcen zu verwalten.';
	@override String get removeFromRecent => 'Aus "Zuletzt" entfernen';
	@override late final _TranslationsProjectsSelectionDe selection = _TranslationsProjectsSelectionDe._(_root);
	@override late final _TranslationsProjectsCreateDialogDe createDialog = _TranslationsProjectsCreateDialogDe._(_root);
	@override late final _TranslationsProjectsIndicatorDe indicator = _TranslationsProjectsIndicatorDe._(_root);
	@override late final _TranslationsProjectsGlossaryDe glossary = _TranslationsProjectsGlossaryDe._(_root);
	@override late final _TranslationsProjectsConflictsDe conflicts = _TranslationsProjectsConflictsDe._(_root);
	@override late final _TranslationsProjectsTmDe tm = _TranslationsProjectsTmDe._(_root);
}

// Path: diff
class _TranslationsDiffDe implements TranslationsDiffEn {
	_TranslationsDiffDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get added => 'Hinzugefügt';
	@override String get removed => 'Entfernt';
	@override String get modified => 'Geändert';
	@override String get unchanged => 'Unverändert';
	@override String get missing => 'Fehlt';
	@override String get extra => 'Extra';
	@override String get sourceValue => 'Quellwert';
	@override String get targetValue => 'Zielwert';
	@override String get key => 'Schlüssel';
	@override String get status => 'Status';
	@override String get actions => 'Aktionen';
	@override String get copyToTarget => 'Kopieren nach Ziel';
	@override String get acceptChange => 'Änderung akzeptieren';
	@override String get rejectChange => 'Änderung ablehnen';
	@override String get viewDetails => 'Details anzeigen';
}

// Path: git
class _TranslationsGitDe implements TranslationsGitEn {
	_TranslationsGitDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Git-Vergleich';
	@override String get selectRepository => 'Repository wählen';
	@override String get selectBranch => 'Branch wählen';
	@override String get selectCommit => 'Commit wählen';
	@override String get compareBranches => 'Branches vergleichen';
	@override String get compareCommits => 'Commits vergleichen';
	@override String get baseBranch => 'Basis-Branch';
	@override String get compareBranch => 'Vergleichs-Branch';
	@override String get noRepositories => 'Keine Git-Repositories gefunden';
	@override String get noRepositoriesDescription => 'Öffnen Sie einen Ordner mit einem Git-Repository';
	@override String filesChanged({required Object count}) => '${count} Dateien geändert';
	@override String additions({required Object count}) => '${count} Ergänzungen';
	@override String deletions({required Object count}) => '${count} Löschungen';
	@override late final _TranslationsGitConflictsDe conflicts = _TranslationsGitConflictsDe._(_root);
}

// Path: quality
class _TranslationsQualityDe implements TranslationsQualityEn {
	_TranslationsQualityDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get _translatorNote => 'API und Metrik-Begriffe (Requests, Tokens, Characters, Prompt, Completion, Export) sollten auf Englisch bleiben, um Konsistenz mit Industrietermini zu wahren.';
	@override String get title => 'Qualitäts-Dashboard';
	@override String get overallScore => 'Gesamtpunktzahl';
	@override String get issues => 'Probleme';
	@override String get warnings => 'Warnungen';
	@override String get suggestions => 'Vorschläge';
	@override String get placeholderMismatch => 'Platzhalter-Fehler';
	@override String get placeholderMismatchDescription => 'Platzhalter wie {name} stimmen nicht überein';
	@override String get lengthOutlier => 'Längenabweichung';
	@override String get lengthOutlierDescription => 'Übersetzungslänge weicht stark ab';
	@override String get duplicateValue => 'Doppelter Wert';
	@override String get duplicateValueDescription => 'Gleiche Übersetzung für mehrere Schlüssel';
	@override String get missingTranslation => 'Fehlende Übersetzung';
	@override String get missingTranslationDescription => 'Übersetzung fehlt für diesen Schlüssel';
	@override String get loading => 'Lade Dashboard...';
	@override String get errorLoading => 'Wir konnten Ihren Verlauf nicht laden. Versuchen Sie es erneut.';
	@override String get emptyState => 'Führen Sie einen Vergleich aus, um Ihr Dashboard zu sehen.';
	@override String get refresh => 'Aktualisieren';
	@override String get buildingInsights => 'Erstelle Einblicke...';
	@override String get crunchingNumbers => 'Zahlen werden verarbeitet...';
	@override String get errorBuilding => 'Wir konnten das Dashboard nicht erstellen. Versuchen Sie es erneut.';
	@override String get noUsableData => 'Noch keine brauchbaren Daten gefunden.';
	@override String get languages => 'Sprachen';
	@override String get averageCoverage => 'Durchschnittliche Abdeckung';
	@override String get potentialIssues => 'Potenzielle Probleme';
	@override String get translationCoverage => 'Übersetzungsabdeckung';
	@override String entriesTranslated({required Object translated, required Object total}) => '${translated} von ${total} Einträgen übersetzt';
	@override String get wordsAddedOverTime => 'Hinzugefügte Wörter im Zeitverlauf';
	@override String get completionVsScope => 'Fertigstellung vs. Umfang';
	@override String get scopeVsProgress => 'Umfang vs. Fortschritt';
	@override String get coveragePercent => 'Abdeckung %';
	@override String get wordsAdded => 'Hinzugefügte Wörter';
	@override String get words => 'Wörter';
	@override String get coverage => 'Abdeckung';
	@override String get scope => 'Umfang';
	@override String get latest => 'Neueste';
	@override String get added => 'Hinzugefügt';
	@override String get change => 'Änderung';
	@override String get totalScope => 'Gesamtumfang';
	@override String get scopeGrowth => 'Umfangswachstum';
	@override String get range => 'Bereich';
	@override String get aiUsage => 'KI & Übersetzungsnutzung';
	@override String lastUsed({required Object date}) => 'Zuletzt genutzt ${date}';
	@override String get noIssuesFound => 'Keine Probleme in den letzten Vergleichen gefunden.';
	@override String get placeholderMismatches => 'Platzhalter-Fehler';
	@override String get placeholderMismatchesDesc => 'Marker wie {name} stimmen nicht überein.';
	@override String get lengthOutliers => 'Sehr kurze oder lange Übersetzungen';
	@override String get lengthOutliersDesc => 'Länge sieht ungewöhnlich im Vergleich zur Quelle aus.';
	@override String get duplicateValues => 'Doppelte Werte';
	@override String get duplicateValuesDesc => 'Die gleiche Übersetzung wird mehrfach verwendet.';
	@override String get placeholderDialogTitle => 'Platzhalter-Fehler';
	@override String get placeholderDialogDesc => 'Diese Übersetzungen haben andere Platzhalter ({name}) als die Quelle.';
	@override String get lengthDialogTitle => 'Längenabweichungen';
	@override String get lengthDialogDesc => 'Diese Übersetzungen sind deutlich kürzer oder länger als die Quelle.';
	@override String get duplicateDialogTitle => 'Doppelte Werte';
	@override String get duplicateDialogDesc => 'Diese Übersetzungen erscheinen mehrfach.';
	@override String duplicateSample({required Object value}) => 'Duplikat: "${value}"';
	@override String get exportError => 'Konnte Bericht nicht erstellen. Bitte versuchen Sie es erneut.';
	@override String get noDataToExport => 'Keine Daten zum Exportieren';
	@override String get exportFailed => 'Export fehlgeschlagen';
	@override String get exportDialogTitle => 'Qualitätsbericht exportieren';
	@override String get reportSaved => 'Bericht gespeichert';
	@override String get export => 'Exportieren';
	@override String get requests => 'Anfragen';
	@override String get tokens => 'Tokens';
	@override String get characters => 'Zeichen';
	@override String get estCost => 'Gesch. Kosten';
	@override String get prompt => 'Prompt';
	@override String get completion => 'Completion';
	@override String get showingCurrentProject => 'Zeige: Aktuelles Projekt';
	@override String get showingAllHistory => 'Zeige: Gesamten Verlauf';
	@override String get filesSkipped => 'Einige Dateien wurden übersprungen, da sie nicht gefunden wurden.';
}

// Path: errors
class _TranslationsErrorsDe implements TranslationsErrorsEn {
	_TranslationsErrorsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get genericError => 'Ein Fehler ist aufgetreten';
	@override String get fileNotFound => 'Datei nicht gefunden';
	@override String get invalidFormat => 'Ungültiges Dateiformat';
	@override String get parseError => 'Fehler beim Parsen der Datei';
	@override String get networkError => 'Netzwerkfehler. Bitte überprüfen Sie Ihre Verbindung.';
	@override String get permissionDenied => 'Zugriff verweigert';
	@override String get unknownError => 'Ein unbekannter Fehler ist aufgetreten';
}

// Path: wizards
class _TranslationsWizardsDe implements TranslationsWizardsEn {
	_TranslationsWizardsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsWizardsFirstRunDe firstRun = _TranslationsWizardsFirstRunDe._(_root);
}

// Path: dialogs
class _TranslationsDialogsDe implements TranslationsDialogsEn {
	_TranslationsDialogsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogsAddIgnorePatternDe addIgnorePattern = _TranslationsDialogsAddIgnorePatternDe._(_root);
	@override late final _TranslationsDialogsDiffViewerDe diffViewer = _TranslationsDialogsDiffViewerDe._(_root);
}

// Path: grid
class _TranslationsGridDe implements TranslationsGridEn {
	_TranslationsGridDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsGridColumnsDe columns = _TranslationsGridColumnsDe._(_root);
}

// Path: tutorial
class _TranslationsTutorialDe implements TranslationsTutorialEn {
	_TranslationsTutorialDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get skipTutorial => 'TUTORIAL ÜBERSPRINGEN';
	@override String get finishMessage => 'Alles fertig! Tippen Sie irgendwo, um abzuschließen.';
	@override String get next => 'Weiter';
	@override String get loadSampleData => 'Beispieldaten laden';
	@override String get browseSourceFile => 'Quelldatei suchen';
	@override String get browseTargetFile => 'Zieldatei suchen';
	@override String get compareFiles => 'Dateien vergleichen';
	@override String get hintPhase2 => 'Nächstes: Filter, Suche, Erweiterte Ansicht und Export.';
	@override late final _TranslationsTutorialStepsDe steps = _TranslationsTutorialStepsDe._(_root);
}

// Path: friendlyErrors
class _TranslationsFriendlyErrorsDe implements TranslationsFriendlyErrorsEn {
	_TranslationsFriendlyErrorsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsFriendlyErrorsFileNotFoundDe fileNotFound = _TranslationsFriendlyErrorsFileNotFoundDe._(_root);
	@override late final _TranslationsFriendlyErrorsAccessDeniedDe accessDenied = _TranslationsFriendlyErrorsAccessDeniedDe._(_root);
	@override late final _TranslationsFriendlyErrorsIsDirectoryDe isDirectory = _TranslationsFriendlyErrorsIsDirectoryDe._(_root);
	@override late final _TranslationsFriendlyErrorsFileAccessDe fileAccess = _TranslationsFriendlyErrorsFileAccessDe._(_root);
	@override late final _TranslationsFriendlyErrorsUnsupportedFormatDe unsupportedFormat = _TranslationsFriendlyErrorsUnsupportedFormatDe._(_root);
	@override late final _TranslationsFriendlyErrorsNetworkErrorDe networkError = _TranslationsFriendlyErrorsNetworkErrorDe._(_root);
	@override late final _TranslationsFriendlyErrorsNotGitRepoDe notGitRepo = _TranslationsFriendlyErrorsNotGitRepoDe._(_root);
	@override late final _TranslationsFriendlyErrorsMergeConflictDe mergeConflict = _TranslationsFriendlyErrorsMergeConflictDe._(_root);
	@override late final _TranslationsFriendlyErrorsGitAuthFailedDe gitAuthFailed = _TranslationsFriendlyErrorsGitAuthFailedDe._(_root);
	@override late final _TranslationsFriendlyErrorsGitOperationFailedDe gitOperationFailed = _TranslationsFriendlyErrorsGitOperationFailedDe._(_root);
	@override late final _TranslationsFriendlyErrorsInvalidJsonDe invalidJson = _TranslationsFriendlyErrorsInvalidJsonDe._(_root);
	@override late final _TranslationsFriendlyErrorsRateLimitReachedDe rateLimitReached = _TranslationsFriendlyErrorsRateLimitReachedDe._(_root);
	@override late final _TranslationsFriendlyErrorsInvalidApiKeyDe invalidApiKey = _TranslationsFriendlyErrorsInvalidApiKeyDe._(_root);
	@override late final _TranslationsFriendlyErrorsTranslationServiceErrorDe translationServiceError = _TranslationsFriendlyErrorsTranslationServiceErrorDe._(_root);
	@override late final _TranslationsFriendlyErrorsOutOfMemoryDe outOfMemory = _TranslationsFriendlyErrorsOutOfMemoryDe._(_root);
	@override late final _TranslationsFriendlyErrorsGenericErrorDe genericError = _TranslationsFriendlyErrorsGenericErrorDe._(_root);
}

// Path: systemTray
class _TranslationsSystemTrayDe implements TranslationsSystemTrayEn {
	_TranslationsSystemTrayDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get showLocalizer => 'Localizer anzeigen';
	@override String get exit => 'Beenden';
}

// Path: validation
class _TranslationsValidationDe implements TranslationsValidationEn {
	_TranslationsValidationDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get connected => 'Verbunden.';
	@override String get connectionTimeout => 'Zeitüberschreitung. Bitte erneut versuchen.';
	@override String get couldNotConnect => 'Konnte nicht verbinden. Bitte erneut versuchen.';
	@override String get checkKeyAndTryAgain => 'Konnte nicht verbinden. Prüfen Sie den Schlüssel.';
	@override String get tryAgainLater => 'Konnte nicht verbinden. Bitte später versuchen.';
	@override String get serviceUnavailable => 'Dienst gerade nicht verfügbar. Bitte später versuchen.';
	@override String get enterKeyFirst => 'Bitte geben Sie zuerst einen Schlüssel ein.';
	@override String get checking => 'Prüfe...';
	@override String deeplUsage({required Object used, required Object limit}) => 'Verbrauch: ${used} / ${limit} Zeichen.';
}

// Path: status
class _TranslationsStatusDe implements TranslationsStatusEn {
	_TranslationsStatusDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get startingComparison => 'Starte Vergleich...';
	@override String get loadingFromHistory => 'Lade Dateien aus Verlauf...';
	@override String get comparisonComplete => 'Vergleich abgeschlossen';
	@override String get couldNotImportFiles => 'Konnte Dateien nicht importieren. Bitte erneut versuchen.';
	@override String get historyFilesNotFound => 'Eine oder beide Dateien aus dem Verlauf nicht am Originalpfad gefunden.';
}

// Path: aiServices
class _TranslationsAiServicesDe implements TranslationsAiServicesEn {
	_TranslationsAiServicesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get geminiEmptyResponse => 'Gemini lieferte leere Antwort';
	@override String get geminiStreamingEmpty => 'Gemini Streaming lieferte leere Antwort';
	@override String get geminiRephraseEmpty => 'Gemini lieferte leere Antwort für Umformulierung';
	@override String get openaiEmptyResponse => 'OpenAI lieferte leere oder fehlgeschlagene Antwort';
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceDe implements TranslationsSettingsAppearanceEn {
	_TranslationsSettingsAppearanceDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Erscheinungsbild';
	@override String get description => 'Passen Sie das Aussehen der App an';
	@override String get theme => 'Design-Modus';
	@override String get themeDescription => 'Wählen Sie zwischen Hell, Dunkel oder System';
	@override String get themeSystem => 'System';
	@override String get themeLight => 'Hell';
	@override String get themeDark => 'Dunkel';
	@override String get themeAmoled => 'AMOLED';
	@override String get accentColor => 'Akzentfarbe';
	@override String get accentColorDescription => 'Wählen Sie Ihre bevorzugte Akzentfarbe';
	@override String get useMicaEffect => 'Mica-Effekt verwenden';
	@override String get micaDescription => 'Windows 11 Mica-Transparenzeffekt aktivieren';
	@override String get diffFontSize => 'Diff Schriftgröße';
	@override String get diffFontSizeDescription => 'Schriftgröße der Vergleichsansicht anpassen';
	@override String get diffFontFamily => 'Diff Schriftart';
	@override String get diffFontFamilyDescription => 'Schriftart für die Vergleichsansicht';
	@override String get systemDefault => 'Systemstandard';
	@override String get pickAccentColor => 'Akzentfarbe wählen';
	@override String get diffColors => 'Diff Farben';
	@override String get presetsTitle => 'Vorlagen';
	@override late final _TranslationsSettingsAppearancePresetsDe presets = _TranslationsSettingsAppearancePresetsDe._(_root);
	@override String get identical => 'Identisch';
	@override String pickColorFor({required Object label}) => 'Farbe für ${label} wählen';
	@override String get livePreview => 'Live-Vorschau';
	@override late final _TranslationsSettingsAppearancePreviewDe preview = _TranslationsSettingsAppearancePreviewDe._(_root);
}

// Path: settings.general
class _TranslationsSettingsGeneralDe implements TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Allgemein';
	@override String get description => 'Allgemeine Anwendungseinstellungen';
	@override String get language => 'Sprache';
	@override String get languageDescription => 'Wählen Sie Ihre bevorzugte Sprache';
	@override String get startMinimized => 'Minimiert im Tray starten';
	@override String get startMinimizedDescription => 'App minimiert im System-Tray starten';
	@override String get rememberWindowPosition => 'Fensterposition merken';
	@override String get rememberWindowPositionDescription => 'Fenstergröße und -position beim Start wiederherstellen';
	@override String get openLastProject => 'Letztes Projekt beim Start öffnen';
	@override String get openLastProjectDescription => 'Automatisch das zuletzt verwendete Projekt öffnen';
	@override String get application => 'Anwendung';
	@override String get defaultView => 'Standardansicht';
	@override String get defaultViewDescription => 'Ansicht beim Start';
	@override String get autoCheckUpdates => 'Automatisch nach Updates suchen';
	@override String get autoCheckUpdatesDescription => 'Beim Start nach Updates suchen';
	@override String get startupOptions => 'Startoptionen';
	@override String get languageAuto => 'Automatisch erkennen';
	@override String get viewBasic => 'Dateivergleich';
	@override String get viewHistory => 'Verlauf';
	@override String get viewDashboard => 'Qualitäts-Dashboard';
	@override String get viewDirectory => 'Ordnervergleich';
	@override String get viewLastUsed => 'Zuletzt verwendete Ansicht';
}

// Path: settings.scope
class _TranslationsSettingsScopeDe implements TranslationsSettingsScopeEn {
	_TranslationsSettingsScopeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Einstellungsbereich';
	@override String get global => 'Globale Standards';
	@override String get project => 'Projekt';
	@override String get reset => 'Projekt auf globale Standards zurücksetzen';
	@override String get resetConfirmation => 'Dies löscht alle Überschreibungen für dieses Projekt und kehrt zu globalen Standards zurück. Dies kann nicht rückgängig gemacht werden.';
	@override String get globalDescription => 'Änderungen gelten für alle Projekte, sofern nicht überschrieben.';
	@override String projectDescription({required Object name}) => 'Änderungen gelten nur für "${name}". Andere Einstellungen erben von globalen Standards.';
	@override String get createPrompt => 'Erstellen Sie ein Projekt, um Einstellungen für bestimmte Ordner anzupassen';
}

// Path: settings.searchKeywords
class _TranslationsSettingsSearchKeywordsDe implements TranslationsSettingsSearchKeywordsEn {
	_TranslationsSettingsSearchKeywordsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override List<String> get general => [
		'Language',
		'Default View',
		'Recent Files Count',
		'Open Last Project',
		'Confirm Before Exit',
		'Show Notifications',
	];
	@override List<String> get comparisonEngine => [
		'Comparison Mode',
		'Similarity Threshold',
		'Case Sensitive',
		'Ignore Whitespace',
		'Ignore Empty Lines',
		'Ignore Comments',
		'Ignore Patterns',
	];
	@override List<String> get appearance => [
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
	@override List<String> get fileHandling => [
		'Source Format',
		'Target Format',
		'Default Encoding',
		'Recent Project Count',
		'Translation Memory',
		'Import Memory',
		'Export Memory',
		'Clear Memory',
	];
	@override List<String> get aiServices => [
		'OpenAI API Key',
		'Anthropic API Key',
		'Google AI API Key',
		'AI Model',
		'Temperature',
		'Custom Prompt',
	];
	@override List<String> get systemIntegrations => [
		'System Tray',
		'Start Minimized',
		'File Associations',
		'Mica Effect',
		'Vibrancy',
		'Window Material',
		'Dock Badge',
		'Untranslated Count',
	];
	@override List<String> get projectResources => [
		'Glossary',
		'Translation Memory',
		'Terminology',
	];
	@override List<String> get about => [
		'Version',
		'Check Updates',
		'Auto Update',
		'Changelog',
		'License',
		'Privacy Policy',
		'Telemetry',
		'Crash Reporting',
	];
	@override List<String> get developer => [
		'Performance Overlay',
		'Semantics Debugger',
		'Material Grid',
		'Raster Cache',
		'Restart Tutorial',
		'Factory Reset',
	];
}

// Path: settings.comparison
class _TranslationsSettingsComparisonDe implements TranslationsSettingsComparisonEn {
	_TranslationsSettingsComparisonDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vergleich';
	@override String get description => 'Vergleichsverhalten konfigurieren';
	@override String get caseSensitive => 'Groß-/Kleinschreibung beachten';
	@override String get caseSensitiveDescription => 'Groß- und Kleinbuchstaben als unterschiedlich behandeln';
	@override String get ignoreWhitespace => 'Leerzeichen ignorieren';
	@override String get ignoreWhitespaceDescription => 'Führende/abschließende Leerzeichen beim Vergleich ignorieren';
	@override String get showLineNumbers => 'Zeilennummern anzeigen';
	@override String get showLineNumbersDescription => 'Zeilennummern in der Diff-Ansicht anzeigen';
	@override String get behavior => 'Vergleichsverhalten';
	@override String get ignoreCase => 'Groß-/Kleinschreibung ignorieren';
	@override String get ignoreCaseDescription => '"Key" und "key" als gleich behandeln';
	@override String get similarityThreshold => 'Ähnlichkeitsschwelle';
	@override String get similarityThresholdDescription => 'Minimale Ähnlichkeit für "Geändert"-Erkennung';
	@override String get mode => 'Vergleichsmodus';
	@override String get modeDescription => 'Wie Einträge zwischen Dateien abgeglichen werden';
	@override String get modeKey => 'Schlüssel-basiert';
	@override String get modeKeyDescription => 'Gleicht nach Schlüsselnamen ab (Standard).';
	@override String get modeOrder => 'Reihenfolge-basiert';
	@override String get modeOrderDescription => 'Gleicht nach Position in der Datei ab.';
	@override String get modeSmart => 'Smart Match';
	@override String get modeSmartDescription => 'Erkennt verschobene/umbenannte Schlüssel.';
	@override String get ignorePatterns => 'Muster ignorieren';
	@override String get noIgnorePatterns => 'Keine Ignorier-Muster gesetzt.';
	@override String get addPattern => 'Muster hinzufügen';
	@override String get resetToGlobal => 'Alle Vergleichseinstellungen auf globale Standards zurücksetzen';
	@override late final _TranslationsSettingsComparisonPatternPresetsDe patternPresets = _TranslationsSettingsComparisonPatternPresetsDe._(_root);
	@override late final _TranslationsSettingsComparisonPreviewMatchDe previewMatch = _TranslationsSettingsComparisonPreviewMatchDe._(_root);
	@override late final _TranslationsSettingsComparisonColorPresetsDe colorPresets = _TranslationsSettingsComparisonColorPresetsDe._(_root);
}

// Path: settings.fileHandling
class _TranslationsSettingsFileHandlingDe implements TranslationsSettingsFileHandlingEn {
	_TranslationsSettingsFileHandlingDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get fileFormats => 'Dateiformate';
	@override String get sourceFormat => 'Quellformat';
	@override String get targetFormat => 'Zielformat';
	@override String get encoding => 'Kodierung';
	@override String get sourceEncoding => 'Quellkodierung';
	@override String get targetEncoding => 'Zielkodierung';
	@override String get autoDetect => 'Automatisch erkennen';
	@override String get autoDetectEncodingDescription => 'Dateikodierung automatisch erkennen';
	@override String get exportSettings => 'Exporteinstellungen';
	@override String get defaultExportFormat => 'Standard-Exportformat';
	@override String get includeUtf8Bom => 'UTF-8 BOM einschließen';
	@override String get includeUtf8BomDescription => 'Erforderlich für Excel-Kompatibilität';
	@override String get openFolderAfterExport => 'Ordner nach Export öffnen';
	@override String get fileSafety => 'Dateisicherheit';
	@override String get fileSafetyDescription => 'Automatische lokale Kopien zur Wiederherstellung.';
	@override String get resetToGlobal => 'Alle Dateihandhabungs-Einstellungen auf globale Standards zurücksetzen';
}

// Path: settings.translationMemory
class _TranslationsSettingsTranslationMemoryDe implements TranslationsSettingsTranslationMemoryEn {
	_TranslationsSettingsTranslationMemoryDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Globales Übersetzungs-Memory';
	@override String get autoLearn => 'Automatisch lernen';
	@override String get autoLearnDescription => 'Übersetzungen zur Wiederverwendung speichern';
	@override String get confidenceThreshold => 'Konfidenzschwelle';
	@override String confidenceThresholdDescription({required Object percent}) => 'Mindestwert für automatische Anwendung (${percent}%)';
	@override String get entries => 'Einträge';
	@override String get size => 'Größe';
	@override String memorySize({required Object size}) => 'Speichergröße: ${size}';
	@override String get import => 'Importieren';
	@override String get exportTmx => 'TMX exportieren';
	@override String get exportCsv => 'CSV exportieren';
	@override String get clearMemory => 'Speicher leeren';
	@override String importedItems({required Object count}) => '${count} Einträge importiert.';
	@override String get noItemsAdded => 'Keine Einträge hinzugefügt.';
	@override String get nothingToExport => 'Nichts zu exportieren.';
	@override String get tmxSaved => 'TMX gespeichert';
	@override String get csvSaved => 'CSV gespeichert';
	@override String get clearConfirmTitle => 'Übersetzungs-Memory leeren?';
	@override String get clearConfirmContent => 'Dies löscht alle gespeicherten Übersetzungspaare auf diesem Gerät. Dies kann nicht rückgängig gemacht werden.';
	@override String get cleared => 'Übersetzungs-Memory geleert.';
	@override String get couldNotClear => 'Speicher konnte nicht geleert werden.';
}

// Path: settings.backup
class _TranslationsSettingsBackupDe implements TranslationsSettingsBackupEn {
	_TranslationsSettingsBackupDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Auto-Backup';
	@override String get description => 'Automatische Backup-Einstellungen';
	@override String get enabled => 'Auto-Backup aktivieren';
	@override String get enabledDescription => 'Dateien vor Änderungen automatisch sichern';
	@override String get maxCopies => 'Maximale Backup-Kopien';
	@override String get maxCopiesDescription => 'Anzahl der zu behaltenden Kopien pro Datei';
	@override String activeStatus({required Object count}) => 'Aktiv · Behalte ${count} Kopien';
	@override String get folder => 'Backup-Ordner';
	@override String get folderDescription => 'Leer lassen, um den gleichen Ordner zu verwenden';
	@override String get useOriginalFolder => 'Originalordner verwenden';
}

// Path: settings.ai
class _TranslationsSettingsAiDe implements TranslationsSettingsAiEn {
	_TranslationsSettingsAiDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'KI-Dienste';
	@override String get description => 'KI-Übersetzung und Assistenz konfigurieren';
	@override String get provider => 'KI-Anbieter';
	@override String get providerDescription => 'Wählen Sie Ihren bevorzugten KI-Dienstleister';
	@override String get apiKey => 'API-Schlüssel';
	@override String get apiKeyDescription => 'Geben Sie Ihren API-Schlüssel für den gewählten Anbieter ein';
	@override String get apiKeyPlaceholder => 'API-Schlüssel eingeben...';
	@override String get testConnection => 'Verbindung testen';
	@override String get connectionSuccess => 'Verbindung erfolgreich!';
	@override String get connectionFailed => 'Verbindung fehlgeschlagen. Bitte prüfen Sie Ihren API-Schlüssel.';
	@override String get translationStrategy => 'Übersetzungsstrategie';
	@override String get strategy => 'Strategie';
	@override String get strategyDescription => 'Wählen Sie, wie Strings übersetzt werden sollen';
	@override String get strategyLLM => 'Generative KI (LLM)';
	@override String get strategyCloud => 'Cloud-Übersetzung';
	@override String get enableAiTranslation => 'KI-Übersetzung aktivieren';
	@override String get enableAiTranslationDescription => 'Erlaubt der App, KI für Übersetzungsvorschläge zu nutzen';
	@override String get llmProvider => 'LLM-Dienstleister';
	@override String get service => 'Dienst';
	@override String get serviceDescription => 'Anbieter für Generative KI';
	@override String get providerGemini => 'Google Gemini';
	@override String get providerOpenAI => 'OpenAI';
	@override String get geminiApiKey => 'Gemini API-Schlüssel';
	@override String get openAiApiKey => 'OpenAI API-Schlüssel';
	@override String get model => 'Modell';
	@override String get modelDescription => 'Wählen Sie das zu verwendende Modell';
	@override String get advancedParameters => 'Erweiterte Parameter';
	@override String get parameters => 'Parameter';
	@override String get parametersDescription => 'Temperatur, Kontext und mehr';
	@override String get temperature => 'Temperatur';
	@override String get temperatureDescription => 'Höhere Werte machen die Ausgabe kreativer';
	@override String get maxTokens => 'Max Tokens';
	@override String get maxTokensDescription => 'Begrenzung der Kontextfensterlänge';
	@override String get systemContext => 'Systemkontext / Anweisungen';
	@override String get systemContextHint => 'Sie sind ein professioneller Übersetzer. Behalten Sie Ton und Absicht bei...';
	@override String get systemContextHelper => 'Geben Sie spezifische Anweisungen an die KI zum Stil und zur Terminologie Ihres Projekts.';
	@override String get contextStrings => 'Kontext-Strings';
	@override String get contextStringsDescription => 'Umliegende Strings für besseren Kontext einbeziehen';
	@override String get contextCount => 'Kontext-Anzahl';
	@override String get contextCountDescription => 'Anzahl der einzubeziehenden umliegenden Strings';
	@override String get cloudServices => 'Cloud-Übersetzungsdienste';
	@override String get googleTranslateApiKey => 'Google Translate API-Schlüssel';
	@override String get deeplApiKey => 'DeepL API-Schlüssel';
	@override String get test => 'Testen';
	@override String get resetToGlobal => 'Alle KI-Einstellungen auf globale Standards zurücksetzen';
}

// Path: settings.integrations
class _TranslationsSettingsIntegrationsDe implements TranslationsSettingsIntegrationsEn {
	_TranslationsSettingsIntegrationsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get platformNotice => 'Plattform-Hinweis';
	@override String get platformNoticeDescription => 'Systemintegrationen sind für diese Plattform nicht verfügbar.';
	@override String get visualEffects => 'Visuelle Effekte';
	@override String get explorerIntegration => 'Explorer-Integration';
	@override String get explorerIntegrationDescription => '"Mit Localizer öffnen" zum Windows Explorer Kontextmenü hinzufügen.';
	@override String get addToContextMenu => 'Zum Kontextmenü hinzufügen';
	@override String get contextMenuAdded => 'Kontextmenü hinzugefügt!';
	@override String get contextMenuAddError => 'Fehler beim Hinzufügen zum Kontextmenü';
	@override String get contextMenuRemoved => 'Kontextmenü entfernt!';
	@override String get contextMenuRemoveError => 'Fehler beim Entfernen vom Kontextmenü';
	@override String get fileAssociations => 'Dateizuordnungen';
	@override String get fileAssociationsDescription => 'Dateitypen registrieren, um sie mit Localizer per Doppelklick zu öffnen.';
	@override String get registered => 'Registriert';
	@override String get notRegistered => 'Nicht registriert';
	@override String extRegistered({required Object ext}) => '${ext} registriert!';
	@override String extUnregistered({required Object ext}) => '${ext} deregistriert!';
	@override String extError({required Object action, required Object ext}) => 'Fehler bei ${action} von ${ext}';
	@override String get registerAll => 'Alle registrieren';
	@override String get unregisterAll => 'Alle deregistrieren';
	@override String registerAllResult({required Object success, required Object total}) => '${success} von ${total} Dateitypen registriert';
	@override String unregisterAllResult({required Object success, required Object total}) => '${success} von ${total} Dateitypen deregistriert';
	@override String get protocolHandler => 'Protokoll-Handler';
	@override String get protocolHandlerDescription => 'localizer:// URLs registrieren. Erlaubt das Öffnen von Projekten aus dem Browser.';
	@override String get protocolRegistered => 'Protokoll-Handler ist registriert';
	@override String get protocolNotRegistered => 'Protokoll-Handler nicht registriert';
	@override String get registerProtocol => 'Protokoll registrieren';
	@override String get unregister => 'Deregistrieren';
	@override String get protocolRegisteredSuccess => 'Protokoll-Handler registriert!';
	@override String get protocolRemovedSuccess => 'Protokoll-Handler entfernt!';
	@override String get protocolRegisterError => 'Fehler beim Registrieren';
	@override String get protocolRemoveError => 'Fehler beim Entfernen';
	@override String get windowMaterial => 'Fenstermaterial';
	@override String get windowMaterialDescription => 'Wählen Sie den macOS Vibrancy-Stil';
	@override String get dockIntegration => 'Dock-Integration';
	@override String get showDockBadge => 'Unübersetzte Anzahl zeigen';
	@override String get showDockBadgeDescription => 'Anzahl unübersetzter Strings am Dock-Icon anzeigen';
	@override late final _TranslationsSettingsIntegrationsMaterialsDe materials = _TranslationsSettingsIntegrationsMaterialsDe._(_root);
	@override late final _TranslationsSettingsIntegrationsFileTypesDe fileTypes = _TranslationsSettingsIntegrationsFileTypesDe._(_root);
}

// Path: settings.developer
class _TranslationsSettingsDeveloperDe implements TranslationsSettingsDeveloperEn {
	_TranslationsSettingsDeveloperDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Developer Settings';
	@override String get description => 'Advanced settings for developers';
	@override String get showLocalizationKeys => 'Show Localization Keys';
	@override String get localizationKeysDescription => 'When enabled, all translated text will show their localization keys instead of the translated value. Useful for verifying which key is used where.';
	@override String get showPerformanceOverlay => 'Show Performance Overlay';
	@override String get performanceOverlayDescription => 'Display FPS and frame timing information';
	@override String get debugMode => 'Debug Mode';
	@override String get debugModeDescription => 'Enable additional logging and debug features';
	@override String get debuggingTools => 'Debugging Tools';
	@override String get semanticsDebugger => 'Semantics Debugger';
	@override String get semanticsDebuggerDescription => 'Visualize semantics tree';
	@override String get materialGrid => 'Material Grid';
	@override String get materialGridDescription => 'Overlay material layout grid';
	@override String get rasterCache => 'Raster Cache Images';
	@override String get rasterCacheDescription => 'Checkerboard raster cache images';
	@override String get actions => 'Actions';
	@override String get showLogs => 'Show App Logs';
	@override String get showLogsDescription => 'Open Talker debug console';
	@override String get restartTutorial => 'Restart Onboarding Tutorial';
	@override String get restartTutorialDescription => 'Reset flags and launch tutorial again';
	@override String get restartRequested => 'Tutorial restart requested.';
	@override String get throwException => 'Throw Test Exception';
	@override String get throwExceptionDescription => 'Trigger a test exception for crash reporting';
	@override String get testExceptionMessage => 'Test Exception triggered from Developer Options';
	@override String get clearTM => 'Clear Translation Memory';
	@override String get clearTMDescription => 'Delete all cached translations';
	@override String get clearTMConfirmation => 'Clear Translation Memory?';
	@override String get clearTMWarning => 'This will delete all learned translations. This cannot be undone.';
	@override String get tmCleared => 'Translation memory cleared';
	@override String get clearApiKeys => 'Clear API Keys';
	@override String get clearApiKeysDescription => 'Remove all stored API keys';
	@override String get clearApiKeysConfirmation => 'Clear API Keys?';
	@override String get clearApiKeysWarning => 'This will remove all API keys from secure storage.';
	@override String get apiKeysCleared => 'API keys cleared';
	@override String get hideOptions => 'Hide Developer Options';
	@override String get hideOptionsDescription => 'Disable developer mode (requires 7 taps to re-enable)';
	@override String get optionsDisabled => 'Developer options disabled';
	@override String get dangerZone => 'Danger Zone';
	@override String get factoryReset => 'Factory Reset';
	@override String get factoryResetDescription => 'Reset all settings and clear data';
	@override String get factoryResetWarning => 'Are you sure you want to reset all settings? This action cannot be undone.';
	@override String get inspectionTools => 'Inspection Tools';
	@override String get searchHint => 'Search settings...';
	@override String get resetToDefault => 'Reset to defaults';
	@override String get resetToGlobal => 'Reset to global default';
	@override String get storageInspector => 'Storage Inspector';
	@override String get storageInspectorDescription => 'View Hive & Secure Storage contents';
	@override String get deviceEnvironment => 'Device & Environment';
	@override String get deviceEnvironmentDescription => 'Screen, platform, and build info';
	@override String get themePlayground => 'Theme Playground';
	@override String get themePlaygroundDescription => 'Color palette & typography';
	@override late final _TranslationsSettingsDeveloperThemePlaygroundSectionDe themePlaygroundSection = _TranslationsSettingsDeveloperThemePlaygroundSectionDe._(_root);
	@override String get localizationInspector => 'Localization Inspector';
	@override String get localizationInspectorDescription => 'Debug translation strings';
	@override String get hiveAppSettings => 'Hive (AppSettings)';
	@override String get secureStorageMasked => 'Secure Storage (Masked)';
	@override late final _TranslationsSettingsDeveloperFeatureFlagsDe featureFlags = _TranslationsSettingsDeveloperFeatureFlagsDe._(_root);
	@override late final _TranslationsSettingsDeveloperStorageInspectorSectionDe storageInspectorSection = _TranslationsSettingsDeveloperStorageInspectorSectionDe._(_root);
	@override late final _TranslationsSettingsDeveloperDeviceInfoSectionDe deviceInfoSection = _TranslationsSettingsDeveloperDeviceInfoSectionDe._(_root);
	@override late final _TranslationsSettingsDeveloperLocalizationInspectorSectionDe localizationInspectorSection = _TranslationsSettingsDeveloperLocalizationInspectorSectionDe._(_root);
}

// Path: settings.about
class _TranslationsSettingsAboutDe implements TranslationsSettingsAboutEn {
	_TranslationsSettingsAboutDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Über';
	@override String get version => 'Version';
	@override String get buildNumber => 'Build-Nummer';
	@override String get author => 'Autor';
	@override String get license => 'Lizenz';
	@override String get sourceCode => 'Quellcode';
	@override String get reportBug => 'Fehler melden';
	@override String get requestFeature => 'Feature vorschlagen';
	@override String get checkForUpdates => 'Nach Updates suchen';
	@override String get upToDate => 'Sie sind auf dem neuesten Stand!';
	@override String updateAvailable({required Object version}) => 'Update verfügbar: ${version}';
	@override String get updateAvailableBadge => 'Update verfügbar!';
	@override String developerSteps({required Object count}) => 'Sie sind ${count} Schritte davon entfernt, Entwickler zu sein.';
	@override String get developerActivated => 'Sie sind jetzt Entwickler!';
	@override String get neverChecked => 'Nie';
	@override String get applicationInfo => 'Anwendungsinformationen';
	@override String get platform => 'Plattform';
	@override String get updateInformation => 'Update-Informationen';
	@override String get currentVersion => 'Aktuelle Version';
	@override String get latestVersion => 'Neueste Version';
	@override String get lastChecked => 'Zuletzt geprüft';
	@override String get checkingForUpdates => 'Prüfe...';
	@override String get whatsNew => 'Was ist neu';
	@override String get systemInformation => 'Systeminformationen';
	@override String get dartVersion => 'Dart-Version';
	@override String get diskSpace => 'Verfügbarer Speicherplatz';
	@override String get memoryUsage => 'Speichernutzung';
	@override String get privacyTitle => 'Datenschutz & Telemetrie';
	@override String get usageStats => 'Anonyme Nutzungsstatistiken';
	@override String get requiresFirebase => 'Erfordert Firebase-Konfiguration';
	@override String get featureUnavailable => 'Funktion derzeit nicht verfügbar (Benötigt Firebase)';
	@override String get settingsManagement => 'Einstellungsverwaltung';
	@override String get settingsManagementDescription => 'Exportieren Sie Ihre Einstellungen in eine Datei, um sie zu sichern oder zu teilen.';
	@override String get resetAll => 'Alles zurücksetzen';
	@override String get links => 'Links';
	@override String get githubRepo => 'GitHub Repository';
	@override String get privacyPolicy => 'Datenschutzerklärung';
	@override String get crashReporting => 'Absturzberichte';
}

// Path: settings.onboarding
class _TranslationsSettingsOnboardingDe implements TranslationsSettingsOnboardingEn {
	_TranslationsSettingsOnboardingDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get skipTutorial => 'Tutorial überspringen';
	@override String get gettingStarted => 'Erste Schritte';
	@override String stepProgress({required Object current, required Object total}) => '${current} von ${total}';
	@override String get loadSampleData => 'Beispieldaten laden';
	@override late final _TranslationsSettingsOnboardingStepsDe steps = _TranslationsSettingsOnboardingStepsDe._(_root);
}

// Path: settings.settingsView
class _TranslationsSettingsSettingsViewDe implements TranslationsSettingsSettingsViewEn {
	_TranslationsSettingsSettingsViewDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String resetCategoryTitle({required Object category}) => 'Reset ${category}?';
	@override String get resetCategoryContent => 'This will reset all settings in this category to their default values.';
	@override String get resetAllTitle => 'Reset All Settings?';
	@override String get resetAllContent => 'This will permanently reset all settings to their factory defaults. This action cannot be undone.';
	@override String get resetAll => 'Reset All';
	@override String resetSuccess({required Object category}) => '${category} reset to defaults';
	@override String get errorLoading => 'Error loading settings';
	@override String get settingsSaved => 'Settings saved';
	@override String updateAvailable({required Object version}) => 'Update available: v${version}';
	@override String get latestVersion => 'You are using the latest version';
	@override String whatsNew({required Object version}) => 'What\'s New in v${version}';
	@override String get downloadUpdate => 'Download Update';
	@override String get exportSettings => 'Export Settings';
	@override String get settingsExported => 'Settings exported';
	@override String exportFail({required Object error}) => 'Failed to export settings: ${error}';
	@override String get importSettings => 'Import Settings';
	@override String get importTitle => 'Import Settings?';
	@override String get importContent => 'This will replace all your current settings with the imported ones. This action cannot be undone.';
	@override String get importSuccess => 'Settings imported successfully!';
	@override String importFail({required Object error}) => 'Failed to import settings: ${error}';
	@override String get invalidFormat => 'Invalid settings file format';
	@override late final _TranslationsSettingsSettingsViewCategoriesDe categories = _TranslationsSettingsSettingsViewCategoriesDe._(_root);
	@override late final _TranslationsSettingsSettingsViewCategoryLabelsDe categoryLabels = _TranslationsSettingsSettingsViewCategoryLabelsDe._(_root);
}

// Path: advancedDiff.aiSuggestion
class _TranslationsAdvancedDiffAiSuggestionDe implements TranslationsAdvancedDiffAiSuggestionEn {
	_TranslationsAdvancedDiffAiSuggestionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get aiTranslation => 'KI-Übersetzung';
	@override String get aiRephrase => 'KI-Umformulierung';
	@override String key({required Object key}) => 'Schlüssel: ${key}';
	@override String get original => 'Original:';
	@override String get suggestion => 'Vorschlag:';
	@override String get confidence => 'KI-Konfidenz';
	@override String get cancelEdit => 'Bearbeitung abbrechen';
	@override String get editSuggestion => 'Vorschlag bearbeiten';
	@override String get alternatives => 'Alternativen:';
	@override String get accept => 'Akzeptieren';
	@override String get reject => 'Ablehnen';
	@override String get stop => 'Stopp';
}

// Path: advancedDiff.detailEdit
class _TranslationsAdvancedDiffDetailEditDe implements TranslationsAdvancedDiffDetailEditEn {
	_TranslationsAdvancedDiffDetailEditDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object key}) => 'Bearbeite: ${key}';
	@override String get sourceLabel => 'QUELLE (Original)';
	@override String get targetLabel => 'ZIEL (Übersetzung)';
	@override String get translateWithCloud => 'Mit Cloud übersetzen';
	@override String get translateWithAi => 'Mit KI übersetzen';
	@override String get translating => 'Übersetze...';
	@override String get applyAndTm => 'Anwenden';
	@override String get entryApplied => 'Eintrag angewendet & zu TM hinzugefügt';
	@override String get translationAdded => 'Übersetzungsvorschlag hinzugefügt.';
	@override String get aiSuggestionAdded => 'KI-Vorschlag hinzugefügt.';
}

// Path: advancedDiff.table
class _TranslationsAdvancedDiffTableDe implements TranslationsAdvancedDiffTableEn {
	_TranslationsAdvancedDiffTableDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get addedToTM => 'Zum Übersetzungs-Memory hinzugefügt';
	@override String get markedReviewed => 'Als geprüft markiert ✓';
	@override String get unmarkedReview => 'Markierung entfernt';
	@override String get reverted => 'Auf Quellwert zurückgesetzt';
	@override String get entryDeleted => 'Eintrag gelöscht';
	@override String get noSourceText => 'Kein Quelltext zum Übersetzen.';
	@override String aiTranslationFailed({required Object key}) => 'KI-Übersetzung fehlgeschlagen für "${key}"';
	@override String get noTargetText => 'Kein Zieltext zum Umformulieren.';
	@override String aiRephraseFailed({required Object key}) => 'KI-Umformulierung fehlgeschlagen für "${key}"';
	@override String get checkRowsFirst => 'Zuerst Zeilen mit Checkboxen auswählen';
	@override String markedRowsReviewed({required Object count}) => '${count} Zeilen als geprüft markiert';
	@override String revertedRows({required Object count}) => '${count} Zeilen zurückgesetzt';
	@override String entriesCount({required Object count}) => '${count} Einträge';
	@override String get markSelectedReviewed => 'Ausgewählte als geprüft markieren';
	@override String get revertSelected => 'Ausgewählte zurücksetzen';
	@override String get noDifferences => 'Keine Unterschiede gefunden';
	@override String get adjustFilters => 'Versuchen Sie, Ihre Filter anzupassen';
	@override String get cloudTranslationApplied => 'Cloud-Übersetzung angewendet.';
	@override String get aiTranslationApplied => 'KI-Übersetzung angewendet.';
	@override String get suggestionApplied => 'Vorschlag angewendet.';
	@override String get aiSuggestionApplied => 'KI-Vorschlag angewendet.';
	@override String get rephraseApplied => 'Umformulierung angewendet.';
	@override String get aiRephraseApplied => 'KI-Umformulierung angewendet.';
	@override String get rephrase => 'Umformulieren';
	@override String get aiRephrase => 'KI-Umformulierung';
	@override String get targetClickToEdit => 'ZIEL (Klicken zum Bearbeiten)';
	@override String get targetClickForDialog => 'ZIEL (Klicken für Dialog)';
	@override String get emptyClickToEdit => '(Leer - Klicken zum Bearbeiten)';
	@override String get unmarkReviewed => 'Markierung entfernen';
	@override String get markReviewed => 'Als geprüft markieren';
	@override String get revertToSource => 'Auf Quelle zurücksetzen';
	@override String get translateWithCloud => 'Mit Cloud übersetzen';
	@override String get translateWithAi => 'Mit KI übersetzen';
	@override String get rephraseWithAi => 'Mit KI umformulieren';
	@override String get moreActions => 'Weitere Aktionen';
	@override String get editDetails => 'Details bearbeiten';
	@override String get suggestTranslation => 'Übersetzung vorschlagen';
	@override String get addToTm => 'Zu TM hinzufügen';
	@override String get deleteEntry => 'Eintrag löschen';
}

// Path: advancedDiff.diffRow
class _TranslationsAdvancedDiffDiffRowDe implements TranslationsAdvancedDiffDiffRowEn {
	_TranslationsAdvancedDiffDiffRowDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get copySource => 'Quelltext kopieren';
	@override String get actions => 'Aktionen';
}

// Path: advancedDiff.status
class _TranslationsAdvancedDiffStatusDe implements TranslationsAdvancedDiffStatusEn {
	_TranslationsAdvancedDiffStatusDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get added => 'NEU';
	@override String get missing => 'FEHLT';
	@override String changed({required Object percent}) => 'GEÄND ${percent}%';
	@override String get same => 'GLEICH';
}

// Path: advancedDiff.sidebar
class _TranslationsAdvancedDiffSidebarDe implements TranslationsAdvancedDiffSidebarEn {
	_TranslationsAdvancedDiffSidebarDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get widgets => 'Widgets';
	@override String get searchPlaceholder => 'Schlüssel & Werte suchen... (Ctrl+F)';
	@override String get fuzzySearchTooltip => 'Unscharfe Suche (hlerranz)';
	@override String get regexSearchTooltip => 'Regex Suche';
	@override String get cloudTranslation => 'Cloud-Übersetzung';
	@override String get aiTranslation => 'KI-Übersetzung';
	@override String get status => 'Status';
	@override String get tm => 'Übersetzungs-Memory';
	@override String get filters => 'Filter';
	@override String get actions => 'Aktionen';
	@override String get similarity => 'Ähnlichkeit';
	@override late final _TranslationsAdvancedDiffSidebarActionsSectionDe actionsSection = _TranslationsAdvancedDiffSidebarActionsSectionDe._(_root);
	@override late final _TranslationsAdvancedDiffSidebarAiSectionDe aiSection = _TranslationsAdvancedDiffSidebarAiSectionDe._(_root);
	@override late final _TranslationsAdvancedDiffSidebarTmSectionDe tmSection = _TranslationsAdvancedDiffSidebarTmSectionDe._(_root);
	@override late final _TranslationsAdvancedDiffSidebarFiltersSectionDe filtersSection = _TranslationsAdvancedDiffSidebarFiltersSectionDe._(_root);
	@override late final _TranslationsAdvancedDiffSidebarSimilaritySectionDe similaritySection = _TranslationsAdvancedDiffSidebarSimilaritySectionDe._(_root);
	@override late final _TranslationsAdvancedDiffSidebarStatusSectionDe statusSection = _TranslationsAdvancedDiffSidebarStatusSectionDe._(_root);
}

// Path: issueDetails.duplicateValue
class _TranslationsIssueDetailsDuplicateValueDe implements TranslationsIssueDetailsDuplicateValueEn {
	_TranslationsIssueDetailsDuplicateValueDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'WIEDERHOLTE ÜBERSETZUNG';
	@override String get warning => 'Unterschiedliche Quelltexte nutzen dieselbe Übersetzung. Kontext prüfen.';
	@override String affectedKeys({required Object count}) => 'BETROFFENE SCHLÜSSEL (${count})';
	@override String get identicalSources => 'Identische Quellen';
	@override String moreKeys({required Object count}) => '+${count} weitere Schlüssel';
}

// Path: issueDetails.lengthOutlier
class _TranslationsIssueDetailsLengthOutlierDe implements TranslationsIssueDetailsLengthOutlierEn {
	_TranslationsIssueDetailsLengthOutlierDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get source => 'QUELLE';
	@override String get translation => 'ÜBERSETZUNG';
	@override String chars({required Object count}) => '${count} Zeichen';
}

// Path: issueDetails.standard
class _TranslationsIssueDetailsStandardDe implements TranslationsIssueDetailsStandardEn {
	_TranslationsIssueDetailsStandardDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get key => 'SCHLÜSSEL';
	@override String get sourceText => 'QUELLTEXT';
	@override String get translation => 'ÜBERSETZUNG';
	@override String get errorDetails => 'FEHLERDETAILS';
	@override String get note => 'HINWEIS';
}

// Path: issueDetails.types
class _TranslationsIssueDetailsTypesDe implements TranslationsIssueDetailsTypesEn {
	_TranslationsIssueDetailsTypesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get duplicateValue => 'Doppelte Werte';
	@override String get lengthOutlier => 'Längenabweichung';
	@override String get placeholderMismatch => 'Defekte Platzhalter';
}

// Path: issueDetails.notes
class _TranslationsIssueDetailsNotesDe implements TranslationsIssueDetailsNotesEn {
	_TranslationsIssueDetailsNotesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get placeholderMismatch => 'Marker wie {name} sollten mit der Quelle übereinstimmen.';
	@override String get lengthOutlier => 'Große Längenänderungen können die Anzeige beeinflussen.';
	@override String get duplicateValue => 'Gleiche Übersetzung wird für verschiedene Schlüssel verwendet.';
}

// Path: issueDetails.fallbacks
class _TranslationsIssueDetailsFallbacksDe implements TranslationsIssueDetailsFallbacksEn {
	_TranslationsIssueDetailsFallbacksDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get multipleSources => 'Mehrere Quelltexte';
	@override String get sourceNotAvailable => 'Quelltext nicht verfügbar';
	@override String get sharedTranslationNotAvailable => 'Geteilte Übersetzung nicht verfügbar';
	@override String get translationNotAvailable => 'Übersetzung nicht verfügbar';
}

// Path: compare.tabs
class _TranslationsCompareTabsDe implements TranslationsCompareTabsEn {
	_TranslationsCompareTabsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get files => 'Dateien';
	@override String get directories => 'Verzeichnisse';
	@override String get git => 'Git';
}

// Path: compare.fileTypes
class _TranslationsCompareFileTypesDe implements TranslationsCompareFileTypesEn {
	_TranslationsCompareFileTypesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get json => 'JSON Lokalisierungsdateien (i18next, Flutter, etc.)';
	@override String get yaml => 'YAML Lokalisierungsdateien (Rails, Flutter)';
	@override String get xml => 'XML Lokalisierungsdateien (Android, .NET)';
	@override String get properties => 'Properties Dateien (Java)';
	@override String get resx => 'RESX Dateien (.NET)';
	@override String get xliff => 'XLIFF Dateien';
}

// Path: history.timeAgo
class _TranslationsHistoryTimeAgoDe implements TranslationsHistoryTimeAgoEn {
	_TranslationsHistoryTimeAgoDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get justNow => 'gerade eben';
	@override String secondsAgo({required Object count}) => 'vor ${count} Sekunden';
	@override String get oneMinuteAgo => 'vor 1 Minute';
	@override String minutesAgo({required Object count}) => 'vor ${count} Minuten';
	@override String get oneHourAgo => 'vor 1 Stunde';
	@override String hoursAgo({required Object count}) => 'vor ${count} Stunden';
	@override String get yesterday => 'gestern';
	@override String daysAgo({required Object count}) => 'vor ${count} Tagen';
	@override String get oneWeekAgo => 'vor 1 Woche';
	@override String weeksAgo({required Object count}) => 'vor ${count} Wochen';
	@override String get oneMonthAgo => 'vor 1 Monat';
	@override String monthsAgo({required Object count}) => 'vor ${count} Monaten';
	@override String get oneYearAgo => 'vor 1 Jahr';
	@override String yearsAgo({required Object count}) => 'vor ${count} Jahren';
	@override String get inTheFuture => 'in der Zukunft';
}

// Path: projects.stats
class _TranslationsProjectsStatsDe implements TranslationsProjectsStatsEn {
	_TranslationsProjectsStatsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Leeres Projekt';
	@override String files({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '1 Übersetzungsdatei',
		other: '${count} Übersetzungsdateien',
	);
	@override String languages({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '1 Sprache',
		other: '${count} Sprachen',
	);
}

// Path: projects.selection
class _TranslationsProjectsSelectionDe implements TranslationsProjectsSelectionEn {
	_TranslationsProjectsSelectionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get selectFolder => 'Projektordner wählen';
	@override String get selectArchive => 'Projektarchiv wählen';
	@override String get openProject => 'Projekt öffnen';
	@override String get browseFolder => 'Ordner durchsuchen...';
	@override String get createNew => 'Neu erstellen';
	@override String get importFromZip => 'Aus ZIP importieren...';
}

// Path: projects.createDialog
class _TranslationsProjectsCreateDialogDe implements TranslationsProjectsCreateDialogEn {
	_TranslationsProjectsCreateDialogDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Projekt erstellen';
	@override String get description => 'Ein Projekt erlaubt es Ihnen, benutzerdefinierte Einstellungen für einen bestimmten Ordner zu speichern. Ein ".localizer" Ordner wird erstellt, um Ihre Projektkonfiguration zu speichern.';
	@override String get folderLabel => 'Projektordner';
	@override String get folderHint => 'Klicken um Ordner zu wählen...';
	@override String get nameLabel => 'Projektname';
	@override String get nameHint => 'z.B., Meine App Übersetzungen';
	@override String get selectFolderWarning => 'Bitte wählen Sie einen Projektordner.';
	@override String get enterNameError => 'Bitte geben Sie einen Projektnamen ein';
	@override String get nameLengthError => 'Name muss mindestens 2 Zeichen lang sein';
	@override String success({required Object name}) => 'Projekt "${name}" erfolgreich erstellt!';
	@override String get failure => 'Fehler beim Erstellen des Projekts.';
	@override String get creating => 'Erstelle...';
	@override String get createAction => 'Projekt erstellen';
}

// Path: projects.indicator
class _TranslationsProjectsIndicatorDe implements TranslationsProjectsIndicatorEn {
	_TranslationsProjectsIndicatorDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get tooltipNoProject => 'Erstellen Sie ein Projekt, um benutzerdefinierte Einstellungen für einen Ordner zu speichern';
	@override String tooltipProject({required Object name}) => 'Projekt: ${name}\nKlicken für Optionen';
	@override String get location => 'Ort';
	@override String get created => 'Erstellt';
	@override String get switchProject => 'Projekt wechseln';
	@override String get done => 'Fertig';
}

// Path: projects.glossary
class _TranslationsProjectsGlossaryDe implements TranslationsProjectsGlossaryEn {
	_TranslationsProjectsGlossaryDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Projekt-Glossar';
	@override String get description => 'Definieren Sie Begriffe, die konsistent behandelt oder nie übersetzt werden sollen.';
	@override String get noTerms => 'Noch keine Glossarbegriffe.';
	@override String get noTermsDesc => 'Fügen Sie Begriffe hinzu, die über Übersetzungen hinweg konsistent bleiben sollen,\noder markieren Sie Markennamen, die nie übersetzt werden sollen.';
	@override String get doNotTranslate => 'Nicht übersetzen';
	@override String get noSpecificTranslation => 'Keine spezifische Übersetzung';
	@override String get addTerm => 'Begriff hinzufügen';
	@override String get editTerm => 'Begriff bearbeiten';
	@override String get term => 'Begriff';
	@override String get termHint => 'z.B., Markenname, Fachbegriff';
	@override String get definition => 'Definition (Optional)';
	@override String get definitionHint => 'Kontext für den Übersetzer';
	@override String get doNotTranslateLabel => 'Nicht übersetzen';
	@override String get doNotTranslateDesc => 'Begriff im Ziel exakt beibehalten';
	@override String get preferredTranslation => 'Bevorzugte Übersetzung';
	@override String get caseSensitive => 'Groß-/Kleinschreibung beachten';
}

// Path: projects.conflicts
class _TranslationsProjectsConflictsDe implements TranslationsProjectsConflictsEn {
	_TranslationsProjectsConflictsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String missingApiKeyTitle({required Object service}) => 'Fehlender API-Schlüssel für ${service}';
	@override String missingApiKeyMessage({required Object service}) => 'Dieses Projekt nutzt ${service}, aber kein API-Schlüssel ist konfiguriert. Fügen Sie Ihren API-Schlüssel in Einstellungen > KI-Dienste hinzu, oder die App verwendet den globalen Standard.';
	@override String get dismiss => 'Verwerfen';
}

// Path: projects.tm
class _TranslationsProjectsTmDe implements TranslationsProjectsTmEn {
	_TranslationsProjectsTmDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Übersetzungs-Memories';
	@override String get description => 'Verwalten Sie Übersetzungs-Memory-Quellen für dieses Projekt.';
	@override String get globalTm => 'Globales Übersetzungs-Memory';
	@override String get globalTmDescription => 'Das geteilte Übersetzungs-Memory aus Ihren App-Einstellungen verwenden';
	@override String get linkedFiles => 'Verknüpfte Dateien (Projektspezifisch)';
	@override String get noLinkedFiles => 'Keine projektspezifischen Dateien verknüpft.';
	@override String get addTmFile => 'TM-Datei hinzufügen';
	@override String get useGlobalTm => 'Globales TM verwenden';
	@override String get selectTm => 'Übersetzungs-Memory wählen';
	@override String get globalTmEnabled => 'Globales Übersetzungs-Memory aktiviert';
}

// Path: git.conflicts
class _TranslationsGitConflictsDe implements TranslationsGitConflictsEn {
	_TranslationsGitConflictsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Merge-Konflikte erkannt';
	@override String get description => 'Sie müssen diese Konflikte lösen, bevor Sie fortfahren können.';
	@override String get abortMergeTitle => 'Merge abbrechen?';
	@override String get abortMergeContent => 'Dies macht alle Merge-Änderungen rückgängig und kehrt zum Zustand vor dem Merge zurück. Dies kann nicht rückgängig gemacht werden.';
	@override String get abortMergeAction => 'Merge abbrechen';
	@override String stagingFile({required Object file}) => 'Stage ${file} für Commit...';
	@override String conflictedFilesCount({required Object count}) => 'Konfliktdateien (${count})';
	@override String get selectFileToResolve => 'Wählen Sie eine Datei zu lösen';
	@override String resolvingFile({required Object file}) => 'Löse: ${file}';
	@override String get keepAllOurs => 'Alle \'Ours\' behalten';
	@override String get acceptAllTheirs => 'Alle \'Theirs\' akzeptieren';
	@override String get allResolved => 'Alle Konflikte in dieser Datei wurden gelöst!';
	@override String get markResolved => 'Als gelöst markieren';
	@override String get stageForCommit => 'Dies wird die Datei für den Commit stagen.';
	@override String conflictIndex({required Object index}) => 'Konflikt #${index}';
	@override String get ours => 'OURS (Aktuell)';
	@override String get theirs => 'THEIRS (Eingehend)';
	@override String get keepOurs => 'Ours behalten';
	@override String get acceptTheirs => 'Theirs akzeptieren';
	@override String get empty => '(Leer)';
}

// Path: wizards.firstRun
class _TranslationsWizardsFirstRunDe implements TranslationsWizardsFirstRunEn {
	_TranslationsWizardsFirstRunDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Willkommen bei Localizer';
	@override String get description => 'Vergleichen Sie Ihre Lokalisierungsdateien in Sekunden.';
	@override String get sourceFile => 'Quelldatei';
	@override String get targetFile => 'Zieldatei';
	@override String get compareNow => 'Jetzt vergleichen';
	@override String get trySample => 'Mit Beispieldaten testen';
	@override String get skip => 'Setup überspringen';
	@override String get browse => 'Klicken zum Durchsuchen';
	@override String error({required Object error}) => 'Fehler beim Laden der Beispieldaten: ${error}';
}

// Path: dialogs.addIgnorePattern
class _TranslationsDialogsAddIgnorePatternDe implements TranslationsDialogsAddIgnorePatternEn {
	_TranslationsDialogsAddIgnorePatternDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ignorier-Muster hinzufügen';
	@override String get patternLabel => 'Muster (Regex)';
	@override String get hint => 'z.B., ^temp_.*';
	@override String get invalid => 'Ungültiges Regex-Muster';
	@override String get testStringLabel => 'Test-String';
	@override String get testHint => 'Schlüssel zum Testen eingeben';
	@override String get match => '✓ Muster passt auf Test-String';
	@override String get noMatch => '✗ Muster passt nicht';
	@override String get add => 'Hinzufügen';
	@override String get cancel => 'Abbrechen';
}

// Path: dialogs.diffViewer
class _TranslationsDialogsDiffViewerDe implements TranslationsDialogsDiffViewerEn {
	_TranslationsDialogsDiffViewerDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Diff Viewer';
	@override String get originalFile => 'Original/Referenzdatei';
	@override String get translationFile => 'Übersetzungs/Vergleichsdatei';
	@override String get base => 'BASIS';
	@override String get target => 'ZIEL';
	@override String get added => 'Hinzugefügt';
	@override String get removed => 'Entfernt';
	@override String get modified => 'Geändert';
	@override String get noMatches => 'Keine Einträge entsprechen den aktuellen Filtern';
	@override String get clickToggle => 'Klicken Sie auf die Badges oben, um Filter umzuschalten';
}

// Path: grid.columns
class _TranslationsGridColumnsDe implements TranslationsGridColumnsEn {
	_TranslationsGridColumnsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get key => 'Schlüssel';
	@override String get source => 'Quelle';
	@override String get status => 'Status';
	@override String get actions => 'Aktionen';
}

// Path: tutorial.steps
class _TranslationsTutorialStepsDe implements TranslationsTutorialStepsEn {
	_TranslationsTutorialStepsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTutorialStepsImportSourceDe importSource = _TranslationsTutorialStepsImportSourceDe._(_root);
	@override late final _TranslationsTutorialStepsImportTargetDe importTarget = _TranslationsTutorialStepsImportTargetDe._(_root);
	@override late final _TranslationsTutorialStepsCompareDe compare = _TranslationsTutorialStepsCompareDe._(_root);
	@override late final _TranslationsTutorialStepsFilterDe filter = _TranslationsTutorialStepsFilterDe._(_root);
	@override late final _TranslationsTutorialStepsSearchDe search = _TranslationsTutorialStepsSearchDe._(_root);
	@override late final _TranslationsTutorialStepsAdvancedDe advanced = _TranslationsTutorialStepsAdvancedDe._(_root);
	@override late final _TranslationsTutorialStepsExportDe export = _TranslationsTutorialStepsExportDe._(_root);
}

// Path: friendlyErrors.fileNotFound
class _TranslationsFriendlyErrorsFileNotFoundDe implements TranslationsFriendlyErrorsFileNotFoundEn {
	_TranslationsFriendlyErrorsFileNotFoundDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Die Datei oder der Ordner konnte nicht gefunden werden.';
	@override String get suggestion => 'Prüfen Sie, ob die Datei verschoben oder gelöscht wurde.';
}

// Path: friendlyErrors.accessDenied
class _TranslationsFriendlyErrorsAccessDeniedDe implements TranslationsFriendlyErrorsAccessDeniedEn {
	_TranslationsFriendlyErrorsAccessDeniedDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Zugriff auf die Datei wurde verweigert.';
	@override String get suggestion => 'Versuchen Sie es als Administrator oder prüfen Sie Dateirechte.';
}

// Path: friendlyErrors.isDirectory
class _TranslationsFriendlyErrorsIsDirectoryDe implements TranslationsFriendlyErrorsIsDirectoryEn {
	_TranslationsFriendlyErrorsIsDirectoryDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Ein Ordner wurde statt einer Datei ausgewählt.';
	@override String get suggestion => 'Bitte wählen Sie eine gültige Datei.';
}

// Path: friendlyErrors.fileAccess
class _TranslationsFriendlyErrorsFileAccessDe implements TranslationsFriendlyErrorsFileAccessEn {
	_TranslationsFriendlyErrorsFileAccessDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Es gab ein Problem beim Zugriff auf die Datei.';
	@override String get suggestion => 'Schließen Sie andere Programme, die sie verwenden könnten.';
}

// Path: friendlyErrors.unsupportedFormat
class _TranslationsFriendlyErrorsUnsupportedFormatDe implements TranslationsFriendlyErrorsUnsupportedFormatEn {
	_TranslationsFriendlyErrorsUnsupportedFormatDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Dieses Dateiformat oder Operation wird nicht unterstützt.';
	@override String get suggestion => 'Prüfen Sie die Dateiendung oder versuchen Sie ein anderes Format.';
}

// Path: friendlyErrors.networkError
class _TranslationsFriendlyErrorsNetworkErrorDe implements TranslationsFriendlyErrorsNetworkErrorEn {
	_TranslationsFriendlyErrorsNetworkErrorDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Konnte keine Verbindung zum Server herstellen.';
	@override String get suggestion => 'Prüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.';
}

// Path: friendlyErrors.notGitRepo
class _TranslationsFriendlyErrorsNotGitRepoDe implements TranslationsFriendlyErrorsNotGitRepoEn {
	_TranslationsFriendlyErrorsNotGitRepoDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Dieser Ordner ist kein Git-Projekt.';
	@override String get suggestion => 'Navigieren Sie zu einem Ordner mit .git Verzeichnis.';
}

// Path: friendlyErrors.mergeConflict
class _TranslationsFriendlyErrorsMergeConflictDe implements TranslationsFriendlyErrorsMergeConflictEn {
	_TranslationsFriendlyErrorsMergeConflictDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Es gibt Merge-Konflikte im Repository.';
	@override String get suggestion => 'Lösen Sie die Konflikte bevor Sie fortfahren.';
}

// Path: friendlyErrors.gitAuthFailed
class _TranslationsFriendlyErrorsGitAuthFailedDe implements TranslationsFriendlyErrorsGitAuthFailedEn {
	_TranslationsFriendlyErrorsGitAuthFailedDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Git-Authentifizierung fehlgeschlagen.';
	@override String get suggestion => 'Prüfen Sie Ihre Anmeldedaten in Einstellungen > Version Control.';
}

// Path: friendlyErrors.gitOperationFailed
class _TranslationsFriendlyErrorsGitOperationFailedDe implements TranslationsFriendlyErrorsGitOperationFailedEn {
	_TranslationsFriendlyErrorsGitOperationFailedDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Eine Git-Operation ist fehlgeschlagen.';
	@override String get suggestion => 'Prüfen Sie die Git-Ansicht für mehr Details.';
}

// Path: friendlyErrors.invalidJson
class _TranslationsFriendlyErrorsInvalidJsonDe implements TranslationsFriendlyErrorsInvalidJsonEn {
	_TranslationsFriendlyErrorsInvalidJsonDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Das Dateiformat ist ungültig oder beschädigt.';
	@override String get suggestion => 'Stellen Sie sicher, dass die Datei gültiges JSON enthält.';
}

// Path: friendlyErrors.rateLimitReached
class _TranslationsFriendlyErrorsRateLimitReachedDe implements TranslationsFriendlyErrorsRateLimitReachedEn {
	_TranslationsFriendlyErrorsRateLimitReachedDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Übersetzungslimit erreicht.';
	@override String get suggestion => 'Warten Sie einige Minuten oder prüfen Sie Ihr API-Limit.';
}

// Path: friendlyErrors.invalidApiKey
class _TranslationsFriendlyErrorsInvalidApiKeyDe implements TranslationsFriendlyErrorsInvalidApiKeyEn {
	_TranslationsFriendlyErrorsInvalidApiKeyDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Ungültiger API-Schlüssel.';
	@override String get suggestion => 'Gehen Sie zu Einstellungen > KI-Übersetzung um ihn zu aktualisieren.';
}

// Path: friendlyErrors.translationServiceError
class _TranslationsFriendlyErrorsTranslationServiceErrorDe implements TranslationsFriendlyErrorsTranslationServiceErrorEn {
	_TranslationsFriendlyErrorsTranslationServiceErrorDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Fehler beim Übersetzungsdienst.';
	@override String get suggestion => 'Prüfen Sie Ihren API-Schlüssel und Internetverbindung.';
}

// Path: friendlyErrors.outOfMemory
class _TranslationsFriendlyErrorsOutOfMemoryDe implements TranslationsFriendlyErrorsOutOfMemoryEn {
	_TranslationsFriendlyErrorsOutOfMemoryDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Nicht genügend Speicher für diese Operation.';
	@override String get suggestion => 'Schließen Sie andere Anwendungen oder nutzen Sie kleinere Dateien.';
}

// Path: friendlyErrors.genericError
class _TranslationsFriendlyErrorsGenericErrorDe implements TranslationsFriendlyErrorsGenericErrorEn {
	_TranslationsFriendlyErrorsGenericErrorDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get message => 'Etwas ist schiefgelaufen.';
	@override String get suggestion => 'Bitte versuchen Sie es erneut. Wenn das Problem besteht, starten Sie die App neu.';
}

// Path: settings.appearance.presets
class _TranslationsSettingsAppearancePresetsDe implements TranslationsSettingsAppearancePresetsEn {
	_TranslationsSettingsAppearancePresetsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get presetDefault => 'Standard';
	@override String get presetColorblind => 'Farbenblind-Freundlich';
	@override String get presetHighContrast => 'Hoher Kontrast';
	@override String get presetNord => 'Nord';
	@override String get presetSolarized => 'Solarized';
	@override String get presetMonokai => 'Monokai';
}

// Path: settings.appearance.preview
class _TranslationsSettingsAppearancePreviewDe implements TranslationsSettingsAppearancePreviewEn {
	_TranslationsSettingsAppearancePreviewDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get step3Title => 'onboarding.step3.title';
	@override String get connectAccount => '"Konto verbinden"';
	@override String get loginHint => 'deprecated.login_hint_v1';
	@override String get enterCredentials => '"Anmeldedaten eingeben"';
	@override String get ctaButton => 'checkout.cta_button';
	@override String get buyNow => '"Jetzt kaufen"';
	@override String get completePurchase => '"Kauf abschließen"';
	@override String get appNameKey => 'common.app_name';
	@override String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class _TranslationsSettingsComparisonPatternPresetsDe implements TranslationsSettingsComparisonPatternPresetsEn {
	_TranslationsSettingsComparisonPatternPresetsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get comments => 'Kommentare';
	@override String get tempKeys => 'Temp-Schlüssel';
	@override String get placeholders => 'Platzhalter';
	@override String get devOnly => 'Nur Entwickler';
}

// Path: settings.comparison.previewMatch
class _TranslationsSettingsComparisonPreviewMatchDe implements TranslationsSettingsComparisonPreviewMatchEn {
	_TranslationsSettingsComparisonPreviewMatchDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vorschau';
	@override String get description => 'Testen Sie, wie sich Ihre Einstellungen auf die Abgleichlogik auswirken.';
	@override String get stringA => 'String A';
	@override String get stringB => 'String B';
	@override String get enterText => 'Text eingeben...';
	@override String get similarity => 'Ähnlichkeit';
	@override String get identical => 'Identisch';
	@override String get identicalDescription => 'Strings stimmen nach Normalisierung exakt überein.';
	@override String get ignored => 'Ignoriert';
	@override String get ignoredDescription => 'Eingabe entspricht einem Ignorier-Muster.';
	@override String get different => 'Unterschiedlich';
	@override String get differentDescription => 'Ein Wert ist leer.';
	@override String get similarModified => 'Ähnlich / Geändert';
	@override String similarModifiedDescription({required Object threshold}) => 'Übereinstimmungsrate liegt über der Schwelle (${threshold}%).';
	@override String get newDifferent => 'Neu / Unterschiedlich';
	@override String newDifferentDescription({required Object threshold}) => 'Übereinstimmungsrate liegt unter der Schwelle (${threshold}%).';
}

// Path: settings.comparison.colorPresets
class _TranslationsSettingsComparisonColorPresetsDe implements TranslationsSettingsComparisonColorPresetsEn {
	_TranslationsSettingsComparisonColorPresetsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get kDefault => 'Standard';
	@override String get colorblindFriendly => 'Farbenblind-Freundlich';
	@override String get highContrast => 'Hoher Kontrast';
	@override String get nord => 'Nord';
	@override String get solarized => 'Solarized';
	@override String get monokai => 'Monokai';
	@override String get presetDefault => 'Standard';
	@override String get presetColorblind => 'Farbenblind-Freundlich';
	@override String get presetHighContrast => 'Hoher Kontrast';
	@override String get presetNord => 'Nord';
	@override String get presetSolarized => 'Solarized';
	@override String get presetMonokai => 'Monokai';
}

// Path: settings.integrations.materials
class _TranslationsSettingsIntegrationsMaterialsDe implements TranslationsSettingsIntegrationsMaterialsEn {
	_TranslationsSettingsIntegrationsMaterialsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get sidebar => 'Seitenleiste';
	@override String get menu => 'Menü';
	@override String get popover => 'Popover';
	@override String get titlebar => 'Titelleiste';
	@override String get underPageBackground => 'Seitenhintergrund';
	@override String get contentBackground => 'Inhalt';
}

// Path: settings.integrations.fileTypes
class _TranslationsSettingsIntegrationsFileTypesDe implements TranslationsSettingsIntegrationsFileTypesEn {
	_TranslationsSettingsIntegrationsFileTypesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get loc => 'Localizer Projektdatei';
	@override String get lang => 'Sprachdatei';
	@override String get json => 'JSON Lokalisierungsdatei';
	@override String get xml => 'XML Lokalisierungsdatei';
}

// Path: settings.developer.themePlaygroundSection
class _TranslationsSettingsDeveloperThemePlaygroundSectionDe implements TranslationsSettingsDeveloperThemePlaygroundSectionEn {
	_TranslationsSettingsDeveloperThemePlaygroundSectionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get colors => 'Colors';
	@override String get typography => 'Typography';
	@override late final _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteDe palette = _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteDe._(_root);
}

// Path: settings.developer.featureFlags
class _TranslationsSettingsDeveloperFeatureFlagsDe implements TranslationsSettingsDeveloperFeatureFlagsEn {
	_TranslationsSettingsDeveloperFeatureFlagsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Experimental Features';
	@override String get description => 'Toggle feature flags locally for testing. These overrides persist across app restarts.';
	@override String get subtitle => 'Override experimental features';
	@override late final _TranslationsSettingsDeveloperFeatureFlagsFlagsDe flags = _TranslationsSettingsDeveloperFeatureFlagsFlagsDe._(_root);
	@override String get reset => 'Reset All Flags';
	@override String get overrides => 'Local Overrides';
	@override String get defaultVal => 'Default';
	@override String get on => 'ON';
	@override String get off => 'OFF';
}

// Path: settings.developer.storageInspectorSection
class _TranslationsSettingsDeveloperStorageInspectorSectionDe implements TranslationsSettingsDeveloperStorageInspectorSectionEn {
	_TranslationsSettingsDeveloperStorageInspectorSectionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get refresh => 'Refresh';
	@override String get hiveData => 'Hive Data';
	@override String get secureStorage => 'Secure Storage';
}

// Path: settings.developer.deviceInfoSection
class _TranslationsSettingsDeveloperDeviceInfoSectionDe implements TranslationsSettingsDeveloperDeviceInfoSectionEn {
	_TranslationsSettingsDeveloperDeviceInfoSectionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get refresh => 'Refresh';
	@override String get copy => 'Copy to Clipboard';
	@override String get computerName => 'Computer Name';
	@override String get osVersion => 'OS Version';
}

// Path: settings.developer.localizationInspectorSection
class _TranslationsSettingsDeveloperLocalizationInspectorSectionDe implements TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
	_TranslationsSettingsDeveloperLocalizationInspectorSectionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get showKeys => 'Show Keys Instead of Values';
	@override String get keysVisible => 'Keys visible';
	@override String get normalDisplay => 'Normal display';
	@override String get note => 'Note: This feature requires app localization to use a wrapper that respects this setting.';
}

// Path: settings.onboarding.steps
class _TranslationsSettingsOnboardingStepsDe implements TranslationsSettingsOnboardingStepsEn {
	_TranslationsSettingsOnboardingStepsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSettingsOnboardingStepsImportFilesDe importFiles = _TranslationsSettingsOnboardingStepsImportFilesDe._(_root);
	@override late final _TranslationsSettingsOnboardingStepsRunComparisonDe runComparison = _TranslationsSettingsOnboardingStepsRunComparisonDe._(_root);
	@override late final _TranslationsSettingsOnboardingStepsReviewMissingDe reviewMissing = _TranslationsSettingsOnboardingStepsReviewMissingDe._(_root);
	@override late final _TranslationsSettingsOnboardingStepsUseFiltersDe useFilters = _TranslationsSettingsOnboardingStepsUseFiltersDe._(_root);
	@override late final _TranslationsSettingsOnboardingStepsSearchResultsDe searchResults = _TranslationsSettingsOnboardingStepsSearchResultsDe._(_root);
	@override late final _TranslationsSettingsOnboardingStepsAdvancedViewDe advancedView = _TranslationsSettingsOnboardingStepsAdvancedViewDe._(_root);
	@override late final _TranslationsSettingsOnboardingStepsEditCellDe editCell = _TranslationsSettingsOnboardingStepsEditCellDe._(_root);
	@override late final _TranslationsSettingsOnboardingStepsExportResultsDe exportResults = _TranslationsSettingsOnboardingStepsExportResultsDe._(_root);
}

// Path: settings.settingsView.categories
class _TranslationsSettingsSettingsViewCategoriesDe implements TranslationsSettingsSettingsViewCategoriesEn {
	_TranslationsSettingsSettingsViewCategoriesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get general => 'General Settings';
	@override String get comparisonEngine => 'Comparison Engine';
	@override String get appearance => 'Appearance';
	@override String get fileHandling => 'File Handling';
	@override String get aiServices => 'AI Services';
	@override String get systemIntegrations => 'System Integrations';
	@override String get projectResources => 'Project Resources (Glossary & TM)';
	@override String get developer => 'Developer Options';
	@override String get about => 'About';
}

// Path: settings.settingsView.categoryLabels
class _TranslationsSettingsSettingsViewCategoryLabelsDe implements TranslationsSettingsSettingsViewCategoryLabelsEn {
	_TranslationsSettingsSettingsViewCategoryLabelsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get general => 'General';
	@override String get comparisonEngine => 'Comparison';
	@override String get appearance => 'Appearance';
	@override String get fileHandling => 'File Handling';
	@override String get aiServices => 'AI Services';
	@override String get systemIntegrations => 'System Integrations';
	@override String get projectResources => 'Project Resources';
	@override String get developer => 'Developer Options';
	@override String get about => 'About';
}

// Path: advancedDiff.sidebar.actionsSection
class _TranslationsAdvancedDiffSidebarActionsSectionDe implements TranslationsAdvancedDiffSidebarActionsSectionEn {
	_TranslationsAdvancedDiffSidebarActionsSectionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get exportMatches => 'Treffer exportieren';
	@override String get preview => 'Vorschau';
	@override String get fillFromTmTitle => 'Aus Übersetzungs-Memory füllen?';
	@override String get fillFromTmContent => 'Dies versucht, leere Zielwerte mit Treffern aus dem Übersetzungs-Memory zu füllen. Bestehende Werte werden NICHT überschrieben.';
	@override String get fill => 'Füllen';
	@override String get fillFromMemory => 'Aus Speicher füllen';
	@override String filledFromTm({required Object count}) => '${count} Elemente aus Übersetzungs-Memory gefüllt.';
}

// Path: advancedDiff.sidebar.aiSection
class _TranslationsAdvancedDiffSidebarAiSectionDe implements TranslationsAdvancedDiffSidebarAiSectionEn {
	_TranslationsAdvancedDiffSidebarAiSectionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get infoCloud => 'Nutzt Cloud-Übersetzung, um leere Zielwerte aus der Quelle zu übersetzen.';
	@override String get infoAi => 'Nutzt KI, um leere Zielwerte aus der Quelle zu übersetzen.';
	@override String get translationSettings => 'Übersetzungseinstellungen';
	@override String get aiSettings => 'KI-Einstellungen';
	@override String get source => 'Quelle';
	@override String get target => 'Ziel';
	@override String translatingProgress({required Object percent}) => 'Übersetze... ${percent}%';
	@override String get translating => 'Übersetze...';
	@override String get translateAllMissing => 'Alle fehlenden übersetzen';
	@override String get translateAllTitle => 'Alle fehlenden übersetzen?';
	@override String translateAllContent({required Object service, required Object source, required Object target}) => 'Dies wird ${service} nutzen, um alle Einträge mit leeren Zielwerten von ${source} nach ${target} zu übersetzen.\n\nSie können jeden Vorschlag prüfen oder alle auf einmal anwenden.';
	@override String get translateAll => 'Alle übersetzen';
	@override String get reviewEach => 'Einzeln prüfen';
	@override String cloudTranslated({required Object count}) => '${count} Einträge mit Cloud-Übersetzung übersetzt.';
	@override String aiTranslated({required Object count}) => '${count} Einträge mit KI übersetzt.';
	@override String get aiTranslateFailed => 'KI-Übersetzung für alle fehlgeschlagen';
	@override String get noMissingEntries => 'Keine fehlenden Einträge zu übersetzen.';
	@override String get skip => 'Überspringen';
	@override String get stop => 'Stopp';
	@override String cloudApplied({required Object count}) => '${count} Vorschläge angewendet.';
	@override String aiApplied({required Object count}) => '${count} KI-Vorschläge angewendet.';
}

// Path: advancedDiff.sidebar.tmSection
class _TranslationsAdvancedDiffSidebarTmSectionDe implements TranslationsAdvancedDiffSidebarTmSectionEn {
	_TranslationsAdvancedDiffSidebarTmSectionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get enableTmFill => 'TM-Füllung aktivieren';
	@override String get autoApplyAboveMinimum => 'Auto-Anwenden über Minimum';
	@override String get matchSettings => 'Treffer-Einstellungen';
	@override String get minMatch => 'Min. Treffer:';
	@override String get limit => 'Limit:';
	@override String get exact => 'Exakt';
}

// Path: advancedDiff.sidebar.filtersSection
class _TranslationsAdvancedDiffSidebarFiltersSectionDe implements TranslationsAdvancedDiffSidebarFiltersSectionEn {
	_TranslationsAdvancedDiffSidebarFiltersSectionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get viewFilters => 'Ansichtsfilter';
	@override String get showAll => 'Alle zeigen';
	@override String get added => 'Hinzugefügt';
	@override String get removed => 'Entfernt';
	@override String get modified => 'Geändert';
	@override String get actionScope => 'Aktionsbereich';
	@override String get applyToAdded => 'Auf Hinzugefügte anwenden';
	@override String get applyToModified => 'Auf Geänderte anwenden';
	@override String get onlyFillEmptyTargets => 'Nur leere Ziele füllen';
	@override String get limitToVisible => 'Auf sichtbare beschränken';
	@override String get editMode => 'Bearbeitungsmodus';
	@override String get dialog => 'Dialog';
	@override String get inline => 'Inline';
}

// Path: advancedDiff.sidebar.similaritySection
class _TranslationsAdvancedDiffSidebarSimilaritySectionDe implements TranslationsAdvancedDiffSidebarSimilaritySectionEn {
	_TranslationsAdvancedDiffSidebarSimilaritySectionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get currentFilter => 'Aktueller Filter:';
	@override String get any => 'ALLE';
	@override String get high => 'HOCH';
	@override String get medium => 'MITTEL';
	@override String get low => 'NIEDRIG';
}

// Path: advancedDiff.sidebar.statusSection
class _TranslationsAdvancedDiffSidebarStatusSectionDe implements TranslationsAdvancedDiffSidebarStatusSectionEn {
	_TranslationsAdvancedDiffSidebarStatusSectionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String total({required Object count}) => '${count} gesamt';
	@override String extra({required Object count}) => '${count} extra';
	@override String missing({required Object count}) => '${count} fehlend';
	@override String changed({required Object count}) => '${count} geändert';
}

// Path: tutorial.steps.importSource
class _TranslationsTutorialStepsImportSourceDe implements TranslationsTutorialStepsImportSourceEn {
	_TranslationsTutorialStepsImportSourceDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => '1. Quelldatei importieren';
	@override String get description => 'Nutzen Sie den Button unten oder Drag & Drop auf den markierten Bereich.';
}

// Path: tutorial.steps.importTarget
class _TranslationsTutorialStepsImportTargetDe implements TranslationsTutorialStepsImportTargetEn {
	_TranslationsTutorialStepsImportTargetDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => '2. Zieldatei importieren';
	@override String get description => 'Nutzen Sie den Button unten oder Drag & Drop auf den markierten Bereich.';
}

// Path: tutorial.steps.compare
class _TranslationsTutorialStepsCompareDe implements TranslationsTutorialStepsCompareEn {
	_TranslationsTutorialStepsCompareDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => '3. Dateien vergleichen';
	@override String get description => 'Tippen Sie den Button unten, um den Vergleich zu starten.';
}

// Path: tutorial.steps.filter
class _TranslationsTutorialStepsFilterDe implements TranslationsTutorialStepsFilterEn {
	_TranslationsTutorialStepsFilterDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => '4. Ergebnisse filtern';
	@override String get description => 'Nutzen Sie diese Filter für Hinzugefügt, Entfernt oder Geändert.';
}

// Path: tutorial.steps.search
class _TranslationsTutorialStepsSearchDe implements TranslationsTutorialStepsSearchEn {
	_TranslationsTutorialStepsSearchDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => '5. Ergebnisse suchen';
	@override String get description => 'Finden Sie spezifische Schlüssel oder Werte.';
}

// Path: tutorial.steps.advanced
class _TranslationsTutorialStepsAdvancedDe implements TranslationsTutorialStepsAdvancedEn {
	_TranslationsTutorialStepsAdvancedDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => '6. Erweiterte Ansicht';
	@override String get description => 'Öffnen Sie die Detailansicht mit Bearbeitung, KI-Übersetzung und mehr.';
}

// Path: tutorial.steps.export
class _TranslationsTutorialStepsExportDe implements TranslationsTutorialStepsExportEn {
	_TranslationsTutorialStepsExportDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => '7. Ergebnisse exportieren';
	@override String get description => 'Speichern Sie Ihren Vergleich als CSV, JSON oder Excel.';
}

// Path: settings.developer.themePlaygroundSection.palette
class _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteDe implements TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
	_TranslationsSettingsDeveloperThemePlaygroundSectionPaletteDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get primary => 'Primary';
	@override String get onPrimary => 'On Primary';
	@override String get secondary => 'Secondary';
	@override String get onSecondary => 'On Secondary';
	@override String get surface => 'Surface';
	@override String get onSurface => 'On Surface';
	@override String get error => 'Error';
	@override String get onError => 'On Error';
	@override String get outline => 'Outline';
	@override String get shadow => 'Shadow';
	@override String get success => 'Success';
	@override String get warning => 'Warning';
	@override String get info => 'Info';
}

// Path: settings.developer.featureFlags.flags
class _TranslationsSettingsDeveloperFeatureFlagsFlagsDe implements TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
	_TranslationsSettingsDeveloperFeatureFlagsFlagsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchDe experimental_ai_batch = _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchDe._(_root);
	@override late final _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmDe new_diff_algorithm = _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmDe._(_root);
	@override late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchDe enhanced_search = _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchDe._(_root);
	@override late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveDe auto_save = _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveDe._(_root);
}

// Path: settings.onboarding.steps.importFiles
class _TranslationsSettingsOnboardingStepsImportFilesDe implements TranslationsSettingsOnboardingStepsImportFilesEn {
	_TranslationsSettingsOnboardingStepsImportFilesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dateien importieren';
	@override String get description => 'Quell- & Zieldateien laden';
}

// Path: settings.onboarding.steps.runComparison
class _TranslationsSettingsOnboardingStepsRunComparisonDe implements TranslationsSettingsOnboardingStepsRunComparisonEn {
	_TranslationsSettingsOnboardingStepsRunComparisonDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vergleich starten';
	@override String get description => 'Klicken Sie auf "Dateien vergleichen"';
}

// Path: settings.onboarding.steps.reviewMissing
class _TranslationsSettingsOnboardingStepsReviewMissingDe implements TranslationsSettingsOnboardingStepsReviewMissingEn {
	_TranslationsSettingsOnboardingStepsReviewMissingDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fehlende Schlüssel prüfen';
	@override String get description => 'Achten Sie auf rote MISSING Elemente';
}

// Path: settings.onboarding.steps.useFilters
class _TranslationsSettingsOnboardingStepsUseFiltersDe implements TranslationsSettingsOnboardingStepsUseFiltersEn {
	_TranslationsSettingsOnboardingStepsUseFiltersDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filter verwenden';
	@override String get description => 'Nach Typ filtern';
}

// Path: settings.onboarding.steps.searchResults
class _TranslationsSettingsOnboardingStepsSearchResultsDe implements TranslationsSettingsOnboardingStepsSearchResultsEn {
	_TranslationsSettingsOnboardingStepsSearchResultsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Suchergebnisse';
	@override String get description => 'Bestimmte Schlüssel finden';
}

// Path: settings.onboarding.steps.advancedView
class _TranslationsSettingsOnboardingStepsAdvancedViewDe implements TranslationsSettingsOnboardingStepsAdvancedViewEn {
	_TranslationsSettingsOnboardingStepsAdvancedViewDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Erweiterte Ansicht';
	@override String get description => 'Detaillierte Analyse erkunden';
}

// Path: settings.onboarding.steps.editCell
class _TranslationsSettingsOnboardingStepsEditCellDe implements TranslationsSettingsOnboardingStepsEditCellEn {
	_TranslationsSettingsOnboardingStepsEditCellDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zelle bearbeiten';
	@override String get description => 'Klicken zum Bearbeiten';
}

// Path: settings.onboarding.steps.exportResults
class _TranslationsSettingsOnboardingStepsExportResultsDe implements TranslationsSettingsOnboardingStepsExportResultsEn {
	_TranslationsSettingsOnboardingStepsExportResultsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exportieren';
	@override String get description => 'Bericht speichern';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchDe implements TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
	_TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Experimental AI Batch';
	@override String get description => 'Enable batch AI translation for multiple rows';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmDe implements TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
	_TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'New Diff Algorithm';
	@override String get description => 'Use improved diffing algorithm for comparisons';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchDe implements TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
	_TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Enhanced Search';
	@override String get description => 'Enable fuzzy search in translation files';
}

// Path: settings.developer.featureFlags.flags.auto_save
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveDe implements TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
	_TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Auto Save';
	@override String get description => 'Automatically save changes after edits';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'Lokalisierungs-Vergleichstool',
			'app.name' => 'Localizer',
			'common.save' => 'Speichern',
			'common.cancel' => 'Abbrechen',
			'common.close' => 'Schließen',
			'common.delete' => 'Löschen',
			'common.edit' => 'Bearbeiten',
			'common.add' => 'Hinzufügen',
			'common.search' => 'Suchen',
			'common.undo' => 'Rückgängig',
			'common.loading' => 'Laden...',
			'common.error' => 'Fehler',
			'common.success' => 'Erfolg',
			'common.warning' => 'Warnung',
			'common.info' => 'Info',
			'common.confirm' => 'Bestätigen',
			'common.yes' => 'Ja',
			'common.no' => 'Nein',
			'common.ok' => 'OK',
			'common.retry' => 'Wiederholen',
			'common.copyText' => 'Kopieren',
			'common.appName' => 'Localizer',
			'common.copied' => 'Kopiert!',
			'common.enabled' => 'Aktiviert',
			'common.disabled' => 'Deaktiviert',
			'common.browse' => 'Durchsuchen',
			'common.clear' => 'Leeren',
			'common.apply' => 'Anwenden',
			'common.reset' => 'Zurücksetzen',
			'common.refresh' => 'Aktualisieren',
			'common.export' => 'Exportieren',
			'common.import' => 'Importieren',
			'common.select' => 'Auswählen',
			'common.selectAll' => 'Alles auswählen',
			'common.deselectAll' => 'Alles abwählen',
			'common.noResults' => 'Keine Ergebnisse gefunden',
			'common.emptyState' => 'Hier ist noch nichts',
			'common.open' => 'Öffnen',
			'common.change' => 'Ändern',
			'common.original' => 'Original',
			'common.kNew' => 'Neu',
			'common.remove' => 'Entfernen',
			'common.auto' => 'Auto',
			'common.execute' => 'Ausführen',
			'common.run' => 'Starten',
			'common.unknown' => 'Unbekannt',
			'common.download' => 'Herunterladen',
			'common.dropdownArrow' => 'Dropdown-Pfeil',
			'common.openInNewWindow' => 'Öffnet in neuem Fenster',
			'common.resetToDefaults' => 'Auf Standards zurücksetzen',
			'menu.file' => 'Datei',
			'menu.edit' => 'Bearbeiten',
			'menu.view' => 'Ansicht',
			'menu.help' => 'Hilfe',
			'menu.openFiles' => 'Dateien öffnen...',
			'menu.openFolder' => 'Ordner öffnen...',
			'menu.exportResults' => 'Ergebnisse exportieren...',
			'menu.undo' => 'Rückgängig',
			'menu.redo' => 'Wiederholen',
			'menu.cut' => 'Ausschneiden',
			'menu.paste' => 'Einfügen',
			'menu.selectAll' => 'Alles auswählen',
			'menu.zoomIn' => 'Vergrößern',
			'menu.zoomOut' => 'Verkleinern',
			'menu.resetZoom' => 'Zoom zurücksetzen',
			'menu.documentation' => 'Dokumentation',
			'menu.reportIssue' => 'Problem melden',
			'menu.about' => ({required Object appName}) => 'Über ${appName}',
			'nav.compare' => 'Vergleichen',
			'nav.history' => 'Verlauf',
			'nav.settings' => 'Einstellungen',
			'nav.projects' => 'Projekte',
			'nav.dashboard' => 'Dashboard',
			'nav.directory' => 'Verzeichnis',
			'nav.repository' => 'Repository',
			'nav.tooltipCompare' => 'Lokalisierungsdateien vergleichen',
			'nav.tooltipHistory' => 'Vergleichsverlauf anzeigen',
			'nav.tooltipSettings' => 'App-Einstellungen',
			'nav.tooltipProjects' => 'Projekte verwalten',
			'nav.tooltipThemeToggle' => 'Design umschalten',
			'nav.tooltipDebugConsole' => 'Debug-Konsole',
			'settings.title' => 'Settings',
			'settings.appSettings' => 'App Settings',
			'settings.projectSettings' => 'Project Settings',
			'settings.appearance.title' => 'Erscheinungsbild',
			'settings.appearance.description' => 'Passen Sie das Aussehen der App an',
			'settings.appearance.theme' => 'Design-Modus',
			'settings.appearance.themeDescription' => 'Wählen Sie zwischen Hell, Dunkel oder System',
			'settings.appearance.themeSystem' => 'System',
			'settings.appearance.themeLight' => 'Hell',
			'settings.appearance.themeDark' => 'Dunkel',
			'settings.appearance.themeAmoled' => 'AMOLED',
			'settings.appearance.accentColor' => 'Akzentfarbe',
			'settings.appearance.accentColorDescription' => 'Wählen Sie Ihre bevorzugte Akzentfarbe',
			'settings.appearance.useMicaEffect' => 'Mica-Effekt verwenden',
			'settings.appearance.micaDescription' => 'Windows 11 Mica-Transparenzeffekt aktivieren',
			'settings.appearance.diffFontSize' => 'Diff Schriftgröße',
			'settings.appearance.diffFontSizeDescription' => 'Schriftgröße der Vergleichsansicht anpassen',
			'settings.appearance.diffFontFamily' => 'Diff Schriftart',
			'settings.appearance.diffFontFamilyDescription' => 'Schriftart für die Vergleichsansicht',
			'settings.appearance.systemDefault' => 'Systemstandard',
			'settings.appearance.pickAccentColor' => 'Akzentfarbe wählen',
			'settings.appearance.diffColors' => 'Diff Farben',
			'settings.appearance.presetsTitle' => 'Vorlagen',
			'settings.appearance.presets.presetDefault' => 'Standard',
			'settings.appearance.presets.presetColorblind' => 'Farbenblind-Freundlich',
			'settings.appearance.presets.presetHighContrast' => 'Hoher Kontrast',
			'settings.appearance.presets.presetNord' => 'Nord',
			'settings.appearance.presets.presetSolarized' => 'Solarized',
			'settings.appearance.presets.presetMonokai' => 'Monokai',
			'settings.appearance.identical' => 'Identisch',
			'settings.appearance.pickColorFor' => ({required Object label}) => 'Farbe für ${label} wählen',
			'settings.appearance.livePreview' => 'Live-Vorschau',
			'settings.appearance.preview.step3Title' => 'onboarding.step3.title',
			'settings.appearance.preview.connectAccount' => '"Konto verbinden"',
			'settings.appearance.preview.loginHint' => 'deprecated.login_hint_v1',
			'settings.appearance.preview.enterCredentials' => '"Anmeldedaten eingeben"',
			'settings.appearance.preview.ctaButton' => 'checkout.cta_button',
			'settings.appearance.preview.buyNow' => '"Jetzt kaufen"',
			'settings.appearance.preview.completePurchase' => '"Kauf abschließen"',
			'settings.appearance.preview.appNameKey' => 'common.app_name',
			'settings.appearance.preview.appNameValue' => '"Localizer"',
			'settings.general.title' => 'Allgemein',
			'settings.general.description' => 'Allgemeine Anwendungseinstellungen',
			'settings.general.language' => 'Sprache',
			'settings.general.languageDescription' => 'Wählen Sie Ihre bevorzugte Sprache',
			'settings.general.startMinimized' => 'Minimiert im Tray starten',
			'settings.general.startMinimizedDescription' => 'App minimiert im System-Tray starten',
			'settings.general.rememberWindowPosition' => 'Fensterposition merken',
			'settings.general.rememberWindowPositionDescription' => 'Fenstergröße und -position beim Start wiederherstellen',
			'settings.general.openLastProject' => 'Letztes Projekt beim Start öffnen',
			'settings.general.openLastProjectDescription' => 'Automatisch das zuletzt verwendete Projekt öffnen',
			'settings.general.application' => 'Anwendung',
			'settings.general.defaultView' => 'Standardansicht',
			'settings.general.defaultViewDescription' => 'Ansicht beim Start',
			'settings.general.autoCheckUpdates' => 'Automatisch nach Updates suchen',
			'settings.general.autoCheckUpdatesDescription' => 'Beim Start nach Updates suchen',
			'settings.general.startupOptions' => 'Startoptionen',
			'settings.general.languageAuto' => 'Automatisch erkennen',
			'settings.general.viewBasic' => 'Dateivergleich',
			'settings.general.viewHistory' => 'Verlauf',
			'settings.general.viewDashboard' => 'Qualitäts-Dashboard',
			'settings.general.viewDirectory' => 'Ordnervergleich',
			'settings.general.viewLastUsed' => 'Zuletzt verwendete Ansicht',
			'settings.scope.title' => 'Einstellungsbereich',
			'settings.scope.global' => 'Globale Standards',
			'settings.scope.project' => 'Projekt',
			'settings.scope.reset' => 'Projekt auf globale Standards zurücksetzen',
			'settings.scope.resetConfirmation' => 'Dies löscht alle Überschreibungen für dieses Projekt und kehrt zu globalen Standards zurück. Dies kann nicht rückgängig gemacht werden.',
			'settings.scope.globalDescription' => 'Änderungen gelten für alle Projekte, sofern nicht überschrieben.',
			'settings.scope.projectDescription' => ({required Object name}) => 'Änderungen gelten nur für "${name}". Andere Einstellungen erben von globalen Standards.',
			'settings.scope.createPrompt' => 'Erstellen Sie ein Projekt, um Einstellungen für bestimmte Ordner anzupassen',
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
			'settings.comparison.title' => 'Vergleich',
			'settings.comparison.description' => 'Vergleichsverhalten konfigurieren',
			'settings.comparison.caseSensitive' => 'Groß-/Kleinschreibung beachten',
			'settings.comparison.caseSensitiveDescription' => 'Groß- und Kleinbuchstaben als unterschiedlich behandeln',
			'settings.comparison.ignoreWhitespace' => 'Leerzeichen ignorieren',
			'settings.comparison.ignoreWhitespaceDescription' => 'Führende/abschließende Leerzeichen beim Vergleich ignorieren',
			'settings.comparison.showLineNumbers' => 'Zeilennummern anzeigen',
			'settings.comparison.showLineNumbersDescription' => 'Zeilennummern in der Diff-Ansicht anzeigen',
			'settings.comparison.behavior' => 'Vergleichsverhalten',
			'settings.comparison.ignoreCase' => 'Groß-/Kleinschreibung ignorieren',
			'settings.comparison.ignoreCaseDescription' => '"Key" und "key" als gleich behandeln',
			'settings.comparison.similarityThreshold' => 'Ähnlichkeitsschwelle',
			'settings.comparison.similarityThresholdDescription' => 'Minimale Ähnlichkeit für "Geändert"-Erkennung',
			'settings.comparison.mode' => 'Vergleichsmodus',
			'settings.comparison.modeDescription' => 'Wie Einträge zwischen Dateien abgeglichen werden',
			'settings.comparison.modeKey' => 'Schlüssel-basiert',
			'settings.comparison.modeKeyDescription' => 'Gleicht nach Schlüsselnamen ab (Standard).',
			'settings.comparison.modeOrder' => 'Reihenfolge-basiert',
			'settings.comparison.modeOrderDescription' => 'Gleicht nach Position in der Datei ab.',
			'settings.comparison.modeSmart' => 'Smart Match',
			'settings.comparison.modeSmartDescription' => 'Erkennt verschobene/umbenannte Schlüssel.',
			'settings.comparison.ignorePatterns' => 'Muster ignorieren',
			'settings.comparison.noIgnorePatterns' => 'Keine Ignorier-Muster gesetzt.',
			'settings.comparison.addPattern' => 'Muster hinzufügen',
			'settings.comparison.resetToGlobal' => 'Alle Vergleichseinstellungen auf globale Standards zurücksetzen',
			'settings.comparison.patternPresets.comments' => 'Kommentare',
			'settings.comparison.patternPresets.tempKeys' => 'Temp-Schlüssel',
			'settings.comparison.patternPresets.placeholders' => 'Platzhalter',
			'settings.comparison.patternPresets.devOnly' => 'Nur Entwickler',
			'settings.comparison.previewMatch.title' => 'Vorschau',
			'settings.comparison.previewMatch.description' => 'Testen Sie, wie sich Ihre Einstellungen auf die Abgleichlogik auswirken.',
			'settings.comparison.previewMatch.stringA' => 'String A',
			'settings.comparison.previewMatch.stringB' => 'String B',
			'settings.comparison.previewMatch.enterText' => 'Text eingeben...',
			'settings.comparison.previewMatch.similarity' => 'Ähnlichkeit',
			'settings.comparison.previewMatch.identical' => 'Identisch',
			'settings.comparison.previewMatch.identicalDescription' => 'Strings stimmen nach Normalisierung exakt überein.',
			'settings.comparison.previewMatch.ignored' => 'Ignoriert',
			'settings.comparison.previewMatch.ignoredDescription' => 'Eingabe entspricht einem Ignorier-Muster.',
			'settings.comparison.previewMatch.different' => 'Unterschiedlich',
			'settings.comparison.previewMatch.differentDescription' => 'Ein Wert ist leer.',
			'settings.comparison.previewMatch.similarModified' => 'Ähnlich / Geändert',
			'settings.comparison.previewMatch.similarModifiedDescription' => ({required Object threshold}) => 'Übereinstimmungsrate liegt über der Schwelle (${threshold}%).',
			'settings.comparison.previewMatch.newDifferent' => 'Neu / Unterschiedlich',
			'settings.comparison.previewMatch.newDifferentDescription' => ({required Object threshold}) => 'Übereinstimmungsrate liegt unter der Schwelle (${threshold}%).',
			'settings.comparison.colorPresets.kDefault' => 'Standard',
			'settings.comparison.colorPresets.colorblindFriendly' => 'Farbenblind-Freundlich',
			'settings.comparison.colorPresets.highContrast' => 'Hoher Kontrast',
			'settings.comparison.colorPresets.nord' => 'Nord',
			'settings.comparison.colorPresets.solarized' => 'Solarized',
			'settings.comparison.colorPresets.monokai' => 'Monokai',
			'settings.comparison.colorPresets.presetDefault' => 'Standard',
			'settings.comparison.colorPresets.presetColorblind' => 'Farbenblind-Freundlich',
			'settings.comparison.colorPresets.presetHighContrast' => 'Hoher Kontrast',
			'settings.comparison.colorPresets.presetNord' => 'Nord',
			'settings.comparison.colorPresets.presetSolarized' => 'Solarized',
			'settings.comparison.colorPresets.presetMonokai' => 'Monokai',
			'settings.fileHandling.fileFormats' => 'Dateiformate',
			'settings.fileHandling.sourceFormat' => 'Quellformat',
			'settings.fileHandling.targetFormat' => 'Zielformat',
			'settings.fileHandling.encoding' => 'Kodierung',
			'settings.fileHandling.sourceEncoding' => 'Quellkodierung',
			'settings.fileHandling.targetEncoding' => 'Zielkodierung',
			'settings.fileHandling.autoDetect' => 'Automatisch erkennen',
			'settings.fileHandling.autoDetectEncodingDescription' => 'Dateikodierung automatisch erkennen',
			'settings.fileHandling.exportSettings' => 'Exporteinstellungen',
			'settings.fileHandling.defaultExportFormat' => 'Standard-Exportformat',
			'settings.fileHandling.includeUtf8Bom' => 'UTF-8 BOM einschließen',
			'settings.fileHandling.includeUtf8BomDescription' => 'Erforderlich für Excel-Kompatibilität',
			'settings.fileHandling.openFolderAfterExport' => 'Ordner nach Export öffnen',
			'settings.fileHandling.fileSafety' => 'Dateisicherheit',
			'settings.fileHandling.fileSafetyDescription' => 'Automatische lokale Kopien zur Wiederherstellung.',
			'settings.fileHandling.resetToGlobal' => 'Alle Dateihandhabungs-Einstellungen auf globale Standards zurücksetzen',
			'settings.translationMemory.title' => 'Globales Übersetzungs-Memory',
			'settings.translationMemory.autoLearn' => 'Automatisch lernen',
			'settings.translationMemory.autoLearnDescription' => 'Übersetzungen zur Wiederverwendung speichern',
			'settings.translationMemory.confidenceThreshold' => 'Konfidenzschwelle',
			'settings.translationMemory.confidenceThresholdDescription' => ({required Object percent}) => 'Mindestwert für automatische Anwendung (${percent}%)',
			'settings.translationMemory.entries' => 'Einträge',
			'settings.translationMemory.size' => 'Größe',
			'settings.translationMemory.memorySize' => ({required Object size}) => 'Speichergröße: ${size}',
			'settings.translationMemory.import' => 'Importieren',
			'settings.translationMemory.exportTmx' => 'TMX exportieren',
			'settings.translationMemory.exportCsv' => 'CSV exportieren',
			'settings.translationMemory.clearMemory' => 'Speicher leeren',
			'settings.translationMemory.importedItems' => ({required Object count}) => '${count} Einträge importiert.',
			'settings.translationMemory.noItemsAdded' => 'Keine Einträge hinzugefügt.',
			'settings.translationMemory.nothingToExport' => 'Nichts zu exportieren.',
			'settings.translationMemory.tmxSaved' => 'TMX gespeichert',
			'settings.translationMemory.csvSaved' => 'CSV gespeichert',
			'settings.translationMemory.clearConfirmTitle' => 'Übersetzungs-Memory leeren?',
			'settings.translationMemory.clearConfirmContent' => 'Dies löscht alle gespeicherten Übersetzungspaare auf diesem Gerät. Dies kann nicht rückgängig gemacht werden.',
			'settings.translationMemory.cleared' => 'Übersetzungs-Memory geleert.',
			'settings.translationMemory.couldNotClear' => 'Speicher konnte nicht geleert werden.',
			'settings.backup.title' => 'Auto-Backup',
			'settings.backup.description' => 'Automatische Backup-Einstellungen',
			'settings.backup.enabled' => 'Auto-Backup aktivieren',
			'settings.backup.enabledDescription' => 'Dateien vor Änderungen automatisch sichern',
			'settings.backup.maxCopies' => 'Maximale Backup-Kopien',
			'settings.backup.maxCopiesDescription' => 'Anzahl der zu behaltenden Kopien pro Datei',
			'settings.backup.activeStatus' => ({required Object count}) => 'Aktiv · Behalte ${count} Kopien',
			'settings.backup.folder' => 'Backup-Ordner',
			'settings.backup.folderDescription' => 'Leer lassen, um den gleichen Ordner zu verwenden',
			'settings.backup.useOriginalFolder' => 'Originalordner verwenden',
			'settings.ai.title' => 'KI-Dienste',
			'settings.ai.description' => 'KI-Übersetzung und Assistenz konfigurieren',
			'settings.ai.provider' => 'KI-Anbieter',
			'settings.ai.providerDescription' => 'Wählen Sie Ihren bevorzugten KI-Dienstleister',
			'settings.ai.apiKey' => 'API-Schlüssel',
			'settings.ai.apiKeyDescription' => 'Geben Sie Ihren API-Schlüssel für den gewählten Anbieter ein',
			'settings.ai.apiKeyPlaceholder' => 'API-Schlüssel eingeben...',
			'settings.ai.testConnection' => 'Verbindung testen',
			'settings.ai.connectionSuccess' => 'Verbindung erfolgreich!',
			'settings.ai.connectionFailed' => 'Verbindung fehlgeschlagen. Bitte prüfen Sie Ihren API-Schlüssel.',
			'settings.ai.translationStrategy' => 'Übersetzungsstrategie',
			'settings.ai.strategy' => 'Strategie',
			'settings.ai.strategyDescription' => 'Wählen Sie, wie Strings übersetzt werden sollen',
			'settings.ai.strategyLLM' => 'Generative KI (LLM)',
			'settings.ai.strategyCloud' => 'Cloud-Übersetzung',
			'settings.ai.enableAiTranslation' => 'KI-Übersetzung aktivieren',
			'settings.ai.enableAiTranslationDescription' => 'Erlaubt der App, KI für Übersetzungsvorschläge zu nutzen',
			'settings.ai.llmProvider' => 'LLM-Dienstleister',
			'settings.ai.service' => 'Dienst',
			'settings.ai.serviceDescription' => 'Anbieter für Generative KI',
			'settings.ai.providerGemini' => 'Google Gemini',
			'settings.ai.providerOpenAI' => 'OpenAI',
			'settings.ai.geminiApiKey' => 'Gemini API-Schlüssel',
			'settings.ai.openAiApiKey' => 'OpenAI API-Schlüssel',
			'settings.ai.model' => 'Modell',
			'settings.ai.modelDescription' => 'Wählen Sie das zu verwendende Modell',
			'settings.ai.advancedParameters' => 'Erweiterte Parameter',
			'settings.ai.parameters' => 'Parameter',
			'settings.ai.parametersDescription' => 'Temperatur, Kontext und mehr',
			'settings.ai.temperature' => 'Temperatur',
			'settings.ai.temperatureDescription' => 'Höhere Werte machen die Ausgabe kreativer',
			'settings.ai.maxTokens' => 'Max Tokens',
			'settings.ai.maxTokensDescription' => 'Begrenzung der Kontextfensterlänge',
			'settings.ai.systemContext' => 'Systemkontext / Anweisungen',
			'settings.ai.systemContextHint' => 'Sie sind ein professioneller Übersetzer. Behalten Sie Ton und Absicht bei...',
			'settings.ai.systemContextHelper' => 'Geben Sie spezifische Anweisungen an die KI zum Stil und zur Terminologie Ihres Projekts.',
			'settings.ai.contextStrings' => 'Kontext-Strings',
			'settings.ai.contextStringsDescription' => 'Umliegende Strings für besseren Kontext einbeziehen',
			'settings.ai.contextCount' => 'Kontext-Anzahl',
			'settings.ai.contextCountDescription' => 'Anzahl der einzubeziehenden umliegenden Strings',
			'settings.ai.cloudServices' => 'Cloud-Übersetzungsdienste',
			'settings.ai.googleTranslateApiKey' => 'Google Translate API-Schlüssel',
			'settings.ai.deeplApiKey' => 'DeepL API-Schlüssel',
			'settings.ai.test' => 'Testen',
			'settings.ai.resetToGlobal' => 'Alle KI-Einstellungen auf globale Standards zurücksetzen',
			'settings.integrations.platformNotice' => 'Plattform-Hinweis',
			'settings.integrations.platformNoticeDescription' => 'Systemintegrationen sind für diese Plattform nicht verfügbar.',
			'settings.integrations.visualEffects' => 'Visuelle Effekte',
			'settings.integrations.explorerIntegration' => 'Explorer-Integration',
			'settings.integrations.explorerIntegrationDescription' => '"Mit Localizer öffnen" zum Windows Explorer Kontextmenü hinzufügen.',
			'settings.integrations.addToContextMenu' => 'Zum Kontextmenü hinzufügen',
			'settings.integrations.contextMenuAdded' => 'Kontextmenü hinzugefügt!',
			'settings.integrations.contextMenuAddError' => 'Fehler beim Hinzufügen zum Kontextmenü',
			'settings.integrations.contextMenuRemoved' => 'Kontextmenü entfernt!',
			'settings.integrations.contextMenuRemoveError' => 'Fehler beim Entfernen vom Kontextmenü',
			'settings.integrations.fileAssociations' => 'Dateizuordnungen',
			'settings.integrations.fileAssociationsDescription' => 'Dateitypen registrieren, um sie mit Localizer per Doppelklick zu öffnen.',
			'settings.integrations.registered' => 'Registriert',
			'settings.integrations.notRegistered' => 'Nicht registriert',
			'settings.integrations.extRegistered' => ({required Object ext}) => '${ext} registriert!',
			'settings.integrations.extUnregistered' => ({required Object ext}) => '${ext} deregistriert!',
			'settings.integrations.extError' => ({required Object action, required Object ext}) => 'Fehler bei ${action} von ${ext}',
			'settings.integrations.registerAll' => 'Alle registrieren',
			'settings.integrations.unregisterAll' => 'Alle deregistrieren',
			'settings.integrations.registerAllResult' => ({required Object success, required Object total}) => '${success} von ${total} Dateitypen registriert',
			'settings.integrations.unregisterAllResult' => ({required Object success, required Object total}) => '${success} von ${total} Dateitypen deregistriert',
			'settings.integrations.protocolHandler' => 'Protokoll-Handler',
			'settings.integrations.protocolHandlerDescription' => 'localizer:// URLs registrieren. Erlaubt das Öffnen von Projekten aus dem Browser.',
			'settings.integrations.protocolRegistered' => 'Protokoll-Handler ist registriert',
			'settings.integrations.protocolNotRegistered' => 'Protokoll-Handler nicht registriert',
			'settings.integrations.registerProtocol' => 'Protokoll registrieren',
			'settings.integrations.unregister' => 'Deregistrieren',
			'settings.integrations.protocolRegisteredSuccess' => 'Protokoll-Handler registriert!',
			'settings.integrations.protocolRemovedSuccess' => 'Protokoll-Handler entfernt!',
			'settings.integrations.protocolRegisterError' => 'Fehler beim Registrieren',
			'settings.integrations.protocolRemoveError' => 'Fehler beim Entfernen',
			'settings.integrations.windowMaterial' => 'Fenstermaterial',
			'settings.integrations.windowMaterialDescription' => 'Wählen Sie den macOS Vibrancy-Stil',
			'settings.integrations.dockIntegration' => 'Dock-Integration',
			'settings.integrations.showDockBadge' => 'Unübersetzte Anzahl zeigen',
			'settings.integrations.showDockBadgeDescription' => 'Anzahl unübersetzter Strings am Dock-Icon anzeigen',
			'settings.integrations.materials.sidebar' => 'Seitenleiste',
			'settings.integrations.materials.menu' => 'Menü',
			'settings.integrations.materials.popover' => 'Popover',
			'settings.integrations.materials.titlebar' => 'Titelleiste',
			'settings.integrations.materials.underPageBackground' => 'Seitenhintergrund',
			'settings.integrations.materials.contentBackground' => 'Inhalt',
			'settings.integrations.fileTypes.loc' => 'Localizer Projektdatei',
			'settings.integrations.fileTypes.lang' => 'Sprachdatei',
			'settings.integrations.fileTypes.json' => 'JSON Lokalisierungsdatei',
			'settings.integrations.fileTypes.xml' => 'XML Lokalisierungsdatei',
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
			'settings.about.title' => 'Über',
			'settings.about.version' => 'Version',
			'settings.about.buildNumber' => 'Build-Nummer',
			'settings.about.author' => 'Autor',
			_ => null,
		} ?? switch (path) {
			'settings.about.license' => 'Lizenz',
			'settings.about.sourceCode' => 'Quellcode',
			'settings.about.reportBug' => 'Fehler melden',
			'settings.about.requestFeature' => 'Feature vorschlagen',
			'settings.about.checkForUpdates' => 'Nach Updates suchen',
			'settings.about.upToDate' => 'Sie sind auf dem neuesten Stand!',
			'settings.about.updateAvailable' => ({required Object version}) => 'Update verfügbar: ${version}',
			'settings.about.updateAvailableBadge' => 'Update verfügbar!',
			'settings.about.developerSteps' => ({required Object count}) => 'Sie sind ${count} Schritte davon entfernt, Entwickler zu sein.',
			'settings.about.developerActivated' => 'Sie sind jetzt Entwickler!',
			'settings.about.neverChecked' => 'Nie',
			'settings.about.applicationInfo' => 'Anwendungsinformationen',
			'settings.about.platform' => 'Plattform',
			'settings.about.updateInformation' => 'Update-Informationen',
			'settings.about.currentVersion' => 'Aktuelle Version',
			'settings.about.latestVersion' => 'Neueste Version',
			'settings.about.lastChecked' => 'Zuletzt geprüft',
			'settings.about.checkingForUpdates' => 'Prüfe...',
			'settings.about.whatsNew' => 'Was ist neu',
			'settings.about.systemInformation' => 'Systeminformationen',
			'settings.about.dartVersion' => 'Dart-Version',
			'settings.about.diskSpace' => 'Verfügbarer Speicherplatz',
			'settings.about.memoryUsage' => 'Speichernutzung',
			'settings.about.privacyTitle' => 'Datenschutz & Telemetrie',
			'settings.about.usageStats' => 'Anonyme Nutzungsstatistiken',
			'settings.about.requiresFirebase' => 'Erfordert Firebase-Konfiguration',
			'settings.about.featureUnavailable' => 'Funktion derzeit nicht verfügbar (Benötigt Firebase)',
			'settings.about.settingsManagement' => 'Einstellungsverwaltung',
			'settings.about.settingsManagementDescription' => 'Exportieren Sie Ihre Einstellungen in eine Datei, um sie zu sichern oder zu teilen.',
			'settings.about.resetAll' => 'Alles zurücksetzen',
			'settings.about.links' => 'Links',
			'settings.about.githubRepo' => 'GitHub Repository',
			'settings.about.privacyPolicy' => 'Datenschutzerklärung',
			'settings.about.crashReporting' => 'Absturzberichte',
			'settings.onboarding.skipTutorial' => 'Tutorial überspringen',
			'settings.onboarding.gettingStarted' => 'Erste Schritte',
			'settings.onboarding.stepProgress' => ({required Object current, required Object total}) => '${current} von ${total}',
			'settings.onboarding.loadSampleData' => 'Beispieldaten laden',
			'settings.onboarding.steps.importFiles.title' => 'Dateien importieren',
			'settings.onboarding.steps.importFiles.description' => 'Quell- & Zieldateien laden',
			'settings.onboarding.steps.runComparison.title' => 'Vergleich starten',
			'settings.onboarding.steps.runComparison.description' => 'Klicken Sie auf "Dateien vergleichen"',
			'settings.onboarding.steps.reviewMissing.title' => 'Fehlende Schlüssel prüfen',
			'settings.onboarding.steps.reviewMissing.description' => 'Achten Sie auf rote MISSING Elemente',
			'settings.onboarding.steps.useFilters.title' => 'Filter verwenden',
			'settings.onboarding.steps.useFilters.description' => 'Nach Typ filtern',
			'settings.onboarding.steps.searchResults.title' => 'Suchergebnisse',
			'settings.onboarding.steps.searchResults.description' => 'Bestimmte Schlüssel finden',
			'settings.onboarding.steps.advancedView.title' => 'Erweiterte Ansicht',
			'settings.onboarding.steps.advancedView.description' => 'Detaillierte Analyse erkunden',
			'settings.onboarding.steps.editCell.title' => 'Zelle bearbeiten',
			'settings.onboarding.steps.editCell.description' => 'Klicken zum Bearbeiten',
			'settings.onboarding.steps.exportResults.title' => 'Exportieren',
			'settings.onboarding.steps.exportResults.description' => 'Bericht speichern',
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
			'fileComparison.title' => 'Dateivergleich',
			'fileComparison.openFiles' => 'Dateien öffnen',
			'fileComparison.exportResults' => 'Ergebnisse exportieren',
			'fileComparison.restartTutorial' => 'Tutorial neu starten',
			'fileComparison.restartTutorialDevOnly' => 'Tutorial-Neustart ist nur im Entwicklermodus verfügbar.',
			'fileComparison.unsupportedFileType' => 'Nicht unterstützter Dateityp.',
			'fileComparison.unsupportedFileTypeSuggestion' => 'Bitte wählen Sie eine unterstützte Lokalisierungsdatei.',
			'fileComparison.someFilesUnsupported' => 'Einige Dateien werden nicht unterstützt.',
			'fileComparison.pickSupportedFiles' => 'Wählen Sie nur unterstützte Lokalisierungsdateien.',
			'fileComparison.pickTwoFiles' => 'Wählen Sie zwei Dateien zum Vergleichen.',
			'fileComparison.pickBilingualFile' => 'Bitte wählen Sie eine zweisprachige Datei zum Vergleichen.',
			'fileComparison.noResultsToExport' => 'Noch keine Ergebnisse zum Exportieren.',
			'fileComparison.performComparisonFirst' => 'Führen Sie zuerst einen Vergleich durch, um Ergebnisse zu exportieren.',
			'fileComparison.performComparisonFirstEditor' => 'Bitte führen Sie zuerst einen Vergleich durch, um Details zu sehen.',
			'fileComparison.sampleDataLoaded' => 'Beispieldaten erfolgreich geladen',
			'fileComparison.loadSampleDataError' => ({required Object error}) => 'Fehler beim Laden der Beispieldaten: ${error}',
			'fileComparison.invalidFileType' => 'Ungültiger Dateityp.',
			'fileComparison.fileSelected' => ({required Object label, required Object fileName}) => '${label} ausgewählt: ${fileName}',
			'fileComparison.sourceFile' => 'Quelldatei',
			'fileComparison.targetFile' => 'Zieldatei',
			'fileComparison.bilingualFile' => 'Zweisprachige Datei',
			'fileComparison.compareFiles' => 'Dateien vergleichen',
			'fileComparison.compareFile' => 'Datei vergleichen',
			'fileComparison.bilingualMode' => 'Bilingualer Modus',
			'fileComparison.twoFilesMode' => 'Zwei Dateien',
			'fileComparison.processing' => 'Verarbeitung...',
			'fileComparison.remaining' => ({required Object time}) => '${time} verbleibend',
			'fileComparison.comparisonInProgress' => 'Vergleich läuft...',
			'fileComparison.comparisonFailed' => ({required Object error}) => 'Vergleich fehlgeschlagen: ${error}',
			'fileComparison.fileChanged' => ({required Object fileName}) => 'Datei geändert: ${fileName}. Vergleiche neu...',
			'fileComparison.dropFileHere' => 'Datei hier ablegen',
			'fileComparison.dropFileOrBrowse' => 'Datei ablegen oder klicken zum Durchsuchen',
			'fileComparison.fileUpload' => 'Datei hochladen',
			'fileComparison.changeFile' => 'Datei ändern',
			'fileComparison.total' => 'Gesamt',
			'fileComparison.show' => 'Zeigen',
			'fileComparison.showAll' => 'Alle zeigen',
			'fileComparison.noMatches' => ({required Object query}) => 'Keine Treffer für "${query}"',
			'fileComparison.showingEntries' => ({required Object count, required Object total}) => 'Zeige ${count} von ${total} Einträgen',
			'fileComparison.filesIdentical' => 'Dateien sind identisch.',
			'fileComparison.hiddenIdentical' => ({required Object count}) => '${count} identische Einträge ausgeblendet',
			'fileComparison.showIdentical' => 'Identische Einträge anzeigen',
			'fileComparison.hideIdentical' => 'Identische Einträge ausblenden',
			'fileComparison.noDiff' => 'Keine Unterschiede basierend auf Schlüsseln gefunden.',
			'fileComparison.source' => 'Quelle',
			'fileComparison.target' => 'Ziel',
			'fileComparison.value' => 'Wert',
			'fileComparison.readyToCompare' => 'Bereit zum Dateivergleich',
			'fileComparison.readyToCompareDesc' => 'Lokalisierungsdateien oben ablegen oder Durchsuchen-Buttons nutzen\num Dateien für den Vergleich auszuwählen.',
			'fileComparison.recentComparisons' => 'Letzte Vergleiche',
			'fileComparison.bilingualFileLabel' => ({required Object name}) => 'Zweisprachige Datei: ${name}',
			'fileComparison.comparisonLabel' => ({required Object source, required Object target}) => '${source} ↔ ${target}',
			'fileComparison.fileNotExist' => 'Eine oder beide Dateien aus dieser Sitzung existieren nicht mehr.',
			'fileComparison.largeFileTitle' => 'Große Datei erkannt',
			'fileComparison.largeFileContent' => ({required Object count}) => 'Das Vergleichsergebnis enthält ${count} Einträge.\nAlle anzuzeigen könnte zu Leistungsproblemen führen.\n\nMöchten Sie fortfahren?',
			'fileComparison.dontShowAgain' => 'Nicht mehr anzeigen für diese Datei',
			'fileComparison.proceed' => 'Fortfahren',
			'fileComparison.exportReport' => ({required Object format}) => '${format} Bericht speichern',
			'fileComparison.saved' => ({required Object format}) => '${format} gespeichert',
			'fileComparison.saveError' => ({required Object format}) => 'Fehler beim Speichern der ${format} Datei.',
			'fileComparison.saveErrorDetailed' => ({required Object format, required Object error}) => 'Fehler beim Speichern von ${format}: ${error}',
			'fileComparison.watching' => 'Beobachten',
			'fileComparison.watchOff' => 'Beobachten Aus',
			'fileComparison.watchingTooltip' => ({required Object status}) => 'Dateiüberwachung: ${status}\nBei Dateiänderungen automatisch neu vergleichen',
			'fileComparison.aiSettingsNotAvailable' => 'Navigation zu KI-Einstellungen nicht verfügbar',
			'directoryComparison.title' => 'Verzeichnisvergleich',
			'directoryComparison.sourceDirectory' => 'Quellverzeichnis',
			'directoryComparison.targetDirectory' => 'Zielverzeichnis',
			'directoryComparison.sourceSubtitle' => 'Original-/Referenzdateien',
			'directoryComparison.targetSubtitle' => 'Übersetzungs-/Vergleichsdateien',
			'directoryComparison.selectBothDirectories' => 'Bitte wählen Sie sowohl ein Quell- als auch ein Zielverzeichnis aus.',
			'directoryComparison.selectSourceFolder' => 'Quellordner wählen',
			'directoryComparison.selectTargetFolder' => 'Zielordner wählen',
			'directoryComparison.dropFolderHere' => 'Ordner hier ablegen oder durchsuchen...',
			'directoryComparison.folderPath' => 'Ordnerpfad',
			'directoryComparison.readyToCompare' => 'Bereit zum Verzeichnisvergleich',
			'directoryComparison.readyToCompareDesc' => 'Ordner oben ablegen oder Durchsuchen-Buttons nutzen\num Verzeichnisse für den Vergleich auszuwählen.',
			'directoryComparison.nestedFolders' => 'Verschachtelte Ordner',
			'directoryComparison.nestedFoldersTooltip' => 'Vergleicht rekursiv alle Unterverzeichnisse',
			'directoryComparison.fileMatching' => 'Dateizuordnung',
			'directoryComparison.fileMatchingTooltip' => 'Paart Dateien automatisch nach Namen',
			'directoryComparison.bulkExport' => 'Massenexport',
			'directoryComparison.bulkExportTooltip' => 'Alle Vergleichsergebnisse auf einmal exportieren',
			'directoryComparison.notDirectoryComparison' => 'Dies ist kein Verzeichnisvergleich.',
			'directoryComparison.directoriesNotExist' => 'Eines oder beide Verzeichnisse existieren nicht mehr.',
			'directoryComparison.errorOccurred' => 'Ein Fehler ist aufgetreten',
			'directoryComparison.noFilesFound' => 'Keine Dateien in den ausgewählten Verzeichnissen gefunden.',
			'directoryComparison.unmatchedSourceFiles' => 'Nicht zugeordnete Quelldateien',
			'directoryComparison.unmatchedTargetFiles' => 'Nicht zugeordnete Zieldateien',
			'directoryComparison.filePairs' => ({required Object count}) => '${count} Dateipaare',
			'directoryComparison.pairedFiles' => ({required Object count}) => 'Gepaarte Dateien (${count})',
			'directoryComparison.view' => 'Ansicht',
			'directoryComparison.failed' => 'Fehlgeschlagen',
			'directoryComparison.pair' => 'Paaren...',
			'directoryComparison.pairDialogTitle' => ({required Object name}) => 'Paare "${name}" mit:',
			'directoryComparison.discoverFiles' => 'Dateien entdecken',
			'directoryComparison.compareAll' => 'Alle vergleichen',
			'directoryComparison.exportAll' => 'Alle exportieren',
			'directoryComparison.comparisonStarted' => 'Vergleich gestartet...',
			'directoryComparison.discoveringFiles' => 'Entdecke Dateien...',
			'directoryComparison.noResultsToExport' => 'Keine Vergleichsergebnisse zum Exportieren. Führen Sie zuerst "Alle vergleichen" aus.',
			'directoryComparison.selectExportFolder' => 'Exportordner wählen',
			'directoryComparison.createExportFolderError' => ({required Object error}) => 'Fehler beim Erstellen des Exportordners: ${error}',
			'directoryComparison.exportingResults' => 'Ergebnisse werden exportiert',
			'directoryComparison.processingFile' => ({required Object file}) => 'Verarbeite: ${file}',
			'directoryComparison.exportProgress' => ({required Object current, required Object total}) => '${current} von ${total} Dateien exportiert',
			'directoryComparison.exportComplete' => 'Export abgeschlossen',
			'directoryComparison.exportSuccessMessage' => ({required Object count}) => 'Erfolgreich ${count} Vergleichsdateien plus Zusammenfassung exportiert.',
			'directoryComparison.exportFailed' => ({required Object error}) => 'Export fehlgeschlagen: ${error}',
			'directoryComparison.close' => 'Schließen',
			'gitComparison._translatorNote' => 'Git-Begriffe (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) sollten auf Englisch bleiben, um Verwirrung bei Entwicklern zu vermeiden.',
			'gitComparison.title' => 'Repository-Vergleich',
			'gitComparison.repoSelector' => 'Repository erstellen / öffnen',
			'gitComparison.noRepoSelected' => 'Kein Repository ausgewählt',
			'gitComparison.open' => 'Öffnen',
			'gitComparison.refreshCommits' => 'Commits aktualisieren',
			'gitComparison.noCommits' => 'Keine Commits gefunden oder geladen. Wählen Sie einen Branch, um Commits zu laden.',
			'gitComparison.baseCommit' => 'Basis-Commit (Älter)',
			'gitComparison.targetCommit' => 'Ziel-Commit (Neuer)',
			'gitComparison.filterCommitsByBranch' => 'Commits nach Branch filtern',
			'gitComparison.conflictDetection' => 'Konflikterkennung',
			'gitComparison.conflictDetectionTooltip' => 'Merge-Konflikte erkennen und lösen',
			'gitComparison.actions' => 'Aktionen:',
			'gitComparison.checkout' => 'Checkout',
			'gitComparison.merge' => 'Merge',
			'gitComparison.pull' => 'Pull',
			'gitComparison.checkoutBranch' => 'Branch auschecken (Checkout)',
			'gitComparison.mergeBranch' => 'Branch in aktuellen mergen',
			'gitComparison.mergeConfirmation' => ({required Object branch}) => '${branch} mergen?',
			'gitComparison.mergeWarning' => 'Dies wird Änderungen in Ihren aktuellen Arbeits-Branch mergen. Konflikte können auftreten.',
			'gitComparison.selectExportFolder' => 'Exportordner wählen',
			'gitComparison.createExportFolderError' => ({required Object error}) => 'Fehler beim Erstellen des Exportordners: ${error}',
			'gitComparison.exportingFiles' => 'Dateien werden exportiert',
			'gitComparison.processingFile' => ({required Object file}) => 'Verarbeite: ${file}',
			'gitComparison.exportProgress' => ({required Object current, required Object total}) => '${current} von ${total} Dateien exportiert',
			'gitComparison.exportComplete' => 'Export abgeschlossen',
			'gitComparison.exportSuccessMessage' => ({required Object count}) => 'Erfolgreich ${count} Dateien mit vollständigem Inhalt exportiert.',
			'gitComparison.exportDetail' => 'Das Diff jeder Datei wird im Unterordner "files" gespeichert.',
			'gitComparison.diffViewer' => 'Diff Viewer',
			'gitComparison.base' => 'BASE',
			'gitComparison.target' => 'TARGET',
			'gitComparison.noLines' => 'Keine Zeilen anzuzeigen',
			'gitComparison.searchFiles' => 'Dateien suchen...',
			'gitComparison.noFilesMatch' => ({required Object query}) => 'Keine Dateien entsprechen "${query}"',
			'gitComparison.filesCount' => ({required Object count}) => '${count} Dateien',
			'gitComparison.selectBaseFile' => 'Basisdatei wählen',
			'gitComparison.selectTargetFile' => 'Zieldatei wählen',
			'gitComparison.comparisonResults' => 'Vergleichsergebnisse',
			'gitComparison.noChanges' => 'Keine Änderungen zwischen ausgewählten Refs gefunden.',
			'gitComparison.linesAdded' => 'Zeilen hinzugefügt',
			'gitComparison.linesRemoved' => 'Zeilen entfernt',
			'gitComparison.commit' => 'Commit',
			'gitComparison.branch' => 'Branch',
			'gitComparison.noRepositorySelected' => 'Kein Repository ausgewählt',
			'gitComparison.notGitComparison' => 'Kein Git-Vergleich',
			'gitComparison.repositoryNotExist' => 'Repository existiert nicht',
			'gitComparison.mainBranch' => 'main',
			'gitComparison.masterBranch' => 'master',
			'gitComparison.backToControls' => 'Zurück zu Vergleichssteuerungen',
			'advancedComparison.placeholder' => 'Advanced Comparison View - Placeholder',
			'advancedDiff.saveAllChanges' => 'Alle Änderungen speichern?',
			'advancedDiff.saveConfirmation' => ({required Object count}) => 'Dies speichert alle ${count} geänderten Einträge in die Zieldatei. Dies kann nicht rückgängig gemacht werden.',
			'advancedDiff.changesSaved' => 'Änderungen erfolgreich gespeichert.',
			'advancedDiff.csvExported' => 'CSV exportiert',
			'advancedDiff.unsavedChanges' => 'Ungespeicherte Änderungen',
			'advancedDiff.unsavedChangesWarning' => 'Sie haben ungespeicherte Änderungen. Sind Sie sicher, dass Sie diese verwerfen wollen?',
			'advancedDiff.discardChanges' => 'Änderungen verwerfen',
			'advancedDiff.goBack' => 'Zurück',
			'advancedDiff.breadcrumbs' => 'Home  >  Editor',
			'advancedDiff.unsaved' => ({required Object count}) => '${count} ungesichert',
			'advancedDiff.reviewed' => ({required Object count}) => '${count} geprüft',
			'advancedDiff.saveAll' => ({required Object count}) => 'Alle speichern (${count})',
			'advancedDiff.allSaved' => 'Alle gespeichert',
			'advancedDiff.saveAllTooltip' => 'Alle Änderungen speichern (Ctrl+S)',
			'advancedDiff.exportTooltip' => 'Daten exportieren (Ctrl+E)',
			'advancedDiff.aiSuggestion.aiTranslation' => 'KI-Übersetzung',
			'advancedDiff.aiSuggestion.aiRephrase' => 'KI-Umformulierung',
			'advancedDiff.aiSuggestion.key' => ({required Object key}) => 'Schlüssel: ${key}',
			'advancedDiff.aiSuggestion.original' => 'Original:',
			'advancedDiff.aiSuggestion.suggestion' => 'Vorschlag:',
			'advancedDiff.aiSuggestion.confidence' => 'KI-Konfidenz',
			'advancedDiff.aiSuggestion.cancelEdit' => 'Bearbeitung abbrechen',
			'advancedDiff.aiSuggestion.editSuggestion' => 'Vorschlag bearbeiten',
			'advancedDiff.aiSuggestion.alternatives' => 'Alternativen:',
			'advancedDiff.aiSuggestion.accept' => 'Akzeptieren',
			'advancedDiff.aiSuggestion.reject' => 'Ablehnen',
			'advancedDiff.aiSuggestion.stop' => 'Stopp',
			'advancedDiff.detailEdit.title' => ({required Object key}) => 'Bearbeite: ${key}',
			'advancedDiff.detailEdit.sourceLabel' => 'QUELLE (Original)',
			'advancedDiff.detailEdit.targetLabel' => 'ZIEL (Übersetzung)',
			'advancedDiff.detailEdit.translateWithCloud' => 'Mit Cloud übersetzen',
			'advancedDiff.detailEdit.translateWithAi' => 'Mit KI übersetzen',
			'advancedDiff.detailEdit.translating' => 'Übersetze...',
			'advancedDiff.detailEdit.applyAndTm' => 'Anwenden',
			'advancedDiff.detailEdit.entryApplied' => 'Eintrag angewendet & zu TM hinzugefügt',
			'advancedDiff.detailEdit.translationAdded' => 'Übersetzungsvorschlag hinzugefügt.',
			'advancedDiff.detailEdit.aiSuggestionAdded' => 'KI-Vorschlag hinzugefügt.',
			'advancedDiff.table.addedToTM' => 'Zum Übersetzungs-Memory hinzugefügt',
			'advancedDiff.table.markedReviewed' => 'Als geprüft markiert ✓',
			'advancedDiff.table.unmarkedReview' => 'Markierung entfernt',
			'advancedDiff.table.reverted' => 'Auf Quellwert zurückgesetzt',
			'advancedDiff.table.entryDeleted' => 'Eintrag gelöscht',
			'advancedDiff.table.noSourceText' => 'Kein Quelltext zum Übersetzen.',
			'advancedDiff.table.aiTranslationFailed' => ({required Object key}) => 'KI-Übersetzung fehlgeschlagen für "${key}"',
			'advancedDiff.table.noTargetText' => 'Kein Zieltext zum Umformulieren.',
			'advancedDiff.table.aiRephraseFailed' => ({required Object key}) => 'KI-Umformulierung fehlgeschlagen für "${key}"',
			'advancedDiff.table.checkRowsFirst' => 'Zuerst Zeilen mit Checkboxen auswählen',
			'advancedDiff.table.markedRowsReviewed' => ({required Object count}) => '${count} Zeilen als geprüft markiert',
			'advancedDiff.table.revertedRows' => ({required Object count}) => '${count} Zeilen zurückgesetzt',
			'advancedDiff.table.entriesCount' => ({required Object count}) => '${count} Einträge',
			'advancedDiff.table.markSelectedReviewed' => 'Ausgewählte als geprüft markieren',
			'advancedDiff.table.revertSelected' => 'Ausgewählte zurücksetzen',
			'advancedDiff.table.noDifferences' => 'Keine Unterschiede gefunden',
			'advancedDiff.table.adjustFilters' => 'Versuchen Sie, Ihre Filter anzupassen',
			'advancedDiff.table.cloudTranslationApplied' => 'Cloud-Übersetzung angewendet.',
			'advancedDiff.table.aiTranslationApplied' => 'KI-Übersetzung angewendet.',
			'advancedDiff.table.suggestionApplied' => 'Vorschlag angewendet.',
			'advancedDiff.table.aiSuggestionApplied' => 'KI-Vorschlag angewendet.',
			'advancedDiff.table.rephraseApplied' => 'Umformulierung angewendet.',
			'advancedDiff.table.aiRephraseApplied' => 'KI-Umformulierung angewendet.',
			'advancedDiff.table.rephrase' => 'Umformulieren',
			'advancedDiff.table.aiRephrase' => 'KI-Umformulierung',
			'advancedDiff.table.targetClickToEdit' => 'ZIEL (Klicken zum Bearbeiten)',
			'advancedDiff.table.targetClickForDialog' => 'ZIEL (Klicken für Dialog)',
			'advancedDiff.table.emptyClickToEdit' => '(Leer - Klicken zum Bearbeiten)',
			'advancedDiff.table.unmarkReviewed' => 'Markierung entfernen',
			'advancedDiff.table.markReviewed' => 'Als geprüft markieren',
			'advancedDiff.table.revertToSource' => 'Auf Quelle zurücksetzen',
			'advancedDiff.table.translateWithCloud' => 'Mit Cloud übersetzen',
			'advancedDiff.table.translateWithAi' => 'Mit KI übersetzen',
			'advancedDiff.table.rephraseWithAi' => 'Mit KI umformulieren',
			'advancedDiff.table.moreActions' => 'Weitere Aktionen',
			'advancedDiff.table.editDetails' => 'Details bearbeiten',
			'advancedDiff.table.suggestTranslation' => 'Übersetzung vorschlagen',
			'advancedDiff.table.addToTm' => 'Zu TM hinzufügen',
			'advancedDiff.table.deleteEntry' => 'Eintrag löschen',
			'advancedDiff.diffRow.copySource' => 'Quelltext kopieren',
			'advancedDiff.diffRow.actions' => 'Aktionen',
			'advancedDiff.status.added' => 'NEU',
			'advancedDiff.status.missing' => 'FEHLT',
			'advancedDiff.status.changed' => ({required Object percent}) => 'GEÄND ${percent}%',
			'advancedDiff.status.same' => 'GLEICH',
			'advancedDiff.sidebar.widgets' => 'Widgets',
			'advancedDiff.sidebar.searchPlaceholder' => 'Schlüssel & Werte suchen... (Ctrl+F)',
			'advancedDiff.sidebar.fuzzySearchTooltip' => 'Unscharfe Suche (hlerranz)',
			'advancedDiff.sidebar.regexSearchTooltip' => 'Regex Suche',
			'advancedDiff.sidebar.cloudTranslation' => 'Cloud-Übersetzung',
			'advancedDiff.sidebar.aiTranslation' => 'KI-Übersetzung',
			'advancedDiff.sidebar.status' => 'Status',
			'advancedDiff.sidebar.tm' => 'Übersetzungs-Memory',
			'advancedDiff.sidebar.filters' => 'Filter',
			'advancedDiff.sidebar.actions' => 'Aktionen',
			'advancedDiff.sidebar.similarity' => 'Ähnlichkeit',
			'advancedDiff.sidebar.actionsSection.exportMatches' => 'Treffer exportieren',
			'advancedDiff.sidebar.actionsSection.preview' => 'Vorschau',
			'advancedDiff.sidebar.actionsSection.fillFromTmTitle' => 'Aus Übersetzungs-Memory füllen?',
			'advancedDiff.sidebar.actionsSection.fillFromTmContent' => 'Dies versucht, leere Zielwerte mit Treffern aus dem Übersetzungs-Memory zu füllen. Bestehende Werte werden NICHT überschrieben.',
			'advancedDiff.sidebar.actionsSection.fill' => 'Füllen',
			'advancedDiff.sidebar.actionsSection.fillFromMemory' => 'Aus Speicher füllen',
			'advancedDiff.sidebar.actionsSection.filledFromTm' => ({required Object count}) => '${count} Elemente aus Übersetzungs-Memory gefüllt.',
			'advancedDiff.sidebar.aiSection.infoCloud' => 'Nutzt Cloud-Übersetzung, um leere Zielwerte aus der Quelle zu übersetzen.',
			'advancedDiff.sidebar.aiSection.infoAi' => 'Nutzt KI, um leere Zielwerte aus der Quelle zu übersetzen.',
			'advancedDiff.sidebar.aiSection.translationSettings' => 'Übersetzungseinstellungen',
			'advancedDiff.sidebar.aiSection.aiSettings' => 'KI-Einstellungen',
			'advancedDiff.sidebar.aiSection.source' => 'Quelle',
			'advancedDiff.sidebar.aiSection.target' => 'Ziel',
			'advancedDiff.sidebar.aiSection.translatingProgress' => ({required Object percent}) => 'Übersetze... ${percent}%',
			'advancedDiff.sidebar.aiSection.translating' => 'Übersetze...',
			'advancedDiff.sidebar.aiSection.translateAllMissing' => 'Alle fehlenden übersetzen',
			'advancedDiff.sidebar.aiSection.translateAllTitle' => 'Alle fehlenden übersetzen?',
			'advancedDiff.sidebar.aiSection.translateAllContent' => ({required Object service, required Object source, required Object target}) => 'Dies wird ${service} nutzen, um alle Einträge mit leeren Zielwerten von ${source} nach ${target} zu übersetzen.\n\nSie können jeden Vorschlag prüfen oder alle auf einmal anwenden.',
			'advancedDiff.sidebar.aiSection.translateAll' => 'Alle übersetzen',
			'advancedDiff.sidebar.aiSection.reviewEach' => 'Einzeln prüfen',
			'advancedDiff.sidebar.aiSection.cloudTranslated' => ({required Object count}) => '${count} Einträge mit Cloud-Übersetzung übersetzt.',
			'advancedDiff.sidebar.aiSection.aiTranslated' => ({required Object count}) => '${count} Einträge mit KI übersetzt.',
			'advancedDiff.sidebar.aiSection.aiTranslateFailed' => 'KI-Übersetzung für alle fehlgeschlagen',
			'advancedDiff.sidebar.aiSection.noMissingEntries' => 'Keine fehlenden Einträge zu übersetzen.',
			'advancedDiff.sidebar.aiSection.skip' => 'Überspringen',
			'advancedDiff.sidebar.aiSection.stop' => 'Stopp',
			'advancedDiff.sidebar.aiSection.cloudApplied' => ({required Object count}) => '${count} Vorschläge angewendet.',
			'advancedDiff.sidebar.aiSection.aiApplied' => ({required Object count}) => '${count} KI-Vorschläge angewendet.',
			'advancedDiff.sidebar.tmSection.enableTmFill' => 'TM-Füllung aktivieren',
			'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' => 'Auto-Anwenden über Minimum',
			'advancedDiff.sidebar.tmSection.matchSettings' => 'Treffer-Einstellungen',
			'advancedDiff.sidebar.tmSection.minMatch' => 'Min. Treffer:',
			'advancedDiff.sidebar.tmSection.limit' => 'Limit:',
			'advancedDiff.sidebar.tmSection.exact' => 'Exakt',
			'advancedDiff.sidebar.filtersSection.viewFilters' => 'Ansichtsfilter',
			'advancedDiff.sidebar.filtersSection.showAll' => 'Alle zeigen',
			'advancedDiff.sidebar.filtersSection.added' => 'Hinzugefügt',
			'advancedDiff.sidebar.filtersSection.removed' => 'Entfernt',
			'advancedDiff.sidebar.filtersSection.modified' => 'Geändert',
			'advancedDiff.sidebar.filtersSection.actionScope' => 'Aktionsbereich',
			'advancedDiff.sidebar.filtersSection.applyToAdded' => 'Auf Hinzugefügte anwenden',
			'advancedDiff.sidebar.filtersSection.applyToModified' => 'Auf Geänderte anwenden',
			'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' => 'Nur leere Ziele füllen',
			'advancedDiff.sidebar.filtersSection.limitToVisible' => 'Auf sichtbare beschränken',
			'advancedDiff.sidebar.filtersSection.editMode' => 'Bearbeitungsmodus',
			'advancedDiff.sidebar.filtersSection.dialog' => 'Dialog',
			'advancedDiff.sidebar.filtersSection.inline' => 'Inline',
			'advancedDiff.sidebar.similaritySection.currentFilter' => 'Aktueller Filter:',
			'advancedDiff.sidebar.similaritySection.any' => 'ALLE',
			'advancedDiff.sidebar.similaritySection.high' => 'HOCH',
			'advancedDiff.sidebar.similaritySection.medium' => 'MITTEL',
			'advancedDiff.sidebar.similaritySection.low' => 'NIEDRIG',
			'advancedDiff.sidebar.statusSection.total' => ({required Object count}) => '${count} gesamt',
			'advancedDiff.sidebar.statusSection.extra' => ({required Object count}) => '${count} extra',
			'advancedDiff.sidebar.statusSection.missing' => ({required Object count}) => '${count} fehlend',
			'advancedDiff.sidebar.statusSection.changed' => ({required Object count}) => '${count} geändert',
			'issueDetails.title' => 'Problem Details',
			'issueDetails.showingIssues' => ({required Object count, required Object total}) => 'Zeige ${count} von ${total} Problemen',
			'issueDetails.searchPlaceholder' => 'Suchen nach Schlüssel, Text oder Fehler...',
			'issueDetails.noDetails' => 'Keine Details verfügbar.',
			'issueDetails.noMatches' => 'Keine Treffer gefunden.',
			'issueDetails.showMore' => 'Mehr anzeigen',
			'issueDetails.copyItems' => ({required Object count}) => '${count} Elemente kopieren',
			'issueDetails.close' => 'Schließen',
			'issueDetails.copied' => 'In Zwischenablage kopiert',
			'issueDetails.copiedCount' => ({required Object count}) => '${count} Elemente kopiert',
			'issueDetails.duplicateValue.label' => 'WIEDERHOLTE ÜBERSETZUNG',
			'issueDetails.duplicateValue.warning' => 'Unterschiedliche Quelltexte nutzen dieselbe Übersetzung. Kontext prüfen.',
			'issueDetails.duplicateValue.affectedKeys' => ({required Object count}) => 'BETROFFENE SCHLÜSSEL (${count})',
			'issueDetails.duplicateValue.identicalSources' => 'Identische Quellen',
			'issueDetails.duplicateValue.moreKeys' => ({required Object count}) => '+${count} weitere Schlüssel',
			'issueDetails.lengthOutlier.source' => 'QUELLE',
			'issueDetails.lengthOutlier.translation' => 'ÜBERSETZUNG',
			'issueDetails.lengthOutlier.chars' => ({required Object count}) => '${count} Zeichen',
			'issueDetails.standard.key' => 'SCHLÜSSEL',
			'issueDetails.standard.sourceText' => 'QUELLTEXT',
			'issueDetails.standard.translation' => 'ÜBERSETZUNG',
			'issueDetails.standard.errorDetails' => 'FEHLERDETAILS',
			'issueDetails.standard.note' => 'HINWEIS',
			'issueDetails.review' => 'Prüfen',
			'issueDetails.types.duplicateValue' => 'Doppelte Werte',
			'issueDetails.types.lengthOutlier' => 'Längenabweichung',
			'issueDetails.types.placeholderMismatch' => 'Defekte Platzhalter',
			'issueDetails.notes.placeholderMismatch' => 'Marker wie {name} sollten mit der Quelle übereinstimmen.',
			'issueDetails.notes.lengthOutlier' => 'Große Längenänderungen können die Anzeige beeinflussen.',
			'issueDetails.notes.duplicateValue' => 'Gleiche Übersetzung wird für verschiedene Schlüssel verwendet.',
			'issueDetails.fallbacks.multipleSources' => 'Mehrere Quelltexte',
			'issueDetails.fallbacks.sourceNotAvailable' => 'Quelltext nicht verfügbar',
			'issueDetails.fallbacks.sharedTranslationNotAvailable' => 'Geteilte Übersetzung nicht verfügbar',
			'issueDetails.fallbacks.translationNotAvailable' => 'Übersetzung nicht verfügbar',
			'importReview.title' => 'Projektimport prüfen',
			'importReview.projectName' => 'Projektname',
			'importReview.created' => 'Erstellt',
			'importReview.historyItems' => 'Verlaufselemente',
			'importReview.customSettingsTitle' => 'Benutzerdefinierte Einstellungen erkannt',
			'importReview.customSettingsWarning' => 'Dieses Projekt enthält benutzerdefinierte Einstellungen, die Ihre Standards überschreiben, solange dieses Projekt geöffnet ist.',
			'importReview.standardSettings' => 'Dieses Projekt verwendet globale Standardeinstellungen.',
			'importReview.cancelImport' => 'Import abbrechen',
			'importReview.trustOpen' => 'Vertrauen & Projekt öffnen',
			'historyView.title' => 'Vergleichsverlauf',
			'historyView.clearAll' => 'Gesamten Verlauf löschen',
			'historyView.searchPlaceholder' => 'Nach Dateinamen suchen...',
			'historyView.sortBy' => 'Sortieren nach',
			'historyView.sortDate' => 'Datum',
			'historyView.sortSource' => 'Quelldatei',
			'historyView.sortTarget' => 'Zieldatei',
			'historyView.showCurrentProject' => 'Zeige: Aktuelles Projekt',
			'historyView.showAllHistory' => 'Zeige: Gesamten Verlauf',
			'historyView.groupByFolder' => 'Nach Ordner gruppieren',
			'historyView.disableGrouping' => 'Gruppierung deaktivieren',
			'historyView.filterAll' => 'Alle',
			'historyView.filterFiles' => 'Dateien',
			'historyView.filterDirectories' => 'Verzeichnisse',
			'historyView.filterGit' => 'Git',
			'historyView.noHistory' => 'Noch kein Vergleichsverlauf',
			'historyView.historyDescription' => 'Ihre Dateivergleiche erscheinen hier',
			'historyView.noResults' => 'Keine Ergebnisse gefunden',
			'historyView.adjustSearch' => 'Versuchen Sie, Ihre Suche anzupassen',
			'historyView.clearConfirmationTitle' => 'Gesamten Verlauf löschen?',
			'historyView.clearConfirmationContent' => 'Dies löscht den gesamten Vergleichsverlauf dauerhaft. Dies kann nicht rückgängig gemacht werden.',
			'historyView.clearAction' => 'Alles löschen',
			'historyView.deletedMessage' => 'Verlaufselement gelöscht',
			'historyView.undo' => 'Rückgängig',
			'historyView.viewDetails' => 'Details anzeigen',
			'historyView.delete' => 'Löschen',
			'historyView.openLocation' => 'Dateipfad öffnen',
			'historyView.bilingual' => 'Bilingual',
			'historyView.filePair' => 'Dateipaar',
			'historyView.directory' => 'Verzeichnis',
			'historyView.git' => 'Git',
			'historyView.repo' => 'Repo',
			'historyView.sourceDir' => 'Quell-Verz.',
			'historyView.targetDir' => 'Ziel-Verz.',
			'historyView.source' => 'Quelle',
			'historyView.target' => 'Ziel',
			'historyView.noChanges' => 'Keine Änderungen erkannt',
			'historyView.added' => 'Hinzugefügt',
			'historyView.removed' => 'Entfernt',
			'historyView.modified' => 'Geändert',
			'historyView.same' => 'Gleich',
			'historyView.total' => 'Gesamt',
			'historyView.currentProject' => 'Aktuelles Projekt',
			'historyView.unassigned' => 'Nicht zugewiesen',
			'historyView.project' => 'Projekt',
			'compare.title' => 'Dateien vergleichen',
			'compare.sourceFile' => 'Quelldatei',
			'compare.targetFile' => 'Zieldatei',
			'compare.sourceFolder' => 'Quellordner',
			'compare.targetFolder' => 'Zielordner',
			'compare.dropFilesHint' => 'Lokalisierungsdateien hier ablegen oder Durchsuchen-Buttons nutzen, um Dateien für den Vergleich auszuwählen.',
			'compare.selectSourceFile' => 'Quelldatei wählen',
			'compare.selectTargetFile' => 'Zieldatei wählen',
			'compare.startComparison' => 'Vergleich starten',
			'compare.comparing' => 'Vergleiche...',
			'compare.comparisonComplete' => 'Vergleich abgeschlossen',
			'compare.noChanges' => 'Keine Änderungen erkannt',
			'compare.filesIdentical' => 'Dateien sind identisch',
			'compare.changesFound' => ({required Object count}) => '${count} Änderungen gefunden',
			'compare.tabs.files' => 'Dateien',
			'compare.tabs.directories' => 'Verzeichnisse',
			'compare.tabs.git' => 'Git',
			'compare.fileTypes.json' => 'JSON Lokalisierungsdateien (i18next, Flutter, etc.)',
			'compare.fileTypes.yaml' => 'YAML Lokalisierungsdateien (Rails, Flutter)',
			'compare.fileTypes.xml' => 'XML Lokalisierungsdateien (Android, .NET)',
			'compare.fileTypes.properties' => 'Properties Dateien (Java)',
			'compare.fileTypes.resx' => 'RESX Dateien (.NET)',
			_ => null,
		} ?? switch (path) {
			'compare.fileTypes.xliff' => 'XLIFF Dateien',
			'history.title' => 'Verlauf',
			'history.recentComparisons' => 'Letzte Vergleiche',
			'history.noHistory' => 'Noch kein Vergleichsverlauf',
			'history.noHistoryDescription' => 'Ihr Vergleichsverlauf wird hier erscheinen',
			'history.clearHistory' => 'Verlauf löschen',
			'history.clearHistoryConfirm' => 'Sind Sie sicher, dass Sie den gesamten Verlauf löschen wollen?',
			'history.deleteEntry' => 'Eintrag löschen',
			'history.openComparison' => 'Vergleich öffnen',
			'history.timeAgo.justNow' => 'gerade eben',
			'history.timeAgo.secondsAgo' => ({required Object count}) => 'vor ${count} Sekunden',
			'history.timeAgo.oneMinuteAgo' => 'vor 1 Minute',
			'history.timeAgo.minutesAgo' => ({required Object count}) => 'vor ${count} Minuten',
			'history.timeAgo.oneHourAgo' => 'vor 1 Stunde',
			'history.timeAgo.hoursAgo' => ({required Object count}) => 'vor ${count} Stunden',
			'history.timeAgo.yesterday' => 'gestern',
			'history.timeAgo.daysAgo' => ({required Object count}) => 'vor ${count} Tagen',
			'history.timeAgo.oneWeekAgo' => 'vor 1 Woche',
			'history.timeAgo.weeksAgo' => ({required Object count}) => 'vor ${count} Wochen',
			'history.timeAgo.oneMonthAgo' => 'vor 1 Monat',
			'history.timeAgo.monthsAgo' => ({required Object count}) => 'vor ${count} Monaten',
			'history.timeAgo.oneYearAgo' => 'vor 1 Jahr',
			'history.timeAgo.yearsAgo' => ({required Object count}) => 'vor ${count} Jahren',
			'history.timeAgo.inTheFuture' => 'in der Zukunft',
			'projects.title' => 'Projekte',
			'projects.createProject' => 'Projekt erstellen',
			'projects.importProject' => 'Projekt importieren',
			'projects.noProjects' => 'Noch keine Projekte',
			'projects.noProjectsDescription' => 'Erstellen Sie ein Projekt, um Ihre Lokalisierungsdateien zu organisieren',
			'projects.projectName' => 'Projektname',
			'projects.projectPath' => 'Projektpfad',
			'projects.lastOpened' => 'Zuletzt geöffnet',
			'projects.openProject' => 'Projekt öffnen',
			'projects.closeProject' => 'Projekt schließen',
			'projects.deleteProject' => 'Projekt löschen',
			'projects.deleteProjectConfirm' => 'Sind Sie sicher, dass Sie dieses Projekt löschen wollen?',
			'projects.exportProject' => 'Projekt exportieren',
			'projects.exportDescription' => 'Erstellen Sie eine portable ZIP-Datei mit Quelldateien, Konfiguration und Verlauf.',
			'projects.exporting' => 'Exportiere Projekt...',
			'projects.exportSuccess' => 'Projekt exportiert',
			'projects.exportError' => ({required Object error}) => 'Export fehlgeschlagen: ${error}',
			'projects.createNewProject' => 'Neues Projekt erstellen',
			'projects.openExistingProject' => 'Vorhandenes Projekt öffnen',
			'projects.importProjectZip' => 'Projekt-ZIP importieren',
			'projects.projectResources' => 'Projektressourcen',
			'projects.recentProjects' => 'Letzte Projekte',
			'projects.noRecentProjects' => 'Keine letzten Projekte',
			'projects.selectProjectZip' => 'Projekt-ZIP wählen',
			'projects.selectDestination' => 'Zielordner für Import wählen',
			'projects.importing' => 'Importiere Projekt...',
			'projects.importSuccess' => 'Projekt erfolgreich importiert',
			'projects.importFailed' => ({required Object error}) => 'Import fehlgeschlagen: ${error}',
			'projects.importingFiles' => 'Importiere Dateien...',
			'projects.noSupportedFiles' => 'Keine unterstützten Dateien abgelegt.',
			'projects.stats.empty' => 'Leeres Projekt',
			'projects.stats.files' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '1 Übersetzungsdatei', other: '${count} Übersetzungsdateien', ), 
			'projects.stats.languages' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '1 Sprache', other: '${count} Sprachen', ), 
			'projects.openProjectFirst' => 'Öffnen Sie zuerst ein Projekt, um dessen Ressourcen zu verwalten.',
			'projects.removeFromRecent' => 'Aus "Zuletzt" entfernen',
			'projects.selection.selectFolder' => 'Projektordner wählen',
			'projects.selection.selectArchive' => 'Projektarchiv wählen',
			'projects.selection.openProject' => 'Projekt öffnen',
			'projects.selection.browseFolder' => 'Ordner durchsuchen...',
			'projects.selection.createNew' => 'Neu erstellen',
			'projects.selection.importFromZip' => 'Aus ZIP importieren...',
			'projects.createDialog.title' => 'Projekt erstellen',
			'projects.createDialog.description' => 'Ein Projekt erlaubt es Ihnen, benutzerdefinierte Einstellungen für einen bestimmten Ordner zu speichern. Ein ".localizer" Ordner wird erstellt, um Ihre Projektkonfiguration zu speichern.',
			'projects.createDialog.folderLabel' => 'Projektordner',
			'projects.createDialog.folderHint' => 'Klicken um Ordner zu wählen...',
			'projects.createDialog.nameLabel' => 'Projektname',
			'projects.createDialog.nameHint' => 'z.B., Meine App Übersetzungen',
			'projects.createDialog.selectFolderWarning' => 'Bitte wählen Sie einen Projektordner.',
			'projects.createDialog.enterNameError' => 'Bitte geben Sie einen Projektnamen ein',
			'projects.createDialog.nameLengthError' => 'Name muss mindestens 2 Zeichen lang sein',
			'projects.createDialog.success' => ({required Object name}) => 'Projekt "${name}" erfolgreich erstellt!',
			'projects.createDialog.failure' => 'Fehler beim Erstellen des Projekts.',
			'projects.createDialog.creating' => 'Erstelle...',
			'projects.createDialog.createAction' => 'Projekt erstellen',
			'projects.indicator.tooltipNoProject' => 'Erstellen Sie ein Projekt, um benutzerdefinierte Einstellungen für einen Ordner zu speichern',
			'projects.indicator.tooltipProject' => ({required Object name}) => 'Projekt: ${name}\nKlicken für Optionen',
			'projects.indicator.location' => 'Ort',
			'projects.indicator.created' => 'Erstellt',
			'projects.indicator.switchProject' => 'Projekt wechseln',
			'projects.indicator.done' => 'Fertig',
			'projects.glossary.title' => 'Projekt-Glossar',
			'projects.glossary.description' => 'Definieren Sie Begriffe, die konsistent behandelt oder nie übersetzt werden sollen.',
			'projects.glossary.noTerms' => 'Noch keine Glossarbegriffe.',
			'projects.glossary.noTermsDesc' => 'Fügen Sie Begriffe hinzu, die über Übersetzungen hinweg konsistent bleiben sollen,\noder markieren Sie Markennamen, die nie übersetzt werden sollen.',
			'projects.glossary.doNotTranslate' => 'Nicht übersetzen',
			'projects.glossary.noSpecificTranslation' => 'Keine spezifische Übersetzung',
			'projects.glossary.addTerm' => 'Begriff hinzufügen',
			'projects.glossary.editTerm' => 'Begriff bearbeiten',
			'projects.glossary.term' => 'Begriff',
			'projects.glossary.termHint' => 'z.B., Markenname, Fachbegriff',
			'projects.glossary.definition' => 'Definition (Optional)',
			'projects.glossary.definitionHint' => 'Kontext für den Übersetzer',
			'projects.glossary.doNotTranslateLabel' => 'Nicht übersetzen',
			'projects.glossary.doNotTranslateDesc' => 'Begriff im Ziel exakt beibehalten',
			'projects.glossary.preferredTranslation' => 'Bevorzugte Übersetzung',
			'projects.glossary.caseSensitive' => 'Groß-/Kleinschreibung beachten',
			'projects.conflicts.missingApiKeyTitle' => ({required Object service}) => 'Fehlender API-Schlüssel für ${service}',
			'projects.conflicts.missingApiKeyMessage' => ({required Object service}) => 'Dieses Projekt nutzt ${service}, aber kein API-Schlüssel ist konfiguriert. Fügen Sie Ihren API-Schlüssel in Einstellungen > KI-Dienste hinzu, oder die App verwendet den globalen Standard.',
			'projects.conflicts.dismiss' => 'Verwerfen',
			'projects.tm.title' => 'Übersetzungs-Memories',
			'projects.tm.description' => 'Verwalten Sie Übersetzungs-Memory-Quellen für dieses Projekt.',
			'projects.tm.globalTm' => 'Globales Übersetzungs-Memory',
			'projects.tm.globalTmDescription' => 'Das geteilte Übersetzungs-Memory aus Ihren App-Einstellungen verwenden',
			'projects.tm.linkedFiles' => 'Verknüpfte Dateien (Projektspezifisch)',
			'projects.tm.noLinkedFiles' => 'Keine projektspezifischen Dateien verknüpft.',
			'projects.tm.addTmFile' => 'TM-Datei hinzufügen',
			'projects.tm.useGlobalTm' => 'Globales TM verwenden',
			'projects.tm.selectTm' => 'Übersetzungs-Memory wählen',
			'projects.tm.globalTmEnabled' => 'Globales Übersetzungs-Memory aktiviert',
			'diff.added' => 'Hinzugefügt',
			'diff.removed' => 'Entfernt',
			'diff.modified' => 'Geändert',
			'diff.unchanged' => 'Unverändert',
			'diff.missing' => 'Fehlt',
			'diff.extra' => 'Extra',
			'diff.sourceValue' => 'Quellwert',
			'diff.targetValue' => 'Zielwert',
			'diff.key' => 'Schlüssel',
			'diff.status' => 'Status',
			'diff.actions' => 'Aktionen',
			'diff.copyToTarget' => 'Kopieren nach Ziel',
			'diff.acceptChange' => 'Änderung akzeptieren',
			'diff.rejectChange' => 'Änderung ablehnen',
			'diff.viewDetails' => 'Details anzeigen',
			'git.title' => 'Git-Vergleich',
			'git.selectRepository' => 'Repository wählen',
			'git.selectBranch' => 'Branch wählen',
			'git.selectCommit' => 'Commit wählen',
			'git.compareBranches' => 'Branches vergleichen',
			'git.compareCommits' => 'Commits vergleichen',
			'git.baseBranch' => 'Basis-Branch',
			'git.compareBranch' => 'Vergleichs-Branch',
			'git.noRepositories' => 'Keine Git-Repositories gefunden',
			'git.noRepositoriesDescription' => 'Öffnen Sie einen Ordner mit einem Git-Repository',
			'git.filesChanged' => ({required Object count}) => '${count} Dateien geändert',
			'git.additions' => ({required Object count}) => '${count} Ergänzungen',
			'git.deletions' => ({required Object count}) => '${count} Löschungen',
			'git.conflicts.title' => 'Merge-Konflikte erkannt',
			'git.conflicts.description' => 'Sie müssen diese Konflikte lösen, bevor Sie fortfahren können.',
			'git.conflicts.abortMergeTitle' => 'Merge abbrechen?',
			'git.conflicts.abortMergeContent' => 'Dies macht alle Merge-Änderungen rückgängig und kehrt zum Zustand vor dem Merge zurück. Dies kann nicht rückgängig gemacht werden.',
			'git.conflicts.abortMergeAction' => 'Merge abbrechen',
			'git.conflicts.stagingFile' => ({required Object file}) => 'Stage ${file} für Commit...',
			'git.conflicts.conflictedFilesCount' => ({required Object count}) => 'Konfliktdateien (${count})',
			'git.conflicts.selectFileToResolve' => 'Wählen Sie eine Datei zu lösen',
			'git.conflicts.resolvingFile' => ({required Object file}) => 'Löse: ${file}',
			'git.conflicts.keepAllOurs' => 'Alle \'Ours\' behalten',
			'git.conflicts.acceptAllTheirs' => 'Alle \'Theirs\' akzeptieren',
			'git.conflicts.allResolved' => 'Alle Konflikte in dieser Datei wurden gelöst!',
			'git.conflicts.markResolved' => 'Als gelöst markieren',
			'git.conflicts.stageForCommit' => 'Dies wird die Datei für den Commit stagen.',
			'git.conflicts.conflictIndex' => ({required Object index}) => 'Konflikt #${index}',
			'git.conflicts.ours' => 'OURS (Aktuell)',
			'git.conflicts.theirs' => 'THEIRS (Eingehend)',
			'git.conflicts.keepOurs' => 'Ours behalten',
			'git.conflicts.acceptTheirs' => 'Theirs akzeptieren',
			'git.conflicts.empty' => '(Leer)',
			'quality._translatorNote' => 'API und Metrik-Begriffe (Requests, Tokens, Characters, Prompt, Completion, Export) sollten auf Englisch bleiben, um Konsistenz mit Industrietermini zu wahren.',
			'quality.title' => 'Qualitäts-Dashboard',
			'quality.overallScore' => 'Gesamtpunktzahl',
			'quality.issues' => 'Probleme',
			'quality.warnings' => 'Warnungen',
			'quality.suggestions' => 'Vorschläge',
			'quality.placeholderMismatch' => 'Platzhalter-Fehler',
			'quality.placeholderMismatchDescription' => 'Platzhalter wie {name} stimmen nicht überein',
			'quality.lengthOutlier' => 'Längenabweichung',
			'quality.lengthOutlierDescription' => 'Übersetzungslänge weicht stark ab',
			'quality.duplicateValue' => 'Doppelter Wert',
			'quality.duplicateValueDescription' => 'Gleiche Übersetzung für mehrere Schlüssel',
			'quality.missingTranslation' => 'Fehlende Übersetzung',
			'quality.missingTranslationDescription' => 'Übersetzung fehlt für diesen Schlüssel',
			'quality.loading' => 'Lade Dashboard...',
			'quality.errorLoading' => 'Wir konnten Ihren Verlauf nicht laden. Versuchen Sie es erneut.',
			'quality.emptyState' => 'Führen Sie einen Vergleich aus, um Ihr Dashboard zu sehen.',
			'quality.refresh' => 'Aktualisieren',
			'quality.buildingInsights' => 'Erstelle Einblicke...',
			'quality.crunchingNumbers' => 'Zahlen werden verarbeitet...',
			'quality.errorBuilding' => 'Wir konnten das Dashboard nicht erstellen. Versuchen Sie es erneut.',
			'quality.noUsableData' => 'Noch keine brauchbaren Daten gefunden.',
			'quality.languages' => 'Sprachen',
			'quality.averageCoverage' => 'Durchschnittliche Abdeckung',
			'quality.potentialIssues' => 'Potenzielle Probleme',
			'quality.translationCoverage' => 'Übersetzungsabdeckung',
			'quality.entriesTranslated' => ({required Object translated, required Object total}) => '${translated} von ${total} Einträgen übersetzt',
			'quality.wordsAddedOverTime' => 'Hinzugefügte Wörter im Zeitverlauf',
			'quality.completionVsScope' => 'Fertigstellung vs. Umfang',
			'quality.scopeVsProgress' => 'Umfang vs. Fortschritt',
			'quality.coveragePercent' => 'Abdeckung %',
			'quality.wordsAdded' => 'Hinzugefügte Wörter',
			'quality.words' => 'Wörter',
			'quality.coverage' => 'Abdeckung',
			'quality.scope' => 'Umfang',
			'quality.latest' => 'Neueste',
			'quality.added' => 'Hinzugefügt',
			'quality.change' => 'Änderung',
			'quality.totalScope' => 'Gesamtumfang',
			'quality.scopeGrowth' => 'Umfangswachstum',
			'quality.range' => 'Bereich',
			'quality.aiUsage' => 'KI & Übersetzungsnutzung',
			'quality.lastUsed' => ({required Object date}) => 'Zuletzt genutzt ${date}',
			'quality.noIssuesFound' => 'Keine Probleme in den letzten Vergleichen gefunden.',
			'quality.placeholderMismatches' => 'Platzhalter-Fehler',
			'quality.placeholderMismatchesDesc' => 'Marker wie {name} stimmen nicht überein.',
			'quality.lengthOutliers' => 'Sehr kurze oder lange Übersetzungen',
			'quality.lengthOutliersDesc' => 'Länge sieht ungewöhnlich im Vergleich zur Quelle aus.',
			'quality.duplicateValues' => 'Doppelte Werte',
			'quality.duplicateValuesDesc' => 'Die gleiche Übersetzung wird mehrfach verwendet.',
			'quality.placeholderDialogTitle' => 'Platzhalter-Fehler',
			'quality.placeholderDialogDesc' => 'Diese Übersetzungen haben andere Platzhalter ({name}) als die Quelle.',
			'quality.lengthDialogTitle' => 'Längenabweichungen',
			'quality.lengthDialogDesc' => 'Diese Übersetzungen sind deutlich kürzer oder länger als die Quelle.',
			'quality.duplicateDialogTitle' => 'Doppelte Werte',
			'quality.duplicateDialogDesc' => 'Diese Übersetzungen erscheinen mehrfach.',
			'quality.duplicateSample' => ({required Object value}) => 'Duplikat: "${value}"',
			'quality.exportError' => 'Konnte Bericht nicht erstellen. Bitte versuchen Sie es erneut.',
			'quality.noDataToExport' => 'Keine Daten zum Exportieren',
			'quality.exportFailed' => 'Export fehlgeschlagen',
			'quality.exportDialogTitle' => 'Qualitätsbericht exportieren',
			'quality.reportSaved' => 'Bericht gespeichert',
			'quality.export' => 'Exportieren',
			'quality.requests' => 'Anfragen',
			'quality.tokens' => 'Tokens',
			'quality.characters' => 'Zeichen',
			'quality.estCost' => 'Gesch. Kosten',
			'quality.prompt' => 'Prompt',
			'quality.completion' => 'Completion',
			'quality.showingCurrentProject' => 'Zeige: Aktuelles Projekt',
			'quality.showingAllHistory' => 'Zeige: Gesamten Verlauf',
			'quality.filesSkipped' => 'Einige Dateien wurden übersprungen, da sie nicht gefunden wurden.',
			'errors.genericError' => 'Ein Fehler ist aufgetreten',
			'errors.fileNotFound' => 'Datei nicht gefunden',
			'errors.invalidFormat' => 'Ungültiges Dateiformat',
			'errors.parseError' => 'Fehler beim Parsen der Datei',
			'errors.networkError' => 'Netzwerkfehler. Bitte überprüfen Sie Ihre Verbindung.',
			'errors.permissionDenied' => 'Zugriff verweigert',
			'errors.unknownError' => 'Ein unbekannter Fehler ist aufgetreten',
			'wizards.firstRun.welcome' => 'Willkommen bei Localizer',
			'wizards.firstRun.description' => 'Vergleichen Sie Ihre Lokalisierungsdateien in Sekunden.',
			'wizards.firstRun.sourceFile' => 'Quelldatei',
			'wizards.firstRun.targetFile' => 'Zieldatei',
			'wizards.firstRun.compareNow' => 'Jetzt vergleichen',
			'wizards.firstRun.trySample' => 'Mit Beispieldaten testen',
			'wizards.firstRun.skip' => 'Setup überspringen',
			'wizards.firstRun.browse' => 'Klicken zum Durchsuchen',
			'wizards.firstRun.error' => ({required Object error}) => 'Fehler beim Laden der Beispieldaten: ${error}',
			'dialogs.addIgnorePattern.title' => 'Ignorier-Muster hinzufügen',
			'dialogs.addIgnorePattern.patternLabel' => 'Muster (Regex)',
			'dialogs.addIgnorePattern.hint' => 'z.B., ^temp_.*',
			'dialogs.addIgnorePattern.invalid' => 'Ungültiges Regex-Muster',
			'dialogs.addIgnorePattern.testStringLabel' => 'Test-String',
			'dialogs.addIgnorePattern.testHint' => 'Schlüssel zum Testen eingeben',
			'dialogs.addIgnorePattern.match' => '✓ Muster passt auf Test-String',
			'dialogs.addIgnorePattern.noMatch' => '✗ Muster passt nicht',
			'dialogs.addIgnorePattern.add' => 'Hinzufügen',
			'dialogs.addIgnorePattern.cancel' => 'Abbrechen',
			'dialogs.diffViewer.title' => 'Diff Viewer',
			'dialogs.diffViewer.originalFile' => 'Original/Referenzdatei',
			'dialogs.diffViewer.translationFile' => 'Übersetzungs/Vergleichsdatei',
			'dialogs.diffViewer.base' => 'BASIS',
			'dialogs.diffViewer.target' => 'ZIEL',
			'dialogs.diffViewer.added' => 'Hinzugefügt',
			'dialogs.diffViewer.removed' => 'Entfernt',
			'dialogs.diffViewer.modified' => 'Geändert',
			'dialogs.diffViewer.noMatches' => 'Keine Einträge entsprechen den aktuellen Filtern',
			'dialogs.diffViewer.clickToggle' => 'Klicken Sie auf die Badges oben, um Filter umzuschalten',
			'grid.columns.key' => 'Schlüssel',
			'grid.columns.source' => 'Quelle',
			'grid.columns.status' => 'Status',
			'grid.columns.actions' => 'Aktionen',
			'tutorial.skipTutorial' => 'TUTORIAL ÜBERSPRINGEN',
			'tutorial.finishMessage' => 'Alles fertig! Tippen Sie irgendwo, um abzuschließen.',
			'tutorial.next' => 'Weiter',
			'tutorial.loadSampleData' => 'Beispieldaten laden',
			'tutorial.browseSourceFile' => 'Quelldatei suchen',
			'tutorial.browseTargetFile' => 'Zieldatei suchen',
			'tutorial.compareFiles' => 'Dateien vergleichen',
			'tutorial.hintPhase2' => 'Nächstes: Filter, Suche, Erweiterte Ansicht und Export.',
			'tutorial.steps.importSource.title' => '1. Quelldatei importieren',
			'tutorial.steps.importSource.description' => 'Nutzen Sie den Button unten oder Drag & Drop auf den markierten Bereich.',
			'tutorial.steps.importTarget.title' => '2. Zieldatei importieren',
			'tutorial.steps.importTarget.description' => 'Nutzen Sie den Button unten oder Drag & Drop auf den markierten Bereich.',
			'tutorial.steps.compare.title' => '3. Dateien vergleichen',
			'tutorial.steps.compare.description' => 'Tippen Sie den Button unten, um den Vergleich zu starten.',
			'tutorial.steps.filter.title' => '4. Ergebnisse filtern',
			'tutorial.steps.filter.description' => 'Nutzen Sie diese Filter für Hinzugefügt, Entfernt oder Geändert.',
			'tutorial.steps.search.title' => '5. Ergebnisse suchen',
			'tutorial.steps.search.description' => 'Finden Sie spezifische Schlüssel oder Werte.',
			'tutorial.steps.advanced.title' => '6. Erweiterte Ansicht',
			'tutorial.steps.advanced.description' => 'Öffnen Sie die Detailansicht mit Bearbeitung, KI-Übersetzung und mehr.',
			'tutorial.steps.export.title' => '7. Ergebnisse exportieren',
			'tutorial.steps.export.description' => 'Speichern Sie Ihren Vergleich als CSV, JSON oder Excel.',
			'friendlyErrors.fileNotFound.message' => 'Die Datei oder der Ordner konnte nicht gefunden werden.',
			'friendlyErrors.fileNotFound.suggestion' => 'Prüfen Sie, ob die Datei verschoben oder gelöscht wurde.',
			'friendlyErrors.accessDenied.message' => 'Zugriff auf die Datei wurde verweigert.',
			'friendlyErrors.accessDenied.suggestion' => 'Versuchen Sie es als Administrator oder prüfen Sie Dateirechte.',
			'friendlyErrors.isDirectory.message' => 'Ein Ordner wurde statt einer Datei ausgewählt.',
			'friendlyErrors.isDirectory.suggestion' => 'Bitte wählen Sie eine gültige Datei.',
			'friendlyErrors.fileAccess.message' => 'Es gab ein Problem beim Zugriff auf die Datei.',
			'friendlyErrors.fileAccess.suggestion' => 'Schließen Sie andere Programme, die sie verwenden könnten.',
			'friendlyErrors.unsupportedFormat.message' => 'Dieses Dateiformat oder Operation wird nicht unterstützt.',
			'friendlyErrors.unsupportedFormat.suggestion' => 'Prüfen Sie die Dateiendung oder versuchen Sie ein anderes Format.',
			'friendlyErrors.networkError.message' => 'Konnte keine Verbindung zum Server herstellen.',
			'friendlyErrors.networkError.suggestion' => 'Prüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.',
			'friendlyErrors.notGitRepo.message' => 'Dieser Ordner ist kein Git-Projekt.',
			'friendlyErrors.notGitRepo.suggestion' => 'Navigieren Sie zu einem Ordner mit .git Verzeichnis.',
			'friendlyErrors.mergeConflict.message' => 'Es gibt Merge-Konflikte im Repository.',
			'friendlyErrors.mergeConflict.suggestion' => 'Lösen Sie die Konflikte bevor Sie fortfahren.',
			'friendlyErrors.gitAuthFailed.message' => 'Git-Authentifizierung fehlgeschlagen.',
			'friendlyErrors.gitAuthFailed.suggestion' => 'Prüfen Sie Ihre Anmeldedaten in Einstellungen > Version Control.',
			'friendlyErrors.gitOperationFailed.message' => 'Eine Git-Operation ist fehlgeschlagen.',
			'friendlyErrors.gitOperationFailed.suggestion' => 'Prüfen Sie die Git-Ansicht für mehr Details.',
			'friendlyErrors.invalidJson.message' => 'Das Dateiformat ist ungültig oder beschädigt.',
			'friendlyErrors.invalidJson.suggestion' => 'Stellen Sie sicher, dass die Datei gültiges JSON enthält.',
			'friendlyErrors.rateLimitReached.message' => 'Übersetzungslimit erreicht.',
			'friendlyErrors.rateLimitReached.suggestion' => 'Warten Sie einige Minuten oder prüfen Sie Ihr API-Limit.',
			'friendlyErrors.invalidApiKey.message' => 'Ungültiger API-Schlüssel.',
			'friendlyErrors.invalidApiKey.suggestion' => 'Gehen Sie zu Einstellungen > KI-Übersetzung um ihn zu aktualisieren.',
			'friendlyErrors.translationServiceError.message' => 'Fehler beim Übersetzungsdienst.',
			'friendlyErrors.translationServiceError.suggestion' => 'Prüfen Sie Ihren API-Schlüssel und Internetverbindung.',
			'friendlyErrors.outOfMemory.message' => 'Nicht genügend Speicher für diese Operation.',
			'friendlyErrors.outOfMemory.suggestion' => 'Schließen Sie andere Anwendungen oder nutzen Sie kleinere Dateien.',
			'friendlyErrors.genericError.message' => 'Etwas ist schiefgelaufen.',
			'friendlyErrors.genericError.suggestion' => 'Bitte versuchen Sie es erneut. Wenn das Problem besteht, starten Sie die App neu.',
			'systemTray.showLocalizer' => 'Localizer anzeigen',
			'systemTray.exit' => 'Beenden',
			'validation.connected' => 'Verbunden.',
			'validation.connectionTimeout' => 'Zeitüberschreitung. Bitte erneut versuchen.',
			'validation.couldNotConnect' => 'Konnte nicht verbinden. Bitte erneut versuchen.',
			'validation.checkKeyAndTryAgain' => 'Konnte nicht verbinden. Prüfen Sie den Schlüssel.',
			'validation.tryAgainLater' => 'Konnte nicht verbinden. Bitte später versuchen.',
			'validation.serviceUnavailable' => 'Dienst gerade nicht verfügbar. Bitte später versuchen.',
			'validation.enterKeyFirst' => 'Bitte geben Sie zuerst einen Schlüssel ein.',
			'validation.checking' => 'Prüfe...',
			'validation.deeplUsage' => ({required Object used, required Object limit}) => 'Verbrauch: ${used} / ${limit} Zeichen.',
			'status.startingComparison' => 'Starte Vergleich...',
			'status.loadingFromHistory' => 'Lade Dateien aus Verlauf...',
			'status.comparisonComplete' => 'Vergleich abgeschlossen',
			'status.couldNotImportFiles' => 'Konnte Dateien nicht importieren. Bitte erneut versuchen.',
			'status.historyFilesNotFound' => 'Eine oder beide Dateien aus dem Verlauf nicht am Originalpfad gefunden.',
			'aiServices.geminiEmptyResponse' => 'Gemini lieferte leere Antwort',
			'aiServices.geminiStreamingEmpty' => 'Gemini Streaming lieferte leere Antwort',
			'aiServices.geminiRephraseEmpty' => 'Gemini lieferte leere Antwort für Umformulierung',
			'aiServices.openaiEmptyResponse' => 'OpenAI lieferte leere oder fehlgeschlagene Antwort',
			_ => null,
		};
	}
}
