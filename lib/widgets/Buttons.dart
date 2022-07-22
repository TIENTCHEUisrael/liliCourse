import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../main.dart';

// ignore: non_constant_identifier_names
Widget Button1(BuildContext ctx, String title, double textSize, Color color,
    Function onPresse) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
    child: OutlinedButton(
      onPressed: onPresse(),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: textSize,
            fontFamily: 'Poppins'),
      ),
    ),
  );
}
