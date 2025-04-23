import 'package:flutter/material.dart';

import '../shared/widgets/mood_navigation.dart';

class MoodStats extends StatelessWidget {
  const MoodStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistics',
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
