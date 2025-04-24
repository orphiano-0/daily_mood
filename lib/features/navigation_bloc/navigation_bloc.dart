import 'package:daily_moode/features/navigation_bloc/navigation_event.dart';
import 'package:daily_moode/features/navigation_bloc/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final int currentIndex = 0;

  NavigationBloc() : super(NavigationState(currentIndex: 0)) {
    on<NavigationOnChanged>((event, emit) {
      emit(NavigationState(currentIndex: event.currentIndex));
    });
  }
}
