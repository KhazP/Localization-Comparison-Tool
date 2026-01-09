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
class TranslationsRu
    with BaseTranslations<AppLocale, Translations>
    implements Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsRu(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.ru,
              overrides: overrides ?? {},
              cardinalResolver: cardinalResolver,
              ordinalResolver: ordinalResolver,
            ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <ru>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final TranslationsRu _root = this; // ignore: unused_field

  @override
  TranslationsRu $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsRu(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsAppRu app = _TranslationsAppRu._(_root);
  @override
  late final _TranslationsCommonRu common = _TranslationsCommonRu._(_root);
  @override
  late final _TranslationsMenuRu menu = _TranslationsMenuRu._(_root);
  @override
  late final _TranslationsNavRu nav = _TranslationsNavRu._(_root);
  @override
  late final _TranslationsSettingsRu settings =
      _TranslationsSettingsRu._(_root);
  @override
  late final _TranslationsFileComparisonRu fileComparison =
      _TranslationsFileComparisonRu._(_root);
  @override
  late final _TranslationsDirectoryComparisonRu directoryComparison =
      _TranslationsDirectoryComparisonRu._(_root);
  @override
  late final _TranslationsCompareRu compare = _TranslationsCompareRu._(_root);
  @override
  late final _TranslationsHistoryRu history = _TranslationsHistoryRu._(_root);
  @override
  late final _TranslationsProjectsRu projects =
      _TranslationsProjectsRu._(_root);
  @override
  late final _TranslationsDiffRu diff = _TranslationsDiffRu._(_root);
  @override
  late final _TranslationsGitComparisonRu gitComparison =
      _TranslationsGitComparisonRu._(_root);
  @override
  late final _TranslationsGitRu git = _TranslationsGitRu._(_root);
  @override
  late final _TranslationsQualityRu quality = _TranslationsQualityRu._(_root);
  @override
  late final _TranslationsErrorsRu errors = _TranslationsErrorsRu._(_root);
  @override
  late final _TranslationsWizardsRu wizards = _TranslationsWizardsRu._(_root);
  @override
  late final _TranslationsDialogsRu dialogs = _TranslationsDialogsRu._(_root);
  @override
  late final _TranslationsGridRu grid = _TranslationsGridRu._(_root);
  @override
  late final _TranslationsAdvancedComparisonRu advancedComparison =
      _TranslationsAdvancedComparisonRu._(_root);
  @override
  late final _TranslationsAdvancedDiffRu advancedDiff =
      _TranslationsAdvancedDiffRu._(_root);
  @override
  late final _TranslationsIssueDetailsRu issueDetails =
      _TranslationsIssueDetailsRu._(_root);
  @override
  late final _TranslationsImportReviewRu importReview =
      _TranslationsImportReviewRu._(_root);
  @override
  late final _TranslationsHistoryViewRu historyView =
      _TranslationsHistoryViewRu._(_root);
  @override
  late final _TranslationsTutorialRu tutorial =
      _TranslationsTutorialRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsRu friendlyErrors =
      _TranslationsFriendlyErrorsRu._(_root);
  @override
  late final _TranslationsSystemTrayRu systemTray =
      _TranslationsSystemTrayRu._(_root);
  @override
  late final _TranslationsValidationRu validation =
      _TranslationsValidationRu._(_root);
  @override
  late final _TranslationsStatusRu status = _TranslationsStatusRu._(_root);
  @override
  late final _TranslationsAiServicesRu aiServices =
      _TranslationsAiServicesRu._(_root);
}

// Path: app
class _TranslationsAppRu implements TranslationsAppEn {
  _TranslationsAppRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Инструмент сравнения локализации';
  @override
  String get name => 'Localizer';
}

// Path: common
class _TranslationsCommonRu implements TranslationsCommonEn {
  _TranslationsCommonRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get save => 'Сохранить';
  @override
  String get cancel => 'Отмена';
  @override
  String get close => 'Закрыть';
  @override
  String get delete => 'Удалить';
  @override
  String get edit => 'Редактировать';
  @override
  String get add => 'Добавить';
  @override
  String get search => 'Поиск';
  @override
  String get undo => 'Отменить';
  @override
  String get loading => 'Загрузка...';
  @override
  String get error => 'Ошибка';
  @override
  String get success => 'Успешно';
  @override
  String get warning => 'Предупреждение';
  @override
  String get info => 'Информация';
  @override
  String get confirm => 'Подтвердить';
  @override
  String get yes => 'Да';
  @override
  String get no => 'Нет';
  @override
  String get ok => 'ОК';
  @override
  String get retry => 'Повторить';
  @override
  String get copyText => 'Копировать';
  @override
  String get appName => 'Localizer';
  @override
  String get copied => 'Скопировано!';
  @override
  String get enabled => 'Включено';
  @override
  String get disabled => 'Отключено';
  @override
  String get browse => 'Обзор';
  @override
  String get clear => 'Очистить';
  @override
  String get apply => 'Применить';
  @override
  String get reset => 'Сброс';
  @override
  String get refresh => 'Обновить';
  @override
  String get export => 'Экспорт';
  @override
  String get import => 'Импорт';
  @override
  String get select => 'Выбрать';
  @override
  String get selectAll => 'Выбрать все';
  @override
  String get deselectAll => 'Снять выделение';
  @override
  String get noResults => 'Результаты не найдены';
  @override
  String get emptyState => 'Пока ничего нет';
  @override
  String get open => 'Открыть';
  @override
  String get change => 'Изменить';
  @override
  String get original => 'Оригинал';
  @override
  String get kNew => 'Новый';
  @override
  String get remove => 'Удалить';
  @override
  String get auto => 'Авто';
  @override
  String get execute => 'Выполнить';
  @override
  String get run => 'Запустить';
  @override
  String get unknown => 'Неизвестно';
  @override
  String get download => 'Скачать';
  @override
  String get dropdownArrow => 'Стрелка выпадающего списка';
  @override
  String get openInNewWindow => 'Открывается в новом окне';
  @override
  String get resetToDefaults => 'Сбросить настройки';
}

// Path: menu
class _TranslationsMenuRu implements TranslationsMenuEn {
  _TranslationsMenuRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get file => 'Файл';
  @override
  String get edit => 'Редактирование';
  @override
  String get view => 'Вид';
  @override
  String get help => 'Справка';
  @override
  String get openFiles => 'Открыть файлы...';
  @override
  String get openFolder => 'Открыть папку...';
  @override
  String get exportResults => 'Экспортировать результаты...';
  @override
  String get undo => 'Отменить';
  @override
  String get redo => 'Повторить';
  @override
  String get cut => 'Вырезать';
  @override
  String get paste => 'Вставить';
  @override
  String get selectAll => 'Выбрать все';
  @override
  String get zoomIn => 'Увеличить';
  @override
  String get zoomOut => 'Уменьшить';
  @override
  String get resetZoom => 'Сбросить масштаб';
  @override
  String get documentation => 'Документация';
  @override
  String get reportIssue => 'Сообщить о проблеме';
  @override
  String about({required Object appName}) => 'О программе ${appName}';
}

// Path: nav
class _TranslationsNavRu implements TranslationsNavEn {
  _TranslationsNavRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get compare => 'Сравнение';
  @override
  String get history => 'История';
  @override
  String get settings => 'Настройки';
  @override
  String get projects => 'Проекты';
  @override
  String get dashboard => 'Качество';
  @override
  String get directory => 'Каталог';
  @override
  String get repository => 'Репозиторий';
  @override
  String get tooltipCompare => 'Сравнить файлы локализации';
  @override
  String get tooltipHistory => 'Просмотр истории сравнений';
  @override
  String get tooltipSettings => 'Настройки приложения';
  @override
  String get tooltipProjects => 'Управление проектами';
  @override
  String get tooltipThemeToggle => 'Переключить тему';
  @override
  String get tooltipDebugConsole => 'Консоль отладки';
}

// Path: settings
class _TranslationsSettingsRu implements TranslationsSettingsEn {
  _TranslationsSettingsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Настройки';
  @override
  String get appSettings => 'Настройки приложения';
  @override
  String get projectSettings => 'Настройки проекта';
  @override
  late final _TranslationsSettingsAppearanceRu appearance =
      _TranslationsSettingsAppearanceRu._(_root);
  @override
  late final _TranslationsSettingsGeneralRu general =
      _TranslationsSettingsGeneralRu._(_root);
  @override
  late final _TranslationsSettingsScopeRu scope =
      _TranslationsSettingsScopeRu._(_root);
  @override
  late final _TranslationsSettingsSearchKeywordsRu searchKeywords =
      _TranslationsSettingsSearchKeywordsRu._(_root);
  @override
  late final _TranslationsSettingsComparisonRu comparison =
      _TranslationsSettingsComparisonRu._(_root);
  @override
  late final _TranslationsSettingsFileHandlingRu fileHandling =
      _TranslationsSettingsFileHandlingRu._(_root);
  @override
  late final _TranslationsSettingsTranslationMemoryRu translationMemory =
      _TranslationsSettingsTranslationMemoryRu._(_root);
  @override
  late final _TranslationsSettingsBackupRu backup =
      _TranslationsSettingsBackupRu._(_root);
  @override
  late final _TranslationsSettingsAiRu ai = _TranslationsSettingsAiRu._(_root);
  @override
  late final _TranslationsSettingsIntegrationsRu integrations =
      _TranslationsSettingsIntegrationsRu._(_root);
  @override
  late final _TranslationsSettingsDeveloperRu developer =
      _TranslationsSettingsDeveloperRu._(_root);
  @override
  late final _TranslationsSettingsAboutRu about =
      _TranslationsSettingsAboutRu._(_root);
  @override
  late final _TranslationsSettingsOnboardingRu onboarding =
      _TranslationsSettingsOnboardingRu._(_root);
  @override
  late final _TranslationsSettingsSettingsViewRu settingsView =
      _TranslationsSettingsSettingsViewRu._(_root);
}

// Path: fileComparison
class _TranslationsFileComparisonRu implements TranslationsFileComparisonEn {
  _TranslationsFileComparisonRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Сравнение файлов';
  @override
  String get openFiles => 'Открыть файлы';
  @override
  String get exportResults => 'Экспортировать результаты';
  @override
  String get restartTutorial => 'Перезапустить обучение';
  @override
  String get restartTutorialDevOnly =>
      'Перезапуск обучения доступен только в режиме разработчика.';
  @override
  String get unsupportedFileType => 'Неподдерживаемый тип файла.';
  @override
  String get unsupportedFileTypeSuggestion =>
      'Выберите поддерживаемый файл локализации.';
  @override
  String get someFilesUnsupported => 'Некоторые файлы не поддерживаются.';
  @override
  String get pickSupportedFiles =>
      'Выберите только поддерживаемые файлы локализации.';
  @override
  String get pickTwoFiles => 'Выберите два файла для сравнения.';
  @override
  String get pickBilingualFile => 'Выберите двуязычный файл для сравнения.';
  @override
  String get noResultsToExport => 'Нет результатов для экспорта.';
  @override
  String get performComparisonFirst =>
      'Сначала выполните сравнение для экспорта результатов.';
  @override
  String get performComparisonFirstEditor =>
      'Сначала выполните сравнение для просмотра расширенных деталей.';
  @override
  String get sampleDataLoaded => 'Примеры данных успешно загружены';
  @override
  String loadSampleDataError({required Object error}) =>
      'Не удалось загрузить примеры данных: ${error}';
  @override
  String get invalidFileType => 'Неверный тип файла.';
  @override
  String fileSelected({required Object label, required Object fileName}) =>
      '${label} выбран: ${fileName}';
  @override
  String get sourceFile => 'Исходный файл';
  @override
  String get targetFile => 'Целевой файл';
  @override
  String get bilingualFile => 'Двуязычный файл';
  @override
  String get compareFiles => 'Сравнить файлы';
  @override
  String get compareFile => 'Сравнить файл';
  @override
  String get bilingualMode => 'Двуязычный режим';
  @override
  String get twoFilesMode => 'Два файла';
  @override
  String get processing => 'Обработка...';
  @override
  String remaining({required Object time}) => 'Осталось ${time}';
  @override
  String get comparisonInProgress => 'Сравнение в процессе...';
  @override
  String comparisonFailed({required Object error}) =>
      'Ошибка сравнения: ${error}';
  @override
  String fileChanged({required Object fileName}) =>
      'Файл изменён: ${fileName}. Повторное сравнение...';
  @override
  String get dropFileHere => 'Перетащите файл сюда';
  @override
  String get dropFileOrBrowse => 'Перетащите файл или нажмите для выбора';
  @override
  String get fileUpload => 'Загрузить файл';
  @override
  String get changeFile => 'Изменить файл';
  @override
  String get total => 'Всего';
  @override
  String get show => 'Показать';
  @override
  String get showAll => 'Показать все';
  @override
  String noMatches({required Object query}) =>
      'Совпадений для "${query}" не найдено';
  @override
  String showingEntries({required Object count, required Object total}) =>
      'Показано ${count} из ${total} записей';
  @override
  String get filesIdentical => 'Файлы идентичны.';
  @override
  String hiddenIdentical({required Object count}) =>
      '${count} идентичных записей скрыто';
  @override
  String get showIdentical => 'Показать идентичные записи';
  @override
  String get hideIdentical => 'Скрыть идентичные записи';
  @override
  String get noDiff => 'Различия по ключам не найдены.';
  @override
  String get source => 'Источник';
  @override
  String get target => 'Цель';
  @override
  String get value => 'Значение';
  @override
  String get readyToCompare => 'Готово к сравнению файлов';
  @override
  String get readyToCompareDesc =>
      'Перетащите файлы локализации выше или используйте кнопки обзора\nдля выбора файлов для сравнения.';
  @override
  String get recentComparisons => 'Недавние сравнения';
  @override
  String bilingualFileLabel({required Object name}) =>
      'Двуязычный файл: ${name}';
  @override
  String comparisonLabel({required Object source, required Object target}) =>
      '${source} ↔ ${target}';
  @override
  String get fileNotExist =>
      'Один или оба файла из этой сессии больше не существуют.';
  @override
  String get largeFileTitle => 'Обнаружен большой файл';
  @override
  String largeFileContent({required Object count}) =>
      'Результат сравнения содержит ${count} записей.\nОтображение всех может вызвать проблемы с производительностью.\n\nПродолжить?';
  @override
  String get dontShowAgain => 'Больше не показывать для этого файла';
  @override
  String get proceed => 'Продолжить';
  @override
  String exportReport({required Object format}) => 'Сохранить отчёт ${format}';
  @override
  String saved({required Object format}) => '${format} сохранён';
  @override
  String saveError({required Object format}) =>
      'Не удалось сохранить файл ${format}.';
  @override
  String saveErrorDetailed({required Object format, required Object error}) =>
      'Не удалось сохранить ${format}: ${error}';
  @override
  String get watching => 'Отслеживание';
  @override
  String get watchOff => 'Отслеживание выкл.';
  @override
  String watchingTooltip({required Object status}) =>
      'Отслеживание файлов: ${status}\nАвтоматическое повторное сравнение при изменении файлов на диске';
  @override
  String get aiSettingsNotAvailable => 'Переход к настройкам ИИ недоступен';
}

// Path: directoryComparison
class _TranslationsDirectoryComparisonRu
    implements TranslationsDirectoryComparisonEn {
  _TranslationsDirectoryComparisonRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Сравнение каталогов';
  @override
  String get sourceDirectory => 'Исходный каталог';
  @override
  String get targetDirectory => 'Целевой каталог';
  @override
  String get sourceSubtitle => 'Оригинальные/справочные файлы';
  @override
  String get targetSubtitle => 'Файлы перевода/сравнения';
  @override
  String get selectBothDirectories => 'Выберите исходный и целевой каталоги.';
  @override
  String get selectSourceFolder => 'Выбрать исходную папку';
  @override
  String get selectTargetFolder => 'Выбрать целевую папку';
  @override
  String get dropFolderHere => 'Перетащите папку сюда или выберите...';
  @override
  String get folderPath => 'Путь к папке';
  @override
  String get readyToCompare => 'Готово к сравнению каталогов';
  @override
  String get readyToCompareDesc =>
      'Перетащите папки выше или используйте кнопки обзора\nдля выбора каталогов для сравнения.';
  @override
  String get nestedFolders => 'Вложенные папки';
  @override
  String get nestedFoldersTooltip =>
      'Рекурсивное сравнение всех вложенных каталогов';
  @override
  String get fileMatching => 'Сопоставление файлов';
  @override
  String get fileMatchingTooltip =>
      'Автоматическое сопоставление файлов по имени';
  @override
  String get bulkExport => 'Пакетный экспорт';
  @override
  String get bulkExportTooltip => 'Экспорт всех результатов сравнения сразу';
  @override
  String get notDirectoryComparison => 'Это не сравнение каталогов.';
  @override
  String get directoriesNotExist =>
      'Один или оба каталога больше не существуют.';
  @override
  String get errorOccurred => 'Произошла ошибка';
  @override
  String get noFilesFound => 'Файлы в выбранных каталогах не найдены.';
  @override
  String get unmatchedSourceFiles => 'Несопоставленные исходные файлы';
  @override
  String get unmatchedTargetFiles => 'Несопоставленные целевые файлы';
  @override
  String filePairs({required Object count}) => '${count} пар файлов';
  @override
  String pairedFiles({required Object count}) =>
      'Сопоставленные файлы (${count})';
  @override
  String get view => 'Просмотр';
  @override
  String get failed => 'Ошибка';
  @override
  String get pair => 'Сопоставить...';
  @override
  String pairDialogTitle({required Object name}) => 'Сопоставить "${name}" с:';
  @override
  String get discoverFiles => 'Обнаружить файлы';
  @override
  String get compareAll => 'Сравнить все';
  @override
  String get exportAll => 'Экспортировать все';
  @override
  String get comparisonStarted => 'Сравнение начато...';
  @override
  String get discoveringFiles => 'Обнаружение файлов...';
  @override
  String get noResultsToExport =>
      'Нет результатов для экспорта. Сначала выполните "Сравнить все".';
  @override
  String get selectExportFolder => 'Выберите папку для экспорта';
  @override
  String createExportFolderError({required Object error}) =>
      'Не удалось создать папку экспорта: ${error}';
  @override
  String get exportingResults => 'Экспорт результатов';
  @override
  String processingFile({required Object file}) => 'Обработка: ${file}';
  @override
  String exportProgress({required Object current, required Object total}) =>
      'Экспортировано ${current} из ${total} файлов';
  @override
  String get exportComplete => 'Экспорт завершён';
  @override
  String exportSuccessMessage({required Object count}) =>
      'Успешно экспортировано ${count} файлов сравнения и сводка.';
  @override
  String exportFailed({required Object error}) => 'Ошибка экспорта: ${error}';
  @override
  String get close => 'Закрыть';
}

// Path: compare
class _TranslationsCompareRu implements TranslationsCompareEn {
  _TranslationsCompareRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Сравнить файлы';
  @override
  String get sourceFile => 'Исходный файл';
  @override
  String get targetFile => 'Целевой файл';
  @override
  String get sourceFolder => 'Исходная папка';
  @override
  String get targetFolder => 'Целевая папка';
  @override
  String get dropFilesHint =>
      'Перетащите файлы локализации сюда или используйте кнопки обзора.';
  @override
  String get selectSourceFile => 'Выберите исходный файл';
  @override
  String get selectTargetFile => 'Выберите целевой файл';
  @override
  String get startComparison => 'Начать сравнение';
  @override
  String get comparing => 'Сравнение...';
  @override
  String get comparisonComplete => 'Сравнение завершено';
  @override
  String get noChanges => 'Изменений не обнаружено';
  @override
  String get filesIdentical => 'Файлы идентичны';
  @override
  String changesFound({required Object count}) => 'Найдено ${count} изменений';
  @override
  late final _TranslationsCompareTabsRu tabs =
      _TranslationsCompareTabsRu._(_root);
  @override
  late final _TranslationsCompareFileTypesRu fileTypes =
      _TranslationsCompareFileTypesRu._(_root);
}

// Path: history
class _TranslationsHistoryRu implements TranslationsHistoryEn {
  _TranslationsHistoryRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'История';
  @override
  String get recentComparisons => 'Недавние сравнения';
  @override
  String get noHistory => 'История сравнений пуста';
  @override
  String get noHistoryDescription => 'Здесь появится история ваших сравнений';
  @override
  String get clearHistory => 'Очистить историю';
  @override
  String get clearHistoryConfirm =>
      'Вы уверены, что хотите очистить всю историю?';
  @override
  String get deleteEntry => 'Удалить запись';
  @override
  String get openComparison => 'Открыть сравнение';
  @override
  late final _TranslationsHistoryTimeAgoRu timeAgo =
      _TranslationsHistoryTimeAgoRu._(_root);
}

// Path: projects
class _TranslationsProjectsRu implements TranslationsProjectsEn {
  _TranslationsProjectsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Проекты';
  @override
  String get createProject => 'Создать проект';
  @override
  String get importProject => 'Импортировать проект';
  @override
  String get noProjects => 'Проектов пока нет';
  @override
  String get noProjectsDescription =>
      'Создайте проект для организации файлов локализации';
  @override
  String get projectName => 'Название проекта';
  @override
  String get projectPath => 'Путь к проекту';
  @override
  String get lastOpened => 'Открыт';
  @override
  String get openProject => 'Открыть проект';
  @override
  String get closeProject => 'Закрыть проект';
  @override
  String get deleteProject => 'Удалить проект';
  @override
  String get deleteProjectConfirm =>
      'Вы уверены, что хотите удалить этот проект?';
  @override
  String get exportProject => 'Экспорт проекта';
  @override
  String get exportDescription =>
      'Создать zip-архив с файлами, настройками и историей.';
  @override
  String get exporting => 'Экспорт проекта...';
  @override
  String get exportSuccess => 'Проект экспортирован';
  @override
  String exportError({required Object error}) => 'Ошибка экспорта: ${error}';
  @override
  String get createNewProject => 'Создать новый проект';
  @override
  String get openExistingProject => 'Открыть существующий проект';
  @override
  String get importProjectZip => 'Импорт проекта из Zip';
  @override
  String get projectResources => 'Ресурсы проекта';
  @override
  String get recentProjects => 'Недавние проекты';
  @override
  String get noRecentProjects => 'Нет недавних проектов';
  @override
  String get selectProjectZip => 'Выбрать Zip проекта';
  @override
  String get selectDestination => 'Выбрать папку назначения для импорта';
  @override
  String get importing => 'Импорт проекта...';
  @override
  String get importSuccess => 'Проект успешно импортирован';
  @override
  String importFailed({required Object error}) => 'Ошибка импорта: ${error}';
  @override
  String get importingFiles => 'Импорт файлов...';
  @override
  String get noSupportedFiles => 'Поддерживаемые файлы не найдены.';
  @override
  late final _TranslationsProjectsStatsRu stats =
      _TranslationsProjectsStatsRu._(_root);
  @override
  String get openProjectFirst =>
      'Сначала откройте проект для управления ресурсами.';
  @override
  String get removeFromRecent => 'Удалить из недавних';
  @override
  late final _TranslationsProjectsSelectionRu selection =
      _TranslationsProjectsSelectionRu._(_root);
  @override
  late final _TranslationsProjectsCreateDialogRu createDialog =
      _TranslationsProjectsCreateDialogRu._(_root);
  @override
  late final _TranslationsProjectsIndicatorRu indicator =
      _TranslationsProjectsIndicatorRu._(_root);
  @override
  late final _TranslationsProjectsGlossaryRu glossary =
      _TranslationsProjectsGlossaryRu._(_root);
  @override
  late final _TranslationsProjectsConflictsRu conflicts =
      _TranslationsProjectsConflictsRu._(_root);
  @override
  late final _TranslationsProjectsTmRu tm = _TranslationsProjectsTmRu._(_root);
}

// Path: diff
class _TranslationsDiffRu implements TranslationsDiffEn {
  _TranslationsDiffRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'Добавлено';
  @override
  String get removed => 'Удалено';
  @override
  String get modified => 'Изменено';
  @override
  String get unchanged => 'Без изменений';
  @override
  String get missing => 'Отсутствует';
  @override
  String get extra => 'Лишнее';
  @override
  String get sourceValue => 'Исходное значение';
  @override
  String get targetValue => 'Целевое значение';
  @override
  String get key => 'Ключ';
  @override
  String get status => 'Статус';
  @override
  String get actions => 'Действия';
  @override
  String get copyToTarget => 'Копировать в цель';
  @override
  String get acceptChange => 'Принять изменение';
  @override
  String get rejectChange => 'Отклонить изменение';
  @override
  String get viewDetails => 'Показать детали';
}

// Path: gitComparison
class _TranslationsGitComparisonRu implements TranslationsGitComparisonEn {
  _TranslationsGitComparisonRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'Git-термины (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) должны оставаться на английском языке во всех переводах, чтобы избежать путаницы среди разработчиков.';
  @override
  String get title => 'Сравнение репозитория';
  @override
  String get repoSelector => 'Создать / Открыть репозиторий';
  @override
  String get noRepoSelected => 'Репозиторий не выбран';
  @override
  String get open => 'Открыть';
  @override
  String get refreshCommits => 'Обновить Commits';
  @override
  String get noCommits =>
      'Commits не найдены или не загружены. Выберите Branch для загрузки Commits.';
  @override
  String get baseCommit => 'Базовый Commit (старый)';
  @override
  String get targetCommit => 'Целевой Commit (новый)';
  @override
  String get filterCommitsByBranch => 'Фильтр Commits по Branch';
  @override
  String get conflictDetection => 'Обнаружение Conflicts';
  @override
  String get conflictDetectionTooltip =>
      'Обнаружение и разрешение Merge Conflicts';
  @override
  String get actions => 'Действия:';
  @override
  String get checkout => 'Checkout';
  @override
  String get merge => 'Merge';
  @override
  String get pull => 'Pull';
  @override
  String get checkoutBranch => 'Checkout Branch';
  @override
  String get mergeBranch => 'Merge Branch в текущий';
  @override
  String mergeConfirmation({required Object branch}) => 'Merge ${branch}?';
  @override
  String get mergeWarning =>
      'Это выполнит Merge изменений в вашу текущую рабочую Branch. Могут возникнуть Conflicts.';
  @override
  String get selectExportFolder => 'Выберите папку для экспорта';
  @override
  String createExportFolderError({required Object error}) =>
      'Не удалось создать папку экспорта: ${error}';
  @override
  String get exportingFiles => 'Экспорт файлов';
  @override
  String processingFile({required Object file}) => 'Обработка: ${file}';
  @override
  String exportProgress({required Object current, required Object total}) =>
      'Экспортировано ${current} из ${total} файлов';
  @override
  String get exportComplete => 'Экспорт завершён';
  @override
  String exportSuccessMessage({required Object count}) =>
      'Успешно экспортировано ${count} файлов с полным содержимым.';
  @override
  String get exportDetail => 'Diff каждого файла сохранён в подпапке "files".';
  @override
  String get diffViewer => 'Просмотр Diff';
  @override
  String get base => 'BASE';
  @override
  String get target => 'TARGET';
  @override
  String get noLines => 'Нет строк для отображения';
  @override
  String get searchFiles => 'Поиск файлов...';
  @override
  String noFilesMatch({required Object query}) =>
      'Файлы, соответствующие "${query}", не найдены';
  @override
  String filesCount({required Object count}) => '${count} файлов';
  @override
  String get selectBaseFile => 'Выбрать базовый файл';
  @override
  String get selectTargetFile => 'Выбрать целевой файл';
  @override
  String get comparisonResults => 'Результаты сравнения';
  @override
  String get noChanges => 'Изменения между выбранными refs не найдены.';
  @override
  String get linesAdded => 'Строк добавлено';
  @override
  String get linesRemoved => 'Строк удалено';
  @override
  String get commit => 'Commit';
  @override
  String get branch => 'Branch';
  @override
  String get noRepositorySelected => 'Репозиторий не выбран';
  @override
  String get notGitComparison => 'Это не Git-сравнение';
  @override
  String get repositoryNotExist => 'Репозиторий не существует';
  @override
  String get mainBranch => 'main';
  @override
  String get masterBranch => 'master';
  @override
  String get backToControls => 'Назад к элементам управления сравнением';
}

// Path: git
class _TranslationsGitRu implements TranslationsGitEn {
  _TranslationsGitRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Сравнение Git';
  @override
  String get selectRepository => 'Выбрать репозиторий';
  @override
  String get selectBranch => 'Выбрать Branch';
  @override
  String get selectCommit => 'Выбрать Commit';
  @override
  String get compareBranches => 'Сравнить Branches';
  @override
  String get compareCommits => 'Сравнить Commits';
  @override
  String get baseBranch => 'Базовая Branch';
  @override
  String get compareBranch => 'Сравниваемая Branch';
  @override
  String get noRepositories => 'Git-репозитории не найдены';
  @override
  String get noRepositoriesDescription =>
      'Откройте папку, содержащую Git-репозиторий';
  @override
  String filesChanged({required Object count}) => '${count} файлов изменено';
  @override
  String additions({required Object count}) => '${count} добавлений';
  @override
  String deletions({required Object count}) => '${count} удалений';
  @override
  late final _TranslationsGitConflictsRu conflicts =
      _TranslationsGitConflictsRu._(_root);
}

// Path: quality
class _TranslationsQualityRu implements TranslationsQualityEn {
  _TranslationsQualityRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get _translatorNote =>
      'API и метрики (Requests, Tokens, Characters, Prompt, Completion, Export) должны оставаться на английском языке для единообразия с отраслевой терминологией.';
  @override
  String get title => 'Панель качества';
  @override
  String get overallScore => 'Общая оценка';
  @override
  String get issues => 'Проблемы';
  @override
  String get warnings => 'Предупреждения';
  @override
  String get suggestions => 'Предложения';
  @override
  String get placeholderMismatch => 'Несовпадение заполнителей';
  @override
  String get placeholderMismatchDescription =>
      'Заполнители {name} не совпадают с источником';
  @override
  String get lengthOutlier => 'Отклонение длины';
  @override
  String get lengthOutlierDescription =>
      'Длина перевода сильно отличается от оригинала';
  @override
  String get duplicateValue => 'Дублирующее значение';
  @override
  String get duplicateValueDescription =>
      'Один перевод используется для разных ключей';
  @override
  String get missingTranslation => 'Отсутствует перевод';
  @override
  String get missingTranslationDescription =>
      'Перевод для этого ключа отсутствует';
  @override
  String get loading => 'Загрузка панели...';
  @override
  String get errorLoading => 'Не удалось загрузить историю. Попробуйте снова.';
  @override
  String get emptyState => 'Запустите сравнение, чтобы увидеть данные.';
  @override
  String get refresh => 'Обновить';
  @override
  String get buildingInsights => 'Сбор данных...';
  @override
  String get crunchingNumbers => 'Обработка чисел...';
  @override
  String get errorBuilding => 'Не удалось построить панель. Попробуйте снова.';
  @override
  String get noUsableData => 'Полезные данные пока не найдены.';
  @override
  String get languages => 'Языки';
  @override
  String get averageCoverage => 'Среднее покрытие';
  @override
  String get potentialIssues => 'Возможные проблемы';
  @override
  String get translationCoverage => 'Покрытие перевода';
  @override
  String entriesTranslated(
          {required Object translated, required Object total}) =>
      'Переведено ${translated} из ${total} записей';
  @override
  String get wordsAddedOverTime => 'Добавление слов со временем';
  @override
  String get completionVsScope => 'Выполнение vs Объём';
  @override
  String get scopeVsProgress => 'Объём vs Прогресс';
  @override
  String get coveragePercent => 'Покрытие %';
  @override
  String get wordsAdded => 'Добавлено слов';
  @override
  String get words => 'Слова';
  @override
  String get coverage => 'Покрытие';
  @override
  String get scope => 'Объём';
  @override
  String get latest => 'Последнее';
  @override
  String get added => 'Добавлено';
  @override
  String get change => 'Изменение';
  @override
  String get totalScope => 'Общий объём';
  @override
  String wordsCount({required Object count}) => '${count} слов';
  @override
  String get scopeGrowth => 'Рост объёма';
  @override
  String get range => 'Диапазон';
  @override
  String get aiUsage => 'Использование ИИ и переводов';
  @override
  String lastUsed({required Object date}) => 'Последн. исп. ${date}';
  @override
  String get noIssuesFound => 'Проблем не найдено в последних сравнениях.';
  @override
  String get placeholderMismatches => 'Несовпадения заполнителей';
  @override
  String get placeholderMismatchesDesc => 'Маркеры типа {name} не совпадают.';
  @override
  String get lengthOutliers => 'Слишком короткие/длинные переводы';
  @override
  String get lengthOutliersDesc =>
      'Длина выглядит необычной по сравнению с исходником.';
  @override
  String get duplicateValues => 'Дублирующиеся значения';
  @override
  String get duplicateValuesDesc => 'Один перевод используется многократно.';
  @override
  String get placeholderDialogTitle => 'Несовпадения заполнителей';
  @override
  String get placeholderDialogDesc =>
      'Эти переводы имеют другие заполнители ({name}), чем источник.';
  @override
  String get lengthDialogTitle => 'Отклонения длины';
  @override
  String get lengthDialogDesc =>
      'Эти переводы значительно короче или длиннее источника.';
  @override
  String get duplicateDialogTitle => 'Дублирующиеся значения';
  @override
  String get duplicateDialogDesc => 'Эти переводы встречаются несколько раз.';
  @override
  String duplicateSample({required Object value}) => 'Дубликат: "${value}"';
  @override
  String get exportError => 'Не удалось создать отчёт. Попробуйте снова.';
  @override
  String get noDataToExport => 'Нет данных для экспорта';
  @override
  String get exportFailed => 'Ошибка экспорта';
  @override
  String get exportDialogTitle => 'Экспорт отчёта о качестве';
  @override
  String get reportSaved => 'Отчёт сохранён';
  @override
  String get export => 'Экспорт';
  @override
  String get requests => 'Запросы';
  @override
  String get tokens => 'Токены';
  @override
  String get characters => 'Символы';
  @override
  String get estCost => 'Оц. стоимость';
  @override
  String get prompt => 'Промпт';
  @override
  String get completion => 'Завершение';
  @override
  String get showingCurrentProject => 'Показано: Текущий проект';
  @override
  String get showingAllHistory => 'Показано: Вся история';
  @override
  String get filesSkipped => 'Некоторые файлы пропущены, так как не найдены.';
  @override
  String charCount({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(
        n,
        one: '1 символ',
        other: '${count} символов',
      );
  @override
  String lengthDiff(
          {required Object target,
          required Object percent,
          required Object source}) =>
      'Цель: ${target} (${percent}%) против источника: ${source}';
}

// Path: errors
class _TranslationsErrorsRu implements TranslationsErrorsEn {
  _TranslationsErrorsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get genericError => 'Произошла ошибка';
  @override
  String get fileNotFound => 'Файл не найден';
  @override
  String get invalidFormat => 'Неверный формат файла';
  @override
  String get parseError => 'Не удалось разобрать файл';
  @override
  String get networkError => 'Ошибка сети. Проверьте соединение.';
  @override
  String get permissionDenied => 'В доступе отказано';
  @override
  String get unknownError => 'Произошла неизвестная ошибка';
}

// Path: wizards
class _TranslationsWizardsRu implements TranslationsWizardsEn {
  _TranslationsWizardsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsWizardsFirstRunRu firstRun =
      _TranslationsWizardsFirstRunRu._(_root);
}

// Path: dialogs
class _TranslationsDialogsRu implements TranslationsDialogsEn {
  _TranslationsDialogsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDialogsAddIgnorePatternRu addIgnorePattern =
      _TranslationsDialogsAddIgnorePatternRu._(_root);
  @override
  late final _TranslationsDialogsDiffViewerRu diffViewer =
      _TranslationsDialogsDiffViewerRu._(_root);
}

// Path: grid
class _TranslationsGridRu implements TranslationsGridEn {
  _TranslationsGridRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGridColumnsRu columns =
      _TranslationsGridColumnsRu._(_root);
}

// Path: advancedComparison
class _TranslationsAdvancedComparisonRu
    implements TranslationsAdvancedComparisonEn {
  _TranslationsAdvancedComparisonRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get placeholder => 'Расширенный вид сравнения — заглушка';
}

// Path: advancedDiff
class _TranslationsAdvancedDiffRu implements TranslationsAdvancedDiffEn {
  _TranslationsAdvancedDiffRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get saveAllChanges => 'Сохранить все изменения?';
  @override
  String saveConfirmation({required Object count}) =>
      'Это сохранит все ${count} изменённых записей в целевой файл. Это действие нельзя отменить.';
  @override
  String get changesSaved => 'Изменения успешно сохранены.';
  @override
  String get csvExported => 'CSV экспортирован';
  @override
  String get unsavedChanges => 'Несохранённые изменения';
  @override
  String get unsavedChangesWarning =>
      'У вас есть несохранённые изменения. Вы уверены, что хотите их отменить?';
  @override
  String get discardChanges => 'Отменить изменения';
  @override
  String get goBack => 'Назад';
  @override
  String get breadcrumbs => 'Главная  >  Редактор';
  @override
  String unsaved({required Object count}) => '${count} не сохранено';
  @override
  String reviewed({required Object count}) => '${count} проверено';
  @override
  String saveAll({required Object count}) => 'Сохранить все (${count})';
  @override
  String get allSaved => 'Всё сохранено';
  @override
  String get saveAllTooltip => 'Сохранить все изменения (Ctrl+S)';
  @override
  String get exportTooltip => 'Экспорт данных (Ctrl+E)';
  @override
  late final _TranslationsAdvancedDiffAiSuggestionRu aiSuggestion =
      _TranslationsAdvancedDiffAiSuggestionRu._(_root);
  @override
  late final _TranslationsAdvancedDiffDetailEditRu detailEdit =
      _TranslationsAdvancedDiffDetailEditRu._(_root);
  @override
  late final _TranslationsAdvancedDiffTableRu table =
      _TranslationsAdvancedDiffTableRu._(_root);
  @override
  late final _TranslationsAdvancedDiffDiffRowRu diffRow =
      _TranslationsAdvancedDiffDiffRowRu._(_root);
  @override
  late final _TranslationsAdvancedDiffStatusRu status =
      _TranslationsAdvancedDiffStatusRu._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarRu sidebar =
      _TranslationsAdvancedDiffSidebarRu._(_root);
}

// Path: issueDetails
class _TranslationsIssueDetailsRu implements TranslationsIssueDetailsEn {
  _TranslationsIssueDetailsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Детали проблемы';
  @override
  String showingIssues({required Object count, required Object total}) =>
      'Показано ${count} из ${total} проблем';
  @override
  String get searchPlaceholder => 'Поиск по ключу, тексту или ошибке...';
  @override
  String get noDetails => 'Нет доступных деталей.';
  @override
  String get noMatches => 'Совпадения не найдены.';
  @override
  String get showMore => 'Показать ещё';
  @override
  String copyItems({required Object count}) => 'Копировать ${count} элементов';
  @override
  String get close => 'Закрыть';
  @override
  String get copied => 'Скопировано в буфер обмена';
  @override
  String copiedCount({required Object count}) =>
      'Скопировано ${count} элементов';
  @override
  late final _TranslationsIssueDetailsDuplicateValueRu duplicateValue =
      _TranslationsIssueDetailsDuplicateValueRu._(_root);
  @override
  late final _TranslationsIssueDetailsLengthOutlierRu lengthOutlier =
      _TranslationsIssueDetailsLengthOutlierRu._(_root);
  @override
  late final _TranslationsIssueDetailsStandardRu standard =
      _TranslationsIssueDetailsStandardRu._(_root);
  @override
  String get review => 'Проверить';
  @override
  late final _TranslationsIssueDetailsTypesRu types =
      _TranslationsIssueDetailsTypesRu._(_root);
  @override
  late final _TranslationsIssueDetailsNotesRu notes =
      _TranslationsIssueDetailsNotesRu._(_root);
  @override
  late final _TranslationsIssueDetailsFallbacksRu fallbacks =
      _TranslationsIssueDetailsFallbacksRu._(_root);
}

// Path: importReview
class _TranslationsImportReviewRu implements TranslationsImportReviewEn {
  _TranslationsImportReviewRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Проверка импорта проекта';
  @override
  String get projectName => 'Название проекта';
  @override
  String get created => 'Создан';
  @override
  String get historyItems => 'Элементы истории';
  @override
  String get customSettingsTitle => 'Обнаружены пользовательские настройки';
  @override
  String get customSettingsWarning =>
      'Этот проект содержит пользовательские настройки, которые переопределят ваши значения по умолчанию, пока этот проект открыт.';
  @override
  String get standardSettings =>
      'Этот проект использует стандартные глобальные настройки.';
  @override
  String get cancelImport => 'Отменить импорт';
  @override
  String get trustOpen => 'Доверять и открыть проект';
}

// Path: historyView
class _TranslationsHistoryViewRu implements TranslationsHistoryViewEn {
  _TranslationsHistoryViewRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'История сравнений';
  @override
  String get clearAll => 'Очистить всю историю';
  @override
  String get searchPlaceholder => 'Поиск по имени файла...';
  @override
  String get sortBy => 'Сортировать по';
  @override
  String get sortDate => 'Дате';
  @override
  String get sortSource => 'Исходному файлу';
  @override
  String get sortTarget => 'Целевому файлу';
  @override
  String get showCurrentProject => 'Показать: текущий проект';
  @override
  String get showAllHistory => 'Показать: вся история';
  @override
  String get groupByFolder => 'Группировать по папке';
  @override
  String get disableGrouping => 'Отключить группировку по папкам';
  @override
  String get filterAll => 'Все';
  @override
  String get filterFiles => 'Файлы';
  @override
  String get filterDirectories => 'Каталоги';
  @override
  String get filterGit => 'Git';
  @override
  String get noHistory => 'История сравнений пуста';
  @override
  String get historyDescription => 'Ваши сравнения файлов появятся здесь';
  @override
  String get noResults => 'Результаты не найдены';
  @override
  String get adjustSearch => 'Попробуйте изменить запрос';
  @override
  String get clearConfirmationTitle => 'Очистить всю историю?';
  @override
  String get clearConfirmationContent =>
      'Это навсегда удалит всю историю сравнений. Это действие нельзя отменить.';
  @override
  String get clearAction => 'Очистить всё';
  @override
  String get deletedMessage => 'Элемент истории удалён';
  @override
  String get undo => 'Отменить';
  @override
  String get viewDetails => 'Показать детали';
  @override
  String get delete => 'Удалить';
  @override
  String get openLocation => 'Открыть расположение файла';
  @override
  String get bilingual => 'Двуязычный';
  @override
  String get filePair => 'Пара файлов';
  @override
  String get directory => 'Каталог';
  @override
  String get git => 'Git';
  @override
  String get repo => 'Репозиторий';
  @override
  String get sourceDir => 'Исходный каталог';
  @override
  String get targetDir => 'Целевой каталог';
  @override
  String get source => 'Источник';
  @override
  String get target => 'Цель';
  @override
  String get noChanges => 'Изменения не обнаружены';
  @override
  String get added => 'Добавлено';
  @override
  String get removed => 'Удалено';
  @override
  String get modified => 'Изменено';
  @override
  String get status => 'Статус';
  @override
  String get actions => 'Действия';
  @override
  String get same => 'Одинаковые';
  @override
  String get total => 'Всего';
  @override
  String get currentProject => 'Текущий проект';
  @override
  String get unassigned => 'Не назначено';
  @override
  String get project => 'Проект';
}

// Path: tutorial
class _TranslationsTutorialRu implements TranslationsTutorialEn {
  _TranslationsTutorialRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'ПРОПУСТИТЬ ОБУЧЕНИЕ';
  @override
  String get finishMessage => 'Готово! Нажмите куда угодно для завершения.';
  @override
  String get next => 'Далее';
  @override
  String get loadSampleData => 'Загрузить примеры данных';
  @override
  String get browseSourceFile => 'Выбрать исходный файл';
  @override
  String get browseTargetFile => 'Выбрать целевой файл';
  @override
  String get compareFiles => 'Сравнить файлы';
  @override
  String get hintPhase2 => 'Далее: фильтры, поиск, расширенный вид и экспорт.';
  @override
  late final _TranslationsTutorialStepsRu steps =
      _TranslationsTutorialStepsRu._(_root);
}

// Path: friendlyErrors
class _TranslationsFriendlyErrorsRu implements TranslationsFriendlyErrorsEn {
  _TranslationsFriendlyErrorsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsFriendlyErrorsFileNotFoundRu fileNotFound =
      _TranslationsFriendlyErrorsFileNotFoundRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsAccessDeniedRu accessDenied =
      _TranslationsFriendlyErrorsAccessDeniedRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsIsDirectoryRu isDirectory =
      _TranslationsFriendlyErrorsIsDirectoryRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsFileAccessRu fileAccess =
      _TranslationsFriendlyErrorsFileAccessRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsUnsupportedFormatRu unsupportedFormat =
      _TranslationsFriendlyErrorsUnsupportedFormatRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsNetworkErrorRu networkError =
      _TranslationsFriendlyErrorsNetworkErrorRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsNotGitRepoRu notGitRepo =
      _TranslationsFriendlyErrorsNotGitRepoRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsMergeConflictRu mergeConflict =
      _TranslationsFriendlyErrorsMergeConflictRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitAuthFailedRu gitAuthFailed =
      _TranslationsFriendlyErrorsGitAuthFailedRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsGitOperationFailedRu
      gitOperationFailed =
      _TranslationsFriendlyErrorsGitOperationFailedRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidJsonRu invalidJson =
      _TranslationsFriendlyErrorsInvalidJsonRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsRateLimitReachedRu rateLimitReached =
      _TranslationsFriendlyErrorsRateLimitReachedRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsInvalidApiKeyRu invalidApiKey =
      _TranslationsFriendlyErrorsInvalidApiKeyRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsTranslationServiceErrorRu
      translationServiceError =
      _TranslationsFriendlyErrorsTranslationServiceErrorRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsOutOfMemoryRu outOfMemory =
      _TranslationsFriendlyErrorsOutOfMemoryRu._(_root);
  @override
  late final _TranslationsFriendlyErrorsGenericErrorRu genericError =
      _TranslationsFriendlyErrorsGenericErrorRu._(_root);
}

// Path: systemTray
class _TranslationsSystemTrayRu implements TranslationsSystemTrayEn {
  _TranslationsSystemTrayRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get showLocalizer => 'Показать Localizer';
  @override
  String get exit => 'Выход';
}

// Path: validation
class _TranslationsValidationRu implements TranslationsValidationEn {
  _TranslationsValidationRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get connected => 'Подключено.';
  @override
  String get connectionTimeout =>
      'Время подключения истекло. Пожалуйста, попробуйте снова.';
  @override
  String get couldNotConnect =>
      'Не удалось подключиться. Пожалуйста, попробуйте снова.';
  @override
  String get checkKeyAndTryAgain =>
      'Не удалось подключиться. Пожалуйста, проверьте ключ и попробуйте снова.';
  @override
  String get tryAgainLater =>
      'Не удалось подключиться сейчас. Пожалуйста, попробуйте позже.';
  @override
  String get serviceUnavailable =>
      'Сервис недоступен сейчас. Пожалуйста, попробуйте позже.';
  @override
  String get enterKeyFirst => 'Сначала введите ключ.';
  @override
  String get checking => 'Проверка...';
  @override
  String deeplUsage({required Object used, required Object limit}) =>
      'Использование: ${used} / ${limit} символов.';
}

// Path: status
class _TranslationsStatusRu implements TranslationsStatusEn {
  _TranslationsStatusRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get startingComparison => 'Начало сравнения...';
  @override
  String get loadingFromHistory => 'Загрузка файлов из истории...';
  @override
  String get comparisonComplete => 'Сравнение завершено';
  @override
  String get couldNotImportFiles =>
      'Не удалось импортировать файлы. Пожалуйста, попробуйте снова.';
  @override
  String get historyFilesNotFound =>
      'Один или оба файла из истории не найдены по исходным путям.';
}

// Path: aiServices
class _TranslationsAiServicesRu implements TranslationsAiServicesEn {
  _TranslationsAiServicesRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get geminiEmptyResponse => 'Gemini вернул пустой ответ';
  @override
  String get geminiStreamingEmpty => 'Gemini streaming вернул пустой ответ';
  @override
  String get geminiRephraseEmpty =>
      'Gemini вернул пустой ответ для перефразирования';
  @override
  String get openaiEmptyResponse => 'OpenAI вернул пустой или неверный ответ';
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceRu
    implements TranslationsSettingsAppearanceEn {
  _TranslationsSettingsAppearanceRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Внешний вид';
  @override
  String get description => 'Настройте внешний вид приложения';
  @override
  String get theme => 'Режим темы';
  @override
  String get themeDescription => 'Выберите светлую, тёмную или системную тему';
  @override
  String get themeSystem => 'Системная';
  @override
  String get themeLight => 'Светлая';
  @override
  String get themeDark => 'Тёмная';
  @override
  String get themeAmoled => 'AMOLED';
  @override
  String get accentColor => 'Цвет акцента';
  @override
  String get accentColorDescription => 'Выберите предпочитаемый цвет акцента';
  @override
  String get useMicaEffect => 'Использовать эффект Mica';
  @override
  String get micaDescription =>
      'Включить эффект прозрачности Mica для Windows 11';
  @override
  String get diffFontSize => 'Размер шрифта сравнения';
  @override
  String get diffFontSizeDescription =>
      'Настройте размер шрифта для окна сравнения';
  @override
  String get diffFontFamily => 'Шрифт сравнения';
  @override
  String get diffFontFamilyDescription => 'Шрифт для окна сравнения';
  @override
  String get systemDefault => 'Системный по умолчанию';
  @override
  String get pickAccentColor => 'Выбрать цвет акцента';
  @override
  String get diffColors => 'Цвета сравнения';
  @override
  String get presetsTitle => 'Пресеты';
  @override
  late final _TranslationsSettingsAppearancePresetsRu presets =
      _TranslationsSettingsAppearancePresetsRu._(_root);
  @override
  String get identical => 'Идентичные';
  @override
  String pickColorFor({required Object label}) => 'Выбрать цвет для ${label}';
  @override
  String get livePreview => 'Предпросмотр';
  @override
  late final _TranslationsSettingsAppearancePreviewRu preview =
      _TranslationsSettingsAppearancePreviewRu._(_root);
}

// Path: settings.general
class _TranslationsSettingsGeneralRu implements TranslationsSettingsGeneralEn {
  _TranslationsSettingsGeneralRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Общие';
  @override
  String get description => 'Общие настройки приложения';
  @override
  String get language => 'Язык';
  @override
  String get languageDescription => 'Выберите предпочитаемый язык';
  @override
  String get startMinimized => 'Запускать свёрнутым в трей';
  @override
  String get startMinimizedDescription =>
      'Запускать приложение свёрнутым в системный трей';
  @override
  String get rememberWindowPosition => 'Запоминать положение окна';
  @override
  String get rememberWindowPositionDescription =>
      'Восстанавливать размер и положение окна при запуске';
  @override
  String get openLastProject => 'Открывать последний проект при запуске';
  @override
  String get openLastProjectDescription =>
      'Автоматически открывать последний используемый проект при запуске приложения';
  @override
  String get application => 'Приложение';
  @override
  String get defaultView => 'Вид по умолчанию';
  @override
  String get defaultViewDescription => 'Вид, отображаемый при запуске';
  @override
  String get autoCheckUpdates => 'Автопроверка обновлений';
  @override
  String get autoCheckUpdatesDescription => 'Проверять обновления при запуске';
  @override
  String get startupOptions => 'Параметры запуска';
  @override
  String get languageAuto => 'Автоопределение';
  @override
  String get viewBasic => 'Сравнение файлов';
  @override
  String get viewHistory => 'История';
  @override
  String get viewDashboard => 'Панель качества';
  @override
  String get viewDirectory => 'Сравнение каталогов';
  @override
  String get viewLastUsed => 'Последний использованный вид';
}

// Path: settings.scope
class _TranslationsSettingsScopeRu implements TranslationsSettingsScopeEn {
  _TranslationsSettingsScopeRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Область настроек';
  @override
  String get global => 'Глобальные значения по умолчанию';
  @override
  String get project => 'Проект';
  @override
  String get reset => 'Сбросить проект к глобальным значениям';
  @override
  String get resetConfirmation =>
      'Это очистит все переопределения для этого проекта и вернёт глобальные значения по умолчанию. Это действие нельзя отменить.';
  @override
  String get globalDescription =>
      'Изменения применяются ко всем проектам, если не переопределены.';
  @override
  String projectDescription({required Object name}) =>
      'Изменения применяются только к "${name}". Остальные настройки наследуются от глобальных значений.';
  @override
  String get createPrompt =>
      'Создайте проект для настройки параметров определённых папок';
}

// Path: settings.searchKeywords
class _TranslationsSettingsSearchKeywordsRu
    implements TranslationsSettingsSearchKeywordsEn {
  _TranslationsSettingsSearchKeywordsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  List<String> get general => [
        'Язык',
        'Вид по умолчанию',
        'Количество недавних файлов',
        'Открывать последний проект',
        'Подтверждать перед выходом',
        'Показывать уведомления',
      ];
  @override
  List<String> get comparisonEngine => [
        'Режим сравнения',
        'Порог схожести',
        'Чувствительность к регистру',
        'Игнорировать пробелы',
        'Игнорировать пустые строки',
        'Игнорировать комментарии',
        'Игнорировать шаблоны',
      ];
  @override
  List<String> get appearance => [
        'Тема',
        'Режим темы',
        'Цвет акцента',
        'Размер шрифта сравнения',
        'Шрифт сравнения',
        'Цвета сравнения',
        'Цвет добавленного',
        'Цвет удалённого',
        'Цвет изменённого',
        'Цвет идентичного',
        'Цветовые пресеты',
        'Предпросмотр',
      ];
  @override
  List<String> get fileHandling => [
        'Формат источника',
        'Формат цели',
        'Кодировка по умолчанию',
        'Количество недавних проектов',
        'Память переводов',
        'Импорт памяти',
        'Экспорт памяти',
        'Очистить память',
      ];
  @override
  List<String> get aiServices => [
        'API-ключ OpenAI',
        'API-ключ Anthropic',
        'API-ключ Google AI',
        'Модель ИИ',
        'Температура',
        'Пользовательский промпт',
      ];
  @override
  List<String> get systemIntegrations => [
        'Системный трей',
        'Запуск свёрнутым',
        'Ассоциации файлов',
        'Эффект Mica',
        'Размытие',
        'Материал окна',
        'Значок Dock',
        'Количество непереведённых',
      ];
  @override
  List<String> get projectResources => [
        'Глоссарий',
        'Память переводов',
        'Терминология',
      ];
  @override
  List<String> get about => [
        'Версия',
        'Проверить обновления',
        'Автообновление',
        'Журнал изменений',
        'Лицензия',
        'Политика конфиденциальности',
        'Телеметрия',
        'Отчёт об ошибках',
      ];
  @override
  List<String> get developer => [
        'Оверлей производительности',
        'Отладчик семантики',
        'Сетка Material',
        'Растровый кэш',
        'Перезапустить руководство',
        'Сброс к заводским настройкам',
      ];
}

// Path: settings.comparison
class _TranslationsSettingsComparisonRu
    implements TranslationsSettingsComparisonEn {
  _TranslationsSettingsComparisonRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Сравнение';
  @override
  String get description => 'Настройка поведения сравнения';
  @override
  String get caseSensitive => 'Чувствительность к регистру';
  @override
  String get caseSensitiveDescription => 'Различать прописные и строчные буквы';
  @override
  String get ignoreWhitespace => 'Игнорировать пробелы';
  @override
  String get ignoreWhitespaceDescription =>
      'Игнорировать начальные/конечные пробелы при сравнении';
  @override
  String get showLineNumbers => 'Показывать номера строк';
  @override
  String get showLineNumbersDescription =>
      'Отображать номера строк в окне сравнения';
  @override
  String get behavior => 'Поведение сравнения';
  @override
  String get ignoreCase => 'Игнорировать регистр';
  @override
  String get ignoreCaseDescription => 'Считать "Key" и "key" одинаковыми';
  @override
  String get similarityThreshold => 'Порог схожести';
  @override
  String get similarityThresholdDescription =>
      'Минимальная схожесть для определения "Изменено"';
  @override
  String get mode => 'Режим сравнения';
  @override
  String get modeDescription => 'Способ сопоставления записей между файлами';
  @override
  String get modeKey => 'По ключам';
  @override
  String get modeKeyDescription =>
      'Сопоставление по имени ключа (по умолчанию).';
  @override
  String get modeOrder => 'По порядку';
  @override
  String get modeOrderDescription => 'Сопоставление по позиции в файле.';
  @override
  String get modeSmart => 'Умное сопоставление';
  @override
  String get modeSmartDescription =>
      'Обнаружение перемещённых/переименованных ключей.';
  @override
  String get ignorePatterns => 'Игнорируемые шаблоны';
  @override
  String get noIgnorePatterns => 'Игнорируемые шаблоны не заданы.';
  @override
  String get addPattern => 'Добавить шаблон';
  @override
  String get resetToGlobal =>
      'Сбросить все настройки сравнения к глобальным значениям';
  @override
  late final _TranslationsSettingsComparisonPatternPresetsRu patternPresets =
      _TranslationsSettingsComparisonPatternPresetsRu._(_root);
  @override
  late final _TranslationsSettingsComparisonPreviewMatchRu previewMatch =
      _TranslationsSettingsComparisonPreviewMatchRu._(_root);
  @override
  late final _TranslationsSettingsComparisonColorPresetsRu colorPresets =
      _TranslationsSettingsComparisonColorPresetsRu._(_root);
}

// Path: settings.fileHandling
class _TranslationsSettingsFileHandlingRu
    implements TranslationsSettingsFileHandlingEn {
  _TranslationsSettingsFileHandlingRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get fileFormats => 'Форматы файлов';
  @override
  String get sourceFormat => 'Формат источника';
  @override
  String get targetFormat => 'Формат цели';
  @override
  String get encoding => 'Кодировка';
  @override
  String get sourceEncoding => 'Кодировка источника';
  @override
  String get targetEncoding => 'Кодировка цели';
  @override
  String get autoDetect => 'Автоопределение';
  @override
  String get autoDetectEncodingDescription =>
      'Автоматически определять кодировку файла';
  @override
  String get exportSettings => 'Настройки экспорта';
  @override
  String get defaultExportFormat => 'Формат экспорта по умолчанию';
  @override
  String get includeUtf8Bom => 'Включить UTF-8 BOM';
  @override
  String get includeUtf8BomDescription => 'Требуется для совместимости с Excel';
  @override
  String get openFolderAfterExport => 'Открыть папку после экспорта';
  @override
  String get fileSafety => 'Безопасность файлов';
  @override
  String get fileSafetyDescription =>
      'Автоматические локальные копии для восстановления.';
  @override
  String get resetToGlobal =>
      'Сбросить все настройки обработки файлов к глобальным значениям';
}

// Path: settings.translationMemory
class _TranslationsSettingsTranslationMemoryRu
    implements TranslationsSettingsTranslationMemoryEn {
  _TranslationsSettingsTranslationMemoryRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Глобальная память переводов';
  @override
  String get autoLearn => 'Автообучение';
  @override
  String get autoLearnDescription =>
      'Сохранять переводы в локальную память для повторного использования';
  @override
  String get confidenceThreshold => 'Порог уверенности';
  @override
  String confidenceThresholdDescription({required Object percent}) =>
      'Минимальная оценка для автоприменения (${percent}%)';
  @override
  String get entries => 'Записей';
  @override
  String get size => 'Размер';
  @override
  String memorySize({required Object size}) => 'Размер памяти: ${size}';
  @override
  String get import => 'Импорт';
  @override
  String get exportTmx => 'Экспорт TMX';
  @override
  String get exportCsv => 'Экспорт CSV';
  @override
  String get clearMemory => 'Очистить память';
  @override
  String importedItems({required Object count}) =>
      'Импортировано ${count} элементов в память.';
  @override
  String get noItemsAdded => 'Элементы не были добавлены.';
  @override
  String get nothingToExport => 'Нечего экспортировать.';
  @override
  String get tmxSaved => 'TMX сохранён';
  @override
  String get csvSaved => 'CSV сохранён';
  @override
  String get clearConfirmTitle => 'Очистить память переводов?';
  @override
  String get clearConfirmContent =>
      'Это удалит все сохранённые пары переводов на этом устройстве. Это действие нельзя отменить.';
  @override
  String get cleared => 'Память переводов очищена.';
  @override
  String get couldNotClear => 'Не удалось очистить память.';
}

// Path: settings.backup
class _TranslationsSettingsBackupRu implements TranslationsSettingsBackupEn {
  _TranslationsSettingsBackupRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Автосохранение';
  @override
  String get description => 'Настройки автоматического резервного копирования';
  @override
  String get enabled => 'Включить автосохранение';
  @override
  String get enabledDescription =>
      'Автоматически создавать резервные копии файлов перед изменениями';
  @override
  String get maxCopies => 'Максимум резервных копий';
  @override
  String get maxCopiesDescription =>
      'Количество резервных копий для каждого файла';
  @override
  String activeStatus({required Object count}) =>
      'Активно · Хранится ${count} копий';
  @override
  String get folder => 'Папка резервных копий';
  @override
  String get folderDescription =>
      'Оставьте пустым для использования той же папки';
  @override
  String get useOriginalFolder => 'Использовать исходную папку файла';
}

// Path: settings.ai
class _TranslationsSettingsAiRu implements TranslationsSettingsAiEn {
  _TranslationsSettingsAiRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'ИИ-сервисы';
  @override
  String get description => 'Настройка ИИ-перевода и помощи';
  @override
  String get provider => 'Провайдер ИИ';
  @override
  String get providerDescription =>
      'Выберите предпочитаемого провайдера ИИ-сервисов';
  @override
  String get apiKey => 'API-ключ';
  @override
  String get apiKeyDescription => 'Введите API-ключ для выбранного провайдера';
  @override
  String get apiKeyPlaceholder => 'Введите API-ключ...';
  @override
  String get testConnection => 'Проверить соединение';
  @override
  String get connectionSuccess => 'Соединение успешно!';
  @override
  String get connectionFailed => 'Ошибка соединения. Проверьте API-ключ.';
  @override
  String get translationStrategy => 'Стратегия перевода';
  @override
  String get strategy => 'Стратегия';
  @override
  String get strategyDescription => 'Выберите способ перевода строк';
  @override
  String get strategyLLM => 'Генеративный ИИ (LLM)';
  @override
  String get strategyCloud => 'Облачный перевод';
  @override
  String get enableAiTranslation => 'Включить ИИ-перевод';
  @override
  String get enableAiTranslationDescription =>
      'Разрешить приложению использовать ИИ для предложений перевода';
  @override
  String get llmProvider => 'Провайдер LLM-сервиса';
  @override
  String get service => 'Сервис';
  @override
  String get serviceDescription => 'Провайдер для генеративного ИИ';
  @override
  String get providerGemini => 'Google Gemini';
  @override
  String get providerOpenAI => 'OpenAI';
  @override
  String get geminiApiKey => 'API-ключ Gemini';
  @override
  String get openAiApiKey => 'API-ключ OpenAI';
  @override
  String get model => 'Модель';
  @override
  String get modelDescription => 'Выберите используемую модель';
  @override
  String get advancedParameters => 'Расширенные параметры';
  @override
  String get parameters => 'Параметры';
  @override
  String get parametersDescription => 'Температура, контекст и другое';
  @override
  String get temperature => 'Температура';
  @override
  String get temperatureDescription =>
      'Высокие значения делают вывод более творческим';
  @override
  String get maxTokens => 'Макс. токенов';
  @override
  String get maxTokensDescription => 'Ограничение длины контекстного окна';
  @override
  String get systemContext => 'Системный контекст / Инструкции';
  @override
  String get systemContextHint =>
      'Вы — профессиональный локализатор. Сохраняйте тон и смысл исходной строки...';
  @override
  String get systemContextHelper =>
      'Предоставьте ИИ конкретные инструкции о стиле и терминологии вашего проекта.';
  @override
  String get contextStrings => 'Контекстные строки';
  @override
  String get contextStringsDescription =>
      'Включать окружающие строки для лучшего контекста';
  @override
  String get contextCount => 'Количество контекста';
  @override
  String get contextCountDescription =>
      'Количество окружающих строк для включения';
  @override
  String get cloudServices => 'Облачные сервисы перевода';
  @override
  String get googleTranslateApiKey => 'API-ключ Google Translate';
  @override
  String get deeplApiKey => 'API-ключ DeepL';
  @override
  String get test => 'Тест';
  @override
  String get resetToGlobal =>
      'Сбросить все настройки ИИ к глобальным значениям';
}

// Path: settings.integrations
class _TranslationsSettingsIntegrationsRu
    implements TranslationsSettingsIntegrationsEn {
  _TranslationsSettingsIntegrationsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get platformNotice => 'Уведомление о платформе';
  @override
  String get platformNoticeDescription =>
      'Системные интеграции недоступны для этой платформы.';
  @override
  String get visualEffects => 'Визуальные эффекты';
  @override
  String get explorerIntegration => 'Интеграция с проводником';
  @override
  String get explorerIntegrationDescription =>
      'Добавить "Открыть в Localizer" в контекстное меню проводника Windows для папок.';
  @override
  String get addToContextMenu => 'Добавить в контекстное меню';
  @override
  String get contextMenuAdded => 'Контекстное меню добавлено!';
  @override
  String get contextMenuAddError => 'Не удалось добавить контекстное меню';
  @override
  String get contextMenuRemoved => 'Контекстное меню удалено!';
  @override
  String get contextMenuRemoveError => 'Не удалось удалить контекстное меню';
  @override
  String get fileAssociations => 'Ассоциации файлов';
  @override
  String get fileAssociationsDescription =>
      'Зарегистрировать типы файлов для открытия в Localizer при двойном клике в проводнике.';
  @override
  String get registered => 'Зарегистрировано';
  @override
  String get notRegistered => 'Не зарегистрировано';
  @override
  String extRegistered({required Object ext}) => '${ext} зарегистрировано!';
  @override
  String extUnregistered({required Object ext}) => '${ext} отменено!';
  @override
  String extError({required Object action, required Object ext}) =>
      'Не удалось ${action} ${ext}';
  @override
  String get registerAll => 'Зарегистрировать все';
  @override
  String get unregisterAll => 'Отменить все';
  @override
  String registerAllResult({required Object success, required Object total}) =>
      'Зарегистрировано ${success} из ${total} типов файлов';
  @override
  String unregisterAllResult(
          {required Object success, required Object total}) =>
      'Отменено ${success} из ${total} типов файлов';
  @override
  String get protocolHandler => 'Обработчик протокола';
  @override
  String get protocolHandlerDescription =>
      'Зарегистрировать URL-схему localizer:// для открытия этого приложения. Позволяет открывать проекты напрямую из ссылок браузера или других приложений.';
  @override
  String get protocolRegistered => 'Обработчик протокола зарегистрирован';
  @override
  String get protocolNotRegistered => 'Обработчик протокола не зарегистрирован';
  @override
  String get registerProtocol => 'Зарегистрировать протокол';
  @override
  String get unregister => 'Отменить регистрацию';
  @override
  String get protocolRegisteredSuccess =>
      'Обработчик протокола зарегистрирован!';
  @override
  String get protocolRemovedSuccess => 'Обработчик протокола удалён!';
  @override
  String get protocolRegisterError => 'Не удалось зарегистрировать';
  @override
  String get protocolRemoveError => 'Не удалось удалить';
  @override
  String get windowMaterial => 'Материал окна';
  @override
  String get windowMaterialDescription => 'Выберите стиль размытия macOS';
  @override
  String get dockIntegration => 'Интеграция с Dock';
  @override
  String get showDockBadge => 'Показывать количество непереведённых';
  @override
  String get showDockBadgeDescription =>
      'Отображать количество непереведённых строк на значке Dock';
  @override
  late final _TranslationsSettingsIntegrationsMaterialsRu materials =
      _TranslationsSettingsIntegrationsMaterialsRu._(_root);
  @override
  late final _TranslationsSettingsIntegrationsFileTypesRu fileTypes =
      _TranslationsSettingsIntegrationsFileTypesRu._(_root);
}

// Path: settings.developer
class _TranslationsSettingsDeveloperRu
    implements TranslationsSettingsDeveloperEn {
  _TranslationsSettingsDeveloperRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Настройки разработчика';
  @override
  String get description => 'Расширенные настройки для разработчиков';
  @override
  String get showLocalizationKeys => 'Показывать ключи локализации';
  @override
  String get localizationKeysDescription =>
      'При включении весь переведённый текст будет показывать ключи локализации вместо переведённых значений. Полезно для проверки использования ключей.';
  @override
  String get showPerformanceOverlay => 'Показывать оверлей производительности';
  @override
  String get performanceOverlayDescription =>
      'Отображать FPS и информацию о кадрах';
  @override
  String get debugMode => 'Режим отладки';
  @override
  String get debugModeDescription =>
      'Включить дополнительное логирование и функции отладки';
  @override
  String get debuggingTools => 'Инструменты отладки';
  @override
  String get semanticsDebugger => 'Отладчик семантики';
  @override
  String get semanticsDebuggerDescription => 'Визуализация дерева семантики';
  @override
  String get materialGrid => 'Сетка Material';
  @override
  String get materialGridDescription => 'Наложение сетки макета Material';
  @override
  String get rasterCache => 'Изображения растрового кэша';
  @override
  String get rasterCacheDescription =>
      'Шахматная разметка изображений растрового кэша';
  @override
  String get actions => 'Действия';
  @override
  String get showLogs => 'Показать логи приложения';
  @override
  String get showLogsDescription => 'Открыть консоль отладки Talker';
  @override
  String get restartTutorial => 'Перезапустить обучение';
  @override
  String get restartTutorialDescription =>
      'Сбросить флаги и запустить обучение снова';
  @override
  String get restartRequested => 'Запрошен перезапуск обучения.';
  @override
  String get throwException => 'Вызвать тестовое исключение';
  @override
  String get throwExceptionDescription =>
      'Вызвать тестовое исключение для проверки отчётов об ошибках';
  @override
  String get testExceptionMessage =>
      'Тестовое исключение вызвано из настроек разработчика';
  @override
  String get clearTM => 'Очистить память переводов';
  @override
  String get clearTMDescription => 'Удалить все кэшированные переводы';
  @override
  String get clearTMConfirmation => 'Очистить память переводов?';
  @override
  String get clearTMWarning =>
      'Это удалит все заученные переводы. Это нельзя отменить.';
  @override
  String get tmCleared => 'Память переводов очищена';
  @override
  String get clearApiKeys => 'Очистить API-ключи';
  @override
  String get clearApiKeysDescription => 'Удалить все сохранённые API-ключи';
  @override
  String get clearApiKeysConfirmation => 'Очистить API-ключи?';
  @override
  String get clearApiKeysWarning =>
      'Это удалит все API-ключи из защищённого хранилища.';
  @override
  String get apiKeysCleared => 'API-ключи очищены';
  @override
  String get hideOptions => 'Скрыть настройки разработчика';
  @override
  String get hideOptionsDescription =>
      'Отключить режим разработчика (требуется 7 нажатий для повторного включения)';
  @override
  String get optionsDisabled => 'Настройки разработчика отключены';
  @override
  String get dangerZone => 'Опасная зона';
  @override
  String get factoryReset => 'Сброс к заводским настройкам';
  @override
  String get factoryResetDescription =>
      'Сбросить все настройки и очистить данные';
  @override
  String get factoryResetWarning =>
      'Вы уверены, что хотите сбросить все настройки? Это действие нельзя отменить.';
  @override
  String get inspectionTools => 'Инструменты инспекции';
  @override
  String get searchHint => 'Поиск настроек...';
  @override
  String get resetToDefault => 'Сбросить по умолчанию';
  @override
  String get resetToGlobal => 'Сбросить к глобальным значениям';
  @override
  String get storageInspector => 'Инспектор хранилища';
  @override
  String get storageInspectorDescription =>
      'Просмотр содержимого Hive и защищённого хранилища';
  @override
  String get deviceEnvironment => 'Устройство и окружение';
  @override
  String get deviceEnvironmentDescription =>
      'Экран, платформа и информация о сборке';
  @override
  String get themePlayground => 'Тестирование темы';
  @override
  String get themePlaygroundDescription => 'Цветовая палитра и типографика';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionRu
      themePlaygroundSection =
      _TranslationsSettingsDeveloperThemePlaygroundSectionRu._(_root);
  @override
  String get localizationInspector => 'Инспектор локализации';
  @override
  String get localizationInspectorDescription => 'Отладка строк перевода';
  @override
  String get hiveAppSettings => 'Hive (AppSettings)';
  @override
  String get secureStorageMasked => 'Защищённое хранилище (скрыто)';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsRu featureFlags =
      _TranslationsSettingsDeveloperFeatureFlagsRu._(_root);
  @override
  late final _TranslationsSettingsDeveloperStorageInspectorSectionRu
      storageInspectorSection =
      _TranslationsSettingsDeveloperStorageInspectorSectionRu._(_root);
  @override
  late final _TranslationsSettingsDeveloperDeviceInfoSectionRu
      deviceInfoSection =
      _TranslationsSettingsDeveloperDeviceInfoSectionRu._(_root);
  @override
  late final _TranslationsSettingsDeveloperLocalizationInspectorSectionRu
      localizationInspectorSection =
      _TranslationsSettingsDeveloperLocalizationInspectorSectionRu._(_root);
}

// Path: settings.about
class _TranslationsSettingsAboutRu implements TranslationsSettingsAboutEn {
  _TranslationsSettingsAboutRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'О программе';
  @override
  String get version => 'Версия';
  @override
  String get buildNumber => 'Номер сборки';
  @override
  String get author => 'Автор';
  @override
  String get license => 'Лицензия';
  @override
  String get sourceCode => 'Исходный код';
  @override
  String get reportBug => 'Сообщить об ошибке';
  @override
  String get requestFeature => 'Запросить функцию';
  @override
  String get checkForUpdates => 'Проверить обновления';
  @override
  String get upToDate => 'У вас последняя версия!';
  @override
  String updateAvailable({required Object version}) =>
      'Доступно обновление: ${version}';
  @override
  String get updateAvailableBadge => 'Доступно обновление!';
  @override
  String developerSteps({required Object count}) =>
      'Осталось ${count} шагов до статуса разработчика.';
  @override
  String get developerActivated => 'Вы теперь разработчик!';
  @override
  String get neverChecked => 'Никогда';
  @override
  String get applicationInfo => 'Информация о приложении';
  @override
  String get platform => 'Платформа';
  @override
  String get updateInformation => 'Информация об обновлениях';
  @override
  String get currentVersion => 'Текущая версия';
  @override
  String get latestVersion => 'Последняя версия';
  @override
  String get lastChecked => 'Последняя проверка';
  @override
  String get checkingForUpdates => 'Проверка...';
  @override
  String get whatsNew => 'Что нового';
  @override
  String get systemInformation => 'Системная информация';
  @override
  String get dartVersion => 'Версия Dart';
  @override
  String get diskSpace => 'Доступное место на диске';
  @override
  String get memoryUsage => 'Использование памяти';
  @override
  String get privacyTitle => 'Конфиденциальность и телеметрия';
  @override
  String get usageStats => 'Анонимная статистика использования';
  @override
  String get requiresFirebase => 'Требуется настройка Firebase';
  @override
  String get featureUnavailable => 'Функция недоступна (требуется Firebase)';
  @override
  String get settingsManagement => 'Управление настройками';
  @override
  String get settingsManagementDescription =>
      'Экспортируйте настройки в файл для резервного копирования или переноса на другие устройства.';
  @override
  String get resetAll => 'Сбросить все';
  @override
  String get links => 'Ссылки';
  @override
  String get githubRepo => 'Репозиторий GitHub';
  @override
  String get privacyPolicy => 'Политика конфиденциальности';
  @override
  String get crashReporting => 'Отчёты об ошибках';
}

// Path: settings.onboarding
class _TranslationsSettingsOnboardingRu
    implements TranslationsSettingsOnboardingEn {
  _TranslationsSettingsOnboardingRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get skipTutorial => 'Пропустить обучение';
  @override
  String get gettingStarted => 'Начало работы';
  @override
  String stepProgress({required Object current, required Object total}) =>
      '${current} из ${total}';
  @override
  String get loadSampleData => 'Загрузить примеры данных';
  @override
  late final _TranslationsSettingsOnboardingStepsRu steps =
      _TranslationsSettingsOnboardingStepsRu._(_root);
}

// Path: settings.settingsView
class _TranslationsSettingsSettingsViewRu
    implements TranslationsSettingsSettingsViewEn {
  _TranslationsSettingsSettingsViewRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String resetCategoryTitle({required Object category}) =>
      'Сбросить ${category}?';
  @override
  String get resetCategoryContent =>
      'Это сбросит все настройки в этой категории к значениям по умолчанию.';
  @override
  String get resetAllTitle => 'Сбросить все настройки?';
  @override
  String get resetAllContent =>
      'Это навсегда сбросит все настройки к заводским значениям. Это действие нельзя отменить.';
  @override
  String get resetAll => 'Сбросить все';
  @override
  String resetSuccess({required Object category}) =>
      '${category} сброшены к значениям по умолчанию';
  @override
  String get errorLoading => 'Ошибка загрузки настроек';
  @override
  String get settingsSaved => 'Настройки сохранены';
  @override
  String updateAvailable({required Object version}) =>
      'Доступно обновление: v${version}';
  @override
  String get latestVersion => 'Вы используете последнюю версию';
  @override
  String whatsNew({required Object version}) => 'Что нового в v${version}';
  @override
  String get downloadUpdate => 'Скачать обновление';
  @override
  String get exportSettings => 'Экспорт настроек';
  @override
  String get settingsExported => 'Настройки экспортированы';
  @override
  String exportFail({required Object error}) =>
      'Не удалось экспортировать настройки: ${error}';
  @override
  String get importSettings => 'Импорт настроек';
  @override
  String get importTitle => 'Импортировать настройки?';
  @override
  String get importContent =>
      'Это заменит все текущие настройки импортированными. Это действие нельзя отменить.';
  @override
  String get importSuccess => 'Настройки успешно импортированы!';
  @override
  String importFail({required Object error}) =>
      'Не удалось импортировать настройки: ${error}';
  @override
  String get invalidFormat => 'Неверный формат файла настроек';
  @override
  late final _TranslationsSettingsSettingsViewCategoriesRu categories =
      _TranslationsSettingsSettingsViewCategoriesRu._(_root);
  @override
  late final _TranslationsSettingsSettingsViewCategoryLabelsRu categoryLabels =
      _TranslationsSettingsSettingsViewCategoryLabelsRu._(_root);
}

// Path: compare.tabs
class _TranslationsCompareTabsRu implements TranslationsCompareTabsEn {
  _TranslationsCompareTabsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get files => 'Файлы';
  @override
  String get directories => 'Каталоги';
  @override
  String get git => 'Git';
}

// Path: compare.fileTypes
class _TranslationsCompareFileTypesRu
    implements TranslationsCompareFileTypesEn {
  _TranslationsCompareFileTypesRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get json => 'Файлы локализации JSON (i18next, Flutter и др.)';
  @override
  String get yaml => 'Файлы локализации YAML (Rails, Flutter)';
  @override
  String get xml => 'Файлы локализации XML (Android, .NET)';
  @override
  String get properties => 'Файлы свойств (Java)';
  @override
  String get resx => 'Файлы RESX (.NET)';
  @override
  String get xliff => 'Файлы XLIFF';
}

// Path: history.timeAgo
class _TranslationsHistoryTimeAgoRu implements TranslationsHistoryTimeAgoEn {
  _TranslationsHistoryTimeAgoRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get justNow => 'только что';
  @override
  String secondsAgo({required Object count}) => '${count} сек. назад';
  @override
  String get oneMinuteAgo => '1 минуту назад';
  @override
  String minutesAgo({required Object count}) => '${count} мин. назад';
  @override
  String get oneHourAgo => '1 час назад';
  @override
  String hoursAgo({required Object count}) => '${count} ч. назад';
  @override
  String get yesterday => 'вчера';
  @override
  String daysAgo({required Object count}) => '${count} дн. назад';
  @override
  String get oneWeekAgo => '1 неделю назад';
  @override
  String weeksAgo({required Object count}) => '${count} нед. назад';
  @override
  String get oneMonthAgo => '1 месяц назад';
  @override
  String monthsAgo({required Object count}) => '${count} мес. назад';
  @override
  String get oneYearAgo => '1 год назад';
  @override
  String yearsAgo({required Object count}) => '${count} г. назад';
  @override
  String get inTheFuture => 'в будущем';
}

// Path: projects.stats
class _TranslationsProjectsStatsRu implements TranslationsProjectsStatsEn {
  _TranslationsProjectsStatsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get empty => 'Пустой проект';
  @override
  String files({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(
        n,
        one: '1 файл перевода',
        other: '${count} файлов перевода',
      );
  @override
  String languages({required num n, required Object count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(
        n,
        one: '1 язык',
        other: '${count} языков',
      );
}

// Path: projects.selection
class _TranslationsProjectsSelectionRu
    implements TranslationsProjectsSelectionEn {
  _TranslationsProjectsSelectionRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get selectFolder => 'Выбрать папку проекта';
  @override
  String get selectArchive => 'Выбрать архив проекта';
  @override
  String get openProject => 'Открыть проект';
  @override
  String get browseFolder => 'Обзор папки...';
  @override
  String get createNew => 'Создать новый';
  @override
  String get importFromZip => 'Импорт из Zip...';
}

// Path: projects.createDialog
class _TranslationsProjectsCreateDialogRu
    implements TranslationsProjectsCreateDialogEn {
  _TranslationsProjectsCreateDialogRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Создать проект';
  @override
  String get description =>
      'Проект позволяет сохранять настройки для конкретной папки. Будет создана папка ".localizer" для настроек.';
  @override
  String get folderLabel => 'Папка проекта';
  @override
  String get folderHint => 'Выберите папку...';
  @override
  String get nameLabel => 'Название проекта';
  @override
  String get nameHint => 'Например: Мой Проект';
  @override
  String get selectFolderWarning => 'Пожалуйста, выберите папку проекта.';
  @override
  String get enterNameError => 'Пожалуйста, введите название проекта';
  @override
  String get nameLengthError => 'Название должно быть не короче 2 символов';
  @override
  String success({required Object name}) => 'Проект "${name}" успешно создан!';
  @override
  String get failure => 'Не удалось создать проект.';
  @override
  String get creating => 'Создание...';
  @override
  String get createAction => 'Создать проект';
}

// Path: projects.indicator
class _TranslationsProjectsIndicatorRu
    implements TranslationsProjectsIndicatorEn {
  _TranslationsProjectsIndicatorRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get tooltipNoProject => 'Создайте проект для сохранения настроек';
  @override
  String tooltipProject({required Object name}) =>
      'Проект: ${name}\nНажмите для опций';
  @override
  String get location => 'Расположение';
  @override
  String get created => 'Создан';
  @override
  String get switchProject => 'Сменить проект';
  @override
  String get done => 'Готово';
}

// Path: projects.glossary
class _TranslationsProjectsGlossaryRu
    implements TranslationsProjectsGlossaryEn {
  _TranslationsProjectsGlossaryRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Глоссарий проекта';
  @override
  String get description => 'Определите термины для единообразия перевода.';
  @override
  String get noTerms => 'Нет терминов.';
  @override
  String get noTermsDesc =>
      'Добавьте термины, которые должны быть согласованы,\nили бренды, которые не нужно переводить.';
  @override
  String get doNotTranslate => 'Не переводить';
  @override
  String get noSpecificTranslation => 'Нет конкретного перевода';
  @override
  String get addTerm => 'Добавить термин';
  @override
  String get editTerm => 'Редактировать термин';
  @override
  String get term => 'Термин';
  @override
  String get termHint => 'Например: бренд, спец. термин';
  @override
  String get definition => 'Определение (необязательно)';
  @override
  String get definitionHint => 'Контекст для переводчика';
  @override
  String get doNotTranslateLabel => 'Не переводить';
  @override
  String get doNotTranslateDesc => 'Оставить как есть в переводе';
  @override
  String get preferredTranslation => 'Предпочтительный перевод';
  @override
  String get caseSensitive => 'Учитывать регистр';
}

// Path: projects.conflicts
class _TranslationsProjectsConflictsRu
    implements TranslationsProjectsConflictsEn {
  _TranslationsProjectsConflictsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String missingApiKeyTitle({required Object service}) =>
      'Нет API ключа для ${service}';
  @override
  String missingApiKeyMessage({required Object service}) =>
      'Этот проект использует ${service}, но ключ не настроен. Добавьте ключ в Настройки > ИИ, или будет использован глобальный.';
  @override
  String get dismiss => 'Закрыть';
}

// Path: projects.tm
class _TranslationsProjectsTmRu implements TranslationsProjectsTmEn {
  _TranslationsProjectsTmRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Память переводов';
  @override
  String get description =>
      'Управление источниками памяти переводов для проекта.';
  @override
  String get globalTm => 'Глобальная память переводов';
  @override
  String get globalTmDescription => 'Использовать общую память из настроек';
  @override
  String get linkedFiles => 'Связанные файлы (Проект)';
  @override
  String get noLinkedFiles => 'Нет связанных файлов проекта.';
  @override
  String get addTmFile => 'Добавить файл TM';
  @override
  String get useGlobalTm => 'Исп. глобальную TM';
  @override
  String get selectTm => 'Выберите память переводов';
  @override
  String get globalTmEnabled => 'Глобальная память переводов включена';
}

// Path: git.conflicts
class _TranslationsGitConflictsRu implements TranslationsGitConflictsEn {
  _TranslationsGitConflictsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Обнаружены Merge Conflicts';
  @override
  String get description =>
      'Вы должны разрешить эти Conflicts, прежде чем продолжить.';
  @override
  String get abortMergeTitle => 'Отменить Merge?';
  @override
  String get abortMergeContent =>
      'Это отменит все изменения Merge и вернёт состояние до Merge. Это действие нельзя отменить.';
  @override
  String get abortMergeAction => 'Отменить Merge';
  @override
  String stagingFile({required Object file}) =>
      'Добавление ${file} для Commit...';
  @override
  String conflictedFilesCount({required Object count}) =>
      'Файлы с Conflicts (${count})';
  @override
  String get selectFileToResolve => 'Выберите файл для разрешения';
  @override
  String resolvingFile({required Object file}) => 'Разрешение: ${file}';
  @override
  String get keepAllOurs => 'Оставить все наши';
  @override
  String get acceptAllTheirs => 'Принять все их';
  @override
  String get allResolved => 'Все Conflicts в этом файле разрешены!';
  @override
  String get markResolved => 'Отметить как разрешённое';
  @override
  String get stageForCommit => 'Это добавит файл для Commit.';
  @override
  String conflictIndex({required Object index}) => 'Conflict #${index}';
  @override
  String get ours => 'НАШЕ (Текущее)';
  @override
  String get theirs => 'ИХ (Входящее)';
  @override
  String get keepOurs => 'Оставить наше';
  @override
  String get acceptTheirs => 'Принять их';
  @override
  String get empty => '(Пусто)';
}

// Path: wizards.firstRun
class _TranslationsWizardsFirstRunRu implements TranslationsWizardsFirstRunEn {
  _TranslationsWizardsFirstRunRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get welcome => 'Добро пожаловать в Localizer';
  @override
  String get description => 'Сравните ваши файлы локализации за секунды.';
  @override
  String get sourceFile => 'Исходный файл';
  @override
  String get targetFile => 'Целевой файл';
  @override
  String get compareNow => 'Сравнить сейчас';
  @override
  String get trySample => 'Попробовать пример';
  @override
  String get skip => 'Пропустить настройку';
  @override
  String get browse => 'Нажмите для выбора';
  @override
  String error({required Object error}) =>
      'Не удалось загрузить пример: ${error}';
}

// Path: dialogs.addIgnorePattern
class _TranslationsDialogsAddIgnorePatternRu
    implements TranslationsDialogsAddIgnorePatternEn {
  _TranslationsDialogsAddIgnorePatternRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Добавить шаблон игнорирования';
  @override
  String get patternLabel => 'Шаблон (regex)';
  @override
  String get hint => 'например, ^temp_.*';
  @override
  String get invalid => 'Неверный regex шаблон';
  @override
  String get testStringLabel => 'Тестовая строка';
  @override
  String get testHint => 'Введите ключ для проверки';
  @override
  String get match => '✓ Шаблон совпадает';
  @override
  String get noMatch => '✗ Шаблон не совпадает';
  @override
  String get add => 'Добавить';
  @override
  String get cancel => 'Отмена';
}

// Path: dialogs.diffViewer
class _TranslationsDialogsDiffViewerRu
    implements TranslationsDialogsDiffViewerEn {
  _TranslationsDialogsDiffViewerRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Просмотр различий';
  @override
  String get originalFile => 'Оригинал/Эталонный файл';
  @override
  String get translationFile => 'Перевод/Файл сравнения';
  @override
  String get base => 'БАЗА';
  @override
  String get target => 'ЦЕЛЬ';
  @override
  String get added => 'Добавлено';
  @override
  String get removed => 'Удалено';
  @override
  String get modified => 'Изменено';
  @override
  String get noMatches => 'Нет записей, соответствующих фильтрам';
  @override
  String get clickToggle => 'Нажмите значки выше для переключения фильтров';
  @override
  String get clickToHide => '(нажмите чтобы скрыть)';
  @override
  String get clickToShow => '(нажмите чтобы показать)';
}

// Path: grid.columns
class _TranslationsGridColumnsRu implements TranslationsGridColumnsEn {
  _TranslationsGridColumnsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'Ключ';
  @override
  String get source => 'Источник';
  @override
  String get status => 'Статус';
  @override
  String get actions => 'Действия';
}

// Path: advancedDiff.aiSuggestion
class _TranslationsAdvancedDiffAiSuggestionRu
    implements TranslationsAdvancedDiffAiSuggestionEn {
  _TranslationsAdvancedDiffAiSuggestionRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get aiTranslation => 'ИИ-перевод';
  @override
  String get aiRephrase => 'ИИ-перефразирование';
  @override
  String key({required Object key}) => 'Ключ: ${key}';
  @override
  String get original => 'Оригинал:';
  @override
  String get suggestion => 'Предложение:';
  @override
  String get confidence => 'Уверенность ИИ';
  @override
  String get cancelEdit => 'Отменить редактирование';
  @override
  String get editSuggestion => 'Редактировать предложение';
  @override
  String get alternatives => 'Альтернативы:';
  @override
  String get accept => 'Принять';
  @override
  String get reject => 'Отклонить';
  @override
  String get stop => 'Стоп';
}

// Path: advancedDiff.detailEdit
class _TranslationsAdvancedDiffDetailEditRu
    implements TranslationsAdvancedDiffDetailEditEn {
  _TranslationsAdvancedDiffDetailEditRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object key}) => 'Редактирование: ${key}';
  @override
  String get sourceLabel => 'ИСТОЧНИК (Оригинал)';
  @override
  String get targetLabel => 'ЦЕЛЬ (Перевод)';
  @override
  String get translateWithCloud => 'Перевести через облако';
  @override
  String get translateWithAi => 'Перевести с ИИ';
  @override
  String get translating => 'Перевод...';
  @override
  String get applyAndTm => 'Применить';
  @override
  String get entryApplied => 'Запись применена и добавлена в память переводов';
  @override
  String get translationAdded => 'Предложение перевода добавлено.';
  @override
  String get aiSuggestionAdded => 'ИИ-предложение добавлено.';
}

// Path: advancedDiff.table
class _TranslationsAdvancedDiffTableRu
    implements TranslationsAdvancedDiffTableEn {
  _TranslationsAdvancedDiffTableRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get addedToTM => 'Добавлено в память переводов';
  @override
  String get markedReviewed => 'Отмечено как проверенное ✓';
  @override
  String get unmarkedReview => 'Отметка проверки снята';
  @override
  String get reverted => 'Возвращено к исходному значению';
  @override
  String get entryDeleted => 'Запись удалена';
  @override
  String get noSourceText => 'Нет исходного текста для перевода.';
  @override
  String aiTranslationFailed({required Object key}) =>
      'ИИ-перевод не удался для "${key}"';
  @override
  String get noTargetText => 'Нет целевого текста для перефразирования.';
  @override
  String aiRephraseFailed({required Object key}) =>
      'ИИ-перефразирование не удалось для "${key}"';
  @override
  String get checkRowsFirst => 'Сначала отметьте строки с помощью флажков';
  @override
  String markedRowsReviewed({required Object count}) =>
      'Отмечено ${count} строк как проверенные';
  @override
  String revertedRows({required Object count}) => 'Возвращено ${count} строк';
  @override
  String entriesCount({required Object count}) => '${count} записей';
  @override
  String get markSelectedReviewed => 'Отметить выбранные как проверенные';
  @override
  String get revertSelected => 'Вернуть выбранные';
  @override
  String get noDifferences => 'Различия не найдены';
  @override
  String get adjustFilters => 'Попробуйте изменить фильтры';
  @override
  String get cloudTranslationApplied => 'Облачный перевод применён.';
  @override
  String get aiTranslationApplied => 'ИИ-перевод применён.';
  @override
  String get suggestionApplied => 'Предложение применено.';
  @override
  String get aiSuggestionApplied => 'ИИ-предложение применено.';
  @override
  String get rephraseApplied => 'Перефразирование применено.';
  @override
  String get aiRephraseApplied => 'ИИ-перефразирование применено.';
  @override
  String get rephrase => 'Перефразировать';
  @override
  String get aiRephrase => 'ИИ-перефразирование';
  @override
  String get targetClickToEdit => 'ЦЕЛЬ (Нажмите для редактирования)';
  @override
  String get targetClickForDialog => 'ЦЕЛЬ (Нажмите для диалога)';
  @override
  String get emptyClickToEdit => '(Пусто — нажмите для редактирования)';
  @override
  String get unmarkReviewed => 'Снять отметку проверки';
  @override
  String get markReviewed => 'Отметить как проверенное';
  @override
  String get revertToSource => 'Вернуть к источнику';
  @override
  String get translateWithCloud => 'Перевести через облако';
  @override
  String get translateWithAi => 'Перевести с ИИ';
  @override
  String get rephraseWithAi => 'Перефразировать с ИИ';
  @override
  String get moreActions => 'Дополнительные действия';
  @override
  String get editDetails => 'Редактировать детали';
  @override
  String get suggestTranslation => 'Предложить перевод';
  @override
  String get addToTm => 'Добавить в память переводов';
  @override
  String get deleteEntry => 'Удалить запись';
}

// Path: advancedDiff.diffRow
class _TranslationsAdvancedDiffDiffRowRu
    implements TranslationsAdvancedDiffDiffRowEn {
  _TranslationsAdvancedDiffDiffRowRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get copySource => 'Копировать исходный текст';
  @override
  String get actions => 'Действия';
}

// Path: advancedDiff.status
class _TranslationsAdvancedDiffStatusRu
    implements TranslationsAdvancedDiffStatusEn {
  _TranslationsAdvancedDiffStatusRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get added => 'ДОБАВЛЕНО';
  @override
  String get missing => 'ОТСУТСТВУЕТ';
  @override
  String changed({required Object percent}) => 'ИЗМ ${percent}%';
  @override
  String get same => 'БЕЗ ИЗМЕНЕНИЙ';
}

// Path: advancedDiff.sidebar
class _TranslationsAdvancedDiffSidebarRu
    implements TranslationsAdvancedDiffSidebarEn {
  _TranslationsAdvancedDiffSidebarRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get widgets => 'Виджеты';
  @override
  String get searchPlaceholder => 'Поиск ключей и значений... (Ctrl+F)';
  @override
  String get fuzzySearchTooltip => 'Нечёткий поиск (с учётом опечаток)';
  @override
  String get regexSearchTooltip => 'Поиск по регулярным выражениям';
  @override
  String get cloudTranslation => 'Облачный перевод';
  @override
  String get aiTranslation => 'ИИ-перевод';
  @override
  String get status => 'Статус';
  @override
  String get tm => 'Память переводов';
  @override
  String get filters => 'Фильтры';
  @override
  String get actions => 'Действия';
  @override
  String get similarity => 'Схожесть';
  @override
  late final _TranslationsAdvancedDiffSidebarActionsSectionRu actionsSection =
      _TranslationsAdvancedDiffSidebarActionsSectionRu._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarAiSectionRu aiSection =
      _TranslationsAdvancedDiffSidebarAiSectionRu._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarTmSectionRu tmSection =
      _TranslationsAdvancedDiffSidebarTmSectionRu._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarFiltersSectionRu filtersSection =
      _TranslationsAdvancedDiffSidebarFiltersSectionRu._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarSimilaritySectionRu
      similaritySection =
      _TranslationsAdvancedDiffSidebarSimilaritySectionRu._(_root);
  @override
  late final _TranslationsAdvancedDiffSidebarStatusSectionRu statusSection =
      _TranslationsAdvancedDiffSidebarStatusSectionRu._(_root);
}

// Path: issueDetails.duplicateValue
class _TranslationsIssueDetailsDuplicateValueRu
    implements TranslationsIssueDetailsDuplicateValueEn {
  _TranslationsIssueDetailsDuplicateValueRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'ПОВТОРЯЮЩИЙСЯ ПЕРЕВОД';
  @override
  String get warning =>
      'Разные исходные тексты используют этот же перевод. Проверьте контекст.';
  @override
  String affectedKeys({required Object count}) => 'ЗАТРОНУТЫЕ КЛЮЧИ (${count})';
  @override
  String get identicalSources => 'Идентичные источники';
  @override
  String moreKeys({required Object count}) => '+${count} ещё ключей';
}

// Path: issueDetails.lengthOutlier
class _TranslationsIssueDetailsLengthOutlierRu
    implements TranslationsIssueDetailsLengthOutlierEn {
  _TranslationsIssueDetailsLengthOutlierRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get source => 'ИСТОЧНИК';
  @override
  String get translation => 'ПЕРЕВОД';
  @override
  String chars({required Object count}) => '${count} символов';
}

// Path: issueDetails.standard
class _TranslationsIssueDetailsStandardRu
    implements TranslationsIssueDetailsStandardEn {
  _TranslationsIssueDetailsStandardRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get key => 'КЛЮЧ';
  @override
  String get sourceText => 'ИСХОДНЫЙ ТЕКСТ';
  @override
  String get translation => 'ПЕРЕВОД';
  @override
  String get errorDetails => 'ДЕТАЛИ ОШИБКИ';
  @override
  String get note => 'ПРИМЕЧАНИЕ';
}

// Path: issueDetails.types
class _TranslationsIssueDetailsTypesRu
    implements TranslationsIssueDetailsTypesEn {
  _TranslationsIssueDetailsTypesRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get duplicateValue => 'Дублирующиеся значения';
  @override
  String get lengthOutlier => 'Несоответствие длины';
  @override
  String get placeholderMismatch => 'Несоответствие плейсхолдеров';
}

// Path: issueDetails.notes
class _TranslationsIssueDetailsNotesRu
    implements TranslationsIssueDetailsNotesEn {
  _TranslationsIssueDetailsNotesRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get placeholderMismatch =>
      'Маркеры типа {name} должны совпадать с источником.';
  @override
  String get lengthOutlier =>
      'Большие изменения длины могут влиять на отображение текста на экране.';
  @override
  String get duplicateValue =>
      'Один и тот же перевод используется для разных ключей.';
}

// Path: issueDetails.fallbacks
class _TranslationsIssueDetailsFallbacksRu
    implements TranslationsIssueDetailsFallbacksEn {
  _TranslationsIssueDetailsFallbacksRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get multipleSources => 'Несколько исходных текстов';
  @override
  String get sourceNotAvailable => 'Исходный текст недоступен';
  @override
  String get sharedTranslationNotAvailable => 'Общий перевод недоступен';
  @override
  String get translationNotAvailable => 'Перевод недоступен';
}

// Path: tutorial.steps
class _TranslationsTutorialStepsRu implements TranslationsTutorialStepsEn {
  _TranslationsTutorialStepsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTutorialStepsImportSourceRu importSource =
      _TranslationsTutorialStepsImportSourceRu._(_root);
  @override
  late final _TranslationsTutorialStepsImportTargetRu importTarget =
      _TranslationsTutorialStepsImportTargetRu._(_root);
  @override
  late final _TranslationsTutorialStepsCompareRu compare =
      _TranslationsTutorialStepsCompareRu._(_root);
  @override
  late final _TranslationsTutorialStepsFilterRu filter =
      _TranslationsTutorialStepsFilterRu._(_root);
  @override
  late final _TranslationsTutorialStepsSearchRu search =
      _TranslationsTutorialStepsSearchRu._(_root);
  @override
  late final _TranslationsTutorialStepsAdvancedRu advanced =
      _TranslationsTutorialStepsAdvancedRu._(_root);
  @override
  late final _TranslationsTutorialStepsExportRu export =
      _TranslationsTutorialStepsExportRu._(_root);
}

// Path: friendlyErrors.fileNotFound
class _TranslationsFriendlyErrorsFileNotFoundRu
    implements TranslationsFriendlyErrorsFileNotFoundEn {
  _TranslationsFriendlyErrorsFileNotFoundRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Файл или папка не найдены.';
  @override
  String get suggestion => 'Проверьте, не был ли файл перемещён или удалён.';
}

// Path: friendlyErrors.accessDenied
class _TranslationsFriendlyErrorsAccessDeniedRu
    implements TranslationsFriendlyErrorsAccessDeniedEn {
  _TranslationsFriendlyErrorsAccessDeniedRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'В доступе к файлу отказано.';
  @override
  String get suggestion =>
      'Попробуйте запустить приложение от имени администратора или проверьте права доступа.';
}

// Path: friendlyErrors.isDirectory
class _TranslationsFriendlyErrorsIsDirectoryRu
    implements TranslationsFriendlyErrorsIsDirectoryEn {
  _TranslationsFriendlyErrorsIsDirectoryRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Выбрана папка вместо файла.';
  @override
  String get suggestion => 'Пожалуйста, выберите корректный файл.';
}

// Path: friendlyErrors.fileAccess
class _TranslationsFriendlyErrorsFileAccessRu
    implements TranslationsFriendlyErrorsFileAccessEn {
  _TranslationsFriendlyErrorsFileAccessRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Проблема с доступом к файлу.';
  @override
  String get suggestion =>
      'Попробуйте закрыть другие программы, которые могут его использовать.';
}

// Path: friendlyErrors.unsupportedFormat
class _TranslationsFriendlyErrorsUnsupportedFormatRu
    implements TranslationsFriendlyErrorsUnsupportedFormatEn {
  _TranslationsFriendlyErrorsUnsupportedFormatRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Этот формат файла или операция не поддерживаются.';
  @override
  String get suggestion =>
      'Проверьте расширение файла или попробуйте другой формат.';
}

// Path: friendlyErrors.networkError
class _TranslationsFriendlyErrorsNetworkErrorRu
    implements TranslationsFriendlyErrorsNetworkErrorEn {
  _TranslationsFriendlyErrorsNetworkErrorRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Не удалось подключиться к серверу.';
  @override
  String get suggestion =>
      'Проверьте подключение к интернету и попробуйте снова.';
}

// Path: friendlyErrors.notGitRepo
class _TranslationsFriendlyErrorsNotGitRepoRu
    implements TranslationsFriendlyErrorsNotGitRepoEn {
  _TranslationsFriendlyErrorsNotGitRepoRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Эта папка не является Git-проектом.';
  @override
  String get suggestion => 'Перейдите в папку, содержащую каталог .git.';
}

// Path: friendlyErrors.mergeConflict
class _TranslationsFriendlyErrorsMergeConflictRu
    implements TranslationsFriendlyErrorsMergeConflictEn {
  _TranslationsFriendlyErrorsMergeConflictRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'В репозитории есть конфликты слияния.';
  @override
  String get suggestion => 'Разрешите конфликты перед продолжением.';
}

// Path: friendlyErrors.gitAuthFailed
class _TranslationsFriendlyErrorsGitAuthFailedRu
    implements TranslationsFriendlyErrorsGitAuthFailedEn {
  _TranslationsFriendlyErrorsGitAuthFailedRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Ошибка аутентификации Git.';
  @override
  String get suggestion =>
      'Проверьте ваши учетные данные в Настройки > Контроль версий.';
}

// Path: friendlyErrors.gitOperationFailed
class _TranslationsFriendlyErrorsGitOperationFailedRu
    implements TranslationsFriendlyErrorsGitOperationFailedEn {
  _TranslationsFriendlyErrorsGitOperationFailedRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Ошибка операции Git.';
  @override
  String get suggestion => 'Проверьте Git view для деталей.';
}

// Path: friendlyErrors.invalidJson
class _TranslationsFriendlyErrorsInvalidJsonRu
    implements TranslationsFriendlyErrorsInvalidJsonEn {
  _TranslationsFriendlyErrorsInvalidJsonRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Формат файла неверный или повреждён.';
  @override
  String get suggestion => 'Убедитесь, что файл содержит корректный JSON.';
}

// Path: friendlyErrors.rateLimitReached
class _TranslationsFriendlyErrorsRateLimitReachedRu
    implements TranslationsFriendlyErrorsRateLimitReachedEn {
  _TranslationsFriendlyErrorsRateLimitReachedRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Лимит переводов достигнут.';
  @override
  String get suggestion =>
      'Подождите несколько минут или проверьте лимиты вашего API-плана.';
}

// Path: friendlyErrors.invalidApiKey
class _TranslationsFriendlyErrorsInvalidApiKeyRu
    implements TranslationsFriendlyErrorsInvalidApiKeyEn {
  _TranslationsFriendlyErrorsInvalidApiKeyRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Неверный API ключ.';
  @override
  String get suggestion =>
      'Перейдите в Настройки > ИИ перевод для обновления ключа.';
}

// Path: friendlyErrors.translationServiceError
class _TranslationsFriendlyErrorsTranslationServiceErrorRu
    implements TranslationsFriendlyErrorsTranslationServiceErrorEn {
  _TranslationsFriendlyErrorsTranslationServiceErrorRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Ошибка сервиса перевода.';
  @override
  String get suggestion => 'Проверьте ваш API ключ и интернет-соединение.';
}

// Path: friendlyErrors.outOfMemory
class _TranslationsFriendlyErrorsOutOfMemoryRu
    implements TranslationsFriendlyErrorsOutOfMemoryEn {
  _TranslationsFriendlyErrorsOutOfMemoryRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Недостаточно памяти для выполнения операции.';
  @override
  String get suggestion =>
      'Попробуйте закрыть другие приложения или использовать файлы меньшего размера.';
}

// Path: friendlyErrors.genericError
class _TranslationsFriendlyErrorsGenericErrorRu
    implements TranslationsFriendlyErrorsGenericErrorEn {
  _TranslationsFriendlyErrorsGenericErrorRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get message => 'Что-то пошло не так.';
  @override
  String get suggestion =>
      'Пожалуйста, попробуйте снова. Если проблема сохраняется, перезапустите приложение.';
}

// Path: settings.appearance.presets
class _TranslationsSettingsAppearancePresetsRu
    implements TranslationsSettingsAppearancePresetsEn {
  _TranslationsSettingsAppearancePresetsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get presetDefault => 'По умолчанию';
  @override
  String get presetColorblind => 'Для дальтоников';
  @override
  String get presetHighContrast => 'Высокий контраст';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.appearance.preview
class _TranslationsSettingsAppearancePreviewRu
    implements TranslationsSettingsAppearancePreviewEn {
  _TranslationsSettingsAppearancePreviewRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get step3Title => 'onboarding.step3.title';
  @override
  String get connectAccount => '"Подключите аккаунт"';
  @override
  String get loginHint => 'deprecated.login_hint_v1';
  @override
  String get enterCredentials => '"Введите учётные данные"';
  @override
  String get ctaButton => 'checkout.cta_button';
  @override
  String get buyNow => '"Купить сейчас"';
  @override
  String get completePurchase => '"Завершить покупку"';
  @override
  String get appNameKey => 'common.app_name';
  @override
  String get appNameValue => '"Localizer"';
}

// Path: settings.comparison.patternPresets
class _TranslationsSettingsComparisonPatternPresetsRu
    implements TranslationsSettingsComparisonPatternPresetsEn {
  _TranslationsSettingsComparisonPatternPresetsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get comments => 'Комментарии';
  @override
  String get tempKeys => 'Временные ключи';
  @override
  String get placeholders => 'Плейсхолдеры';
  @override
  String get devOnly => 'Только для разработки';
}

// Path: settings.comparison.previewMatch
class _TranslationsSettingsComparisonPreviewMatchRu
    implements TranslationsSettingsComparisonPreviewMatchEn {
  _TranslationsSettingsComparisonPreviewMatchRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Предпросмотр соответствия';
  @override
  String get description =>
      'Проверьте, как текущие настройки влияют на логику сопоставления.';
  @override
  String get stringA => 'Строка A';
  @override
  String get stringB => 'Строка B';
  @override
  String get enterText => 'Введите текст...';
  @override
  String get similarity => 'Схожесть';
  @override
  String get identical => 'Идентичные';
  @override
  String get identicalDescription => 'Строки совпадают после нормализации.';
  @override
  String get ignored => 'Игнорируется';
  @override
  String get ignoredDescription => 'Ввод соответствует игнорируемому шаблону.';
  @override
  String get different => 'Различные';
  @override
  String get differentDescription => 'Одно из значений пустое.';
  @override
  String get similarModified => 'Похожие / Изменённые';
  @override
  String similarModifiedDescription({required Object threshold}) =>
      'Оценка совпадения выше порога (${threshold}%).';
  @override
  String get newDifferent => 'Новые / Различные';
  @override
  String newDifferentDescription({required Object threshold}) =>
      'Оценка совпадения ниже порога (${threshold}%).';
}

// Path: settings.comparison.colorPresets
class _TranslationsSettingsComparisonColorPresetsRu
    implements TranslationsSettingsComparisonColorPresetsEn {
  _TranslationsSettingsComparisonColorPresetsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get kDefault => 'По умолчанию';
  @override
  String get colorblindFriendly => 'Для дальтоников';
  @override
  String get highContrast => 'Высокий контраст';
  @override
  String get nord => 'Nord';
  @override
  String get solarized => 'Solarized';
  @override
  String get monokai => 'Monokai';
  @override
  String get presetDefault => 'По умолчанию';
  @override
  String get presetColorblind => 'Для дальтоников';
  @override
  String get presetHighContrast => 'Высокий контраст';
  @override
  String get presetNord => 'Nord';
  @override
  String get presetSolarized => 'Solarized';
  @override
  String get presetMonokai => 'Monokai';
}

// Path: settings.integrations.materials
class _TranslationsSettingsIntegrationsMaterialsRu
    implements TranslationsSettingsIntegrationsMaterialsEn {
  _TranslationsSettingsIntegrationsMaterialsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get sidebar => 'Боковая панель';
  @override
  String get menu => 'Меню';
  @override
  String get popover => 'Всплывающее окно';
  @override
  String get titlebar => 'Заголовок окна';
  @override
  String get underPageBackground => 'Фон страницы';
  @override
  String get contentBackground => 'Содержимое';
}

// Path: settings.integrations.fileTypes
class _TranslationsSettingsIntegrationsFileTypesRu
    implements TranslationsSettingsIntegrationsFileTypesEn {
  _TranslationsSettingsIntegrationsFileTypesRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get loc => 'Файл проекта Localizer';
  @override
  String get lang => 'Языковой файл';
  @override
  String get json => 'JSON-файл локализации';
  @override
  String get xml => 'XML-файл локализации';
}

// Path: settings.developer.themePlaygroundSection
class _TranslationsSettingsDeveloperThemePlaygroundSectionRu
    implements TranslationsSettingsDeveloperThemePlaygroundSectionEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get colors => 'Цвета';
  @override
  String get typography => 'Типографика';
  @override
  late final _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteRu
      palette =
      _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteRu._(_root);
}

// Path: settings.developer.featureFlags
class _TranslationsSettingsDeveloperFeatureFlagsRu
    implements TranslationsSettingsDeveloperFeatureFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Экспериментальные функции';
  @override
  String get description =>
      'Переключайте флаги функций локально для тестирования. Эти переопределения сохраняются между перезапусками приложения.';
  @override
  String get subtitle => 'Переопределение экспериментальных функций';
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsRu flags =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsRu._(_root);
  @override
  String get reset => 'Сбросить все флаги';
  @override
  String get overrides => 'Локальные переопределения';
  @override
  String get defaultVal => 'По умолчанию';
  @override
  String get on => 'ВКЛ';
  @override
  String get off => 'ВЫКЛ';
}

// Path: settings.developer.storageInspectorSection
class _TranslationsSettingsDeveloperStorageInspectorSectionRu
    implements TranslationsSettingsDeveloperStorageInspectorSectionEn {
  _TranslationsSettingsDeveloperStorageInspectorSectionRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'Обновить';
  @override
  String get hiveData => 'Данные Hive';
  @override
  String get secureStorage => 'Защищённое хранилище';
}

// Path: settings.developer.deviceInfoSection
class _TranslationsSettingsDeveloperDeviceInfoSectionRu
    implements TranslationsSettingsDeveloperDeviceInfoSectionEn {
  _TranslationsSettingsDeveloperDeviceInfoSectionRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get refresh => 'Обновить';
  @override
  String get copy => 'Копировать в буфер обмена';
  @override
  String get computerName => 'Имя компьютера';
  @override
  String get osVersion => 'Версия ОС';
}

// Path: settings.developer.localizationInspectorSection
class _TranslationsSettingsDeveloperLocalizationInspectorSectionRu
    implements TranslationsSettingsDeveloperLocalizationInspectorSectionEn {
  _TranslationsSettingsDeveloperLocalizationInspectorSectionRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get showKeys => 'Показывать ключи вместо значений';
  @override
  String get keysVisible => 'Ключи видны';
  @override
  String get normalDisplay => 'Обычное отображение';
  @override
  String get note =>
      'Примечание: Эта функция требует, чтобы локализация приложения использовала обёртку, учитывающую эту настройку.';
}

// Path: settings.onboarding.steps
class _TranslationsSettingsOnboardingStepsRu
    implements TranslationsSettingsOnboardingStepsEn {
  _TranslationsSettingsOnboardingStepsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsOnboardingStepsImportFilesRu importFiles =
      _TranslationsSettingsOnboardingStepsImportFilesRu._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsRunComparisonRu runComparison =
      _TranslationsSettingsOnboardingStepsRunComparisonRu._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsReviewMissingRu reviewMissing =
      _TranslationsSettingsOnboardingStepsReviewMissingRu._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsUseFiltersRu useFilters =
      _TranslationsSettingsOnboardingStepsUseFiltersRu._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsSearchResultsRu searchResults =
      _TranslationsSettingsOnboardingStepsSearchResultsRu._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsAdvancedViewRu advancedView =
      _TranslationsSettingsOnboardingStepsAdvancedViewRu._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsEditCellRu editCell =
      _TranslationsSettingsOnboardingStepsEditCellRu._(_root);
  @override
  late final _TranslationsSettingsOnboardingStepsExportResultsRu exportResults =
      _TranslationsSettingsOnboardingStepsExportResultsRu._(_root);
}

// Path: settings.settingsView.categories
class _TranslationsSettingsSettingsViewCategoriesRu
    implements TranslationsSettingsSettingsViewCategoriesEn {
  _TranslationsSettingsSettingsViewCategoriesRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'Общие настройки';
  @override
  String get comparisonEngine => 'Движок сравнения';
  @override
  String get appearance => 'Внешний вид';
  @override
  String get fileHandling => 'Обработка файлов';
  @override
  String get aiServices => 'ИИ-сервисы';
  @override
  String get systemIntegrations => 'Системные интеграции';
  @override
  String get projectResources =>
      'Ресурсы проекта (глоссарий и память переводов)';
  @override
  String get developer => 'Настройки разработчика';
  @override
  String get about => 'О программе';
}

// Path: settings.settingsView.categoryLabels
class _TranslationsSettingsSettingsViewCategoryLabelsRu
    implements TranslationsSettingsSettingsViewCategoryLabelsEn {
  _TranslationsSettingsSettingsViewCategoryLabelsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get general => 'Общие';
  @override
  String get comparisonEngine => 'Сравнение';
  @override
  String get appearance => 'Внешний вид';
  @override
  String get fileHandling => 'Обработка файлов';
  @override
  String get aiServices => 'ИИ-сервисы';
  @override
  String get systemIntegrations => 'Системные интеграции';
  @override
  String get projectResources => 'Ресурсы проекта';
  @override
  String get developer => 'Настройки разработчика';
  @override
  String get about => 'О программе';
}

// Path: advancedDiff.sidebar.actionsSection
class _TranslationsAdvancedDiffSidebarActionsSectionRu
    implements TranslationsAdvancedDiffSidebarActionsSectionEn {
  _TranslationsAdvancedDiffSidebarActionsSectionRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get exportMatches => 'Экспорт совпадений';
  @override
  String get preview => 'Предпросмотр';
  @override
  String get fillFromTmTitle => 'Заполнить из памяти переводов?';
  @override
  String get fillFromTmContent =>
      'Это попытается заполнить пустые целевые значения с помощью совпадений из памяти переводов. Существующие значения НЕ будут перезаписаны.';
  @override
  String get fill => 'Заполнить';
  @override
  String get fillFromMemory => 'Заполнить из памяти';
  @override
  String filledFromTm({required Object count}) =>
      'Заполнено ${count} элементов из памяти переводов.';
}

// Path: advancedDiff.sidebar.aiSection
class _TranslationsAdvancedDiffSidebarAiSectionRu
    implements TranslationsAdvancedDiffSidebarAiSectionEn {
  _TranslationsAdvancedDiffSidebarAiSectionRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get infoCloud =>
      'Использует облачный перевод для перевода пустых целевых значений из источника.';
  @override
  String get infoAi =>
      'Использует ИИ для перевода пустых целевых значений из источника.';
  @override
  String get translationSettings => 'Настройки перевода';
  @override
  String get aiSettings => 'Настройки ИИ';
  @override
  String get source => 'Источник';
  @override
  String get target => 'Цель';
  @override
  String translatingProgress({required Object percent}) =>
      'Перевод... ${percent}%';
  @override
  String get translating => 'Перевод...';
  @override
  String get translateAllMissing => 'Перевести все отсутствующие';
  @override
  String get translateAllTitle => 'Перевести все отсутствующие?';
  @override
  String translateAllContent(
          {required Object service,
          required Object source,
          required Object target}) =>
      'Это использует ${service} для перевода всех записей с пустыми целевыми значениями с ${source} на ${target}.\n\nВы можете просмотреть каждое предложение или применить все сразу.';
  @override
  String get translateAll => 'Перевести все';
  @override
  String get reviewEach => 'Просмотреть каждый';
  @override
  String cloudTranslated({required Object count}) =>
      'Переведено ${count} записей с помощью облачного перевода.';
  @override
  String aiTranslated({required Object count}) =>
      'Переведено ${count} записей с помощью ИИ.';
  @override
  String get aiTranslateFailed => 'ИИ-перевод всех не удался';
  @override
  String get noMissingEntries => 'Нет отсутствующих записей для перевода.';
  @override
  String get skip => 'Пропустить';
  @override
  String get stop => 'Стоп';
  @override
  String cloudApplied({required Object count}) =>
      'Применено ${count} предложений.';
  @override
  String aiApplied({required Object count}) =>
      'Применено ${count} ИИ-предложений.';
}

// Path: advancedDiff.sidebar.tmSection
class _TranslationsAdvancedDiffSidebarTmSectionRu
    implements TranslationsAdvancedDiffSidebarTmSectionEn {
  _TranslationsAdvancedDiffSidebarTmSectionRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get enableTmFill => 'Включить заполнение из памяти переводов';
  @override
  String get autoApplyAboveMinimum => 'Автоприменение выше минимума';
  @override
  String get matchSettings => 'Настройки сопоставления';
  @override
  String get minMatch => 'Мин. совпадение:';
  @override
  String get limit => 'Лимит:';
  @override
  String get exact => 'Точное';
}

// Path: advancedDiff.sidebar.filtersSection
class _TranslationsAdvancedDiffSidebarFiltersSectionRu
    implements TranslationsAdvancedDiffSidebarFiltersSectionEn {
  _TranslationsAdvancedDiffSidebarFiltersSectionRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get viewFilters => 'Фильтры просмотра';
  @override
  String get showAll => 'Показать все';
  @override
  String get added => 'Добавленные';
  @override
  String get removed => 'Удалённые';
  @override
  String get modified => 'Изменённые';
  @override
  String get actionScope => 'Область действия';
  @override
  String get applyToAdded => 'Применить к добавленным';
  @override
  String get applyToModified => 'Применить к изменённым';
  @override
  String get onlyFillEmptyTargets => 'Заполнять только пустые цели';
  @override
  String get limitToVisible => 'Ограничить видимыми';
  @override
  String get editMode => 'Режим редактирования';
  @override
  String get dialog => 'Диалог';
  @override
  String get inline => 'Встроенный';
}

// Path: advancedDiff.sidebar.similaritySection
class _TranslationsAdvancedDiffSidebarSimilaritySectionRu
    implements TranslationsAdvancedDiffSidebarSimilaritySectionEn {
  _TranslationsAdvancedDiffSidebarSimilaritySectionRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get currentFilter => 'Текущий фильтр:';
  @override
  String get any => 'ЛЮБАЯ';
  @override
  String get high => 'ВЫСОКАЯ';
  @override
  String get medium => 'СРЕДНЯЯ';
  @override
  String get low => 'НИЗКАЯ';
}

// Path: advancedDiff.sidebar.statusSection
class _TranslationsAdvancedDiffSidebarStatusSectionRu
    implements TranslationsAdvancedDiffSidebarStatusSectionEn {
  _TranslationsAdvancedDiffSidebarStatusSectionRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String total({required Object count}) => '${count} всего';
  @override
  String extra({required Object count}) => '${count} лишних';
  @override
  String missing({required Object count}) => '${count} отсутствует';
  @override
  String changed({required Object count}) => '${count} изменено';
}

// Path: tutorial.steps.importSource
class _TranslationsTutorialStepsImportSourceRu
    implements TranslationsTutorialStepsImportSourceEn {
  _TranslationsTutorialStepsImportSourceRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => '1. Импорт исходного файла';
  @override
  String get description =>
      'Используйте кнопку ниже для выбора файла или перетащите его в выделенную область.';
}

// Path: tutorial.steps.importTarget
class _TranslationsTutorialStepsImportTargetRu
    implements TranslationsTutorialStepsImportTargetEn {
  _TranslationsTutorialStepsImportTargetRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => '2. Импорт целевого файла';
  @override
  String get description =>
      'Используйте кнопку ниже для выбора файла или перетащите его в выделенную область.';
}

// Path: tutorial.steps.compare
class _TranslationsTutorialStepsCompareRu
    implements TranslationsTutorialStepsCompareEn {
  _TranslationsTutorialStepsCompareRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => '3. Сравнить файлы';
  @override
  String get description =>
      'Нажмите кнопку ниже, чтобы запустить сравнение и увидеть результаты.';
}

// Path: tutorial.steps.filter
class _TranslationsTutorialStepsFilterRu
    implements TranslationsTutorialStepsFilterEn {
  _TranslationsTutorialStepsFilterRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => '4. Фильтрация результатов';
  @override
  String get description =>
      'Используйте эти фильтры для просмотра добавленных, удалённых или изменённых строк.';
}

// Path: tutorial.steps.search
class _TranslationsTutorialStepsSearchRu
    implements TranslationsTutorialStepsSearchEn {
  _TranslationsTutorialStepsSearchRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => '5. Поиск результатов';
  @override
  String get description =>
      'Найдите конкретные ключи или значения с помощью строки поиска.';
}

// Path: tutorial.steps.advanced
class _TranslationsTutorialStepsAdvancedRu
    implements TranslationsTutorialStepsAdvancedEn {
  _TranslationsTutorialStepsAdvancedRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => '6. Расширенный вид';
  @override
  String get description =>
      'Откройте детальный вид diff с редактированием, ИИ-переводом и другими возможностями.';
}

// Path: tutorial.steps.export
class _TranslationsTutorialStepsExportRu
    implements TranslationsTutorialStepsExportEn {
  _TranslationsTutorialStepsExportRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => '7. Экспорт результатов';
  @override
  String get description =>
      'Сохраните сравнение в формате CSV, JSON или Excel.';
}

// Path: settings.developer.themePlaygroundSection.palette
class _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteRu
    implements TranslationsSettingsDeveloperThemePlaygroundSectionPaletteEn {
  _TranslationsSettingsDeveloperThemePlaygroundSectionPaletteRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get primary => 'Основной';
  @override
  String get onPrimary => 'На основном';
  @override
  String get secondary => 'Вторичный';
  @override
  String get onSecondary => 'На вторичном';
  @override
  String get surface => 'Поверхность';
  @override
  String get onSurface => 'На поверхности';
  @override
  String get error => 'Ошибка';
  @override
  String get onError => 'На ошибке';
  @override
  String get outline => 'Обводка';
  @override
  String get shadow => 'Тень';
  @override
  String get success => 'Успех';
  @override
  String get warning => 'Предупреждение';
  @override
  String get info => 'Информация';
}

// Path: settings.developer.featureFlags.flags
class _TranslationsSettingsDeveloperFeatureFlagsFlagsRu
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchRu
      experimental_ai_batch =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchRu._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmRu
      new_diff_algorithm =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmRu._(
          _root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchRu
      enhanced_search =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchRu._(_root);
  @override
  late final _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveRu
      auto_save =
      _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveRu._(_root);
}

// Path: settings.onboarding.steps.importFiles
class _TranslationsSettingsOnboardingStepsImportFilesRu
    implements TranslationsSettingsOnboardingStepsImportFilesEn {
  _TranslationsSettingsOnboardingStepsImportFilesRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Импорт файлов';
  @override
  String get description => 'Загрузите исходные и целевые файлы';
}

// Path: settings.onboarding.steps.runComparison
class _TranslationsSettingsOnboardingStepsRunComparisonRu
    implements TranslationsSettingsOnboardingStepsRunComparisonEn {
  _TranslationsSettingsOnboardingStepsRunComparisonRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Запуск сравнения';
  @override
  String get description => 'Нажмите "Сравнить файлы"';
}

// Path: settings.onboarding.steps.reviewMissing
class _TranslationsSettingsOnboardingStepsReviewMissingRu
    implements TranslationsSettingsOnboardingStepsReviewMissingEn {
  _TranslationsSettingsOnboardingStepsReviewMissingRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Проверка отсутствующих ключей';
  @override
  String get description => 'Обратите внимание на красные элементы MISSING';
}

// Path: settings.onboarding.steps.useFilters
class _TranslationsSettingsOnboardingStepsUseFiltersRu
    implements TranslationsSettingsOnboardingStepsUseFiltersEn {
  _TranslationsSettingsOnboardingStepsUseFiltersRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Использование фильтров';
  @override
  String get description => 'Фильтрация по типу';
}

// Path: settings.onboarding.steps.searchResults
class _TranslationsSettingsOnboardingStepsSearchResultsRu
    implements TranslationsSettingsOnboardingStepsSearchResultsEn {
  _TranslationsSettingsOnboardingStepsSearchResultsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Поиск результатов';
  @override
  String get description => 'Найдите конкретные ключи';
}

// Path: settings.onboarding.steps.advancedView
class _TranslationsSettingsOnboardingStepsAdvancedViewRu
    implements TranslationsSettingsOnboardingStepsAdvancedViewEn {
  _TranslationsSettingsOnboardingStepsAdvancedViewRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Расширенный вид';
  @override
  String get description => 'Изучите детальный анализ';
}

// Path: settings.onboarding.steps.editCell
class _TranslationsSettingsOnboardingStepsEditCellRu
    implements TranslationsSettingsOnboardingStepsEditCellEn {
  _TranslationsSettingsOnboardingStepsEditCellRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Редактирование ячейки';
  @override
  String get description => 'Нажмите для редактирования значения';
}

// Path: settings.onboarding.steps.exportResults
class _TranslationsSettingsOnboardingStepsExportResultsRu
    implements TranslationsSettingsOnboardingStepsExportResultsEn {
  _TranslationsSettingsOnboardingStepsExportResultsRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Экспорт';
  @override
  String get description => 'Сохраните отчёт';
}

// Path: settings.developer.featureFlags.flags.experimental_ai_batch
class _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchRu
    implements
        TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsExperimentalAiBatchRu._(
      this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Экспериментальный пакетный ИИ';
  @override
  String get description => 'Включить пакетный ИИ-перевод для нескольких строк';
}

// Path: settings.developer.featureFlags.flags.new_diff_algorithm
class _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmRu
    implements
        TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsNewDiffAlgorithmRu._(
      this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Новый алгоритм сравнения';
  @override
  String get description => 'Использовать улучшенный алгоритм сравнения';
}

// Path: settings.developer.featureFlags.flags.enhanced_search
class _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchRu
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsEnhancedSearchRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Улучшенный поиск';
  @override
  String get description => 'Включить нечёткий поиск в файлах перевода';
}

// Path: settings.developer.featureFlags.flags.auto_save
class _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveRu
    implements TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveEn {
  _TranslationsSettingsDeveloperFeatureFlagsFlagsAutoSaveRu._(this._root);

  final TranslationsRu _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Автосохранение';
  @override
  String get description =>
      'Автоматически сохранять изменения после редактирования';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
          'app.title' => 'Инструмент сравнения локализации',
          'app.name' => 'Localizer',
          'common.save' => 'Сохранить',
          'common.cancel' => 'Отмена',
          'common.close' => 'Закрыть',
          'common.delete' => 'Удалить',
          'common.edit' => 'Редактировать',
          'common.add' => 'Добавить',
          'common.search' => 'Поиск',
          'common.undo' => 'Отменить',
          'common.loading' => 'Загрузка...',
          'common.error' => 'Ошибка',
          'common.success' => 'Успешно',
          'common.warning' => 'Предупреждение',
          'common.info' => 'Информация',
          'common.confirm' => 'Подтвердить',
          'common.yes' => 'Да',
          'common.no' => 'Нет',
          'common.ok' => 'ОК',
          'common.retry' => 'Повторить',
          'common.copyText' => 'Копировать',
          'common.appName' => 'Localizer',
          'common.copied' => 'Скопировано!',
          'common.enabled' => 'Включено',
          'common.disabled' => 'Отключено',
          'common.browse' => 'Обзор',
          'common.clear' => 'Очистить',
          'common.apply' => 'Применить',
          'common.reset' => 'Сброс',
          'common.refresh' => 'Обновить',
          'common.export' => 'Экспорт',
          'common.import' => 'Импорт',
          'common.select' => 'Выбрать',
          'common.selectAll' => 'Выбрать все',
          'common.deselectAll' => 'Снять выделение',
          'common.noResults' => 'Результаты не найдены',
          'common.emptyState' => 'Пока ничего нет',
          'common.open' => 'Открыть',
          'common.change' => 'Изменить',
          'common.original' => 'Оригинал',
          'common.kNew' => 'Новый',
          'common.remove' => 'Удалить',
          'common.auto' => 'Авто',
          'common.execute' => 'Выполнить',
          'common.run' => 'Запустить',
          'common.unknown' => 'Неизвестно',
          'common.download' => 'Скачать',
          'common.dropdownArrow' => 'Стрелка выпадающего списка',
          'common.openInNewWindow' => 'Открывается в новом окне',
          'common.resetToDefaults' => 'Сбросить настройки',
          'menu.file' => 'Файл',
          'menu.edit' => 'Редактирование',
          'menu.view' => 'Вид',
          'menu.help' => 'Справка',
          'menu.openFiles' => 'Открыть файлы...',
          'menu.openFolder' => 'Открыть папку...',
          'menu.exportResults' => 'Экспортировать результаты...',
          'menu.undo' => 'Отменить',
          'menu.redo' => 'Повторить',
          'menu.cut' => 'Вырезать',
          'menu.paste' => 'Вставить',
          'menu.selectAll' => 'Выбрать все',
          'menu.zoomIn' => 'Увеличить',
          'menu.zoomOut' => 'Уменьшить',
          'menu.resetZoom' => 'Сбросить масштаб',
          'menu.documentation' => 'Документация',
          'menu.reportIssue' => 'Сообщить о проблеме',
          'menu.about' => ({required Object appName}) =>
              'О программе ${appName}',
          'nav.compare' => 'Сравнение',
          'nav.history' => 'История',
          'nav.settings' => 'Настройки',
          'nav.projects' => 'Проекты',
          'nav.dashboard' => 'Качество',
          'nav.directory' => 'Каталог',
          'nav.repository' => 'Репозиторий',
          'nav.tooltipCompare' => 'Сравнить файлы локализации',
          'nav.tooltipHistory' => 'Просмотр истории сравнений',
          'nav.tooltipSettings' => 'Настройки приложения',
          'nav.tooltipProjects' => 'Управление проектами',
          'nav.tooltipThemeToggle' => 'Переключить тему',
          'nav.tooltipDebugConsole' => 'Консоль отладки',
          'settings.title' => 'Настройки',
          'settings.appSettings' => 'Настройки приложения',
          'settings.projectSettings' => 'Настройки проекта',
          'settings.appearance.title' => 'Внешний вид',
          'settings.appearance.description' =>
            'Настройте внешний вид приложения',
          'settings.appearance.theme' => 'Режим темы',
          'settings.appearance.themeDescription' =>
            'Выберите светлую, тёмную или системную тему',
          'settings.appearance.themeSystem' => 'Системная',
          'settings.appearance.themeLight' => 'Светлая',
          'settings.appearance.themeDark' => 'Тёмная',
          'settings.appearance.themeAmoled' => 'AMOLED',
          'settings.appearance.accentColor' => 'Цвет акцента',
          'settings.appearance.accentColorDescription' =>
            'Выберите предпочитаемый цвет акцента',
          'settings.appearance.useMicaEffect' => 'Использовать эффект Mica',
          'settings.appearance.micaDescription' =>
            'Включить эффект прозрачности Mica для Windows 11',
          'settings.appearance.diffFontSize' => 'Размер шрифта сравнения',
          'settings.appearance.diffFontSizeDescription' =>
            'Настройте размер шрифта для окна сравнения',
          'settings.appearance.diffFontFamily' => 'Шрифт сравнения',
          'settings.appearance.diffFontFamilyDescription' =>
            'Шрифт для окна сравнения',
          'settings.appearance.systemDefault' => 'Системный по умолчанию',
          'settings.appearance.pickAccentColor' => 'Выбрать цвет акцента',
          'settings.appearance.diffColors' => 'Цвета сравнения',
          'settings.appearance.presetsTitle' => 'Пресеты',
          'settings.appearance.presets.presetDefault' => 'По умолчанию',
          'settings.appearance.presets.presetColorblind' => 'Для дальтоников',
          'settings.appearance.presets.presetHighContrast' =>
            'Высокий контраст',
          'settings.appearance.presets.presetNord' => 'Nord',
          'settings.appearance.presets.presetSolarized' => 'Solarized',
          'settings.appearance.presets.presetMonokai' => 'Monokai',
          'settings.appearance.identical' => 'Идентичные',
          'settings.appearance.pickColorFor' => ({required Object label}) =>
              'Выбрать цвет для ${label}',
          'settings.appearance.livePreview' => 'Предпросмотр',
          'settings.appearance.preview.step3Title' => 'onboarding.step3.title',
          'settings.appearance.preview.connectAccount' =>
            '"Подключите аккаунт"',
          'settings.appearance.preview.loginHint' => 'deprecated.login_hint_v1',
          'settings.appearance.preview.enterCredentials' =>
            '"Введите учётные данные"',
          'settings.appearance.preview.ctaButton' => 'checkout.cta_button',
          'settings.appearance.preview.buyNow' => '"Купить сейчас"',
          'settings.appearance.preview.completePurchase' =>
            '"Завершить покупку"',
          'settings.appearance.preview.appNameKey' => 'common.app_name',
          'settings.appearance.preview.appNameValue' => '"Localizer"',
          'settings.general.title' => 'Общие',
          'settings.general.description' => 'Общие настройки приложения',
          'settings.general.language' => 'Язык',
          'settings.general.languageDescription' =>
            'Выберите предпочитаемый язык',
          'settings.general.startMinimized' => 'Запускать свёрнутым в трей',
          'settings.general.startMinimizedDescription' =>
            'Запускать приложение свёрнутым в системный трей',
          'settings.general.rememberWindowPosition' =>
            'Запоминать положение окна',
          'settings.general.rememberWindowPositionDescription' =>
            'Восстанавливать размер и положение окна при запуске',
          'settings.general.openLastProject' =>
            'Открывать последний проект при запуске',
          'settings.general.openLastProjectDescription' =>
            'Автоматически открывать последний используемый проект при запуске приложения',
          'settings.general.application' => 'Приложение',
          'settings.general.defaultView' => 'Вид по умолчанию',
          'settings.general.defaultViewDescription' =>
            'Вид, отображаемый при запуске',
          'settings.general.autoCheckUpdates' => 'Автопроверка обновлений',
          'settings.general.autoCheckUpdatesDescription' =>
            'Проверять обновления при запуске',
          'settings.general.startupOptions' => 'Параметры запуска',
          'settings.general.languageAuto' => 'Автоопределение',
          'settings.general.viewBasic' => 'Сравнение файлов',
          'settings.general.viewHistory' => 'История',
          'settings.general.viewDashboard' => 'Панель качества',
          'settings.general.viewDirectory' => 'Сравнение каталогов',
          'settings.general.viewLastUsed' => 'Последний использованный вид',
          'settings.scope.title' => 'Область настроек',
          'settings.scope.global' => 'Глобальные значения по умолчанию',
          'settings.scope.project' => 'Проект',
          'settings.scope.reset' => 'Сбросить проект к глобальным значениям',
          'settings.scope.resetConfirmation' =>
            'Это очистит все переопределения для этого проекта и вернёт глобальные значения по умолчанию. Это действие нельзя отменить.',
          'settings.scope.globalDescription' =>
            'Изменения применяются ко всем проектам, если не переопределены.',
          'settings.scope.projectDescription' => ({required Object name}) =>
              'Изменения применяются только к "${name}". Остальные настройки наследуются от глобальных значений.',
          'settings.scope.createPrompt' =>
            'Создайте проект для настройки параметров определённых папок',
          'settings.searchKeywords.general.0' => 'Язык',
          'settings.searchKeywords.general.1' => 'Вид по умолчанию',
          'settings.searchKeywords.general.2' => 'Количество недавних файлов',
          'settings.searchKeywords.general.3' => 'Открывать последний проект',
          'settings.searchKeywords.general.4' => 'Подтверждать перед выходом',
          'settings.searchKeywords.general.5' => 'Показывать уведомления',
          'settings.searchKeywords.comparisonEngine.0' => 'Режим сравнения',
          'settings.searchKeywords.comparisonEngine.1' => 'Порог схожести',
          'settings.searchKeywords.comparisonEngine.2' =>
            'Чувствительность к регистру',
          'settings.searchKeywords.comparisonEngine.3' =>
            'Игнорировать пробелы',
          'settings.searchKeywords.comparisonEngine.4' =>
            'Игнорировать пустые строки',
          'settings.searchKeywords.comparisonEngine.5' =>
            'Игнорировать комментарии',
          'settings.searchKeywords.comparisonEngine.6' =>
            'Игнорировать шаблоны',
          'settings.searchKeywords.appearance.0' => 'Тема',
          'settings.searchKeywords.appearance.1' => 'Режим темы',
          'settings.searchKeywords.appearance.2' => 'Цвет акцента',
          'settings.searchKeywords.appearance.3' => 'Размер шрифта сравнения',
          'settings.searchKeywords.appearance.4' => 'Шрифт сравнения',
          'settings.searchKeywords.appearance.5' => 'Цвета сравнения',
          'settings.searchKeywords.appearance.6' => 'Цвет добавленного',
          'settings.searchKeywords.appearance.7' => 'Цвет удалённого',
          'settings.searchKeywords.appearance.8' => 'Цвет изменённого',
          'settings.searchKeywords.appearance.9' => 'Цвет идентичного',
          'settings.searchKeywords.appearance.10' => 'Цветовые пресеты',
          'settings.searchKeywords.appearance.11' => 'Предпросмотр',
          'settings.searchKeywords.fileHandling.0' => 'Формат источника',
          'settings.searchKeywords.fileHandling.1' => 'Формат цели',
          'settings.searchKeywords.fileHandling.2' => 'Кодировка по умолчанию',
          'settings.searchKeywords.fileHandling.3' =>
            'Количество недавних проектов',
          'settings.searchKeywords.fileHandling.4' => 'Память переводов',
          'settings.searchKeywords.fileHandling.5' => 'Импорт памяти',
          'settings.searchKeywords.fileHandling.6' => 'Экспорт памяти',
          'settings.searchKeywords.fileHandling.7' => 'Очистить память',
          'settings.searchKeywords.aiServices.0' => 'API-ключ OpenAI',
          'settings.searchKeywords.aiServices.1' => 'API-ключ Anthropic',
          'settings.searchKeywords.aiServices.2' => 'API-ключ Google AI',
          'settings.searchKeywords.aiServices.3' => 'Модель ИИ',
          'settings.searchKeywords.aiServices.4' => 'Температура',
          'settings.searchKeywords.aiServices.5' => 'Пользовательский промпт',
          'settings.searchKeywords.systemIntegrations.0' => 'Системный трей',
          'settings.searchKeywords.systemIntegrations.1' => 'Запуск свёрнутым',
          'settings.searchKeywords.systemIntegrations.2' => 'Ассоциации файлов',
          'settings.searchKeywords.systemIntegrations.3' => 'Эффект Mica',
          'settings.searchKeywords.systemIntegrations.4' => 'Размытие',
          'settings.searchKeywords.systemIntegrations.5' => 'Материал окна',
          'settings.searchKeywords.systemIntegrations.6' => 'Значок Dock',
          'settings.searchKeywords.systemIntegrations.7' =>
            'Количество непереведённых',
          'settings.searchKeywords.projectResources.0' => 'Глоссарий',
          'settings.searchKeywords.projectResources.1' => 'Память переводов',
          'settings.searchKeywords.projectResources.2' => 'Терминология',
          'settings.searchKeywords.about.0' => 'Версия',
          'settings.searchKeywords.about.1' => 'Проверить обновления',
          'settings.searchKeywords.about.2' => 'Автообновление',
          'settings.searchKeywords.about.3' => 'Журнал изменений',
          'settings.searchKeywords.about.4' => 'Лицензия',
          'settings.searchKeywords.about.5' => 'Политика конфиденциальности',
          'settings.searchKeywords.about.6' => 'Телеметрия',
          'settings.searchKeywords.about.7' => 'Отчёт об ошибках',
          'settings.searchKeywords.developer.0' => 'Оверлей производительности',
          'settings.searchKeywords.developer.1' => 'Отладчик семантики',
          'settings.searchKeywords.developer.2' => 'Сетка Material',
          'settings.searchKeywords.developer.3' => 'Растровый кэш',
          'settings.searchKeywords.developer.4' => 'Перезапустить руководство',
          'settings.searchKeywords.developer.5' =>
            'Сброс к заводским настройкам',
          'settings.comparison.title' => 'Сравнение',
          'settings.comparison.description' => 'Настройка поведения сравнения',
          'settings.comparison.caseSensitive' => 'Чувствительность к регистру',
          'settings.comparison.caseSensitiveDescription' =>
            'Различать прописные и строчные буквы',
          'settings.comparison.ignoreWhitespace' => 'Игнорировать пробелы',
          'settings.comparison.ignoreWhitespaceDescription' =>
            'Игнорировать начальные/конечные пробелы при сравнении',
          'settings.comparison.showLineNumbers' => 'Показывать номера строк',
          'settings.comparison.showLineNumbersDescription' =>
            'Отображать номера строк в окне сравнения',
          'settings.comparison.behavior' => 'Поведение сравнения',
          'settings.comparison.ignoreCase' => 'Игнорировать регистр',
          'settings.comparison.ignoreCaseDescription' =>
            'Считать "Key" и "key" одинаковыми',
          'settings.comparison.similarityThreshold' => 'Порог схожести',
          'settings.comparison.similarityThresholdDescription' =>
            'Минимальная схожесть для определения "Изменено"',
          'settings.comparison.mode' => 'Режим сравнения',
          'settings.comparison.modeDescription' =>
            'Способ сопоставления записей между файлами',
          'settings.comparison.modeKey' => 'По ключам',
          'settings.comparison.modeKeyDescription' =>
            'Сопоставление по имени ключа (по умолчанию).',
          'settings.comparison.modeOrder' => 'По порядку',
          'settings.comparison.modeOrderDescription' =>
            'Сопоставление по позиции в файле.',
          'settings.comparison.modeSmart' => 'Умное сопоставление',
          'settings.comparison.modeSmartDescription' =>
            'Обнаружение перемещённых/переименованных ключей.',
          'settings.comparison.ignorePatterns' => 'Игнорируемые шаблоны',
          'settings.comparison.noIgnorePatterns' =>
            'Игнорируемые шаблоны не заданы.',
          'settings.comparison.addPattern' => 'Добавить шаблон',
          'settings.comparison.resetToGlobal' =>
            'Сбросить все настройки сравнения к глобальным значениям',
          'settings.comparison.patternPresets.comments' => 'Комментарии',
          'settings.comparison.patternPresets.tempKeys' => 'Временные ключи',
          'settings.comparison.patternPresets.placeholders' => 'Плейсхолдеры',
          'settings.comparison.patternPresets.devOnly' =>
            'Только для разработки',
          'settings.comparison.previewMatch.title' =>
            'Предпросмотр соответствия',
          'settings.comparison.previewMatch.description' =>
            'Проверьте, как текущие настройки влияют на логику сопоставления.',
          'settings.comparison.previewMatch.stringA' => 'Строка A',
          'settings.comparison.previewMatch.stringB' => 'Строка B',
          'settings.comparison.previewMatch.enterText' => 'Введите текст...',
          'settings.comparison.previewMatch.similarity' => 'Схожесть',
          'settings.comparison.previewMatch.identical' => 'Идентичные',
          'settings.comparison.previewMatch.identicalDescription' =>
            'Строки совпадают после нормализации.',
          'settings.comparison.previewMatch.ignored' => 'Игнорируется',
          'settings.comparison.previewMatch.ignoredDescription' =>
            'Ввод соответствует игнорируемому шаблону.',
          'settings.comparison.previewMatch.different' => 'Различные',
          'settings.comparison.previewMatch.differentDescription' =>
            'Одно из значений пустое.',
          'settings.comparison.previewMatch.similarModified' =>
            'Похожие / Изменённые',
          'settings.comparison.previewMatch.similarModifiedDescription' => (
                  {required Object threshold}) =>
              'Оценка совпадения выше порога (${threshold}%).',
          'settings.comparison.previewMatch.newDifferent' =>
            'Новые / Различные',
          'settings.comparison.previewMatch.newDifferentDescription' => (
                  {required Object threshold}) =>
              'Оценка совпадения ниже порога (${threshold}%).',
          'settings.comparison.colorPresets.kDefault' => 'По умолчанию',
          'settings.comparison.colorPresets.colorblindFriendly' =>
            'Для дальтоников',
          'settings.comparison.colorPresets.highContrast' => 'Высокий контраст',
          'settings.comparison.colorPresets.nord' => 'Nord',
          'settings.comparison.colorPresets.solarized' => 'Solarized',
          'settings.comparison.colorPresets.monokai' => 'Monokai',
          'settings.comparison.colorPresets.presetDefault' => 'По умолчанию',
          'settings.comparison.colorPresets.presetColorblind' =>
            'Для дальтоников',
          'settings.comparison.colorPresets.presetHighContrast' =>
            'Высокий контраст',
          'settings.comparison.colorPresets.presetNord' => 'Nord',
          'settings.comparison.colorPresets.presetSolarized' => 'Solarized',
          'settings.comparison.colorPresets.presetMonokai' => 'Monokai',
          'settings.fileHandling.fileFormats' => 'Форматы файлов',
          'settings.fileHandling.sourceFormat' => 'Формат источника',
          'settings.fileHandling.targetFormat' => 'Формат цели',
          'settings.fileHandling.encoding' => 'Кодировка',
          'settings.fileHandling.sourceEncoding' => 'Кодировка источника',
          'settings.fileHandling.targetEncoding' => 'Кодировка цели',
          'settings.fileHandling.autoDetect' => 'Автоопределение',
          'settings.fileHandling.autoDetectEncodingDescription' =>
            'Автоматически определять кодировку файла',
          'settings.fileHandling.exportSettings' => 'Настройки экспорта',
          'settings.fileHandling.defaultExportFormat' =>
            'Формат экспорта по умолчанию',
          'settings.fileHandling.includeUtf8Bom' => 'Включить UTF-8 BOM',
          'settings.fileHandling.includeUtf8BomDescription' =>
            'Требуется для совместимости с Excel',
          'settings.fileHandling.openFolderAfterExport' =>
            'Открыть папку после экспорта',
          'settings.fileHandling.fileSafety' => 'Безопасность файлов',
          'settings.fileHandling.fileSafetyDescription' =>
            'Автоматические локальные копии для восстановления.',
          'settings.fileHandling.resetToGlobal' =>
            'Сбросить все настройки обработки файлов к глобальным значениям',
          'settings.translationMemory.title' => 'Глобальная память переводов',
          'settings.translationMemory.autoLearn' => 'Автообучение',
          'settings.translationMemory.autoLearnDescription' =>
            'Сохранять переводы в локальную память для повторного использования',
          'settings.translationMemory.confidenceThreshold' =>
            'Порог уверенности',
          'settings.translationMemory.confidenceThresholdDescription' => (
                  {required Object percent}) =>
              'Минимальная оценка для автоприменения (${percent}%)',
          'settings.translationMemory.entries' => 'Записей',
          'settings.translationMemory.size' => 'Размер',
          'settings.translationMemory.memorySize' => ({required Object size}) =>
              'Размер памяти: ${size}',
          'settings.translationMemory.import' => 'Импорт',
          'settings.translationMemory.exportTmx' => 'Экспорт TMX',
          'settings.translationMemory.exportCsv' => 'Экспорт CSV',
          'settings.translationMemory.clearMemory' => 'Очистить память',
          'settings.translationMemory.importedItems' => (
                  {required Object count}) =>
              'Импортировано ${count} элементов в память.',
          'settings.translationMemory.noItemsAdded' =>
            'Элементы не были добавлены.',
          'settings.translationMemory.nothingToExport' =>
            'Нечего экспортировать.',
          'settings.translationMemory.tmxSaved' => 'TMX сохранён',
          'settings.translationMemory.csvSaved' => 'CSV сохранён',
          'settings.translationMemory.clearConfirmTitle' =>
            'Очистить память переводов?',
          'settings.translationMemory.clearConfirmContent' =>
            'Это удалит все сохранённые пары переводов на этом устройстве. Это действие нельзя отменить.',
          'settings.translationMemory.cleared' => 'Память переводов очищена.',
          'settings.translationMemory.couldNotClear' =>
            'Не удалось очистить память.',
          'settings.backup.title' => 'Автосохранение',
          'settings.backup.description' =>
            'Настройки автоматического резервного копирования',
          'settings.backup.enabled' => 'Включить автосохранение',
          'settings.backup.enabledDescription' =>
            'Автоматически создавать резервные копии файлов перед изменениями',
          'settings.backup.maxCopies' => 'Максимум резервных копий',
          'settings.backup.maxCopiesDescription' =>
            'Количество резервных копий для каждого файла',
          'settings.backup.activeStatus' => ({required Object count}) =>
              'Активно · Хранится ${count} копий',
          'settings.backup.folder' => 'Папка резервных копий',
          'settings.backup.folderDescription' =>
            'Оставьте пустым для использования той же папки',
          'settings.backup.useOriginalFolder' =>
            'Использовать исходную папку файла',
          'settings.ai.title' => 'ИИ-сервисы',
          'settings.ai.description' => 'Настройка ИИ-перевода и помощи',
          'settings.ai.provider' => 'Провайдер ИИ',
          'settings.ai.providerDescription' =>
            'Выберите предпочитаемого провайдера ИИ-сервисов',
          'settings.ai.apiKey' => 'API-ключ',
          'settings.ai.apiKeyDescription' =>
            'Введите API-ключ для выбранного провайдера',
          'settings.ai.apiKeyPlaceholder' => 'Введите API-ключ...',
          'settings.ai.testConnection' => 'Проверить соединение',
          'settings.ai.connectionSuccess' => 'Соединение успешно!',
          'settings.ai.connectionFailed' =>
            'Ошибка соединения. Проверьте API-ключ.',
          'settings.ai.translationStrategy' => 'Стратегия перевода',
          'settings.ai.strategy' => 'Стратегия',
          'settings.ai.strategyDescription' => 'Выберите способ перевода строк',
          'settings.ai.strategyLLM' => 'Генеративный ИИ (LLM)',
          'settings.ai.strategyCloud' => 'Облачный перевод',
          'settings.ai.enableAiTranslation' => 'Включить ИИ-перевод',
          'settings.ai.enableAiTranslationDescription' =>
            'Разрешить приложению использовать ИИ для предложений перевода',
          'settings.ai.llmProvider' => 'Провайдер LLM-сервиса',
          'settings.ai.service' => 'Сервис',
          'settings.ai.serviceDescription' => 'Провайдер для генеративного ИИ',
          'settings.ai.providerGemini' => 'Google Gemini',
          'settings.ai.providerOpenAI' => 'OpenAI',
          'settings.ai.geminiApiKey' => 'API-ключ Gemini',
          'settings.ai.openAiApiKey' => 'API-ключ OpenAI',
          'settings.ai.model' => 'Модель',
          'settings.ai.modelDescription' => 'Выберите используемую модель',
          'settings.ai.advancedParameters' => 'Расширенные параметры',
          'settings.ai.parameters' => 'Параметры',
          'settings.ai.parametersDescription' =>
            'Температура, контекст и другое',
          'settings.ai.temperature' => 'Температура',
          'settings.ai.temperatureDescription' =>
            'Высокие значения делают вывод более творческим',
          'settings.ai.maxTokens' => 'Макс. токенов',
          'settings.ai.maxTokensDescription' =>
            'Ограничение длины контекстного окна',
          'settings.ai.systemContext' => 'Системный контекст / Инструкции',
          'settings.ai.systemContextHint' =>
            'Вы — профессиональный локализатор. Сохраняйте тон и смысл исходной строки...',
          'settings.ai.systemContextHelper' =>
            'Предоставьте ИИ конкретные инструкции о стиле и терминологии вашего проекта.',
          'settings.ai.contextStrings' => 'Контекстные строки',
          'settings.ai.contextStringsDescription' =>
            'Включать окружающие строки для лучшего контекста',
          'settings.ai.contextCount' => 'Количество контекста',
          'settings.ai.contextCountDescription' =>
            'Количество окружающих строк для включения',
          'settings.ai.cloudServices' => 'Облачные сервисы перевода',
          'settings.ai.googleTranslateApiKey' => 'API-ключ Google Translate',
          'settings.ai.deeplApiKey' => 'API-ключ DeepL',
          'settings.ai.test' => 'Тест',
          'settings.ai.resetToGlobal' =>
            'Сбросить все настройки ИИ к глобальным значениям',
          'settings.integrations.platformNotice' => 'Уведомление о платформе',
          'settings.integrations.platformNoticeDescription' =>
            'Системные интеграции недоступны для этой платформы.',
          'settings.integrations.visualEffects' => 'Визуальные эффекты',
          'settings.integrations.explorerIntegration' =>
            'Интеграция с проводником',
          'settings.integrations.explorerIntegrationDescription' =>
            'Добавить "Открыть в Localizer" в контекстное меню проводника Windows для папок.',
          'settings.integrations.addToContextMenu' =>
            'Добавить в контекстное меню',
          'settings.integrations.contextMenuAdded' =>
            'Контекстное меню добавлено!',
          'settings.integrations.contextMenuAddError' =>
            'Не удалось добавить контекстное меню',
          'settings.integrations.contextMenuRemoved' =>
            'Контекстное меню удалено!',
          'settings.integrations.contextMenuRemoveError' =>
            'Не удалось удалить контекстное меню',
          'settings.integrations.fileAssociations' => 'Ассоциации файлов',
          'settings.integrations.fileAssociationsDescription' =>
            'Зарегистрировать типы файлов для открытия в Localizer при двойном клике в проводнике.',
          'settings.integrations.registered' => 'Зарегистрировано',
          'settings.integrations.notRegistered' => 'Не зарегистрировано',
          'settings.integrations.extRegistered' => ({required Object ext}) =>
              '${ext} зарегистрировано!',
          'settings.integrations.extUnregistered' => ({required Object ext}) =>
              '${ext} отменено!',
          'settings.integrations.extError' => (
                  {required Object action, required Object ext}) =>
              'Не удалось ${action} ${ext}',
          'settings.integrations.registerAll' => 'Зарегистрировать все',
          'settings.integrations.unregisterAll' => 'Отменить все',
          'settings.integrations.registerAllResult' => (
                  {required Object success, required Object total}) =>
              'Зарегистрировано ${success} из ${total} типов файлов',
          'settings.integrations.unregisterAllResult' => (
                  {required Object success, required Object total}) =>
              'Отменено ${success} из ${total} типов файлов',
          'settings.integrations.protocolHandler' => 'Обработчик протокола',
          'settings.integrations.protocolHandlerDescription' =>
            'Зарегистрировать URL-схему localizer:// для открытия этого приложения. Позволяет открывать проекты напрямую из ссылок браузера или других приложений.',
          'settings.integrations.protocolRegistered' =>
            'Обработчик протокола зарегистрирован',
          'settings.integrations.protocolNotRegistered' =>
            'Обработчик протокола не зарегистрирован',
          'settings.integrations.registerProtocol' =>
            'Зарегистрировать протокол',
          'settings.integrations.unregister' => 'Отменить регистрацию',
          'settings.integrations.protocolRegisteredSuccess' =>
            'Обработчик протокола зарегистрирован!',
          'settings.integrations.protocolRemovedSuccess' =>
            'Обработчик протокола удалён!',
          'settings.integrations.protocolRegisterError' =>
            'Не удалось зарегистрировать',
          'settings.integrations.protocolRemoveError' => 'Не удалось удалить',
          'settings.integrations.windowMaterial' => 'Материал окна',
          'settings.integrations.windowMaterialDescription' =>
            'Выберите стиль размытия macOS',
          'settings.integrations.dockIntegration' => 'Интеграция с Dock',
          'settings.integrations.showDockBadge' =>
            'Показывать количество непереведённых',
          'settings.integrations.showDockBadgeDescription' =>
            'Отображать количество непереведённых строк на значке Dock',
          'settings.integrations.materials.sidebar' => 'Боковая панель',
          'settings.integrations.materials.menu' => 'Меню',
          'settings.integrations.materials.popover' => 'Всплывающее окно',
          'settings.integrations.materials.titlebar' => 'Заголовок окна',
          'settings.integrations.materials.underPageBackground' =>
            'Фон страницы',
          'settings.integrations.materials.contentBackground' => 'Содержимое',
          'settings.integrations.fileTypes.loc' => 'Файл проекта Localizer',
          'settings.integrations.fileTypes.lang' => 'Языковой файл',
          'settings.integrations.fileTypes.json' => 'JSON-файл локализации',
          'settings.integrations.fileTypes.xml' => 'XML-файл локализации',
          'settings.developer.title' => 'Настройки разработчика',
          'settings.developer.description' =>
            'Расширенные настройки для разработчиков',
          'settings.developer.showLocalizationKeys' =>
            'Показывать ключи локализации',
          'settings.developer.localizationKeysDescription' =>
            'При включении весь переведённый текст будет показывать ключи локализации вместо переведённых значений. Полезно для проверки использования ключей.',
          'settings.developer.showPerformanceOverlay' =>
            'Показывать оверлей производительности',
          'settings.developer.performanceOverlayDescription' =>
            'Отображать FPS и информацию о кадрах',
          'settings.developer.debugMode' => 'Режим отладки',
          'settings.developer.debugModeDescription' =>
            'Включить дополнительное логирование и функции отладки',
          'settings.developer.debuggingTools' => 'Инструменты отладки',
          'settings.developer.semanticsDebugger' => 'Отладчик семантики',
          'settings.developer.semanticsDebuggerDescription' =>
            'Визуализация дерева семантики',
          'settings.developer.materialGrid' => 'Сетка Material',
          'settings.developer.materialGridDescription' =>
            'Наложение сетки макета Material',
          'settings.developer.rasterCache' => 'Изображения растрового кэша',
          'settings.developer.rasterCacheDescription' =>
            'Шахматная разметка изображений растрового кэша',
          'settings.developer.actions' => 'Действия',
          'settings.developer.showLogs' => 'Показать логи приложения',
          'settings.developer.showLogsDescription' =>
            'Открыть консоль отладки Talker',
          'settings.developer.restartTutorial' => 'Перезапустить обучение',
          'settings.developer.restartTutorialDescription' =>
            'Сбросить флаги и запустить обучение снова',
          'settings.developer.restartRequested' =>
            'Запрошен перезапуск обучения.',
          'settings.developer.throwException' => 'Вызвать тестовое исключение',
          'settings.developer.throwExceptionDescription' =>
            'Вызвать тестовое исключение для проверки отчётов об ошибках',
          'settings.developer.testExceptionMessage' =>
            'Тестовое исключение вызвано из настроек разработчика',
          'settings.developer.clearTM' => 'Очистить память переводов',
          'settings.developer.clearTMDescription' =>
            'Удалить все кэшированные переводы',
          'settings.developer.clearTMConfirmation' =>
            'Очистить память переводов?',
          'settings.developer.clearTMWarning' =>
            'Это удалит все заученные переводы. Это нельзя отменить.',
          'settings.developer.tmCleared' => 'Память переводов очищена',
          'settings.developer.clearApiKeys' => 'Очистить API-ключи',
          'settings.developer.clearApiKeysDescription' =>
            'Удалить все сохранённые API-ключи',
          'settings.developer.clearApiKeysConfirmation' =>
            'Очистить API-ключи?',
          'settings.developer.clearApiKeysWarning' =>
            'Это удалит все API-ключи из защищённого хранилища.',
          'settings.developer.apiKeysCleared' => 'API-ключи очищены',
          'settings.developer.hideOptions' => 'Скрыть настройки разработчика',
          'settings.developer.hideOptionsDescription' =>
            'Отключить режим разработчика (требуется 7 нажатий для повторного включения)',
          'settings.developer.optionsDisabled' =>
            'Настройки разработчика отключены',
          'settings.developer.dangerZone' => 'Опасная зона',
          'settings.developer.factoryReset' => 'Сброс к заводским настройкам',
          'settings.developer.factoryResetDescription' =>
            'Сбросить все настройки и очистить данные',
          'settings.developer.factoryResetWarning' =>
            'Вы уверены, что хотите сбросить все настройки? Это действие нельзя отменить.',
          'settings.developer.inspectionTools' => 'Инструменты инспекции',
          'settings.developer.searchHint' => 'Поиск настроек...',
          'settings.developer.resetToDefault' => 'Сбросить по умолчанию',
          'settings.developer.resetToGlobal' =>
            'Сбросить к глобальным значениям',
          'settings.developer.storageInspector' => 'Инспектор хранилища',
          'settings.developer.storageInspectorDescription' =>
            'Просмотр содержимого Hive и защищённого хранилища',
          'settings.developer.deviceEnvironment' => 'Устройство и окружение',
          'settings.developer.deviceEnvironmentDescription' =>
            'Экран, платформа и информация о сборке',
          'settings.developer.themePlayground' => 'Тестирование темы',
          'settings.developer.themePlaygroundDescription' =>
            'Цветовая палитра и типографика',
          'settings.developer.themePlaygroundSection.colors' => 'Цвета',
          'settings.developer.themePlaygroundSection.typography' =>
            'Типографика',
          'settings.developer.themePlaygroundSection.palette.primary' =>
            'Основной',
          'settings.developer.themePlaygroundSection.palette.onPrimary' =>
            'На основном',
          'settings.developer.themePlaygroundSection.palette.secondary' =>
            'Вторичный',
          'settings.developer.themePlaygroundSection.palette.onSecondary' =>
            'На вторичном',
          'settings.developer.themePlaygroundSection.palette.surface' =>
            'Поверхность',
          'settings.developer.themePlaygroundSection.palette.onSurface' =>
            'На поверхности',
          'settings.developer.themePlaygroundSection.palette.error' => 'Ошибка',
          'settings.developer.themePlaygroundSection.palette.onError' =>
            'На ошибке',
          'settings.developer.themePlaygroundSection.palette.outline' =>
            'Обводка',
          'settings.developer.themePlaygroundSection.palette.shadow' => 'Тень',
          'settings.developer.themePlaygroundSection.palette.success' =>
            'Успех',
          'settings.developer.themePlaygroundSection.palette.warning' =>
            'Предупреждение',
          'settings.developer.themePlaygroundSection.palette.info' =>
            'Информация',
          'settings.developer.localizationInspector' => 'Инспектор локализации',
          'settings.developer.localizationInspectorDescription' =>
            'Отладка строк перевода',
          'settings.developer.hiveAppSettings' => 'Hive (AppSettings)',
          'settings.developer.secureStorageMasked' =>
            'Защищённое хранилище (скрыто)',
          'settings.developer.featureFlags.title' =>
            'Экспериментальные функции',
          'settings.developer.featureFlags.description' =>
            'Переключайте флаги функций локально для тестирования. Эти переопределения сохраняются между перезапусками приложения.',
          'settings.developer.featureFlags.subtitle' =>
            'Переопределение экспериментальных функций',
          'settings.developer.featureFlags.flags.experimental_ai_batch.name' =>
            'Экспериментальный пакетный ИИ',
          'settings.developer.featureFlags.flags.experimental_ai_batch.description' =>
            'Включить пакетный ИИ-перевод для нескольких строк',
          'settings.developer.featureFlags.flags.new_diff_algorithm.name' =>
            'Новый алгоритм сравнения',
          'settings.developer.featureFlags.flags.new_diff_algorithm.description' =>
            'Использовать улучшенный алгоритм сравнения',
          'settings.developer.featureFlags.flags.enhanced_search.name' =>
            'Улучшенный поиск',
          'settings.developer.featureFlags.flags.enhanced_search.description' =>
            'Включить нечёткий поиск в файлах перевода',
          'settings.developer.featureFlags.flags.auto_save.name' =>
            'Автосохранение',
          'settings.developer.featureFlags.flags.auto_save.description' =>
            'Автоматически сохранять изменения после редактирования',
          'settings.developer.featureFlags.reset' => 'Сбросить все флаги',
          'settings.developer.featureFlags.overrides' =>
            'Локальные переопределения',
          'settings.developer.featureFlags.defaultVal' => 'По умолчанию',
          'settings.developer.featureFlags.on' => 'ВКЛ',
          'settings.developer.featureFlags.off' => 'ВЫКЛ',
          'settings.developer.storageInspectorSection.refresh' => 'Обновить',
          'settings.developer.storageInspectorSection.hiveData' =>
            'Данные Hive',
          'settings.developer.storageInspectorSection.secureStorage' =>
            'Защищённое хранилище',
          'settings.developer.deviceInfoSection.refresh' => 'Обновить',
          'settings.developer.deviceInfoSection.copy' =>
            'Копировать в буфер обмена',
          'settings.developer.deviceInfoSection.computerName' =>
            'Имя компьютера',
          'settings.developer.deviceInfoSection.osVersion' => 'Версия ОС',
          'settings.developer.localizationInspectorSection.showKeys' =>
            'Показывать ключи вместо значений',
          'settings.developer.localizationInspectorSection.keysVisible' =>
            'Ключи видны',
          'settings.developer.localizationInspectorSection.normalDisplay' =>
            'Обычное отображение',
          'settings.developer.localizationInspectorSection.note' =>
            'Примечание: Эта функция требует, чтобы локализация приложения использовала обёртку, учитывающую эту настройку.',
          'settings.about.title' => 'О программе',
          'settings.about.version' => 'Версия',
          'settings.about.buildNumber' => 'Номер сборки',
          'settings.about.author' => 'Автор',
          _ => null,
        } ??
        switch (path) {
          'settings.about.license' => 'Лицензия',
          'settings.about.sourceCode' => 'Исходный код',
          'settings.about.reportBug' => 'Сообщить об ошибке',
          'settings.about.requestFeature' => 'Запросить функцию',
          'settings.about.checkForUpdates' => 'Проверить обновления',
          'settings.about.upToDate' => 'У вас последняя версия!',
          'settings.about.updateAvailable' => ({required Object version}) =>
              'Доступно обновление: ${version}',
          'settings.about.updateAvailableBadge' => 'Доступно обновление!',
          'settings.about.developerSteps' => ({required Object count}) =>
              'Осталось ${count} шагов до статуса разработчика.',
          'settings.about.developerActivated' => 'Вы теперь разработчик!',
          'settings.about.neverChecked' => 'Никогда',
          'settings.about.applicationInfo' => 'Информация о приложении',
          'settings.about.platform' => 'Платформа',
          'settings.about.updateInformation' => 'Информация об обновлениях',
          'settings.about.currentVersion' => 'Текущая версия',
          'settings.about.latestVersion' => 'Последняя версия',
          'settings.about.lastChecked' => 'Последняя проверка',
          'settings.about.checkingForUpdates' => 'Проверка...',
          'settings.about.whatsNew' => 'Что нового',
          'settings.about.systemInformation' => 'Системная информация',
          'settings.about.dartVersion' => 'Версия Dart',
          'settings.about.diskSpace' => 'Доступное место на диске',
          'settings.about.memoryUsage' => 'Использование памяти',
          'settings.about.privacyTitle' => 'Конфиденциальность и телеметрия',
          'settings.about.usageStats' => 'Анонимная статистика использования',
          'settings.about.requiresFirebase' => 'Требуется настройка Firebase',
          'settings.about.featureUnavailable' =>
            'Функция недоступна (требуется Firebase)',
          'settings.about.settingsManagement' => 'Управление настройками',
          'settings.about.settingsManagementDescription' =>
            'Экспортируйте настройки в файл для резервного копирования или переноса на другие устройства.',
          'settings.about.resetAll' => 'Сбросить все',
          'settings.about.links' => 'Ссылки',
          'settings.about.githubRepo' => 'Репозиторий GitHub',
          'settings.about.privacyPolicy' => 'Политика конфиденциальности',
          'settings.about.crashReporting' => 'Отчёты об ошибках',
          'settings.onboarding.skipTutorial' => 'Пропустить обучение',
          'settings.onboarding.gettingStarted' => 'Начало работы',
          'settings.onboarding.stepProgress' => (
                  {required Object current, required Object total}) =>
              '${current} из ${total}',
          'settings.onboarding.loadSampleData' => 'Загрузить примеры данных',
          'settings.onboarding.steps.importFiles.title' => 'Импорт файлов',
          'settings.onboarding.steps.importFiles.description' =>
            'Загрузите исходные и целевые файлы',
          'settings.onboarding.steps.runComparison.title' => 'Запуск сравнения',
          'settings.onboarding.steps.runComparison.description' =>
            'Нажмите "Сравнить файлы"',
          'settings.onboarding.steps.reviewMissing.title' =>
            'Проверка отсутствующих ключей',
          'settings.onboarding.steps.reviewMissing.description' =>
            'Обратите внимание на красные элементы MISSING',
          'settings.onboarding.steps.useFilters.title' =>
            'Использование фильтров',
          'settings.onboarding.steps.useFilters.description' =>
            'Фильтрация по типу',
          'settings.onboarding.steps.searchResults.title' =>
            'Поиск результатов',
          'settings.onboarding.steps.searchResults.description' =>
            'Найдите конкретные ключи',
          'settings.onboarding.steps.advancedView.title' => 'Расширенный вид',
          'settings.onboarding.steps.advancedView.description' =>
            'Изучите детальный анализ',
          'settings.onboarding.steps.editCell.title' => 'Редактирование ячейки',
          'settings.onboarding.steps.editCell.description' =>
            'Нажмите для редактирования значения',
          'settings.onboarding.steps.exportResults.title' => 'Экспорт',
          'settings.onboarding.steps.exportResults.description' =>
            'Сохраните отчёт',
          'settings.settingsView.resetCategoryTitle' =>
            ({required Object category}) => 'Сбросить ${category}?',
          'settings.settingsView.resetCategoryContent' =>
            'Это сбросит все настройки в этой категории к значениям по умолчанию.',
          'settings.settingsView.resetAllTitle' => 'Сбросить все настройки?',
          'settings.settingsView.resetAllContent' =>
            'Это навсегда сбросит все настройки к заводским значениям. Это действие нельзя отменить.',
          'settings.settingsView.resetAll' => 'Сбросить все',
          'settings.settingsView.resetSuccess' => (
                  {required Object category}) =>
              '${category} сброшены к значениям по умолчанию',
          'settings.settingsView.errorLoading' => 'Ошибка загрузки настроек',
          'settings.settingsView.settingsSaved' => 'Настройки сохранены',
          'settings.settingsView.updateAvailable' =>
            ({required Object version}) => 'Доступно обновление: v${version}',
          'settings.settingsView.latestVersion' =>
            'Вы используете последнюю версию',
          'settings.settingsView.whatsNew' => ({required Object version}) =>
              'Что нового в v${version}',
          'settings.settingsView.downloadUpdate' => 'Скачать обновление',
          'settings.settingsView.exportSettings' => 'Экспорт настроек',
          'settings.settingsView.settingsExported' =>
            'Настройки экспортированы',
          'settings.settingsView.exportFail' => ({required Object error}) =>
              'Не удалось экспортировать настройки: ${error}',
          'settings.settingsView.importSettings' => 'Импорт настроек',
          'settings.settingsView.importTitle' => 'Импортировать настройки?',
          'settings.settingsView.importContent' =>
            'Это заменит все текущие настройки импортированными. Это действие нельзя отменить.',
          'settings.settingsView.importSuccess' =>
            'Настройки успешно импортированы!',
          'settings.settingsView.importFail' => ({required Object error}) =>
              'Не удалось импортировать настройки: ${error}',
          'settings.settingsView.invalidFormat' =>
            'Неверный формат файла настроек',
          'settings.settingsView.categories.general' => 'Общие настройки',
          'settings.settingsView.categories.comparisonEngine' =>
            'Движок сравнения',
          'settings.settingsView.categories.appearance' => 'Внешний вид',
          'settings.settingsView.categories.fileHandling' => 'Обработка файлов',
          'settings.settingsView.categories.aiServices' => 'ИИ-сервисы',
          'settings.settingsView.categories.systemIntegrations' =>
            'Системные интеграции',
          'settings.settingsView.categories.projectResources' =>
            'Ресурсы проекта (глоссарий и память переводов)',
          'settings.settingsView.categories.developer' =>
            'Настройки разработчика',
          'settings.settingsView.categories.about' => 'О программе',
          'settings.settingsView.categoryLabels.general' => 'Общие',
          'settings.settingsView.categoryLabels.comparisonEngine' =>
            'Сравнение',
          'settings.settingsView.categoryLabels.appearance' => 'Внешний вид',
          'settings.settingsView.categoryLabels.fileHandling' =>
            'Обработка файлов',
          'settings.settingsView.categoryLabels.aiServices' => 'ИИ-сервисы',
          'settings.settingsView.categoryLabels.systemIntegrations' =>
            'Системные интеграции',
          'settings.settingsView.categoryLabels.projectResources' =>
            'Ресурсы проекта',
          'settings.settingsView.categoryLabels.developer' =>
            'Настройки разработчика',
          'settings.settingsView.categoryLabels.about' => 'О программе',
          'fileComparison.title' => 'Сравнение файлов',
          'fileComparison.openFiles' => 'Открыть файлы',
          'fileComparison.exportResults' => 'Экспортировать результаты',
          'fileComparison.restartTutorial' => 'Перезапустить обучение',
          'fileComparison.restartTutorialDevOnly' =>
            'Перезапуск обучения доступен только в режиме разработчика.',
          'fileComparison.unsupportedFileType' => 'Неподдерживаемый тип файла.',
          'fileComparison.unsupportedFileTypeSuggestion' =>
            'Выберите поддерживаемый файл локализации.',
          'fileComparison.someFilesUnsupported' =>
            'Некоторые файлы не поддерживаются.',
          'fileComparison.pickSupportedFiles' =>
            'Выберите только поддерживаемые файлы локализации.',
          'fileComparison.pickTwoFiles' => 'Выберите два файла для сравнения.',
          'fileComparison.pickBilingualFile' =>
            'Выберите двуязычный файл для сравнения.',
          'fileComparison.noResultsToExport' => 'Нет результатов для экспорта.',
          'fileComparison.performComparisonFirst' =>
            'Сначала выполните сравнение для экспорта результатов.',
          'fileComparison.performComparisonFirstEditor' =>
            'Сначала выполните сравнение для просмотра расширенных деталей.',
          'fileComparison.sampleDataLoaded' =>
            'Примеры данных успешно загружены',
          'fileComparison.loadSampleDataError' => ({required Object error}) =>
              'Не удалось загрузить примеры данных: ${error}',
          'fileComparison.invalidFileType' => 'Неверный тип файла.',
          'fileComparison.fileSelected' => (
                  {required Object label, required Object fileName}) =>
              '${label} выбран: ${fileName}',
          'fileComparison.sourceFile' => 'Исходный файл',
          'fileComparison.targetFile' => 'Целевой файл',
          'fileComparison.bilingualFile' => 'Двуязычный файл',
          'fileComparison.compareFiles' => 'Сравнить файлы',
          'fileComparison.compareFile' => 'Сравнить файл',
          'fileComparison.bilingualMode' => 'Двуязычный режим',
          'fileComparison.twoFilesMode' => 'Два файла',
          'fileComparison.processing' => 'Обработка...',
          'fileComparison.remaining' => ({required Object time}) =>
              'Осталось ${time}',
          'fileComparison.comparisonInProgress' => 'Сравнение в процессе...',
          'fileComparison.comparisonFailed' => ({required Object error}) =>
              'Ошибка сравнения: ${error}',
          'fileComparison.fileChanged' => ({required Object fileName}) =>
              'Файл изменён: ${fileName}. Повторное сравнение...',
          'fileComparison.dropFileHere' => 'Перетащите файл сюда',
          'fileComparison.dropFileOrBrowse' =>
            'Перетащите файл или нажмите для выбора',
          'fileComparison.fileUpload' => 'Загрузить файл',
          'fileComparison.changeFile' => 'Изменить файл',
          'fileComparison.total' => 'Всего',
          'fileComparison.show' => 'Показать',
          'fileComparison.showAll' => 'Показать все',
          'fileComparison.noMatches' => ({required Object query}) =>
              'Совпадений для "${query}" не найдено',
          'fileComparison.showingEntries' => (
                  {required Object count, required Object total}) =>
              'Показано ${count} из ${total} записей',
          'fileComparison.filesIdentical' => 'Файлы идентичны.',
          'fileComparison.hiddenIdentical' => ({required Object count}) =>
              '${count} идентичных записей скрыто',
          'fileComparison.showIdentical' => 'Показать идентичные записи',
          'fileComparison.hideIdentical' => 'Скрыть идентичные записи',
          'fileComparison.noDiff' => 'Различия по ключам не найдены.',
          'fileComparison.source' => 'Источник',
          'fileComparison.target' => 'Цель',
          'fileComparison.value' => 'Значение',
          'fileComparison.readyToCompare' => 'Готово к сравнению файлов',
          'fileComparison.readyToCompareDesc' =>
            'Перетащите файлы локализации выше или используйте кнопки обзора\nдля выбора файлов для сравнения.',
          'fileComparison.recentComparisons' => 'Недавние сравнения',
          'fileComparison.bilingualFileLabel' => ({required Object name}) =>
              'Двуязычный файл: ${name}',
          'fileComparison.comparisonLabel' => (
                  {required Object source, required Object target}) =>
              '${source} ↔ ${target}',
          'fileComparison.fileNotExist' =>
            'Один или оба файла из этой сессии больше не существуют.',
          'fileComparison.largeFileTitle' => 'Обнаружен большой файл',
          'fileComparison.largeFileContent' => ({required Object count}) =>
              'Результат сравнения содержит ${count} записей.\nОтображение всех может вызвать проблемы с производительностью.\n\nПродолжить?',
          'fileComparison.dontShowAgain' =>
            'Больше не показывать для этого файла',
          'fileComparison.proceed' => 'Продолжить',
          'fileComparison.exportReport' => ({required Object format}) =>
              'Сохранить отчёт ${format}',
          'fileComparison.saved' => ({required Object format}) =>
              '${format} сохранён',
          'fileComparison.saveError' => ({required Object format}) =>
              'Не удалось сохранить файл ${format}.',
          'fileComparison.saveErrorDetailed' => (
                  {required Object format, required Object error}) =>
              'Не удалось сохранить ${format}: ${error}',
          'fileComparison.watching' => 'Отслеживание',
          'fileComparison.watchOff' => 'Отслеживание выкл.',
          'fileComparison.watchingTooltip' => ({required Object status}) =>
              'Отслеживание файлов: ${status}\nАвтоматическое повторное сравнение при изменении файлов на диске',
          'fileComparison.aiSettingsNotAvailable' =>
            'Переход к настройкам ИИ недоступен',
          'directoryComparison.title' => 'Сравнение каталогов',
          'directoryComparison.sourceDirectory' => 'Исходный каталог',
          'directoryComparison.targetDirectory' => 'Целевой каталог',
          'directoryComparison.sourceSubtitle' =>
            'Оригинальные/справочные файлы',
          'directoryComparison.targetSubtitle' => 'Файлы перевода/сравнения',
          'directoryComparison.selectBothDirectories' =>
            'Выберите исходный и целевой каталоги.',
          'directoryComparison.selectSourceFolder' => 'Выбрать исходную папку',
          'directoryComparison.selectTargetFolder' => 'Выбрать целевую папку',
          'directoryComparison.dropFolderHere' =>
            'Перетащите папку сюда или выберите...',
          'directoryComparison.folderPath' => 'Путь к папке',
          'directoryComparison.readyToCompare' =>
            'Готово к сравнению каталогов',
          'directoryComparison.readyToCompareDesc' =>
            'Перетащите папки выше или используйте кнопки обзора\nдля выбора каталогов для сравнения.',
          'directoryComparison.nestedFolders' => 'Вложенные папки',
          'directoryComparison.nestedFoldersTooltip' =>
            'Рекурсивное сравнение всех вложенных каталогов',
          'directoryComparison.fileMatching' => 'Сопоставление файлов',
          'directoryComparison.fileMatchingTooltip' =>
            'Автоматическое сопоставление файлов по имени',
          'directoryComparison.bulkExport' => 'Пакетный экспорт',
          'directoryComparison.bulkExportTooltip' =>
            'Экспорт всех результатов сравнения сразу',
          'directoryComparison.notDirectoryComparison' =>
            'Это не сравнение каталогов.',
          'directoryComparison.directoriesNotExist' =>
            'Один или оба каталога больше не существуют.',
          'directoryComparison.errorOccurred' => 'Произошла ошибка',
          'directoryComparison.noFilesFound' =>
            'Файлы в выбранных каталогах не найдены.',
          'directoryComparison.unmatchedSourceFiles' =>
            'Несопоставленные исходные файлы',
          'directoryComparison.unmatchedTargetFiles' =>
            'Несопоставленные целевые файлы',
          'directoryComparison.filePairs' => ({required Object count}) =>
              '${count} пар файлов',
          'directoryComparison.pairedFiles' => ({required Object count}) =>
              'Сопоставленные файлы (${count})',
          'directoryComparison.view' => 'Просмотр',
          'directoryComparison.failed' => 'Ошибка',
          'directoryComparison.pair' => 'Сопоставить...',
          'directoryComparison.pairDialogTitle' => ({required Object name}) =>
              'Сопоставить "${name}" с:',
          'directoryComparison.discoverFiles' => 'Обнаружить файлы',
          'directoryComparison.compareAll' => 'Сравнить все',
          'directoryComparison.exportAll' => 'Экспортировать все',
          'directoryComparison.comparisonStarted' => 'Сравнение начато...',
          'directoryComparison.discoveringFiles' => 'Обнаружение файлов...',
          'directoryComparison.noResultsToExport' =>
            'Нет результатов для экспорта. Сначала выполните "Сравнить все".',
          'directoryComparison.selectExportFolder' =>
            'Выберите папку для экспорта',
          'directoryComparison.createExportFolderError' => (
                  {required Object error}) =>
              'Не удалось создать папку экспорта: ${error}',
          'directoryComparison.exportingResults' => 'Экспорт результатов',
          'directoryComparison.processingFile' => ({required Object file}) =>
              'Обработка: ${file}',
          'directoryComparison.exportProgress' => (
                  {required Object current, required Object total}) =>
              'Экспортировано ${current} из ${total} файлов',
          'directoryComparison.exportComplete' => 'Экспорт завершён',
          'directoryComparison.exportSuccessMessage' => (
                  {required Object count}) =>
              'Успешно экспортировано ${count} файлов сравнения и сводка.',
          'directoryComparison.exportFailed' => ({required Object error}) =>
              'Ошибка экспорта: ${error}',
          'directoryComparison.close' => 'Закрыть',
          'compare.title' => 'Сравнить файлы',
          'compare.sourceFile' => 'Исходный файл',
          'compare.targetFile' => 'Целевой файл',
          'compare.sourceFolder' => 'Исходная папка',
          'compare.targetFolder' => 'Целевая папка',
          'compare.dropFilesHint' =>
            'Перетащите файлы локализации сюда или используйте кнопки обзора.',
          'compare.selectSourceFile' => 'Выберите исходный файл',
          'compare.selectTargetFile' => 'Выберите целевой файл',
          'compare.startComparison' => 'Начать сравнение',
          'compare.comparing' => 'Сравнение...',
          'compare.comparisonComplete' => 'Сравнение завершено',
          'compare.noChanges' => 'Изменений не обнаружено',
          'compare.filesIdentical' => 'Файлы идентичны',
          'compare.changesFound' => ({required Object count}) =>
              'Найдено ${count} изменений',
          'compare.tabs.files' => 'Файлы',
          'compare.tabs.directories' => 'Каталоги',
          'compare.tabs.git' => 'Git',
          'compare.fileTypes.json' =>
            'Файлы локализации JSON (i18next, Flutter и др.)',
          'compare.fileTypes.yaml' => 'Файлы локализации YAML (Rails, Flutter)',
          'compare.fileTypes.xml' => 'Файлы локализации XML (Android, .NET)',
          'compare.fileTypes.properties' => 'Файлы свойств (Java)',
          'compare.fileTypes.resx' => 'Файлы RESX (.NET)',
          'compare.fileTypes.xliff' => 'Файлы XLIFF',
          'history.title' => 'История',
          'history.recentComparisons' => 'Недавние сравнения',
          'history.noHistory' => 'История сравнений пуста',
          'history.noHistoryDescription' =>
            'Здесь появится история ваших сравнений',
          'history.clearHistory' => 'Очистить историю',
          'history.clearHistoryConfirm' =>
            'Вы уверены, что хотите очистить всю историю?',
          'history.deleteEntry' => 'Удалить запись',
          'history.openComparison' => 'Открыть сравнение',
          'history.timeAgo.justNow' => 'только что',
          'history.timeAgo.secondsAgo' => ({required Object count}) =>
              '${count} сек. назад',
          'history.timeAgo.oneMinuteAgo' => '1 минуту назад',
          'history.timeAgo.minutesAgo' => ({required Object count}) =>
              '${count} мин. назад',
          'history.timeAgo.oneHourAgo' => '1 час назад',
          'history.timeAgo.hoursAgo' => ({required Object count}) =>
              '${count} ч. назад',
          'history.timeAgo.yesterday' => 'вчера',
          'history.timeAgo.daysAgo' => ({required Object count}) =>
              '${count} дн. назад',
          'history.timeAgo.oneWeekAgo' => '1 неделю назад',
          'history.timeAgo.weeksAgo' => ({required Object count}) =>
              '${count} нед. назад',
          'history.timeAgo.oneMonthAgo' => '1 месяц назад',
          'history.timeAgo.monthsAgo' => ({required Object count}) =>
              '${count} мес. назад',
          'history.timeAgo.oneYearAgo' => '1 год назад',
          'history.timeAgo.yearsAgo' => ({required Object count}) =>
              '${count} г. назад',
          'history.timeAgo.inTheFuture' => 'в будущем',
          'projects.title' => 'Проекты',
          'projects.createProject' => 'Создать проект',
          'projects.importProject' => 'Импортировать проект',
          'projects.noProjects' => 'Проектов пока нет',
          'projects.noProjectsDescription' =>
            'Создайте проект для организации файлов локализации',
          'projects.projectName' => 'Название проекта',
          'projects.projectPath' => 'Путь к проекту',
          'projects.lastOpened' => 'Открыт',
          'projects.openProject' => 'Открыть проект',
          'projects.closeProject' => 'Закрыть проект',
          'projects.deleteProject' => 'Удалить проект',
          'projects.deleteProjectConfirm' =>
            'Вы уверены, что хотите удалить этот проект?',
          'projects.exportProject' => 'Экспорт проекта',
          'projects.exportDescription' =>
            'Создать zip-архив с файлами, настройками и историей.',
          'projects.exporting' => 'Экспорт проекта...',
          'projects.exportSuccess' => 'Проект экспортирован',
          'projects.exportError' => ({required Object error}) =>
              'Ошибка экспорта: ${error}',
          'projects.createNewProject' => 'Создать новый проект',
          'projects.openExistingProject' => 'Открыть существующий проект',
          'projects.importProjectZip' => 'Импорт проекта из Zip',
          'projects.projectResources' => 'Ресурсы проекта',
          'projects.recentProjects' => 'Недавние проекты',
          'projects.noRecentProjects' => 'Нет недавних проектов',
          'projects.selectProjectZip' => 'Выбрать Zip проекта',
          'projects.selectDestination' =>
            'Выбрать папку назначения для импорта',
          'projects.importing' => 'Импорт проекта...',
          'projects.importSuccess' => 'Проект успешно импортирован',
          'projects.importFailed' => ({required Object error}) =>
              'Ошибка импорта: ${error}',
          'projects.importingFiles' => 'Импорт файлов...',
          'projects.noSupportedFiles' => 'Поддерживаемые файлы не найдены.',
          'projects.stats.empty' => 'Пустой проект',
          'projects.stats.files' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(
                n,
                one: '1 файл перевода',
                other: '${count} файлов перевода',
              ),
          'projects.stats.languages' => (
                  {required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(
                n,
                one: '1 язык',
                other: '${count} языков',
              ),
          'projects.openProjectFirst' =>
            'Сначала откройте проект для управления ресурсами.',
          'projects.removeFromRecent' => 'Удалить из недавних',
          'projects.selection.selectFolder' => 'Выбрать папку проекта',
          'projects.selection.selectArchive' => 'Выбрать архив проекта',
          'projects.selection.openProject' => 'Открыть проект',
          'projects.selection.browseFolder' => 'Обзор папки...',
          'projects.selection.createNew' => 'Создать новый',
          'projects.selection.importFromZip' => 'Импорт из Zip...',
          'projects.createDialog.title' => 'Создать проект',
          'projects.createDialog.description' =>
            'Проект позволяет сохранять настройки для конкретной папки. Будет создана папка ".localizer" для настроек.',
          'projects.createDialog.folderLabel' => 'Папка проекта',
          'projects.createDialog.folderHint' => 'Выберите папку...',
          'projects.createDialog.nameLabel' => 'Название проекта',
          'projects.createDialog.nameHint' => 'Например: Мой Проект',
          'projects.createDialog.selectFolderWarning' =>
            'Пожалуйста, выберите папку проекта.',
          'projects.createDialog.enterNameError' =>
            'Пожалуйста, введите название проекта',
          'projects.createDialog.nameLengthError' =>
            'Название должно быть не короче 2 символов',
          'projects.createDialog.success' => ({required Object name}) =>
              'Проект "${name}" успешно создан!',
          'projects.createDialog.failure' => 'Не удалось создать проект.',
          'projects.createDialog.creating' => 'Создание...',
          'projects.createDialog.createAction' => 'Создать проект',
          'projects.indicator.tooltipNoProject' =>
            'Создайте проект для сохранения настроек',
          'projects.indicator.tooltipProject' => ({required Object name}) =>
              'Проект: ${name}\nНажмите для опций',
          'projects.indicator.location' => 'Расположение',
          'projects.indicator.created' => 'Создан',
          'projects.indicator.switchProject' => 'Сменить проект',
          'projects.indicator.done' => 'Готово',
          'projects.glossary.title' => 'Глоссарий проекта',
          'projects.glossary.description' =>
            'Определите термины для единообразия перевода.',
          'projects.glossary.noTerms' => 'Нет терминов.',
          'projects.glossary.noTermsDesc' =>
            'Добавьте термины, которые должны быть согласованы,\nили бренды, которые не нужно переводить.',
          'projects.glossary.doNotTranslate' => 'Не переводить',
          'projects.glossary.noSpecificTranslation' =>
            'Нет конкретного перевода',
          'projects.glossary.addTerm' => 'Добавить термин',
          'projects.glossary.editTerm' => 'Редактировать термин',
          'projects.glossary.term' => 'Термин',
          'projects.glossary.termHint' => 'Например: бренд, спец. термин',
          'projects.glossary.definition' => 'Определение (необязательно)',
          'projects.glossary.definitionHint' => 'Контекст для переводчика',
          'projects.glossary.doNotTranslateLabel' => 'Не переводить',
          'projects.glossary.doNotTranslateDesc' =>
            'Оставить как есть в переводе',
          'projects.glossary.preferredTranslation' =>
            'Предпочтительный перевод',
          'projects.glossary.caseSensitive' => 'Учитывать регистр',
          'projects.conflicts.missingApiKeyTitle' =>
            ({required Object service}) => 'Нет API ключа для ${service}',
          'projects.conflicts.missingApiKeyMessage' => (
                  {required Object service}) =>
              'Этот проект использует ${service}, но ключ не настроен. Добавьте ключ в Настройки > ИИ, или будет использован глобальный.',
          'projects.conflicts.dismiss' => 'Закрыть',
          'projects.tm.title' => 'Память переводов',
          'projects.tm.description' =>
            'Управление источниками памяти переводов для проекта.',
          'projects.tm.globalTm' => 'Глобальная память переводов',
          'projects.tm.globalTmDescription' =>
            'Использовать общую память из настроек',
          'projects.tm.linkedFiles' => 'Связанные файлы (Проект)',
          'projects.tm.noLinkedFiles' => 'Нет связанных файлов проекта.',
          'projects.tm.addTmFile' => 'Добавить файл TM',
          'projects.tm.useGlobalTm' => 'Исп. глобальную TM',
          'projects.tm.selectTm' => 'Выберите память переводов',
          'projects.tm.globalTmEnabled' =>
            'Глобальная память переводов включена',
          'diff.added' => 'Добавлено',
          'diff.removed' => 'Удалено',
          'diff.modified' => 'Изменено',
          'diff.unchanged' => 'Без изменений',
          'diff.missing' => 'Отсутствует',
          'diff.extra' => 'Лишнее',
          'diff.sourceValue' => 'Исходное значение',
          'diff.targetValue' => 'Целевое значение',
          'diff.key' => 'Ключ',
          'diff.status' => 'Статус',
          'diff.actions' => 'Действия',
          'diff.copyToTarget' => 'Копировать в цель',
          'diff.acceptChange' => 'Принять изменение',
          'diff.rejectChange' => 'Отклонить изменение',
          'diff.viewDetails' => 'Показать детали',
          'gitComparison._translatorNote' =>
            'Git-термины (Branch, Commit, Checkout, Merge, Conflict, Pull, Push) должны оставаться на английском языке во всех переводах, чтобы избежать путаницы среди разработчиков.',
          'gitComparison.title' => 'Сравнение репозитория',
          'gitComparison.repoSelector' => 'Создать / Открыть репозиторий',
          'gitComparison.noRepoSelected' => 'Репозиторий не выбран',
          'gitComparison.open' => 'Открыть',
          'gitComparison.refreshCommits' => 'Обновить Commits',
          'gitComparison.noCommits' =>
            'Commits не найдены или не загружены. Выберите Branch для загрузки Commits.',
          'gitComparison.baseCommit' => 'Базовый Commit (старый)',
          'gitComparison.targetCommit' => 'Целевой Commit (новый)',
          'gitComparison.filterCommitsByBranch' => 'Фильтр Commits по Branch',
          'gitComparison.conflictDetection' => 'Обнаружение Conflicts',
          'gitComparison.conflictDetectionTooltip' =>
            'Обнаружение и разрешение Merge Conflicts',
          'gitComparison.actions' => 'Действия:',
          'gitComparison.checkout' => 'Checkout',
          'gitComparison.merge' => 'Merge',
          'gitComparison.pull' => 'Pull',
          'gitComparison.checkoutBranch' => 'Checkout Branch',
          'gitComparison.mergeBranch' => 'Merge Branch в текущий',
          'gitComparison.mergeConfirmation' => ({required Object branch}) =>
              'Merge ${branch}?',
          'gitComparison.mergeWarning' =>
            'Это выполнит Merge изменений в вашу текущую рабочую Branch. Могут возникнуть Conflicts.',
          'gitComparison.selectExportFolder' => 'Выберите папку для экспорта',
          'gitComparison.createExportFolderError' => (
                  {required Object error}) =>
              'Не удалось создать папку экспорта: ${error}',
          'gitComparison.exportingFiles' => 'Экспорт файлов',
          'gitComparison.processingFile' => ({required Object file}) =>
              'Обработка: ${file}',
          'gitComparison.exportProgress' => (
                  {required Object current, required Object total}) =>
              'Экспортировано ${current} из ${total} файлов',
          'gitComparison.exportComplete' => 'Экспорт завершён',
          'gitComparison.exportSuccessMessage' => ({required Object count}) =>
              'Успешно экспортировано ${count} файлов с полным содержимым.',
          'gitComparison.exportDetail' =>
            'Diff каждого файла сохранён в подпапке "files".',
          'gitComparison.diffViewer' => 'Просмотр Diff',
          'gitComparison.base' => 'BASE',
          'gitComparison.target' => 'TARGET',
          'gitComparison.noLines' => 'Нет строк для отображения',
          'gitComparison.searchFiles' => 'Поиск файлов...',
          'gitComparison.noFilesMatch' => ({required Object query}) =>
              'Файлы, соответствующие "${query}", не найдены',
          'gitComparison.filesCount' => ({required Object count}) =>
              '${count} файлов',
          'gitComparison.selectBaseFile' => 'Выбрать базовый файл',
          'gitComparison.selectTargetFile' => 'Выбрать целевой файл',
          'gitComparison.comparisonResults' => 'Результаты сравнения',
          'gitComparison.noChanges' =>
            'Изменения между выбранными refs не найдены.',
          'gitComparison.linesAdded' => 'Строк добавлено',
          'gitComparison.linesRemoved' => 'Строк удалено',
          'gitComparison.commit' => 'Commit',
          'gitComparison.branch' => 'Branch',
          'gitComparison.noRepositorySelected' => 'Репозиторий не выбран',
          'gitComparison.notGitComparison' => 'Это не Git-сравнение',
          'gitComparison.repositoryNotExist' => 'Репозиторий не существует',
          'gitComparison.mainBranch' => 'main',
          'gitComparison.masterBranch' => 'master',
          'gitComparison.backToControls' =>
            'Назад к элементам управления сравнением',
          'git.title' => 'Сравнение Git',
          'git.selectRepository' => 'Выбрать репозиторий',
          'git.selectBranch' => 'Выбрать Branch',
          'git.selectCommit' => 'Выбрать Commit',
          'git.compareBranches' => 'Сравнить Branches',
          'git.compareCommits' => 'Сравнить Commits',
          'git.baseBranch' => 'Базовая Branch',
          'git.compareBranch' => 'Сравниваемая Branch',
          'git.noRepositories' => 'Git-репозитории не найдены',
          'git.noRepositoriesDescription' =>
            'Откройте папку, содержащую Git-репозиторий',
          'git.filesChanged' => ({required Object count}) =>
              '${count} файлов изменено',
          'git.additions' => ({required Object count}) => '${count} добавлений',
          'git.deletions' => ({required Object count}) => '${count} удалений',
          'git.conflicts.title' => 'Обнаружены Merge Conflicts',
          'git.conflicts.description' =>
            'Вы должны разрешить эти Conflicts, прежде чем продолжить.',
          'git.conflicts.abortMergeTitle' => 'Отменить Merge?',
          'git.conflicts.abortMergeContent' =>
            'Это отменит все изменения Merge и вернёт состояние до Merge. Это действие нельзя отменить.',
          'git.conflicts.abortMergeAction' => 'Отменить Merge',
          'git.conflicts.stagingFile' => ({required Object file}) =>
              'Добавление ${file} для Commit...',
          'git.conflicts.conflictedFilesCount' => ({required Object count}) =>
              'Файлы с Conflicts (${count})',
          'git.conflicts.selectFileToResolve' => 'Выберите файл для разрешения',
          'git.conflicts.resolvingFile' => ({required Object file}) =>
              'Разрешение: ${file}',
          'git.conflicts.keepAllOurs' => 'Оставить все наши',
          'git.conflicts.acceptAllTheirs' => 'Принять все их',
          'git.conflicts.allResolved' =>
            'Все Conflicts в этом файле разрешены!',
          'git.conflicts.markResolved' => 'Отметить как разрешённое',
          'git.conflicts.stageForCommit' => 'Это добавит файл для Commit.',
          'git.conflicts.conflictIndex' => ({required Object index}) =>
              'Conflict #${index}',
          'git.conflicts.ours' => 'НАШЕ (Текущее)',
          'git.conflicts.theirs' => 'ИХ (Входящее)',
          'git.conflicts.keepOurs' => 'Оставить наше',
          'git.conflicts.acceptTheirs' => 'Принять их',
          'git.conflicts.empty' => '(Пусто)',
          'quality._translatorNote' =>
            'API и метрики (Requests, Tokens, Characters, Prompt, Completion, Export) должны оставаться на английском языке для единообразия с отраслевой терминологией.',
          'quality.title' => 'Панель качества',
          'quality.overallScore' => 'Общая оценка',
          'quality.issues' => 'Проблемы',
          'quality.warnings' => 'Предупреждения',
          'quality.suggestions' => 'Предложения',
          'quality.placeholderMismatch' => 'Несовпадение заполнителей',
          'quality.placeholderMismatchDescription' =>
            'Заполнители {name} не совпадают с источником',
          'quality.lengthOutlier' => 'Отклонение длины',
          'quality.lengthOutlierDescription' =>
            'Длина перевода сильно отличается от оригинала',
          'quality.duplicateValue' => 'Дублирующее значение',
          'quality.duplicateValueDescription' =>
            'Один перевод используется для разных ключей',
          'quality.missingTranslation' => 'Отсутствует перевод',
          'quality.missingTranslationDescription' =>
            'Перевод для этого ключа отсутствует',
          'quality.loading' => 'Загрузка панели...',
          'quality.errorLoading' =>
            'Не удалось загрузить историю. Попробуйте снова.',
          'quality.emptyState' => 'Запустите сравнение, чтобы увидеть данные.',
          'quality.refresh' => 'Обновить',
          'quality.buildingInsights' => 'Сбор данных...',
          'quality.crunchingNumbers' => 'Обработка чисел...',
          'quality.errorBuilding' =>
            'Не удалось построить панель. Попробуйте снова.',
          'quality.noUsableData' => 'Полезные данные пока не найдены.',
          'quality.languages' => 'Языки',
          'quality.averageCoverage' => 'Среднее покрытие',
          'quality.potentialIssues' => 'Возможные проблемы',
          'quality.translationCoverage' => 'Покрытие перевода',
          'quality.entriesTranslated' => (
                  {required Object translated, required Object total}) =>
              'Переведено ${translated} из ${total} записей',
          'quality.wordsAddedOverTime' => 'Добавление слов со временем',
          'quality.completionVsScope' => 'Выполнение vs Объём',
          'quality.scopeVsProgress' => 'Объём vs Прогресс',
          'quality.coveragePercent' => 'Покрытие %',
          'quality.wordsAdded' => 'Добавлено слов',
          'quality.words' => 'Слова',
          'quality.coverage' => 'Покрытие',
          'quality.scope' => 'Объём',
          'quality.latest' => 'Последнее',
          'quality.added' => 'Добавлено',
          'quality.change' => 'Изменение',
          'quality.totalScope' => 'Общий объём',
          'quality.wordsCount' => ({required Object count}) => '${count} слов',
          'quality.scopeGrowth' => 'Рост объёма',
          'quality.range' => 'Диапазон',
          'quality.aiUsage' => 'Использование ИИ и переводов',
          'quality.lastUsed' => ({required Object date}) =>
              'Последн. исп. ${date}',
          'quality.noIssuesFound' =>
            'Проблем не найдено в последних сравнениях.',
          'quality.placeholderMismatches' => 'Несовпадения заполнителей',
          'quality.placeholderMismatchesDesc' =>
            'Маркеры типа {name} не совпадают.',
          'quality.lengthOutliers' => 'Слишком короткие/длинные переводы',
          'quality.lengthOutliersDesc' =>
            'Длина выглядит необычной по сравнению с исходником.',
          'quality.duplicateValues' => 'Дублирующиеся значения',
          'quality.duplicateValuesDesc' =>
            'Один перевод используется многократно.',
          'quality.placeholderDialogTitle' => 'Несовпадения заполнителей',
          'quality.placeholderDialogDesc' =>
            'Эти переводы имеют другие заполнители ({name}), чем источник.',
          'quality.lengthDialogTitle' => 'Отклонения длины',
          'quality.lengthDialogDesc' =>
            'Эти переводы значительно короче или длиннее источника.',
          'quality.duplicateDialogTitle' => 'Дублирующиеся значения',
          'quality.duplicateDialogDesc' =>
            'Эти переводы встречаются несколько раз.',
          'quality.duplicateSample' => ({required Object value}) =>
              'Дубликат: "${value}"',
          'quality.exportError' =>
            'Не удалось создать отчёт. Попробуйте снова.',
          'quality.noDataToExport' => 'Нет данных для экспорта',
          'quality.exportFailed' => 'Ошибка экспорта',
          'quality.exportDialogTitle' => 'Экспорт отчёта о качестве',
          'quality.reportSaved' => 'Отчёт сохранён',
          'quality.export' => 'Экспорт',
          'quality.requests' => 'Запросы',
          'quality.tokens' => 'Токены',
          'quality.characters' => 'Символы',
          'quality.estCost' => 'Оц. стоимость',
          'quality.prompt' => 'Промпт',
          'quality.completion' => 'Завершение',
          'quality.showingCurrentProject' => 'Показано: Текущий проект',
          'quality.showingAllHistory' => 'Показано: Вся история',
          'quality.filesSkipped' =>
            'Некоторые файлы пропущены, так как не найдены.',
          'quality.charCount' => ({required num n, required Object count}) =>
              (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(
                n,
                one: '1 символ',
                other: '${count} символов',
              ),
          'quality.lengthDiff' => (
                  {required Object target,
                  required Object percent,
                  required Object source}) =>
              'Цель: ${target} (${percent}%) против источника: ${source}',
          'errors.genericError' => 'Произошла ошибка',
          'errors.fileNotFound' => 'Файл не найден',
          _ => null,
        } ??
        switch (path) {
          'errors.invalidFormat' => 'Неверный формат файла',
          'errors.parseError' => 'Не удалось разобрать файл',
          'errors.networkError' => 'Ошибка сети. Проверьте соединение.',
          'errors.permissionDenied' => 'В доступе отказано',
          'errors.unknownError' => 'Произошла неизвестная ошибка',
          'wizards.firstRun.welcome' => 'Добро пожаловать в Localizer',
          'wizards.firstRun.description' =>
            'Сравните ваши файлы локализации за секунды.',
          'wizards.firstRun.sourceFile' => 'Исходный файл',
          'wizards.firstRun.targetFile' => 'Целевой файл',
          'wizards.firstRun.compareNow' => 'Сравнить сейчас',
          'wizards.firstRun.trySample' => 'Попробовать пример',
          'wizards.firstRun.skip' => 'Пропустить настройку',
          'wizards.firstRun.browse' => 'Нажмите для выбора',
          'wizards.firstRun.error' => ({required Object error}) =>
              'Не удалось загрузить пример: ${error}',
          'dialogs.addIgnorePattern.title' => 'Добавить шаблон игнорирования',
          'dialogs.addIgnorePattern.patternLabel' => 'Шаблон (regex)',
          'dialogs.addIgnorePattern.hint' => 'например, ^temp_.*',
          'dialogs.addIgnorePattern.invalid' => 'Неверный regex шаблон',
          'dialogs.addIgnorePattern.testStringLabel' => 'Тестовая строка',
          'dialogs.addIgnorePattern.testHint' => 'Введите ключ для проверки',
          'dialogs.addIgnorePattern.match' => '✓ Шаблон совпадает',
          'dialogs.addIgnorePattern.noMatch' => '✗ Шаблон не совпадает',
          'dialogs.addIgnorePattern.add' => 'Добавить',
          'dialogs.addIgnorePattern.cancel' => 'Отмена',
          'dialogs.diffViewer.title' => 'Просмотр различий',
          'dialogs.diffViewer.originalFile' => 'Оригинал/Эталонный файл',
          'dialogs.diffViewer.translationFile' => 'Перевод/Файл сравнения',
          'dialogs.diffViewer.base' => 'БАЗА',
          'dialogs.diffViewer.target' => 'ЦЕЛЬ',
          'dialogs.diffViewer.added' => 'Добавлено',
          'dialogs.diffViewer.removed' => 'Удалено',
          'dialogs.diffViewer.modified' => 'Изменено',
          'dialogs.diffViewer.noMatches' =>
            'Нет записей, соответствующих фильтрам',
          'dialogs.diffViewer.clickToggle' =>
            'Нажмите значки выше для переключения фильтров',
          'dialogs.diffViewer.clickToHide' => '(нажмите чтобы скрыть)',
          'dialogs.diffViewer.clickToShow' => '(нажмите чтобы показать)',
          'grid.columns.key' => 'Ключ',
          'grid.columns.source' => 'Источник',
          'grid.columns.status' => 'Статус',
          'grid.columns.actions' => 'Действия',
          'advancedComparison.placeholder' =>
            'Расширенный вид сравнения — заглушка',
          'advancedDiff.saveAllChanges' => 'Сохранить все изменения?',
          'advancedDiff.saveConfirmation' => ({required Object count}) =>
              'Это сохранит все ${count} изменённых записей в целевой файл. Это действие нельзя отменить.',
          'advancedDiff.changesSaved' => 'Изменения успешно сохранены.',
          'advancedDiff.csvExported' => 'CSV экспортирован',
          'advancedDiff.unsavedChanges' => 'Несохранённые изменения',
          'advancedDiff.unsavedChangesWarning' =>
            'У вас есть несохранённые изменения. Вы уверены, что хотите их отменить?',
          'advancedDiff.discardChanges' => 'Отменить изменения',
          'advancedDiff.goBack' => 'Назад',
          'advancedDiff.breadcrumbs' => 'Главная  >  Редактор',
          'advancedDiff.unsaved' => ({required Object count}) =>
              '${count} не сохранено',
          'advancedDiff.reviewed' => ({required Object count}) =>
              '${count} проверено',
          'advancedDiff.saveAll' => ({required Object count}) =>
              'Сохранить все (${count})',
          'advancedDiff.allSaved' => 'Всё сохранено',
          'advancedDiff.saveAllTooltip' => 'Сохранить все изменения (Ctrl+S)',
          'advancedDiff.exportTooltip' => 'Экспорт данных (Ctrl+E)',
          'advancedDiff.aiSuggestion.aiTranslation' => 'ИИ-перевод',
          'advancedDiff.aiSuggestion.aiRephrase' => 'ИИ-перефразирование',
          'advancedDiff.aiSuggestion.key' => ({required Object key}) =>
              'Ключ: ${key}',
          'advancedDiff.aiSuggestion.original' => 'Оригинал:',
          'advancedDiff.aiSuggestion.suggestion' => 'Предложение:',
          'advancedDiff.aiSuggestion.confidence' => 'Уверенность ИИ',
          'advancedDiff.aiSuggestion.cancelEdit' => 'Отменить редактирование',
          'advancedDiff.aiSuggestion.editSuggestion' =>
            'Редактировать предложение',
          'advancedDiff.aiSuggestion.alternatives' => 'Альтернативы:',
          'advancedDiff.aiSuggestion.accept' => 'Принять',
          'advancedDiff.aiSuggestion.reject' => 'Отклонить',
          'advancedDiff.aiSuggestion.stop' => 'Стоп',
          'advancedDiff.detailEdit.title' => ({required Object key}) =>
              'Редактирование: ${key}',
          'advancedDiff.detailEdit.sourceLabel' => 'ИСТОЧНИК (Оригинал)',
          'advancedDiff.detailEdit.targetLabel' => 'ЦЕЛЬ (Перевод)',
          'advancedDiff.detailEdit.translateWithCloud' =>
            'Перевести через облако',
          'advancedDiff.detailEdit.translateWithAi' => 'Перевести с ИИ',
          'advancedDiff.detailEdit.translating' => 'Перевод...',
          'advancedDiff.detailEdit.applyAndTm' => 'Применить',
          'advancedDiff.detailEdit.entryApplied' =>
            'Запись применена и добавлена в память переводов',
          'advancedDiff.detailEdit.translationAdded' =>
            'Предложение перевода добавлено.',
          'advancedDiff.detailEdit.aiSuggestionAdded' =>
            'ИИ-предложение добавлено.',
          'advancedDiff.table.addedToTM' => 'Добавлено в память переводов',
          'advancedDiff.table.markedReviewed' => 'Отмечено как проверенное ✓',
          'advancedDiff.table.unmarkedReview' => 'Отметка проверки снята',
          'advancedDiff.table.reverted' => 'Возвращено к исходному значению',
          'advancedDiff.table.entryDeleted' => 'Запись удалена',
          'advancedDiff.table.noSourceText' =>
            'Нет исходного текста для перевода.',
          'advancedDiff.table.aiTranslationFailed' => ({required Object key}) =>
              'ИИ-перевод не удался для "${key}"',
          'advancedDiff.table.noTargetText' =>
            'Нет целевого текста для перефразирования.',
          'advancedDiff.table.aiRephraseFailed' => ({required Object key}) =>
              'ИИ-перефразирование не удалось для "${key}"',
          'advancedDiff.table.checkRowsFirst' =>
            'Сначала отметьте строки с помощью флажков',
          'advancedDiff.table.markedRowsReviewed' => (
                  {required Object count}) =>
              'Отмечено ${count} строк как проверенные',
          'advancedDiff.table.revertedRows' => ({required Object count}) =>
              'Возвращено ${count} строк',
          'advancedDiff.table.entriesCount' => ({required Object count}) =>
              '${count} записей',
          'advancedDiff.table.markSelectedReviewed' =>
            'Отметить выбранные как проверенные',
          'advancedDiff.table.revertSelected' => 'Вернуть выбранные',
          'advancedDiff.table.noDifferences' => 'Различия не найдены',
          'advancedDiff.table.adjustFilters' => 'Попробуйте изменить фильтры',
          'advancedDiff.table.cloudTranslationApplied' =>
            'Облачный перевод применён.',
          'advancedDiff.table.aiTranslationApplied' => 'ИИ-перевод применён.',
          'advancedDiff.table.suggestionApplied' => 'Предложение применено.',
          'advancedDiff.table.aiSuggestionApplied' =>
            'ИИ-предложение применено.',
          'advancedDiff.table.rephraseApplied' => 'Перефразирование применено.',
          'advancedDiff.table.aiRephraseApplied' =>
            'ИИ-перефразирование применено.',
          'advancedDiff.table.rephrase' => 'Перефразировать',
          'advancedDiff.table.aiRephrase' => 'ИИ-перефразирование',
          'advancedDiff.table.targetClickToEdit' =>
            'ЦЕЛЬ (Нажмите для редактирования)',
          'advancedDiff.table.targetClickForDialog' =>
            'ЦЕЛЬ (Нажмите для диалога)',
          'advancedDiff.table.emptyClickToEdit' =>
            '(Пусто — нажмите для редактирования)',
          'advancedDiff.table.unmarkReviewed' => 'Снять отметку проверки',
          'advancedDiff.table.markReviewed' => 'Отметить как проверенное',
          'advancedDiff.table.revertToSource' => 'Вернуть к источнику',
          'advancedDiff.table.translateWithCloud' => 'Перевести через облако',
          'advancedDiff.table.translateWithAi' => 'Перевести с ИИ',
          'advancedDiff.table.rephraseWithAi' => 'Перефразировать с ИИ',
          'advancedDiff.table.moreActions' => 'Дополнительные действия',
          'advancedDiff.table.editDetails' => 'Редактировать детали',
          'advancedDiff.table.suggestTranslation' => 'Предложить перевод',
          'advancedDiff.table.addToTm' => 'Добавить в память переводов',
          'advancedDiff.table.deleteEntry' => 'Удалить запись',
          'advancedDiff.diffRow.copySource' => 'Копировать исходный текст',
          'advancedDiff.diffRow.actions' => 'Действия',
          'advancedDiff.status.added' => 'ДОБАВЛЕНО',
          'advancedDiff.status.missing' => 'ОТСУТСТВУЕТ',
          'advancedDiff.status.changed' => ({required Object percent}) =>
              'ИЗМ ${percent}%',
          'advancedDiff.status.same' => 'БЕЗ ИЗМЕНЕНИЙ',
          'advancedDiff.sidebar.widgets' => 'Виджеты',
          'advancedDiff.sidebar.searchPlaceholder' =>
            'Поиск ключей и значений... (Ctrl+F)',
          'advancedDiff.sidebar.fuzzySearchTooltip' =>
            'Нечёткий поиск (с учётом опечаток)',
          'advancedDiff.sidebar.regexSearchTooltip' =>
            'Поиск по регулярным выражениям',
          'advancedDiff.sidebar.cloudTranslation' => 'Облачный перевод',
          'advancedDiff.sidebar.aiTranslation' => 'ИИ-перевод',
          'advancedDiff.sidebar.status' => 'Статус',
          'advancedDiff.sidebar.tm' => 'Память переводов',
          'advancedDiff.sidebar.filters' => 'Фильтры',
          'advancedDiff.sidebar.actions' => 'Действия',
          'advancedDiff.sidebar.similarity' => 'Схожесть',
          'advancedDiff.sidebar.actionsSection.exportMatches' =>
            'Экспорт совпадений',
          'advancedDiff.sidebar.actionsSection.preview' => 'Предпросмотр',
          'advancedDiff.sidebar.actionsSection.fillFromTmTitle' =>
            'Заполнить из памяти переводов?',
          'advancedDiff.sidebar.actionsSection.fillFromTmContent' =>
            'Это попытается заполнить пустые целевые значения с помощью совпадений из памяти переводов. Существующие значения НЕ будут перезаписаны.',
          'advancedDiff.sidebar.actionsSection.fill' => 'Заполнить',
          'advancedDiff.sidebar.actionsSection.fillFromMemory' =>
            'Заполнить из памяти',
          'advancedDiff.sidebar.actionsSection.filledFromTm' => (
                  {required Object count}) =>
              'Заполнено ${count} элементов из памяти переводов.',
          'advancedDiff.sidebar.aiSection.infoCloud' =>
            'Использует облачный перевод для перевода пустых целевых значений из источника.',
          'advancedDiff.sidebar.aiSection.infoAi' =>
            'Использует ИИ для перевода пустых целевых значений из источника.',
          'advancedDiff.sidebar.aiSection.translationSettings' =>
            'Настройки перевода',
          'advancedDiff.sidebar.aiSection.aiSettings' => 'Настройки ИИ',
          'advancedDiff.sidebar.aiSection.source' => 'Источник',
          'advancedDiff.sidebar.aiSection.target' => 'Цель',
          'advancedDiff.sidebar.aiSection.translatingProgress' =>
            ({required Object percent}) => 'Перевод... ${percent}%',
          'advancedDiff.sidebar.aiSection.translating' => 'Перевод...',
          'advancedDiff.sidebar.aiSection.translateAllMissing' =>
            'Перевести все отсутствующие',
          'advancedDiff.sidebar.aiSection.translateAllTitle' =>
            'Перевести все отсутствующие?',
          'advancedDiff.sidebar.aiSection.translateAllContent' => (
                  {required Object service,
                  required Object source,
                  required Object target}) =>
              'Это использует ${service} для перевода всех записей с пустыми целевыми значениями с ${source} на ${target}.\n\nВы можете просмотреть каждое предложение или применить все сразу.',
          'advancedDiff.sidebar.aiSection.translateAll' => 'Перевести все',
          'advancedDiff.sidebar.aiSection.reviewEach' => 'Просмотреть каждый',
          'advancedDiff.sidebar.aiSection.cloudTranslated' => (
                  {required Object count}) =>
              'Переведено ${count} записей с помощью облачного перевода.',
          'advancedDiff.sidebar.aiSection.aiTranslated' => (
                  {required Object count}) =>
              'Переведено ${count} записей с помощью ИИ.',
          'advancedDiff.sidebar.aiSection.aiTranslateFailed' =>
            'ИИ-перевод всех не удался',
          'advancedDiff.sidebar.aiSection.noMissingEntries' =>
            'Нет отсутствующих записей для перевода.',
          'advancedDiff.sidebar.aiSection.skip' => 'Пропустить',
          'advancedDiff.sidebar.aiSection.stop' => 'Стоп',
          'advancedDiff.sidebar.aiSection.cloudApplied' =>
            ({required Object count}) => 'Применено ${count} предложений.',
          'advancedDiff.sidebar.aiSection.aiApplied' =>
            ({required Object count}) => 'Применено ${count} ИИ-предложений.',
          'advancedDiff.sidebar.tmSection.enableTmFill' =>
            'Включить заполнение из памяти переводов',
          'advancedDiff.sidebar.tmSection.autoApplyAboveMinimum' =>
            'Автоприменение выше минимума',
          'advancedDiff.sidebar.tmSection.matchSettings' =>
            'Настройки сопоставления',
          'advancedDiff.sidebar.tmSection.minMatch' => 'Мин. совпадение:',
          'advancedDiff.sidebar.tmSection.limit' => 'Лимит:',
          'advancedDiff.sidebar.tmSection.exact' => 'Точное',
          'advancedDiff.sidebar.filtersSection.viewFilters' =>
            'Фильтры просмотра',
          'advancedDiff.sidebar.filtersSection.showAll' => 'Показать все',
          'advancedDiff.sidebar.filtersSection.added' => 'Добавленные',
          'advancedDiff.sidebar.filtersSection.removed' => 'Удалённые',
          'advancedDiff.sidebar.filtersSection.modified' => 'Изменённые',
          'advancedDiff.sidebar.filtersSection.actionScope' =>
            'Область действия',
          'advancedDiff.sidebar.filtersSection.applyToAdded' =>
            'Применить к добавленным',
          'advancedDiff.sidebar.filtersSection.applyToModified' =>
            'Применить к изменённым',
          'advancedDiff.sidebar.filtersSection.onlyFillEmptyTargets' =>
            'Заполнять только пустые цели',
          'advancedDiff.sidebar.filtersSection.limitToVisible' =>
            'Ограничить видимыми',
          'advancedDiff.sidebar.filtersSection.editMode' =>
            'Режим редактирования',
          'advancedDiff.sidebar.filtersSection.dialog' => 'Диалог',
          'advancedDiff.sidebar.filtersSection.inline' => 'Встроенный',
          'advancedDiff.sidebar.similaritySection.currentFilter' =>
            'Текущий фильтр:',
          'advancedDiff.sidebar.similaritySection.any' => 'ЛЮБАЯ',
          'advancedDiff.sidebar.similaritySection.high' => 'ВЫСОКАЯ',
          'advancedDiff.sidebar.similaritySection.medium' => 'СРЕДНЯЯ',
          'advancedDiff.sidebar.similaritySection.low' => 'НИЗКАЯ',
          'advancedDiff.sidebar.statusSection.total' =>
            ({required Object count}) => '${count} всего',
          'advancedDiff.sidebar.statusSection.extra' =>
            ({required Object count}) => '${count} лишних',
          'advancedDiff.sidebar.statusSection.missing' =>
            ({required Object count}) => '${count} отсутствует',
          'advancedDiff.sidebar.statusSection.changed' =>
            ({required Object count}) => '${count} изменено',
          'issueDetails.title' => 'Детали проблемы',
          'issueDetails.showingIssues' => (
                  {required Object count, required Object total}) =>
              'Показано ${count} из ${total} проблем',
          'issueDetails.searchPlaceholder' =>
            'Поиск по ключу, тексту или ошибке...',
          'issueDetails.noDetails' => 'Нет доступных деталей.',
          'issueDetails.noMatches' => 'Совпадения не найдены.',
          'issueDetails.showMore' => 'Показать ещё',
          'issueDetails.copyItems' => ({required Object count}) =>
              'Копировать ${count} элементов',
          'issueDetails.close' => 'Закрыть',
          'issueDetails.copied' => 'Скопировано в буфер обмена',
          'issueDetails.copiedCount' => ({required Object count}) =>
              'Скопировано ${count} элементов',
          'issueDetails.duplicateValue.label' => 'ПОВТОРЯЮЩИЙСЯ ПЕРЕВОД',
          'issueDetails.duplicateValue.warning' =>
            'Разные исходные тексты используют этот же перевод. Проверьте контекст.',
          'issueDetails.duplicateValue.affectedKeys' =>
            ({required Object count}) => 'ЗАТРОНУТЫЕ КЛЮЧИ (${count})',
          'issueDetails.duplicateValue.identicalSources' =>
            'Идентичные источники',
          'issueDetails.duplicateValue.moreKeys' => ({required Object count}) =>
              '+${count} ещё ключей',
          'issueDetails.lengthOutlier.source' => 'ИСТОЧНИК',
          'issueDetails.lengthOutlier.translation' => 'ПЕРЕВОД',
          'issueDetails.lengthOutlier.chars' => ({required Object count}) =>
              '${count} символов',
          'issueDetails.standard.key' => 'КЛЮЧ',
          'issueDetails.standard.sourceText' => 'ИСХОДНЫЙ ТЕКСТ',
          'issueDetails.standard.translation' => 'ПЕРЕВОД',
          'issueDetails.standard.errorDetails' => 'ДЕТАЛИ ОШИБКИ',
          'issueDetails.standard.note' => 'ПРИМЕЧАНИЕ',
          'issueDetails.review' => 'Проверить',
          'issueDetails.types.duplicateValue' => 'Дублирующиеся значения',
          'issueDetails.types.lengthOutlier' => 'Несоответствие длины',
          'issueDetails.types.placeholderMismatch' =>
            'Несоответствие плейсхолдеров',
          'issueDetails.notes.placeholderMismatch' =>
            'Маркеры типа {name} должны совпадать с источником.',
          'issueDetails.notes.lengthOutlier' =>
            'Большие изменения длины могут влиять на отображение текста на экране.',
          'issueDetails.notes.duplicateValue' =>
            'Один и тот же перевод используется для разных ключей.',
          'issueDetails.fallbacks.multipleSources' =>
            'Несколько исходных текстов',
          'issueDetails.fallbacks.sourceNotAvailable' =>
            'Исходный текст недоступен',
          'issueDetails.fallbacks.sharedTranslationNotAvailable' =>
            'Общий перевод недоступен',
          'issueDetails.fallbacks.translationNotAvailable' =>
            'Перевод недоступен',
          'importReview.title' => 'Проверка импорта проекта',
          'importReview.projectName' => 'Название проекта',
          'importReview.created' => 'Создан',
          'importReview.historyItems' => 'Элементы истории',
          'importReview.customSettingsTitle' =>
            'Обнаружены пользовательские настройки',
          'importReview.customSettingsWarning' =>
            'Этот проект содержит пользовательские настройки, которые переопределят ваши значения по умолчанию, пока этот проект открыт.',
          'importReview.standardSettings' =>
            'Этот проект использует стандартные глобальные настройки.',
          'importReview.cancelImport' => 'Отменить импорт',
          'importReview.trustOpen' => 'Доверять и открыть проект',
          'historyView.title' => 'История сравнений',
          'historyView.clearAll' => 'Очистить всю историю',
          'historyView.searchPlaceholder' => 'Поиск по имени файла...',
          'historyView.sortBy' => 'Сортировать по',
          'historyView.sortDate' => 'Дате',
          'historyView.sortSource' => 'Исходному файлу',
          'historyView.sortTarget' => 'Целевому файлу',
          'historyView.showCurrentProject' => 'Показать: текущий проект',
          'historyView.showAllHistory' => 'Показать: вся история',
          'historyView.groupByFolder' => 'Группировать по папке',
          'historyView.disableGrouping' => 'Отключить группировку по папкам',
          'historyView.filterAll' => 'Все',
          'historyView.filterFiles' => 'Файлы',
          'historyView.filterDirectories' => 'Каталоги',
          'historyView.filterGit' => 'Git',
          'historyView.noHistory' => 'История сравнений пуста',
          'historyView.historyDescription' =>
            'Ваши сравнения файлов появятся здесь',
          'historyView.noResults' => 'Результаты не найдены',
          'historyView.adjustSearch' => 'Попробуйте изменить запрос',
          'historyView.clearConfirmationTitle' => 'Очистить всю историю?',
          'historyView.clearConfirmationContent' =>
            'Это навсегда удалит всю историю сравнений. Это действие нельзя отменить.',
          'historyView.clearAction' => 'Очистить всё',
          'historyView.deletedMessage' => 'Элемент истории удалён',
          'historyView.undo' => 'Отменить',
          'historyView.viewDetails' => 'Показать детали',
          'historyView.delete' => 'Удалить',
          'historyView.openLocation' => 'Открыть расположение файла',
          'historyView.bilingual' => 'Двуязычный',
          'historyView.filePair' => 'Пара файлов',
          'historyView.directory' => 'Каталог',
          'historyView.git' => 'Git',
          'historyView.repo' => 'Репозиторий',
          'historyView.sourceDir' => 'Исходный каталог',
          'historyView.targetDir' => 'Целевой каталог',
          'historyView.source' => 'Источник',
          'historyView.target' => 'Цель',
          'historyView.noChanges' => 'Изменения не обнаружены',
          'historyView.added' => 'Добавлено',
          'historyView.removed' => 'Удалено',
          'historyView.modified' => 'Изменено',
          'historyView.status' => 'Статус',
          'historyView.actions' => 'Действия',
          'historyView.same' => 'Одинаковые',
          'historyView.total' => 'Всего',
          'historyView.currentProject' => 'Текущий проект',
          'historyView.unassigned' => 'Не назначено',
          'historyView.project' => 'Проект',
          'tutorial.skipTutorial' => 'ПРОПУСТИТЬ ОБУЧЕНИЕ',
          'tutorial.finishMessage' =>
            'Готово! Нажмите куда угодно для завершения.',
          'tutorial.next' => 'Далее',
          'tutorial.loadSampleData' => 'Загрузить примеры данных',
          'tutorial.browseSourceFile' => 'Выбрать исходный файл',
          'tutorial.browseTargetFile' => 'Выбрать целевой файл',
          'tutorial.compareFiles' => 'Сравнить файлы',
          'tutorial.hintPhase2' =>
            'Далее: фильтры, поиск, расширенный вид и экспорт.',
          'tutorial.steps.importSource.title' => '1. Импорт исходного файла',
          'tutorial.steps.importSource.description' =>
            'Используйте кнопку ниже для выбора файла или перетащите его в выделенную область.',
          'tutorial.steps.importTarget.title' => '2. Импорт целевого файла',
          'tutorial.steps.importTarget.description' =>
            'Используйте кнопку ниже для выбора файла или перетащите его в выделенную область.',
          'tutorial.steps.compare.title' => '3. Сравнить файлы',
          'tutorial.steps.compare.description' =>
            'Нажмите кнопку ниже, чтобы запустить сравнение и увидеть результаты.',
          'tutorial.steps.filter.title' => '4. Фильтрация результатов',
          'tutorial.steps.filter.description' =>
            'Используйте эти фильтры для просмотра добавленных, удалённых или изменённых строк.',
          'tutorial.steps.search.title' => '5. Поиск результатов',
          'tutorial.steps.search.description' =>
            'Найдите конкретные ключи или значения с помощью строки поиска.',
          'tutorial.steps.advanced.title' => '6. Расширенный вид',
          'tutorial.steps.advanced.description' =>
            'Откройте детальный вид diff с редактированием, ИИ-переводом и другими возможностями.',
          'tutorial.steps.export.title' => '7. Экспорт результатов',
          'tutorial.steps.export.description' =>
            'Сохраните сравнение в формате CSV, JSON или Excel.',
          'friendlyErrors.fileNotFound.message' => 'Файл или папка не найдены.',
          'friendlyErrors.fileNotFound.suggestion' =>
            'Проверьте, не был ли файл перемещён или удалён.',
          'friendlyErrors.accessDenied.message' =>
            'В доступе к файлу отказано.',
          'friendlyErrors.accessDenied.suggestion' =>
            'Попробуйте запустить приложение от имени администратора или проверьте права доступа.',
          'friendlyErrors.isDirectory.message' => 'Выбрана папка вместо файла.',
          'friendlyErrors.isDirectory.suggestion' =>
            'Пожалуйста, выберите корректный файл.',
          'friendlyErrors.fileAccess.message' => 'Проблема с доступом к файлу.',
          'friendlyErrors.fileAccess.suggestion' =>
            'Попробуйте закрыть другие программы, которые могут его использовать.',
          'friendlyErrors.unsupportedFormat.message' =>
            'Этот формат файла или операция не поддерживаются.',
          'friendlyErrors.unsupportedFormat.suggestion' =>
            'Проверьте расширение файла или попробуйте другой формат.',
          'friendlyErrors.networkError.message' =>
            'Не удалось подключиться к серверу.',
          'friendlyErrors.networkError.suggestion' =>
            'Проверьте подключение к интернету и попробуйте снова.',
          'friendlyErrors.notGitRepo.message' =>
            'Эта папка не является Git-проектом.',
          'friendlyErrors.notGitRepo.suggestion' =>
            'Перейдите в папку, содержащую каталог .git.',
          'friendlyErrors.mergeConflict.message' =>
            'В репозитории есть конфликты слияния.',
          'friendlyErrors.mergeConflict.suggestion' =>
            'Разрешите конфликты перед продолжением.',
          'friendlyErrors.gitAuthFailed.message' =>
            'Ошибка аутентификации Git.',
          'friendlyErrors.gitAuthFailed.suggestion' =>
            'Проверьте ваши учетные данные в Настройки > Контроль версий.',
          'friendlyErrors.gitOperationFailed.message' => 'Ошибка операции Git.',
          'friendlyErrors.gitOperationFailed.suggestion' =>
            'Проверьте Git view для деталей.',
          'friendlyErrors.invalidJson.message' =>
            'Формат файла неверный или повреждён.',
          'friendlyErrors.invalidJson.suggestion' =>
            'Убедитесь, что файл содержит корректный JSON.',
          'friendlyErrors.rateLimitReached.message' =>
            'Лимит переводов достигнут.',
          'friendlyErrors.rateLimitReached.suggestion' =>
            'Подождите несколько минут или проверьте лимиты вашего API-плана.',
          'friendlyErrors.invalidApiKey.message' => 'Неверный API ключ.',
          'friendlyErrors.invalidApiKey.suggestion' =>
            'Перейдите в Настройки > ИИ перевод для обновления ключа.',
          'friendlyErrors.translationServiceError.message' =>
            'Ошибка сервиса перевода.',
          'friendlyErrors.translationServiceError.suggestion' =>
            'Проверьте ваш API ключ и интернет-соединение.',
          'friendlyErrors.outOfMemory.message' =>
            'Недостаточно памяти для выполнения операции.',
          'friendlyErrors.outOfMemory.suggestion' =>
            'Попробуйте закрыть другие приложения или использовать файлы меньшего размера.',
          'friendlyErrors.genericError.message' => 'Что-то пошло не так.',
          'friendlyErrors.genericError.suggestion' =>
            'Пожалуйста, попробуйте снова. Если проблема сохраняется, перезапустите приложение.',
          'systemTray.showLocalizer' => 'Показать Localizer',
          'systemTray.exit' => 'Выход',
          'validation.connected' => 'Подключено.',
          'validation.connectionTimeout' =>
            'Время подключения истекло. Пожалуйста, попробуйте снова.',
          'validation.couldNotConnect' =>
            'Не удалось подключиться. Пожалуйста, попробуйте снова.',
          'validation.checkKeyAndTryAgain' =>
            'Не удалось подключиться. Пожалуйста, проверьте ключ и попробуйте снова.',
          'validation.tryAgainLater' =>
            'Не удалось подключиться сейчас. Пожалуйста, попробуйте позже.',
          'validation.serviceUnavailable' =>
            'Сервис недоступен сейчас. Пожалуйста, попробуйте позже.',
          'validation.enterKeyFirst' => 'Сначала введите ключ.',
          'validation.checking' => 'Проверка...',
          'validation.deeplUsage' => (
                  {required Object used, required Object limit}) =>
              'Использование: ${used} / ${limit} символов.',
          'status.startingComparison' => 'Начало сравнения...',
          'status.loadingFromHistory' => 'Загрузка файлов из истории...',
          'status.comparisonComplete' => 'Сравнение завершено',
          'status.couldNotImportFiles' =>
            'Не удалось импортировать файлы. Пожалуйста, попробуйте снова.',
          'status.historyFilesNotFound' =>
            'Один или оба файла из истории не найдены по исходным путям.',
          'aiServices.geminiEmptyResponse' => 'Gemini вернул пустой ответ',
          'aiServices.geminiStreamingEmpty' =>
            'Gemini streaming вернул пустой ответ',
          'aiServices.geminiRephraseEmpty' =>
            'Gemini вернул пустой ответ для перефразирования',
          'aiServices.openaiEmptyResponse' =>
            'OpenAI вернул пустой или неверный ответ',
          _ => null,
        };
  }
}
