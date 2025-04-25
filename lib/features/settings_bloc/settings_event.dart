import 'package:daily_moode/features/mood_entry/models/mood_models.dart';

abstract class SettingEvent {}

class LightThemeSelected extends SettingEvent {}

class DarkThemeSelected extends SettingEvent {}

class DeleteData extends SettingEvent {
  final MoodModel allData;

  DeleteData({required this.allData});
}