import 'package:datingapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:datingapp/features/home/home_page.dart';
import 'package:datingapp/features/welcome%20screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger splash initialization after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AuthBloc>().add(SplashInitialized());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        }
        if (state is Unauthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          );
        }
      },
      builder: (context, state) {
        // Show splash screen by default, hide only when navigation states are reached
        if (state is Authenticated || state is Unauthenticated) {
          return const SizedBox.shrink();
        }

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: width * 0.00),
                Column(
                  children: [
                    SvgPicture.asset(
                      "assets/logo.svg",
                      width: width * 0.25,
                      height: width * 0.25,
                    ),
                    SizedBox(height: width * 0.03),
                    Text(
                      "Lovify",
                      style: GoogleFonts.patrickHand(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 5.0,
                    backgroundColor: Colors.white.withAlpha(51),
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
