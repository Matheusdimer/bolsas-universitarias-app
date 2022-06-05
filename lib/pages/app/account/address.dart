import 'package:bolsas_universitarias/components/spinner.dart';
import 'package:bolsas_universitarias/model/endereco.dart';
import 'package:bolsas_universitarias/pages/app/account/aluno.service.dart';
import 'package:bolsas_universitarias/pages/app/forms/endereco-form.dart';
import 'package:flutter/material.dart';

import '../../../model/aluno.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _alunoService = AlunoService();

  bool _loading = false;

  late Aluno _aluno;
  Endereco _endereco = Endereco.empty();

  void save() async {
    if (!_formKey.currentState!.validate()) return;

    _setLoading(true);

    _aluno.endereco = _endereco;
    await _alunoService.update(_aluno);
    Navigator.of(context).pop();
  }

  void _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  void _setAluno(Aluno? aluno) {
    if (aluno == null) return;

    setState(() {
      _aluno = aluno;
    });
  }

  void _setEndereco(Endereco? endereco) async {
    if (endereco == null) return;

    setState(() {
      _endereco = Endereco.copy(endereco);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final aluno = ModalRoute.of(context)!.settings.arguments as Aluno?;

    _setAluno(aluno);
    _setEndereco(aluno?.endereco);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Endereço')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EnderecoForm(endereco: _endereco),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: save,
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
