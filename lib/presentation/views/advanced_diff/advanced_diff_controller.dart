
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_enums.dart'; 
import 'package:localizer_app_main/core/services/localization_file_service.dart';
import 'package:localizer_app_main/data/services/translation_memory_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:open_file_plus/open_file_plus.dart'; 

// Re-export enums if needed or define new ones here.
// For now, reusing Enums from the old view to minimize breakage during transition, 
// eventually we should move them to a shared model file.

class AdvancedDiffController extends ChangeNotifier {
  // State
  List<MapEntry<String, ComparisonStatusDetail>> processedEntries = [];
  Set<AdvancedDiffFilter> selectedFilters = {AdvancedDiffFilter.all};
  AdvancedDiffSimilarityFilter similarityFilter = AdvancedDiffSimilarityFilter.any;
  String searchQuery = '';
  
  // Clean / Dirty tracking
  Set<String> dirtyKeys = {};
  
  // Services
  final _fileService = LocalizationFileService();

  // Reviewed keys (dimmed, persisted in session)
  Set<String> reviewedKeys = {};

  // Editing mode preference
  bool useInlineEditing = true;

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
  
  // Dependencies or initial data
  final Map<String, ComparisonStatusDetail> fullDiff;
  final Map<String, String> file1Data;
  final Map<String, String> file2Data;
  final String? sourceFileExtension;
  final String? targetFileExtension;
  
  AdvancedDiffController({
    required this.fullDiff,
    required this.file1Data,
    required this.file2Data,
    this.sourceFileExtension,
    this.targetFileExtension,
  }) {
    _applyFilters();
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
    if (enabled) isFuzzyEnabled = false; // Mutex: disable fuzzy when regex is on
    _applyFilters();
  }
  
  void toggleFuzzy(bool enabled) {
    isFuzzyEnabled = enabled;
    if (enabled) isRegexEnabled = false; // Mutex: disable regex when fuzzy is on
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
            if (regex.hasMatch(key) || regex.hasMatch(val1) || regex.hasMatch(val2)) {
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
      if (selectedFilters.contains(AdvancedDiffFilter.all) || selectedFilters.isEmpty) {
         // Proceed to similarity check
      } else {
        bool matches = false;
        if (selectedFilters.contains(AdvancedDiffFilter.added) && status == StringComparisonStatus.added) matches = true;
        if (selectedFilters.contains(AdvancedDiffFilter.removed) && status == StringComparisonStatus.removed) matches = true;
        if (selectedFilters.contains(AdvancedDiffFilter.modified) && status == StringComparisonStatus.modified) matches = true;
        
        if (!matches) return false;
      }

      // Similarity Filter
      if (status == StringComparisonStatus.modified && similarityFilter != AdvancedDiffSimilarityFilter.any) {
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
    
    // Create backup once before first edit? Service creates backup on every upsert call which is slow for batch.
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
    // Assume Languages? En -> Tr placeholder for now?
    // We need language codes. 
    // Ideally we pass them in Controller constructor.
    await tmService.addTranslationUnit(
      sourceLang: 'en', // TODO: Dynamic
      targetLang: 'tr', // TODO: Dynamic
      sourceText: source,
      targetText: target
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
                      double sim = StringSimilarity.compareTwoStrings(sourceValue, newVal);
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
}
