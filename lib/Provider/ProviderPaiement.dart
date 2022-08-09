import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lilicourse/models/paiement/Paiement.dart';
import '../services/service.dart';

enum Statut {
  registing,
  registed,
  notregisted,
}

class PaiementProvider extends ChangeNotifier {
  Paiement? _paiement;
  int? _id;
  String? _name;
  Statut _registerStatus = Statut.notregisted;

  Paiement get paiement {
    return _paiement!;
  }

  int get id {
    return _id!;
  }

  String get name {
    return _name!;
  }

  void setpaiement(Paiement paiement) {
    paiement = _paiement!;
    notifyListeners();
  }

  Statut get registerStatus => _registerStatus;
  set registerStatus(Statut value) {
    _registerStatus = value;
  }

  Future<Map<String, dynamic>> createPaiement(Paiement paie) async {
    var result;
    var ulrcreate =
        Uri.parse('${Api_services.baseUrl3}/lilicourse/paiement/add');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _registerStatus = Statut.registing;
      notifyListeners();
      final response = await http.post(
        ulrcreate,
        headers: header,
        body: json.encode(
          paie.toJson(),
        ),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('$data ..............................');
        _paiement = Paiement.fromJson(data);
        _id = data['paiement_id'];
        notifyListeners();
        result = {
          "statut": true,
          'message': "Paiement Added",
          "AdressLiv": _paiement!
        };
      } else {
        result = {"statut": false, 'message': "Paiement error"};
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<Map<String, dynamic>> PaiementMtn(Paiement paie) async {
    var result;
    var urlpaie = Uri.parse(
        '${Api_services.httpbaseUrl3}/lilicourse/paiementMtn?phone=${_paiement!.phone}&&somme=${_paiement!.montant}');
    try {
      _registerStatus = Statut.registing;
      notifyListeners();
      final response = await http.post(urlpaie);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('$data ..............................');
        notifyListeners();
        result = {"statut": true, 'message': "Paiement confirm", "data": data};
      } else {
        result = {"statut": false, 'message': "Paiement error"};
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<Map<String, dynamic>> PaiementPaypal(Paiement paie) async {
    var result;
    var urlpaie = Uri.parse(
        '${Api_services.httpbaseUrl3}/lilicourse/paiementPaypal?phone=${_paiement!.phone}&&somme=${_paiement!.montant}');
    try {
      _registerStatus = Statut.registing;
      notifyListeners();
      final response = await http.post(urlpaie);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('$data ..............................');
        notifyListeners();
        result = {
          "statut": true,
          'message': "Paiement Paypal confirm",
          "data": data
        };
      } else {
        result = {"statut": false, 'message': "Paiement error"};
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<Map<String, dynamic>> PaiementOrange(Paiement paie) async {
    var result;
    var urlpaie = Uri.parse(
        '${Api_services.httpbaseUrl3}/lilicourse/paiementOrange?phone=${_paiement!.phone}&&somme=${_paiement!.montant}');
    try {
      _registerStatus = Statut.registing;
      notifyListeners();
      final response = await http.post(urlpaie);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('$data ..............................');
        notifyListeners();
        result = {
          "statut": true,
          'message': "Paiement Orange confirm",
          "data": data
        };
      } else {
        result = {"statut": false, 'message': "Paiement error"};
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
