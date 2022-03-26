import 'package:app/pages/app/bolsas/bolsas.service.dart';
import 'package:flutter/cupertino.dart';

import '../../login/auth.service.dart';

enum PageState { init, loading, success, error }

class BolsasController {
  final BolsasService service = BolsasService();
  final AuthService authService = AuthService();
  
  ValueNotifier<PageState> state = ValueNotifier(PageState.init);

  late Future<List<dynamic>> _bolsas;

  Future<List> get bolsas => _bolsas;

  Future<List> loadBolsas() {
    _bolsas = service.findAll();
    return _bolsas;
  }
}
