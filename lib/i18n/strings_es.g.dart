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
class TranslationsEs
    with BaseTranslations<AppLocale, Translations>
    implements Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsEs(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.es,
              overrides: overrides ?? {},
              cardinalResolver: cardinalResolver,
              ordinalResolver: ordinalResolver,
            ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <es>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final TranslationsEs _root = this; // ignore: unused_field

  @override
  TranslationsEs $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsEs(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsAppEs app = _TranslationsAppEs._(_root);
  @override
  late final _TranslationsCommonEs common = _TranslationsCommonEs._(_root);
  @override
  late final _TranslationsMenuEs menu = _TranslationsMenuEs._(_root);
  @override
  late final _TranslationsNavEs nav = _TranslationsNavEs._(_root);
  @override
  late final _TranslationsSettingsEs settings =
      _TranslationsSettingsEs._(_root);
  @override
  late final _TranslationsFileComparisonEs fileComparison =
      _TranslationsFileComparisonEs._(_root);
  @override
  late final _TranslationsDirectoryComparisonEs directoryComparison =
      _TranslationsDirectoryComparisonEs._(_root);
  @override
  late final _TranslationsGitComparisonEs gitComparison =
      _TranslationsGitComparisonEs._(_root);
  @override
  late final _TranslationsAdvancedComparisonEs advancedComparison =
      _TranslationsAdvancedComparisonEs._(_root);
  @override
  late final _TranslationsAdvancedDiffEs advancedDiff =
      _TranslationsAdvancedDiffEs._(_root);
  @override
  late final _TranslationsIssueDetailsEs issueDetails =
      _TranslationsIssueDetailsEs._(_root);
  @override
  late final _TranslationsImportReviewEs importReview =
      _TranslationsImportReviewEs._(_root);
  @override
  late final _TranslationsHistoryViewEs historyView =
      _TranslationsHistoryViewEs._(_root);
  @override
  late final _TranslationsCompareEs compare = _TranslationsCompareEs._(_root);
  @override
  late final _TranslationsHistoryEs history = _TranslationsHistoryEs._(_root);
  @override
  late final _TranslationsProjectsEs projects =
      _TranslationsProjectsEs._(_root);
  @override
  late final _TranslationsDiffEs diff = _TranslationsDiffEs._(_root);
  @override
  late final _TranslationsGitEs git = _TranslationsGitEs._(_root);
  @override
  late final _TranslationsQualityEs quality = _TranslationsQualityEs._(_root);
  @override
  late final _TranslationsErrorsEs errors = _TranslationsErrorsEs._(_root);
  @override
  late final _TranslationsWizardsEs wizards = _TranslationsWizardsEs._(_root);
  @override
  late final _TranslationsDialogsEs dialogs = _TranslationsDialogsEs._(_root);
  @override
  late final _TranslationsGridEs grid = _TranslationsGridEs._(_root);
  @override
  late final _TranslationsTutorialEs tutorial =
      _TranslationsTutorialEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsEs friendlyErrors =
      _TranslationsFriendlyErrorsEs._(_root);
  @override
  late final _TranslationsSystemTrayEs systemTray =
      _TranslationsSystemTrayEs._(_root);
  @override
  late final _TranslationsValidationEs validation =
      _TranslationsValidationEs._(_root);
  @override
  late final _TranslationsStatusEs status = _TranslationsStatusEs._(_root);
  @override
  late final _TranslationsAiServicesEs aiServices =
      _TranslationsAiServicesEs._(_root);
}

// Path: app
class _TranslationsAppEs implements TranslationsAppEn {
  _TranslationsAppEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Herramienta de Comparación de Localización';
  @override
  String get name => 'Localizer';
}

// Path: common
class _TranslationsCommonEs implements TranslationsCommonEn {
  _TranslationsCommonEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get save => 'Guardar';
  @override
  String get cancel => 'Cancelar';
  @override
  String get close => 'Cerrar';
  @override
  String get delete => 'Eliminar';
  @override
  String get edit => 'Editar';
  @override
  String get add => 'Añadir';
  @override
  String get search => 'Buscar';
  @override
  String get undo => 'Deshacer';
  @override
  String get loading => 'Cargando...';
  @override
  String get error => 'Error';
  @override
  String get success => 'Éxito';
  @override
  String get warning => 'Advertencia';
  @override
  String get info => 'Información';
  @override
  String get confirm => 'Confirmar';
  @override
  String get yes => 'Sí';
  @override
  String get no => 'No';
  @override
  String get ok => 'Aceptar';
  @override
  String get retry => 'Reintentar';
  @override
  String get copyText => 'Copiar';
  @override
  String get appName => 'Localizer';
  @override
  String get copied => '¡Copiado!';
  @override
  String get enabled => 'Habilitado';
  @override
  String get disabled => 'Deshabilitado';
  @override
  String get browse => 'Examinar';
  @override
  String get clear => 'Limpiar';
  @override
  String get apply => 'Aplicar';
  @override
  String get reset => 'Restablecer';
  @override
  String get refresh => 'Actualizar';
  @override
  String get export => 'Exportar';
  @override
  String get import => 'Importar';
  @override
  String get select => 'Seleccionar';
  @override
  String get selectAll => 'Seleccionar todo';
  @override
  String get deselectAll => 'Deselect. todo';
  @override
  String get noResults => 'No se encontraron resultados';
  @override
  String get emptyState => 'No hay nada aquí todavía';
  @override
  String get open => 'Abrir';
  @override
  String get change => 'Cambiar';
  @override
  String get original => 'Original';
  @override
  String get kNew => 'Nuevo';
  @override
  String get remove => 'Quitar';
  @override
  String get auto => 'Auto';
  @override
  String get execute => 'Ejecutar';
  @override
  String get run => 'Ejecutar';
  @override
  String get unknown => 'Desconocido';
  @override
  String get download => 'Descargar';
  @override
  String get dropdownArrow => 'Flecha desplegable';
  @override
  String get openInNewWindow => 'Abrir en nueva ventana';
  @override
  String get resetToDefaults => 'Restaurar valores por defecto';
}

// Path: menu
class _TranslationsMenuEs implements TranslationsMenuEn {
  _TranslationsMenuEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get file => 'Archivo';
  @override
  String get edit => 'Editar';
  @override
  String get view => 'Ver';
  @override
  String get help => 'Ayuda';
  @override
  String get openFiles => 'Abrir archivos...';
  @override
  String get openFolder => 'Abrir carpeta...';
  @override
  String get exportResults => 'Exportar resultados...';
  @override
  String get undo => 'Deshacer';
  @override
  String get redo => 'Rehacer';
  @override
  String get cut => 'Cortar';
  @override
  String get paste => 'Pegar';
  @override
  String get selectAll => 'Seleccionar todo';
  @override
  String get zoomIn => 'Acercar';
  @override
  String get zoomOut => 'Alejar';
  @override
  String get resetZoom => 'Restablecer zoom';
  @override
  String get documentation => 'Documentación';
  @override
  String get reportIssue => 'Informar un problema';
  @override
  String about({required Object appName}) => 'Acerca de ${appName}';
}

// Path: nav
class _TranslationsNavEs implements TranslationsNavEn {
  _TranslationsNavEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get compare => 'Comparar';
  @override
  String get history => 'Historial';
  @override
  String get settings => 'Ajustes';
  @override
  String get projects => 'Proyectos';
  @override
  String get dashboard => 'Panel';
  @override
  String get directory => 'Directorio';
  @override
  String get repository => 'Repositorio';
  @override
  String get tooltipCompare => 'Comparar archivos de localización';
  @override
  String get tooltipHistory => 'Ver historial de comparaciones';
  @override
  String get tooltipSettings => 'Ajustes de la aplicación';
  @override
  String get tooltipProjects => 'Gestionar proyectos';
  @override
  String get tooltipThemeToggle => 'Alternar tema';
  @override
  String get tooltipDebugConsole => 'Consola de depuración';
}

// Path: settings
class _TranslationsSettingsEs implements TranslationsSettingsEn {
  _TranslationsSettingsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Configuración';
  @override
  String get appSettings => 'Ajustes de la App';
  @override
  String get projectSettings => 'Ajustes del Proyecto';
  @override
  late final _TranslationsSettingsAppearanceEs appearance =
      _TranslationsSettingsAppearanceEs._(_root);
  @override
  late final _TranslationsSettingsGeneralEs general =
      _TranslationsSettingsGeneralEs._(_root);
  @override
  late final _TranslationsSettingsScopeEs scope =
      _TranslationsSettingsScopeEs._(_root);
  @override
  late final _TranslationsSettingsSearchKeywordsEs searchKeywords =
      _TranslationsSettingsSearchKeywordsEs._(_root);
  @override
  late final _TranslationsSettingsComparisonEs comparison =
      _TranslationsSettingsComparisonEs._(_root);
  @override
  late final _TranslationsSettingsFileHandlingEs fileHandling =
      _TranslationsSettingsFileHandlingEs._(_root);
  @override
  late final _TranslationsSettingsTranslationMemoryEs translationMemory =
      _TranslationsSettingsTranslationMemoryEs._(_root);
  @override
  late final _TranslationsSettingsBackupEs backup =
      _TranslationsSettingsBackupEs._(_root);
  @override
  late final _TranslationsSettingsAiEs ai = _TranslationsSettingsAiEs._(_root);
  @override
  late final _TranslationsSettingsIntegrationsEs integrations =
      _TranslationsSettingsIntegrationsEs._(_root);
  @override
  late final _TranslationsSettingsDeveloperEs developer =
      _TranslationsSettingsDeveloperEs._(_root);
  @override
  late final _TranslationsSettingsAboutEs about =
      _TranslationsSettingsAboutEs._(_root);
  @override
  late final _TranslationsSettingsOnboardingEs onboarding =
      _TranslationsSettingsOnboardingEs._(_root);
  @override
  late final _TranslationsSettingsSettingsViewEs settingsView =
      _TranslationsSettingsSettingsViewEs._(_root);
}

// Path: fileComparison
class _TranslationsFileComparisonEs implements TranslationsFileComparisonEn {
  _TranslationsFileComparisonEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Comparar Archivos';
  @override
  String get openFiles => 'Abrir Archivos';
  @override
  String get exportResults => 'Exportar Resultados';
  @override
  String get restartTutorial => 'Reiniciar Tutorial';
  @override
  String get restartTutorialDevOnly =>
      'El reinicio del tutorial solo está disponible en modo desarrollador.';
  @override
  String get unsupportedFileType => 'Tipo de archivo no soportado.';
  @override
  String get unsupportedFileTypeSuggestion =>
      'Por favor, selecciona un archivo de localización soportado.';
  @override
  String get someFilesUnsupported => 'Algunos archivos no son soportados.';
  @override
  String get pickSupportedFiles =>
      'Elige solo archivos de localización soportados.';
  @override
  String get pickTwoFiles => 'Elige dos archivos para comparar.';
  @override
  String get pickBilingualFile =>
      'Por favor selecciona un archivo bilingüe para comparar.';
  @override
  String get noResultsToExport => 'No hay resultados para exportar aún.';
  @override
  String get performComparisonFirst =>
      'Realiza una comparación primero para exportar resultados.';
  @override
  String get performComparisonFirstEditor =>
      'Por favor realiza una comparación primero para ver detalles avanzados.';
  @override
  String get sampleDataLoaded => 'Datos de ejemplo cargados con éxito';
  @override
  String loadSampleDataError({required Object error}) =>
      'Fallo al cargar datos de ejemplo: ${error}';
  @override
  String get invalidFileType => 'Tipo de archivo inválido.';
  @override
  String fileSelected({required Object label, required Object fileName}) =>
      '${label} seleccionado: ${fileName}';
  @override
  String get sourceFile => 'Archivo origen';
  @override
  String get targetFile => 'Archivo destino';
  @override
  String get bilingualFile => 'Archivo bilingüe';
  @override
  String get compareFiles => 'Comparar Archivos';
  @override
  String get compareFile => 'Comparar Archivo';
  @override
  String get bilingualMode => 'Modo Bilingüe';
  @override
  String get twoFilesMode => 'Dos Archivos';
  @override
  String get processing => 'Procesando...';
  @override
  String remaining({required Object time}) => '${time} restantes';
  @override
  String get comparisonInProgress => 'Comparación en progreso...';
  @override
  String comparisonFailed({required Object error}) =>
      'Comparación Fallida: ${error}';
  @override
  String fileChanged({required Object fileName}) =>
      'Archivo cambiado: ${fileName}. Recomparando...';
  @override
  String get dropFileHere => 'Suelta archivo aquí';
  @override
  String get dropFileOrBrowse => 'Suelta archivo o clic para examinar';
  @override
  String get fileUpload => 'Subir archivo';
  @override
  String get changeFile => 'Cambiar archivo';
  @override
  String get total => 'Total';
  @override
  String get show => 'Mostrar';
  @override
  String get showAll => 'Mostrar Todo';
  @override
  String noMatches({required Object query}) =>
      'No hay coincidencias para "${query}"';
  @override
  String showingEntries({required Object count, required Object total}) =>
      'Mostrando ${count} de ${total} entradas';
  @override
  String get filesIdentical => 'Los archivos son idénticos.';
  @override
  String hiddenIdentical({required Object count}) =>
      '${count} entradas idénticas ocultas';
  @override
  String get showIdentical => 'Mostrar Entradas Idénticas';
  @override
  String get hideIdentical => 'Ocultar entradas idénticas';
  @override
  String get noDiff => 'No se encontraron diferencias basadas en claves.';
  @override
  String get source => 'Origen';
  @override
  String get target => 'Destino';
  @override
  String get value => 'Valor';
  @override
  String get readyToCompare => 'Listo para Comparar Archivos';
  @override
  String get readyToCompareDesc =>
      'Suelta archivos de localización arriba o usa los botones\npara seleccionar archivos para comparar.';
  @override
  String get recentComparisons => 'Comparaciones Recientes';
  @override
  String bilingualFileLabel({required Object name}) =>
      'Archivo bilingüe: ${name}';
  @override
  String comparisonLabel({required Object source, required Object target}) =>
      '${source} ↔ ${target}';
  @override
  String get fileNotExist =>
      'Uno o ambos archivos de esta sesión ya no existen.';
  @override
  String get largeFileTitle => 'Archivo Grande Detectado';
  @override
  String largeFileContent({required Object count}) =>
      'El resultado de la comparación contiene ${count} entradas.\nMostrar todas podría causar problemas de rendimiento.\n\n¿Quieres continuar?';
  @override
  String get dontShowAgain => 'No mostrar de nuevo para este archivo';
  @override
  String get proceed => 'Proceder';
  @override
  String exportReport({required Object format}) => 'Guardar Informe ${format}';
  @override
  String saved({required Object format}) => '${format} guardado';
  @override
  String saveError({required Object format}) =>
      'Fallo al guardar archivo ${format}.';
  @override
  String saveErrorDetailed({required Object format, required Object error}) =>
      'Fallo al guardar ${format}: ${error}';
  @override
  String get watching => 'Observando';
  @override
  String get watchOff => 'Obs. Apagada';
  @override
  String watchingTooltip({required Object status}) =>
      'Observación de Archivos: ${status}\nRecomparar automáticamente cuando los archivos cambien en disco';
  @override
  String get aiSettingsNotAvailable => 'Navegación a Ajustes IA no disponible';
}

// Path: directoryComparison
class _TranslationsDirectoryComparisonEs
    implements TranslationsDirectoryComparisonEn {
  _TranslationsDirectoryComparisonEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Comparar Directorios';
  @override
  String get sourceDirectory => 'Directorio Origen';
  @override
  String get targetDirectory => 'Directorio Destino';
  @override
  String get sourceSubtitle => 'Archivos Originales/Referencia';
  @override
  String get targetSubtitle => 'Archivos Traducción/Comparación';
  @override
  String get selectBothDirectories =>
      'Por favor selecciona ambos directorios origen y destino.';
  @override
  String get selectSourceFolder => 'Seleccionar Carpeta Origen';
  @override
  String get selectTargetFolder => 'Seleccionar Carpeta Destino';
  @override
  String get dropFolderHere => 'Suelta carpeta aquí o examina...';
  @override
  String get folderPath => 'Ruta de Carpeta';
  @override
  String get readyToCompare => 'Listo para Comparar Directorios';
  @override
  String get readyToCompareDesc =>
      'Suelta carpetas arriba o usa los botones\npara seleccionar directorios para comparar.';
  @override
  String get nestedFolders => 'Carpetas Anidadas';
  @override
  String get nestedFoldersTooltip => 'Compara recursivamente subdirectorios';
  @override
  String get fileMatching => 'Emparejamiento';
  @override
  String get fileMatchingTooltip => 'Empareja archivos por nombre';
  @override
  String get bulkExport => 'Exportar Lote';
  @override
  String get bulkExportTooltip => 'Exportar todos los resultados a la vez';
  @override
  String get notDirectoryComparison =>
      'Esto no es una comparación de directorios.';
  @override
  String get directoriesNotExist => 'Uno o ambos directorios ya no existen.';
  @override
  String get errorOccurred => 'Ocurrió un error';
  @override
  String get noFilesFound => 'No se encontraron archivos en los directorios.';
  @override
  String get unmatchedSourceFiles => 'Archivos Origen Sin Pareja';
  @override
  String get unmatchedTargetFiles => 'Archivos Destino Sin Pareja';
  @override
  String filePairs({required Object count}) => '${count} pares de archivos';
  @override
  String pairedFiles({required Object count}) =>
      'Archivos Emparejados (${count})';
  @override
  String get view => 'Ver';
  @override
  String get failed => 'Falló';
  @override
  String get pair => 'Emparejar...';
  @override
  String pairDialogTitle({required Object name}) => 'Emparejar "${name}" con:';
  @override
  String get discoverFiles => 'Descubrir Archivos';
  @override
  String get compareAll => 'Comparar Todo';
  @override
  String get exportAll => 'Exportar Todo';
  @override
  String get comparisonStarted => 'Comparación iniciada...';
  @override
  String get discoveringFiles => 'Descubriendo archivos...';
  @override
  String get noResultsToExport =>
      'Sin resultados para exportar. Ejecuta "Comparar Todo".';
  @override
  String get selectExportFolder => 'Seleccionar Carpeta Exportación';
  @override
  String createExportFolderError({required Object error}) =>
      'Fallo al crear carpeta exportación: ${error}';
  @override
  String get exportingResults => 'Exportando Resultados';
  @override
  String processingFile({required Object file}) => 'Procesando: ${file}';
  @override
  String exportProgress({required Object current, required Object total}) =>
      '${current} of ${total} archivos exportados';
  @override
  String get exportComplete => 'Exportación Completa';
  @override
  String exportSuccessMessage({required Object count}) =>
      'Exportados ${count} archivos de comparación más resumen.';
  @override
  String exportFailed({required Object error}) => 'Fallo exportación: ${error}';
  @override
  String get close => 'Cerrar';
}

// Path: gitComparison
class _TranslationsGitComparisonEs implements TranslationsGitComparisonEn {
  _TranslationsGitComparisonEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.';
  @override
  String get title => 'Comparación de Repositorio';
  @override
  String get repoSelector => 'Crear / Abrir Repositorio';
  @override
  String get noRepoSelected => 'Ningún repositorio seleccionado';
  @override
  String get open => 'Abrir';
  @override
  String get refreshCommits => 'Actualizar Commits';
  @override
  String get noCommits =>
      'No se encontraron commits o no se cargaron. Selecciona una rama para cargar commits.';
  @override
  String get baseCommit => 'Commit Base (Más antiguo)';
  @override
  String get targetCommit => 'Commit Destino (Más nuevo)';
  @override
  String get filterCommitsByBranch => 'Filtrar Commits por Branch';
  @override
  String get conflictDetection => 'Detección de conflictos';
  @override
  String get conflictDetectionTooltip =>
      'Detectar y resolver conflictos de merge';
  @override
  String get actions => 'Acciones:';
  @override
  String get checkout => 'Checkout';
  @override
  String get merge => 'Merge';
  @override
  String get pull => 'Pull';
  @override
  String get checkoutBranch => 'Hacer Checkout a Branch';
  @override
  String get mergeBranch => 'Hacer Merge de Branch en Actual';
  @override
  String mergeConfirmation({required Object branch}) => '¿Merge ${branch}?';
  @override
  String get mergeWarning =>
      'Esto hará merge de los cambios en tu rama de trabajo actual. Pueden ocurrir conflictos.';
  @override
  String get selectExportFolder => 'Seleccionar Carpeta Exportación';
  @override
  String createExportFolderError({required Object error}) =>
      'Fallo al crear carpeta exportación: ${error}';
  @override
  String get exportingFiles => 'Exportando Archivos';
  @override
  String processingFile({required Object file}) => 'Procesando: ${file}';
  @override
  String exportProgress({required Object current, required Object total}) =>
      '${current} de ${total} archivos exportados';
  @override
  String get exportComplete => 'Exportación Completa';
  @override
  String exportSuccessMessage({required Object count}) =>
      'Exportados con éxito ${count} archivos con contenido completo.';
  @override
  String get exportDetail =>
      'El diff de cada archivo se guarda en la subcarpeta "files".';
  @override
  String get diffViewer => 'Visor de Diff';
  @override
  String get base => 'BASE';
  @override
  String get target => 'DESTINO';
  @override
  String get noLines => 'Sin líneas para mostrar';
  @override
  String get searchFiles => 'Buscar archivos...';
  @override
  String noFilesMatch({required Object query}) =>
      'Ningún archivo coincide con "${query}"';
  @override
  String filesCount({required Object count}) => '${count} archivos';
  @override
  String get selectBaseFile => 'Seleccionar Archivo Base';
  @override
  String get selectTargetFile => 'Seleccionar Archivo Destino';
  @override
  String get comparisonResults => 'Resultados de Comparación';
  @override
  String get noChanges =>
      'No se encontraron cambios entre las refs seleccionadas.';
  @override
  String get linesAdded => 'Líneas Añadidas';
  @override
  String get linesRemoved => 'Líneas Eliminadas';
  @override
  String get commit => 'Commit';
  @override
  String get branch => 'Branch';
  @override
  String get noRepositorySelected => 'Ningún repositorio seleccionado';
  @override
  String get notGitComparison => 'No es una comparación Git';
  @override
  String get repositoryNotExist => 'El repositorio no existe';
  @override
  String get mainBranch => 'main';
  @override
  String get masterBranch => 'master';
  @override
  String get backToControls => 'Volver a controles de comparación';
}

// Path: advancedComparison
class _TranslationsAdvancedComparisonEs
    implements TranslationsAdvancedComparisonEn {
  _TranslationsAdvancedComparisonEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get placeholder => 'Vista de Comparación Avanzada - Marcador';
}

// Path: advancedDiff
class _TranslationsAdvancedDiffEs implements TranslationsAdvancedDiffEn {
  _TranslationsAdvancedDiffEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get saveAllChanges => '¿Guardar Todos los Cambios?';
  @override
  String saveConfirmation({required Object count}) =>
      'Esto guardará todas las ${count} entradas modificadas al archivo destino. Esta acción no se puede deshacer.';
  @override
  String get changesSaved => 'Cambios guardados con éxito.';
  @override
  String get csvExported => 'CSV exportado';
  @override
  String get unsavedChanges => 'Cambios Sin Guardar';
  @override
  String get unsavedChangesWarning =>
      'Tienes cambios sin guardar. ¿Seguro que quieres descartarlos?';
  @override
  String get discardChanges => 'Descartar Cambios';
  @override
  String get goBack => 'Volver';
  @override
  String get breadcrumbs => 'Inicio > Editor';
  @override
  String unsaved({required Object count}) => '${count} sin guardar';
  @override
  String reviewed({required Object count}) => '${count} revisados';
  @override
  String saveAll({required Object count}) => 'Guardar Todo (${count})';
  @override
  String get allSaved => 'Todo Guardado';
  @override
  String get saveAllTooltip => 'Guardar Todos los Cambios (Ctrl+S)';
  @override
  String get exportTooltip => 'Exportar Datos (Ctrl+E)';
  @override
  late final _TranslationsAdvancedDiffAiSuggestionEs aiSuggestion =
      _TranslationsAdvancedDiffAiSuggestionEs._(_root);
  @override
  late final _TranslationsAdvancedDiffDetailEditEs detailEdit =
      _TranslationsAdvancedDiffDetailEditEs._(_root);
  @override
  late final _TranslationsAdvancedDiffTableEs table =
      _TranslationsAdvancedDiffTableEs._(_root);
  @override
  late final _TranslationsAdvancedDiffDiffRowEs diffRow =
      _TranslationsAdvancedDiffDiffRowEs._(_root);
  @override
  late final _TranslationsAdvancedDiffStatusEs status =
      _TranslationsAdvancedDiffStatusEs._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarEs sidebar =
      _TranslationsAdvancedDiffSidebarEs._(_root);
}

// Path: issueDetails
class _TranslationsIssueDetailsEs implements TranslationsIssueDetailsEn {
  _TranslationsIssueDetailsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Detalles de Problema';
  @override
  String showingIssues({required Object count, required Object total}) =>
      'Mostrando ${count} de ${total} problemas';
  @override
  String get searchPlaceholder => 'Buscar por clave, texto o error...';
  @override
  String get noDetails => 'Sin detalles disponibles.';
  @override
  String get noMatches => 'No hay coincidencias.';
  @override
  String get showMore => 'Mostrar Más';
  @override
  String copyItems({required Object count}) => 'Copiar ${count} Elementos';
  @override
  String get close => 'Cerrar';
  @override
  String get copied => 'Copiado al portapapeles';
  @override
  String copiedCount({required Object count}) => 'Copiados ${count} elementos';
  @override
  late final _TranslationsIssueDetailsDuplicateValueEs duplicateValue =
      _TranslationsIssueDetailsDuplicateValueEs._(_root);
  @override
  late final _TranslationsIssueDetailsLengthOutlierEs lengthOutlier =
      _TranslationsIssueDetailsLengthOutlierEs._(_root);
  @override
  late final _TranslationsIssueDetailsStandardEs standard =
      _TranslationsIssueDetailsStandardEs._(_root);
  @override
  String get review => 'Revisar';
  @override
  late final _TranslationsIssueDetailsTypesEs types =
      _TranslationsIssueDetailsTypesEs._(_root);
  @override
  late final _TranslationsIssueDetailsNotesEs notes =
      _TranslationsIssueDetailsNotesEs._(_root);
  @override
  late final _TranslationsIssueDetailsFallbacksEs fallbacks =
      _TranslationsIssueDetailsFallbacksEs._(_root);
}

// Path: importReview
class _TranslationsImportReviewEs implements TranslationsImportReviewEn {
  _TranslationsImportReviewEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Revisar Importación de Proyecto';
  @override
  String get projectName => 'Nombre de Proyecto';
  @override
  String get created => 'Creado';
  @override
  String get historyItems => 'Elementos de Historial';
  @override
  String get customSettingsTitle => 'Ajustes Personalizados Detectados';
  @override
  String get customSettingsWarning =>
      'Este proyecto contiene ajustes personalizados que sobrescribirán tus valores por defecto mientras esté abierto.';
  @override
  String get standardSettings => 'Este proyecto usa ajustes globales estándar.';
  @override
  String get cancelImport => 'Cancelar Importación';
  @override
  String get trustOpen => 'Confiar y Abrir Proyecto';
}

// Path: historyView
class _TranslationsHistoryViewEs implements TranslationsHistoryViewEn {
  _TranslationsHistoryViewEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Historial de Comparación';
  @override
  String get clearAll => 'Limpiar todo el historial';
  @override
  String get searchPlaceholder => 'Buscar por nombre de archivo...';
  @override
  String get sortBy => 'Ordenar por';
  @override
  String get sortDate => 'Fecha';
  @override
  String get sortSource => 'Archivo Origen';
  @override
  String get sortTarget => 'Archivo Destino';
  @override
  String get showCurrentProject => 'Mostrando: Proyecto Actual';
  @override
  String get showAllHistory => 'Mostrando: Todo el Historial';
  @override
  String get groupByFolder => 'Agrupar por carpeta';
  @override
  String get disableGrouping => 'Deshabilitar agrupación por carpeta';
  @override
  String get filterAll => 'Todo';
  @override
  String get filterFiles => 'Archivos';
  @override
  String get filterDirectories => 'Directorios';
  @override
  String get filterGit => 'Git';
  @override
  String get noHistory => 'Sin historial de comparaciones';
  @override
  String get historyDescription =>
      'Tus comparaciones de archivos aparecerán aquí';
  @override
  String get noResults => 'Sin resultados encontrados';
  @override
  String get adjustSearch => 'Intenta ajustar tu búsqueda';
  @override
  String get clearConfirmationTitle => '¿Limpiar Todo el Historial?';
  @override
  String get clearConfirmationContent =>
      'Esto borrará permanentemente todo el historial de comparación. No se puede deshacer.';
  @override
  String get clearAction => 'Limpiar Todo';
  @override
  String get deletedMessage => 'Elemento de historial eliminado';
  @override
  String get undo => 'Deshacer';
  @override
  String get viewDetails => 'Ver Detalles';
  @override
  String get delete => 'Eliminar';
  @override
  String get openLocation => 'Abrir ubicación de archivo';
  @override
  String get bilingual => 'Bilingüe';
  @override
  String get filePair => 'Par de Archivos';
  @override
  String get directory => 'Directorio';
  @override
  String get git => 'Git';
  @override
  String get repo => 'Repo';
  @override
  String get sourceDir => 'Dir Origen';
  @override
  String get targetDir => 'Dir Destino';
  @override
  String get source => 'Origen';
  @override
  String get target => 'Destino';
  @override
  String get noChanges => 'Sin cambios detectados';
  @override
  String get added => 'Añadido';
  @override
  String get removed => 'Eliminado';
  @override
  String get modified => 'Modificado';
  @override
  String get same => 'Igual';
  @override
  String get total => 'Total';
  @override
  String get currentProject => 'Proyecto Actual';
  @override
  String get unassigned => 'Sin Asignar';
  @override
  String get project => 'Proyecto';
}

// Path: compare
class _TranslationsCompareEs implements TranslationsCompareEn {
  _TranslationsCompareEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Comparar Archivos';
  @override
  String get sourceFile => 'Archivo Origen';
  @override
  String get targetFile => 'Archivo Destino';
  @override
  String get sourceFolder => 'Carpeta Origen';
  @override
  String get targetFolder => 'Carpeta Destino';
  @override
  String get dropFilesHint =>
      'Suelta archivos de localización aquí o usa los botones para seleccionar archivos para comparar.';
  @override
  String get selectSourceFile => 'Seleccionar archivo origen';
  @override
  String get selectTargetFile => 'Seleccionar archivo destino';
  @override
  String get startComparison => 'Iniciar Comparación';
  @override
  String get comparing => 'Comparando...';
  @override
  String get comparisonComplete => 'Comparación completada';
  @override
  String get noChanges => 'Sin cambios detectados';
  @override
  String get filesIdentical => 'Los archivos son idénticos';
  @override
  String changesFound({required Object count}) =>
      'Encontrados ${count} cambios';
  @override
  late final _TranslationsCompareTabsEs tabs =
      _TranslationsCompareTabsEs._(_root);
  @override
  late final _TranslationsCompareFileTypesEs fileTypes =
      _TranslationsCompareFileTypesEs._(_root);
}

// Path: history
class _TranslationsHistoryEs implements TranslationsHistoryEn {
  _TranslationsHistoryEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Historial';
  @override
  String get recentComparisons => 'Comparaciones Recientes';
  @override
  String get noHistory => 'Sin historial de comparaciones';
  @override
  String get noHistoryDescription =>
      'Tu historial de comparación aparecerá aquí';
  @override
  String get clearHistory => 'Limpiar Historial';
  @override
  String get clearHistoryConfirm =>
      '¿Seguro que quieres limpiar todo el historial?';
  @override
  String get deleteEntry => 'Eliminar Entrada';
  @override
  String get openComparison => 'Abrir Comparación';
  @override
  late final _TranslationsHistoryTimeAgoEs timeAgo =
      _TranslationsHistoryTimeAgoEs._(_root);
}

// Path: projects
class _TranslationsProjectsEs implements TranslationsProjectsEn {
  _TranslationsProjectsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Proyectos';
  @override
  String get createProject => 'Crear Proyecto';
  @override
  String get importProject => 'Importar Proyecto';
  @override
  String get noProjects => 'No hay proyectos aún';
  @override
  String get noProjectsDescription =>
      'Crea un proyecto para organizar tus archivos de localización';
  @override
  String get projectName => 'Nombre del Proyecto';
  @override
  String get projectPath => 'Ruta del Proyecto';
  @override
  String get lastOpened => 'Última apertura';
  @override
  String get openProject => 'Abrir Proyecto';
  @override
  String get closeProject => 'Cerrar Proyecto';
  @override
  String get deleteProject => 'Eliminar Proyecto';
  @override
  String get deleteProjectConfirm =>
      '¿Seguro que quieres eliminar este proyecto?';
  @override
  String get exportProject => 'Exportar Proyecto';
  @override
  String get exportDescription =>
      'Crea un archivo zip portable que contenga archivos origen, configuración e historial.';
  @override
  String get exporting => 'Exportando proyecto...';
  @override
  String get exportSuccess => 'Proyecto exportado';
  @override
  String exportError({required Object error}) => 'Fallo al exportar: ${error}';
  @override
  String get createNewProject => 'Crear Nuevo Proyecto';
  @override
  String get openExistingProject => 'Abrir Proyecto Existente';
  @override
  String get importProjectZip => 'Importar Zip de Proyecto';
  @override
  String get projectResources => 'Recursos del Proyecto';
  @override
  String get recentProjects => 'Proyectos Recientes';
  @override
  String get noRecentProjects => 'Sin proyectos recientes';
  @override
  String get selectProjectZip => 'Seleccionar Zip de Proyecto';
  @override
  String get selectDestination =>
      'Seleccionar Carpeta de Destino para Importación';
  @override
  String get importing => 'Importando proyecto...';
  @override
  String get importSuccess => 'Proyecto importado con éxito';
  @override
  String importFailed({required Object error}) =>
      'Importación fallida: ${error}';
  @override
  String get importingFiles => 'Importando archivos...';
  @override
  String get noSupportedFiles => 'No se soltaron archivos soportados.';
  @override
  late final _TranslationsProjectsStatsEs stats =
      _TranslationsProjectsStatsEs._(_root);
  @override
  String get openProjectFirst =>
      'Abre un proyecto primero para gestionar sus recursos.';
  @override
  String get removeFromRecent => 'Eliminar de recientes';
  @override
  late final _TranslationsProjectsSelectionEs selection =
      _TranslationsProjectsSelectionEs._(_root);
  @override
  late final _TranslationsProjectsCreateDialogEs createDialog =
      _TranslationsProjectsCreateDialogEs._(_root);
  @override
  late final _TranslationsProjectsIndicatorEs indicator =
      _TranslationsProjectsIndicatorEs._(_root);
  @override
  late final _TranslationsProjectsGlossaryEs glossary =
      _TranslationsProjectsGlossaryEs._(_root);
  @override
  late final _TranslationsProjectsConflictsEs conflicts =
      _TranslationsProjectsConflictsEs._(_root);
  @override
  late final _TranslationsProjectsTmEs tm = _TranslationsProjectsTmEs._(_root);
}

// Path: diff
class _TranslationsDiffEs implements TranslationsDiffEn {
  _TranslationsDiffEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'Añadido';
  @override
  String get removed => 'Eliminado';
  @override
  String get modified => 'Modificado';
  @override
  String get unchanged => 'Sin Cambios';
  @override
  String get missing => 'Faltante';
  @override
  String get extra => 'Extra';
  @override
  String get sourceValue => 'Valor Origen';
  @override
  String get targetValue => 'Valor Destino';
  @override
  String get key => 'Clave';
  @override
  String get status => 'Estado';
  @override
  String get actions => 'Acciones';
  @override
  String get copyToTarget => 'Copiar a Destino';
  @override
  String get acceptChange => 'Aceptar Cambio';
  @override
  String get rejectChange => 'Rechazar Cambio';
  @override
  String get viewDetails => 'Ver Detalles';
}

// Path: git
class _TranslationsGitEs implements TranslationsGitEn {
  _TranslationsGitEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Comparación Git';
  @override
  String get selectRepository => 'Seleccionar Repositorio';
  @override
  String get selectBranch => 'Seleccionar Rama';
  @override
  String get selectCommit => 'Seleccionar Commit';
  @override
  String get compareBranches => 'Comparar Ramas';
  @override
  String get compareCommits => 'Comparar Commits';
  @override
  String get baseBranch => 'Rama Base';
  @override
  String get compareBranch => 'Rama Comparar';
  @override
  String get noRepositories => 'No se encontraron repositorios Git';
  @override
  String get noRepositoriesDescription =>
      'Abre una carpeta que contenga un repositorio Git';
  @override
  String filesChanged({required Object count}) => '${count} archivos cambiados';
  @override
  String additions({required Object count}) => '${count} adiciones';
  @override
  String deletions({required Object count}) => '${count} eliminaciones';
  @override
  late final _TranslationsGitConflictsEs conflicts =
      _TranslationsGitConflictsEs._(_root);
}

// Path: quality
class _TranslationsQualityEs implements TranslationsQualityEn {
  _TranslationsQualityEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.';
  @override
  String get title => 'Panel de Calidad';
  @override
  String get overallScore => 'Puntuación General';
  @override
  String get issues => 'Problemas';
  @override
  String get warnings => 'Advertencias';
  @override
  String get suggestions => 'Sugerencias';
  @override
  String get placeholderMismatch => 'Desajuste Marcador';
  @override
  String get placeholderMismatchDescription =>
      'Marcadores como {name} no coinciden entre origen y destino';
  @override
  String get lengthOutlier => 'Longitud Atípica';
  @override
  String get lengthOutlierDescription =>
      'La longitud de traducción difiere significativamente del origen';
  @override
  String get duplicateValue => 'Valor Duplicado';
  @override
  String get duplicateValueDescription =>
      'Misma traducción usada para múltiples claves';
  @override
  String get missingTranslation => 'Traducción Faltante';
  @override
  String get missingTranslationDescription =>
      'Falta la traducción para esta clave';
  @override
  String get loading => 'Cargando panel...';
  @override
  String get errorLoading =>
      'No pudimos cargar tu historial. Intenta de nuevo.';
  @override
  String get emptyState => 'Ejecuta una comparación para ver tu panel.';
  @override
  String get refresh => 'Actualizar';
  @override
  String get buildingInsights => 'Construyendo insights...';
  @override
  String get crunchingNumbers => 'Procesando números...';
  @override
  String get errorBuilding =>
      'No pudimos construir el panel. Intenta de nuevo.';
  @override
  String get noUsableData => 'Aún no se encontraron datos utilizables.';
  @override
  String get languages => 'Idiomas';
  @override
  String get averageCoverage => 'Cobertura media';
  @override
  String get potentialIssues => 'Problemas potenciales';
  @override
  String get translationCoverage => 'Cobertura de traducción';
  @override
  String entriesTranslated(
          {required Object translated, required Object total}) =>
      '${translated} de ${total} entradas traducidas';
  @override
  String get wordsAddedOverTime => 'Palabras añadidas en el tiempo';
  @override
  String get completionVsScope => 'Completado vs Alcance';
  @override
  String get scopeVsProgress => 'Alcance vs Progreso';
  @override
  String get coveragePercent => '% Cobertura';
  @override
  String get wordsAdded => 'Palabras Añadidas';
  @override
  String get words => 'Palabras';
  @override
  String get coverage => 'Cobertura';
  @override
  String get scope => 'Alcance';
  @override
  String get latest => 'Último';
  @override
  String get added => 'Añadido';
  @override
  String get change => 'Cambio';
  @override
  String get totalScope => 'Alcance Total';
  @override
  String wordsCount({required Object count}) => '${count} palabras';
  @override
  String get scopeGrowth => 'Crecimiento Alcance';
  @override
  String get range => 'Rango';
  @override
  String get aiUsage => 'Uso de IA y Traducción';
  @override
  String lastUsed({required Object date}) => 'Último uso ${date}';
  @override
  String get noIssuesFound =>
      'No se encontraron problemas en las últimas comparaciones.';
  @override
  String get placeholderMismatches => 'Desajustes marcadores';
  @override
  String get placeholderMismatchesDesc =>
      'Marcadores como {name} no coinciden.';
  @override
  String get lengthOutliers => 'Traducciones muy cortas o largas';
  @override
  String get lengthOutliersDesc =>
      'La longitud parece inusual comparada con el origen.';
  @override
  String get duplicateValues => 'Valores duplicados';
  @override
  String get duplicateValuesDesc => 'La misma traducción se usa muchas veces.';
  @override
  String get placeholderDialogTitle => 'Desajustes de Marcadores';
  @override
  String get placeholderDialogDesc =>
      'Estas traducciones tienen marcadores diferentes ({name}) al origen.';
  @override
  String get lengthDialogTitle => 'Longitudes Atípicas';
  @override
  String get lengthDialogDesc =>
      'Estas traducciones son significativamente más cortas o largas que el origen.';
  @override
  String get duplicateDialogTitle => 'Valores Duplicados';
  @override
  String get duplicateDialogDesc =>
      'Estas traducciones aparecen múltiples veces.';
  @override
  String duplicateSample({required Object value}) => 'Duplicado: "${value}"';
  @override
  String get exportError =>
      'No se pudo construir el informe. Por favor intenta de nuevo.';
  @override
  String get noDataToExport => 'Sin datos para exportar';
  @override
  String get exportFailed => 'Fallo exportación';
  @override
  String get exportDialogTitle => 'Exportar Informe Calidad';
  @override
  String get reportSaved => 'Informe guardado';
  @override
  String get export => 'Exportar';
  @override
  String get requests => 'Solicitudes';
  @override
  String get tokens => 'Tokens';
  @override
  String get characters => 'Caracteres';
  @override
  String get estCost => 'Coste Est.';
  @override
  String get prompt => 'Prompt';
  @override
  String get completion => 'Completado';
  @override
  String get showingCurrentProject => 'Mostrando: Proyecto Actual';
  @override
  String get showingAllHistory => 'Mostrando: Todo el Historial';
  @override
  String get filesSkipped =>
      'Algunos archivos se saltaron porque no se encontraron.';
  @override
  String charCount({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: '1 carácter',
        other: '${count} caracteres',
      );
  @override
  String lengthDiff(
          {required Object target,
          required Object percent,
          required Object source}) =>
      'Objetivo es ${target} (${percent}%) vs fuente ${source}';
}

// Path: errors
class _TranslationsErrorsEs implements TranslationsErrorsEn {
  _TranslationsErrorsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get genericError => 'Ocurrió un error';
  @override
  String get fileNotFound => 'Archivo no encontrado';
  @override
  String get invalidFormat => 'Formato de archivo inválido';
  @override
  String get parseError => 'Fallo al analizar archivo';
  @override
  String get networkError => 'Error de red. Por favor comprueba tu conexión.';
  @override
  String get permissionDenied => 'Permiso denegado';
  @override
  String get unknownError => 'Ocurrió un error desconocido';
}

// Path: wizards
class _TranslationsWizardsEs implements TranslationsWizardsEn {
  _TranslationsWizardsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsWizardsFirstRunEs firstRun =
      _TranslationsWizardsFirstRunEs._(_root);
}

// Path: dialogs
class _TranslationsDialogsEs implements TranslationsDialogsEn {
  _TranslationsDialogsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDialogsAddIgnorePatternEs addIgnorePattern =
      _TranslationsDialogsAddIgnorePatternEs._(_root);
  @override
  late final _TranslationsDialogsDiffViewerEs diffViewer =
      _TranslationsDialogsDiffViewerEs._(_root);
}

// Path: grid
class _TranslationsGridEs implements TranslationsGridEn {
  _TranslationsGridEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGridColumnsEs columns =
      _TranslationsGridColumnsEs._(_root);
}

// Path: tutorial
class _TranslationsTutorialEs implements TranslationsTutorialEn {
  _TranslationsTutorialEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'SALTAR TUTORIAL';
  @override
  String get finishMessage =>
      '¡Estás listo! Toca en cualquier lugar para terminar.';
  @override
  String get next => 'Siguiente';
  @override
  String get loadSampleData => 'Cargar Datos de Ejemplo';
  @override
  String get browseSourceFile => 'Examinar Archivo Origen';
  @override
  String get browseTargetFile => 'Examinar Archivo Destino';
  @override
  String get compareFiles => 'Comparar Archivos';
  @override
  String get hintPhase2 =>
      'Siguiente: filtros, búsqueda, vista avanzada y exportación.';
  @override
  late final _TranslationsTutorialStepsEs steps =
      _TranslationsTutorialStepsEs._(_root);
}

// Path: friendlyErrors
class _TranslationsFriendlyErrorsEs implements TranslationsFriendlyErrorsEn {
  _TranslationsFriendlyErrorsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsFriendlyErrorsFileNotFoundEs fileNotFound =
      _TranslationsFriendlyErrorsFileNotFoundEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsAccessDeniedEs accessDenied =
      _TranslationsFriendlyErrorsAccessDeniedEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsIsDirectoryEs isDirectory =
      _TranslationsFriendlyErrorsIsDirectoryEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsFileAccessEs fileAccess =
      _TranslationsFriendlyErrorsFileAccessEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsUnsupportedFormatEs unsupportedFormat =
      _TranslationsFriendlyErrorsUnsupportedFormatEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsNetworkErrorEs networkError =
      _TranslationsFriendlyErrorsNetworkErrorEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsNotGitRepoEs notGitRepo =
      _TranslationsFriendlyErrorsNotGitRepoEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsMergeConflictEs mergeConflict =
      _TranslationsFriendlyErrorsMergeConflictEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitAuthFailedEs gitAuthFailed =
      _TranslationsFriendlyErrorsGitAuthFailedEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitOperationFailedEs
      gitOperationFailed =
      _TranslationsFriendlyErrorsGitOperationFailedEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidJsonEs invalidJson =
      _TranslationsFriendlyErrorsInvalidJsonEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsRateLimitReachedEs rateLimitReached =
      _TranslationsFriendlyErrorsRateLimitReachedEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidApiKeyEs invalidApiKey =
      _TranslationsFriendlyErrorsInvalidApiKeyEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsTranslationServiceErrorEs
      translationServiceError =
      _TranslationsFriendlyErrorsTranslationServiceErrorEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsOutOfMemoryEs outOfMemory =
      _TranslationsFriendlyErrorsOutOfMemoryEs._(_root);
  @override
  late final _TranslationsFriendlyErrorsGenericErrorEs genericError =
      _TranslationsFriendlyErrorsGenericErrorEs._(_root);
}

// Path: systemTray
class _TranslationsSystemTrayEs implements TranslationsSystemTrayEn {
  _TranslationsSystemTrayEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get showLocalizer => 'Mostrar Localizer';
  @override
  String get exit => 'Salir';
}

// Path: validation
class _TranslationsValidationEs implements TranslationsValidationEn {
  _TranslationsValidationEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get connected => 'Conectado.';
  @override
  String get connectionTimeout =>
      'Se agotó el tiempo de conexión. Por favor intenta de nuevo.';
  @override
  String get couldNotConnect =>
      'No se pudo conectar. Por favor intenta de nuevo.';
  @override
  String get checkKeyAndTryAgain =>
      'No se pudo conectar. Por favor verifica la clave e intenta de nuevo.';
  @override
  String get tryAgainLater =>
      'No se pudo conectar ahora mismo. Por favor intenta de nuevo más tarde.';
  @override
  String get serviceUnavailable =>
      'El servicio no está disponible ahora mismo. Por favor intenta de nuevo más tarde.';
  @override
  String get enterKeyFirst => 'Por favor introduce una clave primero.';
  @override
  String get checking => 'Comprobando...';
  @override
  String deeplUsage({required Object used, required Object limit}) =>
      'Uso: ${used} / ${limit} caracteres.';
}

// Path: status
class _TranslationsStatusEs implements TranslationsStatusEn {
  _TranslationsStatusEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get startingComparison => 'Iniciando comparación...';
  @override
  String get loadingFromHistory => 'Cargando archivos desde historial...';
  @override
  String get comparisonComplete => 'Comparación completada';
  @override
  String get couldNotImportFiles =>
      'No se pudieron importar los archivos. Por favor intenta de nuevo.';
  @override
  String get historyFilesNotFound =>
      'Uno o ambos archivos del historial no se encontraron en rutas originales.';
}

// Path: aiServices
class _TranslationsAiServicesEs implements TranslationsAiServicesEn {
  _TranslationsAiServicesEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get geminiEmptyResponse => 'Gemini devolvió respuesta vacía';
  @override
  String get geminiStreamingEmpty =>
      'Gemini streaming devolvió respuesta vacía';
  @override
  String get geminiRephraseEmpty =>
      'Gemini devolvió respuesta vacía para refraseo';
  @override
  String get openaiEmptyResponse => 'OpenAI devolvió respuesta vacía o fallida';
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceEs
    implements TranslationsSettingsAppearanceEn {
  _TranslationsSettingsAppearanceEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Apariencia';
  @override
  String get description => 'Personaliza el aspecto de la aplicación';
  @override
  String get theme => 'Modo de Tema';
  @override
  String get themeDescription => 'Elige entre claro, oscuro o sistema';
  @override
  String get themeSystem => 'Sistema';
  @override
  String get themeLight => 'Claro';
  @override
  String get themeDark => 'Oscuro';
  @override
  String get themeAmoled => 'AMOLED';
  @override
  String get accentColor => 'Color de Acento';
  @override
  String get accentColorDescription => 'Elige tu color de acento preferido';
  @override
  String get useMicaEffect => 'Usar Efecto Mica';
  @override
  String get micaDescription =>
      'Habilita transparencia Mica de Windows 11 para un look moderno';
  @override
  String get diffFontSize => 'Tamaño Fuente Diff';
  @override
  String get diffFontSizeDescription =>
      'Ajusta el tamaño de fuente de la vista de comparación';
  @override
  String get diffFontFamily => 'Fuente Diff';
  @override
  String get diffFontFamilyDescription => 'Fuente para la vista de comparación';
  @override
  String get systemDefault => 'Sistema';
  @override
  String get pickAccentColor => 'Elegir Color';
  @override
  String get diffColors => 'Colores Diff';
  @override
  String get presetsTitle => 'Preajustes';
  @override
  late final _TranslationsSettingsAppearancePresetsEs presets =
      _TranslationsSettingsAppearancePresetsEs._(_root);
  @override
  String get identical => 'Idéntico';
  @override
  String pickColorFor({required Object label}) => 'Elegir Color para ${label}';
  @override
  String get livePreview => 'Vista Previa';
  @override
  late final _TranslationsSettingsAppearancePreviewEs preview =
      _TranslationsSettingsAppearancePreviewEs._(_root);
}

// Path: settings.general
class _TranslationsSettingsGeneralEs implements TranslationsSettingsGeneralEn {
  _TranslationsSettingsGeneralEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'General';
  @override
  String get description => 'Configuración general de la aplicación';
  @override
  String get language => 'Idioma';
  @override
  String get languageDescription => 'Elige tu idioma preferido';
  @override
  String get startMinimized => 'Iniciar Minimizado';
  @override
  String get startMinimizedDescription =>
      'Iniciar la app minimizada en la bandeja';
  @override
  String get rememberWindowPosition => 'Recordar Posición';
  @override
  String get rememberWindowPositionDescription =>
      'Restaurar tamaño y posición al iniciar';
  @override
  String get openLastProject => 'Abrir Último Proyecto';
  @override
  String get openLastProjectDescription =>
      'Abrir automáticamente el último proyecto usado';
  @override
  String get application => 'Aplicación';
  @override
  String get defaultView => 'Vista Por Defecto';
  @override
  String get defaultViewDescription => 'Vista a mostrar al inicio';
  @override
  String get autoCheckUpdates => 'Buscar Actualizaciones';
  @override
  String get autoCheckUpdatesDescription =>
      'Buscar actualizaciones al arrancar';
  @override
  String get startupOptions => 'Opciones de Inicio';
  @override
  String get languageAuto => 'Auto-Detectar';
  @override
  String get viewBasic => 'Comparación de Archivos';
  @override
  String get viewHistory => 'Historial';
  @override
  String get viewDashboard => 'Panel de Calidad';
  @override
  String get viewDirectory => 'Comparación de Directorios';
  @override
  String get viewLastUsed => 'Última Usada';
}

// Path: settings.scope
class _TranslationsSettingsScopeEs implements TranslationsSettingsScopeEn {
  _TranslationsSettingsScopeEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Alcance de Ajustes';
  @override
  String get global => 'Valores Globales';
  @override
  String get project => 'Proyecto';
  @override
  String get reset => 'Restaurar Proyecto a Global';
  @override
  String get resetConfirmation =>
      'Esto borrará todas las anulaciones para este proyecto y volverá a los valores globales. Esta acción no se puede deshacer.';
  @override
  String get globalDescription =>
      'Los cambios se aplican a todos los proyectos salvo que se anulen.';
  @override
  String projectDescription({required Object name}) =>
      'Los cambios se aplican solo a "${name}". Otros ajustes heredan de los valores globales.';
  @override
  String get createPrompt =>
      'Crea un proyecto para personalizar ajustes en carpetas específicas';
}

// Path: settings.searchKeywords
class _TranslationsSettingsSearchKeywordsEs
    implements TranslationsSettingsSearchKeywordsEn {
  _TranslationsSettingsSearchKeywordsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  List<String> get general => [
        'Idioma',
        'Vista Por Defecto',
        'Archivos Recientes',
        'Abrir Último Proyecto',
        'Confirmar Salida',
        'Mostrar Notificaciones',
      ];
  @override
  List<String> get comparisonEngine => [
        'Modo Comparación',
        'Umbral Similitud',
        'Sensible a Mayús/Minús',
        'Ignorar Espacios',
        'Ignorar Líneas Vacías',
        'Ignorar Comentarios',
        'Patrones a Ignorar',
      ];
  @override
  List<String> get appearance => [
        'Tema',
        'Modo Tema',
        'Color Acento',
        'Tamaño Fuente Diff',
        'Fuente Diff',
        'Colores Diff',
        'Color Añadido',
        'Color Eliminado',
        'Color Modificado',
        'Color Idéntico',
        'Preajustes Color',
        'Vista Previa',
      ];
  @override
  List<String> get fileHandling => [
        'Formato Origen',
        'Formato Destino',
        'Codificación Por Defecto',
        'Proyectos Recientes',
        'Memoria Traducción',
        'Importar Memoria',
        'Exportar Memoria',
        'Limpiar Memoria',
      ];
  @override
  List<String> get aiServices => [
        'Clave API OpenAI',
        'Clave API Anthropic',
        'Clave API Google AI',
        'Modelo IA',
        'Temperatura',
        'Prompt Personalizado',
      ];
  @override
  List<String> get systemIntegrations => [
        'Bandeja Sistema',
        'Iniciar Minimizado',
        'Asociaciones Archivo',
        'Efecto Mica',
        'Vibrancy',
        'Material Ventana',
        'Insignia Dock',
        'Contador No Traducido',
      ];
  @override
  List<String> get projectResources => [
        'Glosario',
        'Memoria Traducción',
        'Terminología',
      ];
  @override
  List<String> get about => [
        'Versión',
        'Buscar Actualizaciones',
        'Actualización Auto',
        'Cambios',
        'Licencia',
        'Política Privacidad',
        'Telemetría',
        'Informes Error',
      ];
  @override
  List<String> get developer => [
        'Superposición Rendimiento',
        'Depurador Semántica',
        'Rejilla Material',
        'Caché Raster',
        'Reiniciar Tutorial',
        'Restablecimiento Fábrica',
      ];
}

// Path: settings.comparison
class _TranslationsSettingsComparisonEs
    implements TranslationsSettingsComparisonEn {
  _TranslationsSettingsComparisonEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Comparación';
  @override
  String get description => 'Configurar comportamiento de comparación';
  @override
  String get caseSensitive => 'Sensible a Mayúsculas';
  @override
  String get caseSensitiveDescription =>
      'Tratar mayúsculas y minúsculas como diferentes';
  @override
  String get ignoreWhitespace => 'Ignorar Espacios';
  @override
  String get ignoreWhitespaceDescription =>
      'Ignorar espacios iniciales/finales al comparar';
  @override
  String get showLineNumbers => 'Mostrar Números Línea';
  @override
  String get showLineNumbersDescription =>
      'Mostrar números de línea en la vista diff';
  @override
  String get behavior => 'Comportamiento';
  @override
  String get ignoreCase => 'Ignorar Mayúsculas';
  @override
  String get ignoreCaseDescription => 'Tratar "Key" y "key" como iguales';
  @override
  String get similarityThreshold => 'Umbral de Similitud';
  @override
  String get similarityThresholdDescription =>
      'Similitud mínima para detectar "Modificado"';
  @override
  String get mode => 'Modo de Comparación';
  @override
  String get modeDescription => 'Cómo emparejar entradas entre archivos';
  @override
  String get modeKey => 'Basado en Claves';
  @override
  String get modeKeyDescription => 'Empareja por nombre de clave (defecto).';
  @override
  String get modeOrder => 'Basado en Orden';
  @override
  String get modeOrderDescription => 'Empareja por posición en archivo.';
  @override
  String get modeSmart => 'Coincidencia Inteligente';
  @override
  String get modeSmartDescription => 'Detecta claves movidas/renombradas.';
  @override
  String get ignorePatterns => 'Patrones a Ignorar';
  @override
  String get noIgnorePatterns => 'Sin patrones definidos.';
  @override
  String get addPattern => 'Añadir Patrón';
  @override
  String get resetToGlobal => 'Restablecer comparación a valores globales';
  @override
  late final _TranslationsSettingsComparisonPatternPresetsEs patternPresets =
      _TranslationsSettingsComparisonPatternPresetsEs._(_root);
  @override
  late final _TranslationsSettingsComparisonPreviewMatchEs previewMatch =
      _TranslationsSettingsComparisonPreviewMatchEs._(_root);
  @override
  late final _TranslationsSettingsComparisonColorPresetsEs colorPresets =
      _TranslationsSettingsComparisonColorPresetsEs._(_root);
}

// Path: settings.fileHandling
class _TranslationsSettingsFileHandlingEs
    implements TranslationsSettingsFileHandlingEn {
  _TranslationsSettingsFileHandlingEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get fileFormats => 'Formatos de Archivo';
  @override
  String get sourceFormat => 'Formato Origen';
  @override
  String get targetFormat => 'Formato Destino';
  @override
  String get encoding => 'Codificación';
  @override
  String get sourceEncoding => 'Codificación Origen';
  @override
  String get targetEncoding => 'Codificación Destino';
  @override
  String get autoDetect => 'Auto-Detectar';
  @override
  String get autoDetectEncodingDescription =>
      'Detectar automáticamente codificación del archivo';
  @override
  String get exportSettings => 'Ajustes de Exportación';
  @override
  String get defaultExportFormat => 'Formato Exportación por Defecto';
  @override
  String get includeUtf8Bom => 'Incluir UTF-8 BOM';
  @override
  String get includeUtf8BomDescription =>
      'Requerido para compatibilidad con Excel';
  @override
  String get openFolderAfterExport => 'Abrir Carpeta tras Exportar';
  @override
  String get fileSafety => 'Seguridad de Archivos';
  @override
  String get fileSafetyDescription =>
      'Copias locales automáticas para recuperación ante desastres.';
  @override
  String get resetToGlobal =>
      'Restablecer manejo de archivos a valores globales';
}

// Path: settings.translationMemory
class _TranslationsSettingsTranslationMemoryEs
    implements TranslationsSettingsTranslationMemoryEn {
  _TranslationsSettingsTranslationMemoryEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Memoria de Traducción Global';
  @override
  String get autoLearn => 'Auto-aprendizaje';
  @override
  String get autoLearnDescription =>
      'Guardar traducciones en memoria local para reutilizar';
  @override
  String get confidenceThreshold => 'Umbral de Confianza';
  @override
  String confidenceThresholdDescription({required Object percent}) =>
      'Puntuación mínima para auto-aplicar (${percent}%)';
  @override
  String get entries => 'Entradas';
  @override
  String get size => 'Tamaño';
  @override
  String memorySize({required Object size}) => 'Tamaño Memoria: ${size}';
  @override
  String get import => 'Importar';
  @override
  String get exportTmx => 'Exportar TMX';
  @override
  String get exportCsv => 'Exportar CSV';
  @override
  String get clearMemory => 'Limpiar Memoria';
  @override
  String importedItems({required Object count}) =>
      'Importados ${count} elementos a la memoria.';
  @override
  String get noItemsAdded => 'No se añadieron elementos.';
  @override
  String get nothingToExport => 'Nada que exportar todavía.';
  @override
  String get tmxSaved => 'TMX guardado';
  @override
  String get csvSaved => 'CSV guardado';
  @override
  String get clearConfirmTitle => '¿Limpiar memoria de traducción?';
  @override
  String get clearConfirmContent =>
      'Esto eliminará todos los pares de traducción guardados en este dispositivo. Esta acción no se puede deshacer.';
  @override
  String get cleared => 'Memoria de traducción limpiada.';
  @override
  String get couldNotClear => 'No se pudo limpiar la memoria.';
}

// Path: settings.backup
class _TranslationsSettingsBackupEs implements TranslationsSettingsBackupEn {
  _TranslationsSettingsBackupEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Copia de Seguridad Auto';
  @override
  String get description => 'Ajustes de respaldo automático';
  @override
  String get enabled => 'Habilitar Auto-Respaldo';
  @override
  String get enabledDescription =>
      'Respaldar archivos automáticamente antes de cambios';
  @override
  String get maxCopies => 'Máximas Copias';
  @override
  String get maxCopiesDescription => 'Número de copias a mantener por archivo';
  @override
  String activeStatus({required Object count}) =>
      'Activo · Manteniendo ${count} copias';
  @override
  String get folder => 'Carpeta de Respaldo';
  @override
  String get folderDescription => 'Dejar vacío para usar la misma carpeta';
  @override
  String get useOriginalFolder => 'Usar carpeta original del archivo';
}

// Path: settings.ai
class _TranslationsSettingsAiEs implements TranslationsSettingsAiEn {
  _TranslationsSettingsAiEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Servicios IA';
  @override
  String get description => 'Configurar traducción y asistencia por IA';
  @override
  String get provider => 'Proveedor IA';
  @override
  String get providerDescription =>
      'Elige tu proveedor de servicios IA preferido';
  @override
  String get apiKey => 'Clave API';
  @override
  String get apiKeyDescription =>
      'Introduce tu clave API para el proveedor seleccionado';
  @override
  String get apiKeyPlaceholder => 'Introduce clave API...';
  @override
  String get testConnection => 'Probar Conexión';
  @override
  String get connectionSuccess => '¡Conexión exitosa!';
  @override
  String get connectionFailed => 'Conexión fallida. Revisa tu clave API.';
  @override
  String get translationStrategy => 'Estrategia de Traducción';
  @override
  String get strategy => 'Estrategia';
  @override
  String get strategyDescription => 'Selecciona cómo quieres traducir cadenas';
  @override
  String get strategyLLM => 'IA Generativa (LLM)';
  @override
  String get strategyCloud => 'Traducción en la Nube';
  @override
  String get enableAiTranslation => 'Habilitar Traducción IA';
  @override
  String get enableAiTranslationDescription =>
      'Permitir que la app use IA para sugerencias de traducción';
  @override
  String get llmProvider => 'Proveedor Servicio LLM';
  @override
  String get service => 'Servicio';
  @override
  String get serviceDescription => 'Proveedor para IA Generativa';
  @override
  String get providerGemini => 'Google Gemini';
  @override
  String get providerOpenAI => 'OpenAI';
  @override
  String get geminiApiKey => 'Clave API Gemini';
  @override
  String get openAiApiKey => 'Clave API OpenAI';
  @override
  String get model => 'Modelo';
  @override
  String get modelDescription => 'Selecciona qué modelo usar';
  @override
  String get advancedParameters => 'Parámetros Avanzados';
  @override
  String get parameters => 'Parámetros';
  @override
  String get parametersDescription => 'Temperatura, Contexto y más';
  @override
  String get temperature => 'Temperatura';
  @override
  String get temperatureDescription =>
      'Valores más altos hacen la salida más creativa';
  @override
  String get maxTokens => 'Max Tokens';
  @override
  String get maxTokensDescription => 'Límite longitud ventana contexto';
  @override
  String get systemContext => 'Contexto del Sistema / Instrucciones';
  @override
  String get systemContextHint =>
      'Eres un localizador profesional. Mantén el tono e intención...';
  @override
  String get systemContextHelper =>
      'Da instrucciones específicas a la IA sobre el estilo y terminología.';
  @override
  String get contextStrings => 'Cadenas de Contexto';
  @override
  String get contextStringsDescription =>
      'Incluir cadenas circundantes para mejor contexto';
  @override
  String get contextCount => 'Cantidad Contexto';
  @override
  String get contextCountDescription =>
      'Número de cadenas circundantes a incluir';
  @override
  String get cloudServices => 'Servicios Traducción Nube';
  @override
  String get googleTranslateApiKey => 'Clave API Google Translate';
  @override
  String get deeplApiKey => 'Clave API DeepL';
  @override
  String get test => 'Probar';
  @override
  String get resetToGlobal => 'Restablecer ajustes IA a globales';
}

// Path: settings.integrations
class _TranslationsSettingsIntegrationsEs
    implements TranslationsSettingsIntegrationsEn {
  _TranslationsSettingsIntegrationsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get platformNotice => 'Aviso de Plataforma';
  @override
  String get platformNoticeDescription =>
      'Las integraciones del sistema no están disponibles para esta plataforma.';
  @override
  String get visualEffects => 'Efectos Visuales';
  @override
  String get explorerIntegration => 'Integración con Explorador';
  @override
  String get explorerIntegrationDescription =>
      'Añade "Abrir con Localizer" al menú contextual del Explorador de Windows para carpetas.';
  @override
  String get addToContextMenu => 'Añadir al Menú Contextual';
  @override
  String get contextMenuAdded => '¡Menú contextual añadido!';
  @override
  String get contextMenuAddError => 'Fallo al añadir menú contextual';
  @override
  String get contextMenuRemoved => '¡Menú contextual eliminado!';
  @override
  String get contextMenuRemoveError => 'Fallo al eliminar menú contextual';
  @override
  String get fileAssociations => 'Asociaciones de Archivo';
  @override
  String get fileAssociationsDescription =>
      'Registra tipos de archivo para abrir con Localizer al hacer doble clic en el Explorador.';
  @override
  String get registered => 'Registrado';
  @override
  String get notRegistered => 'No Registrado';
  @override
  String extRegistered({required Object ext}) => '¡${ext} registrado!';
  @override
  String extUnregistered({required Object ext}) => '¡${ext} desregistrado!';
  @override
  String extError({required Object action, required Object ext}) =>
      'Fallo al ${action} ${ext}';
  @override
  String get registerAll => 'Registrar Todo';
  @override
  String get unregisterAll => 'Desregistrar Todo';
  @override
  String registerAllResult({required Object success, required Object total}) =>
      'Registrados ${success} de ${total} tipos de archivo';
  @override
  String unregisterAllResult(
          {required Object success, required Object total}) =>
      'Desregistrados ${success} de ${total} tipos de archivo';
  @override
  String get protocolHandler => 'Manejador de Protocolo';
  @override
  String get protocolHandlerDescription =>
      'Registra URLs localizer:// para abrir esta aplicación. Permite abrir proyectos desde enlaces web.';
  @override
  String get protocolRegistered => 'Manejador de protocolo registrado';
  @override
  String get protocolNotRegistered => 'Manejador de protocolo no registrado';
  @override
  String get registerProtocol => 'Registrar Protocolo';
  @override
  String get unregister => 'Desregistrar';
  @override
  String get protocolRegisteredSuccess => '¡Manejador de protocolo registrado!';
  @override
  String get protocolRemovedSuccess => '¡Manejador de protocolo eliminado!';
  @override
  String get protocolRegisterError => 'Fallo al registrar';
  @override
  String get protocolRemoveError => 'Fallo al eliminar';
  @override
  String get windowMaterial => 'Material de Ventana';
  @override
  String get windowMaterialDescription =>
      'Selecciona el estilo de material vibrancy de macOS';
  @override
  String get dockIntegration => 'Integración Dock';
  @override
  String get showDockBadge => 'Mostrar Contador No Traducido';
  @override
  String get showDockBadgeDescription =>
      'Muestra el contador de cadenas no traducidas en la insignia del icono del dock';
  @override
  late final _TranslationsSettingsIntegrationsMaterialsEs materials =
      _TranslationsSettingsIntegrationsMaterialsEs._(_root);
  @override
  late final _TranslationsSettingsIntegrationsFileTypesEs fileTypes =
      _TranslationsSettingsIntegrationsFileTypesEs._(_root);
}

// Path: settings.developer
class _TranslationsSettingsDeveloperEs
    implements TranslationsSettingsDeveloperEn {
  _TranslationsSettingsDeveloperEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ajustes de Desarrollador';
  @override
  String get description => 'Ajustes avanzados para desarrolladores';
  @override
  String get showLocalizationKeys => 'Mostrar Claves de Localización';
  @override
  String get localizationKeysDescription =>
      'Al habilitar, todo el texto traducido mostrará sus claves de localización en lugar del valor. Útil para verificar claves.';
  @override
  String get showPerformanceOverlay => 'Mostrar Superposición de Rendimiento';
  @override
  String get performanceOverlayDescription =>
      'Muestra FPS e información de tiempos de cuadro';
  @override
  String get debugMode => 'Modo Depuración';
  @override
  String get debugModeDescription =>
      'Habilita registros adicionales y funciones de depuración';
  @override
  String get debuggingTools => 'Herramientas de Depuración';
  @override
  String get semanticsDebugger => 'Depurador de Semántica';
  @override
  String get semanticsDebuggerDescription => 'Visualizar árbol de semántica';
  @override
  String get materialGrid => 'Rejilla Material';
  @override
  String get materialGridDescription => 'Superponer rejilla de diseño material';
  @override
  String get rasterCache => 'Imágenes Caché Raster';
  @override
  String get rasterCacheDescription =>
      'Imágenes caché raster en tablero de ajedrez';
  @override
  String get actions => 'Acciones';
  @override
  String get showLogs => 'Mostrar Registros App';
  @override
  String get showLogsDescription => 'Abrir consola de depuración Talker';
  @override
  String get restartTutorial => 'Reiniciar Tutorial de Bienvenida';
  @override
  String get restartTutorialDescription =>
      'Restablecer banderas e iniciar tutorial de nuevo';
  @override
  String get restartRequested => 'Reinicio de tutorial solicitado.';
  @override
  String get throwException => 'Lanzar Excepción de Prueba';
  @override
  String get throwExceptionDescription =>
      'Provocar una excepción de prueba para informes de fallo';
  @override
  String get testExceptionMessage =>
      'Excepción de prueba desde Opciones de Desarrollador';
  @override
  String get clearTM => 'Limpiar Memoria de Traducción';
  @override
  String get clearTMDescription => 'Borrar todas las traducciones en caché';
  @override
  String get clearTMConfirmation => '¿Limpiar Memoria de Traducción?';
  @override
  String get clearTMWarning =>
      'Esto borrará todas las traducciones aprendidas. No se puede deshacer.';
  @override
  String get tmCleared => 'Memoria de traducción limpiada';
  @override
  String get clearApiKeys => 'Limpiar Claves API';
  @override
  String get clearApiKeysDescription =>
      'Eliminar todas las claves API almacenadas';
  @override
  String get clearApiKeysConfirmation => '¿Limpiar Claves API?';
  @override
  String get clearApiKeysWarning =>
      'Esto eliminará todas las claves API del almacenamiento seguro.';
  @override
  String get apiKeysCleared => 'Claves API limpiadas';
  @override
  String get hideOptions => 'Ocultar Opciones de Desarrollador';
  @override
  String get hideOptionsDescription =>
      'Deshabilitar modo desarrollador (requiere 7 toques para rehabilitar)';
  @override
  String get optionsDisabled => 'Opciones de desarrollador deshabilitadas';
  @override
  String get dangerZone => 'Zona de Peligro';
  @override
  String get factoryReset => 'Restablecimiento de Fábrica';
  @override
  String get factoryResetDescription =>
      'Restablecer todos los ajustes y borrar datos';
  @override
  String get factoryResetWarning =>
      '¿Seguro que quieres restablecer todos los ajustes? No se puede deshacer.';
  @override
  String get inspectionTools => 'Herramientas de Inspección';
  @override
  String get searchHint => 'Buscar ajustes...';
  @override
  String get resetToDefault => 'Restablecer a valores por defecto';
  @override
  String get resetToGlobal => 'Restablecer a valor global';
  @override
  String get storageInspector => 'Inspector de Almacenamiento';
  @override
  String get storageInspectorDescription =>
      'Ver contenidos de Hive y Almacenamiento Seguro';
  @override
  String get deviceEnvironment => 'Dispositivo y Entorno';
  @override
  String get deviceEnvironmentDescription =>
      'Info de pantalla, plataforma y compilación';
  @override
  String get themePlayground => 'Zona de Pruebas de Tema';
  @override
  String get themePlaygroundDescription => 'Paleta de colores y tipografía';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionEs
      themePlaygroundSection =
      _TranslationsSettingsDeveloperThemePlaygroundSectionEs._(_root);
  @override
  String get localizationInspector => 'Inspector de Localización';
  @override
  String get localizationInspectorDescription =>
      'Depurar cadenas de traducción';
  @override
  String get hiveAppSettings => 'Hive (AjustesApp)';
  @override
  String get secureStorageMasked => 'Almacenamiento Seguro (Enmascarado)';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsEs featureFlags =
      _TranslationsSettingsDeveloperFeatureFlagsEs._(_root);
  @override
  late final _TranslationsSettingsDeveloperStorageInspectorSectionEs
      storageInspectorSection =
      _TranslationsSettingsDeveloperStorageInspectorSectionEs._(_root);
  @override
  late final _TranslationsSettingsDeveloperDeviceInfoSectionEs
      deviceInfoSection =
      _TranslationsSettingsDeveloperDeviceInfoSectionEs._(_root);
  @override
  late final _TranslationsSettingsDeveloperLocalizationInspectorSectionEs
      localizationInspectorSection =
      _TranslationsSettingsDeveloperLocalizationInspectorSectionEs._(_root);
}

// Path: settings.about
class _TranslationsSettingsAboutEs implements TranslationsSettingsAboutEn {
  _TranslationsSettingsAboutEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Acerca de';
  @override
  String get version => 'Versión';
  @override
  String get buildNumber => 'Número de Compilación';
  @override
  String get author => 'Autor';
  @override
  String get license => 'Licencia';
  @override
  String get sourceCode => 'Código Fuente';
  @override
  String get reportBug => 'Informar de un Bug';
  @override
  String get requestFeature => 'Solicitar una Característica';
  @override
  String get checkForUpdates => 'Buscar Actualizaciones';
  @override
  String get upToDate => '¡Estás al día!';
  @override
  String updateAvailable({required Object version}) =>
      'Actualización disponible: ${version}';
  @override
  String get updateAvailableBadge => '¡Actualización Disponible!';
  @override
  String developerSteps({required Object count}) =>
      'Estás a ${count} pasos de ser desarrollador.';
  @override
  String get developerActivated => '¡Ahora eres desarrollador!';
  @override
  String get neverChecked => 'Nunca';
  @override
  String get applicationInfo => 'Info de Aplicación';
  @override
  String get platform => 'Plataforma';
  @override
  String get updateInformation => 'Info de Actualización';
  @override
  String get currentVersion => 'Versión Actual';
  @override
  String get latestVersion => 'Última Versión';
  @override
  String get lastChecked => 'Última Comprobación';
  @override
  String get checkingForUpdates => 'Comprobando...';
  @override
  String get whatsNew => 'Novedades';
  @override
  String get systemInformation => 'Información del Sistema';
  @override
  String get dartVersion => 'Versión de Dart';
  @override
  String get diskSpace => 'Espacio en Disco';
  @override
  String get memoryUsage => 'Uso de Memoria';
  @override
  String get privacyTitle => 'Privacidad y Telemetría';
  @override
  String get usageStats => 'Estadísticas de Uso Anónimo';
  @override
  String get requiresFirebase => 'Requiere configuración de Firebase';
  @override
  String get featureUnavailable =>
      'Característica no disponible (Requiere Firebase)';
  @override
  String get settingsManagement => 'Gestión de Ajustes';
  @override
  String get settingsManagementDescription =>
      'Exporta tus ajustes a un archivo para respaldarlos o compartir.';
  @override
  String get resetAll => 'Restablecer Todo';
  @override
  String get links => 'Enlaces';
  @override
  String get githubRepo => 'Repositorio GitHub';
  @override
  String get privacyPolicy => 'Política de Privacidad';
  @override
  String get crashReporting => 'Informes de Fallos';
}

// Path: settings.onboarding
class _TranslationsSettingsOnboardingEs
    implements TranslationsSettingsOnboardingEn {
  _TranslationsSettingsOnboardingEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'Saltar Tutorial';
  @override
  String get gettingStarted => 'Empezando';
  @override
  String stepProgress({required Object current, required Object total}) =>
      '${current} de ${total}';
  @override
  String get loadSampleData => 'Cargar Datos de Ejemplo';
  @override
  late final _TranslationsSettingsOnboardingStepsEs steps =
      _TranslationsSettingsOnboardingStepsEs._(_root);
}

// Path: settings.settingsView
class _TranslationsSettingsSettingsViewEs
    implements TranslationsSettingsSettingsViewEn {
  _TranslationsSettingsSettingsViewEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String resetCategoryTitle({required Object category}) =>
      '¿Restablecer ${category}?';
  @override
  String get resetCategoryContent =>
      'Esto restablecerá todos los ajustes de esta categoría a sus valores por defecto.';
  @override
  String get resetAllTitle => '¿Restablecer Todos los Ajustes?';
  @override
  String get resetAllContent =>
      'Esto restablecerá permanentemente todos los ajustes a sus valores de fábrica. No se puede deshacer.';
  @override
  String get resetAll => 'Restablecer Todo';
  @override
  String resetSuccess({required Object category}) =>
      '${category} restablecido por defecto';
  @override
  String get errorLoading => 'Error cargando ajustes';
  @override
  String get settingsSaved => 'Ajustes guardados';
  @override
  String updateAvailable({required Object version}) =>
      'Actualización disponible: v${version}';
  @override
  String get latestVersion => 'Estás usando la última versión';
  @override
  String whatsNew({required Object version}) => 'Novedades en v${version}';
  @override
  String get downloadUpdate => 'Descargar Actualización';
  @override
  String get exportSettings => 'Exportar Ajustes';
  @override
  String get settingsExported => 'Ajustes exportados';
  @override
  String exportFail({required Object error}) =>
      'Fallo al exportar ajustes: ${error}';
  @override
  String get importSettings => 'Importar Ajustes';
  @override
  String get importTitle => '¿Importar Ajustes?';
  @override
  String get importContent =>
      'Esto reemplazará todos tus ajustes actuales con los importados. No se puede deshacer.';
  @override
  String get importSuccess => '¡Ajustes importados con éxito!';
  @override
  String importFail({required Object error}) =>
      'Fallo al importar ajustes: ${error}';
  @override
  String get invalidFormat => 'Formato de archivo de ajustes inválido';
  @override
  late final _TranslationsSettingsSettingsViewCategoriesEs categories =
      _TranslationsSettingsSettingsViewCategoriesEs._(_root);
  @override
  late final _TranslationsSettingsSettingsViewCategoryLabelsEs categoryLabels =
      _TranslationsSettingsSettingsViewCategoryLabelsEs._(_root);
}

// Path: advancedDiff.aiSuggestion
class _TranslationsAdvancedDiffAiSuggestionEs
    implements TranslationsAdvancedDiffAiSuggestionEn {
  _TranslationsAdvancedDiffAiSuggestionEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get aiTranslation => 'Traducción IA';
  @override
  String get aiRephrase => 'Refraseo IA';
  @override
  String key({required Object key}) => 'Clave: ${key}';
  @override
  String get original => 'Original:';
  @override
  String get suggestion => 'Sugerencia:';
  @override
  String get confidence => 'Confianza IA';
  @override
  String get cancelEdit => 'Cancelar edición';
  @override
  String get editSuggestion => 'Editar sugerencia';
  @override
  String get alternatives => 'Alternativas:';
  @override
  String get accept => 'Aceptar';
  @override
  String get reject => 'Rechazar';
  @override
  String get stop => 'Detener';
}

// Path: advancedDiff.detailEdit
class _TranslationsAdvancedDiffDetailEditEs
    implements TranslationsAdvancedDiffDetailEditEn {
  _TranslationsAdvancedDiffDetailEditEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object key}) => 'Editar: ${key}';
  @override
  String get sourceLabel => 'ORIGEN (Original)';
  @override
  String get targetLabel => 'DESTINO (Traducción)';
  @override
  String get translateWithCloud => 'Traducir con Nube';
  @override
  String get translateWithAi => 'Traducir con IA';
  @override
  String get translating => 'Traduciendo...';
  @override
  String get applyAndTm => 'Aplicar';
  @override
  String get entryApplied => 'Entrada aplicada y añadida a MT';
  @override
  String get translationAdded => 'Sugerencia de traducción añadida.';
  @override
  String get aiSuggestionAdded => 'Sugerencia IA añadida.';
}

// Path: advancedDiff.table
class _TranslationsAdvancedDiffTableEs
    implements TranslationsAdvancedDiffTableEn {
  _TranslationsAdvancedDiffTableEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get addedToTM => 'Añadido a Memoria de Traducción';
  @override
  String get markedReviewed => 'Marcado como revisado ✓';
  @override
  String get unmarkedReview => 'Revisión desmarcada';
  @override
  String get reverted => 'Revertido a valor origen';
  @override
  String get entryDeleted => 'Entrada eliminada';
  @override
  String get noSourceText => 'Sin texto origen para traducir.';
  @override
  String aiTranslationFailed({required Object key}) =>
      'Traducción IA falló para "${key}"';
  @override
  String get noTargetText => 'Sin texto destino para refrasear.';
  @override
  String aiRephraseFailed({required Object key}) =>
      'Refraseo IA falló para "${key}"';
  @override
  String get checkRowsFirst => 'Marca filas usando casillas primero';
  @override
  String markedRowsReviewed({required Object count}) =>
      'Marcadas ${count} filas como revisadas';
  @override
  String revertedRows({required Object count}) => 'Revertidas ${count} filas';
  @override
  String entriesCount({required Object count}) => '${count} entradas';
  @override
  String get markSelectedReviewed => 'Marcar Seleccionadas Revisadas';
  @override
  String get revertSelected => 'Revertir Seleccionadas';
  @override
  String get noDifferences => 'No se encontraron diferencias';
  @override
  String get adjustFilters => 'Intenta ajustar tus filtros';
  @override
  String get cloudTranslationApplied => 'Traducción nube aplicada.';
  @override
  String get aiTranslationApplied => 'Traducción IA aplicada.';
  @override
  String get suggestionApplied => 'Sugerencia aplicada.';
  @override
  String get aiSuggestionApplied => 'Sugerencia IA aplicada.';
  @override
  String get rephraseApplied => 'Refraseo aplicado.';
  @override
  String get aiRephraseApplied => 'Refraseo IA aplicado.';
  @override
  String get rephrase => 'Refrasear';
  @override
  String get aiRephrase => 'Refraseo IA';
  @override
  String get targetClickToEdit => 'DESTINO (Clic para editar)';
  @override
  String get targetClickForDialog => 'DESTINO (Clic para diálogo)';
  @override
  String get emptyClickToEdit => '(Vacío - Clic para editar)';
  @override
  String get unmarkReviewed => 'Desmarcar revisado';
  @override
  String get markReviewed => 'Marcar como revisado';
  @override
  String get revertToSource => 'Revertir a origen';
  @override
  String get translateWithCloud => 'Traducir con Nube';
  @override
  String get translateWithAi => 'Traducir con IA';
  @override
  String get rephraseWithAi => 'Refrasear con IA';
  @override
  String get moreActions => 'Más acciones';
  @override
  String get editDetails => 'Editar detalles';
  @override
  String get suggestTranslation => 'Sugerir traducción';
  @override
  String get addToTm => 'Añadir a MT';
  @override
  String get deleteEntry => 'Eliminar entrada';
}

// Path: advancedDiff.diffRow
class _TranslationsAdvancedDiffDiffRowEs
    implements TranslationsAdvancedDiffDiffRowEn {
  _TranslationsAdvancedDiffDiffRowEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get copySource => 'Copiar texto origen';
  @override
  String get actions => 'Acciones';
}

// Path: advancedDiff.status
class _TranslationsAdvancedDiffStatusEs
    implements TranslationsAdvancedDiffStatusEn {
  _TranslationsAdvancedDiffStatusEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'AÑADIDO';
  @override
  String get missing => 'FALTANTE';
  @override
  String changed({required Object percent}) => 'CAMB ${percent}%';
  @override
  String get same => 'IGUAL';
}

// Path: advancedDiff.sidebar
class _TranslationsAdvancedDiffSidebarEs
    implements TranslationsAdvancedDiffSidebarEn {
  _TranslationsAdvancedDiffSidebarEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get widgets => 'Widgets';
  @override
  String get searchPlaceholder => 'Buscar claves y valores... (Ctrl+F)';
  @override
  String get fuzzySearchTooltip => 'Búsqueda Difusa (tolera errores)';
  @override
  String get regexSearchTooltip => 'Búsqueda Regex';
  @override
  String get cloudTranslation => 'Traducción Nube';
  @override
  String get aiTranslation => 'Traducción IA';
  @override
  String get status => 'Estado';
  @override
  String get tm => 'Memoria de Traducción';
  @override
  String get filters => 'Filtros';
  @override
  String get actions => 'Acciones';
  @override
  String get similarity => 'Similitud';
  @override
  late final _TranslationsAdvancedDiffSidebarActionsSectionEs actionsSection =
      _TranslationsAdvancedDiffSidebarActionsSectionEs._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarAiSectionEs aiSection =
      _TranslationsAdvancedDiffSidebarAiSectionEs._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarTmSectionEs tmSection =
      _TranslationsAdvancedDiffSidebarTmSectionEs._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarFiltersSectionEs filtersSection =
      _TranslationsAdvancedDiffSidebarFiltersSectionEs._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarSimilaritySectionEs
      similaritySection =
      _TranslationsAdvancedDiffSidebarSimilaritySectionEs._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarStatusSectionEs statusSection =
      _TranslationsAdvancedDiffSidebarStatusSectionEs._(_root);
}

// Path: issueDetails.duplicateValue
class _TranslationsIssueDetailsDuplicateValueEs
    implements TranslationsIssueDetailsDuplicateValueEn {
  _TranslationsIssueDetailsDuplicateValueEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'TRADUCCIÓN REPETIDA';
  @override
  String get warning =>
      'Diferentes textos de origen usan esta misma traducción. Verifica el contexto.';
  @override
  String affectedKeys({required Object count}) => 'CLAVES AFECTADAS (${count})';
  @override
  String get identicalSources => 'Fuentes Idénticas';
  @override
  String moreKeys({required Object count}) => '+${count} claves más';
}

// Path: issueDetails.lengthOutlier
class _TranslationsIssueDetailsLengthOutlierEs
    implements TranslationsIssueDetailsLengthOutlierEn {
  _TranslationsIssueDetailsLengthOutlierEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get source => 'ORIGEN';
  @override
  String get translation => 'TRADUCCIÓN';
  @override
  String chars({required Object count}) => '${count} car';
}

// Path: issueDetails.standard
class _TranslationsIssueDetailsStandardEs
    implements TranslationsIssueDetailsStandardEn {
  _TranslationsIssueDetailsStandardEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'CLAVE';
  @override
  String get sourceText => 'TEXTO ORIGEN';
  @override
  String get translation => 'TRADUCCIÓN';
  @override
  String get errorDetails => 'DETALLES ERROR';
  @override
  String get note => 'NOTA';
}

// Path: issueDetails.types
class _TranslationsIssueDetailsTypesEs
    implements TranslationsIssueDetailsTypesEn {
  _TranslationsIssueDetailsTypesEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get duplicateValue => 'Valores Duplicados';
  @override
  String get lengthOutlier => 'Desajuste Longitud';
  @override
  String get placeholderMismatch => 'Marcadores Rotos';
}

// Path: issueDetails.notes
class _TranslationsIssueDetailsNotesEs
    implements TranslationsIssueDetailsNotesEn {
  _TranslationsIssueDetailsNotesEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get placeholderMismatch =>
      'Marcadores como {name} deberían coincidir con el origen.';
  @override
  String get lengthOutlier =>
      'Grandes cambios de longitud pueden afectar cómo encaja el texto.';
  @override
  String get duplicateValue =>
      'La misma traducción se usa para diferentes claves.';
}

// Path: issueDetails.fallbacks
class _TranslationsIssueDetailsFallbacksEs
    implements TranslationsIssueDetailsFallbacksEn {
  _TranslationsIssueDetailsFallbacksEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get multipleSources => 'Múltiples textos origen';
  @override
  String get sourceNotAvailable => 'Texto origen no disponible';
  @override
  String get sharedTranslationNotAvailable =>
      'Traducción compartida no disponible';
  @override
  String get translationNotAvailable => 'Traducción no disponible';
}

// Path: compare.tabs
class _TranslationsCompareTabsEs implements TranslationsCompareTabsEn {
  _TranslationsCompareTabsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get files => 'Archivos';
  @override
  String get directories => 'Directorios';
  @override
  String get git => 'Git';
}

// Path: compare.fileTypes
class _TranslationsCompareFileTypesEs
    implements TranslationsCompareFileTypesEn {
  _TranslationsCompareFileTypesEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get json => 'Archivos localización JSON (i18next, Flutter, etc.)';
  @override
  String get yaml => 'Archivos localización YAML (Rails, Flutter)';
  @override
  String get xml => 'Archivos localización XML (Android, .NET)';
  @override
  String get properties => 'Archivos Properties (Java)';
  @override
  String get resx => 'Archivos RESX (.NET)';
  @override
  String get xliff => 'Archivos XLIFF';
}

// Path: history.timeAgo
class _TranslationsHistoryTimeAgoEs implements TranslationsHistoryTimeAgoEn {
  _TranslationsHistoryTimeAgoEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get justNow => 'ahora mismo';
  @override
  String secondsAgo({required Object count}) => 'hace ${count} segundos';
  @override
  String get oneMinuteAgo => 'hace 1 minuto';
  @override
  String minutesAgo({required Object count}) => 'hace ${count} minutos';
  @override
  String get oneHourAgo => 'hace 1 hora';
  @override
  String hoursAgo({required Object count}) => 'hace ${count} horas';
  @override
  String get yesterday => 'ayer';
  @override
  String daysAgo({required Object count}) => 'hace ${count} días';
  @override
  String get oneWeekAgo => 'hace 1 semana';
  @override
  String weeksAgo({required Object count}) => 'hace ${count} semanas';
  @override
  String get oneMonthAgo => 'hace 1 mes';
  @override
  String monthsAgo({required Object count}) => 'hace ${count} meses';
  @override
  String get oneYearAgo => 'hace 1 año';
  @override
  String yearsAgo({required Object count}) => 'hace ${count} años';
  @override
  String get inTheFuture => 'en el futuro';
}

// Path: projects.stats
class _TranslationsProjectsStatsEs implements TranslationsProjectsStatsEn {
  _TranslationsProjectsStatsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get empty => 'Proyecto vacío';
  @override
  String files({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: '1 archivo de traducción',
        other: '${count} archivos de traducción',
      );
  @override
  String languages({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: '1 idioma',
        other: '${count} idiomas',
      );
}

// Path: projects.selection
class _TranslationsProjectsSelectionEs
    implements TranslationsProjectsSelectionEn {
  _TranslationsProjectsSelectionEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get selectFolder => 'Seleccionar Carpeta de Proyecto';
  @override
  String get selectArchive => 'Seleccionar Archivo de Proyecto';
  @override
  String get openProject => 'Abrir Proyecto';
  @override
  String get browseFolder => 'Examinar Carpeta...';
  @override
  String get createNew => 'Crear Nuevo';
  @override
  String get importFromZip => 'Importar desde Zip...';
}

// Path: projects.createDialog
class _TranslationsProjectsCreateDialogEs
    implements TranslationsProjectsCreateDialogEn {
  _TranslationsProjectsCreateDialogEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Crear Proyecto';
  @override
  String get description =>
      'Un proyecto te permite guardar ajustes personalizados para una carpeta específica. Se creará una carpeta ".localizer" para guardar la configuración de tu proyecto.';
  @override
  String get folderLabel => 'Carpeta del Proyecto';
  @override
  String get folderHint => 'Haz clic para seleccionar carpeta...';
  @override
  String get nameLabel => 'Nombre del Proyecto';
  @override
  String get nameHint => 'ej., Mis Traducciones App';
  @override
  String get selectFolderWarning =>
      'Por favor selecciona una carpeta de proyecto.';
  @override
  String get enterNameError => 'Por favor introduce un nombre de proyecto';
  @override
  String get nameLengthError => 'El nombre debe tener al menos 2 caracteres';
  @override
  String success({required Object name}) =>
      '¡Proyecto "${name}" creado con éxito!';
  @override
  String get failure => 'Fallo al crear proyecto.';
  @override
  String get creating => 'Creando...';
  @override
  String get createAction => 'Crear Proyecto';
}

// Path: projects.indicator
class _TranslationsProjectsIndicatorEs
    implements TranslationsProjectsIndicatorEn {
  _TranslationsProjectsIndicatorEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get tooltipNoProject =>
      'Crea un proyecto para guardar ajustes personalizados para una carpeta';
  @override
  String tooltipProject({required Object name}) =>
      'Proyecto: ${name}\nHaz clic para ver opciones';
  @override
  String get location => 'Ubicación';
  @override
  String get created => 'Creado';
  @override
  String get switchProject => 'Cambiar Proyecto';
  @override
  String get done => 'Hecho';
}

// Path: projects.glossary
class _TranslationsProjectsGlossaryEs
    implements TranslationsProjectsGlossaryEn {
  _TranslationsProjectsGlossaryEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Glosario del Proyecto';
  @override
  String get description =>
      'Define términos que deben tratarse consistentemente o nunca traducirse.';
  @override
  String get noTerms => 'Aún no hay términos en glosario.';
  @override
  String get noTermsDesc =>
      'Añade términos que deban permanecer consistentes,\no marca nombres de marca que nunca deban traducirse.';
  @override
  String get doNotTranslate => 'No traducir';
  @override
  String get noSpecificTranslation => 'Sin traducción específica';
  @override
  String get addTerm => 'Añadir Término';
  @override
  String get editTerm => 'Editar Término';
  @override
  String get term => 'Término';
  @override
  String get termHint => 'ej., nombre marca, término especializado';
  @override
  String get definition => 'Definición (Opcional)';
  @override
  String get definitionHint => 'Contexto para el traductor';
  @override
  String get doNotTranslateLabel => 'No Traducir';
  @override
  String get doNotTranslateDesc =>
      'Mantener término exactamente igual en destino';
  @override
  String get preferredTranslation => 'Traducción Preferida';
  @override
  String get caseSensitive => 'Sensible a Mayúsculas';
}

// Path: projects.conflicts
class _TranslationsProjectsConflictsEs
    implements TranslationsProjectsConflictsEn {
  _TranslationsProjectsConflictsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String missingApiKeyTitle({required Object service}) =>
      'Falta clave API para ${service}';
  @override
  String missingApiKeyMessage({required Object service}) =>
      'Este proyecto usa ${service} pero no hay clave API configurada. Añade tu clave API en Ajustes > Servicios IA, o la app usará el valor global por defecto.';
  @override
  String get dismiss => 'Descartar';
}

// Path: projects.tm
class _TranslationsProjectsTmEs implements TranslationsProjectsTmEn {
  _TranslationsProjectsTmEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Memorias de Traducción';
  @override
  String get description =>
      'Gestiona fuentes de memoria de traducción para este proyecto.';
  @override
  String get globalTm => 'Memoria de Traducción Global';
  @override
  String get globalTmDescription =>
      'Usa la memoria de traducción compartida de tus ajustes de app';
  @override
  String get linkedFiles => 'Archivos Vinculados (Específico Proyecto)';
  @override
  String get noLinkedFiles =>
      'No hay archivos específicos del proyecto vinculados.';
  @override
  String get addTmFile => 'Añadir Archivo TM';
  @override
  String get useGlobalTm => 'Usar TM Global';
  @override
  String get selectTm => 'Seleccionar Memoria de Traducción';
  @override
  String get globalTmEnabled => 'Memoria de Traducción Global habilitada';
}

// Path: git.conflicts
class _TranslationsGitConflictsEs implements TranslationsGitConflictsEn {
  _TranslationsGitConflictsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Conflictos de Merge Detectados';
  @override
  String get description =>
      'Debes resolver estos conflictos antes de continuar.';
  @override
  String get abortMergeTitle => '¿Abortar Merge?';
  @override
  String get abortMergeContent =>
      'Esto revertirá todos los cambios del merge y volverá al estado previo. Esto no se puede deshacer.';
  @override
  String get abortMergeAction => 'Abortar Merge';
  @override
  String stagingFile({required Object file}) =>
      'Preparando ${file} para commit...';
  @override
  String conflictedFilesCount({required Object count}) =>
      'Archivos en Conflicto (${count})';
  @override
  String get selectFileToResolve => 'Selecciona un archivo para resolver';
  @override
  String resolvingFile({required Object file}) => 'Resolviendo: ${file}';
  @override
  String get keepAllOurs => 'Mantener Todo Nuestro';
  @override
  String get acceptAllTheirs => 'Aceptar Todo Suyo';
  @override
  String get allResolved =>
      '¡Todos los conflictos en este archivo han sido resueltos!';
  @override
  String get markResolved => 'Marcar como Resuelto';
  @override
  String get stageForCommit => 'Esto preparará el archivo para commit.';
  @override
  String conflictIndex({required Object index}) => 'Conflicto #${index}';
  @override
  String get ours => 'NUESTRO (Actual)';
  @override
  String get theirs => 'SUYO (Entrante)';
  @override
  String get keepOurs => 'Mantener Nuestro';
  @override
  String get acceptTheirs => 'Aceptar Suyo';
  @override
  String get empty => '(Vacío)';
}

// Path: wizards.firstRun
class _TranslationsWizardsFirstRunEs implements TranslationsWizardsFirstRunEn {
  _TranslationsWizardsFirstRunEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get welcome => 'Bienvenido a Localizer';
  @override
  String get description => 'Compara tus archivos de localización en segundos.';
  @override
  String get sourceFile => 'Archivo Origen';
  @override
  String get targetFile => 'Archivo Destino';
  @override
  String get compareNow => 'Comparar Ahora';
  @override
  String get trySample => 'Probar con Datos de Ejemplo';
  @override
  String get skip => 'Saltar Configuración';
  @override
  String get browse => 'Clic para examinar';
  @override
  String error({required Object error}) =>
      'Fallo al cargar datos de ejemplo: ${error}';
}

// Path: dialogs.addIgnorePattern
class _TranslationsDialogsAddIgnorePatternEs
    implements TranslationsDialogsAddIgnorePatternEn {
  _TranslationsDialogsAddIgnorePatternEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Añadir Patrón Ignorar';
  @override
  String get patternLabel => 'Patrón (regex)';
  @override
  String get hint => 'ej., ^temp_.*';
  @override
  String get invalid => 'Patrón regex inválido';
  @override
  String get testStringLabel => 'Cadena de Prueba';
  @override
  String get testHint => 'Introduce una clave para probar contra el patrón';
  @override
  String get match => '✓ El patrón coincide con la cadena';
  @override
  String get noMatch => '✗ El patrón no coincide';
  @override
  String get add => 'Añadir';
  @override
  String get cancel => 'Cancelar';
}

// Path: dialogs.diffViewer
class _TranslationsDialogsDiffViewerEs
    implements TranslationsDialogsDiffViewerEn {
  _TranslationsDialogsDiffViewerEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Visor de Diferencias';
  @override
  String get originalFile => 'Archivo Original/Referencia';
  @override
  String get translationFile => 'Archivo Traducción/Comparación';
  @override
  String get base => 'BASE';
  @override
  String get target => 'DESTINO';
  @override
  String get added => 'Añadido';
  @override
  String get removed => 'Eliminado';
  @override
  String get modified => 'Modificado';
  @override
  String get noMatches => 'Ninguna entrada coincide con los filtros actuales';
  @override
  String get clickToggle =>
      'Haz clic en las insignias arriba para alternar filtros';
  @override
  String get clickToHide => '(clic para ocultar)';
  @override
  String get clickToShow => '(clic para mostrar)';
}

// Path: grid.columns
class _TranslationsGridColumnsEs implements TranslationsGridColumnsEn {
  _TranslationsGridColumnsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'Clave';
  @override
  String get source => 'Origen';
  @override
  String get status => 'Estado';
  @override
  String get actions => 'Acciones';
}

// Path: tutorial.steps
class _TranslationsTutorialStepsEs implements TranslationsTutorialStepsEn {
  _TranslationsTutorialStepsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTutorialStepsImportSourceEs importSource =
      _TranslationsTutorialStepsImportSourceEs._(_root);
  @override
  late final _TranslationsTutorialStepsImportTargetEs importTarget =
      _TranslationsTutorialStepsImportTargetEs._(_root);
  @override
  late final _TranslationsTutorialStepsCompareEs compare =
      _TranslationsTutorialStepsCompareEs._(_root);
  @override
  late final _TranslationsTutorialStepsFilterEs filter =
      _TranslationsTutorialStepsFilterEs._(_root);
  @override
  late final _TranslationsTutorialStepsSearchEs search =
      _TranslationsTutorialStepsSearchEs._(_root);
  @override
  late final _TranslationsTutorialStepsAdvancedEs advanced =
      _TranslationsTutorialStepsAdvancedEs._(_root);
  @override
  late final _TranslationsTutorialStepsExportEs export =
      _TranslationsTutorialStepsExportEs._(_root);
}

// Path: friendlyErrors.fileNotFound
class _TranslationsFriendlyErrorsFileNotFoundEs
    implements TranslationsFriendlyErrorsFileNotFoundEn {
  _TranslationsFriendlyErrorsFileNotFoundEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'El archivo o carpeta no pudo ser encontrado.';
  @override
  String get suggestion => 'Comprueba si el archivo fue movido o eliminado.';
}

// Path: friendlyErrors.accessDenied
class _TranslationsFriendlyErrorsAccessDeniedEs
    implements TranslationsFriendlyErrorsAccessDeniedEn {
  _TranslationsFriendlyErrorsAccessDeniedEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Acceso al archivo denegado.';
  @override
  String get suggestion =>
      'Intenta ejecutar la app como administrador o verifica permisos de archivo.';
}

// Path: friendlyErrors.isDirectory
class _TranslationsFriendlyErrorsIsDirectoryEs
    implements TranslationsFriendlyErrorsIsDirectoryEn {
  _TranslationsFriendlyErrorsIsDirectoryEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Se seleccionó una carpeta en lugar de un archivo.';
  @override
  String get suggestion => 'Por favor selecciona un archivo válido.';
}

// Path: friendlyErrors.fileAccess
class _TranslationsFriendlyErrorsFileAccessEs
    implements TranslationsFriendlyErrorsFileAccessEn {
  _TranslationsFriendlyErrorsFileAccessEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Hubo un problema accediendo al archivo.';
  @override
  String get suggestion =>
      'Intenta cerrar otros programas que puedan estar usándolo.';
}

// Path: friendlyErrors.unsupportedFormat
class _TranslationsFriendlyErrorsUnsupportedFormatEs
    implements TranslationsFriendlyErrorsUnsupportedFormatEn {
  _TranslationsFriendlyErrorsUnsupportedFormatEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Este formato de archivo u operación no es soportado.';
  @override
  String get suggestion =>
      'Verifica la extensión de archivo o intenta un formato diferente.';
}

// Path: friendlyErrors.networkError
class _TranslationsFriendlyErrorsNetworkErrorEs
    implements TranslationsFriendlyErrorsNetworkErrorEn {
  _TranslationsFriendlyErrorsNetworkErrorEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'No se pudo conectar al servidor.';
  @override
  String get suggestion =>
      'Verifica tu conexión a internet e intenta de nuevo.';
}

// Path: friendlyErrors.notGitRepo
class _TranslationsFriendlyErrorsNotGitRepoEs
    implements TranslationsFriendlyErrorsNotGitRepoEn {
  _TranslationsFriendlyErrorsNotGitRepoEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Esta carpeta no es un proyecto Git.';
  @override
  String get suggestion =>
      'Navega a una carpeta que contenga un directorio .git.';
}

// Path: friendlyErrors.mergeConflict
class _TranslationsFriendlyErrorsMergeConflictEs
    implements TranslationsFriendlyErrorsMergeConflictEn {
  _TranslationsFriendlyErrorsMergeConflictEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Hay conflictos de merge en el repositorio.';
  @override
  String get suggestion => 'Resuelve los conflictos antes de continuar.';
}

// Path: friendlyErrors.gitAuthFailed
class _TranslationsFriendlyErrorsGitAuthFailedEs
    implements TranslationsFriendlyErrorsGitAuthFailedEn {
  _TranslationsFriendlyErrorsGitAuthFailedEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Fallo de autenticación Git.';
  @override
  String get suggestion =>
      'Verifica tus credenciales en Ajustes > Control de Versiones.';
}

// Path: friendlyErrors.gitOperationFailed
class _TranslationsFriendlyErrorsGitOperationFailedEs
    implements TranslationsFriendlyErrorsGitOperationFailedEn {
  _TranslationsFriendlyErrorsGitOperationFailedEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Una operación Git falló.';
  @override
  String get suggestion => 'Revisa la vista Git para más detalles.';
}

// Path: friendlyErrors.invalidJson
class _TranslationsFriendlyErrorsInvalidJsonEs
    implements TranslationsFriendlyErrorsInvalidJsonEn {
  _TranslationsFriendlyErrorsInvalidJsonEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'El formato de archivo es inválido o corrupto.';
  @override
  String get suggestion =>
      'Asegura que el archivo contiene contenido JSON válido.';
}

// Path: friendlyErrors.rateLimitReached
class _TranslationsFriendlyErrorsRateLimitReachedEs
    implements TranslationsFriendlyErrorsRateLimitReachedEn {
  _TranslationsFriendlyErrorsRateLimitReachedEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Límite de traducción alcanzado.';
  @override
  String get suggestion =>
      'Espera unos minutos o verifica los límites de tu plan API.';
}

// Path: friendlyErrors.invalidApiKey
class _TranslationsFriendlyErrorsInvalidApiKeyEs
    implements TranslationsFriendlyErrorsInvalidApiKeyEn {
  _TranslationsFriendlyErrorsInvalidApiKeyEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Clave API inválida.';
  @override
  String get suggestion =>
      'Ve a Ajustes > Traducción IA para actualizar tu clave API.';
}

// Path: friendlyErrors.translationServiceError
class _TranslationsFriendlyErrorsTranslationServiceErrorEs
    implements TranslationsFriendlyErrorsTranslationServiceErrorEn {
  _TranslationsFriendlyErrorsTranslationServiceErrorEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Error del servicio de traducción.';
  @override
  String get suggestion => 'Verifica tu clave API y conexión a internet.';
}

// Path: friendlyErrors.outOfMemory
class _TranslationsFriendlyErrorsOutOfMemoryEs
    implements TranslationsFriendlyErrorsOutOfMemoryEn {
  _TranslationsFriendlyErrorsOutOfMemoryEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message =>
      'No hay suficiente memoria para completar esta operación.';
  @override
  String get suggestion =>
      'Intenta cerrar otras aplicaciones o usar archivos más pequeños.';
}

// Path: friendlyErrors.genericError
class _TranslationsFriendlyErrorsGenericErrorEs
    implements TranslationsFriendlyErrorsGenericErrorEn {
  _TranslationsFriendlyErrorsGenericErrorEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Algo salió mal.';
  @override
  String get suggestion =>
      'Por favor intenta de nuevo. Si el problema persiste, reinicia la app.';
}

// Path: settings.appearance.presets
class _TranslationsSettingsAppearancePresetsEs
    implements TranslationsSettingsAppearancePresetsEn {
  _TranslationsSettingsAppearancePresetsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get presetDefault => 'Por defecto';
  @override
  String get presetColorblind => 'Daltónicos';
  @override
  String get presetHighContrast => 'Alto Contraste';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.appearance.preview
class _TranslationsSettingsAppearancePreviewEs
    implements TranslationsSettingsAppearancePreviewEn {
  _TranslationsSettingsAppearancePreviewEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get step3Title => 'onboarding.step3.title';
  @override
  String get connectAccount => '"Conecta tu Cuenta"';
  @override
  String get loginHint => 'deprecated.login_hint_v1';
  @override
  String get enterCredentials => '"Introduce credenciales"';
  @override
  String get ctaButton => 'checkout.cta_button';
  @override
  String get buyNow => '"Comprar Ahora"';
  @override
  String get completePurchase => '"Finalizar Compra"';
  @override
  String get appNameKey => 'common.app_name';
  @override
  String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class _TranslationsSettingsComparisonPatternPresetsEs
    implements TranslationsSettingsComparisonPatternPresetsEn {
  _TranslationsSettingsComparisonPatternPresetsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get comments => 'Comentarios';
  @override
  String get tempKeys => 'Claves Temp';
  @override
  String get placeholders => 'Marcadores';
  @override
  String get devOnly => 'Solo Dev';
}

// Path: settings.comparison.previewMatch
class _TranslationsSettingsComparisonPreviewMatchEs
    implements TranslationsSettingsComparisonPreviewMatchEn {
  _TranslationsSettingsComparisonPreviewMatchEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Probar Coincidencia';
  @override
  String get description =>
      'Prueba cómo afectan tus ajustes a la lógica de emparejamiento.';
  @override
  String get stringA => 'Cadena A';
  @override
  String get stringB => 'Cadena B';
  @override
  String get enterText => 'Introduce texto...';
  @override
  String get similarity => 'Similitud';
  @override
  String get identical => 'Idéntico';
  @override
  String get identicalDescription => 'Cadenas idénticas tras normalización.';
  @override
  String get ignored => 'Ignorado';
  @override
  String get ignoredDescription => 'Entrada coincide con un patrón ignorado.';
  @override
  String get different => 'Diferente';
  @override
  String get differentDescription => 'Un valor está vacío.';
  @override
  String get similarModified => 'Similar / Modificado';
  @override
  String similarModifiedDescription({required Object threshold}) =>
      'Puntuación por encima del umbral (${threshold}%).';
  @override
  String get newDifferent => 'Nuevo / Diferente';
  @override
  String newDifferentDescription({required Object threshold}) =>
      'Puntuación por debajo del umbral (${threshold}%).';
}

// Path: settings.comparison.colorPresets
class _TranslationsSettingsComparisonColorPresetsEs
    implements TranslationsSettingsComparisonColorPresetsEn {
  _TranslationsSettingsComparisonColorPresetsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get kDefault => 'Por defecto';
  @override
  String get colorblindFriendly => 'Daltónicos';
  @override
  String get highContrast => 'Alto Contraste';
  @override
  String get nord => 'Nord';
  @override
  String get solarized => 'Solarized';
  @override
  String get monokai => 'Monokai';
  @override
  String get presetDefault => 'Por defecto';
  @override
  String get presetColorblind => 'Daltónicos';
  @override
  String get presetHighContrast => 'Alto Contraste';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.integrations.materials
class _TranslationsSettingsIntegrationsMaterialsEs
    implements TranslationsSettingsIntegrationsMaterialsEn {
  _TranslationsSettingsIntegrationsMaterialsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get sidebar => 'Barra Lateral';
  @override
  String get menu => 'Menú';
  @override
  String get popover => 'Emergente';
  @override
  String get titlebar => 'Barra de Título';
  @override
  String get underPageBackground => 'Fondo Página';
  @override
  String get contentBackground => 'Contenido';
}

// Path: settings.integrations.fileTypes
class _TranslationsSettingsIntegrationsFileTypesEs
    implements TranslationsSettingsIntegrationsFileTypesEn {
  _TranslationsSettingsIntegrationsFileTypesEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get loc => 'Archivo Proyecto Localizer';
  @override
  String get lang => 'Archivo Idioma';
  @override
  String get json => 'Archivo Localización JSON';
  @override
  String get xml => 'Archivo Localización XML';
}

// Path: settings.developer.themePlaygroundSection
class _TranslationsSettingsDeveloperThemePlaygroundSectionEs
    implements TranslationsSettingsDeveloperThemePlaygroundSectionEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get colors => 'Colores';
  @override
  String get typography => 'Tipografía';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEs
      palette =
      _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEs._(_root);
}

// Path: settings.developer.featureFlags
class _TranslationsSettingsDeveloperFeatureFlagsEs
    implements TranslationsSettingsDeveloperFeatureFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Características Experimentales';
  @override
  String get description =>
      'Alternar banderas de características localmente para pruebas. Persisten tras reiniciar.';
  @override
  String get subtitle => 'Anular características experimentales';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEs flags =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsEs._(_root);
  @override
  String get reset => 'Restablecer Todas';
  @override
  String get overrides => 'Anulaciones Locales';
  @override
  String get defaultVal => 'Por Defecto';
  @override
  String get on => 'ON';
  @override
  String get off => 'OFF';
}

// Path: settings.developer.storageInspectorSection
class _TranslationsSettingsDeveloperStorageInspectorSectionEs
    implements TranslationsSettingsDeveloperStorageInspectorSectionEn {
  _TranslationsSettingsDeveloperStorageInspectorSectionEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'Actualizar';
  @override
  String get hiveData => 'Datos Hive';
  @override
  String get secureStorage => 'Almacenamiento Seguro';
}

// Path: settings.developer.deviceInfoSection
class _TranslationsSettingsDeveloperDeviceInfoSectionEs
    implements TranslationsSettingsDeveloperDeviceInfoSectionEn {
  _TranslationsSettingsDeveloperDeviceInfoSectionEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'Actualizar';
  @override
  String get copy => 'Copiar al Portapapeles';
  @override
  String get computerName => 'Nombre Equipo';
  @override
  String get osVersion => 'Versión SO';
}

// Path: settings.developer.localizationInspectorSection
class _TranslationsSettingsDeveloperLocalizationInspectorSectionEs
    implements TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
  _TranslationsSettingsDeveloperLocalizationInspectorSectionEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get showKeys => 'Mostrar Claves en vez de Valores';
  @override
  String get keysVisible => 'Claves visibles';
  @override
  String get normalDisplay => 'Visualización normal';
  @override
  String get note =>
      'Nota: Requiere que la localización use un wrapper que respete este ajuste.';
}

// Path: settings.onboarding.steps
class _TranslationsSettingsOnboardingStepsEs
    implements TranslationsSettingsOnboardingStepsEn {
  _TranslationsSettingsOnboardingStepsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsOnboardingStepsImportFilesEs importFiles =
      _TranslationsSettingsOnboardingStepsImportFilesEs._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsRunComparisonEs runComparison =
      _TranslationsSettingsOnboardingStepsRunComparisonEs._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsReviewMissingEs reviewMissing =
      _TranslationsSettingsOnboardingStepsReviewMissingEs._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsUseFiltersEs useFilters =
      _TranslationsSettingsOnboardingStepsUseFiltersEs._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsSearchResultsEs searchResults =
      _TranslationsSettingsOnboardingStepsSearchResultsEs._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsAdvancedViewEs advancedView =
      _TranslationsSettingsOnboardingStepsAdvancedViewEs._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsEditCellEs editCell =
      _TranslationsSettingsOnboardingStepsEditCellEs._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsExportResultsEs exportResults =
      _TranslationsSettingsOnboardingStepsExportResultsEs._(_root);
}

// Path: settings.settingsView.categories
class _TranslationsSettingsSettingsViewCategoriesEs
    implements TranslationsSettingsSettingsViewCategoriesEn {
  _TranslationsSettingsSettingsViewCategoriesEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'Ajustes Generales';
  @override
  String get comparisonEngine => 'Motor de Comparación';
  @override
  String get appearance => 'Apariencia';
  @override
  String get fileHandling => 'Manejo de Archivos';
  @override
  String get aiServices => 'Servicios IA';
  @override
  String get systemIntegrations => 'Integraciones de Sistema';
  @override
  String get projectResources => 'Recursos de Proyecto (Glosario y MT)';
  @override
  String get developer => 'Opciones de Desarrollador';
  @override
  String get about => 'Acerca de';
}

// Path: settings.settingsView.categoryLabels
class _TranslationsSettingsSettingsViewCategoryLabelsEs
    implements TranslationsSettingsSettingsViewCategoryLabelsEn {
  _TranslationsSettingsSettingsViewCategoryLabelsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'General';
  @override
  String get comparisonEngine => 'Comparación';
  @override
  String get appearance => 'Apariencia';
  @override
  String get fileHandling => 'Manejo de Archivos';
  @override
  String get aiServices => 'Servicios IA';
  @override
  String get systemIntegrations => 'Integraciones de Sistema';
  @override
  String get projectResources => 'Recursos de Proyecto';
  @override
  String get developer => 'Opciones de Desarrollador';
  @override
  String get about => 'Acerca de';
}

// Path: advancedDiff.sidebar.actionsSection
class _TranslationsAdvancedDiffSidebarActionsSectionEs
    implements TranslationsAdvancedDiffSidebarActionsSectionEn {
  _TranslationsAdvancedDiffSidebarActionsSectionEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get exportMatches => 'Exportar coincidencias';
  @override
  String get preview => 'Vista previa';
  @override
  String get fillFromTmTitle => '¿Rellenar desde Memoria de Traducción?';
  @override
  String get fillFromTmContent =>
      'Esto intentará rellenar valores destino vacíos usando coincidencias de la Memoria de Traducción. Los valores existentes NO se sobrescribirán.';
  @override
  String get fill => 'Rellenar';
  @override
  String get fillFromMemory => 'Rellenar desde Memoria';
  @override
  String filledFromTm({required Object count}) =>
      'Rellenados ${count} elementos desde Memoria de Traducción.';
}

// Path: advancedDiff.sidebar.aiSection
class _TranslationsAdvancedDiffSidebarAiSectionEs
    implements TranslationsAdvancedDiffSidebarAiSectionEn {
  _TranslationsAdvancedDiffSidebarAiSectionEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get infoCloud =>
      'Usa traducción nube para traducir valores destino vacíos desde origen.';
  @override
  String get infoAi =>
      'Usa IA para traducir valores destino vacíos desde origen.';
  @override
  String get translationSettings => 'Ajustes de Traducción';
  @override
  String get aiSettings => 'Ajustes IA';
  @override
  String get source => 'Origen';
  @override
  String get target => 'Destino';
  @override
  String translatingProgress({required Object percent}) =>
      'Traduciendo... ${percent}%';
  @override
  String get translating => 'Traduciendo...';
  @override
  String get translateAllMissing => 'Traducir Todo Faltante';
  @override
  String get translateAllTitle => '¿Traducir Todo Faltante?';
  @override
  String translateAllContent(
          {required Object service,
          required Object source,
          required Object target}) =>
      'Esto usará ${service} para traducir todas las entradas con valores destino vacíos de ${source} a ${target}.\n\nPuedes revisar cada sugerencia o aplicar todo a la vez.';
  @override
  String get translateAll => 'Traducir Todo';
  @override
  String get reviewEach => 'Revisar Cada Uno';
  @override
  String cloudTranslated({required Object count}) =>
      'Traducidas ${count} entradas con traducción nube.';
  @override
  String aiTranslated({required Object count}) =>
      'Traducidas ${count} entradas con IA.';
  @override
  String get aiTranslateFailed => 'Traducción IA de todo falló';
  @override
  String get noMissingEntries => 'No hay entradas faltantes para traducir.';
  @override
  String get skip => 'Saltar';
  @override
  String get stop => 'Detener';
  @override
  String cloudApplied({required Object count}) =>
      'Aplicadas ${count} sugerencias.';
  @override
  String aiApplied({required Object count}) =>
      'Aplicadas ${count} sugerencias IA.';
}

// Path: advancedDiff.sidebar.tmSection
class _TranslationsAdvancedDiffSidebarTmSectionEs
    implements TranslationsAdvancedDiffSidebarTmSectionEn {
  _TranslationsAdvancedDiffSidebarTmSectionEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get enableTmFill => 'Habilitar Relleno MT';
  @override
  String get autoApplyAboveMinimum => 'Auto-aplicar sobre mínimo';
  @override
  String get matchSettings => 'Ajustes de Coincidencia';
  @override
  String get minMatch => 'Coincidencia mín:';
  @override
  String get limit => 'Límite:';
  @override
  String get exact => 'Exacto';
}

// Path: advancedDiff.sidebar.filtersSection
class _TranslationsAdvancedDiffSidebarFiltersSectionEs
    implements TranslationsAdvancedDiffSidebarFiltersSectionEn {
  _TranslationsAdvancedDiffSidebarFiltersSectionEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get viewFilters => 'Filtros de Vista';
  @override
  String get showAll => 'Mostrar Todo';
  @override
  String get added => 'Añadido';
  @override
  String get removed => 'Eliminado';
  @override
  String get modified => 'Modificado';
  @override
  String get actionScope => 'Alcance de Acción';
  @override
  String get applyToAdded => 'Aplicar a Añadido';
  @override
  String get applyToModified => 'Aplicar a Modificado';
  @override
  String get onlyFillEmptyTargets => 'Solo rellenar destinos vacíos';
  @override
  String get limitToVisible => 'Limitar a visibles';
  @override
  String get editMode => 'Modo Edición';
  @override
  String get dialog => 'Diálogo';
  @override
  String get inline => 'En línea';
}

// Path: advancedDiff.sidebar.similaritySection
class _TranslationsAdvancedDiffSidebarSimilaritySectionEs
    implements TranslationsAdvancedDiffSidebarSimilaritySectionEn {
  _TranslationsAdvancedDiffSidebarSimilaritySectionEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get currentFilter => 'Filtro Actual:';
  @override
  String get any => 'CUALQ';
  @override
  String get high => 'ALTA';
  @override
  String get medium => 'MEDIA';
  @override
  String get low => 'BAJA';
}

// Path: advancedDiff.sidebar.statusSection
class _TranslationsAdvancedDiffSidebarStatusSectionEs
    implements TranslationsAdvancedDiffSidebarStatusSectionEn {
  _TranslationsAdvancedDiffSidebarStatusSectionEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String total({required Object count}) => '${count} total';
  @override
  String extra({required Object count}) => '${count} extra';
  @override
  String missing({required Object count}) => '${count} falta';
  @override
  String changed({required Object count}) => '${count} camb';
}

// Path: tutorial.steps.importSource
class _TranslationsTutorialStepsImportSourceEs
    implements TranslationsTutorialStepsImportSourceEn {
  _TranslationsTutorialStepsImportSourceEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => '1. Importar Archivo Origen';
  @override
  String get description =>
      'Usa el botón abajo para examinar archivo, o arrastra y suelta en el área resaltada.';
}

// Path: tutorial.steps.importTarget
class _TranslationsTutorialStepsImportTargetEs
    implements TranslationsTutorialStepsImportTargetEn {
  _TranslationsTutorialStepsImportTargetEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => '2. Importar Archivo Destino';
  @override
  String get description =>
      'Usa el botón abajo para examinar archivo, o arrastra y suelta en el área resaltada.';
}

// Path: tutorial.steps.compare
class _TranslationsTutorialStepsCompareEs
    implements TranslationsTutorialStepsCompareEn {
  _TranslationsTutorialStepsCompareEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => '3. Comparar Archivos';
  @override
  String get description =>
      'Toca el botón abajo para ejecutar la comparación y ver los resultados.';
}

// Path: tutorial.steps.filter
class _TranslationsTutorialStepsFilterEs
    implements TranslationsTutorialStepsFilterEn {
  _TranslationsTutorialStepsFilterEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => '4. Filtrar Resultados';
  @override
  String get description =>
      'Usa estos filtros para ver cadenas Añadidas, Eliminadas o Modificadas.';
}

// Path: tutorial.steps.search
class _TranslationsTutorialStepsSearchEs
    implements TranslationsTutorialStepsSearchEn {
  _TranslationsTutorialStepsSearchEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => '5. Resultados de Búsqueda';
  @override
  String get description =>
      'Encuentra claves o valor específicos usando la barra de búsqueda.';
}

// Path: tutorial.steps.advanced
class _TranslationsTutorialStepsAdvancedEs
    implements TranslationsTutorialStepsAdvancedEn {
  _TranslationsTutorialStepsAdvancedEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => '6. Vista Avanzada';
  @override
  String get description =>
      'Abre la vista detallada de diff con edición, traducción IA y más.';
}

// Path: tutorial.steps.export
class _TranslationsTutorialStepsExportEs
    implements TranslationsTutorialStepsExportEn {
  _TranslationsTutorialStepsExportEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => '7. Exportar Resultados';
  @override
  String get description =>
      'Guarda tu comparación como archivo CSV, JSON o Excel.';
}

// Path: settings.developer.themePlaygroundSection.palette
class _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEs
    implements TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get primary => 'Primario';
  @override
  String get onPrimary => 'En Primario';
  @override
  String get secondary => 'Secundario';
  @override
  String get onSecondary => 'En Secundario';
  @override
  String get surface => 'Superficie';
  @override
  String get onSurface => 'En Superficie';
  @override
  String get error => 'Error';
  @override
  String get onError => 'En Error';
  @override
  String get outline => 'Contorno';
  @override
  String get shadow => 'Sombra';
  @override
  String get success => 'Éxito';
  @override
  String get warning => 'Advertencia';
  @override
  String get info => 'Info';
}

// Path: settings.developer.featureFlags.flags
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEs
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEs
      experimental_ai_batch =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEs._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEs
      new_diff_algorithm =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEs._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEs
      enhanced_search =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEs._(_root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEs
      auto_save =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEs._(_root);
}

// Path: settings.onboarding.steps.importFiles
class _TranslationsSettingsOnboardingStepsImportFilesEs
    implements TranslationsSettingsOnboardingStepsImportFilesEn {
  _TranslationsSettingsOnboardingStepsImportFilesEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Importar Archivos';
  @override
  String get description => 'Carga archivos de origen y destino';
}

// Path: settings.onboarding.steps.runComparison
class _TranslationsSettingsOnboardingStepsRunComparisonEs
    implements TranslationsSettingsOnboardingStepsRunComparisonEn {
  _TranslationsSettingsOnboardingStepsRunComparisonEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ejecutar Comparación';
  @override
  String get description => 'Haz clic en "Comparar Archivos"';
}

// Path: settings.onboarding.steps.reviewMissing
class _TranslationsSettingsOnboardingStepsReviewMissingEs
    implements TranslationsSettingsOnboardingStepsReviewMissingEn {
  _TranslationsSettingsOnboardingStepsReviewMissingEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Revisar Faltantes';
  @override
  String get description => 'Nota los elementos rojos FALTANTES';
}

// Path: settings.onboarding.steps.useFilters
class _TranslationsSettingsOnboardingStepsUseFiltersEs
    implements TranslationsSettingsOnboardingStepsUseFiltersEn {
  _TranslationsSettingsOnboardingStepsUseFiltersEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Usar Filtros';
  @override
  String get description => 'Filtrar por tipo';
}

// Path: settings.onboarding.steps.searchResults
class _TranslationsSettingsOnboardingStepsSearchResultsEs
    implements TranslationsSettingsOnboardingStepsSearchResultsEn {
  _TranslationsSettingsOnboardingStepsSearchResultsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Resultados de Búsqueda';
  @override
  String get description => 'Encuentra claves específicas';
}

// Path: settings.onboarding.steps.advancedView
class _TranslationsSettingsOnboardingStepsAdvancedViewEs
    implements TranslationsSettingsOnboardingStepsAdvancedViewEn {
  _TranslationsSettingsOnboardingStepsAdvancedViewEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Vista Avanzada';
  @override
  String get description => 'Explora análisis detallado';
}

// Path: settings.onboarding.steps.editCell
class _TranslationsSettingsOnboardingStepsEditCellEs
    implements TranslationsSettingsOnboardingStepsEditCellEn {
  _TranslationsSettingsOnboardingStepsEditCellEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Editar una Celda';
  @override
  String get description => 'Haz clic para editar un valor';
}

// Path: settings.onboarding.steps.exportResults
class _TranslationsSettingsOnboardingStepsExportResultsEs
    implements TranslationsSettingsOnboardingStepsExportResultsEn {
  _TranslationsSettingsOnboardingStepsExportResultsEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Exportar';
  @override
  String get description => 'Guarda tu informe';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEs
    implements
        TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEs._(
      this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Lote IA Experimental';
  @override
  String get description => 'Habilitar traducción IA por lotes';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEs
    implements
        TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEs._(
      this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Nuevo Algoritmo Diff';
  @override
  String get description => 'Usar algoritmo diff mejorado';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEs
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Búsqueda Mejorada';
  @override
  String get description => 'Habilitar búsqueda difusa en traducciones';
}

// Path: settings.developer.featureFlags.flags.auto_save
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEs
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEs._(this._root);

  final TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Auto Guardado';
  @override
  String get description => 'Guardar cambios automáticamente tras editar';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
          'app.title' => 'Herramienta de Comparación de Localización',
          'app.name' => 'Localizer',
          'common.save' => 'Guardar',
          'common.cancel' => 'Cancelar',
          'common.close' => 'Cerrar',
          'common.delete' => 'Eliminar',
          'common.edit' => 'Editar',
          'common.add' => 'Añadir',
          'common.search' => 'Buscar',
          'common.undo' => 'Deshacer',
          'common.loading' => 'Cargando...',
          'common.error' => 'Error',
          'common.success' => 'Éxito',
          'common.warning' => 'Advertencia',
          'common.info' => 'Información',
          'common.confirm' => 'Confirmar',
          'common.yes' => 'Sí',
          'common.no' => 'No',
          'common.ok' => 'Aceptar',
          'common.retry' => 'Reintentar',
          'common.copyText' => 'Copiar',
          'common.appName' => 'Localizer',
          'common.copied' => '¡Copiado!',
          'common.enabled' => 'Habilitado',
          'common.disabled' => 'Deshabilitado',
          'common.browse' => 'Examinar',
          'common.clear' => 'Limpiar',
          'common.apply' => 'Aplicar',
          'common.reset' => 'Restablecer',
          'common.refresh' => 'Actualizar',
          'common.export' => 'Exportar',
          'common.import' => 'Importar',
          'common.select' => 'Seleccionar',
          'common.selectAll' => 'Seleccionar todo',
          'common.deselectAll' => 'Deselect. todo',
          'common.noResults' => 'No se encontraron resultados',
          'common.emptyState' => 'No hay nada aquí todavía',
          'common.open' => 'Abrir',
          'common.change' => 'Cambiar',
          'common.original' => 'Original',
          'common.kNew' => 'Nuevo',
          'common.remove' => 'Quitar',
          'common.auto' => 'Auto',
          'common.execute' => 'Ejecutar',
          'common.run' => 'Ejecutar',
          'common.unknown' => 'Desconocido',
          'common.download' => 'Descargar',
          'common.dropdownArrow' => 'Flecha desplegable',
          'common.openInNewWindow' => 'Abrir en nueva ventana',
          'common.resetToDefaults' => 'Restaurar valores por defecto',
          'menu.file' => 'Archivo',
          'menu.edit' => 'Editar',
          'menu.view' => 'Ver',
          'menu.help' => 'Ayuda',
          'menu.openFiles' => 'Abrir archivos...',
          'menu.openFolder' => 'Abrir carpeta...',
          'menu.exportResults' => 'Exportar resultados...',
          'menu.undo' => 'Deshacer',
          'menu.redo' => 'Rehacer',
          'menu.cut' => 'Cortar',
          'menu.paste' => 'Pegar',
          'menu.selectAll' => 'Seleccionar todo',
          'menu.zoomIn' => 'Acercar',
          'menu.zoomOut' => 'Alejar',
          'menu.resetZoom' => 'Restablecer zoom',
          'menu.documentation' => 'Documentación',
          'menu.reportIssue' => 'Informar un problema',
          'menu.about' => ({required Object appName}) => 'Acerca de ${appName}',
          'nav.compare' => 'Comparar',
          'nav.history' => 'Historial',
          'nav.settings' => 'Ajustes',
          'nav.projects' => 'Proyectos',
          'nav.dashboard' => 'Panel',
          'nav.directory' => 'Directorio',
          'nav.repository' => 'Repositorio',
          'nav.tooltipCompare' => 'Comparar archivos de localización',
          'nav.tooltipHistory' => 'Ver historial de comparaciones',
          'nav.tooltipSettings' => 'Ajustes de la aplicación',
          'nav.tooltipProjects' => 'Gestionar proyectos',
          'nav.tooltipThemeToggle' => 'Alternar tema',
          'nav.tooltipDebugConsole' => 'Consola de depuración',
          'settings.title' => 'Configuración',
          'settings.appSettings' => 'Ajustes de la App',
          'settings.projectSettings' => 'Ajustes del Proyecto',
          'settings.appearance.title' => 'Apariencia',
          'settings.appearance.description' =>
            'Personaliza el aspecto de la aplicación',
          'settings.appearance.theme' => 'Modo de Tema',
          'settings.appearance.themeDescription' =>
            'Elige entre claro, oscuro o sistema',
          'settings.appearance.themeSystem' => 'Sistema',
          'settings.appearance.themeLight' => 'Claro',
          'settings.appearance.themeDark' => 'Oscuro',
          'settings.appearance.themeAmoled' => 'AMOLED',
          'settings.appearance.accentColor' => 'Color de Acento',
          'settings.appearance.accentColorDescription' =>
            'Elige tu color de acento preferido',
          'settings.appearance.useMicaEffect' => 'Usar Efecto Mica',
          'settings.appearance.micaDescription' =>
            'Habilita transparencia Mica de Windows 11 para un look moderno',
          'settings.appearance.diffFontSize' => 'Tamaño Fuente Diff',
          'settings.appearance.diffFontSizeDescription' =>
            'Ajusta el tamaño de fuente de la vista de comparación',
          'settings.appearance.diffFontFamily' => 'Fuente Diff',
          'settings.appearance.diffFontFamilyDescription' =>
            'Fuente para la vista de comparación',
          'settings.appearance.systemDefault' => 'Sistema',
          'settings.appearance.pickAccentColor' => 'Elegir Color',
          'settings.appearance.diffColors' => 'Colores Diff',
          'settings.appearance.presetsTitle' => 'Preajustes',
          'settings.appearance.presets.presetDefault' => 'Por defecto',
          'settings.appearance.presets.presetColorblind' => 'Daltónicos',
          'settings.appearance.presets.presetHighContrast' => 'Alto Contraste',
          'settings.appearance.presets.presetNord' => 'Nord',
          'settings.appearance.presets.presetSolarized' => 'Solarized',
          'settings.appearance.presets.presetMonokai' => 'Monokai',
          'settings.appearance.identical' => 'Idéntico',
          'settings.appearance.pickColorFor' => ({required Object label}) =>
              'Elegir Color para ${label}',
          'settings.appearance.livePreview' => 'Vista Previa',
          'settings.appearance.preview.step3Title' => 'onboarding.step3.title',
          'settings.appearance.preview.connectAccount' => '"Conecta tu Cuenta"',
          'settings.appearance.preview.loginHint' => 'deprecated.login_hint_v1',
          'settings.appearance.preview.enterCredentials' =>
            '"Introduce credenciales"',
          'settings.appearance.preview.ctaButton' => 'checkout.cta_button',
          'settings.appearance.preview.buyNow' => '"Comprar Ahora"',
          'settings.appearance.preview.completePurchase' =>
            '"Finalizar Compra"',
          'settings.appearance.preview.appNameKey' => 'common.app_name',
          'settings.appearance.preview.appNameValue' => '"Localizer"',
          'settings.general.title' => 'General',
          'settings.general.description' =>
            'Configuración general de la aplicación',
          'settings.general.language' => 'Idioma',
          'settings.general.languageDescription' => 'Elige tu idioma preferido',
          'settings.general.startMinimized' => 'Iniciar Minimizado',
          'settings.general.startMinimizedDescription' =>
            'Iniciar la app minimizada en la bandeja',
          'settings.general.rememberWindowPosition' => 'Recordar Posición',
          'settings.general.rememberWindowPositionDescription' =>
            'Restaurar tamaño y posición al iniciar',
          'settings.general.openLastProject' => 'Abrir Último Proyecto',
          'settings.general.openLastProjectDescription' =>
            'Abrir automáticamente el último proyecto usado',
          'settings.general.application' => 'Aplicación',
          'settings.general.defaultView' => 'Vista Por Defecto',
          'settings.general.defaultViewDescription' =>
            'Vista a mostrar al inicio',
          'settings.general.autoCheckUpdates' => 'Buscar Actualizaciones',
          'settings.general.autoCheckUpdatesDescription' =>
            'Buscar actualizaciones al arrancar',
          'settings.general.startupOptions' => 'Opciones de Inicio',
          'settings.general.languageAuto' => 'Auto-Detectar',
          'settings.general.viewBasic' => 'Comparación de Archivos',
          'settings.general.viewHistory' => 'Historial',
          'settings.general.viewDashboard' => 'Panel de Calidad',
          'settings.general.viewDirectory' => 'Comparación de Directorios',
          'settings.general.viewLastUsed' => 'Última Usada',
          'settings.scope.title' => 'Alcance de Ajustes',
          'settings.scope.global' => 'Valores Globales',
          'settings.scope.project' => 'Proyecto',
          'settings.scope.reset' => 'Restaurar Proyecto a Global',
          'settings.scope.resetConfirmation' =>
            'Esto borrará todas las anulaciones para este proyecto y volverá a los valores globales. Esta acción no se puede deshacer.',
          'settings.scope.globalDescription' =>
            'Los cambios se aplican a todos los proyectos salvo que se anulen.',
          'settings.scope.projectDescription' => ({required Object name}) =>
              'Los cambios se aplican solo a "${name}". Otros ajustes heredan de los valores globales.',
          'settings.scope.createPrompt' =>
            'Crea un proyecto para personalizar ajustes en carpetas específicas',
          'settings.searchKeywords.general.0' => 'Idioma',
          'settings.searchKeywords.general.1' => 'Vista Por Defecto',
          'settings.searchKeywords.general.2' => 'Archivos Recientes',
          'settings.searchKeywords.general.3' => 'Abrir Último Proyecto',
          'settings.searchKeywords.general.4' => 'Confirmar Salida',
          'settings.searchKeywords.general.5' => 'Mostrar Notificaciones',
          'settings.searchKeywords.comparisonEngine.0' => 'Modo Comparación',
          'settings.searchKeywords.comparisonEngine.1' => 'Umbral Similitud',
          'settings.searchKeywords.comparisonEngine.2' =>
            'Sensible a Mayús/Minús',
          'settings.searchKeywords.comparisonEngine.3' => 'Ignorar Espacios',
          'settings.searchKeywords.comparisonEngine.4' =>
            'Ignorar Líneas Vacías',
          'settings.searchKeywords.comparisonEngine.5' => 'Ignorar Comentarios',
          'settings.searchKeywords.comparisonEngine.6' => 'Patrones a Ignorar',
          'settings.searchKeywords.appearance.0' => 'Tema',
          'settings.searchKeywords.appearance.1' => 'Modo Tema',
          'settings.searchKeywords.appearance.2' => 'Color Acento',
          'settings.searchKeywords.appearance.3' => 'Tamaño Fuente Diff',
          'settings.searchKeywords.appearance.4' => 'Fuente Diff',
          'settings.searchKeywords.appearance.5' => 'Colores Diff',
          'settings.searchKeywords.appearance.6' => 'Color Añadido',
          'settings.searchKeywords.appearance.7' => 'Color Eliminado',
          'settings.searchKeywords.appearance.8' => 'Color Modificado',
          'settings.searchKeywords.appearance.9' => 'Color Idéntico',
          'settings.searchKeywords.appearance.10' => 'Preajustes Color',
          'settings.searchKeywords.appearance.11' => 'Vista Previa',
          'settings.searchKeywords.fileHandling.0' => 'Formato Origen',
          'settings.searchKeywords.fileHandling.1' => 'Formato Destino',
          'settings.searchKeywords.fileHandling.2' =>
            'Codificación Por Defecto',
          'settings.searchKeywords.fileHandling.3' => 'Proyectos Recientes',
          'settings.searchKeywords.fileHandling.4' => 'Memoria Traducción',
          'settings.searchKeywords.fileHandling.5' => 'Importar Memoria',
          'settings.searchKeywords.fileHandling.6' => 'Exportar Memoria',
          'settings.searchKeywords.fileHandling.7' => 'Limpiar Memoria',
          'settings.searchKeywords.aiServices.0' => 'Clave API OpenAI',
          'settings.searchKeywords.aiServices.1' => 'Clave API Anthropic',
          'settings.searchKeywords.aiServices.2' => 'Clave API Google AI',
          'settings.searchKeywords.aiServices.3' => 'Modelo IA',
          'settings.searchKeywords.aiServices.4' => 'Temperatura',
          'settings.searchKeywords.aiServices.5' => 'Prompt Personalizado',
          'settings.searchKeywords.systemIntegrations.0' => 'Bandeja Sistema',
          'settings.searchKeywords.systemIntegrations.1' =>
            'Iniciar Minimizado',
          'settings.searchKeywords.systemIntegrations.2' =>
            'Asociaciones Archivo',
          'settings.searchKeywords.systemIntegrations.3' => 'Efecto Mica',
          'settings.searchKeywords.systemIntegrations.4' => 'Vibrancy',
          'settings.searchKeywords.systemIntegrations.5' => 'Material Ventana',
          'settings.searchKeywords.systemIntegrations.6' => 'Insignia Dock',
          'settings.searchKeywords.systemIntegrations.7' =>
            'Contador No Traducido',
          'settings.searchKeywords.projectResources.0' => 'Glosario',
          'settings.searchKeywords.projectResources.1' => 'Memoria Traducción',
          'settings.searchKeywords.projectResources.2' => 'Terminología',
          'settings.searchKeywords.about.0' => 'Versión',
          'settings.searchKeywords.about.1' => 'Buscar Actualizaciones',
          'settings.searchKeywords.about.2' => 'Actualización Auto',
          'settings.searchKeywords.about.3' => 'Cambios',
          'settings.searchKeywords.about.4' => 'Licencia',
          'settings.searchKeywords.about.5' => 'Política Privacidad',
          'settings.searchKeywords.about.6' => 'Telemetría',
          'settings.searchKeywords.about.7' => 'Informes Error',
          'settings.searchKeywords.developer.0' => 'Superposición Rendimiento',
          'settings.searchKeywords.developer.1' => 'Depurador Semántica',
          'settings.searchKeywords.developer.2' => 'Rejilla Material',
          'settings.searchKeywords.developer.3' => 'Caché Raster',
          'settings.searchKeywords.developer.4' => 'Reiniciar Tutorial',
          'settings.searchKeywords.developer.5' => 'Restablecimiento Fábrica',
          'settings.comparison.title' => 'Comparación',
          'settings.comparison.description' =>
            'Configurar comportamiento de comparación',
          'settings.comparison.caseSensitive' => 'Sensible a Mayúsculas',
          'settings.comparison.caseSensitiveDescription' =>
            'Tratar mayúsculas y minúsculas como diferentes',
          'settings.comparison.ignoreWhitespace' => 'Ignorar Espacios',
          'settings.comparison.ignoreWhitespaceDescription' =>
            'Ignorar espacios iniciales/finales al comparar',
          'settings.comparison.showLineNumbers' => 'Mostrar Números Línea',
          'settings.comparison.showLineNumbersDescription' =>
            'Mostrar números de línea en la vista diff',
          'settings.comparison.behavior' => 'Comportamiento',
          'settings.comparison.ignoreCase' => 'Ignorar Mayúsculas',
          'settings.comparison.ignoreCaseDescription' =>
            'Tratar "Key" y "key" como iguales',
          'settings.comparison.similarityThreshold' => 'Umbral de Similitud',
          'settings.comparison.similarityThresholdDescription' =>
            'Similitud mínima para detectar "Modificado"',
          'settings.comparison.mode' => 'Modo de Comparación',
          'settings.comparison.modeDescription' =>
            'Cómo emparejar entradas entre archivos',
          'settings.comparison.modeKey' => 'Basado en Claves',
          'settings.comparison.modeKeyDescription' =>
            'Empareja por nombre de clave (defecto).',
          'settings.comparison.modeOrder' => 'Basado en Orden',
          'settings.comparison.modeOrderDescription' =>
            'Empareja por posición en archivo.',
          'settings.comparison.modeSmart' => 'Coincidencia Inteligente',
          'settings.comparison.modeSmartDescription' =>
            'Detecta claves movidas/renombradas.',
          'settings.comparison.ignorePatterns' => 'Patrones a Ignorar',
          'settings.comparison.noIgnorePatterns' => 'Sin patrones definidos.',
          'settings.comparison.addPattern' => 'Añadir Patrón',
          'settings.comparison.resetToGlobal' =>
            'Restablecer comparación a valores globales',
          'settings.comparison.patternPresets.comments' => 'Comentarios',
          'settings.comparison.patternPresets.tempKeys' => 'Claves Temp',
          'settings.comparison.patternPresets.placeholders' => 'Marcadores',
          'settings.comparison.patternPresets.devOnly' => 'Solo Dev',
          'settings.comparison.previewMatch.title' => 'Probar Coincidencia',
          'settings.comparison.previewMatch.description' =>
            'Prueba cómo afectan tus ajustes a la lógica de emparejamiento.',
          'settings.comparison.previewMatch.stringA' => 'Cadena A',
          'settings.comparison.previewMatch.stringB' => 'Cadena B',
          'settings.comparison.previewMatch.enterText' => 'Introduce texto...',
          'settings.comparison.previewMatch.similarity' => 'Similitud',
          'settings.comparison.previewMatch.identical' => 'Idéntico',
          'settings.comparison.previewMatch.identicalDescription' =>
            'Cadenas idénticas tras normalización.',
          'settings.comparison.previewMatch.ignored' => 'Ignorado',
          'settings.comparison.previewMatch.ignoredDescription' =>
            'Entrada coincide con un patrón ignorado.',
          'settings.comparison.previewMatch.different' => 'Diferente',
          'settings.comparison.previewMatch.differentDescription' =>
            'Un valor está vacío.',
          'settings.comparison.previewMatch.similarModified' =>
            'Similar / Modificado',
          'settings.comparison.previewMatch.similarModifiedDescription' => (
                  {required Object threshold}) =>
              'Puntuación por encima del umbral (${threshold}%).',
          'settings.comparison.previewMatch.newDifferent' =>
            'Nuevo / Diferente',
          'settings.comparison.previewMatch.newDifferentDescription' => (
                  {required Object threshold}) =>
              'Puntuación por debajo del umbral (${threshold}%).',
          'settings.comparison.colorPresets.kDefault' => 'Por defecto',
          'settings.comparison.colorPresets.colorblindFriendly' => 'Daltónicos',
          'settings.comparison.colorPresets.highContrast' => 'Alto Contraste',
          'settings.comparison.colorPresets.nord' => 'Nord',
          'settings.comparison.colorPresets.solarized' => 'Solarized',
          'settings.comparison.colorPresets.monokai' => 'Monokai',
          'settings.comparison.colorPresets.presetDefault' => 'Por defecto',
          'settings.comparison.colorPresets.presetColorblind' => 'Daltónicos',
          'settings.comparison.colorPresets.presetHighContrast' =>
            'Alto Contraste',
          'settings.comparison.colorPresets.presetNord' => 'Nord',
          'settings.comparison.colorPresets.presetSolarized' => 'Solarized',
          'settings.comparison.colorPresets.presetMonokai' => 'Monokai',
          'settings.fileHandling.fileFormats' => 'Formatos de Archivo',
          'settings.fileHandling.sourceFormat' => 'Formato Origen',
          'settings.fileHandling.targetFormat' => 'Formato Destino',
          'settings.fileHandling.encoding' => 'Codificación',
          'settings.fileHandling.sourceEncoding' => 'Codificación Origen',
          'settings.fileHandling.targetEncoding' => 'Codificación Destino',
          'settings.fileHandling.autoDetect' => 'Auto-Detectar',
          'settings.fileHandling.autoDetectEncodingDescription' =>
            'Detectar automáticamente codificación del archivo',
          'settings.fileHandling.exportSettings' => 'Ajustes de Exportación',
          'settings.fileHandling.defaultExportFormat' =>
            'Formato Exportación por Defecto',
          'settings.fileHandling.includeUtf8Bom' => 'Incluir UTF-8 BOM',
          'settings.fileHandling.includeUtf8BomDescription' =>
            'Requerido para compatibilidad con Excel',
          'settings.fileHandling.openFolderAfterExport' =>
            'Abrir Carpeta tras Exportar',
          'settings.fileHandling.fileSafety' => 'Seguridad de Archivos',
          'settings.fileHandling.fileSafetyDescription' =>
            'Copias locales automáticas para recuperación ante desastres.',
          'settings.fileHandling.resetToGlobal' =>
            'Restablecer manejo de archivos a valores globales',
          'settings.translationMemory.title' => 'Memoria de Traducción Global',
          'settings.translationMemory.autoLearn' => 'Auto-aprendizaje',
          'settings.translationMemory.autoLearnDescription' =>
            'Guardar traducciones en memoria local para reutilizar',
          'settings.translationMemory.confidenceThreshold' =>
            'Umbral de Confianza',
          'settings.translationMemory.confidenceThresholdDescription' => (
                  {required Object percent}) =>
              'Puntuación mínima para auto-aplicar (${percent}%)',
          'settings.translationMemory.entries' => 'Entradas',
          'settings.translationMemory.size' => 'Tamaño',
          'settings.translationMemory.memorySize' => ({required Object size}) =>
              'Tamaño Memoria: ${size}',
          'settings.translationMemory.import' => 'Importar',
          'settings.translationMemory.exportTmx' => 'Exportar TMX',
          'settings.translationMemory.exportCsv' => 'Exportar CSV',
          'settings.translationMemory.clearMemory' => 'Limpiar Memoria',
          'settings.translationMemory.importedItems' => (
                  {required Object count}) =>
              'Importados ${count} elementos a la memoria.',
          'settings.translationMemory.noItemsAdded' =>
            'No se añadieron elementos.',
          'settings.translationMemory.nothingToExport' =>
            'Nada que exportar todavía.',
          'settings.translationMemory.tmxSaved' => 'TMX guardado',
          'settings.translationMemory.csvSaved' => 'CSV guardado',
          'settings.translationMemory.clearConfirmTitle' =>
            '¿Limpiar memoria de traducción?',
          'settings.translationMemory.clearConfirmContent' =>
            'Esto eliminará todos los pares de traducción guardados en este dispositivo. Esta acción no se puede deshacer.',
          'settings.translationMemory.cleared' =>
            'Memoria de traducción limpiada.',
          'settings.translationMemory.couldNotClear' =>
            'No se pudo limpiar la memoria.',
          'settings.backup.title' => 'Copia de Seguridad Auto',
          'settings.backup.description' => 'Ajustes de respaldo automático',
          'settings.backup.enabled' => 'Habilitar Auto-Respaldo',
          'settings.backup.enabledDescription' =>
            'Respaldar archivos automáticamente antes de cambios',
          'settings.backup.maxCopies' => 'Máximas Copias',
          'settings.backup.maxCopiesDescription' =>
            'Número de copias a mantener por archivo',
          'settings.backup.activeStatus' => ({required Object count}) =>
              'Activo · Manteniendo ${count} copias',
          'settings.backup.folder' => 'Carpeta de Respaldo',
          'settings.backup.folderDescription' =>
            'Dejar vacío para usar la misma carpeta',
          'settings.backup.useOriginalFolder' =>
            'Usar carpeta original del archivo',
          'settings.ai.title' => 'Servicios IA',
          'settings.ai.description' =>
            'Configurar traducción y asistencia por IA',
          'settings.ai.provider' => 'Proveedor IA',
          'settings.ai.providerDescription' =>
            'Elige tu proveedor de servicios IA preferido',
          'settings.ai.apiKey' => 'Clave API',
          'settings.ai.apiKeyDescription' =>
            'Introduce tu clave API para el proveedor seleccionado',
          'settings.ai.apiKeyPlaceholder' => 'Introduce clave API...',
          'settings.ai.testConnection' => 'Probar Conexión',
          'settings.ai.connectionSuccess' => '¡Conexión exitosa!',
          'settings.ai.connectionFailed' =>
            'Conexión fallida. Revisa tu clave API.',
          'settings.ai.translationStrategy' => 'Estrategia de Traducción',
          'settings.ai.strategy' => 'Estrategia',
          'settings.ai.strategyDescription' =>
            'Selecciona cómo quieres traducir cadenas',
          'settings.ai.strategyLLM' => 'IA Generativa (LLM)',
          'settings.ai.strategyCloud' => 'Traducción en la Nube',
          'settings.ai.enableAiTranslation' => 'Habilitar Traducción IA',
          'settings.ai.enableAiTranslationDescription' =>
            'Permitir que la app use IA para sugerencias de traducción',
          'settings.ai.llmProvider' => 'Proveedor Servicio LLM',
          'settings.ai.service' => 'Servicio',
          'settings.ai.serviceDescription' => 'Proveedor para IA Generativa',
          'settings.ai.providerGemini' => 'Google Gemini',
          'settings.ai.providerOpenAI' => 'OpenAI',
          'settings.ai.geminiApiKey' => 'Clave API Gemini',
          'settings.ai.openAiApiKey' => 'Clave API OpenAI',
          'settings.ai.model' => 'Modelo',
          'settings.ai.modelDescription' => 'Selecciona qué modelo usar',
          'settings.ai.advancedParameters' => 'Parámetros Avanzados',
          'settings.ai.parameters' => 'Parámetros',
          'settings.ai.parametersDescription' => 'Temperatura, Contexto y más',
          'settings.ai.temperature' => 'Temperatura',
          'settings.ai.temperatureDescription' =>
            'Valores más altos hacen la salida más creativa',
          'settings.ai.maxTokens' => 'Max Tokens',
          'settings.ai.maxTokensDescription' =>
            'Límite longitud ventana contexto',
          'settings.ai.systemContext' => 'Contexto del Sistema / Instrucciones',
          'settings.ai.systemContextHint' =>
            'Eres un localizador profesional. Mantén el tono e intención...',
          'settings.ai.systemContextHelper' =>
            'Da instrucciones específicas a la IA sobre el estilo y terminología.',
          'settings.ai.contextStrings' => 'Cadenas de Contexto',
          'settings.ai.contextStringsDescription' =>
            'Incluir cadenas circundantes para mejor contexto',
          'settings.ai.contextCount' => 'Cantidad Contexto',
          'settings.ai.contextCountDescription' =>
            'Número de cadenas circundantes a incluir',
          'settings.ai.cloudServices' => 'Servicios Traducción Nube',
          'settings.ai.googleTranslateApiKey' => 'Clave API Google Translate',
          'settings.ai.deeplApiKey' => 'Clave API DeepL',
          'settings.ai.test' => 'Probar',
          'settings.ai.resetToGlobal' => 'Restablecer ajustes IA a globales',
          'settings.integrations.platformNotice' => 'Aviso de Plataforma',
          'settings.integrations.platformNoticeDescription' =>
            'Las integraciones del sistema no están disponibles para esta plataforma.',
          'settings.integrations.visualEffects' => 'Efectos Visuales',
          'settings.integrations.explorerIntegration' =>
            'Integración con Explorador',
          'settings.integrations.explorerIntegrationDescription' =>
            'Añade "Abrir con Localizer" al menú contextual del Explorador de Windows para carpetas.',
          'settings.integrations.addToContextMenu' =>
            'Añadir al Menú Contextual',
          'settings.integrations.contextMenuAdded' =>
            '¡Menú contextual añadido!',
          'settings.integrations.contextMenuAddError' =>
            'Fallo al añadir menú contextual',
          'settings.integrations.contextMenuRemoved' =>
            '¡Menú contextual eliminado!',
          'settings.integrations.contextMenuRemoveError' =>
            'Fallo al eliminar menú contextual',
          'settings.integrations.fileAssociations' => 'Asociaciones de Archivo',
          'settings.integrations.fileAssociationsDescription' =>
            'Registra tipos de archivo para abrir con Localizer al hacer doble clic en el Explorador.',
          'settings.integrations.registered' => 'Registrado',
          'settings.integrations.notRegistered' => 'No Registrado',
          'settings.integrations.extRegistered' => ({required Object ext}) =>
              '¡${ext} registrado!',
          'settings.integrations.extUnregistered' => ({required Object ext}) =>
              '¡${ext} desregistrado!',
          'settings.integrations.extError' => (
                  {required Object action, required Object ext}) =>
              'Fallo al ${action} ${ext}',
          'settings.integrations.registerAll' => 'Registrar Todo',
          'settings.integrations.unregisterAll' => 'Desregistrar Todo',
          'settings.integrations.registerAllResult' => (
                  {required Object success, required Object total}) =>
              'Registrados ${success} de ${total} tipos de archivo',
          'settings.integrations.unregisterAllResult' => (
                  {required Object success, required Object total}) =>
              'Desregistrados ${success} de ${total} tipos de archivo',
          'settings.integrations.protocolHandler' => 'Manejador de Protocolo',
          'settings.integrations.protocolHandlerDescription' =>
            'Registra URLs localizer:// para abrir esta aplicación. Permite abrir proyectos desde enlaces web.',
          'settings.integrations.protocolRegistered' =>
            'Manejador de protocolo registrado',
          'settings.integrations.protocolNotRegistered' =>
            'Manejador de protocolo no registrado',
          'settings.integrations.registerProtocol' => 'Registrar Protocolo',
          'settings.integrations.unregister' => 'Desregistrar',
          'settings.integrations.protocolRegisteredSuccess' =>
            '¡Manejador de protocolo registrado!',
          'settings.integrations.protocolRemovedSuccess' =>
            '¡Manejador de protocolo eliminado!',
          'settings.integrations.protocolRegisterError' => 'Fallo al registrar',
          'settings.integrations.protocolRemoveError' => 'Fallo al eliminar',
          'settings.integrations.windowMaterial' => 'Material de Ventana',
          'settings.integrations.windowMaterialDescription' =>
            'Selecciona el estilo de material vibrancy de macOS',
          'settings.integrations.dockIntegration' => 'Integración Dock',
          'settings.integrations.showDockBadge' =>
            'Mostrar Contador No Traducido',
          'settings.integrations.showDockBadgeDescription' =>
            'Muestra el contador de cadenas no traducidas en la insignia del icono del dock',
          'settings.integrations.materials.sidebar' => 'Barra Lateral',
          'settings.integrations.materials.menu' => 'Menú',
          'settings.integrations.materials.popover' => 'Emergente',
          'settings.integrations.materials.titlebar' => 'Barra de Título',
          'settings.integrations.materials.underPageBackground' =>
            'Fondo Página',
          'settings.integrations.materials.contentBackground' => 'Contenido',
          'settings.integrations.fileTypes.loc' => 'Archivo Proyecto Localizer',
          'settings.integrations.fileTypes.lang' => 'Archivo Idioma',
          'settings.integrations.fileTypes.json' => 'Archivo Localización JSON',
          'settings.integrations.fileTypes.xml' => 'Archivo Localización XML',
          'settings.developer.title' => 'Ajustes de Desarrollador',
          'settings.developer.description' =>
            'Ajustes avanzados para desarrolladores',
          'settings.developer.showLocalizationKeys' =>
            'Mostrar Claves de Localización',
          'settings.developer.localizationKeysDescription' =>
            'Al habilitar, todo el texto traducido mostrará sus claves de localización en lugar del valor. Útil para verificar claves.',
          'settings.developer.showPerformanceOverlay' =>
            'Mostrar Superposición de Rendimiento',
          'settings.developer.performanceOverlayDescription' =>
            'Muestra FPS e información de tiempos de cuadro',
          'settings.developer.debugMode' => 'Modo Depuración',
          'settings.developer.debugModeDescription' =>
            'Habilita registros adicionales y funciones de depuración',
          'settings.developer.debuggingTools' => 'Herramientas de Depuración',
          'settings.developer.semanticsDebugger' => 'Depurador de Semántica',
          'settings.developer.semanticsDebuggerDescription' =>
            'Visualizar árbol de semántica',
          'settings.developer.materialGrid' => 'Rejilla Material',
          'settings.developer.materialGridDescription' =>
            'Superponer rejilla de diseño material',
          'settings.developer.rasterCache' => 'Imágenes Caché Raster',
          'settings.developer.rasterCacheDescription' =>
            'Imágenes caché raster en tablero de ajedrez',
          'settings.developer.actions' => 'Acciones',
          'settings.developer.showLogs' => 'Mostrar Registros App',
          'settings.developer.showLogsDescription' =>
            'Abrir consola de depuración Talker',
          'settings.developer.restartTutorial' =>
            'Reiniciar Tutorial de Bienvenida',
          'settings.developer.restartTutorialDescription' =>
            'Restablecer banderas e iniciar tutorial de nuevo',
          'settings.developer.restartRequested' =>
            'Reinicio de tutorial solicitado.',
          'settings.developer.throwException' => 'Lanzar Excepción de Prueba',
          'settings.developer.throwExceptionDescription' =>
            'Provocar una excepción de prueba para informes de fallo',
          'settings.developer.testExceptionMessage' =>
            'Excepción de prueba desde Opciones de Desarrollador',
          'settings.developer.clearTM' => 'Limpiar Memoria de Traducción',
          'settings.developer.clearTMDescription' =>
            'Borrar todas las traducciones en caché',
          'settings.developer.clearTMConfirmation' =>
            '¿Limpiar Memoria de Traducción?',
          'settings.developer.clearTMWarning' =>
            'Esto borrará todas las traducciones aprendidas. No se puede deshacer.',
          'settings.developer.tmCleared' => 'Memoria de traducción limpiada',
          'settings.developer.clearApiKeys' => 'Limpiar Claves API',
          'settings.developer.clearApiKeysDescription' =>
            'Eliminar todas las claves API almacenadas',
          'settings.developer.clearApiKeysConfirmation' =>
            '¿Limpiar Claves API?',
          'settings.developer.clearApiKeysWarning' =>
            'Esto eliminará todas las claves API del almacenamiento seguro.',
          'settings.developer.apiKeysCleared' => 'Claves API limpiadas',
          'settings.developer.hideOptions' =>
            'Ocultar Opciones de Desarrollador',
          'settings.developer.hideOptionsDescription' =>
            'Deshabilitar modo desarrollador (requiere 7 toques para rehabilitar)',
          'settings.developer.optionsDisabled' =>
            'Opciones de desarrollador deshabilitadas',
          'settings.developer.dangerZone' => 'Zona de Peligro',
          'settings.developer.factoryReset' => 'Restablecimiento de Fábrica',
          'settings.developer.factoryResetDescription' =>
            'Restablecer todos los ajustes y borrar datos',
          'settings.developer.factoryResetWarning' =>
            '¿Seguro que quieres restablecer todos los ajustes? No se puede deshacer.',
          'settings.developer.inspectionTools' => 'Herramientas de Inspección',
          'settings.developer.searchHint' => 'Buscar ajustes...',
          'settings.developer.resetToDefault' =>
            'Restablecer a valores por defecto',
          'settings.developer.resetToGlobal' => 'Restablecer a valor global',
          'settings.developer.storageInspector' =>
            'Inspector de Almacenamiento',
          'settings.developer.storageInspectorDescription' =>
            'Ver contenidos de Hive y Almacenamiento Seguro',
          'settings.developer.deviceEnvironment' => 'Dispositivo y Entorno',
          'settings.developer.deviceEnvironmentDescription' =>
            'Info de pantalla, plataforma y compilación',
          'settings.developer.themePlayground' => 'Zona de Pruebas de Tema',
          'settings.developer.themePlaygroundDescription' =>
            'Paleta de colores y tipografía',
          'settings.developer.themePlaygroundSection.colors' => 'Colores',
          'settings.developer.themePlaygroundSection.typography' =>
            'Tipografía',
          'settings.developer.themePlaygroundSection.palette.primary' =>
            'Primario',
          'settings.developer.themePlaygroundSection.palette.onPrimary' =>
            'En Primario',
          'settings.developer.themePlaygroundSection.palette.secondary' =>
            'Secundario',
          'settings.developer.themePlaygroundSection.palette.onSecondary' =>
            'En Secundario',
          'settings.developer.themePlaygroundSection.palette.surface' =>
            'Superficie',
          'settings.developer.themePlaygroundSection.palette.onSurface' =>
            'En Superficie',
          'settings.developer.themePlaygroundSection.palette.error' => 'Error',
          'settings.developer.themePlaygroundSection.palette.onError' =>
            'En Error',
          'settings.developer.themePlaygroundSection.palette.outline' =>
            'Contorno',
          'settings.developer.themePlaygroundSection.palette.shadow' =>
            'Sombra',
          'settings.developer.themePlaygroundSection.palette.success' =>
            'Éxito',
          'settings.developer.themePlaygroundSection.palette.warning' =>
            'Advertencia',
          'settings.developer.themePlaygroundSection.palette.info' => 'Info',
          'settings.developer.localizationInspector' =>
            'Inspector de Localización',
          'settings.developer.localizationInspectorDescription' =>
            'Depurar cadenas de traducción',
          'settings.developer.hiveAppSettings' => 'Hive (AjustesApp)',
          'settings.developer.secureStorageMasked' =>
            'Almacenamiento Seguro (Enmascarado)',
          'settings.developer.featureFlags.title' =>
            'Características Experimentales',
          'settings.developer.featureFlags.description' =>
            'Alternar banderas de características localmente para pruebas. Persisten tras reiniciar.',
          'settings.developer.featureFlags.subtitle' =>
            'Anular características experimentales',
          'settings.developer.featureFlags.flags.experimental_ai_batch.name' =>
            'Lote IA Experimental',
          'settings.developer.featureFlags.flags.experimental_ai_batch.description' =>
            'Habilitar traducción IA por lotes',
          'settings.developer.featureFlags.flags.new_diff_algorithm.name' =>
            'Nuevo Algoritmo Diff',
          'settings.developer.featureFlags.flags.new_diff_algorithm.description' =>
            'Usar algoritmo diff mejorado',
          'settings.developer.featureFlags.flags.enhanced_search.name' =>
            'Búsqueda Mejorada',
          'settings.developer.featureFlags.flags.enhanced_search.description' =>
            'Habilitar búsqueda difusa en traducciones',
          'settings.developer.featureFlags.flags.auto_save.name' =>
            'Auto Guardado',
          'settings.developer.featureFlags.flags.auto_save.description' =>
            'Guardar cambios automáticamente tras editar',
          'settings.developer.featureFlags.reset' => 'Restablecer Todas',
          'settings.developer.featureFlags.overrides' => 'Anulaciones Locales',
          'settings.developer.featureFlags.defaultVal' => 'Por Defecto',
          'settings.developer.featureFlags.on' => 'ON',
          'settings.developer.featureFlags.off' => 'OFF',
          'settings.developer.storageInspectorSection.refresh' => 'Actualizar',
          'settings.developer.storageInspectorSection.hiveData' => 'Datos Hive',
          'settings.developer.storageInspectorSection.secureStorage' =>
            'Almacenamiento Seguro',
          'settings.developer.deviceInfoSection.refresh' => 'Actualizar',
          'settings.developer.deviceInfoSection.copy' =>
            'Copiar al Portapapeles',
          'settings.developer.deviceInfoSection.computerName' =>
            'Nombre Equipo',
          'settings.developer.deviceInfoSection.osVersion' => 'Versión SO',
          'settings.developer.localizationInspectorSection.showKeys' =>
            'Mostrar Claves en vez de Valores',
          'settings.developer.localizationInspectorSection.keysVisible' =>
            'Claves visibles',
          'settings.developer.localizationInspectorSection.normalDisplay' =>
            'Visualización normal',
          'settings.developer.localizationInspectorSection.note' =>
            'Nota: Requiere que la localización use un wrapper que respete este ajuste.',
          'settings.about.title' => 'Acerca de',
          'settings.about.version' => 'Versión',
          'settings.about.buildNumber' => 'Número de Compilación',
          'settings.about.author' => 'Autor',
          _ => null,
        } ??
        switch (path) {
          'settings.about.license' => 'Licencia',
          'settings.about.sourceCode' => 'Código Fuente',
          'settings.about.reportBug' => 'Informar de un Bug',
          'settings.about.requestFeature' => 'Solicitar una Característica',
          'settings.about.checkForUpdates' => 'Buscar Actualizaciones',
          'settings.about.upToDate' => '¡Estás al día!',
          'settings.about.updateAvailable' => ({required Object version}) =>
              'Actualización disponible: ${version}',
          'settings.about.updateAvailableBadge' => '¡Actualización Disponible!',
          'settings.about.developerSteps' => ({required Object count}) =>
              'Estás a ${count} pasos de ser desarrollador.',
          'settings.about.developerActivated' => '¡Ahora eres desarrollador!',
          'settings.about.neverChecked' => 'Nunca',
          'settings.about.applicationInfo' => 'Info de Aplicación',
          'settings.about.platform' => 'Plataforma',
          'settings.about.updateInformation' => 'Info de Actualización',
          'settings.about.currentVersion' => 'Versión Actual',
          'settings.about.latestVersion' => 'Última Versión',
          'settings.about.lastChecked' => 'Última Comprobación',
          'settings.about.checkingForUpdates' => 'Comprobando...',
          'settings.about.whatsNew' => 'Novedades',
          'settings.about.systemInformation' => 'Información del Sistema',
          'settings.about.dartVersion' => 'Versión de Dart',
          'settings.about.diskSpace' => 'Espacio en Disco',
          'settings.about.memoryUsage' => 'Uso de Memoria',
          'settings.about.privacyTitle' => 'Privacidad y Telemetría',
          'settings.about.usageStats' => 'Estadísticas de Uso Anónimo',
          'settings.about.requiresFirebase' =>
            'Requiere configuración de Firebase',
          'settings.about.featureUnavailable' =>
            'Característica no disponible (Requiere Firebase)',
          'settings.about.settingsManagement' => 'Gestión de Ajustes',
          'settings.about.settingsManagementDescription' =>
            'Exporta tus ajustes a un archivo para respaldarlos o compartir.',
          'settings.about.resetAll' => 'Restablecer Todo',
          'settings.about.links' => 'Enlaces',
          'settings.about.githubRepo' => 'Repositorio GitHub',
          'settings.about.privacyPolicy' => 'Política de Privacidad',
          'settings.about.crashReporting' => 'Informes de Fallos',
          'settings.onboarding.skipTutorial' => 'Saltar Tutorial',
          'settings.onboarding.gettingStarted' => 'Empezando',
          'settings.onboarding.stepProgress' => (
                  {required Object current, required Object total}) =>
              '${current} de ${total}',
          'settings.onboarding.loadSampleData' => 'Cargar Datos de Ejemplo',
          'settings.onboarding.steps.importFiles.title' => 'Importar Archivos',
          'settings.onboarding.steps.importFiles.description' =>
            'Carga archivos de origen y destino',
          'settings.onboarding.steps.runComparison.title' =>
            'Ejecutar Comparación',
          'settings.onboarding.steps.runComparison.description' =>
            'Haz clic en "Comparar Archivos"',
          'settings.onboarding.steps.reviewMissing.title' =>
            'Revisar Faltantes',
          'settings.onboarding.steps.reviewMissing.description' =>
            'Nota los elementos rojos FALTANTES',
          'settings.onboarding.steps.useFilters.title' => 'Usar Filtros',
          'settings.onboarding.steps.useFilters.description' =>
            'Filtrar por tipo',
          'settings.onboarding.steps.searchResults.title' =>
            'Resultados de Búsqueda',
          'settings.onboarding.steps.searchResults.description' =>
            'Encuentra claves específicas',
          'settings.onboarding.steps.advancedView.title' => 'Vista Avanzada',
          'settings.onboarding.steps.advancedView.description' =>
            'Explora análisis detallado',
          'settings.onboarding.steps.editCell.title' => 'Editar una Celda',
          'settings.onboarding.steps.editCell.description' =>
            'Haz clic para editar un valor',
          'settings.onboarding.steps.exportResults.title' => 'Exportar',
          'settings.onboarding.steps.exportResults.description' =>
            'Guarda tu informe',
          'settings.settingsView.resetCategoryTitle' =>
            ({required Object category}) => '¿Restablecer ${category}?',
          'settings.settingsView.resetCategoryContent' =>
            'Esto restablecerá todos los ajustes de esta categoría a sus valores por defecto.',
          'settings.settingsView.resetAllTitle' =>
            '¿Restablecer Todos los Ajustes?',
          'settings.settingsView.resetAllContent' =>
            'Esto restablecerá permanentemente todos los ajustes a sus valores de fábrica. No se puede deshacer.',
          'settings.settingsView.resetAll' => 'Restablecer Todo',
          'settings.settingsView.resetSuccess' => (
                  {required Object category}) =>
              '${category} restablecido por defecto',
          'settings.settingsView.errorLoading' => 'Error cargando ajustes',
          'settings.settingsView.settingsSaved' => 'Ajustes guardados',
          'settings.settingsView.updateAvailable' => (
                  {required Object version}) =>
              'Actualización disponible: v${version}',
          'settings.settingsView.latestVersion' =>
            'Estás usando la última versión',
          'settings.settingsView.whatsNew' => ({required Object version}) =>
              'Novedades en v${version}',
          'settings.settingsView.downloadUpdate' => 'Descargar Actualización',
          'settings.settingsView.exportSettings' => 'Exportar Ajustes',
          'settings.settingsView.settingsExported' => 'Ajustes exportados',
          'settings.settingsView.exportFail' => ({required Object error}) =>
              'Fallo al exportar ajustes: ${error}',
          'settings.settingsView.importSettings' => 'Importar Ajustes',
          'settings.settingsView.importTitle' => '¿Importar Ajustes?',
          'settings.settingsView.importContent' =>
            'Esto reemplazará todos tus ajustes actuales con los importados. No se puede deshacer.',
          'settings.settingsView.importSuccess' =>
            '¡Ajustes importados con éxito!',
          'settings.settingsView.importFail' => ({required Object error}) =>
              'Fallo al importar ajustes: ${error}',
          'settings.settingsView.invalidFormat' =>
            'Formato de archivo de ajustes inválido',
          'settings.settingsView.categories.general' => 'Ajustes Generales',
          'settings.settingsView.categories.comparisonEngine' =>
            'Motor de Comparación',
          'settings.settingsView.categories.appearance' => 'Apariencia',
          'settings.settingsView.categories.fileHandling' =>
            'Manejo de Archivos',
          'settings.settingsView.categories.aiServices' => 'Servicios IA',
          'settings.settingsView.categories.systemIntegrations' =>
            'Integraciones de Sistema',
          'settings.settingsView.categories.projectResources' =>
            'Recursos de Proyecto (Glosario y MT)',
          'settings.settingsView.categories.developer' =>
            'Opciones de Desarrollador',
          'settings.settingsView.categories.about' => 'Acerca de',
          'settings.settingsView.categoryLabels.general' => 'General',
          'settings.settingsView.categoryLabels.comparisonEngine' =>
            'Comparación',
          'settings.settingsView.categoryLabels.appearance' => 'Apariencia',
          'settings.settingsView.categoryLabels.fileHandling' =>
            'Manejo de Archivos',
          'settings.settingsView.categoryLabels.aiServices' => 'Servicios IA',
          'settings.settingsView.categoryLabels.systemIntegrations' =>
            'Integraciones de Sistema',
          'settings.settingsView.categoryLabels.projectResources' =>
            'Recursos de Proyecto',
          'settings.settingsView.categoryLabels.developer' =>
            'Opciones de Desarrollador',
          'settings.settingsView.categoryLabels.about' => 'Acerca de',
          'fileComparison.title' => 'Comparar Archivos',
          'fileComparison.openFiles' => 'Abrir Archivos',
          'fileComparison.exportResults' => 'Exportar Resultados',
          'fileComparison.restartTutorial' => 'Reiniciar Tutorial',
          'fileComparison.restartTutorialDevOnly' =>
            'El reinicio del tutorial solo está disponible en modo desarrollador.',
          'fileComparison.unsupportedFileType' =>
            'Tipo de archivo no soportado.',
          'fileComparison.unsupportedFileTypeSuggestion' =>
            'Por favor, selecciona un archivo de localización soportado.',
          'fileComparison.someFilesUnsupported' =>
            'Algunos archivos no son soportados.',
          'fileComparison.pickSupportedFiles' =>
            'Elige solo archivos de localización soportados.',
          'fileComparison.pickTwoFiles' => 'Elige dos archivos para comparar.',
          'fileComparison.pickBilingualFile' =>
            'Por favor selecciona un archivo bilingüe para comparar.',
          'fileComparison.noResultsToExport' =>
            'No hay resultados para exportar aún.',
          'fileComparison.performComparisonFirst' =>
            'Realiza una comparación primero para exportar resultados.',
          'fileComparison.performComparisonFirstEditor' =>
            'Por favor realiza una comparación primero para ver detalles avanzados.',
          'fileComparison.sampleDataLoaded' =>
            'Datos de ejemplo cargados con éxito',
          'fileComparison.loadSampleDataError' => ({required Object error}) =>
              'Fallo al cargar datos de ejemplo: ${error}',
          'fileComparison.invalidFileType' => 'Tipo de archivo inválido.',
          'fileComparison.fileSelected' => (
                  {required Object label, required Object fileName}) =>
              '${label} seleccionado: ${fileName}',
          'fileComparison.sourceFile' => 'Archivo origen',
          'fileComparison.targetFile' => 'Archivo destino',
          'fileComparison.bilingualFile' => 'Archivo bilingüe',
          'fileComparison.compareFiles' => 'Comparar Archivos',
          'fileComparison.compareFile' => 'Comparar Archivo',
          'fileComparison.bilingualMode' => 'Modo Bilingüe',
          'fileComparison.twoFilesMode' => 'Dos Archivos',
          'fileComparison.processing' => 'Procesando...',
          'fileComparison.remaining' => ({required Object time}) =>
              '${time} restantes',
          'fileComparison.comparisonInProgress' => 'Comparación en progreso...',
          'fileComparison.comparisonFailed' => ({required Object error}) =>
              'Comparación Fallida: ${error}',
          'fileComparison.fileChanged' => ({required Object fileName}) =>
              'Archivo cambiado: ${fileName}. Recomparando...',
          'fileComparison.dropFileHere' => 'Suelta archivo aquí',
          'fileComparison.dropFileOrBrowse' =>
            'Suelta archivo o clic para examinar',
          'fileComparison.fileUpload' => 'Subir archivo',
          'fileComparison.changeFile' => 'Cambiar archivo',
          'fileComparison.total' => 'Total',
          'fileComparison.show' => 'Mostrar',
          'fileComparison.showAll' => 'Mostrar Todo',
          'fileComparison.noMatches' => ({required Object query}) =>
              'No hay coincidencias para "${query}"',
          'fileComparison.showingEntries' => (
                  {required Object count, required Object total}) =>
              'Mostrando ${count} de ${total} entradas',
          'fileComparison.filesIdentical' => 'Los archivos son idénticos.',
          'fileComparison.hiddenIdentical' => ({required Object count}) =>
              '${count} entradas idénticas ocultas',
          'fileComparison.showIdentical' => 'Mostrar Entradas Idénticas',
          'fileComparison.hideIdentical' => 'Ocultar entradas idénticas',
          'fileComparison.noDiff' =>
            'No se encontraron diferencias basadas en claves.',
          'fileComparison.source' => 'Origen',
          'fileComparison.target' => 'Destino',
          'fileComparison.value' => 'Valor',
          'fileComparison.readyToCompare' => 'Listo para Comparar Archivos',
          'fileComparison.readyToCompareDesc' =>
            'Suelta archivos de localización arriba o usa los botones\npara seleccionar archivos para comparar.',
          'fileComparison.recentComparisons' => 'Comparaciones Recientes',
          'fileComparison.bilingualFileLabel' => ({required Object name}) =>
              'Archivo bilingüe: ${name}',
          'fileComparison.comparisonLabel' => (
                  {required Object source, required Object target}) =>
              '${source} ↔ ${target}',
          'fileComparison.fileNotExist' =>
            'Uno o ambos archivos de esta sesión ya no existen.',
          'fileComparison.largeFileTitle' => 'Archivo Grande Detectado',
          'fileComparison.largeFileContent' => ({required Object count}) =>
              'El resultado de la comparación contiene ${count} entradas.\nMostrar todas podría causar problemas de rendimiento.\n\n¿Quieres continuar?',
          'fileComparison.dontShowAgain' =>
            'No mostrar de nuevo para este archivo',
          'fileComparison.proceed' => 'Proceder',
          'fileComparison.exportReport' => ({required Object format}) =>
              'Guardar Informe ${format}',
          'fileComparison.saved' => ({required Object format}) =>
              '${format} guardado',
          'fileComparison.saveError' => ({required Object format}) =>
              'Fallo al guardar archivo ${format}.',
          'fileComparison.saveErrorDetailed' => (
                  {required Object format, required Object error}) =>
              'Fallo al guardar ${format}: ${error}',
          'fileComparison.watching' => 'Observando',
          'fileComparison.watchOff' => 'Obs. Apagada',
          'fileComparison.watchingTooltip' => ({required Object status}) =>
              'Observación de Archivos: ${status}\nRecomparar automáticamente cuando los archivos cambien en disco',
          'fileComparison.aiSettingsNotAvailable' =>
            'Navegación a Ajustes IA no disponible',
          'directoryComparison.title' => 'Comparar Directorios',
          'directoryComparison.sourceDirectory' => 'Directorio Origen',
          'directoryComparison.targetDirectory' => 'Directorio Destino',
          'directoryComparison.sourceSubtitle' =>
            'Archivos Originales/Referencia',
          'directoryComparison.targetSubtitle' =>
            'Archivos Traducción/Comparación',
          'directoryComparison.selectBothDirectories' =>
            'Por favor selecciona ambos directorios origen y destino.',
          'directoryComparison.selectSourceFolder' =>
            'Seleccionar Carpeta Origen',
          'directoryComparison.selectTargetFolder' =>
            'Seleccionar Carpeta Destino',
          'directoryComparison.dropFolderHere' =>
            'Suelta carpeta aquí o examina...',
          'directoryComparison.folderPath' => 'Ruta de Carpeta',
          'directoryComparison.readyToCompare' =>
            'Listo para Comparar Directorios',
          'directoryComparison.readyToCompareDesc' =>
            'Suelta carpetas arriba o usa los botones\npara seleccionar directorios para comparar.',
          'directoryComparison.nestedFolders' => 'Carpetas Anidadas',
          'directoryComparison.nestedFoldersTooltip' =>
            'Compara recursivamente subdirectorios',
          'directoryComparison.fileMatching' => 'Emparejamiento',
          'directoryComparison.fileMatchingTooltip' =>
            'Empareja archivos por nombre',
          'directoryComparison.bulkExport' => 'Exportar Lote',
          'directoryComparison.bulkExportTooltip' =>
            'Exportar todos los resultados a la vez',
          'directoryComparison.notDirectoryComparison' =>
            'Esto no es una comparación de directorios.',
          'directoryComparison.directoriesNotExist' =>
            'Uno o ambos directorios ya no existen.',
          'directoryComparison.errorOccurred' => 'Ocurrió un error',
          'directoryComparison.noFilesFound' =>
            'No se encontraron archivos en los directorios.',
          'directoryComparison.unmatchedSourceFiles' =>
            'Archivos Origen Sin Pareja',
          'directoryComparison.unmatchedTargetFiles' =>
            'Archivos Destino Sin Pareja',
          'directoryComparison.filePairs' => ({required Object count}) =>
              '${count} pares de archivos',
          'directoryComparison.pairedFiles' => ({required Object count}) =>
              'Archivos Emparejados (${count})',
          'directoryComparison.view' => 'Ver',
          'directoryComparison.failed' => 'Falló',
          'directoryComparison.pair' => 'Emparejar...',
          'directoryComparison.pairDialogTitle' => ({required Object name}) =>
              'Emparejar "${name}" con:',
          'directoryComparison.discoverFiles' => 'Descubrir Archivos',
          'directoryComparison.compareAll' => 'Comparar Todo',
          'directoryComparison.exportAll' => 'Exportar Todo',
          'directoryComparison.comparisonStarted' => 'Comparación iniciada...',
          'directoryComparison.discoveringFiles' => 'Descubriendo archivos...',
          'directoryComparison.noResultsToExport' =>
            'Sin resultados para exportar. Ejecuta "Comparar Todo".',
          'directoryComparison.selectExportFolder' =>
            'Seleccionar Carpeta Exportación',
          'directoryComparison.createExportFolderError' => (
                  {required Object error}) =>
              'Fallo al crear carpeta exportación: ${error}',
          'directoryComparison.exportingResults' => 'Exportando Resultados',
          'directoryComparison.processingFile' => ({required Object file}) =>
              'Procesando: ${file}',
          'directoryComparison.exportProgress' => (
                  {required Object current, required Object total}) =>
              '${current} of ${total} archivos exportados',
          'directoryComparison.exportComplete' => 'Exportación Completa',
          'directoryComparison.exportSuccessMessage' => (
                  {required Object count}) =>
              'Exportados ${count} archivos de comparación más resumen.',
          'directoryComparison.exportFailed' => ({required Object error}) =>
              'Fallo exportación: ${error}',
          'directoryComparison.close' => 'Cerrar',
          'gitComparison._translatorNote' =>
            'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.',
          'gitComparison.title' => 'Comparación de Repositorio',
          'gitComparison.repoSelector' => 'Crear / Abrir Repositorio',
          'gitComparison.noRepoSelected' => 'Ningún repositorio seleccionado',
          'gitComparison.open' => 'Abrir',
          'gitComparison.refreshCommits' => 'Actualizar Commits',
          'gitComparison.noCommits' =>
            'No se encontraron commits o no se cargaron. Selecciona una rama para cargar commits.',
          'gitComparison.baseCommit' => 'Commit Base (Más antiguo)',
          'gitComparison.targetCommit' => 'Commit Destino (Más nuevo)',
          'gitComparison.filterCommitsByBranch' => 'Filtrar Commits por Branch',
          'gitComparison.conflictDetection' => 'Detección de conflictos',
          'gitComparison.conflictDetectionTooltip' =>
            'Detectar y resolver conflictos de merge',
          'gitComparison.actions' => 'Acciones:',
          'gitComparison.checkout' => 'Checkout',
          'gitComparison.merge' => 'Merge',
          'gitComparison.pull' => 'Pull',
          'gitComparison.checkoutBranch' => 'Hacer Checkout a Branch',
          'gitComparison.mergeBranch' => 'Hacer Merge de Branch en Actual',
          'gitComparison.mergeConfirmation' => ({required Object branch}) =>
              '¿Merge ${branch}?',
          'gitComparison.mergeWarning' =>
            'Esto hará merge de los cambios en tu rama de trabajo actual. Pueden ocurrir conflictos.',
          'gitComparison.selectExportFolder' =>
            'Seleccionar Carpeta Exportación',
          'gitComparison.createExportFolderError' => (
                  {required Object error}) =>
              'Fallo al crear carpeta exportación: ${error}',
          'gitComparison.exportingFiles' => 'Exportando Archivos',
          'gitComparison.processingFile' => ({required Object file}) =>
              'Procesando: ${file}',
          'gitComparison.exportProgress' => (
                  {required Object current, required Object total}) =>
              '${current} de ${total} archivos exportados',
          'gitComparison.exportComplete' => 'Exportación Completa',
          'gitComparison.exportSuccessMessage' => ({required Object count}) =>
              'Exportados con éxito ${count} archivos con contenido completo.',
          'gitComparison.exportDetail' =>
            'El diff de cada archivo se guarda en la subcarpeta "files".',
          'gitComparison.diffViewer' => 'Visor de Diff',
          'gitComparison.base' => 'BASE',
          'gitComparison.target' => 'DESTINO',
          'gitComparison.noLines' => 'Sin líneas para mostrar',
          'gitComparison.searchFiles' => 'Buscar archivos...',
          'gitComparison.noFilesMatch' => ({required Object query}) =>
              'Ningún archivo coincide con "${query}"',
          'gitComparison.filesCount' => ({required Object count}) =>
              '${count} archivos',
          'gitComparison.selectBaseFile' => 'Seleccionar Archivo Base',
          'gitComparison.selectTargetFile' => 'Seleccionar Archivo Destino',
          'gitComparison.comparisonResults' => 'Resultados de Comparación',
          'gitComparison.noChanges' =>
            'No se encontraron cambios entre las refs seleccionadas.',
          'gitComparison.linesAdded' => 'Líneas Añadidas',
          'gitComparison.linesRemoved' => 'Líneas Eliminadas',
          'gitComparison.commit' => 'Commit',
          'gitComparison.branch' => 'Branch',
          'gitComparison.noRepositorySelected' =>
            'Ningún repositorio seleccionado',
          'gitComparison.notGitComparison' => 'No es una comparación Git',
          'gitComparison.repositoryNotExist' => 'El repositorio no existe',
          'gitComparison.mainBranch' => 'main',
          'gitComparison.masterBranch' => 'master',
          'gitComparison.backToControls' => 'Volver a controles de comparación',
          'advancedComparison.placeholder' =>
            'Vista de Comparación Avanzada - Marcador',
          'advancedDiff.saveAllChanges' => '¿Guardar Todos los Cambios?',
          'advancedDiff.saveConfirmation' => ({required Object count}) =>
              'Esto guardará todas las ${count} entradas modificadas al archivo destino. Esta acción no se puede deshacer.',
          'advancedDiff.changesSaved' => 'Cambios guardados con éxito.',
          'advancedDiff.csvExported' => 'CSV exportado',
          'advancedDiff.unsavedChanges' => 'Cambios Sin Guardar',
          'advancedDiff.unsavedChangesWarning' =>
            'Tienes cambios sin guardar. ¿Seguro que quieres descartarlos?',
          'advancedDiff.discardChanges' => 'Descartar Cambios',
          'advancedDiff.goBack' => 'Volver',
          'advancedDiff.breadcrumbs' => 'Inicio > Editor',
          'advancedDiff.unsaved' => ({required Object count}) =>
              '${count} sin guardar',
          'advancedDiff.reviewed' => ({required Object count}) =>
              '${count} revisados',
          'advancedDiff.saveAll' => ({required Object count}) =>
              'Guardar Todo (${count})',
          'advancedDiff.allSaved' => 'Todo Guardado',
          'advancedDiff.saveAllTooltip' => 'Guardar Todos los Cambios (Ctrl+S)',
          'advancedDiff.exportTooltip' => 'Exportar Datos (Ctrl+E)',
          'advancedDiff.aiSuggestion.aiTranslation' => 'Traducción IA',
          'advancedDiff.aiSuggestion.aiRephrase' => 'Refraseo IA',
          'advancedDiff.aiSuggestion.key' => ({required Object key}) =>
              'Clave: ${key}',
          'advancedDiff.aiSuggestion.original' => 'Original:',
          'advancedDiff.aiSuggestion.suggestion' => 'Sugerencia:',
          'advancedDiff.aiSuggestion.confidence' => 'Confianza IA',
          'advancedDiff.aiSuggestion.cancelEdit' => 'Cancelar edición',
          'advancedDiff.aiSuggestion.editSuggestion' => 'Editar sugerencia',
          'advancedDiff.aiSuggestion.alternatives' => 'Alternativas:',
          'advancedDiff.aiSuggestion.accept' => 'Aceptar',
          'advancedDiff.aiSuggestion.reject' => 'Rechazar',
          'advancedDiff.aiSuggestion.stop' => 'Detener',
          'advancedDiff.detailEdit.title' => ({required Object key}) =>
              'Editar: ${key}',
          'advancedDiff.detailEdit.sourceLabel' => 'ORIGEN (Original)',
          'advancedDiff.detailEdit.targetLabel' => 'DESTINO (Traducción)',
          'advancedDiff.detailEdit.translateWithCloud' => 'Traducir con Nube',
          'advancedDiff.detailEdit.translateWithAi' => 'Traducir con IA',
          'advancedDiff.detailEdit.translating' => 'Traduciendo...',
          'advancedDiff.detailEdit.applyAndTm' => 'Aplicar',
          'advancedDiff.detailEdit.entryApplied' =>
            'Entrada aplicada y añadida a MT',
          'advancedDiff.detailEdit.translationAdded' =>
            'Sugerencia de traducción añadida.',
          'advancedDiff.detailEdit.aiSuggestionAdded' =>
            'Sugerencia IA añadida.',
          'advancedDiff.table.addedToTM' => 'Añadido a Memoria de Traducción',
          'advancedDiff.table.markedReviewed' => 'Marcado como revisado ✓',
          'advancedDiff.table.unmarkedReview' => 'Revisión desmarcada',
          'advancedDiff.table.reverted' => 'Revertido a valor origen',
          'advancedDiff.table.entryDeleted' => 'Entrada eliminada',
          'advancedDiff.table.noSourceText' =>
            'Sin texto origen para traducir.',
          'advancedDiff.table.aiTranslationFailed' => ({required Object key}) =>
              'Traducción IA falló para "${key}"',
          'advancedDiff.table.noTargetText' =>
            'Sin texto destino para refrasear.',
          'advancedDiff.table.aiRephraseFailed' => ({required Object key}) =>
              'Refraseo IA falló para "${key}"',
          'advancedDiff.table.checkRowsFirst' =>
            'Marca filas usando casillas primero',
          'advancedDiff.table.markedRowsReviewed' => (
                  {required Object count}) =>
              'Marcadas ${count} filas como revisadas',
          'advancedDiff.table.revertedRows' => ({required Object count}) =>
              'Revertidas ${count} filas',
          'advancedDiff.table.entriesCount' => ({required Object count}) =>
              '${count} entradas',
          'advancedDiff.table.markSelectedReviewed' =>
            'Marcar Seleccionadas Revisadas',
          'advancedDiff.table.revertSelected' => 'Revertir Seleccionadas',
          'advancedDiff.table.noDifferences' => 'No se encontraron diferencias',
          'advancedDiff.table.adjustFilters' => 'Intenta ajustar tus filtros',
          'advancedDiff.table.cloudTranslationApplied' =>
            'Traducción nube aplicada.',
          'advancedDiff.table.aiTranslationApplied' =>
            'Traducción IA aplicada.',
          'advancedDiff.table.suggestionApplied' => 'Sugerencia aplicada.',
          'advancedDiff.table.aiSuggestionApplied' => 'Sugerencia IA aplicada.',
          'advancedDiff.table.rephraseApplied' => 'Refraseo aplicado.',
          'advancedDiff.table.aiRephraseApplied' => 'Refraseo IA aplicado.',
          'advancedDiff.table.rephrase' => 'Refrasear',
          'advancedDiff.table.aiRephrase' => 'Refraseo IA',
          'advancedDiff.table.targetClickToEdit' =>
            'DESTINO (Clic para editar)',
          'advancedDiff.table.targetClickForDialog' =>
            'DESTINO (Clic para diálogo)',
          'advancedDiff.table.emptyClickToEdit' => '(Vacío - Clic para editar)',
          'advancedDiff.table.unmarkReviewed' => 'Desmarcar revisado',
          'advancedDiff.table.markReviewed' => 'Marcar como revisado',
          'advancedDiff.table.revertToSource' => 'Revertir a origen',
          'advancedDiff.table.translateWithCloud' => 'Traducir con Nube',
          'advancedDiff.table.translateWithAi' => 'Traducir con IA',
          'advancedDiff.table.rephraseWithAi' => 'Refrasear con IA',
          'advancedDiff.table.moreActions' => 'Más acciones',
          'advancedDiff.table.editDetails' => 'Editar detalles',
          'advancedDiff.table.suggestTranslation' => 'Sugerir traducción',
          'advancedDiff.table.addToTm' => 'Añadir a MT',
          'advancedDiff.table.deleteEntry' => 'Eliminar entrada',
          'advancedDiff.diffRow.copySource' => 'Copiar texto origen',
          'advancedDiff.diffRow.actions' => 'Acciones',
          'advancedDiff.status.added' => 'AÑADIDO',
          'advancedDiff.status.missing' => 'FALTANTE',
          'advancedDiff.status.changed' => ({required Object percent}) =>
              'CAMB ${percent}%',
          'advancedDiff.status.same' => 'IGUAL',
          'advancedDiff.sidebar.widgets' => 'Widgets',
          'advancedDiff.sidebar.searchPlaceholder' =>
            'Buscar claves y valores... (Ctrl+F)',
          'advancedDiff.sidebar.fuzzySearchTooltip' =>
            'Búsqueda Difusa (tolera errores)',
          'advancedDiff.sidebar.regexSearchTooltip' => 'Búsqueda Regex',
          'advancedDiff.sidebar.cloudTranslation' => 'Traducción Nube',
          'advancedDiff.sidebar.aiTranslation' => 'Traducción IA',
          'advancedDiff.sidebar.status' => 'Estado',
          'advancedDiff.sidebar.tm' => 'Memoria de Traducción',
          'advancedDiff.sidebar.filters' => 'Filtros',
          'advancedDiff.sidebar.actions' => 'Acciones',
          'advancedDiff.sidebar.similarity' => 'Similitud',
          'advancedDiff.sidebar.actionsSection.exportMatches' =>
            'Exportar coincidencias',
          'advancedDiff.sidebar.actionsSection.preview' => 'Vista previa',
          'advancedDiff.sidebar.actionsSection.fillFromTmTitle' =>
            '¿Rellenar desde Memoria de Traducción?',
          'advancedDiff.sidebar.actionsSection.fillFromTmContent' =>
            'Esto intentará rellenar valores destino vacíos usando coincidencias de la Memoria de Traducción. Los valores existentes NO se sobrescribirán.',
          'advancedDiff.sidebar.actionsSection.fill' => 'Rellenar',
          'advancedDiff.sidebar.actionsSection.fillFromMemory' =>
            'Rellenar desde Memoria',
          'advancedDiff.sidebar.actionsSection.filledFromTm' => (
                  {required Object count}) =>
              'Rellenados ${count} elementos desde Memoria de Traducción.',
          'advancedDiff.sidebar.aiSection.infoCloud' =>
            'Usa traducción nube para traducir valores destino vacíos desde origen.',
          'advancedDiff.sidebar.aiSection.infoAi' =>
            'Usa IA para traducir valores destino vacíos desde origen.',
          'advancedDiff.sidebar.aiSection.translationSettings' =>
            'Ajustes de Traducción',
          'advancedDiff.sidebar.aiSection.aiSettings' => 'Ajustes IA',
          'advancedDiff.sidebar.aiSection.source' => 'Origen',
          'advancedDiff.sidebar.aiSection.target' => 'Destino',
          'advancedDiff.sidebar.aiSection.translatingProgress' =>
            ({required Object percent}) => 'Traduciendo... ${percent}%',
          'advancedDiff.sidebar.aiSection.translating' => 'Traduciendo...',
          'advancedDiff.sidebar.aiSection.translateAllMissing' =>
            'Traducir Todo Faltante',
          'advancedDiff.sidebar.aiSection.translateAllTitle' =>
            '¿Traducir Todo Faltante?',
          'advancedDiff.sidebar.aiSection.translateAllContent' => (
                  {required Object service,
                  required Object source,
                  required Object target}) =>
              'Esto usará ${service} para traducir todas las entradas con valores destino vacíos de ${source} a ${target}.\n\nPuedes revisar cada sugerencia o aplicar todo a la vez.',
          'advancedDiff.sidebar.aiSection.translateAll' => 'Traducir Todo',
          'advancedDiff.sidebar.aiSection.reviewEach' => 'Revisar Cada Uno',
          'advancedDiff.sidebar.aiSection.cloudTranslated' => (
                  {required Object count}) =>
              'Traducidas ${count} entradas con traducción nube.',
          'advancedDiff.sidebar.aiSection.aiTranslated' =>
            ({required Object count}) => 'Traducidas ${count} entradas con IA.',
          'advancedDiff.sidebar.aiSection.aiTranslateFailed' =>
            'Traducción IA de todo falló',
          'advancedDiff.sidebar.aiSection.noMissingEntries' =>
            'No hay entradas faltantes para traducir.',
          'advancedDiff.sidebar.aiSection.skip' => 'Saltar',
          'advancedDiff.sidebar.aiSection.stop' => 'Detener',
          'advancedDiff.sidebar.aiSection.cloudApplied' =>
            ({required Object count}) => 'Aplicadas ${count} sugerencias.',
          'advancedDiff.sidebar.aiSection.aiApplied' =>
            ({required Object count}) => 'Aplicadas ${count} sugerencias IA.',
          'advancedDiff.sidebar.tmSection.enableTmFill' =>
            'Habilitar Relleno MT',
          'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' =>
            'Auto-aplicar sobre mínimo',
          'advancedDiff.sidebar.tmSection.matchSettings' =>
            'Ajustes de Coincidencia',
          'advancedDiff.sidebar.tmSection.minMatch' => 'Coincidencia mín:',
          'advancedDiff.sidebar.tmSection.limit' => 'Límite:',
          'advancedDiff.sidebar.tmSection.exact' => 'Exacto',
          'advancedDiff.sidebar.filtersSection.viewFilters' =>
            'Filtros de Vista',
          'advancedDiff.sidebar.filtersSection.showAll' => 'Mostrar Todo',
          'advancedDiff.sidebar.filtersSection.added' => 'Añadido',
          'advancedDiff.sidebar.filtersSection.removed' => 'Eliminado',
          'advancedDiff.sidebar.filtersSection.modified' => 'Modificado',
          'advancedDiff.sidebar.filtersSection.actionScope' =>
            'Alcance de Acción',
          'advancedDiff.sidebar.filtersSection.applyToAdded' =>
            'Aplicar a Añadido',
          'advancedDiff.sidebar.filtersSection.applyToModified' =>
            'Aplicar a Modificado',
          'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' =>
            'Solo rellenar destinos vacíos',
          'advancedDiff.sidebar.filtersSection.limitToVisible' =>
            'Limitar a visibles',
          'advancedDiff.sidebar.filtersSection.editMode' => 'Modo Edición',
          'advancedDiff.sidebar.filtersSection.dialog' => 'Diálogo',
          'advancedDiff.sidebar.filtersSection.inline' => 'En línea',
          'advancedDiff.sidebar.similaritySection.currentFilter' =>
            'Filtro Actual:',
          'advancedDiff.sidebar.similaritySection.any' => 'CUALQ',
          'advancedDiff.sidebar.similaritySection.high' => 'ALTA',
          'advancedDiff.sidebar.similaritySection.medium' => 'MEDIA',
          'advancedDiff.sidebar.similaritySection.low' => 'BAJA',
          'advancedDiff.sidebar.statusSection.total' =>
            ({required Object count}) => '${count} total',
          'advancedDiff.sidebar.statusSection.extra' =>
            ({required Object count}) => '${count} extra',
          'advancedDiff.sidebar.statusSection.missing' =>
            ({required Object count}) => '${count} falta',
          'advancedDiff.sidebar.statusSection.changed' =>
            ({required Object count}) => '${count} camb',
          'issueDetails.title' => 'Detalles de Problema',
          'issueDetails.showingIssues' => (
                  {required Object count, required Object total}) =>
              'Mostrando ${count} de ${total} problemas',
          'issueDetails.searchPlaceholder' =>
            'Buscar por clave, texto o error...',
          'issueDetails.noDetails' => 'Sin detalles disponibles.',
          'issueDetails.noMatches' => 'No hay coincidencias.',
          'issueDetails.showMore' => 'Mostrar Más',
          'issueDetails.copyItems' => ({required Object count}) =>
              'Copiar ${count} Elementos',
          'issueDetails.close' => 'Cerrar',
          'issueDetails.copied' => 'Copiado al portapapeles',
          'issueDetails.copiedCount' => ({required Object count}) =>
              'Copiados ${count} elementos',
          'issueDetails.duplicateValue.label' => 'TRADUCCIÓN REPETIDA',
          'issueDetails.duplicateValue.warning' =>
            'Diferentes textos de origen usan esta misma traducción. Verifica el contexto.',
          'issueDetails.duplicateValue.affectedKeys' =>
            ({required Object count}) => 'CLAVES AFECTADAS (${count})',
          'issueDetails.duplicateValue.identicalSources' => 'Fuentes Idénticas',
          'issueDetails.duplicateValue.moreKeys' => ({required Object count}) =>
              '+${count} claves más',
          'issueDetails.lengthOutlier.source' => 'ORIGEN',
          'issueDetails.lengthOutlier.translation' => 'TRADUCCIÓN',
          'issueDetails.lengthOutlier.chars' => ({required Object count}) =>
              '${count} car',
          'issueDetails.standard.key' => 'CLAVE',
          'issueDetails.standard.sourceText' => 'TEXTO ORIGEN',
          'issueDetails.standard.translation' => 'TRADUCCIÓN',
          'issueDetails.standard.errorDetails' => 'DETALLES ERROR',
          'issueDetails.standard.note' => 'NOTA',
          'issueDetails.review' => 'Revisar',
          'issueDetails.types.duplicateValue' => 'Valores Duplicados',
          'issueDetails.types.lengthOutlier' => 'Desajuste Longitud',
          'issueDetails.types.placeholderMismatch' => 'Marcadores Rotos',
          'issueDetails.notes.placeholderMismatch' =>
            'Marcadores como {name} deberían coincidir con el origen.',
          'issueDetails.notes.lengthOutlier' =>
            'Grandes cambios de longitud pueden afectar cómo encaja el texto.',
          'issueDetails.notes.duplicateValue' =>
            'La misma traducción se usa para diferentes claves.',
          'issueDetails.fallbacks.multipleSources' => 'Múltiples textos origen',
          'issueDetails.fallbacks.sourceNotAvailable' =>
            'Texto origen no disponible',
          'issueDetails.fallbacks.sharedTranslationNotAvailable' =>
            'Traducción compartida no disponible',
          'issueDetails.fallbacks.translationNotAvailable' =>
            'Traducción no disponible',
          'importReview.title' => 'Revisar Importación de Proyecto',
          'importReview.projectName' => 'Nombre de Proyecto',
          'importReview.created' => 'Creado',
          'importReview.historyItems' => 'Elementos de Historial',
          'importReview.customSettingsTitle' =>
            'Ajustes Personalizados Detectados',
          'importReview.customSettingsWarning' =>
            'Este proyecto contiene ajustes personalizados que sobrescribirán tus valores por defecto mientras esté abierto.',
          'importReview.standardSettings' =>
            'Este proyecto usa ajustes globales estándar.',
          'importReview.cancelImport' => 'Cancelar Importación',
          'importReview.trustOpen' => 'Confiar y Abrir Proyecto',
          'historyView.title' => 'Historial de Comparación',
          'historyView.clearAll' => 'Limpiar todo el historial',
          'historyView.searchPlaceholder' => 'Buscar por nombre de archivo...',
          'historyView.sortBy' => 'Ordenar por',
          'historyView.sortDate' => 'Fecha',
          'historyView.sortSource' => 'Archivo Origen',
          'historyView.sortTarget' => 'Archivo Destino',
          'historyView.showCurrentProject' => 'Mostrando: Proyecto Actual',
          'historyView.showAllHistory' => 'Mostrando: Todo el Historial',
          'historyView.groupByFolder' => 'Agrupar por carpeta',
          'historyView.disableGrouping' =>
            'Deshabilitar agrupación por carpeta',
          'historyView.filterAll' => 'Todo',
          'historyView.filterFiles' => 'Archivos',
          'historyView.filterDirectories' => 'Directorios',
          'historyView.filterGit' => 'Git',
          'historyView.noHistory' => 'Sin historial de comparaciones',
          'historyView.historyDescription' =>
            'Tus comparaciones de archivos aparecerán aquí',
          'historyView.noResults' => 'Sin resultados encontrados',
          'historyView.adjustSearch' => 'Intenta ajustar tu búsqueda',
          'historyView.clearConfirmationTitle' => '¿Limpiar Todo el Historial?',
          'historyView.clearConfirmationContent' =>
            'Esto borrará permanentemente todo el historial de comparación. No se puede deshacer.',
          'historyView.clearAction' => 'Limpiar Todo',
          'historyView.deletedMessage' => 'Elemento de historial eliminado',
          'historyView.undo' => 'Deshacer',
          'historyView.viewDetails' => 'Ver Detalles',
          'historyView.delete' => 'Eliminar',
          'historyView.openLocation' => 'Abrir ubicación de archivo',
          'historyView.bilingual' => 'Bilingüe',
          'historyView.filePair' => 'Par de Archivos',
          'historyView.directory' => 'Directorio',
          'historyView.git' => 'Git',
          'historyView.repo' => 'Repo',
          'historyView.sourceDir' => 'Dir Origen',
          'historyView.targetDir' => 'Dir Destino',
          'historyView.source' => 'Origen',
          'historyView.target' => 'Destino',
          'historyView.noChanges' => 'Sin cambios detectados',
          'historyView.added' => 'Añadido',
          'historyView.removed' => 'Eliminado',
          'historyView.modified' => 'Modificado',
          'historyView.same' => 'Igual',
          'historyView.total' => 'Total',
          'historyView.currentProject' => 'Proyecto Actual',
          'historyView.unassigned' => 'Sin Asignar',
          'historyView.project' => 'Proyecto',
          'compare.title' => 'Comparar Archivos',
          'compare.sourceFile' => 'Archivo Origen',
          'compare.targetFile' => 'Archivo Destino',
          'compare.sourceFolder' => 'Carpeta Origen',
          'compare.targetFolder' => 'Carpeta Destino',
          'compare.dropFilesHint' =>
            'Suelta archivos de localización aquí o usa los botones para seleccionar archivos para comparar.',
          'compare.selectSourceFile' => 'Seleccionar archivo origen',
          'compare.selectTargetFile' => 'Seleccionar archivo destino',
          'compare.startComparison' => 'Iniciar Comparación',
          'compare.comparing' => 'Comparando...',
          'compare.comparisonComplete' => 'Comparación completada',
          'compare.noChanges' => 'Sin cambios detectados',
          'compare.filesIdentical' => 'Los archivos son idénticos',
          'compare.changesFound' => ({required Object count}) =>
              'Encontrados ${count} cambios',
          'compare.tabs.files' => 'Archivos',
          'compare.tabs.directories' => 'Directorios',
          'compare.tabs.git' => 'Git',
          'compare.fileTypes.json' =>
            'Archivos localización JSON (i18next, Flutter, etc.)',
          'compare.fileTypes.yaml' =>
            'Archivos localización YAML (Rails, Flutter)',
          'compare.fileTypes.xml' =>
            'Archivos localización XML (Android, .NET)',
          'compare.fileTypes.properties' => 'Archivos Properties (Java)',
          'compare.fileTypes.resx' => 'Archivos RESX (.NET)',
          _ => null,
        } ??
        switch (path) {
          'compare.fileTypes.xliff' => 'Archivos XLIFF',
          'history.title' => 'Historial',
          'history.recentComparisons' => 'Comparaciones Recientes',
          'history.noHistory' => 'Sin historial de comparaciones',
          'history.noHistoryDescription' =>
            'Tu historial de comparación aparecerá aquí',
          'history.clearHistory' => 'Limpiar Historial',
          'history.clearHistoryConfirm' =>
            '¿Seguro que quieres limpiar todo el historial?',
          'history.deleteEntry' => 'Eliminar Entrada',
          'history.openComparison' => 'Abrir Comparación',
          'history.timeAgo.justNow' => 'ahora mismo',
          'history.timeAgo.secondsAgo' => ({required Object count}) =>
              'hace ${count} segundos',
          'history.timeAgo.oneMinuteAgo' => 'hace 1 minuto',
          'history.timeAgo.minutesAgo' => ({required Object count}) =>
              'hace ${count} minutos',
          'history.timeAgo.oneHourAgo' => 'hace 1 hora',
          'history.timeAgo.hoursAgo' => ({required Object count}) =>
              'hace ${count} horas',
          'history.timeAgo.yesterday' => 'ayer',
          'history.timeAgo.daysAgo' => ({required Object count}) =>
              'hace ${count} días',
          'history.timeAgo.oneWeekAgo' => 'hace 1 semana',
          'history.timeAgo.weeksAgo' => ({required Object count}) =>
              'hace ${count} semanas',
          'history.timeAgo.oneMonthAgo' => 'hace 1 mes',
          'history.timeAgo.monthsAgo' => ({required Object count}) =>
              'hace ${count} meses',
          'history.timeAgo.oneYearAgo' => 'hace 1 año',
          'history.timeAgo.yearsAgo' => ({required Object count}) =>
              'hace ${count} años',
          'history.timeAgo.inTheFuture' => 'en el futuro',
          'projects.title' => 'Proyectos',
          'projects.createProject' => 'Crear Proyecto',
          'projects.importProject' => 'Importar Proyecto',
          'projects.noProjects' => 'No hay proyectos aún',
          'projects.noProjectsDescription' =>
            'Crea un proyecto para organizar tus archivos de localización',
          'projects.projectName' => 'Nombre del Proyecto',
          'projects.projectPath' => 'Ruta del Proyecto',
          'projects.lastOpened' => 'Última apertura',
          'projects.openProject' => 'Abrir Proyecto',
          'projects.closeProject' => 'Cerrar Proyecto',
          'projects.deleteProject' => 'Eliminar Proyecto',
          'projects.deleteProjectConfirm' =>
            '¿Seguro que quieres eliminar este proyecto?',
          'projects.exportProject' => 'Exportar Proyecto',
          'projects.exportDescription' =>
            'Crea un archivo zip portable que contenga archivos origen, configuración e historial.',
          'projects.exporting' => 'Exportando proyecto...',
          'projects.exportSuccess' => 'Proyecto exportado',
          'projects.exportError' => ({required Object error}) =>
              'Fallo al exportar: ${error}',
          'projects.createNewProject' => 'Crear Nuevo Proyecto',
          'projects.openExistingProject' => 'Abrir Proyecto Existente',
          'projects.importProjectZip' => 'Importar Zip de Proyecto',
          'projects.projectResources' => 'Recursos del Proyecto',
          'projects.recentProjects' => 'Proyectos Recientes',
          'projects.noRecentProjects' => 'Sin proyectos recientes',
          'projects.selectProjectZip' => 'Seleccionar Zip de Proyecto',
          'projects.selectDestination' =>
            'Seleccionar Carpeta de Destino para Importación',
          'projects.importing' => 'Importando proyecto...',
          'projects.importSuccess' => 'Proyecto importado con éxito',
          'projects.importFailed' => ({required Object error}) =>
              'Importación fallida: ${error}',
          'projects.importingFiles' => 'Importando archivos...',
          'projects.noSupportedFiles' => 'No se soltaron archivos soportados.',
          'projects.stats.empty' => 'Proyecto vacío',
          'projects.stats.files' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
                n,
                one: '1 archivo de traducción',
                other: '${count} archivos de traducción',
              ),
          'projects.stats.languages' => (
                  {required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
                n,
                one: '1 idioma',
                other: '${count} idiomas',
              ),
          'projects.openProjectFirst' =>
            'Abre un proyecto primero para gestionar sus recursos.',
          'projects.removeFromRecent' => 'Eliminar de recientes',
          'projects.selection.selectFolder' =>
            'Seleccionar Carpeta de Proyecto',
          'projects.selection.selectArchive' =>
            'Seleccionar Archivo de Proyecto',
          'projects.selection.openProject' => 'Abrir Proyecto',
          'projects.selection.browseFolder' => 'Examinar Carpeta...',
          'projects.selection.createNew' => 'Crear Nuevo',
          'projects.selection.importFromZip' => 'Importar desde Zip...',
          'projects.createDialog.title' => 'Crear Proyecto',
          'projects.createDialog.description' =>
            'Un proyecto te permite guardar ajustes personalizados para una carpeta específica. Se creará una carpeta ".localizer" para guardar la configuración de tu proyecto.',
          'projects.createDialog.folderLabel' => 'Carpeta del Proyecto',
          'projects.createDialog.folderHint' =>
            'Haz clic para seleccionar carpeta...',
          'projects.createDialog.nameLabel' => 'Nombre del Proyecto',
          'projects.createDialog.nameHint' => 'ej., Mis Traducciones App',
          'projects.createDialog.selectFolderWarning' =>
            'Por favor selecciona una carpeta de proyecto.',
          'projects.createDialog.enterNameError' =>
            'Por favor introduce un nombre de proyecto',
          'projects.createDialog.nameLengthError' =>
            'El nombre debe tener al menos 2 caracteres',
          'projects.createDialog.success' => ({required Object name}) =>
              '¡Proyecto "${name}" creado con éxito!',
          'projects.createDialog.failure' => 'Fallo al crear proyecto.',
          'projects.createDialog.creating' => 'Creando...',
          'projects.createDialog.createAction' => 'Crear Proyecto',
          'projects.indicator.tooltipNoProject' =>
            'Crea un proyecto para guardar ajustes personalizados para una carpeta',
          'projects.indicator.tooltipProject' => ({required Object name}) =>
              'Proyecto: ${name}\nHaz clic para ver opciones',
          'projects.indicator.location' => 'Ubicación',
          'projects.indicator.created' => 'Creado',
          'projects.indicator.switchProject' => 'Cambiar Proyecto',
          'projects.indicator.done' => 'Hecho',
          'projects.glossary.title' => 'Glosario del Proyecto',
          'projects.glossary.description' =>
            'Define términos que deben tratarse consistentemente o nunca traducirse.',
          'projects.glossary.noTerms' => 'Aún no hay términos en glosario.',
          'projects.glossary.noTermsDesc' =>
            'Añade términos que deban permanecer consistentes,\no marca nombres de marca que nunca deban traducirse.',
          'projects.glossary.doNotTranslate' => 'No traducir',
          'projects.glossary.noSpecificTranslation' =>
            'Sin traducción específica',
          'projects.glossary.addTerm' => 'Añadir Término',
          'projects.glossary.editTerm' => 'Editar Término',
          'projects.glossary.term' => 'Término',
          'projects.glossary.termHint' =>
            'ej., nombre marca, término especializado',
          'projects.glossary.definition' => 'Definición (Opcional)',
          'projects.glossary.definitionHint' => 'Contexto para el traductor',
          'projects.glossary.doNotTranslateLabel' => 'No Traducir',
          'projects.glossary.doNotTranslateDesc' =>
            'Mantener término exactamente igual en destino',
          'projects.glossary.preferredTranslation' => 'Traducción Preferida',
          'projects.glossary.caseSensitive' => 'Sensible a Mayúsculas',
          'projects.conflicts.missingApiKeyTitle' =>
            ({required Object service}) => 'Falta clave API para ${service}',
          'projects.conflicts.missingApiKeyMessage' => (
                  {required Object service}) =>
              'Este proyecto usa ${service} pero no hay clave API configurada. Añade tu clave API en Ajustes > Servicios IA, o la app usará el valor global por defecto.',
          'projects.conflicts.dismiss' => 'Descartar',
          'projects.tm.title' => 'Memorias de Traducción',
          'projects.tm.description' =>
            'Gestiona fuentes de memoria de traducción para este proyecto.',
          'projects.tm.globalTm' => 'Memoria de Traducción Global',
          'projects.tm.globalTmDescription' =>
            'Usa la memoria de traducción compartida de tus ajustes de app',
          'projects.tm.linkedFiles' =>
            'Archivos Vinculados (Específico Proyecto)',
          'projects.tm.noLinkedFiles' =>
            'No hay archivos específicos del proyecto vinculados.',
          'projects.tm.addTmFile' => 'Añadir Archivo TM',
          'projects.tm.useGlobalTm' => 'Usar TM Global',
          'projects.tm.selectTm' => 'Seleccionar Memoria de Traducción',
          'projects.tm.globalTmEnabled' =>
            'Memoria de Traducción Global habilitada',
          'diff.added' => 'Añadido',
          'diff.removed' => 'Eliminado',
          'diff.modified' => 'Modificado',
          'diff.unchanged' => 'Sin Cambios',
          'diff.missing' => 'Faltante',
          'diff.extra' => 'Extra',
          'diff.sourceValue' => 'Valor Origen',
          'diff.targetValue' => 'Valor Destino',
          'diff.key' => 'Clave',
          'diff.status' => 'Estado',
          'diff.actions' => 'Acciones',
          'diff.copyToTarget' => 'Copiar a Destino',
          'diff.acceptChange' => 'Aceptar Cambio',
          'diff.rejectChange' => 'Rechazar Cambio',
          'diff.viewDetails' => 'Ver Detalles',
          'git.title' => 'Comparación Git',
          'git.selectRepository' => 'Seleccionar Repositorio',
          'git.selectBranch' => 'Seleccionar Rama',
          'git.selectCommit' => 'Seleccionar Commit',
          'git.compareBranches' => 'Comparar Ramas',
          'git.compareCommits' => 'Comparar Commits',
          'git.baseBranch' => 'Rama Base',
          'git.compareBranch' => 'Rama Comparar',
          'git.noRepositories' => 'No se encontraron repositorios Git',
          'git.noRepositoriesDescription' =>
            'Abre una carpeta que contenga un repositorio Git',
          'git.filesChanged' => ({required Object count}) =>
              '${count} archivos cambiados',
          'git.additions' => ({required Object count}) => '${count} adiciones',
          'git.deletions' => ({required Object count}) =>
              '${count} eliminaciones',
          'git.conflicts.title' => 'Conflictos de Merge Detectados',
          'git.conflicts.description' =>
            'Debes resolver estos conflictos antes de continuar.',
          'git.conflicts.abortMergeTitle' => '¿Abortar Merge?',
          'git.conflicts.abortMergeContent' =>
            'Esto revertirá todos los cambios del merge y volverá al estado previo. Esto no se puede deshacer.',
          'git.conflicts.abortMergeAction' => 'Abortar Merge',
          'git.conflicts.stagingFile' => ({required Object file}) =>
              'Preparando ${file} para commit...',
          'git.conflicts.conflictedFilesCount' => ({required Object count}) =>
              'Archivos en Conflicto (${count})',
          'git.conflicts.selectFileToResolve' =>
            'Selecciona un archivo para resolver',
          'git.conflicts.resolvingFile' => ({required Object file}) =>
              'Resolviendo: ${file}',
          'git.conflicts.keepAllOurs' => 'Mantener Todo Nuestro',
          'git.conflicts.acceptAllTheirs' => 'Aceptar Todo Suyo',
          'git.conflicts.allResolved' =>
            '¡Todos los conflictos en este archivo han sido resueltos!',
          'git.conflicts.markResolved' => 'Marcar como Resuelto',
          'git.conflicts.stageForCommit' =>
            'Esto preparará el archivo para commit.',
          'git.conflicts.conflictIndex' => ({required Object index}) =>
              'Conflicto #${index}',
          'git.conflicts.ours' => 'NUESTRO (Actual)',
          'git.conflicts.theirs' => 'SUYO (Entrante)',
          'git.conflicts.keepOurs' => 'Mantener Nuestro',
          'git.conflicts.acceptTheirs' => 'Aceptar Suyo',
          'git.conflicts.empty' => '(Vacío)',
          'quality._translatorNote' =>
            'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.',
          'quality.title' => 'Panel de Calidad',
          'quality.overallScore' => 'Puntuación General',
          'quality.issues' => 'Problemas',
          'quality.warnings' => 'Advertencias',
          'quality.suggestions' => 'Sugerencias',
          'quality.placeholderMismatch' => 'Desajuste Marcador',
          'quality.placeholderMismatchDescription' =>
            'Marcadores como {name} no coinciden entre origen y destino',
          'quality.lengthOutlier' => 'Longitud Atípica',
          'quality.lengthOutlierDescription' =>
            'La longitud de traducción difiere significativamente del origen',
          'quality.duplicateValue' => 'Valor Duplicado',
          'quality.duplicateValueDescription' =>
            'Misma traducción usada para múltiples claves',
          'quality.missingTranslation' => 'Traducción Faltante',
          'quality.missingTranslationDescription' =>
            'Falta la traducción para esta clave',
          'quality.loading' => 'Cargando panel...',
          'quality.errorLoading' =>
            'No pudimos cargar tu historial. Intenta de nuevo.',
          'quality.emptyState' => 'Ejecuta una comparación para ver tu panel.',
          'quality.refresh' => 'Actualizar',
          'quality.buildingInsights' => 'Construyendo insights...',
          'quality.crunchingNumbers' => 'Procesando números...',
          'quality.errorBuilding' =>
            'No pudimos construir el panel. Intenta de nuevo.',
          'quality.noUsableData' => 'Aún no se encontraron datos utilizables.',
          'quality.languages' => 'Idiomas',
          'quality.averageCoverage' => 'Cobertura media',
          'quality.potentialIssues' => 'Problemas potenciales',
          'quality.translationCoverage' => 'Cobertura de traducción',
          'quality.entriesTranslated' => (
                  {required Object translated, required Object total}) =>
              '${translated} de ${total} entradas traducidas',
          'quality.wordsAddedOverTime' => 'Palabras añadidas en el tiempo',
          'quality.completionVsScope' => 'Completado vs Alcance',
          'quality.scopeVsProgress' => 'Alcance vs Progreso',
          'quality.coveragePercent' => '% Cobertura',
          'quality.wordsAdded' => 'Palabras Añadidas',
          'quality.words' => 'Palabras',
          'quality.coverage' => 'Cobertura',
          'quality.scope' => 'Alcance',
          'quality.latest' => 'Último',
          'quality.added' => 'Añadido',
          'quality.change' => 'Cambio',
          'quality.totalScope' => 'Alcance Total',
          'quality.wordsCount' => ({required Object count}) =>
              '${count} palabras',
          'quality.scopeGrowth' => 'Crecimiento Alcance',
          'quality.range' => 'Rango',
          'quality.aiUsage' => 'Uso de IA y Traducción',
          'quality.lastUsed' => ({required Object date}) =>
              'Último uso ${date}',
          'quality.noIssuesFound' =>
            'No se encontraron problemas en las últimas comparaciones.',
          'quality.placeholderMismatches' => 'Desajustes marcadores',
          'quality.placeholderMismatchesDesc' =>
            'Marcadores como {name} no coinciden.',
          'quality.lengthOutliers' => 'Traducciones muy cortas o largas',
          'quality.lengthOutliersDesc' =>
            'La longitud parece inusual comparada con el origen.',
          'quality.duplicateValues' => 'Valores duplicados',
          'quality.duplicateValuesDesc' =>
            'La misma traducción se usa muchas veces.',
          'quality.placeholderDialogTitle' => 'Desajustes de Marcadores',
          'quality.placeholderDialogDesc' =>
            'Estas traducciones tienen marcadores diferentes ({name}) al origen.',
          'quality.lengthDialogTitle' => 'Longitudes Atípicas',
          'quality.lengthDialogDesc' =>
            'Estas traducciones son significativamente más cortas o largas que el origen.',
          'quality.duplicateDialogTitle' => 'Valores Duplicados',
          'quality.duplicateDialogDesc' =>
            'Estas traducciones aparecen múltiples veces.',
          'quality.duplicateSample' => ({required Object value}) =>
              'Duplicado: "${value}"',
          'quality.exportError' =>
            'No se pudo construir el informe. Por favor intenta de nuevo.',
          'quality.noDataToExport' => 'Sin datos para exportar',
          'quality.exportFailed' => 'Fallo exportación',
          'quality.exportDialogTitle' => 'Exportar Informe Calidad',
          'quality.reportSaved' => 'Informe guardado',
          'quality.export' => 'Exportar',
          'quality.requests' => 'Solicitudes',
          'quality.tokens' => 'Tokens',
          'quality.characters' => 'Caracteres',
          'quality.estCost' => 'Coste Est.',
          'quality.prompt' => 'Prompt',
          'quality.completion' => 'Completado',
          'quality.showingCurrentProject' => 'Mostrando: Proyecto Actual',
          'quality.showingAllHistory' => 'Mostrando: Todo el Historial',
          'quality.filesSkipped' =>
            'Algunos archivos se saltaron porque no se encontraron.',
          'quality.charCount' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
                n,
                one: '1 carácter',
                other: '${count} caracteres',
              ),
          'quality.lengthDiff' => (
                  {required Object target,
                  required Object percent,
                  required Object source}) =>
              'Objetivo es ${target} (${percent}%) vs fuente ${source}',
          'errors.genericError' => 'Ocurrió un error',
          'errors.fileNotFound' => 'Archivo no encontrado',
          'errors.invalidFormat' => 'Formato de archivo inválido',
          'errors.parseError' => 'Fallo al analizar archivo',
          'errors.networkError' =>
            'Error de red. Por favor comprueba tu conexión.',
          'errors.permissionDenied' => 'Permiso denegado',
          'errors.unknownError' => 'Ocurrió un error desconocido',
          'wizards.firstRun.welcome' => 'Bienvenido a Localizer',
          'wizards.firstRun.description' =>
            'Compara tus archivos de localización en segundos.',
          'wizards.firstRun.sourceFile' => 'Archivo Origen',
          'wizards.firstRun.targetFile' => 'Archivo Destino',
          'wizards.firstRun.compareNow' => 'Comparar Ahora',
          'wizards.firstRun.trySample' => 'Probar con Datos de Ejemplo',
          'wizards.firstRun.skip' => 'Saltar Configuración',
          'wizards.firstRun.browse' => 'Clic para examinar',
          'wizards.firstRun.error' => ({required Object error}) =>
              'Fallo al cargar datos de ejemplo: ${error}',
          'dialogs.addIgnorePattern.title' => 'Añadir Patrón Ignorar',
          'dialogs.addIgnorePattern.patternLabel' => 'Patrón (regex)',
          'dialogs.addIgnorePattern.hint' => 'ej., ^temp_.*',
          'dialogs.addIgnorePattern.invalid' => 'Patrón regex inválido',
          'dialogs.addIgnorePattern.testStringLabel' => 'Cadena de Prueba',
          'dialogs.addIgnorePattern.testHint' =>
            'Introduce una clave para probar contra el patrón',
          'dialogs.addIgnorePattern.match' =>
            '✓ El patrón coincide con la cadena',
          'dialogs.addIgnorePattern.noMatch' => '✗ El patrón no coincide',
          'dialogs.addIgnorePattern.add' => 'Añadir',
          'dialogs.addIgnorePattern.cancel' => 'Cancelar',
          'dialogs.diffViewer.title' => 'Visor de Diferencias',
          'dialogs.diffViewer.originalFile' => 'Archivo Original/Referencia',
          'dialogs.diffViewer.translationFile' =>
            'Archivo Traducción/Comparación',
          'dialogs.diffViewer.base' => 'BASE',
          'dialogs.diffViewer.target' => 'DESTINO',
          'dialogs.diffViewer.added' => 'Añadido',
          'dialogs.diffViewer.removed' => 'Eliminado',
          'dialogs.diffViewer.modified' => 'Modificado',
          'dialogs.diffViewer.noMatches' =>
            'Ninguna entrada coincide con los filtros actuales',
          'dialogs.diffViewer.clickToggle' =>
            'Haz clic en las insignias arriba para alternar filtros',
          'dialogs.diffViewer.clickToHide' => '(clic para ocultar)',
          'dialogs.diffViewer.clickToShow' => '(clic para mostrar)',
          'grid.columns.key' => 'Clave',
          'grid.columns.source' => 'Origen',
          'grid.columns.status' => 'Estado',
          'grid.columns.actions' => 'Acciones',
          'tutorial.skipTutorial' => 'SALTAR TUTORIAL',
          'tutorial.finishMessage' =>
            '¡Estás listo! Toca en cualquier lugar para terminar.',
          'tutorial.next' => 'Siguiente',
          'tutorial.loadSampleData' => 'Cargar Datos de Ejemplo',
          'tutorial.browseSourceFile' => 'Examinar Archivo Origen',
          'tutorial.browseTargetFile' => 'Examinar Archivo Destino',
          'tutorial.compareFiles' => 'Comparar Archivos',
          'tutorial.hintPhase2' =>
            'Siguiente: filtros, búsqueda, vista avanzada y exportación.',
          'tutorial.steps.importSource.title' => '1. Importar Archivo Origen',
          'tutorial.steps.importSource.description' =>
            'Usa el botón abajo para examinar archivo, o arrastra y suelta en el área resaltada.',
          'tutorial.steps.importTarget.title' => '2. Importar Archivo Destino',
          'tutorial.steps.importTarget.description' =>
            'Usa el botón abajo para examinar archivo, o arrastra y suelta en el área resaltada.',
          'tutorial.steps.compare.title' => '3. Comparar Archivos',
          'tutorial.steps.compare.description' =>
            'Toca el botón abajo para ejecutar la comparación y ver los resultados.',
          'tutorial.steps.filter.title' => '4. Filtrar Resultados',
          'tutorial.steps.filter.description' =>
            'Usa estos filtros para ver cadenas Añadidas, Eliminadas o Modificadas.',
          'tutorial.steps.search.title' => '5. Resultados de Búsqueda',
          'tutorial.steps.search.description' =>
            'Encuentra claves o valor específicos usando la barra de búsqueda.',
          'tutorial.steps.advanced.title' => '6. Vista Avanzada',
          'tutorial.steps.advanced.description' =>
            'Abre la vista detallada de diff con edición, traducción IA y más.',
          'tutorial.steps.export.title' => '7. Exportar Resultados',
          'tutorial.steps.export.description' =>
            'Guarda tu comparación como archivo CSV, JSON o Excel.',
          'friendlyErrors.fileNotFound.message' =>
            'El archivo o carpeta no pudo ser encontrado.',
          'friendlyErrors.fileNotFound.suggestion' =>
            'Comprueba si el archivo fue movido o eliminado.',
          'friendlyErrors.accessDenied.message' =>
            'Acceso al archivo denegado.',
          'friendlyErrors.accessDenied.suggestion' =>
            'Intenta ejecutar la app como administrador o verifica permisos de archivo.',
          'friendlyErrors.isDirectory.message' =>
            'Se seleccionó una carpeta en lugar de un archivo.',
          'friendlyErrors.isDirectory.suggestion' =>
            'Por favor selecciona un archivo válido.',
          'friendlyErrors.fileAccess.message' =>
            'Hubo un problema accediendo al archivo.',
          'friendlyErrors.fileAccess.suggestion' =>
            'Intenta cerrar otros programas que puedan estar usándolo.',
          'friendlyErrors.unsupportedFormat.message' =>
            'Este formato de archivo u operación no es soportado.',
          'friendlyErrors.unsupportedFormat.suggestion' =>
            'Verifica la extensión de archivo o intenta un formato diferente.',
          'friendlyErrors.networkError.message' =>
            'No se pudo conectar al servidor.',
          'friendlyErrors.networkError.suggestion' =>
            'Verifica tu conexión a internet e intenta de nuevo.',
          'friendlyErrors.notGitRepo.message' =>
            'Esta carpeta no es un proyecto Git.',
          'friendlyErrors.notGitRepo.suggestion' =>
            'Navega a una carpeta que contenga un directorio .git.',
          'friendlyErrors.mergeConflict.message' =>
            'Hay conflictos de merge en el repositorio.',
          'friendlyErrors.mergeConflict.suggestion' =>
            'Resuelve los conflictos antes de continuar.',
          'friendlyErrors.gitAuthFailed.message' =>
            'Fallo de autenticación Git.',
          'friendlyErrors.gitAuthFailed.suggestion' =>
            'Verifica tus credenciales en Ajustes > Control de Versiones.',
          'friendlyErrors.gitOperationFailed.message' =>
            'Una operación Git falló.',
          'friendlyErrors.gitOperationFailed.suggestion' =>
            'Revisa la vista Git para más detalles.',
          'friendlyErrors.invalidJson.message' =>
            'El formato de archivo es inválido o corrupto.',
          'friendlyErrors.invalidJson.suggestion' =>
            'Asegura que el archivo contiene contenido JSON válido.',
          'friendlyErrors.rateLimitReached.message' =>
            'Límite de traducción alcanzado.',
          'friendlyErrors.rateLimitReached.suggestion' =>
            'Espera unos minutos o verifica los límites de tu plan API.',
          'friendlyErrors.invalidApiKey.message' => 'Clave API inválida.',
          'friendlyErrors.invalidApiKey.suggestion' =>
            'Ve a Ajustes > Traducción IA para actualizar tu clave API.',
          'friendlyErrors.translationServiceError.message' =>
            'Error del servicio de traducción.',
          'friendlyErrors.translationServiceError.suggestion' =>
            'Verifica tu clave API y conexión a internet.',
          'friendlyErrors.outOfMemory.message' =>
            'No hay suficiente memoria para completar esta operación.',
          'friendlyErrors.outOfMemory.suggestion' =>
            'Intenta cerrar otras aplicaciones o usar archivos más pequeños.',
          'friendlyErrors.genericError.message' => 'Algo salió mal.',
          'friendlyErrors.genericError.suggestion' =>
            'Por favor intenta de nuevo. Si el problema persiste, reinicia la app.',
          'systemTray.showLocalizer' => 'Mostrar Localizer',
          'systemTray.exit' => 'Salir',
          'validation.connected' => 'Conectado.',
          'validation.connectionTimeout' =>
            'Se agotó el tiempo de conexión. Por favor intenta de nuevo.',
          'validation.couldNotConnect' =>
            'No se pudo conectar. Por favor intenta de nuevo.',
          'validation.checkKeyAndTryAgain' =>
            'No se pudo conectar. Por favor verifica la clave e intenta de nuevo.',
          'validation.tryAgainLater' =>
            'No se pudo conectar ahora mismo. Por favor intenta de nuevo más tarde.',
          'validation.serviceUnavailable' =>
            'El servicio no está disponible ahora mismo. Por favor intenta de nuevo más tarde.',
          'validation.enterKeyFirst' =>
            'Por favor introduce una clave primero.',
          'validation.checking' => 'Comprobando...',
          'validation.deeplUsage' => (
                  {required Object used, required Object limit}) =>
              'Uso: ${used} / ${limit} caracteres.',
          'status.startingComparison' => 'Iniciando comparación...',
          'status.loadingFromHistory' => 'Cargando archivos desde historial...',
          'status.comparisonComplete' => 'Comparación completada',
          'status.couldNotImportFiles' =>
            'No se pudieron importar los archivos. Por favor intenta de nuevo.',
          'status.historyFilesNotFound' =>
            'Uno o ambos archivos del historial no se encontraron en rutas originales.',
          'aiServices.geminiEmptyResponse' => 'Gemini devolvió respuesta vacía',
          'aiServices.geminiStreamingEmpty' =>
            'Gemini streaming devolvió respuesta vacía',
          'aiServices.geminiRephraseEmpty' =>
            'Gemini devolvió respuesta vacía para refraseo',
          'aiServices.openaiEmptyResponse' =>
            'OpenAI devolvió respuesta vacía o fallida',
          _ => null,
        };
  }
}
