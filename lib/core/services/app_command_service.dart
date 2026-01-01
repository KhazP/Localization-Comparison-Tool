import 'dart:async';

/// App-wide commands triggered by menus or shortcuts.
enum AppCommandType {
  openFiles,
  openFolder,
  exportResults,
}

/// A command emitted by global actions.
class AppCommand {
  final AppCommandType type;

  const AppCommand(this.type);
}

/// Broadcasts app commands to interested views.
class AppCommandService {
  final StreamController<AppCommand> _controller =
      StreamController<AppCommand>.broadcast();

  Stream<AppCommand> get stream => _controller.stream;

  void emit(AppCommand command) {
    if (_controller.isClosed) return;
    _controller.add(command);
  }

  void dispose() {
    _controller.close();
  }
}
