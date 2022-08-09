import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/livraison/Page2.dart';
import 'DelayedAnimation.dart';

class animatedButton extends StatefulWidget {
  @override
  State<animatedButton> createState() => _animatedButtonState();
}

class _animatedButtonState extends State<animatedButton> {
  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: 500,
      child: Container(
        height: 70,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueAccent,
              Colors.blue,
            ],
          ),
        ),
        child: TextButton(
          child: const Text(
            'Demander une livraison',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Page2();
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  //Premiere animation de bas en haut
                  var begin = Offset(1.0, 0.0);
                  var end = Offset.zero;
                  var tween = Tween(begin: begin, end: end);
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
