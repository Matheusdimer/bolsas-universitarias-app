import 'package:app/auth/auth.service.dart';
import 'package:app/config/constants.dart';
import 'package:app/config/dio-config.dart';
import 'package:app/model/estado.dart';
import 'package:app/model/municipio.dart';
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
