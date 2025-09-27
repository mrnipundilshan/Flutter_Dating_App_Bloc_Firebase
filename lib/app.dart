import 'package:datingapp/features/auth/data/firebase_auth_repo.dart';
import 'package:datingapp/features/home/home_page.dart';
import 'package:datingapp/features/auth/presentation/pages/auth_page.dart';
import 'package:datingapp/features/auth/presentation/pages/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // <-- important

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
          create: (context) =>
              AuthBloc(authRepository: firebaseAuthrepo)..add(AuthCheck()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const HomePage();
            } else if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const AuthPage();
            }
          },
        ),
      ),
    );
  }
}
