import 'package:flutter/material.dart';

class MoodJournalEntry extends StatelessWidget {
  final TextEditingController journalEntry;

  const MoodJournalEntry({super.key, required this.journalEntry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        controller: journalEntry,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: "Write your journal entry here...",
          // Placeholder text
          hintStyle: const TextStyle(color: Colors.grey),
          // Styling for hint text
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
            borderSide: const BorderSide(color: Colors.grey), // Border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.blue, width: 2), // Focused border
          ),
          filled: true,
          // Enable background color
          fillColor: Colors.white,
          // Background color
          contentPadding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: 16), // Inner padding
        ),
        style: const TextStyle(fontSize: 16), // Text style for journal entry
      ),
    );
  }
}
