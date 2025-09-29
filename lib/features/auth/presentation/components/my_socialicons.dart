import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class MySocialicons extends StatelessWidget {
  final String asssetUrl;
  const MySocialicons({super.key, required this.asssetUrl});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: SvgPicture.asset(
        "assets/google.svg",
        width: width * 0.1, // optional
        height: width * 0.1, // optional
      ),
    );
  }
}
