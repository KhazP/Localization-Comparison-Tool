import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart'; // For StringComparisonStatus and ComparisonStatusDetail
import 'package:csv/csv.dart'; // For CSV generation
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';

// New enum for advanced filter status
enum AdvancedDiffFilter {
  all,
  added,
  removed,
  modified, // Shows all modified regardless of similarity
  modifiedHighSimilarity,   // e.g. similarity >= 0.7
  modifiedMediumSimilarity, // e.g. 0.4 <= similarity < 0.7
  modifiedLowSimilarity     // e.g. similarity < 0.4
}

// Enum for sort order
enum DiffViewSortOrder { alphabetical, fileOrder }

class AdvancedDiffView extends StatefulWidget {
  final ComparisonResult comparisonResult;

  const AdvancedDiffView({super.key, required this.comparisonResult});

  @override
  State<AdvancedDiffView> createState() => _AdvancedDiffViewState();
}

class _AdvancedDiffViewState extends State<AdvancedDiffView> {
  AdvancedDiffFilter _currentFilter = AdvancedDiffFilter.all;
  DiffViewSortOrder _currentSortOrder = DiffViewSortOrder.fileOrder;
  List<MapEntry<String, ComparisonStatusDetail>> _processedDiffEntries = [];

  // Pagination variables
  int _currentPage = 0;
  int _itemsPerPage = 100; // Start with 100 items per page
  List<int> _itemsPerPageOptions = [50, 100, 200, 500];

  // Thresholds for similarity
  static const double _highSimilarityThreshold = 0.7; // For High Sim: >= 0.7
  static const double _lowSimilarityThreshold = 0.4;  // For Low Sim: < 0.4 
                                                     // Medium Sim will be: >= 0.4 AND < 0.7

  @override
  void initState() {
    super.initState();
    _processDiffEntries();
  }

  // Get paginated entries for current page
  List<MapEntry<String, ComparisonStatusDetail>> get _paginatedEntries {
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = (startIndex + _itemsPerPage).clamp(0, _processedDiffEntries.length);
    
    if (startIndex >= _processedDiffEntries.length) return [];
    return _processedDiffEntries.sublist(startIndex, endIndex);
  }

  int get _totalPages => (_processedDiffEntries.length / _itemsPerPage).ceil();

  void _goToPage(int page) {
    setState(() {
      _currentPage = page.clamp(0, _totalPages - 1);
    });
  }

  void _changeItemsPerPage(int newItemsPerPage) {
    setState(() {
      _itemsPerPage = newItemsPerPage;
      _currentPage = 0; // Reset to first page
    });
  }

  void _processDiffEntries() {
    List<MapEntry<String, ComparisonStatusDetail>> filteredEntries = widget.comparisonResult.diff.entries.where((entry) {
      final statusDetail = entry.value;
      final status = statusDetail.status;
      final similarity = statusDetail.similarity; // Will be null if not modified

      if (status == StringComparisonStatus.identical) return false; // Always exclude identical

      switch (_currentFilter) {
        case AdvancedDiffFilter.added:
          return status == StringComparisonStatus.added;
        case AdvancedDiffFilter.removed:
          return status == StringComparisonStatus.removed;
        case AdvancedDiffFilter.modified: // Show all modified
          return status == StringComparisonStatus.modified;
        case AdvancedDiffFilter.modifiedHighSimilarity:
          return status == StringComparisonStatus.modified && 
                 similarity != null && 
                 similarity >= _highSimilarityThreshold;
        case AdvancedDiffFilter.modifiedMediumSimilarity:
          return status == StringComparisonStatus.modified && 
                 similarity != null && 
                 similarity >= _lowSimilarityThreshold &&
                 similarity < _highSimilarityThreshold;
        case AdvancedDiffFilter.modifiedLowSimilarity:
          return status == StringComparisonStatus.modified && 
                 similarity != null && 
                 similarity < _lowSimilarityThreshold;
        case AdvancedDiffFilter.all:
        default:
          return true;
      }
    }).toList();

    // Apply sorting
    if (_currentSortOrder == DiffViewSortOrder.alphabetical) {
      filteredEntries.sort((a, b) => a.key.toLowerCase().compareTo(b.key.toLowerCase()));
    } else { // DiffViewSortOrder.fileOrder
      // Optimized sorting for fileOrder
      final List<String> sourceKeysInOrder = widget.comparisonResult.file1Data.keys.toList();
      final Map<String, int> sourceKeyIndexMap = {
        for (var i = 0; i < sourceKeysInOrder.length; i++) sourceKeysInOrder[i]: i
      };

      filteredEntries.sort((a, b) {
        final int indexA = sourceKeyIndexMap[a.key] ?? -1;
        final int indexB = sourceKeyIndexMap[b.key] ?? -1;

        if (indexA == -1 && indexB == -1) { // Both keys are not in source (e.g., added in target)
          return a.key.toLowerCase().compareTo(b.key.toLowerCase()); // Fallback to alphabetical for new keys
        }
        if (indexA == -1) return 1; // Place keys not in source (added) after those that are
        if (indexB == -1) return -1; // Place keys not in source (added) after those that are
        return indexA.compareTo(indexB);
      });
    }
    setState(() {
      _processedDiffEntries = filteredEntries;
      _currentPage = 0; // Reset to first page when filter/sort changes
    });
  }

  List<DataColumn> _buildDataColumns(BuildContext context) {
    return const [
      DataColumn(label: Text('Status')),
      DataColumn(label: Text('String Key')),
      DataColumn(label: Text('Old Value (Source)')),
      DataColumn(label: Text('New Value (Target)'))
      // DataColumn(label: Text('Similarity %')), // Removed Column
    ];
  }

  Widget _buildPaginationControls(BuildContext context, bool isDarkMode, bool isAmoled) {
    if (_totalPages <= 1) return const SizedBox.shrink();

    final Color controlBgColor = isAmoled 
        ? Colors.grey[900]! 
        : (isDarkMode ? Colors.grey[800]! : Colors.grey[100]!);
    
    final Color textColor = isAmoled 
        ? Colors.grey[300]! 
        : (isDarkMode ? Colors.grey[300]! : Colors.black87);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: controlBgColor,
        border: Border(
          top: BorderSide(color: isAmoled ? Colors.grey[800]! : Colors.grey[300]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Items per page selector
          Row(
            children: [
              Text('Items per page:', style: TextStyle(color: textColor, fontSize: 12)),
              const SizedBox(width: 8),
              DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _itemsPerPage,
                  dropdownColor: controlBgColor,
                  style: TextStyle(color: textColor, fontSize: 12),
                  items: _itemsPerPageOptions.map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) _changeItemsPerPage(newValue);
                  },
                ),
              ),
            ],
          ),
          
          // Page info and navigation
          Row(
            children: [
              Text(
                'Page ${_currentPage + 1} of $_totalPages (${_processedDiffEntries.length} items)',
                style: TextStyle(color: textColor, fontSize: 12),
              ),
              const SizedBox(width: 16),
              
              // Previous page button
              IconButton(
                onPressed: _currentPage > 0 ? () => _goToPage(_currentPage - 1) : null,
                icon: Icon(Icons.chevron_left, color: _currentPage > 0 ? textColor : textColor.withOpacity(0.3)),
                iconSize: 20,
              ),
              
              // Page input field for direct navigation
              if (_totalPages > 5)
                SizedBox(
                  width: 40,
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor, fontSize: 12),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                      hintText: '${_currentPage + 1}',
                      hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                    ),
                    onSubmitted: (value) {
                      final page = int.tryParse(value);
                      if (page != null && page > 0 && page <= _totalPages) {
                        _goToPage(page - 1);
                      }
                    },
                  ),
                ),
              
              // Next page button
              IconButton(
                onPressed: _currentPage < _totalPages - 1 ? () => _goToPage(_currentPage + 1) : null,
                icon: Icon(Icons.chevron_right, color: _currentPage < _totalPages - 1 ? textColor : textColor.withOpacity(0.3)),
                iconSize: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<DataRow> _buildDataRows(BuildContext context, BoxConstraints constraints, bool isDarkMode, ThemeData theme, bool isAmoled) {
    List<DataRow> rows = [];

    // Get theme state for diff colors
    final themeState = context.watch<ThemeBloc>().state;

    // Adjusted proportional widths (Similarity % width redistributed)
    final double statusColWidth = constraints.maxWidth * 0.12; 
    final double keyColWidth = constraints.maxWidth * (0.28 + 0.05); // Was 0.28, added 0.05
    final double valueColWidth = constraints.maxWidth * (0.23 + 0.035); // Was 0.23, added 0.035 (x2 = 0.07)
    // Total: 0.12 + 0.33 + 0.265 + 0.265 = 0.98. Redistributed 0.12 from similarity_col

    // Define cell text color based on Amoled mode
    final Color cellTextColor = isAmoled ? Colors.grey[300]! : (isDarkMode ? Colors.grey[300]! : Colors.black87);

    for (var entry in _paginatedEntries) {
      final key = entry.key;
      final statusDetail = entry.value; 
      final status = statusDetail.status;
      // final similarity = statusDetail.similarity; // No longer directly displayed in a cell

      final file1Value = widget.comparisonResult.file1Data[key] ?? '--';
      final file2Value = widget.comparisonResult.file2Data[key] ?? '--';
      
      String statusText = ''; 
      Color statusColor = Colors.transparent; 
      TextStyle statusTextStyle = const TextStyle(); 
      // String similarityText = '--'; // No longer needed for direct display

      switch (status) {
        case StringComparisonStatus.added:
          statusText = 'ADDED';
          statusColor = themeState.diffAddedColor.withOpacity(0.1);
          statusTextStyle = TextStyle(color: themeState.diffAddedColor, fontWeight: FontWeight.bold);
          break;
        case StringComparisonStatus.removed:
          statusText = 'REMOVED';
          statusColor = themeState.diffRemovedColor.withOpacity(0.1);
          statusTextStyle = TextStyle(color: themeState.diffRemovedColor, fontWeight: FontWeight.bold);
          break;
        case StringComparisonStatus.modified:
          statusText = 'MODIFIED';
          statusColor = themeState.diffModifiedColor.withOpacity(0.1);
          statusTextStyle = TextStyle(color: themeState.diffModifiedColor, fontWeight: FontWeight.bold);
          // if (similarity != null) { // similarityText is not displayed directly
          //   similarityText = '${(similarity * 100).toStringAsFixed(1)}%';
          // }
          break;
        case StringComparisonStatus.identical: 
        default:
          continue; 
      }

      rows.add(DataRow(
        color: WidgetStateProperty.resolveWith<Color?>((_) => statusColor),
        cells: [
          DataCell(Container(width: statusColWidth, alignment: Alignment.centerLeft, child: Text(statusText, style: statusTextStyle, overflow: TextOverflow.ellipsis))),
          DataCell(Container(width: keyColWidth, alignment: Alignment.centerLeft, child: SelectableText(key, maxLines: 2, style: TextStyle(color: cellTextColor)))),
          DataCell(Container(width: valueColWidth, alignment: Alignment.centerLeft, child: SelectableText(status == StringComparisonStatus.added ? '--' : file1Value, maxLines: 3, style: TextStyle(color: cellTextColor)))),
          DataCell(Container(width: valueColWidth, alignment: Alignment.centerLeft, child: SelectableText(status == StringComparisonStatus.removed ? '--' : file2Value, maxLines: 3, style: TextStyle(color: cellTextColor)))),
          // DataCell(Container(width: similarityColWidth, alignment: Alignment.centerRight, child: SelectableText(similarityText, style: TextStyle(color: isDarkMode ? Colors.grey[300] : Colors.black87)))), // Removed Cell
        ],
      ));
    }
    return rows;
  }

  Future<void> _exportToCsv(BuildContext context) async {
    List<List<dynamic>> csvData = [];
    // Remove "Similarity (%)" column header
    csvData.add(['Status', 'String Key', 'Old Value (Source)', 'New Value (Target)']);

    for (var entry in _processedDiffEntries) { // Use processed entries for CSV
      final key = entry.key;
      final statusDetail = entry.value; // ComparisonStatusDetail
      final status = statusDetail.status;

      final file1Value = widget.comparisonResult.file1Data[key] ?? '';
      final file2Value = widget.comparisonResult.file2Data[key] ?? '';
      String statusText;

      switch (status) {
        case StringComparisonStatus.added: 
          statusText = 'ADDED'; 
          csvData.add([statusText, key, '', file2Value]);
          break;
        case StringComparisonStatus.removed: 
          statusText = 'REMOVED'; 
          csvData.add([statusText, key, file1Value, '']);
          break;
        case StringComparisonStatus.modified: 
          statusText = 'MODIFIED';
          csvData.add([statusText, key, file1Value, file2Value]);
          break;
        default: break;
      }
    }
    String csvString = const ListToCsvConverter().convert(csvData);
    
    // Save to file using FilePicker
    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save CSV Report',
      fileName: 'comparison_report.csv',
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    
    if (outputPath != null) {
      try {
        final file = File(outputPath);
        await file.writeAsString(csvString);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('CSV saved to: $outputPath'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to save CSV: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // No direct context.watch here. We will use BlocBuilder.

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        final theme = Theme.of(context);
        final bool isDarkMode = theme.brightness == Brightness.dark;

        final bool isAmoled = isDarkMode &&
                            settingsState.status == SettingsStatus.loaded &&
                            settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

        final Color scaffoldBgColor = isAmoled 
            ? Colors.black 
            : (isDarkMode ? const Color(0xFF1E1E1E) : Colors.grey[200]!);
        
        final Color appBarBgColor = isAmoled 
            ? Colors.black 
            : (isDarkMode ? const Color(0xFF2D2D2D) : theme.appBarTheme.backgroundColor ?? theme.primaryColor);

        // Text color for DataTable headings
        final Color headingTextColor = isAmoled 
            ? Colors.grey[400]! 
            : (isDarkMode ? (theme.textTheme.titleMedium?.color ?? Colors.white70) : (theme.textTheme.bodyLarge?.color ?? Colors.black87));

        // _processedDiffEntries is updated by _processDiffEntries in initState and when filters change

        return Scaffold(
          backgroundColor: scaffoldBgColor,
          appBar: AppBar(
            title: const Text('Advanced Comparison Details'),
            backgroundColor: appBarBgColor,
            elevation: isAmoled ? 0.2 : 1.0,
            iconTheme: IconThemeData(color: isAmoled ? Colors.white70 : theme.appBarTheme.iconTheme?.color), // Ensure back arrow is visible
            titleTextStyle: TextStyle(color: isAmoled ? Colors.white70 : theme.appBarTheme.titleTextStyle?.color, fontSize: 20, fontWeight: FontWeight.w500),
            actions: [
              IconButton(
                icon: Icon(Icons.download_for_offline_outlined, color: isAmoled ? Colors.white70 : theme.iconTheme.color),
                tooltip: 'Export as CSV',
                onPressed: () => _exportToCsv(context),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: <Widget>[
                    _buildFilterChip(AdvancedDiffFilter.all, 'All', theme.primaryColor, isDarkMode, theme, isAmoled),
                    _buildFilterChip(AdvancedDiffFilter.added, 'Added', Colors.green[700]!, isDarkMode, theme, isAmoled),
                    _buildFilterChip(AdvancedDiffFilter.removed, 'Removed', Colors.red[700]!, isDarkMode, theme, isAmoled),
                    _buildFilterChip(AdvancedDiffFilter.modified, 'Modified (All)', Colors.orange[700]!, isDarkMode, theme, isAmoled),
                    _buildFilterChip(AdvancedDiffFilter.modifiedHighSimilarity, 'Mod. (High Sim. ≥70%)', Colors.orange[600]!, isDarkMode, theme, isAmoled),
                    _buildFilterChip(AdvancedDiffFilter.modifiedMediumSimilarity, 'Mod. (Med Sim. 40-70%)', Colors.orange[500]!, isDarkMode, theme, isAmoled),
                    _buildFilterChip(AdvancedDiffFilter.modifiedLowSimilarity, 'Mod. (Low Sim. <40%)', Colors.orange[400]!, isDarkMode, theme, isAmoled),
                    const SizedBox(width: 16),
                     ElevatedButton.icon(
                      icon: Icon(_currentSortOrder == DiffViewSortOrder.alphabetical ? Icons.sort_by_alpha : Icons.format_list_numbered, size: 18),
                      label: Text(_currentSortOrder == DiffViewSortOrder.alphabetical ? 'Sort: Alpha' : 'Sort: File Order'),
                      onPressed: () {
                        setState(() {
                          _currentSortOrder = _currentSortOrder == DiffViewSortOrder.alphabetical 
                                              ? DiffViewSortOrder.fileOrder 
                                              : DiffViewSortOrder.alphabetical;
                          _processDiffEntries();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAmoled ? Colors.grey[850] : (isDarkMode ? theme.colorScheme.surface : theme.colorScheme.secondaryContainer),
                        foregroundColor: isAmoled ? Colors.white70 : (isDarkMode ? theme.colorScheme.onSurface.withOpacity(0.7) : theme.colorScheme.onSecondaryContainer),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        elevation: isAmoled ? 0.5 : 1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    // Top pagination controls
                    _buildPaginationControls(context, isDarkMode, isAmoled),
                    
                    // DataTable
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          // Build rows *inside* LayoutBuilder, now we have constraints
                          // We use _processedDiffEntries to decide on content before building rows for DataTable

                          if (_processedDiffEntries.isEmpty) { // Check the source list for emptiness
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text('No differences match your filter (excluding identical strings).', style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.grey[400] : Colors.grey[700])),
                              )
                            );
                          }
                          
                          // If not empty, build rows and return the scrollable DataTable
                          final List<DataRow> dataRows = _buildDataRows(context, constraints, isDarkMode, theme, isAmoled);

                          return Scrollbar( 
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Scrollbar( 
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                                    child: DataTable(
                                      columnSpacing: 25, 
                                      headingRowHeight: 48,
                                      dataRowMinHeight: 48,
                                      dataRowMaxHeight: 56, 
                                      dividerThickness: 1,
                                      headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                                        (Set<WidgetState> states) => isDarkMode ? const Color(0xFF3C3C3C) : Colors.grey[300],
                                      ),
                                      headingTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: headingTextColor,
                                      ),
                                      dataTextStyle: TextStyle(
                                        fontSize: 13,
                                        color: isDarkMode ? Colors.grey[300] : Colors.black87,
                                      ),
                                      columns: _buildDataColumns(context),
                                      rows: dataRows, // Use the locally built dataRows
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Bottom pagination controls
                    _buildPaginationControls(context, isDarkMode, isAmoled),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  // Helper method for creating modern filter chips
  Widget _buildFilterChip(AdvancedDiffFilter filter, String label, Color activeColor, bool isDarkMode, ThemeData theme, bool isAmoled) {
    final bool isActive = _currentFilter == filter;
    
    final bgColor = isAmoled ? Colors.black : (isDarkMode ? const Color(0xFF1A1A22) : Colors.white);
    final borderColor = isAmoled ? Colors.grey[800]! : (isDarkMode ? const Color(0xFF2E2E38) : Colors.grey[300]!);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentFilter = filter;
          _processDiffEntries();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withAlpha(isDarkMode ? 40 : 25) : bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? activeColor : borderColor,
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isActive)
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(Icons.check, size: 14, color: activeColor),
              ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive 
                    ? activeColor 
                    : (isDarkMode ? Colors.grey[400] : Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 