import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoodNavigationBar extends StatelessWidget {
  const MoodNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: Colors.black),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.note, color: Colors.black),
        label: 'Logs',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.pie_chart, color: Colors.black),
        label: 'Statistics',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings, color: Colors.black),
        label: 'Settings',
      ),
    ],
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/dashboard');
            break;
          case 1:
            context.go('/history');
            break;
          case 2:
            context.go('/statistics');
            break;
          case 3:
            context.go('/settings');
            break;
        }
      },
    );
  }
}
