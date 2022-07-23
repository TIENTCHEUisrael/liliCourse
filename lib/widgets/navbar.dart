import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user/user.dart';

class NavBar extends StatefulWidget {
  final User? user;
  NavBar({required this.user});
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool jour = true;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName:
                Text('${widget.user!.first_name} ${widget.user!.last_name}'),
            accountEmail: Text(
              widget.user!.email,
              style: const TextStyle(color: Colors.white60),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/israel.jpeg',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0XFF1B5E96),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onLongPress: () {
              return;
            },
            onTap: () {
              /*Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return Profile2();
                }),
              );*/
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.person_search_sharp),
            title: const Text('Delivery man'),
            onTap: () {
              /*Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return Coursier();
                }),
              );*/
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Setting'),
            onLongPress: () {
              return;
            },
            onTap: () {
              /*Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return Parametre();
                }),
              );*/
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              CupertinoIcons.moon_stars,
              color: Colors.grey,
            ),
            title: jour ? const Text('Jour') : const Text('Nuit'),
            onLongPress: () {
              return;
            },
            onTap: () {
              setState(() {
                jour = !jour;
                jour ? print('Jour ') : print('nuit');
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onLongPress: () {
              return;
            },
            onTap: () {
              /*Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return Apropos2();
                }),
              );*/
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Disconnected'),
            onLongPress: () {
              return;
            },
            onTap: () {
              return print('Deconnexion ');
            },
          ),
        ],
      ),
    );
  }
}
