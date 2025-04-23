import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../features/mood_entry/models/mood_model.dart';
import 'package:intl/intl.dart';

import '../features/mood_entry/mood_entry_bloc.dart';
import '../features/mood_entry/mood_entry_event.dart';
import '../features/mood_entry/mood_entry_state.dart';
import '../shared/widgets/mood_navigation.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Wow'),
      ),
      bottomNavigationBar: MoodNavigationBar(),
    );
  }


}
