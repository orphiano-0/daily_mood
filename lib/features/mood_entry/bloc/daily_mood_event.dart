import 'package:equatable/equatable.dart';

import '../models/mood_models.dart';

abstract class MoodEvent extends Equatable {
  const MoodEvent();

  @override
  List<Object?> get props => [];
}

class AddMoodEvent extends MoodEvent {
  final MoodModel entry;

  const AddMoodEvent(this.entry);

  @override
  List<Object?> get props => [];
}

class LoadMoodEvent extends MoodEvent {}

class DeleteMoodEvent extends MoodEvent {
  final MoodModel entry;

  const DeleteMoodEvent(this.entry);

  @override
  List<Object?> get props => [entry];

}