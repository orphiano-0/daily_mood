import 'package:flutter/material.dart';

class MoodDialog extends StatelessWidget {
  final String message;
  const MoodDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Confirm',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Pixel',
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'Pixel',
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Ok!',
            style: TextStyle(
              fontFamily: 'Pixel',
            ),
          ),
        ),
      ],
    );
  }
}
