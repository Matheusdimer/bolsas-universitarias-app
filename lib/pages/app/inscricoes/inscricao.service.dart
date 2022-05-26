import 'package:app/auth/auth.service.dart';
import 'package:app/config/dio-config.dart';
import 'package:app/model/inscricao.dart';
import 'package:dio/dio.dart';

class InscricaoService {
  final Dio _http = HttpClient().client;
  final AuthService _authService = AuthService.instance;

  Future<List<Inscricao>> findAll() {
    return _http
        .get<List>(
          '/inscricoes/',
          options: Options(
            headers: {'Authorization': 'Bearer ${_authService.token}'},
          ),
        )
        .then((response) =>
            response.data?.map((e) => Inscricao.fromJson(e)).toList() ?? []);
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
}
