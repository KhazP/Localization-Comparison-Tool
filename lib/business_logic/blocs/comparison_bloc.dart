import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/business_logic/blocs/progress_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';

// Events
abstract class ComparisonEvent {}

class CompareFilesRequested extends ComparisonEvent {
  final File file1;
  final File file2;
  CompareFilesRequested(this.file1, this.file2);
}

class CompareFilesFromHistoryRequested extends ComparisonEvent {
  final String file1Path;
  final String file2Path;
  final bool isFromHistory;
  CompareFilesFromHistoryRequested(this.file1Path, this.file2Path, {this.isFromHistory = true});
}

// States
abstract class ComparisonState {}

class ComparisonInitial extends ComparisonState {}

class ComparisonLoading extends ComparisonState {}

class ComparisonSuccess extends ComparisonState {
  final ComparisonResult result;
  final File file1;
  final File file2;
  final bool wasLoadedFromHistory;

  ComparisonSuccess(this.result, this.file1, this.file2, {this.wasLoadedFromHistory = false});
}

class ComparisonFailure extends ComparisonState {
  final String error;
  ComparisonFailure(this.error);
}

// BLoC
class ComparisonBloc extends Bloc<ComparisonEvent, ComparisonState> {
  final ComparisonEngine comparisonEngine;
  final ProgressBloc progressBloc; // To report progress updates
  final SettingsBloc settingsBloc; // Add SettingsBloc

  ComparisonBloc({
    required this.comparisonEngine, 
    required this.progressBloc,
    required this.settingsBloc, // Require SettingsBloc
  }) : super(ComparisonInitial()) {
    on<CompareFilesRequested>(_onCompareFilesRequested);
    on<CompareFilesFromHistoryRequested>(_onCompareFilesFromHistoryRequested);
  }

  Future<void> _onCompareFilesRequested(CompareFilesRequested event, Emitter<ComparisonState> emit) async {
    emit(ComparisonLoading());
    progressBloc.add(ComparisonStarted(2)); // 2 files to parse initially
    
    // Get AppSettings from SettingsBloc
    final currentSettingsState = settingsBloc.state;
    if (currentSettingsState.status != SettingsStatus.loaded) {
      // Handle case where settings are not loaded, though this should ideally not happen
      // if SettingsBloc is initialized and loaded before comparisons are triggered.
      const errorMessage = 'Settings not loaded. Cannot perform comparison.';
      emit(ComparisonFailure(errorMessage));
      progressBloc.add(ComparisonError(errorMessage));
      return;
    }
    final appSettings = currentSettingsState.appSettings;

    try {
      // TODO: The ComparisonEngine needs to be updated to stream progress to the ProgressBloc.
      // For now, progress is coarse-grained (started, one update per file, completed/error).
      // The engine's compareFiles doesn't currently accept a progress callback or stream.
      // This will require modification in ComparisonEngine or a wrapper.

      // Simulate progress updates for now
      // progressBloc.add(ProgressUpdated(0, event.file1.path));
      // await Future.delayed(Duration(milliseconds: 10)); // Short delay
      // progressBloc.add(ProgressUpdated(1, event.file2.path));

      final result = await comparisonEngine.compareFiles(event.file1, event.file2, appSettings); // Pass appSettings
      emit(ComparisonSuccess(result, event.file1, event.file2, wasLoadedFromHistory: false));
      progressBloc.add(ComparisonCompleted());
    } catch (e) {
      final errorMessage = 'Failed to compare files: ${e.toString()}';
      emit(ComparisonFailure(errorMessage));
      progressBloc.add(ComparisonError(errorMessage));
    }
  }

  Future<void> _onCompareFilesFromHistoryRequested(CompareFilesFromHistoryRequested event, Emitter<ComparisonState> emit) async {
    emit(ComparisonLoading());
    progressBloc.add(ComparisonStarted(2)); 
    
    // Get AppSettings from SettingsBloc
    final currentSettingsState = settingsBloc.state;
    if (currentSettingsState.status != SettingsStatus.loaded) {
      const errorMessage = 'Settings not loaded. Cannot perform comparison from history.';
      emit(ComparisonFailure(errorMessage));
      progressBloc.add(ComparisonError(errorMessage));
      return;
    }
    final appSettings = currentSettingsState.appSettings;

    try {
      final File file1 = File(event.file1Path);
      final File file2 = File(event.file2Path);

      if (!await file1.exists() || !await file2.exists()) {
        const errorMessage = 'One or both files from history not found at original paths.';
        emit(ComparisonFailure(errorMessage));
        progressBloc.add(ComparisonError(errorMessage));
        return;
      }

      final result = await comparisonEngine.compareFiles(file1, file2, appSettings); // Pass appSettings
      emit(ComparisonSuccess(result, file1, file2, wasLoadedFromHistory: event.isFromHistory));
      progressBloc.add(ComparisonCompleted());
    } catch (e) {
      final errorMessage = 'Failed to compare files from history: ${e.toString()}';
      emit(ComparisonFailure(errorMessage));
      progressBloc.add(ComparisonError(errorMessage));
    }
  }
} 