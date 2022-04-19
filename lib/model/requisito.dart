import 'package:json_annotation/json_annotation.dart';

part 'requisito.g.dart';

@JsonSerializable()
class Requisito {
  int? id;
  String descricao;

  Requisito(this.id, this.descricao);

  factory Requisito.fromJson(final dynamic json) => _$RequisitoFromJson(json);

  Map toJson() => _$RequisitoToJson(this);
}
