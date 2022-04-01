import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  late String username;
  late String password;

  User(this.username, this.password);

  factory User.fromJson(final dynamic json) => _$UserFromJson(json);

  Map toJson() => _$UserToJson(this);
}