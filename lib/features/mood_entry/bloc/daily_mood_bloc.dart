import 'package:daily_moode/features/mood_entry/bloc/daily_mood_event.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_state.dart';
import 'package:daily_moode/features/mood_entry/models/mood_models.dart';
import 'package:daily_moode/features/mood_entry/repositories/log_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  // final Box<MoodModel> moodBox;
  final MoodRepository moodRepository;

  MoodBloc({required this.moodRepository}) : super(MoodInitial()) {
    on<LoadMoodEvent>(_onLoadMood);
    on<AddMoodEvent>(_onAddMoodEvent);
    on<DeleteMoodEvent>(_onDeleteMood);
  }

  Future<void> _onLoadMood(LoadMoodEvent event, Emitter<MoodState> emit) async {
    emit(MoodLoading());

    try {
      final box = await Hive.openBox<MoodModel>('daily_moods');
      final moods = box.values.toList();
      print('Moods: ${moods}');
      emit(MoodLoaded(entry: moods));
    } catch (e) {
      emit(MoodFailed('Failed to load Moods'));
    }
  }

  Future<void> _onAddMoodEvent(
    AddMoodEvent event,
    Emitter<MoodState> emit,
  ) async {
    print('Received Data: ${event.entry.toString()}');
    emit(MoodLoading());

    try {
      await moodRepository.entryMood(event.entry);

      emit(MoodAdded(entry: event.entry));
    } catch (e) {
      emit(MoodFailed('Failed to Add: ${e}'));
    }
  }

  Future<void> _onDeleteMood(
    DeleteMoodEvent event,
    Emitter<MoodState> emit,
  ) async {
    emit(MoodLoading());

    try {
      await moodRepository.deleteMood(event.entryId);
      final moodBox = Hive.box<MoodModel>('daily_moods');
      final mood = moodBox.values.toList();
      emit(MoodLoaded(entry: mood));
    } catch (e) {
      emit(MoodFailed('Failed to delete mood'));
    }
  }

  // MoodBloc(this.moodBox) : super(MoodInitial()) {
  //   on<AddMoodEvent>((event, emit) async {
  //     moodBox.put(event.entry.moodId, event.entry);
  //     // await
  //     emit(MoodAdded(entry: event.entry));
  //     print("Added Mood: ${event.entry}");
  //   });

  //   on<LoadMoodEvent>((event, emit) async {
  //     final moods = moodBox.values.toList();
  //     emit(MoodLoaded(entry: moods));
  //     print("Loaded moods: ${moods}"); // Debugging print
  //   });

  //   on<DeleteMoodEvent>((event, emit) async {
  //     emit(MoodDelete(entry: event.entry));
  //   });
  // }
}
