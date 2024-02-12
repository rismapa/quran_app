import 'package:flutter/material.dart';

Color green1 = const Color(0xFF004225);
Color green2 = const Color(0xFFB7E5B4);
Color white = Colors.white;

ThemeData appLight = ThemeData(
  primaryColor: white,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: white),
    backgroundColor: green1,
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      fontFamily: 'Poppins',
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: green1,
    ),
  ),
);

ThemeData appDark = ThemeData(
    primaryColor: white,
    scaffoldBackgroundColor: green1,
    appBarTheme: AppBarTheme(
      backgroundColor: green2,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: white,
      ),
    ));
