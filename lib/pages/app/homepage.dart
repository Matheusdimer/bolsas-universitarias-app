import 'package:app/auth/auth.service.dart';
import 'package:app/pages/app/account/account.dart';
import 'package:app/pages/app/bolsas/bolsas.dart';
import 'package:app/pages/app/inscricoes/inscricoes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authService = AuthService.instance;

  final List<Widget> _tabs = [
    const BolsasList(),
    const InscricoesList(),
    const AccountInfo(),
  ];

  int _tab = 0;

  _setTab(final int index) {
    setState(() {
      _tab = index;
    });
  }

  @override
  void initState() {
    _verifyLogin();
    super.initState();
  }

  void _verifyLogin() {
    if (!_authService.loggedIn()) {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        Navigator.of(context).popAndPushNamed('/login');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas bolsas"),
      ),
      body: _tabs.elementAt(_tab),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Bolsas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Inscrições',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Conta',
          )
        ],
        currentIndex: _tab,
        onTap: _setTab,
      ),
    );
  }
}
