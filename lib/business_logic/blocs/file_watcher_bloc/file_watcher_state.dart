import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_watcher_state.freezed.dart';

@freezed
class FileWatcherState with _$FileWatcherState {
  const factory FileWatcherState.initial() = FileWatcherInitial;

  const factory FileWatcherState.active({
    required String file1Path,
    required String file2Path,
    required bool isEnabled,
  }) = FileWatcherActive;

  const factory FileWatcherState.inactive() = FileWatcherInactive;

  const factory FileWatcherState.fileChangedDetected({
    required String changedFilePath,
    required String file1Path,
    required String file2Path,
    required DateTime timestamp,
  }) = FileChangedDetected;
}
