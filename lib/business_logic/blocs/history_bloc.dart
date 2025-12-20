import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/repositories/history_repository.dart';

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

// States
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<ComparisonSession> history;
  HistoryLoaded(this.history);
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
}

// BLoC
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository historyRepository;
  ComparisonSession? _lastDeletedSession;

  HistoryBloc({required this.historyRepository}) : super(HistoryInitial()) {
    on<LoadHistory>(_onLoadHistory);
    on<AddToHistory>(_onAddToHistory);
    on<DeleteHistoryItem>(_onDeleteHistoryItem);
    on<ClearHistory>(_onClearHistory);
    on<UndoDeleteHistoryItem>(_onUndoDeleteHistoryItem);
  }

  Future<void> _onLoadHistory(LoadHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final history = await historyRepository.getComparisonHistory();
      emit(HistoryLoaded(history));
    } catch (e) {
      emit(HistoryError('Failed to load history: ${e.toString()}'));
    }
  }

  Future<void> _onAddToHistory(AddToHistory event, Emitter<HistoryState> emit) async {
    try {
      await historyRepository.addComparisonToHistory(event.session);
      add(LoadHistory()); 
    } catch (e) {
      emit(HistoryError('Failed to add to history: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteHistoryItem(DeleteHistoryItem event, Emitter<HistoryState> emit) async {
    try {
      // Find the session before deleting it to allow for Undo
      if (state is HistoryLoaded) {
          final sessions = (state as HistoryLoaded).history;
          _lastDeletedSession = sessions.firstWhere((s) => s.id == event.sessionId);
      }

      await historyRepository.deleteSession(event.sessionId);
      add(LoadHistory());
    } catch (e) {
      emit(HistoryError('Failed to delete history item: ${e.toString()}'));
    }
  }

  Future<void> _onUndoDeleteHistoryItem(UndoDeleteHistoryItem event, Emitter<HistoryState> emit) async {
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



  Future<void> _onClearHistory(ClearHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading()); // Or a specific 'ClearingHistory' state
    try {
      await historyRepository.clearHistory();
      emit(HistoryLoaded([])); // Emit empty list after clearing
    } catch (e) {
      emit(HistoryError('Failed to clear history: ${e.toString()}'));
    }
  }
} 