import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:windows_taskbar/windows_taskbar.dart';

part 'progress_bloc.freezed.dart';

// Events
abstract class ProgressEvent {}

class ComparisonStarted extends ProgressEvent {
  final int totalSteps;
  final String initialMessage;
  ComparisonStarted(
      {this.totalSteps = 100, this.initialMessage = 'Starting...'});
}

/// Updated progress event with more granular information
class ProgressUpdated extends ProgressEvent {
  final int percentage; // 0-100
  final String stage; // Current operation name
  final int? bytesProcessed; // For file reading stages
  final int? totalBytes; // Total file size

  ProgressUpdated({
    required this.percentage,
    required this.stage,
    this.bytesProcessed,
    this.totalBytes,
  });
}

class ComparisonCompleted extends ProgressEvent {}

class ComparisonError extends ProgressEvent {
  final String errorMessage;
  ComparisonError(this.errorMessage);
}

// States
@freezed
class ProgressState with _$ProgressState {
  const ProgressState._();

  const factory ProgressState.initial() = ProgressInitial;

  const factory ProgressState.loading({
    /// 0-100
    required int percentage,

    /// Current operation description.
    required String stage,

    /// For file reading stages.
    int? bytesProcessed,

    /// Total file size.
    int? totalBytes,

    /// For ETA calculation.
    required DateTime startTime,
  }) = ProgressLoading;

  const factory ProgressState.success() = ProgressSuccess;
  const factory ProgressState.failure(String error) = ProgressFailure;
}

extension ProgressLoadingX on ProgressLoading {
  /// Calculate estimated time remaining based on current progress.
  Duration? get estimatedTimeRemaining {
    if (percentage < 5) return null;

    final elapsed = DateTime.now().difference(startTime);
    if (elapsed.inMilliseconds == 0) return null;

    final progressRate = percentage / elapsed.inMilliseconds;
    final remainingProgress = 100 - percentage;
    final remainingMs = remainingProgress / progressRate;

    return Duration(milliseconds: remainingMs.round());
  }

  /// Format bytes for display (for example, "45.2 MB").
  String? get formattedBytesProgress {
    if (bytesProcessed == null || totalBytes == null || totalBytes == 0) {
      return null;
    }
    return '${_formatBytes(bytesProcessed!)} / ${_formatBytes(totalBytes!)}';
  }

  // Legacy getters for backward compatibility.
  int get total => 100;
  int get current => percentage;
  String? get message => stage;
}

String _formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  if (bytes < 1024 * 1024 * 1024) {
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
  return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
}

// BLoC
class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  DateTime? _startTime;

  ProgressBloc() : super(ProgressInitial()) {
    on<ComparisonStarted>((event, emit) {
      _startTime = DateTime.now();
      emit(ProgressLoading(
        percentage: 0,
        stage: event.initialMessage,
        startTime: _startTime!,
      ));
      _updateTaskbarProgress(0);
    });

    on<ProgressUpdated>((event, emit) {
      final startTime = _startTime ?? DateTime.now();
      emit(ProgressLoading(
        percentage: event.percentage.clamp(0, 100),
        stage: event.stage,
        bytesProcessed: event.bytesProcessed,
        totalBytes: event.totalBytes,
        startTime: startTime,
      ));
      _updateTaskbarProgress(event.percentage);
    });

    on<ComparisonCompleted>((event, emit) {
      _startTime = null;
      emit(ProgressSuccess());
      _clearTaskbarProgress();
    });

    on<ComparisonError>((event, emit) {
      _startTime = null;
      emit(ProgressFailure(event.errorMessage));
      _setTaskbarError();
    });
  }

  /// Update the Windows taskbar progress indicator
  void _updateTaskbarProgress(int percentage) {
    if (!Platform.isWindows) return;

    final progress = percentage.clamp(0, 100);
    WindowsTaskbar.setProgress(progress, 100);
    WindowsTaskbar.setProgressMode(TaskbarProgressMode.normal);
  }

  /// Clear the Windows taskbar progress indicator
  void _clearTaskbarProgress() {
    if (!Platform.isWindows) return;

    WindowsTaskbar.setProgressMode(TaskbarProgressMode.noProgress);
  }

  /// Set the Windows taskbar to error state
  void _setTaskbarError() {
    if (!Platform.isWindows) return;

    WindowsTaskbar.setProgressMode(TaskbarProgressMode.error);
    WindowsTaskbar.setProgress(100, 100);
  }
}
