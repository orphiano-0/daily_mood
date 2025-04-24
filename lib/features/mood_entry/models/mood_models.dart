import 'package:daily_moode/screens/utils/emoji_categories.dart';
import 'package:hive/hive.dart';

part 'mood_models.g.dart';

@HiveType(typeId: 0)
class MoodModel {
  @HiveField(0)
  int moodId;

  @HiveField(1)
  int emojiId;

  @HiveField(2)
  String moodLog;

  @HiveField(3)
  DateTime timeStamp;

  MoodModel({
    required this.moodId,
    required this.emojiId,
    required this.moodLog,
    required this.timeStamp,
  });

  EmojiCategory get id => EmojiCategory.fromEmojiId(emojiId);
  set id(EmojiCategory emCat) => emojiId = emCat.emojiId;

  @override
  String toString() {
    return 'MoodModel(moodId: $moodId, emojiId: $emojiId, moodLog: $moodLog, timeStamp: $timeStamp)';
  }

}
