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
class TranslationsHi
    with BaseTranslations<AppLocale, Translations>
    implements Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsHi(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.hi,
              overrides: overrides ?? {},
              cardinalResolver: cardinalResolver,
              ordinalResolver: ordinalResolver,
            ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <hi>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final TranslationsHi _root = this; // ignore: unused_field

  @override
  TranslationsHi $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsHi(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsAppHi app = _TranslationsAppHi._(_root);
  @override
  late final _TranslationsCommonHi common = _TranslationsCommonHi._(_root);
  @override
  late final _TranslationsMenuHi menu = _TranslationsMenuHi._(_root);
  @override
  late final _TranslationsNavHi nav = _TranslationsNavHi._(_root);
  @override
  late final _TranslationsSettingsHi settings =
      _TranslationsSettingsHi._(_root);
  @override
  late final _TranslationsFileComparisonHi fileComparison =
      _TranslationsFileComparisonHi._(_root);
  @override
  late final _TranslationsDirectoryComparisonHi directoryComparison =
      _TranslationsDirectoryComparisonHi._(_root);
  @override
  late final _TranslationsGitComparisonHi gitComparison =
      _TranslationsGitComparisonHi._(_root);
  @override
  late final _TranslationsAdvancedComparisonHi advancedComparison =
      _TranslationsAdvancedComparisonHi._(_root);
  @override
  late final _TranslationsAdvancedDiffHi advancedDiff =
      _TranslationsAdvancedDiffHi._(_root);
  @override
  late final _TranslationsIssueDetailsHi issueDetails =
      _TranslationsIssueDetailsHi._(_root);
  @override
  late final _TranslationsImportReviewHi importReview =
      _TranslationsImportReviewHi._(_root);
  @override
  late final _TranslationsHistoryViewHi historyView =
      _TranslationsHistoryViewHi._(_root);
  @override
  late final _TranslationsCompareHi compare = _TranslationsCompareHi._(_root);
  @override
  late final _TranslationsHistoryHi history = _TranslationsHistoryHi._(_root);
  @override
  late final _TranslationsProjectsHi projects =
      _TranslationsProjectsHi._(_root);
  @override
  late final _TranslationsDiffHi diff = _TranslationsDiffHi._(_root);
  @override
  late final _TranslationsGitHi git = _TranslationsGitHi._(_root);
  @override
  late final _TranslationsQualityHi quality = _TranslationsQualityHi._(_root);
  @override
  late final _TranslationsErrorsHi errors = _TranslationsErrorsHi._(_root);
  @override
  late final _TranslationsWizardsHi wizards = _TranslationsWizardsHi._(_root);
  @override
  late final _TranslationsDialogsHi dialogs = _TranslationsDialogsHi._(_root);
  @override
  late final _TranslationsGridHi grid = _TranslationsGridHi._(_root);
  @override
  late final _TranslationsTutorialHi tutorial =
      _TranslationsTutorialHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsHi friendlyErrors =
      _TranslationsFriendlyErrorsHi._(_root);
  @override
  late final _TranslationsSystemTrayHi systemTray =
      _TranslationsSystemTrayHi._(_root);
  @override
  late final _TranslationsValidationHi validation =
      _TranslationsValidationHi._(_root);
  @override
  late final _TranslationsStatusHi status = _TranslationsStatusHi._(_root);
  @override
  late final _TranslationsAiServicesHi aiServices =
      _TranslationsAiServicesHi._(_root);
  @override
  late final _TranslationsDiffTableHi diffTable =
      _TranslationsDiffTableHi._(_root);
  @override
  late final _TranslationsOnboardingHi onboarding =
      _TranslationsOnboardingHi._(_root);
}

// Path: app
class _TranslationsAppHi implements TranslationsAppEn {
  _TranslationsAppHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Localization Comparison Tool';
  @override
  String get name => 'Localizer';
}

// Path: common
class _TranslationsCommonHi implements TranslationsCommonEn {
  _TranslationsCommonHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get save => 'सहेजें';
  @override
  String get cancel => 'रद्द करें';
  @override
  String get close => 'बंद करें';
  @override
  String get delete => 'हटाएं';
  @override
  String get edit => 'संपादित करें';
  @override
  String get add => 'जोड़ें';
  @override
  String get search => 'खोजें';
  @override
  String get undo => 'पूर्ववत करें';
  @override
  String get loading => 'लोड हो रहा है...';
  @override
  String get error => 'त्रुटि';
  @override
  String get success => 'सफल';
  @override
  String get warning => 'चेतावनी';
  @override
  String get info => 'जानकारी';
  @override
  String get confirm => 'पुष्टि करें';
  @override
  String get yes => 'हाँ';
  @override
  String get no => 'नहीं';
  @override
  String get ok => 'ठीक है';
  @override
  String get retry => 'पुनः प्रयास करें';
  @override
  String get copyText => 'कॉपी करें';
  @override
  String get appName => 'Localizer';
  @override
  String get copied => 'कॉपी किया गया!';
  @override
  String get enabled => 'सक्षम';
  @override
  String get disabled => 'अक्षम';
  @override
  String get browse => 'ब्राउज़ करें';
  @override
  String get clear => 'साफ़ करें';
  @override
  String get apply => 'लागू करें';
  @override
  String get reset => 'रीसेट करें';
  @override
  String get refresh => 'ताज़ा करें';
  @override
  String get export => 'निर्यात करें';
  @override
  String get import => 'आयात करें';
  @override
  String get select => 'चुनें';
  @override
  String get selectAll => 'सभी चुनें';
  @override
  String get deselectAll => 'सभी को अचयनित करें';
  @override
  String get noResults => 'कोई परिणाम नहीं मिला';
  @override
  String get emptyState => 'यहाँ अभी कुछ नहीं है';
  @override
  String get open => 'खोलें';
  @override
  String get change => 'बदलें';
  @override
  String get original => 'मूल';
  @override
  String get kNew => 'नया';
  @override
  String get remove => 'निकालें';
  @override
  String get auto => 'स्वचालित';
  @override
  String get execute => 'निष्पादित करें';
  @override
  String get run => 'चलाएं';
  @override
  String get unknown => 'अज्ञात';
  @override
  String get download => 'डाउनलोड करें';
  @override
  String get dropdownArrow => 'ड्रॉपडाउन तीर';
  @override
  String get openInNewWindow => 'नई विंडो में खुलता है';
  @override
  String get resetToDefaults => 'डिफ़ॉल्ट पर रीसेट करें';
}

// Path: menu
class _TranslationsMenuHi implements TranslationsMenuEn {
  _TranslationsMenuHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get file => 'फ़ाइल';
  @override
  String get edit => 'संपादित करें';
  @override
  String get view => 'दृश्य';
  @override
  String get help => 'मदद';
  @override
  String get openFiles => 'फ़ाइलें खोलें...';
  @override
  String get openFolder => 'फ़ोल्डर खोलें...';
  @override
  String get exportResults => 'परिणाम निर्यात करें...';
  @override
  String get undo => 'पूर्ववत करें';
  @override
  String get redo => 'फिर से करें';
  @override
  String get cut => 'काटें';
  @override
  String get paste => 'चिपकाएं';
  @override
  String get selectAll => 'सभी चुनें';
  @override
  String get zoomIn => 'ज़ूम इन';
  @override
  String get zoomOut => 'ज़ूम आउट';
  @override
  String get resetZoom => 'ज़ूम रीसेट करें';
  @override
  String get documentation => 'दस्तावेज़ीकरण';
  @override
  String get reportIssue => 'समस्या की रिपोर्ट करें';
  @override
  String about({required Object appName}) => '${appName} के बारे में';
}

// Path: nav
class _TranslationsNavHi implements TranslationsNavEn {
  _TranslationsNavHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get compare => 'तुलना करें';
  @override
  String get history => 'इतिहास';
  @override
  String get settings => 'सेटिंग्स';
  @override
  String get projects => 'प्रोजेक्ट्स';
  @override
  String get dashboard => 'डैशबोर्ड';
  @override
  String get directory => 'डायरेक्टरी';
  @override
  String get repository => 'रिपॉजिटरी';
  @override
  String get tooltipCompare => 'स्थानीयकरण फ़ाइलों की तुलना करें';
  @override
  String get tooltipHistory => 'तुलना इतिहास देखें';
  @override
  String get tooltipSettings => 'ऐप सेटिंग्स';
  @override
  String get tooltipProjects => 'प्रोजेक्ट्स प्रबंधित करें';
  @override
  String get tooltipThemeToggle => 'थीम टॉगल करें';
  @override
  String get tooltipDebugConsole => 'डिबग कंसोल';
}

// Path: settings
class _TranslationsSettingsHi implements TranslationsSettingsEn {
  _TranslationsSettingsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'सेटिंग्स';
  @override
  String get appSettings => 'ऐप सेटिंग्स';
  @override
  String get projectSettings => 'प्रोजेक्ट सेटिंग्स';
  @override
  late final _TranslationsSettingsAppearanceHi appearance =
      _TranslationsSettingsAppearanceHi._(_root);
  @override
  late final _TranslationsSettingsGeneralHi general =
      _TranslationsSettingsGeneralHi._(_root);
  @override
  late final _TranslationsSettingsScopeHi scope =
      _TranslationsSettingsScopeHi._(_root);
  @override
  late final _TranslationsSettingsSearchKeywordsHi searchKeywords =
      _TranslationsSettingsSearchKeywordsHi._(_root);
  @override
  late final _TranslationsSettingsComparisonHi comparison =
      _TranslationsSettingsComparisonHi._(_root);
  @override
  late final _TranslationsSettingsFileHandlingHi fileHandling =
      _TranslationsSettingsFileHandlingHi._(_root);
  @override
  late final _TranslationsSettingsTranslationMemoryHi translationMemory =
      _TranslationsSettingsTranslationMemoryHi._(_root);
  @override
  late final _TranslationsSettingsBackupHi backup =
      _TranslationsSettingsBackupHi._(_root);
  @override
  late final _TranslationsSettingsAiHi ai = _TranslationsSettingsAiHi._(_root);
  @override
  late final _TranslationsSettingsIntegrationsHi integrations =
      _TranslationsSettingsIntegrationsHi._(_root);
  @override
  late final _TranslationsSettingsDeveloperHi developer =
      _TranslationsSettingsDeveloperHi._(_root);
  @override
  late final _TranslationsSettingsAboutHi about =
      _TranslationsSettingsAboutHi._(_root);
  @override
  late final _TranslationsSettingsOnboardingHi onboarding =
      _TranslationsSettingsOnboardingHi._(_root);
  @override
  late final _TranslationsSettingsSettingsViewHi settingsView =
      _TranslationsSettingsSettingsViewHi._(_root);
}

// Path: fileComparison
class _TranslationsFileComparisonHi implements TranslationsFileComparisonEn {
  _TranslationsFileComparisonHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'फ़ाइल तुलना';
  @override
  String get openFiles => 'फ़ाइलें खोलें';
  @override
  String get exportResults => 'परिणाम निर्यात करें';
  @override
  String get restartTutorial => 'ट्यूटोरियल पुनः आरंभ करें';
  @override
  String get restartTutorialDevOnly =>
      'ट्यूटोरियल पुनः आरंभ केवल डेवलपर मोड में उपलब्ध है।';
  @override
  String get unsupportedFileType => 'असमर्थित फ़ाइल प्रकार।';
  @override
  String get unsupportedFileTypeSuggestion =>
      'कृपया एक समर्थित स्थानीयकरण फ़ाइल चुनें।';
  @override
  String get someFilesUnsupported => 'कुछ फ़ाइलें समर्थित नहीं हैं।';
  @override
  String get pickSupportedFiles => 'केवल समर्थित स्थानीयकरण फ़ाइलें चुनें।';
  @override
  String get pickTwoFiles => 'तुलना करने के लिए दो फ़ाइलें चुनें।';
  @override
  String get pickBilingualFile =>
      'तुलना करने के लिए कृपया एक द्विभाषी फ़ाइल चुनें।';
  @override
  String get noResultsToExport => 'निर्यात करने के लिए अभी कोई परिणाम नहीं है।';
  @override
  String get performComparisonFirst =>
      'परिणाम निर्यात करने के लिए पहले तुलना करें।';
  @override
  String get performComparisonFirstEditor =>
      'उन्नत विवरण देखने के लिए कृपया पहले तुलना करें।';
  @override
  String get sampleDataLoaded => 'नमूना डेटा सफलतापूर्वक लोड किया गया';
  @override
  String loadSampleDataError({required Object error}) =>
      'नमूना डेटा लोड करने में विफल: ${error}';
  @override
  String get invalidFileType => 'अमान्य फ़ाइल प्रकार।';
  @override
  String fileSelected({required Object label, required Object fileName}) =>
      '${label} चयनित: ${fileName}';
  @override
  String get sourceFile => 'स्रोत फ़ाइल';
  @override
  String get targetFile => 'लक्ष्य फ़ाइल';
  @override
  String get bilingualFile => 'द्विभाषी फ़ाइल';
  @override
  String get compareFiles => 'फ़ाइलों की तुलना करें';
  @override
  String get compareFile => 'फ़ाइल की तुलना करें';
  @override
  String get bilingualMode => 'द्विभाषी मोड';
  @override
  String get twoFilesMode => 'दो फ़ाइलें';
  @override
  String get processing => 'प्रोसेसिंग...';
  @override
  String remaining({required Object time}) => '${time} शेष';
  @override
  String get comparisonInProgress => 'तुलना प्रगति पर है...';
  @override
  String comparisonFailed({required Object error}) => 'तुलना विफल: ${error}';
  @override
  String fileChanged({required Object fileName}) =>
      'फ़ाइल बदल गई: ${fileName}। पुनः तुलना कर रहा है...';
  @override
  String get dropFileHere => 'फ़ाइल यहाँ छोड़ें';
  @override
  String get dropFileOrBrowse =>
      'फ़ाइल छोड़ें या ब्राउज़ करने के लिए क्लिक करें';
  @override
  String get fileUpload => 'फ़ाइल अपलोड करें';
  @override
  String get changeFile => 'फ़ाइल बदलें';
  @override
  String get total => 'कुल';
  @override
  String get show => 'दिखाएं';
  @override
  String get showAll => 'सभी दिखाएं';
  @override
  String noMatches({required Object query}) =>
      '"${query}" के लिए कोई मेल नहीं मिला';
  @override
  String showingEntries({required Object total, required Object count}) =>
      '${total} में से ${count} प्रविष्टियाँ दिखा रहा है';
  @override
  String get filesIdentical => 'फ़ाइलें समान हैं।';
  @override
  String hiddenIdentical({required Object count}) =>
      '${count} समान प्रविष्टियाँ छिपी हुई हैं';
  @override
  String get showIdentical => 'समान प्रविष्टियाँ दिखाएं';
  @override
  String get hideIdentical => 'समान प्रविष्टियाँ छिपाएं';
  @override
  String get noDiff => 'कुंजियों के आधार पर कोई अंतर नहीं मिला।';
  @override
  String get source => 'स्रोत';
  @override
  String get target => 'लक्ष्य';
  @override
  String get value => 'मान';
  @override
  String get readyToCompare => 'फ़ाइलों की तुलना करने के लिए तैयार';
  @override
  String get readyToCompareDesc =>
      'ऊपर स्थानीयकरण फ़ाइलें छोड़ें या तुलना के लिए फ़ाइलों का चयन करने के लिए\nब्राउज़ बटन का उपयोग करें।';
  @override
  String get recentComparisons => 'हालिया तुलनाएं';
  @override
  String bilingualFileLabel({required Object name}) =>
      'द्विभाषी फ़ाइल: ${name}';
  @override
  String comparisonLabel({required Object source, required Object target}) =>
      '${source} ↔ ${target}';
  @override
  String get fileNotExist =>
      'इस सत्र की एक या दोनों फ़ाइलें अब मौजूद नहीं हैं।';
  @override
  String get largeFileTitle => 'बड़ी फ़ाइल का पता चला';
  @override
  String largeFileContent({required Object count}) =>
      'तुलना परिणाम में ${count} प्रविष्टियाँ हैं।\nउन सभी को प्रदर्शित करने से प्रदर्शन संबंधी समस्याएं हो सकती हैं।\n\nक्या आप आगे बढ़ना चाहते हैं?';
  @override
  String get dontShowAgain => 'इस फ़ाइल के लिए फिर से न दिखाएं';
  @override
  String get proceed => 'आगे बढ़ें';
  @override
  String exportReport({required Object format}) => '${format} रिपोर्ट सहेजें';
  @override
  String saved({required Object format}) => '${format} सहेजा गया';
  @override
  String saveError({required Object format}) =>
      '${format} फ़ाइल सहेजने में विफल।';
  @override
  String saveErrorDetailed({required Object format, required Object error}) =>
      '${format} सहेजने में विफल: ${error}';
  @override
  String get watching => 'निगरानी';
  @override
  String get watchOff => 'निगरानी बंद';
  @override
  String watchingTooltip({required Object status}) =>
      'फ़ाइल निगरानी: ${status}\nडिस्क पर फ़ाइलें बदलने पर स्वचालित रूप से पुनः तुलना करें';
  @override
  String get aiSettingsNotAvailable =>
      'एआई सेटिंग्स के लिए नेविगेशन उपलब्ध नहीं है';
}

// Path: directoryComparison
class _TranslationsDirectoryComparisonHi
    implements TranslationsDirectoryComparisonEn {
  _TranslationsDirectoryComparisonHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'डायरेक्टरी तुलना';
  @override
  String get sourceDirectory => 'स्रोत डायरेक्टरी';
  @override
  String get targetDirectory => 'लक्ष्य डायरेक्टरी';
  @override
  String get sourceSubtitle => 'मूल/संदर्भ फ़ाइलें';
  @override
  String get targetSubtitle => 'अनुवाद/तुलना फ़ाइलें';
  @override
  String get selectBothDirectories =>
      'कृपया स्रोत और लक्ष्य दोनों डायरेक्टरी चुनें।';
  @override
  String get selectSourceFolder => 'स्रोत फ़ोल्डर चुनें';
  @override
  String get selectTargetFolder => 'लक्ष्य फ़ोल्डर चुनें';
  @override
  String get dropFolderHere => 'फ़ोल्डर यहाँ छोड़ें या ब्राउज़ करें...';
  @override
  String get folderPath => 'फ़ोल्डर पथ';
  @override
  String get readyToCompare => 'डायरेक्टरी की तुलना करने के लिए तैयार';
  @override
  String get readyToCompareDesc =>
      'ऊपर फ़ोल्डर छोड़ें या तुलना के लिए डायरेक्टरी का चयन करने के लिए\nब्राउज़ बटन का उपयोग करें।';
  @override
  String get nestedFolders => 'नेस्टेड फ़ोल्डर';
  @override
  String get nestedFoldersTooltip =>
      'सभी नेस्टेड डायरेक्टरी की पुनरावर्ती तुलना करता है';
  @override
  String get fileMatching => 'फ़ाइल मिलान';
  @override
  String get fileMatchingTooltip =>
      'नाम से फ़ाइलों को स्वचालित रूप से जोड़ता है';
  @override
  String get bulkExport => 'थोक निर्यात';
  @override
  String get bulkExportTooltip => 'सभी तुलना परिणाम एक साथ निर्यात करें';
  @override
  String get notDirectoryComparison => 'यह एक डायरेक्टरी तुलना नहीं है।';
  @override
  String get directoriesNotExist => 'एक या दोनों डायरेक्टरी अब मौजूद नहीं हैं।';
  @override
  String get errorOccurred => 'त्रुटि हुई';
  @override
  String get noFilesFound => 'चयनित डायरेक्टरी में कोई फ़ाइल नहीं मिली।';
  @override
  String get unmatchedSourceFiles => 'बेमेल स्रोत फ़ाइलें';
  @override
  String get unmatchedTargetFiles => 'बेमेल लक्ष्य फ़ाइलें';
  @override
  String filePairs({required Object count}) => '${count} फ़ाइल जोड़े';
  @override
  String pairedFiles({required Object count}) => 'युग्मित फ़ाइलें (${count})';
  @override
  String get view => 'दृश्य';
  @override
  String get failed => 'विफल';
  @override
  String get pair => 'जोड़ा बनाएं...';
  @override
  String pairDialogTitle({required Object name}) =>
      '"${name}" के साथ जोड़ा बनाएं:';
  @override
  String get discoverFiles => 'फ़ाइलें खोजें';
  @override
  String get compareAll => 'सभी तुलना करें';
  @override
  String get exportAll => 'सभी निर्यात करें';
  @override
  String get comparisonStarted => 'तुलना शुरू हुई...';
  @override
  String get discoveringFiles => 'फ़ाइलें खोजी जा रही हैं...';
  @override
  String get noResultsToExport =>
      'निर्यात करने के लिए कोई तुलना परिणाम नहीं। पहले "सभी तुलना करें" चलाएं।';
  @override
  String get selectExportFolder => 'निर्यात फ़ोल्डर चुनें';
  @override
  String createExportFolderError({required Object error}) =>
      'निर्यात फ़ोल्डर बनाने में विफल: ${error}';
  @override
  String get exportingResults => 'परिणाम निर्यात किए जा रहे हैं';
  @override
  String processingFile({required Object file}) => 'प्रोसेसिंग: ${file}';
  @override
  String exportProgress({required Object total, required Object current}) =>
      '${total} में से ${current} फ़ाइलें निर्यात की गईं';
  @override
  String get exportComplete => 'निर्यात पूर्ण';
  @override
  String exportSuccessMessage({required Object count}) =>
      'सफलतापूर्वक ${count} तुलना फ़ाइलें और सारांश निर्यात किया गया।';
  @override
  String exportFailed({required Object error}) => 'निर्यात विफल: ${error}';
  @override
  String get close => 'बंद करें';
}

// Path: gitComparison
class _TranslationsGitComparisonHi implements TranslationsGitComparisonEn {
  _TranslationsGitComparisonHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.';
  @override
  String get title => 'रिपॉजिटरी तुलना';
  @override
  String get repoSelector => 'रिपॉजिटरी बनाएं / खोलें';
  @override
  String get noRepoSelected => 'कोई रिपॉजिटरी चयनित नहीं';
  @override
  String get open => 'खोलें';
  @override
  String get refreshCommits => 'Commits ताज़ा करें';
  @override
  String get noCommits =>
      'कोई commit नहीं मिला या लोड नहीं हुआ। Commits लोड करने के लिए एक branch चुनें।';
  @override
  String get baseCommit => 'आधार Commit (पुराना)';
  @override
  String get targetCommit => 'लक्ष्य Commit (नया)';
  @override
  String get filterCommitsByBranch => 'Branch द्वारा Commits फ़िल्टर करें';
  @override
  String get conflictDetection => 'Conflict का पता लगाना';
  @override
  String get conflictDetectionTooltip =>
      'Merge conflicts का पता लगाएं और हल करें';
  @override
  String get actions => 'क्रियाएं:';
  @override
  String get checkout => 'Checkout';
  @override
  String get merge => 'Merge';
  @override
  String get pull => 'Pull';
  @override
  String get checkoutBranch => 'Checkout Branch';
  @override
  String get mergeBranch => 'Merge Branch को वर्तमान में';
  @override
  String mergeConfirmation({required Object branch}) =>
      '${branch} को Merge करें?';
  @override
  String get mergeWarning =>
      'यह आपके वर्तमान कार्यकारी branch में परिवर्तनों को merge करेगा। Conflicts हो सकते हैं।';
  @override
  String get selectExportFolder => 'निर्यात फ़ोल्डर चुनें';
  @override
  String createExportFolderError({required Object error}) =>
      'निर्यात फ़ोल्डर बनाने में विफल: ${error}';
  @override
  String get exportingFiles => 'फ़ाइलें निर्यात की जा रही हैं';
  @override
  String processingFile({required Object file}) => 'प्रोसेसिंग: ${file}';
  @override
  String exportProgress({required Object total, required Object current}) =>
      '${total} में से ${current} फ़ाइलें निर्यात की गईं';
  @override
  String get exportComplete => 'निर्यात पूर्ण';
  @override
  String exportSuccessMessage({required Object count}) =>
      'सफलतापूर्वक ${count} फ़ाइलें पूर्ण सामग्री के साथ निर्यात की गईं।';
  @override
  String get exportDetail =>
      'प्रत्येक फ़ाइल का diff "files" सबफ़ोल्डर में सहेजा गया है।';
  @override
  String get diffViewer => 'Diff व्यूअर';
  @override
  String get base => 'BASE';
  @override
  String get target => 'TARGET';
  @override
  String get noLines => 'प्रदर्शित करने के लिए कोई लाइनें नहीं';
  @override
  String get searchFiles => 'फ़ाइलें खोजें...';
  @override
  String noFilesMatch({required Object query}) =>
      '"${query}" से कोई फ़ाइल मेल नहीं खाती';
  @override
  String filesCount({required Object count}) => '${count} फ़ाइलें';
  @override
  String get selectBaseFile => 'आधार फ़ाइल चुनें';
  @override
  String get selectTargetFile => 'लक्ष्य फ़ाइल चुनें';
  @override
  String get comparisonResults => 'तुलना परिणाम';
  @override
  String get noChanges => 'चयनित refs के बीच कोई बदलाव नहीं मिला।';
  @override
  String get linesAdded => 'लाइनें जोड़ी गईं';
  @override
  String get linesRemoved => 'लाइनें हटाई गईं';
  @override
  String get commit => 'Commit';
  @override
  String get branch => 'Branch';
  @override
  String get noRepositorySelected => 'कोई रिपॉजिटरी चयनित नहीं';
  @override
  String get notGitComparison => 'यह Git तुलना नहीं है';
  @override
  String get repositoryNotExist => 'रिपॉजिटरी मौजूद नहीं है';
  @override
  String get mainBranch => 'main';
  @override
  String get masterBranch => 'master';
  @override
  String get backToControls => 'तुलना नियंत्रण पर वापस';
}

// Path: advancedComparison
class _TranslationsAdvancedComparisonHi
    implements TranslationsAdvancedComparisonEn {
  _TranslationsAdvancedComparisonHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get placeholder => 'उन्नत तुलना दृश्य - प्लेसहोल्डर';
}

// Path: advancedDiff
class _TranslationsAdvancedDiffHi implements TranslationsAdvancedDiffEn {
  _TranslationsAdvancedDiffHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get saveAllChanges => 'सभी परिवर्तनों को सहेजें?';
  @override
  String saveConfirmation({required Object count}) =>
      'यह लक्ष्य फ़ाइल में सभी ${count} संशोधित प्रविष्टियों को सहेजेगा। यह क्रिया पूर्ववत नहीं की जा सकती।';
  @override
  String get changesSaved => 'परिवर्तन सफलतापूर्वक सहेजे गए।';
  @override
  String get csvExported => 'CSV निर्यात किया गया';
  @override
  String get unsavedChanges => 'बिना सहेजे परिवर्तन';
  @override
  String get unsavedChangesWarning =>
      'आपके पास बिना सहेजे परिवर्तन हैं। क्या आप वाकई उन्हें त्यागना चाहते हैं?';
  @override
  String get discardChanges => 'परिवर्तनों को त्यागें';
  @override
  String get goBack => 'वापस जाओ';
  @override
  String get breadcrumbs => 'होम > संपादक';
  @override
  String unsaved({required Object count}) => '${count} बिना सहेजे';
  @override
  String reviewed({required Object count}) => '${count} समीक्षित';
  @override
  String saveAll({required Object count}) => 'सभी सहेजें (${count})';
  @override
  String get allSaved => 'सभी सहेजे गए';
  @override
  String get saveAllTooltip => 'सभी परिवर्तनों को सहेजें (Ctrl+S)';
  @override
  String get exportTooltip => 'डेटा निर्यात करें (Ctrl+E)';
  @override
  late final _TranslationsAdvancedDiffAiSuggestionHi aiSuggestion =
      _TranslationsAdvancedDiffAiSuggestionHi._(_root);
  @override
  late final _TranslationsAdvancedDiffDetailEditHi detailEdit =
      _TranslationsAdvancedDiffDetailEditHi._(_root);
  @override
  late final _TranslationsAdvancedDiffTableHi table =
      _TranslationsAdvancedDiffTableHi._(_root);
  @override
  late final _TranslationsAdvancedDiffDiffRowHi diffRow =
      _TranslationsAdvancedDiffDiffRowHi._(_root);
  @override
  late final _TranslationsAdvancedDiffStatusHi status =
      _TranslationsAdvancedDiffStatusHi._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarHi sidebar =
      _TranslationsAdvancedDiffSidebarHi._(_root);
}

// Path: issueDetails
class _TranslationsIssueDetailsHi implements TranslationsIssueDetailsEn {
  _TranslationsIssueDetailsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'समस्या विवरण';
  @override
  String showingIssues({required Object total, required Object count}) =>
      '${total} में से ${count} समस्याएं दिखा रहा है';
  @override
  String get searchPlaceholder => 'कुंजी, पाठ या त्रुटि द्वारा खोजें...';
  @override
  String get noDetails => 'कोई विवरण उपलब्ध नहीं है।';
  @override
  String get noMatches => 'कोई मेल नहीं मिला।';
  @override
  String get showMore => 'और दिखाएं';
  @override
  String copyItems({required Object count}) => '${count} आइटम कॉपी करें';
  @override
  String get close => 'बंद करें';
  @override
  String get copied => 'क्लैपबोर्ड पर कॉपी किया गया';
  @override
  String copiedCount({required Object count}) => '${count} आइटम कॉपी किए गए';
  @override
  late final _TranslationsIssueDetailsDuplicateValueHi duplicateValue =
      _TranslationsIssueDetailsDuplicateValueHi._(_root);
  @override
  late final _TranslationsIssueDetailsLengthOutlierHi lengthOutlier =
      _TranslationsIssueDetailsLengthOutlierHi._(_root);
  @override
  late final _TranslationsIssueDetailsStandardHi standard =
      _TranslationsIssueDetailsStandardHi._(_root);
  @override
  String get review => 'समीक्षा';
  @override
  late final _TranslationsIssueDetailsTypesHi types =
      _TranslationsIssueDetailsTypesHi._(_root);
  @override
  late final _TranslationsIssueDetailsNotesHi notes =
      _TranslationsIssueDetailsNotesHi._(_root);
  @override
  late final _TranslationsIssueDetailsFallbacksHi fallbacks =
      _TranslationsIssueDetailsFallbacksHi._(_root);
}

// Path: importReview
class _TranslationsImportReviewHi implements TranslationsImportReviewEn {
  _TranslationsImportReviewHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'प्रोजेक्ट आयात समीक्षा';
  @override
  String get projectName => 'प्रोजेक्ट का नाम';
  @override
  String get created => 'बनाया गया';
  @override
  String get historyItems => 'इतिहास आइटम';
  @override
  String get customSettingsTitle => 'कस्टम सेटिंग्स का पता चला';
  @override
  String get customSettingsWarning =>
      'इस प्रोजेक्ट में कस्टम सेटिंग्स हैं जो इस प्रोजेक्ट के खुले रहने के दौरान आपके डिफॉल्ट को ओवरराइड कर देंगी।';
  @override
  String get standardSettings =>
      'यह प्रोजेक्ट मानक वैश्विक सेटिंग्स का उपयोग करता है।';
  @override
  String get cancelImport => 'आयात रद्द करें';
  @override
  String get trustOpen => 'विश्वास करें और प्रोजेक्ट खोलें';
}

// Path: historyView
class _TranslationsHistoryViewHi implements TranslationsHistoryViewEn {
  _TranslationsHistoryViewHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'तुलना इतिहास';
  @override
  String get clearAll => 'सभी इतिहास साफ़ करें';
  @override
  String get searchPlaceholder => 'फ़ाइल नाम से खोजें...';
  @override
  String get sortBy => 'क्रमबद्ध करें';
  @override
  String get sortDate => 'तारीख';
  @override
  String get sortSource => 'स्रोत फ़ाइल';
  @override
  String get sortTarget => 'लक्ष्य फ़ाइल';
  @override
  String get showCurrentProject => 'दिखा रहा है: वर्तमान प्रोजेक्ट';
  @override
  String get showAllHistory => 'दिखा रहा है: सभी इतिहास';
  @override
  String get groupByFolder => 'फ़ोल्डर द्वारा समूह';
  @override
  String get disableGrouping => 'फ़ोल्डर समूहीकरण अक्षम करें';
  @override
  String get filterAll => 'सभी';
  @override
  String get filterFiles => 'फ़ाइलें';
  @override
  String get filterDirectories => 'निर्देशिकाएँ';
  @override
  String get filterGit => 'Git';
  @override
  String get noHistory => 'अभी तक कोई तुलना इतिहास नहीं';
  @override
  String get historyDescription => 'आपकी फ़ाइल तुलना यहाँ दिखाई देगी';
  @override
  String get noResults => 'कोई परिणाम नहीं मिला';
  @override
  String get adjustSearch => 'अपनी खोज समायोजित करने का प्रयास करें';
  @override
  String get clearConfirmationTitle => 'सभी इतिहास साफ़ करें?';
  @override
  String get clearConfirmationContent =>
      'यह सभी तुलना इतिहास को स्थायी रूप से हटा देगा। यह क्रिया पूर्ववत नहीं की जा सकती।';
  @override
  String get clearAction => 'सभी साफ़ करें';
  @override
  String get deletedMessage => 'इतिहास आइटम हटाया गया';
  @override
  String get undo => 'पूर्ववत करें';
  @override
  String get viewDetails => 'विवरण देखें';
  @override
  String get delete => 'हटाएं';
  @override
  String get openLocation => 'फ़ाइल स्थान खोलें';
  @override
  String get bilingual => 'द्विभाषी';
  @override
  String get filePair => 'फ़ाइल जोड़ी';
  @override
  String get directory => 'निर्देशिका';
  @override
  String get git => 'Git';
  @override
  String get repo => 'Repo';
  @override
  String get sourceDir => 'स्रोत निर्देशिका';
  @override
  String get targetDir => 'लक्ष्य निर्देशिका';
  @override
  String get source => 'स्रोत';
  @override
  String get target => 'लक्ष्य';
  @override
  String get noChanges => 'कोई परिवर्तन नहीं मिला';
  @override
  String get added => 'जोड़ा गया';
  @override
  String get removed => 'हटाया गया';
  @override
  String get modified => 'संशोधित';
  @override
  String get same => 'समान';
  @override
  String get total => 'कुल';
  @override
  String get currentProject => 'वर्तमान प्रोजेक्ट';
  @override
  String get unassigned => 'अनसाइन किया गया';
  @override
  String get project => 'प्रोजेक्ट';
}

// Path: compare
class _TranslationsCompareHi implements TranslationsCompareEn {
  _TranslationsCompareHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'फ़ाइलों की तुलना करें';
  @override
  String get sourceFile => 'स्रोत फ़ाइल';
  @override
  String get targetFile => 'लक्ष्य फ़ाइल';
  @override
  String get sourceFolder => 'स्रोत फ़ोल्डर';
  @override
  String get targetFolder => 'लक्ष्य फ़ोल्डर';
  @override
  String get dropFilesHint =>
      'तुलना के लिए स्थानीयकरण फ़ाइलें यहाँ छोड़ें या फ़ाइलों का चयन करने के लिए ब्राउज़ बटन का उपयोग करें।';
  @override
  String get selectSourceFile => 'स्रोत फ़ाइल चुनें';
  @override
  String get selectTargetFile => 'लक्ष्य फ़ाइल चुनें';
  @override
  String get startComparison => 'तुलना शुरू करें';
  @override
  String get comparing => 'तुलना हो रही है...';
  @override
  String get comparisonComplete => 'तुलना पूर्ण';
  @override
  String get noChanges => 'कोई परिवर्तन नहीं मिला';
  @override
  String get filesIdentical => 'फ़ाइलें समान हैं';
  @override
  String changesFound({required Object count}) => '${count} परिवर्तन मिले';
  @override
  late final _TranslationsCompareTabsHi tabs =
      _TranslationsCompareTabsHi._(_root);
  @override
  late final _TranslationsCompareFileTypesHi fileTypes =
      _TranslationsCompareFileTypesHi._(_root);
}

// Path: history
class _TranslationsHistoryHi implements TranslationsHistoryEn {
  _TranslationsHistoryHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'इतिहास';
  @override
  String get recentComparisons => 'हालिया तुलनाएं';
  @override
  String get noHistory => 'अभी तक कोई तुलना इतिहास नहीं';
  @override
  String get noHistoryDescription => 'आपका तुलना इतिहास यहाँ दिखाई देगा';
  @override
  String get clearHistory => 'इतिहास साफ़ करें';
  @override
  String get clearHistoryConfirm =>
      'क्या आप वाकई सभी इतिहास साफ़ करना चाहते हैं?';
  @override
  String get deleteEntry => 'प्रविष्टि हटाएं';
  @override
  String get openComparison => 'तुलना खोलें';
  @override
  late final _TranslationsHistoryTimeAgoHi timeAgo =
      _TranslationsHistoryTimeAgoHi._(_root);
}

// Path: projects
class _TranslationsProjectsHi implements TranslationsProjectsEn {
  _TranslationsProjectsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'प्रोजेक्ट्स';
  @override
  String get createProject => 'प्रोजेक्ट बनाएं';
  @override
  String get importProject => 'प्रोजेक्ट आयात करें';
  @override
  String get noProjects => 'अभी तक कोई प्रोजेक्ट नहीं';
  @override
  String get noProjectsDescription =>
      'अपनी स्थानीयकरण फ़ाइलों को व्यवस्थित करने के लिए एक प्रोजेक्ट बनाएं';
  @override
  String get projectName => 'प्रोजेक्ट का नाम';
  @override
  String get projectPath => 'प्रोजेक्ट पथ';
  @override
  String get lastOpened => 'अंतिम बार खोला गया';
  @override
  String get openProject => 'प्रोजेक्ट खोलें';
  @override
  String get closeProject => 'प्रोजेक्ट बंद करें';
  @override
  String get deleteProject => 'प्रोजेक्ट हटाएं';
  @override
  String get deleteProjectConfirm =>
      'क्या आप वाकई इस प्रोजेक्ट को हटाना चाहते हैं?';
  @override
  String get exportProject => 'प्रोजेक्ट निर्यात करें';
  @override
  String get exportDescription =>
      'स्रोत फ़ाइलें, कॉन्फ़िगरेशन और इतिहास युक्त एक पोर्टेबल ज़िप फ़ाइल बनाएं।';
  @override
  String get exporting => 'प्रोजेक्ट निर्यात हो रहा है...';
  @override
  String get exportSuccess => 'प्रोजेक्ट निर्यात किया गया';
  @override
  String exportError({required Object error}) => 'निर्यात विफल: ${error}';
  @override
  String get createNewProject => 'नया प्रोजेक्ट बनाएं';
  @override
  String get openExistingProject => 'मौजूदा प्रोजेक्ट खोलें';
  @override
  String get importProjectZip => 'प्रोजेक्ट ज़िप आयात करें';
  @override
  String get projectResources => 'प्रोजेक्ट संसाधन';
  @override
  String get recentProjects => 'हालिया प्रोजेक्ट्स';
  @override
  String get noRecentProjects => 'कोई हालिया प्रोजेक्ट नहीं';
  @override
  String get selectProjectZip => 'प्रोजेक्ट ज़िप चुनें';
  @override
  String get selectDestination => 'आयात के लिए गंतव्य फ़ोल्डर चुनें';
  @override
  String get importing => 'प्रोजेक्ट आयात हो रहा है...';
  @override
  String get importSuccess => 'प्रोजेक्ट सफलतापूर्वक आयात किया गया';
  @override
  String importFailed({required Object error}) => 'आयात विफल: ${error}';
  @override
  String get importingFiles => 'फ़ाइलें आयात हो रही हैं...';
  @override
  String get noSupportedFiles => 'कोई समर्थित फ़ाइल नहीं छोड़ी गई।';
  @override
  late final _TranslationsProjectsStatsHi stats =
      _TranslationsProjectsStatsHi._(_root);
  @override
  String get openProjectFirst =>
      'संसाधनों का प्रबंधन करने के लिए पहले एक प्रोजेक्ट खोलें।';
  @override
  String get removeFromRecent => 'हालिया से हटाएं';
  @override
  late final _TranslationsProjectsSelectionHi selection =
      _TranslationsProjectsSelectionHi._(_root);
  @override
  late final _TranslationsProjectsCreateDialogHi createDialog =
      _TranslationsProjectsCreateDialogHi._(_root);
  @override
  late final _TranslationsProjectsIndicatorHi indicator =
      _TranslationsProjectsIndicatorHi._(_root);
  @override
  late final _TranslationsProjectsGlossaryHi glossary =
      _TranslationsProjectsGlossaryHi._(_root);
  @override
  late final _TranslationsProjectsConflictsHi conflicts =
      _TranslationsProjectsConflictsHi._(_root);
  @override
  late final _TranslationsProjectsTmHi tm = _TranslationsProjectsTmHi._(_root);
}

// Path: diff
class _TranslationsDiffHi implements TranslationsDiffEn {
  _TranslationsDiffHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'जोड़ा गया';
  @override
  String get removed => 'हटाया गया';
  @override
  String get modified => 'संशोधित';
  @override
  String get unchanged => 'अपरिवर्तित';
  @override
  String get missing => 'लापता';
  @override
  String get extra => 'अतिरिक्त';
  @override
  String get sourceValue => 'स्रोत मान';
  @override
  String get targetValue => 'लक्ष्य मान';
  @override
  String get key => 'कुंजी';
  @override
  String get status => 'स्थिति';
  @override
  String get actions => 'क्रियाएं';
  @override
  String get copyToTarget => 'लक्ष्य में कॉपी करें';
  @override
  String get acceptChange => 'परिवर्तन स्वीकार करें';
  @override
  String get rejectChange => 'परिवर्तन अस्वीकार करें';
  @override
  String get viewDetails => 'विवरण देखें';
}

// Path: git
class _TranslationsGitHi implements TranslationsGitEn {
  _TranslationsGitHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.';
  @override
  String get title => 'Git तुलना';
  @override
  String get selectRepository => 'रिपॉजिटरी चुनें';
  @override
  String get selectBranch => 'Branch चुनें';
  @override
  String get selectCommit => 'Commit चुनें';
  @override
  String get compareBranches => 'Branches की तुलना करें';
  @override
  String get compareCommits => 'Commits की तुलना करें';
  @override
  String get baseBranch => 'आधार Branch';
  @override
  String get compareBranch => 'तुलना Branch';
  @override
  String get noRepositories => 'कोई Git रिपॉजिटरी नहीं मिली';
  @override
  String get noRepositoriesDescription => 'एक Git रिपॉजिटरी वाला फ़ोल्डर खोलें';
  @override
  String filesChanged({required Object count}) => '${count} फ़ाइलें बदलीं';
  @override
  String additions({required Object count}) => '${count} जोड़';
  @override
  String deletions({required Object count}) => '${count} हटाना';
  @override
  late final _TranslationsGitConflictsHi conflicts =
      _TranslationsGitConflictsHi._(_root);
}

// Path: quality
class _TranslationsQualityHi implements TranslationsQualityEn {
  _TranslationsQualityHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.';
  @override
  String get title => 'गुणवत्ता डैशबोर्ड';
  @override
  String get overallScore => 'समग्र स्कोर';
  @override
  String get issues => 'समस्याएं';
  @override
  String get warnings => 'चेतावनियाँ';
  @override
  String get suggestions => 'सुझाव';
  @override
  String get placeholderMismatch => 'प्लेसहोल्डर बेमेल';
  @override
  String get placeholderMismatchDescription =>
      '{name} जैसे प्लेसहोल्डर स्रोत और लक्ष्य के बीच मेल नहीं खाते';
  @override
  String get lengthOutlier => 'लंबाई आउटलियर';
  @override
  String get lengthOutlierDescription =>
      'अनुवाद की लंबाई स्रोत से काफी भिन्न है';
  @override
  String get duplicateValue => 'दोहराया गया मान';
  @override
  String get duplicateValueDescription =>
      'कई कुंजियों के लिए समान अनुवाद का उपयोग किया गया';
  @override
  String get missingTranslation => 'लापता अनुवाद';
  @override
  String get missingTranslationDescription => 'इस कुंजी के लिए अनुवाद गायब है';
  @override
  String get loading => 'डैशबोर्ड लोड हो रहा है...';
  @override
  String get errorLoading =>
      'हम आपका इतिहास लोड नहीं कर सके। पुनः प्रयास करें।';
  @override
  String get emptyState => 'अपना डैशबोर्ड देखने के लिए तुलना चलाएं।';
  @override
  String get refresh => 'ताज़ा करें';
  @override
  String get buildingInsights => 'अंतर्दृष्टि बना रहा है...';
  @override
  String get crunchingNumbers => 'संख्याओं को क्रंच कर रहा है...';
  @override
  String get errorBuilding => 'हम डैशबोर्ड नहीं बना सके। पुनः प्रयास करें।';
  @override
  String get noUsableData => 'अभी तक कोई उपयोगी डेटा नहीं मिला।';
  @override
  String get languages => 'भाषाएँ';
  @override
  String get averageCoverage => 'औसत कवरेज';
  @override
  String get potentialIssues => 'संभावित समस्याएं';
  @override
  String get translationCoverage => 'अनुवाद कवरेज';
  @override
  String entriesTranslated(
          {required Object total, required Object translated}) =>
      '${total} में से ${translated} प्रविष्टियाँ अनुवादित';
  @override
  String get wordsAddedOverTime => 'समय के साथ जोड़े गए शब्द';
  @override
  String get completionVsScope => 'पूर्णता बनाम स्कोप';
  @override
  String get scopeVsProgress => 'स्कोप बनाम प्रगति';
  @override
  String get coveragePercent => 'कवरेज %';
  @override
  String get wordsAdded => 'जोड़े गए शब्द';
  @override
  String get words => 'शब्द';
  @override
  String get coverage => 'कवरेज';
  @override
  String get scope => 'स्कोप';
  @override
  String get latest => 'नवीनतम';
  @override
  String get added => 'जोड़ा गया';
  @override
  String get change => 'परिवर्तन';
  @override
  String get totalScope => 'कुल स्कोप';
  @override
  String wordsCount({required Object count}) => '${count} शब्द';
  @override
  String get scopeGrowth => 'स्कोप वृद्धि';
  @override
  String get range => 'रेंज';
  @override
  String get aiUsage => 'AI और अनुवाद उपयोग';
  @override
  String lastUsed({required Object date}) => 'अंतिम उपयोग ${date}';
  @override
  String get noIssuesFound => 'नवीनतम तुलना में कोई समस्या नहीं मिली।';
  @override
  String get placeholderMismatches => 'प्लेसहोल्डर बेमेल';
  @override
  String get placeholderMismatchesDesc => '{name} जैसे मार्कर मेल नहीं खाते।';
  @override
  String get lengthOutliers => 'बहुत छोटे या लंबे अनुवाद';
  @override
  String get lengthOutliersDesc => 'स्रोत की तुलना में लंबाई असामान्य लगती है।';
  @override
  String get duplicateValues => 'दोहराए गए मान';
  @override
  String get duplicateValuesDesc => 'समान अनुवाद कई बार उपयोग किया जाता है।';
  @override
  String get placeholderDialogTitle => 'प्लेसहोल्डर बेमेल';
  @override
  String get placeholderDialogDesc =>
      'इन अनुवादों में स्रोत से अलग प्लेसहोल्डर ({name}) हैं।';
  @override
  String get lengthDialogTitle => 'लंबाई आउटलियर';
  @override
  String get lengthDialogDesc =>
      'ये अनुवाद स्रोत की तुलना में काफी छोटे या लंबे हैं।';
  @override
  String get duplicateDialogTitle => 'दोहराए गए मान';
  @override
  String get duplicateDialogDesc => 'ये अनुवाद कई बार दिखाई देते हैं।';
  @override
  String duplicateSample({required Object value}) => 'डुप्लिकेट: "${value}"';
  @override
  String get exportError => 'रिपोर्ट नहीं बना सका। कृपया पुनः प्रयास करें।';
  @override
  String get noDataToExport => 'निर्यात करने के लिए कोई डेटा नहीं';
  @override
  String get exportFailed => 'निर्यात विफल';
  @override
  String get exportDialogTitle => 'गुणवत्ता रिपोर्ट निर्यात करें';
  @override
  String get reportSaved => 'रिपोर्ट सहेजी गई';
  @override
  String get export => 'निर्यात';
  @override
  String get requests => 'अनुरोध';
  @override
  String get tokens => 'टोकन';
  @override
  String get characters => 'अक्षर';
  @override
  String get estCost => 'अनुमानित लागत';
  @override
  String get prompt => 'प्रॉम्प्ट';
  @override
  String get completion => 'पूर्णता';
  @override
  String get showingCurrentProject => 'दिखा रहा है: वर्तमान प्रोजेक्ट';
  @override
  String get showingAllHistory => 'दिखा रहा है: सभी इतिहास';
  @override
  String get filesSkipped => 'कुछ फ़ाइलें छोड़ दी गईं क्योंकि वे नहीं मिलीं।';
  @override
  String charCount({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        n,
        one: '1 अक्षर',
        other: '${count} अक्षर',
      );
  @override
  String lengthDiff(
          {required Object target,
          required Object percent,
          required Object source}) =>
      'लक्ष्य ${target} है (${percent}%) बनाम स्रोत ${source}';
}

// Path: errors
class _TranslationsErrorsHi implements TranslationsErrorsEn {
  _TranslationsErrorsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get genericError => 'एक त्रुटि हुई';
  @override
  String get fileNotFound => 'फ़ाइल नहीं मिली';
  @override
  String get invalidFormat => 'अमान्य फ़ाइल प्रारूप';
  @override
  String get parseError => 'फ़ाइल पार्स करने में विफल';
  @override
  String get networkError => 'नेटवर्क त्रुटि। कृपया अपना कनेक्शन जांचें।';
  @override
  String get permissionDenied => 'अनुमति अस्वीकृत';
  @override
  String get unknownError => 'एक अज्ञात त्रुटि हुई';
}

// Path: wizards
class _TranslationsWizardsHi implements TranslationsWizardsEn {
  _TranslationsWizardsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsWizardsFirstRunHi firstRun =
      _TranslationsWizardsFirstRunHi._(_root);
}

// Path: dialogs
class _TranslationsDialogsHi implements TranslationsDialogsEn {
  _TranslationsDialogsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDialogsAddIgnorePatternHi addIgnorePattern =
      _TranslationsDialogsAddIgnorePatternHi._(_root);
  @override
  late final _TranslationsDialogsDiffViewerHi diffViewer =
      _TranslationsDialogsDiffViewerHi._(_root);
  @override
  String get confirm => 'पुष्टि करें';
  @override
  String get cancel => 'रद्द करें';
  @override
  String get ok => 'ठीक है';
  @override
  String get yes => 'हाँ';
  @override
  String get no => 'नहीं';
  @override
  String get save => 'सहेजें';
  @override
  String get delete => 'हटाएं';
  @override
  String get close => 'बंद करें';
  @override
  String get error => 'त्रुटि';
  @override
  String get success => 'सफलता';
  @override
  String get warning => 'चेतावनी';
  @override
  String get info => 'जानकारी';
  @override
  String get unsavedChanges => 'बिना सहेजे परिवर्तन';
  @override
  String get unsavedContent =>
      'आपके पास बिना सहेजे परिवर्तन हैं। क्या आप उन्हें सहेजना चाहते हैं?';
  @override
  String get saveChanges => 'परिवर्तन सहेजें?';
  @override
  String get discardChanges => 'परिवर्तनों को त्यागें?';
  @override
  String get deleteConfirm =>
      'क्या आप वाकई इसे हटाना चाहते हैं? यह क्रिया पूर्ववत नहीं की जा सकती।';
  @override
  String get confirmation => 'पुष्टि आवश्यक';
}

// Path: grid
class _TranslationsGridHi implements TranslationsGridEn {
  _TranslationsGridHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGridColumnsHi columns =
      _TranslationsGridColumnsHi._(_root);
}

// Path: tutorial
class _TranslationsTutorialHi implements TranslationsTutorialEn {
  _TranslationsTutorialHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'ट्यूटोरियल छोड़ें';
  @override
  String get finishMessage =>
      'आप पूरी तरह तैयार हैं! समाप्त करने के लिए कहीं भी टैप करें।';
  @override
  String get next => 'अगला';
  @override
  String get loadSampleData => 'नमूना डेटा लोड करें';
  @override
  String get browseSourceFile => 'स्रोत फ़ाइल ब्राउज़ करें';
  @override
  String get browseTargetFile => 'लक्ष्य फ़ाइल ब्राउज़ करें';
  @override
  String get compareFiles => 'फ़ाइलों की तुलना करें';
  @override
  String get hintPhase2 => 'अगला: फ़िल्टर, खोज, उन्नत दृश्य, और निर्यात।';
  @override
  late final _TranslationsTutorialStepsHi steps =
      _TranslationsTutorialStepsHi._(_root);
}

// Path: friendlyErrors
class _TranslationsFriendlyErrorsHi implements TranslationsFriendlyErrorsEn {
  _TranslationsFriendlyErrorsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsFriendlyErrorsFileNotFoundHi fileNotFound =
      _TranslationsFriendlyErrorsFileNotFoundHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsAccessDeniedHi accessDenied =
      _TranslationsFriendlyErrorsAccessDeniedHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsIsDirectoryHi isDirectory =
      _TranslationsFriendlyErrorsIsDirectoryHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsFileAccessHi fileAccess =
      _TranslationsFriendlyErrorsFileAccessHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsUnsupportedFormatHi unsupportedFormat =
      _TranslationsFriendlyErrorsUnsupportedFormatHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsNetworkErrorHi networkError =
      _TranslationsFriendlyErrorsNetworkErrorHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsNotGitRepoHi notGitRepo =
      _TranslationsFriendlyErrorsNotGitRepoHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsMergeConflictHi mergeConflict =
      _TranslationsFriendlyErrorsMergeConflictHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitAuthFailedHi gitAuthFailed =
      _TranslationsFriendlyErrorsGitAuthFailedHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitOperationFailedHi
      gitOperationFailed =
      _TranslationsFriendlyErrorsGitOperationFailedHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidJsonHi invalidJson =
      _TranslationsFriendlyErrorsInvalidJsonHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsRateLimitReachedHi rateLimitReached =
      _TranslationsFriendlyErrorsRateLimitReachedHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidApiKeyHi invalidApiKey =
      _TranslationsFriendlyErrorsInvalidApiKeyHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsTranslationServiceErrorHi
      translationServiceError =
      _TranslationsFriendlyErrorsTranslationServiceErrorHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsOutOfMemoryHi outOfMemory =
      _TranslationsFriendlyErrorsOutOfMemoryHi._(_root);
  @override
  late final _TranslationsFriendlyErrorsGenericErrorHi genericError =
      _TranslationsFriendlyErrorsGenericErrorHi._(_root);
}

// Path: systemTray
class _TranslationsSystemTrayHi implements TranslationsSystemTrayEn {
  _TranslationsSystemTrayHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get showLocalizer => 'Localizer दिखाएं';
  @override
  String get exit => 'बाहर निकलें';
}

// Path: validation
class _TranslationsValidationHi implements TranslationsValidationEn {
  _TranslationsValidationHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get connected => 'जुड़ा हुआ।';
  @override
  String get connectionTimeout => 'कनेक्शन टाइमआउट। कृपया पुनः प्रयास करें।';
  @override
  String get couldNotConnect => 'कनेक्ट नहीं हो सका। कृपया पुनः प्रयास करें।';
  @override
  String get checkKeyAndTryAgain =>
      'कनेक्ट नहीं हो सका। कृपया कुंजी की जाँच करें और पुनः प्रयास करें।';
  @override
  String get tryAgainLater =>
      'अभी कनेक्ट नहीं हो सका। कृपया बाद में पुनः प्रयास करें।';
  @override
  String get serviceUnavailable =>
      'सेवा अभी अनुपलब्ध है। कृपया बाद में पुनः प्रयास करें।';
  @override
  String get enterKeyFirst => 'कृपया पहले एक कुंजी दर्ज करें।';
  @override
  String get checking => 'जाँच हो रही है...';
  @override
  String deeplUsage({required Object used, required Object limit}) =>
      'उपयोग: ${used} / ${limit} अक्षर।';
}

// Path: status
class _TranslationsStatusHi implements TranslationsStatusEn {
  _TranslationsStatusHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get startingComparison => 'तुलना शुरू हो रही है...';
  @override
  String get loadingFromHistory => 'इतिहास से फ़ाइलें लोड हो रही हैं...';
  @override
  String get comparisonComplete => 'तुलना पूर्ण';
  @override
  String get couldNotImportFiles =>
      'फ़ाइलों को आयात नहीं कर सका। कृपया पुनः प्रयास करें।';
  @override
  String get historyFilesNotFound =>
      'इतिहास से एक या दोनों फ़ाइलें मूल पथ पर नहीं मिलीं।';
}

// Path: aiServices
class _TranslationsAiServicesHi implements TranslationsAiServicesEn {
  _TranslationsAiServicesHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get geminiEmptyResponse => 'Gemini ने खाली प्रतिक्रिया दी';
  @override
  String get geminiStreamingEmpty => 'Gemini स्ट्रीमिंग ने खाली प्रतिक्रिया दी';
  @override
  String get geminiRephraseEmpty =>
      'Gemini ने रिफ्रेश के लिए खाली प्रतिक्रिया दी';
  @override
  String get openaiEmptyResponse => 'OpenAI ने खाली या विफल प्रतिक्रिया दी';
}

// Path: diffTable
class _TranslationsDiffTableHi implements TranslationsDiffTableEn {
  _TranslationsDiffTableHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDiffTableColumnsHi columns =
      _TranslationsDiffTableColumnsHi._(_root);
  @override
  String get empty => 'प्रदर्शित करने के लिए कोई प्रविष्टियाँ नहीं';
  @override
  late final _TranslationsDiffTablePaginationHi pagination =
      _TranslationsDiffTablePaginationHi._(_root);
  @override
  late final _TranslationsDiffTableMessagesHi messages =
      _TranslationsDiffTableMessagesHi._(_root);
  @override
  late final _TranslationsDiffTableEditDialogHi editDialog =
      _TranslationsDiffTableEditDialogHi._(_root);
}

// Path: onboarding
class _TranslationsOnboardingHi implements TranslationsOnboardingEn {
  _TranslationsOnboardingHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get gettingStarted => 'शुरू करना';
  @override
  String stepProgress({required Object total, required Object current}) =>
      '${total} में से ${current} कदम';
  @override
  String get skipTutorial => 'ट्यूटोरियल छोड़ें';
  @override
  String get loadSampleData => 'नमूना डेटा लोड करें';
  @override
  late final _TranslationsOnboardingStepsHi steps =
      _TranslationsOnboardingStepsHi._(_root);
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceHi
    implements TranslationsSettingsAppearanceEn {
  _TranslationsSettingsAppearanceHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'दिखावट';
  @override
  String get description => 'ऐप के रूप और अहसास को अनुकूलित करें';
  @override
  String get theme => 'थीम मोड';
  @override
  String get themeDescription => 'लाइट, डार्क या सिस्टम थीम के बीच चुनें';
  @override
  String get themeSystem => 'सिस्टम';
  @override
  String get themeLight => 'लाइट';
  @override
  String get themeDark => 'डार्क';
  @override
  String get themeAmoled => 'एमोलेड';
  @override
  String get accentColor => 'एक्सेंट रंग';
  @override
  String get accentColorDescription => 'अपना पसंदीदा एक्सेंट रंग चुनें';
  @override
  String get useMicaEffect => 'माइका प्रभाव का उपयोग करें';
  @override
  String get micaDescription =>
      'आधुनिक रूप के लिए Windows 11 माइका पारदर्शिता सक्षम करें';
  @override
  String get diffFontSize => 'तुलना फ़ॉन्ट आकार';
  @override
  String get diffFontSizeDescription =>
      'तुलना दृश्य के फ़ॉन्ट आकार को समायोजित करें';
  @override
  String get diffFontFamily => 'तुलना फ़ॉन्ट परिवार';
  @override
  String get diffFontFamilyDescription => 'तुलना दृश्य के लिए फ़ॉन्ट';
  @override
  String get systemDefault => 'सिस्टम डिफ़ॉल्ट';
  @override
  String get pickAccentColor => 'एक्सेंट रंग चुनें';
  @override
  String get diffColors => 'तुलना रंग';
  @override
  String get presetsTitle => 'प्रीसेट';
  @override
  late final _TranslationsSettingsAppearancePresetsHi presets =
      _TranslationsSettingsAppearancePresetsHi._(_root);
  @override
  String get identical => 'समान';
  @override
  String pickColorFor({required Object label}) => '${label} के लिए रंग चुनें';
  @override
  String get livePreview => 'लाइव पूर्वावलोकन';
  @override
  late final _TranslationsSettingsAppearancePreviewHi preview =
      _TranslationsSettingsAppearancePreviewHi._(_root);
}

// Path: settings.general
class _TranslationsSettingsGeneralHi implements TranslationsSettingsGeneralEn {
  _TranslationsSettingsGeneralHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'सामान्य';
  @override
  String get description => 'सामान्य एप्लिकेशन सेटिंग्स';
  @override
  String get language => 'भाषा';
  @override
  String get languageDescription => 'अपनी पसंदीदा भाषा चुनें';
  @override
  String get startMinimized => 'ट्रे में छोटा करके शुरू करें';
  @override
  String get startMinimizedDescription =>
      'सिस्टम ट्रे में छोटा करके ऐप शुरू करें';
  @override
  String get rememberWindowPosition => 'विंडो स्थिति याद रखें';
  @override
  String get rememberWindowPositionDescription =>
      'स्टार्टअप पर विंडो आकार और स्थिति बहाल करें';
  @override
  String get openLastProject => 'स्टार्टअप पर पिछला प्रोजेक्ट खोलें';
  @override
  String get openLastProjectDescription =>
      'ऐप शुरू होने पर स्वचालित रूप से अंतिम उपयोग किया गया प्रोजेक्ट खोलें';
  @override
  String get application => 'एप्लिकेशन';
  @override
  String get defaultView => 'डिफ़ॉल्ट दृश्य';
  @override
  String get defaultViewDescription => 'स्टार्टअप पर दिखने वाला दृश्य';
  @override
  String get autoCheckUpdates => 'अपडेट ऑटो-चेक करें';
  @override
  String get autoCheckUpdatesDescription => 'स्टार्टअप पर अपडेट के लिए जाँचें';
  @override
  String get startupOptions => 'स्टार्टअप विकल्प';
  @override
  String get languageAuto => 'स्वतः-पहचान';
  @override
  String get viewBasic => 'फ़ाइल तुलना';
  @override
  String get viewHistory => 'इतिहास';
  @override
  String get viewDashboard => 'गुणवत्ता डैशबोर्ड';
  @override
  String get viewDirectory => 'डायरेक्टरी तुलना';
  @override
  String get viewLastUsed => 'अंतिम उपयोग किया गया दृश्य';
}

// Path: settings.scope
class _TranslationsSettingsScopeHi implements TranslationsSettingsScopeEn {
  _TranslationsSettingsScopeHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'सेटिंग्स स्कोप';
  @override
  String get global => 'वैश्विक डिफ़ॉल्ट';
  @override
  String get project => 'प्रोजेक्ट';
  @override
  String get reset => 'प्रोजेक्ट को वैश्विक डिफ़ॉल्ट पर रीसेट करें';
  @override
  String get resetConfirmation =>
      'यह इस प्रोजेक्ट के लिए सभी ओवरराइड को साफ़ कर देगा और वैश्विक डिफ़ॉल्ट पर वापस आ जाएगा। यह क्रिया पूर्ववत नहीं की जा सकती।';
  @override
  String get globalDescription =>
      'परिवर्तन सभी प्रोजेक्ट्स पर लागू होते हैं जब तक कि ओवरराइड न किया गया हो।';
  @override
  String projectDescription({required Object name}) =>
      'परिवर्तन केवल "${name}" पर लागू होते हैं। अन्य सेटिंग्स वैश्विक डिफ़ॉल्ट से विरासत में मिलती हैं।';
  @override
  String get createPrompt =>
      'विशिष्ट फ़ोल्डरों के लिए सेटिंग्स अनुकूलित करने के लिए एक प्रोजेक्ट बनाएं';
}

// Path: settings.searchKeywords
class _TranslationsSettingsSearchKeywordsHi
    implements TranslationsSettingsSearchKeywordsEn {
  _TranslationsSettingsSearchKeywordsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  List<String> get general => [
        'भाषा',
        'डिफ़ॉल्ट दृश्य',
        'हालिया फ़ाइलें गिनती',
        'पिछला प्रोजेक्ट खोलें',
        'बाहर निकलने से पहले पुष्टि करें',
        'सूचनाएं दिखाएं',
      ];
  @override
  List<String> get comparisonEngine => [
        'तुलना मोड',
        'समानता सीमा',
        'केस संवेदी',
        'व्हाइटस्पेस अनदेखा करें',
        'खाली लाइनें अनदेखा करें',
        'टिप्पणियाँ अनदेखा करें',
        'पैटर्न अनदेखा करें',
      ];
  @override
  List<String> get appearance => [
        'थीम',
        'थीम मोड',
        'एक्सेंट रंग',
        'तुलना फ़ॉन्ट आकार',
        'तुलना फ़ॉन्ट परिवार',
        'तुलना रंग',
        'जोड़ा गया रंग',
        'हटाया गया रंग',
        'संशोधित रंग',
        'समान रंग',
        'रंग प्रीसेट',
        'पूर्वावलोकन',
      ];
  @override
  List<String> get fileHandling => [
        'स्रोत प्रारूप',
        'लक्ष्य प्रारूप',
        'डिफ़ॉल्ट एन्कोडिंग',
        'हालिया प्रोजेक्ट गिनती',
        'अनुवाद मेमोरी',
        'मेमोरी आयात करें',
        'मेमोरी निर्यात करें',
        'मेमोरी साफ़ करें',
      ];
  @override
  List<String> get aiServices => [
        'OpenAI API कुंजी',
        'Anthropic API कुंजी',
        'Google AI API कुंजी',
        'AI मॉडल',
        'तापमान',
        'कस्टम प्रॉम्प्ट',
      ];
  @override
  List<String> get systemIntegrations => [
        'सिस्टम ट्रे',
        'छोटा करके शुरू करें',
        'फ़ाइल एसोसिएशन',
        'माइका प्रभाव',
        'वाइब्रेंसी',
        'विंडो सामग्री',
        'डॉक बैज',
        'अनुवादित नहीं गिनती',
      ];
  @override
  List<String> get projectResources => [
        'शब्दावली',
        'अनुवाद मेमोरी',
        'शब्दावली',
      ];
  @override
  List<String> get about => [
        'संस्करण',
        'अपडेट जाँचें',
        'ऑटो अपडेट',
        'चेंजलॉग',
        'लाइसेंस',
        'गोपनीयता नीति',
        'टेलीमेट्री',
        'क्रैश रिपोर्टिंग',
      ];
  @override
  List<String> get developer => [
        'प्रदर्शन ओवरले',
        'सिमेंटिक्स डिबगर',
        'मटेरियल ग्रिड',
        'रास्टर कैश',
        'ट्यूटोरियल पुनः आरंभ करें',
        'फ़ैक्टरी रीसेट',
      ];
}

// Path: settings.comparison
class _TranslationsSettingsComparisonHi
    implements TranslationsSettingsComparisonEn {
  _TranslationsSettingsComparisonHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'तुलना';
  @override
  String get description => 'तुलना व्यवहार को कॉन्फ़िगर करें';
  @override
  String get caseSensitive => 'केस संवेदी';
  @override
  String get caseSensitiveDescription => 'बड़े और छोटे अक्षरों को अलग मानें';
  @override
  String get ignoreWhitespace => 'व्हाइटस्पेस अनदेखा करें';
  @override
  String get ignoreWhitespaceDescription =>
      'तुलना करते समय आगे/पीछे के व्हाइटस्पेस को अनदेखा करें';
  @override
  String get showLineNumbers => 'लाइन नंबर दिखाएं';
  @override
  String get showLineNumbersDescription =>
      'डिफ़ दृश्य में लाइन नंबर प्रदर्शित करें';
  @override
  String get behavior => 'तुलना व्यवहार';
  @override
  String get ignoreCase => 'केस अनदेखा करें';
  @override
  String get ignoreCaseDescription => '"Key" और "key" को समान मानें';
  @override
  String get similarityThreshold => 'समानता सीमा';
  @override
  String get similarityThresholdDescription =>
      '"संशोधित" पता लगाने के लिए न्यूनतम समानता';
  @override
  String get mode => 'तुलना मोड';
  @override
  String get modeDescription =>
      'फ़ाइलों के बीच प्रविष्टियों का मिलान कैसे करें';
  @override
  String get modeKey => 'की-आधारित';
  @override
  String get modeKeyDescription => 'कुंजी नाम से मेल खाता है (डिफ़ॉल्ट)।';
  @override
  String get modeOrder => 'क्रम-आधारित';
  @override
  String get modeOrderDescription => 'फ़ाइल में स्थिति के अनुसार मेल खाता है।';
  @override
  String get modeSmart => 'स्मार्ट मैच';
  @override
  String get modeSmartDescription =>
      'स्थानांतरित/नामित कुंजियों का पता लगाता है।';
  @override
  String get ignorePatterns => 'पैटर्न अनदेखा करें';
  @override
  String get noIgnorePatterns => 'कोई अनदेखा पैटर्न सेट नहीं।';
  @override
  String get addPattern => 'पैटर्न जोड़ें';
  @override
  String get resetToGlobal =>
      'सभी तुलना सेटिंग्स को वैश्विक डिफ़ॉल्ट पर रीसेट करें';
  @override
  late final _TranslationsSettingsComparisonPatternPresetsHi patternPresets =
      _TranslationsSettingsComparisonPatternPresetsHi._(_root);
  @override
  late final _TranslationsSettingsComparisonPreviewMatchHi previewMatch =
      _TranslationsSettingsComparisonPreviewMatchHi._(_root);
  @override
  late final _TranslationsSettingsComparisonColorPresetsHi colorPresets =
      _TranslationsSettingsComparisonColorPresetsHi._(_root);
}

// Path: settings.fileHandling
class _TranslationsSettingsFileHandlingHi
    implements TranslationsSettingsFileHandlingEn {
  _TranslationsSettingsFileHandlingHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get fileFormats => 'फ़ाइल प्रारूप';
  @override
  String get sourceFormat => 'स्रोत प्रारूप';
  @override
  String get targetFormat => 'लक्ष्य प्रारूप';
  @override
  String get encoding => 'एन्कोडिंग';
  @override
  String get sourceEncoding => 'स्रोत एन्कोडिंग';
  @override
  String get targetEncoding => 'लक्ष्य एन्कोडिंग';
  @override
  String get autoDetect => 'स्वतः-पहचान';
  @override
  String get autoDetectEncodingDescription =>
      'फ़ाइल एन्कोडिंग का स्वचालित रूप से पता लगाएं';
  @override
  String get exportSettings => 'निर्यात सेटिंग्स';
  @override
  String get defaultExportFormat => 'डिफ़ॉल्ट निर्यात प्रारूप';
  @override
  String get includeUtf8Bom => 'UTF-8 BOM शामिल करें';
  @override
  String get includeUtf8BomDescription => 'Excel संगतता के लिए आवश्यक';
  @override
  String get openFolderAfterExport => 'निर्यात के बाद फ़ोल्डर खोलें';
  @override
  String get fileSafety => 'फ़ाइल सुरक्षा';
  @override
  String get fileSafetyDescription =>
      'आपदा रिकवरी के लिए स्वचालित स्थानीय प्रतियां।';
  @override
  String get resetToGlobal =>
      'सभी फ़ाइल हैंडलिंग सेटिंग्स को वैश्विक डिफ़ॉल्ट पर रीसेट करें';
}

// Path: settings.translationMemory
class _TranslationsSettingsTranslationMemoryHi
    implements TranslationsSettingsTranslationMemoryEn {
  _TranslationsSettingsTranslationMemoryHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'वैश्विक अनुवाद स्मृति';
  @override
  String get autoLearn => 'स्वतः-सीखें';
  @override
  String get autoLearnDescription =>
      'भविष्य के पुन: उपयोग के लिए स्थानीय मेमोरी में अनुवाद सहेजें';
  @override
  String get confidenceThreshold => 'विश्वास सीमा';
  @override
  String confidenceThresholdDescription({required Object percent}) =>
      'स्वचालित रूप से लागू करने के लिए न्यूनतम स्कोर (${percent}%)';
  @override
  String get entries => 'प्रविष्टियाँ';
  @override
  String get size => 'साइज';
  @override
  String memorySize({required Object size}) => 'मेमोरी साइज: ${size}';
  @override
  String get import => 'आयात करें';
  @override
  String get exportTmx => 'TMX निर्यात करें';
  @override
  String get exportCsv => 'CSV निर्यात करें';
  @override
  String get clearMemory => 'मेमोरी साफ़ करें';
  @override
  String importedItems({required Object count}) =>
      'मेमोरी में ${count} आइटम आयात किए गए।';
  @override
  String get noItemsAdded => 'कोई आइटम नहीं जोड़ा गया।';
  @override
  String get nothingToExport => 'अभी निर्यात करने के लिए कुछ नहीं है।';
  @override
  String get tmxSaved => 'TMX सहेजा गया';
  @override
  String get csvSaved => 'CSV सहेजा गया';
  @override
  String get clearConfirmTitle => 'अनुवाद स्मृति साफ़ करें?';
  @override
  String get clearConfirmContent =>
      'यह इस डिवाइस पर सभी सहेजे गए अनुवाद जोड़े हटा देता है। यह क्रिया पूर्ववत नहीं की जा सकती।';
  @override
  String get cleared => 'अनुवाद स्मृति साफ़ की गई।';
  @override
  String get couldNotClear => 'मेमोरी साफ़ नहीं कर सका।';
}

// Path: settings.backup
class _TranslationsSettingsBackupHi implements TranslationsSettingsBackupEn {
  _TranslationsSettingsBackupHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'ऑटो-बैकअप';
  @override
  String get description => 'स्वचालित बैकअप सेटिंग्स';
  @override
  String get enabled => 'ऑटो-बैकअप सक्षम करें';
  @override
  String get enabledDescription =>
      'बदलाव करने से पहले स्वचालित रूप से फ़ाइलों का बैकअप लें';
  @override
  String get maxCopies => 'अधिकतम बैकअप प्रतियां';
  @override
  String get maxCopiesDescription =>
      'प्रति फ़ाइल रखने के लिए बैकअप प्रतियों की संख्या';
  @override
  String activeStatus({required Object count}) =>
      'सक्रिय · ${count} प्रतियां रख रहा है';
  @override
  String get folder => 'बैकअप फ़ोल्डर';
  @override
  String get folderDescription =>
      'उसी फ़ोल्डर का उपयोग करने के लिए खाली छोड़ें';
  @override
  String get useOriginalFolder => 'मूल फ़ाइल फ़ोल्डर का उपयोग करें';
}

// Path: settings.ai
class _TranslationsSettingsAiHi implements TranslationsSettingsAiEn {
  _TranslationsSettingsAiHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'एआई सेवाएँ';
  @override
  String get description => 'एआई अनुवाद और सहायता कॉन्फ़िगर करें';
  @override
  String get provider => 'एआई प्रदाता';
  @override
  String get providerDescription => 'अपना पसंदीदा एआई सेवा प्रदाता चुनें';
  @override
  String get apiKey => 'API कुंजी';
  @override
  String get apiKeyDescription =>
      'चयनित प्रदाता के लिए अपनी API कुंजी दर्ज करें';
  @override
  String get apiKeyPlaceholder => 'API कुंजी दर्ज करें...';
  @override
  String get testConnection => 'कनेक्शन का परीक्षण करें';
  @override
  String get connectionSuccess => 'कनेक्शन सफल!';
  @override
  String get connectionFailed => 'कनेक्शन विफल। कृपया अपनी API कुंजी जांचें।';
  @override
  String get translationStrategy => 'अनुवाद रणनीति';
  @override
  String get strategy => 'रणनीति';
  @override
  String get strategyDescription =>
      'चुनें कि आप स्ट्रिंग्स का अनुवाद कैसे करना चाहते हैं';
  @override
  String get strategyLLM => 'जनरेटिव एआई (LLM)';
  @override
  String get strategyCloud => 'क्लाउड अनुवाद';
  @override
  String get enableAiTranslation => 'एआई अनुवाद सक्षम करें';
  @override
  String get enableAiTranslationDescription =>
      'ऐप को अनुवाद सुझावों के लिए एआई का उपयोग करने की अनुमति दें';
  @override
  String get llmProvider => 'LLM सेवा प्रदाता';
  @override
  String get service => 'सेवा';
  @override
  String get serviceDescription => 'जनरेटिव एआई के लिए प्रदाता';
  @override
  String get providerGemini => 'Google Gemini';
  @override
  String get providerOpenAI => 'OpenAI';
  @override
  String get geminiApiKey => 'Gemini API कुंजी';
  @override
  String get openAiApiKey => 'OpenAI API कुंजी';
  @override
  String get model => 'मॉडल';
  @override
  String get modelDescription => 'चुनें कि कौन सा मॉडल उपयोग करना है';
  @override
  String get advancedParameters => 'उन्नत पैरामीटर';
  @override
  String get parameters => 'पैरामीटर';
  @override
  String get parametersDescription => 'तापमान, संदर्भ, और अधिक';
  @override
  String get temperature => 'तापमान';
  @override
  String get temperatureDescription =>
      'उच्च मान आउटपुट को अधिक रचनात्मक बनाते हैं';
  @override
  String get maxTokens => 'अधिकतम टोकन';
  @override
  String get maxTokensDescription => 'संदर्भ विंडो लंबाई सीमित करें';
  @override
  String get systemContext => 'सिस्टम संदर्भ / निर्देश';
  @override
  String get systemContextHint =>
      'आप एक पेशेवर स्थानीयकरणकर्ता हैं। मूल स्ट्रिंग के टोन और आशय को बनाए रखें...';
  @override
  String get systemContextHelper =>
      'अपने प्रोजेक्ट की शैली और शब्दावली के बारे में एआई को विशिष्ट निर्देश प्रदान करें।';
  @override
  String get contextStrings => 'संदर्भ स्ट्रिंग्स';
  @override
  String get contextStringsDescription =>
      'बेहतर संदर्भ के लिए आसपास की स्ट्रिंग्स शामिल करें';
  @override
  String get contextCount => 'संदर्भ गिनती';
  @override
  String get contextCountDescription =>
      'शामिल करने के लिए आसपास की स्ट्रिंग्स की संख्या';
  @override
  String get cloudServices => 'क्लाउड अनुवाद सेवाएँ';
  @override
  String get googleTranslateApiKey => 'Google Translate API कुंजी';
  @override
  String get deeplApiKey => 'DeepL API कुंजी';
  @override
  String get test => 'परीक्षण';
  @override
  String get resetToGlobal =>
      'सभी एआई सेटिंग्स को वैश्विक डिफ़ॉल्ट पर रीसेट करें';
}

// Path: settings.integrations
class _TranslationsSettingsIntegrationsHi
    implements TranslationsSettingsIntegrationsEn {
  _TranslationsSettingsIntegrationsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get platformNotice => 'प्लेटफ़ॉर्म नोटिस';
  @override
  String get platformNoticeDescription =>
      'सिस्टम एकीकरण इस प्लेटफ़ॉर्म के लिए उपलब्ध नहीं हैं।';
  @override
  String get visualEffects => 'दृश्य प्रभाव';
  @override
  String get explorerIntegration => 'एक्सप्लोरर एकीकरण';
  @override
  String get explorerIntegrationDescription =>
      'फ़ोल्डरों के लिए Windows एक्सप्लोरर राइट-क्लिक मेनू में "Localizer के साथ खोलें" जोड़ें।';
  @override
  String get addToContextMenu => 'संदर्भ मेनू में जोड़ें';
  @override
  String get contextMenuAdded => 'संदर्भ मेनू जोड़ा गया!';
  @override
  String get contextMenuAddError => 'संदर्भ मेनू जोड़ने में विफल';
  @override
  String get contextMenuRemoved => 'संदर्भ मेनू हटाया गया!';
  @override
  String get contextMenuRemoveError => 'संदर्भ मेनू हटाने में विफल';
  @override
  String get fileAssociations => 'फ़ाइल एसोसिएशन';
  @override
  String get fileAssociationsDescription =>
      'एक्स्प्लोरर में डबल-क्लिक करने पर Localizer के साथ खोलने के लिए फ़ाइल प्रकार पंजीकृत करें।';
  @override
  String get registered => 'पंजीकृत';
  @override
  String get notRegistered => 'पंजीकृत नहीं';
  @override
  String extRegistered({required Object ext}) => '${ext} पंजीकृत!';
  @override
  String extUnregistered({required Object ext}) => '${ext} अपंजीकृत!';
  @override
  String extError({required Object action, required Object ext}) =>
      '${action} ${ext} में विफल';
  @override
  String get registerAll => 'सभी पंजीकृत करें';
  @override
  String get unregisterAll => 'सभी अपंजीकृत करें';
  @override
  String registerAllResult({required Object total, required Object success}) =>
      '${total} फ़ाइल प्रकारों में से ${success} पंजीकृत';
  @override
  String unregisterAllResult(
          {required Object total, required Object success}) =>
      '${total} फ़ाइल प्रकारों में से ${success} अपंजीकृत';
  @override
  String get protocolHandler => 'प्रोटोकॉल हैंडलर';
  @override
  String get protocolHandlerDescription =>
      'इस एप्लिकेशन को खोलने के लिए localizer:// URL पंजीकृत करें। ब्राउज़र लिंक या अन्य ऐप्स से सीधे प्रोजेक्ट खोलने की अनुमति देता है।';
  @override
  String get protocolRegistered => 'प्रोटोकॉल हैंडलर पंजीकृत है';
  @override
  String get protocolNotRegistered => 'प्रोटोकॉल हैंडलर पंजीकृत नहीं है';
  @override
  String get registerProtocol => 'प्रोटोकॉल पंजीकृत करें';
  @override
  String get unregister => 'अपंजीकृत करें';
  @override
  String get protocolRegisteredSuccess => 'प्रोटोकॉल हैंडलर पंजीकृत!';
  @override
  String get protocolRemovedSuccess => 'प्रोटोकॉल हैंडलर हटाया गया!';
  @override
  String get protocolRegisterError => 'पंजीकृत करने में विफल';
  @override
  String get protocolRemoveError => 'हटाने में विफल';
  @override
  String get windowMaterial => 'विंडो सामग्री';
  @override
  String get windowMaterialDescription =>
      'macOS वाइब्रेंसी सामग्री शैली का चयन करें';
  @override
  String get dockIntegration => 'डॉक एकीकरण';
  @override
  String get showDockBadge => 'अनुवादित नहीं गिनती दिखाएं';
  @override
  String get showDockBadgeDescription =>
      'डॉक आइकन बैज पर अनुवादित नहीं स्ट्रिंग गिनती प्रदर्शित करें';
  @override
  late final _TranslationsSettingsIntegrationsMaterialsHi materials =
      _TranslationsSettingsIntegrationsMaterialsHi._(_root);
  @override
  late final _TranslationsSettingsIntegrationsFileTypesHi fileTypes =
      _TranslationsSettingsIntegrationsFileTypesHi._(_root);
}

// Path: settings.developer
class _TranslationsSettingsDeveloperHi
    implements TranslationsSettingsDeveloperEn {
  _TranslationsSettingsDeveloperHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'डेवलपर सेटिंग्स';
  @override
  String get description => 'डेवलपर्स के लिए उन्नत सेटिंग्स';
  @override
  String get showLocalizationKeys => 'स्थानीयकरण कुंजियाँ दिखाएं';
  @override
  String get localizationKeysDescription =>
      'सक्षम होने पर, सभी अनुवादित पाठ अनुवादित मान के बजाय अपनी स्थानीयकरण कुंजियाँ दिखाएंगे। यह सत्यापित करने के लिए उपयोगी है कि कौन सी कुंजी कहाँ उपयोग की जाती है।';
  @override
  String get showPerformanceOverlay => 'प्रदर्शन ओवरले दिखाएं';
  @override
  String get performanceOverlayDescription =>
      'FPS और फ्रेम समय की जानकारी प्रदर्शित करें';
  @override
  String get debugMode => 'डिबग मोड';
  @override
  String get debugModeDescription =>
      'अतिरिक्त लॉगिंग और डिबग सुविधाएं सक्षम करें';
  @override
  String get debuggingTools => 'डिबगिंग उपकरण';
  @override
  String get semanticsDebugger => 'सिमेंटिक्स डिबगर';
  @override
  String get semanticsDebuggerDescription => 'सिमेंटिक्स ट्री विज़ुअलाइज़ करें';
  @override
  String get materialGrid => 'मटेरियल ग्रिड';
  @override
  String get materialGridDescription => 'मटेरियल लेआउट ग्रिड ओवरले करें';
  @override
  String get rasterCache => 'रास्टर कैश छवियां';
  @override
  String get rasterCacheDescription => 'चेकरबोर्ड रास्टर कैश छवियां';
  @override
  String get actions => 'क्रियाएं';
  @override
  String get showLogs => 'ऐप लॉग दिखाएं';
  @override
  String get showLogsDescription => 'Talker डिबग कंसोल खोलें';
  @override
  String get restartTutorial => 'ओनबोर्डिंग ट्यूटोरियल पुनः आरंभ करें';
  @override
  String get restartTutorialDescription =>
      'झंडे रीसेट करें और ट्यूटोरियल फिर से लॉन्च करें';
  @override
  String get restartRequested => 'ट्यूटोरियल पुनः आरंभ का अनुरोध किया गया।';
  @override
  String get throwException => 'परीक्षण अपवाद फेंकें';
  @override
  String get throwExceptionDescription =>
      'क्रैश रिपोर्टिंग के लिए परीक्षण अपवाद ट्रिगर करें';
  @override
  String get testExceptionMessage =>
      'डेवलपर विकल्पों से परीक्षण अपवाद ट्रिगर किया गया';
  @override
  String get clearTM => 'अनुवाद स्मृति साफ़ करें';
  @override
  String get clearTMDescription => 'सभी कैश किए गए अनुवाद हटाएं';
  @override
  String get clearTMConfirmation => 'अनुवाद स्मृति साफ़ करें?';
  @override
  String get clearTMWarning =>
      'यह सभी सीखे गए अनुवादों को हटा देगा। यह क्रिया पूर्ववत नहीं की जा सकती।';
  @override
  String get tmCleared => 'अनुवाद स्मृति साफ़ की गई';
  @override
  String get clearApiKeys => 'API कुंजियाँ साफ़ करें';
  @override
  String get clearApiKeysDescription => 'सभी संग्रहीत API कुंजियाँ हटाएं';
  @override
  String get clearApiKeysConfirmation => 'API कुंजियाँ साफ़ करें?';
  @override
  String get clearApiKeysWarning =>
      'यह सुरक्षित भंडारण से सभी API कुंजियों को हटा देगा।';
  @override
  String get apiKeysCleared => 'API कुंजियाँ साफ़ की गईं';
  @override
  String get hideOptions => 'डेवलपर विकल्प छिपाएं';
  @override
  String get hideOptionsDescription =>
      'डेवलपर मोड अक्षम करें (पुनः सक्षम करने के लिए 7 टैप की आवश्यकता है)';
  @override
  String get optionsDisabled => 'डेवलपर विकल्प अक्षम';
  @override
  String get dangerZone => 'खतरा क्षेत्र';
  @override
  String get factoryReset => 'फ़ैक्टरी रीसेट';
  @override
  String get factoryResetDescription =>
      'सभी सेटिंग्स रीसेट करें और डेटा साफ़ करें';
  @override
  String get factoryResetWarning =>
      'क्या आप वाकई सभी सेटिंग्स रीसेट करना चाहते हैं? यह क्रिया पूर्ववत नहीं की जा सकती।';
  @override
  String get inspectionTools => 'निरीक्षण उपकरण';
  @override
  String get searchHint => 'सेटिंग्स खोजें...';
  @override
  String get resetToDefault => 'डिफ़ॉल्ट पर रीसेट करें';
  @override
  String get resetToGlobal => 'वैश्विक डिफ़ॉल्ट पर रीसेट करें';
  @override
  String get storageInspector => 'भंडारण निरीक्षक';
  @override
  String get storageInspectorDescription =>
      'Hive और सुरक्षित भंडारण सामग्री देखें';
  @override
  String get deviceEnvironment => 'डिवाइस और पर्यावरण';
  @override
  String get deviceEnvironmentDescription =>
      'स्क्रीन, प्लेटफ़ॉर्म और बिल्ड जानकारी';
  @override
  String get themePlayground => 'थीम खेल का मैदान';
  @override
  String get themePlaygroundDescription => 'रंग पैलेट और टाइपोग्राफी';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionHi
      themePlaygroundSection =
      _TranslationsSettingsDeveloperThemePlaygroundSectionHi._(_root);
  @override
  String get localizationInspector => 'स्थानीयकरण निरीक्षक';
  @override
  String get localizationInspectorDescription => 'अनुवाद स्ट्रिंग्स डिबग करें';
  @override
  String get hiveAppSettings => 'Hive (AppSettings)';
  @override
  String get secureStorageMasked => 'सुरक्षित भंडारण (मास्क किया गया)';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsHi featureFlags =
      _TranslationsSettingsDeveloperFeatureFlagsHi._(_root);
  @override
  late final _TranslationsSettingsDeveloperStorageInspectorSectionHi
      storageInspectorSection =
      _TranslationsSettingsDeveloperStorageInspectorSectionHi._(_root);
  @override
  late final _TranslationsSettingsDeveloperDeviceInfoSectionHi
      deviceInfoSection =
      _TranslationsSettingsDeveloperDeviceInfoSectionHi._(_root);
  @override
  late final _TranslationsSettingsDeveloperLocalizationInspectorSectionHi
      localizationInspectorSection =
      _TranslationsSettingsDeveloperLocalizationInspectorSectionHi._(_root);
}

// Path: settings.about
class _TranslationsSettingsAboutHi implements TranslationsSettingsAboutEn {
  _TranslationsSettingsAboutHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'के बारे में';
  @override
  String get version => 'संस्करण';
  @override
  String get buildNumber => 'बिल्ड नंबर';
  @override
  String get author => 'लेखक';
  @override
  String get license => 'लाइसेंस';
  @override
  String get sourceCode => 'स्रोत कोड';
  @override
  String get reportBug => 'बग की रिपोर्ट करें';
  @override
  String get requestFeature => 'सुविधा का अनुरोध करें';
  @override
  String get checkForUpdates => 'अपडेट के लिए जाँचें';
  @override
  String get upToDate => 'आप अप-टू-डेट हैं!';
  @override
  String updateAvailable({required Object version}) =>
      'अपडेट उपलब्ध: ${version}';
  @override
  String get updateAvailableBadge => 'अपडेट उपलब्ध!';
  @override
  String developerSteps({required Object count}) =>
      'आप डेवलपर होने से ${count} कदम दूर हैं।';
  @override
  String get developerActivated => 'आप अब एक डेवलपर हैं!';
  @override
  String get neverChecked => 'कभी नहीं';
  @override
  String get applicationInfo => 'एप्लिकेशन जानकारी';
  @override
  String get platform => 'प्लेटफ़ॉर्म';
  @override
  String get updateInformation => 'अपडेट जानकारी';
  @override
  String get currentVersion => 'वर्तमान संस्करण';
  @override
  String get latestVersion => 'नवीनतम संस्करण';
  @override
  String get lastChecked => 'अंतिम जाँचा गया';
  @override
  String get checkingForUpdates => 'जांच रहा है...';
  @override
  String get whatsNew => 'नया क्या है';
  @override
  String get systemInformation => 'सिस्टम जानकारी';
  @override
  String get dartVersion => 'Dart संस्करण';
  @override
  String get diskSpace => 'उपलब्ध डिस्क स्थान';
  @override
  String get memoryUsage => 'मेमोरी उपयोग';
  @override
  String get privacyTitle => 'गोपनीयता और टेलीमेट्री';
  @override
  String get usageStats => 'गुमनाम उपयोग सांख्यिकी';
  @override
  String get requiresFirebase => 'Firebase कॉन्फ़िगरेशन की आवश्यकता है';
  @override
  String get featureUnavailable =>
      'सुविधा वर्तमान में अनुपलब्ध (Firebase की आवश्यकता है)';
  @override
  String get settingsManagement => 'सेटिंग्स प्रबंधन';
  @override
  String get settingsManagementDescription =>
      'अपनी सेटिंग्स को बैकअप करने या अन्य मशीनों के साथ साझा करने के लिए फ़ाइल में निर्यात करें।';
  @override
  String get resetAll => 'सभी रीसेट करें';
  @override
  String get links => 'लिंक';
  @override
  String get githubRepo => 'GitHub रिपॉजिटरी';
  @override
  String get privacyPolicy => 'गोपनीयता नीति';
  @override
  String get crashReporting => 'क्रैश रिपोर्टिंग';
}

// Path: settings.onboarding
class _TranslationsSettingsOnboardingHi
    implements TranslationsSettingsOnboardingEn {
  _TranslationsSettingsOnboardingHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'ट्यूटोरियल छोड़ें';
  @override
  String get gettingStarted => 'शुरू करना';
  @override
  String stepProgress({required Object total, required Object current}) =>
      '${total} में से ${current}';
  @override
  String get loadSampleData => 'नमूना डेटा लोड करें';
  @override
  late final _TranslationsSettingsOnboardingStepsHi steps =
      _TranslationsSettingsOnboardingStepsHi._(_root);
}

// Path: settings.settingsView
class _TranslationsSettingsSettingsViewHi
    implements TranslationsSettingsSettingsViewEn {
  _TranslationsSettingsSettingsViewHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String resetCategoryTitle({required Object category}) =>
      '${category} रीसेट करें?';
  @override
  String get resetCategoryContent =>
      'यह इस श्रेणी की सभी सेटिंग्स को उनके डिफ़ॉल्ट मानों पर रीसेट कर देगा।';
  @override
  String get resetAllTitle => 'सभी सेटिंग्स रीसेट करें?';
  @override
  String get resetAllContent =>
      'यह स्थायी रूप से सभी सेटिंग्स को उनके फ़ैक्टरी डिफ़ॉल्ट पर रीसेट कर देगा। यह क्रिया पूर्ववत नहीं की जा सकती।';
  @override
  String get resetAll => 'सभी रीसेट करें';
  @override
  String resetSuccess({required Object category}) =>
      '${category} डिफ़ॉल्ट पर रीसेट';
  @override
  String get errorLoading => 'सेटिंग्स लोड करने में त्रुटि';
  @override
  String get settingsSaved => 'सेटिंग्स सहेजी गईं';
  @override
  String updateAvailable({required Object version}) =>
      'अपडेट उपलब्ध: v${version}';
  @override
  String get latestVersion => 'आप नवीनतम संस्करण का उपयोग कर रहे हैं';
  @override
  String whatsNew({required Object version}) => 'v${version} में नया क्या है';
  @override
  String get downloadUpdate => 'अपडेट डाउनलोड करें';
  @override
  String get exportSettings => 'सेटिंग्स निर्यात करें';
  @override
  String get settingsExported => 'सेटिंग्स निर्यात की गईं';
  @override
  String exportFail({required Object error}) =>
      'सेटिंग्स निर्यात करने में विफल: ${error}';
  @override
  String get importSettings => 'सेटिंग्स आयात करें';
  @override
  String get importTitle => 'सेटिंग्स आयात करें?';
  @override
  String get importContent =>
      'यह आपकी सभी मौजूदा सेटिंग्स को आयातित सेटिंग्स से बदल देगा। यह क्रिया पूर्ववत नहीं की जा सकती।';
  @override
  String get importSuccess => 'सेटिंग्स सफलतापूर्वक आयात की गईं!';
  @override
  String importFail({required Object error}) =>
      'सेटिंग्स आयात करने में विफल: ${error}';
  @override
  String get invalidFormat => 'अमान्य सेटिंग्स फ़ाइल प्रारूप';
  @override
  late final _TranslationsSettingsSettingsViewCategoriesHi categories =
      _TranslationsSettingsSettingsViewCategoriesHi._(_root);
  @override
  late final _TranslationsSettingsSettingsViewCategoryLabelsHi categoryLabels =
      _TranslationsSettingsSettingsViewCategoryLabelsHi._(_root);
}

// Path: advancedDiff.aiSuggestion
class _TranslationsAdvancedDiffAiSuggestionHi
    implements TranslationsAdvancedDiffAiSuggestionEn {
  _TranslationsAdvancedDiffAiSuggestionHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get aiTranslation => 'एआई अनुवाद';
  @override
  String get aiRephrase => 'एआई रिफ्रेश';
  @override
  String key({required Object key}) => 'कुंजी: ${key}';
  @override
  String get original => 'मूल:';
  @override
  String get suggestion => 'सुझाव:';
  @override
  String get confidence => 'एआई विश्वास';
  @override
  String get cancelEdit => 'संपादन रद्द करें';
  @override
  String get editSuggestion => 'सुझाव संपादित करें';
  @override
  String get alternatives => 'विकल्प:';
  @override
  String get accept => ' स्वीकार करें';
  @override
  String get reject => 'अस्वीकार करें';
  @override
  String get stop => 'रोकें';
}

// Path: advancedDiff.detailEdit
class _TranslationsAdvancedDiffDetailEditHi
    implements TranslationsAdvancedDiffDetailEditEn {
  _TranslationsAdvancedDiffDetailEditHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object key}) => 'संपादित करें: ${key}';
  @override
  String get sourceLabel => 'स्रोत (मूल)';
  @override
  String get targetLabel => 'लक्ष्य (अनुवाद)';
  @override
  String get translateWithCloud => 'क्लाउड के साथ अनुवाद करें';
  @override
  String get translateWithAi => 'एआई के साथ अनुवाद करें';
  @override
  String get translating => 'अनुवाद हो रहा है...';
  @override
  String get applyAndTm => 'लागू करें';
  @override
  String get entryApplied => 'प्रविष्टि लागू की गई और TM में जोड़ी गई';
  @override
  String get translationAdded => 'अनुवाद सुझाव जोड़ा गया।';
  @override
  String get aiSuggestionAdded => 'एआई सुझाव जोड़ा गया।';
}

// Path: advancedDiff.table
class _TranslationsAdvancedDiffTableHi
    implements TranslationsAdvancedDiffTableEn {
  _TranslationsAdvancedDiffTableHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get addedToTM => 'अनुवाद स्मृति में जोड़ा गया';
  @override
  String get markedReviewed => 'समीक्षित के रूप में चिह्नित ✓';
  @override
  String get unmarkedReview => 'समीक्षा अचयनित';
  @override
  String get reverted => 'मूल मान पर वापस लाया गया';
  @override
  String get entryDeleted => 'प्रविष्टि हटाई गई';
  @override
  String get noSourceText => 'अनुवाद करने के लिए कोई स्रोत पाठ नहीं।';
  @override
  String aiTranslationFailed({required Object key}) =>
      '"${key}" के लिए एआई अनुवाद विफल';
  @override
  String get noTargetText => 'रिफ्रेश करने के लिए कोई लक्ष्य पाठ नहीं।';
  @override
  String aiRephraseFailed({required Object key}) =>
      '"${key}" के लिए एआई रिफ्रेश विफल';
  @override
  String get checkRowsFirst =>
      'पहले चेकबॉक्स का उपयोग करके पंक्तियों की जाँच करें';
  @override
  String markedRowsReviewed({required Object count}) =>
      '${count} पंक्तियों को समीक्षित के रूप में चिह्नित किया गया';
  @override
  String revertedRows({required Object count}) =>
      '${count} पंक्तियों को वापस लाया गया';
  @override
  String entriesCount({required Object count}) => '${count} प्रविष्टियाँ';
  @override
  String get markSelectedReviewed => 'चयनित को समीक्षित चिह्नित करें';
  @override
  String get revertSelected => 'चयनित को वापस लाएं';
  @override
  String get noDifferences => 'कोई अंतर नहीं मिला';
  @override
  String get adjustFilters => 'अपने फ़िल्टर समायोजित करने का प्रयास करें';
  @override
  String get cloudTranslationApplied => 'क्लाउड अनुवाद लागू किया गया।';
  @override
  String get aiTranslationApplied => 'एआई अनुवाद लागू किया गया।';
  @override
  String get suggestionApplied => 'सुझाव लागू किया गया।';
  @override
  String get aiSuggestionApplied => 'एआई सुझाव लागू किया गया।';
  @override
  String get rephraseApplied => 'रिफ्रेश लागू किया गया।';
  @override
  String get aiRephraseApplied => 'एआई रिफ्रेश लागू किया गया।';
  @override
  String get rephrase => 'रिफ्रेश';
  @override
  String get aiRephrase => 'एआई रिफ्रेश';
  @override
  String get targetClickToEdit => 'लक्ष्य (संपादित करने के लिए क्लिक करें)';
  @override
  String get targetClickForDialog => 'लक्ष्य (संवाद के लिए क्लिक करें)';
  @override
  String get emptyClickToEdit => '(खाली - संपादित करने के लिए क्लिक करें)';
  @override
  String get unmarkReviewed => 'समीक्षित अचयनित करें';
  @override
  String get markReviewed => 'समीक्षित के रूप में चिह्नित करें';
  @override
  String get revertToSource => 'स्रोत पर वापस लाएं';
  @override
  String get translateWithCloud => 'क्लाउड के साथ अनुवाद करें';
  @override
  String get translateWithAi => 'एआई के साथ अनुवाद करें';
  @override
  String get rephraseWithAi => 'एआई के साथ रिफ्रेश करें';
  @override
  String get moreActions => 'अधिक क्रियाएं';
  @override
  String get editDetails => 'विवरण संपादित करें';
  @override
  String get suggestTranslation => 'अनुवाद सुझाव दें';
  @override
  String get addToTm => 'TM में जोड़ें';
  @override
  String get deleteEntry => 'प्रविष्टि हटाएं';
}

// Path: advancedDiff.diffRow
class _TranslationsAdvancedDiffDiffRowHi
    implements TranslationsAdvancedDiffDiffRowEn {
  _TranslationsAdvancedDiffDiffRowHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get copySource => 'स्रोत पाठ कॉपी करें';
  @override
  String get actions => 'क्रियाएं';
}

// Path: advancedDiff.status
class _TranslationsAdvancedDiffStatusHi
    implements TranslationsAdvancedDiffStatusEn {
  _TranslationsAdvancedDiffStatusHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'जोड़ा गया';
  @override
  String get missing => 'लापता';
  @override
  String changed({required Object percent}) => 'बदला गया ${percent}%';
  @override
  String get same => 'समान';
}

// Path: advancedDiff.sidebar
class _TranslationsAdvancedDiffSidebarHi
    implements TranslationsAdvancedDiffSidebarEn {
  _TranslationsAdvancedDiffSidebarHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get widgets => 'विजेट्स';
  @override
  String get searchPlaceholder => 'कुंजियाँ और मान खोजें... (Ctrl+F)';
  @override
  String get fuzzySearchTooltip => 'फजी खोज (टाइपो-सहिष्णु)';
  @override
  String get regexSearchTooltip => 'Regex खोज';
  @override
  String get cloudTranslation => 'क्लाउड अनुवाद';
  @override
  String get aiTranslation => 'एआई अनुवाद';
  @override
  String get status => 'स्थिति';
  @override
  String get tm => 'अनुवाद स्मृति';
  @override
  String get filters => 'फ़िल्टर';
  @override
  String get actions => 'क्रियाएं';
  @override
  String get similarity => 'समानता';
  @override
  late final _TranslationsAdvancedDiffSidebarActionsSectionHi actionsSection =
      _TranslationsAdvancedDiffSidebarActionsSectionHi._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarAiSectionHi aiSection =
      _TranslationsAdvancedDiffSidebarAiSectionHi._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarTmSectionHi tmSection =
      _TranslationsAdvancedDiffSidebarTmSectionHi._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarFiltersSectionHi filtersSection =
      _TranslationsAdvancedDiffSidebarFiltersSectionHi._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarSimilaritySectionHi
      similaritySection =
      _TranslationsAdvancedDiffSidebarSimilaritySectionHi._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarStatusSectionHi statusSection =
      _TranslationsAdvancedDiffSidebarStatusSectionHi._(_root);
}

// Path: issueDetails.duplicateValue
class _TranslationsIssueDetailsDuplicateValueHi
    implements TranslationsIssueDetailsDuplicateValueEn {
  _TranslationsIssueDetailsDuplicateValueHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'दोहराया गया अनुवाद';
  @override
  String get warning =>
      'विभिन्न स्रोत पाठ इस समान अनुवाद का उपयोग करते हैं। संदर्भ की जाँच करें।';
  @override
  String affectedKeys({required Object count}) =>
      'प्रभावित कुंजियाँ (${count})';
  @override
  String get identicalSources => 'समान स्रोत';
  @override
  String moreKeys({required Object count}) => '+${count} और कुंजियाँ';
}

// Path: issueDetails.lengthOutlier
class _TranslationsIssueDetailsLengthOutlierHi
    implements TranslationsIssueDetailsLengthOutlierEn {
  _TranslationsIssueDetailsLengthOutlierHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get source => 'स्रोत';
  @override
  String get translation => 'अनुवाद';
  @override
  String chars({required Object count}) => '${count} अक्षर';
}

// Path: issueDetails.standard
class _TranslationsIssueDetailsStandardHi
    implements TranslationsIssueDetailsStandardEn {
  _TranslationsIssueDetailsStandardHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'कुंजी';
  @override
  String get sourceText => 'स्रोत पाठ';
  @override
  String get translation => 'अनुवाद';
  @override
  String get errorDetails => 'त्रुटि विवरण';
  @override
  String get note => 'नोट';
}

// Path: issueDetails.types
class _TranslationsIssueDetailsTypesHi
    implements TranslationsIssueDetailsTypesEn {
  _TranslationsIssueDetailsTypesHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get duplicateValue => 'दोहराए गए मान';
  @override
  String get lengthOutlier => 'लंबाई बेमेल';
  @override
  String get placeholderMismatch => 'टूटे हुए प्लेसहोल्डर';
}

// Path: issueDetails.notes
class _TranslationsIssueDetailsNotesHi
    implements TranslationsIssueDetailsNotesEn {
  _TranslationsIssueDetailsNotesHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get placeholderMismatch =>
      '{name} जैसे मार्करों को स्रोत से मेल खाना चाहिए।';
  @override
  String get lengthOutlier =>
      'बड़े लंबाई परिवर्तन यह प्रभावित कर सकते हैं कि पाठ स्क्रीन पर कैसे फिट बैठता है।';
  @override
  String get duplicateValue =>
      'विभिन्न कुंजियों के लिए समान अनुवाद का उपयोग किया जाता है।';
}

// Path: issueDetails.fallbacks
class _TranslationsIssueDetailsFallbacksHi
    implements TranslationsIssueDetailsFallbacksEn {
  _TranslationsIssueDetailsFallbacksHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get multipleSources => 'कई स्रोत पाठ';
  @override
  String get sourceNotAvailable => 'स्रोत पाठ उपलब्ध नहीं है';
  @override
  String get sharedTranslationNotAvailable => 'साझा अनुवाद उपलब्ध नहीं है';
  @override
  String get translationNotAvailable => 'अनुवाद उपलब्ध नहीं है';
}

// Path: compare.tabs
class _TranslationsCompareTabsHi implements TranslationsCompareTabsEn {
  _TranslationsCompareTabsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get files => 'फ़ाइलें';
  @override
  String get directories => 'निर्देशिकाएँ';
  @override
  String get git => 'Git';
}

// Path: compare.fileTypes
class _TranslationsCompareFileTypesHi
    implements TranslationsCompareFileTypesEn {
  _TranslationsCompareFileTypesHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get json => 'JSON स्थानीयकरण फ़ाइलें (i18next, Flutter, आदि)';
  @override
  String get yaml => 'YAML स्थानीयकरण फ़ाइलें (Rails, Flutter)';
  @override
  String get xml => 'XML स्थानीयकरण फ़ाइलें (Android, .NET)';
  @override
  String get properties => 'Properties फ़ाइलें (Java)';
  @override
  String get resx => 'RESX फ़ाइलें (.NET)';
  @override
  String get xliff => 'XLIFF फ़ाइलें';
}

// Path: history.timeAgo
class _TranslationsHistoryTimeAgoHi implements TranslationsHistoryTimeAgoEn {
  _TranslationsHistoryTimeAgoHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get justNow => 'अभी';
  @override
  String secondsAgo({required Object count}) => '${count} सेकंड पहले';
  @override
  String get oneMinuteAgo => '1 मिनट पहले';
  @override
  String minutesAgo({required Object count}) => '${count} मिनट पहले';
  @override
  String get oneHourAgo => '1 घंटा पहले';
  @override
  String hoursAgo({required Object count}) => '${count} घंटे पहले';
  @override
  String get yesterday => 'कल';
  @override
  String daysAgo({required Object count}) => '${count} दिन पहले';
  @override
  String get oneWeekAgo => '1 सप्ताह पहले';
  @override
  String weeksAgo({required Object count}) => '${count} सप्ताह पहले';
  @override
  String get oneMonthAgo => '1 महीने पहले';
  @override
  String monthsAgo({required Object count}) => '${count} महीने पहले';
  @override
  String get oneYearAgo => '1 साल पहले';
  @override
  String yearsAgo({required Object count}) => '${count} साल पहले';
  @override
  String get inTheFuture => 'भविष्य में';
}

// Path: projects.stats
class _TranslationsProjectsStatsHi implements TranslationsProjectsStatsEn {
  _TranslationsProjectsStatsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get empty => 'खाली प्रोजेक्ट';
  @override
  String files({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        n,
        one: '1 अनुवाद फ़ाइल',
        other: '${count} अनुवाद फ़ाइलें',
      );
  @override
  String languages({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        n,
        one: '1 भाषा',
        other: '${count} भाषाएँ',
      );
}

// Path: projects.selection
class _TranslationsProjectsSelectionHi
    implements TranslationsProjectsSelectionEn {
  _TranslationsProjectsSelectionHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get selectFolder => 'प्रोजेक्ट फ़ोल्डर चुनें';
  @override
  String get selectArchive => 'प्रोजेक्ट आर्काइव चुनें';
  @override
  String get openProject => 'प्रोजेक्ट खोलें';
  @override
  String get browseFolder => 'फ़ोल्डर ब्राउज़ करें...';
  @override
  String get createNew => 'नया बनाएं';
  @override
  String get importFromZip => 'ज़िप से आयात करें...';
}

// Path: projects.createDialog
class _TranslationsProjectsCreateDialogHi
    implements TranslationsProjectsCreateDialogEn {
  _TranslationsProjectsCreateDialogHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'प्रोजेक्ट बनाएं';
  @override
  String get description =>
      'एक प्रोजेक्ट आपको एक विशिष्ट फ़ोल्डर के लिए कस्टम सेटिंग्स सहेजने देता है। आपकी प्रोजेक्ट कॉन्फ़िगरेशन को संग्रहीत करने के लिए एक ".localizer" फ़ोल्डर बनाया जाएगा।';
  @override
  String get folderLabel => 'प्रोजेक्ट फ़ोल्डर';
  @override
  String get folderHint => 'फ़ोल्डर चुनने के लिए क्लिक करें...';
  @override
  String get nameLabel => 'प्रोजेक्ट का नाम';
  @override
  String get nameHint => 'उदा., मेरा ऐप अनुवाद';
  @override
  String get selectFolderWarning => 'कृपया एक प्रोजेक्ट फ़ोल्डर चुनें।';
  @override
  String get enterNameError => 'कृपया प्रोजेक्ट का नाम दर्ज करें';
  @override
  String get nameLengthError => 'नाम कम से कम 2 अक्षरों का होना चाहिए';
  @override
  String success({required Object name}) =>
      'प्रोजेक्ट "${name}" सफलतापूर्वक बनाया गया!';
  @override
  String get failure => 'प्रोजेक्ट बनाने में विफल।';
  @override
  String get creating => 'बना रहा है...';
  @override
  String get createAction => 'प्रोजेक्ट बनाएं';
}

// Path: projects.indicator
class _TranslationsProjectsIndicatorHi
    implements TranslationsProjectsIndicatorEn {
  _TranslationsProjectsIndicatorHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get tooltipNoProject =>
      'फ़ोल्डर के लिए कस्टम सेटिंग्स सहेजने के लिए एक प्रोजेक्ट बनाएं';
  @override
  String tooltipProject({required Object name}) =>
      'प्रोजेक्ट: ${name}\nविकल्प देखने के लिए क्लिक करें';
  @override
  String get location => 'स्थान';
  @override
  String get created => 'बनाया गया';
  @override
  String get switchProject => 'प्रोजेक्ट बदलें';
  @override
  String get done => 'हो गया';
}

// Path: projects.glossary
class _TranslationsProjectsGlossaryHi
    implements TranslationsProjectsGlossaryEn {
  _TranslationsProjectsGlossaryHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'प्रोजेक्ट शब्दावली';
  @override
  String get description =>
      'उन शब्दों को परिभाषित करें जिन्हें लगातार माना जाना चाहिए या कभी अनुवादित नहीं किया जाना चाहिए।';
  @override
  String get noTerms => 'अभी तक कोई शब्दावली शब्द नहीं।';
  @override
  String get noTermsDesc =>
      'वे शब्द जोड़ें जो अनुवादों में सुसंगत रहने चाहिए,\nया ब्रांड नाम जिन्हें कभी अनुवादित नहीं किया जाना चाहिए।';
  @override
  String get doNotTranslate => 'अनुवाद न करें';
  @override
  String get noSpecificTranslation => 'कोई विशिष्ट अनुवाद नहीं';
  @override
  String get addTerm => 'शब्द जोड़ें';
  @override
  String get editTerm => 'शब्द संपादित करें';
  @override
  String get term => 'शब्द';
  @override
  String get termHint => 'उदा., ब्रांड नाम, विशिष्ट शब्द';
  @override
  String get definition => 'परिभाषा (वैकल्पिक)';
  @override
  String get definitionHint => 'अनुवादक के लिए संदर्भ';
  @override
  String get doNotTranslateLabel => 'अनुवाद न करें';
  @override
  String get doNotTranslateDesc => 'लक्ष्य में शब्द को बिल्कुल वैसा ही रखें';
  @override
  String get preferredTranslation => 'पसंदीदा अनुवाद';
  @override
  String get caseSensitive => 'केस संवेदी';
}

// Path: projects.conflicts
class _TranslationsProjectsConflictsHi
    implements TranslationsProjectsConflictsEn {
  _TranslationsProjectsConflictsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String missingApiKeyTitle({required Object service}) =>
      '${service} के लिए API कुंजी गायब';
  @override
  String missingApiKeyMessage({required Object service}) =>
      'यह प्रोजेक्ट ${service} का उपयोग करता है लेकिन कोई API कुंजी कॉन्फ़िगर नहीं की गई है। सेटिंग्स > AI सेवाएँ में अपनी API कुंजी जोड़ें, या ऐप वैश्विक डिफ़ॉल्ट का उपयोग करेगा।';
  @override
  String get dismiss => 'खारिज करें';
}

// Path: projects.tm
class _TranslationsProjectsTmHi implements TranslationsProjectsTmEn {
  _TranslationsProjectsTmHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'अनुवाद यादें';
  @override
  String get description =>
      'इस प्रोजेक्ट के लिए अनुवाद स्मृति स्रोतों का प्रबंधन करें।';
  @override
  String get globalTm => 'वैश्विक अनुवाद स्मृति';
  @override
  String get globalTmDescription =>
      'अपनी ऐप सेटिंग्स से साझा अनुवाद स्मृति का उपयोग करें';
  @override
  String get linkedFiles => 'लिंक की गई फ़ाइलें (प्रोजेक्ट विशिष्ट)';
  @override
  String get noLinkedFiles => 'कोई प्रोजेक्ट-विशिष्ट फ़ाइल लिंक नहीं की गई।';
  @override
  String get addTmFile => 'TM फ़ाइल जोड़ें';
  @override
  String get useGlobalTm => 'वैश्विक TM का उपयोग करें';
  @override
  String get selectTm => 'अनुवाद स्मृति चुनें';
  @override
  String get globalTmEnabled => 'वैश्विक अनुवाद स्मृति सक्षम';
}

// Path: git.conflicts
class _TranslationsGitConflictsHi implements TranslationsGitConflictsEn {
  _TranslationsGitConflictsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'मर्ज संघर्ष का पता चला';
  @override
  String get description =>
      'जारी रखने से पहले आपको इन संघर्षों को हल करना होगा।';
  @override
  String get abortMergeTitle => 'मर्ज रद्द करें?';
  @override
  String get abortMergeContent =>
      'यह सभी मर्ज परिवर्तनों को वापस लाएगा और मर्ज से पहले की स्थिति में लौट आएगा। यह क्रिया पूर्ववत नहीं की जा सकती।';
  @override
  String get abortMergeAction => 'मर्ज रद्द करें';
  @override
  String stagingFile({required Object file}) =>
      '${file} को commit के लिए stage कर रहा है...';
  @override
  String conflictedFilesCount({required Object count}) =>
      'संघर्षित फ़ाइलें (${count})';
  @override
  String get selectFileToResolve => 'हल करने के लिए एक फ़ाइल चुनें';
  @override
  String resolvingFile({required Object file}) => 'हल कर रहा है: ${file}';
  @override
  String get keepAllOurs => 'सभी हमारे रखें (Ours)';
  @override
  String get acceptAllTheirs => 'सभी उनके स्वीकार करें (Theirs)';
  @override
  String get allResolved => 'इस फ़ाइल में सभी संघर्ष हल हो गए हैं!';
  @override
  String get markResolved => 'हल किया गया चिह्नित करें';
  @override
  String get stageForCommit => 'यह फ़ाइल को commit के लिए stage करेगा।';
  @override
  String conflictIndex({required Object index}) => 'संघर्ष #${index}';
  @override
  String get ours => 'हमारा (वर्तमान)';
  @override
  String get theirs => 'उनका (आने वाला)';
  @override
  String get keepOurs => 'हमारा रखें';
  @override
  String get acceptTheirs => 'उनका स्वीकार करें';
  @override
  String get empty => '(खाली)';
}

// Path: wizards.firstRun
class _TranslationsWizardsFirstRunHi implements TranslationsWizardsFirstRunEn {
  _TranslationsWizardsFirstRunHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get welcome => 'Localizer में आपका स्वागत है';
  @override
  String get description => 'सेकंड में अपनी स्थानीयकरण फ़ाइलों की तुलना करें।';
  @override
  String get sourceFile => 'स्रोत फ़ाइल';
  @override
  String get targetFile => 'लक्ष्य फ़ाइल';
  @override
  String get compareNow => 'अब तुलना करें';
  @override
  String get trySample => 'नमूना डेटा के साथ प्रयास करें';
  @override
  String get skip => 'सेटअप छोड़ें';
  @override
  String get browse => 'ब्राउज़ करने के लिए क्लिक करें';
  @override
  String error({required Object error}) =>
      'नमूना डेटा लोड करने में विफल: ${error}';
}

// Path: dialogs.addIgnorePattern
class _TranslationsDialogsAddIgnorePatternHi
    implements TranslationsDialogsAddIgnorePatternEn {
  _TranslationsDialogsAddIgnorePatternHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'अनदेखा पैटर्न जोड़ें';
  @override
  String get patternLabel => 'पैटर्न (regex)';
  @override
  String get hint => 'उदाहरण, ^temp_.*';
  @override
  String get invalid => 'अमान्य regex पैटर्न';
  @override
  String get testStringLabel => 'परीक्षण स्ट्रिंग';
  @override
  String get testHint =>
      'पैटर्न के विरुद्ध परीक्षण करने के लिए एक कुंजी दर्ज करें';
  @override
  String get match => '✓ पैटर्न परीक्षण स्ट्रिंग से मेल खाता है';
  @override
  String get noMatch => '✗ पैटर्न मेल नहीं खाता';
  @override
  String get add => 'जोड़ें';
  @override
  String get cancel => 'रद्द करें';
}

// Path: dialogs.diffViewer
class _TranslationsDialogsDiffViewerHi
    implements TranslationsDialogsDiffViewerEn {
  _TranslationsDialogsDiffViewerHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Diff व्यूअर';
  @override
  String get originalFile => 'मूल/संदर्भ फ़ाइल';
  @override
  String get translationFile => 'अनुवाद/तुलना फ़ाइल';
  @override
  String get base => 'आधार';
  @override
  String get target => 'लक्ष्य';
  @override
  String get added => 'जोड़ा गया';
  @override
  String get removed => 'हटाया गया';
  @override
  String get modified => 'संशोधित';
  @override
  String get noMatches => 'वर्तमान फ़िल्टर से कोई प्रविष्टियाँ मेल नहीं खातीं';
  @override
  String get clickToggle =>
      'फ़िल्टर टॉगल करने के लिए ऊपर दिए गए बैज पर क्लिक करें';
  @override
  String get clickToHide => '(छिपाने के लिए क्लिक करें)';
  @override
  String get clickToShow => '(दिखाने के लिए क्लिक करें)';
}

// Path: grid.columns
class _TranslationsGridColumnsHi implements TranslationsGridColumnsEn {
  _TranslationsGridColumnsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'कुंजी';
  @override
  String get source => 'स्रोत';
  @override
  String get status => 'स्थिति';
  @override
  String get actions => 'क्रियाएं';
}

// Path: tutorial.steps
class _TranslationsTutorialStepsHi implements TranslationsTutorialStepsEn {
  _TranslationsTutorialStepsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTutorialStepsImportSourceHi importSource =
      _TranslationsTutorialStepsImportSourceHi._(_root);
  @override
  late final _TranslationsTutorialStepsImportTargetHi importTarget =
      _TranslationsTutorialStepsImportTargetHi._(_root);
  @override
  late final _TranslationsTutorialStepsCompareHi compare =
      _TranslationsTutorialStepsCompareHi._(_root);
  @override
  late final _TranslationsTutorialStepsFilterHi filter =
      _TranslationsTutorialStepsFilterHi._(_root);
  @override
  late final _TranslationsTutorialStepsSearchHi search =
      _TranslationsTutorialStepsSearchHi._(_root);
  @override
  late final _TranslationsTutorialStepsAdvancedHi advanced =
      _TranslationsTutorialStepsAdvancedHi._(_root);
  @override
  late final _TranslationsTutorialStepsExportHi export =
      _TranslationsTutorialStepsExportHi._(_root);
}

// Path: friendlyErrors.fileNotFound
class _TranslationsFriendlyErrorsFileNotFoundHi
    implements TranslationsFriendlyErrorsFileNotFoundEn {
  _TranslationsFriendlyErrorsFileNotFoundHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'फ़ाइल या फ़ोल्डर नहीं मिला।';
  @override
  String get suggestion =>
      'जाँचें कि क्या फ़ाइल को स्थानांतरित या हटा दिया गया था।';
}

// Path: friendlyErrors.accessDenied
class _TranslationsFriendlyErrorsAccessDeniedHi
    implements TranslationsFriendlyErrorsAccessDeniedEn {
  _TranslationsFriendlyErrorsAccessDeniedHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'फ़ाइल तक पहुँच अस्वीकृत कर दी गई थी।';
  @override
  String get suggestion =>
      'ऐप को प्रशासक के रूप में चलाने का प्रयास करें या फ़ाइल अनुमतियां जांचें।';
}

// Path: friendlyErrors.isDirectory
class _TranslationsFriendlyErrorsIsDirectoryHi
    implements TranslationsFriendlyErrorsIsDirectoryEn {
  _TranslationsFriendlyErrorsIsDirectoryHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'फ़ाइल के बजाय एक फ़ोल्डर चुना गया था।';
  @override
  String get suggestion => 'कृपया एक वैध फ़ाइल चुनें।';
}

// Path: friendlyErrors.fileAccess
class _TranslationsFriendlyErrorsFileAccessHi
    implements TranslationsFriendlyErrorsFileAccessEn {
  _TranslationsFriendlyErrorsFileAccessHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'फ़ाइल तक पहुँचने में समस्या थी।';
  @override
  String get suggestion =>
      'इसे उपयोग कर रहे अन्य प्रोग्राम बंद करने का प्रयास करें।';
}

// Path: friendlyErrors.unsupportedFormat
class _TranslationsFriendlyErrorsUnsupportedFormatHi
    implements TranslationsFriendlyErrorsUnsupportedFormatEn {
  _TranslationsFriendlyErrorsUnsupportedFormatHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'यह फ़ाइल प्रारूप या ऑपरेशन समर्थित नहीं है।';
  @override
  String get suggestion =>
      'फ़ाइल एक्सटेंशन चेक करें या कोई अलग प्रारूप आज़माएं।';
}

// Path: friendlyErrors.networkError
class _TranslationsFriendlyErrorsNetworkErrorHi
    implements TranslationsFriendlyErrorsNetworkErrorEn {
  _TranslationsFriendlyErrorsNetworkErrorHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'सर्वर से कनेक्ट नहीं हो सका।';
  @override
  String get suggestion =>
      'अपने इंटरनेट कनेक्शन की जाँच करें और पुन: प्रयास करें।';
}

// Path: friendlyErrors.notGitRepo
class _TranslationsFriendlyErrorsNotGitRepoHi
    implements TranslationsFriendlyErrorsNotGitRepoEn {
  _TranslationsFriendlyErrorsNotGitRepoHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'यह फ़ोल्डर Git प्रोजेक्ट नहीं है।';
  @override
  String get suggestion =>
      'उस फ़ोल्डर में नेविगेट करें जिसमें .git डायरेक्टरी हो।';
}

// Path: friendlyErrors.mergeConflict
class _TranslationsFriendlyErrorsMergeConflictHi
    implements TranslationsFriendlyErrorsMergeConflictEn {
  _TranslationsFriendlyErrorsMergeConflictHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'रिपॉजिटरी में मर्ज संघर्ष हैं।';
  @override
  String get suggestion => 'जारी रखने से पहले संघर्षों को हल करें।';
}

// Path: friendlyErrors.gitAuthFailed
class _TranslationsFriendlyErrorsGitAuthFailedHi
    implements TranslationsFriendlyErrorsGitAuthFailedEn {
  _TranslationsFriendlyErrorsGitAuthFailedHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Git प्रमाणीकरण विफल रहा।';
  @override
  String get suggestion =>
      'सेटिंग्स > संस्करण नियंत्रण में अपने क्रेडेंशियल्स की जाँच करें।';
}

// Path: friendlyErrors.gitOperationFailed
class _TranslationsFriendlyErrorsGitOperationFailedHi
    implements TranslationsFriendlyErrorsGitOperationFailedEn {
  _TranslationsFriendlyErrorsGitOperationFailedHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Git ऑपरेशन विफल रहा।';
  @override
  String get suggestion => 'अधिक विवरण के लिए Git दृश्य देखें।';
}

// Path: friendlyErrors.invalidJson
class _TranslationsFriendlyErrorsInvalidJsonHi
    implements TranslationsFriendlyErrorsInvalidJsonEn {
  _TranslationsFriendlyErrorsInvalidJsonHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'फ़ाइल प्रारूप अमान्य या दूषित है।';
  @override
  String get suggestion => 'सुनिश्चित करें कि फ़ाइल में वैध JSON सामग्री है।';
}

// Path: friendlyErrors.rateLimitReached
class _TranslationsFriendlyErrorsRateLimitReachedHi
    implements TranslationsFriendlyErrorsRateLimitReachedEn {
  _TranslationsFriendlyErrorsRateLimitReachedHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'अनुवाद सीमा समाप्त हो गई।';
  @override
  String get suggestion =>
      'कुछ मिनट प्रतीक्षा करें या अपनी API योजना सीमाएं जांचें।';
}

// Path: friendlyErrors.invalidApiKey
class _TranslationsFriendlyErrorsInvalidApiKeyHi
    implements TranslationsFriendlyErrorsInvalidApiKeyEn {
  _TranslationsFriendlyErrorsInvalidApiKeyHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'अमान्य API कुंजी।';
  @override
  String get suggestion =>
      'अपनी API कुंजी अपडेट करने के लिए सेटिंग्स > AI अनुवाद पर जाएं।';
}

// Path: friendlyErrors.translationServiceError
class _TranslationsFriendlyErrorsTranslationServiceErrorHi
    implements TranslationsFriendlyErrorsTranslationServiceErrorEn {
  _TranslationsFriendlyErrorsTranslationServiceErrorHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'अनुवाद सेवा त्रुटि।';
  @override
  String get suggestion => 'अपनी API कुंजी और इंटरनेट कनेक्शन की जाँच करें।';
}

// Path: friendlyErrors.outOfMemory
class _TranslationsFriendlyErrorsOutOfMemoryHi
    implements TranslationsFriendlyErrorsOutOfMemoryEn {
  _TranslationsFriendlyErrorsOutOfMemoryHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message =>
      'इस ऑपरेशन को पूरा करने के लिए पर्याप्त मेमोरी नहीं है।';
  @override
  String get suggestion =>
      'अन्य एप्लिकेशन बंद करने या छोटी फ़ाइलों का उपयोग करने का प्रयास करें।';
}

// Path: friendlyErrors.genericError
class _TranslationsFriendlyErrorsGenericErrorHi
    implements TranslationsFriendlyErrorsGenericErrorEn {
  _TranslationsFriendlyErrorsGenericErrorHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'कुछ गलत हो गया।';
  @override
  String get suggestion =>
      'कृपया पुन: प्रयास करें। यदि समस्या बनी रहती है, तो ऐप को पुनरारंभ करें।';
}

// Path: diffTable.columns
class _TranslationsDiffTableColumnsHi
    implements TranslationsDiffTableColumnsEn {
  _TranslationsDiffTableColumnsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get id => '#';
  @override
  String get status => 'स्थिति';
  @override
  String get key => 'कुंजी';
  @override
  String get source => 'स्रोत';
  @override
  String get target => 'लक्ष्य';
}

// Path: diffTable.pagination
class _TranslationsDiffTablePaginationHi
    implements TranslationsDiffTablePaginationEn {
  _TranslationsDiffTablePaginationHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get show => 'दिखाएं';
}

// Path: diffTable.messages
class _TranslationsDiffTableMessagesHi
    implements TranslationsDiffTableMessagesEn {
  _TranslationsDiffTableMessagesHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get addedToTM => 'अनुवाद स्मृति में जोड़ा गया';
  @override
  String get reverted => 'प्रविष्टि वापस आ गई';
  @override
  String get deleted => 'प्रविष्टि हटाई गई';
  @override
  String get appliedAndAdded => 'लागू किया गया और TM में जोड़ा गया';
}

// Path: diffTable.editDialog
class _TranslationsDiffTableEditDialogHi
    implements TranslationsDiffTableEditDialogEn {
  _TranslationsDiffTableEditDialogHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object key}) => 'संपादित करें: ${key}';
  @override
  String get sourceLabel => 'स्रोत';
  @override
  String get targetLabel => 'लक्ष्य';
  @override
  String get hint => 'अनुवाद दर्ज करें...';
  @override
  String get cancel => 'रद्द करें';
  @override
  String get applyAndAdd => 'लागू करें और TM में जोड़ें';
  @override
  String get apply => 'लागू करें';
}

// Path: onboarding.steps
class _TranslationsOnboardingStepsHi implements TranslationsOnboardingStepsEn {
  _TranslationsOnboardingStepsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsOnboardingStepsImportFilesHi importFiles =
      _TranslationsOnboardingStepsImportFilesHi._(_root);
  @override
  late final _TranslationsOnboardingStepsRunComparisonHi runComparison =
      _TranslationsOnboardingStepsRunComparisonHi._(_root);
  @override
  late final _TranslationsOnboardingStepsReviewMissingHi reviewMissing =
      _TranslationsOnboardingStepsReviewMissingHi._(_root);
  @override
  late final _TranslationsOnboardingStepsUseFiltersHi useFilters =
      _TranslationsOnboardingStepsUseFiltersHi._(_root);
  @override
  late final _TranslationsOnboardingStepsSearchResultsHi searchResults =
      _TranslationsOnboardingStepsSearchResultsHi._(_root);
  @override
  late final _TranslationsOnboardingStepsAdvancedViewHi advancedView =
      _TranslationsOnboardingStepsAdvancedViewHi._(_root);
  @override
  late final _TranslationsOnboardingStepsEditCellHi editCell =
      _TranslationsOnboardingStepsEditCellHi._(_root);
  @override
  late final _TranslationsOnboardingStepsExportResultsHi exportResults =
      _TranslationsOnboardingStepsExportResultsHi._(_root);
}

// Path: settings.appearance.presets
class _TranslationsSettingsAppearancePresetsHi
    implements TranslationsSettingsAppearancePresetsEn {
  _TranslationsSettingsAppearancePresetsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get presetDefault => 'डिफ़ॉल्ट';
  @override
  String get presetColorblind => 'वर्णांध-अनुकूल';
  @override
  String get presetHighContrast => 'उच्च कंट्रास्ट';
  @override
  String get presetNord => 'नॉर्ड';
  @override
  String get presetSolarized => 'सोलराइज्ड';
  @override
  String get presetMonokai => 'मोनोकाई';
}

// Path: settings.appearance.preview
class _TranslationsSettingsAppearancePreviewHi
    implements TranslationsSettingsAppearancePreviewEn {
  _TranslationsSettingsAppearancePreviewHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get step3Title => 'onboarding.step3.title';
  @override
  String get connectAccount => '"अपना खाता जोड़ें"';
  @override
  String get loginHint => 'deprecated.login_hint_v1';
  @override
  String get enterCredentials => '"क्रेडेंशियल्स दर्ज करें"';
  @override
  String get ctaButton => 'checkout.cta_button';
  @override
  String get buyNow => '"अभी खरीदें"';
  @override
  String get completePurchase => '"खरीदारी पूरी करें"';
  @override
  String get appNameKey => 'common.app_name';
  @override
  String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class _TranslationsSettingsComparisonPatternPresetsHi
    implements TranslationsSettingsComparisonPatternPresetsEn {
  _TranslationsSettingsComparisonPatternPresetsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get comments => 'टिप्पणियाँ';
  @override
  String get tempKeys => 'अस्थायी कुंजी';
  @override
  String get placeholders => 'प्लेसहोल्डर';
  @override
  String get devOnly => 'केवल देव';
}

// Path: settings.comparison.previewMatch
class _TranslationsSettingsComparisonPreviewMatchHi
    implements TranslationsSettingsComparisonPreviewMatchEn {
  _TranslationsSettingsComparisonPreviewMatchHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'पूर्वावलोकन मिलान';
  @override
  String get description =>
      'परीक्षण करें कि आपकी वर्तमान सेटिंग्स मिलान तर्क को कैसे प्रभावित करती हैं।';
  @override
  String get stringA => 'स्ट्रिंग A';
  @override
  String get stringB => 'स्ट्रिंग B';
  @override
  String get enterText => 'पाठ दर्ज करें...';
  @override
  String get similarity => 'समानता';
  @override
  String get identical => 'समान';
  @override
  String get identicalDescription =>
      'सामान्यीकरण के बाद स्ट्रिंग्स बिल्कुल मेल खाती हैं।';
  @override
  String get ignored => 'अनदेखा किया गया';
  @override
  String get ignoredDescription => 'इनपुट एक अनदेखा पैटर्न से मेल खाता है।';
  @override
  String get different => 'अलग';
  @override
  String get differentDescription => 'एक मान खाली है।';
  @override
  String get similarModified => 'समान / संशोधित';
  @override
  String similarModifiedDescription({required Object threshold}) =>
      'मैच स्कोर सीमा (${threshold}%) से ऊपर है।';
  @override
  String get newDifferent => 'नया / अलग';
  @override
  String newDifferentDescription({required Object threshold}) =>
      'मैच स्कोर सीमा (${threshold}%) से नीचे है।';
}

// Path: settings.comparison.colorPresets
class _TranslationsSettingsComparisonColorPresetsHi
    implements TranslationsSettingsComparisonColorPresetsEn {
  _TranslationsSettingsComparisonColorPresetsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get kDefault => 'डिफ़ॉल्ट';
  @override
  String get colorblindFriendly => 'वर्णांध-अनुकूल';
  @override
  String get highContrast => 'उच्च कंट्रास्ट';
  @override
  String get nord => 'नॉर्ड';
  @override
  String get solarized => 'सोलराइज्ड';
  @override
  String get monokai => 'मोनोकाई';
  @override
  String get presetDefault => 'डिफ़ॉल्ट';
  @override
  String get presetColorblind => 'वर्णांध-अनुकूल';
  @override
  String get presetHighContrast => 'उच्च कंट्रास्ट';
  @override
  String get presetNord => 'नॉर्ड';
  @override
  String get presetSolarized => 'सोलराइज्ड';
  @override
  String get presetMonokai => 'मोनोकाई';
}

// Path: settings.integrations.materials
class _TranslationsSettingsIntegrationsMaterialsHi
    implements TranslationsSettingsIntegrationsMaterialsEn {
  _TranslationsSettingsIntegrationsMaterialsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get sidebar => 'साइडबार';
  @override
  String get menu => 'मेनू';
  @override
  String get popover => 'पॉपओवर';
  @override
  String get titlebar => 'टाइटल बार';
  @override
  String get underPageBackground => 'पृष्ठ पृष्ठभूमि';
  @override
  String get contentBackground => 'सामग्री';
}

// Path: settings.integrations.fileTypes
class _TranslationsSettingsIntegrationsFileTypesHi
    implements TranslationsSettingsIntegrationsFileTypesEn {
  _TranslationsSettingsIntegrationsFileTypesHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get loc => 'Localizer प्रोजेक्ट फ़ाइल';
  @override
  String get lang => 'भाषा फ़ाइल';
  @override
  String get json => 'JSON स्थानीयकरण फ़ाइल';
  @override
  String get xml => 'XML स्थानीयकरण फ़ाइल';
}

// Path: settings.developer.themePlaygroundSection
class _TranslationsSettingsDeveloperThemePlaygroundSectionHi
    implements TranslationsSettingsDeveloperThemePlaygroundSectionEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get colors => 'रंग';
  @override
  String get typography => 'टाइपोग्राफी';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteHi
      palette =
      _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteHi._(_root);
}

// Path: settings.developer.featureFlags
class _TranslationsSettingsDeveloperFeatureFlagsHi
    implements TranslationsSettingsDeveloperFeatureFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'प्रयोगात्मक सुविधाएँ';
  @override
  String get description =>
      'परीक्षण के लिए स्थानीय रूप से फीचर झंडे टॉगल करें। ये ओवरराइड ऐप पुनरारंभ करने पर बने रहते हैं।';
  @override
  String get subtitle => 'प्रयोगात्मक सुविधाओं को ओवरराइड करें';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsHi flags =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsHi._(_root);
  @override
  String get reset => 'सभी झंडे रीसेट करें';
  @override
  String get overrides => 'स्थानीय ओवरराइड';
  @override
  String get defaultVal => 'डिफ़ॉल्ट';
  @override
  String get on => 'चालू';
  @override
  String get off => 'बंद';
}

// Path: settings.developer.storageInspectorSection
class _TranslationsSettingsDeveloperStorageInspectorSectionHi
    implements TranslationsSettingsDeveloperStorageInspectorSectionEn {
  _TranslationsSettingsDeveloperStorageInspectorSectionHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'ताज़ा करें';
  @override
  String get hiveData => 'Hive डेटा';
  @override
  String get secureStorage => 'सुरक्षित भंडारण';
}

// Path: settings.developer.deviceInfoSection
class _TranslationsSettingsDeveloperDeviceInfoSectionHi
    implements TranslationsSettingsDeveloperDeviceInfoSectionEn {
  _TranslationsSettingsDeveloperDeviceInfoSectionHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'ताज़ा करें';
  @override
  String get copy => 'क्लिपबोर्ड पर कॉपी करें';
  @override
  String get computerName => 'कंप्यूटर का नाम';
  @override
  String get osVersion => 'OS संस्करण';
}

// Path: settings.developer.localizationInspectorSection
class _TranslationsSettingsDeveloperLocalizationInspectorSectionHi
    implements TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
  _TranslationsSettingsDeveloperLocalizationInspectorSectionHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get showKeys => 'मानों के बजाय कुंजियाँ दिखाएं';
  @override
  String get keysVisible => 'कुंजियाँ दृश्यमान';
  @override
  String get normalDisplay => 'सामान्य प्रदर्शन';
  @override
  String get note =>
      'नोट: इस सुविधा के लिए ऐप स्थानीयकरण को एक रैपर का उपयोग करने की आवश्यकता है जो इस सेटिंग का सम्मान करता है।';
}

// Path: settings.onboarding.steps
class _TranslationsSettingsOnboardingStepsHi
    implements TranslationsSettingsOnboardingStepsEn {
  _TranslationsSettingsOnboardingStepsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsOnboardingStepsImportFilesHi importFiles =
      _TranslationsSettingsOnboardingStepsImportFilesHi._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsRunComparisonHi runComparison =
      _TranslationsSettingsOnboardingStepsRunComparisonHi._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsReviewMissingHi reviewMissing =
      _TranslationsSettingsOnboardingStepsReviewMissingHi._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsUseFiltersHi useFilters =
      _TranslationsSettingsOnboardingStepsUseFiltersHi._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsSearchResultsHi searchResults =
      _TranslationsSettingsOnboardingStepsSearchResultsHi._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsAdvancedViewHi advancedView =
      _TranslationsSettingsOnboardingStepsAdvancedViewHi._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsEditCellHi editCell =
      _TranslationsSettingsOnboardingStepsEditCellHi._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsExportResultsHi exportResults =
      _TranslationsSettingsOnboardingStepsExportResultsHi._(_root);
}

// Path: settings.settingsView.categories
class _TranslationsSettingsSettingsViewCategoriesHi
    implements TranslationsSettingsSettingsViewCategoriesEn {
  _TranslationsSettingsSettingsViewCategoriesHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'सामान्य सेटिंग्स';
  @override
  String get comparisonEngine => 'तुलना इंजन';
  @override
  String get appearance => 'दिखावट';
  @override
  String get fileHandling => 'फ़ाइल हैंडलिंग';
  @override
  String get aiServices => 'एआई सेवाएँ';
  @override
  String get systemIntegrations => 'सिस्टम एकीकरण';
  @override
  String get projectResources => 'प्रोजेक्ट संसाधन (शब्दावली और TM)';
  @override
  String get developer => 'डेवलपर विकल्प';
  @override
  String get about => 'के बारे में';
}

// Path: settings.settingsView.categoryLabels
class _TranslationsSettingsSettingsViewCategoryLabelsHi
    implements TranslationsSettingsSettingsViewCategoryLabelsEn {
  _TranslationsSettingsSettingsViewCategoryLabelsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'सामान्य';
  @override
  String get comparisonEngine => 'तुलना';
  @override
  String get appearance => 'दिखावट';
  @override
  String get fileHandling => 'फ़ाइल हैंडलिंग';
  @override
  String get aiServices => 'एआई सेवाएँ';
  @override
  String get systemIntegrations => 'सिस्टम एकीकरण';
  @override
  String get projectResources => 'प्रोजेक्ट संसाधन';
  @override
  String get developer => 'डेवलपर विकल्प';
  @override
  String get about => 'के बारे में';
}

// Path: advancedDiff.sidebar.actionsSection
class _TranslationsAdvancedDiffSidebarActionsSectionHi
    implements TranslationsAdvancedDiffSidebarActionsSectionEn {
  _TranslationsAdvancedDiffSidebarActionsSectionHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get exportMatches => 'मैच निर्यात करें';
  @override
  String get preview => 'पूर्वावलोकन';
  @override
  String get fillFromTmTitle => 'अनुवाद स्मृति से भरें?';
  @override
  String get fillFromTmContent =>
      'यह अनुवाद स्मृति से मिलान का उपयोग करके खाली लक्ष्य मानों को भरने का प्रयास करेगा। मौजूदा मान अधिलिखित नहीं किए जाएंगे।';
  @override
  String get fill => 'भरें';
  @override
  String get fillFromMemory => 'मेमोरी से भरें';
  @override
  String filledFromTm({required Object count}) =>
      'अनुवाद स्मृति से ${count} आइटम भरे गए।';
}

// Path: advancedDiff.sidebar.aiSection
class _TranslationsAdvancedDiffSidebarAiSectionHi
    implements TranslationsAdvancedDiffSidebarAiSectionEn {
  _TranslationsAdvancedDiffSidebarAiSectionHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get infoCloud =>
      'स्रोत से खाली लक्ष्य मानों का अनुवाद करने के लिए क्लाउड अनुवाद का उपयोग करता है।';
  @override
  String get infoAi =>
      'स्रोत से खाली लक्ष्य मानों का अनुवाद करने के लिए एआई का उपयोग करता है।';
  @override
  String get translationSettings => 'अनुवाद सेटिंग्स';
  @override
  String get aiSettings => 'एआई सेटिंग्स';
  @override
  String get source => 'स्रोत';
  @override
  String get target => 'लक्ष्य';
  @override
  String translatingProgress({required Object percent}) =>
      'अनुवाद हो रहा है... ${percent}%';
  @override
  String get translating => 'अनुवाद हो रहा है...';
  @override
  String get translateAllMissing => 'सभी लापता अनुवाद करें';
  @override
  String get translateAllTitle => 'सभी लापता अनुवाद करें?';
  @override
  String translateAllContent(
          {required Object source,
          required Object target,
          required Object service}) =>
      'यह ${source} से ${target} तक खाली लक्ष्य मानों वाली सभी प्रविष्टियों का अनुवाद करने के लिए ${service} का उपयोग करेगा।\n\nआप प्रत्येक सुझाव की समीक्षा कर सकते हैं या सभी को एक साथ लागू कर सकते हैं।';
  @override
  String get translateAll => 'सभी अनुवाद करें';
  @override
  String get reviewEach => 'प्रत्येक की समीक्षा करें';
  @override
  String cloudTranslated({required Object count}) =>
      'क्लाउड अनुवाद के साथ ${count} प्रविष्टियों का अनुवाद किया गया।';
  @override
  String aiTranslated({required Object count}) =>
      'एआई के साथ ${count} प्रविष्टियों का अनुवाद किया गया।';
  @override
  String get aiTranslateFailed => 'एआई सभी अनुवाद विफल';
  @override
  String get noMissingEntries => 'अनुवाद करने के लिए कोई लापता प्रविष्टि नहीं।';
  @override
  String get skip => 'छोड़ें';
  @override
  String get stop => 'रोकें';
  @override
  String cloudApplied({required Object count}) => '${count} सुझाव लागू किए गए।';
  @override
  String aiApplied({required Object count}) =>
      '${count} एआई सुझाव लागू किए गए।';
}

// Path: advancedDiff.sidebar.tmSection
class _TranslationsAdvancedDiffSidebarTmSectionHi
    implements TranslationsAdvancedDiffSidebarTmSectionEn {
  _TranslationsAdvancedDiffSidebarTmSectionHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get enableTmFill => 'TM भराव सक्षम करें';
  @override
  String get autoApplyAboveMinimum => 'न्यूनतम से ऊपर ऑटो-लागू करें';
  @override
  String get matchSettings => 'मैच सेटिंग्स';
  @override
  String get minMatch => 'मिन मैच:';
  @override
  String get limit => 'सीमा:';
  @override
  String get exact => 'सटीक';
}

// Path: advancedDiff.sidebar.filtersSection
class _TranslationsAdvancedDiffSidebarFiltersSectionHi
    implements TranslationsAdvancedDiffSidebarFiltersSectionEn {
  _TranslationsAdvancedDiffSidebarFiltersSectionHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get viewFilters => 'फ़िल्टर देखें';
  @override
  String get showAll => 'सभी दिखाएं';
  @override
  String get added => 'जोड़ा गया';
  @override
  String get removed => 'हटाया गया';
  @override
  String get modified => 'संशोधित';
  @override
  String get actionScope => 'क्रिया स्कोप';
  @override
  String get applyToAdded => 'जोड़े गए पर लागू करें';
  @override
  String get applyToModified => 'संशोधित पर लागू करें';
  @override
  String get onlyFillEmptyTargets => 'केवल खाली लक्ष्य भरें';
  @override
  String get limitToVisible => 'दृश्यमान तक सीमित करें';
  @override
  String get editMode => 'संपादन मोड';
  @override
  String get dialog => 'संवाद';
  @override
  String get inline => 'इनलाइन';
}

// Path: advancedDiff.sidebar.similaritySection
class _TranslationsAdvancedDiffSidebarSimilaritySectionHi
    implements TranslationsAdvancedDiffSidebarSimilaritySectionEn {
  _TranslationsAdvancedDiffSidebarSimilaritySectionHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get currentFilter => 'वर्तमान फ़िल्टर:';
  @override
  String get any => 'कोई भी';
  @override
  String get high => 'उच्च';
  @override
  String get medium => 'मध्यम';
  @override
  String get low => 'कम';
}

// Path: advancedDiff.sidebar.statusSection
class _TranslationsAdvancedDiffSidebarStatusSectionHi
    implements TranslationsAdvancedDiffSidebarStatusSectionEn {
  _TranslationsAdvancedDiffSidebarStatusSectionHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String total({required Object count}) => '${count} कुल';
  @override
  String extra({required Object count}) => '${count} अतिरिक्त';
  @override
  String missing({required Object count}) => '${count} लापता';
  @override
  String changed({required Object count}) => '${count} बदला गया';
}

// Path: tutorial.steps.importSource
class _TranslationsTutorialStepsImportSourceHi
    implements TranslationsTutorialStepsImportSourceEn {
  _TranslationsTutorialStepsImportSourceHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => '1. स्रोत फ़ाइल आयात करें';
  @override
  String get description =>
      'फ़ाइल के लिए ब्राउज़ करने के लिए नीचे दिए गए बटन का उपयोग करें, या हाइलाइट किए गए क्षेत्र पर खींचें और छोड़ें।';
}

// Path: tutorial.steps.importTarget
class _TranslationsTutorialStepsImportTargetHi
    implements TranslationsTutorialStepsImportTargetEn {
  _TranslationsTutorialStepsImportTargetHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => '2. लक्ष्य फ़ाइल आयात करें';
  @override
  String get description =>
      'फ़ाइल के लिए ब्राउज़ करने के लिए नीचे दिए गए बटन का उपयोग करें, या हाइलाइट किए गए क्षेत्र पर खींचें और छोड़ें।';
}

// Path: tutorial.steps.compare
class _TranslationsTutorialStepsCompareHi
    implements TranslationsTutorialStepsCompareEn {
  _TranslationsTutorialStepsCompareHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => '3. फ़ाइलों की तुलना करें';
  @override
  String get description =>
      'तुलना चलाने और परिणाम देखने के लिए नीचे दिए गए बटन को टैप करें।';
}

// Path: tutorial.steps.filter
class _TranslationsTutorialStepsFilterHi
    implements TranslationsTutorialStepsFilterEn {
  _TranslationsTutorialStepsFilterHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => '4. परिणाम फ़िल्टर करें';
  @override
  String get description =>
      'जोड़े गए, हटाए गए, या संशोधित स्ट्रिंग्स को देखने के लिए इन फ़िल्टर का उपयोग करें।';
}

// Path: tutorial.steps.search
class _TranslationsTutorialStepsSearchHi
    implements TranslationsTutorialStepsSearchEn {
  _TranslationsTutorialStepsSearchHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => '5. खोज परिणाम';
  @override
  String get description =>
      'खोज बार का उपयोग करके विशिष्ट कुंजियाँ या मान खोजें।';
}

// Path: tutorial.steps.advanced
class _TranslationsTutorialStepsAdvancedHi
    implements TranslationsTutorialStepsAdvancedEn {
  _TranslationsTutorialStepsAdvancedHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => '6. उन्नत दृश्य';
  @override
  String get description =>
      'संपादन, एआई अनुवाद, और अधिक के साथ विस्तृत अंतर दृश्य खोलें।';
}

// Path: tutorial.steps.export
class _TranslationsTutorialStepsExportHi
    implements TranslationsTutorialStepsExportEn {
  _TranslationsTutorialStepsExportHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => '7. परिणाम निर्यात करें';
  @override
  String get description =>
      'अपनी तुलना को CSV, JSON, या Excel फ़ाइल के रूप में सहेजें।';
}

// Path: onboarding.steps.importFiles
class _TranslationsOnboardingStepsImportFilesHi
    implements TranslationsOnboardingStepsImportFilesEn {
  _TranslationsOnboardingStepsImportFilesHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'फ़ाइलें आयात करें';
  @override
  String get description =>
      'तुलना करने के लिए अपनी स्रोत और लक्ष्य स्थानीयकरण फ़ाइलें लोड करें';
}

// Path: onboarding.steps.runComparison
class _TranslationsOnboardingStepsRunComparisonHi
    implements TranslationsOnboardingStepsRunComparisonEn {
  _TranslationsOnboardingStepsRunComparisonHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'तुलना चलाएं';
  @override
  String get description =>
      'अंतर और लापता कुंजियों को खोजने के लिए फ़ाइलों की तुलना शुरू करें';
}

// Path: onboarding.steps.reviewMissing
class _TranslationsOnboardingStepsReviewMissingHi
    implements TranslationsOnboardingStepsReviewMissingEn {
  _TranslationsOnboardingStepsReviewMissingHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'लापता समीक्षा करें';
  @override
  String get description =>
      'उन प्रविष्टियों की जाँच करें जो लक्ष्य फ़ाइल में गायब हैं';
}

// Path: onboarding.steps.useFilters
class _TranslationsOnboardingStepsUseFiltersHi
    implements TranslationsOnboardingStepsUseFiltersEn {
  _TranslationsOnboardingStepsUseFiltersHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'फ़िल्टर का उपयोग करें';
  @override
  String get description =>
      'स्थिति, श्रेणी या खोज शब्द द्वारा परिणाम फ़िल्टर करें';
}

// Path: onboarding.steps.searchResults
class _TranslationsOnboardingStepsSearchResultsHi
    implements TranslationsOnboardingStepsSearchResultsEn {
  _TranslationsOnboardingStepsSearchResultsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'खोज परिणाम';
  @override
  String get description =>
      'विशिष्ट कुंजियाँ या अनुवाद खोजने के लिए खोज बार का उपयोग करें';
}

// Path: onboarding.steps.advancedView
class _TranslationsOnboardingStepsAdvancedViewHi
    implements TranslationsOnboardingStepsAdvancedViewEn {
  _TranslationsOnboardingStepsAdvancedViewHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'उन्नत दृश्य';
  @override
  String get description =>
      'विस्तृत साइड-बाय-साइड तुलना के लिए उन्नत दृश्य पर स्विच करें';
}

// Path: onboarding.steps.editCell
class _TranslationsOnboardingStepsEditCellHi
    implements TranslationsOnboardingStepsEditCellEn {
  _TranslationsOnboardingStepsEditCellHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'प्रविष्टियाँ संपादित करें';
  @override
  String get description => 'सीधे अनुवाद संपादित करने के लिए सेल पर क्लिक करें';
}

// Path: onboarding.steps.exportResults
class _TranslationsOnboardingStepsExportResultsHi
    implements TranslationsOnboardingStepsExportResultsEn {
  _TranslationsOnboardingStepsExportResultsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'परिणाम निर्यात करें';
  @override
  String get description => 'अपने परिवर्तन सहेजें या तुलना परिणाम निर्यात करें';
}

// Path: settings.developer.themePlaygroundSection.palette
class _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteHi
    implements TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get primary => 'प्राथमिक';
  @override
  String get onPrimary => 'प्राथमिक पर';
  @override
  String get secondary => 'द्वितीयक';
  @override
  String get onSecondary => 'द्वितीयक पर';
  @override
  String get surface => 'सतह';
  @override
  String get onSurface => 'सतह पर';
  @override
  String get error => 'त्रुटि';
  @override
  String get onError => 'त्रुटि पर';
  @override
  String get outline => 'रूपरेखा';
  @override
  String get shadow => 'छाया';
  @override
  String get success => 'सफलता';
  @override
  String get warning => 'चेतावनी';
  @override
  String get info => 'जानकारी';
}

// Path: settings.developer.featureFlags.flags
class _TranslationsSettingsDeveloperFeatureFlagsFlagsHi
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchHi
      experimental_ai_batch =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchHi._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmHi
      new_diff_algorithm =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmHi._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchHi
      enhanced_search =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchHi._(_root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveHi
      auto_save =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveHi._(_root);
}

// Path: settings.onboarding.steps.importFiles
class _TranslationsSettingsOnboardingStepsImportFilesHi
    implements TranslationsSettingsOnboardingStepsImportFilesEn {
  _TranslationsSettingsOnboardingStepsImportFilesHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'फ़ाइलें आयात करें';
  @override
  String get description => 'स्रोत और लक्ष्य फ़ाइलें लोड करें';
}

// Path: settings.onboarding.steps.runComparison
class _TranslationsSettingsOnboardingStepsRunComparisonHi
    implements TranslationsSettingsOnboardingStepsRunComparisonEn {
  _TranslationsSettingsOnboardingStepsRunComparisonHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'तुलना चलाएं';
  @override
  String get description => '"फ़ाइलों की तुलना करें" पर क्लिक करें';
}

// Path: settings.onboarding.steps.reviewMissing
class _TranslationsSettingsOnboardingStepsReviewMissingHi
    implements TranslationsSettingsOnboardingStepsReviewMissingEn {
  _TranslationsSettingsOnboardingStepsReviewMissingHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'लापता कुंजियों की समीक्षा करें';
  @override
  String get description => 'लाल MISSING आइटम देखें';
}

// Path: settings.onboarding.steps.useFilters
class _TranslationsSettingsOnboardingStepsUseFiltersHi
    implements TranslationsSettingsOnboardingStepsUseFiltersEn {
  _TranslationsSettingsOnboardingStepsUseFiltersHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'फ़िल्टर का उपयोग करें';
  @override
  String get description => 'प्रकार के अनुसार फ़िल्टर करें';
}

// Path: settings.onboarding.steps.searchResults
class _TranslationsSettingsOnboardingStepsSearchResultsHi
    implements TranslationsSettingsOnboardingStepsSearchResultsEn {
  _TranslationsSettingsOnboardingStepsSearchResultsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'खोज परिणाम';
  @override
  String get description => 'विशिष्ट कुंजियाँ खोजें';
}

// Path: settings.onboarding.steps.advancedView
class _TranslationsSettingsOnboardingStepsAdvancedViewHi
    implements TranslationsSettingsOnboardingStepsAdvancedViewEn {
  _TranslationsSettingsOnboardingStepsAdvancedViewHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'उन्नत दृश्य';
  @override
  String get description => 'विस्तृत विश्लेषण का अन्वेषण करें';
}

// Path: settings.onboarding.steps.editCell
class _TranslationsSettingsOnboardingStepsEditCellHi
    implements TranslationsSettingsOnboardingStepsEditCellEn {
  _TranslationsSettingsOnboardingStepsEditCellHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'एक सेल संपादित करें';
  @override
  String get description => 'मान संपादित करने के लिए क्लिक करें';
}

// Path: settings.onboarding.steps.exportResults
class _TranslationsSettingsOnboardingStepsExportResultsHi
    implements TranslationsSettingsOnboardingStepsExportResultsEn {
  _TranslationsSettingsOnboardingStepsExportResultsHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'निर्यात';
  @override
  String get description => 'अपनी रिपोर्ट सहेजें';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchHi
    implements
        TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchHi._(
      this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'प्रयोगात्मक एआई बैच';
  @override
  String get description => 'कई पंक्तियों के लिए बैच एआई अनुवाद सक्षम करें';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmHi
    implements
        TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmHi._(
      this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'नया तुलना एल्गोरिथ्म';
  @override
  String get description => 'तुलना के लिए बेहतर डिफ़ एलगोरिदम का उपयोग करें';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchHi
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'संवर्धित खोज';
  @override
  String get description => 'अनुवाद फ़ाइलों में फजी खोज सक्षम करें';
}

// Path: settings.developer.featureFlags.flags.auto_save
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveHi
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveHi._(this._root);

  final TranslationsHi _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'ऑटो सेव';
  @override
  String get description => 'संपादन के बाद परिवर्तन स्वचालित रूप से सहेजें';
}

/// The flat map containing all translations for locale <hi>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsHi {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
          'app.title' => 'Localization Comparison Tool',
          'app.name' => 'Localizer',
          'common.save' => 'सहेजें',
          'common.cancel' => 'रद्द करें',
          'common.close' => 'बंद करें',
          'common.delete' => 'हटाएं',
          'common.edit' => 'संपादित करें',
          'common.add' => 'जोड़ें',
          'common.search' => 'खोजें',
          'common.undo' => 'पूर्ववत करें',
          'common.loading' => 'लोड हो रहा है...',
          'common.error' => 'त्रुटि',
          'common.success' => 'सफल',
          'common.warning' => 'चेतावनी',
          'common.info' => 'जानकारी',
          'common.confirm' => 'पुष्टि करें',
          'common.yes' => 'हाँ',
          'common.no' => 'नहीं',
          'common.ok' => 'ठीक है',
          'common.retry' => 'पुनः प्रयास करें',
          'common.copyText' => 'कॉपी करें',
          'common.appName' => 'Localizer',
          'common.copied' => 'कॉपी किया गया!',
          'common.enabled' => 'सक्षम',
          'common.disabled' => 'अक्षम',
          'common.browse' => 'ब्राउज़ करें',
          'common.clear' => 'साफ़ करें',
          'common.apply' => 'लागू करें',
          'common.reset' => 'रीसेट करें',
          'common.refresh' => 'ताज़ा करें',
          'common.export' => 'निर्यात करें',
          'common.import' => 'आयात करें',
          'common.select' => 'चुनें',
          'common.selectAll' => 'सभी चुनें',
          'common.deselectAll' => 'सभी को अचयनित करें',
          'common.noResults' => 'कोई परिणाम नहीं मिला',
          'common.emptyState' => 'यहाँ अभी कुछ नहीं है',
          'common.open' => 'खोलें',
          'common.change' => 'बदलें',
          'common.original' => 'मूल',
          'common.kNew' => 'नया',
          'common.remove' => 'निकालें',
          'common.auto' => 'स्वचालित',
          'common.execute' => 'निष्पादित करें',
          'common.run' => 'चलाएं',
          'common.unknown' => 'अज्ञात',
          'common.download' => 'डाउनलोड करें',
          'common.dropdownArrow' => 'ड्रॉपडाउन तीर',
          'common.openInNewWindow' => 'नई विंडो में खुलता है',
          'common.resetToDefaults' => 'डिफ़ॉल्ट पर रीसेट करें',
          'menu.file' => 'फ़ाइल',
          'menu.edit' => 'संपादित करें',
          'menu.view' => 'दृश्य',
          'menu.help' => 'मदद',
          'menu.openFiles' => 'फ़ाइलें खोलें...',
          'menu.openFolder' => 'फ़ोल्डर खोलें...',
          'menu.exportResults' => 'परिणाम निर्यात करें...',
          'menu.undo' => 'पूर्ववत करें',
          'menu.redo' => 'फिर से करें',
          'menu.cut' => 'काटें',
          'menu.paste' => 'चिपकाएं',
          'menu.selectAll' => 'सभी चुनें',
          'menu.zoomIn' => 'ज़ूम इन',
          'menu.zoomOut' => 'ज़ूम आउट',
          'menu.resetZoom' => 'ज़ूम रीसेट करें',
          'menu.documentation' => 'दस्तावेज़ीकरण',
          'menu.reportIssue' => 'समस्या की रिपोर्ट करें',
          'menu.about' => ({required Object appName}) =>
              '${appName} के बारे में',
          'nav.compare' => 'तुलना करें',
          'nav.history' => 'इतिहास',
          'nav.settings' => 'सेटिंग्स',
          'nav.projects' => 'प्रोजेक्ट्स',
          'nav.dashboard' => 'डैशबोर्ड',
          'nav.directory' => 'डायरेक्टरी',
          'nav.repository' => 'रिपॉजिटरी',
          'nav.tooltipCompare' => 'स्थानीयकरण फ़ाइलों की तुलना करें',
          'nav.tooltipHistory' => 'तुलना इतिहास देखें',
          'nav.tooltipSettings' => 'ऐप सेटिंग्स',
          'nav.tooltipProjects' => 'प्रोजेक्ट्स प्रबंधित करें',
          'nav.tooltipThemeToggle' => 'थीम टॉगल करें',
          'nav.tooltipDebugConsole' => 'डिबग कंसोल',
          'settings.title' => 'सेटिंग्स',
          'settings.appSettings' => 'ऐप सेटिंग्स',
          'settings.projectSettings' => 'प्रोजेक्ट सेटिंग्स',
          'settings.appearance.title' => 'दिखावट',
          'settings.appearance.description' =>
            'ऐप के रूप और अहसास को अनुकूलित करें',
          'settings.appearance.theme' => 'थीम मोड',
          'settings.appearance.themeDescription' =>
            'लाइट, डार्क या सिस्टम थीम के बीच चुनें',
          'settings.appearance.themeSystem' => 'सिस्टम',
          'settings.appearance.themeLight' => 'लाइट',
          'settings.appearance.themeDark' => 'डार्क',
          'settings.appearance.themeAmoled' => 'एमोलेड',
          'settings.appearance.accentColor' => 'एक्सेंट रंग',
          'settings.appearance.accentColorDescription' =>
            'अपना पसंदीदा एक्सेंट रंग चुनें',
          'settings.appearance.useMicaEffect' => 'माइका प्रभाव का उपयोग करें',
          'settings.appearance.micaDescription' =>
            'आधुनिक रूप के लिए Windows 11 माइका पारदर्शिता सक्षम करें',
          'settings.appearance.diffFontSize' => 'तुलना फ़ॉन्ट आकार',
          'settings.appearance.diffFontSizeDescription' =>
            'तुलना दृश्य के फ़ॉन्ट आकार को समायोजित करें',
          'settings.appearance.diffFontFamily' => 'तुलना फ़ॉन्ट परिवार',
          'settings.appearance.diffFontFamilyDescription' =>
            'तुलना दृश्य के लिए फ़ॉन्ट',
          'settings.appearance.systemDefault' => 'सिस्टम डिफ़ॉल्ट',
          'settings.appearance.pickAccentColor' => 'एक्सेंट रंग चुनें',
          'settings.appearance.diffColors' => 'तुलना रंग',
          'settings.appearance.presetsTitle' => 'प्रीसेट',
          'settings.appearance.presets.presetDefault' => 'डिफ़ॉल्ट',
          'settings.appearance.presets.presetColorblind' => 'वर्णांध-अनुकूल',
          'settings.appearance.presets.presetHighContrast' => 'उच्च कंट्रास्ट',
          'settings.appearance.presets.presetNord' => 'नॉर्ड',
          'settings.appearance.presets.presetSolarized' => 'सोलराइज्ड',
          'settings.appearance.presets.presetMonokai' => 'मोनोकाई',
          'settings.appearance.identical' => 'समान',
          'settings.appearance.pickColorFor' => ({required Object label}) =>
              '${label} के लिए रंग चुनें',
          'settings.appearance.livePreview' => 'लाइव पूर्वावलोकन',
          'settings.appearance.preview.step3Title' => 'onboarding.step3.title',
          'settings.appearance.preview.connectAccount' => '"अपना खाता जोड़ें"',
          'settings.appearance.preview.loginHint' => 'deprecated.login_hint_v1',
          'settings.appearance.preview.enterCredentials' =>
            '"क्रेडेंशियल्स दर्ज करें"',
          'settings.appearance.preview.ctaButton' => 'checkout.cta_button',
          'settings.appearance.preview.buyNow' => '"अभी खरीदें"',
          'settings.appearance.preview.completePurchase' =>
            '"खरीदारी पूरी करें"',
          'settings.appearance.preview.appNameKey' => 'common.app_name',
          'settings.appearance.preview.appNameValue' => '"Localizer"',
          'settings.general.title' => 'सामान्य',
          'settings.general.description' => 'सामान्य एप्लिकेशन सेटिंग्स',
          'settings.general.language' => 'भाषा',
          'settings.general.languageDescription' => 'अपनी पसंदीदा भाषा चुनें',
          'settings.general.startMinimized' => 'ट्रे में छोटा करके शुरू करें',
          'settings.general.startMinimizedDescription' =>
            'सिस्टम ट्रे में छोटा करके ऐप शुरू करें',
          'settings.general.rememberWindowPosition' => 'विंडो स्थिति याद रखें',
          'settings.general.rememberWindowPositionDescription' =>
            'स्टार्टअप पर विंडो आकार और स्थिति बहाल करें',
          'settings.general.openLastProject' =>
            'स्टार्टअप पर पिछला प्रोजेक्ट खोलें',
          'settings.general.openLastProjectDescription' =>
            'ऐप शुरू होने पर स्वचालित रूप से अंतिम उपयोग किया गया प्रोजेक्ट खोलें',
          'settings.general.application' => 'एप्लिकेशन',
          'settings.general.defaultView' => 'डिफ़ॉल्ट दृश्य',
          'settings.general.defaultViewDescription' =>
            'स्टार्टअप पर दिखने वाला दृश्य',
          'settings.general.autoCheckUpdates' => 'अपडेट ऑटो-चेक करें',
          'settings.general.autoCheckUpdatesDescription' =>
            'स्टार्टअप पर अपडेट के लिए जाँचें',
          'settings.general.startupOptions' => 'स्टार्टअप विकल्प',
          'settings.general.languageAuto' => 'स्वतः-पहचान',
          'settings.general.viewBasic' => 'फ़ाइल तुलना',
          'settings.general.viewHistory' => 'इतिहास',
          'settings.general.viewDashboard' => 'गुणवत्ता डैशबोर्ड',
          'settings.general.viewDirectory' => 'डायरेक्टरी तुलना',
          'settings.general.viewLastUsed' => 'अंतिम उपयोग किया गया दृश्य',
          'settings.scope.title' => 'सेटिंग्स स्कोप',
          'settings.scope.global' => 'वैश्विक डिफ़ॉल्ट',
          'settings.scope.project' => 'प्रोजेक्ट',
          'settings.scope.reset' =>
            'प्रोजेक्ट को वैश्विक डिफ़ॉल्ट पर रीसेट करें',
          'settings.scope.resetConfirmation' =>
            'यह इस प्रोजेक्ट के लिए सभी ओवरराइड को साफ़ कर देगा और वैश्विक डिफ़ॉल्ट पर वापस आ जाएगा। यह क्रिया पूर्ववत नहीं की जा सकती।',
          'settings.scope.globalDescription' =>
            'परिवर्तन सभी प्रोजेक्ट्स पर लागू होते हैं जब तक कि ओवरराइड न किया गया हो।',
          'settings.scope.projectDescription' => ({required Object name}) =>
              'परिवर्तन केवल "${name}" पर लागू होते हैं। अन्य सेटिंग्स वैश्विक डिफ़ॉल्ट से विरासत में मिलती हैं।',
          'settings.scope.createPrompt' =>
            'विशिष्ट फ़ोल्डरों के लिए सेटिंग्स अनुकूलित करने के लिए एक प्रोजेक्ट बनाएं',
          'settings.searchKeywords.general.0' => 'भाषा',
          'settings.searchKeywords.general.1' => 'डिफ़ॉल्ट दृश्य',
          'settings.searchKeywords.general.2' => 'हालिया फ़ाइलें गिनती',
          'settings.searchKeywords.general.3' => 'पिछला प्रोजेक्ट खोलें',
          'settings.searchKeywords.general.4' =>
            'बाहर निकलने से पहले पुष्टि करें',
          'settings.searchKeywords.general.5' => 'सूचनाएं दिखाएं',
          'settings.searchKeywords.comparisonEngine.0' => 'तुलना मोड',
          'settings.searchKeywords.comparisonEngine.1' => 'समानता सीमा',
          'settings.searchKeywords.comparisonEngine.2' => 'केस संवेदी',
          'settings.searchKeywords.comparisonEngine.3' =>
            'व्हाइटस्पेस अनदेखा करें',
          'settings.searchKeywords.comparisonEngine.4' =>
            'खाली लाइनें अनदेखा करें',
          'settings.searchKeywords.comparisonEngine.5' =>
            'टिप्पणियाँ अनदेखा करें',
          'settings.searchKeywords.comparisonEngine.6' => 'पैटर्न अनदेखा करें',
          'settings.searchKeywords.appearance.0' => 'थीम',
          'settings.searchKeywords.appearance.1' => 'थीम मोड',
          'settings.searchKeywords.appearance.2' => 'एक्सेंट रंग',
          'settings.searchKeywords.appearance.3' => 'तुलना फ़ॉन्ट आकार',
          'settings.searchKeywords.appearance.4' => 'तुलना फ़ॉन्ट परिवार',
          'settings.searchKeywords.appearance.5' => 'तुलना रंग',
          'settings.searchKeywords.appearance.6' => 'जोड़ा गया रंग',
          'settings.searchKeywords.appearance.7' => 'हटाया गया रंग',
          'settings.searchKeywords.appearance.8' => 'संशोधित रंग',
          'settings.searchKeywords.appearance.9' => 'समान रंग',
          'settings.searchKeywords.appearance.10' => 'रंग प्रीसेट',
          'settings.searchKeywords.appearance.11' => 'पूर्वावलोकन',
          'settings.searchKeywords.fileHandling.0' => 'स्रोत प्रारूप',
          'settings.searchKeywords.fileHandling.1' => 'लक्ष्य प्रारूप',
          'settings.searchKeywords.fileHandling.2' => 'डिफ़ॉल्ट एन्कोडिंग',
          'settings.searchKeywords.fileHandling.3' => 'हालिया प्रोजेक्ट गिनती',
          'settings.searchKeywords.fileHandling.4' => 'अनुवाद मेमोरी',
          'settings.searchKeywords.fileHandling.5' => 'मेमोरी आयात करें',
          'settings.searchKeywords.fileHandling.6' => 'मेमोरी निर्यात करें',
          'settings.searchKeywords.fileHandling.7' => 'मेमोरी साफ़ करें',
          'settings.searchKeywords.aiServices.0' => 'OpenAI API कुंजी',
          'settings.searchKeywords.aiServices.1' => 'Anthropic API कुंजी',
          'settings.searchKeywords.aiServices.2' => 'Google AI API कुंजी',
          'settings.searchKeywords.aiServices.3' => 'AI मॉडल',
          'settings.searchKeywords.aiServices.4' => 'तापमान',
          'settings.searchKeywords.aiServices.5' => 'कस्टम प्रॉम्प्ट',
          'settings.searchKeywords.systemIntegrations.0' => 'सिस्टम ट्रे',
          'settings.searchKeywords.systemIntegrations.1' =>
            'छोटा करके शुरू करें',
          'settings.searchKeywords.systemIntegrations.2' => 'फ़ाइल एसोसिएशन',
          'settings.searchKeywords.systemIntegrations.3' => 'माइका प्रभाव',
          'settings.searchKeywords.systemIntegrations.4' => 'वाइब्रेंसी',
          'settings.searchKeywords.systemIntegrations.5' => 'विंडो सामग्री',
          'settings.searchKeywords.systemIntegrations.6' => 'डॉक बैज',
          'settings.searchKeywords.systemIntegrations.7' =>
            'अनुवादित नहीं गिनती',
          'settings.searchKeywords.projectResources.0' => 'शब्दावली',
          'settings.searchKeywords.projectResources.1' => 'अनुवाद मेमोरी',
          'settings.searchKeywords.projectResources.2' => 'शब्दावली',
          'settings.searchKeywords.about.0' => 'संस्करण',
          'settings.searchKeywords.about.1' => 'अपडेट जाँचें',
          'settings.searchKeywords.about.2' => 'ऑटो अपडेट',
          'settings.searchKeywords.about.3' => 'चेंजलॉग',
          'settings.searchKeywords.about.4' => 'लाइसेंस',
          'settings.searchKeywords.about.5' => 'गोपनीयता नीति',
          'settings.searchKeywords.about.6' => 'टेलीमेट्री',
          'settings.searchKeywords.about.7' => 'क्रैश रिपोर्टिंग',
          'settings.searchKeywords.developer.0' => 'प्रदर्शन ओवरले',
          'settings.searchKeywords.developer.1' => 'सिमेंटिक्स डिबगर',
          'settings.searchKeywords.developer.2' => 'मटेरियल ग्रिड',
          'settings.searchKeywords.developer.3' => 'रास्टर कैश',
          'settings.searchKeywords.developer.4' => 'ट्यूटोरियल पुनः आरंभ करें',
          'settings.searchKeywords.developer.5' => 'फ़ैक्टरी रीसेट',
          'settings.comparison.title' => 'तुलना',
          'settings.comparison.description' =>
            'तुलना व्यवहार को कॉन्फ़िगर करें',
          'settings.comparison.caseSensitive' => 'केस संवेदी',
          'settings.comparison.caseSensitiveDescription' =>
            'बड़े और छोटे अक्षरों को अलग मानें',
          'settings.comparison.ignoreWhitespace' => 'व्हाइटस्पेस अनदेखा करें',
          'settings.comparison.ignoreWhitespaceDescription' =>
            'तुलना करते समय आगे/पीछे के व्हाइटस्पेस को अनदेखा करें',
          'settings.comparison.showLineNumbers' => 'लाइन नंबर दिखाएं',
          'settings.comparison.showLineNumbersDescription' =>
            'डिफ़ दृश्य में लाइन नंबर प्रदर्शित करें',
          'settings.comparison.behavior' => 'तुलना व्यवहार',
          'settings.comparison.ignoreCase' => 'केस अनदेखा करें',
          'settings.comparison.ignoreCaseDescription' =>
            '"Key" और "key" को समान मानें',
          'settings.comparison.similarityThreshold' => 'समानता सीमा',
          'settings.comparison.similarityThresholdDescription' =>
            '"संशोधित" पता लगाने के लिए न्यूनतम समानता',
          'settings.comparison.mode' => 'तुलना मोड',
          'settings.comparison.modeDescription' =>
            'फ़ाइलों के बीच प्रविष्टियों का मिलान कैसे करें',
          'settings.comparison.modeKey' => 'की-आधारित',
          'settings.comparison.modeKeyDescription' =>
            'कुंजी नाम से मेल खाता है (डिफ़ॉल्ट)।',
          'settings.comparison.modeOrder' => 'क्रम-आधारित',
          'settings.comparison.modeOrderDescription' =>
            'फ़ाइल में स्थिति के अनुसार मेल खाता है।',
          'settings.comparison.modeSmart' => 'स्मार्ट मैच',
          'settings.comparison.modeSmartDescription' =>
            'स्थानांतरित/नामित कुंजियों का पता लगाता है।',
          'settings.comparison.ignorePatterns' => 'पैटर्न अनदेखा करें',
          'settings.comparison.noIgnorePatterns' =>
            'कोई अनदेखा पैटर्न सेट नहीं।',
          'settings.comparison.addPattern' => 'पैटर्न जोड़ें',
          'settings.comparison.resetToGlobal' =>
            'सभी तुलना सेटिंग्स को वैश्विक डिफ़ॉल्ट पर रीसेट करें',
          'settings.comparison.patternPresets.comments' => 'टिप्पणियाँ',
          'settings.comparison.patternPresets.tempKeys' => 'अस्थायी कुंजी',
          'settings.comparison.patternPresets.placeholders' => 'प्लेसहोल्डर',
          'settings.comparison.patternPresets.devOnly' => 'केवल देव',
          'settings.comparison.previewMatch.title' => 'पूर्वावलोकन मिलान',
          'settings.comparison.previewMatch.description' =>
            'परीक्षण करें कि आपकी वर्तमान सेटिंग्स मिलान तर्क को कैसे प्रभावित करती हैं।',
          'settings.comparison.previewMatch.stringA' => 'स्ट्रिंग A',
          'settings.comparison.previewMatch.stringB' => 'स्ट्रिंग B',
          'settings.comparison.previewMatch.enterText' => 'पाठ दर्ज करें...',
          'settings.comparison.previewMatch.similarity' => 'समानता',
          'settings.comparison.previewMatch.identical' => 'समान',
          'settings.comparison.previewMatch.identicalDescription' =>
            'सामान्यीकरण के बाद स्ट्रिंग्स बिल्कुल मेल खाती हैं।',
          'settings.comparison.previewMatch.ignored' => 'अनदेखा किया गया',
          'settings.comparison.previewMatch.ignoredDescription' =>
            'इनपुट एक अनदेखा पैटर्न से मेल खाता है।',
          'settings.comparison.previewMatch.different' => 'अलग',
          'settings.comparison.previewMatch.differentDescription' =>
            'एक मान खाली है।',
          'settings.comparison.previewMatch.similarModified' =>
            'समान / संशोधित',
          'settings.comparison.previewMatch.similarModifiedDescription' => (
                  {required Object threshold}) =>
              'मैच स्कोर सीमा (${threshold}%) से ऊपर है।',
          'settings.comparison.previewMatch.newDifferent' => 'नया / अलग',
          'settings.comparison.previewMatch.newDifferentDescription' => (
                  {required Object threshold}) =>
              'मैच स्कोर सीमा (${threshold}%) से नीचे है।',
          'settings.comparison.colorPresets.kDefault' => 'डिफ़ॉल्ट',
          'settings.comparison.colorPresets.colorblindFriendly' =>
            'वर्णांध-अनुकूल',
          'settings.comparison.colorPresets.highContrast' => 'उच्च कंट्रास्ट',
          'settings.comparison.colorPresets.nord' => 'नॉर्ड',
          'settings.comparison.colorPresets.solarized' => 'सोलराइज्ड',
          'settings.comparison.colorPresets.monokai' => 'मोनोकाई',
          'settings.comparison.colorPresets.presetDefault' => 'डिफ़ॉल्ट',
          'settings.comparison.colorPresets.presetColorblind' =>
            'वर्णांध-अनुकूल',
          'settings.comparison.colorPresets.presetHighContrast' =>
            'उच्च कंट्रास्ट',
          'settings.comparison.colorPresets.presetNord' => 'नॉर्ड',
          'settings.comparison.colorPresets.presetSolarized' => 'सोलराइज्ड',
          'settings.comparison.colorPresets.presetMonokai' => 'मोनोकाई',
          'settings.fileHandling.fileFormats' => 'फ़ाइल प्रारूप',
          'settings.fileHandling.sourceFormat' => 'स्रोत प्रारूप',
          'settings.fileHandling.targetFormat' => 'लक्ष्य प्रारूप',
          'settings.fileHandling.encoding' => 'एन्कोडिंग',
          'settings.fileHandling.sourceEncoding' => 'स्रोत एन्कोडिंग',
          'settings.fileHandling.targetEncoding' => 'लक्ष्य एन्कोडिंग',
          'settings.fileHandling.autoDetect' => 'स्वतः-पहचान',
          'settings.fileHandling.autoDetectEncodingDescription' =>
            'फ़ाइल एन्कोडिंग का स्वचालित रूप से पता लगाएं',
          'settings.fileHandling.exportSettings' => 'निर्यात सेटिंग्स',
          'settings.fileHandling.defaultExportFormat' =>
            'डिफ़ॉल्ट निर्यात प्रारूप',
          'settings.fileHandling.includeUtf8Bom' => 'UTF-8 BOM शामिल करें',
          'settings.fileHandling.includeUtf8BomDescription' =>
            'Excel संगतता के लिए आवश्यक',
          'settings.fileHandling.openFolderAfterExport' =>
            'निर्यात के बाद फ़ोल्डर खोलें',
          'settings.fileHandling.fileSafety' => 'फ़ाइल सुरक्षा',
          'settings.fileHandling.fileSafetyDescription' =>
            'आपदा रिकवरी के लिए स्वचालित स्थानीय प्रतियां।',
          'settings.fileHandling.resetToGlobal' =>
            'सभी फ़ाइल हैंडलिंग सेटिंग्स को वैश्विक डिफ़ॉल्ट पर रीसेट करें',
          'settings.translationMemory.title' => 'वैश्विक अनुवाद स्मृति',
          'settings.translationMemory.autoLearn' => 'स्वतः-सीखें',
          'settings.translationMemory.autoLearnDescription' =>
            'भविष्य के पुन: उपयोग के लिए स्थानीय मेमोरी में अनुवाद सहेजें',
          'settings.translationMemory.confidenceThreshold' => 'विश्वास सीमा',
          'settings.translationMemory.confidenceThresholdDescription' => (
                  {required Object percent}) =>
              'स्वचालित रूप से लागू करने के लिए न्यूनतम स्कोर (${percent}%)',
          'settings.translationMemory.entries' => 'प्रविष्टियाँ',
          'settings.translationMemory.size' => 'साइज',
          'settings.translationMemory.memorySize' => ({required Object size}) =>
              'मेमोरी साइज: ${size}',
          'settings.translationMemory.import' => 'आयात करें',
          'settings.translationMemory.exportTmx' => 'TMX निर्यात करें',
          'settings.translationMemory.exportCsv' => 'CSV निर्यात करें',
          'settings.translationMemory.clearMemory' => 'मेमोरी साफ़ करें',
          'settings.translationMemory.importedItems' => (
                  {required Object count}) =>
              'मेमोरी में ${count} आइटम आयात किए गए।',
          'settings.translationMemory.noItemsAdded' =>
            'कोई आइटम नहीं जोड़ा गया।',
          'settings.translationMemory.nothingToExport' =>
            'अभी निर्यात करने के लिए कुछ नहीं है।',
          'settings.translationMemory.tmxSaved' => 'TMX सहेजा गया',
          'settings.translationMemory.csvSaved' => 'CSV सहेजा गया',
          'settings.translationMemory.clearConfirmTitle' =>
            'अनुवाद स्मृति साफ़ करें?',
          'settings.translationMemory.clearConfirmContent' =>
            'यह इस डिवाइस पर सभी सहेजे गए अनुवाद जोड़े हटा देता है। यह क्रिया पूर्ववत नहीं की जा सकती।',
          'settings.translationMemory.cleared' => 'अनुवाद स्मृति साफ़ की गई।',
          'settings.translationMemory.couldNotClear' =>
            'मेमोरी साफ़ नहीं कर सका।',
          'settings.backup.title' => 'ऑटो-बैकअप',
          'settings.backup.description' => 'स्वचालित बैकअप सेटिंग्स',
          'settings.backup.enabled' => 'ऑटो-बैकअप सक्षम करें',
          'settings.backup.enabledDescription' =>
            'बदलाव करने से पहले स्वचालित रूप से फ़ाइलों का बैकअप लें',
          'settings.backup.maxCopies' => 'अधिकतम बैकअप प्रतियां',
          'settings.backup.maxCopiesDescription' =>
            'प्रति फ़ाइल रखने के लिए बैकअप प्रतियों की संख्या',
          'settings.backup.activeStatus' => ({required Object count}) =>
              'सक्रिय · ${count} प्रतियां रख रहा है',
          'settings.backup.folder' => 'बैकअप फ़ोल्डर',
          'settings.backup.folderDescription' =>
            'उसी फ़ोल्डर का उपयोग करने के लिए खाली छोड़ें',
          'settings.backup.useOriginalFolder' =>
            'मूल फ़ाइल फ़ोल्डर का उपयोग करें',
          'settings.ai.title' => 'एआई सेवाएँ',
          'settings.ai.description' => 'एआई अनुवाद और सहायता कॉन्फ़िगर करें',
          'settings.ai.provider' => 'एआई प्रदाता',
          'settings.ai.providerDescription' =>
            'अपना पसंदीदा एआई सेवा प्रदाता चुनें',
          'settings.ai.apiKey' => 'API कुंजी',
          'settings.ai.apiKeyDescription' =>
            'चयनित प्रदाता के लिए अपनी API कुंजी दर्ज करें',
          'settings.ai.apiKeyPlaceholder' => 'API कुंजी दर्ज करें...',
          'settings.ai.testConnection' => 'कनेक्शन का परीक्षण करें',
          'settings.ai.connectionSuccess' => 'कनेक्शन सफल!',
          'settings.ai.connectionFailed' =>
            'कनेक्शन विफल। कृपया अपनी API कुंजी जांचें।',
          'settings.ai.translationStrategy' => 'अनुवाद रणनीति',
          'settings.ai.strategy' => 'रणनीति',
          'settings.ai.strategyDescription' =>
            'चुनें कि आप स्ट्रिंग्स का अनुवाद कैसे करना चाहते हैं',
          'settings.ai.strategyLLM' => 'जनरेटिव एआई (LLM)',
          'settings.ai.strategyCloud' => 'क्लाउड अनुवाद',
          'settings.ai.enableAiTranslation' => 'एआई अनुवाद सक्षम करें',
          'settings.ai.enableAiTranslationDescription' =>
            'ऐप को अनुवाद सुझावों के लिए एआई का उपयोग करने की अनुमति दें',
          'settings.ai.llmProvider' => 'LLM सेवा प्रदाता',
          'settings.ai.service' => 'सेवा',
          'settings.ai.serviceDescription' => 'जनरेटिव एआई के लिए प्रदाता',
          'settings.ai.providerGemini' => 'Google Gemini',
          'settings.ai.providerOpenAI' => 'OpenAI',
          'settings.ai.geminiApiKey' => 'Gemini API कुंजी',
          'settings.ai.openAiApiKey' => 'OpenAI API कुंजी',
          'settings.ai.model' => 'मॉडल',
          'settings.ai.modelDescription' =>
            'चुनें कि कौन सा मॉडल उपयोग करना है',
          'settings.ai.advancedParameters' => 'उन्नत पैरामीटर',
          'settings.ai.parameters' => 'पैरामीटर',
          'settings.ai.parametersDescription' => 'तापमान, संदर्भ, और अधिक',
          'settings.ai.temperature' => 'तापमान',
          'settings.ai.temperatureDescription' =>
            'उच्च मान आउटपुट को अधिक रचनात्मक बनाते हैं',
          'settings.ai.maxTokens' => 'अधिकतम टोकन',
          'settings.ai.maxTokensDescription' => 'संदर्भ विंडो लंबाई सीमित करें',
          'settings.ai.systemContext' => 'सिस्टम संदर्भ / निर्देश',
          'settings.ai.systemContextHint' =>
            'आप एक पेशेवर स्थानीयकरणकर्ता हैं। मूल स्ट्रिंग के टोन और आशय को बनाए रखें...',
          'settings.ai.systemContextHelper' =>
            'अपने प्रोजेक्ट की शैली और शब्दावली के बारे में एआई को विशिष्ट निर्देश प्रदान करें।',
          'settings.ai.contextStrings' => 'संदर्भ स्ट्रिंग्स',
          'settings.ai.contextStringsDescription' =>
            'बेहतर संदर्भ के लिए आसपास की स्ट्रिंग्स शामिल करें',
          'settings.ai.contextCount' => 'संदर्भ गिनती',
          'settings.ai.contextCountDescription' =>
            'शामिल करने के लिए आसपास की स्ट्रिंग्स की संख्या',
          'settings.ai.cloudServices' => 'क्लाउड अनुवाद सेवाएँ',
          'settings.ai.googleTranslateApiKey' => 'Google Translate API कुंजी',
          'settings.ai.deeplApiKey' => 'DeepL API कुंजी',
          'settings.ai.test' => 'परीक्षण',
          'settings.ai.resetToGlobal' =>
            'सभी एआई सेटिंग्स को वैश्विक डिफ़ॉल्ट पर रीसेट करें',
          'settings.integrations.platformNotice' => 'प्लेटफ़ॉर्म नोटिस',
          'settings.integrations.platformNoticeDescription' =>
            'सिस्टम एकीकरण इस प्लेटफ़ॉर्म के लिए उपलब्ध नहीं हैं।',
          'settings.integrations.visualEffects' => 'दृश्य प्रभाव',
          'settings.integrations.explorerIntegration' => 'एक्सप्लोरर एकीकरण',
          'settings.integrations.explorerIntegrationDescription' =>
            'फ़ोल्डरों के लिए Windows एक्सप्लोरर राइट-क्लिक मेनू में "Localizer के साथ खोलें" जोड़ें।',
          'settings.integrations.addToContextMenu' => 'संदर्भ मेनू में जोड़ें',
          'settings.integrations.contextMenuAdded' => 'संदर्भ मेनू जोड़ा गया!',
          'settings.integrations.contextMenuAddError' =>
            'संदर्भ मेनू जोड़ने में विफल',
          'settings.integrations.contextMenuRemoved' =>
            'संदर्भ मेनू हटाया गया!',
          'settings.integrations.contextMenuRemoveError' =>
            'संदर्भ मेनू हटाने में विफल',
          'settings.integrations.fileAssociations' => 'फ़ाइल एसोसिएशन',
          'settings.integrations.fileAssociationsDescription' =>
            'एक्स्प्लोरर में डबल-क्लिक करने पर Localizer के साथ खोलने के लिए फ़ाइल प्रकार पंजीकृत करें।',
          'settings.integrations.registered' => 'पंजीकृत',
          'settings.integrations.notRegistered' => 'पंजीकृत नहीं',
          'settings.integrations.extRegistered' => ({required Object ext}) =>
              '${ext} पंजीकृत!',
          'settings.integrations.extUnregistered' => ({required Object ext}) =>
              '${ext} अपंजीकृत!',
          'settings.integrations.extError' => (
                  {required Object action, required Object ext}) =>
              '${action} ${ext} में विफल',
          'settings.integrations.registerAll' => 'सभी पंजीकृत करें',
          'settings.integrations.unregisterAll' => 'सभी अपंजीकृत करें',
          'settings.integrations.registerAllResult' => (
                  {required Object total, required Object success}) =>
              '${total} फ़ाइल प्रकारों में से ${success} पंजीकृत',
          'settings.integrations.unregisterAllResult' => (
                  {required Object total, required Object success}) =>
              '${total} फ़ाइल प्रकारों में से ${success} अपंजीकृत',
          'settings.integrations.protocolHandler' => 'प्रोटोकॉल हैंडलर',
          'settings.integrations.protocolHandlerDescription' =>
            'इस एप्लिकेशन को खोलने के लिए localizer:// URL पंजीकृत करें। ब्राउज़र लिंक या अन्य ऐप्स से सीधे प्रोजेक्ट खोलने की अनुमति देता है।',
          'settings.integrations.protocolRegistered' =>
            'प्रोटोकॉल हैंडलर पंजीकृत है',
          'settings.integrations.protocolNotRegistered' =>
            'प्रोटोकॉल हैंडलर पंजीकृत नहीं है',
          'settings.integrations.registerProtocol' => 'प्रोटोकॉल पंजीकृत करें',
          'settings.integrations.unregister' => 'अपंजीकृत करें',
          'settings.integrations.protocolRegisteredSuccess' =>
            'प्रोटोकॉल हैंडलर पंजीकृत!',
          'settings.integrations.protocolRemovedSuccess' =>
            'प्रोटोकॉल हैंडलर हटाया गया!',
          'settings.integrations.protocolRegisterError' =>
            'पंजीकृत करने में विफल',
          'settings.integrations.protocolRemoveError' => 'हटाने में विफल',
          'settings.integrations.windowMaterial' => 'विंडो सामग्री',
          'settings.integrations.windowMaterialDescription' =>
            'macOS वाइब्रेंसी सामग्री शैली का चयन करें',
          'settings.integrations.dockIntegration' => 'डॉक एकीकरण',
          'settings.integrations.showDockBadge' => 'अनुवादित नहीं गिनती दिखाएं',
          'settings.integrations.showDockBadgeDescription' =>
            'डॉक आइकन बैज पर अनुवादित नहीं स्ट्रिंग गिनती प्रदर्शित करें',
          'settings.integrations.materials.sidebar' => 'साइडबार',
          'settings.integrations.materials.menu' => 'मेनू',
          'settings.integrations.materials.popover' => 'पॉपओवर',
          'settings.integrations.materials.titlebar' => 'टाइटल बार',
          'settings.integrations.materials.underPageBackground' =>
            'पृष्ठ पृष्ठभूमि',
          'settings.integrations.materials.contentBackground' => 'सामग्री',
          'settings.integrations.fileTypes.loc' => 'Localizer प्रोजेक्ट फ़ाइल',
          'settings.integrations.fileTypes.lang' => 'भाषा फ़ाइल',
          'settings.integrations.fileTypes.json' => 'JSON स्थानीयकरण फ़ाइल',
          'settings.integrations.fileTypes.xml' => 'XML स्थानीयकरण फ़ाइल',
          'settings.developer.title' => 'डेवलपर सेटिंग्स',
          'settings.developer.description' => 'डेवलपर्स के लिए उन्नत सेटिंग्स',
          'settings.developer.showLocalizationKeys' =>
            'स्थानीयकरण कुंजियाँ दिखाएं',
          'settings.developer.localizationKeysDescription' =>
            'सक्षम होने पर, सभी अनुवादित पाठ अनुवादित मान के बजाय अपनी स्थानीयकरण कुंजियाँ दिखाएंगे। यह सत्यापित करने के लिए उपयोगी है कि कौन सी कुंजी कहाँ उपयोग की जाती है।',
          'settings.developer.showPerformanceOverlay' =>
            'प्रदर्शन ओवरले दिखाएं',
          'settings.developer.performanceOverlayDescription' =>
            'FPS और फ्रेम समय की जानकारी प्रदर्शित करें',
          'settings.developer.debugMode' => 'डिबग मोड',
          'settings.developer.debugModeDescription' =>
            'अतिरिक्त लॉगिंग और डिबग सुविधाएं सक्षम करें',
          'settings.developer.debuggingTools' => 'डिबगिंग उपकरण',
          'settings.developer.semanticsDebugger' => 'सिमेंटिक्स डिबगर',
          'settings.developer.semanticsDebuggerDescription' =>
            'सिमेंटिक्स ट्री विज़ुअलाइज़ करें',
          'settings.developer.materialGrid' => 'मटेरियल ग्रिड',
          'settings.developer.materialGridDescription' =>
            'मटेरियल लेआउट ग्रिड ओवरले करें',
          'settings.developer.rasterCache' => 'रास्टर कैश छवियां',
          'settings.developer.rasterCacheDescription' =>
            'चेकरबोर्ड रास्टर कैश छवियां',
          'settings.developer.actions' => 'क्रियाएं',
          'settings.developer.showLogs' => 'ऐप लॉग दिखाएं',
          'settings.developer.showLogsDescription' => 'Talker डिबग कंसोल खोलें',
          'settings.developer.restartTutorial' =>
            'ओनबोर्डिंग ट्यूटोरियल पुनः आरंभ करें',
          'settings.developer.restartTutorialDescription' =>
            'झंडे रीसेट करें और ट्यूटोरियल फिर से लॉन्च करें',
          'settings.developer.restartRequested' =>
            'ट्यूटोरियल पुनः आरंभ का अनुरोध किया गया।',
          'settings.developer.throwException' => 'परीक्षण अपवाद फेंकें',
          'settings.developer.throwExceptionDescription' =>
            'क्रैश रिपोर्टिंग के लिए परीक्षण अपवाद ट्रिगर करें',
          'settings.developer.testExceptionMessage' =>
            'डेवलपर विकल्पों से परीक्षण अपवाद ट्रिगर किया गया',
          'settings.developer.clearTM' => 'अनुवाद स्मृति साफ़ करें',
          'settings.developer.clearTMDescription' =>
            'सभी कैश किए गए अनुवाद हटाएं',
          'settings.developer.clearTMConfirmation' =>
            'अनुवाद स्मृति साफ़ करें?',
          'settings.developer.clearTMWarning' =>
            'यह सभी सीखे गए अनुवादों को हटा देगा। यह क्रिया पूर्ववत नहीं की जा सकती।',
          'settings.developer.tmCleared' => 'अनुवाद स्मृति साफ़ की गई',
          'settings.developer.clearApiKeys' => 'API कुंजियाँ साफ़ करें',
          'settings.developer.clearApiKeysDescription' =>
            'सभी संग्रहीत API कुंजियाँ हटाएं',
          'settings.developer.clearApiKeysConfirmation' =>
            'API कुंजियाँ साफ़ करें?',
          'settings.developer.clearApiKeysWarning' =>
            'यह सुरक्षित भंडारण से सभी API कुंजियों को हटा देगा।',
          'settings.developer.apiKeysCleared' => 'API कुंजियाँ साफ़ की गईं',
          'settings.developer.hideOptions' => 'डेवलपर विकल्प छिपाएं',
          'settings.developer.hideOptionsDescription' =>
            'डेवलपर मोड अक्षम करें (पुनः सक्षम करने के लिए 7 टैप की आवश्यकता है)',
          'settings.developer.optionsDisabled' => 'डेवलपर विकल्प अक्षम',
          'settings.developer.dangerZone' => 'खतरा क्षेत्र',
          'settings.developer.factoryReset' => 'फ़ैक्टरी रीसेट',
          'settings.developer.factoryResetDescription' =>
            'सभी सेटिंग्स रीसेट करें और डेटा साफ़ करें',
          'settings.developer.factoryResetWarning' =>
            'क्या आप वाकई सभी सेटिंग्स रीसेट करना चाहते हैं? यह क्रिया पूर्ववत नहीं की जा सकती।',
          'settings.developer.inspectionTools' => 'निरीक्षण उपकरण',
          'settings.developer.searchHint' => 'सेटिंग्स खोजें...',
          'settings.developer.resetToDefault' => 'डिफ़ॉल्ट पर रीसेट करें',
          'settings.developer.resetToGlobal' =>
            'वैश्विक डिफ़ॉल्ट पर रीसेट करें',
          'settings.developer.storageInspector' => 'भंडारण निरीक्षक',
          'settings.developer.storageInspectorDescription' =>
            'Hive और सुरक्षित भंडारण सामग्री देखें',
          'settings.developer.deviceEnvironment' => 'डिवाइस और पर्यावरण',
          'settings.developer.deviceEnvironmentDescription' =>
            'स्क्रीन, प्लेटफ़ॉर्म और बिल्ड जानकारी',
          'settings.developer.themePlayground' => 'थीम खेल का मैदान',
          'settings.developer.themePlaygroundDescription' =>
            'रंग पैलेट और टाइपोग्राफी',
          'settings.developer.themePlaygroundSection.colors' => 'रंग',
          'settings.developer.themePlaygroundSection.typography' =>
            'टाइपोग्राफी',
          'settings.developer.themePlaygroundSection.palette.primary' =>
            'प्राथमिक',
          'settings.developer.themePlaygroundSection.palette.onPrimary' =>
            'प्राथमिक पर',
          'settings.developer.themePlaygroundSection.palette.secondary' =>
            'द्वितीयक',
          'settings.developer.themePlaygroundSection.palette.onSecondary' =>
            'द्वितीयक पर',
          'settings.developer.themePlaygroundSection.palette.surface' => 'सतह',
          'settings.developer.themePlaygroundSection.palette.onSurface' =>
            'सतह पर',
          'settings.developer.themePlaygroundSection.palette.error' => 'त्रुटि',
          'settings.developer.themePlaygroundSection.palette.onError' =>
            'त्रुटि पर',
          'settings.developer.themePlaygroundSection.palette.outline' =>
            'रूपरेखा',
          'settings.developer.themePlaygroundSection.palette.shadow' => 'छाया',
          'settings.developer.themePlaygroundSection.palette.success' =>
            'सफलता',
          'settings.developer.themePlaygroundSection.palette.warning' =>
            'चेतावनी',
          'settings.developer.themePlaygroundSection.palette.info' => 'जानकारी',
          'settings.developer.localizationInspector' => 'स्थानीयकरण निरीक्षक',
          'settings.developer.localizationInspectorDescription' =>
            'अनुवाद स्ट्रिंग्स डिबग करें',
          'settings.developer.hiveAppSettings' => 'Hive (AppSettings)',
          'settings.developer.secureStorageMasked' =>
            'सुरक्षित भंडारण (मास्क किया गया)',
          'settings.developer.featureFlags.title' => 'प्रयोगात्मक सुविधाएँ',
          'settings.developer.featureFlags.description' =>
            'परीक्षण के लिए स्थानीय रूप से फीचर झंडे टॉगल करें। ये ओवरराइड ऐप पुनरारंभ करने पर बने रहते हैं।',
          'settings.developer.featureFlags.subtitle' =>
            'प्रयोगात्मक सुविधाओं को ओवरराइड करें',
          'settings.developer.featureFlags.flags.experimental_ai_batch.name' =>
            'प्रयोगात्मक एआई बैच',
          'settings.developer.featureFlags.flags.experimental_ai_batch.description' =>
            'कई पंक्तियों के लिए बैच एआई अनुवाद सक्षम करें',
          'settings.developer.featureFlags.flags.new_diff_algorithm.name' =>
            'नया तुलना एल्गोरिथ्म',
          'settings.developer.featureFlags.flags.new_diff_algorithm.description' =>
            'तुलना के लिए बेहतर डिफ़ एलगोरिदम का उपयोग करें',
          'settings.developer.featureFlags.flags.enhanced_search.name' =>
            'संवर्धित खोज',
          'settings.developer.featureFlags.flags.enhanced_search.description' =>
            'अनुवाद फ़ाइलों में फजी खोज सक्षम करें',
          'settings.developer.featureFlags.flags.auto_save.name' => 'ऑटो सेव',
          'settings.developer.featureFlags.flags.auto_save.description' =>
            'संपादन के बाद परिवर्तन स्वचालित रूप से सहेजें',
          'settings.developer.featureFlags.reset' => 'सभी झंडे रीसेट करें',
          'settings.developer.featureFlags.overrides' => 'स्थानीय ओवरराइड',
          'settings.developer.featureFlags.defaultVal' => 'डिफ़ॉल्ट',
          'settings.developer.featureFlags.on' => 'चालू',
          'settings.developer.featureFlags.off' => 'बंद',
          'settings.developer.storageInspectorSection.refresh' => 'ताज़ा करें',
          'settings.developer.storageInspectorSection.hiveData' => 'Hive डेटा',
          'settings.developer.storageInspectorSection.secureStorage' =>
            'सुरक्षित भंडारण',
          'settings.developer.deviceInfoSection.refresh' => 'ताज़ा करें',
          'settings.developer.deviceInfoSection.copy' =>
            'क्लिपबोर्ड पर कॉपी करें',
          'settings.developer.deviceInfoSection.computerName' =>
            'कंप्यूटर का नाम',
          'settings.developer.deviceInfoSection.osVersion' => 'OS संस्करण',
          'settings.developer.localizationInspectorSection.showKeys' =>
            'मानों के बजाय कुंजियाँ दिखाएं',
          'settings.developer.localizationInspectorSection.keysVisible' =>
            'कुंजियाँ दृश्यमान',
          'settings.developer.localizationInspectorSection.normalDisplay' =>
            'सामान्य प्रदर्शन',
          'settings.developer.localizationInspectorSection.note' =>
            'नोट: इस सुविधा के लिए ऐप स्थानीयकरण को एक रैपर का उपयोग करने की आवश्यकता है जो इस सेटिंग का सम्मान करता है।',
          'settings.about.title' => 'के बारे में',
          'settings.about.version' => 'संस्करण',
          'settings.about.buildNumber' => 'बिल्ड नंबर',
          'settings.about.author' => 'लेखक',
          _ => null,
        } ??
        switch (path) {
          'settings.about.license' => 'लाइसेंस',
          'settings.about.sourceCode' => 'स्रोत कोड',
          'settings.about.reportBug' => 'बग की रिपोर्ट करें',
          'settings.about.requestFeature' => 'सुविधा का अनुरोध करें',
          'settings.about.checkForUpdates' => 'अपडेट के लिए जाँचें',
          'settings.about.upToDate' => 'आप अप-टू-डेट हैं!',
          'settings.about.updateAvailable' => ({required Object version}) =>
              'अपडेट उपलब्ध: ${version}',
          'settings.about.updateAvailableBadge' => 'अपडेट उपलब्ध!',
          'settings.about.developerSteps' => ({required Object count}) =>
              'आप डेवलपर होने से ${count} कदम दूर हैं।',
          'settings.about.developerActivated' => 'आप अब एक डेवलपर हैं!',
          'settings.about.neverChecked' => 'कभी नहीं',
          'settings.about.applicationInfo' => 'एप्लिकेशन जानकारी',
          'settings.about.platform' => 'प्लेटफ़ॉर्म',
          'settings.about.updateInformation' => 'अपडेट जानकारी',
          'settings.about.currentVersion' => 'वर्तमान संस्करण',
          'settings.about.latestVersion' => 'नवीनतम संस्करण',
          'settings.about.lastChecked' => 'अंतिम जाँचा गया',
          'settings.about.checkingForUpdates' => 'जांच रहा है...',
          'settings.about.whatsNew' => 'नया क्या है',
          'settings.about.systemInformation' => 'सिस्टम जानकारी',
          'settings.about.dartVersion' => 'Dart संस्करण',
          'settings.about.diskSpace' => 'उपलब्ध डिस्क स्थान',
          'settings.about.memoryUsage' => 'मेमोरी उपयोग',
          'settings.about.privacyTitle' => 'गोपनीयता और टेलीमेट्री',
          'settings.about.usageStats' => 'गुमनाम उपयोग सांख्यिकी',
          'settings.about.requiresFirebase' =>
            'Firebase कॉन्फ़िगरेशन की आवश्यकता है',
          'settings.about.featureUnavailable' =>
            'सुविधा वर्तमान में अनुपलब्ध (Firebase की आवश्यकता है)',
          'settings.about.settingsManagement' => 'सेटिंग्स प्रबंधन',
          'settings.about.settingsManagementDescription' =>
            'अपनी सेटिंग्स को बैकअप करने या अन्य मशीनों के साथ साझा करने के लिए फ़ाइल में निर्यात करें।',
          'settings.about.resetAll' => 'सभी रीसेट करें',
          'settings.about.links' => 'लिंक',
          'settings.about.githubRepo' => 'GitHub रिपॉजिटरी',
          'settings.about.privacyPolicy' => 'गोपनीयता नीति',
          'settings.about.crashReporting' => 'क्रैश रिपोर्टिंग',
          'settings.onboarding.skipTutorial' => 'ट्यूटोरियल छोड़ें',
          'settings.onboarding.gettingStarted' => 'शुरू करना',
          'settings.onboarding.stepProgress' => (
                  {required Object total, required Object current}) =>
              '${total} में से ${current}',
          'settings.onboarding.loadSampleData' => 'नमूना डेटा लोड करें',
          'settings.onboarding.steps.importFiles.title' => 'फ़ाइलें आयात करें',
          'settings.onboarding.steps.importFiles.description' =>
            'स्रोत और लक्ष्य फ़ाइलें लोड करें',
          'settings.onboarding.steps.runComparison.title' => 'तुलना चलाएं',
          'settings.onboarding.steps.runComparison.description' =>
            '"फ़ाइलों की तुलना करें" पर क्लिक करें',
          'settings.onboarding.steps.reviewMissing.title' =>
            'लापता कुंजियों की समीक्षा करें',
          'settings.onboarding.steps.reviewMissing.description' =>
            'लाल MISSING आइटम देखें',
          'settings.onboarding.steps.useFilters.title' =>
            'फ़िल्टर का उपयोग करें',
          'settings.onboarding.steps.useFilters.description' =>
            'प्रकार के अनुसार फ़िल्टर करें',
          'settings.onboarding.steps.searchResults.title' => 'खोज परिणाम',
          'settings.onboarding.steps.searchResults.description' =>
            'विशिष्ट कुंजियाँ खोजें',
          'settings.onboarding.steps.advancedView.title' => 'उन्नत दृश्य',
          'settings.onboarding.steps.advancedView.description' =>
            'विस्तृत विश्लेषण का अन्वेषण करें',
          'settings.onboarding.steps.editCell.title' => 'एक सेल संपादित करें',
          'settings.onboarding.steps.editCell.description' =>
            'मान संपादित करने के लिए क्लिक करें',
          'settings.onboarding.steps.exportResults.title' => 'निर्यात',
          'settings.onboarding.steps.exportResults.description' =>
            'अपनी रिपोर्ट सहेजें',
          'settings.settingsView.resetCategoryTitle' =>
            ({required Object category}) => '${category} रीसेट करें?',
          'settings.settingsView.resetCategoryContent' =>
            'यह इस श्रेणी की सभी सेटिंग्स को उनके डिफ़ॉल्ट मानों पर रीसेट कर देगा।',
          'settings.settingsView.resetAllTitle' => 'सभी सेटिंग्स रीसेट करें?',
          'settings.settingsView.resetAllContent' =>
            'यह स्थायी रूप से सभी सेटिंग्स को उनके फ़ैक्टरी डिफ़ॉल्ट पर रीसेट कर देगा। यह क्रिया पूर्ववत नहीं की जा सकती।',
          'settings.settingsView.resetAll' => 'सभी रीसेट करें',
          'settings.settingsView.resetSuccess' =>
            ({required Object category}) => '${category} डिफ़ॉल्ट पर रीसेट',
          'settings.settingsView.errorLoading' =>
            'सेटिंग्स लोड करने में त्रुटि',
          'settings.settingsView.settingsSaved' => 'सेटिंग्स सहेजी गईं',
          'settings.settingsView.updateAvailable' =>
            ({required Object version}) => 'अपडेट उपलब्ध: v${version}',
          'settings.settingsView.latestVersion' =>
            'आप नवीनतम संस्करण का उपयोग कर रहे हैं',
          'settings.settingsView.whatsNew' => ({required Object version}) =>
              'v${version} में नया क्या है',
          'settings.settingsView.downloadUpdate' => 'अपडेट डाउनलोड करें',
          'settings.settingsView.exportSettings' => 'सेटिंग्स निर्यात करें',
          'settings.settingsView.settingsExported' => 'सेटिंग्स निर्यात की गईं',
          'settings.settingsView.exportFail' => ({required Object error}) =>
              'सेटिंग्स निर्यात करने में विफल: ${error}',
          'settings.settingsView.importSettings' => 'सेटिंग्स आयात करें',
          'settings.settingsView.importTitle' => 'सेटिंग्स आयात करें?',
          'settings.settingsView.importContent' =>
            'यह आपकी सभी मौजूदा सेटिंग्स को आयातित सेटिंग्स से बदल देगा। यह क्रिया पूर्ववत नहीं की जा सकती।',
          'settings.settingsView.importSuccess' =>
            'सेटिंग्स सफलतापूर्वक आयात की गईं!',
          'settings.settingsView.importFail' => ({required Object error}) =>
              'सेटिंग्स आयात करने में विफल: ${error}',
          'settings.settingsView.invalidFormat' =>
            'अमान्य सेटिंग्स फ़ाइल प्रारूप',
          'settings.settingsView.categories.general' => 'सामान्य सेटिंग्स',
          'settings.settingsView.categories.comparisonEngine' => 'तुलना इंजन',
          'settings.settingsView.categories.appearance' => 'दिखावट',
          'settings.settingsView.categories.fileHandling' => 'फ़ाइल हैंडलिंग',
          'settings.settingsView.categories.aiServices' => 'एआई सेवाएँ',
          'settings.settingsView.categories.systemIntegrations' =>
            'सिस्टम एकीकरण',
          'settings.settingsView.categories.projectResources' =>
            'प्रोजेक्ट संसाधन (शब्दावली और TM)',
          'settings.settingsView.categories.developer' => 'डेवलपर विकल्प',
          'settings.settingsView.categories.about' => 'के बारे में',
          'settings.settingsView.categoryLabels.general' => 'सामान्य',
          'settings.settingsView.categoryLabels.comparisonEngine' => 'तुलना',
          'settings.settingsView.categoryLabels.appearance' => 'दिखावट',
          'settings.settingsView.categoryLabels.fileHandling' =>
            'फ़ाइल हैंडलिंग',
          'settings.settingsView.categoryLabels.aiServices' => 'एआई सेवाएँ',
          'settings.settingsView.categoryLabels.systemIntegrations' =>
            'सिस्टम एकीकरण',
          'settings.settingsView.categoryLabels.projectResources' =>
            'प्रोजेक्ट संसाधन',
          'settings.settingsView.categoryLabels.developer' => 'डेवलपर विकल्प',
          'settings.settingsView.categoryLabels.about' => 'के बारे में',
          'fileComparison.title' => 'फ़ाइल तुलना',
          'fileComparison.openFiles' => 'फ़ाइलें खोलें',
          'fileComparison.exportResults' => 'परिणाम निर्यात करें',
          'fileComparison.restartTutorial' => 'ट्यूटोरियल पुनः आरंभ करें',
          'fileComparison.restartTutorialDevOnly' =>
            'ट्यूटोरियल पुनः आरंभ केवल डेवलपर मोड में उपलब्ध है।',
          'fileComparison.unsupportedFileType' => 'असमर्थित फ़ाइल प्रकार।',
          'fileComparison.unsupportedFileTypeSuggestion' =>
            'कृपया एक समर्थित स्थानीयकरण फ़ाइल चुनें।',
          'fileComparison.someFilesUnsupported' =>
            'कुछ फ़ाइलें समर्थित नहीं हैं।',
          'fileComparison.pickSupportedFiles' =>
            'केवल समर्थित स्थानीयकरण फ़ाइलें चुनें।',
          'fileComparison.pickTwoFiles' =>
            'तुलना करने के लिए दो फ़ाइलें चुनें।',
          'fileComparison.pickBilingualFile' =>
            'तुलना करने के लिए कृपया एक द्विभाषी फ़ाइल चुनें।',
          'fileComparison.noResultsToExport' =>
            'निर्यात करने के लिए अभी कोई परिणाम नहीं है।',
          'fileComparison.performComparisonFirst' =>
            'परिणाम निर्यात करने के लिए पहले तुलना करें।',
          'fileComparison.performComparisonFirstEditor' =>
            'उन्नत विवरण देखने के लिए कृपया पहले तुलना करें।',
          'fileComparison.sampleDataLoaded' =>
            'नमूना डेटा सफलतापूर्वक लोड किया गया',
          'fileComparison.loadSampleDataError' => ({required Object error}) =>
              'नमूना डेटा लोड करने में विफल: ${error}',
          'fileComparison.invalidFileType' => 'अमान्य फ़ाइल प्रकार।',
          'fileComparison.fileSelected' => (
                  {required Object label, required Object fileName}) =>
              '${label} चयनित: ${fileName}',
          'fileComparison.sourceFile' => 'स्रोत फ़ाइल',
          'fileComparison.targetFile' => 'लक्ष्य फ़ाइल',
          'fileComparison.bilingualFile' => 'द्विभाषी फ़ाइल',
          'fileComparison.compareFiles' => 'फ़ाइलों की तुलना करें',
          'fileComparison.compareFile' => 'फ़ाइल की तुलना करें',
          'fileComparison.bilingualMode' => 'द्विभाषी मोड',
          'fileComparison.twoFilesMode' => 'दो फ़ाइलें',
          'fileComparison.processing' => 'प्रोसेसिंग...',
          'fileComparison.remaining' => ({required Object time}) =>
              '${time} शेष',
          'fileComparison.comparisonInProgress' => 'तुलना प्रगति पर है...',
          'fileComparison.comparisonFailed' => ({required Object error}) =>
              'तुलना विफल: ${error}',
          'fileComparison.fileChanged' => ({required Object fileName}) =>
              'फ़ाइल बदल गई: ${fileName}। पुनः तुलना कर रहा है...',
          'fileComparison.dropFileHere' => 'फ़ाइल यहाँ छोड़ें',
          'fileComparison.dropFileOrBrowse' =>
            'फ़ाइल छोड़ें या ब्राउज़ करने के लिए क्लिक करें',
          'fileComparison.fileUpload' => 'फ़ाइल अपलोड करें',
          'fileComparison.changeFile' => 'फ़ाइल बदलें',
          'fileComparison.total' => 'कुल',
          'fileComparison.show' => 'दिखाएं',
          'fileComparison.showAll' => 'सभी दिखाएं',
          'fileComparison.noMatches' => ({required Object query}) =>
              '"${query}" के लिए कोई मेल नहीं मिला',
          'fileComparison.showingEntries' => (
                  {required Object total, required Object count}) =>
              '${total} में से ${count} प्रविष्टियाँ दिखा रहा है',
          'fileComparison.filesIdentical' => 'फ़ाइलें समान हैं।',
          'fileComparison.hiddenIdentical' => ({required Object count}) =>
              '${count} समान प्रविष्टियाँ छिपी हुई हैं',
          'fileComparison.showIdentical' => 'समान प्रविष्टियाँ दिखाएं',
          'fileComparison.hideIdentical' => 'समान प्रविष्टियाँ छिपाएं',
          'fileComparison.noDiff' => 'कुंजियों के आधार पर कोई अंतर नहीं मिला।',
          'fileComparison.source' => 'स्रोत',
          'fileComparison.target' => 'लक्ष्य',
          'fileComparison.value' => 'मान',
          'fileComparison.readyToCompare' =>
            'फ़ाइलों की तुलना करने के लिए तैयार',
          'fileComparison.readyToCompareDesc' =>
            'ऊपर स्थानीयकरण फ़ाइलें छोड़ें या तुलना के लिए फ़ाइलों का चयन करने के लिए\nब्राउज़ बटन का उपयोग करें।',
          'fileComparison.recentComparisons' => 'हालिया तुलनाएं',
          'fileComparison.bilingualFileLabel' => ({required Object name}) =>
              'द्विभाषी फ़ाइल: ${name}',
          'fileComparison.comparisonLabel' => (
                  {required Object source, required Object target}) =>
              '${source} ↔ ${target}',
          'fileComparison.fileNotExist' =>
            'इस सत्र की एक या दोनों फ़ाइलें अब मौजूद नहीं हैं।',
          'fileComparison.largeFileTitle' => 'बड़ी फ़ाइल का पता चला',
          'fileComparison.largeFileContent' => ({required Object count}) =>
              'तुलना परिणाम में ${count} प्रविष्टियाँ हैं।\nउन सभी को प्रदर्शित करने से प्रदर्शन संबंधी समस्याएं हो सकती हैं।\n\nक्या आप आगे बढ़ना चाहते हैं?',
          'fileComparison.dontShowAgain' => 'इस फ़ाइल के लिए फिर से न दिखाएं',
          'fileComparison.proceed' => 'आगे बढ़ें',
          'fileComparison.exportReport' => ({required Object format}) =>
              '${format} रिपोर्ट सहेजें',
          'fileComparison.saved' => ({required Object format}) =>
              '${format} सहेजा गया',
          'fileComparison.saveError' => ({required Object format}) =>
              '${format} फ़ाइल सहेजने में विफल।',
          'fileComparison.saveErrorDetailed' => (
                  {required Object format, required Object error}) =>
              '${format} सहेजने में विफल: ${error}',
          'fileComparison.watching' => 'निगरानी',
          'fileComparison.watchOff' => 'निगरानी बंद',
          'fileComparison.watchingTooltip' => ({required Object status}) =>
              'फ़ाइल निगरानी: ${status}\nडिस्क पर फ़ाइलें बदलने पर स्वचालित रूप से पुनः तुलना करें',
          'fileComparison.aiSettingsNotAvailable' =>
            'एआई सेटिंग्स के लिए नेविगेशन उपलब्ध नहीं है',
          'directoryComparison.title' => 'डायरेक्टरी तुलना',
          'directoryComparison.sourceDirectory' => 'स्रोत डायरेक्टरी',
          'directoryComparison.targetDirectory' => 'लक्ष्य डायरेक्टरी',
          'directoryComparison.sourceSubtitle' => 'मूल/संदर्भ फ़ाइलें',
          'directoryComparison.targetSubtitle' => 'अनुवाद/तुलना फ़ाइलें',
          'directoryComparison.selectBothDirectories' =>
            'कृपया स्रोत और लक्ष्य दोनों डायरेक्टरी चुनें।',
          'directoryComparison.selectSourceFolder' => 'स्रोत फ़ोल्डर चुनें',
          'directoryComparison.selectTargetFolder' => 'लक्ष्य फ़ोल्डर चुनें',
          'directoryComparison.dropFolderHere' =>
            'फ़ोल्डर यहाँ छोड़ें या ब्राउज़ करें...',
          'directoryComparison.folderPath' => 'फ़ोल्डर पथ',
          'directoryComparison.readyToCompare' =>
            'डायरेक्टरी की तुलना करने के लिए तैयार',
          'directoryComparison.readyToCompareDesc' =>
            'ऊपर फ़ोल्डर छोड़ें या तुलना के लिए डायरेक्टरी का चयन करने के लिए\nब्राउज़ बटन का उपयोग करें।',
          'directoryComparison.nestedFolders' => 'नेस्टेड फ़ोल्डर',
          'directoryComparison.nestedFoldersTooltip' =>
            'सभी नेस्टेड डायरेक्टरी की पुनरावर्ती तुलना करता है',
          'directoryComparison.fileMatching' => 'फ़ाइल मिलान',
          'directoryComparison.fileMatchingTooltip' =>
            'नाम से फ़ाइलों को स्वचालित रूप से जोड़ता है',
          'directoryComparison.bulkExport' => 'थोक निर्यात',
          'directoryComparison.bulkExportTooltip' =>
            'सभी तुलना परिणाम एक साथ निर्यात करें',
          'directoryComparison.notDirectoryComparison' =>
            'यह एक डायरेक्टरी तुलना नहीं है।',
          'directoryComparison.directoriesNotExist' =>
            'एक या दोनों डायरेक्टरी अब मौजूद नहीं हैं।',
          'directoryComparison.errorOccurred' => 'त्रुटि हुई',
          'directoryComparison.noFilesFound' =>
            'चयनित डायरेक्टरी में कोई फ़ाइल नहीं मिली।',
          'directoryComparison.unmatchedSourceFiles' => 'बेमेल स्रोत फ़ाइलें',
          'directoryComparison.unmatchedTargetFiles' => 'बेमेल लक्ष्य फ़ाइलें',
          'directoryComparison.filePairs' => ({required Object count}) =>
              '${count} फ़ाइल जोड़े',
          'directoryComparison.pairedFiles' => ({required Object count}) =>
              'युग्मित फ़ाइलें (${count})',
          'directoryComparison.view' => 'दृश्य',
          'directoryComparison.failed' => 'विफल',
          'directoryComparison.pair' => 'जोड़ा बनाएं...',
          'directoryComparison.pairDialogTitle' => ({required Object name}) =>
              '"${name}" के साथ जोड़ा बनाएं:',
          'directoryComparison.discoverFiles' => 'फ़ाइलें खोजें',
          'directoryComparison.compareAll' => 'सभी तुलना करें',
          'directoryComparison.exportAll' => 'सभी निर्यात करें',
          'directoryComparison.comparisonStarted' => 'तुलना शुरू हुई...',
          'directoryComparison.discoveringFiles' =>
            'फ़ाइलें खोजी जा रही हैं...',
          'directoryComparison.noResultsToExport' =>
            'निर्यात करने के लिए कोई तुलना परिणाम नहीं। पहले "सभी तुलना करें" चलाएं।',
          'directoryComparison.selectExportFolder' => 'निर्यात फ़ोल्डर चुनें',
          'directoryComparison.createExportFolderError' => (
                  {required Object error}) =>
              'निर्यात फ़ोल्डर बनाने में विफल: ${error}',
          'directoryComparison.exportingResults' =>
            'परिणाम निर्यात किए जा रहे हैं',
          'directoryComparison.processingFile' => ({required Object file}) =>
              'प्रोसेसिंग: ${file}',
          'directoryComparison.exportProgress' => (
                  {required Object total, required Object current}) =>
              '${total} में से ${current} फ़ाइलें निर्यात की गईं',
          'directoryComparison.exportComplete' => 'निर्यात पूर्ण',
          'directoryComparison.exportSuccessMessage' => (
                  {required Object count}) =>
              'सफलतापूर्वक ${count} तुलना फ़ाइलें और सारांश निर्यात किया गया।',
          'directoryComparison.exportFailed' => ({required Object error}) =>
              'निर्यात विफल: ${error}',
          'directoryComparison.close' => 'बंद करें',
          'gitComparison._translatorNote' =>
            'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.',
          'gitComparison.title' => 'रिपॉजिटरी तुलना',
          'gitComparison.repoSelector' => 'रिपॉजिटरी बनाएं / खोलें',
          'gitComparison.noRepoSelected' => 'कोई रिपॉजिटरी चयनित नहीं',
          'gitComparison.open' => 'खोलें',
          'gitComparison.refreshCommits' => 'Commits ताज़ा करें',
          'gitComparison.noCommits' =>
            'कोई commit नहीं मिला या लोड नहीं हुआ। Commits लोड करने के लिए एक branch चुनें।',
          'gitComparison.baseCommit' => 'आधार Commit (पुराना)',
          'gitComparison.targetCommit' => 'लक्ष्य Commit (नया)',
          'gitComparison.filterCommitsByBranch' =>
            'Branch द्वारा Commits फ़िल्टर करें',
          'gitComparison.conflictDetection' => 'Conflict का पता लगाना',
          'gitComparison.conflictDetectionTooltip' =>
            'Merge conflicts का पता लगाएं और हल करें',
          'gitComparison.actions' => 'क्रियाएं:',
          'gitComparison.checkout' => 'Checkout',
          'gitComparison.merge' => 'Merge',
          'gitComparison.pull' => 'Pull',
          'gitComparison.checkoutBranch' => 'Checkout Branch',
          'gitComparison.mergeBranch' => 'Merge Branch को वर्तमान में',
          'gitComparison.mergeConfirmation' => ({required Object branch}) =>
              '${branch} को Merge करें?',
          'gitComparison.mergeWarning' =>
            'यह आपके वर्तमान कार्यकारी branch में परिवर्तनों को merge करेगा। Conflicts हो सकते हैं।',
          'gitComparison.selectExportFolder' => 'निर्यात फ़ोल्डर चुनें',
          'gitComparison.createExportFolderError' => (
                  {required Object error}) =>
              'निर्यात फ़ोल्डर बनाने में विफल: ${error}',
          'gitComparison.exportingFiles' => 'फ़ाइलें निर्यात की जा रही हैं',
          'gitComparison.processingFile' => ({required Object file}) =>
              'प्रोसेसिंग: ${file}',
          'gitComparison.exportProgress' => (
                  {required Object total, required Object current}) =>
              '${total} में से ${current} फ़ाइलें निर्यात की गईं',
          'gitComparison.exportComplete' => 'निर्यात पूर्ण',
          'gitComparison.exportSuccessMessage' => ({required Object count}) =>
              'सफलतापूर्वक ${count} फ़ाइलें पूर्ण सामग्री के साथ निर्यात की गईं।',
          'gitComparison.exportDetail' =>
            'प्रत्येक फ़ाइल का diff "files" सबफ़ोल्डर में सहेजा गया है।',
          'gitComparison.diffViewer' => 'Diff व्यूअर',
          'gitComparison.base' => 'BASE',
          'gitComparison.target' => 'TARGET',
          'gitComparison.noLines' => 'प्रदर्शित करने के लिए कोई लाइनें नहीं',
          'gitComparison.searchFiles' => 'फ़ाइलें खोजें...',
          'gitComparison.noFilesMatch' => ({required Object query}) =>
              '"${query}" से कोई फ़ाइल मेल नहीं खाती',
          'gitComparison.filesCount' => ({required Object count}) =>
              '${count} फ़ाइलें',
          'gitComparison.selectBaseFile' => 'आधार फ़ाइल चुनें',
          'gitComparison.selectTargetFile' => 'लक्ष्य फ़ाइल चुनें',
          'gitComparison.comparisonResults' => 'तुलना परिणाम',
          'gitComparison.noChanges' => 'चयनित refs के बीच कोई बदलाव नहीं मिला।',
          'gitComparison.linesAdded' => 'लाइनें जोड़ी गईं',
          'gitComparison.linesRemoved' => 'लाइनें हटाई गईं',
          'gitComparison.commit' => 'Commit',
          'gitComparison.branch' => 'Branch',
          'gitComparison.noRepositorySelected' => 'कोई रिपॉजिटरी चयनित नहीं',
          'gitComparison.notGitComparison' => 'यह Git तुलना नहीं है',
          'gitComparison.repositoryNotExist' => 'रिपॉजिटरी मौजूद नहीं है',
          'gitComparison.mainBranch' => 'main',
          'gitComparison.masterBranch' => 'master',
          'gitComparison.backToControls' => 'तुलना नियंत्रण पर वापस',
          'advancedComparison.placeholder' => 'उन्नत तुलना दृश्य - प्लेसहोल्डर',
          'advancedDiff.saveAllChanges' => 'सभी परिवर्तनों को सहेजें?',
          'advancedDiff.saveConfirmation' => ({required Object count}) =>
              'यह लक्ष्य फ़ाइल में सभी ${count} संशोधित प्रविष्टियों को सहेजेगा। यह क्रिया पूर्ववत नहीं की जा सकती।',
          'advancedDiff.changesSaved' => 'परिवर्तन सफलतापूर्वक सहेजे गए।',
          'advancedDiff.csvExported' => 'CSV निर्यात किया गया',
          'advancedDiff.unsavedChanges' => 'बिना सहेजे परिवर्तन',
          'advancedDiff.unsavedChangesWarning' =>
            'आपके पास बिना सहेजे परिवर्तन हैं। क्या आप वाकई उन्हें त्यागना चाहते हैं?',
          'advancedDiff.discardChanges' => 'परिवर्तनों को त्यागें',
          'advancedDiff.goBack' => 'वापस जाओ',
          'advancedDiff.breadcrumbs' => 'होम > संपादक',
          'advancedDiff.unsaved' => ({required Object count}) =>
              '${count} बिना सहेजे',
          'advancedDiff.reviewed' => ({required Object count}) =>
              '${count} समीक्षित',
          'advancedDiff.saveAll' => ({required Object count}) =>
              'सभी सहेजें (${count})',
          'advancedDiff.allSaved' => 'सभी सहेजे गए',
          'advancedDiff.saveAllTooltip' => 'सभी परिवर्तनों को सहेजें (Ctrl+S)',
          'advancedDiff.exportTooltip' => 'डेटा निर्यात करें (Ctrl+E)',
          'advancedDiff.aiSuggestion.aiTranslation' => 'एआई अनुवाद',
          'advancedDiff.aiSuggestion.aiRephrase' => 'एआई रिफ्रेश',
          'advancedDiff.aiSuggestion.key' => ({required Object key}) =>
              'कुंजी: ${key}',
          'advancedDiff.aiSuggestion.original' => 'मूल:',
          'advancedDiff.aiSuggestion.suggestion' => 'सुझाव:',
          'advancedDiff.aiSuggestion.confidence' => 'एआई विश्वास',
          'advancedDiff.aiSuggestion.cancelEdit' => 'संपादन रद्द करें',
          'advancedDiff.aiSuggestion.editSuggestion' => 'सुझाव संपादित करें',
          'advancedDiff.aiSuggestion.alternatives' => 'विकल्प:',
          'advancedDiff.aiSuggestion.accept' => ' स्वीकार करें',
          'advancedDiff.aiSuggestion.reject' => 'अस्वीकार करें',
          'advancedDiff.aiSuggestion.stop' => 'रोकें',
          'advancedDiff.detailEdit.title' => ({required Object key}) =>
              'संपादित करें: ${key}',
          'advancedDiff.detailEdit.sourceLabel' => 'स्रोत (मूल)',
          'advancedDiff.detailEdit.targetLabel' => 'लक्ष्य (अनुवाद)',
          'advancedDiff.detailEdit.translateWithCloud' =>
            'क्लाउड के साथ अनुवाद करें',
          'advancedDiff.detailEdit.translateWithAi' => 'एआई के साथ अनुवाद करें',
          'advancedDiff.detailEdit.translating' => 'अनुवाद हो रहा है...',
          'advancedDiff.detailEdit.applyAndTm' => 'लागू करें',
          'advancedDiff.detailEdit.entryApplied' =>
            'प्रविष्टि लागू की गई और TM में जोड़ी गई',
          'advancedDiff.detailEdit.translationAdded' =>
            'अनुवाद सुझाव जोड़ा गया।',
          'advancedDiff.detailEdit.aiSuggestionAdded' => 'एआई सुझाव जोड़ा गया।',
          'advancedDiff.table.addedToTM' => 'अनुवाद स्मृति में जोड़ा गया',
          'advancedDiff.table.markedReviewed' =>
            'समीक्षित के रूप में चिह्नित ✓',
          'advancedDiff.table.unmarkedReview' => 'समीक्षा अचयनित',
          'advancedDiff.table.reverted' => 'मूल मान पर वापस लाया गया',
          'advancedDiff.table.entryDeleted' => 'प्रविष्टि हटाई गई',
          'advancedDiff.table.noSourceText' =>
            'अनुवाद करने के लिए कोई स्रोत पाठ नहीं।',
          'advancedDiff.table.aiTranslationFailed' => ({required Object key}) =>
              '"${key}" के लिए एआई अनुवाद विफल',
          'advancedDiff.table.noTargetText' =>
            'रिफ्रेश करने के लिए कोई लक्ष्य पाठ नहीं।',
          'advancedDiff.table.aiRephraseFailed' => ({required Object key}) =>
              '"${key}" के लिए एआई रिफ्रेश विफल',
          'advancedDiff.table.checkRowsFirst' =>
            'पहले चेकबॉक्स का उपयोग करके पंक्तियों की जाँच करें',
          'advancedDiff.table.markedRowsReviewed' => (
                  {required Object count}) =>
              '${count} पंक्तियों को समीक्षित के रूप में चिह्नित किया गया',
          'advancedDiff.table.revertedRows' => ({required Object count}) =>
              '${count} पंक्तियों को वापस लाया गया',
          'advancedDiff.table.entriesCount' => ({required Object count}) =>
              '${count} प्रविष्टियाँ',
          'advancedDiff.table.markSelectedReviewed' =>
            'चयनित को समीक्षित चिह्नित करें',
          'advancedDiff.table.revertSelected' => 'चयनित को वापस लाएं',
          'advancedDiff.table.noDifferences' => 'कोई अंतर नहीं मिला',
          'advancedDiff.table.adjustFilters' =>
            'अपने फ़िल्टर समायोजित करने का प्रयास करें',
          'advancedDiff.table.cloudTranslationApplied' =>
            'क्लाउड अनुवाद लागू किया गया।',
          'advancedDiff.table.aiTranslationApplied' =>
            'एआई अनुवाद लागू किया गया।',
          'advancedDiff.table.suggestionApplied' => 'सुझाव लागू किया गया।',
          'advancedDiff.table.aiSuggestionApplied' =>
            'एआई सुझाव लागू किया गया।',
          'advancedDiff.table.rephraseApplied' => 'रिफ्रेश लागू किया गया।',
          'advancedDiff.table.aiRephraseApplied' =>
            'एआई रिफ्रेश लागू किया गया।',
          'advancedDiff.table.rephrase' => 'रिफ्रेश',
          'advancedDiff.table.aiRephrase' => 'एआई रिफ्रेश',
          'advancedDiff.table.targetClickToEdit' =>
            'लक्ष्य (संपादित करने के लिए क्लिक करें)',
          'advancedDiff.table.targetClickForDialog' =>
            'लक्ष्य (संवाद के लिए क्लिक करें)',
          'advancedDiff.table.emptyClickToEdit' =>
            '(खाली - संपादित करने के लिए क्लिक करें)',
          'advancedDiff.table.unmarkReviewed' => 'समीक्षित अचयनित करें',
          'advancedDiff.table.markReviewed' =>
            'समीक्षित के रूप में चिह्नित करें',
          'advancedDiff.table.revertToSource' => 'स्रोत पर वापस लाएं',
          'advancedDiff.table.translateWithCloud' =>
            'क्लाउड के साथ अनुवाद करें',
          'advancedDiff.table.translateWithAi' => 'एआई के साथ अनुवाद करें',
          'advancedDiff.table.rephraseWithAi' => 'एआई के साथ रिफ्रेश करें',
          'advancedDiff.table.moreActions' => 'अधिक क्रियाएं',
          'advancedDiff.table.editDetails' => 'विवरण संपादित करें',
          'advancedDiff.table.suggestTranslation' => 'अनुवाद सुझाव दें',
          'advancedDiff.table.addToTm' => 'TM में जोड़ें',
          'advancedDiff.table.deleteEntry' => 'प्रविष्टि हटाएं',
          'advancedDiff.diffRow.copySource' => 'स्रोत पाठ कॉपी करें',
          'advancedDiff.diffRow.actions' => 'क्रियाएं',
          'advancedDiff.status.added' => 'जोड़ा गया',
          'advancedDiff.status.missing' => 'लापता',
          'advancedDiff.status.changed' => ({required Object percent}) =>
              'बदला गया ${percent}%',
          'advancedDiff.status.same' => 'समान',
          'advancedDiff.sidebar.widgets' => 'विजेट्स',
          'advancedDiff.sidebar.searchPlaceholder' =>
            'कुंजियाँ और मान खोजें... (Ctrl+F)',
          'advancedDiff.sidebar.fuzzySearchTooltip' =>
            'फजी खोज (टाइपो-सहिष्णु)',
          'advancedDiff.sidebar.regexSearchTooltip' => 'Regex खोज',
          'advancedDiff.sidebar.cloudTranslation' => 'क्लाउड अनुवाद',
          'advancedDiff.sidebar.aiTranslation' => 'एआई अनुवाद',
          'advancedDiff.sidebar.status' => 'स्थिति',
          'advancedDiff.sidebar.tm' => 'अनुवाद स्मृति',
          'advancedDiff.sidebar.filters' => 'फ़िल्टर',
          'advancedDiff.sidebar.actions' => 'क्रियाएं',
          'advancedDiff.sidebar.similarity' => 'समानता',
          'advancedDiff.sidebar.actionsSection.exportMatches' =>
            'मैच निर्यात करें',
          'advancedDiff.sidebar.actionsSection.preview' => 'पूर्वावलोकन',
          'advancedDiff.sidebar.actionsSection.fillFromTmTitle' =>
            'अनुवाद स्मृति से भरें?',
          'advancedDiff.sidebar.actionsSection.fillFromTmContent' =>
            'यह अनुवाद स्मृति से मिलान का उपयोग करके खाली लक्ष्य मानों को भरने का प्रयास करेगा। मौजूदा मान अधिलिखित नहीं किए जाएंगे।',
          'advancedDiff.sidebar.actionsSection.fill' => 'भरें',
          'advancedDiff.sidebar.actionsSection.fillFromMemory' =>
            'मेमोरी से भरें',
          'advancedDiff.sidebar.actionsSection.filledFromTm' => (
                  {required Object count}) =>
              'अनुवाद स्मृति से ${count} आइटम भरे गए।',
          'advancedDiff.sidebar.aiSection.infoCloud' =>
            'स्रोत से खाली लक्ष्य मानों का अनुवाद करने के लिए क्लाउड अनुवाद का उपयोग करता है।',
          'advancedDiff.sidebar.aiSection.infoAi' =>
            'स्रोत से खाली लक्ष्य मानों का अनुवाद करने के लिए एआई का उपयोग करता है।',
          'advancedDiff.sidebar.aiSection.translationSettings' =>
            'अनुवाद सेटिंग्स',
          'advancedDiff.sidebar.aiSection.aiSettings' => 'एआई सेटिंग्स',
          'advancedDiff.sidebar.aiSection.source' => 'स्रोत',
          'advancedDiff.sidebar.aiSection.target' => 'लक्ष्य',
          'advancedDiff.sidebar.aiSection.translatingProgress' =>
            ({required Object percent}) => 'अनुवाद हो रहा है... ${percent}%',
          'advancedDiff.sidebar.aiSection.translating' => 'अनुवाद हो रहा है...',
          'advancedDiff.sidebar.aiSection.translateAllMissing' =>
            'सभी लापता अनुवाद करें',
          'advancedDiff.sidebar.aiSection.translateAllTitle' =>
            'सभी लापता अनुवाद करें?',
          'advancedDiff.sidebar.aiSection.translateAllContent' => (
                  {required Object source,
                  required Object target,
                  required Object service}) =>
              'यह ${source} से ${target} तक खाली लक्ष्य मानों वाली सभी प्रविष्टियों का अनुवाद करने के लिए ${service} का उपयोग करेगा।\n\nआप प्रत्येक सुझाव की समीक्षा कर सकते हैं या सभी को एक साथ लागू कर सकते हैं।',
          'advancedDiff.sidebar.aiSection.translateAll' => 'सभी अनुवाद करें',
          'advancedDiff.sidebar.aiSection.reviewEach' =>
            'प्रत्येक की समीक्षा करें',
          'advancedDiff.sidebar.aiSection.cloudTranslated' => (
                  {required Object count}) =>
              'क्लाउड अनुवाद के साथ ${count} प्रविष्टियों का अनुवाद किया गया।',
          'advancedDiff.sidebar.aiSection.aiTranslated' => (
                  {required Object count}) =>
              'एआई के साथ ${count} प्रविष्टियों का अनुवाद किया गया।',
          'advancedDiff.sidebar.aiSection.aiTranslateFailed' =>
            'एआई सभी अनुवाद विफल',
          'advancedDiff.sidebar.aiSection.noMissingEntries' =>
            'अनुवाद करने के लिए कोई लापता प्रविष्टि नहीं।',
          'advancedDiff.sidebar.aiSection.skip' => 'छोड़ें',
          'advancedDiff.sidebar.aiSection.stop' => 'रोकें',
          'advancedDiff.sidebar.aiSection.cloudApplied' =>
            ({required Object count}) => '${count} सुझाव लागू किए गए।',
          'advancedDiff.sidebar.aiSection.aiApplied' =>
            ({required Object count}) => '${count} एआई सुझाव लागू किए गए।',
          'advancedDiff.sidebar.tmSection.enableTmFill' => 'TM भराव सक्षम करें',
          'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' =>
            'न्यूनतम से ऊपर ऑटो-लागू करें',
          'advancedDiff.sidebar.tmSection.matchSettings' => 'मैच सेटिंग्स',
          'advancedDiff.sidebar.tmSection.minMatch' => 'मिन मैच:',
          'advancedDiff.sidebar.tmSection.limit' => 'सीमा:',
          'advancedDiff.sidebar.tmSection.exact' => 'सटीक',
          'advancedDiff.sidebar.filtersSection.viewFilters' => 'फ़िल्टर देखें',
          'advancedDiff.sidebar.filtersSection.showAll' => 'सभी दिखाएं',
          'advancedDiff.sidebar.filtersSection.added' => 'जोड़ा गया',
          'advancedDiff.sidebar.filtersSection.removed' => 'हटाया गया',
          'advancedDiff.sidebar.filtersSection.modified' => 'संशोधित',
          'advancedDiff.sidebar.filtersSection.actionScope' => 'क्रिया स्कोप',
          'advancedDiff.sidebar.filtersSection.applyToAdded' =>
            'जोड़े गए पर लागू करें',
          'advancedDiff.sidebar.filtersSection.applyToModified' =>
            'संशोधित पर लागू करें',
          'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' =>
            'केवल खाली लक्ष्य भरें',
          'advancedDiff.sidebar.filtersSection.limitToVisible' =>
            'दृश्यमान तक सीमित करें',
          'advancedDiff.sidebar.filtersSection.editMode' => 'संपादन मोड',
          'advancedDiff.sidebar.filtersSection.dialog' => 'संवाद',
          'advancedDiff.sidebar.filtersSection.inline' => 'इनलाइन',
          'advancedDiff.sidebar.similaritySection.currentFilter' =>
            'वर्तमान फ़िल्टर:',
          'advancedDiff.sidebar.similaritySection.any' => 'कोई भी',
          'advancedDiff.sidebar.similaritySection.high' => 'उच्च',
          'advancedDiff.sidebar.similaritySection.medium' => 'मध्यम',
          'advancedDiff.sidebar.similaritySection.low' => 'कम',
          'advancedDiff.sidebar.statusSection.total' =>
            ({required Object count}) => '${count} कुल',
          'advancedDiff.sidebar.statusSection.extra' =>
            ({required Object count}) => '${count} अतिरिक्त',
          'advancedDiff.sidebar.statusSection.missing' =>
            ({required Object count}) => '${count} लापता',
          'advancedDiff.sidebar.statusSection.changed' =>
            ({required Object count}) => '${count} बदला गया',
          'issueDetails.title' => 'समस्या विवरण',
          'issueDetails.showingIssues' => (
                  {required Object total, required Object count}) =>
              '${total} में से ${count} समस्याएं दिखा रहा है',
          'issueDetails.searchPlaceholder' =>
            'कुंजी, पाठ या त्रुटि द्वारा खोजें...',
          'issueDetails.noDetails' => 'कोई विवरण उपलब्ध नहीं है।',
          'issueDetails.noMatches' => 'कोई मेल नहीं मिला।',
          'issueDetails.showMore' => 'और दिखाएं',
          'issueDetails.copyItems' => ({required Object count}) =>
              '${count} आइटम कॉपी करें',
          'issueDetails.close' => 'बंद करें',
          'issueDetails.copied' => 'क्लैपबोर्ड पर कॉपी किया गया',
          'issueDetails.copiedCount' => ({required Object count}) =>
              '${count} आइटम कॉपी किए गए',
          'issueDetails.duplicateValue.label' => 'दोहराया गया अनुवाद',
          'issueDetails.duplicateValue.warning' =>
            'विभिन्न स्रोत पाठ इस समान अनुवाद का उपयोग करते हैं। संदर्भ की जाँच करें।',
          'issueDetails.duplicateValue.affectedKeys' =>
            ({required Object count}) => 'प्रभावित कुंजियाँ (${count})',
          'issueDetails.duplicateValue.identicalSources' => 'समान स्रोत',
          'issueDetails.duplicateValue.moreKeys' => ({required Object count}) =>
              '+${count} और कुंजियाँ',
          'issueDetails.lengthOutlier.source' => 'स्रोत',
          'issueDetails.lengthOutlier.translation' => 'अनुवाद',
          'issueDetails.lengthOutlier.chars' => ({required Object count}) =>
              '${count} अक्षर',
          'issueDetails.standard.key' => 'कुंजी',
          'issueDetails.standard.sourceText' => 'स्रोत पाठ',
          'issueDetails.standard.translation' => 'अनुवाद',
          'issueDetails.standard.errorDetails' => 'त्रुटि विवरण',
          'issueDetails.standard.note' => 'नोट',
          'issueDetails.review' => 'समीक्षा',
          'issueDetails.types.duplicateValue' => 'दोहराए गए मान',
          'issueDetails.types.lengthOutlier' => 'लंबाई बेमेल',
          'issueDetails.types.placeholderMismatch' => 'टूटे हुए प्लेसहोल्डर',
          'issueDetails.notes.placeholderMismatch' =>
            '{name} जैसे मार्करों को स्रोत से मेल खाना चाहिए।',
          'issueDetails.notes.lengthOutlier' =>
            'बड़े लंबाई परिवर्तन यह प्रभावित कर सकते हैं कि पाठ स्क्रीन पर कैसे फिट बैठता है।',
          'issueDetails.notes.duplicateValue' =>
            'विभिन्न कुंजियों के लिए समान अनुवाद का उपयोग किया जाता है।',
          'issueDetails.fallbacks.multipleSources' => 'कई स्रोत पाठ',
          'issueDetails.fallbacks.sourceNotAvailable' =>
            'स्रोत पाठ उपलब्ध नहीं है',
          'issueDetails.fallbacks.sharedTranslationNotAvailable' =>
            'साझा अनुवाद उपलब्ध नहीं है',
          'issueDetails.fallbacks.translationNotAvailable' =>
            'अनुवाद उपलब्ध नहीं है',
          'importReview.title' => 'प्रोजेक्ट आयात समीक्षा',
          'importReview.projectName' => 'प्रोजेक्ट का नाम',
          'importReview.created' => 'बनाया गया',
          'importReview.historyItems' => 'इतिहास आइटम',
          'importReview.customSettingsTitle' => 'कस्टम सेटिंग्स का पता चला',
          'importReview.customSettingsWarning' =>
            'इस प्रोजेक्ट में कस्टम सेटिंग्स हैं जो इस प्रोजेक्ट के खुले रहने के दौरान आपके डिफॉल्ट को ओवरराइड कर देंगी।',
          'importReview.standardSettings' =>
            'यह प्रोजेक्ट मानक वैश्विक सेटिंग्स का उपयोग करता है।',
          'importReview.cancelImport' => 'आयात रद्द करें',
          'importReview.trustOpen' => 'विश्वास करें और प्रोजेक्ट खोलें',
          'historyView.title' => 'तुलना इतिहास',
          'historyView.clearAll' => 'सभी इतिहास साफ़ करें',
          'historyView.searchPlaceholder' => 'फ़ाइल नाम से खोजें...',
          'historyView.sortBy' => 'क्रमबद्ध करें',
          'historyView.sortDate' => 'तारीख',
          'historyView.sortSource' => 'स्रोत फ़ाइल',
          'historyView.sortTarget' => 'लक्ष्य फ़ाइल',
          'historyView.showCurrentProject' => 'दिखा रहा है: वर्तमान प्रोजेक्ट',
          'historyView.showAllHistory' => 'दिखा रहा है: सभी इतिहास',
          'historyView.groupByFolder' => 'फ़ोल्डर द्वारा समूह',
          'historyView.disableGrouping' => 'फ़ोल्डर समूहीकरण अक्षम करें',
          'historyView.filterAll' => 'सभी',
          'historyView.filterFiles' => 'फ़ाइलें',
          'historyView.filterDirectories' => 'निर्देशिकाएँ',
          'historyView.filterGit' => 'Git',
          'historyView.noHistory' => 'अभी तक कोई तुलना इतिहास नहीं',
          'historyView.historyDescription' =>
            'आपकी फ़ाइल तुलना यहाँ दिखाई देगी',
          'historyView.noResults' => 'कोई परिणाम नहीं मिला',
          'historyView.adjustSearch' => 'अपनी खोज समायोजित करने का प्रयास करें',
          'historyView.clearConfirmationTitle' => 'सभी इतिहास साफ़ करें?',
          'historyView.clearConfirmationContent' =>
            'यह सभी तुलना इतिहास को स्थायी रूप से हटा देगा। यह क्रिया पूर्ववत नहीं की जा सकती।',
          'historyView.clearAction' => 'सभी साफ़ करें',
          'historyView.deletedMessage' => 'इतिहास आइटम हटाया गया',
          'historyView.undo' => 'पूर्ववत करें',
          'historyView.viewDetails' => 'विवरण देखें',
          'historyView.delete' => 'हटाएं',
          'historyView.openLocation' => 'फ़ाइल स्थान खोलें',
          'historyView.bilingual' => 'द्विभाषी',
          'historyView.filePair' => 'फ़ाइल जोड़ी',
          'historyView.directory' => 'निर्देशिका',
          'historyView.git' => 'Git',
          'historyView.repo' => 'Repo',
          'historyView.sourceDir' => 'स्रोत निर्देशिका',
          'historyView.targetDir' => 'लक्ष्य निर्देशिका',
          'historyView.source' => 'स्रोत',
          'historyView.target' => 'लक्ष्य',
          'historyView.noChanges' => 'कोई परिवर्तन नहीं मिला',
          'historyView.added' => 'जोड़ा गया',
          'historyView.removed' => 'हटाया गया',
          'historyView.modified' => 'संशोधित',
          'historyView.same' => 'समान',
          'historyView.total' => 'कुल',
          'historyView.currentProject' => 'वर्तमान प्रोजेक्ट',
          'historyView.unassigned' => 'अनसाइन किया गया',
          'historyView.project' => 'प्रोजेक्ट',
          'compare.title' => 'फ़ाइलों की तुलना करें',
          'compare.sourceFile' => 'स्रोत फ़ाइल',
          'compare.targetFile' => 'लक्ष्य फ़ाइल',
          'compare.sourceFolder' => 'स्रोत फ़ोल्डर',
          'compare.targetFolder' => 'लक्ष्य फ़ोल्डर',
          'compare.dropFilesHint' =>
            'तुलना के लिए स्थानीयकरण फ़ाइलें यहाँ छोड़ें या फ़ाइलों का चयन करने के लिए ब्राउज़ बटन का उपयोग करें।',
          'compare.selectSourceFile' => 'स्रोत फ़ाइल चुनें',
          'compare.selectTargetFile' => 'लक्ष्य फ़ाइल चुनें',
          'compare.startComparison' => 'तुलना शुरू करें',
          'compare.comparing' => 'तुलना हो रही है...',
          'compare.comparisonComplete' => 'तुलना पूर्ण',
          'compare.noChanges' => 'कोई परिवर्तन नहीं मिला',
          'compare.filesIdentical' => 'फ़ाइलें समान हैं',
          'compare.changesFound' => ({required Object count}) =>
              '${count} परिवर्तन मिले',
          'compare.tabs.files' => 'फ़ाइलें',
          'compare.tabs.directories' => 'निर्देशिकाएँ',
          'compare.tabs.git' => 'Git',
          'compare.fileTypes.json' =>
            'JSON स्थानीयकरण फ़ाइलें (i18next, Flutter, आदि)',
          'compare.fileTypes.yaml' =>
            'YAML स्थानीयकरण फ़ाइलें (Rails, Flutter)',
          'compare.fileTypes.xml' => 'XML स्थानीयकरण फ़ाइलें (Android, .NET)',
          'compare.fileTypes.properties' => 'Properties फ़ाइलें (Java)',
          'compare.fileTypes.resx' => 'RESX फ़ाइलें (.NET)',
          _ => null,
        } ??
        switch (path) {
          'compare.fileTypes.xliff' => 'XLIFF फ़ाइलें',
          'history.title' => 'इतिहास',
          'history.recentComparisons' => 'हालिया तुलनाएं',
          'history.noHistory' => 'अभी तक कोई तुलना इतिहास नहीं',
          'history.noHistoryDescription' => 'आपका तुलना इतिहास यहाँ दिखाई देगा',
          'history.clearHistory' => 'इतिहास साफ़ करें',
          'history.clearHistoryConfirm' =>
            'क्या आप वाकई सभी इतिहास साफ़ करना चाहते हैं?',
          'history.deleteEntry' => 'प्रविष्टि हटाएं',
          'history.openComparison' => 'तुलना खोलें',
          'history.timeAgo.justNow' => 'अभी',
          'history.timeAgo.secondsAgo' => ({required Object count}) =>
              '${count} सेकंड पहले',
          'history.timeAgo.oneMinuteAgo' => '1 मिनट पहले',
          'history.timeAgo.minutesAgo' => ({required Object count}) =>
              '${count} मिनट पहले',
          'history.timeAgo.oneHourAgo' => '1 घंटा पहले',
          'history.timeAgo.hoursAgo' => ({required Object count}) =>
              '${count} घंटे पहले',
          'history.timeAgo.yesterday' => 'कल',
          'history.timeAgo.daysAgo' => ({required Object count}) =>
              '${count} दिन पहले',
          'history.timeAgo.oneWeekAgo' => '1 सप्ताह पहले',
          'history.timeAgo.weeksAgo' => ({required Object count}) =>
              '${count} सप्ताह पहले',
          'history.timeAgo.oneMonthAgo' => '1 महीने पहले',
          'history.timeAgo.monthsAgo' => ({required Object count}) =>
              '${count} महीने पहले',
          'history.timeAgo.oneYearAgo' => '1 साल पहले',
          'history.timeAgo.yearsAgo' => ({required Object count}) =>
              '${count} साल पहले',
          'history.timeAgo.inTheFuture' => 'भविष्य में',
          'projects.title' => 'प्रोजेक्ट्स',
          'projects.createProject' => 'प्रोजेक्ट बनाएं',
          'projects.importProject' => 'प्रोजेक्ट आयात करें',
          'projects.noProjects' => 'अभी तक कोई प्रोजेक्ट नहीं',
          'projects.noProjectsDescription' =>
            'अपनी स्थानीयकरण फ़ाइलों को व्यवस्थित करने के लिए एक प्रोजेक्ट बनाएं',
          'projects.projectName' => 'प्रोजेक्ट का नाम',
          'projects.projectPath' => 'प्रोजेक्ट पथ',
          'projects.lastOpened' => 'अंतिम बार खोला गया',
          'projects.openProject' => 'प्रोजेक्ट खोलें',
          'projects.closeProject' => 'प्रोजेक्ट बंद करें',
          'projects.deleteProject' => 'प्रोजेक्ट हटाएं',
          'projects.deleteProjectConfirm' =>
            'क्या आप वाकई इस प्रोजेक्ट को हटाना चाहते हैं?',
          'projects.exportProject' => 'प्रोजेक्ट निर्यात करें',
          'projects.exportDescription' =>
            'स्रोत फ़ाइलें, कॉन्फ़िगरेशन और इतिहास युक्त एक पोर्टेबल ज़िप फ़ाइल बनाएं।',
          'projects.exporting' => 'प्रोजेक्ट निर्यात हो रहा है...',
          'projects.exportSuccess' => 'प्रोजेक्ट निर्यात किया गया',
          'projects.exportError' => ({required Object error}) =>
              'निर्यात विफल: ${error}',
          'projects.createNewProject' => 'नया प्रोजेक्ट बनाएं',
          'projects.openExistingProject' => 'मौजूदा प्रोजेक्ट खोलें',
          'projects.importProjectZip' => 'प्रोजेक्ट ज़िप आयात करें',
          'projects.projectResources' => 'प्रोजेक्ट संसाधन',
          'projects.recentProjects' => 'हालिया प्रोजेक्ट्स',
          'projects.noRecentProjects' => 'कोई हालिया प्रोजेक्ट नहीं',
          'projects.selectProjectZip' => 'प्रोजेक्ट ज़िप चुनें',
          'projects.selectDestination' => 'आयात के लिए गंतव्य फ़ोल्डर चुनें',
          'projects.importing' => 'प्रोजेक्ट आयात हो रहा है...',
          'projects.importSuccess' => 'प्रोजेक्ट सफलतापूर्वक आयात किया गया',
          'projects.importFailed' => ({required Object error}) =>
              'आयात विफल: ${error}',
          'projects.importingFiles' => 'फ़ाइलें आयात हो रही हैं...',
          'projects.noSupportedFiles' => 'कोई समर्थित फ़ाइल नहीं छोड़ी गई।',
          'projects.stats.empty' => 'खाली प्रोजेक्ट',
          'projects.stats.files' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
                n,
                one: '1 अनुवाद फ़ाइल',
                other: '${count} अनुवाद फ़ाइलें',
              ),
          'projects.stats.languages' => (
                  {required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
                n,
                one: '1 भाषा',
                other: '${count} भाषाएँ',
              ),
          'projects.openProjectFirst' =>
            'संसाधनों का प्रबंधन करने के लिए पहले एक प्रोजेक्ट खोलें।',
          'projects.removeFromRecent' => 'हालिया से हटाएं',
          'projects.selection.selectFolder' => 'प्रोजेक्ट फ़ोल्डर चुनें',
          'projects.selection.selectArchive' => 'प्रोजेक्ट आर्काइव चुनें',
          'projects.selection.openProject' => 'प्रोजेक्ट खोलें',
          'projects.selection.browseFolder' => 'फ़ोल्डर ब्राउज़ करें...',
          'projects.selection.createNew' => 'नया बनाएं',
          'projects.selection.importFromZip' => 'ज़िप से आयात करें...',
          'projects.createDialog.title' => 'प्रोजेक्ट बनाएं',
          'projects.createDialog.description' =>
            'एक प्रोजेक्ट आपको एक विशिष्ट फ़ोल्डर के लिए कस्टम सेटिंग्स सहेजने देता है। आपकी प्रोजेक्ट कॉन्फ़िगरेशन को संग्रहीत करने के लिए एक ".localizer" फ़ोल्डर बनाया जाएगा।',
          'projects.createDialog.folderLabel' => 'प्रोजेक्ट फ़ोल्डर',
          'projects.createDialog.folderHint' =>
            'फ़ोल्डर चुनने के लिए क्लिक करें...',
          'projects.createDialog.nameLabel' => 'प्रोजेक्ट का नाम',
          'projects.createDialog.nameHint' => 'उदा., मेरा ऐप अनुवाद',
          'projects.createDialog.selectFolderWarning' =>
            'कृपया एक प्रोजेक्ट फ़ोल्डर चुनें।',
          'projects.createDialog.enterNameError' =>
            'कृपया प्रोजेक्ट का नाम दर्ज करें',
          'projects.createDialog.nameLengthError' =>
            'नाम कम से कम 2 अक्षरों का होना चाहिए',
          'projects.createDialog.success' => ({required Object name}) =>
              'प्रोजेक्ट "${name}" सफलतापूर्वक बनाया गया!',
          'projects.createDialog.failure' => 'प्रोजेक्ट बनाने में विफल।',
          'projects.createDialog.creating' => 'बना रहा है...',
          'projects.createDialog.createAction' => 'प्रोजेक्ट बनाएं',
          'projects.indicator.tooltipNoProject' =>
            'फ़ोल्डर के लिए कस्टम सेटिंग्स सहेजने के लिए एक प्रोजेक्ट बनाएं',
          'projects.indicator.tooltipProject' => ({required Object name}) =>
              'प्रोजेक्ट: ${name}\nविकल्प देखने के लिए क्लिक करें',
          'projects.indicator.location' => 'स्थान',
          'projects.indicator.created' => 'बनाया गया',
          'projects.indicator.switchProject' => 'प्रोजेक्ट बदलें',
          'projects.indicator.done' => 'हो गया',
          'projects.glossary.title' => 'प्रोजेक्ट शब्दावली',
          'projects.glossary.description' =>
            'उन शब्दों को परिभाषित करें जिन्हें लगातार माना जाना चाहिए या कभी अनुवादित नहीं किया जाना चाहिए।',
          'projects.glossary.noTerms' => 'अभी तक कोई शब्दावली शब्द नहीं।',
          'projects.glossary.noTermsDesc' =>
            'वे शब्द जोड़ें जो अनुवादों में सुसंगत रहने चाहिए,\nया ब्रांड नाम जिन्हें कभी अनुवादित नहीं किया जाना चाहिए।',
          'projects.glossary.doNotTranslate' => 'अनुवाद न करें',
          'projects.glossary.noSpecificTranslation' =>
            'कोई विशिष्ट अनुवाद नहीं',
          'projects.glossary.addTerm' => 'शब्द जोड़ें',
          'projects.glossary.editTerm' => 'शब्द संपादित करें',
          'projects.glossary.term' => 'शब्द',
          'projects.glossary.termHint' => 'उदा., ब्रांड नाम, विशिष्ट शब्द',
          'projects.glossary.definition' => 'परिभाषा (वैकल्पिक)',
          'projects.glossary.definitionHint' => 'अनुवादक के लिए संदर्भ',
          'projects.glossary.doNotTranslateLabel' => 'अनुवाद न करें',
          'projects.glossary.doNotTranslateDesc' =>
            'लक्ष्य में शब्द को बिल्कुल वैसा ही रखें',
          'projects.glossary.preferredTranslation' => 'पसंदीदा अनुवाद',
          'projects.glossary.caseSensitive' => 'केस संवेदी',
          'projects.conflicts.missingApiKeyTitle' =>
            ({required Object service}) => '${service} के लिए API कुंजी गायब',
          'projects.conflicts.missingApiKeyMessage' => (
                  {required Object service}) =>
              'यह प्रोजेक्ट ${service} का उपयोग करता है लेकिन कोई API कुंजी कॉन्फ़िगर नहीं की गई है। सेटिंग्स > AI सेवाएँ में अपनी API कुंजी जोड़ें, या ऐप वैश्विक डिफ़ॉल्ट का उपयोग करेगा।',
          'projects.conflicts.dismiss' => 'खारिज करें',
          'projects.tm.title' => 'अनुवाद यादें',
          'projects.tm.description' =>
            'इस प्रोजेक्ट के लिए अनुवाद स्मृति स्रोतों का प्रबंधन करें।',
          'projects.tm.globalTm' => 'वैश्विक अनुवाद स्मृति',
          'projects.tm.globalTmDescription' =>
            'अपनी ऐप सेटिंग्स से साझा अनुवाद स्मृति का उपयोग करें',
          'projects.tm.linkedFiles' => 'लिंक की गई फ़ाइलें (प्रोजेक्ट विशिष्ट)',
          'projects.tm.noLinkedFiles' =>
            'कोई प्रोजेक्ट-विशिष्ट फ़ाइल लिंक नहीं की गई।',
          'projects.tm.addTmFile' => 'TM फ़ाइल जोड़ें',
          'projects.tm.useGlobalTm' => 'वैश्विक TM का उपयोग करें',
          'projects.tm.selectTm' => 'अनुवाद स्मृति चुनें',
          'projects.tm.globalTmEnabled' => 'वैश्विक अनुवाद स्मृति सक्षम',
          'diff.added' => 'जोड़ा गया',
          'diff.removed' => 'हटाया गया',
          'diff.modified' => 'संशोधित',
          'diff.unchanged' => 'अपरिवर्तित',
          'diff.missing' => 'लापता',
          'diff.extra' => 'अतिरिक्त',
          'diff.sourceValue' => 'स्रोत मान',
          'diff.targetValue' => 'लक्ष्य मान',
          'diff.key' => 'कुंजी',
          'diff.status' => 'स्थिति',
          'diff.actions' => 'क्रियाएं',
          'diff.copyToTarget' => 'लक्ष्य में कॉपी करें',
          'diff.acceptChange' => 'परिवर्तन स्वीकार करें',
          'diff.rejectChange' => 'परिवर्तन अस्वीकार करें',
          'diff.viewDetails' => 'विवरण देखें',
          'git._translatorNote' =>
            'Git terms (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) should remain in English for all translations to avoid confusion among developers.',
          'git.title' => 'Git तुलना',
          'git.selectRepository' => 'रिपॉजिटरी चुनें',
          'git.selectBranch' => 'Branch चुनें',
          'git.selectCommit' => 'Commit चुनें',
          'git.compareBranches' => 'Branches की तुलना करें',
          'git.compareCommits' => 'Commits की तुलना करें',
          'git.baseBranch' => 'आधार Branch',
          'git.compareBranch' => 'तुलना Branch',
          'git.noRepositories' => 'कोई Git रिपॉजिटरी नहीं मिली',
          'git.noRepositoriesDescription' =>
            'एक Git रिपॉजिटरी वाला फ़ोल्डर खोलें',
          'git.filesChanged' => ({required Object count}) =>
              '${count} फ़ाइलें बदलीं',
          'git.additions' => ({required Object count}) => '${count} जोड़',
          'git.deletions' => ({required Object count}) => '${count} हटाना',
          'git.conflicts.title' => 'मर्ज संघर्ष का पता चला',
          'git.conflicts.description' =>
            'जारी रखने से पहले आपको इन संघर्षों को हल करना होगा।',
          'git.conflicts.abortMergeTitle' => 'मर्ज रद्द करें?',
          'git.conflicts.abortMergeContent' =>
            'यह सभी मर्ज परिवर्तनों को वापस लाएगा और मर्ज से पहले की स्थिति में लौट आएगा। यह क्रिया पूर्ववत नहीं की जा सकती।',
          'git.conflicts.abortMergeAction' => 'मर्ज रद्द करें',
          'git.conflicts.stagingFile' => ({required Object file}) =>
              '${file} को commit के लिए stage कर रहा है...',
          'git.conflicts.conflictedFilesCount' => ({required Object count}) =>
              'संघर्षित फ़ाइलें (${count})',
          'git.conflicts.selectFileToResolve' =>
            'हल करने के लिए एक फ़ाइल चुनें',
          'git.conflicts.resolvingFile' => ({required Object file}) =>
              'हल कर रहा है: ${file}',
          'git.conflicts.keepAllOurs' => 'सभी हमारे रखें (Ours)',
          'git.conflicts.acceptAllTheirs' => 'सभी उनके स्वीकार करें (Theirs)',
          'git.conflicts.allResolved' =>
            'इस फ़ाइल में सभी संघर्ष हल हो गए हैं!',
          'git.conflicts.markResolved' => 'हल किया गया चिह्नित करें',
          'git.conflicts.stageForCommit' =>
            'यह फ़ाइल को commit के लिए stage करेगा।',
          'git.conflicts.conflictIndex' => ({required Object index}) =>
              'संघर्ष #${index}',
          'git.conflicts.ours' => 'हमारा (वर्तमान)',
          'git.conflicts.theirs' => 'उनका (आने वाला)',
          'git.conflicts.keepOurs' => 'हमारा रखें',
          'git.conflicts.acceptTheirs' => 'उनका स्वीकार करें',
          'git.conflicts.empty' => '(खाली)',
          'quality._translatorNote' =>
            'API and metric terms (Requests, Tokens, Characters, Prompt, Completion, Export) should remain in English for all translations to maintain consistency with industry terminology.',
          'quality.title' => 'गुणवत्ता डैशबोर्ड',
          'quality.overallScore' => 'समग्र स्कोर',
          'quality.issues' => 'समस्याएं',
          'quality.warnings' => 'चेतावनियाँ',
          'quality.suggestions' => 'सुझाव',
          'quality.placeholderMismatch' => 'प्लेसहोल्डर बेमेल',
          'quality.placeholderMismatchDescription' =>
            '{name} जैसे प्लेसहोल्डर स्रोत और लक्ष्य के बीच मेल नहीं खाते',
          'quality.lengthOutlier' => 'लंबाई आउटलियर',
          'quality.lengthOutlierDescription' =>
            'अनुवाद की लंबाई स्रोत से काफी भिन्न है',
          'quality.duplicateValue' => 'दोहराया गया मान',
          'quality.duplicateValueDescription' =>
            'कई कुंजियों के लिए समान अनुवाद का उपयोग किया गया',
          'quality.missingTranslation' => 'लापता अनुवाद',
          'quality.missingTranslationDescription' =>
            'इस कुंजी के लिए अनुवाद गायब है',
          'quality.loading' => 'डैशबोर्ड लोड हो रहा है...',
          'quality.errorLoading' =>
            'हम आपका इतिहास लोड नहीं कर सके। पुनः प्रयास करें।',
          'quality.emptyState' => 'अपना डैशबोर्ड देखने के लिए तुलना चलाएं।',
          'quality.refresh' => 'ताज़ा करें',
          'quality.buildingInsights' => 'अंतर्दृष्टि बना रहा है...',
          'quality.crunchingNumbers' => 'संख्याओं को क्रंच कर रहा है...',
          'quality.errorBuilding' =>
            'हम डैशबोर्ड नहीं बना सके। पुनः प्रयास करें।',
          'quality.noUsableData' => 'अभी तक कोई उपयोगी डेटा नहीं मिला।',
          'quality.languages' => 'भाषाएँ',
          'quality.averageCoverage' => 'औसत कवरेज',
          'quality.potentialIssues' => 'संभावित समस्याएं',
          'quality.translationCoverage' => 'अनुवाद कवरेज',
          'quality.entriesTranslated' => (
                  {required Object total, required Object translated}) =>
              '${total} में से ${translated} प्रविष्टियाँ अनुवादित',
          'quality.wordsAddedOverTime' => 'समय के साथ जोड़े गए शब्द',
          'quality.completionVsScope' => 'पूर्णता बनाम स्कोप',
          'quality.scopeVsProgress' => 'स्कोप बनाम प्रगति',
          'quality.coveragePercent' => 'कवरेज %',
          'quality.wordsAdded' => 'जोड़े गए शब्द',
          'quality.words' => 'शब्द',
          'quality.coverage' => 'कवरेज',
          'quality.scope' => 'स्कोप',
          'quality.latest' => 'नवीनतम',
          'quality.added' => 'जोड़ा गया',
          'quality.change' => 'परिवर्तन',
          'quality.totalScope' => 'कुल स्कोप',
          'quality.wordsCount' => ({required Object count}) => '${count} शब्द',
          'quality.scopeGrowth' => 'स्कोप वृद्धि',
          'quality.range' => 'रेंज',
          'quality.aiUsage' => 'AI और अनुवाद उपयोग',
          'quality.lastUsed' => ({required Object date}) =>
              'अंतिम उपयोग ${date}',
          'quality.noIssuesFound' => 'नवीनतम तुलना में कोई समस्या नहीं मिली।',
          'quality.placeholderMismatches' => 'प्लेसहोल्डर बेमेल',
          'quality.placeholderMismatchesDesc' =>
            '{name} जैसे मार्कर मेल नहीं खाते।',
          'quality.lengthOutliers' => 'बहुत छोटे या लंबे अनुवाद',
          'quality.lengthOutliersDesc' =>
            'स्रोत की तुलना में लंबाई असामान्य लगती है।',
          'quality.duplicateValues' => 'दोहराए गए मान',
          'quality.duplicateValuesDesc' =>
            'समान अनुवाद कई बार उपयोग किया जाता है।',
          'quality.placeholderDialogTitle' => 'प्लेसहोल्डर बेमेल',
          'quality.placeholderDialogDesc' =>
            'इन अनुवादों में स्रोत से अलग प्लेसहोल्डर ({name}) हैं।',
          'quality.lengthDialogTitle' => 'लंबाई आउटलियर',
          'quality.lengthDialogDesc' =>
            'ये अनुवाद स्रोत की तुलना में काफी छोटे या लंबे हैं।',
          'quality.duplicateDialogTitle' => 'दोहराए गए मान',
          'quality.duplicateDialogDesc' => 'ये अनुवाद कई बार दिखाई देते हैं।',
          'quality.duplicateSample' => ({required Object value}) =>
              'डुप्लिकेट: "${value}"',
          'quality.exportError' =>
            'रिपोर्ट नहीं बना सका। कृपया पुनः प्रयास करें।',
          'quality.noDataToExport' => 'निर्यात करने के लिए कोई डेटा नहीं',
          'quality.exportFailed' => 'निर्यात विफल',
          'quality.exportDialogTitle' => 'गुणवत्ता रिपोर्ट निर्यात करें',
          'quality.reportSaved' => 'रिपोर्ट सहेजी गई',
          'quality.export' => 'निर्यात',
          'quality.requests' => 'अनुरोध',
          'quality.tokens' => 'टोकन',
          'quality.characters' => 'अक्षर',
          'quality.estCost' => 'अनुमानित लागत',
          'quality.prompt' => 'प्रॉम्प्ट',
          'quality.completion' => 'पूर्णता',
          'quality.showingCurrentProject' => 'दिखा रहा है: वर्तमान प्रोजेक्ट',
          'quality.showingAllHistory' => 'दिखा रहा है: सभी इतिहास',
          'quality.filesSkipped' =>
            'कुछ फ़ाइलें छोड़ दी गईं क्योंकि वे नहीं मिलीं।',
          'quality.charCount' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
                n,
                one: '1 अक्षर',
                other: '${count} अक्षर',
              ),
          'quality.lengthDiff' => (
                  {required Object target,
                  required Object percent,
                  required Object source}) =>
              'लक्ष्य ${target} है (${percent}%) बनाम स्रोत ${source}',
          'errors.genericError' => 'एक त्रुटि हुई',
          'errors.fileNotFound' => 'फ़ाइल नहीं मिली',
          'errors.invalidFormat' => 'अमान्य फ़ाइल प्रारूप',
          'errors.parseError' => 'फ़ाइल पार्स करने में विफल',
          'errors.networkError' => 'नेटवर्क त्रुटि। कृपया अपना कनेक्शन जांचें।',
          'errors.permissionDenied' => 'अनुमति अस्वीकृत',
          'errors.unknownError' => 'एक अज्ञात त्रुटि हुई',
          'wizards.firstRun.welcome' => 'Localizer में आपका स्वागत है',
          'wizards.firstRun.description' =>
            'सेकंड में अपनी स्थानीयकरण फ़ाइलों की तुलना करें।',
          'wizards.firstRun.sourceFile' => 'स्रोत फ़ाइल',
          'wizards.firstRun.targetFile' => 'लक्ष्य फ़ाइल',
          'wizards.firstRun.compareNow' => 'अब तुलना करें',
          'wizards.firstRun.trySample' => 'नमूना डेटा के साथ प्रयास करें',
          'wizards.firstRun.skip' => 'सेटअप छोड़ें',
          'wizards.firstRun.browse' => 'ब्राउज़ करने के लिए क्लिक करें',
          'wizards.firstRun.error' => ({required Object error}) =>
              'नमूना डेटा लोड करने में विफल: ${error}',
          'dialogs.addIgnorePattern.title' => 'अनदेखा पैटर्न जोड़ें',
          'dialogs.addIgnorePattern.patternLabel' => 'पैटर्न (regex)',
          'dialogs.addIgnorePattern.hint' => 'उदाहरण, ^temp_.*',
          'dialogs.addIgnorePattern.invalid' => 'अमान्य regex पैटर्न',
          'dialogs.addIgnorePattern.testStringLabel' => 'परीक्षण स्ट्रिंग',
          'dialogs.addIgnorePattern.testHint' =>
            'पैटर्न के विरुद्ध परीक्षण करने के लिए एक कुंजी दर्ज करें',
          'dialogs.addIgnorePattern.match' =>
            '✓ पैटर्न परीक्षण स्ट्रिंग से मेल खाता है',
          'dialogs.addIgnorePattern.noMatch' => '✗ पैटर्न मेल नहीं खाता',
          'dialogs.addIgnorePattern.add' => 'जोड़ें',
          'dialogs.addIgnorePattern.cancel' => 'रद्द करें',
          'dialogs.diffViewer.title' => 'Diff व्यूअर',
          'dialogs.diffViewer.originalFile' => 'मूल/संदर्भ फ़ाइल',
          'dialogs.diffViewer.translationFile' => 'अनुवाद/तुलना फ़ाइल',
          'dialogs.diffViewer.base' => 'आधार',
          'dialogs.diffViewer.target' => 'लक्ष्य',
          'dialogs.diffViewer.added' => 'जोड़ा गया',
          'dialogs.diffViewer.removed' => 'हटाया गया',
          'dialogs.diffViewer.modified' => 'संशोधित',
          'dialogs.diffViewer.noMatches' =>
            'वर्तमान फ़िल्टर से कोई प्रविष्टियाँ मेल नहीं खातीं',
          'dialogs.diffViewer.clickToggle' =>
            'फ़िल्टर टॉगल करने के लिए ऊपर दिए गए बैज पर क्लिक करें',
          'dialogs.diffViewer.clickToHide' => '(छिपाने के लिए क्लिक करें)',
          'dialogs.diffViewer.clickToShow' => '(दिखाने के लिए क्लिक करें)',
          'dialogs.confirm' => 'पुष्टि करें',
          'dialogs.cancel' => 'रद्द करें',
          'dialogs.ok' => 'ठीक है',
          'dialogs.yes' => 'हाँ',
          'dialogs.no' => 'नहीं',
          'dialogs.save' => 'सहेजें',
          'dialogs.delete' => 'हटाएं',
          'dialogs.close' => 'बंद करें',
          'dialogs.error' => 'त्रुटि',
          'dialogs.success' => 'सफलता',
          'dialogs.warning' => 'चेतावनी',
          'dialogs.info' => 'जानकारी',
          'dialogs.unsavedChanges' => 'बिना सहेजे परिवर्तन',
          'dialogs.unsavedContent' =>
            'आपके पास बिना सहेजे परिवर्तन हैं। क्या आप उन्हें सहेजना चाहते हैं?',
          'dialogs.saveChanges' => 'परिवर्तन सहेजें?',
          'dialogs.discardChanges' => 'परिवर्तनों को त्यागें?',
          'dialogs.deleteConfirm' =>
            'क्या आप वाकई इसे हटाना चाहते हैं? यह क्रिया पूर्ववत नहीं की जा सकती।',
          'dialogs.confirmation' => 'पुष्टि आवश्यक',
          'grid.columns.key' => 'कुंजी',
          'grid.columns.source' => 'स्रोत',
          'grid.columns.status' => 'स्थिति',
          'grid.columns.actions' => 'क्रियाएं',
          'tutorial.skipTutorial' => 'ट्यूटोरियल छोड़ें',
          'tutorial.finishMessage' =>
            'आप पूरी तरह तैयार हैं! समाप्त करने के लिए कहीं भी टैप करें।',
          'tutorial.next' => 'अगला',
          'tutorial.loadSampleData' => 'नमूना डेटा लोड करें',
          'tutorial.browseSourceFile' => 'स्रोत फ़ाइल ब्राउज़ करें',
          'tutorial.browseTargetFile' => 'लक्ष्य फ़ाइल ब्राउज़ करें',
          'tutorial.compareFiles' => 'फ़ाइलों की तुलना करें',
          'tutorial.hintPhase2' =>
            'अगला: फ़िल्टर, खोज, उन्नत दृश्य, और निर्यात।',
          'tutorial.steps.importSource.title' => '1. स्रोत फ़ाइल आयात करें',
          'tutorial.steps.importSource.description' =>
            'फ़ाइल के लिए ब्राउज़ करने के लिए नीचे दिए गए बटन का उपयोग करें, या हाइलाइट किए गए क्षेत्र पर खींचें और छोड़ें।',
          'tutorial.steps.importTarget.title' => '2. लक्ष्य फ़ाइल आयात करें',
          'tutorial.steps.importTarget.description' =>
            'फ़ाइल के लिए ब्राउज़ करने के लिए नीचे दिए गए बटन का उपयोग करें, या हाइलाइट किए गए क्षेत्र पर खींचें और छोड़ें।',
          'tutorial.steps.compare.title' => '3. फ़ाइलों की तुलना करें',
          'tutorial.steps.compare.description' =>
            'तुलना चलाने और परिणाम देखने के लिए नीचे दिए गए बटन को टैप करें।',
          'tutorial.steps.filter.title' => '4. परिणाम फ़िल्टर करें',
          'tutorial.steps.filter.description' =>
            'जोड़े गए, हटाए गए, या संशोधित स्ट्रिंग्स को देखने के लिए इन फ़िल्टर का उपयोग करें।',
          'tutorial.steps.search.title' => '5. खोज परिणाम',
          'tutorial.steps.search.description' =>
            'खोज बार का उपयोग करके विशिष्ट कुंजियाँ या मान खोजें।',
          'tutorial.steps.advanced.title' => '6. उन्नत दृश्य',
          'tutorial.steps.advanced.description' =>
            'संपादन, एआई अनुवाद, और अधिक के साथ विस्तृत अंतर दृश्य खोलें।',
          'tutorial.steps.export.title' => '7. परिणाम निर्यात करें',
          'tutorial.steps.export.description' =>
            'अपनी तुलना को CSV, JSON, या Excel फ़ाइल के रूप में सहेजें।',
          'friendlyErrors.fileNotFound.message' =>
            'फ़ाइल या फ़ोल्डर नहीं मिला।',
          'friendlyErrors.fileNotFound.suggestion' =>
            'जाँचें कि क्या फ़ाइल को स्थानांतरित या हटा दिया गया था।',
          'friendlyErrors.accessDenied.message' =>
            'फ़ाइल तक पहुँच अस्वीकृत कर दी गई थी।',
          'friendlyErrors.accessDenied.suggestion' =>
            'ऐप को प्रशासक के रूप में चलाने का प्रयास करें या फ़ाइल अनुमतियां जांचें।',
          'friendlyErrors.isDirectory.message' =>
            'फ़ाइल के बजाय एक फ़ोल्डर चुना गया था।',
          'friendlyErrors.isDirectory.suggestion' =>
            'कृपया एक वैध फ़ाइल चुनें।',
          'friendlyErrors.fileAccess.message' =>
            'फ़ाइल तक पहुँचने में समस्या थी।',
          'friendlyErrors.fileAccess.suggestion' =>
            'इसे उपयोग कर रहे अन्य प्रोग्राम बंद करने का प्रयास करें।',
          'friendlyErrors.unsupportedFormat.message' =>
            'यह फ़ाइल प्रारूप या ऑपरेशन समर्थित नहीं है।',
          'friendlyErrors.unsupportedFormat.suggestion' =>
            'फ़ाइल एक्सटेंशन चेक करें या कोई अलग प्रारूप आज़माएं।',
          'friendlyErrors.networkError.message' =>
            'सर्वर से कनेक्ट नहीं हो सका।',
          'friendlyErrors.networkError.suggestion' =>
            'अपने इंटरनेट कनेक्शन की जाँच करें और पुन: प्रयास करें।',
          'friendlyErrors.notGitRepo.message' =>
            'यह फ़ोल्डर Git प्रोजेक्ट नहीं है।',
          'friendlyErrors.notGitRepo.suggestion' =>
            'उस फ़ोल्डर में नेविगेट करें जिसमें .git डायरेक्टरी हो।',
          'friendlyErrors.mergeConflict.message' =>
            'रिपॉजिटरी में मर्ज संघर्ष हैं।',
          'friendlyErrors.mergeConflict.suggestion' =>
            'जारी रखने से पहले संघर्षों को हल करें।',
          'friendlyErrors.gitAuthFailed.message' => 'Git प्रमाणीकरण विफल रहा।',
          'friendlyErrors.gitAuthFailed.suggestion' =>
            'सेटिंग्स > संस्करण नियंत्रण में अपने क्रेडेंशियल्स की जाँच करें।',
          'friendlyErrors.gitOperationFailed.message' => 'Git ऑपरेशन विफल रहा।',
          'friendlyErrors.gitOperationFailed.suggestion' =>
            'अधिक विवरण के लिए Git दृश्य देखें।',
          'friendlyErrors.invalidJson.message' =>
            'फ़ाइल प्रारूप अमान्य या दूषित है।',
          'friendlyErrors.invalidJson.suggestion' =>
            'सुनिश्चित करें कि फ़ाइल में वैध JSON सामग्री है।',
          'friendlyErrors.rateLimitReached.message' =>
            'अनुवाद सीमा समाप्त हो गई।',
          'friendlyErrors.rateLimitReached.suggestion' =>
            'कुछ मिनट प्रतीक्षा करें या अपनी API योजना सीमाएं जांचें।',
          'friendlyErrors.invalidApiKey.message' => 'अमान्य API कुंजी।',
          'friendlyErrors.invalidApiKey.suggestion' =>
            'अपनी API कुंजी अपडेट करने के लिए सेटिंग्स > AI अनुवाद पर जाएं।',
          'friendlyErrors.translationServiceError.message' =>
            'अनुवाद सेवा त्रुटि।',
          'friendlyErrors.translationServiceError.suggestion' =>
            'अपनी API कुंजी और इंटरनेट कनेक्शन की जाँच करें।',
          'friendlyErrors.outOfMemory.message' =>
            'इस ऑपरेशन को पूरा करने के लिए पर्याप्त मेमोरी नहीं है।',
          'friendlyErrors.outOfMemory.suggestion' =>
            'अन्य एप्लिकेशन बंद करने या छोटी फ़ाइलों का उपयोग करने का प्रयास करें।',
          'friendlyErrors.genericError.message' => 'कुछ गलत हो गया।',
          'friendlyErrors.genericError.suggestion' =>
            'कृपया पुन: प्रयास करें। यदि समस्या बनी रहती है, तो ऐप को पुनरारंभ करें।',
          'systemTray.showLocalizer' => 'Localizer दिखाएं',
          'systemTray.exit' => 'बाहर निकलें',
          'validation.connected' => 'जुड़ा हुआ।',
          'validation.connectionTimeout' =>
            'कनेक्शन टाइमआउट। कृपया पुनः प्रयास करें।',
          'validation.couldNotConnect' =>
            'कनेक्ट नहीं हो सका। कृपया पुनः प्रयास करें।',
          'validation.checkKeyAndTryAgain' =>
            'कनेक्ट नहीं हो सका। कृपया कुंजी की जाँच करें और पुनः प्रयास करें।',
          'validation.tryAgainLater' =>
            'अभी कनेक्ट नहीं हो सका। कृपया बाद में पुनः प्रयास करें।',
          'validation.serviceUnavailable' =>
            'सेवा अभी अनुपलब्ध है। कृपया बाद में पुनः प्रयास करें।',
          'validation.enterKeyFirst' => 'कृपया पहले एक कुंजी दर्ज करें।',
          'validation.checking' => 'जाँच हो रही है...',
          'validation.deeplUsage' => (
                  {required Object used, required Object limit}) =>
              'उपयोग: ${used} / ${limit} अक्षर।',
          'status.startingComparison' => 'तुलना शुरू हो रही है...',
          'status.loadingFromHistory' => 'इतिहास से फ़ाइलें लोड हो रही हैं...',
          'status.comparisonComplete' => 'तुलना पूर्ण',
          'status.couldNotImportFiles' =>
            'फ़ाइलों को आयात नहीं कर सका। कृपया पुनः प्रयास करें।',
          'status.historyFilesNotFound' =>
            'इतिहास से एक या दोनों फ़ाइलें मूल पथ पर नहीं मिलीं।',
          'aiServices.geminiEmptyResponse' => 'Gemini ने खाली प्रतिक्रिया दी',
          'aiServices.geminiStreamingEmpty' =>
            'Gemini स्ट्रीमिंग ने खाली प्रतिक्रिया दी',
          'aiServices.geminiRephraseEmpty' =>
            'Gemini ने रिफ्रेश के लिए खाली प्रतिक्रिया दी',
          'aiServices.openaiEmptyResponse' =>
            'OpenAI ने खाली या विफल प्रतिक्रिया दी',
          'diffTable.columns.id' => '#',
          'diffTable.columns.status' => 'स्थिति',
          'diffTable.columns.key' => 'कुंजी',
          'diffTable.columns.source' => 'स्रोत',
          'diffTable.columns.target' => 'लक्ष्य',
          'diffTable.empty' => 'प्रदर्शित करने के लिए कोई प्रविष्टियाँ नहीं',
          'diffTable.pagination.show' => 'दिखाएं',
          'diffTable.messages.addedToTM' => 'अनुवाद स्मृति में जोड़ा गया',
          'diffTable.messages.reverted' => 'प्रविष्टि वापस आ गई',
          'diffTable.messages.deleted' => 'प्रविष्टि हटाई गई',
          'diffTable.messages.appliedAndAdded' =>
            'लागू किया गया और TM में जोड़ा गया',
          'diffTable.editDialog.title' => ({required Object key}) =>
              'संपादित करें: ${key}',
          'diffTable.editDialog.sourceLabel' => 'स्रोत',
          'diffTable.editDialog.targetLabel' => 'लक्ष्य',
          'diffTable.editDialog.hint' => 'अनुवाद दर्ज करें...',
          'diffTable.editDialog.cancel' => 'रद्द करें',
          'diffTable.editDialog.applyAndAdd' => 'लागू करें और TM में जोड़ें',
          'diffTable.editDialog.apply' => 'लागू करें',
          'onboarding.gettingStarted' => 'शुरू करना',
          'onboarding.stepProgress' => (
                  {required Object total, required Object current}) =>
              '${total} में से ${current} कदम',
          'onboarding.skipTutorial' => 'ट्यूटोरियल छोड़ें',
          'onboarding.loadSampleData' => 'नमूना डेटा लोड करें',
          'onboarding.steps.importFiles.title' => 'फ़ाइलें आयात करें',
          'onboarding.steps.importFiles.description' =>
            'तुलना करने के लिए अपनी स्रोत और लक्ष्य स्थानीयकरण फ़ाइलें लोड करें',
          'onboarding.steps.runComparison.title' => 'तुलना चलाएं',
          'onboarding.steps.runComparison.description' =>
            'अंतर और लापता कुंजियों को खोजने के लिए फ़ाइलों की तुलना शुरू करें',
          'onboarding.steps.reviewMissing.title' => 'लापता समीक्षा करें',
          'onboarding.steps.reviewMissing.description' =>
            'उन प्रविष्टियों की जाँच करें जो लक्ष्य फ़ाइल में गायब हैं',
          'onboarding.steps.useFilters.title' => 'फ़िल्टर का उपयोग करें',
          'onboarding.steps.useFilters.description' =>
            'स्थिति, श्रेणी या खोज शब्द द्वारा परिणाम फ़िल्टर करें',
          'onboarding.steps.searchResults.title' => 'खोज परिणाम',
          'onboarding.steps.searchResults.description' =>
            'विशिष्ट कुंजियाँ या अनुवाद खोजने के लिए खोज बार का उपयोग करें',
          'onboarding.steps.advancedView.title' => 'उन्नत दृश्य',
          'onboarding.steps.advancedView.description' =>
            'विस्तृत साइड-बाय-साइड तुलना के लिए उन्नत दृश्य पर स्विच करें',
          'onboarding.steps.editCell.title' => 'प्रविष्टियाँ संपादित करें',
          'onboarding.steps.editCell.description' =>
            'सीधे अनुवाद संपादित करने के लिए सेल पर क्लिक करें',
          'onboarding.steps.exportResults.title' => 'परिणाम निर्यात करें',
          'onboarding.steps.exportResults.description' =>
            'अपने परिवर्तन सहेजें या तुलना परिणाम निर्यात करें',
          _ => null,
        };
  }
}
