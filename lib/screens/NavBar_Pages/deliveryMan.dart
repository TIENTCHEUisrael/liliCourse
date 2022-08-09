import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/widgets/appBar.dart';

import '../../models/coursier/coursier.dart';
import '../../models/coursier/coursierApi.dart';

class DeliveryMan extends StatefulWidget {
  const DeliveryMan({Key? key}) : super(key: key);

  @override
  State<DeliveryMan> createState() => _DeliveryManState();
}

class _DeliveryManState extends State<DeliveryMan> {
  List<Coursier>? _coursiers;
  bool _isLoading = true;
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
      appBar: buildAppBar(
        context,
        Text(
          'Delivery Man',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      body: Container(),
    );
  }
}
