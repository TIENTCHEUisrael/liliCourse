import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lilicourse/models/adresse/Adresse/Adresse.dart';
import 'package:lilicourse/services/service.dart';

import '../models/adresse/Adresse/sharedAdress.dart';

enum Statut {
  registing,
  registed,
  notregisted,
  updating,
  updated,
  notupdated,
  deleting,
  deleted,
  notdeleted,
}

class AdProvider extends ChangeNotifier {
  Adresse? _adresse;
  int? _id;
  String? _name;
  Statut _registerStatus = Statut.notregisted;
  Statut _deleteStatus = Statut.notdeleted;
  Statut _updateStatus = Statut.notupdated;

  Adresse get adresse {
    return _adresse!;
  }

  int get id {
    return _id!;
  }

  String get name {
    return _name!;
  }

  void setAdress(Adresse ad) {
    ad = _adresse!;
    notifyListeners();
  }

  Statut get registerStatus => _registerStatus;
  set registerStatus(Statut value) {
    _registerStatus = value;
  }

  Statut get deleteStatus => _deleteStatus;
  set deleteStatus(Statut value) {
    _deleteStatus = value;
  }

  Statut get updateStatus => _updateStatus;
  set updateStatus(Statut value) {
    _updateStatus = value;
  }

  Future<Map<String, dynamic>?> createAdresse(Adresse us) async {
    var result;
    var urlCreate =
        Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/adress/add');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _registerStatus = Statut.registing;
      notifyListeners();
      final reponse = await http.post(
        urlCreate,
        headers: header,
        body: json.encode(
          us.toJson(),
        ),
      );
      if (reponse.statusCode == 200) {
        _registerStatus = Statut.registed;
        notifyListeners();
        var data = jsonDecode(reponse.body);
        AdressPreferences.saveAdressToSharePreferences(data);
        _adresse = Adresse.fromJson(data);

        //UserPreferences().saveUser(_user!);
        notifyListeners();
        result = {
          "statut": true,
          "message": "Adress is registed",
          "adress": _adresse!
        };
      } else {
        _registerStatus = Statut.notregisted;
        notifyListeners();
        result = {"statut": false, "message": "User is not registed"};
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<Map<String, dynamic>> updateAdress(Adresse ad) async {
    var result;
    var urlput = Uri.parse(
        '${Api_services.httpbaseUrl2}/lilicourse/adress/put?id=${ad.adressId}');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _registerStatus = Statut.updating;
      notifyListeners();

      final response = await http.put(
        urlput,
        headers: header,
        body: jsonEncode(
          ad.toJson(),
        ),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('$data.......................');
        _registerStatus = Statut.updated;
        AdressPreferences.saveAdressToSharePreferences(data);
        _adresse = Adresse.fromJson(data);
        notifyListeners();

        result = {
          "statut": true,
          "message": "Adress updated",
          "adresse": _adresse!
        };
      } else {
        _registerStatus = Statut.notupdated;
        notifyListeners();
        result = {"statut": false, "message": "Adress not updated"};
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
