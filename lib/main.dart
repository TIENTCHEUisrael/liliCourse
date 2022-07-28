import 'package:flutter/material.dart';
import 'package:lilicourse/services/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/splashScreen/SplashPage.dart';
import 'Provider/provideruser.dart';
import 'screens/Home/HomePage.dart';

const blue_button = Color(0xFF32447A);
const red_button = Color(0xFFF6095F);

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool>? _appTryAutoLogin;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return AuthProvider();
          },
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          _appTryAutoLogin = auth.tryAutoLogin();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'LiliCourse',
            theme: ThemeData(scaffoldBackgroundColor: Colors.white),
            home: auth.isAuth == true
                ? Home(person: auth.user)
                : FutureBuilder<bool>(
                    future: _appTryAutoLogin,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Scaffold(
                            backgroundColor: Colors.white,
                            body: Container(
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );

                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return SplashPage();
                          }
                      }
                    },
                  ),
          );
        },
      ),
    );
    //);
  }
}
