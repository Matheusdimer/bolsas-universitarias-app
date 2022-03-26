import 'package:app/pages/app/homepage.dart';
import 'package:app/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());

  final systemTheme = SystemUiOverlayStyle.light
      .copyWith(systemNavigationBarColor: Colors.white);
  SystemChrome.setSystemUIOverlayStyle(systemTheme);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas bolsas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
