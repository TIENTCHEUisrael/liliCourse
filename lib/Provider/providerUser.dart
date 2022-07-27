import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/user/shared_preferenced.dart';
import '../services/service.dart';
import '../models/user/user.dart';

enum Status {
  NotLoggedIn,
  NotRegistedIn,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggetOut,
  updatedIn,
  upadated,
}

class AuthProvider extends ChangeNotifier {
  String? _token;
  User? _user;
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistedIn;

  String? get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  User? get user {
    if (_user != null) {
      return _user;
    }
    return null;
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Status get loggedInStatus => _loggedInStatus;
  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _registeredInStatus;
  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    var result;
    var url = Uri.parse(
        '${Api_services.httpbaseUrl3}/lilicourse/user/login?mail=$email&passw=$password');
    var url2 = Uri.parse(
        '${Api_services.httpbaseUrl3}/lilicourse/user/loginUser?mail=$email&passw=$password');

    try {
      final response2 = await http.post(url2);
      var data2 = jsonDecode(response2.body);
      if (response2.statusCode == 200) {
        _token = data2['result'];
        print(data2['result']);

        UserPreferences.saveToken(_token!);
        notifyListeners();

        final response1 = await http.get(url);
        var data = jsonDecode(response1.body);
        if (response1.statusCode == 200) {
          _user = User.fromJson(data);

          UserPreferences().saveUser(_user!);
          _loggedInStatus = Status.LoggedIn;

          notifyListeners();

          result = {
            'status': true,
            'message': 'Successfully authenticate',
            'user': _user
          };
        } else {
          _loggedInStatus = Status.NotLoggedIn;
          notifyListeners();
          result = {
            'status': false,
            'message': 'error',
          };
        }
      } else {
        print('Error');
      }
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> createUser(User user) async {
    var result;
    var url =
        Uri.parse('${Api_services.httpbaseUrl3}/lilicourse/user/add_user');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _loggedInStatus = Status.Authenticating;
      notifyListeners();
      final response = await http.post(
        url,
        headers: header,
        body: json.encode(
          user.toJson(),
        ),
      );
      print(response.body);
      if (response.statusCode == 200) {
        _loggedInStatus = Status.Registered;
        notifyListeners();
        var data = jsonDecode(response.body);
        _user = User.fromJson(data);

        UserPreferences().saveUser(_user!);
        notifyListeners();
        result = {
          'status': true,
          'message': 'Successfully registered',
          'data': _user
        };
        var urlLogin = Uri.parse(
            '${Api_services.httpbaseUrl3}/lilicourse/user/login?mail=${_user!.email}&passw=${_user!.password}');
        var urlToken = Uri.parse(
            '${Api_services.httpbaseUrl3}/lilicourse/user/loginUser?mail=${_user!.email}&passw=${_user!.password}');
        final responseToken = await http.post(urlToken);
        if (responseToken.statusCode == 200) {
          var dataToken = jsonDecode(responseToken.body);
          _token = dataToken['result'];
          print(_token);
          UserPreferences.saveToken(_token!);
          notifyListeners();

          final responseLogin = await http.get(urlLogin);
          if (responseLogin.statusCode == 200) {
            _user = User.fromJson(data);

            _loggedInStatus = Status.LoggedIn;
            print(_user);

            notifyListeners();

            result = {
              'status': true,
              'message': 'Successfully authenticate and register',
              'user': _user
            };
          } else {
            result = {
              'status': true,
              'message': 'Successfully  register and not authenticate',
              'user': _user
            };
            print(result['message']);
          }
        } else {
          result = {
            'status': true,
            'message': 'Successfully  register and not generate token',
            'user': _user
          };
        }
      } else {
        return {'status': false, 'message': 'Error registered', 'data': _user};
      }
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>?> update_User(String email, User user) async {
    var result;
    final url = Uri.parse(
        '${Api_services.httpbaseUrl3}/lilicourse/user/update_user?mail=$email');
    final headers = {"Content-type": "application/json"};
    try {
      _loggedInStatus = Status.updatedIn;
      notifyListeners();
      final responseput = await http.put(
        url,
        headers: headers,
        body: json.encode(
          user.toJson(),
        ),
      );
      if (responseput.statusCode == 200) {
        print(
            '${responseput.body}...............................................;;;;');
        var data = jsonDecode(responseput.body);
        _user = User.fromJson(data);
        print('$_user....................................................');
        setUser(_user!);
        UserPreferences().saveUser(_user!);
        _loggedInStatus = Status.upadated;
        notifyListeners();

        result = {
          'status': true,
          'message': 'Successfully  updated',
          'user': _user
        };
      } else {
        result = {'status': false, 'message': 'Error updating', 'user': _user};
      }
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>?> createAuthenticateUser(User user) async {
    var result;
    var url =
        Uri.parse('${Api_services.httpbaseUrl3}/lilicourse/user/add_user');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _loggedInStatus = Status.Registering;
      notifyListeners();
      final response = await http.post(
        url,
        headers: header,
        body: json.encode(
          user.toJson(),
        ),
      );
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _user = User.fromJson(data);

        UserPreferences().saveUser(_user!);
        notifyListeners();
        var urlLogin = Uri.parse(
            '${Api_services.httpbaseUrl3}/lilicourse/user/loginUser?mail=${_user!.email}&passw=${_user!.password}');

        final responseLogin = await http.post(urlLogin);

        if (responseLogin.statusCode == 200) {
          _loggedInStatus = Status.Registered;
          var data = jsonDecode(responseLogin.body);
          _token = data['token'];
          print(_token);
          print(data);
          UserPreferences.saveToken(_token!);
          notifyListeners();
          _user = data;
          UserPreferences().saveUser(_user!);
          notifyListeners();
          result = {
            'status': true,
            'message': 'Successfully registered',
            'data': _user
          };
        }
      } else {
        result = {
          'status': false,
          'message': 'Error registered',
          'data': _user
        };
      }
      return result;
    } on Exception catch (e) {
      print("$e");
    }
  }
}

class UserProvider extends ChangeNotifier {
  User? _user;

  User get user {
    return _user!;
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
