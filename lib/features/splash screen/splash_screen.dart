import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                strokeCap:
                    StrokeCap.round, // Rounded edges for a polished appearance
              ),
            ),
          ],
        ),
      ),
    );
  }
}
