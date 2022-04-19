// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Documento _$DocumentoFromJson(Map<String, dynamic> json) {
  return Documento(
    json['id'] as int?,
    json['nome'] as String,
    DateTime.parse(json['dataCriacao'] as String),
    json['arquivoId'] as int?,
  );
}

Map<String, dynamic> _$DocumentoToJson(Documento instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'dataCriacao': instance.dataCriacao.toIso8601String(),
      'arquivoId': instance.arquivoId,
    };
