import 'package:datingapp/features/auth/presentation/components/my_socialicons.dart';
import 'package:datingapp/features/auth/presentation/components/my_textfield.dart';
import 'package:datingapp/features/auth/presentation/pages/bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;
  const LoginPage({super.key, this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  // Initialize as nullable bool for null safety
  bool? checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            context.read<AuthBloc>().add(BackButtonClickedEvent());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome Back 👋",

                  style: GoogleFonts.patrickHand(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.09,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "Your AI-powered dating adventure awaits",
                  style: GoogleFonts.patrickHand(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,

                      fontSize: width * 0.05,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              // email
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: GoogleFonts.patrickHand(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: width * 0.05,
                    ),
                  ),
                ),
              ),

              MyTextfield(
                controller: emailTextController,
                prefixIcon: CupertinoIcons.mail,

                hintText: "Email",
                obscureText: false,
              ),

              SizedBox(height: height * 0.01),

              // password
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: GoogleFonts.patrickHand(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: width * 0.05,
                    ),
                  ),
                ),
              ),

              MyTextfield(
                controller: passwordTextController,
                prefixIcon: CupertinoIcons.lock,
                suffixIcon: CupertinoIcons.eye,
                hintText: "Password",
                obscureText: true,
              ),

              SizedBox(height: height * 0.01),

              // terms and conditions
              Transform.translate(
                offset: const Offset(-10, 0), // move checkbox left
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Theme.of(context).colorScheme.secondary,
                          side: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary, // border always visible
                            width: 2,
                          ),
                          value: checkBoxValue,
                          onChanged: (bool? newValue) {
                            setState(() {
                              checkBoxValue = newValue;
                            });
                          },
                        ),
                        Text(
                          "Remember me",
                          style: GoogleFonts.patrickHand(
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w100,
                              fontSize: width * 0.05,
                            ),
                          ),
                        ),
                      ],
                    ),

                    GestureDetector(
                      child: Text(
                        " Forgot Password?",
                        style: GoogleFonts.patrickHand(
                          textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w100,
                            fontSize: width * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //  have not account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Still haven't Account?",
                    style: GoogleFonts.patrickHand(
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w100,
                        fontSize: width * 0.05,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(SignUpTextClickedEvent());
                    },
                    child: Text(
                      " Sign up",
                      style: GoogleFonts.patrickHand(
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w100,
                          fontSize: width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.02),

              // sign up button
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Log In",
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
              SizedBox(height: height * 0.02),
              // or continue with
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // left divider
                  SizedBox(
                    width: width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Divider(
                        color: Theme.of(context).colorScheme.tertiary,
                        thickness: 1,
                        endIndent: 8, // space between line and text
                      ),
                    ),
                  ),

                  // text in the middle
                  Text(
                    "or continue with",
                    style: GoogleFonts.patrickHand(
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: width * 0.05,
                      ),
                    ),
                  ),

                  // right divider
                  SizedBox(
                    width: width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Divider(
                        color: Theme.of(context).colorScheme.tertiary,
                        thickness: 1,
                        indent: 8, // space between text and line
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.02),

              // social buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MySocialicons(
                    assetUrl: "assets/google.svg",
                    voidCallback: () {},
                  ),
                  MySocialicons(
                    assetUrl: "assets/apple.svg",
                    voidCallback: () {},
                  ),
                  MySocialicons(
                    assetUrl: "assets/facebook.svg",
                    voidCallback: () {},
                  ),
                  MySocialicons(
                    assetUrl: "assets/twitter.svg",
                    voidCallback: () {},
                  ),
                ],
              ),

              SizedBox(height: height * 0.07),
            ],
          ),
        ),
      ),
    );
  }
}
