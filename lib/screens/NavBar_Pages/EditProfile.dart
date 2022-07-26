import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/Animations/DelayedAnimation.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/widgets/appBar.dart';
import '../../models/user/user.dart';
import '../../widgets/TextFieldwidget.dart';

class EditProfile extends StatefulWidget {
  final User user;
  EditProfile(this.user);

  @override
  State<EditProfile> createState() => _EditPageState();
}

class _EditPageState extends State<EditProfile> {
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
    chargement();
  }

  @override
  Widget build(BuildContext context) {
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
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/Profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    InkWell(
                      child: Card(
                        color: blue_button,
                        elevation: 10,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.camera,
                              color: Colors.white,
                            ),
                            Text(
                              '  Edit Camera  ',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
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
                        onPressed: () {},
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
