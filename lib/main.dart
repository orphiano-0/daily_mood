import 'package:daily_moode/features/carousel_bloc/carousel_bloc.dart';
import 'package:daily_moode/features/mood_entry/bloc/daily_mood_bloc.dart';
import 'package:daily_moode/features/mood_entry/repositories/log_repository.dart';
import 'package:daily_moode/features/settings_bloc/settings_bloc.dart';
import 'package:daily_moode/features/settings_bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:daily_moode/shared/theme/dark_mode.dart';
import 'package:daily_moode/shared/theme/light_mode.dart';
import 'features/mood_entry/models/mood_models.dart';
import 'features/navigation_bloc/navigation_bloc.dart';
import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(MoodModelAdapter());
  final moodBox = await Hive.openBox<MoodModel>('daily_moods');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SettingBloc()),
        RepositoryProvider(create: (_) => MoodRepository()),
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(
          create:
              (context) =>
                  MoodBloc(moodRepository: context.read<MoodRepository>()),
        ),
        BlocProvider(create: (_) => SliderBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: state is LightTheme ? lightTheme : darkTheme,
        );
      },
    );
  }
}
