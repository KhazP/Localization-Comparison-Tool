import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:localizer_app_main/business_logic/blocs/git_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';

import 'package:localizer_app_main/presentation/views/conflict_resolution_view.dart';

class GitView extends StatelessWidget {
  const GitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Git Integration',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          // Repository Selection Area
          const _RepositorySelector(),
          const Divider(height: 32),
          // Main Content Area (Branches, Diff)
          // Main Content Area (Branches, Diff)
          Expanded(
            child: BlocListener<GitBloc, GitState>(
              listener: (context, state) {
                if (state is GitOperationSuccess) {
                  ToastService.showSuccess(context, state.message);
                  // Auto-reload after success.
                  context.read<GitBloc>().add(LoadBranches());
                } else if (state is GitError) {
                   ToastService.showError(context, state.message);
                  // Attempt to recover state if possible, or stay in Error if it's fatal.
                  // If it was a transient error (like Pull failed), we might want to go back to Loaded?
                  // For now, let's try to reload branches to see if we can recover the view.
                  context.read<GitBloc>().add(LoadBranches());
                }
              },
              child: BlocBuilder<GitBloc, GitState>(
                buildWhen: (previous, current) {
                  // Don't rebuild basic UI for transient states if we want to keep the view visible behind the toast
                  // But our states ARE mutually exclusive in this Bloc.
                  // So we DO need to handle building.
                  return current is! GitOperationSuccess; 
                },
                builder: (context, state) {
                  if (state is GitInitial) {
                    return const Center(child: Text('Select a repository to begin.'));
                  } else if (state is GitLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GitError) {
                    // If error is permanent (like repo load fail), show it.
                    // If transient (pull fail), the listener handled it and we triggered reload.
                    // But until reload finishes, what do we show?
                    // Let's show the error properly here too if it persists.
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error, size: 48),
                          const SizedBox(height: 16),
                          Text('Error: ${state.message}', style: TextStyle(color: Theme.of(context).colorScheme.error), textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          FilledButton(onPressed: () => context.read<GitBloc>().add(LoadBranches()), child: const Text('Retry'))
                        ],
                      ),
                    );
                  } else if (state is GitRepositorySelected) {
                    return const Center(child: CircularProgressIndicator()); 
                  } else if (state is GitBranchesLoaded) {
                  return Column(
                    children: [
                      // Action Bar (New)
                      _RepoActionsToolbar(
                        repoPath: state.repoPath,
                        currentBranch: state.branches.firstWhere((b) => b.name == state.branches.first.name, orElse: () => GitBranch('Unknown', '')).name, // Logic improved below
                        branches: state.branches,
                      ),
                      const Divider(),
                      Expanded(
                        child: _ComparisonControls(
                          state: state,
                          repoPath: state.repoPath,
                        ),
                      ),
                    ],
                  );
                } else if (state is GitComparisonInProgress) {
                   return const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [CircularProgressIndicator(), SizedBox(height: 16), Text('Comparing...')]));
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
                    onBack: () => context.read<GitBloc>().add(LoadBranches()), // Will load from cache
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        ],
      ),
    );
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
    return BlocBuilder<GitBloc, GitState>(
      builder: (context, state) {
        String currentPath = state.repoPath ?? 'No repository selected';
        
        return Row(
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickRepository(context),
              icon: const Icon(Icons.folder_open),
              label: const Text('Open Repository'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Current Repo: $currentPath',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
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
        orElse: () => widget.state.branches.first
      );
      
      // Branch defaults
      _baseBranch = mainBranch.name;
      if (widget.state.branches.length > 1) {
         final other = widget.state.branches.firstWhere((b) => b.name != _baseBranch, orElse: () => widget.state.branches.last);
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

    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mode Toggle
            Center(
              child: SegmentedButton<ComparisonMode>(
                segments: const [
                  ButtonSegment(
                    value: ComparisonMode.branch,
                    label: Text('Branch Comparison'),
                    icon: Icon(Icons.call_split),
                  ),
                  ButtonSegment(
                    value: ComparisonMode.commit,
                    label: Text('Commit Comparison'),
                    icon: Icon(Icons.history),
                  ),
                ],
                selected: {mode},
                onSelectionChanged: (newSelection) {
                  context
                      .read<GitBloc>()
                      .add(SwitchComparisonMode(newSelection.first));
                },
              ),
            ),
            const SizedBox(height: 24),
            if (mode == ComparisonMode.branch)
              _buildBranchControls(context)
            else
              _buildCommitControls(context),

            const SizedBox(height: 24),
            // Compare Action Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: _canCompare() ? _performCompare : null,
                icon: const Icon(Icons.compare_arrows),
                label: const Text('Compare', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
      ),
    );
  }

  bool _canCompare() {
    if (widget.state.mode == ComparisonMode.branch) {
      return _baseBranch != null && _targetBranch != null && _baseBranch != _targetBranch;
    } else {
      return _baseCommitSha != null && _targetCommitSha != null && _baseCommitSha != _targetCommitSha;
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
                  border: OutlineInputBorder(),
                ),
                items: widget.state.branches
                    .map((b) => DropdownMenuItem(
                          value: b.name,
                          child: Text(b.name),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() => _baseBranch = val);
                },
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: (_baseBranch != null && _targetBranch != null)
                  ? _swapBranches
                  : null,
              icon: const Icon(Icons.swap_horiz),
              tooltip: 'Swap branches',
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _targetBranch,
                decoration: const InputDecoration(
                  labelText: 'Target Branch',
                  border: OutlineInputBorder(),
                ),
                items: widget.state.branches
                    .map((b) => DropdownMenuItem(
                          value: b.name,
                          child: Text(b.name),
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
                  border: OutlineInputBorder(),
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
                icon: const Icon(Icons.refresh),
                onPressed: () => context
                    .read<GitBloc>()
                    .add(LoadCommits(branchName: _filterBranch)),
                tooltip: 'Refresh Commits',
              ),
          ],
        ),
        const SizedBox(height: 16),
        
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
                    border: OutlineInputBorder(),
                  ),
                  items: _buildCommitItems(context, commits),
                  selectedItemBuilder: (ctx) => _buildSelectedCommitItems(ctx, commits),
                  onChanged: (val) {
                    setState(() => _baseCommitSha = val);
                  },
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                  onPressed: (_baseCommitSha != null && _targetCommitSha != null) ? _swapCommits : null,
                  icon: const Icon(Icons.swap_horiz),
                  tooltip: 'Swap commits',
                ),
              ),

              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _targetCommitSha,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Target Commit (Newer)',
                    border: OutlineInputBorder(),
                  ),
                  items: _buildCommitItems(context, commits),
                  selectedItemBuilder: (ctx) => _buildSelectedCommitItems(ctx, commits),
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
  final String currentBranch; // In a real app we'd identify HEAD properly
  final List<GitBranch> branches;

  const _RepoActionsToolbar({
    required this.repoPath,
    required this.currentBranch,
    required this.branches,
  });

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
           showDialog(context: context, builder: (c) => AlertDialog(
             title: Text('Merge $branchName?'),
             content: const Text('This will merge changes into your current working branch. Conflicts may occur.'),
             actions: [
               TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
               FilledButton(
                 onPressed: () {
                   Navigator.pop(c);
                   context.read<GitBloc>().add(MergeBranch(branchName));
                 }, 
                 child: const Text('Merge')
               ),
             ],
           ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Note: 'currentBranch' passed here is just the first one or logic from parent. 
    // Ideally GitBloc should tell us which one is HEAD. 
    // For now we will assume the user knows or we add a specific "HEAD" field to state later.
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Row(
        children: [
          const Icon(Icons.call_split, size: 20),
          const SizedBox(width: 8),
          Text('Actions:', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(width: 16),
          
          // Checkout
          OutlinedButton.icon(
            onPressed: () => _showCheckoutDialog(context),
            icon: const Icon(Icons.switch_access_shortcut, size: 18),
            label: const Text('Checkout'),
          ),
          const SizedBox(width: 8),

          // Merge
          OutlinedButton.icon(
             onPressed: () => _showMergeDialog(context),
             icon: const Icon(Icons.merge, size: 18),
             label: const Text('Merge'),
          ),
          const SizedBox(width: 8),

          // Pull
          OutlinedButton.icon(
            onPressed: () => context.read<GitBloc>().add(PullChanges()),
            icon: const Icon(Icons.download, size: 18),
            label: const Text('Pull'),
          ),
        ],
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
              leading: const Icon(Icons.code),
              onTap: () {
                Navigator.pop(context);
                onSelected(branch.name);
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
      ],
    );
  }
}

class _ComparisonResultList extends StatelessWidget {
  final List<GitDiffFile> diffFiles;
  final String repoPath;
  final String base;
  final String target;
  final ComparisonMode mode;
  final VoidCallback onBack;

  const _ComparisonResultList({
    required this.diffFiles, 
    required this.repoPath, 
    required this.base,
    required this.target,
    required this.mode,
    required this.onBack
  });

  void _showDiffDialog(BuildContext context, String filePath) {
    showDialog(
      context: context,
      builder: (context) => _GitFileDiffDialog(
        repoPath: repoPath,
        filePath: filePath,
        baseRef: base,
        targetRef: target,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
           children: [
             IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
             const Text('Comparison Results', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
           ],
         ),
         Padding(
           padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              "Comparing ${mode == ComparisonMode.commit ? 'Commit' : 'Branch'} "
              "$base → $target",
              style: Theme.of(context).textTheme.bodySmall,
            ),
         ),
         const SizedBox(height: 8),
         Expanded(
           child: diffFiles.isEmpty 
             ? const Center(child: Text('No changes found between selected branches.'))
             : ListView.builder(
                 itemCount: diffFiles.length,
                 itemBuilder: (context, index) {
                   final file = diffFiles[index];
                   Color statusColor;
                   IconData statusIcon;
                   
                   final themeState = context.watch<ThemeBloc>().state;
                   
                   switch (file.status) {
                     case 'added':
                       statusColor = themeState.diffAddedColor;
                       statusIcon = Icons.add_circle_outline;
                       break;
                     case 'deleted':
                       statusColor = themeState.diffRemovedColor;
                       statusIcon = Icons.remove_circle_outline;
                       break;
                     case 'modified':
                       statusColor = themeState.diffModifiedColor;
                       statusIcon = Icons.edit_outlined;
                       break;
                     default:
                       statusColor = Colors.grey;
                       statusIcon = Icons.help_outline;
                   }

                   return Card(
                     margin: const EdgeInsets.symmetric(vertical: 4),
                     child: ListTile(
                       leading: Icon(statusIcon, color: statusColor),
                       title: Text(file.path),
                       subtitle: Text('Status: ${file.status}'),
                       onTap: () => _showDiffDialog(context, file.path),
                     ),
                   );
                 },
               ),
         ),
      ],
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
        gitService.getFileContentAtBranch(widget.repoPath, widget.baseRef, _baseFilePath),
        gitService.getFileContentAtBranch(widget.repoPath, widget.targetRef, _targetFilePath),
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
    final themeBloc = context.read<ThemeBloc>();

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
                      const SizedBox(height: 4),
                       Text('${widget.baseRef.substring(0, 7)} (Base)  →  ${widget.targetRef.substring(0, 7)} (Target)', 
                         style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                    ],
                  ),
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close)),
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
                            Expanded(child: _buildDiffPane(_baseContent ?? '', true, themeBloc, _baseScrollController)),
                          ],
                        ),
                      ),
                      Container(width: 1, color: theme.dividerColor),
                      // Target Side
                      Expanded(
                        child: Column(
                          children: [
                            _buildFileSelectorButton(context, isBase: false),
                            Expanded(child: _buildDiffPane(_targetContent ?? '', false, themeBloc, _targetScrollController)),
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

  Widget _buildFileSelectorButton(BuildContext context, {required bool isBase}) {
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
              Icon(isBase ? Icons.file_copy_outlined : Icons.file_present_outlined, size: 18),
              const SizedBox(width: 8),
              Text(isBase ? 'BASE' : 'TARGET', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 0.5)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  path,
                  style: TextStyle(
                    fontFamily: 'monospace', 
                    fontSize: 12,
                    color: fileExists ? theme.colorScheme.onSurface : theme.colorScheme.error,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_drop_down, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiffPane(String content, bool isBase, ThemeBloc themeBloc, ScrollController scrollController) {
    final otherContent = isBase ? (_targetContent ?? '') : (_baseContent ?? '');
    
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
    
    if (content.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.insert_drive_file_outlined, size: 48, color: Colors.grey.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text(
              isBase ? 'File does not exist in Base version' : 'File does not exist in Target version',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }
    
    // Split content into lines
    final lines = content.split('\n');
    final otherLines = otherContent.split('\n');
    
    // Get theme colors
    final addedColor = themeBloc.state.diffAddedColor;
    final removedColor = themeBloc.state.diffRemovedColor;
    final addedBgColor = addedColor.withValues(alpha: 0.25);
    final removedBgColor = removedColor.withValues(alpha: 0.25);
    
    // Build a set of changed line indices for accurate highlighting
    final Set<int> changedLines = {};
    final maxLines = lines.length > otherLines.length ? lines.length : otherLines.length;
    
    for (int i = 0; i < maxLines; i++) {
      final thisLine = i < lines.length ? lines[i] : '';
      final otherLine = i < otherLines.length ? otherLines[i] : '';
      if (thisLine != otherLine) {
        changedLines.add(i);
      }
    }
    
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
              
              // Only highlight if this line is in the changed set
              Color? bgColor;
              if (changedLines.contains(index)) {
                bgColor = isBase ? removedBgColor : addedBgColor;
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
                        '${index + 1}',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: fontSize,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SelectableText(
                        line.isEmpty ? ' ' : line,
                        style: TextStyle(fontFamily: fontFamily, fontSize: fontSize),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Minimap / Overview Bar
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
                  changedLines: changedLines,
                  totalLines: totalLines,
                  color: isBase ? removedColor : addedColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Custom painter for the minimap/overview bar
class _MinimapPainter extends CustomPainter {
  final Set<int> changedLines;
  final int totalLines;
  final Color color;

  _MinimapPainter({
    required this.changedLines,
    required this.totalLines,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (totalLines == 0) return;
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final lineHeight = size.height / totalLines;
    final minHeight = 2.0; // Minimum height for visibility
    
    for (final lineIndex in changedLines) {
      if (lineIndex >= totalLines) continue;
      
      final y = (lineIndex / totalLines) * size.height;
      final h = lineHeight < minHeight ? minHeight : lineHeight;
      
      canvas.drawRect(
        Rect.fromLTWH(0, y, size.width, h),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MinimapPainter oldDelegate) {
    return changedLines != oldDelegate.changedLines ||
           totalLines != oldDelegate.totalLines ||
           color != oldDelegate.color;
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
  State<_SearchableFilePickerDialog> createState() => _SearchableFilePickerDialogState();
}

class _SearchableFilePickerDialogState extends State<_SearchableFilePickerDialog> {
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
        _filteredFiles = widget.files.where((f) => f.toLowerCase().contains(lowerQuery)).toList();
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                ? Center(child: Text('No files match "$_searchController.text"', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))))
                : ListView.builder(
                    itemCount: _filteredFiles.length,
                    itemBuilder: (context, index) {
                      final file = _filteredFiles[index];
                      final isSelected = file == _selectedFile;
                      
                      return ListTile(
                        dense: true,
                        selected: isSelected,
                        selectedTileColor: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                        leading: Icon(Icons.insert_drive_file_outlined, size: 18, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                        title: Text(file, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
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
                  Text('${_filteredFiles.length} files', style: theme.textTheme.bodySmall),
                  TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

