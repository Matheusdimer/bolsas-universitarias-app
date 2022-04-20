import 'package:app/auth/auth.service.dart';
import 'package:app/config/constants.dart';
import 'package:app/config/dio-config.dart';
import 'package:app/model/arquivo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const Map<String, IconData> icons = {
  'pdf': Icons.picture_as_pdf,
  'jpeg': Icons.image,
  'jpg': Icons.image,
  'png': Icons.image,
  'doc': Icons.article_outlined,
  'docx': Icons.article_outlined,
  'ppt': Icons.slideshow,
  'pptx': Icons.slideshow,
};

class ArquivoService {
  final Dio _http = HttpClient().client;
  final AuthService _authService = AuthService.instance;

  String getUrl(int? id) {
    return '$apiUrl/arquivos/$id';
  }

  Future<Arquivo> getInfo(int id) {
    return _http
        .get(
          '${getUrl(id)}/info',
          options: Options(
            headers: {'Authorization': 'Bearer ${_authService.token}'},
          ),
        )
        .then((value) => Arquivo.fromJson(value.data));
  }

  IconData getIcon(String? extension) {
    const defaultIcon = Icons.insert_drive_file;

    if (extension == null) {
      return defaultIcon;
    }

    return icons[extension] ?? defaultIcon;
  }
}
