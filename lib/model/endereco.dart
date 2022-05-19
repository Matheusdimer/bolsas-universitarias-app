import 'package:app/model/municipio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'endereco.g.dart';

@JsonSerializable()
class Endereco {
  int? id;
  String? logradouro;
  String? bairro;
  String? cep;
  Municipio? municipio;
  String? complemento;
  String? numero;

  Endereco.empty();

  Endereco(this.id, this.logradouro, this.bairro, this.cep, this.municipio,
      this.complemento, this.numero);

  Endereco.copy(Endereco endereco) {
    id = endereco.id;
    logradouro = endereco.logradouro;
    bairro = endereco.bairro;
    cep = endereco.cep;
    municipio = endereco.municipio;
    complemento = endereco.complemento;
    numero = endereco.numero;
  }

  factory Endereco.fromJson(final dynamic json) => _$EnderecoFromJson(json);

  Map toJson() => _$EnderecoToJson(this);

  @override
  String toString() {
    return 'Endereco{id: $id, logradouro: $logradouro, bairro: $bairro, cep: $cep, municipio: $municipio, complemento: $complemento, numero: $numero}';
  }
}
