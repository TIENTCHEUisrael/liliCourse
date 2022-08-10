import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CommandePreference {
  static saveCommandeToSharePreferences(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('currentCommande', jsonEncode(data));
  }

  static removeCommandeToSharePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("currentCommande");
  }
}
