import 'package:json_annotation/json_annotation.dart';

part 'estado.g.dart';

@JsonSerializable()
class Estado {
  int id;
  String nome;
  String sigla;

  Estado(this.id, this.nome, this.sigla);

  factory Estado.fromJson(final dynamic json) => _$EstadoFromJson(json);

  Map toJson() => _$EstadoToJson(this);

}