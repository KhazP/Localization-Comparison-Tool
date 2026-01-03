import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/core/services/file_watcher_service.dart';
import 'file_watcher_event.dart';
import 'file_watcher_state.dart';

class FileWatcherBloc extends Bloc<FileWatcherEvent, FileWatcherState> {
  final FileWatcherService _fileWatcherService;

  FileWatcherBloc(this._fileWatcherService)
      : super(const FileWatcherInitial()) {
    on<StartWatchingFiles>(_onStartWatchingFiles);
    on<StopWatchingFiles>(_onStopWatchingFiles);
    on<FileChangedEvent>(_onFileChanged);
    on<UpdateWatchedFiles>(_onUpdateWatchedFiles);
  }

  void _onStartWatchingFiles(
      StartWatchingFiles event, Emitter<FileWatcherState> emit) {
    try {
      // Stop any existing watchers
      _fileWatcherService.unwatchAll();

      // Validate files exist
      final file1 = File(event.file1Path);
      final file2 = File(event.file2Path);

      if (!file1.existsSync() || !file2.existsSync()) {
        emit(const FileWatcherInactive());
        return;
      }

      // Start watching both files
      _fileWatcherService.watchFile(event.file1Path, (filePath) {
        add(FileChangedEvent(filePath));
      });

      _fileWatcherService.watchFile(event.file2Path, (filePath) {
        add(FileChangedEvent(filePath));
      });

      emit(FileWatcherActive(
        file1Path: event.file1Path,
        file2Path: event.file2Path,
        isEnabled: true,
      ));
    } catch (e) {
      emit(const FileWatcherInactive());
    }
  }

  void _onStopWatchingFiles(
      StopWatchingFiles event, Emitter<FileWatcherState> emit) {
    _fileWatcherService.unwatchAll();
    emit(const FileWatcherInactive());
  }

  void _onFileChanged(FileChangedEvent event, Emitter<FileWatcherState> emit) {
    final currentState = state;
    if (currentState is FileWatcherActive) {
      emit(FileChangedDetected(
        changedFilePath: event.filePath,
        file1Path: currentState.file1Path,
        file2Path: currentState.file2Path,
        timestamp: DateTime.now(),
      ));

      // Return to active state after emitting the change event
      emit(currentState);
    }
  }

  void _onUpdateWatchedFiles(
      UpdateWatchedFiles event, Emitter<FileWatcherState> emit) {
    final currentState = state;
    if (currentState is FileWatcherActive) {
      final newFile1Path = event.file1Path ?? currentState.file1Path;
      final newFile2Path = event.file2Path ?? currentState.file2Path;

      // If files changed, restart watching with new files
      if (newFile1Path != currentState.file1Path ||
          newFile2Path != currentState.file2Path) {
        add(StartWatchingFiles(newFile1Path, newFile2Path));
      }
    } else if (event.file1Path != null && event.file2Path != null) {
      // Start watching if we have both files
      add(StartWatchingFiles(event.file1Path!, event.file2Path!));
    }
  }

  @override
  Future<void> close() {
    _fileWatcherService.dispose();
    return super.close();
  }
}
