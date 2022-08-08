//import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/main.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                      style:
                          GoogleFonts.poppins(color: red_button, fontSize: 18),
                    ),
                    Text(
                      'Li',
                      style:
                          GoogleFonts.poppins(color: Colors.blue, fontSize: 18),
                    ),
                    Text(
                      'Course',
                      style:
                          GoogleFonts.poppins(color: blue_button, fontSize: 18),
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
                      style:
                          GoogleFonts.poppins(fontSize: 20, color: blue_button),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 3),
                      height: 180,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, builder) {
                            return buildCard(
                                image: 'assets/images/israel.jpeg',
                                name: 'name',
                                contact: 'contact',
                                note: 2);
                          },
                          separatorBuilder: (_, __) {
                            return const Divider();
                          },
                          itemCount: 10),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

buildCard(
    {required String image,
    required String name,
    required String contact,
    required double note}) {
  return GestureDetector(
    onTap: (() => print('dsqd')),
    child: Card(
      child: Container(
        padding: null,
        width: 100,
        child: Column(
          children: [
            ClipOval(
              child: Image.asset(
                image,
                height: 80,
                fit: BoxFit.cover,
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
            RatingBar.builder(
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
            ),
          ],
        ),
      ),
    ),
  );
}
