import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AdressLivraisonPreferences {
  static saveAdressLivraisonToSharePreferences(
      Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('currentAdressLivraison', jsonEncode(data));
  }

  static removeAdressLivraisonToSharePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("currentAdressLivraison");
  }
}
