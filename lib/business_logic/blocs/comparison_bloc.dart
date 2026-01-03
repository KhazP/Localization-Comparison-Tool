import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/core/services/friendly_error_service.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:localizer_app_main/data/repositories/warning_suppressions_repository.dart';

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

/// Updated progress callback type for percentage-based progress reporting
typedef ProgressCallback = void Function(
  int percentage,
  String stage, {
  int? bytesProcessed,
  int? totalBytes,
});

/// Event to proceed with comparison after a warning
class ProceedWithComparison extends ComparisonEvent {
  final ComparisonResult result;
  final File file1;
  final File file2;
  final bool wasLoadedFromHistory;

  ProceedWithComparison(this.result, this.file1, this.file2, {this.wasLoadedFromHistory = false});
}

/// Event to suppress the large file warning for a specific file path.
/// Used when user checks "Don't show again for this file".
class SuppressLargeFileWarning extends ComparisonEvent {
  final String filePath;

  SuppressLargeFileWarning(this.filePath);
}

// States
abstract class ComparisonState extends Equatable {
  const ComparisonState();

  @override
  List<Object?> get props => [];
}

class ComparisonInitial extends ComparisonState {}

class ComparisonLoading extends ComparisonState {
  final String? message;
  const ComparisonLoading({this.message});

  @override
  List<Object?> get props => [message];
}

class ComparisonSuccess extends ComparisonState {
  final ComparisonResult result;
  final File file1;
  final File file2;
  final bool wasLoadedFromHistory;

  const ComparisonSuccess(this.result, this.file1, this.file2, {this.wasLoadedFromHistory = false});

  @override
  List<Object?> get props => [result, file1.path, file2.path, wasLoadedFromHistory];
}

class ComparisonLargeFileWarning extends ComparisonState {
  final ComparisonResult result;
  final File file1;
  final File file2;
  final bool wasLoadedFromHistory;
  final int count;

  const ComparisonLargeFileWarning(
    this.result, 
    this.file1, 
    this.file2, 
    this.count, 
    {this.wasLoadedFromHistory = false}
  );

  @override
  List<Object?> get props => [result, file1.path, file2.path, count, wasLoadedFromHistory];
}

class ComparisonFailure extends ComparisonState {
  final String error;
  const ComparisonFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// BLoC - Decoupled from SettingsBloc and ProgressBloc
class ComparisonBloc extends Bloc<ComparisonEvent, ComparisonState> {
  final ComparisonEngine comparisonEngine;
  final WarningSuppressionsRepository? warningSuppressionsRepository;
  
  /// Optional progress callback for external progress tracking (percentage-based)
  final ProgressCallback? onProgress;

  ComparisonBloc({
    required this.comparisonEngine,
    this.warningSuppressionsRepository,
    this.onProgress,
  }) : super(ComparisonInitial()) {
    on<CompareFilesRequested>(_onCompareFilesRequested);
    on<CompareBilingualFileRequested>(_onCompareBilingualFileRequested);
    on<CompareFilesFromHistoryRequested>(_onCompareFilesFromHistoryRequested);
    on<ProceedWithComparison>(_onProceedWithComparison);
    on<SuppressLargeFileWarning>(_onSuppressLargeFileWarning);
  }

  void _handleComparisonResult(
    Emitter<ComparisonState> emit,
    ComparisonResult result,
    File file1,
    File file2,
    bool wasLoadedFromHistory,
  ) {
    // Check if the warning is suppressed for either file
    final isSuppressed = warningSuppressionsRepository != null &&
        (warningSuppressionsRepository!.isLargeFileWarningSuppressed(file1.path) ||
         warningSuppressionsRepository!.isLargeFileWarningSuppressed(file2.path));

    if (result.diff.length > 50000 && !isSuppressed) {
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

  Future<void> _onSuppressLargeFileWarning(
    SuppressLargeFileWarning event,
    Emitter<ComparisonState> emit,
  ) async {
    await warningSuppressionsRepository?.suppressLargeFileWarning(event.filePath);
  }

  Future<void> _onCompareFilesRequested(
    CompareFilesRequested event, 
    Emitter<ComparisonState> emit,
  ) async {
    emit(const ComparisonLoading(message: 'Starting comparison...'));
    onProgress?.call(0, 'Starting comparison...');

    try {
      final result = await comparisonEngine.compareFiles(
        event.file1, 
        event.file2, 
        event.settings,
        onProgress: onProgress != null 
          ? (percentage, stage, {bytesProcessed, totalBytes}) {
              onProgress?.call(
                percentage, 
                stage, 
                bytesProcessed: bytesProcessed, 
                totalBytes: totalBytes,
              );
            }
          : null,
      );
      
      onProgress?.call(100, 'Comparison complete');
      _handleComparisonResult(emit, result, event.file1, event.file2, false);
    } catch (e) {
      final friendlyError = FriendlyErrorService.getFriendlyMessage(e);
      emit(ComparisonFailure(friendlyError.toString()));
    }
  }

  Future<void> _onCompareFilesFromHistoryRequested(
    CompareFilesFromHistoryRequested event, 
    Emitter<ComparisonState> emit,
  ) async {
    emit(const ComparisonLoading(message: 'Loading files from history...'));
    onProgress?.call(0, 'Loading files from history...');

    try {
      final File file1 = File(event.file1Path);
      final File file2 = File(event.file2Path);

      if (!await file1.exists() || !await file2.exists()) {
        const errorMessage = 'One or both files from history not found at original paths.';
        emit(const ComparisonFailure(errorMessage));
        return;
      }

      final result = await comparisonEngine.compareFiles(
        file1, 
        file2, 
        event.settings,
        onProgress: onProgress != null 
          ? (percentage, stage, {bytesProcessed, totalBytes}) {
              onProgress?.call(
                percentage, 
                stage, 
                bytesProcessed: bytesProcessed, 
                totalBytes: totalBytes,
              );
            }
          : null,
      );
      
      onProgress?.call(100, 'Comparison complete');
      _handleComparisonResult(emit, result, file1, file2, event.isFromHistory);
    } catch (e) {
      final friendlyError = FriendlyErrorService.getFriendlyMessage(e);
      emit(ComparisonFailure(friendlyError.toString()));
    }
  }

  Future<void> _onCompareBilingualFileRequested(
    CompareBilingualFileRequested event,
    Emitter<ComparisonState> emit,
  ) async {
    emit(const ComparisonLoading(message: 'Starting comparison...'));
    onProgress?.call(0, 'Starting comparison...');

    try {
      final result = await comparisonEngine.compareBilingualFile(
        event.file,
        event.settings,
        onProgress: onProgress != null 
          ? (percentage, stage, {bytesProcessed, totalBytes}) {
              onProgress?.call(
                percentage, 
                stage, 
                bytesProcessed: bytesProcessed, 
                totalBytes: totalBytes,
              );
            }
          : null,
      );

      onProgress?.call(100, 'Comparison complete');
      _handleComparisonResult(emit, result, event.file, event.file, event.isFromHistory);
    } on InvalidBilingualFileException catch (e) {
      emit(ComparisonFailure(e.message));
    } catch (e) {
      final friendlyError = FriendlyErrorService.getFriendlyMessage(e);
      emit(ComparisonFailure(friendlyError.toString()));
    }
  }
}
