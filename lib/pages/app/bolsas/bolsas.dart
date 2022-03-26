import 'package:app/components/loading-list.dart';
import 'package:app/pages/app/bolsas/bolsas.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class BolsasList extends StatefulWidget {
  const BolsasList({Key? key}) : super(key: key);

  @override
  State<BolsasList> createState() => _BolsasListState();
}

class _BolsasListState extends State<BolsasList> {
  final controller = BolsasController();

  @override
  void initState() {
    controller.loadBolsas();
    super.initState();
  }

  void _redirectLogin () {
    final logged = ModalRoute.of(context)!.settings.arguments;

    if (logged != null && logged as bool == true) return;

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.of(context).popAndPushNamed('/login');
    });
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
      onTap: () { },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: controller.bolsas,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final bolsas = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: controller.loadBolsas,
            child: ListView.builder(
              itemBuilder: (context, index) => _buildItem(bolsas[index]),
              itemCount: bolsas.length,
            ),
          );
        } else if (snapshot.hasError) {
          _redirectLogin();
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
