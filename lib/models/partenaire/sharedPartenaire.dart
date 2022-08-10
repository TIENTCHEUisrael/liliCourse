import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PartenairePreference {
  static savePartenaireToSharePreferences(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('currentPartenaire', jsonEncode(data));
  }

  static removePartenaireToSharePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("currentPartenaire");
  }
}
