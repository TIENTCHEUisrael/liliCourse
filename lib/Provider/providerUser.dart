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
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistedIn;

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
    final response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data);
    print('..............................................;;');
    if (response.statusCode == 200) {
      User authuser = User.fromJson(data);
      print(authuser);
      UserPreferences().saveUser(authuser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successfully authenticate',
        'user': authuser
      };
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': 'error',
      };
    }
    return result;
  }

  Future<Map<String, dynamic>?> createUser(User user) async {
    var url = Uri.parse('${Api_services.httpbaseUrl3}/lilicourse/add_user');
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

  Future<Map<String, dynamic>?> createToken(User user) async {
    var url = Uri.parse(
        '${Api_services.httpbaseUrl3}/lilicourse/user/loginUser?${user.email}&${user.password}');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      final response = await http.post(url);
      var data = jsonDecode(response.body);
      print(data);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<FutureOr> onvalue(http.Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    print('..............................................;;');

    if (response.statusCode == 200) {
      var userData = responseData['date'];

      User authuser = User.fromJson(responseData);

      UserPreferences().saveUser(authuser);

      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authuser
      };
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
