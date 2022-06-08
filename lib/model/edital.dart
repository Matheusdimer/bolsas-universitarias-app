import 'package:json_annotation/json_annotation.dart';

part 'edital.g.dart';

@JsonSerializable()
class Edital {
  int? id;
  String descricao;
  int? arquivoId;
  DateTime dataInicio;
  DateTime dataFim;
  DateTime? dataResultado;


  Edital(this.id, this.descricao, this.arquivoId, this.dataInicio, this.dataFim,
      this.dataResultado);

  factory Edital.fromJson(final dynamic json) => _$EditalFromJson(json);

  Map toJson() => _$EditalToJson(this);

  bool get atual {
    final now = DateTime.now();
    return dataInicio.isBefore(now) && now.isBefore(dataFim);
  }
}
