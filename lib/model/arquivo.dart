import 'package:json_annotation/json_annotation.dart';

part 'arquivo.g.dart';

@JsonSerializable()
class Arquivo {
  int id;
  String nome;
  String extensao;
  DateTime criadoEm;
  String tipo;

  Arquivo(this.id, this.nome, this.extensao, this.criadoEm, this.tipo);

  factory Arquivo.fromJson(final dynamic json) => _$ArquivoFromJson(json);

  Map toJson() => _$ArquivoToJson(this);
}
