import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MySocialiconsLong extends StatelessWidget {
  final String text;
  final String assetUrl;
  final VoidCallback voidCallback;

  const MySocialiconsLong({
    super.key,
    required this.text,
    required this.assetUrl,
    required this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white60, // optional background
            borderRadius: BorderRadius.circular(40), // rounded corners
            border: Border.all(
              color: Theme.of(context).colorScheme.tertiary, // border color
              width: 1, // border thickness
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: width * 0.025,
          ), // optional padding inside the border

          child: Stack(
            alignment: AlignmentGeometry.center,

            children: [
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: SvgPicture.asset(
                  assetUrl,
                  width: width * 0.07,
                  height: width * 0.07,
                ),
              ),

              Text(
                text,
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
        ),
      ),
    );
  }
}
