// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodModelAdapter extends TypeAdapter<MoodModel> {
  @override
  final int typeId = 0;

  @override
  MoodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoodModel(
      moodId: fields[0] as int,
      emojiId: fields[1] as int,
      moodLog: fields[2] as String,
      timeStamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MoodModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.moodId)
      ..writeByte(1)
      ..write(obj.emojiId)
      ..writeByte(2)
      ..write(obj.moodLog)
      ..writeByte(3)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
