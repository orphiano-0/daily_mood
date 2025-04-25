import 'package:equatable/equatable.dart';

import '../models/mood_models.dart';

abstract class MoodEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddMoodEvent extends MoodEvent {
  final MoodModel entry;

  AddMoodEvent(this.entry);

  @override
  List<Object?> get props => [];
}

class LoadMoodEvent extends MoodEvent {}

class DeleteMoodEvent extends MoodEvent {
  final int entryId;

  DeleteMoodEvent(this.entryId);

  @override
  List<Object?> get props => [entryId];
}
