// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Edital _$EditalFromJson(Map json) => Edital(
      json['id'] as int?,
      json['descricao'] as String,
      json['arquivoId'] as int?,
      DateTime.parse(json['dataInicio'] as String),
      DateTime.parse(json['dataFim'] as String),
      json['dataResultado'] == null
          ? null
          : DateTime.parse(json['dataResultado'] as String),
    );

Map<String, dynamic> _$EditalToJson(Edital instance) => <String, dynamic>{
      'id': instance.id,
      'descricao': instance.descricao,
      'arquivoId': instance.arquivoId,
      'dataInicio': instance.dataInicio.toIso8601String(),
      'dataFim': instance.dataFim.toIso8601String(),
      'dataResultado': instance.dataResultado?.toIso8601String(),
    };
