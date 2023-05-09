import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData materialTheme() {
    return ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Color.fromARGB(255, 27, 36, 85),
        fontFamily: 'Roboto',
        useMaterial3: true,
        textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                color: Colors.white)));
  }
}
