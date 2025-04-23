import 'package:daily_moode/shared/widgets/mood_navigation.dart';
import 'package:flutter/material.dart';

class MoodEntry extends StatelessWidget {
  const MoodEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'Pixel',
          ),
        ),
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
      ),
      bottomNavigationBar: MoodNavigationBar(),
    );
  }
}
