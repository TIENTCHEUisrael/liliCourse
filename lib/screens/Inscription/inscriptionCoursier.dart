import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/Provider/ProviderCoursier.dart';
import 'package:lilicourse/models/coursier/coursier.dart';
import 'package:lilicourse/widgets/appBar.dart';
import 'package:provider/provider.dart';

import '../../Animations/DelayedAnimation.dart';
import '../../main.dart';
import '../../widgets/bas.dart';

class InscriptionCoursier extends StatefulWidget {
  @override
  State<InscriptionCoursier> createState() => _InscriptionCoursierState();
}

class _InscriptionCoursierState extends State<InscriptionCoursier> {
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  final nom = TextEditingController();
  final prenom = TextEditingController();
  final email = TextEditingController();
  final numero = TextEditingController();
  final pass = TextEditingController();
  final image = TextEditingController();
  final tranport = TextEditingController();
  final rating = TextEditingController();
  final occupation = TextEditingController();

  void zero() {
    setState(
      () {
        nom.clear();
        prenom.clear();
        email.clear();
        numero.clear();
        pass.clear();
        image.clear();
        tranport.clear();
        rating.clear();
        occupation.clear();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CoursProvider cours = Provider.of<CoursProvider>(context);
    return Scaffold(
      appBar: buildAppBar(
        context,
        const Text(
          'Add Delivery man',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 10),
                    child: Text(
                      'Register',
                      style: GoogleFonts.cardo(
                          fontSize: 35,
                          color: blue_button,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 52, top: 5.0),
                    child: Text(
                      'Sign delivery man  with ',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Name',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: blue_button),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: MyWidget(
                          controller: nom,
                          label: 'First Name',
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Last Name',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: blue_button),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: MyWidget(
                          controller: prenom,
                          label: 'Last Name',
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Email',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: blue_button),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: MyWidget(
                          controller: email,
                          label: 'Email',
                          icon: const Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Phone Number',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: blue_button),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: MyWidget(
                          keys: TextInputType.phone,
                          controller: numero,
                          label: 'Phone Number',
                          icon: const Icon(Icons.phone_android),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Transport',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: blue_button),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: MyWidget(
                          controller: tranport,
                          label: 'Transport',
                          icon: const Icon(Icons.bike_scooter),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            'rating',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: blue_button),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: MyWidget(
                          controller: rating,
                          label: 'Rating',
                          icon: const Icon(Icons.stars),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Password',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: blue_button),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: TextFormField(
                          obscureText: _obscureText,
                          controller: pass,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[360],
                                fontWeight: FontWeight.w600),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 17, horizontal: 25),
                            focusColor: blue_button,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(27),
                              borderSide: const BorderSide(color: blue_button),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(27),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Occupation',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: blue_button),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: MyWidget(
                          controller: occupation,
                          label: 'Occupation',
                          icon: const Icon(Icons.hourglass_bottom),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Image',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: blue_button),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        child: MyWidget(
                          controller: image,
                          label: 'Image',
                          icon: const Icon(Icons.image),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
                DelayedAnimation(
                  delay: 400,
                  child: Container(
                    width: 250,
                    height: 70,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: blue_button,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        var cour = Coursier(
                          commandeId: null,
                          first_name: nom.text,
                          last_name: prenom.text,
                          email: email.text,
                          phone_number: int.parse(numero.text),
                          password: pass.text,
                          image: image.text,
                          transport: tranport.text,
                          rating: rating.text,
                          occupation: occupation.text,
                          updated_At: DateTime.now().toString(),
                        );
                        cours.createCoursier(cour).then(
                          (respo) {
                            if (respo!['statut']) {
                              var user = respo['coursier'];
                              print(
                                  '.........................................');
                            } else {
                              Fluttertoast.showToast(
                                msg: "Error:${respo['message']}",
                              );
                            }
                            Fluttertoast.showToast(
                              msg: "Message:${respo['message']}",
                            );
                          },
                        );
                      },
                      child: cours.registerStatus == Statut.registing
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : Text(
                              'Register',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                    ),
                  ),
                ),
                bas(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  TextInputType? keys;
  final TextEditingController controller;
  final Icon icon;
  final String label;
  MyWidget(
      {this.keys,
      required this.controller,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: label,
        hintStyle: TextStyle(
            fontSize: 10, color: Colors.grey[360], fontWeight: FontWeight.w600),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 17, horizontal: 25),
        focusColor: blue_button,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(27),
          borderSide: const BorderSide(color: blue_button),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(27),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      keyboardType: keys,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }
}
