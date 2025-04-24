import 'package:daily_moode/screens/main_screen.dart';
import 'package:daily_moode/screens/mood_details.dart';
import 'package:daily_moode/screens/mood_entry.dart';
import 'package:daily_moode/screens/mood_lists.dart';
import 'package:daily_moode/screens/mood_settings.dart';
import 'package:daily_moode/screens/mood_stats.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => MoodLists()),
        GoRoute(path: '/diary', builder: (context, state) => MoodEntryScreen()),
        GoRoute(
          path: '/moodDetails/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return MoodDetailScreen(id: id);
          },
        ),
        GoRoute(path: '/statistics', builder: (context, state) => MoodStats()),
        GoRoute(path: '/settings', builder: (context, state) => MoodSettings()),
      ],
    ),
  ],
);
