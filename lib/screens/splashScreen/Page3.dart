import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: const Alignment(0, -0.5),
          child: SvgPicture.asset(
            'assets/images/splash1/svg/undraw_package_arrived_63rf.svg',
            height: 310,
            width: 210,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: const Alignment(1, 0.3),
              width: 300,
              child: Text(
                'Suivez votre commande depuis le depart jusqu’a l’arriver ',
                style: GoogleFonts.poppins(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
