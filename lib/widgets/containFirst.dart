import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class containFirst extends StatelessWidget {
  final String imagePath;
  final String text;
  containFirst({
    required this.imagePath,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SvgPicture.asset(
            imagePath,
            height: 185,
            width: 140,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
