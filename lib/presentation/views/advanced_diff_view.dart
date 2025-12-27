import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:csv/csv.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/presentation/widgets/common/diff_highlighter.dart';

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

class AdvancedDiffView extends StatefulWidget {
  final ComparisonResult comparisonResult;

  const AdvancedDiffView({super.key, required this.comparisonResult});

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

  // Pagination
  int _currentPage = 0;
  int _itemsPerPage = 100;
  final List<int> _itemsPerPageOptions = [50, 100, 200, 500];

  // Resizable columns - relative widths (sum = 1.0)
  double _statusWidth = 0.10;
  double _keyWidth = 0.28;
  double _oldValueWidth = 0.31;
  double _newValueWidth = 0.31;
  
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
    _searchController.dispose();
    super.dispose();
  }

  // Stats calculation
  Map<String, int> get _stats {
    int added = 0, removed = 0, modified = 0;
    for (var entry in widget.comparisonResult.diff.entries) {
      switch (entry.value.status) {
        case StringComparisonStatus.added: added++; break;
        case StringComparisonStatus.removed: removed++; break;
        case StringComparisonStatus.modified: modified++; break;
        default: break;
      }
    }
    return {'added': added, 'removed': removed, 'modified': modified, 'total': added + removed + modified};
  }

  List<MapEntry<String, ComparisonStatusDetail>> get _paginatedEntries {
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = (startIndex + _itemsPerPage).clamp(0, _processedDiffEntries.length);
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

  void _processDiffEntries() {
    List<MapEntry<String, ComparisonStatusDetail>> filteredEntries = widget.comparisonResult.diff.entries.where((entry) {
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
      if (_selectedFilters.contains(AdvancedDiffFilter.all) || _selectedFilters.isEmpty) {
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
         if (_selectedFilters.contains(AdvancedDiffFilter.modifiedHighSimilarity) && 
             similarity != null && similarity >= _highSimilarityThreshold) {
           matches = true;
         }
         if (!matches && _selectedFilters.contains(AdvancedDiffFilter.modifiedMediumSimilarity) && 
             similarity != null && similarity >= _lowSimilarityThreshold && similarity < _highSimilarityThreshold) {
           matches = true;
         }
         if (!matches && _selectedFilters.contains(AdvancedDiffFilter.modifiedLowSimilarity) && 
             similarity != null && similarity < _lowSimilarityThreshold) {
           matches = true;
         }
      }

      return matches;
    }).toList();

    // Sorting
    if (_currentSortOrder == DiffViewSortOrder.alphabetical) {
      filteredEntries.sort((a, b) => a.key.toLowerCase().compareTo(b.key.toLowerCase()));
    } else {
      final sourceKeys = widget.comparisonResult.file1Data.keys.toList();
      final keyIndex = {for (var i = 0; i < sourceKeys.length; i++) sourceKeys[i]: i};
      filteredEntries.sort((a, b) {
        final indexA = keyIndex[a.key] ?? -1;
        final indexB = keyIndex[b.key] ?? -1;
        if (indexA == -1 && indexB == -1) return a.key.compareTo(b.key);
        if (indexA == -1) return 1;
        if (indexB == -1) return -1;
        return indexA.compareTo(indexB);
      });
    }

    setState(() {
      _processedDiffEntries = filteredEntries;
      _currentPage = 0;
    });
  }

  Future<void> _exportToCsv(BuildContext context) async {
    List<List<dynamic>> csvData = [['Status', 'String Key', 'Old Value (Source)', 'New Value (Target)', 'Similarity']];
    for (var entry in _processedDiffEntries) {
      final key = entry.key;
      final status = entry.value.status;
      final similarity = entry.value.similarity;
      final file1Value = widget.comparisonResult.file1Data[key] ?? '';
      final file2Value = widget.comparisonResult.file2Data[key] ?? '';
      
      String statusText = status == StringComparisonStatus.added ? 'ADDED' 
          : status == StringComparisonStatus.removed ? 'REMOVED' : 'MODIFIED';
      String simText = similarity != null ? '${(similarity * 100).toStringAsFixed(1)}%' : '';
      
      csvData.add([statusText, key, 
        status == StringComparisonStatus.added ? '' : file1Value,
        status == StringComparisonStatus.removed ? '' : file2Value,
        simText]);
    }
    
    String csvString = const ListToCsvConverter().convert(csvData);
    
    // Add UTF-8 BOM for Excel compatibility with non-English characters
    csvString = '\uFEFF$csvString';

    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save CSV Report',
      fileName: 'comparison_report.csv',
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    
    if (outputPath != null) {
      try {
        await File(outputPath).writeAsString(csvString);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('CSV saved to: $outputPath'), behavior: SnackBarBehavior.floating),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save CSV: $e'), backgroundColor: Colors.red),
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
        final bgColor = isDarkMode ? (isAmoled ? Colors.black : _bgPrimary) : Colors.grey[100]!;
        final headerBg = isDarkMode ? (isAmoled ? const Color(0xFF111111) : _bgHeader) : Colors.grey[200]!;
        final rowAltBg = isDarkMode ? (isAmoled ? const Color(0xFF0A0A0A) : _bgSecondary) : Colors.white;
        final textColor = isDarkMode ? _textPrimary : Colors.black87;
        final subtleText = isDarkMode ? _textSecondary : Colors.grey[600]!;
        final borderCol = isDarkMode ? (isAmoled ? Colors.grey[900]! : _borderColor) : Colors.grey[300]!;

        final themeState = context.watch<ThemeBloc>().state;
        final stats = _stats;

        return Scaffold(
          backgroundColor: bgColor,
          body: Column(
            children: [
              // Compact Toolbar
              _buildToolbar(context, isDarkMode, isAmoled, headerBg, textColor, subtleText, borderCol, stats, themeState),
              
              // Filter Bar
              _buildFilterBar(isDarkMode, textColor, borderCol, subtleText, themeState),
              
              // Divider
              Container(height: 1, color: borderCol),
              
              // Table
              Expanded(
                child: _buildTable(context, isDarkMode, isAmoled, headerBg, rowAltBg, textColor, subtleText, borderCol, themeState),
              ),
              
              // Footer with pagination
              _buildFooter(context, isDarkMode, isAmoled, headerBg, textColor, subtleText, borderCol),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToolbar(BuildContext ctx, bool isDark, bool isAmoled, Color headerBg, Color textColor, 
      Color subtleText, Color borderCol, Map<String, int> stats, AppThemeState themeState) {
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
          Text('Diff View', style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(width: 16),
          
          // Stats badges
          _buildStatBadge('${stats['total']}', 'total', subtleText, isDark),
          const SizedBox(width: 8),
          _buildStatBadge('${stats['added']}', 'added', themeState.diffAddedColor, isDark),
          const SizedBox(width: 8),
          _buildStatBadge('${stats['removed']}', 'removed', themeState.diffRemovedColor, isDark),
          const SizedBox(width: 8),
          _buildStatBadge('${stats['modified']}', 'mod', themeState.diffModifiedColor, isDark),
          
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
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
                  borderSide: BorderSide(color: Theme.of(ctx).colorScheme.primary, width: 1.5),
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
            onPressed: () => _exportToCsv(ctx),
            tooltip: 'Export CSV',
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
          Text(count, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: color.withValues(alpha: 0.8), fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildFilterBar(bool isDark, Color textColor, Color borderCol, Color subtleText, AppThemeState themeState) {
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
            Text('Filters:', style: TextStyle(color: subtleText, fontSize: 13, fontWeight: FontWeight.w500)),
            const SizedBox(width: 12),
            // Filter Chips
            ...allFilters.map((filter) {
               bool isSelected = _selectedFilters.contains(filter);
               String label = '';
               Color? chipColor;
               
               switch (filter) {
                   case AdvancedDiffFilter.all: label = 'All'; break;
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
                   default: label = '';
               }
               
               return Padding(
                 padding: const EdgeInsets.only(right: 8),
                 child: FilterChip(
                   label: Text(label),
                   selected: isSelected,
                   onSelected: (_) => toggleFilter(filter),
                   backgroundColor: isDark ? Colors.black26 : Colors.grey[200],
                   selectedColor: (chipColor ?? Colors.blue).withValues(alpha: 0.2),
                   checkmarkColor: chipColor ?? Colors.blue,
                   labelStyle: TextStyle(
                       color: isSelected ? (chipColor ?? Colors.blue) : textColor,
                       fontSize: 12,
                       fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                   ),
                   side: BorderSide(
                       color: isSelected ? (chipColor ?? Colors.blue) : borderCol,
                       width: 1,
                   ),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                   showCheckmark: false,
                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                   padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                   visualDensity: VisualDensity.compact,
                 ),
               );
            }),
            Container(height: 20, width: 1, color: borderCol, margin: const EdgeInsets.symmetric(horizontal: 4)),
            const SizedBox(width: 4),
            
            // Granular Modified options
            ...[
                 AdvancedDiffFilter.modifiedHighSimilarity, 
                 AdvancedDiffFilter.modifiedMediumSimilarity, 
                 AdvancedDiffFilter.modifiedLowSimilarity
            ].map((filter) {
               bool isSelected = _selectedFilters.contains(filter);
               String label = '';
               switch(filter) {
                   case AdvancedDiffFilter.modifiedHighSimilarity: label = 'Mod. High (≥70%)'; break;
                   case AdvancedDiffFilter.modifiedMediumSimilarity: label = 'Mod. Med (40-70%)'; break;
                   case AdvancedDiffFilter.modifiedLowSimilarity: label = 'Mod. Low (<40%)'; break;
                   default: break;
               }
               
               return Padding(
                 padding: const EdgeInsets.only(right: 8),
                 child: FilterChip(
                   label: Text(label),
                   selected: isSelected,
                   onSelected: (_) => toggleFilter(filter),
                   backgroundColor: isDark ? Colors.black26 : Colors.grey[200],
                   selectedColor: themeState.diffModifiedColor.withValues(alpha: 0.2),
                   labelStyle: TextStyle(
                       color: isSelected ? themeState.diffModifiedColor : textColor,
                       fontSize: 12,
                   ),
                   side: BorderSide(
                       color: isSelected ? themeState.diffModifiedColor : borderCol,
                   ),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                child: Text('Clear', style: TextStyle(color: subtleText, fontSize: 12)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortButton(bool isDark, Color textColor, Color subtleText, Color borderCol) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentSortOrder = _currentSortOrder == DiffViewSortOrder.alphabetical
              ? DiffViewSortOrder.fileOrder : DiffViewSortOrder.alphabetical;
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
              _currentSortOrder == DiffViewSortOrder.alphabetical ? Icons.sort_by_alpha : Icons.format_list_numbered,
              color: subtleText, size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              _currentSortOrder == DiffViewSortOrder.alphabetical ? 'A-Z' : 'File',
              style: TextStyle(color: textColor, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext ctx, bool isDark, bool isAmoled, Color headerBg, Color rowAltBg, 
      Color textColor, Color subtleText, Color borderCol, AppThemeState themeState) {
    if (_processedDiffEntries.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, color: subtleText, size: 48),
            const SizedBox(height: 12),
            Text('No results match your filters', style: TextStyle(color: subtleText, fontSize: 14)),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final statusW = totalWidth * _statusWidth;
        final keyW = totalWidth * _keyWidth;
        final oldValW = totalWidth * _oldValueWidth;
        final newValW = totalWidth * _newValueWidth;

        return Column(
          children: [
            // Header row with resizable dividers
            _buildHeaderRow(statusW, keyW, oldValW, newValW, headerBg, textColor, borderCol, totalWidth),
            
            // Data rows
            Expanded(
              child: ListView.builder(
                itemCount: _paginatedEntries.length,
                itemBuilder: (context, index) {
                  final entry = _paginatedEntries[index];
                  final globalIndex = _currentPage * _itemsPerPage + index;
                  final isAlt = index % 2 == 1;
                  
                  return _buildDataRow(
                    entry, globalIndex, isAlt, 
                    statusW, keyW, oldValW, newValW,
                    isDark, isAmoled, rowAltBg, textColor, subtleText, borderCol, themeState,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeaderRow(double statusW, double keyW, double oldValW, double newValW, 
      Color headerBg, Color textColor, Color borderCol, double totalWidth) {
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
            child: Text('#', style: TextStyle(color: textColor.withValues(alpha: 0.6), fontSize: 12, fontWeight: FontWeight.w600)),
          ),
          _buildResizableDivider(0, borderCol, totalWidth),
          
          // Status
          SizedBox(
            width: statusW - 6,
            child: Text('Status', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
          _buildResizableDivider(1, borderCol, totalWidth),
          
          // Key
          SizedBox(
            width: keyW - 6,
            child: Text('String Key', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
          _buildResizableDivider(2, borderCol, totalWidth),
          
          // Old Value
          SizedBox(
            width: oldValW - 6,
            child: Text('Old Value (Source)', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
          _buildResizableDivider(3, borderCol, totalWidth),
          
          // New Value
          Expanded(
            child: Text('New Value (Target)', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600)),
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
        if (_statusWidth + delta >= _minColWidth && _keyWidth - delta >= _minColWidth) {
          _statusWidth += delta;
          _keyWidth -= delta;
        }
        break;
      case 2: // Between key and old value
        if (_keyWidth + delta >= _minColWidth && _oldValueWidth - delta >= _minColWidth) {
          _keyWidth += delta;
          _oldValueWidth -= delta;
        }
        break;
      case 3: // Between old and new value
        if (_oldValueWidth + delta >= _minColWidth && _newValueWidth - delta >= _minColWidth) {
          _oldValueWidth += delta;
          _newValueWidth -= delta;
        }
        break;
    }
  }

  Widget _buildDataRow(MapEntry<String, ComparisonStatusDetail> entry, int globalIndex, bool isAlt,
      double statusW, double keyW, double oldValW, double newValW,
      bool isDark, bool isAmoled, Color rowAltBg, Color textColor, Color subtleText, Color borderCol, AppThemeState themeState) {
    
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
    final file1Value = widget.comparisonResult.file1Data[key] ?? '--';
    final file2Value = widget.comparisonResult.file2Data[key] ?? '--';

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
        statusText = similarity != null ? 'MOD ${(similarity * 100).toInt()}%' : 'MOD';
        break;
      default:
        statusColor = subtleText;
        statusText = '---';
    }

    // Row background with subtle status tint
    final rowBg = isAlt ? rowAltBg : (isDark ? (isAmoled ? Colors.black : _bgPrimary) : Colors.white);
    final tintedBg = Color.lerp(rowBg, statusColor, 0.03)!;

    // Build value widgets
    Widget oldValueWidget;
    Widget newValueWidget;

    if (status == StringComparisonStatus.modified) {
      oldValueWidget = DiffHighlighter.buildDiffText(
        file1Value, file2Value,
        isSource: true,
        baseStyle: TextStyle(color: textColor, fontSize: fontSize, fontFamily: fontFamily),
        maxLines: 2,
        deletionColor: themeState.diffRemovedColor,
      );
      newValueWidget = DiffHighlighter.buildDiffText(
        file1Value, file2Value,
        isSource: false,
        baseStyle: TextStyle(color: textColor, fontSize: fontSize, fontFamily: fontFamily),
        maxLines: 2,
        insertionColor: themeState.diffAddedColor,
      );
    } else if (status == StringComparisonStatus.added) {
      oldValueWidget = Text('—', style: TextStyle(color: subtleText, fontSize: fontSize, fontFamily: fontFamily));
      newValueWidget = Text(file2Value, style: TextStyle(color: textColor, fontSize: fontSize, fontFamily: fontFamily), maxLines: 2, overflow: TextOverflow.ellipsis);
    } else {
      oldValueWidget = Text(file1Value, style: TextStyle(color: textColor, fontSize: fontSize, fontFamily: fontFamily), maxLines: 2, overflow: TextOverflow.ellipsis);
      newValueWidget = Text('—', style: TextStyle(color: subtleText, fontSize: fontSize, fontFamily: fontFamily));
    }

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: tintedBg,
        border: Border(bottom: BorderSide(color: borderCol.withValues(alpha: 0.5))),
      ),
      child: Row(
        children: [
          // Row number
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text('${globalIndex + 1}', style: TextStyle(color: subtleText, fontSize: fontSize, fontFamily: fontFamily)),
          ),
          Container(width: 1, height: 44, color: borderCol.withValues(alpha: 0.3)),
          
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
                child: Text(statusText, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
              ),
            ),
          ),
          Container(width: 1, height: 44, color: borderCol.withValues(alpha: 0.3)),
          
          // Key
          SizedBox(
            width: keyW - 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(key, style: TextStyle(color: textColor, fontSize: fontSize, fontFamily: fontFamily), maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          ),
          Container(width: 1, height: 44, color: borderCol.withValues(alpha: 0.3)),
          
          // Old Value
          SizedBox(
            width: oldValW - 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: oldValueWidget,
            ),
          ),
          Container(width: 1, height: 44, color: borderCol.withValues(alpha: 0.3)),
          
          // New Value
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: newValueWidget,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext ctx, bool isDark, bool isAmoled, Color headerBg, Color textColor, Color subtleText, Color borderCol) {
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
              items: _itemsPerPageOptions.map((v) => DropdownMenuItem(value: v, child: Text('$v'))).toList(),
              onChanged: (v) { if (v != null) _changeItemsPerPage(v); },
            ),
          ),
          
          const Spacer(),
          
          // Page info
          Text(
            '${_currentPage * _itemsPerPage + 1}–${((_currentPage + 1) * _itemsPerPage).clamp(0, _processedDiffEntries.length)} of ${_processedDiffEntries.length}',
            style: TextStyle(color: subtleText, fontSize: 12),
          ),
          const SizedBox(width: 16),
          
          // Page navigation
          IconButton(
            icon: Icon(Icons.first_page, color: _currentPage > 0 ? textColor : subtleText, size: 18),
            onPressed: _currentPage > 0 ? () => _goToPage(0) : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          IconButton(
            icon: Icon(Icons.chevron_left, color: _currentPage > 0 ? textColor : subtleText, size: 18),
            onPressed: _currentPage > 0 ? () => _goToPage(_currentPage - 1) : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text('${_currentPage + 1} / $_totalPages', style: TextStyle(color: textColor, fontSize: 12)),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, color: _currentPage < _totalPages - 1 ? textColor : subtleText, size: 18),
            onPressed: _currentPage < _totalPages - 1 ? () => _goToPage(_currentPage + 1) : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          IconButton(
            icon: Icon(Icons.last_page, color: _currentPage < _totalPages - 1 ? textColor : subtleText, size: 18),
            onPressed: _currentPage < _totalPages - 1 ? () => _goToPage(_totalPages - 1) : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
        ],
      ),
    );
  }
}