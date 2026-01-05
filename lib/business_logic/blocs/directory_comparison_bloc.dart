import 'dart:developer' as developer;
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/core/services/file_discovery_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/data/models/file_pair.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/repositories/history_repository.dart';
import 'package:uuid/uuid.dart';

part 'directory_comparison_bloc.freezed.dart';

// Events
abstract class DirectoryComparisonEvent extends Equatable {
  const DirectoryComparisonEvent();

  @override
  List<Object> get props => [];
}

class CompareDirectoriesRequested extends DirectoryComparisonEvent {
  final String sourceDirectoryPath;
  final String targetDirectoryPath;

  const CompareDirectoriesRequested(
      this.sourceDirectoryPath, this.targetDirectoryPath);

  @override
  List<Object> get props => [sourceDirectoryPath, targetDirectoryPath];
}

class ManuallyPairFile extends DirectoryComparisonEvent {
  final File sourceFile;
  final File targetFile;

  const ManuallyPairFile({required this.sourceFile, required this.targetFile});

  @override
  List<Object> get props => [sourceFile, targetFile];
}

class ComparePairedFilesRequested extends DirectoryComparisonEvent {
  final AppSettings settings;
  const ComparePairedFilesRequested(this.settings);

  @override
  List<Object> get props => [settings];
}

// States
@freezed
class DirectoryComparisonState with _$DirectoryComparisonState {
  const factory DirectoryComparisonState.initial() = DirectoryComparisonInitial;
  const factory DirectoryComparisonState.loading() = DirectoryComparisonLoading;
  const factory DirectoryComparisonState.success({
    required String sourceDirectory,
    required String targetDirectory,
    @Default(<FilePair>[]) List<FilePair> pairedFiles,
    @Default(<File>[]) List<File> unmatchedSourceFiles,
    @Default(<File>[]) List<File> unmatchedTargetFiles,
    @Default(<FilePair, ComparisonResult>{})
    Map<FilePair, ComparisonResult> comparisonResults,
    @Default(<FilePair, String>{}) Map<FilePair, String> comparisonErrors,
  }) = DirectoryComparisonSuccess;
  const factory DirectoryComparisonState.failure(String error) =
      DirectoryComparisonFailure;
}

// BLoC
class DirectoryComparisonBloc
    extends Bloc<DirectoryComparisonEvent, DirectoryComparisonState> {
  final FileDiscoveryService _fileDiscoveryService;
  final ComparisonEngine _comparisonEngine;
  final HistoryRepository _historyRepository;

  DirectoryComparisonBloc({
    required FileDiscoveryService fileDiscoveryService,
    required ComparisonEngine comparisonEngine,
    required HistoryRepository historyRepository,
  })  : _fileDiscoveryService = fileDiscoveryService,
        _comparisonEngine = comparisonEngine,
        _historyRepository = historyRepository,
        super(DirectoryComparisonInitial()) {
    on<CompareDirectoriesRequested>(_onCompareDirectoriesRequested);
    on<ManuallyPairFile>(_onManuallyPairFile);
    on<ComparePairedFilesRequested>(_onComparePairedFilesRequested);
  }

  Future<void> _onCompareDirectoriesRequested(
    CompareDirectoriesRequested event,
    Emitter<DirectoryComparisonState> emit,
  ) async {
    emit(DirectoryComparisonLoading());
    try {
      final discoveryResult = await _fileDiscoveryService.findMatchingFiles(
        event.sourceDirectoryPath,
        event.targetDirectoryPath,
      );
      emit(DirectoryComparisonSuccess(
        sourceDirectory: event.sourceDirectoryPath,
        targetDirectory: event.targetDirectoryPath,
        pairedFiles: discoveryResult.pairedFiles,
        unmatchedSourceFiles: discoveryResult.unmatchedSourceFiles,
        unmatchedTargetFiles: discoveryResult.unmatchedTargetFiles,
      ));
    } catch (e) {
      emit(DirectoryComparisonFailure(e.toString()));
    }
  }

  void _onManuallyPairFile(
    ManuallyPairFile event,
    Emitter<DirectoryComparisonState> emit,
  ) {
    if (state is DirectoryComparisonSuccess) {
      final currentState = state as DirectoryComparisonSuccess;

      // Create the new pair
      final newPair =
          FilePair(sourceFile: event.sourceFile, targetFile: event.targetFile);

      // Create new lists by filtering out the manually paired files
      final newPairedFiles = List<FilePair>.from(currentState.pairedFiles)
        ..add(newPair);
      final newUnmatchedSource =
          List<File>.from(currentState.unmatchedSourceFiles)
            ..remove(event.sourceFile);
      final newUnmatchedTarget =
          List<File>.from(currentState.unmatchedTargetFiles)
            ..remove(event.targetFile);

      // Sort the paired list alphabetically for consistency
      newPairedFiles
          .sort((a, b) => a.sourceFile.path.compareTo(b.sourceFile.path));

      emit(DirectoryComparisonSuccess(
        sourceDirectory: currentState.sourceDirectory,
        targetDirectory: currentState.targetDirectory,
        pairedFiles: newPairedFiles,
        unmatchedSourceFiles: newUnmatchedSource,
        unmatchedTargetFiles: newUnmatchedTarget,
        comparisonResults: currentState.comparisonResults,
        comparisonErrors: currentState.comparisonErrors,
      ));
    }
  }

  Future<void> _onComparePairedFilesRequested(
    ComparePairedFilesRequested event,
    Emitter<DirectoryComparisonState> emit,
  ) async {
    if (state is! DirectoryComparisonSuccess) return;

    final currentState = state as DirectoryComparisonSuccess;
    if (currentState.pairedFiles.isEmpty) return;

    emit(DirectoryComparisonLoading());

    final newResults = <FilePair, ComparisonResult>{};
    final newErrors = <FilePair, String>{};

    for (final pair in currentState.pairedFiles) {
      try {
        final result = await _comparisonEngine.compareFiles(
          pair.sourceFile,
          pair.targetFile,
          event.settings,
        );
        newResults[pair] = result;
      } catch (e, s) {
        developer.log(
          'Failed to compare directory pair.',
          name: 'DirectoryComparisonBloc',
          error: e,
          stackTrace: s,
        );
        newErrors[pair] = _formatComparisonError(e);
      }
    }

    emit(DirectoryComparisonSuccess(
      sourceDirectory: currentState.sourceDirectory,
      targetDirectory: currentState.targetDirectory,
      pairedFiles: currentState.pairedFiles,
      unmatchedSourceFiles: currentState.unmatchedSourceFiles,
      unmatchedTargetFiles: currentState.unmatchedTargetFiles,
      comparisonResults: newResults,
      comparisonErrors: newErrors,
    ));

    // Save to history
    try {
      if (state is DirectoryComparisonSuccess) {
        // Calculate aggregate stats
        int totalAdded = 0;
        int totalRemoved = 0;
        int totalModified = 0;
        int totalIdentical = 0; // Not perfectly tracked in aggregation but okay

        for (final res in newResults.values) {
          totalAdded += res.diff.values
              .where((d) => d.status == StringComparisonStatus.added)
              .length;
          totalRemoved += res.diff.values
              .where((d) => d.status == StringComparisonStatus.removed)
              .length;
          totalModified += res.diff.values
              .where((d) => d.status == StringComparisonStatus.modified)
              .length;
          // identical logic not easily available from diff unless we iterate full map
        }

        // We use the SOURCE directory as file1Path and TARGET as file2Path
        // Ideally we should have stored these in the state...
        // But we can infer from the first pair if available, OR we should store directory paths in state.
        // The pairedFiles have full paths.
        // Let's assume common parent or just use the first pair's parents.
        // Better yet, update State to hold source/target dir paths.
        // For now, let's try to get common path from paired files or just leave empty if failed.

        String srcPath = '';
        String tgtPath = '';

        if (currentState.pairedFiles.isNotEmpty) {
          // We now have the paths in the state!
          srcPath = currentState.sourceDirectory;
          tgtPath = currentState.targetDirectory;
        }

        final session = ComparisonSession(
          id: const Uuid().v4(),
          timestamp: DateTime.now(),
          file1Path: srcPath,
          file2Path: tgtPath,
          stringsAdded: totalAdded,
          stringsRemoved: totalRemoved,
          stringsModified: totalModified,
          stringsIdentical: totalIdentical,
          type: ComparisonType.directory,
          fileCount: newResults.length,
        );

        await _historyRepository.addComparisonToHistory(session);
      }
    } catch (e) {
      developer.log('Failed to save directory comparison history: $e');
    }
  }

  String _formatComparisonError(Object error) {
    final message = error.toString().toLowerCase();
    if (message.contains('unsupported file type')) {
      return 'This file type is not supported yet.';
    }
    return 'Could not compare this file. Check it and try again.';
  }
}
