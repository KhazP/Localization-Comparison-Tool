import 'dart:io';
import 'dart:async';
import 'package:watcher/watcher.dart';

class FileWatcherService {
  final Map<String, StreamSubscription<WatchEvent>> _subscriptions = {};
  final Map<String, Function(String)> _callbacks = {};

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
              // Add a small delay to prevent multiple rapid fire events
              Timer(const Duration(milliseconds: 500), () {
                if (File(filePath).existsSync()) {
                  onFileChanged(filePath);
                }
              });
              break;
            case ChangeType.REMOVE:
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
    final subscription = _subscriptions.remove(filePath);
    subscription?.cancel();
    _callbacks.remove(filePath);
  }

  void unwatchAll() {
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