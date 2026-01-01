import 'package:flutter/widgets.dart';

// Navigation Intents
class OpenFileIntent extends Intent {
  const OpenFileIntent();
}

class OpenFolderIntent extends Intent {
  const OpenFolderIntent();
}

class ExportIntent extends Intent {
  const ExportIntent();
}

class SaveIntent extends Intent {
  const SaveIntent();
}

class OpenSettingsIntent extends Intent {
  const OpenSettingsIntent();
}

// View Interactivity Intents
class ZoomInIntent extends Intent {
  const ZoomInIntent();
}

class ZoomOutIntent extends Intent {
  const ZoomOutIntent();
}

class ResetZoomIntent extends Intent {
  const ResetZoomIntent();
}

class FocusSearchIntent extends Intent {
  const FocusSearchIntent();
}
