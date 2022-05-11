// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estado.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Estado _$EstadoFromJson(Map<String, dynamic> json) {
  return Estado(
    json['id'] as int,
    json['nome'] as String,
    json['sigla'] as String,
  );
}

Map<String, dynamic> _$EstadoToJson(Estado instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'sigla': instance.sigla,
    };
