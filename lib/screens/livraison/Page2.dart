import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/main.dart';
import '../../Animations/DelayedAnimation.dart';
import '../../widgets/appBar.dart';
import '../../widgets/containFirst.dart';
import 'PageMap.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int currentStep = 0;
  Color? colorIn = Colors.transparent;
  Color? colorOut = Colors.transparent;

  int _value = 1;
  int _value2 = 1;
  int _value3 = 1;
  bool isCompleted = false;

  String? type;
  String? taille;
  double? poids;

  String? localisationrecepteur;
  String? namerecepteur;
  int? contactrecepteur;
  String? emailrecepteur;
  String? civiliterecepteur;
  String? planification;

  String? localisationlivrable;
  String? namelivrable;
  int? contactlivrable;
  String? emaillivrable;
  String? civilitelivrable;
  String? instructionlivrable;

  final email = TextEditingController();
  final numero = TextEditingController();
  final mot = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void addAdresse() {}
  void addAdressLivraison() {}
  void addAdressRamassage() {}

  void AddCommange() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        Text('Delivery Page', style: GoogleFonts.poppins(color: Colors.black)),
      ),
      body: isCompleted
          ? buildCompleted()
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
                    imagePath: 'assets/images/delivery/svg/delivery.svg',
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
                                  type = "All type of Object";
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
                                      'All type of Object',
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
                    imagePath: 'assets/images/delivery/svg/delivery.svg',
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
                          GestureDetector(
                              onTap: () {
                                print('Ok1');
                              },
                              child: Carte3(text2: '+0', text1: '0-3')),
                          GestureDetector(
                              onTap: () {
                                print('ok2');
                              },
                              child: Carte3(text1: '4-7', text2: '+1000')),
                          GestureDetector(
                              onTap: () {
                                print('ok2');
                              },
                              child: Carte3(text1: '8-10', text2: '+3000')),
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
                    imagePath: 'assets/images/delivery/svg/delivery.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Details du ramassage',
                          style: GoogleFonts.poppins(fontSize: 15),
                          textAlign: TextAlign.center,
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
                    imagePath: 'assets/images/delivery/svg/delivery.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 8,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Details du ramassage',
                            style: GoogleFonts.poppins(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
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
                    imagePath: 'assets/images/delivery/svg/delivery.svg',
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
                          'Details du recepteur',
                          style: GoogleFonts.poppins(fontSize: 15),
                          textAlign: TextAlign.center,
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
          state: currentStep > 5 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 5,
          title: const Text(''),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                containFirst(
                    imagePath: 'assets/images/delivery/svg/delivery.svg',
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
                            'Planification de ramassage du colis',
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
                                    setState(() {
                                      _value = value as int;
                                    });
                                  },
                                ),
                                Text(
                                  'Aussitot que possible',
                                  style: GoogleFonts.poppins(fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 2,
                                    groupValue: _value,
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value as int;
                                      });
                                    }),
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
                                Text(
                                  '2h:00',
                                  style: GoogleFonts.poppins(fontSize: 15),
                                ),
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
                                Text(
                                  '30 min',
                                  style: GoogleFonts.poppins(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 6 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 6,
          title: const Text(''),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                containFirst(
                    imagePath: 'assets/images/delivery/svg/delivery.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Paiyments ',
                          style: GoogleFonts.poppins(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('Ok1');
                            },
                            child: Carte2(
                                titre: 'Orange Money',
                                imagePath: 'assets/images/image2.png',
                                height: 120,
                                width: 115),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('ok2');
                            },
                            child: Carte2(
                                titre: 'Mobile Money',
                                imagePath: 'assets/images/image3.jpg',
                                height: 120,
                                width: 115),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Carte2(
                            titre: 'Paypal',
                            imagePath: 'assets/images/image1.png',
                            height: 120,
                            width: 115),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ];

  Widget buildCompleted() {
    return SingleChildScrollView(
      child: Column(
        children: [
          containFirst(
              imagePath: 'assets/images/delivery/svg/delivery.svg',
              text: 'Demander une livraison'),
          Card(
            elevation: 5,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Recapitulatif',
                    style: GoogleFonts.poppins(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: blue_button,
                          textStyle: GoogleFonts.poppins(fontSize: 18),
                        ),
                        child: Text(
                          'Confirm',
                          style: GoogleFonts.poppins(),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return const TimeWaiting();
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
                        }),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        textStyle: GoogleFonts.poppins(fontSize: 18),
                      ),
                      child: const Text('Reset'),
                      onPressed: () => setState(() {
                        isCompleted = false;
                        currentStep = 0;
                        email.clear();
                        numero.clear();
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget Carte({
  required String titre,
  required Icon icon,
  required Color colors,
}) {
  return Column(
    children: [
      Card(
        elevation: 4,
        child: icon,
      ),
      Container(
        decoration: BoxDecoration(border: Border.all(color: colors)),
        padding: const EdgeInsets.all(15),
        child: Text(
          titre,
          style: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.bold, color: blue_button),
        ),
      ),
    ],
  );
}

Widget Carte2({
  required String titre,
  required String imagePath,
  required double height,
  required double width,
}) {
  return Column(
    children: [
      Card(
        elevation: 4,
        child: Image.asset(
          imagePath,
          height: height,
          width: width,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          titre,
          style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.bold, color: blue_button),
        ),
      ),
    ],
  );
}

Widget Carte3({
  required String text1,
  required String text2,
}) {
  return Card(
    elevation: 4,
    child: Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            '$text1 KG',
            style: GoogleFonts.poppins(color: blue_button),
            textAlign: TextAlign.center,
          ),
          Text(
            '$text2 XAF',
            style: GoogleFonts.poppins(color: blue_button),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
