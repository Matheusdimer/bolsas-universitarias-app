import 'package:app/auth/auth.service.dart';
import 'package:app/pages/app/account/address.dart';
import 'package:app/pages/app/account/my_account.dart';
import 'package:app/pages/app/bolsas/detail/bolsas.detail.dart';
import 'package:app/pages/app/homepage.dart';
import 'package:app/pages/login/login.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());

  final systemTheme = SystemUiOverlayStyle.light
      .copyWith(systemNavigationBarColor: Colors.white);
  SystemChrome.setSystemUIOverlayStyle(systemTheme);

  AuthService.instance.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas bolsas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: themeColor,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/account': (context) => const MyAccountPage(),
        '/address': (context) => const AddressPage(),
        '/details': (context) => const BolsasDetail()
      },
    );
  }
}
