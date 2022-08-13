import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/Provider/ProviderPaiement.dart';
import 'package:lilicourse/Provider/providerUser.dart';
import 'package:lilicourse/models/adresse/Adresse/Adresse.dart';
import 'package:lilicourse/models/adresse/AdresseLivraison/AdresseLivraison.dart';
import 'package:lilicourse/models/adresse/AdresseRamassage/AdresseRamassage.dart';
import 'package:lilicourse/models/commande/commande.dart';
import 'package:lilicourse/models/paiement/Paiement.dart';
import 'package:provider/provider.dart';
import '../Animations/custum.dart';
import '../Provider/ProviderAdressLiv.dart';
import '../Provider/ProviderAdressRam.dart';
import '../main.dart';
import '../screens/livraison/PageMap.dart';

/// Tag-value used for the add todo popup button.
const String heroAddTodo = 'add-todo-hero';

class AddTodoPopupCard extends StatefulWidget {
  final double price;
  final Commande com;
  final PlaceLocation st;
  final PlaceLocation de;
  AddTodoPopupCard(
      {required this.st,
      required this.de,
      required this.price,
      required this.com});

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
                          Fluttertoast.showToast(
                            msg: "Error:['One Value is null']}",
                          );
                        }
                        if (int.parse(_price.text) < widget.price) {
                          Fluttertoast.showToast(
                            msg: "Error:['Value is not correct']}",
                          );
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
                          print("");
                          print(
                              '.................START PAIEMENT.........................');
                          print("");
                          paiement.createPaiement(paie).then(
                            (value) {
                              if (value['statut']) {
                                print("${value['paiement']}");
                                var p = value['paiement'];
                                print("");
                                print(
                                    '.........START PAIEMENT MTN..............');
                                print("");
                                paiement.PaiementMtn(p).then((tap) {
                                  if (tap['statut']) {
                                    var ok = tap['data'];
                                    print(ok);
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    print("");
                                    print(
                                        '.........FINISH PAIEMENT..............');
                                    print("");
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) {
                                          return AttentePage(
                                              st: widget.st, de: widget.de);
                                        },
                                      ),
                                    );
                                  } else {}
                                });
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Error:${value['message']}",
                                );
                              }
                            },
                          );

                          print("");
                          print(
                              ".........................FINISH PAIEMENT.......................");
                          print("");
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
  final PlaceLocation st;
  final PlaceLocation de;
  PaiementOrange(
      {required this.st,
      required this.de,
      required this.price,
      required this.com});

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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) {
                                      return AttentePage(
                                          st: widget.st, de: widget.de);
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
  final PlaceLocation st;
  final PlaceLocation de;
  PaiementPayPal(
      {required this.st,
      required this.de,
      required this.price,
      required this.com});
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) {
                                      return AttentePage(
                                          st: widget.st, de: widget.de);
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
const String hero = 'ad-todo';

class Popup extends StatefulWidget {
  final Adresse ad;
  final Commande c;
  final Paiement p;

  Popup({required this.ad, required this.c, required this.p});

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  bool _isloading = true;
  AdressLiv? _adressLiv;
  AdressRam? _adressRam;
  @override
  void initState() {
    getAdressRam();
    getAdressLiv();
    super.initState();
  }

  Future<void> getAdressLiv() async {
    await AdLProvider().getAdressLivById(widget.ad.adresslivid).then((value) {
      if (value!['statut']) {
        setState(() {
          _adressLiv = value['adressLiv'];
          print(_adressLiv);
          _isloading = false;
        });
      }
    });
  }

  Future<void> getAdressRam() async {
    await AdRProvider().getAdressRamById(widget.ad.adressramid).then((value) {
      if (value!['statut']) {
        setState(() {
          _adressRam = value['adressRam'];
          print(_adressRam);
          _isloading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? const Center(child: CircularProgressIndicator())
        : Center(
            child: Hero(
              tag: hero,
              createRectTween: (begin, end) {
                return CustomRectTween(begin: begin!, end: end!);
              },
              child: Material(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text(
                            'Information Paiement',
                            style: TextStyle(color: blue_button),
                          ),
                          subtitle: Text(
                              'Mode: ${widget.p.mode}, Money: ${widget.p.montant}, Number: ${widget.p.phone}'),
                          trailing:
                              const Icon(Icons.payment, color: blue_button),
                        ),
                        ListTile(
                          title: const Text(
                            'Order informations ',
                            style: TextStyle(color: blue_button),
                          ),
                          subtitle: Text(
                              'Weight :${widget.ad.poids}, Size: ${widget.ad.taille}, Type: ${widget.ad.type}'),
                          trailing:
                              const Icon(Icons.info_sharp, color: blue_button),
                        ),
                        ListTile(
                          title: const Text(
                            'Pickup informations ',
                            style: TextStyle(color: blue_button),
                          ),
                          subtitle: Text(
                              'Transmitter :${_adressRam!.nameEmetteur},Civility :${_adressRam!.civiliteEmetteur}, Contact :${_adressRam!.contactEmetteur}, Adresse :${_adressRam!.localisationRam}'),
                          trailing: const Icon(Icons.local_activity,
                              color: blue_button),
                        ),
                        ListTile(
                          title: const Text(
                            'Deposit informations ',
                            style: TextStyle(color: blue_button),
                          ),
                          subtitle: Text(
                              'Receiver :${_adressLiv!.nameRecepteur},Civility :${_adressLiv!.civiliteRecepteur}, Contact :${_adressLiv!.contactRecepteur}, Adresse: ${_adressLiv!.localisationLiv}'),
                          trailing: const Icon(Icons.local_activity,
                              color: blue_button),
                        ),
                        const Center(
                          child: Text('Thank\'s'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
