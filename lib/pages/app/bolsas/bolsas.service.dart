enum TipoBolsa { federal, municipal, estadual, institucional }

class BolsasService {
  Future<List<dynamic>> findAll() {
    var list = [
      {
        'id': 1,
        'nome': 'ProUni',
        'descricao': 'Essa bolsa é muito legal',
        'tipo': TipoBolsa.federal,
        'editalAtivo': true
      },
      {
        'id': 2,
        'nome': 'Bolsa PMC',
        'descricao': 'Essa bolsa é muito legal',
        'tipo': TipoBolsa.municipal,
        'editalAtivo': true
      },
      {
        'id': 3,
        'nome': 'UNIEDU',
        'descricao': 'Essa bolsa é muito legal',
        'tipo': TipoBolsa.estadual,
        'editalAtivo': false
      }
    ];

    return Future.delayed(
      const Duration(seconds: 2),
      () => list,
    );
  }
}
