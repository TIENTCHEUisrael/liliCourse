import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/widgets/appBar.dart';
import 'package:provider/provider.dart';

import '../../Provider/providerUser.dart';
import '../../widgets/bas.dart';
import '../login/loginPage.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) =>
      Consumer<AuthProvider>(builder: (context, auth, _) {
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.black,
            ),
            backgroundColor: Colors.grey.shade200,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.moon_stars,
                  color: Colors.black,
                ),
              ),
            ],
            title: const Text(
              'Setting',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    color: blue_button,
                    child: ListTile(
                      title: Text(
                        '${auth.user.first_name} ${auth.user.last_name}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      leading: CircleAvatar(
                        child: Image.asset('assets/images/israel.jpeg'),
                      ),
                      trailing: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.lock_outline,
                            color: blue_button,
                          ),
                          title: const Text('Change Password'),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {},
                        ),
                        const dividers(),
                        ListTile(
                          leading: const Icon(
                            FontAwesomeIcons.language,
                            color: blue_button,
                          ),
                          title: const Text('Change Language'),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {},
                        ),
                        const dividers(),
                        ListTile(
                          leading: const Icon(
                            Icons.lock_outline,
                            color: blue_button,
                          ),
                          title: const Text('Change Profile'),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "Notification Settings",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: blue_button,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SwitchListTile(
                          contentPadding: const EdgeInsets.all(0),
                          activeColor: blue_button,
                          value: true,
                          title: const Text('Received Notifications'),
                          onChanged: (val) {},
                        ),
                        SwitchListTile(
                          contentPadding: EdgeInsets.all(0),
                          activeColor: blue_button,
                          value: false,
                          title: const Text('Received new Chats'),
                          onChanged: (val) {},
                        ),
                        SwitchListTile(
                          contentPadding: const EdgeInsets.all(0),
                          activeColor: blue_button,
                          value: false,
                          title: const Text('Received App updates'),
                          onChanged: (val) {},
                        ),
                        const SwitchListTile(
                          contentPadding: EdgeInsets.all(0),
                          activeColor: blue_button,
                          value: true,
                          title: Text('Change color App'),
                          onChanged: null,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 58,
                  ),
                  bas()
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            highlightElevation: 50,
            hoverElevation: 30,
            elevation: 20,
            child: const Icon(
              FontAwesomeIcons.powerOff,
              color: Colors.white,
            ),
            onPressed: () {
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
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        );
      });
}

/*Positioned(
                        bottom: 00,
                        left: 00,
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.powerOff,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      )*/
class dividers extends StatelessWidget {
  const dividers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
