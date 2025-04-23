import 'package:flutter/material.dart';
import 'dart:convert';

class MoodEntry {
  final int id;
  final DateTime timestamp;
  final double moodScore; // 1-10 mood score
  final String journalEntry;

  MoodEntry({
    required this.id,
    required this.timestamp,
    required this.moodScore,
    required this.journalEntry,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'moodScore': moodScore,
      'journalEntry': journalEntry,
    };
  }

  String toJson() => json.encode(toMap());

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      id: map['id'],
      timestamp: DateTime.parse(map['timestamp']),
      moodScore: map['moodScore'],
      journalEntry: map['journalEntry'],
    );
  }

  factory MoodEntry.fromJson(String source) =>
      MoodEntry.fromMap(json.decode(source));

  String getMoodLabel() {
    if (moodScore >= 9) return 'Excellent';
    if (moodScore >= 7) return 'Happy';
    if (moodScore >= 5) return 'Good';
    if (moodScore >= 3) return 'Okay';
    if (moodScore >= 1) return 'Sad';
    return 'Terrible';
  }

  Color getMoodColor() {
    if (moodScore >= 9) return Colors.purple;
    if (moodScore >= 7) return Colors.blue;
    if (moodScore >= 5) return Colors.green;
    if (moodScore >= 3) return Colors.amber;
    if (moodScore >= 1) return Colors.orange;
    return Colors.red;
  }
}