import 'package:app/model/documento.dart';
import 'package:json_annotation/json_annotation.dart';

import 'aluno.dart';
import 'bolsa.dart';

part 'inscricao.g.dart';

enum SituacaoInscricao {
  AGUARDANDO_ANALISE,
  EM_ANALISE,
  APROVADO,
  REJEITADO,
  AGUARDANDO_CORRECAO
}

@JsonSerializable()
class Inscricao {
  int? id;
  Bolsa bolsa;
  List<Documento> documentos;
  DateTime dataCriacao;
  SituacaoInscricao situacao;
  String? motivoRetorno;
  String? observacoes;
  Aluno? aluno;

  Inscricao(this.id, this.bolsa, this.documentos, this.dataCriacao,
      this.situacao, this.motivoRetorno, this.observacoes, this.aluno);

  factory Inscricao.fromJson(final dynamic json) => _$InscricaoFromJson(json);

  Map toJson() => _$InscricaoToJson(this);
}