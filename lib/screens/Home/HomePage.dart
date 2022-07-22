import 'package:flutter/material.dart';

import '../../models/user/user.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
