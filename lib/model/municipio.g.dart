// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'municipio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Municipio _$MunicipioFromJson(Map<String, dynamic> json) {
  return Municipio(
    json['id'] as int,
    json['nome'] as String,
    json['estado'] == null ? null : Estado.fromJson(json['estado']),
  );
}

Map<String, dynamic> _$MunicipioToJson(Municipio instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'estado': instance.estado,
    };
