import 'package:app/components/spinner.dart';
import 'package:app/model/aluno.dart';
import 'package:app/pages/app/account/aluno.service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:app/utils/captalize.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final _alunoService = AlunoService();

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();

  bool _loading = false;

  final _cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager,
  );

  final _phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  _setAluno(Aluno aluno) {
    _emailController.text = aluno.email ?? '';
    _telefoneController.text = _phoneMask.maskText(aluno.contato ?? '');
  }

  Aluno _updateValues(Aluno aluno) {
    aluno.email = _emailController.text;
    aluno.contato = _telefoneController.text;
    return aluno;
  }

  _save(Aluno aluno) async {
    _setLoading(true);
    await _alunoService.update(_updateValues(aluno));
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

    _setAluno(aluno);

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
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                  initialValue: aluno.nome,
                  enabled: false,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('CPF'),
                  ),
                  initialValue: _cpfMask.maskText(aluno.cpf),
                  enabled: false,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Data Nascimento'),
                  ),
                  enabled: false,
                  initialValue: aluno.dataNascimento != null
                      ? DateFormat('dd/MM/yyyy').format(aluno.dataNascimento!)
                      : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Telefone'),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [_phoneMask],
                  controller: _telefoneController,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<Sexo>(
                  decoration: const InputDecoration(
                    label: Text('Sexo'),
                  ),
                  value: aluno.sexo,
                  items: Sexo.values
                      .map(
                        (sexo) => DropdownMenuItem<Sexo>(
                          child: Text(sexo.name.capitalize()),
                          value: sexo,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      aluno.sexo = value;
                    }
                  },
                ),
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
