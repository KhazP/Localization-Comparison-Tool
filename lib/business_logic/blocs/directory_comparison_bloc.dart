import 'dart:developer' as developer;
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/core/services/file_discovery_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/models/file_pair.dart';

// Events
abstract class DirectoryComparisonEvent extends Equatable {
  const DirectoryComparisonEvent();

  @override
  List<Object> get props => [];
}

class CompareDirectoriesRequested extends DirectoryComparisonEvent {
  final String sourceDirectoryPath;
  final String targetDirectoryPath;

  const CompareDirectoriesRequested(this.sourceDirectoryPath, this.targetDirectoryPath);

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
abstract class DirectoryComparisonState extends Equatable {
  const DirectoryComparisonState();

  @override
  List<Object> get props => [];
}

class DirectoryComparisonInitial extends DirectoryComparisonState {}

class DirectoryComparisonLoading extends DirectoryComparisonState {}

class DirectoryComparisonSuccess extends DirectoryComparisonState {
  final List<FilePair> pairedFiles;
  final List<File> unmatchedSourceFiles;
  final List<File> unmatchedTargetFiles;
  final Map<FilePair, ComparisonResult> comparisonResults;
  final Map<FilePair, String> comparisonErrors;

  const DirectoryComparisonSuccess({
    this.pairedFiles = const [],
    this.unmatchedSourceFiles = const [],
    this.unmatchedTargetFiles = const [],
    this.comparisonResults = const {},
    this.comparisonErrors = const {},
  });

  @override
  List<Object> get props => [
        pairedFiles,
        unmatchedSourceFiles,
        unmatchedTargetFiles,
        comparisonResults,
        comparisonErrors,
      ];
}

class DirectoryComparisonFailure extends DirectoryComparisonState {
  final String error;

  const DirectoryComparisonFailure(this.error);

  @override
  List<Object> get props => [error];
}

// BLoC
class DirectoryComparisonBloc extends Bloc<DirectoryComparisonEvent, DirectoryComparisonState> {
  final FileDiscoveryService _fileDiscoveryService;
  final ComparisonEngine _comparisonEngine;

  DirectoryComparisonBloc({
    required FileDiscoveryService fileDiscoveryService,
    required ComparisonEngine comparisonEngine,
  })  : _fileDiscoveryService = fileDiscoveryService,
        _comparisonEngine = comparisonEngine,
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
      final newPair = FilePair(sourceFile: event.sourceFile, targetFile: event.targetFile);

      // Create new lists by filtering out the manually paired files
      final newPairedFiles = List<FilePair>.from(currentState.pairedFiles)..add(newPair);
      final newUnmatchedSource = List<File>.from(currentState.unmatchedSourceFiles)
        ..remove(event.sourceFile);
      final newUnmatchedTarget = List<File>.from(currentState.unmatchedTargetFiles)
        ..remove(event.targetFile);
      
      // Sort the paired list alphabetically for consistency
      newPairedFiles.sort((a, b) => a.sourceFile.path.compareTo(b.sourceFile.path));

      emit(DirectoryComparisonSuccess(
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
      pairedFiles: currentState.pairedFiles,
      unmatchedSourceFiles: currentState.unmatchedSourceFiles,
      unmatchedTargetFiles: currentState.unmatchedTargetFiles,
      comparisonResults: newResults,
      comparisonErrors: newErrors,
    ));
  }

  String _formatComparisonError(Object error) {
    final message = error.toString().toLowerCase();
    if (message.contains('unsupported file type')) {
      return 'This file type is not supported yet.';
    }
    return 'Could not compare this file. Check it and try again.';
  }
}
