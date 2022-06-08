import 'package:bolsas_universitarias/components/loading-list.dart';
import 'package:bolsas_universitarias/components/loading-tile.dart';
import 'package:bolsas_universitarias/components/text_views.dart';
import 'package:bolsas_universitarias/model/arquivo.dart';
import 'package:bolsas_universitarias/services/arquivos.service.dart';
import 'package:bolsas_universitarias/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

enum FileCardType { grid, list }

class FileCard extends StatefulWidget {
  final int id;
  final String description;
  final FileCardType type;
  final bool flat;

  const FileCard({
    Key? key,
    required this.id,
    required this.description,
    this.type = FileCardType.list,
    this.flat = false,
  }) : super(key: key);

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  final _service = ArquivoService();

  Arquivo? arquivo;

  double? downloadProgress;

  @override
  void initState() {
    super.initState();

    _service
        .getInfo(widget.id)
        .then((value) => setState(() => arquivo = value));
  }

  _download() async {
    if (arquivo == null) return;

    final openResult = await _service.download(
      arquivo: arquivo!,
      progressCallback: _downloadCallback,
    );

    if (openResult.type == ResultType.noAppToOpen) {
      showSnackBar(context,
          'Você não possui nenhum app instalado para abrir esse tipo arquivo.');
    }

    setState(() {
      downloadProgress = null;
    });
  }

  void _downloadCallback(received, total) {
    setState(() {
      downloadProgress = received / total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: widget.flat ? 0 : null,
      child: InkWell(
          onTap: _download,
          child: Container(
            decoration: widget.flat
                ? BoxDecoration(
                    border: Border.all(color: const Color(0xDDDDDDDD)),
                    borderRadius: const BorderRadius.all(Radius.circular(4)))
                : null,
            child: widget.type == FileCardType.grid
                ? buildGridCard()
                : ListTile(
                    title: TextSmallBold(
                      text: widget.description,
                    ),
                    subtitle: buildSubtitle(),
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Container(
                        height: double.infinity,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey.shade200),
                        child: downloadProgress == null
                            ? Icon(
                                _service.getIcon(arquivo?.extensao),
                              )
                            : CircularProgressIndicator(
                                value: downloadProgress,
                              ),
                      ),
                    ),
                  ),
          )),
    );
  }

  Column buildGridCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: Center(
              child: downloadProgress == null
                  ? Icon(
                      _service.getIcon(arquivo?.extensao),
                    )
                  : CircularProgressIndicator(
                      value: downloadProgress,
                    ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextSmallBold(
                  text: widget.description,
                ),
                buildSubtitle()
              ],
            ),
          ),
        )
      ],
    );
  }

  StatelessWidget buildSubtitle() {
    return arquivo != null
        ? TextSmallWeak(
            text: arquivo!.nome,
            size: 10,
          )
        : const CustomShimmer(
            child: LoadingTile(
              height: 14,
            ),
          );
  }
}
