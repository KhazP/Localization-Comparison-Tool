import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';

// Events
abstract class ComparisonEvent {}

/// Event to request file comparison.
/// AppSettings are passed directly to avoid BLoC-to-BLoC coupling.
class CompareFilesRequested extends ComparisonEvent {
  final File file1;
  final File file2;
  final AppSettings settings;
  
  CompareFilesRequested({
    required this.file1, 
    required this.file2,
    required this.settings,
  });
}

/// Event to request bilingual comparison from a single file.
class CompareBilingualFileRequested extends ComparisonEvent {
  final File file;
  final AppSettings settings;
  final bool isFromHistory;

  CompareBilingualFileRequested({
    required this.file,
    required this.settings,
    this.isFromHistory = false,
  });
}

/// Event to compare files from history, with settings passed directly
class CompareFilesFromHistoryRequested extends ComparisonEvent {
  final String file1Path;
  final String file2Path;
  final AppSettings settings;
  final bool isFromHistory;
  
  CompareFilesFromHistoryRequested({
    required this.file1Path, 
    required this.file2Path,
    required this.settings,
    this.isFromHistory = true,
  });
}

// Progress callback type for decoupled progress reporting
typedef ProgressCallback = void Function(int completed, int total, String message);

/// Event to proceed with comparison after a warning
class ProceedWithComparison extends ComparisonEvent {
  final ComparisonResult result;
  final File file1;
  final File file2;
  final bool wasLoadedFromHistory;

  ProceedWithComparison(this.result, this.file1, this.file2, {this.wasLoadedFromHistory = false});
}

// States
abstract class ComparisonState {}

class ComparisonInitial extends ComparisonState {}

class ComparisonLoading extends ComparisonState {
  final String? message;
  ComparisonLoading({this.message});
}

class ComparisonSuccess extends ComparisonState {
  final ComparisonResult result;
  final File file1;
  final File file2;
  final bool wasLoadedFromHistory;

  ComparisonSuccess(this.result, this.file1, this.file2, {this.wasLoadedFromHistory = false});
}

class ComparisonLargeFileWarning extends ComparisonState {
  final ComparisonResult result;
  final File file1;
  final File file2;
  final bool wasLoadedFromHistory;
  final int count;

  ComparisonLargeFileWarning(
    this.result, 
    this.file1, 
    this.file2, 
    this.count, 
    {this.wasLoadedFromHistory = false}
  );
}

class ComparisonFailure extends ComparisonState {
  final String error;
  ComparisonFailure(this.error);
}

// BLoC - Decoupled from SettingsBloc and ProgressBloc
class ComparisonBloc extends Bloc<ComparisonEvent, ComparisonState> {
  final ComparisonEngine comparisonEngine;
  
  /// Optional progress callback for external progress tracking
  final ProgressCallback? onProgress;

  ComparisonBloc({
    required this.comparisonEngine,
    this.onProgress,
  }) : super(ComparisonInitial()) {
    on<CompareFilesRequested>(_onCompareFilesRequested);
    on<CompareBilingualFileRequested>(_onCompareBilingualFileRequested);
    on<CompareFilesFromHistoryRequested>(_onCompareFilesFromHistoryRequested);
    on<ProceedWithComparison>(_onProceedWithComparison);
  }

  void _handleComparisonResult(
    Emitter<ComparisonState> emit,
    ComparisonResult result,
    File file1,
    File file2,
    bool wasLoadedFromHistory,
  ) {
    if (result.diff.length > 50000) {
      emit(ComparisonLargeFileWarning(
        result, 
        file1, 
        file2, 
        result.diff.length, 
        wasLoadedFromHistory: wasLoadedFromHistory
      ));
    } else {
      emit(ComparisonSuccess(result, file1, file2, wasLoadedFromHistory: wasLoadedFromHistory));
    }
  }

  void _onProceedWithComparison(
    ProceedWithComparison event,
    Emitter<ComparisonState> emit,
  ) {
    emit(ComparisonSuccess(
      event.result, 
      event.file1, 
      event.file2, 
      wasLoadedFromHistory: event.wasLoadedFromHistory
    ));
  }

  Future<void> _onCompareFilesRequested(
    CompareFilesRequested event, 
    Emitter<ComparisonState> emit,
  ) async {
    emit(ComparisonLoading(message: 'Starting comparison...'));
    onProgress?.call(0, 2, 'Starting comparison...');

    try {
      onProgress?.call(1, 2, 'Parsing files...');
      
      final result = await comparisonEngine.compareFiles(
        event.file1, 
        event.file2, 
        event.settings,
      );
      
      onProgress?.call(2, 2, 'Comparison complete');
      _handleComparisonResult(emit, result, event.file1, event.file2, false);
    } catch (e) {
      final errorMessage = 'Failed to compare files: ${e.toString()}';
      emit(ComparisonFailure(errorMessage));
    }
  }

  Future<void> _onCompareFilesFromHistoryRequested(
    CompareFilesFromHistoryRequested event, 
    Emitter<ComparisonState> emit,
  ) async {
    emit(ComparisonLoading(message: 'Loading files from history...'));
    onProgress?.call(0, 2, 'Loading files from history...');

    try {
      final File file1 = File(event.file1Path);
      final File file2 = File(event.file2Path);

      if (!await file1.exists() || !await file2.exists()) {
        const errorMessage = 'One or both files from history not found at original paths.';
        emit(ComparisonFailure(errorMessage));
        return;
      }

      onProgress?.call(1, 2, 'Parsing files...');
      
      final result = await comparisonEngine.compareFiles(
        file1, 
        file2, 
        event.settings,
      );
      
      onProgress?.call(2, 2, 'Comparison complete');
      _handleComparisonResult(emit, result, file1, file2, event.isFromHistory);
    } catch (e) {
      final errorMessage = 'Failed to compare files from history: ${e.toString()}';
      emit(ComparisonFailure(errorMessage));
    }
  }

  Future<void> _onCompareBilingualFileRequested(
    CompareBilingualFileRequested event,
    Emitter<ComparisonState> emit,
  ) async {
    emit(ComparisonLoading(message: 'Starting comparison...'));
    onProgress?.call(0, 2, 'Starting comparison...');

    try {
      onProgress?.call(1, 2, 'Parsing file...');

      final result = await comparisonEngine.compareBilingualFile(
        event.file,
        event.settings,
      );

      onProgress?.call(2, 2, 'Comparison complete');
      _handleComparisonResult(emit, result, event.file, event.file, event.isFromHistory);
    } on InvalidBilingualFileException catch (e) {
      emit(ComparisonFailure(e.message));
    } catch (e) {
      final errorMessage = 'Failed to compare file: ${e.toString()}';
      emit(ComparisonFailure(errorMessage));
    }
  }
}

