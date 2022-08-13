import 'package:flutter/material.dart';
import 'package:lilicourse/Provider/ProviderCommande.dart';
import 'package:lilicourse/Provider/providerUser.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/models/paiement/Paiement.dart';
import 'package:provider/provider.dart';
import '../../../Animations/custum.dart';
import '../../../models/adresse/Adresse/Adresse.dart';
import '../../../models/adresse/AdresseLivraison/AdresseLivraison.dart';
import '../../../models/adresse/AdresseRamassage/AdresseRamassage.dart';
import '../../../models/commande/commande.dart';
import '../../../widgets/_addTodoButton.dart';
import '../../../widgets/pageRoute.dart';

class RequestTermine extends StatefulWidget {
  const RequestTermine({Key? key}) : super(key: key);

  @override
  State<RequestTermine> createState() => _RequestTermineState();
}

class _RequestTermineState extends State<RequestTermine> {
  List<Commande>? _commandes;
  List<Paiement>? _paiements;
  List<Adresse>? _adresses;
  Adresse? _adresse;
  AdressLiv? _adressLiv;
  AdressRam? _adressRam;
  bool _isLoading = true;

  @override
  void initState() {
    getCommandes();
    super.initState();
  }

  Future<void> getCommandes() async {
    await CommProvider().getCommandesPaiements().then((value) {
      if (value['statut']) {
        setState(() {
          _paiements = value['paiements'];
          _commandes = value['commandes'];
          _adresses = value['adresses'];
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _paiements!.length,
            itemBuilder: ((context, index) {
              return card(_paiements![index], _commandes![index],
                  _adresses![index], context);
            }),
          );
  }

  Widget card(Paiement p, Commande c, Adresse ad, BuildContext ctx) {
    AuthProvider auth = Provider.of<AuthProvider>(ctx);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) {
              return Popup(
                ad: ad,
                c: c,
                p: p,
              );
            },
          ),
        );
      },
      child: Hero(
        tag: hero,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: Card(
          elevation: 0.5,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: ListTile(
              title: Text(
                  "${ad.type} for ${auth.user.first_name} ${auth.user.last_name}"),
              leading: ad.type == "Colis"
                  ? const Icon(
                      Icons.collections,
                      color: blue_button,
                      size: 40,
                    )
                  : const Icon(
                      Icons.contact_mail,
                      color: blue_button,
                      size: 40,
                    ),
              subtitle: Row(
                children: [
                  Text("Poids:${ad.poids} KG"),
                  const SizedBox(
                    width: 3,
                  ),
                  Text("Taille:${ad.taille}")
                ],
              ),
              trailing: c.statut == "true"
                  ? const Text(
                      "Occupé",
                      style: TextStyle(color: Colors.red),
                    )
                  : const Text(
                      "Libre",
                      style: TextStyle(color: Colors.blue),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
