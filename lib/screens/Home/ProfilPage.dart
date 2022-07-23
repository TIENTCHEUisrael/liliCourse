import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/main.dart';
import '../../models/user/user.dart';
import './HomePage.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilePage> {
  final _icon = CupertinoIcons.moon_stars;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    'My Profile',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Container(
                      height: 180,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/israel.jpeg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('fgdsg'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildName(User user) => Column(
        children: [
          Container(
            height: 0.5,
            width: double.infinity,
            color: Colors.grey,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            user.first_name + ' ' + user.last_name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            user.phone_number.toString(),
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.blueGrey),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            user.email,
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'address',
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
        ],
      );
}
