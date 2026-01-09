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
class TranslationsKo extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsKo(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.ko,
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

  /// Metadata for the translations of <ko>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsKo _root = this; // ignore: unused_field

  @override
  TranslationsKo $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsKo(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsAppKo app = _TranslationsAppKo._(_root);
  @override
  late final _TranslationsCommonKo common = _TranslationsCommonKo._(_root);
  @override
  late final _TranslationsMenuKo menu = _TranslationsMenuKo._(_root);
  @override
  late final _TranslationsNavKo nav = _TranslationsNavKo._(_root);
  @override
  late final _TranslationsSettingsKo settings =
      _TranslationsSettingsKo._(_root);
  @override
  late final _TranslationsFileComparisonKo fileComparison =
      _TranslationsFileComparisonKo._(_root);
  @override
  late final _TranslationsDirectoryComparisonKo directoryComparison =
      _TranslationsDirectoryComparisonKo._(_root);
  @override
  late final _TranslationsGitComparisonKo gitComparison =
      _TranslationsGitComparisonKo._(_root);
  @override
  late final _TranslationsAdvancedComparisonKo advancedComparison =
      _TranslationsAdvancedComparisonKo._(_root);
  @override
  late final _TranslationsAdvancedDiffKo advancedDiff =
      _TranslationsAdvancedDiffKo._(_root);
  @override
  late final _TranslationsIssueDetailsKo issueDetails =
      _TranslationsIssueDetailsKo._(_root);
  @override
  late final _TranslationsImportReviewKo importReview =
      _TranslationsImportReviewKo._(_root);
  @override
  late final _TranslationsHistoryViewKo historyView =
      _TranslationsHistoryViewKo._(_root);
  @override
  late final _TranslationsCompareKo compare = _TranslationsCompareKo._(_root);
  @override
  late final _TranslationsHistoryKo history = _TranslationsHistoryKo._(_root);
  @override
  late final _TranslationsProjectsKo projects =
      _TranslationsProjectsKo._(_root);
  @override
  late final _TranslationsDiffKo diff = _TranslationsDiffKo._(_root);
  @override
  late final _TranslationsGitKo git = _TranslationsGitKo._(_root);
  @override
  late final _TranslationsQualityKo quality = _TranslationsQualityKo._(_root);
  @override
  late final _TranslationsErrorsKo errors = _TranslationsErrorsKo._(_root);
  @override
  late final _TranslationsWizardsKo wizards = _TranslationsWizardsKo._(_root);
  @override
  late final _TranslationsDialogsKo dialogs = _TranslationsDialogsKo._(_root);
  @override
  late final _TranslationsGridKo grid = _TranslationsGridKo._(_root);
  @override
  late final _TranslationsTutorialKo tutorial =
      _TranslationsTutorialKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsKo friendlyErrors =
      _TranslationsFriendlyErrorsKo._(_root);
  @override
  late final _TranslationsSystemTrayKo systemTray =
      _TranslationsSystemTrayKo._(_root);
  @override
  late final _TranslationsValidationKo validation =
      _TranslationsValidationKo._(_root);
  @override
  late final _TranslationsStatusKo status = _TranslationsStatusKo._(_root);
  @override
  late final _TranslationsAiServicesKo aiServices =
      _TranslationsAiServicesKo._(_root);
}

// Path: app
class _TranslationsAppKo extends TranslationsAppEn {
  _TranslationsAppKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '로컬라이제이션 비교 도구';
  @override
  String get name => 'Localizer';
}

// Path: common
class _TranslationsCommonKo extends TranslationsCommonEn {
  _TranslationsCommonKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get save => '저장';
  @override
  String get cancel => '취소';
  @override
  String get close => '닫기';
  @override
  String get delete => '삭제';
  @override
  String get edit => '편집';
  @override
  String get add => '추가';
  @override
  String get search => '검색';
  @override
  String get undo => '실행 취소';
  @override
  String get loading => '로딩 중...';
  @override
  String get error => '오류';
  @override
  String get success => '성공';
  @override
  String get warning => '경고';
  @override
  String get info => '정보';
  @override
  String get confirm => '확인';
  @override
  String get yes => '예';
  @override
  String get no => '아니요';
  @override
  String get ok => '확인';
  @override
  String get retry => '재시도';
  @override
  String get copyText => '복사';
  @override
  String get appName => 'Localizer';
  @override
  String get copied => '복사됨!';
  @override
  String get enabled => '사용';
  @override
  String get disabled => '사용 안 함';
  @override
  String get browse => '찾아보기';
  @override
  String get clear => '지우기';
  @override
  String get apply => '적용';
  @override
  String get reset => '초기화';
  @override
  String get refresh => '새로 고침';
  @override
  String get export => '내보내기';
  @override
  String get import => '가져오기';
  @override
  String get select => '선택';
  @override
  String get selectAll => '전체 선택';
  @override
  String get deselectAll => '전체 선택 해제';
  @override
  String get noResults => '결과 없음';
  @override
  String get emptyState => '내용이 없습니다';
  @override
  String get open => '열기';
  @override
  String get change => '변경';
  @override
  String get original => '원본';
  @override
  String get kNew => '신규';
  @override
  String get remove => '제거';
  @override
  String get auto => '자동';
  @override
  String get execute => '실행';
  @override
  String get run => '실행';
  @override
  String get unknown => '알 수 없음';
  @override
  String get download => '다운로드';
  @override
  String get dropdownArrow => '드롭다운 화살표';
  @override
  String get openInNewWindow => '새 창에서 열기';
  @override
  String get resetToDefaults => '기본값으로 재설정';
}

// Path: menu
class _TranslationsMenuKo extends TranslationsMenuEn {
  _TranslationsMenuKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get file => '파일';
  @override
  String get edit => '편집';
  @override
  String get view => '보기';
  @override
  String get help => '도움말';
  @override
  String get openFiles => '파일 열기...';
  @override
  String get openFolder => '폴더 열기...';
  @override
  String get exportResults => '결과 내보내기...';
  @override
  String get undo => '실행 취소';
  @override
  String get redo => '다시 실행';
  @override
  String get cut => '오려두기';
  @override
  String get paste => '붙여넣기';
  @override
  String get selectAll => '전체 선택';
  @override
  String get zoomIn => '확대';
  @override
  String get zoomOut => '축소';
  @override
  String get resetZoom => '배율 초기화';
  @override
  String get documentation => '문서';
  @override
  String get reportIssue => '문제 보고';
  @override
  String about({required Object appName}) => '${appName} 정보';
}

// Path: nav
class _TranslationsNavKo extends TranslationsNavEn {
  _TranslationsNavKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get compare => '비교';
  @override
  String get history => '기록';
  @override
  String get settings => '설정';
  @override
  String get projects => '프로젝트';
  @override
  String get dashboard => '대시보드';
  @override
  String get directory => '디렉토리';
  @override
  String get repository => '저장소';
  @override
  String get tooltipCompare => '로컬라이제이션 파일 비교';
  @override
  String get tooltipHistory => '비교 기록 보기';
  @override
  String get tooltipSettings => '앱 설정';
  @override
  String get tooltipProjects => '프로젝트 관리';
  @override
  String get tooltipThemeToggle => '테마 전환';
  @override
  String get tooltipDebugConsole => '디버그 콘솔';
}

// Path: settings
class _TranslationsSettingsKo extends TranslationsSettingsEn {
  _TranslationsSettingsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '설정';
  @override
  String get appSettings => '앱 설정';
  @override
  String get projectSettings => '프로젝트 설정';
  @override
  late final _TranslationsSettingsAppearanceKo appearance =
      _TranslationsSettingsAppearanceKo._(_root);
  @override
  late final _TranslationsSettingsGeneralKo general =
      _TranslationsSettingsGeneralKo._(_root);
  @override
  late final _TranslationsSettingsScopeKo scope =
      _TranslationsSettingsScopeKo._(_root);
  @override
  late final _TranslationsSettingsSearchKeywordsKo searchKeywords =
      _TranslationsSettingsSearchKeywordsKo._(_root);
  @override
  late final _TranslationsSettingsComparisonKo comparison =
      _TranslationsSettingsComparisonKo._(_root);
  @override
  late final _TranslationsSettingsFileHandlingKo fileHandling =
      _TranslationsSettingsFileHandlingKo._(_root);
  @override
  late final _TranslationsSettingsTranslationMemoryKo translationMemory =
      _TranslationsSettingsTranslationMemoryKo._(_root);
  @override
  late final _TranslationsSettingsBackupKo backup =
      _TranslationsSettingsBackupKo._(_root);
  @override
  late final _TranslationsSettingsAiKo ai = _TranslationsSettingsAiKo._(_root);
  @override
  late final _TranslationsSettingsIntegrationsKo integrations =
      _TranslationsSettingsIntegrationsKo._(_root);
  @override
  late final _TranslationsSettingsDeveloperKo developer =
      _TranslationsSettingsDeveloperKo._(_root);
  @override
  late final _TranslationsSettingsAboutKo about =
      _TranslationsSettingsAboutKo._(_root);
  @override
  late final _TranslationsSettingsOnboardingKo onboarding =
      _TranslationsSettingsOnboardingKo._(_root);
  @override
  late final _TranslationsSettingsSettingsViewKo settingsView =
      _TranslationsSettingsSettingsViewKo._(_root);
}

// Path: fileComparison
class _TranslationsFileComparisonKo extends TranslationsFileComparisonEn {
  _TranslationsFileComparisonKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '파일 비교';
  @override
  String get openFiles => '파일 열기';
  @override
  String get exportResults => '결과 내보내기';
  @override
  String get restartTutorial => '자습서 다시 시작';
  @override
  String get restartTutorialDevOnly => '자습서 다시 시작은 개발자 모드에서만 사용할 수 있습니다.';
  @override
  String get unsupportedFileType => '지원되지 않는 파일 형식입니다.';
  @override
  String get unsupportedFileTypeSuggestion => '지원되는 로컬라이제이션 파일을 선택하세요.';
  @override
  String get someFilesUnsupported => '일부 파일은 지원되지 않습니다.';
  @override
  String get pickSupportedFiles => '지원되는 로컬라이제이션 파일만 선택하세요.';
  @override
  String get pickTwoFiles => '비교할 두 파일을 선택하세요.';
  @override
  String get pickBilingualFile => '비교할 이중 언어 파일을 선택하세요.';
  @override
  String get noResultsToExport => '아직 내보낼 결과가 없습니다.';
  @override
  String get performComparisonFirst => '결과를 내보내려면 먼저 비교를 수행하세요.';
  @override
  String get performComparisonFirstEditor => '고급 세부 정보를 보려면 먼저 비교를 수행하세요.';
  @override
  String get sampleDataLoaded => '샘플 데이터가 성공적으로 로드되었습니다';
  @override
  String loadSampleDataError({required Object error}) =>
      '샘플 데이터 로드 실패: ${error}';
  @override
  String get invalidFileType => '잘못된 파일 형식입니다.';
  @override
  String fileSelected({required Object label, required Object fileName}) =>
      '${label} 선택됨: ${fileName}';
  @override
  String get sourceFile => '소스 파일';
  @override
  String get targetFile => '타겟 파일';
  @override
  String get bilingualFile => '이중 언어 파일';
  @override
  String get compareFiles => '파일 비교';
  @override
  String get compareFile => '파일 비교';
  @override
  String get bilingualMode => '이중 언어 모드';
  @override
  String get twoFilesMode => '두 파일';
  @override
  String get processing => '처리 중...';
  @override
  String remaining({required Object time}) => '${time} 남음';
  @override
  String get comparisonInProgress => '비교 진행 중...';
  @override
  String comparisonFailed({required Object error}) => '비교 실패: ${error}';
  @override
  String fileChanged({required Object fileName}) =>
      '파일 변경됨: ${fileName}. 다시 비교 중...';
  @override
  String get dropFileHere => '여기에 파일 놓기';
  @override
  String get dropFileOrBrowse => '파일을 놓거나 클릭하여 찾아보기';
  @override
  String get fileUpload => '파일 업로드';
  @override
  String get changeFile => '파일 변경';
  @override
  String get total => '합계';
  @override
  String get show => '표시';
  @override
  String get showAll => '모두 표시';
  @override
  String noMatches({required Object query}) => '"${query}"에 대한 일치 항목 없음';
  @override
  String showingEntries({required Object total, required Object count}) =>
      '${total}개 중 ${count}개 항목 표시 중';
  @override
  String get filesIdentical => '파일이 동일합니다.';
  @override
  String hiddenIdentical({required Object count}) => '${count}개 동일한 항목 숨겨짐';
  @override
  String get showIdentical => '동일한 항목 표시';
  @override
  String get hideIdentical => '동일한 항목 숨기기';
  @override
  String get noDiff => '키를 기반으로 한 차이점이 없습니다.';
  @override
  String get source => '소스';
  @override
  String get target => '타겟';
  @override
  String get value => '값';
  @override
  String get readyToCompare => '파일 비교 준비 완료';
  @override
  String get readyToCompareDesc =>
      '위에 로컬라이제이션 파일을 놓거나 찾아보기 버튼을 사용하여\n비교할 파일을 선택하세요.';
  @override
  String get recentComparisons => '최근 비교';
  @override
  String bilingualFileLabel({required Object name}) => '이중 언어 파일: ${name}';
  @override
  String comparisonLabel({required Object source, required Object target}) =>
      '${source} ↔ ${target}';
  @override
  String get fileNotExist => '이 세션의 파일 중 하나 또는 둘 다 더 이상 존재하지 않습니다.';
  @override
  String get largeFileTitle => '대용량 파일 감지됨';
  @override
  String largeFileContent({required Object count}) =>
      '비교 결과에 ${count}개 항목이 포함되어 있습니다.\n모두 표시하면 성능 문제가 발생할 수 있습니다.\n\n계속하시겠습니까?';
  @override
  String get dontShowAgain => '이 파일에 대해 다시 표시 안 함';
  @override
  String get proceed => '계속';
  @override
  String exportReport({required Object format}) => '${format} 보고서 저장';
  @override
  String saved({required Object format}) => '${format} 저장됨';
  @override
  String saveError({required Object format}) => '${format} 파일 저장 실패.';
  @override
  String saveErrorDetailed({required Object format, required Object error}) =>
      '${format} 저장 실패: ${error}';
  @override
  String get watching => '감시 중';
  @override
  String get watchOff => '감시 끄기';
  @override
  String watchingTooltip({required Object status}) =>
      '파일 감시: ${status}\n디스크에서 파일 변경 시 자동으로 다시 비교';
  @override
  String get aiSettingsNotAvailable => 'AI 설정으로 이동할 수 없음';
}

// Path: directoryComparison
class _TranslationsDirectoryComparisonKo
    extends TranslationsDirectoryComparisonEn {
  _TranslationsDirectoryComparisonKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '디렉토리 비교';
  @override
  String get sourceDirectory => '소스 디렉토리';
  @override
  String get targetDirectory => '타겟 디렉토리';
  @override
  String get sourceSubtitle => '원본/참조 파일';
  @override
  String get targetSubtitle => '번역/비교 파일';
  @override
  String get selectBothDirectories => '소스 및 타겟 디렉토리를 모두 선택하세요.';
  @override
  String get selectSourceFolder => '소스 폴더 선택';
  @override
  String get selectTargetFolder => '타겟 폴더 선택';
  @override
  String get dropFolderHere => '여기에 폴더를 놓거나 찾아보기...';
  @override
  String get folderPath => '폴더 경로';
  @override
  String get readyToCompare => '디렉토리 비교 준비 완료';
  @override
  String get readyToCompareDesc => '위에 폴더를 놓거나 찾아보기 버튼을 사용하여\n비교할 디렉토리를 선택하세요.';
  @override
  String get nestedFolders => '중첩 폴더';
  @override
  String get nestedFoldersTooltip => '모든 중첩 디렉토리를 재귀적으로 비교합니다';
  @override
  String get fileMatching => '파일 일치';
  @override
  String get fileMatchingTooltip => '이름별로 파일을 자동으로 쌍으로 연결합니다';
  @override
  String get bulkExport => '일괄 내보내기';
  @override
  String get bulkExportTooltip => '모든 비교 결과를 한 번에 내보냅니다';
  @override
  String get notDirectoryComparison => '디렉토리 비교가 아닙니다.';
  @override
  String get directoriesNotExist => '하나 또는 두 디렉토리가 더 이상 존재하지 않습니다.';
  @override
  String get errorOccurred => '오류 발생';
  @override
  String get noFilesFound => '선택한 디렉토리에서 파일을 찾을 수 없습니다.';
  @override
  String get unmatchedSourceFiles => '일치하지 않는 소스 파일';
  @override
  String get unmatchedTargetFiles => '일치하지 않는 타겟 파일';
  @override
  String filePairs({required Object count}) => '${count}개 파일 쌍';
  @override
  String pairedFiles({required Object count}) => '쌍으로 연결된 파일 (${count})';
  @override
  String get view => '보기';
  @override
  String get failed => '실패';
  @override
  String get pair => '연결...';
  @override
  String pairDialogTitle({required Object name}) => '"${name}" 연결 대상:';
  @override
  String get discoverFiles => '파일 검색';
  @override
  String get compareAll => '모두 비교';
  @override
  String get exportAll => '모두 내보내기';
  @override
  String get comparisonStarted => '비교 시작됨...';
  @override
  String get discoveringFiles => '파일 검색 중...';
  @override
  String get noResultsToExport => '내보낼 비교 결과가 없습니다. 먼저 "모두 비교"를 실행하세요.';
  @override
  String get selectExportFolder => '내보내기 폴더 선택';
  @override
  String createExportFolderError({required Object error}) =>
      '내보내기 폴더 생성 실패: ${error}';
  @override
  String get exportingResults => '결과 내보내는 중';
  @override
  String processingFile({required Object file}) => '처리 중: ${file}';
  @override
  String exportProgress({required Object total, required Object current}) =>
      '${total}개 중 ${current}개 파일 내보냄';
  @override
  String get exportComplete => '내보내기 완료';
  @override
  String exportSuccessMessage({required Object count}) =>
      '요약과 함께 ${count}개 비교 파일을 성공적으로 내보냈습니다.';
  @override
  String exportFailed({required Object error}) => '내보내기 실패: ${error}';
  @override
  String get close => '닫기';
}

// Path: gitComparison
class _TranslationsGitComparisonKo extends TranslationsGitComparisonEn {
  _TranslationsGitComparisonKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'Git 용어(Branch, Commit, Checkout, Merge, Conflict, Pull, Push)는 개발자들 사이의 혼란을 피하기 위해 모든 번역에서 영어로 유지해야 합니다.';
  @override
  String get title => '저장소 비교';
  @override
  String get repoSelector => '저장소 생성 / 열기';
  @override
  String get noRepoSelected => '선택된 저장소 없음';
  @override
  String get open => '열기';
  @override
  String get refreshCommits => '커밋 새로 고침';
  @override
  String get noCommits => '커밋을 찾거나 로드할 수 없습니다. 커밋을 로드하려면 브랜치를 선택하세요.';
  @override
  String get baseCommit => '베이스 커밋 (이전)';
  @override
  String get targetCommit => '타겟 커밋 (최신)';
  @override
  String get filterCommitsByBranch => '브랜치별 커밋 필터링';
  @override
  String get conflictDetection => '충돌 감지';
  @override
  String get conflictDetectionTooltip => '병합 충돌 감지 및 해결';
  @override
  String get actions => '작업:';
  @override
  String get checkout => 'Checkout';
  @override
  String get merge => 'Merge';
  @override
  String get pull => 'Pull';
  @override
  String get checkoutBranch => 'Branch Checkout';
  @override
  String get mergeBranch => '현재 Branch로 Merge';
  @override
  String mergeConfirmation({required Object branch}) => '${branch}를 병합하시겠습니까?';
  @override
  String get mergeWarning => '현재 작업 브랜치에 변경 사항이 병합됩니다. 충돌이 발생할 수 있습니다.';
  @override
  String get selectExportFolder => '내보내기 폴더 선택';
  @override
  String createExportFolderError({required Object error}) =>
      '내보내기 폴더 생성 실패: ${error}';
  @override
  String get exportingFiles => '파일 내보내는 중';
  @override
  String processingFile({required Object file}) => '처리 중: ${file}';
  @override
  String exportProgress({required Object total, required Object current}) =>
      '${total}개 중 ${current}개 파일 내보냄';
  @override
  String get exportComplete => '내보내기 완료';
  @override
  String exportSuccessMessage({required Object count}) =>
      '전체 내용이 포함된 ${count}개 파일을 성공적으로 내보냈습니다.';
  @override
  String get exportDetail => '각 파일의 diff는 "files" 하위 폴더에 저장됩니다.';
  @override
  String get diffViewer => 'Diff 뷰어';
  @override
  String get base => '베이스';
  @override
  String get target => '타겟';
  @override
  String get noLines => '표시할 줄 없음';
  @override
  String get searchFiles => '파일 검색...';
  @override
  String noFilesMatch({required Object query}) => '"${query}"와 일치하는 파일 없음';
  @override
  String filesCount({required Object count}) => '${count}개 파일';
  @override
  String get selectBaseFile => '베이스 파일 선택';
  @override
  String get selectTargetFile => '타겟 파일 선택';
  @override
  String get comparisonResults => '비교 결과';
  @override
  String get noChanges => '선택한 참조 간에 변경 사항이 없습니다.';
  @override
  String get linesAdded => '추가된 줄';
  @override
  String get linesRemoved => '제거된 줄';
  @override
  String get commit => 'Commit';
  @override
  String get branch => 'Branch';
  @override
  String get noRepositorySelected => '선택된 저장소 없음';
  @override
  String get notGitComparison => 'Git 비교가 아님';
  @override
  String get repositoryNotExist => '저장소가 존재하지 않음';
  @override
  String get mainBranch => 'main';
  @override
  String get masterBranch => 'master';
  @override
  String get backToControls => '비교 컨트롤로 돌아가기';
}

// Path: advancedComparison
class _TranslationsAdvancedComparisonKo
    extends TranslationsAdvancedComparisonEn {
  _TranslationsAdvancedComparisonKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get placeholder => '고급 비교 보기 - 자리 표시자';
}

// Path: advancedDiff
class _TranslationsAdvancedDiffKo extends TranslationsAdvancedDiffEn {
  _TranslationsAdvancedDiffKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get saveAllChanges => '모든 변경 사항 저장?';
  @override
  String saveConfirmation({required Object count}) =>
      '대상 파일에 ${count}개 수정된 항목이 저장됩니다. 이 작업은 취소할 수 없습니다.';
  @override
  String get changesSaved => '변경 사항이 성공적으로 저장되었습니다.';
  @override
  String get csvExported => 'CSV 내보내짐';
  @override
  String get unsavedChanges => '저장되지 않은 변경 사항';
  @override
  String get unsavedChangesWarning => '저장되지 않은 변경 사항이 있습니다. 정말로 취소하시겠습니까?';
  @override
  String get discardChanges => '변경 사항 취소';
  @override
  String get goBack => '뒤로 가기';
  @override
  String get breadcrumbs => '홈 > 편집기';
  @override
  String unsaved({required Object count}) => '${count}개 저장 안 됨';
  @override
  String reviewed({required Object count}) => '${count}개 검토됨';
  @override
  String saveAll({required Object count}) => '모두 저장 (${count})';
  @override
  String get allSaved => '모두 저장됨';
  @override
  String get saveAllTooltip => '모든 변경 사항 저장 (Ctrl+S)';
  @override
  String get exportTooltip => '데이터 내보내기 (Ctrl+E)';
  @override
  late final _TranslationsAdvancedDiffAiSuggestionKo aiSuggestion =
      _TranslationsAdvancedDiffAiSuggestionKo._(_root);
  @override
  late final _TranslationsAdvancedDiffDetailEditKo detailEdit =
      _TranslationsAdvancedDiffDetailEditKo._(_root);
  @override
  late final _TranslationsAdvancedDiffTableKo table =
      _TranslationsAdvancedDiffTableKo._(_root);
  @override
  late final _TranslationsAdvancedDiffDiffRowKo diffRow =
      _TranslationsAdvancedDiffDiffRowKo._(_root);
  @override
  late final _TranslationsAdvancedDiffStatusKo status =
      _TranslationsAdvancedDiffStatusKo._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarKo sidebar =
      _TranslationsAdvancedDiffSidebarKo._(_root);
}

// Path: issueDetails
class _TranslationsIssueDetailsKo extends TranslationsIssueDetailsEn {
  _TranslationsIssueDetailsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '문제 세부 정보';
  @override
  String showingIssues({required Object total, required Object count}) =>
      '${total}개 문제 중 ${count}개 표시 중';
  @override
  String get searchPlaceholder => '키, 텍스트 또는 오류 검색...';
  @override
  String get noDetails => '세부 정보 없음.';
  @override
  String get noMatches => '일치 항목 없음.';
  @override
  String get showMore => '더 보기';
  @override
  String copyItems({required Object count}) => '${count}개 항목 복사';
  @override
  String get close => '닫기';
  @override
  String get copied => '클립보드에 복사됨';
  @override
  String copiedCount({required Object count}) => '${count}개 항목 복사됨';
  @override
  late final _TranslationsIssueDetailsDuplicateValueKo duplicateValue =
      _TranslationsIssueDetailsDuplicateValueKo._(_root);
  @override
  late final _TranslationsIssueDetailsLengthOutlierKo lengthOutlier =
      _TranslationsIssueDetailsLengthOutlierKo._(_root);
  @override
  late final _TranslationsIssueDetailsStandardKo standard =
      _TranslationsIssueDetailsStandardKo._(_root);
  @override
  String get review => '검토';
  @override
  late final _TranslationsIssueDetailsTypesKo types =
      _TranslationsIssueDetailsTypesKo._(_root);
  @override
  late final _TranslationsIssueDetailsNotesKo notes =
      _TranslationsIssueDetailsNotesKo._(_root);
  @override
  late final _TranslationsIssueDetailsFallbacksKo fallbacks =
      _TranslationsIssueDetailsFallbacksKo._(_root);
}

// Path: importReview
class _TranslationsImportReviewKo extends TranslationsImportReviewEn {
  _TranslationsImportReviewKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '프로젝트 가져오기 검토';
  @override
  String get projectName => '프로젝트 이름';
  @override
  String get created => '생성됨';
  @override
  String get historyItems => '기록 항목';
  @override
  String get customSettingsTitle => '사용자 지정 설정 감지됨';
  @override
  String get customSettingsWarning =>
      '이 프로젝트에는 이 프로젝트가 열려 있는 동안 기본값을 재정의하는 사용자 지정 설정이 포함되어 있습니다.';
  @override
  String get standardSettings => '이 프로젝트는 표준 전역 설정을 사용합니다.';
  @override
  String get cancelImport => '가져오기 취소';
  @override
  String get trustOpen => '신뢰 & 프로젝트 열기';
}

// Path: historyView
class _TranslationsHistoryViewKo extends TranslationsHistoryViewEn {
  _TranslationsHistoryViewKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '비교 기록';
  @override
  String get clearAll => '모든 기록 지우기';
  @override
  String get searchPlaceholder => '파일 이름으로 검색...';
  @override
  String get sortBy => '정렬 기준';
  @override
  String get sortDate => '날짜';
  @override
  String get sortSource => '소스 파일';
  @override
  String get sortTarget => '타겟 파일';
  @override
  String get showCurrentProject => '표시 중: 현재 프로젝트';
  @override
  String get showAllHistory => '표시 중: 모든 기록';
  @override
  String get groupByFolder => '폴더별 그룹화';
  @override
  String get disableGrouping => '폴더 그룹화 비활성화';
  @override
  String get filterAll => '전체';
  @override
  String get filterFiles => '파일';
  @override
  String get filterDirectories => '디렉토리';
  @override
  String get filterGit => 'Git';
  @override
  String get noHistory => '아직 비교 기록이 없습니다';
  @override
  String get historyDescription => '파일 비교가 여기에 표시됩니다';
  @override
  String get noResults => '결과 없음';
  @override
  String get adjustSearch => '검색을 조정해 보세요';
  @override
  String get clearConfirmationTitle => '모든 기록을 지우시겠습니까?';
  @override
  String get clearConfirmationContent =>
      '모든 비교 기록이 영구적으로 삭제됩니다. 이 작업은 취소할 수 없습니다.';
  @override
  String get clearAction => '모두 지우기';
  @override
  String get deletedMessage => '기록 항목 삭제됨';
  @override
  String get undo => '실행 취소';
  @override
  String get viewDetails => '세부 정보 보기';
  @override
  String get delete => '삭제';
  @override
  String get openLocation => '파일 위치 열기';
  @override
  String get bilingual => '이중 언어';
  @override
  String get filePair => '파일 쌍';
  @override
  String get directory => '디렉토리';
  @override
  String get git => 'Git';
  @override
  String get repo => '저장소';
  @override
  String get sourceDir => '소스 디렉토리';
  @override
  String get targetDir => '타겟 디렉토리';
  @override
  String get source => '소스';
  @override
  String get target => '타겟';
  @override
  String get noChanges => '변경 사항 감지되지 않음';
  @override
  String get added => '추가됨';
  @override
  String get removed => '제거됨';
  @override
  String get modified => '수정됨';
  @override
  String get same => '동일함';
  @override
  String get total => '합계';
  @override
  String get currentProject => '현재 프로젝트';
  @override
  String get unassigned => '할당되지 않음';
  @override
  String get project => '프로젝트';
}

// Path: compare
class _TranslationsCompareKo extends TranslationsCompareEn {
  _TranslationsCompareKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '파일 비교';
  @override
  String get sourceFile => '소스 파일';
  @override
  String get targetFile => '타겟 파일';
  @override
  String get sourceFolder => '소스 폴더';
  @override
  String get targetFolder => '타겟 폴더';
  @override
  String get dropFilesHint =>
      '로컬라이제이션 파일을 여기에 놓거나 찾아보기 버튼을 사용하여 비교할 파일을 선택하세요.';
  @override
  String get selectSourceFile => '소스 파일 선택';
  @override
  String get selectTargetFile => '타겟 파일 선택';
  @override
  String get startComparison => '비교 시작';
  @override
  String get comparing => '비교 중...';
  @override
  String get comparisonComplete => '비교 완료';
  @override
  String get noChanges => '변경 사항 감지되지 않음';
  @override
  String get filesIdentical => '파일이 동일합니다';
  @override
  String changesFound({required Object count}) => '${count}개 변경 사항 발견됨';
  @override
  late final _TranslationsCompareTabsKo tabs =
      _TranslationsCompareTabsKo._(_root);
  @override
  late final _TranslationsCompareFileTypesKo fileTypes =
      _TranslationsCompareFileTypesKo._(_root);
}

// Path: history
class _TranslationsHistoryKo extends TranslationsHistoryEn {
  _TranslationsHistoryKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '기록';
  @override
  String get recentComparisons => '최근 비교';
  @override
  String get noHistory => '아직 비교 기록이 없습니다';
  @override
  String get noHistoryDescription => '비교 기록이 여기에 표시됩니다';
  @override
  String get clearHistory => '기록 지우기';
  @override
  String get clearHistoryConfirm => '모든 기록을 지우시겠습니까?';
  @override
  String get deleteEntry => '항목 삭제';
  @override
  String get openComparison => '비교 열기';
  @override
  late final _TranslationsHistoryTimeAgoKo timeAgo =
      _TranslationsHistoryTimeAgoKo._(_root);
}

// Path: projects
class _TranslationsProjectsKo extends TranslationsProjectsEn {
  _TranslationsProjectsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '프로젝트';
  @override
  String get createProject => '프로젝트 생성';
  @override
  String get importProject => '프로젝트 가져오기';
  @override
  String get noProjects => '프로젝트 없음';
  @override
  String get noProjectsDescription => '로컬라이제이션 파일을 정리하려면 프로젝트를 생성하세요';
  @override
  String get projectName => '프로젝트 이름';
  @override
  String get projectPath => '프로젝트 경로';
  @override
  String get lastOpened => '마지막으로 연 날짜';
  @override
  String get openProject => '프로젝트 열기';
  @override
  String get closeProject => '프로젝트 닫기';
  @override
  String get deleteProject => '프로젝트 삭제';
  @override
  String get deleteProjectConfirm => '이 프로젝트를 삭제하시겠습니까?';
  @override
  String get exportProject => '프로젝트 내보내기';
  @override
  String get exportDescription => '소스 파일, 구성 및 기록이 포함된 휴대용 zip 파일을 생성합니다.';
  @override
  String get exporting => '프로젝트 내보내는 중...';
  @override
  String get exportSuccess => '프로젝트 내보내짐';
  @override
  String exportError({required Object error}) => '내보내기 실패: ${error}';
  @override
  String get createNewProject => '새 프로젝트 생성';
  @override
  String get openExistingProject => '기존 프로젝트 열기';
  @override
  String get importProjectZip => '프로젝트 Zip 가져오기';
  @override
  String get projectResources => '프로젝트 리소스';
  @override
  String get recentProjects => '최근 프로젝트';
  @override
  String get noRecentProjects => '최근 프로젝트 없음';
  @override
  String get selectProjectZip => '프로젝트 Zip 선택';
  @override
  String get selectDestination => '가져오기 대상 폴더 선택';
  @override
  String get importing => '프로젝트 가져오는 중...';
  @override
  String get importSuccess => '프로젝트를 성공적으로 가져왔습니다';
  @override
  String importFailed({required Object error}) => '가져오기 실패: ${error}';
  @override
  String get importingFiles => '파일 가져오는 중...';
  @override
  String get noSupportedFiles => '지원되는 파일이 없습니다.';
  @override
  late final _TranslationsProjectsStatsKo stats =
      _TranslationsProjectsStatsKo._(_root);
  @override
  String get openProjectFirst => '리소스를 관리하려면 먼저 프로젝트를 여세요.';
  @override
  String get removeFromRecent => '최근 항목에서 제거';
  @override
  late final _TranslationsProjectsSelectionKo selection =
      _TranslationsProjectsSelectionKo._(_root);
  @override
  late final _TranslationsProjectsCreateDialogKo createDialog =
      _TranslationsProjectsCreateDialogKo._(_root);
  @override
  late final _TranslationsProjectsIndicatorKo indicator =
      _TranslationsProjectsIndicatorKo._(_root);
  @override
  late final _TranslationsProjectsGlossaryKo glossary =
      _TranslationsProjectsGlossaryKo._(_root);
  @override
  late final _TranslationsProjectsConflictsKo conflicts =
      _TranslationsProjectsConflictsKo._(_root);
  @override
  late final _TranslationsProjectsTmKo tm = _TranslationsProjectsTmKo._(_root);
}

// Path: diff
class _TranslationsDiffKo extends TranslationsDiffEn {
  _TranslationsDiffKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get added => '추가됨';
  @override
  String get removed => '제거됨';
  @override
  String get modified => '수정됨';
  @override
  String get unchanged => '변경 없음';
  @override
  String get missing => '누락됨';
  @override
  String get extra => '추가됨';
  @override
  String get sourceValue => '소스 값';
  @override
  String get targetValue => '타겟 값';
  @override
  String get key => '키';
  @override
  String get status => '상태';
  @override
  String get actions => '작업';
  @override
  String get copyToTarget => '타겟에 복사';
  @override
  String get acceptChange => '변경 사항 수락';
  @override
  String get rejectChange => '변경 사항 거절';
  @override
  String get viewDetails => '세부 정보 보기';
}

// Path: git
class _TranslationsGitKo extends TranslationsGitEn {
  _TranslationsGitKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Git 비교';
  @override
  String get selectRepository => '저장소 선택';
  @override
  String get selectBranch => '브랜치 선택';
  @override
  String get selectCommit => '커밋 선택';
  @override
  String get compareBranches => '브랜치 비교';
  @override
  String get compareCommits => '커밋 비교';
  @override
  String get baseBranch => '베이스 브랜치';
  @override
  String get compareBranch => '비교 브랜치';
  @override
  String get noRepositories => 'Git 저장소를 찾을 수 없음';
  @override
  String get noRepositoriesDescription => 'Git 저장소가 포함된 폴더를 여세요';
  @override
  String filesChanged({required Object count}) => '${count}개 파일 변경됨';
  @override
  String additions({required Object count}) => '${count}개 추가';
  @override
  String deletions({required Object count}) => '${count}개 삭제';
  @override
  late final _TranslationsGitConflictsKo conflicts =
      _TranslationsGitConflictsKo._(_root);
}

// Path: quality
class _TranslationsQualityKo extends TranslationsQualityEn {
  _TranslationsQualityKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'API 및 메트릭 용어(Requests, Tokens, Characters, Prompt, Completion, Export)는 업계 용어와의 일관성을 유지하기 위해 모든 번역에서 영어로 유지해야 합니다.';
  @override
  String get title => '품질 대시보드';
  @override
  String get overallScore => '전체 점수';
  @override
  String get issues => '문제';
  @override
  String get warnings => '경고';
  @override
  String get suggestions => '제안';
  @override
  String get placeholderMismatch => '플레이스홀더 불일치';
  @override
  String get placeholderMismatchDescription =>
      '{name}과 같은 플레이스홀더가 소스와 타겟 간에 일치하지 않습니다';
  @override
  String get lengthOutlier => '길이 이상치';
  @override
  String get lengthOutlierDescription => '번역 길이가 소스와 크게 다릅니다';
  @override
  String get duplicateValue => '중복된 값';
  @override
  String get duplicateValueDescription => '동일한 번역이 여러 키에 사용됨';
  @override
  String get missingTranslation => '누락된 번역';
  @override
  String get missingTranslationDescription => '이 키에 대한 번역이 누락되었습니다';
  @override
  String get loading => '대시보드 로딩 중...';
  @override
  String get errorLoading => '기록을 로드할 수 없습니다. 다시 시도해 주세요.';
  @override
  String get emptyState => '대시보드를 보려면 비교를 실행하세요.';
  @override
  String get refresh => '새로 고침';
  @override
  String get buildingInsights => '인사이트 구축 중...';
  @override
  String get crunchingNumbers => '숫자 계산 중...';
  @override
  String get errorBuilding => '대시보드를 구축할 수 없습니다. 다시 시도해 주세요.';
  @override
  String get noUsableData => '아직 사용할 수 있는 데이터가 없습니다.';
  @override
  String get languages => '언어';
  @override
  String get averageCoverage => '평균 커버리지';
  @override
  String get potentialIssues => '잠재적 문제';
  @override
  String get translationCoverage => '번역 커버리지';
  @override
  String entriesTranslated(
          {required Object total, required Object translated}) =>
      '${total}개 중 ${translated}개 항목 번역됨';
  @override
  String get wordsAddedOverTime => '시간 경과에 따른 단어 추가';
  @override
  String get completionVsScope => '완료 vs 범위';
  @override
  String get scopeVsProgress => '범위 vs 진행률';
  @override
  String get coveragePercent => '커버리지 %';
  @override
  String get wordsAdded => '추가된 단어';
  @override
  String get words => '단어';
  @override
  String get coverage => '커버리지';
  @override
  String get scope => '범위';
  @override
  String get latest => '최신';
  @override
  String get added => '추가됨';
  @override
  String get change => '변경';
  @override
  String get totalScope => '총 범위';
  @override
  String get scopeGrowth => '범위 증가';
  @override
  String get range => '범위';
  @override
  String get aiUsage => 'AI & 번역 사용량';
  @override
  String lastUsed({required Object date}) => '마지막 사용 ${date}';
  @override
  String get noIssuesFound => '최근 비교에서 발견된 문제가 없습니다.';
  @override
  String get placeholderMismatches => '플레이스홀더 불일치';
  @override
  String get placeholderMismatchesDesc => '{name}과 같은 마커가 일치하지 않습니다.';
  @override
  String get lengthOutliers => '매우 짧거나 긴 번역';
  @override
  String get lengthOutliersDesc => '길이가 소스에 비해 비정상적입니다.';
  @override
  String get duplicateValues => '중복된 값';
  @override
  String get duplicateValuesDesc => '동일한 번역이 여러 번 사용되었습니다.';
  @override
  String get placeholderDialogTitle => '플레이스홀더 불일치';
  @override
  String get placeholderDialogDesc => '이 번역은 소스와 다른 플레이스홀더({name})를 가지고 있습니다.';
  @override
  String get lengthDialogTitle => '길이 이상치';
  @override
  String get lengthDialogDesc => '이 번역은 소스보다 상당히 짧거나 깁니다.';
  @override
  String get duplicateDialogTitle => '중복된 값';
  @override
  String get duplicateDialogDesc => '이 번역은 여러 번 나타납니다.';
  @override
  String duplicateSample({required Object value}) => '중복: "${value}"';
  @override
  String get exportError => '보고서를 작성할 수 없습니다. 다시 시도해 주세요.';
  @override
  String get noDataToExport => '내보낼 데이터 없음';
  @override
  String get exportFailed => '내보내기 실패';
  @override
  String get exportDialogTitle => '품질 보고서 내보내기';
  @override
  String get reportSaved => '보고서 저장됨';
  @override
  String get export => 'Export';
  @override
  String get requests => 'Requests';
  @override
  String get tokens => 'Tokens';
  @override
  String get characters => 'Characters';
  @override
  String get estCost => 'Est. Cost';
  @override
  String get prompt => 'Prompt';
  @override
  String get completion => 'Completion';
  @override
  String get showingCurrentProject => '표시 중: 현재 프로젝트';
  @override
  String get showingAllHistory => '표시 중: 모든 기록';
  @override
  String get filesSkipped => '일부 파일을 찾을 수 없어 건너뛰었습니다.';
}

// Path: errors
class _TranslationsErrorsKo extends TranslationsErrorsEn {
  _TranslationsErrorsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get genericError => '오류가 발생했습니다';
  @override
  String get fileNotFound => '파일을 찾을 수 없음';
  @override
  String get invalidFormat => '잘못된 파일 형식';
  @override
  String get parseError => '파일 파싱 실패';
  @override
  String get networkError => '네트워크 오류. 연결을 확인하세요.';
  @override
  String get permissionDenied => '권한 거부됨';
  @override
  String get unknownError => '알 수 없는 오류가 발생했습니다';
}

// Path: wizards
class _TranslationsWizardsKo extends TranslationsWizardsEn {
  _TranslationsWizardsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsWizardsFirstRunKo firstRun =
      _TranslationsWizardsFirstRunKo._(_root);
}

// Path: dialogs
class _TranslationsDialogsKo extends TranslationsDialogsEn {
  _TranslationsDialogsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDialogsAddIgnorePatternKo addIgnorePattern =
      _TranslationsDialogsAddIgnorePatternKo._(_root);
  @override
  late final _TranslationsDialogsDiffViewerKo diffViewer =
      _TranslationsDialogsDiffViewerKo._(_root);
}

// Path: grid
class _TranslationsGridKo extends TranslationsGridEn {
  _TranslationsGridKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGridColumnsKo columns =
      _TranslationsGridColumnsKo._(_root);
}

// Path: tutorial
class _TranslationsTutorialKo extends TranslationsTutorialEn {
  _TranslationsTutorialKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => '튜토리얼 건너뛰기';
  @override
  String get finishMessage => '모든 준비가 완료되었습니다! 완료하려면 아무 곳이나 탭하세요.';
  @override
  String get next => '다음';
  @override
  String get loadSampleData => '샘플 데이터 로드';
  @override
  String get browseSourceFile => '소스 파일 찾아보기';
  @override
  String get browseTargetFile => '타겟 파일 찾아보기';
  @override
  String get compareFiles => '파일 비교';
  @override
  String get hintPhase2 => '다음: 필터, 검색, 고급 보기 및 내보내기.';
  @override
  late final _TranslationsTutorialStepsKo steps =
      _TranslationsTutorialStepsKo._(_root);
}

// Path: friendlyErrors
class _TranslationsFriendlyErrorsKo extends TranslationsFriendlyErrorsEn {
  _TranslationsFriendlyErrorsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsFriendlyErrorsFileNotFoundKo fileNotFound =
      _TranslationsFriendlyErrorsFileNotFoundKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsAccessDeniedKo accessDenied =
      _TranslationsFriendlyErrorsAccessDeniedKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsIsDirectoryKo isDirectory =
      _TranslationsFriendlyErrorsIsDirectoryKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsFileAccessKo fileAccess =
      _TranslationsFriendlyErrorsFileAccessKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsUnsupportedFormatKo unsupportedFormat =
      _TranslationsFriendlyErrorsUnsupportedFormatKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsNetworkErrorKo networkError =
      _TranslationsFriendlyErrorsNetworkErrorKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsNotGitRepoKo notGitRepo =
      _TranslationsFriendlyErrorsNotGitRepoKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsMergeConflictKo mergeConflict =
      _TranslationsFriendlyErrorsMergeConflictKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitAuthFailedKo gitAuthFailed =
      _TranslationsFriendlyErrorsGitAuthFailedKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitOperationFailedKo
      gitOperationFailed =
      _TranslationsFriendlyErrorsGitOperationFailedKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidJsonKo invalidJson =
      _TranslationsFriendlyErrorsInvalidJsonKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsRateLimitReachedKo rateLimitReached =
      _TranslationsFriendlyErrorsRateLimitReachedKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidApiKeyKo invalidApiKey =
      _TranslationsFriendlyErrorsInvalidApiKeyKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsTranslationServiceErrorKo
      translationServiceError =
      _TranslationsFriendlyErrorsTranslationServiceErrorKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsOutOfMemoryKo outOfMemory =
      _TranslationsFriendlyErrorsOutOfMemoryKo._(_root);
  @override
  late final _TranslationsFriendlyErrorsGenericErrorKo genericError =
      _TranslationsFriendlyErrorsGenericErrorKo._(_root);
}

// Path: systemTray
class _TranslationsSystemTrayKo extends TranslationsSystemTrayEn {
  _TranslationsSystemTrayKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get showLocalizer => 'Localizer 표시';
  @override
  String get exit => '종료';
}

// Path: validation
class _TranslationsValidationKo extends TranslationsValidationEn {
  _TranslationsValidationKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get connected => '연결됨.';
  @override
  String get connectionTimeout => '연결 시간이 초과되었습니다. 다시 시도해 주세요.';
  @override
  String get couldNotConnect => '연결할 수 없습니다. 다시 시도해 주세요.';
  @override
  String get checkKeyAndTryAgain => '연결할 수 없습니다. 키를 확인하고 다시 시도해 주세요.';
  @override
  String get tryAgainLater => '지금은 연결할 수 없습니다. 나중에 다시 시도해 주세요.';
  @override
  String get serviceUnavailable => '서비스를 지금 사용할 수 없습니다. 나중에 다시 시도해 주세요.';
  @override
  String get enterKeyFirst => '먼저 키를 입력하세요.';
  @override
  String get checking => '확인 중...';
  @override
  String deeplUsage({required Object used, required Object limit}) =>
      '사용량: ${used} / ${limit} 문자.';
}

// Path: status
class _TranslationsStatusKo extends TranslationsStatusEn {
  _TranslationsStatusKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get startingComparison => '비교 시작 중...';
  @override
  String get loadingFromHistory => '기록에서 파일 로드 중...';
  @override
  String get comparisonComplete => '비교 완료';
  @override
  String get couldNotImportFiles => '파일을 가져올 수 없습니다. 다시 시도해 주세요.';
  @override
  String get historyFilesNotFound => '기록의 하나 또는 두 파일 모두 원본 경로에서 찾을 수 없습니다.';
}

// Path: aiServices
class _TranslationsAiServicesKo extends TranslationsAiServicesEn {
  _TranslationsAiServicesKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get geminiEmptyResponse => 'Gemini가 빈 응답을 반환했습니다';
  @override
  String get geminiStreamingEmpty => 'Gemini 스트리밍이 빈 응답을 반환했습니다';
  @override
  String get geminiRephraseEmpty => 'Gemini가 문구 수정에 대해 빈 응답을 반환했습니다';
  @override
  String get openaiEmptyResponse => 'OpenAI가 비어 있거나 실패한 응답을 반환했습니다';
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceKo
    extends TranslationsSettingsAppearanceEn {
  _TranslationsSettingsAppearanceKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '화면 표시';
  @override
  String get description => '앱의 모양과 느낌을 사용자 정의합니다';
  @override
  String get theme => '테마 모드';
  @override
  String get themeDescription => '라이트, 다크 또는 시스템 테마 중 선택';
  @override
  String get themeSystem => '시스템';
  @override
  String get themeLight => '라이트';
  @override
  String get themeDark => '다크';
  @override
  String get themeAmoled => 'AMOLED';
  @override
  String get accentColor => '강조 색상';
  @override
  String get accentColorDescription => '선호하는 강조 색상을 선택하세요';
  @override
  String get useMicaEffect => 'Mica 효과 사용';
  @override
  String get micaDescription => '현대적인 룩을 위해 Windows 11 Mica 투명 효과 활성화';
  @override
  String get diffFontSize => '비교 글꼴 크기';
  @override
  String get diffFontSizeDescription => '비교 보기의 글꼴 크기 조정';
  @override
  String get diffFontFamily => '비교 글꼴 패밀리';
  @override
  String get diffFontFamilyDescription => '비교 보기를 위한 글꼴';
  @override
  String get systemDefault => '시스템 기본값';
  @override
  String get pickAccentColor => '강조 색상 선택';
  @override
  String get diffColors => '비교 색상';
  @override
  String get presetsTitle => '프리셋';
  @override
  late final _TranslationsSettingsAppearancePresetsKo presets =
      _TranslationsSettingsAppearancePresetsKo._(_root);
  @override
  String get identical => '동일함';
  @override
  String pickColorFor({required Object label}) => '${label} 색상 선택';
  @override
  String get livePreview => '라이브 미리보기';
  @override
  late final _TranslationsSettingsAppearancePreviewKo preview =
      _TranslationsSettingsAppearancePreviewKo._(_root);
}

// Path: settings.general
class _TranslationsSettingsGeneralKo extends TranslationsSettingsGeneralEn {
  _TranslationsSettingsGeneralKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '일반';
  @override
  String get description => '일반 애플리케이션 설정';
  @override
  String get language => '언어';
  @override
  String get languageDescription => '선호하는 언어를 선택하세요';
  @override
  String get startMinimized => '트레이로 최소화하여 시작';
  @override
  String get startMinimizedDescription => '앱을 시스템 트레이로 최소화하여 시작합니다';
  @override
  String get rememberWindowPosition => '창 위치 기억';
  @override
  String get rememberWindowPositionDescription => '시작 시 창 크기 및 위치 복원';
  @override
  String get openLastProject => '시작 시 마지막 프로젝트 열기';
  @override
  String get openLastProjectDescription => '앱 시작 시 마지막으로 사용한 프로젝트를 자동으로 엽니다';
  @override
  String get application => '애플리케이션';
  @override
  String get defaultView => '기본 보기';
  @override
  String get defaultViewDescription => '시작 시 보여줄 보기';
  @override
  String get autoCheckUpdates => '업데이트 자동 확인';
  @override
  String get autoCheckUpdatesDescription => '시작 시 업데이트 확인';
  @override
  String get startupOptions => '시작 옵션';
  @override
  String get languageAuto => '자동 감지';
  @override
  String get viewBasic => '파일 비교';
  @override
  String get viewHistory => '기록';
  @override
  String get viewDashboard => '품질 대시보드';
  @override
  String get viewDirectory => '디렉토리 비교';
  @override
  String get viewLastUsed => '마지막 사용 보기';
}

// Path: settings.scope
class _TranslationsSettingsScopeKo extends TranslationsSettingsScopeEn {
  _TranslationsSettingsScopeKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '설정 범위';
  @override
  String get global => '전역 기본값';
  @override
  String get project => '프로젝트';
  @override
  String get reset => '프로젝트를 전역 기본값으로 초기화';
  @override
  String get resetConfirmation =>
      '이 프로젝트의 모든 재정의를 지우고 전역 기본값으로 되돌립니다. 이 작업은 취소할 수 없습니다.';
  @override
  String get globalDescription => '변경 사항은 재정의되지 않은 모든 프로젝트에 적용됩니다.';
  @override
  String projectDescription({required Object name}) =>
      '"${name}"에만 변경 사항이 적용됩니다. 다른 설정은 전역 기본값을 상속합니다.';
  @override
  String get createPrompt => '특정 폴더에 대한 설정을 사용자 정의하려면 프로젝트를 생성하세요';
}

// Path: settings.searchKeywords
class _TranslationsSettingsSearchKeywordsKo
    extends TranslationsSettingsSearchKeywordsEn {
  _TranslationsSettingsSearchKeywordsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  List<String> get general => [
        '언어',
        '기본 보기',
        '최근 파일 수',
        '마지막 프로젝트 열기',
        '종료 전 확인',
        '알림 표시',
      ];
  @override
  List<String> get comparisonEngine => [
        '비교 모드',
        '유사도 임계값',
        '대소문자 구분',
        '공백 무시',
        '빈 줄 무시',
        '주석 무시',
        '무시 패턴',
      ];
  @override
  List<String> get appearance => [
        '테마',
        '테마 모드',
        '강조 색상',
        '비교 글꼴 크기',
        '비교 글꼴 패밀리',
        '비교 색상',
        '추가된 색상',
        '제거된 색상',
        '수정된 색상',
        '동일한 색상',
        '색상 프리셋',
        '미리보기',
      ];
  @override
  List<String> get fileHandling => [
        '소스 형식',
        '타겟 형식',
        '기본 인코딩',
        '최근 프로젝트 수',
        '번역 메모리',
        '메모리 가져오기',
        '메모리 내보내기',
        '메모리 지우기',
      ];
  @override
  List<String> get aiServices => [
        'OpenAI API 키',
        'Anthropic API 키',
        'Google AI API 키',
        'AI 모델',
        '온도',
        '사용자 지정 프롬프트',
      ];
  @override
  List<String> get systemIntegrations => [
        '시스템 트레이',
        '최소화하여 시작',
        '파일 연결',
        'Mica 효과',
        'Vibrancy',
        '창 재질',
        '독 배지',
        '미번역 수',
      ];
  @override
  List<String> get projectResources => [
        '용어집',
        '번역 메모리',
        '용어',
      ];
  @override
  List<String> get about => [
        '버전',
        '업데이트 확인',
        '자동 업데이트',
        '변경 로그',
        '라이선스',
        '개인정보 처리방침',
        '텔레메트리',
        '충돌 보고',
      ];
  @override
  List<String> get developer => [
        '성능 오버레이',
        '시맨틱 디버거',
        '머티리얼 그리드',
        '래스터 캐시',
        '자습서 다시 시작',
        '공장 초기화',
      ];
}

// Path: settings.comparison
class _TranslationsSettingsComparisonKo
    extends TranslationsSettingsComparisonEn {
  _TranslationsSettingsComparisonKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '비교';
  @override
  String get description => '비교 동작 구성';
  @override
  String get caseSensitive => '대소문자 구분';
  @override
  String get caseSensitiveDescription => '대문자와 소문자를 다르게 취급';
  @override
  String get ignoreWhitespace => '공백 무시';
  @override
  String get ignoreWhitespaceDescription => '비교 시 선행/후행 공백 무시';
  @override
  String get showLineNumbers => '줄 번호 표시';
  @override
  String get showLineNumbersDescription => '비교 보기에 줄 번호 표시';
  @override
  String get behavior => '비교 동작';
  @override
  String get ignoreCase => '대소문자 무시';
  @override
  String get ignoreCaseDescription => '"Key"와 "key"를 동일하게 취급';
  @override
  String get similarityThreshold => '유사도 임계값';
  @override
  String get similarityThresholdDescription => '"수정됨" 감지를 위한 최소 유사도';
  @override
  String get mode => '비교 모드';
  @override
  String get modeDescription => '파일 간 항목 일치 방식';
  @override
  String get modeKey => '키 기반';
  @override
  String get modeKeyDescription => '키 이름으로 일치시킵니다 (기본값).';
  @override
  String get modeOrder => '순서 기반';
  @override
  String get modeOrderDescription => '파일 내 위치로 일치시킵니다.';
  @override
  String get modeSmart => '스마트 매치';
  @override
  String get modeSmartDescription => '이동/이름 변경된 키를 감지합니다.';
  @override
  String get ignorePatterns => '무시 패턴';
  @override
  String get noIgnorePatterns => '설정된 무시 패턴이 없습니다.';
  @override
  String get addPattern => '패턴 추가';
  @override
  String get resetToGlobal => '모든 비교 설정을 전역 기본값으로 초기화';
  @override
  late final _TranslationsSettingsComparisonPatternPresetsKo patternPresets =
      _TranslationsSettingsComparisonPatternPresetsKo._(_root);
  @override
  late final _TranslationsSettingsComparisonPreviewMatchKo previewMatch =
      _TranslationsSettingsComparisonPreviewMatchKo._(_root);
  @override
  late final _TranslationsSettingsComparisonColorPresetsKo colorPresets =
      _TranslationsSettingsComparisonColorPresetsKo._(_root);
}

// Path: settings.fileHandling
class _TranslationsSettingsFileHandlingKo
    extends TranslationsSettingsFileHandlingEn {
  _TranslationsSettingsFileHandlingKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get fileFormats => '파일 형식';
  @override
  String get sourceFormat => '소스 형식';
  @override
  String get targetFormat => '타겟 형식';
  @override
  String get encoding => '인코딩';
  @override
  String get sourceEncoding => '소스 인코딩';
  @override
  String get targetEncoding => '타겟 인코딩';
  @override
  String get autoDetect => '자동 감지';
  @override
  String get autoDetectEncodingDescription => '파일 인코딩 자동 감지';
  @override
  String get exportSettings => '내보내기 설정';
  @override
  String get defaultExportFormat => '기본 내보내기 형식';
  @override
  String get includeUtf8Bom => 'UTF-8 BOM 포함';
  @override
  String get includeUtf8BomDescription => 'Excel 호환성을 위해 필요';
  @override
  String get openFolderAfterExport => '내보내기 후 폴더 열기';
  @override
  String get fileSafety => '파일 안전';
  @override
  String get fileSafetyDescription => '재해 복구를 위한 자동 로컬 사본.';
  @override
  String get resetToGlobal => '모든 파일 처리 설정을 전역 기본값으로 초기화';
}

// Path: settings.translationMemory
class _TranslationsSettingsTranslationMemoryKo
    extends TranslationsSettingsTranslationMemoryEn {
  _TranslationsSettingsTranslationMemoryKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '전역 번역 메모리';
  @override
  String get autoLearn => '자동 학습';
  @override
  String get autoLearnDescription => '나중에 재사용할 수 있도록 번역을 로컬 메모리에 저장';
  @override
  String get confidenceThreshold => '신뢰도 임계값';
  @override
  String confidenceThresholdDescription({required Object percent}) =>
      '자동 적용을 위한 최소 점수 (${percent}%)';
  @override
  String get entries => '항목';
  @override
  String get size => '크기';
  @override
  String memorySize({required Object size}) => '메모리 크기: ${size}';
  @override
  String get import => '가져오기';
  @override
  String get exportTmx => 'TMX 내보내기';
  @override
  String get exportCsv => 'CSV 내보내기';
  @override
  String get clearMemory => '메모리 지우기';
  @override
  String importedItems({required Object count}) => '메모리에 ${count}개 항목을 가져왔습니다.';
  @override
  String get noItemsAdded => '추가된 항목이 없습니다.';
  @override
  String get nothingToExport => '아직 내보낼 내용이 없습니다.';
  @override
  String get tmxSaved => 'TMX 저장됨';
  @override
  String get csvSaved => 'CSV 저장됨';
  @override
  String get clearConfirmTitle => '번역 메모리를 지우시겠습니까?';
  @override
  String get clearConfirmContent =>
      '이 기기의 모든 저장된 번역 쌍이 제거됩니다. 이 작업은 취소할 수 없습니다.';
  @override
  String get cleared => '번역 메모리가 지워졌습니다.';
  @override
  String get couldNotClear => '메모리를 지울 수 없습니다.';
}

// Path: settings.backup
class _TranslationsSettingsBackupKo extends TranslationsSettingsBackupEn {
  _TranslationsSettingsBackupKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '자동 백업';
  @override
  String get description => '자동 백업 설정';
  @override
  String get enabled => '자동 백업 활성화';
  @override
  String get enabledDescription => '변경하기 전에 파일을 자동으로 백업';
  @override
  String get maxCopies => '최대 백업 사본 수';
  @override
  String get maxCopiesDescription => '파일당 유지할 백업 사본 수';
  @override
  String activeStatus({required Object count}) => '활성 · ${count}개 사본 유지';
  @override
  String get folder => '백업 폴더';
  @override
  String get folderDescription => '동일한 폴더를 사용하려면 비워 두세요';
  @override
  String get useOriginalFolder => '원본 파일 폴더 사용';
}

// Path: settings.ai
class _TranslationsSettingsAiKo extends TranslationsSettingsAiEn {
  _TranslationsSettingsAiKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'AI 서비스';
  @override
  String get description => 'AI 번역 및 지원 구성';
  @override
  String get provider => 'AI 제공자';
  @override
  String get providerDescription => '선호하는 AI 서비스 제공자를 선택하세요';
  @override
  String get apiKey => 'API 키';
  @override
  String get apiKeyDescription => '선택한 제공자의 API 키를 입력하세요';
  @override
  String get apiKeyPlaceholder => 'API 키 입력...';
  @override
  String get testConnection => '연결 테스트';
  @override
  String get connectionSuccess => '연결 성공!';
  @override
  String get connectionFailed => '연결 실패. API 키를 확인하세요.';
  @override
  String get translationStrategy => '번역 전략';
  @override
  String get strategy => '전략';
  @override
  String get strategyDescription => '문자열 번역 방법 선택';
  @override
  String get strategyLLM => '생성형 AI (LLM)';
  @override
  String get strategyCloud => '클라우드 번역';
  @override
  String get enableAiTranslation => 'AI 번역 활성화';
  @override
  String get enableAiTranslationDescription => '앱이 번역 제안에 AI를 사용하도록 허용';
  @override
  String get llmProvider => 'LLM 서비스 제공자';
  @override
  String get service => '서비스';
  @override
  String get serviceDescription => '생성형 AI 제공자';
  @override
  String get providerGemini => 'Google Gemini';
  @override
  String get providerOpenAI => 'OpenAI';
  @override
  String get geminiApiKey => 'Gemini API 키';
  @override
  String get openAiApiKey => 'OpenAI API 키';
  @override
  String get model => '모델';
  @override
  String get modelDescription => '사용할 모델 선택';
  @override
  String get advancedParameters => '고급 매개변수';
  @override
  String get parameters => '매개변수';
  @override
  String get parametersDescription => '온도, 컨텍스트 및 기타';
  @override
  String get temperature => '온도';
  @override
  String get temperatureDescription => '값이 높을수록 출력이 더 창의적입니다';
  @override
  String get maxTokens => '최대 토큰';
  @override
  String get maxTokensDescription => '컨텍스트 창 길이 제한';
  @override
  String get systemContext => '시스템 컨텍스트 / 지침';
  @override
  String get systemContextHint => '당신은 전문 로컬라이저입니다. 소스 문자열의 어조와 의도를 유지하세요...';
  @override
  String get systemContextHelper => '프로젝트의 스타일과 용어에 대해 AI에게 구체적인 지침을 제공하세요.';
  @override
  String get contextStrings => '컨텍스트 문자열';
  @override
  String get contextStringsDescription => '더 나은 컨텍스트를 위해 주변 문자열 포함';
  @override
  String get contextCount => '컨텍스트 수';
  @override
  String get contextCountDescription => '포함할 주변 문자열 수';
  @override
  String get cloudServices => '클라우드 번역 서비스';
  @override
  String get googleTranslateApiKey => 'Google 번역 API 키';
  @override
  String get deeplApiKey => 'DeepL API 키';
  @override
  String get test => '테스트';
  @override
  String get resetToGlobal => '모든 AI 설정을 전역 기본값으로 초기화';
}

// Path: settings.integrations
class _TranslationsSettingsIntegrationsKo
    extends TranslationsSettingsIntegrationsEn {
  _TranslationsSettingsIntegrationsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get platformNotice => '플랫폼 알림';
  @override
  String get platformNoticeDescription => '시스템 통합은 이 플랫폼에서 사용할 수 없습니다.';
  @override
  String get visualEffects => '시각 효과';
  @override
  String get explorerIntegration => '탐색기 통합';
  @override
  String get explorerIntegrationDescription =>
      '폴더의 Windows 탐색기 오른쪽 클릭 메뉴에 "Localizer로 열기"를 추가합니다.';
  @override
  String get addToContextMenu => '컨텍스트 메뉴에 추가';
  @override
  String get contextMenuAdded => '컨텍스트 메뉴가 추가되었습니다!';
  @override
  String get contextMenuAddError => '컨텍스트 메뉴 추가 실패';
  @override
  String get contextMenuRemoved => '컨텍스트 메뉴가 제거되었습니다!';
  @override
  String get contextMenuRemoveError => '컨텍스트 메뉴 제거 실패';
  @override
  String get fileAssociations => '파일 연결';
  @override
  String get fileAssociationsDescription =>
      '탐색기에서 두 번 클릭할 때 Localizer로 열리도록 파일 형식을 등록합니다.';
  @override
  String get registered => '등록됨';
  @override
  String get notRegistered => '등록되지 않음';
  @override
  String extRegistered({required Object ext}) => '${ext} 등록됨!';
  @override
  String extUnregistered({required Object ext}) => '${ext} 등록 해제됨!';
  @override
  String extError({required Object ext, required Object action}) =>
      '${ext} ${action} 실패';
  @override
  String get registerAll => '모두 등록';
  @override
  String get unregisterAll => '모두 등록 해제';
  @override
  String registerAllResult({required Object total, required Object success}) =>
      '총 ${total}개 중 ${success}개 파일 형식 등록 완료';
  @override
  String unregisterAllResult(
          {required Object total, required Object success}) =>
      '총 ${total}개 중 ${success}개 파일 형식 등록 해제 완료';
  @override
  String get protocolHandler => '프로토콜 핸들러';
  @override
  String get protocolHandlerDescription =>
      '이 애플리케이션을 열기 위해 localizer:// URL을 등록합니다. 브라우저 링크나 다른 앱에서 프로젝트를 직접 열 수 있습니다.';
  @override
  String get protocolRegistered => '프로토콜 핸들러가 등록됨';
  @override
  String get protocolNotRegistered => '프로토콜 핸들러가 등록되지 않음';
  @override
  String get registerProtocol => '프로토콜 등록';
  @override
  String get unregister => '등록 해제';
  @override
  String get protocolRegisteredSuccess => '프로토콜 핸들러 등록됨!';
  @override
  String get protocolRemovedSuccess => '프로토콜 핸들러 제거됨!';
  @override
  String get protocolRegisterError => '등록 실패';
  @override
  String get protocolRemoveError => '제거 실패';
  @override
  String get windowMaterial => '창 재질';
  @override
  String get windowMaterialDescription => 'macOS vibrancy 재질 스타일 선택';
  @override
  String get dockIntegration => 'Dock 통합';
  @override
  String get showDockBadge => '미번역 수 표시';
  @override
  String get showDockBadgeDescription => 'Dock 아이콘 배지에 미번역 문자열 수 표시';
  @override
  late final _TranslationsSettingsIntegrationsMaterialsKo materials =
      _TranslationsSettingsIntegrationsMaterialsKo._(_root);
  @override
  late final _TranslationsSettingsIntegrationsFileTypesKo fileTypes =
      _TranslationsSettingsIntegrationsFileTypesKo._(_root);
}

// Path: settings.developer
class _TranslationsSettingsDeveloperKo extends TranslationsSettingsDeveloperEn {
  _TranslationsSettingsDeveloperKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '개발자 설정';
  @override
  String get description => '개발자를 위한 고급 설정';
  @override
  String get showLocalizationKeys => '로컬라이제이션 키 표시';
  @override
  String get localizationKeysDescription =>
      '활성화되면 모든 번역된 텍스트가 번역된 값 대신 로컬라이제이션 키를 표시합니다. 어떤 키가 어디에 사용되는지 확인하는 데 유용합니다.';
  @override
  String get showPerformanceOverlay => '성능 오버레이 표시';
  @override
  String get performanceOverlayDescription => 'FPS 및 프레임 타이밍 정보 표시';
  @override
  String get debugMode => '디버그 모드';
  @override
  String get debugModeDescription => '추가 로깅 및 디버그 기능 활성화';
  @override
  String get debuggingTools => '디버깅 도구';
  @override
  String get semanticsDebugger => '시맨틱 디버거';
  @override
  String get semanticsDebuggerDescription => '시맨틱 트리 시각화';
  @override
  String get materialGrid => '머티리얼 그리드';
  @override
  String get materialGridDescription => '머티리얼 레이아웃 그리드 오버레이';
  @override
  String get rasterCache => '래스터 캐시 이미지';
  @override
  String get rasterCacheDescription => '체커보드 래스터 캐시 이미지';
  @override
  String get actions => '작업';
  @override
  String get showLogs => '앱 로그 표시';
  @override
  String get showLogsDescription => 'Talker 디버그 콘솔 열기';
  @override
  String get restartTutorial => '온보딩 튜토리얼 다시 시작';
  @override
  String get restartTutorialDescription => '플래그 초기화 및 튜토리얼 다시 실행';
  @override
  String get restartRequested => '튜토리얼 다시 시작 요청됨.';
  @override
  String get throwException => '테스트 예외 발생';
  @override
  String get throwExceptionDescription => '충돌 보고를 위한 테스트 예외 트리거';
  @override
  String get testExceptionMessage => '개발자 옵션에서 테스트 예외 트리거됨';
  @override
  String get clearTM => '번역 메모리 지우기';
  @override
  String get clearTMDescription => '모든 캐시된 번역 삭제';
  @override
  String get clearTMConfirmation => '번역 메모리를 지우시겠습니까?';
  @override
  String get clearTMWarning => '학습된 모든 번역이 삭제됩니다. 이 작업은 취소할 수 없습니다.';
  @override
  String get tmCleared => '번역 메모리 지워짐';
  @override
  String get clearApiKeys => 'API 키 지우기';
  @override
  String get clearApiKeysDescription => '모든 저장된 API 키 제거';
  @override
  String get clearApiKeysConfirmation => 'API 키를 지우시겠습니까?';
  @override
  String get clearApiKeysWarning => '보안 저장소에서 모든 API 키가 제거됩니다.';
  @override
  String get apiKeysCleared => 'API 키 지워짐';
  @override
  String get hideOptions => '개발자 옵션 숨기기';
  @override
  String get hideOptionsDescription => '개발자 모드 비활성화 (다시 활성화하려면 7번 탭)';
  @override
  String get optionsDisabled => '개발자 옵션 비활성화됨';
  @override
  String get dangerZone => '위험 구역';
  @override
  String get factoryReset => '공장 초기화';
  @override
  String get factoryResetDescription => '모든 설정 초기화 및 데이터 지우기';
  @override
  String get factoryResetWarning => '모든 설정을 초기화하시겠습니까? 이 작업은 취소할 수 없습니다.';
  @override
  String get inspectionTools => '검사 도구';
  @override
  String get searchHint => '설정 검색...';
  @override
  String get resetToDefault => '기본값으로 재설정';
  @override
  String get resetToGlobal => '전역 기본값으로 재설정';
  @override
  String get storageInspector => '저장소 검사기';
  @override
  String get storageInspectorDescription => 'Hive 및 보안 저장소 내용 보기';
  @override
  String get deviceEnvironment => '기기 및 환경';
  @override
  String get deviceEnvironmentDescription => '화면, 플랫폼 및 빌드 정보';
  @override
  String get themePlayground => '테마 플레이그라운드';
  @override
  String get themePlaygroundDescription => '색상 팔레트 및 타이포그래피';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionKo
      themePlaygroundSection =
      _TranslationsSettingsDeveloperThemePlaygroundSectionKo._(_root);
  @override
  String get localizationInspector => '로컬라이제이션 검사기';
  @override
  String get localizationInspectorDescription => '번역 문자열 디버그';
  @override
  String get hiveAppSettings => 'Hive (앱 설정)';
  @override
  String get secureStorageMasked => '보안 저장소 (마스킹됨)';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsKo featureFlags =
      _TranslationsSettingsDeveloperFeatureFlagsKo._(_root);
  @override
  late final _TranslationsSettingsDeveloperStorageInspectorSectionKo
      storageInspectorSection =
      _TranslationsSettingsDeveloperStorageInspectorSectionKo._(_root);
  @override
  late final _TranslationsSettingsDeveloperDeviceInfoSectionKo
      deviceInfoSection =
      _TranslationsSettingsDeveloperDeviceInfoSectionKo._(_root);
  @override
  late final _TranslationsSettingsDeveloperLocalizationInspectorSectionKo
      localizationInspectorSection =
      _TranslationsSettingsDeveloperLocalizationInspectorSectionKo._(_root);
}

// Path: settings.about
class _TranslationsSettingsAboutKo extends TranslationsSettingsAboutEn {
  _TranslationsSettingsAboutKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '정보';
  @override
  String get version => '버전';
  @override
  String get buildNumber => '빌드 번호';
  @override
  String get author => '작성자';
  @override
  String get license => '라이선스';
  @override
  String get sourceCode => '소스 코드';
  @override
  String get reportBug => '버그 보고';
  @override
  String get requestFeature => '기능 요청';
  @override
  String get checkForUpdates => '업데이트 확인';
  @override
  String get upToDate => '최신 상태입니다!';
  @override
  String updateAvailable({required Object version}) => '업데이트 가능: ${version}';
  @override
  String get updateAvailableBadge => '업데이트 가능!';
  @override
  String developerSteps({required Object count}) =>
      '개발자가 되기까지 ${count}단계 남았습니다.';
  @override
  String get developerActivated => '이제 개발자입니다!';
  @override
  String get neverChecked => '없음';
  @override
  String get applicationInfo => '애플리케이션 정보';
  @override
  String get platform => '플랫폼';
  @override
  String get updateInformation => '업데이트 정보';
  @override
  String get currentVersion => '현재 버전';
  @override
  String get latestVersion => '최신 버전';
  @override
  String get lastChecked => '마지막 확인';
  @override
  String get checkingForUpdates => '확인 중...';
  @override
  String get whatsNew => '새로운 기능';
  @override
  String get systemInformation => '시스템 정보';
  @override
  String get dartVersion => 'Dart 버전';
  @override
  String get diskSpace => '사용 가능한 디스크 공간';
  @override
  String get memoryUsage => '메모리 사용량';
  @override
  String get privacyTitle => '개인정보 및 텔레메트리';
  @override
  String get usageStats => '익명 사용 통계';
  @override
  String get requiresFirebase => 'Firebase 구성 필요';
  @override
  String get featureUnavailable => '기능을 현재 사용할 수 없음 (Firebase 필요)';
  @override
  String get settingsManagement => '설정 관리';
  @override
  String get settingsManagementDescription => '설정을 파일로 내보내 백업하거나 다른 머신과 공유하세요.';
  @override
  String get resetAll => '모두 초기화';
  @override
  String get links => '링크';
  @override
  String get githubRepo => 'GitHub 저장소';
  @override
  String get privacyPolicy => '개인정보 처리방침';
  @override
  String get crashReporting => '충돌 보고';
}

// Path: settings.onboarding
class _TranslationsSettingsOnboardingKo
    extends TranslationsSettingsOnboardingEn {
  _TranslationsSettingsOnboardingKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => '튜토리얼 건너뛰기';
  @override
  String get gettingStarted => '시작하기';
  @override
  String stepProgress({required Object total, required Object current}) =>
      '${total} 중 ${current}';
  @override
  String get loadSampleData => '샘플 데이터 로드';
  @override
  late final _TranslationsSettingsOnboardingStepsKo steps =
      _TranslationsSettingsOnboardingStepsKo._(_root);
}

// Path: settings.settingsView
class _TranslationsSettingsSettingsViewKo
    extends TranslationsSettingsSettingsViewEn {
  _TranslationsSettingsSettingsViewKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String resetCategoryTitle({required Object category}) => '${category} 초기화?';
  @override
  String get resetCategoryContent => '이 카테고리의 모든 설정이 기본값으로 초기화됩니다.';
  @override
  String get resetAllTitle => '모든 설정 초기화?';
  @override
  String get resetAllContent =>
      '모든 설정이 영구적으로 공장 기본값으로 초기화됩니다. 이 작업은 취소할 수 없습니다.';
  @override
  String get resetAll => '모두 초기화';
  @override
  String resetSuccess({required Object category}) => '${category} 기본값으로 초기화됨';
  @override
  String get errorLoading => '설정 로드 오류';
  @override
  String get settingsSaved => '설정 저장됨';
  @override
  String updateAvailable({required Object version}) => '업데이트 가능: v${version}';
  @override
  String get latestVersion => '최신 버전을 사용 중입니다';
  @override
  String whatsNew({required Object version}) => 'v${version}의 새로운 기능';
  @override
  String get downloadUpdate => '업데이트 다운로드';
  @override
  String get exportSettings => '설정 내보내기';
  @override
  String get settingsExported => '설정 내보내짐';
  @override
  String exportFail({required Object error}) => '설정 내보내기 실패: ${error}';
  @override
  String get importSettings => '설정 가져오기';
  @override
  String get importTitle => '설정 가져오기?';
  @override
  String get importContent => '현재 모든 설정이 가져온 설정으로 대체됩니다. 이 작업은 취소할 수 없습니다.';
  @override
  String get importSuccess => '설정을 성공적으로 가져왔습니다!';
  @override
  String importFail({required Object error}) => '설정 가져오기 실패: ${error}';
  @override
  String get invalidFormat => '잘못된 설정 파일 형식';
  @override
  late final _TranslationsSettingsSettingsViewCategoriesKo categories =
      _TranslationsSettingsSettingsViewCategoriesKo._(_root);
  @override
  late final _TranslationsSettingsSettingsViewCategoryLabelsKo categoryLabels =
      _TranslationsSettingsSettingsViewCategoryLabelsKo._(_root);
}

// Path: advancedDiff.aiSuggestion
class _TranslationsAdvancedDiffAiSuggestionKo
    extends TranslationsAdvancedDiffAiSuggestionEn {
  _TranslationsAdvancedDiffAiSuggestionKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get aiTranslation => 'AI 번역';
  @override
  String get aiRephrase => 'AI 문구 수정';
  @override
  String key({required Object key}) => '키: ${key}';
  @override
  String get original => '원본:';
  @override
  String get suggestion => '제안:';
  @override
  String get confidence => 'AI 신뢰도';
  @override
  String get cancelEdit => '편집 취소';
  @override
  String get editSuggestion => '제안 편집';
  @override
  String get alternatives => '대안:';
  @override
  String get accept => '수락';
  @override
  String get reject => '거절';
  @override
  String get stop => '중지';
}

// Path: advancedDiff.detailEdit
class _TranslationsAdvancedDiffDetailEditKo
    extends TranslationsAdvancedDiffDetailEditEn {
  _TranslationsAdvancedDiffDetailEditKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object key}) => '편집: ${key}';
  @override
  String get sourceLabel => '소스 (원본)';
  @override
  String get targetLabel => '타겟 (번역)';
  @override
  String get translateWithCloud => '클라우드로 번역';
  @override
  String get translateWithAi => 'AI로 번역';
  @override
  String get translating => '번역 중...';
  @override
  String get applyAndTm => '적용';
  @override
  String get entryApplied => '항목 적용됨 & TM에 추가됨';
  @override
  String get translationAdded => '번역 제안이 추가되었습니다.';
  @override
  String get aiSuggestionAdded => 'AI 제안이 추가되었습니다.';
}

// Path: advancedDiff.table
class _TranslationsAdvancedDiffTableKo extends TranslationsAdvancedDiffTableEn {
  _TranslationsAdvancedDiffTableKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get addedToTM => '번역 메모리에 추가됨';
  @override
  String get markedReviewed => '검토 완료로 표시됨 ✓';
  @override
  String get unmarkedReview => '검토 표시 해제됨';
  @override
  String get reverted => '소스 값으로 되돌림';
  @override
  String get entryDeleted => '항목 삭제됨';
  @override
  String get noSourceText => '번역할 소스 텍스트가 없습니다.';
  @override
  String aiTranslationFailed({required Object key}) => '"${key}"에 대한 AI 번역 실패';
  @override
  String get noTargetText => '문구를 수정할 타겟 텍스트가 없습니다.';
  @override
  String aiRephraseFailed({required Object key}) => '"${key}"에 대한 AI 문구 수정 실패';
  @override
  String get checkRowsFirst => '먼저 체크박스를 사용하여 행을 선택하세요';
  @override
  String markedRowsReviewed({required Object count}) =>
      '${count}개 행을 검토 완료로 표시했습니다';
  @override
  String revertedRows({required Object count}) => '${count}개 행을 되돌렸습니다';
  @override
  String entriesCount({required Object count}) => '${count}개 항목';
  @override
  String get markSelectedReviewed => '선택 항목 검토 완료로 표시';
  @override
  String get revertSelected => '선택 항목 되돌리기';
  @override
  String get noDifferences => '차이점이 없습니다';
  @override
  String get adjustFilters => '필터를 조정해 보세요';
  @override
  String get cloudTranslationApplied => '클라우드 번역이 적용되었습니다.';
  @override
  String get aiTranslationApplied => 'AI 번역이 적용되었습니다.';
  @override
  String get suggestionApplied => '제안이 적용되었습니다.';
  @override
  String get aiSuggestionApplied => 'AI 제안이 적용되었습니다.';
  @override
  String get rephraseApplied => '문구 수정이 적용되었습니다.';
  @override
  String get aiRephraseApplied => 'AI 문구 수정이 적용되었습니다.';
  @override
  String get rephrase => '문구 수정';
  @override
  String get aiRephrase => 'AI 문구 수정';
  @override
  String get targetClickToEdit => '타겟 (편집하려면 클릭)';
  @override
  String get targetClickForDialog => '타겟 (대화 상자 열기)';
  @override
  String get emptyClickToEdit => '(비어 있음 - 편집하려면 클릭)';
  @override
  String get unmarkReviewed => '검토 표시 해제';
  @override
  String get markReviewed => '검토 완료로 표시';
  @override
  String get revertToSource => '소스로 되돌리기';
  @override
  String get translateWithCloud => '클라우드로 번역';
  @override
  String get translateWithAi => 'AI로 번역';
  @override
  String get rephraseWithAi => 'AI로 문구 수정';
  @override
  String get moreActions => '추가 작업';
  @override
  String get editDetails => '세부 정보 편집';
  @override
  String get suggestTranslation => '번역 제안';
  @override
  String get addToTm => 'TM에 추가';
  @override
  String get deleteEntry => '항목 삭제';
}

// Path: advancedDiff.diffRow
class _TranslationsAdvancedDiffDiffRowKo
    extends TranslationsAdvancedDiffDiffRowEn {
  _TranslationsAdvancedDiffDiffRowKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get copySource => '소스 텍스트 복사';
  @override
  String get actions => '작업';
}

// Path: advancedDiff.status
class _TranslationsAdvancedDiffStatusKo
    extends TranslationsAdvancedDiffStatusEn {
  _TranslationsAdvancedDiffStatusKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get added => '추가됨';
  @override
  String get missing => '누락됨';
  @override
  String changed({required Object percent}) => '변경됨 ${percent}%';
  @override
  String get same => '동일함';
}

// Path: advancedDiff.sidebar
class _TranslationsAdvancedDiffSidebarKo
    extends TranslationsAdvancedDiffSidebarEn {
  _TranslationsAdvancedDiffSidebarKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get widgets => '위젯';
  @override
  String get searchPlaceholder => '키 & 값 검색... (Ctrl+F)';
  @override
  String get fuzzySearchTooltip => '퍼지 검색 (오타 허용)';
  @override
  String get regexSearchTooltip => '정규식 검색';
  @override
  String get cloudTranslation => '클라우드 번역';
  @override
  String get aiTranslation => 'AI 번역';
  @override
  String get status => '상태';
  @override
  String get tm => '번역 메모리';
  @override
  String get filters => '필터';
  @override
  String get actions => '작업';
  @override
  String get similarity => '유사도';
  @override
  late final _TranslationsAdvancedDiffSidebarActionsSectionKo actionsSection =
      _TranslationsAdvancedDiffSidebarActionsSectionKo._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarAiSectionKo aiSection =
      _TranslationsAdvancedDiffSidebarAiSectionKo._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarTmSectionKo tmSection =
      _TranslationsAdvancedDiffSidebarTmSectionKo._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarFiltersSectionKo filtersSection =
      _TranslationsAdvancedDiffSidebarFiltersSectionKo._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarSimilaritySectionKo
      similaritySection =
      _TranslationsAdvancedDiffSidebarSimilaritySectionKo._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarStatusSectionKo statusSection =
      _TranslationsAdvancedDiffSidebarStatusSectionKo._(_root);
}

// Path: issueDetails.duplicateValue
class _TranslationsIssueDetailsDuplicateValueKo
    extends TranslationsIssueDetailsDuplicateValueEn {
  _TranslationsIssueDetailsDuplicateValueKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get label => '중복 번역';
  @override
  String get warning => '다른 소스 텍스트가 이 동일한 번역을 사용합니다. 문맥을 확인하세요.';
  @override
  String affectedKeys({required Object count}) => '영향받는 키 (${count})';
  @override
  String get identicalSources => '동일한 소스';
  @override
  String moreKeys({required Object count}) => '${count}개 키 더 보기';
}

// Path: issueDetails.lengthOutlier
class _TranslationsIssueDetailsLengthOutlierKo
    extends TranslationsIssueDetailsLengthOutlierEn {
  _TranslationsIssueDetailsLengthOutlierKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get source => '소스';
  @override
  String get translation => '번역';
  @override
  String chars({required Object count}) => '${count}자';
}

// Path: issueDetails.standard
class _TranslationsIssueDetailsStandardKo
    extends TranslationsIssueDetailsStandardEn {
  _TranslationsIssueDetailsStandardKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get key => '키';
  @override
  String get sourceText => '소스 텍스트';
  @override
  String get translation => '번역';
  @override
  String get errorDetails => '오류 세부 정보';
  @override
  String get note => '참고';
}

// Path: issueDetails.types
class _TranslationsIssueDetailsTypesKo extends TranslationsIssueDetailsTypesEn {
  _TranslationsIssueDetailsTypesKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get duplicateValue => '중복된 값';
  @override
  String get lengthOutlier => '길이 불일치';
  @override
  String get placeholderMismatch => '손상된 플레이스홀더';
}

// Path: issueDetails.notes
class _TranslationsIssueDetailsNotesKo extends TranslationsIssueDetailsNotesEn {
  _TranslationsIssueDetailsNotesKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get placeholderMismatch => '{name}과 같은 마커는 소스와 일치해야 합니다.';
  @override
  String get lengthOutlier => '큰 길이 변화는 텍스트가 화면에 표시되는 방식에 영향을 줄 수 있습니다.';
  @override
  String get duplicateValue => '서로 다른 키에 동일한 번역이 사용되었습니다.';
}

// Path: issueDetails.fallbacks
class _TranslationsIssueDetailsFallbacksKo
    extends TranslationsIssueDetailsFallbacksEn {
  _TranslationsIssueDetailsFallbacksKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get multipleSources => '다수 소스 텍스트';
  @override
  String get sourceNotAvailable => '소스 텍스트 사용 불가';
  @override
  String get sharedTranslationNotAvailable => '공유 번역 사용 불가';
  @override
  String get translationNotAvailable => '번역 사용 불가';
}

// Path: compare.tabs
class _TranslationsCompareTabsKo extends TranslationsCompareTabsEn {
  _TranslationsCompareTabsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get files => '파일';
  @override
  String get directories => '디렉토리';
  @override
  String get git => 'Git';
}

// Path: compare.fileTypes
class _TranslationsCompareFileTypesKo extends TranslationsCompareFileTypesEn {
  _TranslationsCompareFileTypesKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get json => 'JSON 로컬라이제이션 파일 (i18next, Flutter 등)';
  @override
  String get yaml => 'YAML 로컬라이제이션 파일 (Rails, Flutter)';
  @override
  String get xml => 'XML 로컬라이제이션 파일 (Android, .NET)';
  @override
  String get properties => 'Properties 파일 (Java)';
  @override
  String get resx => 'RESX 파일 (.NET)';
  @override
  String get xliff => 'XLIFF 파일';
}

// Path: history.timeAgo
class _TranslationsHistoryTimeAgoKo extends TranslationsHistoryTimeAgoEn {
  _TranslationsHistoryTimeAgoKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get justNow => '방금 전';
  @override
  String secondsAgo({required Object count}) => '${count}초 전';
  @override
  String get oneMinuteAgo => '1분 전';
  @override
  String minutesAgo({required Object count}) => '${count}분 전';
  @override
  String get oneHourAgo => '1시간 전';
  @override
  String hoursAgo({required Object count}) => '${count}시간 전';
  @override
  String get yesterday => '어제';
  @override
  String daysAgo({required Object count}) => '${count}일 전';
  @override
  String get oneWeekAgo => '1주 전';
  @override
  String weeksAgo({required Object count}) => '${count}주 전';
  @override
  String get oneMonthAgo => '1개월 전';
  @override
  String monthsAgo({required Object count}) => '${count}개월 전';
  @override
  String get oneYearAgo => '1년 전';
  @override
  String yearsAgo({required Object count}) => '${count}년 전';
  @override
  String get inTheFuture => '미래';
}

// Path: projects.stats
class _TranslationsProjectsStatsKo extends TranslationsProjectsStatsEn {
  _TranslationsProjectsStatsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get empty => '빈 프로젝트';
  @override
  String files({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ko'))(
        n,
        one: '1개 번역 파일',
        other: '${count}개 번역 파일',
      );
  @override
  String languages({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ko'))(
        n,
        one: '1개 언어',
        other: '${count}개 언어',
      );
}

// Path: projects.selection
class _TranslationsProjectsSelectionKo extends TranslationsProjectsSelectionEn {
  _TranslationsProjectsSelectionKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get selectFolder => '프로젝트 폴더 선택';
  @override
  String get selectArchive => '프로젝트 아카이브 선택';
  @override
  String get openProject => '프로젝트 열기';
  @override
  String get browseFolder => '폴더 찾아보기...';
  @override
  String get createNew => '새로 생성';
  @override
  String get importFromZip => 'Zip에서 가져오기...';
}

// Path: projects.createDialog
class _TranslationsProjectsCreateDialogKo
    extends TranslationsProjectsCreateDialogEn {
  _TranslationsProjectsCreateDialogKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '프로젝트 생성';
  @override
  String get description =>
      '프로젝트를 사용하면 특정 폴더에 대한 사용자 지정 설정을 저장할 수 있습니다. 프로젝트 구성을 저장하기 위해 ".localizer" 폴더가 생성됩니다.';
  @override
  String get folderLabel => '프로젝트 폴더';
  @override
  String get folderHint => '폴더를 선택하려면 클릭...';
  @override
  String get nameLabel => '프로젝트 이름';
  @override
  String get nameHint => '예: 내 앱 번역';
  @override
  String get selectFolderWarning => '프로젝트 폴더를 선택하세요.';
  @override
  String get enterNameError => '프로젝트 이름을 입력하세요';
  @override
  String get nameLengthError => '이름은 2자 이상이어야 합니다';
  @override
  String success({required Object name}) => '프로젝트 "${name}" 생성 성공!';
  @override
  String get failure => '프로젝트 생성 실패.';
  @override
  String get creating => '생성 중...';
  @override
  String get createAction => '프로젝트 생성';
}

// Path: projects.indicator
class _TranslationsProjectsIndicatorKo extends TranslationsProjectsIndicatorEn {
  _TranslationsProjectsIndicatorKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get tooltipNoProject => '폴더에 대한 사용자 지정 설정을 저장하려면 프로젝트를 생성하세요';
  @override
  String tooltipProject({required Object name}) => '프로젝트: ${name}\n옵션을 보려면 클릭';
  @override
  String get location => '위치';
  @override
  String get created => '생성됨';
  @override
  String get switchProject => '프로젝트 전환';
  @override
  String get done => '완료';
}

// Path: projects.glossary
class _TranslationsProjectsGlossaryKo extends TranslationsProjectsGlossaryEn {
  _TranslationsProjectsGlossaryKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '프로젝트 용어집';
  @override
  String get description => '일관되게 처리하거나 절대 번역하지 않아야 하는 용어를 정의합니다.';
  @override
  String get noTerms => '아직 용어집 용어가 없습니다.';
  @override
  String get noTermsDesc =>
      '번역 전체에서 일관성을 유지해야 하는 용어를 추가하거나,\n번역하지 않아야 하는 브랜드 이름을 표시하세요.';
  @override
  String get doNotTranslate => '번역하지 않음';
  @override
  String get noSpecificTranslation => '특정 번역 없음';
  @override
  String get addTerm => '용어 추가';
  @override
  String get editTerm => '용어 편집';
  @override
  String get term => '용어';
  @override
  String get termHint => '예: 브랜드 이름, 전문 용어';
  @override
  String get definition => '정의 (선택 사항)';
  @override
  String get definitionHint => '번역가를 위한 컨텍스트';
  @override
  String get doNotTranslateLabel => '번역하지 않음';
  @override
  String get doNotTranslateDesc => '타겟에서 용어를 그대로 유지';
  @override
  String get preferredTranslation => '선호하는 번역';
  @override
  String get caseSensitive => '대소문자 구분';
}

// Path: projects.conflicts
class _TranslationsProjectsConflictsKo extends TranslationsProjectsConflictsEn {
  _TranslationsProjectsConflictsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String missingApiKeyTitle({required Object service}) =>
      '${service}에 대한 API 키 누락';
  @override
  String missingApiKeyMessage({required Object service}) =>
      '이 프로젝트는 ${service}을(를) 사용하지만 API 키가 구성되지 않았습니다. 설정 > AI 서비스에서 API 키를 추가하거나 앱이 전역 기본값을 사용합니다.';
  @override
  String get dismiss => '무시';
}

// Path: projects.tm
class _TranslationsProjectsTmKo extends TranslationsProjectsTmEn {
  _TranslationsProjectsTmKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '번역 메모리';
  @override
  String get description => '이 프로젝트의 번역 메모리 소스를 관리합니다.';
  @override
  String get globalTm => '전역 번역 메모리';
  @override
  String get globalTmDescription => '앱 설정의 공유 번역 메모리 사용';
  @override
  String get linkedFiles => '연결된 파일 (프로젝트별)';
  @override
  String get noLinkedFiles => '연결된 프로젝트별 파일이 없습니다.';
  @override
  String get addTmFile => 'TM 파일 추가';
  @override
  String get useGlobalTm => '전역 TM 사용';
  @override
  String get selectTm => '번역 메모리 선택';
  @override
  String get globalTmEnabled => '전역 번역 메모리 활성화됨';
}

// Path: git.conflicts
class _TranslationsGitConflictsKo extends TranslationsGitConflictsEn {
  _TranslationsGitConflictsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '병합 충돌 감지됨';
  @override
  String get description => '계속하려면 이 충돌을 해결해야 합니다.';
  @override
  String get abortMergeTitle => '병합 중단?';
  @override
  String get abortMergeContent =>
      '모든 병합 변경 사항이 되돌려지고 병합 전 상태로 돌아갑니다. 이 작업은 취소할 수 없습니다.';
  @override
  String get abortMergeAction => '병합 중단';
  @override
  String stagingFile({required Object file}) => '커밋을 위해 ${file} 스테이징 중...';
  @override
  String conflictedFilesCount({required Object count}) => '충돌된 파일 (${count})';
  @override
  String get selectFileToResolve => '해결할 파일 선택';
  @override
  String resolvingFile({required Object file}) => '해결 중: ${file}';
  @override
  String get keepAllOurs => '우리 것 모두 유지';
  @override
  String get acceptAllTheirs => '상대 것 모두 수락';
  @override
  String get allResolved => '이 파일의 모든 충돌이 해결되었습니다!';
  @override
  String get markResolved => '해결됨으로 표시';
  @override
  String get stageForCommit => '이 파일은 커밋을 위해 스테이징됩니다.';
  @override
  String conflictIndex({required Object index}) => '충돌 #${index}';
  @override
  String get ours => 'OURS (현재)';
  @override
  String get theirs => 'THEIRS (수신)';
  @override
  String get keepOurs => '우리 것 유지';
  @override
  String get acceptTheirs => '상대 것 수락';
  @override
  String get empty => '(비어 있음)';
}

// Path: wizards.firstRun
class _TranslationsWizardsFirstRunKo extends TranslationsWizardsFirstRunEn {
  _TranslationsWizardsFirstRunKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get welcome => 'Localizer에 오신 것을 환영합니다';
  @override
  String get description => '몇 초 만에 로컬라이제이션 파일을 비교하세요.';
  @override
  String get sourceFile => '소스 파일';
  @override
  String get targetFile => '타겟 파일';
  @override
  String get compareNow => '지금 비교';
  @override
  String get trySample => '샘플 데이터로 시도';
  @override
  String get skip => '설정 건너뛰기';
  @override
  String get browse => '클릭하여 찾아보기';
  @override
  String error({required Object error}) => '샘플 데이터 로드 실패: ${error}';
}

// Path: dialogs.addIgnorePattern
class _TranslationsDialogsAddIgnorePatternKo
    extends TranslationsDialogsAddIgnorePatternEn {
  _TranslationsDialogsAddIgnorePatternKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '무시 패턴 추가';
  @override
  String get patternLabel => '패턴 (regex)';
  @override
  String get hint => '예: ^temp_.*';
  @override
  String get invalid => '잘못된 정규식 패턴';
  @override
  String get testStringLabel => '테스트 문자열';
  @override
  String get testHint => '패턴에 대해 테스트할 키 입력';
  @override
  String get match => '✓ 패턴이 테스트 문자열과 일치함';
  @override
  String get noMatch => '✗ 패턴이 일치하지 않음';
  @override
  String get add => '추가';
  @override
  String get cancel => '취소';
}

// Path: dialogs.diffViewer
class _TranslationsDialogsDiffViewerKo extends TranslationsDialogsDiffViewerEn {
  _TranslationsDialogsDiffViewerKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Diff 뷰어';
  @override
  String get originalFile => '원본/참조 파일';
  @override
  String get translationFile => '번역/비교 파일';
  @override
  String get base => '베이스';
  @override
  String get target => '타겟';
  @override
  String get added => '추가됨';
  @override
  String get removed => '제거됨';
  @override
  String get modified => '수정됨';
  @override
  String get noMatches => '현재 필터와 일치하는 항목 없음';
  @override
  String get clickToggle => '필터를 전환하려면 위 배지를 클릭하세요';
}

// Path: grid.columns
class _TranslationsGridColumnsKo extends TranslationsGridColumnsEn {
  _TranslationsGridColumnsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get key => '키';
  @override
  String get source => '소스';
  @override
  String get status => '상태';
  @override
  String get actions => '작업';
}

// Path: tutorial.steps
class _TranslationsTutorialStepsKo extends TranslationsTutorialStepsEn {
  _TranslationsTutorialStepsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTutorialStepsImportSourceKo importSource =
      _TranslationsTutorialStepsImportSourceKo._(_root);
  @override
  late final _TranslationsTutorialStepsImportTargetKo importTarget =
      _TranslationsTutorialStepsImportTargetKo._(_root);
  @override
  late final _TranslationsTutorialStepsCompareKo compare =
      _TranslationsTutorialStepsCompareKo._(_root);
  @override
  late final _TranslationsTutorialStepsFilterKo filter =
      _TranslationsTutorialStepsFilterKo._(_root);
  @override
  late final _TranslationsTutorialStepsSearchKo search =
      _TranslationsTutorialStepsSearchKo._(_root);
  @override
  late final _TranslationsTutorialStepsAdvancedKo advanced =
      _TranslationsTutorialStepsAdvancedKo._(_root);
  @override
  late final _TranslationsTutorialStepsExportKo export =
      _TranslationsTutorialStepsExportKo._(_root);
}

// Path: friendlyErrors.fileNotFound
class _TranslationsFriendlyErrorsFileNotFoundKo
    extends TranslationsFriendlyErrorsFileNotFoundEn {
  _TranslationsFriendlyErrorsFileNotFoundKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '파일 또는 폴더를 찾을 수 없습니다.';
  @override
  String get suggestion => '파일이 이동되었거나 삭제되었는지 확인하세요.';
}

// Path: friendlyErrors.accessDenied
class _TranslationsFriendlyErrorsAccessDeniedKo
    extends TranslationsFriendlyErrorsAccessDeniedEn {
  _TranslationsFriendlyErrorsAccessDeniedKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '파일에 대한 액세스가 거부되었습니다.';
  @override
  String get suggestion => '관리자 권한으로 앱을 실행하거나 파일 권한을 확인하세요.';
}

// Path: friendlyErrors.isDirectory
class _TranslationsFriendlyErrorsIsDirectoryKo
    extends TranslationsFriendlyErrorsIsDirectoryEn {
  _TranslationsFriendlyErrorsIsDirectoryKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '파일 대신 폴더가 선택되었습니다.';
  @override
  String get suggestion => '유효한 파일을 선택하세요.';
}

// Path: friendlyErrors.fileAccess
class _TranslationsFriendlyErrorsFileAccessKo
    extends TranslationsFriendlyErrorsFileAccessEn {
  _TranslationsFriendlyErrorsFileAccessKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '파일에 액세스하는 데 문제가 발생했습니다.';
  @override
  String get suggestion => '파일을 사용 중일 수 있는 다른 프로그램을 닫고 시도해 보세요.';
}

// Path: friendlyErrors.unsupportedFormat
class _TranslationsFriendlyErrorsUnsupportedFormatKo
    extends TranslationsFriendlyErrorsUnsupportedFormatEn {
  _TranslationsFriendlyErrorsUnsupportedFormatKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '이 파일 형식 또는 작업은 지원되지 않습니다.';
  @override
  String get suggestion => '파일 확장자를 확인하거나 다른 형식을 시도해 보세요.';
}

// Path: friendlyErrors.networkError
class _TranslationsFriendlyErrorsNetworkErrorKo
    extends TranslationsFriendlyErrorsNetworkErrorEn {
  _TranslationsFriendlyErrorsNetworkErrorKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '서버에 연결할 수 없습니다.';
  @override
  String get suggestion => '인터넷 연결을 확인하고 다시 시도해 보세요.';
}

// Path: friendlyErrors.notGitRepo
class _TranslationsFriendlyErrorsNotGitRepoKo
    extends TranslationsFriendlyErrorsNotGitRepoEn {
  _TranslationsFriendlyErrorsNotGitRepoKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '이 폴더는 Git 프로젝트가 아닙니다.';
  @override
  String get suggestion => '.git 디렉토리가 포함된 폴더로 이동하세요.';
}

// Path: friendlyErrors.mergeConflict
class _TranslationsFriendlyErrorsMergeConflictKo
    extends TranslationsFriendlyErrorsMergeConflictEn {
  _TranslationsFriendlyErrorsMergeConflictKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '저장소에 병합 충돌이 있습니다.';
  @override
  String get suggestion => '계속하기 전에 충돌을 해결하세요.';
}

// Path: friendlyErrors.gitAuthFailed
class _TranslationsFriendlyErrorsGitAuthFailedKo
    extends TranslationsFriendlyErrorsGitAuthFailedEn {
  _TranslationsFriendlyErrorsGitAuthFailedKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Git 인증에 실패했습니다.';
  @override
  String get suggestion => '설정 > 버전 제어에서 자격 증명을 확인하세요.';
}

// Path: friendlyErrors.gitOperationFailed
class _TranslationsFriendlyErrorsGitOperationFailedKo
    extends TranslationsFriendlyErrorsGitOperationFailedEn {
  _TranslationsFriendlyErrorsGitOperationFailedKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Git 작업이 실패했습니다.';
  @override
  String get suggestion => '자세한 내용은 Git 보기를 확인하세요.';
}

// Path: friendlyErrors.invalidJson
class _TranslationsFriendlyErrorsInvalidJsonKo
    extends TranslationsFriendlyErrorsInvalidJsonEn {
  _TranslationsFriendlyErrorsInvalidJsonKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '파일 형식이 유효하지 않거나 손상되었습니다.';
  @override
  String get suggestion => '파일에 유효한 JSON 콘텐츠가 포함되어 있는지 확인하세요.';
}

// Path: friendlyErrors.rateLimitReached
class _TranslationsFriendlyErrorsRateLimitReachedKo
    extends TranslationsFriendlyErrorsRateLimitReachedEn {
  _TranslationsFriendlyErrorsRateLimitReachedKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '번역 한도에 도달했습니다.';
  @override
  String get suggestion => '몇 분 기다리거나 API 요금제 한도를 확인하세요.';
}

// Path: friendlyErrors.invalidApiKey
class _TranslationsFriendlyErrorsInvalidApiKeyKo
    extends TranslationsFriendlyErrorsInvalidApiKeyEn {
  _TranslationsFriendlyErrorsInvalidApiKeyKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '유효하지 않은 API 키입니다.';
  @override
  String get suggestion => 'API 키를 업데이트하려면 설정 > AI 번역으로 이동하세요.';
}

// Path: friendlyErrors.translationServiceError
class _TranslationsFriendlyErrorsTranslationServiceErrorKo
    extends TranslationsFriendlyErrorsTranslationServiceErrorEn {
  _TranslationsFriendlyErrorsTranslationServiceErrorKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '번역 서비스 오류입니다.';
  @override
  String get suggestion => 'API 키와 인터넷 연결을 확인하세요.';
}

// Path: friendlyErrors.outOfMemory
class _TranslationsFriendlyErrorsOutOfMemoryKo
    extends TranslationsFriendlyErrorsOutOfMemoryEn {
  _TranslationsFriendlyErrorsOutOfMemoryKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '이 작업을 완료하기에 메모리가 부족합니다.';
  @override
  String get suggestion => '다른 애플리케이션을 닫거나 더 작은 파일을 사용해 보세요.';
}

// Path: friendlyErrors.genericError
class _TranslationsFriendlyErrorsGenericErrorKo
    extends TranslationsFriendlyErrorsGenericErrorEn {
  _TranslationsFriendlyErrorsGenericErrorKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get message => '문제가 발생했습니다.';
  @override
  String get suggestion => '다시 시도해 보세요. 문제가 지속되면 앱을 다시 시작하세요.';
}

// Path: settings.appearance.presets
class _TranslationsSettingsAppearancePresetsKo
    extends TranslationsSettingsAppearancePresetsEn {
  _TranslationsSettingsAppearancePresetsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get presetDefault => '기본';
  @override
  String get presetColorblind => '적록색약 친화적';
  @override
  String get presetHighContrast => '고대비';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.appearance.preview
class _TranslationsSettingsAppearancePreviewKo
    extends TranslationsSettingsAppearancePreviewEn {
  _TranslationsSettingsAppearancePreviewKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get step3Title => 'onboarding.step3.title';
  @override
  String get connectAccount => '"계정 연결"';
  @override
  String get loginHint => 'deprecated.login_hint_v1';
  @override
  String get enterCredentials => '"자격 증명 입력"';
  @override
  String get ctaButton => 'checkout.cta_button';
  @override
  String get buyNow => '"지금 구매"';
  @override
  String get completePurchase => '"구매 완료"';
  @override
  String get appNameKey => 'common.app_name';
  @override
  String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class _TranslationsSettingsComparisonPatternPresetsKo
    extends TranslationsSettingsComparisonPatternPresetsEn {
  _TranslationsSettingsComparisonPatternPresetsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get comments => '주석';
  @override
  String get tempKeys => '임시 키';
  @override
  String get placeholders => '플레이스홀더';
  @override
  String get devOnly => '개발 전용';
}

// Path: settings.comparison.previewMatch
class _TranslationsSettingsComparisonPreviewMatchKo
    extends TranslationsSettingsComparisonPreviewMatchEn {
  _TranslationsSettingsComparisonPreviewMatchKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '일치 미리보기';
  @override
  String get description => '현재 설정이 일치 로직에 미치는 영향을 테스트합니다.';
  @override
  String get stringA => '문자열 A';
  @override
  String get stringB => '문자열 B';
  @override
  String get enterText => '텍스트 입력...';
  @override
  String get similarity => '유사도';
  @override
  String get identical => '동일함';
  @override
  String get identicalDescription => '정규화 후 문자열이 정확히 일치합니다.';
  @override
  String get ignored => '무시됨';
  @override
  String get ignoredDescription => '입력이 무시 패턴과 일치합니다.';
  @override
  String get different => '다름';
  @override
  String get differentDescription => '한 값이 비어 있습니다.';
  @override
  String get similarModified => '유사함 / 수정됨';
  @override
  String similarModifiedDescription({required Object threshold}) =>
      '일치 점수가 임계값(${threshold}%) 이상입니다.';
  @override
  String get newDifferent => '신규 / 다름';
  @override
  String newDifferentDescription({required Object threshold}) =>
      '일치 점수가 임계값(${threshold}%) 미만입니다.';
}

// Path: settings.comparison.colorPresets
class _TranslationsSettingsComparisonColorPresetsKo
    extends TranslationsSettingsComparisonColorPresetsEn {
  _TranslationsSettingsComparisonColorPresetsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get kDefault => '기본';
  @override
  String get colorblindFriendly => '적록색약 친화적';
  @override
  String get highContrast => '고대비';
  @override
  String get nord => 'Nord';
  @override
  String get solarized => 'Solarized';
  @override
  String get monokai => 'Monokai';
  @override
  String get presetDefault => '기본';
  @override
  String get presetColorblind => '적록색약 친화적';
  @override
  String get presetHighContrast => '고대비';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.integrations.materials
class _TranslationsSettingsIntegrationsMaterialsKo
    extends TranslationsSettingsIntegrationsMaterialsEn {
  _TranslationsSettingsIntegrationsMaterialsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get sidebar => '사이드바';
  @override
  String get menu => '메뉴';
  @override
  String get popover => '팝오버';
  @override
  String get titlebar => '제목 표시줄';
  @override
  String get underPageBackground => '페이지 배경';
  @override
  String get contentBackground => '콘텐츠';
}

// Path: settings.integrations.fileTypes
class _TranslationsSettingsIntegrationsFileTypesKo
    extends TranslationsSettingsIntegrationsFileTypesEn {
  _TranslationsSettingsIntegrationsFileTypesKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get loc => 'Localizer 프로젝트 파일';
  @override
  String get lang => '언어 파일';
  @override
  String get json => 'JSON 로컬라이제이션 파일';
  @override
  String get xml => 'XML 로컬라이제이션 파일';
}

// Path: settings.developer.themePlaygroundSection
class _TranslationsSettingsDeveloperThemePlaygroundSectionKo
    extends TranslationsSettingsDeveloperThemePlaygroundSectionEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get colors => '색상';
  @override
  String get typography => '타이포그래피';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteKo
      palette =
      _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteKo._(_root);
}

// Path: settings.developer.featureFlags
class _TranslationsSettingsDeveloperFeatureFlagsKo
    extends TranslationsSettingsDeveloperFeatureFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '실험적 기능';
  @override
  String get description =>
      '테스트를 위해 로컬에서 기능 플래그를 전환합니다. 이 재정의는 앱 재시작 후에도 유지됩니다.';
  @override
  String get subtitle => '실험적 기능 재정의';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsKo flags =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsKo._(_root);
  @override
  String get reset => '모든 플래그 재설정';
  @override
  String get overrides => '로컬 재정의';
  @override
  String get defaultVal => '기본값';
  @override
  String get on => '켜짐';
  @override
  String get off => '꺼짐';
}

// Path: settings.developer.storageInspectorSection
class _TranslationsSettingsDeveloperStorageInspectorSectionKo
    extends TranslationsSettingsDeveloperStorageInspectorSectionEn {
  _TranslationsSettingsDeveloperStorageInspectorSectionKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => '새로 고침';
  @override
  String get hiveData => 'Hive 데이터';
  @override
  String get secureStorage => '보안 저장소';
}

// Path: settings.developer.deviceInfoSection
class _TranslationsSettingsDeveloperDeviceInfoSectionKo
    extends TranslationsSettingsDeveloperDeviceInfoSectionEn {
  _TranslationsSettingsDeveloperDeviceInfoSectionKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => '새로 고침';
  @override
  String get copy => '클립보드에 복사';
  @override
  String get computerName => '컴퓨터 이름';
  @override
  String get osVersion => 'OS 버전';
}

// Path: settings.developer.localizationInspectorSection
class _TranslationsSettingsDeveloperLocalizationInspectorSectionKo
    extends TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
  _TranslationsSettingsDeveloperLocalizationInspectorSectionKo._(
      TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get showKeys => '값 대신 키 표시';
  @override
  String get keysVisible => '키 표시 중';
  @override
  String get normalDisplay => '정상 표시';
  @override
  String get note => '참고: 이 기능을 사용하려면 앱 로컬라이제이션이 이 설정을 준수하는 래퍼를 사용해야 합니다.';
}

// Path: settings.onboarding.steps
class _TranslationsSettingsOnboardingStepsKo
    extends TranslationsSettingsOnboardingStepsEn {
  _TranslationsSettingsOnboardingStepsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsOnboardingStepsImportFilesKo importFiles =
      _TranslationsSettingsOnboardingStepsImportFilesKo._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsRunComparisonKo runComparison =
      _TranslationsSettingsOnboardingStepsRunComparisonKo._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsReviewMissingKo reviewMissing =
      _TranslationsSettingsOnboardingStepsReviewMissingKo._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsUseFiltersKo useFilters =
      _TranslationsSettingsOnboardingStepsUseFiltersKo._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsSearchResultsKo searchResults =
      _TranslationsSettingsOnboardingStepsSearchResultsKo._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsAdvancedViewKo advancedView =
      _TranslationsSettingsOnboardingStepsAdvancedViewKo._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsEditCellKo editCell =
      _TranslationsSettingsOnboardingStepsEditCellKo._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsExportResultsKo exportResults =
      _TranslationsSettingsOnboardingStepsExportResultsKo._(_root);
}

// Path: settings.settingsView.categories
class _TranslationsSettingsSettingsViewCategoriesKo
    extends TranslationsSettingsSettingsViewCategoriesEn {
  _TranslationsSettingsSettingsViewCategoriesKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get general => '일반 설정';
  @override
  String get comparisonEngine => '비교 엔진';
  @override
  String get appearance => '화면 표시';
  @override
  String get fileHandling => '파일 처리';
  @override
  String get aiServices => 'AI 서비스';
  @override
  String get systemIntegrations => '시스템 통합';
  @override
  String get projectResources => '프로젝트 리소스 (용어집 & TM)';
  @override
  String get developer => '개발자 옵션';
  @override
  String get about => '정보';
}

// Path: settings.settingsView.categoryLabels
class _TranslationsSettingsSettingsViewCategoryLabelsKo
    extends TranslationsSettingsSettingsViewCategoryLabelsEn {
  _TranslationsSettingsSettingsViewCategoryLabelsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get general => '일반';
  @override
  String get comparisonEngine => '비교';
  @override
  String get appearance => '화면 표시';
  @override
  String get fileHandling => '파일 처리';
  @override
  String get aiServices => 'AI 서비스';
  @override
  String get systemIntegrations => '시스템 통합';
  @override
  String get projectResources => '프로젝트 리소스';
  @override
  String get developer => '개발자 옵션';
  @override
  String get about => '정보';
}

// Path: advancedDiff.sidebar.actionsSection
class _TranslationsAdvancedDiffSidebarActionsSectionKo
    extends TranslationsAdvancedDiffSidebarActionsSectionEn {
  _TranslationsAdvancedDiffSidebarActionsSectionKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get exportMatches => '일치 항목 내보내기';
  @override
  String get preview => '미리보기';
  @override
  String get fillFromTmTitle => '번역 메모리에서 채우기?';
  @override
  String get fillFromTmContent =>
      '빈 타겟 값을 번역 메모리의 일치 항목으로 채우려고 시도합니다. 기존 값은 덮어쓰지 않습니다.';
  @override
  String get fill => '채우기';
  @override
  String get fillFromMemory => '메모리에서 채우기';
  @override
  String filledFromTm({required Object count}) =>
      '번역 메모리에서 ${count}개 항목을 채웠습니다.';
}

// Path: advancedDiff.sidebar.aiSection
class _TranslationsAdvancedDiffSidebarAiSectionKo
    extends TranslationsAdvancedDiffSidebarAiSectionEn {
  _TranslationsAdvancedDiffSidebarAiSectionKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get infoCloud => '클라우드 번역을 사용하여 소스에서 빈 타겟 값을 번역합니다.';
  @override
  String get infoAi => 'AI를 사용하여 소스에서 빈 타겟 값을 번역합니다.';
  @override
  String get translationSettings => '번역 설정';
  @override
  String get aiSettings => 'AI 설정';
  @override
  String get source => '소스';
  @override
  String get target => '타겟';
  @override
  String translatingProgress({required Object percent}) =>
      '번역 중... ${percent}%';
  @override
  String get translating => '번역 중...';
  @override
  String get translateAllMissing => '누락된 항목 모두 번역';
  @override
  String get translateAllTitle => '누락된 항목 모두 번역?';
  @override
  String translateAllContent(
          {required Object service,
          required Object source,
          required Object target}) =>
      '${service}을(를) 사용하여 빈 타겟 값이 있는 모든 항목을 ${source}에서 ${target}(으)로 번역합니다.\n\n각 제안을 검토하거나 한 번에 모두 적용할 수 있습니다.';
  @override
  String get translateAll => '모두 번역';
  @override
  String get reviewEach => '개별 검토';
  @override
  String cloudTranslated({required Object count}) =>
      '클라우드 번역으로 ${count}개 항목을 번역했습니다.';
  @override
  String aiTranslated({required Object count}) => 'AI로 ${count}개 항목을 번역했습니다.';
  @override
  String get aiTranslateFailed => 'AI 모두 번역 실패';
  @override
  String get noMissingEntries => '번역할 누락된 항목이 없습니다.';
  @override
  String get skip => '건너뛰기';
  @override
  String get stop => '중지';
  @override
  String cloudApplied({required Object count}) => '${count}개 제안 적용됨.';
  @override
  String aiApplied({required Object count}) => '${count}개 AI 제안 적용됨.';
}

// Path: advancedDiff.sidebar.tmSection
class _TranslationsAdvancedDiffSidebarTmSectionKo
    extends TranslationsAdvancedDiffSidebarTmSectionEn {
  _TranslationsAdvancedDiffSidebarTmSectionKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get enableTmFill => 'TM 채우기 활성화';
  @override
  String get autoApplyAboveMinimum => '최소값 이상 자동 적용';
  @override
  String get matchSettings => '일치 설정';
  @override
  String get minMatch => '최소 일치:';
  @override
  String get limit => '제한:';
  @override
  String get exact => '정확함';
}

// Path: advancedDiff.sidebar.filtersSection
class _TranslationsAdvancedDiffSidebarFiltersSectionKo
    extends TranslationsAdvancedDiffSidebarFiltersSectionEn {
  _TranslationsAdvancedDiffSidebarFiltersSectionKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get viewFilters => '보기 필터';
  @override
  String get showAll => '모두 표시';
  @override
  String get added => '추가됨';
  @override
  String get removed => '제거됨';
  @override
  String get modified => '수정됨';
  @override
  String get actionScope => '작업 범위';
  @override
  String get applyToAdded => '추가된 항목에 적용';
  @override
  String get applyToModified => '수정된 항목에 적용';
  @override
  String get onlyFillEmptyTargets => '빈 타겟만 채우기';
  @override
  String get limitToVisible => '표시된 항목으로 제한';
  @override
  String get editMode => '편집 모드';
  @override
  String get dialog => '대화 상자';
  @override
  String get inline => '인라인';
}

// Path: advancedDiff.sidebar.similaritySection
class _TranslationsAdvancedDiffSidebarSimilaritySectionKo
    extends TranslationsAdvancedDiffSidebarSimilaritySectionEn {
  _TranslationsAdvancedDiffSidebarSimilaritySectionKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get currentFilter => '현재 필터:';
  @override
  String get any => '전체';
  @override
  String get high => '높음';
  @override
  String get medium => '중간';
  @override
  String get low => '낮음';
}

// Path: advancedDiff.sidebar.statusSection
class _TranslationsAdvancedDiffSidebarStatusSectionKo
    extends TranslationsAdvancedDiffSidebarStatusSectionEn {
  _TranslationsAdvancedDiffSidebarStatusSectionKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String total({required Object count}) => '총 ${count}개';
  @override
  String extra({required Object count}) => '추가 ${count}개';
  @override
  String missing({required Object count}) => '누락 ${count}개';
  @override
  String changed({required Object count}) => '변경 ${count}개';
}

// Path: tutorial.steps.importSource
class _TranslationsTutorialStepsImportSourceKo
    extends TranslationsTutorialStepsImportSourceEn {
  _TranslationsTutorialStepsImportSourceKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '1. 소스 파일 가져오기';
  @override
  String get description => '아래 버튼을 사용하여 파일을 찾아보거나 강조 표시된 영역에 드래그 앤 드롭하세요.';
}

// Path: tutorial.steps.importTarget
class _TranslationsTutorialStepsImportTargetKo
    extends TranslationsTutorialStepsImportTargetEn {
  _TranslationsTutorialStepsImportTargetKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '2. 타겟 파일 가져오기';
  @override
  String get description => '아래 버튼을 사용하여 파일을 찾아보거나 강조 표시된 영역에 드래그 앤 드롭하세요.';
}

// Path: tutorial.steps.compare
class _TranslationsTutorialStepsCompareKo
    extends TranslationsTutorialStepsCompareEn {
  _TranslationsTutorialStepsCompareKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '3. 파일 비교';
  @override
  String get description => '결과를 보려면 아래 버튼을 탭하여 비교를 실행하세요.';
}

// Path: tutorial.steps.filter
class _TranslationsTutorialStepsFilterKo
    extends TranslationsTutorialStepsFilterEn {
  _TranslationsTutorialStepsFilterKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '4. 결과 필터링';
  @override
  String get description => '이 필터를 사용하여 추가됨, 제거됨, 또는 수정된 문자열을 확인하세요.';
}

// Path: tutorial.steps.search
class _TranslationsTutorialStepsSearchKo
    extends TranslationsTutorialStepsSearchEn {
  _TranslationsTutorialStepsSearchKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '5. 검색 결과';
  @override
  String get description => '검색 창을 사용하여 특정 키나 값을 찾으세요.';
}

// Path: tutorial.steps.advanced
class _TranslationsTutorialStepsAdvancedKo
    extends TranslationsTutorialStepsAdvancedEn {
  _TranslationsTutorialStepsAdvancedKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '6. 고급 보기';
  @override
  String get description => '편집, AI 번역 등을 포함한 상세 diff 보기를 엽니다.';
}

// Path: tutorial.steps.export
class _TranslationsTutorialStepsExportKo
    extends TranslationsTutorialStepsExportEn {
  _TranslationsTutorialStepsExportKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '7. 결과 내보내기';
  @override
  String get description => '비교 내용을 CSV, JSON 또는 Excel 파일로 저장하세요.';
}

// Path: settings.developer.themePlaygroundSection.palette
class _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteKo
    extends TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteKo._(
      TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get primary => 'Primary';
  @override
  String get onPrimary => 'On Primary';
  @override
  String get secondary => 'Secondary';
  @override
  String get onSecondary => 'On Secondary';
  @override
  String get surface => 'Surface';
  @override
  String get onSurface => 'On Surface';
  @override
  String get error => 'Error';
  @override
  String get onError => 'On Error';
  @override
  String get outline => 'Outline';
  @override
  String get shadow => 'Shadow';
  @override
  String get success => 'Success';
  @override
  String get warning => 'Warning';
  @override
  String get info => 'Info';
}

// Path: settings.developer.featureFlags.flags
class _TranslationsSettingsDeveloperFeatureFlagsFlagsKo
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchKo
      experimental_ai_batch =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchKo._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmKo
      new_diff_algorithm =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmKo._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchKo
      enhanced_search =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchKo._(_root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveKo
      auto_save =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveKo._(_root);
}

// Path: settings.onboarding.steps.importFiles
class _TranslationsSettingsOnboardingStepsImportFilesKo
    extends TranslationsSettingsOnboardingStepsImportFilesEn {
  _TranslationsSettingsOnboardingStepsImportFilesKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '파일 가져오기';
  @override
  String get description => '소스 및 타겟 파일 로드';
}

// Path: settings.onboarding.steps.runComparison
class _TranslationsSettingsOnboardingStepsRunComparisonKo
    extends TranslationsSettingsOnboardingStepsRunComparisonEn {
  _TranslationsSettingsOnboardingStepsRunComparisonKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '비교 실행';
  @override
  String get description => '"파일 비교" 클릭';
}

// Path: settings.onboarding.steps.reviewMissing
class _TranslationsSettingsOnboardingStepsReviewMissingKo
    extends TranslationsSettingsOnboardingStepsReviewMissingEn {
  _TranslationsSettingsOnboardingStepsReviewMissingKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '누락된 키 검토';
  @override
  String get description => '빨간색 누락(MISSING) 항목 확인';
}

// Path: settings.onboarding.steps.useFilters
class _TranslationsSettingsOnboardingStepsUseFiltersKo
    extends TranslationsSettingsOnboardingStepsUseFiltersEn {
  _TranslationsSettingsOnboardingStepsUseFiltersKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '필터 사용';
  @override
  String get description => '유형별 필터링';
}

// Path: settings.onboarding.steps.searchResults
class _TranslationsSettingsOnboardingStepsSearchResultsKo
    extends TranslationsSettingsOnboardingStepsSearchResultsEn {
  _TranslationsSettingsOnboardingStepsSearchResultsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '검색 결과';
  @override
  String get description => '특정 키 찾기';
}

// Path: settings.onboarding.steps.advancedView
class _TranslationsSettingsOnboardingStepsAdvancedViewKo
    extends TranslationsSettingsOnboardingStepsAdvancedViewEn {
  _TranslationsSettingsOnboardingStepsAdvancedViewKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '고급 보기';
  @override
  String get description => '상세 분석 탐색';
}

// Path: settings.onboarding.steps.editCell
class _TranslationsSettingsOnboardingStepsEditCellKo
    extends TranslationsSettingsOnboardingStepsEditCellEn {
  _TranslationsSettingsOnboardingStepsEditCellKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '셀 편집';
  @override
  String get description => '값을 클릭하여 편집';
}

// Path: settings.onboarding.steps.exportResults
class _TranslationsSettingsOnboardingStepsExportResultsKo
    extends TranslationsSettingsOnboardingStepsExportResultsEn {
  _TranslationsSettingsOnboardingStepsExportResultsKo._(TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get title => '내보내기';
  @override
  String get description => '보고서 저장';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchKo
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchKo._(
      TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get name => '실험적 AI 배치';
  @override
  String get description => '여러 행에 대한 배치 AI 번역 활성화';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmKo
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmKo._(
      TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get name => '새로운 Diff 알고리즘';
  @override
  String get description => '비교를 위해 개선된 diff 알고리즘 사용';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchKo
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchKo._(
      TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get name => '향상된 검색';
  @override
  String get description => '번역 파일에서 퍼지 검색 활성화';
}

// Path: settings.developer.featureFlags.flags.auto_save
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveKo
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveKo._(
      TranslationsKo root)
      : this._root = root,
        super.internal(root);

  final TranslationsKo _root; // ignore: unused_field

  // Translations
  @override
  String get name => '자동 저장';
  @override
  String get description => '편집 후 변경 사항 자동 저장';
}

/// The flat map containing all translations for locale <ko>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsKo {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
          'app.title' => '로컬라이제이션 비교 도구',
          'app.name' => 'Localizer',
          'common.save' => '저장',
          'common.cancel' => '취소',
          'common.close' => '닫기',
          'common.delete' => '삭제',
          'common.edit' => '편집',
          'common.add' => '추가',
          'common.search' => '검색',
          'common.undo' => '실행 취소',
          'common.loading' => '로딩 중...',
          'common.error' => '오류',
          'common.success' => '성공',
          'common.warning' => '경고',
          'common.info' => '정보',
          'common.confirm' => '확인',
          'common.yes' => '예',
          'common.no' => '아니요',
          'common.ok' => '확인',
          'common.retry' => '재시도',
          'common.copyText' => '복사',
          'common.appName' => 'Localizer',
          'common.copied' => '복사됨!',
          'common.enabled' => '사용',
          'common.disabled' => '사용 안 함',
          'common.browse' => '찾아보기',
          'common.clear' => '지우기',
          'common.apply' => '적용',
          'common.reset' => '초기화',
          'common.refresh' => '새로 고침',
          'common.export' => '내보내기',
          'common.import' => '가져오기',
          'common.select' => '선택',
          'common.selectAll' => '전체 선택',
          'common.deselectAll' => '전체 선택 해제',
          'common.noResults' => '결과 없음',
          'common.emptyState' => '내용이 없습니다',
          'common.open' => '열기',
          'common.change' => '변경',
          'common.original' => '원본',
          'common.kNew' => '신규',
          'common.remove' => '제거',
          'common.auto' => '자동',
          'common.execute' => '실행',
          'common.run' => '실행',
          'common.unknown' => '알 수 없음',
          'common.download' => '다운로드',
          'common.dropdownArrow' => '드롭다운 화살표',
          'common.openInNewWindow' => '새 창에서 열기',
          'common.resetToDefaults' => '기본값으로 재설정',
          'menu.file' => '파일',
          'menu.edit' => '편집',
          'menu.view' => '보기',
          'menu.help' => '도움말',
          'menu.openFiles' => '파일 열기...',
          'menu.openFolder' => '폴더 열기...',
          'menu.exportResults' => '결과 내보내기...',
          'menu.undo' => '실행 취소',
          'menu.redo' => '다시 실행',
          'menu.cut' => '오려두기',
          'menu.paste' => '붙여넣기',
          'menu.selectAll' => '전체 선택',
          'menu.zoomIn' => '확대',
          'menu.zoomOut' => '축소',
          'menu.resetZoom' => '배율 초기화',
          'menu.documentation' => '문서',
          'menu.reportIssue' => '문제 보고',
          'menu.about' => ({required Object appName}) => '${appName} 정보',
          'nav.compare' => '비교',
          'nav.history' => '기록',
          'nav.settings' => '설정',
          'nav.projects' => '프로젝트',
          'nav.dashboard' => '대시보드',
          'nav.directory' => '디렉토리',
          'nav.repository' => '저장소',
          'nav.tooltipCompare' => '로컬라이제이션 파일 비교',
          'nav.tooltipHistory' => '비교 기록 보기',
          'nav.tooltipSettings' => '앱 설정',
          'nav.tooltipProjects' => '프로젝트 관리',
          'nav.tooltipThemeToggle' => '테마 전환',
          'nav.tooltipDebugConsole' => '디버그 콘솔',
          'settings.title' => '설정',
          'settings.appSettings' => '앱 설정',
          'settings.projectSettings' => '프로젝트 설정',
          'settings.appearance.title' => '화면 표시',
          'settings.appearance.description' => '앱의 모양과 느낌을 사용자 정의합니다',
          'settings.appearance.theme' => '테마 모드',
          'settings.appearance.themeDescription' => '라이트, 다크 또는 시스템 테마 중 선택',
          'settings.appearance.themeSystem' => '시스템',
          'settings.appearance.themeLight' => '라이트',
          'settings.appearance.themeDark' => '다크',
          'settings.appearance.themeAmoled' => 'AMOLED',
          'settings.appearance.accentColor' => '강조 색상',
          'settings.appearance.accentColorDescription' => '선호하는 강조 색상을 선택하세요',
          'settings.appearance.useMicaEffect' => 'Mica 효과 사용',
          'settings.appearance.micaDescription' =>
            '현대적인 룩을 위해 Windows 11 Mica 투명 효과 활성화',
          'settings.appearance.diffFontSize' => '비교 글꼴 크기',
          'settings.appearance.diffFontSizeDescription' => '비교 보기의 글꼴 크기 조정',
          'settings.appearance.diffFontFamily' => '비교 글꼴 패밀리',
          'settings.appearance.diffFontFamilyDescription' => '비교 보기를 위한 글꼴',
          'settings.appearance.systemDefault' => '시스템 기본값',
          'settings.appearance.pickAccentColor' => '강조 색상 선택',
          'settings.appearance.diffColors' => '비교 색상',
          'settings.appearance.presetsTitle' => '프리셋',
          'settings.appearance.presets.presetDefault' => '기본',
          'settings.appearance.presets.presetColorblind' => '적록색약 친화적',
          'settings.appearance.presets.presetHighContrast' => '고대비',
          'settings.appearance.presets.presetNord' => 'Nord',
          'settings.appearance.presets.presetSolarized' => 'Solarized',
          'settings.appearance.presets.presetMonokai' => 'Monokai',
          'settings.appearance.identical' => '동일함',
          'settings.appearance.pickColorFor' => ({required Object label}) =>
              '${label} 색상 선택',
          'settings.appearance.livePreview' => '라이브 미리보기',
          'settings.appearance.preview.step3Title' => 'onboarding.step3.title',
          'settings.appearance.preview.connectAccount' => '"계정 연결"',
          'settings.appearance.preview.loginHint' => 'deprecated.login_hint_v1',
          'settings.appearance.preview.enterCredentials' => '"자격 증명 입력"',
          'settings.appearance.preview.ctaButton' => 'checkout.cta_button',
          'settings.appearance.preview.buyNow' => '"지금 구매"',
          'settings.appearance.preview.completePurchase' => '"구매 완료"',
          'settings.appearance.preview.appNameKey' => 'common.app_name',
          'settings.appearance.preview.appNameValue' => '"Localizer"',
          'settings.general.title' => '일반',
          'settings.general.description' => '일반 애플리케이션 설정',
          'settings.general.language' => '언어',
          'settings.general.languageDescription' => '선호하는 언어를 선택하세요',
          'settings.general.startMinimized' => '트레이로 최소화하여 시작',
          'settings.general.startMinimizedDescription' =>
            '앱을 시스템 트레이로 최소화하여 시작합니다',
          'settings.general.rememberWindowPosition' => '창 위치 기억',
          'settings.general.rememberWindowPositionDescription' =>
            '시작 시 창 크기 및 위치 복원',
          'settings.general.openLastProject' => '시작 시 마지막 프로젝트 열기',
          'settings.general.openLastProjectDescription' =>
            '앱 시작 시 마지막으로 사용한 프로젝트를 자동으로 엽니다',
          'settings.general.application' => '애플리케이션',
          'settings.general.defaultView' => '기본 보기',
          'settings.general.defaultViewDescription' => '시작 시 보여줄 보기',
          'settings.general.autoCheckUpdates' => '업데이트 자동 확인',
          'settings.general.autoCheckUpdatesDescription' => '시작 시 업데이트 확인',
          'settings.general.startupOptions' => '시작 옵션',
          'settings.general.languageAuto' => '자동 감지',
          'settings.general.viewBasic' => '파일 비교',
          'settings.general.viewHistory' => '기록',
          'settings.general.viewDashboard' => '품질 대시보드',
          'settings.general.viewDirectory' => '디렉토리 비교',
          'settings.general.viewLastUsed' => '마지막 사용 보기',
          'settings.scope.title' => '설정 범위',
          'settings.scope.global' => '전역 기본값',
          'settings.scope.project' => '프로젝트',
          'settings.scope.reset' => '프로젝트를 전역 기본값으로 초기화',
          'settings.scope.resetConfirmation' =>
            '이 프로젝트의 모든 재정의를 지우고 전역 기본값으로 되돌립니다. 이 작업은 취소할 수 없습니다.',
          'settings.scope.globalDescription' =>
            '변경 사항은 재정의되지 않은 모든 프로젝트에 적용됩니다.',
          'settings.scope.projectDescription' => ({required Object name}) =>
              '"${name}"에만 변경 사항이 적용됩니다. 다른 설정은 전역 기본값을 상속합니다.',
          'settings.scope.createPrompt' =>
            '특정 폴더에 대한 설정을 사용자 정의하려면 프로젝트를 생성하세요',
          'settings.searchKeywords.general.0' => '언어',
          'settings.searchKeywords.general.1' => '기본 보기',
          'settings.searchKeywords.general.2' => '최근 파일 수',
          'settings.searchKeywords.general.3' => '마지막 프로젝트 열기',
          'settings.searchKeywords.general.4' => '종료 전 확인',
          'settings.searchKeywords.general.5' => '알림 표시',
          'settings.searchKeywords.comparisonEngine.0' => '비교 모드',
          'settings.searchKeywords.comparisonEngine.1' => '유사도 임계값',
          'settings.searchKeywords.comparisonEngine.2' => '대소문자 구분',
          'settings.searchKeywords.comparisonEngine.3' => '공백 무시',
          'settings.searchKeywords.comparisonEngine.4' => '빈 줄 무시',
          'settings.searchKeywords.comparisonEngine.5' => '주석 무시',
          'settings.searchKeywords.comparisonEngine.6' => '무시 패턴',
          'settings.searchKeywords.appearance.0' => '테마',
          'settings.searchKeywords.appearance.1' => '테마 모드',
          'settings.searchKeywords.appearance.2' => '강조 색상',
          'settings.searchKeywords.appearance.3' => '비교 글꼴 크기',
          'settings.searchKeywords.appearance.4' => '비교 글꼴 패밀리',
          'settings.searchKeywords.appearance.5' => '비교 색상',
          'settings.searchKeywords.appearance.6' => '추가된 색상',
          'settings.searchKeywords.appearance.7' => '제거된 색상',
          'settings.searchKeywords.appearance.8' => '수정된 색상',
          'settings.searchKeywords.appearance.9' => '동일한 색상',
          'settings.searchKeywords.appearance.10' => '색상 프리셋',
          'settings.searchKeywords.appearance.11' => '미리보기',
          'settings.searchKeywords.fileHandling.0' => '소스 형식',
          'settings.searchKeywords.fileHandling.1' => '타겟 형식',
          'settings.searchKeywords.fileHandling.2' => '기본 인코딩',
          'settings.searchKeywords.fileHandling.3' => '최근 프로젝트 수',
          'settings.searchKeywords.fileHandling.4' => '번역 메모리',
          'settings.searchKeywords.fileHandling.5' => '메모리 가져오기',
          'settings.searchKeywords.fileHandling.6' => '메모리 내보내기',
          'settings.searchKeywords.fileHandling.7' => '메모리 지우기',
          'settings.searchKeywords.aiServices.0' => 'OpenAI API 키',
          'settings.searchKeywords.aiServices.1' => 'Anthropic API 키',
          'settings.searchKeywords.aiServices.2' => 'Google AI API 키',
          'settings.searchKeywords.aiServices.3' => 'AI 모델',
          'settings.searchKeywords.aiServices.4' => '온도',
          'settings.searchKeywords.aiServices.5' => '사용자 지정 프롬프트',
          'settings.searchKeywords.systemIntegrations.0' => '시스템 트레이',
          'settings.searchKeywords.systemIntegrations.1' => '최소화하여 시작',
          'settings.searchKeywords.systemIntegrations.2' => '파일 연결',
          'settings.searchKeywords.systemIntegrations.3' => 'Mica 효과',
          'settings.searchKeywords.systemIntegrations.4' => 'Vibrancy',
          'settings.searchKeywords.systemIntegrations.5' => '창 재질',
          'settings.searchKeywords.systemIntegrations.6' => '독 배지',
          'settings.searchKeywords.systemIntegrations.7' => '미번역 수',
          'settings.searchKeywords.projectResources.0' => '용어집',
          'settings.searchKeywords.projectResources.1' => '번역 메모리',
          'settings.searchKeywords.projectResources.2' => '용어',
          'settings.searchKeywords.about.0' => '버전',
          'settings.searchKeywords.about.1' => '업데이트 확인',
          'settings.searchKeywords.about.2' => '자동 업데이트',
          'settings.searchKeywords.about.3' => '변경 로그',
          'settings.searchKeywords.about.4' => '라이선스',
          'settings.searchKeywords.about.5' => '개인정보 처리방침',
          'settings.searchKeywords.about.6' => '텔레메트리',
          'settings.searchKeywords.about.7' => '충돌 보고',
          'settings.searchKeywords.developer.0' => '성능 오버레이',
          'settings.searchKeywords.developer.1' => '시맨틱 디버거',
          'settings.searchKeywords.developer.2' => '머티리얼 그리드',
          'settings.searchKeywords.developer.3' => '래스터 캐시',
          'settings.searchKeywords.developer.4' => '자습서 다시 시작',
          'settings.searchKeywords.developer.5' => '공장 초기화',
          'settings.comparison.title' => '비교',
          'settings.comparison.description' => '비교 동작 구성',
          'settings.comparison.caseSensitive' => '대소문자 구분',
          'settings.comparison.caseSensitiveDescription' => '대문자와 소문자를 다르게 취급',
          'settings.comparison.ignoreWhitespace' => '공백 무시',
          'settings.comparison.ignoreWhitespaceDescription' =>
            '비교 시 선행/후행 공백 무시',
          'settings.comparison.showLineNumbers' => '줄 번호 표시',
          'settings.comparison.showLineNumbersDescription' => '비교 보기에 줄 번호 표시',
          'settings.comparison.behavior' => '비교 동작',
          'settings.comparison.ignoreCase' => '대소문자 무시',
          'settings.comparison.ignoreCaseDescription' =>
            '"Key"와 "key"를 동일하게 취급',
          'settings.comparison.similarityThreshold' => '유사도 임계값',
          'settings.comparison.similarityThresholdDescription' =>
            '"수정됨" 감지를 위한 최소 유사도',
          'settings.comparison.mode' => '비교 모드',
          'settings.comparison.modeDescription' => '파일 간 항목 일치 방식',
          'settings.comparison.modeKey' => '키 기반',
          'settings.comparison.modeKeyDescription' => '키 이름으로 일치시킵니다 (기본값).',
          'settings.comparison.modeOrder' => '순서 기반',
          'settings.comparison.modeOrderDescription' => '파일 내 위치로 일치시킵니다.',
          'settings.comparison.modeSmart' => '스마트 매치',
          'settings.comparison.modeSmartDescription' => '이동/이름 변경된 키를 감지합니다.',
          'settings.comparison.ignorePatterns' => '무시 패턴',
          'settings.comparison.noIgnorePatterns' => '설정된 무시 패턴이 없습니다.',
          'settings.comparison.addPattern' => '패턴 추가',
          'settings.comparison.resetToGlobal' => '모든 비교 설정을 전역 기본값으로 초기화',
          'settings.comparison.patternPresets.comments' => '주석',
          'settings.comparison.patternPresets.tempKeys' => '임시 키',
          'settings.comparison.patternPresets.placeholders' => '플레이스홀더',
          'settings.comparison.patternPresets.devOnly' => '개발 전용',
          'settings.comparison.previewMatch.title' => '일치 미리보기',
          'settings.comparison.previewMatch.description' =>
            '현재 설정이 일치 로직에 미치는 영향을 테스트합니다.',
          'settings.comparison.previewMatch.stringA' => '문자열 A',
          'settings.comparison.previewMatch.stringB' => '문자열 B',
          'settings.comparison.previewMatch.enterText' => '텍스트 입력...',
          'settings.comparison.previewMatch.similarity' => '유사도',
          'settings.comparison.previewMatch.identical' => '동일함',
          'settings.comparison.previewMatch.identicalDescription' =>
            '정규화 후 문자열이 정확히 일치합니다.',
          'settings.comparison.previewMatch.ignored' => '무시됨',
          'settings.comparison.previewMatch.ignoredDescription' =>
            '입력이 무시 패턴과 일치합니다.',
          'settings.comparison.previewMatch.different' => '다름',
          'settings.comparison.previewMatch.differentDescription' =>
            '한 값이 비어 있습니다.',
          'settings.comparison.previewMatch.similarModified' => '유사함 / 수정됨',
          'settings.comparison.previewMatch.similarModifiedDescription' =>
            ({required Object threshold}) => '일치 점수가 임계값(${threshold}%) 이상입니다.',
          'settings.comparison.previewMatch.newDifferent' => '신규 / 다름',
          'settings.comparison.previewMatch.newDifferentDescription' =>
            ({required Object threshold}) => '일치 점수가 임계값(${threshold}%) 미만입니다.',
          'settings.comparison.colorPresets.kDefault' => '기본',
          'settings.comparison.colorPresets.colorblindFriendly' => '적록색약 친화적',
          'settings.comparison.colorPresets.highContrast' => '고대비',
          'settings.comparison.colorPresets.nord' => 'Nord',
          'settings.comparison.colorPresets.solarized' => 'Solarized',
          'settings.comparison.colorPresets.monokai' => 'Monokai',
          'settings.comparison.colorPresets.presetDefault' => '기본',
          'settings.comparison.colorPresets.presetColorblind' => '적록색약 친화적',
          'settings.comparison.colorPresets.presetHighContrast' => '고대비',
          'settings.comparison.colorPresets.presetNord' => 'Nord',
          'settings.comparison.colorPresets.presetSolarized' => 'Solarized',
          'settings.comparison.colorPresets.presetMonokai' => 'Monokai',
          'settings.fileHandling.fileFormats' => '파일 형식',
          'settings.fileHandling.sourceFormat' => '소스 형식',
          'settings.fileHandling.targetFormat' => '타겟 형식',
          'settings.fileHandling.encoding' => '인코딩',
          'settings.fileHandling.sourceEncoding' => '소스 인코딩',
          'settings.fileHandling.targetEncoding' => '타겟 인코딩',
          'settings.fileHandling.autoDetect' => '자동 감지',
          'settings.fileHandling.autoDetectEncodingDescription' =>
            '파일 인코딩 자동 감지',
          'settings.fileHandling.exportSettings' => '내보내기 설정',
          'settings.fileHandling.defaultExportFormat' => '기본 내보내기 형식',
          'settings.fileHandling.includeUtf8Bom' => 'UTF-8 BOM 포함',
          'settings.fileHandling.includeUtf8BomDescription' =>
            'Excel 호환성을 위해 필요',
          'settings.fileHandling.openFolderAfterExport' => '내보내기 후 폴더 열기',
          'settings.fileHandling.fileSafety' => '파일 안전',
          'settings.fileHandling.fileSafetyDescription' =>
            '재해 복구를 위한 자동 로컬 사본.',
          'settings.fileHandling.resetToGlobal' => '모든 파일 처리 설정을 전역 기본값으로 초기화',
          'settings.translationMemory.title' => '전역 번역 메모리',
          'settings.translationMemory.autoLearn' => '자동 학습',
          'settings.translationMemory.autoLearnDescription' =>
            '나중에 재사용할 수 있도록 번역을 로컬 메모리에 저장',
          'settings.translationMemory.confidenceThreshold' => '신뢰도 임계값',
          'settings.translationMemory.confidenceThresholdDescription' =>
            ({required Object percent}) => '자동 적용을 위한 최소 점수 (${percent}%)',
          'settings.translationMemory.entries' => '항목',
          'settings.translationMemory.size' => '크기',
          'settings.translationMemory.memorySize' => ({required Object size}) =>
              '메모리 크기: ${size}',
          'settings.translationMemory.import' => '가져오기',
          'settings.translationMemory.exportTmx' => 'TMX 내보내기',
          'settings.translationMemory.exportCsv' => 'CSV 내보내기',
          'settings.translationMemory.clearMemory' => '메모리 지우기',
          'settings.translationMemory.importedItems' =>
            ({required Object count}) => '메모리에 ${count}개 항목을 가져왔습니다.',
          'settings.translationMemory.noItemsAdded' => '추가된 항목이 없습니다.',
          'settings.translationMemory.nothingToExport' => '아직 내보낼 내용이 없습니다.',
          'settings.translationMemory.tmxSaved' => 'TMX 저장됨',
          'settings.translationMemory.csvSaved' => 'CSV 저장됨',
          'settings.translationMemory.clearConfirmTitle' => '번역 메모리를 지우시겠습니까?',
          'settings.translationMemory.clearConfirmContent' =>
            '이 기기의 모든 저장된 번역 쌍이 제거됩니다. 이 작업은 취소할 수 없습니다.',
          'settings.translationMemory.cleared' => '번역 메모리가 지워졌습니다.',
          'settings.translationMemory.couldNotClear' => '메모리를 지울 수 없습니다.',
          'settings.backup.title' => '자동 백업',
          'settings.backup.description' => '자동 백업 설정',
          'settings.backup.enabled' => '자동 백업 활성화',
          'settings.backup.enabledDescription' => '변경하기 전에 파일을 자동으로 백업',
          'settings.backup.maxCopies' => '최대 백업 사본 수',
          'settings.backup.maxCopiesDescription' => '파일당 유지할 백업 사본 수',
          'settings.backup.activeStatus' => ({required Object count}) =>
              '활성 · ${count}개 사본 유지',
          'settings.backup.folder' => '백업 폴더',
          'settings.backup.folderDescription' => '동일한 폴더를 사용하려면 비워 두세요',
          'settings.backup.useOriginalFolder' => '원본 파일 폴더 사용',
          'settings.ai.title' => 'AI 서비스',
          'settings.ai.description' => 'AI 번역 및 지원 구성',
          'settings.ai.provider' => 'AI 제공자',
          'settings.ai.providerDescription' => '선호하는 AI 서비스 제공자를 선택하세요',
          'settings.ai.apiKey' => 'API 키',
          'settings.ai.apiKeyDescription' => '선택한 제공자의 API 키를 입력하세요',
          'settings.ai.apiKeyPlaceholder' => 'API 키 입력...',
          'settings.ai.testConnection' => '연결 테스트',
          'settings.ai.connectionSuccess' => '연결 성공!',
          'settings.ai.connectionFailed' => '연결 실패. API 키를 확인하세요.',
          'settings.ai.translationStrategy' => '번역 전략',
          'settings.ai.strategy' => '전략',
          'settings.ai.strategyDescription' => '문자열 번역 방법 선택',
          'settings.ai.strategyLLM' => '생성형 AI (LLM)',
          'settings.ai.strategyCloud' => '클라우드 번역',
          'settings.ai.enableAiTranslation' => 'AI 번역 활성화',
          'settings.ai.enableAiTranslationDescription' =>
            '앱이 번역 제안에 AI를 사용하도록 허용',
          'settings.ai.llmProvider' => 'LLM 서비스 제공자',
          'settings.ai.service' => '서비스',
          'settings.ai.serviceDescription' => '생성형 AI 제공자',
          'settings.ai.providerGemini' => 'Google Gemini',
          'settings.ai.providerOpenAI' => 'OpenAI',
          'settings.ai.geminiApiKey' => 'Gemini API 키',
          'settings.ai.openAiApiKey' => 'OpenAI API 키',
          'settings.ai.model' => '모델',
          'settings.ai.modelDescription' => '사용할 모델 선택',
          'settings.ai.advancedParameters' => '고급 매개변수',
          'settings.ai.parameters' => '매개변수',
          'settings.ai.parametersDescription' => '온도, 컨텍스트 및 기타',
          'settings.ai.temperature' => '온도',
          'settings.ai.temperatureDescription' => '값이 높을수록 출력이 더 창의적입니다',
          'settings.ai.maxTokens' => '최대 토큰',
          'settings.ai.maxTokensDescription' => '컨텍스트 창 길이 제한',
          'settings.ai.systemContext' => '시스템 컨텍스트 / 지침',
          'settings.ai.systemContextHint' =>
            '당신은 전문 로컬라이저입니다. 소스 문자열의 어조와 의도를 유지하세요...',
          'settings.ai.systemContextHelper' =>
            '프로젝트의 스타일과 용어에 대해 AI에게 구체적인 지침을 제공하세요.',
          'settings.ai.contextStrings' => '컨텍스트 문자열',
          'settings.ai.contextStringsDescription' => '더 나은 컨텍스트를 위해 주변 문자열 포함',
          'settings.ai.contextCount' => '컨텍스트 수',
          'settings.ai.contextCountDescription' => '포함할 주변 문자열 수',
          'settings.ai.cloudServices' => '클라우드 번역 서비스',
          'settings.ai.googleTranslateApiKey' => 'Google 번역 API 키',
          'settings.ai.deeplApiKey' => 'DeepL API 키',
          'settings.ai.test' => '테스트',
          'settings.ai.resetToGlobal' => '모든 AI 설정을 전역 기본값으로 초기화',
          'settings.integrations.platformNotice' => '플랫폼 알림',
          'settings.integrations.platformNoticeDescription' =>
            '시스템 통합은 이 플랫폼에서 사용할 수 없습니다.',
          'settings.integrations.visualEffects' => '시각 효과',
          'settings.integrations.explorerIntegration' => '탐색기 통합',
          'settings.integrations.explorerIntegrationDescription' =>
            '폴더의 Windows 탐색기 오른쪽 클릭 메뉴에 "Localizer로 열기"를 추가합니다.',
          'settings.integrations.addToContextMenu' => '컨텍스트 메뉴에 추가',
          'settings.integrations.contextMenuAdded' => '컨텍스트 메뉴가 추가되었습니다!',
          'settings.integrations.contextMenuAddError' => '컨텍스트 메뉴 추가 실패',
          'settings.integrations.contextMenuRemoved' => '컨텍스트 메뉴가 제거되었습니다!',
          'settings.integrations.contextMenuRemoveError' => '컨텍스트 메뉴 제거 실패',
          'settings.integrations.fileAssociations' => '파일 연결',
          'settings.integrations.fileAssociationsDescription' =>
            '탐색기에서 두 번 클릭할 때 Localizer로 열리도록 파일 형식을 등록합니다.',
          'settings.integrations.registered' => '등록됨',
          'settings.integrations.notRegistered' => '등록되지 않음',
          'settings.integrations.extRegistered' => ({required Object ext}) =>
              '${ext} 등록됨!',
          'settings.integrations.extUnregistered' => ({required Object ext}) =>
              '${ext} 등록 해제됨!',
          'settings.integrations.extError' => (
                  {required Object ext, required Object action}) =>
              '${ext} ${action} 실패',
          'settings.integrations.registerAll' => '모두 등록',
          'settings.integrations.unregisterAll' => '모두 등록 해제',
          'settings.integrations.registerAllResult' => (
                  {required Object total, required Object success}) =>
              '총 ${total}개 중 ${success}개 파일 형식 등록 완료',
          'settings.integrations.unregisterAllResult' => (
                  {required Object total, required Object success}) =>
              '총 ${total}개 중 ${success}개 파일 형식 등록 해제 완료',
          'settings.integrations.protocolHandler' => '프로토콜 핸들러',
          'settings.integrations.protocolHandlerDescription' =>
            '이 애플리케이션을 열기 위해 localizer:// URL을 등록합니다. 브라우저 링크나 다른 앱에서 프로젝트를 직접 열 수 있습니다.',
          'settings.integrations.protocolRegistered' => '프로토콜 핸들러가 등록됨',
          'settings.integrations.protocolNotRegistered' => '프로토콜 핸들러가 등록되지 않음',
          'settings.integrations.registerProtocol' => '프로토콜 등록',
          'settings.integrations.unregister' => '등록 해제',
          'settings.integrations.protocolRegisteredSuccess' => '프로토콜 핸들러 등록됨!',
          'settings.integrations.protocolRemovedSuccess' => '프로토콜 핸들러 제거됨!',
          'settings.integrations.protocolRegisterError' => '등록 실패',
          'settings.integrations.protocolRemoveError' => '제거 실패',
          'settings.integrations.windowMaterial' => '창 재질',
          'settings.integrations.windowMaterialDescription' =>
            'macOS vibrancy 재질 스타일 선택',
          'settings.integrations.dockIntegration' => 'Dock 통합',
          'settings.integrations.showDockBadge' => '미번역 수 표시',
          'settings.integrations.showDockBadgeDescription' =>
            'Dock 아이콘 배지에 미번역 문자열 수 표시',
          'settings.integrations.materials.sidebar' => '사이드바',
          'settings.integrations.materials.menu' => '메뉴',
          'settings.integrations.materials.popover' => '팝오버',
          'settings.integrations.materials.titlebar' => '제목 표시줄',
          'settings.integrations.materials.underPageBackground' => '페이지 배경',
          'settings.integrations.materials.contentBackground' => '콘텐츠',
          'settings.integrations.fileTypes.loc' => 'Localizer 프로젝트 파일',
          'settings.integrations.fileTypes.lang' => '언어 파일',
          'settings.integrations.fileTypes.json' => 'JSON 로컬라이제이션 파일',
          'settings.integrations.fileTypes.xml' => 'XML 로컬라이제이션 파일',
          'settings.developer.title' => '개발자 설정',
          'settings.developer.description' => '개발자를 위한 고급 설정',
          'settings.developer.showLocalizationKeys' => '로컬라이제이션 키 표시',
          'settings.developer.localizationKeysDescription' =>
            '활성화되면 모든 번역된 텍스트가 번역된 값 대신 로컬라이제이션 키를 표시합니다. 어떤 키가 어디에 사용되는지 확인하는 데 유용합니다.',
          'settings.developer.showPerformanceOverlay' => '성능 오버레이 표시',
          'settings.developer.performanceOverlayDescription' =>
            'FPS 및 프레임 타이밍 정보 표시',
          'settings.developer.debugMode' => '디버그 모드',
          'settings.developer.debugModeDescription' => '추가 로깅 및 디버그 기능 활성화',
          'settings.developer.debuggingTools' => '디버깅 도구',
          'settings.developer.semanticsDebugger' => '시맨틱 디버거',
          'settings.developer.semanticsDebuggerDescription' => '시맨틱 트리 시각화',
          'settings.developer.materialGrid' => '머티리얼 그리드',
          'settings.developer.materialGridDescription' => '머티리얼 레이아웃 그리드 오버레이',
          'settings.developer.rasterCache' => '래스터 캐시 이미지',
          'settings.developer.rasterCacheDescription' => '체커보드 래스터 캐시 이미지',
          'settings.developer.actions' => '작업',
          'settings.developer.showLogs' => '앱 로그 표시',
          'settings.developer.showLogsDescription' => 'Talker 디버그 콘솔 열기',
          'settings.developer.restartTutorial' => '온보딩 튜토리얼 다시 시작',
          'settings.developer.restartTutorialDescription' =>
            '플래그 초기화 및 튜토리얼 다시 실행',
          'settings.developer.restartRequested' => '튜토리얼 다시 시작 요청됨.',
          'settings.developer.throwException' => '테스트 예외 발생',
          'settings.developer.throwExceptionDescription' =>
            '충돌 보고를 위한 테스트 예외 트리거',
          'settings.developer.testExceptionMessage' => '개발자 옵션에서 테스트 예외 트리거됨',
          'settings.developer.clearTM' => '번역 메모리 지우기',
          'settings.developer.clearTMDescription' => '모든 캐시된 번역 삭제',
          'settings.developer.clearTMConfirmation' => '번역 메모리를 지우시겠습니까?',
          'settings.developer.clearTMWarning' =>
            '학습된 모든 번역이 삭제됩니다. 이 작업은 취소할 수 없습니다.',
          'settings.developer.tmCleared' => '번역 메모리 지워짐',
          'settings.developer.clearApiKeys' => 'API 키 지우기',
          'settings.developer.clearApiKeysDescription' => '모든 저장된 API 키 제거',
          'settings.developer.clearApiKeysConfirmation' => 'API 키를 지우시겠습니까?',
          'settings.developer.clearApiKeysWarning' =>
            '보안 저장소에서 모든 API 키가 제거됩니다.',
          'settings.developer.apiKeysCleared' => 'API 키 지워짐',
          'settings.developer.hideOptions' => '개발자 옵션 숨기기',
          'settings.developer.hideOptionsDescription' =>
            '개발자 모드 비활성화 (다시 활성화하려면 7번 탭)',
          'settings.developer.optionsDisabled' => '개발자 옵션 비활성화됨',
          'settings.developer.dangerZone' => '위험 구역',
          'settings.developer.factoryReset' => '공장 초기화',
          'settings.developer.factoryResetDescription' => '모든 설정 초기화 및 데이터 지우기',
          'settings.developer.factoryResetWarning' =>
            '모든 설정을 초기화하시겠습니까? 이 작업은 취소할 수 없습니다.',
          'settings.developer.inspectionTools' => '검사 도구',
          'settings.developer.searchHint' => '설정 검색...',
          'settings.developer.resetToDefault' => '기본값으로 재설정',
          'settings.developer.resetToGlobal' => '전역 기본값으로 재설정',
          'settings.developer.storageInspector' => '저장소 검사기',
          'settings.developer.storageInspectorDescription' =>
            'Hive 및 보안 저장소 내용 보기',
          'settings.developer.deviceEnvironment' => '기기 및 환경',
          'settings.developer.deviceEnvironmentDescription' =>
            '화면, 플랫폼 및 빌드 정보',
          'settings.developer.themePlayground' => '테마 플레이그라운드',
          'settings.developer.themePlaygroundDescription' => '색상 팔레트 및 타이포그래피',
          'settings.developer.themePlaygroundSection.colors' => '색상',
          'settings.developer.themePlaygroundSection.typography' => '타이포그래피',
          'settings.developer.themePlaygroundSection.palette.primary' =>
            'Primary',
          'settings.developer.themePlaygroundSection.palette.onPrimary' =>
            'On Primary',
          'settings.developer.themePlaygroundSection.palette.secondary' =>
            'Secondary',
          'settings.developer.themePlaygroundSection.palette.onSecondary' =>
            'On Secondary',
          'settings.developer.themePlaygroundSection.palette.surface' =>
            'Surface',
          'settings.developer.themePlaygroundSection.palette.onSurface' =>
            'On Surface',
          'settings.developer.themePlaygroundSection.palette.error' => 'Error',
          'settings.developer.themePlaygroundSection.palette.onError' =>
            'On Error',
          'settings.developer.themePlaygroundSection.palette.outline' =>
            'Outline',
          'settings.developer.themePlaygroundSection.palette.shadow' =>
            'Shadow',
          'settings.developer.themePlaygroundSection.palette.success' =>
            'Success',
          'settings.developer.themePlaygroundSection.palette.warning' =>
            'Warning',
          'settings.developer.themePlaygroundSection.palette.info' => 'Info',
          'settings.developer.localizationInspector' => '로컬라이제이션 검사기',
          'settings.developer.localizationInspectorDescription' => '번역 문자열 디버그',
          'settings.developer.hiveAppSettings' => 'Hive (앱 설정)',
          'settings.developer.secureStorageMasked' => '보안 저장소 (마스킹됨)',
          'settings.developer.featureFlags.title' => '실험적 기능',
          'settings.developer.featureFlags.description' =>
            '테스트를 위해 로컬에서 기능 플래그를 전환합니다. 이 재정의는 앱 재시작 후에도 유지됩니다.',
          'settings.developer.featureFlags.subtitle' => '실험적 기능 재정의',
          'settings.developer.featureFlags.flags.experimental_ai_batch.name' =>
            '실험적 AI 배치',
          'settings.developer.featureFlags.flags.experimental_ai_batch.description' =>
            '여러 행에 대한 배치 AI 번역 활성화',
          'settings.developer.featureFlags.flags.new_diff_algorithm.name' =>
            '새로운 Diff 알고리즘',
          'settings.developer.featureFlags.flags.new_diff_algorithm.description' =>
            '비교를 위해 개선된 diff 알고리즘 사용',
          'settings.developer.featureFlags.flags.enhanced_search.name' =>
            '향상된 검색',
          'settings.developer.featureFlags.flags.enhanced_search.description' =>
            '번역 파일에서 퍼지 검색 활성화',
          'settings.developer.featureFlags.flags.auto_save.name' => '자동 저장',
          'settings.developer.featureFlags.flags.auto_save.description' =>
            '편집 후 변경 사항 자동 저장',
          'settings.developer.featureFlags.reset' => '모든 플래그 재설정',
          'settings.developer.featureFlags.overrides' => '로컬 재정의',
          'settings.developer.featureFlags.defaultVal' => '기본값',
          'settings.developer.featureFlags.on' => '켜짐',
          'settings.developer.featureFlags.off' => '꺼짐',
          'settings.developer.storageInspectorSection.refresh' => '새로 고침',
          'settings.developer.storageInspectorSection.hiveData' => 'Hive 데이터',
          'settings.developer.storageInspectorSection.secureStorage' =>
            '보안 저장소',
          'settings.developer.deviceInfoSection.refresh' => '새로 고침',
          'settings.developer.deviceInfoSection.copy' => '클립보드에 복사',
          'settings.developer.deviceInfoSection.computerName' => '컴퓨터 이름',
          'settings.developer.deviceInfoSection.osVersion' => 'OS 버전',
          'settings.developer.localizationInspectorSection.showKeys' =>
            '값 대신 키 표시',
          'settings.developer.localizationInspectorSection.keysVisible' =>
            '키 표시 중',
          'settings.developer.localizationInspectorSection.normalDisplay' =>
            '정상 표시',
          'settings.developer.localizationInspectorSection.note' =>
            '참고: 이 기능을 사용하려면 앱 로컬라이제이션이 이 설정을 준수하는 래퍼를 사용해야 합니다.',
          'settings.about.title' => '정보',
          'settings.about.version' => '버전',
          'settings.about.buildNumber' => '빌드 번호',
          'settings.about.author' => '작성자',
          _ => null,
        } ??
        switch (path) {
          'settings.about.license' => '라이선스',
          'settings.about.sourceCode' => '소스 코드',
          'settings.about.reportBug' => '버그 보고',
          'settings.about.requestFeature' => '기능 요청',
          'settings.about.checkForUpdates' => '업데이트 확인',
          'settings.about.upToDate' => '최신 상태입니다!',
          'settings.about.updateAvailable' => ({required Object version}) =>
              '업데이트 가능: ${version}',
          'settings.about.updateAvailableBadge' => '업데이트 가능!',
          'settings.about.developerSteps' => ({required Object count}) =>
              '개발자가 되기까지 ${count}단계 남았습니다.',
          'settings.about.developerActivated' => '이제 개발자입니다!',
          'settings.about.neverChecked' => '없음',
          'settings.about.applicationInfo' => '애플리케이션 정보',
          'settings.about.platform' => '플랫폼',
          'settings.about.updateInformation' => '업데이트 정보',
          'settings.about.currentVersion' => '현재 버전',
          'settings.about.latestVersion' => '최신 버전',
          'settings.about.lastChecked' => '마지막 확인',
          'settings.about.checkingForUpdates' => '확인 중...',
          'settings.about.whatsNew' => '새로운 기능',
          'settings.about.systemInformation' => '시스템 정보',
          'settings.about.dartVersion' => 'Dart 버전',
          'settings.about.diskSpace' => '사용 가능한 디스크 공간',
          'settings.about.memoryUsage' => '메모리 사용량',
          'settings.about.privacyTitle' => '개인정보 및 텔레메트리',
          'settings.about.usageStats' => '익명 사용 통계',
          'settings.about.requiresFirebase' => 'Firebase 구성 필요',
          'settings.about.featureUnavailable' =>
            '기능을 현재 사용할 수 없음 (Firebase 필요)',
          'settings.about.settingsManagement' => '설정 관리',
          'settings.about.settingsManagementDescription' =>
            '설정을 파일로 내보내 백업하거나 다른 머신과 공유하세요.',
          'settings.about.resetAll' => '모두 초기화',
          'settings.about.links' => '링크',
          'settings.about.githubRepo' => 'GitHub 저장소',
          'settings.about.privacyPolicy' => '개인정보 처리방침',
          'settings.about.crashReporting' => '충돌 보고',
          'settings.onboarding.skipTutorial' => '튜토리얼 건너뛰기',
          'settings.onboarding.gettingStarted' => '시작하기',
          'settings.onboarding.stepProgress' => (
                  {required Object total, required Object current}) =>
              '${total} 중 ${current}',
          'settings.onboarding.loadSampleData' => '샘플 데이터 로드',
          'settings.onboarding.steps.importFiles.title' => '파일 가져오기',
          'settings.onboarding.steps.importFiles.description' =>
            '소스 및 타겟 파일 로드',
          'settings.onboarding.steps.runComparison.title' => '비교 실행',
          'settings.onboarding.steps.runComparison.description' => '"파일 비교" 클릭',
          'settings.onboarding.steps.reviewMissing.title' => '누락된 키 검토',
          'settings.onboarding.steps.reviewMissing.description' =>
            '빨간색 누락(MISSING) 항목 확인',
          'settings.onboarding.steps.useFilters.title' => '필터 사용',
          'settings.onboarding.steps.useFilters.description' => '유형별 필터링',
          'settings.onboarding.steps.searchResults.title' => '검색 결과',
          'settings.onboarding.steps.searchResults.description' => '특정 키 찾기',
          'settings.onboarding.steps.advancedView.title' => '고급 보기',
          'settings.onboarding.steps.advancedView.description' => '상세 분석 탐색',
          'settings.onboarding.steps.editCell.title' => '셀 편집',
          'settings.onboarding.steps.editCell.description' => '값을 클릭하여 편집',
          'settings.onboarding.steps.exportResults.title' => '내보내기',
          'settings.onboarding.steps.exportResults.description' => '보고서 저장',
          'settings.settingsView.resetCategoryTitle' =>
            ({required Object category}) => '${category} 초기화?',
          'settings.settingsView.resetCategoryContent' =>
            '이 카테고리의 모든 설정이 기본값으로 초기화됩니다.',
          'settings.settingsView.resetAllTitle' => '모든 설정 초기화?',
          'settings.settingsView.resetAllContent' =>
            '모든 설정이 영구적으로 공장 기본값으로 초기화됩니다. 이 작업은 취소할 수 없습니다.',
          'settings.settingsView.resetAll' => '모두 초기화',
          'settings.settingsView.resetSuccess' =>
            ({required Object category}) => '${category} 기본값으로 초기화됨',
          'settings.settingsView.errorLoading' => '설정 로드 오류',
          'settings.settingsView.settingsSaved' => '설정 저장됨',
          'settings.settingsView.updateAvailable' =>
            ({required Object version}) => '업데이트 가능: v${version}',
          'settings.settingsView.latestVersion' => '최신 버전을 사용 중입니다',
          'settings.settingsView.whatsNew' => ({required Object version}) =>
              'v${version}의 새로운 기능',
          'settings.settingsView.downloadUpdate' => '업데이트 다운로드',
          'settings.settingsView.exportSettings' => '설정 내보내기',
          'settings.settingsView.settingsExported' => '설정 내보내짐',
          'settings.settingsView.exportFail' => ({required Object error}) =>
              '설정 내보내기 실패: ${error}',
          'settings.settingsView.importSettings' => '설정 가져오기',
          'settings.settingsView.importTitle' => '설정 가져오기?',
          'settings.settingsView.importContent' =>
            '현재 모든 설정이 가져온 설정으로 대체됩니다. 이 작업은 취소할 수 없습니다.',
          'settings.settingsView.importSuccess' => '설정을 성공적으로 가져왔습니다!',
          'settings.settingsView.importFail' => ({required Object error}) =>
              '설정 가져오기 실패: ${error}',
          'settings.settingsView.invalidFormat' => '잘못된 설정 파일 형식',
          'settings.settingsView.categories.general' => '일반 설정',
          'settings.settingsView.categories.comparisonEngine' => '비교 엔진',
          'settings.settingsView.categories.appearance' => '화면 표시',
          'settings.settingsView.categories.fileHandling' => '파일 처리',
          'settings.settingsView.categories.aiServices' => 'AI 서비스',
          'settings.settingsView.categories.systemIntegrations' => '시스템 통합',
          'settings.settingsView.categories.projectResources' =>
            '프로젝트 리소스 (용어집 & TM)',
          'settings.settingsView.categories.developer' => '개발자 옵션',
          'settings.settingsView.categories.about' => '정보',
          'settings.settingsView.categoryLabels.general' => '일반',
          'settings.settingsView.categoryLabels.comparisonEngine' => '비교',
          'settings.settingsView.categoryLabels.appearance' => '화면 표시',
          'settings.settingsView.categoryLabels.fileHandling' => '파일 처리',
          'settings.settingsView.categoryLabels.aiServices' => 'AI 서비스',
          'settings.settingsView.categoryLabels.systemIntegrations' => '시스템 통합',
          'settings.settingsView.categoryLabels.projectResources' => '프로젝트 리소스',
          'settings.settingsView.categoryLabels.developer' => '개발자 옵션',
          'settings.settingsView.categoryLabels.about' => '정보',
          'fileComparison.title' => '파일 비교',
          'fileComparison.openFiles' => '파일 열기',
          'fileComparison.exportResults' => '결과 내보내기',
          'fileComparison.restartTutorial' => '자습서 다시 시작',
          'fileComparison.restartTutorialDevOnly' =>
            '자습서 다시 시작은 개발자 모드에서만 사용할 수 있습니다.',
          'fileComparison.unsupportedFileType' => '지원되지 않는 파일 형식입니다.',
          'fileComparison.unsupportedFileTypeSuggestion' =>
            '지원되는 로컬라이제이션 파일을 선택하세요.',
          'fileComparison.someFilesUnsupported' => '일부 파일은 지원되지 않습니다.',
          'fileComparison.pickSupportedFiles' => '지원되는 로컬라이제이션 파일만 선택하세요.',
          'fileComparison.pickTwoFiles' => '비교할 두 파일을 선택하세요.',
          'fileComparison.pickBilingualFile' => '비교할 이중 언어 파일을 선택하세요.',
          'fileComparison.noResultsToExport' => '아직 내보낼 결과가 없습니다.',
          'fileComparison.performComparisonFirst' => '결과를 내보내려면 먼저 비교를 수행하세요.',
          'fileComparison.performComparisonFirstEditor' =>
            '고급 세부 정보를 보려면 먼저 비교를 수행하세요.',
          'fileComparison.sampleDataLoaded' => '샘플 데이터가 성공적으로 로드되었습니다',
          'fileComparison.loadSampleDataError' => ({required Object error}) =>
              '샘플 데이터 로드 실패: ${error}',
          'fileComparison.invalidFileType' => '잘못된 파일 형식입니다.',
          'fileComparison.fileSelected' => (
                  {required Object label, required Object fileName}) =>
              '${label} 선택됨: ${fileName}',
          'fileComparison.sourceFile' => '소스 파일',
          'fileComparison.targetFile' => '타겟 파일',
          'fileComparison.bilingualFile' => '이중 언어 파일',
          'fileComparison.compareFiles' => '파일 비교',
          'fileComparison.compareFile' => '파일 비교',
          'fileComparison.bilingualMode' => '이중 언어 모드',
          'fileComparison.twoFilesMode' => '두 파일',
          'fileComparison.processing' => '처리 중...',
          'fileComparison.remaining' => ({required Object time}) =>
              '${time} 남음',
          'fileComparison.comparisonInProgress' => '비교 진행 중...',
          'fileComparison.comparisonFailed' => ({required Object error}) =>
              '비교 실패: ${error}',
          'fileComparison.fileChanged' => ({required Object fileName}) =>
              '파일 변경됨: ${fileName}. 다시 비교 중...',
          'fileComparison.dropFileHere' => '여기에 파일 놓기',
          'fileComparison.dropFileOrBrowse' => '파일을 놓거나 클릭하여 찾아보기',
          'fileComparison.fileUpload' => '파일 업로드',
          'fileComparison.changeFile' => '파일 변경',
          'fileComparison.total' => '합계',
          'fileComparison.show' => '표시',
          'fileComparison.showAll' => '모두 표시',
          'fileComparison.noMatches' => ({required Object query}) =>
              '"${query}"에 대한 일치 항목 없음',
          'fileComparison.showingEntries' => (
                  {required Object total, required Object count}) =>
              '${total}개 중 ${count}개 항목 표시 중',
          'fileComparison.filesIdentical' => '파일이 동일합니다.',
          'fileComparison.hiddenIdentical' => ({required Object count}) =>
              '${count}개 동일한 항목 숨겨짐',
          'fileComparison.showIdentical' => '동일한 항목 표시',
          'fileComparison.hideIdentical' => '동일한 항목 숨기기',
          'fileComparison.noDiff' => '키를 기반으로 한 차이점이 없습니다.',
          'fileComparison.source' => '소스',
          'fileComparison.target' => '타겟',
          'fileComparison.value' => '값',
          'fileComparison.readyToCompare' => '파일 비교 준비 완료',
          'fileComparison.readyToCompareDesc' =>
            '위에 로컬라이제이션 파일을 놓거나 찾아보기 버튼을 사용하여\n비교할 파일을 선택하세요.',
          'fileComparison.recentComparisons' => '최근 비교',
          'fileComparison.bilingualFileLabel' => ({required Object name}) =>
              '이중 언어 파일: ${name}',
          'fileComparison.comparisonLabel' => (
                  {required Object source, required Object target}) =>
              '${source} ↔ ${target}',
          'fileComparison.fileNotExist' =>
            '이 세션의 파일 중 하나 또는 둘 다 더 이상 존재하지 않습니다.',
          'fileComparison.largeFileTitle' => '대용량 파일 감지됨',
          'fileComparison.largeFileContent' => ({required Object count}) =>
              '비교 결과에 ${count}개 항목이 포함되어 있습니다.\n모두 표시하면 성능 문제가 발생할 수 있습니다.\n\n계속하시겠습니까?',
          'fileComparison.dontShowAgain' => '이 파일에 대해 다시 표시 안 함',
          'fileComparison.proceed' => '계속',
          'fileComparison.exportReport' => ({required Object format}) =>
              '${format} 보고서 저장',
          'fileComparison.saved' => ({required Object format}) =>
              '${format} 저장됨',
          'fileComparison.saveError' => ({required Object format}) =>
              '${format} 파일 저장 실패.',
          'fileComparison.saveErrorDetailed' => (
                  {required Object format, required Object error}) =>
              '${format} 저장 실패: ${error}',
          'fileComparison.watching' => '감시 중',
          'fileComparison.watchOff' => '감시 끄기',
          'fileComparison.watchingTooltip' => ({required Object status}) =>
              '파일 감시: ${status}\n디스크에서 파일 변경 시 자동으로 다시 비교',
          'fileComparison.aiSettingsNotAvailable' => 'AI 설정으로 이동할 수 없음',
          'directoryComparison.title' => '디렉토리 비교',
          'directoryComparison.sourceDirectory' => '소스 디렉토리',
          'directoryComparison.targetDirectory' => '타겟 디렉토리',
          'directoryComparison.sourceSubtitle' => '원본/참조 파일',
          'directoryComparison.targetSubtitle' => '번역/비교 파일',
          'directoryComparison.selectBothDirectories' =>
            '소스 및 타겟 디렉토리를 모두 선택하세요.',
          'directoryComparison.selectSourceFolder' => '소스 폴더 선택',
          'directoryComparison.selectTargetFolder' => '타겟 폴더 선택',
          'directoryComparison.dropFolderHere' => '여기에 폴더를 놓거나 찾아보기...',
          'directoryComparison.folderPath' => '폴더 경로',
          'directoryComparison.readyToCompare' => '디렉토리 비교 준비 완료',
          'directoryComparison.readyToCompareDesc' =>
            '위에 폴더를 놓거나 찾아보기 버튼을 사용하여\n비교할 디렉토리를 선택하세요.',
          'directoryComparison.nestedFolders' => '중첩 폴더',
          'directoryComparison.nestedFoldersTooltip' =>
            '모든 중첩 디렉토리를 재귀적으로 비교합니다',
          'directoryComparison.fileMatching' => '파일 일치',
          'directoryComparison.fileMatchingTooltip' =>
            '이름별로 파일을 자동으로 쌍으로 연결합니다',
          'directoryComparison.bulkExport' => '일괄 내보내기',
          'directoryComparison.bulkExportTooltip' => '모든 비교 결과를 한 번에 내보냅니다',
          'directoryComparison.notDirectoryComparison' => '디렉토리 비교가 아닙니다.',
          'directoryComparison.directoriesNotExist' =>
            '하나 또는 두 디렉토리가 더 이상 존재하지 않습니다.',
          'directoryComparison.errorOccurred' => '오류 발생',
          'directoryComparison.noFilesFound' => '선택한 디렉토리에서 파일을 찾을 수 없습니다.',
          'directoryComparison.unmatchedSourceFiles' => '일치하지 않는 소스 파일',
          'directoryComparison.unmatchedTargetFiles' => '일치하지 않는 타겟 파일',
          'directoryComparison.filePairs' => ({required Object count}) =>
              '${count}개 파일 쌍',
          'directoryComparison.pairedFiles' => ({required Object count}) =>
              '쌍으로 연결된 파일 (${count})',
          'directoryComparison.view' => '보기',
          'directoryComparison.failed' => '실패',
          'directoryComparison.pair' => '연결...',
          'directoryComparison.pairDialogTitle' => ({required Object name}) =>
              '"${name}" 연결 대상:',
          'directoryComparison.discoverFiles' => '파일 검색',
          'directoryComparison.compareAll' => '모두 비교',
          'directoryComparison.exportAll' => '모두 내보내기',
          'directoryComparison.comparisonStarted' => '비교 시작됨...',
          'directoryComparison.discoveringFiles' => '파일 검색 중...',
          'directoryComparison.noResultsToExport' =>
            '내보낼 비교 결과가 없습니다. 먼저 "모두 비교"를 실행하세요.',
          'directoryComparison.selectExportFolder' => '내보내기 폴더 선택',
          'directoryComparison.createExportFolderError' =>
            ({required Object error}) => '내보내기 폴더 생성 실패: ${error}',
          'directoryComparison.exportingResults' => '결과 내보내는 중',
          'directoryComparison.processingFile' => ({required Object file}) =>
              '처리 중: ${file}',
          'directoryComparison.exportProgress' => (
                  {required Object total, required Object current}) =>
              '${total}개 중 ${current}개 파일 내보냄',
          'directoryComparison.exportComplete' => '내보내기 완료',
          'directoryComparison.exportSuccessMessage' => (
                  {required Object count}) =>
              '요약과 함께 ${count}개 비교 파일을 성공적으로 내보냈습니다.',
          'directoryComparison.exportFailed' => ({required Object error}) =>
              '내보내기 실패: ${error}',
          'directoryComparison.close' => '닫기',
          'gitComparison._translatorNote' =>
            'Git 용어(Branch, Commit, Checkout, Merge, Conflict, Pull, Push)는 개발자들 사이의 혼란을 피하기 위해 모든 번역에서 영어로 유지해야 합니다.',
          'gitComparison.title' => '저장소 비교',
          'gitComparison.repoSelector' => '저장소 생성 / 열기',
          'gitComparison.noRepoSelected' => '선택된 저장소 없음',
          'gitComparison.open' => '열기',
          'gitComparison.refreshCommits' => '커밋 새로 고침',
          'gitComparison.noCommits' =>
            '커밋을 찾거나 로드할 수 없습니다. 커밋을 로드하려면 브랜치를 선택하세요.',
          'gitComparison.baseCommit' => '베이스 커밋 (이전)',
          'gitComparison.targetCommit' => '타겟 커밋 (최신)',
          'gitComparison.filterCommitsByBranch' => '브랜치별 커밋 필터링',
          'gitComparison.conflictDetection' => '충돌 감지',
          'gitComparison.conflictDetectionTooltip' => '병합 충돌 감지 및 해결',
          'gitComparison.actions' => '작업:',
          'gitComparison.checkout' => 'Checkout',
          'gitComparison.merge' => 'Merge',
          'gitComparison.pull' => 'Pull',
          'gitComparison.checkoutBranch' => 'Branch Checkout',
          'gitComparison.mergeBranch' => '현재 Branch로 Merge',
          'gitComparison.mergeConfirmation' => ({required Object branch}) =>
              '${branch}를 병합하시겠습니까?',
          'gitComparison.mergeWarning' =>
            '현재 작업 브랜치에 변경 사항이 병합됩니다. 충돌이 발생할 수 있습니다.',
          'gitComparison.selectExportFolder' => '내보내기 폴더 선택',
          'gitComparison.createExportFolderError' =>
            ({required Object error}) => '내보내기 폴더 생성 실패: ${error}',
          'gitComparison.exportingFiles' => '파일 내보내는 중',
          'gitComparison.processingFile' => ({required Object file}) =>
              '처리 중: ${file}',
          'gitComparison.exportProgress' => (
                  {required Object total, required Object current}) =>
              '${total}개 중 ${current}개 파일 내보냄',
          'gitComparison.exportComplete' => '내보내기 완료',
          'gitComparison.exportSuccessMessage' => ({required Object count}) =>
              '전체 내용이 포함된 ${count}개 파일을 성공적으로 내보냈습니다.',
          'gitComparison.exportDetail' => '각 파일의 diff는 "files" 하위 폴더에 저장됩니다.',
          'gitComparison.diffViewer' => 'Diff 뷰어',
          'gitComparison.base' => '베이스',
          'gitComparison.target' => '타겟',
          'gitComparison.noLines' => '표시할 줄 없음',
          'gitComparison.searchFiles' => '파일 검색...',
          'gitComparison.noFilesMatch' => ({required Object query}) =>
              '"${query}"와 일치하는 파일 없음',
          'gitComparison.filesCount' => ({required Object count}) =>
              '${count}개 파일',
          'gitComparison.selectBaseFile' => '베이스 파일 선택',
          'gitComparison.selectTargetFile' => '타겟 파일 선택',
          'gitComparison.comparisonResults' => '비교 결과',
          'gitComparison.noChanges' => '선택한 참조 간에 변경 사항이 없습니다.',
          'gitComparison.linesAdded' => '추가된 줄',
          'gitComparison.linesRemoved' => '제거된 줄',
          'gitComparison.commit' => 'Commit',
          'gitComparison.branch' => 'Branch',
          'gitComparison.noRepositorySelected' => '선택된 저장소 없음',
          'gitComparison.notGitComparison' => 'Git 비교가 아님',
          'gitComparison.repositoryNotExist' => '저장소가 존재하지 않음',
          'gitComparison.mainBranch' => 'main',
          'gitComparison.masterBranch' => 'master',
          'gitComparison.backToControls' => '비교 컨트롤로 돌아가기',
          'advancedComparison.placeholder' => '고급 비교 보기 - 자리 표시자',
          'advancedDiff.saveAllChanges' => '모든 변경 사항 저장?',
          'advancedDiff.saveConfirmation' => ({required Object count}) =>
              '대상 파일에 ${count}개 수정된 항목이 저장됩니다. 이 작업은 취소할 수 없습니다.',
          'advancedDiff.changesSaved' => '변경 사항이 성공적으로 저장되었습니다.',
          'advancedDiff.csvExported' => 'CSV 내보내짐',
          'advancedDiff.unsavedChanges' => '저장되지 않은 변경 사항',
          'advancedDiff.unsavedChangesWarning' =>
            '저장되지 않은 변경 사항이 있습니다. 정말로 취소하시겠습니까?',
          'advancedDiff.discardChanges' => '변경 사항 취소',
          'advancedDiff.goBack' => '뒤로 가기',
          'advancedDiff.breadcrumbs' => '홈 > 편집기',
          'advancedDiff.unsaved' => ({required Object count}) =>
              '${count}개 저장 안 됨',
          'advancedDiff.reviewed' => ({required Object count}) =>
              '${count}개 검토됨',
          'advancedDiff.saveAll' => ({required Object count}) =>
              '모두 저장 (${count})',
          'advancedDiff.allSaved' => '모두 저장됨',
          'advancedDiff.saveAllTooltip' => '모든 변경 사항 저장 (Ctrl+S)',
          'advancedDiff.exportTooltip' => '데이터 내보내기 (Ctrl+E)',
          'advancedDiff.aiSuggestion.aiTranslation' => 'AI 번역',
          'advancedDiff.aiSuggestion.aiRephrase' => 'AI 문구 수정',
          'advancedDiff.aiSuggestion.key' => ({required Object key}) =>
              '키: ${key}',
          'advancedDiff.aiSuggestion.original' => '원본:',
          'advancedDiff.aiSuggestion.suggestion' => '제안:',
          'advancedDiff.aiSuggestion.confidence' => 'AI 신뢰도',
          'advancedDiff.aiSuggestion.cancelEdit' => '편집 취소',
          'advancedDiff.aiSuggestion.editSuggestion' => '제안 편집',
          'advancedDiff.aiSuggestion.alternatives' => '대안:',
          'advancedDiff.aiSuggestion.accept' => '수락',
          'advancedDiff.aiSuggestion.reject' => '거절',
          'advancedDiff.aiSuggestion.stop' => '중지',
          'advancedDiff.detailEdit.title' => ({required Object key}) =>
              '편집: ${key}',
          'advancedDiff.detailEdit.sourceLabel' => '소스 (원본)',
          'advancedDiff.detailEdit.targetLabel' => '타겟 (번역)',
          'advancedDiff.detailEdit.translateWithCloud' => '클라우드로 번역',
          'advancedDiff.detailEdit.translateWithAi' => 'AI로 번역',
          'advancedDiff.detailEdit.translating' => '번역 중...',
          'advancedDiff.detailEdit.applyAndTm' => '적용',
          'advancedDiff.detailEdit.entryApplied' => '항목 적용됨 & TM에 추가됨',
          'advancedDiff.detailEdit.translationAdded' => '번역 제안이 추가되었습니다.',
          'advancedDiff.detailEdit.aiSuggestionAdded' => 'AI 제안이 추가되었습니다.',
          'advancedDiff.table.addedToTM' => '번역 메모리에 추가됨',
          'advancedDiff.table.markedReviewed' => '검토 완료로 표시됨 ✓',
          'advancedDiff.table.unmarkedReview' => '검토 표시 해제됨',
          'advancedDiff.table.reverted' => '소스 값으로 되돌림',
          'advancedDiff.table.entryDeleted' => '항목 삭제됨',
          'advancedDiff.table.noSourceText' => '번역할 소스 텍스트가 없습니다.',
          'advancedDiff.table.aiTranslationFailed' => ({required Object key}) =>
              '"${key}"에 대한 AI 번역 실패',
          'advancedDiff.table.noTargetText' => '문구를 수정할 타겟 텍스트가 없습니다.',
          'advancedDiff.table.aiRephraseFailed' => ({required Object key}) =>
              '"${key}"에 대한 AI 문구 수정 실패',
          'advancedDiff.table.checkRowsFirst' => '먼저 체크박스를 사용하여 행을 선택하세요',
          'advancedDiff.table.markedRowsReviewed' =>
            ({required Object count}) => '${count}개 행을 검토 완료로 표시했습니다',
          'advancedDiff.table.revertedRows' => ({required Object count}) =>
              '${count}개 행을 되돌렸습니다',
          'advancedDiff.table.entriesCount' => ({required Object count}) =>
              '${count}개 항목',
          'advancedDiff.table.markSelectedReviewed' => '선택 항목 검토 완료로 표시',
          'advancedDiff.table.revertSelected' => '선택 항목 되돌리기',
          'advancedDiff.table.noDifferences' => '차이점이 없습니다',
          'advancedDiff.table.adjustFilters' => '필터를 조정해 보세요',
          'advancedDiff.table.cloudTranslationApplied' => '클라우드 번역이 적용되었습니다.',
          'advancedDiff.table.aiTranslationApplied' => 'AI 번역이 적용되었습니다.',
          'advancedDiff.table.suggestionApplied' => '제안이 적용되었습니다.',
          'advancedDiff.table.aiSuggestionApplied' => 'AI 제안이 적용되었습니다.',
          'advancedDiff.table.rephraseApplied' => '문구 수정이 적용되었습니다.',
          'advancedDiff.table.aiRephraseApplied' => 'AI 문구 수정이 적용되었습니다.',
          'advancedDiff.table.rephrase' => '문구 수정',
          'advancedDiff.table.aiRephrase' => 'AI 문구 수정',
          'advancedDiff.table.targetClickToEdit' => '타겟 (편집하려면 클릭)',
          'advancedDiff.table.targetClickForDialog' => '타겟 (대화 상자 열기)',
          'advancedDiff.table.emptyClickToEdit' => '(비어 있음 - 편집하려면 클릭)',
          'advancedDiff.table.unmarkReviewed' => '검토 표시 해제',
          'advancedDiff.table.markReviewed' => '검토 완료로 표시',
          'advancedDiff.table.revertToSource' => '소스로 되돌리기',
          'advancedDiff.table.translateWithCloud' => '클라우드로 번역',
          'advancedDiff.table.translateWithAi' => 'AI로 번역',
          'advancedDiff.table.rephraseWithAi' => 'AI로 문구 수정',
          'advancedDiff.table.moreActions' => '추가 작업',
          'advancedDiff.table.editDetails' => '세부 정보 편집',
          'advancedDiff.table.suggestTranslation' => '번역 제안',
          'advancedDiff.table.addToTm' => 'TM에 추가',
          'advancedDiff.table.deleteEntry' => '항목 삭제',
          'advancedDiff.diffRow.copySource' => '소스 텍스트 복사',
          'advancedDiff.diffRow.actions' => '작업',
          'advancedDiff.status.added' => '추가됨',
          'advancedDiff.status.missing' => '누락됨',
          'advancedDiff.status.changed' => ({required Object percent}) =>
              '변경됨 ${percent}%',
          'advancedDiff.status.same' => '동일함',
          'advancedDiff.sidebar.widgets' => '위젯',
          'advancedDiff.sidebar.searchPlaceholder' => '키 & 값 검색... (Ctrl+F)',
          'advancedDiff.sidebar.fuzzySearchTooltip' => '퍼지 검색 (오타 허용)',
          'advancedDiff.sidebar.regexSearchTooltip' => '정규식 검색',
          'advancedDiff.sidebar.cloudTranslation' => '클라우드 번역',
          'advancedDiff.sidebar.aiTranslation' => 'AI 번역',
          'advancedDiff.sidebar.status' => '상태',
          'advancedDiff.sidebar.tm' => '번역 메모리',
          'advancedDiff.sidebar.filters' => '필터',
          'advancedDiff.sidebar.actions' => '작업',
          'advancedDiff.sidebar.similarity' => '유사도',
          'advancedDiff.sidebar.actionsSection.exportMatches' => '일치 항목 내보내기',
          'advancedDiff.sidebar.actionsSection.preview' => '미리보기',
          'advancedDiff.sidebar.actionsSection.fillFromTmTitle' =>
            '번역 메모리에서 채우기?',
          'advancedDiff.sidebar.actionsSection.fillFromTmContent' =>
            '빈 타겟 값을 번역 메모리의 일치 항목으로 채우려고 시도합니다. 기존 값은 덮어쓰지 않습니다.',
          'advancedDiff.sidebar.actionsSection.fill' => '채우기',
          'advancedDiff.sidebar.actionsSection.fillFromMemory' => '메모리에서 채우기',
          'advancedDiff.sidebar.actionsSection.filledFromTm' =>
            ({required Object count}) => '번역 메모리에서 ${count}개 항목을 채웠습니다.',
          'advancedDiff.sidebar.aiSection.infoCloud' =>
            '클라우드 번역을 사용하여 소스에서 빈 타겟 값을 번역합니다.',
          'advancedDiff.sidebar.aiSection.infoAi' =>
            'AI를 사용하여 소스에서 빈 타겟 값을 번역합니다.',
          'advancedDiff.sidebar.aiSection.translationSettings' => '번역 설정',
          'advancedDiff.sidebar.aiSection.aiSettings' => 'AI 설정',
          'advancedDiff.sidebar.aiSection.source' => '소스',
          'advancedDiff.sidebar.aiSection.target' => '타겟',
          'advancedDiff.sidebar.aiSection.translatingProgress' =>
            ({required Object percent}) => '번역 중... ${percent}%',
          'advancedDiff.sidebar.aiSection.translating' => '번역 중...',
          'advancedDiff.sidebar.aiSection.translateAllMissing' =>
            '누락된 항목 모두 번역',
          'advancedDiff.sidebar.aiSection.translateAllTitle' => '누락된 항목 모두 번역?',
          'advancedDiff.sidebar.aiSection.translateAllContent' => (
                  {required Object service,
                  required Object source,
                  required Object target}) =>
              '${service}을(를) 사용하여 빈 타겟 값이 있는 모든 항목을 ${source}에서 ${target}(으)로 번역합니다.\n\n각 제안을 검토하거나 한 번에 모두 적용할 수 있습니다.',
          'advancedDiff.sidebar.aiSection.translateAll' => '모두 번역',
          'advancedDiff.sidebar.aiSection.reviewEach' => '개별 검토',
          'advancedDiff.sidebar.aiSection.cloudTranslated' =>
            ({required Object count}) => '클라우드 번역으로 ${count}개 항목을 번역했습니다.',
          'advancedDiff.sidebar.aiSection.aiTranslated' =>
            ({required Object count}) => 'AI로 ${count}개 항목을 번역했습니다.',
          'advancedDiff.sidebar.aiSection.aiTranslateFailed' => 'AI 모두 번역 실패',
          'advancedDiff.sidebar.aiSection.noMissingEntries' =>
            '번역할 누락된 항목이 없습니다.',
          'advancedDiff.sidebar.aiSection.skip' => '건너뛰기',
          'advancedDiff.sidebar.aiSection.stop' => '중지',
          'advancedDiff.sidebar.aiSection.cloudApplied' =>
            ({required Object count}) => '${count}개 제안 적용됨.',
          'advancedDiff.sidebar.aiSection.aiApplied' =>
            ({required Object count}) => '${count}개 AI 제안 적용됨.',
          'advancedDiff.sidebar.tmSection.enableTmFill' => 'TM 채우기 활성화',
          'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' =>
            '최소값 이상 자동 적용',
          'advancedDiff.sidebar.tmSection.matchSettings' => '일치 설정',
          'advancedDiff.sidebar.tmSection.minMatch' => '최소 일치:',
          'advancedDiff.sidebar.tmSection.limit' => '제한:',
          'advancedDiff.sidebar.tmSection.exact' => '정확함',
          'advancedDiff.sidebar.filtersSection.viewFilters' => '보기 필터',
          'advancedDiff.sidebar.filtersSection.showAll' => '모두 표시',
          'advancedDiff.sidebar.filtersSection.added' => '추가됨',
          'advancedDiff.sidebar.filtersSection.removed' => '제거됨',
          'advancedDiff.sidebar.filtersSection.modified' => '수정됨',
          'advancedDiff.sidebar.filtersSection.actionScope' => '작업 범위',
          'advancedDiff.sidebar.filtersSection.applyToAdded' => '추가된 항목에 적용',
          'advancedDiff.sidebar.filtersSection.applyToModified' => '수정된 항목에 적용',
          'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' =>
            '빈 타겟만 채우기',
          'advancedDiff.sidebar.filtersSection.limitToVisible' => '표시된 항목으로 제한',
          'advancedDiff.sidebar.filtersSection.editMode' => '편집 모드',
          'advancedDiff.sidebar.filtersSection.dialog' => '대화 상자',
          'advancedDiff.sidebar.filtersSection.inline' => '인라인',
          'advancedDiff.sidebar.similaritySection.currentFilter' => '현재 필터:',
          'advancedDiff.sidebar.similaritySection.any' => '전체',
          'advancedDiff.sidebar.similaritySection.high' => '높음',
          'advancedDiff.sidebar.similaritySection.medium' => '중간',
          'advancedDiff.sidebar.similaritySection.low' => '낮음',
          'advancedDiff.sidebar.statusSection.total' =>
            ({required Object count}) => '총 ${count}개',
          'advancedDiff.sidebar.statusSection.extra' =>
            ({required Object count}) => '추가 ${count}개',
          'advancedDiff.sidebar.statusSection.missing' =>
            ({required Object count}) => '누락 ${count}개',
          'advancedDiff.sidebar.statusSection.changed' =>
            ({required Object count}) => '변경 ${count}개',
          'issueDetails.title' => '문제 세부 정보',
          'issueDetails.showingIssues' => (
                  {required Object total, required Object count}) =>
              '${total}개 문제 중 ${count}개 표시 중',
          'issueDetails.searchPlaceholder' => '키, 텍스트 또는 오류 검색...',
          'issueDetails.noDetails' => '세부 정보 없음.',
          'issueDetails.noMatches' => '일치 항목 없음.',
          'issueDetails.showMore' => '더 보기',
          'issueDetails.copyItems' => ({required Object count}) =>
              '${count}개 항목 복사',
          'issueDetails.close' => '닫기',
          'issueDetails.copied' => '클립보드에 복사됨',
          'issueDetails.copiedCount' => ({required Object count}) =>
              '${count}개 항목 복사됨',
          'issueDetails.duplicateValue.label' => '중복 번역',
          'issueDetails.duplicateValue.warning' =>
            '다른 소스 텍스트가 이 동일한 번역을 사용합니다. 문맥을 확인하세요.',
          'issueDetails.duplicateValue.affectedKeys' =>
            ({required Object count}) => '영향받는 키 (${count})',
          'issueDetails.duplicateValue.identicalSources' => '동일한 소스',
          'issueDetails.duplicateValue.moreKeys' => ({required Object count}) =>
              '${count}개 키 더 보기',
          'issueDetails.lengthOutlier.source' => '소스',
          'issueDetails.lengthOutlier.translation' => '번역',
          'issueDetails.lengthOutlier.chars' => ({required Object count}) =>
              '${count}자',
          'issueDetails.standard.key' => '키',
          'issueDetails.standard.sourceText' => '소스 텍스트',
          'issueDetails.standard.translation' => '번역',
          'issueDetails.standard.errorDetails' => '오류 세부 정보',
          'issueDetails.standard.note' => '참고',
          'issueDetails.review' => '검토',
          'issueDetails.types.duplicateValue' => '중복된 값',
          'issueDetails.types.lengthOutlier' => '길이 불일치',
          'issueDetails.types.placeholderMismatch' => '손상된 플레이스홀더',
          'issueDetails.notes.placeholderMismatch' =>
            '{name}과 같은 마커는 소스와 일치해야 합니다.',
          'issueDetails.notes.lengthOutlier' =>
            '큰 길이 변화는 텍스트가 화면에 표시되는 방식에 영향을 줄 수 있습니다.',
          'issueDetails.notes.duplicateValue' => '서로 다른 키에 동일한 번역이 사용되었습니다.',
          'issueDetails.fallbacks.multipleSources' => '다수 소스 텍스트',
          'issueDetails.fallbacks.sourceNotAvailable' => '소스 텍스트 사용 불가',
          'issueDetails.fallbacks.sharedTranslationNotAvailable' =>
            '공유 번역 사용 불가',
          'issueDetails.fallbacks.translationNotAvailable' => '번역 사용 불가',
          'importReview.title' => '프로젝트 가져오기 검토',
          'importReview.projectName' => '프로젝트 이름',
          'importReview.created' => '생성됨',
          'importReview.historyItems' => '기록 항목',
          'importReview.customSettingsTitle' => '사용자 지정 설정 감지됨',
          'importReview.customSettingsWarning' =>
            '이 프로젝트에는 이 프로젝트가 열려 있는 동안 기본값을 재정의하는 사용자 지정 설정이 포함되어 있습니다.',
          'importReview.standardSettings' => '이 프로젝트는 표준 전역 설정을 사용합니다.',
          'importReview.cancelImport' => '가져오기 취소',
          'importReview.trustOpen' => '신뢰 & 프로젝트 열기',
          'historyView.title' => '비교 기록',
          'historyView.clearAll' => '모든 기록 지우기',
          'historyView.searchPlaceholder' => '파일 이름으로 검색...',
          'historyView.sortBy' => '정렬 기준',
          'historyView.sortDate' => '날짜',
          'historyView.sortSource' => '소스 파일',
          'historyView.sortTarget' => '타겟 파일',
          'historyView.showCurrentProject' => '표시 중: 현재 프로젝트',
          'historyView.showAllHistory' => '표시 중: 모든 기록',
          'historyView.groupByFolder' => '폴더별 그룹화',
          'historyView.disableGrouping' => '폴더 그룹화 비활성화',
          'historyView.filterAll' => '전체',
          'historyView.filterFiles' => '파일',
          'historyView.filterDirectories' => '디렉토리',
          'historyView.filterGit' => 'Git',
          'historyView.noHistory' => '아직 비교 기록이 없습니다',
          'historyView.historyDescription' => '파일 비교가 여기에 표시됩니다',
          'historyView.noResults' => '결과 없음',
          'historyView.adjustSearch' => '검색을 조정해 보세요',
          'historyView.clearConfirmationTitle' => '모든 기록을 지우시겠습니까?',
          'historyView.clearConfirmationContent' =>
            '모든 비교 기록이 영구적으로 삭제됩니다. 이 작업은 취소할 수 없습니다.',
          'historyView.clearAction' => '모두 지우기',
          'historyView.deletedMessage' => '기록 항목 삭제됨',
          'historyView.undo' => '실행 취소',
          'historyView.viewDetails' => '세부 정보 보기',
          'historyView.delete' => '삭제',
          'historyView.openLocation' => '파일 위치 열기',
          'historyView.bilingual' => '이중 언어',
          'historyView.filePair' => '파일 쌍',
          'historyView.directory' => '디렉토리',
          'historyView.git' => 'Git',
          'historyView.repo' => '저장소',
          'historyView.sourceDir' => '소스 디렉토리',
          'historyView.targetDir' => '타겟 디렉토리',
          'historyView.source' => '소스',
          'historyView.target' => '타겟',
          'historyView.noChanges' => '변경 사항 감지되지 않음',
          'historyView.added' => '추가됨',
          'historyView.removed' => '제거됨',
          'historyView.modified' => '수정됨',
          'historyView.same' => '동일함',
          'historyView.total' => '합계',
          'historyView.currentProject' => '현재 프로젝트',
          'historyView.unassigned' => '할당되지 않음',
          'historyView.project' => '프로젝트',
          'compare.title' => '파일 비교',
          'compare.sourceFile' => '소스 파일',
          'compare.targetFile' => '타겟 파일',
          'compare.sourceFolder' => '소스 폴더',
          'compare.targetFolder' => '타겟 폴더',
          'compare.dropFilesHint' =>
            '로컬라이제이션 파일을 여기에 놓거나 찾아보기 버튼을 사용하여 비교할 파일을 선택하세요.',
          'compare.selectSourceFile' => '소스 파일 선택',
          'compare.selectTargetFile' => '타겟 파일 선택',
          'compare.startComparison' => '비교 시작',
          'compare.comparing' => '비교 중...',
          'compare.comparisonComplete' => '비교 완료',
          'compare.noChanges' => '변경 사항 감지되지 않음',
          'compare.filesIdentical' => '파일이 동일합니다',
          'compare.changesFound' => ({required Object count}) =>
              '${count}개 변경 사항 발견됨',
          'compare.tabs.files' => '파일',
          'compare.tabs.directories' => '디렉토리',
          'compare.tabs.git' => 'Git',
          'compare.fileTypes.json' => 'JSON 로컬라이제이션 파일 (i18next, Flutter 등)',
          'compare.fileTypes.yaml' => 'YAML 로컬라이제이션 파일 (Rails, Flutter)',
          'compare.fileTypes.xml' => 'XML 로컬라이제이션 파일 (Android, .NET)',
          'compare.fileTypes.properties' => 'Properties 파일 (Java)',
          'compare.fileTypes.resx' => 'RESX 파일 (.NET)',
          _ => null,
        } ??
        switch (path) {
          'compare.fileTypes.xliff' => 'XLIFF 파일',
          'history.title' => '기록',
          'history.recentComparisons' => '최근 비교',
          'history.noHistory' => '아직 비교 기록이 없습니다',
          'history.noHistoryDescription' => '비교 기록이 여기에 표시됩니다',
          'history.clearHistory' => '기록 지우기',
          'history.clearHistoryConfirm' => '모든 기록을 지우시겠습니까?',
          'history.deleteEntry' => '항목 삭제',
          'history.openComparison' => '비교 열기',
          'history.timeAgo.justNow' => '방금 전',
          'history.timeAgo.secondsAgo' => ({required Object count}) =>
              '${count}초 전',
          'history.timeAgo.oneMinuteAgo' => '1분 전',
          'history.timeAgo.minutesAgo' => ({required Object count}) =>
              '${count}분 전',
          'history.timeAgo.oneHourAgo' => '1시간 전',
          'history.timeAgo.hoursAgo' => ({required Object count}) =>
              '${count}시간 전',
          'history.timeAgo.yesterday' => '어제',
          'history.timeAgo.daysAgo' => ({required Object count}) =>
              '${count}일 전',
          'history.timeAgo.oneWeekAgo' => '1주 전',
          'history.timeAgo.weeksAgo' => ({required Object count}) =>
              '${count}주 전',
          'history.timeAgo.oneMonthAgo' => '1개월 전',
          'history.timeAgo.monthsAgo' => ({required Object count}) =>
              '${count}개월 전',
          'history.timeAgo.oneYearAgo' => '1년 전',
          'history.timeAgo.yearsAgo' => ({required Object count}) =>
              '${count}년 전',
          'history.timeAgo.inTheFuture' => '미래',
          'projects.title' => '프로젝트',
          'projects.createProject' => '프로젝트 생성',
          'projects.importProject' => '프로젝트 가져오기',
          'projects.noProjects' => '프로젝트 없음',
          'projects.noProjectsDescription' => '로컬라이제이션 파일을 정리하려면 프로젝트를 생성하세요',
          'projects.projectName' => '프로젝트 이름',
          'projects.projectPath' => '프로젝트 경로',
          'projects.lastOpened' => '마지막으로 연 날짜',
          'projects.openProject' => '프로젝트 열기',
          'projects.closeProject' => '프로젝트 닫기',
          'projects.deleteProject' => '프로젝트 삭제',
          'projects.deleteProjectConfirm' => '이 프로젝트를 삭제하시겠습니까?',
          'projects.exportProject' => '프로젝트 내보내기',
          'projects.exportDescription' =>
            '소스 파일, 구성 및 기록이 포함된 휴대용 zip 파일을 생성합니다.',
          'projects.exporting' => '프로젝트 내보내는 중...',
          'projects.exportSuccess' => '프로젝트 내보내짐',
          'projects.exportError' => ({required Object error}) =>
              '내보내기 실패: ${error}',
          'projects.createNewProject' => '새 프로젝트 생성',
          'projects.openExistingProject' => '기존 프로젝트 열기',
          'projects.importProjectZip' => '프로젝트 Zip 가져오기',
          'projects.projectResources' => '프로젝트 리소스',
          'projects.recentProjects' => '최근 프로젝트',
          'projects.noRecentProjects' => '최근 프로젝트 없음',
          'projects.selectProjectZip' => '프로젝트 Zip 선택',
          'projects.selectDestination' => '가져오기 대상 폴더 선택',
          'projects.importing' => '프로젝트 가져오는 중...',
          'projects.importSuccess' => '프로젝트를 성공적으로 가져왔습니다',
          'projects.importFailed' => ({required Object error}) =>
              '가져오기 실패: ${error}',
          'projects.importingFiles' => '파일 가져오는 중...',
          'projects.noSupportedFiles' => '지원되는 파일이 없습니다.',
          'projects.stats.empty' => '빈 프로젝트',
          'projects.stats.files' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ko'))(
                n,
                one: '1개 번역 파일',
                other: '${count}개 번역 파일',
              ),
          'projects.stats.languages' => (
                  {required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ko'))(
                n,
                one: '1개 언어',
                other: '${count}개 언어',
              ),
          'projects.openProjectFirst' => '리소스를 관리하려면 먼저 프로젝트를 여세요.',
          'projects.removeFromRecent' => '최근 항목에서 제거',
          'projects.selection.selectFolder' => '프로젝트 폴더 선택',
          'projects.selection.selectArchive' => '프로젝트 아카이브 선택',
          'projects.selection.openProject' => '프로젝트 열기',
          'projects.selection.browseFolder' => '폴더 찾아보기...',
          'projects.selection.createNew' => '새로 생성',
          'projects.selection.importFromZip' => 'Zip에서 가져오기...',
          'projects.createDialog.title' => '프로젝트 생성',
          'projects.createDialog.description' =>
            '프로젝트를 사용하면 특정 폴더에 대한 사용자 지정 설정을 저장할 수 있습니다. 프로젝트 구성을 저장하기 위해 ".localizer" 폴더가 생성됩니다.',
          'projects.createDialog.folderLabel' => '프로젝트 폴더',
          'projects.createDialog.folderHint' => '폴더를 선택하려면 클릭...',
          'projects.createDialog.nameLabel' => '프로젝트 이름',
          'projects.createDialog.nameHint' => '예: 내 앱 번역',
          'projects.createDialog.selectFolderWarning' => '프로젝트 폴더를 선택하세요.',
          'projects.createDialog.enterNameError' => '프로젝트 이름을 입력하세요',
          'projects.createDialog.nameLengthError' => '이름은 2자 이상이어야 합니다',
          'projects.createDialog.success' => ({required Object name}) =>
              '프로젝트 "${name}" 생성 성공!',
          'projects.createDialog.failure' => '프로젝트 생성 실패.',
          'projects.createDialog.creating' => '생성 중...',
          'projects.createDialog.createAction' => '프로젝트 생성',
          'projects.indicator.tooltipNoProject' =>
            '폴더에 대한 사용자 지정 설정을 저장하려면 프로젝트를 생성하세요',
          'projects.indicator.tooltipProject' => ({required Object name}) =>
              '프로젝트: ${name}\n옵션을 보려면 클릭',
          'projects.indicator.location' => '위치',
          'projects.indicator.created' => '생성됨',
          'projects.indicator.switchProject' => '프로젝트 전환',
          'projects.indicator.done' => '완료',
          'projects.glossary.title' => '프로젝트 용어집',
          'projects.glossary.description' =>
            '일관되게 처리하거나 절대 번역하지 않아야 하는 용어를 정의합니다.',
          'projects.glossary.noTerms' => '아직 용어집 용어가 없습니다.',
          'projects.glossary.noTermsDesc' =>
            '번역 전체에서 일관성을 유지해야 하는 용어를 추가하거나,\n번역하지 않아야 하는 브랜드 이름을 표시하세요.',
          'projects.glossary.doNotTranslate' => '번역하지 않음',
          'projects.glossary.noSpecificTranslation' => '특정 번역 없음',
          'projects.glossary.addTerm' => '용어 추가',
          'projects.glossary.editTerm' => '용어 편집',
          'projects.glossary.term' => '용어',
          'projects.glossary.termHint' => '예: 브랜드 이름, 전문 용어',
          'projects.glossary.definition' => '정의 (선택 사항)',
          'projects.glossary.definitionHint' => '번역가를 위한 컨텍스트',
          'projects.glossary.doNotTranslateLabel' => '번역하지 않음',
          'projects.glossary.doNotTranslateDesc' => '타겟에서 용어를 그대로 유지',
          'projects.glossary.preferredTranslation' => '선호하는 번역',
          'projects.glossary.caseSensitive' => '대소문자 구분',
          'projects.conflicts.missingApiKeyTitle' =>
            ({required Object service}) => '${service}에 대한 API 키 누락',
          'projects.conflicts.missingApiKeyMessage' => (
                  {required Object service}) =>
              '이 프로젝트는 ${service}을(를) 사용하지만 API 키가 구성되지 않았습니다. 설정 > AI 서비스에서 API 키를 추가하거나 앱이 전역 기본값을 사용합니다.',
          'projects.conflicts.dismiss' => '무시',
          'projects.tm.title' => '번역 메모리',
          'projects.tm.description' => '이 프로젝트의 번역 메모리 소스를 관리합니다.',
          'projects.tm.globalTm' => '전역 번역 메모리',
          'projects.tm.globalTmDescription' => '앱 설정의 공유 번역 메모리 사용',
          'projects.tm.linkedFiles' => '연결된 파일 (프로젝트별)',
          'projects.tm.noLinkedFiles' => '연결된 프로젝트별 파일이 없습니다.',
          'projects.tm.addTmFile' => 'TM 파일 추가',
          'projects.tm.useGlobalTm' => '전역 TM 사용',
          'projects.tm.selectTm' => '번역 메모리 선택',
          'projects.tm.globalTmEnabled' => '전역 번역 메모리 활성화됨',
          'diff.added' => '추가됨',
          'diff.removed' => '제거됨',
          'diff.modified' => '수정됨',
          'diff.unchanged' => '변경 없음',
          'diff.missing' => '누락됨',
          'diff.extra' => '추가됨',
          'diff.sourceValue' => '소스 값',
          'diff.targetValue' => '타겟 값',
          'diff.key' => '키',
          'diff.status' => '상태',
          'diff.actions' => '작업',
          'diff.copyToTarget' => '타겟에 복사',
          'diff.acceptChange' => '변경 사항 수락',
          'diff.rejectChange' => '변경 사항 거절',
          'diff.viewDetails' => '세부 정보 보기',
          'git.title' => 'Git 비교',
          'git.selectRepository' => '저장소 선택',
          'git.selectBranch' => '브랜치 선택',
          'git.selectCommit' => '커밋 선택',
          'git.compareBranches' => '브랜치 비교',
          'git.compareCommits' => '커밋 비교',
          'git.baseBranch' => '베이스 브랜치',
          'git.compareBranch' => '비교 브랜치',
          'git.noRepositories' => 'Git 저장소를 찾을 수 없음',
          'git.noRepositoriesDescription' => 'Git 저장소가 포함된 폴더를 여세요',
          'git.filesChanged' => ({required Object count}) => '${count}개 파일 변경됨',
          'git.additions' => ({required Object count}) => '${count}개 추가',
          'git.deletions' => ({required Object count}) => '${count}개 삭제',
          'git.conflicts.title' => '병합 충돌 감지됨',
          'git.conflicts.description' => '계속하려면 이 충돌을 해결해야 합니다.',
          'git.conflicts.abortMergeTitle' => '병합 중단?',
          'git.conflicts.abortMergeContent' =>
            '모든 병합 변경 사항이 되돌려지고 병합 전 상태로 돌아갑니다. 이 작업은 취소할 수 없습니다.',
          'git.conflicts.abortMergeAction' => '병합 중단',
          'git.conflicts.stagingFile' => ({required Object file}) =>
              '커밋을 위해 ${file} 스테이징 중...',
          'git.conflicts.conflictedFilesCount' => ({required Object count}) =>
              '충돌된 파일 (${count})',
          'git.conflicts.selectFileToResolve' => '해결할 파일 선택',
          'git.conflicts.resolvingFile' => ({required Object file}) =>
              '해결 중: ${file}',
          'git.conflicts.keepAllOurs' => '우리 것 모두 유지',
          'git.conflicts.acceptAllTheirs' => '상대 것 모두 수락',
          'git.conflicts.allResolved' => '이 파일의 모든 충돌이 해결되었습니다!',
          'git.conflicts.markResolved' => '해결됨으로 표시',
          'git.conflicts.stageForCommit' => '이 파일은 커밋을 위해 스테이징됩니다.',
          'git.conflicts.conflictIndex' => ({required Object index}) =>
              '충돌 #${index}',
          'git.conflicts.ours' => 'OURS (현재)',
          'git.conflicts.theirs' => 'THEIRS (수신)',
          'git.conflicts.keepOurs' => '우리 것 유지',
          'git.conflicts.acceptTheirs' => '상대 것 수락',
          'git.conflicts.empty' => '(비어 있음)',
          'quality._translatorNote' =>
            'API 및 메트릭 용어(Requests, Tokens, Characters, Prompt, Completion, Export)는 업계 용어와의 일관성을 유지하기 위해 모든 번역에서 영어로 유지해야 합니다.',
          'quality.title' => '품질 대시보드',
          'quality.overallScore' => '전체 점수',
          'quality.issues' => '문제',
          'quality.warnings' => '경고',
          'quality.suggestions' => '제안',
          'quality.placeholderMismatch' => '플레이스홀더 불일치',
          'quality.placeholderMismatchDescription' =>
            '{name}과 같은 플레이스홀더가 소스와 타겟 간에 일치하지 않습니다',
          'quality.lengthOutlier' => '길이 이상치',
          'quality.lengthOutlierDescription' => '번역 길이가 소스와 크게 다릅니다',
          'quality.duplicateValue' => '중복된 값',
          'quality.duplicateValueDescription' => '동일한 번역이 여러 키에 사용됨',
          'quality.missingTranslation' => '누락된 번역',
          'quality.missingTranslationDescription' => '이 키에 대한 번역이 누락되었습니다',
          'quality.loading' => '대시보드 로딩 중...',
          'quality.errorLoading' => '기록을 로드할 수 없습니다. 다시 시도해 주세요.',
          'quality.emptyState' => '대시보드를 보려면 비교를 실행하세요.',
          'quality.refresh' => '새로 고침',
          'quality.buildingInsights' => '인사이트 구축 중...',
          'quality.crunchingNumbers' => '숫자 계산 중...',
          'quality.errorBuilding' => '대시보드를 구축할 수 없습니다. 다시 시도해 주세요.',
          'quality.noUsableData' => '아직 사용할 수 있는 데이터가 없습니다.',
          'quality.languages' => '언어',
          'quality.averageCoverage' => '평균 커버리지',
          'quality.potentialIssues' => '잠재적 문제',
          'quality.translationCoverage' => '번역 커버리지',
          'quality.entriesTranslated' => (
                  {required Object total, required Object translated}) =>
              '${total}개 중 ${translated}개 항목 번역됨',
          'quality.wordsAddedOverTime' => '시간 경과에 따른 단어 추가',
          'quality.completionVsScope' => '완료 vs 범위',
          'quality.scopeVsProgress' => '범위 vs 진행률',
          'quality.coveragePercent' => '커버리지 %',
          'quality.wordsAdded' => '추가된 단어',
          'quality.words' => '단어',
          'quality.coverage' => '커버리지',
          'quality.scope' => '범위',
          'quality.latest' => '최신',
          'quality.added' => '추가됨',
          'quality.change' => '변경',
          'quality.totalScope' => '총 범위',
          'quality.scopeGrowth' => '범위 증가',
          'quality.range' => '범위',
          'quality.aiUsage' => 'AI & 번역 사용량',
          'quality.lastUsed' => ({required Object date}) => '마지막 사용 ${date}',
          'quality.noIssuesFound' => '최근 비교에서 발견된 문제가 없습니다.',
          'quality.placeholderMismatches' => '플레이스홀더 불일치',
          'quality.placeholderMismatchesDesc' => '{name}과 같은 마커가 일치하지 않습니다.',
          'quality.lengthOutliers' => '매우 짧거나 긴 번역',
          'quality.lengthOutliersDesc' => '길이가 소스에 비해 비정상적입니다.',
          'quality.duplicateValues' => '중복된 값',
          'quality.duplicateValuesDesc' => '동일한 번역이 여러 번 사용되었습니다.',
          'quality.placeholderDialogTitle' => '플레이스홀더 불일치',
          'quality.placeholderDialogDesc' =>
            '이 번역은 소스와 다른 플레이스홀더({name})를 가지고 있습니다.',
          'quality.lengthDialogTitle' => '길이 이상치',
          'quality.lengthDialogDesc' => '이 번역은 소스보다 상당히 짧거나 깁니다.',
          'quality.duplicateDialogTitle' => '중복된 값',
          'quality.duplicateDialogDesc' => '이 번역은 여러 번 나타납니다.',
          'quality.duplicateSample' => ({required Object value}) =>
              '중복: "${value}"',
          'quality.exportError' => '보고서를 작성할 수 없습니다. 다시 시도해 주세요.',
          'quality.noDataToExport' => '내보낼 데이터 없음',
          'quality.exportFailed' => '내보내기 실패',
          'quality.exportDialogTitle' => '품질 보고서 내보내기',
          'quality.reportSaved' => '보고서 저장됨',
          'quality.export' => 'Export',
          'quality.requests' => 'Requests',
          'quality.tokens' => 'Tokens',
          'quality.characters' => 'Characters',
          'quality.estCost' => 'Est. Cost',
          'quality.prompt' => 'Prompt',
          'quality.completion' => 'Completion',
          'quality.showingCurrentProject' => '표시 중: 현재 프로젝트',
          'quality.showingAllHistory' => '표시 중: 모든 기록',
          'quality.filesSkipped' => '일부 파일을 찾을 수 없어 건너뛰었습니다.',
          'errors.genericError' => '오류가 발생했습니다',
          'errors.fileNotFound' => '파일을 찾을 수 없음',
          'errors.invalidFormat' => '잘못된 파일 형식',
          'errors.parseError' => '파일 파싱 실패',
          'errors.networkError' => '네트워크 오류. 연결을 확인하세요.',
          'errors.permissionDenied' => '권한 거부됨',
          'errors.unknownError' => '알 수 없는 오류가 발생했습니다',
          'wizards.firstRun.welcome' => 'Localizer에 오신 것을 환영합니다',
          'wizards.firstRun.description' => '몇 초 만에 로컬라이제이션 파일을 비교하세요.',
          'wizards.firstRun.sourceFile' => '소스 파일',
          'wizards.firstRun.targetFile' => '타겟 파일',
          'wizards.firstRun.compareNow' => '지금 비교',
          'wizards.firstRun.trySample' => '샘플 데이터로 시도',
          'wizards.firstRun.skip' => '설정 건너뛰기',
          'wizards.firstRun.browse' => '클릭하여 찾아보기',
          'wizards.firstRun.error' => ({required Object error}) =>
              '샘플 데이터 로드 실패: ${error}',
          'dialogs.addIgnorePattern.title' => '무시 패턴 추가',
          'dialogs.addIgnorePattern.patternLabel' => '패턴 (regex)',
          'dialogs.addIgnorePattern.hint' => '예: ^temp_.*',
          'dialogs.addIgnorePattern.invalid' => '잘못된 정규식 패턴',
          'dialogs.addIgnorePattern.testStringLabel' => '테스트 문자열',
          'dialogs.addIgnorePattern.testHint' => '패턴에 대해 테스트할 키 입력',
          'dialogs.addIgnorePattern.match' => '✓ 패턴이 테스트 문자열과 일치함',
          'dialogs.addIgnorePattern.noMatch' => '✗ 패턴이 일치하지 않음',
          'dialogs.addIgnorePattern.add' => '추가',
          'dialogs.addIgnorePattern.cancel' => '취소',
          'dialogs.diffViewer.title' => 'Diff 뷰어',
          'dialogs.diffViewer.originalFile' => '원본/참조 파일',
          'dialogs.diffViewer.translationFile' => '번역/비교 파일',
          'dialogs.diffViewer.base' => '베이스',
          'dialogs.diffViewer.target' => '타겟',
          'dialogs.diffViewer.added' => '추가됨',
          'dialogs.diffViewer.removed' => '제거됨',
          'dialogs.diffViewer.modified' => '수정됨',
          'dialogs.diffViewer.noMatches' => '현재 필터와 일치하는 항목 없음',
          'dialogs.diffViewer.clickToggle' => '필터를 전환하려면 위 배지를 클릭하세요',
          'grid.columns.key' => '키',
          'grid.columns.source' => '소스',
          'grid.columns.status' => '상태',
          'grid.columns.actions' => '작업',
          'tutorial.skipTutorial' => '튜토리얼 건너뛰기',
          'tutorial.finishMessage' => '모든 준비가 완료되었습니다! 완료하려면 아무 곳이나 탭하세요.',
          'tutorial.next' => '다음',
          'tutorial.loadSampleData' => '샘플 데이터 로드',
          'tutorial.browseSourceFile' => '소스 파일 찾아보기',
          'tutorial.browseTargetFile' => '타겟 파일 찾아보기',
          'tutorial.compareFiles' => '파일 비교',
          'tutorial.hintPhase2' => '다음: 필터, 검색, 고급 보기 및 내보내기.',
          'tutorial.steps.importSource.title' => '1. 소스 파일 가져오기',
          'tutorial.steps.importSource.description' =>
            '아래 버튼을 사용하여 파일을 찾아보거나 강조 표시된 영역에 드래그 앤 드롭하세요.',
          'tutorial.steps.importTarget.title' => '2. 타겟 파일 가져오기',
          'tutorial.steps.importTarget.description' =>
            '아래 버튼을 사용하여 파일을 찾아보거나 강조 표시된 영역에 드래그 앤 드롭하세요.',
          'tutorial.steps.compare.title' => '3. 파일 비교',
          'tutorial.steps.compare.description' =>
            '결과를 보려면 아래 버튼을 탭하여 비교를 실행하세요.',
          'tutorial.steps.filter.title' => '4. 결과 필터링',
          'tutorial.steps.filter.description' =>
            '이 필터를 사용하여 추가됨, 제거됨, 또는 수정된 문자열을 확인하세요.',
          'tutorial.steps.search.title' => '5. 검색 결과',
          'tutorial.steps.search.description' => '검색 창을 사용하여 특정 키나 값을 찾으세요.',
          'tutorial.steps.advanced.title' => '6. 고급 보기',
          'tutorial.steps.advanced.description' =>
            '편집, AI 번역 등을 포함한 상세 diff 보기를 엽니다.',
          'tutorial.steps.export.title' => '7. 결과 내보내기',
          'tutorial.steps.export.description' =>
            '비교 내용을 CSV, JSON 또는 Excel 파일로 저장하세요.',
          'friendlyErrors.fileNotFound.message' => '파일 또는 폴더를 찾을 수 없습니다.',
          'friendlyErrors.fileNotFound.suggestion' =>
            '파일이 이동되었거나 삭제되었는지 확인하세요.',
          'friendlyErrors.accessDenied.message' => '파일에 대한 액세스가 거부되었습니다.',
          'friendlyErrors.accessDenied.suggestion' =>
            '관리자 권한으로 앱을 실행하거나 파일 권한을 확인하세요.',
          'friendlyErrors.isDirectory.message' => '파일 대신 폴더가 선택되었습니다.',
          'friendlyErrors.isDirectory.suggestion' => '유효한 파일을 선택하세요.',
          'friendlyErrors.fileAccess.message' => '파일에 액세스하는 데 문제가 발생했습니다.',
          'friendlyErrors.fileAccess.suggestion' =>
            '파일을 사용 중일 수 있는 다른 프로그램을 닫고 시도해 보세요.',
          'friendlyErrors.unsupportedFormat.message' =>
            '이 파일 형식 또는 작업은 지원되지 않습니다.',
          'friendlyErrors.unsupportedFormat.suggestion' =>
            '파일 확장자를 확인하거나 다른 형식을 시도해 보세요.',
          'friendlyErrors.networkError.message' => '서버에 연결할 수 없습니다.',
          'friendlyErrors.networkError.suggestion' =>
            '인터넷 연결을 확인하고 다시 시도해 보세요.',
          'friendlyErrors.notGitRepo.message' => '이 폴더는 Git 프로젝트가 아닙니다.',
          'friendlyErrors.notGitRepo.suggestion' => '.git 디렉토리가 포함된 폴더로 이동하세요.',
          'friendlyErrors.mergeConflict.message' => '저장소에 병합 충돌이 있습니다.',
          'friendlyErrors.mergeConflict.suggestion' => '계속하기 전에 충돌을 해결하세요.',
          'friendlyErrors.gitAuthFailed.message' => 'Git 인증에 실패했습니다.',
          'friendlyErrors.gitAuthFailed.suggestion' =>
            '설정 > 버전 제어에서 자격 증명을 확인하세요.',
          'friendlyErrors.gitOperationFailed.message' => 'Git 작업이 실패했습니다.',
          'friendlyErrors.gitOperationFailed.suggestion' =>
            '자세한 내용은 Git 보기를 확인하세요.',
          'friendlyErrors.invalidJson.message' => '파일 형식이 유효하지 않거나 손상되었습니다.',
          'friendlyErrors.invalidJson.suggestion' =>
            '파일에 유효한 JSON 콘텐츠가 포함되어 있는지 확인하세요.',
          'friendlyErrors.rateLimitReached.message' => '번역 한도에 도달했습니다.',
          'friendlyErrors.rateLimitReached.suggestion' =>
            '몇 분 기다리거나 API 요금제 한도를 확인하세요.',
          'friendlyErrors.invalidApiKey.message' => '유효하지 않은 API 키입니다.',
          'friendlyErrors.invalidApiKey.suggestion' =>
            'API 키를 업데이트하려면 설정 > AI 번역으로 이동하세요.',
          'friendlyErrors.translationServiceError.message' => '번역 서비스 오류입니다.',
          'friendlyErrors.translationServiceError.suggestion' =>
            'API 키와 인터넷 연결을 확인하세요.',
          'friendlyErrors.outOfMemory.message' => '이 작업을 완료하기에 메모리가 부족합니다.',
          'friendlyErrors.outOfMemory.suggestion' =>
            '다른 애플리케이션을 닫거나 더 작은 파일을 사용해 보세요.',
          'friendlyErrors.genericError.message' => '문제가 발생했습니다.',
          'friendlyErrors.genericError.suggestion' =>
            '다시 시도해 보세요. 문제가 지속되면 앱을 다시 시작하세요.',
          'systemTray.showLocalizer' => 'Localizer 표시',
          'systemTray.exit' => '종료',
          'validation.connected' => '연결됨.',
          'validation.connectionTimeout' => '연결 시간이 초과되었습니다. 다시 시도해 주세요.',
          'validation.couldNotConnect' => '연결할 수 없습니다. 다시 시도해 주세요.',
          'validation.checkKeyAndTryAgain' => '연결할 수 없습니다. 키를 확인하고 다시 시도해 주세요.',
          'validation.tryAgainLater' => '지금은 연결할 수 없습니다. 나중에 다시 시도해 주세요.',
          'validation.serviceUnavailable' =>
            '서비스를 지금 사용할 수 없습니다. 나중에 다시 시도해 주세요.',
          'validation.enterKeyFirst' => '먼저 키를 입력하세요.',
          'validation.checking' => '확인 중...',
          'validation.deeplUsage' => (
                  {required Object used, required Object limit}) =>
              '사용량: ${used} / ${limit} 문자.',
          'status.startingComparison' => '비교 시작 중...',
          'status.loadingFromHistory' => '기록에서 파일 로드 중...',
          'status.comparisonComplete' => '비교 완료',
          'status.couldNotImportFiles' => '파일을 가져올 수 없습니다. 다시 시도해 주세요.',
          'status.historyFilesNotFound' =>
            '기록의 하나 또는 두 파일 모두 원본 경로에서 찾을 수 없습니다.',
          'aiServices.geminiEmptyResponse' => 'Gemini가 빈 응답을 반환했습니다',
          'aiServices.geminiStreamingEmpty' => 'Gemini 스트리밍이 빈 응답을 반환했습니다',
          'aiServices.geminiRephraseEmpty' => 'Gemini가 문구 수정에 대해 빈 응답을 반환했습니다',
          'aiServices.openaiEmptyResponse' => 'OpenAI가 비어 있거나 실패한 응답을 반환했습니다',
          _ => null,
        };
  }
}
