import 'package:flutter/material.dart';
import 'dart:io';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/data/models/ai_suggestion_result.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/'
    'advanced_diff_enums.dart';
import 'package:localizer_app_main/core/services/'
    'localization_file_service.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/data/services/'
    'translation_memory_service.dart';
import 'package:localizer_app_main/data/services/ai_assistance_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/repositories/review_status_repository.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fuzzy/fuzzy.dart';

// Re-export enums if needed or define new ones here.
// For now, reuse Enums from the old view to minimize breakage during
// transition. We should move them to a shared model file later.

class AdvancedDiffController extends ChangeNotifier {
  // State
  List<MapEntry<String, ComparisonStatusDetail>> processedEntries = [];
  Set<AdvancedDiffFilter> selectedFilters = {AdvancedDiffFilter.all};
  AdvancedDiffSimilarityFilter similarityFilter =
      AdvancedDiffSimilarityFilter.any;
  String searchQuery = '';

  // Clean / Dirty tracking
  Set<String> dirtyKeys = {};

  // Services
  final _fileService = LocalizationFileService();
  final _reviewRepo = sl<ReviewStatusRepository>();

  // Reviewed keys (dimmed, persisted in session)
  Set<String> reviewedKeys = {};

  // Editing mode preference
  bool useInlineEditing = false;

  // Pagination
  int currentPage = 0;
  int itemsPerPage = 100;

  // TM Settings
  bool enableTM = true;
  bool autoApply = false;
  double minMatch = 0.6;
  int limit = 3;
  bool exactMatch = false;

  // Modifiers
  bool applyToAdded = true;
  bool applyToModified = true;
  bool onlyFillEmpty = false;
  bool limitToVisible = true;

  // AI Translation Settings
  String sourceLang = 'en';
  String targetLang = 'tr';
  bool isAiProcessing = false;
  double aiProgress = 0.0;

  // Dependencies or initial data
  final Map<String, ComparisonStatusDetail> fullDiff;
  final Map<String, String> file1Data;
  final Map<String, String> file2Data;
  final String? sourceFileExtension;
  final String? targetFileExtension;
  final String targetFilePath;

  AdvancedDiffController({
    required this.fullDiff,
    required this.file1Data,
    required this.file2Data,
    required this.targetFilePath,
    this.sourceFileExtension,
    this.targetFileExtension,
    bool? initialUseInlineEditing,
  }) {
    useInlineEditing = initialUseInlineEditing ?? useInlineEditing;
    _loadReviewedKeys();
    _applyFilters();
  }

  void _loadReviewedKeys() {
    final savedKeys = _reviewRepo.getReviewedKeys(targetFilePath);
    if (savedKeys.isNotEmpty) {
      reviewedKeys.addAll(savedKeys);
      // We don't need to notify listeners here as it's called in constructor
      // but if we call it later, we might need to.
    }
  }

  String getSourceValue(String key) => file1Data[key] ?? '';
  String getTargetValue(String key) => file2Data[key] ?? '';

  // Search Settings
  bool isRegexEnabled = false;
  bool isFuzzyEnabled = false;

  void updateSearch(String query) {
    searchQuery = query;
    _applyFilters();
  }

  void toggleRegex(bool enabled) {
    isRegexEnabled = enabled;
    if (enabled)
      isFuzzyEnabled = false; // Mutex: disable fuzzy when regex is on
    _applyFilters();
  }

  void toggleFuzzy(bool enabled) {
    isFuzzyEnabled = enabled;
    if (enabled)
      isRegexEnabled = false; // Mutex: disable regex when fuzzy is on
    _applyFilters();
  }

  // TM Settings Methods
  void setTmEnabled(bool value) {
    enableTM = value;
    notifyListeners();
  }

  void setTmAutoApply(bool value) {
    autoApply = value;
    notifyListeners();
  }

  void setTmMinMatch(double value) {
    minMatch = value;
    notifyListeners();
  }

  void setTmLimit(int value) {
    limit = value;
    notifyListeners();
  }

  void setTmExactMatch(bool value) {
    exactMatch = value;
    notifyListeners();
  }

  void toggleReviewed(String key) {
    if (reviewedKeys.contains(key)) {
      reviewedKeys.remove(key);
    } else {
      reviewedKeys.add(key);
    }
    // Save to persistence
    _reviewRepo.saveReviewedKeys(targetFilePath, reviewedKeys.toList());
    notifyListeners();
  }

  void setInlineEditing(bool value) {
    useInlineEditing = value;
    notifyListeners();
  }

  void setItemsPerPage(int items) {
    itemsPerPage = items;
    currentPage = 0;
    notifyListeners();
  }

  void nextPage() {
    final total = processedEntries.length;
    final maxPage = (total / itemsPerPage).ceil() - 1;
    if (currentPage < maxPage) {
      currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
      notifyListeners();
    }
  }

  void firstPage() {
    currentPage = 0;
    notifyListeners();
  }

  void lastPage() {
    final total = processedEntries.length;
    currentPage = (total / itemsPerPage).ceil() - 1;
    notifyListeners();
  }

  void updateFilters(Set<AdvancedDiffFilter> filters) {
    selectedFilters = filters;
    _applyFilters();
  }

  void toggleViewFilter(AdvancedDiffFilter filter) {
    if (filter == AdvancedDiffFilter.all) {
      if (selectedFilters.contains(AdvancedDiffFilter.all)) {
        selectedFilters.clear();
      } else {
        selectedFilters = {AdvancedDiffFilter.all};
      }
    } else {
      selectedFilters.remove(AdvancedDiffFilter.all);
      if (selectedFilters.contains(filter)) {
        selectedFilters.remove(filter);
      } else {
        selectedFilters.add(filter);
      }
      if (selectedFilters.isEmpty) {
        selectedFilters = {AdvancedDiffFilter.all};
      }
    }
    _applyFilters();
  }

  void _applyFilters() {
    processedEntries = fullDiff.entries.where((entry) {
      final status = entry.value.status;
      final similarity = entry.value.similarity;

      if (status == StringComparisonStatus.identical) return false;

      // Search filter
      if (searchQuery.isNotEmpty) {
        final query = isRegexEnabled ? searchQuery : searchQuery.toLowerCase();
        final key = entry.key;
        final val1 = getSourceValue(key);
        final val2 = getTargetValue(key);

        bool diffMatches = false;

        if (isRegexEnabled) {
          try {
            final regex = RegExp(query, caseSensitive: false);
            if (regex.hasMatch(key) ||
                regex.hasMatch(val1) ||
                regex.hasMatch(val2)) {
              diffMatches = true;
            }
          } catch (_) {
            return false;
          }
        } else if (isFuzzyEnabled) {
          // Fuzzy typo-tolerant search
          final searchables = [key, val1, val2];
          final fuse = Fuzzy(
            searchables,
            options: FuzzyOptions(
              threshold: 0.4, // Lower = stricter matching
              findAllMatches: true,
            ),
          );
          final results = fuse.search(searchQuery);
          if (results.isNotEmpty) {
            diffMatches = true;
          }
        } else {
          // Standard contains
          final qLower = query.toLowerCase();
          if (key.toLowerCase().contains(qLower) ||
              val1.toLowerCase().contains(qLower) ||
              val2.toLowerCase().contains(qLower)) {
            diffMatches = true;
          }
        }
        if (!diffMatches) return false;
      }

      // Filter Logic
      if (selectedFilters.contains(AdvancedDiffFilter.all) ||
          selectedFilters.isEmpty) {
        // Proceed to similarity check
      } else {
        bool matches = false;
        if (selectedFilters.contains(AdvancedDiffFilter.added) &&
            status == StringComparisonStatus.added) matches = true;
        if (selectedFilters.contains(AdvancedDiffFilter.removed) &&
            status == StringComparisonStatus.removed) matches = true;
        if (selectedFilters.contains(AdvancedDiffFilter.modified) &&
            status == StringComparisonStatus.modified) matches = true;

        if (!matches) return false;
      }

      // Similarity Filter
      if (status == StringComparisonStatus.modified &&
          similarityFilter != AdvancedDiffSimilarityFilter.any) {
        if (similarity == null) return false;
        switch (similarityFilter) {
          case AdvancedDiffSimilarityFilter.high:
            if (similarity < 0.7) return false;
            break;
          case AdvancedDiffSimilarityFilter.medium:
            if (similarity < 0.4 || similarity >= 0.7) return false;
            break;
          case AdvancedDiffSimilarityFilter.low:
            if (similarity >= 0.4) return false;
            break;
          case AdvancedDiffSimilarityFilter.any:
            break;
        }
      }

      return true;
    }).toList();

    // Sort? For now default order.
    currentPage = 0; // Reset page on filter change
    notifyListeners();
  }

  Map<String, int> get stats {
    int added = 0, removed = 0, modified = 0;
    for (var entry in fullDiff.values) {
      switch (entry.status) {
        case StringComparisonStatus.added:
          added++;
          break;
        case StringComparisonStatus.removed:
          removed++;
          break;
        case StringComparisonStatus.modified:
          modified++;
          break;
        default:
          break;
      }
    }
    return {
      'added': added,
      'removed': removed,
      'modified': modified,
      'total': fullDiff.length,
    };
  }

  // Editing Methods
  void updateEntry(String key, String newValue) {
    if (file2Data[key] == newValue) return;

    file2Data[key] = newValue;
    dirtyKeys.add(key);

    // Re-evaluate status
    final sourceValue = file1Data[key];
    if (sourceValue != null) {
      if (sourceValue == newValue) {
        fullDiff[key] = ComparisonStatusDetail.identical();
      } else {
        // Calculate new similarity if we want, or just set as modified
        // Using basic similarity check if package available, else dummy
        double sim = StringSimilarity.compareTwoStrings(sourceValue, newValue);
        fullDiff[key] = ComparisonStatusDetail.modified(sim);
      }
    } else {
      // It was removed (no source), now we are setting target?
      // If no source, it's "Added" in target (which is file2).
      fullDiff[key] = ComparisonStatusDetail.added();
    }

    _applyFilters();
  }

  Future<void> saveChanges(File targetFile, AppSettings settings) async {
    if (dirtyKeys.isEmpty) return;

    // We save ALL dirty keys.

    // Optimization: If file format allows batch update, use it.
    // Current service upsertEntry is per key.
    // We can iterate.
    int successCount = 0;

    // Create backup once before first edit? Service creates backup on every
    // upsert call which is slow for batch.
    // Ideally service should have batchUpsert.
    // For now, we accept the overhead or try to be smart.

    for (var key in dirtyKeys) {
      final val = file2Data[key];
      if (val != null) {
        await _fileService.upsertEntry(
          file: targetFile,
          key: key,
          value: val,
          settings: settings,
          encodingName: settings.defaultTargetEncoding,
        );
        successCount++;
      }
    }

    if (successCount > 0) {
      dirtyKeys.clear();
      notifyListeners();
    }
  }

  Future<void> addToTM(String key, String source, String target) async {
    final tmService = sl<TranslationMemoryService>();
    await tmService.addTranslationUnit(
      sourceLang: sourceLang.isNotEmpty ? sourceLang : 'und',
      targetLang: targetLang.isNotEmpty ? targetLang : 'und',
      sourceText: source,
      targetText: target,
    );
  }

  /// Reverts the target value to match the source value.
  void revertEntry(String key) {
    final source = file1Data[key];
    if (source == null) return; // Nothing to revert to

    file2Data[key] = source;
    dirtyKeys.add(key);
    fullDiff[key] = ComparisonStatusDetail.identical();
    _applyFilters();
  }

  /// Deletes the entry from the target file (sets value to empty).
  void deleteEntry(String key) {
    file2Data.remove(key);
    dirtyKeys.add(key);

    // If source exists, mark as removed. Otherwise, remove from diff entirely.
    if (file1Data.containsKey(key)) {
      fullDiff[key] = ComparisonStatusDetail.removed();
    } else {
      fullDiff.remove(key);
    }
    _applyFilters();
  }

  Future<String?> exportData() async {
    List<List<dynamic>> rows = [];
    rows.add(["Status", "Key", "Score", "Source", "Target"]);

    for (var entry in processedEntries) {
      var key = entry.key;
      var status = entry.value;
      var source = file1Data[key] ?? '';
      var target = file2Data[key] ?? '';

      rows.add([
        status.status.name,
        key,
        status.similarity?.toStringAsFixed(2) ?? '',
        source,
        target
      ]);
    }

    String csv = const ListToCsvConverter().convert(rows);

    String? output = await FilePicker.platform.saveFile(
      dialogTitle: 'Export Diff',
      fileName: 'diff_export.csv',
      allowedExtensions: ['csv'],
      type: FileType.custom,
    );

    if (output != null) {
      if (!output.endsWith('.csv')) output += '.csv';
      final file = File(output);
      await file.writeAsString(csv);
      return output;
    }
    return null;
  }

  Future<int> fillMissingFromTM() async {
    final tmService = sl<TranslationMemoryService>();
    int filledCount = 0;
    final updates = <String, String>{};

    // Iterate fullDiff to find missing targets
    for (var key in fullDiff.keys) {
      final currentTarget = file2Data[key];
      // If target is empty, try to fill
      if (currentTarget == null || currentTarget.trim().isEmpty) {
        final source = file1Data[key];
        if (source != null && source.isNotEmpty) {
          final match = await tmService.findBestMatch(
            sourceText: source,
            sourceLang: 'und', // TODO: Add lang awareness
            targetLang: 'und',
            minScore: minMatch,
          );

          if (match != null) {
            updates[key] = match.targetText;
          }
        }
      }
    }

    if (updates.isNotEmpty) {
      for (var entry in updates.entries) {
        final key = entry.key;
        final newVal = entry.value;

        file2Data[key] = newVal;
        dirtyKeys.add(key);

        final sourceValue = file1Data[key];
        if (sourceValue != null) {
          if (sourceValue == newVal) {
            fullDiff[key] = ComparisonStatusDetail.identical();
          } else {
            double sim =
                StringSimilarity.compareTwoStrings(sourceValue, newVal);
            fullDiff[key] = ComparisonStatusDetail.modified(sim);
          }
        } else {
          fullDiff[key] = ComparisonStatusDetail.added();
        }
        filledCount++;
      }
      _applyFilters();
    }
    return filledCount;
  }

  // ============================================
  // AI Translation Methods
  // ============================================

  /// Sets the source language for AI translation.
  void setSourceLang(String lang) {
    sourceLang = lang;
    notifyListeners();
  }

  /// Sets the target language for AI translation.
  void setTargetLang(String lang) {
    targetLang = lang;
    notifyListeners();
  }

  /// Gets the AI assistance service.
  AiAssistanceService get _aiService => sl<AiAssistanceService>();

  TalkerService get _talker => sl<TalkerService>();

  /// Returns keys that have a source value but no target value.
  List<String> getMissingKeys() {
    final missingKeys = <String>[];

    for (final entry in fullDiff.entries) {
      final key = entry.key;
      final targetValue = getTargetValue(key);
      final sourceValue = getSourceValue(key);

      if (sourceValue.isNotEmpty && targetValue.isEmpty) {
        missingKeys.add(key);
      }
    }

    return missingKeys;
  }

  /// Starts AI progress tracking.
  void startAiProcessing() {
    isAiProcessing = true;
    aiProgress = 0.0;
    notifyListeners();
  }

  /// Updates AI progress tracking.
  void updateAiProgress(double progress) {
    aiProgress = progress;
    notifyListeners();
  }

  /// Stops AI progress tracking.
  void stopAiProcessing() {
    isAiProcessing = false;
    aiProgress = 0.0;
    notifyListeners();
  }

  /// Requests a translation suggestion for a specific key.
  ///
  /// Returns a [TranslationSuggestion] for user review.
  Future<TranslationSuggestion> suggestTranslation(String key) async {
    final sourceText = getSourceValue(key);
    if (sourceText.isEmpty) {
      throw Exception('No source text for key: $key');
    }

    return await _aiService.suggestTranslation(
      text: sourceText,
      targetLanguage: targetLang,
      sourceLanguage: sourceLang,
    );
  }

  /// Requests a rephrase suggestion for the target value of a specific key.
  ///
  /// Returns a [RephraseResult] for user review.
  Future<RephraseResult> rephraseTarget(String key) async {
    final targetText = getTargetValue(key);
    if (targetText.isEmpty) {
      throw Exception('No target text to rephrase for key: $key');
    }

    final sourceText = getSourceValue(key);

    return await _aiService.rephrase(
      text: targetText,
      targetLanguage: targetLang,
      sourceText: sourceText.isNotEmpty ? sourceText : null,
    );
  }

  /// Applies an accepted AI suggestion to a key.
  void applyAiSuggestion(String key, String newValue) {
    updateEntry(key, newValue);
  }

  /// Translates all missing entries using AI.
  ///
  /// Calls [onProgress] with the current progress (0.0 to 1.0).
  /// Returns the number of entries translated.
  Future<int> translateAllMissing({
    void Function(double progress)? onProgress,
  }) async {
    startAiProcessing();

    int translatedCount = 0;
    final missingKeys = getMissingKeys();

    if (missingKeys.isEmpty) {
      stopAiProcessing();
      return 0;
    }

    try {
      for (int i = 0; i < missingKeys.length; i++) {
        final key = missingKeys[i];
        final sourceText = getSourceValue(key);

        try {
          final suggestion = await _aiService.suggestTranslation(
            text: sourceText,
            targetLanguage: targetLang,
            sourceLanguage: sourceLang,
          );

          // Apply the translation
          updateEntry(key, suggestion.translatedText);
          translatedCount++;
        } catch (e) {
          // Skip failed translations but continue with others
          _talker.warning('AI translate failed for "$key"', e);
        }

        // Update progress
        final progress = (i + 1) / missingKeys.length;
        updateAiProgress(progress);
        onProgress?.call(progress);
      }
    } finally {
      stopAiProcessing();
    }

    return translatedCount;
  }
}
