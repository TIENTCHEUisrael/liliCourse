import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/main.dart';
import '../../Animations/DelayedAnimation.dart';
import '../../widgets/appBar.dart';
import 'PageMap.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int currentStep = 0;
  int _value = 1;
  int _value2 = 1;
  int _value3 = 1;
  bool isCompleted = false;

  final email = TextEditingController();
  final numero = TextEditingController();
  final mot = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        Text('DeliveryPage', style: GoogleFonts.poppins()),
      ),
      body: isCompleted
          ? buildCompleted()
          : Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: blue_button),
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
                      margin: const EdgeInsets.only(top: 50),
                      child: Row(
                        children: [
                          Expanded(
                            child: DelayedAnimation(
                              delay: 150,
                              child: ElevatedButton(
                                child:
                                    Text('Next', style: GoogleFonts.poppins()),
                                onPressed: details.onStepContinue,
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
                                  child: Text('Cancel'),
                                  onPressed: details.onStepCancel,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }
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
                    imagePath: 'assets/image/delivery/svg/delivery.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 5,
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
                          GestureDetector(
                            onTap: () {
                              print('Ok1');
                            },
                            child: Carte(
                              titre: 'Tout type d\'Object',
                              icon: const Icon(
                                Icons.collections,
                                size: 90,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('ok2');
                            },
                            child: Carte(
                              titre: 'Courrier',
                              icon: const Icon(
                                Icons.contact_mail_rounded,
                                size: 90,
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
                    imagePath: 'assets/image/delivery/svg/delivery.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Caracteristique de votre Colis?',
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
                    imagePath: 'assets/image/delivery/svg/delivery.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 5,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Lieu de ramassage',
                                style: GoogleFonts.poppins(),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 300,
                          height: 25,
                          decoration: BoxDecoration(
                              border: Border.all(color: blue_button)),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Lieu de depot',
                                style: GoogleFonts.poppins(),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 300,
                          height: 25,
                          decoration: BoxDecoration(
                              border: Border.all(color: blue_button)),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Instruction a donner au coursier',
                                style: GoogleFonts.poppins(),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          width: 300,
                          child: TextField(
                            controller: mot,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            style: GoogleFonts.poppins(color: Colors.grey),
                            maxLines: 5,
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
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const Text(''),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                containFirst(
                    imagePath: 'assets/image/delivery/svg/delivery.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 2,
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
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          controller: numero,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            label: Text(
                              'Numero a contacter',
                              style: GoogleFonts.poppins(),
                            ),
                            prefixIcon: const Icon(
                              Icons.phone,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            label: Text(
                              'Email ',
                              style: GoogleFonts.poppins(),
                            ),
                            prefixIcon: const Icon(
                              Icons.mail,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Civilite ',
                              style: GoogleFonts.poppins(fontSize: 15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: _value2,
                                    onChanged: (value) {
                                      setState(() {
                                        _value2 = value as int;
                                      });
                                    }),
                                const Text('Madame'),
                                Radio(
                                    value: 2,
                                    groupValue: _value2,
                                    onChanged: (value) {
                                      setState(() {
                                        _value2 = value as int;
                                      });
                                    }),
                                const Text('Monsieur'),
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
          state: currentStep > 4 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 4,
          title: const Text(''),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                containFirst(
                    imagePath: 'assets/image/delivery/svg/delivery.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 2,
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
          state: currentStep > 5 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 5,
          title: const Text(''),
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                containFirst(
                    imagePath: 'assets/image/delivery/svg/delivery.svg',
                    text: 'Demander une livraison'),
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Paiyements ',
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
                                imagePath: 'assets/image/image2.png',
                                height: 120,
                                width: 115),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('ok2');
                            },
                            child: Carte2(
                                titre: 'Mobile Money',
                                imagePath: 'assets/image/image3.jpg',
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
                            imagePath: 'assets/image/image1.png',
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
              imagePath: 'assets/image/delivery/svg/delivery.svg',
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

Widget containFirst({
  required String imagePath,
  required String text,
}) {
  return Container(
    child: Column(
      children: [
        Center(
          child: SvgPicture.asset(
            imagePath,
            height: 185,
            width: 140,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget Carte({
  required String titre,
  required Icon icon,
}) {
  return Column(
    children: [
      Card(
        elevation: 4,
        child: icon,
      ),
      Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          titre,
          style: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.bold, color: red_button),
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
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            text1 + ' KG',
            style: GoogleFonts.poppins(color: blue_button),
            textAlign: TextAlign.center,
          ),
          Text(
            text2 + ' XAF',
            style: GoogleFonts.poppins(color: blue_button),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
