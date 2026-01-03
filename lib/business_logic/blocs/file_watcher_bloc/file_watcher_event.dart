abstract class FileWatcherEvent {}

class StartWatchingFiles extends FileWatcherEvent {
  final String file1Path;
  final String file2Path;

  StartWatchingFiles(this.file1Path, this.file2Path);
}

class StopWatchingFiles extends FileWatcherEvent {}

class FileChangedEvent extends FileWatcherEvent {
  final String filePath;

  FileChangedEvent(this.filePath);
}

class UpdateWatchedFiles extends FileWatcherEvent {
  final String? file1Path;
  final String? file2Path;

  UpdateWatchedFiles({this.file1Path, this.file2Path});
}
