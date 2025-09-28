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
                "Email",
                style: GoogleFonts.patrickHand(
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: width * 0.05,
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
