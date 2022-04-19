import 'package:json_annotation/json_annotation.dart';

part 'documento.g.dart';

@JsonSerializable()
class Documento {
  int? id;
  String nome;
  DateTime dataCriacao;
  int? arquivoId;


  Documento(this.id, this.nome, this.dataCriacao, this.arquivoId);

  factory Documento.fromJson(final dynamic json) => _$DocumentoFromJson(json);

  Map toJson() => _$DocumentoToJson(this);
}
