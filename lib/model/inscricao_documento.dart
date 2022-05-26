import 'package:app/model/documento.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inscricao_documento.g.dart';

@JsonSerializable()
class InscricaoDocumento {
  int? id;
  Documento documento;
  int? arquivoId;

  InscricaoDocumento(this.id, this.documento, this.arquivoId);

  InscricaoDocumento.fromDocumento(this.documento);

  factory InscricaoDocumento.fromJson(final dynamic json) => _$InscricaoDocumentoFromJson(json);

  Map toJson() => _$InscricaoDocumentoToJson(this);
}
