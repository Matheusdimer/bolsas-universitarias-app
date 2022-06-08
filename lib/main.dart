import 'package:bolsas_universitarias/auth/auth.service.dart';
import 'package:bolsas_universitarias/pages/app/account/address.dart';
import 'package:bolsas_universitarias/pages/app/account/my_account.dart';
import 'package:bolsas_universitarias/pages/app/bolsas/detail/bolsas.detail.dart';
import 'package:bolsas_universitarias/pages/app/bolsas/detail/editais.dart';
import 'package:bolsas_universitarias/pages/app/homepage.dart';
import 'package:bolsas_universitarias/pages/app/inscricoes/inscricao.dart';
import 'package:bolsas_universitarias/pages/app/inscricoes/inscricao_detail.dart';
import 'package:bolsas_universitarias/pages/login/login.dart';
import 'package:bolsas_universitarias/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());

  final systemTheme = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: const Color(0xFCFCFCFC),
    systemNavigationBarIconBrightness: Brightness.dark,
  );
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
        '/details': (context) => const BolsasDetail(),
        '/editais': (context) => const EditaisPage(),
        '/inscrever-se': (context) => const InscricaoPage(),
        '/inscricao-detail': (context) => const InscricaoDetail(),
      },
    );
  }
}
