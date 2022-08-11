import 'dart:convert';

import 'package:lilicourse/models/adresse/Adresse/Adresse.dart';
import 'package:http/http.dart' as http;
import '../../../services/service.dart';

class AdressApi {
  static Future<List<Adresse>> getAdress() async {
    var url = Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/adress');
    final response = await http.get(url);
    var data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data) {
      _temp.add(i);
    }
    print('successfully.............................');
    return Adresse.adressFromSnapshot(_temp);
  }
}
