import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/main.dart';

import '../../Animations/DelayedAnimation.dart';
import '../../widgets/appBar.dart';
import '../Inscription/inscriptionCoursier.dart';

class Apropos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context,
          Text(
            'A propos',
            style: GoogleFonts.poppins(color: Colors.black),
          )),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              DelayedAnimation(
                delay: 200,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Pour les Clients, demander votre livraison avec Shexpir et bénéficier de ...',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                ),
              ),
              ListTitlePro(
                  title: 'Connexion a la demande',
                  text:
                      'Notre service est disponible quand vous voulez et ou vous vous trouver',
                  icon: const Icon(
                    Icons.shopping_bag,
                    color: Colors.pink,
                  ),
                  delay: 300,
                  icons: null),
              ListTitlePro(
                  title: 'Securite de vos colis',
                  text:
                      'Notre service s\'assure de la securite de vos colis du lieu de depart au lieu d\'arriver',
                  icon: const Icon(
                    Icons.security,
                    color: Colors.green,
                  ),
                  delay: 350,
                  icons: null),
              ListTitlePro(
                  title: 'Controle du Colis',
                  text:
                      'Notre service s\'assure que vous puissiez suivre votre colis en temps reelles',
                  icon: const Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.blueAccent,
                  ),
                  delay: 400,
                  icons: null),
              const SizedBox(
                height: 15,
              ),
              DelayedAnimation(
                delay: 900,
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'Pour devenir livreur',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 19),
                        ),
                        const Text(
                          'Ce dont vous avez besoin pour etre livreur ...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTitlePro2(
                  title: null,
                  text: 'Inscription en tant que travailleur indépendant ' +
                      ' dans votre pays ',
                  icon: const Icon(
                    Icons.gpp_good,
                    color: Colors.blueAccent,
                  ),
                  delay: 500,
                  icons: null),
              ListTitlePro2(
                  title: null,
                  text: 'Disposez d\'un smartphone avec iOS 12/Android ' +
                      ' 6.0 ou versions ultérieures',
                  icon: const Icon(
                    Icons.gpp_good,
                    color: Colors.blueAccent,
                  ),
                  delay: 550,
                  icons: null),
              ListTitlePro2(
                  title: null,
                  text: 'Disposez d\'un vélo comme moyen de transport',
                  icon: const Icon(
                    Icons.gpp_good,
                    color: Colors.blueAccent,
                  ),
                  delay: 600,
                  icons: null),
              ListTitlePro2(
                  title: null,
                  text: 'Disposez des équipements de sécurité (ex: casque)',
                  icon: const Icon(
                    Icons.gpp_good,
                    color: Colors.blueAccent,
                  ),
                  delay: 650,
                  icons: null),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      elevation: 2,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Nous contacter',
                            style: TextStyle(color: blue_button, fontSize: 17)),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return InscriptionCoursier();
                          }));
                        },
                        child: const Text('Devenir Coursier',
                            style: TextStyle(color: blue_button, fontSize: 17)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

Widget ListTitlePro(
    {required String title,
    required String text,
    required Icon icon,
    required int delay,
    required Icon? icons}) {
  return DelayedAnimation(
    delay: delay,
    child: Card(
      elevation: 3,
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: GoogleFonts.poppins(color: blue_button),
        ),
        subtitle: Text(
          text,
          style: GoogleFonts.poppins(),
        ),
        trailing: icons,
      ),
    ),
  );
}

Widget ListTitlePro2(
    {required String? title,
    required String text,
    required Icon icon,
    required int delay,
    required Icon? icons}) {
  return DelayedAnimation(
    delay: delay,
    child: ListTile(
      leading: icon,
      subtitle: Text(
        text,
        style: GoogleFonts.poppins(),
      ),
      trailing: icons,
    ),
  );
}
