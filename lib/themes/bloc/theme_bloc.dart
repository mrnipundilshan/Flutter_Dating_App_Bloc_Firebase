import 'dart:async';
import 'package:datingapp/themes/bloc/theme_event.dart';
import 'package:datingapp/themes/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<ToggleThemeEvent>(toggleThemeEvent);
  }

  Future<void> toggleThemeEvent(ToggleThemeEvent event, emit) async {
    if (state is LightThemeState) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }
}
