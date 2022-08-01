import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lilicourse/Provider/providerUser.dart';
import 'package:lilicourse/screens/NavBar_Pages/Apropos.dart';
import 'package:lilicourse/screens/login/loginPage.dart';
import 'package:provider/provider.dart';
import '../screens/NavBar_Pages/profile.dart';
import '../screens/NavBar_Pages/setting.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool jour = true;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<AuthProvider>(builder: (context, auth, _) {
        return auth.isAuth == true
            ? ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName:
                        Text('${auth.user.first_name} ${auth.user.last_name}'),
                    accountEmail: Text(
                      auth.user.email,
                      style: const TextStyle(color: Colors.white60),
                    ),
                    currentAccountPicture: CircleAvatar(
                      child: Hero(
                        tag: 'tag1',
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/prof3.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return ProfilePage();
                        }),
                      );
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
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return SettingPage();
                        }),
                      );
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
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return Apropos();
                        }),
                      );
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
                      auth.logOutUser().then(
                        (value) {
                          if (value!['status'] == true) {
                            Fluttertoast.showToast(
                              msg: "Message:${value['message']}",
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginPage();
                                },
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Error:${value['message']}",
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              )
            : Container();
      }),
    );
  }
}
