import 'package:flutter/material.dart';

class AttentePage extends StatefulWidget {
  const AttentePage({Key? key}) : super(key: key);

  @override
  State<AttentePage> createState() => _AttentePageState();
}

class _AttentePageState extends State<AttentePage> {
  @override
  Widget build(BuildContext context) {
    return /*SingleChildScrollView(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          containFirst(imagePath: 'assets/images/delivery/svg/delivery.svg', text: 'Demander une livraison'),
          Card(
            elevation: 5,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text('Que souhaitez vous envoyer ou recevoir ?',style: GoogleFonts.poppins(fontSize: 15),textAlign: TextAlign.center,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){print('Ok1');},
                      child: Carte(titre: 'Tout type d\'Object', icon:Icon(Icons.collections,size: 90,),),
                    ),
                    GestureDetector(
                      onTap: (){print('ok2');},
                      child: Carte(titre: 'Courrier', icon:Icon(Icons.contact_mail_rounded,size: 90,),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),*/
        Container();
  }
}
