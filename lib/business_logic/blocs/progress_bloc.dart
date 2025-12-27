import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windows_taskbar/windows_taskbar.dart';

// Events
abstract class ProgressEvent {}

class ComparisonStarted extends ProgressEvent {
  final int totalFiles; // Or total steps
  ComparisonStarted(this.totalFiles);
}

class ProgressUpdated extends ProgressEvent {
  final int completedFiles; // Or completed steps
  final String currentFile;
  ProgressUpdated(this.completedFiles, this.currentFile);
}

class ComparisonCompleted extends ProgressEvent {}

class ComparisonError extends ProgressEvent {
  final String errorMessage;
  ComparisonError(this.errorMessage);
}

// States
abstract class ProgressState {}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {
  final int total;
  final int current;
  final String? message;
  ProgressLoading(this.total, this.current, {this.message});
}

class ProgressSuccess extends ProgressState {
  // Optionally, include results or a success message
  ProgressSuccess();
}

class ProgressFailure extends ProgressState {
  final String error;
  ProgressFailure(this.error);
}

// BLoC
class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  ProgressBloc() : super(ProgressInitial()) {
    on<ComparisonStarted>((event, emit) {
      emit(ProgressLoading(event.totalFiles, 0, message: 'Starting comparison...'));
      _updateTaskbarProgress(0, event.totalFiles);
    });

    on<ProgressUpdated>((event, emit) {
      if (state is ProgressLoading) {
        final currentTotal = (state as ProgressLoading).total;
        emit(ProgressLoading(currentTotal, event.completedFiles, message: 'Processing: ${event.currentFile}'));
        _updateTaskbarProgress(event.completedFiles, currentTotal);
      }
    });

    on<ComparisonCompleted>((event, emit) {
      emit(ProgressSuccess());
      _clearTaskbarProgress();
    });

    on<ComparisonError>((event, emit) {
      emit(ProgressFailure(event.errorMessage));
      _setTaskbarError();
    });
  }

  /// Update the Windows taskbar progress indicator
  void _updateTaskbarProgress(int current, int total) {
    if (!Platform.isWindows || total == 0) return;
    
    final progress = (current / total * 100).round();
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