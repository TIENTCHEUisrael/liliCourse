import 'package:flutter/widgets.dart';
import 'package:lilicourse/models/user/userApi.dart';

import 'user.dart';

enum HomeState {
  // ignore: constant_identifier_names
  Initial,
  // ignore: constant_identifier_names
  Loading,
  // ignore: constant_identifier_names
  Loaded,
  // ignore: constant_identifier_names
  Error,
}

class UserModel extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  User? user;
  String message = '';

  UserModel(String u, String p) {
    login(u, p);
  }
  HomeState get homeState {
    return _homeState;
  }

  Future<void> login(String mail, String pass) async {
    _homeState = HomeState.Loading;
    try {
      await Future.delayed(const Duration(seconds: 3));
      UserApi.instance.authenticateUser(mail, pass).then((result) {
        user = result;
      });
      _homeState = HomeState.Loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }
}
