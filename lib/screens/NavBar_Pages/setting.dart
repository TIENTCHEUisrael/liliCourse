import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/widgets/appBar.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(
          context,
          Text(
            'Setting App',
            style: GoogleFonts.poppins(color: Colors.black),
          ),
        ),
        body: const Center(
          child: Text('dsfdsf'),
        ),
      );
}
