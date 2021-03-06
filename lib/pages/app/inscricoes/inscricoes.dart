import 'package:bolsas_universitarias/components/badge.dart';
import 'package:bolsas_universitarias/components/empty_list.dart';
import 'package:bolsas_universitarias/components/error_page.dart';
import 'package:bolsas_universitarias/components/future_tracker.dart';
import 'package:bolsas_universitarias/components/loading-list.dart';
import 'package:bolsas_universitarias/model/inscricao.dart';
import 'package:bolsas_universitarias/pages/app/inscricoes/inscricao.service.dart';
import 'package:bolsas_universitarias/pages/app/inscricoes/inscricao_info.dart';
import 'package:flutter/material.dart';

class InscricoesList extends StatefulWidget {
  const InscricoesList({Key? key}) : super(key: key);

  @override
  State<InscricoesList> createState() => _InscricoesListState();
}

class _InscricoesListState extends State<InscricoesList> {
  final _inscricaoService = InscricaoService();

  late Future<List<Inscricao>> _inscricoes;

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() {
    _inscricoes = _inscricaoService.findAll();
  }

  Future<List> reload() {
    setState(() => load());
    return _inscricoes;
  }

  void openDetail(Inscricao inscricao) async {
    final result = await Navigator.of(context).pushNamed(
      '/inscricao-detail',
      arguments: inscricao,
    );

    if (result == true) reload();
  }

  @override
  Widget build(BuildContext context) {
    return FutureTracker<List<Inscricao>>(
      future: _inscricoes,
      loading: const LoadingList(size: 8),
      error: buildErrorPage(context),
      completed: (inscricoes) => inscricoes.isNotEmpty
          ? RefreshIndicator(
              onRefresh: reload,
              child: ListView.builder(
                itemCount: inscricoes.length,
                itemBuilder: (context, index) {
                  final inscricao = inscricoes[index];
                  return Card(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: Badge.getColor(inscricao.situacao!.badge),
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () => openDetail(inscricao),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: InscricaoInfo(inscricao: inscricao),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : const EmptyList(message: 'Nenhuma inscri????o por aqui.'),
    );
  }
}
