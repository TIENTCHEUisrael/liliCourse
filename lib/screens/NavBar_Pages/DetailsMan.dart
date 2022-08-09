import 'package:flutter/material.dart';
import '../../models/coursier/coursier.dart';

class DetailsMan extends StatefulWidget {
  final Coursier currentCoursier;
  DetailsMan({required this.currentCoursier});

  @override
  State<DetailsMan> createState() => _DetailsManState();
}

class _DetailsManState extends State<DetailsMan> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(child: Text('${widget.currentCoursier.first_name}')));
  }
}
