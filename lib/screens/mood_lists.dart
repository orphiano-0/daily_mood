import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../features/mood_entry/models/mood_model.dart';
import 'package:intl/intl.dart';

import '../features/mood_entry/mood_entry_bloc.dart';
import '../features/mood_entry/mood_entry_event.dart';
import '../features/mood_entry/mood_entry_state.dart';
import '../shared/widgets/mood_navigation.dart';

class MoodLists extends StatelessWidget {
  const MoodLists({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Entries'),
      ),
      body: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, state) {
          if (state is MoodInitial || state is MoodLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MoodError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is MoodLoaded) {
            final entries = state.entries;
            if (entries.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No mood entries yet',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.go('/dashboard'),
                      child: const Text('Add Entry'),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return _buildMoodCard(context, entry);
              },
            );
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
      bottomNavigationBar: MoodNavigationBar(),
    );
  }

  Widget _buildMoodCard(BuildContext context, MoodEntry entry) {
    final dateFormat = DateFormat('E, MMM d, y');
    final timeFormat = DateFormat('h:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => context.go('/detail/${entry.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: entry.getMoodColor(),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      entry.getMoodLabel(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        dateFormat.format(entry.timestamp),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        timeFormat.format(entry.timestamp),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                entry.journalEntry,
                style: const TextStyle(fontSize: 16),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => context.go('/detail/${entry.id}'),
                    child: const Text('Read More'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red[400],
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Entry?'),
                          content: const Text('This action cannot be undone.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<MoodBloc>().add(DeleteMoodEntry(id: entry.id));
                                Navigator.pop(context);
                              },
                              child: const Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
