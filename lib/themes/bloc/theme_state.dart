import 'package:flutter/material.dart';
import 'package:datingapp/themes/light_mode.dart';
import 'package:datingapp/themes/dark_mode.dart';

abstract class ThemeState {
  final ThemeData themeData;
  final bool isDarkMode;

  ThemeState(this.themeData, this.isDarkMode);
}

class LightThemeState extends ThemeState {
  LightThemeState() : super(lightMode, false);
}

class DarkThemeState extends ThemeState {
  DarkThemeState() : super(darkMode, true);
}
