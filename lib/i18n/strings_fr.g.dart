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
class TranslationsFr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAppFr app = _TranslationsAppFr._(_root);
	@override late final _TranslationsCommonFr common = _TranslationsCommonFr._(_root);
	@override late final _TranslationsMenuFr menu = _TranslationsMenuFr._(_root);
	@override late final _TranslationsNavFr nav = _TranslationsNavFr._(_root);
	@override late final _TranslationsSettingsFr settings = _TranslationsSettingsFr._(_root);
	@override late final _TranslationsFileComparisonFr fileComparison = _TranslationsFileComparisonFr._(_root);
	@override late final _TranslationsDirectoryComparisonFr directoryComparison = _TranslationsDirectoryComparisonFr._(_root);
	@override late final _TranslationsGitComparisonFr gitComparison = _TranslationsGitComparisonFr._(_root);
	@override late final _TranslationsAdvancedComparisonFr advancedComparison = _TranslationsAdvancedComparisonFr._(_root);
	@override late final _TranslationsAdvancedDiffFr advancedDiff = _TranslationsAdvancedDiffFr._(_root);
	@override late final _TranslationsIssueDetailsFr issueDetails = _TranslationsIssueDetailsFr._(_root);
	@override late final _TranslationsImportReviewFr importReview = _TranslationsImportReviewFr._(_root);
	@override late final _TranslationsHistoryViewFr historyView = _TranslationsHistoryViewFr._(_root);
	@override late final _TranslationsCompareFr compare = _TranslationsCompareFr._(_root);
	@override late final _TranslationsHistoryFr history = _TranslationsHistoryFr._(_root);
	@override late final _TranslationsProjectsFr projects = _TranslationsProjectsFr._(_root);
	@override late final _TranslationsDiffFr diff = _TranslationsDiffFr._(_root);
	@override late final _TranslationsGitFr git = _TranslationsGitFr._(_root);
	@override late final _TranslationsQualityFr quality = _TranslationsQualityFr._(_root);
	@override late final _TranslationsErrorsFr errors = _TranslationsErrorsFr._(_root);
	@override late final _TranslationsWizardsFr wizards = _TranslationsWizardsFr._(_root);
	@override late final _TranslationsDialogsFr dialogs = _TranslationsDialogsFr._(_root);
	@override late final _TranslationsGridFr grid = _TranslationsGridFr._(_root);
	@override late final _TranslationsTutorialFr tutorial = _TranslationsTutorialFr._(_root);
	@override late final _TranslationsFriendlyErrorsFr friendlyErrors = _TranslationsFriendlyErrorsFr._(_root);
	@override late final _TranslationsSystemTrayFr systemTray = _TranslationsSystemTrayFr._(_root);
	@override late final _TranslationsValidationFr validation = _TranslationsValidationFr._(_root);
	@override late final _TranslationsStatusFr status = _TranslationsStatusFr._(_root);
	@override late final _TranslationsAiServicesFr aiServices = _TranslationsAiServicesFr._(_root);
}

// Path: app
class _TranslationsAppFr implements TranslationsAppEn {
	_TranslationsAppFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Outil de Comparaison de Localisation';
	@override String get name => 'Localizer';
}

// Path: common
class _TranslationsCommonFr implements TranslationsCommonEn {
	_TranslationsCommonFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get save => 'Sauvegarder';
	@override String get cancel => 'Annuler';
	@override String get close => 'Fermer';
	@override String get delete => 'Supprimer';
	@override String get edit => 'Modifier';
	@override String get add => 'Ajouter';
	@override String get search => 'Chercher';
	@override String get undo => 'Annuler';
	@override String get loading => 'Chargement...';
	@override String get error => 'Erreur';
	@override String get success => 'Succès';
	@override String get warning => 'Avertissement';
	@override String get info => 'Info';
	@override String get confirm => 'Confirmer';
	@override String get yes => 'Oui';
	@override String get no => 'Non';
	@override String get ok => 'OK';
	@override String get retry => 'Réessayer';
	@override String get copyText => 'Copier';
	@override String get appName => 'Localizer';
	@override String get copied => 'Copié !';
	@override String get enabled => 'Activé';
	@override String get disabled => 'Désactivé';
	@override String get browse => 'Parcourir';
	@override String get clear => 'Effacer';
	@override String get apply => 'Appliquer';
	@override String get reset => 'Réinitialiser';
	@override String get refresh => 'Actualiser';
	@override String get export => 'Exporter';
	@override String get import => 'Importer';
	@override String get select => 'Sélectionner';
	@override String get selectAll => 'Tout sélectionner';
	@override String get deselectAll => 'Tout désélectionner';
	@override String get noResults => 'Aucun résultat trouvé';
	@override String get emptyState => 'Rien ici pour le moment';
	@override String get open => 'Ouvrir';
	@override String get change => 'Changer';
	@override String get original => 'Original';
	@override String get kNew => 'Nouveau';
	@override String get remove => 'Supprimer';
	@override String get auto => 'Auto';
	@override String get execute => 'Exécuter';
	@override String get run => 'Exécuter';
	@override String get unknown => 'Inconnu';
	@override String get download => 'Télécharger';
	@override String get dropdownArrow => 'Flèche de liste déroulante';
	@override String get openInNewWindow => 'S\'ouvre dans une nouvelle fenêtre';
	@override String get resetToDefaults => 'Réinitialiser les paramètres par défaut';
}

// Path: menu
class _TranslationsMenuFr implements TranslationsMenuEn {
	_TranslationsMenuFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get file => 'Fichier';
	@override String get edit => 'Édition';
	@override String get view => 'Affichage';
	@override String get help => 'Aide';
	@override String get openFiles => 'Ouvrir les fichiers...';
	@override String get openFolder => 'Ouvrir le dossier...';
	@override String get exportResults => 'Exporter les résultats...';
	@override String get undo => 'Annuler';
	@override String get redo => 'Rétablir';
	@override String get cut => 'Couper';
	@override String get paste => 'Coller';
	@override String get selectAll => 'Tout sélectionner';
	@override String get zoomIn => 'Zoom avant';
	@override String get zoomOut => 'Zoom arrière';
	@override String get resetZoom => 'Réinitialiser le zoom';
	@override String get documentation => 'Documentation';
	@override String get reportIssue => 'Signaler un problème';
	@override String about({required Object appName}) => 'À propos de ${appName}';
}

// Path: nav
class _TranslationsNavFr implements TranslationsNavEn {
	_TranslationsNavFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get compare => 'Comparer';
	@override String get history => 'Historique';
	@override String get settings => 'Paramètres';
	@override String get projects => 'Projets';
	@override String get dashboard => 'Tableau de bord';
	@override String get directory => 'Dossier';
	@override String get repository => 'Dépôt';
	@override String get tooltipCompare => 'Comparer les fichiers de localisation';
	@override String get tooltipHistory => 'Voir l\'historique des comparaisons';
	@override String get tooltipSettings => 'Paramètres de l\'application';
	@override String get tooltipProjects => 'Gérer les projets';
	@override String get tooltipThemeToggle => 'Changer de thème';
	@override String get tooltipDebugConsole => 'Console de débogage';
}

// Path: settings
class _TranslationsSettingsFr implements TranslationsSettingsEn {
	_TranslationsSettingsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paramètres';
	@override String get appSettings => 'Paramètres de l\'application';
	@override String get projectSettings => 'Paramètres du projet';
	@override late final _TranslationsSettingsAppearanceFr appearance = _TranslationsSettingsAppearanceFr._(_root);
	@override late final _TranslationsSettingsGeneralFr general = _TranslationsSettingsGeneralFr._(_root);
	@override late final _TranslationsSettingsScopeFr scope = _TranslationsSettingsScopeFr._(_root);
	@override late final _TranslationsSettingsSearchKeywordsFr searchKeywords = _TranslationsSettingsSearchKeywordsFr._(_root);
	@override late final _TranslationsSettingsComparisonFr comparison = _TranslationsSettingsComparisonFr._(_root);
	@override late final _TranslationsSettingsFileHandlingFr fileHandling = _TranslationsSettingsFileHandlingFr._(_root);
	@override late final _TranslationsSettingsTranslationMemoryFr translationMemory = _TranslationsSettingsTranslationMemoryFr._(_root);
	@override late final _TranslationsSettingsBackupFr backup = _TranslationsSettingsBackupFr._(_root);
	@override late final _TranslationsSettingsAiFr ai = _TranslationsSettingsAiFr._(_root);
	@override late final _TranslationsSettingsIntegrationsFr integrations = _TranslationsSettingsIntegrationsFr._(_root);
	@override late final _TranslationsSettingsDeveloperFr developer = _TranslationsSettingsDeveloperFr._(_root);
	@override late final _TranslationsSettingsAboutFr about = _TranslationsSettingsAboutFr._(_root);
	@override late final _TranslationsSettingsOnboardingFr onboarding = _TranslationsSettingsOnboardingFr._(_root);
	@override late final _TranslationsSettingsSettingsViewFr settingsView = _TranslationsSettingsSettingsViewFr._(_root);
}

// Path: fileComparison
class _TranslationsFileComparisonFr implements TranslationsFileComparisonEn {
	_TranslationsFileComparisonFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Comparaison de fichiers';
	@override String get openFiles => 'Ouvrir les fichiers';
	@override String get exportResults => 'Exporter les résultats';
	@override String get restartTutorial => 'Redémarrer le tutoriel';
	@override String get restartTutorialDevOnly => 'Le redémarrage du tutoriel est disponible uniquement en mode développeur.';
	@override String get unsupportedFileType => 'Type de fichier non pris en charge.';
	@override String get unsupportedFileTypeSuggestion => 'Veuillez sélectionner un fichier de localisation pris en charge.';
	@override String get someFilesUnsupported => 'Certains fichiers ne sont pas pris en charge.';
	@override String get pickSupportedFiles => 'Choisissez uniquement des fichiers de localisation pris en charge.';
	@override String get pickTwoFiles => 'Choisissez deux fichiers à comparer.';
	@override String get pickBilingualFile => 'Veuillez sélectionner un fichier bilingue à comparer.';
	@override String get noResultsToExport => 'Aucun résultat à exporter pour le moment.';
	@override String get performComparisonFirst => 'Effectuez d\'abord une comparaison pour exporter les résultats.';
	@override String get performComparisonFirstEditor => 'Veuillez d\'abord effectuer une comparaison pour voir les détails avancés.';
	@override String get sampleDataLoaded => 'Données d\'exemple chargées avec succès';
	@override String loadSampleDataError({required Object error}) => 'Échec du chargement des données d\'exemple : ${error}';
	@override String get invalidFileType => 'Type de fichier invalide.';
	@override String fileSelected({required Object label, required Object fileName}) => '${label} sélectionné : ${fileName}';
	@override String get sourceFile => 'Fichier source';
	@override String get targetFile => 'Fichier cible';
	@override String get bilingualFile => 'Fichier bilingue';
	@override String get compareFiles => 'Comparer les fichiers';
	@override String get compareFile => 'Comparer le fichier';
	@override String get bilingualMode => 'Mode bilingue';
	@override String get twoFilesMode => 'Deux fichiers';
	@override String get processing => 'Traitement...';
	@override String remaining({required Object time}) => '${time} restant';
	@override String get comparisonInProgress => 'Comparaison en cours...';
	@override String comparisonFailed({required Object error}) => 'Échec de la comparaison : ${error}';
	@override String fileChanged({required Object fileName}) => 'Fichier modifié : ${fileName}. Re-comparaison...';
	@override String get dropFileHere => 'Déposez le fichier ici';
	@override String get dropFileOrBrowse => 'Déposez le fichier ou cliquez pour parcourir';
	@override String get fileUpload => 'Télécharger le fichier';
	@override String get changeFile => 'Changer de fichier';
	@override String get total => 'Total';
	@override String get show => 'Afficher';
	@override String get showAll => 'Tout afficher';
	@override String noMatches({required Object query}) => 'Aucune correspondance trouvée pour "${query}"';
	@override String showingEntries({required Object count, required Object total}) => 'Affichage de ${count} sur ${total} entrées';
	@override String get filesIdentical => 'Files are identical.';
	@override String hiddenIdentical({required Object count}) => '${count} identical entries hidden';
	@override String get showIdentical => 'Show Identical Entries';
	@override String get hideIdentical => 'Hide identical entries';
	@override String get noDiff => 'No differences found based on keys.';
	@override String get source => 'Source';
	@override String get target => 'Target';
	@override String get value => 'Value';
	@override String get readyToCompare => 'Ready to Compare Files';
	@override String get readyToCompareDesc => 'Drop localization files above or use the browse buttons\nto select files for comparison.';
	@override String get recentComparisons => 'Recent Comparisons';
	@override String bilingualFileLabel({required Object name}) => 'Bilingual file: ${name}';
	@override String comparisonLabel({required Object source, required Object target}) => '${source} ↔ ${target}';
	@override String get fileNotExist => 'One or both files from this session no longer exist.';
	@override String get largeFileTitle => 'Large File Detected';
	@override String largeFileContent({required Object count}) => 'The comparison result contains ${count} entries.\nDisplaying all of them might cause performance issues.\n\nDo you want to proceed?';
	@override String get dontShowAgain => 'Don\'t show again for this file';
	@override String get proceed => 'Proceed';
	@override String exportReport({required Object format}) => 'Save ${format} Report';
	@override String saved({required Object format}) => '${format} saved';
	@override String saveError({required Object format}) => 'Failed to save ${format} file.';
	@override String saveErrorDetailed({required Object format, required Object error}) => 'Failed to save ${format}: ${error}';
	@override String get watching => 'Watching';
	@override String get watchOff => 'Watch Off';
	@override String watchingTooltip({required Object status}) => 'File Watching: ${status}\nAutomatically recompare when files change on disk';
	@override String get aiSettingsNotAvailable => 'Navigation to AI Settings not available';
}

// Path: directoryComparison
class _TranslationsDirectoryComparisonFr implements TranslationsDirectoryComparisonEn {
	_TranslationsDirectoryComparisonFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Directory Comparison';
	@override String get sourceDirectory => 'Source Directory';
	@override String get targetDirectory => 'Target Directory';
	@override String get sourceSubtitle => 'Original/Reference files';
	@override String get targetSubtitle => 'Translation/Comparison files';
	@override String get selectBothDirectories => 'Please select both a source and target directory.';
	@override String get selectSourceFolder => 'Select Source Folder';
	@override String get selectTargetFolder => 'Select Target Folder';
	@override String get dropFolderHere => 'Drop folder here or browse...';
	@override String get folderPath => 'Folder Path';
	@override String get readyToCompare => 'Ready to Compare Directories';
	@override String get readyToCompareDesc => 'Déposez des dossiers ci-dessus ou utilisez les boutons de navigation\npour sélectionner des répertoires à comparer.';
	@override String get nestedFolders => 'Dossiers imbriqués';
	@override String get nestedFoldersTooltip => 'Compare récursivement tous les répertoires imbriqués';
	@override String get fileMatching => 'Correspondance de fichiers';
	@override String get fileMatchingTooltip => 'Associe automatiquement les fichiers par nom';
	@override String get bulkExport => 'Exportation en masse';
	@override String get bulkExportTooltip => 'Exporter tous les résultats de comparaison en une fois';
	@override String get notDirectoryComparison => 'Ceci n\'est pas une comparaison de dossiers.';
	@override String get directoriesNotExist => 'L\'un des dossiers ou les deux n\'existent plus.';
	@override String get errorOccurred => 'Une erreur s\'est produite';
	@override String get noFilesFound => 'Aucun fichier trouvé dans les dossiers sélectionnés.';
	@override String get unmatchedSourceFiles => 'Fichiers source non appariés';
	@override String get unmatchedTargetFiles => 'Fichiers cible non appariés';
	@override String filePairs({required Object count}) => '${count} paires de fichiers';
	@override String pairedFiles({required Object count}) => 'Fichiers appariés (${count})';
	@override String get view => 'Voir';
	@override String get failed => 'Échoué';
	@override String get pair => 'Apparier...';
	@override String pairDialogTitle({required Object name}) => 'Apparier "${name}" avec :';
	@override String get discoverFiles => 'Découvrir les fichiers';
	@override String get compareAll => 'Tout comparer';
	@override String get exportAll => 'Tout exporter';
	@override String get comparisonStarted => 'Comparaison démarrée...';
	@override String get discoveringFiles => 'Découverte des fichiers...';
	@override String get noResultsToExport => 'Aucun résultat de comparaison à exporter. Lancez d\'abord "Tout comparer".';
	@override String get selectExportFolder => 'Sélectionner le dossier d\'exportation';
	@override String createExportFolderError({required Object error}) => 'Échec de la création du dossier d\'exportation : ${error}';
	@override String get exportingResults => 'Exportation des résultats';
	@override String processingFile({required Object file}) => 'Traitement : ${file}';
	@override String exportProgress({required Object current, required Object total}) => '${current} sur ${total} fichiers exportés';
	@override String get exportComplete => 'Exportation terminée';
	@override String exportSuccessMessage({required Object count}) => '${count} fichiers de comparaison plus le résumé ont été exportés avec succès.';
	@override String exportFailed({required Object error}) => 'L\'exportation a échoué : ${error}';
	@override String get close => 'Fermer';
}

// Path: gitComparison
class _TranslationsGitComparisonFr implements TranslationsGitComparisonEn {
	_TranslationsGitComparisonFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get _translatorNote => 'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.';
	@override String get title => 'Comparaison de dépôt';
	@override String get repoSelector => 'Créer / Ouvrir un dépôt';
	@override String get noRepoSelected => 'Aucun dépôt sélectionné';
	@override String get open => 'Ouvrir';
	@override String get refreshCommits => 'Actualiser les commits';
	@override String get noCommits => 'Aucun commit trouvé ou chargé. Sélectionnez une branche pour charger les commits.';
	@override String get baseCommit => 'Commit de base (Plus ancien)';
	@override String get targetCommit => 'Commit cible (Plus récent)';
	@override String get filterCommitsByBranch => 'Filtrer les commits par branche';
	@override String get conflictDetection => 'Détection de conflits';
	@override String get conflictDetectionTooltip => 'Détecter et résoudre les conflits de fusion';
	@override String get actions => 'Actions :';
	@override String get checkout => 'Checkout';
	@override String get merge => 'Merge';
	@override String get pull => 'Pull';
	@override String get checkoutBranch => 'Checkout Branch';
	@override String get mergeBranch => 'Merge Branch into Current';
	@override String mergeConfirmation({required Object branch}) => 'Merge ${branch} ?';
	@override String get mergeWarning => 'Cela fusionnera les modifications dans votre branche de travail actuelle. Des conflits peuvent survenir.';
	@override String get selectExportFolder => 'Sélectionner le dossier d\'exportation';
	@override String createExportFolderError({required Object error}) => 'Échec de la création du dossier d\'exportation : ${error}';
	@override String get exportingFiles => 'Exportation des fichiers';
	@override String processingFile({required Object file}) => 'Traitement : ${file}';
	@override String exportProgress({required Object current, required Object total}) => '${current} sur ${total} fichiers exportés';
	@override String get exportComplete => 'Exportation terminée';
	@override String exportSuccessMessage({required Object count}) => '${count} fichiers avec le contenu complet ont été exportés avec succès.';
	@override String get exportDetail => 'Le diff de chaque fichier est enregistré dans le sous-dossier "files".';
	@override String get diffViewer => 'Visionneuse de diff';
	@override String get base => 'BASE';
	@override String get target => 'CIBLE';
	@override String get noLines => 'Aucune ligne à afficher';
	@override String get searchFiles => 'Rechercher des fichiers...';
	@override String noFilesMatch({required Object query}) => 'Aucun fichier ne correspond à "${query}"';
	@override String filesCount({required Object count}) => '${count} fichiers';
	@override String get selectBaseFile => 'Sélectionner le fichier de base';
	@override String get selectTargetFile => 'Sélectionner le fichier cible';
	@override String get comparisonResults => 'Résultats de la comparaison';
	@override String get noChanges => 'Aucune modification trouvée entre les références sélectionnées.';
	@override String get linesAdded => 'Lignes ajoutées';
	@override String get linesRemoved => 'Lignes supprimées';
	@override String get commit => 'Commit';
	@override String get branch => 'Branch';
	@override String get noRepositorySelected => 'Aucun dépôt sélectionné';
	@override String get notGitComparison => 'Ceci n\'est pas une comparaison Git';
	@override String get repositoryNotExist => 'Le dépôt n\'existe pas';
	@override String get mainBranch => 'main';
	@override String get masterBranch => 'master';
	@override String get backToControls => 'Retour aux contrôles de comparaison';
}

// Path: advancedComparison
class _TranslationsAdvancedComparisonFr implements TranslationsAdvancedComparisonEn {
	_TranslationsAdvancedComparisonFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get placeholder => 'Vue de comparaison avancée - Espace réservé';
}

// Path: advancedDiff
class _TranslationsAdvancedDiffFr implements TranslationsAdvancedDiffEn {
	_TranslationsAdvancedDiffFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get saveAllChanges => 'Sauvegarder toutes les modifications ?';
	@override String saveConfirmation({required Object count}) => 'Cela enregistrera toutes les ${count} entrées modifiées dans le fichier cible. Cette action est irréversible.';
	@override String get changesSaved => 'Modifications enregistrées avec succès.';
	@override String get csvExported => 'CSV exporté';
	@override String get unsavedChanges => 'Modifications non enregistrées';
	@override String get unsavedChangesWarning => 'Vous avez des modifications non enregistrées. Êtes-vous sûr de vouloir les abandonner ?';
	@override String get discardChanges => 'Abandonner les modifications';
	@override String get goBack => 'Retour';
	@override String get breadcrumbs => 'Accueil  >  Éditeur';
	@override String unsaved({required Object count}) => '${count} non enregistrés';
	@override String reviewed({required Object count}) => '${count} révisés';
	@override String saveAll({required Object count}) => 'Tout sauvegarder (${count})';
	@override String get allSaved => 'Tout est sauvegardé';
	@override String get saveAllTooltip => 'Sauvegarder toutes les modifications (Ctrl+S)';
	@override String get exportTooltip => 'Exporter les données (Ctrl+E)';
	@override late final _TranslationsAdvancedDiffAiSuggestionFr aiSuggestion = _TranslationsAdvancedDiffAiSuggestionFr._(_root);
	@override late final _TranslationsAdvancedDiffDetailEditFr detailEdit = _TranslationsAdvancedDiffDetailEditFr._(_root);
	@override late final _TranslationsAdvancedDiffTableFr table = _TranslationsAdvancedDiffTableFr._(_root);
	@override late final _TranslationsAdvancedDiffDiffRowFr diffRow = _TranslationsAdvancedDiffDiffRowFr._(_root);
	@override late final _TranslationsAdvancedDiffStatusFr status = _TranslationsAdvancedDiffStatusFr._(_root);
	@override late final _TranslationsAdvancedDiffSidebarFr sidebar = _TranslationsAdvancedDiffSidebarFr._(_root);
}

// Path: issueDetails
class _TranslationsIssueDetailsFr implements TranslationsIssueDetailsEn {
	_TranslationsIssueDetailsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Détails du problème';
	@override String showingIssues({required Object count, required Object total}) => 'Affichage de ${count} sur ${total} problèmes';
	@override String get searchPlaceholder => 'Rechercher par clé, texte ou erreur...';
	@override String get noDetails => 'Aucun détail disponible.';
	@override String get noMatches => 'Aucune correspondance trouvée.';
	@override String get showMore => 'Afficher plus';
	@override String copyItems({required Object count}) => 'Copier ${count} éléments';
	@override String get close => 'Fermer';
	@override String get copied => 'Copié dans le presse-papiers';
	@override String copiedCount({required Object count}) => '${count} éléments copiés';
	@override late final _TranslationsIssueDetailsDuplicateValueFr duplicateValue = _TranslationsIssueDetailsDuplicateValueFr._(_root);
	@override late final _TranslationsIssueDetailsLengthOutlierFr lengthOutlier = _TranslationsIssueDetailsLengthOutlierFr._(_root);
	@override late final _TranslationsIssueDetailsStandardFr standard = _TranslationsIssueDetailsStandardFr._(_root);
	@override String get review => 'Réviser';
	@override late final _TranslationsIssueDetailsTypesFr types = _TranslationsIssueDetailsTypesFr._(_root);
	@override late final _TranslationsIssueDetailsNotesFr notes = _TranslationsIssueDetailsNotesFr._(_root);
	@override late final _TranslationsIssueDetailsFallbacksFr fallbacks = _TranslationsIssueDetailsFallbacksFr._(_root);
}

// Path: importReview
class _TranslationsImportReviewFr implements TranslationsImportReviewEn {
	_TranslationsImportReviewFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Réviser l\'importation du projet';
	@override String get projectName => 'Nom du projet';
	@override String get created => 'Créé';
	@override String get historyItems => 'Historique';
	@override String get customSettingsTitle => 'Paramètres personnalisés détectés';
	@override String get customSettingsWarning => 'Ce projet contient des paramètres personnalisés qui remplaceront vos réglages par défaut tant qu\'il sera ouvert.';
	@override String get standardSettings => 'Ce projet utilise les paramètres globaux standards.';
	@override String get cancelImport => 'Annuler l\'importation';
	@override String get trustOpen => 'Faire confiance & Ouvrir le projet';
}

// Path: historyView
class _TranslationsHistoryViewFr implements TranslationsHistoryViewEn {
	_TranslationsHistoryViewFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Historique de comparaison';
	@override String get clearAll => 'Effacer tout l\'historique';
	@override String get searchPlaceholder => 'Rechercher par nom de fichier...';
	@override String get sortBy => 'Trier par';
	@override String get sortDate => 'Date';
	@override String get sortSource => 'Fichier source';
	@override String get sortTarget => 'Fichier cible';
	@override String get showCurrentProject => 'Affichage : Projet actuel';
	@override String get showAllHistory => 'Affichage : Tout l\'historique';
	@override String get groupByFolder => 'Grouper par dossier';
	@override String get disableGrouping => 'Désactiver le groupement par dossier';
	@override String get filterAll => 'Tout';
	@override String get filterFiles => 'Fichiers';
	@override String get filterDirectories => 'Dossiers';
	@override String get filterGit => 'Git';
	@override String get noHistory => 'Aucun historique de comparaison pour le moment';
	@override String get historyDescription => 'Vos comparaisons de fichiers apparaîtront ici';
	@override String get noResults => 'Aucun résultat trouvé';
	@override String get adjustSearch => 'Essayez d\'ajuster votre recherche';
	@override String get clearConfirmationTitle => 'Effacer tout l\'historique ?';
	@override String get clearConfirmationContent => 'Cela supprimera définitivement tout l\'historique des comparaisons. Cette action est irréversible.';
	@override String get clearAction => 'Tout effacer';
	@override String get deletedMessage => 'Élément de l\'historique supprimé';
	@override String get undo => 'Annuler';
	@override String get viewDetails => 'Voir détails';
	@override String get delete => 'Supprimer';
	@override String get openLocation => 'Ouvrir l\'emplacement du fichier';
	@override String get bilingual => 'Bilingue';
	@override String get filePair => 'Paire de fichiers';
	@override String get directory => 'Dossier';
	@override String get git => 'Git';
	@override String get repo => 'Dépôt';
	@override String get sourceDir => 'Dossier source';
	@override String get targetDir => 'Dossier cible';
	@override String get source => 'Source';
	@override String get target => 'Cible';
	@override String get noChanges => 'Aucune modification détectée';
	@override String get added => 'Ajouté';
	@override String get removed => 'Supprimé';
	@override String get modified => 'Modifié';
	@override String get same => 'Identique';
	@override String get total => 'Total';
	@override String get currentProject => 'Projet actuel';
	@override String get unassigned => 'Non assigné';
	@override String get project => 'Projet';
}

// Path: compare
class _TranslationsCompareFr implements TranslationsCompareEn {
	_TranslationsCompareFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Comparer les fichiers';
	@override String get sourceFile => 'Fichier source';
	@override String get targetFile => 'Fichier cible';
	@override String get sourceFolder => 'Dossier source';
	@override String get targetFolder => 'Dossier cible';
	@override String get dropFilesHint => 'Déposez les fichiers de localisation ici ou utilisez les boutons de navigation pour sélectionner les fichiers à comparer.';
	@override String get selectSourceFile => 'Sélectionner le fichier source';
	@override String get selectTargetFile => 'Sélectionner le fichier cible';
	@override String get startComparison => 'Démarrer la comparaison';
	@override String get comparing => 'Comparaison...';
	@override String get comparisonComplete => 'Comparaison terminée';
	@override String get noChanges => 'Aucune modification détectée';
	@override String get filesIdentical => 'Les fichiers sont identiques';
	@override String changesFound({required Object count}) => '${count} modifications trouvées';
	@override late final _TranslationsCompareTabsFr tabs = _TranslationsCompareTabsFr._(_root);
	@override late final _TranslationsCompareFileTypesFr fileTypes = _TranslationsCompareFileTypesFr._(_root);
}

// Path: history
class _TranslationsHistoryFr implements TranslationsHistoryEn {
	_TranslationsHistoryFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Historique';
	@override String get recentComparisons => 'Comparaisons récentes';
	@override String get noHistory => 'Aucun historique de comparaison pour le moment';
	@override String get noHistoryDescription => 'Votre historique de comparaison apparaîtra ici';
	@override String get clearHistory => 'Effacer l\'historique';
	@override String get clearHistoryConfirm => 'Êtes-vous sûr de vouloir effacer tout l\'historique ?';
	@override String get deleteEntry => 'Supprimer l\'entrée';
	@override String get openComparison => 'Ouvrir la comparaison';
	@override late final _TranslationsHistoryTimeAgoFr timeAgo = _TranslationsHistoryTimeAgoFr._(_root);
}

// Path: projects
class _TranslationsProjectsFr implements TranslationsProjectsEn {
	_TranslationsProjectsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Projets';
	@override String get createProject => 'Créer un projet';
	@override String get importProject => 'Importer un projet';
	@override String get noProjects => 'Aucun projet pour le moment';
	@override String get noProjectsDescription => 'Créez un projet pour organiser vos fichiers de localisation';
	@override String get projectName => 'Nom du projet';
	@override String get projectPath => 'Chemin du projet';
	@override String get lastOpened => 'Dernière ouverture';
	@override String get openProject => 'Ouvrir le projet';
	@override String get closeProject => 'Fermer le projet';
	@override String get deleteProject => 'Supprimer le projet';
	@override String get deleteProjectConfirm => 'Êtes-vous sûr de vouloir supprimer ce projet ?';
	@override String get exportProject => 'Exporter le projet';
	@override String get exportDescription => 'Créez un fichier zip portable contenant les fichiers sources, la configuration et l\'historique.';
	@override String get exporting => 'Exportation du projet...';
	@override String get exportSuccess => 'Projet exporté';
	@override String exportError({required Object error}) => 'L\'exportation a échoué : ${error}';
	@override String get createNewProject => 'Créer un nouveau projet';
	@override String get openExistingProject => 'Ouvrir un projet existant';
	@override String get importProjectZip => 'Importer le Zip du projet';
	@override String get projectResources => 'Ressources du projet';
	@override String get recentProjects => 'Projets récents';
	@override String get noRecentProjects => 'Aucun projet récent';
	@override String get selectProjectZip => 'Sélectionner le Zip du projet';
	@override String get selectDestination => 'Sélectionner le dossier de destination pour l\'importation';
	@override String get importing => 'Importation du projet...';
	@override String get importSuccess => 'Projet importé avec succès';
	@override String importFailed({required Object error}) => 'L\'importation a échoué : ${error}';
	@override String get importingFiles => 'Importation des fichiers...';
	@override String get noSupportedFiles => 'Aucun fichier pris en charge n\'a été déposé.';
	@override late final _TranslationsProjectsStatsFr stats = _TranslationsProjectsStatsFr._(_root);
	@override String get openProjectFirst => 'Ouvrez d\'abord un projet pour gérer ses ressources.';
	@override String get removeFromRecent => 'Retirer des récents';
	@override late final _TranslationsProjectsSelectionFr selection = _TranslationsProjectsSelectionFr._(_root);
	@override late final _TranslationsProjectsCreateDialogFr createDialog = _TranslationsProjectsCreateDialogFr._(_root);
	@override late final _TranslationsProjectsIndicatorFr indicator = _TranslationsProjectsIndicatorFr._(_root);
	@override late final _TranslationsProjectsGlossaryFr glossary = _TranslationsProjectsGlossaryFr._(_root);
	@override late final _TranslationsProjectsConflictsFr conflicts = _TranslationsProjectsConflictsFr._(_root);
	@override late final _TranslationsProjectsTmFr tm = _TranslationsProjectsTmFr._(_root);
}

// Path: diff
class _TranslationsDiffFr implements TranslationsDiffEn {
	_TranslationsDiffFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get added => 'Ajouté';
	@override String get removed => 'Supprimé';
	@override String get modified => 'Modifié';
	@override String get unchanged => 'Inchangé';
	@override String get missing => 'Manquant';
	@override String get extra => 'En surplus';
	@override String get sourceValue => 'Valeur source';
	@override String get targetValue => 'Valeur cible';
	@override String get key => 'Clé';
	@override String get status => 'Statut';
	@override String get actions => 'Actions';
	@override String get copyToTarget => 'Copier vers la cible';
	@override String get acceptChange => 'Accepter la modification';
	@override String get rejectChange => 'Rejeter la modification';
	@override String get viewDetails => 'Voir détails';
}

// Path: git
class _TranslationsGitFr implements TranslationsGitEn {
	_TranslationsGitFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Comparaison Git';
	@override String get selectRepository => 'Sélectionner le dépôt';
	@override String get selectBranch => 'Sélectionner la branche';
	@override String get selectCommit => 'Sélectionner le commit';
	@override String get compareBranches => 'Comparer les branches';
	@override String get compareCommits => 'Comparer les commits';
	@override String get baseBranch => 'Branche de base';
	@override String get compareBranch => 'Comparer la branche';
	@override String get noRepositories => 'Aucun dépôt Git trouvé';
	@override String get noRepositoriesDescription => 'Open a folder containing a Git repository';
	@override String filesChanged({required Object count}) => '${count} files changed';
	@override String additions({required Object count}) => '${count} additions';
	@override String deletions({required Object count}) => '${count} deletions';
	@override late final _TranslationsGitConflictsFr conflicts = _TranslationsGitConflictsFr._(_root);
}

// Path: quality
class _TranslationsQualityFr implements TranslationsQualityEn {
	_TranslationsQualityFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get _translatorNote => 'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.';
	@override String get title => 'Tableau de bord qualité';
	@override String get overallScore => 'Score global';
	@override String get issues => 'Problèmes';
	@override String get warnings => 'Avertissements';
	@override String get suggestions => 'Suggestions';
	@override String get placeholderMismatch => 'Écart d\'espace réservé';
	@override String get placeholderMismatchDescription => 'Les espaces réservés comme {name} ne correspondent pas entre la source et la cible';
	@override String get lengthOutlier => 'Écart de longueur';
	@override String get lengthOutlierDescription => 'La longueur de la traduction diffère considérablement de la source';
	@override String get duplicateValue => 'Valeur en double';
	@override String get duplicateValueDescription => 'La même traduction est utilisée pour plusieurs clés';
	@override String get missingTranslation => 'Traduction manquante';
	@override String get missingTranslationDescription => 'La traduction manque pour cette clé';
	@override String get loading => 'Chargement du tableau de bord...';
	@override String get errorLoading => 'Nous n\'avons pas pu charger votre historique. Réessayez.';
	@override String get emptyState => 'Lancez une comparaison pour voir votre tableau de bord.';
	@override String get refresh => 'Actualiser';
	@override String get buildingInsights => 'Analyse en cours...';
	@override String get crunchingNumbers => 'Calculs en cours...';
	@override String get errorBuilding => 'Nous n\'avons pas pu construire le tableau de bord. Réessayez.';
	@override String get noUsableData => 'Aucune donnée utilisable trouvée pour le moment.';
	@override String get languages => 'Langues';
	@override String get averageCoverage => 'Couverture moyenne';
	@override String get potentialIssues => 'Problèmes potentiels';
	@override String get translationCoverage => 'Couverture de traduction';
	@override String entriesTranslated({required Object translated, required Object total}) => '${translated} sur ${total} entrées traduites';
	@override String get wordsAddedOverTime => 'Mots ajoutés au fil du temps';
	@override String get completionVsScope => 'Achèvement vs Portée';
	@override String get scopeVsProgress => 'Portée vs Progrès';
	@override String get coveragePercent => 'Couverture %';
	@override String get wordsAdded => 'Mots ajoutés';
	@override String get words => 'Mots';
	@override String get coverage => 'Couverture';
	@override String get scope => 'Portée';
	@override String get latest => 'Dernier';
	@override String get added => 'Ajouté';
	@override String get change => 'Changement';
	@override String get totalScope => 'Portée totale';
	@override String get scopeGrowth => 'Croissance de la portée';
	@override String get range => 'Plage';
	@override String get aiUsage => 'Utilisation de l\'IA & Traduction';
	@override String lastUsed({required Object date}) => 'Dernière utilisation ${date}';
	@override String get noIssuesFound => 'Aucun problème trouvé dans les dernières comparaisons.';
	@override String get placeholderMismatches => 'Écarts d\'espaces réservés';
	@override String get placeholderMismatchesDesc => 'Les marqueurs comme {name} ne correspondent pas.';
	@override String get lengthOutliers => 'Traductions très courtes ou longues';
	@override String get lengthOutliersDesc => 'La longueur semble inhabituelle par rapport à la source.';
	@override String get duplicateValues => 'Valeurs en double';
	@override String get duplicateValuesDesc => 'La même traduction est utilisée plusieurs fois.';
	@override String get placeholderDialogTitle => 'Écarts d\'espaces réservés';
	@override String get placeholderDialogDesc => 'Ces traductions ont des espaces réservés ({name}) différents de la source.';
	@override String get lengthDialogTitle => 'Écarts de longueur';
	@override String get lengthDialogDesc => 'Ces traductions sont considérablement plus courtes ou plus longues que la source.';
	@override String get duplicateDialogTitle => 'Valeurs en double';
	@override String get duplicateDialogDesc => 'Ces traductions apparaissent plusieurs fois.';
	@override String duplicateSample({required Object value}) => 'Double : "${value}"';
	@override String get exportError => 'Impossible de construire le rapport. Veuillez réessayer.';
	@override String get noDataToExport => 'Aucune donnée à exporter';
	@override String get exportFailed => 'Échec de l\'exportation';
	@override String get exportDialogTitle => 'Exporter le rapport qualité';
	@override String get reportSaved => 'Rapport enregistré';
	@override String get export => 'Exporter';
	@override String get requests => 'Requêtes';
	@override String get tokens => 'Tokens';
	@override String get characters => 'Caractères';
	@override String get estCost => 'Coût est.';
	@override String get prompt => 'Prompt';
	@override String get completion => 'Complétion';
	@override String get showingCurrentProject => 'Affichage : Projet actuel';
	@override String get showingAllHistory => 'Affichage : Tout l\'historique';
	@override String get filesSkipped => 'Certains fichiers ont été ignorés car ils n\'ont pas été trouvés.';
}

// Path: errors
class _TranslationsErrorsFr implements TranslationsErrorsEn {
	_TranslationsErrorsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get genericError => 'Une erreur s\'est produite';
	@override String get fileNotFound => 'Fichier non trouvé';
	@override String get invalidFormat => 'Format de fichier invalide';
	@override String get parseError => 'Échec de l\'analyse du fichier';
	@override String get networkError => 'Erreur réseau. Veuillez vérifier votre connexion.';
	@override String get permissionDenied => 'Permission refusée';
	@override String get unknownError => 'Une erreur inconnue s\'est produite';
}

// Path: wizards
class _TranslationsWizardsFr implements TranslationsWizardsEn {
	_TranslationsWizardsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsWizardsFirstRunFr firstRun = _TranslationsWizardsFirstRunFr._(_root);
}

// Path: dialogs
class _TranslationsDialogsFr implements TranslationsDialogsEn {
	_TranslationsDialogsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogsAddIgnorePatternFr addIgnorePattern = _TranslationsDialogsAddIgnorePatternFr._(_root);
	@override late final _TranslationsDialogsDiffViewerFr diffViewer = _TranslationsDialogsDiffViewerFr._(_root);
}

// Path: grid
class _TranslationsGridFr implements TranslationsGridEn {
	_TranslationsGridFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsGridColumnsFr columns = _TranslationsGridColumnsFr._(_root);
}

// Path: tutorial
class _TranslationsTutorialFr implements TranslationsTutorialEn {
	_TranslationsTutorialFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get skipTutorial => 'IGNORER LE TUTORIEL';
	@override String get finishMessage => 'Vous êtes prêt ! Appuyez n\'importe où pour terminer.';
	@override String get next => 'Suivant';
	@override String get loadSampleData => 'Charger des données d\'exemple';
	@override String get browseSourceFile => 'Parcourir le fichier source';
	@override String get browseTargetFile => 'Parcourir le fichier cible';
	@override String get compareFiles => 'Comparer les fichiers';
	@override String get hintPhase2 => 'Ensuite : filtres, recherche, vue avancée et exportation.';
	@override late final _TranslationsTutorialStepsFr steps = _TranslationsTutorialStepsFr._(_root);
}

// Path: friendlyErrors
class _TranslationsFriendlyErrorsFr implements TranslationsFriendlyErrorsEn {
	_TranslationsFriendlyErrorsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsFriendlyErrorsFileNotFoundFr fileNotFound = _TranslationsFriendlyErrorsFileNotFoundFr._(_root);
	@override late final _TranslationsFriendlyErrorsAccessDeniedFr accessDenied = _TranslationsFriendlyErrorsAccessDeniedFr._(_root);
	@override late final _TranslationsFriendlyErrorsIsDirectoryFr isDirectory = _TranslationsFriendlyErrorsIsDirectoryFr._(_root);
	@override late final _TranslationsFriendlyErrorsFileAccessFr fileAccess = _TranslationsFriendlyErrorsFileAccessFr._(_root);
	@override late final _TranslationsFriendlyErrorsUnsupportedFormatFr unsupportedFormat = _TranslationsFriendlyErrorsUnsupportedFormatFr._(_root);
	@override late final _TranslationsFriendlyErrorsNetworkErrorFr networkError = _TranslationsFriendlyErrorsNetworkErrorFr._(_root);
	@override late final _TranslationsFriendlyErrorsNotGitRepoFr notGitRepo = _TranslationsFriendlyErrorsNotGitRepoFr._(_root);
	@override late final _TranslationsFriendlyErrorsMergeConflictFr mergeConflict = _TranslationsFriendlyErrorsMergeConflictFr._(_root);
	@override late final _TranslationsFriendlyErrorsGitAuthFailedFr gitAuthFailed = _TranslationsFriendlyErrorsGitAuthFailedFr._(_root);
	@override late final _TranslationsFriendlyErrorsGitOperationFailedFr gitOperationFailed = _TranslationsFriendlyErrorsGitOperationFailedFr._(_root);
	@override late final _TranslationsFriendlyErrorsInvalidJsonFr invalidJson = _TranslationsFriendlyErrorsInvalidJsonFr._(_root);
	@override late final _TranslationsFriendlyErrorsRateLimitReachedFr rateLimitReached = _TranslationsFriendlyErrorsRateLimitReachedFr._(_root);
	@override late final _TranslationsFriendlyErrorsInvalidApiKeyFr invalidApiKey = _TranslationsFriendlyErrorsInvalidApiKeyFr._(_root);
	@override late final _TranslationsFriendlyErrorsTranslationServiceErrorFr translationServiceError = _TranslationsFriendlyErrorsTranslationServiceErrorFr._(_root);
	@override late final _TranslationsFriendlyErrorsOutOfMemoryFr outOfMemory = _TranslationsFriendlyErrorsOutOfMemoryFr._(_root);
	@override late final _TranslationsFriendlyErrorsGenericErrorFr genericError = _TranslationsFriendlyErrorsGenericErrorFr._(_root);
}

// Path: systemTray
class _TranslationsSystemTrayFr implements TranslationsSystemTrayEn {
	_TranslationsSystemTrayFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get showLocalizer => 'Afficher Localizer';
	@override String get exit => 'Quitter';
}

// Path: validation
class _TranslationsValidationFr implements TranslationsValidationEn {
	_TranslationsValidationFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get connected => 'Connecté.';
	@override String get connectionTimeout => 'Délai de connexion dépassé. Veuillez réessayer.';
	@override String get couldNotConnect => 'Impossible de se connecter. Veuillez réessayer.';
	@override String get checkKeyAndTryAgain => 'Impossible de se connecter. Veuillez vérifier la clé et réessayer.';
	@override String get tryAgainLater => 'Impossible de se connecter pour le moment. Veuillez réessayer plus tard.';
	@override String get serviceUnavailable => 'Le service est indisponible pour le moment. Veuillez réessayer plus tard.';
	@override String get enterKeyFirst => 'Veuillez d\'abord entrer une clé.';
	@override String get checking => 'Vérification...';
	@override String deeplUsage({required Object used, required Object limit}) => 'Utilisation : ${used} / ${limit} caractères.';
}

// Path: status
class _TranslationsStatusFr implements TranslationsStatusEn {
	_TranslationsStatusFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get startingComparison => 'Démarrage de la comparaison...';
	@override String get loadingFromHistory => 'Chargement des fichiers depuis l\'historique...';
	@override String get comparisonComplete => 'Comparaison terminée';
	@override String get couldNotImportFiles => 'Impossible d\'importer les fichiers. Veuillez réessayer.';
	@override String get historyFilesNotFound => 'L\'un des fichiers ou les deux de l\'historique sont introuvables aux emplacements d\'origine.';
}

// Path: aiServices
class _TranslationsAiServicesFr implements TranslationsAiServicesEn {
	_TranslationsAiServicesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get geminiEmptyResponse => 'Gemini a renvoyé une réponse vide';
	@override String get geminiStreamingEmpty => 'Le streaming Gemini a renvoyé une réponse vide';
	@override String get geminiRephraseEmpty => 'Gemini a renvoyé une réponse vide pour la reformulation';
	@override String get openaiEmptyResponse => 'OpenAI a renvoyé une réponse vide ou a échoué';
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceFr implements TranslationsSettingsAppearanceEn {
	_TranslationsSettingsAppearanceFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Apparence';
	@override String get description => 'Personnaliser l\'apparence de l\'application';
	@override String get theme => 'Mode de thème';
	@override String get themeDescription => 'Choisissez entre le thème clair, sombre ou système';
	@override String get themeSystem => 'Système';
	@override String get themeLight => 'Clair';
	@override String get themeDark => 'Sombre';
	@override String get themeAmoled => 'AMOLED';
	@override String get accentColor => 'Couleur d\'accentuation';
	@override String get accentColorDescription => 'Choisissez votre couleur d\'accentuation préférée';
	@override String get useMicaEffect => 'Utiliser l\'effet Mica';
	@override String get micaDescription => 'Activer l\'effet de transparence Mica de Windows 11 pour un look moderne';
	@override String get diffFontSize => 'Taille de police du diff';
	@override String get diffFontSizeDescription => 'Ajuster la taille de la police de la vue de comparaison';
	@override String get diffFontFamily => 'Famille de police du diff';
	@override String get diffFontFamilyDescription => 'Police pour la vue de comparaison';
	@override String get systemDefault => 'Défaut système';
	@override String get pickAccentColor => 'Choisir la couleur d\'accentuation';
	@override String get diffColors => 'Couleurs du diff';
	@override String get presetsTitle => 'Préréglages';
	@override late final _TranslationsSettingsAppearancePresetsFr presets = _TranslationsSettingsAppearancePresetsFr._(_root);
	@override String get identical => 'Identique';
	@override String pickColorFor({required Object label}) => 'Choisir la couleur pour ${label}';
	@override String get livePreview => 'Aperçu en direct';
	@override late final _TranslationsSettingsAppearancePreviewFr preview = _TranslationsSettingsAppearancePreviewFr._(_root);
}

// Path: settings.general
class _TranslationsSettingsGeneralFr implements TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Général';
	@override String get description => 'Paramètres généraux de l\'application';
	@override String get language => 'Langue';
	@override String get languageDescription => 'Choisissez votre langue préférée';
	@override String get startMinimized => 'Démarrer réduit dans la zone de notification';
	@override String get startMinimizedDescription => 'Démarrer l\'application réduite dans la barre d\'état système';
	@override String get rememberWindowPosition => 'Mémoriser la position de la fenêtre';
	@override String get rememberWindowPositionDescription => 'Restaurer la taille et la position de la fenêtre au démarrage';
	@override String get openLastProject => 'Ouvrir le dernier projet au démarrage';
	@override String get openLastProjectDescription => 'Ouvrir automatiquement le dernier projet utilisé au démarrage';
	@override String get application => 'Application';
	@override String get defaultView => 'Vue par défaut';
	@override String get defaultViewDescription => 'Vue à afficher au démarrage';
	@override String get autoCheckUpdates => 'Vérification automatique des mises à jour';
	@override String get autoCheckUpdatesDescription => 'Vérifier les mises à jour au démarrage';
	@override String get startupOptions => 'Options de démarrage';
	@override String get languageAuto => 'Détection automatique';
	@override String get viewBasic => 'Comparaison de fichiers';
	@override String get viewHistory => 'Historique';
	@override String get viewDashboard => 'Tableau de bord qualité';
	@override String get viewDirectory => 'Comparaison de dossiers';
	@override String get viewLastUsed => 'Dernière vue utilisée';
}

// Path: settings.scope
class _TranslationsSettingsScopeFr implements TranslationsSettingsScopeEn {
	_TranslationsSettingsScopeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Portée des paramètres';
	@override String get global => 'Par défaut globaux';
	@override String get project => 'Projet';
	@override String get reset => 'Réinitialiser le projet aux paramètres globaux';
	@override String get resetConfirmation => 'Cela effacera toutes les surcharges pour ce projet et reviendra aux paramètres par défaut globaux. Cette action est irréversible.';
	@override String get globalDescription => 'Les modifications s\'appliquent à tous les projets, sauf indication contraire.';
	@override String projectDescription({required Object name}) => 'Les modifications s\'appliquent uniquement à "${name}". Les autres paramètres héritent des valeurs globales par défaut.';
	@override String get createPrompt => 'Créer un projet pour personnaliser les paramètres de dossiers spécifiques';
}

// Path: settings.searchKeywords
class _TranslationsSettingsSearchKeywordsFr implements TranslationsSettingsSearchKeywordsEn {
	_TranslationsSettingsSearchKeywordsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override List<String> get general => [
		'Langue',
		'Vue par défaut',
		'Nombre de fichiers récents',
		'Ouvrir le dernier projet',
		'Confirmer avant de quitter',
		'Afficher les notifications',
	];
	@override List<String> get comparisonEngine => [
		'Mode de comparaison',
		'Seuil de similitude',
		'Sensible à la casse',
		'Ignorer les espaces',
		'Ignorer les lignes vides',
		'Ignorer les commentaires',
		'Ignorer les motifs',
	];
	@override List<String> get appearance => [
		'Thème',
		'Mode de thème',
		'Couleur d\'accentuation',
		'Taille de police du diff',
		'Famille de police du diff',
		'Couleurs du diff',
		'Couleur d\'ajout',
		'Couleur de suppression',
		'Couleur de modification',
		'Couleur identique',
		'Préréglages de couleurs',
		'Aperçu',
	];
	@override List<String> get fileHandling => [
		'Format source',
		'Format cible',
		'Encodage par défaut',
		'Nombre de projets récents',
		'Mémoire de traduction',
		'Importer la mémoire',
		'Exporter la mémoire',
		'Effacer la mémoire',
	];
	@override List<String> get aiServices => [
		'Clé API OpenAI',
		'Clé API Anthropic',
		'Clé API Google AI',
		'Modèle AI',
		'Température',
		'Invite personnalisée',
	];
	@override List<String> get systemIntegrations => [
		'Zone de notification',
		'Démarrer réduit',
		'Associations de fichiers',
		'Effet Mica',
		'Vibrance',
		'Matériau de la fenêtre',
		'Badge du dock',
		'Nombre de chaînes non traduites',
	];
	@override List<String> get projectResources => [
		'Glossaire',
		'Mémoire de traduction',
		'Terminologie',
	];
	@override List<String> get about => [
		'Version',
		'Vérifier les mises à jour',
		'Mise à jour automatique',
		'Journal des modifications',
		'Licence',
		'Politique de confidentialité',
		'Télémétrie',
		'Rapports de plantage',
	];
	@override List<String> get developer => [
		'Superposition de performance',
		'Débogueur de sémantique',
		'Grille Material',
		'Cache de rastérisation',
		'Redémarrer le tutoriel',
		'Réinitialisation d\'usine',
	];
}

// Path: settings.comparison
class _TranslationsSettingsComparisonFr implements TranslationsSettingsComparisonEn {
	_TranslationsSettingsComparisonFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Comparaison';
	@override String get description => 'Configurer le comportement de comparaison';
	@override String get caseSensitive => 'Sensible à la casse';
	@override String get caseSensitiveDescription => 'Traiter les majuscules et les minuscules comme différentes';
	@override String get ignoreWhitespace => 'Ignorer les espaces';
	@override String get ignoreWhitespaceDescription => 'Ignorer les espaces au début/à la fin lors de la comparaison';
	@override String get showLineNumbers => 'Afficher les numéros de ligne';
	@override String get showLineNumbersDescription => 'Afficher les numéros de ligne dans la vue diff';
	@override String get behavior => 'Comportement de comparaison';
	@override String get ignoreCase => 'Ignorer la casse';
	@override String get ignoreCaseDescription => 'Traiter "Clé" et "clé" comme identiques';
	@override String get similarityThreshold => 'Seuil de similitude';
	@override String get similarityThresholdDescription => 'Similitude minimale pour la détection des modifications';
	@override String get mode => 'Mode de comparaison';
	@override String get modeDescription => 'Comment faire correspondre les entrées entre les fichiers';
	@override String get modeKey => 'Basé sur les clés';
	@override String get modeKeyDescription => 'Correspondance par nom de clé (par défaut).';
	@override String get modeOrder => 'Basé sur l\'ordre';
	@override String get modeOrderDescription => 'Correspondance par position dans le fichier.';
	@override String get modeSmart => 'Correspondance intelligente';
	@override String get modeSmartDescription => 'Détecte les clés déplacées/renommées.';
	@override String get ignorePatterns => 'Motifs à ignorer';
	@override String get noIgnorePatterns => 'Aucun motif à ignorer défini.';
	@override String get addPattern => 'Ajouter un motif';
	@override String get resetToGlobal => 'Réinitialiser tous les paramètres de comparaison aux valeurs par défaut globales';
	@override late final _TranslationsSettingsComparisonPatternPresetsFr patternPresets = _TranslationsSettingsComparisonPatternPresetsFr._(_root);
	@override late final _TranslationsSettingsComparisonPreviewMatchFr previewMatch = _TranslationsSettingsComparisonPreviewMatchFr._(_root);
	@override late final _TranslationsSettingsComparisonColorPresetsFr colorPresets = _TranslationsSettingsComparisonColorPresetsFr._(_root);
}

// Path: settings.fileHandling
class _TranslationsSettingsFileHandlingFr implements TranslationsSettingsFileHandlingEn {
	_TranslationsSettingsFileHandlingFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get fileFormats => 'Formats de fichiers';
	@override String get sourceFormat => 'Format source';
	@override String get targetFormat => 'Format cible';
	@override String get encoding => 'Encodage';
	@override String get sourceEncoding => 'Encodage source';
	@override String get targetEncoding => 'Encodage cible';
	@override String get autoDetect => 'Détection automatique';
	@override String get autoDetectEncodingDescription => 'Détecter automatiquement l\'encodage du fichier';
	@override String get exportSettings => 'Paramètres d\'exportation';
	@override String get defaultExportFormat => 'Format d\'exportation par défaut';
	@override String get includeUtf8Bom => 'Inclure le BOM UTF-8';
	@override String get includeUtf8BomDescription => 'Requis pour la compatibilité avec Excel';
	@override String get openFolderAfterExport => 'Ouvrir le dossier après l\'exportation';
	@override String get fileSafety => 'Sécurité des fichiers';
	@override String get fileSafetyDescription => 'Copies locales automatiques pour la récupération après sinistre.';
	@override String get resetToGlobal => 'Réinitialiser tous les paramètres de gestion des fichiers aux valeurs par défaut globales';
}

// Path: settings.translationMemory
class _TranslationsSettingsTranslationMemoryFr implements TranslationsSettingsTranslationMemoryEn {
	_TranslationsSettingsTranslationMemoryFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mémoire de traduction globale';
	@override String get autoLearn => 'Apprentissage automatique';
	@override String get autoLearnDescription => 'Enregistrer les traductions dans la mémoire locale pour une réutilisation future';
	@override String get confidenceThreshold => 'Seuil de confiance';
	@override String confidenceThresholdDescription({required Object percent}) => 'Score minimal pour l\'application automatique (${percent}%)';
	@override String get entries => 'Entrées';
	@override String get size => 'Taille';
	@override String memorySize({required Object size}) => 'Taille de la mémoire : ${size}';
	@override String get import => 'Importer';
	@override String get exportTmx => 'Exporter en TMX';
	@override String get exportCsv => 'Exporter en CSV';
	@override String get clearMemory => 'Effacer la mémoire';
	@override String importedItems({required Object count}) => '${count} éléments importés dans la mémoire.';
	@override String get noItemsAdded => 'Aucun élément n\'a été ajouté.';
	@override String get nothingToExport => 'Rien à exporter pour le moment.';
	@override String get tmxSaved => 'TMX sauvegardé';
	@override String get csvSaved => 'CSV sauvegardé';
	@override String get clearConfirmTitle => 'Effacer la mémoire de traduction ?';
	@override String get clearConfirmContent => 'Cela supprimera toutes les paires de traduction enregistrées sur cet appareil. Cette action est irréversible.';
	@override String get cleared => 'Mémoire de traduction effacée.';
	@override String get couldNotClear => 'Impossible d\'effacer la mémoire.';
}

// Path: settings.backup
class _TranslationsSettingsBackupFr implements TranslationsSettingsBackupEn {
	_TranslationsSettingsBackupFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sauvegarde automatique';
	@override String get description => 'Paramètres de sauvegarde automatique';
	@override String get enabled => 'Activer la sauvegarde automatique';
	@override String get enabledDescription => 'Sauvegarder automatiquement les fichiers avant d\'apporter des modifications';
	@override String get maxCopies => 'Nombre maximal de copies de sauvegarde';
	@override String get maxCopiesDescription => 'Nombre de copies de sauvegarde à conserver par fichier';
	@override String activeStatus({required Object count}) => 'Actif · Conservation de ${count} copies';
	@override String get folder => 'Dossier de sauvegarde';
	@override String get folderDescription => 'Laissez vide pour utiliser le même dossier';
	@override String get useOriginalFolder => 'Utiliser le dossier d\'origine du fichier';
}

// Path: settings.ai
class _TranslationsSettingsAiFr implements TranslationsSettingsAiEn {
	_TranslationsSettingsAiFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Services d\'IA';
	@override String get description => 'Configurer la traduction et l\'assistance par IA';
	@override String get provider => 'Fournisseur d\'IA';
	@override String get providerDescription => 'Choisissez votre fournisseur de services d\'IA préféré';
	@override String get apiKey => 'Clé API';
	@override String get apiKeyDescription => 'Entrez votre clé API pour le fournisseur sélectionné';
	@override String get apiKeyPlaceholder => 'Entrez la clé API...';
	@override String get testConnection => 'Tester la connexion';
	@override String get connectionSuccess => 'Connexion réussie !';
	@override String get connectionFailed => 'Échec de la connexion. Veuillez vérifier votre clé API.';
	@override String get translationStrategy => 'Stratégie de traduction';
	@override String get strategy => 'Stratégie';
	@override String get strategyDescription => 'Sélectionnez comment vous souhaitez traduire les chaînes';
	@override String get strategyLLM => 'IA générative (LLM)';
	@override String get strategyCloud => 'Traduction Cloud';
	@override String get enableAiTranslation => 'Activer la traduction par IA';
	@override String get enableAiTranslationDescription => 'Autoriser l\'application à utiliser l\'IA pour les suggestions de traduction';
	@override String get llmProvider => 'Fournisseur de service LLM';
	@override String get service => 'Service';
	@override String get serviceDescription => 'Fournisseur pour l\'IA générative';
	@override String get providerGemini => 'Google Gemini';
	@override String get providerOpenAI => 'OpenAI';
	@override String get geminiApiKey => 'Clé API Gemini';
	@override String get openAiApiKey => 'Clé API OpenAI';
	@override String get model => 'Modèle';
	@override String get modelDescription => 'Sélectionnez le modèle à utiliser';
	@override String get advancedParameters => 'Paramètres avancés';
	@override String get parameters => 'Paramètres';
	@override String get parametersDescription => 'Température, Contexte, et plus';
	@override String get temperature => 'Température';
	@override String get temperatureDescription => 'Des valeurs plus élevées rendent la sortie plus créative';
	@override String get maxTokens => 'Max Tokens';
	@override String get maxTokensDescription => 'Limiter la longueur de la fenêtre de contexte';
	@override String get systemContext => 'Contexte système / Instructions';
	@override String get systemContextHint => 'Vous êtes un localisateur professionnel. Maintenez le ton et l\'intention de la chaîne source...';
	@override String get systemContextHelper => 'Fournissez des instructions spécifiques à l\'IA sur le style et la terminologie de votre projet.';
	@override String get contextStrings => 'Chaînes de contexte';
	@override String get contextStringsDescription => 'Inclure les chaînes environnantes pour un meilleur contexte';
	@override String get contextCount => 'Nombre de contextes';
	@override String get contextCountDescription => 'Nombre de chaînes environnantes à inclure';
	@override String get cloudServices => 'Services de traduction Cloud';
	@override String get googleTranslateApiKey => 'Clé API Google Translate';
	@override String get deeplApiKey => 'Clé API DeepL';
	@override String get test => 'Tester';
	@override String get resetToGlobal => 'Réinitialiser tous les paramètres d\'IA aux valeurs par défaut globales';
}

// Path: settings.integrations
class _TranslationsSettingsIntegrationsFr implements TranslationsSettingsIntegrationsEn {
	_TranslationsSettingsIntegrationsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get platformNotice => 'Avis de plateforme';
	@override String get platformNoticeDescription => 'Les intégrations système ne sont pas disponibles pour cette plateforme.';
	@override String get visualEffects => 'Effets visuels';
	@override String get explorerIntegration => 'Intégration de l\'explorateur';
	@override String get explorerIntegrationDescription => 'Ajouter "Ouvrir avec Localizer" au menu contextuel de l\'Explorateur Windows pour les dossiers.';
	@override String get addToContextMenu => 'Ajouter au menu contextuel';
	@override String get contextMenuAdded => 'Menu contextuel ajouté !';
	@override String get contextMenuAddError => 'Échec de l\'ajout du menu contextuel';
	@override String get contextMenuRemoved => 'Menu contextuel supprimé !';
	@override String get contextMenuRemoveError => 'Échec de la suppression du menu contextuel';
	@override String get fileAssociations => 'Associations de fichiers';
	@override String get fileAssociationsDescription => 'Enregistrer les types de fichiers pour les ouvrir avec Localizer lors d\'un double-clic dans l\'Explorateur.';
	@override String get registered => 'Enregistré';
	@override String get notRegistered => 'Non enregistré';
	@override String extRegistered({required Object ext}) => '${ext} enregistré !';
	@override String extUnregistered({required Object ext}) => '${ext} désenregistré !';
	@override String extError({required Object action, required Object ext}) => 'Échec de ${action} ${ext}';
	@override String get registerAll => 'Tout enregistrer';
	@override String get unregisterAll => 'Tout désenregistrer';
	@override String registerAllResult({required Object success, required Object total}) => 'Enregistré ${success} sur ${total} types de fichiers';
	@override String unregisterAllResult({required Object success, required Object total}) => 'Désenregistré ${success} sur ${total} types de fichiers';
	@override String get protocolHandler => 'Gestionnaire de protocole';
	@override String get protocolHandlerDescription => 'Enregistrer les URL localizer:// pour ouvrir cette application. Permet d\'ouvrir des projets directement depuis des liens de navigateur ou d\'autres applications.';
	@override String get protocolRegistered => 'Le gestionnaire de protocole est enregistré';
	@override String get protocolNotRegistered => 'Le gestionnaire de protocole n\'est pas enregistré';
	@override String get registerProtocol => 'Enregistrer le protocole';
	@override String get unregister => 'Désenregistrer';
	@override String get protocolRegisteredSuccess => 'Gestionnaire de protocole enregistré !';
	@override String get protocolRemovedSuccess => 'Gestionnaire de protocole supprimé !';
	@override String get protocolRegisterError => 'Échec de l\'enregistrement';
	@override String get protocolRemoveError => 'Échec de la suppression';
	@override String get windowMaterial => 'Matériau de la fenêtre';
	@override String get windowMaterialDescription => 'Sélectionnez le style de matériau de vibrance macOS';
	@override String get dockIntegration => 'Intégration du Dock';
	@override String get showDockBadge => 'Afficher le nombre de non traduits';
	@override String get showDockBadgeDescription => 'Afficher le nombre de chaînes non traduites sur le badge de l\'icône du dock';
	@override late final _TranslationsSettingsIntegrationsMaterialsFr materials = _TranslationsSettingsIntegrationsMaterialsFr._(_root);
	@override late final _TranslationsSettingsIntegrationsFileTypesFr fileTypes = _TranslationsSettingsIntegrationsFileTypesFr._(_root);
}

// Path: settings.developer
class _TranslationsSettingsDeveloperFr implements TranslationsSettingsDeveloperEn {
	_TranslationsSettingsDeveloperFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paramètres développeur';
	@override String get description => 'Paramètres avancés pour les développeurs';
	@override String get showLocalizationKeys => 'Afficher les clés de localisation';
	@override String get localizationKeysDescription => 'Une fois activé, tout le texte traduit affichera ses clés de localisation au lieu de la valeur traduite. Utile pour vérifier quelle clé est utilisée où.';
	@override String get showPerformanceOverlay => 'Afficher la superposition de performance';
	@override String get performanceOverlayDescription => 'Afficher les FPS et les informations sur le timing des images';
	@override String get debugMode => 'Mode de débogage';
	@override String get debugModeDescription => 'Activer la journalisation supplémentaire et les fonctionnalités de débogage';
	@override String get debuggingTools => 'Outils de débogage';
	@override String get semanticsDebugger => 'Débogueur de sémantique';
	@override String get semanticsDebuggerDescription => 'Visualiser l\'arbre sémantique';
	@override String get materialGrid => 'Grille Material';
	@override String get materialGridDescription => 'Superposer la grille de mise en page Material';
	@override String get rasterCache => 'Images du cache de rastérisation';
	@override String get rasterCacheDescription => 'Images du cache de rastérisation en damier';
	@override String get actions => 'Actions';
	@override String get showLogs => 'Afficher les journaux de l\'application';
	@override String get showLogsDescription => 'Ouvrir la console de débogage Talker';
	@override String get restartTutorial => 'Redémarrer le tutoriel de bienvenue';
	@override String get restartTutorialDescription => 'Réinitialiser les drapeaux et relancer le tutoriel';
	@override String get restartRequested => 'Redémarrage du tutoriel demandé.';
	@override String get throwException => 'Générer une exception de test';
	@override String get throwExceptionDescription => 'Déclencher une exception de test pour les rapports de plantage';
	@override String get testExceptionMessage => 'Exception de test déclenchée depuis les Options Développeur';
	@override String get clearTM => 'Effacer la mémoire de traduction';
	@override String get clearTMDescription => 'Supprimer toutes les traductions mises en cache';
	@override String get clearTMConfirmation => 'Effacer la mémoire de traduction ?';
	@override String get clearTMWarning => 'Cela supprimera toutes les traductions apprises. Cette action est irréversible.';
	@override String get tmCleared => 'Mémoire de traduction effacée';
	@override String get clearApiKeys => 'Effacer les clés API';
	@override String get clearApiKeysDescription => 'Supprimer toutes les clés API stockées';
	@override String get clearApiKeysConfirmation => 'Effacer les clés API ?';
	@override String get clearApiKeysWarning => 'Cela supprimera toutes les clés API du stockage sécurisé.';
	@override String get apiKeysCleared => 'Clés API effacées';
	@override String get hideOptions => 'Masquer les options développeur';
	@override String get hideOptionsDescription => 'Désactiver le mode développeur (nécessite 7 pressions pour réactiver)';
	@override String get optionsDisabled => 'Options développeur désactivées';
	@override String get dangerZone => 'Zone de danger';
	@override String get factoryReset => 'Réinitialisation d\'usine';
	@override String get factoryResetDescription => 'Réinitialiser tous les paramètres et effacer les données';
	@override String get factoryResetWarning => 'Êtes-vous sûr de vouloir réinitialiser tous les paramètres ? Cette action est irréversible.';
	@override String get inspectionTools => 'Outils d\'inspection';
	@override String get searchHint => 'Rechercher dans les paramètres...';
	@override String get resetToDefault => 'Réinitialiser par défaut';
	@override String get resetToGlobal => 'Réinitialiser au défaut global';
	@override String get storageInspector => 'Inspecteur de stockage';
	@override String get storageInspectorDescription => 'Voir le contenu de Hive & du stockage sécurisé';
	@override String get deviceEnvironment => 'Appareil & Environnement';
	@override String get deviceEnvironmentDescription => 'Écran, plateforme, et infos de build';
	@override String get themePlayground => 'Terrain de jeu des thèmes';
	@override String get themePlaygroundDescription => 'Palette de couleurs & typographie';
	@override late final _TranslationsSettingsDeveloperThemePlaygroundSectionFr themePlaygroundSection = _TranslationsSettingsDeveloperThemePlaygroundSectionFr._(_root);
	@override String get localizationInspector => 'Inspecteur de localisation';
	@override String get localizationInspectorDescription => 'Déboguer les chaînes de traduction';
	@override String get hiveAppSettings => 'Hive (AppSettings)';
	@override String get secureStorageMasked => 'Stockage sécurisé (Masqué)';
	@override late final _TranslationsSettingsDeveloperFeatureFlagsFr featureFlags = _TranslationsSettingsDeveloperFeatureFlagsFr._(_root);
	@override late final _TranslationsSettingsDeveloperStorageInspectorSectionFr storageInspectorSection = _TranslationsSettingsDeveloperStorageInspectorSectionFr._(_root);
	@override late final _TranslationsSettingsDeveloperDeviceInfoSectionFr deviceInfoSection = _TranslationsSettingsDeveloperDeviceInfoSectionFr._(_root);
	@override late final _TranslationsSettingsDeveloperLocalizationInspectorSectionFr localizationInspectorSection = _TranslationsSettingsDeveloperLocalizationInspectorSectionFr._(_root);
}

// Path: settings.about
class _TranslationsSettingsAboutFr implements TranslationsSettingsAboutEn {
	_TranslationsSettingsAboutFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'À propos';
	@override String get version => 'Version';
	@override String get buildNumber => 'Numéro de build';
	@override String get author => 'Auteur';
	@override String get license => 'Licence';
	@override String get sourceCode => 'Code source';
	@override String get reportBug => 'Signaler un bug';
	@override String get requestFeature => 'Demander une fonctionnalité';
	@override String get checkForUpdates => 'Vérifier les mises à jour';
	@override String get upToDate => 'Vous êtes à jour !';
	@override String updateAvailable({required Object version}) => 'Mise à jour disponible : ${version}';
	@override String get updateAvailableBadge => 'Mise à jour disponible !';
	@override String developerSteps({required Object count}) => 'Vous êtes à ${count} étapes de devenir un développeur.';
	@override String get developerActivated => 'Vous êtes maintenant un développeur !';
	@override String get neverChecked => 'Jamais';
	@override String get applicationInfo => 'Infos de l\'application';
	@override String get platform => 'Plateforme';
	@override String get updateInformation => 'Informations de mise à jour';
	@override String get currentVersion => 'Version actuelle';
	@override String get latestVersion => 'Dernière version';
	@override String get lastChecked => 'Dernière vérification';
	@override String get checkingForUpdates => 'Vérification...';
	@override String get whatsNew => 'Quoi de neuf';
	@override String get systemInformation => 'Informations système';
	@override String get dartVersion => 'Version de Dart';
	@override String get diskSpace => 'Espace disque disponible';
	@override String get memoryUsage => 'Utilisation de la mémoire';
	@override String get privacyTitle => 'Confidentialité & Télémétrie';
	@override String get usageStats => 'Statistiques d\'utilisation anonymes';
	@override String get requiresFirebase => 'Nécessite une configuration Firebase';
	@override String get featureUnavailable => 'Fonctionnalité actuellement indisponible (nécessite Firebase)';
	@override String get settingsManagement => 'Gestion des paramètres';
	@override String get settingsManagementDescription => 'Exportez vos paramètres dans un fichier pour les sauvegarder ou les partager avec d\'autres machines.';
	@override String get resetAll => 'Tout réinitialiser';
	@override String get links => 'Liens';
	@override String get githubRepo => 'Dépôt GitHub';
	@override String get privacyPolicy => 'Politique de confidentialité';
	@override String get crashReporting => 'Rapports de plantage';
}

// Path: settings.onboarding
class _TranslationsSettingsOnboardingFr implements TranslationsSettingsOnboardingEn {
	_TranslationsSettingsOnboardingFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get skipTutorial => 'Ignorer le tutoriel';
	@override String get gettingStarted => 'Commencer';
	@override String stepProgress({required Object current, required Object total}) => '${current} sur ${total}';
	@override String get loadSampleData => 'Charger des données d\'exemple';
	@override late final _TranslationsSettingsOnboardingStepsFr steps = _TranslationsSettingsOnboardingStepsFr._(_root);
}

// Path: settings.settingsView
class _TranslationsSettingsSettingsViewFr implements TranslationsSettingsSettingsViewEn {
	_TranslationsSettingsSettingsViewFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String resetCategoryTitle({required Object category}) => 'Réinitialiser ${category} ?';
	@override String get resetCategoryContent => 'Cela réinitialisera tous les paramètres de cette catégorie à leurs valeurs par défaut.';
	@override String get resetAllTitle => 'Réinitialiser tous les paramètres ?';
	@override String get resetAllContent => 'Cela réinitialisera définitivement tous les paramètres à leurs valeurs d\'usine. Cette action est irréversible.';
	@override String get resetAll => 'Tout réinitialiser';
	@override String resetSuccess({required Object category}) => '${category} réinitialisé aux valeurs par défaut';
	@override String get errorLoading => 'Erreur lors du chargement des paramètres';
	@override String get settingsSaved => 'Paramètres sauvegardés';
	@override String updateAvailable({required Object version}) => 'Mise à jour disponible : v${version}';
	@override String get latestVersion => 'Vous utilisez la dernière version';
	@override String whatsNew({required Object version}) => 'Quoi de neuf dans la v${version}';
	@override String get downloadUpdate => 'Télécharger la mise à jour';
	@override String get exportSettings => 'Exporter les paramètres';
	@override String get settingsExported => 'Paramètres exportés';
	@override String exportFail({required Object error}) => 'Échec de l\'exportation des paramètres : ${error}';
	@override String get importSettings => 'Importer les paramètres';
	@override String get importTitle => 'Importer les paramètres ?';
	@override String get importContent => 'Cela remplacera tous vos paramètres actuels par ceux importés. Cette action est irréversible.';
	@override String get importSuccess => 'Paramètres importés avec succès !';
	@override String importFail({required Object error}) => 'Échec de l\'importation des paramètres : ${error}';
	@override String get invalidFormat => 'Format de fichier de paramètres invalide';
	@override late final _TranslationsSettingsSettingsViewCategoriesFr categories = _TranslationsSettingsSettingsViewCategoriesFr._(_root);
	@override late final _TranslationsSettingsSettingsViewCategoryLabelsFr categoryLabels = _TranslationsSettingsSettingsViewCategoryLabelsFr._(_root);
}

// Path: advancedDiff.aiSuggestion
class _TranslationsAdvancedDiffAiSuggestionFr implements TranslationsAdvancedDiffAiSuggestionEn {
	_TranslationsAdvancedDiffAiSuggestionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get aiTranslation => 'Traduction par IA';
	@override String get aiRephrase => 'Reformulation par IA';
	@override String key({required Object key}) => 'Clé : ${key}';
	@override String get original => 'Original :';
	@override String get suggestion => 'Suggestion :';
	@override String get confidence => 'Confiance de l\'IA';
	@override String get cancelEdit => 'Annuler la modification';
	@override String get editSuggestion => 'Modifier la suggestion';
	@override String get alternatives => 'Alternatives :';
	@override String get accept => 'Accepter';
	@override String get reject => 'Rejeter';
	@override String get stop => 'Arrêter';
}

// Path: advancedDiff.detailEdit
class _TranslationsAdvancedDiffDetailEditFr implements TranslationsAdvancedDiffDetailEditEn {
	_TranslationsAdvancedDiffDetailEditFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object key}) => 'Modifier : ${key}';
	@override String get sourceLabel => 'SOURCE (Original)';
	@override String get targetLabel => 'CIBLE (Traduction)';
	@override String get translateWithCloud => 'Traduire avec le Cloud';
	@override String get translateWithAi => 'Traduire avec l\'IA';
	@override String get translating => 'Traduction en cours...';
	@override String get applyAndTm => 'Appliquer';
	@override String get entryApplied => 'Entrée appliquée & ajoutée à la MT';
	@override String get translationAdded => 'Suggestion de traduction ajoutée.';
	@override String get aiSuggestionAdded => 'Suggestion d\'IA ajoutée.';
}

// Path: advancedDiff.table
class _TranslationsAdvancedDiffTableFr implements TranslationsAdvancedDiffTableEn {
	_TranslationsAdvancedDiffTableFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get addedToTM => 'Ajouté à la mémoire de traduction';
	@override String get markedReviewed => 'Marqué comme révisé ✓';
	@override String get unmarkedReview => 'Révision décochée';
	@override String get reverted => 'Revenu à la valeur source';
	@override String get entryDeleted => 'Entrée supprimée';
	@override String get noSourceText => 'Aucun texte source à traduire.';
	@override String aiTranslationFailed({required Object key}) => 'Échec de la traduction par IA pour "${key}"';
	@override String get noTargetText => 'Aucun texte cible à reformuler.';
	@override String aiRephraseFailed({required Object key}) => 'Échec de la reformulation par IA pour "${key}"';
	@override String get checkRowsFirst => 'Cochez d\'abord les lignes à l\'aide des cases à cocher';
	@override String markedRowsReviewed({required Object count}) => '${count} lignes marquées comme révisées';
	@override String revertedRows({required Object count}) => '${count} lignes réinitialisées';
	@override String entriesCount({required Object count}) => '${count} entrées';
	@override String get markSelectedReviewed => 'Marquer la sélection comme révisée';
	@override String get revertSelected => 'Réinitialiser la sélection';
	@override String get noDifferences => 'Aucune différence trouvée';
	@override String get adjustFilters => 'Essayez d\'ajuster vos filtres';
	@override String get cloudTranslationApplied => 'Traduction Cloud appliquée.';
	@override String get aiTranslationApplied => 'Traduction par IA appliquée.';
	@override String get suggestionApplied => 'Suggestion appliquée.';
	@override String get aiSuggestionApplied => 'Suggestion d\'IA appliquée.';
	@override String get rephraseApplied => 'Reformulation appliquée.';
	@override String get aiRephraseApplied => 'Reformulation par IA appliquée.';
	@override String get rephrase => 'Reformuler';
	@override String get aiRephrase => 'Reformuler par IA';
	@override String get targetClickToEdit => 'CIBLE (Cliquez pour modifier)';
	@override String get targetClickForDialog => 'CIBLE (Cliquez pour ouvrir la boîte de dialogue)';
	@override String get emptyClickToEdit => '(Vide - Cliquez pour modifier)';
	@override String get unmarkReviewed => 'Décocher révisé';
	@override String get markReviewed => 'Marquer comme révisé';
	@override String get revertToSource => 'Revenir à la source';
	@override String get translateWithCloud => 'Traduire avec le Cloud';
	@override String get translateWithAi => 'Traduire avec l\'IA';
	@override String get rephraseWithAi => 'Reformuler par IA';
	@override String get moreActions => 'Plus d\'actions';
	@override String get editDetails => 'Modifier les détails';
	@override String get suggestTranslation => 'Suggérer une traduction';
	@override String get addToTm => 'Ajouter à la MT';
	@override String get deleteEntry => 'Supprimer l\'entrée';
}

// Path: advancedDiff.diffRow
class _TranslationsAdvancedDiffDiffRowFr implements TranslationsAdvancedDiffDiffRowEn {
	_TranslationsAdvancedDiffDiffRowFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get copySource => 'Copier le texte source';
	@override String get actions => 'Actions';
}

// Path: advancedDiff.status
class _TranslationsAdvancedDiffStatusFr implements TranslationsAdvancedDiffStatusEn {
	_TranslationsAdvancedDiffStatusFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get added => 'AJOUTÉ';
	@override String get missing => 'MANQUANT';
	@override String changed({required Object percent}) => 'MOD ${percent}%';
	@override String get same => 'IDENTIQUE';
}

// Path: advancedDiff.sidebar
class _TranslationsAdvancedDiffSidebarFr implements TranslationsAdvancedDiffSidebarEn {
	_TranslationsAdvancedDiffSidebarFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get widgets => 'Widgets';
	@override String get searchPlaceholder => 'Rechercher clés & valeurs... (Ctrl+F)';
	@override String get fuzzySearchTooltip => 'Recherche floue (tolérante aux fautes)';
	@override String get regexSearchTooltip => 'Recherche Regex';
	@override String get cloudTranslation => 'Traduction Cloud';
	@override String get aiTranslation => 'Traduction par IA';
	@override String get status => 'Statut';
	@override String get tm => 'Mémoire de traduction';
	@override String get filters => 'Filtres';
	@override String get actions => 'Actions';
	@override String get similarity => 'Similitude';
	@override late final _TranslationsAdvancedDiffSidebarActionsSectionFr actionsSection = _TranslationsAdvancedDiffSidebarActionsSectionFr._(_root);
	@override late final _TranslationsAdvancedDiffSidebarAiSectionFr aiSection = _TranslationsAdvancedDiffSidebarAiSectionFr._(_root);
	@override late final _TranslationsAdvancedDiffSidebarTmSectionFr tmSection = _TranslationsAdvancedDiffSidebarTmSectionFr._(_root);
	@override late final _TranslationsAdvancedDiffSidebarFiltersSectionFr filtersSection = _TranslationsAdvancedDiffSidebarFiltersSectionFr._(_root);
	@override late final _TranslationsAdvancedDiffSidebarSimilaritySectionFr similaritySection = _TranslationsAdvancedDiffSidebarSimilaritySectionFr._(_root);
	@override late final _TranslationsAdvancedDiffSidebarStatusSectionFr statusSection = _TranslationsAdvancedDiffSidebarStatusSectionFr._(_root);
}

// Path: issueDetails.duplicateValue
class _TranslationsIssueDetailsDuplicateValueFr implements TranslationsIssueDetailsDuplicateValueEn {
	_TranslationsIssueDetailsDuplicateValueFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'TRADUCTION RÉPÉTÉE';
	@override String get warning => 'Différents textes sources utilisent cette même traduction. Vérifiez le contexte.';
	@override String affectedKeys({required Object count}) => 'CLÉS AFFECTÉES (${count})';
	@override String get identicalSources => 'Sources identiques';
	@override String moreKeys({required Object count}) => '+${count} clés de plus';
}

// Path: issueDetails.lengthOutlier
class _TranslationsIssueDetailsLengthOutlierFr implements TranslationsIssueDetailsLengthOutlierEn {
	_TranslationsIssueDetailsLengthOutlierFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get source => 'SOURCE';
	@override String get translation => 'TRADUCTION';
	@override String chars({required Object count}) => '${count} car.';
}

// Path: issueDetails.standard
class _TranslationsIssueDetailsStandardFr implements TranslationsIssueDetailsStandardEn {
	_TranslationsIssueDetailsStandardFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get key => 'CLÉ';
	@override String get sourceText => 'TEXTE SOURCE';
	@override String get translation => 'TRADUCTION';
	@override String get errorDetails => 'DÉTAILS DE L\'ERREUR';
	@override String get note => 'NOTE';
}

// Path: issueDetails.types
class _TranslationsIssueDetailsTypesFr implements TranslationsIssueDetailsTypesEn {
	_TranslationsIssueDetailsTypesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get duplicateValue => 'Valeurs en double';
	@override String get lengthOutlier => 'Écart de longueur';
	@override String get placeholderMismatch => 'Espaces réservés erronés';
}

// Path: issueDetails.notes
class _TranslationsIssueDetailsNotesFr implements TranslationsIssueDetailsNotesEn {
	_TranslationsIssueDetailsNotesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get placeholderMismatch => 'Les marqueurs comme {name} doivent correspondre à la source.';
	@override String get lengthOutlier => 'De grands changements de longueur peuvent affecter l\'affichage du texte à l\'écran.';
	@override String get duplicateValue => 'La même traduction est utilisée pour différentes clés.';
}

// Path: issueDetails.fallbacks
class _TranslationsIssueDetailsFallbacksFr implements TranslationsIssueDetailsFallbacksEn {
	_TranslationsIssueDetailsFallbacksFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get multipleSources => 'Plusieurs textes sources';
	@override String get sourceNotAvailable => 'Texte source non disponible';
	@override String get sharedTranslationNotAvailable => 'Traduction partagée non disponible';
	@override String get translationNotAvailable => 'Traduction non disponible';
}

// Path: compare.tabs
class _TranslationsCompareTabsFr implements TranslationsCompareTabsEn {
	_TranslationsCompareTabsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get files => 'Fichiers';
	@override String get directories => 'Dossiers';
	@override String get git => 'Git';
}

// Path: compare.fileTypes
class _TranslationsCompareFileTypesFr implements TranslationsCompareFileTypesEn {
	_TranslationsCompareFileTypesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get json => 'Fichiers de localisation JSON (i18next, Flutter, etc.)';
	@override String get yaml => 'Fichiers de localisation YAML (Rails, Flutter)';
	@override String get xml => 'Fichiers de localisation XML (Android, .NET)';
	@override String get properties => 'Fichiers properties (Java)';
	@override String get resx => 'Fichiers RESX (.NET)';
	@override String get xliff => 'Fichiers XLIFF';
}

// Path: history.timeAgo
class _TranslationsHistoryTimeAgoFr implements TranslationsHistoryTimeAgoEn {
	_TranslationsHistoryTimeAgoFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get justNow => 'à l\'instant';
	@override String secondsAgo({required Object count}) => 'il y a ${count} secondes';
	@override String get oneMinuteAgo => 'il y a 1 minute';
	@override String minutesAgo({required Object count}) => 'il y a ${count} minutes';
	@override String get oneHourAgo => 'il y a 1 heure';
	@override String hoursAgo({required Object count}) => 'il y a ${count} heures';
	@override String get yesterday => 'hier';
	@override String daysAgo({required Object count}) => 'il y a ${count} jours';
	@override String get oneWeekAgo => 'il y a 1 semaine';
	@override String weeksAgo({required Object count}) => 'il y a ${count} semaines';
	@override String get oneMonthAgo => 'il y a 1 mois';
	@override String monthsAgo({required Object count}) => 'il y a ${count} mois';
	@override String get oneYearAgo => 'il y a 1 an';
	@override String yearsAgo({required Object count}) => 'il y a ${count} ans';
	@override String get inTheFuture => 'dans le futur';
}

// Path: projects.stats
class _TranslationsProjectsStatsFr implements TranslationsProjectsStatsEn {
	_TranslationsProjectsStatsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Projet vide';
	@override String files({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '1 fichier de traduction',
		other: '${count} fichiers de traduction',
	);
	@override String languages({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '1 langue',
		other: '${count} langues',
	);
}

// Path: projects.selection
class _TranslationsProjectsSelectionFr implements TranslationsProjectsSelectionEn {
	_TranslationsProjectsSelectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get selectFolder => 'Sélectionner le dossier du projet';
	@override String get selectArchive => 'Sélectionner l\'archive du projet';
	@override String get openProject => 'Ouvrir le projet';
	@override String get browseFolder => 'Parcourir le dossier...';
	@override String get createNew => 'Créer un nouveau';
	@override String get importFromZip => 'Importer depuis un Zip...';
}

// Path: projects.createDialog
class _TranslationsProjectsCreateDialogFr implements TranslationsProjectsCreateDialogEn {
	_TranslationsProjectsCreateDialogFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Créer un projet';
	@override String get description => 'Un projet vous permet d\'enregistrer des paramètres personnalisés pour un dossier spécifique. Un dossier ".localizer" sera créé pour stocker la configuration de votre projet.';
	@override String get folderLabel => 'Dossier du projet';
	@override String get folderHint => 'Cliquez pour sélectionner le dossier...';
	@override String get nameLabel => 'Nom du projet';
	@override String get nameHint => 'ex: Mon App Traductions';
	@override String get selectFolderWarning => 'Veuillez sélectionner un dossier de projet.';
	@override String get enterNameError => 'Veuillez entrer un nom de projet';
	@override String get nameLengthError => 'Le nom doit comporter au moins 2 caractères';
	@override String success({required Object name}) => 'Projet "${name}" créé avec succès !';
	@override String get failure => 'Échec de la création du projet.';
	@override String get creating => 'Création...';
	@override String get createAction => 'Créer le projet';
}

// Path: projects.indicator
class _TranslationsProjectsIndicatorFr implements TranslationsProjectsIndicatorEn {
	_TranslationsProjectsIndicatorFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get tooltipNoProject => 'Créez un projet pour enregistrer des paramètres personnalisés pour un dossier';
	@override String tooltipProject({required Object name}) => 'Projet : ${name}\nCliquez pour voir les options';
	@override String get location => 'Emplacement';
	@override String get created => 'Créé';
	@override String get switchProject => 'Changer de projet';
	@override String get done => 'Terminé';
}

// Path: projects.glossary
class _TranslationsProjectsGlossaryFr implements TranslationsProjectsGlossaryEn {
	_TranslationsProjectsGlossaryFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Glossaire du projet';
	@override String get description => 'Définissez des termes qui doivent être traités de manière cohérente ou ne jamais être traduits.';
	@override String get noTerms => 'Aucun terme dans le glossaire pour le moment.';
	@override String get noTermsDesc => 'Ajoutez des termes qui doivent rester cohérents d\'une traduction à l\'autre,\nou marquez des noms de marque qui ne doivent jamais être traduits.';
	@override String get doNotTranslate => 'Ne pas traduire';
	@override String get noSpecificTranslation => 'Pas de traduction spécifique';
	@override String get addTerm => 'Ajouter un terme';
	@override String get editTerm => 'Modifier le terme';
	@override String get term => 'Terme';
	@override String get termHint => 'ex: nom de marque, terme spécialisé';
	@override String get definition => 'Définition (Optionnel)';
	@override String get definitionHint => 'Contexte pour le traducteur';
	@override String get doNotTranslateLabel => 'Ne pas traduire';
	@override String get doNotTranslateDesc => 'Garder le terme exactement tel quel dans la cible';
	@override String get preferredTranslation => 'Traduction préférée';
	@override String get caseSensitive => 'Sensible à la casse';
}

// Path: projects.conflicts
class _TranslationsProjectsConflictsFr implements TranslationsProjectsConflictsEn {
	_TranslationsProjectsConflictsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String missingApiKeyTitle({required Object service}) => 'Clé API manquante pour ${service}';
	@override String missingApiKeyMessage({required Object service}) => 'Ce projet utilise ${service} mais aucune clé API n\'est configurée. Ajoutez votre clé API dans Paramètres > Services d\'IA, sinon l\'application utilisera le défaut global.';
	@override String get dismiss => 'Ignorer';
}

// Path: projects.tm
class _TranslationsProjectsTmFr implements TranslationsProjectsTmEn {
	_TranslationsProjectsTmFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mémoires de traduction';
	@override String get description => 'Gérez les sources de mémoire de traduction pour ce projet.';
	@override String get globalTm => 'Mémoire de traduction globale';
	@override String get globalTmDescription => 'Utilisez la mémoire de traduction partagée de vos paramètres d\'application';
	@override String get linkedFiles => 'Fichiers liés (Spécifiques au projet)';
	@override String get noLinkedFiles => 'Aucun fichier spécifique au projet lié.';
	@override String get addTmFile => 'Ajouter un fichier MT';
	@override String get useGlobalTm => 'Utiliser la MT globale';
	@override String get selectTm => 'Sélectionner la mémoire de traduction';
	@override String get globalTmEnabled => 'Mémoire de traduction globale activée';
}

// Path: git.conflicts
class _TranslationsGitConflictsFr implements TranslationsGitConflictsEn {
	_TranslationsGitConflictsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Merge Conflicts Detected';
	@override String get description => 'You must resolve these conflicts before you can continue.';
	@override String get abortMergeTitle => 'Abort Merge?';
	@override String get abortMergeContent => 'This will revert all merge changes and return to the state before the merge. This cannot be undone.';
	@override String get abortMergeAction => 'Abort Merge';
	@override String stagingFile({required Object file}) => 'Staging ${file} for commit...';
	@override String conflictedFilesCount({required Object count}) => 'Conflicted Files (${count})';
	@override String get selectFileToResolve => 'Select a file to resolve';
	@override String resolvingFile({required Object file}) => 'Resolving: ${file}';
	@override String get keepAllOurs => 'Keep All Ours';
	@override String get acceptAllTheirs => 'Accept All Theirs';
	@override String get allResolved => 'All conflicts in this file have been resolved!';
	@override String get markResolved => 'Mark as Resolved';
	@override String get stageForCommit => 'This will stage the file for commit.';
	@override String conflictIndex({required Object index}) => 'Conflict #${index}';
	@override String get ours => 'OURS (Current)';
	@override String get theirs => 'THEIRS (Incoming)';
	@override String get keepOurs => 'Keep Ours';
	@override String get acceptTheirs => 'Accept Theirs';
	@override String get empty => '(Empty)';
}

// Path: wizards.firstRun
class _TranslationsWizardsFirstRunFr implements TranslationsWizardsFirstRunEn {
	_TranslationsWizardsFirstRunFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Bienvenue sur Localizer';
	@override String get description => 'Comparez vos fichiers de localisation en quelques secondes.';
	@override String get sourceFile => 'Fichier source';
	@override String get targetFile => 'Fichier cible';
	@override String get compareNow => 'Comparer maintenant';
	@override String get trySample => 'Essayer avec des données d\'exemple';
	@override String get skip => 'Ignorer la configuration';
	@override String get browse => 'Cliquez pour parcourir';
	@override String error({required Object error}) => 'Échec du chargement des données d\'exemple : ${error}';
}

// Path: dialogs.addIgnorePattern
class _TranslationsDialogsAddIgnorePatternFr implements TranslationsDialogsAddIgnorePatternEn {
	_TranslationsDialogsAddIgnorePatternFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajouter un motif à ignorer';
	@override String get patternLabel => 'Motif (regex)';
	@override String get hint => 'ex: ^temp_.*';
	@override String get invalid => 'Motif regex invalide';
	@override String get testStringLabel => 'Chaîne de test';
	@override String get testHint => 'Entrez une clé pour tester le motif';
	@override String get match => '✓ Le motif correspond à la chaîne de test';
	@override String get noMatch => '✗ Le motif ne correspond pas';
	@override String get add => 'Ajouter';
	@override String get cancel => 'Annuler';
}

// Path: dialogs.diffViewer
class _TranslationsDialogsDiffViewerFr implements TranslationsDialogsDiffViewerEn {
	_TranslationsDialogsDiffViewerFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Visionneuse de diff';
	@override String get originalFile => 'Fichier original/référence';
	@override String get translationFile => 'Fichier traduction/comparaison';
	@override String get base => 'BASE';
	@override String get target => 'CIBLE';
	@override String get added => 'Ajouté';
	@override String get removed => 'Supprimé';
	@override String get modified => 'Modifié';
	@override String get noMatches => 'Aucune entrée ne correspond aux filtres actuels';
	@override String get clickToggle => 'Cliquez sur les badges ci-dessus pour activer les filtres';
}

// Path: grid.columns
class _TranslationsGridColumnsFr implements TranslationsGridColumnsEn {
	_TranslationsGridColumnsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get key => 'Clé';
	@override String get source => 'Source';
	@override String get status => 'Statut';
	@override String get actions => 'Actions';
}

// Path: tutorial.steps
class _TranslationsTutorialStepsFr implements TranslationsTutorialStepsEn {
	_TranslationsTutorialStepsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTutorialStepsImportSourceFr importSource = _TranslationsTutorialStepsImportSourceFr._(_root);
	@override late final _TranslationsTutorialStepsImportTargetFr importTarget = _TranslationsTutorialStepsImportTargetFr._(_root);
	@override late final _TranslationsTutorialStepsCompareFr compare = _TranslationsTutorialStepsCompareFr._(_root);
	@override late final _TranslationsTutorialStepsFilterFr filter = _TranslationsTutorialStepsFilterFr._(_root);
	@override late final _TranslationsTutorialStepsSearchFr search = _TranslationsTutorialStepsSearchFr._(_root);
	@override late final _TranslationsTutorialStepsAdvancedFr advanced = _TranslationsTutorialStepsAdvancedFr._(_root);
	@override late final _TranslationsTutorialStepsExportFr export = _TranslationsTutorialStepsExportFr._(_root);
}

// Path: friendlyErrors.fileNotFound
class _TranslationsFriendlyErrorsFileNotFoundFr implements TranslationsFriendlyErrorsFileNotFoundEn {
	_TranslationsFriendlyErrorsFileNotFoundFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Le fichier ou le dossier est introuvable.';
	@override String get suggestion => 'Vérifiez si le fichier a été déplacé ou supprimé.';
}

// Path: friendlyErrors.accessDenied
class _TranslationsFriendlyErrorsAccessDeniedFr implements TranslationsFriendlyErrorsAccessDeniedEn {
	_TranslationsFriendlyErrorsAccessDeniedFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'L\'accès au fichier a été refusé.';
	@override String get suggestion => 'Essayez de lancer l\'application en tant qu\'administrateur ou vérifiez les permissions du fichier.';
}

// Path: friendlyErrors.isDirectory
class _TranslationsFriendlyErrorsIsDirectoryFr implements TranslationsFriendlyErrorsIsDirectoryEn {
	_TranslationsFriendlyErrorsIsDirectoryFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Un dossier a été sélectionné à la place d\'un fichier.';
	@override String get suggestion => 'Veuillez sélectionner un fichier valide.';
}

// Path: friendlyErrors.fileAccess
class _TranslationsFriendlyErrorsFileAccessFr implements TranslationsFriendlyErrorsFileAccessEn {
	_TranslationsFriendlyErrorsFileAccessFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Un problème est survenu lors de l\'accès au fichier.';
	@override String get suggestion => 'Essayez de fermer les autres programmes qui pourraient l\'utiliser.';
}

// Path: friendlyErrors.unsupportedFormat
class _TranslationsFriendlyErrorsUnsupportedFormatFr implements TranslationsFriendlyErrorsUnsupportedFormatEn {
	_TranslationsFriendlyErrorsUnsupportedFormatFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Ce format de fichier ou cette opération n\'est pas pris en charge.';
	@override String get suggestion => 'Vérifiez l\'extension du fichier ou essayez un format différent.';
}

// Path: friendlyErrors.networkError
class _TranslationsFriendlyErrorsNetworkErrorFr implements TranslationsFriendlyErrorsNetworkErrorEn {
	_TranslationsFriendlyErrorsNetworkErrorFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Impossible de se connecter au serveur.';
	@override String get suggestion => 'Vérifiez votre connexion internet et réessayez.';
}

// Path: friendlyErrors.notGitRepo
class _TranslationsFriendlyErrorsNotGitRepoFr implements TranslationsFriendlyErrorsNotGitRepoEn {
	_TranslationsFriendlyErrorsNotGitRepoFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Ce dossier n\'est pas un projet Git.';
	@override String get suggestion => 'Naviguez vers un dossier contenant un répertoire .git.';
}

// Path: friendlyErrors.mergeConflict
class _TranslationsFriendlyErrorsMergeConflictFr implements TranslationsFriendlyErrorsMergeConflictEn {
	_TranslationsFriendlyErrorsMergeConflictFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Il y a des conflits de fusion dans le dépôt.';
	@override String get suggestion => 'Résolvez les conflits avant de continuer.';
}

// Path: friendlyErrors.gitAuthFailed
class _TranslationsFriendlyErrorsGitAuthFailedFr implements TranslationsFriendlyErrorsGitAuthFailedEn {
	_TranslationsFriendlyErrorsGitAuthFailedFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'L\'authentification Git a échoué.';
	@override String get suggestion => 'Vérifiez vos identifiants dans Paramètres > Gestion de versions.';
}

// Path: friendlyErrors.gitOperationFailed
class _TranslationsFriendlyErrorsGitOperationFailedFr implements TranslationsFriendlyErrorsGitOperationFailedEn {
	_TranslationsFriendlyErrorsGitOperationFailedFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Une opération Git a échoué.';
	@override String get suggestion => 'Vérifiez la vue Git pour plus de détails.';
}

// Path: friendlyErrors.invalidJson
class _TranslationsFriendlyErrorsInvalidJsonFr implements TranslationsFriendlyErrorsInvalidJsonEn {
	_TranslationsFriendlyErrorsInvalidJsonFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Le format du fichier est invalide ou corrompu.';
	@override String get suggestion => 'Assurez-vous que le fichier contient un contenu JSON valide.';
}

// Path: friendlyErrors.rateLimitReached
class _TranslationsFriendlyErrorsRateLimitReachedFr implements TranslationsFriendlyErrorsRateLimitReachedEn {
	_TranslationsFriendlyErrorsRateLimitReachedFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Limite de traduction atteinte.';
	@override String get suggestion => 'Attendez quelques minutes ou vérifiez les limites de votre plan API.';
}

// Path: friendlyErrors.invalidApiKey
class _TranslationsFriendlyErrorsInvalidApiKeyFr implements TranslationsFriendlyErrorsInvalidApiKeyEn {
	_TranslationsFriendlyErrorsInvalidApiKeyFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Clé API invalide.';
	@override String get suggestion => 'Allez dans Paramètres > Traduction par IA pour mettre à jour votre clé API.';
}

// Path: friendlyErrors.translationServiceError
class _TranslationsFriendlyErrorsTranslationServiceErrorFr implements TranslationsFriendlyErrorsTranslationServiceErrorEn {
	_TranslationsFriendlyErrorsTranslationServiceErrorFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Erreur du service de traduction.';
	@override String get suggestion => 'Vérifiez votre clé API et votre connexion internet.';
}

// Path: friendlyErrors.outOfMemory
class _TranslationsFriendlyErrorsOutOfMemoryFr implements TranslationsFriendlyErrorsOutOfMemoryEn {
	_TranslationsFriendlyErrorsOutOfMemoryFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Mémoire insuffisante pour terminer cette opération.';
	@override String get suggestion => 'Essayez de fermer d\'autres applications ou d\'utiliser des fichiers plus petits.';
}

// Path: friendlyErrors.genericError
class _TranslationsFriendlyErrorsGenericErrorFr implements TranslationsFriendlyErrorsGenericErrorEn {
	_TranslationsFriendlyErrorsGenericErrorFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get message => 'Un problème est survenu.';
	@override String get suggestion => 'Veuillez réessayer. Si le problème persiste, redémarrez l\'application.';
}

// Path: settings.appearance.presets
class _TranslationsSettingsAppearancePresetsFr implements TranslationsSettingsAppearancePresetsEn {
	_TranslationsSettingsAppearancePresetsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get presetDefault => 'Par défaut';
	@override String get presetColorblind => 'Adapté aux daltoniens';
	@override String get presetHighContrast => 'Contraste élevé';
	@override String get presetNord => 'Nord';
	@override String get presetSolarized => 'Solarized';
	@override String get presetMonokai => 'Monokai';
}

// Path: settings.appearance.preview
class _TranslationsSettingsAppearancePreviewFr implements TranslationsSettingsAppearancePreviewEn {
	_TranslationsSettingsAppearancePreviewFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get step3Title => 'onboarding.step3.title';
	@override String get connectAccount => '"Connectez votre compte"';
	@override String get loginHint => 'deprecated.login_hint_v1';
	@override String get enterCredentials => '"Entrez vos identifiants"';
	@override String get ctaButton => 'checkout.cta_button';
	@override String get buyNow => '"Acheter maintenant"';
	@override String get completePurchase => '"Finaliser l\'achat"';
	@override String get appNameKey => 'common.app_name';
	@override String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class _TranslationsSettingsComparisonPatternPresetsFr implements TranslationsSettingsComparisonPatternPresetsEn {
	_TranslationsSettingsComparisonPatternPresetsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get comments => 'Commentaires';
	@override String get tempKeys => 'Clés temporaires';
	@override String get placeholders => 'Espaces réservés';
	@override String get devOnly => 'Dév uniquement';
}

// Path: settings.comparison.previewMatch
class _TranslationsSettingsComparisonPreviewMatchFr implements TranslationsSettingsComparisonPreviewMatchEn {
	_TranslationsSettingsComparisonPreviewMatchFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aperçu de correspondance';
	@override String get description => 'Testez comment vos paramètres actuels affectent la logique de correspondance.';
	@override String get stringA => 'Chaîne A';
	@override String get stringB => 'Chaîne B';
	@override String get enterText => 'Entrez du texte...';
	@override String get similarity => 'Similitude';
	@override String get identical => 'Identique';
	@override String get identicalDescription => 'Les chaînes correspondent exactement après normalisation.';
	@override String get ignored => 'Ignoré';
	@override String get ignoredDescription => 'L\'entrée correspond à un motif à ignorer.';
	@override String get different => 'Différent';
	@override String get differentDescription => 'Une valeur est vide.';
	@override String get similarModified => 'Similaire / Modifié';
	@override String similarModifiedDescription({required Object threshold}) => 'Le score de correspondance est supérieur au seuil (${threshold}%).';
	@override String get newDifferent => 'Nouveau / Différent';
	@override String newDifferentDescription({required Object threshold}) => 'Le score de correspondance est inférieur au seuil (${threshold}%).';
}

// Path: settings.comparison.colorPresets
class _TranslationsSettingsComparisonColorPresetsFr implements TranslationsSettingsComparisonColorPresetsEn {
	_TranslationsSettingsComparisonColorPresetsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get kDefault => 'Par défaut';
	@override String get colorblindFriendly => 'Adapté aux daltoniens';
	@override String get highContrast => 'Contraste élevé';
	@override String get nord => 'Nord';
	@override String get solarized => 'Solarized';
	@override String get monokai => 'Monokai';
	@override String get presetDefault => 'Par défaut';
	@override String get presetColorblind => 'Adapté aux daltoniens';
	@override String get presetHighContrast => 'Contraste élevé';
	@override String get presetNord => 'Nord';
	@override String get presetSolarized => 'Solarized';
	@override String get presetMonokai => 'Monokai';
}

// Path: settings.integrations.materials
class _TranslationsSettingsIntegrationsMaterialsFr implements TranslationsSettingsIntegrationsMaterialsEn {
	_TranslationsSettingsIntegrationsMaterialsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sidebar => 'Barre latérale';
	@override String get menu => 'Menu';
	@override String get popover => 'Fenêtre contextuelle';
	@override String get titlebar => 'Barre de titre';
	@override String get underPageBackground => 'Arrière-plan de la page';
	@override String get contentBackground => 'Contenu';
}

// Path: settings.integrations.fileTypes
class _TranslationsSettingsIntegrationsFileTypesFr implements TranslationsSettingsIntegrationsFileTypesEn {
	_TranslationsSettingsIntegrationsFileTypesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get loc => 'Fichier projet Localizer';
	@override String get lang => 'Fichier de langue';
	@override String get json => 'Fichier de localisation JSON';
	@override String get xml => 'Fichier de localisation XML';
}

// Path: settings.developer.themePlaygroundSection
class _TranslationsSettingsDeveloperThemePlaygroundSectionFr implements TranslationsSettingsDeveloperThemePlaygroundSectionEn {
	_TranslationsSettingsDeveloperThemePlaygroundSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get colors => 'Couleurs';
	@override String get typography => 'Typographie';
	@override late final _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteFr palette = _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteFr._(_root);
}

// Path: settings.developer.featureFlags
class _TranslationsSettingsDeveloperFeatureFlagsFr implements TranslationsSettingsDeveloperFeatureFlagsEn {
	_TranslationsSettingsDeveloperFeatureFlagsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fonctionnalités expérimentales';
	@override String get description => 'Activez les drapeaux de fonctionnalités localement pour les tests. Ces surcharges persistent après le redémarrage de l\'application.';
	@override String get subtitle => 'Surcharger les fonctionnalités expérimentales';
	@override late final _TranslationsSettingsDeveloperFeatureFlagsFlagsFr flags = _TranslationsSettingsDeveloperFeatureFlagsFlagsFr._(_root);
	@override String get reset => 'Réinitialiser tous les drapeaux';
	@override String get overrides => 'Surcharges locales';
	@override String get defaultVal => 'Par défaut';
	@override String get on => 'ACTIVÉ';
	@override String get off => 'DÉSACTIVÉ';
}

// Path: settings.developer.storageInspectorSection
class _TranslationsSettingsDeveloperStorageInspectorSectionFr implements TranslationsSettingsDeveloperStorageInspectorSectionEn {
	_TranslationsSettingsDeveloperStorageInspectorSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get refresh => 'Actualiser';
	@override String get hiveData => 'Données Hive';
	@override String get secureStorage => 'Stockage sécurisé';
}

// Path: settings.developer.deviceInfoSection
class _TranslationsSettingsDeveloperDeviceInfoSectionFr implements TranslationsSettingsDeveloperDeviceInfoSectionEn {
	_TranslationsSettingsDeveloperDeviceInfoSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get refresh => 'Actualiser';
	@override String get copy => 'Copier dans le presse-papiers';
	@override String get computerName => 'Nom de l\'ordinateur';
	@override String get osVersion => 'Version de l\'OS';
}

// Path: settings.developer.localizationInspectorSection
class _TranslationsSettingsDeveloperLocalizationInspectorSectionFr implements TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
	_TranslationsSettingsDeveloperLocalizationInspectorSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get showKeys => 'Afficher les clés au lieu des valeurs';
	@override String get keysVisible => 'Clés visibles';
	@override String get normalDisplay => 'Affichage normal';
	@override String get note => 'Note : Cette fonctionnalité nécessite que la localisation de l\'application utilise un wrapper qui respecte ce paramètre.';
}

// Path: settings.onboarding.steps
class _TranslationsSettingsOnboardingStepsFr implements TranslationsSettingsOnboardingStepsEn {
	_TranslationsSettingsOnboardingStepsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSettingsOnboardingStepsImportFilesFr importFiles = _TranslationsSettingsOnboardingStepsImportFilesFr._(_root);
	@override late final _TranslationsSettingsOnboardingStepsRunComparisonFr runComparison = _TranslationsSettingsOnboardingStepsRunComparisonFr._(_root);
	@override late final _TranslationsSettingsOnboardingStepsReviewMissingFr reviewMissing = _TranslationsSettingsOnboardingStepsReviewMissingFr._(_root);
	@override late final _TranslationsSettingsOnboardingStepsUseFiltersFr useFilters = _TranslationsSettingsOnboardingStepsUseFiltersFr._(_root);
	@override late final _TranslationsSettingsOnboardingStepsSearchResultsFr searchResults = _TranslationsSettingsOnboardingStepsSearchResultsFr._(_root);
	@override late final _TranslationsSettingsOnboardingStepsAdvancedViewFr advancedView = _TranslationsSettingsOnboardingStepsAdvancedViewFr._(_root);
	@override late final _TranslationsSettingsOnboardingStepsEditCellFr editCell = _TranslationsSettingsOnboardingStepsEditCellFr._(_root);
	@override late final _TranslationsSettingsOnboardingStepsExportResultsFr exportResults = _TranslationsSettingsOnboardingStepsExportResultsFr._(_root);
}

// Path: settings.settingsView.categories
class _TranslationsSettingsSettingsViewCategoriesFr implements TranslationsSettingsSettingsViewCategoriesEn {
	_TranslationsSettingsSettingsViewCategoriesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get general => 'Paramètres généraux';
	@override String get comparisonEngine => 'Moteur de comparaison';
	@override String get appearance => 'Apparence';
	@override String get fileHandling => 'Gestion des fichiers';
	@override String get aiServices => 'Services d\'IA';
	@override String get systemIntegrations => 'Intégrations système';
	@override String get projectResources => 'Ressources du projet (Glossaire & MT)';
	@override String get developer => 'Options développeur';
	@override String get about => 'À propos';
}

// Path: settings.settingsView.categoryLabels
class _TranslationsSettingsSettingsViewCategoryLabelsFr implements TranslationsSettingsSettingsViewCategoryLabelsEn {
	_TranslationsSettingsSettingsViewCategoryLabelsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get general => 'Général';
	@override String get comparisonEngine => 'Comparaison';
	@override String get appearance => 'Apparence';
	@override String get fileHandling => 'Gestion des fichiers';
	@override String get aiServices => 'Services d\'IA';
	@override String get systemIntegrations => 'Intégrations système';
	@override String get projectResources => 'Ressources du projet';
	@override String get developer => 'Options développeur';
	@override String get about => 'À propos';
}

// Path: advancedDiff.sidebar.actionsSection
class _TranslationsAdvancedDiffSidebarActionsSectionFr implements TranslationsAdvancedDiffSidebarActionsSectionEn {
	_TranslationsAdvancedDiffSidebarActionsSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get exportMatches => 'Exporter les correspondances';
	@override String get preview => 'Aperçu';
	@override String get fillFromTmTitle => 'Remplir depuis la mémoire de traduction ?';
	@override String get fillFromTmContent => 'Cela tentera de remplir les valeurs cibles vides à l\'aide des correspondances de la mémoire de traduction. Les valeurs existantes ne seront PAS écrasées.';
	@override String get fill => 'Remplir';
	@override String get fillFromMemory => 'Remplir depuis la mémoire';
	@override String filledFromTm({required Object count}) => '${count} éléments remplis depuis la mémoire de traduction.';
}

// Path: advancedDiff.sidebar.aiSection
class _TranslationsAdvancedDiffSidebarAiSectionFr implements TranslationsAdvancedDiffSidebarAiSectionEn {
	_TranslationsAdvancedDiffSidebarAiSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get infoCloud => 'Utilise la traduction Cloud pour traduire les valeurs cibles vides à partir de la source.';
	@override String get infoAi => 'Utilise l\'IA pour traduire les valeurs cibles vides à partir de la source.';
	@override String get translationSettings => 'Paramètres de traduction';
	@override String get aiSettings => 'Paramètres d\'IA';
	@override String get source => 'Source';
	@override String get target => 'Cible';
	@override String translatingProgress({required Object percent}) => 'Traduction... ${percent}%';
	@override String get translating => 'Traduction...';
	@override String get translateAllMissing => 'Traduire tout ce qui manque';
	@override String get translateAllTitle => 'Traduire tout ce qui manque ?';
	@override String translateAllContent({required Object service, required Object source, required Object target}) => 'Cela utilisera ${service} pour traduire toutes les entrées ayant des valeurs cibles vides de ${source} vers ${target}.\n\nVous pouvez réviser chaque suggestion ou tout appliquer d\'un coup.';
	@override String get translateAll => 'Tout traduire';
	@override String get reviewEach => 'Réviser chaque élément';
	@override String cloudTranslated({required Object count}) => '${count} entrées traduites avec la traduction Cloud.';
	@override String aiTranslated({required Object count}) => '${count} entrées traduites avec l\'IA.';
	@override String get aiTranslateFailed => 'L\'IA n\'a pas réussi à tout traduire';
	@override String get noMissingEntries => 'Aucune entrée manquante à traduire.';
	@override String get skip => 'Passer';
	@override String get stop => 'Arrêter';
	@override String cloudApplied({required Object count}) => '${count} suggestions appliquées.';
	@override String aiApplied({required Object count}) => '${count} suggestions d\'IA appliquées.';
}

// Path: advancedDiff.sidebar.tmSection
class _TranslationsAdvancedDiffSidebarTmSectionFr implements TranslationsAdvancedDiffSidebarTmSectionEn {
	_TranslationsAdvancedDiffSidebarTmSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get enableTmFill => 'Activer le remplissage par MT';
	@override String get autoApplyAboveMinimum => 'Appliquer automatiquement au-dessus du minimum';
	@override String get matchSettings => 'Paramètres de correspondance';
	@override String get minMatch => 'Corresp. min :';
	@override String get limit => 'Limite :';
	@override String get exact => 'Exact';
}

// Path: advancedDiff.sidebar.filtersSection
class _TranslationsAdvancedDiffSidebarFiltersSectionFr implements TranslationsAdvancedDiffSidebarFiltersSectionEn {
	_TranslationsAdvancedDiffSidebarFiltersSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get viewFilters => 'Filtres d\'affichage';
	@override String get showAll => 'Tout afficher';
	@override String get added => 'Ajouté';
	@override String get removed => 'Supprimé';
	@override String get modified => 'Modifié';
	@override String get actionScope => 'Portée de l\'action';
	@override String get applyToAdded => 'Appliquer aux ajoutés';
	@override String get applyToModified => 'Appliquer aux modifiés';
	@override String get onlyFillEmptyTargets => 'Remplir uniquement les cibles vides';
	@override String get limitToVisible => 'Limiter au visible';
	@override String get editMode => 'Mode d\'édition';
	@override String get dialog => 'Dialogue';
	@override String get inline => 'En ligne';
}

// Path: advancedDiff.sidebar.similaritySection
class _TranslationsAdvancedDiffSidebarSimilaritySectionFr implements TranslationsAdvancedDiffSidebarSimilaritySectionEn {
	_TranslationsAdvancedDiffSidebarSimilaritySectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get currentFilter => 'Filtre actuel :';
	@override String get any => 'TOUT';
	@override String get high => 'HAUT';
	@override String get medium => 'MOYEN';
	@override String get low => 'BAS';
}

// Path: advancedDiff.sidebar.statusSection
class _TranslationsAdvancedDiffSidebarStatusSectionFr implements TranslationsAdvancedDiffSidebarStatusSectionEn {
	_TranslationsAdvancedDiffSidebarStatusSectionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String total({required Object count}) => '${count} au total';
	@override String extra({required Object count}) => '${count} en surplus';
	@override String missing({required Object count}) => '${count} manquants';
	@override String changed({required Object count}) => '${count} modifiés';
}

// Path: tutorial.steps.importSource
class _TranslationsTutorialStepsImportSourceFr implements TranslationsTutorialStepsImportSourceEn {
	_TranslationsTutorialStepsImportSourceFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => '1. Importer le fichier source';
	@override String get description => 'Utilisez le bouton ci-dessous pour rechercher un fichier, ou glissez-le & déposez-le sur la zone mise en évidence.';
}

// Path: tutorial.steps.importTarget
class _TranslationsTutorialStepsImportTargetFr implements TranslationsTutorialStepsImportTargetEn {
	_TranslationsTutorialStepsImportTargetFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => '2. Importer le fichier cible';
	@override String get description => 'Utilisez le bouton ci-dessous pour rechercher un fichier, ou glissez-le & déposez-le sur la zone mise en évidence.';
}

// Path: tutorial.steps.compare
class _TranslationsTutorialStepsCompareFr implements TranslationsTutorialStepsCompareEn {
	_TranslationsTutorialStepsCompareFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => '3. Comparer les fichiers';
	@override String get description => 'Appuyez sur le bouton ci-dessous pour lancer la comparaison et voir les résultats.';
}

// Path: tutorial.steps.filter
class _TranslationsTutorialStepsFilterFr implements TranslationsTutorialStepsFilterEn {
	_TranslationsTutorialStepsFilterFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => '4. Filtrer les résultats';
	@override String get description => 'Utilisez ces filtres pour voir les chaînes ajoutées, supprimées ou modifiées.';
}

// Path: tutorial.steps.search
class _TranslationsTutorialStepsSearchFr implements TranslationsTutorialStepsSearchEn {
	_TranslationsTutorialStepsSearchFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => '5. Rechercher des résultats';
	@override String get description => 'Trouvez des clés ou des valeurs spécifiques à l\'aide de la barre de recherche.';
}

// Path: tutorial.steps.advanced
class _TranslationsTutorialStepsAdvancedFr implements TranslationsTutorialStepsAdvancedEn {
	_TranslationsTutorialStepsAdvancedFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => '6. Vue avancée';
	@override String get description => 'Ouvrez la vue détaillée du diff avec l\'édition, la traduction par IA, et plus encore.';
}

// Path: tutorial.steps.export
class _TranslationsTutorialStepsExportFr implements TranslationsTutorialStepsExportEn {
	_TranslationsTutorialStepsExportFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => '7. Exporter les résultats';
	@override String get description => 'Sauvegardez votre comparaison au format CSV, JSON ou Excel.';
}

// Path: settings.developer.themePlaygroundSection.palette
class _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteFr implements TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
	_TranslationsSettingsDeveloperThemePlaygroundSectionPaletteFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get primary => 'Primaire';
	@override String get onPrimary => 'Sur Primaire';
	@override String get secondary => 'Secondaire';
	@override String get onSecondary => 'Sur Secondaire';
	@override String get surface => 'Surface';
	@override String get onSurface => 'Sur Surface';
	@override String get error => 'Erreur';
	@override String get onError => 'Sur Erreur';
	@override String get outline => 'Contour';
	@override String get shadow => 'Ombre';
	@override String get success => 'Succès';
	@override String get warning => 'Avertissement';
	@override String get info => 'Info';
}

// Path: settings.developer.featureFlags.flags
class _TranslationsSettingsDeveloperFeatureFlagsFlagsFr implements TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
	_TranslationsSettingsDeveloperFeatureFlagsFlagsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchFr experimental_ai_batch = _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchFr._(_root);
	@override late final _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmFr new_diff_algorithm = _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmFr._(_root);
	@override late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchFr enhanced_search = _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchFr._(_root);
	@override late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveFr auto_save = _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveFr._(_root);
}

// Path: settings.onboarding.steps.importFiles
class _TranslationsSettingsOnboardingStepsImportFilesFr implements TranslationsSettingsOnboardingStepsImportFilesEn {
	_TranslationsSettingsOnboardingStepsImportFilesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Importer des fichiers';
	@override String get description => 'Charger les fichiers source et cible';
}

// Path: settings.onboarding.steps.runComparison
class _TranslationsSettingsOnboardingStepsRunComparisonFr implements TranslationsSettingsOnboardingStepsRunComparisonEn {
	_TranslationsSettingsOnboardingStepsRunComparisonFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lancer la comparaison';
	@override String get description => 'Cliquez sur "Comparer les fichiers"';
}

// Path: settings.onboarding.steps.reviewMissing
class _TranslationsSettingsOnboardingStepsReviewMissingFr implements TranslationsSettingsOnboardingStepsReviewMissingEn {
	_TranslationsSettingsOnboardingStepsReviewMissingFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Réviser les clés manquantes';
	@override String get description => 'Notez les éléments manquants en rouge';
}

// Path: settings.onboarding.steps.useFilters
class _TranslationsSettingsOnboardingStepsUseFiltersFr implements TranslationsSettingsOnboardingStepsUseFiltersEn {
	_TranslationsSettingsOnboardingStepsUseFiltersFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Utiliser les filtres';
	@override String get description => 'Filtrer par type';
}

// Path: settings.onboarding.steps.searchResults
class _TranslationsSettingsOnboardingStepsSearchResultsFr implements TranslationsSettingsOnboardingStepsSearchResultsEn {
	_TranslationsSettingsOnboardingStepsSearchResultsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Résultats de recherche';
	@override String get description => 'Trouver des clés spécifiques';
}

// Path: settings.onboarding.steps.advancedView
class _TranslationsSettingsOnboardingStepsAdvancedViewFr implements TranslationsSettingsOnboardingStepsAdvancedViewEn {
	_TranslationsSettingsOnboardingStepsAdvancedViewFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vue avancée';
	@override String get description => 'Explorer l\'analyse détaillée';
}

// Path: settings.onboarding.steps.editCell
class _TranslationsSettingsOnboardingStepsEditCellFr implements TranslationsSettingsOnboardingStepsEditCellEn {
	_TranslationsSettingsOnboardingStepsEditCellFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Modifier une cellule';
	@override String get description => 'Cliquez pour modifier une valeur';
}

// Path: settings.onboarding.steps.exportResults
class _TranslationsSettingsOnboardingStepsExportResultsFr implements TranslationsSettingsOnboardingStepsExportResultsEn {
	_TranslationsSettingsOnboardingStepsExportResultsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exporter';
	@override String get description => 'Sauvegarder votre rapport';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchFr implements TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
	_TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Lot d\'IA expérimental';
	@override String get description => 'Activer la traduction par lot par IA pour plusieurs lignes';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmFr implements TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
	_TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nouvel algorithme de diff';
	@override String get description => 'Utiliser un algorithme de diff amélioré pour les comparaisons';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchFr implements TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
	_TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Recherche améliorée';
	@override String get description => 'Activer la recherche floue dans les fichiers de traduction';
}

// Path: settings.developer.featureFlags.flags.auto_save
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveFr implements TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
	_TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Sauvegarde automatique';
	@override String get description => 'Sauvegarder automatiquement les modifications après l\'édition';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'Outil de Comparaison de Localisation',
			'app.name' => 'Localizer',
			'common.save' => 'Sauvegarder',
			'common.cancel' => 'Annuler',
			'common.close' => 'Fermer',
			'common.delete' => 'Supprimer',
			'common.edit' => 'Modifier',
			'common.add' => 'Ajouter',
			'common.search' => 'Chercher',
			'common.undo' => 'Annuler',
			'common.loading' => 'Chargement...',
			'common.error' => 'Erreur',
			'common.success' => 'Succès',
			'common.warning' => 'Avertissement',
			'common.info' => 'Info',
			'common.confirm' => 'Confirmer',
			'common.yes' => 'Oui',
			'common.no' => 'Non',
			'common.ok' => 'OK',
			'common.retry' => 'Réessayer',
			'common.copyText' => 'Copier',
			'common.appName' => 'Localizer',
			'common.copied' => 'Copié !',
			'common.enabled' => 'Activé',
			'common.disabled' => 'Désactivé',
			'common.browse' => 'Parcourir',
			'common.clear' => 'Effacer',
			'common.apply' => 'Appliquer',
			'common.reset' => 'Réinitialiser',
			'common.refresh' => 'Actualiser',
			'common.export' => 'Exporter',
			'common.import' => 'Importer',
			'common.select' => 'Sélectionner',
			'common.selectAll' => 'Tout sélectionner',
			'common.deselectAll' => 'Tout désélectionner',
			'common.noResults' => 'Aucun résultat trouvé',
			'common.emptyState' => 'Rien ici pour le moment',
			'common.open' => 'Ouvrir',
			'common.change' => 'Changer',
			'common.original' => 'Original',
			'common.kNew' => 'Nouveau',
			'common.remove' => 'Supprimer',
			'common.auto' => 'Auto',
			'common.execute' => 'Exécuter',
			'common.run' => 'Exécuter',
			'common.unknown' => 'Inconnu',
			'common.download' => 'Télécharger',
			'common.dropdownArrow' => 'Flèche de liste déroulante',
			'common.openInNewWindow' => 'S\'ouvre dans une nouvelle fenêtre',
			'common.resetToDefaults' => 'Réinitialiser les paramètres par défaut',
			'menu.file' => 'Fichier',
			'menu.edit' => 'Édition',
			'menu.view' => 'Affichage',
			'menu.help' => 'Aide',
			'menu.openFiles' => 'Ouvrir les fichiers...',
			'menu.openFolder' => 'Ouvrir le dossier...',
			'menu.exportResults' => 'Exporter les résultats...',
			'menu.undo' => 'Annuler',
			'menu.redo' => 'Rétablir',
			'menu.cut' => 'Couper',
			'menu.paste' => 'Coller',
			'menu.selectAll' => 'Tout sélectionner',
			'menu.zoomIn' => 'Zoom avant',
			'menu.zoomOut' => 'Zoom arrière',
			'menu.resetZoom' => 'Réinitialiser le zoom',
			'menu.documentation' => 'Documentation',
			'menu.reportIssue' => 'Signaler un problème',
			'menu.about' => ({required Object appName}) => 'À propos de ${appName}',
			'nav.compare' => 'Comparer',
			'nav.history' => 'Historique',
			'nav.settings' => 'Paramètres',
			'nav.projects' => 'Projets',
			'nav.dashboard' => 'Tableau de bord',
			'nav.directory' => 'Dossier',
			'nav.repository' => 'Dépôt',
			'nav.tooltipCompare' => 'Comparer les fichiers de localisation',
			'nav.tooltipHistory' => 'Voir l\'historique des comparaisons',
			'nav.tooltipSettings' => 'Paramètres de l\'application',
			'nav.tooltipProjects' => 'Gérer les projets',
			'nav.tooltipThemeToggle' => 'Changer de thème',
			'nav.tooltipDebugConsole' => 'Console de débogage',
			'settings.title' => 'Paramètres',
			'settings.appSettings' => 'Paramètres de l\'application',
			'settings.projectSettings' => 'Paramètres du projet',
			'settings.appearance.title' => 'Apparence',
			'settings.appearance.description' => 'Personnaliser l\'apparence de l\'application',
			'settings.appearance.theme' => 'Mode de thème',
			'settings.appearance.themeDescription' => 'Choisissez entre le thème clair, sombre ou système',
			'settings.appearance.themeSystem' => 'Système',
			'settings.appearance.themeLight' => 'Clair',
			'settings.appearance.themeDark' => 'Sombre',
			'settings.appearance.themeAmoled' => 'AMOLED',
			'settings.appearance.accentColor' => 'Couleur d\'accentuation',
			'settings.appearance.accentColorDescription' => 'Choisissez votre couleur d\'accentuation préférée',
			'settings.appearance.useMicaEffect' => 'Utiliser l\'effet Mica',
			'settings.appearance.micaDescription' => 'Activer l\'effet de transparence Mica de Windows 11 pour un look moderne',
			'settings.appearance.diffFontSize' => 'Taille de police du diff',
			'settings.appearance.diffFontSizeDescription' => 'Ajuster la taille de la police de la vue de comparaison',
			'settings.appearance.diffFontFamily' => 'Famille de police du diff',
			'settings.appearance.diffFontFamilyDescription' => 'Police pour la vue de comparaison',
			'settings.appearance.systemDefault' => 'Défaut système',
			'settings.appearance.pickAccentColor' => 'Choisir la couleur d\'accentuation',
			'settings.appearance.diffColors' => 'Couleurs du diff',
			'settings.appearance.presetsTitle' => 'Préréglages',
			'settings.appearance.presets.presetDefault' => 'Par défaut',
			'settings.appearance.presets.presetColorblind' => 'Adapté aux daltoniens',
			'settings.appearance.presets.presetHighContrast' => 'Contraste élevé',
			'settings.appearance.presets.presetNord' => 'Nord',
			'settings.appearance.presets.presetSolarized' => 'Solarized',
			'settings.appearance.presets.presetMonokai' => 'Monokai',
			'settings.appearance.identical' => 'Identique',
			'settings.appearance.pickColorFor' => ({required Object label}) => 'Choisir la couleur pour ${label}',
			'settings.appearance.livePreview' => 'Aperçu en direct',
			'settings.appearance.preview.step3Title' => 'onboarding.step3.title',
			'settings.appearance.preview.connectAccount' => '"Connectez votre compte"',
			'settings.appearance.preview.loginHint' => 'deprecated.login_hint_v1',
			'settings.appearance.preview.enterCredentials' => '"Entrez vos identifiants"',
			'settings.appearance.preview.ctaButton' => 'checkout.cta_button',
			'settings.appearance.preview.buyNow' => '"Acheter maintenant"',
			'settings.appearance.preview.completePurchase' => '"Finaliser l\'achat"',
			'settings.appearance.preview.appNameKey' => 'common.app_name',
			'settings.appearance.preview.appNameValue' => '"Localizer"',
			'settings.general.title' => 'Général',
			'settings.general.description' => 'Paramètres généraux de l\'application',
			'settings.general.language' => 'Langue',
			'settings.general.languageDescription' => 'Choisissez votre langue préférée',
			'settings.general.startMinimized' => 'Démarrer réduit dans la zone de notification',
			'settings.general.startMinimizedDescription' => 'Démarrer l\'application réduite dans la barre d\'état système',
			'settings.general.rememberWindowPosition' => 'Mémoriser la position de la fenêtre',
			'settings.general.rememberWindowPositionDescription' => 'Restaurer la taille et la position de la fenêtre au démarrage',
			'settings.general.openLastProject' => 'Ouvrir le dernier projet au démarrage',
			'settings.general.openLastProjectDescription' => 'Ouvrir automatiquement le dernier projet utilisé au démarrage',
			'settings.general.application' => 'Application',
			'settings.general.defaultView' => 'Vue par défaut',
			'settings.general.defaultViewDescription' => 'Vue à afficher au démarrage',
			'settings.general.autoCheckUpdates' => 'Vérification automatique des mises à jour',
			'settings.general.autoCheckUpdatesDescription' => 'Vérifier les mises à jour au démarrage',
			'settings.general.startupOptions' => 'Options de démarrage',
			'settings.general.languageAuto' => 'Détection automatique',
			'settings.general.viewBasic' => 'Comparaison de fichiers',
			'settings.general.viewHistory' => 'Historique',
			'settings.general.viewDashboard' => 'Tableau de bord qualité',
			'settings.general.viewDirectory' => 'Comparaison de dossiers',
			'settings.general.viewLastUsed' => 'Dernière vue utilisée',
			'settings.scope.title' => 'Portée des paramètres',
			'settings.scope.global' => 'Par défaut globaux',
			'settings.scope.project' => 'Projet',
			'settings.scope.reset' => 'Réinitialiser le projet aux paramètres globaux',
			'settings.scope.resetConfirmation' => 'Cela effacera toutes les surcharges pour ce projet et reviendra aux paramètres par défaut globaux. Cette action est irréversible.',
			'settings.scope.globalDescription' => 'Les modifications s\'appliquent à tous les projets, sauf indication contraire.',
			'settings.scope.projectDescription' => ({required Object name}) => 'Les modifications s\'appliquent uniquement à "${name}". Les autres paramètres héritent des valeurs globales par défaut.',
			'settings.scope.createPrompt' => 'Créer un projet pour personnaliser les paramètres de dossiers spécifiques',
			'settings.searchKeywords.general.0' => 'Langue',
			'settings.searchKeywords.general.1' => 'Vue par défaut',
			'settings.searchKeywords.general.2' => 'Nombre de fichiers récents',
			'settings.searchKeywords.general.3' => 'Ouvrir le dernier projet',
			'settings.searchKeywords.general.4' => 'Confirmer avant de quitter',
			'settings.searchKeywords.general.5' => 'Afficher les notifications',
			'settings.searchKeywords.comparisonEngine.0' => 'Mode de comparaison',
			'settings.searchKeywords.comparisonEngine.1' => 'Seuil de similitude',
			'settings.searchKeywords.comparisonEngine.2' => 'Sensible à la casse',
			'settings.searchKeywords.comparisonEngine.3' => 'Ignorer les espaces',
			'settings.searchKeywords.comparisonEngine.4' => 'Ignorer les lignes vides',
			'settings.searchKeywords.comparisonEngine.5' => 'Ignorer les commentaires',
			'settings.searchKeywords.comparisonEngine.6' => 'Ignorer les motifs',
			'settings.searchKeywords.appearance.0' => 'Thème',
			'settings.searchKeywords.appearance.1' => 'Mode de thème',
			'settings.searchKeywords.appearance.2' => 'Couleur d\'accentuation',
			'settings.searchKeywords.appearance.3' => 'Taille de police du diff',
			'settings.searchKeywords.appearance.4' => 'Famille de police du diff',
			'settings.searchKeywords.appearance.5' => 'Couleurs du diff',
			'settings.searchKeywords.appearance.6' => 'Couleur d\'ajout',
			'settings.searchKeywords.appearance.7' => 'Couleur de suppression',
			'settings.searchKeywords.appearance.8' => 'Couleur de modification',
			'settings.searchKeywords.appearance.9' => 'Couleur identique',
			'settings.searchKeywords.appearance.10' => 'Préréglages de couleurs',
			'settings.searchKeywords.appearance.11' => 'Aperçu',
			'settings.searchKeywords.fileHandling.0' => 'Format source',
			'settings.searchKeywords.fileHandling.1' => 'Format cible',
			'settings.searchKeywords.fileHandling.2' => 'Encodage par défaut',
			'settings.searchKeywords.fileHandling.3' => 'Nombre de projets récents',
			'settings.searchKeywords.fileHandling.4' => 'Mémoire de traduction',
			'settings.searchKeywords.fileHandling.5' => 'Importer la mémoire',
			'settings.searchKeywords.fileHandling.6' => 'Exporter la mémoire',
			'settings.searchKeywords.fileHandling.7' => 'Effacer la mémoire',
			'settings.searchKeywords.aiServices.0' => 'Clé API OpenAI',
			'settings.searchKeywords.aiServices.1' => 'Clé API Anthropic',
			'settings.searchKeywords.aiServices.2' => 'Clé API Google AI',
			'settings.searchKeywords.aiServices.3' => 'Modèle AI',
			'settings.searchKeywords.aiServices.4' => 'Température',
			'settings.searchKeywords.aiServices.5' => 'Invite personnalisée',
			'settings.searchKeywords.systemIntegrations.0' => 'Zone de notification',
			'settings.searchKeywords.systemIntegrations.1' => 'Démarrer réduit',
			'settings.searchKeywords.systemIntegrations.2' => 'Associations de fichiers',
			'settings.searchKeywords.systemIntegrations.3' => 'Effet Mica',
			'settings.searchKeywords.systemIntegrations.4' => 'Vibrance',
			'settings.searchKeywords.systemIntegrations.5' => 'Matériau de la fenêtre',
			'settings.searchKeywords.systemIntegrations.6' => 'Badge du dock',
			'settings.searchKeywords.systemIntegrations.7' => 'Nombre de chaînes non traduites',
			'settings.searchKeywords.projectResources.0' => 'Glossaire',
			'settings.searchKeywords.projectResources.1' => 'Mémoire de traduction',
			'settings.searchKeywords.projectResources.2' => 'Terminologie',
			'settings.searchKeywords.about.0' => 'Version',
			'settings.searchKeywords.about.1' => 'Vérifier les mises à jour',
			'settings.searchKeywords.about.2' => 'Mise à jour automatique',
			'settings.searchKeywords.about.3' => 'Journal des modifications',
			'settings.searchKeywords.about.4' => 'Licence',
			'settings.searchKeywords.about.5' => 'Politique de confidentialité',
			'settings.searchKeywords.about.6' => 'Télémétrie',
			'settings.searchKeywords.about.7' => 'Rapports de plantage',
			'settings.searchKeywords.developer.0' => 'Superposition de performance',
			'settings.searchKeywords.developer.1' => 'Débogueur de sémantique',
			'settings.searchKeywords.developer.2' => 'Grille Material',
			'settings.searchKeywords.developer.3' => 'Cache de rastérisation',
			'settings.searchKeywords.developer.4' => 'Redémarrer le tutoriel',
			'settings.searchKeywords.developer.5' => 'Réinitialisation d\'usine',
			'settings.comparison.title' => 'Comparaison',
			'settings.comparison.description' => 'Configurer le comportement de comparaison',
			'settings.comparison.caseSensitive' => 'Sensible à la casse',
			'settings.comparison.caseSensitiveDescription' => 'Traiter les majuscules et les minuscules comme différentes',
			'settings.comparison.ignoreWhitespace' => 'Ignorer les espaces',
			'settings.comparison.ignoreWhitespaceDescription' => 'Ignorer les espaces au début/à la fin lors de la comparaison',
			'settings.comparison.showLineNumbers' => 'Afficher les numéros de ligne',
			'settings.comparison.showLineNumbersDescription' => 'Afficher les numéros de ligne dans la vue diff',
			'settings.comparison.behavior' => 'Comportement de comparaison',
			'settings.comparison.ignoreCase' => 'Ignorer la casse',
			'settings.comparison.ignoreCaseDescription' => 'Traiter "Clé" et "clé" comme identiques',
			'settings.comparison.similarityThreshold' => 'Seuil de similitude',
			'settings.comparison.similarityThresholdDescription' => 'Similitude minimale pour la détection des modifications',
			'settings.comparison.mode' => 'Mode de comparaison',
			'settings.comparison.modeDescription' => 'Comment faire correspondre les entrées entre les fichiers',
			'settings.comparison.modeKey' => 'Basé sur les clés',
			'settings.comparison.modeKeyDescription' => 'Correspondance par nom de clé (par défaut).',
			'settings.comparison.modeOrder' => 'Basé sur l\'ordre',
			'settings.comparison.modeOrderDescription' => 'Correspondance par position dans le fichier.',
			'settings.comparison.modeSmart' => 'Correspondance intelligente',
			'settings.comparison.modeSmartDescription' => 'Détecte les clés déplacées/renommées.',
			'settings.comparison.ignorePatterns' => 'Motifs à ignorer',
			'settings.comparison.noIgnorePatterns' => 'Aucun motif à ignorer défini.',
			'settings.comparison.addPattern' => 'Ajouter un motif',
			'settings.comparison.resetToGlobal' => 'Réinitialiser tous les paramètres de comparaison aux valeurs par défaut globales',
			'settings.comparison.patternPresets.comments' => 'Commentaires',
			'settings.comparison.patternPresets.tempKeys' => 'Clés temporaires',
			'settings.comparison.patternPresets.placeholders' => 'Espaces réservés',
			'settings.comparison.patternPresets.devOnly' => 'Dév uniquement',
			'settings.comparison.previewMatch.title' => 'Aperçu de correspondance',
			'settings.comparison.previewMatch.description' => 'Testez comment vos paramètres actuels affectent la logique de correspondance.',
			'settings.comparison.previewMatch.stringA' => 'Chaîne A',
			'settings.comparison.previewMatch.stringB' => 'Chaîne B',
			'settings.comparison.previewMatch.enterText' => 'Entrez du texte...',
			'settings.comparison.previewMatch.similarity' => 'Similitude',
			'settings.comparison.previewMatch.identical' => 'Identique',
			'settings.comparison.previewMatch.identicalDescription' => 'Les chaînes correspondent exactement après normalisation.',
			'settings.comparison.previewMatch.ignored' => 'Ignoré',
			'settings.comparison.previewMatch.ignoredDescription' => 'L\'entrée correspond à un motif à ignorer.',
			'settings.comparison.previewMatch.different' => 'Différent',
			'settings.comparison.previewMatch.differentDescription' => 'Une valeur est vide.',
			'settings.comparison.previewMatch.similarModified' => 'Similaire / Modifié',
			'settings.comparison.previewMatch.similarModifiedDescription' => ({required Object threshold}) => 'Le score de correspondance est supérieur au seuil (${threshold}%).',
			'settings.comparison.previewMatch.newDifferent' => 'Nouveau / Différent',
			'settings.comparison.previewMatch.newDifferentDescription' => ({required Object threshold}) => 'Le score de correspondance est inférieur au seuil (${threshold}%).',
			'settings.comparison.colorPresets.kDefault' => 'Par défaut',
			'settings.comparison.colorPresets.colorblindFriendly' => 'Adapté aux daltoniens',
			'settings.comparison.colorPresets.highContrast' => 'Contraste élevé',
			'settings.comparison.colorPresets.nord' => 'Nord',
			'settings.comparison.colorPresets.solarized' => 'Solarized',
			'settings.comparison.colorPresets.monokai' => 'Monokai',
			'settings.comparison.colorPresets.presetDefault' => 'Par défaut',
			'settings.comparison.colorPresets.presetColorblind' => 'Adapté aux daltoniens',
			'settings.comparison.colorPresets.presetHighContrast' => 'Contraste élevé',
			'settings.comparison.colorPresets.presetNord' => 'Nord',
			'settings.comparison.colorPresets.presetSolarized' => 'Solarized',
			'settings.comparison.colorPresets.presetMonokai' => 'Monokai',
			'settings.fileHandling.fileFormats' => 'Formats de fichiers',
			'settings.fileHandling.sourceFormat' => 'Format source',
			'settings.fileHandling.targetFormat' => 'Format cible',
			'settings.fileHandling.encoding' => 'Encodage',
			'settings.fileHandling.sourceEncoding' => 'Encodage source',
			'settings.fileHandling.targetEncoding' => 'Encodage cible',
			'settings.fileHandling.autoDetect' => 'Détection automatique',
			'settings.fileHandling.autoDetectEncodingDescription' => 'Détecter automatiquement l\'encodage du fichier',
			'settings.fileHandling.exportSettings' => 'Paramètres d\'exportation',
			'settings.fileHandling.defaultExportFormat' => 'Format d\'exportation par défaut',
			'settings.fileHandling.includeUtf8Bom' => 'Inclure le BOM UTF-8',
			'settings.fileHandling.includeUtf8BomDescription' => 'Requis pour la compatibilité avec Excel',
			'settings.fileHandling.openFolderAfterExport' => 'Ouvrir le dossier après l\'exportation',
			'settings.fileHandling.fileSafety' => 'Sécurité des fichiers',
			'settings.fileHandling.fileSafetyDescription' => 'Copies locales automatiques pour la récupération après sinistre.',
			'settings.fileHandling.resetToGlobal' => 'Réinitialiser tous les paramètres de gestion des fichiers aux valeurs par défaut globales',
			'settings.translationMemory.title' => 'Mémoire de traduction globale',
			'settings.translationMemory.autoLearn' => 'Apprentissage automatique',
			'settings.translationMemory.autoLearnDescription' => 'Enregistrer les traductions dans la mémoire locale pour une réutilisation future',
			'settings.translationMemory.confidenceThreshold' => 'Seuil de confiance',
			'settings.translationMemory.confidenceThresholdDescription' => ({required Object percent}) => 'Score minimal pour l\'application automatique (${percent}%)',
			'settings.translationMemory.entries' => 'Entrées',
			'settings.translationMemory.size' => 'Taille',
			'settings.translationMemory.memorySize' => ({required Object size}) => 'Taille de la mémoire : ${size}',
			'settings.translationMemory.import' => 'Importer',
			'settings.translationMemory.exportTmx' => 'Exporter en TMX',
			'settings.translationMemory.exportCsv' => 'Exporter en CSV',
			'settings.translationMemory.clearMemory' => 'Effacer la mémoire',
			'settings.translationMemory.importedItems' => ({required Object count}) => '${count} éléments importés dans la mémoire.',
			'settings.translationMemory.noItemsAdded' => 'Aucun élément n\'a été ajouté.',
			'settings.translationMemory.nothingToExport' => 'Rien à exporter pour le moment.',
			'settings.translationMemory.tmxSaved' => 'TMX sauvegardé',
			'settings.translationMemory.csvSaved' => 'CSV sauvegardé',
			'settings.translationMemory.clearConfirmTitle' => 'Effacer la mémoire de traduction ?',
			'settings.translationMemory.clearConfirmContent' => 'Cela supprimera toutes les paires de traduction enregistrées sur cet appareil. Cette action est irréversible.',
			'settings.translationMemory.cleared' => 'Mémoire de traduction effacée.',
			'settings.translationMemory.couldNotClear' => 'Impossible d\'effacer la mémoire.',
			'settings.backup.title' => 'Sauvegarde automatique',
			'settings.backup.description' => 'Paramètres de sauvegarde automatique',
			'settings.backup.enabled' => 'Activer la sauvegarde automatique',
			'settings.backup.enabledDescription' => 'Sauvegarder automatiquement les fichiers avant d\'apporter des modifications',
			'settings.backup.maxCopies' => 'Nombre maximal de copies de sauvegarde',
			'settings.backup.maxCopiesDescription' => 'Nombre de copies de sauvegarde à conserver par fichier',
			'settings.backup.activeStatus' => ({required Object count}) => 'Actif · Conservation de ${count} copies',
			'settings.backup.folder' => 'Dossier de sauvegarde',
			'settings.backup.folderDescription' => 'Laissez vide pour utiliser le même dossier',
			'settings.backup.useOriginalFolder' => 'Utiliser le dossier d\'origine du fichier',
			'settings.ai.title' => 'Services d\'IA',
			'settings.ai.description' => 'Configurer la traduction et l\'assistance par IA',
			'settings.ai.provider' => 'Fournisseur d\'IA',
			'settings.ai.providerDescription' => 'Choisissez votre fournisseur de services d\'IA préféré',
			'settings.ai.apiKey' => 'Clé API',
			'settings.ai.apiKeyDescription' => 'Entrez votre clé API pour le fournisseur sélectionné',
			'settings.ai.apiKeyPlaceholder' => 'Entrez la clé API...',
			'settings.ai.testConnection' => 'Tester la connexion',
			'settings.ai.connectionSuccess' => 'Connexion réussie !',
			'settings.ai.connectionFailed' => 'Échec de la connexion. Veuillez vérifier votre clé API.',
			'settings.ai.translationStrategy' => 'Stratégie de traduction',
			'settings.ai.strategy' => 'Stratégie',
			'settings.ai.strategyDescription' => 'Sélectionnez comment vous souhaitez traduire les chaînes',
			'settings.ai.strategyLLM' => 'IA générative (LLM)',
			'settings.ai.strategyCloud' => 'Traduction Cloud',
			'settings.ai.enableAiTranslation' => 'Activer la traduction par IA',
			'settings.ai.enableAiTranslationDescription' => 'Autoriser l\'application à utiliser l\'IA pour les suggestions de traduction',
			'settings.ai.llmProvider' => 'Fournisseur de service LLM',
			'settings.ai.service' => 'Service',
			'settings.ai.serviceDescription' => 'Fournisseur pour l\'IA générative',
			'settings.ai.providerGemini' => 'Google Gemini',
			'settings.ai.providerOpenAI' => 'OpenAI',
			'settings.ai.geminiApiKey' => 'Clé API Gemini',
			'settings.ai.openAiApiKey' => 'Clé API OpenAI',
			'settings.ai.model' => 'Modèle',
			'settings.ai.modelDescription' => 'Sélectionnez le modèle à utiliser',
			'settings.ai.advancedParameters' => 'Paramètres avancés',
			'settings.ai.parameters' => 'Paramètres',
			'settings.ai.parametersDescription' => 'Température, Contexte, et plus',
			'settings.ai.temperature' => 'Température',
			'settings.ai.temperatureDescription' => 'Des valeurs plus élevées rendent la sortie plus créative',
			'settings.ai.maxTokens' => 'Max Tokens',
			'settings.ai.maxTokensDescription' => 'Limiter la longueur de la fenêtre de contexte',
			'settings.ai.systemContext' => 'Contexte système / Instructions',
			'settings.ai.systemContextHint' => 'Vous êtes un localisateur professionnel. Maintenez le ton et l\'intention de la chaîne source...',
			'settings.ai.systemContextHelper' => 'Fournissez des instructions spécifiques à l\'IA sur le style et la terminologie de votre projet.',
			'settings.ai.contextStrings' => 'Chaînes de contexte',
			'settings.ai.contextStringsDescription' => 'Inclure les chaînes environnantes pour un meilleur contexte',
			'settings.ai.contextCount' => 'Nombre de contextes',
			'settings.ai.contextCountDescription' => 'Nombre de chaînes environnantes à inclure',
			'settings.ai.cloudServices' => 'Services de traduction Cloud',
			'settings.ai.googleTranslateApiKey' => 'Clé API Google Translate',
			'settings.ai.deeplApiKey' => 'Clé API DeepL',
			'settings.ai.test' => 'Tester',
			'settings.ai.resetToGlobal' => 'Réinitialiser tous les paramètres d\'IA aux valeurs par défaut globales',
			'settings.integrations.platformNotice' => 'Avis de plateforme',
			'settings.integrations.platformNoticeDescription' => 'Les intégrations système ne sont pas disponibles pour cette plateforme.',
			'settings.integrations.visualEffects' => 'Effets visuels',
			'settings.integrations.explorerIntegration' => 'Intégration de l\'explorateur',
			'settings.integrations.explorerIntegrationDescription' => 'Ajouter "Ouvrir avec Localizer" au menu contextuel de l\'Explorateur Windows pour les dossiers.',
			'settings.integrations.addToContextMenu' => 'Ajouter au menu contextuel',
			'settings.integrations.contextMenuAdded' => 'Menu contextuel ajouté !',
			'settings.integrations.contextMenuAddError' => 'Échec de l\'ajout du menu contextuel',
			'settings.integrations.contextMenuRemoved' => 'Menu contextuel supprimé !',
			'settings.integrations.contextMenuRemoveError' => 'Échec de la suppression du menu contextuel',
			'settings.integrations.fileAssociations' => 'Associations de fichiers',
			'settings.integrations.fileAssociationsDescription' => 'Enregistrer les types de fichiers pour les ouvrir avec Localizer lors d\'un double-clic dans l\'Explorateur.',
			'settings.integrations.registered' => 'Enregistré',
			'settings.integrations.notRegistered' => 'Non enregistré',
			'settings.integrations.extRegistered' => ({required Object ext}) => '${ext} enregistré !',
			'settings.integrations.extUnregistered' => ({required Object ext}) => '${ext} désenregistré !',
			'settings.integrations.extError' => ({required Object action, required Object ext}) => 'Échec de ${action} ${ext}',
			'settings.integrations.registerAll' => 'Tout enregistrer',
			'settings.integrations.unregisterAll' => 'Tout désenregistrer',
			'settings.integrations.registerAllResult' => ({required Object success, required Object total}) => 'Enregistré ${success} sur ${total} types de fichiers',
			'settings.integrations.unregisterAllResult' => ({required Object success, required Object total}) => 'Désenregistré ${success} sur ${total} types de fichiers',
			'settings.integrations.protocolHandler' => 'Gestionnaire de protocole',
			'settings.integrations.protocolHandlerDescription' => 'Enregistrer les URL localizer:// pour ouvrir cette application. Permet d\'ouvrir des projets directement depuis des liens de navigateur ou d\'autres applications.',
			'settings.integrations.protocolRegistered' => 'Le gestionnaire de protocole est enregistré',
			'settings.integrations.protocolNotRegistered' => 'Le gestionnaire de protocole n\'est pas enregistré',
			'settings.integrations.registerProtocol' => 'Enregistrer le protocole',
			'settings.integrations.unregister' => 'Désenregistrer',
			'settings.integrations.protocolRegisteredSuccess' => 'Gestionnaire de protocole enregistré !',
			'settings.integrations.protocolRemovedSuccess' => 'Gestionnaire de protocole supprimé !',
			'settings.integrations.protocolRegisterError' => 'Échec de l\'enregistrement',
			'settings.integrations.protocolRemoveError' => 'Échec de la suppression',
			'settings.integrations.windowMaterial' => 'Matériau de la fenêtre',
			'settings.integrations.windowMaterialDescription' => 'Sélectionnez le style de matériau de vibrance macOS',
			'settings.integrations.dockIntegration' => 'Intégration du Dock',
			'settings.integrations.showDockBadge' => 'Afficher le nombre de non traduits',
			'settings.integrations.showDockBadgeDescription' => 'Afficher le nombre de chaînes non traduites sur le badge de l\'icône du dock',
			'settings.integrations.materials.sidebar' => 'Barre latérale',
			'settings.integrations.materials.menu' => 'Menu',
			'settings.integrations.materials.popover' => 'Fenêtre contextuelle',
			'settings.integrations.materials.titlebar' => 'Barre de titre',
			'settings.integrations.materials.underPageBackground' => 'Arrière-plan de la page',
			'settings.integrations.materials.contentBackground' => 'Contenu',
			'settings.integrations.fileTypes.loc' => 'Fichier projet Localizer',
			'settings.integrations.fileTypes.lang' => 'Fichier de langue',
			'settings.integrations.fileTypes.json' => 'Fichier de localisation JSON',
			'settings.integrations.fileTypes.xml' => 'Fichier de localisation XML',
			'settings.developer.title' => 'Paramètres développeur',
			'settings.developer.description' => 'Paramètres avancés pour les développeurs',
			'settings.developer.showLocalizationKeys' => 'Afficher les clés de localisation',
			'settings.developer.localizationKeysDescription' => 'Une fois activé, tout le texte traduit affichera ses clés de localisation au lieu de la valeur traduite. Utile pour vérifier quelle clé est utilisée où.',
			'settings.developer.showPerformanceOverlay' => 'Afficher la superposition de performance',
			'settings.developer.performanceOverlayDescription' => 'Afficher les FPS et les informations sur le timing des images',
			'settings.developer.debugMode' => 'Mode de débogage',
			'settings.developer.debugModeDescription' => 'Activer la journalisation supplémentaire et les fonctionnalités de débogage',
			'settings.developer.debuggingTools' => 'Outils de débogage',
			'settings.developer.semanticsDebugger' => 'Débogueur de sémantique',
			'settings.developer.semanticsDebuggerDescription' => 'Visualiser l\'arbre sémantique',
			'settings.developer.materialGrid' => 'Grille Material',
			'settings.developer.materialGridDescription' => 'Superposer la grille de mise en page Material',
			'settings.developer.rasterCache' => 'Images du cache de rastérisation',
			'settings.developer.rasterCacheDescription' => 'Images du cache de rastérisation en damier',
			'settings.developer.actions' => 'Actions',
			'settings.developer.showLogs' => 'Afficher les journaux de l\'application',
			'settings.developer.showLogsDescription' => 'Ouvrir la console de débogage Talker',
			'settings.developer.restartTutorial' => 'Redémarrer le tutoriel de bienvenue',
			'settings.developer.restartTutorialDescription' => 'Réinitialiser les drapeaux et relancer le tutoriel',
			'settings.developer.restartRequested' => 'Redémarrage du tutoriel demandé.',
			'settings.developer.throwException' => 'Générer une exception de test',
			'settings.developer.throwExceptionDescription' => 'Déclencher une exception de test pour les rapports de plantage',
			'settings.developer.testExceptionMessage' => 'Exception de test déclenchée depuis les Options Développeur',
			'settings.developer.clearTM' => 'Effacer la mémoire de traduction',
			'settings.developer.clearTMDescription' => 'Supprimer toutes les traductions mises en cache',
			'settings.developer.clearTMConfirmation' => 'Effacer la mémoire de traduction ?',
			'settings.developer.clearTMWarning' => 'Cela supprimera toutes les traductions apprises. Cette action est irréversible.',
			'settings.developer.tmCleared' => 'Mémoire de traduction effacée',
			'settings.developer.clearApiKeys' => 'Effacer les clés API',
			'settings.developer.clearApiKeysDescription' => 'Supprimer toutes les clés API stockées',
			'settings.developer.clearApiKeysConfirmation' => 'Effacer les clés API ?',
			'settings.developer.clearApiKeysWarning' => 'Cela supprimera toutes les clés API du stockage sécurisé.',
			'settings.developer.apiKeysCleared' => 'Clés API effacées',
			'settings.developer.hideOptions' => 'Masquer les options développeur',
			'settings.developer.hideOptionsDescription' => 'Désactiver le mode développeur (nécessite 7 pressions pour réactiver)',
			'settings.developer.optionsDisabled' => 'Options développeur désactivées',
			'settings.developer.dangerZone' => 'Zone de danger',
			'settings.developer.factoryReset' => 'Réinitialisation d\'usine',
			'settings.developer.factoryResetDescription' => 'Réinitialiser tous les paramètres et effacer les données',
			'settings.developer.factoryResetWarning' => 'Êtes-vous sûr de vouloir réinitialiser tous les paramètres ? Cette action est irréversible.',
			'settings.developer.inspectionTools' => 'Outils d\'inspection',
			'settings.developer.searchHint' => 'Rechercher dans les paramètres...',
			'settings.developer.resetToDefault' => 'Réinitialiser par défaut',
			'settings.developer.resetToGlobal' => 'Réinitialiser au défaut global',
			'settings.developer.storageInspector' => 'Inspecteur de stockage',
			'settings.developer.storageInspectorDescription' => 'Voir le contenu de Hive & du stockage sécurisé',
			'settings.developer.deviceEnvironment' => 'Appareil & Environnement',
			'settings.developer.deviceEnvironmentDescription' => 'Écran, plateforme, et infos de build',
			'settings.developer.themePlayground' => 'Terrain de jeu des thèmes',
			'settings.developer.themePlaygroundDescription' => 'Palette de couleurs & typographie',
			'settings.developer.themePlaygroundSection.colors' => 'Couleurs',
			'settings.developer.themePlaygroundSection.typography' => 'Typographie',
			'settings.developer.themePlaygroundSection.palette.primary' => 'Primaire',
			'settings.developer.themePlaygroundSection.palette.onPrimary' => 'Sur Primaire',
			'settings.developer.themePlaygroundSection.palette.secondary' => 'Secondaire',
			'settings.developer.themePlaygroundSection.palette.onSecondary' => 'Sur Secondaire',
			'settings.developer.themePlaygroundSection.palette.surface' => 'Surface',
			'settings.developer.themePlaygroundSection.palette.onSurface' => 'Sur Surface',
			'settings.developer.themePlaygroundSection.palette.error' => 'Erreur',
			'settings.developer.themePlaygroundSection.palette.onError' => 'Sur Erreur',
			'settings.developer.themePlaygroundSection.palette.outline' => 'Contour',
			'settings.developer.themePlaygroundSection.palette.shadow' => 'Ombre',
			'settings.developer.themePlaygroundSection.palette.success' => 'Succès',
			'settings.developer.themePlaygroundSection.palette.warning' => 'Avertissement',
			'settings.developer.themePlaygroundSection.palette.info' => 'Info',
			'settings.developer.localizationInspector' => 'Inspecteur de localisation',
			'settings.developer.localizationInspectorDescription' => 'Déboguer les chaînes de traduction',
			'settings.developer.hiveAppSettings' => 'Hive (AppSettings)',
			'settings.developer.secureStorageMasked' => 'Stockage sécurisé (Masqué)',
			'settings.developer.featureFlags.title' => 'Fonctionnalités expérimentales',
			'settings.developer.featureFlags.description' => 'Activez les drapeaux de fonctionnalités localement pour les tests. Ces surcharges persistent après le redémarrage de l\'application.',
			'settings.developer.featureFlags.subtitle' => 'Surcharger les fonctionnalités expérimentales',
			'settings.developer.featureFlags.flags.experimental_ai_batch.name' => 'Lot d\'IA expérimental',
			'settings.developer.featureFlags.flags.experimental_ai_batch.description' => 'Activer la traduction par lot par IA pour plusieurs lignes',
			'settings.developer.featureFlags.flags.new_diff_algorithm.name' => 'Nouvel algorithme de diff',
			'settings.developer.featureFlags.flags.new_diff_algorithm.description' => 'Utiliser un algorithme de diff amélioré pour les comparaisons',
			'settings.developer.featureFlags.flags.enhanced_search.name' => 'Recherche améliorée',
			'settings.developer.featureFlags.flags.enhanced_search.description' => 'Activer la recherche floue dans les fichiers de traduction',
			'settings.developer.featureFlags.flags.auto_save.name' => 'Sauvegarde automatique',
			'settings.developer.featureFlags.flags.auto_save.description' => 'Sauvegarder automatiquement les modifications après l\'édition',
			'settings.developer.featureFlags.reset' => 'Réinitialiser tous les drapeaux',
			'settings.developer.featureFlags.overrides' => 'Surcharges locales',
			'settings.developer.featureFlags.defaultVal' => 'Par défaut',
			'settings.developer.featureFlags.on' => 'ACTIVÉ',
			'settings.developer.featureFlags.off' => 'DÉSACTIVÉ',
			'settings.developer.storageInspectorSection.refresh' => 'Actualiser',
			'settings.developer.storageInspectorSection.hiveData' => 'Données Hive',
			'settings.developer.storageInspectorSection.secureStorage' => 'Stockage sécurisé',
			'settings.developer.deviceInfoSection.refresh' => 'Actualiser',
			'settings.developer.deviceInfoSection.copy' => 'Copier dans le presse-papiers',
			'settings.developer.deviceInfoSection.computerName' => 'Nom de l\'ordinateur',
			'settings.developer.deviceInfoSection.osVersion' => 'Version de l\'OS',
			'settings.developer.localizationInspectorSection.showKeys' => 'Afficher les clés au lieu des valeurs',
			'settings.developer.localizationInspectorSection.keysVisible' => 'Clés visibles',
			'settings.developer.localizationInspectorSection.normalDisplay' => 'Affichage normal',
			'settings.developer.localizationInspectorSection.note' => 'Note : Cette fonctionnalité nécessite que la localisation de l\'application utilise un wrapper qui respecte ce paramètre.',
			'settings.about.title' => 'À propos',
			'settings.about.version' => 'Version',
			'settings.about.buildNumber' => 'Numéro de build',
			'settings.about.author' => 'Auteur',
			_ => null,
		} ?? switch (path) {
			'settings.about.license' => 'Licence',
			'settings.about.sourceCode' => 'Code source',
			'settings.about.reportBug' => 'Signaler un bug',
			'settings.about.requestFeature' => 'Demander une fonctionnalité',
			'settings.about.checkForUpdates' => 'Vérifier les mises à jour',
			'settings.about.upToDate' => 'Vous êtes à jour !',
			'settings.about.updateAvailable' => ({required Object version}) => 'Mise à jour disponible : ${version}',
			'settings.about.updateAvailableBadge' => 'Mise à jour disponible !',
			'settings.about.developerSteps' => ({required Object count}) => 'Vous êtes à ${count} étapes de devenir un développeur.',
			'settings.about.developerActivated' => 'Vous êtes maintenant un développeur !',
			'settings.about.neverChecked' => 'Jamais',
			'settings.about.applicationInfo' => 'Infos de l\'application',
			'settings.about.platform' => 'Plateforme',
			'settings.about.updateInformation' => 'Informations de mise à jour',
			'settings.about.currentVersion' => 'Version actuelle',
			'settings.about.latestVersion' => 'Dernière version',
			'settings.about.lastChecked' => 'Dernière vérification',
			'settings.about.checkingForUpdates' => 'Vérification...',
			'settings.about.whatsNew' => 'Quoi de neuf',
			'settings.about.systemInformation' => 'Informations système',
			'settings.about.dartVersion' => 'Version de Dart',
			'settings.about.diskSpace' => 'Espace disque disponible',
			'settings.about.memoryUsage' => 'Utilisation de la mémoire',
			'settings.about.privacyTitle' => 'Confidentialité & Télémétrie',
			'settings.about.usageStats' => 'Statistiques d\'utilisation anonymes',
			'settings.about.requiresFirebase' => 'Nécessite une configuration Firebase',
			'settings.about.featureUnavailable' => 'Fonctionnalité actuellement indisponible (nécessite Firebase)',
			'settings.about.settingsManagement' => 'Gestion des paramètres',
			'settings.about.settingsManagementDescription' => 'Exportez vos paramètres dans un fichier pour les sauvegarder ou les partager avec d\'autres machines.',
			'settings.about.resetAll' => 'Tout réinitialiser',
			'settings.about.links' => 'Liens',
			'settings.about.githubRepo' => 'Dépôt GitHub',
			'settings.about.privacyPolicy' => 'Politique de confidentialité',
			'settings.about.crashReporting' => 'Rapports de plantage',
			'settings.onboarding.skipTutorial' => 'Ignorer le tutoriel',
			'settings.onboarding.gettingStarted' => 'Commencer',
			'settings.onboarding.stepProgress' => ({required Object current, required Object total}) => '${current} sur ${total}',
			'settings.onboarding.loadSampleData' => 'Charger des données d\'exemple',
			'settings.onboarding.steps.importFiles.title' => 'Importer des fichiers',
			'settings.onboarding.steps.importFiles.description' => 'Charger les fichiers source et cible',
			'settings.onboarding.steps.runComparison.title' => 'Lancer la comparaison',
			'settings.onboarding.steps.runComparison.description' => 'Cliquez sur "Comparer les fichiers"',
			'settings.onboarding.steps.reviewMissing.title' => 'Réviser les clés manquantes',
			'settings.onboarding.steps.reviewMissing.description' => 'Notez les éléments manquants en rouge',
			'settings.onboarding.steps.useFilters.title' => 'Utiliser les filtres',
			'settings.onboarding.steps.useFilters.description' => 'Filtrer par type',
			'settings.onboarding.steps.searchResults.title' => 'Résultats de recherche',
			'settings.onboarding.steps.searchResults.description' => 'Trouver des clés spécifiques',
			'settings.onboarding.steps.advancedView.title' => 'Vue avancée',
			'settings.onboarding.steps.advancedView.description' => 'Explorer l\'analyse détaillée',
			'settings.onboarding.steps.editCell.title' => 'Modifier une cellule',
			'settings.onboarding.steps.editCell.description' => 'Cliquez pour modifier une valeur',
			'settings.onboarding.steps.exportResults.title' => 'Exporter',
			'settings.onboarding.steps.exportResults.description' => 'Sauvegarder votre rapport',
			'settings.settingsView.resetCategoryTitle' => ({required Object category}) => 'Réinitialiser ${category} ?',
			'settings.settingsView.resetCategoryContent' => 'Cela réinitialisera tous les paramètres de cette catégorie à leurs valeurs par défaut.',
			'settings.settingsView.resetAllTitle' => 'Réinitialiser tous les paramètres ?',
			'settings.settingsView.resetAllContent' => 'Cela réinitialisera définitivement tous les paramètres à leurs valeurs d\'usine. Cette action est irréversible.',
			'settings.settingsView.resetAll' => 'Tout réinitialiser',
			'settings.settingsView.resetSuccess' => ({required Object category}) => '${category} réinitialisé aux valeurs par défaut',
			'settings.settingsView.errorLoading' => 'Erreur lors du chargement des paramètres',
			'settings.settingsView.settingsSaved' => 'Paramètres sauvegardés',
			'settings.settingsView.updateAvailable' => ({required Object version}) => 'Mise à jour disponible : v${version}',
			'settings.settingsView.latestVersion' => 'Vous utilisez la dernière version',
			'settings.settingsView.whatsNew' => ({required Object version}) => 'Quoi de neuf dans la v${version}',
			'settings.settingsView.downloadUpdate' => 'Télécharger la mise à jour',
			'settings.settingsView.exportSettings' => 'Exporter les paramètres',
			'settings.settingsView.settingsExported' => 'Paramètres exportés',
			'settings.settingsView.exportFail' => ({required Object error}) => 'Échec de l\'exportation des paramètres : ${error}',
			'settings.settingsView.importSettings' => 'Importer les paramètres',
			'settings.settingsView.importTitle' => 'Importer les paramètres ?',
			'settings.settingsView.importContent' => 'Cela remplacera tous vos paramètres actuels par ceux importés. Cette action est irréversible.',
			'settings.settingsView.importSuccess' => 'Paramètres importés avec succès !',
			'settings.settingsView.importFail' => ({required Object error}) => 'Échec de l\'importation des paramètres : ${error}',
			'settings.settingsView.invalidFormat' => 'Format de fichier de paramètres invalide',
			'settings.settingsView.categories.general' => 'Paramètres généraux',
			'settings.settingsView.categories.comparisonEngine' => 'Moteur de comparaison',
			'settings.settingsView.categories.appearance' => 'Apparence',
			'settings.settingsView.categories.fileHandling' => 'Gestion des fichiers',
			'settings.settingsView.categories.aiServices' => 'Services d\'IA',
			'settings.settingsView.categories.systemIntegrations' => 'Intégrations système',
			'settings.settingsView.categories.projectResources' => 'Ressources du projet (Glossaire & MT)',
			'settings.settingsView.categories.developer' => 'Options développeur',
			'settings.settingsView.categories.about' => 'À propos',
			'settings.settingsView.categoryLabels.general' => 'Général',
			'settings.settingsView.categoryLabels.comparisonEngine' => 'Comparaison',
			'settings.settingsView.categoryLabels.appearance' => 'Apparence',
			'settings.settingsView.categoryLabels.fileHandling' => 'Gestion des fichiers',
			'settings.settingsView.categoryLabels.aiServices' => 'Services d\'IA',
			'settings.settingsView.categoryLabels.systemIntegrations' => 'Intégrations système',
			'settings.settingsView.categoryLabels.projectResources' => 'Ressources du projet',
			'settings.settingsView.categoryLabels.developer' => 'Options développeur',
			'settings.settingsView.categoryLabels.about' => 'À propos',
			'fileComparison.title' => 'Comparaison de fichiers',
			'fileComparison.openFiles' => 'Ouvrir les fichiers',
			'fileComparison.exportResults' => 'Exporter les résultats',
			'fileComparison.restartTutorial' => 'Redémarrer le tutoriel',
			'fileComparison.restartTutorialDevOnly' => 'Le redémarrage du tutoriel est disponible uniquement en mode développeur.',
			'fileComparison.unsupportedFileType' => 'Type de fichier non pris en charge.',
			'fileComparison.unsupportedFileTypeSuggestion' => 'Veuillez sélectionner un fichier de localisation pris en charge.',
			'fileComparison.someFilesUnsupported' => 'Certains fichiers ne sont pas pris en charge.',
			'fileComparison.pickSupportedFiles' => 'Choisissez uniquement des fichiers de localisation pris en charge.',
			'fileComparison.pickTwoFiles' => 'Choisissez deux fichiers à comparer.',
			'fileComparison.pickBilingualFile' => 'Veuillez sélectionner un fichier bilingue à comparer.',
			'fileComparison.noResultsToExport' => 'Aucun résultat à exporter pour le moment.',
			'fileComparison.performComparisonFirst' => 'Effectuez d\'abord une comparaison pour exporter les résultats.',
			'fileComparison.performComparisonFirstEditor' => 'Veuillez d\'abord effectuer une comparaison pour voir les détails avancés.',
			'fileComparison.sampleDataLoaded' => 'Données d\'exemple chargées avec succès',
			'fileComparison.loadSampleDataError' => ({required Object error}) => 'Échec du chargement des données d\'exemple : ${error}',
			'fileComparison.invalidFileType' => 'Type de fichier invalide.',
			'fileComparison.fileSelected' => ({required Object label, required Object fileName}) => '${label} sélectionné : ${fileName}',
			'fileComparison.sourceFile' => 'Fichier source',
			'fileComparison.targetFile' => 'Fichier cible',
			'fileComparison.bilingualFile' => 'Fichier bilingue',
			'fileComparison.compareFiles' => 'Comparer les fichiers',
			'fileComparison.compareFile' => 'Comparer le fichier',
			'fileComparison.bilingualMode' => 'Mode bilingue',
			'fileComparison.twoFilesMode' => 'Deux fichiers',
			'fileComparison.processing' => 'Traitement...',
			'fileComparison.remaining' => ({required Object time}) => '${time} restant',
			'fileComparison.comparisonInProgress' => 'Comparaison en cours...',
			'fileComparison.comparisonFailed' => ({required Object error}) => 'Échec de la comparaison : ${error}',
			'fileComparison.fileChanged' => ({required Object fileName}) => 'Fichier modifié : ${fileName}. Re-comparaison...',
			'fileComparison.dropFileHere' => 'Déposez le fichier ici',
			'fileComparison.dropFileOrBrowse' => 'Déposez le fichier ou cliquez pour parcourir',
			'fileComparison.fileUpload' => 'Télécharger le fichier',
			'fileComparison.changeFile' => 'Changer de fichier',
			'fileComparison.total' => 'Total',
			'fileComparison.show' => 'Afficher',
			'fileComparison.showAll' => 'Tout afficher',
			'fileComparison.noMatches' => ({required Object query}) => 'Aucune correspondance trouvée pour "${query}"',
			'fileComparison.showingEntries' => ({required Object count, required Object total}) => 'Affichage de ${count} sur ${total} entrées',
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
			'directoryComparison.readyToCompareDesc' => 'Déposez des dossiers ci-dessus ou utilisez les boutons de navigation\npour sélectionner des répertoires à comparer.',
			'directoryComparison.nestedFolders' => 'Dossiers imbriqués',
			'directoryComparison.nestedFoldersTooltip' => 'Compare récursivement tous les répertoires imbriqués',
			'directoryComparison.fileMatching' => 'Correspondance de fichiers',
			'directoryComparison.fileMatchingTooltip' => 'Associe automatiquement les fichiers par nom',
			'directoryComparison.bulkExport' => 'Exportation en masse',
			'directoryComparison.bulkExportTooltip' => 'Exporter tous les résultats de comparaison en une fois',
			'directoryComparison.notDirectoryComparison' => 'Ceci n\'est pas une comparaison de dossiers.',
			'directoryComparison.directoriesNotExist' => 'L\'un des dossiers ou les deux n\'existent plus.',
			'directoryComparison.errorOccurred' => 'Une erreur s\'est produite',
			'directoryComparison.noFilesFound' => 'Aucun fichier trouvé dans les dossiers sélectionnés.',
			'directoryComparison.unmatchedSourceFiles' => 'Fichiers source non appariés',
			'directoryComparison.unmatchedTargetFiles' => 'Fichiers cible non appariés',
			'directoryComparison.filePairs' => ({required Object count}) => '${count} paires de fichiers',
			'directoryComparison.pairedFiles' => ({required Object count}) => 'Fichiers appariés (${count})',
			'directoryComparison.view' => 'Voir',
			'directoryComparison.failed' => 'Échoué',
			'directoryComparison.pair' => 'Apparier...',
			'directoryComparison.pairDialogTitle' => ({required Object name}) => 'Apparier "${name}" avec :',
			'directoryComparison.discoverFiles' => 'Découvrir les fichiers',
			'directoryComparison.compareAll' => 'Tout comparer',
			'directoryComparison.exportAll' => 'Tout exporter',
			'directoryComparison.comparisonStarted' => 'Comparaison démarrée...',
			'directoryComparison.discoveringFiles' => 'Découverte des fichiers...',
			'directoryComparison.noResultsToExport' => 'Aucun résultat de comparaison à exporter. Lancez d\'abord "Tout comparer".',
			'directoryComparison.selectExportFolder' => 'Sélectionner le dossier d\'exportation',
			'directoryComparison.createExportFolderError' => ({required Object error}) => 'Échec de la création du dossier d\'exportation : ${error}',
			'directoryComparison.exportingResults' => 'Exportation des résultats',
			'directoryComparison.processingFile' => ({required Object file}) => 'Traitement : ${file}',
			'directoryComparison.exportProgress' => ({required Object current, required Object total}) => '${current} sur ${total} fichiers exportés',
			'directoryComparison.exportComplete' => 'Exportation terminée',
			'directoryComparison.exportSuccessMessage' => ({required Object count}) => '${count} fichiers de comparaison plus le résumé ont été exportés avec succès.',
			'directoryComparison.exportFailed' => ({required Object error}) => 'L\'exportation a échoué : ${error}',
			'directoryComparison.close' => 'Fermer',
			'gitComparison._translatorNote' => 'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.',
			'gitComparison.title' => 'Comparaison de dépôt',
			'gitComparison.repoSelector' => 'Créer / Ouvrir un dépôt',
			'gitComparison.noRepoSelected' => 'Aucun dépôt sélectionné',
			'gitComparison.open' => 'Ouvrir',
			'gitComparison.refreshCommits' => 'Actualiser les commits',
			'gitComparison.noCommits' => 'Aucun commit trouvé ou chargé. Sélectionnez une branche pour charger les commits.',
			'gitComparison.baseCommit' => 'Commit de base (Plus ancien)',
			'gitComparison.targetCommit' => 'Commit cible (Plus récent)',
			'gitComparison.filterCommitsByBranch' => 'Filtrer les commits par branche',
			'gitComparison.conflictDetection' => 'Détection de conflits',
			'gitComparison.conflictDetectionTooltip' => 'Détecter et résoudre les conflits de fusion',
			'gitComparison.actions' => 'Actions :',
			'gitComparison.checkout' => 'Checkout',
			'gitComparison.merge' => 'Merge',
			'gitComparison.pull' => 'Pull',
			'gitComparison.checkoutBranch' => 'Checkout Branch',
			'gitComparison.mergeBranch' => 'Merge Branch into Current',
			'gitComparison.mergeConfirmation' => ({required Object branch}) => 'Merge ${branch} ?',
			'gitComparison.mergeWarning' => 'Cela fusionnera les modifications dans votre branche de travail actuelle. Des conflits peuvent survenir.',
			'gitComparison.selectExportFolder' => 'Sélectionner le dossier d\'exportation',
			'gitComparison.createExportFolderError' => ({required Object error}) => 'Échec de la création du dossier d\'exportation : ${error}',
			'gitComparison.exportingFiles' => 'Exportation des fichiers',
			'gitComparison.processingFile' => ({required Object file}) => 'Traitement : ${file}',
			'gitComparison.exportProgress' => ({required Object current, required Object total}) => '${current} sur ${total} fichiers exportés',
			'gitComparison.exportComplete' => 'Exportation terminée',
			'gitComparison.exportSuccessMessage' => ({required Object count}) => '${count} fichiers avec le contenu complet ont été exportés avec succès.',
			'gitComparison.exportDetail' => 'Le diff de chaque fichier est enregistré dans le sous-dossier "files".',
			'gitComparison.diffViewer' => 'Visionneuse de diff',
			'gitComparison.base' => 'BASE',
			'gitComparison.target' => 'CIBLE',
			'gitComparison.noLines' => 'Aucune ligne à afficher',
			'gitComparison.searchFiles' => 'Rechercher des fichiers...',
			'gitComparison.noFilesMatch' => ({required Object query}) => 'Aucun fichier ne correspond à "${query}"',
			'gitComparison.filesCount' => ({required Object count}) => '${count} fichiers',
			'gitComparison.selectBaseFile' => 'Sélectionner le fichier de base',
			'gitComparison.selectTargetFile' => 'Sélectionner le fichier cible',
			'gitComparison.comparisonResults' => 'Résultats de la comparaison',
			'gitComparison.noChanges' => 'Aucune modification trouvée entre les références sélectionnées.',
			'gitComparison.linesAdded' => 'Lignes ajoutées',
			'gitComparison.linesRemoved' => 'Lignes supprimées',
			'gitComparison.commit' => 'Commit',
			'gitComparison.branch' => 'Branch',
			'gitComparison.noRepositorySelected' => 'Aucun dépôt sélectionné',
			'gitComparison.notGitComparison' => 'Ceci n\'est pas une comparaison Git',
			'gitComparison.repositoryNotExist' => 'Le dépôt n\'existe pas',
			'gitComparison.mainBranch' => 'main',
			'gitComparison.masterBranch' => 'master',
			'gitComparison.backToControls' => 'Retour aux contrôles de comparaison',
			'advancedComparison.placeholder' => 'Vue de comparaison avancée - Espace réservé',
			'advancedDiff.saveAllChanges' => 'Sauvegarder toutes les modifications ?',
			'advancedDiff.saveConfirmation' => ({required Object count}) => 'Cela enregistrera toutes les ${count} entrées modifiées dans le fichier cible. Cette action est irréversible.',
			'advancedDiff.changesSaved' => 'Modifications enregistrées avec succès.',
			'advancedDiff.csvExported' => 'CSV exporté',
			'advancedDiff.unsavedChanges' => 'Modifications non enregistrées',
			'advancedDiff.unsavedChangesWarning' => 'Vous avez des modifications non enregistrées. Êtes-vous sûr de vouloir les abandonner ?',
			'advancedDiff.discardChanges' => 'Abandonner les modifications',
			'advancedDiff.goBack' => 'Retour',
			'advancedDiff.breadcrumbs' => 'Accueil  >  Éditeur',
			'advancedDiff.unsaved' => ({required Object count}) => '${count} non enregistrés',
			'advancedDiff.reviewed' => ({required Object count}) => '${count} révisés',
			'advancedDiff.saveAll' => ({required Object count}) => 'Tout sauvegarder (${count})',
			'advancedDiff.allSaved' => 'Tout est sauvegardé',
			'advancedDiff.saveAllTooltip' => 'Sauvegarder toutes les modifications (Ctrl+S)',
			'advancedDiff.exportTooltip' => 'Exporter les données (Ctrl+E)',
			'advancedDiff.aiSuggestion.aiTranslation' => 'Traduction par IA',
			'advancedDiff.aiSuggestion.aiRephrase' => 'Reformulation par IA',
			'advancedDiff.aiSuggestion.key' => ({required Object key}) => 'Clé : ${key}',
			'advancedDiff.aiSuggestion.original' => 'Original :',
			'advancedDiff.aiSuggestion.suggestion' => 'Suggestion :',
			'advancedDiff.aiSuggestion.confidence' => 'Confiance de l\'IA',
			'advancedDiff.aiSuggestion.cancelEdit' => 'Annuler la modification',
			'advancedDiff.aiSuggestion.editSuggestion' => 'Modifier la suggestion',
			'advancedDiff.aiSuggestion.alternatives' => 'Alternatives :',
			'advancedDiff.aiSuggestion.accept' => 'Accepter',
			'advancedDiff.aiSuggestion.reject' => 'Rejeter',
			'advancedDiff.aiSuggestion.stop' => 'Arrêter',
			'advancedDiff.detailEdit.title' => ({required Object key}) => 'Modifier : ${key}',
			'advancedDiff.detailEdit.sourceLabel' => 'SOURCE (Original)',
			'advancedDiff.detailEdit.targetLabel' => 'CIBLE (Traduction)',
			'advancedDiff.detailEdit.translateWithCloud' => 'Traduire avec le Cloud',
			'advancedDiff.detailEdit.translateWithAi' => 'Traduire avec l\'IA',
			'advancedDiff.detailEdit.translating' => 'Traduction en cours...',
			'advancedDiff.detailEdit.applyAndTm' => 'Appliquer',
			'advancedDiff.detailEdit.entryApplied' => 'Entrée appliquée & ajoutée à la MT',
			'advancedDiff.detailEdit.translationAdded' => 'Suggestion de traduction ajoutée.',
			'advancedDiff.detailEdit.aiSuggestionAdded' => 'Suggestion d\'IA ajoutée.',
			'advancedDiff.table.addedToTM' => 'Ajouté à la mémoire de traduction',
			'advancedDiff.table.markedReviewed' => 'Marqué comme révisé ✓',
			'advancedDiff.table.unmarkedReview' => 'Révision décochée',
			'advancedDiff.table.reverted' => 'Revenu à la valeur source',
			'advancedDiff.table.entryDeleted' => 'Entrée supprimée',
			'advancedDiff.table.noSourceText' => 'Aucun texte source à traduire.',
			'advancedDiff.table.aiTranslationFailed' => ({required Object key}) => 'Échec de la traduction par IA pour "${key}"',
			'advancedDiff.table.noTargetText' => 'Aucun texte cible à reformuler.',
			'advancedDiff.table.aiRephraseFailed' => ({required Object key}) => 'Échec de la reformulation par IA pour "${key}"',
			'advancedDiff.table.checkRowsFirst' => 'Cochez d\'abord les lignes à l\'aide des cases à cocher',
			'advancedDiff.table.markedRowsReviewed' => ({required Object count}) => '${count} lignes marquées comme révisées',
			'advancedDiff.table.revertedRows' => ({required Object count}) => '${count} lignes réinitialisées',
			'advancedDiff.table.entriesCount' => ({required Object count}) => '${count} entrées',
			'advancedDiff.table.markSelectedReviewed' => 'Marquer la sélection comme révisée',
			'advancedDiff.table.revertSelected' => 'Réinitialiser la sélection',
			'advancedDiff.table.noDifferences' => 'Aucune différence trouvée',
			'advancedDiff.table.adjustFilters' => 'Essayez d\'ajuster vos filtres',
			'advancedDiff.table.cloudTranslationApplied' => 'Traduction Cloud appliquée.',
			'advancedDiff.table.aiTranslationApplied' => 'Traduction par IA appliquée.',
			'advancedDiff.table.suggestionApplied' => 'Suggestion appliquée.',
			'advancedDiff.table.aiSuggestionApplied' => 'Suggestion d\'IA appliquée.',
			'advancedDiff.table.rephraseApplied' => 'Reformulation appliquée.',
			'advancedDiff.table.aiRephraseApplied' => 'Reformulation par IA appliquée.',
			'advancedDiff.table.rephrase' => 'Reformuler',
			'advancedDiff.table.aiRephrase' => 'Reformuler par IA',
			'advancedDiff.table.targetClickToEdit' => 'CIBLE (Cliquez pour modifier)',
			'advancedDiff.table.targetClickForDialog' => 'CIBLE (Cliquez pour ouvrir la boîte de dialogue)',
			'advancedDiff.table.emptyClickToEdit' => '(Vide - Cliquez pour modifier)',
			'advancedDiff.table.unmarkReviewed' => 'Décocher révisé',
			'advancedDiff.table.markReviewed' => 'Marquer comme révisé',
			'advancedDiff.table.revertToSource' => 'Revenir à la source',
			'advancedDiff.table.translateWithCloud' => 'Traduire avec le Cloud',
			'advancedDiff.table.translateWithAi' => 'Traduire avec l\'IA',
			'advancedDiff.table.rephraseWithAi' => 'Reformuler par IA',
			'advancedDiff.table.moreActions' => 'Plus d\'actions',
			'advancedDiff.table.editDetails' => 'Modifier les détails',
			'advancedDiff.table.suggestTranslation' => 'Suggérer une traduction',
			'advancedDiff.table.addToTm' => 'Ajouter à la MT',
			'advancedDiff.table.deleteEntry' => 'Supprimer l\'entrée',
			'advancedDiff.diffRow.copySource' => 'Copier le texte source',
			'advancedDiff.diffRow.actions' => 'Actions',
			'advancedDiff.status.added' => 'AJOUTÉ',
			'advancedDiff.status.missing' => 'MANQUANT',
			'advancedDiff.status.changed' => ({required Object percent}) => 'MOD ${percent}%',
			'advancedDiff.status.same' => 'IDENTIQUE',
			'advancedDiff.sidebar.widgets' => 'Widgets',
			'advancedDiff.sidebar.searchPlaceholder' => 'Rechercher clés & valeurs... (Ctrl+F)',
			'advancedDiff.sidebar.fuzzySearchTooltip' => 'Recherche floue (tolérante aux fautes)',
			'advancedDiff.sidebar.regexSearchTooltip' => 'Recherche Regex',
			'advancedDiff.sidebar.cloudTranslation' => 'Traduction Cloud',
			'advancedDiff.sidebar.aiTranslation' => 'Traduction par IA',
			'advancedDiff.sidebar.status' => 'Statut',
			'advancedDiff.sidebar.tm' => 'Mémoire de traduction',
			'advancedDiff.sidebar.filters' => 'Filtres',
			'advancedDiff.sidebar.actions' => 'Actions',
			'advancedDiff.sidebar.similarity' => 'Similitude',
			'advancedDiff.sidebar.actionsSection.exportMatches' => 'Exporter les correspondances',
			'advancedDiff.sidebar.actionsSection.preview' => 'Aperçu',
			'advancedDiff.sidebar.actionsSection.fillFromTmTitle' => 'Remplir depuis la mémoire de traduction ?',
			'advancedDiff.sidebar.actionsSection.fillFromTmContent' => 'Cela tentera de remplir les valeurs cibles vides à l\'aide des correspondances de la mémoire de traduction. Les valeurs existantes ne seront PAS écrasées.',
			'advancedDiff.sidebar.actionsSection.fill' => 'Remplir',
			'advancedDiff.sidebar.actionsSection.fillFromMemory' => 'Remplir depuis la mémoire',
			'advancedDiff.sidebar.actionsSection.filledFromTm' => ({required Object count}) => '${count} éléments remplis depuis la mémoire de traduction.',
			'advancedDiff.sidebar.aiSection.infoCloud' => 'Utilise la traduction Cloud pour traduire les valeurs cibles vides à partir de la source.',
			'advancedDiff.sidebar.aiSection.infoAi' => 'Utilise l\'IA pour traduire les valeurs cibles vides à partir de la source.',
			'advancedDiff.sidebar.aiSection.translationSettings' => 'Paramètres de traduction',
			'advancedDiff.sidebar.aiSection.aiSettings' => 'Paramètres d\'IA',
			'advancedDiff.sidebar.aiSection.source' => 'Source',
			'advancedDiff.sidebar.aiSection.target' => 'Cible',
			'advancedDiff.sidebar.aiSection.translatingProgress' => ({required Object percent}) => 'Traduction... ${percent}%',
			'advancedDiff.sidebar.aiSection.translating' => 'Traduction...',
			'advancedDiff.sidebar.aiSection.translateAllMissing' => 'Traduire tout ce qui manque',
			'advancedDiff.sidebar.aiSection.translateAllTitle' => 'Traduire tout ce qui manque ?',
			'advancedDiff.sidebar.aiSection.translateAllContent' => ({required Object service, required Object source, required Object target}) => 'Cela utilisera ${service} pour traduire toutes les entrées ayant des valeurs cibles vides de ${source} vers ${target}.\n\nVous pouvez réviser chaque suggestion ou tout appliquer d\'un coup.',
			'advancedDiff.sidebar.aiSection.translateAll' => 'Tout traduire',
			'advancedDiff.sidebar.aiSection.reviewEach' => 'Réviser chaque élément',
			'advancedDiff.sidebar.aiSection.cloudTranslated' => ({required Object count}) => '${count} entrées traduites avec la traduction Cloud.',
			'advancedDiff.sidebar.aiSection.aiTranslated' => ({required Object count}) => '${count} entrées traduites avec l\'IA.',
			'advancedDiff.sidebar.aiSection.aiTranslateFailed' => 'L\'IA n\'a pas réussi à tout traduire',
			'advancedDiff.sidebar.aiSection.noMissingEntries' => 'Aucune entrée manquante à traduire.',
			'advancedDiff.sidebar.aiSection.skip' => 'Passer',
			'advancedDiff.sidebar.aiSection.stop' => 'Arrêter',
			'advancedDiff.sidebar.aiSection.cloudApplied' => ({required Object count}) => '${count} suggestions appliquées.',
			'advancedDiff.sidebar.aiSection.aiApplied' => ({required Object count}) => '${count} suggestions d\'IA appliquées.',
			'advancedDiff.sidebar.tmSection.enableTmFill' => 'Activer le remplissage par MT',
			'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' => 'Appliquer automatiquement au-dessus du minimum',
			'advancedDiff.sidebar.tmSection.matchSettings' => 'Paramètres de correspondance',
			'advancedDiff.sidebar.tmSection.minMatch' => 'Corresp. min :',
			'advancedDiff.sidebar.tmSection.limit' => 'Limite :',
			'advancedDiff.sidebar.tmSection.exact' => 'Exact',
			'advancedDiff.sidebar.filtersSection.viewFilters' => 'Filtres d\'affichage',
			'advancedDiff.sidebar.filtersSection.showAll' => 'Tout afficher',
			'advancedDiff.sidebar.filtersSection.added' => 'Ajouté',
			'advancedDiff.sidebar.filtersSection.removed' => 'Supprimé',
			'advancedDiff.sidebar.filtersSection.modified' => 'Modifié',
			'advancedDiff.sidebar.filtersSection.actionScope' => 'Portée de l\'action',
			'advancedDiff.sidebar.filtersSection.applyToAdded' => 'Appliquer aux ajoutés',
			'advancedDiff.sidebar.filtersSection.applyToModified' => 'Appliquer aux modifiés',
			'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' => 'Remplir uniquement les cibles vides',
			'advancedDiff.sidebar.filtersSection.limitToVisible' => 'Limiter au visible',
			'advancedDiff.sidebar.filtersSection.editMode' => 'Mode d\'édition',
			'advancedDiff.sidebar.filtersSection.dialog' => 'Dialogue',
			'advancedDiff.sidebar.filtersSection.inline' => 'En ligne',
			'advancedDiff.sidebar.similaritySection.currentFilter' => 'Filtre actuel :',
			'advancedDiff.sidebar.similaritySection.any' => 'TOUT',
			'advancedDiff.sidebar.similaritySection.high' => 'HAUT',
			'advancedDiff.sidebar.similaritySection.medium' => 'MOYEN',
			'advancedDiff.sidebar.similaritySection.low' => 'BAS',
			'advancedDiff.sidebar.statusSection.total' => ({required Object count}) => '${count} au total',
			'advancedDiff.sidebar.statusSection.extra' => ({required Object count}) => '${count} en surplus',
			'advancedDiff.sidebar.statusSection.missing' => ({required Object count}) => '${count} manquants',
			'advancedDiff.sidebar.statusSection.changed' => ({required Object count}) => '${count} modifiés',
			'issueDetails.title' => 'Détails du problème',
			'issueDetails.showingIssues' => ({required Object count, required Object total}) => 'Affichage de ${count} sur ${total} problèmes',
			'issueDetails.searchPlaceholder' => 'Rechercher par clé, texte ou erreur...',
			'issueDetails.noDetails' => 'Aucun détail disponible.',
			'issueDetails.noMatches' => 'Aucune correspondance trouvée.',
			'issueDetails.showMore' => 'Afficher plus',
			'issueDetails.copyItems' => ({required Object count}) => 'Copier ${count} éléments',
			'issueDetails.close' => 'Fermer',
			'issueDetails.copied' => 'Copié dans le presse-papiers',
			'issueDetails.copiedCount' => ({required Object count}) => '${count} éléments copiés',
			'issueDetails.duplicateValue.label' => 'TRADUCTION RÉPÉTÉE',
			'issueDetails.duplicateValue.warning' => 'Différents textes sources utilisent cette même traduction. Vérifiez le contexte.',
			'issueDetails.duplicateValue.affectedKeys' => ({required Object count}) => 'CLÉS AFFECTÉES (${count})',
			'issueDetails.duplicateValue.identicalSources' => 'Sources identiques',
			'issueDetails.duplicateValue.moreKeys' => ({required Object count}) => '+${count} clés de plus',
			'issueDetails.lengthOutlier.source' => 'SOURCE',
			'issueDetails.lengthOutlier.translation' => 'TRADUCTION',
			'issueDetails.lengthOutlier.chars' => ({required Object count}) => '${count} car.',
			'issueDetails.standard.key' => 'CLÉ',
			'issueDetails.standard.sourceText' => 'TEXTE SOURCE',
			'issueDetails.standard.translation' => 'TRADUCTION',
			'issueDetails.standard.errorDetails' => 'DÉTAILS DE L\'ERREUR',
			'issueDetails.standard.note' => 'NOTE',
			'issueDetails.review' => 'Réviser',
			'issueDetails.types.duplicateValue' => 'Valeurs en double',
			'issueDetails.types.lengthOutlier' => 'Écart de longueur',
			'issueDetails.types.placeholderMismatch' => 'Espaces réservés erronés',
			'issueDetails.notes.placeholderMismatch' => 'Les marqueurs comme {name} doivent correspondre à la source.',
			'issueDetails.notes.lengthOutlier' => 'De grands changements de longueur peuvent affecter l\'affichage du texte à l\'écran.',
			'issueDetails.notes.duplicateValue' => 'La même traduction est utilisée pour différentes clés.',
			'issueDetails.fallbacks.multipleSources' => 'Plusieurs textes sources',
			'issueDetails.fallbacks.sourceNotAvailable' => 'Texte source non disponible',
			'issueDetails.fallbacks.sharedTranslationNotAvailable' => 'Traduction partagée non disponible',
			'issueDetails.fallbacks.translationNotAvailable' => 'Traduction non disponible',
			'importReview.title' => 'Réviser l\'importation du projet',
			'importReview.projectName' => 'Nom du projet',
			'importReview.created' => 'Créé',
			'importReview.historyItems' => 'Historique',
			'importReview.customSettingsTitle' => 'Paramètres personnalisés détectés',
			'importReview.customSettingsWarning' => 'Ce projet contient des paramètres personnalisés qui remplaceront vos réglages par défaut tant qu\'il sera ouvert.',
			'importReview.standardSettings' => 'Ce projet utilise les paramètres globaux standards.',
			'importReview.cancelImport' => 'Annuler l\'importation',
			'importReview.trustOpen' => 'Faire confiance & Ouvrir le projet',
			'historyView.title' => 'Historique de comparaison',
			'historyView.clearAll' => 'Effacer tout l\'historique',
			'historyView.searchPlaceholder' => 'Rechercher par nom de fichier...',
			'historyView.sortBy' => 'Trier par',
			'historyView.sortDate' => 'Date',
			'historyView.sortSource' => 'Fichier source',
			'historyView.sortTarget' => 'Fichier cible',
			'historyView.showCurrentProject' => 'Affichage : Projet actuel',
			'historyView.showAllHistory' => 'Affichage : Tout l\'historique',
			'historyView.groupByFolder' => 'Grouper par dossier',
			'historyView.disableGrouping' => 'Désactiver le groupement par dossier',
			'historyView.filterAll' => 'Tout',
			'historyView.filterFiles' => 'Fichiers',
			'historyView.filterDirectories' => 'Dossiers',
			'historyView.filterGit' => 'Git',
			'historyView.noHistory' => 'Aucun historique de comparaison pour le moment',
			'historyView.historyDescription' => 'Vos comparaisons de fichiers apparaîtront ici',
			'historyView.noResults' => 'Aucun résultat trouvé',
			'historyView.adjustSearch' => 'Essayez d\'ajuster votre recherche',
			'historyView.clearConfirmationTitle' => 'Effacer tout l\'historique ?',
			'historyView.clearConfirmationContent' => 'Cela supprimera définitivement tout l\'historique des comparaisons. Cette action est irréversible.',
			'historyView.clearAction' => 'Tout effacer',
			'historyView.deletedMessage' => 'Élément de l\'historique supprimé',
			'historyView.undo' => 'Annuler',
			'historyView.viewDetails' => 'Voir détails',
			'historyView.delete' => 'Supprimer',
			'historyView.openLocation' => 'Ouvrir l\'emplacement du fichier',
			'historyView.bilingual' => 'Bilingue',
			'historyView.filePair' => 'Paire de fichiers',
			'historyView.directory' => 'Dossier',
			'historyView.git' => 'Git',
			'historyView.repo' => 'Dépôt',
			'historyView.sourceDir' => 'Dossier source',
			'historyView.targetDir' => 'Dossier cible',
			'historyView.source' => 'Source',
			'historyView.target' => 'Cible',
			'historyView.noChanges' => 'Aucune modification détectée',
			'historyView.added' => 'Ajouté',
			'historyView.removed' => 'Supprimé',
			'historyView.modified' => 'Modifié',
			'historyView.same' => 'Identique',
			'historyView.total' => 'Total',
			'historyView.currentProject' => 'Projet actuel',
			'historyView.unassigned' => 'Non assigné',
			'historyView.project' => 'Projet',
			'compare.title' => 'Comparer les fichiers',
			'compare.sourceFile' => 'Fichier source',
			'compare.targetFile' => 'Fichier cible',
			'compare.sourceFolder' => 'Dossier source',
			'compare.targetFolder' => 'Dossier cible',
			'compare.dropFilesHint' => 'Déposez les fichiers de localisation ici ou utilisez les boutons de navigation pour sélectionner les fichiers à comparer.',
			'compare.selectSourceFile' => 'Sélectionner le fichier source',
			'compare.selectTargetFile' => 'Sélectionner le fichier cible',
			'compare.startComparison' => 'Démarrer la comparaison',
			'compare.comparing' => 'Comparaison...',
			'compare.comparisonComplete' => 'Comparaison terminée',
			'compare.noChanges' => 'Aucune modification détectée',
			'compare.filesIdentical' => 'Les fichiers sont identiques',
			'compare.changesFound' => ({required Object count}) => '${count} modifications trouvées',
			'compare.tabs.files' => 'Fichiers',
			'compare.tabs.directories' => 'Dossiers',
			'compare.tabs.git' => 'Git',
			'compare.fileTypes.json' => 'Fichiers de localisation JSON (i18next, Flutter, etc.)',
			'compare.fileTypes.yaml' => 'Fichiers de localisation YAML (Rails, Flutter)',
			'compare.fileTypes.xml' => 'Fichiers de localisation XML (Android, .NET)',
			'compare.fileTypes.properties' => 'Fichiers properties (Java)',
			'compare.fileTypes.resx' => 'Fichiers RESX (.NET)',
			_ => null,
		} ?? switch (path) {
			'compare.fileTypes.xliff' => 'Fichiers XLIFF',
			'history.title' => 'Historique',
			'history.recentComparisons' => 'Comparaisons récentes',
			'history.noHistory' => 'Aucun historique de comparaison pour le moment',
			'history.noHistoryDescription' => 'Votre historique de comparaison apparaîtra ici',
			'history.clearHistory' => 'Effacer l\'historique',
			'history.clearHistoryConfirm' => 'Êtes-vous sûr de vouloir effacer tout l\'historique ?',
			'history.deleteEntry' => 'Supprimer l\'entrée',
			'history.openComparison' => 'Ouvrir la comparaison',
			'history.timeAgo.justNow' => 'à l\'instant',
			'history.timeAgo.secondsAgo' => ({required Object count}) => 'il y a ${count} secondes',
			'history.timeAgo.oneMinuteAgo' => 'il y a 1 minute',
			'history.timeAgo.minutesAgo' => ({required Object count}) => 'il y a ${count} minutes',
			'history.timeAgo.oneHourAgo' => 'il y a 1 heure',
			'history.timeAgo.hoursAgo' => ({required Object count}) => 'il y a ${count} heures',
			'history.timeAgo.yesterday' => 'hier',
			'history.timeAgo.daysAgo' => ({required Object count}) => 'il y a ${count} jours',
			'history.timeAgo.oneWeekAgo' => 'il y a 1 semaine',
			'history.timeAgo.weeksAgo' => ({required Object count}) => 'il y a ${count} semaines',
			'history.timeAgo.oneMonthAgo' => 'il y a 1 mois',
			'history.timeAgo.monthsAgo' => ({required Object count}) => 'il y a ${count} mois',
			'history.timeAgo.oneYearAgo' => 'il y a 1 an',
			'history.timeAgo.yearsAgo' => ({required Object count}) => 'il y a ${count} ans',
			'history.timeAgo.inTheFuture' => 'dans le futur',
			'projects.title' => 'Projets',
			'projects.createProject' => 'Créer un projet',
			'projects.importProject' => 'Importer un projet',
			'projects.noProjects' => 'Aucun projet pour le moment',
			'projects.noProjectsDescription' => 'Créez un projet pour organiser vos fichiers de localisation',
			'projects.projectName' => 'Nom du projet',
			'projects.projectPath' => 'Chemin du projet',
			'projects.lastOpened' => 'Dernière ouverture',
			'projects.openProject' => 'Ouvrir le projet',
			'projects.closeProject' => 'Fermer le projet',
			'projects.deleteProject' => 'Supprimer le projet',
			'projects.deleteProjectConfirm' => 'Êtes-vous sûr de vouloir supprimer ce projet ?',
			'projects.exportProject' => 'Exporter le projet',
			'projects.exportDescription' => 'Créez un fichier zip portable contenant les fichiers sources, la configuration et l\'historique.',
			'projects.exporting' => 'Exportation du projet...',
			'projects.exportSuccess' => 'Projet exporté',
			'projects.exportError' => ({required Object error}) => 'L\'exportation a échoué : ${error}',
			'projects.createNewProject' => 'Créer un nouveau projet',
			'projects.openExistingProject' => 'Ouvrir un projet existant',
			'projects.importProjectZip' => 'Importer le Zip du projet',
			'projects.projectResources' => 'Ressources du projet',
			'projects.recentProjects' => 'Projets récents',
			'projects.noRecentProjects' => 'Aucun projet récent',
			'projects.selectProjectZip' => 'Sélectionner le Zip du projet',
			'projects.selectDestination' => 'Sélectionner le dossier de destination pour l\'importation',
			'projects.importing' => 'Importation du projet...',
			'projects.importSuccess' => 'Projet importé avec succès',
			'projects.importFailed' => ({required Object error}) => 'L\'importation a échoué : ${error}',
			'projects.importingFiles' => 'Importation des fichiers...',
			'projects.noSupportedFiles' => 'Aucun fichier pris en charge n\'a été déposé.',
			'projects.stats.empty' => 'Projet vide',
			'projects.stats.files' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '1 fichier de traduction', other: '${count} fichiers de traduction', ), 
			'projects.stats.languages' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '1 langue', other: '${count} langues', ), 
			'projects.openProjectFirst' => 'Ouvrez d\'abord un projet pour gérer ses ressources.',
			'projects.removeFromRecent' => 'Retirer des récents',
			'projects.selection.selectFolder' => 'Sélectionner le dossier du projet',
			'projects.selection.selectArchive' => 'Sélectionner l\'archive du projet',
			'projects.selection.openProject' => 'Ouvrir le projet',
			'projects.selection.browseFolder' => 'Parcourir le dossier...',
			'projects.selection.createNew' => 'Créer un nouveau',
			'projects.selection.importFromZip' => 'Importer depuis un Zip...',
			'projects.createDialog.title' => 'Créer un projet',
			'projects.createDialog.description' => 'Un projet vous permet d\'enregistrer des paramètres personnalisés pour un dossier spécifique. Un dossier ".localizer" sera créé pour stocker la configuration de votre projet.',
			'projects.createDialog.folderLabel' => 'Dossier du projet',
			'projects.createDialog.folderHint' => 'Cliquez pour sélectionner le dossier...',
			'projects.createDialog.nameLabel' => 'Nom du projet',
			'projects.createDialog.nameHint' => 'ex: Mon App Traductions',
			'projects.createDialog.selectFolderWarning' => 'Veuillez sélectionner un dossier de projet.',
			'projects.createDialog.enterNameError' => 'Veuillez entrer un nom de projet',
			'projects.createDialog.nameLengthError' => 'Le nom doit comporter au moins 2 caractères',
			'projects.createDialog.success' => ({required Object name}) => 'Projet "${name}" créé avec succès !',
			'projects.createDialog.failure' => 'Échec de la création du projet.',
			'projects.createDialog.creating' => 'Création...',
			'projects.createDialog.createAction' => 'Créer le projet',
			'projects.indicator.tooltipNoProject' => 'Créez un projet pour enregistrer des paramètres personnalisés pour un dossier',
			'projects.indicator.tooltipProject' => ({required Object name}) => 'Projet : ${name}\nCliquez pour voir les options',
			'projects.indicator.location' => 'Emplacement',
			'projects.indicator.created' => 'Créé',
			'projects.indicator.switchProject' => 'Changer de projet',
			'projects.indicator.done' => 'Terminé',
			'projects.glossary.title' => 'Glossaire du projet',
			'projects.glossary.description' => 'Définissez des termes qui doivent être traités de manière cohérente ou ne jamais être traduits.',
			'projects.glossary.noTerms' => 'Aucun terme dans le glossaire pour le moment.',
			'projects.glossary.noTermsDesc' => 'Ajoutez des termes qui doivent rester cohérents d\'une traduction à l\'autre,\nou marquez des noms de marque qui ne doivent jamais être traduits.',
			'projects.glossary.doNotTranslate' => 'Ne pas traduire',
			'projects.glossary.noSpecificTranslation' => 'Pas de traduction spécifique',
			'projects.glossary.addTerm' => 'Ajouter un terme',
			'projects.glossary.editTerm' => 'Modifier le terme',
			'projects.glossary.term' => 'Terme',
			'projects.glossary.termHint' => 'ex: nom de marque, terme spécialisé',
			'projects.glossary.definition' => 'Définition (Optionnel)',
			'projects.glossary.definitionHint' => 'Contexte pour le traducteur',
			'projects.glossary.doNotTranslateLabel' => 'Ne pas traduire',
			'projects.glossary.doNotTranslateDesc' => 'Garder le terme exactement tel quel dans la cible',
			'projects.glossary.preferredTranslation' => 'Traduction préférée',
			'projects.glossary.caseSensitive' => 'Sensible à la casse',
			'projects.conflicts.missingApiKeyTitle' => ({required Object service}) => 'Clé API manquante pour ${service}',
			'projects.conflicts.missingApiKeyMessage' => ({required Object service}) => 'Ce projet utilise ${service} mais aucune clé API n\'est configurée. Ajoutez votre clé API dans Paramètres > Services d\'IA, sinon l\'application utilisera le défaut global.',
			'projects.conflicts.dismiss' => 'Ignorer',
			'projects.tm.title' => 'Mémoires de traduction',
			'projects.tm.description' => 'Gérez les sources de mémoire de traduction pour ce projet.',
			'projects.tm.globalTm' => 'Mémoire de traduction globale',
			'projects.tm.globalTmDescription' => 'Utilisez la mémoire de traduction partagée de vos paramètres d\'application',
			'projects.tm.linkedFiles' => 'Fichiers liés (Spécifiques au projet)',
			'projects.tm.noLinkedFiles' => 'Aucun fichier spécifique au projet lié.',
			'projects.tm.addTmFile' => 'Ajouter un fichier MT',
			'projects.tm.useGlobalTm' => 'Utiliser la MT globale',
			'projects.tm.selectTm' => 'Sélectionner la mémoire de traduction',
			'projects.tm.globalTmEnabled' => 'Mémoire de traduction globale activée',
			'diff.added' => 'Ajouté',
			'diff.removed' => 'Supprimé',
			'diff.modified' => 'Modifié',
			'diff.unchanged' => 'Inchangé',
			'diff.missing' => 'Manquant',
			'diff.extra' => 'En surplus',
			'diff.sourceValue' => 'Valeur source',
			'diff.targetValue' => 'Valeur cible',
			'diff.key' => 'Clé',
			'diff.status' => 'Statut',
			'diff.actions' => 'Actions',
			'diff.copyToTarget' => 'Copier vers la cible',
			'diff.acceptChange' => 'Accepter la modification',
			'diff.rejectChange' => 'Rejeter la modification',
			'diff.viewDetails' => 'Voir détails',
			'git.title' => 'Comparaison Git',
			'git.selectRepository' => 'Sélectionner le dépôt',
			'git.selectBranch' => 'Sélectionner la branche',
			'git.selectCommit' => 'Sélectionner le commit',
			'git.compareBranches' => 'Comparer les branches',
			'git.compareCommits' => 'Comparer les commits',
			'git.baseBranch' => 'Branche de base',
			'git.compareBranch' => 'Comparer la branche',
			'git.noRepositories' => 'Aucun dépôt Git trouvé',
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
			'quality.title' => 'Tableau de bord qualité',
			'quality.overallScore' => 'Score global',
			'quality.issues' => 'Problèmes',
			'quality.warnings' => 'Avertissements',
			'quality.suggestions' => 'Suggestions',
			'quality.placeholderMismatch' => 'Écart d\'espace réservé',
			'quality.placeholderMismatchDescription' => 'Les espaces réservés comme {name} ne correspondent pas entre la source et la cible',
			'quality.lengthOutlier' => 'Écart de longueur',
			'quality.lengthOutlierDescription' => 'La longueur de la traduction diffère considérablement de la source',
			'quality.duplicateValue' => 'Valeur en double',
			'quality.duplicateValueDescription' => 'La même traduction est utilisée pour plusieurs clés',
			'quality.missingTranslation' => 'Traduction manquante',
			'quality.missingTranslationDescription' => 'La traduction manque pour cette clé',
			'quality.loading' => 'Chargement du tableau de bord...',
			'quality.errorLoading' => 'Nous n\'avons pas pu charger votre historique. Réessayez.',
			'quality.emptyState' => 'Lancez une comparaison pour voir votre tableau de bord.',
			'quality.refresh' => 'Actualiser',
			'quality.buildingInsights' => 'Analyse en cours...',
			'quality.crunchingNumbers' => 'Calculs en cours...',
			'quality.errorBuilding' => 'Nous n\'avons pas pu construire le tableau de bord. Réessayez.',
			'quality.noUsableData' => 'Aucune donnée utilisable trouvée pour le moment.',
			'quality.languages' => 'Langues',
			'quality.averageCoverage' => 'Couverture moyenne',
			'quality.potentialIssues' => 'Problèmes potentiels',
			'quality.translationCoverage' => 'Couverture de traduction',
			'quality.entriesTranslated' => ({required Object translated, required Object total}) => '${translated} sur ${total} entrées traduites',
			'quality.wordsAddedOverTime' => 'Mots ajoutés au fil du temps',
			'quality.completionVsScope' => 'Achèvement vs Portée',
			'quality.scopeVsProgress' => 'Portée vs Progrès',
			'quality.coveragePercent' => 'Couverture %',
			'quality.wordsAdded' => 'Mots ajoutés',
			'quality.words' => 'Mots',
			'quality.coverage' => 'Couverture',
			'quality.scope' => 'Portée',
			'quality.latest' => 'Dernier',
			'quality.added' => 'Ajouté',
			'quality.change' => 'Changement',
			'quality.totalScope' => 'Portée totale',
			'quality.scopeGrowth' => 'Croissance de la portée',
			'quality.range' => 'Plage',
			'quality.aiUsage' => 'Utilisation de l\'IA & Traduction',
			'quality.lastUsed' => ({required Object date}) => 'Dernière utilisation ${date}',
			'quality.noIssuesFound' => 'Aucun problème trouvé dans les dernières comparaisons.',
			'quality.placeholderMismatches' => 'Écarts d\'espaces réservés',
			'quality.placeholderMismatchesDesc' => 'Les marqueurs comme {name} ne correspondent pas.',
			'quality.lengthOutliers' => 'Traductions très courtes ou longues',
			'quality.lengthOutliersDesc' => 'La longueur semble inhabituelle par rapport à la source.',
			'quality.duplicateValues' => 'Valeurs en double',
			'quality.duplicateValuesDesc' => 'La même traduction est utilisée plusieurs fois.',
			'quality.placeholderDialogTitle' => 'Écarts d\'espaces réservés',
			'quality.placeholderDialogDesc' => 'Ces traductions ont des espaces réservés ({name}) différents de la source.',
			'quality.lengthDialogTitle' => 'Écarts de longueur',
			'quality.lengthDialogDesc' => 'Ces traductions sont considérablement plus courtes ou plus longues que la source.',
			'quality.duplicateDialogTitle' => 'Valeurs en double',
			'quality.duplicateDialogDesc' => 'Ces traductions apparaissent plusieurs fois.',
			'quality.duplicateSample' => ({required Object value}) => 'Double : "${value}"',
			'quality.exportError' => 'Impossible de construire le rapport. Veuillez réessayer.',
			'quality.noDataToExport' => 'Aucune donnée à exporter',
			'quality.exportFailed' => 'Échec de l\'exportation',
			'quality.exportDialogTitle' => 'Exporter le rapport qualité',
			'quality.reportSaved' => 'Rapport enregistré',
			'quality.export' => 'Exporter',
			'quality.requests' => 'Requêtes',
			'quality.tokens' => 'Tokens',
			'quality.characters' => 'Caractères',
			'quality.estCost' => 'Coût est.',
			'quality.prompt' => 'Prompt',
			'quality.completion' => 'Complétion',
			'quality.showingCurrentProject' => 'Affichage : Projet actuel',
			'quality.showingAllHistory' => 'Affichage : Tout l\'historique',
			'quality.filesSkipped' => 'Certains fichiers ont été ignorés car ils n\'ont pas été trouvés.',
			'errors.genericError' => 'Une erreur s\'est produite',
			'errors.fileNotFound' => 'Fichier non trouvé',
			'errors.invalidFormat' => 'Format de fichier invalide',
			'errors.parseError' => 'Échec de l\'analyse du fichier',
			'errors.networkError' => 'Erreur réseau. Veuillez vérifier votre connexion.',
			'errors.permissionDenied' => 'Permission refusée',
			'errors.unknownError' => 'Une erreur inconnue s\'est produite',
			'wizards.firstRun.welcome' => 'Bienvenue sur Localizer',
			'wizards.firstRun.description' => 'Comparez vos fichiers de localisation en quelques secondes.',
			'wizards.firstRun.sourceFile' => 'Fichier source',
			'wizards.firstRun.targetFile' => 'Fichier cible',
			'wizards.firstRun.compareNow' => 'Comparer maintenant',
			'wizards.firstRun.trySample' => 'Essayer avec des données d\'exemple',
			'wizards.firstRun.skip' => 'Ignorer la configuration',
			'wizards.firstRun.browse' => 'Cliquez pour parcourir',
			'wizards.firstRun.error' => ({required Object error}) => 'Échec du chargement des données d\'exemple : ${error}',
			'dialogs.addIgnorePattern.title' => 'Ajouter un motif à ignorer',
			'dialogs.addIgnorePattern.patternLabel' => 'Motif (regex)',
			'dialogs.addIgnorePattern.hint' => 'ex: ^temp_.*',
			'dialogs.addIgnorePattern.invalid' => 'Motif regex invalide',
			'dialogs.addIgnorePattern.testStringLabel' => 'Chaîne de test',
			'dialogs.addIgnorePattern.testHint' => 'Entrez une clé pour tester le motif',
			'dialogs.addIgnorePattern.match' => '✓ Le motif correspond à la chaîne de test',
			'dialogs.addIgnorePattern.noMatch' => '✗ Le motif ne correspond pas',
			'dialogs.addIgnorePattern.add' => 'Ajouter',
			'dialogs.addIgnorePattern.cancel' => 'Annuler',
			'dialogs.diffViewer.title' => 'Visionneuse de diff',
			'dialogs.diffViewer.originalFile' => 'Fichier original/référence',
			'dialogs.diffViewer.translationFile' => 'Fichier traduction/comparaison',
			'dialogs.diffViewer.base' => 'BASE',
			'dialogs.diffViewer.target' => 'CIBLE',
			'dialogs.diffViewer.added' => 'Ajouté',
			'dialogs.diffViewer.removed' => 'Supprimé',
			'dialogs.diffViewer.modified' => 'Modifié',
			'dialogs.diffViewer.noMatches' => 'Aucune entrée ne correspond aux filtres actuels',
			'dialogs.diffViewer.clickToggle' => 'Cliquez sur les badges ci-dessus pour activer les filtres',
			'grid.columns.key' => 'Clé',
			'grid.columns.source' => 'Source',
			'grid.columns.status' => 'Statut',
			'grid.columns.actions' => 'Actions',
			'tutorial.skipTutorial' => 'IGNORER LE TUTORIEL',
			'tutorial.finishMessage' => 'Vous êtes prêt ! Appuyez n\'importe où pour terminer.',
			'tutorial.next' => 'Suivant',
			'tutorial.loadSampleData' => 'Charger des données d\'exemple',
			'tutorial.browseSourceFile' => 'Parcourir le fichier source',
			'tutorial.browseTargetFile' => 'Parcourir le fichier cible',
			'tutorial.compareFiles' => 'Comparer les fichiers',
			'tutorial.hintPhase2' => 'Ensuite : filtres, recherche, vue avancée et exportation.',
			'tutorial.steps.importSource.title' => '1. Importer le fichier source',
			'tutorial.steps.importSource.description' => 'Utilisez le bouton ci-dessous pour rechercher un fichier, ou glissez-le & déposez-le sur la zone mise en évidence.',
			'tutorial.steps.importTarget.title' => '2. Importer le fichier cible',
			'tutorial.steps.importTarget.description' => 'Utilisez le bouton ci-dessous pour rechercher un fichier, ou glissez-le & déposez-le sur la zone mise en évidence.',
			'tutorial.steps.compare.title' => '3. Comparer les fichiers',
			'tutorial.steps.compare.description' => 'Appuyez sur le bouton ci-dessous pour lancer la comparaison et voir les résultats.',
			'tutorial.steps.filter.title' => '4. Filtrer les résultats',
			'tutorial.steps.filter.description' => 'Utilisez ces filtres pour voir les chaînes ajoutées, supprimées ou modifiées.',
			'tutorial.steps.search.title' => '5. Rechercher des résultats',
			'tutorial.steps.search.description' => 'Trouvez des clés ou des valeurs spécifiques à l\'aide de la barre de recherche.',
			'tutorial.steps.advanced.title' => '6. Vue avancée',
			'tutorial.steps.advanced.description' => 'Ouvrez la vue détaillée du diff avec l\'édition, la traduction par IA, et plus encore.',
			'tutorial.steps.export.title' => '7. Exporter les résultats',
			'tutorial.steps.export.description' => 'Sauvegardez votre comparaison au format CSV, JSON ou Excel.',
			'friendlyErrors.fileNotFound.message' => 'Le fichier ou le dossier est introuvable.',
			'friendlyErrors.fileNotFound.suggestion' => 'Vérifiez si le fichier a été déplacé ou supprimé.',
			'friendlyErrors.accessDenied.message' => 'L\'accès au fichier a été refusé.',
			'friendlyErrors.accessDenied.suggestion' => 'Essayez de lancer l\'application en tant qu\'administrateur ou vérifiez les permissions du fichier.',
			'friendlyErrors.isDirectory.message' => 'Un dossier a été sélectionné à la place d\'un fichier.',
			'friendlyErrors.isDirectory.suggestion' => 'Veuillez sélectionner un fichier valide.',
			'friendlyErrors.fileAccess.message' => 'Un problème est survenu lors de l\'accès au fichier.',
			'friendlyErrors.fileAccess.suggestion' => 'Essayez de fermer les autres programmes qui pourraient l\'utiliser.',
			'friendlyErrors.unsupportedFormat.message' => 'Ce format de fichier ou cette opération n\'est pas pris en charge.',
			'friendlyErrors.unsupportedFormat.suggestion' => 'Vérifiez l\'extension du fichier ou essayez un format différent.',
			'friendlyErrors.networkError.message' => 'Impossible de se connecter au serveur.',
			'friendlyErrors.networkError.suggestion' => 'Vérifiez votre connexion internet et réessayez.',
			'friendlyErrors.notGitRepo.message' => 'Ce dossier n\'est pas un projet Git.',
			'friendlyErrors.notGitRepo.suggestion' => 'Naviguez vers un dossier contenant un répertoire .git.',
			'friendlyErrors.mergeConflict.message' => 'Il y a des conflits de fusion dans le dépôt.',
			'friendlyErrors.mergeConflict.suggestion' => 'Résolvez les conflits avant de continuer.',
			'friendlyErrors.gitAuthFailed.message' => 'L\'authentification Git a échoué.',
			'friendlyErrors.gitAuthFailed.suggestion' => 'Vérifiez vos identifiants dans Paramètres > Gestion de versions.',
			'friendlyErrors.gitOperationFailed.message' => 'Une opération Git a échoué.',
			'friendlyErrors.gitOperationFailed.suggestion' => 'Vérifiez la vue Git pour plus de détails.',
			'friendlyErrors.invalidJson.message' => 'Le format du fichier est invalide ou corrompu.',
			'friendlyErrors.invalidJson.suggestion' => 'Assurez-vous que le fichier contient un contenu JSON valide.',
			'friendlyErrors.rateLimitReached.message' => 'Limite de traduction atteinte.',
			'friendlyErrors.rateLimitReached.suggestion' => 'Attendez quelques minutes ou vérifiez les limites de votre plan API.',
			'friendlyErrors.invalidApiKey.message' => 'Clé API invalide.',
			'friendlyErrors.invalidApiKey.suggestion' => 'Allez dans Paramètres > Traduction par IA pour mettre à jour votre clé API.',
			'friendlyErrors.translationServiceError.message' => 'Erreur du service de traduction.',
			'friendlyErrors.translationServiceError.suggestion' => 'Vérifiez votre clé API et votre connexion internet.',
			'friendlyErrors.outOfMemory.message' => 'Mémoire insuffisante pour terminer cette opération.',
			'friendlyErrors.outOfMemory.suggestion' => 'Essayez de fermer d\'autres applications ou d\'utiliser des fichiers plus petits.',
			'friendlyErrors.genericError.message' => 'Un problème est survenu.',
			'friendlyErrors.genericError.suggestion' => 'Veuillez réessayer. Si le problème persiste, redémarrez l\'application.',
			'systemTray.showLocalizer' => 'Afficher Localizer',
			'systemTray.exit' => 'Quitter',
			'validation.connected' => 'Connecté.',
			'validation.connectionTimeout' => 'Délai de connexion dépassé. Veuillez réessayer.',
			'validation.couldNotConnect' => 'Impossible de se connecter. Veuillez réessayer.',
			'validation.checkKeyAndTryAgain' => 'Impossible de se connecter. Veuillez vérifier la clé et réessayer.',
			'validation.tryAgainLater' => 'Impossible de se connecter pour le moment. Veuillez réessayer plus tard.',
			'validation.serviceUnavailable' => 'Le service est indisponible pour le moment. Veuillez réessayer plus tard.',
			'validation.enterKeyFirst' => 'Veuillez d\'abord entrer une clé.',
			'validation.checking' => 'Vérification...',
			'validation.deeplUsage' => ({required Object used, required Object limit}) => 'Utilisation : ${used} / ${limit} caractères.',
			'status.startingComparison' => 'Démarrage de la comparaison...',
			'status.loadingFromHistory' => 'Chargement des fichiers depuis l\'historique...',
			'status.comparisonComplete' => 'Comparaison terminée',
			'status.couldNotImportFiles' => 'Impossible d\'importer les fichiers. Veuillez réessayer.',
			'status.historyFilesNotFound' => 'L\'un des fichiers ou les deux de l\'historique sont introuvables aux emplacements d\'origine.',
			'aiServices.geminiEmptyResponse' => 'Gemini a renvoyé une réponse vide',
			'aiServices.geminiStreamingEmpty' => 'Le streaming Gemini a renvoyé une réponse vide',
			'aiServices.geminiRephraseEmpty' => 'Gemini a renvoyé une réponse vide pour la reformulation',
			'aiServices.openaiEmptyResponse' => 'OpenAI a renvoyé une réponse vide ou a échoué',
			_ => null,
		};
	}
}
