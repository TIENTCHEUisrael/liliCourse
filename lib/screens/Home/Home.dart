import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/models/coursier/coursier.dart';
import 'package:lilicourse/models/coursier/coursierApi.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Provider/ProviderCoursier.dart';
import '../../models/user/user.dart';
import '../../services/service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Coursier>? _coursiers;
  User? user;
  bool _isLoading = true;
  final List<String> images = [
    'assets/images/homes/request.json',
    'assets/images/homes/accepter.json',
    'assets/images/homes/transport.json',
    'assets/images/homes/Attente.json',
    'assets/images/homes/attenteClient.json',
    'assets/images/homes/recuperer.json',
    'assets/images/homes/give.json',
  ];

  @override
  void initState() {
    super.initState();
    getCoursier();
  }

  Future<void> getCoursier() async {
    _coursiers = await CourserApi.getCoursiers();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<CoursProvider>(
          builder: (context, cours, _) {
            return Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Li',
                          style: GoogleFonts.poppins(
                              color: red_button, fontSize: 18),
                        ),
                        Text(
                          'Li',
                          style: GoogleFonts.poppins(
                              color: Colors.blue, fontSize: 18),
                        ),
                        Text(
                          'Course',
                          style: GoogleFonts.poppins(
                              color: blue_button, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'App',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(5),
                    height: 300,
                    width: double.infinity,
                    child: CarouselSlider(
                      items: images
                          .map(
                            (e) => Container(
                              child: Lottie.asset(e,
                                  height: 250, width: double.infinity),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(autoPlay: true, height: 250),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Yours Deliveries man',
                          style: GoogleFonts.poppins(
                              fontSize: 20, color: blue_button),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 3),
                          height: 180,
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        print(
                                            '${_coursiers![index].first_name}');
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return ShowDialogueFunc(
                                                nom: _coursiers![index]
                                                    .first_name,
                                                prenom: _coursiers![index]
                                                    .last_name,
                                                phone: _coursiers![index]
                                                    .phone_number,
                                                email: _coursiers![index].email,
                                                image:
                                                    _coursiers![index].image!,
                                                vehicule: _coursiers![index]
                                                    .transport,
                                                start:
                                                    _coursiers![index].rating,
                                                occupation: _coursiers![index]
                                                    .occupation);
                                          },
                                        );
                                      },
                                      child: buildCard(
                                        image: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              '${Api_services.imageUrlCoursier2}/${_coursiers![index].image}'),
                                        ),
                                        name: _coursiers![index].first_name,
                                        contact: _coursiers![index]
                                            .phone_number
                                            .toString(),
                                        /*note: double.parse(
                                            _coursiers![index].rating),*/
                                      ),
                                    );
                                  },
                                  separatorBuilder: (_, __) {
                                    return const Divider();
                                  },
                                  itemCount: _coursiers!.length),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            'Yours Actions',
                            style: GoogleFonts.poppins(
                                fontSize: 19, color: blue_button),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: null,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (() {
                                  print('sqdsd');
                                }),
                                child: const Card(
                                  elevation: 1,
                                  child: ListTile(
                                    title: Text('Yours Orders'),
                                    subtitle: Text(
                                        "It's the same order to register for system"),
                                    leading: Icon(
                                      Icons.library_books,
                                      color: red_button,
                                      size: 35,
                                    ),
                                    trailing: Icon(Icons.arrow_right),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (() {
                                  print('sdfsdf');
                                }),
                                child: const Card(
                                  elevation: 1,
                                  child: ListTile(
                                    title: Text('Yours Request'),
                                    subtitle: Text(
                                        "It's the same request when you ask"),
                                    leading: Icon(
                                      Icons.request_page_outlined,
                                      color: red_button,
                                      size: 35,
                                    ),
                                    trailing: Icon(Icons.arrow_right),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'We love you',
                                  style: GoogleFonts.cagliostro(
                                      fontSize: 35, color: blue_button),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

buildCard(
    {required Image image, required String name, required String contact}) {
  return Card(
    child: Container(
      padding: null,
      width: 100,
      child: Column(
        children: [
          Hero(
            tag: 'CoursImage',
            child: ClipOval(
              child: Container(
                padding: null,
                height: 110,
                child: image,
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            name,
            style: GoogleFonts.poppins(fontSize: 15),
          ),
          Text(
            contact,
            style: GoogleFonts.poppins(fontSize: 13),
          ),
          /*RatingBar.builder(
            initialRating: note,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 15.0,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),*/
        ],
      ),
    ),
  );
}

Widget ShowDialogueFunc(
    {required String nom,
    required String prenom,
    required int phone,
    required String email,
    required String image,
    required String vehicule,
    required String start,
    required String occupation}) {
  return DraggableScrollableSheet(
    initialChildSize: 0.7,
    builder: (_, controller) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: ListView(
          controller: controller,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Container(
                    height: 160,
                    width: 160,
                    padding: null,
                    child: ClipOval(
                      child: Image(
                        image: NetworkImage(
                            '${Api_services.imageUrlCoursier2}/$image'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      'Delivery Man Information',
                      style:
                          GoogleFonts.arimo(fontSize: 22, color: blue_button),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.info,
                            color: blue_button,
                            size: 35,
                          ),
                          title: Text(
                            'Name',
                            style: GoogleFonts.poppins(color: Colors.blue[800]),
                          ),
                          subtitle: Text(
                            '$nom',
                            style: GoogleFonts.arimo(fontSize: 15),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.info,
                            color: blue_button,
                            size: 35,
                          ),
                          title: Text(
                            'Last Name',
                            style: GoogleFonts.poppins(color: Colors.blue[800]),
                          ),
                          subtitle: Text(
                            '$prenom',
                            style: GoogleFonts.arimo(fontSize: 15),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.phone,
                            color: blue_button,
                            size: 35,
                          ),
                          title: Text(
                            'Number',
                            style: GoogleFonts.poppins(color: Colors.blue[800]),
                          ),
                          subtitle: Text(
                            '$phone',
                            style: GoogleFonts.arimo(fontSize: 15),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.email,
                            color: blue_button,
                            size: 35,
                          ),
                          title: Text(
                            'Email',
                            style: GoogleFonts.poppins(color: Colors.blue[800]),
                          ),
                          subtitle: Text(
                            '$email',
                            style: GoogleFonts.arimo(fontSize: 15),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.car_crash,
                            color: blue_button,
                            size: 35,
                          ),
                          title: Text(
                            'Vehicule',
                            style: GoogleFonts.poppins(color: Colors.blue[800]),
                          ),
                          subtitle: Text(
                            '$vehicule',
                            style: GoogleFonts.arimo(fontSize: 15),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.star,
                            color: blue_button,
                            size: 35,
                          ),
                          title: Text(
                            'Notes',
                            style: GoogleFonts.poppins(color: Colors.blue[800]),
                          ),
                          subtitle: Text('$start star(s)'),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.dashboard,
                            color: blue_button,
                            size: 35,
                          ),
                          title: Text(
                            'Statut',
                            style: GoogleFonts.poppins(color: Colors.blue[800]),
                          ),
                          subtitle: occupation == 'true'
                              ? Text(
                                  'Occupé',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: red_button),
                                )
                              : Text(
                                  'Libre',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.green),
                                ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.info,
                            color: blue_button,
                            size: 35,
                          ),
                          title: Text(
                            'Request',
                            style: GoogleFonts.poppins(color: Colors.blue[800]),
                          ),
                          subtitle: const Text('request'),
                          trailing: const Icon(Icons.arrow_right),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
