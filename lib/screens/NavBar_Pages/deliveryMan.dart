import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/widgets/appBar.dart';

class DeliveryMan extends StatefulWidget {
  const DeliveryMan({Key? key}) : super(key: key);

  @override
  State<DeliveryMan> createState() => _DeliveryManState();
}

class _DeliveryManState extends State<DeliveryMan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        Text(
          'Delivery Man',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      body: Container(),
    );
  }
}
