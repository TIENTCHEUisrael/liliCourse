import 'dart:convert';

import 'package:lilicourse/models/adresse/AdresseLivraison/AdresseLivraison.dart';
import 'package:http/http.dart' as http;
import '../../../services/service.dart';

class AdressLivApi {
  static Future<List<AdressLiv>> getAdressLiv() async {
    var url = Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/adressLiv');
    final response = await http.get(url);
    var data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data) {
      _temp.add(i);
    }
    print('successfully.............................');
    return AdressLiv.adressLivFromSnapshot(_temp);
  }
}
