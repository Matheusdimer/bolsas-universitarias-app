import 'package:flutter/material.dart';

class InscricaoCadastro extends StatefulWidget {
  const InscricaoCadastro({Key? key}) : super(key: key);

  @override
  State<InscricaoCadastro> createState() => _InscricaoCadastroState();
}

class _InscricaoCadastroState extends State<InscricaoCadastro> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscrever-se"),
      ),
      body: Container(),
    );
  }
}
