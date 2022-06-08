import 'package:bolsas_universitarias/auth/auth.service.dart';
import 'package:bolsas_universitarias/config/constants.dart';
import 'package:bolsas_universitarias/config/dio-config.dart';
import 'package:bolsas_universitarias/model/estado.dart';
import 'package:bolsas_universitarias/model/municipio.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class EnderecoService {
  final _http = HttpClient().client;
  final _auth = AuthService.instance;
  final _path = '$apiUrl/enderecos';

  Future<List<Estado>> get estados {
    return _http
        .get(
          '$_path/estados',
          options: buildConfigurableCacheOptions(
            options: Options(headers: {
              'Authorization': 'Bearer ${_auth.token}',
            }),
            maxAge: const Duration(days: 15),
          ),
        )
        .then((value) =>
            (value.data as List).map(Estado.fromJson).toList());
  }

  Future<List<Municipio>> getMunicipios({int? idEstado, String? filter}) {
    if (idEstado == null) {
      return Future.value([]);
    }

    return _http.get(
      '$_path/municipios/$idEstado',
      options: buildConfigurableCacheOptions(
        options: Options(headers: {
          'Authorization': 'Bearer ${_auth.token}',
        }),
        maxAge: const Duration(days: 5),
      ),
      queryParameters: {'nome': filter ?? ''},
    ).then((value) =>
        (value.data as List).map(Municipio.fromJson).toList());
  }
}
