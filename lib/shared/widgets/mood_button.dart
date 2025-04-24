import 'package:flutter/material.dart';

class MoodButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  const MoodButton({super.key, required this.text, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 4),
        ),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: 'Pixel', // You’ll need to add this pixel font
          ),
        ),
      ),
    );
  }
}
