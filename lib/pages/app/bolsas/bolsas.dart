import 'package:bolsas_universitarias/components/badge.dart';
import 'package:bolsas_universitarias/components/error_page.dart';
import 'package:bolsas_universitarias/components/future_tracker.dart';
import 'package:bolsas_universitarias/components/loading-list.dart';
import 'package:bolsas_universitarias/components/loading-tile.dart';
import 'package:bolsas_universitarias/components/text_views.dart';
import 'package:bolsas_universitarias/model/bolsa.dart';
import 'package:bolsas_universitarias/pages/app/bolsas/bolsas.service.dart';
import 'package:bolsas_universitarias/services/arquivos.service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/empty_list.dart';

class BolsasList extends StatefulWidget {
  const BolsasList({Key? key}) : super(key: key);

  @override
  State<BolsasList> createState() => _BolsasListState();
}

class _BolsasListState extends State<BolsasList> {
  final _service = BolsasService();
  final _arquivoService = ArquivoService();

  late Future<List<Bolsa>> bolsas;

  @override
  void initState() {
    _load();
    super.initState();
  }

  Future<List<Bolsa>> _load() {
    setState(() {
      bolsas = _service.findAll();
    });
    return bolsas;
  }

  _openDetails(Bolsa bolsa) {
    Navigator.of(context).pushNamed('/details', arguments: bolsa);
  }

  _openInscricao(Bolsa bolsa) {
    if (bolsa.tipoInscricao == TipoInscricao.EXTERNA && bolsa.url != null) {
      final url = Uri.parse(bolsa.url!);
      launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Navigator.of(context).pushNamed('/inscrever-se', arguments: bolsa.id);
    }
  }

  Widget _buildItem(final Bolsa bolsa) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () => _openDetails(bolsa),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bolsa.fotoId != null)
              Image.network(
                _arquivoService.getUrl(bolsa.fotoId),
                key: Key(bolsa.fotoId.toString()),
                fit: BoxFit.fitWidth,
                height: 150,
                width: double.infinity,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CustomShimmer(
                    child: LoadingTile(
                      width: double.infinity,
                      height: 150,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                  );
                },
              ),
            ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bolsa.nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
              initiallyExpanded: true,
              childrenPadding: const EdgeInsets.all(16),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bolsa.descricao,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextSmallBold(text: 'Tipo da bolsa'),
                    Badge(type: BadgeType.info, text: bolsa.tipoBolsa),
                  ],
                ),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: bolsa.editalAtivo ? () => _openInscricao(bolsa) : null,
                  child: const Text('INSCREVER-SE'),
                ),
                TextButton(
                  onPressed: () => _openDetails(bolsa),
                  child: const Text('VER DETALHES'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureTracker<List<Bolsa>>(
      future: _load(),
      completed: (bolsas) => RefreshIndicator(
        onRefresh: _load,
        child: bolsas.isEmpty
            ? const EmptyList(
                message: 'Nenhuma bolsa disponível.',
              )
            : Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ListView.builder(
                  itemBuilder: (context, index) => _buildItem(bolsas[index]),
                  itemCount: bolsas.length,
                ),
              ),
      ),
      loading: const LoadingCardList(
        size: 2,
        hasImage: true,
      ),
      error: buildErrorPage(context),
    );
  }
}
