import 'package:flutter/material.dart';

class BolsasDetail extends StatefulWidget {
  const BolsasDetail({Key? key}) : super(key: key);

  @override
  State<BolsasDetail> createState() => _BolsasDetailState();
}

class _BolsasDetailState extends State<BolsasDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
    );
  }
}
