import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class MySocialicons extends StatelessWidget {
  final String asssetUrl;
  final VoidCallback voidCallback;
  const MySocialicons({
    super.key,
    required this.asssetUrl,
    required this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: SvgPicture.asset(
        asssetUrl,
        width: width * 0.1, // optional
        height: width * 0.1, // optional
      ),
    );
  }
}
