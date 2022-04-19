import 'package:app/model/documento.dart';
import 'package:app/model/requisito.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bolsa.g.dart';

@JsonSerializable()
class Bolsa {
  int? id;
  String nome;
  String descricao;
  List<Requisito>? requisitos;
  List<Documento>? documentos;
  bool? editalAtivo;
  String tipoBolsa;
  int? fotoId;

  Bolsa(this.id, this.nome, this.descricao, this.requisitos, this.documentos,
      this.editalAtivo, this.tipoBolsa);

  factory Bolsa.fromJson(final dynamic json) => _$BolsaFromJson(json);

  Map toJson() => _$BolsaToJson(this);
}
