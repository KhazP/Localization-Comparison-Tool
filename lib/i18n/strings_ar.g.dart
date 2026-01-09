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
class TranslationsAr
    with BaseTranslations<AppLocale, Translations>
    implements Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsAr(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.ar,
              overrides: overrides ?? {},
              cardinalResolver: cardinalResolver,
              ordinalResolver: ordinalResolver,
            ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <ar>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final TranslationsAr _root = this; // ignore: unused_field

  @override
  TranslationsAr $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsAr(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsAppAr app = _TranslationsAppAr._(_root);
  @override
  late final _TranslationsCommonAr common = _TranslationsCommonAr._(_root);
  @override
  late final _TranslationsMenuAr menu = _TranslationsMenuAr._(_root);
  @override
  late final _TranslationsNavAr nav = _TranslationsNavAr._(_root);
  @override
  late final _TranslationsSettingsAr settings =
      _TranslationsSettingsAr._(_root);
  @override
  late final _TranslationsFileComparisonAr fileComparison =
      _TranslationsFileComparisonAr._(_root);
  @override
  late final _TranslationsDirectoryComparisonAr directoryComparison =
      _TranslationsDirectoryComparisonAr._(_root);
  @override
  late final _TranslationsGitComparisonAr gitComparison =
      _TranslationsGitComparisonAr._(_root);
  @override
  late final _TranslationsAdvancedComparisonAr advancedComparison =
      _TranslationsAdvancedComparisonAr._(_root);
  @override
  late final _TranslationsAdvancedDiffAr advancedDiff =
      _TranslationsAdvancedDiffAr._(_root);
  @override
  late final _TranslationsIssueDetailsAr issueDetails =
      _TranslationsIssueDetailsAr._(_root);
  @override
  late final _TranslationsImportReviewAr importReview =
      _TranslationsImportReviewAr._(_root);
  @override
  late final _TranslationsHistoryViewAr historyView =
      _TranslationsHistoryViewAr._(_root);
  @override
  late final _TranslationsCompareAr compare = _TranslationsCompareAr._(_root);
  @override
  late final _TranslationsHistoryAr history = _TranslationsHistoryAr._(_root);
  @override
  late final _TranslationsProjectsAr projects =
      _TranslationsProjectsAr._(_root);
  @override
  late final _TranslationsDiffAr diff = _TranslationsDiffAr._(_root);
  @override
  late final _TranslationsGitAr git = _TranslationsGitAr._(_root);
  @override
  late final _TranslationsQualityAr quality = _TranslationsQualityAr._(_root);
  @override
  late final _TranslationsErrorsAr errors = _TranslationsErrorsAr._(_root);
  @override
  late final _TranslationsWizardsAr wizards = _TranslationsWizardsAr._(_root);
  @override
  late final _TranslationsDialogsAr dialogs = _TranslationsDialogsAr._(_root);
  @override
  late final _TranslationsGridAr grid = _TranslationsGridAr._(_root);
  @override
  late final _TranslationsTutorialAr tutorial =
      _TranslationsTutorialAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsAr friendlyErrors =
      _TranslationsFriendlyErrorsAr._(_root);
  @override
  late final _TranslationsSystemTrayAr systemTray =
      _TranslationsSystemTrayAr._(_root);
  @override
  late final _TranslationsValidationAr validation =
      _TranslationsValidationAr._(_root);
  @override
  late final _TranslationsStatusAr status = _TranslationsStatusAr._(_root);
  @override
  late final _TranslationsAiServicesAr aiServices =
      _TranslationsAiServicesAr._(_root);
}

// Path: app
class _TranslationsAppAr implements TranslationsAppEn {
  _TranslationsAppAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'أداة مقارنة الترجمة';
  @override
  String get name => 'Localizer';
}

// Path: common
class _TranslationsCommonAr implements TranslationsCommonEn {
  _TranslationsCommonAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get save => 'حفظ';
  @override
  String get cancel => 'إلغاء';
  @override
  String get close => 'إغلاق';
  @override
  String get delete => 'حذف';
  @override
  String get edit => 'تعديل';
  @override
  String get add => 'إضافة';
  @override
  String get search => 'بحث';
  @override
  String get undo => 'تراجع';
  @override
  String get loading => 'جارٍ التحميل...';
  @override
  String get error => 'خطأ';
  @override
  String get success => 'نجاح';
  @override
  String get warning => 'تحذير';
  @override
  String get info => 'معلومات';
  @override
  String get confirm => 'تأكيد';
  @override
  String get yes => 'نعم';
  @override
  String get no => 'لا';
  @override
  String get ok => 'موافق';
  @override
  String get retry => 'إعادة المحاولة';
  @override
  String get copyText => 'نسخ';
  @override
  String get appName => 'Localizer';
  @override
  String get copied => 'تم النسخ!';
  @override
  String get enabled => 'مفعّل';
  @override
  String get disabled => 'معطّل';
  @override
  String get browse => 'تصفح';
  @override
  String get clear => 'مسح';
  @override
  String get apply => 'تطبيق';
  @override
  String get reset => 'إعادة تعيين';
  @override
  String get refresh => 'تحديث';
  @override
  String get export => 'تصدير';
  @override
  String get import => 'استيراد';
  @override
  String get select => 'تحديد';
  @override
  String get selectAll => 'تحديد الكل';
  @override
  String get deselectAll => 'إلغاء تحديد الكل';
  @override
  String get noResults => 'لا توجد نتائج';
  @override
  String get emptyState => 'لا شيء هنا بعد';
  @override
  String get open => 'فتح';
  @override
  String get change => 'تغيير';
  @override
  String get original => 'الأصلي';
  @override
  String get kNew => 'الجديد';
  @override
  String get remove => 'إزالة';
  @override
  String get auto => 'تلقائي';
  @override
  String get execute => 'تنفيذ';
  @override
  String get run => 'تشغيل';
  @override
  String get unknown => 'غير معروف';
  @override
  String get download => 'تنزيل';
  @override
  String get dropdownArrow => 'سهم القائمة المنسدلة';
  @override
  String get openInNewWindow => 'فتح في نافذة جديدة';
  @override
  String get resetToDefaults => 'إعادة تعيين للافتراضيات';
}

// Path: menu
class _TranslationsMenuAr implements TranslationsMenuEn {
  _TranslationsMenuAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get file => 'ملف';
  @override
  String get edit => 'تحرير';
  @override
  String get view => 'عرض';
  @override
  String get help => 'مساعدة';
  @override
  String get openFiles => 'فتح ملفات...';
  @override
  String get openFolder => 'فتح مجلد...';
  @override
  String get exportResults => 'تصدير النتائج...';
  @override
  String get undo => 'تراجع';
  @override
  String get redo => 'إعادة';
  @override
  String get cut => 'قص';
  @override
  String get paste => 'لصق';
  @override
  String get selectAll => 'تحديد الكل';
  @override
  String get zoomIn => 'تكيبر';
  @override
  String get zoomOut => 'تصغير';
  @override
  String get resetZoom => 'إعادة تعيين التكبير/التصغير';
  @override
  String get documentation => 'الوثائق';
  @override
  String get reportIssue => 'الإبلاغ عن مشكلة';
  @override
  String about({required Object appName}) => 'حول ${appName}';
}

// Path: nav
class _TranslationsNavAr implements TranslationsNavEn {
  _TranslationsNavAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get compare => 'مقارنة';
  @override
  String get history => 'السجل';
  @override
  String get settings => 'الإعدادات';
  @override
  String get projects => 'المشاريع';
  @override
  String get dashboard => 'لوحة القيادة';
  @override
  String get directory => 'الدليل';
  @override
  String get repository => 'المستودع';
  @override
  String get tooltipCompare => 'مقارنة ملفات الترجمة';
  @override
  String get tooltipHistory => 'عرض سجل المقارنة';
  @override
  String get tooltipSettings => 'إعدادات التطبيق';
  @override
  String get tooltipProjects => 'إدارة المشاريع';
  @override
  String get tooltipThemeToggle => 'تبديل المظهر';
  @override
  String get tooltipDebugConsole => 'وحدة تحكم التصحيح';
}

// Path: settings
class _TranslationsSettingsAr implements TranslationsSettingsEn {
  _TranslationsSettingsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'الإعدادات';
  @override
  String get appSettings => 'إعدادات التطبيق';
  @override
  String get projectSettings => 'إعدادات المشروع';
  @override
  late final _TranslationsSettingsAppearanceAr appearance =
      _TranslationsSettingsAppearanceAr._(_root);
  @override
  late final _TranslationsSettingsGeneralAr general =
      _TranslationsSettingsGeneralAr._(_root);
  @override
  late final _TranslationsSettingsScopeAr scope =
      _TranslationsSettingsScopeAr._(_root);
  @override
  late final _TranslationsSettingsSearchKeywordsAr searchKeywords =
      _TranslationsSettingsSearchKeywordsAr._(_root);
  @override
  late final _TranslationsSettingsComparisonAr comparison =
      _TranslationsSettingsComparisonAr._(_root);
  @override
  late final _TranslationsSettingsFileHandlingAr fileHandling =
      _TranslationsSettingsFileHandlingAr._(_root);
  @override
  late final _TranslationsSettingsTranslationMemoryAr translationMemory =
      _TranslationsSettingsTranslationMemoryAr._(_root);
  @override
  late final _TranslationsSettingsBackupAr backup =
      _TranslationsSettingsBackupAr._(_root);
  @override
  late final _TranslationsSettingsAiAr ai = _TranslationsSettingsAiAr._(_root);
  @override
  late final _TranslationsSettingsIntegrationsAr integrations =
      _TranslationsSettingsIntegrationsAr._(_root);
  @override
  late final _TranslationsSettingsDeveloperAr developer =
      _TranslationsSettingsDeveloperAr._(_root);
  @override
  late final _TranslationsSettingsAboutAr about =
      _TranslationsSettingsAboutAr._(_root);
  @override
  late final _TranslationsSettingsSettingsViewAr settingsView =
      _TranslationsSettingsSettingsViewAr._(_root);
  @override
  late final _TranslationsSettingsOnboardingAr onboarding =
      _TranslationsSettingsOnboardingAr._(_root);
}

// Path: fileComparison
class _TranslationsFileComparisonAr implements TranslationsFileComparisonEn {
  _TranslationsFileComparisonAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'مقارنة الملفات';
  @override
  String get openFiles => 'فتح الملفات';
  @override
  String get exportResults => 'تصدير النتائج';
  @override
  String get restartTutorial => 'إعادة تشغيل البرنامج التعليمي';
  @override
  String get restartTutorialDevOnly =>
      'إعادة تشغيل البرنامج التعليمي متاح فقط في وضع المطور.';
  @override
  String get unsupportedFileType => 'نوع الملف غير مدعوم.';
  @override
  String get unsupportedFileTypeSuggestion => 'يرجى تحديد ملف توطين مدعوم.';
  @override
  String get someFilesUnsupported => 'بعض الملفات غير مدعومة.';
  @override
  String get pickSupportedFiles => 'اختر ملفات توطين مدعومة فقط.';
  @override
  String get pickTwoFiles => 'اختر ملفين للمقارنة.';
  @override
  String get pickBilingualFile => 'يرجى تحديد ملف ثنائي اللغة للمقارنة.';
  @override
  String get noResultsToExport => 'لا توجد نتائج للتصدير بعد.';
  @override
  String get performComparisonFirst => 'قم بإجراء مقارنة أولاً لتصدير النتائج.';
  @override
  String get performComparisonFirstEditor =>
      'يرجى إجراء مقارنة أولاً لرؤية التفاصيل المتقدمة.';
  @override
  String get sampleDataLoaded => 'تم تحميل بيانات العينة بنجاح';
  @override
  String loadSampleDataError({required Object error}) =>
      'فشل تحميل بيانات العينة: ${error}';
  @override
  String get invalidFileType => 'نوع ملف غير صالح.';
  @override
  String fileSelected({required Object label, required Object fileName}) =>
      'تم تحديد ${label}: ${fileName}';
  @override
  String get sourceFile => 'ملف المصدر';
  @override
  String get targetFile => 'ملف الهدف';
  @override
  String get bilingualFile => 'ملف ثنائي اللغة';
  @override
  String get compareFiles => 'مقارنة الملفات';
  @override
  String get compareFile => 'مقارنة الملف';
  @override
  String get bilingualMode => 'وضع ثنائي اللغة';
  @override
  String get twoFilesMode => 'ملفان';
  @override
  String get processing => 'جارٍ المعالجة...';
  @override
  String remaining({required Object time}) => 'متبقي ${time}';
  @override
  String get comparisonInProgress => 'المقارنة قيد التقدم...';
  @override
  String comparisonFailed({required Object error}) => 'فشلت المقارنة: ${error}';
  @override
  String fileChanged({required Object fileName}) =>
      'تم تغيير الملف: ${fileName}. إعادة المقارنة...';
  @override
  String get dropFileHere => 'أفلت الملف هنا';
  @override
  String get dropFileOrBrowse => 'أفلت الملف أو انقر للتصفح';
  @override
  String get fileUpload => 'تحميل ملف';
  @override
  String get changeFile => 'تغيير الملف';
  @override
  String get total => 'المجموع';
  @override
  String get show => 'عرض';
  @override
  String get showAll => 'عرض الكل';
  @override
  String noMatches({required Object query}) =>
      'لم يتم العثور على تطابقات لـ "${query}"';
  @override
  String showingEntries({required Object count, required Object total}) =>
      'عرض ${count} من ${total} إدخال';
  @override
  String get filesIdentical => 'الملفات متطابقة.';
  @override
  String hiddenIdentical({required Object count}) =>
      '${count} إدخالات متطابقة مخفية';
  @override
  String get showIdentical => 'إظهار الإدخالات المتطابقة';
  @override
  String get hideIdentical => 'إخفاء الإدخالات المتطابقة';
  @override
  String get noDiff => 'لم يتم العثور على فروق بناءً على المفاتيح.';
  @override
  String get source => 'المصدر';
  @override
  String get target => 'الهدف';
  @override
  String get value => 'القيمة';
  @override
  String get readyToCompare => 'جاهز لمقارنة الملفات';
  @override
  String get readyToCompareDesc =>
      'أفلت ملفات التوطين أعلاه أو استخدم أزرار التصفح\nلتحديد ملفات للمقارنة.';
  @override
  String get recentComparisons => 'المقارنات الأخيرة';
  @override
  String bilingualFileLabel({required Object name}) =>
      'ملف ثنائي اللغة: ${name}';
  @override
  String comparisonLabel({required Object source, required Object target}) =>
      '${source} ↔ ${target}';
  @override
  String get fileNotExist =>
      'أحد الملفين أو كلاهما من هذه الجلسة لم يعد موجوداً.';
  @override
  String get largeFileTitle => 'تم اكتشاف ملف كبير';
  @override
  String largeFileContent({required Object count}) =>
      'تحتوي نتيجة المقارنة على ${count} إدخال.\nعرض جميعها قد يسبب مشاكل في الأداء.\n\nهل تريد المتابعة؟';
  @override
  String get dontShowAgain => 'لا تظهر مرة أخرى لهذا الملف';
  @override
  String get proceed => 'متابعة';
  @override
  String exportReport({required Object format}) => 'حفظ تقرير ${format}';
  @override
  String saved({required Object format}) => 'تم حفظ ${format}';
  @override
  String saveError({required Object format}) => 'فشل حفظ ملف ${format}.';
  @override
  String saveErrorDetailed({required Object format, required Object error}) =>
      'فشل حفظ ${format}: ${error}';
  @override
  String get watching => 'مراقبة';
  @override
  String get watchOff => 'إيقاف المراقبة';
  @override
  String watchingTooltip({required Object status}) =>
      'مراقبة الملفات: ${status}\nإعادة المقارنة تلقائياً عند تغيير الملفات على القرص';
  @override
  String get aiSettingsNotAvailable =>
      'الانتقال إلى إعدادات الذكاء الاصطناعي غير متاح';
}

// Path: directoryComparison
class _TranslationsDirectoryComparisonAr
    implements TranslationsDirectoryComparisonEn {
  _TranslationsDirectoryComparisonAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'مقارنة الأدلة';
  @override
  String get sourceDirectory => 'دليل المصدر';
  @override
  String get targetDirectory => 'دليل الهدف';
  @override
  String get sourceSubtitle => 'ملفات الأصل/المرجع';
  @override
  String get targetSubtitle => 'ملفات الترجمة/المقارنة';
  @override
  String get selectBothDirectories => 'يرجى تحديد كلاً من دليل المصدر والهدف.';
  @override
  String get selectSourceFolder => 'تحديد مجلد المصدر';
  @override
  String get selectTargetFolder => 'تحديد مجلد الهدف';
  @override
  String get dropFolderHere => 'أفلت المجلد هنا أو تصفح...';
  @override
  String get folderPath => 'مسار المجلد';
  @override
  String get readyToCompare => 'جاهز لمقارنة الأدلة';
  @override
  String get readyToCompareDesc =>
      'أفلت المجلدات أعلاه أو استخدم أزرار التصفح\nلتحديد أدلة للمقارنة.';
  @override
  String get nestedFolders => 'مجلدات متداخلة';
  @override
  String get nestedFoldersTooltip => 'يقارن جميع الأدلة المتداخلة بشكل متكرر';
  @override
  String get fileMatching => 'مطابقة الملفات';
  @override
  String get fileMatchingTooltip => 'يقرن الملفات تلقائياً بالاسم';
  @override
  String get bulkExport => 'تصدير جماعي';
  @override
  String get bulkExportTooltip => 'تصدير جميع نتائج المقارنة دفعة واحدة';
  @override
  String get notDirectoryComparison => 'هذه ليست مقارنة أدلة.';
  @override
  String get directoriesNotExist => 'أحد الدليلين أو كلاهما لم يعد موجوداً.';
  @override
  String get errorOccurred => 'حدث خطأ';
  @override
  String get noFilesFound => 'لم يتم العثور على ملفات في الأدلة المحددة.';
  @override
  String get unmatchedSourceFiles => 'ملفات المصدر غير المتطابقة';
  @override
  String get unmatchedTargetFiles => 'ملفات الهدف غير المتطابقة';
  @override
  String filePairs({required Object count}) => '${count} أزواج ملفات';
  @override
  String pairedFiles({required Object count}) => 'الملفات المقترنة (${count})';
  @override
  String get view => 'عرض';
  @override
  String get failed => 'فشل';
  @override
  String get pair => 'اقتران...';
  @override
  String pairDialogTitle({required Object name}) => 'اقتران "${name}" مع:';
  @override
  String get discoverFiles => 'اكتشاف الملفات';
  @override
  String get compareAll => 'مقارنة الكل';
  @override
  String get exportAll => 'تصدير الكل';
  @override
  String get comparisonStarted => 'بدأت المقارنة...';
  @override
  String get discoveringFiles => 'جارٍ اكتشاف الملفات...';
  @override
  String get noResultsToExport =>
      'لا توجد نتائج مقارنة للتصدير. قم بتشغيل "مقارنة الكل" أولاً.';
  @override
  String get selectExportFolder => 'تحديد مجلد التصدير';
  @override
  String createExportFolderError({required Object error}) =>
      'فشل إنشاء مجلد التصدير: ${error}';
  @override
  String get exportingResults => 'جارٍ تصدير النتائج';
  @override
  String processingFile({required Object file}) => 'جارٍ المعالجة: ${file}';
  @override
  String exportProgress({required Object current, required Object total}) =>
      'تم تصدير ${current} من ${total} ملف';
  @override
  String get exportComplete => 'اكتمل التصدير';
  @override
  String exportSuccessMessage({required Object count}) =>
      'تم تصدير ${count} ملفات مقارنة بنجاح بالإضافة إلى الملخص.';
  @override
  String exportFailed({required Object error}) => 'فشل التصدير: ${error}';
  @override
  String get close => 'إغلاق';
}

// Path: gitComparison
class _TranslationsGitComparisonAr implements TranslationsGitComparisonEn {
  _TranslationsGitComparisonAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.';
  @override
  String get title => 'مقارنة المستودع';
  @override
  String get repoSelector => 'إنشاء / فتح مستودع';
  @override
  String get noRepoSelected => 'لم يتم تحديد مستودع';
  @override
  String get open => 'فتح';
  @override
  String get refreshCommits => 'تحديث الالتزامات (Commits)';
  @override
  String get noCommits =>
      'لم يتم العثور على التزامات أو تحميلها. حدد فرعاً لتحميل الالتزامات.';
  @override
  String get baseCommit => 'الالتزام الأساسي (الأقدم)';
  @override
  String get targetCommit => 'الالتزام المستهدف (الأحدث)';
  @override
  String get filterCommitsByBranch => 'تصفية الالتزامات حسب الفرع';
  @override
  String get conflictDetection => 'كشف التعارض';
  @override
  String get conflictDetectionTooltip => 'كشف وحل تعارضات الدمج';
  @override
  String get actions => 'إجراءات:';
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
  String mergeConfirmation({required Object branch}) => 'Merge ${branch}?';
  @override
  String get mergeWarning =>
      'سيؤدي هذا إلى دمج التغييرات في فرع العمل الحالي. قد تحدث تعارضات.';
  @override
  String get selectExportFolder => 'تحديد مجلد التصدير';
  @override
  String createExportFolderError({required Object error}) =>
      'فشل إنشاء مجلد التصدير: ${error}';
  @override
  String get exportingFiles => 'تصدير الملفات';
  @override
  String processingFile({required Object file}) => 'جارٍ المعالجة: ${file}';
  @override
  String exportProgress({required Object current, required Object total}) =>
      'تم تصدير ${current} من ${total} ملف';
  @override
  String get exportComplete => 'اكتمل التصدير';
  @override
  String exportSuccessMessage({required Object count}) =>
      'تم تصدير ${count} ملفات بنجاح بمحتوى كامل.';
  @override
  String get exportDetail => 'يتم حفظ فرق كل ملف في المجلد الفرعي "files".';
  @override
  String get diffViewer => 'عارض الفرق';
  @override
  String get base => 'BASE';
  @override
  String get target => 'TARGET';
  @override
  String get noLines => 'لا توجد خطوط للعرض';
  @override
  String get searchFiles => 'بحث في الملفات...';
  @override
  String noFilesMatch({required Object query}) =>
      'لا توجد ملفات تطابق "${query}"';
  @override
  String filesCount({required Object count}) => '${count} ملفات';
  @override
  String get selectBaseFile => 'تحديد ملف القاعدة';
  @override
  String get selectTargetFile => 'تحديد ملف الهدف';
  @override
  String get comparisonResults => 'نتائج المقارنة';
  @override
  String get noChanges => 'لم يتم العثور على تغييرات بين المراجع المحددة.';
  @override
  String get linesAdded => 'خطوط مضافة';
  @override
  String get linesRemoved => 'خطوط محذوفة';
  @override
  String get commit => 'Commit';
  @override
  String get branch => 'Branch';
  @override
  String get noRepositorySelected => 'لم يتم تحديد مستودع';
  @override
  String get notGitComparison => 'ليست مقارنة Git';
  @override
  String get repositoryNotExist => 'المستودع غير موجود';
  @override
  String get mainBranch => 'main';
  @override
  String get masterBranch => 'master';
  @override
  String get backToControls => 'عودة إلى عناصر تحكم المقارنة';
}

// Path: advancedComparison
class _TranslationsAdvancedComparisonAr
    implements TranslationsAdvancedComparisonEn {
  _TranslationsAdvancedComparisonAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get placeholder => 'عرض مقارنة متقدم - عنصر نائب';
}

// Path: advancedDiff
class _TranslationsAdvancedDiffAr implements TranslationsAdvancedDiffEn {
  _TranslationsAdvancedDiffAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get saveAllChanges => 'حفظ جميع التغييرات؟';
  @override
  String saveConfirmation({required Object count}) =>
      'سيؤدي هذا إلى حفظ جميع الإدخالات المعدلة البالغ عددها ${count} في ملف الهدف. هذا الإجراء لا يمكن التراجع عنه.';
  @override
  String get changesSaved => 'تم حفظ التغييرات بنجاح.';
  @override
  String get csvExported => 'تم تصدير CSV';
  @override
  String get unsavedChanges => 'تغييرات غير محفوظة';
  @override
  String get unsavedChangesWarning =>
      'لديك تغييرات غير محفوظة. هل أنت متأكد أنك تريد تجاهلها؟';
  @override
  String get discardChanges => 'تجاهل التغييرات';
  @override
  String get goBack => 'رجوع';
  @override
  String get breadcrumbs => 'الرئيسية > المحرر';
  @override
  String unsaved({required Object count}) => '${count} غير محفوظ';
  @override
  String reviewed({required Object count}) => '${count} تمت مراجعته';
  @override
  String saveAll({required Object count}) => 'حفظ الكل (${count})';
  @override
  String get allSaved => 'تم حفظ الكل';
  @override
  String get saveAllTooltip => 'حفظ جميع التغييرات (Ctrl+S)';
  @override
  String get exportTooltip => 'تصدير البيانات (Ctrl+E)';
  @override
  late final _TranslationsAdvancedDiffAiSuggestionAr aiSuggestion =
      _TranslationsAdvancedDiffAiSuggestionAr._(_root);
  @override
  late final _TranslationsAdvancedDiffDetailEditAr detailEdit =
      _TranslationsAdvancedDiffDetailEditAr._(_root);
  @override
  late final _TranslationsAdvancedDiffTableAr table =
      _TranslationsAdvancedDiffTableAr._(_root);
  @override
  late final _TranslationsAdvancedDiffDiffRowAr diffRow =
      _TranslationsAdvancedDiffDiffRowAr._(_root);
  @override
  late final _TranslationsAdvancedDiffStatusAr status =
      _TranslationsAdvancedDiffStatusAr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarAr sidebar =
      _TranslationsAdvancedDiffSidebarAr._(_root);
}

// Path: issueDetails
class _TranslationsIssueDetailsAr implements TranslationsIssueDetailsEn {
  _TranslationsIssueDetailsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'تفاصيل المشكلة';
  @override
  String showingIssues({required Object count, required Object total}) =>
      'عرض ${count} من ${total} مشكلة';
  @override
  String get searchPlaceholder => 'بحث بالمفتاح، النص، أو الخطأ...';
  @override
  String get noDetails => 'لا توجد تفاصيل متوفرة.';
  @override
  String get noMatches => 'لم يتم العثور على تطابقات.';
  @override
  String get showMore => 'إظهار المزيد';
  @override
  String copyItems({required Object count}) => 'نسخ ${count} عنصر';
  @override
  String get close => 'إغلاق';
  @override
  String get copied => 'تم النسخ إلى الحافظة';
  @override
  String copiedCount({required Object count}) => 'تم نسخ ${count} عنصر';
  @override
  late final _TranslationsIssueDetailsDuplicateValueAr duplicateValue =
      _TranslationsIssueDetailsDuplicateValueAr._(_root);
  @override
  late final _TranslationsIssueDetailsLengthOutlierAr lengthOutlier =
      _TranslationsIssueDetailsLengthOutlierAr._(_root);
  @override
  late final _TranslationsIssueDetailsStandardAr standard =
      _TranslationsIssueDetailsStandardAr._(_root);
  @override
  String get review => 'مراجعة';
  @override
  late final _TranslationsIssueDetailsTypesAr types =
      _TranslationsIssueDetailsTypesAr._(_root);
  @override
  late final _TranslationsIssueDetailsNotesAr notes =
      _TranslationsIssueDetailsNotesAr._(_root);
  @override
  late final _TranslationsIssueDetailsFallbacksAr fallbacks =
      _TranslationsIssueDetailsFallbacksAr._(_root);
}

// Path: importReview
class _TranslationsImportReviewAr implements TranslationsImportReviewEn {
  _TranslationsImportReviewAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'مراجعة استيراد المشروع';
  @override
  String get projectName => 'اسم المشروع';
  @override
  String get created => 'تم الإنشاء';
  @override
  String get historyItems => 'عناصر السجل';
  @override
  String get customSettingsTitle => 'تم اكتشاف إعدادات مخصصة';
  @override
  String get customSettingsWarning =>
      'يحتوي هذا المشروع على إعدادات مخصصة ستتجاوز افتراضياتك أثناء فتح هذا المشروع.';
  @override
  String get standardSettings =>
      'يستخدم هذا المشروع الإعدادات العالمية القياسية.';
  @override
  String get cancelImport => 'إلغاء الاستيراد';
  @override
  String get trustOpen => 'ثقة وفتح المشروع';
}

// Path: historyView
class _TranslationsHistoryViewAr implements TranslationsHistoryViewEn {
  _TranslationsHistoryViewAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'سجل المقارنة';
  @override
  String get clearAll => 'مسح كل السجل';
  @override
  String get searchPlaceholder => 'بحث باسم الملف...';
  @override
  String get sortBy => 'فرز حسب';
  @override
  String get sortDate => 'التاريخ';
  @override
  String get sortSource => 'ملف المصدر';
  @override
  String get sortTarget => 'ملف الهدف';
  @override
  String get showCurrentProject => 'عرض: المشروع الحالي';
  @override
  String get showAllHistory => 'عرض: كل السجل';
  @override
  String get groupByFolder => 'تجميع حسب المجلد';
  @override
  String get disableGrouping => 'تعطيل تجميع المجلدات';
  @override
  String get filterAll => 'الكل';
  @override
  String get filterFiles => 'ملفات';
  @override
  String get filterDirectories => 'أدلة';
  @override
  String get filterGit => 'Git';
  @override
  String get noHistory => 'لا يوجد سجل مقارنة بعد';
  @override
  String get historyDescription => 'ستظهر مقارنات ملفاتك هنا';
  @override
  String get noResults => 'لا توجد نتائج';
  @override
  String get adjustSearch => 'حاول تعديل بحثك';
  @override
  String get clearConfirmationTitle => 'مسح كل السجل؟';
  @override
  String get clearConfirmationContent =>
      'سيؤدي هذا إلى حذف كل سجل المقارنة بشكل دائم. هذا الإجراء لا يمكن التراجع عنه.';
  @override
  String get clearAction => 'مسح الكل';
  @override
  String get deletedMessage => 'تم حذف عنصر السجل';
  @override
  String get undo => 'تراجع';
  @override
  String get viewDetails => 'عرض التفاصيل';
  @override
  String get delete => 'حذف';
  @override
  String get openLocation => 'فتح موقع الملف';
  @override
  String get bilingual => 'ثنائي اللغة';
  @override
  String get filePair => 'زوج ملفات';
  @override
  String get directory => 'دليل';
  @override
  String get git => 'Git';
  @override
  String get repo => 'مستودع';
  @override
  String get sourceDir => 'دليل المصدر';
  @override
  String get targetDir => 'دليل الهدف';
  @override
  String get source => 'المصدر';
  @override
  String get target => 'الهدف';
  @override
  String get noChanges => 'لم يتم اكتشاف تغييرات';
  @override
  String get added => 'مضاف';
  @override
  String get removed => 'محذوف';
  @override
  String get modified => 'معدل';
  @override
  String get same => 'نفسه';
  @override
  String get total => 'المجموع';
  @override
  String get currentProject => 'المشروع الحالي';
  @override
  String get unassigned => 'غير معين';
  @override
  String get project => 'المشروع';
}

// Path: compare
class _TranslationsCompareAr implements TranslationsCompareEn {
  _TranslationsCompareAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'مقارنة الملفات';
  @override
  String get sourceFile => 'ملف المصدر';
  @override
  String get targetFile => 'ملف الهدف';
  @override
  String get sourceFolder => 'مجلد المصدر';
  @override
  String get targetFolder => 'مجلد الهدف';
  @override
  String get dropFilesHint =>
      'أفلت ملفات التوطين هنا أو استخدم أزرار التصفح لتحديد ملفات للمقارنة.';
  @override
  String get selectSourceFile => 'تحديد ملف المصدر';
  @override
  String get selectTargetFile => 'تحديد ملف الهدف';
  @override
  String get startComparison => 'بدء المقارنة';
  @override
  String get comparing => 'جارٍ المقارنة...';
  @override
  String get comparisonComplete => 'اكتملت المقارنة';
  @override
  String get noChanges => 'لم يتم اكتشاف تغييرات';
  @override
  String get filesIdentical => 'الملفات متطابقة';
  @override
  String changesFound({required Object count}) =>
      'تم العثور على ${count} تغييرات';
  @override
  late final _TranslationsCompareTabsAr tabs =
      _TranslationsCompareTabsAr._(_root);
  @override
  late final _TranslationsCompareFileTypesAr fileTypes =
      _TranslationsCompareFileTypesAr._(_root);
}

// Path: history
class _TranslationsHistoryAr implements TranslationsHistoryEn {
  _TranslationsHistoryAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'السجل';
  @override
  String get recentComparisons => 'المقارنات الأخيرة';
  @override
  String get noHistory => 'لا يوجد سجل مقارنة بعد';
  @override
  String get noHistoryDescription => 'سيظهر سجل مقارنتك هنا';
  @override
  String get clearHistory => 'مسح السجل';
  @override
  String get clearHistoryConfirm => 'هل أنت متأكد أنك تريد مسح كل السجل؟';
  @override
  String get deleteEntry => 'حذف الإدخال';
  @override
  String get openComparison => 'فتح المقارنة';
  @override
  late final _TranslationsHistoryTimeAgoAr timeAgo =
      _TranslationsHistoryTimeAgoAr._(_root);
}

// Path: projects
class _TranslationsProjectsAr implements TranslationsProjectsEn {
  _TranslationsProjectsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'المشاريع';
  @override
  String get createProject => 'إنشاء مشروع';
  @override
  String get importProject => 'استيراد مشروع';
  @override
  String get noProjects => 'لا توجد مشاريع بعد';
  @override
  String get noProjectsDescription =>
      'أنشئ مشروعاً لتنظيم ملفات التوطين الخاصة بك';
  @override
  String get projectName => 'اسم المشروع';
  @override
  String get projectPath => 'مسار المشروع';
  @override
  String get lastOpened => 'آخر فتح';
  @override
  String get openProject => 'فتح المشروع';
  @override
  String get closeProject => 'إغلاق المشروع';
  @override
  String get deleteProject => 'حذف المشروع';
  @override
  String get deleteProjectConfirm => 'هل أنت متأكد أنك تريد حذف هذا المشروع؟';
  @override
  String get exportProject => 'تصدير المشروع';
  @override
  String get exportDescription =>
      'إنشاء ملف مضغوط محمول يحتوي على ملفات المصدر، التكوين، والسجل.';
  @override
  String get exporting => 'جارٍ تصدير المشروع...';
  @override
  String get exportSuccess => 'تم تصدير المشروع';
  @override
  String exportError({required Object error}) => 'فشل التصدير: ${error}';
  @override
  String get createNewProject => 'إنشاء مشروع جديد';
  @override
  String get openExistingProject => 'فتح مشروع موجود';
  @override
  String get importProjectZip => 'استيراد ملف مضغوط للمشروع';
  @override
  String get projectResources => 'موارد المشروع';
  @override
  String get recentProjects => 'المشاريع الأخيرة';
  @override
  String get noRecentProjects => 'لا توجد مشاريع حديثة';
  @override
  String get selectProjectZip => 'تحديد ملف مضغوط للمشروع';
  @override
  String get selectDestination => 'تحديد مجلد الوجهة للاستيراد';
  @override
  String get importing => 'جارٍ استيراد المشروع...';
  @override
  String get importSuccess => 'تم استيراد المشروع بنجاح';
  @override
  String importFailed({required Object error}) => 'فشل الاستيراد: ${error}';
  @override
  String get importingFiles => 'جارٍ استيراد الملفات...';
  @override
  String get noSupportedFiles => 'لم يتم إفلات أي ملفات مدعومة.';
  @override
  late final _TranslationsProjectsStatsAr stats =
      _TranslationsProjectsStatsAr._(_root);
  @override
  String get openProjectFirst => 'افتح مشروعاً أولاً لإدارة موارده.';
  @override
  String get removeFromRecent => 'إزالة من الحديثة';
  @override
  late final _TranslationsProjectsSelectionAr selection =
      _TranslationsProjectsSelectionAr._(_root);
  @override
  late final _TranslationsProjectsCreateDialogAr createDialog =
      _TranslationsProjectsCreateDialogAr._(_root);
  @override
  late final _TranslationsProjectsIndicatorAr indicator =
      _TranslationsProjectsIndicatorAr._(_root);
  @override
  late final _TranslationsProjectsGlossaryAr glossary =
      _TranslationsProjectsGlossaryAr._(_root);
  @override
  late final _TranslationsProjectsConflictsAr conflicts =
      _TranslationsProjectsConflictsAr._(_root);
  @override
  late final _TranslationsProjectsTmAr tm = _TranslationsProjectsTmAr._(_root);
}

// Path: diff
class _TranslationsDiffAr implements TranslationsDiffEn {
  _TranslationsDiffAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'مضاف';
  @override
  String get removed => 'محذوف';
  @override
  String get modified => 'معدل';
  @override
  String get unchanged => 'غير متغير';
  @override
  String get missing => 'مفقود';
  @override
  String get extra => 'إضافي';
  @override
  String get sourceValue => 'قيمة المصدر';
  @override
  String get targetValue => 'قيمة الهدف';
  @override
  String get key => 'المفتاح';
  @override
  String get status => 'الحالة';
  @override
  String get actions => 'إجراءات';
  @override
  String get copyToTarget => 'نسخ إلى الهدف';
  @override
  String get acceptChange => 'قبول التغيير';
  @override
  String get rejectChange => 'رفض التغيير';
  @override
  String get viewDetails => 'عرض التفاصيل';
}

// Path: git
class _TranslationsGitAr implements TranslationsGitEn {
  _TranslationsGitAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'مقارنة Git';
  @override
  String get selectRepository => 'تحديد المستودع';
  @override
  String get selectBranch => 'تحديد الفرع';
  @override
  String get selectCommit => 'تحديد الالتزام (Commit)';
  @override
  String get compareBranches => 'مقارنة الفروع';
  @override
  String get compareCommits => 'مقارنة الالتزامات';
  @override
  String get baseBranch => 'الفرع الأساسي';
  @override
  String get compareBranch => 'فرع المقارنة';
  @override
  String get noRepositories => 'لم يتم العثور على مستودعات Git';
  @override
  String get noRepositoriesDescription => 'افتح مجلداً يحتوي على مستودع Git';
  @override
  String filesChanged({required Object count}) => 'تم تغيير ${count} ملف';
  @override
  String additions({required Object count}) => '${count} إضافات';
  @override
  String deletions({required Object count}) => '${count} عمليات حذف';
  @override
  late final _TranslationsGitConflictsAr conflicts =
      _TranslationsGitConflictsAr._(_root);
}

// Path: quality
class _TranslationsQualityAr implements TranslationsQualityEn {
  _TranslationsQualityAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.';
  @override
  String get title => 'لوحة الجودة';
  @override
  String get overallScore => 'النتيجة الإجمالية';
  @override
  String get issues => 'مشاك';
  @override
  String get warnings => 'تحذيرات';
  @override
  String get suggestions => 'اقتراحات';
  @override
  String get placeholderMismatch => 'عدم تطابق العناصر النائبة';
  @override
  String get placeholderMismatchDescription =>
      'العناصر النائبة مثل {name} لا تتطابق بين المصدر والهدف';
  @override
  String get lengthOutlier => 'طول شاذ';
  @override
  String get lengthOutlierDescription =>
      'يختلف طول الترجمة بشكل كبير عن المصدر';
  @override
  String get duplicateValue => 'قيمة مكررة';
  @override
  String get duplicateValueDescription => 'نفس الترجمة مستخدمة لمفاتيح متعددة';
  @override
  String get missingTranslation => 'ترجمة مفقودة';
  @override
  String get missingTranslationDescription => 'الترجمة مفقودة لهذا المفتاح';
  @override
  String get loading => 'جارٍ تحميل لوحة القيادة...';
  @override
  String get errorLoading => 'لم نتمكن من تحميل سجلك. حاول مرة أخرى.';
  @override
  String get emptyState => 'قم بإجراء مقارنة لرؤية لوحة القيادة الخاصة بك.';
  @override
  String get refresh => 'تحديث';
  @override
  String get buildingInsights => 'بناء الرؤى...';
  @override
  String get crunchingNumbers => 'معالجة الأرقام...';
  @override
  String get errorBuilding => 'لم نتمكن من بناء لوحة القيادة. حاول مرة أخرى.';
  @override
  String get noUsableData => 'لم يتم العثور على بيانات قابلة للاستخدام بعد.';
  @override
  String get languages => 'اللغات';
  @override
  String get averageCoverage => 'متوسط التغطية';
  @override
  String get potentialIssues => 'مشاكل محتملة';
  @override
  String get translationCoverage => 'تغطية الترجمة';
  @override
  String entriesTranslated(
          {required Object translated, required Object total}) =>
      'تم ترجمة ${translated} من ${total} إدخال';
  @override
  String get wordsAddedOverTime => 'الكلمات المضافة مع مرور الوقت';
  @override
  String get completionVsScope => 'الاكتمال مقابل النطاق';
  @override
  String get scopeVsProgress => 'النطاق مقابل التقدم';
  @override
  String get coveragePercent => 'التغطية %';
  @override
  String get wordsAdded => 'كلمات مضافة';
  @override
  String get words => 'كلمات';
  @override
  String get coverage => 'تغطية';
  @override
  String get scope => 'نطاق';
  @override
  String get latest => 'الأحدث';
  @override
  String get added => 'مضاف';
  @override
  String get change => 'تغيير';
  @override
  String get totalScope => 'النطاق الإجمالي';
  @override
  String wordsCount({required Object count}) => '${count} كلمة';
  @override
  String get scopeGrowth => 'نمو النطاق';
  @override
  String get range => 'النطاق';
  @override
  String get aiUsage => 'استخدام الذكاء الاصطناعي والترجمة';
  @override
  String lastUsed({required Object date}) => 'آخر استخدام ${date}';
  @override
  String get noIssuesFound => 'لم يتم العثور على مشاكل في أحدث المقارنات.';
  @override
  String get placeholderMismatches => 'عدم تطابق العناصر النائبة';
  @override
  String get placeholderMismatchesDesc => 'العلامات مثل {name} لا تتطابق.';
  @override
  String get lengthOutliers => 'ترجمات قصيرة جداً أو طويلة جداً';
  @override
  String get lengthOutliersDesc => 'يبدو الطول غير عادي مقارنة بالمصدر.';
  @override
  String get duplicateValues => 'قيم مكررة';
  @override
  String get duplicateValuesDesc => 'يتم استخدام نفس الترجمة مرات عديدة.';
  @override
  String get placeholderDialogTitle => 'عدم تطابق العناصر النائبة';
  @override
  String get placeholderDialogDesc =>
      'تحتوي هذه الترجمات على عناصر نائبة ({name}) مختلفة عن المصدر.';
  @override
  String get lengthDialogTitle => 'طول شاذ';
  @override
  String get lengthDialogDesc => 'هذه الترجمات أقصر أو أطول بكثير من المصدر.';
  @override
  String get duplicateDialogTitle => 'قيم مكررة';
  @override
  String get duplicateDialogDesc => 'تظهر هذه الترجمات عدة مرات.';
  @override
  String duplicateSample({required Object value}) => 'مكرر: "${value}"';
  @override
  String get exportError => 'تعذر بناء التقرير. يرجى المحاولة مرة أخرى.';
  @override
  String get noDataToExport => 'لا توجد بيانات للتصدير';
  @override
  String get exportFailed => 'فشل التصدير';
  @override
  String get exportDialogTitle => 'تصدير تقرير الجودة';
  @override
  String get reportSaved => 'تم حفظ التقرير';
  @override
  String get export => 'تصدير';
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
  String get showingCurrentProject => 'عرض: المشروع الحالي';
  @override
  String get showingAllHistory => 'عرض: كل السجل';
  @override
  String get filesSkipped => 'تم تخطي بعض الملفات لعدم العثور عليها.';
  @override
  String charCount({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        n,
        one: 'حرف واحد',
        other: '${count} أحرف',
      );
  @override
  String lengthDiff(
          {required Object target,
          required Object percent,
          required Object source}) =>
      'الهدف ${target} (${percent}%) مقابل المصدر ${source}';
}

// Path: errors
class _TranslationsErrorsAr implements TranslationsErrorsEn {
  _TranslationsErrorsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get genericError => 'حدث خطأ';
  @override
  String get fileNotFound => 'لم يتم العثور على الملف';
  @override
  String get invalidFormat => 'تنسيق ملف غير صالح';
  @override
  String get parseError => 'فشل تحليل الملف';
  @override
  String get networkError => 'خطأ في الشبكة. يرجى التحقق من اتصالك.';
  @override
  String get permissionDenied => 'تم رفض الإذن';
  @override
  String get unknownError => 'حدث خطأ غير متوقع';
}

// Path: wizards
class _TranslationsWizardsAr implements TranslationsWizardsEn {
  _TranslationsWizardsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsWizardsFirstRunAr firstRun =
      _TranslationsWizardsFirstRunAr._(_root);
}

// Path: dialogs
class _TranslationsDialogsAr implements TranslationsDialogsEn {
  _TranslationsDialogsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDialogsAddIgnorePatternAr addIgnorePattern =
      _TranslationsDialogsAddIgnorePatternAr._(_root);
  @override
  late final _TranslationsDialogsDiffViewerAr diffViewer =
      _TranslationsDialogsDiffViewerAr._(_root);
}

// Path: grid
class _TranslationsGridAr implements TranslationsGridEn {
  _TranslationsGridAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGridColumnsAr columns =
      _TranslationsGridColumnsAr._(_root);
}

// Path: tutorial
class _TranslationsTutorialAr implements TranslationsTutorialEn {
  _TranslationsTutorialAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'تخطي التعليم';
  @override
  String get finishMessage => 'أنت جاهز تماماً! انقر في أي مكان للإنهاء.';
  @override
  String get next => 'التالي';
  @override
  String get loadSampleData => 'تحميل بيانات العينة';
  @override
  String get browseSourceFile => 'تصفح ملف المصدر';
  @override
  String get browseTargetFile => 'تصفح ملف الهدف';
  @override
  String get compareFiles => 'مقارنة الملفات';
  @override
  String get hintPhase2 => 'التالي: الفلاتر، البحث، العرض المتقدم، والتصدير.';
  @override
  late final _TranslationsTutorialStepsAr steps =
      _TranslationsTutorialStepsAr._(_root);
}

// Path: friendlyErrors
class _TranslationsFriendlyErrorsAr implements TranslationsFriendlyErrorsEn {
  _TranslationsFriendlyErrorsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsFriendlyErrorsFileNotFoundAr fileNotFound =
      _TranslationsFriendlyErrorsFileNotFoundAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsAccessDeniedAr accessDenied =
      _TranslationsFriendlyErrorsAccessDeniedAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsIsDirectoryAr isDirectory =
      _TranslationsFriendlyErrorsIsDirectoryAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsFileAccessAr fileAccess =
      _TranslationsFriendlyErrorsFileAccessAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsUnsupportedFormatAr unsupportedFormat =
      _TranslationsFriendlyErrorsUnsupportedFormatAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsNetworkErrorAr networkError =
      _TranslationsFriendlyErrorsNetworkErrorAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsNotGitRepoAr notGitRepo =
      _TranslationsFriendlyErrorsNotGitRepoAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsMergeConflictAr mergeConflict =
      _TranslationsFriendlyErrorsMergeConflictAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitAuthFailedAr gitAuthFailed =
      _TranslationsFriendlyErrorsGitAuthFailedAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitOperationFailedAr
      gitOperationFailed =
      _TranslationsFriendlyErrorsGitOperationFailedAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidJsonAr invalidJson =
      _TranslationsFriendlyErrorsInvalidJsonAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsRateLimitReachedAr rateLimitReached =
      _TranslationsFriendlyErrorsRateLimitReachedAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidApiKeyAr invalidApiKey =
      _TranslationsFriendlyErrorsInvalidApiKeyAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsTranslationServiceErrorAr
      translationServiceError =
      _TranslationsFriendlyErrorsTranslationServiceErrorAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsOutOfMemoryAr outOfMemory =
      _TranslationsFriendlyErrorsOutOfMemoryAr._(_root);
  @override
  late final _TranslationsFriendlyErrorsGenericErrorAr genericError =
      _TranslationsFriendlyErrorsGenericErrorAr._(_root);
}

// Path: systemTray
class _TranslationsSystemTrayAr implements TranslationsSystemTrayEn {
  _TranslationsSystemTrayAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get showLocalizer => 'إظهار Localizer';
  @override
  String get exit => 'خروج';
}

// Path: validation
class _TranslationsValidationAr implements TranslationsValidationEn {
  _TranslationsValidationAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get connected => 'متصل.';
  @override
  String get connectionTimeout => 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.';
  @override
  String get couldNotConnect => 'تعذر الاتصال. يرجى المحاولة مرة أخرى.';
  @override
  String get checkKeyAndTryAgain =>
      'تعذر الاتصال. يرجى التحقق من المفتاح والمحاولة مرة أخرى.';
  @override
  String get tryAgainLater =>
      'تعذر الاتصال الآن. يرجى المحاولة مرة أخرى لاحقاً.';
  @override
  String get serviceUnavailable =>
      'الخدمة غير متوفرة الآن. يرجى المحاولة مرة أخرى لاحقاً.';
  @override
  String get enterKeyFirst => 'يرجى إدخال مفتاح أولاً.';
  @override
  String get checking => 'جارٍ التحقق...';
  @override
  String deeplUsage({required Object used, required Object limit}) =>
      'الاستخدام: ${used} / ${limit} حرف.';
}

// Path: status
class _TranslationsStatusAr implements TranslationsStatusEn {
  _TranslationsStatusAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get startingComparison => 'جارٍ بدء المقارنة...';
  @override
  String get loadingFromHistory => 'جارٍ تحميل الملفات من السجل...';
  @override
  String get comparisonComplete => 'اكتملت المقارنة';
  @override
  String get couldNotImportFiles =>
      'تعذر استيراد الملفات. يرجى المحاولة مرة أخرى.';
  @override
  String get historyFilesNotFound =>
      'لم يتم العثور على أحد الملفين أو كلاهما من السجل في المسارات الأصلية.';
}

// Path: aiServices
class _TranslationsAiServicesAr implements TranslationsAiServicesEn {
  _TranslationsAiServicesAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get geminiEmptyResponse => 'أعاد Gemini استجابة فارغة';
  @override
  String get geminiStreamingEmpty =>
      'أعاد البث المباشر لـ Gemini استجابة فارغة';
  @override
  String get geminiRephraseEmpty => 'أعاد Gemini استجابة فارغة لإعادة الصياغة';
  @override
  String get openaiEmptyResponse => 'أعاد OpenAI استجابة فارغة أو فاشلة';
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceAr
    implements TranslationsSettingsAppearanceEn {
  _TranslationsSettingsAppearanceAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'المظهر';
  @override
  String get description => 'تخصيص شكل ومظهر التطبيق';
  @override
  String get theme => 'وضع المظهر';
  @override
  String get themeDescription => 'اختر بين الفاتح، الداكن، أو مظهر النظام';
  @override
  String get themeSystem => 'النظام';
  @override
  String get themeLight => 'فاتح';
  @override
  String get themeDark => 'داكن';
  @override
  String get themeAmoled => 'AMOLED';
  @override
  String get accentColor => 'لون التمييز';
  @override
  String get accentColorDescription => 'اختر لون التمييز المفضل لديك';
  @override
  String get useMicaEffect => 'استخدام تأثير Mica';
  @override
  String get micaDescription =>
      'تفعيل تأثير شفافية Mica الخاص بـ Windows 11 لمظهر عصري';
  @override
  String get diffFontSize => 'حجم خط المقارنة';
  @override
  String get diffFontSizeDescription => 'ضبط حجم الخط في عرض المقارنة';
  @override
  String get diffFontFamily => 'خط المقارنة';
  @override
  String get diffFontFamilyDescription => 'الخط المستخدم في عرض المقارنة';
  @override
  String get systemDefault => 'افتراضي النظام';
  @override
  String get pickAccentColor => 'اختر لون التمييز';
  @override
  String get diffColors => 'ألوان المقارنة';
  @override
  String get presetsTitle => 'إعدادات مسبقة';
  @override
  late final _TranslationsSettingsAppearancePresetsAr presets =
      _TranslationsSettingsAppearancePresetsAr._(_root);
  @override
  String get identical => 'متطابق';
  @override
  String pickColorFor({required Object label}) => 'اختر لون لـ ${label}';
  @override
  String get livePreview => 'معاينة حية';
  @override
  late final _TranslationsSettingsAppearancePreviewAr preview =
      _TranslationsSettingsAppearancePreviewAr._(_root);
}

// Path: settings.general
class _TranslationsSettingsGeneralAr implements TranslationsSettingsGeneralEn {
  _TranslationsSettingsGeneralAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'عام';
  @override
  String get description => 'إعدادات التطبيق العامة';
  @override
  String get language => 'الغة';
  @override
  String get languageDescription => 'اختر لغتك المفضلة';
  @override
  String get startMinimized => 'بدء مصغر في علبة النظام';
  @override
  String get startMinimizedDescription =>
      'بدء تشغيل التطبيق مصغراً في علبة النظام';
  @override
  String get rememberWindowPosition => 'تذكر موقع النافذة';
  @override
  String get rememberWindowPositionDescription =>
      'استعادة حجم وموقع النافذة عند بدء التشغيل';
  @override
  String get openLastProject => 'فتح آخر مشروع عند البدء';
  @override
  String get openLastProjectDescription =>
      'فتح آخر مشروع مستخدم تلقائياً عند بدء تشغيل التطبيق';
  @override
  String get application => 'التطبيق';
  @override
  String get defaultView => 'العرض الافتراضي';
  @override
  String get defaultViewDescription => 'العرض الذي يظهر عند بدء التشغيل';
  @override
  String get autoCheckUpdates => 'التحقق التلقائي من التحديثات';
  @override
  String get autoCheckUpdatesDescription =>
      'التحقق من وجود تحديثات عند بدء التشغيل';
  @override
  String get startupOptions => 'خيارات بدء التشغيل';
  @override
  String get languageAuto => 'اكتشاف تلقائي';
  @override
  String get viewBasic => 'مقارنة الملفات';
  @override
  String get viewHistory => 'السجل';
  @override
  String get viewDashboard => 'لوحة الجودة';
  @override
  String get viewDirectory => 'مقارنة الأدلة';
  @override
  String get viewLastUsed => 'آخر عرض مستخدم';
}

// Path: settings.scope
class _TranslationsSettingsScopeAr implements TranslationsSettingsScopeEn {
  _TranslationsSettingsScopeAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'نطاق الإعدادات';
  @override
  String get global => 'الافتراضيات العالمية';
  @override
  String get project => 'المشروع';
  @override
  String get reset => 'إعادة تعيين المشروع للافتراضيات العالمية';
  @override
  String get resetConfirmation =>
      'سيؤدي هذا إلى مسح جميع التجاوزات لهذا المشروع والعودة إلى الافتراضيات العالمية. هذا الإجراء لا يمكن التراجع عنه.';
  @override
  String get globalDescription =>
      'تنطبق التغييرات على جميع المشاريع ما لم يتم تجاوزها.';
  @override
  String projectDescription({required Object name}) =>
      'تنطبق التغييرات فقط على "${name}". الإعدادات الأخرى ترث من الافتراضيات العالمية.';
  @override
  String get createPrompt => 'أنشئ مشروعاً لتخصيص الإعدادات لمجلدات محددة';
}

// Path: settings.searchKeywords
class _TranslationsSettingsSearchKeywordsAr
    implements TranslationsSettingsSearchKeywordsEn {
  _TranslationsSettingsSearchKeywordsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  List<String> get general => [
        'اللغة',
        'العرض الافتراضي',
        'عدد الملفات الحديثة',
        'فتح آخر مشروع',
        'تأكيد قبل الخروج',
        'إظهار الإشعارات',
      ];
  @override
  List<String> get comparisonEngine => [
        'وضع المقارنة',
        'عتبة التشابه',
        'حساس لحالة الأحرف',
        'تجاهل المسافات البيضاء',
        'تجاهل الأسطر الفارغة',
        'تجاهل التعليقات',
        'تجاهل الأنماط',
      ];
  @override
  List<String> get appearance => [
        'المظهر',
        'وضع المظهر',
        'لون التمييز',
        'حجم خط المقارنة',
        'خط المقارنة',
        'ألوان المقارنة',
        'لون المضاف',
        'لون المحذوف',
        'لون المعدل',
        'لون المتطابق',
        'إعدادات الألوان المسبقة',
        'معاينة',
      ];
  @override
  List<String> get fileHandling => [
        'تنسيق المصدر',
        'تنسيق الهدف',
        'الترميز الافتراضي',
        'عدد المشاريع الحديثة',
        'ذاكرة الترجمة',
        'استيراد الذاكرة',
        'تصدير الذاكرة',
        'مسح الذاكرة',
      ];
  @override
  List<String> get aiServices => [
        'مفتاح واجهة برمجة تطبيقات OpenAI',
        'مفتاح واجهة برمجة تطبيقات Anthropic',
        'مفتاح واجهة برمجة تطبيقات Google AI',
        'نموذج الذكاء الاصطناعي',
        'درجة الحرارة',
        'موجه مخصص',
      ];
  @override
  List<String> get systemIntegrations => [
        'علبة النظام',
        'بدء مصغر',
        'ارتباطات الملفات',
        'تأثير Mica',
        'الحيوية',
        'مادة النافذة',
        'شارة الرصيف',
        'عدد غير المترجمة',
      ];
  @override
  List<String> get projectResources => [
        'مسرد المصطلحات',
        'ذاكرة الترجمة',
        'المصطلحات',
      ];
  @override
  List<String> get about => [
        'الإصدار',
        'التحقق من التحديثات',
        'تحديث تلقائي',
        'سجل التغييرات',
        'الرخصة',
        'سياسة الخصوصية',
        'القياس عن بعد',
        'الإبلاغ عن الأعطال',
      ];
  @override
  List<String> get developer => [
        'تراكب الأداء',
        'مصحح الدلالات',
        'شبكة المواد',
        'تخزين الصور النقطية مؤقتاً',
        'إعادة تشغيل البرنامج التعليمي',
        'إعادة ضبط المصنع',
      ];
}

// Path: settings.comparison
class _TranslationsSettingsComparisonAr
    implements TranslationsSettingsComparisonEn {
  _TranslationsSettingsComparisonAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'المقارنة';
  @override
  String get description => 'تكوين سلوك المقارنة';
  @override
  String get caseSensitive => 'حساس لحالة الأحرف';
  @override
  String get caseSensitiveDescription =>
      'معاملة الأحرف الكبيرة والصغيرة كمختلفة';
  @override
  String get ignoreWhitespace => 'تجاهل المسافات البيضاء';
  @override
  String get ignoreWhitespaceDescription =>
      'تجاهل المسافة البيضاء في البداية/النهاية عند المقارنة';
  @override
  String get showLineNumbers => 'إظهار أرقام الأسطر';
  @override
  String get showLineNumbersDescription => 'عرض أرقام الأسطر في عرض الفرق';
  @override
  String get behavior => 'سلوك المقارنة';
  @override
  String get ignoreCase => 'تجاهل حالة الأحرف';
  @override
  String get ignoreCaseDescription => 'معاملة "Key" و "key" كشيء واحد';
  @override
  String get similarityThreshold => 'عتبة التشابه';
  @override
  String get similarityThresholdDescription =>
      'الحد الأدنى للتشابه لاكتشاف "المعدل"';
  @override
  String get mode => 'وضع المقارنة';
  @override
  String get modeDescription => 'كيفية مطابقة الإدخالات بين الملفات';
  @override
  String get modeKey => 'مستند إلى المفتاح';
  @override
  String get modeKeyDescription => 'يطابق بناءً على اسم المفتاح (افتراضي).';
  @override
  String get modeOrder => 'مستند إلى الترتيب';
  @override
  String get modeOrderDescription => 'يطابق بناءً على الموضع في الملف.';
  @override
  String get modeSmart => 'مطابقة ذكية';
  @override
  String get modeSmartDescription => 'يكتشف المفاتيح المنقولة/المعاد تسميتها.';
  @override
  String get ignorePatterns => 'أنماط التجاهل';
  @override
  String get noIgnorePatterns => 'لم يتم تعيين أنماط تجاهل.';
  @override
  String get addPattern => 'إضافة نمط';
  @override
  String get resetToGlobal =>
      'إعادة تعيين جميع إعدادات المقارنة للافتراضيات العالمية';
  @override
  late final _TranslationsSettingsComparisonPatternPresetsAr patternPresets =
      _TranslationsSettingsComparisonPatternPresetsAr._(_root);
  @override
  late final _TranslationsSettingsComparisonPreviewMatchAr previewMatch =
      _TranslationsSettingsComparisonPreviewMatchAr._(_root);
  @override
  late final _TranslationsSettingsComparisonColorPresetsAr colorPresets =
      _TranslationsSettingsComparisonColorPresetsAr._(_root);
}

// Path: settings.fileHandling
class _TranslationsSettingsFileHandlingAr
    implements TranslationsSettingsFileHandlingEn {
  _TranslationsSettingsFileHandlingAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get fileFormats => 'تنسيقات الملفات';
  @override
  String get sourceFormat => 'تنسيق المصدر';
  @override
  String get targetFormat => 'تنسيق الهدف';
  @override
  String get encoding => 'الترميز';
  @override
  String get sourceEncoding => 'ترميز المصدر';
  @override
  String get targetEncoding => 'ترميز الهدف';
  @override
  String get autoDetect => 'اكتشاف تلقائي';
  @override
  String get autoDetectEncodingDescription => 'الكشف التلقائي عن ترميز الملف';
  @override
  String get exportSettings => 'إعدادات التصدير';
  @override
  String get defaultExportFormat => 'تنسيق التصدير الافتراضي';
  @override
  String get includeUtf8Bom => 'تضمين UTF-8 BOM';
  @override
  String get includeUtf8BomDescription => 'مطلوب لتوافق Excel';
  @override
  String get openFolderAfterExport => 'فتح المجلد بعد التصدير';
  @override
  String get fileSafety => 'أمان الملفات';
  @override
  String get fileSafetyDescription => 'نسخ محلية تلقائية لاستعادة البيانات.';
  @override
  String get resetToGlobal =>
      'إعادة تعيين جميع إعدادات معالجة الملفات للافتراضيات العالمية';
}

// Path: settings.translationMemory
class _TranslationsSettingsTranslationMemoryAr
    implements TranslationsSettingsTranslationMemoryEn {
  _TranslationsSettingsTranslationMemoryAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'ذاكرة الترجمة العالمية';
  @override
  String get autoLearn => 'تعلم تلقائي';
  @override
  String get autoLearnDescription =>
      'حفظ الترجمات في الذاكرة المحلية لإعادة استخدامها مستقبلاً';
  @override
  String get confidenceThreshold => 'عتبة الثقة';
  @override
  String confidenceThresholdDescription({required Object percent}) =>
      'الحد الأنى للدرجة للتطبيق التلقائي (${percent}%)';
  @override
  String get entries => 'الإدخالات';
  @override
  String get size => 'الحجم';
  @override
  String memorySize({required Object size}) => 'حجم الذاكرة: ${size}';
  @override
  String get import => 'استيراد';
  @override
  String get exportTmx => 'تصدير TMX';
  @override
  String get exportCsv => 'تصدير CSV';
  @override
  String get clearMemory => 'مسح الذاكرة';
  @override
  String importedItems({required Object count}) =>
      'تم استيراد ${count} عنصراً في الذاكرة.';
  @override
  String get noItemsAdded => 'لم تتم إضافة أي عناصر.';
  @override
  String get nothingToExport => 'لا يوجد شيء لتصديره بعد.';
  @override
  String get tmxSaved => 'تم حفظ TMX';
  @override
  String get csvSaved => 'تم حفظ CSV';
  @override
  String get clearConfirmTitle => 'مسح ذاكرة الترجمة؟';
  @override
  String get clearConfirmContent =>
      'سيؤدي هذا إلى إزالة جميع أزواج الترجمة المحفوظة على هذا الجهاز. هذا الإجراء لا يمكن التراج عنه.';
  @override
  String get cleared => 'تم مسح ذاكرة الترجمة.';
  @override
  String get couldNotClear => 'تعذر مسح الذاكرة.';
}

// Path: settings.backup
class _TranslationsSettingsBackupAr implements TranslationsSettingsBackupEn {
  _TranslationsSettingsBackupAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'نسخ احتياطي تلقائي';
  @override
  String get description => 'إعدادات النسخ الاحتياطي التلقائي';
  @override
  String get enabled => 'تفعيل النسخ الاحتياطي التلقائي';
  @override
  String get enabledDescription =>
      'نسخ الملفات احتياطياً تلقائياً قبل إجراء التغييرات';
  @override
  String get maxCopies => 'الحد الأقصى لنسخ النسخ الاحتياطي';
  @override
  String get maxCopiesDescription =>
      'عدد نسخ النسخ الاحتياطي التي يجب الاحتفاظ بها لكل ملف';
  @override
  String activeStatus({required Object count}) =>
      'نشط · الاحتفاظ بـ ${count} نسخ';
  @override
  String get folder => 'مجلد النسخ الاحتياطي';
  @override
  String get folderDescription => 'أتركه فارغاً لاستخدام نفس المجلد';
  @override
  String get useOriginalFolder => 'استخدام مجلد الملف الأصلي';
}

// Path: settings.ai
class _TranslationsSettingsAiAr implements TranslationsSettingsAiEn {
  _TranslationsSettingsAiAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'خدمات الذكاء الاصطناعي';
  @override
  String get description => 'تكوين الترجمة والمساعدة بالذكاء الاصطناعي';
  @override
  String get provider => 'موفر الذكاء الاصطناعي';
  @override
  String get providerDescription =>
      'اختر موفر خدمة الذكاء الاصطناعي المفضل لديك';
  @override
  String get apiKey => 'مفتاح API';
  @override
  String get apiKeyDescription => 'أدخل مفتاح API الخاص بك للموفر المحدد';
  @override
  String get apiKeyPlaceholder => 'أدخل مفتاح API...';
  @override
  String get testConnection => 'اختبار الاتصال';
  @override
  String get connectionSuccess => 'نجح الاتصال!';
  @override
  String get connectionFailed =>
      'فشل الاتصال. يرجى التحقق من مفتاح API الخاص بك.';
  @override
  String get translationStrategy => 'استراتيجية الترجمة';
  @override
  String get strategy => 'الاستراتيجية';
  @override
  String get strategyDescription => 'اختر كيفية ترجمة النصوص';
  @override
  String get strategyLLM => 'الذكاء الاصطناعي التوليدي (LLM)';
  @override
  String get strategyCloud => 'الترجمة السحابية';
  @override
  String get enableAiTranslation => 'تفعيل الترجمة بالذكاء الاصطناعي';
  @override
  String get enableAiTranslationDescription =>
      'السماح للتطبيق باستخدام الذكاء الاصطناعي لاقتراحات الترجمة';
  @override
  String get llmProvider => 'موفر خدمة LLM';
  @override
  String get service => 'الخدمة';
  @override
  String get serviceDescription => 'موفر الذكاء الاصطناعي التوليدي';
  @override
  String get providerGemini => 'Google Gemini';
  @override
  String get providerOpenAI => 'OpenAI';
  @override
  String get geminiApiKey => 'مفتاح Gemini API';
  @override
  String get openAiApiKey => 'مفتاح OpenAI API';
  @override
  String get model => 'النموذج';
  @override
  String get modelDescription => 'حدد النموذج الذي تريد استخدامه';
  @override
  String get advancedParameters => 'معلمات متقدمة';
  @override
  String get parameters => 'المعلمات';
  @override
  String get parametersDescription => 'درجة الحرارة، السياق، والمزيد';
  @override
  String get temperature => 'درجة الحرارة';
  @override
  String get temperatureDescription => 'القيم الأعلى تجعل الإخراج أكثر إبداعاً';
  @override
  String get maxTokens => 'الحد الأقصى للرموز';
  @override
  String get maxTokensDescription => 'الحد من طول نافذة السياق';
  @override
  String get systemContext => 'سياق النظام / التعليمات';
  @override
  String get systemContextHint =>
      'أنت مترجم محترف. حافظ على نبرة المصدر وقصده...';
  @override
  String get systemContextHelper =>
      'قدم تعليمات محددة للذكاء الاصطناعي حول أسلوب ومصطلحات مشروعك.';
  @override
  String get contextStrings => 'سلاسل السياق';
  @override
  String get contextStringsDescription =>
      'تضمين السلاسل المحيطة للحصول على سياق أفضل';
  @override
  String get contextCount => 'عدد السياق';
  @override
  String get contextCountDescription => 'عدد السلاسل المحيطة التي سيتم تضمينها';
  @override
  String get cloudServices => 'خدمات الترجمة السحابية';
  @override
  String get googleTranslateApiKey => 'مفتاح Google Translate API';
  @override
  String get deeplApiKey => 'مفتاح DeepL API';
  @override
  String get test => 'اختبار';
  @override
  String get resetToGlobal =>
      'إعادة تعيين جميع إعدادات الذكاء الاصطناعي للافتراضيات العالمية';
}

// Path: settings.integrations
class _TranslationsSettingsIntegrationsAr
    implements TranslationsSettingsIntegrationsEn {
  _TranslationsSettingsIntegrationsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get platformNotice => 'إشعار المنصة';
  @override
  String get platformNoticeDescription =>
      'تكاملات النظام غير متوفرة لهذه المنصة.';
  @override
  String get visualEffects => 'تأثيرات بصرية';
  @override
  String get explorerIntegration => 'تكامل المستكشف';
  @override
  String get explorerIntegrationDescription =>
      'إضافة "فتح باستخدام Localizer" إلى قائمة النقر بزر الماوس الأيمن في مستكشف Windows للمجلدات.';
  @override
  String get addToContextMenu => 'إضافة إلى قائمة السياق';
  @override
  String get contextMenuAdded => 'تمت إضافة قائمة السياق!';
  @override
  String get contextMenuAddError => 'فشل إضافة قائمة السياق';
  @override
  String get contextMenuRemoved => 'تمت إزالة قائمة السياق!';
  @override
  String get contextMenuRemoveError => 'فشل إزالة قائمة السياق';
  @override
  String get fileAssociations => 'ارتباطات الملفات';
  @override
  String get fileAssociationsDescription =>
      'تسجيل أنواع الملفات لفتحها باستخدام Localizer عند النقر المزدوج في المستكشف.';
  @override
  String get registered => 'مسجل';
  @override
  String get notRegistered => 'غير مسجل';
  @override
  String extRegistered({required Object ext}) => 'تم تسجيل ${ext}!';
  @override
  String extUnregistered({required Object ext}) => 'تم إلغاء تسجيل ${ext}!';
  @override
  String extError({required Object action, required Object ext}) =>
      'فشل في ${action} ${ext}';
  @override
  String get registerAll => 'تسجيل الكل';
  @override
  String get unregisterAll => 'إلغاء تسجيل الكل';
  @override
  String registerAllResult({required Object success, required Object total}) =>
      'تسجيل ${success} من ${total} أنواع ملفات';
  @override
  String unregisterAllResult(
          {required Object success, required Object total}) =>
      'إلغاء تسجيل ${success} من ${total} أنواع ملفات';
  @override
  String get protocolHandler => 'معالج البروتوكول';
  @override
  String get protocolHandlerDescription =>
      'تسجيل عناوين URL localizer:// لفتح هذا التطبيق. يسمح بفتح المشاريع مباشرة من روابط المتصفح أو التطبيقات الأخرى.';
  @override
  String get protocolRegistered => 'معالج البروتوكول مسجل';
  @override
  String get protocolNotRegistered => 'معالج البروتوكول غير مسجل';
  @override
  String get registerProtocol => 'تسجيل البروتوكول';
  @override
  String get unregister => 'إلغاء التسجيل';
  @override
  String get protocolRegisteredSuccess => 'تم تسجيل معالج البروتوكول!';
  @override
  String get protocolRemovedSuccess => 'تمت إزالة معالج البروتوكول!';
  @override
  String get protocolRegisterError => 'فشل التسجيل';
  @override
  String get protocolRemoveError => 'فشل الإزالة';
  @override
  String get windowMaterial => 'مادة النافذة';
  @override
  String get windowMaterialDescription => 'حدد نمط مادة حيوية macOS';
  @override
  String get dockIntegration => 'تكامل Dock';
  @override
  String get showDockBadge => 'إظهار عدد غير المترجمة';
  @override
  String get showDockBadgeDescription =>
      'عرض عدد السلاسل غير المترجمة على شارة أيقونة dock';
  @override
  late final _TranslationsSettingsIntegrationsMaterialsAr materials =
      _TranslationsSettingsIntegrationsMaterialsAr._(_root);
  @override
  late final _TranslationsSettingsIntegrationsFileTypesAr fileTypes =
      _TranslationsSettingsIntegrationsFileTypesAr._(_root);
}

// Path: settings.developer
class _TranslationsSettingsDeveloperAr
    implements TranslationsSettingsDeveloperEn {
  _TranslationsSettingsDeveloperAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'إعدادات المطور';
  @override
  String get description => 'إعدادات متقدمة للمطورين';
  @override
  String get showLocalizationKeys => 'إظهار مفاتيح التوطين';
  @override
  String get localizationKeysDescription =>
      'عند التفعيل، ستظهر جميع النصوص المترجمة مفاتيح التوطين الخاصة بها بدلاً من القيمة المترجمة. مفيد للتحقق من المفتاح المستخدم.';
  @override
  String get showPerformanceOverlay => 'إظهار تراكب الأداء';
  @override
  String get performanceOverlayDescription => 'عرض FPS ومعلومات توقيت الإطار';
  @override
  String get debugMode => 'وضع التصحيح';
  @override
  String get debugModeDescription => 'تفعيل تسجيل إضافي وميزات تصحيح الأخطاء';
  @override
  String get debuggingTools => 'أدوات التصحيح';
  @override
  String get semanticsDebugger => 'مصحح الدلالات';
  @override
  String get semanticsDebuggerDescription => 'تصور شجرة الدلالات';
  @override
  String get materialGrid => 'شبكة المواد';
  @override
  String get materialGridDescription => 'تراكب شبكة تخطيط المواد';
  @override
  String get rasterCache => 'تخزين الصور النقطية مؤقتاً';
  @override
  String get rasterCacheDescription => 'صور ذاكرة التخزين المؤقت النقطية';
  @override
  String get actions => 'إجراءات';
  @override
  String get showLogs => 'إظهار سجلات التطبيق';
  @override
  String get showLogsDescription => 'فتح وحدة تحكم تصحيح Talker';
  @override
  String get restartTutorial => 'إعادة تشغيل البرنامج التعليمي';
  @override
  String get restartTutorialDescription =>
      'إعادة تعيين العلامات وتشغيل البرنامج التعليمي مرة أخرى';
  @override
  String get restartRequested => 'تم طلب إعادة تشغيل البرنامج التعليمي.';
  @override
  String get throwException => 'رمي استثناء اختبار';
  @override
  String get throwExceptionDescription =>
      'تشغيل استثناء اختبار للإبلاغ عن الأعطال';
  @override
  String get testExceptionMessage =>
      'تم تشغيل استثناء الاختبار من خيارات المطور';
  @override
  String get clearTM => 'مسح ذاكرة الترجمة';
  @override
  String get clearTMDescription => 'حذف جميع الترجمات المخزنة مؤقتاً';
  @override
  String get clearTMConfirmation => 'مسح ذاكرة الترجمة؟';
  @override
  String get clearTMWarning =>
      'سيؤدي هذا إلى حذف جميع الترجمات التي تم تعلمها. هذا لا يمكن التراجع عنه.';
  @override
  String get tmCleared => 'تم مسح ذاكرة الترجمة';
  @override
  String get clearApiKeys => 'مسح مفاتيح API';
  @override
  String get clearApiKeysDescription => 'إزالة جميع مفاتيح API المخزنة';
  @override
  String get clearApiKeysConfirmation => 'مسح مفاتيح API؟';
  @override
  String get clearApiKeysWarning =>
      'سيؤدي هذا إلى إزالة جميع مفاتيح API من التخزين الآمن.';
  @override
  String get apiKeysCleared => 'تم مسح مفاتيح API';
  @override
  String get hideOptions => 'إخفاء خيارات المطور';
  @override
  String get hideOptionsDescription =>
      'تعطيل وضع المطور (يتطلب 7 نقرات لإعادة التفعيل)';
  @override
  String get optionsDisabled => 'تم تعطيل خيارات المطور';
  @override
  String get dangerZone => 'منطقة الخطر';
  @override
  String get factoryReset => 'إعادة ضبط المصنع';
  @override
  String get factoryResetDescription =>
      'إعادة تعيين جميع الإعدادات ومسح البيانات';
  @override
  String get factoryResetWarning =>
      'هل أنت متأكد أنك تريد إعادة تعيين جميع الإعدادات؟ هذا الإجراء لا يمكن التراجع عنه.';
  @override
  String get inspectionTools => 'أدوات الفحص';
  @override
  String get searchHint => 'بحث في الإعدادات...';
  @override
  String get resetToDefault => 'إعادة تعيين للافتراضيات';
  @override
  String get resetToGlobal => 'إعادة تعيين للافتراضي العالمي';
  @override
  String get storageInspector => 'مفتش التخزين';
  @override
  String get storageInspectorDescription => 'عرض محتويات Hive و Secure Storage';
  @override
  String get deviceEnvironment => 'الجهاز والبيئة';
  @override
  String get deviceEnvironmentDescription => 'معلومات الشاشة، المنصة، والبناء';
  @override
  String get themePlayground => 'ملعب المظهر';
  @override
  String get themePlaygroundDescription => 'لوحة الألوان والطباعة';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionAr
      themePlaygroundSection =
      _TranslationsSettingsDeveloperThemePlaygroundSectionAr._(_root);
  @override
  String get localizationInspector => 'مفتش التوطين';
  @override
  String get localizationInspectorDescription => 'تصحيح سلاسل الترجمة';
  @override
  String get hiveAppSettings => 'Hive (AppSettings)';
  @override
  String get secureStorageMasked => 'Secure Storage (Masked)';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsAr featureFlags =
      _TranslationsSettingsDeveloperFeatureFlagsAr._(_root);
  @override
  late final _TranslationsSettingsDeveloperStorageInspectorSectionAr
      storageInspectorSection =
      _TranslationsSettingsDeveloperStorageInspectorSectionAr._(_root);
  @override
  late final _TranslationsSettingsDeveloperDeviceInfoSectionAr
      deviceInfoSection =
      _TranslationsSettingsDeveloperDeviceInfoSectionAr._(_root);
  @override
  late final _TranslationsSettingsDeveloperLocalizationInspectorSectionAr
      localizationInspectorSection =
      _TranslationsSettingsDeveloperLocalizationInspectorSectionAr._(_root);
}

// Path: settings.about
class _TranslationsSettingsAboutAr implements TranslationsSettingsAboutEn {
  _TranslationsSettingsAboutAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'حول';
  @override
  String get version => 'الإصدار';
  @override
  String get buildNumber => 'رقم البناء';
  @override
  String get author => 'المؤلف';
  @override
  String get license => 'الرخصة';
  @override
  String get sourceCode => 'كود المصدر';
  @override
  String get reportBug => 'الإبلاغ عن خطأ';
  @override
  String get requestFeature => 'طلب ميزة';
  @override
  String get checkForUpdates => 'التحقق من التحديثات';
  @override
  String get upToDate => 'أنت على أحدث إصدار!';
  @override
  String updateAvailable({required Object version}) => 'يوجد تحديث: ${version}';
  @override
  String get updateAvailableBadge => 'تحديث متوفر!';
  @override
  String developerSteps({required Object count}) =>
      'أنت على بعد ${count} خطوات من أن تكون مطوراً.';
  @override
  String get developerActivated => 'أنت الآن مطور!';
  @override
  String get neverChecked => 'أبداً';
  @override
  String get applicationInfo => 'معلومات التطبيق';
  @override
  String get platform => 'المنصة';
  @override
  String get updateInformation => 'معلومات التحديث';
  @override
  String get currentVersion => 'الإصدار الحالي';
  @override
  String get latestVersion => 'أحدث إصدار';
  @override
  String get lastChecked => 'آخر تحقق';
  @override
  String get checkingForUpdates => 'جارٍ التحقق...';
  @override
  String get whatsNew => 'ما الجديد';
  @override
  String get systemInformation => 'معلومات النظام';
  @override
  String get dartVersion => 'إصدار Dart';
  @override
  String get diskSpace => 'مساحة القرص المتوفرة';
  @override
  String get memoryUsage => 'استخدام الذاكرة';
  @override
  String get privacyTitle => 'الخصوصية والقياس عن بعد';
  @override
  String get usageStats => 'إحصائيات الاستخدام المجهولة';
  @override
  String get requiresFirebase => 'يتطلب تكوين Firebase';
  @override
  String get featureUnavailable => 'الميزة غير متوفرة حالياً (تتطلب Firebase)';
  @override
  String get settingsManagement => 'إدارة الإعدادات';
  @override
  String get settingsManagementDescription =>
      'تصدير الإعدادات إلى ملف لإجراء نسخ احتياطي أو مشاركتها مع أجهزة أخرى.';
  @override
  String get resetAll => 'إعادة تعيين الكل';
  @override
  String get links => 'روابط';
  @override
  String get githubRepo => 'مستودع GitHub';
  @override
  String get privacyPolicy => 'سياسة الخصوصية';
  @override
  String get crashReporting => 'الإبلاغ عن الأعطال';
}

// Path: settings.settingsView
class _TranslationsSettingsSettingsViewAr
    implements TranslationsSettingsSettingsViewEn {
  _TranslationsSettingsSettingsViewAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String resetCategoryTitle({required Object category}) =>
      'إعادة تعيين ${category}؟';
  @override
  String get resetCategoryContent =>
      'سيؤدي هذا إلى إعادة تعيين جميع الإعدادات في هذه الفئة إلى قيمها الافتراضية.';
  @override
  String get resetAllTitle => 'إعادة تعيين جميع الإعدادات؟';
  @override
  String get resetAllContent =>
      'سيؤدي هذا إلى إعادة تعيين جميع الإعدادات بشكل دائم إلى افتراضيات المصنع. هذا الإجراء لا يمكن التراجع عنه.';
  @override
  String get resetAll => 'إعادة تعيين الكل';
  @override
  String resetSuccess({required Object category}) =>
      'تمت إعادة تعيين ${category} للافتراضيات';
  @override
  String get errorLoading => 'خطأ في تحميل الإعدادات';
  @override
  String get settingsSaved => 'تم حفظ الإعدادات';
  @override
  String updateAvailable({required Object version}) =>
      'تحديث متوفر: v${version}';
  @override
  String get latestVersion => 'أنت تستخدم أحدث إصدار';
  @override
  String whatsNew({required Object version}) => 'ما الجديد في v${version}';
  @override
  String get downloadUpdate => 'تنزيل التحديث';
  @override
  String get exportSettings => 'تصدير الإعدادات';
  @override
  String get settingsExported => 'تم تصدير الإعدادات';
  @override
  String exportFail({required Object error}) => 'فشل تصدير الإعدادات: ${error}';
  @override
  String get importSettings => 'استيراد الإعدادات';
  @override
  String get importTitle => 'استيراد الإعدادات؟';
  @override
  String get importContent =>
      'سيؤدي هذا إلى استبدال جميع إعداداتك الحالية بالمستوردة. هذا الإجراء لا يمكن التراجع عنه.';
  @override
  String get importSuccess => 'تم استيراد الإعدادات بنجاح!';
  @override
  String importFail({required Object error}) =>
      'فشل استيراد الإعدادات: ${error}';
  @override
  String get invalidFormat => 'تنسيق ملف الإعدادات غير صالح';
  @override
  late final _TranslationsSettingsSettingsViewCategoriesAr categories =
      _TranslationsSettingsSettingsViewCategoriesAr._(_root);
  @override
  late final _TranslationsSettingsSettingsViewCategoryLabelsAr categoryLabels =
      _TranslationsSettingsSettingsViewCategoryLabelsAr._(_root);
}

// Path: settings.onboarding
class _TranslationsSettingsOnboardingAr
    implements TranslationsSettingsOnboardingEn {
  _TranslationsSettingsOnboardingAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'تخطي البرنامج التعليمي';
  @override
  String get gettingStarted => 'البدء';
  @override
  String stepProgress({required Object current, required Object total}) =>
      '${current} من ${total}';
  @override
  String get loadSampleData => 'تحميل بيانات العينة';
  @override
  late final _TranslationsSettingsOnboardingStepsAr steps =
      _TranslationsSettingsOnboardingStepsAr._(_root);
}

// Path: advancedDiff.aiSuggestion
class _TranslationsAdvancedDiffAiSuggestionAr
    implements TranslationsAdvancedDiffAiSuggestionEn {
  _TranslationsAdvancedDiffAiSuggestionAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get aiTranslation => 'ترجمة الذكاء الاصطناعي';
  @override
  String get aiRephrase => 'إعادة صياغة الذكاء الاصطناعي';
  @override
  String key({required Object key}) => 'المفتاح: ${key}';
  @override
  String get original => 'الأصل:';
  @override
  String get suggestion => 'الاقتراح:';
  @override
  String get confidence => 'ثقة الذكاء الاصطناعي';
  @override
  String get cancelEdit => 'إلغاء التعديل';
  @override
  String get editSuggestion => 'تعديل الاقتراح';
  @override
  String get alternatives => 'بدائل:';
  @override
  String get accept => 'قبول';
  @override
  String get reject => 'رفض';
  @override
  String get stop => 'إيقاف';
}

// Path: advancedDiff.detailEdit
class _TranslationsAdvancedDiffDetailEditAr
    implements TranslationsAdvancedDiffDetailEditEn {
  _TranslationsAdvancedDiffDetailEditAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object key}) => 'تعديل: ${key}';
  @override
  String get sourceLabel => 'المصدر (الأصل)';
  @override
  String get targetLabel => 'الهدف (الترجمة)';
  @override
  String get translateWithCloud => 'ترجمة سحابية';
  @override
  String get translateWithAi => 'ترجمة بالذكاء الاصطناعي';
  @override
  String get translating => 'جارٍ الترجمة...';
  @override
  String get applyAndTm => 'تطبيق';
  @override
  String get entryApplied => 'تم تطبيق الإدخال وإضافته للذاكرة';
  @override
  String get translationAdded => 'تمت إضافة اقتراح الترجمة.';
  @override
  String get aiSuggestionAdded => 'تمت إضافة اقتراح الذكاء الاصطناعي.';
}

// Path: advancedDiff.table
class _TranslationsAdvancedDiffTableAr
    implements TranslationsAdvancedDiffTableEn {
  _TranslationsAdvancedDiffTableAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get addedToTM => 'تمت الإضافة لذاكرة الترجمة';
  @override
  String get markedReviewed => 'تم وضع علامة مراجعة ✓';
  @override
  String get unmarkedReview => 'تمت إزالة علامة المراجعة';
  @override
  String get reverted => 'تم التراجع لقيمة المصدر';
  @override
  String get entryDeleted => 'تم حذف الإدخال';
  @override
  String get noSourceText => 'لا يوجد نص مصدر للترجمة.';
  @override
  String aiTranslationFailed({required Object key}) =>
      'فشلت ترجمة الذكاء الاصطناعي لـ "${key}"';
  @override
  String get noTargetText => 'لا يوجد نص هدف لإعادة صياغته.';
  @override
  String aiRephraseFailed({required Object key}) =>
      'فشلت إعادة صياغة الذكاء الاصطناعي لـ "${key}"';
  @override
  String get checkRowsFirst => 'حدد الصفوف باستخدام مربعات الاختيار أولاً';
  @override
  String markedRowsReviewed({required Object count}) =>
      'تم وضع علامة مراجعة لـ ${count} صفوف';
  @override
  String revertedRows({required Object count}) => 'تم التراجع عن ${count} صفوف';
  @override
  String entriesCount({required Object count}) => '${count} إدخالات';
  @override
  String get markSelectedReviewed => 'وضع علامة مراجعة للمحدد';
  @override
  String get revertSelected => 'تراجع عن المحدد';
  @override
  String get noDifferences => 'لم يتم العثور على فروق';
  @override
  String get adjustFilters => 'حاول تعديل الفلاتر الخاصة بك';
  @override
  String get cloudTranslationApplied => 'تم تطبيق الترجمة السحابية.';
  @override
  String get aiTranslationApplied => 'تم تطبيق ترجمة الذكاء الاصطناعي.';
  @override
  String get suggestionApplied => 'تم تطبيق الاقتراح.';
  @override
  String get aiSuggestionApplied => 'تم تطبيق اقتراح الذكاء الاصطناعي.';
  @override
  String get rephraseApplied => 'تم تطبيق إعادة الصياغة.';
  @override
  String get aiRephraseApplied => 'تم تطبيق إعادة الصياغة بالذكاء الاصطناعي.';
  @override
  String get rephrase => 'إعادة صياغة';
  @override
  String get aiRephrase => 'إعادة صياغة بالذكاء الاصطناعي';
  @override
  String get targetClickToEdit => 'الهدف (انقر للتعديل)';
  @override
  String get targetClickForDialog => 'الهدف (انقر للحوار)';
  @override
  String get emptyClickToEdit => '(فارغ - انقر للتعديل)';
  @override
  String get unmarkReviewed => 'إزالة علامة المراجعة';
  @override
  String get markReviewed => 'وضع علامة مراجعة';
  @override
  String get revertToSource => 'تراجع إلى المصدر';
  @override
  String get translateWithCloud => 'ترجمة سحابية';
  @override
  String get translateWithAi => 'ترجمة بالذكاء الاصطناعي';
  @override
  String get rephraseWithAi => 'إعادة صياغة بالذكاء الاصطناعي';
  @override
  String get moreActions => 'المزيد من الإجراءات';
  @override
  String get editDetails => 'تعديل التفاصيل';
  @override
  String get suggestTranslation => 'اقتراح ترجمة';
  @override
  String get addToTm => 'إضافة إلى الذاكرة';
  @override
  String get deleteEntry => 'حذف إدخال';
}

// Path: advancedDiff.diffRow
class _TranslationsAdvancedDiffDiffRowAr
    implements TranslationsAdvancedDiffDiffRowEn {
  _TranslationsAdvancedDiffDiffRowAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get copySource => 'نسخ نص المصدر';
  @override
  String get actions => 'إجراءات';
}

// Path: advancedDiff.status
class _TranslationsAdvancedDiffStatusAr
    implements TranslationsAdvancedDiffStatusEn {
  _TranslationsAdvancedDiffStatusAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'مضاف';
  @override
  String get missing => 'مفقود';
  @override
  String changed({required Object percent}) => 'معدل ${percent}%';
  @override
  String get same => 'نفسه';
}

// Path: advancedDiff.sidebar
class _TranslationsAdvancedDiffSidebarAr
    implements TranslationsAdvancedDiffSidebarEn {
  _TranslationsAdvancedDiffSidebarAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get widgets => 'أدوات';
  @override
  String get searchPlaceholder => 'بحث في المفاتيح والقيم... (Ctrl+F)';
  @override
  String get fuzzySearchTooltip => 'بحث ضبابي (متسامح مع الأخطاء المطبعية)';
  @override
  String get regexSearchTooltip => 'بحث Regex';
  @override
  String get cloudTranslation => 'ترجمة سحابية';
  @override
  String get aiTranslation => 'ترجمة بالذكاء الاصطناعي';
  @override
  String get status => 'الحالة';
  @override
  String get tm => 'ذاكرة الترجمة';
  @override
  String get filters => 'فلاتر';
  @override
  String get actions => 'إجراءات';
  @override
  String get similarity => 'التشابه';
  @override
  late final _TranslationsAdvancedDiffSidebarActionsSectionAr actionsSection =
      _TranslationsAdvancedDiffSidebarActionsSectionAr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarAiSectionAr aiSection =
      _TranslationsAdvancedDiffSidebarAiSectionAr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarTmSectionAr tmSection =
      _TranslationsAdvancedDiffSidebarTmSectionAr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarFiltersSectionAr filtersSection =
      _TranslationsAdvancedDiffSidebarFiltersSectionAr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarSimilaritySectionAr
      similaritySection =
      _TranslationsAdvancedDiffSidebarSimilaritySectionAr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarStatusSectionAr statusSection =
      _TranslationsAdvancedDiffSidebarStatusSectionAr._(_root);
}

// Path: issueDetails.duplicateValue
class _TranslationsIssueDetailsDuplicateValueAr
    implements TranslationsIssueDetailsDuplicateValueEn {
  _TranslationsIssueDetailsDuplicateValueAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'ترجمة مكررة';
  @override
  String get warning =>
      'تستخدم نصوص مصدر مختلفة هذه الترجمة نفسها. تحقق من السياق.';
  @override
  String affectedKeys({required Object count}) =>
      'المفاتيح المتأثرة (${count})';
  @override
  String get identicalSources => 'مصادر متطابقة';
  @override
  String moreKeys({required Object count}) => '+${count} مفاتيح أخرى';
}

// Path: issueDetails.lengthOutlier
class _TranslationsIssueDetailsLengthOutlierAr
    implements TranslationsIssueDetailsLengthOutlierEn {
  _TranslationsIssueDetailsLengthOutlierAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get source => 'المصدر';
  @override
  String get translation => 'الترجمة';
  @override
  String chars({required Object count}) => '${count} حرف';
}

// Path: issueDetails.standard
class _TranslationsIssueDetailsStandardAr
    implements TranslationsIssueDetailsStandardEn {
  _TranslationsIssueDetailsStandardAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'المفتاح';
  @override
  String get sourceText => 'نص المصدر';
  @override
  String get translation => 'الترجمة';
  @override
  String get errorDetails => 'تفاصيل الخطأ';
  @override
  String get note => 'ملاحظة';
}

// Path: issueDetails.types
class _TranslationsIssueDetailsTypesAr
    implements TranslationsIssueDetailsTypesEn {
  _TranslationsIssueDetailsTypesAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get duplicateValue => 'قيم مكررة';
  @override
  String get lengthOutlier => 'عدم تطابق الطول';
  @override
  String get placeholderMismatch => 'عناصر نائبة معطلة';
}

// Path: issueDetails.notes
class _TranslationsIssueDetailsNotesAr
    implements TranslationsIssueDetailsNotesEn {
  _TranslationsIssueDetailsNotesAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get placeholderMismatch =>
      'يجب أن تتطابق علامات مثل {name} مع المصدر.';
  @override
  String get lengthOutlier =>
      'التغييرات الكبيرة في الطول يمكن أن تؤثر على كيفية ظهور النص على الشاشة.';
  @override
  String get duplicateValue => 'يتم استخدام نفس الترجمة لمفاتيح مختلفة.';
}

// Path: issueDetails.fallbacks
class _TranslationsIssueDetailsFallbacksAr
    implements TranslationsIssueDetailsFallbacksEn {
  _TranslationsIssueDetailsFallbacksAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get multipleSources => 'نصوص مصدر متعددة';
  @override
  String get sourceNotAvailable => 'نص المصدر غير متوفر';
  @override
  String get sharedTranslationNotAvailable => 'الترجمة المشتركة غير متوفرة';
  @override
  String get translationNotAvailable => 'الترجمة غير متوفرة';
}

// Path: compare.tabs
class _TranslationsCompareTabsAr implements TranslationsCompareTabsEn {
  _TranslationsCompareTabsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get files => 'ملفات';
  @override
  String get directories => 'أدلة';
  @override
  String get git => 'Git';
}

// Path: compare.fileTypes
class _TranslationsCompareFileTypesAr
    implements TranslationsCompareFileTypesEn {
  _TranslationsCompareFileTypesAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get json => 'ملفات توطين JSON (i18next, Flutter, etc.)';
  @override
  String get yaml => 'ملفات توطين YAML (Rails, Flutter)';
  @override
  String get xml => 'ملفات توطين XML (Android, .NET)';
  @override
  String get properties => 'ملفات Properties (Java)';
  @override
  String get resx => 'ملفات RESX (.NET)';
  @override
  String get xliff => 'ملفات XLIFF';
}

// Path: history.timeAgo
class _TranslationsHistoryTimeAgoAr implements TranslationsHistoryTimeAgoEn {
  _TranslationsHistoryTimeAgoAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get justNow => 'الآن';
  @override
  String secondsAgo({required Object count}) => 'منذ ${count} ثواني';
  @override
  String get oneMinuteAgo => 'منذ دقيقة';
  @override
  String minutesAgo({required Object count}) => 'منذ ${count} دقائق';
  @override
  String get oneHourAgo => 'منذ ساعة';
  @override
  String hoursAgo({required Object count}) => 'منذ ${count} ساعات';
  @override
  String get yesterday => 'أمس';
  @override
  String daysAgo({required Object count}) => 'منذ ${count} أيام';
  @override
  String get oneWeekAgo => 'منذ أسبوع';
  @override
  String weeksAgo({required Object count}) => 'منذ ${count} أسابيع';
  @override
  String get oneMonthAgo => 'منذ شهر';
  @override
  String monthsAgo({required Object count}) => 'منذ ${count} أشهر';
  @override
  String get oneYearAgo => 'منذ سنة';
  @override
  String yearsAgo({required Object count}) => 'منذ ${count} سنوات';
  @override
  String get inTheFuture => 'في المستقبل';
}

// Path: projects.stats
class _TranslationsProjectsStatsAr implements TranslationsProjectsStatsEn {
  _TranslationsProjectsStatsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get empty => 'مشروع فارغ';
  @override
  String files({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        n,
        one: 'ملف ترجمة واحد',
        other: '${count} ملفات ترجمة',
      );
  @override
  String languages({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        n,
        one: 'لغة واحدة',
        other: '${count} لغات',
      );
}

// Path: projects.selection
class _TranslationsProjectsSelectionAr
    implements TranslationsProjectsSelectionEn {
  _TranslationsProjectsSelectionAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get selectFolder => 'تحديد مجلد المشروع';
  @override
  String get selectArchive => 'تحديد أرشيف المشروع';
  @override
  String get openProject => 'فتح المشروع';
  @override
  String get browseFolder => 'تصفح المجلد...';
  @override
  String get createNew => 'إنشاء جديد';
  @override
  String get importFromZip => 'استيراد من Zip...';
}

// Path: projects.createDialog
class _TranslationsProjectsCreateDialogAr
    implements TranslationsProjectsCreateDialogEn {
  _TranslationsProjectsCreateDialogAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'إنشاء مشروع';
  @override
  String get description =>
      'يسمح لك المشروع بحفظ إعدادات مخصصة لمجلد محدد. سيتم إنشاء مجلد ".localizer" لتخزين تكوين مشروعك.';
  @override
  String get folderLabel => 'مجلد المشروع';
  @override
  String get folderHint => 'انقر لتحديد المجلد...';
  @override
  String get nameLabel => 'اسم المشروع';
  @override
  String get nameHint => 'مثال: ترجمات تطبيقي';
  @override
  String get selectFolderWarning => 'يرجى تحديد مجلد المشروع.';
  @override
  String get enterNameError => 'يرجى إدخال اسم المشروع';
  @override
  String get nameLengthError => 'يجب أن يكون الاسم حرفين على الأقل';
  @override
  String success({required Object name}) => 'تم إنشاء المشروع "${name}" بنجاح!';
  @override
  String get failure => 'فشل إنشاء المشروع.';
  @override
  String get creating => 'جارٍ الإنشاء...';
  @override
  String get createAction => 'إنشاء المشروع';
}

// Path: projects.indicator
class _TranslationsProjectsIndicatorAr
    implements TranslationsProjectsIndicatorEn {
  _TranslationsProjectsIndicatorAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get tooltipNoProject => 'أنشئ مشروعاً لحفظ إعدادات مخصصة لمجلد';
  @override
  String tooltipProject({required Object name}) =>
      'المشروع: ${name}\nانقر لرؤية الخيارات';
  @override
  String get location => 'الموقع';
  @override
  String get created => 'تم الإنشاء';
  @override
  String get switchProject => 'تبديل المشروع';
  @override
  String get done => 'تم';
}

// Path: projects.glossary
class _TranslationsProjectsGlossaryAr
    implements TranslationsProjectsGlossaryEn {
  _TranslationsProjectsGlossaryAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'مسرد المشروع';
  @override
  String get description =>
      'تحديد المصطلحات التي يجب معاملتها بشكل متسق أو عدم ترجمتها أبداً.';
  @override
  String get noTerms => 'لا توجد مصطلحات في المسرد بعد.';
  @override
  String get noTermsDesc =>
      'أضف مصطلحات يجب أن تظل متسقة عبر الترجمات،\nأو ضع علامة على الأسماء التجارية التي يجب عدم ترجمتها أبداً.';
  @override
  String get doNotTranslate => 'لا تترجم';
  @override
  String get noSpecificTranslation => 'لا توجد ترجمة محددة';
  @override
  String get addTerm => 'إضافة مصطلح';
  @override
  String get editTerm => 'تعديل المصطلح';
  @override
  String get term => 'المصطلح';
  @override
  String get termHint => 'مثال: اسم العلامة التجارية، مصطلح متخصص';
  @override
  String get definition => 'تعريف (اختياري)';
  @override
  String get definitionHint => 'سياق للمترجم';
  @override
  String get doNotTranslateLabel => 'لا تترجم';
  @override
  String get doNotTranslateDesc => 'احتفظ بالمصطلح كما هو تماماً في الهدف';
  @override
  String get preferredTranslation => 'الترجمة المفضلة';
  @override
  String get caseSensitive => 'حساس لحالة الأحرف';
}

// Path: projects.conflicts
class _TranslationsProjectsConflictsAr
    implements TranslationsProjectsConflictsEn {
  _TranslationsProjectsConflictsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String missingApiKeyTitle({required Object service}) =>
      'مفتاح API مفقود لـ ${service}';
  @override
  String missingApiKeyMessage({required Object service}) =>
      'يستخدم هذا المشروع ${service} ولكن لم يتم تكوين مفتاح API. أضف مفتاح API الخاص بك في الإعدادات > خدمات الذكاء الاصطناعي، أو سيستخدم التطبيق الافتراضي العالمي.';
  @override
  String get dismiss => 'تجاهل';
}

// Path: projects.tm
class _TranslationsProjectsTmAr implements TranslationsProjectsTmEn {
  _TranslationsProjectsTmAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'ذواكر الترجمة';
  @override
  String get description => 'إدارة مصادر ذاكرة الترجمة لهذا المشروع.';
  @override
  String get globalTm => 'ذاكرة الترجمة العالمية';
  @override
  String get globalTmDescription =>
      'استخدام ذاكرة الترجمة المشتركة من إعدادات تطبيقك';
  @override
  String get linkedFiles => 'ملفات مرتبطة (خاص بالمشروع)';
  @override
  String get noLinkedFiles => 'لا توجد ملفات خاصة بالمشروع مرتبطة.';
  @override
  String get addTmFile => 'إضافة ملف ذاكرة ترجمة';
  @override
  String get useGlobalTm => 'استخدام ذاكرة الترجمة العالمية';
  @override
  String get selectTm => 'تحديد ذاكرة الترجمة';
  @override
  String get globalTmEnabled => 'تم تفعيل ذاكرة الترجمة العالمية';
}

// Path: git.conflicts
class _TranslationsGitConflictsAr implements TranslationsGitConflictsEn {
  _TranslationsGitConflictsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'تم اكتشاف تعارضات دمج';
  @override
  String get description => 'يجب عليك حل هذه التعارضات قبل المتابعة.';
  @override
  String get abortMergeTitle => 'إحباط الدمج؟';
  @override
  String get abortMergeContent =>
      'سيؤدي هذا إلى التراجع عن جميع تغييرات الدمج والعودة إلى الحالة قبل الدمج. هذا لا يمكن التراجع عنه.';
  @override
  String get abortMergeAction => 'إحباط الدمج';
  @override
  String stagingFile({required Object file}) =>
      'نقل ${file} للمرحلة المؤقت (Staging) للالتزام...';
  @override
  String conflictedFilesCount({required Object count}) =>
      'ملفات متعارضة (${count})';
  @override
  String get selectFileToResolve => 'حدد ملفاً لحله';
  @override
  String resolvingFile({required Object file}) => 'جارٍ حل: ${file}';
  @override
  String get keepAllOurs => 'الاحتفاظ بكل ما لدينا';
  @override
  String get acceptAllTheirs => 'قبول كل ما لديهم';
  @override
  String get allResolved => 'تم حل جميع التعارضات في هذا الملف!';
  @override
  String get markResolved => 'وضع علامة تم الحل';
  @override
  String get stageForCommit =>
      'سيؤدي هذا إلى نقل الملف للمرحلة المؤقتة للالتزام.';
  @override
  String conflictIndex({required Object index}) => 'تعارض #${index}';
  @override
  String get ours => 'لدينا (الحالي)';
  @override
  String get theirs => 'لديهم (الوارد)';
  @override
  String get keepOurs => 'الاحتفاظ بما لدينا';
  @override
  String get acceptTheirs => 'قبول ما لديهم';
  @override
  String get empty => '(فارغ)';
}

// Path: wizards.firstRun
class _TranslationsWizardsFirstRunAr implements TranslationsWizardsFirstRunEn {
  _TranslationsWizardsFirstRunAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get welcome => 'مرحباً في Localizer';
  @override
  String get description => 'قارن ملفات التوطين الخاصة بك في ثوانٍ.';
  @override
  String get sourceFile => 'ملف المصدر';
  @override
  String get targetFile => 'ملف الهدف';
  @override
  String get compareNow => 'قارن الآن';
  @override
  String get trySample => 'جرب مع بيانات العينة';
  @override
  String get skip => 'تخطي الإعداد';
  @override
  String get browse => 'انقر للتصفح';
  @override
  String error({required Object error}) => 'فشل تحميل بيانات العينة: ${error}';
}

// Path: dialogs.addIgnorePattern
class _TranslationsDialogsAddIgnorePatternAr
    implements TranslationsDialogsAddIgnorePatternEn {
  _TranslationsDialogsAddIgnorePatternAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'إضافة نمط تجاهل';
  @override
  String get patternLabel => 'النمط (regex)';
  @override
  String get hint => 'مثال: ^temp_.*';
  @override
  String get invalid => 'نمط regex غير صالح';
  @override
  String get testStringLabel => 'نص اختبار';
  @override
  String get testHint => 'أدخل مفتاحاً للاختبار ضد النمط';
  @override
  String get match => '✓ النمط يطابق نص الاختبار';
  @override
  String get noMatch => '✗ النمط لا يطابق';
  @override
  String get add => 'إضافة';
  @override
  String get cancel => 'إلغاء';
}

// Path: dialogs.diffViewer
class _TranslationsDialogsDiffViewerAr
    implements TranslationsDialogsDiffViewerEn {
  _TranslationsDialogsDiffViewerAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'عارض الفرق';
  @override
  String get originalFile => 'ملف الأصل/المرجع';
  @override
  String get translationFile => 'ملف الترجمة/المقارنة';
  @override
  String get base => 'BASE';
  @override
  String get target => 'TARGET';
  @override
  String get added => 'مضاف';
  @override
  String get removed => 'محذوف';
  @override
  String get modified => 'معدل';
  @override
  String get noMatches => 'لا توجد إدخالات تطابق الفلاتر الحالية';
  @override
  String get clickToggle => 'انقر على الشارات أعلاه لتبديل الفلاتر';
  @override
  String get clickToHide => '(انقر للإخفاء)';
  @override
  String get clickToShow => '(انقر للإظهار)';
}

// Path: grid.columns
class _TranslationsGridColumnsAr implements TranslationsGridColumnsEn {
  _TranslationsGridColumnsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'المفتاح';
  @override
  String get source => 'المصدر';
  @override
  String get status => 'الحالة';
  @override
  String get actions => 'إجراءات';
}

// Path: tutorial.steps
class _TranslationsTutorialStepsAr implements TranslationsTutorialStepsEn {
  _TranslationsTutorialStepsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTutorialStepsImportSourceAr importSource =
      _TranslationsTutorialStepsImportSourceAr._(_root);
  @override
  late final _TranslationsTutorialStepsImportTargetAr importTarget =
      _TranslationsTutorialStepsImportTargetAr._(_root);
  @override
  late final _TranslationsTutorialStepsCompareAr compare =
      _TranslationsTutorialStepsCompareAr._(_root);
  @override
  late final _TranslationsTutorialStepsFilterAr filter =
      _TranslationsTutorialStepsFilterAr._(_root);
  @override
  late final _TranslationsTutorialStepsSearchAr search =
      _TranslationsTutorialStepsSearchAr._(_root);
  @override
  late final _TranslationsTutorialStepsAdvancedAr advanced =
      _TranslationsTutorialStepsAdvancedAr._(_root);
  @override
  late final _TranslationsTutorialStepsExportAr export =
      _TranslationsTutorialStepsExportAr._(_root);
}

// Path: friendlyErrors.fileNotFound
class _TranslationsFriendlyErrorsFileNotFoundAr
    implements TranslationsFriendlyErrorsFileNotFoundEn {
  _TranslationsFriendlyErrorsFileNotFoundAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'لا يمكن العثور على الملف أو المجلد.';
  @override
  String get suggestion => 'تحقق ما إذا كان الملف قد تم نقله أو حذفه.';
}

// Path: friendlyErrors.accessDenied
class _TranslationsFriendlyErrorsAccessDeniedAr
    implements TranslationsFriendlyErrorsAccessDeniedEn {
  _TranslationsFriendlyErrorsAccessDeniedAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'تم رفض الوصول إلى الملف.';
  @override
  String get suggestion => 'حاول تشغيل التطبيق كمسؤول أو تحقق من أذونات الملف.';
}

// Path: friendlyErrors.isDirectory
class _TranslationsFriendlyErrorsIsDirectoryAr
    implements TranslationsFriendlyErrorsIsDirectoryEn {
  _TranslationsFriendlyErrorsIsDirectoryAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'تم تحديد مجلد بدلاً من ملف.';
  @override
  String get suggestion => 'يرجى تحديد ملف صالح.';
}

// Path: friendlyErrors.fileAccess
class _TranslationsFriendlyErrorsFileAccessAr
    implements TranslationsFriendlyErrorsFileAccessEn {
  _TranslationsFriendlyErrorsFileAccessAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'حدثت مشكلة في الوصول إلى الملف.';
  @override
  String get suggestion => 'حاول إغلاق البرامج الأخرى التي قد تستخدمه.';
}

// Path: friendlyErrors.unsupportedFormat
class _TranslationsFriendlyErrorsUnsupportedFormatAr
    implements TranslationsFriendlyErrorsUnsupportedFormatEn {
  _TranslationsFriendlyErrorsUnsupportedFormatAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'تنسيق الملف هذا أو العملية غير مدعومة.';
  @override
  String get suggestion => 'تحقق من امتداد الملف أو جرب تنسيقاً مختلفاً.';
}

// Path: friendlyErrors.networkError
class _TranslationsFriendlyErrorsNetworkErrorAr
    implements TranslationsFriendlyErrorsNetworkErrorEn {
  _TranslationsFriendlyErrorsNetworkErrorAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'تعذر الاتصال بالخادم.';
  @override
  String get suggestion => 'تحقق من اتصالك بالإنترنت وحاول مرة أخرى.';
}

// Path: friendlyErrors.notGitRepo
class _TranslationsFriendlyErrorsNotGitRepoAr
    implements TranslationsFriendlyErrorsNotGitRepoEn {
  _TranslationsFriendlyErrorsNotGitRepoAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'هذا المجلد ليس مشروع Git.';
  @override
  String get suggestion => 'انتقل إلى مجلد يحتوي على دليل .git.';
}

// Path: friendlyErrors.mergeConflict
class _TranslationsFriendlyErrorsMergeConflictAr
    implements TranslationsFriendlyErrorsMergeConflictEn {
  _TranslationsFriendlyErrorsMergeConflictAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'توجد تعارضات دمج في المستودع.';
  @override
  String get suggestion => 'قم بحل التعارضات قبل المتابعة.';
}

// Path: friendlyErrors.gitAuthFailed
class _TranslationsFriendlyErrorsGitAuthFailedAr
    implements TranslationsFriendlyErrorsGitAuthFailedEn {
  _TranslationsFriendlyErrorsGitAuthFailedAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'فشلت مصادقة Git.';
  @override
  String get suggestion =>
      'تحقق من بيانات اعتمادك في الإعدادات > التحكم في الإصدار.';
}

// Path: friendlyErrors.gitOperationFailed
class _TranslationsFriendlyErrorsGitOperationFailedAr
    implements TranslationsFriendlyErrorsGitOperationFailedEn {
  _TranslationsFriendlyErrorsGitOperationFailedAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'فشلت عملية Git.';
  @override
  String get suggestion => 'تحقق من عرض Git لمزيد من التفاصيل.';
}

// Path: friendlyErrors.invalidJson
class _TranslationsFriendlyErrorsInvalidJsonAr
    implements TranslationsFriendlyErrorsInvalidJsonEn {
  _TranslationsFriendlyErrorsInvalidJsonAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'تنسيق الملف غير صالح أو تالف.';
  @override
  String get suggestion => 'تأكد من أن الملف يحتوي على محتوى JSON صالح.';
}

// Path: friendlyErrors.rateLimitReached
class _TranslationsFriendlyErrorsRateLimitReachedAr
    implements TranslationsFriendlyErrorsRateLimitReachedEn {
  _TranslationsFriendlyErrorsRateLimitReachedAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'تم الوصول إلى حد الترجمة.';
  @override
  String get suggestion => 'انتظر بضع دقائق أو تحقق من حدود خطة API الخاصة بك.';
}

// Path: friendlyErrors.invalidApiKey
class _TranslationsFriendlyErrorsInvalidApiKeyAr
    implements TranslationsFriendlyErrorsInvalidApiKeyEn {
  _TranslationsFriendlyErrorsInvalidApiKeyAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'مفتاح API غير صالح.';
  @override
  String get suggestion =>
      'انتقل إلى الإعدادات > الترجمة بالذكاء الاصطناعي لتحديث مفتاح API الخاص بك.';
}

// Path: friendlyErrors.translationServiceError
class _TranslationsFriendlyErrorsTranslationServiceErrorAr
    implements TranslationsFriendlyErrorsTranslationServiceErrorEn {
  _TranslationsFriendlyErrorsTranslationServiceErrorAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'خطأ في خدمة الترجمة.';
  @override
  String get suggestion => 'تحقق من مفتاح API واتصالك بالإنترنت.';
}

// Path: friendlyErrors.outOfMemory
class _TranslationsFriendlyErrorsOutOfMemoryAr
    implements TranslationsFriendlyErrorsOutOfMemoryEn {
  _TranslationsFriendlyErrorsOutOfMemoryAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'لا توجد ذاكرة كافية لإكمال هذه العملية.';
  @override
  String get suggestion => 'حاول إغلاق التطبيقات الأخرى أو استخدام ملفات أصغر.';
}

// Path: friendlyErrors.genericError
class _TranslationsFriendlyErrorsGenericErrorAr
    implements TranslationsFriendlyErrorsGenericErrorEn {
  _TranslationsFriendlyErrorsGenericErrorAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'حدث خطأ ما.';
  @override
  String get suggestion =>
      'يرجى المحاولة مرة أخرى. إذا استمرت المشكلة، أعد تشغيل التطبيق.';
}

// Path: settings.appearance.presets
class _TranslationsSettingsAppearancePresetsAr
    implements TranslationsSettingsAppearancePresetsEn {
  _TranslationsSettingsAppearancePresetsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get presetDefault => 'الافتراضي';
  @override
  String get presetColorblind => 'صديق لعمى الألوان';
  @override
  String get presetHighContrast => 'تباين عالي';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.appearance.preview
class _TranslationsSettingsAppearancePreviewAr
    implements TranslationsSettingsAppearancePreviewEn {
  _TranslationsSettingsAppearancePreviewAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get step3Title => 'onboarding.step3.title';
  @override
  String get connectAccount => '"ربط حسابك"';
  @override
  String get loginHint => 'deprecated.login_hint_v1';
  @override
  String get enterCredentials => '"أدخل بيانات الاعتماد"';
  @override
  String get ctaButton => 'checkout.cta_button';
  @override
  String get buyNow => '"اشتر الآن"';
  @override
  String get completePurchase => '"إتمام الشراء"';
  @override
  String get appNameKey => 'common.app_name';
  @override
  String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class _TranslationsSettingsComparisonPatternPresetsAr
    implements TranslationsSettingsComparisonPatternPresetsEn {
  _TranslationsSettingsComparisonPatternPresetsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get comments => 'التعليقات';
  @override
  String get tempKeys => 'مفاتيح مؤقتة';
  @override
  String get placeholders => 'العناصر النائبة';
  @override
  String get devOnly => 'المطور فقط';
}

// Path: settings.comparison.previewMatch
class _TranslationsSettingsComparisonPreviewMatchAr
    implements TranslationsSettingsComparisonPreviewMatchEn {
  _TranslationsSettingsComparisonPreviewMatchAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'معاينة المطابقة';
  @override
  String get description =>
      'اختبر كيف تؤثر إعداداتك الحالية على منطق المطابقة.';
  @override
  String get stringA => 'النص أ';
  @override
  String get stringB => 'النص ب';
  @override
  String get enterText => 'أدخل نصا...';
  @override
  String get similarity => 'التشابه';
  @override
  String get identical => 'متطابق';
  @override
  String get identicalDescription => 'تتطابق النصوص تماماً بعد التسوية.';
  @override
  String get ignored => 'متجاهل';
  @override
  String get ignoredDescription => 'المدخل يطابق نمط تجاهل.';
  @override
  String get different => 'مختلف';
  @override
  String get differentDescription => 'أحد القيم فارغ.';
  @override
  String get similarModified => 'مشابه / معدل';
  @override
  String similarModifiedDescription({required Object threshold}) =>
      'درجة التطابق أعلى من العتبة (${threshold}%).';
  @override
  String get newDifferent => 'جديد / مختلف';
  @override
  String newDifferentDescription({required Object threshold}) =>
      'درجة التطابق أقل من العتبة (${threshold}%).';
}

// Path: settings.comparison.colorPresets
class _TranslationsSettingsComparisonColorPresetsAr
    implements TranslationsSettingsComparisonColorPresetsEn {
  _TranslationsSettingsComparisonColorPresetsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get kDefault => 'افتراضي';
  @override
  String get colorblindFriendly => 'صديق لعمى الألوان';
  @override
  String get highContrast => 'تباين عالي';
  @override
  String get nord => 'Nord';
  @override
  String get solarized => 'Solarized';
  @override
  String get monokai => 'Monokai';
  @override
  String get presetDefault => 'افتراضي';
  @override
  String get presetColorblind => 'صديق لعمى الألوان';
  @override
  String get presetHighContrast => 'تباين عالي';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.integrations.materials
class _TranslationsSettingsIntegrationsMaterialsAr
    implements TranslationsSettingsIntegrationsMaterialsEn {
  _TranslationsSettingsIntegrationsMaterialsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get sidebar => 'شريط جانبي';
  @override
  String get menu => 'قائمة';
  @override
  String get popover => 'منبثق';
  @override
  String get titlebar => 'شريط العنوان';
  @override
  String get underPageBackground => 'خلفية الصفحة';
  @override
  String get contentBackground => 'المحتوى';
}

// Path: settings.integrations.fileTypes
class _TranslationsSettingsIntegrationsFileTypesAr
    implements TranslationsSettingsIntegrationsFileTypesEn {
  _TranslationsSettingsIntegrationsFileTypesAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get loc => 'ملف مشروع Localizer';
  @override
  String get lang => 'ملف اللغة';
  @override
  String get json => 'ملف توطين JSON';
  @override
  String get xml => 'ملف توطين XML';
}

// Path: settings.developer.themePlaygroundSection
class _TranslationsSettingsDeveloperThemePlaygroundSectionAr
    implements TranslationsSettingsDeveloperThemePlaygroundSectionEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get colors => 'الألوان';
  @override
  String get typography => 'الطباعة';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteAr
      palette =
      _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteAr._(_root);
}

// Path: settings.developer.featureFlags
class _TranslationsSettingsDeveloperFeatureFlagsAr
    implements TranslationsSettingsDeveloperFeatureFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'ميزات تجريبية';
  @override
  String get description =>
      'تبديل ميزات تجريبية محلياً للاختبار. تستمر هذه التجاوزات عبر إعادة تشغيل التطبيق.';
  @override
  String get subtitle => 'تجاوز الميزات التجريبية';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAr flags =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsAr._(_root);
  @override
  String get reset => 'إعادة تعيين جميع العلامات';
  @override
  String get overrides => 'تجاوزات محلية';
  @override
  String get defaultVal => 'افتراضي';
  @override
  String get on => 'ON';
  @override
  String get off => 'OFF';
}

// Path: settings.developer.storageInspectorSection
class _TranslationsSettingsDeveloperStorageInspectorSectionAr
    implements TranslationsSettingsDeveloperStorageInspectorSectionEn {
  _TranslationsSettingsDeveloperStorageInspectorSectionAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'تحديث';
  @override
  String get hiveData => 'بيانات Hive';
  @override
  String get secureStorage => 'Secure Storage';
}

// Path: settings.developer.deviceInfoSection
class _TranslationsSettingsDeveloperDeviceInfoSectionAr
    implements TranslationsSettingsDeveloperDeviceInfoSectionEn {
  _TranslationsSettingsDeveloperDeviceInfoSectionAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'تحديث';
  @override
  String get copy => 'نسخ إلى الحافظة';
  @override
  String get computerName => 'اسم الكمبيوتر';
  @override
  String get osVersion => 'إصدار نظام التشغيل';
}

// Path: settings.developer.localizationInspectorSection
class _TranslationsSettingsDeveloperLocalizationInspectorSectionAr
    implements TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
  _TranslationsSettingsDeveloperLocalizationInspectorSectionAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get showKeys => 'إظهار المفاتيح بدلاً من القيم';
  @override
  String get keysVisible => 'المفاتيح مرئية';
  @override
  String get normalDisplay => 'عرض عادي';
  @override
  String get note =>
      'ملاحظة: تتطلب هذه الميزة أن يستخدم توطين التطبيق غلافاً يحترم هذا الإعداد.';
}

// Path: settings.settingsView.categories
class _TranslationsSettingsSettingsViewCategoriesAr
    implements TranslationsSettingsSettingsViewCategoriesEn {
  _TranslationsSettingsSettingsViewCategoriesAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'الإعدادات العامة';
  @override
  String get comparisonEngine => 'محرك المقارنة';
  @override
  String get appearance => 'المظهر';
  @override
  String get fileHandling => 'معالجة الملفات';
  @override
  String get aiServices => 'خدمات الذكاء الاصطناعي';
  @override
  String get systemIntegrations => 'تكاملات النظام';
  @override
  String get projectResources => 'موارد المشروع (المسرد وذاكرة الترجمة)';
  @override
  String get developer => 'خيارات المطور';
  @override
  String get about => 'حول';
}

// Path: settings.settingsView.categoryLabels
class _TranslationsSettingsSettingsViewCategoryLabelsAr
    implements TranslationsSettingsSettingsViewCategoryLabelsEn {
  _TranslationsSettingsSettingsViewCategoryLabelsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'عام';
  @override
  String get comparisonEngine => 'المقارنة';
  @override
  String get appearance => 'المظهر';
  @override
  String get fileHandling => 'معالجة الملفات';
  @override
  String get aiServices => 'خدمات الذكاء الاصطناعي';
  @override
  String get systemIntegrations => 'تكاملات النظام';
  @override
  String get projectResources => 'موارد المشروع';
  @override
  String get developer => 'خيارات المطور';
  @override
  String get about => 'حول';
}

// Path: settings.onboarding.steps
class _TranslationsSettingsOnboardingStepsAr
    implements TranslationsSettingsOnboardingStepsEn {
  _TranslationsSettingsOnboardingStepsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsOnboardingStepsImportFilesAr importFiles =
      _TranslationsSettingsOnboardingStepsImportFilesAr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsRunComparisonAr runComparison =
      _TranslationsSettingsOnboardingStepsRunComparisonAr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsReviewMissingAr reviewMissing =
      _TranslationsSettingsOnboardingStepsReviewMissingAr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsUseFiltersAr useFilters =
      _TranslationsSettingsOnboardingStepsUseFiltersAr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsSearchResultsAr searchResults =
      _TranslationsSettingsOnboardingStepsSearchResultsAr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsAdvancedViewAr advancedView =
      _TranslationsSettingsOnboardingStepsAdvancedViewAr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsEditCellAr editCell =
      _TranslationsSettingsOnboardingStepsEditCellAr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsExportResultsAr exportResults =
      _TranslationsSettingsOnboardingStepsExportResultsAr._(_root);
}

// Path: advancedDiff.sidebar.actionsSection
class _TranslationsAdvancedDiffSidebarActionsSectionAr
    implements TranslationsAdvancedDiffSidebarActionsSectionEn {
  _TranslationsAdvancedDiffSidebarActionsSectionAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get exportMatches => 'تصدير التطابقات';
  @override
  String get preview => 'معاينة';
  @override
  String get fillFromTmTitle => 'الملء من ذاكرة الترجمة؟';
  @override
  String get fillFromTmContent =>
      'سيحاول هذا ملء قيم الهدف الفارغة باستخدام تطابقات من ذاكرة الترجمة. لن يتم استبدال القيم الموجودة.';
  @override
  String get fill => 'ملء';
  @override
  String get fillFromMemory => 'ملء من الذاكرة';
  @override
  String filledFromTm({required Object count}) =>
      'تم ملء ${count} عناصر من ذاكرة الترجمة.';
}

// Path: advancedDiff.sidebar.aiSection
class _TranslationsAdvancedDiffSidebarAiSectionAr
    implements TranslationsAdvancedDiffSidebarAiSectionEn {
  _TranslationsAdvancedDiffSidebarAiSectionAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get infoCloud =>
      'يستخدم الترجمة السحابية لترجمة قيم الهدف الفارغة من المصدر.';
  @override
  String get infoAi =>
      'يستخدم الذكاء الاصطناعي لترجمة قيم الهدف الفارغة من المصدر.';
  @override
  String get translationSettings => 'إعدادات الترجمة';
  @override
  String get aiSettings => 'إعدادات الذكاء الاصطناعي';
  @override
  String get source => 'المصدر';
  @override
  String get target => 'الهدف';
  @override
  String translatingProgress({required Object percent}) =>
      'جارٍ الترجمة... ${percent}%';
  @override
  String get translating => 'جارٍ الترجمة...';
  @override
  String get translateAllMissing => 'ترجمة كل المفقود';
  @override
  String get translateAllTitle => 'ترجمة كل المفقود؟';
  @override
  String translateAllContent(
          {required Object service,
          required Object source,
          required Object target}) =>
      'سيستخدم هذا ${service} لترجمة جميع الإدخالات ذات القيم الفارغة من ${source} إلى ${target}.\n\nيمكنك مراجعة كل اقتراح أو تطبيق الكل دفعة واحدة.';
  @override
  String get translateAll => 'ترجمة الكل';
  @override
  String get reviewEach => 'مراجعة كل واحد';
  @override
  String cloudTranslated({required Object count}) =>
      'تمت ترجمة ${count} إدخالات بالترجمة السحابية.';
  @override
  String aiTranslated({required Object count}) =>
      'تمت ترجمة ${count} إدخالات بالذكاء الاصطناعي.';
  @override
  String get aiTranslateFailed => 'فشلت ترجمة الكل بالذكاء الاصطناعي';
  @override
  String get noMissingEntries => 'لا توجد إدخالات مفقودة للترجمة.';
  @override
  String get skip => 'تخطي';
  @override
  String get stop => 'إيقاف';
  @override
  String cloudApplied({required Object count}) => 'تم تطبيق ${count} اقتراحات.';
  @override
  String aiApplied({required Object count}) =>
      'تم تطبيق ${count} اقتراحات ذكاء اصطناعي.';
}

// Path: advancedDiff.sidebar.tmSection
class _TranslationsAdvancedDiffSidebarTmSectionAr
    implements TranslationsAdvancedDiffSidebarTmSectionEn {
  _TranslationsAdvancedDiffSidebarTmSectionAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get enableTmFill => 'تفعيل ملء الذاكرة';
  @override
  String get autoApplyAboveMinimum => 'تطبيق تلقائي فوق الحد الأدنى';
  @override
  String get matchSettings => 'إعدادات المطابقة';
  @override
  String get minMatch => 'أدنى تطابق:';
  @override
  String get limit => 'الحد:';
  @override
  String get exact => 'تام';
}

// Path: advancedDiff.sidebar.filtersSection
class _TranslationsAdvancedDiffSidebarFiltersSectionAr
    implements TranslationsAdvancedDiffSidebarFiltersSectionEn {
  _TranslationsAdvancedDiffSidebarFiltersSectionAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get viewFilters => 'فلاتر العرض';
  @override
  String get showAll => 'عرض الكل';
  @override
  String get added => 'مضاف';
  @override
  String get removed => 'محذوف';
  @override
  String get modified => 'معدل';
  @override
  String get actionScope => 'نطاق الإجراء';
  @override
  String get applyToAdded => 'تطبيق على المضاف';
  @override
  String get applyToModified => 'تطبيق على المعدل';
  @override
  String get onlyFillEmptyTargets => 'ملء الأهداف الفارغة فقط';
  @override
  String get limitToVisible => 'قصر على المرئي';
  @override
  String get editMode => 'وضع التعديل';
  @override
  String get dialog => 'حوار';
  @override
  String get inline => 'مضمن';
}

// Path: advancedDiff.sidebar.similaritySection
class _TranslationsAdvancedDiffSidebarSimilaritySectionAr
    implements TranslationsAdvancedDiffSidebarSimilaritySectionEn {
  _TranslationsAdvancedDiffSidebarSimilaritySectionAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get currentFilter => 'الفلتر الحالي:';
  @override
  String get any => 'أي';
  @override
  String get high => 'عالي';
  @override
  String get medium => 'متوسط';
  @override
  String get low => 'منخفض';
}

// Path: advancedDiff.sidebar.statusSection
class _TranslationsAdvancedDiffSidebarStatusSectionAr
    implements TranslationsAdvancedDiffSidebarStatusSectionEn {
  _TranslationsAdvancedDiffSidebarStatusSectionAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String total({required Object count}) => '${count} إجمالي';
  @override
  String extra({required Object count}) => '${count} إضافي';
  @override
  String missing({required Object count}) => '${count} مفقود';
  @override
  String changed({required Object count}) => '${count} متغير';
}

// Path: tutorial.steps.importSource
class _TranslationsTutorialStepsImportSourceAr
    implements TranslationsTutorialStepsImportSourceEn {
  _TranslationsTutorialStepsImportSourceAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '1. استيراد ملف المصدر';
  @override
  String get description =>
      'استخدم الزر أدناه لتصفح الملف، أو اسحب وأفلت في المنطقة المظللة.';
}

// Path: tutorial.steps.importTarget
class _TranslationsTutorialStepsImportTargetAr
    implements TranslationsTutorialStepsImportTargetEn {
  _TranslationsTutorialStepsImportTargetAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '2. استيراد ملف الهدف';
  @override
  String get description =>
      'استخدم الزر أدناه لتصفح الملف، أو اسحب وأفلت في المنطقة المظللة.';
}

// Path: tutorial.steps.compare
class _TranslationsTutorialStepsCompareAr
    implements TranslationsTutorialStepsCompareEn {
  _TranslationsTutorialStepsCompareAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '3. مقارنة الملفات';
  @override
  String get description =>
      'انقر على الزر أدناه لتشغيل المقارنة ورؤية النتائج.';
}

// Path: tutorial.steps.filter
class _TranslationsTutorialStepsFilterAr
    implements TranslationsTutorialStepsFilterEn {
  _TranslationsTutorialStepsFilterAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '4. تصفية النتائج';
  @override
  String get description =>
      'استخدم هذه الفلاتر لعرض السلاسل المضافة، المحذوفة، أو المعدلة.';
}

// Path: tutorial.steps.search
class _TranslationsTutorialStepsSearchAr
    implements TranslationsTutorialStepsSearchEn {
  _TranslationsTutorialStepsSearchAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '5. نتائج البحث';
  @override
  String get description => 'اعثر على مفاتيح أو قيم محددة باستخدام شريط البحث.';
}

// Path: tutorial.steps.advanced
class _TranslationsTutorialStepsAdvancedAr
    implements TranslationsTutorialStepsAdvancedEn {
  _TranslationsTutorialStepsAdvancedAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '6. العرض المتقدم';
  @override
  String get description =>
      'افتح عرض الفرق التفصيلي مع التعديل، والترجمة بالذكاء الاصطناعي، والمزيد.';
}

// Path: tutorial.steps.export
class _TranslationsTutorialStepsExportAr
    implements TranslationsTutorialStepsExportEn {
  _TranslationsTutorialStepsExportAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '7. تصدير النتائج';
  @override
  String get description => 'احفظ مقارنتك كملف CSV، JSON، أو Excel.';
}

// Path: settings.developer.themePlaygroundSection.palette
class _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteAr
    implements TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

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
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAr
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchAr
      experimental_ai_batch =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchAr._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmAr
      new_diff_algorithm =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmAr._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchAr
      enhanced_search =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchAr._(_root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveAr
      auto_save =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveAr._(_root);
}

// Path: settings.onboarding.steps.importFiles
class _TranslationsSettingsOnboardingStepsImportFilesAr
    implements TranslationsSettingsOnboardingStepsImportFilesEn {
  _TranslationsSettingsOnboardingStepsImportFilesAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'استيراد الملفات';
  @override
  String get description => 'تحميل ملفات المصدر والهدف';
}

// Path: settings.onboarding.steps.runComparison
class _TranslationsSettingsOnboardingStepsRunComparisonAr
    implements TranslationsSettingsOnboardingStepsRunComparisonEn {
  _TranslationsSettingsOnboardingStepsRunComparisonAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'تشغيل المقارنة';
  @override
  String get description => 'انقر على "مقارنة الملفات"';
}

// Path: settings.onboarding.steps.reviewMissing
class _TranslationsSettingsOnboardingStepsReviewMissingAr
    implements TranslationsSettingsOnboardingStepsReviewMissingEn {
  _TranslationsSettingsOnboardingStepsReviewMissingAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'مراجعة المفاتيح المفقودة';
  @override
  String get description => 'لاحظ العناصر المفقودة الحمراء';
}

// Path: settings.onboarding.steps.useFilters
class _TranslationsSettingsOnboardingStepsUseFiltersAr
    implements TranslationsSettingsOnboardingStepsUseFiltersEn {
  _TranslationsSettingsOnboardingStepsUseFiltersAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'استخدام الفلاتر';
  @override
  String get description => 'تصفية حسب النوع';
}

// Path: settings.onboarding.steps.searchResults
class _TranslationsSettingsOnboardingStepsSearchResultsAr
    implements TranslationsSettingsOnboardingStepsSearchResultsEn {
  _TranslationsSettingsOnboardingStepsSearchResultsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'نتائج البحث';
  @override
  String get description => 'العثور على مفاتيح محددة';
}

// Path: settings.onboarding.steps.advancedView
class _TranslationsSettingsOnboardingStepsAdvancedViewAr
    implements TranslationsSettingsOnboardingStepsAdvancedViewEn {
  _TranslationsSettingsOnboardingStepsAdvancedViewAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'عرض متقدم';
  @override
  String get description => 'استكشاف التحليل التفصيلي';
}

// Path: settings.onboarding.steps.editCell
class _TranslationsSettingsOnboardingStepsEditCellAr
    implements TranslationsSettingsOnboardingStepsEditCellEn {
  _TranslationsSettingsOnboardingStepsEditCellAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'تحرير خلية';
  @override
  String get description => 'انقر لتحرير قيمة';
}

// Path: settings.onboarding.steps.exportResults
class _TranslationsSettingsOnboardingStepsExportResultsAr
    implements TranslationsSettingsOnboardingStepsExportResultsEn {
  _TranslationsSettingsOnboardingStepsExportResultsAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'تصدير';
  @override
  String get description => 'حفظ تقريرك';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchAr
    implements
        TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchAr._(
      this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'الذكاء الاصطناعي الدفعي التجريبي';
  @override
  String get description => 'تفعيل ترجمة الذكاء الاصطناعي الدفعية لصفوف متعددة';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmAr
    implements
        TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmAr._(
      this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'خوارزمية فرق جديدة';
  @override
  String get description => 'استخدام خوارزمية فرق محسنة للمقارنات';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchAr
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'بحث محسن';
  @override
  String get description => 'تفعيل البحث الضبابي في ملفات الترجمة';
}

// Path: settings.developer.featureFlags.flags.auto_save
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveAr
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveAr._(this._root);

  final TranslationsAr _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'حفظ تلقائي';
  @override
  String get description => 'حفظ التغييرات تلقائياً بعد التعديلات';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
          'app.title' => 'أداة مقارنة الترجمة',
          'app.name' => 'Localizer',
          'common.save' => 'حفظ',
          'common.cancel' => 'إلغاء',
          'common.close' => 'إغلاق',
          'common.delete' => 'حذف',
          'common.edit' => 'تعديل',
          'common.add' => 'إضافة',
          'common.search' => 'بحث',
          'common.undo' => 'تراجع',
          'common.loading' => 'جارٍ التحميل...',
          'common.error' => 'خطأ',
          'common.success' => 'نجاح',
          'common.warning' => 'تحذير',
          'common.info' => 'معلومات',
          'common.confirm' => 'تأكيد',
          'common.yes' => 'نعم',
          'common.no' => 'لا',
          'common.ok' => 'موافق',
          'common.retry' => 'إعادة المحاولة',
          'common.copyText' => 'نسخ',
          'common.appName' => 'Localizer',
          'common.copied' => 'تم النسخ!',
          'common.enabled' => 'مفعّل',
          'common.disabled' => 'معطّل',
          'common.browse' => 'تصفح',
          'common.clear' => 'مسح',
          'common.apply' => 'تطبيق',
          'common.reset' => 'إعادة تعيين',
          'common.refresh' => 'تحديث',
          'common.export' => 'تصدير',
          'common.import' => 'استيراد',
          'common.select' => 'تحديد',
          'common.selectAll' => 'تحديد الكل',
          'common.deselectAll' => 'إلغاء تحديد الكل',
          'common.noResults' => 'لا توجد نتائج',
          'common.emptyState' => 'لا شيء هنا بعد',
          'common.open' => 'فتح',
          'common.change' => 'تغيير',
          'common.original' => 'الأصلي',
          'common.kNew' => 'الجديد',
          'common.remove' => 'إزالة',
          'common.auto' => 'تلقائي',
          'common.execute' => 'تنفيذ',
          'common.run' => 'تشغيل',
          'common.unknown' => 'غير معروف',
          'common.download' => 'تنزيل',
          'common.dropdownArrow' => 'سهم القائمة المنسدلة',
          'common.openInNewWindow' => 'فتح في نافذة جديدة',
          'common.resetToDefaults' => 'إعادة تعيين للافتراضيات',
          'menu.file' => 'ملف',
          'menu.edit' => 'تحرير',
          'menu.view' => 'عرض',
          'menu.help' => 'مساعدة',
          'menu.openFiles' => 'فتح ملفات...',
          'menu.openFolder' => 'فتح مجلد...',
          'menu.exportResults' => 'تصدير النتائج...',
          'menu.undo' => 'تراجع',
          'menu.redo' => 'إعادة',
          'menu.cut' => 'قص',
          'menu.paste' => 'لصق',
          'menu.selectAll' => 'تحديد الكل',
          'menu.zoomIn' => 'تكيبر',
          'menu.zoomOut' => 'تصغير',
          'menu.resetZoom' => 'إعادة تعيين التكبير/التصغير',
          'menu.documentation' => 'الوثائق',
          'menu.reportIssue' => 'الإبلاغ عن مشكلة',
          'menu.about' => ({required Object appName}) => 'حول ${appName}',
          'nav.compare' => 'مقارنة',
          'nav.history' => 'السجل',
          'nav.settings' => 'الإعدادات',
          'nav.projects' => 'المشاريع',
          'nav.dashboard' => 'لوحة القيادة',
          'nav.directory' => 'الدليل',
          'nav.repository' => 'المستودع',
          'nav.tooltipCompare' => 'مقارنة ملفات الترجمة',
          'nav.tooltipHistory' => 'عرض سجل المقارنة',
          'nav.tooltipSettings' => 'إعدادات التطبيق',
          'nav.tooltipProjects' => 'إدارة المشاريع',
          'nav.tooltipThemeToggle' => 'تبديل المظهر',
          'nav.tooltipDebugConsole' => 'وحدة تحكم التصحيح',
          'settings.title' => 'الإعدادات',
          'settings.appSettings' => 'إعدادات التطبيق',
          'settings.projectSettings' => 'إعدادات المشروع',
          'settings.appearance.title' => 'المظهر',
          'settings.appearance.description' => 'تخصيص شكل ومظهر التطبيق',
          'settings.appearance.theme' => 'وضع المظهر',
          'settings.appearance.themeDescription' =>
            'اختر بين الفاتح، الداكن، أو مظهر النظام',
          'settings.appearance.themeSystem' => 'النظام',
          'settings.appearance.themeLight' => 'فاتح',
          'settings.appearance.themeDark' => 'داكن',
          'settings.appearance.themeAmoled' => 'AMOLED',
          'settings.appearance.accentColor' => 'لون التمييز',
          'settings.appearance.accentColorDescription' =>
            'اختر لون التمييز المفضل لديك',
          'settings.appearance.useMicaEffect' => 'استخدام تأثير Mica',
          'settings.appearance.micaDescription' =>
            'تفعيل تأثير شفافية Mica الخاص بـ Windows 11 لمظهر عصري',
          'settings.appearance.diffFontSize' => 'حجم خط المقارنة',
          'settings.appearance.diffFontSizeDescription' =>
            'ضبط حجم الخط في عرض المقارنة',
          'settings.appearance.diffFontFamily' => 'خط المقارنة',
          'settings.appearance.diffFontFamilyDescription' =>
            'الخط المستخدم في عرض المقارنة',
          'settings.appearance.systemDefault' => 'افتراضي النظام',
          'settings.appearance.pickAccentColor' => 'اختر لون التمييز',
          'settings.appearance.diffColors' => 'ألوان المقارنة',
          'settings.appearance.presetsTitle' => 'إعدادات مسبقة',
          'settings.appearance.presets.presetDefault' => 'الافتراضي',
          'settings.appearance.presets.presetColorblind' => 'صديق لعمى الألوان',
          'settings.appearance.presets.presetHighContrast' => 'تباين عالي',
          'settings.appearance.presets.presetNord' => 'Nord',
          'settings.appearance.presets.presetSolarized' => 'Solarized',
          'settings.appearance.presets.presetMonokai' => 'Monokai',
          'settings.appearance.identical' => 'متطابق',
          'settings.appearance.pickColorFor' => ({required Object label}) =>
              'اختر لون لـ ${label}',
          'settings.appearance.livePreview' => 'معاينة حية',
          'settings.appearance.preview.step3Title' => 'onboarding.step3.title',
          'settings.appearance.preview.connectAccount' => '"ربط حسابك"',
          'settings.appearance.preview.loginHint' => 'deprecated.login_hint_v1',
          'settings.appearance.preview.enterCredentials' =>
            '"أدخل بيانات الاعتماد"',
          'settings.appearance.preview.ctaButton' => 'checkout.cta_button',
          'settings.appearance.preview.buyNow' => '"اشتر الآن"',
          'settings.appearance.preview.completePurchase' => '"إتمام الشراء"',
          'settings.appearance.preview.appNameKey' => 'common.app_name',
          'settings.appearance.preview.appNameValue' => '"Localizer"',
          'settings.general.title' => 'عام',
          'settings.general.description' => 'إعدادات التطبيق العامة',
          'settings.general.language' => 'الغة',
          'settings.general.languageDescription' => 'اختر لغتك المفضلة',
          'settings.general.startMinimized' => 'بدء مصغر في علبة النظام',
          'settings.general.startMinimizedDescription' =>
            'بدء تشغيل التطبيق مصغراً في علبة النظام',
          'settings.general.rememberWindowPosition' => 'تذكر موقع النافذة',
          'settings.general.rememberWindowPositionDescription' =>
            'استعادة حجم وموقع النافذة عند بدء التشغيل',
          'settings.general.openLastProject' => 'فتح آخر مشروع عند البدء',
          'settings.general.openLastProjectDescription' =>
            'فتح آخر مشروع مستخدم تلقائياً عند بدء تشغيل التطبيق',
          'settings.general.application' => 'التطبيق',
          'settings.general.defaultView' => 'العرض الافتراضي',
          'settings.general.defaultViewDescription' =>
            'العرض الذي يظهر عند بدء التشغيل',
          'settings.general.autoCheckUpdates' => 'التحقق التلقائي من التحديثات',
          'settings.general.autoCheckUpdatesDescription' =>
            'التحقق من وجود تحديثات عند بدء التشغيل',
          'settings.general.startupOptions' => 'خيارات بدء التشغيل',
          'settings.general.languageAuto' => 'اكتشاف تلقائي',
          'settings.general.viewBasic' => 'مقارنة الملفات',
          'settings.general.viewHistory' => 'السجل',
          'settings.general.viewDashboard' => 'لوحة الجودة',
          'settings.general.viewDirectory' => 'مقارنة الأدلة',
          'settings.general.viewLastUsed' => 'آخر عرض مستخدم',
          'settings.scope.title' => 'نطاق الإعدادات',
          'settings.scope.global' => 'الافتراضيات العالمية',
          'settings.scope.project' => 'المشروع',
          'settings.scope.reset' => 'إعادة تعيين المشروع للافتراضيات العالمية',
          'settings.scope.resetConfirmation' =>
            'سيؤدي هذا إلى مسح جميع التجاوزات لهذا المشروع والعودة إلى الافتراضيات العالمية. هذا الإجراء لا يمكن التراجع عنه.',
          'settings.scope.globalDescription' =>
            'تنطبق التغييرات على جميع المشاريع ما لم يتم تجاوزها.',
          'settings.scope.projectDescription' => ({required Object name}) =>
              'تنطبق التغييرات فقط على "${name}". الإعدادات الأخرى ترث من الافتراضيات العالمية.',
          'settings.scope.createPrompt' =>
            'أنشئ مشروعاً لتخصيص الإعدادات لمجلدات محددة',
          'settings.searchKeywords.general.0' => 'اللغة',
          'settings.searchKeywords.general.1' => 'العرض الافتراضي',
          'settings.searchKeywords.general.2' => 'عدد الملفات الحديثة',
          'settings.searchKeywords.general.3' => 'فتح آخر مشروع',
          'settings.searchKeywords.general.4' => 'تأكيد قبل الخروج',
          'settings.searchKeywords.general.5' => 'إظهار الإشعارات',
          'settings.searchKeywords.comparisonEngine.0' => 'وضع المقارنة',
          'settings.searchKeywords.comparisonEngine.1' => 'عتبة التشابه',
          'settings.searchKeywords.comparisonEngine.2' => 'حساس لحالة الأحرف',
          'settings.searchKeywords.comparisonEngine.3' =>
            'تجاهل المسافات البيضاء',
          'settings.searchKeywords.comparisonEngine.4' =>
            'تجاهل الأسطر الفارغة',
          'settings.searchKeywords.comparisonEngine.5' => 'تجاهل التعليقات',
          'settings.searchKeywords.comparisonEngine.6' => 'تجاهل الأنماط',
          'settings.searchKeywords.appearance.0' => 'المظهر',
          'settings.searchKeywords.appearance.1' => 'وضع المظهر',
          'settings.searchKeywords.appearance.2' => 'لون التمييز',
          'settings.searchKeywords.appearance.3' => 'حجم خط المقارنة',
          'settings.searchKeywords.appearance.4' => 'خط المقارنة',
          'settings.searchKeywords.appearance.5' => 'ألوان المقارنة',
          'settings.searchKeywords.appearance.6' => 'لون المضاف',
          'settings.searchKeywords.appearance.7' => 'لون المحذوف',
          'settings.searchKeywords.appearance.8' => 'لون المعدل',
          'settings.searchKeywords.appearance.9' => 'لون المتطابق',
          'settings.searchKeywords.appearance.10' => 'إعدادات الألوان المسبقة',
          'settings.searchKeywords.appearance.11' => 'معاينة',
          'settings.searchKeywords.fileHandling.0' => 'تنسيق المصدر',
          'settings.searchKeywords.fileHandling.1' => 'تنسيق الهدف',
          'settings.searchKeywords.fileHandling.2' => 'الترميز الافتراضي',
          'settings.searchKeywords.fileHandling.3' => 'عدد المشاريع الحديثة',
          'settings.searchKeywords.fileHandling.4' => 'ذاكرة الترجمة',
          'settings.searchKeywords.fileHandling.5' => 'استيراد الذاكرة',
          'settings.searchKeywords.fileHandling.6' => 'تصدير الذاكرة',
          'settings.searchKeywords.fileHandling.7' => 'مسح الذاكرة',
          'settings.searchKeywords.aiServices.0' =>
            'مفتاح واجهة برمجة تطبيقات OpenAI',
          'settings.searchKeywords.aiServices.1' =>
            'مفتاح واجهة برمجة تطبيقات Anthropic',
          'settings.searchKeywords.aiServices.2' =>
            'مفتاح واجهة برمجة تطبيقات Google AI',
          'settings.searchKeywords.aiServices.3' => 'نموذج الذكاء الاصطناعي',
          'settings.searchKeywords.aiServices.4' => 'درجة الحرارة',
          'settings.searchKeywords.aiServices.5' => 'موجه مخصص',
          'settings.searchKeywords.systemIntegrations.0' => 'علبة النظام',
          'settings.searchKeywords.systemIntegrations.1' => 'بدء مصغر',
          'settings.searchKeywords.systemIntegrations.2' => 'ارتباطات الملفات',
          'settings.searchKeywords.systemIntegrations.3' => 'تأثير Mica',
          'settings.searchKeywords.systemIntegrations.4' => 'الحيوية',
          'settings.searchKeywords.systemIntegrations.5' => 'مادة النافذة',
          'settings.searchKeywords.systemIntegrations.6' => 'شارة الرصيف',
          'settings.searchKeywords.systemIntegrations.7' => 'عدد غير المترجمة',
          'settings.searchKeywords.projectResources.0' => 'مسرد المصطلحات',
          'settings.searchKeywords.projectResources.1' => 'ذاكرة الترجمة',
          'settings.searchKeywords.projectResources.2' => 'المصطلحات',
          'settings.searchKeywords.about.0' => 'الإصدار',
          'settings.searchKeywords.about.1' => 'التحقق من التحديثات',
          'settings.searchKeywords.about.2' => 'تحديث تلقائي',
          'settings.searchKeywords.about.3' => 'سجل التغييرات',
          'settings.searchKeywords.about.4' => 'الرخصة',
          'settings.searchKeywords.about.5' => 'سياسة الخصوصية',
          'settings.searchKeywords.about.6' => 'القياس عن بعد',
          'settings.searchKeywords.about.7' => 'الإبلاغ عن الأعطال',
          'settings.searchKeywords.developer.0' => 'تراكب الأداء',
          'settings.searchKeywords.developer.1' => 'مصحح الدلالات',
          'settings.searchKeywords.developer.2' => 'شبكة المواد',
          'settings.searchKeywords.developer.3' => 'تخزين الصور النقطية مؤقتاً',
          'settings.searchKeywords.developer.4' =>
            'إعادة تشغيل البرنامج التعليمي',
          'settings.searchKeywords.developer.5' => 'إعادة ضبط المصنع',
          'settings.comparison.title' => 'المقارنة',
          'settings.comparison.description' => 'تكوين سلوك المقارنة',
          'settings.comparison.caseSensitive' => 'حساس لحالة الأحرف',
          'settings.comparison.caseSensitiveDescription' =>
            'معاملة الأحرف الكبيرة والصغيرة كمختلفة',
          'settings.comparison.ignoreWhitespace' => 'تجاهل المسافات البيضاء',
          'settings.comparison.ignoreWhitespaceDescription' =>
            'تجاهل المسافة البيضاء في البداية/النهاية عند المقارنة',
          'settings.comparison.showLineNumbers' => 'إظهار أرقام الأسطر',
          'settings.comparison.showLineNumbersDescription' =>
            'عرض أرقام الأسطر في عرض الفرق',
          'settings.comparison.behavior' => 'سلوك المقارنة',
          'settings.comparison.ignoreCase' => 'تجاهل حالة الأحرف',
          'settings.comparison.ignoreCaseDescription' =>
            'معاملة "Key" و "key" كشيء واحد',
          'settings.comparison.similarityThreshold' => 'عتبة التشابه',
          'settings.comparison.similarityThresholdDescription' =>
            'الحد الأدنى للتشابه لاكتشاف "المعدل"',
          'settings.comparison.mode' => 'وضع المقارنة',
          'settings.comparison.modeDescription' =>
            'كيفية مطابقة الإدخالات بين الملفات',
          'settings.comparison.modeKey' => 'مستند إلى المفتاح',
          'settings.comparison.modeKeyDescription' =>
            'يطابق بناءً على اسم المفتاح (افتراضي).',
          'settings.comparison.modeOrder' => 'مستند إلى الترتيب',
          'settings.comparison.modeOrderDescription' =>
            'يطابق بناءً على الموضع في الملف.',
          'settings.comparison.modeSmart' => 'مطابقة ذكية',
          'settings.comparison.modeSmartDescription' =>
            'يكتشف المفاتيح المنقولة/المعاد تسميتها.',
          'settings.comparison.ignorePatterns' => 'أنماط التجاهل',
          'settings.comparison.noIgnorePatterns' => 'لم يتم تعيين أنماط تجاهل.',
          'settings.comparison.addPattern' => 'إضافة نمط',
          'settings.comparison.resetToGlobal' =>
            'إعادة تعيين جميع إعدادات المقارنة للافتراضيات العالمية',
          'settings.comparison.patternPresets.comments' => 'التعليقات',
          'settings.comparison.patternPresets.tempKeys' => 'مفاتيح مؤقتة',
          'settings.comparison.patternPresets.placeholders' =>
            'العناصر النائبة',
          'settings.comparison.patternPresets.devOnly' => 'المطور فقط',
          'settings.comparison.previewMatch.title' => 'معاينة المطابقة',
          'settings.comparison.previewMatch.description' =>
            'اختبر كيف تؤثر إعداداتك الحالية على منطق المطابقة.',
          'settings.comparison.previewMatch.stringA' => 'النص أ',
          'settings.comparison.previewMatch.stringB' => 'النص ب',
          'settings.comparison.previewMatch.enterText' => 'أدخل نصا...',
          'settings.comparison.previewMatch.similarity' => 'التشابه',
          'settings.comparison.previewMatch.identical' => 'متطابق',
          'settings.comparison.previewMatch.identicalDescription' =>
            'تتطابق النصوص تماماً بعد التسوية.',
          'settings.comparison.previewMatch.ignored' => 'متجاهل',
          'settings.comparison.previewMatch.ignoredDescription' =>
            'المدخل يطابق نمط تجاهل.',
          'settings.comparison.previewMatch.different' => 'مختلف',
          'settings.comparison.previewMatch.differentDescription' =>
            'أحد القيم فارغ.',
          'settings.comparison.previewMatch.similarModified' => 'مشابه / معدل',
          'settings.comparison.previewMatch.similarModifiedDescription' => (
                  {required Object threshold}) =>
              'درجة التطابق أعلى من العتبة (${threshold}%).',
          'settings.comparison.previewMatch.newDifferent' => 'جديد / مختلف',
          'settings.comparison.previewMatch.newDifferentDescription' => (
                  {required Object threshold}) =>
              'درجة التطابق أقل من العتبة (${threshold}%).',
          'settings.comparison.colorPresets.kDefault' => 'افتراضي',
          'settings.comparison.colorPresets.colorblindFriendly' =>
            'صديق لعمى الألوان',
          'settings.comparison.colorPresets.highContrast' => 'تباين عالي',
          'settings.comparison.colorPresets.nord' => 'Nord',
          'settings.comparison.colorPresets.solarized' => 'Solarized',
          'settings.comparison.colorPresets.monokai' => 'Monokai',
          'settings.comparison.colorPresets.presetDefault' => 'افتراضي',
          'settings.comparison.colorPresets.presetColorblind' =>
            'صديق لعمى الألوان',
          'settings.comparison.colorPresets.presetHighContrast' => 'تباين عالي',
          'settings.comparison.colorPresets.presetNord' => 'Nord',
          'settings.comparison.colorPresets.presetSolarized' => 'Solarized',
          'settings.comparison.colorPresets.presetMonokai' => 'Monokai',
          'settings.fileHandling.fileFormats' => 'تنسيقات الملفات',
          'settings.fileHandling.sourceFormat' => 'تنسيق المصدر',
          'settings.fileHandling.targetFormat' => 'تنسيق الهدف',
          'settings.fileHandling.encoding' => 'الترميز',
          'settings.fileHandling.sourceEncoding' => 'ترميز المصدر',
          'settings.fileHandling.targetEncoding' => 'ترميز الهدف',
          'settings.fileHandling.autoDetect' => 'اكتشاف تلقائي',
          'settings.fileHandling.autoDetectEncodingDescription' =>
            'الكشف التلقائي عن ترميز الملف',
          'settings.fileHandling.exportSettings' => 'إعدادات التصدير',
          'settings.fileHandling.defaultExportFormat' =>
            'تنسيق التصدير الافتراضي',
          'settings.fileHandling.includeUtf8Bom' => 'تضمين UTF-8 BOM',
          'settings.fileHandling.includeUtf8BomDescription' =>
            'مطلوب لتوافق Excel',
          'settings.fileHandling.openFolderAfterExport' =>
            'فتح المجلد بعد التصدير',
          'settings.fileHandling.fileSafety' => 'أمان الملفات',
          'settings.fileHandling.fileSafetyDescription' =>
            'نسخ محلية تلقائية لاستعادة البيانات.',
          'settings.fileHandling.resetToGlobal' =>
            'إعادة تعيين جميع إعدادات معالجة الملفات للافتراضيات العالمية',
          'settings.translationMemory.title' => 'ذاكرة الترجمة العالمية',
          'settings.translationMemory.autoLearn' => 'تعلم تلقائي',
          'settings.translationMemory.autoLearnDescription' =>
            'حفظ الترجمات في الذاكرة المحلية لإعادة استخدامها مستقبلاً',
          'settings.translationMemory.confidenceThreshold' => 'عتبة الثقة',
          'settings.translationMemory.confidenceThresholdDescription' => (
                  {required Object percent}) =>
              'الحد الأنى للدرجة للتطبيق التلقائي (${percent}%)',
          'settings.translationMemory.entries' => 'الإدخالات',
          'settings.translationMemory.size' => 'الحجم',
          'settings.translationMemory.memorySize' => ({required Object size}) =>
              'حجم الذاكرة: ${size}',
          'settings.translationMemory.import' => 'استيراد',
          'settings.translationMemory.exportTmx' => 'تصدير TMX',
          'settings.translationMemory.exportCsv' => 'تصدير CSV',
          'settings.translationMemory.clearMemory' => 'مسح الذاكرة',
          'settings.translationMemory.importedItems' => (
                  {required Object count}) =>
              'تم استيراد ${count} عنصراً في الذاكرة.',
          'settings.translationMemory.noItemsAdded' => 'لم تتم إضافة أي عناصر.',
          'settings.translationMemory.nothingToExport' =>
            'لا يوجد شيء لتصديره بعد.',
          'settings.translationMemory.tmxSaved' => 'تم حفظ TMX',
          'settings.translationMemory.csvSaved' => 'تم حفظ CSV',
          'settings.translationMemory.clearConfirmTitle' =>
            'مسح ذاكرة الترجمة؟',
          'settings.translationMemory.clearConfirmContent' =>
            'سيؤدي هذا إلى إزالة جميع أزواج الترجمة المحفوظة على هذا الجهاز. هذا الإجراء لا يمكن التراج عنه.',
          'settings.translationMemory.cleared' => 'تم مسح ذاكرة الترجمة.',
          'settings.translationMemory.couldNotClear' => 'تعذر مسح الذاكرة.',
          'settings.backup.title' => 'نسخ احتياطي تلقائي',
          'settings.backup.description' => 'إعدادات النسخ الاحتياطي التلقائي',
          'settings.backup.enabled' => 'تفعيل النسخ الاحتياطي التلقائي',
          'settings.backup.enabledDescription' =>
            'نسخ الملفات احتياطياً تلقائياً قبل إجراء التغييرات',
          'settings.backup.maxCopies' => 'الحد الأقصى لنسخ النسخ الاحتياطي',
          'settings.backup.maxCopiesDescription' =>
            'عدد نسخ النسخ الاحتياطي التي يجب الاحتفاظ بها لكل ملف',
          'settings.backup.activeStatus' => ({required Object count}) =>
              'نشط · الاحتفاظ بـ ${count} نسخ',
          'settings.backup.folder' => 'مجلد النسخ الاحتياطي',
          'settings.backup.folderDescription' =>
            'أتركه فارغاً لاستخدام نفس المجلد',
          'settings.backup.useOriginalFolder' => 'استخدام مجلد الملف الأصلي',
          'settings.ai.title' => 'خدمات الذكاء الاصطناعي',
          'settings.ai.description' =>
            'تكوين الترجمة والمساعدة بالذكاء الاصطناعي',
          'settings.ai.provider' => 'موفر الذكاء الاصطناعي',
          'settings.ai.providerDescription' =>
            'اختر موفر خدمة الذكاء الاصطناعي المفضل لديك',
          'settings.ai.apiKey' => 'مفتاح API',
          'settings.ai.apiKeyDescription' =>
            'أدخل مفتاح API الخاص بك للموفر المحدد',
          'settings.ai.apiKeyPlaceholder' => 'أدخل مفتاح API...',
          'settings.ai.testConnection' => 'اختبار الاتصال',
          'settings.ai.connectionSuccess' => 'نجح الاتصال!',
          'settings.ai.connectionFailed' =>
            'فشل الاتصال. يرجى التحقق من مفتاح API الخاص بك.',
          'settings.ai.translationStrategy' => 'استراتيجية الترجمة',
          'settings.ai.strategy' => 'الاستراتيجية',
          'settings.ai.strategyDescription' => 'اختر كيفية ترجمة النصوص',
          'settings.ai.strategyLLM' => 'الذكاء الاصطناعي التوليدي (LLM)',
          'settings.ai.strategyCloud' => 'الترجمة السحابية',
          'settings.ai.enableAiTranslation' =>
            'تفعيل الترجمة بالذكاء الاصطناعي',
          'settings.ai.enableAiTranslationDescription' =>
            'السماح للتطبيق باستخدام الذكاء الاصطناعي لاقتراحات الترجمة',
          'settings.ai.llmProvider' => 'موفر خدمة LLM',
          'settings.ai.service' => 'الخدمة',
          'settings.ai.serviceDescription' => 'موفر الذكاء الاصطناعي التوليدي',
          'settings.ai.providerGemini' => 'Google Gemini',
          'settings.ai.providerOpenAI' => 'OpenAI',
          'settings.ai.geminiApiKey' => 'مفتاح Gemini API',
          'settings.ai.openAiApiKey' => 'مفتاح OpenAI API',
          'settings.ai.model' => 'النموذج',
          'settings.ai.modelDescription' => 'حدد النموذج الذي تريد استخدامه',
          'settings.ai.advancedParameters' => 'معلمات متقدمة',
          'settings.ai.parameters' => 'المعلمات',
          'settings.ai.parametersDescription' =>
            'درجة الحرارة، السياق، والمزيد',
          'settings.ai.temperature' => 'درجة الحرارة',
          'settings.ai.temperatureDescription' =>
            'القيم الأعلى تجعل الإخراج أكثر إبداعاً',
          'settings.ai.maxTokens' => 'الحد الأقصى للرموز',
          'settings.ai.maxTokensDescription' => 'الحد من طول نافذة السياق',
          'settings.ai.systemContext' => 'سياق النظام / التعليمات',
          'settings.ai.systemContextHint' =>
            'أنت مترجم محترف. حافظ على نبرة المصدر وقصده...',
          'settings.ai.systemContextHelper' =>
            'قدم تعليمات محددة للذكاء الاصطناعي حول أسلوب ومصطلحات مشروعك.',
          'settings.ai.contextStrings' => 'سلاسل السياق',
          'settings.ai.contextStringsDescription' =>
            'تضمين السلاسل المحيطة للحصول على سياق أفضل',
          'settings.ai.contextCount' => 'عدد السياق',
          'settings.ai.contextCountDescription' =>
            'عدد السلاسل المحيطة التي سيتم تضمينها',
          'settings.ai.cloudServices' => 'خدمات الترجمة السحابية',
          'settings.ai.googleTranslateApiKey' => 'مفتاح Google Translate API',
          'settings.ai.deeplApiKey' => 'مفتاح DeepL API',
          'settings.ai.test' => 'اختبار',
          'settings.ai.resetToGlobal' =>
            'إعادة تعيين جميع إعدادات الذكاء الاصطناعي للافتراضيات العالمية',
          'settings.integrations.platformNotice' => 'إشعار المنصة',
          'settings.integrations.platformNoticeDescription' =>
            'تكاملات النظام غير متوفرة لهذه المنصة.',
          'settings.integrations.visualEffects' => 'تأثيرات بصرية',
          'settings.integrations.explorerIntegration' => 'تكامل المستكشف',
          'settings.integrations.explorerIntegrationDescription' =>
            'إضافة "فتح باستخدام Localizer" إلى قائمة النقر بزر الماوس الأيمن في مستكشف Windows للمجلدات.',
          'settings.integrations.addToContextMenu' => 'إضافة إلى قائمة السياق',
          'settings.integrations.contextMenuAdded' => 'تمت إضافة قائمة السياق!',
          'settings.integrations.contextMenuAddError' =>
            'فشل إضافة قائمة السياق',
          'settings.integrations.contextMenuRemoved' =>
            'تمت إزالة قائمة السياق!',
          'settings.integrations.contextMenuRemoveError' =>
            'فشل إزالة قائمة السياق',
          'settings.integrations.fileAssociations' => 'ارتباطات الملفات',
          'settings.integrations.fileAssociationsDescription' =>
            'تسجيل أنواع الملفات لفتحها باستخدام Localizer عند النقر المزدوج في المستكشف.',
          'settings.integrations.registered' => 'مسجل',
          'settings.integrations.notRegistered' => 'غير مسجل',
          'settings.integrations.extRegistered' => ({required Object ext}) =>
              'تم تسجيل ${ext}!',
          'settings.integrations.extUnregistered' => ({required Object ext}) =>
              'تم إلغاء تسجيل ${ext}!',
          'settings.integrations.extError' => (
                  {required Object action, required Object ext}) =>
              'فشل في ${action} ${ext}',
          'settings.integrations.registerAll' => 'تسجيل الكل',
          'settings.integrations.unregisterAll' => 'إلغاء تسجيل الكل',
          'settings.integrations.registerAllResult' => (
                  {required Object success, required Object total}) =>
              'تسجيل ${success} من ${total} أنواع ملفات',
          'settings.integrations.unregisterAllResult' => (
                  {required Object success, required Object total}) =>
              'إلغاء تسجيل ${success} من ${total} أنواع ملفات',
          'settings.integrations.protocolHandler' => 'معالج البروتوكول',
          'settings.integrations.protocolHandlerDescription' =>
            'تسجيل عناوين URL localizer:// لفتح هذا التطبيق. يسمح بفتح المشاريع مباشرة من روابط المتصفح أو التطبيقات الأخرى.',
          'settings.integrations.protocolRegistered' => 'معالج البروتوكول مسجل',
          'settings.integrations.protocolNotRegistered' =>
            'معالج البروتوكول غير مسجل',
          'settings.integrations.registerProtocol' => 'تسجيل البروتوكول',
          'settings.integrations.unregister' => 'إلغاء التسجيل',
          'settings.integrations.protocolRegisteredSuccess' =>
            'تم تسجيل معالج البروتوكول!',
          'settings.integrations.protocolRemovedSuccess' =>
            'تمت إزالة معالج البروتوكول!',
          'settings.integrations.protocolRegisterError' => 'فشل التسجيل',
          'settings.integrations.protocolRemoveError' => 'فشل الإزالة',
          'settings.integrations.windowMaterial' => 'مادة النافذة',
          'settings.integrations.windowMaterialDescription' =>
            'حدد نمط مادة حيوية macOS',
          'settings.integrations.dockIntegration' => 'تكامل Dock',
          'settings.integrations.showDockBadge' => 'إظهار عدد غير المترجمة',
          'settings.integrations.showDockBadgeDescription' =>
            'عرض عدد السلاسل غير المترجمة على شارة أيقونة dock',
          'settings.integrations.materials.sidebar' => 'شريط جانبي',
          'settings.integrations.materials.menu' => 'قائمة',
          'settings.integrations.materials.popover' => 'منبثق',
          'settings.integrations.materials.titlebar' => 'شريط العنوان',
          'settings.integrations.materials.underPageBackground' =>
            'خلفية الصفحة',
          'settings.integrations.materials.contentBackground' => 'المحتوى',
          'settings.integrations.fileTypes.loc' => 'ملف مشروع Localizer',
          'settings.integrations.fileTypes.lang' => 'ملف اللغة',
          'settings.integrations.fileTypes.json' => 'ملف توطين JSON',
          'settings.integrations.fileTypes.xml' => 'ملف توطين XML',
          'settings.developer.title' => 'إعدادات المطور',
          'settings.developer.description' => 'إعدادات متقدمة للمطورين',
          'settings.developer.showLocalizationKeys' => 'إظهار مفاتيح التوطين',
          'settings.developer.localizationKeysDescription' =>
            'عند التفعيل، ستظهر جميع النصوص المترجمة مفاتيح التوطين الخاصة بها بدلاً من القيمة المترجمة. مفيد للتحقق من المفتاح المستخدم.',
          'settings.developer.showPerformanceOverlay' => 'إظهار تراكب الأداء',
          'settings.developer.performanceOverlayDescription' =>
            'عرض FPS ومعلومات توقيت الإطار',
          'settings.developer.debugMode' => 'وضع التصحيح',
          'settings.developer.debugModeDescription' =>
            'تفعيل تسجيل إضافي وميزات تصحيح الأخطاء',
          'settings.developer.debuggingTools' => 'أدوات التصحيح',
          'settings.developer.semanticsDebugger' => 'مصحح الدلالات',
          'settings.developer.semanticsDebuggerDescription' =>
            'تصور شجرة الدلالات',
          'settings.developer.materialGrid' => 'شبكة المواد',
          'settings.developer.materialGridDescription' =>
            'تراكب شبكة تخطيط المواد',
          'settings.developer.rasterCache' => 'تخزين الصور النقطية مؤقتاً',
          'settings.developer.rasterCacheDescription' =>
            'صور ذاكرة التخزين المؤقت النقطية',
          'settings.developer.actions' => 'إجراءات',
          'settings.developer.showLogs' => 'إظهار سجلات التطبيق',
          'settings.developer.showLogsDescription' =>
            'فتح وحدة تحكم تصحيح Talker',
          'settings.developer.restartTutorial' =>
            'إعادة تشغيل البرنامج التعليمي',
          'settings.developer.restartTutorialDescription' =>
            'إعادة تعيين العلامات وتشغيل البرنامج التعليمي مرة أخرى',
          'settings.developer.restartRequested' =>
            'تم طلب إعادة تشغيل البرنامج التعليمي.',
          'settings.developer.throwException' => 'رمي استثناء اختبار',
          'settings.developer.throwExceptionDescription' =>
            'تشغيل استثناء اختبار للإبلاغ عن الأعطال',
          'settings.developer.testExceptionMessage' =>
            'تم تشغيل استثناء الاختبار من خيارات المطور',
          'settings.developer.clearTM' => 'مسح ذاكرة الترجمة',
          'settings.developer.clearTMDescription' =>
            'حذف جميع الترجمات المخزنة مؤقتاً',
          'settings.developer.clearTMConfirmation' => 'مسح ذاكرة الترجمة؟',
          'settings.developer.clearTMWarning' =>
            'سيؤدي هذا إلى حذف جميع الترجمات التي تم تعلمها. هذا لا يمكن التراجع عنه.',
          'settings.developer.tmCleared' => 'تم مسح ذاكرة الترجمة',
          'settings.developer.clearApiKeys' => 'مسح مفاتيح API',
          'settings.developer.clearApiKeysDescription' =>
            'إزالة جميع مفاتيح API المخزنة',
          'settings.developer.clearApiKeysConfirmation' => 'مسح مفاتيح API؟',
          'settings.developer.clearApiKeysWarning' =>
            'سيؤدي هذا إلى إزالة جميع مفاتيح API من التخزين الآمن.',
          'settings.developer.apiKeysCleared' => 'تم مسح مفاتيح API',
          'settings.developer.hideOptions' => 'إخفاء خيارات المطور',
          'settings.developer.hideOptionsDescription' =>
            'تعطيل وضع المطور (يتطلب 7 نقرات لإعادة التفعيل)',
          'settings.developer.optionsDisabled' => 'تم تعطيل خيارات المطور',
          'settings.developer.dangerZone' => 'منطقة الخطر',
          'settings.developer.factoryReset' => 'إعادة ضبط المصنع',
          'settings.developer.factoryResetDescription' =>
            'إعادة تعيين جميع الإعدادات ومسح البيانات',
          'settings.developer.factoryResetWarning' =>
            'هل أنت متأكد أنك تريد إعادة تعيين جميع الإعدادات؟ هذا الإجراء لا يمكن التراجع عنه.',
          'settings.developer.inspectionTools' => 'أدوات الفحص',
          'settings.developer.searchHint' => 'بحث في الإعدادات...',
          'settings.developer.resetToDefault' => 'إعادة تعيين للافتراضيات',
          'settings.developer.resetToGlobal' => 'إعادة تعيين للافتراضي العالمي',
          'settings.developer.storageInspector' => 'مفتش التخزين',
          'settings.developer.storageInspectorDescription' =>
            'عرض محتويات Hive و Secure Storage',
          'settings.developer.deviceEnvironment' => 'الجهاز والبيئة',
          'settings.developer.deviceEnvironmentDescription' =>
            'معلومات الشاشة، المنصة، والبناء',
          'settings.developer.themePlayground' => 'ملعب المظهر',
          'settings.developer.themePlaygroundDescription' =>
            'لوحة الألوان والطباعة',
          'settings.developer.themePlaygroundSection.colors' => 'الألوان',
          'settings.developer.themePlaygroundSection.typography' => 'الطباعة',
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
          'settings.developer.localizationInspector' => 'مفتش التوطين',
          'settings.developer.localizationInspectorDescription' =>
            'تصحيح سلاسل الترجمة',
          'settings.developer.hiveAppSettings' => 'Hive (AppSettings)',
          'settings.developer.secureStorageMasked' => 'Secure Storage (Masked)',
          'settings.developer.featureFlags.title' => 'ميزات تجريبية',
          'settings.developer.featureFlags.description' =>
            'تبديل ميزات تجريبية محلياً للاختبار. تستمر هذه التجاوزات عبر إعادة تشغيل التطبيق.',
          'settings.developer.featureFlags.subtitle' =>
            'تجاوز الميزات التجريبية',
          'settings.developer.featureFlags.flags.experimental_ai_batch.name' =>
            'الذكاء الاصطناعي الدفعي التجريبي',
          'settings.developer.featureFlags.flags.experimental_ai_batch.description' =>
            'تفعيل ترجمة الذكاء الاصطناعي الدفعية لصفوف متعددة',
          'settings.developer.featureFlags.flags.new_diff_algorithm.name' =>
            'خوارزمية فرق جديدة',
          'settings.developer.featureFlags.flags.new_diff_algorithm.description' =>
            'استخدام خوارزمية فرق محسنة للمقارنات',
          'settings.developer.featureFlags.flags.enhanced_search.name' =>
            'بحث محسن',
          'settings.developer.featureFlags.flags.enhanced_search.description' =>
            'تفعيل البحث الضبابي في ملفات الترجمة',
          'settings.developer.featureFlags.flags.auto_save.name' =>
            'حفظ تلقائي',
          'settings.developer.featureFlags.flags.auto_save.description' =>
            'حفظ التغييرات تلقائياً بعد التعديلات',
          'settings.developer.featureFlags.reset' =>
            'إعادة تعيين جميع العلامات',
          'settings.developer.featureFlags.overrides' => 'تجاوزات محلية',
          'settings.developer.featureFlags.defaultVal' => 'افتراضي',
          'settings.developer.featureFlags.on' => 'ON',
          'settings.developer.featureFlags.off' => 'OFF',
          'settings.developer.storageInspectorSection.refresh' => 'تحديث',
          'settings.developer.storageInspectorSection.hiveData' =>
            'بيانات Hive',
          'settings.developer.storageInspectorSection.secureStorage' =>
            'Secure Storage',
          'settings.developer.deviceInfoSection.refresh' => 'تحديث',
          'settings.developer.deviceInfoSection.copy' => 'نسخ إلى الحافظة',
          'settings.developer.deviceInfoSection.computerName' =>
            'اسم الكمبيوتر',
          'settings.developer.deviceInfoSection.osVersion' =>
            'إصدار نظام التشغيل',
          'settings.developer.localizationInspectorSection.showKeys' =>
            'إظهار المفاتيح بدلاً من القيم',
          'settings.developer.localizationInspectorSection.keysVisible' =>
            'المفاتيح مرئية',
          'settings.developer.localizationInspectorSection.normalDisplay' =>
            'عرض عادي',
          'settings.developer.localizationInspectorSection.note' =>
            'ملاحظة: تتطلب هذه الميزة أن يستخدم توطين التطبيق غلافاً يحترم هذا الإعداد.',
          'settings.about.title' => 'حول',
          'settings.about.version' => 'الإصدار',
          'settings.about.buildNumber' => 'رقم البناء',
          'settings.about.author' => 'المؤلف',
          _ => null,
        } ??
        switch (path) {
          'settings.about.license' => 'الرخصة',
          'settings.about.sourceCode' => 'كود المصدر',
          'settings.about.reportBug' => 'الإبلاغ عن خطأ',
          'settings.about.requestFeature' => 'طلب ميزة',
          'settings.about.checkForUpdates' => 'التحقق من التحديثات',
          'settings.about.upToDate' => 'أنت على أحدث إصدار!',
          'settings.about.updateAvailable' => ({required Object version}) =>
              'يوجد تحديث: ${version}',
          'settings.about.updateAvailableBadge' => 'تحديث متوفر!',
          'settings.about.developerSteps' => ({required Object count}) =>
              'أنت على بعد ${count} خطوات من أن تكون مطوراً.',
          'settings.about.developerActivated' => 'أنت الآن مطور!',
          'settings.about.neverChecked' => 'أبداً',
          'settings.about.applicationInfo' => 'معلومات التطبيق',
          'settings.about.platform' => 'المنصة',
          'settings.about.updateInformation' => 'معلومات التحديث',
          'settings.about.currentVersion' => 'الإصدار الحالي',
          'settings.about.latestVersion' => 'أحدث إصدار',
          'settings.about.lastChecked' => 'آخر تحقق',
          'settings.about.checkingForUpdates' => 'جارٍ التحقق...',
          'settings.about.whatsNew' => 'ما الجديد',
          'settings.about.systemInformation' => 'معلومات النظام',
          'settings.about.dartVersion' => 'إصدار Dart',
          'settings.about.diskSpace' => 'مساحة القرص المتوفرة',
          'settings.about.memoryUsage' => 'استخدام الذاكرة',
          'settings.about.privacyTitle' => 'الخصوصية والقياس عن بعد',
          'settings.about.usageStats' => 'إحصائيات الاستخدام المجهولة',
          'settings.about.requiresFirebase' => 'يتطلب تكوين Firebase',
          'settings.about.featureUnavailable' =>
            'الميزة غير متوفرة حالياً (تتطلب Firebase)',
          'settings.about.settingsManagement' => 'إدارة الإعدادات',
          'settings.about.settingsManagementDescription' =>
            'تصدير الإعدادات إلى ملف لإجراء نسخ احتياطي أو مشاركتها مع أجهزة أخرى.',
          'settings.about.resetAll' => 'إعادة تعيين الكل',
          'settings.about.links' => 'روابط',
          'settings.about.githubRepo' => 'مستودع GitHub',
          'settings.about.privacyPolicy' => 'سياسة الخصوصية',
          'settings.about.crashReporting' => 'الإبلاغ عن الأعطال',
          'settings.settingsView.resetCategoryTitle' =>
            ({required Object category}) => 'إعادة تعيين ${category}؟',
          'settings.settingsView.resetCategoryContent' =>
            'سيؤدي هذا إلى إعادة تعيين جميع الإعدادات في هذه الفئة إلى قيمها الافتراضية.',
          'settings.settingsView.resetAllTitle' =>
            'إعادة تعيين جميع الإعدادات؟',
          'settings.settingsView.resetAllContent' =>
            'سيؤدي هذا إلى إعادة تعيين جميع الإعدادات بشكل دائم إلى افتراضيات المصنع. هذا الإجراء لا يمكن التراجع عنه.',
          'settings.settingsView.resetAll' => 'إعادة تعيين الكل',
          'settings.settingsView.resetSuccess' => (
                  {required Object category}) =>
              'تمت إعادة تعيين ${category} للافتراضيات',
          'settings.settingsView.errorLoading' => 'خطأ في تحميل الإعدادات',
          'settings.settingsView.settingsSaved' => 'تم حفظ الإعدادات',
          'settings.settingsView.updateAvailable' =>
            ({required Object version}) => 'تحديث متوفر: v${version}',
          'settings.settingsView.latestVersion' => 'أنت تستخدم أحدث إصدار',
          'settings.settingsView.whatsNew' => ({required Object version}) =>
              'ما الجديد في v${version}',
          'settings.settingsView.downloadUpdate' => 'تنزيل التحديث',
          'settings.settingsView.exportSettings' => 'تصدير الإعدادات',
          'settings.settingsView.settingsExported' => 'تم تصدير الإعدادات',
          'settings.settingsView.exportFail' => ({required Object error}) =>
              'فشل تصدير الإعدادات: ${error}',
          'settings.settingsView.importSettings' => 'استيراد الإعدادات',
          'settings.settingsView.importTitle' => 'استيراد الإعدادات؟',
          'settings.settingsView.importContent' =>
            'سيؤدي هذا إلى استبدال جميع إعداداتك الحالية بالمستوردة. هذا الإجراء لا يمكن التراجع عنه.',
          'settings.settingsView.importSuccess' =>
            'تم استيراد الإعدادات بنجاح!',
          'settings.settingsView.importFail' => ({required Object error}) =>
              'فشل استيراد الإعدادات: ${error}',
          'settings.settingsView.invalidFormat' =>
            'تنسيق ملف الإعدادات غير صالح',
          'settings.settingsView.categories.general' => 'الإعدادات العامة',
          'settings.settingsView.categories.comparisonEngine' =>
            'محرك المقارنة',
          'settings.settingsView.categories.appearance' => 'المظهر',
          'settings.settingsView.categories.fileHandling' => 'معالجة الملفات',
          'settings.settingsView.categories.aiServices' =>
            'خدمات الذكاء الاصطناعي',
          'settings.settingsView.categories.systemIntegrations' =>
            'تكاملات النظام',
          'settings.settingsView.categories.projectResources' =>
            'موارد المشروع (المسرد وذاكرة الترجمة)',
          'settings.settingsView.categories.developer' => 'خيارات المطور',
          'settings.settingsView.categories.about' => 'حول',
          'settings.settingsView.categoryLabels.general' => 'عام',
          'settings.settingsView.categoryLabels.comparisonEngine' => 'المقارنة',
          'settings.settingsView.categoryLabels.appearance' => 'المظهر',
          'settings.settingsView.categoryLabels.fileHandling' =>
            'معالجة الملفات',
          'settings.settingsView.categoryLabels.aiServices' =>
            'خدمات الذكاء الاصطناعي',
          'settings.settingsView.categoryLabels.systemIntegrations' =>
            'تكاملات النظام',
          'settings.settingsView.categoryLabels.projectResources' =>
            'موارد المشروع',
          'settings.settingsView.categoryLabels.developer' => 'خيارات المطور',
          'settings.settingsView.categoryLabels.about' => 'حول',
          'settings.onboarding.skipTutorial' => 'تخطي البرنامج التعليمي',
          'settings.onboarding.gettingStarted' => 'البدء',
          'settings.onboarding.stepProgress' => (
                  {required Object current, required Object total}) =>
              '${current} من ${total}',
          'settings.onboarding.loadSampleData' => 'تحميل بيانات العينة',
          'settings.onboarding.steps.importFiles.title' => 'استيراد الملفات',
          'settings.onboarding.steps.importFiles.description' =>
            'تحميل ملفات المصدر والهدف',
          'settings.onboarding.steps.runComparison.title' => 'تشغيل المقارنة',
          'settings.onboarding.steps.runComparison.description' =>
            'انقر على "مقارنة الملفات"',
          'settings.onboarding.steps.reviewMissing.title' =>
            'مراجعة المفاتيح المفقودة',
          'settings.onboarding.steps.reviewMissing.description' =>
            'لاحظ العناصر المفقودة الحمراء',
          'settings.onboarding.steps.useFilters.title' => 'استخدام الفلاتر',
          'settings.onboarding.steps.useFilters.description' =>
            'تصفية حسب النوع',
          'settings.onboarding.steps.searchResults.title' => 'نتائج البحث',
          'settings.onboarding.steps.searchResults.description' =>
            'العثور على مفاتيح محددة',
          'settings.onboarding.steps.advancedView.title' => 'عرض متقدم',
          'settings.onboarding.steps.advancedView.description' =>
            'استكشاف التحليل التفصيلي',
          'settings.onboarding.steps.editCell.title' => 'تحرير خلية',
          'settings.onboarding.steps.editCell.description' =>
            'انقر لتحرير قيمة',
          'settings.onboarding.steps.exportResults.title' => 'تصدير',
          'settings.onboarding.steps.exportResults.description' => 'حفظ تقريرك',
          'fileComparison.title' => 'مقارنة الملفات',
          'fileComparison.openFiles' => 'فتح الملفات',
          'fileComparison.exportResults' => 'تصدير النتائج',
          'fileComparison.restartTutorial' => 'إعادة تشغيل البرنامج التعليمي',
          'fileComparison.restartTutorialDevOnly' =>
            'إعادة تشغيل البرنامج التعليمي متاح فقط في وضع المطور.',
          'fileComparison.unsupportedFileType' => 'نوع الملف غير مدعوم.',
          'fileComparison.unsupportedFileTypeSuggestion' =>
            'يرجى تحديد ملف توطين مدعوم.',
          'fileComparison.someFilesUnsupported' => 'بعض الملفات غير مدعومة.',
          'fileComparison.pickSupportedFiles' => 'اختر ملفات توطين مدعومة فقط.',
          'fileComparison.pickTwoFiles' => 'اختر ملفين للمقارنة.',
          'fileComparison.pickBilingualFile' =>
            'يرجى تحديد ملف ثنائي اللغة للمقارنة.',
          'fileComparison.noResultsToExport' => 'لا توجد نتائج للتصدير بعد.',
          'fileComparison.performComparisonFirst' =>
            'قم بإجراء مقارنة أولاً لتصدير النتائج.',
          'fileComparison.performComparisonFirstEditor' =>
            'يرجى إجراء مقارنة أولاً لرؤية التفاصيل المتقدمة.',
          'fileComparison.sampleDataLoaded' => 'تم تحميل بيانات العينة بنجاح',
          'fileComparison.loadSampleDataError' => ({required Object error}) =>
              'فشل تحميل بيانات العينة: ${error}',
          'fileComparison.invalidFileType' => 'نوع ملف غير صالح.',
          'fileComparison.fileSelected' => (
                  {required Object label, required Object fileName}) =>
              'تم تحديد ${label}: ${fileName}',
          'fileComparison.sourceFile' => 'ملف المصدر',
          'fileComparison.targetFile' => 'ملف الهدف',
          'fileComparison.bilingualFile' => 'ملف ثنائي اللغة',
          'fileComparison.compareFiles' => 'مقارنة الملفات',
          'fileComparison.compareFile' => 'مقارنة الملف',
          'fileComparison.bilingualMode' => 'وضع ثنائي اللغة',
          'fileComparison.twoFilesMode' => 'ملفان',
          'fileComparison.processing' => 'جارٍ المعالجة...',
          'fileComparison.remaining' => ({required Object time}) =>
              'متبقي ${time}',
          'fileComparison.comparisonInProgress' => 'المقارنة قيد التقدم...',
          'fileComparison.comparisonFailed' => ({required Object error}) =>
              'فشلت المقارنة: ${error}',
          'fileComparison.fileChanged' => ({required Object fileName}) =>
              'تم تغيير الملف: ${fileName}. إعادة المقارنة...',
          'fileComparison.dropFileHere' => 'أفلت الملف هنا',
          'fileComparison.dropFileOrBrowse' => 'أفلت الملف أو انقر للتصفح',
          'fileComparison.fileUpload' => 'تحميل ملف',
          'fileComparison.changeFile' => 'تغيير الملف',
          'fileComparison.total' => 'المجموع',
          'fileComparison.show' => 'عرض',
          'fileComparison.showAll' => 'عرض الكل',
          'fileComparison.noMatches' => ({required Object query}) =>
              'لم يتم العثور على تطابقات لـ "${query}"',
          'fileComparison.showingEntries' => (
                  {required Object count, required Object total}) =>
              'عرض ${count} من ${total} إدخال',
          'fileComparison.filesIdentical' => 'الملفات متطابقة.',
          'fileComparison.hiddenIdentical' => ({required Object count}) =>
              '${count} إدخالات متطابقة مخفية',
          'fileComparison.showIdentical' => 'إظهار الإدخالات المتطابقة',
          'fileComparison.hideIdentical' => 'إخفاء الإدخالات المتطابقة',
          'fileComparison.noDiff' =>
            'لم يتم العثور على فروق بناءً على المفاتيح.',
          'fileComparison.source' => 'المصدر',
          'fileComparison.target' => 'الهدف',
          'fileComparison.value' => 'القيمة',
          'fileComparison.readyToCompare' => 'جاهز لمقارنة الملفات',
          'fileComparison.readyToCompareDesc' =>
            'أفلت ملفات التوطين أعلاه أو استخدم أزرار التصفح\nلتحديد ملفات للمقارنة.',
          'fileComparison.recentComparisons' => 'المقارنات الأخيرة',
          'fileComparison.bilingualFileLabel' => ({required Object name}) =>
              'ملف ثنائي اللغة: ${name}',
          'fileComparison.comparisonLabel' => (
                  {required Object source, required Object target}) =>
              '${source} ↔ ${target}',
          'fileComparison.fileNotExist' =>
            'أحد الملفين أو كلاهما من هذه الجلسة لم يعد موجوداً.',
          'fileComparison.largeFileTitle' => 'تم اكتشاف ملف كبير',
          'fileComparison.largeFileContent' => ({required Object count}) =>
              'تحتوي نتيجة المقارنة على ${count} إدخال.\nعرض جميعها قد يسبب مشاكل في الأداء.\n\nهل تريد المتابعة؟',
          'fileComparison.dontShowAgain' => 'لا تظهر مرة أخرى لهذا الملف',
          'fileComparison.proceed' => 'متابعة',
          'fileComparison.exportReport' => ({required Object format}) =>
              'حفظ تقرير ${format}',
          'fileComparison.saved' => ({required Object format}) =>
              'تم حفظ ${format}',
          'fileComparison.saveError' => ({required Object format}) =>
              'فشل حفظ ملف ${format}.',
          'fileComparison.saveErrorDetailed' => (
                  {required Object format, required Object error}) =>
              'فشل حفظ ${format}: ${error}',
          'fileComparison.watching' => 'مراقبة',
          'fileComparison.watchOff' => 'إيقاف المراقبة',
          'fileComparison.watchingTooltip' => ({required Object status}) =>
              'مراقبة الملفات: ${status}\nإعادة المقارنة تلقائياً عند تغيير الملفات على القرص',
          'fileComparison.aiSettingsNotAvailable' =>
            'الانتقال إلى إعدادات الذكاء الاصطناعي غير متاح',
          'directoryComparison.title' => 'مقارنة الأدلة',
          'directoryComparison.sourceDirectory' => 'دليل المصدر',
          'directoryComparison.targetDirectory' => 'دليل الهدف',
          'directoryComparison.sourceSubtitle' => 'ملفات الأصل/المرجع',
          'directoryComparison.targetSubtitle' => 'ملفات الترجمة/المقارنة',
          'directoryComparison.selectBothDirectories' =>
            'يرجى تحديد كلاً من دليل المصدر والهدف.',
          'directoryComparison.selectSourceFolder' => 'تحديد مجلد المصدر',
          'directoryComparison.selectTargetFolder' => 'تحديد مجلد الهدف',
          'directoryComparison.dropFolderHere' => 'أفلت المجلد هنا أو تصفح...',
          'directoryComparison.folderPath' => 'مسار المجلد',
          'directoryComparison.readyToCompare' => 'جاهز لمقارنة الأدلة',
          'directoryComparison.readyToCompareDesc' =>
            'أفلت المجلدات أعلاه أو استخدم أزرار التصفح\nلتحديد أدلة للمقارنة.',
          'directoryComparison.nestedFolders' => 'مجلدات متداخلة',
          'directoryComparison.nestedFoldersTooltip' =>
            'يقارن جميع الأدلة المتداخلة بشكل متكرر',
          'directoryComparison.fileMatching' => 'مطابقة الملفات',
          'directoryComparison.fileMatchingTooltip' =>
            'يقرن الملفات تلقائياً بالاسم',
          'directoryComparison.bulkExport' => 'تصدير جماعي',
          'directoryComparison.bulkExportTooltip' =>
            'تصدير جميع نتائج المقارنة دفعة واحدة',
          'directoryComparison.notDirectoryComparison' =>
            'هذه ليست مقارنة أدلة.',
          'directoryComparison.directoriesNotExist' =>
            'أحد الدليلين أو كلاهما لم يعد موجوداً.',
          'directoryComparison.errorOccurred' => 'حدث خطأ',
          'directoryComparison.noFilesFound' =>
            'لم يتم العثور على ملفات في الأدلة المحددة.',
          'directoryComparison.unmatchedSourceFiles' =>
            'ملفات المصدر غير المتطابقة',
          'directoryComparison.unmatchedTargetFiles' =>
            'ملفات الهدف غير المتطابقة',
          'directoryComparison.filePairs' => ({required Object count}) =>
              '${count} أزواج ملفات',
          'directoryComparison.pairedFiles' => ({required Object count}) =>
              'الملفات المقترنة (${count})',
          'directoryComparison.view' => 'عرض',
          'directoryComparison.failed' => 'فشل',
          'directoryComparison.pair' => 'اقتران...',
          'directoryComparison.pairDialogTitle' => ({required Object name}) =>
              'اقتران "${name}" مع:',
          'directoryComparison.discoverFiles' => 'اكتشاف الملفات',
          'directoryComparison.compareAll' => 'مقارنة الكل',
          'directoryComparison.exportAll' => 'تصدير الكل',
          'directoryComparison.comparisonStarted' => 'بدأت المقارنة...',
          'directoryComparison.discoveringFiles' => 'جارٍ اكتشاف الملفات...',
          'directoryComparison.noResultsToExport' =>
            'لا توجد نتائج مقارنة للتصدير. قم بتشغيل "مقارنة الكل" أولاً.',
          'directoryComparison.selectExportFolder' => 'تحديد مجلد التصدير',
          'directoryComparison.createExportFolderError' =>
            ({required Object error}) => 'فشل إنشاء مجلد التصدير: ${error}',
          'directoryComparison.exportingResults' => 'جارٍ تصدير النتائج',
          'directoryComparison.processingFile' => ({required Object file}) =>
              'جارٍ المعالجة: ${file}',
          'directoryComparison.exportProgress' => (
                  {required Object current, required Object total}) =>
              'تم تصدير ${current} من ${total} ملف',
          'directoryComparison.exportComplete' => 'اكتمل التصدير',
          'directoryComparison.exportSuccessMessage' => (
                  {required Object count}) =>
              'تم تصدير ${count} ملفات مقارنة بنجاح بالإضافة إلى الملخص.',
          'directoryComparison.exportFailed' => ({required Object error}) =>
              'فشل التصدير: ${error}',
          'directoryComparison.close' => 'إغلاق',
          'gitComparison._translatorNote' =>
            'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.',
          'gitComparison.title' => 'مقارنة المستودع',
          'gitComparison.repoSelector' => 'إنشاء / فتح مستودع',
          'gitComparison.noRepoSelected' => 'لم يتم تحديد مستودع',
          'gitComparison.open' => 'فتح',
          'gitComparison.refreshCommits' => 'تحديث الالتزامات (Commits)',
          'gitComparison.noCommits' =>
            'لم يتم العثور على التزامات أو تحميلها. حدد فرعاً لتحميل الالتزامات.',
          'gitComparison.baseCommit' => 'الالتزام الأساسي (الأقدم)',
          'gitComparison.targetCommit' => 'الالتزام المستهدف (الأحدث)',
          'gitComparison.filterCommitsByBranch' => 'تصفية الالتزامات حسب الفرع',
          'gitComparison.conflictDetection' => 'كشف التعارض',
          'gitComparison.conflictDetectionTooltip' => 'كشف وحل تعارضات الدمج',
          'gitComparison.actions' => 'إجراءات:',
          'gitComparison.checkout' => 'Checkout',
          'gitComparison.merge' => 'Merge',
          'gitComparison.pull' => 'Pull',
          'gitComparison.checkoutBranch' => 'Checkout Branch',
          'gitComparison.mergeBranch' => 'Merge Branch into Current',
          'gitComparison.mergeConfirmation' => ({required Object branch}) =>
              'Merge ${branch}?',
          'gitComparison.mergeWarning' =>
            'سيؤدي هذا إلى دمج التغييرات في فرع العمل الحالي. قد تحدث تعارضات.',
          'gitComparison.selectExportFolder' => 'تحديد مجلد التصدير',
          'gitComparison.createExportFolderError' =>
            ({required Object error}) => 'فشل إنشاء مجلد التصدير: ${error}',
          'gitComparison.exportingFiles' => 'تصدير الملفات',
          'gitComparison.processingFile' => ({required Object file}) =>
              'جارٍ المعالجة: ${file}',
          'gitComparison.exportProgress' => (
                  {required Object current, required Object total}) =>
              'تم تصدير ${current} من ${total} ملف',
          'gitComparison.exportComplete' => 'اكتمل التصدير',
          'gitComparison.exportSuccessMessage' => ({required Object count}) =>
              'تم تصدير ${count} ملفات بنجاح بمحتوى كامل.',
          'gitComparison.exportDetail' =>
            'يتم حفظ فرق كل ملف في المجلد الفرعي "files".',
          'gitComparison.diffViewer' => 'عارض الفرق',
          'gitComparison.base' => 'BASE',
          'gitComparison.target' => 'TARGET',
          'gitComparison.noLines' => 'لا توجد خطوط للعرض',
          'gitComparison.searchFiles' => 'بحث في الملفات...',
          'gitComparison.noFilesMatch' => ({required Object query}) =>
              'لا توجد ملفات تطابق "${query}"',
          'gitComparison.filesCount' => ({required Object count}) =>
              '${count} ملفات',
          'gitComparison.selectBaseFile' => 'تحديد ملف القاعدة',
          'gitComparison.selectTargetFile' => 'تحديد ملف الهدف',
          'gitComparison.comparisonResults' => 'نتائج المقارنة',
          'gitComparison.noChanges' =>
            'لم يتم العثور على تغييرات بين المراجع المحددة.',
          'gitComparison.linesAdded' => 'خطوط مضافة',
          'gitComparison.linesRemoved' => 'خطوط محذوفة',
          'gitComparison.commit' => 'Commit',
          'gitComparison.branch' => 'Branch',
          'gitComparison.noRepositorySelected' => 'لم يتم تحديد مستودع',
          'gitComparison.notGitComparison' => 'ليست مقارنة Git',
          'gitComparison.repositoryNotExist' => 'المستودع غير موجود',
          'gitComparison.mainBranch' => 'main',
          'gitComparison.masterBranch' => 'master',
          'gitComparison.backToControls' => 'عودة إلى عناصر تحكم المقارنة',
          'advancedComparison.placeholder' => 'عرض مقارنة متقدم - عنصر نائب',
          'advancedDiff.saveAllChanges' => 'حفظ جميع التغييرات؟',
          'advancedDiff.saveConfirmation' => ({required Object count}) =>
              'سيؤدي هذا إلى حفظ جميع الإدخالات المعدلة البالغ عددها ${count} في ملف الهدف. هذا الإجراء لا يمكن التراجع عنه.',
          'advancedDiff.changesSaved' => 'تم حفظ التغييرات بنجاح.',
          'advancedDiff.csvExported' => 'تم تصدير CSV',
          'advancedDiff.unsavedChanges' => 'تغييرات غير محفوظة',
          'advancedDiff.unsavedChangesWarning' =>
            'لديك تغييرات غير محفوظة. هل أنت متأكد أنك تريد تجاهلها؟',
          'advancedDiff.discardChanges' => 'تجاهل التغييرات',
          'advancedDiff.goBack' => 'رجوع',
          'advancedDiff.breadcrumbs' => 'الرئيسية > المحرر',
          'advancedDiff.unsaved' => ({required Object count}) =>
              '${count} غير محفوظ',
          'advancedDiff.reviewed' => ({required Object count}) =>
              '${count} تمت مراجعته',
          'advancedDiff.saveAll' => ({required Object count}) =>
              'حفظ الكل (${count})',
          'advancedDiff.allSaved' => 'تم حفظ الكل',
          'advancedDiff.saveAllTooltip' => 'حفظ جميع التغييرات (Ctrl+S)',
          'advancedDiff.exportTooltip' => 'تصدير البيانات (Ctrl+E)',
          'advancedDiff.aiSuggestion.aiTranslation' => 'ترجمة الذكاء الاصطناعي',
          'advancedDiff.aiSuggestion.aiRephrase' =>
            'إعادة صياغة الذكاء الاصطناعي',
          'advancedDiff.aiSuggestion.key' => ({required Object key}) =>
              'المفتاح: ${key}',
          'advancedDiff.aiSuggestion.original' => 'الأصل:',
          'advancedDiff.aiSuggestion.suggestion' => 'الاقتراح:',
          'advancedDiff.aiSuggestion.confidence' => 'ثقة الذكاء الاصطناعي',
          'advancedDiff.aiSuggestion.cancelEdit' => 'إلغاء التعديل',
          'advancedDiff.aiSuggestion.editSuggestion' => 'تعديل الاقتراح',
          'advancedDiff.aiSuggestion.alternatives' => 'بدائل:',
          'advancedDiff.aiSuggestion.accept' => 'قبول',
          'advancedDiff.aiSuggestion.reject' => 'رفض',
          'advancedDiff.aiSuggestion.stop' => 'إيقاف',
          'advancedDiff.detailEdit.title' => ({required Object key}) =>
              'تعديل: ${key}',
          'advancedDiff.detailEdit.sourceLabel' => 'المصدر (الأصل)',
          'advancedDiff.detailEdit.targetLabel' => 'الهدف (الترجمة)',
          'advancedDiff.detailEdit.translateWithCloud' => 'ترجمة سحابية',
          'advancedDiff.detailEdit.translateWithAi' =>
            'ترجمة بالذكاء الاصطناعي',
          'advancedDiff.detailEdit.translating' => 'جارٍ الترجمة...',
          'advancedDiff.detailEdit.applyAndTm' => 'تطبيق',
          'advancedDiff.detailEdit.entryApplied' =>
            'تم تطبيق الإدخال وإضافته للذاكرة',
          'advancedDiff.detailEdit.translationAdded' =>
            'تمت إضافة اقتراح الترجمة.',
          'advancedDiff.detailEdit.aiSuggestionAdded' =>
            'تمت إضافة اقتراح الذكاء الاصطناعي.',
          'advancedDiff.table.addedToTM' => 'تمت الإضافة لذاكرة الترجمة',
          'advancedDiff.table.markedReviewed' => 'تم وضع علامة مراجعة ✓',
          'advancedDiff.table.unmarkedReview' => 'تمت إزالة علامة المراجعة',
          'advancedDiff.table.reverted' => 'تم التراجع لقيمة المصدر',
          'advancedDiff.table.entryDeleted' => 'تم حذف الإدخال',
          'advancedDiff.table.noSourceText' => 'لا يوجد نص مصدر للترجمة.',
          'advancedDiff.table.aiTranslationFailed' => ({required Object key}) =>
              'فشلت ترجمة الذكاء الاصطناعي لـ "${key}"',
          'advancedDiff.table.noTargetText' => 'لا يوجد نص هدف لإعادة صياغته.',
          'advancedDiff.table.aiRephraseFailed' => ({required Object key}) =>
              'فشلت إعادة صياغة الذكاء الاصطناعي لـ "${key}"',
          'advancedDiff.table.checkRowsFirst' =>
            'حدد الصفوف باستخدام مربعات الاختيار أولاً',
          'advancedDiff.table.markedRowsReviewed' =>
            ({required Object count}) => 'تم وضع علامة مراجعة لـ ${count} صفوف',
          'advancedDiff.table.revertedRows' => ({required Object count}) =>
              'تم التراجع عن ${count} صفوف',
          'advancedDiff.table.entriesCount' => ({required Object count}) =>
              '${count} إدخالات',
          'advancedDiff.table.markSelectedReviewed' =>
            'وضع علامة مراجعة للمحدد',
          'advancedDiff.table.revertSelected' => 'تراجع عن المحدد',
          'advancedDiff.table.noDifferences' => 'لم يتم العثور على فروق',
          'advancedDiff.table.adjustFilters' => 'حاول تعديل الفلاتر الخاصة بك',
          'advancedDiff.table.cloudTranslationApplied' =>
            'تم تطبيق الترجمة السحابية.',
          'advancedDiff.table.aiTranslationApplied' =>
            'تم تطبيق ترجمة الذكاء الاصطناعي.',
          'advancedDiff.table.suggestionApplied' => 'تم تطبيق الاقتراح.',
          'advancedDiff.table.aiSuggestionApplied' =>
            'تم تطبيق اقتراح الذكاء الاصطناعي.',
          'advancedDiff.table.rephraseApplied' => 'تم تطبيق إعادة الصياغة.',
          'advancedDiff.table.aiRephraseApplied' =>
            'تم تطبيق إعادة الصياغة بالذكاء الاصطناعي.',
          'advancedDiff.table.rephrase' => 'إعادة صياغة',
          'advancedDiff.table.aiRephrase' => 'إعادة صياغة بالذكاء الاصطناعي',
          'advancedDiff.table.targetClickToEdit' => 'الهدف (انقر للتعديل)',
          'advancedDiff.table.targetClickForDialog' => 'الهدف (انقر للحوار)',
          'advancedDiff.table.emptyClickToEdit' => '(فارغ - انقر للتعديل)',
          'advancedDiff.table.unmarkReviewed' => 'إزالة علامة المراجعة',
          'advancedDiff.table.markReviewed' => 'وضع علامة مراجعة',
          'advancedDiff.table.revertToSource' => 'تراجع إلى المصدر',
          'advancedDiff.table.translateWithCloud' => 'ترجمة سحابية',
          'advancedDiff.table.translateWithAi' => 'ترجمة بالذكاء الاصطناعي',
          'advancedDiff.table.rephraseWithAi' =>
            'إعادة صياغة بالذكاء الاصطناعي',
          'advancedDiff.table.moreActions' => 'المزيد من الإجراءات',
          'advancedDiff.table.editDetails' => 'تعديل التفاصيل',
          'advancedDiff.table.suggestTranslation' => 'اقتراح ترجمة',
          'advancedDiff.table.addToTm' => 'إضافة إلى الذاكرة',
          'advancedDiff.table.deleteEntry' => 'حذف إدخال',
          'advancedDiff.diffRow.copySource' => 'نسخ نص المصدر',
          'advancedDiff.diffRow.actions' => 'إجراءات',
          'advancedDiff.status.added' => 'مضاف',
          'advancedDiff.status.missing' => 'مفقود',
          'advancedDiff.status.changed' => ({required Object percent}) =>
              'معدل ${percent}%',
          'advancedDiff.status.same' => 'نفسه',
          'advancedDiff.sidebar.widgets' => 'أدوات',
          'advancedDiff.sidebar.searchPlaceholder' =>
            'بحث في المفاتيح والقيم... (Ctrl+F)',
          'advancedDiff.sidebar.fuzzySearchTooltip' =>
            'بحث ضبابي (متسامح مع الأخطاء المطبعية)',
          'advancedDiff.sidebar.regexSearchTooltip' => 'بحث Regex',
          'advancedDiff.sidebar.cloudTranslation' => 'ترجمة سحابية',
          'advancedDiff.sidebar.aiTranslation' => 'ترجمة بالذكاء الاصطناعي',
          'advancedDiff.sidebar.status' => 'الحالة',
          'advancedDiff.sidebar.tm' => 'ذاكرة الترجمة',
          'advancedDiff.sidebar.filters' => 'فلاتر',
          'advancedDiff.sidebar.actions' => 'إجراءات',
          'advancedDiff.sidebar.similarity' => 'التشابه',
          'advancedDiff.sidebar.actionsSection.exportMatches' =>
            'تصدير التطابقات',
          'advancedDiff.sidebar.actionsSection.preview' => 'معاينة',
          'advancedDiff.sidebar.actionsSection.fillFromTmTitle' =>
            'الملء من ذاكرة الترجمة؟',
          'advancedDiff.sidebar.actionsSection.fillFromTmContent' =>
            'سيحاول هذا ملء قيم الهدف الفارغة باستخدام تطابقات من ذاكرة الترجمة. لن يتم استبدال القيم الموجودة.',
          'advancedDiff.sidebar.actionsSection.fill' => 'ملء',
          'advancedDiff.sidebar.actionsSection.fillFromMemory' =>
            'ملء من الذاكرة',
          'advancedDiff.sidebar.actionsSection.filledFromTm' => (
                  {required Object count}) =>
              'تم ملء ${count} عناصر من ذاكرة الترجمة.',
          'advancedDiff.sidebar.aiSection.infoCloud' =>
            'يستخدم الترجمة السحابية لترجمة قيم الهدف الفارغة من المصدر.',
          'advancedDiff.sidebar.aiSection.infoAi' =>
            'يستخدم الذكاء الاصطناعي لترجمة قيم الهدف الفارغة من المصدر.',
          'advancedDiff.sidebar.aiSection.translationSettings' =>
            'إعدادات الترجمة',
          'advancedDiff.sidebar.aiSection.aiSettings' =>
            'إعدادات الذكاء الاصطناعي',
          'advancedDiff.sidebar.aiSection.source' => 'المصدر',
          'advancedDiff.sidebar.aiSection.target' => 'الهدف',
          'advancedDiff.sidebar.aiSection.translatingProgress' =>
            ({required Object percent}) => 'جارٍ الترجمة... ${percent}%',
          'advancedDiff.sidebar.aiSection.translating' => 'جارٍ الترجمة...',
          'advancedDiff.sidebar.aiSection.translateAllMissing' =>
            'ترجمة كل المفقود',
          'advancedDiff.sidebar.aiSection.translateAllTitle' =>
            'ترجمة كل المفقود؟',
          'advancedDiff.sidebar.aiSection.translateAllContent' => (
                  {required Object service,
                  required Object source,
                  required Object target}) =>
              'سيستخدم هذا ${service} لترجمة جميع الإدخالات ذات القيم الفارغة من ${source} إلى ${target}.\n\nيمكنك مراجعة كل اقتراح أو تطبيق الكل دفعة واحدة.',
          'advancedDiff.sidebar.aiSection.translateAll' => 'ترجمة الكل',
          'advancedDiff.sidebar.aiSection.reviewEach' => 'مراجعة كل واحد',
          'advancedDiff.sidebar.aiSection.cloudTranslated' => (
                  {required Object count}) =>
              'تمت ترجمة ${count} إدخالات بالترجمة السحابية.',
          'advancedDiff.sidebar.aiSection.aiTranslated' => (
                  {required Object count}) =>
              'تمت ترجمة ${count} إدخالات بالذكاء الاصطناعي.',
          'advancedDiff.sidebar.aiSection.aiTranslateFailed' =>
            'فشلت ترجمة الكل بالذكاء الاصطناعي',
          'advancedDiff.sidebar.aiSection.noMissingEntries' =>
            'لا توجد إدخالات مفقودة للترجمة.',
          'advancedDiff.sidebar.aiSection.skip' => 'تخطي',
          'advancedDiff.sidebar.aiSection.stop' => 'إيقاف',
          'advancedDiff.sidebar.aiSection.cloudApplied' =>
            ({required Object count}) => 'تم تطبيق ${count} اقتراحات.',
          'advancedDiff.sidebar.aiSection.aiApplied' => (
                  {required Object count}) =>
              'تم تطبيق ${count} اقتراحات ذكاء اصطناعي.',
          'advancedDiff.sidebar.tmSection.enableTmFill' => 'تفعيل ملء الذاكرة',
          'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' =>
            'تطبيق تلقائي فوق الحد الأدنى',
          'advancedDiff.sidebar.tmSection.matchSettings' => 'إعدادات المطابقة',
          'advancedDiff.sidebar.tmSection.minMatch' => 'أدنى تطابق:',
          'advancedDiff.sidebar.tmSection.limit' => 'الحد:',
          'advancedDiff.sidebar.tmSection.exact' => 'تام',
          'advancedDiff.sidebar.filtersSection.viewFilters' => 'فلاتر العرض',
          'advancedDiff.sidebar.filtersSection.showAll' => 'عرض الكل',
          'advancedDiff.sidebar.filtersSection.added' => 'مضاف',
          'advancedDiff.sidebar.filtersSection.removed' => 'محذوف',
          'advancedDiff.sidebar.filtersSection.modified' => 'معدل',
          'advancedDiff.sidebar.filtersSection.actionScope' => 'نطاق الإجراء',
          'advancedDiff.sidebar.filtersSection.applyToAdded' =>
            'تطبيق على المضاف',
          'advancedDiff.sidebar.filtersSection.applyToModified' =>
            'تطبيق على المعدل',
          'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' =>
            'ملء الأهداف الفارغة فقط',
          'advancedDiff.sidebar.filtersSection.limitToVisible' =>
            'قصر على المرئي',
          'advancedDiff.sidebar.filtersSection.editMode' => 'وضع التعديل',
          'advancedDiff.sidebar.filtersSection.dialog' => 'حوار',
          'advancedDiff.sidebar.filtersSection.inline' => 'مضمن',
          'advancedDiff.sidebar.similaritySection.currentFilter' =>
            'الفلتر الحالي:',
          'advancedDiff.sidebar.similaritySection.any' => 'أي',
          'advancedDiff.sidebar.similaritySection.high' => 'عالي',
          'advancedDiff.sidebar.similaritySection.medium' => 'متوسط',
          'advancedDiff.sidebar.similaritySection.low' => 'منخفض',
          'advancedDiff.sidebar.statusSection.total' =>
            ({required Object count}) => '${count} إجمالي',
          'advancedDiff.sidebar.statusSection.extra' =>
            ({required Object count}) => '${count} إضافي',
          'advancedDiff.sidebar.statusSection.missing' =>
            ({required Object count}) => '${count} مفقود',
          'advancedDiff.sidebar.statusSection.changed' =>
            ({required Object count}) => '${count} متغير',
          'issueDetails.title' => 'تفاصيل المشكلة',
          'issueDetails.showingIssues' => (
                  {required Object count, required Object total}) =>
              'عرض ${count} من ${total} مشكلة',
          'issueDetails.searchPlaceholder' => 'بحث بالمفتاح، النص، أو الخطأ...',
          'issueDetails.noDetails' => 'لا توجد تفاصيل متوفرة.',
          'issueDetails.noMatches' => 'لم يتم العثور على تطابقات.',
          'issueDetails.showMore' => 'إظهار المزيد',
          'issueDetails.copyItems' => ({required Object count}) =>
              'نسخ ${count} عنصر',
          'issueDetails.close' => 'إغلاق',
          'issueDetails.copied' => 'تم النسخ إلى الحافظة',
          'issueDetails.copiedCount' => ({required Object count}) =>
              'تم نسخ ${count} عنصر',
          'issueDetails.duplicateValue.label' => 'ترجمة مكررة',
          'issueDetails.duplicateValue.warning' =>
            'تستخدم نصوص مصدر مختلفة هذه الترجمة نفسها. تحقق من السياق.',
          'issueDetails.duplicateValue.affectedKeys' =>
            ({required Object count}) => 'المفاتيح المتأثرة (${count})',
          'issueDetails.duplicateValue.identicalSources' => 'مصادر متطابقة',
          'issueDetails.duplicateValue.moreKeys' => ({required Object count}) =>
              '+${count} مفاتيح أخرى',
          'issueDetails.lengthOutlier.source' => 'المصدر',
          'issueDetails.lengthOutlier.translation' => 'الترجمة',
          'issueDetails.lengthOutlier.chars' => ({required Object count}) =>
              '${count} حرف',
          'issueDetails.standard.key' => 'المفتاح',
          'issueDetails.standard.sourceText' => 'نص المصدر',
          'issueDetails.standard.translation' => 'الترجمة',
          'issueDetails.standard.errorDetails' => 'تفاصيل الخطأ',
          'issueDetails.standard.note' => 'ملاحظة',
          'issueDetails.review' => 'مراجعة',
          'issueDetails.types.duplicateValue' => 'قيم مكررة',
          'issueDetails.types.lengthOutlier' => 'عدم تطابق الطول',
          'issueDetails.types.placeholderMismatch' => 'عناصر نائبة معطلة',
          'issueDetails.notes.placeholderMismatch' =>
            'يجب أن تتطابق علامات مثل {name} مع المصدر.',
          'issueDetails.notes.lengthOutlier' =>
            'التغييرات الكبيرة في الطول يمكن أن تؤثر على كيفية ظهور النص على الشاشة.',
          'issueDetails.notes.duplicateValue' =>
            'يتم استخدام نفس الترجمة لمفاتيح مختلفة.',
          'issueDetails.fallbacks.multipleSources' => 'نصوص مصدر متعددة',
          'issueDetails.fallbacks.sourceNotAvailable' => 'نص المصدر غير متوفر',
          'issueDetails.fallbacks.sharedTranslationNotAvailable' =>
            'الترجمة المشتركة غير متوفرة',
          'issueDetails.fallbacks.translationNotAvailable' =>
            'الترجمة غير متوفرة',
          'importReview.title' => 'مراجعة استيراد المشروع',
          'importReview.projectName' => 'اسم المشروع',
          'importReview.created' => 'تم الإنشاء',
          'importReview.historyItems' => 'عناصر السجل',
          'importReview.customSettingsTitle' => 'تم اكتشاف إعدادات مخصصة',
          'importReview.customSettingsWarning' =>
            'يحتوي هذا المشروع على إعدادات مخصصة ستتجاوز افتراضياتك أثناء فتح هذا المشروع.',
          'importReview.standardSettings' =>
            'يستخدم هذا المشروع الإعدادات العالمية القياسية.',
          'importReview.cancelImport' => 'إلغاء الاستيراد',
          'importReview.trustOpen' => 'ثقة وفتح المشروع',
          'historyView.title' => 'سجل المقارنة',
          'historyView.clearAll' => 'مسح كل السجل',
          'historyView.searchPlaceholder' => 'بحث باسم الملف...',
          'historyView.sortBy' => 'فرز حسب',
          'historyView.sortDate' => 'التاريخ',
          'historyView.sortSource' => 'ملف المصدر',
          'historyView.sortTarget' => 'ملف الهدف',
          'historyView.showCurrentProject' => 'عرض: المشروع الحالي',
          'historyView.showAllHistory' => 'عرض: كل السجل',
          'historyView.groupByFolder' => 'تجميع حسب المجلد',
          'historyView.disableGrouping' => 'تعطيل تجميع المجلدات',
          'historyView.filterAll' => 'الكل',
          'historyView.filterFiles' => 'ملفات',
          'historyView.filterDirectories' => 'أدلة',
          'historyView.filterGit' => 'Git',
          'historyView.noHistory' => 'لا يوجد سجل مقارنة بعد',
          'historyView.historyDescription' => 'ستظهر مقارنات ملفاتك هنا',
          'historyView.noResults' => 'لا توجد نتائج',
          'historyView.adjustSearch' => 'حاول تعديل بحثك',
          'historyView.clearConfirmationTitle' => 'مسح كل السجل؟',
          'historyView.clearConfirmationContent' =>
            'سيؤدي هذا إلى حذف كل سجل المقارنة بشكل دائم. هذا الإجراء لا يمكن التراجع عنه.',
          'historyView.clearAction' => 'مسح الكل',
          'historyView.deletedMessage' => 'تم حذف عنصر السجل',
          'historyView.undo' => 'تراجع',
          'historyView.viewDetails' => 'عرض التفاصيل',
          'historyView.delete' => 'حذف',
          'historyView.openLocation' => 'فتح موقع الملف',
          'historyView.bilingual' => 'ثنائي اللغة',
          'historyView.filePair' => 'زوج ملفات',
          'historyView.directory' => 'دليل',
          'historyView.git' => 'Git',
          'historyView.repo' => 'مستودع',
          'historyView.sourceDir' => 'دليل المصدر',
          'historyView.targetDir' => 'دليل الهدف',
          'historyView.source' => 'المصدر',
          'historyView.target' => 'الهدف',
          'historyView.noChanges' => 'لم يتم اكتشاف تغييرات',
          'historyView.added' => 'مضاف',
          'historyView.removed' => 'محذوف',
          'historyView.modified' => 'معدل',
          'historyView.same' => 'نفسه',
          'historyView.total' => 'المجموع',
          'historyView.currentProject' => 'المشروع الحالي',
          'historyView.unassigned' => 'غير معين',
          'historyView.project' => 'المشروع',
          'compare.title' => 'مقارنة الملفات',
          'compare.sourceFile' => 'ملف المصدر',
          'compare.targetFile' => 'ملف الهدف',
          'compare.sourceFolder' => 'مجلد المصدر',
          'compare.targetFolder' => 'مجلد الهدف',
          'compare.dropFilesHint' =>
            'أفلت ملفات التوطين هنا أو استخدم أزرار التصفح لتحديد ملفات للمقارنة.',
          'compare.selectSourceFile' => 'تحديد ملف المصدر',
          'compare.selectTargetFile' => 'تحديد ملف الهدف',
          'compare.startComparison' => 'بدء المقارنة',
          'compare.comparing' => 'جارٍ المقارنة...',
          'compare.comparisonComplete' => 'اكتملت المقارنة',
          'compare.noChanges' => 'لم يتم اكتشاف تغييرات',
          'compare.filesIdentical' => 'الملفات متطابقة',
          'compare.changesFound' => ({required Object count}) =>
              'تم العثور على ${count} تغييرات',
          'compare.tabs.files' => 'ملفات',
          'compare.tabs.directories' => 'أدلة',
          'compare.tabs.git' => 'Git',
          'compare.fileTypes.json' =>
            'ملفات توطين JSON (i18next, Flutter, etc.)',
          'compare.fileTypes.yaml' => 'ملفات توطين YAML (Rails, Flutter)',
          'compare.fileTypes.xml' => 'ملفات توطين XML (Android, .NET)',
          'compare.fileTypes.properties' => 'ملفات Properties (Java)',
          'compare.fileTypes.resx' => 'ملفات RESX (.NET)',
          _ => null,
        } ??
        switch (path) {
          'compare.fileTypes.xliff' => 'ملفات XLIFF',
          'history.title' => 'السجل',
          'history.recentComparisons' => 'المقارنات الأخيرة',
          'history.noHistory' => 'لا يوجد سجل مقارنة بعد',
          'history.noHistoryDescription' => 'سيظهر سجل مقارنتك هنا',
          'history.clearHistory' => 'مسح السجل',
          'history.clearHistoryConfirm' =>
            'هل أنت متأكد أنك تريد مسح كل السجل؟',
          'history.deleteEntry' => 'حذف الإدخال',
          'history.openComparison' => 'فتح المقارنة',
          'history.timeAgo.justNow' => 'الآن',
          'history.timeAgo.secondsAgo' => ({required Object count}) =>
              'منذ ${count} ثواني',
          'history.timeAgo.oneMinuteAgo' => 'منذ دقيقة',
          'history.timeAgo.minutesAgo' => ({required Object count}) =>
              'منذ ${count} دقائق',
          'history.timeAgo.oneHourAgo' => 'منذ ساعة',
          'history.timeAgo.hoursAgo' => ({required Object count}) =>
              'منذ ${count} ساعات',
          'history.timeAgo.yesterday' => 'أمس',
          'history.timeAgo.daysAgo' => ({required Object count}) =>
              'منذ ${count} أيام',
          'history.timeAgo.oneWeekAgo' => 'منذ أسبوع',
          'history.timeAgo.weeksAgo' => ({required Object count}) =>
              'منذ ${count} أسابيع',
          'history.timeAgo.oneMonthAgo' => 'منذ شهر',
          'history.timeAgo.monthsAgo' => ({required Object count}) =>
              'منذ ${count} أشهر',
          'history.timeAgo.oneYearAgo' => 'منذ سنة',
          'history.timeAgo.yearsAgo' => ({required Object count}) =>
              'منذ ${count} سنوات',
          'history.timeAgo.inTheFuture' => 'في المستقبل',
          'projects.title' => 'المشاريع',
          'projects.createProject' => 'إنشاء مشروع',
          'projects.importProject' => 'استيراد مشروع',
          'projects.noProjects' => 'لا توجد مشاريع بعد',
          'projects.noProjectsDescription' =>
            'أنشئ مشروعاً لتنظيم ملفات التوطين الخاصة بك',
          'projects.projectName' => 'اسم المشروع',
          'projects.projectPath' => 'مسار المشروع',
          'projects.lastOpened' => 'آخر فتح',
          'projects.openProject' => 'فتح المشروع',
          'projects.closeProject' => 'إغلاق المشروع',
          'projects.deleteProject' => 'حذف المشروع',
          'projects.deleteProjectConfirm' =>
            'هل أنت متأكد أنك تريد حذف هذا المشروع؟',
          'projects.exportProject' => 'تصدير المشروع',
          'projects.exportDescription' =>
            'إنشاء ملف مضغوط محمول يحتوي على ملفات المصدر، التكوين، والسجل.',
          'projects.exporting' => 'جارٍ تصدير المشروع...',
          'projects.exportSuccess' => 'تم تصدير المشروع',
          'projects.exportError' => ({required Object error}) =>
              'فشل التصدير: ${error}',
          'projects.createNewProject' => 'إنشاء مشروع جديد',
          'projects.openExistingProject' => 'فتح مشروع موجود',
          'projects.importProjectZip' => 'استيراد ملف مضغوط للمشروع',
          'projects.projectResources' => 'موارد المشروع',
          'projects.recentProjects' => 'المشاريع الأخيرة',
          'projects.noRecentProjects' => 'لا توجد مشاريع حديثة',
          'projects.selectProjectZip' => 'تحديد ملف مضغوط للمشروع',
          'projects.selectDestination' => 'تحديد مجلد الوجهة للاستيراد',
          'projects.importing' => 'جارٍ استيراد المشروع...',
          'projects.importSuccess' => 'تم استيراد المشروع بنجاح',
          'projects.importFailed' => ({required Object error}) =>
              'فشل الاستيراد: ${error}',
          'projects.importingFiles' => 'جارٍ استيراد الملفات...',
          'projects.noSupportedFiles' => 'لم يتم إفلات أي ملفات مدعومة.',
          'projects.stats.empty' => 'مشروع فارغ',
          'projects.stats.files' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
                n,
                one: 'ملف ترجمة واحد',
                other: '${count} ملفات ترجمة',
              ),
          'projects.stats.languages' => (
                  {required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
                n,
                one: 'لغة واحدة',
                other: '${count} لغات',
              ),
          'projects.openProjectFirst' => 'افتح مشروعاً أولاً لإدارة موارده.',
          'projects.removeFromRecent' => 'إزالة من الحديثة',
          'projects.selection.selectFolder' => 'تحديد مجلد المشروع',
          'projects.selection.selectArchive' => 'تحديد أرشيف المشروع',
          'projects.selection.openProject' => 'فتح المشروع',
          'projects.selection.browseFolder' => 'تصفح المجلد...',
          'projects.selection.createNew' => 'إنشاء جديد',
          'projects.selection.importFromZip' => 'استيراد من Zip...',
          'projects.createDialog.title' => 'إنشاء مشروع',
          'projects.createDialog.description' =>
            'يسمح لك المشروع بحفظ إعدادات مخصصة لمجلد محدد. سيتم إنشاء مجلد ".localizer" لتخزين تكوين مشروعك.',
          'projects.createDialog.folderLabel' => 'مجلد المشروع',
          'projects.createDialog.folderHint' => 'انقر لتحديد المجلد...',
          'projects.createDialog.nameLabel' => 'اسم المشروع',
          'projects.createDialog.nameHint' => 'مثال: ترجمات تطبيقي',
          'projects.createDialog.selectFolderWarning' =>
            'يرجى تحديد مجلد المشروع.',
          'projects.createDialog.enterNameError' => 'يرجى إدخال اسم المشروع',
          'projects.createDialog.nameLengthError' =>
            'يجب أن يكون الاسم حرفين على الأقل',
          'projects.createDialog.success' => ({required Object name}) =>
              'تم إنشاء المشروع "${name}" بنجاح!',
          'projects.createDialog.failure' => 'فشل إنشاء المشروع.',
          'projects.createDialog.creating' => 'جارٍ الإنشاء...',
          'projects.createDialog.createAction' => 'إنشاء المشروع',
          'projects.indicator.tooltipNoProject' =>
            'أنشئ مشروعاً لحفظ إعدادات مخصصة لمجلد',
          'projects.indicator.tooltipProject' => ({required Object name}) =>
              'المشروع: ${name}\nانقر لرؤية الخيارات',
          'projects.indicator.location' => 'الموقع',
          'projects.indicator.created' => 'تم الإنشاء',
          'projects.indicator.switchProject' => 'تبديل المشروع',
          'projects.indicator.done' => 'تم',
          'projects.glossary.title' => 'مسرد المشروع',
          'projects.glossary.description' =>
            'تحديد المصطلحات التي يجب معاملتها بشكل متسق أو عدم ترجمتها أبداً.',
          'projects.glossary.noTerms' => 'لا توجد مصطلحات في المسرد بعد.',
          'projects.glossary.noTermsDesc' =>
            'أضف مصطلحات يجب أن تظل متسقة عبر الترجمات،\nأو ضع علامة على الأسماء التجارية التي يجب عدم ترجمتها أبداً.',
          'projects.glossary.doNotTranslate' => 'لا تترجم',
          'projects.glossary.noSpecificTranslation' => 'لا توجد ترجمة محددة',
          'projects.glossary.addTerm' => 'إضافة مصطلح',
          'projects.glossary.editTerm' => 'تعديل المصطلح',
          'projects.glossary.term' => 'المصطلح',
          'projects.glossary.termHint' =>
            'مثال: اسم العلامة التجارية، مصطلح متخصص',
          'projects.glossary.definition' => 'تعريف (اختياري)',
          'projects.glossary.definitionHint' => 'سياق للمترجم',
          'projects.glossary.doNotTranslateLabel' => 'لا تترجم',
          'projects.glossary.doNotTranslateDesc' =>
            'احتفظ بالمصطلح كما هو تماماً في الهدف',
          'projects.glossary.preferredTranslation' => 'الترجمة المفضلة',
          'projects.glossary.caseSensitive' => 'حساس لحالة الأحرف',
          'projects.conflicts.missingApiKeyTitle' =>
            ({required Object service}) => 'مفتاح API مفقود لـ ${service}',
          'projects.conflicts.missingApiKeyMessage' => (
                  {required Object service}) =>
              'يستخدم هذا المشروع ${service} ولكن لم يتم تكوين مفتاح API. أضف مفتاح API الخاص بك في الإعدادات > خدمات الذكاء الاصطناعي، أو سيستخدم التطبيق الافتراضي العالمي.',
          'projects.conflicts.dismiss' => 'تجاهل',
          'projects.tm.title' => 'ذواكر الترجمة',
          'projects.tm.description' =>
            'إدارة مصادر ذاكرة الترجمة لهذا المشروع.',
          'projects.tm.globalTm' => 'ذاكرة الترجمة العالمية',
          'projects.tm.globalTmDescription' =>
            'استخدام ذاكرة الترجمة المشتركة من إعدادات تطبيقك',
          'projects.tm.linkedFiles' => 'ملفات مرتبطة (خاص بالمشروع)',
          'projects.tm.noLinkedFiles' => 'لا توجد ملفات خاصة بالمشروع مرتبطة.',
          'projects.tm.addTmFile' => 'إضافة ملف ذاكرة ترجمة',
          'projects.tm.useGlobalTm' => 'استخدام ذاكرة الترجمة العالمية',
          'projects.tm.selectTm' => 'تحديد ذاكرة الترجمة',
          'projects.tm.globalTmEnabled' => 'تم تفعيل ذاكرة الترجمة العالمية',
          'diff.added' => 'مضاف',
          'diff.removed' => 'محذوف',
          'diff.modified' => 'معدل',
          'diff.unchanged' => 'غير متغير',
          'diff.missing' => 'مفقود',
          'diff.extra' => 'إضافي',
          'diff.sourceValue' => 'قيمة المصدر',
          'diff.targetValue' => 'قيمة الهدف',
          'diff.key' => 'المفتاح',
          'diff.status' => 'الحالة',
          'diff.actions' => 'إجراءات',
          'diff.copyToTarget' => 'نسخ إلى الهدف',
          'diff.acceptChange' => 'قبول التغيير',
          'diff.rejectChange' => 'رفض التغيير',
          'diff.viewDetails' => 'عرض التفاصيل',
          'git.title' => 'مقارنة Git',
          'git.selectRepository' => 'تحديد المستودع',
          'git.selectBranch' => 'تحديد الفرع',
          'git.selectCommit' => 'تحديد الالتزام (Commit)',
          'git.compareBranches' => 'مقارنة الفروع',
          'git.compareCommits' => 'مقارنة الالتزامات',
          'git.baseBranch' => 'الفرع الأساسي',
          'git.compareBranch' => 'فرع المقارنة',
          'git.noRepositories' => 'لم يتم العثور على مستودعات Git',
          'git.noRepositoriesDescription' => 'افتح مجلداً يحتوي على مستودع Git',
          'git.filesChanged' => ({required Object count}) =>
              'تم تغيير ${count} ملف',
          'git.additions' => ({required Object count}) => '${count} إضافات',
          'git.deletions' => ({required Object count}) => '${count} عمليات حذف',
          'git.conflicts.title' => 'تم اكتشاف تعارضات دمج',
          'git.conflicts.description' =>
            'يجب عليك حل هذه التعارضات قبل المتابعة.',
          'git.conflicts.abortMergeTitle' => 'إحباط الدمج؟',
          'git.conflicts.abortMergeContent' =>
            'سيؤدي هذا إلى التراجع عن جميع تغييرات الدمج والعودة إلى الحالة قبل الدمج. هذا لا يمكن التراجع عنه.',
          'git.conflicts.abortMergeAction' => 'إحباط الدمج',
          'git.conflicts.stagingFile' => ({required Object file}) =>
              'نقل ${file} للمرحلة المؤقت (Staging) للالتزام...',
          'git.conflicts.conflictedFilesCount' => ({required Object count}) =>
              'ملفات متعارضة (${count})',
          'git.conflicts.selectFileToResolve' => 'حدد ملفاً لحله',
          'git.conflicts.resolvingFile' => ({required Object file}) =>
              'جارٍ حل: ${file}',
          'git.conflicts.keepAllOurs' => 'الاحتفاظ بكل ما لدينا',
          'git.conflicts.acceptAllTheirs' => 'قبول كل ما لديهم',
          'git.conflicts.allResolved' => 'تم حل جميع التعارضات في هذا الملف!',
          'git.conflicts.markResolved' => 'وضع علامة تم الحل',
          'git.conflicts.stageForCommit' =>
            'سيؤدي هذا إلى نقل الملف للمرحلة المؤقتة للالتزام.',
          'git.conflicts.conflictIndex' => ({required Object index}) =>
              'تعارض #${index}',
          'git.conflicts.ours' => 'لدينا (الحالي)',
          'git.conflicts.theirs' => 'لديهم (الوارد)',
          'git.conflicts.keepOurs' => 'الاحتفاظ بما لدينا',
          'git.conflicts.acceptTheirs' => 'قبول ما لديهم',
          'git.conflicts.empty' => '(فارغ)',
          'quality._translatorNote' =>
            'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.',
          'quality.title' => 'لوحة الجودة',
          'quality.overallScore' => 'النتيجة الإجمالية',
          'quality.issues' => 'مشاك',
          'quality.warnings' => 'تحذيرات',
          'quality.suggestions' => 'اقتراحات',
          'quality.placeholderMismatch' => 'عدم تطابق العناصر النائبة',
          'quality.placeholderMismatchDescription' =>
            'العناصر النائبة مثل {name} لا تتطابق بين المصدر والهدف',
          'quality.lengthOutlier' => 'طول شاذ',
          'quality.lengthOutlierDescription' =>
            'يختلف طول الترجمة بشكل كبير عن المصدر',
          'quality.duplicateValue' => 'قيمة مكررة',
          'quality.duplicateValueDescription' =>
            'نفس الترجمة مستخدمة لمفاتيح متعددة',
          'quality.missingTranslation' => 'ترجمة مفقودة',
          'quality.missingTranslationDescription' =>
            'الترجمة مفقودة لهذا المفتاح',
          'quality.loading' => 'جارٍ تحميل لوحة القيادة...',
          'quality.errorLoading' => 'لم نتمكن من تحميل سجلك. حاول مرة أخرى.',
          'quality.emptyState' =>
            'قم بإجراء مقارنة لرؤية لوحة القيادة الخاصة بك.',
          'quality.refresh' => 'تحديث',
          'quality.buildingInsights' => 'بناء الرؤى...',
          'quality.crunchingNumbers' => 'معالجة الأرقام...',
          'quality.errorBuilding' =>
            'لم نتمكن من بناء لوحة القيادة. حاول مرة أخرى.',
          'quality.noUsableData' =>
            'لم يتم العثور على بيانات قابلة للاستخدام بعد.',
          'quality.languages' => 'اللغات',
          'quality.averageCoverage' => 'متوسط التغطية',
          'quality.potentialIssues' => 'مشاكل محتملة',
          'quality.translationCoverage' => 'تغطية الترجمة',
          'quality.entriesTranslated' => (
                  {required Object translated, required Object total}) =>
              'تم ترجمة ${translated} من ${total} إدخال',
          'quality.wordsAddedOverTime' => 'الكلمات المضافة مع مرور الوقت',
          'quality.completionVsScope' => 'الاكتمال مقابل النطاق',
          'quality.scopeVsProgress' => 'النطاق مقابل التقدم',
          'quality.coveragePercent' => 'التغطية %',
          'quality.wordsAdded' => 'كلمات مضافة',
          'quality.words' => 'كلمات',
          'quality.coverage' => 'تغطية',
          'quality.scope' => 'نطاق',
          'quality.latest' => 'الأحدث',
          'quality.added' => 'مضاف',
          'quality.change' => 'تغيير',
          'quality.totalScope' => 'النطاق الإجمالي',
          'quality.wordsCount' => ({required Object count}) => '${count} كلمة',
          'quality.scopeGrowth' => 'نمو النطاق',
          'quality.range' => 'النطاق',
          'quality.aiUsage' => 'استخدام الذكاء الاصطناعي والترجمة',
          'quality.lastUsed' => ({required Object date}) =>
              'آخر استخدام ${date}',
          'quality.noIssuesFound' =>
            'لم يتم العثور على مشاكل في أحدث المقارنات.',
          'quality.placeholderMismatches' => 'عدم تطابق العناصر النائبة',
          'quality.placeholderMismatchesDesc' =>
            'العلامات مثل {name} لا تتطابق.',
          'quality.lengthOutliers' => 'ترجمات قصيرة جداً أو طويلة جداً',
          'quality.lengthOutliersDesc' => 'يبدو الطول غير عادي مقارنة بالمصدر.',
          'quality.duplicateValues' => 'قيم مكررة',
          'quality.duplicateValuesDesc' =>
            'يتم استخدام نفس الترجمة مرات عديدة.',
          'quality.placeholderDialogTitle' => 'عدم تطابق العناصر النائبة',
          'quality.placeholderDialogDesc' =>
            'تحتوي هذه الترجمات على عناصر نائبة ({name}) مختلفة عن المصدر.',
          'quality.lengthDialogTitle' => 'طول شاذ',
          'quality.lengthDialogDesc' =>
            'هذه الترجمات أقصر أو أطول بكثير من المصدر.',
          'quality.duplicateDialogTitle' => 'قيم مكررة',
          'quality.duplicateDialogDesc' => 'تظهر هذه الترجمات عدة مرات.',
          'quality.duplicateSample' => ({required Object value}) =>
              'مكرر: "${value}"',
          'quality.exportError' => 'تعذر بناء التقرير. يرجى المحاولة مرة أخرى.',
          'quality.noDataToExport' => 'لا توجد بيانات للتصدير',
          'quality.exportFailed' => 'فشل التصدير',
          'quality.exportDialogTitle' => 'تصدير تقرير الجودة',
          'quality.reportSaved' => 'تم حفظ التقرير',
          'quality.export' => 'تصدير',
          'quality.requests' => 'Requests',
          'quality.tokens' => 'Tokens',
          'quality.characters' => 'Characters',
          'quality.estCost' => 'Est. Cost',
          'quality.prompt' => 'Prompt',
          'quality.completion' => 'Completion',
          'quality.showingCurrentProject' => 'عرض: المشروع الحالي',
          'quality.showingAllHistory' => 'عرض: كل السجل',
          'quality.filesSkipped' => 'تم تخطي بعض الملفات لعدم العثور عليها.',
          'quality.charCount' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
                n,
                one: 'حرف واحد',
                other: '${count} أحرف',
              ),
          'quality.lengthDiff' => (
                  {required Object target,
                  required Object percent,
                  required Object source}) =>
              'الهدف ${target} (${percent}%) مقابل المصدر ${source}',
          'errors.genericError' => 'حدث خطأ',
          'errors.fileNotFound' => 'لم يتم العثور على الملف',
          'errors.invalidFormat' => 'تنسيق ملف غير صالح',
          'errors.parseError' => 'فشل تحليل الملف',
          'errors.networkError' => 'خطأ في الشبكة. يرجى التحقق من اتصالك.',
          'errors.permissionDenied' => 'تم رفض الإذن',
          'errors.unknownError' => 'حدث خطأ غير متوقع',
          'wizards.firstRun.welcome' => 'مرحباً في Localizer',
          'wizards.firstRun.description' =>
            'قارن ملفات التوطين الخاصة بك في ثوانٍ.',
          'wizards.firstRun.sourceFile' => 'ملف المصدر',
          'wizards.firstRun.targetFile' => 'ملف الهدف',
          'wizards.firstRun.compareNow' => 'قارن الآن',
          'wizards.firstRun.trySample' => 'جرب مع بيانات العينة',
          'wizards.firstRun.skip' => 'تخطي الإعداد',
          'wizards.firstRun.browse' => 'انقر للتصفح',
          'wizards.firstRun.error' => ({required Object error}) =>
              'فشل تحميل بيانات العينة: ${error}',
          'dialogs.addIgnorePattern.title' => 'إضافة نمط تجاهل',
          'dialogs.addIgnorePattern.patternLabel' => 'النمط (regex)',
          'dialogs.addIgnorePattern.hint' => 'مثال: ^temp_.*',
          'dialogs.addIgnorePattern.invalid' => 'نمط regex غير صالح',
          'dialogs.addIgnorePattern.testStringLabel' => 'نص اختبار',
          'dialogs.addIgnorePattern.testHint' =>
            'أدخل مفتاحاً للاختبار ضد النمط',
          'dialogs.addIgnorePattern.match' => '✓ النمط يطابق نص الاختبار',
          'dialogs.addIgnorePattern.noMatch' => '✗ النمط لا يطابق',
          'dialogs.addIgnorePattern.add' => 'إضافة',
          'dialogs.addIgnorePattern.cancel' => 'إلغاء',
          'dialogs.diffViewer.title' => 'عارض الفرق',
          'dialogs.diffViewer.originalFile' => 'ملف الأصل/المرجع',
          'dialogs.diffViewer.translationFile' => 'ملف الترجمة/المقارنة',
          'dialogs.diffViewer.base' => 'BASE',
          'dialogs.diffViewer.target' => 'TARGET',
          'dialogs.diffViewer.added' => 'مضاف',
          'dialogs.diffViewer.removed' => 'محذوف',
          'dialogs.diffViewer.modified' => 'معدل',
          'dialogs.diffViewer.noMatches' =>
            'لا توجد إدخالات تطابق الفلاتر الحالية',
          'dialogs.diffViewer.clickToggle' =>
            'انقر على الشارات أعلاه لتبديل الفلاتر',
          'dialogs.diffViewer.clickToHide' => '(انقر للإخفاء)',
          'dialogs.diffViewer.clickToShow' => '(انقر للإظهار)',
          'grid.columns.key' => 'المفتاح',
          'grid.columns.source' => 'المصدر',
          'grid.columns.status' => 'الحالة',
          'grid.columns.actions' => 'إجراءات',
          'tutorial.skipTutorial' => 'تخطي التعليم',
          'tutorial.finishMessage' =>
            'أنت جاهز تماماً! انقر في أي مكان للإنهاء.',
          'tutorial.next' => 'التالي',
          'tutorial.loadSampleData' => 'تحميل بيانات العينة',
          'tutorial.browseSourceFile' => 'تصفح ملف المصدر',
          'tutorial.browseTargetFile' => 'تصفح ملف الهدف',
          'tutorial.compareFiles' => 'مقارنة الملفات',
          'tutorial.hintPhase2' =>
            'التالي: الفلاتر، البحث، العرض المتقدم، والتصدير.',
          'tutorial.steps.importSource.title' => '1. استيراد ملف المصدر',
          'tutorial.steps.importSource.description' =>
            'استخدم الزر أدناه لتصفح الملف، أو اسحب وأفلت في المنطقة المظللة.',
          'tutorial.steps.importTarget.title' => '2. استيراد ملف الهدف',
          'tutorial.steps.importTarget.description' =>
            'استخدم الزر أدناه لتصفح الملف، أو اسحب وأفلت في المنطقة المظللة.',
          'tutorial.steps.compare.title' => '3. مقارنة الملفات',
          'tutorial.steps.compare.description' =>
            'انقر على الزر أدناه لتشغيل المقارنة ورؤية النتائج.',
          'tutorial.steps.filter.title' => '4. تصفية النتائج',
          'tutorial.steps.filter.description' =>
            'استخدم هذه الفلاتر لعرض السلاسل المضافة، المحذوفة، أو المعدلة.',
          'tutorial.steps.search.title' => '5. نتائج البحث',
          'tutorial.steps.search.description' =>
            'اعثر على مفاتيح أو قيم محددة باستخدام شريط البحث.',
          'tutorial.steps.advanced.title' => '6. العرض المتقدم',
          'tutorial.steps.advanced.description' =>
            'افتح عرض الفرق التفصيلي مع التعديل، والترجمة بالذكاء الاصطناعي، والمزيد.',
          'tutorial.steps.export.title' => '7. تصدير النتائج',
          'tutorial.steps.export.description' =>
            'احفظ مقارنتك كملف CSV، JSON، أو Excel.',
          'friendlyErrors.fileNotFound.message' =>
            'لا يمكن العثور على الملف أو المجلد.',
          'friendlyErrors.fileNotFound.suggestion' =>
            'تحقق ما إذا كان الملف قد تم نقله أو حذفه.',
          'friendlyErrors.accessDenied.message' => 'تم رفض الوصول إلى الملف.',
          'friendlyErrors.accessDenied.suggestion' =>
            'حاول تشغيل التطبيق كمسؤول أو تحقق من أذونات الملف.',
          'friendlyErrors.isDirectory.message' => 'تم تحديد مجلد بدلاً من ملف.',
          'friendlyErrors.isDirectory.suggestion' => 'يرجى تحديد ملف صالح.',
          'friendlyErrors.fileAccess.message' =>
            'حدثت مشكلة في الوصول إلى الملف.',
          'friendlyErrors.fileAccess.suggestion' =>
            'حاول إغلاق البرامج الأخرى التي قد تستخدمه.',
          'friendlyErrors.unsupportedFormat.message' =>
            'تنسيق الملف هذا أو العملية غير مدعومة.',
          'friendlyErrors.unsupportedFormat.suggestion' =>
            'تحقق من امتداد الملف أو جرب تنسيقاً مختلفاً.',
          'friendlyErrors.networkError.message' => 'تعذر الاتصال بالخادم.',
          'friendlyErrors.networkError.suggestion' =>
            'تحقق من اتصالك بالإنترنت وحاول مرة أخرى.',
          'friendlyErrors.notGitRepo.message' => 'هذا المجلد ليس مشروع Git.',
          'friendlyErrors.notGitRepo.suggestion' =>
            'انتقل إلى مجلد يحتوي على دليل .git.',
          'friendlyErrors.mergeConflict.message' =>
            'توجد تعارضات دمج في المستودع.',
          'friendlyErrors.mergeConflict.suggestion' =>
            'قم بحل التعارضات قبل المتابعة.',
          'friendlyErrors.gitAuthFailed.message' => 'فشلت مصادقة Git.',
          'friendlyErrors.gitAuthFailed.suggestion' =>
            'تحقق من بيانات اعتمادك في الإعدادات > التحكم في الإصدار.',
          'friendlyErrors.gitOperationFailed.message' => 'فشلت عملية Git.',
          'friendlyErrors.gitOperationFailed.suggestion' =>
            'تحقق من عرض Git لمزيد من التفاصيل.',
          'friendlyErrors.invalidJson.message' =>
            'تنسيق الملف غير صالح أو تالف.',
          'friendlyErrors.invalidJson.suggestion' =>
            'تأكد من أن الملف يحتوي على محتوى JSON صالح.',
          'friendlyErrors.rateLimitReached.message' =>
            'تم الوصول إلى حد الترجمة.',
          'friendlyErrors.rateLimitReached.suggestion' =>
            'انتظر بضع دقائق أو تحقق من حدود خطة API الخاصة بك.',
          'friendlyErrors.invalidApiKey.message' => 'مفتاح API غير صالح.',
          'friendlyErrors.invalidApiKey.suggestion' =>
            'انتقل إلى الإعدادات > الترجمة بالذكاء الاصطناعي لتحديث مفتاح API الخاص بك.',
          'friendlyErrors.translationServiceError.message' =>
            'خطأ في خدمة الترجمة.',
          'friendlyErrors.translationServiceError.suggestion' =>
            'تحقق من مفتاح API واتصالك بالإنترنت.',
          'friendlyErrors.outOfMemory.message' =>
            'لا توجد ذاكرة كافية لإكمال هذه العملية.',
          'friendlyErrors.outOfMemory.suggestion' =>
            'حاول إغلاق التطبيقات الأخرى أو استخدام ملفات أصغر.',
          'friendlyErrors.genericError.message' => 'حدث خطأ ما.',
          'friendlyErrors.genericError.suggestion' =>
            'يرجى المحاولة مرة أخرى. إذا استمرت المشكلة، أعد تشغيل التطبيق.',
          'systemTray.showLocalizer' => 'إظهار Localizer',
          'systemTray.exit' => 'خروج',
          'validation.connected' => 'متصل.',
          'validation.connectionTimeout' =>
            'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.',
          'validation.couldNotConnect' =>
            'تعذر الاتصال. يرجى المحاولة مرة أخرى.',
          'validation.checkKeyAndTryAgain' =>
            'تعذر الاتصال. يرجى التحقق من المفتاح والمحاولة مرة أخرى.',
          'validation.tryAgainLater' =>
            'تعذر الاتصال الآن. يرجى المحاولة مرة أخرى لاحقاً.',
          'validation.serviceUnavailable' =>
            'الخدمة غير متوفرة الآن. يرجى المحاولة مرة أخرى لاحقاً.',
          'validation.enterKeyFirst' => 'يرجى إدخال مفتاح أولاً.',
          'validation.checking' => 'جارٍ التحقق...',
          'validation.deeplUsage' => (
                  {required Object used, required Object limit}) =>
              'الاستخدام: ${used} / ${limit} حرف.',
          'status.startingComparison' => 'جارٍ بدء المقارنة...',
          'status.loadingFromHistory' => 'جارٍ تحميل الملفات من السجل...',
          'status.comparisonComplete' => 'اكتملت المقارنة',
          'status.couldNotImportFiles' =>
            'تعذر استيراد الملفات. يرجى المحاولة مرة أخرى.',
          'status.historyFilesNotFound' =>
            'لم يتم العثور على أحد الملفين أو كلاهما من السجل في المسارات الأصلية.',
          'aiServices.geminiEmptyResponse' => 'أعاد Gemini استجابة فارغة',
          'aiServices.geminiStreamingEmpty' =>
            'أعاد البث المباشر لـ Gemini استجابة فارغة',
          'aiServices.geminiRephraseEmpty' =>
            'أعاد Gemini استجابة فارغة لإعادة الصياغة',
          'aiServices.openaiEmptyResponse' =>
            'أعاد OpenAI استجابة فارغة أو فاشلة',
          _ => null,
        };
  }
}
