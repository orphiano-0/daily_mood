import 'package:daily_moode/screens/main_screen.dart';
import 'package:daily_moode/screens/mood_details.dart';
import 'package:daily_moode/screens/mood_entry/mood_entry.dart';
import 'package:daily_moode/screens/mood_history/mood_history.dart';
import 'package:daily_moode/screens/mood_settings/mood_settings.dart';
import 'package:daily_moode/screens/mood_settings/settings_mood.dart';
import 'package:daily_moode/screens/mood_stats/mood_stats.dart';
import 'package:flutter/widgets.dart';
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
          path: '/',
          pageBuilder: (context, state) => fadeTransition(MoodEntry(), state),
        ),
        GoRoute(
          path: '/diary',
          pageBuilder: (context, state) => fadeTransition(MoodHistory(), state),
        ),

        // GoRoute(path: '/diary', builder: (context, state) => MoodHistory()),
        GoRoute(
          path: '/moodDetails/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return MoodDetailScreen(id: id);
          },
        ),
        GoRoute(
          path: '/statistics',
          pageBuilder: (context, state) => fadeTransition(MoodStats(), state),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder:
              (context, state) => fadeTransition(SettingsMood(), state),
        ),
      ],
    ),
  ],
);

CustomTransitionPage fadeTransition(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
