import 'package:flutter_bloc/flutter_bloc.dart';

import 'carousel_event.dart';
import 'carousel_state.dart';

class SliderBloc extends Bloc<SliderOnChanged, SliderState> {
  final int currentSliderIndex = 1;

  SliderBloc() : super(SliderState(currentSliderIndex: 1)) {
    on<SliderOnChanged>((event, emit) {
      emit(SliderState(currentSliderIndex: event.currentSliderIndex));
      print("Slider New Index; ${event.currentSliderIndex}");
    });
  }
}
