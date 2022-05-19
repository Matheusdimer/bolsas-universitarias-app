import 'package:app/components/masks.dart';
import 'package:app/components/spinner.dart';
import 'package:app/model/endereco.dart';
import 'package:app/model/estado.dart';
import 'package:app/model/municipio.dart';
import 'package:app/pages/app/account/aluno.service.dart';
import 'package:app/pages/app/account/endereco.service.dart';
import 'package:app/utils/validators.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../model/aluno.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _enderecoService = EnderecoService();
  final _alunoService = AlunoService();

  bool _loading = false;

  List<Estado> _estados = [];

  late Aluno _aluno;
  Endereco _endereco = Endereco.empty();
  Estado? _estado;

  Future<void> loadEstados() {
    return _enderecoService.estados
        .then((value) => setState(() => _estados = value));
  }

  void _setEstado(Estado? value) {
    _estado = value;
    setState(() {
      _endereco.municipio = null;
    });
  }

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
    loadEstados().then((value) {
      if (endereco == null) return;

      Estado? estado = _endereco.municipio?.estado;

      if (estado == null) return;

      setState(() {
        _estado = _estados.firstWhere((element) => element.id == estado.id);
      });
    });

    if (endereco == null) return;

    setState(() {
      _endereco = Endereco.copy(endereco);
    });
  }

  List<DropdownMenuItem<T>> _getDropdownList<T>(
      List<T> list, String Function(T value) textProvider) {
    return list
        .map((e) => DropdownMenuItem<T>(
              value: e,
              child: Text(
                textProvider(e),
              ),
            ))
        .toList();
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
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('CEP'),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: cepMask.maskText(_endereco.cep ?? ''),
                  inputFormatters: [cepMask],
                  onChanged: (value) => _endereco.cep = value.replaceAll('-', ''),
                  validator: requiredValidator,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Logradouro'),
                  ),
                  initialValue: _endereco.logradouro,
                  onChanged: (value) => _endereco.logradouro = value,
                  validator: requiredValidator,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Bairro'),
                  ),
                  initialValue: _endereco.bairro,
                  onChanged: (value) => _endereco.bairro = value,
                  validator: requiredValidator,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Número'),
                  ),
                  initialValue: _endereco.numero,
                  onChanged: (value) => _endereco.numero = value,
                  validator: requiredValidator,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Complemento'),
                  ),
                  initialValue: _endereco.complemento,
                  onChanged: (value) => _endereco.complemento = value,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<Estado>(
                  value: _estado,
                  decoration: const InputDecoration(
                    label: Text('Estado'),
                  ),
                  items: _getDropdownList(
                      _estados, (value) => '${value.nome} (${value.sigla})'),
                  onChanged: _setEstado,
                  validator: requiredValidator,
                ),
                const SizedBox(height: 20),
                DropdownSearch<Municipio>(
                  mode: Mode.BOTTOM_SHEET,
                  searchDelay: const Duration(milliseconds: 500),
                  showSearchBox: true,
                  dropdownSearchDecoration:
                      const InputDecoration(labelText: "Município"),
                  onFind: (String? filter) {
                    return _enderecoService.getMunicipios(
                      idEstado: _estado?.id,
                      filter: filter,
                    );
                  },
                  selectedItem: _endereco.municipio,
                  onChanged: (Municipio? data) {
                    _endereco.municipio = data;
                  },
                  validator: requiredValidator,
                ),
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
