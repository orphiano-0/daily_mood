import 'package:daily_moode/features/mood_entry/repositories/mood_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/mood_model.dart';
import 'mood_entry_event.dart';
import 'mood_entry_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final MoodRepository _repository;
  List<MoodEntry> _entries = [];

  MoodBloc(this._repository) : super(MoodInitial()) {
    on<LoadMoodEntries>(_onLoadMoodEntries);
    on<AddMoodEntry>(_onAddMoodEntry);
    on<DeleteMoodEntry>(_onDeleteMoodEntry);
    on<ClearAllMoodEntries>(_onClearAllMoodEntries); // Added missing handler

    // Load entries when the bloc is created
    add(LoadMoodEntries());
  }

  Future<void> _onLoadMoodEntries(LoadMoodEntries event, Emitter<MoodState> emit) async {
    emit(MoodLoading());
    try {
      _entries = await _repository.getMoodEntries();
      emit(MoodLoaded(entries: _entries));
    } catch (e) {
      emit(MoodError(message: 'Failed to load mood entries: $e'));
    }
  }

  Future<void> _onAddMoodEntry(AddMoodEntry event, Emitter<MoodState> emit) async {
    emit(MoodLoading());
    try {
      final nextId = await _repository.getNextId();
      final newEntry = MoodEntry(
        id: nextId,
        timestamp: DateTime.now(),
        moodScore: event.moodScore,
        journalEntry: event.journalEntry,
      );

      _entries.add(newEntry);

      // Sort entries by most recent first
      _entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      // Save to persistent storage
      await _repository.saveMoodEntries(_entries);

      emit(MoodLoaded(entries: _entries));
    } catch (e) {
      emit(MoodError(message: 'Failed to add mood entry: $e'));
    }
  }

  Future<void> _onDeleteMoodEntry(DeleteMoodEntry event, Emitter<MoodState> emit) async {
    emit(MoodLoading());
    try {
      _entries.removeWhere((entry) => entry.id == event.id);

      // Save updated list to persistent storage
      await _repository.saveMoodEntries(_entries);

      emit(MoodLoaded(entries: _entries));
    } catch (e) {
      emit(MoodError(message: 'Failed to delete mood entry: $e'));
    }
  }

  // Added handler for ClearAllMoodEntries
  Future<void> _onClearAllMoodEntries(ClearAllMoodEntries event, Emitter<MoodState> emit) async {
    emit(MoodLoading());
    try {
      // Clear all entries from the list
      _entries.clear();

      // Save empty list to persistent storage
      await _repository.saveMoodEntries(_entries);

      emit(MoodLoaded(entries: _entries));
    } catch (e) {
      emit(MoodError(message: 'Failed to clear all mood entries: $e'));
    }
  }
}