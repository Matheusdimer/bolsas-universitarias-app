import 'package:app/model/estado.dart';
import 'package:json_annotation/json_annotation.dart';

part 'municipio.g.dart';

@JsonSerializable()
class Municipio {
  int id;
  String nome;
  Estado? estado;

  Municipio(this.id, this.nome, this.estado);

  factory Municipio.fromJson(final dynamic json) => _$MunicipioFromJson(json);

  Map toJson() => _$MunicipioToJson(this);

  @override
  String toString() {
    if (estado != null) {
      return '$nome (${estado?.sigla})';
    }
    return nome;
  }
}
