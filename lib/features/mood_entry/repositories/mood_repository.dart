import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mood_model.dart';

class MoodRepository {
  final SharedPreferences _prefs;
  final String _storageKey = 'mood_entries';

  MoodRepository(this._prefs);

  Future<List<MoodEntry>> getMoodEntries() async {
    try {
      final entriesJson = _prefs.getStringList(_storageKey) ?? [];
      final entries = entriesJson
          .map((json) => MoodEntry.fromJson(json))
          .toList();

      // Sort by timestamp (newest first)
      entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return entries;
    } catch (e) {
      // If there's an error reading, return an empty list
      return [];
    }
  }

  Future<bool> saveMoodEntries(List<MoodEntry> entries) async {
    try {
      final entriesJson = entries.map((entry) => entry.toJson()).toList();
      return await _prefs.setStringList(_storageKey, entriesJson);
    } catch (e) {
      return false;
    }
  }

  Future<int> getNextId() async {
    final entries = await getMoodEntries();
    if (entries.isEmpty) return 1;

    // Find the highest ID and add 1
    return entries.map((e) => e.id).reduce((max, id) => id > max ? id : max) + 1;
  }
}