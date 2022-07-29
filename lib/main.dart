import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  Future<bool>? _appTryAutoLogin;

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
                  : const SplashPage());
        },
      ),
    );
    //);
  }
}
