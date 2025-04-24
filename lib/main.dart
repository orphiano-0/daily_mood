import 'package:daily_moode/features/navigation_bloc/navigation_state.dart';
import 'package:daily_moode/screens/main_screen.dart';
import 'package:daily_moode/screens/mood_entry.dart';
import 'package:daily_moode/screens/mood_lists.dart';
import 'package:daily_moode/screens/mood_settings.dart';
import 'package:daily_moode/screens/mood_stats.dart';
import 'package:daily_moode/shared/widgets/mood_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/mood_entry/mood_entry_bloc.dart';
import 'features/navigation_bloc/navigation_bloc.dart';
import 'routes/app_router.dart';
import 'features/mood_entry/repositories/mood_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final repository = MoodRepository(prefs);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(create: (_) => MoodBloc(repository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
