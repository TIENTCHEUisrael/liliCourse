import 'dart:convert';
import 'package:lilicourse/models/commande/commande.dart';

import '../../../services/service.dart';
import 'package:http/http.dart' as http;

class CommandeApi {
  static Future<List<Commande>> getcommandes() async {
    var url = Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/commandes');
    final response = await http.get(url);
    var data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data) {
      _temp.add(i);
    }
    print('successfully.............................');
    return Commande.recipesFromSnapshot(_temp);
  }
}
