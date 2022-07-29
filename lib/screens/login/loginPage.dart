import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/Animations/DelayedAnimation.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/screens/Home/HomePage.dart';
import 'package:provider/provider.dart';
import '../../Provider/provideruser.dart';
import '../../models/user/user.dart';
import '../../widgets/bas.dart';
import '../Inscription/Choice.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  User? user;
  bool _obscuretext = true;
  Color _color = Colors.grey;
  bool isLoading = false;
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 100,
            horizontal: 30,
          ),
          child: Column(
            children: [
              DelayedAnimation(
                delay: 90,
                child: Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  height: 280,
                  width: 290,
                  child: Image.asset("assets/images/d.png"),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DelayedAnimation(
                        delay: 400,
                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            labelText: 'Your adress mail',
                            prefixIcon: const Icon(Icons.mail),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mail';
                            }
                            return null;
                          },
                        ),
                      ),
                      DelayedAnimation(
                        delay: 450,
                        child: TextFormField(
                          controller: pass,
                          obscureText: _obscuretext,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            labelText: 'Your password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.visibility,
                                color: _color,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscuretext = !_obscuretext;
                                  _color = Colors.black;
                                });
                              },
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your pass';
                            }
                            return null;
                          },
                        ),
                      ),
                      DelayedAnimation(
                        delay: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'You are forget your password ?',
                                style: GoogleFonts.arimo(
                                    color: Colors.blue, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 510,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: blue_button,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.only(
                          left: 100,
                          right: 100,
                          top: 10,
                          bottom: 10,
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : Text(
                              'Connexion',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18),
                            ),
                      onPressed: () {
                        final form = _formKey.currentState;

                        if (form!.validate()) {
                          form.save();
                          final Future<Map<String, dynamic>?> response =
                              auth.loginUser(email.text, pass.text);
                          response.then(
                            (respo) {
                              if (respo!['statut']) {
                                User user = respo['user'];
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setUSer(user);
                                Fluttertoast.showToast(
                                  msg: "${respo['message']}",
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) {
                                      return Home();
                                    },
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Error:${respo['message']}",
                                );
                              }
                            },
                          );
                        }
                      }),
                ),
              ),
              DelayedAnimation(
                delay: 530,
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 30,
                  ),
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      'Inscription',
                      style: GoogleFonts.poppins(
                        color: red_button,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ChoicePage();
                        }),
                      );
                    },
                  ),
                ),
              ),
              bas(),
            ],
          ),
        ),
      ),
    );
  }
}
