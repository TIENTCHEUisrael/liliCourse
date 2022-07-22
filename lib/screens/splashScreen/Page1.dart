// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: const Alignment(0, -0.5),
          child: SvgPicture.asset(
            'assets/images/splash1/svg/undraw_mobile_interface_re_1vv9.svg',
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
                'Avec Shexpi vous avez la possibilite d’avoir un de nos coursier de Douala a disposition pour votre colis ',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
