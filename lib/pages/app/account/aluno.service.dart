import 'package:bolsas_universitarias/auth/auth.service.dart';
import 'package:bolsas_universitarias/config/constants.dart';
import 'package:bolsas_universitarias/config/dio-config.dart';
import 'package:bolsas_universitarias/model/aluno.dart';
import 'package:dio/dio.dart';

class AlunoService {
  static Aluno? _aluno;

  final _authService = AuthService.instance;
  final _http = HttpClient().client;
  final _path = '$apiUrl/alunos';

  Future<Aluno> findAluno() {
    return _http
        .get(
          '$_path/me',
          options: Options(headers: {
            'Authorization': 'Bearer ${_authService.token}',
          }),
        )
        .then((response) => Aluno.fromJson(response.data));
  }

  Future<Aluno> get aluno async {
    return _aluno = _aluno ?? await findAluno();
  }

  Future<Aluno> update(Aluno aluno) {
    return _http
        .put(
      '$_path/${aluno.id}',
      data: aluno.toJson(),
      options: Options(headers: {
        'Authorization': 'Bearer ${_authService.token}',
      }),
    ).then((value) async => _aluno = await findAluno());
  }

  void clearAluno() {
    _aluno = null;
  }
}
