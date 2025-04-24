import 'package:daily_moode/features/navigation_bloc/navigation_bloc.dart';
import 'package:daily_moode/features/navigation_bloc/navigation_state.dart';
import 'package:daily_moode/screens/mood_entry.dart';
import 'package:daily_moode/screens/mood_lists.dart';
import 'package:daily_moode/screens/mood_settings.dart';
import 'package:daily_moode/screens/mood_stats.dart';
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
    return Scaffold(body: Center(child: Text('Hello')));
  }
}
