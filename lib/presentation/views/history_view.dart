import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:localizer_app_main/business_logic/blocs/comparison_bloc.dart';
import 'package:localizer_app_main/core/utils/time_utils.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/directory_comparison_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/git_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/repositories/project_repository.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/common/skeleton_loader.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/core/services/dialog_service.dart';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum HistoryFilterType { all, file, directory, git }

class HistoryView extends StatefulWidget {
  final Function(int) onNavigateToTab;

  const HistoryView({super.key, required this.onNavigateToTab});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _filterController = TextEditingController();
  HistoryFilterType _selectedFilter = HistoryFilterType.all;
  List<ComparisonSession> _allHistory = [];
  List<ComparisonSession> _filteredHistory = [];
  final Map<String, bool> _expandedStates = {};
  String _sortBy = 'timestamp';
  bool _sortAscending = false;
  bool _groupByFolder = false;
  bool _showOnlyCurrentProject = true;
  Map<String, String> _projectNames = {}; // projectId -> projectName
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _filterController.addListener(_filterHistory);
    context.read<HistoryBloc>().add(LoadHistory());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
    _loadProjectNames();
  }

  Future<void> _loadProjectNames() async {
    try {
      final repository = GetIt.I<ProjectRepository>();
      final projects = await repository.getRecentProjects();
      if (mounted) {
        setState(() {
          _projectNames = {
            for (final p in projects) p.id: p.name,
          };
        });
      }
    } catch (e) {
      // Ignore errors loading project names - we'll fall back to showing IDs
    }
  }

  @override
  void dispose() {
    _filterController.removeListener(_filterHistory);
    _filterController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _filterHistory() {
    final filter = _filterController.text.toLowerCase();
    final projectState = context.read<ProjectBloc>().state;
    String? currentProjectId;
    if (projectState.status == ProjectStatus.loaded) {
      currentProjectId = projectState.currentProject?.id;
    }

    setState(() {
      _filteredHistory = _allHistory.where((session) {
        final matchesText = session.file1Path.toLowerCase().contains(filter) ||
            session.file2Path.toLowerCase().contains(filter);

        if (!matchesText) return false;

        // Project filter
        if (_showOnlyCurrentProject && currentProjectId != null) {
          return session.projectId == currentProjectId;
        }

        // Type filter
        if (_selectedFilter == HistoryFilterType.file &&
            session.type != ComparisonType.file) return false;
        if (_selectedFilter == HistoryFilterType.directory &&
            session.type != ComparisonType.directory) return false;
        if (_selectedFilter == HistoryFilterType.git &&
            session.type != ComparisonType.git) return false;

        return true;
      }).toList();
      _applySort();
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
        _sortAscending = sortBy != 'timestamp';
      }
      _applySort();
    });
  }

  void _onViewDetails(ComparisonSession session) {
    final settingsState = context.read<SettingsBloc>().state;

    // Directory Comparison
    if (session.type == ComparisonType.directory) {
      widget.onNavigateToTab(4); // Navigate to Files tab
      context.read<DirectoryComparisonBloc>().add(
          CompareDirectoriesRequested(session.file1Path, session.file2Path));
      return;
    }

    // Git Comparison
    if (session.type == ComparisonType.git) {
      widget.onNavigateToTab(5); // Navigate to Git tab
      // Assuming gitRepoPath is stored in file1Path (or explicit field if I added one?)
      // I added explicit fields: gitRepoPath, gitBranch1, gitBranch2, etc.
      if (session.gitRepoPath != null) {
        context.read<GitBloc>().add(SelectRepository(session.gitRepoPath!));

        // Wait minor delay or assume state builds up?
        // BLoC queues events.

        if (session.gitBranch1 != null && session.gitBranch2 != null) {
          context
              .read<GitBloc>()
              .add(CompareBranches(session.gitBranch1!, session.gitBranch2!));
        } else if (session.gitCommit1 != null && session.gitCommit2 != null) {
          context
              .read<GitBloc>()
              .add(CompareCommits(session.gitCommit1!, session.gitCommit2!));
        }
      }
      return;
    }

    // Default: File Comparison
    widget.onNavigateToTab(1); // Basic Comparison
    if (settingsState.status == SettingsStatus.loaded) {
      final isBilingualSession = session.file1Path == session.file2Path;
      if (isBilingualSession) {
        context.read<ComparisonBloc>().add(
              CompareBilingualFileRequested(
                file: File(session.file1Path),
                settings: settingsState.appSettings,
                isFromHistory: true,
              ),
            );
      } else {
        context.read<ComparisonBloc>().add(
              CompareFilesFromHistoryRequested(
                file1Path: session.file1Path,
                file2Path: session.file2Path,
                settings: settingsState.appSettings,
              ),
            );
      }
    }
  }

  void _deleteSession(ComparisonSession session) {
    context.read<HistoryBloc>().add(DeleteHistoryItem(session.id));
    ToastService.showSuccess(
      context,
      'History item deleted',
      onUndo: () {
        context.read<HistoryBloc>().add(UndoDeleteHistoryItem());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    final projectState = context.watch<ProjectBloc>().state;
    final isProjectLoaded = projectState.status == ProjectStatus.loaded;

    // AMOLED detection
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = isDark &&
        settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    // AMOLED-aware color helpers
    final cardColor = isAmoled
        ? AppThemeV2.amoledCard
        : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard);
    final borderColor = isAmoled
        ? AppThemeV2.amoledBorder
        : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    LucideIcons.clock,
                    size: 28,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Comparison History',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Clear all button
                  Tooltip(
                    message: 'Clear all history',
                    child: IconButton(
                      color: isDark
                          ? AppThemeV2.darkTextMuted
                          : AppThemeV2.lightTextMuted,
                      onPressed: () => _showClearConfirmation(context),
                      icon: Icon(
                        LucideIcons.trash2,
                        color: isDark
                            ? AppThemeV2.darkTextMuted
                            : AppThemeV2.lightTextMuted,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Search and Sort Row
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: borderColor,
                        ),
                      ),
                      child: TextField(
                        controller: _filterController,
                        decoration: InputDecoration(
                          hintText: 'Search by file name...',
                          prefixIcon: Icon(
                            LucideIcons.search,
                            color: isDark
                                ? AppThemeV2.darkTextMuted
                                : AppThemeV2.lightTextMuted,
                          ),
                          suffixIcon: _filterController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    LucideIcons.x,
                                    size: 20,
                                    color: isDark
                                        ? AppThemeV2.darkTextMuted
                                        : AppThemeV2.lightTextMuted,
                                  ),
                                  onPressed: () => _filterController.clear(),
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Sort dropdown
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: borderColor,
                      ),
                    ),
                    child: PopupMenuButton<String>(
                      onSelected: _setSort,
                      tooltip: 'Sort by',
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.arrowUpDown,
                              size: 20,
                              color: isDark
                                  ? AppThemeV2.darkTextSecondary
                                  : AppThemeV2.lightTextSecondary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _getSortLabel(),
                              style: theme.textTheme.bodyMedium,
                            ),
                            Icon(
                              _sortAscending
                                  ? LucideIcons.arrowUp
                                  : LucideIcons.arrowDown,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                      itemBuilder: (context) => [
                        _buildSortMenuItem(
                            'timestamp', 'Date', LucideIcons.clock),
                        _buildSortMenuItem(
                            'file1Path', 'Source File', LucideIcons.fileInput),
                        _buildSortMenuItem('file2Path', 'Target File',
                            LucideIcons.arrowRightLeft),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Project Filter Toggle
                  if (isProjectLoaded) ...[
                    Tooltip(
                      message: _showOnlyCurrentProject
                          ? 'Showing: Current Project'
                          : 'Showing: All History',
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _showOnlyCurrentProject = !_showOnlyCurrentProject;
                            _filterHistory();
                          });
                        },
                        icon: Icon(
                          _showOnlyCurrentProject
                              ? LucideIcons.filter
                              : LucideIcons.filterX,
                          color: _showOnlyCurrentProject
                              ? colorScheme.primary
                              : (isDark
                                  ? AppThemeV2.darkTextMuted
                                  : AppThemeV2.lightTextMuted),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  // Group by folder toggle
                  Tooltip(
                    message: _groupByFolder
                        ? 'Disable folder grouping'
                        : 'Group by folder',
                    child: IconButton(
                      onPressed: () =>
                          setState(() => _groupByFolder = !_groupByFolder),
                      icon: Icon(
                        _groupByFolder
                            ? LucideIcons.folder
                            : LucideIcons.folderOpen,
                        color: _groupByFolder
                            ? colorScheme.primary
                            : (isDark
                                ? AppThemeV2.darkTextMuted
                                : AppThemeV2.lightTextMuted),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Filter Chips Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', HistoryFilterType.all),
                    const SizedBox(width: 8),
                    _buildFilterChip('Files', HistoryFilterType.file,
                        icon: LucideIcons.arrowRightLeft),
                    const SizedBox(width: 8),
                    _buildFilterChip('Directories', HistoryFilterType.directory,
                        icon: LucideIcons.folder),
                    const SizedBox(width: 8),
                    _buildFilterChip('Git', HistoryFilterType.git,
                        icon: LucideIcons.gitBranch),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // History List
              Expanded(
                child: BlocConsumer<HistoryBloc, HistoryState>(
                  listener: (context, state) {
                    if (state is HistoryLoaded) {
                      setState(() {
                        _allHistory = state.history;
                        _filteredHistory = List.from(_allHistory);
                        _applySort();
                      });
                    } else if (state is HistoryError) {
                      ToastService.showError(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is HistoryLoading && _allHistory.isEmpty) {
                      // Show skeleton loaders while history is loading
                      return const HistorySkeletonList(itemCount: 4);
                    }

                    if (_allHistory.isEmpty) {
                      return _buildEmptyState(context);
                    }

                    if (_filteredHistory.isEmpty) {
                      return _buildNoResultsState(context);
                    }

                    if (_groupByFolder) {
                      return _buildGroupedList(context);
                    }

                    // Show project-grouped view when showing all history (not filtered to current project)
                    if (!_showOnlyCurrentProject) {
                      return _buildProjectGroupedList(context);
                    }

                    return ListView.builder(
                      itemCount: _filteredHistory.length,
                      itemBuilder: (context, index) {
                        final session = _filteredHistory[index];
                        return _HistoryCard(
                          session: session,
                          isExpanded: _expandedStates[session.id] ?? false,
                          onTap: () {
                            setState(() {
                              _expandedStates[session.id] =
                                  !(_expandedStates[session.id] ?? false);
                            });
                          },
                          onView: () => _onViewDetails(session),
                          onDelete: () => _deleteSession(session),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSortLabel() {
    switch (_sortBy) {
      case 'file1Path':
        return 'Source';
      case 'file2Path':
        return 'Target';
      default:
        return 'Date';
    }
  }

  PopupMenuItem<String> _buildSortMenuItem(
      String value, String label, IconData icon) {
    final theme = Theme.of(context);
    final isSelected = _sortBy == value;

    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected ? theme.colorScheme.primary : null,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? theme.colorScheme.primary : null,
              fontWeight: isSelected ? FontWeight.w600 : null,
            ),
          ),
          if (isSelected) ...[
            const Spacer(),
            Icon(
              LucideIcons.check,
              size: 18,
              color: theme.colorScheme.primary,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGroupedList(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeState = context.watch<ThemeBloc>().state;

    // Group sessions by parent folder with full path context
    final Map<String, List<ComparisonSession>> grouped = {};
    final Map<String, String> folderPaths = {}; // Store grandparent context

    for (final session in _filteredHistory) {
      final parts = session.file1Path.split(Platform.pathSeparator);
      final folder = parts.length > 1 ? parts[parts.length - 2] : 'Root';
      final grandparent = parts.length > 2 ? parts[parts.length - 3] : '';

      grouped.putIfAbsent(folder, () => []).add(session);
      if (grandparent.isNotEmpty && !folderPaths.containsKey(folder)) {
        folderPaths[folder] = grandparent;
      }
    }

    // Sort folder names alphabetically
    final sortedFolders = grouped.keys.toList()..sort();

    return ListView.builder(
      itemCount: sortedFolders.length,
      itemBuilder: (context, folderIndex) {
        final folder = sortedFolders[folderIndex];
        final sessions = grouped[folder]!;
        final isExpanded = _expandedStates['folder_$folder'] ?? true;
        final grandparent = folderPaths[folder];

        // Aggregate stats for this folder
        int totalAdded = 0, totalRemoved = 0, totalModified = 0;
        final Set<String> fileTypes = {};

        for (final session in sessions) {
          totalAdded += session.stringsAdded;
          totalRemoved += session.stringsRemoved;
          totalModified += session.stringsModified;

          // Extract file type
          final ext = session.file1Path.split('.').last.toUpperCase();
          if (ext.isNotEmpty && ext.length <= 5) fileTypes.add(ext);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Folder header
            InkWell(
              onTap: () {
                setState(() {
                  _expandedStates['folder_$folder'] = !isExpanded;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                margin:
                    EdgeInsets.only(bottom: 8, top: folderIndex > 0 ? 16 : 0),
                decoration: BoxDecoration(
                  color: isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First row: folder name, count, expand icon
                    Row(
                      children: [
                        Icon(
                          isExpanded
                              ? LucideIcons.folderOpen
                              : LucideIcons.folder,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 10),
                        // Grandparent + folder path
                        Expanded(
                          child: Row(
                            children: [
                              if (grandparent != null &&
                                  grandparent.isNotEmpty) ...[
                                Text(
                                  '.../$grandparent/',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isDark
                                        ? AppThemeV2.darkTextMuted
                                        : AppThemeV2.lightTextMuted,
                                  ),
                                ),
                              ],
                              Text(
                                folder,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Count badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withAlpha(30),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${sessions.length}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isExpanded
                              ? LucideIcons.chevronUp
                              : LucideIcons.chevronDown,
                          size: 20,
                          color: isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Second row: stats, density bar, file types
                    Row(
                      children: [
                        // Aggregate stats
                        if (totalAdded > 0)
                          _MiniStatBadge(
                              label: '+$totalAdded',
                              color: themeState.diffAddedColor),
                        if (totalRemoved > 0)
                          _MiniStatBadge(
                              label: '-$totalRemoved',
                              color: themeState.diffRemovedColor),
                        if (totalModified > 0)
                          _MiniStatBadge(
                              label: '~$totalModified',
                              color: themeState.diffModifiedColor),
                        const SizedBox(width: 8),
                        // Mini density bar
                        Expanded(
                          child: _ChangeDensityBar(
                            added: totalAdded,
                            removed: totalRemoved,
                            modified: totalModified,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // File types
                        ...fileTypes.take(3).map((type) => Container(
                              margin: const EdgeInsets.only(left: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.secondary.withAlpha(20),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                type,
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Sessions in this folder
            if (isExpanded)
              ...sessions.map((session) => _HistoryCard(
                    session: session,
                    isExpanded: _expandedStates[session.id] ?? false,
                    onTap: () {
                      setState(() {
                        _expandedStates[session.id] =
                            !(_expandedStates[session.id] ?? false);
                      });
                    },
                    onView: () => _onViewDetails(session),
                    onDelete: () => _deleteSession(session),
                  )),
          ],
        );
      },
    );
  }

  /// Builds a list grouped by project when showing all history.
  /// Shows project name headers with aggregate stats.
  Widget _buildProjectGroupedList(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeState = context.watch<ThemeBloc>().state;

    // AMOLED detection
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = isDark &&
        settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    final cardColor = isAmoled
        ? AppThemeV2.amoledCard
        : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard);
    final borderColor = isAmoled
        ? AppThemeV2.amoledBorder
        : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder);

    // Group sessions by projectId
    final Map<String?, List<ComparisonSession>> grouped = {};

    for (final session in _filteredHistory) {
      grouped.putIfAbsent(session.projectId, () => []).add(session);
    }

    // Sort: current project first (if applicable), then by name, with "Unassigned" last
    final projectState = context.watch<ProjectBloc>().state;
    final currentProjectId = projectState.currentProject?.id;

    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        // Current project first
        if (a == currentProjectId) return -1;
        if (b == currentProjectId) return 1;
        // Unassigned (null) last
        if (a == null) return 1;
        if (b == null) return -1;
        // Sort by name alphabetically
        final nameA = _projectNames[a] ?? a;
        final nameB = _projectNames[b] ?? b;
        return nameA.compareTo(nameB);
      });

    return ListView.builder(
      itemCount: sortedKeys.length,
      itemBuilder: (context, projectIndex) {
        final projectId = sortedKeys[projectIndex];
        final sessions = grouped[projectId]!;
        final isExpanded = _expandedStates['project_$projectId'] ?? true;

        // Get project name
        String projectName;
        IconData projectIcon;
        if (projectId == null) {
          projectName = 'Unassigned';
          projectIcon = LucideIcons.folderMinus;
        } else if (projectId == currentProjectId) {
          projectName = _projectNames[projectId] ??
              projectState.currentProject?.name ??
              'Current Project';
          projectIcon = LucideIcons.star;
        } else {
          projectName = _projectNames[projectId] ??
              'Project ${projectId.substring(0, 8)}...';
          projectIcon = LucideIcons.folder;
        }

        // Aggregate stats for this project
        int totalAdded = 0, totalRemoved = 0, totalModified = 0;
        final Set<String> fileTypes = {};

        for (final session in sessions) {
          totalAdded += session.stringsAdded;
          totalRemoved += session.stringsRemoved;
          totalModified += session.stringsModified;

          // Extract file type
          final ext = session.file1Path.split('.').last.toUpperCase();
          if (ext.isNotEmpty && ext.length <= 5) fileTypes.add(ext);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project header
            InkWell(
              onTap: () {
                setState(() {
                  _expandedStates['project_$projectId'] = !isExpanded;
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                margin:
                    EdgeInsets.only(bottom: 8, top: projectIndex > 0 ? 16 : 0),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First row: project name, count, expand icon
                    Row(
                      children: [
                        Icon(
                          isExpanded ? LucideIcons.folderOpen : projectIcon,
                          size: 18,
                          color: projectId == currentProjectId
                              ? theme.colorScheme.primary
                              : (projectId == null
                                  ? (isDark
                                      ? AppThemeV2.darkTextMuted
                                      : AppThemeV2.lightTextMuted)
                                  : theme.colorScheme.secondary),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            projectName,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: projectId == null
                                  ? (isDark
                                      ? AppThemeV2.darkTextMuted
                                      : AppThemeV2.lightTextMuted)
                                  : null,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Count badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withAlpha(30),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${sessions.length}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isExpanded
                              ? LucideIcons.chevronUp
                              : LucideIcons.chevronDown,
                          size: 20,
                          color: isDark
                              ? AppThemeV2.darkTextMuted
                              : AppThemeV2.lightTextMuted,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Second row: stats, density bar, file types
                    Row(
                      children: [
                        // Aggregate stats
                        if (totalAdded > 0)
                          _MiniStatBadge(
                              label: '+$totalAdded',
                              color: themeState.diffAddedColor),
                        if (totalRemoved > 0)
                          _MiniStatBadge(
                              label: '-$totalRemoved',
                              color: themeState.diffRemovedColor),
                        if (totalModified > 0)
                          _MiniStatBadge(
                              label: '~$totalModified',
                              color: themeState.diffModifiedColor),
                        const SizedBox(width: 8),
                        // Mini density bar
                        Expanded(
                          child: _ChangeDensityBar(
                            added: totalAdded,
                            removed: totalRemoved,
                            modified: totalModified,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // File types
                        ...fileTypes.take(3).map((type) => Container(
                              margin: const EdgeInsets.only(left: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.secondary.withAlpha(20),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                type,
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Sessions in this project
            if (isExpanded)
              ...sessions.map((session) => _HistoryCard(
                    session: session,
                    isExpanded: _expandedStates[session.id] ?? false,
                    onTap: () {
                      setState(() {
                        _expandedStates[session.id] =
                            !(_expandedStates[session.id] ?? false);
                      });
                    },
                    onView: () => _onViewDetails(session),
                    onDelete: () => _deleteSession(session),
                  )),
          ],
        );
      },
    );
  }

  // Mini stat badge for folder header
  Widget _MiniStatBadge({required String label, required Color color}) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.history,
            size: 72,
            color:
                isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
          ),
          const SizedBox(height: 16),
          Text(
            'No comparison history yet',
            style: theme.textTheme.titleMedium?.copyWith(
              color: isDark
                  ? AppThemeV2.darkTextSecondary
                  : AppThemeV2.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your file comparisons will appear here',
            style: theme.textTheme.bodyMedium?.copyWith(
              color:
                  isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsState(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.searchX,
            size: 64,
            color:
                isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
          ),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: theme.textTheme.titleMedium?.copyWith(
              color: isDark
                  ? AppThemeV2.darkTextSecondary
                  : AppThemeV2.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search',
            style: theme.textTheme.bodyMedium?.copyWith(
              color:
                  isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showClearConfirmation(BuildContext context) async {
    final confirmed = await DialogService.showConfirmation(
      context: context,
      title: 'Clear All History?',
      content:
          'This will permanently delete all comparison history. This action cannot be undone.',
      confirmText: 'Clear All',
      isDestructive: true,
      icon: LucideIcons.trash2,
    );

    if (confirmed == true && context.mounted) {
      context.read<HistoryBloc>().add(ClearHistory());
    }
  }

  Widget _buildFilterChip(String label, HistoryFilterType type,
      {IconData? icon}) {
    final isSelected = _selectedFilter == type;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return FilterChip(
      avatar: icon != null
          ? Icon(
              icon,
              size: 16,
              color: isSelected
                  ? theme.colorScheme.onPrimary
                  : (isDark
                      ? AppThemeV2.darkTextSecondary
                      : AppThemeV2.lightTextSecondary),
            )
          : null,
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected) {
          setState(() {
            _selectedFilter = type;
            _filterHistory();
          });
        }
      },
      showCheckmark: false, // We use the icon as the indicator or just color
      backgroundColor: Colors.transparent,
      selectedColor: theme.colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected
            ? theme.colorScheme.onPrimary
            : (isDark
                ? AppThemeV2.darkTextSecondary
                : AppThemeV2.lightTextSecondary),
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected
              ? Colors.transparent
              : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder),
        ),
      ),
    );
  }
}

class _HistoryCard extends StatefulWidget {
  final ComparisonSession session;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback onView;
  final VoidCallback onDelete;

  const _HistoryCard({
    required this.session,
    required this.isExpanded,
    required this.onTap,
    required this.onView,
    required this.onDelete,
  });

  @override
  State<_HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<_HistoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final session = widget.session;
    final formattedDate =
        DateFormat('MMM dd, yyyy • HH:mm').format(session.timestamp);
    final relativeTime = TimeUtils.timeAgo(session.timestamp);

    // simple filename extraction
    final isBilingualSession = session.file1Path == session.file2Path;

    // Customize display based on type
    String name1, name2;
    IconData typeIcon;
    String typeLabel;

    switch (session.type) {
      case ComparisonType.directory:
        name1 = session.file1Path.split(Platform.pathSeparator).last;
        name2 = session.file2Path.split(Platform.pathSeparator).last;
        typeIcon = LucideIcons.folderInput;
        typeLabel = 'Directory';
        break;
      case ComparisonType.git:
        // Use repo name if possible or path
        name1 =
            session.gitRepoPath?.split(Platform.pathSeparator).last ?? 'Repo';
        name2 = ''; // Unused in main title for Git
        typeIcon = LucideIcons.gitBranch;
        typeLabel = 'Git';
        break;
      case ComparisonType.file:
      default:
        name1 = session.file1Path.split(Platform.pathSeparator).last;
        name2 = session.file2Path.split(Platform.pathSeparator).last;
        typeIcon = isBilingualSession
            ? LucideIcons.languages
            : LucideIcons.arrowRightLeft;
        typeLabel = isBilingualSession ? 'Bilingual' : 'File Pair';
        break;
    }

    final file1Name = name1;
    final file2Name = name2;

    final fileTypeLabel = _buildFileTypeLabel(
      session.file1Path,
      session.file2Path,
    );
    // For Git, branches info
    String? gitContext;
    if (session.type == ComparisonType.git) {
      if (session.gitBranch1 != null) {
        gitContext = '${session.gitBranch1} ↔ ${session.gitBranch2}';
      } else if (session.gitCommit1 != null) {
        gitContext =
            '${session.gitCommit1?.substring(0, 7)} ↔ ${session.gitCommit2?.substring(0, 7)}';
      }
    }

    final themeState = context.watch<ThemeBloc>().state;

    // AMOLED detection
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = isDark &&
        settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    // AMOLED-aware colors
    final cardColor = isAmoled
        ? AppThemeV2.amoledCard
        : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard);
    final cardHoverColor = isAmoled
        ? AppThemeV2.amoledCardHover
        : (isDark ? AppThemeV2.darkCardHover : AppThemeV2.lightCardHover);
    final borderColor = isAmoled
        ? AppThemeV2.amoledBorder
        : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder);
    final neutralStatColor =
        isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted;
    final totalStrings = session.stringsAdded +
        session.stringsRemoved +
        session.stringsModified +
        session.stringsIdentical;

    // Determine the dominant status color for the left border
    Color statusColor;
    if (session.stringsAdded > 0 &&
        session.stringsRemoved == 0 &&
        session.stringsModified == 0) {
      statusColor = themeState.diffAddedColor;
    } else if (session.stringsRemoved > 0 &&
        session.stringsAdded == 0 &&
        session.stringsModified == 0) {
      statusColor = themeState.diffRemovedColor;
    } else if (session.stringsModified > 0 ||
        (session.stringsAdded > 0 && session.stringsRemoved > 0)) {
      statusColor = themeState.diffModifiedColor;
    } else if (session.stringsAdded > 0 || session.stringsRemoved > 0) {
      statusColor = themeState.diffModifiedColor;
    } else {
      statusColor = borderColor;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: _isHovered ? cardHoverColor : cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left status indicator
                Container(
                  width: 4,
                  constraints: BoxConstraints(
                    minHeight: widget.isExpanded ? 140 : 80,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row
                        Row(
                          children: [
                            // 1. Type Icon & Status
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: (session.type == ComparisonType.git
                                        ? Colors.orange
                                        : (session.type ==
                                                ComparisonType.directory
                                            ? Colors.purple
                                            : Colors.blue))
                                    .withAlpha(25),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: (session.type == ComparisonType.git
                                          ? Colors.orange
                                          : (session.type ==
                                                  ComparisonType.directory
                                              ? Colors.purple
                                              : Colors.blue))
                                      .withAlpha(50),
                                ),
                              ),
                              child: Icon(
                                typeIcon,
                                size: 24,
                                color: (session.type == ComparisonType.git
                                    ? Colors.orange
                                    : (session.type == ComparisonType.directory
                                        ? Colors.purple
                                        : Colors.blue)),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // 2. Info Column (File Names + Date)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Primary Title (Repo / Dir / File)
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          name1, // Cleaned up name
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      // If it's a file comparison (and not bilingual), show arrow and second file
                                      if (session.type == ComparisonType.file &&
                                          !isBilingualSession) ...[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Icon(
                                            LucideIcons.arrowRight,
                                            size: 16,
                                            color: isDark
                                                ? AppThemeV2.darkTextMuted
                                                : AppThemeV2.lightTextMuted,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            name2,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 4),

                                  // Subtitles (Branches, Paths, etc)
                                  if (session.type == ComparisonType.git &&
                                      gitContext != null)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Row(
                                        children: [
                                          Icon(LucideIcons.gitBranch,
                                              size: 14,
                                              color:
                                                  theme.colorScheme.secondary),
                                          const SizedBox(width: 4),
                                          Text(
                                            gitContext,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              color:
                                                  theme.colorScheme.secondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  else if (session.type ==
                                      ComparisonType.directory)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        '${session.file1Path} ↔ ${session.file2Path}',
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: isDark
                                              ? AppThemeV2.darkTextMuted
                                              : AppThemeV2.lightTextMuted,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                  // Meta Row: Date & Chips
                                  Row(
                                    children: [
                                      Tooltip(
                                        message: formattedDate,
                                        child: Text(
                                          relativeTime,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: isDark
                                                ? AppThemeV2.darkTextMuted
                                                : AppThemeV2.lightTextMuted,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? AppThemeV2.darkTextMuted
                                              : AppThemeV2.lightTextMuted,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // Quick stats text instead of pie chart
                                      if (totalStrings > 0)
                                        Text.rich(
                                          TextSpan(children: [
                                            if (session.stringsAdded > 0)
                                              TextSpan(
                                                  text:
                                                      '+${session.stringsAdded} ',
                                                  style: TextStyle(
                                                      color: themeState
                                                          .diffAddedColor,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            if (session.stringsRemoved > 0)
                                              TextSpan(
                                                  text:
                                                      '-${session.stringsRemoved} ',
                                                  style: TextStyle(
                                                      color: themeState
                                                          .diffRemovedColor,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            if (session.stringsModified > 0)
                                              TextSpan(
                                                  text:
                                                      '~${session.stringsModified}',
                                                  style: TextStyle(
                                                      color: themeState
                                                          .diffModifiedColor,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          ]),
                                          style: theme.textTheme.bodySmall,
                                        )
                                      else
                                        Text(
                                          'No changes',
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            fontStyle: FontStyle.italic,
                                            color: isDark
                                                ? AppThemeV2.darkTextMuted
                                                : AppThemeV2.lightTextMuted,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // 3. Action Icon (Chevron)
                            const SizedBox(width: 8),
                            AnimatedRotation(
                              turns: widget.isExpanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                LucideIcons.chevronDown,
                                color: isDark
                                    ? AppThemeV2.darkTextMuted
                                    : AppThemeV2.lightTextMuted,
                              ),
                            ),
                          ],
                        ),

                        // Expanded content
                        if (widget.isExpanded) ...[
                          const SizedBox(height: 16),
                          Divider(
                              height: 1,
                              color: isDark
                                  ? AppThemeV2.darkBorder
                                  : AppThemeV2.lightBorder),
                          const SizedBox(height: 16),
                          if (session.type == ComparisonType.git)
                            _FilePathRow(
                              label: 'Repository',
                              path: session.gitRepoPath ?? session.file1Path,
                              icon: LucideIcons.gitBranch,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          else if (isBilingualSession &&
                              session.type == ComparisonType.file)
                            _FilePathRow(
                              label: 'Bilingual file',
                              path: session.file1Path,
                              icon: LucideIcons.languages,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          else ...[
                            _FilePathRow(
                              label: session.type == ComparisonType.directory
                                  ? 'Source Dir'
                                  : 'Source',
                              path: session.file1Path,
                              icon: LucideIcons.fileInput,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 8),
                            _FilePathRow(
                              label: session.type == ComparisonType.directory
                                  ? 'Target Dir'
                                  : 'Target',
                              path: session.file2Path,
                              icon: LucideIcons.arrowRightLeft,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ],
                          const SizedBox(height: 16),

                          // Change Density Bar (visual ratio)
                          _ChangeDensityBar(
                            added: session.stringsAdded,
                            removed: session.stringsRemoved,
                            modified: session.stringsModified,
                          ),
                          const SizedBox(height: 16),

                          // Stats row detailed
                          Row(
                            children: [
                              if (session.stringsAdded > 0)
                                _StatChip(
                                  label: 'Added',
                                  count: session.stringsAdded,
                                  color: themeState.diffAddedColor,
                                  icon: LucideIcons.plusCircle,
                                ),
                              if (session.stringsRemoved > 0)
                                _StatChip(
                                  label: 'Removed',
                                  count: session.stringsRemoved,
                                  color: themeState.diffRemovedColor,
                                  icon: LucideIcons.minusCircle,
                                ),
                              if (session.stringsModified > 0)
                                _StatChip(
                                  label: 'Modified',
                                  count: session.stringsModified,
                                  color: themeState.diffModifiedColor,
                                  icon: LucideIcons.refreshCw,
                                ),
                              if (session.stringsIdentical > 0)
                                _StatChip(
                                  label: 'Same',
                                  count: session.stringsIdentical,
                                  color: neutralStatColor,
                                  icon: LucideIcons.checkCircle,
                                ),
                              if (totalStrings > 0)
                                _StatChip(
                                  label: 'Total',
                                  count: totalStrings,
                                  color: neutralStatColor,
                                  icon: LucideIcons.list,
                                ),
                              if (session.stringsAdded == 0 &&
                                  session.stringsRemoved == 0 &&
                                  session.stringsModified == 0)
                                Text(
                                  'No changes detected',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isDark
                                        ? AppThemeV2.darkTextMuted
                                        : AppThemeV2.lightTextMuted,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Actions row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: widget.onDelete,
                                icon: Icon(LucideIcons.trash2,
                                    size: 18, color: AppThemeV2.error),
                                label: Text('Delete',
                                    style: TextStyle(color: AppThemeV2.error)),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                ),
                              ),
                              const SizedBox(width: 8),
                              FilledButton.icon(
                                onPressed: widget.onView,
                                icon: const Icon(LucideIcons.eye, size: 18),
                                label: const Text('View Details'),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _buildFileTypeLabel(String file1Path, String file2Path) {
    final sourceType = _extensionLabel(file1Path);
    final targetType = _extensionLabel(file2Path);

    if (sourceType == null && targetType == null) {
      return null;
    }

    if (sourceType == null) {
      return targetType;
    }

    if (targetType == null) {
      return sourceType;
    }

    if (sourceType == targetType) {
      return sourceType;
    }

    return '$sourceType -> $targetType';
  }

  String? _extensionLabel(String path) {
    final fileName = path.split(Platform.pathSeparator).last;
    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == fileName.length - 1) {
      return null;
    }
    final ext = fileName.substring(dotIndex + 1).trim();
    if (ext.isEmpty) {
      return null;
    }
    return ext.toUpperCase();
  }
}

class _FilePathRow extends StatelessWidget {
  final String label;
  final String path;
  final IconData icon;
  final Color color;

  const _FilePathRow({
    required this.label,
    required this.path,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Extract parent folder and filename for better context
    final parts = path.split(Platform.pathSeparator);
    final fileName = parts.last;
    final parentFolder = parts.length > 1 ? parts[parts.length - 2] : '';
    final displayPath =
        parentFolder.isNotEmpty ? '.../$parentFolder/$fileName' : fileName;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: theme.textTheme.bodySmall?.copyWith(
            color:
                isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Tooltip(
            message: path,
            child: Text(
              displayPath,
              style: theme.textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        // Open Location button
        Tooltip(
          message: 'Open file location',
          child: IconButton(
            icon: Icon(
              LucideIcons.folderOpen,
              size: 16,
              color:
                  isDark ? AppThemeV2.darkTextMuted : AppThemeV2.lightTextMuted,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            onPressed: () => _openFileLocation(path),
          ),
        ),
      ],
    );
  }

  void _openFileLocation(String filePath) {
    final file = File(filePath);
    final directory = file.parent.path;
    if (Platform.isWindows) {
      Process.run('explorer.exe', [directory]);
    } else if (Platform.isMacOS) {
      Process.run('open', [directory]);
    } else if (Platform.isLinux) {
      Process.run('xdg-open', [directory]);
    }
  }
}

class _StatPill extends StatelessWidget {
  final int count;
  final Color color;
  final IconData icon;

  const _StatPill({
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final IconData icon;

  const _StatChip({
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            '$count $label',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _InfoChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Horizontal bar showing the ratio of added/removed/modified strings
class _ChangeDensityBar extends StatelessWidget {
  final int added;
  final int removed;
  final int modified;

  const _ChangeDensityBar({
    required this.added,
    required this.removed,
    required this.modified,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final total = added + removed + modified;

    if (total == 0) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 6,
        child: Row(
          children: [
            if (added > 0)
              Expanded(
                flex: added,
                child: Container(color: themeState.diffAddedColor),
              ),
            if (removed > 0)
              Expanded(
                flex: removed,
                child: Container(color: themeState.diffRemovedColor),
              ),
            if (modified > 0)
              Expanded(
                flex: modified,
                child: Container(color: themeState.diffModifiedColor),
              ),
          ],
        ),
      ),
    );
  }
}
