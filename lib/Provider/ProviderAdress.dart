import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lilicourse/models/adresse/Adresse/Adresse.dart';
import 'package:lilicourse/services/service.dart';

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

  Future<Map<String, dynamic>> createAdress(Adresse ad) async {
    var result;
    var urlcre =
        Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/adress/add');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _registerStatus = Statut.registing;
      notifyListeners();

      final response = await http.post(
        urlcre,
        headers: header,
        body: jsonEncode(
          ad.toJson(),
        ),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('$data.......................');
        _registerStatus = Statut.registed;
        _adresse = Adresse.fromJson(data);
        notifyListeners();

        result = {
          "statut": true,
          "message": "Adress added",
          "adresse": _adresse!
        };
      } else {
        _registerStatus = Statut.notregisted;
        notifyListeners();
        result = {"statut": false, "message": "Adress not added"};
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
