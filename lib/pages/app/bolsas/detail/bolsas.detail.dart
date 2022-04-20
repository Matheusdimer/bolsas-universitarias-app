import 'package:app/components/badge.dart';
import 'package:app/components/future_tracker.dart';
import 'package:app/components/loading_detail.dart';
import 'package:app/components/text_views.dart';
import 'package:app/model/bolsa.dart';
import 'package:app/pages/app/bolsas/bolsas.service.dart';
import 'package:app/services/arquivos.service.dart';
import 'package:flutter/material.dart';

class BolsasDetail extends StatefulWidget {
  const BolsasDetail({Key? key}) : super(key: key);

  @override
  State<BolsasDetail> createState() => _BolsasDetailState();
}

class _BolsasDetailState extends State<BolsasDetail> {
  final _service = BolsasService();
  final _arquivoService = ArquivoService();

  _loadBolsa(int id) {
    return _service.find(id);
  }

  @override
  Widget build(BuildContext context) {
    final bolsa = ModalRoute.of(context)!.settings.arguments as Bolsa;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
        ),
        bottomNavigationBar: bolsa.editalAtivo == null
            ? Material(
              elevation: 10,
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      child: const Text('INSCREVER-SE'),
                      style: OutlinedButton.styleFrom(),
                      onPressed: () {},
                    ),
                  ),
                ),
            )
            : null,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (bolsa.fotoId != null)
                Image.network(
                  _arquivoService.getUrl(bolsa.fotoId),
                  fit: BoxFit.fitWidth,
                  height: 150,
                  width: double.infinity,
                ),
              FutureTracker<Bolsa>(
                future: _loadBolsa(bolsa.id),
                loading: const LoadingDetail(),
                completed: (bolsa) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextTitle(text: bolsa.nome),
                          Badge(
                            text: bolsa.editalAtivo == true
                                ? 'DISPONÍVEL'
                                : 'INDISPONÍVEL',
                            type: bolsa.editalAtivo == true
                                ? BadgeType.success
                                : BadgeType.error,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const TextNormalBold(text: 'Descrição'),
                      const SizedBox(height: 20),
                      TextNormal(text: bolsa.descricao),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextNormalBold(text: 'Tipo da bolsa'),
                          Badge(type: BadgeType.info, text: bolsa.tipoBolsa),
                        ],
                      ),
                      const CustomDivider(
                        height: 40,
                      ),
                      const TextSubTitle(text: 'Requisitos'),
                      const SizedBox(height: 20),
                      Column(
                        children: (bolsa.requisitos ?? [])
                            .map(
                              (requisito) => Padding(
                                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextTitle(text: '• '),
                                    Flexible(
                                      child: TextNormal(text: requisito.descricao),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ),
                error: (error) => Container(),
              ),
            ],
          ),
        ));
  }
}
