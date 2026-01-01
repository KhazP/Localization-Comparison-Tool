import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_intents.dart';

// Since some actions rely on specific Bloc events or Navigation which might differ 
// based on where we are, we can define a GlobalActions wrapper or just individual Action classes.
// For now, these are top-level functional actions that the main App widget will provide.

class GlobalActions {
  static Map<Type, Action<Intent>> getActions(BuildContext context) {
    return {
      OpenFileIntent: CallbackAction<OpenFileIntent>(
        onInvoke: (intent) {
          // Dispatch generic event or show dialog - depends on how we want to handle this globally
          // For now, print to debug CONSOLE as we need to hook into active view
          debugPrint('Global: Open File Intent triggered');
          return null;
        },
      ),
      OpenFolderIntent: CallbackAction<OpenFolderIntent>(
        onInvoke: (intent) {
          debugPrint('Global: Open Folder Intent triggered');
          return null;
        },
      ),
      ExportIntent: CallbackAction<ExportIntent>(
        onInvoke: (intent) {
          debugPrint('Global: Export Intent triggered');
          return null;
        },
      ),
      OpenSettingsIntent: CallbackAction<OpenSettingsIntent>(
        onInvoke: (intent) {
          // Settings is usually tab 5 in HomeView, but we can't easily reach it from here
          // without a global navigation key or context propagation.
          // However, verify if we can pop deeply or use a global key.
          debugPrint('Global: Open Settings Intent triggered');
          return null;
        },
      ),
      ZoomInIntent: CallbackAction<ZoomInIntent>(
        onInvoke: (intent) {
          // Dispatch zoom in to relevant Bloc or View
          debugPrint('Global: Zoom In Intent triggered');
          return null;
        },
      ),
      ZoomOutIntent: CallbackAction<ZoomOutIntent>(
        onInvoke: (intent) {
           debugPrint('Global: Zoom Out Intent triggered');
           return null;
        },
      ),
      ResetZoomIntent: CallbackAction<ResetZoomIntent>(
        onInvoke: (intent) {
           debugPrint('Global: Reset Zoom Intent triggered');
           return null;
        },
      ),
    };
  }
}
