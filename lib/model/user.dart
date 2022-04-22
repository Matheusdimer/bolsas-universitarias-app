import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String username;
  String password;
  int? fotoId;

  User.login(this.username, this.password);

  User(this.id, this.username, this.password, this.fotoId);

  factory User.fromJson(final dynamic json) => _$UserFromJson(json);

  Map toJson() => _$UserToJson(this);
}
