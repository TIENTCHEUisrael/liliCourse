import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/splashScreen/SplashPage.dart';
import 'Provider/provideruser.dart';

const blue_button = Color(0xFF32447A);
const red_button = Color(0xFFF6095F);

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LiliCourse',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: SplashPage(),
        initialRoute: '/',
      ),
    );
  }
}
