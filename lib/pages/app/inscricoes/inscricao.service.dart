import 'package:bolsas_universitarias/auth/auth.service.dart';
import 'package:bolsas_universitarias/config/dio-config.dart';
import 'package:bolsas_universitarias/model/inscricao.dart';
import 'package:bolsas_universitarias/pages/app/account/aluno.service.dart';
import 'package:dio/dio.dart';

class InscricaoService {
  final Dio _http = HttpClient().client;
  final AuthService _authService = AuthService.instance;
  final AlunoService _alunoService = AlunoService();

  Future<List<Inscricao>> findAll() {
    return _alunoService.aluno.then((aluno) => _http
        .get<List>(
          '/inscricoes?idAluno=${aluno.id}',
          options: Options(
            headers: {'Authorization': 'Bearer ${_authService.token}'},
          ),
        )
        .then((response) =>
            response.data?.map(Inscricao.fromJson).toList() ?? []));
  }

  Future<Inscricao> find(int id) {
    return _http
        .get(
          '/inscricoes/$id',
          options: Options(
            headers: {'Authorization': 'Bearer ${_authService.token}'},
          ),
        )
        .then((response) => Inscricao.fromJson(response.data));
  }

  Future<Inscricao> save(Inscricao inscricao) {
    return _http
        .post(
          '/inscricoes',
          options: Options(
            headers: {'Authorization': 'Bearer ${_authService.token}'},
          ),
          data: inscricao.toJson(),
        )
        .then((response) => Inscricao.fromJson(response.data));
  }

  Future<Inscricao> update(Inscricao inscricao) {
    return _http
        .put(
      '/inscricoes/${inscricao.id}',
      options: Options(
        headers: {'Authorization': 'Bearer ${_authService.token}'},
      ),
      data: inscricao.toJson(),
    )
        .then((response) => Inscricao.fromJson(response.data));
  }
}
