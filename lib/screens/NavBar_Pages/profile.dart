import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/widgets/appBar.dart';
import '../../models/user/user.dart';
import './EditProfile.dart';
import '../../Animations/DelayedAnimation.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  ProfilePage({required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        Text(
          'Profile',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 5, left: 5),
          child: Column(
            children: [
              DelayedAnimation(
                delay: 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  height: 160,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'tag1',
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: Image.asset(
                              'assets/images/prof3.png',
                              height: 128,
                              width: 128,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 150,
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: double.infinity,
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
                            widget.user.first_name,
                            style: GoogleFonts.poppins(
                              color: Colors.grey[650],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
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
                            widget.user.last_name,
                            style: GoogleFonts.poppins(
                              color: Colors.grey[650],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
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
                            widget.user.email,
                            style: GoogleFonts.poppins(
                              color: Colors.grey[650],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'phone_number :',
                            style: GoogleFonts.poppins(
                                color: blue_button, fontSize: 16),
                          ),
                          Text(
                            widget.user.phone_number.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.grey[650],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
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
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 120,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return EditProfile(widget.user);
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          /*Premiere animation de bas en haut

                          var begin = const Offset(1.0, 1.0);
                          var end = Offset.zero;
                          //var curve=Curves.ease;
                          var tween = Tween(
                              begin: begin,
                              end: end) /*.chain(CurveTween(curve: curve))*/;
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );*/

                          //Seconde animation Effet fondu et avec Hero c'est pour faire un genre de survole sur une propriete speciique

                          animation = CurvedAnimation(
                              parent: animation, curve: Curves.ease);
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    'Upgrade Profile',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 0.3,
                width: double.infinity,
                color: Colors.grey,
              ),
              DelayedAnimation(
                delay: 200,
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Text(
                        'About you :',
                        style: GoogleFonts.poppins(
                          color: blue_button,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          widget.user.commentaire,
                          style: GoogleFonts.poppins(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 0.3,
                width: double.infinity,
                color: Colors.grey,
              ),
              DelayedAnimation(
                delay: 250,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        'Orders :',
                        style: GoogleFonts.poppins(color: blue_button),
                      ),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: blue_button,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
