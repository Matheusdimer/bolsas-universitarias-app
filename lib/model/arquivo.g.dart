// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arquivo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Arquivo _$ArquivoFromJson(Map json) => Arquivo(
      json['id'] as int,
      json['nome'] as String,
      json['extensao'] as String,
      DateTime.parse(json['criadoEm'] as String),
      json['tipo'] as String,
    );

Map<String, dynamic> _$ArquivoToJson(Arquivo instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'extensao': instance.extensao,
      'criadoEm': instance.criadoEm.toIso8601String(),
      'tipo': instance.tipo,
    };
