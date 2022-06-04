import 'package:app/components/badge.dart';
import 'package:app/components/empty_list.dart';
import 'package:app/components/error_page.dart';
import 'package:app/components/future_tracker.dart';
import 'package:app/components/loading-list.dart';
import 'package:app/components/text_views.dart';
import 'package:app/model/inscricao.dart';
import 'package:app/pages/app/inscricoes/inscricao.service.dart';
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
    _inscricoes = _inscricaoService.findAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureTracker<List<Inscricao>>(
      future: _inscricoes,
      loading: const LoadingList(size: 8),
      error: buildErrorPage(context),
      completed: (inscricoes) => inscricoes.isNotEmpty
          ? ListView.builder(
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
                  onTap: () {
                    Navigator.of(context).pushNamed('/inscricao-detail',
                        arguments: inscricao.id);
                  },
                );
              },
            )
          : const EmptyList(message: 'Nenhuma inscrição por aqui.'),
    );
  }
}
