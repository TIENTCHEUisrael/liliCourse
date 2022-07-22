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
          context, MaterialPageRoute(builder: (ctx) => Navigators()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 60,
                left: 5,
                right: 5,
              ),
              child: Lottie.asset("assets/images/splash1/delivery3.json",
                  height: 300),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5),
              child: Image.asset(
                "assets/images/d.png",
                height: 150,
                width: 150,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              height: 120,
            ),
            bas(),
          ],
        ),
      ),
    ));
  }
}
