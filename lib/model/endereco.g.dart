// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endereco.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Endereco _$EnderecoFromJson(Map json) => Endereco(
      json['id'] as int?,
      json['logradouro'] as String?,
      json['bairro'] as String?,
      json['cep'] as String?,
      json['municipio'] == null ? null : Municipio.fromJson(json['municipio']),
      json['complemento'] as String?,
      json['numero'] as String?,
    );

Map<String, dynamic> _$EnderecoToJson(Endereco instance) => <String, dynamic>{
      'id': instance.id,
      'logradouro': instance.logradouro,
      'bairro': instance.bairro,
      'cep': instance.cep,
      'municipio': instance.municipio?.toJson(),
      'complemento': instance.complemento,
      'numero': instance.numero,
    };
