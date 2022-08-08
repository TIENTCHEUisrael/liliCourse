import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lilicourse/models/coursier/coursierPreference.dart';

import '../models/coursier/coursier.dart';
import '../services/service.dart';

enum Statut {
  getting,
  getted,
  notget,
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

class CoursProvider extends ChangeNotifier {
  Coursier? _coursier;
  int? _id;
  Statut _registerStatus = Statut.notregisted;
  Statut _deleteStatus = Statut.notdeleted;
  Statut _updateStatus = Statut.notupdated;
  Statut _getStatus = Statut.notget;

  Coursier get coursier {
    return _coursier!;
  }

  int get id {
    return _id!;
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

  Statut get getStatut => _getStatus;
  set getStatut(Statut value) {
    _getStatus = value;
  }

  static Future<List<Coursier>> getCoursiers() async {
    var url = Uri.parse('${Api_services.httpbaseUrl3}/lilicourse/coursiers');
    final response = await http.get(url);

    var data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data) {
      _temp.add(i);
    }
    return Coursier.recipesFromSnapshot(_temp);
  }

  Future<Map<String, dynamic>> getCoursier(int id) async {
    var result;
    var urlget = Uri.parse('$Api_services.baseUrl3/lilicourse/coursier?id=$id');
    try {
      _getStatus = Statut.getting;
      notifyListeners();
      final responseget = await http.get(urlget);
      if (responseget.statusCode == 200) {
        _getStatus = Statut.getted;
        notifyListeners();

        var data = jsonDecode(responseget.body);
        CoursierPreferenced.saveCoursierToSharePreferences(data);
        notifyListeners();
        print('$data.......................................');

        _coursier = Coursier.fromJson(data);
        notifyListeners();

        result = {
          "statut": true,
          "message": "Coursier getted",
          "coursier": _coursier!
        };
      } else {
        _getStatus = Statut.notget;
        notifyListeners();
        result = {
          "statut": false,
          "message": "Coursier not getted",
          "coursier": _coursier!
        };
      }
    } catch (e) {
      print('error');
    }
    return result;
  }

  Future<Map<String, dynamic>> deleteCoursier(int id) async {
    var result;
    var urldel = Uri.parse('$Api_services.baseUrl3/lilicourse/coursier?id=$id');
    try {
      _getStatus = Statut.deleting;
      notifyListeners();
      final responsedel = await http.delete(urldel);
      if (responsedel.statusCode == 200) {
        _getStatus = Statut.deleted;
        CoursierPreferenced.removeUserToSharePreference();
        notifyListeners();

        var data = jsonDecode(responsedel.body);

        print('$data.......................................');

        result = {
          "statut": true,
          "message": "Coursier deleted",
          "coursier": data["message"]
        };
      } else {
        _getStatus = Statut.notdeleted;
        notifyListeners();
        result = {"statut": false, "message": "Coursier not getted"};
      }
    } catch (e) {
      print('error');
    }
    return result;
  }
}
