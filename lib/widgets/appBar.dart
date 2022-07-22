import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar buildAppBar(BuildContext context, String text) {
  const icon = CupertinoIcons.moon_stars;
  return AppBar(
    leading: const BackButton(
      color: Colors.black,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          icon,
          color: Colors.black,
        ),
      ),
    ],
    title: Text(
      text,
      style: GoogleFonts.poppins(color: Colors.black),
    ),
    centerTitle: true,
  );
}
