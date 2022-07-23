import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LiliCourse',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const SplashPage(),
      initialRoute: '/',
    );
  }
}
