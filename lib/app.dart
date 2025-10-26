import 'package:datingapp/features/auth/data/firebase_auth_repo.dart';
import 'package:datingapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:datingapp/features/splash%20screen/splash_screen.dart';
import 'package:datingapp/themes/bloc/theme_bloc.dart';
import 'package:datingapp/themes/bloc/theme_state.dart';
import 'package:datingapp/themes/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
  App - Root Level

  Repository for the database
  - firebase

  Bloc providers: for the state managment
  -auth

  check auth state
  - unauthenticated -> auth page (login/register)
  - authenticated -> home page
*/

class MainApp extends StatelessWidget {
  MainApp({super.key});

  // auth repo
  final firebaseAuthrepo = FirebaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: firebaseAuthrepo),
        ),

        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: darkMode,

          home: const SplashScreen(),
        ),
      ),
    );
  }
}
