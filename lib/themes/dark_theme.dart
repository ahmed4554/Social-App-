import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 44, 44, 44),
        titleTextStyle: TextStyle(color: Colors.white)),
    scaffoldBackgroundColor: const Color.fromARGB(255, 44, 44, 44),
    platform: TargetPlatform.iOS,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 20.0,
      backgroundColor: Color.fromARGB(255, 44, 44, 44),
      unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
    ),
  );
}
