import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AdressPreferences {
  static saveAdressToSharePreferences(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('currentAdress', jsonEncode(data));
  }

  static removeAdressToSharePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("currentAdress");
  }
}
