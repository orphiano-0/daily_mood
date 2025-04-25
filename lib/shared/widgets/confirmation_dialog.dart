import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const ConfirmationDialog({super.key, required this.onPressed, required this.text});

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
        text,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Pixel',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontFamily: 'Pixel',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onPressed();
          },
          child: const Text(
            'Confirm',
            style: TextStyle(
              fontFamily: 'Pixel',
            ),
          ),
        ),
      ],
    );
  }
}
