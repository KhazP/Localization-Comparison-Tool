import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/directory_comparison_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/data/models/file_pair.dart';
import 'package:localizer_app_main/presentation/views/comparison_result_dialog.dart';
import 'package:path/path.dart' as p;

class FilesView extends StatefulWidget {
  const FilesView({super.key});

  @override
  State<FilesView> createState() => _FilesViewState();
}

class _FilesViewState extends State<FilesView> {
  String? _sourceDirectory;
  String? _targetDirectory;

  Future<void> _pickDirectory(bool isSource) async {
    String? result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      setState(() {
        if (isSource) {
          _sourceDirectory = result;
        } else {
          _targetDirectory = result;
        }
      });
    }
  }

  void _startDirectoryComparison() {
    if (_sourceDirectory != null && _targetDirectory != null) {
      context.read<DirectoryComparisonBloc>().add(
            CompareDirectoriesRequested(_sourceDirectory!, _targetDirectory!),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both a source and target directory.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsState = context.watch<SettingsBloc>().state;
    final bool isAmoled = settingsState.status == SettingsStatus.loaded &&
                        theme.brightness == Brightness.dark &&
                        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            color: isAmoled ? Colors.black : theme.cardColor,
            elevation: isAmoled ? 0.3 : 2.0,
            shape: isAmoled
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.grey[850]!))
                : null,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildDirectoryPicker(
                        context: context,
                        title: 'Source Directory',
                        directory: _sourceDirectory,
                        onPressed: () => _pickDirectory(true),
                      ),
                      const SizedBox(width: 10),
                      _buildDirectoryPicker(
                        context: context,
                        title: 'Target Directory',
                        directory: _targetDirectory,
                        onPressed: () => _pickDirectory(false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<DirectoryComparisonBloc, DirectoryComparisonState>(
                    builder: (context, state) {
                      bool canCompare = false;
                      if (state is DirectoryComparisonSuccess) {
                        canCompare = state.pairedFiles.isNotEmpty;
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.play_arrow_rounded),
                              label: const Text('Start'),
                              onPressed: _startDirectoryComparison,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.compare_arrows_rounded),
                              label: const Text('Compare'),
                              onPressed: canCompare
                                  ? () {
                                      final settingsState = context.read<SettingsBloc>().state;
                                      if (settingsState.status == SettingsStatus.loaded) {
                                        context.read<DirectoryComparisonBloc>().add(ComparePairedFilesRequested(settingsState.appSettings));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Comparison process started...')),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Settings are not loaded yet.')),
                                        );
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Results Panel
          Expanded(
            child: Card(
              child: BlocBuilder<DirectoryComparisonBloc, DirectoryComparisonState>(
                builder: (context, state) {
                  if (state is DirectoryComparisonInitial) {
                    return const Center(
                      child: Text('Select directories to start a comparison.'),
                    );
                  }
                  if (state is DirectoryComparisonLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is DirectoryComparisonSuccess) {
                    if (state.pairedFiles.isEmpty &&
                        state.unmatchedSourceFiles.isEmpty &&
                        state.unmatchedTargetFiles.isEmpty) {
                      return const Center(
                        child: Text('No files found in the selected directories.'),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildPairedFilesSection(context, state.pairedFiles, state.comparisonResults),
                          _buildUnmatchedFilesSection(
                            context,
                            'Unmatched Source Files',
                            state.unmatchedSourceFiles,
                            state.unmatchedTargetFiles,
                          ),
                          _buildUnmatchedFilesSection(
                            context,
                            'Unmatched Target Files',
                            state.unmatchedTargetFiles,
                            null, // No pairing action for target files
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is DirectoryComparisonFailure) {
                    return Center(
                      child: Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
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

  Widget _buildPairedFilesSection(BuildContext context, List<FilePair> pairs, Map<FilePair, ComparisonResult> results) {
    return ExpansionTile(
      title: Text('Paired Files (${pairs.length})'),
      initiallyExpanded: true,
      children: pairs.map((pair) {
        final result = results[pair];
        final added = result?.diff.values.where((d) => d.status == StringComparisonStatus.added).length ?? 0;
        final removed = result?.diff.values.where((d) => d.status == StringComparisonStatus.removed).length ?? 0;
        final modified = result?.diff.values.where((d) => d.status == StringComparisonStatus.modified).length ?? 0;

        Widget trailing;
        if (result == null) {
          trailing = const Icon(Icons.hourglass_empty, color: Colors.grey);
        } else {
          trailing = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatChip('A', added, Colors.green),
              _buildStatChip('R', removed, Colors.red),
              _buildStatChip('M', modified, Colors.orange),
              const SizedBox(width: 8),
              SizedBox(
                height: 30, // Match chip height
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => ComparisonResultDialog(result: result),
                    );
                  },
                  child: const Text('View'),
                ),
              ),
            ],
          );
        }

        return ListTile(
          leading: const Icon(Icons.check_circle, color: Colors.green),
          title: Text(p.basename(pair.sourceFile.path)),
          subtitle: Text(p.basename(pair.targetFile.path)),
          trailing: trailing,
          dense: true,
        );
      }).toList(),
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$label: $count',
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildUnmatchedFilesSection(
    BuildContext context,
    String title,
    List<File> files,
    List<File>? availableToPair,
  ) {
    return ExpansionTile(
      title: Text('$title (${files.length})'),
      initiallyExpanded: true,
      children: files.map((file) {
        return ListTile(
          leading: const Icon(Icons.help_outline, color: Colors.orange),
          title: Text(p.basename(file.path)),
          trailing: availableToPair != null
              ? ElevatedButton(
                  child: const Text('Pair...'),
                  onPressed: () => _showPairingDialog(context, file, availableToPair),
                )
              : null,
          dense: true,
        );
      }).toList(),
    );
  }

  Future<void> _showPairingDialog(
    BuildContext context,
    File sourceFile,
    List<File> availableTargets,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Pair "${p.basename(sourceFile.path)}" with:'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableTargets.length,
              itemBuilder: (context, index) {
                final targetFile = availableTargets[index];
                return ListTile(
                  title: Text(p.basename(targetFile.path)),
                  onTap: () {
                    context.read<DirectoryComparisonBloc>().add(
                          ManuallyPairFile(sourceFile: sourceFile, targetFile: targetFile),
                        );
                    Navigator.of(dialogContext).pop();
                  },
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDirectoryPicker({
    required BuildContext context,
    required String title,
    String? directory,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);
    final settingsState = context.read<SettingsBloc>().state;
    final bool isAmoled = settingsState.status == SettingsStatus.loaded &&
                        theme.brightness == Brightness.dark &&
                        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    String displayPath = directory ?? 'No directory selected';
    if (directory != null) {
      final separator = Platform.isWindows ? '\\' : '/';
      final parts = directory.split(separator);
      if (parts.length > 3) {
        displayPath = '...${separator}${parts.skip(parts.length - 3).join(separator)}';
      }
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isAmoled
                      ? Colors.white70
                      : theme.textTheme.titleMedium?.color)),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isAmoled
                  ? const Color(0xFF1E1E1E)
                  : theme.colorScheme.surface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: isAmoled ? Colors.grey[800]! : theme.dividerColor,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.folder_open_outlined,
                  color: isAmoled ? Colors.white70 : theme.iconTheme.color,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Tooltip(
                    message: directory ?? '',
                    child: Text(
                      displayPath,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: isAmoled
                              ? Colors.white70
                              : theme.textTheme.bodyMedium?.color),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.folder, size: 16),
              label: const Text('Browse'),
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 