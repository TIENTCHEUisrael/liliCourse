import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lilicourse/models/commande/commande.dart';

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

class CommProvider extends ChangeNotifier {
  Commande? _commande;
  int? _id;
  String? _name;
  Statut _registerStatus = Statut.notregisted;
  Statut _deleteStatus = Statut.notdeleted;
  Statut _updateStatus = Statut.notupdated;

  Commande get commande {
    return _commande!;
  }

  int get id {
    return _id!;
  }

  String get name {
    return _name!;
  }

  void setCommande(Commande co) {
    co = _commande!;
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

  Future<Map<String, dynamic>> createAdress(Commande com) async {
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
          com.toJson(),
        ),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('$data.......................');
        _registerStatus = Statut.registed;
        _commande = Commande.fromJson(data);
        notifyListeners();

        result = {
          "statut": true,
          "message": "Commande added",
          "commande": _commande!
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

  Future<Map<String, dynamic>> updateAdress(Commande com) async {
    var result;
    var urlput = Uri.parse(
        '${Api_services.httpbaseUrl2}/lilicourse/adress/put?id=${com.commandeId}');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _registerStatus = Statut.updating;
      notifyListeners();

      final response = await http.put(
        urlput,
        headers: header,
        body: jsonEncode(
          com.toJson(),
        ),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('$data.......................');
        _registerStatus = Statut.updated;
        _commande = Commande.fromJson(data);
        notifyListeners();

        result = {
          "statut": true,
          "message": "Commande updated",
          "commande": _commande!
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
