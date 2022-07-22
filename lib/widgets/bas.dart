import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/main.dart';

Widget bas() {
  return Container(
    padding: const EdgeInsets.all(5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Li',
          style: GoogleFonts.poppins(
            color: Colors.red,
          ),
        ),
        Text(
          'Li',
          style: GoogleFonts.poppins(
            color: Colors.blue,
          ),
        ),
        Text(
          'Course ',
          style: GoogleFonts.poppins(color: blue_button),
        ),
        Text(
          'version 1.0.O',
          style: GoogleFonts.poppins(),
        ),
      ],
    ),
  );
}
