import 'package:app/components/empty_list.dart';
import 'package:flutter/material.dart';

class CandidaturasList extends StatelessWidget {
  const CandidaturasList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EmptyList(message: 'Nenhuma inscrição realizada.');
  }
}
