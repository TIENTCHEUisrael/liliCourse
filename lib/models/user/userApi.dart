import 'package:http/http.dart' as http;
import './user.dart';
import 'dart:convert';
import '../../services/service.dart';

class UserApi {
  static UserApi? _instance;

  UserApi._();

  static UserApi get instance {
    if (_instance == null) {
      _instance = UserApi._();
    }
    return _instance!;
  }

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

  Future<User> authenticateUser(String email, String password) async {
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
























































/**ChangeNotifierProvider(
                    create: (context) {
                      return UserModel(email.text, pass.text);
                    },
                    child: Builder(
                      builder: (context) {
                        final model = Provider.of<UserModel>(context);

                        if (model.homeState == HomeState.Loading) {
                          setState(() {
                            isLoading = true;
                          });
                        }
                        if (model.homeState == HomeState.Error) {
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(
                            msg: "Error:${model.message}",
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                        final currentUser = model.user;
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: blue_button,
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.only(
                                left: 100,
                                right: 100,
                                top: 10,
                                bottom: 10,
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  )
                                : Text(
                                    'Connexion',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 18),
                                  ),
                            onPressed: () {
                              isLoading
                                  ? null
                                  : Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                      return Home(person: currentUser!);
                                    }));
                            });
                      },
                    ),
                  ), */
                