import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lilicourse/models/user/shared_preferenced.dart';
import '../models/user/user.dart';
import '../services/service.dart';

enum Statut {
  authenticating,
  authenticated,
  notauthenticate,
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

class AuthProvider extends ChangeNotifier {
  String? _token;
  User? _user;
  int? _id;

  Statut _logStatus = Statut.notauthenticate;
  Statut _registerStatus = Statut.notregisted;
  Statut _deleteStatus = Statut.notdeleted;
  Statut _updateStatus = Statut.notupdated;

  String get token {
    return _token!;
  }

  bool? get isAuth {
    return _token != null;
  }

  User get user {
    return _user!;
  }

  int get id {
    return _id!;
  }

  void setUSer(User us) {
    us = _user!;
    notifyListeners();
  }

  void setToken(String tok) {
    tok = _token!;
    notifyListeners();
  }

  Statut get logStatus => _logStatus;
  set logStatus(Statut value) {
    _logStatus = value;
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

  Future<Map<String, dynamic>?> loginUser(String mail, String pass) async {
    var result;
    var urlLogin = Uri.parse(
        '${Api_services.httpbaseUrl3}/lilicourse/user/login?mail=$mail&passw=$pass');

    try {
      _logStatus = Statut.authenticating;
      notifyListeners();
      final response = await http.get(urlLogin);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _user = User.fromJson(data);
        print(_user!);
        UserPreferences().saveUser(_user!);
        notifyListeners();

        var urlToken = Uri.parse(
            '${Api_services.httpbaseUrl3}/lilicourse/user/generate?mail=${_user!.email}');
        final responseToken = await http.post(urlToken);
        if (responseToken.statusCode == 200) {
          var data1 = jsonDecode(responseToken.body);
          _token = data1['token'];
          print(
              '...................................................................;');
          print(_token!);
          _logStatus = Statut.authenticated;
          notifyListeners();
          UserPreferences.saveToken(_token!);
          notifyListeners();

          result = {
            "statut": true,
            "message": "User authenticated",
            "user": _user!
          };
        } else {
          result = {"statut": true, "message": "Error token", "user": _user!};
        }
      } else {
        _logStatus = Statut.notauthenticate;
        notifyListeners();
        result = {
          "statut": false,
          "message": "User not authenticated",
          "user": _user!
        };
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<Map<String, dynamic>?> createUser(User us) async {
    var result;
    var urlCreate =
        Uri.parse('${Api_services.httpbaseUrl3}/lilicourse/user/add_user');
    Map<String, String> header = {"Content-Type": "application/json"};
    print('..................................');
    try {
      _logStatus = Statut.registing;
      notifyListeners();
      final reponse = await http.post(
        urlCreate,
        headers: header,
        body: json.encode(
          us.toJson(),
        ),
      );
      if (reponse.statusCode == 200) {
        _logStatus = Statut.registed;
        notifyListeners();
        var data = jsonDecode(reponse.body);
        _user = User.fromJson(data);
        UserPreferences().saveUser(_user!);
        notifyListeners();
        print('${_user!}...........................................');

        var urlToken = Uri.parse(
            '${Api_services.httpbaseUrl3}/lilicourse/user/generate?mail=${_user!.email}');
        final responseToken = await http.post(urlToken);
        if (responseToken.statusCode == 200) {
          var data1 = jsonDecode(responseToken.body);
          _token = data1['token'];
          print(
              '...................................................................;');
          print(_token!);
          notifyListeners();
          UserPreferences.saveToken(_token!);
          notifyListeners();

          result = {
            "statut": true,
            "message": "User enregistrer",
            "user": _user!,
            "token": _token!,
          };
        } else {
          result = {
            "statut": true,
            "message": "Erreur de token",
            "user": _user!
          };
        }
      } else {
        _logStatus = Statut.notregisted;
        notifyListeners();
        result = {
          "statut": false,
          "message": "User is not registed",
          "user": _user!
        };
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<Map<String, dynamic>?> deleteUser(User us) async {
    var urlDelete = Uri.parse('${Api_services.httpbaseUrl3}/lilicourse/user/');
    try {} catch (e) {}
  }

  Future<Map<String, dynamic>?> update_User(String email, User user) async {
    var result;
    final urlId =
        Uri.parse('${Api_services.httpbaseUrl3}/lilicourse/user/getId=$email');
    final headers = {"Content-type": "application/json"};
    try {
      final responseput = await http.get(urlId);
      if (responseput.statusCode == 200) {
        var data = jsonDecode(responseput.body);
        _id = data['id'];
        notifyListeners();
        final urlupdate = Uri.parse(
            '${Api_services.httpbaseUrl3}/lilicourse/user/update_user?id=$_id');
        final respon = await http.put(
          urlupdate,
          headers: headers,
          body: jsonEncode(
            user.toJson(),
          ),
        );
        if (respon.statusCode == 200) {
          var data = jsonDecode(respon.body);
          _user = User.fromJson(data);

          UserPreferences().saveUser(_user!);
          notifyListeners();

          result = {
            'status': true,
            'message': 'Successfully  updated',
            'user': _user
          };
        }
      } else {
        _logStatus = Statut.notupdated;
        result = {'status': false, 'message': 'Error updating'};
      }
      return result;
    } catch (e) {
      print(e.toString());
    }
  }
}
