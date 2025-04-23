import 'models/mood_model.dart';

abstract class MoodState {}

class MoodInitial extends MoodState {}

class MoodLoading extends MoodState {}

class MoodLoaded extends MoodState {
  final List<MoodEntry> entries;

  MoodLoaded({required this.entries});
}

class MoodError extends MoodState {
  final String message;

  MoodError({required this.message});
}