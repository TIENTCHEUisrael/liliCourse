import 'package:flutter/material.dart';

class RequestEnCour extends StatefulWidget {
  const RequestEnCour({Key? key}) : super(key: key);

  @override
  State<RequestEnCour> createState() => _RequestEnCourState();
}

class _RequestEnCourState extends State<RequestEnCour> {
  void getPaiement() async {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Column(children: [card()]),
        );
      }),
    );
  }

  Widget card() {
    return InkWell(
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(),
        ),
      ),
    );
  }
}
