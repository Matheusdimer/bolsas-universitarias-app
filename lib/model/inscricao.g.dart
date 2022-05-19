// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inscricao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inscricao _$InscricaoFromJson(Map<String, dynamic> json) {
  return Inscricao(
    json['id'] as int?,
    Bolsa.fromJson(json['bolsa']),
    (json['documentos'] as List<dynamic>)
        .map((e) => Documento.fromJson(e))
        .toList(),
    DateTime.parse(json['dataCriacao'] as String),
    _$enumDecode(_$SituacaoInscricaoEnumMap, json['situacao']),
    json['motivoRetorno'] as String?,
    json['observacoes'] as String?,
    json['aluno'] == null ? null : Aluno.fromJson(json['aluno']),
  );
}

Map<String, dynamic> _$InscricaoToJson(Inscricao instance) => <String, dynamic>{
      'id': instance.id,
      'bolsa': instance.bolsa,
      'documentos': instance.documentos,
      'dataCriacao': instance.dataCriacao.toIso8601String(),
      'situacao': _$SituacaoInscricaoEnumMap[instance.situacao],
      'motivoRetorno': instance.motivoRetorno,
      'observacoes': instance.observacoes,
      'aluno': instance.aluno,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$SituacaoInscricaoEnumMap = {
  SituacaoInscricao.AGUARDANDO_ANALISE: 'AGUARDANDO_ANALISE',
  SituacaoInscricao.EM_ANALISE: 'EM_ANALISE',
  SituacaoInscricao.APROVADO: 'APROVADO',
  SituacaoInscricao.REJEITADO: 'REJEITADO',
  SituacaoInscricao.AGUARDANDO_CORRECAO: 'AGUARDANDO_CORRECAO',
};
