import 'package:app/components/error_page.dart';
import 'package:app/components/future_tracker.dart';
import 'package:app/components/loading-list.dart';
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
                fit: BoxFit.fitWidth,
                height: 150,
                width: double.infinity,
              ),
            ExpansionTile(
              title: Text(
                bolsa.nome,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Badge(
                text: bolsa.editalAtivo == true ? 'DISPONÍVEL' : 'INDISPONÍVEL',
                type: bolsa.editalAtivo == true
                    ? BadgeType.success
                    : BadgeType.error,
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
      loading: const Center(
        child: LoadingList(
          size: 8,
          hasImage: true,
        ),
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

enum BadgeType { error, warn, success, info, white }

class Badge extends StatelessWidget {
  final String text;
  final BadgeType type;

  const Badge({
    Key? key,
    required this.type,
    required this.text,
  }) : super(key: key);

  MaterialColor getColor() {
    switch (type) {
      case BadgeType.error:
        return Colors.red;
      case BadgeType.success:
        return Colors.green;
      case BadgeType.warn:
        return Colors.yellow;
      case BadgeType.info:
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    var color = getColor();

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color.withOpacity(0.3),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}