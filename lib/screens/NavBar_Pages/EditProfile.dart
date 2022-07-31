import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lilicourse/main.dart';
import '../../Animations/DelayedAnimation.dart';
import '../../../widgets/appBar.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:provider/provider.dart';
import '../../Provider/providerUser.dart';
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
  String? name;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      final imagePermanent = await saveImagePermany(image.path);
      setState(
        () {
          images = imagePermanent;
          name = image.name;
        },
      );
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to pick Image :$e}",
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
  final adress = TextEditingController();

  void chargement() {
    nom.text = authuser!.first_name;
    prenom.text = authuser!.last_name;
    email.text = authuser!.email;
    phone.text = authuser!.phone_number.toString();
    password.text = authuser!.password;
    comentaire.text = authuser!.commentaire;
  }

  @override
  void initState() {
    super.initState();
    authuser = widget.user;
    print(authuser);
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
                  border: Border.all(color: Colors.transparent),
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
                                'assets/images/prof3.png',
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
                            child: Container(
                              child: FlatButton.icon(
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                                textColor: blue_button,
                                onPressed: () => pickImage(ImageSource.camera),
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            alignment: Alignment.center,
                            child: Container(
                              child: FlatButton.icon(
                                icon: const Icon(Icons.camera),
                                label: const Text('Gallery'),
                                textColor: blue_button,
                                onPressed: () => pickImage(ImageSource.gallery),
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
                      controller: nom,
                      label: 'Nom',
                      text: nom.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      controller: prenom,
                      label: 'Prenom',
                      text: prenom.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      controller: phone,
                      label: 'Telephone',
                      text: phone.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      controller: email,
                      label: 'Email',
                      text: email.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      controller: adress,
                      label: 'Adresse',
                      text: 'Adresse',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      controller: comentaire,
                      label: 'About you',
                      text: comentaire.text,
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DelayedAnimation(
                      delay: 120,
                      child: ElevatedButton(
                        onPressed: () {
                          auth.uploadImage(images!).then((value) {
                            if (value!['status']) {
                              Fluttertoast.showToast(
                                msg: "Message:${value['message']}",
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Error:${value['message']}",
                              );
                            }
                          });
                          var us = User(
                              first_name: nom.text,
                              last_name: prenom.text,
                              email: email.text,
                              phone_number: int.parse(phone.text),
                              password: password.text,
                              commentaire: comentaire.text,
                              image: name == null ? " " : name as String,
                              updated_At: DateTime.now().toString());
                          auth.update_User(widget.user.email, us).then((value) {
                            if (value!['status']) {
                              User user = value['user'];
                              Provider.of<AuthProvider>(context, listen: false)
                                  .setUSer(user);
                              print('......................');
                              Fluttertoast.showToast(
                                msg: "Message:${value['message']}",
                              );
                              Navigator.of(context).pop();
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
                        child: auth.logStatus == Statut.updating
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                            : Text(
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

  Future<File> saveImagePermany(String paths) async {
    //final d = Directory("/static/images/");
    final directory = await syspaths.getApplicationDocumentsDirectory();
    final name = path.basename(paths);
    final image = File('${directory.path}/$name');
    print(name);
    print('............................................;');
    return File(paths).copy(image.path);
  }
}
