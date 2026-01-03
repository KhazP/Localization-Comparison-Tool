import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/app_command_service.dart';
import 'package:localizer_app_main/core/services/app_tab_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'app_intents.dart';

// Since some actions rely on specific Bloc events or Navigation which might differ
// based on where we are, we can define a GlobalActions wrapper or just individual Action classes.
// For now, these are top-level functional actions that the main App widget will provide.

class GlobalActions {
  static Map<Type, Action<Intent>> getActions(BuildContext context) {
    final appCommandService = sl<AppCommandService>();
    final appTabService = sl<AppTabService>();

    return {
      OpenFileIntent: CallbackAction<OpenFileIntent>(
        onInvoke: (intent) {
          appTabService.select(1);
          appCommandService.emit(
            const AppCommand(AppCommandType.openFiles),
          );
          return null;
        },
      ),
      OpenFolderIntent: CallbackAction<OpenFolderIntent>(
        onInvoke: (intent) {
          appTabService.select(4);
          appCommandService.emit(
            const AppCommand(AppCommandType.openFolder),
          );
          return null;
        },
      ),
      ExportIntent: CallbackAction<ExportIntent>(
        onInvoke: (intent) {
          appTabService.select(1);
          appCommandService.emit(
            const AppCommand(AppCommandType.exportResults),
          );
          return null;
        },
      ),
      OpenSettingsIntent: CallbackAction<OpenSettingsIntent>(
        onInvoke: (intent) {
          appTabService.select(6);
          return null;
        },
      ),
      ZoomInIntent: CallbackAction<ZoomInIntent>(
        onInvoke: (intent) {
          _adjustDiffFontSize(context, 1.0);
          return null;
        },
      ),
      ZoomOutIntent: CallbackAction<ZoomOutIntent>(
        onInvoke: (intent) {
          _adjustDiffFontSize(context, -1.0);
          return null;
        },
      ),
      ResetZoomIntent: CallbackAction<ResetZoomIntent>(
        onInvoke: (intent) {
          _resetDiffFontSize(context);
          return null;
        },
      ),
    };
  }

  static void _adjustDiffFontSize(BuildContext context, double delta) {
    final settingsBloc = context.read<SettingsBloc>();
    if (settingsBloc.state.status != SettingsStatus.loaded) {
      return;
    }
    final currentSize = settingsBloc.state.appSettings.diffFontSize;
    final nextSize = (currentSize + delta).clamp(8.0, 32.0);
    settingsBloc.add(UpdateDiffFontSize(nextSize));
  }

  static void _resetDiffFontSize(BuildContext context) {
    final settingsBloc = context.read<SettingsBloc>();
    if (settingsBloc.state.status != SettingsStatus.loaded) {
      return;
    }
    final defaultSize = AppSettings.defaultSettings().diffFontSize;
    settingsBloc.add(UpdateDiffFontSize(defaultSize));
  }
}
