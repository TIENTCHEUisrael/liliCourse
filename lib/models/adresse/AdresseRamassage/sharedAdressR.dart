import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AdressRamassagePreferences {
  static saveAdressRamassageToSharePreferences(
      Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('currentAdressRamassage', jsonEncode(data));
  }

  static removeAdressRamassageToSharePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("currentAdressRamassage");
  }
}
