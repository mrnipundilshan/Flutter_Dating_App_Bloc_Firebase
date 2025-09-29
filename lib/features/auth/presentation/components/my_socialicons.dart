import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MySocialicons extends StatelessWidget {
  final String assetUrl;
  final VoidCallback voidCallback;
  const MySocialicons({
    super.key,
    required this.assetUrl,
    required this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // optional background
          borderRadius: BorderRadius.circular(40), // rounded corners
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary, // border color
            width: 1, // border thickness
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: 8,
        ), // optional padding inside the border
        child: SvgPicture.asset(
          assetUrl,
          width: width * 0.07,
          height: width * 0.07,
        ),
      ),
    );
  }
}
