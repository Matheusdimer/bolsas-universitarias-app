import 'package:bolsas_universitarias/components/spinner.dart';
import 'package:bolsas_universitarias/model/aluno.dart';
import 'package:bolsas_universitarias/pages/app/account/aluno.service.dart';
import 'package:bolsas_universitarias/pages/app/forms/aluno-form.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final _alunoService = AlunoService();

  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  _save(Aluno aluno) async {
    _setLoading(true);
    await _alunoService.update(aluno);
    Navigator.of(context).pop();
  }

  _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
  }

  @override
  Widget build(BuildContext context) {
    final aluno = ModalRoute.of(context)!.settings.arguments as Aluno;

    return Scaffold(
      appBar: AppBar(title: const Text('Dados do aluno')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AlunoForm(aluno: aluno),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _save(aluno),
                    child: _loading ? const Spinner() : const Text('SALVAR'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
