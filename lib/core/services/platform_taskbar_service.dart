import 'dart:io';

import 'package:windows_taskbar/windows_taskbar.dart';

/// Platform-agnostic interface for taskbar progress indicators.
///
/// On Windows, delegates to [WindowsTaskbar]. On other platforms, all methods
/// are no-ops.
abstract class PlatformTaskbarService {
  /// Creates the appropriate implementation for the current platform.
  factory PlatformTaskbarService() {
    if (Platform.isWindows) {
      return _WindowsTaskbarService();
    }
    return _NoOpTaskbarService();
  }

  /// Sets the taskbar progress to [progress] out of [total].
  void setProgress(int progress, int total);

  /// Sets the taskbar to indeterminate (spinner) mode.
  void setIndeterminate();

  /// Clears the taskbar progress indicator.
  void clearProgress();

  /// Sets the taskbar to error state and automatically clears after [duration].
  void setError({Duration duration = const Duration(seconds: 2)});

  /// Sets the taskbar progress to normal mode with the given [percentage] (0-100).
  void setNormalProgress(int percentage) {
    setProgress(percentage.clamp(0, 100), 100);
  }
}

class _WindowsTaskbarService implements PlatformTaskbarService {
  @override
  void setProgress(int progress, int total) {
    WindowsTaskbar.setProgress(progress, total);
    WindowsTaskbar.setProgressMode(TaskbarProgressMode.normal);
  }

  @override
  void setIndeterminate() {
    WindowsTaskbar.setProgressMode(TaskbarProgressMode.indeterminate);
  }

  @override
  void clearProgress() {
    WindowsTaskbar.setProgressMode(TaskbarProgressMode.noProgress);
  }

  @override
  void setError({Duration duration = const Duration(seconds: 2)}) {
    WindowsTaskbar.setProgressMode(TaskbarProgressMode.error);
    WindowsTaskbar.setProgress(100, 100);
    Future.delayed(duration, () {
      WindowsTaskbar.setProgressMode(TaskbarProgressMode.noProgress);
    });
  }

  @override
  void setNormalProgress(int percentage) {
    final progress = percentage.clamp(0, 100);
    WindowsTaskbar.setProgress(progress, 100);
    WindowsTaskbar.setProgressMode(TaskbarProgressMode.normal);
  }
}

class _NoOpTaskbarService implements PlatformTaskbarService {
  @override
  void setProgress(int progress, int total) {}

  @override
  void setIndeterminate() {}

  @override
  void clearProgress() {}

  @override
  void setError({Duration duration = const Duration(seconds: 2)}) {}

  @override
  void setNormalProgress(int percentage) {}
}
