import 'package:flutter/material.dart';

class MoodJournalEntry extends StatelessWidget {
  final TextEditingController journalEntry;

  const MoodJournalEntry({super.key, required this.journalEntry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8EF),
        border: Border.all(
          color: const Color(0xFF222222),
          width: 3,
        ),
        borderRadius: BorderRadius.zero,
      ),
      child: TextField(
        controller: journalEntry,
        maxLines: 9,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "Write your journal entry here...",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Pixel',
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
        ),
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontFamily: 'Pixel',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
