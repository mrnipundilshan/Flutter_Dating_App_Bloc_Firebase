import 'package:datingapp/features/auth/presentation/components/my_socialicons_long.dart';
import 'package:datingapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:datingapp/features/auth/presentation/pages/login_page.dart';
import 'package:datingapp/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthWelcome extends StatefulWidget {
  const AuthWelcome({super.key});

  @override
  State<AuthWelcome> createState() => _AuthWelcomeState();
}

class _AuthWelcomeState extends State<AuthWelcome> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  // Initialize as nullable bool for null safety
  bool? checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is NavigateToSignUp) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RegisterPage()),
          );
        }
        if (state is NavigateToSignIn) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        }
        if (state is NavigateToSignUpText) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RegisterPage()),
          );
        }
        if (state is NavigateToSignInText) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/logopink.svg",
                      width: width * 0.25,
                      height: width * 0.25,
                    ),
                    SizedBox(height: width * 0.03),
                    Text(
                      "Let's Get Started!",

                      style: GoogleFonts.patrickHand(
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.09,
                        ),
                      ),
                    ),
                    Text(
                      "Let's dive in into your account",
                      style: GoogleFonts.patrickHand(
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,

                          fontSize: width * 0.05,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    // social buttons
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MySocialiconsLong(
                          text: "Continue with Google",
                          assetUrl: "assets/google.svg",
                          voidCallback: () {},
                        ),
                        MySocialiconsLong(
                          text: "Continue with Apple",
                          assetUrl: "assets/apple.svg",
                          voidCallback: () {},
                        ),
                        MySocialiconsLong(
                          text: "Continue with Facebook",
                          assetUrl: "assets/facebook.svg",
                          voidCallback: () {},
                        ),
                        MySocialiconsLong(
                          text: "Continue with X",
                          assetUrl: "assets/twitter.svg",
                          voidCallback: () {},
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.04),

                    // sign up button
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RegisterPage()),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Sign up",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.patrickHand(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: width * 0.08,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.01),

                    // sign up button
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.white60,
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          SignInButtonClickedEvent(),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Sign in",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.patrickHand(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: width * 0.08,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.01),

                    Text(
                      "Privacy Policy . Terms of Service",
                      style: GoogleFonts.patrickHand(
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,

                          fontSize: width * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
