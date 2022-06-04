import 'package:app/components/badge.dart';
import 'package:app/components/error_page.dart';
import 'package:app/components/future_tracker.dart';
import 'package:app/components/text_views.dart';
import 'package:app/model/inscricao.dart';
import 'package:app/pages/app/inscricoes/inscricao.service.dart';
import 'package:app/pages/app/inscricoes/inscricao_documento_card.dart';
import 'package:flutter/material.dart';

class InscricaoDetail extends StatefulWidget {
  const InscricaoDetail({Key? key}) : super(key: key);

  @override
  State<InscricaoDetail> createState() => _InscricaoDetailState();
}

class _InscricaoDetailState extends State<InscricaoDetail> {
  final _inscricaoService = InscricaoService();

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(title: const Text('Inscrição')),
      body: FutureTracker<Inscricao>(
        future: _inscricaoService.find(id),
        completed: (inscricao) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const TextNormalBold(text: 'Código: '),
                        Badge(
                          type: BadgeType.white,
                          text: inscricao.id!.toString(),
                        ),
                      ],
                    ),
                    Badge(
                      type: inscricao.situacao!.badge,
                      text: inscricao.situacao!.description,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const TextSubTitle(text: 'Observações'),
                const SizedBox(height: 10),
                TextNormal(text: inscricao.observacoes ?? '---'),
                const SizedBox(height: 20),
                const TextSubTitle(text: 'Documentos'),
                const SizedBox(height: 10),
                ...buildDocumentosList(inscricao)
              ],
            ),
          ),
        ),
        error: buildErrorPage(context),
      ),
    );
  }

  List<Widget> buildDocumentosList(Inscricao inscricao) {
    return List.generate(
      inscricao.documentos?.length ?? 0,
      (index) => InscricaoDocumentoCard(
        inscricaoDocumento: inscricao.documentos![index],
      ),
    );
  }
}
