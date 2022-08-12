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
        return Container(
          child: Center(
            child: Text('ZEZE'),
          ),
        );
      }),
    );
  }
}
