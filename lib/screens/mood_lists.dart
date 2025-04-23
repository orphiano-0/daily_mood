import 'package:flutter/material.dart';

import '../shared/widgets/mood_navigation.dart';

class MoodLists extends StatelessWidget {
  const MoodLists({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
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
