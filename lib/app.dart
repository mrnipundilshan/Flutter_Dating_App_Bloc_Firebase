import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/features/auth/data/firebase_auth_repo.dart';
import 'package:datingapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:datingapp/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:datingapp/features/chat/data/services/chat_service.dart';
import 'package:datingapp/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:datingapp/features/splash%20screen/splash_screen.dart';
import 'package:datingapp/themes/bloc/theme_bloc.dart';
import 'package:datingapp/themes/bloc/theme_state.dart';
import 'package:datingapp/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
  App - Root Level

  Repository for the database
  - firebase

  Bloc providers: for the state managment
  - auth: handles authentication state
  - theme: handles theme switching
  - chat: handles chat functionality (messages, seen status)

  check auth state
  - unauthenticated -> auth page (login/register)
  - authenticated -> home page
*/

class MainApp extends StatelessWidget {
  MainApp({super.key});

  // auth repo
  final firebaseAuthrepo = FirebaseAuthRepo();

  // chat dependency chain: ChatBloc → ChatRepositories → ChatService → FirebaseFirestore
  // Creating repository instance at root level for dependency injection
  // This allows ChatBloc to be provided app-wide, accessible from any screen
  final chatRepository = ChatRepositoryImpl(
    ChatService(FirebaseFirestore.instance),
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: firebaseAuthrepo),
        ),

        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),

        // ChatBloc provided at root level for app-wide access to chat functionality
        // Any screen can access ChatBloc via BlocProvider.of<ChatBloc>(context)
        BlocProvider<ChatBloc>(create: (context) => ChatBloc(chatRepository)),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,

          home: const SplashScreen(),
        ),
      ),
    );
  }
}
