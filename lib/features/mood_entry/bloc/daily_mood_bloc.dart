import 'package:daily_moode/features/mood_entry/bloc/daily_mood_event.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_state.dart';
import 'package:daily_moode/features/mood_entry/models/mood_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final Box<MoodModel> moodBox;

  MoodBloc(this.moodBox) : super(MoodInitial()) {

    on<AddMoodEvent>((event, emit) async {
      moodBox.put(event.entry.moodId, event.entry); // Ensure moodId is unique
      emit(MoodAdded(entry: event.entry));
      print("Added Mood: ${event.entry}");
    });

    on<LoadMoodEvent>((event, emit) async {
      final moods = moodBox.values.toList();
      emit(MoodLoaded(entry: moods));
      print("Loaded moods: ${moods}"); // Debugging print
    });


    on<DeleteMoodEvent>((event, emit) async {
      emit(MoodDelete(entry: event.entry));
    });
  }
}