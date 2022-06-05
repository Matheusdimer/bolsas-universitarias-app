import 'package:bolsas_universitarias/auth/auth.service.dart';
import 'package:bolsas_universitarias/config/dio-config.dart';
import 'package:bolsas_universitarias/model/bolsa.dart';
import 'package:dio/dio.dart';

enum TipoBolsa { federal, municipal, estadual, institucional }

class BolsasService {
  final Dio _http = HttpClient().client;
  final AuthService _authService = AuthService.instance;

  Future<List<Bolsa>> findAll() {
    return _http
        .get<List>(
          '/bolsas/',
          options: Options(
            headers: {'Authorization': 'Bearer ${_authService.token}'},
          ),
        )
        .then((response) =>
            response.data?.map((e) => Bolsa.fromJson(e)).toList() ?? []);
  }

  Future<Bolsa> find(int id) {
    return _http
        .get(
          '/bolsas/$id',
          options: Options(
            headers: {'Authorization': 'Bearer ${_authService.token}'},
          ),
        )
        .then((response) => Bolsa.fromJson(response.data));
  }
}
