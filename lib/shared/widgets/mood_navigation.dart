import 'package:daily_moode/features/navigation_bloc/navigation_bloc.dart';
import 'package:daily_moode/features/navigation_bloc/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/navigation_bloc/navigation_event.dart';

class MoodNavigationBar extends StatelessWidget {
  const MoodNavigationBar({super.key});

  static const List<String> routes = [
    '/',
    '/diary',
    '/statistics',
    '/settings',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              if (state.currentIndex != index) {
                context.read<NavigationBloc>().add(NavigationOnChanged(index));
                context.go(routes[index]);
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Diary'),
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart),
                label: 'Stats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            selectedItemColor: Colors.greenAccent,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.blueGrey.shade900,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Pixel',
              fontSize: 10,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Pixel',
              fontSize: 10,
            ),
          ),
        );
      },
    );
  }
}
