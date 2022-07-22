import 'package:flutter/material.dart';
import '../models/user/user.dart';
import '../models/user/userApi.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User>? _users;
  User? user;
  bool _isLoading = true;
  var _obscuretext = true;
  final nomcontroller = TextEditingController();
  final prenomcontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmPasswordcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final commentairecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // getUsers();
    getUser(1);
    if (user != null) {
      nomcontroller.text = user!.first_name;
      prenomcontroller.text = user!.last_name;
      emailcontroller.text = user!.email;
      passwordcontroller.text = user!.password;
      phonecontroller.text = user!.phone_number.toString();
      commentairecontroller.text = user!.commentaire;
    } else {
      print("..............................;;null");
    }
  }

  @override
  void dispose() {
    super.dispose();
    nomcontroller.dispose();
    prenomcontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmPasswordcontroller.dispose();
    phonecontroller.dispose();
  }

  Future<void> getUsers() async {
    _users = await UserApi.getUsers();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getUser(int id) async {
    User us = await UserApi.getUser(id);
    setState(() {
      user = us;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person),
            SizedBox(
              width: 10,
            ),
            Text('Users'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            child: Column(children: [
          TextFormField(
            controller: nomcontroller,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.grey[400],
                decoration: TextDecoration.none,
              ),
              //border: OutlineInputBorder( borderSide: BorderSide( color: Colors.teal, ), ),
              labelText: 'Votre nom',
              prefixIcon: const Icon(
                Icons.edit,
              ),
              //errorText: _validate ? 'Value Can\'t Be Empty' : null,
            ),
          ),
          TextFormField(
            controller: prenomcontroller,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.grey[400],
                decoration: TextDecoration.none,
              ),
              labelText: 'Votre prenom',
              prefixIcon: const Icon(
                Icons.edit,
              ),
              //errorText: _validate ? 'Value Can\'t Be Empty' : null,
            ),
          ),
          TextFormField(
            controller: emailcontroller,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.grey[400],
                decoration: TextDecoration.none,
              ),
              labelText: 'Votre adresse email',
              prefixIcon: const Icon(
                Icons.mail,
              ),
              //errorText: _validate ? 'Value Can\'t Be Empty' : null,
            ),
          ),
          TextFormField(
            controller: phonecontroller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.grey[400],
                decoration: TextDecoration.none,
              ),
              labelText: 'Votre numero de telephone',
              prefixIcon: const Icon(
                Icons.phone,
              ),
              //errorText: _validate ? 'Value Can\'t Be Empty' : null,
            ),
          ),
          TextFormField(
            controller: passwordcontroller,
            obscureText: _obscuretext,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.grey[400],
                decoration: TextDecoration.none,
              ),
              labelText: 'Entrer un mot de passe',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.visibility,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _obscuretext = !_obscuretext;
                  });
                },
              ),
              //errorText: _validate ? 'Value Can\'t Be Empty' : null,
            ),
          ),
          TextFormField(
            controller: commentairecontroller,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.grey[400],
                decoration: TextDecoration.none,
              ),
              labelText: 'commentaire',
              prefixIcon: const Icon(
                Icons.phone,
              ),
              //errorText: _validate ? 'Value Can\'t Be Empty' : null,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '<< Precedent',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  /*UserApi.createUser(User(
                      first_name: nomcontroller.text,
                      last_name: prenomcontroller.text,
                      email: emailcontroller.text,
                      phone_number: int.parse(phonecontroller.text),
                      password: passwordcontroller.text,
                      commentaire: commentairecontroller.text,
                      image: ""));
                  print("User added");*/
                },
                child: Text(
                  'Enregistrer',
                ),
              ),
            ],
          ),
        ])),
      ),
    );
  }
}
