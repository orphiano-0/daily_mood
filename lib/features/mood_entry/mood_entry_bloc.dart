import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mood_entry_event.dart';
part 'mood_entry_state.dart';

class MoodEntryBloc extends Bloc<MoodEntryEvent, MoodEntryState> {
  MoodEntryBloc() : super(MoodEntryInitial()) {
    on<MoodEntryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
