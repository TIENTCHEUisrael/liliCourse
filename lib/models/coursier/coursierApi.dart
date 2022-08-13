import 'dart:convert';
import '../../services/service.dart';
import 'package:http/http.dart' as http;
import 'coursier.dart';

class CourserApi {
  static Future<List<Coursier>> getCoursiers() async {
    var url = Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/coursiers');
    final response = await http.get(url);
    var data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data) {
      _temp.add(i);
    }
    return Coursier.recipesFromSnapshot(_temp);
  }
}
