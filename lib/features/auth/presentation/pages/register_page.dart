import 'package:datingapp/core/components/my_snackbar.dart';
import 'package:datingapp/features/auth/presentation/components/my_socialicons.dart';
import 'package:datingapp/features/auth/presentation/components/my_textfield.dart';
import 'package:datingapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({super.key, this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  // Initialize as nullable bool for null safety
  bool checkBoxValue = false;

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
            Navigator.pop(context);
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
                  "Join Lovify Today ✨",

                  style: GoogleFonts.patrickHand(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.09,
                    ),
                  ),
                ),
              ),
              Text(
                "Create your account and start sparking connections today!",
                style: GoogleFonts.patrickHand(
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,

                    fontSize: width * 0.05,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              // name
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Name",
                  style: GoogleFonts.patrickHand(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: width * 0.05,
                    ),
                  ),
                ),
              ),

              MyTextfield(
                controller: nameTextController,
                prefixIcon: CupertinoIcons.person,
                hintText: "Name",
                obscureText: false,
              ),

              SizedBox(height: height * 0.01),

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

              // confirm password
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Confirm Password",
                  style: GoogleFonts.patrickHand(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: width * 0.05,
                    ),
                  ),
                ),
              ),

              MyTextfield(
                controller: confirmPasswordTextController,
                prefixIcon: CupertinoIcons.lock,
                suffixIcon: CupertinoIcons.eye,
                hintText: "Confirm Password",
                obscureText: true,
              ),

              SizedBox(height: height * 0.01),

              // terms and conditions
              Transform.translate(
                offset: const Offset(-10, 0), // move checkbox left
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                          checkBoxValue = newValue!;
                        });
                      },
                    ),
                    Text(
                      "I agree to Lovify",
                      style: GoogleFonts.patrickHand(
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w100,
                          fontSize: width * 0.05,
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        " Terms & Conditions.",
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
              // alread have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
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
                      context.read<AuthBloc>().add(SignInTextClickedEvent());
                    },
                    child: Text(
                      " Log In",
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
                onPressed: () {
                  if (checkBoxValue == false) {
                    mySnackbar(context, "Agree for terms and conditions");
                    return;
                  }

                  if (nameTextController.text.isEmpty ||
                      emailTextController.text.isEmpty ||
                      passwordTextController.text.isEmpty ||
                      confirmPasswordTextController.text.isEmpty) {
                    mySnackbar(context, "Fill all fields");
                    return;
                  }

                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(emailTextController.text.trim())) {
                    mySnackbar(context, "Please enter a valid email address");
                    return;
                  }

                  if (passwordTextController.text.trim().length < 6) {
                    mySnackbar(context, "password should 6 character length");
                    return;
                  }

                  context.read<AuthBloc>().add(
                    SignUpButtonClickedEvent(
                      name: nameTextController.text.trim(),
                      email: emailTextController.text.trim(),
                      password: passwordTextController.text.trim(),
                      confirmPassword: confirmPasswordTextController.text
                          .trim(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Sign up",
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
