import 'dart:convert';
import 'package:lilicourse/models/adresse/AdresseRamassage/AdresseRamassage.dart';

import '../../../services/service.dart';
import 'package:http/http.dart' as http;

class AdressRamApi {
  static Future<List<AdressRam>> getAdressRam() async {
    var url = Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/adressRam');
    final response = await http.get(url);
    var data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data) {
      _temp.add(i);
    }
    print('successfully.............................');
    return AdressRam.adressRamFromSnapshot(_temp);
  }
}
