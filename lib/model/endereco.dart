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

  factory Endereco.fromJson(final dynamic json) => _$EnderecoFromJson(json);

  Map toJson() => _$EnderecoToJson(this);
}
