import 'package:bolsas_universitarias/auth/auth.service.dart';
import 'package:bolsas_universitarias/config/constants.dart';
import 'package:bolsas_universitarias/config/dio-config.dart';
import 'package:bolsas_universitarias/model/estado.dart';
import 'package:bolsas_universitarias/model/municipio.dart';
import 'package:dio/dio.dart';

class EnderecoService {
  static List<Estado> _estados = [];

  final _http = HttpClient().client;
  final _auth = AuthService.instance;
  final _path = '$apiUrl/enderecos';

  Future<List<Estado>> get estados async {
    if (_estados.isNotEmpty) return Future.value(_estados);

    return _estados = await _http
        .get(
          '$_path/estados',
          options: Options(headers: {
            'Authorization': 'Bearer ${_auth.token}',
          }),
        )
        .then((value) =>
            (value.data as List).map((e) => Estado.fromJson(e)).toList());
  }

  Future<List<Municipio>> getMunicipios({int? idEstado, String? filter}) {
    if (idEstado == null) {
      return Future.value([]);
    }

    return _http.get(
      '$_path/municipios/$idEstado',
      options: Options(headers: {
        'Authorization': 'Bearer ${_auth.token}',
      }),
      queryParameters: {'nome': filter ?? ''},
    ).then((value) =>
        (value.data as List).map((e) => Municipio.fromJson(e)).toList());
  }
}
