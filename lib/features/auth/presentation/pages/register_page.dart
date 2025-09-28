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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: SafeArea(
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
                hintText: "Password",
                obscureText: true,
              ),

              SizedBox(height: height * 0.02),

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
                hintText: "Confirm Password",
                obscureText: true,
              ),

              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
