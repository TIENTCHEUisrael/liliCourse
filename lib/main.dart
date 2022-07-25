import 'package:flutter/material.dart';
import 'package:lilicourse/Provider/providerUser.dart';
import 'package:lilicourse/models/user/shared_preferenced.dart';
import 'package:lilicourse/screens/Home/HomePage.dart';
import 'package:provider/provider.dart';
import '../screens/splashScreen/SplashPage.dart';
import 'models/user/user.dart';

const blue_button = Color(0xFF32447A);
const red_button = Color(0xFFF6095F);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();
    Future<String> getUserToken() => UserPreferences().getToken();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return AuthProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return UserProvider();
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LiliCourse',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error:${snapshot.error}');
                } else if (getUserToken() as String == null) {
                  return SplashPage();
                } else {
                  Provider.of<UserProvider>(context)
                      .setUser(snapshot.data as User);
                }
                return Home(person: snapshot.data as User);
            }
          },
        ),
        //SplashPage(),
        initialRoute: '/',
      ),
    );
  }
}
