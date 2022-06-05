import 'package:bolsas_universitarias/components/masks.dart';
import 'package:bolsas_universitarias/model/endereco.dart';
import 'package:bolsas_universitarias/model/estado.dart';
import 'package:bolsas_universitarias/model/municipio.dart';
import 'package:bolsas_universitarias/pages/app/account/endereco.service.dart';
import 'package:bolsas_universitarias/utils/validators.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class EnderecoForm extends StatefulWidget {
  final Endereco endereco;

  const EnderecoForm({Key? key, required this.endereco}) : super(key: key);

  @override
  State<EnderecoForm> createState() => _EnderecoFormState();
}

class _EnderecoFormState extends State<EnderecoForm> {
  final _service = EnderecoService();

  late Endereco _endereco;

  Estado? _estado;
  List<Estado> _estados = [];

  @override
  void initState() {
    super.initState();
    _endereco = widget.endereco;

    loadEstados().then((value) {
      Estado? estado = _endereco.municipio?.estado;

      if (estado == null) return;

      setState(() {
        _estado = _estados.firstWhere((element) => element.id == estado.id);
      });
    });
  }

  Future<void> loadEstados() {
    return _service.estados
        .then((value) => setState(() => _estados = value));
  }

  void _setEstado(Estado? value) {
    _estado = value;
    setState(() {
      _endereco.municipio = null;
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            label: Text('CEP'),
          ),
          keyboardType: TextInputType.number,
          initialValue: cepMask.maskText(_endereco.cep ?? ''),
          inputFormatters: [cepMask],
          onChanged: (value) =>
          _endereco.cep = cepMask.unmaskText(value),
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
            return _service.getMunicipios(
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
      ],
    );
  }
}