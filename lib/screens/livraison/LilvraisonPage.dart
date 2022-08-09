import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/screens/livraison/Page1.dart';
import 'package:lilicourse/widgets/appBar.dart';
import '../../models/user/user.dart';
import '../../widgets/appBar.dart';

class LivraisonPage extends StatelessWidget {
  final User user;
  const LivraisonPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        Text(
          'Demander une Livraison',
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 15),
        ),
      ),
      body: const Page1(),
    );
  }
}
