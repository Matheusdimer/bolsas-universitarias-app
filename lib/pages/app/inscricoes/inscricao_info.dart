import 'package:bolsas_universitarias/components/badge.dart';
import 'package:bolsas_universitarias/components/icon_row.dart';
import 'package:bolsas_universitarias/components/text_views.dart';
import 'package:bolsas_universitarias/model/inscricao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InscricaoInfo extends StatelessWidget {
  final Inscricao inscricao;

  const InscricaoInfo({Key? key, required this.inscricao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Badge(
              type: BadgeType.white,
              text: inscricao.id.toString(),
            ),
            Badge(
              type: inscricao.situacao!.badge,
              text: inscricao.situacao!.description,
              style: BadgeStyle.status,
            )
          ],
        ),
        const SizedBox(height: 20),
        IconRow(
          icon: Icons.book_outlined,
          text:
          TextNormalBold(text: inscricao.bolsa.nome),
        ),
        const SizedBox(height: 5),
        IconRow(
          icon: Icons.access_time_outlined,
          text: TextNormal(
            text: 'Aberto em ' +
                DateFormat('dd/MM/yyyy \'às\' HH:mm')
                    .format(inscricao.dataCriacao!),
          ),
        ),
      ],
    );
  }
}
