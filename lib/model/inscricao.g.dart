// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inscricao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inscricao _$InscricaoFromJson(Map<String, dynamic> json) {
  return Inscricao(
    json['id'] as int?,
    Bolsa.fromJson(json['bolsa']),
    ((json['documentos'] ?? []) as List<dynamic>)
        .map((e) => InscricaoDocumento.fromJson(e))
        .toList(),
    json['dataCriacao'] == null
        ? null
        : DateTime.parse(json['dataCriacao'] as String),
    _$enumDecodeNullable(_$SituacaoInscricaoEnumMap, json['situacao']),
    json['motivoRetorno'] as String?,
    json['observacoes'] as String?,
    Aluno.fromJson(json['aluno']),
  );
}

Map<String, dynamic> _$InscricaoToJson(Inscricao instance) => <String, dynamic>{
      'id': instance.id,
      'bolsa': instance.bolsa,
      'documentos': instance.documentos,
      'dataCriacao': instance.dataCriacao?.toIso8601String(),
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

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$SituacaoInscricaoEnumMap = {
  SituacaoInscricao.AGUARDANDO_ANALISE: 'AGUARDANDO_ANALISE',
  SituacaoInscricao.EM_ANALISE: 'EM_ANALISE',
  SituacaoInscricao.APROVADO: 'APROVADO',
  SituacaoInscricao.REJEITADO: 'REJEITADO',
  SituacaoInscricao.AGUARDANDO_CORRECAO: 'AGUARDANDO_CORRECAO',
};
