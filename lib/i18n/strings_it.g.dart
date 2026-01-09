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
class TranslationsIt
    with BaseTranslations<AppLocale, Translations>
    implements Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsIt(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.it,
              overrides: overrides ?? {},
              cardinalResolver: cardinalResolver,
              ordinalResolver: ordinalResolver,
            ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <it>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final TranslationsIt _root = this; // ignore: unused_field

  @override
  TranslationsIt $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsIt(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsAppIt app = _TranslationsAppIt._(_root);
  @override
  late final _TranslationsCommonIt common = _TranslationsCommonIt._(_root);
  @override
  late final _TranslationsMenuIt menu = _TranslationsMenuIt._(_root);
  @override
  late final _TranslationsNavIt nav = _TranslationsNavIt._(_root);
  @override
  late final _TranslationsSettingsIt settings =
      _TranslationsSettingsIt._(_root);
  @override
  late final _TranslationsFileComparisonIt fileComparison =
      _TranslationsFileComparisonIt._(_root);
  @override
  late final _TranslationsDirectoryComparisonIt directoryComparison =
      _TranslationsDirectoryComparisonIt._(_root);
  @override
  late final _TranslationsGitComparisonIt gitComparison =
      _TranslationsGitComparisonIt._(_root);
  @override
  late final _TranslationsAdvancedComparisonIt advancedComparison =
      _TranslationsAdvancedComparisonIt._(_root);
  @override
  late final _TranslationsAdvancedDiffIt advancedDiff =
      _TranslationsAdvancedDiffIt._(_root);
  @override
  late final _TranslationsIssueDetailsIt issueDetails =
      _TranslationsIssueDetailsIt._(_root);
  @override
  late final _TranslationsImportReviewIt importReview =
      _TranslationsImportReviewIt._(_root);
  @override
  late final _TranslationsHistoryViewIt historyView =
      _TranslationsHistoryViewIt._(_root);
  @override
  late final _TranslationsCompareIt compare = _TranslationsCompareIt._(_root);
  @override
  late final _TranslationsHistoryIt history = _TranslationsHistoryIt._(_root);
  @override
  late final _TranslationsProjectsIt projects =
      _TranslationsProjectsIt._(_root);
  @override
  late final _TranslationsDiffIt diff = _TranslationsDiffIt._(_root);
  @override
  late final _TranslationsGitIt git = _TranslationsGitIt._(_root);
  @override
  late final _TranslationsQualityIt quality = _TranslationsQualityIt._(_root);
  @override
  late final _TranslationsErrorsIt errors = _TranslationsErrorsIt._(_root);
  @override
  late final _TranslationsWizardsIt wizards = _TranslationsWizardsIt._(_root);
  @override
  late final _TranslationsDialogsIt dialogs = _TranslationsDialogsIt._(_root);
  @override
  late final _TranslationsGridIt grid = _TranslationsGridIt._(_root);
  @override
  late final _TranslationsTutorialIt tutorial =
      _TranslationsTutorialIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsIt friendlyErrors =
      _TranslationsFriendlyErrorsIt._(_root);
  @override
  late final _TranslationsSystemTrayIt systemTray =
      _TranslationsSystemTrayIt._(_root);
  @override
  late final _TranslationsValidationIt validation =
      _TranslationsValidationIt._(_root);
  @override
  late final _TranslationsStatusIt status = _TranslationsStatusIt._(_root);
  @override
  late final _TranslationsAiServicesIt aiServices =
      _TranslationsAiServicesIt._(_root);
  @override
  late final _TranslationsDiffTableIt diffTable =
      _TranslationsDiffTableIt._(_root);
  @override
  late final _TranslationsOnboardingIt onboarding =
      _TranslationsOnboardingIt._(_root);
}

// Path: app
class _TranslationsAppIt implements TranslationsAppEn {
  _TranslationsAppIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Strumento di Confronto Localizzazione';
  @override
  String get name => 'Localizer';
}

// Path: common
class _TranslationsCommonIt implements TranslationsCommonEn {
  _TranslationsCommonIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get save => 'Salva';
  @override
  String get cancel => 'Annulla';
  @override
  String get close => 'Chiudi';
  @override
  String get delete => 'Elimina';
  @override
  String get edit => 'Modifica';
  @override
  String get add => 'Aggiungi';
  @override
  String get search => 'Cerca';
  @override
  String get undo => 'Annulla';
  @override
  String get loading => 'Caricamento...';
  @override
  String get error => 'Errore';
  @override
  String get success => 'Successo';
  @override
  String get warning => 'Avviso';
  @override
  String get info => 'Info';
  @override
  String get confirm => 'Conferma';
  @override
  String get yes => 'Sì';
  @override
  String get no => 'No';
  @override
  String get ok => 'OK';
  @override
  String get retry => 'Riprova';
  @override
  String get copyText => 'Copia';
  @override
  String get appName => 'Localizer';
  @override
  String get copied => 'Copiato!';
  @override
  String get enabled => 'Abilitato';
  @override
  String get disabled => 'Disabilitato';
  @override
  String get browse => 'Sfoglia';
  @override
  String get clear => 'Cancella';
  @override
  String get apply => 'Applica';
  @override
  String get reset => 'Ripristina';
  @override
  String get refresh => 'Aggiorna';
  @override
  String get export => 'Esporta';
  @override
  String get import => 'Importa';
  @override
  String get select => 'Seleziona';
  @override
  String get selectAll => 'Seleziona tutto';
  @override
  String get deselectAll => 'Deseleziona tutto';
  @override
  String get noResults => 'Nessun risultato trovato';
  @override
  String get emptyState => 'Ancora nulla qui';
  @override
  String get open => 'Apri';
  @override
  String get change => 'Cambia';
  @override
  String get original => 'Originale';
  @override
  String get kNew => 'Nuovo';
  @override
  String get remove => 'Rimuovi';
  @override
  String get auto => 'Auto';
  @override
  String get execute => 'Esegui';
  @override
  String get run => 'Esegui';
  @override
  String get unknown => 'Sconosciuto';
  @override
  String get download => 'Scarica';
  @override
  String get dropdownArrow => 'Freccia a discesa';
  @override
  String get openInNewWindow => 'Apre in una nuova finestra';
  @override
  String get resetToDefaults => 'Ripristina predefiniti';
}

// Path: menu
class _TranslationsMenuIt implements TranslationsMenuEn {
  _TranslationsMenuIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get file => 'File';
  @override
  String get edit => 'Modifica';
  @override
  String get view => 'Visualizza';
  @override
  String get help => 'Aiuto';
  @override
  String get openFiles => 'Apri file...';
  @override
  String get openFolder => 'Apri cartella...';
  @override
  String get exportResults => 'Esporta risultati...';
  @override
  String get undo => 'Annulla';
  @override
  String get redo => 'Ripristina';
  @override
  String get cut => 'Taglia';
  @override
  String get paste => 'Incolla';
  @override
  String get selectAll => 'Seleziona tutto';
  @override
  String get zoomIn => 'Ingrandisci';
  @override
  String get zoomOut => 'Rimpicciolisci';
  @override
  String get resetZoom => 'Ripristina zoom';
  @override
  String get documentation => 'Documentazione';
  @override
  String get reportIssue => 'Segnala un problema';
  @override
  String about({required Object appName}) => 'Informazioni su ${appName}';
}

// Path: nav
class _TranslationsNavIt implements TranslationsNavEn {
  _TranslationsNavIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get compare => 'Confronta';
  @override
  String get history => 'Cronologia';
  @override
  String get settings => 'Impostazioni';
  @override
  String get projects => 'Progetti';
  @override
  String get dashboard => 'Dashboard';
  @override
  String get directory => 'Cartella';
  @override
  String get repository => 'Repository';
  @override
  String get tooltipCompare => 'Confronta file di localizzazione';
  @override
  String get tooltipHistory => 'Visualizza cronologia confronti';
  @override
  String get tooltipSettings => 'Impostazioni app';
  @override
  String get tooltipProjects => 'Gestisci progetti';
  @override
  String get tooltipThemeToggle => 'Attiva/disattiva tema';
  @override
  String get tooltipDebugConsole => 'Console di debug';
}

// Path: settings
class _TranslationsSettingsIt implements TranslationsSettingsEn {
  _TranslationsSettingsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Impostazioni';
  @override
  String get appSettings => 'Impostazioni App';
  @override
  String get projectSettings => 'Impostazioni Progetto';
  @override
  late final _TranslationsSettingsAppearanceIt appearance =
      _TranslationsSettingsAppearanceIt._(_root);
  @override
  late final _TranslationsSettingsGeneralIt general =
      _TranslationsSettingsGeneralIt._(_root);
  @override
  late final _TranslationsSettingsScopeIt scope =
      _TranslationsSettingsScopeIt._(_root);
  @override
  late final _TranslationsSettingsSearchKeywordsIt searchKeywords =
      _TranslationsSettingsSearchKeywordsIt._(_root);
  @override
  late final _TranslationsSettingsComparisonIt comparison =
      _TranslationsSettingsComparisonIt._(_root);
  @override
  late final _TranslationsSettingsFileHandlingIt fileHandling =
      _TranslationsSettingsFileHandlingIt._(_root);
  @override
  late final _TranslationsSettingsTranslationMemoryIt translationMemory =
      _TranslationsSettingsTranslationMemoryIt._(_root);
  @override
  late final _TranslationsSettingsBackupIt backup =
      _TranslationsSettingsBackupIt._(_root);
  @override
  late final _TranslationsSettingsAiIt ai = _TranslationsSettingsAiIt._(_root);
  @override
  late final _TranslationsSettingsIntegrationsIt integrations =
      _TranslationsSettingsIntegrationsIt._(_root);
  @override
  late final _TranslationsSettingsDeveloperIt developer =
      _TranslationsSettingsDeveloperIt._(_root);
  @override
  late final _TranslationsSettingsAboutIt about =
      _TranslationsSettingsAboutIt._(_root);
  @override
  late final _TranslationsSettingsOnboardingIt onboarding =
      _TranslationsSettingsOnboardingIt._(_root);
  @override
  late final _TranslationsSettingsSettingsViewIt settingsView =
      _TranslationsSettingsSettingsViewIt._(_root);
}

// Path: fileComparison
class _TranslationsFileComparisonIt implements TranslationsFileComparisonEn {
  _TranslationsFileComparisonIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Confronto File';
  @override
  String get openFiles => 'Apri File';
  @override
  String get exportResults => 'Esporta Risultati';
  @override
  String get restartTutorial => 'Riavvia Tutorial';
  @override
  String get restartTutorialDevOnly =>
      'Il riavvio del tutorial è disponibile solo in modalità sviluppatore.';
  @override
  String get unsupportedFileType => 'Tipo di file non supportato.';
  @override
  String get unsupportedFileTypeSuggestion =>
      'Seleziona un file di localizzazione supportato.';
  @override
  String get someFilesUnsupported => 'Alcuni file non sono supportati.';
  @override
  String get pickSupportedFiles =>
      'Scegli solo file di localizzazione supportati.';
  @override
  String get pickTwoFiles => 'Scegli due file da confrontare.';
  @override
  String get pickBilingualFile => 'Seleziona un file bilingue da confrontare.';
  @override
  String get noResultsToExport => 'Nessun risultato da esportare ancora.';
  @override
  String get performComparisonFirst =>
      'Esegui prima un confronto per esportare i risultati.';
  @override
  String get performComparisonFirstEditor =>
      'Esegui prima un confronto per vedere i dettagli avanzati.';
  @override
  String get sampleDataLoaded => 'Dati di esempio caricati con successo';
  @override
  String loadSampleDataError({required Object error}) =>
      'Impossibile caricare i dati di esempio: ${error}';
  @override
  String get invalidFileType => 'Tipo di file non valido.';
  @override
  String fileSelected({required Object label, required Object fileName}) =>
      '${label} selezionato: ${fileName}';
  @override
  String get sourceFile => 'File sorgente';
  @override
  String get targetFile => 'File di destinazione';
  @override
  String get bilingualFile => 'File bilingue';
  @override
  String get compareFiles => 'Confronta File';
  @override
  String get compareFile => 'Confronta File';
  @override
  String get bilingualMode => 'Modalità Bilingue';
  @override
  String get twoFilesMode => 'Due File';
  @override
  String get processing => 'Elaborazione in corso...';
  @override
  String remaining({required Object time}) => 'mancano ${time}';
  @override
  String get comparisonInProgress => 'Confronto in corso...';
  @override
  String comparisonFailed({required Object error}) =>
      'Confronto Fallito: ${error}';
  @override
  String fileChanged({required Object fileName}) =>
      'File modificato: ${fileName}. Riconfronto in corso...';
  @override
  String get dropFileHere => 'Trascina il file qui';
  @override
  String get dropFileOrBrowse => 'Trascina il file o fai clic per sfogliare';
  @override
  String get fileUpload => 'Carica file';
  @override
  String get changeFile => 'Cambia file';
  @override
  String get total => 'Totale';
  @override
  String get show => 'Mostra';
  @override
  String get showAll => 'Mostra Tutto';
  @override
  String noMatches({required Object query}) =>
      'Nessuna corrispondenza trovata per "${query}"';
  @override
  String showingEntries({required Object count, required Object total}) =>
      'Visualizzazione di ${count} su ${total} voci';
  @override
  String get filesIdentical => 'I file sono identici.';
  @override
  String hiddenIdentical({required Object count}) =>
      '${count} voci identiche nascoste';
  @override
  String get showIdentical => 'Mostra Voci Identiche';
  @override
  String get hideIdentical => 'Nascondi voci identiche';
  @override
  String get noDiff => 'Nessuna differenza trovata in base alle chiavi.';
  @override
  String get source => 'Sorgente';
  @override
  String get target => 'Destinazione';
  @override
  String get value => 'Valore';
  @override
  String get readyToCompare => 'Pronto per il Confronto dei File';
  @override
  String get readyToCompareDesc =>
      'Trascina i file di localizzazione sopra o usa i pulsanti sfoglia\nper selezionare i file da confrontare.';
  @override
  String get recentComparisons => 'Confronti Recenti';
  @override
  String bilingualFileLabel({required Object name}) => 'File bilingue: ${name}';
  @override
  String comparisonLabel({required Object source, required Object target}) =>
      '${source} ↔ ${target}';
  @override
  String get fileNotExist =>
      'Uno o entrambi i file di questa sessione non esistono più.';
  @override
  String get largeFileTitle => 'Rilevato File di Grandi Dimensioni';
  @override
  String largeFileContent({required Object count}) =>
      'Il risultato del confronto contiene ${count} voci.\nVisualizzarle tutte potrebbe causare problemi di prestazioni.\n\nVuoi procedere?';
  @override
  String get dontShowAgain => 'Non mostrare più per questo file';
  @override
  String get proceed => 'Procedi';
  @override
  String exportReport({required Object format}) => 'Salva Report ${format}';
  @override
  String saved({required Object format}) => '${format} salvato';
  @override
  String saveError({required Object format}) =>
      'Impossibile salvare il file ${format}.';
  @override
  String saveErrorDetailed({required Object format, required Object error}) =>
      'Impossibile salvare ${format}: ${error}';
  @override
  String get watching => 'Monitoraggio attivo';
  @override
  String get watchOff => 'Monitoraggio disattivato';
  @override
  String watchingTooltip({required Object status}) =>
      'Monitoraggio File: ${status}\nRiconfronta automaticamente quando i file cambiano su disco';
  @override
  String get aiSettingsNotAvailable =>
      'Navigazione alle Impostazioni AI non disponibile';
}

// Path: directoryComparison
class _TranslationsDirectoryComparisonIt
    implements TranslationsDirectoryComparisonEn {
  _TranslationsDirectoryComparisonIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Confronto Cartelle';
  @override
  String get sourceDirectory => 'Cartella Sorgente';
  @override
  String get targetDirectory => 'Cartella di Destinazione';
  @override
  String get sourceSubtitle => 'File originali/di riferimento';
  @override
  String get targetSubtitle => 'File di traduzione/confronto';
  @override
  String get selectBothDirectories =>
      'Seleziona sia la cartella sorgente che quella di destinazione.';
  @override
  String get selectSourceFolder => 'Seleziona Cartella Sorgente';
  @override
  String get selectTargetFolder => 'Seleziona Cartella di Destinazione';
  @override
  String get dropFolderHere => 'Trascina la cartella qui o sfoglia...';
  @override
  String get folderPath => 'Percorso Cartella';
  @override
  String get readyToCompare => 'Pronto per il Confronto delle Cartelle';
  @override
  String get readyToCompareDesc =>
      'Trascina le cartelle sopra o usa i pulsanti sfoglia\nper selezionare le cartelle da confrontare.';
  @override
  String get nestedFolders => 'Cartelle nidificate';
  @override
  String get nestedFoldersTooltip =>
      'Confronta ricorsivamente tutte le sottocartelle';
  @override
  String get fileMatching => 'Corrispondenza file';
  @override
  String get fileMatchingTooltip => 'Accoppia automaticamente i file per nome';
  @override
  String get bulkExport => 'Esportazione massiva';
  @override
  String get bulkExportTooltip =>
      'Esporta tutti i risultati del confronto in una volta sola';
  @override
  String get notDirectoryComparison =>
      'Questo non è un confronto tra cartelle.';
  @override
  String get directoriesNotExist =>
      'Una o entrambe le cartelle non esistono più.';
  @override
  String get errorOccurred => 'Si è verificato un errore';
  @override
  String get noFilesFound => 'Nessun file trovato nelle cartelle selezionate.';
  @override
  String get unmatchedSourceFiles => 'File Sorgente Non Accoppiati';
  @override
  String get unmatchedTargetFiles => 'File di Destinazione Non Accoppiati';
  @override
  String filePairs({required Object count}) => '${count} coppie di file';
  @override
  String pairedFiles({required Object count}) => 'File Accoppiati (${count})';
  @override
  String get view => 'Visualizza';
  @override
  String get failed => 'Fallito';
  @override
  String get pair => 'Accoppia...';
  @override
  String pairDialogTitle({required Object name}) => 'Accoppia "${name}" con:';
  @override
  String get discoverFiles => 'Scopri File';
  @override
  String get compareAll => 'Confronta Tutto';
  @override
  String get exportAll => 'Esporta Tutto';
  @override
  String get comparisonStarted => 'Confronto avviato...';
  @override
  String get discoveringFiles => 'Ricerca file in corso...';
  @override
  String get noResultsToExport =>
      'Nessun risultato da esportare. Esegui prima "Confronta Tutto".';
  @override
  String get selectExportFolder => 'Seleziona Cartella di Esportazione';
  @override
  String createExportFolderError({required Object error}) =>
      'Impossibile creare la cartella di esportazione: ${error}';
  @override
  String get exportingResults => 'Esportazione Risultati';
  @override
  String processingFile({required Object file}) => 'In elaborazione: ${file}';
  @override
  String exportProgress({required Object current, required Object total}) =>
      '${current} di ${total} file esportati';
  @override
  String get exportComplete => 'Esportazione Completata';
  @override
  String exportSuccessMessage({required Object count}) =>
      'Esportati con successo ${count} file di confronto più il riepilogo.';
  @override
  String exportFailed({required Object error}) =>
      'Esportazione fallita: ${error}';
  @override
  String get close => 'Chiudi';
}

// Path: gitComparison
class _TranslationsGitComparisonIt implements TranslationsGitComparisonEn {
  _TranslationsGitComparisonIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'I termini Git (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) devono rimanere in inglese per tutte le traduzioni per evitare confusione tra gli sviluppatori.';
  @override
  String get title => 'Confronto Repository';
  @override
  String get repoSelector => 'Crea / Apri Repository';
  @override
  String get noRepoSelected => 'Nessun repository selezionato';
  @override
  String get open => 'Apri';
  @override
  String get refreshCommits => 'Aggiorna Commit';
  @override
  String get noCommits =>
      'Nessun commit trovato o caricato. Seleziona un branch per caricare i commit.';
  @override
  String get baseCommit => 'Base Commit (Più vecchio)';
  @override
  String get targetCommit => 'Target Commit (Più recente)';
  @override
  String get filterCommitsByBranch => 'Filtra Commit per Branch';
  @override
  String get conflictDetection => 'Rilevamento conflitti';
  @override
  String get conflictDetectionTooltip =>
      'Rileva e risolvi i conflitti di merge';
  @override
  String get actions => 'Azioni:';
  @override
  String get checkout => 'Checkout';
  @override
  String get merge => 'Merge';
  @override
  String get pull => 'Pull';
  @override
  String get checkoutBranch => 'Checkout Branch';
  @override
  String get mergeBranch => 'Esegui Merge del Branch in quello corrente';
  @override
  String mergeConfirmation({required Object branch}) =>
      'Eseguire merge di ${branch}?';
  @override
  String get mergeWarning =>
      'Questo unirà le modifiche nel tuo branch di lavoro attuale. Potrebbero verificarsi conflitti.';
  @override
  String get selectExportFolder => 'Seleziona Cartella di Esportazione';
  @override
  String createExportFolderError({required Object error}) =>
      'Impossibile creare la cartella di esportazione: ${error}';
  @override
  String get exportingFiles => 'Esportazione File';
  @override
  String processingFile({required Object file}) => 'In elaborazione: ${file}';
  @override
  String exportProgress({required Object current, required Object total}) =>
      '${current} di ${total} file esportati';
  @override
  String get exportComplete => 'Esportazione Completata';
  @override
  String exportSuccessMessage({required Object count}) =>
      'Esportati con successo ${count} file con il contenuto completo.';
  @override
  String get exportDetail =>
      'Il diff di ogni file è salvato nella sottocartella "files".';
  @override
  String get diffViewer => 'Visualizzatore Diff';
  @override
  String get base => 'BASE';
  @override
  String get target => 'TARGET';
  @override
  String get noLines => 'Nessuna riga da visualizzare';
  @override
  String get searchFiles => 'Cerca file...';
  @override
  String noFilesMatch({required Object query}) =>
      'Nessun file corrisponde a "${query}"';
  @override
  String filesCount({required Object count}) => '${count} file';
  @override
  String get selectBaseFile => 'Seleziona File Base';
  @override
  String get selectTargetFile => 'Seleziona File Target';
  @override
  String get comparisonResults => 'Risultati del Confronto';
  @override
  String get noChanges =>
      'Nessuna modifica trovata tra i riferimenti selezionati.';
  @override
  String get linesAdded => 'Righe Aggiunte';
  @override
  String get linesRemoved => 'Righe Rimosse';
  @override
  String get commit => 'Commit';
  @override
  String get branch => 'Branch';
  @override
  String get noRepositorySelected => 'Nessun repository selezionato';
  @override
  String get notGitComparison => 'Non è un confronto Git';
  @override
  String get repositoryNotExist => 'Il repository non esiste';
  @override
  String get mainBranch => 'main';
  @override
  String get masterBranch => 'master';
  @override
  String get backToControls => 'Torna ai controlli di confronto';
}

// Path: advancedComparison
class _TranslationsAdvancedComparisonIt
    implements TranslationsAdvancedComparisonEn {
  _TranslationsAdvancedComparisonIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get placeholder => 'Vista Confronto Avanzata - Placeholder';
}

// Path: advancedDiff
class _TranslationsAdvancedDiffIt implements TranslationsAdvancedDiffEn {
  _TranslationsAdvancedDiffIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get saveAllChanges => 'Salvare tutte le modifiche?';
  @override
  String saveConfirmation({required Object count}) =>
      'Questo salverà tutte le ${count} voci modificate nel file di destinazione. Questa azione non può essere annullata.';
  @override
  String get changesSaved => 'Modifiche salvate con successo.';
  @override
  String get csvExported => 'CSV esportato';
  @override
  String get unsavedChanges => 'Modifiche non salvate';
  @override
  String get unsavedChangesWarning =>
      'Hai delle modifiche non salvate. Sei sicuro di volerle scartare?';
  @override
  String get discardChanges => 'Scarta Modifiche';
  @override
  String get goBack => 'Torna indietro';
  @override
  String get breadcrumbs => 'Home  >  Editor';
  @override
  String unsaved({required Object count}) => '${count} non salvate';
  @override
  String reviewed({required Object count}) => '${count} revisionate';
  @override
  String saveAll({required Object count}) => 'Salva Tutto (${count})';
  @override
  String get allSaved => 'Tutto Salvato';
  @override
  String get saveAllTooltip => 'Salva tutte le modifiche (Ctrl+S)';
  @override
  String get exportTooltip => 'Esporta Dati (Ctrl+E)';
  @override
  late final _TranslationsAdvancedDiffAiSuggestionIt aiSuggestion =
      _TranslationsAdvancedDiffAiSuggestionIt._(_root);
  @override
  late final _TranslationsAdvancedDiffDetailEditIt detailEdit =
      _TranslationsAdvancedDiffDetailEditIt._(_root);
  @override
  late final _TranslationsAdvancedDiffTableIt table =
      _TranslationsAdvancedDiffTableIt._(_root);
  @override
  late final _TranslationsAdvancedDiffDiffRowIt diffRow =
      _TranslationsAdvancedDiffDiffRowIt._(_root);
  @override
  late final _TranslationsAdvancedDiffStatusIt status =
      _TranslationsAdvancedDiffStatusIt._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarIt sidebar =
      _TranslationsAdvancedDiffSidebarIt._(_root);
}

// Path: issueDetails
class _TranslationsIssueDetailsIt implements TranslationsIssueDetailsEn {
  _TranslationsIssueDetailsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Dettagli Problema';
  @override
  String showingIssues({required Object count, required Object total}) =>
      'Visualizzazione di ${count} su ${total} problemi';
  @override
  String get searchPlaceholder => 'Cerca per chiave, testo o errore...';
  @override
  String get noDetails => 'Nessun dettaglio disponibile.';
  @override
  String get noMatches => 'Nessuna corrispondenza trovata.';
  @override
  String get showMore => 'Mostra Altro';
  @override
  String copyItems({required Object count}) => 'Copia ${count} elementi';
  @override
  String get close => 'Chiudi';
  @override
  String get copied => 'Copiato negli appunti';
  @override
  String copiedCount({required Object count}) => 'Copiati ${count} elementi';
  @override
  late final _TranslationsIssueDetailsDuplicateValueIt duplicateValue =
      _TranslationsIssueDetailsDuplicateValueIt._(_root);
  @override
  late final _TranslationsIssueDetailsLengthOutlierIt lengthOutlier =
      _TranslationsIssueDetailsLengthOutlierIt._(_root);
  @override
  late final _TranslationsIssueDetailsStandardIt standard =
      _TranslationsIssueDetailsStandardIt._(_root);
  @override
  String get review => 'Revisione';
  @override
  late final _TranslationsIssueDetailsTypesIt types =
      _TranslationsIssueDetailsTypesIt._(_root);
  @override
  late final _TranslationsIssueDetailsNotesIt notes =
      _TranslationsIssueDetailsNotesIt._(_root);
  @override
  late final _TranslationsIssueDetailsFallbacksIt fallbacks =
      _TranslationsIssueDetailsFallbacksIt._(_root);
}

// Path: importReview
class _TranslationsImportReviewIt implements TranslationsImportReviewEn {
  _TranslationsImportReviewIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Revisione Importazione Progetto';
  @override
  String get projectName => 'Nome Progetto';
  @override
  String get created => 'Creato';
  @override
  String get historyItems => 'Elementi Cronologia';
  @override
  String get customSettingsTitle => 'Rilevate Impostazioni Personalizzate';
  @override
  String get customSettingsWarning =>
      'Questo progetto contiene impostazioni personalizzate che sovrascriveranno i tuoi predefiniti mentre il progetto è aperto.';
  @override
  String get standardSettings =>
      'Questo progetto usa le impostazioni globali standard.';
  @override
  String get cancelImport => 'Annulla Importazione';
  @override
  String get trustOpen => 'Fidati e Apri Progetto';
}

// Path: historyView
class _TranslationsHistoryViewIt implements TranslationsHistoryViewEn {
  _TranslationsHistoryViewIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Cronologia Confronti';
  @override
  String get clearAll => 'Cancella tutta la cronologia';
  @override
  String get searchPlaceholder => 'Cerca per nome file...';
  @override
  String get sortBy => 'Ordina per';
  @override
  String get sortDate => 'Data';
  @override
  String get sortSource => 'File Sorgente';
  @override
  String get sortTarget => 'File Target';
  @override
  String get showCurrentProject => 'Visualizzazione: Progetto Corrente';
  @override
  String get showAllHistory => 'Visualizzazione: Tutta la Cronologia';
  @override
  String get groupByFolder => 'Raggruppa per cartella';
  @override
  String get disableGrouping => 'Disabilita raggruppamento cartelle';
  @override
  String get filterAll => 'Tutti';
  @override
  String get filterFiles => 'File';
  @override
  String get filterDirectories => 'Cartelle';
  @override
  String get filterGit => 'Git';
  @override
  String get noHistory => 'Ancora nessuna cronologia confronti';
  @override
  String get historyDescription => 'I tuoi confronti appariranno qui';
  @override
  String get noResults => 'Nessun risultato trovato';
  @override
  String get adjustSearch => 'Prova a regolare la ricerca';
  @override
  String get clearConfirmationTitle => 'Cancellare Tutta la Cronologia?';
  @override
  String get clearConfirmationContent =>
      'Questo eliminerà permanentemente tutta la cronologia dei confronti. L\'azione è irreversibile.';
  @override
  String get clearAction => 'Cancella Tutto';
  @override
  String get deletedMessage => 'Elemento cronologia eliminato';
  @override
  String get undo => 'Annulla';
  @override
  String get viewDetails => 'Visualizza Dettagli';
  @override
  String get delete => 'Elimina';
  @override
  String get openLocation => 'Apri posizione file';
  @override
  String get bilingual => 'Bilingue';
  @override
  String get filePair => 'Coppia di File';
  @override
  String get directory => 'Cartella';
  @override
  String get git => 'Git';
  @override
  String get repo => 'Repo';
  @override
  String get sourceDir => 'Dir Sorgente';
  @override
  String get targetDir => 'Dir Target';
  @override
  String get source => 'Sorgente';
  @override
  String get target => 'Target';
  @override
  String get noChanges => 'Nessuna modifica rilevata';
  @override
  String get added => 'Aggiunti';
  @override
  String get removed => 'Rimossi';
  @override
  String get modified => 'Modificati';
  @override
  String get same => 'Uguali';
  @override
  String get total => 'Totale';
  @override
  String get currentProject => 'Progetto Corrente';
  @override
  String get unassigned => 'Non assegnato';
  @override
  String get project => 'Progetto';
}

// Path: compare
class _TranslationsCompareIt implements TranslationsCompareEn {
  _TranslationsCompareIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Confronta File';
  @override
  String get sourceFile => 'File Sorgente';
  @override
  String get targetFile => 'File Target';
  @override
  String get sourceFolder => 'Cartella Sorgente';
  @override
  String get targetFolder => 'Cartella Target';
  @override
  String get dropFilesHint =>
      'Trascina i file di localizzazione qui o usa i pulsanti sfoglia per selezionare i file da confrontare.';
  @override
  String get selectSourceFile => 'Seleziona file sorgente';
  @override
  String get selectTargetFile => 'Seleziona file target';
  @override
  String get startComparison => 'Avvia Confronto';
  @override
  String get comparing => 'Confronto in corso...';
  @override
  String get comparisonComplete => 'Confronto completato';
  @override
  String get noChanges => 'Nessuna modifica rilevata';
  @override
  String get filesIdentical => 'I file sono identici';
  @override
  String changesFound({required Object count}) => '${count} modifiche trovate';
  @override
  late final _TranslationsCompareTabsIt tabs =
      _TranslationsCompareTabsIt._(_root);
  @override
  late final _TranslationsCompareFileTypesIt fileTypes =
      _TranslationsCompareFileTypesIt._(_root);
}

// Path: history
class _TranslationsHistoryIt implements TranslationsHistoryEn {
  _TranslationsHistoryIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Cronologia';
  @override
  String get recentComparisons => 'Confronti Recenti';
  @override
  String get noHistory => 'Ancora nessuna cronologia confronti';
  @override
  String get noHistoryDescription => 'La tua cronologia apparirà qui';
  @override
  String get clearHistory => 'Cancella Cronologia';
  @override
  String get clearHistoryConfirm =>
      'Sei sicuro di voler cancellare tutta la cronologia?';
  @override
  String get deleteEntry => 'Elimina Voce';
  @override
  String get openComparison => 'Apri Confronto';
  @override
  late final _TranslationsHistoryTimeAgoIt timeAgo =
      _TranslationsHistoryTimeAgoIt._(_root);
}

// Path: projects
class _TranslationsProjectsIt implements TranslationsProjectsEn {
  _TranslationsProjectsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Progetti';
  @override
  String get createProject => 'Crea Progetto';
  @override
  String get importProject => 'Importa Progetto';
  @override
  String get noProjects => 'Ancora nessun progetto';
  @override
  String get noProjectsDescription =>
      'Crea un progetto per organizzare i tuoi file di localizzazione';
  @override
  String get projectName => 'Nome Progetto';
  @override
  String get projectPath => 'Percorso Progetto';
  @override
  String get lastOpened => 'Ultima apertura';
  @override
  String get openProject => 'Apri Progetto';
  @override
  String get closeProject => 'Chiudi Progetto';
  @override
  String get deleteProject => 'Elimina Progetto';
  @override
  String get deleteProjectConfirm =>
      'Sei sicuro di voler eliminare questo progetto?';
  @override
  String get exportProject => 'Esporta Progetto';
  @override
  String get exportDescription =>
      'Crea un file zip portatile contenente i file sorgente, la configurazione e la cronologia.';
  @override
  String get exporting => 'Esportazione progetto...';
  @override
  String get exportSuccess => 'Progetto esportato';
  @override
  String exportError({required Object error}) =>
      'Esportazione fallita: ${error}';
  @override
  String get createNewProject => 'Crea Nuovo Progetto';
  @override
  String get openExistingProject => 'Apri Progetto Esistente';
  @override
  String get importProjectZip => 'Importa Zip Progetto';
  @override
  String get projectResources => 'Risorse Progetto';
  @override
  String get recentProjects => 'Progetti Recenti';
  @override
  String get noRecentProjects => 'Nessun progetto recente';
  @override
  String get selectProjectZip => 'Seleziona Zip Progetto';
  @override
  String get selectDestination =>
      'Seleziona Cartella di Destinazione per l\'Importazione';
  @override
  String get importing => 'Importazione progetto...';
  @override
  String get importSuccess => 'Progetto importato con successo';
  @override
  String importFailed({required Object error}) =>
      'Importazione fallita: ${error}';
  @override
  String get importingFiles => 'Importazione file...';
  @override
  String get noSupportedFiles => 'Non sono stati trascinati file supportati.';
  @override
  late final _TranslationsProjectsStatsIt stats =
      _TranslationsProjectsStatsIt._(_root);
  @override
  String get openProjectFirst =>
      'Apri prima un progetto per gestire le sue risorse.';
  @override
  String get removeFromRecent => 'Rimuovi dai recenti';
  @override
  late final _TranslationsProjectsSelectionIt selection =
      _TranslationsProjectsSelectionIt._(_root);
  @override
  late final _TranslationsProjectsCreateDialogIt createDialog =
      _TranslationsProjectsCreateDialogIt._(_root);
  @override
  late final _TranslationsProjectsIndicatorIt indicator =
      _TranslationsProjectsIndicatorIt._(_root);
  @override
  late final _TranslationsProjectsGlossaryIt glossary =
      _TranslationsProjectsGlossaryIt._(_root);
  @override
  late final _TranslationsProjectsConflictsIt conflicts =
      _TranslationsProjectsConflictsIt._(_root);
  @override
  late final _TranslationsProjectsTmIt tm = _TranslationsProjectsTmIt._(_root);
}

// Path: diff
class _TranslationsDiffIt implements TranslationsDiffEn {
  _TranslationsDiffIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'Aggiunto';
  @override
  String get removed => 'Rimosso';
  @override
  String get modified => 'Modificato';
  @override
  String get unchanged => 'Invariato';
  @override
  String get missing => 'Mancante';
  @override
  String get extra => 'Extra';
  @override
  String get sourceValue => 'Valore Sorgente';
  @override
  String get targetValue => 'Valore Target';
  @override
  String get key => 'Chiave';
  @override
  String get status => 'Stato';
  @override
  String get actions => 'Azioni';
  @override
  String get copyToTarget => 'Copia in Target';
  @override
  String get acceptChange => 'Accetta Modifica';
  @override
  String get rejectChange => 'Rifiuta Modifica';
  @override
  String get viewDetails => 'Visualizza Dettagli';
}

// Path: git
class _TranslationsGitIt implements TranslationsGitEn {
  _TranslationsGitIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Confronto Git';
  @override
  String get selectRepository => 'Seleziona Repository';
  @override
  String get selectBranch => 'Seleziona Branch';
  @override
  String get selectCommit => 'Seleziona Commit';
  @override
  String get compareBranches => 'Confronta Branch';
  @override
  String get compareCommits => 'Confronta Commit';
  @override
  String get baseBranch => 'Branch Base';
  @override
  String get compareBranch => 'Branch di Confronto';
  @override
  String get noRepositories => 'Nessun repository Git trovato';
  @override
  String get noRepositoriesDescription =>
      'Apri una cartella contenente un repository Git';
  @override
  String filesChanged({required Object count}) => '${count} file modificati';
  @override
  String additions({required Object count}) => '${count} aggiunte';
  @override
  String deletions({required Object count}) => '${count} rimozioni';
  @override
  late final _TranslationsGitConflictsIt conflicts =
      _TranslationsGitConflictsIt._(_root);
}

// Path: quality
class _TranslationsQualityIt implements TranslationsQualityEn {
  _TranslationsQualityIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'I termini API e metriche (Requests, Tokens, Characters, Prompt, Completion, Export) devono rimanere in inglese per tutte le traduzioni per mantenere la coerenza con la terminologia del settore.';
  @override
  String get title => 'Dashboard Qualità';
  @override
  String get overallScore => 'Punteggio Complessivo';
  @override
  String get issues => 'Problemi';
  @override
  String get warnings => 'Avvisi';
  @override
  String get suggestions => 'Suggerimenti';
  @override
  String get placeholderMismatch => 'Discrepanza Segnaposto';
  @override
  String get placeholderMismatchDescription =>
      'I segnaposto come {name} non corrispondono tra sorgente e destinazione';
  @override
  String get lengthOutlier => 'Anomalia Lunghezza';
  @override
  String get lengthOutlierDescription =>
      'La lunghezza della traduzione differisce significativamente dalla sorgente';
  @override
  String get duplicateValue => 'Valore Duplicato';
  @override
  String get duplicateValueDescription =>
      'La stessa traduzione è usata per più chiavi';
  @override
  String get missingTranslation => 'Traduzione Mancante';
  @override
  String get missingTranslationDescription =>
      'Manca la traduzione per questa chiave';
  @override
  String get loading => 'Caricamento dashboard...';
  @override
  String get errorLoading => 'Impossibile caricare la cronologia. Riprova.';
  @override
  String get emptyState => 'Esegui un confronto per vedere la tua dashboard.';
  @override
  String get refresh => 'Aggiorna';
  @override
  String get buildingInsights => 'Analisi in corso...';
  @override
  String get crunchingNumbers => 'Elaborazione dati...';
  @override
  String get errorBuilding => 'Impossibile creare la dashboard. Riprova.';
  @override
  String get noUsableData => 'Ancora nessun dato utilizzabile trovato.';
  @override
  String get languages => 'Lingue';
  @override
  String get averageCoverage => 'Copertura media';
  @override
  String get potentialIssues => 'Problemi potenziali';
  @override
  String get translationCoverage => 'Copertura traduzione';
  @override
  String entriesTranslated(
          {required Object translated, required Object total}) =>
      '${translated} su ${total} voci tradotte';
  @override
  String get wordsAddedOverTime => 'Parole aggiunte nel tempo';
  @override
  String get completionVsScope => 'Completamento vs Ambito';
  @override
  String get scopeVsProgress => 'Ambito vs Progresso';
  @override
  String get coveragePercent => 'Copertura %';
  @override
  String get wordsAdded => 'Parole Aggiunte';
  @override
  String get words => 'Parole';
  @override
  String get coverage => 'Copertura';
  @override
  String get scope => 'Ambito';
  @override
  String get latest => 'Recente';
  @override
  String get added => 'Aggiunte';
  @override
  String get change => 'Modifica';
  @override
  String get totalScope => 'Ambito Totale';
  @override
  String wordsCount({required Object count}) => '${count} parole';
  @override
  String get scopeGrowth => 'Crescita Ambito';
  @override
  String get range => 'Intervallo';
  @override
  String get aiUsage => 'Utilizzo AI e Traduzione';
  @override
  String lastUsed({required Object date}) => 'Ultimo utilizzo ${date}';
  @override
  String get noIssuesFound => 'Nessun problema trovato negli ultimi confronti.';
  @override
  String get placeholderMismatches => 'Discrepanze segnaposto';
  @override
  String get placeholderMismatchesDesc =>
      'I marcatori come {name} non corrispondono.';
  @override
  String get lengthOutliers => 'Traduzioni molto corte o lunghe';
  @override
  String get lengthOutliersDesc =>
      'La lunghezza sembra insolita rispetto alla sorgente.';
  @override
  String get duplicateValues => 'Valori duplicati';
  @override
  String get duplicateValuesDesc => 'La stessa traduzione è usata molte volte.';
  @override
  String get placeholderDialogTitle => 'Discrepanze Segnaposto';
  @override
  String get placeholderDialogDesc =>
      'Queste traduzioni hanno segnaposto ({name}) diversi dalla sorgente.';
  @override
  String get lengthDialogTitle => 'Anomalie di Lunghezza';
  @override
  String get lengthDialogDesc =>
      'Queste traduzioni sono significativamente più corte o più lunghe della sorgente.';
  @override
  String get duplicateDialogTitle => 'Valori Duplicati';
  @override
  String get duplicateDialogDesc => 'Queste traduzioni appaiono più volte.';
  @override
  String duplicateSample({required Object value}) => 'Duplicato: "${value}"';
  @override
  String get exportError => 'Impossibile generare il report. Riprova.';
  @override
  String get noDataToExport => 'Nessun dato da esportare';
  @override
  String get exportFailed => 'Esportazione fallita';
  @override
  String get exportDialogTitle => 'Esporta Report Qualità';
  @override
  String get reportSaved => 'Report salvato';
  @override
  String get export => 'Esporta';
  @override
  String get requests => 'Richieste';
  @override
  String get tokens => 'Token';
  @override
  String get characters => 'Caratteri';
  @override
  String get estCost => 'Costo stimato';
  @override
  String get prompt => 'Prompt';
  @override
  String get completion => 'Completamento';
  @override
  String get showingCurrentProject => 'Visualizzazione: Progetto Corrente';
  @override
  String get showingAllHistory => 'Visualizzazione: Tutta la Cronologia';
  @override
  String get filesSkipped =>
      'Alcuni file sono stati saltati perché non trovati.';
  @override
  String charCount({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
        n,
        one: '1 carattere',
        other: '${count} caratteri',
      );
  @override
  String lengthDiff(
          {required Object target,
          required Object percent,
          required Object source}) =>
      'Target è ${target} (${percent}%) vs sorgente ${source}';
}

// Path: errors
class _TranslationsErrorsIt implements TranslationsErrorsEn {
  _TranslationsErrorsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get genericError => 'Si è verificato un errore';
  @override
  String get fileNotFound => 'File non trovato';
  @override
  String get invalidFormat => 'Formato file non valido';
  @override
  String get parseError => 'Impossibile analizzare il file';
  @override
  String get networkError => 'Errore di rete. Controlla la tua connessione.';
  @override
  String get permissionDenied => 'Permesso negato';
  @override
  String get unknownError => 'Si è verificato un errore sconosciuto';
}

// Path: wizards
class _TranslationsWizardsIt implements TranslationsWizardsEn {
  _TranslationsWizardsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsWizardsFirstRunIt firstRun =
      _TranslationsWizardsFirstRunIt._(_root);
}

// Path: dialogs
class _TranslationsDialogsIt implements TranslationsDialogsEn {
  _TranslationsDialogsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDialogsAddIgnorePatternIt addIgnorePattern =
      _TranslationsDialogsAddIgnorePatternIt._(_root);
  @override
  late final _TranslationsDialogsDiffViewerIt diffViewer =
      _TranslationsDialogsDiffViewerIt._(_root);
}

// Path: grid
class _TranslationsGridIt implements TranslationsGridEn {
  _TranslationsGridIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGridColumnsIt columns =
      _TranslationsGridColumnsIt._(_root);
}

// Path: tutorial
class _TranslationsTutorialIt implements TranslationsTutorialEn {
  _TranslationsTutorialIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'SALTA TUTORIAL';
  @override
  String get finishMessage => 'Sei pronto! Tocca ovunque per finire.';
  @override
  String get next => 'Avanti';
  @override
  String get loadSampleData => 'Carica Dati di Esempio';
  @override
  String get browseSourceFile => 'Sfoglia File Sorgente';
  @override
  String get browseTargetFile => 'Sfoglia File Target';
  @override
  String get compareFiles => 'Confronta File';
  @override
  String get hintPhase2 =>
      'Prossimo: filtri, ricerca, vista avanzata ed esportazione.';
  @override
  late final _TranslationsTutorialStepsIt steps =
      _TranslationsTutorialStepsIt._(_root);
}

// Path: friendlyErrors
class _TranslationsFriendlyErrorsIt implements TranslationsFriendlyErrorsEn {
  _TranslationsFriendlyErrorsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsFriendlyErrorsFileNotFoundIt fileNotFound =
      _TranslationsFriendlyErrorsFileNotFoundIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsAccessDeniedIt accessDenied =
      _TranslationsFriendlyErrorsAccessDeniedIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsIsDirectoryIt isDirectory =
      _TranslationsFriendlyErrorsIsDirectoryIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsFileAccessIt fileAccess =
      _TranslationsFriendlyErrorsFileAccessIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsUnsupportedFormatIt unsupportedFormat =
      _TranslationsFriendlyErrorsUnsupportedFormatIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsNetworkErrorIt networkError =
      _TranslationsFriendlyErrorsNetworkErrorIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsNotGitRepoIt notGitRepo =
      _TranslationsFriendlyErrorsNotGitRepoIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsMergeConflictIt mergeConflict =
      _TranslationsFriendlyErrorsMergeConflictIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitAuthFailedIt gitAuthFailed =
      _TranslationsFriendlyErrorsGitAuthFailedIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitOperationFailedIt
      gitOperationFailed =
      _TranslationsFriendlyErrorsGitOperationFailedIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidJsonIt invalidJson =
      _TranslationsFriendlyErrorsInvalidJsonIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsRateLimitReachedIt rateLimitReached =
      _TranslationsFriendlyErrorsRateLimitReachedIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidApiKeyIt invalidApiKey =
      _TranslationsFriendlyErrorsInvalidApiKeyIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsTranslationServiceErrorIt
      translationServiceError =
      _TranslationsFriendlyErrorsTranslationServiceErrorIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsOutOfMemoryIt outOfMemory =
      _TranslationsFriendlyErrorsOutOfMemoryIt._(_root);
  @override
  late final _TranslationsFriendlyErrorsGenericErrorIt genericError =
      _TranslationsFriendlyErrorsGenericErrorIt._(_root);
}

// Path: systemTray
class _TranslationsSystemTrayIt implements TranslationsSystemTrayEn {
  _TranslationsSystemTrayIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get showLocalizer => 'Mostra Localizer';
  @override
  String get exit => 'Esci';
}

// Path: validation
class _TranslationsValidationIt implements TranslationsValidationEn {
  _TranslationsValidationIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get connected => 'Connesso.';
  @override
  String get connectionTimeout => 'Connessione scaduta. Riprova.';
  @override
  String get couldNotConnect => 'Impossibile connettersi. Riprova.';
  @override
  String get checkKeyAndTryAgain =>
      'Impossibile connettersi. Controlla la chiave e riprova.';
  @override
  String get tryAgainLater => 'Impossibile connettersi ora. Riprova più tardi.';
  @override
  String get serviceUnavailable =>
      'Il servizio non è disponibile al momento. Riprova più tardi.';
  @override
  String get enterKeyFirst => 'Inserisci prima una chiave.';
  @override
  String get checking => 'Verifica in corso...';
  @override
  String deeplUsage({required Object used, required Object limit}) =>
      'Utilizzo: ${used} / ${limit} caratteri.';
}

// Path: status
class _TranslationsStatusIt implements TranslationsStatusEn {
  _TranslationsStatusIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get startingComparison => 'Avvio confronto...';
  @override
  String get loadingFromHistory => 'Caricamento file dalla cronologia...';
  @override
  String get comparisonComplete => 'Confronto completato';
  @override
  String get couldNotImportFiles => 'Impossibile importare i file. Riprova.';
  @override
  String get historyFilesNotFound =>
      'Uno o entrambi i file della cronologia non sono stati trovati nei percorsi originali.';
}

// Path: aiServices
class _TranslationsAiServicesIt implements TranslationsAiServicesEn {
  _TranslationsAiServicesIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get geminiEmptyResponse => 'Gemini ha restituito una risposta vuota';
  @override
  String get geminiStreamingEmpty =>
      'Lo streaming di Gemini ha restituito una risposta vuota';
  @override
  String get geminiRephraseEmpty =>
      'Gemini ha restituito una risposta vuota per la rielaborazione';
  @override
  String get openaiEmptyResponse =>
      'OpenAI ha restituito una risposta vuota o fallita';
}

// Path: diffTable
class _TranslationsDiffTableIt implements TranslationsDiffTableEn {
  _TranslationsDiffTableIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDiffTableColumnsIt columns =
      _TranslationsDiffTableColumnsIt._(_root);
  @override
  String get empty => 'No entries to display';
  @override
  late final _TranslationsDiffTablePaginationIt pagination =
      _TranslationsDiffTablePaginationIt._(_root);
  @override
  late final _TranslationsDiffTableMessagesIt messages =
      _TranslationsDiffTableMessagesIt._(_root);
  @override
  late final _TranslationsDiffTableEditDialogIt editDialog =
      _TranslationsDiffTableEditDialogIt._(_root);
}

// Path: onboarding
class _TranslationsOnboardingIt implements TranslationsOnboardingEn {
  _TranslationsOnboardingIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get gettingStarted => 'Getting Started';
  @override
  String stepProgress({required Object current, required Object total}) =>
      'Step ${current} of ${total}';
  @override
  String get skipTutorial => 'Skip Tutorial';
  @override
  String get loadSampleData => 'Load Sample Data';
  @override
  late final _TranslationsOnboardingStepsIt steps =
      _TranslationsOnboardingStepsIt._(_root);
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceIt
    implements TranslationsSettingsAppearanceEn {
  _TranslationsSettingsAppearanceIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Aspetto';
  @override
  String get description =>
      'Personalizza l\'aspetto e l\'interfaccia dell\'app';
  @override
  String get theme => 'Modalità Tema';
  @override
  String get themeDescription => 'Scegli tra tema chiaro, scuro o di sistema';
  @override
  String get themeSystem => 'Sistema';
  @override
  String get themeLight => 'Chiaro';
  @override
  String get themeDark => 'Scuro';
  @override
  String get themeAmoled => 'AMOLED';
  @override
  String get accentColor => 'Colore Accento';
  @override
  String get accentColorDescription => 'Scegli il tuo colore accento preferito';
  @override
  String get useMicaEffect => 'Usa Effetto Mica';
  @override
  String get micaDescription =>
      'Abilità l\'effetto di trasparenza Mica di Windows 11 per un look moderno';
  @override
  String get diffFontSize => 'Dimensione Carattere Diff';
  @override
  String get diffFontSizeDescription =>
      'Regola la dimensione del carattere nella vista di confronto';
  @override
  String get diffFontFamily => 'Famiglia Carattere Diff';
  @override
  String get diffFontFamilyDescription => 'Carattere per la vista di confronto';
  @override
  String get systemDefault => 'Predefinito di Sistema';
  @override
  String get pickAccentColor => 'Scegli Colore Accento';
  @override
  String get diffColors => 'Colori Diff';
  @override
  String get presetsTitle => 'Predefiniti';
  @override
  late final _TranslationsSettingsAppearancePresetsIt presets =
      _TranslationsSettingsAppearancePresetsIt._(_root);
  @override
  String get identical => 'Identico';
  @override
  String pickColorFor({required Object label}) => 'Scegli colore per ${label}';
  @override
  String get livePreview => 'Anteprima dal vivo';
  @override
  late final _TranslationsSettingsAppearancePreviewIt preview =
      _TranslationsSettingsAppearancePreviewIt._(_root);
}

// Path: settings.general
class _TranslationsSettingsGeneralIt implements TranslationsSettingsGeneralEn {
  _TranslationsSettingsGeneralIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Generale';
  @override
  String get description => 'Impostazioni generali dell\'applicazione';
  @override
  String get language => 'Lingua';
  @override
  String get languageDescription => 'Scegli la tua lingua preferita';
  @override
  String get startMinimized => 'Avvia ridotto nella barra di sistema';
  @override
  String get startMinimizedDescription =>
      'Avvia l\'app ridotta nella barra delle applicazioni';
  @override
  String get rememberWindowPosition => 'Ricorda posizione finestra';
  @override
  String get rememberWindowPositionDescription =>
      'Ripristina dimensioni e posizione della finestra all\'avvio';
  @override
  String get openLastProject => 'Apri ultimo progetto all\'avvio';
  @override
  String get openLastProjectDescription =>
      'Apri automaticamente l\'ultimo progetto utilizzato all\'avvio dell\'app';
  @override
  String get application => 'Applicazione';
  @override
  String get defaultView => 'Vista Predefinita';
  @override
  String get defaultViewDescription => 'Vista da mostrare all\'avvio';
  @override
  String get autoCheckUpdates => 'Controlla aggiornamenti automaticamente';
  @override
  String get autoCheckUpdatesDescription =>
      'Controlla aggiornamenti all\'avvio';
  @override
  String get startupOptions => 'Opzioni di avvio';
  @override
  String get languageAuto => 'Rilevamento automatico';
  @override
  String get viewBasic => 'Confronto File';
  @override
  String get viewHistory => 'Cronologia';
  @override
  String get viewDashboard => 'Dashboard Qualità';
  @override
  String get viewDirectory => 'Confronto Cartelle';
  @override
  String get viewLastUsed => 'Ultima vista usata';
}

// Path: settings.scope
class _TranslationsSettingsScopeIt implements TranslationsSettingsScopeEn {
  _TranslationsSettingsScopeIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ambito Impostazioni';
  @override
  String get global => 'Predefiniti Globali';
  @override
  String get project => 'Progetto';
  @override
  String get reset => 'Ripristina progetto ai predefiniti globali';
  @override
  String get resetConfirmation =>
      'Questo cancellerà tutte le personalizzazioni per questo progetto e ripristinerà i predefiniti globali. Questa azione non può essere annullata.';
  @override
  String get globalDescription =>
      'Le modifiche si applicano a tutti i progetti a meno che non siano sovrascritte.';
  @override
  String projectDescription({required Object name}) =>
      'Le modifiche si applicano solo a "${name}". Altre impostazioni ereditano dai predefiniti globali.';
  @override
  String get createPrompt =>
      'Crea un progetto per personalizzare le impostazioni per cartelle specifiche';
}

// Path: settings.searchKeywords
class _TranslationsSettingsSearchKeywordsIt
    implements TranslationsSettingsSearchKeywordsEn {
  _TranslationsSettingsSearchKeywordsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  List<String> get general => [
        'Lingua',
        'Vista Predefinita',
        'Conteggio File Recenti',
        'Apri Ultimo Progetto',
        'Conferma Prima di Uscire',
        'Mostra Notifiche',
      ];
  @override
  List<String> get comparisonEngine => [
        'Modalità Confronto',
        'Soglia di Somiglianza',
        'Case Sensitive',
        'Ignora Spazi Bianchi',
        'Ignora Righe Vuote',
        'Ignora Commenti',
        'Ignora Pattern',
      ];
  @override
  List<String> get appearance => [
        'Tema',
        'Modalità Tema',
        'Colore Accento',
        'Dimensione Carattere Diff',
        'Famiglia Carattere Diff',
        'Colori Diff',
        'Colore Aggiunto',
        'Colore Rimosso',
        'Colore Modificato',
        'Colore Identico',
        'Predefiniti Colore',
        'Anteprima',
      ];
  @override
  List<String> get fileHandling => [
        'Formato Sorgente',
        'Formato Destinazione',
        'Codifica Predefinita',
        'Conteggio Progetti Recenti',
        'Memoria di Traduzione',
        'Importa Memoria',
        'Esporta Memoria',
        'Cancella Memoria',
      ];
  @override
  List<String> get aiServices => [
        'Chiave API OpenAI',
        'Chiave API Anthropic',
        'Chiave API Google AI',
        'Modello AI',
        'Temperatura',
        'Prompt Personalizzato',
      ];
  @override
  List<String> get systemIntegrations => [
        'Barra di Sistema',
        'Avvia Ridotto',
        'Associazioni File',
        'Effetto Mica',
        'Vibrancy',
        'Materiale Finestra',
        'Badge Dock',
        'Conteggio Non Tradotti',
      ];
  @override
  List<String> get projectResources => [
        'Glossario',
        'Memoria di Traduzione',
        'Terminologia',
      ];
  @override
  List<String> get about => [
        'Versione',
        'Controlla Aggiornamenti',
        'Aggiornamento Automatico',
        'Changelog',
        'Licenza',
        'Informativa sulla Privacy',
        'Telemetria',
        'Segnalazione Crash',
      ];
  @override
  List<String> get developer => [
        'Overlay Prestazioni',
        'Debugger Semantica',
        'Griglia Material',
        'Cache Raster',
        'Riavvia Tutorial',
        'Ripristino di Fabbrica',
      ];
}

// Path: settings.comparison
class _TranslationsSettingsComparisonIt
    implements TranslationsSettingsComparisonEn {
  _TranslationsSettingsComparisonIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Confronto';
  @override
  String get description => 'Configura il comportamento del confronto';
  @override
  String get caseSensitive => 'Case Sensitive';
  @override
  String get caseSensitiveDescription =>
      'Tratta le lettere maiuscole e minuscole come diverse';
  @override
  String get ignoreWhitespace => 'Ignora Spazi Bianchi';
  @override
  String get ignoreWhitespaceDescription =>
      'Ignora gli spazi bianchi iniziali/finali durante il confronto';
  @override
  String get showLineNumbers => 'Mostra Numeri di Riga';
  @override
  String get showLineNumbersDescription =>
      'Visualizza i numeri di riga nella vista diff';
  @override
  String get behavior => 'Comportamento Confronto';
  @override
  String get ignoreCase => 'Ignora Maiuscole/Minuscole';
  @override
  String get ignoreCaseDescription => 'Tratta "Chiave" e "chiave" come uguali';
  @override
  String get similarityThreshold => 'Soglia di Somiglianza';
  @override
  String get similarityThresholdDescription =>
      'Somiglianza minima per il rilevamento "Modificato"';
  @override
  String get mode => 'Modalità Confronto';
  @override
  String get modeDescription => 'Come accoppiare le voci tra i file';
  @override
  String get modeKey => 'Basato su chiave';
  @override
  String get modeKeyDescription => 'Accoppia per nome chiave (predefinito).';
  @override
  String get modeOrder => 'Basato su ordine';
  @override
  String get modeOrderDescription => 'Accoppia per posizione nel file.';
  @override
  String get modeSmart => 'Accoppiamento Intelligente';
  @override
  String get modeSmartDescription => 'Rileva chiavi spostate/rinominate.';
  @override
  String get ignorePatterns => 'Pattern da Ignorare';
  @override
  String get noIgnorePatterns => 'Nessun pattern da ignorare impostato.';
  @override
  String get addPattern => 'Aggiungi Pattern';
  @override
  String get resetToGlobal =>
      'Ripristina tutte le impostazioni di confronto ai predefiniti globali';
  @override
  late final _TranslationsSettingsComparisonPatternPresetsIt patternPresets =
      _TranslationsSettingsComparisonPatternPresetsIt._(_root);
  @override
  late final _TranslationsSettingsComparisonPreviewMatchIt previewMatch =
      _TranslationsSettingsComparisonPreviewMatchIt._(_root);
  @override
  late final _TranslationsSettingsComparisonColorPresetsIt colorPresets =
      _TranslationsSettingsComparisonColorPresetsIt._(_root);
}

// Path: settings.fileHandling
class _TranslationsSettingsFileHandlingIt
    implements TranslationsSettingsFileHandlingEn {
  _TranslationsSettingsFileHandlingIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get fileFormats => 'Formati File';
  @override
  String get sourceFormat => 'Formato Sorgente';
  @override
  String get targetFormat => 'Formato Destinazione';
  @override
  String get encoding => 'Codifica';
  @override
  String get sourceEncoding => 'Codifica Sorgente';
  @override
  String get targetEncoding => 'Codifica Destinazione';
  @override
  String get autoDetect => 'Rilevamento automatico';
  @override
  String get autoDetectEncodingDescription =>
      'Rileva automaticamente la codifica del file';
  @override
  String get exportSettings => 'Impostazioni Esportazione';
  @override
  String get defaultExportFormat => 'Formato Esportazione Predefinito';
  @override
  String get includeUtf8Bom => 'Includi BOM UTF-8';
  @override
  String get includeUtf8BomDescription =>
      'Richiesto per la compatibilità con Excel';
  @override
  String get openFolderAfterExport => 'Apri cartella dopo esportazione';
  @override
  String get fileSafety => 'Sicurezza File';
  @override
  String get fileSafetyDescription =>
      'Copie locali automatiche per il recupero in caso di errore.';
  @override
  String get resetToGlobal =>
      'Ripristina tutte le impostazioni di gestione file ai predefiniti globali';
}

// Path: settings.translationMemory
class _TranslationsSettingsTranslationMemoryIt
    implements TranslationsSettingsTranslationMemoryEn {
  _TranslationsSettingsTranslationMemoryIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Memoria di Traduzione Globale';
  @override
  String get autoLearn => 'Auto-apprendimento';
  @override
  String get autoLearnDescription =>
      'Salva le traduzioni nella memoria locale per riutilizzi futuri';
  @override
  String get confidenceThreshold => 'Soglia di Confidenza';
  @override
  String confidenceThresholdDescription({required Object percent}) =>
      'Punteggio minimo per l\'applicazione automatica (${percent}%)';
  @override
  String get entries => 'Voci';
  @override
  String get size => 'Dimensione';
  @override
  String memorySize({required Object size}) => 'Dimensione Memoria: ${size}';
  @override
  String get import => 'Importa';
  @override
  String get exportTmx => 'Esporta TMX';
  @override
  String get exportCsv => 'Esporta CSV';
  @override
  String get clearMemory => 'Cancella Memoria';
  @override
  String importedItems({required Object count}) =>
      'Importate ${count} voci nella memoria.';
  @override
  String get noItemsAdded => 'Nessuna voce aggiunta.';
  @override
  String get nothingToExport => 'Nulla da esportare ancora.';
  @override
  String get tmxSaved => 'TMX salvato';
  @override
  String get csvSaved => 'CSV salvato';
  @override
  String get clearConfirmTitle => 'Cancellare la memoria di traduzione?';
  @override
  String get clearConfirmContent =>
      'Questo rimuoverà tutte le coppie di traduzione salvate su questo dispositivo. Questa azione non può essere annullata.';
  @override
  String get cleared => 'Memoria di traduzione cancellata.';
  @override
  String get couldNotClear => 'Impossibile cancellare la memoria.';
}

// Path: settings.backup
class _TranslationsSettingsBackupIt implements TranslationsSettingsBackupEn {
  _TranslationsSettingsBackupIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Backup Automatico';
  @override
  String get description => 'Impostazioni backup automatico';
  @override
  String get enabled => 'Abilita Backup Automatico';
  @override
  String get enabledDescription =>
      'Esegui automaticamente il backup dei file prima di apportare modifiche';
  @override
  String get maxCopies => 'Numero Massimo di Copie di Backup';
  @override
  String get maxCopiesDescription =>
      'Numero di copie di backup da conservare per file';
  @override
  String activeStatus({required Object count}) =>
      'Attivo · Conservazione di ${count} copie';
  @override
  String get folder => 'Cartella di Backup';
  @override
  String get folderDescription => 'Lascia vuoto per usare la stessa cartella';
  @override
  String get useOriginalFolder => 'Usa cartella originale del file';
}

// Path: settings.ai
class _TranslationsSettingsAiIt implements TranslationsSettingsAiEn {
  _TranslationsSettingsAiIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Servizi AI';
  @override
  String get description => 'Configura la traduzione e l\'assistenza AI';
  @override
  String get provider => 'Provider AI';
  @override
  String get providerDescription =>
      'Scegli il tuo provider di servizi AI preferito';
  @override
  String get apiKey => 'Chiave API';
  @override
  String get apiKeyDescription =>
      'Inserisci la tua chiave API per il provider selezionato';
  @override
  String get apiKeyPlaceholder => 'Inserisci chiave API...';
  @override
  String get testConnection => 'Test Connessione';
  @override
  String get connectionSuccess => 'Connessione riuscita!';
  @override
  String get connectionFailed =>
      'Connessione fallita. Controlla la tua chiave API.';
  @override
  String get translationStrategy => 'Strategia di Traduzione';
  @override
  String get strategy => 'Strategia';
  @override
  String get strategyDescription => 'Seleziona come vuoi tradurre le stringhe';
  @override
  String get strategyLLM => 'AI Generativa (LLM)';
  @override
  String get strategyCloud => 'Traduzione Cloud';
  @override
  String get enableAiTranslation => 'Abilita Traduzione AI';
  @override
  String get enableAiTranslationDescription =>
      'Consenti all\'app di usare l\'AI per i suggerimenti di traduzione';
  @override
  String get llmProvider => 'Provider Servizio LLM';
  @override
  String get service => 'Servizio';
  @override
  String get serviceDescription => 'Provider per l\'AI Generativa';
  @override
  String get providerGemini => 'Google Gemini';
  @override
  String get providerOpenAI => 'OpenAI';
  @override
  String get geminiApiKey => 'Chiave API Gemini';
  @override
  String get openAiApiKey => 'Chiave API OpenAI';
  @override
  String get model => 'Modello';
  @override
  String get modelDescription => 'Seleziona quale modello usare';
  @override
  String get advancedParameters => 'Parametri Avanzati';
  @override
  String get parameters => 'Parametri';
  @override
  String get parametersDescription => 'Temperatura, Contesto e altro';
  @override
  String get temperature => 'Temperatura';
  @override
  String get temperatureDescription =>
      'Valori più alti rendono l\'output più creativo';
  @override
  String get maxTokens => 'Token Massimi';
  @override
  String get maxTokensDescription =>
      'Limita la lunghezza della finestra di contesto';
  @override
  String get systemContext => 'Contesto di Sistema / Istruzioni';
  @override
  String get systemContextHint =>
      'Sei un localizzatore professionista. Mantieni il tono e l\'intento della stringa sorgente...';
  @override
  String get systemContextHelper =>
      'Fornisci istruzioni specifiche all\'AI sullo stile e la terminologia del tuo progetto.';
  @override
  String get contextStrings => 'Stringhe di Contesto';
  @override
  String get contextStringsDescription =>
      'Includi le stringhe circostanti per un contesto migliore';
  @override
  String get contextCount => 'Conteggio Contesto';
  @override
  String get contextCountDescription =>
      'Numero di stringhe circostanti da includere';
  @override
  String get cloudServices => 'Servizi di Traduzione Cloud';
  @override
  String get googleTranslateApiKey => 'Chiave API Google Translate';
  @override
  String get deeplApiKey => 'Chiave API DeepL';
  @override
  String get test => 'Test';
  @override
  String get resetToGlobal =>
      'Ripristina tutte le impostazioni AI ai predefiniti globali';
}

// Path: settings.integrations
class _TranslationsSettingsIntegrationsIt
    implements TranslationsSettingsIntegrationsEn {
  _TranslationsSettingsIntegrationsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get platformNotice => 'Avviso Piattaforma';
  @override
  String get platformNoticeDescription =>
      'Le integrazioni di sistema non sono disponibili per questa piattaforma.';
  @override
  String get visualEffects => 'Effetti Visivi';
  @override
  String get explorerIntegration => 'Integrazione Explorer';
  @override
  String get explorerIntegrationDescription =>
      'Aggiungi "Apri con Localizer" al menu contestuale di Esplora file di Windows per le cartelle.';
  @override
  String get addToContextMenu => 'Aggiungi al Menu Contestuale';
  @override
  String get contextMenuAdded => 'Menu contestuale aggiunto!';
  @override
  String get contextMenuAddError =>
      'Impossibile aggiungere il menu contestuale';
  @override
  String get contextMenuRemoved => 'Menu contestuale rimosso!';
  @override
  String get contextMenuRemoveError =>
      'Impossibile rimuovere il menu contestuale';
  @override
  String get fileAssociations => 'Associazioni File';
  @override
  String get fileAssociationsDescription =>
      'Registra i tipi di file da aprire con Localizer quando si fa doppio clic in Esplora file.';
  @override
  String get registered => 'Registrato';
  @override
  String get notRegistered => 'Non registrato';
  @override
  String extRegistered({required Object ext}) => '${ext} registrato!';
  @override
  String extUnregistered({required Object ext}) => '${ext} rimosso!';
  @override
  String extError({required Object action, required Object ext}) =>
      'Impossibile ${action} ${ext}';
  @override
  String get registerAll => 'Registra Tutti';
  @override
  String get unregisterAll => 'Rimuovi Tutti';
  @override
  String registerAllResult({required Object success, required Object total}) =>
      'Registrati ${success} su ${total} tipi di file';
  @override
  String unregisterAllResult(
          {required Object success, required Object total}) =>
      'Rimossi ${success} su ${total} tipi di file';
  @override
  String get protocolHandler => 'Gestore Protocollo';
  @override
  String get protocolHandlerDescription =>
      'Registra gli URL localizer:// per aprire questa applicazione. Consente di aprire i progetti direttamente dai link del browser o da altre app.';
  @override
  String get protocolRegistered => 'Il gestore del protocollo è registrato';
  @override
  String get protocolNotRegistered => 'Gestore del protocollo non registrato';
  @override
  String get registerProtocol => 'Registra Protocollo';
  @override
  String get unregister => 'Rimuovi';
  @override
  String get protocolRegisteredSuccess => 'Gestore del protocollo registrato!';
  @override
  String get protocolRemovedSuccess => 'Gestore del protocollo rimosso!';
  @override
  String get protocolRegisterError => 'Registrazione fallita';
  @override
  String get protocolRemoveError => 'Rimozione fallita';
  @override
  String get windowMaterial => 'Materiale Finestra';
  @override
  String get windowMaterialDescription =>
      'Seleziona lo stile del materiale di vibrazione macOS';
  @override
  String get dockIntegration => 'Integrazione Dock';
  @override
  String get showDockBadge => 'Mostra Conteggio Non Tradotti';
  @override
  String get showDockBadgeDescription =>
      'Mostra il numero di stringhe non tradotte sul badge dell\'icona del dock';
  @override
  late final _TranslationsSettingsIntegrationsMaterialsIt materials =
      _TranslationsSettingsIntegrationsMaterialsIt._(_root);
  @override
  late final _TranslationsSettingsIntegrationsFileTypesIt fileTypes =
      _TranslationsSettingsIntegrationsFileTypesIt._(_root);
}

// Path: settings.developer
class _TranslationsSettingsDeveloperIt
    implements TranslationsSettingsDeveloperEn {
  _TranslationsSettingsDeveloperIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Impostazioni Sviluppatore';
  @override
  String get description => 'Impostazioni avanzate per sviluppatori';
  @override
  String get showLocalizationKeys => 'Mostra Chiavi di Localizzazione';
  @override
  String get localizationKeysDescription =>
      'Se abilitato, tutto il testo tradotto mostrerà le chiavi di localizzazione invece del valore tradotto. Utile per verificare quale chiave viene usata e dove.';
  @override
  String get showPerformanceOverlay => 'Mostra Overlay Prestazioni';
  @override
  String get performanceOverlayDescription =>
      'Visualizza informazioni su FPS e tempi dei frame';
  @override
  String get debugMode => 'Modalità Debug';
  @override
  String get debugModeDescription =>
      'Abilita logging aggiuntivo e funzionalità di debug';
  @override
  String get debuggingTools => 'Strumenti di Debug';
  @override
  String get semanticsDebugger => 'Debugger Semantica';
  @override
  String get semanticsDebuggerDescription =>
      'Visualizza l\'albero della semantica';
  @override
  String get materialGrid => 'Griglia Material';
  @override
  String get materialGridDescription =>
      'Sovrappone la griglia di layout Material';
  @override
  String get rasterCache => 'Immagini Cache Raster';
  @override
  String get rasterCacheDescription =>
      'Evidenzia a scacchi le immagini nella cache raster';
  @override
  String get actions => 'Azioni';
  @override
  String get showLogs => 'Mostra Log App';
  @override
  String get showLogsDescription => 'Apri la console di debug Talker';
  @override
  String get restartTutorial => 'Riavvia Tutorial Iniziale';
  @override
  String get restartTutorialDescription =>
      'Ripristina i flag e avvia di nuovo il tutorial';
  @override
  String get restartRequested => 'Riavvio tutorial richiesto.';
  @override
  String get throwException => 'Lancia Eccezione di Test';
  @override
  String get throwExceptionDescription =>
      'Attiva un\'eccezione di test per la segnalazione crash';
  @override
  String get testExceptionMessage =>
      'Eccezione di Test attivata dalle Opzioni Sviluppatore';
  @override
  String get clearTM => 'Cancella Memoria di Traduzione';
  @override
  String get clearTMDescription => 'Elimina tutte le traduzioni memorizzate';
  @override
  String get clearTMConfirmation => 'Cancellare Memoria di Traduzione?';
  @override
  String get clearTMWarning =>
      'Questo eliminerà tutte le traduzioni apprese. L\'azione è irreversibile.';
  @override
  String get tmCleared => 'Memoria di traduzione cancellata';
  @override
  String get clearApiKeys => 'Cancella Chiavi API';
  @override
  String get clearApiKeysDescription =>
      'Rimuovi tutte le chiavi API memorizzate';
  @override
  String get clearApiKeysConfirmation => 'Cancellare Chiavi API?';
  @override
  String get clearApiKeysWarning =>
      'Questo rimuoverà tutte le chiavi API dallo storage sicuro.';
  @override
  String get apiKeysCleared => 'Chiavi API cancellate';
  @override
  String get hideOptions => 'Nascondi Opzioni Sviluppatore';
  @override
  String get hideOptionsDescription =>
      'Disabilita modalità sviluppatore (richiede 7 tocchi per riabilitarla)';
  @override
  String get optionsDisabled => 'Opzioni sviluppatore disabilitate';
  @override
  String get dangerZone => 'Zona Pericolosa';
  @override
  String get factoryReset => 'Ripristino di Fabbrica';
  @override
  String get factoryResetDescription =>
      'Ripristina tutte le impostazioni e cancella i dati';
  @override
  String get factoryResetWarning =>
      'Sei sicuro di voler ripristinare tutte le impostazioni? Questa azione non può essere annullata.';
  @override
  String get inspectionTools => 'Strumenti di Ispezione';
  @override
  String get searchHint => 'Cerca impostazioni...';
  @override
  String get resetToDefault => 'Ripristina predefiniti';
  @override
  String get resetToGlobal => 'Ripristina al predefinito globale';
  @override
  String get storageInspector => 'Ispettore Archiviazione';
  @override
  String get storageInspectorDescription =>
      'Visualizza i contenuti di Hive e Secure Storage';
  @override
  String get deviceEnvironment => 'Dispositivo e Ambiente';
  @override
  String get deviceEnvironmentDescription =>
      'Info su schermo, piattaforma e build';
  @override
  String get themePlayground => 'Playground del Tema';
  @override
  String get themePlaygroundDescription => 'Tavolozza colori e tipografia';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionIt
      themePlaygroundSection =
      _TranslationsSettingsDeveloperThemePlaygroundSectionIt._(_root);
  @override
  String get localizationInspector => 'Ispettore Localizzazione';
  @override
  String get localizationInspectorDescription =>
      'Debug delle stringhe di traduzione';
  @override
  String get hiveAppSettings => 'Hive (AppSettings)';
  @override
  String get secureStorageMasked => 'Secure Storage (Mascherato)';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsIt featureFlags =
      _TranslationsSettingsDeveloperFeatureFlagsIt._(_root);
  @override
  late final _TranslationsSettingsDeveloperStorageInspectorSectionIt
      storageInspectorSection =
      _TranslationsSettingsDeveloperStorageInspectorSectionIt._(_root);
  @override
  late final _TranslationsSettingsDeveloperDeviceInfoSectionIt
      deviceInfoSection =
      _TranslationsSettingsDeveloperDeviceInfoSectionIt._(_root);
  @override
  late final _TranslationsSettingsDeveloperLocalizationInspectorSectionIt
      localizationInspectorSection =
      _TranslationsSettingsDeveloperLocalizationInspectorSectionIt._(_root);
}

// Path: settings.about
class _TranslationsSettingsAboutIt implements TranslationsSettingsAboutEn {
  _TranslationsSettingsAboutIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Informazioni';
  @override
  String get version => 'Versione';
  @override
  String get buildNumber => 'Numero Build';
  @override
  String get author => 'Autore';
  @override
  String get license => 'Licenza';
  @override
  String get sourceCode => 'Codice Sorgente';
  @override
  String get reportBug => 'Segnala un Bug';
  @override
  String get requestFeature => 'Richiedi una Funzionalità';
  @override
  String get checkForUpdates => 'Controlla Aggiornamenti';
  @override
  String get upToDate => 'L\'app è aggiornata!';
  @override
  String updateAvailable({required Object version}) =>
      'Aggiornamento disponibile: ${version}';
  @override
  String get updateAvailableBadge => 'Aggiornamento Disponibile!';
  @override
  String developerSteps({required Object count}) =>
      'Ti mancano ${count} passaggi per diventare uno sviluppatore.';
  @override
  String get developerActivated => 'Ora sei uno sviluppatore!';
  @override
  String get neverChecked => 'Mai';
  @override
  String get applicationInfo => 'Info Applicazione';
  @override
  String get platform => 'Piattaforma';
  @override
  String get updateInformation => 'Informazioni Aggiornamento';
  @override
  String get currentVersion => 'Versione Corrente';
  @override
  String get latestVersion => 'Ultima Versione';
  @override
  String get lastChecked => 'Ultimo Controllo';
  @override
  String get checkingForUpdates => 'Controllo in corso...';
  @override
  String get whatsNew => 'Novità';
  @override
  String get systemInformation => 'Informazioni di Sistema';
  @override
  String get dartVersion => 'Versione Dart';
  @override
  String get diskSpace => 'Spazio su Disco Disponibile';
  @override
  String get memoryUsage => 'Utilizzo Memoria';
  @override
  String get privacyTitle => 'Privacy e Telemetria';
  @override
  String get usageStats => 'Statistiche di Utilizzo Anonime';
  @override
  String get requiresFirebase => 'Richiede configurazione Firebase';
  @override
  String get featureUnavailable =>
      'Funzionalità attualmente non disponibile (Richiede Firebase)';
  @override
  String get settingsManagement => 'Gestione Impostazioni';
  @override
  String get settingsManagementDescription =>
      'Esporta le tue impostazioni in un file per eseguirne il backup o condividerle con altri computer.';
  @override
  String get resetAll => 'Ripristina Tutto';
  @override
  String get links => 'Link';
  @override
  String get githubRepo => 'Repository GitHub';
  @override
  String get privacyPolicy => 'Informativa sulla Privacy';
  @override
  String get crashReporting => 'Segnalazione Crash';
}

// Path: settings.onboarding
class _TranslationsSettingsOnboardingIt
    implements TranslationsSettingsOnboardingEn {
  _TranslationsSettingsOnboardingIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'Salta Tutorial';
  @override
  String get gettingStarted => 'Iniziamo';
  @override
  String stepProgress({required Object current, required Object total}) =>
      '${current} di ${total}';
  @override
  String get loadSampleData => 'Carica Dati di Esempio';
  @override
  late final _TranslationsSettingsOnboardingStepsIt steps =
      _TranslationsSettingsOnboardingStepsIt._(_root);
}

// Path: settings.settingsView
class _TranslationsSettingsSettingsViewIt
    implements TranslationsSettingsSettingsViewEn {
  _TranslationsSettingsSettingsViewIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String resetCategoryTitle({required Object category}) =>
      'Ripristinare ${category}?';
  @override
  String get resetCategoryContent =>
      'Questo ripristinerà tutte le impostazioni in questa categoria ai loro valori predefiniti.';
  @override
  String get resetAllTitle => 'Ripristinare Tutte le Impostazioni?';
  @override
  String get resetAllContent =>
      'Questo ripristinerà permanentemente tutte le impostazioni ai valori di fabbrica. Questa azione non può essere annullata.';
  @override
  String get resetAll => 'Ripristina Tutto';
  @override
  String resetSuccess({required Object category}) =>
      '${category} ripristinata ai predefiniti';
  @override
  String get errorLoading => 'Errore durante il caricamento delle impostazioni';
  @override
  String get settingsSaved => 'Impostazioni salvate';
  @override
  String updateAvailable({required Object version}) =>
      'Aggiornamento disponibile: v${version}';
  @override
  String get latestVersion => 'Stai usando l\'ultima versione';
  @override
  String whatsNew({required Object version}) => 'Novità nella v${version}';
  @override
  String get downloadUpdate => 'Scarica Aggiornamento';
  @override
  String get exportSettings => 'Esporta Impostazioni';
  @override
  String get settingsExported => 'Impostazioni esportate';
  @override
  String exportFail({required Object error}) =>
      'Impossibile esportare le impostazioni: ${error}';
  @override
  String get importSettings => 'Importa Impostazioni';
  @override
  String get importTitle => 'Importare Impostazioni?';
  @override
  String get importContent =>
      'Questo sostituirà tutte le impostazioni attuali con quelle importate. Questa azione non può essere annullata.';
  @override
  String get importSuccess => 'Impostazioni importate con successo!';
  @override
  String importFail({required Object error}) =>
      'Impossibile importare le impostazioni: ${error}';
  @override
  String get invalidFormat => 'Formato file impostazioni non valido';
  @override
  late final _TranslationsSettingsSettingsViewCategoriesIt categories =
      _TranslationsSettingsSettingsViewCategoriesIt._(_root);
  @override
  late final _TranslationsSettingsSettingsViewCategoryLabelsIt categoryLabels =
      _TranslationsSettingsSettingsViewCategoryLabelsIt._(_root);
}

// Path: advancedDiff.aiSuggestion
class _TranslationsAdvancedDiffAiSuggestionIt
    implements TranslationsAdvancedDiffAiSuggestionEn {
  _TranslationsAdvancedDiffAiSuggestionIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get aiTranslation => 'Traduzione AI';
  @override
  String get aiRephrase => 'Rielaborazione AI';
  @override
  String key({required Object key}) => 'Chiave: ${key}';
  @override
  String get original => 'Originale:';
  @override
  String get suggestion => 'Suggerimento:';
  @override
  String get confidence => 'Confidenza AI';
  @override
  String get cancelEdit => 'Annulla modifica';
  @override
  String get editSuggestion => 'Modifica suggerimento';
  @override
  String get alternatives => 'Alternative:';
  @override
  String get accept => 'Accetta';
  @override
  String get reject => 'Rifiuta';
  @override
  String get stop => 'Ferma';
}

// Path: advancedDiff.detailEdit
class _TranslationsAdvancedDiffDetailEditIt
    implements TranslationsAdvancedDiffDetailEditEn {
  _TranslationsAdvancedDiffDetailEditIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object key}) => 'Modifica: ${key}';
  @override
  String get sourceLabel => 'SORGENTE (Originale)';
  @override
  String get targetLabel => 'DESTINAZIONE (Traduzione)';
  @override
  String get translateWithCloud => 'Traduci con Cloud';
  @override
  String get translateWithAi => 'Traduci con AI';
  @override
  String get translating => 'Traduzione in corso...';
  @override
  String get applyAndTm => 'Applica';
  @override
  String get entryApplied => 'Voce applicata e aggiunta alla TM';
  @override
  String get translationAdded => 'Suggerimento di traduzione aggiunto.';
  @override
  String get aiSuggestionAdded => 'Suggerimento AI aggiunto.';
}

// Path: advancedDiff.table
class _TranslationsAdvancedDiffTableIt
    implements TranslationsAdvancedDiffTableEn {
  _TranslationsAdvancedDiffTableIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get addedToTM => 'Aggiunto alla Memoria di Traduzione';
  @override
  String get markedReviewed => 'Contrassegnato come revisionato ✓';
  @override
  String get unmarkedReview => 'Revisione annullata';
  @override
  String get reverted => 'Ripristinato al valore sorgente';
  @override
  String get entryDeleted => 'Voce eliminata';
  @override
  String get noSourceText => 'Nessun testo sorgente da tradurre.';
  @override
  String aiTranslationFailed({required Object key}) =>
      'Traduzione AI fallita per "${key}"';
  @override
  String get noTargetText => 'Nessun testo di destinazione da rielaborare.';
  @override
  String aiRephraseFailed({required Object key}) =>
      'Rielaborazione AI fallita per "${key}"';
  @override
  String get checkRowsFirst =>
      'Seleziona prima le righe usando le caselle di controllo';
  @override
  String markedRowsReviewed({required Object count}) =>
      'Contrassegnate ${count} righe come revisionate';
  @override
  String revertedRows({required Object count}) => 'Ripristinate ${count} righe';
  @override
  String entriesCount({required Object count}) => '${count} voci';
  @override
  String get markSelectedReviewed => 'Segna Selezionati come Revisionati';
  @override
  String get revertSelected => 'Ripristina Selezionati';
  @override
  String get noDifferences => 'Nessuna differenza trovata';
  @override
  String get adjustFilters => 'Prova a regolare i filtri';
  @override
  String get cloudTranslationApplied => 'Traduzione cloud applicata.';
  @override
  String get aiTranslationApplied => 'Traduzione AI applicata.';
  @override
  String get suggestionApplied => 'Suggerimento applicato.';
  @override
  String get aiSuggestionApplied => 'Suggerimento AI applicato.';
  @override
  String get rephraseApplied => 'Rielaborazione applicata.';
  @override
  String get aiRephraseApplied => 'Rielaborazione AI applicata.';
  @override
  String get rephrase => 'Rielabora';
  @override
  String get aiRephrase => 'Rielabora con AI';
  @override
  String get targetClickToEdit => 'DESTINAZIONE (Clicca per modificare)';
  @override
  String get targetClickForDialog =>
      'DESTINAZIONE (Clicca per la finestra di dialogo)';
  @override
  String get emptyClickToEdit => '(Vuoto - Clicca per modificare)';
  @override
  String get unmarkReviewed => 'Annulla revisione';
  @override
  String get markReviewed => 'Segna come revisionato';
  @override
  String get revertToSource => 'Ripristina a sorgente';
  @override
  String get translateWithCloud => 'Traduci con Cloud';
  @override
  String get translateWithAi => 'Traduci con AI';
  @override
  String get rephraseWithAi => 'Rielabora con AI';
  @override
  String get moreActions => 'Altre azioni';
  @override
  String get editDetails => 'Modifica dettagli';
  @override
  String get suggestTranslation => 'Suggerisci traduzione';
  @override
  String get addToTm => 'Aggiungi a TM';
  @override
  String get deleteEntry => 'Elimina voce';
}

// Path: advancedDiff.diffRow
class _TranslationsAdvancedDiffDiffRowIt
    implements TranslationsAdvancedDiffDiffRowEn {
  _TranslationsAdvancedDiffDiffRowIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get copySource => 'Copia testo sorgente';
  @override
  String get actions => 'Azioni';
}

// Path: advancedDiff.status
class _TranslationsAdvancedDiffStatusIt
    implements TranslationsAdvancedDiffStatusEn {
  _TranslationsAdvancedDiffStatusIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'AGGIUNTO';
  @override
  String get missing => 'MANCANTE';
  @override
  String changed({required Object percent}) => 'MOD ${percent}%';
  @override
  String get same => 'UGUALE';
}

// Path: advancedDiff.sidebar
class _TranslationsAdvancedDiffSidebarIt
    implements TranslationsAdvancedDiffSidebarEn {
  _TranslationsAdvancedDiffSidebarIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get widgets => 'Widget';
  @override
  String get searchPlaceholder => 'Cerca chiavi e valori... (Ctrl+F)';
  @override
  String get fuzzySearchTooltip => 'Ricerca Fuzzy (tollerante agli errori)';
  @override
  String get regexSearchTooltip => 'Ricerca Regex';
  @override
  String get cloudTranslation => 'Traduzione Cloud';
  @override
  String get aiTranslation => 'Traduzione AI';
  @override
  String get status => 'Stato';
  @override
  String get tm => 'Memoria di Traduzione';
  @override
  String get filters => 'Filtri';
  @override
  String get actions => 'Azioni';
  @override
  String get similarity => 'Somiglianza';
  @override
  late final _TranslationsAdvancedDiffSidebarActionsSectionIt actionsSection =
      _TranslationsAdvancedDiffSidebarActionsSectionIt._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarAiSectionIt aiSection =
      _TranslationsAdvancedDiffSidebarAiSectionIt._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarTmSectionIt tmSection =
      _TranslationsAdvancedDiffSidebarTmSectionIt._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarFiltersSectionIt filtersSection =
      _TranslationsAdvancedDiffSidebarFiltersSectionIt._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarSimilaritySectionIt
      similaritySection =
      _TranslationsAdvancedDiffSidebarSimilaritySectionIt._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarStatusSectionIt statusSection =
      _TranslationsAdvancedDiffSidebarStatusSectionIt._(_root);
}

// Path: issueDetails.duplicateValue
class _TranslationsIssueDetailsDuplicateValueIt
    implements TranslationsIssueDetailsDuplicateValueEn {
  _TranslationsIssueDetailsDuplicateValueIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'TRADUZIONE RIPETUTA';
  @override
  String get warning =>
      'Diversi testi sorgente usano questa stessa traduzione. Controlla il contesto.';
  @override
  String affectedKeys({required Object count}) =>
      'CHIAVI INTERESSATE (${count})';
  @override
  String get identicalSources => 'Sorgenti Identiche';
  @override
  String moreKeys({required Object count}) => '+altre ${count} chiavi';
}

// Path: issueDetails.lengthOutlier
class _TranslationsIssueDetailsLengthOutlierIt
    implements TranslationsIssueDetailsLengthOutlierEn {
  _TranslationsIssueDetailsLengthOutlierIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get source => 'SORGENTE';
  @override
  String get translation => 'TRADUZIONE';
  @override
  String chars({required Object count}) => '${count} caratt.';
}

// Path: issueDetails.standard
class _TranslationsIssueDetailsStandardIt
    implements TranslationsIssueDetailsStandardEn {
  _TranslationsIssueDetailsStandardIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'CHIAVE';
  @override
  String get sourceText => 'TESTO SORGENTE';
  @override
  String get translation => 'TRADUZIONE';
  @override
  String get errorDetails => 'DETTAGLI ERRORE';
  @override
  String get note => 'NOTA';
}

// Path: issueDetails.types
class _TranslationsIssueDetailsTypesIt
    implements TranslationsIssueDetailsTypesEn {
  _TranslationsIssueDetailsTypesIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get duplicateValue => 'Valori Duplicati';
  @override
  String get lengthOutlier => 'Discrepanza Lunghezza';
  @override
  String get placeholderMismatch => 'Segnaposto Danneggiati';
}

// Path: issueDetails.notes
class _TranslationsIssueDetailsNotesIt
    implements TranslationsIssueDetailsNotesEn {
  _TranslationsIssueDetailsNotesIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get placeholderMismatch =>
      'Marcatori come {name} dovrebbero corrispondere alla sorgente.';
  @override
  String get lengthOutlier =>
      'Grandi cambiamenti di lunghezza possono influenzare come il testo si adatta allo schermo.';
  @override
  String get duplicateValue =>
      'La stessa traduzione è usata per diverse chiavi.';
}

// Path: issueDetails.fallbacks
class _TranslationsIssueDetailsFallbacksIt
    implements TranslationsIssueDetailsFallbacksEn {
  _TranslationsIssueDetailsFallbacksIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get multipleSources => 'Più testi sorgente';
  @override
  String get sourceNotAvailable => 'Testo sorgente non disponibile';
  @override
  String get sharedTranslationNotAvailable =>
      'Traduzione condivisa non disponibile';
  @override
  String get translationNotAvailable => 'Traduzione non disponibile';
}

// Path: compare.tabs
class _TranslationsCompareTabsIt implements TranslationsCompareTabsEn {
  _TranslationsCompareTabsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get files => 'File';
  @override
  String get directories => 'Cartelle';
  @override
  String get git => 'Git';
}

// Path: compare.fileTypes
class _TranslationsCompareFileTypesIt
    implements TranslationsCompareFileTypesEn {
  _TranslationsCompareFileTypesIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get json => 'File di localizzazione JSON (i18next, Flutter, ecc.)';
  @override
  String get yaml => 'File di localizzazione YAML (Rails, Flutter)';
  @override
  String get xml => 'File di localizzazione XML (Android, .NET)';
  @override
  String get properties => 'File properties (Java)';
  @override
  String get resx => 'File RESX (.NET)';
  @override
  String get xliff => 'File XLIFF';
}

// Path: history.timeAgo
class _TranslationsHistoryTimeAgoIt implements TranslationsHistoryTimeAgoEn {
  _TranslationsHistoryTimeAgoIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get justNow => 'proprio ora';
  @override
  String secondsAgo({required Object count}) => '${count} secondi fa';
  @override
  String get oneMinuteAgo => '1 minuto fa';
  @override
  String minutesAgo({required Object count}) => '${count} minuti fa';
  @override
  String get oneHourAgo => '1 ora fa';
  @override
  String hoursAgo({required Object count}) => '${count} ore fa';
  @override
  String get yesterday => 'ieri';
  @override
  String daysAgo({required Object count}) => '${count} giorni fa';
  @override
  String get oneWeekAgo => '1 settimana fa';
  @override
  String weeksAgo({required Object count}) => '${count} settimane fa';
  @override
  String get oneMonthAgo => '1 mese fa';
  @override
  String monthsAgo({required Object count}) => '${count} mesi fa';
  @override
  String get oneYearAgo => '1 anno fa';
  @override
  String yearsAgo({required Object count}) => '${count} anni fa';
  @override
  String get inTheFuture => 'nel futuro';
}

// Path: projects.stats
class _TranslationsProjectsStatsIt implements TranslationsProjectsStatsEn {
  _TranslationsProjectsStatsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get empty => 'Progetto vuoto';
  @override
  String files({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
        n,
        one: '1 file di traduzione',
        other: '${count} file di traduzione',
      );
  @override
  String languages({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
        n,
        one: '1 lingua',
        other: '${count} lingue',
      );
}

// Path: projects.selection
class _TranslationsProjectsSelectionIt
    implements TranslationsProjectsSelectionEn {
  _TranslationsProjectsSelectionIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get selectFolder => 'Seleziona Cartella Progetto';
  @override
  String get selectArchive => 'Seleziona Archivio Progetto';
  @override
  String get openProject => 'Apri Progetto';
  @override
  String get browseFolder => 'Sfoglia Cartella...';
  @override
  String get createNew => 'Crea Nuovo';
  @override
  String get importFromZip => 'Importa da Zip...';
}

// Path: projects.createDialog
class _TranslationsProjectsCreateDialogIt
    implements TranslationsProjectsCreateDialogEn {
  _TranslationsProjectsCreateDialogIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Crea Progetto';
  @override
  String get description =>
      'Un progetto ti permette di salvare impostazioni personalizzate per una cartella specifica. Verrà creata una cartella ".localizer" per memorizzare la configurazione del progetto.';
  @override
  String get folderLabel => 'Cartella Progetto';
  @override
  String get folderHint => 'Clicca per selezionare la cartella...';
  @override
  String get nameLabel => 'Nome Progetto';
  @override
  String get nameHint => 'es., Traduzioni Mia App';
  @override
  String get selectFolderWarning => 'Seleziona una cartella progetto.';
  @override
  String get enterNameError => 'Inserisci un nome progetto';
  @override
  String get nameLengthError => 'Il nome deve essere di almeno 2 caratteri';
  @override
  String success({required Object name}) =>
      'Progetto "${name}" creato con successo!';
  @override
  String get failure => 'Impossibile creare il progetto.';
  @override
  String get creating => 'Creazione...';
  @override
  String get createAction => 'Crea Progetto';
}

// Path: projects.indicator
class _TranslationsProjectsIndicatorIt
    implements TranslationsProjectsIndicatorEn {
  _TranslationsProjectsIndicatorIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get tooltipNoProject =>
      'Crea un progetto per salvare impostazioni personalizzate per una cartella';
  @override
  String tooltipProject({required Object name}) =>
      'Progetto: ${name}\nClicca per vedere le opzioni';
  @override
  String get location => 'Posizione';
  @override
  String get created => 'Creato';
  @override
  String get switchProject => 'Cambia Progetto';
  @override
  String get done => 'Fatto';
}

// Path: projects.glossary
class _TranslationsProjectsGlossaryIt
    implements TranslationsProjectsGlossaryEn {
  _TranslationsProjectsGlossaryIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Glossario Progetto';
  @override
  String get description =>
      'Definisci i termini che devono essere trattati in modo coerente o mai tradotti.';
  @override
  String get noTerms => 'Ancora nessun termine nel glossario.';
  @override
  String get noTermsDesc =>
      'Aggiungi termini che devono rimanere coerenti tra le traduzioni,\no contrassegna i nomi dei brand che non devono mai essere tradotti.';
  @override
  String get doNotTranslate => 'Non tradurre';
  @override
  String get noSpecificTranslation => 'Nessuna traduzione specifica';
  @override
  String get addTerm => 'Aggiungi Termine';
  @override
  String get editTerm => 'Modifica Termine';
  @override
  String get term => 'Termine';
  @override
  String get termHint => 'es., nome brand, termine specialistico';
  @override
  String get definition => 'Definizione (Opzionale)';
  @override
  String get definitionHint => 'Contesto per il traduttore';
  @override
  String get doNotTranslateLabel => 'Non Tradurre';
  @override
  String get doNotTranslateDesc =>
      'Mantieni il termine esattamente com\'è nella destinazione';
  @override
  String get preferredTranslation => 'Traduzione Preferita';
  @override
  String get caseSensitive => 'Case Sensitive';
}

// Path: projects.conflicts
class _TranslationsProjectsConflictsIt
    implements TranslationsProjectsConflictsEn {
  _TranslationsProjectsConflictsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String missingApiKeyTitle({required Object service}) =>
      'Chiave API mancante per ${service}';
  @override
  String missingApiKeyMessage({required Object service}) =>
      'Questo progetto usa ${service} ma non è configurata alcuna chiave API. Aggiungi la tua chiave API in Impostazioni > Servizi AI, altrimenti l\'app userà il predefinito globale.';
  @override
  String get dismiss => 'Ignora';
}

// Path: projects.tm
class _TranslationsProjectsTmIt implements TranslationsProjectsTmEn {
  _TranslationsProjectsTmIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Memorie di Traduzione';
  @override
  String get description =>
      'Gestisci le sorgenti della memoria di traduzione per questo progetto.';
  @override
  String get globalTm => 'Memoria di Traduzione Globale';
  @override
  String get globalTmDescription =>
      'Usa la memoria di traduzione condivisa dalle impostazioni dell\'app';
  @override
  String get linkedFiles => 'File Collegati (Specifici del Progetto)';
  @override
  String get noLinkedFiles => 'Nessun file specifico del progetto collegato.';
  @override
  String get addTmFile => 'Aggiungi File TM';
  @override
  String get useGlobalTm => 'Usa TM Globale';
  @override
  String get selectTm => 'Seleziona Memoria di Traduzione';
  @override
  String get globalTmEnabled => 'Memoria di Traduzione Globale abilitata';
}

// Path: git.conflicts
class _TranslationsGitConflictsIt implements TranslationsGitConflictsEn {
  _TranslationsGitConflictsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Rilevati Conflitti di Merge';
  @override
  String get description =>
      'Devi risolvere questi conflitti prima di poter continuare.';
  @override
  String get abortMergeTitle => 'Annullare Merge?';
  @override
  String get abortMergeContent =>
      'Questo annullerà tutte le modifiche del merge e tornerà allo stato precedente. L\'azione è irreversibile.';
  @override
  String get abortMergeAction => 'Annulla Merge';
  @override
  String stagingFile({required Object file}) =>
      'Messa in staging di ${file} per il commit...';
  @override
  String conflictedFilesCount({required Object count}) =>
      'File in Conflitto (${count})';
  @override
  String get selectFileToResolve => 'Seleziona un file da risolvere';
  @override
  String resolvingFile({required Object file}) => 'Risoluzione: ${file}';
  @override
  String get keepAllOurs => 'Mantieni Tutto Nostro (Ours)';
  @override
  String get acceptAllTheirs => 'Accetta Tutto Loro (Theirs)';
  @override
  String get allResolved =>
      'Tutti i conflitti in questo file sono stati risolti!';
  @override
  String get markResolved => 'Segna come Risolto';
  @override
  String get stageForCommit =>
      'Questo metterà il file in staging per il commit.';
  @override
  String conflictIndex({required Object index}) => 'Conflitto #${index}';
  @override
  String get ours => 'NOSTRO (Corrente)';
  @override
  String get theirs => 'LORO (In arrivo)';
  @override
  String get keepOurs => 'Mantieni Nostro';
  @override
  String get acceptTheirs => 'Accetta Loro';
  @override
  String get empty => '(Vuoto)';
}

// Path: wizards.firstRun
class _TranslationsWizardsFirstRunIt implements TranslationsWizardsFirstRunEn {
  _TranslationsWizardsFirstRunIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get welcome => 'Benvenuto in Localizer';
  @override
  String get description =>
      'Confronta i tuoi file di localizzazione in pochi secondi.';
  @override
  String get sourceFile => 'File Sorgente';
  @override
  String get targetFile => 'File Target';
  @override
  String get compareNow => 'Confronta Ora';
  @override
  String get trySample => 'Prova con Dati di Esempio';
  @override
  String get skip => 'Salta Configurazione';
  @override
  String get browse => 'Clicca per sfogliare';
  @override
  String error({required Object error}) =>
      'Impossibile caricare i dati di esempio: ${error}';
}

// Path: dialogs.addIgnorePattern
class _TranslationsDialogsAddIgnorePatternIt
    implements TranslationsDialogsAddIgnorePatternEn {
  _TranslationsDialogsAddIgnorePatternIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Aggiungi Pattern da Ignorare';
  @override
  String get patternLabel => 'Pattern (regex)';
  @override
  String get hint => 'es., ^temp_.*';
  @override
  String get invalid => 'Pattern regex non valido';
  @override
  String get testStringLabel => 'Stringa di Test';
  @override
  String get testHint => 'Inserisci una chiave da testare contro il pattern';
  @override
  String get match => '✓ Il pattern corrisponde alla stringa di test';
  @override
  String get noMatch => '✗ Il pattern non corrisponde';
  @override
  String get add => 'Aggiungi';
  @override
  String get cancel => 'Annulla';
}

// Path: dialogs.diffViewer
class _TranslationsDialogsDiffViewerIt
    implements TranslationsDialogsDiffViewerEn {
  _TranslationsDialogsDiffViewerIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Visualizzatore Diff';
  @override
  String get originalFile => 'File Originale/di riferimento';
  @override
  String get translationFile => 'File di Traduzione/Confronto';
  @override
  String get base => 'BASE';
  @override
  String get target => 'TARGET';
  @override
  String get added => 'Aggiunto';
  @override
  String get removed => 'Rimosso';
  @override
  String get modified => 'Modificato';
  @override
  String get noMatches => 'Nessuna voce corrisponde ai filtri attuali';
  @override
  String get clickToggle => 'Clicca sui badge sopra per attivare i filtri';
  @override
  String get clickToHide => '(clicca per nascondere)';
  @override
  String get clickToShow => '(clicca per mostrare)';
}

// Path: grid.columns
class _TranslationsGridColumnsIt implements TranslationsGridColumnsEn {
  _TranslationsGridColumnsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'Chiave';
  @override
  String get source => 'Sorgente';
  @override
  String get status => 'Stato';
  @override
  String get actions => 'Azioni';
}

// Path: tutorial.steps
class _TranslationsTutorialStepsIt implements TranslationsTutorialStepsEn {
  _TranslationsTutorialStepsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTutorialStepsImportSourceIt importSource =
      _TranslationsTutorialStepsImportSourceIt._(_root);
  @override
  late final _TranslationsTutorialStepsImportTargetIt importTarget =
      _TranslationsTutorialStepsImportTargetIt._(_root);
  @override
  late final _TranslationsTutorialStepsCompareIt compare =
      _TranslationsTutorialStepsCompareIt._(_root);
  @override
  late final _TranslationsTutorialStepsFilterIt filter =
      _TranslationsTutorialStepsFilterIt._(_root);
  @override
  late final _TranslationsTutorialStepsSearchIt search =
      _TranslationsTutorialStepsSearchIt._(_root);
  @override
  late final _TranslationsTutorialStepsAdvancedIt advanced =
      _TranslationsTutorialStepsAdvancedIt._(_root);
  @override
  late final _TranslationsTutorialStepsExportIt export =
      _TranslationsTutorialStepsExportIt._(_root);
}

// Path: friendlyErrors.fileNotFound
class _TranslationsFriendlyErrorsFileNotFoundIt
    implements TranslationsFriendlyErrorsFileNotFoundEn {
  _TranslationsFriendlyErrorsFileNotFoundIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Impossibile trovare il file o la cartella.';
  @override
  String get suggestion => 'Verifica se il file è stato spostato o eliminato.';
}

// Path: friendlyErrors.accessDenied
class _TranslationsFriendlyErrorsAccessDeniedIt
    implements TranslationsFriendlyErrorsAccessDeniedEn {
  _TranslationsFriendlyErrorsAccessDeniedIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Accesso al file negato.';
  @override
  String get suggestion =>
      'Prova ad avviare l\'app come amministratore o controlla i permessi del file.';
}

// Path: friendlyErrors.isDirectory
class _TranslationsFriendlyErrorsIsDirectoryIt
    implements TranslationsFriendlyErrorsIsDirectoryEn {
  _TranslationsFriendlyErrorsIsDirectoryIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'È stata selezionata una cartella invece di un file.';
  @override
  String get suggestion => 'Seleziona un file valido.';
}

// Path: friendlyErrors.fileAccess
class _TranslationsFriendlyErrorsFileAccessIt
    implements TranslationsFriendlyErrorsFileAccessEn {
  _TranslationsFriendlyErrorsFileAccessIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Si è verificato un problema nell\'accesso al file.';
  @override
  String get suggestion =>
      'Prova a chiudere altri programmi che potrebbero usarlo.';
}

// Path: friendlyErrors.unsupportedFormat
class _TranslationsFriendlyErrorsUnsupportedFormatIt
    implements TranslationsFriendlyErrorsUnsupportedFormatEn {
  _TranslationsFriendlyErrorsUnsupportedFormatIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Questo formato di file o operazione non è supportato.';
  @override
  String get suggestion =>
      'Controlla l\'estensione del file o prova un formato diverso.';
}

// Path: friendlyErrors.networkError
class _TranslationsFriendlyErrorsNetworkErrorIt
    implements TranslationsFriendlyErrorsNetworkErrorEn {
  _TranslationsFriendlyErrorsNetworkErrorIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Impossibile connettersi al server.';
  @override
  String get suggestion => 'Controlla la tua connessione internet e riprova.';
}

// Path: friendlyErrors.notGitRepo
class _TranslationsFriendlyErrorsNotGitRepoIt
    implements TranslationsFriendlyErrorsNotGitRepoEn {
  _TranslationsFriendlyErrorsNotGitRepoIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Questa cartella non è un progetto Git.';
  @override
  String get suggestion =>
      'Naviga in una cartella che contiene una directory .git.';
}

// Path: friendlyErrors.mergeConflict
class _TranslationsFriendlyErrorsMergeConflictIt
    implements TranslationsFriendlyErrorsMergeConflictEn {
  _TranslationsFriendlyErrorsMergeConflictIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Ci sono conflitti di merge nel repository.';
  @override
  String get suggestion => 'Risolvi i conflitti prima di continuare.';
}

// Path: friendlyErrors.gitAuthFailed
class _TranslationsFriendlyErrorsGitAuthFailedIt
    implements TranslationsFriendlyErrorsGitAuthFailedEn {
  _TranslationsFriendlyErrorsGitAuthFailedIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Autenticazione Git fallita.';
  @override
  String get suggestion =>
      'Controlla le tue credenziali in Impostazioni > Version Control.';
}

// Path: friendlyErrors.gitOperationFailed
class _TranslationsFriendlyErrorsGitOperationFailedIt
    implements TranslationsFriendlyErrorsGitOperationFailedEn {
  _TranslationsFriendlyErrorsGitOperationFailedIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Un\'operazione Git è fallita.';
  @override
  String get suggestion => 'Controlla la vista Git per maggiori dettagli.';
}

// Path: friendlyErrors.invalidJson
class _TranslationsFriendlyErrorsInvalidJsonIt
    implements TranslationsFriendlyErrorsInvalidJsonEn {
  _TranslationsFriendlyErrorsInvalidJsonIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Il formato del file non è valido o è corrotto.';
  @override
  String get suggestion =>
      'Assicurati che il file contenga contenuto JSON valido.';
}

// Path: friendlyErrors.rateLimitReached
class _TranslationsFriendlyErrorsRateLimitReachedIt
    implements TranslationsFriendlyErrorsRateLimitReachedEn {
  _TranslationsFriendlyErrorsRateLimitReachedIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Limite di traduzione raggiunto.';
  @override
  String get suggestion =>
      'Attendi qualche minuto o controlla i limiti del tuo piano API.';
}

// Path: friendlyErrors.invalidApiKey
class _TranslationsFriendlyErrorsInvalidApiKeyIt
    implements TranslationsFriendlyErrorsInvalidApiKeyEn {
  _TranslationsFriendlyErrorsInvalidApiKeyIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Chiave API non valida.';
  @override
  String get suggestion =>
      'Vai in Impostazioni > Traduzione AI per aggiornare la tua chiave API.';
}

// Path: friendlyErrors.translationServiceError
class _TranslationsFriendlyErrorsTranslationServiceErrorIt
    implements TranslationsFriendlyErrorsTranslationServiceErrorEn {
  _TranslationsFriendlyErrorsTranslationServiceErrorIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Errore del servizio di traduzione.';
  @override
  String get suggestion =>
      'Controlla la tua chiave API e la connessione internet.';
}

// Path: friendlyErrors.outOfMemory
class _TranslationsFriendlyErrorsOutOfMemoryIt
    implements TranslationsFriendlyErrorsOutOfMemoryEn {
  _TranslationsFriendlyErrorsOutOfMemoryIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Memoria insufficiente per completare l\'operazione.';
  @override
  String get suggestion =>
      'Prova a chiudere altre applicazioni o usa file più piccoli.';
}

// Path: friendlyErrors.genericError
class _TranslationsFriendlyErrorsGenericErrorIt
    implements TranslationsFriendlyErrorsGenericErrorEn {
  _TranslationsFriendlyErrorsGenericErrorIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Qualcosa è andato storto.';
  @override
  String get suggestion => 'Riprova. Se il problema persiste, riavvia l\'app.';
}

// Path: diffTable.columns
class _TranslationsDiffTableColumnsIt
    implements TranslationsDiffTableColumnsEn {
  _TranslationsDiffTableColumnsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get id => '#';
  @override
  String get status => 'Status';
  @override
  String get key => 'Key';
  @override
  String get source => 'Source';
  @override
  String get target => 'Target';
}

// Path: diffTable.pagination
class _TranslationsDiffTablePaginationIt
    implements TranslationsDiffTablePaginationEn {
  _TranslationsDiffTablePaginationIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get show => 'Show';
}

// Path: diffTable.messages
class _TranslationsDiffTableMessagesIt
    implements TranslationsDiffTableMessagesEn {
  _TranslationsDiffTableMessagesIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get addedToTM => 'Added to Translation Memory';
  @override
  String get reverted => 'Entry reverted';
  @override
  String get deleted => 'Entry deleted';
  @override
  String get appliedAndAdded => 'Applied and added to Translation Memory';
}

// Path: diffTable.editDialog
class _TranslationsDiffTableEditDialogIt
    implements TranslationsDiffTableEditDialogEn {
  _TranslationsDiffTableEditDialogIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object key}) => 'Edit: ${key}';
  @override
  String get sourceLabel => 'Source';
  @override
  String get targetLabel => 'Target';
  @override
  String get hint => 'Enter translation...';
  @override
  String get cancel => 'Cancel';
  @override
  String get applyAndAdd => 'Apply & Add to TM';
  @override
  String get apply => 'Apply';
}

// Path: onboarding.steps
class _TranslationsOnboardingStepsIt implements TranslationsOnboardingStepsEn {
  _TranslationsOnboardingStepsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsOnboardingStepsImportFilesIt importFiles =
      _TranslationsOnboardingStepsImportFilesIt._(_root);
  @override
  late final _TranslationsOnboardingStepsRunComparisonIt runComparison =
      _TranslationsOnboardingStepsRunComparisonIt._(_root);
  @override
  late final _TranslationsOnboardingStepsReviewMissingIt reviewMissing =
      _TranslationsOnboardingStepsReviewMissingIt._(_root);
  @override
  late final _TranslationsOnboardingStepsUseFiltersIt useFilters =
      _TranslationsOnboardingStepsUseFiltersIt._(_root);
  @override
  late final _TranslationsOnboardingStepsSearchResultsIt searchResults =
      _TranslationsOnboardingStepsSearchResultsIt._(_root);
  @override
  late final _TranslationsOnboardingStepsAdvancedViewIt advancedView =
      _TranslationsOnboardingStepsAdvancedViewIt._(_root);
  @override
  late final _TranslationsOnboardingStepsEditCellIt editCell =
      _TranslationsOnboardingStepsEditCellIt._(_root);
  @override
  late final _TranslationsOnboardingStepsExportResultsIt exportResults =
      _TranslationsOnboardingStepsExportResultsIt._(_root);
}

// Path: settings.appearance.presets
class _TranslationsSettingsAppearancePresetsIt
    implements TranslationsSettingsAppearancePresetsEn {
  _TranslationsSettingsAppearancePresetsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get presetDefault => 'Predefinito';
  @override
  String get presetColorblind => 'Per daltonici';
  @override
  String get presetHighContrast => 'Contrasto elevato';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.appearance.preview
class _TranslationsSettingsAppearancePreviewIt
    implements TranslationsSettingsAppearancePreviewEn {
  _TranslationsSettingsAppearancePreviewIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get step3Title => 'onboarding.step3.title';
  @override
  String get connectAccount => '"Collega il tuo account"';
  @override
  String get loginHint => 'deprecated.login_hint_v1';
  @override
  String get enterCredentials => '"Inserisci credenziali"';
  @override
  String get ctaButton => 'checkout.cta_button';
  @override
  String get buyNow => '"Acquista ora"';
  @override
  String get completePurchase => '"Completa acquisto"';
  @override
  String get appNameKey => 'common.app_name';
  @override
  String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class _TranslationsSettingsComparisonPatternPresetsIt
    implements TranslationsSettingsComparisonPatternPresetsEn {
  _TranslationsSettingsComparisonPatternPresetsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get comments => 'Commenti';
  @override
  String get tempKeys => 'Chiavi Temporanee';
  @override
  String get placeholders => 'Segnaposto';
  @override
  String get devOnly => 'Solo Sviluppo';
}

// Path: settings.comparison.previewMatch
class _TranslationsSettingsComparisonPreviewMatchIt
    implements TranslationsSettingsComparisonPreviewMatchEn {
  _TranslationsSettingsComparisonPreviewMatchIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Anteprima Accoppiamento';
  @override
  String get description =>
      'Verifica come le impostazioni attuali influenzano la logica di accoppiamento.';
  @override
  String get stringA => 'Stringa A';
  @override
  String get stringB => 'Stringa B';
  @override
  String get enterText => 'Inserisci testo...';
  @override
  String get similarity => 'Somiglianza';
  @override
  String get identical => 'Identiche';
  @override
  String get identicalDescription =>
      'Le stringhe corrispondono esattamente dopo la normalizzazione.';
  @override
  String get ignored => 'Ignorate';
  @override
  String get ignoredDescription =>
      'L\'input corrisponde a un pattern da ignorare.';
  @override
  String get different => 'Diverse';
  @override
  String get differentDescription => 'Un valore è vuoto.';
  @override
  String get similarModified => 'Simili / Modificate';
  @override
  String similarModifiedDescription({required Object threshold}) =>
      'Il punteggio di corrispondenza è superiore alla soglia (${threshold}%).';
  @override
  String get newDifferent => 'Nuove / Diverse';
  @override
  String newDifferentDescription({required Object threshold}) =>
      'Il punteggio di corrispondenza è inferiore alla soglia (${threshold}%).';
}

// Path: settings.comparison.colorPresets
class _TranslationsSettingsComparisonColorPresetsIt
    implements TranslationsSettingsComparisonColorPresetsEn {
  _TranslationsSettingsComparisonColorPresetsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get kDefault => 'Predefinito';
  @override
  String get colorblindFriendly => 'Per daltonici';
  @override
  String get highContrast => 'Contrasto elevato';
  @override
  String get nord => 'Nord';
  @override
  String get solarized => 'Solarized';
  @override
  String get monokai => 'Monokai';
  @override
  String get presetDefault => 'Predefinito';
  @override
  String get presetColorblind => 'Per daltonici';
  @override
  String get presetHighContrast => 'Contrasto elevato';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.integrations.materials
class _TranslationsSettingsIntegrationsMaterialsIt
    implements TranslationsSettingsIntegrationsMaterialsEn {
  _TranslationsSettingsIntegrationsMaterialsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get sidebar => 'Barra laterale';
  @override
  String get menu => 'Menu';
  @override
  String get popover => 'Popover';
  @override
  String get titlebar => 'Barra del titolo';
  @override
  String get underPageBackground => 'Sfondo Pagina';
  @override
  String get contentBackground => 'Contenuto';
}

// Path: settings.integrations.fileTypes
class _TranslationsSettingsIntegrationsFileTypesIt
    implements TranslationsSettingsIntegrationsFileTypesEn {
  _TranslationsSettingsIntegrationsFileTypesIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get loc => 'File Progetto Localizer';
  @override
  String get lang => 'File Lingua';
  @override
  String get json => 'File Localizzazione JSON';
  @override
  String get xml => 'File Localizzazione XML';
}

// Path: settings.developer.themePlaygroundSection
class _TranslationsSettingsDeveloperThemePlaygroundSectionIt
    implements TranslationsSettingsDeveloperThemePlaygroundSectionEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get colors => 'Colori';
  @override
  String get typography => 'Tipografia';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteIt
      palette =
      _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteIt._(_root);
}

// Path: settings.developer.featureFlags
class _TranslationsSettingsDeveloperFeatureFlagsIt
    implements TranslationsSettingsDeveloperFeatureFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Funzionalità Sperimentali';
  @override
  String get description =>
      'Attiva i flag delle funzionalità localmente per il test. Queste impostazioni persistono al riavvio dell\'app.';
  @override
  String get subtitle => 'Sovrascrivi funzionalità sperimentali';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsIt flags =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsIt._(_root);
  @override
  String get reset => 'Ripristina Tutti i Flag';
  @override
  String get overrides => 'Sovrascritture Locali';
  @override
  String get defaultVal => 'Predefinito';
  @override
  String get on => 'ON';
  @override
  String get off => 'OFF';
}

// Path: settings.developer.storageInspectorSection
class _TranslationsSettingsDeveloperStorageInspectorSectionIt
    implements TranslationsSettingsDeveloperStorageInspectorSectionEn {
  _TranslationsSettingsDeveloperStorageInspectorSectionIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'Aggiorna';
  @override
  String get hiveData => 'Dati Hive';
  @override
  String get secureStorage => 'Secure Storage';
}

// Path: settings.developer.deviceInfoSection
class _TranslationsSettingsDeveloperDeviceInfoSectionIt
    implements TranslationsSettingsDeveloperDeviceInfoSectionEn {
  _TranslationsSettingsDeveloperDeviceInfoSectionIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'Aggiorna';
  @override
  String get copy => 'Copia negli appunti';
  @override
  String get computerName => 'Nome Computer';
  @override
  String get osVersion => 'Versione OS';
}

// Path: settings.developer.localizationInspectorSection
class _TranslationsSettingsDeveloperLocalizationInspectorSectionIt
    implements TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
  _TranslationsSettingsDeveloperLocalizationInspectorSectionIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get showKeys => 'Mostra Chiavi Invece dei Valori';
  @override
  String get keysVisible => 'Chiavi visibili';
  @override
  String get normalDisplay => 'Visualizzazione normale';
  @override
  String get note =>
      'Nota: questa funzione richiede che la localizzazione dell\'app utilizzi un wrapper che rispetti questa impostazione.';
}

// Path: settings.onboarding.steps
class _TranslationsSettingsOnboardingStepsIt
    implements TranslationsSettingsOnboardingStepsEn {
  _TranslationsSettingsOnboardingStepsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsOnboardingStepsImportFilesIt importFiles =
      _TranslationsSettingsOnboardingStepsImportFilesIt._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsRunComparisonIt runComparison =
      _TranslationsSettingsOnboardingStepsRunComparisonIt._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsReviewMissingIt reviewMissing =
      _TranslationsSettingsOnboardingStepsReviewMissingIt._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsUseFiltersIt useFilters =
      _TranslationsSettingsOnboardingStepsUseFiltersIt._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsSearchResultsIt searchResults =
      _TranslationsSettingsOnboardingStepsSearchResultsIt._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsAdvancedViewIt advancedView =
      _TranslationsSettingsOnboardingStepsAdvancedViewIt._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsEditCellIt editCell =
      _TranslationsSettingsOnboardingStepsEditCellIt._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsExportResultsIt exportResults =
      _TranslationsSettingsOnboardingStepsExportResultsIt._(_root);
}

// Path: settings.settingsView.categories
class _TranslationsSettingsSettingsViewCategoriesIt
    implements TranslationsSettingsSettingsViewCategoriesEn {
  _TranslationsSettingsSettingsViewCategoriesIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'Impostazioni Generali';
  @override
  String get comparisonEngine => 'Motore di Confronto';
  @override
  String get appearance => 'Aspetto';
  @override
  String get fileHandling => 'Gestione File';
  @override
  String get aiServices => 'Servizi AI';
  @override
  String get systemIntegrations => 'Integrazioni di Sistema';
  @override
  String get projectResources => 'Risorse Progetto (Glossario e TM)';
  @override
  String get developer => 'Opzioni Sviluppatore';
  @override
  String get about => 'Informazioni';
}

// Path: settings.settingsView.categoryLabels
class _TranslationsSettingsSettingsViewCategoryLabelsIt
    implements TranslationsSettingsSettingsViewCategoryLabelsEn {
  _TranslationsSettingsSettingsViewCategoryLabelsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'Generale';
  @override
  String get comparisonEngine => 'Confronto';
  @override
  String get appearance => 'Aspetto';
  @override
  String get fileHandling => 'Gestione File';
  @override
  String get aiServices => 'Servizi AI';
  @override
  String get systemIntegrations => 'Integrazioni di Sistema';
  @override
  String get projectResources => 'Risorse Progetto';
  @override
  String get developer => 'Opzioni Sviluppatore';
  @override
  String get about => 'Informazioni';
}

// Path: advancedDiff.sidebar.actionsSection
class _TranslationsAdvancedDiffSidebarActionsSectionIt
    implements TranslationsAdvancedDiffSidebarActionsSectionEn {
  _TranslationsAdvancedDiffSidebarActionsSectionIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get exportMatches => 'Esporta corrispondenze';
  @override
  String get preview => 'Anteprima';
  @override
  String get fillFromTmTitle => 'Riempire dalla Memoria di Traduzione?';
  @override
  String get fillFromTmContent =>
      'Questo tenterà di riempire i valori di destinazione vuoti usando le corrispondenze della Memoria di Traduzione. I valori esistenti NON verranno sovrascritti.';
  @override
  String get fill => 'Riempi';
  @override
  String get fillFromMemory => 'Riempi dalla Memoria';
  @override
  String filledFromTm({required Object count}) =>
      'Riempiti ${count} elementi dalla Memoria di Traduzione.';
}

// Path: advancedDiff.sidebar.aiSection
class _TranslationsAdvancedDiffSidebarAiSectionIt
    implements TranslationsAdvancedDiffSidebarAiSectionEn {
  _TranslationsAdvancedDiffSidebarAiSectionIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get infoCloud =>
      'Usa la traduzione cloud per tradurre i valori di destinazione vuoti dalla sorgente.';
  @override
  String get infoAi =>
      'Usa l\'AI per tradurre i valori di destinazione vuoti dalla sorgente.';
  @override
  String get translationSettings => 'Impostazioni Traduzione';
  @override
  String get aiSettings => 'Impostazioni AI';
  @override
  String get source => 'Sorgente';
  @override
  String get target => 'Destinazione';
  @override
  String translatingProgress({required Object percent}) =>
      'Traduzione in corso... ${percent}%';
  @override
  String get translating => 'Traduzione in corso...';
  @override
  String get translateAllMissing => 'Traduci Tutti i Mancanti';
  @override
  String get translateAllTitle => 'Tradurre Tutti i Mancanti?';
  @override
  String translateAllContent(
          {required Object service,
          required Object source,
          required Object target}) =>
      'Questo userà ${service} per tradurre tutte le voci con valori di destinazione vuoti da ${source} a ${target}.\n\nYou can review ogni suggerimento o applicarli tutti in una volta.';
  @override
  String get translateAll => 'Traduci Tutto';
  @override
  String get reviewEach => 'Rivedi Singolarmente';
  @override
  String cloudTranslated({required Object count}) =>
      'Tradotte ${count} voci con la traduzione cloud.';
  @override
  String aiTranslated({required Object count}) =>
      'Tradotte ${count} voci con l\'AI.';
  @override
  String get aiTranslateFailed => 'Traduzione AI massiva fallita';
  @override
  String get noMissingEntries => 'Nessuna voce mancante da tradurre.';
  @override
  String get skip => 'Salta';
  @override
  String get stop => 'Ferma';
  @override
  String cloudApplied({required Object count}) =>
      'Applicati ${count} suggerimenti.';
  @override
  String aiApplied({required Object count}) =>
      'Applicati ${count} suggerimenti AI.';
}

// Path: advancedDiff.sidebar.tmSection
class _TranslationsAdvancedDiffSidebarTmSectionIt
    implements TranslationsAdvancedDiffSidebarTmSectionEn {
  _TranslationsAdvancedDiffSidebarTmSectionIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get enableTmFill => 'Abilita Riempimento TM';
  @override
  String get autoApplyAboveMinimum => 'Applica auto. sopra il minimo';
  @override
  String get matchSettings => 'Impostazioni Corrispondenza';
  @override
  String get minMatch => 'Match min:';
  @override
  String get limit => 'Limite:';
  @override
  String get exact => 'Esatto';
}

// Path: advancedDiff.sidebar.filtersSection
class _TranslationsAdvancedDiffSidebarFiltersSectionIt
    implements TranslationsAdvancedDiffSidebarFiltersSectionEn {
  _TranslationsAdvancedDiffSidebarFiltersSectionIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get viewFilters => 'Filtri Vista';
  @override
  String get showAll => 'Mostra Tutto';
  @override
  String get added => 'Aggiunti';
  @override
  String get removed => 'Rimossi';
  @override
  String get modified => 'Modificati';
  @override
  String get actionScope => 'Ambito Azione';
  @override
  String get applyToAdded => 'Applica ad Aggiunti';
  @override
  String get applyToModified => 'Applica a Modificati';
  @override
  String get onlyFillEmptyTargets => 'Riempi solo destinazioni vuote';
  @override
  String get limitToVisible => 'Limita al visibile';
  @override
  String get editMode => 'Modalità Modifica';
  @override
  String get dialog => 'Dialogo';
  @override
  String get inline => 'In riga';
}

// Path: advancedDiff.sidebar.similaritySection
class _TranslationsAdvancedDiffSidebarSimilaritySectionIt
    implements TranslationsAdvancedDiffSidebarSimilaritySectionEn {
  _TranslationsAdvancedDiffSidebarSimilaritySectionIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get currentFilter => 'Filtro Attuale:';
  @override
  String get any => 'QUALSIASI';
  @override
  String get high => 'ALTA';
  @override
  String get medium => 'MEDIA';
  @override
  String get low => 'BASSA';
}

// Path: advancedDiff.sidebar.statusSection
class _TranslationsAdvancedDiffSidebarStatusSectionIt
    implements TranslationsAdvancedDiffSidebarStatusSectionEn {
  _TranslationsAdvancedDiffSidebarStatusSectionIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String total({required Object count}) => '${count} totali';
  @override
  String extra({required Object count}) => '${count} extra';
  @override
  String missing({required Object count}) => '${count} mancanti';
  @override
  String changed({required Object count}) => '${count} modificati';
}

// Path: tutorial.steps.importSource
class _TranslationsTutorialStepsImportSourceIt
    implements TranslationsTutorialStepsImportSourceEn {
  _TranslationsTutorialStepsImportSourceIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => '1. Importa File Sorgente';
  @override
  String get description =>
      'Usa il pulsante sotto per sfogliare un file, o trascinalo nell\'area evidenziata.';
}

// Path: tutorial.steps.importTarget
class _TranslationsTutorialStepsImportTargetIt
    implements TranslationsTutorialStepsImportTargetEn {
  _TranslationsTutorialStepsImportTargetIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => '2. Importa File Target';
  @override
  String get description =>
      'Usa il pulsante sotto per sfogliare un file, o trascinalo nell\'area evidenziata.';
}

// Path: tutorial.steps.compare
class _TranslationsTutorialStepsCompareIt
    implements TranslationsTutorialStepsCompareEn {
  _TranslationsTutorialStepsCompareIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => '3. Confronta File';
  @override
  String get description =>
      'Tocca il pulsante sotto per avviare il confronto e vedere i risultati.';
}

// Path: tutorial.steps.filter
class _TranslationsTutorialStepsFilterIt
    implements TranslationsTutorialStepsFilterEn {
  _TranslationsTutorialStepsFilterIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => '4. Filtra i Risultati';
  @override
  String get description =>
      'Usa questi filtri per visualizzare le stringhe Aggiunte, Rimosse o Modificate.';
}

// Path: tutorial.steps.search
class _TranslationsTutorialStepsSearchIt
    implements TranslationsTutorialStepsSearchEn {
  _TranslationsTutorialStepsSearchIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => '5. Cerca nei Risultati';
  @override
  String get description =>
      'Trova chiavi o valori specifici usando la barra di ricerca.';
}

// Path: tutorial.steps.advanced
class _TranslationsTutorialStepsAdvancedIt
    implements TranslationsTutorialStepsAdvancedEn {
  _TranslationsTutorialStepsAdvancedIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => '6. Vista Avanzata';
  @override
  String get description =>
      'Apri la vista diff dettagliata con editing, traduzione AI e altro.';
}

// Path: tutorial.steps.export
class _TranslationsTutorialStepsExportIt
    implements TranslationsTutorialStepsExportEn {
  _TranslationsTutorialStepsExportIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => '7. Esporta Risultati';
  @override
  String get description =>
      'Salva il tuo confronto come file CSV, JSON o Excel.';
}

// Path: onboarding.steps.importFiles
class _TranslationsOnboardingStepsImportFilesIt
    implements TranslationsOnboardingStepsImportFilesEn {
  _TranslationsOnboardingStepsImportFilesIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Import Files';
  @override
  String get description =>
      'Load your source and target localization files to compare';
}

// Path: onboarding.steps.runComparison
class _TranslationsOnboardingStepsRunComparisonIt
    implements TranslationsOnboardingStepsRunComparisonEn {
  _TranslationsOnboardingStepsRunComparisonIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Run Comparison';
  @override
  String get description =>
      'Start comparing files to find differences and missing keys';
}

// Path: onboarding.steps.reviewMissing
class _TranslationsOnboardingStepsReviewMissingIt
    implements TranslationsOnboardingStepsReviewMissingEn {
  _TranslationsOnboardingStepsReviewMissingIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Review Missing';
  @override
  String get description => 'Check entries that are missing in the target file';
}

// Path: onboarding.steps.useFilters
class _TranslationsOnboardingStepsUseFiltersIt
    implements TranslationsOnboardingStepsUseFiltersEn {
  _TranslationsOnboardingStepsUseFiltersIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Use Filters';
  @override
  String get description =>
      'Filter results by status, category, or search term';
}

// Path: onboarding.steps.searchResults
class _TranslationsOnboardingStepsSearchResultsIt
    implements TranslationsOnboardingStepsSearchResultsEn {
  _TranslationsOnboardingStepsSearchResultsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Search Results';
  @override
  String get description =>
      'Use the search bar to find specific keys or translations';
}

// Path: onboarding.steps.advancedView
class _TranslationsOnboardingStepsAdvancedViewIt
    implements TranslationsOnboardingStepsAdvancedViewEn {
  _TranslationsOnboardingStepsAdvancedViewIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Advanced View';
  @override
  String get description =>
      'Switch to advanced view for detailed side-by-side comparison';
}

// Path: onboarding.steps.editCell
class _TranslationsOnboardingStepsEditCellIt
    implements TranslationsOnboardingStepsEditCellEn {
  _TranslationsOnboardingStepsEditCellIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Edit Entries';
  @override
  String get description => 'Click on a cell to edit translations directly';
}

// Path: onboarding.steps.exportResults
class _TranslationsOnboardingStepsExportResultsIt
    implements TranslationsOnboardingStepsExportResultsEn {
  _TranslationsOnboardingStepsExportResultsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Export Results';
  @override
  String get description => 'Save your changes or export comparison results';
}

// Path: settings.developer.themePlaygroundSection.palette
class _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteIt
    implements TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get primary => 'Primario';
  @override
  String get onPrimary => 'Su Primario';
  @override
  String get secondary => 'Secondario';
  @override
  String get onSecondary => 'Su Secondario';
  @override
  String get surface => 'Superficie';
  @override
  String get onSurface => 'Su Superficie';
  @override
  String get error => 'Errore';
  @override
  String get onError => 'Su Errore';
  @override
  String get outline => 'Contorno';
  @override
  String get shadow => 'Ombra';
  @override
  String get success => 'Successo';
  @override
  String get warning => 'Avviso';
  @override
  String get info => 'Info';
}

// Path: settings.developer.featureFlags.flags
class _TranslationsSettingsDeveloperFeatureFlagsFlagsIt
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchIt
      experimental_ai_batch =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchIt._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmIt
      new_diff_algorithm =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmIt._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchIt
      enhanced_search =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchIt._(_root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveIt
      auto_save =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveIt._(_root);
}

// Path: settings.onboarding.steps.importFiles
class _TranslationsSettingsOnboardingStepsImportFilesIt
    implements TranslationsSettingsOnboardingStepsImportFilesEn {
  _TranslationsSettingsOnboardingStepsImportFilesIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Importa File';
  @override
  String get description => 'Carica i file sorgente e di destinazione';
}

// Path: settings.onboarding.steps.runComparison
class _TranslationsSettingsOnboardingStepsRunComparisonIt
    implements TranslationsSettingsOnboardingStepsRunComparisonEn {
  _TranslationsSettingsOnboardingStepsRunComparisonIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Esegui Confronto';
  @override
  String get description => 'Fai clic su "Confronta File"';
}

// Path: settings.onboarding.steps.reviewMissing
class _TranslationsSettingsOnboardingStepsReviewMissingIt
    implements TranslationsSettingsOnboardingStepsReviewMissingEn {
  _TranslationsSettingsOnboardingStepsReviewMissingIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Controlla Chiavi Mancanti';
  @override
  String get description => 'Nota gli elementi rossi MANCANTI';
}

// Path: settings.onboarding.steps.useFilters
class _TranslationsSettingsOnboardingStepsUseFiltersIt
    implements TranslationsSettingsOnboardingStepsUseFiltersEn {
  _TranslationsSettingsOnboardingStepsUseFiltersIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Usa i Filtri';
  @override
  String get description => 'Filtra per tipo';
}

// Path: settings.onboarding.steps.searchResults
class _TranslationsSettingsOnboardingStepsSearchResultsIt
    implements TranslationsSettingsOnboardingStepsSearchResultsEn {
  _TranslationsSettingsOnboardingStepsSearchResultsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Risultati della Ricerca';
  @override
  String get description => 'Trova chiavi specifiche';
}

// Path: settings.onboarding.steps.advancedView
class _TranslationsSettingsOnboardingStepsAdvancedViewIt
    implements TranslationsSettingsOnboardingStepsAdvancedViewEn {
  _TranslationsSettingsOnboardingStepsAdvancedViewIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Vista Avanzata';
  @override
  String get description => 'Esplora l\'analisi dettagliata';
}

// Path: settings.onboarding.steps.editCell
class _TranslationsSettingsOnboardingStepsEditCellIt
    implements TranslationsSettingsOnboardingStepsEditCellEn {
  _TranslationsSettingsOnboardingStepsEditCellIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Modifica una Cella';
  @override
  String get description => 'Fai clic per modificare un valore';
}

// Path: settings.onboarding.steps.exportResults
class _TranslationsSettingsOnboardingStepsExportResultsIt
    implements TranslationsSettingsOnboardingStepsExportResultsEn {
  _TranslationsSettingsOnboardingStepsExportResultsIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Esporta';
  @override
  String get description => 'Salva il tuo report';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchIt
    implements
        TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchIt._(
      this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Batch AI Sperimentale';
  @override
  String get description => 'Abilita traduzione AI batch per più righe';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmIt
    implements
        TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmIt._(
      this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Nuovo Algoritmo Diff';
  @override
  String get description => 'Usa un algoritmo diff migliorato per i confronti';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchIt
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Ricerca Migliorata';
  @override
  String get description => 'Abilita ricerca fuzzy nei file di traduzione';
}

// Path: settings.developer.featureFlags.flags.auto_save
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveIt
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveIt._(this._root);

  final TranslationsIt _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Salvataggio Automatico';
  @override
  String get description =>
      'Salva automaticamente le modifiche dopo l\'editing';
}

/// The flat map containing all translations for locale <it>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsIt {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
          'app.title' => 'Strumento di Confronto Localizzazione',
          'app.name' => 'Localizer',
          'common.save' => 'Salva',
          'common.cancel' => 'Annulla',
          'common.close' => 'Chiudi',
          'common.delete' => 'Elimina',
          'common.edit' => 'Modifica',
          'common.add' => 'Aggiungi',
          'common.search' => 'Cerca',
          'common.undo' => 'Annulla',
          'common.loading' => 'Caricamento...',
          'common.error' => 'Errore',
          'common.success' => 'Successo',
          'common.warning' => 'Avviso',
          'common.info' => 'Info',
          'common.confirm' => 'Conferma',
          'common.yes' => 'Sì',
          'common.no' => 'No',
          'common.ok' => 'OK',
          'common.retry' => 'Riprova',
          'common.copyText' => 'Copia',
          'common.appName' => 'Localizer',
          'common.copied' => 'Copiato!',
          'common.enabled' => 'Abilitato',
          'common.disabled' => 'Disabilitato',
          'common.browse' => 'Sfoglia',
          'common.clear' => 'Cancella',
          'common.apply' => 'Applica',
          'common.reset' => 'Ripristina',
          'common.refresh' => 'Aggiorna',
          'common.export' => 'Esporta',
          'common.import' => 'Importa',
          'common.select' => 'Seleziona',
          'common.selectAll' => 'Seleziona tutto',
          'common.deselectAll' => 'Deseleziona tutto',
          'common.noResults' => 'Nessun risultato trovato',
          'common.emptyState' => 'Ancora nulla qui',
          'common.open' => 'Apri',
          'common.change' => 'Cambia',
          'common.original' => 'Originale',
          'common.kNew' => 'Nuovo',
          'common.remove' => 'Rimuovi',
          'common.auto' => 'Auto',
          'common.execute' => 'Esegui',
          'common.run' => 'Esegui',
          'common.unknown' => 'Sconosciuto',
          'common.download' => 'Scarica',
          'common.dropdownArrow' => 'Freccia a discesa',
          'common.openInNewWindow' => 'Apre in una nuova finestra',
          'common.resetToDefaults' => 'Ripristina predefiniti',
          'menu.file' => 'File',
          'menu.edit' => 'Modifica',
          'menu.view' => 'Visualizza',
          'menu.help' => 'Aiuto',
          'menu.openFiles' => 'Apri file...',
          'menu.openFolder' => 'Apri cartella...',
          'menu.exportResults' => 'Esporta risultati...',
          'menu.undo' => 'Annulla',
          'menu.redo' => 'Ripristina',
          'menu.cut' => 'Taglia',
          'menu.paste' => 'Incolla',
          'menu.selectAll' => 'Seleziona tutto',
          'menu.zoomIn' => 'Ingrandisci',
          'menu.zoomOut' => 'Rimpicciolisci',
          'menu.resetZoom' => 'Ripristina zoom',
          'menu.documentation' => 'Documentazione',
          'menu.reportIssue' => 'Segnala un problema',
          'menu.about' => ({required Object appName}) =>
              'Informazioni su ${appName}',
          'nav.compare' => 'Confronta',
          'nav.history' => 'Cronologia',
          'nav.settings' => 'Impostazioni',
          'nav.projects' => 'Progetti',
          'nav.dashboard' => 'Dashboard',
          'nav.directory' => 'Cartella',
          'nav.repository' => 'Repository',
          'nav.tooltipCompare' => 'Confronta file di localizzazione',
          'nav.tooltipHistory' => 'Visualizza cronologia confronti',
          'nav.tooltipSettings' => 'Impostazioni app',
          'nav.tooltipProjects' => 'Gestisci progetti',
          'nav.tooltipThemeToggle' => 'Attiva/disattiva tema',
          'nav.tooltipDebugConsole' => 'Console di debug',
          'settings.title' => 'Impostazioni',
          'settings.appSettings' => 'Impostazioni App',
          'settings.projectSettings' => 'Impostazioni Progetto',
          'settings.appearance.title' => 'Aspetto',
          'settings.appearance.description' =>
            'Personalizza l\'aspetto e l\'interfaccia dell\'app',
          'settings.appearance.theme' => 'Modalità Tema',
          'settings.appearance.themeDescription' =>
            'Scegli tra tema chiaro, scuro o di sistema',
          'settings.appearance.themeSystem' => 'Sistema',
          'settings.appearance.themeLight' => 'Chiaro',
          'settings.appearance.themeDark' => 'Scuro',
          'settings.appearance.themeAmoled' => 'AMOLED',
          'settings.appearance.accentColor' => 'Colore Accento',
          'settings.appearance.accentColorDescription' =>
            'Scegli il tuo colore accento preferito',
          'settings.appearance.useMicaEffect' => 'Usa Effetto Mica',
          'settings.appearance.micaDescription' =>
            'Abilità l\'effetto di trasparenza Mica di Windows 11 per un look moderno',
          'settings.appearance.diffFontSize' => 'Dimensione Carattere Diff',
          'settings.appearance.diffFontSizeDescription' =>
            'Regola la dimensione del carattere nella vista di confronto',
          'settings.appearance.diffFontFamily' => 'Famiglia Carattere Diff',
          'settings.appearance.diffFontFamilyDescription' =>
            'Carattere per la vista di confronto',
          'settings.appearance.systemDefault' => 'Predefinito di Sistema',
          'settings.appearance.pickAccentColor' => 'Scegli Colore Accento',
          'settings.appearance.diffColors' => 'Colori Diff',
          'settings.appearance.presetsTitle' => 'Predefiniti',
          'settings.appearance.presets.presetDefault' => 'Predefinito',
          'settings.appearance.presets.presetColorblind' => 'Per daltonici',
          'settings.appearance.presets.presetHighContrast' =>
            'Contrasto elevato',
          'settings.appearance.presets.presetNord' => 'Nord',
          'settings.appearance.presets.presetSolarized' => 'Solarized',
          'settings.appearance.presets.presetMonokai' => 'Monokai',
          'settings.appearance.identical' => 'Identico',
          'settings.appearance.pickColorFor' => ({required Object label}) =>
              'Scegli colore per ${label}',
          'settings.appearance.livePreview' => 'Anteprima dal vivo',
          'settings.appearance.preview.step3Title' => 'onboarding.step3.title',
          'settings.appearance.preview.connectAccount' =>
            '"Collega il tuo account"',
          'settings.appearance.preview.loginHint' => 'deprecated.login_hint_v1',
          'settings.appearance.preview.enterCredentials' =>
            '"Inserisci credenziali"',
          'settings.appearance.preview.ctaButton' => 'checkout.cta_button',
          'settings.appearance.preview.buyNow' => '"Acquista ora"',
          'settings.appearance.preview.completePurchase' =>
            '"Completa acquisto"',
          'settings.appearance.preview.appNameKey' => 'common.app_name',
          'settings.appearance.preview.appNameValue' => '"Localizer"',
          'settings.general.title' => 'Generale',
          'settings.general.description' =>
            'Impostazioni generali dell\'applicazione',
          'settings.general.language' => 'Lingua',
          'settings.general.languageDescription' =>
            'Scegli la tua lingua preferita',
          'settings.general.startMinimized' =>
            'Avvia ridotto nella barra di sistema',
          'settings.general.startMinimizedDescription' =>
            'Avvia l\'app ridotta nella barra delle applicazioni',
          'settings.general.rememberWindowPosition' =>
            'Ricorda posizione finestra',
          'settings.general.rememberWindowPositionDescription' =>
            'Ripristina dimensioni e posizione della finestra all\'avvio',
          'settings.general.openLastProject' =>
            'Apri ultimo progetto all\'avvio',
          'settings.general.openLastProjectDescription' =>
            'Apri automaticamente l\'ultimo progetto utilizzato all\'avvio dell\'app',
          'settings.general.application' => 'Applicazione',
          'settings.general.defaultView' => 'Vista Predefinita',
          'settings.general.defaultViewDescription' =>
            'Vista da mostrare all\'avvio',
          'settings.general.autoCheckUpdates' =>
            'Controlla aggiornamenti automaticamente',
          'settings.general.autoCheckUpdatesDescription' =>
            'Controlla aggiornamenti all\'avvio',
          'settings.general.startupOptions' => 'Opzioni di avvio',
          'settings.general.languageAuto' => 'Rilevamento automatico',
          'settings.general.viewBasic' => 'Confronto File',
          'settings.general.viewHistory' => 'Cronologia',
          'settings.general.viewDashboard' => 'Dashboard Qualità',
          'settings.general.viewDirectory' => 'Confronto Cartelle',
          'settings.general.viewLastUsed' => 'Ultima vista usata',
          'settings.scope.title' => 'Ambito Impostazioni',
          'settings.scope.global' => 'Predefiniti Globali',
          'settings.scope.project' => 'Progetto',
          'settings.scope.reset' =>
            'Ripristina progetto ai predefiniti globali',
          'settings.scope.resetConfirmation' =>
            'Questo cancellerà tutte le personalizzazioni per questo progetto e ripristinerà i predefiniti globali. Questa azione non può essere annullata.',
          'settings.scope.globalDescription' =>
            'Le modifiche si applicano a tutti i progetti a meno che non siano sovrascritte.',
          'settings.scope.projectDescription' => ({required Object name}) =>
              'Le modifiche si applicano solo a "${name}". Altre impostazioni ereditano dai predefiniti globali.',
          'settings.scope.createPrompt' =>
            'Crea un progetto per personalizzare le impostazioni per cartelle specifiche',
          'settings.searchKeywords.general.0' => 'Lingua',
          'settings.searchKeywords.general.1' => 'Vista Predefinita',
          'settings.searchKeywords.general.2' => 'Conteggio File Recenti',
          'settings.searchKeywords.general.3' => 'Apri Ultimo Progetto',
          'settings.searchKeywords.general.4' => 'Conferma Prima di Uscire',
          'settings.searchKeywords.general.5' => 'Mostra Notifiche',
          'settings.searchKeywords.comparisonEngine.0' => 'Modalità Confronto',
          'settings.searchKeywords.comparisonEngine.1' =>
            'Soglia di Somiglianza',
          'settings.searchKeywords.comparisonEngine.2' => 'Case Sensitive',
          'settings.searchKeywords.comparisonEngine.3' =>
            'Ignora Spazi Bianchi',
          'settings.searchKeywords.comparisonEngine.4' => 'Ignora Righe Vuote',
          'settings.searchKeywords.comparisonEngine.5' => 'Ignora Commenti',
          'settings.searchKeywords.comparisonEngine.6' => 'Ignora Pattern',
          'settings.searchKeywords.appearance.0' => 'Tema',
          'settings.searchKeywords.appearance.1' => 'Modalità Tema',
          'settings.searchKeywords.appearance.2' => 'Colore Accento',
          'settings.searchKeywords.appearance.3' => 'Dimensione Carattere Diff',
          'settings.searchKeywords.appearance.4' => 'Famiglia Carattere Diff',
          'settings.searchKeywords.appearance.5' => 'Colori Diff',
          'settings.searchKeywords.appearance.6' => 'Colore Aggiunto',
          'settings.searchKeywords.appearance.7' => 'Colore Rimosso',
          'settings.searchKeywords.appearance.8' => 'Colore Modificato',
          'settings.searchKeywords.appearance.9' => 'Colore Identico',
          'settings.searchKeywords.appearance.10' => 'Predefiniti Colore',
          'settings.searchKeywords.appearance.11' => 'Anteprima',
          'settings.searchKeywords.fileHandling.0' => 'Formato Sorgente',
          'settings.searchKeywords.fileHandling.1' => 'Formato Destinazione',
          'settings.searchKeywords.fileHandling.2' => 'Codifica Predefinita',
          'settings.searchKeywords.fileHandling.3' =>
            'Conteggio Progetti Recenti',
          'settings.searchKeywords.fileHandling.4' => 'Memoria di Traduzione',
          'settings.searchKeywords.fileHandling.5' => 'Importa Memoria',
          'settings.searchKeywords.fileHandling.6' => 'Esporta Memoria',
          'settings.searchKeywords.fileHandling.7' => 'Cancella Memoria',
          'settings.searchKeywords.aiServices.0' => 'Chiave API OpenAI',
          'settings.searchKeywords.aiServices.1' => 'Chiave API Anthropic',
          'settings.searchKeywords.aiServices.2' => 'Chiave API Google AI',
          'settings.searchKeywords.aiServices.3' => 'Modello AI',
          'settings.searchKeywords.aiServices.4' => 'Temperatura',
          'settings.searchKeywords.aiServices.5' => 'Prompt Personalizzato',
          'settings.searchKeywords.systemIntegrations.0' => 'Barra di Sistema',
          'settings.searchKeywords.systemIntegrations.1' => 'Avvia Ridotto',
          'settings.searchKeywords.systemIntegrations.2' => 'Associazioni File',
          'settings.searchKeywords.systemIntegrations.3' => 'Effetto Mica',
          'settings.searchKeywords.systemIntegrations.4' => 'Vibrancy',
          'settings.searchKeywords.systemIntegrations.5' =>
            'Materiale Finestra',
          'settings.searchKeywords.systemIntegrations.6' => 'Badge Dock',
          'settings.searchKeywords.systemIntegrations.7' =>
            'Conteggio Non Tradotti',
          'settings.searchKeywords.projectResources.0' => 'Glossario',
          'settings.searchKeywords.projectResources.1' =>
            'Memoria di Traduzione',
          'settings.searchKeywords.projectResources.2' => 'Terminologia',
          'settings.searchKeywords.about.0' => 'Versione',
          'settings.searchKeywords.about.1' => 'Controlla Aggiornamenti',
          'settings.searchKeywords.about.2' => 'Aggiornamento Automatico',
          'settings.searchKeywords.about.3' => 'Changelog',
          'settings.searchKeywords.about.4' => 'Licenza',
          'settings.searchKeywords.about.5' => 'Informativa sulla Privacy',
          'settings.searchKeywords.about.6' => 'Telemetria',
          'settings.searchKeywords.about.7' => 'Segnalazione Crash',
          'settings.searchKeywords.developer.0' => 'Overlay Prestazioni',
          'settings.searchKeywords.developer.1' => 'Debugger Semantica',
          'settings.searchKeywords.developer.2' => 'Griglia Material',
          'settings.searchKeywords.developer.3' => 'Cache Raster',
          'settings.searchKeywords.developer.4' => 'Riavvia Tutorial',
          'settings.searchKeywords.developer.5' => 'Ripristino di Fabbrica',
          'settings.comparison.title' => 'Confronto',
          'settings.comparison.description' =>
            'Configura il comportamento del confronto',
          'settings.comparison.caseSensitive' => 'Case Sensitive',
          'settings.comparison.caseSensitiveDescription' =>
            'Tratta le lettere maiuscole e minuscole come diverse',
          'settings.comparison.ignoreWhitespace' => 'Ignora Spazi Bianchi',
          'settings.comparison.ignoreWhitespaceDescription' =>
            'Ignora gli spazi bianchi iniziali/finali durante il confronto',
          'settings.comparison.showLineNumbers' => 'Mostra Numeri di Riga',
          'settings.comparison.showLineNumbersDescription' =>
            'Visualizza i numeri di riga nella vista diff',
          'settings.comparison.behavior' => 'Comportamento Confronto',
          'settings.comparison.ignoreCase' => 'Ignora Maiuscole/Minuscole',
          'settings.comparison.ignoreCaseDescription' =>
            'Tratta "Chiave" e "chiave" come uguali',
          'settings.comparison.similarityThreshold' => 'Soglia di Somiglianza',
          'settings.comparison.similarityThresholdDescription' =>
            'Somiglianza minima per il rilevamento "Modificato"',
          'settings.comparison.mode' => 'Modalità Confronto',
          'settings.comparison.modeDescription' =>
            'Come accoppiare le voci tra i file',
          'settings.comparison.modeKey' => 'Basato su chiave',
          'settings.comparison.modeKeyDescription' =>
            'Accoppia per nome chiave (predefinito).',
          'settings.comparison.modeOrder' => 'Basato su ordine',
          'settings.comparison.modeOrderDescription' =>
            'Accoppia per posizione nel file.',
          'settings.comparison.modeSmart' => 'Accoppiamento Intelligente',
          'settings.comparison.modeSmartDescription' =>
            'Rileva chiavi spostate/rinominate.',
          'settings.comparison.ignorePatterns' => 'Pattern da Ignorare',
          'settings.comparison.noIgnorePatterns' =>
            'Nessun pattern da ignorare impostato.',
          'settings.comparison.addPattern' => 'Aggiungi Pattern',
          'settings.comparison.resetToGlobal' =>
            'Ripristina tutte le impostazioni di confronto ai predefiniti globali',
          'settings.comparison.patternPresets.comments' => 'Commenti',
          'settings.comparison.patternPresets.tempKeys' => 'Chiavi Temporanee',
          'settings.comparison.patternPresets.placeholders' => 'Segnaposto',
          'settings.comparison.patternPresets.devOnly' => 'Solo Sviluppo',
          'settings.comparison.previewMatch.title' => 'Anteprima Accoppiamento',
          'settings.comparison.previewMatch.description' =>
            'Verifica come le impostazioni attuali influenzano la logica di accoppiamento.',
          'settings.comparison.previewMatch.stringA' => 'Stringa A',
          'settings.comparison.previewMatch.stringB' => 'Stringa B',
          'settings.comparison.previewMatch.enterText' => 'Inserisci testo...',
          'settings.comparison.previewMatch.similarity' => 'Somiglianza',
          'settings.comparison.previewMatch.identical' => 'Identiche',
          'settings.comparison.previewMatch.identicalDescription' =>
            'Le stringhe corrispondono esattamente dopo la normalizzazione.',
          'settings.comparison.previewMatch.ignored' => 'Ignorate',
          'settings.comparison.previewMatch.ignoredDescription' =>
            'L\'input corrisponde a un pattern da ignorare.',
          'settings.comparison.previewMatch.different' => 'Diverse',
          'settings.comparison.previewMatch.differentDescription' =>
            'Un valore è vuoto.',
          'settings.comparison.previewMatch.similarModified' =>
            'Simili / Modificate',
          'settings.comparison.previewMatch.similarModifiedDescription' => (
                  {required Object threshold}) =>
              'Il punteggio di corrispondenza è superiore alla soglia (${threshold}%).',
          'settings.comparison.previewMatch.newDifferent' => 'Nuove / Diverse',
          'settings.comparison.previewMatch.newDifferentDescription' => (
                  {required Object threshold}) =>
              'Il punteggio di corrispondenza è inferiore alla soglia (${threshold}%).',
          'settings.comparison.colorPresets.kDefault' => 'Predefinito',
          'settings.comparison.colorPresets.colorblindFriendly' =>
            'Per daltonici',
          'settings.comparison.colorPresets.highContrast' =>
            'Contrasto elevato',
          'settings.comparison.colorPresets.nord' => 'Nord',
          'settings.comparison.colorPresets.solarized' => 'Solarized',
          'settings.comparison.colorPresets.monokai' => 'Monokai',
          'settings.comparison.colorPresets.presetDefault' => 'Predefinito',
          'settings.comparison.colorPresets.presetColorblind' =>
            'Per daltonici',
          'settings.comparison.colorPresets.presetHighContrast' =>
            'Contrasto elevato',
          'settings.comparison.colorPresets.presetNord' => 'Nord',
          'settings.comparison.colorPresets.presetSolarized' => 'Solarized',
          'settings.comparison.colorPresets.presetMonokai' => 'Monokai',
          'settings.fileHandling.fileFormats' => 'Formati File',
          'settings.fileHandling.sourceFormat' => 'Formato Sorgente',
          'settings.fileHandling.targetFormat' => 'Formato Destinazione',
          'settings.fileHandling.encoding' => 'Codifica',
          'settings.fileHandling.sourceEncoding' => 'Codifica Sorgente',
          'settings.fileHandling.targetEncoding' => 'Codifica Destinazione',
          'settings.fileHandling.autoDetect' => 'Rilevamento automatico',
          'settings.fileHandling.autoDetectEncodingDescription' =>
            'Rileva automaticamente la codifica del file',
          'settings.fileHandling.exportSettings' => 'Impostazioni Esportazione',
          'settings.fileHandling.defaultExportFormat' =>
            'Formato Esportazione Predefinito',
          'settings.fileHandling.includeUtf8Bom' => 'Includi BOM UTF-8',
          'settings.fileHandling.includeUtf8BomDescription' =>
            'Richiesto per la compatibilità con Excel',
          'settings.fileHandling.openFolderAfterExport' =>
            'Apri cartella dopo esportazione',
          'settings.fileHandling.fileSafety' => 'Sicurezza File',
          'settings.fileHandling.fileSafetyDescription' =>
            'Copie locali automatiche per il recupero in caso di errore.',
          'settings.fileHandling.resetToGlobal' =>
            'Ripristina tutte le impostazioni di gestione file ai predefiniti globali',
          'settings.translationMemory.title' => 'Memoria di Traduzione Globale',
          'settings.translationMemory.autoLearn' => 'Auto-apprendimento',
          'settings.translationMemory.autoLearnDescription' =>
            'Salva le traduzioni nella memoria locale per riutilizzi futuri',
          'settings.translationMemory.confidenceThreshold' =>
            'Soglia di Confidenza',
          'settings.translationMemory.confidenceThresholdDescription' => (
                  {required Object percent}) =>
              'Punteggio minimo per l\'applicazione automatica (${percent}%)',
          'settings.translationMemory.entries' => 'Voci',
          'settings.translationMemory.size' => 'Dimensione',
          'settings.translationMemory.memorySize' => ({required Object size}) =>
              'Dimensione Memoria: ${size}',
          'settings.translationMemory.import' => 'Importa',
          'settings.translationMemory.exportTmx' => 'Esporta TMX',
          'settings.translationMemory.exportCsv' => 'Esporta CSV',
          'settings.translationMemory.clearMemory' => 'Cancella Memoria',
          'settings.translationMemory.importedItems' => (
                  {required Object count}) =>
              'Importate ${count} voci nella memoria.',
          'settings.translationMemory.noItemsAdded' => 'Nessuna voce aggiunta.',
          'settings.translationMemory.nothingToExport' =>
            'Nulla da esportare ancora.',
          'settings.translationMemory.tmxSaved' => 'TMX salvato',
          'settings.translationMemory.csvSaved' => 'CSV salvato',
          'settings.translationMemory.clearConfirmTitle' =>
            'Cancellare la memoria di traduzione?',
          'settings.translationMemory.clearConfirmContent' =>
            'Questo rimuoverà tutte le coppie di traduzione salvate su questo dispositivo. Questa azione non può essere annullata.',
          'settings.translationMemory.cleared' =>
            'Memoria di traduzione cancellata.',
          'settings.translationMemory.couldNotClear' =>
            'Impossibile cancellare la memoria.',
          'settings.backup.title' => 'Backup Automatico',
          'settings.backup.description' => 'Impostazioni backup automatico',
          'settings.backup.enabled' => 'Abilita Backup Automatico',
          'settings.backup.enabledDescription' =>
            'Esegui automaticamente il backup dei file prima di apportare modifiche',
          'settings.backup.maxCopies' => 'Numero Massimo di Copie di Backup',
          'settings.backup.maxCopiesDescription' =>
            'Numero di copie di backup da conservare per file',
          'settings.backup.activeStatus' => ({required Object count}) =>
              'Attivo · Conservazione di ${count} copie',
          'settings.backup.folder' => 'Cartella di Backup',
          'settings.backup.folderDescription' =>
            'Lascia vuoto per usare la stessa cartella',
          'settings.backup.useOriginalFolder' =>
            'Usa cartella originale del file',
          'settings.ai.title' => 'Servizi AI',
          'settings.ai.description' =>
            'Configura la traduzione e l\'assistenza AI',
          'settings.ai.provider' => 'Provider AI',
          'settings.ai.providerDescription' =>
            'Scegli il tuo provider di servizi AI preferito',
          'settings.ai.apiKey' => 'Chiave API',
          'settings.ai.apiKeyDescription' =>
            'Inserisci la tua chiave API per il provider selezionato',
          'settings.ai.apiKeyPlaceholder' => 'Inserisci chiave API...',
          'settings.ai.testConnection' => 'Test Connessione',
          'settings.ai.connectionSuccess' => 'Connessione riuscita!',
          'settings.ai.connectionFailed' =>
            'Connessione fallita. Controlla la tua chiave API.',
          'settings.ai.translationStrategy' => 'Strategia di Traduzione',
          'settings.ai.strategy' => 'Strategia',
          'settings.ai.strategyDescription' =>
            'Seleziona come vuoi tradurre le stringhe',
          'settings.ai.strategyLLM' => 'AI Generativa (LLM)',
          'settings.ai.strategyCloud' => 'Traduzione Cloud',
          'settings.ai.enableAiTranslation' => 'Abilita Traduzione AI',
          'settings.ai.enableAiTranslationDescription' =>
            'Consenti all\'app di usare l\'AI per i suggerimenti di traduzione',
          'settings.ai.llmProvider' => 'Provider Servizio LLM',
          'settings.ai.service' => 'Servizio',
          'settings.ai.serviceDescription' => 'Provider per l\'AI Generativa',
          'settings.ai.providerGemini' => 'Google Gemini',
          'settings.ai.providerOpenAI' => 'OpenAI',
          'settings.ai.geminiApiKey' => 'Chiave API Gemini',
          'settings.ai.openAiApiKey' => 'Chiave API OpenAI',
          'settings.ai.model' => 'Modello',
          'settings.ai.modelDescription' => 'Seleziona quale modello usare',
          'settings.ai.advancedParameters' => 'Parametri Avanzati',
          'settings.ai.parameters' => 'Parametri',
          'settings.ai.parametersDescription' =>
            'Temperatura, Contesto e altro',
          'settings.ai.temperature' => 'Temperatura',
          'settings.ai.temperatureDescription' =>
            'Valori più alti rendono l\'output più creativo',
          'settings.ai.maxTokens' => 'Token Massimi',
          'settings.ai.maxTokensDescription' =>
            'Limita la lunghezza della finestra di contesto',
          'settings.ai.systemContext' => 'Contesto di Sistema / Istruzioni',
          'settings.ai.systemContextHint' =>
            'Sei un localizzatore professionista. Mantieni il tono e l\'intento della stringa sorgente...',
          'settings.ai.systemContextHelper' =>
            'Fornisci istruzioni specifiche all\'AI sullo stile e la terminologia del tuo progetto.',
          'settings.ai.contextStrings' => 'Stringhe di Contesto',
          'settings.ai.contextStringsDescription' =>
            'Includi le stringhe circostanti per un contesto migliore',
          'settings.ai.contextCount' => 'Conteggio Contesto',
          'settings.ai.contextCountDescription' =>
            'Numero di stringhe circostanti da includere',
          'settings.ai.cloudServices' => 'Servizi di Traduzione Cloud',
          'settings.ai.googleTranslateApiKey' => 'Chiave API Google Translate',
          'settings.ai.deeplApiKey' => 'Chiave API DeepL',
          'settings.ai.test' => 'Test',
          'settings.ai.resetToGlobal' =>
            'Ripristina tutte le impostazioni AI ai predefiniti globali',
          'settings.integrations.platformNotice' => 'Avviso Piattaforma',
          'settings.integrations.platformNoticeDescription' =>
            'Le integrazioni di sistema non sono disponibili per questa piattaforma.',
          'settings.integrations.visualEffects' => 'Effetti Visivi',
          'settings.integrations.explorerIntegration' =>
            'Integrazione Explorer',
          'settings.integrations.explorerIntegrationDescription' =>
            'Aggiungi "Apri con Localizer" al menu contestuale di Esplora file di Windows per le cartelle.',
          'settings.integrations.addToContextMenu' =>
            'Aggiungi al Menu Contestuale',
          'settings.integrations.contextMenuAdded' =>
            'Menu contestuale aggiunto!',
          'settings.integrations.contextMenuAddError' =>
            'Impossibile aggiungere il menu contestuale',
          'settings.integrations.contextMenuRemoved' =>
            'Menu contestuale rimosso!',
          'settings.integrations.contextMenuRemoveError' =>
            'Impossibile rimuovere il menu contestuale',
          'settings.integrations.fileAssociations' => 'Associazioni File',
          'settings.integrations.fileAssociationsDescription' =>
            'Registra i tipi di file da aprire con Localizer quando si fa doppio clic in Esplora file.',
          'settings.integrations.registered' => 'Registrato',
          'settings.integrations.notRegistered' => 'Non registrato',
          'settings.integrations.extRegistered' => ({required Object ext}) =>
              '${ext} registrato!',
          'settings.integrations.extUnregistered' => ({required Object ext}) =>
              '${ext} rimosso!',
          'settings.integrations.extError' => (
                  {required Object action, required Object ext}) =>
              'Impossibile ${action} ${ext}',
          'settings.integrations.registerAll' => 'Registra Tutti',
          'settings.integrations.unregisterAll' => 'Rimuovi Tutti',
          'settings.integrations.registerAllResult' => (
                  {required Object success, required Object total}) =>
              'Registrati ${success} su ${total} tipi di file',
          'settings.integrations.unregisterAllResult' => (
                  {required Object success, required Object total}) =>
              'Rimossi ${success} su ${total} tipi di file',
          'settings.integrations.protocolHandler' => 'Gestore Protocollo',
          'settings.integrations.protocolHandlerDescription' =>
            'Registra gli URL localizer:// per aprire questa applicazione. Consente di aprire i progetti direttamente dai link del browser o da altre app.',
          'settings.integrations.protocolRegistered' =>
            'Il gestore del protocollo è registrato',
          'settings.integrations.protocolNotRegistered' =>
            'Gestore del protocollo non registrato',
          'settings.integrations.registerProtocol' => 'Registra Protocollo',
          'settings.integrations.unregister' => 'Rimuovi',
          'settings.integrations.protocolRegisteredSuccess' =>
            'Gestore del protocollo registrato!',
          'settings.integrations.protocolRemovedSuccess' =>
            'Gestore del protocollo rimosso!',
          'settings.integrations.protocolRegisterError' =>
            'Registrazione fallita',
          'settings.integrations.protocolRemoveError' => 'Rimozione fallita',
          'settings.integrations.windowMaterial' => 'Materiale Finestra',
          'settings.integrations.windowMaterialDescription' =>
            'Seleziona lo stile del materiale di vibrazione macOS',
          'settings.integrations.dockIntegration' => 'Integrazione Dock',
          'settings.integrations.showDockBadge' =>
            'Mostra Conteggio Non Tradotti',
          'settings.integrations.showDockBadgeDescription' =>
            'Mostra il numero di stringhe non tradotte sul badge dell\'icona del dock',
          'settings.integrations.materials.sidebar' => 'Barra laterale',
          'settings.integrations.materials.menu' => 'Menu',
          'settings.integrations.materials.popover' => 'Popover',
          'settings.integrations.materials.titlebar' => 'Barra del titolo',
          'settings.integrations.materials.underPageBackground' =>
            'Sfondo Pagina',
          'settings.integrations.materials.contentBackground' => 'Contenuto',
          'settings.integrations.fileTypes.loc' => 'File Progetto Localizer',
          'settings.integrations.fileTypes.lang' => 'File Lingua',
          'settings.integrations.fileTypes.json' => 'File Localizzazione JSON',
          'settings.integrations.fileTypes.xml' => 'File Localizzazione XML',
          'settings.developer.title' => 'Impostazioni Sviluppatore',
          'settings.developer.description' =>
            'Impostazioni avanzate per sviluppatori',
          'settings.developer.showLocalizationKeys' =>
            'Mostra Chiavi di Localizzazione',
          'settings.developer.localizationKeysDescription' =>
            'Se abilitato, tutto il testo tradotto mostrerà le chiavi di localizzazione invece del valore tradotto. Utile per verificare quale chiave viene usata e dove.',
          'settings.developer.showPerformanceOverlay' =>
            'Mostra Overlay Prestazioni',
          'settings.developer.performanceOverlayDescription' =>
            'Visualizza informazioni su FPS e tempi dei frame',
          'settings.developer.debugMode' => 'Modalità Debug',
          'settings.developer.debugModeDescription' =>
            'Abilita logging aggiuntivo e funzionalità di debug',
          'settings.developer.debuggingTools' => 'Strumenti di Debug',
          'settings.developer.semanticsDebugger' => 'Debugger Semantica',
          'settings.developer.semanticsDebuggerDescription' =>
            'Visualizza l\'albero della semantica',
          'settings.developer.materialGrid' => 'Griglia Material',
          'settings.developer.materialGridDescription' =>
            'Sovrappone la griglia di layout Material',
          'settings.developer.rasterCache' => 'Immagini Cache Raster',
          'settings.developer.rasterCacheDescription' =>
            'Evidenzia a scacchi le immagini nella cache raster',
          'settings.developer.actions' => 'Azioni',
          'settings.developer.showLogs' => 'Mostra Log App',
          'settings.developer.showLogsDescription' =>
            'Apri la console di debug Talker',
          'settings.developer.restartTutorial' => 'Riavvia Tutorial Iniziale',
          'settings.developer.restartTutorialDescription' =>
            'Ripristina i flag e avvia di nuovo il tutorial',
          'settings.developer.restartRequested' =>
            'Riavvio tutorial richiesto.',
          'settings.developer.throwException' => 'Lancia Eccezione di Test',
          'settings.developer.throwExceptionDescription' =>
            'Attiva un\'eccezione di test per la segnalazione crash',
          'settings.developer.testExceptionMessage' =>
            'Eccezione di Test attivata dalle Opzioni Sviluppatore',
          'settings.developer.clearTM' => 'Cancella Memoria di Traduzione',
          'settings.developer.clearTMDescription' =>
            'Elimina tutte le traduzioni memorizzate',
          'settings.developer.clearTMConfirmation' =>
            'Cancellare Memoria di Traduzione?',
          'settings.developer.clearTMWarning' =>
            'Questo eliminerà tutte le traduzioni apprese. L\'azione è irreversibile.',
          'settings.developer.tmCleared' => 'Memoria di traduzione cancellata',
          'settings.developer.clearApiKeys' => 'Cancella Chiavi API',
          'settings.developer.clearApiKeysDescription' =>
            'Rimuovi tutte le chiavi API memorizzate',
          'settings.developer.clearApiKeysConfirmation' =>
            'Cancellare Chiavi API?',
          'settings.developer.clearApiKeysWarning' =>
            'Questo rimuoverà tutte le chiavi API dallo storage sicuro.',
          'settings.developer.apiKeysCleared' => 'Chiavi API cancellate',
          'settings.developer.hideOptions' => 'Nascondi Opzioni Sviluppatore',
          'settings.developer.hideOptionsDescription' =>
            'Disabilita modalità sviluppatore (richiede 7 tocchi per riabilitarla)',
          'settings.developer.optionsDisabled' =>
            'Opzioni sviluppatore disabilitate',
          'settings.developer.dangerZone' => 'Zona Pericolosa',
          'settings.developer.factoryReset' => 'Ripristino di Fabbrica',
          'settings.developer.factoryResetDescription' =>
            'Ripristina tutte le impostazioni e cancella i dati',
          'settings.developer.factoryResetWarning' =>
            'Sei sicuro di voler ripristinare tutte le impostazioni? Questa azione non può essere annullata.',
          'settings.developer.inspectionTools' => 'Strumenti di Ispezione',
          'settings.developer.searchHint' => 'Cerca impostazioni...',
          'settings.developer.resetToDefault' => 'Ripristina predefiniti',
          'settings.developer.resetToGlobal' =>
            'Ripristina al predefinito globale',
          'settings.developer.storageInspector' => 'Ispettore Archiviazione',
          'settings.developer.storageInspectorDescription' =>
            'Visualizza i contenuti di Hive e Secure Storage',
          'settings.developer.deviceEnvironment' => 'Dispositivo e Ambiente',
          'settings.developer.deviceEnvironmentDescription' =>
            'Info su schermo, piattaforma e build',
          'settings.developer.themePlayground' => 'Playground del Tema',
          'settings.developer.themePlaygroundDescription' =>
            'Tavolozza colori e tipografia',
          'settings.developer.themePlaygroundSection.colors' => 'Colori',
          'settings.developer.themePlaygroundSection.typography' =>
            'Tipografia',
          'settings.developer.themePlaygroundSection.palette.primary' =>
            'Primario',
          'settings.developer.themePlaygroundSection.palette.onPrimary' =>
            'Su Primario',
          'settings.developer.themePlaygroundSection.palette.secondary' =>
            'Secondario',
          'settings.developer.themePlaygroundSection.palette.onSecondary' =>
            'Su Secondario',
          'settings.developer.themePlaygroundSection.palette.surface' =>
            'Superficie',
          'settings.developer.themePlaygroundSection.palette.onSurface' =>
            'Su Superficie',
          'settings.developer.themePlaygroundSection.palette.error' => 'Errore',
          'settings.developer.themePlaygroundSection.palette.onError' =>
            'Su Errore',
          'settings.developer.themePlaygroundSection.palette.outline' =>
            'Contorno',
          'settings.developer.themePlaygroundSection.palette.shadow' => 'Ombra',
          'settings.developer.themePlaygroundSection.palette.success' =>
            'Successo',
          'settings.developer.themePlaygroundSection.palette.warning' =>
            'Avviso',
          'settings.developer.themePlaygroundSection.palette.info' => 'Info',
          'settings.developer.localizationInspector' =>
            'Ispettore Localizzazione',
          'settings.developer.localizationInspectorDescription' =>
            'Debug delle stringhe di traduzione',
          'settings.developer.hiveAppSettings' => 'Hive (AppSettings)',
          'settings.developer.secureStorageMasked' =>
            'Secure Storage (Mascherato)',
          'settings.developer.featureFlags.title' =>
            'Funzionalità Sperimentali',
          'settings.developer.featureFlags.description' =>
            'Attiva i flag delle funzionalità localmente per il test. Queste impostazioni persistono al riavvio dell\'app.',
          'settings.developer.featureFlags.subtitle' =>
            'Sovrascrivi funzionalità sperimentali',
          'settings.developer.featureFlags.flags.experimental_ai_batch.name' =>
            'Batch AI Sperimentale',
          'settings.developer.featureFlags.flags.experimental_ai_batch.description' =>
            'Abilita traduzione AI batch per più righe',
          'settings.developer.featureFlags.flags.new_diff_algorithm.name' =>
            'Nuovo Algoritmo Diff',
          'settings.developer.featureFlags.flags.new_diff_algorithm.description' =>
            'Usa un algoritmo diff migliorato per i confronti',
          'settings.developer.featureFlags.flags.enhanced_search.name' =>
            'Ricerca Migliorata',
          'settings.developer.featureFlags.flags.enhanced_search.description' =>
            'Abilita ricerca fuzzy nei file di traduzione',
          'settings.developer.featureFlags.flags.auto_save.name' =>
            'Salvataggio Automatico',
          'settings.developer.featureFlags.flags.auto_save.description' =>
            'Salva automaticamente le modifiche dopo l\'editing',
          'settings.developer.featureFlags.reset' => 'Ripristina Tutti i Flag',
          'settings.developer.featureFlags.overrides' =>
            'Sovrascritture Locali',
          'settings.developer.featureFlags.defaultVal' => 'Predefinito',
          'settings.developer.featureFlags.on' => 'ON',
          'settings.developer.featureFlags.off' => 'OFF',
          'settings.developer.storageInspectorSection.refresh' => 'Aggiorna',
          'settings.developer.storageInspectorSection.hiveData' => 'Dati Hive',
          'settings.developer.storageInspectorSection.secureStorage' =>
            'Secure Storage',
          'settings.developer.deviceInfoSection.refresh' => 'Aggiorna',
          'settings.developer.deviceInfoSection.copy' => 'Copia negli appunti',
          'settings.developer.deviceInfoSection.computerName' =>
            'Nome Computer',
          'settings.developer.deviceInfoSection.osVersion' => 'Versione OS',
          'settings.developer.localizationInspectorSection.showKeys' =>
            'Mostra Chiavi Invece dei Valori',
          'settings.developer.localizationInspectorSection.keysVisible' =>
            'Chiavi visibili',
          'settings.developer.localizationInspectorSection.normalDisplay' =>
            'Visualizzazione normale',
          'settings.developer.localizationInspectorSection.note' =>
            'Nota: questa funzione richiede che la localizzazione dell\'app utilizzi un wrapper che rispetti questa impostazione.',
          'settings.about.title' => 'Informazioni',
          'settings.about.version' => 'Versione',
          'settings.about.buildNumber' => 'Numero Build',
          'settings.about.author' => 'Autore',
          _ => null,
        } ??
        switch (path) {
          'settings.about.license' => 'Licenza',
          'settings.about.sourceCode' => 'Codice Sorgente',
          'settings.about.reportBug' => 'Segnala un Bug',
          'settings.about.requestFeature' => 'Richiedi una Funzionalità',
          'settings.about.checkForUpdates' => 'Controlla Aggiornamenti',
          'settings.about.upToDate' => 'L\'app è aggiornata!',
          'settings.about.updateAvailable' => ({required Object version}) =>
              'Aggiornamento disponibile: ${version}',
          'settings.about.updateAvailableBadge' => 'Aggiornamento Disponibile!',
          'settings.about.developerSteps' => ({required Object count}) =>
              'Ti mancano ${count} passaggi per diventare uno sviluppatore.',
          'settings.about.developerActivated' => 'Ora sei uno sviluppatore!',
          'settings.about.neverChecked' => 'Mai',
          'settings.about.applicationInfo' => 'Info Applicazione',
          'settings.about.platform' => 'Piattaforma',
          'settings.about.updateInformation' => 'Informazioni Aggiornamento',
          'settings.about.currentVersion' => 'Versione Corrente',
          'settings.about.latestVersion' => 'Ultima Versione',
          'settings.about.lastChecked' => 'Ultimo Controllo',
          'settings.about.checkingForUpdates' => 'Controllo in corso...',
          'settings.about.whatsNew' => 'Novità',
          'settings.about.systemInformation' => 'Informazioni di Sistema',
          'settings.about.dartVersion' => 'Versione Dart',
          'settings.about.diskSpace' => 'Spazio su Disco Disponibile',
          'settings.about.memoryUsage' => 'Utilizzo Memoria',
          'settings.about.privacyTitle' => 'Privacy e Telemetria',
          'settings.about.usageStats' => 'Statistiche di Utilizzo Anonime',
          'settings.about.requiresFirebase' =>
            'Richiede configurazione Firebase',
          'settings.about.featureUnavailable' =>
            'Funzionalità attualmente non disponibile (Richiede Firebase)',
          'settings.about.settingsManagement' => 'Gestione Impostazioni',
          'settings.about.settingsManagementDescription' =>
            'Esporta le tue impostazioni in un file per eseguirne il backup o condividerle con altri computer.',
          'settings.about.resetAll' => 'Ripristina Tutto',
          'settings.about.links' => 'Link',
          'settings.about.githubRepo' => 'Repository GitHub',
          'settings.about.privacyPolicy' => 'Informativa sulla Privacy',
          'settings.about.crashReporting' => 'Segnalazione Crash',
          'settings.onboarding.skipTutorial' => 'Salta Tutorial',
          'settings.onboarding.gettingStarted' => 'Iniziamo',
          'settings.onboarding.stepProgress' => (
                  {required Object current, required Object total}) =>
              '${current} di ${total}',
          'settings.onboarding.loadSampleData' => 'Carica Dati di Esempio',
          'settings.onboarding.steps.importFiles.title' => 'Importa File',
          'settings.onboarding.steps.importFiles.description' =>
            'Carica i file sorgente e di destinazione',
          'settings.onboarding.steps.runComparison.title' => 'Esegui Confronto',
          'settings.onboarding.steps.runComparison.description' =>
            'Fai clic su "Confronta File"',
          'settings.onboarding.steps.reviewMissing.title' =>
            'Controlla Chiavi Mancanti',
          'settings.onboarding.steps.reviewMissing.description' =>
            'Nota gli elementi rossi MANCANTI',
          'settings.onboarding.steps.useFilters.title' => 'Usa i Filtri',
          'settings.onboarding.steps.useFilters.description' =>
            'Filtra per tipo',
          'settings.onboarding.steps.searchResults.title' =>
            'Risultati della Ricerca',
          'settings.onboarding.steps.searchResults.description' =>
            'Trova chiavi specifiche',
          'settings.onboarding.steps.advancedView.title' => 'Vista Avanzata',
          'settings.onboarding.steps.advancedView.description' =>
            'Esplora l\'analisi dettagliata',
          'settings.onboarding.steps.editCell.title' => 'Modifica una Cella',
          'settings.onboarding.steps.editCell.description' =>
            'Fai clic per modificare un valore',
          'settings.onboarding.steps.exportResults.title' => 'Esporta',
          'settings.onboarding.steps.exportResults.description' =>
            'Salva il tuo report',
          'settings.settingsView.resetCategoryTitle' =>
            ({required Object category}) => 'Ripristinare ${category}?',
          'settings.settingsView.resetCategoryContent' =>
            'Questo ripristinerà tutte le impostazioni in questa categoria ai loro valori predefiniti.',
          'settings.settingsView.resetAllTitle' =>
            'Ripristinare Tutte le Impostazioni?',
          'settings.settingsView.resetAllContent' =>
            'Questo ripristinerà permanentemente tutte le impostazioni ai valori di fabbrica. Questa azione non può essere annullata.',
          'settings.settingsView.resetAll' => 'Ripristina Tutto',
          'settings.settingsView.resetSuccess' => (
                  {required Object category}) =>
              '${category} ripristinata ai predefiniti',
          'settings.settingsView.errorLoading' =>
            'Errore durante il caricamento delle impostazioni',
          'settings.settingsView.settingsSaved' => 'Impostazioni salvate',
          'settings.settingsView.updateAvailable' => (
                  {required Object version}) =>
              'Aggiornamento disponibile: v${version}',
          'settings.settingsView.latestVersion' =>
            'Stai usando l\'ultima versione',
          'settings.settingsView.whatsNew' => ({required Object version}) =>
              'Novità nella v${version}',
          'settings.settingsView.downloadUpdate' => 'Scarica Aggiornamento',
          'settings.settingsView.exportSettings' => 'Esporta Impostazioni',
          'settings.settingsView.settingsExported' => 'Impostazioni esportate',
          'settings.settingsView.exportFail' => ({required Object error}) =>
              'Impossibile esportare le impostazioni: ${error}',
          'settings.settingsView.importSettings' => 'Importa Impostazioni',
          'settings.settingsView.importTitle' => 'Importare Impostazioni?',
          'settings.settingsView.importContent' =>
            'Questo sostituirà tutte le impostazioni attuali con quelle importate. Questa azione non può essere annullata.',
          'settings.settingsView.importSuccess' =>
            'Impostazioni importate con successo!',
          'settings.settingsView.importFail' => ({required Object error}) =>
              'Impossibile importare le impostazioni: ${error}',
          'settings.settingsView.invalidFormat' =>
            'Formato file impostazioni non valido',
          'settings.settingsView.categories.general' => 'Impostazioni Generali',
          'settings.settingsView.categories.comparisonEngine' =>
            'Motore di Confronto',
          'settings.settingsView.categories.appearance' => 'Aspetto',
          'settings.settingsView.categories.fileHandling' => 'Gestione File',
          'settings.settingsView.categories.aiServices' => 'Servizi AI',
          'settings.settingsView.categories.systemIntegrations' =>
            'Integrazioni di Sistema',
          'settings.settingsView.categories.projectResources' =>
            'Risorse Progetto (Glossario e TM)',
          'settings.settingsView.categories.developer' =>
            'Opzioni Sviluppatore',
          'settings.settingsView.categories.about' => 'Informazioni',
          'settings.settingsView.categoryLabels.general' => 'Generale',
          'settings.settingsView.categoryLabels.comparisonEngine' =>
            'Confronto',
          'settings.settingsView.categoryLabels.appearance' => 'Aspetto',
          'settings.settingsView.categoryLabels.fileHandling' =>
            'Gestione File',
          'settings.settingsView.categoryLabels.aiServices' => 'Servizi AI',
          'settings.settingsView.categoryLabels.systemIntegrations' =>
            'Integrazioni di Sistema',
          'settings.settingsView.categoryLabels.projectResources' =>
            'Risorse Progetto',
          'settings.settingsView.categoryLabels.developer' =>
            'Opzioni Sviluppatore',
          'settings.settingsView.categoryLabels.about' => 'Informazioni',
          'fileComparison.title' => 'Confronto File',
          'fileComparison.openFiles' => 'Apri File',
          'fileComparison.exportResults' => 'Esporta Risultati',
          'fileComparison.restartTutorial' => 'Riavvia Tutorial',
          'fileComparison.restartTutorialDevOnly' =>
            'Il riavvio del tutorial è disponibile solo in modalità sviluppatore.',
          'fileComparison.unsupportedFileType' =>
            'Tipo di file non supportato.',
          'fileComparison.unsupportedFileTypeSuggestion' =>
            'Seleziona un file di localizzazione supportato.',
          'fileComparison.someFilesUnsupported' =>
            'Alcuni file non sono supportati.',
          'fileComparison.pickSupportedFiles' =>
            'Scegli solo file di localizzazione supportati.',
          'fileComparison.pickTwoFiles' => 'Scegli due file da confrontare.',
          'fileComparison.pickBilingualFile' =>
            'Seleziona un file bilingue da confrontare.',
          'fileComparison.noResultsToExport' =>
            'Nessun risultato da esportare ancora.',
          'fileComparison.performComparisonFirst' =>
            'Esegui prima un confronto per esportare i risultati.',
          'fileComparison.performComparisonFirstEditor' =>
            'Esegui prima un confronto per vedere i dettagli avanzati.',
          'fileComparison.sampleDataLoaded' =>
            'Dati di esempio caricati con successo',
          'fileComparison.loadSampleDataError' => ({required Object error}) =>
              'Impossibile caricare i dati di esempio: ${error}',
          'fileComparison.invalidFileType' => 'Tipo di file non valido.',
          'fileComparison.fileSelected' => (
                  {required Object label, required Object fileName}) =>
              '${label} selezionato: ${fileName}',
          'fileComparison.sourceFile' => 'File sorgente',
          'fileComparison.targetFile' => 'File di destinazione',
          'fileComparison.bilingualFile' => 'File bilingue',
          'fileComparison.compareFiles' => 'Confronta File',
          'fileComparison.compareFile' => 'Confronta File',
          'fileComparison.bilingualMode' => 'Modalità Bilingue',
          'fileComparison.twoFilesMode' => 'Due File',
          'fileComparison.processing' => 'Elaborazione in corso...',
          'fileComparison.remaining' => ({required Object time}) =>
              'mancano ${time}',
          'fileComparison.comparisonInProgress' => 'Confronto in corso...',
          'fileComparison.comparisonFailed' => ({required Object error}) =>
              'Confronto Fallito: ${error}',
          'fileComparison.fileChanged' => ({required Object fileName}) =>
              'File modificato: ${fileName}. Riconfronto in corso...',
          'fileComparison.dropFileHere' => 'Trascina il file qui',
          'fileComparison.dropFileOrBrowse' =>
            'Trascina il file o fai clic per sfogliare',
          'fileComparison.fileUpload' => 'Carica file',
          'fileComparison.changeFile' => 'Cambia file',
          'fileComparison.total' => 'Totale',
          'fileComparison.show' => 'Mostra',
          'fileComparison.showAll' => 'Mostra Tutto',
          'fileComparison.noMatches' => ({required Object query}) =>
              'Nessuna corrispondenza trovata per "${query}"',
          'fileComparison.showingEntries' => (
                  {required Object count, required Object total}) =>
              'Visualizzazione di ${count} su ${total} voci',
          'fileComparison.filesIdentical' => 'I file sono identici.',
          'fileComparison.hiddenIdentical' => ({required Object count}) =>
              '${count} voci identiche nascoste',
          'fileComparison.showIdentical' => 'Mostra Voci Identiche',
          'fileComparison.hideIdentical' => 'Nascondi voci identiche',
          'fileComparison.noDiff' =>
            'Nessuna differenza trovata in base alle chiavi.',
          'fileComparison.source' => 'Sorgente',
          'fileComparison.target' => 'Destinazione',
          'fileComparison.value' => 'Valore',
          'fileComparison.readyToCompare' => 'Pronto per il Confronto dei File',
          'fileComparison.readyToCompareDesc' =>
            'Trascina i file di localizzazione sopra o usa i pulsanti sfoglia\nper selezionare i file da confrontare.',
          'fileComparison.recentComparisons' => 'Confronti Recenti',
          'fileComparison.bilingualFileLabel' => ({required Object name}) =>
              'File bilingue: ${name}',
          'fileComparison.comparisonLabel' => (
                  {required Object source, required Object target}) =>
              '${source} ↔ ${target}',
          'fileComparison.fileNotExist' =>
            'Uno o entrambi i file di questa sessione non esistono più.',
          'fileComparison.largeFileTitle' =>
            'Rilevato File di Grandi Dimensioni',
          'fileComparison.largeFileContent' => ({required Object count}) =>
              'Il risultato del confronto contiene ${count} voci.\nVisualizzarle tutte potrebbe causare problemi di prestazioni.\n\nVuoi procedere?',
          'fileComparison.dontShowAgain' => 'Non mostrare più per questo file',
          'fileComparison.proceed' => 'Procedi',
          'fileComparison.exportReport' => ({required Object format}) =>
              'Salva Report ${format}',
          'fileComparison.saved' => ({required Object format}) =>
              '${format} salvato',
          'fileComparison.saveError' => ({required Object format}) =>
              'Impossibile salvare il file ${format}.',
          'fileComparison.saveErrorDetailed' => (
                  {required Object format, required Object error}) =>
              'Impossibile salvare ${format}: ${error}',
          'fileComparison.watching' => 'Monitoraggio attivo',
          'fileComparison.watchOff' => 'Monitoraggio disattivato',
          'fileComparison.watchingTooltip' => ({required Object status}) =>
              'Monitoraggio File: ${status}\nRiconfronta automaticamente quando i file cambiano su disco',
          'fileComparison.aiSettingsNotAvailable' =>
            'Navigazione alle Impostazioni AI non disponibile',
          'directoryComparison.title' => 'Confronto Cartelle',
          'directoryComparison.sourceDirectory' => 'Cartella Sorgente',
          'directoryComparison.targetDirectory' => 'Cartella di Destinazione',
          'directoryComparison.sourceSubtitle' =>
            'File originali/di riferimento',
          'directoryComparison.targetSubtitle' =>
            'File di traduzione/confronto',
          'directoryComparison.selectBothDirectories' =>
            'Seleziona sia la cartella sorgente che quella di destinazione.',
          'directoryComparison.selectSourceFolder' =>
            'Seleziona Cartella Sorgente',
          'directoryComparison.selectTargetFolder' =>
            'Seleziona Cartella di Destinazione',
          'directoryComparison.dropFolderHere' =>
            'Trascina la cartella qui o sfoglia...',
          'directoryComparison.folderPath' => 'Percorso Cartella',
          'directoryComparison.readyToCompare' =>
            'Pronto per il Confronto delle Cartelle',
          'directoryComparison.readyToCompareDesc' =>
            'Trascina le cartelle sopra o usa i pulsanti sfoglia\nper selezionare le cartelle da confrontare.',
          'directoryComparison.nestedFolders' => 'Cartelle nidificate',
          'directoryComparison.nestedFoldersTooltip' =>
            'Confronta ricorsivamente tutte le sottocartelle',
          'directoryComparison.fileMatching' => 'Corrispondenza file',
          'directoryComparison.fileMatchingTooltip' =>
            'Accoppia automaticamente i file per nome',
          'directoryComparison.bulkExport' => 'Esportazione massiva',
          'directoryComparison.bulkExportTooltip' =>
            'Esporta tutti i risultati del confronto in una volta sola',
          'directoryComparison.notDirectoryComparison' =>
            'Questo non è un confronto tra cartelle.',
          'directoryComparison.directoriesNotExist' =>
            'Una o entrambe le cartelle non esistono più.',
          'directoryComparison.errorOccurred' => 'Si è verificato un errore',
          'directoryComparison.noFilesFound' =>
            'Nessun file trovato nelle cartelle selezionate.',
          'directoryComparison.unmatchedSourceFiles' =>
            'File Sorgente Non Accoppiati',
          'directoryComparison.unmatchedTargetFiles' =>
            'File di Destinazione Non Accoppiati',
          'directoryComparison.filePairs' => ({required Object count}) =>
              '${count} coppie di file',
          'directoryComparison.pairedFiles' => ({required Object count}) =>
              'File Accoppiati (${count})',
          'directoryComparison.view' => 'Visualizza',
          'directoryComparison.failed' => 'Fallito',
          'directoryComparison.pair' => 'Accoppia...',
          'directoryComparison.pairDialogTitle' => ({required Object name}) =>
              'Accoppia "${name}" con:',
          'directoryComparison.discoverFiles' => 'Scopri File',
          'directoryComparison.compareAll' => 'Confronta Tutto',
          'directoryComparison.exportAll' => 'Esporta Tutto',
          'directoryComparison.comparisonStarted' => 'Confronto avviato...',
          'directoryComparison.discoveringFiles' => 'Ricerca file in corso...',
          'directoryComparison.noResultsToExport' =>
            'Nessun risultato da esportare. Esegui prima "Confronta Tutto".',
          'directoryComparison.selectExportFolder' =>
            'Seleziona Cartella di Esportazione',
          'directoryComparison.createExportFolderError' => (
                  {required Object error}) =>
              'Impossibile creare la cartella di esportazione: ${error}',
          'directoryComparison.exportingResults' => 'Esportazione Risultati',
          'directoryComparison.processingFile' => ({required Object file}) =>
              'In elaborazione: ${file}',
          'directoryComparison.exportProgress' => (
                  {required Object current, required Object total}) =>
              '${current} di ${total} file esportati',
          'directoryComparison.exportComplete' => 'Esportazione Completata',
          'directoryComparison.exportSuccessMessage' => (
                  {required Object count}) =>
              'Esportati con successo ${count} file di confronto più il riepilogo.',
          'directoryComparison.exportFailed' => ({required Object error}) =>
              'Esportazione fallita: ${error}',
          'directoryComparison.close' => 'Chiudi',
          'gitComparison._translatorNote' =>
            'I termini Git (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) devono rimanere in inglese per tutte le traduzioni per evitare confusione tra gli sviluppatori.',
          'gitComparison.title' => 'Confronto Repository',
          'gitComparison.repoSelector' => 'Crea / Apri Repository',
          'gitComparison.noRepoSelected' => 'Nessun repository selezionato',
          'gitComparison.open' => 'Apri',
          'gitComparison.refreshCommits' => 'Aggiorna Commit',
          'gitComparison.noCommits' =>
            'Nessun commit trovato o caricato. Seleziona un branch per caricare i commit.',
          'gitComparison.baseCommit' => 'Base Commit (Più vecchio)',
          'gitComparison.targetCommit' => 'Target Commit (Più recente)',
          'gitComparison.filterCommitsByBranch' => 'Filtra Commit per Branch',
          'gitComparison.conflictDetection' => 'Rilevamento conflitti',
          'gitComparison.conflictDetectionTooltip' =>
            'Rileva e risolvi i conflitti di merge',
          'gitComparison.actions' => 'Azioni:',
          'gitComparison.checkout' => 'Checkout',
          'gitComparison.merge' => 'Merge',
          'gitComparison.pull' => 'Pull',
          'gitComparison.checkoutBranch' => 'Checkout Branch',
          'gitComparison.mergeBranch' =>
            'Esegui Merge del Branch in quello corrente',
          'gitComparison.mergeConfirmation' => ({required Object branch}) =>
              'Eseguire merge di ${branch}?',
          'gitComparison.mergeWarning' =>
            'Questo unirà le modifiche nel tuo branch di lavoro attuale. Potrebbero verificarsi conflitti.',
          'gitComparison.selectExportFolder' =>
            'Seleziona Cartella di Esportazione',
          'gitComparison.createExportFolderError' => (
                  {required Object error}) =>
              'Impossibile creare la cartella di esportazione: ${error}',
          'gitComparison.exportingFiles' => 'Esportazione File',
          'gitComparison.processingFile' => ({required Object file}) =>
              'In elaborazione: ${file}',
          'gitComparison.exportProgress' => (
                  {required Object current, required Object total}) =>
              '${current} di ${total} file esportati',
          'gitComparison.exportComplete' => 'Esportazione Completata',
          'gitComparison.exportSuccessMessage' => ({required Object count}) =>
              'Esportati con successo ${count} file con il contenuto completo.',
          'gitComparison.exportDetail' =>
            'Il diff di ogni file è salvato nella sottocartella "files".',
          'gitComparison.diffViewer' => 'Visualizzatore Diff',
          'gitComparison.base' => 'BASE',
          'gitComparison.target' => 'TARGET',
          'gitComparison.noLines' => 'Nessuna riga da visualizzare',
          'gitComparison.searchFiles' => 'Cerca file...',
          'gitComparison.noFilesMatch' => ({required Object query}) =>
              'Nessun file corrisponde a "${query}"',
          'gitComparison.filesCount' => ({required Object count}) =>
              '${count} file',
          'gitComparison.selectBaseFile' => 'Seleziona File Base',
          'gitComparison.selectTargetFile' => 'Seleziona File Target',
          'gitComparison.comparisonResults' => 'Risultati del Confronto',
          'gitComparison.noChanges' =>
            'Nessuna modifica trovata tra i riferimenti selezionati.',
          'gitComparison.linesAdded' => 'Righe Aggiunte',
          'gitComparison.linesRemoved' => 'Righe Rimosse',
          'gitComparison.commit' => 'Commit',
          'gitComparison.branch' => 'Branch',
          'gitComparison.noRepositorySelected' =>
            'Nessun repository selezionato',
          'gitComparison.notGitComparison' => 'Non è un confronto Git',
          'gitComparison.repositoryNotExist' => 'Il repository non esiste',
          'gitComparison.mainBranch' => 'main',
          'gitComparison.masterBranch' => 'master',
          'gitComparison.backToControls' => 'Torna ai controlli di confronto',
          'advancedComparison.placeholder' =>
            'Vista Confronto Avanzata - Placeholder',
          'advancedDiff.saveAllChanges' => 'Salvare tutte le modifiche?',
          'advancedDiff.saveConfirmation' => ({required Object count}) =>
              'Questo salverà tutte le ${count} voci modificate nel file di destinazione. Questa azione non può essere annullata.',
          'advancedDiff.changesSaved' => 'Modifiche salvate con successo.',
          'advancedDiff.csvExported' => 'CSV esportato',
          'advancedDiff.unsavedChanges' => 'Modifiche non salvate',
          'advancedDiff.unsavedChangesWarning' =>
            'Hai delle modifiche non salvate. Sei sicuro di volerle scartare?',
          'advancedDiff.discardChanges' => 'Scarta Modifiche',
          'advancedDiff.goBack' => 'Torna indietro',
          'advancedDiff.breadcrumbs' => 'Home  >  Editor',
          'advancedDiff.unsaved' => ({required Object count}) =>
              '${count} non salvate',
          'advancedDiff.reviewed' => ({required Object count}) =>
              '${count} revisionate',
          'advancedDiff.saveAll' => ({required Object count}) =>
              'Salva Tutto (${count})',
          'advancedDiff.allSaved' => 'Tutto Salvato',
          'advancedDiff.saveAllTooltip' => 'Salva tutte le modifiche (Ctrl+S)',
          'advancedDiff.exportTooltip' => 'Esporta Dati (Ctrl+E)',
          'advancedDiff.aiSuggestion.aiTranslation' => 'Traduzione AI',
          'advancedDiff.aiSuggestion.aiRephrase' => 'Rielaborazione AI',
          'advancedDiff.aiSuggestion.key' => ({required Object key}) =>
              'Chiave: ${key}',
          'advancedDiff.aiSuggestion.original' => 'Originale:',
          'advancedDiff.aiSuggestion.suggestion' => 'Suggerimento:',
          'advancedDiff.aiSuggestion.confidence' => 'Confidenza AI',
          'advancedDiff.aiSuggestion.cancelEdit' => 'Annulla modifica',
          'advancedDiff.aiSuggestion.editSuggestion' => 'Modifica suggerimento',
          'advancedDiff.aiSuggestion.alternatives' => 'Alternative:',
          'advancedDiff.aiSuggestion.accept' => 'Accetta',
          'advancedDiff.aiSuggestion.reject' => 'Rifiuta',
          'advancedDiff.aiSuggestion.stop' => 'Ferma',
          'advancedDiff.detailEdit.title' => ({required Object key}) =>
              'Modifica: ${key}',
          'advancedDiff.detailEdit.sourceLabel' => 'SORGENTE (Originale)',
          'advancedDiff.detailEdit.targetLabel' => 'DESTINAZIONE (Traduzione)',
          'advancedDiff.detailEdit.translateWithCloud' => 'Traduci con Cloud',
          'advancedDiff.detailEdit.translateWithAi' => 'Traduci con AI',
          'advancedDiff.detailEdit.translating' => 'Traduzione in corso...',
          'advancedDiff.detailEdit.applyAndTm' => 'Applica',
          'advancedDiff.detailEdit.entryApplied' =>
            'Voce applicata e aggiunta alla TM',
          'advancedDiff.detailEdit.translationAdded' =>
            'Suggerimento di traduzione aggiunto.',
          'advancedDiff.detailEdit.aiSuggestionAdded' =>
            'Suggerimento AI aggiunto.',
          'advancedDiff.table.addedToTM' =>
            'Aggiunto alla Memoria di Traduzione',
          'advancedDiff.table.markedReviewed' =>
            'Contrassegnato come revisionato ✓',
          'advancedDiff.table.unmarkedReview' => 'Revisione annullata',
          'advancedDiff.table.reverted' => 'Ripristinato al valore sorgente',
          'advancedDiff.table.entryDeleted' => 'Voce eliminata',
          'advancedDiff.table.noSourceText' =>
            'Nessun testo sorgente da tradurre.',
          'advancedDiff.table.aiTranslationFailed' => ({required Object key}) =>
              'Traduzione AI fallita per "${key}"',
          'advancedDiff.table.noTargetText' =>
            'Nessun testo di destinazione da rielaborare.',
          'advancedDiff.table.aiRephraseFailed' => ({required Object key}) =>
              'Rielaborazione AI fallita per "${key}"',
          'advancedDiff.table.checkRowsFirst' =>
            'Seleziona prima le righe usando le caselle di controllo',
          'advancedDiff.table.markedRowsReviewed' => (
                  {required Object count}) =>
              'Contrassegnate ${count} righe come revisionate',
          'advancedDiff.table.revertedRows' => ({required Object count}) =>
              'Ripristinate ${count} righe',
          'advancedDiff.table.entriesCount' => ({required Object count}) =>
              '${count} voci',
          'advancedDiff.table.markSelectedReviewed' =>
            'Segna Selezionati come Revisionati',
          'advancedDiff.table.revertSelected' => 'Ripristina Selezionati',
          'advancedDiff.table.noDifferences' => 'Nessuna differenza trovata',
          'advancedDiff.table.adjustFilters' => 'Prova a regolare i filtri',
          'advancedDiff.table.cloudTranslationApplied' =>
            'Traduzione cloud applicata.',
          'advancedDiff.table.aiTranslationApplied' =>
            'Traduzione AI applicata.',
          'advancedDiff.table.suggestionApplied' => 'Suggerimento applicato.',
          'advancedDiff.table.aiSuggestionApplied' =>
            'Suggerimento AI applicato.',
          'advancedDiff.table.rephraseApplied' => 'Rielaborazione applicata.',
          'advancedDiff.table.aiRephraseApplied' =>
            'Rielaborazione AI applicata.',
          'advancedDiff.table.rephrase' => 'Rielabora',
          'advancedDiff.table.aiRephrase' => 'Rielabora con AI',
          'advancedDiff.table.targetClickToEdit' =>
            'DESTINAZIONE (Clicca per modificare)',
          'advancedDiff.table.targetClickForDialog' =>
            'DESTINAZIONE (Clicca per la finestra di dialogo)',
          'advancedDiff.table.emptyClickToEdit' =>
            '(Vuoto - Clicca per modificare)',
          'advancedDiff.table.unmarkReviewed' => 'Annulla revisione',
          'advancedDiff.table.markReviewed' => 'Segna come revisionato',
          'advancedDiff.table.revertToSource' => 'Ripristina a sorgente',
          'advancedDiff.table.translateWithCloud' => 'Traduci con Cloud',
          'advancedDiff.table.translateWithAi' => 'Traduci con AI',
          'advancedDiff.table.rephraseWithAi' => 'Rielabora con AI',
          'advancedDiff.table.moreActions' => 'Altre azioni',
          'advancedDiff.table.editDetails' => 'Modifica dettagli',
          'advancedDiff.table.suggestTranslation' => 'Suggerisci traduzione',
          'advancedDiff.table.addToTm' => 'Aggiungi a TM',
          'advancedDiff.table.deleteEntry' => 'Elimina voce',
          'advancedDiff.diffRow.copySource' => 'Copia testo sorgente',
          'advancedDiff.diffRow.actions' => 'Azioni',
          'advancedDiff.status.added' => 'AGGIUNTO',
          'advancedDiff.status.missing' => 'MANCANTE',
          'advancedDiff.status.changed' => ({required Object percent}) =>
              'MOD ${percent}%',
          'advancedDiff.status.same' => 'UGUALE',
          'advancedDiff.sidebar.widgets' => 'Widget',
          'advancedDiff.sidebar.searchPlaceholder' =>
            'Cerca chiavi e valori... (Ctrl+F)',
          'advancedDiff.sidebar.fuzzySearchTooltip' =>
            'Ricerca Fuzzy (tollerante agli errori)',
          'advancedDiff.sidebar.regexSearchTooltip' => 'Ricerca Regex',
          'advancedDiff.sidebar.cloudTranslation' => 'Traduzione Cloud',
          'advancedDiff.sidebar.aiTranslation' => 'Traduzione AI',
          'advancedDiff.sidebar.status' => 'Stato',
          'advancedDiff.sidebar.tm' => 'Memoria di Traduzione',
          'advancedDiff.sidebar.filters' => 'Filtri',
          'advancedDiff.sidebar.actions' => 'Azioni',
          'advancedDiff.sidebar.similarity' => 'Somiglianza',
          'advancedDiff.sidebar.actionsSection.exportMatches' =>
            'Esporta corrispondenze',
          'advancedDiff.sidebar.actionsSection.preview' => 'Anteprima',
          'advancedDiff.sidebar.actionsSection.fillFromTmTitle' =>
            'Riempire dalla Memoria di Traduzione?',
          'advancedDiff.sidebar.actionsSection.fillFromTmContent' =>
            'Questo tenterà di riempire i valori di destinazione vuoti usando le corrispondenze della Memoria di Traduzione. I valori esistenti NON verranno sovrascritti.',
          'advancedDiff.sidebar.actionsSection.fill' => 'Riempi',
          'advancedDiff.sidebar.actionsSection.fillFromMemory' =>
            'Riempi dalla Memoria',
          'advancedDiff.sidebar.actionsSection.filledFromTm' => (
                  {required Object count}) =>
              'Riempiti ${count} elementi dalla Memoria di Traduzione.',
          'advancedDiff.sidebar.aiSection.infoCloud' =>
            'Usa la traduzione cloud per tradurre i valori di destinazione vuoti dalla sorgente.',
          'advancedDiff.sidebar.aiSection.infoAi' =>
            'Usa l\'AI per tradurre i valori di destinazione vuoti dalla sorgente.',
          'advancedDiff.sidebar.aiSection.translationSettings' =>
            'Impostazioni Traduzione',
          'advancedDiff.sidebar.aiSection.aiSettings' => 'Impostazioni AI',
          'advancedDiff.sidebar.aiSection.source' => 'Sorgente',
          'advancedDiff.sidebar.aiSection.target' => 'Destinazione',
          'advancedDiff.sidebar.aiSection.translatingProgress' =>
            ({required Object percent}) => 'Traduzione in corso... ${percent}%',
          'advancedDiff.sidebar.aiSection.translating' =>
            'Traduzione in corso...',
          'advancedDiff.sidebar.aiSection.translateAllMissing' =>
            'Traduci Tutti i Mancanti',
          'advancedDiff.sidebar.aiSection.translateAllTitle' =>
            'Tradurre Tutti i Mancanti?',
          'advancedDiff.sidebar.aiSection.translateAllContent' => (
                  {required Object service,
                  required Object source,
                  required Object target}) =>
              'Questo userà ${service} per tradurre tutte le voci con valori di destinazione vuoti da ${source} a ${target}.\n\nYou can review ogni suggerimento o applicarli tutti in una volta.',
          'advancedDiff.sidebar.aiSection.translateAll' => 'Traduci Tutto',
          'advancedDiff.sidebar.aiSection.reviewEach' => 'Rivedi Singolarmente',
          'advancedDiff.sidebar.aiSection.cloudTranslated' => (
                  {required Object count}) =>
              'Tradotte ${count} voci con la traduzione cloud.',
          'advancedDiff.sidebar.aiSection.aiTranslated' =>
            ({required Object count}) => 'Tradotte ${count} voci con l\'AI.',
          'advancedDiff.sidebar.aiSection.aiTranslateFailed' =>
            'Traduzione AI massiva fallita',
          'advancedDiff.sidebar.aiSection.noMissingEntries' =>
            'Nessuna voce mancante da tradurre.',
          'advancedDiff.sidebar.aiSection.skip' => 'Salta',
          'advancedDiff.sidebar.aiSection.stop' => 'Ferma',
          'advancedDiff.sidebar.aiSection.cloudApplied' =>
            ({required Object count}) => 'Applicati ${count} suggerimenti.',
          'advancedDiff.sidebar.aiSection.aiApplied' =>
            ({required Object count}) => 'Applicati ${count} suggerimenti AI.',
          'advancedDiff.sidebar.tmSection.enableTmFill' =>
            'Abilita Riempimento TM',
          'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' =>
            'Applica auto. sopra il minimo',
          'advancedDiff.sidebar.tmSection.matchSettings' =>
            'Impostazioni Corrispondenza',
          'advancedDiff.sidebar.tmSection.minMatch' => 'Match min:',
          'advancedDiff.sidebar.tmSection.limit' => 'Limite:',
          'advancedDiff.sidebar.tmSection.exact' => 'Esatto',
          'advancedDiff.sidebar.filtersSection.viewFilters' => 'Filtri Vista',
          'advancedDiff.sidebar.filtersSection.showAll' => 'Mostra Tutto',
          'advancedDiff.sidebar.filtersSection.added' => 'Aggiunti',
          'advancedDiff.sidebar.filtersSection.removed' => 'Rimossi',
          'advancedDiff.sidebar.filtersSection.modified' => 'Modificati',
          'advancedDiff.sidebar.filtersSection.actionScope' => 'Ambito Azione',
          'advancedDiff.sidebar.filtersSection.applyToAdded' =>
            'Applica ad Aggiunti',
          'advancedDiff.sidebar.filtersSection.applyToModified' =>
            'Applica a Modificati',
          'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' =>
            'Riempi solo destinazioni vuote',
          'advancedDiff.sidebar.filtersSection.limitToVisible' =>
            'Limita al visibile',
          'advancedDiff.sidebar.filtersSection.editMode' => 'Modalità Modifica',
          'advancedDiff.sidebar.filtersSection.dialog' => 'Dialogo',
          'advancedDiff.sidebar.filtersSection.inline' => 'In riga',
          'advancedDiff.sidebar.similaritySection.currentFilter' =>
            'Filtro Attuale:',
          'advancedDiff.sidebar.similaritySection.any' => 'QUALSIASI',
          'advancedDiff.sidebar.similaritySection.high' => 'ALTA',
          'advancedDiff.sidebar.similaritySection.medium' => 'MEDIA',
          'advancedDiff.sidebar.similaritySection.low' => 'BASSA',
          'advancedDiff.sidebar.statusSection.total' =>
            ({required Object count}) => '${count} totali',
          'advancedDiff.sidebar.statusSection.extra' =>
            ({required Object count}) => '${count} extra',
          'advancedDiff.sidebar.statusSection.missing' =>
            ({required Object count}) => '${count} mancanti',
          'advancedDiff.sidebar.statusSection.changed' =>
            ({required Object count}) => '${count} modificati',
          'issueDetails.title' => 'Dettagli Problema',
          'issueDetails.showingIssues' => (
                  {required Object count, required Object total}) =>
              'Visualizzazione di ${count} su ${total} problemi',
          'issueDetails.searchPlaceholder' =>
            'Cerca per chiave, testo o errore...',
          'issueDetails.noDetails' => 'Nessun dettaglio disponibile.',
          'issueDetails.noMatches' => 'Nessuna corrispondenza trovata.',
          'issueDetails.showMore' => 'Mostra Altro',
          'issueDetails.copyItems' => ({required Object count}) =>
              'Copia ${count} elementi',
          'issueDetails.close' => 'Chiudi',
          'issueDetails.copied' => 'Copiato negli appunti',
          'issueDetails.copiedCount' => ({required Object count}) =>
              'Copiati ${count} elementi',
          'issueDetails.duplicateValue.label' => 'TRADUZIONE RIPETUTA',
          'issueDetails.duplicateValue.warning' =>
            'Diversi testi sorgente usano questa stessa traduzione. Controlla il contesto.',
          'issueDetails.duplicateValue.affectedKeys' =>
            ({required Object count}) => 'CHIAVI INTERESSATE (${count})',
          'issueDetails.duplicateValue.identicalSources' =>
            'Sorgenti Identiche',
          'issueDetails.duplicateValue.moreKeys' => ({required Object count}) =>
              '+altre ${count} chiavi',
          'issueDetails.lengthOutlier.source' => 'SORGENTE',
          'issueDetails.lengthOutlier.translation' => 'TRADUZIONE',
          'issueDetails.lengthOutlier.chars' => ({required Object count}) =>
              '${count} caratt.',
          'issueDetails.standard.key' => 'CHIAVE',
          'issueDetails.standard.sourceText' => 'TESTO SORGENTE',
          'issueDetails.standard.translation' => 'TRADUZIONE',
          'issueDetails.standard.errorDetails' => 'DETTAGLI ERRORE',
          'issueDetails.standard.note' => 'NOTA',
          'issueDetails.review' => 'Revisione',
          'issueDetails.types.duplicateValue' => 'Valori Duplicati',
          'issueDetails.types.lengthOutlier' => 'Discrepanza Lunghezza',
          'issueDetails.types.placeholderMismatch' => 'Segnaposto Danneggiati',
          'issueDetails.notes.placeholderMismatch' =>
            'Marcatori come {name} dovrebbero corrispondere alla sorgente.',
          'issueDetails.notes.lengthOutlier' =>
            'Grandi cambiamenti di lunghezza possono influenzare come il testo si adatta allo schermo.',
          'issueDetails.notes.duplicateValue' =>
            'La stessa traduzione è usata per diverse chiavi.',
          'issueDetails.fallbacks.multipleSources' => 'Più testi sorgente',
          'issueDetails.fallbacks.sourceNotAvailable' =>
            'Testo sorgente non disponibile',
          'issueDetails.fallbacks.sharedTranslationNotAvailable' =>
            'Traduzione condivisa non disponibile',
          'issueDetails.fallbacks.translationNotAvailable' =>
            'Traduzione non disponibile',
          'importReview.title' => 'Revisione Importazione Progetto',
          'importReview.projectName' => 'Nome Progetto',
          'importReview.created' => 'Creato',
          'importReview.historyItems' => 'Elementi Cronologia',
          'importReview.customSettingsTitle' =>
            'Rilevate Impostazioni Personalizzate',
          'importReview.customSettingsWarning' =>
            'Questo progetto contiene impostazioni personalizzate che sovrascriveranno i tuoi predefiniti mentre il progetto è aperto.',
          'importReview.standardSettings' =>
            'Questo progetto usa le impostazioni globali standard.',
          'importReview.cancelImport' => 'Annulla Importazione',
          'importReview.trustOpen' => 'Fidati e Apri Progetto',
          'historyView.title' => 'Cronologia Confronti',
          'historyView.clearAll' => 'Cancella tutta la cronologia',
          'historyView.searchPlaceholder' => 'Cerca per nome file...',
          'historyView.sortBy' => 'Ordina per',
          'historyView.sortDate' => 'Data',
          'historyView.sortSource' => 'File Sorgente',
          'historyView.sortTarget' => 'File Target',
          'historyView.showCurrentProject' =>
            'Visualizzazione: Progetto Corrente',
          'historyView.showAllHistory' =>
            'Visualizzazione: Tutta la Cronologia',
          'historyView.groupByFolder' => 'Raggruppa per cartella',
          'historyView.disableGrouping' => 'Disabilita raggruppamento cartelle',
          'historyView.filterAll' => 'Tutti',
          'historyView.filterFiles' => 'File',
          'historyView.filterDirectories' => 'Cartelle',
          'historyView.filterGit' => 'Git',
          'historyView.noHistory' => 'Ancora nessuna cronologia confronti',
          'historyView.historyDescription' =>
            'I tuoi confronti appariranno qui',
          'historyView.noResults' => 'Nessun risultato trovato',
          'historyView.adjustSearch' => 'Prova a regolare la ricerca',
          'historyView.clearConfirmationTitle' =>
            'Cancellare Tutta la Cronologia?',
          'historyView.clearConfirmationContent' =>
            'Questo eliminerà permanentemente tutta la cronologia dei confronti. L\'azione è irreversibile.',
          'historyView.clearAction' => 'Cancella Tutto',
          'historyView.deletedMessage' => 'Elemento cronologia eliminato',
          'historyView.undo' => 'Annulla',
          'historyView.viewDetails' => 'Visualizza Dettagli',
          'historyView.delete' => 'Elimina',
          'historyView.openLocation' => 'Apri posizione file',
          'historyView.bilingual' => 'Bilingue',
          'historyView.filePair' => 'Coppia di File',
          'historyView.directory' => 'Cartella',
          'historyView.git' => 'Git',
          'historyView.repo' => 'Repo',
          'historyView.sourceDir' => 'Dir Sorgente',
          'historyView.targetDir' => 'Dir Target',
          'historyView.source' => 'Sorgente',
          'historyView.target' => 'Target',
          'historyView.noChanges' => 'Nessuna modifica rilevata',
          'historyView.added' => 'Aggiunti',
          'historyView.removed' => 'Rimossi',
          'historyView.modified' => 'Modificati',
          'historyView.same' => 'Uguali',
          'historyView.total' => 'Totale',
          'historyView.currentProject' => 'Progetto Corrente',
          'historyView.unassigned' => 'Non assegnato',
          'historyView.project' => 'Progetto',
          'compare.title' => 'Confronta File',
          'compare.sourceFile' => 'File Sorgente',
          'compare.targetFile' => 'File Target',
          'compare.sourceFolder' => 'Cartella Sorgente',
          'compare.targetFolder' => 'Cartella Target',
          'compare.dropFilesHint' =>
            'Trascina i file di localizzazione qui o usa i pulsanti sfoglia per selezionare i file da confrontare.',
          'compare.selectSourceFile' => 'Seleziona file sorgente',
          'compare.selectTargetFile' => 'Seleziona file target',
          'compare.startComparison' => 'Avvia Confronto',
          'compare.comparing' => 'Confronto in corso...',
          'compare.comparisonComplete' => 'Confronto completato',
          'compare.noChanges' => 'Nessuna modifica rilevata',
          'compare.filesIdentical' => 'I file sono identici',
          'compare.changesFound' => ({required Object count}) =>
              '${count} modifiche trovate',
          'compare.tabs.files' => 'File',
          'compare.tabs.directories' => 'Cartelle',
          'compare.tabs.git' => 'Git',
          'compare.fileTypes.json' =>
            'File di localizzazione JSON (i18next, Flutter, ecc.)',
          'compare.fileTypes.yaml' =>
            'File di localizzazione YAML (Rails, Flutter)',
          'compare.fileTypes.xml' =>
            'File di localizzazione XML (Android, .NET)',
          'compare.fileTypes.properties' => 'File properties (Java)',
          'compare.fileTypes.resx' => 'File RESX (.NET)',
          _ => null,
        } ??
        switch (path) {
          'compare.fileTypes.xliff' => 'File XLIFF',
          'history.title' => 'Cronologia',
          'history.recentComparisons' => 'Confronti Recenti',
          'history.noHistory' => 'Ancora nessuna cronologia confronti',
          'history.noHistoryDescription' => 'La tua cronologia apparirà qui',
          'history.clearHistory' => 'Cancella Cronologia',
          'history.clearHistoryConfirm' =>
            'Sei sicuro di voler cancellare tutta la cronologia?',
          'history.deleteEntry' => 'Elimina Voce',
          'history.openComparison' => 'Apri Confronto',
          'history.timeAgo.justNow' => 'proprio ora',
          'history.timeAgo.secondsAgo' => ({required Object count}) =>
              '${count} secondi fa',
          'history.timeAgo.oneMinuteAgo' => '1 minuto fa',
          'history.timeAgo.minutesAgo' => ({required Object count}) =>
              '${count} minuti fa',
          'history.timeAgo.oneHourAgo' => '1 ora fa',
          'history.timeAgo.hoursAgo' => ({required Object count}) =>
              '${count} ore fa',
          'history.timeAgo.yesterday' => 'ieri',
          'history.timeAgo.daysAgo' => ({required Object count}) =>
              '${count} giorni fa',
          'history.timeAgo.oneWeekAgo' => '1 settimana fa',
          'history.timeAgo.weeksAgo' => ({required Object count}) =>
              '${count} settimane fa',
          'history.timeAgo.oneMonthAgo' => '1 mese fa',
          'history.timeAgo.monthsAgo' => ({required Object count}) =>
              '${count} mesi fa',
          'history.timeAgo.oneYearAgo' => '1 anno fa',
          'history.timeAgo.yearsAgo' => ({required Object count}) =>
              '${count} anni fa',
          'history.timeAgo.inTheFuture' => 'nel futuro',
          'projects.title' => 'Progetti',
          'projects.createProject' => 'Crea Progetto',
          'projects.importProject' => 'Importa Progetto',
          'projects.noProjects' => 'Ancora nessun progetto',
          'projects.noProjectsDescription' =>
            'Crea un progetto per organizzare i tuoi file di localizzazione',
          'projects.projectName' => 'Nome Progetto',
          'projects.projectPath' => 'Percorso Progetto',
          'projects.lastOpened' => 'Ultima apertura',
          'projects.openProject' => 'Apri Progetto',
          'projects.closeProject' => 'Chiudi Progetto',
          'projects.deleteProject' => 'Elimina Progetto',
          'projects.deleteProjectConfirm' =>
            'Sei sicuro di voler eliminare questo progetto?',
          'projects.exportProject' => 'Esporta Progetto',
          'projects.exportDescription' =>
            'Crea un file zip portatile contenente i file sorgente, la configurazione e la cronologia.',
          'projects.exporting' => 'Esportazione progetto...',
          'projects.exportSuccess' => 'Progetto esportato',
          'projects.exportError' => ({required Object error}) =>
              'Esportazione fallita: ${error}',
          'projects.createNewProject' => 'Crea Nuovo Progetto',
          'projects.openExistingProject' => 'Apri Progetto Esistente',
          'projects.importProjectZip' => 'Importa Zip Progetto',
          'projects.projectResources' => 'Risorse Progetto',
          'projects.recentProjects' => 'Progetti Recenti',
          'projects.noRecentProjects' => 'Nessun progetto recente',
          'projects.selectProjectZip' => 'Seleziona Zip Progetto',
          'projects.selectDestination' =>
            'Seleziona Cartella di Destinazione per l\'Importazione',
          'projects.importing' => 'Importazione progetto...',
          'projects.importSuccess' => 'Progetto importato con successo',
          'projects.importFailed' => ({required Object error}) =>
              'Importazione fallita: ${error}',
          'projects.importingFiles' => 'Importazione file...',
          'projects.noSupportedFiles' =>
            'Non sono stati trascinati file supportati.',
          'projects.stats.empty' => 'Progetto vuoto',
          'projects.stats.files' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
                n,
                one: '1 file di traduzione',
                other: '${count} file di traduzione',
              ),
          'projects.stats.languages' => (
                  {required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
                n,
                one: '1 lingua',
                other: '${count} lingue',
              ),
          'projects.openProjectFirst' =>
            'Apri prima un progetto per gestire le sue risorse.',
          'projects.removeFromRecent' => 'Rimuovi dai recenti',
          'projects.selection.selectFolder' => 'Seleziona Cartella Progetto',
          'projects.selection.selectArchive' => 'Seleziona Archivio Progetto',
          'projects.selection.openProject' => 'Apri Progetto',
          'projects.selection.browseFolder' => 'Sfoglia Cartella...',
          'projects.selection.createNew' => 'Crea Nuovo',
          'projects.selection.importFromZip' => 'Importa da Zip...',
          'projects.createDialog.title' => 'Crea Progetto',
          'projects.createDialog.description' =>
            'Un progetto ti permette di salvare impostazioni personalizzate per una cartella specifica. Verrà creata una cartella ".localizer" per memorizzare la configurazione del progetto.',
          'projects.createDialog.folderLabel' => 'Cartella Progetto',
          'projects.createDialog.folderHint' =>
            'Clicca per selezionare la cartella...',
          'projects.createDialog.nameLabel' => 'Nome Progetto',
          'projects.createDialog.nameHint' => 'es., Traduzioni Mia App',
          'projects.createDialog.selectFolderWarning' =>
            'Seleziona una cartella progetto.',
          'projects.createDialog.enterNameError' =>
            'Inserisci un nome progetto',
          'projects.createDialog.nameLengthError' =>
            'Il nome deve essere di almeno 2 caratteri',
          'projects.createDialog.success' => ({required Object name}) =>
              'Progetto "${name}" creato con successo!',
          'projects.createDialog.failure' => 'Impossibile creare il progetto.',
          'projects.createDialog.creating' => 'Creazione...',
          'projects.createDialog.createAction' => 'Crea Progetto',
          'projects.indicator.tooltipNoProject' =>
            'Crea un progetto per salvare impostazioni personalizzate per una cartella',
          'projects.indicator.tooltipProject' => ({required Object name}) =>
              'Progetto: ${name}\nClicca per vedere le opzioni',
          'projects.indicator.location' => 'Posizione',
          'projects.indicator.created' => 'Creato',
          'projects.indicator.switchProject' => 'Cambia Progetto',
          'projects.indicator.done' => 'Fatto',
          'projects.glossary.title' => 'Glossario Progetto',
          'projects.glossary.description' =>
            'Definisci i termini che devono essere trattati in modo coerente o mai tradotti.',
          'projects.glossary.noTerms' => 'Ancora nessun termine nel glossario.',
          'projects.glossary.noTermsDesc' =>
            'Aggiungi termini che devono rimanere coerenti tra le traduzioni,\no contrassegna i nomi dei brand che non devono mai essere tradotti.',
          'projects.glossary.doNotTranslate' => 'Non tradurre',
          'projects.glossary.noSpecificTranslation' =>
            'Nessuna traduzione specifica',
          'projects.glossary.addTerm' => 'Aggiungi Termine',
          'projects.glossary.editTerm' => 'Modifica Termine',
          'projects.glossary.term' => 'Termine',
          'projects.glossary.termHint' =>
            'es., nome brand, termine specialistico',
          'projects.glossary.definition' => 'Definizione (Opzionale)',
          'projects.glossary.definitionHint' => 'Contesto per il traduttore',
          'projects.glossary.doNotTranslateLabel' => 'Non Tradurre',
          'projects.glossary.doNotTranslateDesc' =>
            'Mantieni il termine esattamente com\'è nella destinazione',
          'projects.glossary.preferredTranslation' => 'Traduzione Preferita',
          'projects.glossary.caseSensitive' => 'Case Sensitive',
          'projects.conflicts.missingApiKeyTitle' =>
            ({required Object service}) => 'Chiave API mancante per ${service}',
          'projects.conflicts.missingApiKeyMessage' => (
                  {required Object service}) =>
              'Questo progetto usa ${service} ma non è configurata alcuna chiave API. Aggiungi la tua chiave API in Impostazioni > Servizi AI, altrimenti l\'app userà il predefinito globale.',
          'projects.conflicts.dismiss' => 'Ignora',
          'projects.tm.title' => 'Memorie di Traduzione',
          'projects.tm.description' =>
            'Gestisci le sorgenti della memoria di traduzione per questo progetto.',
          'projects.tm.globalTm' => 'Memoria di Traduzione Globale',
          'projects.tm.globalTmDescription' =>
            'Usa la memoria di traduzione condivisa dalle impostazioni dell\'app',
          'projects.tm.linkedFiles' =>
            'File Collegati (Specifici del Progetto)',
          'projects.tm.noLinkedFiles' =>
            'Nessun file specifico del progetto collegato.',
          'projects.tm.addTmFile' => 'Aggiungi File TM',
          'projects.tm.useGlobalTm' => 'Usa TM Globale',
          'projects.tm.selectTm' => 'Seleziona Memoria di Traduzione',
          'projects.tm.globalTmEnabled' =>
            'Memoria di Traduzione Globale abilitata',
          'diff.added' => 'Aggiunto',
          'diff.removed' => 'Rimosso',
          'diff.modified' => 'Modificato',
          'diff.unchanged' => 'Invariato',
          'diff.missing' => 'Mancante',
          'diff.extra' => 'Extra',
          'diff.sourceValue' => 'Valore Sorgente',
          'diff.targetValue' => 'Valore Target',
          'diff.key' => 'Chiave',
          'diff.status' => 'Stato',
          'diff.actions' => 'Azioni',
          'diff.copyToTarget' => 'Copia in Target',
          'diff.acceptChange' => 'Accetta Modifica',
          'diff.rejectChange' => 'Rifiuta Modifica',
          'diff.viewDetails' => 'Visualizza Dettagli',
          'git.title' => 'Confronto Git',
          'git.selectRepository' => 'Seleziona Repository',
          'git.selectBranch' => 'Seleziona Branch',
          'git.selectCommit' => 'Seleziona Commit',
          'git.compareBranches' => 'Confronta Branch',
          'git.compareCommits' => 'Confronta Commit',
          'git.baseBranch' => 'Branch Base',
          'git.compareBranch' => 'Branch di Confronto',
          'git.noRepositories' => 'Nessun repository Git trovato',
          'git.noRepositoriesDescription' =>
            'Apri una cartella contenente un repository Git',
          'git.filesChanged' => ({required Object count}) =>
              '${count} file modificati',
          'git.additions' => ({required Object count}) => '${count} aggiunte',
          'git.deletions' => ({required Object count}) => '${count} rimozioni',
          'git.conflicts.title' => 'Rilevati Conflitti di Merge',
          'git.conflicts.description' =>
            'Devi risolvere questi conflitti prima di poter continuare.',
          'git.conflicts.abortMergeTitle' => 'Annullare Merge?',
          'git.conflicts.abortMergeContent' =>
            'Questo annullerà tutte le modifiche del merge e tornerà allo stato precedente. L\'azione è irreversibile.',
          'git.conflicts.abortMergeAction' => 'Annulla Merge',
          'git.conflicts.stagingFile' => ({required Object file}) =>
              'Messa in staging di ${file} per il commit...',
          'git.conflicts.conflictedFilesCount' => ({required Object count}) =>
              'File in Conflitto (${count})',
          'git.conflicts.selectFileToResolve' =>
            'Seleziona un file da risolvere',
          'git.conflicts.resolvingFile' => ({required Object file}) =>
              'Risoluzione: ${file}',
          'git.conflicts.keepAllOurs' => 'Mantieni Tutto Nostro (Ours)',
          'git.conflicts.acceptAllTheirs' => 'Accetta Tutto Loro (Theirs)',
          'git.conflicts.allResolved' =>
            'Tutti i conflitti in questo file sono stati risolti!',
          'git.conflicts.markResolved' => 'Segna come Risolto',
          'git.conflicts.stageForCommit' =>
            'Questo metterà il file in staging per il commit.',
          'git.conflicts.conflictIndex' => ({required Object index}) =>
              'Conflitto #${index}',
          'git.conflicts.ours' => 'NOSTRO (Corrente)',
          'git.conflicts.theirs' => 'LORO (In arrivo)',
          'git.conflicts.keepOurs' => 'Mantieni Nostro',
          'git.conflicts.acceptTheirs' => 'Accetta Loro',
          'git.conflicts.empty' => '(Vuoto)',
          'quality._translatorNote' =>
            'I termini API e metriche (Requests, Tokens, Characters, Prompt, Completion, Export) devono rimanere in inglese per tutte le traduzioni per mantenere la coerenza con la terminologia del settore.',
          'quality.title' => 'Dashboard Qualità',
          'quality.overallScore' => 'Punteggio Complessivo',
          'quality.issues' => 'Problemi',
          'quality.warnings' => 'Avvisi',
          'quality.suggestions' => 'Suggerimenti',
          'quality.placeholderMismatch' => 'Discrepanza Segnaposto',
          'quality.placeholderMismatchDescription' =>
            'I segnaposto come {name} non corrispondono tra sorgente e destinazione',
          'quality.lengthOutlier' => 'Anomalia Lunghezza',
          'quality.lengthOutlierDescription' =>
            'La lunghezza della traduzione differisce significativamente dalla sorgente',
          'quality.duplicateValue' => 'Valore Duplicato',
          'quality.duplicateValueDescription' =>
            'La stessa traduzione è usata per più chiavi',
          'quality.missingTranslation' => 'Traduzione Mancante',
          'quality.missingTranslationDescription' =>
            'Manca la traduzione per questa chiave',
          'quality.loading' => 'Caricamento dashboard...',
          'quality.errorLoading' =>
            'Impossibile caricare la cronologia. Riprova.',
          'quality.emptyState' =>
            'Esegui un confronto per vedere la tua dashboard.',
          'quality.refresh' => 'Aggiorna',
          'quality.buildingInsights' => 'Analisi in corso...',
          'quality.crunchingNumbers' => 'Elaborazione dati...',
          'quality.errorBuilding' =>
            'Impossibile creare la dashboard. Riprova.',
          'quality.noUsableData' => 'Ancora nessun dato utilizzabile trovato.',
          'quality.languages' => 'Lingue',
          'quality.averageCoverage' => 'Copertura media',
          'quality.potentialIssues' => 'Problemi potenziali',
          'quality.translationCoverage' => 'Copertura traduzione',
          'quality.entriesTranslated' => (
                  {required Object translated, required Object total}) =>
              '${translated} su ${total} voci tradotte',
          'quality.wordsAddedOverTime' => 'Parole aggiunte nel tempo',
          'quality.completionVsScope' => 'Completamento vs Ambito',
          'quality.scopeVsProgress' => 'Ambito vs Progresso',
          'quality.coveragePercent' => 'Copertura %',
          'quality.wordsAdded' => 'Parole Aggiunte',
          'quality.words' => 'Parole',
          'quality.coverage' => 'Copertura',
          'quality.scope' => 'Ambito',
          'quality.latest' => 'Recente',
          'quality.added' => 'Aggiunte',
          'quality.change' => 'Modifica',
          'quality.totalScope' => 'Ambito Totale',
          'quality.wordsCount' => ({required Object count}) =>
              '${count} parole',
          'quality.scopeGrowth' => 'Crescita Ambito',
          'quality.range' => 'Intervallo',
          'quality.aiUsage' => 'Utilizzo AI e Traduzione',
          'quality.lastUsed' => ({required Object date}) =>
              'Ultimo utilizzo ${date}',
          'quality.noIssuesFound' =>
            'Nessun problema trovato negli ultimi confronti.',
          'quality.placeholderMismatches' => 'Discrepanze segnaposto',
          'quality.placeholderMismatchesDesc' =>
            'I marcatori come {name} non corrispondono.',
          'quality.lengthOutliers' => 'Traduzioni molto corte o lunghe',
          'quality.lengthOutliersDesc' =>
            'La lunghezza sembra insolita rispetto alla sorgente.',
          'quality.duplicateValues' => 'Valori duplicati',
          'quality.duplicateValuesDesc' =>
            'La stessa traduzione è usata molte volte.',
          'quality.placeholderDialogTitle' => 'Discrepanze Segnaposto',
          'quality.placeholderDialogDesc' =>
            'Queste traduzioni hanno segnaposto ({name}) diversi dalla sorgente.',
          'quality.lengthDialogTitle' => 'Anomalie di Lunghezza',
          'quality.lengthDialogDesc' =>
            'Queste traduzioni sono significativamente più corte o più lunghe della sorgente.',
          'quality.duplicateDialogTitle' => 'Valori Duplicati',
          'quality.duplicateDialogDesc' =>
            'Queste traduzioni appaiono più volte.',
          'quality.duplicateSample' => ({required Object value}) =>
              'Duplicato: "${value}"',
          'quality.exportError' => 'Impossibile generare il report. Riprova.',
          'quality.noDataToExport' => 'Nessun dato da esportare',
          'quality.exportFailed' => 'Esportazione fallita',
          'quality.exportDialogTitle' => 'Esporta Report Qualità',
          'quality.reportSaved' => 'Report salvato',
          'quality.export' => 'Esporta',
          'quality.requests' => 'Richieste',
          'quality.tokens' => 'Token',
          'quality.characters' => 'Caratteri',
          'quality.estCost' => 'Costo stimato',
          'quality.prompt' => 'Prompt',
          'quality.completion' => 'Completamento',
          'quality.showingCurrentProject' =>
            'Visualizzazione: Progetto Corrente',
          'quality.showingAllHistory' => 'Visualizzazione: Tutta la Cronologia',
          'quality.filesSkipped' =>
            'Alcuni file sono stati saltati perché non trovati.',
          'quality.charCount' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
                n,
                one: '1 carattere',
                other: '${count} caratteri',
              ),
          'quality.lengthDiff' => (
                  {required Object target,
                  required Object percent,
                  required Object source}) =>
              'Target è ${target} (${percent}%) vs sorgente ${source}',
          'errors.genericError' => 'Si è verificato un errore',
          'errors.fileNotFound' => 'File non trovato',
          'errors.invalidFormat' => 'Formato file non valido',
          'errors.parseError' => 'Impossibile analizzare il file',
          'errors.networkError' =>
            'Errore di rete. Controlla la tua connessione.',
          'errors.permissionDenied' => 'Permesso negato',
          'errors.unknownError' => 'Si è verificato un errore sconosciuto',
          'wizards.firstRun.welcome' => 'Benvenuto in Localizer',
          'wizards.firstRun.description' =>
            'Confronta i tuoi file di localizzazione in pochi secondi.',
          'wizards.firstRun.sourceFile' => 'File Sorgente',
          'wizards.firstRun.targetFile' => 'File Target',
          'wizards.firstRun.compareNow' => 'Confronta Ora',
          'wizards.firstRun.trySample' => 'Prova con Dati di Esempio',
          'wizards.firstRun.skip' => 'Salta Configurazione',
          'wizards.firstRun.browse' => 'Clicca per sfogliare',
          'wizards.firstRun.error' => ({required Object error}) =>
              'Impossibile caricare i dati di esempio: ${error}',
          'dialogs.addIgnorePattern.title' => 'Aggiungi Pattern da Ignorare',
          'dialogs.addIgnorePattern.patternLabel' => 'Pattern (regex)',
          'dialogs.addIgnorePattern.hint' => 'es., ^temp_.*',
          'dialogs.addIgnorePattern.invalid' => 'Pattern regex non valido',
          'dialogs.addIgnorePattern.testStringLabel' => 'Stringa di Test',
          'dialogs.addIgnorePattern.testHint' =>
            'Inserisci una chiave da testare contro il pattern',
          'dialogs.addIgnorePattern.match' =>
            '✓ Il pattern corrisponde alla stringa di test',
          'dialogs.addIgnorePattern.noMatch' => '✗ Il pattern non corrisponde',
          'dialogs.addIgnorePattern.add' => 'Aggiungi',
          'dialogs.addIgnorePattern.cancel' => 'Annulla',
          'dialogs.diffViewer.title' => 'Visualizzatore Diff',
          'dialogs.diffViewer.originalFile' => 'File Originale/di riferimento',
          'dialogs.diffViewer.translationFile' =>
            'File di Traduzione/Confronto',
          'dialogs.diffViewer.base' => 'BASE',
          'dialogs.diffViewer.target' => 'TARGET',
          'dialogs.diffViewer.added' => 'Aggiunto',
          'dialogs.diffViewer.removed' => 'Rimosso',
          'dialogs.diffViewer.modified' => 'Modificato',
          'dialogs.diffViewer.noMatches' =>
            'Nessuna voce corrisponde ai filtri attuali',
          'dialogs.diffViewer.clickToggle' =>
            'Clicca sui badge sopra per attivare i filtri',
          'dialogs.diffViewer.clickToHide' => '(clicca per nascondere)',
          'dialogs.diffViewer.clickToShow' => '(clicca per mostrare)',
          'grid.columns.key' => 'Chiave',
          'grid.columns.source' => 'Sorgente',
          'grid.columns.status' => 'Stato',
          'grid.columns.actions' => 'Azioni',
          'tutorial.skipTutorial' => 'SALTA TUTORIAL',
          'tutorial.finishMessage' => 'Sei pronto! Tocca ovunque per finire.',
          'tutorial.next' => 'Avanti',
          'tutorial.loadSampleData' => 'Carica Dati di Esempio',
          'tutorial.browseSourceFile' => 'Sfoglia File Sorgente',
          'tutorial.browseTargetFile' => 'Sfoglia File Target',
          'tutorial.compareFiles' => 'Confronta File',
          'tutorial.hintPhase2' =>
            'Prossimo: filtri, ricerca, vista avanzata ed esportazione.',
          'tutorial.steps.importSource.title' => '1. Importa File Sorgente',
          'tutorial.steps.importSource.description' =>
            'Usa il pulsante sotto per sfogliare un file, o trascinalo nell\'area evidenziata.',
          'tutorial.steps.importTarget.title' => '2. Importa File Target',
          'tutorial.steps.importTarget.description' =>
            'Usa il pulsante sotto per sfogliare un file, o trascinalo nell\'area evidenziata.',
          'tutorial.steps.compare.title' => '3. Confronta File',
          'tutorial.steps.compare.description' =>
            'Tocca il pulsante sotto per avviare il confronto e vedere i risultati.',
          'tutorial.steps.filter.title' => '4. Filtra i Risultati',
          'tutorial.steps.filter.description' =>
            'Usa questi filtri per visualizzare le stringhe Aggiunte, Rimosse o Modificate.',
          'tutorial.steps.search.title' => '5. Cerca nei Risultati',
          'tutorial.steps.search.description' =>
            'Trova chiavi o valori specifici usando la barra di ricerca.',
          'tutorial.steps.advanced.title' => '6. Vista Avanzata',
          'tutorial.steps.advanced.description' =>
            'Apri la vista diff dettagliata con editing, traduzione AI e altro.',
          'tutorial.steps.export.title' => '7. Esporta Risultati',
          'tutorial.steps.export.description' =>
            'Salva il tuo confronto come file CSV, JSON o Excel.',
          'friendlyErrors.fileNotFound.message' =>
            'Impossibile trovare il file o la cartella.',
          'friendlyErrors.fileNotFound.suggestion' =>
            'Verifica se il file è stato spostato o eliminato.',
          'friendlyErrors.accessDenied.message' => 'Accesso al file negato.',
          'friendlyErrors.accessDenied.suggestion' =>
            'Prova ad avviare l\'app come amministratore o controlla i permessi del file.',
          'friendlyErrors.isDirectory.message' =>
            'È stata selezionata una cartella invece di un file.',
          'friendlyErrors.isDirectory.suggestion' =>
            'Seleziona un file valido.',
          'friendlyErrors.fileAccess.message' =>
            'Si è verificato un problema nell\'accesso al file.',
          'friendlyErrors.fileAccess.suggestion' =>
            'Prova a chiudere altri programmi che potrebbero usarlo.',
          'friendlyErrors.unsupportedFormat.message' =>
            'Questo formato di file o operazione non è supportato.',
          'friendlyErrors.unsupportedFormat.suggestion' =>
            'Controlla l\'estensione del file o prova un formato diverso.',
          'friendlyErrors.networkError.message' =>
            'Impossibile connettersi al server.',
          'friendlyErrors.networkError.suggestion' =>
            'Controlla la tua connessione internet e riprova.',
          'friendlyErrors.notGitRepo.message' =>
            'Questa cartella non è un progetto Git.',
          'friendlyErrors.notGitRepo.suggestion' =>
            'Naviga in una cartella che contiene una directory .git.',
          'friendlyErrors.mergeConflict.message' =>
            'Ci sono conflitti di merge nel repository.',
          'friendlyErrors.mergeConflict.suggestion' =>
            'Risolvi i conflitti prima di continuare.',
          'friendlyErrors.gitAuthFailed.message' =>
            'Autenticazione Git fallita.',
          'friendlyErrors.gitAuthFailed.suggestion' =>
            'Controlla le tue credenziali in Impostazioni > Version Control.',
          'friendlyErrors.gitOperationFailed.message' =>
            'Un\'operazione Git è fallita.',
          'friendlyErrors.gitOperationFailed.suggestion' =>
            'Controlla la vista Git per maggiori dettagli.',
          'friendlyErrors.invalidJson.message' =>
            'Il formato del file non è valido o è corrotto.',
          'friendlyErrors.invalidJson.suggestion' =>
            'Assicurati che il file contenga contenuto JSON valido.',
          'friendlyErrors.rateLimitReached.message' =>
            'Limite di traduzione raggiunto.',
          'friendlyErrors.rateLimitReached.suggestion' =>
            'Attendi qualche minuto o controlla i limiti del tuo piano API.',
          'friendlyErrors.invalidApiKey.message' => 'Chiave API non valida.',
          'friendlyErrors.invalidApiKey.suggestion' =>
            'Vai in Impostazioni > Traduzione AI per aggiornare la tua chiave API.',
          'friendlyErrors.translationServiceError.message' =>
            'Errore del servizio di traduzione.',
          'friendlyErrors.translationServiceError.suggestion' =>
            'Controlla la tua chiave API e la connessione internet.',
          'friendlyErrors.outOfMemory.message' =>
            'Memoria insufficiente per completare l\'operazione.',
          'friendlyErrors.outOfMemory.suggestion' =>
            'Prova a chiudere altre applicazioni o usa file più piccoli.',
          'friendlyErrors.genericError.message' => 'Qualcosa è andato storto.',
          'friendlyErrors.genericError.suggestion' =>
            'Riprova. Se il problema persiste, riavvia l\'app.',
          'systemTray.showLocalizer' => 'Mostra Localizer',
          'systemTray.exit' => 'Esci',
          'validation.connected' => 'Connesso.',
          'validation.connectionTimeout' => 'Connessione scaduta. Riprova.',
          'validation.couldNotConnect' => 'Impossibile connettersi. Riprova.',
          'validation.checkKeyAndTryAgain' =>
            'Impossibile connettersi. Controlla la chiave e riprova.',
          'validation.tryAgainLater' =>
            'Impossibile connettersi ora. Riprova più tardi.',
          'validation.serviceUnavailable' =>
            'Il servizio non è disponibile al momento. Riprova più tardi.',
          'validation.enterKeyFirst' => 'Inserisci prima una chiave.',
          'validation.checking' => 'Verifica in corso...',
          'validation.deeplUsage' => (
                  {required Object used, required Object limit}) =>
              'Utilizzo: ${used} / ${limit} caratteri.',
          'status.startingComparison' => 'Avvio confronto...',
          'status.loadingFromHistory' => 'Caricamento file dalla cronologia...',
          'status.comparisonComplete' => 'Confronto completato',
          'status.couldNotImportFiles' =>
            'Impossibile importare i file. Riprova.',
          'status.historyFilesNotFound' =>
            'Uno o entrambi i file della cronologia non sono stati trovati nei percorsi originali.',
          'aiServices.geminiEmptyResponse' =>
            'Gemini ha restituito una risposta vuota',
          'aiServices.geminiStreamingEmpty' =>
            'Lo streaming di Gemini ha restituito una risposta vuota',
          'aiServices.geminiRephraseEmpty' =>
            'Gemini ha restituito una risposta vuota per la rielaborazione',
          'aiServices.openaiEmptyResponse' =>
            'OpenAI ha restituito una risposta vuota o fallita',
          'diffTable.columns.id' => '#',
          'diffTable.columns.status' => 'Status',
          'diffTable.columns.key' => 'Key',
          'diffTable.columns.source' => 'Source',
          'diffTable.columns.target' => 'Target',
          'diffTable.empty' => 'No entries to display',
          'diffTable.pagination.show' => 'Show',
          'diffTable.messages.addedToTM' => 'Added to Translation Memory',
          'diffTable.messages.reverted' => 'Entry reverted',
          'diffTable.messages.deleted' => 'Entry deleted',
          'diffTable.messages.appliedAndAdded' =>
            'Applied and added to Translation Memory',
          'diffTable.editDialog.title' => ({required Object key}) =>
              'Edit: ${key}',
          'diffTable.editDialog.sourceLabel' => 'Source',
          'diffTable.editDialog.targetLabel' => 'Target',
          'diffTable.editDialog.hint' => 'Enter translation...',
          'diffTable.editDialog.cancel' => 'Cancel',
          'diffTable.editDialog.applyAndAdd' => 'Apply & Add to TM',
          'diffTable.editDialog.apply' => 'Apply',
          'onboarding.gettingStarted' => 'Getting Started',
          'onboarding.stepProgress' => (
                  {required Object current, required Object total}) =>
              'Step ${current} of ${total}',
          'onboarding.skipTutorial' => 'Skip Tutorial',
          'onboarding.loadSampleData' => 'Load Sample Data',
          'onboarding.steps.importFiles.title' => 'Import Files',
          'onboarding.steps.importFiles.description' =>
            'Load your source and target localization files to compare',
          'onboarding.steps.runComparison.title' => 'Run Comparison',
          'onboarding.steps.runComparison.description' =>
            'Start comparing files to find differences and missing keys',
          'onboarding.steps.reviewMissing.title' => 'Review Missing',
          'onboarding.steps.reviewMissing.description' =>
            'Check entries that are missing in the target file',
          'onboarding.steps.useFilters.title' => 'Use Filters',
          'onboarding.steps.useFilters.description' =>
            'Filter results by status, category, or search term',
          'onboarding.steps.searchResults.title' => 'Search Results',
          'onboarding.steps.searchResults.description' =>
            'Use the search bar to find specific keys or translations',
          'onboarding.steps.advancedView.title' => 'Advanced View',
          'onboarding.steps.advancedView.description' =>
            'Switch to advanced view for detailed side-by-side comparison',
          'onboarding.steps.editCell.title' => 'Edit Entries',
          'onboarding.steps.editCell.description' =>
            'Click on a cell to edit translations directly',
          'onboarding.steps.exportResults.title' => 'Export Results',
          'onboarding.steps.exportResults.description' =>
            'Save your changes or export comparison results',
          _ => null,
        };
  }
}
