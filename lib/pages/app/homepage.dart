import 'package:app/pages/app/bolsas/bolsas.dart';
import 'package:app/pages/app/candidaturas/candidaturas.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _tabs = [
    const BolsasList(),
    const CandidaturasList(),
  ];

  int _tab = 0;

  _setTab(final int index) {
    setState(() {
      _tab = index;
    });
  }

  @override
  void initState() {
    super.initState();
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
        ],
        currentIndex: _tab,
        onTap: _setTab,
      ),
    );
  }
}
