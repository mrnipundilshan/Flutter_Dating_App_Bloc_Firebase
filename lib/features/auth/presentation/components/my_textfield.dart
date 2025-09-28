import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextfield extends StatefulWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String hintText;
  final bool obscureText;
  const MyTextfield({
    super.key,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    required this.obscureText,
  });

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  bool _obsecure = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return TextField(
      obscureText: widget.obscureText && _obsecure,

      style: GoogleFonts.patrickHand(
        textStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: width * 0.05,
        ),
      ),
      controller: widget.controller,

      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: GoogleFonts.patrickHand(
          textStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary.withAlpha(100),
            fontSize: width * 0.05,
          ),
        ),
        prefixIcon: Opacity(opacity: 0.5, child: Icon(widget.prefixIcon)),

        // Wrap suffix in GestureDetector so it’s clickable
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obsecure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                ),
                onPressed: () => setState(() {
                  _obsecure = !_obsecure;
                }),
              )
            : null,

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
