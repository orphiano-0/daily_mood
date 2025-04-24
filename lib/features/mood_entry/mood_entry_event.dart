abstract class MoodEvent {}

class LoadMoodEntries extends MoodEvent {}

class AddMoodEntry extends MoodEvent {
  final double moodScore;
  final String journalEntry;

  AddMoodEntry({required this.moodScore, required this.journalEntry});
}

class DeleteMoodEntry extends MoodEvent {
  final int id;

  DeleteMoodEntry({required this.id});
}

class ClearAllMoodEntries extends MoodEvent {
  List<Object> get props => [];
}

