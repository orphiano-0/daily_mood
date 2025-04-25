import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primaryColor: Colors.blueAccent,
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1F1F1F),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  cardTheme: CardTheme(
    color: const Color(0xFF2A2A2A),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.blueAccent,
    ),
  ),
  sliderTheme: const SliderThemeData(
    activeTrackColor: Colors.blueAccent,
    thumbColor: Colors.blueAccent,
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.blueAccent,
    secondary: Colors.lightBlueAccent,
    surface: const Color(0xFF2A2A2A),
    error: Colors.redAccent,
    inversePrimary: Colors.white
  ),
  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xFF2A2A2A),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);