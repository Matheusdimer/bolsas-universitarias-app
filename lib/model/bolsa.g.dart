// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bolsa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bolsa _$BolsaFromJson(Map<String, dynamic> json) {
  return Bolsa(
    json['id'] as int,
    json['nome'] as String,
    json['descricao'] as String,
    (json['requisitos'] as List<dynamic>?)
        ?.map((e) => Requisito.fromJson(e))
        .toList(),
    (json['documentos'] as List<dynamic>?)
        ?.map((e) => Documento.fromJson(e))
        .toList(),
    json['editalAtivo'] as bool,
    json['tipoBolsa'] as String,
    json['fotoId'] as int?,
    _$enumDecode(_$TipoInscricaoEnumMap, json['tipoInscricao']),
    json['url'] as String?,
  )..editais = (json['editais'] as List<dynamic>?)
      ?.map((e) => Edital.fromJson(e))
      .toList();
}

Map<String, dynamic> _$BolsaToJson(Bolsa instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'descricao': instance.descricao,
      'requisitos': instance.requisitos,
      'documentos': instance.documentos,
      'editais': instance.editais,
      'editalAtivo': instance.editalAtivo,
      'tipoBolsa': instance.tipoBolsa,
      'fotoId': instance.fotoId,
      'tipoInscricao': _$TipoInscricaoEnumMap[instance.tipoInscricao],
      'url': instance.url,
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

const _$TipoInscricaoEnumMap = {
  TipoInscricao.INTERNA: 'INTERNA',
  TipoInscricao.EXTERNA: 'EXTERNA',
};
