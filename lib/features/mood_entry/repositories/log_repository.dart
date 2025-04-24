import 'package:daily_moode/features/mood_entry/models/mood_models.dart';
import 'package:hive/hive.dart';

class MoodRepository {
  static const String boxName = 'daily_moods';

  Future<void> entryMood(MoodModel moodId) async {
    final box = await Hive.openBox<MoodModel>(boxName);
    await box.put(moodId.id, moodId);
  }

  Future<MoodModel?> getMoodById(int id) async {
    final box = await Hive.openBox<MoodModel>(boxName);
    return box.get(id);
  }

  // Future<List<MoodModel>> getAllMood() async {
  //   final box = await Hive.openBox<MoodModel>(boxName);
  //   return box.values.toList();
  // }

  Future<void> deleteMood(MoodModel moodId) async {
    final box = await Hive.openBox<MoodModel>(boxName);
    await box.delete(moodId.id);
  }
}