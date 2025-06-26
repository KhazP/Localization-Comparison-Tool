import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:localizer_app_main/business_logic/blocs/comparison_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'dart:io'; // For Platform.pathSeparator
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';

class HistoryView extends StatefulWidget {
  final Function(int) onNavigateToTab; // Callback to navigate tabs

  const HistoryView({super.key, required this.onNavigateToTab});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final TextEditingController _filterController = TextEditingController();
  List<ComparisonSession> _allHistory = [];
  List<ComparisonSession> _filteredHistory = [];
  // Remove _sortColumnIndex, _sortAscending, and _dataSource as PaginatedDataTable is being replaced
  // int _sortColumnIndex = 0;
  // bool _sortAscending = true;
  // _HistoryDataSource? _dataSource;

  // Map to track expansion state of each history item
  final Map<String, bool> _expandedStates = {};
  String _sortBy = 'timestamp'; // Default sort
  bool _sortAscending = false; // Default to descending for timestamp


  @override
  void initState() {
    super.initState();
    _filterController.addListener(_filterHistory);
    // Initial load of history
    context.read<HistoryBloc>().add(LoadHistory());
  }

  @override
  void dispose() {
    _filterController.removeListener(_filterHistory);
    _filterController.dispose();
    super.dispose();
  }

  void _filterHistory() {
    final filter = _filterController.text.toLowerCase();
    setState(() {
      _filteredHistory = _allHistory.where((session) {
        return session.file1Path.toLowerCase().contains(filter) ||
               session.file2Path.toLowerCase().contains(filter);
      }).toList();
      _applySort(); // Re-apply sort after filtering
    });
  }

  void _applySort() {
    _filteredHistory.sort((a, b) {
      int comparison;
      switch (_sortBy) {
        case 'file1Path':
          comparison = a.file1Path.compareTo(b.file1Path);
          break;
        case 'file2Path':
          comparison = a.file2Path.compareTo(b.file2Path);
          break;
        case 'timestamp':
        default:
          comparison = a.timestamp.compareTo(b.timestamp);
          break;
      }
      return _sortAscending ? comparison : -comparison;
    });
  }


  void _setSort(String sortBy) {
    setState(() {
      if (_sortBy == sortBy) {
        _sortAscending = !_sortAscending;
      } else {
        _sortBy = sortBy;
        _sortAscending = true; // Default to ascending for new column
        if (sortBy == 'timestamp') _sortAscending = false; // Default to descending for timestamp
      }
      _applySort();
    });
  }
  
  // Removed _updateDataSource as PaginatedDataTable is no longer used.

  // _formatSummary is no longer needed here as it will be part of the list item widget
  // String _formatSummary(ComparisonSession session) { ... }

  void _onViewDetails(ComparisonSession session) {
    // Navigate to Basic Comparison View (index 0)
    widget.onNavigateToTab(0);
    // Dispatch event to ComparisonBloc to load the files
    context.read<ComparisonBloc>().add(
          CompareFilesFromHistoryRequested(session.file1Path, session.file2Path),
        );
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        final theme = Theme.of(context);
        final bool isDarkMode = theme.brightness == Brightness.dark;
        final bool isAmoled = isDarkMode &&
                              settingsState.status == SettingsStatus.loaded &&
                              settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

        final Color appBarBgColor = isAmoled
            ? Colors.black
            : (isDarkMode ? const Color(0xFF2A2D3E) : Colors.grey[50]!);
        final Color appBarContentColor = isAmoled
            ? Colors.white70
            : (isDarkMode ? Colors.white : Colors.black);
        
        final Color mainContentBgColor = isAmoled
            ? Colors.black
            : (isDarkMode ? const Color(0xFF2A2D3E) : Colors.grey[100]!);
        
        final Color searchFieldFillColor = isAmoled
            ? Colors.grey[900]! // Very dark grey for field itself on black background
            : (isDarkMode ? const Color(0xFF3A3D4E) : Colors.white);
        final Color searchFieldHintColor = isAmoled
            ? Colors.grey[600]!
            : (isDarkMode ? Colors.grey[400]! : Colors.grey[700]!);
        final Color searchFieldTextColor = isAmoled
            ? Colors.grey[300]!
            : (isDarkMode ? Colors.white : Colors.black);
        final Color searchFieldIconColor = isAmoled
            ? Colors.grey[500]!
            : (isDarkMode ? Colors.grey[300]! : Colors.grey[600]!);
        
        final Color popupMenuBgColor = isAmoled
            ? Colors.grey[900]! // Consistent with search field
            : (isDarkMode ? const Color(0xFF3A3D4E) : Colors.white);
        final Color popupMenuIconColor = isAmoled
            ? Colors.grey[400]!
            : (isDarkMode ? Colors.white70 : Colors.black54);


        return Scaffold(
          appBar: AppBar(
            title: Text('Comparison History', style: TextStyle(color: appBarContentColor)),
            backgroundColor: appBarBgColor,
            elevation: isAmoled ? 0.2 : 1.0,
            iconTheme: IconThemeData(color: appBarContentColor), // For potential leading icon
            actions: [
              IconButton(
                icon: Icon(Icons.delete_sweep, color: appBarContentColor.withOpacity(0.8)),
                tooltip: 'Clear History',
                onPressed: () async { 
                  final confirmClear = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext dialogContext) => AlertDialog(
                      title: const Text('Confirm Clear'),
                      content: const Text('Are you sure you want to clear all comparison history? This action cannot be undone.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(dialogContext).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                          onPressed: () => Navigator.of(dialogContext).pop(true),
                          child: const Text('Clear All'),
                        ),
                      ],
                    ),
                  );
                  if (confirmClear == true) {
                    context.read<HistoryBloc>().add(ClearHistory());
                  }
                },
              )
            ],
          ),
          body: BlocConsumer<HistoryBloc, HistoryState>(
            listener: (context, state) {
              if (state is HistoryLoaded) {
                setState(() {
                  _allHistory = state.history;
                  _filteredHistory = List.from(_allHistory);
                  _applySort();
                });
              } else if (state is HistoryError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              }
            },
            builder: (context, state) {
              if (state is HistoryLoading && _allHistory.isEmpty) { 
                return Center(child: CircularProgressIndicator(color: theme.colorScheme.primary));
              }
              if (_allHistory.isEmpty && state is! HistoryLoading) {
                return Center(child: Text('No comparison history yet.', style: TextStyle(color: isAmoled ? Colors.grey[500] : (isDarkMode ? Colors.grey[400] : Colors.grey[700]))));
              }

              return Container(
                color: mainContentBgColor, // Main background for list area
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _filterController,
                              style: TextStyle(color: searchFieldTextColor),
                              decoration: InputDecoration(
                                hintText: 'Filter by file name...',
                                hintStyle: TextStyle(color: searchFieldHintColor),
                                prefixIcon: Icon(Icons.search, color: searchFieldIconColor),
                                filled: true,
                                fillColor: searchFieldFillColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: isAmoled ? BorderSide(color: Colors.grey[700]!) : BorderSide.none 
                                ),
                                enabledBorder: OutlineInputBorder( // Added for consistency
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: isAmoled ? BorderSide(color: Colors.grey[700]!) : BorderSide.none
                                ),
                                focusedBorder: OutlineInputBorder( // Added for consistency
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: isAmoled ? BorderSide(color: theme.colorScheme.primary) : BorderSide(color: theme.colorScheme.primary, width:1.5)
                                ),
                                suffixIcon: _filterController.text.isNotEmpty
                                    ? IconButton(
                                        icon: Icon(Icons.clear, color: searchFieldIconColor),
                                        onPressed: () {
                                          _filterController.clear();
                                        },
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.sort, color: popupMenuIconColor),
                            tooltip: "Sort By",
                            onSelected: _setSort,
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'timestamp',
                                child: Text('Sort by Date'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'file1Path',
                                child: Text('Sort by Source File'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'file2Path',
                                child: Text('Sort by Target File'),
                              ),
                            ],
                             color: popupMenuBgColor, // Background for the dropdown menu
                             // Text style for popup menu items will inherit, or can be set via itemBuilder if needed
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _filteredHistory.isEmpty
                          ? Center(child: Text('No results match your filter.', style: TextStyle(color: isAmoled ? Colors.grey[500] : (isDarkMode ? Colors.grey[400] : Colors.grey[700]))))
                          : ListView.builder(
                              itemCount: _filteredHistory.length,
                              itemBuilder: (context, index) {
                                final session = _filteredHistory[index];
                                final isExpanded = _expandedStates[session.id] ?? false;
                                return _buildHistoryCard(context, session, isExpanded, isDarkMode, isAmoled);
                              },
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }

  Widget _buildHistoryCard(BuildContext context, ComparisonSession session, bool isExpanded, bool isDarkMode, bool isAmoled) {
    final theme = Theme.of(context);
    // Define colors for stats based on mockup (these are semantic, should be okay for Amoled if contrast is good)
    final Color newColor = isAmoled 
        ? Colors.greenAccent[100]! // Lighter for Amoled
        : (isDarkMode ? Colors.greenAccent.shade400 : Colors.green.shade700);
    final Color delColor = isAmoled 
        ? Colors.red[300]! // Lighter for Amoled
        : (isDarkMode ? Colors.redAccent.shade400 : Colors.red.shade700);
    final Color modColor = isAmoled 
        ? Colors.orange[300]! // Lighter for Amoled
        : (isDarkMode ? Colors.orangeAccent.shade400 : Colors.orange.shade700);
    
    String formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm').format(session.timestamp);

    // Define text and icon colors for Amoled
    final Color cardTextColor = isAmoled ? Colors.grey[400]! : (isDarkMode ? Colors.grey[300]! : Colors.grey[700]!);
    final Color cardMutedTextColor = isAmoled ? Colors.grey[500]! : (isDarkMode ? Colors.grey[400]! : Colors.grey[700]!);
    final Color cardIconColor = isAmoled ? Colors.grey[500]! : (isDarkMode ? Colors.grey[400]! : Colors.grey[700]!);
    final Color expandIconColor = isAmoled ? Colors.grey[500]! : (isDarkMode ? Colors.white70 : Colors.black54);
    final Color noChangesTextColor = isAmoled ? Colors.grey[500]! : (isDarkMode ? Colors.grey[400]! : Colors.grey[600]!);

    final Color cardInkWellSplashColor = isAmoled ? Colors.white.withOpacity(0.05) : theme.splashColor;
    final Color cardInkWellHighlightColor = isAmoled ? Colors.white.withOpacity(0.03) : theme.highlightColor;

    return Card(
      color: isAmoled ? Colors.black : (isDarkMode ? const Color(0xFF3A3D4E) : Colors.white),
      elevation: isAmoled ? 0.2 : 2.0,
      shape: isAmoled 
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Or your desired radius
              side: BorderSide(color: Colors.grey[850]!)
            )
          : null, // Default shape with elevation for non-Amoled
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _expandedStates[session.id] = !isExpanded;
          });
        },
        splashColor: cardInkWellSplashColor,
        highlightColor: cardInkWellHighlightColor,
        borderRadius: BorderRadius.circular(12.0), // Match card's border radius for ink effects
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: cardIconColor),
                      const SizedBox(width: 8),
                      Text(
                        formattedTimestamp,
                        style: TextStyle(fontSize: 13, color: cardMutedTextColor),
                      ),
                    ],
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: expandIconColor,
                  ),
                ],
              ),
              if (!isExpanded) ...[ // Collapsed view: Summary stats
                const SizedBox(height: 12),
                 Row(
                  children: [
                    if (session.stringsAdded > 0) ...[
                      Icon(Icons.add_circle_outline, color: newColor, size: 16),
                      const SizedBox(width: 4),
                      Text('${session.stringsAdded} new', style: TextStyle(color: newColor, fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 12),
                    ],
                    if (session.stringsRemoved > 0) ...[
                      Icon(Icons.remove_circle_outline, color: delColor, size: 16),
                      const SizedBox(width: 4),
                      Text('${session.stringsRemoved} del', style: TextStyle(color: delColor, fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 12),
                    ],
                    if (session.stringsModified > 0) ...[
                      Icon(Icons.sync_alt, color: modColor, size: 16),
                      const SizedBox(width: 4),
                      Text('${session.stringsModified} mod', style: TextStyle(color: modColor, fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                    if (session.stringsAdded == 0 && session.stringsRemoved == 0 && session.stringsModified == 0)
                      Text('No changes', style: TextStyle(color: noChangesTextColor, fontSize: 13)),
                  ],
                ),
              ],
              if (isExpanded) ...[ // Expanded view: Detailed info
                const SizedBox(height: 12),
                _buildDetailRow('Source:', session.file1Path.split(Platform.pathSeparator).last, Icons.article_outlined, isDarkMode, theme, isAmoled, fullPath: session.file1Path),
                const SizedBox(height: 8),
                _buildDetailRow('Target:', session.file2Path.split(Platform.pathSeparator).last, Icons.article_outlined, isDarkMode, theme, isAmoled, fullPath: session.file2Path),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (session.stringsAdded > 0) _buildStatChip('${session.stringsAdded} new', newColor, Icons.add_circle_outline, isAmoled),
                    if (session.stringsRemoved > 0) _buildStatChip('${session.stringsRemoved} del', delColor, Icons.remove_circle_outline, isAmoled),
                    if (session.stringsModified > 0) _buildStatChip('${session.stringsModified} mod', modColor, Icons.sync_alt, isAmoled),
                     if (session.stringsAdded == 0 && session.stringsRemoved == 0 && session.stringsModified == 0)
                      Text('No changes detected', style: TextStyle(color: noChangesTextColor, fontStyle: FontStyle.italic)),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    icon: Icon(Icons.visibility_outlined, size: 18, color: theme.colorScheme.primary),
                    label: Text('View in Comparison', style: TextStyle(color: theme.colorScheme.primary, fontSize: 13)),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    onPressed: () => _onViewDetails(session),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon, bool isDarkMode, ThemeData theme, bool isAmoled, {String? fullPath}) {
    final Color detailIconColor = isAmoled 
        ? Colors.blue[400]! 
        : (isDarkMode ? Colors.blue[300]! : theme.primaryColor);
    final Color detailLabelColor = isAmoled 
        ? Colors.grey[350]! 
        : (isDarkMode ? Colors.grey[300]! : Colors.black87);
    final Color detailValueColor = isAmoled 
        ? Colors.grey[350]! 
        : (isDarkMode ? Colors.grey[300]! : Colors.black87);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: detailIconColor),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: detailLabelColor)),
        const SizedBox(width: 4),
        Expanded(
          child: Tooltip(
            message: fullPath ?? value,
            child: Text(
              value,
              style: TextStyle(fontSize: 13, color: detailValueColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatChip(String text, Color color, IconData icon, bool isAmoled) {
    final Color chipBackgroundColor = isAmoled ? color.withOpacity(0.1) : color.withOpacity(0.15);
    final Color chipBorderColor = isAmoled ? color.withOpacity(0.3) : color.withOpacity(0.5);

    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: chipBackgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: chipBorderColor, width: 0.5)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// _HistoryDataSource class is no longer needed and should be removed.
// class _HistoryDataSource extends DataTableSource { ... } 