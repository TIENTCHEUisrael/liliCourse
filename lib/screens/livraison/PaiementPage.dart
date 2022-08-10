import 'package:flutter/material.dart';
import 'package:lilicourse/models/adresse/Adresse/Adresse.dart';
import 'package:lilicourse/models/adresse/AdresseLivraison/AdresseLivraison.dart';
import 'package:lilicourse/models/adresse/AdresseRamassage/AdresseRamassage.dart';
import 'package:lilicourse/models/commande/commande.dart';
import 'package:lilicourse/widgets/appBar.dart';

class PaiementPage extends StatefulWidget {
  final AdressLiv adL;
  final AdressRam adR;
  final Adresse ad;
  final Commande com;

  const PaiementPage(
      {Key? key,
      required this.adL,
      required this.adR,
      required this.ad,
      required this.com})
      : super(key: key);

  @override
  State<PaiementPage> createState() => _PaiementPageState();
}

class _PaiementPageState extends State<PaiementPage> {
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
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [],
        ),
      )),
    );
  }
}
