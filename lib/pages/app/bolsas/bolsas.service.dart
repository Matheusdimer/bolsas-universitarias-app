import 'package:app/auth/auth.service.dart';
import 'package:app/config/dio-config.dart';
import 'package:app/model/bolsa.dart';
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
        .then((response) => response.data?.map((e) => Bolsa.fromJson(e)).toList() ?? []);
  }
}
