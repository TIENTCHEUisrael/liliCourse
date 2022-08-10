import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CoursierPreferenced {
  static saveCoursierToSharePreferences(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('currentCoursier', jsonEncode(data));
  }

  static removeUserToSharePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("currentCoursier");
  }
}
