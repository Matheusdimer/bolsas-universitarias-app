import 'package:bolsas_universitarias/components/badge.dart';
import 'package:bolsas_universitarias/model/edital.dart';
import 'package:bolsas_universitarias/pages/app/bolsas/edital_tile.dart';
import 'package:flutter/material.dart';

class EditaisPage extends StatelessWidget {
  const EditaisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editais =
        ModalRoute.of(context)!.settings.arguments as List<Edital>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editais'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: ListView.builder(
          itemCount: editais.length,
          itemBuilder: (context, index) => Card(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 3,
                    color: Badge.getColor(
                      editais[index].atual
                          ? BadgeType.success
                          : BadgeType.error,
                    ),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: EditalTile(edital: editais[index], flat: true),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
