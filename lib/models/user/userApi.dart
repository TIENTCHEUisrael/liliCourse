import 'package:http/http.dart' as http;
import './user.dart';
import 'dart:convert';
import '../../services/service.dart';

class UserApi {
  static Future<List<User>> getUsers() async {
    var url = Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/users');
    final response = await http.get(url);

    var data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data) {
      _temp.add(i);
    }
    return User.usersFromSnapshot(_temp);
  }

  static Future<User> getUser(int id) async {
    var url = Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load this user');
    }
  }

  static Future<User> authenticateUser(String email, String password) async {
    var url = Uri.parse(
        '${Api_services.httpbaseUrl2}/lilicourse/user/login?mail=$email&passw=$password');
    final response = await http.get(url);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load this user');
    }
  }

  static Future<void> createUser(User user) async {
    var url = Uri.parse('${Api_services.httpbaseUrl3}/lilicourse/add_user');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      final response = await http.post(
        url,
        headers: header,
        body: /*jsonEncode(user
          .toJson()), */
            jsonEncode(<String, dynamic>{
          "first_name": user.first_name,
          "last_name": user.last_name,
          "email": user.email,
          "phone_number": user.phone_number,
          "password": user.password,
          "commentaire": user.commentaire,
          "image": user.image,
        }),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
