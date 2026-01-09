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
class TranslationsTr extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsTr(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.tr,
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

  /// Metadata for the translations of <tr>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsTr _root = this; // ignore: unused_field

  @override
  TranslationsTr $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsTr(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsAppTr app = _TranslationsAppTr._(_root);
  @override
  late final _TranslationsCommonTr common = _TranslationsCommonTr._(_root);
  @override
  late final _TranslationsMenuTr menu = _TranslationsMenuTr._(_root);
  @override
  late final _TranslationsNavTr nav = _TranslationsNavTr._(_root);
  @override
  late final _TranslationsSettingsTr settings =
      _TranslationsSettingsTr._(_root);
  @override
  late final _TranslationsFileComparisonTr fileComparison =
      _TranslationsFileComparisonTr._(_root);
  @override
  late final _TranslationsDirectoryComparisonTr directoryComparison =
      _TranslationsDirectoryComparisonTr._(_root);
  @override
  late final _TranslationsGitComparisonTr gitComparison =
      _TranslationsGitComparisonTr._(_root);
  @override
  late final _TranslationsAdvancedComparisonTr advancedComparison =
      _TranslationsAdvancedComparisonTr._(_root);
  @override
  late final _TranslationsAdvancedDiffTr advancedDiff =
      _TranslationsAdvancedDiffTr._(_root);
  @override
  late final _TranslationsIssueDetailsTr issueDetails =
      _TranslationsIssueDetailsTr._(_root);
  @override
  late final _TranslationsImportReviewTr importReview =
      _TranslationsImportReviewTr._(_root);
  @override
  late final _TranslationsHistoryViewTr historyView =
      _TranslationsHistoryViewTr._(_root);
  @override
  late final _TranslationsCompareTr compare = _TranslationsCompareTr._(_root);
  @override
  late final _TranslationsHistoryTr history = _TranslationsHistoryTr._(_root);
  @override
  late final _TranslationsProjectsTr projects =
      _TranslationsProjectsTr._(_root);
  @override
  late final _TranslationsDiffTr diff = _TranslationsDiffTr._(_root);
  @override
  late final _TranslationsGitTr git = _TranslationsGitTr._(_root);
  @override
  late final _TranslationsQualityTr quality = _TranslationsQualityTr._(_root);
  @override
  late final _TranslationsErrorsTr errors = _TranslationsErrorsTr._(_root);
  @override
  late final _TranslationsWizardsTr wizards = _TranslationsWizardsTr._(_root);
  @override
  late final _TranslationsDialogsTr dialogs = _TranslationsDialogsTr._(_root);
  @override
  late final _TranslationsGridTr grid = _TranslationsGridTr._(_root);
  @override
  late final _TranslationsTutorialTr tutorial =
      _TranslationsTutorialTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsTr friendlyErrors =
      _TranslationsFriendlyErrorsTr._(_root);
  @override
  late final _TranslationsSystemTrayTr systemTray =
      _TranslationsSystemTrayTr._(_root);
  @override
  late final _TranslationsValidationTr validation =
      _TranslationsValidationTr._(_root);
  @override
  late final _TranslationsStatusTr status = _TranslationsStatusTr._(_root);
  @override
  late final _TranslationsAiServicesTr aiServices =
      _TranslationsAiServicesTr._(_root);
}

// Path: app
class _TranslationsAppTr extends TranslationsAppEn {
  _TranslationsAppTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Yerelleştirme Karşılaştırma Aracı';
  @override
  String get name => 'Localizer';
}

// Path: common
class _TranslationsCommonTr extends TranslationsCommonEn {
  _TranslationsCommonTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get save => 'Kaydet';
  @override
  String get cancel => 'İptal';
  @override
  String get close => 'Kapat';
  @override
  String get delete => 'Sil';
  @override
  String get edit => 'Düzenle';
  @override
  String get add => 'Ekle';
  @override
  String get search => 'Ara';
  @override
  String get undo => 'Geri Al';
  @override
  String get loading => 'Yükleniyor...';
  @override
  String get error => 'Hata';
  @override
  String get success => 'Başarılı';
  @override
  String get warning => 'Uyarı';
  @override
  String get info => 'Bilgi';
  @override
  String get confirm => 'Onayla';
  @override
  String get yes => 'Evet';
  @override
  String get no => 'Hayır';
  @override
  String get ok => 'Tamam';
  @override
  String get retry => 'Tekrar Dene';
  @override
  String get copyText => 'Kopyala';
  @override
  String get appName => 'Localizer';
  @override
  String get copied => 'Kopyalandı!';
  @override
  String get enabled => 'Etkin';
  @override
  String get disabled => 'Devre Dışı';
  @override
  String get browse => 'Gözat';
  @override
  String get clear => 'Temizle';
  @override
  String get apply => 'Uygula';
  @override
  String get reset => 'Sıfırla';
  @override
  String get refresh => 'Yenile';
  @override
  String get export => 'Dışa Aktar';
  @override
  String get import => 'İçe Aktar';
  @override
  String get select => 'Seç';
  @override
  String get selectAll => 'Tümünü Seç';
  @override
  String get deselectAll => 'Seçimi Kaldır';
  @override
  String get noResults => 'Sonuç bulunamadı';
  @override
  String get emptyState => 'Henüz bir şey yok';
  @override
  String get open => 'Aç';
  @override
  String get change => 'Değiştir';
  @override
  String get original => 'Orijinal';
  @override
  String get kNew => 'Yeni';
  @override
  String get remove => 'Kaldır';
  @override
  String get auto => 'Otomatik';
  @override
  String get execute => 'Çalıştır';
  @override
  String get run => 'Çalıştır';
  @override
  String get unknown => 'Bilinmeyen';
  @override
  String get download => 'İndir';
  @override
  String get dropdownArrow => 'Açılır menü oku';
  @override
  String get openInNewWindow => 'Yeni pencerede açar';
  @override
  String get resetToDefaults => 'Varsayılanlara sıfırla';
}

// Path: menu
class _TranslationsMenuTr extends TranslationsMenuEn {
  _TranslationsMenuTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get file => 'Dosya';
  @override
  String get edit => 'Düzenle';
  @override
  String get view => 'Görünüm';
  @override
  String get help => 'Yardım';
  @override
  String get openFiles => 'Dosyaları Aç...';
  @override
  String get openFolder => 'Klasör Aç...';
  @override
  String get exportResults => 'Sonuçları Dışa Aktar...';
  @override
  String get undo => 'Geri Al';
  @override
  String get redo => 'Yinele';
  @override
  String get cut => 'Kes';
  @override
  String get paste => 'Yapıştır';
  @override
  String get selectAll => 'Tümünü Seç';
  @override
  String get zoomIn => 'Yakınlaştır';
  @override
  String get zoomOut => 'Uzaklaştır';
  @override
  String get resetZoom => 'Yakınlaştırmayı Sıfırla';
  @override
  String get documentation => 'Belgeler';
  @override
  String get reportIssue => 'Sorun Bildir';
  @override
  String about({required Object appName}) => '${appName} Hakkında';
}

// Path: nav
class _TranslationsNavTr extends TranslationsNavEn {
  _TranslationsNavTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get compare => 'Karşılaştır';
  @override
  String get history => 'Geçmiş';
  @override
  String get settings => 'Ayarlar';
  @override
  String get projects => 'Projeler';
  @override
  String get dashboard => 'Pano';
  @override
  String get directory => 'Dizin';
  @override
  String get repository => 'Repo';
  @override
  String get tooltipCompare => 'Yerelleştirme dosyalarını karşılaştır';
  @override
  String get tooltipHistory => 'Karşılaştırma geçmişini görüntüle';
  @override
  String get tooltipSettings => 'Uygulama ayarları';
  @override
  String get tooltipProjects => 'Projeleri yönet';
  @override
  String get tooltipThemeToggle => 'Temayı Değiştir';
  @override
  String get tooltipDebugConsole => 'Hata Ayıklama Konsolu';
}

// Path: settings
class _TranslationsSettingsTr extends TranslationsSettingsEn {
  _TranslationsSettingsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ayarlar';
  @override
  String get appSettings => 'Uygulama Ayarları';
  @override
  String get projectSettings => 'Proje Ayarları';
  @override
  late final _TranslationsSettingsAppearanceTr appearance =
      _TranslationsSettingsAppearanceTr._(_root);
  @override
  late final _TranslationsSettingsGeneralTr general =
      _TranslationsSettingsGeneralTr._(_root);
  @override
  late final _TranslationsSettingsScopeTr scope =
      _TranslationsSettingsScopeTr._(_root);
  @override
  late final _TranslationsSettingsSearchKeywordsTr searchKeywords =
      _TranslationsSettingsSearchKeywordsTr._(_root);
  @override
  late final _TranslationsSettingsComparisonTr comparison =
      _TranslationsSettingsComparisonTr._(_root);
  @override
  late final _TranslationsSettingsFileHandlingTr fileHandling =
      _TranslationsSettingsFileHandlingTr._(_root);
  @override
  late final _TranslationsSettingsTranslationMemoryTr translationMemory =
      _TranslationsSettingsTranslationMemoryTr._(_root);
  @override
  late final _TranslationsSettingsBackupTr backup =
      _TranslationsSettingsBackupTr._(_root);
  @override
  late final _TranslationsSettingsAiTr ai = _TranslationsSettingsAiTr._(_root);
  @override
  late final _TranslationsSettingsIntegrationsTr integrations =
      _TranslationsSettingsIntegrationsTr._(_root);
  @override
  late final _TranslationsSettingsDeveloperTr developer =
      _TranslationsSettingsDeveloperTr._(_root);
  @override
  late final _TranslationsSettingsAboutTr about =
      _TranslationsSettingsAboutTr._(_root);
  @override
  late final _TranslationsSettingsOnboardingTr onboarding =
      _TranslationsSettingsOnboardingTr._(_root);
  @override
  late final _TranslationsSettingsSettingsViewTr settingsView =
      _TranslationsSettingsSettingsViewTr._(_root);
}

// Path: fileComparison
class _TranslationsFileComparisonTr extends TranslationsFileComparisonEn {
  _TranslationsFileComparisonTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Dosya Karşılaştırma';
  @override
  String get openFiles => 'Dosyaları Aç';
  @override
  String get exportResults => 'Sonuçları Dışa Aktar';
  @override
  String get restartTutorial => 'Eğitimi Yeniden Başlat';
  @override
  String get restartTutorialDevOnly =>
      'Eğitimi yeniden başlatma yalnızca geliştirici modunda kullanılabilir.';
  @override
  String get unsupportedFileType => 'Desteklenmeyen dosya türü.';
  @override
  String get unsupportedFileTypeSuggestion =>
      'Lütfen desteklenen bir yerelleştirme dosyası seçin.';
  @override
  String get someFilesUnsupported => 'Bazı dosyalar desteklenmiyor.';
  @override
  String get pickSupportedFiles =>
      'Yalnızca desteklenen yerelleştirme dosyalarını seçin.';
  @override
  String get pickTwoFiles => 'Karşılaştırmak için iki dosya seçin.';
  @override
  String get pickBilingualFile =>
      'Karşılaştırmak için lütfen iki dilli bir dosya seçin.';
  @override
  String get noResultsToExport => 'Henüz dışa aktarılacak sonuç yok.';
  @override
  String get performComparisonFirst =>
      'Sonuçları dışa aktarmak için önce bir karşılaştırma yapın.';
  @override
  String get performComparisonFirstEditor =>
      'Gelişmiş ayrıntıları görmek için lütfen önce bir karşılaştırma yapın.';
  @override
  String get sampleDataLoaded => 'Örnek veriler başarıyla yüklendi';
  @override
  String loadSampleDataError({required Object error}) =>
      'Örnek veriler yüklenemedi: ${error}';
  @override
  String get invalidFileType => 'Geçersiz dosya türü.';
  @override
  String fileSelected({required Object label, required Object fileName}) =>
      '${label} seçildi: ${fileName}';
  @override
  String get sourceFile => 'Kaynak dosya';
  @override
  String get targetFile => 'Hedef dosya';
  @override
  String get bilingualFile => 'İki dilli dosya';
  @override
  String get compareFiles => 'Dosyaları Karşılaştır';
  @override
  String get compareFile => 'Dosyayı Karşılaştır';
  @override
  String get bilingualMode => 'İki Dilli Mod';
  @override
  String get twoFilesMode => 'İki Dosya';
  @override
  String get processing => 'İşleniyor...';
  @override
  String remaining({required Object time}) => '${time} kaldı';
  @override
  String get comparisonInProgress => 'Karşılaştırma devam ediyor...';
  @override
  String comparisonFailed({required Object error}) =>
      'Karşılaştırma Başarısız: ${error}';
  @override
  String fileChanged({required Object fileName}) =>
      'Dosya değişti: ${fileName}. Yeniden karşılaştırılıyor...';
  @override
  String get dropFileHere => 'Dosyayı buraya bırakın';
  @override
  String get dropFileOrBrowse => 'Dosyayı bırakın veya göz atmak için tıklayın';
  @override
  String get fileUpload => 'Dosya yükle';
  @override
  String get changeFile => 'Dosyayı değiştir';
  @override
  String get total => 'Toplam';
  @override
  String get show => 'Göster';
  @override
  String get showAll => 'Tümünü Göster';
  @override
  String noMatches({required Object query}) =>
      '"${query}" için eşleşme bulunamadı';
  @override
  String showingEntries({required Object total, required Object count}) =>
      '${total} girişten ${count} tanesi gösteriliyor';
  @override
  String get filesIdentical => 'Dosyalar aynı.';
  @override
  String hiddenIdentical({required Object count}) =>
      '${count} aynı giriş gizlendi';
  @override
  String get showIdentical => 'Aynı Girişleri Göster';
  @override
  String get hideIdentical => 'Aynı girişleri gizle';
  @override
  String get noDiff => 'Anahtarlara dayalı fark bulunamadı.';
  @override
  String get source => 'Kaynak';
  @override
  String get target => 'Hedef';
  @override
  String get value => 'Değer';
  @override
  String get readyToCompare => 'Dosyaları Karşılaştırmaya Hazır';
  @override
  String get readyToCompareDesc =>
      'Yerelleştirme dosyalarını yukarıya bırakın veya karşılaştırma için dosya seçmek üzere gözat düğmelerini kullanın.';
  @override
  String get recentComparisons => 'Son Karşılaştırmalar';
  @override
  String bilingualFileLabel({required Object name}) =>
      'İki dilli dosya: ${name}';
  @override
  String comparisonLabel({required Object source, required Object target}) =>
      '${source} ↔ ${target}';
  @override
  String get fileNotExist =>
      'Bu oturumdaki dosyalardan biri veya her ikisi artık mevcut değil.';
  @override
  String get largeFileTitle => 'Büyük Dosya Algılandı';
  @override
  String largeFileContent({required Object count}) =>
      'Karşılaştırma sonucu ${count} giriş içeriyor.\nHepsini görüntülemek performans sorunlarına neden olabilir.\n\nDevam etmek istiyor musunuz?';
  @override
  String get dontShowAgain => 'Bu dosya için tekrar gösterme';
  @override
  String get proceed => 'Devam Et';
  @override
  String exportReport({required Object format}) => '${format} Raporunu Kaydet';
  @override
  String saved({required Object format}) => '${format} kaydedildi';
  @override
  String saveError({required Object format}) =>
      '${format} dosyası kaydedilemedi.';
  @override
  String saveErrorDetailed({required Object format, required Object error}) =>
      '${format} kaydedilemedi: ${error}';
  @override
  String get watching => 'İzleniyor';
  @override
  String get watchOff => 'İzleme Kapalı';
  @override
  String watchingTooltip({required Object status}) =>
      'Dosya İzleme: ${status}\nDosyalar diskte değiştiğinde otomatik olarak yeniden karşılaştır';
  @override
  String get aiSettingsNotAvailable => 'Yapay Zeka ayarlarına erişilemiyor';
}

// Path: directoryComparison
class _TranslationsDirectoryComparisonTr
    extends TranslationsDirectoryComparisonEn {
  _TranslationsDirectoryComparisonTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Dizin Karşılaştırma';
  @override
  String get sourceDirectory => 'Kaynak Dizin';
  @override
  String get targetDirectory => 'Hedef Dizin';
  @override
  String get sourceSubtitle => 'Orijinal/Referans dosyaları';
  @override
  String get targetSubtitle => 'Çeviri/Karşılaştırma dosyaları';
  @override
  String get selectBothDirectories =>
      'Lütfen hem kaynak hem de hedef dizini seçin.';
  @override
  String get selectSourceFolder => 'Kaynak Klasörü Seç';
  @override
  String get selectTargetFolder => 'Hedef Klasörü Seç';
  @override
  String get dropFolderHere => 'Klasörü buraya bırakın veya göz atın...';
  @override
  String get folderPath => 'Klasör Yolu';
  @override
  String get readyToCompare => 'Dizinleri Karşılaştırmaya Hazır';
  @override
  String get readyToCompareDesc =>
      'Klasörleri yukarıya bırakın veya karşılaştırma için dizinleri seçmek üzere gözat düğmelerini kullanın.';
  @override
  String get nestedFolders => 'İç içe klasörler';
  @override
  String get nestedFoldersTooltip =>
      'Tüm iç içe dizinleri yinelemeli olarak karşılaştırır';
  @override
  String get fileMatching => 'Dosya eşleştirme';
  @override
  String get fileMatchingTooltip =>
      'Dosyaları ada göre otomatik olarak eşleştirir';
  @override
  String get bulkExport => 'Toplu dışa aktarma';
  @override
  String get bulkExportTooltip =>
      'Tüm karşılaştırma sonuçlarını tek seferde dışa aktar';
  @override
  String get notDirectoryComparison => 'Bu bir dizin karşılaştırması değil.';
  @override
  String get directoriesNotExist =>
      'Bir veya her iki dizin artık mevcut değil.';
  @override
  String get errorOccurred => 'Hata oluştu';
  @override
  String get noFilesFound => 'Seçilen dizinlerde dosya bulunamadı.';
  @override
  String get unmatchedSourceFiles => 'Eşleşmeyen Kaynak Dosyalar';
  @override
  String get unmatchedTargetFiles => 'Eşleşmeyen Hedef Dosyalar';
  @override
  String filePairs({required Object count}) => '${count} dosya çifti';
  @override
  String pairedFiles({required Object count}) => 'Eşleşen Dosyalar (${count})';
  @override
  String get view => 'Görüntüle';
  @override
  String get failed => 'Başarısız';
  @override
  String get pair => 'Eşleştir...';
  @override
  String pairDialogTitle({required Object name}) =>
      '"${name}" dosyasını şununla eşleştir:';
  @override
  String get discoverFiles => 'Dosyaları Keşfet';
  @override
  String get compareAll => 'Tümünü Karşılaştır';
  @override
  String get exportAll => 'Tümünü Dışa Aktar';
  @override
  String get comparisonStarted => 'Karşılaştırma başlatıldı...';
  @override
  String get discoveringFiles => 'Dosyalar keşfediliyor...';
  @override
  String get noResultsToExport =>
      'Dışa aktarılacak karşılaştırma sonucu yok. Önce "Tümünü Karşılaştır"ı çalıştırın.';
  @override
  String get selectExportFolder => 'Dışa Aktarma Klasörünü Seç';
  @override
  String createExportFolderError({required Object error}) =>
      'Dışa aktarma klasörü oluşturulamadı: ${error}';
  @override
  String get exportingResults => 'Sonuçlar Dışa Aktarılıyor';
  @override
  String processingFile({required Object file}) => 'İşleniyor: ${file}';
  @override
  String exportProgress({required Object total, required Object current}) =>
      '${total} dosyadan ${current} tanesi dışa aktarıldı';
  @override
  String get exportComplete => 'Dışa Aktarma Tamamlandı';
  @override
  String exportSuccessMessage({required Object count}) =>
      '${count} karşılaştırma dosyası ve özet başarıyla dışa aktarıldı.';
  @override
  String exportFailed({required Object error}) =>
      'Dışa aktarma başarısız: ${error}';
  @override
  String get close => 'Kapat';
}

// Path: gitComparison
class _TranslationsGitComparisonTr extends TranslationsGitComparisonEn {
  _TranslationsGitComparisonTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Repo Karşılaştırması';
  @override
  String get repoSelector => 'Repo Oluştur / Aç';
  @override
  String get noRepoSelected => 'Repo seçilmedi';
  @override
  String get open => 'Aç';
  @override
  String get refreshCommits => 'Commitleri Yenile';
  @override
  String get noCommits =>
      'Commit bulunamadı veya yüklenemedi. Commitleri yüklemek için bir dal seçin.';
  @override
  String get baseCommit => 'Temel Commit (Eski)';
  @override
  String get targetCommit => 'Hedef Commit (Yeni)';
  @override
  String get filterCommitsByBranch => 'Branch\'a Göre Commitleri Filtrele';
  @override
  String get conflictDetection => 'Conflict algılama';
  @override
  String get conflictDetectionTooltip =>
      'Merge conflictlerini tespit et ve çöz';
  @override
  String get actions => 'Eylemler:';
  @override
  String get checkout => 'Checkout';
  @override
  String get merge => 'Merge';
  @override
  String get pull => 'Pull';
  @override
  String get checkoutBranch => 'Branch\'a Checkout Yap';
  @override
  String get mergeBranch => 'Branch\'ı Geçerli Branch ile Merge Et';
  @override
  String mergeConfirmation({required Object branch}) =>
      '${branch} merge edilsin mi?';
  @override
  String get mergeWarning =>
      'Bu, değişiklikleri geçerli çalışma branch\'ınızla birleştirecektir. Conflict oluşabilir.';
  @override
  String get selectExportFolder => 'Dışa Aktarma Klasörünü Seç';
  @override
  String createExportFolderError({required Object error}) =>
      'Dışa aktarma klasörü oluşturulamadı: ${error}';
  @override
  String get exportingFiles => 'Dosyalar Dışa Aktarılıyor';
  @override
  String processingFile({required Object file}) => 'İşleniyor: ${file}';
  @override
  String exportProgress({required Object total, required Object current}) =>
      '${total} dosyadan ${current} tanesi dışa aktarıldı';
  @override
  String get exportComplete => 'Dışa Aktarma Tamamlandı';
  @override
  String exportSuccessMessage({required Object count}) =>
      '${count} dosya tam içerikle başarıyla dışa aktarıldı.';
  @override
  String get exportDetail =>
      'Her dosyanın farkı "files" alt klasörüne kaydedilir.';
  @override
  String get diffViewer => 'Fark Görüntüleyici';
  @override
  String get base => 'TEMEL';
  @override
  String get target => 'HEDEF';
  @override
  String get noLines => 'Görüntülenecek satır yok';
  @override
  String get searchFiles => 'Dosyaları ara...';
  @override
  String noFilesMatch({required Object query}) =>
      '"${query}" ile eşleşen dosya yok';
  @override
  String filesCount({required Object count}) => '${count} dosya';
  @override
  String get selectBaseFile => 'Temel Dosyayı Seç';
  @override
  String get selectTargetFile => 'Hedef Dosyayı Seç';
  @override
  String get comparisonResults => 'Karşılaştırma Sonuçları';
  @override
  String get noChanges => 'Seçilen referanslar arasında değişiklik bulunamadı.';
  @override
  String get linesAdded => 'Eklenen Satırlar';
  @override
  String get linesRemoved => 'Kaldırılan Satırlar';
  @override
  String get commit => 'Commit';
  @override
  String get branch => 'Branch';
  @override
  String get noRepositorySelected => 'Depo seçilmedi';
  @override
  String get notGitComparison => 'Git karşılaştırması değil';
  @override
  String get repositoryNotExist => 'Depo mevcut değil';
  @override
  String get mainBranch => 'main';
  @override
  String get masterBranch => 'master';
  @override
  String get backToControls => 'Karşılaştırma kontrollerine dön';
}

// Path: advancedComparison
class _TranslationsAdvancedComparisonTr
    extends TranslationsAdvancedComparisonEn {
  _TranslationsAdvancedComparisonTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get placeholder => 'Gelişmiş Karşılaştırma Görünümü - Yer Tutucu';
}

// Path: advancedDiff
class _TranslationsAdvancedDiffTr extends TranslationsAdvancedDiffEn {
  _TranslationsAdvancedDiffTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get saveAllChanges => 'Tüm Değişiklikleri Kaydet?';
  @override
  String saveConfirmation({required Object count}) =>
      'Bu işlem, değiştirilen ${count} girdinin tamamını hedef dosyaya kaydedecek. Bu işlem geri alınamaz.';
  @override
  String get changesSaved => 'Değişiklikler başarıyla kaydedildi.';
  @override
  String get csvExported => 'CSV dışa aktarıldı';
  @override
  String get unsavedChanges => 'Kaydedilmemiş Değişiklikler';
  @override
  String get unsavedChangesWarning =>
      'Kaydedilmemiş değişiklikleriniz var. Bunları silmek istediğinizden emin misiniz?';
  @override
  String get discardChanges => 'Değişiklikleri Sil';
  @override
  String get goBack => 'Geri git';
  @override
  String get breadcrumbs => 'Ana Sayfa  >  Düzenleyici';
  @override
  String unsaved({required Object count}) => '${count} kaydedilmemiş';
  @override
  String reviewed({required Object count}) => '${count} incelendi';
  @override
  String saveAll({required Object count}) => 'Tümünü Kaydet (${count})';
  @override
  String get allSaved => 'Tümü Kaydedildi';
  @override
  String get saveAllTooltip => 'Tüm Değişiklikleri Kaydet (Ctrl+S)';
  @override
  String get exportTooltip => 'Veriyi Dışa Aktar (Ctrl+E)';
  @override
  late final _TranslationsAdvancedDiffAiSuggestionTr aiSuggestion =
      _TranslationsAdvancedDiffAiSuggestionTr._(_root);
  @override
  late final _TranslationsAdvancedDiffDetailEditTr detailEdit =
      _TranslationsAdvancedDiffDetailEditTr._(_root);
  @override
  late final _TranslationsAdvancedDiffTableTr table =
      _TranslationsAdvancedDiffTableTr._(_root);
  @override
  late final _TranslationsAdvancedDiffDiffRowTr diffRow =
      _TranslationsAdvancedDiffDiffRowTr._(_root);
  @override
  late final _TranslationsAdvancedDiffStatusTr status =
      _TranslationsAdvancedDiffStatusTr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarTr sidebar =
      _TranslationsAdvancedDiffSidebarTr._(_root);
}

// Path: issueDetails
class _TranslationsIssueDetailsTr extends TranslationsIssueDetailsEn {
  _TranslationsIssueDetailsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Sorun Ayrıntıları';
  @override
  String showingIssues({required Object total, required Object count}) =>
      '${total} sorundan ${count} tanesi gösteriliyor';
  @override
  String get searchPlaceholder => 'Anahtar, metin veya hataya göre ara...';
  @override
  String get noDetails => 'Ayrıntı mevcut değil.';
  @override
  String get noMatches => 'Eşleşme bulunamadı.';
  @override
  String get showMore => 'Daha Fazla Göster';
  @override
  String copyItems({required Object count}) => '${count} Öğeyi Kopyala';
  @override
  String get close => 'Kapat';
  @override
  String get copied => 'Panoya kopyalandı';
  @override
  String copiedCount({required Object count}) => '${count} öğe kopyalandı';
  @override
  late final _TranslationsIssueDetailsDuplicateValueTr duplicateValue =
      _TranslationsIssueDetailsDuplicateValueTr._(_root);
  @override
  late final _TranslationsIssueDetailsLengthOutlierTr lengthOutlier =
      _TranslationsIssueDetailsLengthOutlierTr._(_root);
  @override
  late final _TranslationsIssueDetailsStandardTr standard =
      _TranslationsIssueDetailsStandardTr._(_root);
  @override
  String get review => 'İncele';
  @override
  late final _TranslationsIssueDetailsTypesTr types =
      _TranslationsIssueDetailsTypesTr._(_root);
  @override
  late final _TranslationsIssueDetailsNotesTr notes =
      _TranslationsIssueDetailsNotesTr._(_root);
  @override
  late final _TranslationsIssueDetailsFallbacksTr fallbacks =
      _TranslationsIssueDetailsFallbacksTr._(_root);
}

// Path: importReview
class _TranslationsImportReviewTr extends TranslationsImportReviewEn {
  _TranslationsImportReviewTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Proje İçe Aktarımını İncele';
  @override
  String get projectName => 'Proje Adı';
  @override
  String get created => 'Oluşturulma';
  @override
  String get historyItems => 'Geçmiş Öğeleri';
  @override
  String get customSettingsTitle => 'Özel Ayarlar Algılandı';
  @override
  String get customSettingsWarning =>
      'Bu proje, proje açıkken varsayılanlarınızı geçersiz kılacak özel ayarlar içerir.';
  @override
  String get standardSettings => 'Bu proje standart küresel ayarları kullanır.';
  @override
  String get cancelImport => 'İçe Aktarmayı İptal Et';
  @override
  String get trustOpen => 'Güven ve Projeyi Aç';
}

// Path: historyView
class _TranslationsHistoryViewTr extends TranslationsHistoryViewEn {
  _TranslationsHistoryViewTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Karşılaştırma Geçmişi';
  @override
  String get clearAll => 'Tüm geçmişi temizle';
  @override
  String get searchPlaceholder => 'Dosya adına göre ara...';
  @override
  String get sortBy => 'Sıralama ölçütü';
  @override
  String get sortDate => 'Tarih';
  @override
  String get sortSource => 'Kaynak Dosya';
  @override
  String get sortTarget => 'Hedef Dosya';
  @override
  String get showCurrentProject => 'Gösterilen: Mevcut Proje';
  @override
  String get showAllHistory => 'Gösterilen: Tüm Geçmiş';
  @override
  String get groupByFolder => 'Klasöre göre grupla';
  @override
  String get disableGrouping => 'Klasör gruplamasını devre dışı bırak';
  @override
  String get filterAll => 'Tümü';
  @override
  String get filterFiles => 'Dosyalar';
  @override
  String get filterDirectories => 'Dizinler';
  @override
  String get filterGit => 'Git';
  @override
  String get noHistory => 'Henüz karşılaştırma geçmişi yok';
  @override
  String get historyDescription =>
      'Dosya karşılaştırmalarınız burada görünecek';
  @override
  String get noResults => 'Sonuç bulunamadı';
  @override
  String get adjustSearch => 'Aramayı ayarlamayı deneyin';
  @override
  String get clearConfirmationTitle => 'Tüm Geçmişi Temizle?';
  @override
  String get clearConfirmationContent =>
      'Bu işlem tüm karşılaştırma geçmişini kalıcı olarak silecek. Bu işlem geri alınamaz.';
  @override
  String get clearAction => 'Tümünü Temizle';
  @override
  String get deletedMessage => 'Geçmiş öğesi silindi';
  @override
  String get undo => 'Geri Al';
  @override
  String get viewDetails => 'Ayrıntıları Görüntüle';
  @override
  String get delete => 'Sil';
  @override
  String get openLocation => 'Dosya konumunu aç';
  @override
  String get bilingual => 'İki Dilli';
  @override
  String get filePair => 'Dosya Çifti';
  @override
  String get directory => 'Dizin';
  @override
  String get git => 'Git';
  @override
  String get repo => 'Depo';
  @override
  String get sourceDir => 'Kaynak Dizin';
  @override
  String get targetDir => 'Hedef Dizin';
  @override
  String get source => 'Kaynak';
  @override
  String get target => 'Hedef';
  @override
  String get noChanges => 'Değişiklik algılanmadı';
  @override
  String get added => 'Eklendi';
  @override
  String get removed => 'Kaldırıldı';
  @override
  String get modified => 'Değiştirildi';
  @override
  String get same => 'Aynı';
  @override
  String get total => 'Toplam';
  @override
  String get currentProject => 'Mevcut Proje';
  @override
  String get unassigned => 'Atanmamış';
  @override
  String get project => 'Proje';
}

// Path: compare
class _TranslationsCompareTr extends TranslationsCompareEn {
  _TranslationsCompareTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Dosyaları Karşılaştır';
  @override
  String get sourceFile => 'Kaynak Dosya';
  @override
  String get targetFile => 'Hedef Dosya';
  @override
  String get sourceFolder => 'Kaynak Klasör';
  @override
  String get targetFolder => 'Hedef Klasör';
  @override
  String get dropFilesHint =>
      'Yerelleştirme dosyalarını buraya bırakın veya karşılaştırma için dosya seçmek üzere gözat düğmelerini kullanın.';
  @override
  String get selectSourceFile => 'Kaynak dosya seç';
  @override
  String get selectTargetFile => 'Hedef dosya seç';
  @override
  String get startComparison => 'Karşılaştırmayı Başlat';
  @override
  String get comparing => 'Karşılaştırılıyor...';
  @override
  String get comparisonComplete => 'Karşılaştırma tamamlandı';
  @override
  String get noChanges => 'Değişiklik algılanmadı';
  @override
  String get filesIdentical => 'Dosyalar aynı';
  @override
  String changesFound({required Object count}) => '${count} değişiklik bulundu';
  @override
  late final _TranslationsCompareTabsTr tabs =
      _TranslationsCompareTabsTr._(_root);
  @override
  late final _TranslationsCompareFileTypesTr fileTypes =
      _TranslationsCompareFileTypesTr._(_root);
}

// Path: history
class _TranslationsHistoryTr extends TranslationsHistoryEn {
  _TranslationsHistoryTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Geçmiş';
  @override
  String get recentComparisons => 'Son Karşılaştırmalar';
  @override
  String get noHistory => 'Henüz karşılaştırma geçmişi yok';
  @override
  String get noHistoryDescription =>
      'Karşılaştırma geçmişiniz burada görünecek';
  @override
  String get clearHistory => 'Geçmişi Temizle';
  @override
  String get clearHistoryConfirm =>
      'Tüm geçmişi silmek istediğinizden emin misiniz?';
  @override
  String get deleteEntry => 'Girdiyi Sil';
  @override
  String get openComparison => 'Karşılaştırmayı Aç';
  @override
  late final _TranslationsHistoryTimeAgoTr timeAgo =
      _TranslationsHistoryTimeAgoTr._(_root);
}

// Path: projects
class _TranslationsProjectsTr extends TranslationsProjectsEn {
  _TranslationsProjectsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Projeler';
  @override
  String get createProject => 'Proje Oluştur';
  @override
  String get importProject => 'Proje İçe Aktar';
  @override
  String get noProjects => 'Henüz proje yok';
  @override
  String get noProjectsDescription =>
      'Yerelleştirme dosyalarınızı düzenlemek için bir proje oluşturun';
  @override
  String get projectName => 'Proje Adı';
  @override
  String get projectPath => 'Proje Yolu';
  @override
  String get lastOpened => 'Son açılma';
  @override
  String get openProject => 'Projeyi Aç';
  @override
  String get closeProject => 'Projeyi Kapat';
  @override
  String get deleteProject => 'Projeyi Sil';
  @override
  String get deleteProjectConfirm =>
      'Bu projeyi silmek istediğinizden emin misiniz?';
  @override
  String get exportProject => 'Projeyi Dışa Aktar';
  @override
  String get exportDescription =>
      'Kaynak dosyaları, yapılandırmayı ve geçmişi içeren taşınabilir bir zip dosyası oluşturun.';
  @override
  String get exporting => 'Proje dışa aktarılıyor...';
  @override
  String get exportSuccess => 'Proje dışa aktarıldı';
  @override
  String exportError({required Object error}) =>
      'Dışa aktarma başarısız: ${error}';
  @override
  String get createNewProject => 'Yeni Proje Oluştur';
  @override
  String get openExistingProject => 'Mevcut Projeyi Aç';
  @override
  String get importProjectZip => 'Proje Zip İçe Aktar';
  @override
  String get projectResources => 'Proje Kaynakları';
  @override
  String get recentProjects => 'Son Projeler';
  @override
  String get noRecentProjects => 'Son proje yok';
  @override
  String get selectProjectZip => 'Proje Zip Seç';
  @override
  String get selectDestination => 'İçe Aktarma için Hedef Klasör Seç';
  @override
  String get importing => 'Proje içe aktarılıyor...';
  @override
  String get importSuccess => 'Proje başarıyla içe aktarıldı';
  @override
  String importFailed({required Object error}) =>
      'İçe aktarma başarısız: ${error}';
  @override
  String get importingFiles => 'Dosyalar içe aktarılıyor...';
  @override
  String get noSupportedFiles => 'Desteklenen dosya bırakılmadı.';
  @override
  late final _TranslationsProjectsStatsTr stats =
      _TranslationsProjectsStatsTr._(_root);
  @override
  String get openProjectFirst =>
      'Kaynaklarını yönetmek için önce bir proje açın.';
  @override
  String get removeFromRecent => 'Son kullanılanlardan kaldır';
  @override
  late final _TranslationsProjectsSelectionTr selection =
      _TranslationsProjectsSelectionTr._(_root);
  @override
  late final _TranslationsProjectsCreateDialogTr createDialog =
      _TranslationsProjectsCreateDialogTr._(_root);
  @override
  late final _TranslationsProjectsIndicatorTr indicator =
      _TranslationsProjectsIndicatorTr._(_root);
  @override
  late final _TranslationsProjectsGlossaryTr glossary =
      _TranslationsProjectsGlossaryTr._(_root);
  @override
  late final _TranslationsProjectsConflictsTr conflicts =
      _TranslationsProjectsConflictsTr._(_root);
  @override
  late final _TranslationsProjectsTmTr tm = _TranslationsProjectsTmTr._(_root);
}

// Path: diff
class _TranslationsDiffTr extends TranslationsDiffEn {
  _TranslationsDiffTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'Eklendi';
  @override
  String get removed => 'Kaldırıldı';
  @override
  String get modified => 'Değiştirildi';
  @override
  String get unchanged => 'Değişmedi';
  @override
  String get missing => 'Eksik';
  @override
  String get extra => 'Fazla';
  @override
  String get sourceValue => 'Kaynak Değer';
  @override
  String get targetValue => 'Hedef Değer';
  @override
  String get key => 'Anahtar';
  @override
  String get status => 'Durum';
  @override
  String get actions => 'Eylemler';
  @override
  String get copyToTarget => 'Hedefe Kopyala';
  @override
  String get acceptChange => 'Değişikliği Kabul Et';
  @override
  String get rejectChange => 'Değişikliği Reddet';
  @override
  String get viewDetails => 'Ayrıntıları Görüntüle';
}

// Path: git
class _TranslationsGitTr extends TranslationsGitEn {
  _TranslationsGitTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Git Karşılaştırması';
  @override
  String get selectRepository => 'Depo Seç';
  @override
  String get selectBranch => 'Dal Seç';
  @override
  String get selectCommit => 'İşleme Seç';
  @override
  String get noRepositories => 'Git deposu bulunamadı';
  @override
  String get noRepositoriesDescription =>
      'Dalları veya işlemeleri karşılaştırmak için bir git deposu seçin.';
  @override
  String get compareBranches => 'Dalları Karşılaştır';
  @override
  String get compareCommits => 'İşlemeleri Karşılaştır';
  @override
  String get baseBranch => 'Temel Dal';
  @override
  String get compareBranch => 'Karşılaştırma Dalı';
  @override
  String filesChanged({required Object count}) => '${count} dosya değişti';
  @override
  String additions({required Object count}) => '${count} ekleme';
  @override
  String deletions({required Object count}) => '${count} silme';
  @override
  String get filterCommitsByBranch => 'İşlemeleri Dala Göre Filtrele';
  @override
  late final _TranslationsGitConflictsTr conflicts =
      _TranslationsGitConflictsTr._(_root);
}

// Path: quality
class _TranslationsQualityTr extends TranslationsQualityEn {
  _TranslationsQualityTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Kalite Panosu';
  @override
  String get overallScore => 'Genel Puan';
  @override
  String get issues => 'Sorunlar';
  @override
  String get warnings => 'Uyarılar';
  @override
  String get suggestions => 'Öneriler';
  @override
  String get placeholderMismatch => 'Yer Tutucu Uyumsuzluğu';
  @override
  String get placeholderMismatchDescription =>
      '{name} gibi yer tutucular kaynak ve hedef arasında eşleşmiyor';
  @override
  String get lengthOutlier => 'Uzunluk Sapması';
  @override
  String get lengthOutlierDescription =>
      'Çeviri uzunluğu kaynaktan önemli ölçüde farklı';
  @override
  String get duplicateValue => 'Yinelenen Değer';
  @override
  String get duplicateValueDescription =>
      'Birden fazla anahtar için aynı çeviri kullanılmış';
  @override
  String get missingTranslation => 'Eksik Çeviri';
  @override
  String get missingTranslationDescription => 'Bu anahtar için çeviri eksik';
  @override
  String get loading => 'Pano yükleniyor...';
  @override
  String get errorLoading => 'Geçmişiniz yüklenemedi. Tekrar deneyin.';
  @override
  String get emptyState => 'Panonuzu görmek için bir karşılaştırma çalıştırın.';
  @override
  String get refresh => 'Yenile';
  @override
  String get buildingInsights => 'Analizler oluşturuluyor...';
  @override
  String get crunchingNumbers => 'Rakamlar işleniyor...';
  @override
  String get errorBuilding => 'Pano oluşturulamadı. Tekrar deneyin.';
  @override
  String get noUsableData => 'Henüz kullanılabilir veri bulunamadı.';
  @override
  String get languages => 'Diller';
  @override
  String get averageCoverage => 'Ortalama kapsam';
  @override
  String get potentialIssues => 'Olası sorunlar';
  @override
  String get translationCoverage => 'Çeviri kapsamı';
  @override
  String entriesTranslated(
          {required Object total, required Object translated}) =>
      '${total} girdiden ${translated} tanesi çevrildi';
  @override
  String get wordsAddedOverTime => 'Zamanla eklenen kelimeler';
  @override
  String get completionVsScope => 'Tamamlama vs Kapsam';
  @override
  String get scopeVsProgress => 'Kapsam vs İlerleme';
  @override
  String get coveragePercent => 'Kapsam %';
  @override
  String get wordsAdded => 'Eklenen Kelimeler';
  @override
  String get words => 'Kelimeler';
  @override
  String get coverage => 'Kapsam';
  @override
  String get scope => 'Kapsam';
  @override
  String get latest => 'En Son';
  @override
  String get added => 'Eklendi';
  @override
  String get change => 'Değişim';
  @override
  String get totalScope => 'Toplam Kapsam';
  @override
  String wordsCount({required Object count}) => '${count} kelime';
  @override
  String get scopeGrowth => 'Kapsam Büyümesi';
  @override
  String get range => 'Aralık';
  @override
  String get aiUsage => 'Yapay Zeka ve Çeviri Kullanımı';
  @override
  String lastUsed({required Object date}) => 'Son kullanım: ${date}';
  @override
  String get noIssuesFound => 'Son karşılaştırmalarda sorun bulunamadı.';
  @override
  String get placeholderMismatches => 'Yer tutucu uyumsuzlukları';
  @override
  String get placeholderMismatchesDesc => '{name} gibi işaretçiler eşleşmiyor.';
  @override
  String get lengthOutliers => 'Çok kısa veya uzun çeviriler';
  @override
  String get lengthOutliersDesc =>
      'Uzunluk kaynağa kıyasla olağandışı görünüyor.';
  @override
  String get duplicateValues => 'Yinelenen değerler';
  @override
  String get duplicateValuesDesc => 'Aynı çeviri birçok kez kullanılmış.';
  @override
  String get placeholderDialogTitle => 'Yer Tutucu Uyumsuzlukları';
  @override
  String get placeholderDialogDesc =>
      'Bu çeviriler kaynaktan farklı yer tutucular ({name}) içeriyor.';
  @override
  String get lengthDialogTitle => 'Uzunluk Sapmaları';
  @override
  String get lengthDialogDesc =>
      'Bu çeviriler kaynaktan önemli ölçüde daha kısa veya daha uzun.';
  @override
  String get duplicateDialogTitle => 'Yinelenen Değerler';
  @override
  String get duplicateDialogDesc => 'Bu çeviriler birden çok kez görünüyor.';
  @override
  String duplicateSample({required Object value}) => 'Yinelenen: "${value}"';
  @override
  String get exportError => 'Rapor oluşturulamadı. Lütfen tekrar deneyin.';
  @override
  String get noDataToExport => 'Dışa aktarılacak veri yok';
  @override
  String get exportFailed => 'Dışa aktarma başarısız';
  @override
  String get exportDialogTitle => 'Kalite Raporunu Dışa Aktar';
  @override
  String get reportSaved => 'Rapor kaydedildi';
  @override
  String get export => 'Export';
  @override
  String get requests => 'Requests';
  @override
  String get tokens => 'Tokens';
  @override
  String get characters => 'Characters';
  @override
  String get estCost => 'Tahmini Maliyet';
  @override
  String get prompt => 'Prompt';
  @override
  String get completion => 'Completion';
  @override
  String get showingCurrentProject => 'Gösterilen: Mevcut Proje';
  @override
  String get showingAllHistory => 'Gösterilen: Tüm Geçmiş';
  @override
  String get filesSkipped => 'Bazı dosyalar bulunamadığı için atlandı.';
}

// Path: errors
class _TranslationsErrorsTr extends TranslationsErrorsEn {
  _TranslationsErrorsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get genericError => 'Bir hata oluştu';
  @override
  String get fileNotFound => 'Dosya bulunamadı';
  @override
  String get invalidFormat => 'Geçersiz dosya formatı';
  @override
  String get parseError => 'Dosya ayrıştırılamadı';
  @override
  String get networkError => 'Ağ hatası. Lütfen bağlantınızı kontrol edin.';
  @override
  String get permissionDenied => 'İzin reddedildi';
  @override
  String get unknownError => 'Bilinmeyen bir hata oluştu';
}

// Path: wizards
class _TranslationsWizardsTr extends TranslationsWizardsEn {
  _TranslationsWizardsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsWizardsFirstRunTr firstRun =
      _TranslationsWizardsFirstRunTr._(_root);
}

// Path: dialogs
class _TranslationsDialogsTr extends TranslationsDialogsEn {
  _TranslationsDialogsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDialogsAddIgnorePatternTr addIgnorePattern =
      _TranslationsDialogsAddIgnorePatternTr._(_root);
  @override
  late final _TranslationsDialogsDiffViewerTr diffViewer =
      _TranslationsDialogsDiffViewerTr._(_root);
}

// Path: grid
class _TranslationsGridTr extends TranslationsGridEn {
  _TranslationsGridTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGridColumnsTr columns =
      _TranslationsGridColumnsTr._(_root);
}

// Path: tutorial
class _TranslationsTutorialTr extends TranslationsTutorialEn {
  _TranslationsTutorialTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'ÖĞRETİCİYİ ATLA';
  @override
  String get finishMessage =>
      'Hazırsınız! Bitirmek için herhangi bir yere dokunun.';
  @override
  String get next => 'İleri';
  @override
  String get loadSampleData => 'Örnek Veri Yükle';
  @override
  String get browseSourceFile => 'Kaynak Dosya Seç';
  @override
  String get browseTargetFile => 'Hedef Dosya Seç';
  @override
  String get compareFiles => 'Dosyaları Karşılaştır';
  @override
  String get hintPhase2 =>
      'Sonraki: filtreler, arama, gelişmiş görünüm ve dışa aktarma.';
  @override
  late final _TranslationsTutorialStepsTr steps =
      _TranslationsTutorialStepsTr._(_root);
}

// Path: friendlyErrors
class _TranslationsFriendlyErrorsTr extends TranslationsFriendlyErrorsEn {
  _TranslationsFriendlyErrorsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsFriendlyErrorsFileNotFoundTr fileNotFound =
      _TranslationsFriendlyErrorsFileNotFoundTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsAccessDeniedTr accessDenied =
      _TranslationsFriendlyErrorsAccessDeniedTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsIsDirectoryTr isDirectory =
      _TranslationsFriendlyErrorsIsDirectoryTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsFileAccessTr fileAccess =
      _TranslationsFriendlyErrorsFileAccessTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsUnsupportedFormatTr unsupportedFormat =
      _TranslationsFriendlyErrorsUnsupportedFormatTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsNetworkErrorTr networkError =
      _TranslationsFriendlyErrorsNetworkErrorTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsNotGitRepoTr notGitRepo =
      _TranslationsFriendlyErrorsNotGitRepoTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsMergeConflictTr mergeConflict =
      _TranslationsFriendlyErrorsMergeConflictTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitAuthFailedTr gitAuthFailed =
      _TranslationsFriendlyErrorsGitAuthFailedTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitOperationFailedTr
      gitOperationFailed =
      _TranslationsFriendlyErrorsGitOperationFailedTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidJsonTr invalidJson =
      _TranslationsFriendlyErrorsInvalidJsonTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsRateLimitReachedTr rateLimitReached =
      _TranslationsFriendlyErrorsRateLimitReachedTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidApiKeyTr invalidApiKey =
      _TranslationsFriendlyErrorsInvalidApiKeyTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsTranslationServiceErrorTr
      translationServiceError =
      _TranslationsFriendlyErrorsTranslationServiceErrorTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsOutOfMemoryTr outOfMemory =
      _TranslationsFriendlyErrorsOutOfMemoryTr._(_root);
  @override
  late final _TranslationsFriendlyErrorsGenericErrorTr genericError =
      _TranslationsFriendlyErrorsGenericErrorTr._(_root);
}

// Path: systemTray
class _TranslationsSystemTrayTr extends TranslationsSystemTrayEn {
  _TranslationsSystemTrayTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get showLocalizer => 'Localizer\'ı Göster';
  @override
  String get exit => 'Çıkış';
}

// Path: validation
class _TranslationsValidationTr extends TranslationsValidationEn {
  _TranslationsValidationTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get connected => 'Bağlandı.';
  @override
  String get connectionTimeout =>
      'Bağlantı zaman aşımına uğradı. Lütfen tekrar deneyin.';
  @override
  String get couldNotConnect => 'Bağlanılamadı. Lütfen tekrar deneyin.';
  @override
  String get checkKeyAndTryAgain =>
      'Bağlanılamadı. Lütfen anahtarı kontrol edin ve tekrar deneyin.';
  @override
  String get tryAgainLater =>
      'Şu anda bağlanılamıyor. Lütfen daha sonra tekrar deneyin.';
  @override
  String get serviceUnavailable =>
      'Servis şu anda kullanılamıyor. Lütfen daha sonra tekrar deneyin.';
  @override
  String get enterKeyFirst => 'Lütfen önce bir anahtar girin.';
  @override
  String get checking => 'Kontrol ediliyor...';
  @override
  String deeplUsage({required Object used, required Object limit}) =>
      'Kullanım: ${used} / ${limit} karakter.';
}

// Path: status
class _TranslationsStatusTr extends TranslationsStatusEn {
  _TranslationsStatusTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get startingComparison => 'Karşılaştırma başlatılıyor...';
  @override
  String get loadingFromHistory => 'Geçmişten dosyalar yükleniyor...';
  @override
  String get comparisonComplete => 'Karşılaştırma tamamlandı';
  @override
  String get couldNotImportFiles =>
      'Dosyalar içe aktarılamadı. Lütfen tekrar deneyin.';
  @override
  String get historyFilesNotFound =>
      'Geçmişteki dosyalardan biri veya her ikisi orijinal yollarında bulunamadı.';
}

// Path: aiServices
class _TranslationsAiServicesTr extends TranslationsAiServicesEn {
  _TranslationsAiServicesTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get geminiEmptyResponse => 'Gemini boş yanıt döndürdü';
  @override
  String get geminiStreamingEmpty => 'Gemini akışı boş yanıt döndürdü';
  @override
  String get geminiRephraseEmpty =>
      'Gemini yeniden ifadelendirme için boş yanıt döndürdü';
  @override
  String get openaiEmptyResponse => 'OpenAI boş veya başarısız yanıt döndürdü';
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceTr
    extends TranslationsSettingsAppearanceEn {
  _TranslationsSettingsAppearanceTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Görünüm';
  @override
  String get description => 'Uygulamanın görünümünü özelleştirin';
  @override
  String get theme => 'Tema Modu';
  @override
  String get themeDescription =>
      'Açık, koyu veya sistem teması arasında seçim yapın';
  @override
  String get themeSystem => 'Sistem';
  @override
  String get themeLight => 'Açık';
  @override
  String get themeDark => 'Koyu';
  @override
  String get themeAmoled => 'AMOLED';
  @override
  String get accentColor => 'Vurgu Rengi';
  @override
  String get accentColorDescription => 'Tercih ettiğiniz vurgu rengini seçin';
  @override
  String get useMicaEffect => 'Mica Efektini Kullan';
  @override
  String get micaDescription =>
      'Modern bir görünüm için Windows 11 Mica şeffaflık efektini etkinleştirin';
  @override
  String get diffFontSize => 'Fark Yazı Tipi Boyutu';
  @override
  String get diffFontSizeDescription =>
      'Karşılaştırma görünümünün yazı tipi boyutunu ayarlayın';
  @override
  String get diffFontFamily => 'Fark Yazı Tipi Ailesi';
  @override
  String get diffFontFamilyDescription =>
      'Karşılaştırma görünümü için yazı tipi';
  @override
  String get systemDefault => 'Sistem Varsayılanı';
  @override
  String get pickAccentColor => 'Vurgu Rengi Seç';
  @override
  String get diffColors => 'Fark Renkleri';
  @override
  String get presetsTitle => 'Hazır Ayarlar';
  @override
  late final _TranslationsSettingsAppearancePresetsTr presets =
      _TranslationsSettingsAppearancePresetsTr._(_root);
  @override
  String get identical => 'Aynı';
  @override
  String pickColorFor({required Object label}) => '${label} için Renk Seç';
  @override
  String get livePreview => 'Canlı Önizleme';
  @override
  late final _TranslationsSettingsAppearancePreviewTr preview =
      _TranslationsSettingsAppearancePreviewTr._(_root);
}

// Path: settings.general
class _TranslationsSettingsGeneralTr extends TranslationsSettingsGeneralEn {
  _TranslationsSettingsGeneralTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Genel';
  @override
  String get description => 'Genel uygulama ayarları';
  @override
  String get language => 'Dil';
  @override
  String get languageDescription => 'Tercih ettiğiniz dili seçin';
  @override
  String get startMinimized => 'Simge Durumunda Küçültülmüş Başlat';
  @override
  String get startMinimizedDescription =>
      'Uygulamayı sistem tepsisinde simge durumunda başlat';
  @override
  String get rememberWindowPosition => 'Pencere Konumunu Hatırla';
  @override
  String get rememberWindowPositionDescription =>
      'Başlangıçta pencere boyutunu ve konumunu geri yükle';
  @override
  String get openLastProject => 'Başlangıçta Son Projeyi Aç';
  @override
  String get openLastProjectDescription =>
      'Uygulama başladığında son kullanılan projeyi otomatik olarak aç';
  @override
  String get application => 'Uygulama';
  @override
  String get defaultView => 'Varsayılan Görünüm';
  @override
  String get defaultViewDescription => 'Başlangıçta gösterilecek görünüm';
  @override
  String get autoCheckUpdates => 'Güncellemeleri Otomatik Kontrol Et';
  @override
  String get autoCheckUpdatesDescription =>
      'Başlangıçta güncellemeleri kontrol et';
  @override
  String get startupOptions => 'Başlangıç Seçenekleri';
  @override
  String get languageAuto => 'Otomatik Algıla';
  @override
  String get viewBasic => 'Dosya Karşılaştırma';
  @override
  String get viewHistory => 'Geçmiş';
  @override
  String get viewDashboard => 'Kalite Panosu';
  @override
  String get viewDirectory => 'Dizin Karşılaştırma';
  @override
  String get viewLastUsed => 'Son Kullanılan Görünüm';
}

// Path: settings.scope
class _TranslationsSettingsScopeTr extends TranslationsSettingsScopeEn {
  _TranslationsSettingsScopeTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ayarlar Kapsamı';
  @override
  String get global => 'Genel Varsayılanlar';
  @override
  String get project => 'Proje';
  @override
  String get reset => 'Projeyi Genel Varsayılanlara Sıfırla';
  @override
  String get resetConfirmation =>
      'Bu işlem bu proje için tüm geçersiz kılmaları temizleyecek. Bu işlem geri alınamaz.';
  @override
  String get globalDescription =>
      'Değişiklikler aksi belirtilmedikçe tüm projelere uygulanır.';
  @override
  String projectDescription({required Object name}) =>
      'Değişiklikler sadece "${name}" projesine uygulanır. Diğer ayarlar genel varsayılanlardan miras alınır.';
  @override
  String get createPrompt => 'Özel ayarlar için proje oluşturun';
}

// Path: settings.searchKeywords
class _TranslationsSettingsSearchKeywordsTr
    extends TranslationsSettingsSearchKeywordsEn {
  _TranslationsSettingsSearchKeywordsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  List<String> get general => [
        'Dil',
        'Varsayılan Görünüm',
        'Son Dosyalar Sayısı',
        'Son Projeyi Aç',
        'Çıkışta Onayla',
        'Bildirimleri Göster',
      ];
  @override
  List<String> get comparisonEngine => [
        'Karşılaştırma Modu',
        'Benzerlik Eşiği',
        'Büyük/Küçük Harf Duyarlı',
        'Boşlukları Yoksay',
        'Boş Satırları Yoksay',
        'Yorumları Yoksay',
        'Yoksayma Desenleri',
      ];
  @override
  List<String> get appearance => [
        'Tema',
        'Tema Modu',
        'Vurgu Rengi',
        'Fark Yazı Tipi Boyutu',
        'Fark Yazı Tipi Ailesi',
        'Fark Renkleri',
        'Eklendi Rengi',
        'Silindi Rengi',
        'Değiştirildi Rengi',
        'Aynı Rengi',
        'Renk Önayarları',
        'Önizleme',
      ];
  @override
  List<String> get fileHandling => [
        'Kaynak Formatı',
        'Hedef Formatı',
        'Varsayılan Kodlama',
        'Son Proje Sayısı',
        'Çeviri Hafızası',
        'Hafıza İçe Aktar',
        'Hafıza Dışa Aktar',
        'Hafızayı Temizle',
      ];
  @override
  List<String> get aiServices => [
        'OpenAI API Anahtarı',
        'Anthropic API Anahtarı',
        'Google AI API Anahtarı',
        'Yapay Zeka Modeli',
        'Sıcaklık',
        'Özel İstemi',
      ];
  @override
  List<String> get systemIntegrations => [
        'Sistem Tepsisi',
        'Küçültülmüş Başlat',
        'Dosya İlişkilendirmeleri',
        'Mica Efekti',
        'Canlılık',
        'Pencere Materyali',
        'Dock Rozeti',
        'Çevrilmemiş Sayısı',
      ];
  @override
  List<String> get projectResources => [
        'Terimler Sözlüğü',
        'Çeviri Hafızası',
        'Terminoloji',
      ];
  @override
  List<String> get about => [
        'Sürüm',
        'Güncellemeleri Kontrol Et',
        'Otomatik Güncelleme',
        'Değişiklik Günlüğü',
        'Lisans',
        'Gizlilik Politikası',
        'Telemetri',
        'Çökme Raporlama',
      ];
  @override
  List<String> get developer => [
        'Performans Katmanı',
        'Anlamsal Hata Ayıklayıcı',
        'Materyal Izgarası',
        'Raster Önbelleği',
        'Eğitimi Yeniden Başlat',
        'Fabrika Ayarlarına Sıfırla',
      ];
}

// Path: settings.comparison
class _TranslationsSettingsComparisonTr
    extends TranslationsSettingsComparisonEn {
  _TranslationsSettingsComparisonTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Karşılaştırma';
  @override
  String get description => 'Karşılaştırma davranışını yapılandırın';
  @override
  String get caseSensitive => 'Büyük/Küçük Harf Duyarlı';
  @override
  String get caseSensitiveDescription =>
      'Büyük ve küçük harfleri farklı olarak değerlendir';
  @override
  String get ignoreWhitespace => 'Boşlukları Yoksay';
  @override
  String get ignoreWhitespaceDescription =>
      'Karşılaştırırken baştaki/sondaki boşlukları yoksay';
  @override
  String get showLineNumbers => 'Satır Numaralarını Göster';
  @override
  String get showLineNumbersDescription =>
      'Fark görünümünde satır numaralarını göster';
  @override
  String get behavior => 'Karşılaştırma Davranışı';
  @override
  String get ignoreCase => 'Büyük/Küçük Harfi Yoksay';
  @override
  String get ignoreCaseDescription => '"Key" ve "key" aynı kabul edilir';
  @override
  String get similarityThreshold => 'Benzerlik Eşiği';
  @override
  String get similarityThresholdDescription =>
      '"Değiştirildi" tespiti için minimum benzerlik';
  @override
  String get mode => 'Karşılaştırma Modu';
  @override
  String get modeDescription =>
      'Dosyalar arasındaki girişlerin nasıl eşleştirileceği';
  @override
  String get modeKey => 'Anahtar tabanlı';
  @override
  String get modeKeyDescription =>
      'Anahtar adına göre eşleştirir (varsayılan).';
  @override
  String get modeOrder => 'Sıra tabanlı';
  @override
  String get modeOrderDescription => 'Dosyadaki sıraya göre eşleştirir.';
  @override
  String get modeSmart => 'Akıllı Eşleşme';
  @override
  String get modeSmartDescription =>
      'Taşınan/yeniden adlandırılan anahtarları algılar.';
  @override
  String get ignorePatterns => 'Yoksayma Desenleri';
  @override
  String get noIgnorePatterns => 'Yoksayma deseni ayarlanmadı.';
  @override
  String get addPattern => 'Desen Ekle';
  @override
  String get resetToGlobal =>
      'Tüm karşılaştırma ayarlarını küresel varsayılanlara sıfırla';
  @override
  late final _TranslationsSettingsComparisonPatternPresetsTr patternPresets =
      _TranslationsSettingsComparisonPatternPresetsTr._(_root);
  @override
  late final _TranslationsSettingsComparisonPreviewMatchTr previewMatch =
      _TranslationsSettingsComparisonPreviewMatchTr._(_root);
  @override
  late final _TranslationsSettingsComparisonColorPresetsTr colorPresets =
      _TranslationsSettingsComparisonColorPresetsTr._(_root);
}

// Path: settings.fileHandling
class _TranslationsSettingsFileHandlingTr
    extends TranslationsSettingsFileHandlingEn {
  _TranslationsSettingsFileHandlingTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get fileFormats => 'Dosya Biçimleri';
  @override
  String get sourceFormat => 'Kaynak Biçimi';
  @override
  String get targetFormat => 'Hedef Biçimi';
  @override
  String get encoding => 'Kodlama';
  @override
  String get sourceEncoding => 'Kaynak Kodlama';
  @override
  String get targetEncoding => 'Hedef Kodlama';
  @override
  String get autoDetect => 'Otomatik Algıla';
  @override
  String get autoDetectEncodingDescription =>
      'Dosya kodlamasını otomatik algıla';
  @override
  String get exportSettings => 'Dışa Aktarma Ayarları';
  @override
  String get defaultExportFormat => 'Varsayılan Dışa Aktarma Biçimi';
  @override
  String get includeUtf8Bom => 'UTF-8 BOM İçer';
  @override
  String get includeUtf8BomDescription => 'Excel uyumluluğu için gereklidir';
  @override
  String get openFolderAfterExport => 'Dışa Aktardıktan Sonra Klasörü Aç';
  @override
  String get fileSafety => 'Dosya Güvenliği';
  @override
  String get fileSafetyDescription =>
      'Felaket kurtarma için otomatik yerel kopyalar.';
  @override
  String get resetToGlobal =>
      'Tüm dosya işleme ayarlarını küresel varsayılanlara sıfırla';
}

// Path: settings.translationMemory
class _TranslationsSettingsTranslationMemoryTr
    extends TranslationsSettingsTranslationMemoryEn {
  _TranslationsSettingsTranslationMemoryTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Küresel Çeviri Belleği';
  @override
  String get autoLearn => 'Otomatik Öğren';
  @override
  String get autoLearnDescription =>
      'Gelecekte tekrar kullanmak için çevirileri yerel belleğe kaydet';
  @override
  String get confidenceThreshold => 'Güven Eşiği';
  @override
  String confidenceThresholdDescription({required Object percent}) =>
      'Otomatik uygulama için minimum puan (${percent}%)';
  @override
  String get entries => 'Girdiler';
  @override
  String get size => 'Boyut';
  @override
  String memorySize({required Object size}) => 'Bellek Boyutu: ${size}';
  @override
  String get import => 'İçe Aktar';
  @override
  String get exportTmx => 'TMX Dışa Aktar';
  @override
  String get exportCsv => 'CSV Dışa Aktar';
  @override
  String get clearMemory => 'Belleği Temizle';
  @override
  String importedItems({required Object count}) =>
      '${count} öğe belleğe aktarıldı.';
  @override
  String get noItemsAdded => 'Hiçbir öğe eklenmedi.';
  @override
  String get nothingToExport => 'Henüz dışa aktarılacak bir şey yok.';
  @override
  String get tmxSaved => 'TMX kaydedildi';
  @override
  String get csvSaved => 'CSV kaydedildi';
  @override
  String get clearConfirmTitle => 'Çeviri belleği temizlensin mi?';
  @override
  String get clearConfirmContent =>
      'Bu, bu cihazdaki tüm kayıtlı çeviri çiftlerini kaldırır. Bu işlem geri alınamaz.';
  @override
  String get cleared => 'Çeviri belleği temizlendi.';
  @override
  String get couldNotClear => 'Bellek temizlenemedi.';
}

// Path: settings.backup
class _TranslationsSettingsBackupTr extends TranslationsSettingsBackupEn {
  _TranslationsSettingsBackupTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Otomatik Yedekleme';
  @override
  String get description => 'Otomatik yedekleme ayarları';
  @override
  String get enabled => 'Otomatik Yedeklemeyi Etkinleştir';
  @override
  String get enabledDescription =>
      'Değişiklik yapmadan önce dosyaları otomatik olarak yedekle';
  @override
  String get maxCopies => 'Maksimum Yedek Kopya Sayısı';
  @override
  String get maxCopiesDescription =>
      'Dosya başına tutulacak yedek kopya sayısı';
  @override
  String activeStatus({required Object count}) =>
      'Etkin · ${count} kopya saklanıyor';
  @override
  String get folder => 'Yedek Klasörü';
  @override
  String get folderDescription => 'Aynı klasörü kullanmak için boş bırakın';
  @override
  String get useOriginalFolder => 'Orijinal dosya klasörünü kullan';
}

// Path: settings.ai
class _TranslationsSettingsAiTr extends TranslationsSettingsAiEn {
  _TranslationsSettingsAiTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Yapay Zeka Hizmetleri';
  @override
  String get description =>
      'Yapay zeka çeviri ve yardım ayarlarını yapılandırın';
  @override
  String get provider => 'Yapay Zeka Sağlayıcısı';
  @override
  String get providerDescription =>
      'Tercih ettiğiniz yapay zeka hizmet sağlayıcısını seçin';
  @override
  String get apiKey => 'API Anahtarı';
  @override
  String get apiKeyDescription =>
      'Seçilen sağlayıcı için API anahtarınızı girin';
  @override
  String get apiKeyPlaceholder => 'API anahtarını girin...';
  @override
  String get testConnection => 'Bağlantıyı Test Et';
  @override
  String get connectionSuccess => 'Bağlantı başarılı!';
  @override
  String get connectionFailed =>
      'Bağlantı başarısız. Lütfen API anahtarınızı kontrol edin.';
  @override
  String get translationStrategy => 'Çeviri Stratejisi';
  @override
  String get strategy => 'Strateji';
  @override
  String get strategyDescription => 'Dizelerin nasıl çevrileceğini seçin';
  @override
  String get strategyLLM => 'Üretken Yapay Zeka (LLM)';
  @override
  String get strategyCloud => 'Bulut Çevirisi';
  @override
  String get enableAiTranslation => 'Yapay Zeka Çevirisini Etkinleştir';
  @override
  String get enableAiTranslationDescription =>
      'Uygulamanın çeviri önerileri için yapay zeka kullanmasına izin ver';
  @override
  String get llmProvider => 'LLM Hizmet Sağlayıcısı';
  @override
  String get service => 'Hizmet';
  @override
  String get serviceDescription => 'Üretken Yapay Zeka Sağlayıcısı';
  @override
  String get providerGemini => 'Google Gemini';
  @override
  String get providerOpenAI => 'OpenAI';
  @override
  String get geminiApiKey => 'Gemini API Anahtarı';
  @override
  String get openAiApiKey => 'OpenAI API Anahtarı';
  @override
  String get model => 'Model';
  @override
  String get modelDescription => 'Hangi modelin kullanılacağını seçin';
  @override
  String get advancedParameters => 'Gelişmiş Parametreler';
  @override
  String get parameters => 'Parametreler';
  @override
  String get parametersDescription => 'Sıcaklık, Bağlam ve daha fazlası';
  @override
  String get temperature => 'Sıcaklık';
  @override
  String get temperatureDescription =>
      'Yüksek değerler çıktıyı daha yaratıcı yapar';
  @override
  String get maxTokens => 'Maksimum Token';
  @override
  String get maxTokensDescription => 'Bağlam penceresi uzunluğunu sınırla';
  @override
  String get systemContext => 'Sistem Bağlamı / Talimatlar';
  @override
  String get systemContextHint =>
      'Siz profesyonel bir yerelleştiricisiniz. Kaynak dizenin tonunu ve amacını koruyun...';
  @override
  String get systemContextHelper =>
      'Projenizin tarzı ve terminolojisi hakkında yapay zekaya özel talimatlar verin.';
  @override
  String get contextStrings => 'Bağlam Dizeleri';
  @override
  String get contextStringsDescription =>
      'Daha iyi bağlam için çevreleyen dizeleri ekle';
  @override
  String get contextCount => 'Bağlam Sayısı';
  @override
  String get contextCountDescription => 'Eklenecek çevreleyen dize sayısı';
  @override
  String get cloudServices => 'Bulut Çeviri Hizmetleri';
  @override
  String get googleTranslateApiKey => 'Google Translate API Anahtarı';
  @override
  String get deeplApiKey => 'DeepL API Anahtarı';
  @override
  String get test => 'Test Et';
  @override
  String get resetToGlobal =>
      'Tüm Yapay Zeka ayarlarını küresel varsayılanlara sıfırla';
}

// Path: settings.integrations
class _TranslationsSettingsIntegrationsTr
    extends TranslationsSettingsIntegrationsEn {
  _TranslationsSettingsIntegrationsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get platformNotice => 'Platform Bildirimi';
  @override
  String get platformNoticeDescription =>
      'Sistem entegrasyonları bu platformda mevcut değil.';
  @override
  String get visualEffects => 'Görsel Efektler';
  @override
  String get explorerIntegration => 'Gezgin Entegrasyonu';
  @override
  String get explorerIntegrationDescription =>
      'Klasörler için Windows Gezgini sağ tık menüsüne "Localizer ile Aç" seçeneğini ekleyin.';
  @override
  String get addToContextMenu => 'Bağlam Menüsüne Ekle';
  @override
  String get contextMenuAdded => 'Bağlam menüsü eklendi!';
  @override
  String get contextMenuAddError => 'Bağlam menüsü eklenemedi';
  @override
  String get contextMenuRemoved => 'Bağlam menüsü kaldırıldı!';
  @override
  String get contextMenuRemoveError => 'Bağlam menüsü kaldırılamadı';
  @override
  String get fileAssociations => 'Dosya İlişkilendirmeleri';
  @override
  String get fileAssociationsDescription =>
      'Dosya türlerini, Gezgin\'de çift tıklandığında Localizer ile açılacak şekilde kaydedin.';
  @override
  String get registered => 'Kayıtlı';
  @override
  String get notRegistered => 'Kayıtlı Değil';
  @override
  String extRegistered({required Object ext}) => '${ext} kaydedildi!';
  @override
  String extUnregistered({required Object ext}) => '${ext} kaydı silindi!';
  @override
  String extError({required Object ext, required Object action}) =>
      '${ext} ${action} başarısız';
  @override
  String get registerAll => 'Tümünü Kaydet';
  @override
  String get unregisterAll => 'Tümünü Kaldır';
  @override
  String registerAllResult({required Object total, required Object success}) =>
      '${total} dosya türünden ${success} tanesi kaydedildi';
  @override
  String unregisterAllResult(
          {required Object total, required Object success}) =>
      '${total} dosya türünden ${success} tanesinin kaydı silindi';
  @override
  String get protocolHandler => 'Protokol İşleyici';
  @override
  String get protocolHandlerDescription =>
      'Bu uygulamayı açmak için localizer:// URL\'lerini kaydedin. Projelerin doğrudan tarayıcı bağlantılarından veya diğer uygulamalardan açılmasını sağlar.';
  @override
  String get protocolRegistered => 'Protokol işleyici kayıtlı';
  @override
  String get protocolNotRegistered => 'Protokol işleyici kayıtlı değil';
  @override
  String get registerProtocol => 'Protokolü Kaydet';
  @override
  String get unregister => 'Kaydı Sil';
  @override
  String get protocolRegisteredSuccess => 'Protokol işleyici kaydedildi!';
  @override
  String get protocolRemovedSuccess => 'Protokol işleyici kaldırıldı!';
  @override
  String get protocolRegisterError => 'Kayıt başarısız';
  @override
  String get protocolRemoveError => 'Kaldırma başarısız';
  @override
  String get windowMaterial => 'Pencere Malzemesi';
  @override
  String get windowMaterialDescription =>
      'macOS canlılık malzemesi stilini seçin';
  @override
  String get dockIntegration => 'Dock Entegrasyonu';
  @override
  String get showDockBadge => 'Çevrilmemiş Sayısını Göster';
  @override
  String get showDockBadgeDescription =>
      'Dock simgesi rozetinde çevrilmemiş dize sayısını görüntüle';
  @override
  late final _TranslationsSettingsIntegrationsMaterialsTr materials =
      _TranslationsSettingsIntegrationsMaterialsTr._(_root);
  @override
  late final _TranslationsSettingsIntegrationsFileTypesTr fileTypes =
      _TranslationsSettingsIntegrationsFileTypesTr._(_root);
}

// Path: settings.developer
class _TranslationsSettingsDeveloperTr extends TranslationsSettingsDeveloperEn {
  _TranslationsSettingsDeveloperTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Geliştirici Ayarları';
  @override
  String get description => 'Geliştiriciler için gelişmiş ayarlar';
  @override
  String get showLocalizationKeys => 'Yerelleştirme Anahtarlarını Göster';
  @override
  String get localizationKeysDescription =>
      'Etkinleştirildiğinde, tüm çevrilmiş metinler çevrilmiş değer yerine yerelleştirme anahtarlarını gösterir. Hangi anahtarın nerede kullanıldığını doğrulamak için faydalıdır.';
  @override
  String get showPerformanceOverlay => 'Performans Katmanını Göster';
  @override
  String get performanceOverlayDescription =>
      'FPS ve kare zamanlama bilgilerini göster';
  @override
  String get debugMode => 'Hata Ayıklama Modu';
  @override
  String get debugModeDescription =>
      'Ek günlükleme ve hata ayıklama özelliklerini etkinleştir';
  @override
  String get debuggingTools => 'Hata Ayıklama Araçları';
  @override
  String get semanticsDebugger => 'Anlamsal Hata Ayıklayıcı';
  @override
  String get semanticsDebuggerDescription => 'Anlamsal ağacı görselleştir';
  @override
  String get materialGrid => 'Materyal Izgara';
  @override
  String get materialGridDescription => 'Materyal düzen ızgarasını yerleştir';
  @override
  String get rasterCache => 'Raster Önbellek Görüntüleri';
  @override
  String get rasterCacheDescription =>
      'Dama tahtası raster önbellek görüntüleri';
  @override
  String get actions => 'Eylemler';
  @override
  String get showLogs => 'Uygulama Günlüklerini Göster';
  @override
  String get showLogsDescription => 'Talker hata ayıklama konsolunu aç';
  @override
  String get restartTutorial => 'Tanıtım Eğitimini Yeniden Başlat';
  @override
  String get restartTutorialDescription =>
      'Bayrakları sıfırla ve eğitimi tekrar başlat';
  @override
  String get restartRequested => 'Eğitim yeniden başlatma istendi.';
  @override
  String get throwException => 'Test İstisnası Fırlat';
  @override
  String get throwExceptionDescription =>
      'Kilitlenme raporlaması için bir test istisnası tetikle';
  @override
  String get testExceptionMessage =>
      'Geliştirici Seçeneklerinden Test İstisnası tetiklendi';
  @override
  String get clearTM => 'Çeviri Belleğini Temizle';
  @override
  String get clearTMDescription => 'Tüm önbelleğe alınmış çevirileri sil';
  @override
  String get clearTMConfirmation => 'Çeviri Belleğini Temizle?';
  @override
  String get clearTMWarning =>
      'Bu, öğrenilen tüm çevirileri silecek. Bu işlem geri alınamaz.';
  @override
  String get tmCleared => 'Çeviri belleği temizlendi';
  @override
  String get clearApiKeys => 'API Anahtarlarını Temizle';
  @override
  String get clearApiKeysDescription => 'Kayıtlı tüm API anahtarlarını kaldır';
  @override
  String get clearApiKeysConfirmation => 'API Anahtarlarını Temizle?';
  @override
  String get clearApiKeysWarning =>
      'Bu, güvenli depolamadaki tüm API anahtarlarını kaldıracak.';
  @override
  String get apiKeysCleared => 'API anahtarları temizlendi';
  @override
  String get hideOptions => 'Geliştirici Seçeneklerini Gizle';
  @override
  String get hideOptionsDescription =>
      'Geliştirici modunu devre dışı bırak (yeniden etkinleştirmek için 7 kez dokunun)';
  @override
  String get optionsDisabled => 'Geliştirici seçenekleri devre dışı bırakıldı';
  @override
  String get dangerZone => 'Tehlike Bölgesi';
  @override
  String get factoryReset => 'Fabrika Ayarlarına Sıfırla';
  @override
  String get factoryResetDescription =>
      'Tüm ayarları sıfırla ve verileri temizle';
  @override
  String get factoryResetWarning =>
      'Tüm ayarları sıfırlamak istediğinizden emin misiniz? Bu işlem geri alınamaz.';
  @override
  String get inspectionTools => 'İnceleme Araçları';
  @override
  String get searchHint => 'Ayarlarda ara...';
  @override
  String get resetToDefault => 'Varsayılanlara sıfırla';
  @override
  String get resetToGlobal => 'Küresel varsayılana sıfırla';
  @override
  String get storageInspector => 'Depo Denetleyici';
  @override
  String get storageInspectorDescription =>
      'Hive ve Güvenli Depo içeriklerini görüntüle';
  @override
  String get deviceEnvironment => 'Cihaz ve Ortam';
  @override
  String get deviceEnvironmentDescription =>
      'Ekran, platform ve derleme bilgisi';
  @override
  String get themePlayground => 'Tema Oyun Alanı';
  @override
  String get themePlaygroundDescription => 'Renk paleti ve tipografi';
  @override
  String get localizationInspector => 'Yerelleştirme Denetleyici';
  @override
  String get localizationInspectorDescription =>
      'Çeviri dizelerinde hata ayıkla';
  @override
  String get hiveAppSettings => 'Hive (Uygulama Ayarları)';
  @override
  String get secureStorageMasked => 'Güvenli Depo (Maskelenmiş)';
  @override
  late final _TranslationsSettingsDeveloperStorageInspectorSectionTr
      storageInspectorSection =
      _TranslationsSettingsDeveloperStorageInspectorSectionTr._(_root);
  @override
  late final _TranslationsSettingsDeveloperDeviceInfoSectionTr
      deviceInfoSection =
      _TranslationsSettingsDeveloperDeviceInfoSectionTr._(_root);
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionTr
      themePlaygroundSection =
      _TranslationsSettingsDeveloperThemePlaygroundSectionTr._(_root);
  @override
  late final _TranslationsSettingsDeveloperLocalizationInspectorSectionTr
      localizationInspectorSection =
      _TranslationsSettingsDeveloperLocalizationInspectorSectionTr._(_root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsTr featureFlags =
      _TranslationsSettingsDeveloperFeatureFlagsTr._(_root);
}

// Path: settings.about
class _TranslationsSettingsAboutTr extends TranslationsSettingsAboutEn {
  _TranslationsSettingsAboutTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Hakkında';
  @override
  String get version => 'Sürüm';
  @override
  String get buildNumber => 'Yapı Numarası';
  @override
  String get author => 'Yazar';
  @override
  String get license => 'Lisans';
  @override
  String get sourceCode => 'Kaynak Kodu';
  @override
  String get reportBug => 'Hata Bildir';
  @override
  String get requestFeature => 'Özellik İste';
  @override
  String get checkForUpdates => 'Güncellemeleri Kontrol Et';
  @override
  String get upToDate => 'Güncelsiniz!';
  @override
  String updateAvailable({required Object version}) =>
      'Güncelleme mevcut: ${version}';
  @override
  String get updateAvailableBadge => 'Güncelleme Mevcut!';
  @override
  String developerSteps({required Object count}) =>
      'Geliştirici olmanıza ${count} adım kaldı.';
  @override
  String get developerActivated => 'Artık bir geliştiricisiniz!';
  @override
  String get neverChecked => 'Asla';
  @override
  String get applicationInfo => 'Uygulama Bilgisi';
  @override
  String get platform => 'Platform';
  @override
  String get updateInformation => 'Güncelleme Bilgisi';
  @override
  String get currentVersion => 'Mevcut Sürüm';
  @override
  String get latestVersion => 'Son Sürüm';
  @override
  String get lastChecked => 'Son Kontrol';
  @override
  String get checkingForUpdates => 'Kontrol ediliyor...';
  @override
  String get whatsNew => 'Yenilikler';
  @override
  String get systemInformation => 'Sistem Bilgisi';
  @override
  String get dartVersion => 'Dart Sürümü';
  @override
  String get diskSpace => 'Kullanılabilir Disk Alanı';
  @override
  String get memoryUsage => 'Bellek Kullanımı';
  @override
  String get privacyTitle => 'Gizlilik ve Telemetri';
  @override
  String get usageStats => 'Anonim Kullanım İstatistikleri';
  @override
  String get requiresFirebase => 'Firebase yapılandırması gerektirir';
  @override
  String get featureUnavailable =>
      'Özellik şu anda kullanılamıyor (Firebase gerektirir)';
  @override
  String get settingsManagement => 'Ayarlar Yönetimi';
  @override
  String get settingsManagementDescription =>
      'Ayarlarınızı yedeklemek veya başka makinelerle paylaşmak için bir dosyaya aktarın.';
  @override
  String get resetAll => 'Tümünü Sıfırla';
  @override
  String get links => 'Bağlantılar';
  @override
  String get githubRepo => 'GitHub Deposu';
  @override
  String get privacyPolicy => 'Gizlilik Politikası';
  @override
  String get crashReporting => 'Çökme Raporlama';
}

// Path: settings.onboarding
class _TranslationsSettingsOnboardingTr
    extends TranslationsSettingsOnboardingEn {
  _TranslationsSettingsOnboardingTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'Eğitimi Atla';
  @override
  String get gettingStarted => 'Başlarken';
  @override
  String stepProgress({required Object total, required Object current}) =>
      '${total} adımdan ${current}. adım';
  @override
  String get loadSampleData => 'Örnek Verileri Yükle';
  @override
  late final _TranslationsSettingsOnboardingStepsTr steps =
      _TranslationsSettingsOnboardingStepsTr._(_root);
}

// Path: settings.settingsView
class _TranslationsSettingsSettingsViewTr
    extends TranslationsSettingsSettingsViewEn {
  _TranslationsSettingsSettingsViewTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String resetCategoryTitle({required Object category}) =>
      '${category} Sıfırlansın mı?';
  @override
  String get resetCategoryContent =>
      'Bu, bu kategorideki tüm ayarları varsayılan değerlerine sıfırlayacaktır.';
  @override
  String get resetAllTitle => 'Tüm Ayarlar Sıfırlansın mı?';
  @override
  String get resetAllContent =>
      'Bu, tüm ayarları kalıcı olarak fabrika varsayılanlarına sıfırlayacaktır. Bu işlem geri alınamaz.';
  @override
  String get resetAll => 'Tümünü Sıfırla';
  @override
  String resetSuccess({required Object category}) =>
      '${category} varsayılanlara sıfırlandı';
  @override
  String get errorLoading => 'Ayarlar yüklenirken hata oluştu';
  @override
  String get settingsSaved => 'Ayarlar kaydedildi';
  @override
  String updateAvailable({required Object version}) =>
      'Güncelleme mevcut: v${version}';
  @override
  String get latestVersion => 'En son sürümü kullanıyorsunuz';
  @override
  String whatsNew({required Object version}) =>
      'v${version} Sürümündeki Yenilikler';
  @override
  String get downloadUpdate => 'Güncellemeyi İndir';
  @override
  String get exportSettings => 'Ayarları Dışa Aktar';
  @override
  String get settingsExported => 'Ayarlar dışa aktarıldı';
  @override
  String exportFail({required Object error}) =>
      'Ayarlar dışa aktarılamadı: ${error}';
  @override
  String get importSettings => 'Ayarları İçe Aktar';
  @override
  String get importTitle => 'Ayarlar İçe Aktarılsın mı?';
  @override
  String get importContent =>
      'Bu, mevcut tüm ayarlarınızı içe aktarılanlarla değiştirecektir. Bu işlem geri alınamaz.';
  @override
  String get importSuccess => 'Ayarlar başarıyla içe aktarıldı!';
  @override
  String importFail({required Object error}) =>
      'Ayarlar içe aktarılamadı: ${error}';
  @override
  String get invalidFormat => 'Geçersiz ayar dosyası formatı';
  @override
  late final _TranslationsSettingsSettingsViewCategoriesTr categories =
      _TranslationsSettingsSettingsViewCategoriesTr._(_root);
  @override
  late final _TranslationsSettingsSettingsViewCategoryLabelsTr categoryLabels =
      _TranslationsSettingsSettingsViewCategoryLabelsTr._(_root);
}

// Path: advancedDiff.aiSuggestion
class _TranslationsAdvancedDiffAiSuggestionTr
    extends TranslationsAdvancedDiffAiSuggestionEn {
  _TranslationsAdvancedDiffAiSuggestionTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get aiTranslation => 'Yapay Zeka Çevirisi';
  @override
  String get aiRephrase => 'Yapay Zeka Yeniden İfadesi';
  @override
  String key({required Object key}) => 'Anahtar: ${key}';
  @override
  String get original => 'Orijinal:';
  @override
  String get suggestion => 'Öneri:';
  @override
  String get confidence => 'Yapay Zeka Güveni';
  @override
  String get cancelEdit => 'Düzenlemeyi iptal et';
  @override
  String get editSuggestion => 'Öneriyi düzenle';
  @override
  String get alternatives => 'Alternatifler:';
  @override
  String get accept => 'Kabul Et';
  @override
  String get reject => 'Reddet';
  @override
  String get stop => 'Durdur';
}

// Path: advancedDiff.detailEdit
class _TranslationsAdvancedDiffDetailEditTr
    extends TranslationsAdvancedDiffDetailEditEn {
  _TranslationsAdvancedDiffDetailEditTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object key}) => 'Düzenle: ${key}';
  @override
  String get sourceLabel => 'KAYNAK (Orijinal)';
  @override
  String get targetLabel => 'HEDEF (Çeviri)';
  @override
  String get translateWithCloud => 'Bulut ile Çevir';
  @override
  String get translateWithAi => 'Yapay Zeka ile Çevir';
  @override
  String get translating => 'Çevriliyor...';
  @override
  String get applyAndTm => 'Uygula';
  @override
  String get entryApplied => 'Giriş uygulandı ve Çeviri Belleğine eklendi';
  @override
  String get translationAdded => 'Çeviri önerisi eklendi.';
  @override
  String get aiSuggestionAdded => 'Yapay zeka önerisi eklendi.';
}

// Path: advancedDiff.table
class _TranslationsAdvancedDiffTableTr extends TranslationsAdvancedDiffTableEn {
  _TranslationsAdvancedDiffTableTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get addedToTM => 'Çeviri Belleğine Eklendi';
  @override
  String get markedReviewed => 'İncelendi olarak işaretlendi ✓';
  @override
  String get unmarkedReview => 'İnceleme işareti kaldırıldı';
  @override
  String get reverted => 'Kaynak değere geri döndürüldü';
  @override
  String get entryDeleted => 'Giriş silindi';
  @override
  String get noSourceText => 'Çevrilecek kaynak metin yok.';
  @override
  String aiTranslationFailed({required Object key}) =>
      '"${key}" için yapay zeka çevirisi başarısız oldu';
  @override
  String get noTargetText => 'Yeniden ifade edilecek hedef metin yok.';
  @override
  String aiRephraseFailed({required Object key}) =>
      '"${key}" için yapay zeka yeniden ifadesi başarısız oldu';
  @override
  String get checkRowsFirst =>
      'Önce onay kutularını kullanarak satırları seçin';
  @override
  String markedRowsReviewed({required Object count}) =>
      '${count} satır incelendi olarak işaretlendi';
  @override
  String revertedRows({required Object count}) => '${count} satır geri alındı';
  @override
  String entriesCount({required Object count}) => '${count} giriş';
  @override
  String get markSelectedReviewed => 'Seçilenleri İncelendi Olarak İşaretle';
  @override
  String get revertSelected => 'Seçilenleri Geri Al';
  @override
  String get noDifferences => 'Fark bulunamadı';
  @override
  String get adjustFilters => 'Filtrelerinizi ayarlamayı deneyin';
  @override
  String get cloudTranslationApplied => 'Bulut çevirisi uygulandı.';
  @override
  String get aiTranslationApplied => 'Yapay zeka çevirisi uygulandı.';
  @override
  String get suggestionApplied => 'Öneri uygulandı.';
  @override
  String get aiSuggestionApplied => 'Yapay zeka önerisi uygulandı.';
  @override
  String get rephraseApplied => 'Yeniden ifade etme uygulandı.';
  @override
  String get aiRephraseApplied => 'Yapay zeka yeniden ifadesi uygulandı.';
  @override
  String get rephrase => 'Yeniden İfade Et';
  @override
  String get aiRephrase => 'Yapay Zeka ile Yeniden İfade Et';
  @override
  String get targetClickToEdit => 'HEDEF (Düzenlemek için tıklayın)';
  @override
  String get targetClickForDialog => 'HEDEF (Diyalog için tıklayın)';
  @override
  String get emptyClickToEdit => '(Boş - Düzenlemek için tıklayın)';
  @override
  String get unmarkReviewed => 'İncelendi işaretini kaldır';
  @override
  String get markReviewed => 'İncelendi olarak işaretle';
  @override
  String get revertToSource => 'Kaynağa geri dön';
  @override
  String get translateWithCloud => 'Bulut ile Çevir';
  @override
  String get translateWithAi => 'Yapay Zeka ile Çevir';
  @override
  String get rephraseWithAi => 'Yapay Zeka ile Yeniden İfade Et';
  @override
  String get moreActions => 'Diğer eylemler';
  @override
  String get editDetails => 'Ayrıntıları düzenle';
  @override
  String get suggestTranslation => 'Çeviri öner';
  @override
  String get addToTm => 'ÇB\'ye Ekle';
  @override
  String get deleteEntry => 'Girişi sil';
}

// Path: advancedDiff.diffRow
class _TranslationsAdvancedDiffDiffRowTr
    extends TranslationsAdvancedDiffDiffRowEn {
  _TranslationsAdvancedDiffDiffRowTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get copySource => 'Kaynak metni kopyala';
  @override
  String get copyTarget => 'Hedef metni kopyala';
  @override
  String get actions => 'Eylemler';
}

// Path: advancedDiff.status
class _TranslationsAdvancedDiffStatusTr
    extends TranslationsAdvancedDiffStatusEn {
  _TranslationsAdvancedDiffStatusTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'EKLENDİ';
  @override
  String get missing => 'EKSİK';
  @override
  String changed({required Object percent}) => 'DĞŞ %${percent}';
  @override
  String get same => 'AYNI';
}

// Path: advancedDiff.sidebar
class _TranslationsAdvancedDiffSidebarTr
    extends TranslationsAdvancedDiffSidebarEn {
  _TranslationsAdvancedDiffSidebarTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get widgets => 'Araçlar';
  @override
  String get searchPlaceholder => 'Anahtarları ve değerleri ara... (Ctrl+F)';
  @override
  String get fuzzySearchTooltip => 'Bulanık Arama (yazım hatasına toleranslı)';
  @override
  String get regexSearchTooltip => 'Regex Arama';
  @override
  String get cloudTranslation => 'Bulut Çevirisi';
  @override
  String get aiTranslation => 'Yapay Zeka Çevirisi';
  @override
  String get status => 'Durum';
  @override
  String get tm => 'Çeviri Belleği';
  @override
  String get filters => 'Filtreler';
  @override
  String get actions => 'Eylemler';
  @override
  String get similarity => 'Benzerlik';
  @override
  late final _TranslationsAdvancedDiffSidebarActionsSectionTr actionsSection =
      _TranslationsAdvancedDiffSidebarActionsSectionTr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarAiSectionTr aiSection =
      _TranslationsAdvancedDiffSidebarAiSectionTr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarTmSectionTr tmSection =
      _TranslationsAdvancedDiffSidebarTmSectionTr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarFiltersSectionTr filtersSection =
      _TranslationsAdvancedDiffSidebarFiltersSectionTr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarSimilaritySectionTr
      similaritySection =
      _TranslationsAdvancedDiffSidebarSimilaritySectionTr._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarStatusSectionTr statusSection =
      _TranslationsAdvancedDiffSidebarStatusSectionTr._(_root);
}

// Path: issueDetails.duplicateValue
class _TranslationsIssueDetailsDuplicateValueTr
    extends TranslationsIssueDetailsDuplicateValueEn {
  _TranslationsIssueDetailsDuplicateValueTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'TEKRARLANAN ÇEVİRİ';
  @override
  String get warning =>
      'Farklı kaynak metinler aynı çeviriyi kullanıyor. Bağlamı kontrol edin.';
  @override
  String affectedKeys({required Object count}) =>
      'ETKİLENEN ANAHTARLAR (${count})';
  @override
  String get identicalSources => 'Aynı Kaynaklar';
  @override
  String moreKeys({required Object count}) => '+${count} anahtar daha';
}

// Path: issueDetails.lengthOutlier
class _TranslationsIssueDetailsLengthOutlierTr
    extends TranslationsIssueDetailsLengthOutlierEn {
  _TranslationsIssueDetailsLengthOutlierTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get source => 'KAYNAK';
  @override
  String get translation => 'ÇEVİRİ';
  @override
  String chars({required Object count}) => '${count} karakter';
}

// Path: issueDetails.standard
class _TranslationsIssueDetailsStandardTr
    extends TranslationsIssueDetailsStandardEn {
  _TranslationsIssueDetailsStandardTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'ANAHTAR';
  @override
  String get sourceText => 'KAYNAK METİN';
  @override
  String get translation => 'ÇEVİRİ';
  @override
  String get errorDetails => 'HATA AYRINTILARI';
  @override
  String get note => 'NOT';
}

// Path: issueDetails.types
class _TranslationsIssueDetailsTypesTr extends TranslationsIssueDetailsTypesEn {
  _TranslationsIssueDetailsTypesTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get duplicateValue => 'Yinelenen Değerler';
  @override
  String get lengthOutlier => 'Uzunluk Uyumsuzluğu';
  @override
  String get placeholderMismatch => 'Bozuk Yer Tutucular';
}

// Path: issueDetails.notes
class _TranslationsIssueDetailsNotesTr extends TranslationsIssueDetailsNotesEn {
  _TranslationsIssueDetailsNotesTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get placeholderMismatch =>
      '{name} gibi işaretçiler kaynakla eşleşmelidir.';
  @override
  String get lengthOutlier =>
      'Büyük uzunluk değişiklikleri metnin ekrana nasıl sığacağını etkileyebilir.';
  @override
  String get duplicateValue =>
      'Farklı anahtarlar için aynı çeviri kullanılmış.';
}

// Path: issueDetails.fallbacks
class _TranslationsIssueDetailsFallbacksTr
    extends TranslationsIssueDetailsFallbacksEn {
  _TranslationsIssueDetailsFallbacksTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get multipleSources => 'Birden fazla kaynak metin';
  @override
  String get sourceNotAvailable => 'Kaynak metin mevcut değil';
  @override
  String get sharedTranslationNotAvailable => 'Paylaşılan çeviri mevcut değil';
  @override
  String get translationNotAvailable => 'Çeviri mevcut değil';
}

// Path: compare.tabs
class _TranslationsCompareTabsTr extends TranslationsCompareTabsEn {
  _TranslationsCompareTabsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get files => 'Dosyalar';
  @override
  String get directories => 'Dizinler';
  @override
  String get git => 'Git';
}

// Path: compare.fileTypes
class _TranslationsCompareFileTypesTr extends TranslationsCompareFileTypesEn {
  _TranslationsCompareFileTypesTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get json => 'JSON yerelleştirme dosyaları (i18next, Flutter, vb.)';
  @override
  String get yaml => 'YAML yerelleştirme dosyaları (Rails, Flutter)';
  @override
  String get xml => 'XML yerelleştirme dosyaları (Android, .NET)';
  @override
  String get properties => 'Properties dosyaları (Java)';
  @override
  String get resx => 'RESX dosyaları (.NET)';
  @override
  String get xliff => 'XLIFF dosyaları';
}

// Path: history.timeAgo
class _TranslationsHistoryTimeAgoTr extends TranslationsHistoryTimeAgoEn {
  _TranslationsHistoryTimeAgoTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get justNow => 'az önce';
  @override
  String secondsAgo({required Object count}) => '${count} saniye önce';
  @override
  String get oneMinuteAgo => '1 dakika önce';
  @override
  String minutesAgo({required Object count}) => '${count} dakika önce';
  @override
  String get oneHourAgo => '1 saat önce';
  @override
  String hoursAgo({required Object count}) => '${count} saat önce';
  @override
  String get yesterday => 'dün';
  @override
  String daysAgo({required Object count}) => '${count} gün önce';
  @override
  String get oneWeekAgo => '1 hafta önce';
  @override
  String weeksAgo({required Object count}) => '${count} hafta önce';
  @override
  String get oneMonthAgo => '1 ay önce';
  @override
  String monthsAgo({required Object count}) => '${count} ay önce';
  @override
  String get oneYearAgo => '1 yıl önce';
  @override
  String yearsAgo({required Object count}) => '${count} yıl önce';
  @override
  String get inTheFuture => 'gelecekte';
}

// Path: projects.stats
class _TranslationsProjectsStatsTr extends TranslationsProjectsStatsEn {
  _TranslationsProjectsStatsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get empty => 'Boş proje';
  @override
  String files({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(
        n,
        one: '1 çeviri dosyası',
        other: '${count} çeviri dosyası',
      );
  @override
  String languages({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(
        n,
        one: '1 dil',
        other: '${count} dil',
      );
}

// Path: projects.selection
class _TranslationsProjectsSelectionTr extends TranslationsProjectsSelectionEn {
  _TranslationsProjectsSelectionTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get selectFolder => 'Proje Klasörünü Seç';
  @override
  String get selectArchive => 'Proje Arşivini Seç';
  @override
  String get openProject => 'Projeyi Aç';
  @override
  String get browseFolder => 'Klasöre Göz At...';
  @override
  String get createNew => 'Yeni Oluştur';
  @override
  String get importFromZip => 'Zip\'ten İçe Aktar...';
}

// Path: projects.createDialog
class _TranslationsProjectsCreateDialogTr
    extends TranslationsProjectsCreateDialogEn {
  _TranslationsProjectsCreateDialogTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Proje Oluştur';
  @override
  String get description =>
      'Bir proje, belirli bir klasör için özel ayarları kaydetmenizi sağlar. Proje yapılandırmanızı saklamak için bir ".localizer" klasörü oluşturulacaktır.';
  @override
  String get folderLabel => 'Proje Klasörü';
  @override
  String get folderHint => 'Klasör seçmek için tıklayın...';
  @override
  String get nameLabel => 'Proje Adı';
  @override
  String get nameHint => 'ör. Uygulamam Çevirileri';
  @override
  String get selectFolderWarning => 'Lütfen bir proje klasörü seçin.';
  @override
  String get enterNameError => 'Lütfen bir proje adı girin';
  @override
  String get nameLengthError => 'Ad en az 2 karakter olmalıdır';
  @override
  String success({required Object name}) =>
      '"${name}" projesi başarıyla oluşturuldu!';
  @override
  String get failure => 'Proje oluşturulamadı.';
  @override
  String get creating => 'Oluşturuluyor...';
  @override
  String get createAction => 'Proje Oluştur';
}

// Path: projects.indicator
class _TranslationsProjectsIndicatorTr extends TranslationsProjectsIndicatorEn {
  _TranslationsProjectsIndicatorTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get tooltipNoProject =>
      'Bir klasör için özel ayarları kaydetmek üzere proje oluşturun';
  @override
  String tooltipProject({required Object name}) =>
      'Proje: ${name}\nSeçenekleri görmek için tıklayın';
  @override
  String get location => 'Konum';
  @override
  String get created => 'Oluşturulma';
  @override
  String get switchProject => 'Proje Değiştir';
  @override
  String get done => 'Bitti';
}

// Path: projects.glossary
class _TranslationsProjectsGlossaryTr extends TranslationsProjectsGlossaryEn {
  _TranslationsProjectsGlossaryTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Proje Sözlüğü';
  @override
  String get description =>
      'Tutarlı bir şekilde ele alınması veya asla çevrilmemesi gereken terimleri tanımlayın.';
  @override
  String get noTerms => 'Henüz sözlük terimi yok.';
  @override
  String get noTermsDesc =>
      'Çeviriler arasında tutarlı kalması gereken terimleri ekleyin\nveya asla çevrilmemesi gereken marka adlarını işaretleyin.';
  @override
  String get doNotTranslate => 'Çevirme';
  @override
  String get noSpecificTranslation => 'Belirli bir çeviri yok';
  @override
  String get addTerm => 'Terim Ekle';
  @override
  String get editTerm => 'Terimi Düzenle';
  @override
  String get term => 'Terim';
  @override
  String get termHint => 'ör. marka adı, uzmanlık terimi';
  @override
  String get definition => 'Tanım (İsteğe Bağlı)';
  @override
  String get definitionHint => 'Çevirmen için bağlam';
  @override
  String get doNotTranslateLabel => 'Çevirme';
  @override
  String get doNotTranslateDesc => 'Terimi hedefte olduğu gibi tut';
  @override
  String get preferredTranslation => 'Tercih Edilen Çeviri';
  @override
  String get caseSensitive => 'Büyük/Küçük Harfe Duyarlı';
}

// Path: projects.conflicts
class _TranslationsProjectsConflictsTr extends TranslationsProjectsConflictsEn {
  _TranslationsProjectsConflictsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String missingApiKeyTitle({required Object service}) =>
      '${service} için API anahtarı eksik';
  @override
  String missingApiKeyMessage({required Object service}) =>
      'Bu proje ${service} kullanıyor ancak yapılandırılmış bir API anahtarı yok. API anahtarınızı Ayarlar > Yapay Zeka Hizmetleri bölümüne ekleyin, aksi takdirde uygulama küresel varsayılanı kullanacaktır.';
  @override
  String get dismiss => 'Kapat';
}

// Path: projects.tm
class _TranslationsProjectsTmTr extends TranslationsProjectsTmEn {
  _TranslationsProjectsTmTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Çeviri Bellekleri';
  @override
  String get description =>
      'Bu proje için çeviri belleği kaynaklarını yönetin.';
  @override
  String get globalTm => 'Küresel Çeviri Belleği';
  @override
  String get globalTmDescription =>
      'Uygulama ayarlarınızdan paylaşılan çeviri belleğini kullanın';
  @override
  String get linkedFiles => 'Bağlı Dosyalar (Projeye Özel)';
  @override
  String get noLinkedFiles => 'Projeye özel dosya bağlanmadı.';
  @override
  String get addTmFile => 'ÇB Dosyası Ekle';
  @override
  String get useGlobalTm => 'Küresel ÇB Kullan';
  @override
  String get selectTm => 'Çeviri Belleği Seç';
  @override
  String get globalTmEnabled => 'Küresel Çeviri Belleği etkinleştirildi';
}

// Path: git.conflicts
class _TranslationsGitConflictsTr extends TranslationsGitConflictsEn {
  _TranslationsGitConflictsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Birleştirme Çakışmaları Algılandı';
  @override
  String get description => 'Devam etmeden önce bu çakışmaları çözmelisiniz.';
  @override
  String get abortMergeTitle => 'Birleştirme İptal Edilsin mi?';
  @override
  String get abortMergeContent =>
      'Bu, tüm birleştirme değişikliklerini geri alacak ve birleştirme öncesi duruma dönecektir. Bu işlem geri alınamaz.';
  @override
  String get abortMergeAction => 'Birleştirmeyi İptal Et';
  @override
  String stagingFile({required Object file}) =>
      '${file} işleme için hazırlanıyor...';
  @override
  String conflictedFilesCount({required Object count}) =>
      'Çakışan Dosyalar (${count})';
  @override
  String get selectFileToResolve => 'Çözmek için bir dosya seçin';
  @override
  String resolvingFile({required Object file}) => 'Çözülüyor: ${file}';
  @override
  String get keepAllOurs => 'Tüm Bizimkileri Tut';
  @override
  String get acceptAllTheirs => 'Tüm Onlarınkini Kabul Et';
  @override
  String get allResolved => 'Bu dosyadaki tüm çakışmalar çözüldü!';
  @override
  String get markResolved => 'Çözüldü Olarak İşaretle';
  @override
  String get stageForCommit => 'Bu, dosyayı işleme için hazırlayacaktır.';
  @override
  String conflictIndex({required Object index}) => 'Çakışma #${index}';
  @override
  String get ours => 'BİZİMKİ (Mevcut)';
  @override
  String get theirs => 'ONLARINKİ (Gelen)';
  @override
  String get keepOurs => 'Bizimkini Tut';
  @override
  String get acceptTheirs => 'Onlarınkini Kabul Et';
  @override
  String get empty => '(Boş)';
}

// Path: wizards.firstRun
class _TranslationsWizardsFirstRunTr extends TranslationsWizardsFirstRunEn {
  _TranslationsWizardsFirstRunTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get welcome => 'Localizer\'a Hoş Geldiniz';
  @override
  String get description =>
      'Yerelleştirme dosyalarınızı saniyeler içinde karşılaştırın.';
  @override
  String get sourceFile => 'Kaynak Dosya';
  @override
  String get targetFile => 'Hedef Dosya';
  @override
  String get compareNow => 'Şimdi Karşılaştır';
  @override
  String get trySample => 'Örnek Veri ile Dene';
  @override
  String get skip => 'Kurulumu Atla';
  @override
  String get browse => 'Gözat';
  @override
  String error({required Object error}) => 'Örnek veri yüklenemedi: ${error}';
}

// Path: dialogs.addIgnorePattern
class _TranslationsDialogsAddIgnorePatternTr
    extends TranslationsDialogsAddIgnorePatternEn {
  _TranslationsDialogsAddIgnorePatternTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Yoksayma Deseni Ekle';
  @override
  String get patternLabel => 'Desen (regex)';
  @override
  String get hint => 'örn. ^temp_.*';
  @override
  String get invalid => 'Geçersiz regex deseni';
  @override
  String get testStringLabel => 'Test Dizisi';
  @override
  String get testHint => 'Desenle test edilecek bir anahtar girin';
  @override
  String get match => '✓ Desen test dizisiyle eşleşiyor';
  @override
  String get noMatch => '✗ Desen eşleşmiyor';
  @override
  String get add => 'Ekle';
  @override
  String get cancel => 'İptal';
}

// Path: dialogs.diffViewer
class _TranslationsDialogsDiffViewerTr extends TranslationsDialogsDiffViewerEn {
  _TranslationsDialogsDiffViewerTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Fark Görüntüleyici';
  @override
  String get originalFile => 'Orijinal/Referans dosya';
  @override
  String get translationFile => 'Çeviri/Karşılaştırma dosyası';
  @override
  String get base => 'TEMEL';
  @override
  String get target => 'HEDEF';
  @override
  String get added => 'Eklendi';
  @override
  String get removed => 'Kaldırıldı';
  @override
  String get modified => 'Değiştirildi';
  @override
  String get noMatches => 'Geçerli filtrelerle eşleşen kayıt yok';
  @override
  String get clickToggle =>
      'Filtreleri değiştirmek için yukarıdaki rozetlere tıklayın';
  @override
  String get clickToHide => '(gizlemek için tıkla)';
  @override
  String get clickToShow => '(göstermek için tıkla)';
}

// Path: grid.columns
class _TranslationsGridColumnsTr extends TranslationsGridColumnsEn {
  _TranslationsGridColumnsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'ANAHTAR';
  @override
  String get source => 'KAYNAK';
  @override
  String get actions => 'İŞLEMLER';
  @override
  String get status => '#';
}

// Path: tutorial.steps
class _TranslationsTutorialStepsTr extends TranslationsTutorialStepsEn {
  _TranslationsTutorialStepsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTutorialStepsImportSourceTr importSource =
      _TranslationsTutorialStepsImportSourceTr._(_root);
  @override
  late final _TranslationsTutorialStepsImportTargetTr importTarget =
      _TranslationsTutorialStepsImportTargetTr._(_root);
  @override
  late final _TranslationsTutorialStepsCompareTr compare =
      _TranslationsTutorialStepsCompareTr._(_root);
  @override
  late final _TranslationsTutorialStepsFilterTr filter =
      _TranslationsTutorialStepsFilterTr._(_root);
  @override
  late final _TranslationsTutorialStepsSearchTr search =
      _TranslationsTutorialStepsSearchTr._(_root);
  @override
  late final _TranslationsTutorialStepsAdvancedTr advanced =
      _TranslationsTutorialStepsAdvancedTr._(_root);
  @override
  late final _TranslationsTutorialStepsExportTr export =
      _TranslationsTutorialStepsExportTr._(_root);
}

// Path: friendlyErrors.fileNotFound
class _TranslationsFriendlyErrorsFileNotFoundTr
    extends TranslationsFriendlyErrorsFileNotFoundEn {
  _TranslationsFriendlyErrorsFileNotFoundTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Dosya veya klasör bulunamadı.';
  @override
  String get suggestion =>
      'Dosyanın taşınmış veya silinmiş olup olmadığını kontrol edin.';
}

// Path: friendlyErrors.accessDenied
class _TranslationsFriendlyErrorsAccessDeniedTr
    extends TranslationsFriendlyErrorsAccessDeniedEn {
  _TranslationsFriendlyErrorsAccessDeniedTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Dosyaya erişim reddedildi.';
  @override
  String get suggestion =>
      'Uygulamayı yönetici olarak çalıştırmayı veya dosya izinlerini kontrol etmeyi deneyin.';
}

// Path: friendlyErrors.isDirectory
class _TranslationsFriendlyErrorsIsDirectoryTr
    extends TranslationsFriendlyErrorsIsDirectoryEn {
  _TranslationsFriendlyErrorsIsDirectoryTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Dosya yerine bir klasör seçildi.';
  @override
  String get suggestion => 'Lütfen geçerli bir dosya seçin.';
}

// Path: friendlyErrors.fileAccess
class _TranslationsFriendlyErrorsFileAccessTr
    extends TranslationsFriendlyErrorsFileAccessEn {
  _TranslationsFriendlyErrorsFileAccessTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Dosyaya erişimde bir sorun oluştu.';
  @override
  String get suggestion =>
      'Dosyayı kullanıyor olabilecek diğer programları kapatmayı deneyin.';
}

// Path: friendlyErrors.unsupportedFormat
class _TranslationsFriendlyErrorsUnsupportedFormatTr
    extends TranslationsFriendlyErrorsUnsupportedFormatEn {
  _TranslationsFriendlyErrorsUnsupportedFormatTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Bu dosya formatı veya işlem desteklenmiyor.';
  @override
  String get suggestion =>
      'Dosya uzantısını kontrol edin veya farklı bir format deneyin.';
}

// Path: friendlyErrors.networkError
class _TranslationsFriendlyErrorsNetworkErrorTr
    extends TranslationsFriendlyErrorsNetworkErrorEn {
  _TranslationsFriendlyErrorsNetworkErrorTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Sunucuya bağlanılamadı.';
  @override
  String get suggestion =>
      'İnternet bağlantınızı kontrol edin ve tekrar deneyin.';
}

// Path: friendlyErrors.notGitRepo
class _TranslationsFriendlyErrorsNotGitRepoTr
    extends TranslationsFriendlyErrorsNotGitRepoEn {
  _TranslationsFriendlyErrorsNotGitRepoTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Bu klasör bir Git projesi değil.';
  @override
  String get suggestion => '.git dizini içeren bir klasöre gidin.';
}

// Path: friendlyErrors.mergeConflict
class _TranslationsFriendlyErrorsMergeConflictTr
    extends TranslationsFriendlyErrorsMergeConflictEn {
  _TranslationsFriendlyErrorsMergeConflictTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Depoda birleştirme çakışmaları var.';
  @override
  String get suggestion => 'Devam etmeden önce çakışmaları çözün.';
}

// Path: friendlyErrors.gitAuthFailed
class _TranslationsFriendlyErrorsGitAuthFailedTr
    extends TranslationsFriendlyErrorsGitAuthFailedEn {
  _TranslationsFriendlyErrorsGitAuthFailedTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Git kimlik doğrulaması başarısız oldu.';
  @override
  String get suggestion =>
      'Ayarlar > Sürüm Kontrolü\'nde kimlik bilgilerinizi kontrol edin.';
}

// Path: friendlyErrors.gitOperationFailed
class _TranslationsFriendlyErrorsGitOperationFailedTr
    extends TranslationsFriendlyErrorsGitOperationFailedEn {
  _TranslationsFriendlyErrorsGitOperationFailedTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Bir Git işlemi başarısız oldu.';
  @override
  String get suggestion =>
      'Daha fazla ayrıntı için Git görünümünü kontrol edin.';
}

// Path: friendlyErrors.invalidJson
class _TranslationsFriendlyErrorsInvalidJsonTr
    extends TranslationsFriendlyErrorsInvalidJsonEn {
  _TranslationsFriendlyErrorsInvalidJsonTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Dosya formatı geçersiz veya bozuk.';
  @override
  String get suggestion =>
      'Dosyanın geçerli JSON içeriği içerdiğinden emin olun.';
}

// Path: friendlyErrors.rateLimitReached
class _TranslationsFriendlyErrorsRateLimitReachedTr
    extends TranslationsFriendlyErrorsRateLimitReachedEn {
  _TranslationsFriendlyErrorsRateLimitReachedTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Çeviri limiti aşıldı.';
  @override
  String get suggestion =>
      'Birkaç dakika bekleyin veya API plan limitinizi kontrol edin.';
}

// Path: friendlyErrors.invalidApiKey
class _TranslationsFriendlyErrorsInvalidApiKeyTr
    extends TranslationsFriendlyErrorsInvalidApiKeyEn {
  _TranslationsFriendlyErrorsInvalidApiKeyTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Geçersiz API anahtarı.';
  @override
  String get suggestion =>
      'API anahtarınızı güncellemek için Ayarlar > Yapay Zeka Çevirisi\'ne gidin.';
}

// Path: friendlyErrors.translationServiceError
class _TranslationsFriendlyErrorsTranslationServiceErrorTr
    extends TranslationsFriendlyErrorsTranslationServiceErrorEn {
  _TranslationsFriendlyErrorsTranslationServiceErrorTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Çeviri servisi hatası.';
  @override
  String get suggestion =>
      'API anahtarınızı ve internet bağlantınızı kontrol edin.';
}

// Path: friendlyErrors.outOfMemory
class _TranslationsFriendlyErrorsOutOfMemoryTr
    extends TranslationsFriendlyErrorsOutOfMemoryEn {
  _TranslationsFriendlyErrorsOutOfMemoryTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Bu işlemi tamamlamak için yeterli bellek yok.';
  @override
  String get suggestion =>
      'Diğer uygulamaları kapatmayı veya daha küçük dosyalar kullanmayı deneyin.';
}

// Path: friendlyErrors.genericError
class _TranslationsFriendlyErrorsGenericErrorTr
    extends TranslationsFriendlyErrorsGenericErrorEn {
  _TranslationsFriendlyErrorsGenericErrorTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Bir şeyler yanlış gitti.';
  @override
  String get suggestion =>
      'Lütfen tekrar deneyin. Sorun devam ederse uygulamayı yeniden başlatın.';
}

// Path: settings.appearance.presets
class _TranslationsSettingsAppearancePresetsTr
    extends TranslationsSettingsAppearancePresetsEn {
  _TranslationsSettingsAppearancePresetsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get presetDefault => 'Varsayılan';
  @override
  String get presetColorblind => 'Renk Körü Dostu';
  @override
  String get presetHighContrast => 'Yüksek Kontrast';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.appearance.preview
class _TranslationsSettingsAppearancePreviewTr
    extends TranslationsSettingsAppearancePreviewEn {
  _TranslationsSettingsAppearancePreviewTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get step3Title => 'egitim.adim3.baslik';
  @override
  String get connectAccount => '"Hesabınızı Bağlayın"';
  @override
  String get loginHint => 'eski.giris_ipucu_v1';
  @override
  String get enterCredentials => '"Kimlik bilgilerini girin"';
  @override
  String get ctaButton => 'odeme.eylem_dugmesi';
  @override
  String get buyNow => '"Satın Al"';
  @override
  String get completePurchase => '"Satın Almayı Tamamla"';
  @override
  String get appNameKey => 'ortak.uygulama_adi';
  @override
  String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class _TranslationsSettingsComparisonPatternPresetsTr
    extends TranslationsSettingsComparisonPatternPresetsEn {
  _TranslationsSettingsComparisonPatternPresetsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get comments => 'Yorumlar';
  @override
  String get tempKeys => 'Geçici Anahtarlar';
  @override
  String get placeholders => 'Yer Tutucular';
  @override
  String get devOnly => 'Sadece Geliştirici';
}

// Path: settings.comparison.previewMatch
class _TranslationsSettingsComparisonPreviewMatchTr
    extends TranslationsSettingsComparisonPreviewMatchEn {
  _TranslationsSettingsComparisonPreviewMatchTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Eşleşme Önizleme';
  @override
  String get description =>
      'Mevcut ayarlarınızın eşleşme mantığını nasıl etkilediğini test edin.';
  @override
  String get stringA => 'Dize A';
  @override
  String get stringB => 'Dize B';
  @override
  String get enterText => 'Metin girin...';
  @override
  String get similarity => 'Benzerlik';
  @override
  String get identical => 'Aynı';
  @override
  String get identicalDescription =>
      'Dizeler normalleştirmeden sonra tam olarak eşleşiyor.';
  @override
  String get ignored => 'Yoksayıldı';
  @override
  String get ignoredDescription => 'Girdi bir yoksayma deseniyle eşleşiyor.';
  @override
  String get different => 'Farklı';
  @override
  String get differentDescription => 'Bir değer boş.';
  @override
  String get similarModified => 'Benzer / Değiştirilmiş';
  @override
  String similarModifiedDescription({required Object threshold}) =>
      'Eşleşme puanı eşiğin üzerinde (${threshold}%).';
  @override
  String get newDifferent => 'Yeni / Farklı';
  @override
  String newDifferentDescription({required Object threshold}) =>
      'Eşleşme puanı eşiğin altında (${threshold}%).';
}

// Path: settings.comparison.colorPresets
class _TranslationsSettingsComparisonColorPresetsTr
    extends TranslationsSettingsComparisonColorPresetsEn {
  _TranslationsSettingsComparisonColorPresetsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get kDefault => 'Varsayılan';
  @override
  String get colorblindFriendly => 'Renk Körlüğüne Uygun';
  @override
  String get highContrast => 'Yüksek Kontrast';
  @override
  String get nord => 'Nord';
  @override
  String get solarized => 'Solarized';
  @override
  String get monokai => 'Monokai';
  @override
  String get presetDefault => 'Varsayılan';
  @override
  String get presetColorblind => 'Renk Körlüğüne Uygun';
  @override
  String get presetHighContrast => 'Yüksek Kontrast';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.integrations.materials
class _TranslationsSettingsIntegrationsMaterialsTr
    extends TranslationsSettingsIntegrationsMaterialsEn {
  _TranslationsSettingsIntegrationsMaterialsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get sidebar => 'Kenar Çubuğu';
  @override
  String get menu => 'Menü';
  @override
  String get popover => 'Açılır Pencere';
  @override
  String get titlebar => 'Başlık Çubuğu';
  @override
  String get underPageBackground => 'Sayfa Arka Planı';
  @override
  String get contentBackground => 'İçerik';
}

// Path: settings.integrations.fileTypes
class _TranslationsSettingsIntegrationsFileTypesTr
    extends TranslationsSettingsIntegrationsFileTypesEn {
  _TranslationsSettingsIntegrationsFileTypesTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get loc => 'Localizer Proje Dosyası';
  @override
  String get lang => 'Dil Dosyası';
  @override
  String get json => 'JSON Yerelleştirme Dosyası';
  @override
  String get xml => 'XML Yerelleştirme Dosyası';
}

// Path: settings.developer.storageInspectorSection
class _TranslationsSettingsDeveloperStorageInspectorSectionTr
    extends TranslationsSettingsDeveloperStorageInspectorSectionEn {
  _TranslationsSettingsDeveloperStorageInspectorSectionTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'Yenile';
  @override
  String get hiveData => 'Hive Verileri';
  @override
  String get secureStorage => 'Güvenli Depolama';
}

// Path: settings.developer.deviceInfoSection
class _TranslationsSettingsDeveloperDeviceInfoSectionTr
    extends TranslationsSettingsDeveloperDeviceInfoSectionEn {
  _TranslationsSettingsDeveloperDeviceInfoSectionTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'Yenile';
  @override
  String get copy => 'Panoya Kopyala';
  @override
  String get computerName => 'Bilgisayar Adı';
  @override
  String get osVersion => 'İşletim Sistemi Sürümü';
}

// Path: settings.developer.themePlaygroundSection
class _TranslationsSettingsDeveloperThemePlaygroundSectionTr
    extends TranslationsSettingsDeveloperThemePlaygroundSectionEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get colors => 'Renkler';
  @override
  String get typography => 'Tipografi';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteTr
      palette =
      _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteTr._(_root);
}

// Path: settings.developer.localizationInspectorSection
class _TranslationsSettingsDeveloperLocalizationInspectorSectionTr
    extends TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
  _TranslationsSettingsDeveloperLocalizationInspectorSectionTr._(
      TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get showKeys => 'Çeviri Anahtarlarını Göster';
  @override
  String get keysVisible => 'Anahtarlar görünür';
  @override
  String get normalDisplay => 'Normal görünüm';
  @override
  String get note =>
      'Not: Bu özellik uygulama yeniden başlatmayı gerektirebilir.';
}

// Path: settings.developer.featureFlags
class _TranslationsSettingsDeveloperFeatureFlagsTr
    extends TranslationsSettingsDeveloperFeatureFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Deneysel Özellikler';
  @override
  String get description =>
      'Özellik bayraklarını yerel olarak test etmek için değiştirin. Bu geçersiz kılmalar uygulama yeniden başlatıldığında kalıcı olur.';
  @override
  String get subtitle => 'Deneysel özellikleri geçersiz kıl';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsTr flags =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsTr._(_root);
  @override
  String get reset => 'Tüm Bayrakları Sıfırla';
  @override
  String get overrides => 'Yerel Geçersiz Kılmalar';
  @override
  String get defaultVal => 'Varsayılan';
  @override
  String get on => 'AÇIK';
  @override
  String get off => 'KAPALI';
}

// Path: settings.onboarding.steps
class _TranslationsSettingsOnboardingStepsTr
    extends TranslationsSettingsOnboardingStepsEn {
  _TranslationsSettingsOnboardingStepsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsOnboardingStepsImportFilesTr importFiles =
      _TranslationsSettingsOnboardingStepsImportFilesTr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsRunComparisonTr runComparison =
      _TranslationsSettingsOnboardingStepsRunComparisonTr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsReviewMissingTr reviewMissing =
      _TranslationsSettingsOnboardingStepsReviewMissingTr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsUseFiltersTr useFilters =
      _TranslationsSettingsOnboardingStepsUseFiltersTr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsSearchResultsTr searchResults =
      _TranslationsSettingsOnboardingStepsSearchResultsTr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsAdvancedViewTr advancedView =
      _TranslationsSettingsOnboardingStepsAdvancedViewTr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsEditCellTr editCell =
      _TranslationsSettingsOnboardingStepsEditCellTr._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsExportResultsTr exportResults =
      _TranslationsSettingsOnboardingStepsExportResultsTr._(_root);
}

// Path: settings.settingsView.categories
class _TranslationsSettingsSettingsViewCategoriesTr
    extends TranslationsSettingsSettingsViewCategoriesEn {
  _TranslationsSettingsSettingsViewCategoriesTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'Genel Ayarlar';
  @override
  String get comparisonEngine => 'Karşılaştırma Motoru';
  @override
  String get appearance => 'Görünüm';
  @override
  String get fileHandling => 'Dosya İşleme';
  @override
  String get aiServices => 'Yapay Zeka Hizmetleri';
  @override
  String get systemIntegrations => 'Sistem Entegrasyonları';
  @override
  String get projectResources => 'Proje Kaynakları (Sözlük & ÇB)';
  @override
  String get developer => 'Geliştirici Seçenekleri';
  @override
  String get about => 'Hakkında';
}

// Path: settings.settingsView.categoryLabels
class _TranslationsSettingsSettingsViewCategoryLabelsTr
    extends TranslationsSettingsSettingsViewCategoryLabelsEn {
  _TranslationsSettingsSettingsViewCategoryLabelsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'Genel';
  @override
  String get comparisonEngine => 'Karşılaştırma';
  @override
  String get appearance => 'Görünüm';
  @override
  String get fileHandling => 'Dosya İşleme';
  @override
  String get aiServices => 'Yapay Zeka Hizmetleri';
  @override
  String get systemIntegrations => 'Sistem Entegrasyonları';
  @override
  String get projectResources => 'Proje Kaynakları';
  @override
  String get developer => 'Geliştirici Seçenekleri';
  @override
  String get about => 'Hakkında';
}

// Path: advancedDiff.sidebar.actionsSection
class _TranslationsAdvancedDiffSidebarActionsSectionTr
    extends TranslationsAdvancedDiffSidebarActionsSectionEn {
  _TranslationsAdvancedDiffSidebarActionsSectionTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get exportMatches => 'Eşleşmeleri Dışa Aktar';
  @override
  String get preview => 'Önizleme';
  @override
  String get fillFromTmTitle => 'Çeviri Belleğinden Doldurulsun mu?';
  @override
  String get fillFromTmContent =>
      'Bu, Çeviri Belleğindeki eşleşmeleri kullanarak boş hedef değerleri doldurmaya çalışacaktır. Mevcut değerlerin üzerine YAZILMAYACAKTIR.';
  @override
  String get fill => 'Doldur';
  @override
  String get fillFromMemory => 'Bellekten Doldur';
  @override
  String filledFromTm({required Object count}) =>
      '${count} öğe Çeviri Belleğinden dolduruldu.';
}

// Path: advancedDiff.sidebar.aiSection
class _TranslationsAdvancedDiffSidebarAiSectionTr
    extends TranslationsAdvancedDiffSidebarAiSectionEn {
  _TranslationsAdvancedDiffSidebarAiSectionTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get infoCloud =>
      'Kaynaktan gelen boş hedef değerleri çevirmek için bulut çevirisi kullanır.';
  @override
  String get infoAi =>
      'Kaynaktan gelen boş hedef değerleri çevirmek için yapay zeka kullanır.';
  @override
  String get translationSettings => 'Çeviri Ayarları';
  @override
  String get aiSettings => 'Yapay Zeka Ayarları';
  @override
  String get source => 'Kaynak';
  @override
  String get target => 'Hedef';
  @override
  String translatingProgress({required Object percent}) =>
      'Çevriliyor... %${percent}';
  @override
  String get translating => 'Çevriliyor...';
  @override
  String get translateAllMissing => 'Tüm Eksikleri Çevir';
  @override
  String get translateAllTitle => 'Tüm Eksikler Çevrilsin mi?';
  @override
  String translateAllContent(
          {required Object source,
          required Object target,
          required Object service}) =>
      'Bu işlem, boş hedef değerlere sahip tüm girdileri ${source} dilinden ${target} diline çevirmek için ${service} kullanacaktır.\n\nHer öneriyi inceleyebilir veya hepsini aynı anda uygulayabilirsiniz.';
  @override
  String get translateAll => 'Tümünü Çevir';
  @override
  String get reviewEach => 'Her Birini İncele';
  @override
  String cloudTranslated({required Object count}) =>
      '${count} girdi bulut çevirisi ile çevrildi.';
  @override
  String aiTranslated({required Object count}) =>
      '${count} girdi yapay zeka ile çevrildi.';
  @override
  String get aiTranslateFailed => 'Yapay zeka toplu çevirisi başarısız oldu';
  @override
  String get noMissingEntries => 'Çevrilecek eksik girdi yok.';
  @override
  String get skip => 'Atla';
  @override
  String get stop => 'Durdur';
  @override
  String cloudApplied({required Object count}) => '${count} öneri uygulandı.';
  @override
  String aiApplied({required Object count}) =>
      '${count} yapay zeka önerisi uygulandı.';
}

// Path: advancedDiff.sidebar.tmSection
class _TranslationsAdvancedDiffSidebarTmSectionTr
    extends TranslationsAdvancedDiffSidebarTmSectionEn {
  _TranslationsAdvancedDiffSidebarTmSectionTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get enableTmFill => 'TM Doldurma Etkinleştir';
  @override
  String get autoApplyAboveMinimum => 'Minimum üstünde otomatik uygula';
  @override
  String get matchSettings => 'Eşleşme Ayarları';
  @override
  String get minMatch => 'Min eşleşme:';
  @override
  String get limit => 'Limit:';
  @override
  String get exact => 'Tam Eşleşme';
}

// Path: advancedDiff.sidebar.filtersSection
class _TranslationsAdvancedDiffSidebarFiltersSectionTr
    extends TranslationsAdvancedDiffSidebarFiltersSectionEn {
  _TranslationsAdvancedDiffSidebarFiltersSectionTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get viewFilters => 'Görünüm Filtreleri';
  @override
  String get showAll => 'Tümünü Göster';
  @override
  String get added => 'Eklenen';
  @override
  String get removed => 'Silinen';
  @override
  String get modified => 'Değiştirilen';
  @override
  String get actionScope => 'Eylem Kapsamı';
  @override
  String get applyToAdded => 'Eklenenlere Uygula';
  @override
  String get applyToModified => 'Değiştirilenlere Uygula';
  @override
  String get onlyFillEmptyTargets => 'Yalnızca boş hedefleri doldur';
  @override
  String get limitToVisible => 'Görünene sınırla';
  @override
  String get editMode => 'Düzenleme Modu';
  @override
  String get dialog => 'Diyalog';
  @override
  String get inline => 'Satır İçi';
}

// Path: advancedDiff.sidebar.similaritySection
class _TranslationsAdvancedDiffSidebarSimilaritySectionTr
    extends TranslationsAdvancedDiffSidebarSimilaritySectionEn {
  _TranslationsAdvancedDiffSidebarSimilaritySectionTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get currentFilter => 'Geçerli Filtre:';
  @override
  String get any => 'HERHANGİ';
  @override
  String get high => 'YÜKSEK';
  @override
  String get medium => 'ORTA';
  @override
  String get low => 'DÜŞÜK';
}

// Path: advancedDiff.sidebar.statusSection
class _TranslationsAdvancedDiffSidebarStatusSectionTr
    extends TranslationsAdvancedDiffSidebarStatusSectionEn {
  _TranslationsAdvancedDiffSidebarStatusSectionTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String total({required Object count}) => '${count} toplam';
  @override
  String extra({required Object count}) => '${count} fazla';
  @override
  String missing({required Object count}) => '${count} eksik';
  @override
  String changed({required Object count}) => '${count} değişti';
}

// Path: tutorial.steps.importSource
class _TranslationsTutorialStepsImportSourceTr
    extends TranslationsTutorialStepsImportSourceEn {
  _TranslationsTutorialStepsImportSourceTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '1. Kaynak Dosyayı İçe Aktar';
  @override
  String get description =>
      'Dosya seçmek için aşağıdaki düğmeyi kullanın veya vurgulanan alana sürükleyip bırakın.';
}

// Path: tutorial.steps.importTarget
class _TranslationsTutorialStepsImportTargetTr
    extends TranslationsTutorialStepsImportTargetEn {
  _TranslationsTutorialStepsImportTargetTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '2. Hedef Dosyayı İçe Aktar';
  @override
  String get description =>
      'Dosya seçmek için aşağıdaki düğmeyi kullanın veya vurgulanan alana sürükleyip bırakın.';
}

// Path: tutorial.steps.compare
class _TranslationsTutorialStepsCompareTr
    extends TranslationsTutorialStepsCompareEn {
  _TranslationsTutorialStepsCompareTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '3. Dosyaları Karşılaştır';
  @override
  String get description =>
      'Karşılaştırmayı çalıştırmak ve sonuçları görmek için aşağıdaki düğmeye dokunun.';
}

// Path: tutorial.steps.filter
class _TranslationsTutorialStepsFilterTr
    extends TranslationsTutorialStepsFilterEn {
  _TranslationsTutorialStepsFilterTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '4. Sonuçları Filtrele';
  @override
  String get description =>
      'Eklenen, Kaldırılan veya Değiştirilen dizileri görüntülemek için bu filtreleri kullanın.';
}

// Path: tutorial.steps.search
class _TranslationsTutorialStepsSearchTr
    extends TranslationsTutorialStepsSearchEn {
  _TranslationsTutorialStepsSearchTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '5. Sonuçlarda Ara';
  @override
  String get description =>
      'Arama çubuğunu kullanarak belirli anahtarları veya değerleri bulun.';
}

// Path: tutorial.steps.advanced
class _TranslationsTutorialStepsAdvancedTr
    extends TranslationsTutorialStepsAdvancedEn {
  _TranslationsTutorialStepsAdvancedTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '6. Gelişmiş Görünüm';
  @override
  String get description =>
      'Düzenleme, yapay zeka çevirisi ve daha fazlası ile ayrıntılı fark görünümünü açın.';
}

// Path: tutorial.steps.export
class _TranslationsTutorialStepsExportTr
    extends TranslationsTutorialStepsExportEn {
  _TranslationsTutorialStepsExportTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => '7. Sonuçları Dışa Aktar';
  @override
  String get description =>
      'Karşılaştırmanızı CSV, JSON veya Excel dosyası olarak kaydedin.';
}

// Path: settings.developer.themePlaygroundSection.palette
class _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteTr
    extends TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteTr._(
      TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get primary => 'Birincil';
  @override
  String get onPrimary => 'Birincil Üzeri';
  @override
  String get secondary => 'İkincil';
  @override
  String get onSecondary => 'İkincil Üzeri';
  @override
  String get surface => 'Yüzey';
  @override
  String get onSurface => 'Yüzey Üzeri';
  @override
  String get error => 'Hata';
  @override
  String get onError => 'Hata Üzeri';
  @override
  String get outline => 'Dış Hat';
  @override
  String get shadow => 'Gölge';
  @override
  String get success => 'Başarılı';
  @override
  String get warning => 'Uyarı';
  @override
  String get info => 'Bilgi';
}

// Path: settings.developer.featureFlags.flags
class _TranslationsSettingsDeveloperFeatureFlagsFlagsTr
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchTr
      experimental_ai_batch =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchTr._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmTr
      new_diff_algorithm =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmTr._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchTr
      enhanced_search =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchTr._(_root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveTr
      auto_save =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveTr._(_root);
}

// Path: settings.onboarding.steps.importFiles
class _TranslationsSettingsOnboardingStepsImportFilesTr
    extends TranslationsSettingsOnboardingStepsImportFilesEn {
  _TranslationsSettingsOnboardingStepsImportFilesTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Dosyaları İçe Aktar';
  @override
  String get description => 'Kaynak ve hedef dosyaları yükle';
}

// Path: settings.onboarding.steps.runComparison
class _TranslationsSettingsOnboardingStepsRunComparisonTr
    extends TranslationsSettingsOnboardingStepsRunComparisonEn {
  _TranslationsSettingsOnboardingStepsRunComparisonTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Karşılaştırmayı Çalıştır';
  @override
  String get description => '"Dosyaları Karşılaştır"a tıkla';
}

// Path: settings.onboarding.steps.reviewMissing
class _TranslationsSettingsOnboardingStepsReviewMissingTr
    extends TranslationsSettingsOnboardingStepsReviewMissingEn {
  _TranslationsSettingsOnboardingStepsReviewMissingTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Eksik Anahtarları İncele';
  @override
  String get description => 'Kırmızı EKSİK öğeleri fark et';
}

// Path: settings.onboarding.steps.useFilters
class _TranslationsSettingsOnboardingStepsUseFiltersTr
    extends TranslationsSettingsOnboardingStepsUseFiltersEn {
  _TranslationsSettingsOnboardingStepsUseFiltersTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Filtreleri Kullan';
  @override
  String get description => 'Türe göre filtrele';
}

// Path: settings.onboarding.steps.searchResults
class _TranslationsSettingsOnboardingStepsSearchResultsTr
    extends TranslationsSettingsOnboardingStepsSearchResultsEn {
  _TranslationsSettingsOnboardingStepsSearchResultsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Arama Sonuçları';
  @override
  String get description => 'Belirli anahtarları bul';
}

// Path: settings.onboarding.steps.advancedView
class _TranslationsSettingsOnboardingStepsAdvancedViewTr
    extends TranslationsSettingsOnboardingStepsAdvancedViewEn {
  _TranslationsSettingsOnboardingStepsAdvancedViewTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Gelişmiş Görünüm';
  @override
  String get description => 'Ayrıntılı analizi keşfet';
}

// Path: settings.onboarding.steps.editCell
class _TranslationsSettingsOnboardingStepsEditCellTr
    extends TranslationsSettingsOnboardingStepsEditCellEn {
  _TranslationsSettingsOnboardingStepsEditCellTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Bir Hücreyi Düzenle';
  @override
  String get description => 'Bir değeri düzenlemek için tıkla';
}

// Path: settings.onboarding.steps.exportResults
class _TranslationsSettingsOnboardingStepsExportResultsTr
    extends TranslationsSettingsOnboardingStepsExportResultsEn {
  _TranslationsSettingsOnboardingStepsExportResultsTr._(TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Dışa Aktar';
  @override
  String get description => 'Raporunu kaydet';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchTr
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchTr._(
      TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Deneysel Yapay Zeka Toplu İşlemi';
  @override
  String get description =>
      'Birden fazla satır için toplu yapay zeka çevirisini etkinleştir';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmTr
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmTr._(
      TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Yeni Fark Algoritması';
  @override
  String get description =>
      'Karşılaştırmalar için geliştirilmiş fark algoritmasını kullan';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchTr
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchTr._(
      TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Gelişmiş Arama';
  @override
  String get description => 'Çeviri dosyalarında bulanık aramayı etkinleştir';
}

// Path: settings.developer.featureFlags.flags.auto_save
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveTr
    extends TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveTr._(
      TranslationsTr root)
      : this._root = root,
        super.internal(root);

  final TranslationsTr _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Otomatik Kaydet';
  @override
  String get description =>
      'Düzenlemelerden sonra değişiklikleri otomatik kaydet';
}

/// The flat map containing all translations for locale <tr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsTr {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
          'app.title' => 'Yerelleştirme Karşılaştırma Aracı',
          'app.name' => 'Localizer',
          'common.save' => 'Kaydet',
          'common.cancel' => 'İptal',
          'common.close' => 'Kapat',
          'common.delete' => 'Sil',
          'common.edit' => 'Düzenle',
          'common.add' => 'Ekle',
          'common.search' => 'Ara',
          'common.undo' => 'Geri Al',
          'common.loading' => 'Yükleniyor...',
          'common.error' => 'Hata',
          'common.success' => 'Başarılı',
          'common.warning' => 'Uyarı',
          'common.info' => 'Bilgi',
          'common.confirm' => 'Onayla',
          'common.yes' => 'Evet',
          'common.no' => 'Hayır',
          'common.ok' => 'Tamam',
          'common.retry' => 'Tekrar Dene',
          'common.copyText' => 'Kopyala',
          'common.appName' => 'Localizer',
          'common.copied' => 'Kopyalandı!',
          'common.enabled' => 'Etkin',
          'common.disabled' => 'Devre Dışı',
          'common.browse' => 'Gözat',
          'common.clear' => 'Temizle',
          'common.apply' => 'Uygula',
          'common.reset' => 'Sıfırla',
          'common.refresh' => 'Yenile',
          'common.export' => 'Dışa Aktar',
          'common.import' => 'İçe Aktar',
          'common.select' => 'Seç',
          'common.selectAll' => 'Tümünü Seç',
          'common.deselectAll' => 'Seçimi Kaldır',
          'common.noResults' => 'Sonuç bulunamadı',
          'common.emptyState' => 'Henüz bir şey yok',
          'common.open' => 'Aç',
          'common.change' => 'Değiştir',
          'common.original' => 'Orijinal',
          'common.kNew' => 'Yeni',
          'common.remove' => 'Kaldır',
          'common.auto' => 'Otomatik',
          'common.execute' => 'Çalıştır',
          'common.run' => 'Çalıştır',
          'common.unknown' => 'Bilinmeyen',
          'common.download' => 'İndir',
          'common.dropdownArrow' => 'Açılır menü oku',
          'common.openInNewWindow' => 'Yeni pencerede açar',
          'common.resetToDefaults' => 'Varsayılanlara sıfırla',
          'menu.file' => 'Dosya',
          'menu.edit' => 'Düzenle',
          'menu.view' => 'Görünüm',
          'menu.help' => 'Yardım',
          'menu.openFiles' => 'Dosyaları Aç...',
          'menu.openFolder' => 'Klasör Aç...',
          'menu.exportResults' => 'Sonuçları Dışa Aktar...',
          'menu.undo' => 'Geri Al',
          'menu.redo' => 'Yinele',
          'menu.cut' => 'Kes',
          'menu.paste' => 'Yapıştır',
          'menu.selectAll' => 'Tümünü Seç',
          'menu.zoomIn' => 'Yakınlaştır',
          'menu.zoomOut' => 'Uzaklaştır',
          'menu.resetZoom' => 'Yakınlaştırmayı Sıfırla',
          'menu.documentation' => 'Belgeler',
          'menu.reportIssue' => 'Sorun Bildir',
          'menu.about' => ({required Object appName}) => '${appName} Hakkında',
          'nav.compare' => 'Karşılaştır',
          'nav.history' => 'Geçmiş',
          'nav.settings' => 'Ayarlar',
          'nav.projects' => 'Projeler',
          'nav.dashboard' => 'Pano',
          'nav.directory' => 'Dizin',
          'nav.repository' => 'Repo',
          'nav.tooltipCompare' => 'Yerelleştirme dosyalarını karşılaştır',
          'nav.tooltipHistory' => 'Karşılaştırma geçmişini görüntüle',
          'nav.tooltipSettings' => 'Uygulama ayarları',
          'nav.tooltipProjects' => 'Projeleri yönet',
          'nav.tooltipThemeToggle' => 'Temayı Değiştir',
          'nav.tooltipDebugConsole' => 'Hata Ayıklama Konsolu',
          'settings.title' => 'Ayarlar',
          'settings.appSettings' => 'Uygulama Ayarları',
          'settings.projectSettings' => 'Proje Ayarları',
          'settings.appearance.title' => 'Görünüm',
          'settings.appearance.description' =>
            'Uygulamanın görünümünü özelleştirin',
          'settings.appearance.theme' => 'Tema Modu',
          'settings.appearance.themeDescription' =>
            'Açık, koyu veya sistem teması arasında seçim yapın',
          'settings.appearance.themeSystem' => 'Sistem',
          'settings.appearance.themeLight' => 'Açık',
          'settings.appearance.themeDark' => 'Koyu',
          'settings.appearance.themeAmoled' => 'AMOLED',
          'settings.appearance.accentColor' => 'Vurgu Rengi',
          'settings.appearance.accentColorDescription' =>
            'Tercih ettiğiniz vurgu rengini seçin',
          'settings.appearance.useMicaEffect' => 'Mica Efektini Kullan',
          'settings.appearance.micaDescription' =>
            'Modern bir görünüm için Windows 11 Mica şeffaflık efektini etkinleştirin',
          'settings.appearance.diffFontSize' => 'Fark Yazı Tipi Boyutu',
          'settings.appearance.diffFontSizeDescription' =>
            'Karşılaştırma görünümünün yazı tipi boyutunu ayarlayın',
          'settings.appearance.diffFontFamily' => 'Fark Yazı Tipi Ailesi',
          'settings.appearance.diffFontFamilyDescription' =>
            'Karşılaştırma görünümü için yazı tipi',
          'settings.appearance.systemDefault' => 'Sistem Varsayılanı',
          'settings.appearance.pickAccentColor' => 'Vurgu Rengi Seç',
          'settings.appearance.diffColors' => 'Fark Renkleri',
          'settings.appearance.presetsTitle' => 'Hazır Ayarlar',
          'settings.appearance.presets.presetDefault' => 'Varsayılan',
          'settings.appearance.presets.presetColorblind' => 'Renk Körü Dostu',
          'settings.appearance.presets.presetHighContrast' => 'Yüksek Kontrast',
          'settings.appearance.presets.presetNord' => 'Nord',
          'settings.appearance.presets.presetSolarized' => 'Solarized',
          'settings.appearance.presets.presetMonokai' => 'Monokai',
          'settings.appearance.identical' => 'Aynı',
          'settings.appearance.pickColorFor' => ({required Object label}) =>
              '${label} için Renk Seç',
          'settings.appearance.livePreview' => 'Canlı Önizleme',
          'settings.appearance.preview.step3Title' => 'egitim.adim3.baslik',
          'settings.appearance.preview.connectAccount' =>
            '"Hesabınızı Bağlayın"',
          'settings.appearance.preview.loginHint' => 'eski.giris_ipucu_v1',
          'settings.appearance.preview.enterCredentials' =>
            '"Kimlik bilgilerini girin"',
          'settings.appearance.preview.ctaButton' => 'odeme.eylem_dugmesi',
          'settings.appearance.preview.buyNow' => '"Satın Al"',
          'settings.appearance.preview.completePurchase' =>
            '"Satın Almayı Tamamla"',
          'settings.appearance.preview.appNameKey' => 'ortak.uygulama_adi',
          'settings.appearance.preview.appNameValue' => '"Localizer"',
          'settings.general.title' => 'Genel',
          'settings.general.description' => 'Genel uygulama ayarları',
          'settings.general.language' => 'Dil',
          'settings.general.languageDescription' =>
            'Tercih ettiğiniz dili seçin',
          'settings.general.startMinimized' =>
            'Simge Durumunda Küçültülmüş Başlat',
          'settings.general.startMinimizedDescription' =>
            'Uygulamayı sistem tepsisinde simge durumunda başlat',
          'settings.general.rememberWindowPosition' =>
            'Pencere Konumunu Hatırla',
          'settings.general.rememberWindowPositionDescription' =>
            'Başlangıçta pencere boyutunu ve konumunu geri yükle',
          'settings.general.openLastProject' => 'Başlangıçta Son Projeyi Aç',
          'settings.general.openLastProjectDescription' =>
            'Uygulama başladığında son kullanılan projeyi otomatik olarak aç',
          'settings.general.application' => 'Uygulama',
          'settings.general.defaultView' => 'Varsayılan Görünüm',
          'settings.general.defaultViewDescription' =>
            'Başlangıçta gösterilecek görünüm',
          'settings.general.autoCheckUpdates' =>
            'Güncellemeleri Otomatik Kontrol Et',
          'settings.general.autoCheckUpdatesDescription' =>
            'Başlangıçta güncellemeleri kontrol et',
          'settings.general.startupOptions' => 'Başlangıç Seçenekleri',
          'settings.general.languageAuto' => 'Otomatik Algıla',
          'settings.general.viewBasic' => 'Dosya Karşılaştırma',
          'settings.general.viewHistory' => 'Geçmiş',
          'settings.general.viewDashboard' => 'Kalite Panosu',
          'settings.general.viewDirectory' => 'Dizin Karşılaştırma',
          'settings.general.viewLastUsed' => 'Son Kullanılan Görünüm',
          'settings.scope.title' => 'Ayarlar Kapsamı',
          'settings.scope.global' => 'Genel Varsayılanlar',
          'settings.scope.project' => 'Proje',
          'settings.scope.reset' => 'Projeyi Genel Varsayılanlara Sıfırla',
          'settings.scope.resetConfirmation' =>
            'Bu işlem bu proje için tüm geçersiz kılmaları temizleyecek. Bu işlem geri alınamaz.',
          'settings.scope.globalDescription' =>
            'Değişiklikler aksi belirtilmedikçe tüm projelere uygulanır.',
          'settings.scope.projectDescription' => ({required Object name}) =>
              'Değişiklikler sadece "${name}" projesine uygulanır. Diğer ayarlar genel varsayılanlardan miras alınır.',
          'settings.scope.createPrompt' => 'Özel ayarlar için proje oluşturun',
          'settings.searchKeywords.general.0' => 'Dil',
          'settings.searchKeywords.general.1' => 'Varsayılan Görünüm',
          'settings.searchKeywords.general.2' => 'Son Dosyalar Sayısı',
          'settings.searchKeywords.general.3' => 'Son Projeyi Aç',
          'settings.searchKeywords.general.4' => 'Çıkışta Onayla',
          'settings.searchKeywords.general.5' => 'Bildirimleri Göster',
          'settings.searchKeywords.comparisonEngine.0' => 'Karşılaştırma Modu',
          'settings.searchKeywords.comparisonEngine.1' => 'Benzerlik Eşiği',
          'settings.searchKeywords.comparisonEngine.2' =>
            'Büyük/Küçük Harf Duyarlı',
          'settings.searchKeywords.comparisonEngine.3' => 'Boşlukları Yoksay',
          'settings.searchKeywords.comparisonEngine.4' =>
            'Boş Satırları Yoksay',
          'settings.searchKeywords.comparisonEngine.5' => 'Yorumları Yoksay',
          'settings.searchKeywords.comparisonEngine.6' => 'Yoksayma Desenleri',
          'settings.searchKeywords.appearance.0' => 'Tema',
          'settings.searchKeywords.appearance.1' => 'Tema Modu',
          'settings.searchKeywords.appearance.2' => 'Vurgu Rengi',
          'settings.searchKeywords.appearance.3' => 'Fark Yazı Tipi Boyutu',
          'settings.searchKeywords.appearance.4' => 'Fark Yazı Tipi Ailesi',
          'settings.searchKeywords.appearance.5' => 'Fark Renkleri',
          'settings.searchKeywords.appearance.6' => 'Eklendi Rengi',
          'settings.searchKeywords.appearance.7' => 'Silindi Rengi',
          'settings.searchKeywords.appearance.8' => 'Değiştirildi Rengi',
          'settings.searchKeywords.appearance.9' => 'Aynı Rengi',
          'settings.searchKeywords.appearance.10' => 'Renk Önayarları',
          'settings.searchKeywords.appearance.11' => 'Önizleme',
          'settings.searchKeywords.fileHandling.0' => 'Kaynak Formatı',
          'settings.searchKeywords.fileHandling.1' => 'Hedef Formatı',
          'settings.searchKeywords.fileHandling.2' => 'Varsayılan Kodlama',
          'settings.searchKeywords.fileHandling.3' => 'Son Proje Sayısı',
          'settings.searchKeywords.fileHandling.4' => 'Çeviri Hafızası',
          'settings.searchKeywords.fileHandling.5' => 'Hafıza İçe Aktar',
          'settings.searchKeywords.fileHandling.6' => 'Hafıza Dışa Aktar',
          'settings.searchKeywords.fileHandling.7' => 'Hafızayı Temizle',
          'settings.searchKeywords.aiServices.0' => 'OpenAI API Anahtarı',
          'settings.searchKeywords.aiServices.1' => 'Anthropic API Anahtarı',
          'settings.searchKeywords.aiServices.2' => 'Google AI API Anahtarı',
          'settings.searchKeywords.aiServices.3' => 'Yapay Zeka Modeli',
          'settings.searchKeywords.aiServices.4' => 'Sıcaklık',
          'settings.searchKeywords.aiServices.5' => 'Özel İstemi',
          'settings.searchKeywords.systemIntegrations.0' => 'Sistem Tepsisi',
          'settings.searchKeywords.systemIntegrations.1' =>
            'Küçültülmüş Başlat',
          'settings.searchKeywords.systemIntegrations.2' =>
            'Dosya İlişkilendirmeleri',
          'settings.searchKeywords.systemIntegrations.3' => 'Mica Efekti',
          'settings.searchKeywords.systemIntegrations.4' => 'Canlılık',
          'settings.searchKeywords.systemIntegrations.5' => 'Pencere Materyali',
          'settings.searchKeywords.systemIntegrations.6' => 'Dock Rozeti',
          'settings.searchKeywords.systemIntegrations.7' =>
            'Çevrilmemiş Sayısı',
          'settings.searchKeywords.projectResources.0' => 'Terimler Sözlüğü',
          'settings.searchKeywords.projectResources.1' => 'Çeviri Hafızası',
          'settings.searchKeywords.projectResources.2' => 'Terminoloji',
          'settings.searchKeywords.about.0' => 'Sürüm',
          'settings.searchKeywords.about.1' => 'Güncellemeleri Kontrol Et',
          'settings.searchKeywords.about.2' => 'Otomatik Güncelleme',
          'settings.searchKeywords.about.3' => 'Değişiklik Günlüğü',
          'settings.searchKeywords.about.4' => 'Lisans',
          'settings.searchKeywords.about.5' => 'Gizlilik Politikası',
          'settings.searchKeywords.about.6' => 'Telemetri',
          'settings.searchKeywords.about.7' => 'Çökme Raporlama',
          'settings.searchKeywords.developer.0' => 'Performans Katmanı',
          'settings.searchKeywords.developer.1' => 'Anlamsal Hata Ayıklayıcı',
          'settings.searchKeywords.developer.2' => 'Materyal Izgarası',
          'settings.searchKeywords.developer.3' => 'Raster Önbelleği',
          'settings.searchKeywords.developer.4' => 'Eğitimi Yeniden Başlat',
          'settings.searchKeywords.developer.5' => 'Fabrika Ayarlarına Sıfırla',
          'settings.comparison.title' => 'Karşılaştırma',
          'settings.comparison.description' =>
            'Karşılaştırma davranışını yapılandırın',
          'settings.comparison.caseSensitive' => 'Büyük/Küçük Harf Duyarlı',
          'settings.comparison.caseSensitiveDescription' =>
            'Büyük ve küçük harfleri farklı olarak değerlendir',
          'settings.comparison.ignoreWhitespace' => 'Boşlukları Yoksay',
          'settings.comparison.ignoreWhitespaceDescription' =>
            'Karşılaştırırken baştaki/sondaki boşlukları yoksay',
          'settings.comparison.showLineNumbers' => 'Satır Numaralarını Göster',
          'settings.comparison.showLineNumbersDescription' =>
            'Fark görünümünde satır numaralarını göster',
          'settings.comparison.behavior' => 'Karşılaştırma Davranışı',
          'settings.comparison.ignoreCase' => 'Büyük/Küçük Harfi Yoksay',
          'settings.comparison.ignoreCaseDescription' =>
            '"Key" ve "key" aynı kabul edilir',
          'settings.comparison.similarityThreshold' => 'Benzerlik Eşiği',
          'settings.comparison.similarityThresholdDescription' =>
            '"Değiştirildi" tespiti için minimum benzerlik',
          'settings.comparison.mode' => 'Karşılaştırma Modu',
          'settings.comparison.modeDescription' =>
            'Dosyalar arasındaki girişlerin nasıl eşleştirileceği',
          'settings.comparison.modeKey' => 'Anahtar tabanlı',
          'settings.comparison.modeKeyDescription' =>
            'Anahtar adına göre eşleştirir (varsayılan).',
          'settings.comparison.modeOrder' => 'Sıra tabanlı',
          'settings.comparison.modeOrderDescription' =>
            'Dosyadaki sıraya göre eşleştirir.',
          'settings.comparison.modeSmart' => 'Akıllı Eşleşme',
          'settings.comparison.modeSmartDescription' =>
            'Taşınan/yeniden adlandırılan anahtarları algılar.',
          'settings.comparison.ignorePatterns' => 'Yoksayma Desenleri',
          'settings.comparison.noIgnorePatterns' =>
            'Yoksayma deseni ayarlanmadı.',
          'settings.comparison.addPattern' => 'Desen Ekle',
          'settings.comparison.resetToGlobal' =>
            'Tüm karşılaştırma ayarlarını küresel varsayılanlara sıfırla',
          'settings.comparison.patternPresets.comments' => 'Yorumlar',
          'settings.comparison.patternPresets.tempKeys' => 'Geçici Anahtarlar',
          'settings.comparison.patternPresets.placeholders' => 'Yer Tutucular',
          'settings.comparison.patternPresets.devOnly' => 'Sadece Geliştirici',
          'settings.comparison.previewMatch.title' => 'Eşleşme Önizleme',
          'settings.comparison.previewMatch.description' =>
            'Mevcut ayarlarınızın eşleşme mantığını nasıl etkilediğini test edin.',
          'settings.comparison.previewMatch.stringA' => 'Dize A',
          'settings.comparison.previewMatch.stringB' => 'Dize B',
          'settings.comparison.previewMatch.enterText' => 'Metin girin...',
          'settings.comparison.previewMatch.similarity' => 'Benzerlik',
          'settings.comparison.previewMatch.identical' => 'Aynı',
          'settings.comparison.previewMatch.identicalDescription' =>
            'Dizeler normalleştirmeden sonra tam olarak eşleşiyor.',
          'settings.comparison.previewMatch.ignored' => 'Yoksayıldı',
          'settings.comparison.previewMatch.ignoredDescription' =>
            'Girdi bir yoksayma deseniyle eşleşiyor.',
          'settings.comparison.previewMatch.different' => 'Farklı',
          'settings.comparison.previewMatch.differentDescription' =>
            'Bir değer boş.',
          'settings.comparison.previewMatch.similarModified' =>
            'Benzer / Değiştirilmiş',
          'settings.comparison.previewMatch.similarModifiedDescription' => (
                  {required Object threshold}) =>
              'Eşleşme puanı eşiğin üzerinde (${threshold}%).',
          'settings.comparison.previewMatch.newDifferent' => 'Yeni / Farklı',
          'settings.comparison.previewMatch.newDifferentDescription' => (
                  {required Object threshold}) =>
              'Eşleşme puanı eşiğin altında (${threshold}%).',
          'settings.comparison.colorPresets.kDefault' => 'Varsayılan',
          'settings.comparison.colorPresets.colorblindFriendly' =>
            'Renk Körlüğüne Uygun',
          'settings.comparison.colorPresets.highContrast' => 'Yüksek Kontrast',
          'settings.comparison.colorPresets.nord' => 'Nord',
          'settings.comparison.colorPresets.solarized' => 'Solarized',
          'settings.comparison.colorPresets.monokai' => 'Monokai',
          'settings.comparison.colorPresets.presetDefault' => 'Varsayılan',
          'settings.comparison.colorPresets.presetColorblind' =>
            'Renk Körlüğüne Uygun',
          'settings.comparison.colorPresets.presetHighContrast' =>
            'Yüksek Kontrast',
          'settings.comparison.colorPresets.presetNord' => 'Nord',
          'settings.comparison.colorPresets.presetSolarized' => 'Solarized',
          'settings.comparison.colorPresets.presetMonokai' => 'Monokai',
          'settings.fileHandling.fileFormats' => 'Dosya Biçimleri',
          'settings.fileHandling.sourceFormat' => 'Kaynak Biçimi',
          'settings.fileHandling.targetFormat' => 'Hedef Biçimi',
          'settings.fileHandling.encoding' => 'Kodlama',
          'settings.fileHandling.sourceEncoding' => 'Kaynak Kodlama',
          'settings.fileHandling.targetEncoding' => 'Hedef Kodlama',
          'settings.fileHandling.autoDetect' => 'Otomatik Algıla',
          'settings.fileHandling.autoDetectEncodingDescription' =>
            'Dosya kodlamasını otomatik algıla',
          'settings.fileHandling.exportSettings' => 'Dışa Aktarma Ayarları',
          'settings.fileHandling.defaultExportFormat' =>
            'Varsayılan Dışa Aktarma Biçimi',
          'settings.fileHandling.includeUtf8Bom' => 'UTF-8 BOM İçer',
          'settings.fileHandling.includeUtf8BomDescription' =>
            'Excel uyumluluğu için gereklidir',
          'settings.fileHandling.openFolderAfterExport' =>
            'Dışa Aktardıktan Sonra Klasörü Aç',
          'settings.fileHandling.fileSafety' => 'Dosya Güvenliği',
          'settings.fileHandling.fileSafetyDescription' =>
            'Felaket kurtarma için otomatik yerel kopyalar.',
          'settings.fileHandling.resetToGlobal' =>
            'Tüm dosya işleme ayarlarını küresel varsayılanlara sıfırla',
          'settings.translationMemory.title' => 'Küresel Çeviri Belleği',
          'settings.translationMemory.autoLearn' => 'Otomatik Öğren',
          'settings.translationMemory.autoLearnDescription' =>
            'Gelecekte tekrar kullanmak için çevirileri yerel belleğe kaydet',
          'settings.translationMemory.confidenceThreshold' => 'Güven Eşiği',
          'settings.translationMemory.confidenceThresholdDescription' => (
                  {required Object percent}) =>
              'Otomatik uygulama için minimum puan (${percent}%)',
          'settings.translationMemory.entries' => 'Girdiler',
          'settings.translationMemory.size' => 'Boyut',
          'settings.translationMemory.memorySize' => ({required Object size}) =>
              'Bellek Boyutu: ${size}',
          'settings.translationMemory.import' => 'İçe Aktar',
          'settings.translationMemory.exportTmx' => 'TMX Dışa Aktar',
          'settings.translationMemory.exportCsv' => 'CSV Dışa Aktar',
          'settings.translationMemory.clearMemory' => 'Belleği Temizle',
          'settings.translationMemory.importedItems' =>
            ({required Object count}) => '${count} öğe belleğe aktarıldı.',
          'settings.translationMemory.noItemsAdded' => 'Hiçbir öğe eklenmedi.',
          'settings.translationMemory.nothingToExport' =>
            'Henüz dışa aktarılacak bir şey yok.',
          'settings.translationMemory.tmxSaved' => 'TMX kaydedildi',
          'settings.translationMemory.csvSaved' => 'CSV kaydedildi',
          'settings.translationMemory.clearConfirmTitle' =>
            'Çeviri belleği temizlensin mi?',
          'settings.translationMemory.clearConfirmContent' =>
            'Bu, bu cihazdaki tüm kayıtlı çeviri çiftlerini kaldırır. Bu işlem geri alınamaz.',
          'settings.translationMemory.cleared' => 'Çeviri belleği temizlendi.',
          'settings.translationMemory.couldNotClear' => 'Bellek temizlenemedi.',
          'settings.backup.title' => 'Otomatik Yedekleme',
          'settings.backup.description' => 'Otomatik yedekleme ayarları',
          'settings.backup.enabled' => 'Otomatik Yedeklemeyi Etkinleştir',
          'settings.backup.enabledDescription' =>
            'Değişiklik yapmadan önce dosyaları otomatik olarak yedekle',
          'settings.backup.maxCopies' => 'Maksimum Yedek Kopya Sayısı',
          'settings.backup.maxCopiesDescription' =>
            'Dosya başına tutulacak yedek kopya sayısı',
          'settings.backup.activeStatus' => ({required Object count}) =>
              'Etkin · ${count} kopya saklanıyor',
          'settings.backup.folder' => 'Yedek Klasörü',
          'settings.backup.folderDescription' =>
            'Aynı klasörü kullanmak için boş bırakın',
          'settings.backup.useOriginalFolder' =>
            'Orijinal dosya klasörünü kullan',
          'settings.ai.title' => 'Yapay Zeka Hizmetleri',
          'settings.ai.description' =>
            'Yapay zeka çeviri ve yardım ayarlarını yapılandırın',
          'settings.ai.provider' => 'Yapay Zeka Sağlayıcısı',
          'settings.ai.providerDescription' =>
            'Tercih ettiğiniz yapay zeka hizmet sağlayıcısını seçin',
          'settings.ai.apiKey' => 'API Anahtarı',
          'settings.ai.apiKeyDescription' =>
            'Seçilen sağlayıcı için API anahtarınızı girin',
          'settings.ai.apiKeyPlaceholder' => 'API anahtarını girin...',
          'settings.ai.testConnection' => 'Bağlantıyı Test Et',
          'settings.ai.connectionSuccess' => 'Bağlantı başarılı!',
          'settings.ai.connectionFailed' =>
            'Bağlantı başarısız. Lütfen API anahtarınızı kontrol edin.',
          'settings.ai.translationStrategy' => 'Çeviri Stratejisi',
          'settings.ai.strategy' => 'Strateji',
          'settings.ai.strategyDescription' =>
            'Dizelerin nasıl çevrileceğini seçin',
          'settings.ai.strategyLLM' => 'Üretken Yapay Zeka (LLM)',
          'settings.ai.strategyCloud' => 'Bulut Çevirisi',
          'settings.ai.enableAiTranslation' =>
            'Yapay Zeka Çevirisini Etkinleştir',
          'settings.ai.enableAiTranslationDescription' =>
            'Uygulamanın çeviri önerileri için yapay zeka kullanmasına izin ver',
          'settings.ai.llmProvider' => 'LLM Hizmet Sağlayıcısı',
          'settings.ai.service' => 'Hizmet',
          'settings.ai.serviceDescription' => 'Üretken Yapay Zeka Sağlayıcısı',
          'settings.ai.providerGemini' => 'Google Gemini',
          'settings.ai.providerOpenAI' => 'OpenAI',
          'settings.ai.geminiApiKey' => 'Gemini API Anahtarı',
          'settings.ai.openAiApiKey' => 'OpenAI API Anahtarı',
          'settings.ai.model' => 'Model',
          'settings.ai.modelDescription' =>
            'Hangi modelin kullanılacağını seçin',
          'settings.ai.advancedParameters' => 'Gelişmiş Parametreler',
          'settings.ai.parameters' => 'Parametreler',
          'settings.ai.parametersDescription' =>
            'Sıcaklık, Bağlam ve daha fazlası',
          'settings.ai.temperature' => 'Sıcaklık',
          'settings.ai.temperatureDescription' =>
            'Yüksek değerler çıktıyı daha yaratıcı yapar',
          'settings.ai.maxTokens' => 'Maksimum Token',
          'settings.ai.maxTokensDescription' =>
            'Bağlam penceresi uzunluğunu sınırla',
          'settings.ai.systemContext' => 'Sistem Bağlamı / Talimatlar',
          'settings.ai.systemContextHint' =>
            'Siz profesyonel bir yerelleştiricisiniz. Kaynak dizenin tonunu ve amacını koruyun...',
          'settings.ai.systemContextHelper' =>
            'Projenizin tarzı ve terminolojisi hakkında yapay zekaya özel talimatlar verin.',
          'settings.ai.contextStrings' => 'Bağlam Dizeleri',
          'settings.ai.contextStringsDescription' =>
            'Daha iyi bağlam için çevreleyen dizeleri ekle',
          'settings.ai.contextCount' => 'Bağlam Sayısı',
          'settings.ai.contextCountDescription' =>
            'Eklenecek çevreleyen dize sayısı',
          'settings.ai.cloudServices' => 'Bulut Çeviri Hizmetleri',
          'settings.ai.googleTranslateApiKey' =>
            'Google Translate API Anahtarı',
          'settings.ai.deeplApiKey' => 'DeepL API Anahtarı',
          'settings.ai.test' => 'Test Et',
          'settings.ai.resetToGlobal' =>
            'Tüm Yapay Zeka ayarlarını küresel varsayılanlara sıfırla',
          'settings.integrations.platformNotice' => 'Platform Bildirimi',
          'settings.integrations.platformNoticeDescription' =>
            'Sistem entegrasyonları bu platformda mevcut değil.',
          'settings.integrations.visualEffects' => 'Görsel Efektler',
          'settings.integrations.explorerIntegration' => 'Gezgin Entegrasyonu',
          'settings.integrations.explorerIntegrationDescription' =>
            'Klasörler için Windows Gezgini sağ tık menüsüne "Localizer ile Aç" seçeneğini ekleyin.',
          'settings.integrations.addToContextMenu' => 'Bağlam Menüsüne Ekle',
          'settings.integrations.contextMenuAdded' => 'Bağlam menüsü eklendi!',
          'settings.integrations.contextMenuAddError' =>
            'Bağlam menüsü eklenemedi',
          'settings.integrations.contextMenuRemoved' =>
            'Bağlam menüsü kaldırıldı!',
          'settings.integrations.contextMenuRemoveError' =>
            'Bağlam menüsü kaldırılamadı',
          'settings.integrations.fileAssociations' =>
            'Dosya İlişkilendirmeleri',
          'settings.integrations.fileAssociationsDescription' =>
            'Dosya türlerini, Gezgin\'de çift tıklandığında Localizer ile açılacak şekilde kaydedin.',
          'settings.integrations.registered' => 'Kayıtlı',
          'settings.integrations.notRegistered' => 'Kayıtlı Değil',
          'settings.integrations.extRegistered' => ({required Object ext}) =>
              '${ext} kaydedildi!',
          'settings.integrations.extUnregistered' => ({required Object ext}) =>
              '${ext} kaydı silindi!',
          'settings.integrations.extError' => (
                  {required Object ext, required Object action}) =>
              '${ext} ${action} başarısız',
          'settings.integrations.registerAll' => 'Tümünü Kaydet',
          'settings.integrations.unregisterAll' => 'Tümünü Kaldır',
          'settings.integrations.registerAllResult' => (
                  {required Object total, required Object success}) =>
              '${total} dosya türünden ${success} tanesi kaydedildi',
          'settings.integrations.unregisterAllResult' => (
                  {required Object total, required Object success}) =>
              '${total} dosya türünden ${success} tanesinin kaydı silindi',
          'settings.integrations.protocolHandler' => 'Protokol İşleyici',
          'settings.integrations.protocolHandlerDescription' =>
            'Bu uygulamayı açmak için localizer:// URL\'lerini kaydedin. Projelerin doğrudan tarayıcı bağlantılarından veya diğer uygulamalardan açılmasını sağlar.',
          'settings.integrations.protocolRegistered' =>
            'Protokol işleyici kayıtlı',
          'settings.integrations.protocolNotRegistered' =>
            'Protokol işleyici kayıtlı değil',
          'settings.integrations.registerProtocol' => 'Protokolü Kaydet',
          'settings.integrations.unregister' => 'Kaydı Sil',
          'settings.integrations.protocolRegisteredSuccess' =>
            'Protokol işleyici kaydedildi!',
          'settings.integrations.protocolRemovedSuccess' =>
            'Protokol işleyici kaldırıldı!',
          'settings.integrations.protocolRegisterError' => 'Kayıt başarısız',
          'settings.integrations.protocolRemoveError' => 'Kaldırma başarısız',
          'settings.integrations.windowMaterial' => 'Pencere Malzemesi',
          'settings.integrations.windowMaterialDescription' =>
            'macOS canlılık malzemesi stilini seçin',
          'settings.integrations.dockIntegration' => 'Dock Entegrasyonu',
          'settings.integrations.showDockBadge' =>
            'Çevrilmemiş Sayısını Göster',
          'settings.integrations.showDockBadgeDescription' =>
            'Dock simgesi rozetinde çevrilmemiş dize sayısını görüntüle',
          'settings.integrations.materials.sidebar' => 'Kenar Çubuğu',
          'settings.integrations.materials.menu' => 'Menü',
          'settings.integrations.materials.popover' => 'Açılır Pencere',
          'settings.integrations.materials.titlebar' => 'Başlık Çubuğu',
          'settings.integrations.materials.underPageBackground' =>
            'Sayfa Arka Planı',
          'settings.integrations.materials.contentBackground' => 'İçerik',
          'settings.integrations.fileTypes.loc' => 'Localizer Proje Dosyası',
          'settings.integrations.fileTypes.lang' => 'Dil Dosyası',
          'settings.integrations.fileTypes.json' =>
            'JSON Yerelleştirme Dosyası',
          'settings.integrations.fileTypes.xml' => 'XML Yerelleştirme Dosyası',
          'settings.developer.title' => 'Geliştirici Ayarları',
          'settings.developer.description' =>
            'Geliştiriciler için gelişmiş ayarlar',
          'settings.developer.showLocalizationKeys' =>
            'Yerelleştirme Anahtarlarını Göster',
          'settings.developer.localizationKeysDescription' =>
            'Etkinleştirildiğinde, tüm çevrilmiş metinler çevrilmiş değer yerine yerelleştirme anahtarlarını gösterir. Hangi anahtarın nerede kullanıldığını doğrulamak için faydalıdır.',
          'settings.developer.showPerformanceOverlay' =>
            'Performans Katmanını Göster',
          'settings.developer.performanceOverlayDescription' =>
            'FPS ve kare zamanlama bilgilerini göster',
          'settings.developer.debugMode' => 'Hata Ayıklama Modu',
          'settings.developer.debugModeDescription' =>
            'Ek günlükleme ve hata ayıklama özelliklerini etkinleştir',
          'settings.developer.debuggingTools' => 'Hata Ayıklama Araçları',
          'settings.developer.semanticsDebugger' => 'Anlamsal Hata Ayıklayıcı',
          'settings.developer.semanticsDebuggerDescription' =>
            'Anlamsal ağacı görselleştir',
          'settings.developer.materialGrid' => 'Materyal Izgara',
          'settings.developer.materialGridDescription' =>
            'Materyal düzen ızgarasını yerleştir',
          'settings.developer.rasterCache' => 'Raster Önbellek Görüntüleri',
          'settings.developer.rasterCacheDescription' =>
            'Dama tahtası raster önbellek görüntüleri',
          'settings.developer.actions' => 'Eylemler',
          'settings.developer.showLogs' => 'Uygulama Günlüklerini Göster',
          'settings.developer.showLogsDescription' =>
            'Talker hata ayıklama konsolunu aç',
          'settings.developer.restartTutorial' =>
            'Tanıtım Eğitimini Yeniden Başlat',
          'settings.developer.restartTutorialDescription' =>
            'Bayrakları sıfırla ve eğitimi tekrar başlat',
          'settings.developer.restartRequested' =>
            'Eğitim yeniden başlatma istendi.',
          'settings.developer.throwException' => 'Test İstisnası Fırlat',
          'settings.developer.throwExceptionDescription' =>
            'Kilitlenme raporlaması için bir test istisnası tetikle',
          'settings.developer.testExceptionMessage' =>
            'Geliştirici Seçeneklerinden Test İstisnası tetiklendi',
          'settings.developer.clearTM' => 'Çeviri Belleğini Temizle',
          'settings.developer.clearTMDescription' =>
            'Tüm önbelleğe alınmış çevirileri sil',
          'settings.developer.clearTMConfirmation' =>
            'Çeviri Belleğini Temizle?',
          'settings.developer.clearTMWarning' =>
            'Bu, öğrenilen tüm çevirileri silecek. Bu işlem geri alınamaz.',
          'settings.developer.tmCleared' => 'Çeviri belleği temizlendi',
          'settings.developer.clearApiKeys' => 'API Anahtarlarını Temizle',
          'settings.developer.clearApiKeysDescription' =>
            'Kayıtlı tüm API anahtarlarını kaldır',
          'settings.developer.clearApiKeysConfirmation' =>
            'API Anahtarlarını Temizle?',
          'settings.developer.clearApiKeysWarning' =>
            'Bu, güvenli depolamadaki tüm API anahtarlarını kaldıracak.',
          'settings.developer.apiKeysCleared' => 'API anahtarları temizlendi',
          'settings.developer.hideOptions' => 'Geliştirici Seçeneklerini Gizle',
          'settings.developer.hideOptionsDescription' =>
            'Geliştirici modunu devre dışı bırak (yeniden etkinleştirmek için 7 kez dokunun)',
          'settings.developer.optionsDisabled' =>
            'Geliştirici seçenekleri devre dışı bırakıldı',
          'settings.developer.dangerZone' => 'Tehlike Bölgesi',
          'settings.developer.factoryReset' => 'Fabrika Ayarlarına Sıfırla',
          'settings.developer.factoryResetDescription' =>
            'Tüm ayarları sıfırla ve verileri temizle',
          'settings.developer.factoryResetWarning' =>
            'Tüm ayarları sıfırlamak istediğinizden emin misiniz? Bu işlem geri alınamaz.',
          'settings.developer.inspectionTools' => 'İnceleme Araçları',
          'settings.developer.searchHint' => 'Ayarlarda ara...',
          'settings.developer.resetToDefault' => 'Varsayılanlara sıfırla',
          'settings.developer.resetToGlobal' => 'Küresel varsayılana sıfırla',
          'settings.developer.storageInspector' => 'Depo Denetleyici',
          'settings.developer.storageInspectorDescription' =>
            'Hive ve Güvenli Depo içeriklerini görüntüle',
          'settings.developer.deviceEnvironment' => 'Cihaz ve Ortam',
          'settings.developer.deviceEnvironmentDescription' =>
            'Ekran, platform ve derleme bilgisi',
          'settings.developer.themePlayground' => 'Tema Oyun Alanı',
          'settings.developer.themePlaygroundDescription' =>
            'Renk paleti ve tipografi',
          'settings.developer.localizationInspector' =>
            'Yerelleştirme Denetleyici',
          'settings.developer.localizationInspectorDescription' =>
            'Çeviri dizelerinde hata ayıkla',
          'settings.developer.hiveAppSettings' => 'Hive (Uygulama Ayarları)',
          'settings.developer.secureStorageMasked' =>
            'Güvenli Depo (Maskelenmiş)',
          'settings.developer.storageInspectorSection.refresh' => 'Yenile',
          'settings.developer.storageInspectorSection.hiveData' =>
            'Hive Verileri',
          'settings.developer.storageInspectorSection.secureStorage' =>
            'Güvenli Depolama',
          'settings.developer.deviceInfoSection.refresh' => 'Yenile',
          'settings.developer.deviceInfoSection.copy' => 'Panoya Kopyala',
          'settings.developer.deviceInfoSection.computerName' =>
            'Bilgisayar Adı',
          'settings.developer.deviceInfoSection.osVersion' =>
            'İşletim Sistemi Sürümü',
          'settings.developer.themePlaygroundSection.colors' => 'Renkler',
          'settings.developer.themePlaygroundSection.typography' => 'Tipografi',
          'settings.developer.themePlaygroundSection.palette.primary' =>
            'Birincil',
          'settings.developer.themePlaygroundSection.palette.onPrimary' =>
            'Birincil Üzeri',
          'settings.developer.themePlaygroundSection.palette.secondary' =>
            'İkincil',
          'settings.developer.themePlaygroundSection.palette.onSecondary' =>
            'İkincil Üzeri',
          'settings.developer.themePlaygroundSection.palette.surface' =>
            'Yüzey',
          'settings.developer.themePlaygroundSection.palette.onSurface' =>
            'Yüzey Üzeri',
          'settings.developer.themePlaygroundSection.palette.error' => 'Hata',
          'settings.developer.themePlaygroundSection.palette.onError' =>
            'Hata Üzeri',
          'settings.developer.themePlaygroundSection.palette.outline' =>
            'Dış Hat',
          'settings.developer.themePlaygroundSection.palette.shadow' => 'Gölge',
          'settings.developer.themePlaygroundSection.palette.success' =>
            'Başarılı',
          'settings.developer.themePlaygroundSection.palette.warning' =>
            'Uyarı',
          'settings.developer.themePlaygroundSection.palette.info' => 'Bilgi',
          'settings.developer.localizationInspectorSection.showKeys' =>
            'Çeviri Anahtarlarını Göster',
          'settings.developer.localizationInspectorSection.keysVisible' =>
            'Anahtarlar görünür',
          'settings.developer.localizationInspectorSection.normalDisplay' =>
            'Normal görünüm',
          'settings.developer.localizationInspectorSection.note' =>
            'Not: Bu özellik uygulama yeniden başlatmayı gerektirebilir.',
          'settings.developer.featureFlags.title' => 'Deneysel Özellikler',
          'settings.developer.featureFlags.description' =>
            'Özellik bayraklarını yerel olarak test etmek için değiştirin. Bu geçersiz kılmalar uygulama yeniden başlatıldığında kalıcı olur.',
          'settings.developer.featureFlags.subtitle' =>
            'Deneysel özellikleri geçersiz kıl',
          'settings.developer.featureFlags.flags.experimental_ai_batch.name' =>
            'Deneysel Yapay Zeka Toplu İşlemi',
          'settings.developer.featureFlags.flags.experimental_ai_batch.description' =>
            'Birden fazla satır için toplu yapay zeka çevirisini etkinleştir',
          'settings.developer.featureFlags.flags.new_diff_algorithm.name' =>
            'Yeni Fark Algoritması',
          'settings.developer.featureFlags.flags.new_diff_algorithm.description' =>
            'Karşılaştırmalar için geliştirilmiş fark algoritmasını kullan',
          'settings.developer.featureFlags.flags.enhanced_search.name' =>
            'Gelişmiş Arama',
          'settings.developer.featureFlags.flags.enhanced_search.description' =>
            'Çeviri dosyalarında bulanık aramayı etkinleştir',
          'settings.developer.featureFlags.flags.auto_save.name' =>
            'Otomatik Kaydet',
          'settings.developer.featureFlags.flags.auto_save.description' =>
            'Düzenlemelerden sonra değişiklikleri otomatik kaydet',
          'settings.developer.featureFlags.reset' => 'Tüm Bayrakları Sıfırla',
          'settings.developer.featureFlags.overrides' =>
            'Yerel Geçersiz Kılmalar',
          'settings.developer.featureFlags.defaultVal' => 'Varsayılan',
          'settings.developer.featureFlags.on' => 'AÇIK',
          'settings.developer.featureFlags.off' => 'KAPALI',
          'settings.about.title' => 'Hakkında',
          'settings.about.version' => 'Sürüm',
          'settings.about.buildNumber' => 'Yapı Numarası',
          'settings.about.author' => 'Yazar',
          _ => null,
        } ??
        switch (path) {
          'settings.about.license' => 'Lisans',
          'settings.about.sourceCode' => 'Kaynak Kodu',
          'settings.about.reportBug' => 'Hata Bildir',
          'settings.about.requestFeature' => 'Özellik İste',
          'settings.about.checkForUpdates' => 'Güncellemeleri Kontrol Et',
          'settings.about.upToDate' => 'Güncelsiniz!',
          'settings.about.updateAvailable' => ({required Object version}) =>
              'Güncelleme mevcut: ${version}',
          'settings.about.updateAvailableBadge' => 'Güncelleme Mevcut!',
          'settings.about.developerSteps' => ({required Object count}) =>
              'Geliştirici olmanıza ${count} adım kaldı.',
          'settings.about.developerActivated' => 'Artık bir geliştiricisiniz!',
          'settings.about.neverChecked' => 'Asla',
          'settings.about.applicationInfo' => 'Uygulama Bilgisi',
          'settings.about.platform' => 'Platform',
          'settings.about.updateInformation' => 'Güncelleme Bilgisi',
          'settings.about.currentVersion' => 'Mevcut Sürüm',
          'settings.about.latestVersion' => 'Son Sürüm',
          'settings.about.lastChecked' => 'Son Kontrol',
          'settings.about.checkingForUpdates' => 'Kontrol ediliyor...',
          'settings.about.whatsNew' => 'Yenilikler',
          'settings.about.systemInformation' => 'Sistem Bilgisi',
          'settings.about.dartVersion' => 'Dart Sürümü',
          'settings.about.diskSpace' => 'Kullanılabilir Disk Alanı',
          'settings.about.memoryUsage' => 'Bellek Kullanımı',
          'settings.about.privacyTitle' => 'Gizlilik ve Telemetri',
          'settings.about.usageStats' => 'Anonim Kullanım İstatistikleri',
          'settings.about.requiresFirebase' =>
            'Firebase yapılandırması gerektirir',
          'settings.about.featureUnavailable' =>
            'Özellik şu anda kullanılamıyor (Firebase gerektirir)',
          'settings.about.settingsManagement' => 'Ayarlar Yönetimi',
          'settings.about.settingsManagementDescription' =>
            'Ayarlarınızı yedeklemek veya başka makinelerle paylaşmak için bir dosyaya aktarın.',
          'settings.about.resetAll' => 'Tümünü Sıfırla',
          'settings.about.links' => 'Bağlantılar',
          'settings.about.githubRepo' => 'GitHub Deposu',
          'settings.about.privacyPolicy' => 'Gizlilik Politikası',
          'settings.about.crashReporting' => 'Çökme Raporlama',
          'settings.onboarding.skipTutorial' => 'Eğitimi Atla',
          'settings.onboarding.gettingStarted' => 'Başlarken',
          'settings.onboarding.stepProgress' => (
                  {required Object total, required Object current}) =>
              '${total} adımdan ${current}. adım',
          'settings.onboarding.loadSampleData' => 'Örnek Verileri Yükle',
          'settings.onboarding.steps.importFiles.title' =>
            'Dosyaları İçe Aktar',
          'settings.onboarding.steps.importFiles.description' =>
            'Kaynak ve hedef dosyaları yükle',
          'settings.onboarding.steps.runComparison.title' =>
            'Karşılaştırmayı Çalıştır',
          'settings.onboarding.steps.runComparison.description' =>
            '"Dosyaları Karşılaştır"a tıkla',
          'settings.onboarding.steps.reviewMissing.title' =>
            'Eksik Anahtarları İncele',
          'settings.onboarding.steps.reviewMissing.description' =>
            'Kırmızı EKSİK öğeleri fark et',
          'settings.onboarding.steps.useFilters.title' => 'Filtreleri Kullan',
          'settings.onboarding.steps.useFilters.description' =>
            'Türe göre filtrele',
          'settings.onboarding.steps.searchResults.title' => 'Arama Sonuçları',
          'settings.onboarding.steps.searchResults.description' =>
            'Belirli anahtarları bul',
          'settings.onboarding.steps.advancedView.title' => 'Gelişmiş Görünüm',
          'settings.onboarding.steps.advancedView.description' =>
            'Ayrıntılı analizi keşfet',
          'settings.onboarding.steps.editCell.title' => 'Bir Hücreyi Düzenle',
          'settings.onboarding.steps.editCell.description' =>
            'Bir değeri düzenlemek için tıkla',
          'settings.onboarding.steps.exportResults.title' => 'Dışa Aktar',
          'settings.onboarding.steps.exportResults.description' =>
            'Raporunu kaydet',
          'settings.settingsView.resetCategoryTitle' =>
            ({required Object category}) => '${category} Sıfırlansın mı?',
          'settings.settingsView.resetCategoryContent' =>
            'Bu, bu kategorideki tüm ayarları varsayılan değerlerine sıfırlayacaktır.',
          'settings.settingsView.resetAllTitle' =>
            'Tüm Ayarlar Sıfırlansın mı?',
          'settings.settingsView.resetAllContent' =>
            'Bu, tüm ayarları kalıcı olarak fabrika varsayılanlarına sıfırlayacaktır. Bu işlem geri alınamaz.',
          'settings.settingsView.resetAll' => 'Tümünü Sıfırla',
          'settings.settingsView.resetSuccess' => (
                  {required Object category}) =>
              '${category} varsayılanlara sıfırlandı',
          'settings.settingsView.errorLoading' =>
            'Ayarlar yüklenirken hata oluştu',
          'settings.settingsView.settingsSaved' => 'Ayarlar kaydedildi',
          'settings.settingsView.updateAvailable' =>
            ({required Object version}) => 'Güncelleme mevcut: v${version}',
          'settings.settingsView.latestVersion' =>
            'En son sürümü kullanıyorsunuz',
          'settings.settingsView.whatsNew' => ({required Object version}) =>
              'v${version} Sürümündeki Yenilikler',
          'settings.settingsView.downloadUpdate' => 'Güncellemeyi İndir',
          'settings.settingsView.exportSettings' => 'Ayarları Dışa Aktar',
          'settings.settingsView.settingsExported' => 'Ayarlar dışa aktarıldı',
          'settings.settingsView.exportFail' => ({required Object error}) =>
              'Ayarlar dışa aktarılamadı: ${error}',
          'settings.settingsView.importSettings' => 'Ayarları İçe Aktar',
          'settings.settingsView.importTitle' => 'Ayarlar İçe Aktarılsın mı?',
          'settings.settingsView.importContent' =>
            'Bu, mevcut tüm ayarlarınızı içe aktarılanlarla değiştirecektir. Bu işlem geri alınamaz.',
          'settings.settingsView.importSuccess' =>
            'Ayarlar başarıyla içe aktarıldı!',
          'settings.settingsView.importFail' => ({required Object error}) =>
              'Ayarlar içe aktarılamadı: ${error}',
          'settings.settingsView.invalidFormat' =>
            'Geçersiz ayar dosyası formatı',
          'settings.settingsView.categories.general' => 'Genel Ayarlar',
          'settings.settingsView.categories.comparisonEngine' =>
            'Karşılaştırma Motoru',
          'settings.settingsView.categories.appearance' => 'Görünüm',
          'settings.settingsView.categories.fileHandling' => 'Dosya İşleme',
          'settings.settingsView.categories.aiServices' =>
            'Yapay Zeka Hizmetleri',
          'settings.settingsView.categories.systemIntegrations' =>
            'Sistem Entegrasyonları',
          'settings.settingsView.categories.projectResources' =>
            'Proje Kaynakları (Sözlük & ÇB)',
          'settings.settingsView.categories.developer' =>
            'Geliştirici Seçenekleri',
          'settings.settingsView.categories.about' => 'Hakkında',
          'settings.settingsView.categoryLabels.general' => 'Genel',
          'settings.settingsView.categoryLabels.comparisonEngine' =>
            'Karşılaştırma',
          'settings.settingsView.categoryLabels.appearance' => 'Görünüm',
          'settings.settingsView.categoryLabels.fileHandling' => 'Dosya İşleme',
          'settings.settingsView.categoryLabels.aiServices' =>
            'Yapay Zeka Hizmetleri',
          'settings.settingsView.categoryLabels.systemIntegrations' =>
            'Sistem Entegrasyonları',
          'settings.settingsView.categoryLabels.projectResources' =>
            'Proje Kaynakları',
          'settings.settingsView.categoryLabels.developer' =>
            'Geliştirici Seçenekleri',
          'settings.settingsView.categoryLabels.about' => 'Hakkında',
          'fileComparison.title' => 'Dosya Karşılaştırma',
          'fileComparison.openFiles' => 'Dosyaları Aç',
          'fileComparison.exportResults' => 'Sonuçları Dışa Aktar',
          'fileComparison.restartTutorial' => 'Eğitimi Yeniden Başlat',
          'fileComparison.restartTutorialDevOnly' =>
            'Eğitimi yeniden başlatma yalnızca geliştirici modunda kullanılabilir.',
          'fileComparison.unsupportedFileType' => 'Desteklenmeyen dosya türü.',
          'fileComparison.unsupportedFileTypeSuggestion' =>
            'Lütfen desteklenen bir yerelleştirme dosyası seçin.',
          'fileComparison.someFilesUnsupported' =>
            'Bazı dosyalar desteklenmiyor.',
          'fileComparison.pickSupportedFiles' =>
            'Yalnızca desteklenen yerelleştirme dosyalarını seçin.',
          'fileComparison.pickTwoFiles' =>
            'Karşılaştırmak için iki dosya seçin.',
          'fileComparison.pickBilingualFile' =>
            'Karşılaştırmak için lütfen iki dilli bir dosya seçin.',
          'fileComparison.noResultsToExport' =>
            'Henüz dışa aktarılacak sonuç yok.',
          'fileComparison.performComparisonFirst' =>
            'Sonuçları dışa aktarmak için önce bir karşılaştırma yapın.',
          'fileComparison.performComparisonFirstEditor' =>
            'Gelişmiş ayrıntıları görmek için lütfen önce bir karşılaştırma yapın.',
          'fileComparison.sampleDataLoaded' =>
            'Örnek veriler başarıyla yüklendi',
          'fileComparison.loadSampleDataError' => ({required Object error}) =>
              'Örnek veriler yüklenemedi: ${error}',
          'fileComparison.invalidFileType' => 'Geçersiz dosya türü.',
          'fileComparison.fileSelected' => (
                  {required Object label, required Object fileName}) =>
              '${label} seçildi: ${fileName}',
          'fileComparison.sourceFile' => 'Kaynak dosya',
          'fileComparison.targetFile' => 'Hedef dosya',
          'fileComparison.bilingualFile' => 'İki dilli dosya',
          'fileComparison.compareFiles' => 'Dosyaları Karşılaştır',
          'fileComparison.compareFile' => 'Dosyayı Karşılaştır',
          'fileComparison.bilingualMode' => 'İki Dilli Mod',
          'fileComparison.twoFilesMode' => 'İki Dosya',
          'fileComparison.processing' => 'İşleniyor...',
          'fileComparison.remaining' => ({required Object time}) =>
              '${time} kaldı',
          'fileComparison.comparisonInProgress' =>
            'Karşılaştırma devam ediyor...',
          'fileComparison.comparisonFailed' => ({required Object error}) =>
              'Karşılaştırma Başarısız: ${error}',
          'fileComparison.fileChanged' => ({required Object fileName}) =>
              'Dosya değişti: ${fileName}. Yeniden karşılaştırılıyor...',
          'fileComparison.dropFileHere' => 'Dosyayı buraya bırakın',
          'fileComparison.dropFileOrBrowse' =>
            'Dosyayı bırakın veya göz atmak için tıklayın',
          'fileComparison.fileUpload' => 'Dosya yükle',
          'fileComparison.changeFile' => 'Dosyayı değiştir',
          'fileComparison.total' => 'Toplam',
          'fileComparison.show' => 'Göster',
          'fileComparison.showAll' => 'Tümünü Göster',
          'fileComparison.noMatches' => ({required Object query}) =>
              '"${query}" için eşleşme bulunamadı',
          'fileComparison.showingEntries' => (
                  {required Object total, required Object count}) =>
              '${total} girişten ${count} tanesi gösteriliyor',
          'fileComparison.filesIdentical' => 'Dosyalar aynı.',
          'fileComparison.hiddenIdentical' => ({required Object count}) =>
              '${count} aynı giriş gizlendi',
          'fileComparison.showIdentical' => 'Aynı Girişleri Göster',
          'fileComparison.hideIdentical' => 'Aynı girişleri gizle',
          'fileComparison.noDiff' => 'Anahtarlara dayalı fark bulunamadı.',
          'fileComparison.source' => 'Kaynak',
          'fileComparison.target' => 'Hedef',
          'fileComparison.value' => 'Değer',
          'fileComparison.readyToCompare' => 'Dosyaları Karşılaştırmaya Hazır',
          'fileComparison.readyToCompareDesc' =>
            'Yerelleştirme dosyalarını yukarıya bırakın veya karşılaştırma için dosya seçmek üzere gözat düğmelerini kullanın.',
          'fileComparison.recentComparisons' => 'Son Karşılaştırmalar',
          'fileComparison.bilingualFileLabel' => ({required Object name}) =>
              'İki dilli dosya: ${name}',
          'fileComparison.comparisonLabel' => (
                  {required Object source, required Object target}) =>
              '${source} ↔ ${target}',
          'fileComparison.fileNotExist' =>
            'Bu oturumdaki dosyalardan biri veya her ikisi artık mevcut değil.',
          'fileComparison.largeFileTitle' => 'Büyük Dosya Algılandı',
          'fileComparison.largeFileContent' => ({required Object count}) =>
              'Karşılaştırma sonucu ${count} giriş içeriyor.\nHepsini görüntülemek performans sorunlarına neden olabilir.\n\nDevam etmek istiyor musunuz?',
          'fileComparison.dontShowAgain' => 'Bu dosya için tekrar gösterme',
          'fileComparison.proceed' => 'Devam Et',
          'fileComparison.exportReport' => ({required Object format}) =>
              '${format} Raporunu Kaydet',
          'fileComparison.saved' => ({required Object format}) =>
              '${format} kaydedildi',
          'fileComparison.saveError' => ({required Object format}) =>
              '${format} dosyası kaydedilemedi.',
          'fileComparison.saveErrorDetailed' => (
                  {required Object format, required Object error}) =>
              '${format} kaydedilemedi: ${error}',
          'fileComparison.watching' => 'İzleniyor',
          'fileComparison.watchOff' => 'İzleme Kapalı',
          'fileComparison.watchingTooltip' => ({required Object status}) =>
              'Dosya İzleme: ${status}\nDosyalar diskte değiştiğinde otomatik olarak yeniden karşılaştır',
          'fileComparison.aiSettingsNotAvailable' =>
            'Yapay Zeka ayarlarına erişilemiyor',
          'directoryComparison.title' => 'Dizin Karşılaştırma',
          'directoryComparison.sourceDirectory' => 'Kaynak Dizin',
          'directoryComparison.targetDirectory' => 'Hedef Dizin',
          'directoryComparison.sourceSubtitle' => 'Orijinal/Referans dosyaları',
          'directoryComparison.targetSubtitle' =>
            'Çeviri/Karşılaştırma dosyaları',
          'directoryComparison.selectBothDirectories' =>
            'Lütfen hem kaynak hem de hedef dizini seçin.',
          'directoryComparison.selectSourceFolder' => 'Kaynak Klasörü Seç',
          'directoryComparison.selectTargetFolder' => 'Hedef Klasörü Seç',
          'directoryComparison.dropFolderHere' =>
            'Klasörü buraya bırakın veya göz atın...',
          'directoryComparison.folderPath' => 'Klasör Yolu',
          'directoryComparison.readyToCompare' =>
            'Dizinleri Karşılaştırmaya Hazır',
          'directoryComparison.readyToCompareDesc' =>
            'Klasörleri yukarıya bırakın veya karşılaştırma için dizinleri seçmek üzere gözat düğmelerini kullanın.',
          'directoryComparison.nestedFolders' => 'İç içe klasörler',
          'directoryComparison.nestedFoldersTooltip' =>
            'Tüm iç içe dizinleri yinelemeli olarak karşılaştırır',
          'directoryComparison.fileMatching' => 'Dosya eşleştirme',
          'directoryComparison.fileMatchingTooltip' =>
            'Dosyaları ada göre otomatik olarak eşleştirir',
          'directoryComparison.bulkExport' => 'Toplu dışa aktarma',
          'directoryComparison.bulkExportTooltip' =>
            'Tüm karşılaştırma sonuçlarını tek seferde dışa aktar',
          'directoryComparison.notDirectoryComparison' =>
            'Bu bir dizin karşılaştırması değil.',
          'directoryComparison.directoriesNotExist' =>
            'Bir veya her iki dizin artık mevcut değil.',
          'directoryComparison.errorOccurred' => 'Hata oluştu',
          'directoryComparison.noFilesFound' =>
            'Seçilen dizinlerde dosya bulunamadı.',
          'directoryComparison.unmatchedSourceFiles' =>
            'Eşleşmeyen Kaynak Dosyalar',
          'directoryComparison.unmatchedTargetFiles' =>
            'Eşleşmeyen Hedef Dosyalar',
          'directoryComparison.filePairs' => ({required Object count}) =>
              '${count} dosya çifti',
          'directoryComparison.pairedFiles' => ({required Object count}) =>
              'Eşleşen Dosyalar (${count})',
          'directoryComparison.view' => 'Görüntüle',
          'directoryComparison.failed' => 'Başarısız',
          'directoryComparison.pair' => 'Eşleştir...',
          'directoryComparison.pairDialogTitle' => ({required Object name}) =>
              '"${name}" dosyasını şununla eşleştir:',
          'directoryComparison.discoverFiles' => 'Dosyaları Keşfet',
          'directoryComparison.compareAll' => 'Tümünü Karşılaştır',
          'directoryComparison.exportAll' => 'Tümünü Dışa Aktar',
          'directoryComparison.comparisonStarted' =>
            'Karşılaştırma başlatıldı...',
          'directoryComparison.discoveringFiles' => 'Dosyalar keşfediliyor...',
          'directoryComparison.noResultsToExport' =>
            'Dışa aktarılacak karşılaştırma sonucu yok. Önce "Tümünü Karşılaştır"ı çalıştırın.',
          'directoryComparison.selectExportFolder' =>
            'Dışa Aktarma Klasörünü Seç',
          'directoryComparison.createExportFolderError' => (
                  {required Object error}) =>
              'Dışa aktarma klasörü oluşturulamadı: ${error}',
          'directoryComparison.exportingResults' => 'Sonuçlar Dışa Aktarılıyor',
          'directoryComparison.processingFile' => ({required Object file}) =>
              'İşleniyor: ${file}',
          'directoryComparison.exportProgress' => (
                  {required Object total, required Object current}) =>
              '${total} dosyadan ${current} tanesi dışa aktarıldı',
          'directoryComparison.exportComplete' => 'Dışa Aktarma Tamamlandı',
          'directoryComparison.exportSuccessMessage' => (
                  {required Object count}) =>
              '${count} karşılaştırma dosyası ve özet başarıyla dışa aktarıldı.',
          'directoryComparison.exportFailed' => ({required Object error}) =>
              'Dışa aktarma başarısız: ${error}',
          'directoryComparison.close' => 'Kapat',
          'gitComparison.title' => 'Repo Karşılaştırması',
          'gitComparison.repoSelector' => 'Repo Oluştur / Aç',
          'gitComparison.noRepoSelected' => 'Repo seçilmedi',
          'gitComparison.open' => 'Aç',
          'gitComparison.refreshCommits' => 'Commitleri Yenile',
          'gitComparison.noCommits' =>
            'Commit bulunamadı veya yüklenemedi. Commitleri yüklemek için bir dal seçin.',
          'gitComparison.baseCommit' => 'Temel Commit (Eski)',
          'gitComparison.targetCommit' => 'Hedef Commit (Yeni)',
          'gitComparison.filterCommitsByBranch' =>
            'Branch\'a Göre Commitleri Filtrele',
          'gitComparison.conflictDetection' => 'Conflict algılama',
          'gitComparison.conflictDetectionTooltip' =>
            'Merge conflictlerini tespit et ve çöz',
          'gitComparison.actions' => 'Eylemler:',
          'gitComparison.checkout' => 'Checkout',
          'gitComparison.merge' => 'Merge',
          'gitComparison.pull' => 'Pull',
          'gitComparison.checkoutBranch' => 'Branch\'a Checkout Yap',
          'gitComparison.mergeBranch' =>
            'Branch\'ı Geçerli Branch ile Merge Et',
          'gitComparison.mergeConfirmation' => ({required Object branch}) =>
              '${branch} merge edilsin mi?',
          'gitComparison.mergeWarning' =>
            'Bu, değişiklikleri geçerli çalışma branch\'ınızla birleştirecektir. Conflict oluşabilir.',
          'gitComparison.selectExportFolder' => 'Dışa Aktarma Klasörünü Seç',
          'gitComparison.createExportFolderError' => (
                  {required Object error}) =>
              'Dışa aktarma klasörü oluşturulamadı: ${error}',
          'gitComparison.exportingFiles' => 'Dosyalar Dışa Aktarılıyor',
          'gitComparison.processingFile' => ({required Object file}) =>
              'İşleniyor: ${file}',
          'gitComparison.exportProgress' => (
                  {required Object total, required Object current}) =>
              '${total} dosyadan ${current} tanesi dışa aktarıldı',
          'gitComparison.exportComplete' => 'Dışa Aktarma Tamamlandı',
          'gitComparison.exportSuccessMessage' => ({required Object count}) =>
              '${count} dosya tam içerikle başarıyla dışa aktarıldı.',
          'gitComparison.exportDetail' =>
            'Her dosyanın farkı "files" alt klasörüne kaydedilir.',
          'gitComparison.diffViewer' => 'Fark Görüntüleyici',
          'gitComparison.base' => 'TEMEL',
          'gitComparison.target' => 'HEDEF',
          'gitComparison.noLines' => 'Görüntülenecek satır yok',
          'gitComparison.searchFiles' => 'Dosyaları ara...',
          'gitComparison.noFilesMatch' => ({required Object query}) =>
              '"${query}" ile eşleşen dosya yok',
          'gitComparison.filesCount' => ({required Object count}) =>
              '${count} dosya',
          'gitComparison.selectBaseFile' => 'Temel Dosyayı Seç',
          'gitComparison.selectTargetFile' => 'Hedef Dosyayı Seç',
          'gitComparison.comparisonResults' => 'Karşılaştırma Sonuçları',
          'gitComparison.noChanges' =>
            'Seçilen referanslar arasında değişiklik bulunamadı.',
          'gitComparison.linesAdded' => 'Eklenen Satırlar',
          'gitComparison.linesRemoved' => 'Kaldırılan Satırlar',
          'gitComparison.commit' => 'Commit',
          'gitComparison.branch' => 'Branch',
          'gitComparison.noRepositorySelected' => 'Depo seçilmedi',
          'gitComparison.notGitComparison' => 'Git karşılaştırması değil',
          'gitComparison.repositoryNotExist' => 'Depo mevcut değil',
          'gitComparison.mainBranch' => 'main',
          'gitComparison.masterBranch' => 'master',
          'gitComparison.backToControls' => 'Karşılaştırma kontrollerine dön',
          'advancedComparison.placeholder' =>
            'Gelişmiş Karşılaştırma Görünümü - Yer Tutucu',
          'advancedDiff.saveAllChanges' => 'Tüm Değişiklikleri Kaydet?',
          'advancedDiff.saveConfirmation' => ({required Object count}) =>
              'Bu işlem, değiştirilen ${count} girdinin tamamını hedef dosyaya kaydedecek. Bu işlem geri alınamaz.',
          'advancedDiff.changesSaved' => 'Değişiklikler başarıyla kaydedildi.',
          'advancedDiff.csvExported' => 'CSV dışa aktarıldı',
          'advancedDiff.unsavedChanges' => 'Kaydedilmemiş Değişiklikler',
          'advancedDiff.unsavedChangesWarning' =>
            'Kaydedilmemiş değişiklikleriniz var. Bunları silmek istediğinizden emin misiniz?',
          'advancedDiff.discardChanges' => 'Değişiklikleri Sil',
          'advancedDiff.goBack' => 'Geri git',
          'advancedDiff.breadcrumbs' => 'Ana Sayfa  >  Düzenleyici',
          'advancedDiff.unsaved' => ({required Object count}) =>
              '${count} kaydedilmemiş',
          'advancedDiff.reviewed' => ({required Object count}) =>
              '${count} incelendi',
          'advancedDiff.saveAll' => ({required Object count}) =>
              'Tümünü Kaydet (${count})',
          'advancedDiff.allSaved' => 'Tümü Kaydedildi',
          'advancedDiff.saveAllTooltip' => 'Tüm Değişiklikleri Kaydet (Ctrl+S)',
          'advancedDiff.exportTooltip' => 'Veriyi Dışa Aktar (Ctrl+E)',
          'advancedDiff.aiSuggestion.aiTranslation' => 'Yapay Zeka Çevirisi',
          'advancedDiff.aiSuggestion.aiRephrase' =>
            'Yapay Zeka Yeniden İfadesi',
          'advancedDiff.aiSuggestion.key' => ({required Object key}) =>
              'Anahtar: ${key}',
          'advancedDiff.aiSuggestion.original' => 'Orijinal:',
          'advancedDiff.aiSuggestion.suggestion' => 'Öneri:',
          'advancedDiff.aiSuggestion.confidence' => 'Yapay Zeka Güveni',
          'advancedDiff.aiSuggestion.cancelEdit' => 'Düzenlemeyi iptal et',
          'advancedDiff.aiSuggestion.editSuggestion' => 'Öneriyi düzenle',
          'advancedDiff.aiSuggestion.alternatives' => 'Alternatifler:',
          'advancedDiff.aiSuggestion.accept' => 'Kabul Et',
          'advancedDiff.aiSuggestion.reject' => 'Reddet',
          'advancedDiff.aiSuggestion.stop' => 'Durdur',
          'advancedDiff.detailEdit.title' => ({required Object key}) =>
              'Düzenle: ${key}',
          'advancedDiff.detailEdit.sourceLabel' => 'KAYNAK (Orijinal)',
          'advancedDiff.detailEdit.targetLabel' => 'HEDEF (Çeviri)',
          'advancedDiff.detailEdit.translateWithCloud' => 'Bulut ile Çevir',
          'advancedDiff.detailEdit.translateWithAi' => 'Yapay Zeka ile Çevir',
          'advancedDiff.detailEdit.translating' => 'Çevriliyor...',
          'advancedDiff.detailEdit.applyAndTm' => 'Uygula',
          'advancedDiff.detailEdit.entryApplied' =>
            'Giriş uygulandı ve Çeviri Belleğine eklendi',
          'advancedDiff.detailEdit.translationAdded' =>
            'Çeviri önerisi eklendi.',
          'advancedDiff.detailEdit.aiSuggestionAdded' =>
            'Yapay zeka önerisi eklendi.',
          'advancedDiff.table.addedToTM' => 'Çeviri Belleğine Eklendi',
          'advancedDiff.table.markedReviewed' =>
            'İncelendi olarak işaretlendi ✓',
          'advancedDiff.table.unmarkedReview' => 'İnceleme işareti kaldırıldı',
          'advancedDiff.table.reverted' => 'Kaynak değere geri döndürüldü',
          'advancedDiff.table.entryDeleted' => 'Giriş silindi',
          'advancedDiff.table.noSourceText' => 'Çevrilecek kaynak metin yok.',
          'advancedDiff.table.aiTranslationFailed' => ({required Object key}) =>
              '"${key}" için yapay zeka çevirisi başarısız oldu',
          'advancedDiff.table.noTargetText' =>
            'Yeniden ifade edilecek hedef metin yok.',
          'advancedDiff.table.aiRephraseFailed' => ({required Object key}) =>
              '"${key}" için yapay zeka yeniden ifadesi başarısız oldu',
          'advancedDiff.table.checkRowsFirst' =>
            'Önce onay kutularını kullanarak satırları seçin',
          'advancedDiff.table.markedRowsReviewed' => (
                  {required Object count}) =>
              '${count} satır incelendi olarak işaretlendi',
          'advancedDiff.table.revertedRows' => ({required Object count}) =>
              '${count} satır geri alındı',
          'advancedDiff.table.entriesCount' => ({required Object count}) =>
              '${count} giriş',
          'advancedDiff.table.markSelectedReviewed' =>
            'Seçilenleri İncelendi Olarak İşaretle',
          'advancedDiff.table.revertSelected' => 'Seçilenleri Geri Al',
          'advancedDiff.table.noDifferences' => 'Fark bulunamadı',
          'advancedDiff.table.adjustFilters' =>
            'Filtrelerinizi ayarlamayı deneyin',
          'advancedDiff.table.cloudTranslationApplied' =>
            'Bulut çevirisi uygulandı.',
          'advancedDiff.table.aiTranslationApplied' =>
            'Yapay zeka çevirisi uygulandı.',
          'advancedDiff.table.suggestionApplied' => 'Öneri uygulandı.',
          'advancedDiff.table.aiSuggestionApplied' =>
            'Yapay zeka önerisi uygulandı.',
          'advancedDiff.table.rephraseApplied' =>
            'Yeniden ifade etme uygulandı.',
          'advancedDiff.table.aiRephraseApplied' =>
            'Yapay zeka yeniden ifadesi uygulandı.',
          'advancedDiff.table.rephrase' => 'Yeniden İfade Et',
          'advancedDiff.table.aiRephrase' => 'Yapay Zeka ile Yeniden İfade Et',
          'advancedDiff.table.targetClickToEdit' =>
            'HEDEF (Düzenlemek için tıklayın)',
          'advancedDiff.table.targetClickForDialog' =>
            'HEDEF (Diyalog için tıklayın)',
          'advancedDiff.table.emptyClickToEdit' =>
            '(Boş - Düzenlemek için tıklayın)',
          'advancedDiff.table.unmarkReviewed' => 'İncelendi işaretini kaldır',
          'advancedDiff.table.markReviewed' => 'İncelendi olarak işaretle',
          'advancedDiff.table.revertToSource' => 'Kaynağa geri dön',
          'advancedDiff.table.translateWithCloud' => 'Bulut ile Çevir',
          'advancedDiff.table.translateWithAi' => 'Yapay Zeka ile Çevir',
          'advancedDiff.table.rephraseWithAi' =>
            'Yapay Zeka ile Yeniden İfade Et',
          'advancedDiff.table.moreActions' => 'Diğer eylemler',
          'advancedDiff.table.editDetails' => 'Ayrıntıları düzenle',
          'advancedDiff.table.suggestTranslation' => 'Çeviri öner',
          'advancedDiff.table.addToTm' => 'ÇB\'ye Ekle',
          'advancedDiff.table.deleteEntry' => 'Girişi sil',
          'advancedDiff.diffRow.copySource' => 'Kaynak metni kopyala',
          'advancedDiff.diffRow.copyTarget' => 'Hedef metni kopyala',
          'advancedDiff.diffRow.actions' => 'Eylemler',
          'advancedDiff.status.added' => 'EKLENDİ',
          'advancedDiff.status.missing' => 'EKSİK',
          'advancedDiff.status.changed' => ({required Object percent}) =>
              'DĞŞ %${percent}',
          'advancedDiff.status.same' => 'AYNI',
          'advancedDiff.sidebar.widgets' => 'Araçlar',
          'advancedDiff.sidebar.searchPlaceholder' =>
            'Anahtarları ve değerleri ara... (Ctrl+F)',
          'advancedDiff.sidebar.fuzzySearchTooltip' =>
            'Bulanık Arama (yazım hatasına toleranslı)',
          'advancedDiff.sidebar.regexSearchTooltip' => 'Regex Arama',
          'advancedDiff.sidebar.cloudTranslation' => 'Bulut Çevirisi',
          'advancedDiff.sidebar.aiTranslation' => 'Yapay Zeka Çevirisi',
          'advancedDiff.sidebar.status' => 'Durum',
          'advancedDiff.sidebar.tm' => 'Çeviri Belleği',
          'advancedDiff.sidebar.filters' => 'Filtreler',
          'advancedDiff.sidebar.actions' => 'Eylemler',
          'advancedDiff.sidebar.similarity' => 'Benzerlik',
          'advancedDiff.sidebar.actionsSection.exportMatches' =>
            'Eşleşmeleri Dışa Aktar',
          'advancedDiff.sidebar.actionsSection.preview' => 'Önizleme',
          'advancedDiff.sidebar.actionsSection.fillFromTmTitle' =>
            'Çeviri Belleğinden Doldurulsun mu?',
          'advancedDiff.sidebar.actionsSection.fillFromTmContent' =>
            'Bu, Çeviri Belleğindeki eşleşmeleri kullanarak boş hedef değerleri doldurmaya çalışacaktır. Mevcut değerlerin üzerine YAZILMAYACAKTIR.',
          'advancedDiff.sidebar.actionsSection.fill' => 'Doldur',
          'advancedDiff.sidebar.actionsSection.fillFromMemory' =>
            'Bellekten Doldur',
          'advancedDiff.sidebar.actionsSection.filledFromTm' => (
                  {required Object count}) =>
              '${count} öğe Çeviri Belleğinden dolduruldu.',
          'advancedDiff.sidebar.aiSection.infoCloud' =>
            'Kaynaktan gelen boş hedef değerleri çevirmek için bulut çevirisi kullanır.',
          'advancedDiff.sidebar.aiSection.infoAi' =>
            'Kaynaktan gelen boş hedef değerleri çevirmek için yapay zeka kullanır.',
          'advancedDiff.sidebar.aiSection.translationSettings' =>
            'Çeviri Ayarları',
          'advancedDiff.sidebar.aiSection.aiSettings' => 'Yapay Zeka Ayarları',
          'advancedDiff.sidebar.aiSection.source' => 'Kaynak',
          'advancedDiff.sidebar.aiSection.target' => 'Hedef',
          'advancedDiff.sidebar.aiSection.translatingProgress' =>
            ({required Object percent}) => 'Çevriliyor... %${percent}',
          'advancedDiff.sidebar.aiSection.translating' => 'Çevriliyor...',
          'advancedDiff.sidebar.aiSection.translateAllMissing' =>
            'Tüm Eksikleri Çevir',
          'advancedDiff.sidebar.aiSection.translateAllTitle' =>
            'Tüm Eksikler Çevrilsin mi?',
          'advancedDiff.sidebar.aiSection.translateAllContent' => (
                  {required Object source,
                  required Object target,
                  required Object service}) =>
              'Bu işlem, boş hedef değerlere sahip tüm girdileri ${source} dilinden ${target} diline çevirmek için ${service} kullanacaktır.\n\nHer öneriyi inceleyebilir veya hepsini aynı anda uygulayabilirsiniz.',
          'advancedDiff.sidebar.aiSection.translateAll' => 'Tümünü Çevir',
          'advancedDiff.sidebar.aiSection.reviewEach' => 'Her Birini İncele',
          'advancedDiff.sidebar.aiSection.cloudTranslated' => (
                  {required Object count}) =>
              '${count} girdi bulut çevirisi ile çevrildi.',
          'advancedDiff.sidebar.aiSection.aiTranslated' => (
                  {required Object count}) =>
              '${count} girdi yapay zeka ile çevrildi.',
          'advancedDiff.sidebar.aiSection.aiTranslateFailed' =>
            'Yapay zeka toplu çevirisi başarısız oldu',
          'advancedDiff.sidebar.aiSection.noMissingEntries' =>
            'Çevrilecek eksik girdi yok.',
          'advancedDiff.sidebar.aiSection.skip' => 'Atla',
          'advancedDiff.sidebar.aiSection.stop' => 'Durdur',
          'advancedDiff.sidebar.aiSection.cloudApplied' =>
            ({required Object count}) => '${count} öneri uygulandı.',
          'advancedDiff.sidebar.aiSection.aiApplied' => (
                  {required Object count}) =>
              '${count} yapay zeka önerisi uygulandı.',
          'advancedDiff.sidebar.tmSection.enableTmFill' =>
            'TM Doldurma Etkinleştir',
          'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' =>
            'Minimum üstünde otomatik uygula',
          'advancedDiff.sidebar.tmSection.matchSettings' => 'Eşleşme Ayarları',
          'advancedDiff.sidebar.tmSection.minMatch' => 'Min eşleşme:',
          'advancedDiff.sidebar.tmSection.limit' => 'Limit:',
          'advancedDiff.sidebar.tmSection.exact' => 'Tam Eşleşme',
          'advancedDiff.sidebar.filtersSection.viewFilters' =>
            'Görünüm Filtreleri',
          'advancedDiff.sidebar.filtersSection.showAll' => 'Tümünü Göster',
          'advancedDiff.sidebar.filtersSection.added' => 'Eklenen',
          'advancedDiff.sidebar.filtersSection.removed' => 'Silinen',
          'advancedDiff.sidebar.filtersSection.modified' => 'Değiştirilen',
          'advancedDiff.sidebar.filtersSection.actionScope' => 'Eylem Kapsamı',
          'advancedDiff.sidebar.filtersSection.applyToAdded' =>
            'Eklenenlere Uygula',
          'advancedDiff.sidebar.filtersSection.applyToModified' =>
            'Değiştirilenlere Uygula',
          'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' =>
            'Yalnızca boş hedefleri doldur',
          'advancedDiff.sidebar.filtersSection.limitToVisible' =>
            'Görünene sınırla',
          'advancedDiff.sidebar.filtersSection.editMode' => 'Düzenleme Modu',
          'advancedDiff.sidebar.filtersSection.dialog' => 'Diyalog',
          'advancedDiff.sidebar.filtersSection.inline' => 'Satır İçi',
          'advancedDiff.sidebar.similaritySection.currentFilter' =>
            'Geçerli Filtre:',
          'advancedDiff.sidebar.similaritySection.any' => 'HERHANGİ',
          'advancedDiff.sidebar.similaritySection.high' => 'YÜKSEK',
          'advancedDiff.sidebar.similaritySection.medium' => 'ORTA',
          'advancedDiff.sidebar.similaritySection.low' => 'DÜŞÜK',
          'advancedDiff.sidebar.statusSection.total' =>
            ({required Object count}) => '${count} toplam',
          'advancedDiff.sidebar.statusSection.extra' =>
            ({required Object count}) => '${count} fazla',
          'advancedDiff.sidebar.statusSection.missing' =>
            ({required Object count}) => '${count} eksik',
          'advancedDiff.sidebar.statusSection.changed' =>
            ({required Object count}) => '${count} değişti',
          'issueDetails.title' => 'Sorun Ayrıntıları',
          'issueDetails.showingIssues' => (
                  {required Object total, required Object count}) =>
              '${total} sorundan ${count} tanesi gösteriliyor',
          'issueDetails.searchPlaceholder' =>
            'Anahtar, metin veya hataya göre ara...',
          'issueDetails.noDetails' => 'Ayrıntı mevcut değil.',
          'issueDetails.noMatches' => 'Eşleşme bulunamadı.',
          'issueDetails.showMore' => 'Daha Fazla Göster',
          'issueDetails.copyItems' => ({required Object count}) =>
              '${count} Öğeyi Kopyala',
          'issueDetails.close' => 'Kapat',
          'issueDetails.copied' => 'Panoya kopyalandı',
          'issueDetails.copiedCount' => ({required Object count}) =>
              '${count} öğe kopyalandı',
          'issueDetails.duplicateValue.label' => 'TEKRARLANAN ÇEVİRİ',
          'issueDetails.duplicateValue.warning' =>
            'Farklı kaynak metinler aynı çeviriyi kullanıyor. Bağlamı kontrol edin.',
          'issueDetails.duplicateValue.affectedKeys' =>
            ({required Object count}) => 'ETKİLENEN ANAHTARLAR (${count})',
          'issueDetails.duplicateValue.identicalSources' => 'Aynı Kaynaklar',
          'issueDetails.duplicateValue.moreKeys' => ({required Object count}) =>
              '+${count} anahtar daha',
          'issueDetails.lengthOutlier.source' => 'KAYNAK',
          'issueDetails.lengthOutlier.translation' => 'ÇEVİRİ',
          'issueDetails.lengthOutlier.chars' => ({required Object count}) =>
              '${count} karakter',
          'issueDetails.standard.key' => 'ANAHTAR',
          'issueDetails.standard.sourceText' => 'KAYNAK METİN',
          'issueDetails.standard.translation' => 'ÇEVİRİ',
          'issueDetails.standard.errorDetails' => 'HATA AYRINTILARI',
          'issueDetails.standard.note' => 'NOT',
          'issueDetails.review' => 'İncele',
          'issueDetails.types.duplicateValue' => 'Yinelenen Değerler',
          'issueDetails.types.lengthOutlier' => 'Uzunluk Uyumsuzluğu',
          'issueDetails.types.placeholderMismatch' => 'Bozuk Yer Tutucular',
          'issueDetails.notes.placeholderMismatch' =>
            '{name} gibi işaretçiler kaynakla eşleşmelidir.',
          'issueDetails.notes.lengthOutlier' =>
            'Büyük uzunluk değişiklikleri metnin ekrana nasıl sığacağını etkileyebilir.',
          'issueDetails.notes.duplicateValue' =>
            'Farklı anahtarlar için aynı çeviri kullanılmış.',
          'issueDetails.fallbacks.multipleSources' =>
            'Birden fazla kaynak metin',
          'issueDetails.fallbacks.sourceNotAvailable' =>
            'Kaynak metin mevcut değil',
          'issueDetails.fallbacks.sharedTranslationNotAvailable' =>
            'Paylaşılan çeviri mevcut değil',
          'issueDetails.fallbacks.translationNotAvailable' =>
            'Çeviri mevcut değil',
          'importReview.title' => 'Proje İçe Aktarımını İncele',
          'importReview.projectName' => 'Proje Adı',
          'importReview.created' => 'Oluşturulma',
          'importReview.historyItems' => 'Geçmiş Öğeleri',
          'importReview.customSettingsTitle' => 'Özel Ayarlar Algılandı',
          'importReview.customSettingsWarning' =>
            'Bu proje, proje açıkken varsayılanlarınızı geçersiz kılacak özel ayarlar içerir.',
          'importReview.standardSettings' =>
            'Bu proje standart küresel ayarları kullanır.',
          'importReview.cancelImport' => 'İçe Aktarmayı İptal Et',
          'importReview.trustOpen' => 'Güven ve Projeyi Aç',
          'historyView.title' => 'Karşılaştırma Geçmişi',
          'historyView.clearAll' => 'Tüm geçmişi temizle',
          'historyView.searchPlaceholder' => 'Dosya adına göre ara...',
          'historyView.sortBy' => 'Sıralama ölçütü',
          'historyView.sortDate' => 'Tarih',
          'historyView.sortSource' => 'Kaynak Dosya',
          'historyView.sortTarget' => 'Hedef Dosya',
          'historyView.showCurrentProject' => 'Gösterilen: Mevcut Proje',
          'historyView.showAllHistory' => 'Gösterilen: Tüm Geçmiş',
          'historyView.groupByFolder' => 'Klasöre göre grupla',
          'historyView.disableGrouping' =>
            'Klasör gruplamasını devre dışı bırak',
          'historyView.filterAll' => 'Tümü',
          'historyView.filterFiles' => 'Dosyalar',
          'historyView.filterDirectories' => 'Dizinler',
          'historyView.filterGit' => 'Git',
          'historyView.noHistory' => 'Henüz karşılaştırma geçmişi yok',
          'historyView.historyDescription' =>
            'Dosya karşılaştırmalarınız burada görünecek',
          'historyView.noResults' => 'Sonuç bulunamadı',
          'historyView.adjustSearch' => 'Aramayı ayarlamayı deneyin',
          'historyView.clearConfirmationTitle' => 'Tüm Geçmişi Temizle?',
          'historyView.clearConfirmationContent' =>
            'Bu işlem tüm karşılaştırma geçmişini kalıcı olarak silecek. Bu işlem geri alınamaz.',
          'historyView.clearAction' => 'Tümünü Temizle',
          'historyView.deletedMessage' => 'Geçmiş öğesi silindi',
          'historyView.undo' => 'Geri Al',
          'historyView.viewDetails' => 'Ayrıntıları Görüntüle',
          'historyView.delete' => 'Sil',
          'historyView.openLocation' => 'Dosya konumunu aç',
          'historyView.bilingual' => 'İki Dilli',
          'historyView.filePair' => 'Dosya Çifti',
          'historyView.directory' => 'Dizin',
          'historyView.git' => 'Git',
          'historyView.repo' => 'Depo',
          'historyView.sourceDir' => 'Kaynak Dizin',
          'historyView.targetDir' => 'Hedef Dizin',
          'historyView.source' => 'Kaynak',
          'historyView.target' => 'Hedef',
          'historyView.noChanges' => 'Değişiklik algılanmadı',
          'historyView.added' => 'Eklendi',
          'historyView.removed' => 'Kaldırıldı',
          'historyView.modified' => 'Değiştirildi',
          'historyView.same' => 'Aynı',
          'historyView.total' => 'Toplam',
          'historyView.currentProject' => 'Mevcut Proje',
          'historyView.unassigned' => 'Atanmamış',
          'historyView.project' => 'Proje',
          'compare.title' => 'Dosyaları Karşılaştır',
          'compare.sourceFile' => 'Kaynak Dosya',
          'compare.targetFile' => 'Hedef Dosya',
          'compare.sourceFolder' => 'Kaynak Klasör',
          'compare.targetFolder' => 'Hedef Klasör',
          'compare.dropFilesHint' =>
            'Yerelleştirme dosyalarını buraya bırakın veya karşılaştırma için dosya seçmek üzere gözat düğmelerini kullanın.',
          'compare.selectSourceFile' => 'Kaynak dosya seç',
          'compare.selectTargetFile' => 'Hedef dosya seç',
          'compare.startComparison' => 'Karşılaştırmayı Başlat',
          'compare.comparing' => 'Karşılaştırılıyor...',
          'compare.comparisonComplete' => 'Karşılaştırma tamamlandı',
          'compare.noChanges' => 'Değişiklik algılanmadı',
          'compare.filesIdentical' => 'Dosyalar aynı',
          'compare.changesFound' => ({required Object count}) =>
              '${count} değişiklik bulundu',
          'compare.tabs.files' => 'Dosyalar',
          'compare.tabs.directories' => 'Dizinler',
          'compare.tabs.git' => 'Git',
          'compare.fileTypes.json' =>
            'JSON yerelleştirme dosyaları (i18next, Flutter, vb.)',
          'compare.fileTypes.yaml' =>
            'YAML yerelleştirme dosyaları (Rails, Flutter)',
          'compare.fileTypes.xml' =>
            'XML yerelleştirme dosyaları (Android, .NET)',
          'compare.fileTypes.properties' => 'Properties dosyaları (Java)',
          'compare.fileTypes.resx' => 'RESX dosyaları (.NET)',
          _ => null,
        } ??
        switch (path) {
          'compare.fileTypes.xliff' => 'XLIFF dosyaları',
          'history.title' => 'Geçmiş',
          'history.recentComparisons' => 'Son Karşılaştırmalar',
          'history.noHistory' => 'Henüz karşılaştırma geçmişi yok',
          'history.noHistoryDescription' =>
            'Karşılaştırma geçmişiniz burada görünecek',
          'history.clearHistory' => 'Geçmişi Temizle',
          'history.clearHistoryConfirm' =>
            'Tüm geçmişi silmek istediğinizden emin misiniz?',
          'history.deleteEntry' => 'Girdiyi Sil',
          'history.openComparison' => 'Karşılaştırmayı Aç',
          'history.timeAgo.justNow' => 'az önce',
          'history.timeAgo.secondsAgo' => ({required Object count}) =>
              '${count} saniye önce',
          'history.timeAgo.oneMinuteAgo' => '1 dakika önce',
          'history.timeAgo.minutesAgo' => ({required Object count}) =>
              '${count} dakika önce',
          'history.timeAgo.oneHourAgo' => '1 saat önce',
          'history.timeAgo.hoursAgo' => ({required Object count}) =>
              '${count} saat önce',
          'history.timeAgo.yesterday' => 'dün',
          'history.timeAgo.daysAgo' => ({required Object count}) =>
              '${count} gün önce',
          'history.timeAgo.oneWeekAgo' => '1 hafta önce',
          'history.timeAgo.weeksAgo' => ({required Object count}) =>
              '${count} hafta önce',
          'history.timeAgo.oneMonthAgo' => '1 ay önce',
          'history.timeAgo.monthsAgo' => ({required Object count}) =>
              '${count} ay önce',
          'history.timeAgo.oneYearAgo' => '1 yıl önce',
          'history.timeAgo.yearsAgo' => ({required Object count}) =>
              '${count} yıl önce',
          'history.timeAgo.inTheFuture' => 'gelecekte',
          'projects.title' => 'Projeler',
          'projects.createProject' => 'Proje Oluştur',
          'projects.importProject' => 'Proje İçe Aktar',
          'projects.noProjects' => 'Henüz proje yok',
          'projects.noProjectsDescription' =>
            'Yerelleştirme dosyalarınızı düzenlemek için bir proje oluşturun',
          'projects.projectName' => 'Proje Adı',
          'projects.projectPath' => 'Proje Yolu',
          'projects.lastOpened' => 'Son açılma',
          'projects.openProject' => 'Projeyi Aç',
          'projects.closeProject' => 'Projeyi Kapat',
          'projects.deleteProject' => 'Projeyi Sil',
          'projects.deleteProjectConfirm' =>
            'Bu projeyi silmek istediğinizden emin misiniz?',
          'projects.exportProject' => 'Projeyi Dışa Aktar',
          'projects.exportDescription' =>
            'Kaynak dosyaları, yapılandırmayı ve geçmişi içeren taşınabilir bir zip dosyası oluşturun.',
          'projects.exporting' => 'Proje dışa aktarılıyor...',
          'projects.exportSuccess' => 'Proje dışa aktarıldı',
          'projects.exportError' => ({required Object error}) =>
              'Dışa aktarma başarısız: ${error}',
          'projects.createNewProject' => 'Yeni Proje Oluştur',
          'projects.openExistingProject' => 'Mevcut Projeyi Aç',
          'projects.importProjectZip' => 'Proje Zip İçe Aktar',
          'projects.projectResources' => 'Proje Kaynakları',
          'projects.recentProjects' => 'Son Projeler',
          'projects.noRecentProjects' => 'Son proje yok',
          'projects.selectProjectZip' => 'Proje Zip Seç',
          'projects.selectDestination' => 'İçe Aktarma için Hedef Klasör Seç',
          'projects.importing' => 'Proje içe aktarılıyor...',
          'projects.importSuccess' => 'Proje başarıyla içe aktarıldı',
          'projects.importFailed' => ({required Object error}) =>
              'İçe aktarma başarısız: ${error}',
          'projects.importingFiles' => 'Dosyalar içe aktarılıyor...',
          'projects.noSupportedFiles' => 'Desteklenen dosya bırakılmadı.',
          'projects.stats.empty' => 'Boş proje',
          'projects.stats.files' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(
                n,
                one: '1 çeviri dosyası',
                other: '${count} çeviri dosyası',
              ),
          'projects.stats.languages' => (
                  {required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(
                n,
                one: '1 dil',
                other: '${count} dil',
              ),
          'projects.openProjectFirst' =>
            'Kaynaklarını yönetmek için önce bir proje açın.',
          'projects.removeFromRecent' => 'Son kullanılanlardan kaldır',
          'projects.selection.selectFolder' => 'Proje Klasörünü Seç',
          'projects.selection.selectArchive' => 'Proje Arşivini Seç',
          'projects.selection.openProject' => 'Projeyi Aç',
          'projects.selection.browseFolder' => 'Klasöre Göz At...',
          'projects.selection.createNew' => 'Yeni Oluştur',
          'projects.selection.importFromZip' => 'Zip\'ten İçe Aktar...',
          'projects.createDialog.title' => 'Proje Oluştur',
          'projects.createDialog.description' =>
            'Bir proje, belirli bir klasör için özel ayarları kaydetmenizi sağlar. Proje yapılandırmanızı saklamak için bir ".localizer" klasörü oluşturulacaktır.',
          'projects.createDialog.folderLabel' => 'Proje Klasörü',
          'projects.createDialog.folderHint' =>
            'Klasör seçmek için tıklayın...',
          'projects.createDialog.nameLabel' => 'Proje Adı',
          'projects.createDialog.nameHint' => 'ör. Uygulamam Çevirileri',
          'projects.createDialog.selectFolderWarning' =>
            'Lütfen bir proje klasörü seçin.',
          'projects.createDialog.enterNameError' =>
            'Lütfen bir proje adı girin',
          'projects.createDialog.nameLengthError' =>
            'Ad en az 2 karakter olmalıdır',
          'projects.createDialog.success' => ({required Object name}) =>
              '"${name}" projesi başarıyla oluşturuldu!',
          'projects.createDialog.failure' => 'Proje oluşturulamadı.',
          'projects.createDialog.creating' => 'Oluşturuluyor...',
          'projects.createDialog.createAction' => 'Proje Oluştur',
          'projects.indicator.tooltipNoProject' =>
            'Bir klasör için özel ayarları kaydetmek üzere proje oluşturun',
          'projects.indicator.tooltipProject' => ({required Object name}) =>
              'Proje: ${name}\nSeçenekleri görmek için tıklayın',
          'projects.indicator.location' => 'Konum',
          'projects.indicator.created' => 'Oluşturulma',
          'projects.indicator.switchProject' => 'Proje Değiştir',
          'projects.indicator.done' => 'Bitti',
          'projects.glossary.title' => 'Proje Sözlüğü',
          'projects.glossary.description' =>
            'Tutarlı bir şekilde ele alınması veya asla çevrilmemesi gereken terimleri tanımlayın.',
          'projects.glossary.noTerms' => 'Henüz sözlük terimi yok.',
          'projects.glossary.noTermsDesc' =>
            'Çeviriler arasında tutarlı kalması gereken terimleri ekleyin\nveya asla çevrilmemesi gereken marka adlarını işaretleyin.',
          'projects.glossary.doNotTranslate' => 'Çevirme',
          'projects.glossary.noSpecificTranslation' => 'Belirli bir çeviri yok',
          'projects.glossary.addTerm' => 'Terim Ekle',
          'projects.glossary.editTerm' => 'Terimi Düzenle',
          'projects.glossary.term' => 'Terim',
          'projects.glossary.termHint' => 'ör. marka adı, uzmanlık terimi',
          'projects.glossary.definition' => 'Tanım (İsteğe Bağlı)',
          'projects.glossary.definitionHint' => 'Çevirmen için bağlam',
          'projects.glossary.doNotTranslateLabel' => 'Çevirme',
          'projects.glossary.doNotTranslateDesc' =>
            'Terimi hedefte olduğu gibi tut',
          'projects.glossary.preferredTranslation' => 'Tercih Edilen Çeviri',
          'projects.glossary.caseSensitive' => 'Büyük/Küçük Harfe Duyarlı',
          'projects.conflicts.missingApiKeyTitle' =>
            ({required Object service}) => '${service} için API anahtarı eksik',
          'projects.conflicts.missingApiKeyMessage' => (
                  {required Object service}) =>
              'Bu proje ${service} kullanıyor ancak yapılandırılmış bir API anahtarı yok. API anahtarınızı Ayarlar > Yapay Zeka Hizmetleri bölümüne ekleyin, aksi takdirde uygulama küresel varsayılanı kullanacaktır.',
          'projects.conflicts.dismiss' => 'Kapat',
          'projects.tm.title' => 'Çeviri Bellekleri',
          'projects.tm.description' =>
            'Bu proje için çeviri belleği kaynaklarını yönetin.',
          'projects.tm.globalTm' => 'Küresel Çeviri Belleği',
          'projects.tm.globalTmDescription' =>
            'Uygulama ayarlarınızdan paylaşılan çeviri belleğini kullanın',
          'projects.tm.linkedFiles' => 'Bağlı Dosyalar (Projeye Özel)',
          'projects.tm.noLinkedFiles' => 'Projeye özel dosya bağlanmadı.',
          'projects.tm.addTmFile' => 'ÇB Dosyası Ekle',
          'projects.tm.useGlobalTm' => 'Küresel ÇB Kullan',
          'projects.tm.selectTm' => 'Çeviri Belleği Seç',
          'projects.tm.globalTmEnabled' =>
            'Küresel Çeviri Belleği etkinleştirildi',
          'diff.added' => 'Eklendi',
          'diff.removed' => 'Kaldırıldı',
          'diff.modified' => 'Değiştirildi',
          'diff.unchanged' => 'Değişmedi',
          'diff.missing' => 'Eksik',
          'diff.extra' => 'Fazla',
          'diff.sourceValue' => 'Kaynak Değer',
          'diff.targetValue' => 'Hedef Değer',
          'diff.key' => 'Anahtar',
          'diff.status' => 'Durum',
          'diff.actions' => 'Eylemler',
          'diff.copyToTarget' => 'Hedefe Kopyala',
          'diff.acceptChange' => 'Değişikliği Kabul Et',
          'diff.rejectChange' => 'Değişikliği Reddet',
          'diff.viewDetails' => 'Ayrıntıları Görüntüle',
          'git.title' => 'Git Karşılaştırması',
          'git.selectRepository' => 'Depo Seç',
          'git.selectBranch' => 'Dal Seç',
          'git.selectCommit' => 'İşleme Seç',
          'git.noRepositories' => 'Git deposu bulunamadı',
          'git.noRepositoriesDescription' =>
            'Dalları veya işlemeleri karşılaştırmak için bir git deposu seçin.',
          'git.compareBranches' => 'Dalları Karşılaştır',
          'git.compareCommits' => 'İşlemeleri Karşılaştır',
          'git.baseBranch' => 'Temel Dal',
          'git.compareBranch' => 'Karşılaştırma Dalı',
          'git.filesChanged' => ({required Object count}) =>
              '${count} dosya değişti',
          'git.additions' => ({required Object count}) => '${count} ekleme',
          'git.deletions' => ({required Object count}) => '${count} silme',
          'git.filterCommitsByBranch' => 'İşlemeleri Dala Göre Filtrele',
          'git.conflicts.title' => 'Birleştirme Çakışmaları Algılandı',
          'git.conflicts.description' =>
            'Devam etmeden önce bu çakışmaları çözmelisiniz.',
          'git.conflicts.abortMergeTitle' => 'Birleştirme İptal Edilsin mi?',
          'git.conflicts.abortMergeContent' =>
            'Bu, tüm birleştirme değişikliklerini geri alacak ve birleştirme öncesi duruma dönecektir. Bu işlem geri alınamaz.',
          'git.conflicts.abortMergeAction' => 'Birleştirmeyi İptal Et',
          'git.conflicts.stagingFile' => ({required Object file}) =>
              '${file} işleme için hazırlanıyor...',
          'git.conflicts.conflictedFilesCount' => ({required Object count}) =>
              'Çakışan Dosyalar (${count})',
          'git.conflicts.selectFileToResolve' => 'Çözmek için bir dosya seçin',
          'git.conflicts.resolvingFile' => ({required Object file}) =>
              'Çözülüyor: ${file}',
          'git.conflicts.keepAllOurs' => 'Tüm Bizimkileri Tut',
          'git.conflicts.acceptAllTheirs' => 'Tüm Onlarınkini Kabul Et',
          'git.conflicts.allResolved' => 'Bu dosyadaki tüm çakışmalar çözüldü!',
          'git.conflicts.markResolved' => 'Çözüldü Olarak İşaretle',
          'git.conflicts.stageForCommit' =>
            'Bu, dosyayı işleme için hazırlayacaktır.',
          'git.conflicts.conflictIndex' => ({required Object index}) =>
              'Çakışma #${index}',
          'git.conflicts.ours' => 'BİZİMKİ (Mevcut)',
          'git.conflicts.theirs' => 'ONLARINKİ (Gelen)',
          'git.conflicts.keepOurs' => 'Bizimkini Tut',
          'git.conflicts.acceptTheirs' => 'Onlarınkini Kabul Et',
          'git.conflicts.empty' => '(Boş)',
          'quality.title' => 'Kalite Panosu',
          'quality.overallScore' => 'Genel Puan',
          'quality.issues' => 'Sorunlar',
          'quality.warnings' => 'Uyarılar',
          'quality.suggestions' => 'Öneriler',
          'quality.placeholderMismatch' => 'Yer Tutucu Uyumsuzluğu',
          'quality.placeholderMismatchDescription' =>
            '{name} gibi yer tutucular kaynak ve hedef arasında eşleşmiyor',
          'quality.lengthOutlier' => 'Uzunluk Sapması',
          'quality.lengthOutlierDescription' =>
            'Çeviri uzunluğu kaynaktan önemli ölçüde farklı',
          'quality.duplicateValue' => 'Yinelenen Değer',
          'quality.duplicateValueDescription' =>
            'Birden fazla anahtar için aynı çeviri kullanılmış',
          'quality.missingTranslation' => 'Eksik Çeviri',
          'quality.missingTranslationDescription' =>
            'Bu anahtar için çeviri eksik',
          'quality.loading' => 'Pano yükleniyor...',
          'quality.errorLoading' => 'Geçmişiniz yüklenemedi. Tekrar deneyin.',
          'quality.emptyState' =>
            'Panonuzu görmek için bir karşılaştırma çalıştırın.',
          'quality.refresh' => 'Yenile',
          'quality.buildingInsights' => 'Analizler oluşturuluyor...',
          'quality.crunchingNumbers' => 'Rakamlar işleniyor...',
          'quality.errorBuilding' => 'Pano oluşturulamadı. Tekrar deneyin.',
          'quality.noUsableData' => 'Henüz kullanılabilir veri bulunamadı.',
          'quality.languages' => 'Diller',
          'quality.averageCoverage' => 'Ortalama kapsam',
          'quality.potentialIssues' => 'Olası sorunlar',
          'quality.translationCoverage' => 'Çeviri kapsamı',
          'quality.entriesTranslated' => (
                  {required Object total, required Object translated}) =>
              '${total} girdiden ${translated} tanesi çevrildi',
          'quality.wordsAddedOverTime' => 'Zamanla eklenen kelimeler',
          'quality.completionVsScope' => 'Tamamlama vs Kapsam',
          'quality.scopeVsProgress' => 'Kapsam vs İlerleme',
          'quality.coveragePercent' => 'Kapsam %',
          'quality.wordsAdded' => 'Eklenen Kelimeler',
          'quality.words' => 'Kelimeler',
          'quality.coverage' => 'Kapsam',
          'quality.scope' => 'Kapsam',
          'quality.latest' => 'En Son',
          'quality.added' => 'Eklendi',
          'quality.change' => 'Değişim',
          'quality.totalScope' => 'Toplam Kapsam',
          'quality.wordsCount' => ({required Object count}) =>
              '${count} kelime',
          'quality.scopeGrowth' => 'Kapsam Büyümesi',
          'quality.range' => 'Aralık',
          'quality.aiUsage' => 'Yapay Zeka ve Çeviri Kullanımı',
          'quality.lastUsed' => ({required Object date}) =>
              'Son kullanım: ${date}',
          'quality.noIssuesFound' => 'Son karşılaştırmalarda sorun bulunamadı.',
          'quality.placeholderMismatches' => 'Yer tutucu uyumsuzlukları',
          'quality.placeholderMismatchesDesc' =>
            '{name} gibi işaretçiler eşleşmiyor.',
          'quality.lengthOutliers' => 'Çok kısa veya uzun çeviriler',
          'quality.lengthOutliersDesc' =>
            'Uzunluk kaynağa kıyasla olağandışı görünüyor.',
          'quality.duplicateValues' => 'Yinelenen değerler',
          'quality.duplicateValuesDesc' =>
            'Aynı çeviri birçok kez kullanılmış.',
          'quality.placeholderDialogTitle' => 'Yer Tutucu Uyumsuzlukları',
          'quality.placeholderDialogDesc' =>
            'Bu çeviriler kaynaktan farklı yer tutucular ({name}) içeriyor.',
          'quality.lengthDialogTitle' => 'Uzunluk Sapmaları',
          'quality.lengthDialogDesc' =>
            'Bu çeviriler kaynaktan önemli ölçüde daha kısa veya daha uzun.',
          'quality.duplicateDialogTitle' => 'Yinelenen Değerler',
          'quality.duplicateDialogDesc' =>
            'Bu çeviriler birden çok kez görünüyor.',
          'quality.duplicateSample' => ({required Object value}) =>
              'Yinelenen: "${value}"',
          'quality.exportError' =>
            'Rapor oluşturulamadı. Lütfen tekrar deneyin.',
          'quality.noDataToExport' => 'Dışa aktarılacak veri yok',
          'quality.exportFailed' => 'Dışa aktarma başarısız',
          'quality.exportDialogTitle' => 'Kalite Raporunu Dışa Aktar',
          'quality.reportSaved' => 'Rapor kaydedildi',
          'quality.export' => 'Export',
          'quality.requests' => 'Requests',
          'quality.tokens' => 'Tokens',
          'quality.characters' => 'Characters',
          'quality.estCost' => 'Tahmini Maliyet',
          'quality.prompt' => 'Prompt',
          'quality.completion' => 'Completion',
          'quality.showingCurrentProject' => 'Gösterilen: Mevcut Proje',
          'quality.showingAllHistory' => 'Gösterilen: Tüm Geçmiş',
          'quality.filesSkipped' => 'Bazı dosyalar bulunamadığı için atlandı.',
          'errors.genericError' => 'Bir hata oluştu',
          'errors.fileNotFound' => 'Dosya bulunamadı',
          'errors.invalidFormat' => 'Geçersiz dosya formatı',
          'errors.parseError' => 'Dosya ayrıştırılamadı',
          'errors.networkError' =>
            'Ağ hatası. Lütfen bağlantınızı kontrol edin.',
          'errors.permissionDenied' => 'İzin reddedildi',
          'errors.unknownError' => 'Bilinmeyen bir hata oluştu',
          'wizards.firstRun.welcome' => 'Localizer\'a Hoş Geldiniz',
          'wizards.firstRun.description' =>
            'Yerelleştirme dosyalarınızı saniyeler içinde karşılaştırın.',
          'wizards.firstRun.sourceFile' => 'Kaynak Dosya',
          'wizards.firstRun.targetFile' => 'Hedef Dosya',
          'wizards.firstRun.compareNow' => 'Şimdi Karşılaştır',
          'wizards.firstRun.trySample' => 'Örnek Veri ile Dene',
          'wizards.firstRun.skip' => 'Kurulumu Atla',
          'wizards.firstRun.browse' => 'Gözat',
          'wizards.firstRun.error' => ({required Object error}) =>
              'Örnek veri yüklenemedi: ${error}',
          'dialogs.addIgnorePattern.title' => 'Yoksayma Deseni Ekle',
          'dialogs.addIgnorePattern.patternLabel' => 'Desen (regex)',
          'dialogs.addIgnorePattern.hint' => 'örn. ^temp_.*',
          'dialogs.addIgnorePattern.invalid' => 'Geçersiz regex deseni',
          'dialogs.addIgnorePattern.testStringLabel' => 'Test Dizisi',
          'dialogs.addIgnorePattern.testHint' =>
            'Desenle test edilecek bir anahtar girin',
          'dialogs.addIgnorePattern.match' =>
            '✓ Desen test dizisiyle eşleşiyor',
          'dialogs.addIgnorePattern.noMatch' => '✗ Desen eşleşmiyor',
          'dialogs.addIgnorePattern.add' => 'Ekle',
          'dialogs.addIgnorePattern.cancel' => 'İptal',
          'dialogs.diffViewer.title' => 'Fark Görüntüleyici',
          'dialogs.diffViewer.originalFile' => 'Orijinal/Referans dosya',
          'dialogs.diffViewer.translationFile' =>
            'Çeviri/Karşılaştırma dosyası',
          'dialogs.diffViewer.base' => 'TEMEL',
          'dialogs.diffViewer.target' => 'HEDEF',
          'dialogs.diffViewer.added' => 'Eklendi',
          'dialogs.diffViewer.removed' => 'Kaldırıldı',
          'dialogs.diffViewer.modified' => 'Değiştirildi',
          'dialogs.diffViewer.noMatches' =>
            'Geçerli filtrelerle eşleşen kayıt yok',
          'dialogs.diffViewer.clickToggle' =>
            'Filtreleri değiştirmek için yukarıdaki rozetlere tıklayın',
          'dialogs.diffViewer.clickToHide' => '(gizlemek için tıkla)',
          'dialogs.diffViewer.clickToShow' => '(göstermek için tıkla)',
          'grid.columns.key' => 'ANAHTAR',
          'grid.columns.source' => 'KAYNAK',
          'grid.columns.actions' => 'İŞLEMLER',
          'grid.columns.status' => '#',
          'tutorial.skipTutorial' => 'ÖĞRETİCİYİ ATLA',
          'tutorial.finishMessage' =>
            'Hazırsınız! Bitirmek için herhangi bir yere dokunun.',
          'tutorial.next' => 'İleri',
          'tutorial.loadSampleData' => 'Örnek Veri Yükle',
          'tutorial.browseSourceFile' => 'Kaynak Dosya Seç',
          'tutorial.browseTargetFile' => 'Hedef Dosya Seç',
          'tutorial.compareFiles' => 'Dosyaları Karşılaştır',
          'tutorial.hintPhase2' =>
            'Sonraki: filtreler, arama, gelişmiş görünüm ve dışa aktarma.',
          'tutorial.steps.importSource.title' => '1. Kaynak Dosyayı İçe Aktar',
          'tutorial.steps.importSource.description' =>
            'Dosya seçmek için aşağıdaki düğmeyi kullanın veya vurgulanan alana sürükleyip bırakın.',
          'tutorial.steps.importTarget.title' => '2. Hedef Dosyayı İçe Aktar',
          'tutorial.steps.importTarget.description' =>
            'Dosya seçmek için aşağıdaki düğmeyi kullanın veya vurgulanan alana sürükleyip bırakın.',
          'tutorial.steps.compare.title' => '3. Dosyaları Karşılaştır',
          'tutorial.steps.compare.description' =>
            'Karşılaştırmayı çalıştırmak ve sonuçları görmek için aşağıdaki düğmeye dokunun.',
          'tutorial.steps.filter.title' => '4. Sonuçları Filtrele',
          'tutorial.steps.filter.description' =>
            'Eklenen, Kaldırılan veya Değiştirilen dizileri görüntülemek için bu filtreleri kullanın.',
          'tutorial.steps.search.title' => '5. Sonuçlarda Ara',
          'tutorial.steps.search.description' =>
            'Arama çubuğunu kullanarak belirli anahtarları veya değerleri bulun.',
          'tutorial.steps.advanced.title' => '6. Gelişmiş Görünüm',
          'tutorial.steps.advanced.description' =>
            'Düzenleme, yapay zeka çevirisi ve daha fazlası ile ayrıntılı fark görünümünü açın.',
          'tutorial.steps.export.title' => '7. Sonuçları Dışa Aktar',
          'tutorial.steps.export.description' =>
            'Karşılaştırmanızı CSV, JSON veya Excel dosyası olarak kaydedin.',
          'friendlyErrors.fileNotFound.message' =>
            'Dosya veya klasör bulunamadı.',
          'friendlyErrors.fileNotFound.suggestion' =>
            'Dosyanın taşınmış veya silinmiş olup olmadığını kontrol edin.',
          'friendlyErrors.accessDenied.message' => 'Dosyaya erişim reddedildi.',
          'friendlyErrors.accessDenied.suggestion' =>
            'Uygulamayı yönetici olarak çalıştırmayı veya dosya izinlerini kontrol etmeyi deneyin.',
          'friendlyErrors.isDirectory.message' =>
            'Dosya yerine bir klasör seçildi.',
          'friendlyErrors.isDirectory.suggestion' =>
            'Lütfen geçerli bir dosya seçin.',
          'friendlyErrors.fileAccess.message' =>
            'Dosyaya erişimde bir sorun oluştu.',
          'friendlyErrors.fileAccess.suggestion' =>
            'Dosyayı kullanıyor olabilecek diğer programları kapatmayı deneyin.',
          'friendlyErrors.unsupportedFormat.message' =>
            'Bu dosya formatı veya işlem desteklenmiyor.',
          'friendlyErrors.unsupportedFormat.suggestion' =>
            'Dosya uzantısını kontrol edin veya farklı bir format deneyin.',
          'friendlyErrors.networkError.message' => 'Sunucuya bağlanılamadı.',
          'friendlyErrors.networkError.suggestion' =>
            'İnternet bağlantınızı kontrol edin ve tekrar deneyin.',
          'friendlyErrors.notGitRepo.message' =>
            'Bu klasör bir Git projesi değil.',
          'friendlyErrors.notGitRepo.suggestion' =>
            '.git dizini içeren bir klasöre gidin.',
          'friendlyErrors.mergeConflict.message' =>
            'Depoda birleştirme çakışmaları var.',
          'friendlyErrors.mergeConflict.suggestion' =>
            'Devam etmeden önce çakışmaları çözün.',
          'friendlyErrors.gitAuthFailed.message' =>
            'Git kimlik doğrulaması başarısız oldu.',
          'friendlyErrors.gitAuthFailed.suggestion' =>
            'Ayarlar > Sürüm Kontrolü\'nde kimlik bilgilerinizi kontrol edin.',
          'friendlyErrors.gitOperationFailed.message' =>
            'Bir Git işlemi başarısız oldu.',
          'friendlyErrors.gitOperationFailed.suggestion' =>
            'Daha fazla ayrıntı için Git görünümünü kontrol edin.',
          'friendlyErrors.invalidJson.message' =>
            'Dosya formatı geçersiz veya bozuk.',
          'friendlyErrors.invalidJson.suggestion' =>
            'Dosyanın geçerli JSON içeriği içerdiğinden emin olun.',
          'friendlyErrors.rateLimitReached.message' => 'Çeviri limiti aşıldı.',
          'friendlyErrors.rateLimitReached.suggestion' =>
            'Birkaç dakika bekleyin veya API plan limitinizi kontrol edin.',
          'friendlyErrors.invalidApiKey.message' => 'Geçersiz API anahtarı.',
          'friendlyErrors.invalidApiKey.suggestion' =>
            'API anahtarınızı güncellemek için Ayarlar > Yapay Zeka Çevirisi\'ne gidin.',
          'friendlyErrors.translationServiceError.message' =>
            'Çeviri servisi hatası.',
          'friendlyErrors.translationServiceError.suggestion' =>
            'API anahtarınızı ve internet bağlantınızı kontrol edin.',
          'friendlyErrors.outOfMemory.message' =>
            'Bu işlemi tamamlamak için yeterli bellek yok.',
          'friendlyErrors.outOfMemory.suggestion' =>
            'Diğer uygulamaları kapatmayı veya daha küçük dosyalar kullanmayı deneyin.',
          'friendlyErrors.genericError.message' => 'Bir şeyler yanlış gitti.',
          'friendlyErrors.genericError.suggestion' =>
            'Lütfen tekrar deneyin. Sorun devam ederse uygulamayı yeniden başlatın.',
          'systemTray.showLocalizer' => 'Localizer\'ı Göster',
          'systemTray.exit' => 'Çıkış',
          'validation.connected' => 'Bağlandı.',
          'validation.connectionTimeout' =>
            'Bağlantı zaman aşımına uğradı. Lütfen tekrar deneyin.',
          'validation.couldNotConnect' =>
            'Bağlanılamadı. Lütfen tekrar deneyin.',
          'validation.checkKeyAndTryAgain' =>
            'Bağlanılamadı. Lütfen anahtarı kontrol edin ve tekrar deneyin.',
          'validation.tryAgainLater' =>
            'Şu anda bağlanılamıyor. Lütfen daha sonra tekrar deneyin.',
          'validation.serviceUnavailable' =>
            'Servis şu anda kullanılamıyor. Lütfen daha sonra tekrar deneyin.',
          'validation.enterKeyFirst' => 'Lütfen önce bir anahtar girin.',
          'validation.checking' => 'Kontrol ediliyor...',
          'validation.deeplUsage' => (
                  {required Object used, required Object limit}) =>
              'Kullanım: ${used} / ${limit} karakter.',
          'status.startingComparison' => 'Karşılaştırma başlatılıyor...',
          'status.loadingFromHistory' => 'Geçmişten dosyalar yükleniyor...',
          'status.comparisonComplete' => 'Karşılaştırma tamamlandı',
          'status.couldNotImportFiles' =>
            'Dosyalar içe aktarılamadı. Lütfen tekrar deneyin.',
          'status.historyFilesNotFound' =>
            'Geçmişteki dosyalardan biri veya her ikisi orijinal yollarında bulunamadı.',
          'aiServices.geminiEmptyResponse' => 'Gemini boş yanıt döndürdü',
          'aiServices.geminiStreamingEmpty' =>
            'Gemini akışı boş yanıt döndürdü',
          'aiServices.geminiRephraseEmpty' =>
            'Gemini yeniden ifadelendirme için boş yanıt döndürdü',
          'aiServices.openaiEmptyResponse' =>
            'OpenAI boş veya başarısız yanıt döndürdü',
          _ => null,
        };
  }
}
