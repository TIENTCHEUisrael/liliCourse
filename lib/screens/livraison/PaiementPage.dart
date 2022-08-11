import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/models/adresse/Adresse/Adresse.dart';
import 'package:lilicourse/models/adresse/AdresseLivraison/AdresseLivraison.dart';
import 'package:lilicourse/models/adresse/AdresseRamassage/AdresseRamassage.dart';
import 'package:lilicourse/models/commande/commande.dart';
import 'package:lilicourse/widgets/appBar.dart';

import '../../main.dart';
import '../../models/user/user.dart';
import '../../widgets/bas.dart';
import '../../widgets/containFirst.dart';

class PaiementPage extends StatefulWidget {
  final User us;
  final AdressLiv adL;
  final AdressRam adR;
  final Adresse ad;
  final Commande com;

  const PaiementPage(
      {required this.us,
      required this.adL,
      required this.adR,
      required this.ad,
      required this.com});

  @override
  State<PaiementPage> createState() => _PaiementPageState();
}

class _PaiementPageState extends State<PaiementPage> {
  double _price = 1500.000;
  void calculatePrice() {
    var price;
    setState(
      () {
        _price = price;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    calculatePrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        const Text(
          'Paiement',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.5),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              containFirst(
                  imagePath: 'assets/images/delivery/svg/paiement.svg',
                  text: 'Paiement'),
              Container(
                width: 400,
                height: 120,
                decoration: BoxDecoration(
                  color: HexColor("32447A"),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Price :",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blue[200]),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "\$*****.**** FCFA",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Validate your paiement with",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Icon(
                      color: red_button,
                      Icons.arrow_drop_down,
                      size: 38,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Column(children: [
                  InkWell(
                    child: Card(
                      elevation: 1,
                      child: ListTile(
                        leading: Image.asset(
                          height: 50,
                          width: 50,
                          'assets/images/image3.jpg',
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          'Mobile Money',
                          style: GoogleFonts.poppins(color: blue_button),
                        ),
                        subtitle: Text(
                          'Make your payment with Mtn money',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Card(
                      elevation: 1,
                      child: ListTile(
                        leading: Image.asset(
                          height: 50,
                          width: 50,
                          'assets/images/image2.png',
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          'Orange Money',
                          style: GoogleFonts.poppins(color: blue_button),
                        ),
                        subtitle: Text(
                          'Make your payment with Orange money',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Card(
                      elevation: 1,
                      child: ListTile(
                        leading: Image.asset(
                          height: 50,
                          width: 50,
                          'assets/images/image1.png',
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          'Paypal',
                          style: GoogleFonts.poppins(color: blue_button),
                        ),
                        subtitle: Text(
                          'Make your payment with paypal',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              bas(),
            ],
          ),
        ),
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
