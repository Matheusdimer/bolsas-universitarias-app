// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inscricao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inscricao _$InscricaoFromJson(Map json) => Inscricao(
      json['id'] as int?,
      Bolsa.fromJson(json['bolsa']),
      (json['documentos'] as List<dynamic>?)
          ?.map((e) => InscricaoDocumento.fromJson(e))
          .toList(),
      json['dataCriacao'] == null
          ? null
          : DateTime.parse(json['dataCriacao'] as String),
      $enumDecodeNullable(_$SituacaoInscricaoEnumMap, json['situacao']),
      json['motivoRetorno'] as String?,
      json['observacoes'] as String?,
      Aluno.fromJson(json['aluno']),
    );

Map<String, dynamic> _$InscricaoToJson(Inscricao instance) => <String, dynamic>{
      'id': instance.id,
      'bolsa': instance.bolsa.toJson(),
      'documentos': instance.documentos?.map((e) => e.toJson()).toList(),
      'dataCriacao': instance.dataCriacao?.toIso8601String(),
      'situacao': _$SituacaoInscricaoEnumMap[instance.situacao],
      'motivoRetorno': instance.motivoRetorno,
      'observacoes': instance.observacoes,
      'aluno': instance.aluno.toJson(),
    };

const _$SituacaoInscricaoEnumMap = {
  SituacaoInscricao.AGUARDANDO_ANALISE: 'AGUARDANDO_ANALISE',
  SituacaoInscricao.EM_ANALISE: 'EM_ANALISE',
  SituacaoInscricao.APROVADO: 'APROVADO',
  SituacaoInscricao.REJEITADO: 'REJEITADO',
  SituacaoInscricao.AGUARDANDO_CORRECAO: 'AGUARDANDO_CORRECAO',
};
