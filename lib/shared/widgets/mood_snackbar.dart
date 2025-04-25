import 'package:flutter/material.dart';

class MoodSnackBar {
  static SnackBar create(String text) {
    return SnackBar(
      content: Row(
        children: [
          Icon(Icons.sentiment_satisfied_alt, color: Colors.yellow.shade500,),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Pixel',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6,
    );
  }
}
