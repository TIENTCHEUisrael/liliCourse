import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import './../../main.dart';
import '../../widgets/bas.dart';
import '../../Animations/DelayedAnimation.dart';
import '../../Animations/animatedButton.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DelayedAnimation(
            delay: 300,
            child: Container(
              alignment: Alignment.center,
              child: Lottie.asset(
                'assets/images/okk.json',
                height: 350,
                width: 350,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            child: Text(
              "Profiter d'un service de demande de livraison dont le prix s'eleve a 1500frc de base.Voulez-vous?",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: blue_button, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          animatedButton(),
          const SizedBox(
            height: 80,
          ),
          bas()
        ],
      ),
    );
  }
}
