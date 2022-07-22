import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/widgets/bas.dart';
import '../../../main.dart';
import '../../Animations/DelayedAnimation.dart';
import './inscription.dart';
import './inscriptionCoursier.dart';
import './inscriptionPartenaire.dart';

class ChoicePage extends StatelessWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 30,
          ),
          child: Column(
            children: [
              DelayedAnimation(
                delay: 100,
                child: Image.asset(
                  "assets/images/d.png",
                  height: 250,
                  width: 250,
                ),
              ),
              DelayedAnimation(
                delay: 100,
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Text(
                    'Vous etes ?',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 500,
                child: Container(
                  margin: EdgeInsets.all(20),
                  width: 210,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: blue_button,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.all(13),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Inscription();
                        }),
                      );
                    },
                    child: Text(
                      'Un Client',
                      style: GoogleFonts.poppins(fontSize: 22),
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 500,
                child: Container(
                  margin: EdgeInsets.all(20),
                  width: 210,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: blue_button,
                      shape: StadiumBorder(),
                      padding: EdgeInsets.all(13),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return InscriptionCoursier();
                        }),
                      );
                    },
                    child: Text(
                      'Un Coursier',
                      style: GoogleFonts.poppins(fontSize: 22),
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 800,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    bottom: 50,
                  ),
                  width: 210,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: blue_button,
                      shape: StadiumBorder(),
                      padding: const EdgeInsets.all(13),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return InscriptionPartenaire();
                        }),
                      );
                    },
                    child: Text(
                      'Un Partenaire',
                      style: GoogleFonts.poppins(fontSize: 22),
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 100,
                child: Container(
                  width: double.infinity,
                  child: TextButton(
                    child: Text(
                      '<< Precedent',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              bas(),
            ],
          ),
        ),
      ),
    );
  }
}
