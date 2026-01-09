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
class TranslationsJa extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsJa(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.ja,
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

  /// Metadata for the translations of <ja>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsJa _root = this; // ignore: unused_field

  @override
  TranslationsJa $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsJa(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsAppJa app = _TranslationsAppJa._(_root);
  @override
  late final _TranslationsCommonJa common = _TranslationsCommonJa._(_root);
  @override
  late final _TranslationsMenuJa menu = _TranslationsMenuJa._(_root);
  @override
  late final _TranslationsNavJa nav = _TranslationsNavJa._(_root);
  @override
  late final _TranslationsSettingsJa settings =
      _TranslationsSettingsJa._(_root);
  @override
  late final _TranslationsFileComparisonJa fileComparison =
      _TranslationsFileComparisonJa._(_root);
  @override
  late final _TranslationsDirectoryComparisonJa directoryComparison =
      _TranslationsDirectoryComparisonJa._(_root);
  @override
  late final _TranslationsGitComparisonJa gitComparison =
      _TranslationsGitComparisonJa._(_root);
  @override
  late final _TranslationsAdvancedComparisonJa advancedComparison =
      _TranslationsAdvancedComparisonJa._(_root);
  @override
  late final _TranslationsAdvancedDiffJa advancedDiff =
      _TranslationsAdvancedDiffJa._(_root);
  @override
  late final _TranslationsIssueDetailsJa issueDetails =
      _TranslationsIssueDetailsJa._(_root);
  @override
  late final _TranslationsImportReviewJa importReview =
      _TranslationsImportReviewJa._(_root);
  @override
  late final _TranslationsHistoryViewJa historyView =
      _TranslationsHistoryViewJa._(_root);
  @override
  late final _TranslationsCompareJa compare = _TranslationsCompareJa._(_root);
  @override
  late final _TranslationsHistoryJa history = _TranslationsHistoryJa._(_root);
  @override
  late final _TranslationsProjectsJa projects =
      _TranslationsProjectsJa._(_root);
  @override
  late final _TranslationsDiffJa diff = _TranslationsDiffJa._(_root);
  @override
  late final _TranslationsGitJa git = _TranslationsGitJa._(_root);
  @override
  late final _TranslationsQualityJa quality = _TranslationsQualityJa._(_root);
  @override
  late final _TranslationsErrorsJa errors = _TranslationsErrorsJa._(_root);
  @override
  late final _TranslationsWizardsJa wizards = _TranslationsWizardsJa._(_root);
  @override
  late final _TranslationsDialogsJa dialogs = _TranslationsDialogsJa._(_root);
  @override
  late final _TranslationsGridJa grid = _TranslationsGridJa._(_root);
  @override
  late final _TranslationsTutorialJa tutorial =
      _TranslationsTutorialJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsJa friendlyErrors =
      _TranslationsFriendlyErrorsJa._(_root);
  @override
  late final _TranslationsSystemTrayJa systemTray =
      _TranslationsSystemTrayJa._(_root);
  @override
  late final _TranslationsValidationJa validation =
      _TranslationsValidationJa._(_root);
  @override
  late final _TranslationsStatusJa status = _TranslationsStatusJa._(_root);
  @override
  late final _TranslationsAiServicesJa aiServices =
      _TranslationsAiServicesJa._(_root);
}

// Path: app
class _TranslationsAppJa extends TranslationsAppEn {
  _TranslationsAppJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'ローカリゼーション比較ツール';
  @override
  String get name => 'Localizer';
}

// Path: common
class _TranslationsCommonJa extends TranslationsCommonEn {
  _TranslationsCommonJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get save => '保存';
  @override
  String get cancel => 'キャンセル';
  @override
  String get close => '閉じる';
  @override
  String get delete => '削除';
  @override
  String get edit => '編集';
  @override
  String get add => '追加';
  @override
  String get search => '検索';
  @override
  String get undo => '元に戻す';
  @override
  String get loading => '読み込み中...';
  @override
  String get error => 'エラー';
  @override
  String get success => '成功';
  @override
  String get warning => '警告';
  @override
  String get info => '情報';
  @override
  String get confirm => '確認';
  @override
  String get yes => 'はい';
  @override
  String get no => 'いいえ';
  @override
  String get ok => 'OK';
  @override
  String get retry => '再試行';
  @override
  String get copyText => 'コピー';
  @override
  String get appName => 'Localizer';
  @override
  String get copied => 'コピーしました！';
  @override
  String get enabled => '有効';
  @override
  String get disabled => '無効';
  @override
  String get browse => '参照';
  @override
  String get clear => 'クリア';
  @override
  String get apply => '適用';
  @override
  String get reset => 'リセット';
  @override
  String get refresh => '更新';
  @override
  String get export => 'エクスポート';
  @override
  String get import => 'インポート';
  @override
  String get select => '選択';
  @override
  String get selectAll => 'すべて選択';
  @override
  String get deselectAll => 'すべての選択を解除';
  @override
  String get noResults => '結果が見つかりません';
  @override
  String get emptyState => 'データがありません';
  @override
  String get open => '開く';
  @override
  String get change => '変更';
  @override
  String get original => 'オリジナル';
  @override
  String get kNew => '新規';
  @override
  String get remove => '削除';
  @override
  String get auto => '自動';
  @override
  String get execute => '実行';
  @override
  String get run => '実行';
  @override
  String get unknown => '不明';
  @override
  String get download => 'ダウンロード';
  @override
  String get dropdownArrow => 'ドロップダウン矢印';
  @override
  String get openInNewWindow => '新しいウィンドウで開く';
  @override
  String get resetToDefaults => 'デフォルトにリセット';
}

// Path: menu
class _TranslationsMenuJa extends TranslationsMenuEn {
  _TranslationsMenuJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get file => 'ファイル';
  @override
  String get edit => '編集';
  @override
  String get view => '表示';
  @override
  String get help => 'ヘルプ';
  @override
  String get openFiles => 'ファイルを開く...';
  @override
  String get openFolder => 'フォルダを開く...';
  @override
  String get exportResults => '結果をエクスポート...';
  @override
  String get undo => '元に戻す';
  @override
  String get redo => 'やり直し';
  @override
  String get cut => '切り取り';
  @override
  String get paste => '貼り付け';
  @override
  String get selectAll => 'すべて選択';
  @override
  String get zoomIn => '拡大';
  @override
  String get zoomOut => '縮小';
  @override
  String get resetZoom => 'ズームをリセット';
  @override
  String get documentation => 'ドキュメント';
  @override
  String get reportIssue => '問題を報告';
  @override
  String about({required Object appName}) => '${appName} について';
}

// Path: nav
class _TranslationsNavJa extends TranslationsNavEn {
  _TranslationsNavJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get compare => '比較';
  @override
  String get history => '履歴';
  @override
  String get settings => '設定';
  @override
  String get projects => 'プロジェクト';
  @override
  String get dashboard => 'ダッシュボード';
  @override
  String get directory => 'ディレクトリ';
  @override
  String get repository => 'リポジトリ';
  @override
  String get tooltipCompare => 'ローカリゼーションファイルを比較';
  @override
  String get tooltipHistory => '比較履歴を表示';
  @override
  String get tooltipSettings => 'アプリ設定';
  @override
  String get tooltipProjects => 'プロジェクト管理';
  @override
  String get tooltipThemeToggle => 'テーマの切り替え';
  @override
  String get tooltipDebugConsole => 'デバッグコンソール';
}

// Path: settings
class _TranslationsSettingsJa extends TranslationsSettingsEn {
  _TranslationsSettingsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '設定';
  @override
  String get appSettings => 'アプリ設定';
  @override
  String get projectSettings => 'プロジェクト設定';
  @override
  late final _TranslationsSettingsAppearanceJa appearance =
      _TranslationsSettingsAppearanceJa._(_root);
  @override
  late final _TranslationsSettingsGeneralJa general =
      _TranslationsSettingsGeneralJa._(_root);
  @override
  late final _TranslationsSettingsScopeJa scope =
      _TranslationsSettingsScopeJa._(_root);
  @override
  late final _TranslationsSettingsSearchKeywordsJa searchKeywords =
      _TranslationsSettingsSearchKeywordsJa._(_root);
  @override
  late final _TranslationsSettingsComparisonJa comparison =
      _TranslationsSettingsComparisonJa._(_root);
  @override
  late final _TranslationsSettingsFileHandlingJa fileHandling =
      _TranslationsSettingsFileHandlingJa._(_root);
  @override
  late final _TranslationsSettingsTranslationMemoryJa translationMemory =
      _TranslationsSettingsTranslationMemoryJa._(_root);
  @override
  late final _TranslationsSettingsBackupJa backup =
      _TranslationsSettingsBackupJa._(_root);
  @override
  late final _TranslationsSettingsAiJa ai = _TranslationsSettingsAiJa._(_root);
  @override
  late final _TranslationsSettingsIntegrationsJa integrations =
      _TranslationsSettingsIntegrationsJa._(_root);
  @override
  late final _TranslationsSettingsDeveloperJa developer =
      _TranslationsSettingsDeveloperJa._(_root);
  @override
  late final _TranslationsSettingsAboutJa about =
      _TranslationsSettingsAboutJa._(_root);
  @override
  late final _TranslationsSettingsOnboardingJa onboarding =
      _TranslationsSettingsOnboardingJa._(_root);
  @override
  late final _TranslationsSettingsSettingsViewJa settingsView =
      _TranslationsSettingsSettingsViewJa._(_root);
}

// Path: fileComparison
class _TranslationsFileComparisonJa extends TranslationsFileComparisonEn {
  _TranslationsFileComparisonJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'ファイル比較';
  @override
  String get openFiles => 'ファイルを開く';
  @override
  String get exportResults => '結果をエクスポート';
  @override
  String get restartTutorial => 'チュートリアルを再開';
  @override
  String get restartTutorialDevOnly => 'チュートリアルの再開は開発者モードでのみ利用可能です。';
  @override
  String get unsupportedFileType => 'サポートされていないファイル形式です。';
  @override
  String get unsupportedFileTypeSuggestion =>
      'サポートされているローカリゼーションファイルを選択してください。';
  @override
  String get someFilesUnsupported => '一部のファイルがサポートされていません。';
  @override
  String get pickSupportedFiles => 'サポートされているローカリゼーションファイルのみを選択してください。';
  @override
  String get pickTwoFiles => '比較する 2 つのファイルを選択してください。';
  @override
  String get pickBilingualFile => '比較するバイリンガルファイルを選択してください。';
  @override
  String get noResultsToExport => 'エクスポートする結果がまだありません。';
  @override
  String get performComparisonFirst => '結果をエクスポートするには、まず比較を行ってください。';
  @override
  String get performComparisonFirstEditor => '詳細を確認するには、まず比較を行ってください。';
  @override
  String get sampleDataLoaded => 'サンプルデータを正常に読み込みました';
  @override
  String loadSampleDataError({required Object error}) =>
      'サンプルデータの読み込みに失敗しました: ${error}';
  @override
  String get invalidFileType => '無効なファイル形式です。';
  @override
  String fileSelected({required Object label, required Object fileName}) =>
      '${label} が選択されました: ${fileName}';
  @override
  String get sourceFile => 'ソースファイル';
  @override
  String get targetFile => 'ターゲットファイル';
  @override
  String get bilingualFile => 'バイリンガルファイル';
  @override
  String get compareFiles => 'ファイルを比較';
  @override
  String get compareFile => 'ファイルを比較';
  @override
  String get bilingualMode => 'バイリンガルモード';
  @override
  String get twoFilesMode => '2 ファイルモード';
  @override
  String get processing => '処理中...';
  @override
  String remaining({required Object time}) => '残り ${time}';
  @override
  String get comparisonInProgress => '比較中...';
  @override
  String comparisonFailed({required Object error}) => '比較に失敗しました: ${error}';
  @override
  String fileChanged({required Object fileName}) =>
      'ファイルが変更されました: ${fileName}。再比較中...';
  @override
  String get dropFileHere => 'ここにファイルをドロップ';
  @override
  String get dropFileOrBrowse => 'ファイルをドロップするかクリックして参照';
  @override
  String get fileUpload => 'ファイルをアップロード';
  @override
  String get changeFile => 'ファイルを変更';
  @override
  String get total => '合計';
  @override
  String get show => '表示';
  @override
  String get showAll => 'すべて表示';
  @override
  String noMatches({required Object query}) => '"${query}" に一致する結果はありません';
  @override
  String showingEntries({required Object total, required Object count}) =>
      '${total} 件中 ${count} 件のエントリを表示中';
  @override
  String get filesIdentical => 'ファイルは同一です。';
  @override
  String hiddenIdentical({required Object count}) =>
      '${count} 件の同一エントリが非表示になっています';
  @override
  String get showIdentical => '同一のエントリを表示';
  @override
  String get hideIdentical => '同一のエントリを非表示';
  @override
  String get noDiff => 'キーに基づく差異は見つかりませんでした。';
  @override
  String get source => 'ソース';
  @override
  String get target => 'ターゲット';
  @override
  String get value => '値';
  @override
  String get readyToCompare => '比較の準備ができました';
  @override
  String get readyToCompareDesc =>
      '上にローカリゼーションファイルをドロップするか、参照ボタンを使用して\n比較するファイルを選択してください。';
  @override
  String get recentComparisons => '最近の比較';
  @override
  String bilingualFileLabel({required Object name}) => 'バイリンガルファイル: ${name}';
  @override
  String comparisonLabel({required Object source, required Object target}) =>
      '${source} ↔ ${target}';
  @override
  String get fileNotExist => 'このセッションのファイルの一つ、または両方が存在しません。';
  @override
  String get largeFileTitle => '大きなファイルを検出';
  @override
  String largeFileContent({required Object count}) =>
      '比較結果には ${count} 件のエントリが含まれています。\nすべて表示するとパフォーマンスが低下する可能性があります。\n\n続行しますか？';
  @override
  String get dontShowAgain => 'このファイルについては今後表示しない';
  @override
  String get proceed => '続行';
  @override
  String exportReport({required Object format}) => '${format} レポートを保存';
  @override
  String saved({required Object format}) => '${format} を保存しました';
  @override
  String saveError({required Object format}) => '${format} ファイルの保存に失敗しました。';
  @override
  String saveErrorDetailed({required Object format, required Object error}) =>
      '${format} の保存に失敗しました: ${error}';
  @override
  String get watching => '監視中';
  @override
  String get watchOff => '監視オフ';
  @override
  String watchingTooltip({required Object status}) =>
      'ファイル監視: ${status}\nディスク上のファイルが変更されると自動的に再比較します';
  @override
  String get aiSettingsNotAvailable => 'AI 設定への移動は利用できません';
}

// Path: directoryComparison
class _TranslationsDirectoryComparisonJa
    extends TranslationsDirectoryComparisonEn {
  _TranslationsDirectoryComparisonJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'ディレクトリ比較';
  @override
  String get sourceDirectory => 'ソースディレクトリ';
  @override
  String get targetDirectory => 'ターゲットディレクトリ';
  @override
  String get sourceSubtitle => 'オリジナル/参照ファイル';
  @override
  String get targetSubtitle => '翻訳/比較ファイル';
  @override
  String get selectBothDirectories => 'ソースとターゲットの両方のディレクトリを選択してください。';
  @override
  String get selectSourceFolder => 'ソースフォルダを選択';
  @override
  String get selectTargetFolder => 'ターゲットフォルダを選択';
  @override
  String get dropFolderHere => 'フォルダをドロップするか、参照してください...';
  @override
  String get folderPath => 'フォルダパス';
  @override
  String get readyToCompare => 'ディレクトリ比較の準備完了';
  @override
  String get readyToCompareDesc =>
      '上にフォルダをドロップするか、参照ボタンを使用して\n比較するディレクトリを選択してください。';
  @override
  String get nestedFolders => 'ネストされたフォルダ';
  @override
  String get nestedFoldersTooltip => 'すべてのネストされたディレクトリを再帰的に比較します';
  @override
  String get fileMatching => 'ファイル照合';
  @override
  String get fileMatchingTooltip => '名前でファイルを自動的にペアリングします';
  @override
  String get bulkExport => '一括エクスポート';
  @override
  String get bulkExportTooltip => 'すべての比較結果を一度にエクスポートします';
  @override
  String get notDirectoryComparison => 'これはディレクトリ比較ではありません。';
  @override
  String get directoriesNotExist => '一方または両方のディレクトリが存在しません。';
  @override
  String get errorOccurred => 'エラーが発生しました';
  @override
  String get noFilesFound => '選択したディレクトリにファイルが見つかりません。';
  @override
  String get unmatchedSourceFiles => '一致しないソースファイル';
  @override
  String get unmatchedTargetFiles => '一致しないターゲットファイル';
  @override
  String filePairs({required Object count}) => '${count} 個のファイルペア';
  @override
  String pairedFiles({required Object count}) => 'ペアリングされたファイル (${count})';
  @override
  String get view => '表示';
  @override
  String get failed => '失敗';
  @override
  String get pair => 'ペアリング...';
  @override
  String pairDialogTitle({required Object name}) => '"${name}" のペアを選択:';
  @override
  String get discoverFiles => 'ファイルを検索';
  @override
  String get compareAll => 'すべて比較';
  @override
  String get exportAll => 'すべてエクスポート';
  @override
  String get comparisonStarted => '比較を開始しました...';
  @override
  String get discoveringFiles => 'ファイルを検索中...';
  @override
  String get noResultsToExport => 'エクスポートする比較結果がありません。まず「すべて比較」を実行してください。';
  @override
  String get selectExportFolder => 'エクスポートフォルダを選択';
  @override
  String createExportFolderError({required Object error}) =>
      'エクスポートフォルダの作成に失敗しました: ${error}';
  @override
  String get exportingResults => '結果をエクスポート中';
  @override
  String processingFile({required Object file}) => '処理中: ${file}';
  @override
  String exportProgress({required Object total, required Object current}) =>
      '${total} 中 ${current} 個のファイルをエクスポート済み';
  @override
  String get exportComplete => 'エクスポート完了';
  @override
  String exportSuccessMessage({required Object count}) =>
      '${count} 個の比較ファイルとサマリーを正常にエクスポートしました。';
  @override
  String exportFailed({required Object error}) => 'エクスポート失敗: ${error}';
  @override
  String get close => '閉じる';
}

// Path: gitComparison
class _TranslationsGitComparisonJa extends TranslationsGitComparisonEn {
  _TranslationsGitComparisonJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.';
  @override
  String get title => 'リポジトリ比較';
  @override
  String get repoSelector => 'リポジトリを作成 / 開く';
  @override
  String get noRepoSelected => 'リポジトリが選択されていません';
  @override
  String get open => '開く';
  @override
  String get refreshCommits => 'コミットを更新';
  @override
  String get noCommits => 'コミットが見つからないか、読み込まれていません。ブランチを選択してコミットを読み込んでください。';
  @override
  String get baseCommit => 'ベースコミット（古い方）';
  @override
  String get targetCommit => 'ターゲットコミット（新しい方）';
  @override
  String get filterCommitsByBranch => 'ブランチでコミットをフィルタリング';
  @override
  String get conflictDetection => 'コンフリクト検出';
  @override
  String get conflictDetectionTooltip => 'マージコンフリクトを検出して解決します';
  @override
  String get actions => 'アクション:';
  @override
  String get checkout => 'Checkout';
  @override
  String get merge => 'Merge';
  @override
  String get pull => 'Pull';
  @override
  String get checkoutBranch => 'Checkout Branch';
  @override
  String get mergeBranch => 'Merge Branch into Current';
  @override
  String mergeConfirmation({required Object branch}) => '${branch} をマージしますか？';
  @override
  String get mergeWarning => 'これにより、現在の作業ブランチに変更がマージされます。コンフリクトが発生する可能性があります。';
  @override
  String get selectExportFolder => 'エクスポートフォルダを選択';
  @override
  String createExportFolderError({required Object error}) =>
      'エクスポートフォルダの作成に失敗しました: ${error}';
  @override
  String get exportingFiles => 'ファイルをエクスポート中';
  @override
  String processingFile({required Object file}) => '処理中: ${file}';
  @override
  String exportProgress({required Object total, required Object current}) =>
      '${total} 中 ${current} 個のファイルをエクスポート済み';
  @override
  String get exportComplete => 'エクスポート完了';
  @override
  String exportSuccessMessage({required Object count}) =>
      '${count} 個のファイルをフルコンテンツで正常にエクスポートしました。';
  @override
  String get exportDetail => '各ファイルの差異は "files" サブフォルダに保存されます。';
  @override
  String get diffViewer => '差異ビューア';
  @override
  String get base => 'ベース';
  @override
  String get target => 'ターゲット';
  @override
  String get noLines => '表示する行がありません';
  @override
  String get searchFiles => 'ファイルを検索...';
  @override
  String noFilesMatch({required Object query}) => '"${query}" に一致するファイルはありません';
  @override
  String filesCount({required Object count}) => '${count} 個のファイル';
  @override
  String get selectBaseFile => 'ベースファイルを選択';
  @override
  String get selectTargetFile => 'ターゲットファイルを選択';
  @override
  String get comparisonResults => '比較結果';
  @override
  String get noChanges => '選択した参照間に変更は見つかりませんでした。';
  @override
  String get linesAdded => '追加された行';
  @override
  String get linesRemoved => '削除された行';
  @override
  String get commit => 'Commit';
  @override
  String get branch => 'Branch';
  @override
  String get noRepositorySelected => 'リポジリが選択されていません';
  @override
  String get notGitComparison => 'Git 比較ではありません';
  @override
  String get repositoryNotExist => 'リポジトリが存在しません';
  @override
  String get mainBranch => 'main';
  @override
  String get masterBranch => 'master';
  @override
  String get backToControls => '比較コントロールに戻る';
}

// Path: advancedComparison
class _TranslationsAdvancedComparisonJa
    extends TranslationsAdvancedComparisonEn {
  _TranslationsAdvancedComparisonJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get placeholder => '詳細比較ビュー - プレースホルダー';
}

// Path: advancedDiff
class _TranslationsAdvancedDiffJa extends TranslationsAdvancedDiffEn {
  _TranslationsAdvancedDiffJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get saveAllChanges => 'すべての変更を保存しますか？';
  @override
  String saveConfirmation({required Object count}) =>
      'これにより、修正された ${count} 件のすべてのエントリがターゲットファイルに保存されます。この操作は取り消せません。';
  @override
  String get changesSaved => '変更を正常に保存しました。';
  @override
  String get csvExported => 'CSV をエクスポートしました';
  @override
  String get unsavedChanges => '未保存の変更';
  @override
  String get unsavedChangesWarning => '保存されていない変更があります。破棄してもよろしいですか？';
  @override
  String get discardChanges => '変更を破棄';
  @override
  String get goBack => '戻る';
  @override
  String get breadcrumbs => 'ホーム  >  エディタ';
  @override
  String unsaved({required Object count}) => '${count} 件未保存';
  @override
  String reviewed({required Object count}) => '${count} 件確認済み';
  @override
  String saveAll({required Object count}) => 'すべて保存 (${count})';
  @override
  String get allSaved => 'すべて保存済み';
  @override
  String get saveAllTooltip => 'すべての変更を保存 (Ctrl+S)';
  @override
  String get exportTooltip => 'データをエクスポート (Ctrl+E)';
  @override
  late final _TranslationsAdvancedDiffAiSuggestionJa aiSuggestion =
      _TranslationsAdvancedDiffAiSuggestionJa._(_root);
  @override
  late final _TranslationsAdvancedDiffDetailEditJa detailEdit =
      _TranslationsAdvancedDiffDetailEditJa._(_root);
  @override
  late final _TranslationsAdvancedDiffTableJa table =
      _TranslationsAdvancedDiffTableJa._(_root);
  @override
  late final _TranslationsAdvancedDiffDiffRowJa diffRow =
      _TranslationsAdvancedDiffDiffRowJa._(_root);
  @override
  late final _TranslationsAdvancedDiffStatusJa status =
      _TranslationsAdvancedDiffStatusJa._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarJa sidebar =
      _TranslationsAdvancedDiffSidebarJa._(_root);
}

// Path: issueDetails
class _TranslationsIssueDetailsJa extends TranslationsIssueDetailsEn {
  _TranslationsIssueDetailsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '問題の詳細';
  @override
  String showingIssues({required Object total, required Object count}) =>
      '${total} 件中 ${count} 件の問題を表示中';
  @override
  String get searchPlaceholder => 'キー、テキスト、またはエラーを検索...';
  @override
  String get noDetails => '詳細はありません。';
  @override
  String get noMatches => '一致する項目はありません。';
  @override
  String get showMore => 'さらに表示';
  @override
  String copyItems({required Object count}) => '${count} 件のアイテムをコピー';
  @override
  String get close => '閉じる';
  @override
  String get copied => 'クリップボードにコピーしました';
  @override
  String copiedCount({required Object count}) => '${count} 件のアイテムをコピーしました';
  @override
  late final _TranslationsIssueDetailsDuplicateValueJa duplicateValue =
      _TranslationsIssueDetailsDuplicateValueJa._(_root);
  @override
  late final _TranslationsIssueDetailsLengthOutlierJa lengthOutlier =
      _TranslationsIssueDetailsLengthOutlierJa._(_root);
  @override
  late final _TranslationsIssueDetailsStandardJa standard =
      _TranslationsIssueDetailsStandardJa._(_root);
  @override
  String get review => '確認';
  @override
  late final _TranslationsIssueDetailsTypesJa types =
      _TranslationsIssueDetailsTypesJa._(_root);
  @override
  late final _TranslationsIssueDetailsNotesJa notes =
      _TranslationsIssueDetailsNotesJa._(_root);
  @override
  late final _TranslationsIssueDetailsFallbacksJa fallbacks =
      _TranslationsIssueDetailsFallbacksJa._(_root);
}

// Path: importReview
class _TranslationsImportReviewJa extends TranslationsImportReviewEn {
  _TranslationsImportReviewJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'プロジェクトインポートの確認';
  @override
  String get projectName => 'プロジェクト名';
  @override
  String get created => '作成日';
  @override
  String get historyItems => '履歴アイテム';
  @override
  String get customSettingsTitle => 'カスタム設定を検出';
  @override
  String get customSettingsWarning =>
      'このプロジェクトには、プロジェクトを開いている間にデフォルトを上書きするカスタム設定が含まれています。';
  @override
  String get standardSettings => 'このプロジェクトは標準的なグローバル設定を使用しています。';
  @override
  String get cancelImport => 'インポートをキャンセル';
  @override
  String get trustOpen => '信頼してプロジェクトを開く';
}

// Path: historyView
class _TranslationsHistoryViewJa extends TranslationsHistoryViewEn {
  _TranslationsHistoryViewJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '比較履歴';
  @override
  String get clearAll => 'すべての履歴をクリア';
  @override
  String get searchPlaceholder => 'ファイル名で検索...';
  @override
  String get sortBy => '並び替え';
  @override
  String get sortDate => '日付';
  @override
  String get sortSource => 'ソースファイル';
  @override
  String get sortTarget => 'ターゲットファイル';
  @override
  String get showCurrentProject => '表示中: 現在のプロジェクト';
  @override
  String get showAllHistory => '表示中: すべての履歴';
  @override
  String get groupByFolder => 'フォルダでグループ化';
  @override
  String get disableGrouping => 'グループ化を無効にする';
  @override
  String get filterAll => 'すべて';
  @override
  String get filterFiles => 'ファイル';
  @override
  String get filterDirectories => 'ディレクトリ';
  @override
  String get filterGit => 'Git';
  @override
  String get noHistory => '比較履歴がまだありません';
  @override
  String get historyDescription => 'ここにはファイルの比較履歴が表示されます';
  @override
  String get noResults => '結果が見つかりません';
  @override
  String get adjustSearch => '検索条件を調整してみてください';
  @override
  String get clearConfirmationTitle => 'すべての履歴をクリアしますか？';
  @override
  String get clearConfirmationContent => 'すべての比較履歴を永久に削除します。この操作は取り消せません。';
  @override
  String get clearAction => 'すべてクリア';
  @override
  String get deletedMessage => '履歴アイテムを削除しました';
  @override
  String get undo => '元に戻す';
  @override
  String get viewDetails => '詳細を表示';
  @override
  String get delete => '削除';
  @override
  String get openLocation => 'ファイルの場所を開く';
  @override
  String get bilingual => 'バイリンガル';
  @override
  String get filePair => 'ファイルペア';
  @override
  String get directory => 'ディレクトリ';
  @override
  String get git => 'Git';
  @override
  String get repo => 'リポジトリ';
  @override
  String get sourceDir => 'ソースディレクトリ';
  @override
  String get targetDir => 'ターゲットディレクトリ';
  @override
  String get source => 'ソース';
  @override
  String get target => 'ターゲット';
  @override
  String get noChanges => '変更は検出されませんでした';
  @override
  String get added => '追加済み';
  @override
  String get removed => '削除済み';
  @override
  String get modified => '修正済み';
  @override
  String get same => '同一';
  @override
  String get total => '合計';
  @override
  String get currentProject => '現在のプロジェクト';
  @override
  String get unassigned => '未割り当て';
  @override
  String get project => 'プロジェクト';
}

// Path: compare
class _TranslationsCompareJa extends TranslationsCompareEn {
  _TranslationsCompareJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'ファイルを比較';
  @override
  String get sourceFile => 'ソースファイル';
  @override
  String get targetFile => 'ターゲットファイル';
  @override
  String get sourceFolder => 'ソースフォルダ';
  @override
  String get targetFolder => 'ターゲットフォルダ';
  @override
  String get dropFilesHint =>
      'ここにローカリゼーションファイルをドロップするか、参照ボタンを使用して比較するファイルを選択してください。';
  @override
  String get selectSourceFile => 'ソースファイルを選択';
  @override
  String get selectTargetFile => 'ターゲットファイルを選択';
  @override
  String get startComparison => '比較を開始';
  @override
  String get comparing => '比較中...';
  @override
  String get comparisonComplete => '比較完了';
  @override
  String get noChanges => '変更は検出されませんでした';
  @override
  String get filesIdentical => 'ファイルは同一です';
  @override
  String changesFound({required Object count}) => '${count} 件の変更が見つかりました';
  @override
  late final _TranslationsCompareTabsJa tabs =
      _TranslationsCompareTabsJa._(_root);
  @override
  late final _TranslationsCompareFileTypesJa fileTypes =
      _TranslationsCompareFileTypesJa._(_root);
}

// Path: history
class _TranslationsHistoryJa extends TranslationsHistoryEn {
  _TranslationsHistoryJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '履歴';
  @override
  String get recentComparisons => '最近の比較';
  @override
  String get noHistory => '比較履歴がまだありません';
  @override
  String get noHistoryDescription => 'ここには比較履歴が表示されます';
  @override
  String get clearHistory => '履歴をクリア';
  @override
  String get clearHistoryConfirm => 'すべての履歴をクリアしてもよろしいですか？';
  @override
  String get deleteEntry => 'エントリを削除';
  @override
  String get openComparison => '比較を開く';
  @override
  late final _TranslationsHistoryTimeAgoJa timeAgo =
      _TranslationsHistoryTimeAgoJa._(_root);
}

// Path: projects
class _TranslationsProjectsJa extends TranslationsProjectsEn {
  _TranslationsProjectsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'プロジェクト';
  @override
  String get createProject => 'プロジェクトを作成';
  @override
  String get importProject => 'プロジェクトをインポート';
  @override
  String get noProjects => 'プロジェクトがまだありません';
  @override
  String get noProjectsDescription => 'ローカリゼーションファイルを整理するためにプロジェクトを作成してください';
  @override
  String get projectName => 'プロジェクト名';
  @override
  String get projectPath => 'プロジェクトパス';
  @override
  String get lastOpened => '最終閲覧日';
  @override
  String get openProject => 'プロジェクトを開く';
  @override
  String get closeProject => 'プロジェクトを閉じる';
  @override
  String get deleteProject => 'プロジェクトを削除';
  @override
  String get deleteProjectConfirm => 'このプロジェクトを削除してもよろしいですか？';
  @override
  String get exportProject => 'プロジェクトをエクスポート';
  @override
  String get exportDescription => 'ソースファイル、設定、履歴を含むポータブルな ZIP ファイルを作成します。';
  @override
  String get exporting => 'プロジェクトをエクスポート中...';
  @override
  String get exportSuccess => 'プロジェクトをエクスポートしました';
  @override
  String exportError({required Object error}) => 'エクスポートに失敗しました: ${error}';
  @override
  String get createNewProject => '新規プロジェクト作成';
  @override
  String get openExistingProject => '既存のプロジェクトを開く';
  @override
  String get importProjectZip => 'プロジェクト ZIP をインポート';
  @override
  String get projectResources => 'プロジェクトリソース';
  @override
  String get recentProjects => '最近のプロジェクト';
  @override
  String get noRecentProjects => '最近のプロジェクトはありません';
  @override
  String get selectProjectZip => 'プロジェクト ZIP を選択';
  @override
  String get selectDestination => 'インポート先のフォルダを選択';
  @override
  String get importing => 'プロジェクトをインポート中...';
  @override
  String get importSuccess => 'プロジェクトを正常にインポートしました';
  @override
  String importFailed({required Object error}) => 'インポートに失敗しました: ${error}';
  @override
  String get importingFiles => 'ファイルをインポート中...';
  @override
  String get noSupportedFiles => 'ドロップされたファイルにサポートされている形式はありませんでした。';
  @override
  late final _TranslationsProjectsStatsJa stats =
      _TranslationsProjectsStatsJa._(_root);
  @override
  String get openProjectFirst => 'リソースを管理するには、まずプロジェクトを開いてください。';
  @override
  String get removeFromRecent => '最近使った項目から削除';
  @override
  late final _TranslationsProjectsSelectionJa selection =
      _TranslationsProjectsSelectionJa._(_root);
  @override
  late final _TranslationsProjectsCreateDialogJa createDialog =
      _TranslationsProjectsCreateDialogJa._(_root);
  @override
  late final _TranslationsProjectsIndicatorJa indicator =
      _TranslationsProjectsIndicatorJa._(_root);
  @override
  late final _TranslationsProjectsGlossaryJa glossary =
      _TranslationsProjectsGlossaryJa._(_root);
  @override
  late final _TranslationsProjectsConflictsJa conflicts =
      _TranslationsProjectsConflictsJa._(_root);
  @override
  late final _TranslationsProjectsTmJa tm = _TranslationsProjectsTmJa._(_root);
}

// Path: diff
class _TranslationsDiffJa extends TranslationsDiffEn {
  _TranslationsDiffJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get added => '追加済み';
  @override
  String get removed => '削除済み';
  @override
  String get modified => '修正済み';
  @override
  String get unchanged => '未変更';
  @override
  String get missing => '欠落';
  @override
  String get extra => '余分';
  @override
  String get sourceValue => 'ソースの値';
  @override
  String get targetValue => 'ターゲットの値';
  @override
  String get key => 'キー';
  @override
  String get status => 'ステータス';
  @override
  String get actions => 'アクション';
  @override
  String get copyToTarget => 'ターゲットにコピー';
  @override
  String get acceptChange => '変更を適用';
  @override
  String get rejectChange => '変更を拒否';
  @override
  String get viewDetails => '詳細を表示';
}

// Path: git
class _TranslationsGitJa extends TranslationsGitEn {
  _TranslationsGitJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Git 比較';
  @override
  String get selectRepository => 'リポジトリを選択';
  @override
  String get selectBranch => 'ブランチを選択';
  @override
  String get selectCommit => 'コミットを選択';
  @override
  String get compareBranches => 'ブランチを比較';
  @override
  String get compareCommits => 'コミットを比較';
  @override
  String get baseBranch => 'ベースブランチ';
  @override
  String get compareBranch => '比較ブランチ';
  @override
  String get noRepositories => 'Git リポジトリが見つかりません';
  @override
  String get noRepositoriesDescription => 'Git リポジトリを含むフォルダを開いてください';
  @override
  String filesChanged({required Object count}) => '${count} 個のファイルが変更されました';
  @override
  String additions({required Object count}) => '${count} 個の追加';
  @override
  String deletions({required Object count}) => '${count} 個の削除';
  @override
  late final _TranslationsGitConflictsJa conflicts =
      _TranslationsGitConflictsJa._(_root);
}

// Path: quality
class _TranslationsQualityJa extends TranslationsQualityEn {
  _TranslationsQualityJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.';
  @override
  String get title => '品質ダッシュボード';
  @override
  String get overallScore => '総合スコア';
  @override
  String get issues => '問題';
  @override
  String get warnings => '警告';
  @override
  String get suggestions => '提案';
  @override
  String get placeholderMismatch => 'プレースホルダーの不一致';
  @override
  String get placeholderMismatchDescription =>
      '{name} のようなプレースホルダーがソースとターゲットで一致していません';
  @override
  String get lengthOutlier => '長さの異常値';
  @override
  String get lengthOutlierDescription => '翻訳の長さがソースと大きく異なります';
  @override
  String get duplicateValue => '重複する値';
  @override
  String get duplicateValueDescription => '複数のキーに同じ翻訳が使用されています';
  @override
  String get missingTranslation => '翻訳の欠落';
  @override
  String get missingTranslationDescription => 'このキーの翻訳がありません';
  @override
  String get loading => 'ダッシュボードを読み込み中...';
  @override
  String get errorLoading => '履歴を読み込めませんでした。再試行してください。';
  @override
  String get emptyState => 'ダッシュボードを表示するには比較を実行してください。';
  @override
  String get refresh => '更新';
  @override
  String get buildingInsights => 'インサイトを構築中...';
  @override
  String get crunchingNumbers => '数値を計算中...';
  @override
  String get errorBuilding => 'ダッシュボードを構築できませんでした。再試行してください。';
  @override
  String get noUsableData => '使用可能なデータがまだ見つかりません。';
  @override
  String get languages => '言語';
  @override
  String get averageCoverage => '平均カバレッジ';
  @override
  String get potentialIssues => '潜在的な問題';
  @override
  String get translationCoverage => '翻訳カバレッジ';
  @override
  String entriesTranslated(
          {required Object total, required Object translated}) =>
      '${total} 件中 ${translated} 件のエントリが翻訳済み';
  @override
  String get wordsAddedOverTime => '追加された語数の推移';
  @override
  String get completionVsScope => '完了率 vs スコープ';
  @override
  String get scopeVsProgress => 'スコープ vs 進捗';
  @override
  String get coveragePercent => 'カバレッジ %';
  @override
  String get wordsAdded => '追加された語数';
  @override
  String get words => '語';
  @override
  String get coverage => 'カバレッジ';
  @override
  String get scope => 'スコープ';
  @override
  String get latest => '最新';
  @override
  String get added => '追加済み';
  @override
  String get change => '変更';
  @override
  String get totalScope => '合計スコープ';
  @override
  String wordsCount({required Object count}) => '${count} 語';
  @override
  String get scopeGrowth => 'スコープの増加';
  @override
  String get range => '範囲';
  @override
  String get aiUsage => 'AI と翻訳の使用状況';
  @override
  String lastUsed({required Object date}) => '最終使用日 ${date}';
  @override
  String get noIssuesFound => '最新の比較で問題は見つかりませんでした。';
  @override
  String get placeholderMismatches => 'プレースホルダーの不一致';
  @override
  String get placeholderMismatchesDesc => '{name} のようなマーカーが一致しません。';
  @override
  String get lengthOutliers => '極端に短い、または長い翻訳';
  @override
  String get lengthOutliersDesc => 'ソースと比較して長さが不自然です。';
  @override
  String get duplicateValues => '重複する値';
  @override
  String get duplicateValuesDesc => '同じ翻訳が何度も使用されています。';
  @override
  String get placeholderDialogTitle => 'プレースホルダーの不一致';
  @override
  String get placeholderDialogDesc =>
      'これらの翻訳には、ソースと異なるプレースホルダー ({name}) が含まれています。';
  @override
  String get lengthDialogTitle => '長さの異常値';
  @override
  String get lengthDialogDesc => 'これらの翻訳は、ソースより大幅に短いか長くなっています。';
  @override
  String get duplicateDialogTitle => '重複する値';
  @override
  String get duplicateDialogDesc => 'これらの翻訳は複数回出現します。';
  @override
  String duplicateSample({required Object value}) => '重複: "${value}"';
  @override
  String get exportError => 'レポートを作成できませんでした。もう一度お試しください。';
  @override
  String get noDataToExport => 'エクスポートするデータがありません';
  @override
  String get exportFailed => 'エクスポート失敗';
  @override
  String get exportDialogTitle => '品質レポートをエクスポート';
  @override
  String get reportSaved => 'レポートを保存しました';
  @override
  String get export => 'エクスポート';
  @override
  String get requests => 'リクエスト';
  @override
  String get tokens => 'トークン';
  @override
  String get characters => '文字数';
  @override
  String get estCost => '推定コスト';
  @override
  String get prompt => 'プロンプト';
  @override
  String get completion => '完了';
  @override
  String get showingCurrentProject => '表示中: 現在のプロジェクト';
  @override
  String get showingAllHistory => '表示中: すべての履歴';
  @override
  String get filesSkipped => '一部のファイルが見つからなかったため、スキップされました。';
}

// Path: errors
class _TranslationsErrorsJa extends TranslationsErrorsEn {
  _TranslationsErrorsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get genericError => 'エラーが発生しました';
  @override
  String get fileNotFound => 'ファイルが見つかりません';
  @override
  String get invalidFormat => '無効なファイル形式';
  @override
  String get parseError => 'ファイルの解析に失敗しました';
  @override
  String get networkError => 'ネットワークエラー。接続を確認してください。';
  @override
  String get permissionDenied => 'アクセス許可が拒否されました';
  @override
  String get unknownError => '不明なエラーが発生しました';
}

// Path: wizards
class _TranslationsWizardsJa extends TranslationsWizardsEn {
  _TranslationsWizardsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsWizardsFirstRunJa firstRun =
      _TranslationsWizardsFirstRunJa._(_root);
}

// Path: dialogs
class _TranslationsDialogsJa extends TranslationsDialogsEn {
  _TranslationsDialogsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDialogsAddIgnorePatternJa addIgnorePattern =
      _TranslationsDialogsAddIgnorePatternJa._(_root);
  @override
  late final _TranslationsDialogsDiffViewerJa diffViewer =
      _TranslationsDialogsDiffViewerJa._(_root);
}

// Path: grid
class _TranslationsGridJa extends TranslationsGridEn {
  _TranslationsGridJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGridColumnsJa columns =
      _TranslationsGridColumnsJa._(_root);
}

// Path: tutorial
class _TranslationsTutorialJa extends TranslationsTutorialEn {
  _TranslationsTutorialJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'チュートリアルをスキップ';
  @override
  String get finishMessage => '準備が整いました！どこかをタップして終了します。';
  @override
  String get next => '次へ';
  @override
  String get loadSampleData => 'サンプルデータを読み込む';
  @override
  String get browseSourceFile => 'ソースファイルを参照';
  @override
  String get browseTargetFile => 'ターゲットファイルを参照';
  @override
  String get compareFiles => 'ファイルを比較';
  @override
  String get hintPhase2 => '次へ: フィルタ、検索、詳細ビュー、エクスポート。';
  @override
  late final _TranslationsTutorialStepsJa steps =
      _TranslationsTutorialStepsJa._(_root);
}

// Path: friendlyErrors
class _TranslationsFriendlyErrorsJa extends TranslationsFriendlyErrorsEn {
  _TranslationsFriendlyErrorsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsFriendlyErrorsFileNotFoundJa fileNotFound =
      _TranslationsFriendlyErrorsFileNotFoundJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsAccessDeniedJa accessDenied =
      _TranslationsFriendlyErrorsAccessDeniedJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsIsDirectoryJa isDirectory =
      _TranslationsFriendlyErrorsIsDirectoryJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsFileAccessJa fileAccess =
      _TranslationsFriendlyErrorsFileAccessJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsUnsupportedFormatJa unsupportedFormat =
      _TranslationsFriendlyErrorsUnsupportedFormatJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsNetworkErrorJa networkError =
      _TranslationsFriendlyErrorsNetworkErrorJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsNotGitRepoJa notGitRepo =
      _TranslationsFriendlyErrorsNotGitRepoJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsMergeConflictJa mergeConflict =
      _TranslationsFriendlyErrorsMergeConflictJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitAuthFailedJa gitAuthFailed =
      _TranslationsFriendlyErrorsGitAuthFailedJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitOperationFailedJa
      gitOperationFailed =
      _TranslationsFriendlyErrorsGitOperationFailedJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidJsonJa invalidJson =
      _TranslationsFriendlyErrorsInvalidJsonJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsRateLimitReachedJa rateLimitReached =
      _TranslationsFriendlyErrorsRateLimitReachedJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidApiKeyJa invalidApiKey =
      _TranslationsFriendlyErrorsInvalidApiKeyJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsTranslationServiceErrorJa
      translationServiceError =
      _TranslationsFriendlyErrorsTranslationServiceErrorJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsOutOfMemoryJa outOfMemory =
      _TranslationsFriendlyErrorsOutOfMemoryJa._(_root);
  @override
  late final _TranslationsFriendlyErrorsGenericErrorJa genericError =
      _TranslationsFriendlyErrorsGenericErrorJa._(_root);
}

// Path: systemTray
class _TranslationsSystemTrayJa extends TranslationsSystemTrayEn {
  _TranslationsSystemTrayJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get showLocalizer => 'Localizer を表示';
  @override
  String get exit => '終了';
}

// Path: validation
class _TranslationsValidationJa extends TranslationsValidationEn {
  _TranslationsValidationJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get connected => '接続されました。';
  @override
  String get connectionTimeout => '接続がタイムアウトしました。もう一度お試しください。';
  @override
  String get couldNotConnect => '接続できませんでした。もう一度お試しください。';
  @override
  String get checkKeyAndTryAgain => '接続できませんでした。キーを確認してもう一度お試しください。';
  @override
  String get tryAgainLater => '現在接続できません。後でもう一度お試しください。';
  @override
  String get serviceUnavailable => 'サービスは現在利用できません。後でもう一度お試しください。';
  @override
  String get enterKeyFirst => 'まずキーを入力してください。';
  @override
  String get checking => '確認中...';
  @override
  String deeplUsage({required Object limit, required Object used}) =>
      '使用状況: ${limit} 文字中 ${used} 文字。';
}

// Path: status
class _TranslationsStatusJa extends TranslationsStatusEn {
  _TranslationsStatusJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get startingComparison => '比較を開始しています...';
  @override
  String get loadingFromHistory => '履歴からファイルを読み込んでいます...';
  @override
  String get comparisonComplete => '比較完了';
  @override
  String get couldNotImportFiles => 'ファイルをインポートできませんでした。もう一度お試しください。';
  @override
  String get historyFilesNotFound => '履歴にあるファイルの一つ、または両方が元のパスに見つかりませんでした。';
}

// Path: aiServices
class _TranslationsAiServicesJa extends TranslationsAiServicesEn {
  _TranslationsAiServicesJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get geminiEmptyResponse => 'Gemini が空の応答を返しました';
  @override
  String get geminiStreamingEmpty => 'Gemini ストリーミングが空の応答を返しました';
  @override
  String get geminiRephraseEmpty => 'Gemini が言い換えに対して空の応答を返しました';
  @override
  String get openaiEmptyResponse => 'OpenAI が空の応答または失敗の応答を返しました';
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceJa
    extends TranslationsSettingsAppearanceEn {
  _TranslationsSettingsAppearanceJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '外観';
  @override
  String get description => 'アプリの見た目をカスタマイズします';
  @override
  String get theme => 'テーマモード';
  @override
  String get themeDescription => 'ライト、ダーク、またはシステムテーマを選択します';
  @override
  String get themeSystem => 'システム';
  @override
  String get themeLight => 'ライト';
  @override
  String get themeDark => 'ダーク';
  @override
  String get themeAmoled => 'AMOLED';
  @override
  String get accentColor => 'アクセントカラー';
  @override
  String get accentColorDescription => 'お好みのアクセントカラーを選択します';
  @override
  String get useMicaEffect => 'Micaエフェクトを使用';
  @override
  String get micaDescription => 'モダンな見た目のためにWindows 11のMica透過エフェクトを有効にします';
  @override
  String get diffFontSize => '比較フォントサイズ';
  @override
  String get diffFontSizeDescription => '比較ビューのフォントサイズを調整します';
  @override
  String get diffFontFamily => '比較フォントファミリー';
  @override
  String get diffFontFamilyDescription => '比較ビューに使用するフォント';
  @override
  String get systemDefault => 'システムデフォルト';
  @override
  String get pickAccentColor => 'アクセントカラーを選択';
  @override
  String get diffColors => '比較色';
  @override
  String get presetsTitle => 'プリセット';
  @override
  late final _TranslationsSettingsAppearancePresetsJa presets =
      _TranslationsSettingsAppearancePresetsJa._(_root);
  @override
  String get identical => '同一';
  @override
  String pickColorFor({required Object label}) => '${label} の色を選択';
  @override
  String get livePreview => 'ライブプレビュー';
  @override
  late final _TranslationsSettingsAppearancePreviewJa preview =
      _TranslationsSettingsAppearancePreviewJa._(_root);
}

// Path: settings.general
class _TranslationsSettingsGeneralJa extends TranslationsSettingsGeneralEn {
  _TranslationsSettingsGeneralJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '全般';
  @override
  String get description => '全般的なアプリケーション設定';
  @override
  String get language => '言語';
  @override
  String get languageDescription => '使用する言語を選択します';
  @override
  String get startMinimized => 'トレイに最小化して起動';
  @override
  String get startMinimizedDescription => 'システムトレイに最小化した状態でアプリを起動します';
  @override
  String get rememberWindowPosition => 'ウィンドウ位置を記憶';
  @override
  String get rememberWindowPositionDescription => '起動時にウィンドウのサイズと位置を復元します';
  @override
  String get openLastProject => '起動時に最後のプロジェクトを開く';
  @override
  String get openLastProjectDescription => 'アプリ起動時に最後に使用したプロジェクトを自動的に開きます';
  @override
  String get application => 'アプリケーション';
  @override
  String get defaultView => 'デフォルトビュー';
  @override
  String get defaultViewDescription => '起動時に表示するビュー';
  @override
  String get autoCheckUpdates => 'アップデートの自動確認';
  @override
  String get autoCheckUpdatesDescription => '起動時にアップデートを確認します';
  @override
  String get startupOptions => '起動オプション';
  @override
  String get languageAuto => '自動検出';
  @override
  String get viewBasic => 'ファイル比較';
  @override
  String get viewHistory => '履歴';
  @override
  String get viewDashboard => '品質ダッシュボード';
  @override
  String get viewDirectory => 'ディレクトリ比較';
  @override
  String get viewLastUsed => '最後に使用したビュー';
}

// Path: settings.scope
class _TranslationsSettingsScopeJa extends TranslationsSettingsScopeEn {
  _TranslationsSettingsScopeJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '設定のスコープ';
  @override
  String get global => 'グローバルデフォルト';
  @override
  String get project => 'プロジェクト';
  @override
  String get reset => 'プロジェクトをグローバルデフォルトにリセット';
  @override
  String get resetConfirmation =>
      'これにより、このプロジェクトのすべてのオーバーライドが解除され、グローバルデフォルトに戻ります。この操作は取り消せません。';
  @override
  String get globalDescription => '変更は、個別に上書きされない限りすべてのプロジェクトに適用されます。';
  @override
  String projectDescription({required Object name}) =>
      '変更は "${name}" にのみ適用されます。その他の設定はグローバルデフォルトから継承されます。';
  @override
  String get createPrompt => '特定のフォルダの設定をカスタマイズするにはプロジェクトを作成してください';
}

// Path: settings.searchKeywords
class _TranslationsSettingsSearchKeywordsJa
    extends TranslationsSettingsSearchKeywordsEn {
  _TranslationsSettingsSearchKeywordsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  List<String> get general => [
        '言語',
        'デフォルトビュー',
        '最近使ったファイルの数',
        '最後のプロジェクトを開く',
        '終了前に確認',
        '通知を表示',
      ];
  @override
  List<String> get comparisonEngine => [
        '比較モード',
        '類似度しきい値',
        '大文字小文字を区別',
        '空白を無視',
        '空行を無視',
        'コメントを無視',
        'パターンを無視',
      ];
  @override
  List<String> get appearance => [
        'テーマ',
        'テーマモード',
        'アクセントカラー',
        '比較フォントサイズ',
        '比較フォントファミリー',
        '比較色',
        '追加された色',
        '削除された色',
        '変更された色',
        '同一の色',
        'カラープリセット',
        'プレビュー',
      ];
  @override
  List<String> get fileHandling => [
        'ソース形式',
        'ターゲット形式',
        'デフォルトエンコーディング',
        '最近のプロジェクト数',
        '翻訳メモリ',
        'メモリのインポート',
        'メモリのエクスポート',
        'メモリのクリア',
      ];
  @override
  List<String> get aiServices => [
        'OpenAI APIキー',
        'Anthropic APIキー',
        'Google AI APIキー',
        'AIモデル',
        '温度',
        'カスタムプロンプト',
      ];
  @override
  List<String> get systemIntegrations => [
        'システムトレイ',
        '最小化して起動',
        'ファイルの関連付け',
        'Micaエフェクト',
        'バイブランシー',
        'ウィンドウ素材',
        'Dockバッジ',
        '未翻訳数',
      ];
  @override
  List<String> get projectResources => [
        '用語集',
        '翻訳メモリ',
        '用語',
      ];
  @override
  List<String> get about => [
        'バージョン',
        'アップデートを確認',
        '自動アップデート',
        '変更履歴',
        'ライセンス',
        'プライバシーポリシー',
        'テレメトリ',
        'クラッシュレポート',
      ];
  @override
  List<String> get developer => [
        'パフォーマンスオーバーレイ',
        'セマンティクスデバッガ',
        'マテリアルグリッド',
        'ラスターキャッシュ',
        'チュートリアルを再開',
        '工場出荷時設定にリセット',
      ];
}

// Path: settings.comparison
class _TranslationsSettingsComparisonJa
    extends TranslationsSettingsComparisonEn {
  _TranslationsSettingsComparisonJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '比較';
  @override
  String get description => '比較動作を設定します';
  @override
  String get caseSensitive => '大文字小文字を区別';
  @override
  String get caseSensitiveDescription => '大文字と小文字を異なる文字として扱います';
  @override
  String get ignoreWhitespace => '空白を無視';
  @override
  String get ignoreWhitespaceDescription => '比較時に先頭および末尾の空白を無視します';
  @override
  String get showLineNumbers => '行番号を表示';
  @override
  String get showLineNumbersDescription => '比較ビューに行番号を表示します';
  @override
  String get behavior => '比較動作';
  @override
  String get ignoreCase => '大文字小文字を無視';
  @override
  String get ignoreCaseDescription => '"Key" と "key" を同じものとして扱います';
  @override
  String get similarityThreshold => '類似度しきい値';
  @override
  String get similarityThresholdDescription => '「変更」として検出する最小の類似度';
  @override
  String get mode => '比較モード';
  @override
  String get modeDescription => 'ファイル間でエントリを照合する方法';
  @override
  String get modeKey => 'キーベース';
  @override
  String get modeKeyDescription => 'キー名で照合します（デフォルト）。';
  @override
  String get modeOrder => '順序ベース';
  @override
  String get modeOrderDescription => 'ファイル内の位置で照合します。';
  @override
  String get modeSmart => 'スマートマッチ';
  @override
  String get modeSmartDescription => '移動または名前が変更されたキーを検出します。';
  @override
  String get ignorePatterns => '無視パターン';
  @override
  String get noIgnorePatterns => '無視パターンが設定されていません。';
  @override
  String get addPattern => 'パターンを追加';
  @override
  String get resetToGlobal => 'すべての比較設定をグローバルデフォルトにリセット';
  @override
  late final _TranslationsSettingsComparisonPatternPresetsJa patternPresets =
      _TranslationsSettingsComparisonPatternPresetsJa._(_root);
  @override
  late final _TranslationsSettingsComparisonPreviewMatchJa previewMatch =
      _TranslationsSettingsComparisonPreviewMatchJa._(_root);
  @override
  late final _TranslationsSettingsComparisonColorPresetsJa colorPresets =
      _TranslationsSettingsComparisonColorPresetsJa._(_root);
}

// Path: settings.fileHandling
class _TranslationsSettingsFileHandlingJa
    extends TranslationsSettingsFileHandlingEn {
  _TranslationsSettingsFileHandlingJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get fileFormats => 'ファイル形式';
  @override
  String get sourceFormat => 'ソース形式';
  @override
  String get targetFormat => 'ターゲット形式';
  @override
  String get encoding => 'エンコーディング';
  @override
  String get sourceEncoding => 'ソースエンコーディング';
  @override
  String get targetEncoding => 'ターゲットエンコーディング';
  @override
  String get autoDetect => '自動検出';
  @override
  String get autoDetectEncodingDescription => 'ファイルのエンコーディングを自動的に検出します';
  @override
  String get exportSettings => 'エクスポート設定';
  @override
  String get defaultExportFormat => 'デフォルトのエクスポート形式';
  @override
  String get includeUtf8Bom => 'UTF-8 BOMを含める';
  @override
  String get includeUtf8BomDescription => 'Excelとの互換性に必要です';
  @override
  String get openFolderAfterExport => 'エクスポート後にフォルダを開く';
  @override
  String get fileSafety => 'ファイルの安全性';
  @override
  String get fileSafetyDescription => '障害復旧のための自動ローカルコピー。';
  @override
  String get resetToGlobal => 'すべてのファイル処理設定をグローバルデフォルトにリセット';
}

// Path: settings.translationMemory
class _TranslationsSettingsTranslationMemoryJa
    extends TranslationsSettingsTranslationMemoryEn {
  _TranslationsSettingsTranslationMemoryJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'グローバル翻訳メモリ';
  @override
  String get autoLearn => '自動学習';
  @override
  String get autoLearnDescription => '将来的な再利用のために翻訳をローカルメモリに保存します';
  @override
  String get confidenceThreshold => '信頼度しきい値';
  @override
  String confidenceThresholdDescription({required Object percent}) =>
      '自動適用する最小スコア（${percent}%）';
  @override
  String get entries => 'エントリ';
  @override
  String get size => 'サイズ';
  @override
  String memorySize({required Object size}) => 'メモリサイズ: ${size}';
  @override
  String get import => 'インポート';
  @override
  String get exportTmx => 'TMXをエクスポート';
  @override
  String get exportCsv => 'CSVをエクスポート';
  @override
  String get clearMemory => 'メモリをクリア';
  @override
  String importedItems({required Object count}) =>
      '${count} 件のアイテムをメモリにインポートしました。';
  @override
  String get noItemsAdded => 'アイテムは追加されませんでした。';
  @override
  String get nothingToExport => 'エクスポートするデータがありません。';
  @override
  String get tmxSaved => 'TMXを保存しました';
  @override
  String get csvSaved => 'CSVを保存しました';
  @override
  String get clearConfirmTitle => '翻訳メモリをクリアしますか？';
  @override
  String get clearConfirmContent =>
      'これにより、このデバイスに保存されているすべての翻訳ペアが削除されます。この操作は取り消せません。';
  @override
  String get cleared => '翻訳メモリをクリアしました。';
  @override
  String get couldNotClear => 'メモリをクリアできませんでした。';
}

// Path: settings.backup
class _TranslationsSettingsBackupJa extends TranslationsSettingsBackupEn {
  _TranslationsSettingsBackupJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '自動バックアップ';
  @override
  String get description => '自動バックアップ設定';
  @override
  String get enabled => '自動バックアップを有効にする';
  @override
  String get enabledDescription => '変更を加える前にファイルを自動的にバックアップします';
  @override
  String get maxCopies => '最大バックアップ数';
  @override
  String get maxCopiesDescription => 'ファイルごとに保持するバックアップコピーの数';
  @override
  String activeStatus({required Object count}) => '有効 · ${count} 個のコピーを保持中';
  @override
  String get folder => 'バックアップフォルダ';
  @override
  String get folderDescription => '同じフォルダを使用する場合は空のままにしてください';
  @override
  String get useOriginalFolder => '元のファイルフォルダを使用';
}

// Path: settings.ai
class _TranslationsSettingsAiJa extends TranslationsSettingsAiEn {
  _TranslationsSettingsAiJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'AI サービス';
  @override
  String get description => 'AI 翻訳とアシスタンスを設定します';
  @override
  String get provider => 'AI プロバイダー';
  @override
  String get providerDescription => 'お好みの AI サービスプロバイダーを選択します';
  @override
  String get apiKey => 'API キー';
  @override
  String get apiKeyDescription => '選択したプロバイダーの API キーを入力します';
  @override
  String get apiKeyPlaceholder => 'API キーを入力...';
  @override
  String get testConnection => '接続テスト';
  @override
  String get connectionSuccess => '接続に成功しました！';
  @override
  String get connectionFailed => '接続に失敗しました。API キーを確認してください。';
  @override
  String get translationStrategy => '翻訳戦略';
  @override
  String get strategy => '戦略';
  @override
  String get strategyDescription => '文字列をどのように翻訳するか選択します';
  @override
  String get strategyLLM => '生成 AI (LLM)';
  @override
  String get strategyCloud => 'クラウド翻訳';
  @override
  String get enableAiTranslation => 'AI 翻訳を有効にする';
  @override
  String get enableAiTranslationDescription => '翻訳の提案に AI を使用することを許可します';
  @override
  String get llmProvider => 'LLM サービスプロバイダー';
  @override
  String get service => 'サービス';
  @override
  String get serviceDescription => '生成 AI のプロバイダー';
  @override
  String get providerGemini => 'Google Gemini';
  @override
  String get providerOpenAI => 'OpenAI';
  @override
  String get geminiApiKey => 'Gemini API キー';
  @override
  String get openAiApiKey => 'OpenAI API キー';
  @override
  String get model => 'モデル';
  @override
  String get modelDescription => '使用するモデルを選択します';
  @override
  String get advancedParameters => '詳細パラメータ';
  @override
  String get parameters => 'パラメータ';
  @override
  String get parametersDescription => '温度、コンテキストなど';
  @override
  String get temperature => '温度';
  @override
  String get temperatureDescription => '値を高くすると、よりクリエイティブな出力になります';
  @override
  String get maxTokens => '最大トークン数';
  @override
  String get maxTokensDescription => 'コンテキストウィンドウの長さを制限します';
  @override
  String get systemContext => 'システムコンテキスト / 指示';
  @override
  String get systemContextHint => 'あなたはプロのローカライザーです。ソース文字列のトーンと意図を維持してください...';
  @override
  String get systemContextHelper => 'プロジェクトのスタイルや用語について、AI に具体的な指示を与えます。';
  @override
  String get contextStrings => 'コンテキスト文字列';
  @override
  String get contextStringsDescription => 'より良いコンテキストのために周囲の文字列を含めます';
  @override
  String get contextCount => 'コンテキスト数';
  @override
  String get contextCountDescription => '含める周囲の文字列の数';
  @override
  String get cloudServices => 'クラウド翻訳サービス';
  @override
  String get googleTranslateApiKey => 'Google 翻訳 API キー';
  @override
  String get deeplApiKey => 'DeepL API キー';
  @override
  String get test => 'テスト';
  @override
  String get resetToGlobal => 'すべての AI 設定をグローバルデフォルトにリセット';
}

// Path: settings.integrations
class _TranslationsSettingsIntegrationsJa
    extends TranslationsSettingsIntegrationsEn {
  _TranslationsSettingsIntegrationsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get platformNotice => 'プラットフォームに関する注意';
  @override
  String get platformNoticeDescription => 'このプラットフォームではシステム連携をご利用いただけません。';
  @override
  String get visualEffects => '視覚効果';
  @override
  String get explorerIntegration => 'エクスプローラー連携';
  @override
  String get explorerIntegrationDescription =>
      'フォルダの右クリックメニューに「Localizer で開く」を追加します。';
  @override
  String get addToContextMenu => 'コンテキストメニューに追加';
  @override
  String get contextMenuAdded => 'コンテキストメニューに追加しました！';
  @override
  String get contextMenuAddError => 'コンテキストメニューへの追加に失敗しました';
  @override
  String get contextMenuRemoved => 'コンテキストメニューから削除しました！';
  @override
  String get contextMenuRemoveError => 'コンテキストメニューからの削除に失敗しました';
  @override
  String get fileAssociations => 'ファイルの関連付け';
  @override
  String get fileAssociationsDescription =>
      'エクスプローラーでダブルクリックしたときに Localizer で開くファイル形式を登録します。';
  @override
  String get registered => '登録済み';
  @override
  String get notRegistered => '未登録';
  @override
  String extRegistered({required Object ext}) => '${ext} を登録しました！';
  @override
  String extUnregistered({required Object ext}) => '${ext} の登録を解除しました！';
  @override
  String extError({required Object ext, required Object action}) =>
      '${ext} の ${action} に失敗しました';
  @override
  String get registerAll => 'すべて登録';
  @override
  String get unregisterAll => 'すべて解除';
  @override
  String registerAllResult({required Object total, required Object success}) =>
      '${total} 個中 ${success} 個のファイル形式を登録しました';
  @override
  String unregisterAllResult(
          {required Object total, required Object success}) =>
      '${total} 個中 ${success} 個のファイル形式の登録を解除しました';
  @override
  String get protocolHandler => 'プロトコルハンドラー';
  @override
  String get protocolHandlerDescription =>
      'このアプリケーションを開くための localizer:// URL を登録します。ブラウザのリンクなどから直接プロジェクトを開けるようになります。';
  @override
  String get protocolRegistered => 'プロトコルハンドラーは登録済みです';
  @override
  String get protocolNotRegistered => 'プロトコルハンドラーは未登録です';
  @override
  String get registerProtocol => 'プロトコルを登録';
  @override
  String get unregister => '登録解除';
  @override
  String get protocolRegisteredSuccess => 'プロトコルハンドラーを登録しました！';
  @override
  String get protocolRemovedSuccess => 'プロトコルハンドラーを削除しました！';
  @override
  String get protocolRegisterError => '登録に失敗しました';
  @override
  String get protocolRemoveError => '削除に失敗しました';
  @override
  String get windowMaterial => 'ウィンドウ素材';
  @override
  String get windowMaterialDescription => 'macOS のバイブランシー素材スタイルを選択します';
  @override
  String get dockIntegration => 'Dock 連携';
  @override
  String get showDockBadge => '未翻訳数を表示';
  @override
  String get showDockBadgeDescription => 'Dock アイコンのバッジに未翻訳文字列の数を表示します';
  @override
  late final _TranslationsSettingsIntegrationsMaterialsJa materials =
      _TranslationsSettingsIntegrationsMaterialsJa._(_root);
  @override
  late final _TranslationsSettingsIntegrationsFileTypesJa fileTypes =
      _TranslationsSettingsIntegrationsFileTypesJa._(_root);
}

// Path: settings.developer
class _TranslationsSettingsDeveloperJa extends TranslationsSettingsDeveloperEn {
  _TranslationsSettingsDeveloperJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '開発者設定';
  @override
  String get description => '開発者向けの詳細設定';
  @override
  String get showLocalizationKeys => 'ローカリゼーションキーを表示';
  @override
  String get localizationKeysDescription =>
      '有効にすると、すべての翻訳テキストが翻訳後の値ではなくローカリゼーションキーとして表示されます。どのキーがどこで使用されているか確認するのに便利です。';
  @override
  String get showPerformanceOverlay => 'パフォーマンスオーバーレイを表示';
  @override
  String get performanceOverlayDescription => 'FPS とフレームタイミィング情報を表示します';
  @override
  String get debugMode => 'デバッグモード';
  @override
  String get debugModeDescription => '追加のログ記録とデバッグ機能を有効にします';
  @override
  String get debuggingTools => 'デバッグツール';
  @override
  String get semanticsDebugger => 'セマンティクスデバッガ';
  @override
  String get semanticsDebuggerDescription => 'セマンティクスツリーを可視化します';
  @override
  String get materialGrid => 'マテリアルグリッド';
  @override
  String get materialGridDescription => 'マテリアルレイアウトグリッドをオーバーレイ表示します';
  @override
  String get rasterCache => 'ラスターキャッシュイメージ';
  @override
  String get rasterCacheDescription => 'ラスターキャッシュイメージをチェッカーボード表示します';
  @override
  String get actions => 'アクション';
  @override
  String get showLogs => 'アプリアログを表示';
  @override
  String get showLogsDescription => 'Talker デバッグコンソールを開きます';
  @override
  String get restartTutorial => 'オンボーディングチュートリアルを再開';
  @override
  String get restartTutorialDescription => 'フラグをリセットしてチュートリアルを再度開始します';
  @override
  String get restartRequested => 'チュートリアルの再開がリクエストされました。';
  @override
  String get throwException => 'テスト例外をスロー';
  @override
  String get throwExceptionDescription => 'クラッシュレポート用のテスト例外を発生させます';
  @override
  String get testExceptionMessage => '開発者オプションからテスト例外が発生しました';
  @override
  String get clearTM => '翻訳メモリをクリア';
  @override
  String get clearTMDescription => 'キャッシュされたすべての翻訳を削除します';
  @override
  String get clearTMConfirmation => '翻訳メモリをクリアしますか？';
  @override
  String get clearTMWarning => 'これにより、学習したすべての翻訳が削除されます。この操作は取り消せません。';
  @override
  String get tmCleared => '翻訳メモリをクリアしました';
  @override
  String get clearApiKeys => 'API キーをクリア';
  @override
  String get clearApiKeysDescription => '保存されているすべての API キーを削除します';
  @override
  String get clearApiKeysConfirmation => 'API キーをクリアしますか？';
  @override
  String get clearApiKeysWarning => 'これにより、セキュアストレージからすべての API キーが削除されます。';
  @override
  String get apiKeysCleared => 'API キーをクリアしました';
  @override
  String get hideOptions => '開発者オプションを非表示にする';
  @override
  String get hideOptionsDescription => '開発者モードを無効にします（再有効化には 7 回タップが必要です）';
  @override
  String get optionsDisabled => '開発者オプションを無効にしました';
  @override
  String get dangerZone => '危険ゾーン';
  @override
  String get factoryReset => '工場出荷時設定にリセット';
  @override
  String get factoryResetDescription => 'すべての設定をリセットし、データを消去します';
  @override
  String get factoryResetWarning => 'すべての設定をリセットしてもよろしいですか？この操作は取り消せません。';
  @override
  String get inspectionTools => 'インスペクションツール';
  @override
  String get searchHint => '設定を検索...';
  @override
  String get resetToDefault => 'デフォルトにリセット';
  @override
  String get resetToGlobal => 'グローバルデフォルトにリセット';
  @override
  String get storageInspector => 'ストレージインスペクタ';
  @override
  String get storageInspectorDescription => 'Hive およびセキュアストレージの内容を表示します';
  @override
  String get deviceEnvironment => 'デバイスと環境';
  @override
  String get deviceEnvironmentDescription => '画面、プラットフォーム、ビルド情報';
  @override
  String get themePlayground => 'テーマプレイグラウンド';
  @override
  String get themePlaygroundDescription => 'カラーパレットとタイポグラフィ';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionJa
      themePlaygroundSection =
      _TranslationsSettingsDeveloperThemePlaygroundSectionJa._(_root);
  @override
  String get localizationInspector => 'ローカリゼーションインスペクタ';
  @override
  String get localizationInspectorDescription => '翻訳文字列をデバッグします';
  @override
  String get hiveAppSettings => 'Hive (AppSettings)';
  @override
  String get secureStorageMasked => 'セキュアストレージ (マスク済み)';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsJa featureFlags =
      _TranslationsSettingsDeveloperFeatureFlagsJa._(_root);
  @override
  late final _TranslationsSettingsDeveloperStorageInspectorSectionJa
      storageInspectorSection =
      _TranslationsSettingsDeveloperStorageInspectorSectionJa._(_root);
  @override
  late final _TranslationsSettingsDeveloperDeviceInfoSectionJa
      deviceInfoSection =
      _TranslationsSettingsDeveloperDeviceInfoSectionJa._(_root);
  @override
  late final _TranslationsSettingsDeveloperLocalizationInspectorSectionJa
      localizationInspectorSection =
      _TranslationsSettingsDeveloperLocalizationInspectorSectionJa._(_root);
}

// Path: settings.about
class _TranslationsSettingsAboutJa extends TranslationsSettingsAboutEn {
  _TranslationsSettingsAboutJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'このアプリについて';
  @override
  String get version => 'バージョン';
  @override
  String get buildNumber => 'ビルド番号';
  @override
  String get author => '作成者';
  @override
  String get license => 'ライセンス';
  @override
  String get sourceCode => 'ソースコード';
  @override
  String get reportBug => 'バグを報告';
  @override
  String get requestFeature => '機能をリクエスト';
  @override
  String get checkForUpdates => 'アップデートを確認';
  @override
  String get upToDate => '最新の状態です！';
  @override
  String updateAvailable({required Object version}) =>
      'アップデートがあります: ${version}';
  @override
  String get updateAvailableBadge => 'アップデートがあります！';
  @override
  String developerSteps({required Object count}) =>
      '開発者になるまであと ${count} ステップです。';
  @override
  String get developerActivated => '開発者モードが有効になりました！';
  @override
  String get neverChecked => '未確認';
  @override
  String get applicationInfo => 'アプリケーション情報';
  @override
  String get platform => 'プラットフォーム';
  @override
  String get updateInformation => 'アップデート情報';
  @override
  String get currentVersion => '現在のバージョン';
  @override
  String get latestVersion => '最新のバージョン';
  @override
  String get lastChecked => '最終確認日';
  @override
  String get checkingForUpdates => '確認中...';
  @override
  String get whatsNew => '新機能';
  @override
  String get systemInformation => 'システム情報';
  @override
  String get dartVersion => 'Dart バージョン';
  @override
  String get diskSpace => '空きディスク容量';
  @override
  String get memoryUsage => 'メモリ使用量';
  @override
  String get privacyTitle => 'プライバシーとテレメトリ';
  @override
  String get usageStats => '匿名の使用統計';
  @override
  String get requiresFirebase => 'Firebase の設定が必要です';
  @override
  String get featureUnavailable => '機能は現在利用できません (Firebase が必要です)';
  @override
  String get settingsManagement => '設定の管理';
  @override
  String get settingsManagementDescription =>
      '設定をファイルにエクスポートして、バックアップしたり他のマシンと共有したりできます。';
  @override
  String get resetAll => 'すべてリセット';
  @override
  String get links => 'リンク';
  @override
  String get githubRepo => 'GitHub リポジトリ';
  @override
  String get privacyPolicy => 'プライバシーポリシー';
  @override
  String get crashReporting => 'クラッシュレポート';
}

// Path: settings.onboarding
class _TranslationsSettingsOnboardingJa
    extends TranslationsSettingsOnboardingEn {
  _TranslationsSettingsOnboardingJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'チュートリアルをスキップ';
  @override
  String get gettingStarted => 'はじめに';
  @override
  String stepProgress({required Object total, required Object current}) =>
      '${total} 中 ${current}';
  @override
  String get loadSampleData => 'サンプルデータを読み込む';
  @override
  late final _TranslationsSettingsOnboardingStepsJa steps =
      _TranslationsSettingsOnboardingStepsJa._(_root);
}

// Path: settings.settingsView
class _TranslationsSettingsSettingsViewJa
    extends TranslationsSettingsSettingsViewEn {
  _TranslationsSettingsSettingsViewJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String resetCategoryTitle({required Object category}) =>
      '${category} をリセットしますか？';
  @override
  String get resetCategoryContent => 'このカテゴリのすべての設定をデフォルト値にリセットします。';
  @override
  String get resetAllTitle => 'すべての設定をリセットしますか？';
  @override
  String get resetAllContent => 'すべての設定を工場出荷時のデフォルトに永久にリセットします。この操作は取り消せません。';
  @override
  String get resetAll => 'すべてリセット';
  @override
  String resetSuccess({required Object category}) => '${category} をリセットしました';
  @override
  String get errorLoading => '設定の読み込み中にエラーが発生しました';
  @override
  String get settingsSaved => '設定を保存しました';
  @override
  String updateAvailable({required Object version}) =>
      'アップデートがあります: v${version}';
  @override
  String get latestVersion => '最新のバージョンを使用しています';
  @override
  String whatsNew({required Object version}) => 'v${version} の新機能';
  @override
  String get downloadUpdate => 'アップデートをダウンロード';
  @override
  String get exportSettings => '設定をエクスポート';
  @override
  String get settingsExported => '設定をエクスポートしました';
  @override
  String exportFail({required Object error}) => '設定のエクスポートに失敗しました: ${error}';
  @override
  String get importSettings => '設定をインポート';
  @override
  String get importTitle => '設定をインポートしますか？';
  @override
  String get importContent => '現在のすべての設定がインポートされた内容に置き換わります。この操作は取り消せません。';
  @override
  String get importSuccess => '設定のインポートに成功しました！';
  @override
  String importFail({required Object error}) => '設定のインポートに失敗しました: ${error}';
  @override
  String get invalidFormat => '無効な設定ファイル形式です';
  @override
  late final _TranslationsSettingsSettingsViewCategoriesJa categories =
      _TranslationsSettingsSettingsViewCategoriesJa._(_root);
  @override
  late final _TranslationsSettingsSettingsViewCategoryLabelsJa categoryLabels =
      _TranslationsSettingsSettingsViewCategoryLabelsJa._(_root);
}

// Path: advancedDiff.aiSuggestion
class _TranslationsAdvancedDiffAiSuggestionJa
    extends TranslationsAdvancedDiffAiSuggestionEn {
  _TranslationsAdvancedDiffAiSuggestionJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get aiTranslation => 'AI 翻訳';
  @override
  String get aiRephrase => 'AI 言い換え';
  @override
  String key({required Object key}) => 'キー: ${key}';
  @override
  String get original => 'オリジナル:';
  @override
  String get suggestion => '提案:';
  @override
  String get confidence => 'AI 信頼度';
  @override
  String get cancelEdit => '編集をキャンセル';
  @override
  String get editSuggestion => '提案を編集';
  @override
  String get alternatives => '代替案:';
  @override
  String get accept => '適用';
  @override
  String get reject => '拒否';
  @override
  String get stop => '停止';
}

// Path: advancedDiff.detailEdit
class _TranslationsAdvancedDiffDetailEditJa
    extends TranslationsAdvancedDiffDetailEditEn {
  _TranslationsAdvancedDiffDetailEditJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object key}) => '編集: ${key}';
  @override
  String get sourceLabel => 'ソース (オリジナル)';
  @override
  String get targetLabel => 'ターゲット (翻訳)';
  @override
  String get translateWithCloud => 'クラウドで翻訳';
  @override
  String get translateWithAi => 'AI で翻訳';
  @override
  String get translating => '翻訳中...';
  @override
  String get applyAndTm => '適用';
  @override
  String get entryApplied => 'エントリを適用し、翻訳メモリに追加しました';
  @override
  String get translationAdded => '翻訳案が追加されました。';
  @override
  String get aiSuggestionAdded => 'AI 案が追加されました。';
}

// Path: advancedDiff.table
class _TranslationsAdvancedDiffTableJa extends TranslationsAdvancedDiffTableEn {
  _TranslationsAdvancedDiffTableJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get addedToTM => '翻訳メモリに追加しました';
  @override
  String get markedReviewed => '確認済みとしてマークしました ✓';
  @override
  String get unmarkedReview => '確認解除';
  @override
  String get reverted => 'ソースの値に戻しました';
  @override
  String get entryDeleted => 'エントリを削除しました';
  @override
  String get noSourceText => '翻訳するソーステキストがありません。';
  @override
  String aiTranslationFailed({required Object key}) =>
      '"${key}" の AI 翻訳に失敗しました';
  @override
  String get noTargetText => '言い換えるターゲットテキストがありません。';
  @override
  String aiRephraseFailed({required Object key}) => '"${key}" の AI 言い換えに失敗しました';
  @override
  String get checkRowsFirst => 'まずチェックボックスを使って行を選択してください';
  @override
  String markedRowsReviewed({required Object count}) =>
      '${count} 行を確認済みとしてマークしました';
  @override
  String revertedRows({required Object count}) => '${count} 行を元に戻しました';
  @override
  String entriesCount({required Object count}) => '${count} 件のエントリ';
  @override
  String get markSelectedReviewed => '選択した項目を確認済みにする';
  @override
  String get revertSelected => '選択した項目を元に戻す';
  @override
  String get noDifferences => '差異は見つかりませんでした';
  @override
  String get adjustFilters => 'フィルタを調整してみてください';
  @override
  String get cloudTranslationApplied => 'クラウド翻訳を適用しました。';
  @override
  String get aiTranslationApplied => 'AI 翻訳を適用しました。';
  @override
  String get suggestionApplied => '提案を適用しました。';
  @override
  String get aiSuggestionApplied => 'AI 提案を適用しました。';
  @override
  String get rephraseApplied => '言い換えを適用しました。';
  @override
  String get aiRephraseApplied => 'AI 言い換えを適用しました。';
  @override
  String get rephrase => '言い換え';
  @override
  String get aiRephrase => 'AI 言い換え';
  @override
  String get targetClickToEdit => 'ターゲット (クリックして編集)';
  @override
  String get targetClickForDialog => 'ターゲット (クリックしてダイアログを表示)';
  @override
  String get emptyClickToEdit => '(空 - クリックして編集)';
  @override
  String get unmarkReviewed => '確認マークを解除';
  @override
  String get markReviewed => '確認済みとしてマーク';
  @override
  String get revertToSource => 'ソースに戻す';
  @override
  String get translateWithCloud => 'クラウドで翻訳';
  @override
  String get translateWithAi => 'AI で翻訳';
  @override
  String get rephraseWithAi => 'AI で言い換え';
  @override
  String get moreActions => 'その他のアクション';
  @override
  String get editDetails => '詳細を編集';
  @override
  String get suggestTranslation => '翻訳を提案';
  @override
  String get addToTm => '翻訳メモリに追加';
  @override
  String get deleteEntry => 'エントリを削除';
}

// Path: advancedDiff.diffRow
class _TranslationsAdvancedDiffDiffRowJa
    extends TranslationsAdvancedDiffDiffRowEn {
  _TranslationsAdvancedDiffDiffRowJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get copySource => 'ソーステキストをコピー';
  @override
  String get actions => 'アクション';
}

// Path: advancedDiff.status
class _TranslationsAdvancedDiffStatusJa
    extends TranslationsAdvancedDiffStatusEn {
  _TranslationsAdvancedDiffStatusJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get added => '追加';
  @override
  String get missing => '欠落';
  @override
  String changed({required Object percent}) => '変更 ${percent}%';
  @override
  String get same => '同一';
}

// Path: advancedDiff.sidebar
class _TranslationsAdvancedDiffSidebarJa
    extends TranslationsAdvancedDiffSidebarEn {
  _TranslationsAdvancedDiffSidebarJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get widgets => 'ウィジェット';
  @override
  String get searchPlaceholder => 'キーと値を検索... (Ctrl+F)';
  @override
  String get fuzzySearchTooltip => 'あいまい検索 (タイポ許容)';
  @override
  String get regexSearchTooltip => '正規表現検索';
  @override
  String get cloudTranslation => 'クラウド翻訳';
  @override
  String get aiTranslation => 'AI 翻訳';
  @override
  String get status => 'ステータス';
  @override
  String get tm => '翻訳メモリ';
  @override
  String get filters => 'フィルタ';
  @override
  String get actions => 'アクション';
  @override
  String get similarity => '類似度';
  @override
  late final _TranslationsAdvancedDiffSidebarActionsSectionJa actionsSection =
      _TranslationsAdvancedDiffSidebarActionsSectionJa._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarAiSectionJa aiSection =
      _TranslationsAdvancedDiffSidebarAiSectionJa._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarTmSectionJa tmSection =
      _TranslationsAdvancedDiffSidebarTmSectionJa._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarFiltersSectionJa filtersSection =
      _TranslationsAdvancedDiffSidebarFiltersSectionJa._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarSimilaritySectionJa
      similaritySection =
      _TranslationsAdvancedDiffSidebarSimilaritySectionJa._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarStatusSectionJa statusSection =
      _TranslationsAdvancedDiffSidebarStatusSectionJa._(_root);
}

// Path: issueDetails.duplicateValue
class _TranslationsIssueDetailsDuplicateValueJa
    extends TranslationsIssueDetailsDuplicateValueEn {
  _TranslationsIssueDetailsDuplicateValueJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get label => '重複した翻訳';
  @override
  String get warning => '異なるソーステキストに同じ翻訳が使用されています。コンテキストを確認してください。';
  @override
  String affectedKeys({required Object count}) => '対象のキー (${count})';
  @override
  String get identicalSources => '同一のソース';
  @override
  String moreKeys({required Object count}) => '他 ${count} 個のキー';
}

// Path: issueDetails.lengthOutlier
class _TranslationsIssueDetailsLengthOutlierJa
    extends TranslationsIssueDetailsLengthOutlierEn {
  _TranslationsIssueDetailsLengthOutlierJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get source => 'ソース';
  @override
  String get translation => '翻訳';
  @override
  String chars({required Object count}) => '${count} 文字';
}

// Path: issueDetails.standard
class _TranslationsIssueDetailsStandardJa
    extends TranslationsIssueDetailsStandardEn {
  _TranslationsIssueDetailsStandardJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'キー';
  @override
  String get sourceText => 'ソーステキスト';
  @override
  String get translation => '翻訳';
  @override
  String get errorDetails => 'エラー詳細';
  @override
  String get note => 'メモ';
}

// Path: issueDetails.types
class _TranslationsIssueDetailsTypesJa extends TranslationsIssueDetailsTypesEn {
  _TranslationsIssueDetailsTypesJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get duplicateValue => '重複する値';
  @override
  String get lengthOutlier => '長さの不一致';
  @override
  String get placeholderMismatch => '破損したプレースホルダー';
}

// Path: issueDetails.notes
class _TranslationsIssueDetailsNotesJa extends TranslationsIssueDetailsNotesEn {
  _TranslationsIssueDetailsNotesJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get placeholderMismatch => '{name} のようなマーカーはソースと一致させる必要があります。';
  @override
  String get lengthOutlier => '長さが大きく変わると、画面上でのテキストの収まりに影響する可能性があります。';
  @override
  String get duplicateValue => '異なるキーに同じ翻訳が使用されています。';
}

// Path: issueDetails.fallbacks
class _TranslationsIssueDetailsFallbacksJa
    extends TranslationsIssueDetailsFallbacksEn {
  _TranslationsIssueDetailsFallbacksJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get multipleSources => '複数のソーステキスト';
  @override
  String get sourceNotAvailable => 'ソーステキスト利用不可';
  @override
  String get sharedTranslationNotAvailable => '共有翻訳利用不可';
  @override
  String get translationNotAvailable => '翻訳利用不可';
}

// Path: compare.tabs
class _TranslationsCompareTabsJa extends TranslationsCompareTabsEn {
  _TranslationsCompareTabsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get files => 'ファイル';
  @override
  String get directories => 'ディレクトリ';
  @override
  String get git => 'Git';
}

// Path: compare.fileTypes
class _TranslationsCompareFileTypesJa extends TranslationsCompareFileTypesEn {
  _TranslationsCompareFileTypesJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get json => 'JSON ローカリゼーションファイル (i18next, Flutter など)';
  @override
  String get yaml => 'YAML ローカリゼーションファイル (Rails, Flutter)';
  @override
  String get xml => 'XML ローカリゼーションファイル (Android, .NET)';
  @override
  String get properties => 'Properties ファイル (Java)';
  @override
  String get resx => 'RESX ファイル (.NET)';
  @override
  String get xliff => 'XLIFF ファイル';
}

// Path: history.timeAgo
class _TranslationsHistoryTimeAgoJa extends TranslationsHistoryTimeAgoEn {
  _TranslationsHistoryTimeAgoJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get justNow => 'たった今';
  @override
  String secondsAgo({required Object count}) => '${count} 秒前';
  @override
  String get oneMinuteAgo => '1 分前';
  @override
  String minutesAgo({required Object count}) => '${count} 分前';
  @override
  String get oneHourAgo => '1 時間前';
  @override
  String hoursAgo({required Object count}) => '${count} 時間前';
  @override
  String get yesterday => '昨日';
  @override
  String daysAgo({required Object count}) => '${count} 日前';
  @override
  String get oneWeekAgo => '1 週間前';
  @override
  String weeksAgo({required Object count}) => '${count} 週間前';
  @override
  String get oneMonthAgo => '1 ヶ月前';
  @override
  String monthsAgo({required Object count}) => '${count} ヶ月前';
  @override
  String get oneYearAgo => '1 年前';
  @override
  String yearsAgo({required Object count}) => '${count} 年前';
  @override
  String get inTheFuture => '未来';
}

// Path: projects.stats
class _TranslationsProjectsStatsJa extends TranslationsProjectsStatsEn {
  _TranslationsProjectsStatsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get empty => '空のプロジェクト';
  @override
  String files({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ja'))(
        n,
        one: '1 つの翻訳ファイル',
        other: '${count} 個の翻訳ファイル',
      );
  @override
  String languages({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ja'))(
        n,
        one: '1 言語',
        other: '${count} 言語',
      );
}

// Path: projects.selection
class _TranslationsProjectsSelectionJa extends TranslationsProjectsSelectionEn {
  _TranslationsProjectsSelectionJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get selectFolder => 'プロジェクトフォルダを選択';
  @override
  String get selectArchive => 'プロジェクトアーカイブを選択';
  @override
  String get openProject => 'プロジェクトを開く';
  @override
  String get browseFolder => 'フォルダをブラウズ...';
  @override
  String get createNew => '新規作成';
  @override
  String get importFromZip => 'Zip からインポート...';
}

// Path: projects.createDialog
class _TranslationsProjectsCreateDialogJa
    extends TranslationsProjectsCreateDialogEn {
  _TranslationsProjectsCreateDialogJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'プロジェクトを作成';
  @override
  String get description =>
      'プロジェクトを使用すると、特定のフォルダのカスタム設定を保存できます。プロジェクト設定を保存するために ".localizer" フォルダが作成されます。';
  @override
  String get folderLabel => 'プロジェクトフォルダ';
  @override
  String get folderHint => 'クリックしてフォルダを選択...';
  @override
  String get nameLabel => 'プロジェクト名';
  @override
  String get nameHint => '例: 私のアプリの翻訳';
  @override
  String get selectFolderWarning => 'プロジェクトフォルダを選択してください。';
  @override
  String get enterNameError => 'プロジェクト名を入力してください';
  @override
  String get nameLengthError => '名前は 2 文字以上である必要があります';
  @override
  String success({required Object name}) => 'プロジェクト "${name}" を正常に作成しました！';
  @override
  String get failure => 'プロジェクトの作成に失敗しました。';
  @override
  String get creating => '作成中...';
  @override
  String get createAction => 'プロジェクトを作成';
}

// Path: projects.indicator
class _TranslationsProjectsIndicatorJa extends TranslationsProjectsIndicatorEn {
  _TranslationsProjectsIndicatorJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get tooltipNoProject => '特定のフォルダのカスタム設定を保存するためにプロジェクトを作成します';
  @override
  String tooltipProject({required Object name}) =>
      'プロジェクト: ${name}\nクリックしてオプションを表示';
  @override
  String get location => '場所';
  @override
  String get created => '作成日';
  @override
  String get switchProject => 'プロジェクトを切り替え';
  @override
  String get done => '完了';
}

// Path: projects.glossary
class _TranslationsProjectsGlossaryJa extends TranslationsProjectsGlossaryEn {
  _TranslationsProjectsGlossaryJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'プロジェクト用語集';
  @override
  String get description => '一貫して扱う必要のある用語や、翻訳してはいけない用語を定義します。';
  @override
  String get noTerms => '用語集に用語がありません。';
  @override
  String get noTermsDesc => '翻訳を通じて一貫性を保つ必要のある用語や、\n翻訳してはいけないブランド名などを追加してください。';
  @override
  String get doNotTranslate => '翻訳しない';
  @override
  String get noSpecificTranslation => '特定の翻訳なし';
  @override
  String get addTerm => '用語を追加';
  @override
  String get editTerm => '用語を編集';
  @override
  String get term => '用語';
  @override
  String get termHint => '例: ブランド名、専門用語';
  @override
  String get definition => '定義 (任意)';
  @override
  String get definitionHint => '翻訳者へのコンテキスト情報';
  @override
  String get doNotTranslateLabel => '翻訳しない';
  @override
  String get doNotTranslateDesc => 'ターゲットでも用語をそのまま保持します';
  @override
  String get preferredTranslation => '優先される翻訳';
  @override
  String get caseSensitive => '大文字小文字を区別';
}

// Path: projects.conflicts
class _TranslationsProjectsConflictsJa extends TranslationsProjectsConflictsEn {
  _TranslationsProjectsConflictsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String missingApiKeyTitle({required Object service}) =>
      '${service} の API キーが不足しています';
  @override
  String missingApiKeyMessage({required Object service}) =>
      'このプロジェクトは ${service} を使用しますが、API キーが設定されていません。設定 > AI サービスで API キーを追加してください。追加しない場合は、アプリのグローバルデフォルトが使用されます。';
  @override
  String get dismiss => '閉じる';
}

// Path: projects.tm
class _TranslationsProjectsTmJa extends TranslationsProjectsTmEn {
  _TranslationsProjectsTmJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '翻訳メモリ';
  @override
  String get description => 'このプロジェクトの翻訳メモリソースを管理します。';
  @override
  String get globalTm => 'グローバル翻訳メモリ';
  @override
  String get globalTmDescription => 'アプリ設定の共有翻訳メモリを使用します';
  @override
  String get linkedFiles => 'リンクされたファイル (プロジェクト固有)';
  @override
  String get noLinkedFiles => 'リンクされたプロジェクト固有のファイルはありません。';
  @override
  String get addTmFile => 'TM ファイルを追加';
  @override
  String get useGlobalTm => 'グローバル TM を使用';
  @override
  String get selectTm => '翻訳メモリを選択';
  @override
  String get globalTmEnabled => 'グローバル翻訳メモリが有効です';
}

// Path: git.conflicts
class _TranslationsGitConflictsJa extends TranslationsGitConflictsEn {
  _TranslationsGitConflictsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'マージコンフリクトを検出';
  @override
  String get description => '続行する前に、これらのコンフリクトを解決する必要があります。';
  @override
  String get abortMergeTitle => 'マージを中止しますか？';
  @override
  String get abortMergeContent =>
      'すべてのマージによる変更を元に戻し、マージ前の状態に戻ります。この操作は取り消せません。';
  @override
  String get abortMergeAction => 'マージを中止';
  @override
  String stagingFile({required Object file}) => 'コミットのために ${file} をステージング中...';
  @override
  String conflictedFilesCount({required Object count}) =>
      'コンフリクトのあるファイル (${count})';
  @override
  String get selectFileToResolve => '解決するファイルを選択';
  @override
  String resolvingFile({required Object file}) => '解決中: ${file}';
  @override
  String get keepAllOurs => '自分の変更をすべて保持';
  @override
  String get acceptAllTheirs => '相手の変更をすべて受け入れる';
  @override
  String get allResolved => 'このファイルのすべてのコンフリクトが解決されました！';
  @override
  String get markResolved => '解決済みとしてマーク';
  @override
  String get stageForCommit => 'これによりファイルがコミット用にステージングされます。';
  @override
  String conflictIndex({required Object index}) => 'コンフリクト #${index}';
  @override
  String get ours => '自分の変更 (現在)';
  @override
  String get theirs => '相手の変更 (取り込み)';
  @override
  String get keepOurs => '自分の変更を保持';
  @override
  String get acceptTheirs => '相手の変更を受け入れる';
  @override
  String get empty => '(空)';
}

// Path: wizards.firstRun
class _TranslationsWizardsFirstRunJa extends TranslationsWizardsFirstRunEn {
  _TranslationsWizardsFirstRunJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get welcome => 'Localizer へようこそ';
  @override
  String get description => 'ローカリゼーションファイルを数秒で比較できます。';
  @override
  String get sourceFile => 'ソースファイル';
  @override
  String get targetFile => 'ターゲットファイル';
  @override
  String get compareNow => '今すぐ比較';
  @override
  String get trySample => 'サンプルデータで試す';
  @override
  String get skip => '設定をスキップ';
  @override
  String get browse => 'クリックして参照';
  @override
  String error({required Object error}) => 'サンプルデータの読み込みに失敗しました: ${error}';
}

// Path: dialogs.addIgnorePattern
class _TranslationsDialogsAddIgnorePatternJa
    extends TranslationsDialogsAddIgnorePatternEn {
  _TranslationsDialogsAddIgnorePatternJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '無視パターンの追加';
  @override
  String get patternLabel => 'パターン (正規表現)';
  @override
  String get hint => '例: ^temp_.*';
  @override
  String get invalid => '無効な正規表現パターンです';
  @override
  String get testStringLabel => 'テスト文字列';
  @override
  String get testHint => 'パターンと照合するキーを入力';
  @override
  String get match => '✓ パターンがテスト文字列に一致します';
  @override
  String get noMatch => '✗ パターンが一致しません';
  @override
  String get add => '追加';
  @override
  String get cancel => 'キャンセル';
}

// Path: dialogs.diffViewer
class _TranslationsDialogsDiffViewerJa extends TranslationsDialogsDiffViewerEn {
  _TranslationsDialogsDiffViewerJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '差異ビューア';
  @override
  String get originalFile => 'オリジナル/参照ファイル';
  @override
  String get translationFile => '翻訳/比較ファイル';
  @override
  String get base => 'ベース';
  @override
  String get target => 'ターゲット';
  @override
  String get added => '追加済み';
  @override
  String get removed => '削除済み';
  @override
  String get modified => '修正済み';
  @override
  String get noMatches => '現在のフィルタに一致するエントリはありません';
  @override
  String get clickToggle => '上のバッジをクリックしてフィルタを切り替えます';
  @override
  String get clickToHide => '(クリックで非表示)';
  @override
  String get clickToShow => '(クリックで表示)';
}

// Path: grid.columns
class _TranslationsGridColumnsJa extends TranslationsGridColumnsEn {
  _TranslationsGridColumnsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'キー';
  @override
  String get source => 'ソース';
  @override
  String get status => 'ステータス';
  @override
  String get actions => 'アクション';
}

// Path: tutorial.steps
class _TranslationsTutorialStepsJa extends TranslationsTutorialStepsEn {
  _TranslationsTutorialStepsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTutorialStepsImportSourceJa importSource =
      _TranslationsTutorialStepsImportSourceJa._(_root);
  @override
  late final _TranslationsTutorialStepsImportTargetJa importTarget =
      _TranslationsTutorialStepsImportTargetJa._(_root);
  @override
  late final _TranslationsTutorialStepsCompareJa compare =
      _TranslationsTutorialStepsCompareJa._(_root);
  @override
  late final _TranslationsTutorialStepsFilterJa filter =
      _TranslationsTutorialStepsFilterJa._(_root);
  @override
  late final _TranslationsTutorialStepsSearchJa search =
      _TranslationsTutorialStepsSearchJa._(_root);
  @override
  late final _TranslationsTutorialStepsAdvancedJa advanced =
      _TranslationsTutorialStepsAdvancedJa._(_root);
  @override
  late final _TranslationsTutorialStepsExportJa export =
      _TranslationsTutorialStepsExportJa._(_root);
}

// Path: friendlyErrors.fileNotFound
class _TranslationsFriendlyErrorsFileNotFoundJa
    extends TranslationsFriendlyErrorsFileNotFoundEn {
  _TranslationsFriendlyErrorsFileNotFoundJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'ファイルまたはフォルダが見つかりませんでした。';
  @override
  String get suggestion => 'ファイルが移動または削除されていないか確認してください。';
}

// Path: friendlyErrors.accessDenied
class _TranslationsFriendlyErrorsAccessDeniedJa
    extends TranslationsFriendlyErrorsAccessDeniedEn {
  _TranslationsFriendlyErrorsAccessDeniedJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'ファイルへのアクセスが拒否されました。';
  @override
  String get suggestion => 'アプリを管理者として実行するか、ファイルのアクセス許可を確認してください。';
}

// Path: friendlyErrors.isDirectory
class _TranslationsFriendlyErrorsIsDirectoryJa
    extends TranslationsFriendlyErrorsIsDirectoryEn {
  _TranslationsFriendlyErrorsIsDirectoryJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'ファイルの代わりにフォルダが選択されました。';
  @override
  String get suggestion => '有効なファイルを選択してください。';
}

// Path: friendlyErrors.fileAccess
class _TranslationsFriendlyErrorsFileAccessJa
    extends TranslationsFriendlyErrorsFileAccessEn {
  _TranslationsFriendlyErrorsFileAccessJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'ファイルへのアクセス中に問題が発生しました。';
  @override
  String get suggestion => 'それを使用している可能性のある他のプログラムを閉じてみてください。';
}

// Path: friendlyErrors.unsupportedFormat
class _TranslationsFriendlyErrorsUnsupportedFormatJa
    extends TranslationsFriendlyErrorsUnsupportedFormatEn {
  _TranslationsFriendlyErrorsUnsupportedFormatJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'このファイル形式または操作はサポートされていません。';
  @override
  String get suggestion => 'ファイル拡張子を確認するか、別の形式を試してください。';
}

// Path: friendlyErrors.networkError
class _TranslationsFriendlyErrorsNetworkErrorJa
    extends TranslationsFriendlyErrorsNetworkErrorEn {
  _TranslationsFriendlyErrorsNetworkErrorJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'サーバーに接続できませんでした。';
  @override
  String get suggestion => 'インターネット接続を確認して、もう一度お試しください。';
}

// Path: friendlyErrors.notGitRepo
class _TranslationsFriendlyErrorsNotGitRepoJa
    extends TranslationsFriendlyErrorsNotGitRepoEn {
  _TranslationsFriendlyErrorsNotGitRepoJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'このフォルダは Git プロジェクトではありません。';
  @override
  String get suggestion => '.git ディレクトリを含むフォルダに移動してください。';
}

// Path: friendlyErrors.mergeConflict
class _TranslationsFriendlyErrorsMergeConflictJa
    extends TranslationsFriendlyErrorsMergeConflictEn {
  _TranslationsFriendlyErrorsMergeConflictJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'リポジトリにマージコンフリクトがあります。';
  @override
  String get suggestion => '続行する前にコンフリクトを解決してください。';
}

// Path: friendlyErrors.gitAuthFailed
class _TranslationsFriendlyErrorsGitAuthFailedJa
    extends TranslationsFriendlyErrorsGitAuthFailedEn {
  _TranslationsFriendlyErrorsGitAuthFailedJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Git の認証に失敗しました。';
  @override
  String get suggestion => '設定 > バージョン管理 で資格情報を確認してください。';
}

// Path: friendlyErrors.gitOperationFailed
class _TranslationsFriendlyErrorsGitOperationFailedJa
    extends TranslationsFriendlyErrorsGitOperationFailedEn {
  _TranslationsFriendlyErrorsGitOperationFailedJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Git 操作に失敗しました。';
  @override
  String get suggestion => '詳細については Git ビューを確認してください。';
}

// Path: friendlyErrors.invalidJson
class _TranslationsFriendlyErrorsInvalidJsonJa
    extends TranslationsFriendlyErrorsInvalidJsonEn {
  _TranslationsFriendlyErrorsInvalidJsonJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'ファイル形式が無効であるか、破損しています。';
  @override
  String get suggestion => 'ファイルに有効な JSON コンテンツが含まれていることを確認してください。';
}

// Path: friendlyErrors.rateLimitReached
class _TranslationsFriendlyErrorsRateLimitReachedJa
    extends TranslationsFriendlyErrorsRateLimitReachedEn {
  _TranslationsFriendlyErrorsRateLimitReachedJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => '翻訳制限に達しました。';
  @override
  String get suggestion => '数分待つか、API プランの制限を確認してください。';
}

// Path: friendlyErrors.invalidApiKey
class _TranslationsFriendlyErrorsInvalidApiKeyJa
    extends TranslationsFriendlyErrorsInvalidApiKeyEn {
  _TranslationsFriendlyErrorsInvalidApiKeyJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => '無効な API キーです。';
  @override
  String get suggestion => '設定 > AI 翻訳 に移動して、API キーを更新してください。';
}

// Path: friendlyErrors.translationServiceError
class _TranslationsFriendlyErrorsTranslationServiceErrorJa
    extends TranslationsFriendlyErrorsTranslationServiceErrorEn {
  _TranslationsFriendlyErrorsTranslationServiceErrorJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => '翻訳サービスエラーが発生しました。';
  @override
  String get suggestion => 'API キーとインターネット接続を確認してください。';
}

// Path: friendlyErrors.outOfMemory
class _TranslationsFriendlyErrorsOutOfMemoryJa
    extends TranslationsFriendlyErrorsOutOfMemoryEn {
  _TranslationsFriendlyErrorsOutOfMemoryJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'この操作を完了するためのメモリが不足しています。';
  @override
  String get suggestion => '他のアプリケーションを閉じるか、より小さいファイルを使用してみてください。';
}

// Path: friendlyErrors.genericError
class _TranslationsFriendlyErrorsGenericErrorJa
    extends TranslationsFriendlyErrorsGenericErrorEn {
  _TranslationsFriendlyErrorsGenericErrorJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get message => '問題が発生しました。';
  @override
  String get suggestion => 'もう一度お試しください。問題が解決しない場合は、アプリを再起動してください。';
}

// Path: settings.appearance.presets
class _TranslationsSettingsAppearancePresetsJa
    extends TranslationsSettingsAppearancePresetsEn {
  _TranslationsSettingsAppearancePresetsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get presetDefault => 'デフォルト';
  @override
  String get presetColorblind => '色覚多様性対応';
  @override
  String get presetHighContrast => 'ハイコントラスト';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.appearance.preview
class _TranslationsSettingsAppearancePreviewJa
    extends TranslationsSettingsAppearancePreviewEn {
  _TranslationsSettingsAppearancePreviewJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get step3Title => 'onboarding.step3.title';
  @override
  String get connectAccount => '"アカウントを接続"';
  @override
  String get loginHint => 'deprecated.login_hint_v1';
  @override
  String get enterCredentials => '"資格情報を入力"';
  @override
  String get ctaButton => 'checkout.cta_button';
  @override
  String get buyNow => '"今すぐ購入"';
  @override
  String get completePurchase => '"購入を完了"';
  @override
  String get appNameKey => 'common.app_name';
  @override
  String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class _TranslationsSettingsComparisonPatternPresetsJa
    extends TranslationsSettingsComparisonPatternPresetsEn {
  _TranslationsSettingsComparisonPatternPresetsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get comments => 'コメント';
  @override
  String get tempKeys => '一時的なキー';
  @override
  String get placeholders => 'プレースホルダー';
  @override
  String get devOnly => '開発専用';
}

// Path: settings.comparison.previewMatch
class _TranslationsSettingsComparisonPreviewMatchJa
    extends TranslationsSettingsComparisonPreviewMatchEn {
  _TranslationsSettingsComparisonPreviewMatchJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '照合プレビュー';
  @override
  String get description => '現在の設定が照合ロジックにどのように影響するかテストします。';
  @override
  String get stringA => '文字列 A';
  @override
  String get stringB => '文字列 B';
  @override
  String get enterText => 'テキストを入力...';
  @override
  String get similarity => '類似度';
  @override
  String get identical => '同一';
  @override
  String get identicalDescription => '正規化後に文字列が完全に一致します。';
  @override
  String get ignored => '無視';
  @override
  String get ignoredDescription => '入力が無視パターンに一致します。';
  @override
  String get different => '不一致';
  @override
  String get differentDescription => 'いずれかの値が空です。';
  @override
  String get similarModified => '類似 / 変更';
  @override
  String similarModifiedDescription({required Object threshold}) =>
      '一致スコアがしきい値（${threshold}%）を超えています。';
  @override
  String get newDifferent => '新規 / 不一致';
  @override
  String newDifferentDescription({required Object threshold}) =>
      '一致スコアがしきい値（${threshold}%）を下回っています。';
}

// Path: settings.comparison.colorPresets
class _TranslationsSettingsComparisonColorPresetsJa
    extends TranslationsSettingsComparisonColorPresetsEn {
  _TranslationsSettingsComparisonColorPresetsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get kDefault => 'デフォルト';
  @override
  String get colorblindFriendly => '色覚多様性対応';
  @override
  String get highContrast => 'ハイコントラスト';
  @override
  String get nord => 'Nord';
  @override
  String get solarized => 'Solarized';
  @override
  String get monokai => 'Monokai';
  @override
  String get presetDefault => 'デフォルト';
  @override
  String get presetColorblind => '色覚多様性対応';
  @override
  String get presetHighContrast => 'ハイコントラスト';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.integrations.materials
class _TranslationsSettingsIntegrationsMaterialsJa
    extends TranslationsSettingsIntegrationsMaterialsEn {
  _TranslationsSettingsIntegrationsMaterialsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get sidebar => 'サイドバー';
  @override
  String get menu => 'メニュー';
  @override
  String get popover => 'ポップオーバー';
  @override
  String get titlebar => 'タイトルバー';
  @override
  String get underPageBackground => 'ページ背景';
  @override
  String get contentBackground => 'コンテンツ';
}

// Path: settings.integrations.fileTypes
class _TranslationsSettingsIntegrationsFileTypesJa
    extends TranslationsSettingsIntegrationsFileTypesEn {
  _TranslationsSettingsIntegrationsFileTypesJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get loc => 'Localizer プロジェクトファイル';
  @override
  String get lang => '言語ファイル';
  @override
  String get json => 'JSON ローカリゼーションファイル';
  @override
  String get xml => 'XML ローカリゼーションファイル';
}

// Path: settings.developer.themePlaygroundSection
class _TranslationsSettingsDeveloperThemePlaygroundSectionJa
    extends TranslationsSettingsDeveloperThemePlaygroundSectionEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get colors => '色';
  @override
  String get typography => 'タイポグラフィ';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteJa
      palette =
      _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteJa._(_root);
}

// Path: settings.developer.featureFlags
class _TranslationsSettingsDeveloperFeatureFlagsJa
    extends TranslationsSettingsDeveloperFeatureFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '実験的な機能';
  @override
  String get description =>
      'テストのために機能フラグをローカルで切り替えます。これらのオーバーライドはアプリの再起動後も保持されます。';
  @override
  String get subtitle => '実験的な機能を上書き';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsJa flags =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsJa._(_root);
  @override
  String get reset => 'すべてのフラグをリセット';
  @override
  String get overrides => 'ローカルオーバーライド';
  @override
  String get defaultVal => 'デフォルト';
  @override
  String get on => 'オン';
  @override
  String get off => 'オフ';
}

// Path: settings.developer.storageInspectorSection
class _TranslationsSettingsDeveloperStorageInspectorSectionJa
    extends TranslationsSettingsDeveloperStorageInspectorSectionEn {
  _TranslationsSettingsDeveloperStorageInspectorSectionJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => '更新';
  @override
  String get hiveData => 'Hive データ';
  @override
  String get secureStorage => 'セキュアストレージ';
}

// Path: settings.developer.deviceInfoSection
class _TranslationsSettingsDeveloperDeviceInfoSectionJa
    extends TranslationsSettingsDeveloperDeviceInfoSectionEn {
  _TranslationsSettingsDeveloperDeviceInfoSectionJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => '更新';
  @override
  String get copy => 'クリップボードにコピー';
  @override
  String get computerName => 'コンピュータ名';
  @override
  String get osVersion => 'OS バージョン';
}

// Path: settings.developer.localizationInspectorSection
class _TranslationsSettingsDeveloperLocalizationInspectorSectionJa
    extends TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
  _TranslationsSettingsDeveloperLocalizationInspectorSectionJa._(
      TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get showKeys => '値の代わりにキーを表示';
  @override
  String get keysVisible => 'キーを表示中';
  @override
  String get normalDisplay => '通常表示';
  @override
  String get note =>
      '注意: この機能を使用するには、アプリのローカリゼーションがこの設定を尊重するラッパーを使用している必要があります。';
}

// Path: settings.onboarding.steps
class _TranslationsSettingsOnboardingStepsJa
    extends TranslationsSettingsOnboardingStepsEn {
  _TranslationsSettingsOnboardingStepsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsOnboardingStepsImportFilesJa importFiles =
      _TranslationsSettingsOnboardingStepsImportFilesJa._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsRunComparisonJa runComparison =
      _TranslationsSettingsOnboardingStepsRunComparisonJa._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsReviewMissingJa reviewMissing =
      _TranslationsSettingsOnboardingStepsReviewMissingJa._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsUseFiltersJa useFilters =
      _TranslationsSettingsOnboardingStepsUseFiltersJa._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsSearchResultsJa searchResults =
      _TranslationsSettingsOnboardingStepsSearchResultsJa._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsAdvancedViewJa advancedView =
      _TranslationsSettingsOnboardingStepsAdvancedViewJa._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsEditCellJa editCell =
      _TranslationsSettingsOnboardingStepsEditCellJa._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsExportResultsJa exportResults =
      _TranslationsSettingsOnboardingStepsExportResultsJa._(_root);
}

// Path: settings.settingsView.categories
class _TranslationsSettingsSettingsViewCategoriesJa
    extends TranslationsSettingsSettingsViewCategoriesEn {
  _TranslationsSettingsSettingsViewCategoriesJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get general => '全般設定';
  @override
  String get comparisonEngine => '比較エンジン';
  @override
  String get appearance => '外観';
  @override
  String get fileHandling => 'ファイル処理';
  @override
  String get aiServices => 'AI サービス';
  @override
  String get systemIntegrations => 'システム連携';
  @override
  String get projectResources => 'プロジェクトリソース (用語集と翻訳メモリ)';
  @override
  String get developer => '開発者オプション';
  @override
  String get about => 'このアプリについて';
}

// Path: settings.settingsView.categoryLabels
class _TranslationsSettingsSettingsViewCategoryLabelsJa
    extends TranslationsSettingsSettingsViewCategoryLabelsEn {
  _TranslationsSettingsSettingsViewCategoryLabelsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get general => '全般';
  @override
  String get comparisonEngine => '比較';
  @override
  String get appearance => '外観';
  @override
  String get fileHandling => 'ファイル処理';
  @override
  String get aiServices => 'AI サービス';
  @override
  String get systemIntegrations => 'システム連携';
  @override
  String get projectResources => 'プロジェクトリソース';
  @override
  String get developer => '開発者オプション';
  @override
  String get about => '詳細';
}

// Path: advancedDiff.sidebar.actionsSection
class _TranslationsAdvancedDiffSidebarActionsSectionJa
    extends TranslationsAdvancedDiffSidebarActionsSectionEn {
  _TranslationsAdvancedDiffSidebarActionsSectionJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get exportMatches => '一致項目をエクスポート';
  @override
  String get preview => 'プレビュー';
  @override
  String get fillFromTmTitle => '翻訳メモリから入力しますか？';
  @override
  String get fillFromTmContent =>
      '翻訳メモリから一致するものを見つけて、空のターゲット値を埋めます。既存の値は上書きされません。';
  @override
  String get fill => '埋める';
  @override
  String get fillFromMemory => 'メモリから入力';
  @override
  String filledFromTm({required Object count}) =>
      '翻訳メモリから ${count} 件のアイテムを入力しました。';
}

// Path: advancedDiff.sidebar.aiSection
class _TranslationsAdvancedDiffSidebarAiSectionJa
    extends TranslationsAdvancedDiffSidebarAiSectionEn {
  _TranslationsAdvancedDiffSidebarAiSectionJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get infoCloud => 'クラウド翻訳を使用して、ソースから空のターゲット値を翻訳します。';
  @override
  String get infoAi => 'AI を使用して、ソースから空のターゲット値を翻訳します。';
  @override
  String get translationSettings => '翻訳設定';
  @override
  String get aiSettings => 'AI 設定';
  @override
  String get source => 'ソース';
  @override
  String get target => 'ターゲット';
  @override
  String translatingProgress({required Object percent}) => '翻訳中... ${percent}%';
  @override
  String get translating => '翻訳中...';
  @override
  String get translateAllMissing => '欠落しているものをすべて翻訳';
  @override
  String get translateAllTitle => '欠落しているものをすべて翻訳しますか？';
  @override
  String translateAllContent(
          {required Object service,
          required Object source,
          required Object target}) =>
      '${service} を使用して、${source} から ${target} への空のターゲット値を持つすべてのエントリを翻訳します。\n\n各提案を確認するか、すべて一度に適用できます。';
  @override
  String get translateAll => 'すべて翻訳';
  @override
  String get reviewEach => '個別に確認';
  @override
  String cloudTranslated({required Object count}) =>
      'クラウド翻訳で ${count} 件のエントリを翻訳しました。';
  @override
  String aiTranslated({required Object count}) =>
      'AI で ${count} 件のエントリを翻訳しました。';
  @override
  String get aiTranslateFailed => 'AI 一括翻訳に失敗しました';
  @override
  String get noMissingEntries => '翻訳が必要な欠落したエントリはありません。';
  @override
  String get skip => 'スキップ';
  @override
  String get stop => '停止';
  @override
  String cloudApplied({required Object count}) => '${count} 件の提案を適用しました。';
  @override
  String aiApplied({required Object count}) => '${count} 件の AI 提案を適用しました。';
}

// Path: advancedDiff.sidebar.tmSection
class _TranslationsAdvancedDiffSidebarTmSectionJa
    extends TranslationsAdvancedDiffSidebarTmSectionEn {
  _TranslationsAdvancedDiffSidebarTmSectionJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get enableTmFill => 'TM 自動入力を有効にする';
  @override
  String get autoApplyAboveMinimum => '最小値以上で自動適用';
  @override
  String get matchSettings => '一致設定';
  @override
  String get minMatch => '最小一致:';
  @override
  String get limit => '制限:';
  @override
  String get exact => '完全一致';
}

// Path: advancedDiff.sidebar.filtersSection
class _TranslationsAdvancedDiffSidebarFiltersSectionJa
    extends TranslationsAdvancedDiffSidebarFiltersSectionEn {
  _TranslationsAdvancedDiffSidebarFiltersSectionJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get viewFilters => 'ビューフィルタ';
  @override
  String get showAll => 'すべて表示';
  @override
  String get added => '追加済み';
  @override
  String get removed => '削除済み';
  @override
  String get modified => '修正済み';
  @override
  String get actionScope => 'アクションスコープ';
  @override
  String get applyToAdded => '追加分に適用';
  @override
  String get applyToModified => '修正分に適用';
  @override
  String get onlyFillEmptyTargets => '空のターゲットのみ埋める';
  @override
  String get limitToVisible => '表示中のものに限定';
  @override
  String get editMode => '編集モード';
  @override
  String get dialog => 'ダイアログ';
  @override
  String get inline => 'インライン';
}

// Path: advancedDiff.sidebar.similaritySection
class _TranslationsAdvancedDiffSidebarSimilaritySectionJa
    extends TranslationsAdvancedDiffSidebarSimilaritySectionEn {
  _TranslationsAdvancedDiffSidebarSimilaritySectionJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get currentFilter => '現在のフィルタ:';
  @override
  String get any => 'すべて';
  @override
  String get high => '高';
  @override
  String get medium => '中';
  @override
  String get low => '低';
}

// Path: advancedDiff.sidebar.statusSection
class _TranslationsAdvancedDiffSidebarStatusSectionJa
    extends TranslationsAdvancedDiffSidebarStatusSectionEn {
  _TranslationsAdvancedDiffSidebarStatusSectionJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String total({required Object count}) => '合計 ${count}';
  @override
  String extra({required Object count}) => '追加 ${count}';
  @override
  String missing({required Object count}) => '欠落 ${count}';
  @override
  String changed({required Object count}) => '変更 ${count}';
}

// Path: tutorial.steps.importSource
class _TranslationsTutorialStepsImportSourceJa
    extends TranslationsTutorialStepsImportSourceEn {
  _TranslationsTutorialStepsImportSourceJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '1. ソースファイルのインポート';
  @override
  String get description => '下のボタンを使用してファイルを参照するか、ハイライトされた領域にドラッグ＆ドロップしてください。';
}

// Path: tutorial.steps.importTarget
class _TranslationsTutorialStepsImportTargetJa
    extends TranslationsTutorialStepsImportTargetEn {
  _TranslationsTutorialStepsImportTargetJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '2. ターゲットファイルのインポート';
  @override
  String get description => '下のボタンを使用してファイルを参照するか、ハイライトされた領域にドラッグ＆ドロップしてください。';
}

// Path: tutorial.steps.compare
class _TranslationsTutorialStepsCompareJa
    extends TranslationsTutorialStepsCompareEn {
  _TranslationsTutorialStepsCompareJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '3. ファイルを比較';
  @override
  String get description => '下のボタンをタップして比較を実行し、結果を確認します。';
}

// Path: tutorial.steps.filter
class _TranslationsTutorialStepsFilterJa
    extends TranslationsTutorialStepsFilterEn {
  _TranslationsTutorialStepsFilterJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '4. 結果のフィルタリング';
  @override
  String get description => 'これらのフィルタを使用して、追加、削除、または修正された文字列を表示します。';
}

// Path: tutorial.steps.search
class _TranslationsTutorialStepsSearchJa
    extends TranslationsTutorialStepsSearchEn {
  _TranslationsTutorialStepsSearchJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '5. 検索結果';
  @override
  String get description => '検索バーを使用して、特定のキーや値を検索します。';
}

// Path: tutorial.steps.advanced
class _TranslationsTutorialStepsAdvancedJa
    extends TranslationsTutorialStepsAdvancedEn {
  _TranslationsTutorialStepsAdvancedJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '6. 詳細ビュー';
  @override
  String get description => '編集、AI 翻訳などを含む詳細な差異ビューを開きます。';
}

// Path: tutorial.steps.export
class _TranslationsTutorialStepsExportJa
    extends TranslationsTutorialStepsExportEn {
  _TranslationsTutorialStepsExportJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '7. 結果のエクスポート';
  @override
  String get description => '比較結果を CSV、JSON、または Excel ファイルとして保存します。';
}

// Path: settings.developer.themePlaygroundSection.palette
class _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteJa
    extends TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteJa._(
      TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get primary => 'プライマリ';
  @override
  String get onPrimary => 'オン・プライマリ';
  @override
  String get secondary => 'セカンダリ';
  @override
  String get onSecondary => 'オン・セカンダリ';
  @override
  String get surface => 'サーフェス';
  @override
  String get onSurface => 'オン・サーフェス';
  @override
  String get error => 'エラー';
  @override
  String get onError => 'オン・エラー';
  @override
  String get outline => 'アウトライン';
  @override
  String get shadow => 'シャドウ';
  @override
  String get success => '成功';
  @override
  String get warning => '警告';
  @override
  String get info => '情報';
}

// Path: settings.developer.featureFlags.flags
class _TranslationsSettingsDeveloperFeatureFlagsFlagsJa
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchJa
      experimental_ai_batch =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchJa._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmJa
      new_diff_algorithm =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmJa._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchJa
      enhanced_search =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchJa._(_root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveJa
      auto_save =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveJa._(_root);
}

// Path: settings.onboarding.steps.importFiles
class _TranslationsSettingsOnboardingStepsImportFilesJa
    extends TranslationsSettingsOnboardingStepsImportFilesEn {
  _TranslationsSettingsOnboardingStepsImportFilesJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'ファイルのインポート';
  @override
  String get description => 'ソースとターゲットのファイルを読み込みます';
}

// Path: settings.onboarding.steps.runComparison
class _TranslationsSettingsOnboardingStepsRunComparisonJa
    extends TranslationsSettingsOnboardingStepsRunComparisonEn {
  _TranslationsSettingsOnboardingStepsRunComparisonJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '比較の実行';
  @override
  String get description => '「ファイルを比較」をクリックします';
}

// Path: settings.onboarding.steps.reviewMissing
class _TranslationsSettingsOnboardingStepsReviewMissingJa
    extends TranslationsSettingsOnboardingStepsReviewMissingEn {
  _TranslationsSettingsOnboardingStepsReviewMissingJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '不足しているキーの確認';
  @override
  String get description => '赤色の「欠落」アイテムを確認してください';
}

// Path: settings.onboarding.steps.useFilters
class _TranslationsSettingsOnboardingStepsUseFiltersJa
    extends TranslationsSettingsOnboardingStepsUseFiltersEn {
  _TranslationsSettingsOnboardingStepsUseFiltersJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'フィルタの使用';
  @override
  String get description => 'タイプ別にフィルタリングします';
}

// Path: settings.onboarding.steps.searchResults
class _TranslationsSettingsOnboardingStepsSearchResultsJa
    extends TranslationsSettingsOnboardingStepsSearchResultsEn {
  _TranslationsSettingsOnboardingStepsSearchResultsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '検索結果';
  @override
  String get description => '特定のキーを検索します';
}

// Path: settings.onboarding.steps.advancedView
class _TranslationsSettingsOnboardingStepsAdvancedViewJa
    extends TranslationsSettingsOnboardingStepsAdvancedViewEn {
  _TranslationsSettingsOnboardingStepsAdvancedViewJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => '詳細ビュー';
  @override
  String get description => '詳細な分析を確認します';
}

// Path: settings.onboarding.steps.editCell
class _TranslationsSettingsOnboardingStepsEditCellJa
    extends TranslationsSettingsOnboardingStepsEditCellEn {
  _TranslationsSettingsOnboardingStepsEditCellJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'セルの編集';
  @override
  String get description => 'クリックして値を編集します';
}

// Path: settings.onboarding.steps.exportResults
class _TranslationsSettingsOnboardingStepsExportResultsJa
    extends TranslationsSettingsOnboardingStepsExportResultsEn {
  _TranslationsSettingsOnboardingStepsExportResultsJa._(TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'エクスポート';
  @override
  String get description => 'レポートを保存します';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchJa
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchJa._(
      TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get name => '実験的な AI バッチ';
  @override
  String get description => '複数の行に対してバッチ AI 翻訳を有効にします';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmJa
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmJa._(
      TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get name => '新しい比較アルゴリズム';
  @override
  String get description => '比較のために改善された比較アルゴリズムを使用します';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchJa
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchJa._(
      TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get name => '強化された検索';
  @override
  String get description => '翻訳ファイル内でのあいまい検索を有効にします';
}

// Path: settings.developer.featureFlags.flags.auto_save
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveJa
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveJa._(
      TranslationsJa root)
      : this._root = root,
        super.internal(root);

  final TranslationsJa _root; // ignore: unused_field

  // Translations
  @override
  String get name => '自動保存';
  @override
  String get description => '編集後に変更を自動的に保存します';
}

/// The flat map containing all translations for locale <ja>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsJa {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
          'app.title' => 'ローカリゼーション比較ツール',
          'app.name' => 'Localizer',
          'common.save' => '保存',
          'common.cancel' => 'キャンセル',
          'common.close' => '閉じる',
          'common.delete' => '削除',
          'common.edit' => '編集',
          'common.add' => '追加',
          'common.search' => '検索',
          'common.undo' => '元に戻す',
          'common.loading' => '読み込み中...',
          'common.error' => 'エラー',
          'common.success' => '成功',
          'common.warning' => '警告',
          'common.info' => '情報',
          'common.confirm' => '確認',
          'common.yes' => 'はい',
          'common.no' => 'いいえ',
          'common.ok' => 'OK',
          'common.retry' => '再試行',
          'common.copyText' => 'コピー',
          'common.appName' => 'Localizer',
          'common.copied' => 'コピーしました！',
          'common.enabled' => '有効',
          'common.disabled' => '無効',
          'common.browse' => '参照',
          'common.clear' => 'クリア',
          'common.apply' => '適用',
          'common.reset' => 'リセット',
          'common.refresh' => '更新',
          'common.export' => 'エクスポート',
          'common.import' => 'インポート',
          'common.select' => '選択',
          'common.selectAll' => 'すべて選択',
          'common.deselectAll' => 'すべての選択を解除',
          'common.noResults' => '結果が見つかりません',
          'common.emptyState' => 'データがありません',
          'common.open' => '開く',
          'common.change' => '変更',
          'common.original' => 'オリジナル',
          'common.kNew' => '新規',
          'common.remove' => '削除',
          'common.auto' => '自動',
          'common.execute' => '実行',
          'common.run' => '実行',
          'common.unknown' => '不明',
          'common.download' => 'ダウンロード',
          'common.dropdownArrow' => 'ドロップダウン矢印',
          'common.openInNewWindow' => '新しいウィンドウで開く',
          'common.resetToDefaults' => 'デフォルトにリセット',
          'menu.file' => 'ファイル',
          'menu.edit' => '編集',
          'menu.view' => '表示',
          'menu.help' => 'ヘルプ',
          'menu.openFiles' => 'ファイルを開く...',
          'menu.openFolder' => 'フォルダを開く...',
          'menu.exportResults' => '結果をエクスポート...',
          'menu.undo' => '元に戻す',
          'menu.redo' => 'やり直し',
          'menu.cut' => '切り取り',
          'menu.paste' => '貼り付け',
          'menu.selectAll' => 'すべて選択',
          'menu.zoomIn' => '拡大',
          'menu.zoomOut' => '縮小',
          'menu.resetZoom' => 'ズームをリセット',
          'menu.documentation' => 'ドキュメント',
          'menu.reportIssue' => '問題を報告',
          'menu.about' => ({required Object appName}) => '${appName} について',
          'nav.compare' => '比較',
          'nav.history' => '履歴',
          'nav.settings' => '設定',
          'nav.projects' => 'プロジェクト',
          'nav.dashboard' => 'ダッシュボード',
          'nav.directory' => 'ディレクトリ',
          'nav.repository' => 'リポジトリ',
          'nav.tooltipCompare' => 'ローカリゼーションファイルを比較',
          'nav.tooltipHistory' => '比較履歴を表示',
          'nav.tooltipSettings' => 'アプリ設定',
          'nav.tooltipProjects' => 'プロジェクト管理',
          'nav.tooltipThemeToggle' => 'テーマの切り替え',
          'nav.tooltipDebugConsole' => 'デバッグコンソール',
          'settings.title' => '設定',
          'settings.appSettings' => 'アプリ設定',
          'settings.projectSettings' => 'プロジェクト設定',
          'settings.appearance.title' => '外観',
          'settings.appearance.description' => 'アプリの見た目をカスタマイズします',
          'settings.appearance.theme' => 'テーマモード',
          'settings.appearance.themeDescription' => 'ライト、ダーク、またはシステムテーマを選択します',
          'settings.appearance.themeSystem' => 'システム',
          'settings.appearance.themeLight' => 'ライト',
          'settings.appearance.themeDark' => 'ダーク',
          'settings.appearance.themeAmoled' => 'AMOLED',
          'settings.appearance.accentColor' => 'アクセントカラー',
          'settings.appearance.accentColorDescription' => 'お好みのアクセントカラーを選択します',
          'settings.appearance.useMicaEffect' => 'Micaエフェクトを使用',
          'settings.appearance.micaDescription' =>
            'モダンな見た目のためにWindows 11のMica透過エフェクトを有効にします',
          'settings.appearance.diffFontSize' => '比較フォントサイズ',
          'settings.appearance.diffFontSizeDescription' =>
            '比較ビューのフォントサイズを調整します',
          'settings.appearance.diffFontFamily' => '比較フォントファミリー',
          'settings.appearance.diffFontFamilyDescription' => '比較ビューに使用するフォント',
          'settings.appearance.systemDefault' => 'システムデフォルト',
          'settings.appearance.pickAccentColor' => 'アクセントカラーを選択',
          'settings.appearance.diffColors' => '比較色',
          'settings.appearance.presetsTitle' => 'プリセット',
          'settings.appearance.presets.presetDefault' => 'デフォルト',
          'settings.appearance.presets.presetColorblind' => '色覚多様性対応',
          'settings.appearance.presets.presetHighContrast' => 'ハイコントラスト',
          'settings.appearance.presets.presetNord' => 'Nord',
          'settings.appearance.presets.presetSolarized' => 'Solarized',
          'settings.appearance.presets.presetMonokai' => 'Monokai',
          'settings.appearance.identical' => '同一',
          'settings.appearance.pickColorFor' => ({required Object label}) =>
              '${label} の色を選択',
          'settings.appearance.livePreview' => 'ライブプレビュー',
          'settings.appearance.preview.step3Title' => 'onboarding.step3.title',
          'settings.appearance.preview.connectAccount' => '"アカウントを接続"',
          'settings.appearance.preview.loginHint' => 'deprecated.login_hint_v1',
          'settings.appearance.preview.enterCredentials' => '"資格情報を入力"',
          'settings.appearance.preview.ctaButton' => 'checkout.cta_button',
          'settings.appearance.preview.buyNow' => '"今すぐ購入"',
          'settings.appearance.preview.completePurchase' => '"購入を完了"',
          'settings.appearance.preview.appNameKey' => 'common.app_name',
          'settings.appearance.preview.appNameValue' => '"Localizer"',
          'settings.general.title' => '全般',
          'settings.general.description' => '全般的なアプリケーション設定',
          'settings.general.language' => '言語',
          'settings.general.languageDescription' => '使用する言語を選択します',
          'settings.general.startMinimized' => 'トレイに最小化して起動',
          'settings.general.startMinimizedDescription' =>
            'システムトレイに最小化した状態でアプリを起動します',
          'settings.general.rememberWindowPosition' => 'ウィンドウ位置を記憶',
          'settings.general.rememberWindowPositionDescription' =>
            '起動時にウィンドウのサイズと位置を復元します',
          'settings.general.openLastProject' => '起動時に最後のプロジェクトを開く',
          'settings.general.openLastProjectDescription' =>
            'アプリ起動時に最後に使用したプロジェクトを自動的に開きます',
          'settings.general.application' => 'アプリケーション',
          'settings.general.defaultView' => 'デフォルトビュー',
          'settings.general.defaultViewDescription' => '起動時に表示するビュー',
          'settings.general.autoCheckUpdates' => 'アップデートの自動確認',
          'settings.general.autoCheckUpdatesDescription' => '起動時にアップデートを確認します',
          'settings.general.startupOptions' => '起動オプション',
          'settings.general.languageAuto' => '自動検出',
          'settings.general.viewBasic' => 'ファイル比較',
          'settings.general.viewHistory' => '履歴',
          'settings.general.viewDashboard' => '品質ダッシュボード',
          'settings.general.viewDirectory' => 'ディレクトリ比較',
          'settings.general.viewLastUsed' => '最後に使用したビュー',
          'settings.scope.title' => '設定のスコープ',
          'settings.scope.global' => 'グローバルデフォルト',
          'settings.scope.project' => 'プロジェクト',
          'settings.scope.reset' => 'プロジェクトをグローバルデフォルトにリセット',
          'settings.scope.resetConfirmation' =>
            'これにより、このプロジェクトのすべてのオーバーライドが解除され、グローバルデフォルトに戻ります。この操作は取り消せません。',
          'settings.scope.globalDescription' =>
            '変更は、個別に上書きされない限りすべてのプロジェクトに適用されます。',
          'settings.scope.projectDescription' => ({required Object name}) =>
              '変更は "${name}" にのみ適用されます。その他の設定はグローバルデフォルトから継承されます。',
          'settings.scope.createPrompt' =>
            '特定のフォルダの設定をカスタマイズするにはプロジェクトを作成してください',
          'settings.searchKeywords.general.0' => '言語',
          'settings.searchKeywords.general.1' => 'デフォルトビュー',
          'settings.searchKeywords.general.2' => '最近使ったファイルの数',
          'settings.searchKeywords.general.3' => '最後のプロジェクトを開く',
          'settings.searchKeywords.general.4' => '終了前に確認',
          'settings.searchKeywords.general.5' => '通知を表示',
          'settings.searchKeywords.comparisonEngine.0' => '比較モード',
          'settings.searchKeywords.comparisonEngine.1' => '類似度しきい値',
          'settings.searchKeywords.comparisonEngine.2' => '大文字小文字を区別',
          'settings.searchKeywords.comparisonEngine.3' => '空白を無視',
          'settings.searchKeywords.comparisonEngine.4' => '空行を無視',
          'settings.searchKeywords.comparisonEngine.5' => 'コメントを無視',
          'settings.searchKeywords.comparisonEngine.6' => 'パターンを無視',
          'settings.searchKeywords.appearance.0' => 'テーマ',
          'settings.searchKeywords.appearance.1' => 'テーマモード',
          'settings.searchKeywords.appearance.2' => 'アクセントカラー',
          'settings.searchKeywords.appearance.3' => '比較フォントサイズ',
          'settings.searchKeywords.appearance.4' => '比較フォントファミリー',
          'settings.searchKeywords.appearance.5' => '比較色',
          'settings.searchKeywords.appearance.6' => '追加された色',
          'settings.searchKeywords.appearance.7' => '削除された色',
          'settings.searchKeywords.appearance.8' => '変更された色',
          'settings.searchKeywords.appearance.9' => '同一の色',
          'settings.searchKeywords.appearance.10' => 'カラープリセット',
          'settings.searchKeywords.appearance.11' => 'プレビュー',
          'settings.searchKeywords.fileHandling.0' => 'ソース形式',
          'settings.searchKeywords.fileHandling.1' => 'ターゲット形式',
          'settings.searchKeywords.fileHandling.2' => 'デフォルトエンコーディング',
          'settings.searchKeywords.fileHandling.3' => '最近のプロジェクト数',
          'settings.searchKeywords.fileHandling.4' => '翻訳メモリ',
          'settings.searchKeywords.fileHandling.5' => 'メモリのインポート',
          'settings.searchKeywords.fileHandling.6' => 'メモリのエクスポート',
          'settings.searchKeywords.fileHandling.7' => 'メモリのクリア',
          'settings.searchKeywords.aiServices.0' => 'OpenAI APIキー',
          'settings.searchKeywords.aiServices.1' => 'Anthropic APIキー',
          'settings.searchKeywords.aiServices.2' => 'Google AI APIキー',
          'settings.searchKeywords.aiServices.3' => 'AIモデル',
          'settings.searchKeywords.aiServices.4' => '温度',
          'settings.searchKeywords.aiServices.5' => 'カスタムプロンプト',
          'settings.searchKeywords.systemIntegrations.0' => 'システムトレイ',
          'settings.searchKeywords.systemIntegrations.1' => '最小化して起動',
          'settings.searchKeywords.systemIntegrations.2' => 'ファイルの関連付け',
          'settings.searchKeywords.systemIntegrations.3' => 'Micaエフェクト',
          'settings.searchKeywords.systemIntegrations.4' => 'バイブランシー',
          'settings.searchKeywords.systemIntegrations.5' => 'ウィンドウ素材',
          'settings.searchKeywords.systemIntegrations.6' => 'Dockバッジ',
          'settings.searchKeywords.systemIntegrations.7' => '未翻訳数',
          'settings.searchKeywords.projectResources.0' => '用語集',
          'settings.searchKeywords.projectResources.1' => '翻訳メモリ',
          'settings.searchKeywords.projectResources.2' => '用語',
          'settings.searchKeywords.about.0' => 'バージョン',
          'settings.searchKeywords.about.1' => 'アップデートを確認',
          'settings.searchKeywords.about.2' => '自動アップデート',
          'settings.searchKeywords.about.3' => '変更履歴',
          'settings.searchKeywords.about.4' => 'ライセンス',
          'settings.searchKeywords.about.5' => 'プライバシーポリシー',
          'settings.searchKeywords.about.6' => 'テレメトリ',
          'settings.searchKeywords.about.7' => 'クラッシュレポート',
          'settings.searchKeywords.developer.0' => 'パフォーマンスオーバーレイ',
          'settings.searchKeywords.developer.1' => 'セマンティクスデバッガ',
          'settings.searchKeywords.developer.2' => 'マテリアルグリッド',
          'settings.searchKeywords.developer.3' => 'ラスターキャッシュ',
          'settings.searchKeywords.developer.4' => 'チュートリアルを再開',
          'settings.searchKeywords.developer.5' => '工場出荷時設定にリセット',
          'settings.comparison.title' => '比較',
          'settings.comparison.description' => '比較動作を設定します',
          'settings.comparison.caseSensitive' => '大文字小文字を区別',
          'settings.comparison.caseSensitiveDescription' =>
            '大文字と小文字を異なる文字として扱います',
          'settings.comparison.ignoreWhitespace' => '空白を無視',
          'settings.comparison.ignoreWhitespaceDescription' =>
            '比較時に先頭および末尾の空白を無視します',
          'settings.comparison.showLineNumbers' => '行番号を表示',
          'settings.comparison.showLineNumbersDescription' => '比較ビューに行番号を表示します',
          'settings.comparison.behavior' => '比較動作',
          'settings.comparison.ignoreCase' => '大文字小文字を無視',
          'settings.comparison.ignoreCaseDescription' =>
            '"Key" と "key" を同じものとして扱います',
          'settings.comparison.similarityThreshold' => '類似度しきい値',
          'settings.comparison.similarityThresholdDescription' =>
            '「変更」として検出する最小の類似度',
          'settings.comparison.mode' => '比較モード',
          'settings.comparison.modeDescription' => 'ファイル間でエントリを照合する方法',
          'settings.comparison.modeKey' => 'キーベース',
          'settings.comparison.modeKeyDescription' => 'キー名で照合します（デフォルト）。',
          'settings.comparison.modeOrder' => '順序ベース',
          'settings.comparison.modeOrderDescription' => 'ファイル内の位置で照合します。',
          'settings.comparison.modeSmart' => 'スマートマッチ',
          'settings.comparison.modeSmartDescription' =>
            '移動または名前が変更されたキーを検出します。',
          'settings.comparison.ignorePatterns' => '無視パターン',
          'settings.comparison.noIgnorePatterns' => '無視パターンが設定されていません。',
          'settings.comparison.addPattern' => 'パターンを追加',
          'settings.comparison.resetToGlobal' => 'すべての比較設定をグローバルデフォルトにリセット',
          'settings.comparison.patternPresets.comments' => 'コメント',
          'settings.comparison.patternPresets.tempKeys' => '一時的なキー',
          'settings.comparison.patternPresets.placeholders' => 'プレースホルダー',
          'settings.comparison.patternPresets.devOnly' => '開発専用',
          'settings.comparison.previewMatch.title' => '照合プレビュー',
          'settings.comparison.previewMatch.description' =>
            '現在の設定が照合ロジックにどのように影響するかテストします。',
          'settings.comparison.previewMatch.stringA' => '文字列 A',
          'settings.comparison.previewMatch.stringB' => '文字列 B',
          'settings.comparison.previewMatch.enterText' => 'テキストを入力...',
          'settings.comparison.previewMatch.similarity' => '類似度',
          'settings.comparison.previewMatch.identical' => '同一',
          'settings.comparison.previewMatch.identicalDescription' =>
            '正規化後に文字列が完全に一致します。',
          'settings.comparison.previewMatch.ignored' => '無視',
          'settings.comparison.previewMatch.ignoredDescription' =>
            '入力が無視パターンに一致します。',
          'settings.comparison.previewMatch.different' => '不一致',
          'settings.comparison.previewMatch.differentDescription' =>
            'いずれかの値が空です。',
          'settings.comparison.previewMatch.similarModified' => '類似 / 変更',
          'settings.comparison.previewMatch.similarModifiedDescription' => (
                  {required Object threshold}) =>
              '一致スコアがしきい値（${threshold}%）を超えています。',
          'settings.comparison.previewMatch.newDifferent' => '新規 / 不一致',
          'settings.comparison.previewMatch.newDifferentDescription' => (
                  {required Object threshold}) =>
              '一致スコアがしきい値（${threshold}%）を下回っています。',
          'settings.comparison.colorPresets.kDefault' => 'デフォルト',
          'settings.comparison.colorPresets.colorblindFriendly' => '色覚多様性対応',
          'settings.comparison.colorPresets.highContrast' => 'ハイコントラスト',
          'settings.comparison.colorPresets.nord' => 'Nord',
          'settings.comparison.colorPresets.solarized' => 'Solarized',
          'settings.comparison.colorPresets.monokai' => 'Monokai',
          'settings.comparison.colorPresets.presetDefault' => 'デフォルト',
          'settings.comparison.colorPresets.presetColorblind' => '色覚多様性対応',
          'settings.comparison.colorPresets.presetHighContrast' => 'ハイコントラスト',
          'settings.comparison.colorPresets.presetNord' => 'Nord',
          'settings.comparison.colorPresets.presetSolarized' => 'Solarized',
          'settings.comparison.colorPresets.presetMonokai' => 'Monokai',
          'settings.fileHandling.fileFormats' => 'ファイル形式',
          'settings.fileHandling.sourceFormat' => 'ソース形式',
          'settings.fileHandling.targetFormat' => 'ターゲット形式',
          'settings.fileHandling.encoding' => 'エンコーディング',
          'settings.fileHandling.sourceEncoding' => 'ソースエンコーディング',
          'settings.fileHandling.targetEncoding' => 'ターゲットエンコーディング',
          'settings.fileHandling.autoDetect' => '自動検出',
          'settings.fileHandling.autoDetectEncodingDescription' =>
            'ファイルのエンコーディングを自動的に検出します',
          'settings.fileHandling.exportSettings' => 'エクスポート設定',
          'settings.fileHandling.defaultExportFormat' => 'デフォルトのエクスポート形式',
          'settings.fileHandling.includeUtf8Bom' => 'UTF-8 BOMを含める',
          'settings.fileHandling.includeUtf8BomDescription' =>
            'Excelとの互換性に必要です',
          'settings.fileHandling.openFolderAfterExport' => 'エクスポート後にフォルダを開く',
          'settings.fileHandling.fileSafety' => 'ファイルの安全性',
          'settings.fileHandling.fileSafetyDescription' => '障害復旧のための自動ローカルコピー。',
          'settings.fileHandling.resetToGlobal' =>
            'すべてのファイル処理設定をグローバルデフォルトにリセット',
          'settings.translationMemory.title' => 'グローバル翻訳メモリ',
          'settings.translationMemory.autoLearn' => '自動学習',
          'settings.translationMemory.autoLearnDescription' =>
            '将来的な再利用のために翻訳をローカルメモリに保存します',
          'settings.translationMemory.confidenceThreshold' => '信頼度しきい値',
          'settings.translationMemory.confidenceThresholdDescription' =>
            ({required Object percent}) => '自動適用する最小スコア（${percent}%）',
          'settings.translationMemory.entries' => 'エントリ',
          'settings.translationMemory.size' => 'サイズ',
          'settings.translationMemory.memorySize' => ({required Object size}) =>
              'メモリサイズ: ${size}',
          'settings.translationMemory.import' => 'インポート',
          'settings.translationMemory.exportTmx' => 'TMXをエクスポート',
          'settings.translationMemory.exportCsv' => 'CSVをエクスポート',
          'settings.translationMemory.clearMemory' => 'メモリをクリア',
          'settings.translationMemory.importedItems' =>
            ({required Object count}) => '${count} 件のアイテムをメモリにインポートしました。',
          'settings.translationMemory.noItemsAdded' => 'アイテムは追加されませんでした。',
          'settings.translationMemory.nothingToExport' => 'エクスポートするデータがありません。',
          'settings.translationMemory.tmxSaved' => 'TMXを保存しました',
          'settings.translationMemory.csvSaved' => 'CSVを保存しました',
          'settings.translationMemory.clearConfirmTitle' => '翻訳メモリをクリアしますか？',
          'settings.translationMemory.clearConfirmContent' =>
            'これにより、このデバイスに保存されているすべての翻訳ペアが削除されます。この操作は取り消せません。',
          'settings.translationMemory.cleared' => '翻訳メモリをクリアしました。',
          'settings.translationMemory.couldNotClear' => 'メモリをクリアできませんでした。',
          'settings.backup.title' => '自動バックアップ',
          'settings.backup.description' => '自動バックアップ設定',
          'settings.backup.enabled' => '自動バックアップを有効にする',
          'settings.backup.enabledDescription' => '変更を加える前にファイルを自動的にバックアップします',
          'settings.backup.maxCopies' => '最大バックアップ数',
          'settings.backup.maxCopiesDescription' => 'ファイルごとに保持するバックアップコピーの数',
          'settings.backup.activeStatus' => ({required Object count}) =>
              '有効 · ${count} 個のコピーを保持中',
          'settings.backup.folder' => 'バックアップフォルダ',
          'settings.backup.folderDescription' => '同じフォルダを使用する場合は空のままにしてください',
          'settings.backup.useOriginalFolder' => '元のファイルフォルダを使用',
          'settings.ai.title' => 'AI サービス',
          'settings.ai.description' => 'AI 翻訳とアシスタンスを設定します',
          'settings.ai.provider' => 'AI プロバイダー',
          'settings.ai.providerDescription' => 'お好みの AI サービスプロバイダーを選択します',
          'settings.ai.apiKey' => 'API キー',
          'settings.ai.apiKeyDescription' => '選択したプロバイダーの API キーを入力します',
          'settings.ai.apiKeyPlaceholder' => 'API キーを入力...',
          'settings.ai.testConnection' => '接続テスト',
          'settings.ai.connectionSuccess' => '接続に成功しました！',
          'settings.ai.connectionFailed' => '接続に失敗しました。API キーを確認してください。',
          'settings.ai.translationStrategy' => '翻訳戦略',
          'settings.ai.strategy' => '戦略',
          'settings.ai.strategyDescription' => '文字列をどのように翻訳するか選択します',
          'settings.ai.strategyLLM' => '生成 AI (LLM)',
          'settings.ai.strategyCloud' => 'クラウド翻訳',
          'settings.ai.enableAiTranslation' => 'AI 翻訳を有効にする',
          'settings.ai.enableAiTranslationDescription' =>
            '翻訳の提案に AI を使用することを許可します',
          'settings.ai.llmProvider' => 'LLM サービスプロバイダー',
          'settings.ai.service' => 'サービス',
          'settings.ai.serviceDescription' => '生成 AI のプロバイダー',
          'settings.ai.providerGemini' => 'Google Gemini',
          'settings.ai.providerOpenAI' => 'OpenAI',
          'settings.ai.geminiApiKey' => 'Gemini API キー',
          'settings.ai.openAiApiKey' => 'OpenAI API キー',
          'settings.ai.model' => 'モデル',
          'settings.ai.modelDescription' => '使用するモデルを選択します',
          'settings.ai.advancedParameters' => '詳細パラメータ',
          'settings.ai.parameters' => 'パラメータ',
          'settings.ai.parametersDescription' => '温度、コンテキストなど',
          'settings.ai.temperature' => '温度',
          'settings.ai.temperatureDescription' => '値を高くすると、よりクリエイティブな出力になります',
          'settings.ai.maxTokens' => '最大トークン数',
          'settings.ai.maxTokensDescription' => 'コンテキストウィンドウの長さを制限します',
          'settings.ai.systemContext' => 'システムコンテキスト / 指示',
          'settings.ai.systemContextHint' =>
            'あなたはプロのローカライザーです。ソース文字列のトーンと意図を維持してください...',
          'settings.ai.systemContextHelper' =>
            'プロジェクトのスタイルや用語について、AI に具体的な指示を与えます。',
          'settings.ai.contextStrings' => 'コンテキスト文字列',
          'settings.ai.contextStringsDescription' =>
            'より良いコンテキストのために周囲の文字列を含めます',
          'settings.ai.contextCount' => 'コンテキスト数',
          'settings.ai.contextCountDescription' => '含める周囲の文字列の数',
          'settings.ai.cloudServices' => 'クラウド翻訳サービス',
          'settings.ai.googleTranslateApiKey' => 'Google 翻訳 API キー',
          'settings.ai.deeplApiKey' => 'DeepL API キー',
          'settings.ai.test' => 'テスト',
          'settings.ai.resetToGlobal' => 'すべての AI 設定をグローバルデフォルトにリセット',
          'settings.integrations.platformNotice' => 'プラットフォームに関する注意',
          'settings.integrations.platformNoticeDescription' =>
            'このプラットフォームではシステム連携をご利用いただけません。',
          'settings.integrations.visualEffects' => '視覚効果',
          'settings.integrations.explorerIntegration' => 'エクスプローラー連携',
          'settings.integrations.explorerIntegrationDescription' =>
            'フォルダの右クリックメニューに「Localizer で開く」を追加します。',
          'settings.integrations.addToContextMenu' => 'コンテキストメニューに追加',
          'settings.integrations.contextMenuAdded' => 'コンテキストメニューに追加しました！',
          'settings.integrations.contextMenuAddError' =>
            'コンテキストメニューへの追加に失敗しました',
          'settings.integrations.contextMenuRemoved' => 'コンテキストメニューから削除しました！',
          'settings.integrations.contextMenuRemoveError' =>
            'コンテキストメニューからの削除に失敗しました',
          'settings.integrations.fileAssociations' => 'ファイルの関連付け',
          'settings.integrations.fileAssociationsDescription' =>
            'エクスプローラーでダブルクリックしたときに Localizer で開くファイル形式を登録します。',
          'settings.integrations.registered' => '登録済み',
          'settings.integrations.notRegistered' => '未登録',
          'settings.integrations.extRegistered' => ({required Object ext}) =>
              '${ext} を登録しました！',
          'settings.integrations.extUnregistered' => ({required Object ext}) =>
              '${ext} の登録を解除しました！',
          'settings.integrations.extError' => (
                  {required Object ext, required Object action}) =>
              '${ext} の ${action} に失敗しました',
          'settings.integrations.registerAll' => 'すべて登録',
          'settings.integrations.unregisterAll' => 'すべて解除',
          'settings.integrations.registerAllResult' => (
                  {required Object total, required Object success}) =>
              '${total} 個中 ${success} 個のファイル形式を登録しました',
          'settings.integrations.unregisterAllResult' => (
                  {required Object total, required Object success}) =>
              '${total} 個中 ${success} 個のファイル形式の登録を解除しました',
          'settings.integrations.protocolHandler' => 'プロトコルハンドラー',
          'settings.integrations.protocolHandlerDescription' =>
            'このアプリケーションを開くための localizer:// URL を登録します。ブラウザのリンクなどから直接プロジェクトを開けるようになります。',
          'settings.integrations.protocolRegistered' => 'プロトコルハンドラーは登録済みです',
          'settings.integrations.protocolNotRegistered' => 'プロトコルハンドラーは未登録です',
          'settings.integrations.registerProtocol' => 'プロトコルを登録',
          'settings.integrations.unregister' => '登録解除',
          'settings.integrations.protocolRegisteredSuccess' =>
            'プロトコルハンドラーを登録しました！',
          'settings.integrations.protocolRemovedSuccess' =>
            'プロトコルハンドラーを削除しました！',
          'settings.integrations.protocolRegisterError' => '登録に失敗しました',
          'settings.integrations.protocolRemoveError' => '削除に失敗しました',
          'settings.integrations.windowMaterial' => 'ウィンドウ素材',
          'settings.integrations.windowMaterialDescription' =>
            'macOS のバイブランシー素材スタイルを選択します',
          'settings.integrations.dockIntegration' => 'Dock 連携',
          'settings.integrations.showDockBadge' => '未翻訳数を表示',
          'settings.integrations.showDockBadgeDescription' =>
            'Dock アイコンのバッジに未翻訳文字列の数を表示します',
          'settings.integrations.materials.sidebar' => 'サイドバー',
          'settings.integrations.materials.menu' => 'メニュー',
          'settings.integrations.materials.popover' => 'ポップオーバー',
          'settings.integrations.materials.titlebar' => 'タイトルバー',
          'settings.integrations.materials.underPageBackground' => 'ページ背景',
          'settings.integrations.materials.contentBackground' => 'コンテンツ',
          'settings.integrations.fileTypes.loc' => 'Localizer プロジェクトファイル',
          'settings.integrations.fileTypes.lang' => '言語ファイル',
          'settings.integrations.fileTypes.json' => 'JSON ローカリゼーションファイル',
          'settings.integrations.fileTypes.xml' => 'XML ローカリゼーションファイル',
          'settings.developer.title' => '開発者設定',
          'settings.developer.description' => '開発者向けの詳細設定',
          'settings.developer.showLocalizationKeys' => 'ローカリゼーションキーを表示',
          'settings.developer.localizationKeysDescription' =>
            '有効にすると、すべての翻訳テキストが翻訳後の値ではなくローカリゼーションキーとして表示されます。どのキーがどこで使用されているか確認するのに便利です。',
          'settings.developer.showPerformanceOverlay' => 'パフォーマンスオーバーレイを表示',
          'settings.developer.performanceOverlayDescription' =>
            'FPS とフレームタイミィング情報を表示します',
          'settings.developer.debugMode' => 'デバッグモード',
          'settings.developer.debugModeDescription' => '追加のログ記録とデバッグ機能を有効にします',
          'settings.developer.debuggingTools' => 'デバッグツール',
          'settings.developer.semanticsDebugger' => 'セマンティクスデバッガ',
          'settings.developer.semanticsDebuggerDescription' =>
            'セマンティクスツリーを可視化します',
          'settings.developer.materialGrid' => 'マテリアルグリッド',
          'settings.developer.materialGridDescription' =>
            'マテリアルレイアウトグリッドをオーバーレイ表示します',
          'settings.developer.rasterCache' => 'ラスターキャッシュイメージ',
          'settings.developer.rasterCacheDescription' =>
            'ラスターキャッシュイメージをチェッカーボード表示します',
          'settings.developer.actions' => 'アクション',
          'settings.developer.showLogs' => 'アプリアログを表示',
          'settings.developer.showLogsDescription' => 'Talker デバッグコンソールを開きます',
          'settings.developer.restartTutorial' => 'オンボーディングチュートリアルを再開',
          'settings.developer.restartTutorialDescription' =>
            'フラグをリセットしてチュートリアルを再度開始します',
          'settings.developer.restartRequested' => 'チュートリアルの再開がリクエストされました。',
          'settings.developer.throwException' => 'テスト例外をスロー',
          'settings.developer.throwExceptionDescription' =>
            'クラッシュレポート用のテスト例外を発生させます',
          'settings.developer.testExceptionMessage' => '開発者オプションからテスト例外が発生しました',
          'settings.developer.clearTM' => '翻訳メモリをクリア',
          'settings.developer.clearTMDescription' => 'キャッシュされたすべての翻訳を削除します',
          'settings.developer.clearTMConfirmation' => '翻訳メモリをクリアしますか？',
          'settings.developer.clearTMWarning' =>
            'これにより、学習したすべての翻訳が削除されます。この操作は取り消せません。',
          'settings.developer.tmCleared' => '翻訳メモリをクリアしました',
          'settings.developer.clearApiKeys' => 'API キーをクリア',
          'settings.developer.clearApiKeysDescription' =>
            '保存されているすべての API キーを削除します',
          'settings.developer.clearApiKeysConfirmation' => 'API キーをクリアしますか？',
          'settings.developer.clearApiKeysWarning' =>
            'これにより、セキュアストレージからすべての API キーが削除されます。',
          'settings.developer.apiKeysCleared' => 'API キーをクリアしました',
          'settings.developer.hideOptions' => '開発者オプションを非表示にする',
          'settings.developer.hideOptionsDescription' =>
            '開発者モードを無効にします（再有効化には 7 回タップが必要です）',
          'settings.developer.optionsDisabled' => '開発者オプションを無効にしました',
          'settings.developer.dangerZone' => '危険ゾーン',
          'settings.developer.factoryReset' => '工場出荷時設定にリセット',
          'settings.developer.factoryResetDescription' =>
            'すべての設定をリセットし、データを消去します',
          'settings.developer.factoryResetWarning' =>
            'すべての設定をリセットしてもよろしいですか？この操作は取り消せません。',
          'settings.developer.inspectionTools' => 'インスペクションツール',
          'settings.developer.searchHint' => '設定を検索...',
          'settings.developer.resetToDefault' => 'デフォルトにリセット',
          'settings.developer.resetToGlobal' => 'グローバルデフォルトにリセット',
          'settings.developer.storageInspector' => 'ストレージインスペクタ',
          'settings.developer.storageInspectorDescription' =>
            'Hive およびセキュアストレージの内容を表示します',
          'settings.developer.deviceEnvironment' => 'デバイスと環境',
          'settings.developer.deviceEnvironmentDescription' =>
            '画面、プラットフォーム、ビルド情報',
          'settings.developer.themePlayground' => 'テーマプレイグラウンド',
          'settings.developer.themePlaygroundDescription' => 'カラーパレットとタイポグラフィ',
          'settings.developer.themePlaygroundSection.colors' => '色',
          'settings.developer.themePlaygroundSection.typography' => 'タイポグラフィ',
          'settings.developer.themePlaygroundSection.palette.primary' =>
            'プライマリ',
          'settings.developer.themePlaygroundSection.palette.onPrimary' =>
            'オン・プライマリ',
          'settings.developer.themePlaygroundSection.palette.secondary' =>
            'セカンダリ',
          'settings.developer.themePlaygroundSection.palette.onSecondary' =>
            'オン・セカンダリ',
          'settings.developer.themePlaygroundSection.palette.surface' =>
            'サーフェス',
          'settings.developer.themePlaygroundSection.palette.onSurface' =>
            'オン・サーフェス',
          'settings.developer.themePlaygroundSection.palette.error' => 'エラー',
          'settings.developer.themePlaygroundSection.palette.onError' =>
            'オン・エラー',
          'settings.developer.themePlaygroundSection.palette.outline' =>
            'アウトライン',
          'settings.developer.themePlaygroundSection.palette.shadow' => 'シャドウ',
          'settings.developer.themePlaygroundSection.palette.success' => '成功',
          'settings.developer.themePlaygroundSection.palette.warning' => '警告',
          'settings.developer.themePlaygroundSection.palette.info' => '情報',
          'settings.developer.localizationInspector' => 'ローカリゼーションインスペクタ',
          'settings.developer.localizationInspectorDescription' =>
            '翻訳文字列をデバッグします',
          'settings.developer.hiveAppSettings' => 'Hive (AppSettings)',
          'settings.developer.secureStorageMasked' => 'セキュアストレージ (マスク済み)',
          'settings.developer.featureFlags.title' => '実験的な機能',
          'settings.developer.featureFlags.description' =>
            'テストのために機能フラグをローカルで切り替えます。これらのオーバーライドはアプリの再起動後も保持されます。',
          'settings.developer.featureFlags.subtitle' => '実験的な機能を上書き',
          'settings.developer.featureFlags.flags.experimental_ai_batch.name' =>
            '実験的な AI バッチ',
          'settings.developer.featureFlags.flags.experimental_ai_batch.description' =>
            '複数の行に対してバッチ AI 翻訳を有効にします',
          'settings.developer.featureFlags.flags.new_diff_algorithm.name' =>
            '新しい比較アルゴリズム',
          'settings.developer.featureFlags.flags.new_diff_algorithm.description' =>
            '比較のために改善された比較アルゴリズムを使用します',
          'settings.developer.featureFlags.flags.enhanced_search.name' =>
            '強化された検索',
          'settings.developer.featureFlags.flags.enhanced_search.description' =>
            '翻訳ファイル内でのあいまい検索を有効にします',
          'settings.developer.featureFlags.flags.auto_save.name' => '自動保存',
          'settings.developer.featureFlags.flags.auto_save.description' =>
            '編集後に変更を自動的に保存します',
          'settings.developer.featureFlags.reset' => 'すべてのフラグをリセット',
          'settings.developer.featureFlags.overrides' => 'ローカルオーバーライド',
          'settings.developer.featureFlags.defaultVal' => 'デフォルト',
          'settings.developer.featureFlags.on' => 'オン',
          'settings.developer.featureFlags.off' => 'オフ',
          'settings.developer.storageInspectorSection.refresh' => '更新',
          'settings.developer.storageInspectorSection.hiveData' => 'Hive データ',
          'settings.developer.storageInspectorSection.secureStorage' =>
            'セキュアストレージ',
          'settings.developer.deviceInfoSection.refresh' => '更新',
          'settings.developer.deviceInfoSection.copy' => 'クリップボードにコピー',
          'settings.developer.deviceInfoSection.computerName' => 'コンピュータ名',
          'settings.developer.deviceInfoSection.osVersion' => 'OS バージョン',
          'settings.developer.localizationInspectorSection.showKeys' =>
            '値の代わりにキーを表示',
          'settings.developer.localizationInspectorSection.keysVisible' =>
            'キーを表示中',
          'settings.developer.localizationInspectorSection.normalDisplay' =>
            '通常表示',
          'settings.developer.localizationInspectorSection.note' =>
            '注意: この機能を使用するには、アプリのローカリゼーションがこの設定を尊重するラッパーを使用している必要があります。',
          'settings.about.title' => 'このアプリについて',
          'settings.about.version' => 'バージョン',
          'settings.about.buildNumber' => 'ビルド番号',
          'settings.about.author' => '作成者',
          _ => null,
        } ??
        switch (path) {
          'settings.about.license' => 'ライセンス',
          'settings.about.sourceCode' => 'ソースコード',
          'settings.about.reportBug' => 'バグを報告',
          'settings.about.requestFeature' => '機能をリクエスト',
          'settings.about.checkForUpdates' => 'アップデートを確認',
          'settings.about.upToDate' => '最新の状態です！',
          'settings.about.updateAvailable' => ({required Object version}) =>
              'アップデートがあります: ${version}',
          'settings.about.updateAvailableBadge' => 'アップデートがあります！',
          'settings.about.developerSteps' => ({required Object count}) =>
              '開発者になるまであと ${count} ステップです。',
          'settings.about.developerActivated' => '開発者モードが有効になりました！',
          'settings.about.neverChecked' => '未確認',
          'settings.about.applicationInfo' => 'アプリケーション情報',
          'settings.about.platform' => 'プラットフォーム',
          'settings.about.updateInformation' => 'アップデート情報',
          'settings.about.currentVersion' => '現在のバージョン',
          'settings.about.latestVersion' => '最新のバージョン',
          'settings.about.lastChecked' => '最終確認日',
          'settings.about.checkingForUpdates' => '確認中...',
          'settings.about.whatsNew' => '新機能',
          'settings.about.systemInformation' => 'システム情報',
          'settings.about.dartVersion' => 'Dart バージョン',
          'settings.about.diskSpace' => '空きディスク容量',
          'settings.about.memoryUsage' => 'メモリ使用量',
          'settings.about.privacyTitle' => 'プライバシーとテレメトリ',
          'settings.about.usageStats' => '匿名の使用統計',
          'settings.about.requiresFirebase' => 'Firebase の設定が必要です',
          'settings.about.featureUnavailable' =>
            '機能は現在利用できません (Firebase が必要です)',
          'settings.about.settingsManagement' => '設定の管理',
          'settings.about.settingsManagementDescription' =>
            '設定をファイルにエクスポートして、バックアップしたり他のマシンと共有したりできます。',
          'settings.about.resetAll' => 'すべてリセット',
          'settings.about.links' => 'リンク',
          'settings.about.githubRepo' => 'GitHub リポジトリ',
          'settings.about.privacyPolicy' => 'プライバシーポリシー',
          'settings.about.crashReporting' => 'クラッシュレポート',
          'settings.onboarding.skipTutorial' => 'チュートリアルをスキップ',
          'settings.onboarding.gettingStarted' => 'はじめに',
          'settings.onboarding.stepProgress' => (
                  {required Object total, required Object current}) =>
              '${total} 中 ${current}',
          'settings.onboarding.loadSampleData' => 'サンプルデータを読み込む',
          'settings.onboarding.steps.importFiles.title' => 'ファイルのインポート',
          'settings.onboarding.steps.importFiles.description' =>
            'ソースとターゲットのファイルを読み込みます',
          'settings.onboarding.steps.runComparison.title' => '比較の実行',
          'settings.onboarding.steps.runComparison.description' =>
            '「ファイルを比較」をクリックします',
          'settings.onboarding.steps.reviewMissing.title' => '不足しているキーの確認',
          'settings.onboarding.steps.reviewMissing.description' =>
            '赤色の「欠落」アイテムを確認してください',
          'settings.onboarding.steps.useFilters.title' => 'フィルタの使用',
          'settings.onboarding.steps.useFilters.description' =>
            'タイプ別にフィルタリングします',
          'settings.onboarding.steps.searchResults.title' => '検索結果',
          'settings.onboarding.steps.searchResults.description' =>
            '特定のキーを検索します',
          'settings.onboarding.steps.advancedView.title' => '詳細ビュー',
          'settings.onboarding.steps.advancedView.description' => '詳細な分析を確認します',
          'settings.onboarding.steps.editCell.title' => 'セルの編集',
          'settings.onboarding.steps.editCell.description' => 'クリックして値を編集します',
          'settings.onboarding.steps.exportResults.title' => 'エクスポート',
          'settings.onboarding.steps.exportResults.description' => 'レポートを保存します',
          'settings.settingsView.resetCategoryTitle' =>
            ({required Object category}) => '${category} をリセットしますか？',
          'settings.settingsView.resetCategoryContent' =>
            'このカテゴリのすべての設定をデフォルト値にリセットします。',
          'settings.settingsView.resetAllTitle' => 'すべての設定をリセットしますか？',
          'settings.settingsView.resetAllContent' =>
            'すべての設定を工場出荷時のデフォルトに永久にリセットします。この操作は取り消せません。',
          'settings.settingsView.resetAll' => 'すべてリセット',
          'settings.settingsView.resetSuccess' =>
            ({required Object category}) => '${category} をリセットしました',
          'settings.settingsView.errorLoading' => '設定の読み込み中にエラーが発生しました',
          'settings.settingsView.settingsSaved' => '設定を保存しました',
          'settings.settingsView.updateAvailable' =>
            ({required Object version}) => 'アップデートがあります: v${version}',
          'settings.settingsView.latestVersion' => '最新のバージョンを使用しています',
          'settings.settingsView.whatsNew' => ({required Object version}) =>
              'v${version} の新機能',
          'settings.settingsView.downloadUpdate' => 'アップデートをダウンロード',
          'settings.settingsView.exportSettings' => '設定をエクスポート',
          'settings.settingsView.settingsExported' => '設定をエクスポートしました',
          'settings.settingsView.exportFail' => ({required Object error}) =>
              '設定のエクスポートに失敗しました: ${error}',
          'settings.settingsView.importSettings' => '設定をインポート',
          'settings.settingsView.importTitle' => '設定をインポートしますか？',
          'settings.settingsView.importContent' =>
            '現在のすべての設定がインポートされた内容に置き換わります。この操作は取り消せません。',
          'settings.settingsView.importSuccess' => '設定のインポートに成功しました！',
          'settings.settingsView.importFail' => ({required Object error}) =>
              '設定のインポートに失敗しました: ${error}',
          'settings.settingsView.invalidFormat' => '無効な設定ファイル形式です',
          'settings.settingsView.categories.general' => '全般設定',
          'settings.settingsView.categories.comparisonEngine' => '比較エンジン',
          'settings.settingsView.categories.appearance' => '外観',
          'settings.settingsView.categories.fileHandling' => 'ファイル処理',
          'settings.settingsView.categories.aiServices' => 'AI サービス',
          'settings.settingsView.categories.systemIntegrations' => 'システム連携',
          'settings.settingsView.categories.projectResources' =>
            'プロジェクトリソース (用語集と翻訳メモリ)',
          'settings.settingsView.categories.developer' => '開発者オプション',
          'settings.settingsView.categories.about' => 'このアプリについて',
          'settings.settingsView.categoryLabels.general' => '全般',
          'settings.settingsView.categoryLabels.comparisonEngine' => '比較',
          'settings.settingsView.categoryLabels.appearance' => '外観',
          'settings.settingsView.categoryLabels.fileHandling' => 'ファイル処理',
          'settings.settingsView.categoryLabels.aiServices' => 'AI サービス',
          'settings.settingsView.categoryLabels.systemIntegrations' => 'システム連携',
          'settings.settingsView.categoryLabels.projectResources' =>
            'プロジェクトリソース',
          'settings.settingsView.categoryLabels.developer' => '開発者オプション',
          'settings.settingsView.categoryLabels.about' => '詳細',
          'fileComparison.title' => 'ファイル比較',
          'fileComparison.openFiles' => 'ファイルを開く',
          'fileComparison.exportResults' => '結果をエクスポート',
          'fileComparison.restartTutorial' => 'チュートリアルを再開',
          'fileComparison.restartTutorialDevOnly' =>
            'チュートリアルの再開は開発者モードでのみ利用可能です。',
          'fileComparison.unsupportedFileType' => 'サポートされていないファイル形式です。',
          'fileComparison.unsupportedFileTypeSuggestion' =>
            'サポートされているローカリゼーションファイルを選択してください。',
          'fileComparison.someFilesUnsupported' => '一部のファイルがサポートされていません。',
          'fileComparison.pickSupportedFiles' =>
            'サポートされているローカリゼーションファイルのみを選択してください。',
          'fileComparison.pickTwoFiles' => '比較する 2 つのファイルを選択してください。',
          'fileComparison.pickBilingualFile' => '比較するバイリンガルファイルを選択してください。',
          'fileComparison.noResultsToExport' => 'エクスポートする結果がまだありません。',
          'fileComparison.performComparisonFirst' =>
            '結果をエクスポートするには、まず比較を行ってください。',
          'fileComparison.performComparisonFirstEditor' =>
            '詳細を確認するには、まず比較を行ってください。',
          'fileComparison.sampleDataLoaded' => 'サンプルデータを正常に読み込みました',
          'fileComparison.loadSampleDataError' => ({required Object error}) =>
              'サンプルデータの読み込みに失敗しました: ${error}',
          'fileComparison.invalidFileType' => '無効なファイル形式です。',
          'fileComparison.fileSelected' => (
                  {required Object label, required Object fileName}) =>
              '${label} が選択されました: ${fileName}',
          'fileComparison.sourceFile' => 'ソースファイル',
          'fileComparison.targetFile' => 'ターゲットファイル',
          'fileComparison.bilingualFile' => 'バイリンガルファイル',
          'fileComparison.compareFiles' => 'ファイルを比較',
          'fileComparison.compareFile' => 'ファイルを比較',
          'fileComparison.bilingualMode' => 'バイリンガルモード',
          'fileComparison.twoFilesMode' => '2 ファイルモード',
          'fileComparison.processing' => '処理中...',
          'fileComparison.remaining' => ({required Object time}) =>
              '残り ${time}',
          'fileComparison.comparisonInProgress' => '比較中...',
          'fileComparison.comparisonFailed' => ({required Object error}) =>
              '比較に失敗しました: ${error}',
          'fileComparison.fileChanged' => ({required Object fileName}) =>
              'ファイルが変更されました: ${fileName}。再比較中...',
          'fileComparison.dropFileHere' => 'ここにファイルをドロップ',
          'fileComparison.dropFileOrBrowse' => 'ファイルをドロップするかクリックして参照',
          'fileComparison.fileUpload' => 'ファイルをアップロード',
          'fileComparison.changeFile' => 'ファイルを変更',
          'fileComparison.total' => '合計',
          'fileComparison.show' => '表示',
          'fileComparison.showAll' => 'すべて表示',
          'fileComparison.noMatches' => ({required Object query}) =>
              '"${query}" に一致する結果はありません',
          'fileComparison.showingEntries' => (
                  {required Object total, required Object count}) =>
              '${total} 件中 ${count} 件のエントリを表示中',
          'fileComparison.filesIdentical' => 'ファイルは同一です。',
          'fileComparison.hiddenIdentical' => ({required Object count}) =>
              '${count} 件の同一エントリが非表示になっています',
          'fileComparison.showIdentical' => '同一のエントリを表示',
          'fileComparison.hideIdentical' => '同一のエントリを非表示',
          'fileComparison.noDiff' => 'キーに基づく差異は見つかりませんでした。',
          'fileComparison.source' => 'ソース',
          'fileComparison.target' => 'ターゲット',
          'fileComparison.value' => '値',
          'fileComparison.readyToCompare' => '比較の準備ができました',
          'fileComparison.readyToCompareDesc' =>
            '上にローカリゼーションファイルをドロップするか、参照ボタンを使用して\n比較するファイルを選択してください。',
          'fileComparison.recentComparisons' => '最近の比較',
          'fileComparison.bilingualFileLabel' => ({required Object name}) =>
              'バイリンガルファイル: ${name}',
          'fileComparison.comparisonLabel' => (
                  {required Object source, required Object target}) =>
              '${source} ↔ ${target}',
          'fileComparison.fileNotExist' => 'このセッションのファイルの一つ、または両方が存在しません。',
          'fileComparison.largeFileTitle' => '大きなファイルを検出',
          'fileComparison.largeFileContent' => ({required Object count}) =>
              '比較結果には ${count} 件のエントリが含まれています。\nすべて表示するとパフォーマンスが低下する可能性があります。\n\n続行しますか？',
          'fileComparison.dontShowAgain' => 'このファイルについては今後表示しない',
          'fileComparison.proceed' => '続行',
          'fileComparison.exportReport' => ({required Object format}) =>
              '${format} レポートを保存',
          'fileComparison.saved' => ({required Object format}) =>
              '${format} を保存しました',
          'fileComparison.saveError' => ({required Object format}) =>
              '${format} ファイルの保存に失敗しました。',
          'fileComparison.saveErrorDetailed' => (
                  {required Object format, required Object error}) =>
              '${format} の保存に失敗しました: ${error}',
          'fileComparison.watching' => '監視中',
          'fileComparison.watchOff' => '監視オフ',
          'fileComparison.watchingTooltip' => ({required Object status}) =>
              'ファイル監視: ${status}\nディスク上のファイルが変更されると自動的に再比較します',
          'fileComparison.aiSettingsNotAvailable' => 'AI 設定への移動は利用できません',
          'directoryComparison.title' => 'ディレクトリ比較',
          'directoryComparison.sourceDirectory' => 'ソースディレクトリ',
          'directoryComparison.targetDirectory' => 'ターゲットディレクトリ',
          'directoryComparison.sourceSubtitle' => 'オリジナル/参照ファイル',
          'directoryComparison.targetSubtitle' => '翻訳/比較ファイル',
          'directoryComparison.selectBothDirectories' =>
            'ソースとターゲットの両方のディレクトリを選択してください。',
          'directoryComparison.selectSourceFolder' => 'ソースフォルダを選択',
          'directoryComparison.selectTargetFolder' => 'ターゲットフォルダを選択',
          'directoryComparison.dropFolderHere' => 'フォルダをドロップするか、参照してください...',
          'directoryComparison.folderPath' => 'フォルダパス',
          'directoryComparison.readyToCompare' => 'ディレクトリ比較の準備完了',
          'directoryComparison.readyToCompareDesc' =>
            '上にフォルダをドロップするか、参照ボタンを使用して\n比較するディレクトリを選択してください。',
          'directoryComparison.nestedFolders' => 'ネストされたフォルダ',
          'directoryComparison.nestedFoldersTooltip' =>
            'すべてのネストされたディレクトリを再帰的に比較します',
          'directoryComparison.fileMatching' => 'ファイル照合',
          'directoryComparison.fileMatchingTooltip' => '名前でファイルを自動的にペアリングします',
          'directoryComparison.bulkExport' => '一括エクスポート',
          'directoryComparison.bulkExportTooltip' => 'すべての比較結果を一度にエクスポートします',
          'directoryComparison.notDirectoryComparison' => 'これはディレクトリ比較ではありません。',
          'directoryComparison.directoriesNotExist' => '一方または両方のディレクトリが存在しません。',
          'directoryComparison.errorOccurred' => 'エラーが発生しました',
          'directoryComparison.noFilesFound' => '選択したディレクトリにファイルが見つかりません。',
          'directoryComparison.unmatchedSourceFiles' => '一致しないソースファイル',
          'directoryComparison.unmatchedTargetFiles' => '一致しないターゲットファイル',
          'directoryComparison.filePairs' => ({required Object count}) =>
              '${count} 個のファイルペア',
          'directoryComparison.pairedFiles' => ({required Object count}) =>
              'ペアリングされたファイル (${count})',
          'directoryComparison.view' => '表示',
          'directoryComparison.failed' => '失敗',
          'directoryComparison.pair' => 'ペアリング...',
          'directoryComparison.pairDialogTitle' => ({required Object name}) =>
              '"${name}" のペアを選択:',
          'directoryComparison.discoverFiles' => 'ファイルを検索',
          'directoryComparison.compareAll' => 'すべて比較',
          'directoryComparison.exportAll' => 'すべてエクスポート',
          'directoryComparison.comparisonStarted' => '比較を開始しました...',
          'directoryComparison.discoveringFiles' => 'ファイルを検索中...',
          'directoryComparison.noResultsToExport' =>
            'エクスポートする比較結果がありません。まず「すべて比較」を実行してください。',
          'directoryComparison.selectExportFolder' => 'エクスポートフォルダを選択',
          'directoryComparison.createExportFolderError' =>
            ({required Object error}) => 'エクスポートフォルダの作成に失敗しました: ${error}',
          'directoryComparison.exportingResults' => '結果をエクスポート中',
          'directoryComparison.processingFile' => ({required Object file}) =>
              '処理中: ${file}',
          'directoryComparison.exportProgress' => (
                  {required Object total, required Object current}) =>
              '${total} 中 ${current} 個のファイルをエクスポート済み',
          'directoryComparison.exportComplete' => 'エクスポート完了',
          'directoryComparison.exportSuccessMessage' => (
                  {required Object count}) =>
              '${count} 個の比較ファイルとサマリーを正常にエクスポートしました。',
          'directoryComparison.exportFailed' => ({required Object error}) =>
              'エクスポート失敗: ${error}',
          'directoryComparison.close' => '閉じる',
          'gitComparison._translatorNote' =>
            'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.',
          'gitComparison.title' => 'リポジトリ比較',
          'gitComparison.repoSelector' => 'リポジトリを作成 / 開く',
          'gitComparison.noRepoSelected' => 'リポジトリが選択されていません',
          'gitComparison.open' => '開く',
          'gitComparison.refreshCommits' => 'コミットを更新',
          'gitComparison.noCommits' =>
            'コミットが見つからないか、読み込まれていません。ブランチを選択してコミットを読み込んでください。',
          'gitComparison.baseCommit' => 'ベースコミット（古い方）',
          'gitComparison.targetCommit' => 'ターゲットコミット（新しい方）',
          'gitComparison.filterCommitsByBranch' => 'ブランチでコミットをフィルタリング',
          'gitComparison.conflictDetection' => 'コンフリクト検出',
          'gitComparison.conflictDetectionTooltip' => 'マージコンフリクトを検出して解決します',
          'gitComparison.actions' => 'アクション:',
          'gitComparison.checkout' => 'Checkout',
          'gitComparison.merge' => 'Merge',
          'gitComparison.pull' => 'Pull',
          'gitComparison.checkoutBranch' => 'Checkout Branch',
          'gitComparison.mergeBranch' => 'Merge Branch into Current',
          'gitComparison.mergeConfirmation' => ({required Object branch}) =>
              '${branch} をマージしますか？',
          'gitComparison.mergeWarning' =>
            'これにより、現在の作業ブランチに変更がマージされます。コンフリクトが発生する可能性があります。',
          'gitComparison.selectExportFolder' => 'エクスポートフォルダを選択',
          'gitComparison.createExportFolderError' =>
            ({required Object error}) => 'エクスポートフォルダの作成に失敗しました: ${error}',
          'gitComparison.exportingFiles' => 'ファイルをエクスポート中',
          'gitComparison.processingFile' => ({required Object file}) =>
              '処理中: ${file}',
          'gitComparison.exportProgress' => (
                  {required Object total, required Object current}) =>
              '${total} 中 ${current} 個のファイルをエクスポート済み',
          'gitComparison.exportComplete' => 'エクスポート完了',
          'gitComparison.exportSuccessMessage' => ({required Object count}) =>
              '${count} 個のファイルをフルコンテンツで正常にエクスポートしました。',
          'gitComparison.exportDetail' => '各ファイルの差異は "files" サブフォルダに保存されます。',
          'gitComparison.diffViewer' => '差異ビューア',
          'gitComparison.base' => 'ベース',
          'gitComparison.target' => 'ターゲット',
          'gitComparison.noLines' => '表示する行がありません',
          'gitComparison.searchFiles' => 'ファイルを検索...',
          'gitComparison.noFilesMatch' => ({required Object query}) =>
              '"${query}" に一致するファイルはありません',
          'gitComparison.filesCount' => ({required Object count}) =>
              '${count} 個のファイル',
          'gitComparison.selectBaseFile' => 'ベースファイルを選択',
          'gitComparison.selectTargetFile' => 'ターゲットファイルを選択',
          'gitComparison.comparisonResults' => '比較結果',
          'gitComparison.noChanges' => '選択した参照間に変更は見つかりませんでした。',
          'gitComparison.linesAdded' => '追加された行',
          'gitComparison.linesRemoved' => '削除された行',
          'gitComparison.commit' => 'Commit',
          'gitComparison.branch' => 'Branch',
          'gitComparison.noRepositorySelected' => 'リポジリが選択されていません',
          'gitComparison.notGitComparison' => 'Git 比較ではありません',
          'gitComparison.repositoryNotExist' => 'リポジトリが存在しません',
          'gitComparison.mainBranch' => 'main',
          'gitComparison.masterBranch' => 'master',
          'gitComparison.backToControls' => '比較コントロールに戻る',
          'advancedComparison.placeholder' => '詳細比較ビュー - プレースホルダー',
          'advancedDiff.saveAllChanges' => 'すべての変更を保存しますか？',
          'advancedDiff.saveConfirmation' => ({required Object count}) =>
              'これにより、修正された ${count} 件のすべてのエントリがターゲットファイルに保存されます。この操作は取り消せません。',
          'advancedDiff.changesSaved' => '変更を正常に保存しました。',
          'advancedDiff.csvExported' => 'CSV をエクスポートしました',
          'advancedDiff.unsavedChanges' => '未保存の変更',
          'advancedDiff.unsavedChangesWarning' =>
            '保存されていない変更があります。破棄してもよろしいですか？',
          'advancedDiff.discardChanges' => '変更を破棄',
          'advancedDiff.goBack' => '戻る',
          'advancedDiff.breadcrumbs' => 'ホーム  >  エディタ',
          'advancedDiff.unsaved' => ({required Object count}) =>
              '${count} 件未保存',
          'advancedDiff.reviewed' => ({required Object count}) =>
              '${count} 件確認済み',
          'advancedDiff.saveAll' => ({required Object count}) =>
              'すべて保存 (${count})',
          'advancedDiff.allSaved' => 'すべて保存済み',
          'advancedDiff.saveAllTooltip' => 'すべての変更を保存 (Ctrl+S)',
          'advancedDiff.exportTooltip' => 'データをエクスポート (Ctrl+E)',
          'advancedDiff.aiSuggestion.aiTranslation' => 'AI 翻訳',
          'advancedDiff.aiSuggestion.aiRephrase' => 'AI 言い換え',
          'advancedDiff.aiSuggestion.key' => ({required Object key}) =>
              'キー: ${key}',
          'advancedDiff.aiSuggestion.original' => 'オリジナル:',
          'advancedDiff.aiSuggestion.suggestion' => '提案:',
          'advancedDiff.aiSuggestion.confidence' => 'AI 信頼度',
          'advancedDiff.aiSuggestion.cancelEdit' => '編集をキャンセル',
          'advancedDiff.aiSuggestion.editSuggestion' => '提案を編集',
          'advancedDiff.aiSuggestion.alternatives' => '代替案:',
          'advancedDiff.aiSuggestion.accept' => '適用',
          'advancedDiff.aiSuggestion.reject' => '拒否',
          'advancedDiff.aiSuggestion.stop' => '停止',
          'advancedDiff.detailEdit.title' => ({required Object key}) =>
              '編集: ${key}',
          'advancedDiff.detailEdit.sourceLabel' => 'ソース (オリジナル)',
          'advancedDiff.detailEdit.targetLabel' => 'ターゲット (翻訳)',
          'advancedDiff.detailEdit.translateWithCloud' => 'クラウドで翻訳',
          'advancedDiff.detailEdit.translateWithAi' => 'AI で翻訳',
          'advancedDiff.detailEdit.translating' => '翻訳中...',
          'advancedDiff.detailEdit.applyAndTm' => '適用',
          'advancedDiff.detailEdit.entryApplied' => 'エントリを適用し、翻訳メモリに追加しました',
          'advancedDiff.detailEdit.translationAdded' => '翻訳案が追加されました。',
          'advancedDiff.detailEdit.aiSuggestionAdded' => 'AI 案が追加されました。',
          'advancedDiff.table.addedToTM' => '翻訳メモリに追加しました',
          'advancedDiff.table.markedReviewed' => '確認済みとしてマークしました ✓',
          'advancedDiff.table.unmarkedReview' => '確認解除',
          'advancedDiff.table.reverted' => 'ソースの値に戻しました',
          'advancedDiff.table.entryDeleted' => 'エントリを削除しました',
          'advancedDiff.table.noSourceText' => '翻訳するソーステキストがありません。',
          'advancedDiff.table.aiTranslationFailed' => ({required Object key}) =>
              '"${key}" の AI 翻訳に失敗しました',
          'advancedDiff.table.noTargetText' => '言い換えるターゲットテキストがありません。',
          'advancedDiff.table.aiRephraseFailed' => ({required Object key}) =>
              '"${key}" の AI 言い換えに失敗しました',
          'advancedDiff.table.checkRowsFirst' => 'まずチェックボックスを使って行を選択してください',
          'advancedDiff.table.markedRowsReviewed' =>
            ({required Object count}) => '${count} 行を確認済みとしてマークしました',
          'advancedDiff.table.revertedRows' => ({required Object count}) =>
              '${count} 行を元に戻しました',
          'advancedDiff.table.entriesCount' => ({required Object count}) =>
              '${count} 件のエントリ',
          'advancedDiff.table.markSelectedReviewed' => '選択した項目を確認済みにする',
          'advancedDiff.table.revertSelected' => '選択した項目を元に戻す',
          'advancedDiff.table.noDifferences' => '差異は見つかりませんでした',
          'advancedDiff.table.adjustFilters' => 'フィルタを調整してみてください',
          'advancedDiff.table.cloudTranslationApplied' => 'クラウド翻訳を適用しました。',
          'advancedDiff.table.aiTranslationApplied' => 'AI 翻訳を適用しました。',
          'advancedDiff.table.suggestionApplied' => '提案を適用しました。',
          'advancedDiff.table.aiSuggestionApplied' => 'AI 提案を適用しました。',
          'advancedDiff.table.rephraseApplied' => '言い換えを適用しました。',
          'advancedDiff.table.aiRephraseApplied' => 'AI 言い換えを適用しました。',
          'advancedDiff.table.rephrase' => '言い換え',
          'advancedDiff.table.aiRephrase' => 'AI 言い換え',
          'advancedDiff.table.targetClickToEdit' => 'ターゲット (クリックして編集)',
          'advancedDiff.table.targetClickForDialog' => 'ターゲット (クリックしてダイアログを表示)',
          'advancedDiff.table.emptyClickToEdit' => '(空 - クリックして編集)',
          'advancedDiff.table.unmarkReviewed' => '確認マークを解除',
          'advancedDiff.table.markReviewed' => '確認済みとしてマーク',
          'advancedDiff.table.revertToSource' => 'ソースに戻す',
          'advancedDiff.table.translateWithCloud' => 'クラウドで翻訳',
          'advancedDiff.table.translateWithAi' => 'AI で翻訳',
          'advancedDiff.table.rephraseWithAi' => 'AI で言い換え',
          'advancedDiff.table.moreActions' => 'その他のアクション',
          'advancedDiff.table.editDetails' => '詳細を編集',
          'advancedDiff.table.suggestTranslation' => '翻訳を提案',
          'advancedDiff.table.addToTm' => '翻訳メモリに追加',
          'advancedDiff.table.deleteEntry' => 'エントリを削除',
          'advancedDiff.diffRow.copySource' => 'ソーステキストをコピー',
          'advancedDiff.diffRow.actions' => 'アクション',
          'advancedDiff.status.added' => '追加',
          'advancedDiff.status.missing' => '欠落',
          'advancedDiff.status.changed' => ({required Object percent}) =>
              '変更 ${percent}%',
          'advancedDiff.status.same' => '同一',
          'advancedDiff.sidebar.widgets' => 'ウィジェット',
          'advancedDiff.sidebar.searchPlaceholder' => 'キーと値を検索... (Ctrl+F)',
          'advancedDiff.sidebar.fuzzySearchTooltip' => 'あいまい検索 (タイポ許容)',
          'advancedDiff.sidebar.regexSearchTooltip' => '正規表現検索',
          'advancedDiff.sidebar.cloudTranslation' => 'クラウド翻訳',
          'advancedDiff.sidebar.aiTranslation' => 'AI 翻訳',
          'advancedDiff.sidebar.status' => 'ステータス',
          'advancedDiff.sidebar.tm' => '翻訳メモリ',
          'advancedDiff.sidebar.filters' => 'フィルタ',
          'advancedDiff.sidebar.actions' => 'アクション',
          'advancedDiff.sidebar.similarity' => '類似度',
          'advancedDiff.sidebar.actionsSection.exportMatches' => '一致項目をエクスポート',
          'advancedDiff.sidebar.actionsSection.preview' => 'プレビュー',
          'advancedDiff.sidebar.actionsSection.fillFromTmTitle' =>
            '翻訳メモリから入力しますか？',
          'advancedDiff.sidebar.actionsSection.fillFromTmContent' =>
            '翻訳メモリから一致するものを見つけて、空のターゲット値を埋めます。既存の値は上書きされません。',
          'advancedDiff.sidebar.actionsSection.fill' => '埋める',
          'advancedDiff.sidebar.actionsSection.fillFromMemory' => 'メモリから入力',
          'advancedDiff.sidebar.actionsSection.filledFromTm' =>
            ({required Object count}) => '翻訳メモリから ${count} 件のアイテムを入力しました。',
          'advancedDiff.sidebar.aiSection.infoCloud' =>
            'クラウド翻訳を使用して、ソースから空のターゲット値を翻訳します。',
          'advancedDiff.sidebar.aiSection.infoAi' =>
            'AI を使用して、ソースから空のターゲット値を翻訳します。',
          'advancedDiff.sidebar.aiSection.translationSettings' => '翻訳設定',
          'advancedDiff.sidebar.aiSection.aiSettings' => 'AI 設定',
          'advancedDiff.sidebar.aiSection.source' => 'ソース',
          'advancedDiff.sidebar.aiSection.target' => 'ターゲット',
          'advancedDiff.sidebar.aiSection.translatingProgress' =>
            ({required Object percent}) => '翻訳中... ${percent}%',
          'advancedDiff.sidebar.aiSection.translating' => '翻訳中...',
          'advancedDiff.sidebar.aiSection.translateAllMissing' =>
            '欠落しているものをすべて翻訳',
          'advancedDiff.sidebar.aiSection.translateAllTitle' =>
            '欠落しているものをすべて翻訳しますか？',
          'advancedDiff.sidebar.aiSection.translateAllContent' => (
                  {required Object service,
                  required Object source,
                  required Object target}) =>
              '${service} を使用して、${source} から ${target} への空のターゲット値を持つすべてのエントリを翻訳します。\n\n各提案を確認するか、すべて一度に適用できます。',
          'advancedDiff.sidebar.aiSection.translateAll' => 'すべて翻訳',
          'advancedDiff.sidebar.aiSection.reviewEach' => '個別に確認',
          'advancedDiff.sidebar.aiSection.cloudTranslated' =>
            ({required Object count}) => 'クラウド翻訳で ${count} 件のエントリを翻訳しました。',
          'advancedDiff.sidebar.aiSection.aiTranslated' =>
            ({required Object count}) => 'AI で ${count} 件のエントリを翻訳しました。',
          'advancedDiff.sidebar.aiSection.aiTranslateFailed' =>
            'AI 一括翻訳に失敗しました',
          'advancedDiff.sidebar.aiSection.noMissingEntries' =>
            '翻訳が必要な欠落したエントリはありません。',
          'advancedDiff.sidebar.aiSection.skip' => 'スキップ',
          'advancedDiff.sidebar.aiSection.stop' => '停止',
          'advancedDiff.sidebar.aiSection.cloudApplied' =>
            ({required Object count}) => '${count} 件の提案を適用しました。',
          'advancedDiff.sidebar.aiSection.aiApplied' =>
            ({required Object count}) => '${count} 件の AI 提案を適用しました。',
          'advancedDiff.sidebar.tmSection.enableTmFill' => 'TM 自動入力を有効にする',
          'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' =>
            '最小値以上で自動適用',
          'advancedDiff.sidebar.tmSection.matchSettings' => '一致設定',
          'advancedDiff.sidebar.tmSection.minMatch' => '最小一致:',
          'advancedDiff.sidebar.tmSection.limit' => '制限:',
          'advancedDiff.sidebar.tmSection.exact' => '完全一致',
          'advancedDiff.sidebar.filtersSection.viewFilters' => 'ビューフィルタ',
          'advancedDiff.sidebar.filtersSection.showAll' => 'すべて表示',
          'advancedDiff.sidebar.filtersSection.added' => '追加済み',
          'advancedDiff.sidebar.filtersSection.removed' => '削除済み',
          'advancedDiff.sidebar.filtersSection.modified' => '修正済み',
          'advancedDiff.sidebar.filtersSection.actionScope' => 'アクションスコープ',
          'advancedDiff.sidebar.filtersSection.applyToAdded' => '追加分に適用',
          'advancedDiff.sidebar.filtersSection.applyToModified' => '修正分に適用',
          'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' =>
            '空のターゲットのみ埋める',
          'advancedDiff.sidebar.filtersSection.limitToVisible' => '表示中のものに限定',
          'advancedDiff.sidebar.filtersSection.editMode' => '編集モード',
          'advancedDiff.sidebar.filtersSection.dialog' => 'ダイアログ',
          'advancedDiff.sidebar.filtersSection.inline' => 'インライン',
          'advancedDiff.sidebar.similaritySection.currentFilter' => '現在のフィルタ:',
          'advancedDiff.sidebar.similaritySection.any' => 'すべて',
          'advancedDiff.sidebar.similaritySection.high' => '高',
          'advancedDiff.sidebar.similaritySection.medium' => '中',
          'advancedDiff.sidebar.similaritySection.low' => '低',
          'advancedDiff.sidebar.statusSection.total' =>
            ({required Object count}) => '合計 ${count}',
          'advancedDiff.sidebar.statusSection.extra' =>
            ({required Object count}) => '追加 ${count}',
          'advancedDiff.sidebar.statusSection.missing' =>
            ({required Object count}) => '欠落 ${count}',
          'advancedDiff.sidebar.statusSection.changed' =>
            ({required Object count}) => '変更 ${count}',
          'issueDetails.title' => '問題の詳細',
          'issueDetails.showingIssues' => (
                  {required Object total, required Object count}) =>
              '${total} 件中 ${count} 件の問題を表示中',
          'issueDetails.searchPlaceholder' => 'キー、テキスト、またはエラーを検索...',
          'issueDetails.noDetails' => '詳細はありません。',
          'issueDetails.noMatches' => '一致する項目はありません。',
          'issueDetails.showMore' => 'さらに表示',
          'issueDetails.copyItems' => ({required Object count}) =>
              '${count} 件のアイテムをコピー',
          'issueDetails.close' => '閉じる',
          'issueDetails.copied' => 'クリップボードにコピーしました',
          'issueDetails.copiedCount' => ({required Object count}) =>
              '${count} 件のアイテムをコピーしました',
          'issueDetails.duplicateValue.label' => '重複した翻訳',
          'issueDetails.duplicateValue.warning' =>
            '異なるソーステキストに同じ翻訳が使用されています。コンテキストを確認してください。',
          'issueDetails.duplicateValue.affectedKeys' =>
            ({required Object count}) => '対象のキー (${count})',
          'issueDetails.duplicateValue.identicalSources' => '同一のソース',
          'issueDetails.duplicateValue.moreKeys' => ({required Object count}) =>
              '他 ${count} 個のキー',
          'issueDetails.lengthOutlier.source' => 'ソース',
          'issueDetails.lengthOutlier.translation' => '翻訳',
          'issueDetails.lengthOutlier.chars' => ({required Object count}) =>
              '${count} 文字',
          'issueDetails.standard.key' => 'キー',
          'issueDetails.standard.sourceText' => 'ソーステキスト',
          'issueDetails.standard.translation' => '翻訳',
          'issueDetails.standard.errorDetails' => 'エラー詳細',
          'issueDetails.standard.note' => 'メモ',
          'issueDetails.review' => '確認',
          'issueDetails.types.duplicateValue' => '重複する値',
          'issueDetails.types.lengthOutlier' => '長さの不一致',
          'issueDetails.types.placeholderMismatch' => '破損したプレースホルダー',
          'issueDetails.notes.placeholderMismatch' =>
            '{name} のようなマーカーはソースと一致させる必要があります。',
          'issueDetails.notes.lengthOutlier' =>
            '長さが大きく変わると、画面上でのテキストの収まりに影響する可能性があります。',
          'issueDetails.notes.duplicateValue' => '異なるキーに同じ翻訳が使用されています。',
          'issueDetails.fallbacks.multipleSources' => '複数のソーステキスト',
          'issueDetails.fallbacks.sourceNotAvailable' => 'ソーステキスト利用不可',
          'issueDetails.fallbacks.sharedTranslationNotAvailable' => '共有翻訳利用不可',
          'issueDetails.fallbacks.translationNotAvailable' => '翻訳利用不可',
          'importReview.title' => 'プロジェクトインポートの確認',
          'importReview.projectName' => 'プロジェクト名',
          'importReview.created' => '作成日',
          'importReview.historyItems' => '履歴アイテム',
          'importReview.customSettingsTitle' => 'カスタム設定を検出',
          'importReview.customSettingsWarning' =>
            'このプロジェクトには、プロジェクトを開いている間にデフォルトを上書きするカスタム設定が含まれています。',
          'importReview.standardSettings' => 'このプロジェクトは標準的なグローバル設定を使用しています。',
          'importReview.cancelImport' => 'インポートをキャンセル',
          'importReview.trustOpen' => '信頼してプロジェクトを開く',
          'historyView.title' => '比較履歴',
          'historyView.clearAll' => 'すべての履歴をクリア',
          'historyView.searchPlaceholder' => 'ファイル名で検索...',
          'historyView.sortBy' => '並び替え',
          'historyView.sortDate' => '日付',
          'historyView.sortSource' => 'ソースファイル',
          'historyView.sortTarget' => 'ターゲットファイル',
          'historyView.showCurrentProject' => '表示中: 現在のプロジェクト',
          'historyView.showAllHistory' => '表示中: すべての履歴',
          'historyView.groupByFolder' => 'フォルダでグループ化',
          'historyView.disableGrouping' => 'グループ化を無効にする',
          'historyView.filterAll' => 'すべて',
          'historyView.filterFiles' => 'ファイル',
          'historyView.filterDirectories' => 'ディレクトリ',
          'historyView.filterGit' => 'Git',
          'historyView.noHistory' => '比較履歴がまだありません',
          'historyView.historyDescription' => 'ここにはファイルの比較履歴が表示されます',
          'historyView.noResults' => '結果が見つかりません',
          'historyView.adjustSearch' => '検索条件を調整してみてください',
          'historyView.clearConfirmationTitle' => 'すべての履歴をクリアしますか？',
          'historyView.clearConfirmationContent' =>
            'すべての比較履歴を永久に削除します。この操作は取り消せません。',
          'historyView.clearAction' => 'すべてクリア',
          'historyView.deletedMessage' => '履歴アイテムを削除しました',
          'historyView.undo' => '元に戻す',
          'historyView.viewDetails' => '詳細を表示',
          'historyView.delete' => '削除',
          'historyView.openLocation' => 'ファイルの場所を開く',
          'historyView.bilingual' => 'バイリンガル',
          'historyView.filePair' => 'ファイルペア',
          'historyView.directory' => 'ディレクトリ',
          'historyView.git' => 'Git',
          'historyView.repo' => 'リポジトリ',
          'historyView.sourceDir' => 'ソースディレクトリ',
          'historyView.targetDir' => 'ターゲットディレクトリ',
          'historyView.source' => 'ソース',
          'historyView.target' => 'ターゲット',
          'historyView.noChanges' => '変更は検出されませんでした',
          'historyView.added' => '追加済み',
          'historyView.removed' => '削除済み',
          'historyView.modified' => '修正済み',
          'historyView.same' => '同一',
          'historyView.total' => '合計',
          'historyView.currentProject' => '現在のプロジェクト',
          'historyView.unassigned' => '未割り当て',
          'historyView.project' => 'プロジェクト',
          'compare.title' => 'ファイルを比較',
          'compare.sourceFile' => 'ソースファイル',
          'compare.targetFile' => 'ターゲットファイル',
          'compare.sourceFolder' => 'ソースフォルダ',
          'compare.targetFolder' => 'ターゲットフォルダ',
          'compare.dropFilesHint' =>
            'ここにローカリゼーションファイルをドロップするか、参照ボタンを使用して比較するファイルを選択してください。',
          'compare.selectSourceFile' => 'ソースファイルを選択',
          'compare.selectTargetFile' => 'ターゲットファイルを選択',
          'compare.startComparison' => '比較を開始',
          'compare.comparing' => '比較中...',
          'compare.comparisonComplete' => '比較完了',
          'compare.noChanges' => '変更は検出されませんでした',
          'compare.filesIdentical' => 'ファイルは同一です',
          'compare.changesFound' => ({required Object count}) =>
              '${count} 件の変更が見つかりました',
          'compare.tabs.files' => 'ファイル',
          'compare.tabs.directories' => 'ディレクトリ',
          'compare.tabs.git' => 'Git',
          'compare.fileTypes.json' =>
            'JSON ローカリゼーションファイル (i18next, Flutter など)',
          'compare.fileTypes.yaml' => 'YAML ローカリゼーションファイル (Rails, Flutter)',
          'compare.fileTypes.xml' => 'XML ローカリゼーションファイル (Android, .NET)',
          'compare.fileTypes.properties' => 'Properties ファイル (Java)',
          'compare.fileTypes.resx' => 'RESX ファイル (.NET)',
          _ => null,
        } ??
        switch (path) {
          'compare.fileTypes.xliff' => 'XLIFF ファイル',
          'history.title' => '履歴',
          'history.recentComparisons' => '最近の比較',
          'history.noHistory' => '比較履歴がまだありません',
          'history.noHistoryDescription' => 'ここには比較履歴が表示されます',
          'history.clearHistory' => '履歴をクリア',
          'history.clearHistoryConfirm' => 'すべての履歴をクリアしてもよろしいですか？',
          'history.deleteEntry' => 'エントリを削除',
          'history.openComparison' => '比較を開く',
          'history.timeAgo.justNow' => 'たった今',
          'history.timeAgo.secondsAgo' => ({required Object count}) =>
              '${count} 秒前',
          'history.timeAgo.oneMinuteAgo' => '1 分前',
          'history.timeAgo.minutesAgo' => ({required Object count}) =>
              '${count} 分前',
          'history.timeAgo.oneHourAgo' => '1 時間前',
          'history.timeAgo.hoursAgo' => ({required Object count}) =>
              '${count} 時間前',
          'history.timeAgo.yesterday' => '昨日',
          'history.timeAgo.daysAgo' => ({required Object count}) =>
              '${count} 日前',
          'history.timeAgo.oneWeekAgo' => '1 週間前',
          'history.timeAgo.weeksAgo' => ({required Object count}) =>
              '${count} 週間前',
          'history.timeAgo.oneMonthAgo' => '1 ヶ月前',
          'history.timeAgo.monthsAgo' => ({required Object count}) =>
              '${count} ヶ月前',
          'history.timeAgo.oneYearAgo' => '1 年前',
          'history.timeAgo.yearsAgo' => ({required Object count}) =>
              '${count} 年前',
          'history.timeAgo.inTheFuture' => '未来',
          'projects.title' => 'プロジェクト',
          'projects.createProject' => 'プロジェクトを作成',
          'projects.importProject' => 'プロジェクトをインポート',
          'projects.noProjects' => 'プロジェクトがまだありません',
          'projects.noProjectsDescription' =>
            'ローカリゼーションファイルを整理するためにプロジェクトを作成してください',
          'projects.projectName' => 'プロジェクト名',
          'projects.projectPath' => 'プロジェクトパス',
          'projects.lastOpened' => '最終閲覧日',
          'projects.openProject' => 'プロジェクトを開く',
          'projects.closeProject' => 'プロジェクトを閉じる',
          'projects.deleteProject' => 'プロジェクトを削除',
          'projects.deleteProjectConfirm' => 'このプロジェクトを削除してもよろしいですか？',
          'projects.exportProject' => 'プロジェクトをエクスポート',
          'projects.exportDescription' =>
            'ソースファイル、設定、履歴を含むポータブルな ZIP ファイルを作成します。',
          'projects.exporting' => 'プロジェクトをエクスポート中...',
          'projects.exportSuccess' => 'プロジェクトをエクスポートしました',
          'projects.exportError' => ({required Object error}) =>
              'エクスポートに失敗しました: ${error}',
          'projects.createNewProject' => '新規プロジェクト作成',
          'projects.openExistingProject' => '既存のプロジェクトを開く',
          'projects.importProjectZip' => 'プロジェクト ZIP をインポート',
          'projects.projectResources' => 'プロジェクトリソース',
          'projects.recentProjects' => '最近のプロジェクト',
          'projects.noRecentProjects' => '最近のプロジェクトはありません',
          'projects.selectProjectZip' => 'プロジェクト ZIP を選択',
          'projects.selectDestination' => 'インポート先のフォルダを選択',
          'projects.importing' => 'プロジェクトをインポート中...',
          'projects.importSuccess' => 'プロジェクトを正常にインポートしました',
          'projects.importFailed' => ({required Object error}) =>
              'インポートに失敗しました: ${error}',
          'projects.importingFiles' => 'ファイルをインポート中...',
          'projects.noSupportedFiles' => 'ドロップされたファイルにサポートされている形式はありませんでした。',
          'projects.stats.empty' => '空のプロジェクト',
          'projects.stats.files' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ja'))(
                n,
                one: '1 つの翻訳ファイル',
                other: '${count} 個の翻訳ファイル',
              ),
          'projects.stats.languages' => (
                  {required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ja'))(
                n,
                one: '1 言語',
                other: '${count} 言語',
              ),
          'projects.openProjectFirst' => 'リソースを管理するには、まずプロジェクトを開いてください。',
          'projects.removeFromRecent' => '最近使った項目から削除',
          'projects.selection.selectFolder' => 'プロジェクトフォルダを選択',
          'projects.selection.selectArchive' => 'プロジェクトアーカイブを選択',
          'projects.selection.openProject' => 'プロジェクトを開く',
          'projects.selection.browseFolder' => 'フォルダをブラウズ...',
          'projects.selection.createNew' => '新規作成',
          'projects.selection.importFromZip' => 'Zip からインポート...',
          'projects.createDialog.title' => 'プロジェクトを作成',
          'projects.createDialog.description' =>
            'プロジェクトを使用すると、特定のフォルダのカスタム設定を保存できます。プロジェクト設定を保存するために ".localizer" フォルダが作成されます。',
          'projects.createDialog.folderLabel' => 'プロジェクトフォルダ',
          'projects.createDialog.folderHint' => 'クリックしてフォルダを選択...',
          'projects.createDialog.nameLabel' => 'プロジェクト名',
          'projects.createDialog.nameHint' => '例: 私のアプリの翻訳',
          'projects.createDialog.selectFolderWarning' => 'プロジェクトフォルダを選択してください。',
          'projects.createDialog.enterNameError' => 'プロジェクト名を入力してください',
          'projects.createDialog.nameLengthError' => '名前は 2 文字以上である必要があります',
          'projects.createDialog.success' => ({required Object name}) =>
              'プロジェクト "${name}" を正常に作成しました！',
          'projects.createDialog.failure' => 'プロジェクトの作成に失敗しました。',
          'projects.createDialog.creating' => '作成中...',
          'projects.createDialog.createAction' => 'プロジェクトを作成',
          'projects.indicator.tooltipNoProject' =>
            '特定のフォルダのカスタム設定を保存するためにプロジェクトを作成します',
          'projects.indicator.tooltipProject' => ({required Object name}) =>
              'プロジェクト: ${name}\nクリックしてオプションを表示',
          'projects.indicator.location' => '場所',
          'projects.indicator.created' => '作成日',
          'projects.indicator.switchProject' => 'プロジェクトを切り替え',
          'projects.indicator.done' => '完了',
          'projects.glossary.title' => 'プロジェクト用語集',
          'projects.glossary.description' =>
            '一貫して扱う必要のある用語や、翻訳してはいけない用語を定義します。',
          'projects.glossary.noTerms' => '用語集に用語がありません。',
          'projects.glossary.noTermsDesc' =>
            '翻訳を通じて一貫性を保つ必要のある用語や、\n翻訳してはいけないブランド名などを追加してください。',
          'projects.glossary.doNotTranslate' => '翻訳しない',
          'projects.glossary.noSpecificTranslation' => '特定の翻訳なし',
          'projects.glossary.addTerm' => '用語を追加',
          'projects.glossary.editTerm' => '用語を編集',
          'projects.glossary.term' => '用語',
          'projects.glossary.termHint' => '例: ブランド名、専門用語',
          'projects.glossary.definition' => '定義 (任意)',
          'projects.glossary.definitionHint' => '翻訳者へのコンテキスト情報',
          'projects.glossary.doNotTranslateLabel' => '翻訳しない',
          'projects.glossary.doNotTranslateDesc' => 'ターゲットでも用語をそのまま保持します',
          'projects.glossary.preferredTranslation' => '優先される翻訳',
          'projects.glossary.caseSensitive' => '大文字小文字を区別',
          'projects.conflicts.missingApiKeyTitle' =>
            ({required Object service}) => '${service} の API キーが不足しています',
          'projects.conflicts.missingApiKeyMessage' => (
                  {required Object service}) =>
              'このプロジェクトは ${service} を使用しますが、API キーが設定されていません。設定 > AI サービスで API キーを追加してください。追加しない場合は、アプリのグローバルデフォルトが使用されます。',
          'projects.conflicts.dismiss' => '閉じる',
          'projects.tm.title' => '翻訳メモリ',
          'projects.tm.description' => 'このプロジェクトの翻訳メモリソースを管理します。',
          'projects.tm.globalTm' => 'グローバル翻訳メモリ',
          'projects.tm.globalTmDescription' => 'アプリ設定の共有翻訳メモリを使用します',
          'projects.tm.linkedFiles' => 'リンクされたファイル (プロジェクト固有)',
          'projects.tm.noLinkedFiles' => 'リンクされたプロジェクト固有のファイルはありません。',
          'projects.tm.addTmFile' => 'TM ファイルを追加',
          'projects.tm.useGlobalTm' => 'グローバル TM を使用',
          'projects.tm.selectTm' => '翻訳メモリを選択',
          'projects.tm.globalTmEnabled' => 'グローバル翻訳メモリが有効です',
          'diff.added' => '追加済み',
          'diff.removed' => '削除済み',
          'diff.modified' => '修正済み',
          'diff.unchanged' => '未変更',
          'diff.missing' => '欠落',
          'diff.extra' => '余分',
          'diff.sourceValue' => 'ソースの値',
          'diff.targetValue' => 'ターゲットの値',
          'diff.key' => 'キー',
          'diff.status' => 'ステータス',
          'diff.actions' => 'アクション',
          'diff.copyToTarget' => 'ターゲットにコピー',
          'diff.acceptChange' => '変更を適用',
          'diff.rejectChange' => '変更を拒否',
          'diff.viewDetails' => '詳細を表示',
          'git.title' => 'Git 比較',
          'git.selectRepository' => 'リポジトリを選択',
          'git.selectBranch' => 'ブランチを選択',
          'git.selectCommit' => 'コミットを選択',
          'git.compareBranches' => 'ブランチを比較',
          'git.compareCommits' => 'コミットを比較',
          'git.baseBranch' => 'ベースブランチ',
          'git.compareBranch' => '比較ブランチ',
          'git.noRepositories' => 'Git リポジトリが見つかりません',
          'git.noRepositoriesDescription' => 'Git リポジトリを含むフォルダを開いてください',
          'git.filesChanged' => ({required Object count}) =>
              '${count} 個のファイルが変更されました',
          'git.additions' => ({required Object count}) => '${count} 個の追加',
          'git.deletions' => ({required Object count}) => '${count} 個の削除',
          'git.conflicts.title' => 'マージコンフリクトを検出',
          'git.conflicts.description' => '続行する前に、これらのコンフリクトを解決する必要があります。',
          'git.conflicts.abortMergeTitle' => 'マージを中止しますか？',
          'git.conflicts.abortMergeContent' =>
            'すべてのマージによる変更を元に戻し、マージ前の状態に戻ります。この操作は取り消せません。',
          'git.conflicts.abortMergeAction' => 'マージを中止',
          'git.conflicts.stagingFile' => ({required Object file}) =>
              'コミットのために ${file} をステージング中...',
          'git.conflicts.conflictedFilesCount' => ({required Object count}) =>
              'コンフリクトのあるファイル (${count})',
          'git.conflicts.selectFileToResolve' => '解決するファイルを選択',
          'git.conflicts.resolvingFile' => ({required Object file}) =>
              '解決中: ${file}',
          'git.conflicts.keepAllOurs' => '自分の変更をすべて保持',
          'git.conflicts.acceptAllTheirs' => '相手の変更をすべて受け入れる',
          'git.conflicts.allResolved' => 'このファイルのすべてのコンフリクトが解決されました！',
          'git.conflicts.markResolved' => '解決済みとしてマーク',
          'git.conflicts.stageForCommit' => 'これによりファイルがコミット用にステージングされます。',
          'git.conflicts.conflictIndex' => ({required Object index}) =>
              'コンフリクト #${index}',
          'git.conflicts.ours' => '自分の変更 (現在)',
          'git.conflicts.theirs' => '相手の変更 (取り込み)',
          'git.conflicts.keepOurs' => '自分の変更を保持',
          'git.conflicts.acceptTheirs' => '相手の変更を受け入れる',
          'git.conflicts.empty' => '(空)',
          'quality._translatorNote' =>
            'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.',
          'quality.title' => '品質ダッシュボード',
          'quality.overallScore' => '総合スコア',
          'quality.issues' => '問題',
          'quality.warnings' => '警告',
          'quality.suggestions' => '提案',
          'quality.placeholderMismatch' => 'プレースホルダーの不一致',
          'quality.placeholderMismatchDescription' =>
            '{name} のようなプレースホルダーがソースとターゲットで一致していません',
          'quality.lengthOutlier' => '長さの異常値',
          'quality.lengthOutlierDescription' => '翻訳の長さがソースと大きく異なります',
          'quality.duplicateValue' => '重複する値',
          'quality.duplicateValueDescription' => '複数のキーに同じ翻訳が使用されています',
          'quality.missingTranslation' => '翻訳の欠落',
          'quality.missingTranslationDescription' => 'このキーの翻訳がありません',
          'quality.loading' => 'ダッシュボードを読み込み中...',
          'quality.errorLoading' => '履歴を読み込めませんでした。再試行してください。',
          'quality.emptyState' => 'ダッシュボードを表示するには比較を実行してください。',
          'quality.refresh' => '更新',
          'quality.buildingInsights' => 'インサイトを構築中...',
          'quality.crunchingNumbers' => '数値を計算中...',
          'quality.errorBuilding' => 'ダッシュボードを構築できませんでした。再試行してください。',
          'quality.noUsableData' => '使用可能なデータがまだ見つかりません。',
          'quality.languages' => '言語',
          'quality.averageCoverage' => '平均カバレッジ',
          'quality.potentialIssues' => '潜在的な問題',
          'quality.translationCoverage' => '翻訳カバレッジ',
          'quality.entriesTranslated' => (
                  {required Object total, required Object translated}) =>
              '${total} 件中 ${translated} 件のエントリが翻訳済み',
          'quality.wordsAddedOverTime' => '追加された語数の推移',
          'quality.completionVsScope' => '完了率 vs スコープ',
          'quality.scopeVsProgress' => 'スコープ vs 進捗',
          'quality.coveragePercent' => 'カバレッジ %',
          'quality.wordsAdded' => '追加された語数',
          'quality.words' => '語',
          'quality.coverage' => 'カバレッジ',
          'quality.scope' => 'スコープ',
          'quality.latest' => '最新',
          'quality.added' => '追加済み',
          'quality.change' => '変更',
          'quality.totalScope' => '合計スコープ',
          'quality.wordsCount' => ({required Object count}) => '${count} 語',
          'quality.scopeGrowth' => 'スコープの増加',
          'quality.range' => '範囲',
          'quality.aiUsage' => 'AI と翻訳の使用状況',
          'quality.lastUsed' => ({required Object date}) => '最終使用日 ${date}',
          'quality.noIssuesFound' => '最新の比較で問題は見つかりませんでした。',
          'quality.placeholderMismatches' => 'プレースホルダーの不一致',
          'quality.placeholderMismatchesDesc' => '{name} のようなマーカーが一致しません。',
          'quality.lengthOutliers' => '極端に短い、または長い翻訳',
          'quality.lengthOutliersDesc' => 'ソースと比較して長さが不自然です。',
          'quality.duplicateValues' => '重複する値',
          'quality.duplicateValuesDesc' => '同じ翻訳が何度も使用されています。',
          'quality.placeholderDialogTitle' => 'プレースホルダーの不一致',
          'quality.placeholderDialogDesc' =>
            'これらの翻訳には、ソースと異なるプレースホルダー ({name}) が含まれています。',
          'quality.lengthDialogTitle' => '長さの異常値',
          'quality.lengthDialogDesc' => 'これらの翻訳は、ソースより大幅に短いか長くなっています。',
          'quality.duplicateDialogTitle' => '重複する値',
          'quality.duplicateDialogDesc' => 'これらの翻訳は複数回出現します。',
          'quality.duplicateSample' => ({required Object value}) =>
              '重複: "${value}"',
          'quality.exportError' => 'レポートを作成できませんでした。もう一度お試しください。',
          'quality.noDataToExport' => 'エクスポートするデータがありません',
          'quality.exportFailed' => 'エクスポート失敗',
          'quality.exportDialogTitle' => '品質レポートをエクスポート',
          'quality.reportSaved' => 'レポートを保存しました',
          'quality.export' => 'エクスポート',
          'quality.requests' => 'リクエスト',
          'quality.tokens' => 'トークン',
          'quality.characters' => '文字数',
          'quality.estCost' => '推定コスト',
          'quality.prompt' => 'プロンプト',
          'quality.completion' => '完了',
          'quality.showingCurrentProject' => '表示中: 現在のプロジェクト',
          'quality.showingAllHistory' => '表示中: すべての履歴',
          'quality.filesSkipped' => '一部のファイルが見つからなかったため、スキップされました。',
          'errors.genericError' => 'エラーが発生しました',
          'errors.fileNotFound' => 'ファイルが見つかりません',
          'errors.invalidFormat' => '無効なファイル形式',
          'errors.parseError' => 'ファイルの解析に失敗しました',
          'errors.networkError' => 'ネットワークエラー。接続を確認してください。',
          'errors.permissionDenied' => 'アクセス許可が拒否されました',
          'errors.unknownError' => '不明なエラーが発生しました',
          'wizards.firstRun.welcome' => 'Localizer へようこそ',
          'wizards.firstRun.description' => 'ローカリゼーションファイルを数秒で比較できます。',
          'wizards.firstRun.sourceFile' => 'ソースファイル',
          'wizards.firstRun.targetFile' => 'ターゲットファイル',
          'wizards.firstRun.compareNow' => '今すぐ比較',
          'wizards.firstRun.trySample' => 'サンプルデータで試す',
          'wizards.firstRun.skip' => '設定をスキップ',
          'wizards.firstRun.browse' => 'クリックして参照',
          'wizards.firstRun.error' => ({required Object error}) =>
              'サンプルデータの読み込みに失敗しました: ${error}',
          'dialogs.addIgnorePattern.title' => '無視パターンの追加',
          'dialogs.addIgnorePattern.patternLabel' => 'パターン (正規表現)',
          'dialogs.addIgnorePattern.hint' => '例: ^temp_.*',
          'dialogs.addIgnorePattern.invalid' => '無効な正規表現パターンです',
          'dialogs.addIgnorePattern.testStringLabel' => 'テスト文字列',
          'dialogs.addIgnorePattern.testHint' => 'パターンと照合するキーを入力',
          'dialogs.addIgnorePattern.match' => '✓ パターンがテスト文字列に一致します',
          'dialogs.addIgnorePattern.noMatch' => '✗ パターンが一致しません',
          'dialogs.addIgnorePattern.add' => '追加',
          'dialogs.addIgnorePattern.cancel' => 'キャンセル',
          'dialogs.diffViewer.title' => '差異ビューア',
          'dialogs.diffViewer.originalFile' => 'オリジナル/参照ファイル',
          'dialogs.diffViewer.translationFile' => '翻訳/比較ファイル',
          'dialogs.diffViewer.base' => 'ベース',
          'dialogs.diffViewer.target' => 'ターゲット',
          'dialogs.diffViewer.added' => '追加済み',
          'dialogs.diffViewer.removed' => '削除済み',
          'dialogs.diffViewer.modified' => '修正済み',
          'dialogs.diffViewer.noMatches' => '現在のフィルタに一致するエントリはありません',
          'dialogs.diffViewer.clickToggle' => '上のバッジをクリックしてフィルタを切り替えます',
          'dialogs.diffViewer.clickToHide' => '(クリックで非表示)',
          'dialogs.diffViewer.clickToShow' => '(クリックで表示)',
          'grid.columns.key' => 'キー',
          'grid.columns.source' => 'ソース',
          'grid.columns.status' => 'ステータス',
          'grid.columns.actions' => 'アクション',
          'tutorial.skipTutorial' => 'チュートリアルをスキップ',
          'tutorial.finishMessage' => '準備が整いました！どこかをタップして終了します。',
          'tutorial.next' => '次へ',
          'tutorial.loadSampleData' => 'サンプルデータを読み込む',
          'tutorial.browseSourceFile' => 'ソースファイルを参照',
          'tutorial.browseTargetFile' => 'ターゲットファイルを参照',
          'tutorial.compareFiles' => 'ファイルを比較',
          'tutorial.hintPhase2' => '次へ: フィルタ、検索、詳細ビュー、エクスポート。',
          'tutorial.steps.importSource.title' => '1. ソースファイルのインポート',
          'tutorial.steps.importSource.description' =>
            '下のボタンを使用してファイルを参照するか、ハイライトされた領域にドラッグ＆ドロップしてください。',
          'tutorial.steps.importTarget.title' => '2. ターゲットファイルのインポート',
          'tutorial.steps.importTarget.description' =>
            '下のボタンを使用してファイルを参照するか、ハイライトされた領域にドラッグ＆ドロップしてください。',
          'tutorial.steps.compare.title' => '3. ファイルを比較',
          'tutorial.steps.compare.description' => '下のボタンをタップして比較を実行し、結果を確認します。',
          'tutorial.steps.filter.title' => '4. 結果のフィルタリング',
          'tutorial.steps.filter.description' =>
            'これらのフィルタを使用して、追加、削除、または修正された文字列を表示します。',
          'tutorial.steps.search.title' => '5. 検索結果',
          'tutorial.steps.search.description' => '検索バーを使用して、特定のキーや値を検索します。',
          'tutorial.steps.advanced.title' => '6. 詳細ビュー',
          'tutorial.steps.advanced.description' =>
            '編集、AI 翻訳などを含む詳細な差異ビューを開きます。',
          'tutorial.steps.export.title' => '7. 結果のエクスポート',
          'tutorial.steps.export.description' =>
            '比較結果を CSV、JSON、または Excel ファイルとして保存します。',
          'friendlyErrors.fileNotFound.message' => 'ファイルまたはフォルダが見つかりませんでした。',
          'friendlyErrors.fileNotFound.suggestion' =>
            'ファイルが移動または削除されていないか確認してください。',
          'friendlyErrors.accessDenied.message' => 'ファイルへのアクセスが拒否されました。',
          'friendlyErrors.accessDenied.suggestion' =>
            'アプリを管理者として実行するか、ファイルのアクセス許可を確認してください。',
          'friendlyErrors.isDirectory.message' => 'ファイルの代わりにフォルダが選択されました。',
          'friendlyErrors.isDirectory.suggestion' => '有効なファイルを選択してください。',
          'friendlyErrors.fileAccess.message' => 'ファイルへのアクセス中に問題が発生しました。',
          'friendlyErrors.fileAccess.suggestion' =>
            'それを使用している可能性のある他のプログラムを閉じてみてください。',
          'friendlyErrors.unsupportedFormat.message' =>
            'このファイル形式または操作はサポートされていません。',
          'friendlyErrors.unsupportedFormat.suggestion' =>
            'ファイル拡張子を確認するか、別の形式を試してください。',
          'friendlyErrors.networkError.message' => 'サーバーに接続できませんでした。',
          'friendlyErrors.networkError.suggestion' =>
            'インターネット接続を確認して、もう一度お試しください。',
          'friendlyErrors.notGitRepo.message' => 'このフォルダは Git プロジェクトではありません。',
          'friendlyErrors.notGitRepo.suggestion' =>
            '.git ディレクトリを含むフォルダに移動してください。',
          'friendlyErrors.mergeConflict.message' => 'リポジトリにマージコンフリクトがあります。',
          'friendlyErrors.mergeConflict.suggestion' => '続行する前にコンフリクトを解決してください。',
          'friendlyErrors.gitAuthFailed.message' => 'Git の認証に失敗しました。',
          'friendlyErrors.gitAuthFailed.suggestion' =>
            '設定 > バージョン管理 で資格情報を確認してください。',
          'friendlyErrors.gitOperationFailed.message' => 'Git 操作に失敗しました。',
          'friendlyErrors.gitOperationFailed.suggestion' =>
            '詳細については Git ビューを確認してください。',
          'friendlyErrors.invalidJson.message' => 'ファイル形式が無効であるか、破損しています。',
          'friendlyErrors.invalidJson.suggestion' =>
            'ファイルに有効な JSON コンテンツが含まれていることを確認してください。',
          'friendlyErrors.rateLimitReached.message' => '翻訳制限に達しました。',
          'friendlyErrors.rateLimitReached.suggestion' =>
            '数分待つか、API プランの制限を確認してください。',
          'friendlyErrors.invalidApiKey.message' => '無効な API キーです。',
          'friendlyErrors.invalidApiKey.suggestion' =>
            '設定 > AI 翻訳 に移動して、API キーを更新してください。',
          'friendlyErrors.translationServiceError.message' =>
            '翻訳サービスエラーが発生しました。',
          'friendlyErrors.translationServiceError.suggestion' =>
            'API キーとインターネット接続を確認してください。',
          'friendlyErrors.outOfMemory.message' => 'この操作を完了するためのメモリが不足しています。',
          'friendlyErrors.outOfMemory.suggestion' =>
            '他のアプリケーションを閉じるか、より小さいファイルを使用してみてください。',
          'friendlyErrors.genericError.message' => '問題が発生しました。',
          'friendlyErrors.genericError.suggestion' =>
            'もう一度お試しください。問題が解決しない場合は、アプリを再起動してください。',
          'systemTray.showLocalizer' => 'Localizer を表示',
          'systemTray.exit' => '終了',
          'validation.connected' => '接続されました。',
          'validation.connectionTimeout' => '接続がタイムアウトしました。もう一度お試しください。',
          'validation.couldNotConnect' => '接続できませんでした。もう一度お試しください。',
          'validation.checkKeyAndTryAgain' => '接続できませんでした。キーを確認してもう一度お試しください。',
          'validation.tryAgainLater' => '現在接続できません。後でもう一度お試しください。',
          'validation.serviceUnavailable' => 'サービスは現在利用できません。後でもう一度お試しください。',
          'validation.enterKeyFirst' => 'まずキーを入力してください。',
          'validation.checking' => '確認中...',
          'validation.deeplUsage' => (
                  {required Object limit, required Object used}) =>
              '使用状況: ${limit} 文字中 ${used} 文字。',
          'status.startingComparison' => '比較を開始しています...',
          'status.loadingFromHistory' => '履歴からファイルを読み込んでいます...',
          'status.comparisonComplete' => '比較完了',
          'status.couldNotImportFiles' => 'ファイルをインポートできませんでした。もう一度お試しください。',
          'status.historyFilesNotFound' =>
            '履歴にあるファイルの一つ、または両方が元のパスに見つかりませんでした。',
          'aiServices.geminiEmptyResponse' => 'Gemini が空の応答を返しました',
          'aiServices.geminiStreamingEmpty' => 'Gemini ストリーミングが空の応答を返しました',
          'aiServices.geminiRephraseEmpty' => 'Gemini が言い換えに対して空の応答を返しました',
          'aiServices.openaiEmptyResponse' => 'OpenAI が空の応答または失敗の応答を返しました',
          _ => null,
        };
  }
}
