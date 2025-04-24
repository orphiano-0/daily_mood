import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../features/mood_entry/models/mood_model.dart' as mood_model; // Alias to avoid conflict
import '../features/mood_entry/mood_entry_bloc.dart';
import '../features/mood_entry/mood_entry_state.dart';
import 'package:go_router/go_router.dart';

import 'mood_entry_card.dart';


class MoodDiaryScreen extends StatelessWidget {
  const MoodDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Pixel', // Use a pixelated font for retro style
          ),
        ),
        backgroundColor:
        Colors.blueGrey.shade900, // Dark background for retro feel
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home'); // Navigate back to the home screen
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Mood Diary',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MoodBloc, MoodState>(
              builder: (context, state) {
                if (state is MoodLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MoodLoaded) {
                  if (state.entries.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mood_bad,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No mood entries yet',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Group entries by date
                  final groupedEntries = <String, List<mood_model.MoodEntry>>{};

                  for (final entry in state.entries) {
                    final date = entry.timestamp != null
                        ? DateFormat('MMMM d, y').format(entry.timestamp!)
                        : 'Unknown Date';

                    if (!groupedEntries.containsKey(date)) {
                      groupedEntries[date] = [];
                    }

                    groupedEntries[date]!.add(entry);
                  }

                  return ListView.builder(
                    itemCount: groupedEntries.length,
                    itemBuilder: (context, index) {
                      final date = groupedEntries.keys.elementAt(index);
                      final entries = groupedEntries[date]!;

                      // Sort entries by timestamp (newest first)
                      entries.sort((a, b) => b.timestamp?.compareTo(a.timestamp ?? DateTime(0)) ?? 0);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  date,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: entries.length,
                            itemBuilder: (context, entryIndex) {
                              final entry = entries[entryIndex];
                              return MoodEntryCard(entry: entry); // Ensure MoodEntryCard is defined
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Something went wrong',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

