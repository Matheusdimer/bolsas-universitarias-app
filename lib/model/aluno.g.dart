// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aluno.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aluno _$AlunoFromJson(Map<String, dynamic> json) {
  return Aluno(
    json['id'] as int,
    json['nome'] as String,
    json['cpf'] as String,
    json['dataNascimento'] == null
        ? null
        : DateTime.parse(json['dataNascimento'] as String),
    json['usuario'] != null
        ? User.fromJson(json['usuario'])
        : User.login('', ''),
    json['email'] as String?,
    json['contato'] as String?,
    _$enumDecode(_$SexoEnumMap, json['sexo']),
    json['endereco'] == null ? null : Endereco.fromJson(json['endereco']),
  );
}

Map<String, dynamic> _$AlunoToJson(Aluno instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'cpf': instance.cpf,
      'dataNascimento': instance.dataNascimento?.toIso8601String(),
      'usuario': instance.usuario,
      'email': instance.email,
      'contato': instance.contato,
      'sexo': _$SexoEnumMap[instance.sexo],
      'endereco': instance.endereco,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$SexoEnumMap = {
  Sexo.MASCULINO: 'MASCULINO',
  Sexo.FEMININO: 'FEMININO',
};
