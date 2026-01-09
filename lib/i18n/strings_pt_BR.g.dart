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
class TranslationsPtBr extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsPtBr(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.ptBr,
              overrides: overrides ?? {},
              cardinalResolver: cardinalResolver,
              ordinalResolver: ordinalResolver,
            ),
        super(
            cardinalResolver: cardinalResolver,
            ordinalResolver: ordinalResolver) {
    super.$meta.setFlatMapFunction(
        $meta.getTranslation); // copy base translations to super.$meta
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <pt-BR>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsPtBr _root = this; // ignore: unused_field

  @override
  TranslationsPtBr $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsPtBr(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsAppPtBr app = _TranslationsAppPtBr._(_root);
  @override
  late final _TranslationsCommonPtBr common = _TranslationsCommonPtBr._(_root);
  @override
  late final _TranslationsMenuPtBr menu = _TranslationsMenuPtBr._(_root);
  @override
  late final _TranslationsNavPtBr nav = _TranslationsNavPtBr._(_root);
  @override
  late final _TranslationsSettingsPtBr settings =
      _TranslationsSettingsPtBr._(_root);
  @override
  late final _TranslationsFileComparisonPtBr fileComparison =
      _TranslationsFileComparisonPtBr._(_root);
  @override
  late final _TranslationsDirectoryComparisonPtBr directoryComparison =
      _TranslationsDirectoryComparisonPtBr._(_root);
  @override
  late final _TranslationsGitComparisonPtBr gitComparison =
      _TranslationsGitComparisonPtBr._(_root);
  @override
  late final _TranslationsAdvancedComparisonPtBr advancedComparison =
      _TranslationsAdvancedComparisonPtBr._(_root);
  @override
  late final _TranslationsAdvancedDiffPtBr advancedDiff =
      _TranslationsAdvancedDiffPtBr._(_root);
  @override
  late final _TranslationsIssueDetailsPtBr issueDetails =
      _TranslationsIssueDetailsPtBr._(_root);
  @override
  late final _TranslationsImportReviewPtBr importReview =
      _TranslationsImportReviewPtBr._(_root);
  @override
  late final _TranslationsHistoryViewPtBr historyView =
      _TranslationsHistoryViewPtBr._(_root);
  @override
  late final _TranslationsComparePtBr compare =
      _TranslationsComparePtBr._(_root);
  @override
  late final _TranslationsHistoryPtBr history =
      _TranslationsHistoryPtBr._(_root);
  @override
  late final _TranslationsProjectsPtBr projects =
      _TranslationsProjectsPtBr._(_root);
  @override
  late final _TranslationsDiffPtBr diff = _TranslationsDiffPtBr._(_root);
  @override
  late final _TranslationsGitPtBr git = _TranslationsGitPtBr._(_root);
  @override
  late final _TranslationsQualityPtBr quality =
      _TranslationsQualityPtBr._(_root);
  @override
  late final _TranslationsErrorsPtBr errors = _TranslationsErrorsPtBr._(_root);
  @override
  late final _TranslationsWizardsPtBr wizards =
      _TranslationsWizardsPtBr._(_root);
  @override
  late final _TranslationsDialogsPtBr dialogs =
      _TranslationsDialogsPtBr._(_root);
  @override
  late final _TranslationsGridPtBr grid = _TranslationsGridPtBr._(_root);
  @override
  late final _TranslationsTutorialPtBr tutorial =
      _TranslationsTutorialPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsPtBr friendlyErrors =
      _TranslationsFriendlyErrorsPtBr._(_root);
  @override
  late final _TranslationsSystemTrayPtBr systemTray =
      _TranslationsSystemTrayPtBr._(_root);
  @override
  late final _TranslationsValidationPtBr validation =
      _TranslationsValidationPtBr._(_root);
  @override
  late final _TranslationsStatusPtBr status = _TranslationsStatusPtBr._(_root);
  @override
  late final _TranslationsAiServicesPtBr aiServices =
      _TranslationsAiServicesPtBr._(_root);
}

// Path: app
class _TranslationsAppPtBr extends TranslationsAppEn {
  _TranslationsAppPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ferramenta de Comparação de Localização';
  @override
  String get name => 'Localizer';
}

// Path: common
class _TranslationsCommonPtBr extends TranslationsCommonEn {
  _TranslationsCommonPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get save => 'Salvar';
  @override
  String get cancel => 'Cancelar';
  @override
  String get close => 'Fechar';
  @override
  String get delete => 'Excluir';
  @override
  String get edit => 'Editar';
  @override
  String get add => 'Adicionar';
  @override
  String get search => 'Pesquisar';
  @override
  String get undo => 'Desfazer';
  @override
  String get loading => 'Carregando...';
  @override
  String get error => 'Erro';
  @override
  String get success => 'Sucesso';
  @override
  String get warning => 'Aviso';
  @override
  String get info => 'Informação';
  @override
  String get confirm => 'Confirmar';
  @override
  String get yes => 'Sim';
  @override
  String get no => 'Não';
  @override
  String get ok => 'OK';
  @override
  String get retry => 'Tentar Novamente';
  @override
  String get copyText => 'Copiar';
  @override
  String get appName => 'Localizer';
  @override
  String get copied => 'Copiado!';
  @override
  String get enabled => 'Ativado';
  @override
  String get disabled => 'Desativado';
  @override
  String get browse => 'Procurar';
  @override
  String get clear => 'Limpar';
  @override
  String get apply => 'Aplicar';
  @override
  String get reset => 'Redefinir';
  @override
  String get refresh => 'Atualizar';
  @override
  String get export => 'Exportar';
  @override
  String get import => 'Importar';
  @override
  String get select => 'Selecionar';
  @override
  String get selectAll => 'Selecionar Tudo';
  @override
  String get deselectAll => 'Desmarcar Tudo';
  @override
  String get noResults => 'Nenhum resultado encontrado';
  @override
  String get emptyState => 'Nada aqui ainda';
  @override
  String get open => 'Abrir';
  @override
  String get change => 'Alterar';
  @override
  String get original => 'Original';
  @override
  String get kNew => 'Novo';
  @override
  String get remove => 'Remover';
  @override
  String get auto => 'Automático';
  @override
  String get execute => 'Executar';
  @override
  String get run => 'Rodar';
  @override
  String get unknown => 'Desconhecido';
  @override
  String get download => 'Baixar';
  @override
  String get dropdownArrow => 'Seta suspensa';
  @override
  String get openInNewWindow => 'Abrir em nova janela';
  @override
  String get resetToDefaults => 'Redefinir para os padrões';
}

// Path: menu
class _TranslationsMenuPtBr extends TranslationsMenuEn {
  _TranslationsMenuPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get file => 'Arquivo';
  @override
  String get edit => 'Editar';
  @override
  String get view => 'Exibir';
  @override
  String get help => 'Ajuda';
  @override
  String get openFiles => 'Abrir Arquivos...';
  @override
  String get openFolder => 'Abrir Pasta...';
  @override
  String get exportResults => 'Exportar Resultados...';
  @override
  String get undo => 'Desfazer';
  @override
  String get redo => 'Refazer';
  @override
  String get cut => 'Recortar';
  @override
  String get paste => 'Colar';
  @override
  String get selectAll => 'Selecionar Tudo';
  @override
  String get zoomIn => 'Aumentar Zoom';
  @override
  String get zoomOut => 'Diminuir Zoom';
  @override
  String get resetZoom => 'Redefinir Zoom';
  @override
  String get documentation => 'Documentação';
  @override
  String get reportIssue => 'Relatar um Problema';
  @override
  String about({required Object appName}) => 'Sobre ${appName}';
}

// Path: nav
class _TranslationsNavPtBr extends TranslationsNavEn {
  _TranslationsNavPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get compare => 'Comparar';
  @override
  String get history => 'Histórico';
  @override
  String get settings => 'Configurações';
  @override
  String get projects => 'Projetos';
  @override
  String get dashboard => 'Painel';
  @override
  String get directory => 'Diretório';
  @override
  String get repository => 'Repositório';
  @override
  String get tooltipCompare => 'Comparar arquivos de localização';
  @override
  String get tooltipHistory => 'Ver histórico de comparação';
  @override
  String get tooltipSettings => 'Configurações do aplicativo';
  @override
  String get tooltipProjects => 'Gerenciar projetos';
  @override
  String get tooltipThemeToggle => 'Alternar Tema';
  @override
  String get tooltipDebugConsole => 'Console de Depuração';
}

// Path: settings
class _TranslationsSettingsPtBr extends TranslationsSettingsEn {
  _TranslationsSettingsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Configurações';
  @override
  String get appSettings => 'Configurações do App';
  @override
  String get projectSettings => 'Configurações do Projeto';
  @override
  late final _TranslationsSettingsAppearancePtBr appearance =
      _TranslationsSettingsAppearancePtBr._(_root);
  @override
  late final _TranslationsSettingsGeneralPtBr general =
      _TranslationsSettingsGeneralPtBr._(_root);
  @override
  late final _TranslationsSettingsScopePtBr scope =
      _TranslationsSettingsScopePtBr._(_root);
  @override
  late final _TranslationsSettingsSearchKeywordsPtBr searchKeywords =
      _TranslationsSettingsSearchKeywordsPtBr._(_root);
  @override
  late final _TranslationsSettingsComparisonPtBr comparison =
      _TranslationsSettingsComparisonPtBr._(_root);
  @override
  late final _TranslationsSettingsFileHandlingPtBr fileHandling =
      _TranslationsSettingsFileHandlingPtBr._(_root);
  @override
  late final _TranslationsSettingsTranslationMemoryPtBr translationMemory =
      _TranslationsSettingsTranslationMemoryPtBr._(_root);
  @override
  late final _TranslationsSettingsBackupPtBr backup =
      _TranslationsSettingsBackupPtBr._(_root);
  @override
  late final _TranslationsSettingsAiPtBr ai =
      _TranslationsSettingsAiPtBr._(_root);
  @override
  late final _TranslationsSettingsIntegrationsPtBr integrations =
      _TranslationsSettingsIntegrationsPtBr._(_root);
  @override
  late final _TranslationsSettingsDeveloperPtBr developer =
      _TranslationsSettingsDeveloperPtBr._(_root);
  @override
  late final _TranslationsSettingsAboutPtBr about =
      _TranslationsSettingsAboutPtBr._(_root);
  @override
  late final _TranslationsSettingsOnboardingPtBr onboarding =
      _TranslationsSettingsOnboardingPtBr._(_root);
  @override
  late final _TranslationsSettingsSettingsViewPtBr settingsView =
      _TranslationsSettingsSettingsViewPtBr._(_root);
}

// Path: fileComparison
class _TranslationsFileComparisonPtBr extends TranslationsFileComparisonEn {
  _TranslationsFileComparisonPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Comparação de Arquivos';
  @override
  String get openFiles => 'Abrir Arquivos';
  @override
  String get exportResults => 'Exportar Resultados';
  @override
  String get restartTutorial => 'Reiniciar Tutorial';
  @override
  String get restartTutorialDevOnly =>
      'A reinicialização do tutorial está disponível apenas no modo de desenvolvedor.';
  @override
  String get unsupportedFileType => 'Tipo de arquivo não suportado.';
  @override
  String get unsupportedFileTypeSuggestion =>
      'Por favor, selecione um arquivo de localização suportado.';
  @override
  String get someFilesUnsupported => 'Alguns arquivos não são suportados.';
  @override
  String get pickSupportedFiles =>
      'Escolha apenas arquivos de localização suportados.';
  @override
  String get pickTwoFiles => 'Escolha dois arquivos para comparar.';
  @override
  String get pickBilingualFile =>
      'Por favor, selecione um arquivo bilíngue para comparar.';
  @override
  String get noResultsToExport => 'Nenhum resultado para exportar ainda.';
  @override
  String get performComparisonFirst =>
      'Realize uma comparação primeiro para exportar os resultados.';
  @override
  String get performComparisonFirstEditor =>
      'Por favor, realize uma comparação primeiro para ver os detalhes avançados.';
  @override
  String get sampleDataLoaded => 'Dados de exemplo carregados com sucesso';
  @override
  String loadSampleDataError({required Object error}) =>
      'Falha ao carregar dados de exemplo: ${error}';
  @override
  String get invalidFileType => 'Tipo de arquivo inválido.';
  @override
  String fileSelected({required Object label, required Object fileName}) =>
      '${label} selecionado: ${fileName}';
  @override
  String get sourceFile => 'Arquivo de origem';
  @override
  String get targetFile => 'Arquivo de destino';
  @override
  String get bilingualFile => 'Arquivo bilíngue';
  @override
  String get compareFiles => 'Comparar Arquivos';
  @override
  String get compareFile => 'Comparar Arquivo';
  @override
  String get bilingualMode => 'Modo Bilíngue';
  @override
  String get twoFilesMode => 'Dois Arquivos';
  @override
  String get processing => 'Processando...';
  @override
  String remaining({required Object time}) => '${time} restante';
  @override
  String get comparisonInProgress => 'Comparação em andamento...';
  @override
  String comparisonFailed({required Object error}) =>
      'Falha na Comparação: ${error}';
  @override
  String fileChanged({required Object fileName}) =>
      'Arquivo alterado: ${fileName}. Recomparando...';
  @override
  String get dropFileHere => 'Solte o arquivo aqui';
  @override
  String get dropFileOrBrowse => 'Solte o arquivo ou clique para procurar';
  @override
  String get fileUpload => 'Upload de arquivo';
  @override
  String get changeFile => 'Alterar arquivo';
  @override
  String get total => 'Total';
  @override
  String get show => 'Mostrar';
  @override
  String get showAll => 'Mostrar Tudo';
  @override
  String noMatches({required Object query}) =>
      'Nenhum resultado encontrado para "${query}"';
  @override
  String showingEntries({required Object count, required Object total}) =>
      'Mostrando ${count} de ${total} entradas';
  @override
  String get filesIdentical => 'Os arquivos são idênticos.';
  @override
  String hiddenIdentical({required Object count}) =>
      '${count} entradas idênticas ocultas';
  @override
  String get showIdentical => 'Mostrar Entradas Idênticas';
  @override
  String get hideIdentical => 'Ocultar entradas idênticas';
  @override
  String get noDiff => 'Nenhuma diferença encontrada com base nas chaves.';
  @override
  String get source => 'Origem';
  @override
  String get target => 'Destino';
  @override
  String get value => 'Valor';
  @override
  String get readyToCompare => 'Pronto para Comparar Arquivos';
  @override
  String get readyToCompareDesc =>
      'Solte arquivos de localização acima ou use os botões de procurar\npara selecionar arquivos para comparação.';
  @override
  String get recentComparisons => 'Comparações Recentes';
  @override
  String bilingualFileLabel({required Object name}) =>
      'Arquivo bilíngue: ${name}';
  @override
  String comparisonLabel({required Object source, required Object target}) =>
      '${source} ↔ ${target}';
  @override
  String get fileNotExist =>
      'Um ou ambos os arquivos desta sessão não existem mais.';
  @override
  String get largeFileTitle => 'Arquivo Grande Detectado';
  @override
  String largeFileContent({required Object count}) =>
      'O resultado da comparação contém ${count} entradas.\nExibi-las todas pode causar problemas de desempenho.\n\nDeseja continuar?';
  @override
  String get dontShowAgain => 'Não mostrar novamente para este arquivo';
  @override
  String get proceed => 'Continuar';
  @override
  String exportReport({required Object format}) => 'Salvar Relatório ${format}';
  @override
  String saved({required Object format}) => '${format} salvo';
  @override
  String saveError({required Object format}) =>
      'Falha ao salvar o arquivo ${format}.';
  @override
  String saveErrorDetailed({required Object format, required Object error}) =>
      'Falha ao salvar ${format}: ${error}';
  @override
  String get watching => 'Monitorando';
  @override
  String get watchOff => 'Monitoramento Desligado';
  @override
  String watchingTooltip({required Object status}) =>
      'Monitoramento de Arquivos: ${status}\nRecomparar automaticamente quando os arquivos mudarem no disco';
  @override
  String get aiSettingsNotAvailable =>
      'Navegação para Configurações de IA não disponível';
}

// Path: directoryComparison
class _TranslationsDirectoryComparisonPtBr
    extends TranslationsDirectoryComparisonEn {
  _TranslationsDirectoryComparisonPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Comparação de Diretórios';
  @override
  String get sourceDirectory => 'Diretório de Origem';
  @override
  String get targetDirectory => 'Diretório de Destino';
  @override
  String get sourceSubtitle => 'Arquivos originais/referência';
  @override
  String get targetSubtitle => 'Arquivos de tradução/comparação';
  @override
  String get selectBothDirectories =>
      'Por favor, selecione os diretórios de origem e destino.';
  @override
  String get selectSourceFolder => 'Selecionar Pasta de Origem';
  @override
  String get selectTargetFolder => 'Selecionar Pasta de Destino';
  @override
  String get dropFolderHere => 'Solte a pasta aqui ou procure...';
  @override
  String get folderPath => 'Caminho da Pasta';
  @override
  String get readyToCompare => 'Pronto para Comparar Diretórios';
  @override
  String get readyToCompareDesc =>
      'Solte pastas acima ou use os botões de procurar\npara selecionar diretórios para comparação.';
  @override
  String get nestedFolders => 'Pastas aninhadas';
  @override
  String get nestedFoldersTooltip =>
      'Compara recursivamente todos os diretórios aninhados';
  @override
  String get fileMatching => 'Correspondência de arquivos';
  @override
  String get fileMatchingTooltip =>
      'Emparelha automaticamente arquivos pelo nome';
  @override
  String get bulkExport => 'Exportação em massa';
  @override
  String get bulkExportTooltip =>
      'Exportar todos os resultados da comparação de uma vez';
  @override
  String get notDirectoryComparison =>
      'Isto não é uma comparação de diretório.';
  @override
  String get directoriesNotExist =>
      'Um ou ambos os diretórios não existem mais.';
  @override
  String get errorOccurred => 'Ocorreu um erro';
  @override
  String get noFilesFound =>
      'Nenhum arquivo encontrado nos diretórios selecionados.';
  @override
  String get unmatchedSourceFiles => 'Arquivos de Origem não Correspondidos';
  @override
  String get unmatchedTargetFiles => 'Arquivos de Destino não Correspondidos';
  @override
  String filePairs({required Object count}) => '${count} pares de arquivos';
  @override
  String pairedFiles({required Object count}) =>
      'Arquivos Emparelhados (${count})';
  @override
  String get view => 'Ver';
  @override
  String get failed => 'Falhou';
  @override
  String get pair => 'Parear...';
  @override
  String pairDialogTitle({required Object name}) => 'Parear "${name}" com:';
  @override
  String get discoverFiles => 'Descobrir Arquivos';
  @override
  String get compareAll => 'Comparar Tudo';
  @override
  String get exportAll => 'Exportar Tudo';
  @override
  String get comparisonStarted => 'Comparação iniciada...';
  @override
  String get discoveringFiles => 'Descobrindo arquivos...';
  @override
  String get noResultsToExport =>
      'Nenhum resultado de comparação para exportar. Execute "Comparar Tudo" primeiro.';
  @override
  String get selectExportFolder => 'Selecionar Pasta de Exportação';
  @override
  String createExportFolderError({required Object error}) =>
      'Falha ao criar pasta de exportação: ${error}';
  @override
  String get exportingResults => 'Exportando Resultados';
  @override
  String processingFile({required Object file}) => 'Processando: ${file}';
  @override
  String exportProgress({required Object current, required Object total}) =>
      '${current} de ${total} arquivos exportados';
  @override
  String get exportComplete => 'Exportação Concluída';
  @override
  String exportSuccessMessage({required Object count}) =>
      'Exportados com sucesso ${count} arquivos de comparação mais o resumo.';
  @override
  String exportFailed({required Object error}) => 'Exportação falhou: ${error}';
  @override
  String get close => 'Fechar';
}

// Path: gitComparison
class _TranslationsGitComparisonPtBr extends TranslationsGitComparisonEn {
  _TranslationsGitComparisonPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'Termos Git (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) devem permanecer em Inglês para todas as traduções a fim de evitar confusão entre desenvolvedores.';
  @override
  String get title => 'Comparação de Repositório';
  @override
  String get repoSelector => 'Criar / Abrir Repositório';
  @override
  String get noRepoSelected => 'Nenhum repositório selecionado';
  @override
  String get open => 'Abrir';
  @override
  String get refreshCommits => 'Atualizar Commits';
  @override
  String get noCommits =>
      'Nenhum commit encontrado ou carregado. Selecione uma branch para carregar os commits.';
  @override
  String get baseCommit => 'Commit Base (Mais Antigo)';
  @override
  String get targetCommit => 'Commit de Destino (Mais Recente)';
  @override
  String get filterCommitsByBranch => 'Filtrar Commits por Branch';
  @override
  String get conflictDetection => 'Detecção de conflitos';
  @override
  String get conflictDetectionTooltip =>
      'Detectar e resolver conflitos de merge';
  @override
  String get actions => 'Ações:';
  @override
  String get checkout => 'Checkout';
  @override
  String get merge => 'Merge';
  @override
  String get pull => 'Pull';
  @override
  String get checkoutBranch => 'Checkout Branch';
  @override
  String get mergeBranch => 'Fazer Merge da Branch na Atual';
  @override
  String mergeConfirmation({required Object branch}) =>
      'Fazer merge de ${branch}?';
  @override
  String get mergeWarning =>
      'Isso fará o merge das alterações na sua branch atual. Conflitos podem ocorrer.';
  @override
  String get selectExportFolder => 'Selecionar Pasta de Exportação';
  @override
  String createExportFolderError({required Object error}) =>
      'Falha ao criar pasta de exportação: ${error}';
  @override
  String get exportingFiles => 'Exportando Arquivos';
  @override
  String processingFile({required Object file}) => 'Processando: ${file}';
  @override
  String exportProgress({required Object current, required Object total}) =>
      '${current} de ${total} arquivos exportados';
  @override
  String get exportComplete => 'Exportação Concluída';
  @override
  String exportSuccessMessage({required Object count}) =>
      'Exportados com sucesso ${count} arquivos com conteúdo completo.';
  @override
  String get exportDetail =>
      'O diff de cada arquivo é salvo na subpasta "files".';
  @override
  String get diffViewer => 'Visualizador de Diff';
  @override
  String get base => 'BASE';
  @override
  String get target => 'DESTINO';
  @override
  String get noLines => 'Nenhuma linha para exibir';
  @override
  String get searchFiles => 'Pesquisar arquivos...';
  @override
  String noFilesMatch({required Object query}) =>
      'Nenhum arquivo corresponde a "${query}"';
  @override
  String filesCount({required Object count}) => '${count} arquivos';
  @override
  String get selectBaseFile => 'Selecionar Arquivo Base';
  @override
  String get selectTargetFile => 'Selecionar Arquivo de Destino';
  @override
  String get comparisonResults => 'Resultados da Comparação';
  @override
  String get noChanges =>
      'Nenhuma alteração encontrada entre as referências selecionadas.';
  @override
  String get linesAdded => 'Linhas Adicionadas';
  @override
  String get linesRemoved => 'Linhas Removidas';
  @override
  String get commit => 'Commit';
  @override
  String get branch => 'Branch';
  @override
  String get noRepositorySelected => 'Nenhum repositório selecionado';
  @override
  String get notGitComparison => 'Não é uma comparação Git';
  @override
  String get repositoryNotExist => 'Repositório não existe';
  @override
  String get mainBranch => 'main';
  @override
  String get masterBranch => 'master';
  @override
  String get backToControls => 'Voltar aos controles de comparação';
}

// Path: advancedComparison
class _TranslationsAdvancedComparisonPtBr
    extends TranslationsAdvancedComparisonEn {
  _TranslationsAdvancedComparisonPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get placeholder =>
      'Visualização de Comparação Avançada - Espaço Reservado';
}

// Path: advancedDiff
class _TranslationsAdvancedDiffPtBr extends TranslationsAdvancedDiffEn {
  _TranslationsAdvancedDiffPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get saveAllChanges => 'Salvar Todas as Alterações?';
  @override
  String saveConfirmation({required Object count}) =>
      'Isso salvará todas as ${count} entradas modificadas no arquivo de destino. Esta ação não pode ser desfeita.';
  @override
  String get changesSaved => 'Alterações salvas com sucesso.';
  @override
  String get csvExported => 'CSV exportado';
  @override
  String get unsavedChanges => 'Alterações Não Salvas';
  @override
  String get unsavedChangesWarning =>
      'Você tem alterações não salvas. Tem certeza de que deseja descartá-las?';
  @override
  String get discardChanges => 'Descartar Alterações';
  @override
  String get goBack => 'Voltar';
  @override
  String get breadcrumbs => 'Início  >  Editor';
  @override
  String unsaved({required Object count}) => '${count} não salvas';
  @override
  String reviewed({required Object count}) => '${count} revisadas';
  @override
  String saveAll({required Object count}) => 'Salvar Tudo (${count})';
  @override
  String get allSaved => 'Tudo Salvo';
  @override
  String get saveAllTooltip => 'Salvar Todas as Alterações (Ctrl+S)';
  @override
  String get exportTooltip => 'Exportar Dados (Ctrl+E)';
  @override
  late final _TranslationsAdvancedDiffAiSuggestionPtBr aiSuggestion =
      _TranslationsAdvancedDiffAiSuggestionPtBr._(_root);
  @override
  late final _TranslationsAdvancedDiffDetailEditPtBr detailEdit =
      _TranslationsAdvancedDiffDetailEditPtBr._(_root);
  @override
  late final _TranslationsAdvancedDiffTablePtBr table =
      _TranslationsAdvancedDiffTablePtBr._(_root);
  @override
  late final _TranslationsAdvancedDiffDiffRowPtBr diffRow =
      _TranslationsAdvancedDiffDiffRowPtBr._(_root);
  @override
  late final _TranslationsAdvancedDiffStatusPtBr status =
      _TranslationsAdvancedDiffStatusPtBr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarPtBr sidebar =
      _TranslationsAdvancedDiffSidebarPtBr._(_root);
}

// Path: issueDetails
class _TranslationsIssueDetailsPtBr extends TranslationsIssueDetailsEn {
  _TranslationsIssueDetailsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Detalhes do Problema';
  @override
  String showingIssues({required Object count, required Object total}) =>
      'Mostrando ${count} de ${total} problemas';
  @override
  String get searchPlaceholder => 'Pesquisar por chave, texto ou erro...';
  @override
  String get noDetails => 'Nenhum detalhe disponível.';
  @override
  String get noMatches => 'Nenhuma correspondência encontrada.';
  @override
  String get showMore => 'Mostrar Mais';
  @override
  String copyItems({required Object count}) => 'Copiar ${count} Itens';
  @override
  String get close => 'Fechar';
  @override
  String get copied => 'Copiado para a área de transferência';
  @override
  String copiedCount({required Object count}) => 'Copiados ${count} itens';
  @override
  late final _TranslationsIssueDetailsDuplicateValuePtBr duplicateValue =
      _TranslationsIssueDetailsDuplicateValuePtBr._(_root);
  @override
  late final _TranslationsIssueDetailsLengthOutlierPtBr lengthOutlier =
      _TranslationsIssueDetailsLengthOutlierPtBr._(_root);
  @override
  late final _TranslationsIssueDetailsStandardPtBr standard =
      _TranslationsIssueDetailsStandardPtBr._(_root);
  @override
  String get review => 'Revisar';
  @override
  late final _TranslationsIssueDetailsTypesPtBr types =
      _TranslationsIssueDetailsTypesPtBr._(_root);
  @override
  late final _TranslationsIssueDetailsNotesPtBr notes =
      _TranslationsIssueDetailsNotesPtBr._(_root);
  @override
  late final _TranslationsIssueDetailsFallbacksPtBr fallbacks =
      _TranslationsIssueDetailsFallbacksPtBr._(_root);
}

// Path: importReview
class _TranslationsImportReviewPtBr extends TranslationsImportReviewEn {
  _TranslationsImportReviewPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Revisar Importação de Projeto';
  @override
  String get projectName => 'Nome do Projeto';
  @override
  String get created => 'Criado';
  @override
  String get historyItems => 'Itens do Histórico';
  @override
  String get customSettingsTitle => 'Configurações Personalizadas Detectadas';
  @override
  String get customSettingsWarning =>
      'Este projeto contém configurações personalizadas que substituirão seus padrões enquanto este projeto estiver aberto.';
  @override
  String get standardSettings =>
      'Este projeto usa configurações globais padrão.';
  @override
  String get cancelImport => 'Cancelar Importação';
  @override
  String get trustOpen => 'Confiar & Abrir Projeto';
}

// Path: historyView
class _TranslationsHistoryViewPtBr extends TranslationsHistoryViewEn {
  _TranslationsHistoryViewPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Histórico de Comparações';
  @override
  String get clearAll => 'Limpar todo o histórico';
  @override
  String get searchPlaceholder => 'Pesquisar por nome de arquivo...';
  @override
  String get sortBy => 'Ordenar por';
  @override
  String get sortDate => 'Data';
  @override
  String get sortSource => 'Arquivo de Origem';
  @override
  String get sortTarget => 'Arquivo de Destino';
  @override
  String get showCurrentProject => 'Mostrando: Projeto Atual';
  @override
  String get showAllHistory => 'Mostrando: Todo o Histórico';
  @override
  String get groupByFolder => 'Agrupar por pasta';
  @override
  String get disableGrouping => 'Desativar agrupamento por pasta';
  @override
  String get filterAll => 'Tudo';
  @override
  String get filterFiles => 'Arquivos';
  @override
  String get filterDirectories => 'Diretórios';
  @override
  String get filterGit => 'Git';
  @override
  String get noHistory => 'Nenhum histórico de comparação ainda';
  @override
  String get historyDescription =>
      'Suas comparações de arquivos aparecerão aqui';
  @override
  String get noResults => 'Nenhum resultado encontrado';
  @override
  String get adjustSearch => 'Tente ajustar sua pesquisa';
  @override
  String get clearConfirmationTitle => 'Limpar Todo o Histórico?';
  @override
  String get clearConfirmationContent =>
      'Isso excluirá permanentemente todo o histórico de comparações. Esta ação não pode ser desfeita.';
  @override
  String get clearAction => 'Limpar Tudo';
  @override
  String get deletedMessage => 'Item do histórico excluído';
  @override
  String get undo => 'Desfazer';
  @override
  String get viewDetails => 'Ver Detalhes';
  @override
  String get delete => 'Excluir';
  @override
  String get openLocation => 'Abrir local do arquivo';
  @override
  String get bilingual => 'Bilíngue';
  @override
  String get filePair => 'Par de Arquivos';
  @override
  String get directory => 'Diretório';
  @override
  String get git => 'Git';
  @override
  String get repo => 'Repo';
  @override
  String get sourceDir => 'Dir. de Origem';
  @override
  String get targetDir => 'Dir. de Destino';
  @override
  String get source => 'Origem';
  @override
  String get target => 'Destino';
  @override
  String get noChanges => 'Nenhuma alteração detectada';
  @override
  String get added => 'Adicionado';
  @override
  String get removed => 'Removido';
  @override
  String get modified => 'Modificado';
  @override
  String get same => 'Igual';
  @override
  String get total => 'Total';
  @override
  String get currentProject => 'Projeto Atual';
  @override
  String get unassigned => 'Não atribuído';
  @override
  String get project => 'Projeto';
}

// Path: compare
class _TranslationsComparePtBr extends TranslationsCompareEn {
  _TranslationsComparePtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Comparar Arquivos';
  @override
  String get sourceFile => 'Arquivo de Origem';
  @override
  String get targetFile => 'Arquivo de Destino';
  @override
  String get sourceFolder => 'Pasta de Origem';
  @override
  String get targetFolder => 'Pasta de Destino';
  @override
  String get dropFilesHint =>
      'Solte os arquivos de localização aqui ou use os botões de procurar para selecionar os arquivos para comparação.';
  @override
  String get selectSourceFile => 'Selecionar arquivo de origem';
  @override
  String get selectTargetFile => 'Selecionar arquivo de destino';
  @override
  String get startComparison => 'Iniciar Comparação';
  @override
  String get comparing => 'Comparando...';
  @override
  String get comparisonComplete => 'Comparação concluída';
  @override
  String get noChanges => 'Nenhuma alteração detectada';
  @override
  String get filesIdentical => 'Os arquivos são idênticos';
  @override
  String changesFound({required Object count}) =>
      '${count} alterações encontradas';
  @override
  late final _TranslationsCompareTabsPtBr tabs =
      _TranslationsCompareTabsPtBr._(_root);
  @override
  late final _TranslationsCompareFileTypesPtBr fileTypes =
      _TranslationsCompareFileTypesPtBr._(_root);
}

// Path: history
class _TranslationsHistoryPtBr extends TranslationsHistoryEn {
  _TranslationsHistoryPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Histórico';
  @override
  String get recentComparisons => 'Comparações Recentes';
  @override
  String get noHistory => 'Nenhum histórico de comparação ainda';
  @override
  String get noHistoryDescription =>
      'Seu histórico de comparações aparecerão aqui';
  @override
  String get clearHistory => 'Limpar Histórico';
  @override
  String get clearHistoryConfirm =>
      'Tem certeza de que deseja limpar todo o histórico?';
  @override
  String get deleteEntry => 'Excluir Entrada';
  @override
  String get openComparison => 'Abrir Comparação';
  @override
  late final _TranslationsHistoryTimeAgoPtBr timeAgo =
      _TranslationsHistoryTimeAgoPtBr._(_root);
}

// Path: projects
class _TranslationsProjectsPtBr extends TranslationsProjectsEn {
  _TranslationsProjectsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Projetos';
  @override
  String get createProject => 'Criar Projeto';
  @override
  String get importProject => 'Importar Projeto';
  @override
  String get noProjects => 'Nenhum projeto ainda';
  @override
  String get noProjectsDescription =>
      'Crie um projeto para organizar seus arquivos de localização';
  @override
  String get projectName => 'Nome do Projeto';
  @override
  String get projectPath => 'Caminho do Projeto';
  @override
  String get lastOpened => 'Aberto pela última vez';
  @override
  String get openProject => 'Abrir Projeto';
  @override
  String get closeProject => 'Fechar Projeto';
  @override
  String get deleteProject => 'Excluir Projeto';
  @override
  String get deleteProjectConfirm =>
      'Tem certeza de que deseja excluir este projeto?';
  @override
  String get exportProject => 'Exportar Projeto';
  @override
  String get exportDescription =>
      'Crie um arquivo zip portátil contendo arquivos de origem, configuração e histórico.';
  @override
  String get exporting => 'Exportando projeto...';
  @override
  String get exportSuccess => 'Projeto exportado';
  @override
  String exportError({required Object error}) =>
      'Falha na exportação: ${error}';
  @override
  String get createNewProject => 'Criar Novo Projeto';
  @override
  String get openExistingProject => 'Abrir Projeto Existente';
  @override
  String get importProjectZip => 'Importar Zip de Projeto';
  @override
  String get projectResources => 'Recursos do Projeto';
  @override
  String get recentProjects => 'Projetos Recentes';
  @override
  String get noRecentProjects => 'Nenhum projeto recente';
  @override
  String get selectProjectZip => 'Selecionar Zip de Projeto';
  @override
  String get selectDestination => 'Selecionar Pasta de Destino para Importação';
  @override
  String get importing => 'Importando projeto...';
  @override
  String get importSuccess => 'Projeto importado com sucesso';
  @override
  String importFailed({required Object error}) => 'Importação falhou: ${error}';
  @override
  String get importingFiles => 'Importando arquivos...';
  @override
  String get noSupportedFiles => 'Nenhum arquivo suportado foi solto.';
  @override
  late final _TranslationsProjectsStatsPtBr stats =
      _TranslationsProjectsStatsPtBr._(_root);
  @override
  String get openProjectFirst =>
      'Abra um projeto primeiro para gerenciar seus recursos.';
  @override
  String get removeFromRecent => 'Remover dos recentes';
  @override
  late final _TranslationsProjectsSelectionPtBr selection =
      _TranslationsProjectsSelectionPtBr._(_root);
  @override
  late final _TranslationsProjectsCreateDialogPtBr createDialog =
      _TranslationsProjectsCreateDialogPtBr._(_root);
  @override
  late final _TranslationsProjectsIndicatorPtBr indicator =
      _TranslationsProjectsIndicatorPtBr._(_root);
  @override
  late final _TranslationsProjectsGlossaryPtBr glossary =
      _TranslationsProjectsGlossaryPtBr._(_root);
  @override
  late final _TranslationsProjectsConflictsPtBr conflicts =
      _TranslationsProjectsConflictsPtBr._(_root);
  @override
  late final _TranslationsProjectsTmPtBr tm =
      _TranslationsProjectsTmPtBr._(_root);
}

// Path: diff
class _TranslationsDiffPtBr extends TranslationsDiffEn {
  _TranslationsDiffPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'Adicionado';
  @override
  String get removed => 'Removido';
  @override
  String get modified => 'Modificado';
  @override
  String get unchanged => 'Inalterado';
  @override
  String get missing => 'Ausente';
  @override
  String get extra => 'Extra';
  @override
  String get sourceValue => 'Valor de Origem';
  @override
  String get targetValue => 'Valor de Destino';
  @override
  String get key => 'Chave';
  @override
  String get status => 'Status';
  @override
  String get actions => 'Ações';
  @override
  String get copyToTarget => 'Copiar para o Destino';
  @override
  String get acceptChange => 'Aceitar Alteração';
  @override
  String get rejectChange => 'Rejeitar Alteração';
  @override
  String get viewDetails => 'Ver Detalhes';
}

// Path: git
class _TranslationsGitPtBr extends TranslationsGitEn {
  _TranslationsGitPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Comparação Git';
  @override
  String get selectRepository => 'Selecionar Repositório';
  @override
  String get selectBranch => 'Selecionar Branch';
  @override
  String get selectCommit => 'Selecionar Commit';
  @override
  String get compareBranches => 'Comparar Branches';
  @override
  String get compareCommits => 'Comparar Commits';
  @override
  String get baseBranch => 'Branch Base';
  @override
  String get compareBranch => 'Branch de Comparação';
  @override
  String get noRepositories => 'Nenhum repositório Git encontrado';
  @override
  String get noRepositoriesDescription =>
      'Abra uma pasta contendo um repositório Git';
  @override
  String filesChanged({required Object count}) => '${count} arquivos alterados';
  @override
  String additions({required Object count}) => '${count} adições';
  @override
  String deletions({required Object count}) => '${count} exclusões';
  @override
  late final _TranslationsGitConflictsPtBr conflicts =
      _TranslationsGitConflictsPtBr._(_root);
}

// Path: quality
class _TranslationsQualityPtBr extends TranslationsQualityEn {
  _TranslationsQualityPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'Termos de API e métricas (Requests, Tokens, Characters, Prompt, Completion, Export) devem permanecer em Inglês para todas as traduções a fim de manter a consistência com a terminologia da indústria.';
  @override
  String get title => 'Painel de Qualidade';
  @override
  String get overallScore => 'Pontuação Geral';
  @override
  String get issues => 'Problemas';
  @override
  String get warnings => 'Avisos';
  @override
  String get suggestions => 'Sugestões';
  @override
  String get placeholderMismatch => 'Incompatibilidade de Espaço Reservado';
  @override
  String get placeholderMismatchDescription =>
      'Espaços reservados como {name} não coincidem entre origem e destino';
  @override
  String get lengthOutlier => 'Anomalia de Comprimento';
  @override
  String get lengthOutlierDescription =>
      'O comprimento da tradução difere significativamente da origem';
  @override
  String get duplicateValue => 'Valor Duplicado';
  @override
  String get duplicateValueDescription =>
      'A mesma tradução usada para múltiplas chaves';
  @override
  String get missingTranslation => 'Tradução Ausente';
  @override
  String get missingTranslationDescription =>
      'Tradução ausente para esta chave';
  @override
  String get loading => 'Carregando painel...';
  @override
  String get errorLoading =>
      'Não foi possível carregar seu histórico. Tente novamente.';
  @override
  String get emptyState => 'Execute uma comparação para ver seu painel.';
  @override
  String get refresh => 'Atualizar';
  @override
  String get buildingInsights => 'Construindo insights...';
  @override
  String get crunchingNumbers => 'Processando os números...';
  @override
  String get errorBuilding =>
      'Não foi possível construir o painel. Tente novamente.';
  @override
  String get noUsableData => 'Nenhum dado utilizável foi encontrado ainda.';
  @override
  String get languages => 'Idiomas';
  @override
  String get averageCoverage => 'Cobertura média';
  @override
  String get potentialIssues => 'Problemas potenciais';
  @override
  String get translationCoverage => 'Cobertura de tradução';
  @override
  String entriesTranslated(
          {required Object translated, required Object total}) =>
      '${translated} de ${total} entradas traduzidas';
  @override
  String get wordsAddedOverTime => 'Palavras adicionadas ao longo do tempo';
  @override
  String get completionVsScope => 'Conclusão vs Escopo';
  @override
  String get scopeVsProgress => 'Escopo vs Progresso';
  @override
  String get coveragePercent => 'Cobertura %';
  @override
  String get wordsAdded => 'Palavras Adicionadas';
  @override
  String get words => 'Palavras';
  @override
  String get coverage => 'Cobertura';
  @override
  String get scope => 'Escopo';
  @override
  String get latest => 'Mais Recente';
  @override
  String get added => 'Adicionado';
  @override
  String get change => 'Alteração';
  @override
  String get totalScope => 'Escopo Total';
  @override
  String wordsCount({required Object count}) => '${count} palavras';
  @override
  String get scopeGrowth => 'Crescimento do Escopo';
  @override
  String get range => 'Intervalo';
  @override
  String get aiUsage => 'Uso de IA & Tradução';
  @override
  String lastUsed({required Object date}) => 'Usado pela última vez em ${date}';
  @override
  String get noIssuesFound =>
      'Nenhum problema encontrado nas últimas comparações.';
  @override
  String get placeholderMismatches => 'Incompatibilidades de espaço reservado';
  @override
  String get placeholderMismatchesDesc =>
      'Marcadores como {name} não coincidem.';
  @override
  String get lengthOutliers => 'Traduções muito curtas ou longas';
  @override
  String get lengthOutliersDesc =>
      'O comprimento parece incomum em comparação com a origem.';
  @override
  String get duplicateValues => 'Valores duplicados';
  @override
  String get duplicateValuesDesc => 'A mesma tradução é usada muitas vezes.';
  @override
  String get placeholderDialogTitle => 'Incompatibilidades de Espaço Reservado';
  @override
  String get placeholderDialogDesc =>
      'Estas traduções têm espaços reservados ({name}) diferentes da origem.';
  @override
  String get lengthDialogTitle => 'Anomalias de Comprimento';
  @override
  String get lengthDialogDesc =>
      'Estas traduções são significativamente mais curtas ou mais longas que a origem.';
  @override
  String get duplicateDialogTitle => 'Valores Duplicados';
  @override
  String get duplicateDialogDesc => 'Estas traduções aparecem múltiplas vezes.';
  @override
  String duplicateSample({required Object value}) => 'Duplicado: "${value}"';
  @override
  String get exportError =>
      'Não foi possível construir o relatório. Por favor, tente novamente.';
  @override
  String get noDataToExport => 'Nenhum dado para exportar';
  @override
  String get exportFailed => 'Exportação falhou';
  @override
  String get exportDialogTitle => 'Exportar Relatório de Qualidade';
  @override
  String get reportSaved => 'Relatório salvo';
  @override
  String get export => 'Exportar';
  @override
  String get requests => 'Requisições';
  @override
  String get tokens => 'Tokens';
  @override
  String get characters => 'Caracteres';
  @override
  String get estCost => 'Custo Est.';
  @override
  String get prompt => 'Prompt';
  @override
  String get completion => 'Conclusão';
  @override
  String get showingCurrentProject => 'Mostrando: Projeto Atual';
  @override
  String get showingAllHistory => 'Mostrando: Todo o Histórico';
  @override
  String get filesSkipped =>
      'Alguns arquivos foram ignorados porque não foram encontrados.';
}

// Path: errors
class _TranslationsErrorsPtBr extends TranslationsErrorsEn {
  _TranslationsErrorsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get genericError => 'Ocorreu um erro';
  @override
  String get fileNotFound => 'Arquivo não encontrado';
  @override
  String get invalidFormat => 'Formato de arquivo inválido';
  @override
  String get parseError => 'Falha ao analisar o arquivo';
  @override
  String get networkError => 'Erro de rede. Por favor, verifique sua conexão.';
  @override
  String get permissionDenied => 'Permissão negada';
  @override
  String get unknownError => 'Ocorreu um erro desconhecido';
}

// Path: wizards
class _TranslationsWizardsPtBr extends TranslationsWizardsEn {
  _TranslationsWizardsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsWizardsFirstRunPtBr firstRun =
      _TranslationsWizardsFirstRunPtBr._(_root);
}

// Path: dialogs
class _TranslationsDialogsPtBr extends TranslationsDialogsEn {
  _TranslationsDialogsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDialogsAddIgnorePatternPtBr addIgnorePattern =
      _TranslationsDialogsAddIgnorePatternPtBr._(_root);
  @override
  late final _TranslationsDialogsDiffViewerPtBr diffViewer =
      _TranslationsDialogsDiffViewerPtBr._(_root);
}

// Path: grid
class _TranslationsGridPtBr extends TranslationsGridEn {
  _TranslationsGridPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGridColumnsPtBr columns =
      _TranslationsGridColumnsPtBr._(_root);
}

// Path: tutorial
class _TranslationsTutorialPtBr extends TranslationsTutorialEn {
  _TranslationsTutorialPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'PULAR TUTORIAL';
  @override
  String get finishMessage =>
      'Tudo pronto! Toque em qualquer lugar para terminar.';
  @override
  String get next => 'Próximo';
  @override
  String get loadSampleData => 'Carregar Dados de Exemplo';
  @override
  String get browseSourceFile => 'Procurar Arquivo de Origem';
  @override
  String get browseTargetFile => 'Procurar Arquivo de Destino';
  @override
  String get compareFiles => 'Comparar Arquivos';
  @override
  String get hintPhase2 =>
      'Próximo: filtros, pesquisa, visualização avançada e exportação.';
  @override
  late final _TranslationsTutorialStepsPtBr steps =
      _TranslationsTutorialStepsPtBr._(_root);
}

// Path: friendlyErrors
class _TranslationsFriendlyErrorsPtBr extends TranslationsFriendlyErrorsEn {
  _TranslationsFriendlyErrorsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsFriendlyErrorsFileNotFoundPtBr fileNotFound =
      _TranslationsFriendlyErrorsFileNotFoundPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsAccessDeniedPtBr accessDenied =
      _TranslationsFriendlyErrorsAccessDeniedPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsIsDirectoryPtBr isDirectory =
      _TranslationsFriendlyErrorsIsDirectoryPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsFileAccessPtBr fileAccess =
      _TranslationsFriendlyErrorsFileAccessPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsUnsupportedFormatPtBr
      unsupportedFormat =
      _TranslationsFriendlyErrorsUnsupportedFormatPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsNetworkErrorPtBr networkError =
      _TranslationsFriendlyErrorsNetworkErrorPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsNotGitRepoPtBr notGitRepo =
      _TranslationsFriendlyErrorsNotGitRepoPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsMergeConflictPtBr mergeConflict =
      _TranslationsFriendlyErrorsMergeConflictPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitAuthFailedPtBr gitAuthFailed =
      _TranslationsFriendlyErrorsGitAuthFailedPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitOperationFailedPtBr
      gitOperationFailed =
      _TranslationsFriendlyErrorsGitOperationFailedPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidJsonPtBr invalidJson =
      _TranslationsFriendlyErrorsInvalidJsonPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsRateLimitReachedPtBr rateLimitReached =
      _TranslationsFriendlyErrorsRateLimitReachedPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidApiKeyPtBr invalidApiKey =
      _TranslationsFriendlyErrorsInvalidApiKeyPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsTranslationServiceErrorPtBr
      translationServiceError =
      _TranslationsFriendlyErrorsTranslationServiceErrorPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsOutOfMemoryPtBr outOfMemory =
      _TranslationsFriendlyErrorsOutOfMemoryPtBr._(_root);
  @override
  late final _TranslationsFriendlyErrorsGenericErrorPtBr genericError =
      _TranslationsFriendlyErrorsGenericErrorPtBr._(_root);
}

// Path: systemTray
class _TranslationsSystemTrayPtBr extends TranslationsSystemTrayEn {
  _TranslationsSystemTrayPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get showLocalizer => 'Mostrar Localizer';
  @override
  String get exit => 'Sair';
}

// Path: validation
class _TranslationsValidationPtBr extends TranslationsValidationEn {
  _TranslationsValidationPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get connected => 'Conectado.';
  @override
  String get connectionTimeout =>
      'A conexão expirou. Por favor, tente novamente.';
  @override
  String get couldNotConnect =>
      'Não foi possível conectar. Por favor, tente novamente.';
  @override
  String get checkKeyAndTryAgain =>
      'Não foi possível conectar. Por favor, verifique a chave e tente novamente.';
  @override
  String get tryAgainLater =>
      'Não foi possível conectar agora. Por favor, tente novamente mais tarde.';
  @override
  String get serviceUnavailable =>
      'O serviço está indisponível no momento. Por favor, tente novamente mais tarde.';
  @override
  String get enterKeyFirst => 'Por favor, insira uma chave primeiro.';
  @override
  String get checking => 'Verificando...';
  @override
  String deeplUsage({required Object used, required Object limit}) =>
      'Uso: ${used} / ${limit} caracteres.';
}

// Path: status
class _TranslationsStatusPtBr extends TranslationsStatusEn {
  _TranslationsStatusPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get startingComparison => 'Iniciando comparação...';
  @override
  String get loadingFromHistory => 'Carregando arquivos do histórico...';
  @override
  String get comparisonComplete => 'Comparação concluída';
  @override
  String get couldNotImportFiles =>
      'Não foi possível importar os arquivos. Por favor, tente novamente.';
  @override
  String get historyFilesNotFound =>
      'Um ou ambos os arquivos do histórico não foram encontrados nos caminhos originais.';
}

// Path: aiServices
class _TranslationsAiServicesPtBr extends TranslationsAiServicesEn {
  _TranslationsAiServicesPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get geminiEmptyResponse => 'O Gemini retornou uma resposta vazia';
  @override
  String get geminiStreamingEmpty =>
      'O streaming do Gemini retornou uma resposta vazia';
  @override
  String get geminiRephraseEmpty =>
      'O Gemini retornou uma resposta vazia para refraseamento';
  @override
  String get openaiEmptyResponse =>
      'A OpenAI retornou uma resposta vazia ou com falha';
}

// Path: settings.appearance
class _TranslationsSettingsAppearancePtBr
    extends TranslationsSettingsAppearanceEn {
  _TranslationsSettingsAppearancePtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Aparência';
  @override
  String get description => 'Personalize a aparência do aplicativo';
  @override
  String get theme => 'Modo de Tema';
  @override
  String get themeDescription =>
      'Escolha entre os temas claro, escuro ou do sistema';
  @override
  String get themeSystem => 'Sistema';
  @override
  String get themeLight => 'Claro';
  @override
  String get themeDark => 'Escuro';
  @override
  String get themeAmoled => 'AMOLED';
  @override
  String get accentColor => 'Cor de Destaque';
  @override
  String get accentColorDescription => 'Escolha sua cor de destaque preferida';
  @override
  String get useMicaEffect => 'Usar Efeito Mica';
  @override
  String get micaDescription =>
      'Ativar o efeito de transparência Mica do Windows 11 para um visual moderno';
  @override
  String get diffFontSize => 'Tamanho da Fonte de Comparação';
  @override
  String get diffFontSizeDescription =>
      'Ajuste o tamanho da fonte da visualização de comparação';
  @override
  String get diffFontFamily => 'Família da Fonte de Comparação';
  @override
  String get diffFontFamilyDescription =>
      'Fonte para a visualização de comparação';
  @override
  String get systemDefault => 'Padrão do Sistema';
  @override
  String get pickAccentColor => 'Escolher Cor de Destaque';
  @override
  String get diffColors => 'Cores de Comparação';
  @override
  String get presetsTitle => 'Predefinições';
  @override
  late final _TranslationsSettingsAppearancePresetsPtBr presets =
      _TranslationsSettingsAppearancePresetsPtBr._(_root);
  @override
  String get identical => 'Idêntico';
  @override
  String pickColorFor({required Object label}) => 'Escolher Cor para ${label}';
  @override
  String get livePreview => 'Visualização ao Vivo';
  @override
  late final _TranslationsSettingsAppearancePreviewPtBr preview =
      _TranslationsSettingsAppearancePreviewPtBr._(_root);
}

// Path: settings.general
class _TranslationsSettingsGeneralPtBr extends TranslationsSettingsGeneralEn {
  _TranslationsSettingsGeneralPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Geral';
  @override
  String get description => 'Configurações gerais do aplicativo';
  @override
  String get language => 'Idioma';
  @override
  String get languageDescription => 'Escolha seu idioma preferido';
  @override
  String get startMinimized => 'Iniciar Minimizado na Bandeja';
  @override
  String get startMinimizedDescription =>
      'Inicie o aplicativo minimizado na bandeja do sistema';
  @override
  String get rememberWindowPosition => 'Lembrar Posição da Janela';
  @override
  String get rememberWindowPositionDescription =>
      'Restaurar tamanho e posição da janela ao iniciar';
  @override
  String get openLastProject => 'Abrir Último Projeto ao Iniciar';
  @override
  String get openLastProjectDescription =>
      'Abrir automaticamente o último projeto usado quando o app iniciar';
  @override
  String get application => 'Aplicativo';
  @override
  String get defaultView => 'Visualização Padrão';
  @override
  String get defaultViewDescription => 'Visualização a ser exibida ao iniciar';
  @override
  String get autoCheckUpdates => 'Verificar Atualizações Automaticamente';
  @override
  String get autoCheckUpdatesDescription =>
      'Verificar se há atualizações ao iniciar';
  @override
  String get startupOptions => 'Opções de Inicialização';
  @override
  String get languageAuto => 'Detectar Automaticamente';
  @override
  String get viewBasic => 'Comparação de Arquivos';
  @override
  String get viewHistory => 'Histórico';
  @override
  String get viewDashboard => 'Painel de Qualidade';
  @override
  String get viewDirectory => 'Comparação de Diretório';
  @override
  String get viewLastUsed => 'Última Visualização Usada';
}

// Path: settings.scope
class _TranslationsSettingsScopePtBr extends TranslationsSettingsScopeEn {
  _TranslationsSettingsScopePtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Escopo de Configurações';
  @override
  String get global => 'Padrões Globais';
  @override
  String get project => 'Projeto';
  @override
  String get reset => 'Redefinir Projeto para os Padrões Globais';
  @override
  String get resetConfirmation =>
      'Isso limpará todas as sobreposições deste projeto e reverterá para os padrões globais. Esta ação não pode ser desfeita.';
  @override
  String get globalDescription =>
      'As alterações se aplicam a todos os projetos, a menos que sejam substituídas.';
  @override
  String projectDescription({required Object name}) =>
      'As alterações se aplicam apenas a "${name}". Outras configurações herdam dos padrões globais.';
  @override
  String get createPrompt =>
      'Crie un projeto para personalizar as configurações para pastas específicas';
}

// Path: settings.searchKeywords
class _TranslationsSettingsSearchKeywordsPtBr
    extends TranslationsSettingsSearchKeywordsEn {
  _TranslationsSettingsSearchKeywordsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  List<String> get general => [
        'Idioma',
        'Visualização Padrão',
        'Contagem de Arquivos Recentes',
        'Abrir Último Projeto',
        'Confirmar Antes de Sair',
        'Mostrar Notificações',
      ];
  @override
  List<String> get comparisonEngine => [
        'Modo de Comparação',
        'Limiar de Similaridade',
        'Diferenciar Maiúsculas e Minúsculas',
        'Ignorar Espaços em Branco',
        'Ignorar Linhas Vazias',
        'Ignorar Comentários',
        'Ignorar Padrões',
      ];
  @override
  List<String> get appearance => [
        'Tema',
        'Modo de Tema',
        'Cor de Destaque',
        'Tamanho da Fonte de Comparação',
        'Família da Fonte de Comparação',
        'Cores de Comparação',
        'Cor Adicionada',
        'Cor Removida',
        'Cor Modificada',
        'Cor Idêntica',
        'Predefinições de Cores',
        'Visualização',
      ];
  @override
  List<String> get fileHandling => [
        'Formato de Origem',
        'Formato de Destino',
        'Codificação Padrão',
        'Contagem de Projetos Recentes',
        'Memória de Tradução',
        'Importar Memória',
        'Exportar Memória',
        'Limpar Memória',
      ];
  @override
  List<String> get aiServices => [
        'Chave de API da OpenAI',
        'Chave de API da Anthropic',
        'Chave de API da Google AI',
        'Modelo de IA',
        'Temperatura',
        'Prompt Personalizado',
      ];
  @override
  List<String> get systemIntegrations => [
        'Bandeja do Sistema',
        'Iniciar Minimizado',
        'Associações de Arquivos',
        'Efeito Mica',
        'Vibrancy',
        'Material da Janela',
        'Badges no Dock',
        'Contagem de Não Traduzidos',
      ];
  @override
  List<String> get projectResources => [
        'Glossário',
        'Memória de Tradução',
        'Terminologia',
      ];
  @override
  List<String> get about => [
        'Versão',
        'Verificar Atualizações',
        'Atualização Automática',
        'Registro de Alterações',
        'Licença',
        'Política de Privacidade',
        'Telemetria',
        'Relatório de Erros',
      ];
  @override
  List<String> get developer => [
        'Sobreposição de Desempenho',
        'Depurador de Semântica',
        'Grade de Material',
        'Cache de Rasterização',
        'Reiniciar Tutorial',
        'Redefinição de Fábrica',
      ];
}

// Path: settings.comparison
class _TranslationsSettingsComparisonPtBr
    extends TranslationsSettingsComparisonEn {
  _TranslationsSettingsComparisonPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Comparação';
  @override
  String get description => 'Configurar o comportamento de comparação';
  @override
  String get caseSensitive => 'Diferenciar Maiúsculas/Minúsculas';
  @override
  String get caseSensitiveDescription =>
      'Tratar letras maiúsculas e minúsculas como diferentes';
  @override
  String get ignoreWhitespace => 'Ignorar Espaços em Branco';
  @override
  String get ignoreWhitespaceDescription =>
      'Ignorar espaços em branco no início/fim ao comparar';
  @override
  String get showLineNumbers => 'Mostrar Números de Linha';
  @override
  String get showLineNumbersDescription =>
      'Exibir números de linha na visualização de diff';
  @override
  String get behavior => 'Comportamento de Comparação';
  @override
  String get ignoreCase => 'Ignorar Diferença de Maiúsculas/Minúsculas';
  @override
  String get ignoreCaseDescription => 'Tratar "Chave" e "chave" como iguais';
  @override
  String get similarityThreshold => 'Limiar de Similaridade';
  @override
  String get similarityThresholdDescription =>
      'Similaridade mínima para detecção de "Modificado"';
  @override
  String get mode => 'Modo de Comparação';
  @override
  String get modeDescription => 'Como corresponder entradas entre arquivos';
  @override
  String get modeKey => 'Baseado em Chave';
  @override
  String get modeKeyDescription => 'Corresponde pelo nome da chave (padrão).';
  @override
  String get modeOrder => 'Baseado na Ordem';
  @override
  String get modeOrderDescription => 'Corresponde pela posição no arquivo.';
  @override
  String get modeSmart => 'Correspondência Inteligente';
  @override
  String get modeSmartDescription => 'Detecta chaves movidas/renomeadas.';
  @override
  String get ignorePatterns => 'Ignorar Padrões';
  @override
  String get noIgnorePatterns => 'Nenhum padrão de ignorar definido.';
  @override
  String get addPattern => 'Adicionar Padrão';
  @override
  String get resetToGlobal =>
      'Redefinir todas as configurações de comparação para os padrões globais';
  @override
  late final _TranslationsSettingsComparisonPatternPresetsPtBr patternPresets =
      _TranslationsSettingsComparisonPatternPresetsPtBr._(_root);
  @override
  late final _TranslationsSettingsComparisonPreviewMatchPtBr previewMatch =
      _TranslationsSettingsComparisonPreviewMatchPtBr._(_root);
  @override
  late final _TranslationsSettingsComparisonColorPresetsPtBr colorPresets =
      _TranslationsSettingsComparisonColorPresetsPtBr._(_root);
}

// Path: settings.fileHandling
class _TranslationsSettingsFileHandlingPtBr
    extends TranslationsSettingsFileHandlingEn {
  _TranslationsSettingsFileHandlingPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get fileFormats => 'Formatos de Arquivo';
  @override
  String get sourceFormat => 'Formato de Origem';
  @override
  String get targetFormat => 'Formato de Destino';
  @override
  String get encoding => 'Codificação';
  @override
  String get sourceEncoding => 'Codificação de Origem';
  @override
  String get targetEncoding => 'Codificação de Destino';
  @override
  String get autoDetect => 'Detectar Automaticamente';
  @override
  String get autoDetectEncodingDescription =>
      'Detectar automaticamente a codificação do arquivo';
  @override
  String get exportSettings => 'Configurações de Exportação';
  @override
  String get defaultExportFormat => 'Formato de Exportação Padrão';
  @override
  String get includeUtf8Bom => 'Incluir UTF-8 BOM';
  @override
  String get includeUtf8BomDescription =>
      'Necessário para compatibilidade com Excel';
  @override
  String get openFolderAfterExport => 'Abrir Pasta após Exportar';
  @override
  String get fileSafety => 'Segurança de Arquivo';
  @override
  String get fileSafetyDescription =>
      'Cópias locais automáticas para recuperação de desastres.';
  @override
  String get resetToGlobal =>
      'Redefinir todas as configurações de manipulação de arquivo para os padrões globais';
}

// Path: settings.translationMemory
class _TranslationsSettingsTranslationMemoryPtBr
    extends TranslationsSettingsTranslationMemoryEn {
  _TranslationsSettingsTranslationMemoryPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Memória de Tradução Global';
  @override
  String get autoLearn => 'Aprender Automaticamente';
  @override
  String get autoLearnDescription =>
      'Salvar traduções na memória local para reutilização futura';
  @override
  String get confidenceThreshold => 'Limiar de Confiança';
  @override
  String confidenceThresholdDescription({required Object percent}) =>
      'Pontuação mínima para aplicação automática (${percent}%)';
  @override
  String get entries => 'Entradas';
  @override
  String get size => 'Tamanho';
  @override
  String memorySize({required Object size}) => 'Tamanho da Memória: ${size}';
  @override
  String get import => 'Importar';
  @override
  String get exportTmx => 'Exportar TMX';
  @override
  String get exportCsv => 'Exportar CSV';
  @override
  String get clearMemory => 'Limpar Memória';
  @override
  String importedItems({required Object count}) =>
      '${count} itens importados para a memória.';
  @override
  String get noItemsAdded => 'Nenhum item foi adicionado.';
  @override
  String get nothingToExport => 'Nada para exportar ainda.';
  @override
  String get tmxSaved => 'TMX salvo';
  @override
  String get csvSaved => 'CSV salvo';
  @override
  String get clearConfirmTitle => 'Limpar memória de tradução?';
  @override
  String get clearConfirmContent =>
      'Isso remove todos os pares de tradução salvos neste dispositivo. Esta ação não pode ser desfeita.';
  @override
  String get cleared => 'Memória de tradução limpa.';
  @override
  String get couldNotClear => 'Não foi possível limpar a memória.';
}

// Path: settings.backup
class _TranslationsSettingsBackupPtBr extends TranslationsSettingsBackupEn {
  _TranslationsSettingsBackupPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Backup Automático';
  @override
  String get description => 'Configurações de backup automático';
  @override
  String get enabled => 'Ativar Backup Automático';
  @override
  String get enabledDescription =>
      'Fazer backup automático dos arquivos antes de realizar alterações';
  @override
  String get maxCopies => 'Máximo de Cópias de Backup';
  @override
  String get maxCopiesDescription =>
      'Número de cópias de backup a serem mantidas por arquivo';
  @override
  String activeStatus({required Object count}) =>
      'Ativo · Mantendo ${count} cópias';
  @override
  String get folder => 'Pasta de Backup';
  @override
  String get folderDescription => 'Deixe em branco para usar a mesma pasta';
  @override
  String get useOriginalFolder => 'Usar pasta original do arquivo';
}

// Path: settings.ai
class _TranslationsSettingsAiPtBr extends TranslationsSettingsAiEn {
  _TranslationsSettingsAiPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Serviços de IA';
  @override
  String get description => 'Configurar tradução e assistência por IA';
  @override
  String get provider => 'Provedor de IA';
  @override
  String get providerDescription =>
      'Escolha seu provedor de serviços de IA preferido';
  @override
  String get apiKey => 'Chave de API';
  @override
  String get apiKeyDescription =>
      'Insira sua chave de API para o provedor selecionado';
  @override
  String get apiKeyPlaceholder => 'Insira a chave de API...';
  @override
  String get testConnection => 'Testar Conexão';
  @override
  String get connectionSuccess => 'Conexão bem-sucedida!';
  @override
  String get connectionFailed =>
      'Falha na conexão. Por favor, verifique sua chave de API.';
  @override
  String get translationStrategy => 'Estratégia de Tradução';
  @override
  String get strategy => 'Estratégia';
  @override
  String get strategyDescription =>
      'Selecione como você deseja traduzir as strings';
  @override
  String get strategyLLM => 'IA Generativa (LLM)';
  @override
  String get strategyCloud => 'Tradução na Nuvem';
  @override
  String get enableAiTranslation => 'Ativar Tradução por IA';
  @override
  String get enableAiTranslationDescription =>
      'Permitir que o aplicativo use IA para sugestões de tradução';
  @override
  String get llmProvider => 'Provedor de Serviço LLM';
  @override
  String get service => 'Serviço';
  @override
  String get serviceDescription => 'Provedor para IA Generativa';
  @override
  String get providerGemini => 'Google Gemini';
  @override
  String get providerOpenAI => 'OpenAI';
  @override
  String get geminiApiKey => 'Chave de API do Gemini';
  @override
  String get openAiApiKey => 'Chave de API da OpenAI';
  @override
  String get model => 'Modelo';
  @override
  String get modelDescription => 'Selecione qual modelo usar';
  @override
  String get advancedParameters => 'Parâmetros Avançados';
  @override
  String get parameters => 'Parâmetros';
  @override
  String get parametersDescription => 'Temperatura, Contexto e mais';
  @override
  String get temperature => 'Temperatura';
  @override
  String get temperatureDescription =>
      'Valores mais altos tornam o resultado mais criativo';
  @override
  String get maxTokens => 'Máximo de Tokens';
  @override
  String get maxTokensDescription => 'Limitar o tamanho da janela de contexto';
  @override
  String get systemContext => 'Contexto do Sistema / Instruções';
  @override
  String get systemContextHint =>
      'Você é um profissional de localização. Mantenha o tom e a intenção da string de origem...';
  @override
  String get systemContextHelper =>
      'Forneça instruções específicas para a IA sobre o estilo e a terminologia do seu projeto.';
  @override
  String get contextStrings => 'Strings de Contexto';
  @override
  String get contextStringsDescription =>
      'Incluir strings circundantes para melhor contexto';
  @override
  String get contextCount => 'Contagem de Contexto';
  @override
  String get contextCountDescription =>
      'Número de strings circundantes a serem incluídas';
  @override
  String get cloudServices => 'Serviços de Tradução na Nuvem';
  @override
  String get googleTranslateApiKey => 'Chave de API do Google Translate';
  @override
  String get deeplApiKey => 'Chave de API do DeepL';
  @override
  String get test => 'Testar';
  @override
  String get resetToGlobal =>
      'Redefinir todas as configurações de IA para os padrões globais';
}

// Path: settings.integrations
class _TranslationsSettingsIntegrationsPtBr
    extends TranslationsSettingsIntegrationsEn {
  _TranslationsSettingsIntegrationsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get platformNotice => 'Aviso de Plataforma';
  @override
  String get platformNoticeDescription =>
      'Integrações de sistema não estão disponíveis para esta plataforma.';
  @override
  String get visualEffects => 'Efeitos Visuais';
  @override
  String get explorerIntegration => 'Integração com Explorer';
  @override
  String get explorerIntegrationDescription =>
      'Adicionar "Abrir com Localizer" ao menu de contexto do Windows Explorer para pastas.';
  @override
  String get addToContextMenu => 'Adicionar ao Menu de Contexto';
  @override
  String get contextMenuAdded => 'Menu de contexto adicionado!';
  @override
  String get contextMenuAddError => 'Falha ao adicionar menu de contexto';
  @override
  String get contextMenuRemoved => 'Menu de contexto removido!';
  @override
  String get contextMenuRemoveError => 'Falha ao remover menu de contexto';
  @override
  String get fileAssociations => 'Associações de Arquivos';
  @override
  String get fileAssociationsDescription =>
      'Registrar tipos de arquivos para abrir com o Localizer ao clicar duas vezes no Explorer.';
  @override
  String get registered => 'Registrado';
  @override
  String get notRegistered => 'Não Registrado';
  @override
  String extRegistered({required Object ext}) => '${ext} registrado!';
  @override
  String extUnregistered({required Object ext}) => '${ext} desregistrado!';
  @override
  String extError({required Object action, required Object ext}) =>
      'Falha ao ${action} ${ext}';
  @override
  String get registerAll => 'Registrar Tudo';
  @override
  String get unregisterAll => 'Desregistrar Tudo';
  @override
  String registerAllResult({required Object success, required Object total}) =>
      'Registrados ${success} de ${total} tipos de arquivos';
  @override
  String unregisterAllResult(
          {required Object success, required Object total}) =>
      'Desregistrados ${success} de ${total} tipos de arquivos';
  @override
  String get protocolHandler => 'Manipulador de Protocolo';
  @override
  String get protocolHandlerDescription =>
      'Registrar URLs localizer:// para abrir este aplicativo. Permite abrir projetos diretamente de links do navegador ou outros apps.';
  @override
  String get protocolRegistered => 'O manipulador de protocolo está registrado';
  @override
  String get protocolNotRegistered =>
      'O manipulador de protocolo não está registrado';
  @override
  String get registerProtocol => 'Registrar Protocolo';
  @override
  String get unregister => 'Desregistrar';
  @override
  String get protocolRegisteredSuccess =>
      'Manipulador de protocolo registrado!';
  @override
  String get protocolRemovedSuccess => 'Manipulador de protocolo removido!';
  @override
  String get protocolRegisterError => 'Falha ao registrar';
  @override
  String get protocolRemoveError => 'Falha ao remover';
  @override
  String get windowMaterial => 'Material da Janela';
  @override
  String get windowMaterialDescription =>
      'Selecione o estilo de material vibrante do macOS';
  @override
  String get dockIntegration => 'Integração com o Dock';
  @override
  String get showDockBadge => 'Mostrar Contagem de Não Traduzidos';
  @override
  String get showDockBadgeDescription =>
      'Exibir contagem de strings não traduzidas no badge do ícone do dock';
  @override
  late final _TranslationsSettingsIntegrationsMaterialsPtBr materials =
      _TranslationsSettingsIntegrationsMaterialsPtBr._(_root);
  @override
  late final _TranslationsSettingsIntegrationsFileTypesPtBr fileTypes =
      _TranslationsSettingsIntegrationsFileTypesPtBr._(_root);
}

// Path: settings.developer
class _TranslationsSettingsDeveloperPtBr
    extends TranslationsSettingsDeveloperEn {
  _TranslationsSettingsDeveloperPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Configurações de Desenvolvedor';
  @override
  String get description => 'Configurações avançadas para desenvolvedores';
  @override
  String get showLocalizationKeys => 'Mostrar Chaves de Localização';
  @override
  String get localizationKeysDescription =>
      'Quando ativado, todo o texto traduzido exibirá suas chaves de localização em vez do valor traduzido. Útil para verificar qual chave é usada onde.';
  @override
  String get showPerformanceOverlay => 'Mostrar Camada de Desempenho';
  @override
  String get performanceOverlayDescription =>
      'Exibir informações de FPS e tempo de quadro';
  @override
  String get debugMode => 'Modo de Depuração';
  @override
  String get debugModeDescription =>
      'Ativar registros adicionais e recursos de depuração';
  @override
  String get debuggingTools => 'Ferramentas de Depuração';
  @override
  String get semanticsDebugger => 'Depurador de Semântica';
  @override
  String get semanticsDebuggerDescription => 'Visualizar árvore de semântica';
  @override
  String get materialGrid => 'Grade de Material';
  @override
  String get materialGridDescription => 'Sobrepor grade de layout de material';
  @override
  String get rasterCache => 'Imagens de Cache de Rasterização';
  @override
  String get rasterCacheDescription =>
      'Verificar imagens de cache de rasterização';
  @override
  String get actions => 'Ações';
  @override
  String get showLogs => 'Mostrar Logs do App';
  @override
  String get showLogsDescription => 'Abrir o console de depuração Talker';
  @override
  String get restartTutorial => 'Reiniciar Tutorial de Onboarding';
  @override
  String get restartTutorialDescription =>
      'Redefinir flags e iniciar tutorial novamente';
  @override
  String get restartRequested => 'Reinicialização do tutorial solicitada.';
  @override
  String get throwException => 'Lançar Exceção de Teste';
  @override
  String get throwExceptionDescription =>
      'Acionar uma exceção de teste para relatório de falhas';
  @override
  String get testExceptionMessage =>
      'Exceção de teste acionada a partir das Opções de Desenvolvedor';
  @override
  String get clearTM => 'Limpar Memória de Tradução';
  @override
  String get clearTMDescription => 'Excluir todas as traduções em cache';
  @override
  String get clearTMConfirmation => 'Limpar Memória de Tradução?';
  @override
  String get clearTMWarning =>
      'Isso excluirá todas as traduções aprendidas. Esta ação não pode ser desfeita.';
  @override
  String get tmCleared => 'Memória de tradução limpa';
  @override
  String get clearApiKeys => 'Limpar Chaves de API';
  @override
  String get clearApiKeysDescription =>
      'Remover todas as chaves de API armazenadas';
  @override
  String get clearApiKeysConfirmation => 'Limpar Chaves de API?';
  @override
  String get clearApiKeysWarning =>
      'Isso removerá todas as chaves de API do armazenamento seguro.';
  @override
  String get apiKeysCleared => 'Chaves de API limpas';
  @override
  String get hideOptions => 'Ocultar Opções de Desenvolvedor';
  @override
  String get hideOptionsDescription =>
      'Desativar modo de desenvolvedor (requer 7 toques para reativar)';
  @override
  String get optionsDisabled => 'Opções de desenvolvedor desativadas';
  @override
  String get dangerZone => 'Zona de Perigo';
  @override
  String get factoryReset => 'Redefinição de Fábrica';
  @override
  String get factoryResetDescription =>
      'Redefinir todas as configurações e limpar dados';
  @override
  String get factoryResetWarning =>
      'Tem certeza de que deseja redefinir todas as configurações? Esta ação não pode ser desfeita.';
  @override
  String get inspectionTools => 'Ferramentas de Inspeção';
  @override
  String get searchHint => 'Pesquisar configurações...';
  @override
  String get resetToDefault => 'Redefinir para os padrões';
  @override
  String get resetToGlobal => 'Redefinir para o padrão global';
  @override
  String get storageInspector => 'Inspetor de Armazenamento';
  @override
  String get storageInspectorDescription =>
      'Ver conteúdos do Hive & Secure Storage';
  @override
  String get deviceEnvironment => 'Dispositivo & Ambiente';
  @override
  String get deviceEnvironmentDescription =>
      'Tela, plataforma e informações de build';
  @override
  String get themePlayground => 'Playground de Tema';
  @override
  String get themePlaygroundDescription => 'Paleta de cores & tipografia';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionPtBr
      themePlaygroundSection =
      _TranslationsSettingsDeveloperThemePlaygroundSectionPtBr._(_root);
  @override
  String get localizationInspector => 'Inspetor de Localização';
  @override
  String get localizationInspectorDescription => 'Depurar strings de tradução';
  @override
  String get hiveAppSettings => 'Hive (AppSettings)';
  @override
  String get secureStorageMasked => 'Secure Storage (Mascarado)';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsPtBr featureFlags =
      _TranslationsSettingsDeveloperFeatureFlagsPtBr._(_root);
  @override
  late final _TranslationsSettingsDeveloperStorageInspectorSectionPtBr
      storageInspectorSection =
      _TranslationsSettingsDeveloperStorageInspectorSectionPtBr._(_root);
  @override
  late final _TranslationsSettingsDeveloperDeviceInfoSectionPtBr
      deviceInfoSection =
      _TranslationsSettingsDeveloperDeviceInfoSectionPtBr._(_root);
  @override
  late final _TranslationsSettingsDeveloperLocalizationInspectorSectionPtBr
      localizationInspectorSection =
      _TranslationsSettingsDeveloperLocalizationInspectorSectionPtBr._(_root);
}

// Path: settings.about
class _TranslationsSettingsAboutPtBr extends TranslationsSettingsAboutEn {
  _TranslationsSettingsAboutPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Sobre';
  @override
  String get version => 'Versão';
  @override
  String get buildNumber => 'Número da Build';
  @override
  String get author => 'Autor';
  @override
  String get license => 'Licença';
  @override
  String get sourceCode => 'Código Fonte';
  @override
  String get reportBug => 'Relatar um Erro';
  @override
  String get requestFeature => 'Solicitar um Recurso';
  @override
  String get checkForUpdates => 'Verificar Atualizações';
  @override
  String get upToDate => 'Você está atualizado!';
  @override
  String updateAvailable({required Object version}) =>
      'Atualização disponível: ${version}';
  @override
  String get updateAvailableBadge => 'Atualização Disponível!';
  @override
  String developerSteps({required Object count}) =>
      'Você está a ${count} passos de ser um desenvolvedor.';
  @override
  String get developerActivated => 'Você agora é um desenvolvedor!';
  @override
  String get neverChecked => 'Nunca';
  @override
  String get applicationInfo => 'Informações do Aplicativo';
  @override
  String get platform => 'Plataforma';
  @override
  String get updateInformation => 'Informações de Atualização';
  @override
  String get currentVersion => 'Versão Atual';
  @override
  String get latestVersion => 'Última Versão';
  @override
  String get lastChecked => 'Última Verificação';
  @override
  String get checkingForUpdates => 'Verificando...';
  @override
  String get whatsNew => 'O que há de novo';
  @override
  String get systemInformation => 'Informações do Sistema';
  @override
  String get dartVersion => 'Versão do Dart';
  @override
  String get diskSpace => 'Espaço em Disco Disponível';
  @override
  String get memoryUsage => 'Uso de Memória';
  @override
  String get privacyTitle => 'Privacidade & Telemetria';
  @override
  String get usageStats => 'Estatísticas de Uso Anônimas';
  @override
  String get requiresFirebase => 'Requer configuração do Firebase';
  @override
  String get featureUnavailable =>
      'Recurso atualmente indisponível (Requer Firebase)';
  @override
  String get settingsManagement => 'Gerenciamento de Configurações';
  @override
  String get settingsManagementDescription =>
      'Exporte suas configurações para um arquivo para fazer backup ou compartilhar com outras máquinas.';
  @override
  String get resetAll => 'Redefinir Tudo';
  @override
  String get links => 'Links';
  @override
  String get githubRepo => 'Repositório GitHub';
  @override
  String get privacyPolicy => 'Política de Privacidade';
  @override
  String get crashReporting => 'Relatório de Falhas';
}

// Path: settings.onboarding
class _TranslationsSettingsOnboardingPtBr
    extends TranslationsSettingsOnboardingEn {
  _TranslationsSettingsOnboardingPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'Pular Tutorial';
  @override
  String get gettingStarted => 'Primeiros Passos';
  @override
  String stepProgress({required Object current, required Object total}) =>
      '${current} de ${total}';
  @override
  String get loadSampleData => 'Carregar Dados de Exemplo';
  @override
  late final _TranslationsSettingsOnboardingStepsPtBr steps =
      _TranslationsSettingsOnboardingStepsPtBr._(_root);
}

// Path: settings.settingsView
class _TranslationsSettingsSettingsViewPtBr
    extends TranslationsSettingsSettingsViewEn {
  _TranslationsSettingsSettingsViewPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String resetCategoryTitle({required Object category}) =>
      'Redefinir ${category}?';
  @override
  String get resetCategoryContent =>
      'Isto redefinirá todas as configurações nesta categoria para seus valores padrão.';
  @override
  String get resetAllTitle => 'Redefinir Todas as Configurações?';
  @override
  String get resetAllContent =>
      'Isto redefinirá permanentemente todas as configurações para seus padrões de fábrica. Esta ação não pode ser desfeita.';
  @override
  String get resetAll => 'Redefinir Tudo';
  @override
  String resetSuccess({required Object category}) =>
      '${category} redefinido para os padrões';
  @override
  String get errorLoading => 'Erro ao carregar configurações';
  @override
  String get settingsSaved => 'Configurações salvas';
  @override
  String updateAvailable({required Object version}) =>
      'Atualização disponível: v${version}';
  @override
  String get latestVersion => 'Você está usando a última versão';
  @override
  String whatsNew({required Object version}) =>
      'O que há de novo na v${version}';
  @override
  String get downloadUpdate => 'Baixar Atualização';
  @override
  String get exportSettings => 'Exportar Configurações';
  @override
  String get settingsExported => 'Configurações exportadas';
  @override
  String exportFail({required Object error}) =>
      'Falha ao exportar configurações: ${error}';
  @override
  String get importSettings => 'Importar Configurações';
  @override
  String get importTitle => 'Importar Configurações?';
  @override
  String get importContent =>
      'Isto substituirá todas as suas configurações atuais pelas importadas. Esta ação não pode ser desfeita.';
  @override
  String get importSuccess => 'Configurações importadas com sucesso!';
  @override
  String importFail({required Object error}) =>
      'Falha ao importar configurações: ${error}';
  @override
  String get invalidFormat => 'Formato de arquivo de configurações inválido';
  @override
  late final _TranslationsSettingsSettingsViewCategoriesPtBr categories =
      _TranslationsSettingsSettingsViewCategoriesPtBr._(_root);
  @override
  late final _TranslationsSettingsSettingsViewCategoryLabelsPtBr
      categoryLabels =
      _TranslationsSettingsSettingsViewCategoryLabelsPtBr._(_root);
}

// Path: advancedDiff.aiSuggestion
class _TranslationsAdvancedDiffAiSuggestionPtBr
    extends TranslationsAdvancedDiffAiSuggestionEn {
  _TranslationsAdvancedDiffAiSuggestionPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get aiTranslation => 'Tradução por IA';
  @override
  String get aiRephrase => 'Refrasear por IA';
  @override
  String key({required Object key}) => 'Chave: ${key}';
  @override
  String get original => 'Original:';
  @override
  String get suggestion => 'Sugestão:';
  @override
  String get confidence => 'Confiança da IA';
  @override
  String get cancelEdit => 'Cancelar edição';
  @override
  String get editSuggestion => 'Editar sugestão';
  @override
  String get alternatives => 'Alternativas:';
  @override
  String get accept => 'Aceitar';
  @override
  String get reject => 'Rejeitar';
  @override
  String get stop => 'Parar';
}

// Path: advancedDiff.detailEdit
class _TranslationsAdvancedDiffDetailEditPtBr
    extends TranslationsAdvancedDiffDetailEditEn {
  _TranslationsAdvancedDiffDetailEditPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object key}) => 'Editar: ${key}';
  @override
  String get sourceLabel => 'ORIGEM (Original)';
  @override
  String get targetLabel => 'DESTINO (Tradução)';
  @override
  String get translateWithCloud => 'Traduzir com Nuvem';
  @override
  String get translateWithAi => 'Traduzir com IA';
  @override
  String get translating => 'Traduzindo...';
  @override
  String get applyAndTm => 'Aplicar';
  @override
  String get entryApplied => 'Entrada aplicada & adicionada à TM';
  @override
  String get translationAdded => 'Sugestão de tradução adicionada.';
  @override
  String get aiSuggestionAdded => 'Sugestão de IA adicionada.';
}

// Path: advancedDiff.table
class _TranslationsAdvancedDiffTablePtBr
    extends TranslationsAdvancedDiffTableEn {
  _TranslationsAdvancedDiffTablePtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get addedToTM => 'Adicionado à Memória de Tradução';
  @override
  String get markedReviewed => 'Marcado como revisado ✓';
  @override
  String get unmarkedReview => 'Revisão desmarcada';
  @override
  String get reverted => 'Revertido para o valor de origem';
  @override
  String get entryDeleted => 'Entrada excluída';
  @override
  String get noSourceText => 'Nenhum texto de origem para traduzir.';
  @override
  String aiTranslationFailed({required Object key}) =>
      'Tradução por IA falhou para "${key}"';
  @override
  String get noTargetText => 'Nenhum texto de destino para refrasear.';
  @override
  String aiRephraseFailed({required Object key}) =>
      'Refraseamento por IA falhou para "${key}"';
  @override
  String get checkRowsFirst =>
      'Marque as linhas usando as caixas de seleção primeiro';
  @override
  String markedRowsReviewed({required Object count}) =>
      'Marcadas ${count} linhas como revisadas';
  @override
  String revertedRows({required Object count}) => 'Revertidas ${count} linhas';
  @override
  String entriesCount({required Object count}) => '${count} entradas';
  @override
  String get markSelectedReviewed => 'Marcar Selecionadas como Revisadas';
  @override
  String get revertSelected => 'Reverter Selecionadas';
  @override
  String get noDifferences => 'Nenhuma diferença encontrada';
  @override
  String get adjustFilters => 'Tente ajustar seus filtros';
  @override
  String get cloudTranslationApplied => 'Tradução na nuvem aplicada.';
  @override
  String get aiTranslationApplied => 'Tradução por IA aplicada.';
  @override
  String get suggestionApplied => 'Sugestão aplicada.';
  @override
  String get aiSuggestionApplied => 'Sugestão de IA aplicada.';
  @override
  String get rephraseApplied => 'Refraseamento aplicado.';
  @override
  String get aiRephraseApplied => 'Refraseamento por IA aplicado.';
  @override
  String get rephrase => 'Refrasear';
  @override
  String get aiRephrase => 'Refrasear por IA';
  @override
  String get targetClickToEdit => 'DESTINO (Clique para editar)';
  @override
  String get targetClickForDialog => 'DESTINO (Clique para diálogo)';
  @override
  String get emptyClickToEdit => '(Vazio - Clique para editar)';
  @override
  String get unmarkReviewed => 'Desmarcar revisado';
  @override
  String get markReviewed => 'Marcar como revisado';
  @override
  String get revertToSource => 'Reverter para origem';
  @override
  String get translateWithCloud => 'Traduzir com Nuvem';
  @override
  String get translateWithAi => 'Traduzir com IA';
  @override
  String get rephraseWithAi => 'Refrasear com IA';
  @override
  String get moreActions => 'Mais ações';
  @override
  String get editDetails => 'Editar detalhes';
  @override
  String get suggestTranslation => 'Sugerir tradução';
  @override
  String get addToTm => 'Adicionar à TM';
  @override
  String get deleteEntry => 'Excluir entrada';
}

// Path: advancedDiff.diffRow
class _TranslationsAdvancedDiffDiffRowPtBr
    extends TranslationsAdvancedDiffDiffRowEn {
  _TranslationsAdvancedDiffDiffRowPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get copySource => 'Copiar texto de origem';
  @override
  String get actions => 'Ações';
}

// Path: advancedDiff.status
class _TranslationsAdvancedDiffStatusPtBr
    extends TranslationsAdvancedDiffStatusEn {
  _TranslationsAdvancedDiffStatusPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'ADICIONADO';
  @override
  String get missing => 'AUSENTE';
  @override
  String changed({required Object percent}) => 'ALT ${percent}%';
  @override
  String get same => 'IGUAL';
}

// Path: advancedDiff.sidebar
class _TranslationsAdvancedDiffSidebarPtBr
    extends TranslationsAdvancedDiffSidebarEn {
  _TranslationsAdvancedDiffSidebarPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get widgets => 'Widgets';
  @override
  String get searchPlaceholder => 'Pesquisar chaves & valores... (Ctrl+F)';
  @override
  String get fuzzySearchTooltip => 'Pesquisa Difusa (tolerante a erros)';
  @override
  String get regexSearchTooltip => 'Pesquisa Regex';
  @override
  String get cloudTranslation => 'Tradução na Nuvem';
  @override
  String get aiTranslation => 'Tradução por IA';
  @override
  String get status => 'Status';
  @override
  String get tm => 'Memória de Tradução';
  @override
  String get filters => 'Filtros';
  @override
  String get actions => 'Ações';
  @override
  String get similarity => 'Similaridade';
  @override
  late final _TranslationsAdvancedDiffSidebarActionsSectionPtBr actionsSection =
      _TranslationsAdvancedDiffSidebarActionsSectionPtBr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarAiSectionPtBr aiSection =
      _TranslationsAdvancedDiffSidebarAiSectionPtBr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarTmSectionPtBr tmSection =
      _TranslationsAdvancedDiffSidebarTmSectionPtBr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarFiltersSectionPtBr filtersSection =
      _TranslationsAdvancedDiffSidebarFiltersSectionPtBr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarSimilaritySectionPtBr
      similaritySection =
      _TranslationsAdvancedDiffSidebarSimilaritySectionPtBr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarStatusSectionPtBr statusSection =
      _TranslationsAdvancedDiffSidebarStatusSectionPtBr._(_root);
}

// Path: issueDetails.duplicateValue
class _TranslationsIssueDetailsDuplicateValuePtBr
    extends TranslationsIssueDetailsDuplicateValueEn {
  _TranslationsIssueDetailsDuplicateValuePtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'TRADUÇÃO REPETIDA';
  @override
  String get warning =>
      'Diferentes textos de origem usam esta mesma tradução. Verifique o contexto.';
  @override
  String affectedKeys({required Object count}) => 'CHAVES AFETADAS (${count})';
  @override
  String get identicalSources => 'Origens Idênticas';
  @override
  String moreKeys({required Object count}) => '+${count} mais chaves';
}

// Path: issueDetails.lengthOutlier
class _TranslationsIssueDetailsLengthOutlierPtBr
    extends TranslationsIssueDetailsLengthOutlierEn {
  _TranslationsIssueDetailsLengthOutlierPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get source => 'ORIGEM';
  @override
  String get translation => 'TRADUÇÃO';
  @override
  String chars({required Object count}) => '${count} chars';
}

// Path: issueDetails.standard
class _TranslationsIssueDetailsStandardPtBr
    extends TranslationsIssueDetailsStandardEn {
  _TranslationsIssueDetailsStandardPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'CHAVE';
  @override
  String get sourceText => 'TEXTO DE ORIGEM';
  @override
  String get translation => 'TRADUÇÃO';
  @override
  String get errorDetails => 'DETALHES DO ERRO';
  @override
  String get note => 'NOTA';
}

// Path: issueDetails.types
class _TranslationsIssueDetailsTypesPtBr
    extends TranslationsIssueDetailsTypesEn {
  _TranslationsIssueDetailsTypesPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get duplicateValue => 'Valores Duplicados';
  @override
  String get lengthOutlier => 'Incompatibilidade de Comprimento';
  @override
  String get placeholderMismatch => 'Espaços Reservados Quebrados';
}

// Path: issueDetails.notes
class _TranslationsIssueDetailsNotesPtBr
    extends TranslationsIssueDetailsNotesEn {
  _TranslationsIssueDetailsNotesPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get placeholderMismatch =>
      'Marcadores como {name} devem corresponder à origem.';
  @override
  String get lengthOutlier =>
      'Grandes alterações de comprimento podem afetar como o texto se ajusta na tela.';
  @override
  String get duplicateValue =>
      'A mesma tradução é usada para chaves diferentes.';
}

// Path: issueDetails.fallbacks
class _TranslationsIssueDetailsFallbacksPtBr
    extends TranslationsIssueDetailsFallbacksEn {
  _TranslationsIssueDetailsFallbacksPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get multipleSources => 'Múltiplos textos de origem';
  @override
  String get sourceNotAvailable => 'Texto de origem não disponível';
  @override
  String get sharedTranslationNotAvailable =>
      'Tradução compartilhada não disponível';
  @override
  String get translationNotAvailable => 'Tradução não disponível';
}

// Path: compare.tabs
class _TranslationsCompareTabsPtBr extends TranslationsCompareTabsEn {
  _TranslationsCompareTabsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get files => 'Arquivos';
  @override
  String get directories => 'Diretórios';
  @override
  String get git => 'Git';
}

// Path: compare.fileTypes
class _TranslationsCompareFileTypesPtBr extends TranslationsCompareFileTypesEn {
  _TranslationsCompareFileTypesPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get json => 'Arquivos de localização JSON (i18next, Flutter, etc.)';
  @override
  String get yaml => 'Arquivos de localização YAML (Rails, Flutter)';
  @override
  String get xml => 'Arquivos de localização XML (Android, .NET)';
  @override
  String get properties => 'Arquivos Properties (Java)';
  @override
  String get resx => 'Arquivos RESX (.NET)';
  @override
  String get xliff => 'Arquivos XLIFF';
}

// Path: history.timeAgo
class _TranslationsHistoryTimeAgoPtBr extends TranslationsHistoryTimeAgoEn {
  _TranslationsHistoryTimeAgoPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get justNow => 'agora mesmo';
  @override
  String secondsAgo({required Object count}) => 'há ${count} segundos';
  @override
  String get oneMinuteAgo => 'há 1 minuto';
  @override
  String minutesAgo({required Object count}) => 'há ${count} minutos';
  @override
  String get oneHourAgo => 'há 1 hora';
  @override
  String hoursAgo({required Object count}) => 'há ${count} horas';
  @override
  String get yesterday => 'ontem';
  @override
  String daysAgo({required Object count}) => 'há ${count} dias';
  @override
  String get oneWeekAgo => 'há 1 semana';
  @override
  String weeksAgo({required Object count}) => 'há ${count} semanas';
  @override
  String get oneMonthAgo => 'há 1 mês';
  @override
  String monthsAgo({required Object count}) => 'há ${count} meses';
  @override
  String get oneYearAgo => 'há 1 ano';
  @override
  String yearsAgo({required Object count}) => 'há ${count} anos';
  @override
  String get inTheFuture => 'no futuro';
}

// Path: projects.stats
class _TranslationsProjectsStatsPtBr extends TranslationsProjectsStatsEn {
  _TranslationsProjectsStatsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get empty => 'Projeto vazio';
  @override
  String files({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(
        n,
        one: '1 arquivo de tradução',
        other: '${count} arquivos de tradução',
      );
  @override
  String languages({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(
        n,
        one: '1 idioma',
        other: '${count} idiomas',
      );
}

// Path: projects.selection
class _TranslationsProjectsSelectionPtBr
    extends TranslationsProjectsSelectionEn {
  _TranslationsProjectsSelectionPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get selectFolder => 'Selecionar Pasta do Projeto';
  @override
  String get selectArchive => 'Selecionar Arquivo do Projeto';
  @override
  String get openProject => 'Abrir Projeto';
  @override
  String get browseFolder => 'Procurar Pasta...';
  @override
  String get createNew => 'Criar Novo';
  @override
  String get importFromZip => 'Importar de Zip...';
}

// Path: projects.createDialog
class _TranslationsProjectsCreateDialogPtBr
    extends TranslationsProjectsCreateDialogEn {
  _TranslationsProjectsCreateDialogPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Criar Projeto';
  @override
  String get description =>
      'Um projeto permite que você salve configurações personalizadas para uma pasta específica. Uma pasta ".localizer" será criada para armazenar a configuração do seu projeto.';
  @override
  String get folderLabel => 'Pasta do Projeto';
  @override
  String get folderHint => 'Clique para selecionar a pasta...';
  @override
  String get nameLabel => 'Nome do Projeto';
  @override
  String get nameHint => 'ex: Traduções do Meu App';
  @override
  String get selectFolderWarning =>
      'Por favor, selecione uma pasta de projeto.';
  @override
  String get enterNameError => 'Por favor, insira um nome de projeto';
  @override
  String get nameLengthError => 'O nome deve ter pelo menos 2 caracteres';
  @override
  String success({required Object name}) =>
      'Projeto "${name}" criado com sucesso!';
  @override
  String get failure => 'Falha ao criar o projeto.';
  @override
  String get creating => 'Criando...';
  @override
  String get createAction => 'Criar Projeto';
}

// Path: projects.indicator
class _TranslationsProjectsIndicatorPtBr
    extends TranslationsProjectsIndicatorEn {
  _TranslationsProjectsIndicatorPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get tooltipNoProject =>
      'Crie um projeto para salvar configurações personalizadas para uma pasta';
  @override
  String tooltipProject({required Object name}) =>
      'Projeto: ${name}\nClique para ver as opções';
  @override
  String get location => 'Localização';
  @override
  String get created => 'Criado';
  @override
  String get switchProject => 'Trocar Projeto';
  @override
  String get done => 'Concluído';
}

// Path: projects.glossary
class _TranslationsProjectsGlossaryPtBr extends TranslationsProjectsGlossaryEn {
  _TranslationsProjectsGlossaryPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Glossário do Projeto';
  @override
  String get description =>
      'Defina termos que devem ser tratados de forma consistente ou nunca traduzidos.';
  @override
  String get noTerms => 'Nenhum termo no glossário ainda.';
  @override
  String get noTermsDesc =>
      'Adicione termos que devem permanecer consistentes entre as traduções,\nou marque nomes de marcas que nunca devem ser traduzidos.';
  @override
  String get doNotTranslate => 'Não traduzir';
  @override
  String get noSpecificTranslation => 'Nenhuma tradução específica';
  @override
  String get addTerm => 'Adicionar Termo';
  @override
  String get editTerm => 'Editar Termo';
  @override
  String get term => 'Termo';
  @override
  String get termHint => 'ex: nome da marca, termo especializado';
  @override
  String get definition => 'Definição (Opcional)';
  @override
  String get definitionHint => 'Contexto para o tradutor';
  @override
  String get doNotTranslateLabel => 'Não Traduzir';
  @override
  String get doNotTranslateDesc =>
      'Manter o termo exatamente como está no destino';
  @override
  String get preferredTranslation => 'Tradução Preferida';
  @override
  String get caseSensitive => 'Diferenciar Maiúsculas/Minúsculas';
}

// Path: projects.conflicts
class _TranslationsProjectsConflictsPtBr
    extends TranslationsProjectsConflictsEn {
  _TranslationsProjectsConflictsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String missingApiKeyTitle({required Object service}) =>
      'Chave de API ausente para ${service}';
  @override
  String missingApiKeyMessage({required Object service}) =>
      'Este projeto usa ${service}, mas nenhuma chave de API está configurada. Adicione sua chave de API em Configurações > Serviços de IA, ou o app usará o padrão global.';
  @override
  String get dismiss => 'Descartar';
}

// Path: projects.tm
class _TranslationsProjectsTmPtBr extends TranslationsProjectsTmEn {
  _TranslationsProjectsTmPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Memórias de Tradução';
  @override
  String get description =>
      'Gerenciar fontes de memória de tradução para este projeto.';
  @override
  String get globalTm => 'Memória de Tradução Global';
  @override
  String get globalTmDescription =>
      'Usar a memória de tradução compartilhada das configurações do seu app';
  @override
  String get linkedFiles => 'Arquivos Vinculados (Específicos do Projeto)';
  @override
  String get noLinkedFiles => 'Nenhum arquivo específico do projeto vinculado.';
  @override
  String get addTmFile => 'Adicionar Arquivo de TM';
  @override
  String get useGlobalTm => 'Usar TM Global';
  @override
  String get selectTm => 'Selecionar Memória de Tradução';
  @override
  String get globalTmEnabled => 'Memória de Tradução Global ativada';
}

// Path: git.conflicts
class _TranslationsGitConflictsPtBr extends TranslationsGitConflictsEn {
  _TranslationsGitConflictsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Conflitos de Merge Detectados';
  @override
  String get description =>
      'Você deve resolver estes conflitos antes de continuar.';
  @override
  String get abortMergeTitle => 'Abortar Merge?';
  @override
  String get abortMergeContent =>
      'Isso reverterá todas as alterações de merge e retornará ao estado anterior ao merge. Esta ação não pode ser desfeita.';
  @override
  String get abortMergeAction => 'Abortar Merge';
  @override
  String stagingFile({required Object file}) =>
      'Preparando ${file} para commit...';
  @override
  String conflictedFilesCount({required Object count}) =>
      'Arquivos com Conflito (${count})';
  @override
  String get selectFileToResolve => 'Selecione um arquivo para resolver';
  @override
  String resolvingFile({required Object file}) => 'Resolvendo: ${file}';
  @override
  String get keepAllOurs => 'Manter Tudo Nosso (Ours)';
  @override
  String get acceptAllTheirs => 'Aceitar Tudo Deles (Theirs)';
  @override
  String get allResolved =>
      'Todos os conflitos neste arquivo foram resolvidos!';
  @override
  String get markResolved => 'Marcar como Resolvido';
  @override
  String get stageForCommit => 'Isso preparará o arquivo para commit.';
  @override
  String conflictIndex({required Object index}) => 'Conflito #${index}';
  @override
  String get ours => 'NOSSO (Ours - Atual)';
  @override
  String get theirs => 'DELES (Theirs - Entrada)';
  @override
  String get keepOurs => 'Manter Nosso';
  @override
  String get acceptTheirs => 'Aceitar Deles';
  @override
  String get empty => '(Vazio)';
}

// Path: wizards.firstRun
class _TranslationsWizardsFirstRunPtBr extends TranslationsWizardsFirstRunEn {
  _TranslationsWizardsFirstRunPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get welcome => 'Bem-vindo ao Localizer';
  @override
  String get description => 'Compare seus arquivos de localização em segundos.';
  @override
  String get sourceFile => 'Arquivo de Origem';
  @override
  String get targetFile => 'Arquivo de Destino';
  @override
  String get compareNow => 'Comparar Agora';
  @override
  String get trySample => 'Tentar com Dados de Exemplo';
  @override
  String get skip => 'Pular Configuração';
  @override
  String get browse => 'Clique para procurar';
  @override
  String error({required Object error}) =>
      'Falha ao carregar dados de exemplo: ${error}';
}

// Path: dialogs.addIgnorePattern
class _TranslationsDialogsAddIgnorePatternPtBr
    extends TranslationsDialogsAddIgnorePatternEn {
  _TranslationsDialogsAddIgnorePatternPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Adicionar Padrão de Ignorar';
  @override
  String get patternLabel => 'Padrão (regex)';
  @override
  String get hint => 'ex: ^temp_.*';
  @override
  String get invalid => 'Padrão regex inválido';
  @override
  String get testStringLabel => 'Testar String';
  @override
  String get testHint => 'Insira uma chave para testar contra o padrão';
  @override
  String get match => '✓ Padrão corresponde à string de teste';
  @override
  String get noMatch => '✗ Padrão não corresponde';
  @override
  String get add => 'Adicionar';
  @override
  String get cancel => 'Cancelar';
}

// Path: dialogs.diffViewer
class _TranslationsDialogsDiffViewerPtBr
    extends TranslationsDialogsDiffViewerEn {
  _TranslationsDialogsDiffViewerPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Visualizador de Diff';
  @override
  String get originalFile => 'Arquivo Original/Referência';
  @override
  String get translationFile => 'Arquivo de Tradução/Comparação';
  @override
  String get base => 'BASE';
  @override
  String get target => 'DESTINO';
  @override
  String get added => 'Adicionado';
  @override
  String get removed => 'Removido';
  @override
  String get modified => 'Modificado';
  @override
  String get noMatches => 'Nenhuma entrada corresponde aos filtros atuais';
  @override
  String get clickToggle => 'Clique nos badges acima para alternar os filtros';
  @override
  String get clickToHide => '(clique para ocultar)';
  @override
  String get clickToShow => '(clique para mostrar)';
}

// Path: grid.columns
class _TranslationsGridColumnsPtBr extends TranslationsGridColumnsEn {
  _TranslationsGridColumnsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'Chave';
  @override
  String get source => 'Origem';
  @override
  String get status => 'Status';
  @override
  String get actions => 'Ações';
}

// Path: tutorial.steps
class _TranslationsTutorialStepsPtBr extends TranslationsTutorialStepsEn {
  _TranslationsTutorialStepsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTutorialStepsImportSourcePtBr importSource =
      _TranslationsTutorialStepsImportSourcePtBr._(_root);
  @override
  late final _TranslationsTutorialStepsImportTargetPtBr importTarget =
      _TranslationsTutorialStepsImportTargetPtBr._(_root);
  @override
  late final _TranslationsTutorialStepsComparePtBr compare =
      _TranslationsTutorialStepsComparePtBr._(_root);
  @override
  late final _TranslationsTutorialStepsFilterPtBr filter =
      _TranslationsTutorialStepsFilterPtBr._(_root);
  @override
  late final _TranslationsTutorialStepsSearchPtBr search =
      _TranslationsTutorialStepsSearchPtBr._(_root);
  @override
  late final _TranslationsTutorialStepsAdvancedPtBr advanced =
      _TranslationsTutorialStepsAdvancedPtBr._(_root);
  @override
  late final _TranslationsTutorialStepsExportPtBr export =
      _TranslationsTutorialStepsExportPtBr._(_root);
}

// Path: friendlyErrors.fileNotFound
class _TranslationsFriendlyErrorsFileNotFoundPtBr
    extends TranslationsFriendlyErrorsFileNotFoundEn {
  _TranslationsFriendlyErrorsFileNotFoundPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'O arquivo ou pasta não pôde ser encontrado.';
  @override
  String get suggestion => 'Verifique se o arquivo foi movido ou excluído.';
}

// Path: friendlyErrors.accessDenied
class _TranslationsFriendlyErrorsAccessDeniedPtBr
    extends TranslationsFriendlyErrorsAccessDeniedEn {
  _TranslationsFriendlyErrorsAccessDeniedPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'O acesso ao arquivo foi negado.';
  @override
  String get suggestion =>
      'Tente executar o aplicativo como administrador ou verifique as permissões do arquivo.';
}

// Path: friendlyErrors.isDirectory
class _TranslationsFriendlyErrorsIsDirectoryPtBr
    extends TranslationsFriendlyErrorsIsDirectoryEn {
  _TranslationsFriendlyErrorsIsDirectoryPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Uma pasta foi selecionada em vez de um arquivo.';
  @override
  String get suggestion => 'Por favor, selecione um arquivo válido.';
}

// Path: friendlyErrors.fileAccess
class _TranslationsFriendlyErrorsFileAccessPtBr
    extends TranslationsFriendlyErrorsFileAccessEn {
  _TranslationsFriendlyErrorsFileAccessPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Houve um problema ao acessar o arquivo.';
  @override
  String get suggestion =>
      'Tente fechar outros programas que possam estar usando o arquivo.';
}

// Path: friendlyErrors.unsupportedFormat
class _TranslationsFriendlyErrorsUnsupportedFormatPtBr
    extends TranslationsFriendlyErrorsUnsupportedFormatEn {
  _TranslationsFriendlyErrorsUnsupportedFormatPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Este formato de arquivo ou operação não é suportado.';
  @override
  String get suggestion =>
      'Verifique a extensão do arquivo ou tente um formato diferente.';
}

// Path: friendlyErrors.networkError
class _TranslationsFriendlyErrorsNetworkErrorPtBr
    extends TranslationsFriendlyErrorsNetworkErrorEn {
  _TranslationsFriendlyErrorsNetworkErrorPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Não foi possível conectar ao servidor.';
  @override
  String get suggestion =>
      'Verifique sua conexão com a internet e tente novamente.';
}

// Path: friendlyErrors.notGitRepo
class _TranslationsFriendlyErrorsNotGitRepoPtBr
    extends TranslationsFriendlyErrorsNotGitRepoEn {
  _TranslationsFriendlyErrorsNotGitRepoPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Esta pasta não é um projeto Git.';
  @override
  String get suggestion =>
      'Navegue até uma pasta que contenha um diretório .git.';
}

// Path: friendlyErrors.mergeConflict
class _TranslationsFriendlyErrorsMergeConflictPtBr
    extends TranslationsFriendlyErrorsMergeConflictEn {
  _TranslationsFriendlyErrorsMergeConflictPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Existem conflitos de merge no repositório.';
  @override
  String get suggestion => 'Resolva os conflitos antes de continuar.';
}

// Path: friendlyErrors.gitAuthFailed
class _TranslationsFriendlyErrorsGitAuthFailedPtBr
    extends TranslationsFriendlyErrorsGitAuthFailedEn {
  _TranslationsFriendlyErrorsGitAuthFailedPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Falha na autenticação do Git.';
  @override
  String get suggestion =>
      'Verifique suas credenciais em Configurações > Controle de Versão.';
}

// Path: friendlyErrors.gitOperationFailed
class _TranslationsFriendlyErrorsGitOperationFailedPtBr
    extends TranslationsFriendlyErrorsGitOperationFailedEn {
  _TranslationsFriendlyErrorsGitOperationFailedPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Uma operação do Git falhou.';
  @override
  String get suggestion =>
      'Verifique a visualização do Git para mais detalhes.';
}

// Path: friendlyErrors.invalidJson
class _TranslationsFriendlyErrorsInvalidJsonPtBr
    extends TranslationsFriendlyErrorsInvalidJsonEn {
  _TranslationsFriendlyErrorsInvalidJsonPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'O formato do arquivo é inválido ou está corrompido.';
  @override
  String get suggestion =>
      'Certifique-se de que o arquivo contém conteúdo JSON válido.';
}

// Path: friendlyErrors.rateLimitReached
class _TranslationsFriendlyErrorsRateLimitReachedPtBr
    extends TranslationsFriendlyErrorsRateLimitReachedEn {
  _TranslationsFriendlyErrorsRateLimitReachedPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Limite de tradução atingido.';
  @override
  String get suggestion =>
      'Aguarde alguns minutos ou verifique os limites do seu plano de API.';
}

// Path: friendlyErrors.invalidApiKey
class _TranslationsFriendlyErrorsInvalidApiKeyPtBr
    extends TranslationsFriendlyErrorsInvalidApiKeyEn {
  _TranslationsFriendlyErrorsInvalidApiKeyPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Chave de API inválida.';
  @override
  String get suggestion =>
      'Vá em Configurações > Tradução por IA para atualizar sua chave de API.';
}

// Path: friendlyErrors.translationServiceError
class _TranslationsFriendlyErrorsTranslationServiceErrorPtBr
    extends TranslationsFriendlyErrorsTranslationServiceErrorEn {
  _TranslationsFriendlyErrorsTranslationServiceErrorPtBr._(
      TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Erro no serviço de tradução.';
  @override
  String get suggestion =>
      'Verifique sua chave de API e conexão com a internet.';
}

// Path: friendlyErrors.outOfMemory
class _TranslationsFriendlyErrorsOutOfMemoryPtBr
    extends TranslationsFriendlyErrorsOutOfMemoryEn {
  _TranslationsFriendlyErrorsOutOfMemoryPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Memória insuficiente para completar esta operação.';
  @override
  String get suggestion =>
      'Tente fechar outros aplicativos ou usar arquivos menores.';
}

// Path: friendlyErrors.genericError
class _TranslationsFriendlyErrorsGenericErrorPtBr
    extends TranslationsFriendlyErrorsGenericErrorEn {
  _TranslationsFriendlyErrorsGenericErrorPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Algo deu errado.';
  @override
  String get suggestion =>
      'Por favor, tente novamente. Se o problema persistir, reinicie o aplicativo.';
}

// Path: settings.appearance.presets
class _TranslationsSettingsAppearancePresetsPtBr
    extends TranslationsSettingsAppearancePresetsEn {
  _TranslationsSettingsAppearancePresetsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get presetDefault => 'Padrão';
  @override
  String get presetColorblind => 'Acessível para Daltônicos';
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
class _TranslationsSettingsAppearancePreviewPtBr
    extends TranslationsSettingsAppearancePreviewEn {
  _TranslationsSettingsAppearancePreviewPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get step3Title => 'onboarding.step3.title';
  @override
  String get connectAccount => '"Conecte sua Conta"';
  @override
  String get loginHint => 'deprecated.login_hint_v1';
  @override
  String get enterCredentials => '"Insira as credenciais"';
  @override
  String get ctaButton => 'checkout.cta_button';
  @override
  String get buyNow => '"Comprar Agora"';
  @override
  String get completePurchase => '"Finalizar Compra"';
  @override
  String get appNameKey => 'common.app_name';
  @override
  String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class _TranslationsSettingsComparisonPatternPresetsPtBr
    extends TranslationsSettingsComparisonPatternPresetsEn {
  _TranslationsSettingsComparisonPatternPresetsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get comments => 'Comentários';
  @override
  String get tempKeys => 'Chaves Temporárias';
  @override
  String get placeholders => 'Espaços Reservados';
  @override
  String get devOnly => 'Apenas Dev';
}

// Path: settings.comparison.previewMatch
class _TranslationsSettingsComparisonPreviewMatchPtBr
    extends TranslationsSettingsComparisonPreviewMatchEn {
  _TranslationsSettingsComparisonPreviewMatchPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Visualizar Correspondência';
  @override
  String get description =>
      'Teste como suas configurações atuais afetam a lógica de correspondência.';
  @override
  String get stringA => 'String A';
  @override
  String get stringB => 'String B';
  @override
  String get enterText => 'Digite o texto...';
  @override
  String get similarity => 'Similaridade';
  @override
  String get identical => 'Idêntico';
  @override
  String get identicalDescription =>
      'As strings coincidem exatamente após a normalização.';
  @override
  String get ignored => 'Ignorado';
  @override
  String get ignoredDescription =>
      'A entrada corresponde a um padrão de ignorar.';
  @override
  String get different => 'Diferente';
  @override
  String get differentDescription => 'Um dos valores está vazio.';
  @override
  String get similarModified => 'Semelhante / Modificado';
  @override
  String similarModifiedDescription({required Object threshold}) =>
      'A pontuação de correspondência está acima do limiar (${threshold}%).';
  @override
  String get newDifferent => 'Novo / Diferente';
  @override
  String newDifferentDescription({required Object threshold}) =>
      'A pontuação de correspondência está abaixo do limiar (${threshold}%).';
}

// Path: settings.comparison.colorPresets
class _TranslationsSettingsComparisonColorPresetsPtBr
    extends TranslationsSettingsComparisonColorPresetsEn {
  _TranslationsSettingsComparisonColorPresetsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get kDefault => 'Padrão';
  @override
  String get colorblindFriendly => 'Acessível para Daltônicos';
  @override
  String get highContrast => 'Alto Contraste';
  @override
  String get nord => 'Nord';
  @override
  String get solarized => 'Solarized';
  @override
  String get monokai => 'Monokai';
  @override
  String get presetDefault => 'Padrão';
  @override
  String get presetColorblind => 'Acessível para Daltônicos';
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
class _TranslationsSettingsIntegrationsMaterialsPtBr
    extends TranslationsSettingsIntegrationsMaterialsEn {
  _TranslationsSettingsIntegrationsMaterialsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get sidebar => 'Barra lateral';
  @override
  String get menu => 'Menu';
  @override
  String get popover => 'Popover';
  @override
  String get titlebar => 'Barra de título';
  @override
  String get underPageBackground => 'Fundo da página';
  @override
  String get contentBackground => 'Conteúdo';
}

// Path: settings.integrations.fileTypes
class _TranslationsSettingsIntegrationsFileTypesPtBr
    extends TranslationsSettingsIntegrationsFileTypesEn {
  _TranslationsSettingsIntegrationsFileTypesPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get loc => 'Arquivo de Projeto Localizer';
  @override
  String get lang => 'Arquivo de Idioma';
  @override
  String get json => 'Arquivo de Localização JSON';
  @override
  String get xml => 'Arquivo de Localização XML';
}

// Path: settings.developer.themePlaygroundSection
class _TranslationsSettingsDeveloperThemePlaygroundSectionPtBr
    extends TranslationsSettingsDeveloperThemePlaygroundSectionEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionPtBr._(
      TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get colors => 'Cores';
  @override
  String get typography => 'Tipografia';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionPalettePtBr
      palette =
      _TranslationsSettingsDeveloperThemePlaygroundSectionPalettePtBr._(_root);
}

// Path: settings.developer.featureFlags
class _TranslationsSettingsDeveloperFeatureFlagsPtBr
    extends TranslationsSettingsDeveloperFeatureFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Recursos Experimentais';
  @override
  String get description =>
      'Alternar flags de recursos localmente para teste. Essas sobreposições persistem entre as reinicializações do app.';
  @override
  String get subtitle => 'Sobrescrever recursos experimentais';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsPtBr flags =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsPtBr._(_root);
  @override
  String get reset => 'Redefinir Todas as Flags';
  @override
  String get overrides => 'Sobreposições Locais';
  @override
  String get defaultVal => 'Padrão';
  @override
  String get on => 'LIGADO';
  @override
  String get off => 'DESLIGADO';
}

// Path: settings.developer.storageInspectorSection
class _TranslationsSettingsDeveloperStorageInspectorSectionPtBr
    extends TranslationsSettingsDeveloperStorageInspectorSectionEn {
  _TranslationsSettingsDeveloperStorageInspectorSectionPtBr._(
      TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'Atualizar';
  @override
  String get hiveData => 'Dados do Hive';
  @override
  String get secureStorage => 'Secure Storage';
}

// Path: settings.developer.deviceInfoSection
class _TranslationsSettingsDeveloperDeviceInfoSectionPtBr
    extends TranslationsSettingsDeveloperDeviceInfoSectionEn {
  _TranslationsSettingsDeveloperDeviceInfoSectionPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'Atualizar';
  @override
  String get copy => 'Copiar para Área de Transferência';
  @override
  String get computerName => 'Nome do Computador';
  @override
  String get osVersion => 'Versão do SO';
}

// Path: settings.developer.localizationInspectorSection
class _TranslationsSettingsDeveloperLocalizationInspectorSectionPtBr
    extends TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
  _TranslationsSettingsDeveloperLocalizationInspectorSectionPtBr._(
      TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get showKeys => 'Mostrar Chaves em vez de Valores';
  @override
  String get keysVisible => 'Chaves visíveis';
  @override
  String get normalDisplay => 'Exibição normal';
  @override
  String get note =>
      'Nota: Este recurso requer que a localização do app use um wrapper que respeite esta configuração.';
}

// Path: settings.onboarding.steps
class _TranslationsSettingsOnboardingStepsPtBr
    extends TranslationsSettingsOnboardingStepsEn {
  _TranslationsSettingsOnboardingStepsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsOnboardingStepsImportFilesPtBr importFiles =
      _TranslationsSettingsOnboardingStepsImportFilesPtBr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsRunComparisonPtBr
      runComparison =
      _TranslationsSettingsOnboardingStepsRunComparisonPtBr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsReviewMissingPtBr
      reviewMissing =
      _TranslationsSettingsOnboardingStepsReviewMissingPtBr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsUseFiltersPtBr useFilters =
      _TranslationsSettingsOnboardingStepsUseFiltersPtBr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsSearchResultsPtBr
      searchResults =
      _TranslationsSettingsOnboardingStepsSearchResultsPtBr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsAdvancedViewPtBr advancedView =
      _TranslationsSettingsOnboardingStepsAdvancedViewPtBr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsEditCellPtBr editCell =
      _TranslationsSettingsOnboardingStepsEditCellPtBr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsExportResultsPtBr
      exportResults =
      _TranslationsSettingsOnboardingStepsExportResultsPtBr._(_root);
}

// Path: settings.settingsView.categories
class _TranslationsSettingsSettingsViewCategoriesPtBr
    extends TranslationsSettingsSettingsViewCategoriesEn {
  _TranslationsSettingsSettingsViewCategoriesPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'Configurações Gerais';
  @override
  String get comparisonEngine => 'Mecanismo de Comparação';
  @override
  String get appearance => 'Aparência';
  @override
  String get fileHandling => 'Manipulação de Arquivos';
  @override
  String get aiServices => 'Serviços de IA';
  @override
  String get systemIntegrations => 'Integrações de Sistema';
  @override
  String get projectResources => 'Recursos do Projeto (Glossário & TM)';
  @override
  String get developer => 'Opções de Desenvolvedor';
  @override
  String get about => 'Sobre';
}

// Path: settings.settingsView.categoryLabels
class _TranslationsSettingsSettingsViewCategoryLabelsPtBr
    extends TranslationsSettingsSettingsViewCategoryLabelsEn {
  _TranslationsSettingsSettingsViewCategoryLabelsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'Geral';
  @override
  String get comparisonEngine => 'Comparação';
  @override
  String get appearance => 'Aparência';
  @override
  String get fileHandling => 'Manipulação de Arquivos';
  @override
  String get aiServices => 'Serviços de IA';
  @override
  String get systemIntegrations => 'Integrações de Sistema';
  @override
  String get projectResources => 'Recursos do Projeto';
  @override
  String get developer => 'Opções de Desenvolvedor';
  @override
  String get about => 'Sobre';
}

// Path: advancedDiff.sidebar.actionsSection
class _TranslationsAdvancedDiffSidebarActionsSectionPtBr
    extends TranslationsAdvancedDiffSidebarActionsSectionEn {
  _TranslationsAdvancedDiffSidebarActionsSectionPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get exportMatches => 'Exportar correspondências';
  @override
  String get preview => 'Visualizar';
  @override
  String get fillFromTmTitle => 'Preencher a partir da Memória de Tradução?';
  @override
  String get fillFromTmContent =>
      'Isso tentará preencher os valores de destino vazios usando correspondências da Memória de Tradução. Os valores existentes NÃO serão sobrescritos.';
  @override
  String get fill => 'Preencher';
  @override
  String get fillFromMemory => 'Preencher da Memória';
  @override
  String filledFromTm({required Object count}) =>
      'Preenchidos ${count} itens da Memória de Tradução.';
}

// Path: advancedDiff.sidebar.aiSection
class _TranslationsAdvancedDiffSidebarAiSectionPtBr
    extends TranslationsAdvancedDiffSidebarAiSectionEn {
  _TranslationsAdvancedDiffSidebarAiSectionPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get infoCloud =>
      'Usa tradução na nuvem para traduzir valores de destino vazios a partir da origem.';
  @override
  String get infoAi =>
      'Usa IA para traduzir valores de destino vazios a partir da origem.';
  @override
  String get translationSettings => 'Configurações de Tradução';
  @override
  String get aiSettings => 'Configurações de IA';
  @override
  String get source => 'Origem';
  @override
  String get target => 'Destino';
  @override
  String translatingProgress({required Object percent}) =>
      'Traduzindo... ${percent}%';
  @override
  String get translating => 'Traduzindo...';
  @override
  String get translateAllMissing => 'Traduzir Todos os Ausentes';
  @override
  String get translateAllTitle => 'Traduzir Todos os Ausentes?';
  @override
  String translateAllContent(
          {required Object service,
          required Object source,
          required Object target}) =>
      'Isso usará ${service} para traduzir todas as entradas com valores de destino vazios de ${source} para ${target}.\n\nVocê pode revisar cada sugestão ou aplicar todas de uma vez.';
  @override
  String get translateAll => 'Traduzir Tudo';
  @override
  String get reviewEach => 'Revisar Cada';
  @override
  String cloudTranslated({required Object count}) =>
      'Traduzidas ${count} entradas com tradução na nuvem.';
  @override
  String aiTranslated({required Object count}) =>
      'Traduzidas ${count} entradas com IA.';
  @override
  String get aiTranslateFailed => 'Falha ao traduzir tudo por IA';
  @override
  String get noMissingEntries => 'Nenhuma entrada ausente para traduzir.';
  @override
  String get skip => 'Pular';
  @override
  String get stop => 'Parar';
  @override
  String cloudApplied({required Object count}) =>
      'Aplicadas ${count} sugestões.';
  @override
  String aiApplied({required Object count}) =>
      'Aplicadas ${count} sugestões de IA.';
}

// Path: advancedDiff.sidebar.tmSection
class _TranslationsAdvancedDiffSidebarTmSectionPtBr
    extends TranslationsAdvancedDiffSidebarTmSectionEn {
  _TranslationsAdvancedDiffSidebarTmSectionPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get enableTmFill => 'Ativar Preenchimento por TM';
  @override
  String get autoApplyAboveMinimum => 'Aplicar automaticamente acima do mínimo';
  @override
  String get matchSettings => 'Configurações de Correspondência';
  @override
  String get minMatch => 'Correspondência mín.:';
  @override
  String get limit => 'Limite:';
  @override
  String get exact => 'Exata';
}

// Path: advancedDiff.sidebar.filtersSection
class _TranslationsAdvancedDiffSidebarFiltersSectionPtBr
    extends TranslationsAdvancedDiffSidebarFiltersSectionEn {
  _TranslationsAdvancedDiffSidebarFiltersSectionPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get viewFilters => 'Filtros de Visualização';
  @override
  String get showAll => 'Mostrar Tudo';
  @override
  String get added => 'Adicionado';
  @override
  String get removed => 'Removido';
  @override
  String get modified => 'Modificado';
  @override
  String get actionScope => 'Escopo da Ação';
  @override
  String get applyToAdded => 'Aplicar aos Adicionados';
  @override
  String get applyToModified => 'Aplicar aos Modificados';
  @override
  String get onlyFillEmptyTargets => 'Apenas preencher destinos vazios';
  @override
  String get limitToVisible => 'Limitar ao visível';
  @override
  String get editMode => 'Modo de Edição';
  @override
  String get dialog => 'Diálogo';
  @override
  String get inline => 'Em linha';
}

// Path: advancedDiff.sidebar.similaritySection
class _TranslationsAdvancedDiffSidebarSimilaritySectionPtBr
    extends TranslationsAdvancedDiffSidebarSimilaritySectionEn {
  _TranslationsAdvancedDiffSidebarSimilaritySectionPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get currentFilter => 'Filtro Atual:';
  @override
  String get any => 'QUALQUER';
  @override
  String get high => 'ALTA';
  @override
  String get medium => 'MÉDIA';
  @override
  String get low => 'BAIXA';
}

// Path: advancedDiff.sidebar.statusSection
class _TranslationsAdvancedDiffSidebarStatusSectionPtBr
    extends TranslationsAdvancedDiffSidebarStatusSectionEn {
  _TranslationsAdvancedDiffSidebarStatusSectionPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String total({required Object count}) => '${count} total';
  @override
  String extra({required Object count}) => '${count} extras';
  @override
  String missing({required Object count}) => '${count} ausentes';
  @override
  String changed({required Object count}) => '${count} alterados';
}

// Path: tutorial.steps.importSource
class _TranslationsTutorialStepsImportSourcePtBr
    extends TranslationsTutorialStepsImportSourceEn {
  _TranslationsTutorialStepsImportSourcePtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '1. Importar Arquivo de Origem';
  @override
  String get description =>
      'Use o botão abaixo para procurar um arquivo ou arraste & solte na área destacada.';
}

// Path: tutorial.steps.importTarget
class _TranslationsTutorialStepsImportTargetPtBr
    extends TranslationsTutorialStepsImportTargetEn {
  _TranslationsTutorialStepsImportTargetPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '2. Importar Arquivo de Destino';
  @override
  String get description =>
      'Use o botão abaixo para procurar um arquivo ou arraste & solte na área destacada.';
}

// Path: tutorial.steps.compare
class _TranslationsTutorialStepsComparePtBr
    extends TranslationsTutorialStepsCompareEn {
  _TranslationsTutorialStepsComparePtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '3. Comparar Arquivos';
  @override
  String get description =>
      'Toque no botão abaixo para rodar a comparação e ver os resultados.';
}

// Path: tutorial.steps.filter
class _TranslationsTutorialStepsFilterPtBr
    extends TranslationsTutorialStepsFilterEn {
  _TranslationsTutorialStepsFilterPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '4. Filtrar Resultados';
  @override
  String get description =>
      'Use estes filtros para ver strings Adicionadas, Removidas ou Modificadas.';
}

// Path: tutorial.steps.search
class _TranslationsTutorialStepsSearchPtBr
    extends TranslationsTutorialStepsSearchEn {
  _TranslationsTutorialStepsSearchPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '5. Pesquisar Resultados';
  @override
  String get description =>
      'Encontre chaves ou valores específicos usando a barra de pesquisa.';
}

// Path: tutorial.steps.advanced
class _TranslationsTutorialStepsAdvancedPtBr
    extends TranslationsTutorialStepsAdvancedEn {
  _TranslationsTutorialStepsAdvancedPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '6. Visualização Avançada';
  @override
  String get description =>
      'Abra a visualização detalhada de diff com edição, tradução por IA e mais.';
}

// Path: tutorial.steps.export
class _TranslationsTutorialStepsExportPtBr
    extends TranslationsTutorialStepsExportEn {
  _TranslationsTutorialStepsExportPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '7. Exportar Resultados';
  @override
  String get description =>
      'Salve sua comparação como arquivo CSV, JSON ou Excel.';
}

// Path: settings.developer.themePlaygroundSection.palette
class _TranslationsSettingsDeveloperThemePlaygroundSectionPalettePtBr
    extends TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionPalettePtBr._(
      TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get primary => 'Primária';
  @override
  String get onPrimary => 'No Primária';
  @override
  String get secondary => 'Secundária';
  @override
  String get onSecondary => 'No Secundária';
  @override
  String get surface => 'Superfície';
  @override
  String get onSurface => 'Na Superfície';
  @override
  String get error => 'Erro';
  @override
  String get onError => 'No Erro';
  @override
  String get outline => 'Contorno';
  @override
  String get shadow => 'Sombra';
  @override
  String get success => 'Sucesso';
  @override
  String get warning => 'Aviso';
  @override
  String get info => 'Informação';
}

// Path: settings.developer.featureFlags.flags
class _TranslationsSettingsDeveloperFeatureFlagsFlagsPtBr
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchPtBr
      experimental_ai_batch =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchPtBr._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmPtBr
      new_diff_algorithm =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmPtBr._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchPtBr
      enhanced_search =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchPtBr._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSavePtBr
      auto_save =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSavePtBr._(_root);
}

// Path: settings.onboarding.steps.importFiles
class _TranslationsSettingsOnboardingStepsImportFilesPtBr
    extends TranslationsSettingsOnboardingStepsImportFilesEn {
  _TranslationsSettingsOnboardingStepsImportFilesPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Importar Arquivos';
  @override
  String get description => 'Carregar arquivos de origem e destino';
}

// Path: settings.onboarding.steps.runComparison
class _TranslationsSettingsOnboardingStepsRunComparisonPtBr
    extends TranslationsSettingsOnboardingStepsRunComparisonEn {
  _TranslationsSettingsOnboardingStepsRunComparisonPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Executar Comparação';
  @override
  String get description => 'Clique em "Comparar Arquivos"';
}

// Path: settings.onboarding.steps.reviewMissing
class _TranslationsSettingsOnboardingStepsReviewMissingPtBr
    extends TranslationsSettingsOnboardingStepsReviewMissingEn {
  _TranslationsSettingsOnboardingStepsReviewMissingPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Revisar Chaves Ausentes';
  @override
  String get description => 'Observe os itens FALTANDO em vermelho';
}

// Path: settings.onboarding.steps.useFilters
class _TranslationsSettingsOnboardingStepsUseFiltersPtBr
    extends TranslationsSettingsOnboardingStepsUseFiltersEn {
  _TranslationsSettingsOnboardingStepsUseFiltersPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Usar Filtros';
  @override
  String get description => 'Filtrar por tipo';
}

// Path: settings.onboarding.steps.searchResults
class _TranslationsSettingsOnboardingStepsSearchResultsPtBr
    extends TranslationsSettingsOnboardingStepsSearchResultsEn {
  _TranslationsSettingsOnboardingStepsSearchResultsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Resultados da Pesquisa';
  @override
  String get description => 'Encontrar chaves específicas';
}

// Path: settings.onboarding.steps.advancedView
class _TranslationsSettingsOnboardingStepsAdvancedViewPtBr
    extends TranslationsSettingsOnboardingStepsAdvancedViewEn {
  _TranslationsSettingsOnboardingStepsAdvancedViewPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Visualização Avançada';
  @override
  String get description => 'Explore análises detalhadas';
}

// Path: settings.onboarding.steps.editCell
class _TranslationsSettingsOnboardingStepsEditCellPtBr
    extends TranslationsSettingsOnboardingStepsEditCellEn {
  _TranslationsSettingsOnboardingStepsEditCellPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Editar uma Célula';
  @override
  String get description => 'Clique para editar um valor';
}

// Path: settings.onboarding.steps.exportResults
class _TranslationsSettingsOnboardingStepsExportResultsPtBr
    extends TranslationsSettingsOnboardingStepsExportResultsEn {
  _TranslationsSettingsOnboardingStepsExportResultsPtBr._(TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Exportar';
  @override
  String get description => 'Salve seu relatório';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchPtBr
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchPtBr._(
      TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Lote de IA Experimental';
  @override
  String get description => 'Ativar tradução de IA em lote para várias linhas';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmPtBr
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmPtBr._(
      TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Novo Algoritmo de Diff';
  @override
  String get description =>
      'Usar algoritmo de diff aprimorado para comparações';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchPtBr
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchPtBr._(
      TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Pesquisa Aprimorada';
  @override
  String get description =>
      'Ativar pesquisa difusa (fuzzy search) em arquivos de tradução';
}

// Path: settings.developer.featureFlags.flags.auto_save
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSavePtBr
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSavePtBr._(
      TranslationsPtBr root)
      : this._root = root,
        super.internal(root);

  final TranslationsPtBr _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Salvamento Automático';
  @override
  String get description => 'Salvar alterações automaticamente após as edições';
}

/// The flat map containing all translations for locale <pt-BR>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsPtBr {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
          'app.title' => 'Ferramenta de Comparação de Localização',
          'app.name' => 'Localizer',
          'common.save' => 'Salvar',
          'common.cancel' => 'Cancelar',
          'common.close' => 'Fechar',
          'common.delete' => 'Excluir',
          'common.edit' => 'Editar',
          'common.add' => 'Adicionar',
          'common.search' => 'Pesquisar',
          'common.undo' => 'Desfazer',
          'common.loading' => 'Carregando...',
          'common.error' => 'Erro',
          'common.success' => 'Sucesso',
          'common.warning' => 'Aviso',
          'common.info' => 'Informação',
          'common.confirm' => 'Confirmar',
          'common.yes' => 'Sim',
          'common.no' => 'Não',
          'common.ok' => 'OK',
          'common.retry' => 'Tentar Novamente',
          'common.copyText' => 'Copiar',
          'common.appName' => 'Localizer',
          'common.copied' => 'Copiado!',
          'common.enabled' => 'Ativado',
          'common.disabled' => 'Desativado',
          'common.browse' => 'Procurar',
          'common.clear' => 'Limpar',
          'common.apply' => 'Aplicar',
          'common.reset' => 'Redefinir',
          'common.refresh' => 'Atualizar',
          'common.export' => 'Exportar',
          'common.import' => 'Importar',
          'common.select' => 'Selecionar',
          'common.selectAll' => 'Selecionar Tudo',
          'common.deselectAll' => 'Desmarcar Tudo',
          'common.noResults' => 'Nenhum resultado encontrado',
          'common.emptyState' => 'Nada aqui ainda',
          'common.open' => 'Abrir',
          'common.change' => 'Alterar',
          'common.original' => 'Original',
          'common.kNew' => 'Novo',
          'common.remove' => 'Remover',
          'common.auto' => 'Automático',
          'common.execute' => 'Executar',
          'common.run' => 'Rodar',
          'common.unknown' => 'Desconhecido',
          'common.download' => 'Baixar',
          'common.dropdownArrow' => 'Seta suspensa',
          'common.openInNewWindow' => 'Abrir em nova janela',
          'common.resetToDefaults' => 'Redefinir para os padrões',
          'menu.file' => 'Arquivo',
          'menu.edit' => 'Editar',
          'menu.view' => 'Exibir',
          'menu.help' => 'Ajuda',
          'menu.openFiles' => 'Abrir Arquivos...',
          'menu.openFolder' => 'Abrir Pasta...',
          'menu.exportResults' => 'Exportar Resultados...',
          'menu.undo' => 'Desfazer',
          'menu.redo' => 'Refazer',
          'menu.cut' => 'Recortar',
          'menu.paste' => 'Colar',
          'menu.selectAll' => 'Selecionar Tudo',
          'menu.zoomIn' => 'Aumentar Zoom',
          'menu.zoomOut' => 'Diminuir Zoom',
          'menu.resetZoom' => 'Redefinir Zoom',
          'menu.documentation' => 'Documentação',
          'menu.reportIssue' => 'Relatar um Problema',
          'menu.about' => ({required Object appName}) => 'Sobre ${appName}',
          'nav.compare' => 'Comparar',
          'nav.history' => 'Histórico',
          'nav.settings' => 'Configurações',
          'nav.projects' => 'Projetos',
          'nav.dashboard' => 'Painel',
          'nav.directory' => 'Diretório',
          'nav.repository' => 'Repositório',
          'nav.tooltipCompare' => 'Comparar arquivos de localização',
          'nav.tooltipHistory' => 'Ver histórico de comparação',
          'nav.tooltipSettings' => 'Configurações do aplicativo',
          'nav.tooltipProjects' => 'Gerenciar projetos',
          'nav.tooltipThemeToggle' => 'Alternar Tema',
          'nav.tooltipDebugConsole' => 'Console de Depuração',
          'settings.title' => 'Configurações',
          'settings.appSettings' => 'Configurações do App',
          'settings.projectSettings' => 'Configurações do Projeto',
          'settings.appearance.title' => 'Aparência',
          'settings.appearance.description' =>
            'Personalize a aparência do aplicativo',
          'settings.appearance.theme' => 'Modo de Tema',
          'settings.appearance.themeDescription' =>
            'Escolha entre os temas claro, escuro ou do sistema',
          'settings.appearance.themeSystem' => 'Sistema',
          'settings.appearance.themeLight' => 'Claro',
          'settings.appearance.themeDark' => 'Escuro',
          'settings.appearance.themeAmoled' => 'AMOLED',
          'settings.appearance.accentColor' => 'Cor de Destaque',
          'settings.appearance.accentColorDescription' =>
            'Escolha sua cor de destaque preferida',
          'settings.appearance.useMicaEffect' => 'Usar Efeito Mica',
          'settings.appearance.micaDescription' =>
            'Ativar o efeito de transparência Mica do Windows 11 para um visual moderno',
          'settings.appearance.diffFontSize' =>
            'Tamanho da Fonte de Comparação',
          'settings.appearance.diffFontSizeDescription' =>
            'Ajuste o tamanho da fonte da visualização de comparação',
          'settings.appearance.diffFontFamily' =>
            'Família da Fonte de Comparação',
          'settings.appearance.diffFontFamilyDescription' =>
            'Fonte para a visualização de comparação',
          'settings.appearance.systemDefault' => 'Padrão do Sistema',
          'settings.appearance.pickAccentColor' => 'Escolher Cor de Destaque',
          'settings.appearance.diffColors' => 'Cores de Comparação',
          'settings.appearance.presetsTitle' => 'Predefinições',
          'settings.appearance.presets.presetDefault' => 'Padrão',
          'settings.appearance.presets.presetColorblind' =>
            'Acessível para Daltônicos',
          'settings.appearance.presets.presetHighContrast' => 'Alto Contraste',
          'settings.appearance.presets.presetNord' => 'Nord',
          'settings.appearance.presets.presetSolarized' => 'Solarized',
          'settings.appearance.presets.presetMonokai' => 'Monokai',
          'settings.appearance.identical' => 'Idêntico',
          'settings.appearance.pickColorFor' => ({required Object label}) =>
              'Escolher Cor para ${label}',
          'settings.appearance.livePreview' => 'Visualização ao Vivo',
          'settings.appearance.preview.step3Title' => 'onboarding.step3.title',
          'settings.appearance.preview.connectAccount' => '"Conecte sua Conta"',
          'settings.appearance.preview.loginHint' => 'deprecated.login_hint_v1',
          'settings.appearance.preview.enterCredentials' =>
            '"Insira as credenciais"',
          'settings.appearance.preview.ctaButton' => 'checkout.cta_button',
          'settings.appearance.preview.buyNow' => '"Comprar Agora"',
          'settings.appearance.preview.completePurchase' =>
            '"Finalizar Compra"',
          'settings.appearance.preview.appNameKey' => 'common.app_name',
          'settings.appearance.preview.appNameValue' => '"Localizer"',
          'settings.general.title' => 'Geral',
          'settings.general.description' =>
            'Configurações gerais do aplicativo',
          'settings.general.language' => 'Idioma',
          'settings.general.languageDescription' =>
            'Escolha seu idioma preferido',
          'settings.general.startMinimized' => 'Iniciar Minimizado na Bandeja',
          'settings.general.startMinimizedDescription' =>
            'Inicie o aplicativo minimizado na bandeja do sistema',
          'settings.general.rememberWindowPosition' =>
            'Lembrar Posição da Janela',
          'settings.general.rememberWindowPositionDescription' =>
            'Restaurar tamanho e posição da janela ao iniciar',
          'settings.general.openLastProject' =>
            'Abrir Último Projeto ao Iniciar',
          'settings.general.openLastProjectDescription' =>
            'Abrir automaticamente o último projeto usado quando o app iniciar',
          'settings.general.application' => 'Aplicativo',
          'settings.general.defaultView' => 'Visualização Padrão',
          'settings.general.defaultViewDescription' =>
            'Visualização a ser exibida ao iniciar',
          'settings.general.autoCheckUpdates' =>
            'Verificar Atualizações Automaticamente',
          'settings.general.autoCheckUpdatesDescription' =>
            'Verificar se há atualizações ao iniciar',
          'settings.general.startupOptions' => 'Opções de Inicialização',
          'settings.general.languageAuto' => 'Detectar Automaticamente',
          'settings.general.viewBasic' => 'Comparação de Arquivos',
          'settings.general.viewHistory' => 'Histórico',
          'settings.general.viewDashboard' => 'Painel de Qualidade',
          'settings.general.viewDirectory' => 'Comparação de Diretório',
          'settings.general.viewLastUsed' => 'Última Visualização Usada',
          'settings.scope.title' => 'Escopo de Configurações',
          'settings.scope.global' => 'Padrões Globais',
          'settings.scope.project' => 'Projeto',
          'settings.scope.reset' => 'Redefinir Projeto para os Padrões Globais',
          'settings.scope.resetConfirmation' =>
            'Isso limpará todas as sobreposições deste projeto e reverterá para os padrões globais. Esta ação não pode ser desfeita.',
          'settings.scope.globalDescription' =>
            'As alterações se aplicam a todos os projetos, a menos que sejam substituídas.',
          'settings.scope.projectDescription' => ({required Object name}) =>
              'As alterações se aplicam apenas a "${name}". Outras configurações herdam dos padrões globais.',
          'settings.scope.createPrompt' =>
            'Crie un projeto para personalizar as configurações para pastas específicas',
          'settings.searchKeywords.general.0' => 'Idioma',
          'settings.searchKeywords.general.1' => 'Visualização Padrão',
          'settings.searchKeywords.general.2' =>
            'Contagem de Arquivos Recentes',
          'settings.searchKeywords.general.3' => 'Abrir Último Projeto',
          'settings.searchKeywords.general.4' => 'Confirmar Antes de Sair',
          'settings.searchKeywords.general.5' => 'Mostrar Notificações',
          'settings.searchKeywords.comparisonEngine.0' => 'Modo de Comparação',
          'settings.searchKeywords.comparisonEngine.1' =>
            'Limiar de Similaridade',
          'settings.searchKeywords.comparisonEngine.2' =>
            'Diferenciar Maiúsculas e Minúsculas',
          'settings.searchKeywords.comparisonEngine.3' =>
            'Ignorar Espaços em Branco',
          'settings.searchKeywords.comparisonEngine.4' =>
            'Ignorar Linhas Vazias',
          'settings.searchKeywords.comparisonEngine.5' => 'Ignorar Comentários',
          'settings.searchKeywords.comparisonEngine.6' => 'Ignorar Padrões',
          'settings.searchKeywords.appearance.0' => 'Tema',
          'settings.searchKeywords.appearance.1' => 'Modo de Tema',
          'settings.searchKeywords.appearance.2' => 'Cor de Destaque',
          'settings.searchKeywords.appearance.3' =>
            'Tamanho da Fonte de Comparação',
          'settings.searchKeywords.appearance.4' =>
            'Família da Fonte de Comparação',
          'settings.searchKeywords.appearance.5' => 'Cores de Comparação',
          'settings.searchKeywords.appearance.6' => 'Cor Adicionada',
          'settings.searchKeywords.appearance.7' => 'Cor Removida',
          'settings.searchKeywords.appearance.8' => 'Cor Modificada',
          'settings.searchKeywords.appearance.9' => 'Cor Idêntica',
          'settings.searchKeywords.appearance.10' => 'Predefinições de Cores',
          'settings.searchKeywords.appearance.11' => 'Visualização',
          'settings.searchKeywords.fileHandling.0' => 'Formato de Origem',
          'settings.searchKeywords.fileHandling.1' => 'Formato de Destino',
          'settings.searchKeywords.fileHandling.2' => 'Codificação Padrão',
          'settings.searchKeywords.fileHandling.3' =>
            'Contagem de Projetos Recentes',
          'settings.searchKeywords.fileHandling.4' => 'Memória de Tradução',
          'settings.searchKeywords.fileHandling.5' => 'Importar Memória',
          'settings.searchKeywords.fileHandling.6' => 'Exportar Memória',
          'settings.searchKeywords.fileHandling.7' => 'Limpar Memória',
          'settings.searchKeywords.aiServices.0' => 'Chave de API da OpenAI',
          'settings.searchKeywords.aiServices.1' => 'Chave de API da Anthropic',
          'settings.searchKeywords.aiServices.2' => 'Chave de API da Google AI',
          'settings.searchKeywords.aiServices.3' => 'Modelo de IA',
          'settings.searchKeywords.aiServices.4' => 'Temperatura',
          'settings.searchKeywords.aiServices.5' => 'Prompt Personalizado',
          'settings.searchKeywords.systemIntegrations.0' =>
            'Bandeja do Sistema',
          'settings.searchKeywords.systemIntegrations.1' =>
            'Iniciar Minimizado',
          'settings.searchKeywords.systemIntegrations.2' =>
            'Associações de Arquivos',
          'settings.searchKeywords.systemIntegrations.3' => 'Efeito Mica',
          'settings.searchKeywords.systemIntegrations.4' => 'Vibrancy',
          'settings.searchKeywords.systemIntegrations.5' =>
            'Material da Janela',
          'settings.searchKeywords.systemIntegrations.6' => 'Badges no Dock',
          'settings.searchKeywords.systemIntegrations.7' =>
            'Contagem de Não Traduzidos',
          'settings.searchKeywords.projectResources.0' => 'Glossário',
          'settings.searchKeywords.projectResources.1' => 'Memória de Tradução',
          'settings.searchKeywords.projectResources.2' => 'Terminologia',
          'settings.searchKeywords.about.0' => 'Versão',
          'settings.searchKeywords.about.1' => 'Verificar Atualizações',
          'settings.searchKeywords.about.2' => 'Atualização Automática',
          'settings.searchKeywords.about.3' => 'Registro de Alterações',
          'settings.searchKeywords.about.4' => 'Licença',
          'settings.searchKeywords.about.5' => 'Política de Privacidade',
          'settings.searchKeywords.about.6' => 'Telemetria',
          'settings.searchKeywords.about.7' => 'Relatório de Erros',
          'settings.searchKeywords.developer.0' => 'Sobreposição de Desempenho',
          'settings.searchKeywords.developer.1' => 'Depurador de Semântica',
          'settings.searchKeywords.developer.2' => 'Grade de Material',
          'settings.searchKeywords.developer.3' => 'Cache de Rasterização',
          'settings.searchKeywords.developer.4' => 'Reiniciar Tutorial',
          'settings.searchKeywords.developer.5' => 'Redefinição de Fábrica',
          'settings.comparison.title' => 'Comparação',
          'settings.comparison.description' =>
            'Configurar o comportamento de comparação',
          'settings.comparison.caseSensitive' =>
            'Diferenciar Maiúsculas/Minúsculas',
          'settings.comparison.caseSensitiveDescription' =>
            'Tratar letras maiúsculas e minúsculas como diferentes',
          'settings.comparison.ignoreWhitespace' => 'Ignorar Espaços em Branco',
          'settings.comparison.ignoreWhitespaceDescription' =>
            'Ignorar espaços em branco no início/fim ao comparar',
          'settings.comparison.showLineNumbers' => 'Mostrar Números de Linha',
          'settings.comparison.showLineNumbersDescription' =>
            'Exibir números de linha na visualização de diff',
          'settings.comparison.behavior' => 'Comportamento de Comparação',
          'settings.comparison.ignoreCase' =>
            'Ignorar Diferença de Maiúsculas/Minúsculas',
          'settings.comparison.ignoreCaseDescription' =>
            'Tratar "Chave" e "chave" como iguais',
          'settings.comparison.similarityThreshold' => 'Limiar de Similaridade',
          'settings.comparison.similarityThresholdDescription' =>
            'Similaridade mínima para detecção de "Modificado"',
          'settings.comparison.mode' => 'Modo de Comparação',
          'settings.comparison.modeDescription' =>
            'Como corresponder entradas entre arquivos',
          'settings.comparison.modeKey' => 'Baseado em Chave',
          'settings.comparison.modeKeyDescription' =>
            'Corresponde pelo nome da chave (padrão).',
          'settings.comparison.modeOrder' => 'Baseado na Ordem',
          'settings.comparison.modeOrderDescription' =>
            'Corresponde pela posição no arquivo.',
          'settings.comparison.modeSmart' => 'Correspondência Inteligente',
          'settings.comparison.modeSmartDescription' =>
            'Detecta chaves movidas/renomeadas.',
          'settings.comparison.ignorePatterns' => 'Ignorar Padrões',
          'settings.comparison.noIgnorePatterns' =>
            'Nenhum padrão de ignorar definido.',
          'settings.comparison.addPattern' => 'Adicionar Padrão',
          'settings.comparison.resetToGlobal' =>
            'Redefinir todas as configurações de comparação para os padrões globais',
          'settings.comparison.patternPresets.comments' => 'Comentários',
          'settings.comparison.patternPresets.tempKeys' => 'Chaves Temporárias',
          'settings.comparison.patternPresets.placeholders' =>
            'Espaços Reservados',
          'settings.comparison.patternPresets.devOnly' => 'Apenas Dev',
          'settings.comparison.previewMatch.title' =>
            'Visualizar Correspondência',
          'settings.comparison.previewMatch.description' =>
            'Teste como suas configurações atuais afetam a lógica de correspondência.',
          'settings.comparison.previewMatch.stringA' => 'String A',
          'settings.comparison.previewMatch.stringB' => 'String B',
          'settings.comparison.previewMatch.enterText' => 'Digite o texto...',
          'settings.comparison.previewMatch.similarity' => 'Similaridade',
          'settings.comparison.previewMatch.identical' => 'Idêntico',
          'settings.comparison.previewMatch.identicalDescription' =>
            'As strings coincidem exatamente após a normalização.',
          'settings.comparison.previewMatch.ignored' => 'Ignorado',
          'settings.comparison.previewMatch.ignoredDescription' =>
            'A entrada corresponde a um padrão de ignorar.',
          'settings.comparison.previewMatch.different' => 'Diferente',
          'settings.comparison.previewMatch.differentDescription' =>
            'Um dos valores está vazio.',
          'settings.comparison.previewMatch.similarModified' =>
            'Semelhante / Modificado',
          'settings.comparison.previewMatch.similarModifiedDescription' => (
                  {required Object threshold}) =>
              'A pontuação de correspondência está acima do limiar (${threshold}%).',
          'settings.comparison.previewMatch.newDifferent' => 'Novo / Diferente',
          'settings.comparison.previewMatch.newDifferentDescription' => (
                  {required Object threshold}) =>
              'A pontuação de correspondência está abaixo do limiar (${threshold}%).',
          'settings.comparison.colorPresets.kDefault' => 'Padrão',
          'settings.comparison.colorPresets.colorblindFriendly' =>
            'Acessível para Daltônicos',
          'settings.comparison.colorPresets.highContrast' => 'Alto Contraste',
          'settings.comparison.colorPresets.nord' => 'Nord',
          'settings.comparison.colorPresets.solarized' => 'Solarized',
          'settings.comparison.colorPresets.monokai' => 'Monokai',
          'settings.comparison.colorPresets.presetDefault' => 'Padrão',
          'settings.comparison.colorPresets.presetColorblind' =>
            'Acessível para Daltônicos',
          'settings.comparison.colorPresets.presetHighContrast' =>
            'Alto Contraste',
          'settings.comparison.colorPresets.presetNord' => 'Nord',
          'settings.comparison.colorPresets.presetSolarized' => 'Solarized',
          'settings.comparison.colorPresets.presetMonokai' => 'Monokai',
          'settings.fileHandling.fileFormats' => 'Formatos de Arquivo',
          'settings.fileHandling.sourceFormat' => 'Formato de Origem',
          'settings.fileHandling.targetFormat' => 'Formato de Destino',
          'settings.fileHandling.encoding' => 'Codificação',
          'settings.fileHandling.sourceEncoding' => 'Codificação de Origem',
          'settings.fileHandling.targetEncoding' => 'Codificação de Destino',
          'settings.fileHandling.autoDetect' => 'Detectar Automaticamente',
          'settings.fileHandling.autoDetectEncodingDescription' =>
            'Detectar automaticamente a codificação do arquivo',
          'settings.fileHandling.exportSettings' =>
            'Configurações de Exportação',
          'settings.fileHandling.defaultExportFormat' =>
            'Formato de Exportação Padrão',
          'settings.fileHandling.includeUtf8Bom' => 'Incluir UTF-8 BOM',
          'settings.fileHandling.includeUtf8BomDescription' =>
            'Necessário para compatibilidade com Excel',
          'settings.fileHandling.openFolderAfterExport' =>
            'Abrir Pasta após Exportar',
          'settings.fileHandling.fileSafety' => 'Segurança de Arquivo',
          'settings.fileHandling.fileSafetyDescription' =>
            'Cópias locais automáticas para recuperação de desastres.',
          'settings.fileHandling.resetToGlobal' =>
            'Redefinir todas as configurações de manipulação de arquivo para os padrões globais',
          'settings.translationMemory.title' => 'Memória de Tradução Global',
          'settings.translationMemory.autoLearn' => 'Aprender Automaticamente',
          'settings.translationMemory.autoLearnDescription' =>
            'Salvar traduções na memória local para reutilização futura',
          'settings.translationMemory.confidenceThreshold' =>
            'Limiar de Confiança',
          'settings.translationMemory.confidenceThresholdDescription' => (
                  {required Object percent}) =>
              'Pontuação mínima para aplicação automática (${percent}%)',
          'settings.translationMemory.entries' => 'Entradas',
          'settings.translationMemory.size' => 'Tamanho',
          'settings.translationMemory.memorySize' => ({required Object size}) =>
              'Tamanho da Memória: ${size}',
          'settings.translationMemory.import' => 'Importar',
          'settings.translationMemory.exportTmx' => 'Exportar TMX',
          'settings.translationMemory.exportCsv' => 'Exportar CSV',
          'settings.translationMemory.clearMemory' => 'Limpar Memória',
          'settings.translationMemory.importedItems' => (
                  {required Object count}) =>
              '${count} itens importados para a memória.',
          'settings.translationMemory.noItemsAdded' =>
            'Nenhum item foi adicionado.',
          'settings.translationMemory.nothingToExport' =>
            'Nada para exportar ainda.',
          'settings.translationMemory.tmxSaved' => 'TMX salvo',
          'settings.translationMemory.csvSaved' => 'CSV salvo',
          'settings.translationMemory.clearConfirmTitle' =>
            'Limpar memória de tradução?',
          'settings.translationMemory.clearConfirmContent' =>
            'Isso remove todos os pares de tradução salvos neste dispositivo. Esta ação não pode ser desfeita.',
          'settings.translationMemory.cleared' => 'Memória de tradução limpa.',
          'settings.translationMemory.couldNotClear' =>
            'Não foi possível limpar a memória.',
          'settings.backup.title' => 'Backup Automático',
          'settings.backup.description' => 'Configurações de backup automático',
          'settings.backup.enabled' => 'Ativar Backup Automático',
          'settings.backup.enabledDescription' =>
            'Fazer backup automático dos arquivos antes de realizar alterações',
          'settings.backup.maxCopies' => 'Máximo de Cópias de Backup',
          'settings.backup.maxCopiesDescription' =>
            'Número de cópias de backup a serem mantidas por arquivo',
          'settings.backup.activeStatus' => ({required Object count}) =>
              'Ativo · Mantendo ${count} cópias',
          'settings.backup.folder' => 'Pasta de Backup',
          'settings.backup.folderDescription' =>
            'Deixe em branco para usar a mesma pasta',
          'settings.backup.useOriginalFolder' =>
            'Usar pasta original do arquivo',
          'settings.ai.title' => 'Serviços de IA',
          'settings.ai.description' =>
            'Configurar tradução e assistência por IA',
          'settings.ai.provider' => 'Provedor de IA',
          'settings.ai.providerDescription' =>
            'Escolha seu provedor de serviços de IA preferido',
          'settings.ai.apiKey' => 'Chave de API',
          'settings.ai.apiKeyDescription' =>
            'Insira sua chave de API para o provedor selecionado',
          'settings.ai.apiKeyPlaceholder' => 'Insira a chave de API...',
          'settings.ai.testConnection' => 'Testar Conexão',
          'settings.ai.connectionSuccess' => 'Conexão bem-sucedida!',
          'settings.ai.connectionFailed' =>
            'Falha na conexão. Por favor, verifique sua chave de API.',
          'settings.ai.translationStrategy' => 'Estratégia de Tradução',
          'settings.ai.strategy' => 'Estratégia',
          'settings.ai.strategyDescription' =>
            'Selecione como você deseja traduzir as strings',
          'settings.ai.strategyLLM' => 'IA Generativa (LLM)',
          'settings.ai.strategyCloud' => 'Tradução na Nuvem',
          'settings.ai.enableAiTranslation' => 'Ativar Tradução por IA',
          'settings.ai.enableAiTranslationDescription' =>
            'Permitir que o aplicativo use IA para sugestões de tradução',
          'settings.ai.llmProvider' => 'Provedor de Serviço LLM',
          'settings.ai.service' => 'Serviço',
          'settings.ai.serviceDescription' => 'Provedor para IA Generativa',
          'settings.ai.providerGemini' => 'Google Gemini',
          'settings.ai.providerOpenAI' => 'OpenAI',
          'settings.ai.geminiApiKey' => 'Chave de API do Gemini',
          'settings.ai.openAiApiKey' => 'Chave de API da OpenAI',
          'settings.ai.model' => 'Modelo',
          'settings.ai.modelDescription' => 'Selecione qual modelo usar',
          'settings.ai.advancedParameters' => 'Parâmetros Avançados',
          'settings.ai.parameters' => 'Parâmetros',
          'settings.ai.parametersDescription' => 'Temperatura, Contexto e mais',
          'settings.ai.temperature' => 'Temperatura',
          'settings.ai.temperatureDescription' =>
            'Valores mais altos tornam o resultado mais criativo',
          'settings.ai.maxTokens' => 'Máximo de Tokens',
          'settings.ai.maxTokensDescription' =>
            'Limitar o tamanho da janela de contexto',
          'settings.ai.systemContext' => 'Contexto do Sistema / Instruções',
          'settings.ai.systemContextHint' =>
            'Você é um profissional de localização. Mantenha o tom e a intenção da string de origem...',
          'settings.ai.systemContextHelper' =>
            'Forneça instruções específicas para a IA sobre o estilo e a terminologia do seu projeto.',
          'settings.ai.contextStrings' => 'Strings de Contexto',
          'settings.ai.contextStringsDescription' =>
            'Incluir strings circundantes para melhor contexto',
          'settings.ai.contextCount' => 'Contagem de Contexto',
          'settings.ai.contextCountDescription' =>
            'Número de strings circundantes a serem incluídas',
          'settings.ai.cloudServices' => 'Serviços de Tradução na Nuvem',
          'settings.ai.googleTranslateApiKey' =>
            'Chave de API do Google Translate',
          'settings.ai.deeplApiKey' => 'Chave de API do DeepL',
          'settings.ai.test' => 'Testar',
          'settings.ai.resetToGlobal' =>
            'Redefinir todas as configurações de IA para os padrões globais',
          'settings.integrations.platformNotice' => 'Aviso de Plataforma',
          'settings.integrations.platformNoticeDescription' =>
            'Integrações de sistema não estão disponíveis para esta plataforma.',
          'settings.integrations.visualEffects' => 'Efeitos Visuais',
          'settings.integrations.explorerIntegration' =>
            'Integração com Explorer',
          'settings.integrations.explorerIntegrationDescription' =>
            'Adicionar "Abrir com Localizer" ao menu de contexto do Windows Explorer para pastas.',
          'settings.integrations.addToContextMenu' =>
            'Adicionar ao Menu de Contexto',
          'settings.integrations.contextMenuAdded' =>
            'Menu de contexto adicionado!',
          'settings.integrations.contextMenuAddError' =>
            'Falha ao adicionar menu de contexto',
          'settings.integrations.contextMenuRemoved' =>
            'Menu de contexto removido!',
          'settings.integrations.contextMenuRemoveError' =>
            'Falha ao remover menu de contexto',
          'settings.integrations.fileAssociations' => 'Associações de Arquivos',
          'settings.integrations.fileAssociationsDescription' =>
            'Registrar tipos de arquivos para abrir com o Localizer ao clicar duas vezes no Explorer.',
          'settings.integrations.registered' => 'Registrado',
          'settings.integrations.notRegistered' => 'Não Registrado',
          'settings.integrations.extRegistered' => ({required Object ext}) =>
              '${ext} registrado!',
          'settings.integrations.extUnregistered' => ({required Object ext}) =>
              '${ext} desregistrado!',
          'settings.integrations.extError' => (
                  {required Object action, required Object ext}) =>
              'Falha ao ${action} ${ext}',
          'settings.integrations.registerAll' => 'Registrar Tudo',
          'settings.integrations.unregisterAll' => 'Desregistrar Tudo',
          'settings.integrations.registerAllResult' => (
                  {required Object success, required Object total}) =>
              'Registrados ${success} de ${total} tipos de arquivos',
          'settings.integrations.unregisterAllResult' => (
                  {required Object success, required Object total}) =>
              'Desregistrados ${success} de ${total} tipos de arquivos',
          'settings.integrations.protocolHandler' => 'Manipulador de Protocolo',
          'settings.integrations.protocolHandlerDescription' =>
            'Registrar URLs localizer:// para abrir este aplicativo. Permite abrir projetos diretamente de links do navegador ou outros apps.',
          'settings.integrations.protocolRegistered' =>
            'O manipulador de protocolo está registrado',
          'settings.integrations.protocolNotRegistered' =>
            'O manipulador de protocolo não está registrado',
          'settings.integrations.registerProtocol' => 'Registrar Protocolo',
          'settings.integrations.unregister' => 'Desregistrar',
          'settings.integrations.protocolRegisteredSuccess' =>
            'Manipulador de protocolo registrado!',
          'settings.integrations.protocolRemovedSuccess' =>
            'Manipulador de protocolo removido!',
          'settings.integrations.protocolRegisterError' => 'Falha ao registrar',
          'settings.integrations.protocolRemoveError' => 'Falha ao remover',
          'settings.integrations.windowMaterial' => 'Material da Janela',
          'settings.integrations.windowMaterialDescription' =>
            'Selecione o estilo de material vibrante do macOS',
          'settings.integrations.dockIntegration' => 'Integração com o Dock',
          'settings.integrations.showDockBadge' =>
            'Mostrar Contagem de Não Traduzidos',
          'settings.integrations.showDockBadgeDescription' =>
            'Exibir contagem de strings não traduzidas no badge do ícone do dock',
          'settings.integrations.materials.sidebar' => 'Barra lateral',
          'settings.integrations.materials.menu' => 'Menu',
          'settings.integrations.materials.popover' => 'Popover',
          'settings.integrations.materials.titlebar' => 'Barra de título',
          'settings.integrations.materials.underPageBackground' =>
            'Fundo da página',
          'settings.integrations.materials.contentBackground' => 'Conteúdo',
          'settings.integrations.fileTypes.loc' =>
            'Arquivo de Projeto Localizer',
          'settings.integrations.fileTypes.lang' => 'Arquivo de Idioma',
          'settings.integrations.fileTypes.json' =>
            'Arquivo de Localização JSON',
          'settings.integrations.fileTypes.xml' => 'Arquivo de Localização XML',
          'settings.developer.title' => 'Configurações de Desenvolvedor',
          'settings.developer.description' =>
            'Configurações avançadas para desenvolvedores',
          'settings.developer.showLocalizationKeys' =>
            'Mostrar Chaves de Localização',
          'settings.developer.localizationKeysDescription' =>
            'Quando ativado, todo o texto traduzido exibirá suas chaves de localização em vez do valor traduzido. Útil para verificar qual chave é usada onde.',
          'settings.developer.showPerformanceOverlay' =>
            'Mostrar Camada de Desempenho',
          'settings.developer.performanceOverlayDescription' =>
            'Exibir informações de FPS e tempo de quadro',
          'settings.developer.debugMode' => 'Modo de Depuração',
          'settings.developer.debugModeDescription' =>
            'Ativar registros adicionais e recursos de depuração',
          'settings.developer.debuggingTools' => 'Ferramentas de Depuração',
          'settings.developer.semanticsDebugger' => 'Depurador de Semântica',
          'settings.developer.semanticsDebuggerDescription' =>
            'Visualizar árvore de semântica',
          'settings.developer.materialGrid' => 'Grade de Material',
          'settings.developer.materialGridDescription' =>
            'Sobrepor grade de layout de material',
          'settings.developer.rasterCache' =>
            'Imagens de Cache de Rasterização',
          'settings.developer.rasterCacheDescription' =>
            'Verificar imagens de cache de rasterização',
          'settings.developer.actions' => 'Ações',
          'settings.developer.showLogs' => 'Mostrar Logs do App',
          'settings.developer.showLogsDescription' =>
            'Abrir o console de depuração Talker',
          'settings.developer.restartTutorial' =>
            'Reiniciar Tutorial de Onboarding',
          'settings.developer.restartTutorialDescription' =>
            'Redefinir flags e iniciar tutorial novamente',
          'settings.developer.restartRequested' =>
            'Reinicialização do tutorial solicitada.',
          'settings.developer.throwException' => 'Lançar Exceção de Teste',
          'settings.developer.throwExceptionDescription' =>
            'Acionar uma exceção de teste para relatório de falhas',
          'settings.developer.testExceptionMessage' =>
            'Exceção de teste acionada a partir das Opções de Desenvolvedor',
          'settings.developer.clearTM' => 'Limpar Memória de Tradução',
          'settings.developer.clearTMDescription' =>
            'Excluir todas as traduções em cache',
          'settings.developer.clearTMConfirmation' =>
            'Limpar Memória de Tradução?',
          'settings.developer.clearTMWarning' =>
            'Isso excluirá todas as traduções aprendidas. Esta ação não pode ser desfeita.',
          'settings.developer.tmCleared' => 'Memória de tradução limpa',
          'settings.developer.clearApiKeys' => 'Limpar Chaves de API',
          'settings.developer.clearApiKeysDescription' =>
            'Remover todas as chaves de API armazenadas',
          'settings.developer.clearApiKeysConfirmation' =>
            'Limpar Chaves de API?',
          'settings.developer.clearApiKeysWarning' =>
            'Isso removerá todas as chaves de API do armazenamento seguro.',
          'settings.developer.apiKeysCleared' => 'Chaves de API limpas',
          'settings.developer.hideOptions' => 'Ocultar Opções de Desenvolvedor',
          'settings.developer.hideOptionsDescription' =>
            'Desativar modo de desenvolvedor (requer 7 toques para reativar)',
          'settings.developer.optionsDisabled' =>
            'Opções de desenvolvedor desativadas',
          'settings.developer.dangerZone' => 'Zona de Perigo',
          'settings.developer.factoryReset' => 'Redefinição de Fábrica',
          'settings.developer.factoryResetDescription' =>
            'Redefinir todas as configurações e limpar dados',
          'settings.developer.factoryResetWarning' =>
            'Tem certeza de que deseja redefinir todas as configurações? Esta ação não pode ser desfeita.',
          'settings.developer.inspectionTools' => 'Ferramentas de Inspeção',
          'settings.developer.searchHint' => 'Pesquisar configurações...',
          'settings.developer.resetToDefault' => 'Redefinir para os padrões',
          'settings.developer.resetToGlobal' =>
            'Redefinir para o padrão global',
          'settings.developer.storageInspector' => 'Inspetor de Armazenamento',
          'settings.developer.storageInspectorDescription' =>
            'Ver conteúdos do Hive & Secure Storage',
          'settings.developer.deviceEnvironment' => 'Dispositivo & Ambiente',
          'settings.developer.deviceEnvironmentDescription' =>
            'Tela, plataforma e informações de build',
          'settings.developer.themePlayground' => 'Playground de Tema',
          'settings.developer.themePlaygroundDescription' =>
            'Paleta de cores & tipografia',
          'settings.developer.themePlaygroundSection.colors' => 'Cores',
          'settings.developer.themePlaygroundSection.typography' =>
            'Tipografia',
          'settings.developer.themePlaygroundSection.palette.primary' =>
            'Primária',
          'settings.developer.themePlaygroundSection.palette.onPrimary' =>
            'No Primária',
          'settings.developer.themePlaygroundSection.palette.secondary' =>
            'Secundária',
          'settings.developer.themePlaygroundSection.palette.onSecondary' =>
            'No Secundária',
          'settings.developer.themePlaygroundSection.palette.surface' =>
            'Superfície',
          'settings.developer.themePlaygroundSection.palette.onSurface' =>
            'Na Superfície',
          'settings.developer.themePlaygroundSection.palette.error' => 'Erro',
          'settings.developer.themePlaygroundSection.palette.onError' =>
            'No Erro',
          'settings.developer.themePlaygroundSection.palette.outline' =>
            'Contorno',
          'settings.developer.themePlaygroundSection.palette.shadow' =>
            'Sombra',
          'settings.developer.themePlaygroundSection.palette.success' =>
            'Sucesso',
          'settings.developer.themePlaygroundSection.palette.warning' =>
            'Aviso',
          'settings.developer.themePlaygroundSection.palette.info' =>
            'Informação',
          'settings.developer.localizationInspector' =>
            'Inspetor de Localização',
          'settings.developer.localizationInspectorDescription' =>
            'Depurar strings de tradução',
          'settings.developer.hiveAppSettings' => 'Hive (AppSettings)',
          'settings.developer.secureStorageMasked' =>
            'Secure Storage (Mascarado)',
          'settings.developer.featureFlags.title' => 'Recursos Experimentais',
          'settings.developer.featureFlags.description' =>
            'Alternar flags de recursos localmente para teste. Essas sobreposições persistem entre as reinicializações do app.',
          'settings.developer.featureFlags.subtitle' =>
            'Sobrescrever recursos experimentais',
          'settings.developer.featureFlags.flags.experimental_ai_batch.name' =>
            'Lote de IA Experimental',
          'settings.developer.featureFlags.flags.experimental_ai_batch.description' =>
            'Ativar tradução de IA em lote para várias linhas',
          'settings.developer.featureFlags.flags.new_diff_algorithm.name' =>
            'Novo Algoritmo de Diff',
          'settings.developer.featureFlags.flags.new_diff_algorithm.description' =>
            'Usar algoritmo de diff aprimorado para comparações',
          'settings.developer.featureFlags.flags.enhanced_search.name' =>
            'Pesquisa Aprimorada',
          'settings.developer.featureFlags.flags.enhanced_search.description' =>
            'Ativar pesquisa difusa (fuzzy search) em arquivos de tradução',
          'settings.developer.featureFlags.flags.auto_save.name' =>
            'Salvamento Automático',
          'settings.developer.featureFlags.flags.auto_save.description' =>
            'Salvar alterações automaticamente após as edições',
          'settings.developer.featureFlags.reset' => 'Redefinir Todas as Flags',
          'settings.developer.featureFlags.overrides' => 'Sobreposições Locais',
          'settings.developer.featureFlags.defaultVal' => 'Padrão',
          'settings.developer.featureFlags.on' => 'LIGADO',
          'settings.developer.featureFlags.off' => 'DESLIGADO',
          'settings.developer.storageInspectorSection.refresh' => 'Atualizar',
          'settings.developer.storageInspectorSection.hiveData' =>
            'Dados do Hive',
          'settings.developer.storageInspectorSection.secureStorage' =>
            'Secure Storage',
          'settings.developer.deviceInfoSection.refresh' => 'Atualizar',
          'settings.developer.deviceInfoSection.copy' =>
            'Copiar para Área de Transferência',
          'settings.developer.deviceInfoSection.computerName' =>
            'Nome do Computador',
          'settings.developer.deviceInfoSection.osVersion' => 'Versão do SO',
          'settings.developer.localizationInspectorSection.showKeys' =>
            'Mostrar Chaves em vez de Valores',
          'settings.developer.localizationInspectorSection.keysVisible' =>
            'Chaves visíveis',
          'settings.developer.localizationInspectorSection.normalDisplay' =>
            'Exibição normal',
          'settings.developer.localizationInspectorSection.note' =>
            'Nota: Este recurso requer que a localização do app use um wrapper que respeite esta configuração.',
          'settings.about.title' => 'Sobre',
          'settings.about.version' => 'Versão',
          'settings.about.buildNumber' => 'Número da Build',
          'settings.about.author' => 'Autor',
          _ => null,
        } ??
        switch (path) {
          'settings.about.license' => 'Licença',
          'settings.about.sourceCode' => 'Código Fonte',
          'settings.about.reportBug' => 'Relatar um Erro',
          'settings.about.requestFeature' => 'Solicitar um Recurso',
          'settings.about.checkForUpdates' => 'Verificar Atualizações',
          'settings.about.upToDate' => 'Você está atualizado!',
          'settings.about.updateAvailable' => ({required Object version}) =>
              'Atualização disponível: ${version}',
          'settings.about.updateAvailableBadge' => 'Atualização Disponível!',
          'settings.about.developerSteps' => ({required Object count}) =>
              'Você está a ${count} passos de ser um desenvolvedor.',
          'settings.about.developerActivated' =>
            'Você agora é um desenvolvedor!',
          'settings.about.neverChecked' => 'Nunca',
          'settings.about.applicationInfo' => 'Informações do Aplicativo',
          'settings.about.platform' => 'Plataforma',
          'settings.about.updateInformation' => 'Informações de Atualização',
          'settings.about.currentVersion' => 'Versão Atual',
          'settings.about.latestVersion' => 'Última Versão',
          'settings.about.lastChecked' => 'Última Verificação',
          'settings.about.checkingForUpdates' => 'Verificando...',
          'settings.about.whatsNew' => 'O que há de novo',
          'settings.about.systemInformation' => 'Informações do Sistema',
          'settings.about.dartVersion' => 'Versão do Dart',
          'settings.about.diskSpace' => 'Espaço em Disco Disponível',
          'settings.about.memoryUsage' => 'Uso de Memória',
          'settings.about.privacyTitle' => 'Privacidade & Telemetria',
          'settings.about.usageStats' => 'Estatísticas de Uso Anônimas',
          'settings.about.requiresFirebase' =>
            'Requer configuração do Firebase',
          'settings.about.featureUnavailable' =>
            'Recurso atualmente indisponível (Requer Firebase)',
          'settings.about.settingsManagement' =>
            'Gerenciamento de Configurações',
          'settings.about.settingsManagementDescription' =>
            'Exporte suas configurações para um arquivo para fazer backup ou compartilhar com outras máquinas.',
          'settings.about.resetAll' => 'Redefinir Tudo',
          'settings.about.links' => 'Links',
          'settings.about.githubRepo' => 'Repositório GitHub',
          'settings.about.privacyPolicy' => 'Política de Privacidade',
          'settings.about.crashReporting' => 'Relatório de Falhas',
          'settings.onboarding.skipTutorial' => 'Pular Tutorial',
          'settings.onboarding.gettingStarted' => 'Primeiros Passos',
          'settings.onboarding.stepProgress' => (
                  {required Object current, required Object total}) =>
              '${current} de ${total}',
          'settings.onboarding.loadSampleData' => 'Carregar Dados de Exemplo',
          'settings.onboarding.steps.importFiles.title' => 'Importar Arquivos',
          'settings.onboarding.steps.importFiles.description' =>
            'Carregar arquivos de origem e destino',
          'settings.onboarding.steps.runComparison.title' =>
            'Executar Comparação',
          'settings.onboarding.steps.runComparison.description' =>
            'Clique em "Comparar Arquivos"',
          'settings.onboarding.steps.reviewMissing.title' =>
            'Revisar Chaves Ausentes',
          'settings.onboarding.steps.reviewMissing.description' =>
            'Observe os itens FALTANDO em vermelho',
          'settings.onboarding.steps.useFilters.title' => 'Usar Filtros',
          'settings.onboarding.steps.useFilters.description' =>
            'Filtrar por tipo',
          'settings.onboarding.steps.searchResults.title' =>
            'Resultados da Pesquisa',
          'settings.onboarding.steps.searchResults.description' =>
            'Encontrar chaves específicas',
          'settings.onboarding.steps.advancedView.title' =>
            'Visualização Avançada',
          'settings.onboarding.steps.advancedView.description' =>
            'Explore análises detalhadas',
          'settings.onboarding.steps.editCell.title' => 'Editar uma Célula',
          'settings.onboarding.steps.editCell.description' =>
            'Clique para editar um valor',
          'settings.onboarding.steps.exportResults.title' => 'Exportar',
          'settings.onboarding.steps.exportResults.description' =>
            'Salve seu relatório',
          'settings.settingsView.resetCategoryTitle' =>
            ({required Object category}) => 'Redefinir ${category}?',
          'settings.settingsView.resetCategoryContent' =>
            'Isto redefinirá todas as configurações nesta categoria para seus valores padrão.',
          'settings.settingsView.resetAllTitle' =>
            'Redefinir Todas as Configurações?',
          'settings.settingsView.resetAllContent' =>
            'Isto redefinirá permanentemente todas as configurações para seus padrões de fábrica. Esta ação não pode ser desfeita.',
          'settings.settingsView.resetAll' => 'Redefinir Tudo',
          'settings.settingsView.resetSuccess' => (
                  {required Object category}) =>
              '${category} redefinido para os padrões',
          'settings.settingsView.errorLoading' =>
            'Erro ao carregar configurações',
          'settings.settingsView.settingsSaved' => 'Configurações salvas',
          'settings.settingsView.updateAvailable' => (
                  {required Object version}) =>
              'Atualização disponível: v${version}',
          'settings.settingsView.latestVersion' =>
            'Você está usando a última versão',
          'settings.settingsView.whatsNew' => ({required Object version}) =>
              'O que há de novo na v${version}',
          'settings.settingsView.downloadUpdate' => 'Baixar Atualização',
          'settings.settingsView.exportSettings' => 'Exportar Configurações',
          'settings.settingsView.settingsExported' =>
            'Configurações exportadas',
          'settings.settingsView.exportFail' => ({required Object error}) =>
              'Falha ao exportar configurações: ${error}',
          'settings.settingsView.importSettings' => 'Importar Configurações',
          'settings.settingsView.importTitle' => 'Importar Configurações?',
          'settings.settingsView.importContent' =>
            'Isto substituirá todas as suas configurações atuais pelas importadas. Esta ação não pode ser desfeita.',
          'settings.settingsView.importSuccess' =>
            'Configurações importadas com sucesso!',
          'settings.settingsView.importFail' => ({required Object error}) =>
              'Falha ao importar configurações: ${error}',
          'settings.settingsView.invalidFormat' =>
            'Formato de arquivo de configurações inválido',
          'settings.settingsView.categories.general' => 'Configurações Gerais',
          'settings.settingsView.categories.comparisonEngine' =>
            'Mecanismo de Comparação',
          'settings.settingsView.categories.appearance' => 'Aparência',
          'settings.settingsView.categories.fileHandling' =>
            'Manipulação de Arquivos',
          'settings.settingsView.categories.aiServices' => 'Serviços de IA',
          'settings.settingsView.categories.systemIntegrations' =>
            'Integrações de Sistema',
          'settings.settingsView.categories.projectResources' =>
            'Recursos do Projeto (Glossário & TM)',
          'settings.settingsView.categories.developer' =>
            'Opções de Desenvolvedor',
          'settings.settingsView.categories.about' => 'Sobre',
          'settings.settingsView.categoryLabels.general' => 'Geral',
          'settings.settingsView.categoryLabels.comparisonEngine' =>
            'Comparação',
          'settings.settingsView.categoryLabels.appearance' => 'Aparência',
          'settings.settingsView.categoryLabels.fileHandling' =>
            'Manipulação de Arquivos',
          'settings.settingsView.categoryLabels.aiServices' => 'Serviços de IA',
          'settings.settingsView.categoryLabels.systemIntegrations' =>
            'Integrações de Sistema',
          'settings.settingsView.categoryLabels.projectResources' =>
            'Recursos do Projeto',
          'settings.settingsView.categoryLabels.developer' =>
            'Opções de Desenvolvedor',
          'settings.settingsView.categoryLabels.about' => 'Sobre',
          'fileComparison.title' => 'Comparação de Arquivos',
          'fileComparison.openFiles' => 'Abrir Arquivos',
          'fileComparison.exportResults' => 'Exportar Resultados',
          'fileComparison.restartTutorial' => 'Reiniciar Tutorial',
          'fileComparison.restartTutorialDevOnly' =>
            'A reinicialização do tutorial está disponível apenas no modo de desenvolvedor.',
          'fileComparison.unsupportedFileType' =>
            'Tipo de arquivo não suportado.',
          'fileComparison.unsupportedFileTypeSuggestion' =>
            'Por favor, selecione um arquivo de localização suportado.',
          'fileComparison.someFilesUnsupported' =>
            'Alguns arquivos não são suportados.',
          'fileComparison.pickSupportedFiles' =>
            'Escolha apenas arquivos de localização suportados.',
          'fileComparison.pickTwoFiles' =>
            'Escolha dois arquivos para comparar.',
          'fileComparison.pickBilingualFile' =>
            'Por favor, selecione um arquivo bilíngue para comparar.',
          'fileComparison.noResultsToExport' =>
            'Nenhum resultado para exportar ainda.',
          'fileComparison.performComparisonFirst' =>
            'Realize uma comparação primeiro para exportar os resultados.',
          'fileComparison.performComparisonFirstEditor' =>
            'Por favor, realize uma comparação primeiro para ver os detalhes avançados.',
          'fileComparison.sampleDataLoaded' =>
            'Dados de exemplo carregados com sucesso',
          'fileComparison.loadSampleDataError' => ({required Object error}) =>
              'Falha ao carregar dados de exemplo: ${error}',
          'fileComparison.invalidFileType' => 'Tipo de arquivo inválido.',
          'fileComparison.fileSelected' => (
                  {required Object label, required Object fileName}) =>
              '${label} selecionado: ${fileName}',
          'fileComparison.sourceFile' => 'Arquivo de origem',
          'fileComparison.targetFile' => 'Arquivo de destino',
          'fileComparison.bilingualFile' => 'Arquivo bilíngue',
          'fileComparison.compareFiles' => 'Comparar Arquivos',
          'fileComparison.compareFile' => 'Comparar Arquivo',
          'fileComparison.bilingualMode' => 'Modo Bilíngue',
          'fileComparison.twoFilesMode' => 'Dois Arquivos',
          'fileComparison.processing' => 'Processando...',
          'fileComparison.remaining' => ({required Object time}) =>
              '${time} restante',
          'fileComparison.comparisonInProgress' => 'Comparação em andamento...',
          'fileComparison.comparisonFailed' => ({required Object error}) =>
              'Falha na Comparação: ${error}',
          'fileComparison.fileChanged' => ({required Object fileName}) =>
              'Arquivo alterado: ${fileName}. Recomparando...',
          'fileComparison.dropFileHere' => 'Solte o arquivo aqui',
          'fileComparison.dropFileOrBrowse' =>
            'Solte o arquivo ou clique para procurar',
          'fileComparison.fileUpload' => 'Upload de arquivo',
          'fileComparison.changeFile' => 'Alterar arquivo',
          'fileComparison.total' => 'Total',
          'fileComparison.show' => 'Mostrar',
          'fileComparison.showAll' => 'Mostrar Tudo',
          'fileComparison.noMatches' => ({required Object query}) =>
              'Nenhum resultado encontrado para "${query}"',
          'fileComparison.showingEntries' => (
                  {required Object count, required Object total}) =>
              'Mostrando ${count} de ${total} entradas',
          'fileComparison.filesIdentical' => 'Os arquivos são idênticos.',
          'fileComparison.hiddenIdentical' => ({required Object count}) =>
              '${count} entradas idênticas ocultas',
          'fileComparison.showIdentical' => 'Mostrar Entradas Idênticas',
          'fileComparison.hideIdentical' => 'Ocultar entradas idênticas',
          'fileComparison.noDiff' =>
            'Nenhuma diferença encontrada com base nas chaves.',
          'fileComparison.source' => 'Origem',
          'fileComparison.target' => 'Destino',
          'fileComparison.value' => 'Valor',
          'fileComparison.readyToCompare' => 'Pronto para Comparar Arquivos',
          'fileComparison.readyToCompareDesc' =>
            'Solte arquivos de localização acima ou use os botões de procurar\npara selecionar arquivos para comparação.',
          'fileComparison.recentComparisons' => 'Comparações Recentes',
          'fileComparison.bilingualFileLabel' => ({required Object name}) =>
              'Arquivo bilíngue: ${name}',
          'fileComparison.comparisonLabel' => (
                  {required Object source, required Object target}) =>
              '${source} ↔ ${target}',
          'fileComparison.fileNotExist' =>
            'Um ou ambos os arquivos desta sessão não existem mais.',
          'fileComparison.largeFileTitle' => 'Arquivo Grande Detectado',
          'fileComparison.largeFileContent' => ({required Object count}) =>
              'O resultado da comparação contém ${count} entradas.\nExibi-las todas pode causar problemas de desempenho.\n\nDeseja continuar?',
          'fileComparison.dontShowAgain' =>
            'Não mostrar novamente para este arquivo',
          'fileComparison.proceed' => 'Continuar',
          'fileComparison.exportReport' => ({required Object format}) =>
              'Salvar Relatório ${format}',
          'fileComparison.saved' => ({required Object format}) =>
              '${format} salvo',
          'fileComparison.saveError' => ({required Object format}) =>
              'Falha ao salvar o arquivo ${format}.',
          'fileComparison.saveErrorDetailed' => (
                  {required Object format, required Object error}) =>
              'Falha ao salvar ${format}: ${error}',
          'fileComparison.watching' => 'Monitorando',
          'fileComparison.watchOff' => 'Monitoramento Desligado',
          'fileComparison.watchingTooltip' => ({required Object status}) =>
              'Monitoramento de Arquivos: ${status}\nRecomparar automaticamente quando os arquivos mudarem no disco',
          'fileComparison.aiSettingsNotAvailable' =>
            'Navegação para Configurações de IA não disponível',
          'directoryComparison.title' => 'Comparação de Diretórios',
          'directoryComparison.sourceDirectory' => 'Diretório de Origem',
          'directoryComparison.targetDirectory' => 'Diretório de Destino',
          'directoryComparison.sourceSubtitle' =>
            'Arquivos originais/referência',
          'directoryComparison.targetSubtitle' =>
            'Arquivos de tradução/comparação',
          'directoryComparison.selectBothDirectories' =>
            'Por favor, selecione os diretórios de origem e destino.',
          'directoryComparison.selectSourceFolder' =>
            'Selecionar Pasta de Origem',
          'directoryComparison.selectTargetFolder' =>
            'Selecionar Pasta de Destino',
          'directoryComparison.dropFolderHere' =>
            'Solte a pasta aqui ou procure...',
          'directoryComparison.folderPath' => 'Caminho da Pasta',
          'directoryComparison.readyToCompare' =>
            'Pronto para Comparar Diretórios',
          'directoryComparison.readyToCompareDesc' =>
            'Solte pastas acima ou use os botões de procurar\npara selecionar diretórios para comparação.',
          'directoryComparison.nestedFolders' => 'Pastas aninhadas',
          'directoryComparison.nestedFoldersTooltip' =>
            'Compara recursivamente todos os diretórios aninhados',
          'directoryComparison.fileMatching' => 'Correspondência de arquivos',
          'directoryComparison.fileMatchingTooltip' =>
            'Emparelha automaticamente arquivos pelo nome',
          'directoryComparison.bulkExport' => 'Exportação em massa',
          'directoryComparison.bulkExportTooltip' =>
            'Exportar todos os resultados da comparação de uma vez',
          'directoryComparison.notDirectoryComparison' =>
            'Isto não é uma comparação de diretório.',
          'directoryComparison.directoriesNotExist' =>
            'Um ou ambos os diretórios não existem mais.',
          'directoryComparison.errorOccurred' => 'Ocorreu um erro',
          'directoryComparison.noFilesFound' =>
            'Nenhum arquivo encontrado nos diretórios selecionados.',
          'directoryComparison.unmatchedSourceFiles' =>
            'Arquivos de Origem não Correspondidos',
          'directoryComparison.unmatchedTargetFiles' =>
            'Arquivos de Destino não Correspondidos',
          'directoryComparison.filePairs' => ({required Object count}) =>
              '${count} pares de arquivos',
          'directoryComparison.pairedFiles' => ({required Object count}) =>
              'Arquivos Emparelhados (${count})',
          'directoryComparison.view' => 'Ver',
          'directoryComparison.failed' => 'Falhou',
          'directoryComparison.pair' => 'Parear...',
          'directoryComparison.pairDialogTitle' => ({required Object name}) =>
              'Parear "${name}" com:',
          'directoryComparison.discoverFiles' => 'Descobrir Arquivos',
          'directoryComparison.compareAll' => 'Comparar Tudo',
          'directoryComparison.exportAll' => 'Exportar Tudo',
          'directoryComparison.comparisonStarted' => 'Comparação iniciada...',
          'directoryComparison.discoveringFiles' => 'Descobrindo arquivos...',
          'directoryComparison.noResultsToExport' =>
            'Nenhum resultado de comparação para exportar. Execute "Comparar Tudo" primeiro.',
          'directoryComparison.selectExportFolder' =>
            'Selecionar Pasta de Exportação',
          'directoryComparison.createExportFolderError' => (
                  {required Object error}) =>
              'Falha ao criar pasta de exportação: ${error}',
          'directoryComparison.exportingResults' => 'Exportando Resultados',
          'directoryComparison.processingFile' => ({required Object file}) =>
              'Processando: ${file}',
          'directoryComparison.exportProgress' => (
                  {required Object current, required Object total}) =>
              '${current} de ${total} arquivos exportados',
          'directoryComparison.exportComplete' => 'Exportação Concluída',
          'directoryComparison.exportSuccessMessage' => (
                  {required Object count}) =>
              'Exportados com sucesso ${count} arquivos de comparação mais o resumo.',
          'directoryComparison.exportFailed' => ({required Object error}) =>
              'Exportação falhou: ${error}',
          'directoryComparison.close' => 'Fechar',
          'gitComparison._translatorNote' =>
            'Termos Git (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) devem permanecer em Inglês para todas as traduções a fim de evitar confusão entre desenvolvedores.',
          'gitComparison.title' => 'Comparação de Repositório',
          'gitComparison.repoSelector' => 'Criar / Abrir Repositório',
          'gitComparison.noRepoSelected' => 'Nenhum repositório selecionado',
          'gitComparison.open' => 'Abrir',
          'gitComparison.refreshCommits' => 'Atualizar Commits',
          'gitComparison.noCommits' =>
            'Nenhum commit encontrado ou carregado. Selecione uma branch para carregar os commits.',
          'gitComparison.baseCommit' => 'Commit Base (Mais Antigo)',
          'gitComparison.targetCommit' => 'Commit de Destino (Mais Recente)',
          'gitComparison.filterCommitsByBranch' => 'Filtrar Commits por Branch',
          'gitComparison.conflictDetection' => 'Detecção de conflitos',
          'gitComparison.conflictDetectionTooltip' =>
            'Detectar e resolver conflitos de merge',
          'gitComparison.actions' => 'Ações:',
          'gitComparison.checkout' => 'Checkout',
          'gitComparison.merge' => 'Merge',
          'gitComparison.pull' => 'Pull',
          'gitComparison.checkoutBranch' => 'Checkout Branch',
          'gitComparison.mergeBranch' => 'Fazer Merge da Branch na Atual',
          'gitComparison.mergeConfirmation' => ({required Object branch}) =>
              'Fazer merge de ${branch}?',
          'gitComparison.mergeWarning' =>
            'Isso fará o merge das alterações na sua branch atual. Conflitos podem ocorrer.',
          'gitComparison.selectExportFolder' =>
            'Selecionar Pasta de Exportação',
          'gitComparison.createExportFolderError' => (
                  {required Object error}) =>
              'Falha ao criar pasta de exportação: ${error}',
          'gitComparison.exportingFiles' => 'Exportando Arquivos',
          'gitComparison.processingFile' => ({required Object file}) =>
              'Processando: ${file}',
          'gitComparison.exportProgress' => (
                  {required Object current, required Object total}) =>
              '${current} de ${total} arquivos exportados',
          'gitComparison.exportComplete' => 'Exportação Concluída',
          'gitComparison.exportSuccessMessage' => ({required Object count}) =>
              'Exportados com sucesso ${count} arquivos com conteúdo completo.',
          'gitComparison.exportDetail' =>
            'O diff de cada arquivo é salvo na subpasta "files".',
          'gitComparison.diffViewer' => 'Visualizador de Diff',
          'gitComparison.base' => 'BASE',
          'gitComparison.target' => 'DESTINO',
          'gitComparison.noLines' => 'Nenhuma linha para exibir',
          'gitComparison.searchFiles' => 'Pesquisar arquivos...',
          'gitComparison.noFilesMatch' => ({required Object query}) =>
              'Nenhum arquivo corresponde a "${query}"',
          'gitComparison.filesCount' => ({required Object count}) =>
              '${count} arquivos',
          'gitComparison.selectBaseFile' => 'Selecionar Arquivo Base',
          'gitComparison.selectTargetFile' => 'Selecionar Arquivo de Destino',
          'gitComparison.comparisonResults' => 'Resultados da Comparação',
          'gitComparison.noChanges' =>
            'Nenhuma alteração encontrada entre as referências selecionadas.',
          'gitComparison.linesAdded' => 'Linhas Adicionadas',
          'gitComparison.linesRemoved' => 'Linhas Removidas',
          'gitComparison.commit' => 'Commit',
          'gitComparison.branch' => 'Branch',
          'gitComparison.noRepositorySelected' =>
            'Nenhum repositório selecionado',
          'gitComparison.notGitComparison' => 'Não é uma comparação Git',
          'gitComparison.repositoryNotExist' => 'Repositório não existe',
          'gitComparison.mainBranch' => 'main',
          'gitComparison.masterBranch' => 'master',
          'gitComparison.backToControls' =>
            'Voltar aos controles de comparação',
          'advancedComparison.placeholder' =>
            'Visualização de Comparação Avançada - Espaço Reservado',
          'advancedDiff.saveAllChanges' => 'Salvar Todas as Alterações?',
          'advancedDiff.saveConfirmation' => ({required Object count}) =>
              'Isso salvará todas as ${count} entradas modificadas no arquivo de destino. Esta ação não pode ser desfeita.',
          'advancedDiff.changesSaved' => 'Alterações salvas com sucesso.',
          'advancedDiff.csvExported' => 'CSV exportado',
          'advancedDiff.unsavedChanges' => 'Alterações Não Salvas',
          'advancedDiff.unsavedChangesWarning' =>
            'Você tem alterações não salvas. Tem certeza de que deseja descartá-las?',
          'advancedDiff.discardChanges' => 'Descartar Alterações',
          'advancedDiff.goBack' => 'Voltar',
          'advancedDiff.breadcrumbs' => 'Início  >  Editor',
          'advancedDiff.unsaved' => ({required Object count}) =>
              '${count} não salvas',
          'advancedDiff.reviewed' => ({required Object count}) =>
              '${count} revisadas',
          'advancedDiff.saveAll' => ({required Object count}) =>
              'Salvar Tudo (${count})',
          'advancedDiff.allSaved' => 'Tudo Salvo',
          'advancedDiff.saveAllTooltip' =>
            'Salvar Todas as Alterações (Ctrl+S)',
          'advancedDiff.exportTooltip' => 'Exportar Dados (Ctrl+E)',
          'advancedDiff.aiSuggestion.aiTranslation' => 'Tradução por IA',
          'advancedDiff.aiSuggestion.aiRephrase' => 'Refrasear por IA',
          'advancedDiff.aiSuggestion.key' => ({required Object key}) =>
              'Chave: ${key}',
          'advancedDiff.aiSuggestion.original' => 'Original:',
          'advancedDiff.aiSuggestion.suggestion' => 'Sugestão:',
          'advancedDiff.aiSuggestion.confidence' => 'Confiança da IA',
          'advancedDiff.aiSuggestion.cancelEdit' => 'Cancelar edição',
          'advancedDiff.aiSuggestion.editSuggestion' => 'Editar sugestão',
          'advancedDiff.aiSuggestion.alternatives' => 'Alternativas:',
          'advancedDiff.aiSuggestion.accept' => 'Aceitar',
          'advancedDiff.aiSuggestion.reject' => 'Rejeitar',
          'advancedDiff.aiSuggestion.stop' => 'Parar',
          'advancedDiff.detailEdit.title' => ({required Object key}) =>
              'Editar: ${key}',
          'advancedDiff.detailEdit.sourceLabel' => 'ORIGEM (Original)',
          'advancedDiff.detailEdit.targetLabel' => 'DESTINO (Tradução)',
          'advancedDiff.detailEdit.translateWithCloud' => 'Traduzir com Nuvem',
          'advancedDiff.detailEdit.translateWithAi' => 'Traduzir com IA',
          'advancedDiff.detailEdit.translating' => 'Traduzindo...',
          'advancedDiff.detailEdit.applyAndTm' => 'Aplicar',
          'advancedDiff.detailEdit.entryApplied' =>
            'Entrada aplicada & adicionada à TM',
          'advancedDiff.detailEdit.translationAdded' =>
            'Sugestão de tradução adicionada.',
          'advancedDiff.detailEdit.aiSuggestionAdded' =>
            'Sugestão de IA adicionada.',
          'advancedDiff.table.addedToTM' => 'Adicionado à Memória de Tradução',
          'advancedDiff.table.markedReviewed' => 'Marcado como revisado ✓',
          'advancedDiff.table.unmarkedReview' => 'Revisão desmarcada',
          'advancedDiff.table.reverted' => 'Revertido para o valor de origem',
          'advancedDiff.table.entryDeleted' => 'Entrada excluída',
          'advancedDiff.table.noSourceText' =>
            'Nenhum texto de origem para traduzir.',
          'advancedDiff.table.aiTranslationFailed' => ({required Object key}) =>
              'Tradução por IA falhou para "${key}"',
          'advancedDiff.table.noTargetText' =>
            'Nenhum texto de destino para refrasear.',
          'advancedDiff.table.aiRephraseFailed' => ({required Object key}) =>
              'Refraseamento por IA falhou para "${key}"',
          'advancedDiff.table.checkRowsFirst' =>
            'Marque as linhas usando as caixas de seleção primeiro',
          'advancedDiff.table.markedRowsReviewed' => (
                  {required Object count}) =>
              'Marcadas ${count} linhas como revisadas',
          'advancedDiff.table.revertedRows' => ({required Object count}) =>
              'Revertidas ${count} linhas',
          'advancedDiff.table.entriesCount' => ({required Object count}) =>
              '${count} entradas',
          'advancedDiff.table.markSelectedReviewed' =>
            'Marcar Selecionadas como Revisadas',
          'advancedDiff.table.revertSelected' => 'Reverter Selecionadas',
          'advancedDiff.table.noDifferences' => 'Nenhuma diferença encontrada',
          'advancedDiff.table.adjustFilters' => 'Tente ajustar seus filtros',
          'advancedDiff.table.cloudTranslationApplied' =>
            'Tradução na nuvem aplicada.',
          'advancedDiff.table.aiTranslationApplied' =>
            'Tradução por IA aplicada.',
          'advancedDiff.table.suggestionApplied' => 'Sugestão aplicada.',
          'advancedDiff.table.aiSuggestionApplied' =>
            'Sugestão de IA aplicada.',
          'advancedDiff.table.rephraseApplied' => 'Refraseamento aplicado.',
          'advancedDiff.table.aiRephraseApplied' =>
            'Refraseamento por IA aplicado.',
          'advancedDiff.table.rephrase' => 'Refrasear',
          'advancedDiff.table.aiRephrase' => 'Refrasear por IA',
          'advancedDiff.table.targetClickToEdit' =>
            'DESTINO (Clique para editar)',
          'advancedDiff.table.targetClickForDialog' =>
            'DESTINO (Clique para diálogo)',
          'advancedDiff.table.emptyClickToEdit' =>
            '(Vazio - Clique para editar)',
          'advancedDiff.table.unmarkReviewed' => 'Desmarcar revisado',
          'advancedDiff.table.markReviewed' => 'Marcar como revisado',
          'advancedDiff.table.revertToSource' => 'Reverter para origem',
          'advancedDiff.table.translateWithCloud' => 'Traduzir com Nuvem',
          'advancedDiff.table.translateWithAi' => 'Traduzir com IA',
          'advancedDiff.table.rephraseWithAi' => 'Refrasear com IA',
          'advancedDiff.table.moreActions' => 'Mais ações',
          'advancedDiff.table.editDetails' => 'Editar detalhes',
          'advancedDiff.table.suggestTranslation' => 'Sugerir tradução',
          'advancedDiff.table.addToTm' => 'Adicionar à TM',
          'advancedDiff.table.deleteEntry' => 'Excluir entrada',
          'advancedDiff.diffRow.copySource' => 'Copiar texto de origem',
          'advancedDiff.diffRow.actions' => 'Ações',
          'advancedDiff.status.added' => 'ADICIONADO',
          'advancedDiff.status.missing' => 'AUSENTE',
          'advancedDiff.status.changed' => ({required Object percent}) =>
              'ALT ${percent}%',
          'advancedDiff.status.same' => 'IGUAL',
          'advancedDiff.sidebar.widgets' => 'Widgets',
          'advancedDiff.sidebar.searchPlaceholder' =>
            'Pesquisar chaves & valores... (Ctrl+F)',
          'advancedDiff.sidebar.fuzzySearchTooltip' =>
            'Pesquisa Difusa (tolerante a erros)',
          'advancedDiff.sidebar.regexSearchTooltip' => 'Pesquisa Regex',
          'advancedDiff.sidebar.cloudTranslation' => 'Tradução na Nuvem',
          'advancedDiff.sidebar.aiTranslation' => 'Tradução por IA',
          'advancedDiff.sidebar.status' => 'Status',
          'advancedDiff.sidebar.tm' => 'Memória de Tradução',
          'advancedDiff.sidebar.filters' => 'Filtros',
          'advancedDiff.sidebar.actions' => 'Ações',
          'advancedDiff.sidebar.similarity' => 'Similaridade',
          'advancedDiff.sidebar.actionsSection.exportMatches' =>
            'Exportar correspondências',
          'advancedDiff.sidebar.actionsSection.preview' => 'Visualizar',
          'advancedDiff.sidebar.actionsSection.fillFromTmTitle' =>
            'Preencher a partir da Memória de Tradução?',
          'advancedDiff.sidebar.actionsSection.fillFromTmContent' =>
            'Isso tentará preencher os valores de destino vazios usando correspondências da Memória de Tradução. Os valores existentes NÃO serão sobrescritos.',
          'advancedDiff.sidebar.actionsSection.fill' => 'Preencher',
          'advancedDiff.sidebar.actionsSection.fillFromMemory' =>
            'Preencher da Memória',
          'advancedDiff.sidebar.actionsSection.filledFromTm' => (
                  {required Object count}) =>
              'Preenchidos ${count} itens da Memória de Tradução.',
          'advancedDiff.sidebar.aiSection.infoCloud' =>
            'Usa tradução na nuvem para traduzir valores de destino vazios a partir da origem.',
          'advancedDiff.sidebar.aiSection.infoAi' =>
            'Usa IA para traduzir valores de destino vazios a partir da origem.',
          'advancedDiff.sidebar.aiSection.translationSettings' =>
            'Configurações de Tradução',
          'advancedDiff.sidebar.aiSection.aiSettings' => 'Configurações de IA',
          'advancedDiff.sidebar.aiSection.source' => 'Origem',
          'advancedDiff.sidebar.aiSection.target' => 'Destino',
          'advancedDiff.sidebar.aiSection.translatingProgress' =>
            ({required Object percent}) => 'Traduzindo... ${percent}%',
          'advancedDiff.sidebar.aiSection.translating' => 'Traduzindo...',
          'advancedDiff.sidebar.aiSection.translateAllMissing' =>
            'Traduzir Todos os Ausentes',
          'advancedDiff.sidebar.aiSection.translateAllTitle' =>
            'Traduzir Todos os Ausentes?',
          'advancedDiff.sidebar.aiSection.translateAllContent' => (
                  {required Object service,
                  required Object source,
                  required Object target}) =>
              'Isso usará ${service} para traduzir todas as entradas com valores de destino vazios de ${source} para ${target}.\n\nVocê pode revisar cada sugestão ou aplicar todas de uma vez.',
          'advancedDiff.sidebar.aiSection.translateAll' => 'Traduzir Tudo',
          'advancedDiff.sidebar.aiSection.reviewEach' => 'Revisar Cada',
          'advancedDiff.sidebar.aiSection.cloudTranslated' => (
                  {required Object count}) =>
              'Traduzidas ${count} entradas com tradução na nuvem.',
          'advancedDiff.sidebar.aiSection.aiTranslated' =>
            ({required Object count}) => 'Traduzidas ${count} entradas com IA.',
          'advancedDiff.sidebar.aiSection.aiTranslateFailed' =>
            'Falha ao traduzir tudo por IA',
          'advancedDiff.sidebar.aiSection.noMissingEntries' =>
            'Nenhuma entrada ausente para traduzir.',
          'advancedDiff.sidebar.aiSection.skip' => 'Pular',
          'advancedDiff.sidebar.aiSection.stop' => 'Parar',
          'advancedDiff.sidebar.aiSection.cloudApplied' =>
            ({required Object count}) => 'Aplicadas ${count} sugestões.',
          'advancedDiff.sidebar.aiSection.aiApplied' =>
            ({required Object count}) => 'Aplicadas ${count} sugestões de IA.',
          'advancedDiff.sidebar.tmSection.enableTmFill' =>
            'Ativar Preenchimento por TM',
          'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' =>
            'Aplicar automaticamente acima do mínimo',
          'advancedDiff.sidebar.tmSection.matchSettings' =>
            'Configurações de Correspondência',
          'advancedDiff.sidebar.tmSection.minMatch' => 'Correspondência mín.:',
          'advancedDiff.sidebar.tmSection.limit' => 'Limite:',
          'advancedDiff.sidebar.tmSection.exact' => 'Exata',
          'advancedDiff.sidebar.filtersSection.viewFilters' =>
            'Filtros de Visualização',
          'advancedDiff.sidebar.filtersSection.showAll' => 'Mostrar Tudo',
          'advancedDiff.sidebar.filtersSection.added' => 'Adicionado',
          'advancedDiff.sidebar.filtersSection.removed' => 'Removido',
          'advancedDiff.sidebar.filtersSection.modified' => 'Modificado',
          'advancedDiff.sidebar.filtersSection.actionScope' => 'Escopo da Ação',
          'advancedDiff.sidebar.filtersSection.applyToAdded' =>
            'Aplicar aos Adicionados',
          'advancedDiff.sidebar.filtersSection.applyToModified' =>
            'Aplicar aos Modificados',
          'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' =>
            'Apenas preencher destinos vazios',
          'advancedDiff.sidebar.filtersSection.limitToVisible' =>
            'Limitar ao visível',
          'advancedDiff.sidebar.filtersSection.editMode' => 'Modo de Edição',
          'advancedDiff.sidebar.filtersSection.dialog' => 'Diálogo',
          'advancedDiff.sidebar.filtersSection.inline' => 'Em linha',
          'advancedDiff.sidebar.similaritySection.currentFilter' =>
            'Filtro Atual:',
          'advancedDiff.sidebar.similaritySection.any' => 'QUALQUER',
          'advancedDiff.sidebar.similaritySection.high' => 'ALTA',
          'advancedDiff.sidebar.similaritySection.medium' => 'MÉDIA',
          'advancedDiff.sidebar.similaritySection.low' => 'BAIXA',
          'advancedDiff.sidebar.statusSection.total' =>
            ({required Object count}) => '${count} total',
          'advancedDiff.sidebar.statusSection.extra' =>
            ({required Object count}) => '${count} extras',
          'advancedDiff.sidebar.statusSection.missing' =>
            ({required Object count}) => '${count} ausentes',
          'advancedDiff.sidebar.statusSection.changed' =>
            ({required Object count}) => '${count} alterados',
          'issueDetails.title' => 'Detalhes do Problema',
          'issueDetails.showingIssues' => (
                  {required Object count, required Object total}) =>
              'Mostrando ${count} de ${total} problemas',
          'issueDetails.searchPlaceholder' =>
            'Pesquisar por chave, texto ou erro...',
          'issueDetails.noDetails' => 'Nenhum detalhe disponível.',
          'issueDetails.noMatches' => 'Nenhuma correspondência encontrada.',
          'issueDetails.showMore' => 'Mostrar Mais',
          'issueDetails.copyItems' => ({required Object count}) =>
              'Copiar ${count} Itens',
          'issueDetails.close' => 'Fechar',
          'issueDetails.copied' => 'Copiado para a área de transferência',
          'issueDetails.copiedCount' => ({required Object count}) =>
              'Copiados ${count} itens',
          'issueDetails.duplicateValue.label' => 'TRADUÇÃO REPETIDA',
          'issueDetails.duplicateValue.warning' =>
            'Diferentes textos de origem usam esta mesma tradução. Verifique o contexto.',
          'issueDetails.duplicateValue.affectedKeys' =>
            ({required Object count}) => 'CHAVES AFETADAS (${count})',
          'issueDetails.duplicateValue.identicalSources' => 'Origens Idênticas',
          'issueDetails.duplicateValue.moreKeys' => ({required Object count}) =>
              '+${count} mais chaves',
          'issueDetails.lengthOutlier.source' => 'ORIGEM',
          'issueDetails.lengthOutlier.translation' => 'TRADUÇÃO',
          'issueDetails.lengthOutlier.chars' => ({required Object count}) =>
              '${count} chars',
          'issueDetails.standard.key' => 'CHAVE',
          'issueDetails.standard.sourceText' => 'TEXTO DE ORIGEM',
          'issueDetails.standard.translation' => 'TRADUÇÃO',
          'issueDetails.standard.errorDetails' => 'DETALHES DO ERRO',
          'issueDetails.standard.note' => 'NOTA',
          'issueDetails.review' => 'Revisar',
          'issueDetails.types.duplicateValue' => 'Valores Duplicados',
          'issueDetails.types.lengthOutlier' =>
            'Incompatibilidade de Comprimento',
          'issueDetails.types.placeholderMismatch' =>
            'Espaços Reservados Quebrados',
          'issueDetails.notes.placeholderMismatch' =>
            'Marcadores como {name} devem corresponder à origem.',
          'issueDetails.notes.lengthOutlier' =>
            'Grandes alterações de comprimento podem afetar como o texto se ajusta na tela.',
          'issueDetails.notes.duplicateValue' =>
            'A mesma tradução é usada para chaves diferentes.',
          'issueDetails.fallbacks.multipleSources' =>
            'Múltiplos textos de origem',
          'issueDetails.fallbacks.sourceNotAvailable' =>
            'Texto de origem não disponível',
          'issueDetails.fallbacks.sharedTranslationNotAvailable' =>
            'Tradução compartilhada não disponível',
          'issueDetails.fallbacks.translationNotAvailable' =>
            'Tradução não disponível',
          'importReview.title' => 'Revisar Importação de Projeto',
          'importReview.projectName' => 'Nome do Projeto',
          'importReview.created' => 'Criado',
          'importReview.historyItems' => 'Itens do Histórico',
          'importReview.customSettingsTitle' =>
            'Configurações Personalizadas Detectadas',
          'importReview.customSettingsWarning' =>
            'Este projeto contém configurações personalizadas que substituirão seus padrões enquanto este projeto estiver aberto.',
          'importReview.standardSettings' =>
            'Este projeto usa configurações globais padrão.',
          'importReview.cancelImport' => 'Cancelar Importação',
          'importReview.trustOpen' => 'Confiar & Abrir Projeto',
          'historyView.title' => 'Histórico de Comparações',
          'historyView.clearAll' => 'Limpar todo o histórico',
          'historyView.searchPlaceholder' => 'Pesquisar por nome de arquivo...',
          'historyView.sortBy' => 'Ordenar por',
          'historyView.sortDate' => 'Data',
          'historyView.sortSource' => 'Arquivo de Origem',
          'historyView.sortTarget' => 'Arquivo de Destino',
          'historyView.showCurrentProject' => 'Mostrando: Projeto Atual',
          'historyView.showAllHistory' => 'Mostrando: Todo o Histórico',
          'historyView.groupByFolder' => 'Agrupar por pasta',
          'historyView.disableGrouping' => 'Desativar agrupamento por pasta',
          'historyView.filterAll' => 'Tudo',
          'historyView.filterFiles' => 'Arquivos',
          'historyView.filterDirectories' => 'Diretórios',
          'historyView.filterGit' => 'Git',
          'historyView.noHistory' => 'Nenhum histórico de comparação ainda',
          'historyView.historyDescription' =>
            'Suas comparações de arquivos aparecerão aqui',
          'historyView.noResults' => 'Nenhum resultado encontrado',
          'historyView.adjustSearch' => 'Tente ajustar sua pesquisa',
          'historyView.clearConfirmationTitle' => 'Limpar Todo o Histórico?',
          'historyView.clearConfirmationContent' =>
            'Isso excluirá permanentemente todo o histórico de comparações. Esta ação não pode ser desfeita.',
          'historyView.clearAction' => 'Limpar Tudo',
          'historyView.deletedMessage' => 'Item do histórico excluído',
          'historyView.undo' => 'Desfazer',
          'historyView.viewDetails' => 'Ver Detalhes',
          'historyView.delete' => 'Excluir',
          'historyView.openLocation' => 'Abrir local do arquivo',
          'historyView.bilingual' => 'Bilíngue',
          'historyView.filePair' => 'Par de Arquivos',
          'historyView.directory' => 'Diretório',
          'historyView.git' => 'Git',
          'historyView.repo' => 'Repo',
          'historyView.sourceDir' => 'Dir. de Origem',
          'historyView.targetDir' => 'Dir. de Destino',
          'historyView.source' => 'Origem',
          'historyView.target' => 'Destino',
          'historyView.noChanges' => 'Nenhuma alteração detectada',
          'historyView.added' => 'Adicionado',
          'historyView.removed' => 'Removido',
          'historyView.modified' => 'Modificado',
          'historyView.same' => 'Igual',
          'historyView.total' => 'Total',
          'historyView.currentProject' => 'Projeto Atual',
          'historyView.unassigned' => 'Não atribuído',
          'historyView.project' => 'Projeto',
          'compare.title' => 'Comparar Arquivos',
          'compare.sourceFile' => 'Arquivo de Origem',
          'compare.targetFile' => 'Arquivo de Destino',
          'compare.sourceFolder' => 'Pasta de Origem',
          'compare.targetFolder' => 'Pasta de Destino',
          'compare.dropFilesHint' =>
            'Solte os arquivos de localização aqui ou use os botões de procurar para selecionar os arquivos para comparação.',
          'compare.selectSourceFile' => 'Selecionar arquivo de origem',
          'compare.selectTargetFile' => 'Selecionar arquivo de destino',
          'compare.startComparison' => 'Iniciar Comparação',
          'compare.comparing' => 'Comparando...',
          'compare.comparisonComplete' => 'Comparação concluída',
          'compare.noChanges' => 'Nenhuma alteração detectada',
          'compare.filesIdentical' => 'Os arquivos são idênticos',
          'compare.changesFound' => ({required Object count}) =>
              '${count} alterações encontradas',
          'compare.tabs.files' => 'Arquivos',
          'compare.tabs.directories' => 'Diretórios',
          'compare.tabs.git' => 'Git',
          'compare.fileTypes.json' =>
            'Arquivos de localização JSON (i18next, Flutter, etc.)',
          'compare.fileTypes.yaml' =>
            'Arquivos de localização YAML (Rails, Flutter)',
          'compare.fileTypes.xml' =>
            'Arquivos de localização XML (Android, .NET)',
          'compare.fileTypes.properties' => 'Arquivos Properties (Java)',
          'compare.fileTypes.resx' => 'Arquivos RESX (.NET)',
          _ => null,
        } ??
        switch (path) {
          'compare.fileTypes.xliff' => 'Arquivos XLIFF',
          'history.title' => 'Histórico',
          'history.recentComparisons' => 'Comparações Recentes',
          'history.noHistory' => 'Nenhum histórico de comparação ainda',
          'history.noHistoryDescription' =>
            'Seu histórico de comparações aparecerão aqui',
          'history.clearHistory' => 'Limpar Histórico',
          'history.clearHistoryConfirm' =>
            'Tem certeza de que deseja limpar todo o histórico?',
          'history.deleteEntry' => 'Excluir Entrada',
          'history.openComparison' => 'Abrir Comparação',
          'history.timeAgo.justNow' => 'agora mesmo',
          'history.timeAgo.secondsAgo' => ({required Object count}) =>
              'há ${count} segundos',
          'history.timeAgo.oneMinuteAgo' => 'há 1 minuto',
          'history.timeAgo.minutesAgo' => ({required Object count}) =>
              'há ${count} minutos',
          'history.timeAgo.oneHourAgo' => 'há 1 hora',
          'history.timeAgo.hoursAgo' => ({required Object count}) =>
              'há ${count} horas',
          'history.timeAgo.yesterday' => 'ontem',
          'history.timeAgo.daysAgo' => ({required Object count}) =>
              'há ${count} dias',
          'history.timeAgo.oneWeekAgo' => 'há 1 semana',
          'history.timeAgo.weeksAgo' => ({required Object count}) =>
              'há ${count} semanas',
          'history.timeAgo.oneMonthAgo' => 'há 1 mês',
          'history.timeAgo.monthsAgo' => ({required Object count}) =>
              'há ${count} meses',
          'history.timeAgo.oneYearAgo' => 'há 1 ano',
          'history.timeAgo.yearsAgo' => ({required Object count}) =>
              'há ${count} anos',
          'history.timeAgo.inTheFuture' => 'no futuro',
          'projects.title' => 'Projetos',
          'projects.createProject' => 'Criar Projeto',
          'projects.importProject' => 'Importar Projeto',
          'projects.noProjects' => 'Nenhum projeto ainda',
          'projects.noProjectsDescription' =>
            'Crie um projeto para organizar seus arquivos de localização',
          'projects.projectName' => 'Nome do Projeto',
          'projects.projectPath' => 'Caminho do Projeto',
          'projects.lastOpened' => 'Aberto pela última vez',
          'projects.openProject' => 'Abrir Projeto',
          'projects.closeProject' => 'Fechar Projeto',
          'projects.deleteProject' => 'Excluir Projeto',
          'projects.deleteProjectConfirm' =>
            'Tem certeza de que deseja excluir este projeto?',
          'projects.exportProject' => 'Exportar Projeto',
          'projects.exportDescription' =>
            'Crie um arquivo zip portátil contendo arquivos de origem, configuração e histórico.',
          'projects.exporting' => 'Exportando projeto...',
          'projects.exportSuccess' => 'Projeto exportado',
          'projects.exportError' => ({required Object error}) =>
              'Falha na exportação: ${error}',
          'projects.createNewProject' => 'Criar Novo Projeto',
          'projects.openExistingProject' => 'Abrir Projeto Existente',
          'projects.importProjectZip' => 'Importar Zip de Projeto',
          'projects.projectResources' => 'Recursos do Projeto',
          'projects.recentProjects' => 'Projetos Recentes',
          'projects.noRecentProjects' => 'Nenhum projeto recente',
          'projects.selectProjectZip' => 'Selecionar Zip de Projeto',
          'projects.selectDestination' =>
            'Selecionar Pasta de Destino para Importação',
          'projects.importing' => 'Importando projeto...',
          'projects.importSuccess' => 'Projeto importado com sucesso',
          'projects.importFailed' => ({required Object error}) =>
              'Importação falhou: ${error}',
          'projects.importingFiles' => 'Importando arquivos...',
          'projects.noSupportedFiles' => 'Nenhum arquivo suportado foi solto.',
          'projects.stats.empty' => 'Projeto vazio',
          'projects.stats.files' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(
                n,
                one: '1 arquivo de tradução',
                other: '${count} arquivos de tradução',
              ),
          'projects.stats.languages' => (
                  {required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(
                n,
                one: '1 idioma',
                other: '${count} idiomas',
              ),
          'projects.openProjectFirst' =>
            'Abra um projeto primeiro para gerenciar seus recursos.',
          'projects.removeFromRecent' => 'Remover dos recentes',
          'projects.selection.selectFolder' => 'Selecionar Pasta do Projeto',
          'projects.selection.selectArchive' => 'Selecionar Arquivo do Projeto',
          'projects.selection.openProject' => 'Abrir Projeto',
          'projects.selection.browseFolder' => 'Procurar Pasta...',
          'projects.selection.createNew' => 'Criar Novo',
          'projects.selection.importFromZip' => 'Importar de Zip...',
          'projects.createDialog.title' => 'Criar Projeto',
          'projects.createDialog.description' =>
            'Um projeto permite que você salve configurações personalizadas para uma pasta específica. Uma pasta ".localizer" será criada para armazenar a configuração do seu projeto.',
          'projects.createDialog.folderLabel' => 'Pasta do Projeto',
          'projects.createDialog.folderHint' =>
            'Clique para selecionar a pasta...',
          'projects.createDialog.nameLabel' => 'Nome do Projeto',
          'projects.createDialog.nameHint' => 'ex: Traduções do Meu App',
          'projects.createDialog.selectFolderWarning' =>
            'Por favor, selecione uma pasta de projeto.',
          'projects.createDialog.enterNameError' =>
            'Por favor, insira um nome de projeto',
          'projects.createDialog.nameLengthError' =>
            'O nome deve ter pelo menos 2 caracteres',
          'projects.createDialog.success' => ({required Object name}) =>
              'Projeto "${name}" criado com sucesso!',
          'projects.createDialog.failure' => 'Falha ao criar o projeto.',
          'projects.createDialog.creating' => 'Criando...',
          'projects.createDialog.createAction' => 'Criar Projeto',
          'projects.indicator.tooltipNoProject' =>
            'Crie um projeto para salvar configurações personalizadas para uma pasta',
          'projects.indicator.tooltipProject' => ({required Object name}) =>
              'Projeto: ${name}\nClique para ver as opções',
          'projects.indicator.location' => 'Localização',
          'projects.indicator.created' => 'Criado',
          'projects.indicator.switchProject' => 'Trocar Projeto',
          'projects.indicator.done' => 'Concluído',
          'projects.glossary.title' => 'Glossário do Projeto',
          'projects.glossary.description' =>
            'Defina termos que devem ser tratados de forma consistente ou nunca traduzidos.',
          'projects.glossary.noTerms' => 'Nenhum termo no glossário ainda.',
          'projects.glossary.noTermsDesc' =>
            'Adicione termos que devem permanecer consistentes entre as traduções,\nou marque nomes de marcas que nunca devem ser traduzidos.',
          'projects.glossary.doNotTranslate' => 'Não traduzir',
          'projects.glossary.noSpecificTranslation' =>
            'Nenhuma tradução específica',
          'projects.glossary.addTerm' => 'Adicionar Termo',
          'projects.glossary.editTerm' => 'Editar Termo',
          'projects.glossary.term' => 'Termo',
          'projects.glossary.termHint' =>
            'ex: nome da marca, termo especializado',
          'projects.glossary.definition' => 'Definição (Opcional)',
          'projects.glossary.definitionHint' => 'Contexto para o tradutor',
          'projects.glossary.doNotTranslateLabel' => 'Não Traduzir',
          'projects.glossary.doNotTranslateDesc' =>
            'Manter o termo exatamente como está no destino',
          'projects.glossary.preferredTranslation' => 'Tradução Preferida',
          'projects.glossary.caseSensitive' =>
            'Diferenciar Maiúsculas/Minúsculas',
          'projects.conflicts.missingApiKeyTitle' => (
                  {required Object service}) =>
              'Chave de API ausente para ${service}',
          'projects.conflicts.missingApiKeyMessage' => (
                  {required Object service}) =>
              'Este projeto usa ${service}, mas nenhuma chave de API está configurada. Adicione sua chave de API em Configurações > Serviços de IA, ou o app usará o padrão global.',
          'projects.conflicts.dismiss' => 'Descartar',
          'projects.tm.title' => 'Memórias de Tradução',
          'projects.tm.description' =>
            'Gerenciar fontes de memória de tradução para este projeto.',
          'projects.tm.globalTm' => 'Memória de Tradução Global',
          'projects.tm.globalTmDescription' =>
            'Usar a memória de tradução compartilhada das configurações do seu app',
          'projects.tm.linkedFiles' =>
            'Arquivos Vinculados (Específicos do Projeto)',
          'projects.tm.noLinkedFiles' =>
            'Nenhum arquivo específico do projeto vinculado.',
          'projects.tm.addTmFile' => 'Adicionar Arquivo de TM',
          'projects.tm.useGlobalTm' => 'Usar TM Global',
          'projects.tm.selectTm' => 'Selecionar Memória de Tradução',
          'projects.tm.globalTmEnabled' => 'Memória de Tradução Global ativada',
          'diff.added' => 'Adicionado',
          'diff.removed' => 'Removido',
          'diff.modified' => 'Modificado',
          'diff.unchanged' => 'Inalterado',
          'diff.missing' => 'Ausente',
          'diff.extra' => 'Extra',
          'diff.sourceValue' => 'Valor de Origem',
          'diff.targetValue' => 'Valor de Destino',
          'diff.key' => 'Chave',
          'diff.status' => 'Status',
          'diff.actions' => 'Ações',
          'diff.copyToTarget' => 'Copiar para o Destino',
          'diff.acceptChange' => 'Aceitar Alteração',
          'diff.rejectChange' => 'Rejeitar Alteração',
          'diff.viewDetails' => 'Ver Detalhes',
          'git.title' => 'Comparação Git',
          'git.selectRepository' => 'Selecionar Repositório',
          'git.selectBranch' => 'Selecionar Branch',
          'git.selectCommit' => 'Selecionar Commit',
          'git.compareBranches' => 'Comparar Branches',
          'git.compareCommits' => 'Comparar Commits',
          'git.baseBranch' => 'Branch Base',
          'git.compareBranch' => 'Branch de Comparação',
          'git.noRepositories' => 'Nenhum repositório Git encontrado',
          'git.noRepositoriesDescription' =>
            'Abra uma pasta contendo um repositório Git',
          'git.filesChanged' => ({required Object count}) =>
              '${count} arquivos alterados',
          'git.additions' => ({required Object count}) => '${count} adições',
          'git.deletions' => ({required Object count}) => '${count} exclusões',
          'git.conflicts.title' => 'Conflitos de Merge Detectados',
          'git.conflicts.description' =>
            'Você deve resolver estes conflitos antes de continuar.',
          'git.conflicts.abortMergeTitle' => 'Abortar Merge?',
          'git.conflicts.abortMergeContent' =>
            'Isso reverterá todas as alterações de merge e retornará ao estado anterior ao merge. Esta ação não pode ser desfeita.',
          'git.conflicts.abortMergeAction' => 'Abortar Merge',
          'git.conflicts.stagingFile' => ({required Object file}) =>
              'Preparando ${file} para commit...',
          'git.conflicts.conflictedFilesCount' => ({required Object count}) =>
              'Arquivos com Conflito (${count})',
          'git.conflicts.selectFileToResolve' =>
            'Selecione um arquivo para resolver',
          'git.conflicts.resolvingFile' => ({required Object file}) =>
              'Resolvendo: ${file}',
          'git.conflicts.keepAllOurs' => 'Manter Tudo Nosso (Ours)',
          'git.conflicts.acceptAllTheirs' => 'Aceitar Tudo Deles (Theirs)',
          'git.conflicts.allResolved' =>
            'Todos os conflitos neste arquivo foram resolvidos!',
          'git.conflicts.markResolved' => 'Marcar como Resolvido',
          'git.conflicts.stageForCommit' =>
            'Isso preparará o arquivo para commit.',
          'git.conflicts.conflictIndex' => ({required Object index}) =>
              'Conflito #${index}',
          'git.conflicts.ours' => 'NOSSO (Ours - Atual)',
          'git.conflicts.theirs' => 'DELES (Theirs - Entrada)',
          'git.conflicts.keepOurs' => 'Manter Nosso',
          'git.conflicts.acceptTheirs' => 'Aceitar Deles',
          'git.conflicts.empty' => '(Vazio)',
          'quality._translatorNote' =>
            'Termos de API e métricas (Requests, Tokens, Characters, Prompt, Completion, Export) devem permanecer em Inglês para todas as traduções a fim de manter a consistência com a terminologia da indústria.',
          'quality.title' => 'Painel de Qualidade',
          'quality.overallScore' => 'Pontuação Geral',
          'quality.issues' => 'Problemas',
          'quality.warnings' => 'Avisos',
          'quality.suggestions' => 'Sugestões',
          'quality.placeholderMismatch' =>
            'Incompatibilidade de Espaço Reservado',
          'quality.placeholderMismatchDescription' =>
            'Espaços reservados como {name} não coincidem entre origem e destino',
          'quality.lengthOutlier' => 'Anomalia de Comprimento',
          'quality.lengthOutlierDescription' =>
            'O comprimento da tradução difere significativamente da origem',
          'quality.duplicateValue' => 'Valor Duplicado',
          'quality.duplicateValueDescription' =>
            'A mesma tradução usada para múltiplas chaves',
          'quality.missingTranslation' => 'Tradução Ausente',
          'quality.missingTranslationDescription' =>
            'Tradução ausente para esta chave',
          'quality.loading' => 'Carregando painel...',
          'quality.errorLoading' =>
            'Não foi possível carregar seu histórico. Tente novamente.',
          'quality.emptyState' => 'Execute uma comparação para ver seu painel.',
          'quality.refresh' => 'Atualizar',
          'quality.buildingInsights' => 'Construindo insights...',
          'quality.crunchingNumbers' => 'Processando os números...',
          'quality.errorBuilding' =>
            'Não foi possível construir o painel. Tente novamente.',
          'quality.noUsableData' =>
            'Nenhum dado utilizável foi encontrado ainda.',
          'quality.languages' => 'Idiomas',
          'quality.averageCoverage' => 'Cobertura média',
          'quality.potentialIssues' => 'Problemas potenciais',
          'quality.translationCoverage' => 'Cobertura de tradução',
          'quality.entriesTranslated' => (
                  {required Object translated, required Object total}) =>
              '${translated} de ${total} entradas traduzidas',
          'quality.wordsAddedOverTime' =>
            'Palavras adicionadas ao longo do tempo',
          'quality.completionVsScope' => 'Conclusão vs Escopo',
          'quality.scopeVsProgress' => 'Escopo vs Progresso',
          'quality.coveragePercent' => 'Cobertura %',
          'quality.wordsAdded' => 'Palavras Adicionadas',
          'quality.words' => 'Palavras',
          'quality.coverage' => 'Cobertura',
          'quality.scope' => 'Escopo',
          'quality.latest' => 'Mais Recente',
          'quality.added' => 'Adicionado',
          'quality.change' => 'Alteração',
          'quality.totalScope' => 'Escopo Total',
          'quality.wordsCount' => ({required Object count}) =>
              '${count} palavras',
          'quality.scopeGrowth' => 'Crescimento do Escopo',
          'quality.range' => 'Intervalo',
          'quality.aiUsage' => 'Uso de IA & Tradução',
          'quality.lastUsed' => ({required Object date}) =>
              'Usado pela última vez em ${date}',
          'quality.noIssuesFound' =>
            'Nenhum problema encontrado nas últimas comparações.',
          'quality.placeholderMismatches' =>
            'Incompatibilidades de espaço reservado',
          'quality.placeholderMismatchesDesc' =>
            'Marcadores como {name} não coincidem.',
          'quality.lengthOutliers' => 'Traduções muito curtas ou longas',
          'quality.lengthOutliersDesc' =>
            'O comprimento parece incomum em comparação com a origem.',
          'quality.duplicateValues' => 'Valores duplicados',
          'quality.duplicateValuesDesc' =>
            'A mesma tradução é usada muitas vezes.',
          'quality.placeholderDialogTitle' =>
            'Incompatibilidades de Espaço Reservado',
          'quality.placeholderDialogDesc' =>
            'Estas traduções têm espaços reservados ({name}) diferentes da origem.',
          'quality.lengthDialogTitle' => 'Anomalias de Comprimento',
          'quality.lengthDialogDesc' =>
            'Estas traduções são significativamente mais curtas ou mais longas que a origem.',
          'quality.duplicateDialogTitle' => 'Valores Duplicados',
          'quality.duplicateDialogDesc' =>
            'Estas traduções aparecem múltiplas vezes.',
          'quality.duplicateSample' => ({required Object value}) =>
              'Duplicado: "${value}"',
          'quality.exportError' =>
            'Não foi possível construir o relatório. Por favor, tente novamente.',
          'quality.noDataToExport' => 'Nenhum dado para exportar',
          'quality.exportFailed' => 'Exportação falhou',
          'quality.exportDialogTitle' => 'Exportar Relatório de Qualidade',
          'quality.reportSaved' => 'Relatório salvo',
          'quality.export' => 'Exportar',
          'quality.requests' => 'Requisições',
          'quality.tokens' => 'Tokens',
          'quality.characters' => 'Caracteres',
          'quality.estCost' => 'Custo Est.',
          'quality.prompt' => 'Prompt',
          'quality.completion' => 'Conclusão',
          'quality.showingCurrentProject' => 'Mostrando: Projeto Atual',
          'quality.showingAllHistory' => 'Mostrando: Todo o Histórico',
          'quality.filesSkipped' =>
            'Alguns arquivos foram ignorados porque não foram encontrados.',
          'errors.genericError' => 'Ocorreu um erro',
          'errors.fileNotFound' => 'Arquivo não encontrado',
          'errors.invalidFormat' => 'Formato de arquivo inválido',
          'errors.parseError' => 'Falha ao analisar o arquivo',
          'errors.networkError' =>
            'Erro de rede. Por favor, verifique sua conexão.',
          'errors.permissionDenied' => 'Permissão negada',
          'errors.unknownError' => 'Ocorreu um erro desconhecido',
          'wizards.firstRun.welcome' => 'Bem-vindo ao Localizer',
          'wizards.firstRun.description' =>
            'Compare seus arquivos de localização em segundos.',
          'wizards.firstRun.sourceFile' => 'Arquivo de Origem',
          'wizards.firstRun.targetFile' => 'Arquivo de Destino',
          'wizards.firstRun.compareNow' => 'Comparar Agora',
          'wizards.firstRun.trySample' => 'Tentar com Dados de Exemplo',
          'wizards.firstRun.skip' => 'Pular Configuração',
          'wizards.firstRun.browse' => 'Clique para procurar',
          'wizards.firstRun.error' => ({required Object error}) =>
              'Falha ao carregar dados de exemplo: ${error}',
          'dialogs.addIgnorePattern.title' => 'Adicionar Padrão de Ignorar',
          'dialogs.addIgnorePattern.patternLabel' => 'Padrão (regex)',
          'dialogs.addIgnorePattern.hint' => 'ex: ^temp_.*',
          'dialogs.addIgnorePattern.invalid' => 'Padrão regex inválido',
          'dialogs.addIgnorePattern.testStringLabel' => 'Testar String',
          'dialogs.addIgnorePattern.testHint' =>
            'Insira uma chave para testar contra o padrão',
          'dialogs.addIgnorePattern.match' =>
            '✓ Padrão corresponde à string de teste',
          'dialogs.addIgnorePattern.noMatch' => '✗ Padrão não corresponde',
          'dialogs.addIgnorePattern.add' => 'Adicionar',
          'dialogs.addIgnorePattern.cancel' => 'Cancelar',
          'dialogs.diffViewer.title' => 'Visualizador de Diff',
          'dialogs.diffViewer.originalFile' => 'Arquivo Original/Referência',
          'dialogs.diffViewer.translationFile' =>
            'Arquivo de Tradução/Comparação',
          'dialogs.diffViewer.base' => 'BASE',
          'dialogs.diffViewer.target' => 'DESTINO',
          'dialogs.diffViewer.added' => 'Adicionado',
          'dialogs.diffViewer.removed' => 'Removido',
          'dialogs.diffViewer.modified' => 'Modificado',
          'dialogs.diffViewer.noMatches' =>
            'Nenhuma entrada corresponde aos filtros atuais',
          'dialogs.diffViewer.clickToggle' =>
            'Clique nos badges acima para alternar os filtros',
          'dialogs.diffViewer.clickToHide' => '(clique para ocultar)',
          'dialogs.diffViewer.clickToShow' => '(clique para mostrar)',
          'grid.columns.key' => 'Chave',
          'grid.columns.source' => 'Origem',
          'grid.columns.status' => 'Status',
          'grid.columns.actions' => 'Ações',
          'tutorial.skipTutorial' => 'PULAR TUTORIAL',
          'tutorial.finishMessage' =>
            'Tudo pronto! Toque em qualquer lugar para terminar.',
          'tutorial.next' => 'Próximo',
          'tutorial.loadSampleData' => 'Carregar Dados de Exemplo',
          'tutorial.browseSourceFile' => 'Procurar Arquivo de Origem',
          'tutorial.browseTargetFile' => 'Procurar Arquivo de Destino',
          'tutorial.compareFiles' => 'Comparar Arquivos',
          'tutorial.hintPhase2' =>
            'Próximo: filtros, pesquisa, visualização avançada e exportação.',
          'tutorial.steps.importSource.title' =>
            '1. Importar Arquivo de Origem',
          'tutorial.steps.importSource.description' =>
            'Use o botão abaixo para procurar um arquivo ou arraste & solte na área destacada.',
          'tutorial.steps.importTarget.title' =>
            '2. Importar Arquivo de Destino',
          'tutorial.steps.importTarget.description' =>
            'Use o botão abaixo para procurar um arquivo ou arraste & solte na área destacada.',
          'tutorial.steps.compare.title' => '3. Comparar Arquivos',
          'tutorial.steps.compare.description' =>
            'Toque no botão abaixo para rodar a comparação e ver os resultados.',
          'tutorial.steps.filter.title' => '4. Filtrar Resultados',
          'tutorial.steps.filter.description' =>
            'Use estes filtros para ver strings Adicionadas, Removidas ou Modificadas.',
          'tutorial.steps.search.title' => '5. Pesquisar Resultados',
          'tutorial.steps.search.description' =>
            'Encontre chaves ou valores específicos usando a barra de pesquisa.',
          'tutorial.steps.advanced.title' => '6. Visualização Avançada',
          'tutorial.steps.advanced.description' =>
            'Abra a visualização detalhada de diff com edição, tradução por IA e mais.',
          'tutorial.steps.export.title' => '7. Exportar Resultados',
          'tutorial.steps.export.description' =>
            'Salve sua comparação como arquivo CSV, JSON ou Excel.',
          'friendlyErrors.fileNotFound.message' =>
            'O arquivo ou pasta não pôde ser encontrado.',
          'friendlyErrors.fileNotFound.suggestion' =>
            'Verifique se o arquivo foi movido ou excluído.',
          'friendlyErrors.accessDenied.message' =>
            'O acesso ao arquivo foi negado.',
          'friendlyErrors.accessDenied.suggestion' =>
            'Tente executar o aplicativo como administrador ou verifique as permissões do arquivo.',
          'friendlyErrors.isDirectory.message' =>
            'Uma pasta foi selecionada em vez de um arquivo.',
          'friendlyErrors.isDirectory.suggestion' =>
            'Por favor, selecione um arquivo válido.',
          'friendlyErrors.fileAccess.message' =>
            'Houve um problema ao acessar o arquivo.',
          'friendlyErrors.fileAccess.suggestion' =>
            'Tente fechar outros programas que possam estar usando o arquivo.',
          'friendlyErrors.unsupportedFormat.message' =>
            'Este formato de arquivo ou operação não é suportado.',
          'friendlyErrors.unsupportedFormat.suggestion' =>
            'Verifique a extensão do arquivo ou tente um formato diferente.',
          'friendlyErrors.networkError.message' =>
            'Não foi possível conectar ao servidor.',
          'friendlyErrors.networkError.suggestion' =>
            'Verifique sua conexão com a internet e tente novamente.',
          'friendlyErrors.notGitRepo.message' =>
            'Esta pasta não é um projeto Git.',
          'friendlyErrors.notGitRepo.suggestion' =>
            'Navegue até uma pasta que contenha um diretório .git.',
          'friendlyErrors.mergeConflict.message' =>
            'Existem conflitos de merge no repositório.',
          'friendlyErrors.mergeConflict.suggestion' =>
            'Resolva os conflitos antes de continuar.',
          'friendlyErrors.gitAuthFailed.message' =>
            'Falha na autenticação do Git.',
          'friendlyErrors.gitAuthFailed.suggestion' =>
            'Verifique suas credenciais em Configurações > Controle de Versão.',
          'friendlyErrors.gitOperationFailed.message' =>
            'Uma operação do Git falhou.',
          'friendlyErrors.gitOperationFailed.suggestion' =>
            'Verifique a visualização do Git para mais detalhes.',
          'friendlyErrors.invalidJson.message' =>
            'O formato do arquivo é inválido ou está corrompido.',
          'friendlyErrors.invalidJson.suggestion' =>
            'Certifique-se de que o arquivo contém conteúdo JSON válido.',
          'friendlyErrors.rateLimitReached.message' =>
            'Limite de tradução atingido.',
          'friendlyErrors.rateLimitReached.suggestion' =>
            'Aguarde alguns minutos ou verifique os limites do seu plano de API.',
          'friendlyErrors.invalidApiKey.message' => 'Chave de API inválida.',
          'friendlyErrors.invalidApiKey.suggestion' =>
            'Vá em Configurações > Tradução por IA para atualizar sua chave de API.',
          'friendlyErrors.translationServiceError.message' =>
            'Erro no serviço de tradução.',
          'friendlyErrors.translationServiceError.suggestion' =>
            'Verifique sua chave de API e conexão com a internet.',
          'friendlyErrors.outOfMemory.message' =>
            'Memória insuficiente para completar esta operação.',
          'friendlyErrors.outOfMemory.suggestion' =>
            'Tente fechar outros aplicativos ou usar arquivos menores.',
          'friendlyErrors.genericError.message' => 'Algo deu errado.',
          'friendlyErrors.genericError.suggestion' =>
            'Por favor, tente novamente. Se o problema persistir, reinicie o aplicativo.',
          'systemTray.showLocalizer' => 'Mostrar Localizer',
          'systemTray.exit' => 'Sair',
          'validation.connected' => 'Conectado.',
          'validation.connectionTimeout' =>
            'A conexão expirou. Por favor, tente novamente.',
          'validation.couldNotConnect' =>
            'Não foi possível conectar. Por favor, tente novamente.',
          'validation.checkKeyAndTryAgain' =>
            'Não foi possível conectar. Por favor, verifique a chave e tente novamente.',
          'validation.tryAgainLater' =>
            'Não foi possível conectar agora. Por favor, tente novamente mais tarde.',
          'validation.serviceUnavailable' =>
            'O serviço está indisponível no momento. Por favor, tente novamente mais tarde.',
          'validation.enterKeyFirst' => 'Por favor, insira uma chave primeiro.',
          'validation.checking' => 'Verificando...',
          'validation.deeplUsage' => (
                  {required Object used, required Object limit}) =>
              'Uso: ${used} / ${limit} caracteres.',
          'status.startingComparison' => 'Iniciando comparação...',
          'status.loadingFromHistory' => 'Carregando arquivos do histórico...',
          'status.comparisonComplete' => 'Comparação concluída',
          'status.couldNotImportFiles' =>
            'Não foi possível importar os arquivos. Por favor, tente novamente.',
          'status.historyFilesNotFound' =>
            'Um ou ambos os arquivos do histórico não foram encontrados nos caminhos originais.',
          'aiServices.geminiEmptyResponse' =>
            'O Gemini retornou uma resposta vazia',
          'aiServices.geminiStreamingEmpty' =>
            'O streaming do Gemini retornou uma resposta vazia',
          'aiServices.geminiRephraseEmpty' =>
            'O Gemini retornou uma resposta vazia para refraseamento',
          'aiServices.openaiEmptyResponse' =>
            'A OpenAI retornou uma resposta vazia ou com falha',
          _ => null,
        };
  }
}
