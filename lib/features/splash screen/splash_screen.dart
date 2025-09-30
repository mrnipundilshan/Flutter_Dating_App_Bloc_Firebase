import 'package:datingapp/features/auth/presentation/pages/auth_welcome.dart';
import 'package:datingapp/features/auth/presentation/pages/bloc/auth_bloc.dart';
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
    _startSplash();
  }

  void _startSplash() async {
    // Wait 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Trigger auth check in bloc
    if (mounted) {
      context.read<AuthBloc>().add(AuthCheck());
    }
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
                  width: 60.0, // Increase width to make the indicator larger
                  height: 60.0, // Increase height to make the indicator larger
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ), // Sets the progress indicator color to white
                    strokeWidth:
                        5.0, // Thinner stroke for a modern, minimalist look
                    backgroundColor: Colors.white.withAlpha(
                      51,
                    ), // Subtle background for contrast
                    strokeCap: StrokeCap
                        .round, // Rounded edges for a polished appearance
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
