import 'package:app/components/file_card.dart';
import 'package:app/components/text_views.dart';
import 'package:app/model/edital.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditalTile extends StatelessWidget {
  EditalTile({
    Key? key,
    required this.edital,
  }) : super(key: key);

  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  final Edital edital;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextNormalBold(text: 'Data de início'),
                    TextNormal(
                      text: dateFormatter.format(edital.dataInicio),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextNormalBold(text: 'Data final'),
                    TextNormal(
                      text: dateFormatter.format(edital.dataFim),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextNormalBold(
                          text: 'Data de divulgação do resultado'),
                      TextNormal(
                        text: edital.dataResultado != null
                            ? dateFormatter.format(edital.dataResultado!)
                            : '---',
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextNormalBold(text: 'Descrição'),
                      TextNormal(text: edital.descricao)
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (edital.arquivoId != null)
          FileCard(id: edital.arquivoId!, description: 'Documento do edital'),
      ],
    );
  }
}
