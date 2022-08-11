import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../main.dart';
import '../../widgets/appBar.dart';

class TimeWaiting extends StatefulWidget {
  const TimeWaiting({Key? key}) : super(key: key);

  @override
  State<TimeWaiting> createState() => _TimeWaitingState();
}

class _TimeWaitingState extends State<TimeWaiting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        Text('TimeWaiting', style: GoogleFonts.poppins()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 95),
              child: Center(
                child: Lottie.asset(
                  'assets/images/timer.json',
                  height: 250,
                  width: 200,
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: const CircularProgressIndicator()),
            Container(
              padding: const EdgeInsets.only(top: 220),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Li',
                    style: GoogleFonts.poppins(color: Colors.red),
                  ),
                  Text(
                    'li',
                    style: GoogleFonts.poppins(color: blue_button),
                  ),
                  Text(
                    ' Course version 1.0',
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
