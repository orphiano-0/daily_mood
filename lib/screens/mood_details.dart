import 'package:flutter/material.dart';

class MoodDetailScreen extends StatelessWidget {
  final int id;

  const MoodDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Detail'),
      ),
      body: Center(
        child: Text('Displaying details for mood entry ID: $id'),
      ),
    );
  }
}