import 'package:daily_moode/features/navigation_bloc/navigation_bloc.dart';
import 'package:daily_moode/features/navigation_bloc/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/navigation_bloc/navigation_event.dart';

class MoodNavigationBar extends StatelessWidget {
  const MoodNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is NavigationState) {
          switch (state.currentIndex) {
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
        }
      },
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: Colors.blueGrey.shade900,
          currentIndex: state.currentIndex,
          selectedItemColor: Colors.greenAccent,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 24),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note, size: 24),
              label: 'LOGS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart, size: 24),
              label: 'STATS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 24),
              label: 'SETTINGS',
            ),
          ],
          onTap: (index) {
            context.read<NavigationBloc>().add(NavigationOnChanged(index));

          },
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Pixel',
            fontSize: 10,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Pixel',
            fontSize: 10,
          ),
        );
      },
    );
  }
}
