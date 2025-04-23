import 'package:daily_moode/screens/mood_entry.dart';
import 'package:daily_moode/screens/mood_lists.dart';
import 'package:daily_moode/screens/mood_settings.dart';
import 'package:daily_moode/screens/mood_stats.dart';
import 'package:go_router/go_router.dart';

import '../features/mood_entry/models/mood_model.dart';
import '../screens/main_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => MainScreen()),
    GoRoute(path: '/dashboard', builder: (context, state) => MoodEntryScreen()),
    GoRoute(path: '/history', builder: (context, state) => MoodLists()),
    GoRoute(path: '/statistics', builder: (context, state) => MoodStats()),
    GoRoute(path: '/settings', builder: (context, state) => MoodSettings()),
  ],
);