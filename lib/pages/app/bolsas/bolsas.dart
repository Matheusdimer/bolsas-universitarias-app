import 'package:app/components/error_page.dart';
import 'package:app/components/loading-list.dart';
import 'package:app/pages/app/bolsas/bolsas.service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class BolsasList extends StatefulWidget {
  const BolsasList({Key? key}) : super(key: key);

  @override
  State<BolsasList> createState() => _BolsasListState();
}

class _BolsasListState extends State<BolsasList> {
  final _service = BolsasService();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildItem(final dynamic bolsa) {
    return ListTile(
      title: Text(bolsa['nome']),
      subtitle: Text(bolsa['descricao']),
      leading: const Icon(
        Icons.image,
        size: 40,
      ),
      trailing: PopupMenuButton(
        icon: const Icon(Icons.more_vert_outlined),
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(
            child: Text("Inscrever-se"),
          )
        ],
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _service.findAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final bolsas = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: () => _service.findAll(),
            child: ListView.builder(
              itemBuilder: (context, index) => _buildItem(bolsas[index]),
              itemCount: bolsas.length,
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);

          if (snapshot.error is DioError) {
            final error = snapshot.error as DioError;

            if (error.response?.statusCode == 401) {
              SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
                Navigator.of(context).popAndPushNamed('/login');
              });
            }
          } else {
            return ErrorPage(error: snapshot.error.toString());
          }
        }

        return const Center(
          child: LoadingList(
            size: 8,
            hasImage: true,
          ),
        );
      },
    );
  }
}
