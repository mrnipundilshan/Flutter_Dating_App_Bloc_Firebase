import 'package:datingapp/features/auth/presentation/components/my_socialicons.dart';
import 'package:datingapp/features/auth/presentation/components/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  // Initialize as nullable bool for null safety
  bool? checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Join Lovify Today ✨",
                style: GoogleFonts.patrickHand(
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.09,
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
              Text(
                "Name",
                style: GoogleFonts.patrickHand(
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: width * 0.05,
                  ),
                ),
              ),

              MyTextfield(
                controller: nameTextController,
                prefixIcon: CupertinoIcons.person,
                hintText: "Name",
                obscureText: false,
              ),

              SizedBox(height: height * 0.02),

              // email
              Text(
                "Email",
                style: GoogleFonts.patrickHand(
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: width * 0.05,
                  ),
                ),
              ),

              MyTextfield(
                controller: emailTextController,
                prefixIcon: CupertinoIcons.mail,

                hintText: "Email",
                obscureText: false,
              ),

              SizedBox(height: height * 0.02),

              // password
              Text(
                "Password",
                style: GoogleFonts.patrickHand(
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: width * 0.05,
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

              SizedBox(height: height * 0.02),

              // confirm password
              Text(
                "Confirm Password",
                style: GoogleFonts.patrickHand(
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: width * 0.05,
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

              SizedBox(height: height * 0.02),

              // terms and conditions
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
              // alread y have account
              Row(
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
                    child: Text(
                      " Sign in",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // left divider
                  Expanded(
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
                  Expanded(
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
            ],
          ),
        ),
      ),
    );
  }
}
