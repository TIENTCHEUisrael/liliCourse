import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/Animations/DelayedAnimation.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/models/user/userApi.dart';
import 'package:lilicourse/screens/Home/HomePage.dart';
import '../../widgets/bas.dart';
import '../Inscription/Choice.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscuretext = false;
  Color _color = Colors.grey;
  bool isLoading = false;
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        UserApi.authenticateUser(email.text, pass.text)
                            .then((result) {
                          setState(() {
                            isLoading = true;
                          });
                          return Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) {
                              return Home(
                                person: result,
                              );
                            }),
                          );
                        });
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
