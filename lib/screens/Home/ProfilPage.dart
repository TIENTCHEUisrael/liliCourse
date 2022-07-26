// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/Animations/DelayedAnimation.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/screens/NavBar_Pages/EditProfile.dart';
import 'package:provider/provider.dart';
import '../../Provider/providerUser.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilePage> {
  final _icon = CupertinoIcons.moon_stars;
  final double topContainerheigh = 170;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
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
                child: Column(
                  children: [
                    Container(
                      height: topContainerheigh,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: topContainerheigh * .58,
                                color: Colors.grey[300],
                              ),
                              Container(
                                height: topContainerheigh * .42,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              height: 130,
                              width: 130,
                              child: Card(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Hero(
                                    tag: 'tag1',
                                    child: ClipOval(
                                      child: Material(
                                        child: Image.asset(
                                            'assets/images/israel.jpeg'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 18,
                            left: 190,
                            child: DelayedAnimation(
                              delay: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return EditProfile(auth.user!);
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        //Premiere animation de bas en haut

                                        var begin = const Offset(1.0, 1.0);
                                        var end = Offset.zero;
                                        //var curve=Curves.ease;
                                        var tween = Tween(
                                            begin: begin,
                                            end:
                                                end) /*.chain(CurveTween(curve: curve))*/;
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );

                                        //Seconde animation Effet fondu et avec Hero c'est pour faire un genre de survole sur une propriete speciique

                                        /*  animation=CurvedAnimation(parent: animation, curve: Curves.ease);
                                        return FadeTransition(opacity: animation,child: child,);*/
                                      },
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(10),
                                  backgroundColor:
                                      MaterialStateProperty.all(blue_button),
                                  textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                child: Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  //width: MediaQuery.of(context).size.width - 205,
                                  child: const Text('Ugrade Profile'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              DelayedAnimation(
                delay: 200,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Name :',
                            style: GoogleFonts.poppins(
                                color: blue_button, fontSize: 16),
                          ),
                          Text(
                            auth.user!.first_name,
                            style: GoogleFonts.poppins(
                              color: Colors.grey[650],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Last_name :',
                            style: GoogleFonts.poppins(
                                color: blue_button, fontSize: 16),
                          ),
                          Text(
                            auth.user!.last_name,
                            style: GoogleFonts.poppins(
                              color: Colors.grey[650],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'email :',
                            style: GoogleFonts.poppins(
                                color: blue_button, fontSize: 16),
                          ),
                          Text(
                            auth.user!.email,
                            style: GoogleFonts.poppins(
                              color: Colors.grey[650],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'number :',
                            style: GoogleFonts.poppins(
                                color: blue_button, fontSize: 16),
                          ),
                          Text(
                            auth.user!.phone_number.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.grey[650],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Adresse :',
                            style: GoogleFonts.poppins(
                                color: blue_button, fontSize: 16),
                          ),
                          Text(
                            'Adresse',
                            //widget.user.phone_number.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.grey[650],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  iconColor: Colors.black,
                  leading: Icon(Icons.shop),
                  title: Text(
                    'Orders',
                    style:
                        GoogleFonts.poppins(fontSize: 18, color: blue_button),
                  ),
                  subtitle: const Text('Check your orders'),
                  trailing: const Icon(CupertinoIcons.chevron_forward),
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
            