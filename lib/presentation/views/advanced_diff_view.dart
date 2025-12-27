import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/core/services/diff_calculator.dart';
import 'package:localizer_app_main/core/services/fuzzy_fill_rules.dart';
import '../../core/services/localization_file_service.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/services/'
    'translation_memory_service.dart';
import 'package:csv/csv.dart';
import '../../business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import '../widgets/common/diff_highlighter.dart';
import 'package:localizer_app_main/core/services/backup_service.dart';
import 'package:excel/excel.dart' hide Border;
import 'dart:convert';

// Filter options
enum AdvancedDiffFilter { all, added, removed, modified }

enum AdvancedDiffSimilarityFilter { any, high, medium, low }

// Sort order
enum DiffViewSortOrder { alphabetical, fileOrder }

enum _DeleteTarget { source, target, both }

class _EditContext {
  _EditContext({
    required this.isSource,
    required this.key,
    required this.originalValue,
  });

  final bool isSource;
  final String key;
  final String? originalValue;
}

class AdvancedDiffView extends StatefulWidget {
  final ComparisonResult comparisonResult;
  final File sourceFile;
  final File targetFile;

  const AdvancedDiffView({
    super.key,
    required this.comparisonResult,
    required this.sourceFile,
    required this.targetFile,
  });

  @override
  State<AdvancedDiffView> createState() => _AdvancedDiffViewState();
}

class _AdvancedDiffViewState extends State<AdvancedDiffView> {
  static const Map<String, String> _languageNameMap = {
    'english': 'en',
    'turkish': 'tr',
    'german': 'de',
    'french': 'fr',
    'spanish': 'es',
    'italian': 'it',
    'portuguese': 'pt',
    'brazilian': 'pt-br',
    'russian': 'ru',
    'japanese': 'ja',
    'korean': 'ko',
    'chinese': 'zh',
    'arabic': 'ar',
    'polish': 'pl',
    'dutch': 'nl',
    'swedish': 'sv',
    'norwegian': 'no',
    'danish': 'da',
    'finnish': 'fi',
  };

  // Filter & Sort
  Set<AdvancedDiffFilter> _selectedFilters = {AdvancedDiffFilter.all};
  AdvancedDiffSimilarityFilter _similarityFilter =
      AdvancedDiffSimilarityFilter.any;
  DiffViewSortOrder _currentSortOrder = DiffViewSortOrder.fileOrder;
  List<MapEntry<String, ComparisonStatusDetail>> _processedDiffEntries = [];
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final LocalizationFileService _fileService = LocalizationFileService();
  final TranslationMemoryService? _translationMemoryService =
      sl.isRegistered<TranslationMemoryService>()
          ? sl<TranslationMemoryService>()
          : null;
  final Map<String, TextEditingController> _cellControllers = {};
  final Map<String, FocusNode> _cellFocusNodes = {};
  final Set<String> _editingCells = {};
  final Set<String> _savingCells = {};
  final Map<String, _EditContext> _editContexts = {};
  bool _savingAllEdits = false;
  bool _addingAllToMemory = false;
  bool _runningFuzzyFill = false;
  bool _exportingFuzzyReport = false;
  late final String _sourceLanguageCode;
  late final String _targetLanguageCode;
  String? _sourceLanguageOverride;
  String? _targetLanguageOverride;
  bool _languagePromptShown = false;

  final Map<String, List<TranslationMemoryMatch>> _fuzzyMatchCache = {};
  final Set<String> _fuzzyMatchLoading = {};
  bool _showFuzzyPreviews = false;
  bool _fuzzyMinScoreDirty = false;
  double _fuzzyMinScoreDraft = 0.6;
  final Set<String> _selectedRowKeys = {};
  bool _applyToAdded = true;
  bool _applyToModified = true;
  bool _limitToVisibleEntries = true;
  bool _useSelectionOnly = false;

  // Pagination
  int _currentPage = 0;
  int _itemsPerPage = 100;
  final List<int> _itemsPerPageOptions = [50, 100, 200, 500];

  // Resizable columns - relative widths (sum = 1.0)
  double _statusWidth = 0.10;
  double _keyWidth = 0.28;
  double _oldValueWidth = 0.31;
  double _newValueWidth = 0.31;
  static const double _selectionColumnWidth = 32;
  static const double _rowNumberColumnWidth = 40;
  static const double _actionColumnWidth = 132;

  // Minimum column widths
  static const double _minColWidth = 0.08;

  // Thresholds
  static const double _highSimilarityThreshold = 0.7;
  static const double _lowSimilarityThreshold = 0.4;

  // Modern color palette (GitHub-style dark)
  static const Color _bgPrimary = Color(0xFF0D1117);
  static const Color _bgSecondary = Color(0xFF161B22);
  static const Color _bgHeader = Color(0xFF21262D);
  static const Color _borderColor = Color(0xFF30363D);
  static const Color _textPrimary = Color(0xFFE6EDF3);
  static const Color _textSecondary = Color(0xFF8B949E);

  @override
  void initState() {
    super.initState();
    _sourceLanguageCode = _detectLanguageFromPath(widget.sourceFile.path);
    _targetLanguageCode = _detectLanguageFromPath(widget.targetFile.path);
    _processDiffEntries();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybePromptLanguageOverride();
    });
  }

  @override
  void dispose() {
    for (final controller in _cellControllers.values) {
      controller.dispose();
    }
    for (final focusNode in _cellFocusNodes.values) {
      focusNode.dispose();
    }
    _cellControllers.clear();
    _cellFocusNodes.clear();
    _searchController.dispose();
    super.dispose();
  }

  // Stats calculation
  Map<String, int> get _stats {
    int added = 0, removed = 0, modified = 0;
    for (var entry in widget.comparisonResult.diff.entries) {
      switch (entry.value.status) {
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
      'total': added + removed + modified
    };
  }

  List<MapEntry<String, ComparisonStatusDetail>> get _paginatedEntries {
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex =
        (startIndex + _itemsPerPage).clamp(0, _processedDiffEntries.length);
    if (startIndex >= _processedDiffEntries.length) return [];
    return _processedDiffEntries.sublist(startIndex, endIndex);
  }

  int get _totalPages => (_processedDiffEntries.length / _itemsPerPage).ceil();

  void _goToPage(int page) {
    setState(() => _currentPage = page.clamp(0, _totalPages - 1));
  }

  void _changeItemsPerPage(int newItemsPerPage) {
    setState(() {
      _itemsPerPage = newItemsPerPage;
      _currentPage = 0;
    });
  }

  void _processDiffEntries({bool resetPage = true}) {
    List<MapEntry<String, ComparisonStatusDetail>> filteredEntries =
        widget.comparisonResult.diff.entries.where((entry) {
      final status = entry.value.status;
      final similarity = entry.value.similarity;

      if (status == StringComparisonStatus.identical) return false;

      // Search filter
      if (_searchQuery.isNotEmpty) {
        final key = entry.key.toLowerCase();
        final query = _searchQuery.toLowerCase();
        if (!key.contains(query)) return false;
      }

      // Filter Logic (Union of selected filters)
      if (_selectedFilters.contains(AdvancedDiffFilter.all) ||
          _selectedFilters.isEmpty) {
        return true;
      }

      bool matches = false;

      if (_selectedFilters.contains(AdvancedDiffFilter.added)) {
        if (status == StringComparisonStatus.added) matches = true;
      }
      if (!matches && _selectedFilters.contains(AdvancedDiffFilter.removed)) {
        if (status == StringComparisonStatus.removed) matches = true;
      }
      if (!matches && _selectedFilters.contains(AdvancedDiffFilter.modified)) {
        if (status == StringComparisonStatus.modified) matches = true;
      }

      if (!matches) {
        return false;
      }

      if (status == StringComparisonStatus.modified &&
          _similarityFilter != AdvancedDiffSimilarityFilter.any) {
        return _matchesSimilarityFilter(similarity);
      }

      return true;
    }).toList();

    // Sorting
    if (_currentSortOrder == DiffViewSortOrder.alphabetical) {
      filteredEntries
          .sort((a, b) => a.key.toLowerCase().compareTo(b.key.toLowerCase()));
    } else {
      final sourceKeys = widget.comparisonResult.file1Data.keys.toList();
      final keyIndex = {
        for (var i = 0; i < sourceKeys.length; i++) sourceKeys[i]: i
      };
      filteredEntries.sort((a, b) {
        final indexA = keyIndex[a.key] ?? -1;
        final indexB = keyIndex[b.key] ?? -1;
        if (indexA == -1 && indexB == -1) return a.key.compareTo(b.key);
        if (indexA == -1) return 1;
        if (indexB == -1) return -1;
        return indexA.compareTo(indexB);
      });
    }

    final totalPages = (filteredEntries.length / _itemsPerPage).ceil();
    final maxPage = totalPages > 0 ? totalPages - 1 : 0;
    final nextPage = resetPage ? 0 : _currentPage;

    setState(() {
      _processedDiffEntries = filteredEntries;
      _selectedRowKeys.retainAll(
        filteredEntries.map((entry) => entry.key),
      );
      _currentPage = nextPage.clamp(0, maxPage);
    });
  }

  bool _matchesSimilarityFilter(double? similarity) {
    if (similarity == null) {
      return false;
    }
    switch (_similarityFilter) {
      case AdvancedDiffSimilarityFilter.high:
        return similarity >= _highSimilarityThreshold;
      case AdvancedDiffSimilarityFilter.medium:
        return similarity >= _lowSimilarityThreshold &&
            similarity < _highSimilarityThreshold;
      case AdvancedDiffSimilarityFilter.low:
        return similarity < _lowSimilarityThreshold;
      case AdvancedDiffSimilarityFilter.any:
        return true;
    }
  }

  String _cellKey(String key, bool isSource) {
    return '${isSource ? 'source' : 'target'}::$key';
  }

  TextEditingController _ensureController(String cellKey) {
    return _cellControllers.putIfAbsent(
      cellKey,
      () => TextEditingController(),
    );
  }

  FocusNode _ensureFocusNode(String cellKey) {
    return _cellFocusNodes.putIfAbsent(cellKey, () {
      final focusNode = FocusNode(debugLabel: cellKey);
      focusNode.addListener(() {
        if (!focusNode.hasFocus && _editingCells.contains(cellKey)) {
          final context = _editContexts[cellKey];
          if (context == null) {
            return;
          }
          _commitEdit(
            cellKey: cellKey,
            isSource: context.isSource,
            key: context.key,
            originalValue: context.originalValue,
            newValue: _cellControllers[cellKey]?.text ?? '',
          );
        }
      });
      return focusNode;
    });
  }

  void _startEditing({
    required String cellKey,
    required String initialValue,
    required bool isSource,
    required String key,
    required String? originalValue,
  }) {
    final controller = _ensureController(cellKey);
    controller.text = initialValue;
    controller.selection = TextSelection.collapsed(
      offset: controller.text.length,
    );
    final focusNode = _ensureFocusNode(cellKey);
    setState(() {
      _editingCells.add(cellKey);
      _editContexts[cellKey] = _EditContext(
        isSource: isSource,
        key: key,
        originalValue: originalValue,
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      focusNode.requestFocus();
    });
  }

  void _stopEditing(String cellKey) {
    if (_editingCells.remove(cellKey)) {
      _editContexts.remove(cellKey);
      setState(() {});
    }
  }

  void _clearCellState(String key) {
    for (final isSource in [true, false]) {
      final cellKey = _cellKey(key, isSource);
      _editingCells.remove(cellKey);
      _editContexts.remove(cellKey);
      _cellControllers.remove(cellKey)?.dispose();
      _cellFocusNodes.remove(cellKey)?.dispose();
    }
  }

  void _replaceComparisonData({
    Map<String, String>? sourceData,
    Map<String, String>? targetData,
    bool resetPage = false,
  }) {
    if (sourceData != null) {
      widget.comparisonResult.file1Data
        ..clear()
        ..addAll(sourceData);
    }
    if (targetData != null) {
      widget.comparisonResult.file2Data
        ..clear()
        ..addAll(targetData);
    }
    _refreshDiff(resetPage: resetPage);
  }

  void _refreshDiff({bool resetPage = false}) {
    final settingsState = context.read<SettingsBloc>().state;
    if (settingsState.status != SettingsStatus.loaded) {
      return;
    }
    final settings = settingsState.appSettings;
    final diff = DiffCalculator.calculateDiff(
      data1: widget.comparisonResult.file1Data,
      data2: widget.comparisonResult.file2Data,
      ignoreCase: settings.ignoreCase,
      ignorePatterns: settings.ignorePatterns,
      ignoreWhitespace: settings.ignoreWhitespace,
      comparisonMode: settings.comparisonMode,
      similarityThreshold: settings.similarityThreshold,
    );
    widget.comparisonResult.diff
      ..clear()
      ..addAll(diff);
    _processDiffEntries(resetPage: resetPage);
  }

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _saveAllEdits() async {
    if (_savingAllEdits) {
      return;
    }
    if (_editingCells.isEmpty) {
      _showMessage('No edits to save.');
      return;
    }
    setState(() => _savingAllEdits = true);
    int saved = 0;
    int failed = 0;
    final cells = List<String>.from(_editingCells);
    for (final cellKey in cells) {
      final context = _editContexts[cellKey];
      final controller = _cellControllers[cellKey];
      if (context == null || controller == null) {
        continue;
      }
      if (_savingCells.contains(cellKey)) {
        continue;
      }
      _savingCells.add(cellKey);
      final success = await _saveEdit(
        isSource: context.isSource,
        key: context.key,
        originalValue: context.originalValue,
        newValue: controller.text,
      );
      _savingCells.remove(cellKey);
      if (success) {
        _stopEditing(cellKey);
        saved++;
      } else {
        failed++;
      }
    }
    if (mounted) {
      setState(() => _savingAllEdits = false);
    }
    if (!mounted) {
      return;
    }
    if (saved == 0 && failed == 0) {
      _showMessage('No changes to save.');
    } else if (failed == 0) {
      _showMessage('Saved $saved changes.');
    } else {
      _showMessage(
        'Saved $saved changes. $failed failed.',
        isError: true,
      );
    }
  }

  Future<bool> _saveEdit({
    required bool isSource,
    required String key,
    required String? originalValue,
    required String newValue,
  }) async {
    if (originalValue == null && newValue.trim().isEmpty) {
      return true;
    }
    if (originalValue != null && newValue == originalValue) {
      return true;
    }

    final settingsState = context.read<SettingsBloc>().state;
    if (settingsState.status != SettingsStatus.loaded) {
      _showMessage('Please try again in a moment.', isError: true);
      return false;
    }

    final settings = settingsState.appSettings;
    final file = isSource ? widget.sourceFile : widget.targetFile;
    final forcedFormat =
        isSource ? settings.defaultSourceFormat : settings.defaultTargetFormat;
    final encodingName = isSource
        ? settings.defaultSourceEncoding
        : settings.defaultTargetEncoding;

    if (!_fileService.canEditFile(file, forcedFormat: forcedFormat)) {
      _showMessage(
        'Editing is not available for this file type.',
        isError: true,
      );
      return false;
    }

    try {
      final updated = await _fileService.upsertEntry(
        file: file,
        key: key,
        value: newValue,
        settings: settings,
        encodingName: encodingName,
        forcedFormat: forcedFormat,
        relatedValue: isSource ? null : widget.comparisonResult.file1Data[key],
      );
      if (!mounted) {
        return false;
      }
      _replaceComparisonData(
        sourceData: isSource ? updated : null,
        targetData: isSource ? null : updated,
      );
      _showMessage(
        isSource ? 'Saved to the source file.' : 'Saved to the target file.',
      );
      return true;
    } catch (e, s) {
      developer.log(
        'Failed to save entry',
        name: 'AdvancedDiffView',
        error: e,
        stackTrace: s,
      );
      _showMessage('Sorry, that change did not save.', isError: true);
      return false;
    }
  }

  Future<void> _commitEdit({
    required String cellKey,
    required bool isSource,
    required String key,
    required String? originalValue,
    required String newValue,
  }) async {
    if (!_editingCells.contains(cellKey)) {
      return;
    }
    if (_savingCells.contains(cellKey)) {
      return;
    }
    _savingCells.add(cellKey);
    final success = await _saveEdit(
      isSource: isSource,
      key: key,
      originalValue: originalValue,
      newValue: newValue,
    );
    _savingCells.remove(cellKey);
    if (success) {
      _stopEditing(cellKey);
    }
  }

  Future<void> _deleteKey({
    required String key,
    required bool deleteSource,
    required bool deleteTarget,
  }) async {
    if (!deleteSource && !deleteTarget) {
      return;
    }

    final settingsState = context.read<SettingsBloc>().state;
    if (settingsState.status != SettingsStatus.loaded) {
      _showMessage('Please try again in a moment.', isError: true);
      return;
    }

    final settings = settingsState.appSettings;
    Map<String, String>? sourceData;
    Map<String, String>? targetData;
    var hasError = false;

    if (deleteSource) {
      try {
        sourceData = await _fileService.deleteEntry(
          file: widget.sourceFile,
          key: key,
          settings: settings,
          encodingName: settings.defaultSourceEncoding,
          forcedFormat: settings.defaultSourceFormat,
        );
      } catch (e, s) {
        developer.log(
          'Failed to delete source entry',
          name: 'AdvancedDiffView',
          error: e,
          stackTrace: s,
        );
        hasError = true;
      }
    }

    if (deleteTarget) {
      try {
        targetData = await _fileService.deleteEntry(
          file: widget.targetFile,
          key: key,
          settings: settings,
          encodingName: settings.defaultTargetEncoding,
          forcedFormat: settings.defaultTargetFormat,
        );
      } catch (e, s) {
        developer.log(
          'Failed to delete target entry',
          name: 'AdvancedDiffView',
          error: e,
          stackTrace: s,
        );
        hasError = true;
      }
    }

    if (!mounted) {
      return;
    }

    if (sourceData != null || targetData != null) {
      _clearCellState(key);
      _replaceComparisonData(
        sourceData: sourceData,
        targetData: targetData,
      );
    }

    if (hasError) {
      _showMessage('Sorry, that delete did not finish.', isError: true);
      return;
    }

    if (deleteSource && deleteTarget) {
      _showMessage('Deleted from both files.');
    } else if (deleteSource) {
      _showMessage('Deleted from the source file.');
    } else if (deleteTarget) {
      _showMessage('Deleted from the target file.');
    }
  }

  Future<void> _confirmDelete(String key) async {
    final hasSource = widget.comparisonResult.file1Data.containsKey(key);
    final hasTarget = widget.comparisonResult.file2Data.containsKey(key);

    final choice = await showDialog<_DeleteTarget>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete this key?'),
          content: const Text('Choose where to remove it.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            if (hasSource)
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(_DeleteTarget.source),
                child: const Text('Source only'),
              ),
            if (hasTarget)
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(_DeleteTarget.target),
                child: const Text('Target only'),
              ),
            if (hasSource && hasTarget)
              TextButton(
                onPressed: () => Navigator.of(context).pop(_DeleteTarget.both),
                child: const Text('Both'),
              ),
          ],
        );
      },
    );

    if (choice == null) {
      return;
    }

    switch (choice) {
      case _DeleteTarget.source:
        await _deleteKey(key: key, deleteSource: true, deleteTarget: false);
        break;
      case _DeleteTarget.target:
        await _deleteKey(key: key, deleteSource: false, deleteTarget: true);
        break;
      case _DeleteTarget.both:
        await _deleteKey(key: key, deleteSource: true, deleteTarget: true);
        break;
    }
  }

  Widget _buildEditableCell({
    required String entryKey,
    required bool isSource,
    required String? currentValue,
    required Widget displayWidget,
    required TextStyle textStyle,
    required Color subtleText,
    required bool canEdit,
  }) {
    final cellKey = _cellKey(entryKey, isSource);
    if (!canEdit) {
      return Tooltip(
        message: 'Editing is not available for this file type.',
        child: displayWidget,
      );
    }

    if (!_editingCells.contains(cellKey)) {
      return Tooltip(
        message: 'Click to edit',
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _startEditing(
            cellKey: cellKey,
            initialValue: currentValue ?? '',
            isSource: isSource,
            key: entryKey,
            originalValue: currentValue,
          ),
          child: SizedBox.expand(
            child: Align(
              alignment: Alignment.centerLeft,
              child: IgnorePointer(child: displayWidget),
            ),
          ),
        ),
      );
    }

    final controller = _ensureController(cellKey);
    final focusNode = _ensureFocusNode(cellKey);
    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: textStyle,
      maxLines: 1,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        hintText: currentValue == null ? 'Add text' : null,
        hintStyle: TextStyle(
          color: subtleText,
          fontSize: textStyle.fontSize,
        ),
      ),
      onTapOutside: (_) {
        _commitEdit(
          cellKey: cellKey,
          isSource: isSource,
          key: entryKey,
          originalValue: currentValue,
          newValue: controller.text,
        );
      },
      onSubmitted: (value) {
        _commitEdit(
          cellKey: cellKey,
          isSource: isSource,
          key: entryKey,
          originalValue: currentValue,
          newValue: value,
        );
      },
    );
  }

  Future<void> _addToTranslationMemory({
    required String sourceText,
    required String targetText,
  }) async {
    final service = _translationMemoryService;
    if (service == null) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Translation memory is unavailable.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    try {
      await service.addTranslationUnit(
        sourceLang: _sourceLanguageCode,
        targetLang: _targetLanguageCode,
        sourceText: sourceText,
        targetText: targetText,
      );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saved to memory.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e, s) {
      developer.log(
        'Failed to save translation memory entry.',
        name: 'translation_memory.add',
        error: e,
        stackTrace: s,
      );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not save to memory.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _addAllToTranslationMemory() async {
    if (_addingAllToMemory) {
      return;
    }
    final service = _translationMemoryService;
    if (service == null) {
      _showMessage('Translation memory is unavailable.', isError: true);
      return;
    }
    setState(() => _addingAllToMemory = true);
    int added = 0;
    try {
      for (final entry in _processedDiffEntries) {
        if (entry.value.status != StringComparisonStatus.modified) {
          continue;
        }
        final sourceText =
            widget.comparisonResult.file1Data[entry.key]?.trim() ?? '';
        final targetText =
            widget.comparisonResult.file2Data[entry.key]?.trim() ?? '';
        if (sourceText.isEmpty || targetText.isEmpty) {
          continue;
        }
        await service.addTranslationUnit(
          sourceLang: _sourceLanguageCode,
          targetLang: _targetLanguageCode,
          sourceText: sourceText,
          targetText: targetText,
        );
        added++;
      }
    } catch (e, s) {
      developer.log(
        'Failed to add translation memory entries.',
        name: 'translation_memory.add_all',
        error: e,
        stackTrace: s,
      );
      if (mounted) {
        _showMessage('Could not add all to memory.', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() => _addingAllToMemory = false);
      }
    }
    if (!mounted) {
      return;
    }
    if (added == 0) {
      _showMessage('Nothing to add yet.');
    } else {
      _showMessage('Added $added items to memory.');
    }
  }

  double _effectiveFuzzyMinScore(AppSettings settings) {
    if (settings.fuzzyFillExactMatchesOnly) {
      return 1.0;
    }
    return settings.fuzzyFillMinScore.clamp(0.0, 1.0);
  }

  void _syncFuzzyMinScore(AppSettings settings) {
    if (_fuzzyMinScoreDirty) {
      return;
    }
    _fuzzyMinScoreDraft = _effectiveFuzzyMinScore(settings);
  }

  FuzzyFillRules _fuzzyFillRules(AppSettings settings) {
    return FuzzyFillRules(
      minScore: _effectiveFuzzyMinScore(settings),
      onlyEmptyTargets: settings.fuzzyFillOnlyEmptyTargets,
      applyToAdded: _applyToAdded,
      applyToModified: _applyToModified,
    );
  }

  List<MapEntry<String, ComparisonStatusDetail>> _entriesForFuzzyFill() {
    final entries = _limitToVisibleEntries
        ? _processedDiffEntries
        : widget.comparisonResult.diff.entries
            .where((entry) =>
                entry.value.status != StringComparisonStatus.identical)
            .toList();
    if (_useSelectionOnly) {
      if (_selectedRowKeys.isEmpty) {
        return [];
      }
      return entries
          .where((entry) => _selectedRowKeys.contains(entry.key))
          .toList();
    }
    return entries;
  }

  void _clearFuzzyMatchCache() {
    setState(() {
      _fuzzyMatchCache.clear();
      _fuzzyMatchLoading.clear();
    });
  }

  String _formatScore(double score) {
    return '${(score * 100).round()}%';
  }

  Future<bool> _ensureTranslationMemoryReady() async {
    final service = _translationMemoryService;
    if (service == null) {
      _showMessage('Translation memory is unavailable.', isError: true);
      return false;
    }
    final settingsState = context.read<SettingsBloc>().state;
    if (settingsState.status != SettingsStatus.loaded) {
      _showMessage('Please try again in a moment.', isError: true);
      return false;
    }
    if (!settingsState.appSettings.enableTranslationMemory) {
      _showMessage('Translation memory is turned off in settings.');
      return false;
    }
    final stats = await service.getStats();
    if (stats.entryCount == 0) {
      _showMessage('Translation memory is empty.');
      return false;
    }
    return true;
  }

  Future<void> _loadFuzzyMatchesForEntries({
    required List<MapEntry<String, ComparisonStatusDetail>> entries,
    required AppSettings settings,
  }) async {
    final service = _translationMemoryService;
    if (service == null) {
      return;
    }

    final rules = _fuzzyFillRules(settings);
    final sourceLang = _effectiveSourceLanguage();
    final targetLang = _effectiveTargetLanguage();

    for (final entry in entries) {
      final key = entry.key;
      if (_fuzzyMatchCache.containsKey(key) ||
          _fuzzyMatchLoading.contains(key)) {
        continue;
      }
      final status = entry.value.status;
      if (status != StringComparisonStatus.added &&
          status != StringComparisonStatus.modified) {
        continue;
      }
      final sourceText = widget.comparisonResult.file1Data[key]?.trim() ?? '';
      if (sourceText.isEmpty) {
        continue;
      }
      final targetText = widget.comparisonResult.file2Data[key]?.trim() ?? '';
      if (rules.onlyEmptyTargets && targetText.isNotEmpty) {
        continue;
      }
      if (status == StringComparisonStatus.added && !rules.applyToAdded) {
        continue;
      }
      if (status == StringComparisonStatus.modified && !rules.applyToModified) {
        continue;
      }

      _fuzzyMatchLoading.add(key);
      final matches = await service.findMatches(
        sourceText: sourceText,
        sourceLang: sourceLang,
        targetLang: targetLang,
        minScore: rules.minScore,
        limit: settings.fuzzyFillMatchLimit,
      );
      _fuzzyMatchCache[key] = matches;
      _fuzzyMatchLoading.remove(key);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<Map<String, String>?> _saveTargetSilently({
    required String key,
    required String newValue,
  }) async {
    final settingsState = context.read<SettingsBloc>().state;
    if (settingsState.status != SettingsStatus.loaded) {
      return null;
    }

    final settings = settingsState.appSettings;
    try {
      return await _fileService.upsertEntry(
        file: widget.targetFile,
        key: key,
        value: newValue,
        settings: settings,
        encodingName: settings.defaultTargetEncoding,
        forcedFormat: settings.defaultTargetFormat,
        relatedValue: widget.comparisonResult.file1Data[key],
      );
    } catch (e, s) {
      developer.log(
        'Failed to apply fuzzy match.',
        name: 'AdvancedDiffView',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  Future<void> _applyMatchForKey(String key) async {
    final settingsState = context.read<SettingsBloc>().state;
    if (settingsState.status != SettingsStatus.loaded) {
      _showMessage('Please try again in a moment.', isError: true);
      return;
    }
    if (!_fileService.canEditFile(
      widget.targetFile,
      forcedFormat: settingsState.appSettings.defaultTargetFormat,
    )) {
      _showMessage('Editing is not available for this file type.');
      return;
    }
    final matches = _fuzzyMatchCache[key];
    final match = matches == null || matches.isEmpty ? null : matches.first;
    if (match == null) {
      _showMessage('No match available for this row.');
      return;
    }
    final updatedMap = await _saveTargetSilently(
      key: key,
      newValue: match.targetText,
    );
    if (updatedMap == null) {
      _showMessage('Sorry, that change did not save.', isError: true);
      return;
    }
    _replaceComparisonData(targetData: updatedMap);
    _showMessage('Applied the match.');
  }

  Future<void> _runFuzzyFill({required bool previewOnly}) async {
    if (_runningFuzzyFill) {
      return;
    }
    if (!await _ensureTranslationMemoryReady()) {
      return;
    }
    final settingsState = context.read<SettingsBloc>().state;
    if (settingsState.status != SettingsStatus.loaded) {
      return;
    }
    final settings = settingsState.appSettings;
    if (!settings.enableFuzzyFill) {
      _showMessage('Enable fuzzy fill to use this feature.');
      return;
    }
    setState(() => _runningFuzzyFill = true);
    final entries = _entriesForFuzzyFill();
    if (entries.isEmpty) {
      setState(() => _runningFuzzyFill = false);
      if (_useSelectionOnly && _selectedRowKeys.isEmpty) {
        _showMessage('Select rows to use selection-only mode.');
      } else {
        _showMessage('No rows match your current filters.');
      }
      return;
    }

    await _loadFuzzyMatchesForEntries(entries: entries, settings: settings);

    if (previewOnly) {
      setState(() => _showFuzzyPreviews = true);
      _showMessage('Loaded match previews.');
      setState(() => _runningFuzzyFill = false);
      return;
    }

    if (!settings.fuzzyFillAutoApply) {
      setState(() => _runningFuzzyFill = false);
      _showMessage('Matches are ready to review.');
      return;
    }
    if (!_fileService.canEditFile(
      widget.targetFile,
      forcedFormat: settings.defaultTargetFormat,
    )) {
      setState(() => _runningFuzzyFill = false);
      _showMessage('Editing is not available for this file type.');
      return;
    }

    final rules = _fuzzyFillRules(settings);
    int applied = 0;
    int noMatch = 0;
    int skipped = 0;
    int failed = 0;
    Map<String, String>? updatedTargetData;

    for (final entry in entries) {
      final key = entry.key;
      final status = entry.value.status;
      final matches = _fuzzyMatchCache[key];
      final match = matches == null || matches.isEmpty ? null : matches.first;
      if (match == null) {
        noMatch++;
        continue;
      }
      final targetText = widget.comparisonResult.file2Data[key]?.trim() ?? '';
      if (!rules.canApply(
        status: status,
        currentTarget: targetText,
        score: match.score,
      )) {
        skipped++;
        continue;
      }
      if (_editingCells.contains(_cellKey(key, false))) {
        skipped++;
        continue;
      }
      if (targetText.trim() == match.targetText.trim()) {
        skipped++;
        continue;
      }
      final nextMap = await _saveTargetSilently(
        key: key,
        newValue: match.targetText,
      );
      if (nextMap == null) {
        failed++;
        continue;
      }
      updatedTargetData = nextMap;
      applied++;
    }

    if (updatedTargetData != null) {
      _replaceComparisonData(targetData: updatedTargetData);
    }

    if (!mounted) {
      return;
    }
    setState(() => _runningFuzzyFill = false);
    if (applied == 0 && failed == 0) {
      _showMessage('No matches were applied.');
      return;
    }
    if (failed == 0) {
      _showMessage('Applied $applied matches. $noMatch had no match.');
      return;
    }
    _showMessage(
      'Applied $applied matches. $noMatch had no match. $failed failed.',
      isError: true,
    );
  }

  Future<void> _exportFuzzyMatchReport() async {
    if (_exportingFuzzyReport) {
      return;
    }
    if (!await _ensureTranslationMemoryReady()) {
      return;
    }
    setState(() => _exportingFuzzyReport = true);
    final settingsState = context.read<SettingsBloc>().state;
    if (settingsState.status != SettingsStatus.loaded) {
      setState(() => _exportingFuzzyReport = false);
      return;
    }
    final settings = settingsState.appSettings;
    final entries = _entriesForFuzzyFill();
    await _loadFuzzyMatchesForEntries(entries: entries, settings: settings);

    final rows = <List<String>>[
      ['Key', 'Source', 'Suggested Target', 'Score'],
    ];
    for (final entry in entries) {
      final key = entry.key;
      final sourceText = widget.comparisonResult.file1Data[key] ?? '';
      final matches = _fuzzyMatchCache[key];
      final match = matches == null || matches.isEmpty ? null : matches.first;
      if (match == null) {
        continue;
      }
      rows.add([
        key,
        sourceText,
        match.targetText,
        _formatScore(match.score),
      ]);
    }

    if (rows.length == 1) {
      setState(() => _exportingFuzzyReport = false);
      _showMessage('No matches available to export.');
      return;
    }

    String csvString = const ListToCsvConverter().convert(rows);
    if (settings.includeUtf8Bom) {
      csvString = '\uFEFF$csvString';
    }

    final outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Match Report',
      fileName: 'fuzzy_match_report.csv',
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (outputPath != null) {
      try {
        await BackupService().createBackupIfNeeded(
          targetPath: outputPath,
          settings: settings,
        );
        await File(outputPath).writeAsString(csvString);
        if (mounted) {
          if (settings.openFolderAfterExport && Platform.isWindows) {
            Process.run('explorer.exe', [File(outputPath).parent.path]);
          }
          _showMessage('Match report saved.');
        }
      } catch (e) {
        if (mounted) {
          _showMessage('Failed to save match report.', isError: true);
        }
      }
    }

    if (mounted) {
      setState(() => _exportingFuzzyReport = false);
    }
  }

  String _detectLanguageFromPath(String filePath) {
    final normalized = filePath.replaceAll('\\', '/').toLowerCase();
    final segments = normalized.split('/');
    final fileName = segments.isNotEmpty ? segments.last : normalized;
    final baseName =
        fileName.contains('.') ? fileName.split('.').first : fileName;
    final direct = _matchLocale(baseName);
    if (direct != null) {
      return direct;
    }
    final namedDirect = _matchLanguageName(baseName);
    if (namedDirect != null) {
      return namedDirect;
    }
    final tokensMatch = _matchLocaleInTokens(baseName);
    if (tokensMatch != null) {
      return tokensMatch;
    }
    final namedTokens = _matchLanguageNameInTokens(baseName);
    if (namedTokens != null) {
      return namedTokens;
    }
    for (final segment in segments.reversed) {
      final segmentMatch = _matchLocale(segment);
      if (segmentMatch != null) {
        return segmentMatch;
      }
      final namedSegment = _matchLanguageName(segment);
      if (namedSegment != null) {
        return namedSegment;
      }
      final segmentTokens = _matchLocaleInTokens(segment);
      if (segmentTokens != null) {
        return segmentTokens;
      }
      final namedSegmentTokens = _matchLanguageNameInTokens(segment);
      if (namedSegmentTokens != null) {
        return namedSegmentTokens;
      }
    }
    return 'und';
  }

  String _effectiveSourceLanguage() {
    final override = _sourceLanguageOverride?.trim();
    if (override != null && override.isNotEmpty) {
      return override.toLowerCase();
    }
    return _sourceLanguageCode;
  }

  String _effectiveTargetLanguage() {
    final override = _targetLanguageOverride?.trim();
    if (override != null && override.isNotEmpty) {
      return override.toLowerCase();
    }
    return _targetLanguageCode;
  }

  String _languageDisplayName(String code) {
    if (code == 'und') {
      return 'Unknown';
    }
    final match = _languageNameMap.entries.firstWhere(
      (entry) => entry.value == code,
      orElse: () => const MapEntry('Unknown', 'und'),
    );
    if (match.value == code && match.key != 'Unknown') {
      final name = match.key;
      return '${name[0].toUpperCase()}${name.substring(1)} ($code)';
    }
    return code;
  }

  bool _isListFormat(Map<String, String> data) {
    if (data.isEmpty) {
      return false;
    }
    var matches = 0;
    for (final entry in data.entries) {
      if (entry.key.trim() == entry.value.trim()) {
        matches++;
      }
    }
    return matches / data.length >= 0.85;
  }

  bool _showListFormatWarning(AppSettings settings) {
    if (settings.comparisonMode != 'Key-based') {
      return false;
    }
    final sourceList = _isListFormat(widget.comparisonResult.file1Data);
    final targetList = _isListFormat(widget.comparisonResult.file2Data);
    return sourceList || targetList;
  }

  Future<void> _maybePromptLanguageOverride() async {
    if (_languagePromptShown || !mounted) {
      return;
    }
    if (_sourceLanguageCode != 'und' && _targetLanguageCode != 'und') {
      return;
    }
    _languagePromptShown = true;
    await _showLanguageOverrideDialog();
  }

  Future<void> _showLanguageOverrideDialog() async {
    final sourceController = TextEditingController(
      text: _sourceLanguageCode == 'und' ? '' : _sourceLanguageCode,
    );
    final targetController = TextEditingController(
      text: _targetLanguageCode == 'und' ? '' : _targetLanguageCode,
    );
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose languages for matching'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'If the file names are unclear, add a short language tag '
                'like en or tr. Leave blank to keep auto.',
              ),
              const SizedBox(height: 12),
              TextField(
                controller: sourceController,
                decoration: const InputDecoration(
                  labelText: 'Source language',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: targetController,
                decoration: const InputDecoration(
                  labelText: 'Target language',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result != true || !mounted) {
      sourceController.dispose();
      targetController.dispose();
      return;
    }

    setState(() {
      final sourceOverride = sourceController.text.trim();
      final targetOverride = targetController.text.trim();
      _sourceLanguageOverride = sourceOverride.isEmpty ? null : sourceOverride;
      _targetLanguageOverride = targetOverride.isEmpty ? null : targetOverride;
      _fuzzyMatchCache.clear();
      _fuzzyMatchLoading.clear();
    });
    sourceController.dispose();
    targetController.dispose();
  }

  String? _matchLanguageName(String value) {
    final normalized = value.replaceAll(RegExp(r'[^a-z]'), '');
    if (normalized.isEmpty) {
      return null;
    }
    return _languageNameMap[normalized];
  }

  String? _matchLanguageNameInTokens(String value) {
    final tokens = value
        .split(RegExp(r'[^a-z]+'))
        .where((token) => token.isNotEmpty)
        .toList();
    for (final token in tokens) {
      final match = _languageNameMap[token];
      if (match != null) {
        return match;
      }
    }
    return null;
  }

  String? _matchLocale(String value) {
    final match = RegExp(r'^([a-z]{2})(?:[-_]?([a-z]{2}))?$').firstMatch(value);
    if (match == null) {
      return null;
    }
    final language = match.group(1);
    final region = match.group(2);
    if (language == null || language.isEmpty) {
      return null;
    }
    if (region == null || region.isEmpty) {
      return language;
    }
    return '$language-$region';
  }

  String? _matchLocaleInTokens(String value) {
    final tokens = value
        .split(RegExp(r'[^a-z]+'))
        .where((token) => token.isNotEmpty)
        .toList();
    for (var index = 0; index < tokens.length; index++) {
      final token = tokens[index];
      if (token.length != 2) {
        continue;
      }
      if (index + 1 < tokens.length && tokens[index + 1].length == 2) {
        return '${tokens[index]}-${tokens[index + 1]}';
      }
      return token;
    }
    return null;
  }

  Future<void> _exportResult(BuildContext context) async {
    final settings = context.read<SettingsBloc>().state.appSettings;
    final format = settings.defaultExportFormat;

    if (format == 'Excel') {
      await _exportToExcel(context);
    } else if (format == 'JSON') {
      await _exportToJson(context);
    } else {
      await _exportToCsv(context);
    }
  }

  Future<void> _exportToExcel(BuildContext context) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Header
    sheetObject.appendRow([
      TextCellValue('Status'),
      TextCellValue('String Key'),
      TextCellValue('Old Value (Source)'),
      TextCellValue('New Value (Target)'),
      TextCellValue('Similarity')
    ]);

    for (var entry in _processedDiffEntries) {
      final key = entry.key;
      final status = entry.value.status;
      final similarity = entry.value.similarity;
      final file1Value = widget.comparisonResult.file1Data[key] ?? '';
      final file2Value = widget.comparisonResult.file2Data[key] ?? '';

      String statusText = status == StringComparisonStatus.added
          ? 'EXTRA'
          : status == StringComparisonStatus.removed
              ? 'MISSING'
              : 'CHANGED';
      String simText =
          similarity != null ? '${(similarity * 100).toStringAsFixed(1)}%' : '';

      sheetObject.appendRow([
        TextCellValue(statusText),
        TextCellValue(key),
        TextCellValue(status == StringComparisonStatus.added ? '' : file1Value),
        TextCellValue(
            status == StringComparisonStatus.removed ? '' : file2Value),
        TextCellValue(simText)
      ]);
    }

    // Save
    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Excel Report',
      fileName: 'comparison_report.xlsx',
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (outputPath != null) {
      try {
        final settings = context.read<SettingsBloc>().state.appSettings;
        await BackupService().createBackupIfNeeded(
          targetPath: outputPath,
          settings: settings,
        );
        var fileBytes = excel.save();
        if (fileBytes != null) {
          File(outputPath)
            ..createSync(recursive: true)
            ..writeAsBytesSync(fileBytes);

          if (context.mounted) {
            if (settings.openFolderAfterExport) {
              // Attempt to open folder
              final folder = File(outputPath).parent.path;
              // Open folder logic would go here, for now just notify
              // On Windows we can try 'explorer.exe'
              if (Platform.isWindows) {
                Process.run('explorer.exe', [folder]);
              }
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Excel saved to: $outputPath'),
                  behavior: SnackBarBehavior.floating),
            );
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to save Excel: $e'),
                backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  Future<void> _exportToJson(BuildContext context) async {
    List<Map<String, dynamic>> jsonData = [];
    for (var entry in _processedDiffEntries) {
      final key = entry.key;
      final status = entry.value.status;
      final similarity = entry.value.similarity;
      final file1Value = widget.comparisonResult.file1Data[key] ?? '';
      final file2Value = widget.comparisonResult.file2Data[key] ?? '';

      jsonData.add({
        'status': status == StringComparisonStatus.added
            ? 'extra'
            : status == StringComparisonStatus.removed
                ? 'missing'
                : status.name,
        'key': key,
        'old_value': status == StringComparisonStatus.added ? null : file1Value,
        'new_value':
            status == StringComparisonStatus.removed ? null : file2Value,
        'similarity': similarity
      });
    }

    String jsonString = const JsonEncoder.withIndent('  ').convert(jsonData);

    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save JSON Report',
      fileName: 'comparison_report.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (outputPath != null) {
      try {
        final settings = context.read<SettingsBloc>().state.appSettings;
        await BackupService().createBackupIfNeeded(
          targetPath: outputPath,
          settings: settings,
        );
        await File(outputPath).writeAsString(jsonString);
        if (context.mounted) {
          if (settings.openFolderAfterExport && Platform.isWindows) {
            Process.run('explorer.exe', [File(outputPath).parent.path]);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('JSON saved to: $outputPath'),
                behavior: SnackBarBehavior.floating),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to save JSON: $e'),
                backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  Future<void> _exportToCsv(BuildContext context) async {
    List<List<dynamic>> csvData = [
      [
        'Status',
        'String Key',
        'Old Value (Source)',
        'New Value (Target)',
        'Similarity'
      ]
    ];
    for (var entry in _processedDiffEntries) {
      final key = entry.key;
      final status = entry.value.status;
      final similarity = entry.value.similarity;
      final file1Value = widget.comparisonResult.file1Data[key] ?? '';
      final file2Value = widget.comparisonResult.file2Data[key] ?? '';

      String statusText = status == StringComparisonStatus.added
          ? 'EXTRA'
          : status == StringComparisonStatus.removed
              ? 'MISSING'
              : 'CHANGED';
      String simText =
          similarity != null ? '${(similarity * 100).toStringAsFixed(1)}%' : '';

      csvData.add([
        statusText,
        key,
        status == StringComparisonStatus.added ? '' : file1Value,
        status == StringComparisonStatus.removed ? '' : file2Value,
        simText
      ]);
    }

    String csvString = const ListToCsvConverter().convert(csvData);

    final settings = context.read<SettingsBloc>().state.appSettings;
    if (settings.includeUtf8Bom) {
      csvString = '\uFEFF$csvString';
    }

    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save CSV Report',
      fileName: 'comparison_report.csv',
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (outputPath != null) {
      try {
        await BackupService().createBackupIfNeeded(
          targetPath: outputPath,
          settings: settings,
        );
        await File(outputPath).writeAsString(csvString);
        if (context.mounted) {
          if (settings.openFolderAfterExport && Platform.isWindows) {
            Process.run('explorer.exe', [File(outputPath).parent.path]);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('CSV saved to: $outputPath'),
                behavior: SnackBarBehavior.floating),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to save CSV: $e'),
                backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        final theme = Theme.of(context);
        final isDarkMode = theme.brightness == Brightness.dark;
        final isAmoled = isDarkMode &&
            settingsState.status == SettingsStatus.loaded &&
            settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';
        if (settingsState.status == SettingsStatus.loaded) {
          _syncFuzzyMinScore(settingsState.appSettings);
        }

        // Use modern palette for dark mode, fallback for light
        final bgColor = isDarkMode
            ? (isAmoled ? Colors.black : _bgPrimary)
            : Colors.grey[100]!;
        final headerBg = isDarkMode
            ? (isAmoled ? const Color(0xFF111111) : _bgHeader)
            : Colors.grey[200]!;
        final rowAltBg = isDarkMode
            ? (isAmoled ? const Color(0xFF0A0A0A) : _bgSecondary)
            : Colors.white;
        final textColor = isDarkMode ? _textPrimary : Colors.black87;
        final subtleText = isDarkMode ? _textSecondary : Colors.grey[600]!;
        final borderCol = isDarkMode
            ? (isAmoled ? Colors.grey[900]! : _borderColor)
            : Colors.grey[300]!;

        final themeState = context.watch<ThemeBloc>().state;
        final stats = _stats;

        return Scaffold(
          backgroundColor: bgColor,
          body: Column(
            children: [
              // Compact Toolbar
              _buildToolbar(context, isDarkMode, isAmoled, headerBg, textColor,
                  subtleText, borderCol, stats, themeState),

              // Filter Bar removed (merged into toolbar)

              // Fuzzy Fill Panel
              _buildFuzzyFillPanel(
                context,
                isDarkMode,
                textColor,
                borderCol,
                subtleText,
              ),

              if (settingsState.status == SettingsStatus.loaded &&
                  _showListFormatWarning(settingsState.appSettings))
                _buildListFormatWarning(
                  isDarkMode,
                  textColor,
                  borderCol,
                  subtleText,
                ),

              // Divider
              Container(height: 1, color: borderCol),

              // Table
              Expanded(
                child: _buildTable(context, isDarkMode, isAmoled, headerBg,
                    rowAltBg, textColor, subtleText, borderCol, themeState),
              ),

              // Footer with pagination
              _buildFooter(context, isDarkMode, isAmoled, headerBg, textColor,
                  subtleText, borderCol),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToolbar(
      BuildContext ctx,
      bool isDark,
      bool isAmoled,
      Color headerBg,
      Color textColor,
      Color subtleText,
      Color borderCol,
      Map<String, int> stats,
      AppThemeState themeState) {
    
    // Helper to handle filter toggling (logic moved from old _buildFilterBar)
    void toggleFilter(AdvancedDiffFilter filter) {
      setState(() {
        if (filter == AdvancedDiffFilter.all) {
          _selectedFilters.clear();
          _selectedFilters.add(AdvancedDiffFilter.all);
        } else {
          _selectedFilters.remove(AdvancedDiffFilter.all);
          if (_selectedFilters.contains(filter)) {
            _selectedFilters.remove(filter);
          } else {
            _selectedFilters.add(filter);
          }

          // If nothing selected, revert to All
          if (_selectedFilters.isEmpty) {
            _selectedFilters.add(AdvancedDiffFilter.all);
          }
        }
        _processDiffEntries();
      });
    }

    // Helper to get selection state
    bool isFilterSelected(AdvancedDiffFilter filter) {
       return _selectedFilters.contains(filter);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: headerBg,
        border: Border(bottom: BorderSide(color: borderCol, width: 1)),
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            icon: Icon(Icons.arrow_back, color: textColor, size: 20),
            onPressed: () => Navigator.of(ctx).pop(),
            tooltip: 'Back',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          const SizedBox(width: 8),

          // Title
          Text('Diff View',
              style: TextStyle(
                  color: textColor, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(width: 16),

          // Stats badges (Clickable Filters)
          
          // Total -> All
          _buildStatBadge(
            '${stats['total']}', 
            'total', 
            subtleText, 
            isDark, 
            isFilterSelected(AdvancedDiffFilter.all),
            () => toggleFilter(AdvancedDiffFilter.all)
          ),
          const SizedBox(width: 8),
          
          // Extra -> Added
          _buildStatBadge(
            '${stats['added']}', 
            'extra', 
            themeState.diffAddedColor, 
            isDark,
            isFilterSelected(AdvancedDiffFilter.added),
             () => toggleFilter(AdvancedDiffFilter.added)
          ),
          const SizedBox(width: 8),
          
          // Missing -> Removed
          _buildStatBadge(
            '${stats['removed']}', 
            'missing',
            themeState.diffRemovedColor, 
            isDark,
            isFilterSelected(AdvancedDiffFilter.removed),
            () => toggleFilter(AdvancedDiffFilter.removed)
          ),
          const SizedBox(width: 8),
          
          // Changed -> Modified
          _buildStatBadge(
            '${stats['modified']}', 
            'changed',
            themeState.diffModifiedColor, 
            isDark,
            isFilterSelected(AdvancedDiffFilter.modified),
            () => toggleFilter(AdvancedDiffFilter.modified)
          ),
         
          const SizedBox(width: 16),
          Container(width: 1, height: 20, color: borderCol),
          const SizedBox(width: 16),

          // Similarity Dropdown (Moved from Filter Bar)
          Text(
            'Similarity: ',
            style: TextStyle(color: subtleText, fontSize: 13),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<AdvancedDiffSimilarityFilter>(
              value: _similarityFilter,
              dropdownColor: isDark ? const Color(0xFF1E242C) : Colors.white,
              style: TextStyle(color: textColor, fontSize: 13),
              icon: Icon(Icons.arrow_drop_down, color: subtleText),
              items: const [
                AdvancedDiffSimilarityFilter.any,
                AdvancedDiffSimilarityFilter.high,
                AdvancedDiffSimilarityFilter.medium,
                AdvancedDiffSimilarityFilter.low,
              ].map((filter) {
                String label = 'Any';
                switch (filter) {
                  case AdvancedDiffSimilarityFilter.high:
                    label = 'High (≥70%)';
                    break;
                  case AdvancedDiffSimilarityFilter.medium:
                    label = 'Medium (40-70%)';
                    break;
                  case AdvancedDiffSimilarityFilter.low:
                    label = 'Low (<40%)';
                    break;
                  case AdvancedDiffSimilarityFilter.any:
                    label = 'Any';
                    break;
                }
                return DropdownMenuItem(
                  value: filter,
                  child: Text(label),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _similarityFilter = value;
                  _processDiffEntries();
                });
              },
            ),
          ),

          const Spacer(),

          // Search field
          SizedBox(
            width: 200,
            height: 32,
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: textColor, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Search keys...',
                hintStyle: TextStyle(color: subtleText, fontSize: 13),
                prefixIcon: Icon(Icons.search, color: subtleText, size: 18),
                filled: true,
                fillColor: isDark ? Colors.black26 : Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: borderCol),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: borderCol),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                      color: Theme.of(ctx).colorScheme.primary, width: 1.5),
                ),
              ),
              onChanged: (value) {
                _searchQuery = value;
                _processDiffEntries();
              },
            ),
          ),
          const SizedBox(width: 12),

          // Sort toggle
          _buildSortButton(isDark, textColor, subtleText, borderCol),
          const SizedBox(width: 8),

          // Export button
          IconButton(
            icon: Icon(Icons.download_outlined, color: textColor, size: 20),
            onPressed: () => _exportResult(ctx),
            tooltip: 'Export Result',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge(
    String count, 
    String label, 
    Color color, 
    bool isDark, 
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          // Visual indication of selection: darker bg (or inverted in light mode?) 
          // or just opacity change. Let's make it fully opaque if selected.
          color: isSelected 
             ? color.withValues(alpha: isDark ? 0.25 : 0.2)
             : color.withValues(alpha: 0.05), // Faint when not selected
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected 
              ? color.withValues(alpha: 0.8) 
              : color.withValues(alpha: 0.1), // Very faint border when not selected
              width: 1
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(count,
                style: TextStyle(
                    color: color, 
                    fontSize: 12, 
                    fontWeight: FontWeight.w600)),
            const SizedBox(width: 4),
            Text(label,
                style:
                    TextStyle(
                      color: isSelected ? color : color.withValues(alpha: 0.7), 
                      fontSize: 11
                    )),
          ],
        ),
      ),
    );
  }


  Widget _buildFuzzyFillPanel(
    BuildContext context,
    bool isDark,
    Color textColor,
    Color borderCol,
    Color subtleText,
  ) {
    final settingsState = context.watch<SettingsBloc>().state;
    if (settingsState.status != SettingsStatus.loaded) {
      return const SizedBox.shrink();
    }
    final settings = settingsState.appSettings;
    final controlsEnabled = settings.enableFuzzyFill;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B22) : Colors.white,
        border: Border(bottom: BorderSide(color: borderCol)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Title + Enable Switch + Auto-apply toggle
          Row(
            children: [
              Icon(Icons.memory_rounded, color: subtleText, size: 20),
              const SizedBox(width: 8),
              Text(
                'Translation memory fill',
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 16),
              Switch(
                value: settings.enableFuzzyFill,
                onChanged: (value) {
                  context.read<SettingsBloc>().add(
                        UpdateEnableFuzzyFill(value),
                      );
                  _clearFuzzyMatchCache();
                },
              ),
              if (controlsEnabled) ...[
                const SizedBox(width: 24),
                _buildFuzzyToggle(
                  label: 'Auto-apply above minimum',
                  value: settings.fuzzyFillAutoApply,
                  enabled: controlsEnabled,
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                          UpdateFuzzyFillAutoApply(value),
                        );
                  },
                ),
              ],
            ],
          ),

          if (controlsEnabled) ...[
            const SizedBox(height: 16),
            
            // Section 1: Match Settings
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    'Match Settings',
                    style: TextStyle(
                      color: subtleText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Wrap(
                    spacing: 24,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // Slider
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Min match: ${_formatScore(_fuzzyMinScoreDraft)}',
                            style: TextStyle(color: subtleText, fontSize: 12),
                          ),
                          SizedBox(
                            width: 150,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 2,
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 6),
                                overlayShape: const RoundSliderOverlayShape(
                                    overlayRadius: 14),
                              ),
                              child: Slider(
                                value: _fuzzyMinScoreDraft.clamp(0.6, 1.0),
                                min: 0.6,
                                max: 1.0,
                                divisions: 40,
                                onChanged: !settings.fuzzyFillExactMatchesOnly
                                    ? (value) {
                                        setState(() {
                                          _fuzzyMinScoreDraft = value;
                                          _fuzzyMinScoreDirty = true;
                                        });
                                      }
                                    : null,
                                onChangeEnd: !settings.fuzzyFillExactMatchesOnly
                                    ? (value) {
                                        _fuzzyMinScoreDirty = false;
                                        context.read<SettingsBloc>().add(
                                              UpdateFuzzyFillMinScore(value),
                                            );
                                        _clearFuzzyMatchCache();
                                      }
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Match Limit
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Limit:',
                            style: TextStyle(color: subtleText, fontSize: 12),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            height: 24,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: settings.fuzzyFillMatchLimit,
                                dropdownColor:
                                    isDark ? _bgSecondary : Colors.white,
                                style:
                                    TextStyle(color: textColor, fontSize: 12),
                                items: const [1, 3, 5, 10]
                                    .map(
                                      (value) => DropdownMenuItem(
                                        value: value,
                                        child: Text('$value'),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value == null) return;
                                  context.read<SettingsBloc>().add(
                                        UpdateFuzzyFillMatchLimit(value),
                                      );
                                  _clearFuzzyMatchCache();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Exact Matches Only
                      _buildFuzzyToggle(
                        label: 'Exact matches only',
                        value: settings.fuzzyFillExactMatchesOnly,
                        enabled: true,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                UpdateFuzzyFillExactMatchesOnly(value),
                              );
                          _clearFuzzyMatchCache();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            Divider(color: borderCol.withValues(alpha: 0.4), height: 1),
            const SizedBox(height: 12),

            // Section 2: Filter Options
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Filters',
                      style: TextStyle(
                        color: subtleText,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Wrap(
                    spacing: 24,
                    runSpacing: 12,
                    children: [
                      _buildFuzzyToggle(
                        label: 'Apply to Added',
                        value: _applyToAdded,
                        enabled: true,
                        onChanged: (value) {
                          setState(() => _applyToAdded = value);
                          _clearFuzzyMatchCache();
                        },
                      ),
                      _buildFuzzyToggle(
                        label: 'Apply to Modified',
                        value: _applyToModified,
                        enabled: true,
                        onChanged: (value) {
                          setState(() => _applyToModified = value);
                          _clearFuzzyMatchCache();
                        },
                      ),
                      _buildFuzzyToggle(
                        label: 'Only fill empty targets',
                        value: settings.fuzzyFillOnlyEmptyTargets,
                        enabled: true,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                UpdateFuzzyFillOnlyEmptyTargets(value),
                              );
                          _clearFuzzyMatchCache();
                        },
                      ),
                      _buildFuzzyToggle(
                        label: 'Limit to visible',
                        value: _limitToVisibleEntries,
                        enabled: true,
                        onChanged: (value) {
                          setState(() => _limitToVisibleEntries = value);
                        },
                      ),
                      _buildFuzzyToggle(
                        label: 'Selected only',
                        value: _useSelectionOnly,
                        enabled: true,
                        onChanged: (value) {
                          setState(() => _useSelectionOnly = value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Divider(color: borderCol.withValues(alpha: 0.4), height: 1),
            const SizedBox(height: 12),

            // Section 3: Actions
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    'Actions',
                    style: TextStyle(
                      color: subtleText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                // Language Display
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black12 : Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: borderCol),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${_languageDisplayName(_effectiveSourceLanguage())} → ${_languageDisplayName(_effectiveTargetLanguage())}',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: _showLanguageOverrideDialog,
                        borderRadius: BorderRadius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(Icons.edit,
                              size: 14, color: subtleText),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),

                // Action Buttons
                TextButton.icon(
                  onPressed: !_exportingFuzzyReport
                      ? _exportFuzzyMatchReport
                      : null,
                  icon: const Icon(Icons.download_outlined, size: 16),
                  label: const Text('Export matches'),
                  style: TextButton.styleFrom(
                    foregroundColor: textColor,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: !_runningFuzzyFill
                      ? () {
                          if (_showFuzzyPreviews) {
                            setState(() => _showFuzzyPreviews = false);
                          } else {
                            _runFuzzyFill(previewOnly: true);
                          }
                        }
                      : null,
                  icon: Icon(
                      _showFuzzyPreviews
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: 16),
                  label: Text(
                    _showFuzzyPreviews ? 'Hide Previews' : 'Preview',
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: !_runningFuzzyFill
                      ? () => _runFuzzyFill(previewOnly: false)
                      : null,
                  icon: const Icon(Icons.auto_fix_high, size: 16),
                  label: Text(
                    settings.fuzzyFillAutoApply
                        ? 'Fill from Memory'
                        : 'Find Matches',
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildListFormatWarning(
    bool isDark,
    Color textColor,
    Color borderCol,
    Color subtleText,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E242C) : Colors.orange[50],
        border: Border(bottom: BorderSide(color: borderCol)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: subtleText, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'One of these files looks like a simple list without labels. '
              'That means missing rows will stay red and new text will show up '
              'as extra rows. For best results, use labeled pairs in both '
              'files or switch to line order matching in settings.',
              style: TextStyle(color: textColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFuzzyToggle({
    required String label,
    required bool value,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    return InkWell(
      onTap: enabled ? () => onChanged(!value) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: enabled ? (next) => onChanged(next ?? false) : null,
            visualDensity: VisualDensity.compact,
          ),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSortButton(
      bool isDark, Color textColor, Color subtleText, Color borderCol) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentSortOrder =
              _currentSortOrder == DiffViewSortOrder.alphabetical
                  ? DiffViewSortOrder.fileOrder
                  : DiffViewSortOrder.alphabetical;
        });
        _processDiffEntries();
      },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isDark ? Colors.black26 : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: borderCol),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _currentSortOrder == DiffViewSortOrder.alphabetical
                  ? Icons.sort_by_alpha
                  : Icons.format_list_numbered,
              color: subtleText,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              _currentSortOrder == DiffViewSortOrder.alphabetical
                  ? 'A-Z'
                  : 'File',
              style: TextStyle(color: textColor, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTable(
      BuildContext ctx,
      bool isDark,
      bool isAmoled,
      Color headerBg,
      Color rowAltBg,
      Color textColor,
      Color subtleText,
      Color borderCol,
      AppThemeState themeState) {
    if (_processedDiffEntries.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, color: subtleText, size: 48),
            const SizedBox(height: 12),
            Text('No results match your filters',
                style: TextStyle(color: subtleText, fontSize: 14)),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final availableWidth = totalWidth -
            _actionColumnWidth -
            _selectionColumnWidth -
            _rowNumberColumnWidth;
        final layoutWidth = availableWidth > 1.0 ? availableWidth : 1.0;
        final statusW = layoutWidth * _statusWidth;
        final keyW = layoutWidth * _keyWidth;
        final oldValW = layoutWidth * _oldValueWidth;
        final newValW = layoutWidth * _newValueWidth;
        final canSaveAll = !_savingAllEdits;
        final canAddAll = !_addingAllToMemory;

        return Column(
          children: [
            // Header row with resizable dividers
            _buildHeaderRow(
              statusW,
              keyW,
              oldValW,
              newValW,
              headerBg,
              textColor,
              borderCol,
              layoutWidth,
              _actionColumnWidth,
              canSaveAll,
              canAddAll,
            ),

            // Data rows
            Expanded(
              child: ListView.builder(
                itemCount: _paginatedEntries.length,
                itemBuilder: (context, index) {
                  final entry = _paginatedEntries[index];
                  final globalIndex = _currentPage * _itemsPerPage + index;
                  final isAlt = index % 2 == 1;

                  return _buildDataRow(
                    entry,
                    globalIndex,
                    isAlt,
                    statusW,
                    keyW,
                    oldValW,
                    newValW,
                    _actionColumnWidth,
                    isDark,
                    isAmoled,
                    rowAltBg,
                    textColor,
                    subtleText,
                    borderCol,
                    themeState,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeaderRow(
      double statusW,
      double keyW,
      double oldValW,
      double newValW,
      Color headerBg,
      Color textColor,
      Color borderCol,
      double availableWidth,
      double actionW,
      bool canSaveAll,
      bool canAddAll) {
    final hasEntries = _processedDiffEntries.isNotEmpty;
    final allSelected = hasEntries &&
        _processedDiffEntries.every(
          (entry) => _selectedRowKeys.contains(entry.key),
        );
    final someSelected = _selectedRowKeys.isNotEmpty && !allSelected;
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: headerBg,
        border: Border(bottom: BorderSide(color: borderCol)),
      ),
      child: Row(
        children: [
          // Selection header
          SizedBox(
            width: _selectionColumnWidth,
            child: Checkbox(
              value: allSelected ? true : (someSelected ? null : false),
              tristate: true,
              onChanged: hasEntries
                  ? (value) {
                      setState(() {
                        if (value == true) {
                          _selectedRowKeys.addAll(
                            _processedDiffEntries.map((entry) => entry.key),
                          );
                        } else {
                          _selectedRowKeys.clear();
                        }
                      });
                    }
                  : null,
              visualDensity: VisualDensity.compact,
            ),
          ),
          Container(width: 1, height: 36, color: borderCol),

          // Row number header (fixed 40px)
          Container(
            width: _rowNumberColumnWidth,
            alignment: Alignment.center,
            child: Text('#',
                style: TextStyle(
                    color: textColor.withValues(alpha: 0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
          _buildResizableDivider(0, borderCol, availableWidth),

          // Status
          SizedBox(
            width: statusW - 6,
            child: Text('Status',
                style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
          _buildResizableDivider(1, borderCol, availableWidth),

          // Key
          SizedBox(
            width: keyW - 6,
            child: Text('String Key',
                style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
          _buildResizableDivider(2, borderCol, availableWidth),

          // Old Value
          SizedBox(
            width: oldValW - 6,
            child: Text('Old Value (Source)',
                style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
          _buildResizableDivider(3, borderCol, availableWidth),

          // New Value
          Expanded(
            child: Text('New Value (Target)',
                style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
          Container(width: 1, height: 36, color: borderCol),
          SizedBox(
            width: actionW,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.memory_rounded,
                    color: canAddAll
                        ? textColor.withValues(alpha: 0.8)
                        : borderCol,
                    size: 16,
                  ),
                  tooltip: 'Add all to memory',
                  onPressed: canAddAll ? _addAllToTranslationMemory : null,
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(minWidth: 28, minHeight: 28),
                ),
                IconButton(
                  icon: Icon(
                    Icons.save_rounded,
                    color: canSaveAll
                        ? textColor.withValues(alpha: 0.8)
                        : borderCol,
                    size: 16,
                  ),
                  tooltip: 'Save all edits',
                  onPressed: canSaveAll ? _saveAllEdits : null,
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(minWidth: 28, minHeight: 28),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResizableDivider(int index, Color borderCol, double totalWidth) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            final delta = details.delta.dx / totalWidth;
            _resizeColumn(index, delta);
          });
        },
        child: Container(
          width: 6,
          height: 36,
          color: Colors.transparent,
          child: Center(
            child: Container(width: 1, height: 20, color: borderCol),
          ),
        ),
      ),
    );
  }

  void _resizeColumn(int index, double delta) {
    // Redistribute space between adjacent columns
    switch (index) {
      case 0: // Between row# and status - move status
        break;
      case 1: // Between status and key
        if (_statusWidth + delta >= _minColWidth &&
            _keyWidth - delta >= _minColWidth) {
          _statusWidth += delta;
          _keyWidth -= delta;
        }
        break;
      case 2: // Between key and old value
        if (_keyWidth + delta >= _minColWidth &&
            _oldValueWidth - delta >= _minColWidth) {
          _keyWidth += delta;
          _oldValueWidth -= delta;
        }
        break;
      case 3: // Between old and new value
        if (_oldValueWidth + delta >= _minColWidth &&
            _newValueWidth - delta >= _minColWidth) {
          _oldValueWidth += delta;
          _newValueWidth -= delta;
        }
        break;
    }
  }

  Widget _buildDataRow(
      MapEntry<String, ComparisonStatusDetail> entry,
      int globalIndex,
      bool isAlt,
      double statusW,
      double keyW,
      double oldValW,
      double newValW,
      double actionW,
      bool isDark,
      bool isAmoled,
      Color rowAltBg,
      Color textColor,
      Color subtleText,
      Color borderCol,
      AppThemeState themeState) {
    // Get font settings
    final settingsState = context.watch<SettingsBloc>().state;
    String fontFamily = 'Consolas, Monaco, monospace';
    double fontSize = 12.0;
    if (settingsState.status == SettingsStatus.loaded) {
      try {
        final ff = settingsState.appSettings.diffFontFamily;
        if (ff.isNotEmpty && ff != 'System Default') fontFamily = ff;
        fontSize = settingsState.appSettings.diffFontSize;
      } catch (_) {}
    }

    final key = entry.key;
    final status = entry.value.status;
    final similarity = entry.value.similarity;
    final file1Value = widget.comparisonResult.file1Data[key];
    final file2Value = widget.comparisonResult.file2Data[key];
    final sourceText = file1Value?.trim() ?? '';
    final targetText = file2Value?.trim() ?? '';
    final canAddToMemory = status == StringComparisonStatus.modified &&
        sourceText.isNotEmpty &&
        targetText.isNotEmpty;
    final settingsLoaded = settingsState.status == SettingsStatus.loaded;
    final settings = settingsLoaded ? settingsState.appSettings : null;
    final canUseFuzzy = settings != null && settings.enableFuzzyFill;
    final rules = settings != null ? _fuzzyFillRules(settings) : null;
    final matches = _fuzzyMatchCache[key];
    final bestMatch =
        matches != null && matches.isNotEmpty ? matches.first : null;
    final canShowSuggestion = canUseFuzzy &&
        bestMatch != null &&
        rules != null &&
        rules.canApply(
          status: status,
          currentTarget: targetText,
          score: bestMatch.score,
        ) &&
        targetText.trim() != bestMatch.targetText.trim();
    final showNoMatchInfo = _showFuzzyPreviews &&
        canUseFuzzy &&
        bestMatch == null &&
        !_fuzzyMatchLoading.contains(key);

    // Status styling
    Color statusColor;
    String statusText;
    switch (status) {
      case StringComparisonStatus.added:
        statusColor = themeState.diffAddedColor;
        statusText = 'EXTRA';
        break;
      case StringComparisonStatus.removed:
        statusColor = themeState.diffRemovedColor;
        statusText = 'MISSING';
        break;
      case StringComparisonStatus.modified:
        statusColor = themeState.diffModifiedColor;
        statusText =
            similarity != null ? 'CHG ${(similarity * 100).toInt()}%' : 'CHG';
        break;
      default:
        statusColor = subtleText;
        statusText = '---';
    }

    // Row background with subtle status tint
    final rowBg = isAlt
        ? rowAltBg
        : (isDark ? (isAmoled ? Colors.black : _bgPrimary) : Colors.white);
    final tintedBg = Color.lerp(rowBg, statusColor, 0.03)!;

    // Build value widgets
    Widget oldValueWidget;
    Widget newValueWidget;

    final baseStyle = TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontFamily: fontFamily,
    );

    if (status == StringComparisonStatus.modified) {
      oldValueWidget = DiffHighlighter.buildDiffText(
        file1Value ?? '',
        file2Value ?? '',
        isSource: true,
        baseStyle: baseStyle,
        maxLines: 2,
        deletionColor: themeState.diffRemovedColor,
      );
      newValueWidget = DiffHighlighter.buildDiffText(
        file1Value ?? '',
        file2Value ?? '',
        isSource: false,
        baseStyle: baseStyle,
        maxLines: 2,
        insertionColor: themeState.diffAddedColor,
      );
    } else if (status == StringComparisonStatus.added) {
      oldValueWidget = Text('—',
          style: TextStyle(
              color: subtleText, fontSize: fontSize, fontFamily: fontFamily));
      newValueWidget = Text(file2Value ?? '',
          style: baseStyle, maxLines: 2, overflow: TextOverflow.ellipsis);
    } else {
      oldValueWidget = Text(file1Value ?? '',
          style: baseStyle, maxLines: 2, overflow: TextOverflow.ellipsis);
      newValueWidget = Text('—',
          style: TextStyle(
              color: subtleText, fontSize: fontSize, fontFamily: fontFamily));
    }

    final canEditSource = settingsState.status == SettingsStatus.loaded &&
        _fileService.canEditFile(
          widget.sourceFile,
          forcedFormat: settingsState.appSettings.defaultSourceFormat,
        );
    final canEditTarget = settingsState.status == SettingsStatus.loaded &&
        _fileService.canEditFile(
          widget.targetFile,
          forcedFormat: settingsState.appSettings.defaultTargetFormat,
        );
    final canDeleteSource = canEditSource && file1Value != null;
    final canDeleteTarget = canEditTarget && file2Value != null;

    final oldValueCell = _buildEditableCell(
      entryKey: key,
      isSource: true,
      currentValue: file1Value,
      displayWidget: oldValueWidget,
      textStyle: baseStyle,
      subtleText: subtleText,
      canEdit: canEditSource,
    );
    final newValueCell = _buildEditableCell(
      entryKey: key,
      isSource: false,
      currentValue: file2Value,
      displayWidget: newValueWidget,
      textStyle: baseStyle,
      subtleText: subtleText,
      canEdit: canEditTarget,
    );

    final row = Container(
      height: 44,
      decoration: BoxDecoration(
        color: tintedBg,
        border:
            Border(bottom: BorderSide(color: borderCol.withValues(alpha: 0.5))),
      ),
      child: Row(
        children: [
          // Selection checkbox
          SizedBox(
            width: _selectionColumnWidth,
            child: Checkbox(
              value: _selectedRowKeys.contains(key),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _selectedRowKeys.add(key);
                  } else {
                    _selectedRowKeys.remove(key);
                  }
                });
              },
              visualDensity: VisualDensity.compact,
            ),
          ),
          Container(
              width: 1, height: 44, color: borderCol.withValues(alpha: 0.3)),

          // Row number
          Container(
            width: _rowNumberColumnWidth,
            alignment: Alignment.center,
            child: Text('${globalIndex + 1}',
                style: TextStyle(
                    color: subtleText,
                    fontSize: fontSize,
                    fontFamily: fontFamily)),
          ),
          Container(
              width: 1, height: 44, color: borderCol.withValues(alpha: 0.3)),

          // Status badge
          SizedBox(
            width: statusW - 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(statusText,
                    style: TextStyle(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          Container(
              width: 1, height: 44, color: borderCol.withValues(alpha: 0.3)),

          // Key
          SizedBox(
            width: keyW - 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(key,
                  style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontFamily: fontFamily),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          Container(
              width: 1, height: 44, color: borderCol.withValues(alpha: 0.3)),

          // Old Value
          SizedBox(
            width: oldValW - 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: oldValueCell,
            ),
          ),
          Container(
              width: 1, height: 44, color: borderCol.withValues(alpha: 0.3)),

          // New Value
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: newValueCell,
            ),
          ),
          Container(
              width: 1, height: 44, color: borderCol.withValues(alpha: 0.3)),
          SizedBox(
            width: actionW,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (canShowSuggestion && bestMatch != null)
                  _buildSuggestionChip(
                    match: bestMatch,
                    statusColor: statusColor,
                    onApply: () => _applyMatchForKey(key),
                  ),
                if (showNoMatchInfo)
                  Tooltip(
                    message: 'No match for the current languages.',
                    child: Icon(
                      Icons.info_outline,
                      color: subtleText,
                      size: 16,
                    ),
                  ),
                IconButton(
                  icon: Icon(
                    Icons.memory_rounded,
                    color: canAddToMemory ? subtleText : borderCol,
                    size: 18,
                  ),
                  tooltip: canAddToMemory
                      ? 'Add to memory'
                      : 'Needs both source and target',
                  onPressed: canAddToMemory
                      ? () => _addToTranslationMemory(
                            sourceText: sourceText,
                            targetText: targetText,
                          )
                      : null,
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(minWidth: 28, minHeight: 28),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: canDeleteSource || canDeleteTarget
                        ? subtleText
                        : borderCol,
                    size: 18,
                  ),
                  tooltip: canDeleteSource || canDeleteTarget
                      ? 'Delete'
                      : 'Delete not available',
                  onPressed: canDeleteSource || canDeleteTarget
                      ? () => _confirmDelete(key)
                      : null,
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(minWidth: 28, minHeight: 28),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    if (!_showFuzzyPreviews || bestMatch == null) {
      return row;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        row,
        _buildFuzzyPreviewRow(
          match: bestMatch,
          sourceText: sourceText,
          textColor: textColor,
          subtleText: subtleText,
          borderCol: borderCol,
          themeState: themeState,
          rowBg: rowBg,
        ),
      ],
    );
  }

  Widget _buildSuggestionChip({
    required TranslationMemoryMatch match,
    required Color statusColor,
    required VoidCallback onApply,
  }) {
    final preview = _translationMemoryService?.buildMatchPreview(
          match.sourceText,
        ) ??
        match.sourceText;
    return Tooltip(
      message: 'Match ${_formatScore(match.score)}\n$preview',
      child: InkWell(
        onTap: onApply,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: const EdgeInsets.only(right: 4),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: statusColor.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatScore(match.score),
                style: TextStyle(
                  color: statusColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 2),
              Icon(
                Icons.check,
                size: 12,
                color: statusColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFuzzyPreviewRow({
    required TranslationMemoryMatch match,
    required String sourceText,
    required Color textColor,
    required Color subtleText,
    required Color borderCol,
    required AppThemeState themeState,
    required Color rowBg,
  }) {
    final baseStyle = TextStyle(color: textColor, fontSize: 11);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color.lerp(rowBg, themeState.diffModifiedColor, 0.06),
        border: Border(
          bottom: BorderSide(color: borderCol.withValues(alpha: 0.5)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Match ${_formatScore(match.score)}',
            style: TextStyle(
              color: themeState.diffModifiedColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Source: ', style: TextStyle(color: subtleText)),
              Expanded(
                child: DiffHighlighter.buildDiffText(
                  sourceText,
                  match.sourceText,
                  isSource: false,
                  baseStyle: baseStyle,
                  maxLines: 2,
                  insertionColor: themeState.diffAddedColor,
                  deletionColor: themeState.diffRemovedColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Suggested: ', style: TextStyle(color: subtleText)),
              Expanded(
                child: Text(
                  match.targetText,
                  style: baseStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext ctx, bool isDark, bool isAmoled,
      Color headerBg, Color textColor, Color subtleText, Color borderCol) {
    final rangeStart = _currentPage * _itemsPerPage + 1;
    final rangeEnd = ((_currentPage + 1) * _itemsPerPage)
        .clamp(0, _processedDiffEntries.length);
    final totalEntries = _processedDiffEntries.length;
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: headerBg,
        border: Border(top: BorderSide(color: borderCol)),
      ),
      child: Row(
        children: [
          // Items per page
          Text('Show:', style: TextStyle(color: subtleText, fontSize: 12)),
          const SizedBox(width: 8),
          DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _itemsPerPage,
              dropdownColor: isDark ? _bgSecondary : Colors.white,
              style: TextStyle(color: textColor, fontSize: 12),
              items: _itemsPerPageOptions
                  .map((v) => DropdownMenuItem(value: v, child: Text('$v')))
                  .toList(),
              onChanged: (v) {
                if (v != null) _changeItemsPerPage(v);
              },
            ),
          ),

          const Spacer(),

          // Page info
          Text(
            '$rangeStart–$rangeEnd of $totalEntries',
            style: TextStyle(color: subtleText, fontSize: 12),
          ),
          const SizedBox(width: 16),

          // Page navigation
          IconButton(
            icon: Icon(Icons.first_page,
                color: _currentPage > 0 ? textColor : subtleText, size: 18),
            onPressed: _currentPage > 0 ? () => _goToPage(0) : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          IconButton(
            icon: Icon(Icons.chevron_left,
                color: _currentPage > 0 ? textColor : subtleText, size: 18),
            onPressed:
                _currentPage > 0 ? () => _goToPage(_currentPage - 1) : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text('${_currentPage + 1} / $_totalPages',
                style: TextStyle(color: textColor, fontSize: 12)),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right,
                color: _currentPage < _totalPages - 1 ? textColor : subtleText,
                size: 18),
            onPressed: _currentPage < _totalPages - 1
                ? () => _goToPage(_currentPage + 1)
                : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          IconButton(
            icon: Icon(Icons.last_page,
                color: _currentPage < _totalPages - 1 ? textColor : subtleText,
                size: 18),
            onPressed: _currentPage < _totalPages - 1
                ? () => _goToPage(_totalPages - 1)
                : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
        ],
      ),
    );
  }
}
