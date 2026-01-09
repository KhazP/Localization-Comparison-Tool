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
class TranslationsZhCn extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsZhCn(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.zhCn,
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

  /// Metadata for the translations of <zh-CN>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsZhCn _root = this; // ignore: unused_field

  @override
  TranslationsZhCn $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsZhCn(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsAppZhCn app = _TranslationsAppZhCn._(_root);
  @override
  late final _TranslationsCommonZhCn common = _TranslationsCommonZhCn._(_root);
  @override
  late final _TranslationsMenuZhCn menu = _TranslationsMenuZhCn._(_root);
  @override
  late final _TranslationsNavZhCn nav = _TranslationsNavZhCn._(_root);
  @override
  late final _TranslationsSettingsZhCn settings =
      _TranslationsSettingsZhCn._(_root);
  @override
  late final _TranslationsFileComparisonZhCn fileComparison =
      _TranslationsFileComparisonZhCn._(_root);
  @override
  late final _TranslationsDirectoryComparisonZhCn directoryComparison =
      _TranslationsDirectoryComparisonZhCn._(_root);
  @override
  late final _TranslationsGitComparisonZhCn gitComparison =
      _TranslationsGitComparisonZhCn._(_root);
  @override
  late final _TranslationsAdvancedComparisonZhCn advancedComparison =
      _TranslationsAdvancedComparisonZhCn._(_root);
  @override
  late final _TranslationsAdvancedDiffZhCn advancedDiff =
      _TranslationsAdvancedDiffZhCn._(_root);
  @override
  late final _TranslationsIssueDetailsZhCn issueDetails =
      _TranslationsIssueDetailsZhCn._(_root);
  @override
  late final _TranslationsImportReviewZhCn importReview =
      _TranslationsImportReviewZhCn._(_root);
  @override
  late final _TranslationsHistoryViewZhCn historyView =
      _TranslationsHistoryViewZhCn._(_root);
  @override
  late final _TranslationsCompareZhCn compare =
      _TranslationsCompareZhCn._(_root);
  @override
  late final _TranslationsHistoryZhCn history =
      _TranslationsHistoryZhCn._(_root);
  @override
  late final _TranslationsProjectsZhCn projects =
      _TranslationsProjectsZhCn._(_root);
  @override
  late final _TranslationsDiffZhCn diff = _TranslationsDiffZhCn._(_root);
  @override
  late final _TranslationsGitZhCn git = _TranslationsGitZhCn._(_root);
  @override
  late final _TranslationsQualityZhCn quality =
      _TranslationsQualityZhCn._(_root);
  @override
  late final _TranslationsErrorsZhCn errors = _TranslationsErrorsZhCn._(_root);
  @override
  late final _TranslationsWizardsZhCn wizards =
      _TranslationsWizardsZhCn._(_root);
  @override
  late final _TranslationsDialogsZhCn dialogs =
      _TranslationsDialogsZhCn._(_root);
  @override
  late final _TranslationsGridZhCn grid = _TranslationsGridZhCn._(_root);
  @override
  late final _TranslationsTutorialZhCn tutorial =
      _TranslationsTutorialZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsZhCn friendlyErrors =
      _TranslationsFriendlyErrorsZhCn._(_root);
  @override
  late final _TranslationsSystemTrayZhCn systemTray =
      _TranslationsSystemTrayZhCn._(_root);
  @override
  late final _TranslationsValidationZhCn validation =
      _TranslationsValidationZhCn._(_root);
  @override
  late final _TranslationsStatusZhCn status = _TranslationsStatusZhCn._(_root);
  @override
  late final _TranslationsAiServicesZhCn aiServices =
      _TranslationsAiServicesZhCn._(_root);
}

// Path: app
class _TranslationsAppZhCn extends TranslationsAppEn {
  _TranslationsAppZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '本地化对比工具';
  @override
  String get name => 'Localizer';
}

// Path: common
class _TranslationsCommonZhCn extends TranslationsCommonEn {
  _TranslationsCommonZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get save => '保存';
  @override
  String get cancel => '取消';
  @override
  String get close => '关闭';
  @override
  String get delete => '删除';
  @override
  String get edit => '编辑';
  @override
  String get add => '添加';
  @override
  String get search => '搜索';
  @override
  String get undo => '撤销';
  @override
  String get loading => '加载中...';
  @override
  String get error => '错误';
  @override
  String get success => '成功';
  @override
  String get warning => '警告';
  @override
  String get info => '信息';
  @override
  String get confirm => '确认';
  @override
  String get yes => '是';
  @override
  String get no => '否';
  @override
  String get ok => '确定';
  @override
  String get retry => '重试';
  @override
  String get copyText => '复制';
  @override
  String get appName => 'Localizer';
  @override
  String get copied => '已复制!';
  @override
  String get enabled => '已启用';
  @override
  String get disabled => '已禁用';
  @override
  String get browse => '浏览';
  @override
  String get clear => '清除';
  @override
  String get apply => '应用';
  @override
  String get reset => '重置';
  @override
  String get refresh => '刷新';
  @override
  String get export => '导出';
  @override
  String get import => '导入';
  @override
  String get select => '选择';
  @override
  String get selectAll => '全选';
  @override
  String get deselectAll => '取消全选';
  @override
  String get noResults => '未找到结果';
  @override
  String get emptyState => '暂无内容';
  @override
  String get open => '打开';
  @override
  String get change => '更改';
  @override
  String get original => '原始';
  @override
  String get kNew => '新';
  @override
  String get remove => '移除';
  @override
  String get auto => '自动';
  @override
  String get execute => '执行';
  @override
  String get run => '运行';
  @override
  String get unknown => '未知';
  @override
  String get download => '下载';
  @override
  String get dropdownArrow => '下拉箭头';
  @override
  String get openInNewWindow => '在新窗口中打开';
  @override
  String get resetToDefaults => '恢复默认设置';
}

// Path: menu
class _TranslationsMenuZhCn extends TranslationsMenuEn {
  _TranslationsMenuZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get file => '文件';
  @override
  String get edit => '编辑';
  @override
  String get view => '视图';
  @override
  String get help => '帮助';
  @override
  String get openFiles => '打开文件...';
  @override
  String get openFolder => '打开文件夹...';
  @override
  String get exportResults => '导出结果...';
  @override
  String get undo => '撤销';
  @override
  String get redo => '重做';
  @override
  String get cut => '剪切';
  @override
  String get paste => '粘贴';
  @override
  String get selectAll => '全选';
  @override
  String get zoomIn => '放大';
  @override
  String get zoomOut => '缩小';
  @override
  String get resetZoom => '重置缩放';
  @override
  String get documentation => '文档';
  @override
  String get reportIssue => '报告问题';
  @override
  String about({required Object appName}) => '关于 ${appName}';
}

// Path: nav
class _TranslationsNavZhCn extends TranslationsNavEn {
  _TranslationsNavZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get compare => '比较';
  @override
  String get history => '历史';
  @override
  String get settings => '设置';
  @override
  String get projects => '项目';
  @override
  String get dashboard => '仪表盘';
  @override
  String get directory => '目录';
  @override
  String get repository => '仓库';
  @override
  String get tooltipCompare => '比较本地化文件';
  @override
  String get tooltipHistory => '查看比较历史';
  @override
  String get tooltipSettings => '应用设置';
  @override
  String get tooltipProjects => '管理项目';
  @override
  String get tooltipThemeToggle => '切换主题';
  @override
  String get tooltipDebugConsole => '调试控制台';
}

// Path: settings
class _TranslationsSettingsZhCn extends TranslationsSettingsEn {
  _TranslationsSettingsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '设置';
  @override
  String get appSettings => '应用设置';
  @override
  String get projectSettings => '项目设置';
  @override
  late final _TranslationsSettingsAppearanceZhCn appearance =
      _TranslationsSettingsAppearanceZhCn._(_root);
  @override
  late final _TranslationsSettingsGeneralZhCn general =
      _TranslationsSettingsGeneralZhCn._(_root);
  @override
  late final _TranslationsSettingsScopeZhCn scope =
      _TranslationsSettingsScopeZhCn._(_root);
  @override
  late final _TranslationsSettingsSearchKeywordsZhCn searchKeywords =
      _TranslationsSettingsSearchKeywordsZhCn._(_root);
  @override
  late final _TranslationsSettingsComparisonZhCn comparison =
      _TranslationsSettingsComparisonZhCn._(_root);
  @override
  late final _TranslationsSettingsFileHandlingZhCn fileHandling =
      _TranslationsSettingsFileHandlingZhCn._(_root);
  @override
  late final _TranslationsSettingsTranslationMemoryZhCn translationMemory =
      _TranslationsSettingsTranslationMemoryZhCn._(_root);
  @override
  late final _TranslationsSettingsBackupZhCn backup =
      _TranslationsSettingsBackupZhCn._(_root);
  @override
  late final _TranslationsSettingsAiZhCn ai =
      _TranslationsSettingsAiZhCn._(_root);
  @override
  late final _TranslationsSettingsIntegrationsZhCn integrations =
      _TranslationsSettingsIntegrationsZhCn._(_root);
  @override
  late final _TranslationsSettingsDeveloperZhCn developer =
      _TranslationsSettingsDeveloperZhCn._(_root);
  @override
  late final _TranslationsSettingsAboutZhCn about =
      _TranslationsSettingsAboutZhCn._(_root);
  @override
  late final _TranslationsSettingsOnboardingZhCn onboarding =
      _TranslationsSettingsOnboardingZhCn._(_root);
  @override
  late final _TranslationsSettingsSettingsViewZhCn settingsView =
      _TranslationsSettingsSettingsViewZhCn._(_root);
}

// Path: fileComparison
class _TranslationsFileComparisonZhCn extends TranslationsFileComparisonEn {
  _TranslationsFileComparisonZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '文件对比';
  @override
  String get openFiles => '打开文件';
  @override
  String get exportResults => '导出结果';
  @override
  String get restartTutorial => '重启教程';
  @override
  String get restartTutorialDevOnly => '重启教程仅在开发者模式下可用。';
  @override
  String get unsupportedFileType => '不支持的文件类型。';
  @override
  String get unsupportedFileTypeSuggestion => '请选择支持的本地化文件。';
  @override
  String get someFilesUnsupported => '部分文件不支持。';
  @override
  String get pickSupportedFiles => '仅选择支持的本地化文件。';
  @override
  String get pickTwoFiles => '选择两个文件进行对比。';
  @override
  String get pickBilingualFile => '请选择一个双语文件进行对比。';
  @override
  String get noResultsToExport => '暂无结果可导出。';
  @override
  String get performComparisonFirst => '请先执行对比以导出结果。';
  @override
  String get performComparisonFirstEditor => '请先执行对比以查看高级详细信息。';
  @override
  String get sampleDataLoaded => '示例数据加载成功';
  @override
  String loadSampleDataError({required Object error}) => '加载示例数据失败：${error}';
  @override
  String get invalidFileType => '无效的文件类型。';
  @override
  String fileSelected({required Object label, required Object fileName}) =>
      '已选择 ${label}：${fileName}';
  @override
  String get sourceFile => '源文件';
  @override
  String get targetFile => '目标文件';
  @override
  String get bilingualFile => '双语文件';
  @override
  String get compareFiles => '比较文件';
  @override
  String get compareFile => '比较文件';
  @override
  String get bilingualMode => '双语模式';
  @override
  String get twoFilesMode => '双文件';
  @override
  String get processing => '处理中...';
  @override
  String remaining({required Object time}) => '剩余 ${time}';
  @override
  String get comparisonInProgress => '对比进行中...';
  @override
  String comparisonFailed({required Object error}) => '对比失败：${error}';
  @override
  String fileChanged({required Object fileName}) =>
      '文件已更改：${fileName}。正在重新对比...';
  @override
  String get dropFileHere => '拖放文件到此处';
  @override
  String get dropFileOrBrowse => '拖放文件或点击浏览';
  @override
  String get fileUpload => '上传文件';
  @override
  String get changeFile => '更改文件';
  @override
  String get total => '总计';
  @override
  String get show => '显示';
  @override
  String get showAll => '显示全部';
  @override
  String noMatches({required Object query}) => '未找到 "${query}" 的匹配项';
  @override
  String showingEntries({required Object count, required Object total}) =>
      '显示 ${count} / ${total} 条目';
  @override
  String get filesIdentical => '文件完全相同。';
  @override
  String hiddenIdentical({required Object count}) => '隐藏了 ${count} 个相同条目';
  @override
  String get showIdentical => '显示相同条目';
  @override
  String get hideIdentical => '隐藏相同条目';
  @override
  String get noDiff => '基于键未发现差异。';
  @override
  String get source => '源';
  @override
  String get target => '目标';
  @override
  String get value => '值';
  @override
  String get readyToCompare => '准备对比文件';
  @override
  String get readyToCompareDesc => '将本地化文件拖放到上方或使用浏览按钮\n选择文件进行对比。';
  @override
  String get recentComparisons => '最近的对比';
  @override
  String bilingualFileLabel({required Object name}) => '双语文件：${name}';
  @override
  String comparisonLabel({required Object source, required Object target}) =>
      '${source} ↔ ${target}';
  @override
  String get fileNotExist => '此会话中的一个或两个文件不再存在。';
  @override
  String get largeFileTitle => '检测到大文件';
  @override
  String largeFileContent({required Object count}) =>
      '对比结果包含 ${count} 个条目。\n显示所有条目可能会导致性能问题。\n\n是否继续？';
  @override
  String get dontShowAgain => '此文件不再显示';
  @override
  String get proceed => '继续';
  @override
  String exportReport({required Object format}) => '保存 ${format} 报告';
  @override
  String saved({required Object format}) => '${format} 已保存';
  @override
  String saveError({required Object format}) => '保存 ${format} 文件失败。';
  @override
  String saveErrorDetailed({required Object format, required Object error}) =>
      '保存 ${format} 失败：${error}';
  @override
  String get watching => '正在监视';
  @override
  String get watchOff => '监视关闭';
  @override
  String watchingTooltip({required Object status}) =>
      '文件监视：${status}\n当磁盘上的文件更改时自动重新对比';
  @override
  String get aiSettingsNotAvailable => 'AI 设置导航不可用';
}

// Path: directoryComparison
class _TranslationsDirectoryComparisonZhCn
    extends TranslationsDirectoryComparisonEn {
  _TranslationsDirectoryComparisonZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '目录对比';
  @override
  String get sourceDirectory => '源目录';
  @override
  String get targetDirectory => '目标目录';
  @override
  String get sourceSubtitle => '原始/参考文件';
  @override
  String get targetSubtitle => '翻译/对比文件';
  @override
  String get selectBothDirectories => '请同时选择源目录和目标目录。';
  @override
  String get selectSourceFolder => '选择源文件夹';
  @override
  String get selectTargetFolder => '选择目标文件夹';
  @override
  String get dropFolderHere => '拖放文件夹到此处或浏览...';
  @override
  String get folderPath => '文件夹路径';
  @override
  String get readyToCompare => '准备对比目录';
  @override
  String get readyToCompareDesc => '拖放文件夹到上方或使用浏览按钮\n选择目录进行对比。';
  @override
  String get nestedFolders => '嵌套文件夹';
  @override
  String get nestedFoldersTooltip => '递归对比所有嵌套目录';
  @override
  String get fileMatching => '文件匹配';
  @override
  String get fileMatchingTooltip => '按名称自动配对文件';
  @override
  String get bulkExport => '批量导出';
  @override
  String get bulkExportTooltip => '一次性导出所有对比结果';
  @override
  String get notDirectoryComparison => '这不是目录对比。';
  @override
  String get directoriesNotExist => '一个或两个目录不再存在。';
  @override
  String get errorOccurred => '发生错误';
  @override
  String get noFilesFound => '在所选目录中未找到文件。';
  @override
  String get unmatchedSourceFiles => '未匹配的源文件';
  @override
  String get unmatchedTargetFiles => '未匹配的目标文件';
  @override
  String filePairs({required Object count}) => '${count} 对文件';
  @override
  String pairedFiles({required Object count}) => '已配对文件 (${count})';
  @override
  String get view => '查看';
  @override
  String get failed => '失败';
  @override
  String get pair => '配对...';
  @override
  String pairDialogTitle({required Object name}) => '将 "${name}" 配对与：';
  @override
  String get discoverFiles => '发现文件';
  @override
  String get compareAll => '对比全部';
  @override
  String get exportAll => '导出全部';
  @override
  String get comparisonStarted => '对比已开始...';
  @override
  String get discoveringFiles => '正在发现文件...';
  @override
  String get noResultsToExport => '没有对比结果可导出。请先运行 "对比全部"。';
  @override
  String get selectExportFolder => '选择导出文件夹';
  @override
  String createExportFolderError({required Object error}) =>
      '创建导出文件夹失败：${error}';
  @override
  String get exportingResults => '正在导出结果';
  @override
  String processingFile({required Object file}) => '正在处理：${file}';
  @override
  String exportProgress({required Object current, required Object total}) =>
      '已导出 ${current} / ${total} 个文件';
  @override
  String get exportComplete => '导出完成';
  @override
  String exportSuccessMessage({required Object count}) =>
      '成功导出 ${count} 个对比文件及摘要。';
  @override
  String exportFailed({required Object error}) => '导出失败：${error}';
  @override
  String get close => '关闭';
}

// Path: gitComparison
class _TranslationsGitComparisonZhCn extends TranslationsGitComparisonEn {
  _TranslationsGitComparisonZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.';
  @override
  String get title => '仓库对比';
  @override
  String get repoSelector => '创建 / 打开仓库';
  @override
  String get noRepoSelected => '未选择仓库';
  @override
  String get open => '打开';
  @override
  String get refreshCommits => '刷新提交';
  @override
  String get noCommits => '未找到或未加载提交。请选择一个分支以加载提交。';
  @override
  String get baseCommit => '基础提交 (旧)';
  @override
  String get targetCommit => '目标提交 (新)';
  @override
  String get filterCommitsByBranch => '按分支过滤提交';
  @override
  String get conflictDetection => '冲突检测';
  @override
  String get conflictDetectionTooltip => '检测并解决合并冲突';
  @override
  String get actions => '操作：';
  @override
  String get checkout => 'Checkout';
  @override
  String get merge => 'Merge';
  @override
  String get pull => 'Pull';
  @override
  String get checkoutBranch => 'Checkout 分支';
  @override
  String get mergeBranch => 'Merge 分支到当前';
  @override
  String mergeConfirmation({required Object branch}) => 'Merge ${branch}？';
  @override
  String get mergeWarning => '这将合并更改到您当前的工作分支。可能会发生冲突。';
  @override
  String get selectExportFolder => '选择导出文件夹';
  @override
  String createExportFolderError({required Object error}) =>
      '创建导出文件夹失败：${error}';
  @override
  String get exportingFiles => '正在导出文件';
  @override
  String processingFile({required Object file}) => '正在处理：${file}';
  @override
  String exportProgress({required Object current, required Object total}) =>
      '已导出 ${current} / ${total} 个文件';
  @override
  String get exportComplete => '导出完成';
  @override
  String exportSuccessMessage({required Object count}) =>
      '成功导出 ${count} 个文件及完整内容。';
  @override
  String get exportDetail => '每个文件的差异保存在 "files" 子文件夹中。';
  @override
  String get diffViewer => '差异查看器';
  @override
  String get base => 'BASE';
  @override
  String get target => 'TARGET';
  @override
  String get noLines => '没有要显示的行';
  @override
  String get searchFiles => '搜索文件...';
  @override
  String noFilesMatch({required Object query}) => '没有文件匹配 "${query}"';
  @override
  String filesCount({required Object count}) => '${count} 个文件';
  @override
  String get selectBaseFile => '选择基础文件';
  @override
  String get selectTargetFile => '选择目标文件';
  @override
  String get comparisonResults => '对比结果';
  @override
  String get noChanges => '所选引用之间未发现更改。';
  @override
  String get linesAdded => '新增行数';
  @override
  String get linesRemoved => '移除行数';
  @override
  String get commit => 'Commit';
  @override
  String get branch => 'Branch';
  @override
  String get noRepositorySelected => '未选择仓库';
  @override
  String get notGitComparison => '不是 Git 对比';
  @override
  String get repositoryNotExist => '仓库不存在';
  @override
  String get mainBranch => 'main';
  @override
  String get masterBranch => 'master';
  @override
  String get backToControls => '返回对比控制';
}

// Path: advancedComparison
class _TranslationsAdvancedComparisonZhCn
    extends TranslationsAdvancedComparisonEn {
  _TranslationsAdvancedComparisonZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get placeholder => '高级对比视图 - 占位符';
}

// Path: advancedDiff
class _TranslationsAdvancedDiffZhCn extends TranslationsAdvancedDiffEn {
  _TranslationsAdvancedDiffZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get saveAllChanges => '保存所有更改？';
  @override
  String saveConfirmation({required Object count}) =>
      '这将保存 ${count} 个修改条目到目标文件。此操作无法撤销。';
  @override
  String get changesSaved => '更改保存成功。';
  @override
  String get csvExported => 'CSV 已导出';
  @override
  String get unsavedChanges => '未保存的更改';
  @override
  String get unsavedChangesWarning => '您有未保存的更改。确定要放弃它们吗？';
  @override
  String get discardChanges => '放弃更改';
  @override
  String get goBack => '返回';
  @override
  String get breadcrumbs => '首页 > 编辑器';
  @override
  String unsaved({required Object count}) => '${count} 未保存';
  @override
  String reviewed({required Object count}) => '${count} 已审核';
  @override
  String saveAll({required Object count}) => '保存全部 (${count})';
  @override
  String get allSaved => '全部已保存';
  @override
  String get saveAllTooltip => '保存所有更改 (Ctrl+S)';
  @override
  String get exportTooltip => '导出数据 (Ctrl+E)';
  @override
  late final _TranslationsAdvancedDiffAiSuggestionZhCn aiSuggestion =
      _TranslationsAdvancedDiffAiSuggestionZhCn._(_root);
  @override
  late final _TranslationsAdvancedDiffDetailEditZhCn detailEdit =
      _TranslationsAdvancedDiffDetailEditZhCn._(_root);
  @override
  late final _TranslationsAdvancedDiffTableZhCn table =
      _TranslationsAdvancedDiffTableZhCn._(_root);
  @override
  late final _TranslationsAdvancedDiffDiffRowZhCn diffRow =
      _TranslationsAdvancedDiffDiffRowZhCn._(_root);
  @override
  late final _TranslationsAdvancedDiffStatusZhCn status =
      _TranslationsAdvancedDiffStatusZhCn._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarZhCn sidebar =
      _TranslationsAdvancedDiffSidebarZhCn._(_root);
}

// Path: issueDetails
class _TranslationsIssueDetailsZhCn extends TranslationsIssueDetailsEn {
  _TranslationsIssueDetailsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '问题详情';
  @override
  String showingIssues({required Object count, required Object total}) =>
      '显示 ${count} / ${total} 个问题';
  @override
  String get searchPlaceholder => '通过键、文本或错误搜索...';
  @override
  String get noDetails => '没有可用详情。';
  @override
  String get noMatches => '未找到匹配项。';
  @override
  String get showMore => '显示更多';
  @override
  String copyItems({required Object count}) => '复制 ${count} 个项目';
  @override
  String get close => '关闭';
  @override
  String get copied => '已复制到剪贴板';
  @override
  String copiedCount({required Object count}) => '已复制 ${count} 个项目';
  @override
  late final _TranslationsIssueDetailsDuplicateValueZhCn duplicateValue =
      _TranslationsIssueDetailsDuplicateValueZhCn._(_root);
  @override
  late final _TranslationsIssueDetailsLengthOutlierZhCn lengthOutlier =
      _TranslationsIssueDetailsLengthOutlierZhCn._(_root);
  @override
  late final _TranslationsIssueDetailsStandardZhCn standard =
      _TranslationsIssueDetailsStandardZhCn._(_root);
  @override
  String get review => '审查';
  @override
  late final _TranslationsIssueDetailsTypesZhCn types =
      _TranslationsIssueDetailsTypesZhCn._(_root);
  @override
  late final _TranslationsIssueDetailsNotesZhCn notes =
      _TranslationsIssueDetailsNotesZhCn._(_root);
  @override
  late final _TranslationsIssueDetailsFallbacksZhCn fallbacks =
      _TranslationsIssueDetailsFallbacksZhCn._(_root);
}

// Path: importReview
class _TranslationsImportReviewZhCn extends TranslationsImportReviewEn {
  _TranslationsImportReviewZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '审查项目导入';
  @override
  String get projectName => '项目名称';
  @override
  String get created => '创建时间';
  @override
  String get historyItems => '历史项目';
  @override
  String get customSettingsTitle => '检测到自定义设置';
  @override
  String get customSettingsWarning => '此项目包含自定义设置，将在项目打开时覆盖您的默认设置。';
  @override
  String get standardSettings => '此项目使用标准全局设置。';
  @override
  String get cancelImport => '取消导入';
  @override
  String get trustOpen => '信任并打开项目';
}

// Path: historyView
class _TranslationsHistoryViewZhCn extends TranslationsHistoryViewEn {
  _TranslationsHistoryViewZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '对比历史';
  @override
  String get clearAll => '清除所有历史';
  @override
  String get searchPlaceholder => '按文件名搜索...';
  @override
  String get sortBy => '排序方式';
  @override
  String get sortDate => '日期';
  @override
  String get sortSource => '源文件';
  @override
  String get sortTarget => '目标文件';
  @override
  String get showCurrentProject => '显示：当前项目';
  @override
  String get showAllHistory => '显示：所有历史';
  @override
  String get groupByFolder => '按文件夹分组';
  @override
  String get disableGrouping => '禁用文件夹分组';
  @override
  String get filterAll => '全部';
  @override
  String get filterFiles => '文件';
  @override
  String get filterDirectories => '目录';
  @override
  String get filterGit => 'Git';
  @override
  String get noHistory => '暂无对比历史';
  @override
  String get historyDescription => '您的文件对比将显示在这里';
  @override
  String get noResults => '未找到结果';
  @override
  String get adjustSearch => '尝试调整您的搜索';
  @override
  String get clearConfirmationTitle => '清除所有历史？';
  @override
  String get clearConfirmationContent => '这将永久删除所有对比历史。此操作无法撤销。';
  @override
  String get clearAction => '清除全部';
  @override
  String get deletedMessage => '历史项目已删除';
  @override
  String get undo => '撤销';
  @override
  String get viewDetails => '查看详情';
  @override
  String get delete => '删除';
  @override
  String get openLocation => '打开文件位置';
  @override
  String get bilingual => '双语';
  @override
  String get filePair => '文件对';
  @override
  String get directory => '目录';
  @override
  String get git => 'Git';
  @override
  String get repo => '仓库';
  @override
  String get sourceDir => '源目录';
  @override
  String get targetDir => '目标目录';
  @override
  String get source => '源';
  @override
  String get target => '目标';
  @override
  String get noChanges => '未检测到更改';
  @override
  String get added => '新增';
  @override
  String get removed => '移除';
  @override
  String get modified => '修改';
  @override
  String get same => '相同';
  @override
  String get total => '总计';
  @override
  String get currentProject => '当前项目';
  @override
  String get unassigned => '未分配';
  @override
  String get project => '项目';
}

// Path: compare
class _TranslationsCompareZhCn extends TranslationsCompareEn {
  _TranslationsCompareZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '对比文件';
  @override
  String get sourceFile => '源文件';
  @override
  String get targetFile => '目标文件';
  @override
  String get sourceFolder => '源文件夹';
  @override
  String get targetFolder => '目标文件夹';
  @override
  String get dropFilesHint => '将本地化文件拖放到此处或使用浏览按钮选择文件进行对比。';
  @override
  String get selectSourceFile => '选择源文件';
  @override
  String get selectTargetFile => '选择目标文件';
  @override
  String get startComparison => '开始对比';
  @override
  String get comparing => '对比中...';
  @override
  String get comparisonComplete => '对比完成';
  @override
  String get noChanges => '未检测到更改';
  @override
  String get filesIdentical => '文件完全相同';
  @override
  String changesFound({required Object count}) => '发现 ${count} 处更改';
  @override
  late final _TranslationsCompareTabsZhCn tabs =
      _TranslationsCompareTabsZhCn._(_root);
  @override
  late final _TranslationsCompareFileTypesZhCn fileTypes =
      _TranslationsCompareFileTypesZhCn._(_root);
}

// Path: history
class _TranslationsHistoryZhCn extends TranslationsHistoryEn {
  _TranslationsHistoryZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '历史';
  @override
  String get recentComparisons => '最近的对比';
  @override
  String get noHistory => '暂无对比历史';
  @override
  String get noHistoryDescription => '您的对比历史将显示在这里';
  @override
  String get clearHistory => '清除历史';
  @override
  String get clearHistoryConfirm => '您确定要清除所有历史吗？';
  @override
  String get deleteEntry => '删除条目';
  @override
  String get openComparison => '打开对比';
  @override
  late final _TranslationsHistoryTimeAgoZhCn timeAgo =
      _TranslationsHistoryTimeAgoZhCn._(_root);
}

// Path: projects
class _TranslationsProjectsZhCn extends TranslationsProjectsEn {
  _TranslationsProjectsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '项目';
  @override
  String get createProject => '创建项目';
  @override
  String get importProject => '导入项目';
  @override
  String get noProjects => '暂无项目';
  @override
  String get noProjectsDescription => '创建一个项目以组织您的本地化文件';
  @override
  String get projectName => '项目名称';
  @override
  String get projectPath => '项目路径';
  @override
  String get lastOpened => '上次打开';
  @override
  String get openProject => '打开项目';
  @override
  String get closeProject => '关闭项目';
  @override
  String get deleteProject => '删除项目';
  @override
  String get deleteProjectConfirm => '您确定要删除此项目吗？';
  @override
  String get exportProject => '导出项目';
  @override
  String get exportDescription => '创建一个包含源文件、配置和历史记录的便携式压缩包。';
  @override
  String get exporting => '正在导出项目...';
  @override
  String get exportSuccess => '项目已导出';
  @override
  String exportError({required Object error}) => '导出失败：${error}';
  @override
  String get createNewProject => '创建新项目';
  @override
  String get openExistingProject => '打开现有项目';
  @override
  String get importProjectZip => '导入项目压缩包';
  @override
  String get projectResources => '项目资源';
  @override
  String get recentProjects => '最近的项目';
  @override
  String get noRecentProjects => '没有最近的项目';
  @override
  String get selectProjectZip => '选择项目压缩包';
  @override
  String get selectDestination => '选择导入目标文件夹';
  @override
  String get importing => '正在导入项目...';
  @override
  String get importSuccess => '项目导入成功';
  @override
  String importFailed({required Object error}) => '导入失败：${error}';
  @override
  String get importingFiles => '正在导入文件...';
  @override
  String get noSupportedFiles => '未拖入支持的文件。';
  @override
  late final _TranslationsProjectsStatsZhCn stats =
      _TranslationsProjectsStatsZhCn._(_root);
  @override
  String get openProjectFirst => '请先打开一个项目以管理其资源。';
  @override
  String get removeFromRecent => '从最近记录中移除';
  @override
  late final _TranslationsProjectsSelectionZhCn selection =
      _TranslationsProjectsSelectionZhCn._(_root);
  @override
  late final _TranslationsProjectsCreateDialogZhCn createDialog =
      _TranslationsProjectsCreateDialogZhCn._(_root);
  @override
  late final _TranslationsProjectsIndicatorZhCn indicator =
      _TranslationsProjectsIndicatorZhCn._(_root);
  @override
  late final _TranslationsProjectsGlossaryZhCn glossary =
      _TranslationsProjectsGlossaryZhCn._(_root);
  @override
  late final _TranslationsProjectsConflictsZhCn conflicts =
      _TranslationsProjectsConflictsZhCn._(_root);
  @override
  late final _TranslationsProjectsTmZhCn tm =
      _TranslationsProjectsTmZhCn._(_root);
}

// Path: diff
class _TranslationsDiffZhCn extends TranslationsDiffEn {
  _TranslationsDiffZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get added => '新增';
  @override
  String get removed => '移除';
  @override
  String get modified => '修改';
  @override
  String get unchanged => '未更改';
  @override
  String get missing => '缺失';
  @override
  String get extra => '额外';
  @override
  String get sourceValue => '源值';
  @override
  String get targetValue => '目标值';
  @override
  String get key => '键';
  @override
  String get status => '状态';
  @override
  String get actions => '操作';
  @override
  String get copyToTarget => '复制到目标';
  @override
  String get acceptChange => '接受更改';
  @override
  String get rejectChange => '拒绝更改';
  @override
  String get viewDetails => '查看详情';
}

// Path: git
class _TranslationsGitZhCn extends TranslationsGitEn {
  _TranslationsGitZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Git 对比';
  @override
  String get selectRepository => '选择仓库';
  @override
  String get selectBranch => '选择分支';
  @override
  String get selectCommit => '选择提交';
  @override
  String get compareBranches => '对比分支';
  @override
  String get compareCommits => '对比提交';
  @override
  String get baseBranch => '基础分支';
  @override
  String get compareBranch => '对比分支';
  @override
  String get noRepositories => '未找到 Git 仓库';
  @override
  String get noRepositoriesDescription => '打开包含 Git 仓库的文件夹';
  @override
  String filesChanged({required Object count}) => '${count} 个文件已更改';
  @override
  String additions({required Object count}) => '${count} 处新增';
  @override
  String deletions({required Object count}) => '${count} 处删除';
  @override
  late final _TranslationsGitConflictsZhCn conflicts =
      _TranslationsGitConflictsZhCn._(_root);
}

// Path: quality
class _TranslationsQualityZhCn extends TranslationsQualityEn {
  _TranslationsQualityZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.';
  @override
  String get title => '质量仪表盘';
  @override
  String get overallScore => '总体评分';
  @override
  String get issues => '问题';
  @override
  String get warnings => '警告';
  @override
  String get suggestions => '建议';
  @override
  String get placeholderMismatch => '占位符不匹配';
  @override
  String get placeholderMismatchDescription => '占位符如 {name} 在源和目标之间不匹配';
  @override
  String get lengthOutlier => '长度异常';
  @override
  String get lengthOutlierDescription => '翻译长度与源文本差异显著';
  @override
  String get duplicateValue => '重复值';
  @override
  String get duplicateValueDescription => '多个键使用相同的翻译';
  @override
  String get missingTranslation => '缺失翻译';
  @override
  String get missingTranslationDescription => '此键缺少翻译';
  @override
  String get loading => '正在加载仪表盘...';
  @override
  String get errorLoading => '无法加载您的历史记录。请重试。';
  @override
  String get emptyState => '运行对比以查看您的仪表盘。';
  @override
  String get refresh => '刷新';
  @override
  String get buildingInsights => '正在构建洞察...';
  @override
  String get crunchingNumbers => '正在处理数据...';
  @override
  String get errorBuilding => '无法构建仪表盘。请重试。';
  @override
  String get noUsableData => '尚未找到可用数据。';
  @override
  String get languages => '语言';
  @override
  String get averageCoverage => '平均覆盖率';
  @override
  String get potentialIssues => '潜在问题';
  @override
  String get translationCoverage => '翻译覆盖率';
  @override
  String entriesTranslated(
          {required Object total, required Object translated}) =>
      '${total} 个条目中已翻译 ${translated} 个';
  @override
  String get wordsAddedOverTime => '随时间新增词数';
  @override
  String get completionVsScope => '完成度 vs 范围';
  @override
  String get scopeVsProgress => '范围 vs 进度';
  @override
  String get coveragePercent => '覆盖率 %';
  @override
  String get wordsAdded => '新增词数';
  @override
  String get words => '词数';
  @override
  String get coverage => '覆盖率';
  @override
  String get scope => '范围';
  @override
  String get latest => '最新';
  @override
  String get added => '新增';
  @override
  String get change => '变化';
  @override
  String get totalScope => '总范围';
  @override
  String wordsCount({required Object count}) => '${count} 字';
  @override
  String get scopeGrowth => '范围增长';
  @override
  String get range => '范围';
  @override
  String get aiUsage => 'AI 与翻译使用情况';
  @override
  String lastUsed({required Object date}) => '上次使用 ${date}';
  @override
  String get noIssuesFound => '在最近的对比中未发现问题。';
  @override
  String get placeholderMismatches => '占位符不匹配';
  @override
  String get placeholderMismatchesDesc => '标记如 {name} 不匹配。';
  @override
  String get lengthOutliers => '过短或过长的翻译';
  @override
  String get lengthOutliersDesc => '长度与源文本相比看起来不正常。';
  @override
  String get duplicateValues => '重复值';
  @override
  String get duplicateValuesDesc => '相同的翻译被多次使用。';
  @override
  String get placeholderDialogTitle => '占位符不匹配';
  @override
  String get placeholderDialogDesc => '这些翻译的占位符 ({name}) 与源文本不同。';
  @override
  String get lengthDialogTitle => '长度异常';
  @override
  String get lengthDialogDesc => '这些翻译比源文本显著更短或更长。';
  @override
  String get duplicateDialogTitle => '重复值';
  @override
  String get duplicateDialogDesc => '这些翻译多次出现。';
  @override
  String duplicateSample({required Object value}) => '重复："${value}"';
  @override
  String get exportError => '无法构建报告。请重试。';
  @override
  String get noDataToExport => '没有数据可导出';
  @override
  String get exportFailed => '导出失败';
  @override
  String get exportDialogTitle => '导出质量报告';
  @override
  String get reportSaved => '报告已保存';
  @override
  String get export => '导出';
  @override
  String get requests => 'Requests';
  @override
  String get tokens => 'Tokens';
  @override
  String get characters => 'Characters';
  @override
  String get estCost => '预估成本';
  @override
  String get prompt => 'Prompt';
  @override
  String get completion => 'Completion';
  @override
  String get showingCurrentProject => '显示：当前项目';
  @override
  String get showingAllHistory => '显示：所有历史';
  @override
  String get filesSkipped => '部分文件因未找到而被跳过。';
}

// Path: errors
class _TranslationsErrorsZhCn extends TranslationsErrorsEn {
  _TranslationsErrorsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get genericError => '发生错误';
  @override
  String get fileNotFound => '文件未找到';
  @override
  String get invalidFormat => '无效的文件格式';
  @override
  String get parseError => '解析文件失败';
  @override
  String get networkError => '网络错误。请检查您的连接。';
  @override
  String get permissionDenied => '权限被拒绝';
  @override
  String get unknownError => '发生未知错误';
}

// Path: wizards
class _TranslationsWizardsZhCn extends TranslationsWizardsEn {
  _TranslationsWizardsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsWizardsFirstRunZhCn firstRun =
      _TranslationsWizardsFirstRunZhCn._(_root);
}

// Path: dialogs
class _TranslationsDialogsZhCn extends TranslationsDialogsEn {
  _TranslationsDialogsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDialogsAddIgnorePatternZhCn addIgnorePattern =
      _TranslationsDialogsAddIgnorePatternZhCn._(_root);
  @override
  late final _TranslationsDialogsDiffViewerZhCn diffViewer =
      _TranslationsDialogsDiffViewerZhCn._(_root);
}

// Path: grid
class _TranslationsGridZhCn extends TranslationsGridEn {
  _TranslationsGridZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGridColumnsZhCn columns =
      _TranslationsGridColumnsZhCn._(_root);
}

// Path: tutorial
class _TranslationsTutorialZhCn extends TranslationsTutorialEn {
  _TranslationsTutorialZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => '跳过教程';
  @override
  String get finishMessage => '一切准备就绪！点击任意位置完成。';
  @override
  String get next => '下一步';
  @override
  String get loadSampleData => '加载示例数据';
  @override
  String get browseSourceFile => '浏览源文件';
  @override
  String get browseTargetFile => '浏览目标文件';
  @override
  String get compareFiles => '对比文件';
  @override
  String get hintPhase2 => '下一步：过滤器、搜索、高级视图和导出。';
  @override
  late final _TranslationsTutorialStepsZhCn steps =
      _TranslationsTutorialStepsZhCn._(_root);
}

// Path: friendlyErrors
class _TranslationsFriendlyErrorsZhCn extends TranslationsFriendlyErrorsEn {
  _TranslationsFriendlyErrorsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsFriendlyErrorsFileNotFoundZhCn fileNotFound =
      _TranslationsFriendlyErrorsFileNotFoundZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsAccessDeniedZhCn accessDenied =
      _TranslationsFriendlyErrorsAccessDeniedZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsIsDirectoryZhCn isDirectory =
      _TranslationsFriendlyErrorsIsDirectoryZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsFileAccessZhCn fileAccess =
      _TranslationsFriendlyErrorsFileAccessZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsUnsupportedFormatZhCn
      unsupportedFormat =
      _TranslationsFriendlyErrorsUnsupportedFormatZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsNetworkErrorZhCn networkError =
      _TranslationsFriendlyErrorsNetworkErrorZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsNotGitRepoZhCn notGitRepo =
      _TranslationsFriendlyErrorsNotGitRepoZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsMergeConflictZhCn mergeConflict =
      _TranslationsFriendlyErrorsMergeConflictZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitAuthFailedZhCn gitAuthFailed =
      _TranslationsFriendlyErrorsGitAuthFailedZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitOperationFailedZhCn
      gitOperationFailed =
      _TranslationsFriendlyErrorsGitOperationFailedZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidJsonZhCn invalidJson =
      _TranslationsFriendlyErrorsInvalidJsonZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsRateLimitReachedZhCn rateLimitReached =
      _TranslationsFriendlyErrorsRateLimitReachedZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidApiKeyZhCn invalidApiKey =
      _TranslationsFriendlyErrorsInvalidApiKeyZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsTranslationServiceErrorZhCn
      translationServiceError =
      _TranslationsFriendlyErrorsTranslationServiceErrorZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsOutOfMemoryZhCn outOfMemory =
      _TranslationsFriendlyErrorsOutOfMemoryZhCn._(_root);
  @override
  late final _TranslationsFriendlyErrorsGenericErrorZhCn genericError =
      _TranslationsFriendlyErrorsGenericErrorZhCn._(_root);
}

// Path: systemTray
class _TranslationsSystemTrayZhCn extends TranslationsSystemTrayEn {
  _TranslationsSystemTrayZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get showLocalizer => '显示 Localizer';
  @override
  String get exit => '退出';
}

// Path: validation
class _TranslationsValidationZhCn extends TranslationsValidationEn {
  _TranslationsValidationZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get connected => '已连接。';
  @override
  String get connectionTimeout => '连接超时。请重试。';
  @override
  String get couldNotConnect => '无法连接。请重试。';
  @override
  String get checkKeyAndTryAgain => '无法连接。请检查密钥并重试。';
  @override
  String get tryAgainLater => '暂时无法连接。请稍后重试。';
  @override
  String get serviceUnavailable => '服务当前不可用。请稍后重试。';
  @override
  String get enterKeyFirst => '请先输入密钥。';
  @override
  String get checking => '正在检查...';
  @override
  String deeplUsage({required Object used, required Object limit}) =>
      '使用量：${used} / ${limit} 字符。';
}

// Path: status
class _TranslationsStatusZhCn extends TranslationsStatusEn {
  _TranslationsStatusZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get startingComparison => '正在开始对比...';
  @override
  String get loadingFromHistory => '正在从历史记录加载文件...';
  @override
  String get comparisonComplete => '对比完成';
  @override
  String get couldNotImportFiles => '无法导入文件。请重试。';
  @override
  String get historyFilesNotFound => '在原始路径未找到来自历史的一个或两个文件。';
}

// Path: aiServices
class _TranslationsAiServicesZhCn extends TranslationsAiServicesEn {
  _TranslationsAiServicesZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get geminiEmptyResponse => 'Gemini 返回了空响应';
  @override
  String get geminiStreamingEmpty => 'Gemini 流式传输返回了空响应';
  @override
  String get geminiRephraseEmpty => 'Gemini 改写返回了空响应';
  @override
  String get openaiEmptyResponse => 'OpenAI 返回了空或失败的响应';
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceZhCn
    extends TranslationsSettingsAppearanceEn {
  _TranslationsSettingsAppearanceZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '外观';
  @override
  String get description => '自定义应用的外观和感觉';
  @override
  String get theme => '主题模式';
  @override
  String get themeDescription => '选择明亮、暗黑或跟随系统';
  @override
  String get themeSystem => '跟随系统';
  @override
  String get themeLight => '明亮';
  @override
  String get themeDark => '暗黑';
  @override
  String get themeAmoled => 'AMOLED';
  @override
  String get accentColor => '强调色';
  @override
  String get accentColorDescription => '选择您喜欢的强调色';
  @override
  String get useMicaEffect => '使用云母效果';
  @override
  String get micaDescription => '启用 Windows 11 云母半透明效果，获得现代外观';
  @override
  String get diffFontSize => '对比字体大小';
  @override
  String get diffFontSizeDescription => '调整对比视图的字体大小';
  @override
  String get diffFontFamily => '对比字体';
  @override
  String get diffFontFamilyDescription => '对比视图使用的字体';
  @override
  String get systemDefault => '系统默认';
  @override
  String get pickAccentColor => '选择强调色';
  @override
  String get diffColors => '对比颜色';
  @override
  String get presetsTitle => '预设';
  @override
  late final _TranslationsSettingsAppearancePresetsZhCn presets =
      _TranslationsSettingsAppearancePresetsZhCn._(_root);
  @override
  String get identical => '相同';
  @override
  String pickColorFor({required Object label}) => '选择 ${label} 的颜色';
  @override
  String get livePreview => '实时预览';
  @override
  late final _TranslationsSettingsAppearancePreviewZhCn preview =
      _TranslationsSettingsAppearancePreviewZhCn._(_root);
}

// Path: settings.general
class _TranslationsSettingsGeneralZhCn extends TranslationsSettingsGeneralEn {
  _TranslationsSettingsGeneralZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '常规';
  @override
  String get description => '常规应用设置';
  @override
  String get language => '语言';
  @override
  String get languageDescription => '选择您的首选语言';
  @override
  String get startMinimized => '启动时最小化到托盘';
  @override
  String get startMinimizedDescription => '应用启动时最小化到系统托盘';
  @override
  String get rememberWindowPosition => '记住窗口位置';
  @override
  String get rememberWindowPositionDescription => '启动时恢复窗口大小和位置';
  @override
  String get openLastProject => '启动时打开上一个项目';
  @override
  String get openLastProjectDescription => '应用启动时自动打开上次使用的项目';
  @override
  String get application => '应用';
  @override
  String get defaultView => '默认视图';
  @override
  String get defaultViewDescription => '启动时显示的视图';
  @override
  String get autoCheckUpdates => '自动检查更新';
  @override
  String get autoCheckUpdatesDescription => '启动时检查更新';
  @override
  String get startupOptions => '启动选项';
  @override
  String get languageAuto => '自动检测';
  @override
  String get viewBasic => '文件对比';
  @override
  String get viewHistory => '历史记录';
  @override
  String get viewDashboard => '质量仪表盘';
  @override
  String get viewDirectory => '目录对比';
  @override
  String get viewLastUsed => '上次使用的视图';
}

// Path: settings.scope
class _TranslationsSettingsScopeZhCn extends TranslationsSettingsScopeEn {
  _TranslationsSettingsScopeZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '设置范围';
  @override
  String get global => '全局默认';
  @override
  String get project => '项目';
  @override
  String get reset => '重置项目为全局默认';
  @override
  String get resetConfirmation => '这将清除该项目的所有覆盖设置并恢复为全局默认值。此操作无法撤销。';
  @override
  String get globalDescription => '更改适用于所有项目，除非被覆盖。';
  @override
  String projectDescription({required Object name}) =>
      '更改仅适用于 "${name}"。其他设置继承自全局默认值。';
  @override
  String get createPrompt => '创建一个项目以自定义特定文件夹的设置';
}

// Path: settings.searchKeywords
class _TranslationsSettingsSearchKeywordsZhCn
    extends TranslationsSettingsSearchKeywordsEn {
  _TranslationsSettingsSearchKeywordsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  List<String> get general => [
        '语言',
        '默认视图',
        '最近文件数量',
        '打开上一个项目',
        '退出前确认',
        '显示通知',
      ];
  @override
  List<String> get comparisonEngine => [
        '对比模式',
        '相似度阈值',
        '区分大小写',
        '忽略空白',
        '忽略空行',
        '忽略注释',
        '忽略模式',
      ];
  @override
  List<String> get appearance => [
        '主题',
        '主题模式',
        '强调色',
        '对比字体大小',
        '对比字体',
        '对比颜色',
        '新增颜色',
        '删除颜色',
        '修改颜色',
        '相同颜色',
        '颜色预设',
        '预览',
      ];
  @override
  List<String> get fileHandling => [
        '源格式',
        '目标格式',
        '默认编码',
        '最近项目数量',
        '翻译记忆库',
        '导入记忆库',
        '导出记忆库',
        '清除记忆库',
      ];
  @override
  List<String> get aiServices => [
        'OpenAI API 密钥',
        'Anthropic API 密钥',
        'Google AI API 密钥',
        'AI 模型',
        '温度',
        '自定义提示词',
      ];
  @override
  List<String> get systemIntegrations => [
        '系统托盘',
        '启动最小化',
        '文件关联',
        '云母效果',
        '特效',
        '窗口材质',
        'Dock 徽章',
        '未翻译计数',
      ];
  @override
  List<String> get projectResources => [
        '术语表',
        '翻译记忆库',
        '术语',
      ];
  @override
  List<String> get about => [
        '版本',
        '检查更新',
        '自动更新',
        '更新日志',
        '许可证',
        '隐私政策',
        '遥测',
        '崩溃报告',
      ];
  @override
  List<String> get developer => [
        '性能浮层',
        '语义调试器',
        'Material 网格',
        '光栅缓存',
        '重启教程',
        '恢复出厂设置',
      ];
}

// Path: settings.comparison
class _TranslationsSettingsComparisonZhCn
    extends TranslationsSettingsComparisonEn {
  _TranslationsSettingsComparisonZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '对比';
  @override
  String get description => '配置对比行为';
  @override
  String get caseSensitive => '区分大小写';
  @override
  String get caseSensitiveDescription => '将大写和小写字母视为不同';
  @override
  String get ignoreWhitespace => '忽略空白';
  @override
  String get ignoreWhitespaceDescription => '对比时忽略前导/尾随空白';
  @override
  String get showLineNumbers => '显示行号';
  @override
  String get showLineNumbersDescription => '在对比视图中显示行号';
  @override
  String get behavior => '对比行为';
  @override
  String get ignoreCase => '忽略大小写';
  @override
  String get ignoreCaseDescription => '将 "Key" 和 "key" 视为相同';
  @override
  String get similarityThreshold => '相似度阈值';
  @override
  String get similarityThresholdDescription => '检测 "已修改" 的最低相似度';
  @override
  String get mode => '对比模式';
  @override
  String get modeDescription => '如何在文件之间匹配条目';
  @override
  String get modeKey => '基于键';
  @override
  String get modeKeyDescription => '通过键名匹配（默认）。';
  @override
  String get modeOrder => '基于顺序';
  @override
  String get modeOrderDescription => '通过在文件中的位置匹配。';
  @override
  String get modeSmart => '智能匹配';
  @override
  String get modeSmartDescription => '检测移动/重命名的键。';
  @override
  String get ignorePatterns => '忽略模式';
  @override
  String get noIgnorePatterns => '未设置忽略模式。';
  @override
  String get addPattern => '添加模式';
  @override
  String get resetToGlobal => '重置所有对比设置为全局默认值';
  @override
  late final _TranslationsSettingsComparisonPatternPresetsZhCn patternPresets =
      _TranslationsSettingsComparisonPatternPresetsZhCn._(_root);
  @override
  late final _TranslationsSettingsComparisonPreviewMatchZhCn previewMatch =
      _TranslationsSettingsComparisonPreviewMatchZhCn._(_root);
  @override
  late final _TranslationsSettingsComparisonColorPresetsZhCn colorPresets =
      _TranslationsSettingsComparisonColorPresetsZhCn._(_root);
}

// Path: settings.fileHandling
class _TranslationsSettingsFileHandlingZhCn
    extends TranslationsSettingsFileHandlingEn {
  _TranslationsSettingsFileHandlingZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get fileFormats => '文件格式';
  @override
  String get sourceFormat => '源格式';
  @override
  String get targetFormat => '目标格式';
  @override
  String get encoding => '编码';
  @override
  String get sourceEncoding => '源编码';
  @override
  String get targetEncoding => '目标编码';
  @override
  String get autoDetect => '自动检测';
  @override
  String get autoDetectEncodingDescription => '自动检测文件编码';
  @override
  String get exportSettings => '导出设置';
  @override
  String get defaultExportFormat => '默认导出格式';
  @override
  String get includeUtf8Bom => '包含 UTF-8 BOM';
  @override
  String get includeUtf8BomDescription => 'Excel 兼容性所需';
  @override
  String get openFolderAfterExport => '导出后打开文件夹';
  @override
  String get fileSafety => '文件安全';
  @override
  String get fileSafetyDescription => '自动为灾难恢复创建本地副本。';
  @override
  String get resetToGlobal => '重置所有文件处理设置为全局默认值';
}

// Path: settings.translationMemory
class _TranslationsSettingsTranslationMemoryZhCn
    extends TranslationsSettingsTranslationMemoryEn {
  _TranslationsSettingsTranslationMemoryZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '全局翻译记忆库';
  @override
  String get autoLearn => '自动学习';
  @override
  String get autoLearnDescription => '将翻译保存到本地记忆库以供将来重复使用';
  @override
  String get confidenceThreshold => '置信度阈值';
  @override
  String confidenceThresholdDescription({required Object percent}) =>
      '自动应用的最低分数 (${percent}%)';
  @override
  String get entries => '条目';
  @override
  String get size => '大小';
  @override
  String memorySize({required Object size}) => '记忆库大小：${size}';
  @override
  String get import => '导入';
  @override
  String get exportTmx => '导出 TMX';
  @override
  String get exportCsv => '导出 CSV';
  @override
  String get clearMemory => '清除记忆库';
  @override
  String importedItems({required Object count}) => '已将 ${count} 个项目导入记忆库。';
  @override
  String get noItemsAdded => '未添加任何项目。';
  @override
  String get nothingToExport => '暂无内容可导出。';
  @override
  String get tmxSaved => 'TMX 已保存';
  @override
  String get csvSaved => 'CSV 已保存';
  @override
  String get clearConfirmTitle => '清除翻译记忆库？';
  @override
  String get clearConfirmContent => '这将删除此设备上所有保存的翻译对。此操作无法撤销。';
  @override
  String get cleared => '翻译记忆库已清除。';
  @override
  String get couldNotClear => '无法清除记忆库。';
}

// Path: settings.backup
class _TranslationsSettingsBackupZhCn extends TranslationsSettingsBackupEn {
  _TranslationsSettingsBackupZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '自动备份';
  @override
  String get description => '自动备份设置';
  @override
  String get enabled => '启用自动备份';
  @override
  String get enabledDescription => '在进行更改前自动备份文件';
  @override
  String get maxCopies => '最大备份副本数';
  @override
  String get maxCopiesDescription => '每个为文件保留的备份副本数量';
  @override
  String activeStatus({required Object count}) => '激活 · 保留 ${count} 个副本';
  @override
  String get folder => '备份文件夹';
  @override
  String get folderDescription => '留空以使用相同文件夹';
  @override
  String get useOriginalFolder => '使用原始文件文件夹';
}

// Path: settings.ai
class _TranslationsSettingsAiZhCn extends TranslationsSettingsAiEn {
  _TranslationsSettingsAiZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'AI 服务';
  @override
  String get description => '配置 AI 翻译和辅助';
  @override
  String get provider => 'AI 提供商';
  @override
  String get providerDescription => '选择您首选的 AI 服务提供商';
  @override
  String get apiKey => 'API 密钥';
  @override
  String get apiKeyDescription => '输入所选提供商的 API 密钥';
  @override
  String get apiKeyPlaceholder => '输入 API 密钥...';
  @override
  String get testConnection => '测试连接';
  @override
  String get connectionSuccess => '连接成功！';
  @override
  String get connectionFailed => '连接失败。请检查您的 API 密钥。';
  @override
  String get translationStrategy => '翻译策略';
  @override
  String get strategy => '策略';
  @override
  String get strategyDescription => '选择您希望如何翻译字符串';
  @override
  String get strategyLLM => '生成式 AI (LLM)';
  @override
  String get strategyCloud => '云翻译';
  @override
  String get enableAiTranslation => '启用 AI 翻译';
  @override
  String get enableAiTranslationDescription => '允许应用使用 AI 进行翻译建议';
  @override
  String get llmProvider => 'LLM 服务提供商';
  @override
  String get service => '服务';
  @override
  String get serviceDescription => '生成式 AI 提供商';
  @override
  String get providerGemini => 'Google Gemini';
  @override
  String get providerOpenAI => 'OpenAI';
  @override
  String get geminiApiKey => 'Gemini API 密钥';
  @override
  String get openAiApiKey => 'OpenAI API 密钥';
  @override
  String get model => '模型';
  @override
  String get modelDescription => '选择使用的模型';
  @override
  String get advancedParameters => '高级参数';
  @override
  String get parameters => '参数';
  @override
  String get parametersDescription => '温度、上下文及更多';
  @override
  String get temperature => '温度';
  @override
  String get temperatureDescription => '较高的值使输出更具创造性';
  @override
  String get maxTokens => '最大 Tokens';
  @override
  String get maxTokensDescription => '限制上下文窗口长度';
  @override
  String get systemContext => '系统上下文 / 指令';
  @override
  String get systemContextHint => '你是一名专业的本地化人员。保持源字符串的语气和意图...';
  @override
  String get systemContextHelper => '向 AI 提供有关项目风格和术语的具体说明。';
  @override
  String get contextStrings => '上下文字符串';
  @override
  String get contextStringsDescription => '包含周围的字符串以获得更好的上下文';
  @override
  String get contextCount => '上下文数量';
  @override
  String get contextCountDescription => '包含的周围字符串数量';
  @override
  String get cloudServices => '云翻译服务';
  @override
  String get googleTranslateApiKey => 'Google 翻译 API 密钥';
  @override
  String get deeplApiKey => 'DeepL API 密钥';
  @override
  String get test => '测试';
  @override
  String get resetToGlobal => '重置所有 AI 设置为全局默认值';
}

// Path: settings.integrations
class _TranslationsSettingsIntegrationsZhCn
    extends TranslationsSettingsIntegrationsEn {
  _TranslationsSettingsIntegrationsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get platformNotice => '平台通知';
  @override
  String get platformNoticeDescription => '该平台不支持系统集成。';
  @override
  String get visualEffects => '视觉效果';
  @override
  String get explorerIntegration => '资源管理器集成';
  @override
  String get explorerIntegrationDescription =>
      '将 "使用 Localizer 打开" 添加到文件夹的 Windows 资源管理器右键菜单。';
  @override
  String get addToContextMenu => '添加到上下文菜单';
  @override
  String get contextMenuAdded => '上下文菜单已添加！';
  @override
  String get contextMenuAddError => '添加上下文菜单失败';
  @override
  String get contextMenuRemoved => '上下文菜单已移除！';
  @override
  String get contextMenuRemoveError => '移除上下文菜单失败';
  @override
  String get fileAssociations => '文件关联';
  @override
  String get fileAssociationsDescription =>
      '注册文件类型以便在资源管理器中双击时使用 Localizer 打开。';
  @override
  String get registered => '已注册';
  @override
  String get notRegistered => '未注册';
  @override
  String extRegistered({required Object ext}) => '${ext} 已注册！';
  @override
  String extUnregistered({required Object ext}) => '${ext} 已取消注册！';
  @override
  String extError({required Object ext, required Object action}) =>
      '无法对 ${ext} 执行 ${action}';
  @override
  String get registerAll => '全部注册';
  @override
  String get unregisterAll => '全部取消注册';
  @override
  String registerAllResult({required Object success, required Object total}) =>
      '已注册 ${success} / ${total} 个文件类型';
  @override
  String unregisterAllResult(
          {required Object success, required Object total}) =>
      '已取消注册 ${success} / ${total} 个文件类型';
  @override
  String get protocolHandler => '协议处理程序';
  @override
  String get protocolHandlerDescription => '注册 localizer:// URL 以打开此应用程序。';
  @override
  String get protocolRegistered => '协议处理程序已注册';
  @override
  String get protocolNotRegistered => '协议处理程序未注册';
  @override
  String get registerProtocol => '注册协议';
  @override
  String get unregister => '取消注册';
  @override
  String get protocolRegisteredSuccess => '协议处理程序已注册！';
  @override
  String get protocolRemovedSuccess => '协议处理程序已移除！';
  @override
  String get protocolRegisterError => '注册失败';
  @override
  String get protocolRemoveError => '移除失败';
  @override
  String get windowMaterial => '窗口材质';
  @override
  String get windowMaterialDescription => '选择 macOS 材质风格';
  @override
  String get dockIntegration => 'Dock 集成';
  @override
  String get showDockBadge => '显示未翻译计数';
  @override
  String get showDockBadgeDescription => '在 Dock 图标徽章上显示未翻译字符串计数';
  @override
  late final _TranslationsSettingsIntegrationsMaterialsZhCn materials =
      _TranslationsSettingsIntegrationsMaterialsZhCn._(_root);
  @override
  late final _TranslationsSettingsIntegrationsFileTypesZhCn fileTypes =
      _TranslationsSettingsIntegrationsFileTypesZhCn._(_root);
}

// Path: settings.developer
class _TranslationsSettingsDeveloperZhCn
    extends TranslationsSettingsDeveloperEn {
  _TranslationsSettingsDeveloperZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '开发者设置';
  @override
  String get description => '开发者的应用设置';
  @override
  String get showLocalizationKeys => '显示本地化键';
  @override
  String get localizationKeysDescription => '启用后，所有翻译文本显示键名而非值';
  @override
  String get showPerformanceOverlay => '显示性能浮层';
  @override
  String get performanceOverlayDescription => '显示 FPS 和帧计时信息';
  @override
  String get debugMode => '调试模式';
  @override
  String get debugModeDescription => '启用额外日志和调试功能';
  @override
  String get debuggingTools => '调试工具';
  @override
  String get semanticsDebugger => '语义调试器';
  @override
  String get semanticsDebuggerDescription => '可视化语义树';
  @override
  String get materialGrid => 'Material 网格';
  @override
  String get materialGridDescription => '覆盖 Material 布局网格';
  @override
  String get rasterCache => '光栅缓存图像';
  @override
  String get rasterCacheDescription => '棋盘格光栅缓存图像';
  @override
  String get actions => '操作';
  @override
  String get showLogs => '显示应用日志';
  @override
  String get showLogsDescription => '打开 Talker 调试控制台';
  @override
  String get restartTutorial => '重启入门教程';
  @override
  String get restartTutorialDescription => '重置标志并重新启动教程';
  @override
  String get restartRequested => '教程重启已请求。';
  @override
  String get throwException => '抛出测试异常';
  @override
  String get throwExceptionDescription => '触发测试异常以进行崩溃报告';
  @override
  String get testExceptionMessage => '从开发者选项触发的测试异常';
  @override
  String get clearTM => '清除翻译记忆库';
  @override
  String get clearTMDescription => '删除所有缓存的翻译';
  @override
  String get clearTMConfirmation => '清除翻译记忆库？';
  @override
  String get clearTMWarning => '这将删除所有学习到的翻译。此操作无法撤销。';
  @override
  String get tmCleared => '翻译记忆库已清除';
  @override
  String get clearApiKeys => '清除 API 密钥';
  @override
  String get clearApiKeysDescription => '移除所有存储的 API 密钥';
  @override
  String get clearApiKeysConfirmation => '清除 API 密钥？';
  @override
  String get clearApiKeysWarning => '这将从安全存储中移除所有 API 密钥。';
  @override
  String get apiKeysCleared => 'API 密钥已清除';
  @override
  String get hideOptions => '隐藏开发者选项';
  @override
  String get hideOptionsDescription => '禁用开发者模式（需要点击 7 次以重新启用）';
  @override
  String get optionsDisabled => '开发者选项已禁用';
  @override
  String get dangerZone => '危险区域';
  @override
  String get factoryReset => '恢复出厂设置';
  @override
  String get factoryResetDescription => '重置所有设置并清除数据';
  @override
  String get factoryResetWarning => '您确定要重置所有设置吗？此操作无法撤销。';
  @override
  String get inspectionTools => '检查工具';
  @override
  String get searchHint => '搜索设置...';
  @override
  String get resetToDefault => '恢复默认设置';
  @override
  String get resetToGlobal => '恢复全局默认设置';
  @override
  String get storageInspector => '存储检查器';
  @override
  String get storageInspectorDescription => '查看 Hive 和安全存储内容';
  @override
  String get deviceEnvironment => '设备与环境';
  @override
  String get deviceEnvironmentDescription => '屏幕、平台和构建信息';
  @override
  String get themePlayground => '主题广场';
  @override
  String get themePlaygroundDescription => '调色板和排版';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionZhCn
      themePlaygroundSection =
      _TranslationsSettingsDeveloperThemePlaygroundSectionZhCn._(_root);
  @override
  String get localizationInspector => '本地化检查器';
  @override
  String get localizationInspectorDescription => '调试翻译字符串';
  @override
  String get hiveAppSettings => 'Hive (应用设置)';
  @override
  String get secureStorageMasked => '安全存储 (已掩码)';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsZhCn featureFlags =
      _TranslationsSettingsDeveloperFeatureFlagsZhCn._(_root);
  @override
  late final _TranslationsSettingsDeveloperStorageInspectorSectionZhCn
      storageInspectorSection =
      _TranslationsSettingsDeveloperStorageInspectorSectionZhCn._(_root);
  @override
  late final _TranslationsSettingsDeveloperDeviceInfoSectionZhCn
      deviceInfoSection =
      _TranslationsSettingsDeveloperDeviceInfoSectionZhCn._(_root);
  @override
  late final _TranslationsSettingsDeveloperLocalizationInspectorSectionZhCn
      localizationInspectorSection =
      _TranslationsSettingsDeveloperLocalizationInspectorSectionZhCn._(_root);
}

// Path: settings.about
class _TranslationsSettingsAboutZhCn extends TranslationsSettingsAboutEn {
  _TranslationsSettingsAboutZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '关于';
  @override
  String get version => '版本';
  @override
  String get buildNumber => '构建版本';
  @override
  String get author => '作者';
  @override
  String get license => '许可证';
  @override
  String get sourceCode => '源代码';
  @override
  String get reportBug => '报告漏洞';
  @override
  String get requestFeature => '请求功能';
  @override
  String get checkForUpdates => '检查更新';
  @override
  String get upToDate => '您已是最新版本！';
  @override
  String updateAvailable({required Object version}) => '发现新版本：${version}';
  @override
  String get updateAvailableBadge => '有更新可用！';
  @override
  String developerSteps({required Object count}) => '您距离成为开发者还有 ${count} 步。';
  @override
  String get developerActivated => '您现在是开发者了！';
  @override
  String get neverChecked => '从不';
  @override
  String get applicationInfo => '应用信息';
  @override
  String get platform => '平台';
  @override
  String get updateInformation => '更新信息';
  @override
  String get currentVersion => '当前版本';
  @override
  String get latestVersion => '最新版本';
  @override
  String get lastChecked => '上次检查';
  @override
  String get checkingForUpdates => '正在检查...';
  @override
  String get whatsNew => '新功能';
  @override
  String get systemInformation => '系统信息';
  @override
  String get dartVersion => 'Dart 版本';
  @override
  String get diskSpace => '可用磁盘空间';
  @override
  String get memoryUsage => '内存使用';
  @override
  String get privacyTitle => '隐私与遥测';
  @override
  String get usageStats => '匿名使用统计';
  @override
  String get requiresFirebase => '需要 Firebase 配置';
  @override
  String get featureUnavailable => '功能当前不可用（需要 Firebase）';
  @override
  String get settingsManagement => '设置管理';
  @override
  String get settingsManagementDescription => '将您的设置导出到文件以进行备份或与其他机器共享。';
  @override
  String get resetAll => '重置全部';
  @override
  String get links => '链接';
  @override
  String get githubRepo => 'GitHub 仓库';
  @override
  String get privacyPolicy => '隐私政策';
  @override
  String get crashReporting => '崩溃报告';
}

// Path: settings.onboarding
class _TranslationsSettingsOnboardingZhCn
    extends TranslationsSettingsOnboardingEn {
  _TranslationsSettingsOnboardingZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => '跳过教程';
  @override
  String get gettingStarted => '快速入门';
  @override
  String stepProgress({required Object current, required Object total}) =>
      '${current} / ${total}';
  @override
  String get loadSampleData => '加载示例数据';
  @override
  late final _TranslationsSettingsOnboardingStepsZhCn steps =
      _TranslationsSettingsOnboardingStepsZhCn._(_root);
}

// Path: settings.settingsView
class _TranslationsSettingsSettingsViewZhCn
    extends TranslationsSettingsSettingsViewEn {
  _TranslationsSettingsSettingsViewZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String resetCategoryTitle({required Object category}) => '重置 ${category}？';
  @override
  String get resetCategoryContent => '这将重置此类别下的所有设置恢复默认值。';
  @override
  String get resetAllTitle => '重置所有设置？';
  @override
  String get resetAllContent => '这将永久将所有设置重置为出厂默认值。此操作无法撤销。';
  @override
  String get resetAll => '重置全部';
  @override
  String resetSuccess({required Object category}) => '${category} 已恢复默认';
  @override
  String get errorLoading => '加载设置错误';
  @override
  String get settingsSaved => '设置已保存';
  @override
  String updateAvailable({required Object version}) => '更新可用：v${version}';
  @override
  String get latestVersion => '您正在使用最新版本';
  @override
  String whatsNew({required Object version}) => 'v${version} 的新功能';
  @override
  String get downloadUpdate => '下载更新';
  @override
  String get exportSettings => '导出设置';
  @override
  String get settingsExported => '设置已导出';
  @override
  String exportFail({required Object error}) => '导出设置失败：${error}';
  @override
  String get importSettings => '导入设置';
  @override
  String get importTitle => '导入设置？';
  @override
  String get importContent => '这将使用导入的设置替换当前所有设置。此操作无法撤销。';
  @override
  String get importSuccess => '设置导入成功！';
  @override
  String importFail({required Object error}) => '导入设置失败：${error}';
  @override
  String get invalidFormat => '无效的设置文件格式';
  @override
  late final _TranslationsSettingsSettingsViewCategoriesZhCn categories =
      _TranslationsSettingsSettingsViewCategoriesZhCn._(_root);
  @override
  late final _TranslationsSettingsSettingsViewCategoryLabelsZhCn
      categoryLabels =
      _TranslationsSettingsSettingsViewCategoryLabelsZhCn._(_root);
}

// Path: advancedDiff.aiSuggestion
class _TranslationsAdvancedDiffAiSuggestionZhCn
    extends TranslationsAdvancedDiffAiSuggestionEn {
  _TranslationsAdvancedDiffAiSuggestionZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get aiTranslation => 'AI 翻译';
  @override
  String get aiRephrase => 'AI 改写';
  @override
  String key({required Object key}) => '键：${key}';
  @override
  String get original => '原始：';
  @override
  String get suggestion => '建议：';
  @override
  String get confidence => 'AI 置信度';
  @override
  String get cancelEdit => '取消编辑';
  @override
  String get editSuggestion => '编辑建议';
  @override
  String get alternatives => '替代方案：';
  @override
  String get accept => '接受';
  @override
  String get reject => '拒绝';
  @override
  String get stop => '停止';
}

// Path: advancedDiff.detailEdit
class _TranslationsAdvancedDiffDetailEditZhCn
    extends TranslationsAdvancedDiffDetailEditEn {
  _TranslationsAdvancedDiffDetailEditZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object key}) => '编辑：${key}';
  @override
  String get sourceLabel => '源 (原始)';
  @override
  String get targetLabel => '目标 (翻译)';
  @override
  String get translateWithCloud => '使用云翻译';
  @override
  String get translateWithAi => '使用 AI 翻译';
  @override
  String get translating => '翻译中...';
  @override
  String get applyAndTm => '应用';
  @override
  String get entryApplied => '条目已应用并添加到 TM';
  @override
  String get translationAdded => '翻译建议已添加。';
  @override
  String get aiSuggestionAdded => 'AI 建议已添加。';
}

// Path: advancedDiff.table
class _TranslationsAdvancedDiffTableZhCn
    extends TranslationsAdvancedDiffTableEn {
  _TranslationsAdvancedDiffTableZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get addedToTM => '已添加到翻译记忆库';
  @override
  String get markedReviewed => '标记为已审核 ✓';
  @override
  String get unmarkedReview => '取消已审核标记';
  @override
  String get reverted => '已恢复为源值';
  @override
  String get entryDeleted => '条目已删除';
  @override
  String get noSourceText => '没有可翻译的源文本。';
  @override
  String aiTranslationFailed({required Object key}) => '"${key}" AI 翻译失败';
  @override
  String get noTargetText => '没有可改写的目标文本。';
  @override
  String aiRephraseFailed({required Object key}) => '"${key}" AI 改写失败';
  @override
  String get checkRowsFirst => '请先使用复选框选择行';
  @override
  String markedRowsReviewed({required Object count}) => '已将 ${count} 行标记为已审核';
  @override
  String revertedRows({required Object count}) => '已恢复 ${count} 行';
  @override
  String entriesCount({required Object count}) => '${count} 个条目';
  @override
  String get markSelectedReviewed => '标记所选为已审核';
  @override
  String get revertSelected => '恢复所选';
  @override
  String get noDifferences => '未发现差异';
  @override
  String get adjustFilters => '尝试调整过滤器';
  @override
  String get cloudTranslationApplied => '云翻译已应用。';
  @override
  String get aiTranslationApplied => 'AI 翻译已应用。';
  @override
  String get suggestionApplied => '建议已应用。';
  @override
  String get aiSuggestionApplied => 'AI 建议已应用。';
  @override
  String get rephraseApplied => '改写已应用。';
  @override
  String get aiRephraseApplied => 'AI 改写已应用。';
  @override
  String get rephrase => '改写';
  @override
  String get aiRephrase => 'AI 改写';
  @override
  String get targetClickToEdit => '目标 (点击编辑)';
  @override
  String get targetClickForDialog => '目标 (点击打开对话框)';
  @override
  String get emptyClickToEdit => '(空 - 点击编辑)';
  @override
  String get unmarkReviewed => '取消已审核';
  @override
  String get markReviewed => '标记为已审核';
  @override
  String get revertToSource => '恢复为源文';
  @override
  String get translateWithCloud => '使用云翻译';
  @override
  String get translateWithAi => '使用 AI 翻译';
  @override
  String get rephraseWithAi => '使用 AI 改写';
  @override
  String get moreActions => '更多操作';
  @override
  String get editDetails => '编辑详情';
  @override
  String get suggestTranslation => '建议翻译';
  @override
  String get addToTm => '添加到 TM';
  @override
  String get deleteEntry => '删除条目';
}

// Path: advancedDiff.diffRow
class _TranslationsAdvancedDiffDiffRowZhCn
    extends TranslationsAdvancedDiffDiffRowEn {
  _TranslationsAdvancedDiffDiffRowZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get copySource => '复制源文本';
  @override
  String get actions => '操作';
}

// Path: advancedDiff.status
class _TranslationsAdvancedDiffStatusZhCn
    extends TranslationsAdvancedDiffStatusEn {
  _TranslationsAdvancedDiffStatusZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get added => '新增';
  @override
  String get missing => '缺失';
  @override
  String changed({required Object percent}) => '修改 ${percent}%';
  @override
  String get same => '相同';
}

// Path: advancedDiff.sidebar
class _TranslationsAdvancedDiffSidebarZhCn
    extends TranslationsAdvancedDiffSidebarEn {
  _TranslationsAdvancedDiffSidebarZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get widgets => '小部件';
  @override
  String get searchPlaceholder => '搜索键和值... (Ctrl+F)';
  @override
  String get fuzzySearchTooltip => '模糊搜索 (容错)';
  @override
  String get regexSearchTooltip => '正则表达式搜索';
  @override
  String get cloudTranslation => '云翻译';
  @override
  String get aiTranslation => 'AI 翻译';
  @override
  String get status => '状态';
  @override
  String get tm => '翻译记忆库';
  @override
  String get filters => '过滤器';
  @override
  String get actions => '操作';
  @override
  String get similarity => '相似度';
  @override
  late final _TranslationsAdvancedDiffSidebarActionsSectionZhCn actionsSection =
      _TranslationsAdvancedDiffSidebarActionsSectionZhCn._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarAiSectionZhCn aiSection =
      _TranslationsAdvancedDiffSidebarAiSectionZhCn._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarTmSectionZhCn tmSection =
      _TranslationsAdvancedDiffSidebarTmSectionZhCn._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarFiltersSectionZhCn filtersSection =
      _TranslationsAdvancedDiffSidebarFiltersSectionZhCn._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarSimilaritySectionZhCn
      similaritySection =
      _TranslationsAdvancedDiffSidebarSimilaritySectionZhCn._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarStatusSectionZhCn statusSection =
      _TranslationsAdvancedDiffSidebarStatusSectionZhCn._(_root);
}

// Path: issueDetails.duplicateValue
class _TranslationsIssueDetailsDuplicateValueZhCn
    extends TranslationsIssueDetailsDuplicateValueEn {
  _TranslationsIssueDetailsDuplicateValueZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get label => '重复翻译';
  @override
  String get warning => '不同的源文本使用相同的翻译。请检查上下文。';
  @override
  String affectedKeys({required Object count}) => '受影响的键 (${count})';
  @override
  String get identicalSources => '源文本相同';
  @override
  String moreKeys({required Object count}) => '+${count} 更多键';
}

// Path: issueDetails.lengthOutlier
class _TranslationsIssueDetailsLengthOutlierZhCn
    extends TranslationsIssueDetailsLengthOutlierEn {
  _TranslationsIssueDetailsLengthOutlierZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get source => '源';
  @override
  String get translation => '翻译';
  @override
  String chars({required Object count}) => '${count} 字符';
}

// Path: issueDetails.standard
class _TranslationsIssueDetailsStandardZhCn
    extends TranslationsIssueDetailsStandardEn {
  _TranslationsIssueDetailsStandardZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get key => '键';
  @override
  String get sourceText => '源文本';
  @override
  String get translation => '翻译';
  @override
  String get errorDetails => '错误详情';
  @override
  String get note => '注意';
}

// Path: issueDetails.types
class _TranslationsIssueDetailsTypesZhCn
    extends TranslationsIssueDetailsTypesEn {
  _TranslationsIssueDetailsTypesZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get duplicateValue => '重复值';
  @override
  String get lengthOutlier => '长度不匹配';
  @override
  String get placeholderMismatch => '占位符损坏';
}

// Path: issueDetails.notes
class _TranslationsIssueDetailsNotesZhCn
    extends TranslationsIssueDetailsNotesEn {
  _TranslationsIssueDetailsNotesZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get placeholderMismatch => '占位符如 {name} 应与源文本匹配。';
  @override
  String get lengthOutlier => '长度的巨大变化可能会影响文本在屏幕上的显示。';
  @override
  String get duplicateValue => '不同的键使用了相同的翻译。';
}

// Path: issueDetails.fallbacks
class _TranslationsIssueDetailsFallbacksZhCn
    extends TranslationsIssueDetailsFallbacksEn {
  _TranslationsIssueDetailsFallbacksZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get multipleSources => '多个源文本';
  @override
  String get sourceNotAvailable => '源文本不可用';
  @override
  String get sharedTranslationNotAvailable => '共享翻译不可用';
  @override
  String get translationNotAvailable => '翻译不可用';
}

// Path: compare.tabs
class _TranslationsCompareTabsZhCn extends TranslationsCompareTabsEn {
  _TranslationsCompareTabsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get files => '文件';
  @override
  String get directories => '目录';
  @override
  String get git => 'Git';
}

// Path: compare.fileTypes
class _TranslationsCompareFileTypesZhCn extends TranslationsCompareFileTypesEn {
  _TranslationsCompareFileTypesZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get json => 'JSON 本地化文件 (i18next, Flutter 等)';
  @override
  String get yaml => 'YAML 本地化文件 (Rails, Flutter)';
  @override
  String get xml => 'XML 本地化文件 (Android, .NET)';
  @override
  String get properties => '属性文件 (Java)';
  @override
  String get resx => 'RESX 文件 (.NET)';
  @override
  String get xliff => 'XLIFF 文件';
}

// Path: history.timeAgo
class _TranslationsHistoryTimeAgoZhCn extends TranslationsHistoryTimeAgoEn {
  _TranslationsHistoryTimeAgoZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get justNow => '刚刚';
  @override
  String secondsAgo({required Object count}) => '${count} 秒前';
  @override
  String get oneMinuteAgo => '1 分钟前';
  @override
  String minutesAgo({required Object count}) => '${count} 分钟前';
  @override
  String get oneHourAgo => '1 小时前';
  @override
  String hoursAgo({required Object count}) => '${count} 小时前';
  @override
  String get yesterday => '昨天';
  @override
  String daysAgo({required Object count}) => '${count} 天前';
  @override
  String get oneWeekAgo => '1 周前';
  @override
  String weeksAgo({required Object count}) => '${count} 周前';
  @override
  String get oneMonthAgo => '1 个月前';
  @override
  String monthsAgo({required Object count}) => '${count} 个月前';
  @override
  String get oneYearAgo => '1 年前';
  @override
  String yearsAgo({required Object count}) => '${count} 年前';
  @override
  String get inTheFuture => '未来';
}

// Path: projects.stats
class _TranslationsProjectsStatsZhCn extends TranslationsProjectsStatsEn {
  _TranslationsProjectsStatsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get empty => '空项目';
  @override
  String files({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        n,
        one: '1 个翻译文件',
        other: '${count} 个翻译文件',
      );
  @override
  String languages({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        n,
        one: '1 种语言',
        other: '${count} 种语言',
      );
}

// Path: projects.selection
class _TranslationsProjectsSelectionZhCn
    extends TranslationsProjectsSelectionEn {
  _TranslationsProjectsSelectionZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get selectFolder => '选择项目文件夹';
  @override
  String get selectArchive => '选择项目归档';
  @override
  String get openProject => '打开项目';
  @override
  String get browseFolder => '浏览文件夹...';
  @override
  String get createNew => '创建新项目';
  @override
  String get importFromZip => '从 Zip 导入...';
}

// Path: projects.createDialog
class _TranslationsProjectsCreateDialogZhCn
    extends TranslationsProjectsCreateDialogEn {
  _TranslationsProjectsCreateDialogZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '创建项目';
  @override
  String get description =>
      '项目允许您保存特定文件夹的自定义设置。将创建一个 ".localizer" 文件夹以存储您的项目配置。';
  @override
  String get folderLabel => '项目文件夹';
  @override
  String get folderHint => '点击选择文件夹...';
  @override
  String get nameLabel => '项目名称';
  @override
  String get nameHint => '例如，My App Translations';
  @override
  String get selectFolderWarning => '请选择一个项目文件夹。';
  @override
  String get enterNameError => '请输入项目名称';
  @override
  String get nameLengthError => '名称必须至少 2 个字符';
  @override
  String success({required Object name}) => '项目 "${name}" 创建成功！';
  @override
  String get failure => '创建项目失败。';
  @override
  String get creating => '正在创建...';
  @override
  String get createAction => '创建项目';
}

// Path: projects.indicator
class _TranslationsProjectsIndicatorZhCn
    extends TranslationsProjectsIndicatorEn {
  _TranslationsProjectsIndicatorZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get tooltipNoProject => '创建一个项目以保存文件夹的自定义设置';
  @override
  String tooltipProject({required Object name}) => '项目：${name}\n点击查看选项';
  @override
  String get location => '位置';
  @override
  String get created => '创建时间';
  @override
  String get switchProject => '切换项目';
  @override
  String get done => '完成';
}

// Path: projects.glossary
class _TranslationsProjectsGlossaryZhCn extends TranslationsProjectsGlossaryEn {
  _TranslationsProjectsGlossaryZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '项目术语表';
  @override
  String get description => '定义应统一处理或从不翻译的术语。';
  @override
  String get noTerms => '暂无术语。';
  @override
  String get noTermsDesc => '添加应在翻译中保持一致的术语，\n或标记不应翻译的品牌名称。';
  @override
  String get doNotTranslate => '不翻译';
  @override
  String get noSpecificTranslation => '无特定翻译';
  @override
  String get addTerm => '添加术语';
  @override
  String get editTerm => '编辑术语';
  @override
  String get term => '术语';
  @override
  String get termHint => '例如，品牌名称，专业术语';
  @override
  String get definition => '定义 (可选)';
  @override
  String get definitionHint => '给译者的上下文';
  @override
  String get doNotTranslateLabel => '不翻译';
  @override
  String get doNotTranslateDesc => '在目标中保持术语完全不变';
  @override
  String get preferredTranslation => '首选翻译';
  @override
  String get caseSensitive => '区分大小写';
}

// Path: projects.conflicts
class _TranslationsProjectsConflictsZhCn
    extends TranslationsProjectsConflictsEn {
  _TranslationsProjectsConflictsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String missingApiKeyTitle({required Object service}) =>
      '缺少 ${service} 的 API 密钥';
  @override
  String missingApiKeyMessage({required Object service}) =>
      '此项目使用 ${service}，但未配置 API 密钥。请在 设置 > AI 服务 中添加您的 API 密钥，否则应用将使用全局默认值。';
  @override
  String get dismiss => '忽略';
}

// Path: projects.tm
class _TranslationsProjectsTmZhCn extends TranslationsProjectsTmEn {
  _TranslationsProjectsTmZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '翻译记忆库';
  @override
  String get description => '管理此项目的翻译记忆库来源。';
  @override
  String get globalTm => '全局翻译记忆库';
  @override
  String get globalTmDescription => '使用应用设置中的共享翻译记忆库';
  @override
  String get linkedFiles => '链接文件 (项目特定)';
  @override
  String get noLinkedFiles => '未链接项目特定文件。';
  @override
  String get addTmFile => '添加 TM 文件';
  @override
  String get useGlobalTm => '使用全局 TM';
  @override
  String get selectTm => '选择翻译记忆库';
  @override
  String get globalTmEnabled => '全局翻译记忆库已启用';
}

// Path: git.conflicts
class _TranslationsGitConflictsZhCn extends TranslationsGitConflictsEn {
  _TranslationsGitConflictsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '检测到合并冲突';
  @override
  String get description => '您必须在继续之前解决这些冲突。';
  @override
  String get abortMergeTitle => '终止合并？';
  @override
  String get abortMergeContent => '这将撤销所有合并更改并返回到合并前的状态。此操作无法撤销。';
  @override
  String get abortMergeAction => '终止合并';
  @override
  String stagingFile({required Object file}) => '正在暂存 ${file} 以提交...';
  @override
  String conflictedFilesCount({required Object count}) => '冲突文件 (${count})';
  @override
  String get selectFileToResolve => '选择文件以解决';
  @override
  String resolvingFile({required Object file}) => '正在解决：${file}';
  @override
  String get keepAllOurs => '保留所有当前 (Ours)';
  @override
  String get acceptAllTheirs => '接受所有传入 (Theirs)';
  @override
  String get allResolved => '此文件中的所有冲突已解决！';
  @override
  String get markResolved => '标记为已解决';
  @override
  String get stageForCommit => '这将暂存文件以进行提交。';
  @override
  String conflictIndex({required Object index}) => '冲突 #${index}';
  @override
  String get ours => 'OURS (当前)';
  @override
  String get theirs => 'THEIRS (传入)';
  @override
  String get keepOurs => '保留当前';
  @override
  String get acceptTheirs => '接受传入';
  @override
  String get empty => '(空)';
}

// Path: wizards.firstRun
class _TranslationsWizardsFirstRunZhCn extends TranslationsWizardsFirstRunEn {
  _TranslationsWizardsFirstRunZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get welcome => '欢迎使用 Localizer';
  @override
  String get description => '几秒钟内对比您的本地化文件。';
  @override
  String get sourceFile => '源文件';
  @override
  String get targetFile => '目标文件';
  @override
  String get compareNow => '立即对比';
  @override
  String get trySample => '尝试示例数据';
  @override
  String get skip => '跳过设置';
  @override
  String get browse => '点击浏览';
  @override
  String error({required Object error}) => '加载示例数据失败：${error}';
}

// Path: dialogs.addIgnorePattern
class _TranslationsDialogsAddIgnorePatternZhCn
    extends TranslationsDialogsAddIgnorePatternEn {
  _TranslationsDialogsAddIgnorePatternZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '添加忽略模式';
  @override
  String get patternLabel => '模式 (正则表达式)';
  @override
  String get hint => '例如，^temp_.*';
  @override
  String get invalid => '无效的正则表达式模式';
  @override
  String get testStringLabel => '测试字符串';
  @override
  String get testHint => '输入键以测试模式';
  @override
  String get match => '✓ 模式匹配测试字符串';
  @override
  String get noMatch => '✗ 模式不匹配';
  @override
  String get add => '添加';
  @override
  String get cancel => '取消';
}

// Path: dialogs.diffViewer
class _TranslationsDialogsDiffViewerZhCn
    extends TranslationsDialogsDiffViewerEn {
  _TranslationsDialogsDiffViewerZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '差异查看器';
  @override
  String get originalFile => '原始/参考文件';
  @override
  String get translationFile => '翻译/对比文件';
  @override
  String get base => 'BASE';
  @override
  String get target => 'TARGET';
  @override
  String get added => '新增';
  @override
  String get removed => '移除';
  @override
  String get modified => '修改';
  @override
  String get noMatches => '没有条目匹配当前过滤器';
  @override
  String get clickToggle => '点击上方徽章以切换过滤器';
  @override
  String get clickToHide => '(点击隐藏)';
  @override
  String get clickToShow => '(点击显示)';
}

// Path: grid.columns
class _TranslationsGridColumnsZhCn extends TranslationsGridColumnsEn {
  _TranslationsGridColumnsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get key => '键';
  @override
  String get source => '源';
  @override
  String get status => '状态';
  @override
  String get actions => '操作';
}

// Path: tutorial.steps
class _TranslationsTutorialStepsZhCn extends TranslationsTutorialStepsEn {
  _TranslationsTutorialStepsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTutorialStepsImportSourceZhCn importSource =
      _TranslationsTutorialStepsImportSourceZhCn._(_root);
  @override
  late final _TranslationsTutorialStepsImportTargetZhCn importTarget =
      _TranslationsTutorialStepsImportTargetZhCn._(_root);
  @override
  late final _TranslationsTutorialStepsCompareZhCn compare =
      _TranslationsTutorialStepsCompareZhCn._(_root);
  @override
  late final _TranslationsTutorialStepsFilterZhCn filter =
      _TranslationsTutorialStepsFilterZhCn._(_root);
  @override
  late final _TranslationsTutorialStepsSearchZhCn search =
      _TranslationsTutorialStepsSearchZhCn._(_root);
  @override
  late final _TranslationsTutorialStepsAdvancedZhCn advanced =
      _TranslationsTutorialStepsAdvancedZhCn._(_root);
  @override
  late final _TranslationsTutorialStepsExportZhCn export =
      _TranslationsTutorialStepsExportZhCn._(_root);
}

// Path: friendlyErrors.fileNotFound
class _TranslationsFriendlyErrorsFileNotFoundZhCn
    extends TranslationsFriendlyErrorsFileNotFoundEn {
  _TranslationsFriendlyErrorsFileNotFoundZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '无法找到该文件或文件夹。';
  @override
  String get suggestion => '请检查文件是否被移动或删除。';
}

// Path: friendlyErrors.accessDenied
class _TranslationsFriendlyErrorsAccessDeniedZhCn
    extends TranslationsFriendlyErrorsAccessDeniedEn {
  _TranslationsFriendlyErrorsAccessDeniedZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '访问文件被拒绝。';
  @override
  String get suggestion => '尝试以管理员身份运行应用或检查文件权限。';
}

// Path: friendlyErrors.isDirectory
class _TranslationsFriendlyErrorsIsDirectoryZhCn
    extends TranslationsFriendlyErrorsIsDirectoryEn {
  _TranslationsFriendlyErrorsIsDirectoryZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '选择的是文件夹而非文件。';
  @override
  String get suggestion => '请选择一个有效的文件。';
}

// Path: friendlyErrors.fileAccess
class _TranslationsFriendlyErrorsFileAccessZhCn
    extends TranslationsFriendlyErrorsFileAccessEn {
  _TranslationsFriendlyErrorsFileAccessZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '访问文件时出现问题。';
  @override
  String get suggestion => '尝试关闭可能正在使用该文件的其他程序。';
}

// Path: friendlyErrors.unsupportedFormat
class _TranslationsFriendlyErrorsUnsupportedFormatZhCn
    extends TranslationsFriendlyErrorsUnsupportedFormatEn {
  _TranslationsFriendlyErrorsUnsupportedFormatZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '不支持此文件格式或操作。';
  @override
  String get suggestion => '检查文件扩展名或尝试其他格式。';
}

// Path: friendlyErrors.networkError
class _TranslationsFriendlyErrorsNetworkErrorZhCn
    extends TranslationsFriendlyErrorsNetworkErrorEn {
  _TranslationsFriendlyErrorsNetworkErrorZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '无法连接到服务器。';
  @override
  String get suggestion => '检查您的互联网连接并重试。';
}

// Path: friendlyErrors.notGitRepo
class _TranslationsFriendlyErrorsNotGitRepoZhCn
    extends TranslationsFriendlyErrorsNotGitRepoEn {
  _TranslationsFriendlyErrorsNotGitRepoZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '此文件夹不是 Git 项目。';
  @override
  String get suggestion => '导航到包含 .git 目录的文件夹。';
}

// Path: friendlyErrors.mergeConflict
class _TranslationsFriendlyErrorsMergeConflictZhCn
    extends TranslationsFriendlyErrorsMergeConflictEn {
  _TranslationsFriendlyErrorsMergeConflictZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '仓库中存在合并冲突。';
  @override
  String get suggestion => '继续之前请解决冲突。';
}

// Path: friendlyErrors.gitAuthFailed
class _TranslationsFriendlyErrorsGitAuthFailedZhCn
    extends TranslationsFriendlyErrorsGitAuthFailedEn {
  _TranslationsFriendlyErrorsGitAuthFailedZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Git 验证失败。';
  @override
  String get suggestion => '请在 设置 > 版本控制 中检查您的凭据。';
}

// Path: friendlyErrors.gitOperationFailed
class _TranslationsFriendlyErrorsGitOperationFailedZhCn
    extends TranslationsFriendlyErrorsGitOperationFailedEn {
  _TranslationsFriendlyErrorsGitOperationFailedZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Git 操作失败。';
  @override
  String get suggestion => '查看 Git 视图以获取更多详细信息。';
}

// Path: friendlyErrors.invalidJson
class _TranslationsFriendlyErrorsInvalidJsonZhCn
    extends TranslationsFriendlyErrorsInvalidJsonEn {
  _TranslationsFriendlyErrorsInvalidJsonZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '文件格式无效或已损坏。';
  @override
  String get suggestion => '确保文件包含有效的 JSON 内容。';
}

// Path: friendlyErrors.rateLimitReached
class _TranslationsFriendlyErrorsRateLimitReachedZhCn
    extends TranslationsFriendlyErrorsRateLimitReachedEn {
  _TranslationsFriendlyErrorsRateLimitReachedZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '达到翻译限制。';
  @override
  String get suggestion => '请稍候几分钟或检查您的 API 计划限制。';
}

// Path: friendlyErrors.invalidApiKey
class _TranslationsFriendlyErrorsInvalidApiKeyZhCn
    extends TranslationsFriendlyErrorsInvalidApiKeyEn {
  _TranslationsFriendlyErrorsInvalidApiKeyZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '无效的 API 密钥。';
  @override
  String get suggestion => '前往 设置 > AI 翻译 更新您的 API 密钥。';
}

// Path: friendlyErrors.translationServiceError
class _TranslationsFriendlyErrorsTranslationServiceErrorZhCn
    extends TranslationsFriendlyErrorsTranslationServiceErrorEn {
  _TranslationsFriendlyErrorsTranslationServiceErrorZhCn._(
      TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '翻译服务错误。';
  @override
  String get suggestion => '检查您的 API 密钥和互联网连接。';
}

// Path: friendlyErrors.outOfMemory
class _TranslationsFriendlyErrorsOutOfMemoryZhCn
    extends TranslationsFriendlyErrorsOutOfMemoryEn {
  _TranslationsFriendlyErrorsOutOfMemoryZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '内存不足，无法完成此操作。';
  @override
  String get suggestion => '尝试关闭其他应用程序或使用更小的文件。';
}

// Path: friendlyErrors.genericError
class _TranslationsFriendlyErrorsGenericErrorZhCn
    extends TranslationsFriendlyErrorsGenericErrorEn {
  _TranslationsFriendlyErrorsGenericErrorZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get message => '出错了。';
  @override
  String get suggestion => '请重试。如果问题持续，请重启应用。';
}

// Path: settings.appearance.presets
class _TranslationsSettingsAppearancePresetsZhCn
    extends TranslationsSettingsAppearancePresetsEn {
  _TranslationsSettingsAppearancePresetsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get presetDefault => '默认';
  @override
  String get presetColorblind => '色盲友好';
  @override
  String get presetHighContrast => '高对比度';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.appearance.preview
class _TranslationsSettingsAppearancePreviewZhCn
    extends TranslationsSettingsAppearancePreviewEn {
  _TranslationsSettingsAppearancePreviewZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get step3Title => 'boarding.step3.title';
  @override
  String get connectAccount => '"关联您的账户"';
  @override
  String get loginHint => 'deprecated.login_hint_v1';
  @override
  String get enterCredentials => '"输入凭据"';
  @override
  String get ctaButton => 'checkout.cta_button';
  @override
  String get buyNow => '"立即购买"';
  @override
  String get completePurchase => '"完成购买"';
  @override
  String get appNameKey => 'common.app_name';
  @override
  String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class _TranslationsSettingsComparisonPatternPresetsZhCn
    extends TranslationsSettingsComparisonPatternPresetsEn {
  _TranslationsSettingsComparisonPatternPresetsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get comments => '注释';
  @override
  String get tempKeys => '临时键';
  @override
  String get placeholders => '占位符';
  @override
  String get devOnly => '仅开发';
}

// Path: settings.comparison.previewMatch
class _TranslationsSettingsComparisonPreviewMatchZhCn
    extends TranslationsSettingsComparisonPreviewMatchEn {
  _TranslationsSettingsComparisonPreviewMatchZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '预览匹配';
  @override
  String get description => '测试当前设置如何影响匹配逻辑。';
  @override
  String get stringA => '字符串 A';
  @override
  String get stringB => '字符串 B';
  @override
  String get enterText => '输入文本...';
  @override
  String get similarity => '相似度';
  @override
  String get identical => '相同';
  @override
  String get identicalDescription => '标准化后字符串完全匹配。';
  @override
  String get ignored => '已忽略';
  @override
  String get ignoredDescription => '输入匹配忽略模式。';
  @override
  String get different => '不同';
  @override
  String get differentDescription => '一个值为空。';
  @override
  String get similarModified => '相似 / 已修改';
  @override
  String similarModifiedDescription({required Object threshold}) =>
      '匹配得分高于阈值 (${threshold}%)。';
  @override
  String get newDifferent => '新增 / 不同';
  @override
  String newDifferentDescription({required Object threshold}) =>
      '匹配得分低于阈值 (${threshold}%)。';
}

// Path: settings.comparison.colorPresets
class _TranslationsSettingsComparisonColorPresetsZhCn
    extends TranslationsSettingsComparisonColorPresetsEn {
  _TranslationsSettingsComparisonColorPresetsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get kDefault => '默认';
  @override
  String get colorblindFriendly => '色盲友好';
  @override
  String get highContrast => '高对比度';
  @override
  String get nord => 'Nord';
  @override
  String get solarized => 'Solarized';
  @override
  String get monokai => 'Monokai';
  @override
  String get presetDefault => '默认';
  @override
  String get presetColorblind => '色盲友好';
  @override
  String get presetHighContrast => '高对比度';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.integrations.materials
class _TranslationsSettingsIntegrationsMaterialsZhCn
    extends TranslationsSettingsIntegrationsMaterialsEn {
  _TranslationsSettingsIntegrationsMaterialsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get sidebar => '侧边栏';
  @override
  String get menu => '菜单';
  @override
  String get popover => '弹出窗口';
  @override
  String get titlebar => '标题栏';
  @override
  String get underPageBackground => '页面背景下';
  @override
  String get contentBackground => '内容';
}

// Path: settings.integrations.fileTypes
class _TranslationsSettingsIntegrationsFileTypesZhCn
    extends TranslationsSettingsIntegrationsFileTypesEn {
  _TranslationsSettingsIntegrationsFileTypesZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get loc => 'Localizer 项目文件';
  @override
  String get lang => '语言文件';
  @override
  String get json => 'JSON 本地化文件';
  @override
  String get xml => 'XML 本地化文件';
}

// Path: settings.developer.themePlaygroundSection
class _TranslationsSettingsDeveloperThemePlaygroundSectionZhCn
    extends TranslationsSettingsDeveloperThemePlaygroundSectionEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionZhCn._(
      TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get colors => '颜色';
  @override
  String get typography => '排版';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteZhCn
      palette =
      _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteZhCn._(_root);
}

// Path: settings.developer.featureFlags
class _TranslationsSettingsDeveloperFeatureFlagsZhCn
    extends TranslationsSettingsDeveloperFeatureFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '实验性功能';
  @override
  String get description => '在本地切换功能标志以进行测试。这些覆盖在应用重启后仍然存在。';
  @override
  String get subtitle => '覆盖实验性功能';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsZhCn flags =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsZhCn._(_root);
  @override
  String get reset => '重置所有标志';
  @override
  String get overrides => '本地覆盖';
  @override
  String get defaultVal => '默认';
  @override
  String get on => '开';
  @override
  String get off => '关';
}

// Path: settings.developer.storageInspectorSection
class _TranslationsSettingsDeveloperStorageInspectorSectionZhCn
    extends TranslationsSettingsDeveloperStorageInspectorSectionEn {
  _TranslationsSettingsDeveloperStorageInspectorSectionZhCn._(
      TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => '刷新';
  @override
  String get hiveData => 'Hive 数据';
  @override
  String get secureStorage => '安全存储';
}

// Path: settings.developer.deviceInfoSection
class _TranslationsSettingsDeveloperDeviceInfoSectionZhCn
    extends TranslationsSettingsDeveloperDeviceInfoSectionEn {
  _TranslationsSettingsDeveloperDeviceInfoSectionZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => '刷新';
  @override
  String get copy => '复制到剪贴板';
  @override
  String get computerName => '计算机名称';
  @override
  String get osVersion => '系统版本';
}

// Path: settings.developer.localizationInspectorSection
class _TranslationsSettingsDeveloperLocalizationInspectorSectionZhCn
    extends TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
  _TranslationsSettingsDeveloperLocalizationInspectorSectionZhCn._(
      TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get showKeys => '显示键名代替值';
  @override
  String get keysVisible => '键可见';
  @override
  String get normalDisplay => '正常显示';
  @override
  String get note => '注意：此功能需要应用本地化使用遵循此设置的封装器。';
}

// Path: settings.onboarding.steps
class _TranslationsSettingsOnboardingStepsZhCn
    extends TranslationsSettingsOnboardingStepsEn {
  _TranslationsSettingsOnboardingStepsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsOnboardingStepsImportFilesZhCn importFiles =
      _TranslationsSettingsOnboardingStepsImportFilesZhCn._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsRunComparisonZhCn
      runComparison =
      _TranslationsSettingsOnboardingStepsRunComparisonZhCn._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsReviewMissingZhCn
      reviewMissing =
      _TranslationsSettingsOnboardingStepsReviewMissingZhCn._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsUseFiltersZhCn useFilters =
      _TranslationsSettingsOnboardingStepsUseFiltersZhCn._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsSearchResultsZhCn
      searchResults =
      _TranslationsSettingsOnboardingStepsSearchResultsZhCn._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsAdvancedViewZhCn advancedView =
      _TranslationsSettingsOnboardingStepsAdvancedViewZhCn._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsEditCellZhCn editCell =
      _TranslationsSettingsOnboardingStepsEditCellZhCn._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsExportResultsZhCn
      exportResults =
      _TranslationsSettingsOnboardingStepsExportResultsZhCn._(_root);
}

// Path: settings.settingsView.categories
class _TranslationsSettingsSettingsViewCategoriesZhCn
    extends TranslationsSettingsSettingsViewCategoriesEn {
  _TranslationsSettingsSettingsViewCategoriesZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get general => '常规设置';
  @override
  String get comparisonEngine => '对比引擎';
  @override
  String get appearance => '外观';
  @override
  String get fileHandling => '文件处理';
  @override
  String get aiServices => 'AI 服务';
  @override
  String get systemIntegrations => '系统集成';
  @override
  String get projectResources => '项目资源 (术语表 & TM)';
  @override
  String get developer => '开发者选项';
  @override
  String get about => '关于';
}

// Path: settings.settingsView.categoryLabels
class _TranslationsSettingsSettingsViewCategoryLabelsZhCn
    extends TranslationsSettingsSettingsViewCategoryLabelsEn {
  _TranslationsSettingsSettingsViewCategoryLabelsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get general => '常规';
  @override
  String get comparisonEngine => '对比';
  @override
  String get appearance => '外观';
  @override
  String get fileHandling => '文件处理';
  @override
  String get aiServices => 'AI 服务';
  @override
  String get systemIntegrations => '系统集成';
  @override
  String get projectResources => '项目资源';
  @override
  String get developer => '开发者选项';
  @override
  String get about => '关于';
}

// Path: advancedDiff.sidebar.actionsSection
class _TranslationsAdvancedDiffSidebarActionsSectionZhCn
    extends TranslationsAdvancedDiffSidebarActionsSectionEn {
  _TranslationsAdvancedDiffSidebarActionsSectionZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get exportMatches => '导出匹配项';
  @override
  String get preview => '预览';
  @override
  String get fillFromTmTitle => '从翻译记忆库填充？';
  @override
  String get fillFromTmContent => '这将尝试使用翻译记忆库中的匹配项填充空的目标值。现有值不会被覆盖。';
  @override
  String get fill => '填充';
  @override
  String get fillFromMemory => '从记忆库填充';
  @override
  String filledFromTm({required Object count}) => '已从翻译记忆库填充 ${count} 个项目。';
}

// Path: advancedDiff.sidebar.aiSection
class _TranslationsAdvancedDiffSidebarAiSectionZhCn
    extends TranslationsAdvancedDiffSidebarAiSectionEn {
  _TranslationsAdvancedDiffSidebarAiSectionZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get infoCloud => '使用云翻译将源文本翻译为空目标值。';
  @override
  String get infoAi => '使用 AI 将源文本翻译为空目标值。';
  @override
  String get translationSettings => '翻译设置';
  @override
  String get aiSettings => 'AI 设置';
  @override
  String get source => '源';
  @override
  String get target => '目标';
  @override
  String translatingProgress({required Object percent}) => '翻译中... ${percent}%';
  @override
  String get translating => '翻译中...';
  @override
  String get translateAllMissing => '翻译所有缺失项';
  @override
  String get translateAllTitle => '翻译所有缺失项？';
  @override
  String translateAllContent(
          {required Object service,
          required Object source,
          required Object target}) =>
      '这将使用 ${service} 将所有目标值为空的条目从 ${source} 翻译为 ${target}。\n\n您可以逐个审核建议或一次性全部应用。';
  @override
  String get translateAll => '全部翻译';
  @override
  String get reviewEach => '逐个审核';
  @override
  String cloudTranslated({required Object count}) => '使用云翻译翻译了 ${count} 个条目。';
  @override
  String aiTranslated({required Object count}) => '使用 AI 翻译了 ${count} 个条目。';
  @override
  String get aiTranslateFailed => 'AI 全部翻译失败';
  @override
  String get noMissingEntries => '没有缺失条目可翻译。';
  @override
  String get skip => '跳过';
  @override
  String get stop => '停止';
  @override
  String cloudApplied({required Object count}) => '应用了 ${count} 个建议。';
  @override
  String aiApplied({required Object count}) => '应用了 ${count} 个 AI 建议。';
}

// Path: advancedDiff.sidebar.tmSection
class _TranslationsAdvancedDiffSidebarTmSectionZhCn
    extends TranslationsAdvancedDiffSidebarTmSectionEn {
  _TranslationsAdvancedDiffSidebarTmSectionZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get enableTmFill => '启用 TM 填充';
  @override
  String get autoApplyAboveMinimum => '高于最低值自动应用';
  @override
  String get matchSettings => '匹配设置';
  @override
  String get minMatch => '最低匹配：';
  @override
  String get limit => '限制：';
  @override
  String get exact => '完全';
}

// Path: advancedDiff.sidebar.filtersSection
class _TranslationsAdvancedDiffSidebarFiltersSectionZhCn
    extends TranslationsAdvancedDiffSidebarFiltersSectionEn {
  _TranslationsAdvancedDiffSidebarFiltersSectionZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get viewFilters => '视图过滤器';
  @override
  String get showAll => '显示全部';
  @override
  String get added => '新增';
  @override
  String get removed => '移除';
  @override
  String get modified => '已修改';
  @override
  String get actionScope => '操作范围';
  @override
  String get applyToAdded => '应用于新增';
  @override
  String get applyToModified => '应用于已修改';
  @override
  String get onlyFillEmptyTargets => '仅填充空目标';
  @override
  String get limitToVisible => '限制为可见';
  @override
  String get editMode => '编辑模式';
  @override
  String get dialog => '对话框';
  @override
  String get inline => '行内';
}

// Path: advancedDiff.sidebar.similaritySection
class _TranslationsAdvancedDiffSidebarSimilaritySectionZhCn
    extends TranslationsAdvancedDiffSidebarSimilaritySectionEn {
  _TranslationsAdvancedDiffSidebarSimilaritySectionZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get currentFilter => '当前过滤器：';
  @override
  String get any => '任意';
  @override
  String get high => '高';
  @override
  String get medium => '中';
  @override
  String get low => '低';
}

// Path: advancedDiff.sidebar.statusSection
class _TranslationsAdvancedDiffSidebarStatusSectionZhCn
    extends TranslationsAdvancedDiffSidebarStatusSectionEn {
  _TranslationsAdvancedDiffSidebarStatusSectionZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String total({required Object count}) => '${count} 总计';
  @override
  String extra({required Object count}) => '${count} 额外';
  @override
  String missing({required Object count}) => '${count} 缺失';
  @override
  String changed({required Object count}) => '${count} 修改';
}

// Path: tutorial.steps.importSource
class _TranslationsTutorialStepsImportSourceZhCn
    extends TranslationsTutorialStepsImportSourceEn {
  _TranslationsTutorialStepsImportSourceZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '1. 导入源文件';
  @override
  String get description => '使用下方按钮浏览文件，或拖放到高亮区域。';
}

// Path: tutorial.steps.importTarget
class _TranslationsTutorialStepsImportTargetZhCn
    extends TranslationsTutorialStepsImportTargetEn {
  _TranslationsTutorialStepsImportTargetZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '2. 导入目标文件';
  @override
  String get description => '使用下方按钮浏览文件，或拖放到高亮区域。';
}

// Path: tutorial.steps.compare
class _TranslationsTutorialStepsCompareZhCn
    extends TranslationsTutorialStepsCompareEn {
  _TranslationsTutorialStepsCompareZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '3. 对比文件';
  @override
  String get description => '点击下方按钮运行对比并查看结果。';
}

// Path: tutorial.steps.filter
class _TranslationsTutorialStepsFilterZhCn
    extends TranslationsTutorialStepsFilterEn {
  _TranslationsTutorialStepsFilterZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '4. 过滤结果';
  @override
  String get description => '使用这些过滤器查看新增、移除或修改的字符串。';
}

// Path: tutorial.steps.search
class _TranslationsTutorialStepsSearchZhCn
    extends TranslationsTutorialStepsSearchEn {
  _TranslationsTutorialStepsSearchZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '5. 搜索结果';
  @override
  String get description => '使用搜索栏查找特定键或值。';
}

// Path: tutorial.steps.advanced
class _TranslationsTutorialStepsAdvancedZhCn
    extends TranslationsTutorialStepsAdvancedEn {
  _TranslationsTutorialStepsAdvancedZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '6. 高级视图';
  @override
  String get description => '打开详细差异视图，支持编辑、AI 翻译等功能。';
}

// Path: tutorial.steps.export
class _TranslationsTutorialStepsExportZhCn
    extends TranslationsTutorialStepsExportEn {
  _TranslationsTutorialStepsExportZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '7. 导出结果';
  @override
  String get description => '将您的对比结果保存为 CSV、JSON 或 Excel 文件。';
}

// Path: settings.developer.themePlaygroundSection.palette
class _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteZhCn
    extends TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteZhCn._(
      TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get primary => '主要';
  @override
  String get onPrimary => '主要之上';
  @override
  String get secondary => '次要';
  @override
  String get onSecondary => '次要之上';
  @override
  String get surface => '表面';
  @override
  String get onSurface => '表面之上';
  @override
  String get error => '错误';
  @override
  String get onError => '错误之上';
  @override
  String get outline => '轮廓';
  @override
  String get shadow => '阴影';
  @override
  String get success => '成功';
  @override
  String get warning => '警告';
  @override
  String get info => '信息';
}

// Path: settings.developer.featureFlags.flags
class _TranslationsSettingsDeveloperFeatureFlagsFlagsZhCn
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchZhCn
      experimental_ai_batch =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchZhCn._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmZhCn
      new_diff_algorithm =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmZhCn._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchZhCn
      enhanced_search =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchZhCn._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveZhCn
      auto_save =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveZhCn._(_root);
}

// Path: settings.onboarding.steps.importFiles
class _TranslationsSettingsOnboardingStepsImportFilesZhCn
    extends TranslationsSettingsOnboardingStepsImportFilesEn {
  _TranslationsSettingsOnboardingStepsImportFilesZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '导入文件';
  @override
  String get description => '加载源文件和目标文件';
}

// Path: settings.onboarding.steps.runComparison
class _TranslationsSettingsOnboardingStepsRunComparisonZhCn
    extends TranslationsSettingsOnboardingStepsRunComparisonEn {
  _TranslationsSettingsOnboardingStepsRunComparisonZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '运行比较';
  @override
  String get description => '点击 "比较文件"';
}

// Path: settings.onboarding.steps.reviewMissing
class _TranslationsSettingsOnboardingStepsReviewMissingZhCn
    extends TranslationsSettingsOnboardingStepsReviewMissingEn {
  _TranslationsSettingsOnboardingStepsReviewMissingZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '查看缺失键';
  @override
  String get description => '注意红色的 "MISSING" 项目';
}

// Path: settings.onboarding.steps.useFilters
class _TranslationsSettingsOnboardingStepsUseFiltersZhCn
    extends TranslationsSettingsOnboardingStepsUseFiltersEn {
  _TranslationsSettingsOnboardingStepsUseFiltersZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '使用过滤器';
  @override
  String get description => '按类型过滤';
}

// Path: settings.onboarding.steps.searchResults
class _TranslationsSettingsOnboardingStepsSearchResultsZhCn
    extends TranslationsSettingsOnboardingStepsSearchResultsEn {
  _TranslationsSettingsOnboardingStepsSearchResultsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '搜索结果';
  @override
  String get description => '查找特定键';
}

// Path: settings.onboarding.steps.advancedView
class _TranslationsSettingsOnboardingStepsAdvancedViewZhCn
    extends TranslationsSettingsOnboardingStepsAdvancedViewEn {
  _TranslationsSettingsOnboardingStepsAdvancedViewZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '高级视图';
  @override
  String get description => '探索详细分析';
}

// Path: settings.onboarding.steps.editCell
class _TranslationsSettingsOnboardingStepsEditCellZhCn
    extends TranslationsSettingsOnboardingStepsEditCellEn {
  _TranslationsSettingsOnboardingStepsEditCellZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '编辑单元格';
  @override
  String get description => '点击编辑值';
}

// Path: settings.onboarding.steps.exportResults
class _TranslationsSettingsOnboardingStepsExportResultsZhCn
    extends TranslationsSettingsOnboardingStepsExportResultsEn {
  _TranslationsSettingsOnboardingStepsExportResultsZhCn._(TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '导出';
  @override
  String get description => '保存您的报告';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchZhCn
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchZhCn._(
      TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get name => '实验性 AI 批处理';
  @override
  String get description => '启用多行 AI 翻译批处理';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmZhCn
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmZhCn._(
      TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get name => '新对比算法';
  @override
  String get description => '使用改进的对比算法';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchZhCn
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchZhCn._(
      TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get name => '增强搜索';
  @override
  String get description => '启用翻译文件模糊搜索';
}

// Path: settings.developer.featureFlags.flags.auto_save
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveZhCn
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveZhCn._(
      TranslationsZhCn root)
      : this._root = root,
        super.internal(root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get name => '自动保存';
  @override
  String get description => '编辑后自动保存更改';
}

/// The flat map containing all translations for locale <zh-CN>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhCn {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
          'app.title' => '本地化对比工具',
          'app.name' => 'Localizer',
          'common.save' => '保存',
          'common.cancel' => '取消',
          'common.close' => '关闭',
          'common.delete' => '删除',
          'common.edit' => '编辑',
          'common.add' => '添加',
          'common.search' => '搜索',
          'common.undo' => '撤销',
          'common.loading' => '加载中...',
          'common.error' => '错误',
          'common.success' => '成功',
          'common.warning' => '警告',
          'common.info' => '信息',
          'common.confirm' => '确认',
          'common.yes' => '是',
          'common.no' => '否',
          'common.ok' => '确定',
          'common.retry' => '重试',
          'common.copyText' => '复制',
          'common.appName' => 'Localizer',
          'common.copied' => '已复制!',
          'common.enabled' => '已启用',
          'common.disabled' => '已禁用',
          'common.browse' => '浏览',
          'common.clear' => '清除',
          'common.apply' => '应用',
          'common.reset' => '重置',
          'common.refresh' => '刷新',
          'common.export' => '导出',
          'common.import' => '导入',
          'common.select' => '选择',
          'common.selectAll' => '全选',
          'common.deselectAll' => '取消全选',
          'common.noResults' => '未找到结果',
          'common.emptyState' => '暂无内容',
          'common.open' => '打开',
          'common.change' => '更改',
          'common.original' => '原始',
          'common.kNew' => '新',
          'common.remove' => '移除',
          'common.auto' => '自动',
          'common.execute' => '执行',
          'common.run' => '运行',
          'common.unknown' => '未知',
          'common.download' => '下载',
          'common.dropdownArrow' => '下拉箭头',
          'common.openInNewWindow' => '在新窗口中打开',
          'common.resetToDefaults' => '恢复默认设置',
          'menu.file' => '文件',
          'menu.edit' => '编辑',
          'menu.view' => '视图',
          'menu.help' => '帮助',
          'menu.openFiles' => '打开文件...',
          'menu.openFolder' => '打开文件夹...',
          'menu.exportResults' => '导出结果...',
          'menu.undo' => '撤销',
          'menu.redo' => '重做',
          'menu.cut' => '剪切',
          'menu.paste' => '粘贴',
          'menu.selectAll' => '全选',
          'menu.zoomIn' => '放大',
          'menu.zoomOut' => '缩小',
          'menu.resetZoom' => '重置缩放',
          'menu.documentation' => '文档',
          'menu.reportIssue' => '报告问题',
          'menu.about' => ({required Object appName}) => '关于 ${appName}',
          'nav.compare' => '比较',
          'nav.history' => '历史',
          'nav.settings' => '设置',
          'nav.projects' => '项目',
          'nav.dashboard' => '仪表盘',
          'nav.directory' => '目录',
          'nav.repository' => '仓库',
          'nav.tooltipCompare' => '比较本地化文件',
          'nav.tooltipHistory' => '查看比较历史',
          'nav.tooltipSettings' => '应用设置',
          'nav.tooltipProjects' => '管理项目',
          'nav.tooltipThemeToggle' => '切换主题',
          'nav.tooltipDebugConsole' => '调试控制台',
          'settings.title' => '设置',
          'settings.appSettings' => '应用设置',
          'settings.projectSettings' => '项目设置',
          'settings.appearance.title' => '外观',
          'settings.appearance.description' => '自定义应用的外观和感觉',
          'settings.appearance.theme' => '主题模式',
          'settings.appearance.themeDescription' => '选择明亮、暗黑或跟随系统',
          'settings.appearance.themeSystem' => '跟随系统',
          'settings.appearance.themeLight' => '明亮',
          'settings.appearance.themeDark' => '暗黑',
          'settings.appearance.themeAmoled' => 'AMOLED',
          'settings.appearance.accentColor' => '强调色',
          'settings.appearance.accentColorDescription' => '选择您喜欢的强调色',
          'settings.appearance.useMicaEffect' => '使用云母效果',
          'settings.appearance.micaDescription' =>
            '启用 Windows 11 云母半透明效果，获得现代外观',
          'settings.appearance.diffFontSize' => '对比字体大小',
          'settings.appearance.diffFontSizeDescription' => '调整对比视图的字体大小',
          'settings.appearance.diffFontFamily' => '对比字体',
          'settings.appearance.diffFontFamilyDescription' => '对比视图使用的字体',
          'settings.appearance.systemDefault' => '系统默认',
          'settings.appearance.pickAccentColor' => '选择强调色',
          'settings.appearance.diffColors' => '对比颜色',
          'settings.appearance.presetsTitle' => '预设',
          'settings.appearance.presets.presetDefault' => '默认',
          'settings.appearance.presets.presetColorblind' => '色盲友好',
          'settings.appearance.presets.presetHighContrast' => '高对比度',
          'settings.appearance.presets.presetNord' => 'Nord',
          'settings.appearance.presets.presetSolarized' => 'Solarized',
          'settings.appearance.presets.presetMonokai' => 'Monokai',
          'settings.appearance.identical' => '相同',
          'settings.appearance.pickColorFor' => ({required Object label}) =>
              '选择 ${label} 的颜色',
          'settings.appearance.livePreview' => '实时预览',
          'settings.appearance.preview.step3Title' => 'boarding.step3.title',
          'settings.appearance.preview.connectAccount' => '"关联您的账户"',
          'settings.appearance.preview.loginHint' => 'deprecated.login_hint_v1',
          'settings.appearance.preview.enterCredentials' => '"输入凭据"',
          'settings.appearance.preview.ctaButton' => 'checkout.cta_button',
          'settings.appearance.preview.buyNow' => '"立即购买"',
          'settings.appearance.preview.completePurchase' => '"完成购买"',
          'settings.appearance.preview.appNameKey' => 'common.app_name',
          'settings.appearance.preview.appNameValue' => '"Localizer"',
          'settings.general.title' => '常规',
          'settings.general.description' => '常规应用设置',
          'settings.general.language' => '语言',
          'settings.general.languageDescription' => '选择您的首选语言',
          'settings.general.startMinimized' => '启动时最小化到托盘',
          'settings.general.startMinimizedDescription' => '应用启动时最小化到系统托盘',
          'settings.general.rememberWindowPosition' => '记住窗口位置',
          'settings.general.rememberWindowPositionDescription' =>
            '启动时恢复窗口大小和位置',
          'settings.general.openLastProject' => '启动时打开上一个项目',
          'settings.general.openLastProjectDescription' => '应用启动时自动打开上次使用的项目',
          'settings.general.application' => '应用',
          'settings.general.defaultView' => '默认视图',
          'settings.general.defaultViewDescription' => '启动时显示的视图',
          'settings.general.autoCheckUpdates' => '自动检查更新',
          'settings.general.autoCheckUpdatesDescription' => '启动时检查更新',
          'settings.general.startupOptions' => '启动选项',
          'settings.general.languageAuto' => '自动检测',
          'settings.general.viewBasic' => '文件对比',
          'settings.general.viewHistory' => '历史记录',
          'settings.general.viewDashboard' => '质量仪表盘',
          'settings.general.viewDirectory' => '目录对比',
          'settings.general.viewLastUsed' => '上次使用的视图',
          'settings.scope.title' => '设置范围',
          'settings.scope.global' => '全局默认',
          'settings.scope.project' => '项目',
          'settings.scope.reset' => '重置项目为全局默认',
          'settings.scope.resetConfirmation' =>
            '这将清除该项目的所有覆盖设置并恢复为全局默认值。此操作无法撤销。',
          'settings.scope.globalDescription' => '更改适用于所有项目，除非被覆盖。',
          'settings.scope.projectDescription' => ({required Object name}) =>
              '更改仅适用于 "${name}"。其他设置继承自全局默认值。',
          'settings.scope.createPrompt' => '创建一个项目以自定义特定文件夹的设置',
          'settings.searchKeywords.general.0' => '语言',
          'settings.searchKeywords.general.1' => '默认视图',
          'settings.searchKeywords.general.2' => '最近文件数量',
          'settings.searchKeywords.general.3' => '打开上一个项目',
          'settings.searchKeywords.general.4' => '退出前确认',
          'settings.searchKeywords.general.5' => '显示通知',
          'settings.searchKeywords.comparisonEngine.0' => '对比模式',
          'settings.searchKeywords.comparisonEngine.1' => '相似度阈值',
          'settings.searchKeywords.comparisonEngine.2' => '区分大小写',
          'settings.searchKeywords.comparisonEngine.3' => '忽略空白',
          'settings.searchKeywords.comparisonEngine.4' => '忽略空行',
          'settings.searchKeywords.comparisonEngine.5' => '忽略注释',
          'settings.searchKeywords.comparisonEngine.6' => '忽略模式',
          'settings.searchKeywords.appearance.0' => '主题',
          'settings.searchKeywords.appearance.1' => '主题模式',
          'settings.searchKeywords.appearance.2' => '强调色',
          'settings.searchKeywords.appearance.3' => '对比字体大小',
          'settings.searchKeywords.appearance.4' => '对比字体',
          'settings.searchKeywords.appearance.5' => '对比颜色',
          'settings.searchKeywords.appearance.6' => '新增颜色',
          'settings.searchKeywords.appearance.7' => '删除颜色',
          'settings.searchKeywords.appearance.8' => '修改颜色',
          'settings.searchKeywords.appearance.9' => '相同颜色',
          'settings.searchKeywords.appearance.10' => '颜色预设',
          'settings.searchKeywords.appearance.11' => '预览',
          'settings.searchKeywords.fileHandling.0' => '源格式',
          'settings.searchKeywords.fileHandling.1' => '目标格式',
          'settings.searchKeywords.fileHandling.2' => '默认编码',
          'settings.searchKeywords.fileHandling.3' => '最近项目数量',
          'settings.searchKeywords.fileHandling.4' => '翻译记忆库',
          'settings.searchKeywords.fileHandling.5' => '导入记忆库',
          'settings.searchKeywords.fileHandling.6' => '导出记忆库',
          'settings.searchKeywords.fileHandling.7' => '清除记忆库',
          'settings.searchKeywords.aiServices.0' => 'OpenAI API 密钥',
          'settings.searchKeywords.aiServices.1' => 'Anthropic API 密钥',
          'settings.searchKeywords.aiServices.2' => 'Google AI API 密钥',
          'settings.searchKeywords.aiServices.3' => 'AI 模型',
          'settings.searchKeywords.aiServices.4' => '温度',
          'settings.searchKeywords.aiServices.5' => '自定义提示词',
          'settings.searchKeywords.systemIntegrations.0' => '系统托盘',
          'settings.searchKeywords.systemIntegrations.1' => '启动最小化',
          'settings.searchKeywords.systemIntegrations.2' => '文件关联',
          'settings.searchKeywords.systemIntegrations.3' => '云母效果',
          'settings.searchKeywords.systemIntegrations.4' => '特效',
          'settings.searchKeywords.systemIntegrations.5' => '窗口材质',
          'settings.searchKeywords.systemIntegrations.6' => 'Dock 徽章',
          'settings.searchKeywords.systemIntegrations.7' => '未翻译计数',
          'settings.searchKeywords.projectResources.0' => '术语表',
          'settings.searchKeywords.projectResources.1' => '翻译记忆库',
          'settings.searchKeywords.projectResources.2' => '术语',
          'settings.searchKeywords.about.0' => '版本',
          'settings.searchKeywords.about.1' => '检查更新',
          'settings.searchKeywords.about.2' => '自动更新',
          'settings.searchKeywords.about.3' => '更新日志',
          'settings.searchKeywords.about.4' => '许可证',
          'settings.searchKeywords.about.5' => '隐私政策',
          'settings.searchKeywords.about.6' => '遥测',
          'settings.searchKeywords.about.7' => '崩溃报告',
          'settings.searchKeywords.developer.0' => '性能浮层',
          'settings.searchKeywords.developer.1' => '语义调试器',
          'settings.searchKeywords.developer.2' => 'Material 网格',
          'settings.searchKeywords.developer.3' => '光栅缓存',
          'settings.searchKeywords.developer.4' => '重启教程',
          'settings.searchKeywords.developer.5' => '恢复出厂设置',
          'settings.comparison.title' => '对比',
          'settings.comparison.description' => '配置对比行为',
          'settings.comparison.caseSensitive' => '区分大小写',
          'settings.comparison.caseSensitiveDescription' => '将大写和小写字母视为不同',
          'settings.comparison.ignoreWhitespace' => '忽略空白',
          'settings.comparison.ignoreWhitespaceDescription' => '对比时忽略前导/尾随空白',
          'settings.comparison.showLineNumbers' => '显示行号',
          'settings.comparison.showLineNumbersDescription' => '在对比视图中显示行号',
          'settings.comparison.behavior' => '对比行为',
          'settings.comparison.ignoreCase' => '忽略大小写',
          'settings.comparison.ignoreCaseDescription' => '将 "Key" 和 "key" 视为相同',
          'settings.comparison.similarityThreshold' => '相似度阈值',
          'settings.comparison.similarityThresholdDescription' =>
            '检测 "已修改" 的最低相似度',
          'settings.comparison.mode' => '对比模式',
          'settings.comparison.modeDescription' => '如何在文件之间匹配条目',
          'settings.comparison.modeKey' => '基于键',
          'settings.comparison.modeKeyDescription' => '通过键名匹配（默认）。',
          'settings.comparison.modeOrder' => '基于顺序',
          'settings.comparison.modeOrderDescription' => '通过在文件中的位置匹配。',
          'settings.comparison.modeSmart' => '智能匹配',
          'settings.comparison.modeSmartDescription' => '检测移动/重命名的键。',
          'settings.comparison.ignorePatterns' => '忽略模式',
          'settings.comparison.noIgnorePatterns' => '未设置忽略模式。',
          'settings.comparison.addPattern' => '添加模式',
          'settings.comparison.resetToGlobal' => '重置所有对比设置为全局默认值',
          'settings.comparison.patternPresets.comments' => '注释',
          'settings.comparison.patternPresets.tempKeys' => '临时键',
          'settings.comparison.patternPresets.placeholders' => '占位符',
          'settings.comparison.patternPresets.devOnly' => '仅开发',
          'settings.comparison.previewMatch.title' => '预览匹配',
          'settings.comparison.previewMatch.description' => '测试当前设置如何影响匹配逻辑。',
          'settings.comparison.previewMatch.stringA' => '字符串 A',
          'settings.comparison.previewMatch.stringB' => '字符串 B',
          'settings.comparison.previewMatch.enterText' => '输入文本...',
          'settings.comparison.previewMatch.similarity' => '相似度',
          'settings.comparison.previewMatch.identical' => '相同',
          'settings.comparison.previewMatch.identicalDescription' =>
            '标准化后字符串完全匹配。',
          'settings.comparison.previewMatch.ignored' => '已忽略',
          'settings.comparison.previewMatch.ignoredDescription' => '输入匹配忽略模式。',
          'settings.comparison.previewMatch.different' => '不同',
          'settings.comparison.previewMatch.differentDescription' => '一个值为空。',
          'settings.comparison.previewMatch.similarModified' => '相似 / 已修改',
          'settings.comparison.previewMatch.similarModifiedDescription' =>
            ({required Object threshold}) => '匹配得分高于阈值 (${threshold}%)。',
          'settings.comparison.previewMatch.newDifferent' => '新增 / 不同',
          'settings.comparison.previewMatch.newDifferentDescription' =>
            ({required Object threshold}) => '匹配得分低于阈值 (${threshold}%)。',
          'settings.comparison.colorPresets.kDefault' => '默认',
          'settings.comparison.colorPresets.colorblindFriendly' => '色盲友好',
          'settings.comparison.colorPresets.highContrast' => '高对比度',
          'settings.comparison.colorPresets.nord' => 'Nord',
          'settings.comparison.colorPresets.solarized' => 'Solarized',
          'settings.comparison.colorPresets.monokai' => 'Monokai',
          'settings.comparison.colorPresets.presetDefault' => '默认',
          'settings.comparison.colorPresets.presetColorblind' => '色盲友好',
          'settings.comparison.colorPresets.presetHighContrast' => '高对比度',
          'settings.comparison.colorPresets.presetNord' => 'Nord',
          'settings.comparison.colorPresets.presetSolarized' => 'Solarized',
          'settings.comparison.colorPresets.presetMonokai' => 'Monokai',
          'settings.fileHandling.fileFormats' => '文件格式',
          'settings.fileHandling.sourceFormat' => '源格式',
          'settings.fileHandling.targetFormat' => '目标格式',
          'settings.fileHandling.encoding' => '编码',
          'settings.fileHandling.sourceEncoding' => '源编码',
          'settings.fileHandling.targetEncoding' => '目标编码',
          'settings.fileHandling.autoDetect' => '自动检测',
          'settings.fileHandling.autoDetectEncodingDescription' => '自动检测文件编码',
          'settings.fileHandling.exportSettings' => '导出设置',
          'settings.fileHandling.defaultExportFormat' => '默认导出格式',
          'settings.fileHandling.includeUtf8Bom' => '包含 UTF-8 BOM',
          'settings.fileHandling.includeUtf8BomDescription' => 'Excel 兼容性所需',
          'settings.fileHandling.openFolderAfterExport' => '导出后打开文件夹',
          'settings.fileHandling.fileSafety' => '文件安全',
          'settings.fileHandling.fileSafetyDescription' => '自动为灾难恢复创建本地副本。',
          'settings.fileHandling.resetToGlobal' => '重置所有文件处理设置为全局默认值',
          'settings.translationMemory.title' => '全局翻译记忆库',
          'settings.translationMemory.autoLearn' => '自动学习',
          'settings.translationMemory.autoLearnDescription' =>
            '将翻译保存到本地记忆库以供将来重复使用',
          'settings.translationMemory.confidenceThreshold' => '置信度阈值',
          'settings.translationMemory.confidenceThresholdDescription' =>
            ({required Object percent}) => '自动应用的最低分数 (${percent}%)',
          'settings.translationMemory.entries' => '条目',
          'settings.translationMemory.size' => '大小',
          'settings.translationMemory.memorySize' => ({required Object size}) =>
              '记忆库大小：${size}',
          'settings.translationMemory.import' => '导入',
          'settings.translationMemory.exportTmx' => '导出 TMX',
          'settings.translationMemory.exportCsv' => '导出 CSV',
          'settings.translationMemory.clearMemory' => '清除记忆库',
          'settings.translationMemory.importedItems' =>
            ({required Object count}) => '已将 ${count} 个项目导入记忆库。',
          'settings.translationMemory.noItemsAdded' => '未添加任何项目。',
          'settings.translationMemory.nothingToExport' => '暂无内容可导出。',
          'settings.translationMemory.tmxSaved' => 'TMX 已保存',
          'settings.translationMemory.csvSaved' => 'CSV 已保存',
          'settings.translationMemory.clearConfirmTitle' => '清除翻译记忆库？',
          'settings.translationMemory.clearConfirmContent' =>
            '这将删除此设备上所有保存的翻译对。此操作无法撤销。',
          'settings.translationMemory.cleared' => '翻译记忆库已清除。',
          'settings.translationMemory.couldNotClear' => '无法清除记忆库。',
          'settings.backup.title' => '自动备份',
          'settings.backup.description' => '自动备份设置',
          'settings.backup.enabled' => '启用自动备份',
          'settings.backup.enabledDescription' => '在进行更改前自动备份文件',
          'settings.backup.maxCopies' => '最大备份副本数',
          'settings.backup.maxCopiesDescription' => '每个为文件保留的备份副本数量',
          'settings.backup.activeStatus' => ({required Object count}) =>
              '激活 · 保留 ${count} 个副本',
          'settings.backup.folder' => '备份文件夹',
          'settings.backup.folderDescription' => '留空以使用相同文件夹',
          'settings.backup.useOriginalFolder' => '使用原始文件文件夹',
          'settings.ai.title' => 'AI 服务',
          'settings.ai.description' => '配置 AI 翻译和辅助',
          'settings.ai.provider' => 'AI 提供商',
          'settings.ai.providerDescription' => '选择您首选的 AI 服务提供商',
          'settings.ai.apiKey' => 'API 密钥',
          'settings.ai.apiKeyDescription' => '输入所选提供商的 API 密钥',
          'settings.ai.apiKeyPlaceholder' => '输入 API 密钥...',
          'settings.ai.testConnection' => '测试连接',
          'settings.ai.connectionSuccess' => '连接成功！',
          'settings.ai.connectionFailed' => '连接失败。请检查您的 API 密钥。',
          'settings.ai.translationStrategy' => '翻译策略',
          'settings.ai.strategy' => '策略',
          'settings.ai.strategyDescription' => '选择您希望如何翻译字符串',
          'settings.ai.strategyLLM' => '生成式 AI (LLM)',
          'settings.ai.strategyCloud' => '云翻译',
          'settings.ai.enableAiTranslation' => '启用 AI 翻译',
          'settings.ai.enableAiTranslationDescription' => '允许应用使用 AI 进行翻译建议',
          'settings.ai.llmProvider' => 'LLM 服务提供商',
          'settings.ai.service' => '服务',
          'settings.ai.serviceDescription' => '生成式 AI 提供商',
          'settings.ai.providerGemini' => 'Google Gemini',
          'settings.ai.providerOpenAI' => 'OpenAI',
          'settings.ai.geminiApiKey' => 'Gemini API 密钥',
          'settings.ai.openAiApiKey' => 'OpenAI API 密钥',
          'settings.ai.model' => '模型',
          'settings.ai.modelDescription' => '选择使用的模型',
          'settings.ai.advancedParameters' => '高级参数',
          'settings.ai.parameters' => '参数',
          'settings.ai.parametersDescription' => '温度、上下文及更多',
          'settings.ai.temperature' => '温度',
          'settings.ai.temperatureDescription' => '较高的值使输出更具创造性',
          'settings.ai.maxTokens' => '最大 Tokens',
          'settings.ai.maxTokensDescription' => '限制上下文窗口长度',
          'settings.ai.systemContext' => '系统上下文 / 指令',
          'settings.ai.systemContextHint' => '你是一名专业的本地化人员。保持源字符串的语气和意图...',
          'settings.ai.systemContextHelper' => '向 AI 提供有关项目风格和术语的具体说明。',
          'settings.ai.contextStrings' => '上下文字符串',
          'settings.ai.contextStringsDescription' => '包含周围的字符串以获得更好的上下文',
          'settings.ai.contextCount' => '上下文数量',
          'settings.ai.contextCountDescription' => '包含的周围字符串数量',
          'settings.ai.cloudServices' => '云翻译服务',
          'settings.ai.googleTranslateApiKey' => 'Google 翻译 API 密钥',
          'settings.ai.deeplApiKey' => 'DeepL API 密钥',
          'settings.ai.test' => '测试',
          'settings.ai.resetToGlobal' => '重置所有 AI 设置为全局默认值',
          'settings.integrations.platformNotice' => '平台通知',
          'settings.integrations.platformNoticeDescription' => '该平台不支持系统集成。',
          'settings.integrations.visualEffects' => '视觉效果',
          'settings.integrations.explorerIntegration' => '资源管理器集成',
          'settings.integrations.explorerIntegrationDescription' =>
            '将 "使用 Localizer 打开" 添加到文件夹的 Windows 资源管理器右键菜单。',
          'settings.integrations.addToContextMenu' => '添加到上下文菜单',
          'settings.integrations.contextMenuAdded' => '上下文菜单已添加！',
          'settings.integrations.contextMenuAddError' => '添加上下文菜单失败',
          'settings.integrations.contextMenuRemoved' => '上下文菜单已移除！',
          'settings.integrations.contextMenuRemoveError' => '移除上下文菜单失败',
          'settings.integrations.fileAssociations' => '文件关联',
          'settings.integrations.fileAssociationsDescription' =>
            '注册文件类型以便在资源管理器中双击时使用 Localizer 打开。',
          'settings.integrations.registered' => '已注册',
          'settings.integrations.notRegistered' => '未注册',
          'settings.integrations.extRegistered' => ({required Object ext}) =>
              '${ext} 已注册！',
          'settings.integrations.extUnregistered' => ({required Object ext}) =>
              '${ext} 已取消注册！',
          'settings.integrations.extError' => (
                  {required Object ext, required Object action}) =>
              '无法对 ${ext} 执行 ${action}',
          'settings.integrations.registerAll' => '全部注册',
          'settings.integrations.unregisterAll' => '全部取消注册',
          'settings.integrations.registerAllResult' => (
                  {required Object success, required Object total}) =>
              '已注册 ${success} / ${total} 个文件类型',
          'settings.integrations.unregisterAllResult' => (
                  {required Object success, required Object total}) =>
              '已取消注册 ${success} / ${total} 个文件类型',
          'settings.integrations.protocolHandler' => '协议处理程序',
          'settings.integrations.protocolHandlerDescription' =>
            '注册 localizer:// URL 以打开此应用程序。',
          'settings.integrations.protocolRegistered' => '协议处理程序已注册',
          'settings.integrations.protocolNotRegistered' => '协议处理程序未注册',
          'settings.integrations.registerProtocol' => '注册协议',
          'settings.integrations.unregister' => '取消注册',
          'settings.integrations.protocolRegisteredSuccess' => '协议处理程序已注册！',
          'settings.integrations.protocolRemovedSuccess' => '协议处理程序已移除！',
          'settings.integrations.protocolRegisterError' => '注册失败',
          'settings.integrations.protocolRemoveError' => '移除失败',
          'settings.integrations.windowMaterial' => '窗口材质',
          'settings.integrations.windowMaterialDescription' => '选择 macOS 材质风格',
          'settings.integrations.dockIntegration' => 'Dock 集成',
          'settings.integrations.showDockBadge' => '显示未翻译计数',
          'settings.integrations.showDockBadgeDescription' =>
            '在 Dock 图标徽章上显示未翻译字符串计数',
          'settings.integrations.materials.sidebar' => '侧边栏',
          'settings.integrations.materials.menu' => '菜单',
          'settings.integrations.materials.popover' => '弹出窗口',
          'settings.integrations.materials.titlebar' => '标题栏',
          'settings.integrations.materials.underPageBackground' => '页面背景下',
          'settings.integrations.materials.contentBackground' => '内容',
          'settings.integrations.fileTypes.loc' => 'Localizer 项目文件',
          'settings.integrations.fileTypes.lang' => '语言文件',
          'settings.integrations.fileTypes.json' => 'JSON 本地化文件',
          'settings.integrations.fileTypes.xml' => 'XML 本地化文件',
          'settings.developer.title' => '开发者设置',
          'settings.developer.description' => '开发者的应用设置',
          'settings.developer.showLocalizationKeys' => '显示本地化键',
          'settings.developer.localizationKeysDescription' =>
            '启用后，所有翻译文本显示键名而非值',
          'settings.developer.showPerformanceOverlay' => '显示性能浮层',
          'settings.developer.performanceOverlayDescription' => '显示 FPS 和帧计时信息',
          'settings.developer.debugMode' => '调试模式',
          'settings.developer.debugModeDescription' => '启用额外日志和调试功能',
          'settings.developer.debuggingTools' => '调试工具',
          'settings.developer.semanticsDebugger' => '语义调试器',
          'settings.developer.semanticsDebuggerDescription' => '可视化语义树',
          'settings.developer.materialGrid' => 'Material 网格',
          'settings.developer.materialGridDescription' => '覆盖 Material 布局网格',
          'settings.developer.rasterCache' => '光栅缓存图像',
          'settings.developer.rasterCacheDescription' => '棋盘格光栅缓存图像',
          'settings.developer.actions' => '操作',
          'settings.developer.showLogs' => '显示应用日志',
          'settings.developer.showLogsDescription' => '打开 Talker 调试控制台',
          'settings.developer.restartTutorial' => '重启入门教程',
          'settings.developer.restartTutorialDescription' => '重置标志并重新启动教程',
          'settings.developer.restartRequested' => '教程重启已请求。',
          'settings.developer.throwException' => '抛出测试异常',
          'settings.developer.throwExceptionDescription' => '触发测试异常以进行崩溃报告',
          'settings.developer.testExceptionMessage' => '从开发者选项触发的测试异常',
          'settings.developer.clearTM' => '清除翻译记忆库',
          'settings.developer.clearTMDescription' => '删除所有缓存的翻译',
          'settings.developer.clearTMConfirmation' => '清除翻译记忆库？',
          'settings.developer.clearTMWarning' => '这将删除所有学习到的翻译。此操作无法撤销。',
          'settings.developer.tmCleared' => '翻译记忆库已清除',
          'settings.developer.clearApiKeys' => '清除 API 密钥',
          'settings.developer.clearApiKeysDescription' => '移除所有存储的 API 密钥',
          'settings.developer.clearApiKeysConfirmation' => '清除 API 密钥？',
          'settings.developer.clearApiKeysWarning' => '这将从安全存储中移除所有 API 密钥。',
          'settings.developer.apiKeysCleared' => 'API 密钥已清除',
          'settings.developer.hideOptions' => '隐藏开发者选项',
          'settings.developer.hideOptionsDescription' =>
            '禁用开发者模式（需要点击 7 次以重新启用）',
          'settings.developer.optionsDisabled' => '开发者选项已禁用',
          'settings.developer.dangerZone' => '危险区域',
          'settings.developer.factoryReset' => '恢复出厂设置',
          'settings.developer.factoryResetDescription' => '重置所有设置并清除数据',
          'settings.developer.factoryResetWarning' => '您确定要重置所有设置吗？此操作无法撤销。',
          'settings.developer.inspectionTools' => '检查工具',
          'settings.developer.searchHint' => '搜索设置...',
          'settings.developer.resetToDefault' => '恢复默认设置',
          'settings.developer.resetToGlobal' => '恢复全局默认设置',
          'settings.developer.storageInspector' => '存储检查器',
          'settings.developer.storageInspectorDescription' => '查看 Hive 和安全存储内容',
          'settings.developer.deviceEnvironment' => '设备与环境',
          'settings.developer.deviceEnvironmentDescription' => '屏幕、平台和构建信息',
          'settings.developer.themePlayground' => '主题广场',
          'settings.developer.themePlaygroundDescription' => '调色板和排版',
          'settings.developer.themePlaygroundSection.colors' => '颜色',
          'settings.developer.themePlaygroundSection.typography' => '排版',
          'settings.developer.themePlaygroundSection.palette.primary' => '主要',
          'settings.developer.themePlaygroundSection.palette.onPrimary' =>
            '主要之上',
          'settings.developer.themePlaygroundSection.palette.secondary' => '次要',
          'settings.developer.themePlaygroundSection.palette.onSecondary' =>
            '次要之上',
          'settings.developer.themePlaygroundSection.palette.surface' => '表面',
          'settings.developer.themePlaygroundSection.palette.onSurface' =>
            '表面之上',
          'settings.developer.themePlaygroundSection.palette.error' => '错误',
          'settings.developer.themePlaygroundSection.palette.onError' => '错误之上',
          'settings.developer.themePlaygroundSection.palette.outline' => '轮廓',
          'settings.developer.themePlaygroundSection.palette.shadow' => '阴影',
          'settings.developer.themePlaygroundSection.palette.success' => '成功',
          'settings.developer.themePlaygroundSection.palette.warning' => '警告',
          'settings.developer.themePlaygroundSection.palette.info' => '信息',
          'settings.developer.localizationInspector' => '本地化检查器',
          'settings.developer.localizationInspectorDescription' => '调试翻译字符串',
          'settings.developer.hiveAppSettings' => 'Hive (应用设置)',
          'settings.developer.secureStorageMasked' => '安全存储 (已掩码)',
          'settings.developer.featureFlags.title' => '实验性功能',
          'settings.developer.featureFlags.description' =>
            '在本地切换功能标志以进行测试。这些覆盖在应用重启后仍然存在。',
          'settings.developer.featureFlags.subtitle' => '覆盖实验性功能',
          'settings.developer.featureFlags.flags.experimental_ai_batch.name' =>
            '实验性 AI 批处理',
          'settings.developer.featureFlags.flags.experimental_ai_batch.description' =>
            '启用多行 AI 翻译批处理',
          'settings.developer.featureFlags.flags.new_diff_algorithm.name' =>
            '新对比算法',
          'settings.developer.featureFlags.flags.new_diff_algorithm.description' =>
            '使用改进的对比算法',
          'settings.developer.featureFlags.flags.enhanced_search.name' =>
            '增强搜索',
          'settings.developer.featureFlags.flags.enhanced_search.description' =>
            '启用翻译文件模糊搜索',
          'settings.developer.featureFlags.flags.auto_save.name' => '自动保存',
          'settings.developer.featureFlags.flags.auto_save.description' =>
            '编辑后自动保存更改',
          'settings.developer.featureFlags.reset' => '重置所有标志',
          'settings.developer.featureFlags.overrides' => '本地覆盖',
          'settings.developer.featureFlags.defaultVal' => '默认',
          'settings.developer.featureFlags.on' => '开',
          'settings.developer.featureFlags.off' => '关',
          'settings.developer.storageInspectorSection.refresh' => '刷新',
          'settings.developer.storageInspectorSection.hiveData' => 'Hive 数据',
          'settings.developer.storageInspectorSection.secureStorage' => '安全存储',
          'settings.developer.deviceInfoSection.refresh' => '刷新',
          'settings.developer.deviceInfoSection.copy' => '复制到剪贴板',
          'settings.developer.deviceInfoSection.computerName' => '计算机名称',
          'settings.developer.deviceInfoSection.osVersion' => '系统版本',
          'settings.developer.localizationInspectorSection.showKeys' =>
            '显示键名代替值',
          'settings.developer.localizationInspectorSection.keysVisible' =>
            '键可见',
          'settings.developer.localizationInspectorSection.normalDisplay' =>
            '正常显示',
          'settings.developer.localizationInspectorSection.note' =>
            '注意：此功能需要应用本地化使用遵循此设置的封装器。',
          'settings.about.title' => '关于',
          'settings.about.version' => '版本',
          'settings.about.buildNumber' => '构建版本',
          'settings.about.author' => '作者',
          _ => null,
        } ??
        switch (path) {
          'settings.about.license' => '许可证',
          'settings.about.sourceCode' => '源代码',
          'settings.about.reportBug' => '报告漏洞',
          'settings.about.requestFeature' => '请求功能',
          'settings.about.checkForUpdates' => '检查更新',
          'settings.about.upToDate' => '您已是最新版本！',
          'settings.about.updateAvailable' => ({required Object version}) =>
              '发现新版本：${version}',
          'settings.about.updateAvailableBadge' => '有更新可用！',
          'settings.about.developerSteps' => ({required Object count}) =>
              '您距离成为开发者还有 ${count} 步。',
          'settings.about.developerActivated' => '您现在是开发者了！',
          'settings.about.neverChecked' => '从不',
          'settings.about.applicationInfo' => '应用信息',
          'settings.about.platform' => '平台',
          'settings.about.updateInformation' => '更新信息',
          'settings.about.currentVersion' => '当前版本',
          'settings.about.latestVersion' => '最新版本',
          'settings.about.lastChecked' => '上次检查',
          'settings.about.checkingForUpdates' => '正在检查...',
          'settings.about.whatsNew' => '新功能',
          'settings.about.systemInformation' => '系统信息',
          'settings.about.dartVersion' => 'Dart 版本',
          'settings.about.diskSpace' => '可用磁盘空间',
          'settings.about.memoryUsage' => '内存使用',
          'settings.about.privacyTitle' => '隐私与遥测',
          'settings.about.usageStats' => '匿名使用统计',
          'settings.about.requiresFirebase' => '需要 Firebase 配置',
          'settings.about.featureUnavailable' => '功能当前不可用（需要 Firebase）',
          'settings.about.settingsManagement' => '设置管理',
          'settings.about.settingsManagementDescription' =>
            '将您的设置导出到文件以进行备份或与其他机器共享。',
          'settings.about.resetAll' => '重置全部',
          'settings.about.links' => '链接',
          'settings.about.githubRepo' => 'GitHub 仓库',
          'settings.about.privacyPolicy' => '隐私政策',
          'settings.about.crashReporting' => '崩溃报告',
          'settings.onboarding.skipTutorial' => '跳过教程',
          'settings.onboarding.gettingStarted' => '快速入门',
          'settings.onboarding.stepProgress' => (
                  {required Object current, required Object total}) =>
              '${current} / ${total}',
          'settings.onboarding.loadSampleData' => '加载示例数据',
          'settings.onboarding.steps.importFiles.title' => '导入文件',
          'settings.onboarding.steps.importFiles.description' => '加载源文件和目标文件',
          'settings.onboarding.steps.runComparison.title' => '运行比较',
          'settings.onboarding.steps.runComparison.description' => '点击 "比较文件"',
          'settings.onboarding.steps.reviewMissing.title' => '查看缺失键',
          'settings.onboarding.steps.reviewMissing.description' =>
            '注意红色的 "MISSING" 项目',
          'settings.onboarding.steps.useFilters.title' => '使用过滤器',
          'settings.onboarding.steps.useFilters.description' => '按类型过滤',
          'settings.onboarding.steps.searchResults.title' => '搜索结果',
          'settings.onboarding.steps.searchResults.description' => '查找特定键',
          'settings.onboarding.steps.advancedView.title' => '高级视图',
          'settings.onboarding.steps.advancedView.description' => '探索详细分析',
          'settings.onboarding.steps.editCell.title' => '编辑单元格',
          'settings.onboarding.steps.editCell.description' => '点击编辑值',
          'settings.onboarding.steps.exportResults.title' => '导出',
          'settings.onboarding.steps.exportResults.description' => '保存您的报告',
          'settings.settingsView.resetCategoryTitle' =>
            ({required Object category}) => '重置 ${category}？',
          'settings.settingsView.resetCategoryContent' => '这将重置此类别下的所有设置恢复默认值。',
          'settings.settingsView.resetAllTitle' => '重置所有设置？',
          'settings.settingsView.resetAllContent' =>
            '这将永久将所有设置重置为出厂默认值。此操作无法撤销。',
          'settings.settingsView.resetAll' => '重置全部',
          'settings.settingsView.resetSuccess' =>
            ({required Object category}) => '${category} 已恢复默认',
          'settings.settingsView.errorLoading' => '加载设置错误',
          'settings.settingsView.settingsSaved' => '设置已保存',
          'settings.settingsView.updateAvailable' =>
            ({required Object version}) => '更新可用：v${version}',
          'settings.settingsView.latestVersion' => '您正在使用最新版本',
          'settings.settingsView.whatsNew' => ({required Object version}) =>
              'v${version} 的新功能',
          'settings.settingsView.downloadUpdate' => '下载更新',
          'settings.settingsView.exportSettings' => '导出设置',
          'settings.settingsView.settingsExported' => '设置已导出',
          'settings.settingsView.exportFail' => ({required Object error}) =>
              '导出设置失败：${error}',
          'settings.settingsView.importSettings' => '导入设置',
          'settings.settingsView.importTitle' => '导入设置？',
          'settings.settingsView.importContent' => '这将使用导入的设置替换当前所有设置。此操作无法撤销。',
          'settings.settingsView.importSuccess' => '设置导入成功！',
          'settings.settingsView.importFail' => ({required Object error}) =>
              '导入设置失败：${error}',
          'settings.settingsView.invalidFormat' => '无效的设置文件格式',
          'settings.settingsView.categories.general' => '常规设置',
          'settings.settingsView.categories.comparisonEngine' => '对比引擎',
          'settings.settingsView.categories.appearance' => '外观',
          'settings.settingsView.categories.fileHandling' => '文件处理',
          'settings.settingsView.categories.aiServices' => 'AI 服务',
          'settings.settingsView.categories.systemIntegrations' => '系统集成',
          'settings.settingsView.categories.projectResources' =>
            '项目资源 (术语表 & TM)',
          'settings.settingsView.categories.developer' => '开发者选项',
          'settings.settingsView.categories.about' => '关于',
          'settings.settingsView.categoryLabels.general' => '常规',
          'settings.settingsView.categoryLabels.comparisonEngine' => '对比',
          'settings.settingsView.categoryLabels.appearance' => '外观',
          'settings.settingsView.categoryLabels.fileHandling' => '文件处理',
          'settings.settingsView.categoryLabels.aiServices' => 'AI 服务',
          'settings.settingsView.categoryLabels.systemIntegrations' => '系统集成',
          'settings.settingsView.categoryLabels.projectResources' => '项目资源',
          'settings.settingsView.categoryLabels.developer' => '开发者选项',
          'settings.settingsView.categoryLabels.about' => '关于',
          'fileComparison.title' => '文件对比',
          'fileComparison.openFiles' => '打开文件',
          'fileComparison.exportResults' => '导出结果',
          'fileComparison.restartTutorial' => '重启教程',
          'fileComparison.restartTutorialDevOnly' => '重启教程仅在开发者模式下可用。',
          'fileComparison.unsupportedFileType' => '不支持的文件类型。',
          'fileComparison.unsupportedFileTypeSuggestion' => '请选择支持的本地化文件。',
          'fileComparison.someFilesUnsupported' => '部分文件不支持。',
          'fileComparison.pickSupportedFiles' => '仅选择支持的本地化文件。',
          'fileComparison.pickTwoFiles' => '选择两个文件进行对比。',
          'fileComparison.pickBilingualFile' => '请选择一个双语文件进行对比。',
          'fileComparison.noResultsToExport' => '暂无结果可导出。',
          'fileComparison.performComparisonFirst' => '请先执行对比以导出结果。',
          'fileComparison.performComparisonFirstEditor' => '请先执行对比以查看高级详细信息。',
          'fileComparison.sampleDataLoaded' => '示例数据加载成功',
          'fileComparison.loadSampleDataError' => ({required Object error}) =>
              '加载示例数据失败：${error}',
          'fileComparison.invalidFileType' => '无效的文件类型。',
          'fileComparison.fileSelected' => (
                  {required Object label, required Object fileName}) =>
              '已选择 ${label}：${fileName}',
          'fileComparison.sourceFile' => '源文件',
          'fileComparison.targetFile' => '目标文件',
          'fileComparison.bilingualFile' => '双语文件',
          'fileComparison.compareFiles' => '比较文件',
          'fileComparison.compareFile' => '比较文件',
          'fileComparison.bilingualMode' => '双语模式',
          'fileComparison.twoFilesMode' => '双文件',
          'fileComparison.processing' => '处理中...',
          'fileComparison.remaining' => ({required Object time}) =>
              '剩余 ${time}',
          'fileComparison.comparisonInProgress' => '对比进行中...',
          'fileComparison.comparisonFailed' => ({required Object error}) =>
              '对比失败：${error}',
          'fileComparison.fileChanged' => ({required Object fileName}) =>
              '文件已更改：${fileName}。正在重新对比...',
          'fileComparison.dropFileHere' => '拖放文件到此处',
          'fileComparison.dropFileOrBrowse' => '拖放文件或点击浏览',
          'fileComparison.fileUpload' => '上传文件',
          'fileComparison.changeFile' => '更改文件',
          'fileComparison.total' => '总计',
          'fileComparison.show' => '显示',
          'fileComparison.showAll' => '显示全部',
          'fileComparison.noMatches' => ({required Object query}) =>
              '未找到 "${query}" 的匹配项',
          'fileComparison.showingEntries' => (
                  {required Object count, required Object total}) =>
              '显示 ${count} / ${total} 条目',
          'fileComparison.filesIdentical' => '文件完全相同。',
          'fileComparison.hiddenIdentical' => ({required Object count}) =>
              '隐藏了 ${count} 个相同条目',
          'fileComparison.showIdentical' => '显示相同条目',
          'fileComparison.hideIdentical' => '隐藏相同条目',
          'fileComparison.noDiff' => '基于键未发现差异。',
          'fileComparison.source' => '源',
          'fileComparison.target' => '目标',
          'fileComparison.value' => '值',
          'fileComparison.readyToCompare' => '准备对比文件',
          'fileComparison.readyToCompareDesc' =>
            '将本地化文件拖放到上方或使用浏览按钮\n选择文件进行对比。',
          'fileComparison.recentComparisons' => '最近的对比',
          'fileComparison.bilingualFileLabel' => ({required Object name}) =>
              '双语文件：${name}',
          'fileComparison.comparisonLabel' => (
                  {required Object source, required Object target}) =>
              '${source} ↔ ${target}',
          'fileComparison.fileNotExist' => '此会话中的一个或两个文件不再存在。',
          'fileComparison.largeFileTitle' => '检测到大文件',
          'fileComparison.largeFileContent' => ({required Object count}) =>
              '对比结果包含 ${count} 个条目。\n显示所有条目可能会导致性能问题。\n\n是否继续？',
          'fileComparison.dontShowAgain' => '此文件不再显示',
          'fileComparison.proceed' => '继续',
          'fileComparison.exportReport' => ({required Object format}) =>
              '保存 ${format} 报告',
          'fileComparison.saved' => ({required Object format}) =>
              '${format} 已保存',
          'fileComparison.saveError' => ({required Object format}) =>
              '保存 ${format} 文件失败。',
          'fileComparison.saveErrorDetailed' => (
                  {required Object format, required Object error}) =>
              '保存 ${format} 失败：${error}',
          'fileComparison.watching' => '正在监视',
          'fileComparison.watchOff' => '监视关闭',
          'fileComparison.watchingTooltip' => ({required Object status}) =>
              '文件监视：${status}\n当磁盘上的文件更改时自动重新对比',
          'fileComparison.aiSettingsNotAvailable' => 'AI 设置导航不可用',
          'directoryComparison.title' => '目录对比',
          'directoryComparison.sourceDirectory' => '源目录',
          'directoryComparison.targetDirectory' => '目标目录',
          'directoryComparison.sourceSubtitle' => '原始/参考文件',
          'directoryComparison.targetSubtitle' => '翻译/对比文件',
          'directoryComparison.selectBothDirectories' => '请同时选择源目录和目标目录。',
          'directoryComparison.selectSourceFolder' => '选择源文件夹',
          'directoryComparison.selectTargetFolder' => '选择目标文件夹',
          'directoryComparison.dropFolderHere' => '拖放文件夹到此处或浏览...',
          'directoryComparison.folderPath' => '文件夹路径',
          'directoryComparison.readyToCompare' => '准备对比目录',
          'directoryComparison.readyToCompareDesc' =>
            '拖放文件夹到上方或使用浏览按钮\n选择目录进行对比。',
          'directoryComparison.nestedFolders' => '嵌套文件夹',
          'directoryComparison.nestedFoldersTooltip' => '递归对比所有嵌套目录',
          'directoryComparison.fileMatching' => '文件匹配',
          'directoryComparison.fileMatchingTooltip' => '按名称自动配对文件',
          'directoryComparison.bulkExport' => '批量导出',
          'directoryComparison.bulkExportTooltip' => '一次性导出所有对比结果',
          'directoryComparison.notDirectoryComparison' => '这不是目录对比。',
          'directoryComparison.directoriesNotExist' => '一个或两个目录不再存在。',
          'directoryComparison.errorOccurred' => '发生错误',
          'directoryComparison.noFilesFound' => '在所选目录中未找到文件。',
          'directoryComparison.unmatchedSourceFiles' => '未匹配的源文件',
          'directoryComparison.unmatchedTargetFiles' => '未匹配的目标文件',
          'directoryComparison.filePairs' => ({required Object count}) =>
              '${count} 对文件',
          'directoryComparison.pairedFiles' => ({required Object count}) =>
              '已配对文件 (${count})',
          'directoryComparison.view' => '查看',
          'directoryComparison.failed' => '失败',
          'directoryComparison.pair' => '配对...',
          'directoryComparison.pairDialogTitle' => ({required Object name}) =>
              '将 "${name}" 配对与：',
          'directoryComparison.discoverFiles' => '发现文件',
          'directoryComparison.compareAll' => '对比全部',
          'directoryComparison.exportAll' => '导出全部',
          'directoryComparison.comparisonStarted' => '对比已开始...',
          'directoryComparison.discoveringFiles' => '正在发现文件...',
          'directoryComparison.noResultsToExport' => '没有对比结果可导出。请先运行 "对比全部"。',
          'directoryComparison.selectExportFolder' => '选择导出文件夹',
          'directoryComparison.createExportFolderError' =>
            ({required Object error}) => '创建导出文件夹失败：${error}',
          'directoryComparison.exportingResults' => '正在导出结果',
          'directoryComparison.processingFile' => ({required Object file}) =>
              '正在处理：${file}',
          'directoryComparison.exportProgress' => (
                  {required Object current, required Object total}) =>
              '已导出 ${current} / ${total} 个文件',
          'directoryComparison.exportComplete' => '导出完成',
          'directoryComparison.exportSuccessMessage' =>
            ({required Object count}) => '成功导出 ${count} 个对比文件及摘要。',
          'directoryComparison.exportFailed' => ({required Object error}) =>
              '导出失败：${error}',
          'directoryComparison.close' => '关闭',
          'gitComparison._translatorNote' =>
            'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.',
          'gitComparison.title' => '仓库对比',
          'gitComparison.repoSelector' => '创建 / 打开仓库',
          'gitComparison.noRepoSelected' => '未选择仓库',
          'gitComparison.open' => '打开',
          'gitComparison.refreshCommits' => '刷新提交',
          'gitComparison.noCommits' => '未找到或未加载提交。请选择一个分支以加载提交。',
          'gitComparison.baseCommit' => '基础提交 (旧)',
          'gitComparison.targetCommit' => '目标提交 (新)',
          'gitComparison.filterCommitsByBranch' => '按分支过滤提交',
          'gitComparison.conflictDetection' => '冲突检测',
          'gitComparison.conflictDetectionTooltip' => '检测并解决合并冲突',
          'gitComparison.actions' => '操作：',
          'gitComparison.checkout' => 'Checkout',
          'gitComparison.merge' => 'Merge',
          'gitComparison.pull' => 'Pull',
          'gitComparison.checkoutBranch' => 'Checkout 分支',
          'gitComparison.mergeBranch' => 'Merge 分支到当前',
          'gitComparison.mergeConfirmation' => ({required Object branch}) =>
              'Merge ${branch}？',
          'gitComparison.mergeWarning' => '这将合并更改到您当前的工作分支。可能会发生冲突。',
          'gitComparison.selectExportFolder' => '选择导出文件夹',
          'gitComparison.createExportFolderError' =>
            ({required Object error}) => '创建导出文件夹失败：${error}',
          'gitComparison.exportingFiles' => '正在导出文件',
          'gitComparison.processingFile' => ({required Object file}) =>
              '正在处理：${file}',
          'gitComparison.exportProgress' => (
                  {required Object current, required Object total}) =>
              '已导出 ${current} / ${total} 个文件',
          'gitComparison.exportComplete' => '导出完成',
          'gitComparison.exportSuccessMessage' => ({required Object count}) =>
              '成功导出 ${count} 个文件及完整内容。',
          'gitComparison.exportDetail' => '每个文件的差异保存在 "files" 子文件夹中。',
          'gitComparison.diffViewer' => '差异查看器',
          'gitComparison.base' => 'BASE',
          'gitComparison.target' => 'TARGET',
          'gitComparison.noLines' => '没有要显示的行',
          'gitComparison.searchFiles' => '搜索文件...',
          'gitComparison.noFilesMatch' => ({required Object query}) =>
              '没有文件匹配 "${query}"',
          'gitComparison.filesCount' => ({required Object count}) =>
              '${count} 个文件',
          'gitComparison.selectBaseFile' => '选择基础文件',
          'gitComparison.selectTargetFile' => '选择目标文件',
          'gitComparison.comparisonResults' => '对比结果',
          'gitComparison.noChanges' => '所选引用之间未发现更改。',
          'gitComparison.linesAdded' => '新增行数',
          'gitComparison.linesRemoved' => '移除行数',
          'gitComparison.commit' => 'Commit',
          'gitComparison.branch' => 'Branch',
          'gitComparison.noRepositorySelected' => '未选择仓库',
          'gitComparison.notGitComparison' => '不是 Git 对比',
          'gitComparison.repositoryNotExist' => '仓库不存在',
          'gitComparison.mainBranch' => 'main',
          'gitComparison.masterBranch' => 'master',
          'gitComparison.backToControls' => '返回对比控制',
          'advancedComparison.placeholder' => '高级对比视图 - 占位符',
          'advancedDiff.saveAllChanges' => '保存所有更改？',
          'advancedDiff.saveConfirmation' => ({required Object count}) =>
              '这将保存 ${count} 个修改条目到目标文件。此操作无法撤销。',
          'advancedDiff.changesSaved' => '更改保存成功。',
          'advancedDiff.csvExported' => 'CSV 已导出',
          'advancedDiff.unsavedChanges' => '未保存的更改',
          'advancedDiff.unsavedChangesWarning' => '您有未保存的更改。确定要放弃它们吗？',
          'advancedDiff.discardChanges' => '放弃更改',
          'advancedDiff.goBack' => '返回',
          'advancedDiff.breadcrumbs' => '首页 > 编辑器',
          'advancedDiff.unsaved' => ({required Object count}) => '${count} 未保存',
          'advancedDiff.reviewed' => ({required Object count}) =>
              '${count} 已审核',
          'advancedDiff.saveAll' => ({required Object count}) =>
              '保存全部 (${count})',
          'advancedDiff.allSaved' => '全部已保存',
          'advancedDiff.saveAllTooltip' => '保存所有更改 (Ctrl+S)',
          'advancedDiff.exportTooltip' => '导出数据 (Ctrl+E)',
          'advancedDiff.aiSuggestion.aiTranslation' => 'AI 翻译',
          'advancedDiff.aiSuggestion.aiRephrase' => 'AI 改写',
          'advancedDiff.aiSuggestion.key' => ({required Object key}) =>
              '键：${key}',
          'advancedDiff.aiSuggestion.original' => '原始：',
          'advancedDiff.aiSuggestion.suggestion' => '建议：',
          'advancedDiff.aiSuggestion.confidence' => 'AI 置信度',
          'advancedDiff.aiSuggestion.cancelEdit' => '取消编辑',
          'advancedDiff.aiSuggestion.editSuggestion' => '编辑建议',
          'advancedDiff.aiSuggestion.alternatives' => '替代方案：',
          'advancedDiff.aiSuggestion.accept' => '接受',
          'advancedDiff.aiSuggestion.reject' => '拒绝',
          'advancedDiff.aiSuggestion.stop' => '停止',
          'advancedDiff.detailEdit.title' => ({required Object key}) =>
              '编辑：${key}',
          'advancedDiff.detailEdit.sourceLabel' => '源 (原始)',
          'advancedDiff.detailEdit.targetLabel' => '目标 (翻译)',
          'advancedDiff.detailEdit.translateWithCloud' => '使用云翻译',
          'advancedDiff.detailEdit.translateWithAi' => '使用 AI 翻译',
          'advancedDiff.detailEdit.translating' => '翻译中...',
          'advancedDiff.detailEdit.applyAndTm' => '应用',
          'advancedDiff.detailEdit.entryApplied' => '条目已应用并添加到 TM',
          'advancedDiff.detailEdit.translationAdded' => '翻译建议已添加。',
          'advancedDiff.detailEdit.aiSuggestionAdded' => 'AI 建议已添加。',
          'advancedDiff.table.addedToTM' => '已添加到翻译记忆库',
          'advancedDiff.table.markedReviewed' => '标记为已审核 ✓',
          'advancedDiff.table.unmarkedReview' => '取消已审核标记',
          'advancedDiff.table.reverted' => '已恢复为源值',
          'advancedDiff.table.entryDeleted' => '条目已删除',
          'advancedDiff.table.noSourceText' => '没有可翻译的源文本。',
          'advancedDiff.table.aiTranslationFailed' => ({required Object key}) =>
              '"${key}" AI 翻译失败',
          'advancedDiff.table.noTargetText' => '没有可改写的目标文本。',
          'advancedDiff.table.aiRephraseFailed' => ({required Object key}) =>
              '"${key}" AI 改写失败',
          'advancedDiff.table.checkRowsFirst' => '请先使用复选框选择行',
          'advancedDiff.table.markedRowsReviewed' =>
            ({required Object count}) => '已将 ${count} 行标记为已审核',
          'advancedDiff.table.revertedRows' => ({required Object count}) =>
              '已恢复 ${count} 行',
          'advancedDiff.table.entriesCount' => ({required Object count}) =>
              '${count} 个条目',
          'advancedDiff.table.markSelectedReviewed' => '标记所选为已审核',
          'advancedDiff.table.revertSelected' => '恢复所选',
          'advancedDiff.table.noDifferences' => '未发现差异',
          'advancedDiff.table.adjustFilters' => '尝试调整过滤器',
          'advancedDiff.table.cloudTranslationApplied' => '云翻译已应用。',
          'advancedDiff.table.aiTranslationApplied' => 'AI 翻译已应用。',
          'advancedDiff.table.suggestionApplied' => '建议已应用。',
          'advancedDiff.table.aiSuggestionApplied' => 'AI 建议已应用。',
          'advancedDiff.table.rephraseApplied' => '改写已应用。',
          'advancedDiff.table.aiRephraseApplied' => 'AI 改写已应用。',
          'advancedDiff.table.rephrase' => '改写',
          'advancedDiff.table.aiRephrase' => 'AI 改写',
          'advancedDiff.table.targetClickToEdit' => '目标 (点击编辑)',
          'advancedDiff.table.targetClickForDialog' => '目标 (点击打开对话框)',
          'advancedDiff.table.emptyClickToEdit' => '(空 - 点击编辑)',
          'advancedDiff.table.unmarkReviewed' => '取消已审核',
          'advancedDiff.table.markReviewed' => '标记为已审核',
          'advancedDiff.table.revertToSource' => '恢复为源文',
          'advancedDiff.table.translateWithCloud' => '使用云翻译',
          'advancedDiff.table.translateWithAi' => '使用 AI 翻译',
          'advancedDiff.table.rephraseWithAi' => '使用 AI 改写',
          'advancedDiff.table.moreActions' => '更多操作',
          'advancedDiff.table.editDetails' => '编辑详情',
          'advancedDiff.table.suggestTranslation' => '建议翻译',
          'advancedDiff.table.addToTm' => '添加到 TM',
          'advancedDiff.table.deleteEntry' => '删除条目',
          'advancedDiff.diffRow.copySource' => '复制源文本',
          'advancedDiff.diffRow.actions' => '操作',
          'advancedDiff.status.added' => '新增',
          'advancedDiff.status.missing' => '缺失',
          'advancedDiff.status.changed' => ({required Object percent}) =>
              '修改 ${percent}%',
          'advancedDiff.status.same' => '相同',
          'advancedDiff.sidebar.widgets' => '小部件',
          'advancedDiff.sidebar.searchPlaceholder' => '搜索键和值... (Ctrl+F)',
          'advancedDiff.sidebar.fuzzySearchTooltip' => '模糊搜索 (容错)',
          'advancedDiff.sidebar.regexSearchTooltip' => '正则表达式搜索',
          'advancedDiff.sidebar.cloudTranslation' => '云翻译',
          'advancedDiff.sidebar.aiTranslation' => 'AI 翻译',
          'advancedDiff.sidebar.status' => '状态',
          'advancedDiff.sidebar.tm' => '翻译记忆库',
          'advancedDiff.sidebar.filters' => '过滤器',
          'advancedDiff.sidebar.actions' => '操作',
          'advancedDiff.sidebar.similarity' => '相似度',
          'advancedDiff.sidebar.actionsSection.exportMatches' => '导出匹配项',
          'advancedDiff.sidebar.actionsSection.preview' => '预览',
          'advancedDiff.sidebar.actionsSection.fillFromTmTitle' => '从翻译记忆库填充？',
          'advancedDiff.sidebar.actionsSection.fillFromTmContent' =>
            '这将尝试使用翻译记忆库中的匹配项填充空的目标值。现有值不会被覆盖。',
          'advancedDiff.sidebar.actionsSection.fill' => '填充',
          'advancedDiff.sidebar.actionsSection.fillFromMemory' => '从记忆库填充',
          'advancedDiff.sidebar.actionsSection.filledFromTm' =>
            ({required Object count}) => '已从翻译记忆库填充 ${count} 个项目。',
          'advancedDiff.sidebar.aiSection.infoCloud' => '使用云翻译将源文本翻译为空目标值。',
          'advancedDiff.sidebar.aiSection.infoAi' => '使用 AI 将源文本翻译为空目标值。',
          'advancedDiff.sidebar.aiSection.translationSettings' => '翻译设置',
          'advancedDiff.sidebar.aiSection.aiSettings' => 'AI 设置',
          'advancedDiff.sidebar.aiSection.source' => '源',
          'advancedDiff.sidebar.aiSection.target' => '目标',
          'advancedDiff.sidebar.aiSection.translatingProgress' =>
            ({required Object percent}) => '翻译中... ${percent}%',
          'advancedDiff.sidebar.aiSection.translating' => '翻译中...',
          'advancedDiff.sidebar.aiSection.translateAllMissing' => '翻译所有缺失项',
          'advancedDiff.sidebar.aiSection.translateAllTitle' => '翻译所有缺失项？',
          'advancedDiff.sidebar.aiSection.translateAllContent' => (
                  {required Object service,
                  required Object source,
                  required Object target}) =>
              '这将使用 ${service} 将所有目标值为空的条目从 ${source} 翻译为 ${target}。\n\n您可以逐个审核建议或一次性全部应用。',
          'advancedDiff.sidebar.aiSection.translateAll' => '全部翻译',
          'advancedDiff.sidebar.aiSection.reviewEach' => '逐个审核',
          'advancedDiff.sidebar.aiSection.cloudTranslated' =>
            ({required Object count}) => '使用云翻译翻译了 ${count} 个条目。',
          'advancedDiff.sidebar.aiSection.aiTranslated' =>
            ({required Object count}) => '使用 AI 翻译了 ${count} 个条目。',
          'advancedDiff.sidebar.aiSection.aiTranslateFailed' => 'AI 全部翻译失败',
          'advancedDiff.sidebar.aiSection.noMissingEntries' => '没有缺失条目可翻译。',
          'advancedDiff.sidebar.aiSection.skip' => '跳过',
          'advancedDiff.sidebar.aiSection.stop' => '停止',
          'advancedDiff.sidebar.aiSection.cloudApplied' =>
            ({required Object count}) => '应用了 ${count} 个建议。',
          'advancedDiff.sidebar.aiSection.aiApplied' =>
            ({required Object count}) => '应用了 ${count} 个 AI 建议。',
          'advancedDiff.sidebar.tmSection.enableTmFill' => '启用 TM 填充',
          'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' => '高于最低值自动应用',
          'advancedDiff.sidebar.tmSection.matchSettings' => '匹配设置',
          'advancedDiff.sidebar.tmSection.minMatch' => '最低匹配：',
          'advancedDiff.sidebar.tmSection.limit' => '限制：',
          'advancedDiff.sidebar.tmSection.exact' => '完全',
          'advancedDiff.sidebar.filtersSection.viewFilters' => '视图过滤器',
          'advancedDiff.sidebar.filtersSection.showAll' => '显示全部',
          'advancedDiff.sidebar.filtersSection.added' => '新增',
          'advancedDiff.sidebar.filtersSection.removed' => '移除',
          'advancedDiff.sidebar.filtersSection.modified' => '已修改',
          'advancedDiff.sidebar.filtersSection.actionScope' => '操作范围',
          'advancedDiff.sidebar.filtersSection.applyToAdded' => '应用于新增',
          'advancedDiff.sidebar.filtersSection.applyToModified' => '应用于已修改',
          'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' =>
            '仅填充空目标',
          'advancedDiff.sidebar.filtersSection.limitToVisible' => '限制为可见',
          'advancedDiff.sidebar.filtersSection.editMode' => '编辑模式',
          'advancedDiff.sidebar.filtersSection.dialog' => '对话框',
          'advancedDiff.sidebar.filtersSection.inline' => '行内',
          'advancedDiff.sidebar.similaritySection.currentFilter' => '当前过滤器：',
          'advancedDiff.sidebar.similaritySection.any' => '任意',
          'advancedDiff.sidebar.similaritySection.high' => '高',
          'advancedDiff.sidebar.similaritySection.medium' => '中',
          'advancedDiff.sidebar.similaritySection.low' => '低',
          'advancedDiff.sidebar.statusSection.total' =>
            ({required Object count}) => '${count} 总计',
          'advancedDiff.sidebar.statusSection.extra' =>
            ({required Object count}) => '${count} 额外',
          'advancedDiff.sidebar.statusSection.missing' =>
            ({required Object count}) => '${count} 缺失',
          'advancedDiff.sidebar.statusSection.changed' =>
            ({required Object count}) => '${count} 修改',
          'issueDetails.title' => '问题详情',
          'issueDetails.showingIssues' => (
                  {required Object count, required Object total}) =>
              '显示 ${count} / ${total} 个问题',
          'issueDetails.searchPlaceholder' => '通过键、文本或错误搜索...',
          'issueDetails.noDetails' => '没有可用详情。',
          'issueDetails.noMatches' => '未找到匹配项。',
          'issueDetails.showMore' => '显示更多',
          'issueDetails.copyItems' => ({required Object count}) =>
              '复制 ${count} 个项目',
          'issueDetails.close' => '关闭',
          'issueDetails.copied' => '已复制到剪贴板',
          'issueDetails.copiedCount' => ({required Object count}) =>
              '已复制 ${count} 个项目',
          'issueDetails.duplicateValue.label' => '重复翻译',
          'issueDetails.duplicateValue.warning' => '不同的源文本使用相同的翻译。请检查上下文。',
          'issueDetails.duplicateValue.affectedKeys' =>
            ({required Object count}) => '受影响的键 (${count})',
          'issueDetails.duplicateValue.identicalSources' => '源文本相同',
          'issueDetails.duplicateValue.moreKeys' => ({required Object count}) =>
              '+${count} 更多键',
          'issueDetails.lengthOutlier.source' => '源',
          'issueDetails.lengthOutlier.translation' => '翻译',
          'issueDetails.lengthOutlier.chars' => ({required Object count}) =>
              '${count} 字符',
          'issueDetails.standard.key' => '键',
          'issueDetails.standard.sourceText' => '源文本',
          'issueDetails.standard.translation' => '翻译',
          'issueDetails.standard.errorDetails' => '错误详情',
          'issueDetails.standard.note' => '注意',
          'issueDetails.review' => '审查',
          'issueDetails.types.duplicateValue' => '重复值',
          'issueDetails.types.lengthOutlier' => '长度不匹配',
          'issueDetails.types.placeholderMismatch' => '占位符损坏',
          'issueDetails.notes.placeholderMismatch' => '占位符如 {name} 应与源文本匹配。',
          'issueDetails.notes.lengthOutlier' => '长度的巨大变化可能会影响文本在屏幕上的显示。',
          'issueDetails.notes.duplicateValue' => '不同的键使用了相同的翻译。',
          'issueDetails.fallbacks.multipleSources' => '多个源文本',
          'issueDetails.fallbacks.sourceNotAvailable' => '源文本不可用',
          'issueDetails.fallbacks.sharedTranslationNotAvailable' => '共享翻译不可用',
          'issueDetails.fallbacks.translationNotAvailable' => '翻译不可用',
          'importReview.title' => '审查项目导入',
          'importReview.projectName' => '项目名称',
          'importReview.created' => '创建时间',
          'importReview.historyItems' => '历史项目',
          'importReview.customSettingsTitle' => '检测到自定义设置',
          'importReview.customSettingsWarning' => '此项目包含自定义设置，将在项目打开时覆盖您的默认设置。',
          'importReview.standardSettings' => '此项目使用标准全局设置。',
          'importReview.cancelImport' => '取消导入',
          'importReview.trustOpen' => '信任并打开项目',
          'historyView.title' => '对比历史',
          'historyView.clearAll' => '清除所有历史',
          'historyView.searchPlaceholder' => '按文件名搜索...',
          'historyView.sortBy' => '排序方式',
          'historyView.sortDate' => '日期',
          'historyView.sortSource' => '源文件',
          'historyView.sortTarget' => '目标文件',
          'historyView.showCurrentProject' => '显示：当前项目',
          'historyView.showAllHistory' => '显示：所有历史',
          'historyView.groupByFolder' => '按文件夹分组',
          'historyView.disableGrouping' => '禁用文件夹分组',
          'historyView.filterAll' => '全部',
          'historyView.filterFiles' => '文件',
          'historyView.filterDirectories' => '目录',
          'historyView.filterGit' => 'Git',
          'historyView.noHistory' => '暂无对比历史',
          'historyView.historyDescription' => '您的文件对比将显示在这里',
          'historyView.noResults' => '未找到结果',
          'historyView.adjustSearch' => '尝试调整您的搜索',
          'historyView.clearConfirmationTitle' => '清除所有历史？',
          'historyView.clearConfirmationContent' => '这将永久删除所有对比历史。此操作无法撤销。',
          'historyView.clearAction' => '清除全部',
          'historyView.deletedMessage' => '历史项目已删除',
          'historyView.undo' => '撤销',
          'historyView.viewDetails' => '查看详情',
          'historyView.delete' => '删除',
          'historyView.openLocation' => '打开文件位置',
          'historyView.bilingual' => '双语',
          'historyView.filePair' => '文件对',
          'historyView.directory' => '目录',
          'historyView.git' => 'Git',
          'historyView.repo' => '仓库',
          'historyView.sourceDir' => '源目录',
          'historyView.targetDir' => '目标目录',
          'historyView.source' => '源',
          'historyView.target' => '目标',
          'historyView.noChanges' => '未检测到更改',
          'historyView.added' => '新增',
          'historyView.removed' => '移除',
          'historyView.modified' => '修改',
          'historyView.same' => '相同',
          'historyView.total' => '总计',
          'historyView.currentProject' => '当前项目',
          'historyView.unassigned' => '未分配',
          'historyView.project' => '项目',
          'compare.title' => '对比文件',
          'compare.sourceFile' => '源文件',
          'compare.targetFile' => '目标文件',
          'compare.sourceFolder' => '源文件夹',
          'compare.targetFolder' => '目标文件夹',
          'compare.dropFilesHint' => '将本地化文件拖放到此处或使用浏览按钮选择文件进行对比。',
          'compare.selectSourceFile' => '选择源文件',
          'compare.selectTargetFile' => '选择目标文件',
          'compare.startComparison' => '开始对比',
          'compare.comparing' => '对比中...',
          'compare.comparisonComplete' => '对比完成',
          'compare.noChanges' => '未检测到更改',
          'compare.filesIdentical' => '文件完全相同',
          'compare.changesFound' => ({required Object count}) =>
              '发现 ${count} 处更改',
          'compare.tabs.files' => '文件',
          'compare.tabs.directories' => '目录',
          'compare.tabs.git' => 'Git',
          'compare.fileTypes.json' => 'JSON 本地化文件 (i18next, Flutter 等)',
          'compare.fileTypes.yaml' => 'YAML 本地化文件 (Rails, Flutter)',
          'compare.fileTypes.xml' => 'XML 本地化文件 (Android, .NET)',
          'compare.fileTypes.properties' => '属性文件 (Java)',
          'compare.fileTypes.resx' => 'RESX 文件 (.NET)',
          _ => null,
        } ??
        switch (path) {
          'compare.fileTypes.xliff' => 'XLIFF 文件',
          'history.title' => '历史',
          'history.recentComparisons' => '最近的对比',
          'history.noHistory' => '暂无对比历史',
          'history.noHistoryDescription' => '您的对比历史将显示在这里',
          'history.clearHistory' => '清除历史',
          'history.clearHistoryConfirm' => '您确定要清除所有历史吗？',
          'history.deleteEntry' => '删除条目',
          'history.openComparison' => '打开对比',
          'history.timeAgo.justNow' => '刚刚',
          'history.timeAgo.secondsAgo' => ({required Object count}) =>
              '${count} 秒前',
          'history.timeAgo.oneMinuteAgo' => '1 分钟前',
          'history.timeAgo.minutesAgo' => ({required Object count}) =>
              '${count} 分钟前',
          'history.timeAgo.oneHourAgo' => '1 小时前',
          'history.timeAgo.hoursAgo' => ({required Object count}) =>
              '${count} 小时前',
          'history.timeAgo.yesterday' => '昨天',
          'history.timeAgo.daysAgo' => ({required Object count}) =>
              '${count} 天前',
          'history.timeAgo.oneWeekAgo' => '1 周前',
          'history.timeAgo.weeksAgo' => ({required Object count}) =>
              '${count} 周前',
          'history.timeAgo.oneMonthAgo' => '1 个月前',
          'history.timeAgo.monthsAgo' => ({required Object count}) =>
              '${count} 个月前',
          'history.timeAgo.oneYearAgo' => '1 年前',
          'history.timeAgo.yearsAgo' => ({required Object count}) =>
              '${count} 年前',
          'history.timeAgo.inTheFuture' => '未来',
          'projects.title' => '项目',
          'projects.createProject' => '创建项目',
          'projects.importProject' => '导入项目',
          'projects.noProjects' => '暂无项目',
          'projects.noProjectsDescription' => '创建一个项目以组织您的本地化文件',
          'projects.projectName' => '项目名称',
          'projects.projectPath' => '项目路径',
          'projects.lastOpened' => '上次打开',
          'projects.openProject' => '打开项目',
          'projects.closeProject' => '关闭项目',
          'projects.deleteProject' => '删除项目',
          'projects.deleteProjectConfirm' => '您确定要删除此项目吗？',
          'projects.exportProject' => '导出项目',
          'projects.exportDescription' => '创建一个包含源文件、配置和历史记录的便携式压缩包。',
          'projects.exporting' => '正在导出项目...',
          'projects.exportSuccess' => '项目已导出',
          'projects.exportError' => ({required Object error}) =>
              '导出失败：${error}',
          'projects.createNewProject' => '创建新项目',
          'projects.openExistingProject' => '打开现有项目',
          'projects.importProjectZip' => '导入项目压缩包',
          'projects.projectResources' => '项目资源',
          'projects.recentProjects' => '最近的项目',
          'projects.noRecentProjects' => '没有最近的项目',
          'projects.selectProjectZip' => '选择项目压缩包',
          'projects.selectDestination' => '选择导入目标文件夹',
          'projects.importing' => '正在导入项目...',
          'projects.importSuccess' => '项目导入成功',
          'projects.importFailed' => ({required Object error}) =>
              '导入失败：${error}',
          'projects.importingFiles' => '正在导入文件...',
          'projects.noSupportedFiles' => '未拖入支持的文件。',
          'projects.stats.empty' => '空项目',
          'projects.stats.files' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
                n,
                one: '1 个翻译文件',
                other: '${count} 个翻译文件',
              ),
          'projects.stats.languages' => (
                  {required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
                n,
                one: '1 种语言',
                other: '${count} 种语言',
              ),
          'projects.openProjectFirst' => '请先打开一个项目以管理其资源。',
          'projects.removeFromRecent' => '从最近记录中移除',
          'projects.selection.selectFolder' => '选择项目文件夹',
          'projects.selection.selectArchive' => '选择项目归档',
          'projects.selection.openProject' => '打开项目',
          'projects.selection.browseFolder' => '浏览文件夹...',
          'projects.selection.createNew' => '创建新项目',
          'projects.selection.importFromZip' => '从 Zip 导入...',
          'projects.createDialog.title' => '创建项目',
          'projects.createDialog.description' =>
            '项目允许您保存特定文件夹的自定义设置。将创建一个 ".localizer" 文件夹以存储您的项目配置。',
          'projects.createDialog.folderLabel' => '项目文件夹',
          'projects.createDialog.folderHint' => '点击选择文件夹...',
          'projects.createDialog.nameLabel' => '项目名称',
          'projects.createDialog.nameHint' => '例如，My App Translations',
          'projects.createDialog.selectFolderWarning' => '请选择一个项目文件夹。',
          'projects.createDialog.enterNameError' => '请输入项目名称',
          'projects.createDialog.nameLengthError' => '名称必须至少 2 个字符',
          'projects.createDialog.success' => ({required Object name}) =>
              '项目 "${name}" 创建成功！',
          'projects.createDialog.failure' => '创建项目失败。',
          'projects.createDialog.creating' => '正在创建...',
          'projects.createDialog.createAction' => '创建项目',
          'projects.indicator.tooltipNoProject' => '创建一个项目以保存文件夹的自定义设置',
          'projects.indicator.tooltipProject' => ({required Object name}) =>
              '项目：${name}\n点击查看选项',
          'projects.indicator.location' => '位置',
          'projects.indicator.created' => '创建时间',
          'projects.indicator.switchProject' => '切换项目',
          'projects.indicator.done' => '完成',
          'projects.glossary.title' => '项目术语表',
          'projects.glossary.description' => '定义应统一处理或从不翻译的术语。',
          'projects.glossary.noTerms' => '暂无术语。',
          'projects.glossary.noTermsDesc' => '添加应在翻译中保持一致的术语，\n或标记不应翻译的品牌名称。',
          'projects.glossary.doNotTranslate' => '不翻译',
          'projects.glossary.noSpecificTranslation' => '无特定翻译',
          'projects.glossary.addTerm' => '添加术语',
          'projects.glossary.editTerm' => '编辑术语',
          'projects.glossary.term' => '术语',
          'projects.glossary.termHint' => '例如，品牌名称，专业术语',
          'projects.glossary.definition' => '定义 (可选)',
          'projects.glossary.definitionHint' => '给译者的上下文',
          'projects.glossary.doNotTranslateLabel' => '不翻译',
          'projects.glossary.doNotTranslateDesc' => '在目标中保持术语完全不变',
          'projects.glossary.preferredTranslation' => '首选翻译',
          'projects.glossary.caseSensitive' => '区分大小写',
          'projects.conflicts.missingApiKeyTitle' =>
            ({required Object service}) => '缺少 ${service} 的 API 密钥',
          'projects.conflicts.missingApiKeyMessage' => (
                  {required Object service}) =>
              '此项目使用 ${service}，但未配置 API 密钥。请在 设置 > AI 服务 中添加您的 API 密钥，否则应用将使用全局默认值。',
          'projects.conflicts.dismiss' => '忽略',
          'projects.tm.title' => '翻译记忆库',
          'projects.tm.description' => '管理此项目的翻译记忆库来源。',
          'projects.tm.globalTm' => '全局翻译记忆库',
          'projects.tm.globalTmDescription' => '使用应用设置中的共享翻译记忆库',
          'projects.tm.linkedFiles' => '链接文件 (项目特定)',
          'projects.tm.noLinkedFiles' => '未链接项目特定文件。',
          'projects.tm.addTmFile' => '添加 TM 文件',
          'projects.tm.useGlobalTm' => '使用全局 TM',
          'projects.tm.selectTm' => '选择翻译记忆库',
          'projects.tm.globalTmEnabled' => '全局翻译记忆库已启用',
          'diff.added' => '新增',
          'diff.removed' => '移除',
          'diff.modified' => '修改',
          'diff.unchanged' => '未更改',
          'diff.missing' => '缺失',
          'diff.extra' => '额外',
          'diff.sourceValue' => '源值',
          'diff.targetValue' => '目标值',
          'diff.key' => '键',
          'diff.status' => '状态',
          'diff.actions' => '操作',
          'diff.copyToTarget' => '复制到目标',
          'diff.acceptChange' => '接受更改',
          'diff.rejectChange' => '拒绝更改',
          'diff.viewDetails' => '查看详情',
          'git.title' => 'Git 对比',
          'git.selectRepository' => '选择仓库',
          'git.selectBranch' => '选择分支',
          'git.selectCommit' => '选择提交',
          'git.compareBranches' => '对比分支',
          'git.compareCommits' => '对比提交',
          'git.baseBranch' => '基础分支',
          'git.compareBranch' => '对比分支',
          'git.noRepositories' => '未找到 Git 仓库',
          'git.noRepositoriesDescription' => '打开包含 Git 仓库的文件夹',
          'git.filesChanged' => ({required Object count}) => '${count} 个文件已更改',
          'git.additions' => ({required Object count}) => '${count} 处新增',
          'git.deletions' => ({required Object count}) => '${count} 处删除',
          'git.conflicts.title' => '检测到合并冲突',
          'git.conflicts.description' => '您必须在继续之前解决这些冲突。',
          'git.conflicts.abortMergeTitle' => '终止合并？',
          'git.conflicts.abortMergeContent' => '这将撤销所有合并更改并返回到合并前的状态。此操作无法撤销。',
          'git.conflicts.abortMergeAction' => '终止合并',
          'git.conflicts.stagingFile' => ({required Object file}) =>
              '正在暂存 ${file} 以提交...',
          'git.conflicts.conflictedFilesCount' => ({required Object count}) =>
              '冲突文件 (${count})',
          'git.conflicts.selectFileToResolve' => '选择文件以解决',
          'git.conflicts.resolvingFile' => ({required Object file}) =>
              '正在解决：${file}',
          'git.conflicts.keepAllOurs' => '保留所有当前 (Ours)',
          'git.conflicts.acceptAllTheirs' => '接受所有传入 (Theirs)',
          'git.conflicts.allResolved' => '此文件中的所有冲突已解决！',
          'git.conflicts.markResolved' => '标记为已解决',
          'git.conflicts.stageForCommit' => '这将暂存文件以进行提交。',
          'git.conflicts.conflictIndex' => ({required Object index}) =>
              '冲突 #${index}',
          'git.conflicts.ours' => 'OURS (当前)',
          'git.conflicts.theirs' => 'THEIRS (传入)',
          'git.conflicts.keepOurs' => '保留当前',
          'git.conflicts.acceptTheirs' => '接受传入',
          'git.conflicts.empty' => '(空)',
          'quality._translatorNote' =>
            'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.',
          'quality.title' => '质量仪表盘',
          'quality.overallScore' => '总体评分',
          'quality.issues' => '问题',
          'quality.warnings' => '警告',
          'quality.suggestions' => '建议',
          'quality.placeholderMismatch' => '占位符不匹配',
          'quality.placeholderMismatchDescription' => '占位符如 {name} 在源和目标之间不匹配',
          'quality.lengthOutlier' => '长度异常',
          'quality.lengthOutlierDescription' => '翻译长度与源文本差异显著',
          'quality.duplicateValue' => '重复值',
          'quality.duplicateValueDescription' => '多个键使用相同的翻译',
          'quality.missingTranslation' => '缺失翻译',
          'quality.missingTranslationDescription' => '此键缺少翻译',
          'quality.loading' => '正在加载仪表盘...',
          'quality.errorLoading' => '无法加载您的历史记录。请重试。',
          'quality.emptyState' => '运行对比以查看您的仪表盘。',
          'quality.refresh' => '刷新',
          'quality.buildingInsights' => '正在构建洞察...',
          'quality.crunchingNumbers' => '正在处理数据...',
          'quality.errorBuilding' => '无法构建仪表盘。请重试。',
          'quality.noUsableData' => '尚未找到可用数据。',
          'quality.languages' => '语言',
          'quality.averageCoverage' => '平均覆盖率',
          'quality.potentialIssues' => '潜在问题',
          'quality.translationCoverage' => '翻译覆盖率',
          'quality.entriesTranslated' => (
                  {required Object total, required Object translated}) =>
              '${total} 个条目中已翻译 ${translated} 个',
          'quality.wordsAddedOverTime' => '随时间新增词数',
          'quality.completionVsScope' => '完成度 vs 范围',
          'quality.scopeVsProgress' => '范围 vs 进度',
          'quality.coveragePercent' => '覆盖率 %',
          'quality.wordsAdded' => '新增词数',
          'quality.words' => '词数',
          'quality.coverage' => '覆盖率',
          'quality.scope' => '范围',
          'quality.latest' => '最新',
          'quality.added' => '新增',
          'quality.change' => '变化',
          'quality.totalScope' => '总范围',
          'quality.wordsCount' => ({required Object count}) => '${count} 字',
          'quality.scopeGrowth' => '范围增长',
          'quality.range' => '范围',
          'quality.aiUsage' => 'AI 与翻译使用情况',
          'quality.lastUsed' => ({required Object date}) => '上次使用 ${date}',
          'quality.noIssuesFound' => '在最近的对比中未发现问题。',
          'quality.placeholderMismatches' => '占位符不匹配',
          'quality.placeholderMismatchesDesc' => '标记如 {name} 不匹配。',
          'quality.lengthOutliers' => '过短或过长的翻译',
          'quality.lengthOutliersDesc' => '长度与源文本相比看起来不正常。',
          'quality.duplicateValues' => '重复值',
          'quality.duplicateValuesDesc' => '相同的翻译被多次使用。',
          'quality.placeholderDialogTitle' => '占位符不匹配',
          'quality.placeholderDialogDesc' => '这些翻译的占位符 ({name}) 与源文本不同。',
          'quality.lengthDialogTitle' => '长度异常',
          'quality.lengthDialogDesc' => '这些翻译比源文本显著更短或更长。',
          'quality.duplicateDialogTitle' => '重复值',
          'quality.duplicateDialogDesc' => '这些翻译多次出现。',
          'quality.duplicateSample' => ({required Object value}) =>
              '重复："${value}"',
          'quality.exportError' => '无法构建报告。请重试。',
          'quality.noDataToExport' => '没有数据可导出',
          'quality.exportFailed' => '导出失败',
          'quality.exportDialogTitle' => '导出质量报告',
          'quality.reportSaved' => '报告已保存',
          'quality.export' => '导出',
          'quality.requests' => 'Requests',
          'quality.tokens' => 'Tokens',
          'quality.characters' => 'Characters',
          'quality.estCost' => '预估成本',
          'quality.prompt' => 'Prompt',
          'quality.completion' => 'Completion',
          'quality.showingCurrentProject' => '显示：当前项目',
          'quality.showingAllHistory' => '显示：所有历史',
          'quality.filesSkipped' => '部分文件因未找到而被跳过。',
          'errors.genericError' => '发生错误',
          'errors.fileNotFound' => '文件未找到',
          'errors.invalidFormat' => '无效的文件格式',
          'errors.parseError' => '解析文件失败',
          'errors.networkError' => '网络错误。请检查您的连接。',
          'errors.permissionDenied' => '权限被拒绝',
          'errors.unknownError' => '发生未知错误',
          'wizards.firstRun.welcome' => '欢迎使用 Localizer',
          'wizards.firstRun.description' => '几秒钟内对比您的本地化文件。',
          'wizards.firstRun.sourceFile' => '源文件',
          'wizards.firstRun.targetFile' => '目标文件',
          'wizards.firstRun.compareNow' => '立即对比',
          'wizards.firstRun.trySample' => '尝试示例数据',
          'wizards.firstRun.skip' => '跳过设置',
          'wizards.firstRun.browse' => '点击浏览',
          'wizards.firstRun.error' => ({required Object error}) =>
              '加载示例数据失败：${error}',
          'dialogs.addIgnorePattern.title' => '添加忽略模式',
          'dialogs.addIgnorePattern.patternLabel' => '模式 (正则表达式)',
          'dialogs.addIgnorePattern.hint' => '例如，^temp_.*',
          'dialogs.addIgnorePattern.invalid' => '无效的正则表达式模式',
          'dialogs.addIgnorePattern.testStringLabel' => '测试字符串',
          'dialogs.addIgnorePattern.testHint' => '输入键以测试模式',
          'dialogs.addIgnorePattern.match' => '✓ 模式匹配测试字符串',
          'dialogs.addIgnorePattern.noMatch' => '✗ 模式不匹配',
          'dialogs.addIgnorePattern.add' => '添加',
          'dialogs.addIgnorePattern.cancel' => '取消',
          'dialogs.diffViewer.title' => '差异查看器',
          'dialogs.diffViewer.originalFile' => '原始/参考文件',
          'dialogs.diffViewer.translationFile' => '翻译/对比文件',
          'dialogs.diffViewer.base' => 'BASE',
          'dialogs.diffViewer.target' => 'TARGET',
          'dialogs.diffViewer.added' => '新增',
          'dialogs.diffViewer.removed' => '移除',
          'dialogs.diffViewer.modified' => '修改',
          'dialogs.diffViewer.noMatches' => '没有条目匹配当前过滤器',
          'dialogs.diffViewer.clickToggle' => '点击上方徽章以切换过滤器',
          'dialogs.diffViewer.clickToHide' => '(点击隐藏)',
          'dialogs.diffViewer.clickToShow' => '(点击显示)',
          'grid.columns.key' => '键',
          'grid.columns.source' => '源',
          'grid.columns.status' => '状态',
          'grid.columns.actions' => '操作',
          'tutorial.skipTutorial' => '跳过教程',
          'tutorial.finishMessage' => '一切准备就绪！点击任意位置完成。',
          'tutorial.next' => '下一步',
          'tutorial.loadSampleData' => '加载示例数据',
          'tutorial.browseSourceFile' => '浏览源文件',
          'tutorial.browseTargetFile' => '浏览目标文件',
          'tutorial.compareFiles' => '对比文件',
          'tutorial.hintPhase2' => '下一步：过滤器、搜索、高级视图和导出。',
          'tutorial.steps.importSource.title' => '1. 导入源文件',
          'tutorial.steps.importSource.description' => '使用下方按钮浏览文件，或拖放到高亮区域。',
          'tutorial.steps.importTarget.title' => '2. 导入目标文件',
          'tutorial.steps.importTarget.description' => '使用下方按钮浏览文件，或拖放到高亮区域。',
          'tutorial.steps.compare.title' => '3. 对比文件',
          'tutorial.steps.compare.description' => '点击下方按钮运行对比并查看结果。',
          'tutorial.steps.filter.title' => '4. 过滤结果',
          'tutorial.steps.filter.description' => '使用这些过滤器查看新增、移除或修改的字符串。',
          'tutorial.steps.search.title' => '5. 搜索结果',
          'tutorial.steps.search.description' => '使用搜索栏查找特定键或值。',
          'tutorial.steps.advanced.title' => '6. 高级视图',
          'tutorial.steps.advanced.description' => '打开详细差异视图，支持编辑、AI 翻译等功能。',
          'tutorial.steps.export.title' => '7. 导出结果',
          'tutorial.steps.export.description' =>
            '将您的对比结果保存为 CSV、JSON 或 Excel 文件。',
          'friendlyErrors.fileNotFound.message' => '无法找到该文件或文件夹。',
          'friendlyErrors.fileNotFound.suggestion' => '请检查文件是否被移动或删除。',
          'friendlyErrors.accessDenied.message' => '访问文件被拒绝。',
          'friendlyErrors.accessDenied.suggestion' => '尝试以管理员身份运行应用或检查文件权限。',
          'friendlyErrors.isDirectory.message' => '选择的是文件夹而非文件。',
          'friendlyErrors.isDirectory.suggestion' => '请选择一个有效的文件。',
          'friendlyErrors.fileAccess.message' => '访问文件时出现问题。',
          'friendlyErrors.fileAccess.suggestion' => '尝试关闭可能正在使用该文件的其他程序。',
          'friendlyErrors.unsupportedFormat.message' => '不支持此文件格式或操作。',
          'friendlyErrors.unsupportedFormat.suggestion' => '检查文件扩展名或尝试其他格式。',
          'friendlyErrors.networkError.message' => '无法连接到服务器。',
          'friendlyErrors.networkError.suggestion' => '检查您的互联网连接并重试。',
          'friendlyErrors.notGitRepo.message' => '此文件夹不是 Git 项目。',
          'friendlyErrors.notGitRepo.suggestion' => '导航到包含 .git 目录的文件夹。',
          'friendlyErrors.mergeConflict.message' => '仓库中存在合并冲突。',
          'friendlyErrors.mergeConflict.suggestion' => '继续之前请解决冲突。',
          'friendlyErrors.gitAuthFailed.message' => 'Git 验证失败。',
          'friendlyErrors.gitAuthFailed.suggestion' => '请在 设置 > 版本控制 中检查您的凭据。',
          'friendlyErrors.gitOperationFailed.message' => 'Git 操作失败。',
          'friendlyErrors.gitOperationFailed.suggestion' =>
            '查看 Git 视图以获取更多详细信息。',
          'friendlyErrors.invalidJson.message' => '文件格式无效或已损坏。',
          'friendlyErrors.invalidJson.suggestion' => '确保文件包含有效的 JSON 内容。',
          'friendlyErrors.rateLimitReached.message' => '达到翻译限制。',
          'friendlyErrors.rateLimitReached.suggestion' =>
            '请稍候几分钟或检查您的 API 计划限制。',
          'friendlyErrors.invalidApiKey.message' => '无效的 API 密钥。',
          'friendlyErrors.invalidApiKey.suggestion' =>
            '前往 设置 > AI 翻译 更新您的 API 密钥。',
          'friendlyErrors.translationServiceError.message' => '翻译服务错误。',
          'friendlyErrors.translationServiceError.suggestion' =>
            '检查您的 API 密钥和互联网连接。',
          'friendlyErrors.outOfMemory.message' => '内存不足，无法完成此操作。',
          'friendlyErrors.outOfMemory.suggestion' => '尝试关闭其他应用程序或使用更小的文件。',
          'friendlyErrors.genericError.message' => '出错了。',
          'friendlyErrors.genericError.suggestion' => '请重试。如果问题持续，请重启应用。',
          'systemTray.showLocalizer' => '显示 Localizer',
          'systemTray.exit' => '退出',
          'validation.connected' => '已连接。',
          'validation.connectionTimeout' => '连接超时。请重试。',
          'validation.couldNotConnect' => '无法连接。请重试。',
          'validation.checkKeyAndTryAgain' => '无法连接。请检查密钥并重试。',
          'validation.tryAgainLater' => '暂时无法连接。请稍后重试。',
          'validation.serviceUnavailable' => '服务当前不可用。请稍后重试。',
          'validation.enterKeyFirst' => '请先输入密钥。',
          'validation.checking' => '正在检查...',
          'validation.deeplUsage' => (
                  {required Object used, required Object limit}) =>
              '使用量：${used} / ${limit} 字符。',
          'status.startingComparison' => '正在开始对比...',
          'status.loadingFromHistory' => '正在从历史记录加载文件...',
          'status.comparisonComplete' => '对比完成',
          'status.couldNotImportFiles' => '无法导入文件。请重试。',
          'status.historyFilesNotFound' => '在原始路径未找到来自历史的一个或两个文件。',
          'aiServices.geminiEmptyResponse' => 'Gemini 返回了空响应',
          'aiServices.geminiStreamingEmpty' => 'Gemini 流式传输返回了空响应',
          'aiServices.geminiRephraseEmpty' => 'Gemini 改写返回了空响应',
          'aiServices.openaiEmptyResponse' => 'OpenAI 返回了空或失败的响应',
          _ => null,
        };
  }
}
