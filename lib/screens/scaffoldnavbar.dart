import 'package:daily_moode/features/navigation_bloc/navigation_bloc.dart';
import 'package:daily_moode/features/navigation_bloc/navigation_state.dart';
import 'package:daily_moode/shared/widgets/mood_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: child,
          bottomNavigationBar: const MoodNavigationBar(),
        );
      },
    );
  }
}
