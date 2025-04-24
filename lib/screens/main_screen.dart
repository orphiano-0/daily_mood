import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/navigation_bloc/navigation_bloc.dart';
import '../features/navigation_bloc/navigation_state.dart';
import '../shared/widgets/mood_navigation.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

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
