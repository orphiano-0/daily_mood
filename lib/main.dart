import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/mood_entry/mood_entry_bloc.dart';
import 'features/navigation_bloc/navigation_bloc.dart';
import 'features/mood_entry/repositories/mood_repository.dart';
import 'shared/theme/theme_controller.dart';
import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final repository = MoodRepository(prefs);
  await ThemeController.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController.instance),
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
    final themeController = Provider.of<ThemeController>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mood Tracker',
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      themeMode: themeController.themeMode,
      routerConfig: router,
    );
  }
}