import 'package:app/components/badge.dart';
import 'package:app/components/error_page.dart';
import 'package:app/components/future_tracker.dart';
import 'package:app/components/loading-list.dart';
import 'package:app/components/loading-tile.dart';
import 'package:app/config/constants.dart';
import 'package:app/model/bolsa.dart';
import 'package:app/pages/app/bolsas/bolsas.service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../components/empty_list.dart';

class BolsasList extends StatefulWidget {
  const BolsasList({Key? key}) : super(key: key);

  @override
  State<BolsasList> createState() => _BolsasListState();
}

class _BolsasListState extends State<BolsasList> {
  final _service = BolsasService();

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

  _openDetails(int? id) {
    Navigator.of(context).pushNamed('/details', arguments: id);
  }

  Widget _buildItem(final Bolsa bolsa) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () => _openDetails(bolsa.id),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bolsa.fotoId != null)
              Image.network(
                '$apiUrl/arquivos/${bolsa.fotoId}',
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
                    const Text(
                      'Tipo da bolsa',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Badge(type: BadgeType.info, text: bolsa.tipoBolsa),
                  ],
                )
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: bolsa.editalAtivo == true ? () {} : null,
                  child: const Text('INSCREVER-SE'),
                ),
                TextButton(
                  onPressed: () => _openDetails(bolsa.id),
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
                padding: const EdgeInsets.all(8.0),
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
      error: (error) {
        if (error is DioError) {
          if (error.response?.statusCode == 401) {
            SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
              Navigator.of(context).popAndPushNamed('/login');
            });
          } else {
            return ErrorPage(error: error.message);
          }
        }
        return ErrorPage(error: error.toString());
      },
    );
  }
}
