import 'package:daily_moode/screens/main_screen.dart';
import 'package:daily_moode/screens/mood_diary.dart';
import 'package:daily_moode/screens/mood_lists.dart';
import 'package:daily_moode/screens/mood_settings.dart';
import 'package:daily_moode/screens/mood_stats.dart';
import 'package:daily_moode/screens/mood_details.dart';
import 'package:daily_moode/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const MoodDiaryScreen(),
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const MoodLists(),
        ),
        GoRoute(
          path: '/statistics',
          builder: (context, state) => const MoodStats(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const MoodSettings(),
        ),
        GoRoute(
          path: '/detail/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return MoodDiaryScreen();
          },
        ),
      ],
    ),
  ],
);