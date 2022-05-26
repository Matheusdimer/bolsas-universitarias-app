import 'dart:io';

import 'package:app/components/future_tracker.dart';
import 'package:app/components/text_views.dart';
import 'package:app/model/arquivo.dart';
import 'package:app/model/inscricao_documento.dart';
import 'package:app/services/arquivos.service.dart';
import 'package:app/utils/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class InscricaoDocumentoCard extends StatefulWidget {
  final InscricaoDocumento inscricaoDocumento;

  const InscricaoDocumentoCard({Key? key, required this.inscricaoDocumento})
      : super(key: key);

  @override
  State<InscricaoDocumentoCard> createState() => _InscricaoDocumentoCardState();
}

class _InscricaoDocumentoCardState extends State<InscricaoDocumentoCard> {
  final _arquivoService = ArquivoService();

  Future<void>? _upload;
  Arquivo? arquivo;

  late InscricaoDocumento inscricaoDocumento;

  @override
  void initState() {
    inscricaoDocumento = widget.inscricaoDocumento;
    super.initState();
  }

  void uploadAnexo() async {
    final files =
        await FilePicker.platform.pickFiles(dialogTitle: 'Escolher anexo');

    if (files != null && files.count > 1) {
      final snackBar = buildSnackBar('Só é permitido anexar um arquivo por documento.');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    final platformFile = files!.files.single;
    final file = File(platformFile.path!);

    upload = _arquivoService
        .upload(await file.readAsBytes(), platformFile.name, (count, total) {})
        .then(setArquivo);
  }

  void setArquivo(Arquivo arquivo) {
    setState(() {
      this.arquivo = arquivo;
      inscricaoDocumento.arquivoId = arquivo.id;
    });
  }

  set upload(Future<void> future) {
    setState(() {
      _upload = future;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextNormalBold(
                  text: inscricaoDocumento.documento.nome,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextNormal(
                  text: arquivo?.nome ?? '---',
                )
              ],
            ),
            FutureTracker<void>(
              future: _upload,
              loading: const CircularProgressIndicator(),
              completed: (value) => IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: uploadAnexo,
              ),
            )
          ],
        ),
      ),
    );
  }
}
