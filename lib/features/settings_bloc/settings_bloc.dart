import 'package:daily_moode/features/settings_bloc/settings_event.dart';
import 'package:daily_moode/features/settings_bloc/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(LightTheme()) {
    on<LightThemeSelected>((event, emit) => emit(LightTheme()));
    on<DarkThemeSelected>((event, emit) => emit(DarkTheme()));
  }
}