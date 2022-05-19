import 'package:app/components/empty_list.dart';
import 'package:flutter/material.dart';

class InscricoesList extends StatelessWidget {
  const InscricoesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EmptyList(message: 'Nenhuma inscrição realizada.');
  }
}
