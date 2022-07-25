import 'package:shared_preferences/shared_preferences.dart';

import './user.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("first_name", user.first_name);
    prefs.setString("last_name", user.last_name);
    prefs.setString("email", user.email);
    prefs.setInt("phone_number", user.phone_number);
    prefs.setString("password", user.password);
    prefs.setString("commentaire", user.commentaire);
    prefs.setString("image", user.image!);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? first_name = prefs.getString("first_name");
    String? last_name = prefs.getString("last_name");
    String? email = prefs.getString("email");
    int? phone_number = prefs.getString("phone_number") as int;
    String? password = prefs.getString("passwordd");
    String? commentaire = prefs.getString("commentaire");
    String? image = prefs.getString("image");

    return User(
      first_name: first_name!,
      last_name: last_name!,
      email: email!,
      phone_number: phone_number,
      password: password!,
      commentaire: commentaire!,
      image: image,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("first_name");
    prefs.remove("last_name");
    prefs.remove("email");
    prefs.remove("phone_number");
    prefs.remove("password");
    prefs.remove("commentaire");
    prefs.remove("image");
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(
      "result",
    );

    return token!;
  }

  Future<bool> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("result", token);

    return prefs.commit();
  }
}
