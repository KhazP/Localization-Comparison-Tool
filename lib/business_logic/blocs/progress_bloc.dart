import 'package:flutter_bloc/flutter_bloc.dart';

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
    });

    on<ProgressUpdated>((event, emit) {
      if (state is ProgressLoading) {
        final currentTotal = (state as ProgressLoading).total;
        emit(ProgressLoading(currentTotal, event.completedFiles, message: 'Processing: ${event.currentFile}'));
      }
    });

    on<ComparisonCompleted>((event, emit) {
      emit(ProgressSuccess());
    });

    on<ComparisonError>((event, emit) {
      emit(ProgressFailure(event.errorMessage));
    });
  }
} 