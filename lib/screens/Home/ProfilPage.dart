import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Provider/providerUser.dart';
import '../../models/user/user.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilePage> {
  final _icon = CupertinoIcons.moon_stars;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
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
                      decoration: const BoxDecoration(
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
}
  /*AvatarGlow(
                glowColor: Colors.blue,
                endRadius: 90.0,
                duration: Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: Duration(milliseconds: 100),
                child: Material(
                  // Replace this child with your own
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Image.asset(
                      'assets/images/d.png',
                      height: 60,
                    ),
                    radius: 40.0,
                  ),
                ),
              ),*/
            