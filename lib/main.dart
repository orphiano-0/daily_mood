import 'package:daily_moode/routes/app_router.dart' as AppRouter;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/mood_entry/mood_entry_bloc.dart';
import 'features/navigation_bloc/navigation_bloc.dart';
import 'routes/app_router.dart';
import 'features/mood_entry/repositories/mood_repository.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//    MyApp({super.key});
//
//   // final prefs = await SharedPreferences.getInstance();
//   // final repository = MoodRepository(prefs);
//   var repository;
//   Future<void> _initPrefs() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     repository = MoodRepository(prefs);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => MoodBloc(repository),
//       child: MaterialApp.router(
//         title: 'Mood & Reflection Tracker',
//         theme: ThemeData(
//           primarySwatch: Colors.teal,
//           scaffoldBackgroundColor: Colors.grey[100],
//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.teal,
//             elevation: 0,
//           ),
//           elevatedButtonTheme: ElevatedButtonThemeData(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.teal,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//         ),
//         routerConfig: AppRouter.router,
//       ),
//     );
//   }
// }

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final repository = MoodRepository(prefs);
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => NavigationBloc()),BlocProvider(create: (_) => MoodBloc(repository)) ],
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