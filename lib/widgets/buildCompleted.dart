import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../screens/livraison/PageMap.dart';
import 'containFirst.dart';

class buildCompleted extends StatefulWidget {
  int currentStep;
  final TextEditingController email;
  final TextEditingController numero;
  bool isCompleted;

  buildCompleted(
      {required this.currentStep,
      required this.email,
      required this.numero,
      required this.isCompleted});

  @override
  State<buildCompleted> createState() => _buildCompletedState();
}

class _buildCompletedState extends State<buildCompleted> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          containFirst(
              imagePath: 'assets/images/delivery/svg/delivery.svg',
              text: 'Demander une livraison'),
          Card(
            elevation: 5,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Recapitulatif',
                    style: GoogleFonts.poppins(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: blue_button,
                          textStyle: GoogleFonts.poppins(fontSize: 18),
                        ),
                        child: Text(
                          'Confirm',
                          style: GoogleFonts.poppins(),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return AttentePage();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                //Premiere animation de bas en haut
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var tween = Tween(begin: begin, end: end);
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        }),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        textStyle: GoogleFonts.poppins(fontSize: 18),
                      ),
                      child: const Text('Reset'),
                      onPressed: () => setState(() {
                        widget.isCompleted = false;
                        widget.currentStep = 0;
                        widget.email.clear();
                        widget.numero.clear();
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
