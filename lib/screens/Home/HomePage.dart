import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lilicourse/widgets/navbar.dart';
import '../../models/user/user.dart';
import '../livraison/LilvraisonPage.dart';
import './CommandesPage.dart';
import './NotificationPage.dart';
import './ChatsPage.dart';
import './ProfilPage.dart';

class Home extends StatefulWidget {
  final User person;

  Home({required this.person});

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
    return Scaffold(
      drawer: NavBar(user: widget.person),
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
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return LivraisonPage(user: widget.person);
              },
            ),
          );
        },
      ),
    );
  }
}
