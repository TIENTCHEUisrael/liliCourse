import 'dart:convert';
import 'package:lilicourse/models/paiement/Paiement.dart';
import 'package:http/http.dart' as http;
import '../../services/service.dart';

class PaiementApi {
  static Future<List<Paiement>> getPaiement() async {
    var url = Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/paiements');
    final response = await http.get(url);
    var data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data) {
      _temp.add(i);
    }
    print('successfully.............................');
    return Paiement.paiementFromSnapshot(_temp);
  }
}
