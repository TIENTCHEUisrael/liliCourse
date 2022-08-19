import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/main.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/bas.dart';
import './Navigation.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const routeNamed = "/SplashPage";

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const Navigators()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            Center(
              child: Image.asset(
                "assets/images/d.png",
                height: 250,
                width: 250,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              height: 180,
            ),
            bas(),
          ],
        ),
      ),
    );
  }
}

/**const CircularProgressIndicator(), 
 * Container(
              padding: const EdgeInsets.only(
                top: 60,
                left: 5,
                right: 5,
              ),
              child: Lottie.asset("assets/images/splash1/delivery3.json",
                  height: 300),
            ), */