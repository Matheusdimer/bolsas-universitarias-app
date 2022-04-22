import 'package:app/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aluno.g.dart';

enum Sexo {
  MASCULINO, FEMININO
}

@JsonSerializable()
class Aluno {
  int id;
  String nome;
  String cpf;
  DateTime dataNascimento;
  User usuario;
  String? email;
  String? contato;
  Sexo sexo;

  Aluno(this.id, this.nome, this.cpf, this.dataNascimento, this.usuario,
      this.email, this.contato, this.sexo);

  factory Aluno.fromJson(final dynamic json) => _$AlunoFromJson(json);

  Map toJson() => _$AlunoToJson(this);


}
