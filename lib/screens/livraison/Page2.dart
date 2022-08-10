import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/Provider/ProviderAdress.dart';
import 'package:lilicourse/Provider/ProviderAdressLiv.dart';
import 'package:lilicourse/Provider/ProviderCommande.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/models/adresse/AdresseLivraison/AdresseLivraison.dart';
import 'package:lilicourse/models/adresse/AdresseRamassage/AdresseRamassage.dart';
import 'package:lilicourse/widgets/dataTable.dart';
import 'package:lilicourse/widgets/locationInput.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Animations/DelayedAnimation.dart';
import '../../Provider/ProviderAdressRam.dart';
import '../../Provider/providerUser.dart';
import '../../models/adresse/Adresse/Adresse.dart';
import '../../models/commande/commande.dart';
import '../../models/paiement/Paiement.dart';
import '../../widgets/appBar.dart';
import '../../widgets/bas.dart';
import '../../widgets/containFirst.dart';
import 'PageMap.dart';
import 'PaiementPage.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool isLoading = false;
  AdressLiv? adressLiv;
  AdressRam? adressRam;
  Adresse? adresse;
  Commande? commande;
  int currentStep = 0;
  Color? colorIn = Colors.transparent;
  Color? colorOut = Colors.transparent;
  double t1 = 10;
  double t2 = 10;
  double t3 = 10;
  double h1 = 15;
  double h2 = 9;
  double h3 = 12;

  int _value = 1;
  int _value2 = 1;
  int _value3 = 1;
  bool isCompleted = false;

  String? type;
  String taille = "Taille M";
  double? poids;
  String? planification;
  PlaceLocation? _pickedLocation;

  String? localisationrecepteur;
  final localisationR = TextEditingController();
  final namerecepteur = TextEditingController();
  final contactrecepteur = TextEditingController();
  final emailrecepteur = TextEditingController();
  final instructionrecepteur = TextEditingController();
  String? civiliterecepteur;

  String? localisationRamassage;
  final localisationE = TextEditingController();
  final nameemetteur = TextEditingController();
  final contactemetteur = TextEditingController();
  final emailemetteur = TextEditingController();
  final instructionemetteur = TextEditingController();
  String? civiliteemetteur;

  @override
  void initState() {
    super.initState();
  }

  AdressLiv addAdressLivraison(BuildContext ctx) {
    var adL = AdressLiv(
        localisationLiv: localisationrecepteur!,
        nameRecepteur: namerecepteur.text,
        contactRecepteur: int.parse(contactrecepteur.text),
        emailRecepteur: emailrecepteur.text,
        civiliteRecepteur: civiliterecepteur!,
        instruction: instructionrecepteur.text,
        updatedAt: DateTime.now().toString());
    setState(
      () {
        adressLiv = adL;
      },
    );
    AdLProvider proAdl = Provider.of<AdLProvider>(ctx);
    proAdl.createAdresseLiv(adressLiv!).then((value) {
      if (value['statut'] == true) {
        setState(
          () {
            adressLiv = value['adressLiv'];
          },
        );
        Provider.of<AdLProvider>(context, listen: false)
            .setAdressLiv(adressLiv!);
        print('succesfully.................................ii');
        Fluttertoast.showToast(
          msg: "Message:${value['message']}",
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error:${value['message']}",
        );
      }
    });
    return adressLiv!;
  }

  Commande addCommande(BuildContext ctx) {
    AuthProvider auth = Provider.of<AuthProvider>(ctx);
    AdProvider ad = Provider.of<AdProvider>(ctx);
    var us = auth.user;
    var adre = ad.adresse;
    var com = Commande(
        client_id: us.id!,
        adresse_id: ad.id,
        statut: false,
        updated_at: DateTime.now().toString());
    setState(
      () {
        commande = com;
        isLoading = false;
      },
    );
    CommProvider proAdl = Provider.of<CommProvider>(ctx);
    proAdl.createAdress(commande!).then((value) {
      if (value['statut'] == true) {
        setState(
          () {
            commande = value['commande'];
          },
        );
        Provider.of<CommProvider>(context, listen: false)
            .setCommande(commande!);
        print('succesfully..........................................');
        Fluttertoast.showToast(
          msg: "Message:${value['message']}",
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error:${value['message']}",
        );
      }
    });
    return commande!;
  }

  Adresse addAdress(BuildContext ctx) {
    var ad = Adresse(
        adresslivid: adressLiv!.adressLivId!,
        adressramid: adressRam!.adressRamId!,
        poids: poids.toString(),
        taille: taille,
        type: type!,
        planification: planification!,
        updatedAt: DateTime.now().toString());
    setState(
      () {
        adresse = ad;
      },
    );
    AdProvider proAdl = Provider.of<AdProvider>(ctx);
    proAdl.createAdress(adresse!).then((value) {
      if (value['statut'] == true) {
        setState(
          () {
            adresse = value['adresse'];
          },
        );
        Provider.of<AdProvider>(context, listen: false).setAdress(adresse!);
        print('succesfully.................................ii');
        Fluttertoast.showToast(
          msg: "Message:${value['message']}",
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error:${value['message']}",
        );
      }
    });
    return adresse!;
  }

  AdressRam addAdressRamassage(BuildContext ctx) {
    var adR = AdressRam(
        localisationRam: localisationRamassage!,
        nameEmetteur: nameemetteur.text,
        contactEmetteur: int.parse(contactemetteur.text),
        emailEmetteur: emailemetteur.text,
        civiliteEmetteur: civiliteemetteur!,
        instruction: instructionemetteur.text,
        updatedAt: DateTime.now().toString());
    setState(
      () {
        adressRam = adR;
      },
    );
    AdRProvider proAdl = Provider.of<AdRProvider>(ctx);
    proAdl.createAdresseRam(adressRam!).then((value) {
      if (value['statut'] == true) {
        setState(
          () {
            adressRam = value['adresseRam'];
          },
        );
        Provider.of<AdRProvider>(context, listen: false)
            .setAdressRam(adressRam!);
        print('succesfully.................................ii');
        Fluttertoast.showToast(
          msg: "Message:${value['message']}",
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error:${value['message']}",
        );
      }
    });
    return adressRam!;
  }

  void _selectPlaceR(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
    if (_pickedLocation!.latitude == null ||
        _pickedLocation!.longitude == null) {
    } else {
      print('ok');
      var bob = Provider.of<AdRProvider>(context, listen: false)
          .getPlaceAdress(_pickedLocation!.latitude, _pickedLocation!.longitude)
          .then(
        (value) {
          setState(() {
            localisationE.text = value;
            localisationRamassage = value;
          });
          print(localisationRamassage);
        },
      );
    }
  }

  void _selectPlaceL(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
    if (_pickedLocation!.latitude == null ||
        _pickedLocation!.longitude == null) {
      print('Error');
    } else {
      print('ok');
      var bob = Provider.of<AdRProvider>(context, listen: false)
          .getPlaceAdress(_pickedLocation!.latitude, _pickedLocation!.longitude)
          .then(
        (value) {
          setState(() {
            localisationR.text = value;
            localisationrecepteur = value;
          });
          print(localisationrecepteur);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        Text('Delivery Page', style: GoogleFonts.poppins(color: Colors.black)),
      ),
      body: isCompleted
          ? buildCompleted(context)
          : Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: Colors.blue),
              ),
              child: Stepper(
                type: StepperType.horizontal,
                steps: getSteps(),
                currentStep: currentStep,
                //lorsque on reparr en avant d'un step
                onStepContinue: () {
                  final isLastStep = currentStep == getSteps().length - 1;
                  if (isLastStep) {
                    setState(() {
                      isCompleted = true;
                    });
                    print('completed');
                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                //lorsque on revient en arriere d'un step
                onStepCancel: currentStep == 0
                    ? null
                    : () {
                        setState(() {
                          currentStep -= 1;
                        });
                      },
                //Au clic sur un step
                onStepTapped: (step) {
                  setState(() {
                    currentStep =
                        step; //Pour permettre de defiler en cliquand tu l'un des step
                  });
                },
                controlsBuilder: (context, ControlsDetails details) {
                  final isLastStep = currentStep == getSteps().length - 1;
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: DelayedAnimation(
                            delay: 150,
                            child: ElevatedButton(
                              onPressed: details.onStepContinue,
                              child: Text(
                                'Next',
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        if (currentStep != 0)
                          Expanded(
                            child: DelayedAnimation(
                              delay: 200,
                              child: ElevatedButton(
                                onPressed: details.onStepCancel,
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
                //Customiser nos bouton
              ),
            ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text(''),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                containFirst(
                    imagePath: 'assets/images/delivery/svg/request.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Que souhaitez vous envoyer ou recevoir ?',
                          style: GoogleFonts.poppins(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.elasticInOut,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  type = "Colis";
                                  colorIn = Colors.blueGrey;
                                  colorOut = Colors.transparent;
                                });
                                print(type);
                              },
                              child: Column(
                                children: [
                                  const Card(
                                    //color: Colors.grey,
                                    elevation: 4,
                                    child: Icon(
                                      Icons.collections,
                                      size: 90,
                                      color: blue_button,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        border: Border.all(color: colorIn!)),
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      'Colis',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: blue_button),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.elasticInOut,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  type = "Courriel";
                                  colorIn = Colors.transparent;
                                  colorOut = Colors.blueGrey;
                                });
                                print(type);
                              },
                              child: Column(
                                children: [
                                  const Card(
                                    elevation: 4,
                                    child: Icon(
                                      Icons.contact_mail,
                                      size: 90,
                                      color: blue_button,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        border: Border.all(color: colorOut!)),
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      'Courrier',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: blue_button),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text(''),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                containFirst(
                    imagePath: 'assets/images/delivery/svg/info.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Caracteristique de votre Colis',
                          style: GoogleFonts.poppins(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                poids = 3;
                                t1 = 15;
                                t2 = 10;
                                t3 = 10;
                                print('poids:$poids');
                              });
                            },
                            child: Card(
                              elevation: 4,
                              child: Container(
                                padding: EdgeInsets.all(t1),
                                child: Column(
                                  children: [
                                    Text(
                                      '0-3 KG',
                                      style: GoogleFonts.poppins(
                                          color: blue_button),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '+0 XAF',
                                      style: GoogleFonts.poppins(
                                          color: blue_button),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(
                                () {
                                  poids = 7;
                                  t2 = 15;
                                  t1 = 10;
                                  t3 = 10;
                                  print('poids:$poids');
                                },
                              );
                            },
                            child: Card(
                              elevation: 4,
                              child: Container(
                                padding: EdgeInsets.all(t2),
                                child: Column(
                                  children: [
                                    Text(
                                      '4-7 KG',
                                      style: GoogleFonts.poppins(
                                          color: blue_button),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '+1000 XAF',
                                      style: GoogleFonts.poppins(
                                          color: blue_button),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(
                                () {
                                  poids = 10;
                                  t3 = 15;
                                  t2 = 10;
                                  t1 = 10;

                                  print('poids:$poids');
                                },
                              );
                            },
                            child: Card(
                              elevation: 4,
                              child: Container(
                                padding: EdgeInsets.all(t3),
                                child: Column(
                                  children: [
                                    Text(
                                      '8-10 KG',
                                      style: GoogleFonts.poppins(
                                          color: blue_button),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '+3000 XAF',
                                      style: GoogleFonts.poppins(
                                          color: blue_button),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: _value3,
                                  onChanged: (value) {
                                    setState(() {
                                      _value3 = value as int;
                                      taille = "Taille M";
                                      print('taille:$taille');
                                    });
                                  },
                                ),
                                Text(
                                  'Taille M',
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: _value3,
                                  onChanged: (value) {
                                    setState(() {
                                      _value3 = value as int;
                                      taille = "Taille S";
                                      print('taille:$taille');
                                    });
                                  },
                                ),
                                Text(
                                  'Taille S',
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text(''),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                containFirst(
                    imagePath: 'assets/images/delivery/svg/pickup.svg',
                    text: 'Pickup Details'),
                Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            const Icon(Icons.info,
                                size: 25, color: blue_button),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Information transmitter',
                              style: GoogleFonts.poppins(
                                  fontSize: 15, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                icon: Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  width: 10,
                                  height: 10,
                                  child: const Icon(
                                    Icons.info,
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Name of sender",
                                //border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.only(left: 8.0, top: 16.0),
                              ),
                              controller: nameemetteur,
                              style: const TextStyle(fontSize: 12),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                icon: Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  width: 10,
                                  height: 10,
                                  child: const Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Email of sender",
                                //border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.only(left: 8.0, top: 16.0),
                              ),
                              controller: emailemetteur,
                              style: const TextStyle(fontSize: 12),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                icon: Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  width: 10,
                                  height: 10,
                                  child: const Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Contact of sender",
                                contentPadding:
                                    const EdgeInsets.only(left: 8.0, top: 16.0),
                              ),
                              controller: contactemetteur,
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 3,
                                ),
                                const Icon(Icons.info,
                                    size: 25, color: blue_button),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Civility transmitter',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.blue),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: _value3,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _value3 = value as int;
                                        civiliteemetteur = "Masculin";
                                      },
                                    );
                                    print(civiliteemetteur);
                                  },
                                ),
                                Text(
                                  'Masculin',
                                  style: GoogleFonts.poppins(fontSize: 13),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Radio(
                                  value: 2,
                                  groupValue: _value3,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _value3 = value as int;
                                        civiliteemetteur = "Feminin";
                                      },
                                    );
                                    print(civiliteemetteur);
                                  },
                                ),
                                Text(
                                  'Feminin',
                                  style: GoogleFonts.poppins(fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(Icons.maps_home_work,
                                    size: 25, color: blue_button),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("Localisation",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15, color: Colors.blue)
                                    //textAlign: TextAlign.start,
                                    ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      LocationInput(
                        controller: localisationE,
                        onselectPlace: _selectPlaceR,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(Icons.comment,
                              size: 25, color: blue_button),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("Instruction",
                              style: GoogleFonts.poppins(
                                  fontSize: 15, color: Colors.blue)
                              //textAlign: TextAlign.start,
                              ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 10),
                        child: TextField(
                          controller: instructionemetteur,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText:
                                  'Your instruction fo the delivery man about the transmitter of the course'),
                          style: GoogleFonts.poppins(fontSize: 12),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const Text(''),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                containFirst(
                    imagePath: 'assets/images/delivery/svg/deposit.svg',
                    text: 'Deposit Details'),
                Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            const Icon(Icons.info,
                                size: 25, color: blue_button),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Instruction receiver",
                              style: GoogleFonts.poppins(
                                  fontSize: 15, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                icon: Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  width: 10,
                                  height: 10,
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Name of receiver",
                                //border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.only(left: 8.0, top: 16.0),
                              ),
                              controller: namerecepteur,
                              style: const TextStyle(fontSize: 12),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                icon: Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  width: 10,
                                  height: 10,
                                  child: const Icon(
                                    Icons.mail,
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Email of receiver",
                                //border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.only(left: 8.0, top: 16.0),
                              ),
                              controller: emailrecepteur,
                              style: const TextStyle(fontSize: 12),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                icon: Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  width: 10,
                                  height: 10,
                                  child: const Icon(
                                    Icons.phone_android,
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Contact of receiver",
                                //border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.only(left: 8.0, top: 16.0),
                              ),
                              controller: contactrecepteur,
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 30,
                                ),
                                const Icon(Icons.note,
                                    size: 25, color: blue_button),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("Civility",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15, color: Colors.blue)
                                    //textAlign: TextAlign.start,
                                    ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: _value3,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _value3 = value as int;
                                        civiliterecepteur = "Masculin";
                                      },
                                    );
                                    print(civiliterecepteur);
                                  },
                                ),
                                Text(
                                  'Masculin',
                                  style: GoogleFonts.poppins(fontSize: 13),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Radio(
                                  value: 2,
                                  groupValue: _value3,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _value3 = value as int;
                                        civiliterecepteur = "Feminin";
                                      },
                                    );
                                    print(civiliterecepteur);
                                  },
                                ),
                                Text(
                                  'Feminin',
                                  style: GoogleFonts.poppins(fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 30,
                                ),
                                const Icon(Icons.info,
                                    size: 25, color: blue_button),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("Localisation of receiver",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15, color: Colors.blue)
                                    //textAlign: TextAlign.start,
                                    ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      LocationInput(
                        controller: localisationR,
                        onselectPlace: _selectPlaceL,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 40,
                          ),
                          const Icon(Icons.comment,
                              size: 25, color: blue_button),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("Instruction",
                              style: GoogleFonts.poppins(
                                  fontSize: 15, color: Colors.blue)
                              //textAlign: TextAlign.start,
                              ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 10),
                        child: TextField(
                          controller: instructionrecepteur,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText:
                                  'Give the instruction about the receiver of your course'),
                          style: GoogleFonts.poppins(fontSize: 12),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 4 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 4,
          title: const Text(''),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                containFirst(
                    imagePath: 'assets/images/delivery/svg/w.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Delivery planning',
                          style: GoogleFonts.poppins(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _value = value as int;
                                    },
                                  );
                                },
                              ),
                              Text('Aussitot que possible',
                                  style: GoogleFonts.poppins(fontSize: 15)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _value = value as int;
                                    },
                                  );
                                },
                              ),
                              Text('1h:00',
                                  style: GoogleFonts.poppins(fontSize: 15)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 3,
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _value = value as int;
                                    },
                                  );
                                },
                              ),
                              Text('2h:00',
                                  style: GoogleFonts.poppins(fontSize: 15)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 4,
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _value = value as int;
                                    },
                                  );
                                },
                              ),
                              Text('30 min',
                                  style: GoogleFonts.poppins(fontSize: 15)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 5,
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _value = value as int;
                                    },
                                  );
                                },
                              ),
                              Text('Rien',
                                  style: GoogleFonts.poppins(fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          'Give as much time as you want',
                          style: GoogleFonts.poppins(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          'This will be taken into account in the fees',
                          style: GoogleFonts.poppins(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 5 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 5,
          title: const Text(''),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                containFirst(
                    imagePath: 'assets/images/delivery/svg/information.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Summary',
                          style: GoogleFonts.poppins(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          "Delivery information",
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.blue),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 5, right: 5, top: 8, bottom: 5),
                        padding: const EdgeInsets.only(
                            left: 3, right: 3, top: 3, bottom: 3),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(2),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Package size: "),
                                Text(taille),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Package weight: "),
                                Text("$poids"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Type of package: "),
                                Text(
                                  type == null ? " " : type!,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          "Pickup information: ",
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.blue),
                        ),
                      ),
                      DataTableWidget(
                        name: nameemetteur.text,
                        email: emailemetteur.text,
                        contact: contactemetteur.text,
                        civility:
                            civiliteemetteur == null ? " " : civiliteemetteur!,
                        localisation: localisationRamassage == null
                            ? " "
                            : localisationRamassage!,
                        instruction: instructionemetteur.text,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          "Deposit information",
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.blue),
                        ),
                      ),
                      DataTableWidget(
                        name: namerecepteur.text,
                        email: emailrecepteur.text,
                        contact: contactrecepteur.text,
                        civility: civiliterecepteur == null
                            ? " "
                            : civiliterecepteur!,
                        localisation: localisationrecepteur == null
                            ? " "
                            : localisationrecepteur!,
                        instruction: instructionrecepteur.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: Text('Recapitulatif'),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ];

  Widget buildCompleted(BuildContext ctx) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Center(
                  child: Lottie.asset(
                      'assets/images/delivery/lotties/regis.json',
                      fit: BoxFit.cover)),
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Do you want to save your request?',
                  style: GoogleFonts.poppins(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(5),
                      primary: blue_button,
                      textStyle: GoogleFonts.poppins(fontSize: 18),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            'Confirm',
                            style: GoogleFonts.poppins(),
                          ),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      var one = addAdressRamassage(ctx);
                      var two = addAdressLivraison(ctx);
                      var three = addAdress(ctx);
                      var fourth = addCommande(ctx);

                      if (one == null ||
                          two == null ||
                          three == null ||
                          fourth == null) {
                        Fluttertoast.showToast(
                          msg: "Value is null",
                        );
                      } else {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return PaiementPage(
                                ad: three,
                                adL: two,
                                adR: one,
                                com: fourth,
                              );
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              //Premiere animation de bas en haut
                              var begin = const Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var tween = Tween(begin: begin, end: end);
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: GoogleFonts.poppins(fontSize: 18),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: red_button),
                    ),
                    onPressed: () => setState(() {
                      isCompleted = false;
                      currentStep = 0;
                      /*email.clear();
                      numero.clear();*/
                    }),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 150),
          bas(),
        ],
      ),
    );
  }
}
/**Step(
          state: currentStep > 6 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 6,
          title: const Text(''),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                containFirst(
                    imagePath: 'assets/images/delivery/svg/paiement.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Paiements ',
                          style: GoogleFonts.poppins(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              print('Orange Money');
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(h1),
                                  child: Card(
                                    elevation: 4,
                                    child: Image.asset(
                                      "assets/images/image2.png",
                                      height: 110,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    "Orange money",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: blue_button),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print('Mobile Money');
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(h2),
                                  child: Card(
                                    elevation: 4,
                                    child: Image.asset(
                                      "assets/images/image3.jpg",
                                      height: 110,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    "Mobile Money",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: blue_button),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            print('PayPal money');
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(h3),
                                child: Card(
                                  elevation: 4,
                                  child: Image.asset(
                                    "assets/images/image1.png",
                                    height: 110,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  "Paypal Money",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: blue_button),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ), */