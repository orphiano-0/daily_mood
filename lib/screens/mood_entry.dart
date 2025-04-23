import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../features/mood_entry/models/mood_model.dart';
import '../features/mood_entry/mood_entry_bloc.dart';
import '../features/mood_entry/mood_entry_event.dart';
import '../features/mood_entry/mood_entry_state.dart';

class MoodEntryScreen extends StatefulWidget {
  const MoodEntryScreen({super.key});

  @override
  State<MoodEntryScreen> createState() => _MoodEntryScreen();
}

class _MoodEntryScreen extends State<MoodEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _journalController = TextEditingController();
  double _moodScore = 5.0;

  String _getMoodEmoji() {
    if (_moodScore >= 9) return '😁';
    if (_moodScore >= 7) return '😊';
    if (_moodScore >= 5) return '🙂';
    if (_moodScore >= 3) return '😐';
    if (_moodScore >= 1) return '☹️';
    return '😭';
  }

  String _getMoodLabel() {
    if (_moodScore >= 9) return 'Excellent';
    if (_moodScore >= 7) return 'Happy';
    if (_moodScore >= 5) return 'Good';
    if (_moodScore >= 3) return 'Okay';
    if (_moodScore >= 1) return 'Sad';
    return 'Terrible';
  }

  Color _getMoodColor() {
    if (_moodScore >= 9) return Colors.purple;
    if (_moodScore >= 7) return Colors.blue;
    if (_moodScore >= 5) return Colors.green;
    if (_moodScore >= 3) return Colors.amber;
    if (_moodScore >= 1) return Colors.orange;
    return Colors.red;
  }

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Mood Entry'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => context.go('/'),
        // ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How are you feeling today?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    Text(
                      _getMoodEmoji(),
                      style: const TextStyle(fontSize: 72),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getMoodColor(),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _getMoodLabel(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Slider(
                value: _moodScore,
                min: 0,
                max: 10,
                divisions: 10,
                label: _moodScore.toStringAsFixed(1),
                activeColor: _getMoodColor(),
                onChanged: (value) {
                  setState(() {
                    _moodScore = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Terrible', style: TextStyle(color: Colors.grey[600])),
                  Text('Excellent', style: TextStyle(color: Colors.grey[600])),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Your Reflection',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Take a moment to write about how you\'re feeling and why.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _journalController,
                decoration: InputDecoration(
                  hintText: 'Share your thoughts...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please write a reflection';
                  }
                  if (value.trim().length < 5) {
                    return 'Please write a longer reflection';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final bloc = context.read<MoodBloc>();
                      bloc.add(AddMoodEntry(
                        moodScore: _moodScore,
                        journalEntry: _journalController.text.trim(),
                      ));
                      context.go('/');
                    }
                  },
                  child: const Text(
                    'Save Entry',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodDetailScreen extends StatelessWidget {
  final int id;

  const MoodDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodBloc, MoodState>(
      builder: (context, state) {
        if (state is MoodLoaded) {
          final entry = state.entries.firstWhere(
                (e) => e.id == id,
            orElse: () => MoodEntry(
              id: -1,
              timestamp: DateTime.now(),
              moodScore: 0,
              journalEntry: 'Entry not found',
            ),
          );

          if (entry.id == -1) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Entry Not Found'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/'),
                ),
              ),
              body: const Center(
                child: Text('The requested entry was not found.'),
              ),
            );
          }

          final dateFormat = DateFormat('EEEE, MMMM d, y');
          final timeFormat = DateFormat('h:mm a');

          return Scaffold(
            appBar: AppBar(
              title: const Text('Mood Details'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go('/'),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete),
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
                              context.go('/');
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
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date and Time
                  Text(
                    dateFormat.format(entry.timestamp),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    timeFormat.format(entry.timestamp),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Mood
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mood',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
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
                              const SizedBox(width: 12),
                              Text(
                                '${entry.moodScore.toStringAsFixed(1)}/10',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Journal Entry
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Reflection',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            entry.journalEntry,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Loading...'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/'),
            ),
          ),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}