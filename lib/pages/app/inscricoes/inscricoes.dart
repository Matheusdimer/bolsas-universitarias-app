import 'package:bolsas_universitarias/components/badge.dart';
import 'package:bolsas_universitarias/components/empty_list.dart';
import 'package:bolsas_universitarias/components/error_page.dart';
import 'package:bolsas_universitarias/components/future_tracker.dart';
import 'package:bolsas_universitarias/components/loading-list.dart';
import 'package:bolsas_universitarias/components/text_views.dart';
import 'package:bolsas_universitarias/model/inscricao.dart';
import 'package:bolsas_universitarias/pages/app/inscricoes/inscricao.service.dart';
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
                  return ListTile(
                    title: TextNormalBold(text: inscricao.bolsa.nome),
                    subtitle: TextNormal(text: inscricao.aluno.nome),
                    leading: SizedBox(
                      height: 50,
                      width: 30,
                      child: Center(
                          child: TextNormal(text: inscricao.id.toString())),
                    ),
                    trailing: Badge(
                      type: inscricao.situacao!.badge,
                      text: inscricao.situacao!.description,
                    ),
                    onTap: () => openDetail(inscricao),
                  );
                },
              ),
            )
          : const EmptyList(message: 'Nenhuma inscrição por aqui.'),
    );
  }
}
