import 'dart:io';

import 'package:app/config/constants.dart';
import 'package:app/model/aluno.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/user.dart';

class AuthService {
  final _http = Dio(
    BaseOptions(
      baseUrl: apiUrl,
      contentType: ContentType.json.value,
    ),
  );

  AuthService._internal();

  final _storage = const FlutterSecureStorage();

  static final _instance = AuthService._internal();

  String? _token;

  static AuthService get instance => _instance;

  Future<void> init() async {
    if (token == null) {
      _token = await _storage.read(key: 'token');
    }
  }

  Future<String> login(User user) async {
    final response = await _http.post('/auth/', data: user.toJson());
    _token = response.data['token'];

    if (_token == null) {
      return Future.error('Erro no login.');
    }

    _storage.write(key: "token", value: _token);

    return _token ?? '';
  }

  Future<void> logout() {
    _token = null;
    return _storage.delete(key: 'token');
  }

  String? get token => _token;

  bool loggedIn() => _token != null;

  Future<User> updateUser(User user) {
    return _http
        .put('/users/${user.id}',
            data: user.toJson(),
            options: Options(
              headers: {
                'Authorization': 'Bearer $token'
              },
            ))
        .then((value) => User.fromJson(value.data));
  }
}
