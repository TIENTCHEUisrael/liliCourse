import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/Animations/DelayedAnimation.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/widgets/bas.dart';
import 'package:provider/provider.dart';
import '../../Provider/provideruser.dart';
import '../../models/user/user.dart';
import '../Home/HomePage.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  final nom = TextEditingController();
  final prenom = TextEditingController();
  final email = TextEditingController();
  final numero = TextEditingController();
  final pass = TextEditingController();
  final confirm = TextEditingController();
  final comment = TextEditingController();

  void zero() {
    setState(() {
      nom.clear();
      prenom.clear();
      email.clear();
      numero.clear();
      pass.clear();
      confirm.clear();
      comment.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Image.asset(
                "assets/images/d.png",
                height: 250,
                width: 300,
                fit: BoxFit.cover,
              ),
              Text(
                "Sign up",
                style: GoogleFonts.poppins(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nom,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          decoration: TextDecoration.none,
                        ),
                        labelText: 'Votre first name',
                        prefixIcon: const Icon(
                          Icons.edit,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: prenom,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          decoration: TextDecoration.none,
                        ),
                        labelText: 'Votre last name',
                        prefixIcon: const Icon(
                          Icons.edit,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          decoration: TextDecoration.none,
                        ),
                        labelText: 'Enter your email',
                        prefixIcon: const Icon(
                          Icons.mail,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mail';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Enter valid mail';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: numero,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          decoration: TextDecoration.none,
                        ),
                        labelText: 'Votre phone number',
                        prefixIcon: const Icon(
                          Icons.phone,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: pass,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          decoration: TextDecoration.none,
                        ),
                        labelText: 'Enter your  password',
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
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length < 6) {
                          return 'Please enter minimun 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: confirm,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          decoration: TextDecoration.none,
                        ),
                        labelText: 'confirm your pass',
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
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the pass';
                        } else if (value != pass.text) {
                          return 'Enter the same carateres with your pass';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'About you',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: comment,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: GoogleFonts.poppins(color: Colors.grey),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your comment';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DelayedAnimation(
                    delay: 400,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: blue_button,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          var us = User(
                            first_name: nom.text,
                            last_name: prenom.text,
                            email: email.text,
                            phone_number: int.parse(numero.text),
                            password: pass.text,
                            commentaire: comment.text,
                            image: "",
                            updated_At: DateTime.now().toString(),
                          );
                          auth.createUser(us).then(
                            (respo) {
                              if (respo!['statut']) {
                                var user = respo['user'];
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setUSer(user);
                                print('.................................ii');
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Error:${respo['message']}",
                                );
                              }
                              Fluttertoast.showToast(
                                msg: "Message:${respo['message']}",
                              );
                              auth.logStatus == Statut.registing
                                  ? null
                                  : Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) {
                                          return Home(
                                            person: respo['user'],
                                          );
                                        },
                                      ),
                                    );
                            },
                          );
                        },
                        child: auth.logStatus == Statut.registing
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
                  DelayedAnimation(
                    delay: 400,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Back',
                            style: GoogleFonts.poppins(color: red_button)),
                      ),
                    ),
                  ),
                ],
              ),
              bas()
            ],
          ),
        ),
      ),
    );
  }
}
