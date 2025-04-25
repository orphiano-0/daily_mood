import 'package:daily_moode/features/settings_bloc/settings_event.dart';
import 'package:daily_moode/features/settings_bloc/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  static const String themeKey = "selected_theme";

  SettingBloc() : super(LightTheme()) {
    on<LightThemeSelected>(_onLightThemeSelected);
    on<DarkThemeSelected>(_onDarkThemeSelected);

    _loadThemePreference();
  }

  void _onLightThemeSelected(LightThemeSelected event,
      Emitter<SettingState> emit) {
    emit(LightTheme());
    _saveThemePreference(isLightTheme: true);
  }

  void _onDarkThemeSelected(DarkThemeSelected event,
      Emitter<SettingState> emit) {
    emit(DarkTheme());
    _saveThemePreference(isLightTheme: false);
  }

  Future<void> _saveThemePreference({
    required bool isLightTheme
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isLightTheme);
  }

  Future<void> _loadThemePreference() async {
   final prefs = await SharedPreferences.getInstance();
   final isLightTheme = prefs.getBool(themeKey) ?? true;
   
   add(isLightTheme ? LightThemeSelected() : DarkThemeSelected());
  }
}