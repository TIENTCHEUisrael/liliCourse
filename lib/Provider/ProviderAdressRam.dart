import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lilicourse/models/adresse/AdresseRamassage/AdresseRamassage.dart';
import 'package:lilicourse/models/adresse/AdresseRamassage/sharedAdressR.dart';

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

class AdRProvider extends ChangeNotifier {
  AdressRam? _adressRam;
  int? _id;
  String? _name;
  Statut _registerStatus = Statut.notregisted;
  Statut _deleteStatus = Statut.notdeleted;
  Statut _updateStatus = Statut.notupdated;

  AdressRam get adressRam {
    return _adressRam!;
  }

  int get id {
    return _id!;
  }

  String get name {
    return _name!;
  }

  void setAdressRam(AdressRam adr) {
    adr = _adressRam!;
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

  Future<Map<String, dynamic>?> getAdressRamById(int id) async {
    var result;
    var urlAdressRam =
        Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/adressRamId?id=$id');

    try {
      final response = await http.get(urlAdressRam);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        _adressRam = AdressRam.fromJson(data);
        notifyListeners();

        result = {
          "statut": true,
          "message": "Adress Ram getted",
          "adressRam": _adressRam
        };
      } else {
        result = {"statut": false, "message": "Adress Ram not getted"};
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<Map<String, dynamic>?> createAdressRam(AdressRam us) async {
    var result;
    var urlCreate =
        Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/adressRam/add');
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
        AdressRamassagePreferences.saveAdressRamassageToSharePreferences(data);
        _adressRam = AdressRam.fromJson(data);

        //UserPreferences().saveUser(_user!);
        notifyListeners();
        result = {
          "statut": true,
          "message": "AdressRam is registed",
          "adressRam": _adressRam!
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

  Future<Map<String, dynamic>> updateAdressRam(AdressRam adressRa) async {
    var result;
    var ulrput = Uri.parse(
        '${Api_services.httpbaseUrl2}/lilicourse/adressLiv/put?id=${adressRa.adressRamId}');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _updateStatus = Statut.updating;
      notifyListeners();
      final responseput = await http.put(
        ulrput,
        headers: header,
        body: jsonEncode(
          adressRa.toJson(),
        ),
      );
      if (responseput.statusCode == 200) {
        var data = jsonDecode(responseput.body);
        print('$data .....................................;');
        _updateStatus = Statut.updated;
        _id = data['adresse_ram_id'];
        _adressRam = AdressRam.fromJson(data);
        AdressRamassagePreferences.saveAdressRamassageToSharePreferences(data);
        notifyListeners();

        result = {
          "statut": true,
          "message": "Adress updated",
          "adressRam": _adressRam!
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
