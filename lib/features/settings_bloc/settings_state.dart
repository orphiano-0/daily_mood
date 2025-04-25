import 'package:daily_moode/features/mood_entry/models/mood_models.dart';

abstract class SettingState {}

class LightTheme extends SettingState {}

class DarkTheme extends SettingState {}

class DeleteData extends SettingState {
  final MoodModel allData;

  DeleteData({required this.allData});
}