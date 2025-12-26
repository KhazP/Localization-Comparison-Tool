import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:localizer_app_main/business_logic/blocs/git_bloc.dart';
import 'package:localizer_app_main/data/services/git_service.dart';

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
          Expanded(
            child: BlocBuilder<GitBloc, GitState>(
              builder: (context, state) {
                if (state is GitInitial) {
                  return const Center(child: Text('Select a repository to begin.'));
                } else if (state is GitLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GitError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error, size: 48),
                        const SizedBox(height: 16),
                        Text('Error: ${state.message}', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                      ],
                    ),
                  );
                } else if (state is GitRepositorySelected) {
                  return const Center(child: CircularProgressIndicator()); 
                } else if (state is GitBranchesLoaded) {
                  return _ComparisonControls(
                    state: state,
                    repoPath: state.repoPath,
                  );
                } else if (state is GitComparisonInProgress) {
                   return const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [CircularProgressIndicator(), SizedBox(height: 16), Text('Comparing...')]));
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mode Toggle
        Center(
          child: SegmentedButton<ComparisonMode>(
            segments: const [
              ButtonSegment(value: ComparisonMode.branch, label: Text('Branch Comparison'), icon: Icon(Icons.call_split)),
              ButtonSegment(value: ComparisonMode.commit, label: Text('Commit Comparison'), icon: Icon(Icons.history)),
            ],
            selected: {mode},
            onSelectionChanged: (newSelection) {
              context.read<GitBloc>().add(SwitchComparisonMode(newSelection.first));
            },
          ),
        ),
        const SizedBox(height: 24),
        
        if (mode == ComparisonMode.branch) 
          _buildBranchControls(context)
        else 
          _buildCommitControls(context),
      ],
    );
  }

  Widget _buildBranchControls(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _baseBranch,
                decoration: const InputDecoration(labelText: 'Base Branch', border: OutlineInputBorder()),
                items: widget.state.branches.map((b) => DropdownMenuItem(value: b.name, child: Text(b.name))).toList(),
                onChanged: (val) => setState(() => _baseBranch = val),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.arrow_forward),
            ),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _targetBranch,
                decoration: const InputDecoration(labelText: 'Target Branch', border: OutlineInputBorder()),
                items: widget.state.branches.map((b) => DropdownMenuItem(value: b.name, child: Text(b.name))).toList(),
                onChanged: (val) => setState(() => _targetBranch = val),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: FilledButton.icon(
            onPressed: (_baseBranch != null && _targetBranch != null)
                ? () {
                    context.read<GitBloc>().add(CompareBranches(_baseBranch!, _targetBranch!));
                  }
                : null,
            icon: const Icon(Icons.compare),
            label: const Text('Compare Branches'),
          ),
        ),
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
                decoration: const InputDecoration(labelText: 'Filter Commits by Branch', border: OutlineInputBorder()),
                items: widget.state.branches.map((b) => DropdownMenuItem(value: b.name, child: Text(b.name))).toList(),
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
              const SizedBox(width: 24, height: 24, child: CircularProgressIndicator())
            else
              IconButton(
                icon: const Icon(Icons.refresh), 
                onPressed: () => context.read<GitBloc>().add(LoadCommits(branchName: _filterBranch)),
                tooltip: 'Refresh Commits',
              ),
          ],
        ),
        const SizedBox(height: 16),
        
        if (commits.isEmpty && !isLoading)
           const Text('No commits found or loaded. Select a branch to load commits.'),

        if (commits.isNotEmpty) ...[
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _baseCommitSha,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Base Commit (Older)', border: OutlineInputBorder()),
                  items: commits.map((c) => DropdownMenuItem(
                    value: c.sha, 
                    child: Text(
                      '${c.sha.substring(0, 7)} - ${c.message.split('\n').first}', 
                      overflow: TextOverflow.ellipsis,
                    ),
                  )).toList(),
                  onChanged: (val) => setState(() => _baseCommitSha = val),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(Icons.arrow_forward),
              ),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _targetCommitSha,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Target Commit (Newer)', border: OutlineInputBorder()),
                  items: commits.map((c) => DropdownMenuItem(
                    value: c.sha, 
                    child: Text(
                      '${c.sha.substring(0, 7)} - ${c.message.split('\n').first}', 
                      overflow: TextOverflow.ellipsis,
                    ),
                  )).toList(),
                  onChanged: (val) => setState(() => _targetCommitSha = val),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              onPressed: (_baseCommitSha != null && _targetCommitSha != null)
                  ? () {
                      context.read<GitBloc>().add(CompareCommits(_baseCommitSha!, _targetCommitSha!));
                    }
                  : null,
              icon: const Icon(Icons.history),
              label: const Text('Compare Commits'),
            ),
          ),
        ]
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
             'Comparing ${mode == ComparisonMode.commit ? 'Commit' : 'Branch'} $base → $target', 
             style: Theme.of(context).textTheme.bodySmall
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
                   
                   switch (file.status) {
                     case 'added':
                       statusColor = Colors.green;
                       statusIcon = Icons.add_circle_outline;
                       break;
                     case 'deleted':
                       statusColor = Colors.red;
                       statusIcon = Icons.remove_circle_outline;
                       break;
                     case 'modified':
                       statusColor = Colors.orange;
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

class _GitFileDiffDialog extends StatelessWidget {
  final String repoPath;
  final String filePath;
  final String baseRef;
  final String targetRef;

  const _GitFileDiffDialog({
    required this.repoPath,
    required this.filePath,
    required this.baseRef,
    required this.targetRef,
  });

  @override
  Widget build(BuildContext context) {
    final gitService = context.read<GitBloc>().gitService;

    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: SizedBox(
        width: 1000,
        height: 700,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Diff: $filePath', style: Theme.of(context).textTheme.titleLarge),
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close)),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: Future.wait([
                  gitService.getFileContentAtBranch(repoPath, baseRef, filePath),
                  gitService.getFileContentAtBranch(repoPath, targetRef, filePath),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading content: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final baseContent = snapshot.data![0];
                    final targetContent = snapshot.data![1];
                    
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.grey.withValues(alpha: 0.1),
                                width: double.infinity,
                                child: Text(baseRef, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(16),
                                  child: SelectableText(baseContent, style: const TextStyle(fontFamily: 'monospace')),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(width: 1),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.blue.withValues(alpha: 0.1),
                                width: double.infinity,
                                child: Text(targetRef, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(16),
                                  child: SelectableText(targetContent, style: const TextStyle(fontFamily: 'monospace')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
