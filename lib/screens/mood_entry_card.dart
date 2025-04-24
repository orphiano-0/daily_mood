import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../features/mood_entry/models/mood_model.dart' as mood_model;

class MoodEntryCard extends StatelessWidget {
  final mood_model.MoodEntry entry;

  const MoodEntryCard({required this.entry, super.key});

  String _getMoodEmoji(double moodScore) {
    if (moodScore >= 9) return '😁';
    if (moodScore >= 7) return '😊';
    if (moodScore >= 5) return '🙂';
    if (moodScore >= 3) return '😐';
    if (moodScore >= 1) return '☹️';
    return '😭';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Text(
          _getMoodEmoji(entry.moodScore), // Derive emoji from moodScore
          style: const TextStyle(fontSize: 32),
        ),
        title: Text(
          entry.journalEntry ?? 'No journal entry', // Default text if null
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          entry.timestamp != null
              ? DateFormat('hh:mm a').format(entry.timestamp!)
              : 'Unknown time', // Default text if timestamp is null
        ),
      ),
    );
  }
}