import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
              child: SvgPicture.asset(
                'assets/images/delivery/svg/question.svg',
                height: 350,
                width: 350,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            child: Text(
              'Vous voulez ?',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: blue_button, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          animatedButton(),
          const SizedBox(
            height: 130,
          ),
          bas()
        ],
      ),
    );
  }
}
