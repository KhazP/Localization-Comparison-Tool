import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:localizer_app_main/business_logic/blocs/git_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/common/diff_highlighter.dart';
import 'package:localizer_app_main/presentation/widgets/common/empty_state_common.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';

import 'package:localizer_app_main/presentation/views/conflict_resolution_view.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class GitComparisonView extends StatefulWidget {
  const GitComparisonView({super.key});

  @override
  State<GitComparisonView> createState() => _GitComparisonViewState();
}

class _GitComparisonViewState extends State<GitComparisonView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _fadeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = isDark &&
        settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    // AMOLED-aware helpers
    Color getCardColor() => isAmoled
        ? AppThemeV2.amoledCard
        : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard);
    Color getBorderColor() => isAmoled
        ? AppThemeV2.amoledBorder
        : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                children: [
                  Icon(LucideIcons.gitBranch,
                      size: 28, color: colorScheme.primary),
                  const SizedBox(width: 12),
                  Text(
                    'Repository Comparison',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // Repository Selector Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: getCardColor(),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: getBorderColor()),
              ),
              child: const _RepositorySelector(),
            ),
            const SizedBox(height: 24),
            // Main Content
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: getCardColor(),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: getBorderColor()),
                ),
                child: BlocListener<GitBloc, GitState>(
                  listener: (context, state) {
                    if (state is GitOperationSuccess) {
                      ToastService.showSuccess(context, state.message);
                      context.read<GitBloc>().add(LoadBranches());
                    } else if (state is GitError) {
                      ToastService.showError(context, state.message);
                      context.read<GitBloc>().add(LoadBranches());
                    }
                  },
                  child: BlocBuilder<GitBloc, GitState>(
                    buildWhen: (previous, current) {
                      return current is! GitOperationSuccess;
                    },
                    builder: (context, state) {
                      if (state is GitInitial) {
                        return _buildEmptyState(context);
                      } else if (state is GitLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is GitError) {
                        // For permanent errors
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(LucideIcons.alertCircle,
                                  color: theme.colorScheme.error, size: 48),
                              const SizedBox(height: 16),
                              Text('Error: ${state.message}',
                                  style:
                                      TextStyle(color: theme.colorScheme.error),
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 16),
                              FilledButton(
                                  onPressed: () => context
                                      .read<GitBloc>()
                                      .add(LoadBranches()),
                                  child: const Text('Retry'))
                            ],
                          ),
                        );
                      } else if (state is GitRepositorySelected) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is GitBranchesLoaded) {
                        return Column(
                          children: [
                            _RepoActionsToolbar(
                              repoPath: state.repoPath,
                              currentBranch: state.branches
                                  .firstWhere(
                                      (b) =>
                                          b.name == state.branches.first.name,
                                      orElse: () => GitBranch('Unknown', ''))
                                  .name,
                              branches: state.branches,
                            ),
                            const Divider(height: 1),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: _ComparisonControls(
                                  state: state,
                                  repoPath: state.repoPath,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (state is GitComparisonInProgress) {
                        return const Center(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text('Comparing...')
                            ]));
                      } else if (state is GitConflictsDetected) {
                        return ConflictResolutionView(
                          repoPath: state.repoPath,
                          conflictedFiles: state.conflictedFiles,
                        );
                      } else if (state is GitComparisonResult) {
                        return _ComparisonResultList(
                          diffFiles: state.diffFiles,
                          repoPath: state.repoPath,
                          base: state.base,
                          target: state.target,
                          mode: state.mode,
                          onBack: () =>
                              context.read<GitBloc>().add(LoadBranches()),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return EmptyStateContainer(
      icon: LucideIcons.gitBranch,
      title: 'Ready to Compare Repository',
      subtitle: 'Open a local Git repository to compare\nbranches or commits.',
      chips: const [
        ContextChip(
            label: 'Branch comparison', tooltip: 'Compare any two branches'),
        ContextChip(
            label: 'Commit history', tooltip: 'Compare specific commits'),
        ContextChip(
            label: 'Conflict detection',
            tooltip: 'Detect and resolve merge conflicts'),
      ],
      bottomSection: RecentComparisonsList(
        filterType: ComparisonType.git,
        onTap: _loadRecentGitComparison,
      ),
    );
  }

  void _loadRecentGitComparison(ComparisonSession session) {
    if (session.type != ComparisonType.git) {
      ToastService.showInfo(context, 'This is not a git comparison.');
      return;
    }

    final repoPath = session.gitRepoPath;
    if (repoPath == null || !Directory(repoPath).existsSync()) {
      ToastService.showError(
          context, 'Repository no longer exists at this path.');
      return;
    }

    // Open the repository
    context.read<GitBloc>().add(SelectRepository(repoPath));
  }
}

class _RepositorySelector extends StatelessWidget {
  const _RepositorySelector();

  Future<void> _pickRepository(BuildContext context) async {
    String? result = await FilePicker.platform.getDirectoryPath();
    if (result != null && context.mounted) {
      context.read<GitBloc>().add(SelectRepository(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<GitBloc, GitState>(
      builder: (context, state) {
        String currentPath = state.repoPath ?? 'No repository selected';
        bool hasRepo = state.repoPath != null;

        return Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(LucideIcons.gitFork,
                  color: theme.colorScheme.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create / Open Repository',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentPath,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppThemeV2.darkTextMuted
                          : AppThemeV2.lightTextMuted,
                      fontFamily: hasRepo ? 'monospace' : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            FilledButton.icon(
              onPressed: () => _pickRepository(context),
              icon: const Icon(LucideIcons.folderOpen, size: 18),
              label: const Text('Open'),
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ComparisonControls extends StatefulWidget {
  final GitBranchesLoaded state;
  final String repoPath;

  const _ComparisonControls({required this.state, required this.repoPath});

  @override
  State<_ComparisonControls> createState() => _ComparisonControlsState();
}

class _ComparisonControlsState extends State<_ComparisonControls> {
  // Branch Mode
  String? _baseBranch;
  String? _targetBranch;

  // Commit Mode
  String? _filterBranch;
  String? _baseCommitSha;
  String? _targetCommitSha;

  @override
  void initState() {
    super.initState();
    _initializeDefaults();
  }

  void _initializeDefaults() {
    if (widget.state.branches.isNotEmpty) {
      // Find main/master
      final mainBranch = widget.state.branches.firstWhere(
          (b) => b.name == 'main' || b.name == 'master',
          orElse: () => widget.state.branches.first);

      // Branch defaults
      _baseBranch = mainBranch.name;
      if (widget.state.branches.length > 1) {
        final other = widget.state.branches.firstWhere(
            (b) => b.name != _baseBranch,
            orElse: () => widget.state.branches.last);
        _targetBranch = other.name;
      } else {
        _targetBranch = _baseBranch;
      }

      // Commit defaults
      _filterBranch = mainBranch.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mode = widget.state.mode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mode Toggle
        Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SegmentedButton<ComparisonMode>(
              segments: const [
                ButtonSegment(
                  value: ComparisonMode.branch,
                  label: Text('Branch Comparison'),
                  icon: Icon(LucideIcons.gitBranch),
                ),
                ButtonSegment(
                  value: ComparisonMode.commit,
                  label: Text('Commit Comparison'),
                  icon: Icon(LucideIcons.history),
                ),
              ],
              selected: {mode},
              onSelectionChanged: (newSelection) {
                context
                    .read<GitBloc>()
                    .add(SwitchComparisonMode(newSelection.first));
              },
              style: ButtonStyle(
                visualDensity: VisualDensity.comfortable,
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        if (mode == ComparisonMode.branch)
          _buildBranchControls(context)
        else
          _buildCommitControls(context),

        const SizedBox(height: 32),
        // Compare Action Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: FilledButton.icon(
            onPressed: _canCompare() ? _performCompare : null,
            icon: const Icon(LucideIcons.arrowRightLeft),
            label: const Text('Compare',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  bool _canCompare() {
    if (widget.state.mode == ComparisonMode.branch) {
      return _baseBranch != null &&
          _targetBranch != null &&
          _baseBranch != _targetBranch;
    } else {
      return _baseCommitSha != null &&
          _targetCommitSha != null &&
          _baseCommitSha != _targetCommitSha;
    }
  }

  void _performCompare() {
    final bloc = context.read<GitBloc>();
    if (widget.state.mode == ComparisonMode.branch) {
      bloc.add(CompareBranches(_baseBranch!, _targetBranch!));
    } else {
      bloc.add(CompareCommits(_baseCommitSha!, _targetCommitSha!));
    }
  }

  Widget _buildBranchControls(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _baseBranch,
                decoration: const InputDecoration(
                  labelText: 'Base Branch',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                items: widget.state.branches
                    .map((b) => DropdownMenuItem(
                          value: b.name,
                          child: Row(
                            children: [
                              Icon(LucideIcons.gitBranch,
                                  size: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                              const SizedBox(width: 8),
                              Text(b.name),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() => _baseBranch = val);
                },
              ),
            ),
            const SizedBox(width: 16),
            Icon(LucideIcons.arrowRightLeft,
                size: 20, color: Theme.of(context).colorScheme.outline),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _targetBranch,
                decoration: const InputDecoration(
                  labelText: 'Target Branch',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                items: widget.state.branches
                    .map((b) => DropdownMenuItem(
                          value: b.name,
                          child: Row(
                            children: [
                              Icon(LucideIcons.gitBranch,
                                  size: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                              const SizedBox(width: 8),
                              Text(b.name),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() => _targetBranch = val);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildCommitControls(BuildContext context) {
    final commits = widget.state.commits;
    final isLoading = widget.state.isLoadingCommits;

    return Column(
      children: [
        // Filter by Branch
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _filterBranch,
                decoration: const InputDecoration(
                  labelText: 'Filter Commits by Branch',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                items: widget.state.branches
                    .map((b) => DropdownMenuItem(
                          value: b.name,
                          child: Text(b.name),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() => _filterBranch = val);
                  if (val != null) {
                    context.read<GitBloc>().add(LoadCommits(branchName: val));
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            if (isLoading)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              )
            else
              IconButton(
                icon: const Icon(LucideIcons.refreshCcw),
                onPressed: () => context
                    .read<GitBloc>()
                    .add(LoadCommits(branchName: _filterBranch)),
                tooltip: 'Refresh Commits',
              ),
          ],
        ),
        const SizedBox(height: 24),

        if (commits.isEmpty && !isLoading)
          const Text(
            'No commits found or loaded. '
            'Select a branch to load commits.',
          ),

        if (commits.isNotEmpty) ...[
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _baseCommitSha,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Base Commit (Older)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  items: _buildCommitItems(context, commits),
                  selectedItemBuilder: (ctx) =>
                      _buildSelectedCommitItems(ctx, commits),
                  onChanged: (val) {
                    setState(() => _baseCommitSha = val);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Icon(LucideIcons.arrowRightLeft,
                  size: 20, color: Theme.of(context).colorScheme.outline),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _targetCommitSha,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Target Commit (Newer)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  items: _buildCommitItems(context, commits),
                  selectedItemBuilder: (ctx) =>
                      _buildSelectedCommitItems(ctx, commits),
                  onChanged: (val) {
                    setState(() => _targetCommitSha = val);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ]
      ],
    );
  }

  void _swapCommits() {
    if (_baseCommitSha == null || _targetCommitSha == null) {
      return;
    }
    setState(() {
      final swapped = _baseCommitSha;
      _baseCommitSha = _targetCommitSha;
      _targetCommitSha = swapped;
    });
  }

  void _swapBranches() {
    if (_baseBranch == null || _targetBranch == null) {
      return;
    }
    setState(() {
      final swapped = _baseBranch;
      _baseBranch = _targetBranch;
      _targetBranch = swapped;
    });
  }

  List<DropdownMenuItem<String>> _buildCommitItems(
    BuildContext context,
    List<GitCommit> commits,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('MMM d, yyyy');

    return commits
        .map((commit) => DropdownMenuItem(
              value: commit.sha,
              child: Row(
                children: [
                  Icon(LucideIcons.gitCommit,
                      size: 16, color: colorScheme.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commit.message.split('\n').first,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${commit.author} • ${dateFormat.format(commit.date)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
        .toList();
  }

  List<Widget> _buildSelectedCommitItems(
    BuildContext context,
    List<GitCommit> commits,
  ) {
    return commits.map((commit) {
      return Text(
        '${commit.sha.substring(0, 7)} - ${commit.message.split('\n').first}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }).toList();
  }
}

class _RepoActionsToolbar extends StatelessWidget {
  final String repoPath;
  final String currentBranch;
  final List<GitBranch> branches;

  const _RepoActionsToolbar({
    required this.repoPath,
    required this.currentBranch,
    required this.branches,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppThemeV2.darkSurface : AppThemeV2.lightSurface,
        border: Border(
            bottom: BorderSide(
                color: isDark
                    ? AppThemeV2.darkBorderSubtle
                    : AppThemeV2.lightBorderSubtle)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.gitBranch, size: 20, color: colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            'Actions:',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 24),
          _ActionButton(
            icon: LucideIcons.cornerUpRight,
            label: 'Checkout',
            onPressed: () => _showCheckoutDialog(context),
          ),
          const SizedBox(width: 12),
          _ActionButton(
            icon: LucideIcons.merge,
            label: 'Merge',
            onPressed: () => _showMergeDialog(context),
          ),
          const SizedBox(width: 12),
          _ActionButton(
            icon: LucideIcons.download,
            label: 'Pull',
            onPressed: () => context.read<GitBloc>().add(PullChanges()),
          ),
        ],
      ),
    );
  }

  // ... dialog methods (unchanged) ...
  void _showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _BranchSelectionDialog(
        title: 'Checkout Branch',
        branches: branches,
        onSelected: (branchName) {
          context.read<GitBloc>().add(CheckoutBranch(branchName));
        },
      ),
    );
  }

  void _showMergeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _BranchSelectionDialog(
        title: 'Merge Branch into Current',
        branches: branches,
        excludeBranch: currentBranch, // Can't merge self
        onSelected: (branchName) {
          // Confirm merge
          showDialog(
              context: context,
              builder: (c) => AlertDialog(
                    title: Text('Merge $branchName?'),
                    content: const Text(
                        'This will merge changes into your current working branch. Conflicts may occur.'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(c),
                          child: const Text('Cancel')),
                      FilledButton(
                          onPressed: () {
                            Navigator.pop(c);
                            context
                                .read<GitBloc>()
                                .add(MergeBranch(branchName));
                          },
                          child: const Text('Merge')),
                    ],
                  ));
        },
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: isDark ? Colors.white : Colors.black,
        side: BorderSide(
          color: isDark
              ? AppThemeV2.darkBorderSubtle
              : AppThemeV2.lightBorderSubtle,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class _BranchSelectionDialog extends StatelessWidget {
  final String title;
  final List<GitBranch> branches;
  final Function(String) onSelected;
  final String? excludeBranch;

  const _BranchSelectionDialog({
    required this.title,
    required this.branches,
    required this.onSelected,
    this.excludeBranch,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = branches.where((b) => b.name != excludeBranch).toList();

    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 300,
        height: 300,
        child: ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final branch = filtered[index];
            return ListTile(
              title: Text(branch.name),
              leading: const Icon(LucideIcons.code),
              onTap: () {
                Navigator.pop(context);
                onSelected(branch.name);
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
      ],
    );
  }
}

class _ComparisonResultList extends StatefulWidget {
  final List<GitDiffFile> diffFiles;
  final String repoPath;
  final String base;
  final String target;
  final ComparisonMode mode;
  final VoidCallback onBack;

  const _ComparisonResultList(
      {required this.diffFiles,
      required this.repoPath,
      required this.base,
      required this.target,
      required this.mode,
      required this.onBack});

  @override
  State<_ComparisonResultList> createState() => _ComparisonResultListState();
}

class _ComparisonResultListState extends State<_ComparisonResultList> {
  // Export State
  bool _isExporting = false;
  int _exportedCount = 0;
  int _totalToExport = 0;
  String? _currentExportFile;
  StateSetter? _exportDialogSetState;

  Future<void> _exportResults() async {
    // Get settings for export format
    final settingsState = context.read<SettingsBloc>().state;
    final exportFormat = settingsState.status == SettingsStatus.loaded
        ? settingsState.appSettings.defaultExportFormat.toLowerCase()
        : 'csv';
    final includeUtf8Bom = settingsState.status == SettingsStatus.loaded
        ? settingsState.appSettings.includeUtf8Bom
        : true;
    final openFolderAfterExport = settingsState.status == SettingsStatus.loaded
        ? settingsState.appSettings.openFolderAfterExport
        : true;

    // Get GitService from context
    final gitBloc = context.read<GitBloc>();

    // 1. Ask user for directory
    final exportPath = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select Export Folder',
    );

    if (exportPath == null) return;

    // 2. Create timestamped folder with subfolders
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final exportDir = Directory('$exportPath/git_export_$timestamp');
    final filesDir = Directory('${exportDir.path}/files');

    try {
      await exportDir.create(recursive: true);
      await filesDir.create(recursive: true);
    } catch (e) {
      if (mounted) {
        ToastService.showError(context, 'Failed to create export folder: $e');
      }
      return;
    }

    setState(() {
      _isExporting = true;
      _exportedCount = 0;
      _totalToExport = widget.diffFiles.length;
      _currentExportFile = null;
    });

    // Show progress dialog
    if (mounted) {
      _showExportProgressDialog();
    }

    try {
      // Build enriched data
      final now = DateTime.now();
      final repoName = p.basename(widget.repoPath);

      // Calculate totals
      int totalAdditions = 0;
      int totalDeletions = 0;
      for (var file in widget.diffFiles) {
        totalAdditions += file.additions;
        totalDeletions += file.deletions;
      }

      // Export individual file diffs
      for (int i = 0; i < widget.diffFiles.length; i++) {
        final file = widget.diffFiles[i];
        final fileName = p.basename(file.path);

        setState(() {
          _exportedCount = i;
          _currentExportFile = fileName;
        });
        _refreshExportDialog();

        try {
          // Fetch base and target versions
          final baseContent = await gitBloc.gitService.getFileContentAtBranch(
            widget.repoPath,
            widget.base,
            file.path,
          );
          final targetContent = await gitBloc.gitService.getFileContentAtBranch(
            widget.repoPath,
            widget.target,
            file.path,
          );

          // Create diff content
          final diffContent = StringBuffer();
          diffContent
              .writeln('--- a/${file.path} (${_truncateRef(widget.base)})');
          diffContent
              .writeln('+++ b/${file.path} (${_truncateRef(widget.target)})');
          diffContent.writeln('');
          diffContent.writeln('Status: ${file.status.toUpperCase()}');
          diffContent.writeln('Additions: +${file.additions}');
          diffContent.writeln('Deletions: -${file.deletions}');
          diffContent.writeln('');
          diffContent.writeln('=' * 60);
          diffContent.writeln('BASE VERSION (${_truncateRef(widget.base)}):');
          diffContent.writeln('=' * 60);
          diffContent.writeln(baseContent.isEmpty
              ? '(File does not exist in base)'
              : baseContent);
          diffContent.writeln('');
          diffContent.writeln('=' * 60);
          diffContent
              .writeln('TARGET VERSION (${_truncateRef(widget.target)}):');
          diffContent.writeln('=' * 60);
          diffContent.writeln(targetContent.isEmpty
              ? '(File does not exist in target)'
              : targetContent);

          // Write to file - sanitize filename
          final safeFileName =
              file.path.replaceAll('/', '_').replaceAll('\\', '_');
          final diffFile = File('${filesDir.path}/$safeFileName.diff');
          await diffFile.writeAsString(diffContent.toString());
        } catch (e) {
          // Log error but continue with other files
          debugPrint('Failed to export ${file.path}: $e');
        }
      }

      // Write summary files
      if (exportFormat == 'json') {
        // JSON Export
        final jsonData = {
          'metadata': {
            'repository': widget.repoPath,
            'repositoryName': repoName,
            'baseRef': widget.base,
            'targetRef': widget.target,
            'comparisonMode':
                widget.mode == ComparisonMode.commit ? 'commit' : 'branch',
            'exportedAt': now.toIso8601String(),
            'totalFiles': widget.diffFiles.length,
            'totalAdditions': totalAdditions,
            'totalDeletions': totalDeletions,
          },
          'changes': widget.diffFiles
              .map((file) => {
                    'path': file.path,
                    'status': file.status,
                    'additions': file.additions,
                    'deletions': file.deletions,
                    'totalChanges': file.additions + file.deletions,
                    'diffFile':
                        'files/${file.path.replaceAll('/', '_').replaceAll('\\', '_')}.diff',
                  })
              .toList(),
        };

        final jsonString = const JsonEncoder.withIndent('  ').convert(jsonData);
        final jsonFile = File('${exportDir.path}/_summary.json');
        await jsonFile.writeAsString(jsonString);
      } else {
        // CSV Export
        final csvData = <List<dynamic>>[
          [
            'File Path',
            'Status',
            'Additions',
            'Deletions',
            'Total Changes',
            'Diff File'
          ],
        ];

        for (var file in widget.diffFiles) {
          final safeFileName =
              file.path.replaceAll('/', '_').replaceAll('\\', '_');
          csvData.add([
            file.path,
            file.status,
            file.additions,
            file.deletions,
            file.additions + file.deletions,
            'files/$safeFileName.diff',
          ]);
        }

        // Add summary row
        csvData.add([]);
        csvData.add([
          'TOTAL',
          '',
          totalAdditions,
          totalDeletions,
          totalAdditions + totalDeletions,
          ''
        ]);
        csvData.add([]);
        csvData.add(['Repository', repoName]);
        csvData.add(['Base Ref', widget.base]);
        csvData.add(['Target Ref', widget.target]);
        csvData.add(['Exported At', now.toIso8601String()]);

        final csvString = const ListToCsvConverter().convert(csvData);
        final csvFile = File('${exportDir.path}/_summary.csv');
        final prefix = includeUtf8Bom ? '\uFEFF' : '';
        await csvFile.writeAsString('$prefix$csvString');
      }

      setState(() {
        _exportedCount = widget.diffFiles.length;
        _currentExportFile = null;
      });
      _refreshExportDialog();

      // Close progress dialog and show success
      if (mounted) {
        _exportDialogSetState = null;
        Navigator.of(context).pop();
        _showExportCompleteDialog(
            exportDir.path, widget.diffFiles.length, openFolderAfterExport);
      }
    } catch (e) {
      if (mounted) {
        _exportDialogSetState = null;
        Navigator.of(context).pop();
        ToastService.showError(context, 'Export failed: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isExporting = false;
          _exportedCount = 0;
          _totalToExport = 0;
          _currentExportFile = null;
        });
      }
    }
  }

  void _refreshExportDialog() {
    _exportDialogSetState?.call(() {});
  }

  void _showExportProgressDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            _exportDialogSetState = setDialogState;
            final theme = Theme.of(context);
            final isDark = theme.brightness == Brightness.dark;

            return AlertDialog(
              title: Row(
                children: [
                  Icon(LucideIcons.download, color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  const Text('Exporting Files'),
                ],
              ),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_currentExportFile != null)
                      Text(
                        'Processing: $_currentExportFile',
                        style: theme.textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: _totalToExport > 0
                          ? _exportedCount / _totalToExport
                          : null,
                      backgroundColor: isDark
                          ? AppThemeV2.darkBorder
                          : AppThemeV2.lightBorder,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.primary),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$_exportedCount of $_totalToExport files exported',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppThemeV2.darkTextMuted
                            : AppThemeV2.lightTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showExportCompleteDialog(
      String exportPath, int fileCount, bool showOpenFolder) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(LucideIcons.checkCircle, color: Colors.green.shade400),
              const SizedBox(width: 12),
              const Text('Export Complete'),
            ],
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Successfully exported $fileCount files with full content.'),
                const SizedBox(height: 8),
                Text(
                  'Each file\'s diff is saved in the "files" subfolder.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppThemeV2.darkTextMuted
                        : AppThemeV2.lightTextMuted,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppThemeV2.darkSurface
                        : AppThemeV2.lightSurface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark
                          ? AppThemeV2.darkBorder
                          : AppThemeV2.lightBorder,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.folder,
                        size: 20,
                        color: isDark
                            ? AppThemeV2.darkTextMuted
                            : AppThemeV2.lightTextMuted,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          exportPath,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(fontFamily: 'monospace'),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            if (showOpenFolder)
              TextButton(
                onPressed: () {
                  // Use shell: true and proper Windows path format
                  final windowsPath = exportPath.replaceAll('/', '\\');
                  Process.run('explorer.exe', [windowsPath], runInShell: true);
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('Open Folder'),
              ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showDiffDialog(BuildContext context, String filePath) {
    showDialog(
      context: context,
      builder: (context) => _GitFileDiffDialog(
        repoPath: widget.repoPath,
        filePath: filePath,
        baseRef: widget.base,
        targetRef: widget.target,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Calculate stats for display
    int added = 0, modified = 0, deleted = 0;
    for (var file in widget.diffFiles) {
      switch (file.status) {
        case 'added':
          added++;
          break;
        case 'modified':
          modified++;
          break;
        case 'deleted':
          deleted++;
          break;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(
                onPressed: widget.onBack,
                icon: const Icon(LucideIcons.arrowLeft),
                tooltip: 'Back to comparison controls',
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Comparison Results',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${widget.mode == ComparisonMode.commit ? 'Commit' : 'Branch'}: "
                      "${_truncateRef(widget.base)} → ${_truncateRef(widget.target)}",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppThemeV2.darkTextMuted
                            : AppThemeV2.lightTextMuted,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Stats and Actions Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? AppThemeV2.darkSurface : AppThemeV2.lightSurface,
            border: Border(
              top: BorderSide(
                  color: isDark
                      ? AppThemeV2.darkBorderSubtle
                      : AppThemeV2.lightBorderSubtle),
              bottom: BorderSide(
                  color: isDark
                      ? AppThemeV2.darkBorderSubtle
                      : AppThemeV2.lightBorderSubtle),
            ),
          ),
          child: Row(
            children: [
              // Stats chips
              _StatChip(
                  icon: LucideIcons.plus,
                  label: 'Added',
                  count: added,
                  color: Colors.green),
              const SizedBox(width: 12),
              _StatChip(
                  icon: LucideIcons.pencil,
                  label: 'Modified',
                  count: modified,
                  color: Colors.orange),
              const SizedBox(width: 12),
              _StatChip(
                  icon: LucideIcons.minus,
                  label: 'Deleted',
                  count: deleted,
                  color: Colors.red),
              const Spacer(),
              // Export Button
              OutlinedButton.icon(
                onPressed: _isExporting ? null : _exportResults,
                icon: _isExporting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(LucideIcons.download, size: 18),
                label: Text(_isExporting ? 'Exporting...' : 'Export'),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: widget.diffFiles.isEmpty
              ? const Center(
                  child: Text('No changes found between selected refs.'))
              : ListView.builder(
                  itemCount: widget.diffFiles.length,
                  itemBuilder: (context, index) {
                    final file = widget.diffFiles[index];
                    final themeState = context.watch<ThemeBloc>().state;
                    final settingsState = context.watch<SettingsBloc>().state;

                    final isDark =
                        Theme.of(context).brightness == Brightness.dark;
                    final isAmoled = isDark &&
                        settingsState.status == SettingsStatus.loaded &&
                        settingsState.appSettings.appThemeMode.toLowerCase() ==
                            'amoled';

                    Color statusColor;
                    String statusLabel;

                    switch (file.status) {
                      case 'added':
                        statusColor = themeState.diffAddedColor;
                        statusLabel = 'Added';
                        break;
                      case 'deleted':
                        statusColor = themeState.diffRemovedColor;
                        statusLabel = 'Removed';
                        break;
                      case 'modified':
                        statusColor = themeState.diffModifiedColor;
                        statusLabel = 'Modified';
                        break;
                      case 'renamed':
                        statusColor = Colors.blue;
                        statusLabel = 'Renamed';
                        break;
                      default:
                        statusColor = Colors.grey;
                        statusLabel = file.status;
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: isAmoled
                            ? AppThemeV2.amoledSurface
                            : (isDark
                                ? AppThemeV2.darkSurface
                                : AppThemeV2.lightSurface),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isAmoled
                              ? AppThemeV2.amoledBorderSubtle
                              : (isDark
                                  ? AppThemeV2.darkBorderSubtle
                                  : AppThemeV2.lightBorderSubtle),
                        ),
                      ),
                      child: InkWell(
                        onTap: () => _showDiffDialog(context, file.path),
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Colored Status Strip
                              Container(
                                width: 4,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Status Icon
                              Icon(
                                file.status == 'added'
                                    ? LucideIcons.filePlus
                                    : (file.status == 'deleted'
                                        ? LucideIcons.fileMinus
                                        : LucideIcons.fileEdit),
                                size: 20,
                                color: statusColor,
                              ),
                              const SizedBox(width: 12),

                              // Path Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      file.path,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      statusLabel,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: statusColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),

                              // Stats
                              if (file.additions > 0) ...[
                                _GitStatChip(
                                  icon: LucideIcons.plus,
                                  count: file.additions,
                                  color: themeState.diffAddedColor,
                                  tooltip: 'Lines Added',
                                ),
                                const SizedBox(width: 8),
                              ],

                              if (file.deletions > 0) ...[
                                _GitStatChip(
                                  icon: LucideIcons.trash2,
                                  count: file.deletions,
                                  color: themeState.diffRemovedColor,
                                  tooltip: 'Lines Removed',
                                ),
                                const SizedBox(width: 8),
                              ],

                              // Modified indicator if we don't have line stats but it is modified?
                              // Actually, modified files always have adds/dels ideally.
                              // But if 0/0 and modified (e.g. rename or permission), show icon?
                              if (file.additions == 0 &&
                                  file.deletions == 0 &&
                                  file.status == 'modified')
                                _GitStatChip(
                                  icon: LucideIcons.pencil,
                                  count: 0,
                                  color: themeState.diffModifiedColor,
                                  tooltip: 'Modified',
                                ),

                              if (file.additions == 0 &&
                                  file.deletions == 0 &&
                                  file.status == 'modified')
                                const SizedBox(width: 8),

                              // View Button
                              TextButton.icon(
                                onPressed: () =>
                                    _showDiffDialog(context, file.path),
                                icon: const Icon(LucideIcons.eye, size: 16),
                                label: const Text('View'),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  String _truncateRef(String ref) {
    // If it's a commit SHA (40 chars hex), truncate to 7
    if (ref.length == 40 && RegExp(r'^[0-9a-fA-F]+$').hasMatch(ref)) {
      return ref.substring(0, 7);
    }
    // Otherwise return as-is (branch name)
    return ref;
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
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
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _GitStatChip extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color color;
  final String tooltip;

  const _GitStatChip({
    required this.icon,
    required this.count,
    required this.color,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
            Text(
              '$count',
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GitFileDiffDialog extends StatefulWidget {
  final String repoPath;
  final String filePath; // Initial file path
  final String baseRef;
  final String targetRef;

  const _GitFileDiffDialog({
    required this.repoPath,
    required this.filePath,
    required this.baseRef,
    required this.targetRef,
  });

  @override
  State<_GitFileDiffDialog> createState() => _GitFileDiffDialogState();
}

class _GitFileDiffDialogState extends State<_GitFileDiffDialog> {
  late String _baseFilePath;
  late String _targetFilePath;

  // File lists for picker
  List<String> _baseFiles = [];
  List<String> _targetFiles = [];
  bool _isLoadingFileList = true;

  // Content cache for diff
  String? _baseContent;
  String? _targetContent;
  bool _isLoadingContent = false;

  // Scroll controllers for synchronized scrolling
  final ScrollController _baseScrollController = ScrollController();
  final ScrollController _targetScrollController = ScrollController();
  bool _isSyncingScroll = false;

  // Filter states
  bool _showAdded = true;
  bool _showRemoved = true;
  bool _showModified =
      true; // Show modified by default for Git view as it is line-based

  @override
  void initState() {
    super.initState();
    _baseFilePath = widget.filePath;
    _targetFilePath = widget.filePath;

    // Setup scroll sync listeners
    _baseScrollController.addListener(_onBaseScroll);
    _targetScrollController.addListener(_onTargetScroll);

    _loadFileLists();
  }

  @override
  void dispose() {
    _baseScrollController.removeListener(_onBaseScroll);
    _targetScrollController.removeListener(_onTargetScroll);
    _baseScrollController.dispose();
    _targetScrollController.dispose();
    super.dispose();
  }

  void _onBaseScroll() {
    if (_isSyncingScroll) return;
    _isSyncingScroll = true;
    if (_targetScrollController.hasClients) {
      _targetScrollController.jumpTo(_baseScrollController.offset);
    }
    _isSyncingScroll = false;
  }

  void _onTargetScroll() {
    if (_isSyncingScroll) return;
    _isSyncingScroll = true;
    if (_baseScrollController.hasClients) {
      _baseScrollController.jumpTo(_targetScrollController.offset);
    }
    _isSyncingScroll = false;
  }

  Future<void> _loadFileLists() async {
    final gitService = context.read<GitBloc>().gitService;
    try {
      final results = await Future.wait([
        gitService.getFilesInCommit(widget.repoPath, widget.baseRef),
        gitService.getFilesInCommit(widget.repoPath, widget.targetRef),
      ]);

      if (mounted) {
        setState(() {
          _baseFiles = results[0]..sort();
          _targetFiles = results[1]..sort();
          _isLoadingFileList = false;
        });
        _loadContent();
      }
    } catch (e) {
      debugPrint('Error loading file lists: $e');
      if (mounted) {
        setState(() => _isLoadingFileList = false);
      }
    }
  }

  Future<void> _loadContent() async {
    if (_isLoadingContent) return;
    setState(() => _isLoadingContent = true);

    final gitService = context.read<GitBloc>().gitService;
    try {
      final results = await Future.wait([
        gitService.getFileContentAtBranch(
            widget.repoPath, widget.baseRef, _baseFilePath),
        gitService.getFileContentAtBranch(
            widget.repoPath, widget.targetRef, _targetFilePath),
      ]);

      if (mounted) {
        setState(() {
          _baseContent = results[0];
          _targetContent = results[1];
          _isLoadingContent = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading content: $e');
      if (mounted) {
        setState(() => _isLoadingContent = false);
      }
    }
  }

  void _showSearchableFilePicker(BuildContext context, {required bool isBase}) {
    final files = isBase ? _baseFiles : _targetFiles;
    final currentFile = isBase ? _baseFilePath : _targetFilePath;

    showDialog(
      context: context,
      builder: (ctx) => _SearchableFilePickerDialog(
        files: files,
        currentFile: currentFile,
        title: isBase ? 'Select Base File' : 'Select Target File',
        onSelected: (file) {
          setState(() {
            if (isBase) {
              _baseFilePath = file;
            } else {
              _targetFilePath = file;
            }
          });
          _loadContent();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeState = context.watch<ThemeBloc>().state;

    // Process content for diff
    final baseLinesRaw = (_baseContent ?? '').split('\n');
    final targetLinesRaw = (_targetContent ?? '').split('\n');
    final maxLines = baseLinesRaw.length > targetLinesRaw.length
        ? baseLinesRaw.length
        : targetLinesRaw.length;

    final sourceLines = <_DiffLine>[];
    final targetLines = <_DiffLine>[];

    int addedCount = 0;
    int removedCount = 0;
    int modifiedCount = 0;

    // First pass to count stats and build raw lines
    for (int i = 0; i < maxLines; i++) {
      final baseLine = i < baseLinesRaw.length ? baseLinesRaw[i] : null;
      final targetLine = i < targetLinesRaw.length ? targetLinesRaw[i] : null;

      _LineStatus status = _LineStatus.unchanged;

      if (baseLine != targetLine) {
        if (baseLine == null && targetLine != null) {
          status = _LineStatus.added;
          addedCount++;
        } else if (baseLine != null && targetLine == null) {
          status = _LineStatus.removed;
          removedCount++;
        } else {
          status = _LineStatus.modified;
          modifiedCount++;
        }
      }

      // Apply filters
      bool show = false;
      switch (status) {
        case _LineStatus.added:
          show = _showAdded;
          break;
        case _LineStatus.removed:
          show = _showRemoved;
          break;
        case _LineStatus.modified:
          show = _showModified;
          break;
        case _LineStatus.unchanged:
          show =
              true; // Always show unchanged for context in Git view? Or maybe filter?
          // For now, let's keep unchanged typically visible, but maybe not if focusing on diffs.
          // Actually, Git diffs usually show context.
          break;
        default:
          break;
      }

      // Slight deviation from ComparisonDialog: Git view is context-heavy.
      // If we strictly hide "Unchanged", it becomes unreadable code.
      // But for consistency with the other dialog, we'll keep the badging/filtering visual.
      // Let's assume we show everything but use filters to 'highlight' or 'jump'?
      // Wait, the user asked for *filtering* behavior.
      // In the other dialog, we hide the rows.
      // In code diff, hiding unchanged rows makes it a patch view.
      // Let's apply valid filtering.

      if (!show &&
          status != _LineStatus.unchanged &&
          status != _LineStatus.empty) {
        // If it's a change status that is filtered OUT, we skip it?
        // It's safer to just build the list and then render?
        continue;
      }

      sourceLines.add(_DiffLine(
        lineNumber: i + 1,
        content: baseLine ?? '',
        status: status == _LineStatus.added
            ? _LineStatus.empty
            : (status == _LineStatus.removed
                ? _LineStatus.removed
                : (status == _LineStatus.modified
                    ? _LineStatus.modified
                    : _LineStatus.unchanged)),
        sourceContent: baseLine ?? '',
        targetContent: targetLine ?? '',
      ));

      targetLines.add(_DiffLine(
        lineNumber: i + 1,
        content: targetLine ?? '',
        status: status == _LineStatus.removed
            ? _LineStatus.empty
            : (status == _LineStatus.added
                ? _LineStatus.added
                : (status == _LineStatus.modified
                    ? _LineStatus.modified
                    : _LineStatus.unchanged)),
        sourceContent: baseLine ?? '',
        targetContent: targetLine ?? '',
      ));
    }

    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: SizedBox(
        width: 1400,
        height: 850,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Diff Viewer', style: theme.textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Branch Info
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                                '${widget.baseRef.substring(0, 7)} (Base)  →  ${widget.targetRef.substring(0, 7)} (Target)',
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(fontFamily: 'monospace')),
                          ),
                          const SizedBox(width: 16),

                          // Filters
                          _FilterBadge(
                            icon: LucideIcons.plus,
                            count: addedCount,
                            color: themeState.diffAddedColor,
                            label: 'Added',
                            isActive: _showAdded,
                            onTap: () =>
                                setState(() => _showAdded = !_showAdded),
                          ),
                          const SizedBox(width: 8),
                          _FilterBadge(
                            icon: LucideIcons.trash2,
                            count: removedCount,
                            color: themeState.diffRemovedColor,
                            label: 'Removed',
                            isActive: _showRemoved,
                            onTap: () =>
                                setState(() => _showRemoved = !_showRemoved),
                          ),
                          const SizedBox(width: 8),
                          _FilterBadge(
                            icon: LucideIcons.pencil,
                            count: modifiedCount,
                            color: themeState.diffModifiedColor,
                            label: 'Modified',
                            isActive: _showModified,
                            onTap: () =>
                                setState(() => _showModified = !_showModified),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close)),
                ],
              ),
            ),
            const Divider(height: 1),

            // Content
            Expanded(
              child: _isLoadingFileList || _isLoadingContent
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Base Side
                        Expanded(
                          child: Column(
                            children: [
                              _buildFileSelectorButton(context, isBase: true),
                              Expanded(
                                  child: _buildDiffPane(sourceLines, true,
                                      themeState, _baseScrollController)),
                            ],
                          ),
                        ),
                        Container(width: 1, color: theme.dividerColor),
                        // Target Side
                        Expanded(
                          child: Column(
                            children: [
                              _buildFileSelectorButton(context, isBase: false),
                              Expanded(
                                  child: _buildDiffPane(targetLines, false,
                                      themeState, _targetScrollController)),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileSelectorButton(BuildContext context,
      {required bool isBase}) {
    final theme = Theme.of(context);
    final files = isBase ? _baseFiles : _targetFiles;
    final path = isBase ? _baseFilePath : _targetFilePath;
    final fileExists = files.contains(path);

    return Material(
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: InkWell(
        onTap: () => _showSearchableFilePicker(context, isBase: isBase),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                  isBase
                      ? Icons.file_copy_outlined
                      : Icons.file_present_outlined,
                  size: 18),
              const SizedBox(width: 8),
              Text(isBase ? 'BASE' : 'TARGET',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      letterSpacing: 0.5)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  path,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: fileExists
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.error,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_drop_down,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiffPane(List<_DiffLine> lines, bool isBase,
      AppThemeState themeState, ScrollController scrollController) {
    if (lines.isEmpty) {
      return const Center(child: Text("No lines to display"));
    }

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

    // Colors
    final addedColor = themeState.diffAddedColor;
    final removedColor = themeState.diffRemovedColor;
    final modifiedColor = themeState.diffModifiedColor;

    return Row(
      children: [
        // Main content ListView
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.all(8),
            itemCount: lines.length,
            itemBuilder: (context, index) {
              final line = lines[index];
              Color? bgColor;
              switch (line.status) {
                case _LineStatus.added:
                  bgColor = addedColor.withValues(alpha: 0.25);
                  break;
                case _LineStatus.removed:
                  bgColor = removedColor.withValues(alpha: 0.25);
                  break;
                case _LineStatus.modified:
                  bgColor = modifiedColor.withValues(alpha: 0.25);
                  break;
                case _LineStatus.empty:
                  bgColor = Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withValues(alpha: 0.3);
                  break;
                case _LineStatus.unchanged:
                  bgColor = null;
                  break;
              }

              return Container(
                color: bgColor,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        '${line.lineNumber}',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: fontSize,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                    Expanded(
                      child: line.content.isEmpty
                          ? Text(
                              ' ',
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: fontSize,
                                fontStyle: FontStyle.italic,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.3),
                              ),
                            )
                          : (line.status == _LineStatus.modified &&
                                  line.sourceContent != null &&
                                  line.targetContent != null)
                              ? DiffHighlighter.buildDiffText(
                                  line.sourceContent!,
                                  line.targetContent!,
                                  isSource: isBase,
                                  baseStyle: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: fontSize,
                                  ),
                                  deletionColor: removedColor,
                                  insertionColor: addedColor,
                                  selectable: true,
                                )
                              : SelectableText(
                                  line.content,
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: fontSize,
                                    fontStyle: line.status == _LineStatus.empty
                                        ? FontStyle.italic
                                        : null,
                                    color: line.status == _LineStatus.empty
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withValues(alpha: 0.3)
                                        : null,
                                  ),
                                ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Minimap / Overview Bar (Reused Logic)
        Container(
          width: 12,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final totalHeight = constraints.maxHeight;
              final totalLines = lines.length;

              if (totalLines == 0) return const SizedBox.shrink();

              return CustomPaint(
                size: Size(12, totalHeight),
                painter: _MinimapPainter(
                  lines: lines,
                  totalLines: totalLines,
                  addedColor: addedColor,
                  removedColor: removedColor,
                  modifiedColor: modifiedColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Reusing helper classes to ensure consistency
enum _LineStatus {
  unchanged,
  added,
  removed,
  modified,
  empty,
}

class _DiffLine {
  final int lineNumber;
  final String content;
  final _LineStatus status;
  final String? sourceContent;
  final String? targetContent;

  _DiffLine({
    required this.lineNumber,
    required this.content,
    required this.status,
    this.sourceContent,
    this.targetContent,
  });
}

class _FilterBadge extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color color;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterBadge({
    required this.icon,
    required this.count,
    required this.color,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final activeColor = color;
    final inactiveColor = isDark
        ? AppThemeV2.darkTextMuted.withValues(alpha: 0.5)
        : AppThemeV2.lightTextMuted.withValues(alpha: 0.5);

    final displayColor = isActive ? activeColor : inactiveColor;

    return Tooltip(
      message:
          '$label: $count${isActive ? ' (click to hide)' : ' (click to show)'}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: displayColor.withValues(alpha: isActive ? 0.2 : 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: displayColor.withValues(alpha: isActive ? 0.5 : 0.2),
                width: isActive ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 14, color: displayColor),
                const SizedBox(width: 6),
                Text(
                  '$count',
                  style: TextStyle(
                    color: displayColor,
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom painter for the minimap/overview bar
class _MinimapPainter extends CustomPainter {
  final List<_DiffLine> lines;
  final int totalLines;
  final Color addedColor;
  final Color removedColor;
  final Color modifiedColor;

  _MinimapPainter({
    required this.lines,
    required this.totalLines,
    required this.addedColor,
    required this.removedColor,
    required this.modifiedColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (totalLines == 0) return;

    final lineHeight = size.height / totalLines;
    const minHeight = 2.0;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      Color? color;

      switch (line.status) {
        case _LineStatus.added:
          color = addedColor;
          break;
        case _LineStatus.removed:
          color = removedColor;
          break;
        case _LineStatus.modified:
          color = modifiedColor;
          break;
        default:
          continue;
      }

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      final y = (i / totalLines) * size.height;
      final h = lineHeight < minHeight ? minHeight : lineHeight;

      canvas.drawRect(
        Rect.fromLTWH(0, y, size.width, h),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MinimapPainter oldDelegate) {
    return lines != oldDelegate.lines || totalLines != oldDelegate.totalLines;
  }
}

// Searchable File Picker Dialog
class _SearchableFilePickerDialog extends StatefulWidget {
  final List<String> files;
  final String currentFile;
  final String title;
  final ValueChanged<String> onSelected;

  const _SearchableFilePickerDialog({
    required this.files,
    required this.currentFile,
    required this.title,
    required this.onSelected,
  });

  @override
  State<_SearchableFilePickerDialog> createState() =>
      _SearchableFilePickerDialogState();
}

class _SearchableFilePickerDialogState
    extends State<_SearchableFilePickerDialog> {
  late TextEditingController _searchController;
  late List<String> _filteredFiles;
  String? _selectedFile;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredFiles = widget.files;
    _selectedFile = widget.currentFile;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterFiles(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredFiles = widget.files;
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredFiles = widget.files
            .where((f) => f.toLowerCase().contains(lowerQuery))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: SizedBox(
        width: 600,
        height: 500,
        child: Column(
          children: [
            // Header with Search
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search files...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                    onChanged: _filterFiles,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // File List
            Expanded(
              child: _filteredFiles.isEmpty
                  ? Center(
                      child: Text('No files match "$_searchController.text"',
                          style: TextStyle(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.6))))
                  : ListView.builder(
                      itemCount: _filteredFiles.length,
                      itemBuilder: (context, index) {
                        final file = _filteredFiles[index];
                        final isSelected = file == _selectedFile;

                        return ListTile(
                          dense: true,
                          selected: isSelected,
                          selectedTileColor: theme.colorScheme.primaryContainer
                              .withValues(alpha: 0.3),
                          leading: Icon(Icons.insert_drive_file_outlined,
                              size: 18,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.6)),
                          title: Text(file,
                              style: const TextStyle(
                                  fontFamily: 'monospace', fontSize: 12)),
                          onTap: () {
                            widget.onSelected(file);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
            ),
            // Footer
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${_filteredFiles.length} files',
                      style: theme.textTheme.bodySmall),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
