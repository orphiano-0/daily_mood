import 'package:flutter/material.dart';

import '../shared/widgets/mood_navigation.dart';

class MoodSettings extends StatelessWidget {
  const MoodSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'Pixel',
          ),
        ),
        backgroundColor: Color(0xffC0B2C3),
        centerTitle: true,
      ),
    );
  }
}
