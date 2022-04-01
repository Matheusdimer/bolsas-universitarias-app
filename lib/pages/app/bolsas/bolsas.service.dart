import 'package:app/auth/auth.service.dart';
import 'package:app/config/dio-config.dart';
import 'package:dio/dio.dart';

enum TipoBolsa { federal, municipal, estadual, institucional }

class BolsasService {
  final Dio _http = HttpClient().client;
  final AuthService _authService = AuthService.instance;

  Future<List> findAll() {
    return _http
        .get<List>(
          'bolsas/',
          options: Options(
            headers: {'Authorization': 'Bearer ${_authService.token}'},
          ),
        )
        .then((response) => response.data ?? []);
  }
}
