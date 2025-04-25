import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primaryColor: Colors.blueAccent,
  colorScheme: ColorScheme.dark(
    primary: Colors.blueAccent,
    secondary: Colors.lightBlueAccent,
    surface: const Color(0xFF2A2A2A),
    error: Colors.redAccent,
    inversePrimary: Colors.white
  )
);