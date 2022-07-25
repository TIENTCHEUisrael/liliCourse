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
  LoggetOut
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

        UserPreferences.saveToken(_token);
        notifyListeners();

        final response1 = await http.get(url);
        var data = jsonDecode(response1.body);
        if (response1.statusCode == 200) {
          _user = User.fromJson(data);
          print(_user);

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

  /*Future<void> createToken(User user) async {
    var url = Uri.parse(
        '${Api_services.httpbaseUrl3}/lilicourse/user/loginUser?mail=${user.email}&passw=${user.password}');
    try {
      final response = await http.post(url);
      var data = jsonDecode(response.body);
      _token = data['result'];
      print(data['result']);

      UserPreferences.saveToken(_token);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }*/

  Future<Map<String, dynamic>?> createUser(User user) async {
    var url = Uri.parse('${Api_services.httpbaseUrl3}/lilicourse/add_user');
    var url1 = Uri.parse(
        '${Api_services.httpbaseUrl3}/lilicourse/user/login?mail=${user.email}&passw=${user.password}');
    var url2 = Uri.parse(
        '${Api_services.httpbaseUrl3}/lilicourse/user/loginUser?mail=${user.email}&passw=${user.password}');

    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _loggedInStatus = Status.Authenticating;
      notifyListeners();

      final response = await http
          .post(url,
              body: json.encode(
                user.toJson(),
              ),
              headers: header)
          .then(onvalue)
          .catchError(onError("Error"));
      _loggedInStatus = Status.Registered;
      notifyListeners();

      return response as Future<Map<String, dynamic>?>;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<FutureOr> onvalue(http.Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    print('..............................................;;');

    if (response.statusCode == 200) {
      _user = User.fromJson(responseData);

      UserPreferences().saveUser(_user!);
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': _user
      };
      var url1 = Uri.parse(
          '${Api_services.httpbaseUrl3}/lilicourse/user/login?mail=${_user!.email}&passw=${_user!.password}');
      var url2 = Uri.parse(
          '${Api_services.httpbaseUrl3}/lilicourse/user/loginUser?mail=${_user!.email}&passw=${_user!.password}');
      final response2 = await http.post(url2);
      var data2 = jsonDecode(response2.body);
      if (response2.statusCode == 200) {
        _token = data2['result'];
        print(data2['result']);

        UserPreferences.saveToken(_token);
        notifyListeners();

        final response1 = await http.get(url1);
        var data = jsonDecode(response1.body);
        if (response1.statusCode == 200) {
          _user = User.fromJson(data);
          print(_user);

          UserPreferences().saveUser(_user!);
          _loggedInStatus = Status.LoggedIn;

          notifyListeners();
        } else {
          _loggedInStatus = Status.NotLoggedIn;
          notifyListeners();
        }
      } else {
        print('Error');
      }
    } else {
      result = {
        'status': false,
        'message': 'Error registered',
        'data': responseData
      };
    }
    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');

    return {'status': false, 'message': 'failed registered', 'data': error};
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
