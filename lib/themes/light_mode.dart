import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.black,
    secondary: Color(0xFFFF3EA4), // <-- Use 0xFF + your hex code
    tertiary: Colors.grey,
  ),
);
