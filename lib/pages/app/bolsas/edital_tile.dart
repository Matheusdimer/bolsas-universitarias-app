import 'package:bolsas_universitarias/components/badge.dart';
import 'package:bolsas_universitarias/components/file_card.dart';
import 'package:bolsas_universitarias/components/text_views.dart';
import 'package:bolsas_universitarias/model/edital.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditalTile extends StatelessWidget {
  EditalTile({
    Key? key,
    required this.edital,
    this.flat = false,
  }) : super(key: key);

  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  final Edital edital;
  final bool flat;

  @override
  Widget build(BuildContext context) {
    final isAtual = edital.atual;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Badge(type: BadgeType.white, text: edital.id!.toString()),
                      const SizedBox(width: 10),
                      TextNormalBold(text: edital.descricao),
                    ],
                  ),
                  Badge(
                    type: isAtual ? BadgeType.success : BadgeType.error,
                    text: isAtual ? 'Aberto' : 'Fechado',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
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
              const SizedBox(height: 10),
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
            ],
          ),
        ),
        const SizedBox(height: 10),
        if (edital.arquivoId != null)
          FileCard(
            id: edital.arquivoId!,
            description: 'Documento do edital',
            flat: flat,
          ),
      ],
    );
  }
}
