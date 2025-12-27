import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/core/services/diff_calculator.dart';
import '../../core/services/localization_file_service.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:csv/csv.dart';
import '../../business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import '../widgets/common/diff_highlighter.dart';
import 'package:localizer_app_main/core/services/backup_service.dart';
import 'package:excel/excel.dart' hide Border;
import 'dart:convert';

// Filter options
enum AdvancedDiffFilter {
  all,
  added,
  removed,
  modified,
  modifiedHighSimilarity,
  modifiedMediumSimilarity,
  modifiedLowSimilarity
}

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
  // Filter & Sort
  Set<AdvancedDiffFilter> _selectedFilters = {AdvancedDiffFilter.all};
  DiffViewSortOrder _currentSortOrder = DiffViewSortOrder.fileOrder;
  List<MapEntry<String, ComparisonStatusDetail>> _processedDiffEntries = [];
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final LocalizationFileService _fileService = LocalizationFileService();
  final Map<String, TextEditingController> _cellControllers = {};
  final Map<String, FocusNode> _cellFocusNodes = {};
  final Set<String> _editingCells = {};
  final Set<String> _savingCells = {};
  final Map<String, _EditContext> _editContexts = {};

  // Pagination
  int _currentPage = 0;
  int _itemsPerPage = 100;
  final List<int> _itemsPerPageOptions = [50, 100, 200, 500];

  // Resizable columns - relative widths (sum = 1.0)
  double _statusWidth = 0.10;
  double _keyWidth = 0.28;
  double _oldValueWidth = 0.31;
  double _newValueWidth = 0.31;
  static const double _actionColumnWidth = 44;

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
    _processDiffEntries();
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
      // Granular modified filters
      if (!matches && status == StringComparisonStatus.modified) {
        if (_selectedFilters
                .contains(AdvancedDiffFilter.modifiedHighSimilarity) &&
            similarity != null &&
            similarity >= _highSimilarityThreshold) {
          matches = true;
        }
        if (!matches &&
            _selectedFilters
                .contains(AdvancedDiffFilter.modifiedMediumSimilarity) &&
            similarity != null &&
            similarity >= _lowSimilarityThreshold &&
            similarity < _highSimilarityThreshold) {
          matches = true;
        }
        if (!matches &&
            _selectedFilters
                .contains(AdvancedDiffFilter.modifiedLowSimilarity) &&
            similarity != null &&
            similarity < _lowSimilarityThreshold) {
          matches = true;
        }
      }

      return matches;
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

    final totalPages =
        (filteredEntries.length / _itemsPerPage).ceil();
    final maxPage = totalPages > 0 ? totalPages - 1 : 0;
    final nextPage = resetPage ? 0 : _currentPage;

    setState(() {
      _processedDiffEntries = filteredEntries;
      _currentPage = nextPage.clamp(0, maxPage);
    });
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
    final forcedFormat = isSource
        ? settings.defaultSourceFormat
        : settings.defaultTargetFormat;
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
        relatedValue:
            isSource ? null : widget.comparisonResult.file1Data[key],
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
                onPressed: () =>
                    Navigator.of(context).pop(_DeleteTarget.both),
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
          ? 'ADDED'
          : status == StringComparisonStatus.removed
              ? 'REMOVED'
              : 'MODIFIED';
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
        'status': status.name,
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
          ? 'ADDED'
          : status == StringComparisonStatus.removed
              ? 'REMOVED'
              : 'MODIFIED';
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

              // Filter Bar
              _buildFilterBar(
                  isDarkMode, textColor, borderCol, subtleText, themeState),

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

          // Stats badges
          _buildStatBadge('${stats['total']}', 'total', subtleText, isDark),
          const SizedBox(width: 8),
          _buildStatBadge(
              '${stats['added']}', 'added', themeState.diffAddedColor, isDark),
          const SizedBox(width: 8),
          _buildStatBadge('${stats['removed']}', 'removed',
              themeState.diffRemovedColor, isDark),
          const SizedBox(width: 8),
          _buildStatBadge('${stats['modified']}', 'mod',
              themeState.diffModifiedColor, isDark),

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

  Widget _buildStatBadge(String count, String label, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(count,
              style: TextStyle(
                  color: color, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(width: 4),
          Text(label,
              style:
                  TextStyle(color: color.withValues(alpha: 0.8), fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildFilterBar(bool isDark, Color textColor, Color borderCol,
      Color subtleText, AppThemeState themeState) {
    final allFilters = [
      AdvancedDiffFilter.all,
      AdvancedDiffFilter.added,
      AdvancedDiffFilter.removed,
      AdvancedDiffFilter.modified,
    ];

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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B22) : Colors.white,
        border: Border(bottom: BorderSide(color: borderCol)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text('Filters:',
                style: TextStyle(
                    color: subtleText,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
            const SizedBox(width: 12),
            // Filter Chips
            ...allFilters.map((filter) {
              bool isSelected = _selectedFilters.contains(filter);
              String label = '';
              Color? chipColor;

              switch (filter) {
                case AdvancedDiffFilter.all:
                  label = 'All';
                  break;
                case AdvancedDiffFilter.added:
                  label = 'Added';
                  chipColor = themeState.diffAddedColor;
                  break;
                case AdvancedDiffFilter.removed:
                  label = 'Removed';
                  chipColor = themeState.diffRemovedColor;
                  break;
                case AdvancedDiffFilter.modified:
                  label = 'Modified';
                  chipColor = themeState.diffModifiedColor;
                  break;
                default:
                  label = '';
              }

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (_) => toggleFilter(filter),
                  backgroundColor: isDark ? Colors.black26 : Colors.grey[200],
                  selectedColor:
                      (chipColor ?? Colors.blue).withValues(alpha: 0.2),
                  checkmarkColor: chipColor ?? Colors.blue,
                  labelStyle: TextStyle(
                    color: isSelected ? (chipColor ?? Colors.blue) : textColor,
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  side: BorderSide(
                    color: isSelected ? (chipColor ?? Colors.blue) : borderCol,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  showCheckmark: false,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  visualDensity: VisualDensity.compact,
                ),
              );
            }),
            Container(
                height: 20,
                width: 1,
                color: borderCol,
                margin: const EdgeInsets.symmetric(horizontal: 4)),
            const SizedBox(width: 4),

            // Granular Modified options
            ...[
              AdvancedDiffFilter.modifiedHighSimilarity,
              AdvancedDiffFilter.modifiedMediumSimilarity,
              AdvancedDiffFilter.modifiedLowSimilarity
            ].map((filter) {
              bool isSelected = _selectedFilters.contains(filter);
              String label = '';
              switch (filter) {
                case AdvancedDiffFilter.modifiedHighSimilarity:
                  label = 'Mod. High (≥70%)';
                  break;
                case AdvancedDiffFilter.modifiedMediumSimilarity:
                  label = 'Mod. Med (40-70%)';
                  break;
                case AdvancedDiffFilter.modifiedLowSimilarity:
                  label = 'Mod. Low (<40%)';
                  break;
                default:
                  break;
              }

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (_) => toggleFilter(filter),
                  backgroundColor: isDark ? Colors.black26 : Colors.grey[200],
                  selectedColor:
                      themeState.diffModifiedColor.withValues(alpha: 0.2),
                  labelStyle: TextStyle(
                    color:
                        isSelected ? themeState.diffModifiedColor : textColor,
                    fontSize: 12,
                  ),
                  side: BorderSide(
                    color:
                        isSelected ? themeState.diffModifiedColor : borderCol,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  showCheckmark: false,
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
              );
            }),

            // Clear All Button (appears if anything but All is selected)
            if (!_selectedFilters.contains(AdvancedDiffFilter.all))
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedFilters = {AdvancedDiffFilter.all};
                    _processDiffEntries();
                  });
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text('Clear',
                    style: TextStyle(color: subtleText, fontSize: 12)),
              ),
          ],
        ),
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
        final availableWidth = totalWidth - _actionColumnWidth;
        final layoutWidth = availableWidth > 1.0 ? availableWidth : 1.0;
        final statusW = layoutWidth * _statusWidth;
        final keyW = layoutWidth * _keyWidth;
        final oldValW = layoutWidth * _oldValueWidth;
        final newValW = layoutWidth * _newValueWidth;

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
      double actionW) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: headerBg,
        border: Border(bottom: BorderSide(color: borderCol)),
      ),
      child: Row(
        children: [
          // Row number header (fixed 40px)
          Container(
            width: 40,
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
            child: Icon(
              Icons.delete_outline,
              color: textColor.withValues(alpha: 0.6),
              size: 16,
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

    // Status styling
    Color statusColor;
    String statusText;
    switch (status) {
      case StringComparisonStatus.added:
        statusColor = themeState.diffAddedColor;
        statusText = 'ADD';
        break;
      case StringComparisonStatus.removed:
        statusColor = themeState.diffRemovedColor;
        statusText = 'DEL';
        break;
      case StringComparisonStatus.modified:
        statusColor = themeState.diffModifiedColor;
        statusText =
            similarity != null ? 'MOD ${(similarity * 100).toInt()}%' : 'MOD';
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
          style: baseStyle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis);
    } else {
      oldValueWidget = Text(file1Value ?? '',
          style: baseStyle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis);
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

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: tintedBg,
        border:
            Border(bottom: BorderSide(color: borderCol.withValues(alpha: 0.5))),
      ),
      child: Row(
        children: [
          // Row number
          Container(
            width: 40,
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
            child: IconButton(
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
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            ),
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
