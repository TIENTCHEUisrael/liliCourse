import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Animations/DelayedAnimation.dart';
import '../login/loginPage.dart';
import './Page1.dart';
import './Page2.dart';
import './Page3.dart';
import '../../widgets/bas.dart';

class Navigators extends StatefulWidget {
  static const routeNamed = "/NavigatorPage";

  const Navigators({Key? key}) : super(key: key);

  @override
  State<Navigators> createState() => _NavigatorsState();
}

class _NavigatorsState extends State<Navigators> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              Page1(),
              Page2(),
              Page3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.5),
            child: SmoothPageIndicator(controller: _controller, count: 3),
          ),
          onLastPage
              ? DelayedAnimation(
                  delay: 500,
                  child: Container(
                    alignment: const Alignment(0, 0.75),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: blue_button),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const LoginPage();
                            }),
                          );
                        },
                        child: const Text(
                          'Start >>>',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Container(
            alignment: const Alignment(0, 0.98),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Li',
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Li',
                  style: GoogleFonts.poppins(
                    color: blue_button,
                  ),
                ),
                Text(
                  'Course version 1.0.0',
                  style: GoogleFonts.poppins(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
