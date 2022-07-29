import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/Provider/providerUser.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/widgets/bas.dart';
import 'package:lilicourse/widgets/navbar.dart';
import 'package:provider/provider.dart';
import '../../models/user/user.dart';
import '../livraison/LilvraisonPage.dart';
import './CommandesPage.dart';
import './NotificationPage.dart';
import './ChatsPage.dart';
import './ProfilPage.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _texte = 'Home';
  int currentTab = 3;

  final List<Widget> screens = [
    CommandesPage(),
    ChatsPage(),
    NotificationPage(),
    ProfilePage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentPage = ProfilePage();

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      drawer: NavBar(),
      drawerScrimColor: Colors.grey,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.white,
        title: Center(
          child: Image.asset(
            "assets/images/d.png",
            height: 100,
            width: 120,
            fit: BoxFit.cover,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 40,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.moon_stars,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentPage,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'uniqueTag',
        splashColor: blue_button,
        hoverColor: Colors.orange,
        highlightElevation: 50,
        hoverElevation: 30,
        elevation: 20,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return LivraisonPage(user: auth.user);
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                //Premiere animation de bas en haut

                var begin = const Offset(0.0, 1.0);
                var end = Offset.zero;
                //var curve=Curves.ease;
                var tween = Tween(
                    begin: begin,
                    end: end) /*.chain(CurveTween(curve: curve))*/;
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 82,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              currentPage = CommandesPage();
                              currentTab = 0;
                              _texte = 'Orders';
                            });
                          },
                          minWidth: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.library_books,
                                color:
                                    currentTab == 0 ? blue_button : Colors.grey,
                                size: currentTab == 0 ? 38 : 29,
                              ),
                              Text(
                                'Orders',
                                style: GoogleFonts.poppins(
                                    color: currentTab == 0
                                        ? blue_button
                                        : Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              currentPage = ChatsPage();
                              currentTab = 1;
                              _texte = 'Chats';
                            });
                          },
                          minWidth: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat,
                                color:
                                    currentTab == 1 ? blue_button : Colors.grey,
                                size: currentTab == 1 ? 38 : 29,
                              ),
                              Text(
                                'Chats',
                                style: GoogleFonts.poppins(
                                    color: currentTab == 1
                                        ? blue_button
                                        : Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            setState(
                              () {
                                currentPage = NotificationPage();
                                currentTab = 2;
                                _texte = 'Notifications';
                              },
                            );
                          },
                          minWidth: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notification_important,
                                color:
                                    currentTab == 2 ? blue_button : Colors.grey,
                                size: currentTab == 2 ? 38 : 28,
                              ),
                              Text(
                                'Notified',
                                style: GoogleFonts.poppins(
                                    color: currentTab == 2
                                        ? blue_button
                                        : Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              currentPage = ProfilePage();
                              currentTab = 3;
                              _texte = 'Profile';
                            });
                          },
                          minWidth: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color:
                                    currentTab == 3 ? blue_button : Colors.grey,
                                size: currentTab == 3 ? 38 : 28,
                              ),
                              Text(
                                'Profile',
                                style: GoogleFonts.poppins(
                                  color: currentTab == 3
                                      ? blue_button
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                bas()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
