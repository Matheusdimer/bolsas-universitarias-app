// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inscricao_documento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InscricaoDocumento _$InscricaoDocumentoFromJson(Map<String, dynamic> json) {
  return InscricaoDocumento(
    json['id'] as int?,
    Documento.fromJson(json['documento']),
    json['arquivoId'] as int?,
  );
}

Map<String, dynamic> _$InscricaoDocumentoToJson(InscricaoDocumento instance) =>
    <String, dynamic>{
      'id': instance.id,
      'documento': instance.documento,
      'arquivoId': instance.arquivoId,
    };
