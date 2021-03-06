import 'dart:io';
import 'dart:typed_data';

import 'package:bolsas_universitarias/auth/auth.service.dart';
import 'package:bolsas_universitarias/config/constants.dart';
import 'package:bolsas_universitarias/config/dio-config.dart';
import 'package:bolsas_universitarias/model/arquivo.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final String _path = '$apiUrl/arquivos';

  final Dio _http = HttpClient().client;
  final AuthService _authService = AuthService.instance;

  String getUrl(int? id) {
    return '$_path/$id';
  }

  Future<Arquivo> getInfo(int id) {
    return _http
        .get(
          '${getUrl(id)}/info',
          options: buildConfigurableCacheOptions(
            maxAge: const Duration(days: 5),
            options: Options(
              headers: {'Authorization': 'Bearer ${_authService.token}'},
            ),
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

  Future<OpenResult> download(
      {required Arquivo arquivo, ProgressCallback? progressCallback}) async {
    final url = getUrl(arquivo.id);

    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) return OpenResult();

    final directory = await getExternalStorageDirectory();

    if (directory == null) return OpenResult();

    final path = '${directory.path}/${arquivo.nome}';

    if (!File(path).existsSync()) {
      await _http.download(url, path, onReceiveProgress: progressCallback);
    }

    return OpenFile.open(path);
  }

  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

  Future<Arquivo> upload(Uint8List fileBytes, String name,
      ProgressCallback? progressCallback) async {
    final form = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        fileBytes,
        filename: name,
      )
    });
    return _http
        .post(_path, data: form, onSendProgress: progressCallback)
        .then((value) => Arquivo.fromJson(value.data));
  }

  Future<void> remove(int id) {
    return _http.delete(
      '$_path/$id',
      options: Options(
        headers: {'Authorization': 'Bearer ${_authService.token}'},
      ),
    );
  }
}
