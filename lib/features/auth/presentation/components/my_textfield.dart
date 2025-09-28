import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return TextField(
      obscureText: obscureText,
      style: GoogleFonts.patrickHand(
        textStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: width * 0.05,
        ),
      ),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.patrickHand(
          textStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary.withAlpha(100),
            fontSize: width * 0.05,
          ),
        ),
        prefixIcon: Opacity(opacity: 0.5, child: Icon(CupertinoIcons.mail)),

        fillColor: Theme.of(context).colorScheme.tertiary.withAlpha(60),
        filled: true,

        // border when not active
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary.withAlpha(60),
          ),
        ),

        // border when active
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary.withAlpha(1000),
          ),
        ),
      ),
    );
  }
}
