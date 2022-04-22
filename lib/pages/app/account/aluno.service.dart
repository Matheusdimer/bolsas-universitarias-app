import 'package:app/auth/auth.service.dart';
import 'package:app/config/constants.dart';
import 'package:app/config/dio-config.dart';
import 'package:app/model/aluno.dart';
import 'package:dio/dio.dart';

class AlunoService {
  final _authService = AuthService.instance;
  final _http = HttpClient().client;
  final _path = '$apiUrl/alunos';

  Future<Aluno> get aluno {
    return _http
        .get(
          '$_path/me',
          options: Options(headers: {
            'Authorization': 'Bearer ${_authService.token}',
          }),
        )
        .then((response) => Aluno.fromJson(response.data));
  }

  Future<Aluno> update(Aluno aluno) {
    return _http
        .put(
          '$_path/${aluno.id}',
          data: aluno.toJson(),
          options: Options(headers: {
            'Authorization': 'Bearer ${_authService.token}',
          }),
        )
        .then((value) => Aluno.fromJson(value.data));
  }
}
