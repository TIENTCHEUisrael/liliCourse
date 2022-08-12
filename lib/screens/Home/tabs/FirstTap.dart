import 'package:flutter/material.dart';

class RequestTermine extends StatefulWidget {
  const RequestTermine({Key? key}) : super(key: key);

  @override
  State<RequestTermine> createState() => _RequestTermineState();
}

class _RequestTermineState extends State<RequestTermine> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: ((context, index) {
        return Container(
          child: Center(
            child: Text('EEEE'),
          ),
        );
      }),
    );
  }
}
