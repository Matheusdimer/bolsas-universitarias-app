import 'dart:convert';
import 'dart:io';
import 'package:bolsas_universitarias/config/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class HttpClient {
  static final HttpClient _instance = HttpClient._internal();

  late Dio _http;

  factory HttpClient() => _instance;

  HttpClient._internal() {
    _http = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        contentType: ContentType.json.value,
      ),
    );
  }

  Dio get client => _http;

  dispose() {
    _http.close();
  }
}
