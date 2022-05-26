import 'package:app/components/masks.dart';
import 'package:app/model/aluno.dart';
import 'package:app/utils/captalize.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlunoForm extends StatelessWidget {
  const AlunoForm({
    Key? key,
    required this.aluno,
  }) : super(key: key);

  final Aluno aluno;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          initialValue: cpfMask.maskText(aluno.cpf),
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
          initialValue: aluno.email,
          onChanged: (value) => aluno.email = value,
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            label: Text('Telefone'),
          ),
          keyboardType: TextInputType.phone,
          inputFormatters: [phoneMask],
          initialValue: aluno.contato,
          onChanged: (value) => aluno.contato = phoneMask.unmaskText(value),
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
      ],
    );
  }
}