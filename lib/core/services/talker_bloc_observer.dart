import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerBlocObserver extends BlocObserver {
  TalkerBlocObserver({
    required Talker talker,
    this.settings = const TalkerBlocLoggerSettings(),
  }) : _talker = talker;

  final Talker _talker;
  final TalkerBlocLoggerSettings settings;

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (!settings.enabled || !settings.printEvent) return;
    _talker.logTyped(
      TalkerLog(
        '${bloc.runtimeType} event: $event',
        key: 'BLOC',
        pen: AnsiPen()..xterm(51), // Cyan/Blue
      ),
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (!settings.enabled || !settings.printTransition) return;
    _talker.logTyped(
      TalkerLog(
        '${bloc.runtimeType} transition: $transition',
        key: 'BLOC',
        pen: AnsiPen()..xterm(45), // Lighter Cyan
      ),
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (!settings.enabled || !settings.printError) return;
    _talker.handle(error, stackTrace, '${bloc.runtimeType} error');
  }
}

class TalkerBlocLoggerSettings {
  const TalkerBlocLoggerSettings({
    this.enabled = true,
    this.printEvent = true,
    this.printTransition = true,
    this.printError = true,
    this.printCreate = false,
    this.printClose = false,
  });

  final bool enabled;
  final bool printEvent;
  final bool printTransition;
  final bool printError;
  final bool printCreate;
  final bool printClose;
}
