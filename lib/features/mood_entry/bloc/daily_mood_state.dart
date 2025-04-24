import 'package:daily_moode/features/mood_entry/models/mood_models.dart';
import 'package:equatable/equatable.dart';

abstract class MoodState extends Equatable {
  const MoodState();

  @override
  List<Object?> get props => [];
}

class MoodInitial extends MoodState {}

class MoodAdded extends MoodState {
  final MoodModel entry;

  const MoodAdded({required this.entry});
}

class MoodLoaded extends MoodState {
  final List<MoodModel> entry;

  const MoodLoaded({required this.entry});

  @override
  List<Object?> get props => [entry];
}

class MoodDelete extends MoodState {
  final MoodModel entry;

  const MoodDelete({required this.entry});

}


