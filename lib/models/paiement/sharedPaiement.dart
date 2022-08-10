import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PaiementPreference {
  static savePaiementToSharePreferences(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('currentPaiement', jsonEncode(data));
  }

  static removePaiementToSharePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("currentPaiement");
  }
}
