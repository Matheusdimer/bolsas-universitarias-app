import 'package:bolsas_universitarias/model/documento.dart';
import 'package:bolsas_universitarias/model/edital.dart';
import 'package:bolsas_universitarias/model/requisito.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bolsa.g.dart';

enum TipoInscricao { INTERNA, EXTERNA }

@JsonSerializable()
class Bolsa {
  int id;
  String nome;
  String descricao;
  List<Requisito>? requisitos;
  List<Documento>? documentos;
  List<Edital>? editais;
  bool editalAtivo;
  String tipoBolsa;
  int? fotoId;
  TipoInscricao tipoInscricao;
  String? url;

  Bolsa(
      this.id,
      this.nome,
      this.descricao,
      this.requisitos,
      this.documentos,
      this.editalAtivo,
      this.tipoBolsa,
      this.fotoId,
      this.tipoInscricao,
      this.url);

  factory Bolsa.fromJson(final dynamic json) => _$BolsaFromJson(json);

  Map toJson() => _$BolsaToJson(this);

  Edital? get editalAtual {
    if (editais == null) return null;

    final now = DateTime.now();
    return editais!.firstWhere((edital) =>
        edital.dataInicio.isBefore(now) && now.isBefore(edital.dataFim));
  }
}
