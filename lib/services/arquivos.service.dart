import 'dart:typed_data';

import 'package:app/auth/auth.service.dart';
import 'package:app/config/constants.dart';
import 'package:app/config/dio-config.dart';
import 'package:app/model/arquivo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  Future download(
      {required Arquivo arquivo, ProgressCallback? progressCallback}) async {
    final url = getUrl(arquivo.id);

    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) return;

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/${arquivo.nome}';

    await _http.download(url, path, onReceiveProgress: progressCallback);

    OpenFile.open(path);
  }

  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

  Future<Arquivo> upload(XFile file, ProgressCallback? progressCallback) async {
    final form = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        await file.readAsBytes(),
        filename: file.name,
      )
    });
    return _http
        .post(_path, data: form, onSendProgress: progressCallback)
        .then((value) => Arquivo.fromJson(value.data));
  }
}
