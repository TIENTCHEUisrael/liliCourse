import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/Provider/ProviderPaiement.dart';
import 'package:lilicourse/Provider/providerUser.dart';
import 'package:lilicourse/models/commande/commande.dart';
import 'package:lilicourse/models/paiement/Paiement.dart';
import 'package:provider/provider.dart';

import '../Animations/custum.dart';
import '../main.dart';

/// Tag-value used for the add todo popup button.
const String heroAddTodo = 'add-todo-hero';

class AddTodoPopupCard extends StatefulWidget {
  final double price;
  final Commande com;
  AddTodoPopupCard({required this.price, required this.com});

  @override
  State<AddTodoPopupCard> createState() => _AddTodoPopupCardState();
}

class _AddTodoPopupCardState extends State<AddTodoPopupCard> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _phone = TextEditingController();
    TextEditingController _price = TextEditingController();
    AuthProvider auth = Provider.of<AuthProvider>(context);
    PaiementProvider paiement = Provider.of<PaiementProvider>(context);
    bool _isLoading = true;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        'assets/images/image3.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: TextField(
                        controller: _phone,
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.phone,
                        cursorColor: Colors.black,
                        maxLines: 2,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    ListTile(
                      leading: const Icon(Icons.price_check),
                      title: TextField(
                        controller: _price,
                        decoration: const InputDecoration(
                          hintText: '\$ Price',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.black,
                        maxLines: 2,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.com == null || widget.price == null) {
                        } else {
                          var us = auth.user;
                          var paie = Paiement(
                            userId: us.id!,
                            commandeId: widget.com.commandeId!,
                            montant: _price.text,
                            mode: "Mobile Money",
                            phone: _phone.text,
                            updated_at: DateTime.now().toString(),
                          );
                          print(
                              '.................START PAIEMENT.........................');
                          paiement.createPaiement(paie).then(
                            (value) {
                              if (value['statut']) {
                                print("${value['paiement']}");
                                Fluttertoast.showToast(
                                  msg: "Message:${value['message']}",
                                );
                                setState(
                                  () {
                                    _isLoading = false;
                                  },
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Error:${value['message']}",
                                );
                              }
                            },
                          );
                          print(
                              ".........................FINISH PAIEMENT.......................");
                        }
                      },
                      child: Text(
                        'Validate',
                        style: GoogleFonts.poppins(
                            color: blue_button, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String otherHero = 'add-hero';

class PaiementOrange extends StatefulWidget {
  final double price;
  final Commande com;
  PaiementOrange({required this.price, required this.com});

  @override
  State<PaiementOrange> createState() => _PaiementOrangeState();
}

class _PaiementOrangeState extends State<PaiementOrange> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _phone = TextEditingController();
    TextEditingController _price = TextEditingController();
    AuthProvider auth = Provider.of<AuthProvider>(context);
    PaiementProvider paiement = Provider.of<PaiementProvider>(context);
    bool _isLoading = true;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        'assets/images/image2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: TextField(
                        controller: _phone,
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.phone,
                        cursorColor: Colors.black,
                        maxLines: 2,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    ListTile(
                      leading: const Icon(Icons.price_check),
                      title: TextField(
                        controller: _price,
                        decoration: const InputDecoration(
                          hintText: '\$ Price',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.black,
                        maxLines: 2,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.com == null || widget.price == null) {
                        } else {
                          var us = auth.user;
                          var paie = Paiement(
                            userId: us.id!,
                            commandeId: widget.com.commandeId!,
                            montant: _price.text,
                            mode: "Mobile Money",
                            phone: _phone.text,
                            updated_at: DateTime.now().toString(),
                          );
                          print(
                              '.................START PAIEMENT.........................');
                          paiement.createPaiement(paie).then(
                            (value) {
                              if (value['statut']) {
                                print("${value['paiement']}");
                                Fluttertoast.showToast(
                                  msg: "Message:${value['message']}",
                                );
                                setState(
                                  () {
                                    _isLoading = false;
                                  },
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Error:${value['message']}",
                                );
                              }
                            },
                          );
                          print(
                              ".........................FINISH PAIEMENT.......................");
                        }
                      },
                      child: Text(
                        'Validate',
                        style: GoogleFonts.poppins(
                            color: blue_button, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String otherHero2 = 'add-todo';

class PaiementPayPal extends StatefulWidget {
  final double price;
  final Commande com;
  PaiementPayPal({required this.price, required this.com});
  @override
  State<PaiementPayPal> createState() => _PaiementPayPalState();
}

class _PaiementPayPalState extends State<PaiementPayPal> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _phone = TextEditingController();
    TextEditingController _price = TextEditingController();
    AuthProvider auth = Provider.of<AuthProvider>(context);
    PaiementProvider paiement = Provider.of<PaiementProvider>(context);
    bool _isLoading = true;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        'assets/images/image1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: TextField(
                        controller: _phone,
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.phone,
                        cursorColor: Colors.black,
                        maxLines: 2,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    ListTile(
                      leading: const Icon(Icons.price_check),
                      title: TextField(
                        controller: _price,
                        decoration: const InputDecoration(
                          hintText: '\$ Price',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.black,
                        maxLines: 2,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.com == null || widget.price == null) {
                        } else {
                          var us = auth.user;
                          var paie = Paiement(
                            userId: us.id!,
                            commandeId: widget.com.commandeId!,
                            montant: _price.text,
                            mode: "Mobile Money",
                            phone: _phone.text,
                            updated_at: DateTime.now().toString(),
                          );
                          print(
                              '.................START PAIEMENT.........................');
                          paiement.createPaiement(paie).then(
                            (value) {
                              if (value['statut']) {
                                print("${value['paiement']}");
                                Fluttertoast.showToast(
                                  msg: "Message:${value['message']}",
                                );
                                setState(
                                  () {
                                    _isLoading = false;
                                  },
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Error:${value['message']}",
                                );
                              }
                            },
                          );
                          print(
                              ".........................FINISH PAIEMENT.......................");
                        }
                      },
                      child: Text(
                        'Validate',
                        style: GoogleFonts.poppins(
                            color: blue_button, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
