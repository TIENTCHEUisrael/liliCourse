import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lilicourse/models/adresse/AdresseLivraison/AdresseLivraison.dart';

import '../services/location_service.dart';
import '../services/service.dart';

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

class AdLProvider extends ChangeNotifier {
  AdressLiv? _adressLiv;
  int? _id;
  String? _name;
  Statut _registerStatus = Statut.notregisted;
  Statut _deleteStatus = Statut.notdeleted;
  Statut _updateStatus = Statut.notupdated;

  AdressLiv get adressLiv {
    return _adressLiv!;
  }

  int get id {
    return _id!;
  }

  String get name {
    return _name!;
  }

  void setAdressLiv(AdressLiv adl) {
    adl = _adressLiv!;
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

  Future<String> getPlaceAdress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    var obj = json.decode(response.body)['results'][0]['formatted_address'];
    return obj;
  }

  Future<Map<String, dynamic>> createAdresseLiv(AdressLiv adressLi) async {
    var result;
    var ulrcreate =
        Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/adressLiv/add');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _registerStatus = Statut.registing;
      notifyListeners();
      final response = await http.post(
        ulrcreate,
        headers: header,
        body: json.encode(
          adressLi.toJson(),
        ),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('$data ..............................');
        _adressLiv = AdressLiv.fromJson(data);
        _id = data['adresse_liv_id'];
        _registerStatus = Statut.registed;
        notifyListeners();
        result = {
          "statut": true,
          'message': "Adress Livraison Added",
          "adressLiv": _adressLiv!
        };
      } else {
        result = {"statut": false, 'message': "Adress Livraison error"};
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<Map<String, dynamic>> updateAdressLiv(AdressLiv adressLi) async {
    var result;
    var ulrput = Uri.parse(
        '${Api_services.httpbaseUrl2}/lilicourse/adressLiv/put?id=${adressLi.adressLivId}');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _updateStatus = Statut.updating;
      notifyListeners();
      final responseput = await http.put(
        ulrput,
        headers: header,
        body: jsonEncode(
          adressLi.toJson(),
        ),
      );
      if (responseput.statusCode == 200) {
        var data = jsonDecode(responseput.body);
        print('$data .....................................;');
        _updateStatus = Statut.updated;
        _id = data['adresse_liv_id'];
        _adressLiv = AdressLiv.fromJson(data);
        notifyListeners();

        result = {
          "statut": true,
          "message": "Adress updated",
          "adressLiv": _adressLiv!
        };
      } else {
        _updateStatus = Statut.notupdated;
        result = {'statut': false, 'message': 'Error updating'};
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
