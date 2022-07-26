import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lilicourse/Animations/DelayedAnimation.dart';
import 'package:lilicourse/Provider/providerUser.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/widgets/appBar.dart';
import 'package:provider/provider.dart';
import '../../models/user/user.dart';
import '../../widgets/TextFieldwidget.dart';

class EditProfile extends StatefulWidget {
  final User user;
  EditProfile(this.user);

  @override
  State<EditProfile> createState() => _EditPageState();
}

class _EditPageState extends State<EditProfile> {
  File? images;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }

      final imageTemporary = File(image.path);
      setState(
        () {
          images = imageTemporary;
        },
      );
    } on PlatformException catch (e) {
      print('Failed to pick Image');
      Fluttertoast.showToast(
        msg: "Error: Failed to pick Image}",
      );
    }
  }

  User? authuser;
  final nom = TextEditingController();
  final prenom = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final comentaire = TextEditingController();

  void chargement() {
    nom.text = widget.user.first_name;
    prenom.text = widget.user.last_name;
    email.text = widget.user.email;
    phone.text = widget.user.phone_number.toString();
    password.text = widget.user.password;
    comentaire.text = widget.user.commentaire;
  }

  @override
  void initState() {
    super.initState();
    authuser = widget.user;
    chargement();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: buildAppBar(
        context,
        Text(
          'Edit Profile',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Hero(
                      tag: 'tag1',
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: 130,
                        width: 110,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: images != null
                            ? Image.file(
                                images!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/Profile.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: blue_button,
                                  onPrimary: Colors.white),
                              onPressed: () => pickImage(),
                              child: Row(
                                children: [
                                  const Icon(Icons.image_outlined),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Pick Gallery',
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: blue_button,
                                  onPrimary: Colors.white),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  const Icon(Icons.camera_alt_outlined),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Pick Camera',
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 0.3,
                width: double.infinity,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 15,
              ),
              Form(
                child: Column(
                  children: [
                    TextFieldWidget(
                        label: 'Nom', text: nom.text, onChanged: (name) {}),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        label: 'Prenom',
                        text: prenom.text,
                        onChanged: (name) {}),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        label: 'Telephone',
                        text: phone.text,
                        onChanged: (name) {}),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        label: 'Email', text: email.text, onChanged: (name) {}),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        label: 'Adresse',
                        text: 'Adresse',
                        onChanged: (name) {}),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        label: 'About you',
                        text: comentaire.text,
                        maxLines: 5,
                        onChanged: (name) {}),
                    const SizedBox(
                      height: 20,
                    ),
                    DelayedAnimation(
                      delay: 120,
                      child: ElevatedButton(
                        onPressed: () {
                          var us = User(
                              first_name: nom.text,
                              last_name: prenom.text,
                              email: email.text,
                              phone_number: int.parse(phone.text),
                              password: password.text,
                              commentaire: comentaire.text,
                              image: "",
                              updated_At: DateTime.now().toString());
                          auth.update_User(authuser!.email, us).then((value) {
                            if (value!['status']) {
                              User user = value['user'];
                              Provider.of<UserProvider>(context, listen: false)
                                  .setUser(user);
                              print('......................');
                              Fluttertoast.showToast(
                                msg: "Message:${value['message']}",
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Error:${value['message']}",
                              );
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        child: Text(
                          'Update Profile',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
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
