import 'package:app/components/badge.dart';
import 'package:app/model/inscricao_documento.dart';
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

extension SituacaoInscricaoDescription on SituacaoInscricao {
  String get description {
    switch (this) {
      case SituacaoInscricao.AGUARDANDO_ANALISE:
        return 'Aguardando análise';
      case SituacaoInscricao.EM_ANALISE:
        return 'Em análise';
      case SituacaoInscricao.APROVADO:
        return 'Aprovado';
      case SituacaoInscricao.REJEITADO:
        return 'Rejeitado';
      case SituacaoInscricao.AGUARDANDO_CORRECAO:
        return 'Aguardando Correção';
    }
  }

  BadgeType get badge {
    switch (this) {
      case SituacaoInscricao.AGUARDANDO_ANALISE:
        return BadgeType.info;
      case SituacaoInscricao.EM_ANALISE:
        return BadgeType.info;
      case SituacaoInscricao.APROVADO:
        return BadgeType.success;
      case SituacaoInscricao.REJEITADO:
        return BadgeType.error;
      case SituacaoInscricao.AGUARDANDO_CORRECAO:
        return BadgeType.warn;
    }
  }
}

@JsonSerializable()
class Inscricao {
  int? id;
  Bolsa bolsa;
  List<InscricaoDocumento>? documentos;
  DateTime? dataCriacao;
  SituacaoInscricao? situacao = SituacaoInscricao.AGUARDANDO_ANALISE;
  String? motivoRetorno;
  String? observacoes;
  Aluno aluno;

  Inscricao(this.id, this.bolsa, this.documentos, this.dataCriacao,
      this.situacao, this.motivoRetorno, this.observacoes, this.aluno);

  Inscricao.fromBolsa(this.bolsa, this.documentos, this.aluno);

  factory Inscricao.fromJson(final dynamic json) => _$InscricaoFromJson(json);

  Map toJson() => _$InscricaoToJson(this);

  copy() => Inscricao(id, bolsa, documentos, dataCriacao, situacao,
      motivoRetorno, observacoes, aluno);
}
