abstract class FileWatcherState {
  const FileWatcherState();
}

class FileWatcherInitial extends FileWatcherState {
  const FileWatcherInitial();
}

class FileWatcherActive extends FileWatcherState {
  final String file1Path;
  final String file2Path;
  final bool isEnabled;

  const FileWatcherActive({
    required this.file1Path,
    required this.file2Path,
    required this.isEnabled,
  });

  FileWatcherActive copyWith({
    String? file1Path,
    String? file2Path,
    bool? isEnabled,
  }) {
    return FileWatcherActive(
      file1Path: file1Path ?? this.file1Path,
      file2Path: file2Path ?? this.file2Path,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class FileWatcherInactive extends FileWatcherState {
  const FileWatcherInactive();
}

class FileChangedDetected extends FileWatcherState {
  final String changedFilePath;
  final String file1Path;
  final String file2Path;
  final DateTime timestamp;

  const FileChangedDetected({
    required this.changedFilePath,
    required this.file1Path,
    required this.file2Path,
    required this.timestamp,
  });
}