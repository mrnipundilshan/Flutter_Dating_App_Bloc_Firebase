import 'package:datingapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF3EA4), // <-- Use 0xFF + your hex code
      body: Center(
        child: ElevatedButton(
          child: const Text("log out"),
          onPressed: () {
            context.read<AuthBloc>().add(LogOutButtonClickedEvent());
          },
        ),
      ),
    );
  }
}
