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

class ClearHistory extends HistoryEvent {}

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

  HistoryBloc({required this.historyRepository}) : super(HistoryInitial()) {
    on<LoadHistory>(_onLoadHistory);
    on<AddToHistory>(_onAddToHistory);
    on<ClearHistory>(_onClearHistory);
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
    // No loading state for add, or a specific 'AddingToHistory' state if preferred
    try {
      await historyRepository.addComparisonToHistory(event.session);
      // After adding, reload the history to reflect the change
      add(LoadHistory()); 
    } catch (e) {
      emit(HistoryError('Failed to add to history: ${e.toString()}'));
      // Optionally, re-emit previous loaded state if available
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