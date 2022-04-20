import 'package:app/auth/auth.service.dart';
import 'package:app/config/constants.dart';
import 'package:app/config/dio-config.dart';
import 'package:dio/dio.dart';

class ArquivoService {
  final Dio _http = HttpClient().client;
  final AuthService _authService = AuthService.instance;

  String getUrl(int? id) {
    return '$apiUrl/arquivos/$id';
  }
}
