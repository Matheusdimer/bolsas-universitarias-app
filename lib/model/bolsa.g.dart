// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bolsa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bolsa _$BolsaFromJson(Map json) => Bolsa(
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
      $enumDecode(_$TipoInscricaoEnumMap, json['tipoInscricao']),
      json['url'] as String?,
    )..editais = (json['editais'] as List<dynamic>?)
        ?.map((e) => Edital.fromJson(e))
        .toList();

Map<String, dynamic> _$BolsaToJson(Bolsa instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'descricao': instance.descricao,
      'requisitos': instance.requisitos?.map((e) => e.toJson()).toList(),
      'documentos': instance.documentos?.map((e) => e.toJson()).toList(),
      'editais': instance.editais?.map((e) => e.toJson()).toList(),
      'editalAtivo': instance.editalAtivo,
      'tipoBolsa': instance.tipoBolsa,
      'fotoId': instance.fotoId,
      'tipoInscricao': _$TipoInscricaoEnumMap[instance.tipoInscricao],
      'url': instance.url,
    };

const _$TipoInscricaoEnumMap = {
  TipoInscricao.INTERNA: 'INTERNA',
  TipoInscricao.EXTERNA: 'EXTERNA',
};
