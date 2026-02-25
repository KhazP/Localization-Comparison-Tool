import 'package:equatable/equatable.dart';

abstract class FileWatcherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartWatchingFiles extends FileWatcherEvent {
  final String file1Path;
  final String file2Path;

  StartWatchingFiles(this.file1Path, this.file2Path);

  @override
  List<Object?> get props => [file1Path, file2Path];
}

class StopWatchingFiles extends FileWatcherEvent {}

class FileChangedEvent extends FileWatcherEvent {
  final String filePath;

  FileChangedEvent(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class UpdateWatchedFiles extends FileWatcherEvent {
  final String? file1Path;
  final String? file2Path;

  UpdateWatchedFiles({this.file1Path, this.file2Path});

  @override
  List<Object?> get props => [file1Path, file2Path];
}
