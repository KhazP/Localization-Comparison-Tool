import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/git_bloc.dart';
import 'package:localizer_app_main/data/services/git_service.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';

class ConflictResolutionView extends StatefulWidget {
  final String repoPath;
  final List<String> conflictedFiles;

  const ConflictResolutionView({
    super.key,
    required this.repoPath,
    required this.conflictedFiles,
  });

  @override
  State<ConflictResolutionView> createState() => _ConflictResolutionViewState();
}

class _ConflictResolutionViewState extends State<ConflictResolutionView> {
  String? _selectedFile;
  List<ConflictMarker>? _markers;
  bool _isLoadingMarkers = false;

  @override
  void initState() {
    super.initState();
    if (widget.conflictedFiles.isNotEmpty) {
      _selectFile(widget.conflictedFiles.first);
    }
  }

  void _selectFile(String filePath) async {
    setState(() {
      _selectedFile = filePath;
      _isLoadingMarkers = true;
      _markers = null;
    });

    try {
      final fullPath = '${widget.repoPath}\\\\$filePath';
      debugPrint('Parsing conflict markers for: $fullPath');
      final markers = await context
          .read<GitBloc>()
          .gitService
          .parseConflictMarkers(fullPath);
      debugPrint('Found ${markers.length} conflict markers');
      if (mounted) {
        setState(() {
          _markers = markers;
          _isLoadingMarkers = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading markers: $e');
      if (mounted) setState(() => _isLoadingMarkers = false);
    }
  }

  void _resolveFile(ResolutionStrategy strategy) {
    if (_selectedFile == null) return;
    context
        .read<GitBloc>()
        .add(ResolveConflict(widget.repoPath, _selectedFile!, strategy));
  }

  void _resolveSingleMarker(
      ConflictMarker marker, ResolutionStrategy strategy) async {
    if (_selectedFile == null) return;
    final fullPath = '${widget.repoPath}/$_selectedFile';
    context.read<GitBloc>().add(
        ResolveSingleConflict(widget.repoPath, fullPath, marker, strategy));
    // Refresh markers after resolution
    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      _selectFile(_selectedFile!);
    }
  }

  void _markFileResolved() {
    if (_selectedFile == null) return;
    debugPrint('Marking file as resolved: ${widget.repoPath}, $_selectedFile');
    context
        .read<GitBloc>()
        .add(MarkFileResolved(widget.repoPath, _selectedFile!));
    ToastService.showInfo(
      context,
      'Staging $_selectedFile for commit...',
      duration: const Duration(seconds: 2),
    );
  }

  void _abortMerge() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Abort Merge?'),
              content: const Text(
                  'This will revert all merge changes and return to the state before the merge. This cannot be undone.'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancel')),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(ctx); // Close dialog
                    context.read<GitBloc>().add(AbortMerge(widget.repoPath));
                    // Close view handled by parent listener usually, but we are inside a full view/dialog?
                  },
                  child: const Text('Abort Merge'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: Theme.of(context).colorScheme.onErrorContainer),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Merge Conflicts Detected',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'You must resolve these conflicts before you can continue.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer
                                  .withValues(alpha: 0.8),
                            ),
                      ),
                    ],
                  ),
                ),
                FilledButton.icon(
                  onPressed: _abortMerge,
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                  ),
                  icon: const Icon(Icons.cancel),
                  label: const Text('Abort Merge'),
                ),
              ],
            ),
          ),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // File List
                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                            'Conflicted Files (${widget.conflictedFiles.length})',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: widget.conflictedFiles.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final file = widget.conflictedFiles[index];
                            final isSelected = file == _selectedFile;
                            return ListTile(
                              title: Text(
                                file,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isSelected
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer
                                      : null,
                                  fontWeight:
                                      isSelected ? FontWeight.bold : null,
                                ),
                              ),
                              leading: Icon(
                                Icons.description_outlined,
                                color: isSelected
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                    : null,
                              ),
                              selected: isSelected,
                              selectedTileColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              onTap: () => _selectFile(file),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),

                // Details / Resolution Area
                Expanded(
                  child: _selectedFile == null
                      ? const Center(child: Text('Select a file to resolve'))
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Resolving: $_selectedFile',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  Row(
                                    children: [
                                      OutlinedButton.icon(
                                        icon: const Icon(Icons.undo),
                                        label: const Text('Keep All Ours'),
                                        onPressed: () => _resolveFile(
                                            ResolutionStrategy.ours),
                                      ),
                                      const SizedBox(width: 12),
                                      FilledButton.icon(
                                        icon: const Icon(Icons.input),
                                        label: const Text('Accept All Theirs'),
                                        onPressed: () => _resolveFile(
                                            ResolutionStrategy.theirs),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 1),
                            Expanded(
                              child: _isLoadingMarkers
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : _buildMarkersList(),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkersList() {
    if (_markers == null || _markers!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline,
                size: 64, color: Colors.green.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            const Text('All conflicts in this file have been resolved!',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _markFileResolved,
              icon: const Icon(Icons.check),
              label: const Text('Mark as Resolved'),
            ),
            const SizedBox(height: 8),
            const Text('This will stage the file for commit.',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _markers!.length,
      itemBuilder: (context, index) {
        final marker = _markers![index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: Theme.of(context)
              .colorScheme
              .surfaceContainerHighest
              .withValues(alpha: 0.3),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Conflict #${index + 1}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('OURS (Current)',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.blue)),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Theme.of(context).colorScheme.surface,
                            width: double.infinity,
                            child: Text(
                              marker.ours.trim().isEmpty
                                  ? '(Empty)'
                                  : marker.ours.trim(),
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('THEIRS (Incoming)',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.green)),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Theme.of(context).colorScheme.surface,
                            width: double.infinity,
                            child: Text(
                              marker.theirs.trim().isEmpty
                                  ? '(Empty)'
                                  : marker.theirs.trim(),
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildMarkerActions(marker),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMarkerActions(ConflictMarker marker) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton.icon(
          icon: const Icon(Icons.check, size: 16),
          label: const Text('Keep Ours'),
          onPressed: () =>
              _resolveSingleMarker(marker, ResolutionStrategy.ours),
        ),
        const SizedBox(width: 8),
        FilledButton.icon(
          icon: const Icon(Icons.check, size: 16),
          label: const Text('Accept Theirs'),
          onPressed: () =>
              _resolveSingleMarker(marker, ResolutionStrategy.theirs),
        ),
      ],
    );
  }
}
