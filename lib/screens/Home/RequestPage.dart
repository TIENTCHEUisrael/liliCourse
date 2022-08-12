import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';
import '../../screens/Home/tabs/firstTab.dart';
import '../../screens/Home/tabs/secondTab.dart';

class RequestPage extends StatefulWidget {
  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              indicatorColor: red_button,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.timer_off, color: Colors.black),
                      Text(
                        'Terminé',
                        style: GoogleFonts.poppins(color: blue_button),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.time_to_leave,
                        color: Colors.black,
                      ),
                      Text(
                        'En Cour',
                        style: GoogleFonts.poppins(
                          color: blue_button,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  RequestTermine(),
                  RequestEnCour(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
