import 'package:flutter/material.dart';
import 'package:lilicourse/Provider/ProviderAdress.dart';
import 'package:lilicourse/Provider/ProviderAdressLiv.dart';
import 'package:lilicourse/Provider/ProviderAdressRam.dart';
import 'package:lilicourse/Provider/ProviderCommande.dart';
import 'package:lilicourse/Provider/ProviderCoursier.dart';
import 'package:lilicourse/Provider/ProviderPaiement.dart';
import 'package:lilicourse/theme/themeManager.dart';
import 'package:provider/provider.dart';
import '../screens/splashScreen/SplashPage.dart';
import 'Provider/providerUser.dart';
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
  //Future<bool>? _appTryAutoLogin;

  @override
  void initState() {
    //AuthProvider().logOutUser();
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
        ChangeNotifierProvider(
          create: (_) {
            return AdLProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return AdProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return AdRProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return CoursProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return CommProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return PaiementProvider();
          },
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'LiliCourse',
            home: auth.isAuth == true
                ? Home()
                : FutureBuilder<bool>(
                    future: auth.tryAutoLogin(),
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
