import 'package:flutter/material.dart';

import '../../models/user/user.dart';

class Home extends StatefulWidget {
  final User user;

  Home({required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
