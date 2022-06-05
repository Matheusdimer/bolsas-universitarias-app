import 'package:bolsas_universitarias/components/badge.dart';
import 'package:bolsas_universitarias/components/error_page.dart';
import 'package:bolsas_universitarias/components/file_card.dart';
import 'package:bolsas_universitarias/components/future_tracker.dart';
import 'package:bolsas_universitarias/components/loading_detail.dart';
import 'package:bolsas_universitarias/components/text_views.dart';
import 'package:bolsas_universitarias/model/bolsa.dart';
import 'package:bolsas_universitarias/pages/app/bolsas/bolsas.service.dart';
import 'package:bolsas_universitarias/services/arquivos.service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  _openInscricao(Bolsa bolsa) {
    if (bolsa.tipoInscricao == TipoInscricao.EXTERNA && bolsa.url != null) {
      final url = Uri.parse(bolsa.url!);
      launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Navigator.of(context).pushNamed('/inscrever-se', arguments: bolsa.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bolsa = ModalRoute.of(context)!.settings.arguments as Bolsa;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
        ),
        bottomNavigationBar: bolsa.editalAtivo
            ? Material(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      child: const Text('INSCREVER-SE'),
                      onPressed: () => _openInscricao(bolsa),
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
                            text: bolsa.editalAtivo
                                ? 'DISPONÍVEL'
                                : 'INDISPONÍVEL',
                            type: bolsa.editalAtivo
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
                      if (bolsa.requisitos != null &&
                          bolsa.requisitos!.isNotEmpty)
                        Column(
                          children: bolsa.requisitos!
                              .map(
                                (requisito) => Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 8, left: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TextTitle(text: '• '),
                                      Flexible(
                                        child: TextNormal(
                                            text: requisito.descricao),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      else
                        const Center(
                          child: TextNormal(
                              text: "Nenhum requisito por aqui."),
                        ),
                      const CustomDivider(
                        height: 40,
                      ),
                      const TextSubTitle(text: 'Documentos'),
                      const SizedBox(height: 20),
                      if (bolsa.documentos != null &&
                          (bolsa.documentos as List).isNotEmpty)
                        GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            children: (bolsa.documentos ?? [])
                                .map(
                                  (documento) => FileCard(
                                    id: documento.arquivoId as int,
                                    description: documento.nome,
                                    type: FileCardType.grid,
                                  ),
                                )
                                .toList())
                      else
                        const Center(
                          child: TextNormal(text: 'Nenhum documento por aqui.'),
                        )
                    ],
                  ),
                ),
                error: buildErrorPage(context),
              ),
            ],
          ),
        ));
  }
}
