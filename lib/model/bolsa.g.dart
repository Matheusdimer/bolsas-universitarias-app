// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bolsa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bolsa _$BolsaFromJson(Map<String, dynamic> json) {
  return Bolsa(
    json['id'] as int?,
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
  )..fotoId = json['fotoId'] as int?;
}

Map<String, dynamic> _$BolsaToJson(Bolsa instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'descricao': instance.descricao,
      'requisitos': instance.requisitos,
      'documentos': instance.documentos,
      'editalAtivo': instance.editalAtivo,
      'tipoBolsa': instance.tipoBolsa,
      'fotoId': instance.fotoId,
    };
