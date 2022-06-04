// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aluno.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aluno _$AlunoFromJson(Map json) => Aluno(
      json['id'] as int,
      json['nome'] as String,
      json['cpf'] as String,
      json['dataNascimento'] == null
          ? null
          : DateTime.parse(json['dataNascimento'] as String),
      json['usuario'] == null ? null : User.fromJson(json['usuario']),
      json['email'] as String?,
      json['contato'] as String?,
      $enumDecode(_$SexoEnumMap, json['sexo']),
      json['endereco'] == null ? null : Endereco.fromJson(json['endereco']),
    );

Map<String, dynamic> _$AlunoToJson(Aluno instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'cpf': instance.cpf,
      'dataNascimento': instance.dataNascimento?.toIso8601String(),
      'usuario': instance.usuario?.toJson(),
      'email': instance.email,
      'contato': instance.contato,
      'sexo': _$SexoEnumMap[instance.sexo],
      'endereco': instance.endereco?.toJson(),
    };

const _$SexoEnumMap = {
  Sexo.MASCULINO: 'MASCULINO',
  Sexo.FEMININO: 'FEMININO',
};
