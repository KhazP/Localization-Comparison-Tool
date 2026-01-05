import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/repositories/history_repository.dart';

part 'history_bloc.freezed.dart';

// Events
abstract class HistoryEvent {}

class LoadHistory extends HistoryEvent {}

class AddToHistory extends HistoryEvent {
  final ComparisonSession session;
  AddToHistory(this.session);
}

class DeleteHistoryItem extends HistoryEvent {
  final String sessionId;
  DeleteHistoryItem(this.sessionId);
}

class ClearHistory extends HistoryEvent {}

class UndoDeleteHistoryItem extends HistoryEvent {}

class ImportHistory extends HistoryEvent {
  final List<ComparisonSession> sessions;
  ImportHistory(this.sessions);
}

// States
@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.initial() = HistoryInitial;
  const factory HistoryState.loading() = HistoryLoading;
  const factory HistoryState.loaded(List<ComparisonSession> history) =
      HistoryLoaded;
  const factory HistoryState.error(String message) = HistoryError;
}

// BLoC
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository historyRepository;
  ComparisonSession? _lastDeletedSession;
  late StreamSubscription _historySubscription;

  HistoryBloc({required this.historyRepository})
      : super(const HistoryInitial()) {
    _historySubscription = historyRepository.onHistoryChanged.listen((_) {
      add(LoadHistory());
    });

    on<LoadHistory>(_onLoadHistory);
    on<AddToHistory>(_onAddToHistory);
    on<DeleteHistoryItem>(_onDeleteHistoryItem);
    on<ClearHistory>(_onClearHistory);

    on<UndoDeleteHistoryItem>(_onUndoDeleteHistoryItem);
    on<ImportHistory>(_onImportHistory);
  }

  @override
  Future<void> close() {
    _historySubscription.cancel();
    return super.close();
  }

  Future<void> _onLoadHistory(
      LoadHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final history = await historyRepository.getComparisonHistory();
      emit(HistoryLoaded(history));
    } catch (e) {
      emit(HistoryError('Failed to load history: ${e.toString()}'));
    }
  }

  Future<void> _onAddToHistory(
      AddToHistory event, Emitter<HistoryState> emit) async {
    try {
      await historyRepository.addComparisonToHistory(event.session);
      add(LoadHistory());
    } catch (e) {
      emit(HistoryError('Failed to add to history: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteHistoryItem(
      DeleteHistoryItem event, Emitter<HistoryState> emit) async {
    try {
      // Find the session before deleting it to allow for Undo
      if (state is HistoryLoaded) {
        final sessions = (state as HistoryLoaded).history;
        _lastDeletedSession =
            sessions.firstWhere((s) => s.id == event.sessionId);
      }

      await historyRepository.deleteSession(event.sessionId);
      add(LoadHistory());
    } catch (e) {
      emit(HistoryError('Failed to delete history item: ${e.toString()}'));
    }
  }

  Future<void> _onUndoDeleteHistoryItem(
      UndoDeleteHistoryItem event, Emitter<HistoryState> emit) async {
    if (_lastDeletedSession != null) {
      try {
        await historyRepository.addComparisonToHistory(_lastDeletedSession!);
        _lastDeletedSession = null;
        add(LoadHistory());
      } catch (e) {
        emit(HistoryError('Failed to undo delete: ${e.toString()}'));
      }
    }
  }

  Future<void> _onClearHistory(
      ClearHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading()); // Or a specific 'ClearingHistory' state
    try {
      await historyRepository.clearHistory();
      emit(HistoryLoaded([])); // Emit empty list after clearing
    } catch (e) {
      emit(HistoryError('Failed to clear history: ${e.toString()}'));
    }
  }

  Future<void> _onImportHistory(
      ImportHistory event, Emitter<HistoryState> emit) async {
    try {
      // Add all sessions sequentially
      // Optimization: Could check if ID exists to avoid duplicates, but Hive put overwrites.
      for (final session in event.sessions) {
        await historyRepository.addComparisonToHistory(session);
      }
      add(LoadHistory());
    } catch (e) {
      emit(HistoryError('Failed to import history: ${e.toString()}'));
    }
  }
}
