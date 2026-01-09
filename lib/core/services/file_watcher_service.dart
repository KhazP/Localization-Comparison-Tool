import 'dart:io';
import 'dart:async';
import 'package:watcher/watcher.dart';

class FileWatcherService {
  final Map<String, StreamSubscription<WatchEvent>> _subscriptions = {};
  final Map<String, Function(String)> _callbacks = {};
  // Debounce timers to prevent multiple callbacks for rapid file changes
  final Map<String, Timer> _debounceTimers = {};
  static const Duration _debounceDelay = Duration(milliseconds: 500);

  void watchFile(String filePath, Function(String) onFileChanged) {
    // Remove existing watcher for this file if it exists
    unwatchFile(filePath);

    final file = File(filePath);
    if (!file.existsSync()) {
      return;
    }

    // Watch the directory containing the file
    final directory = file.parent;
    final fileName = file.uri.pathSegments.last;

    final watcher = DirectoryWatcher(directory.path);

    _subscriptions[filePath] = watcher.events.listen(
      (event) {
        // Only trigger callback for the specific file we're watching
        if (event.path.endsWith(fileName)) {
          switch (event.type) {
            case ChangeType.MODIFY:
            case ChangeType.ADD:
              // Cancel any existing debounce timer for this file
              _debounceTimers[filePath]?.cancel();
              // Create a new debounce timer - only the last event within
              // the debounce window will trigger the callback
              _debounceTimers[filePath] = Timer(_debounceDelay, () {
                _debounceTimers.remove(filePath);
                if (File(filePath).existsSync()) {
                  onFileChanged(filePath);
                }
              });
              break;
            case ChangeType.REMOVE:
              // Cancel any pending debounce timer
              _debounceTimers[filePath]?.cancel();
              _debounceTimers.remove(filePath);
              // File was deleted, stop watching
              unwatchFile(filePath);
              break;
          }
        }
      },
      onError: (error) {
        // Stop watching on error
        unwatchFile(filePath);
      },
    );

    _callbacks[filePath] = onFileChanged;
  }

  void unwatchFile(String filePath) {
    // Cancel any pending debounce timer
    _debounceTimers[filePath]?.cancel();
    _debounceTimers.remove(filePath);
    // Cancel the subscription
    final subscription = _subscriptions.remove(filePath);
    subscription?.cancel();
    _callbacks.remove(filePath);
  }

  void unwatchAll() {
    // Cancel all debounce timers
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
    // Cancel all subscriptions
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
    _subscriptions.clear();
    _callbacks.clear();
  }

  bool isWatching(String filePath) {
    return _subscriptions.containsKey(filePath);
  }

  List<String> get watchedFiles => List.from(_subscriptions.keys);

  void dispose() {
    unwatchAll();
  }
}
