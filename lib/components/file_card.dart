import 'package:app/components/loading-list.dart';
import 'package:app/components/loading-tile.dart';
import 'package:app/components/text_views.dart';
import 'package:app/model/arquivo.dart';
import 'package:app/services/arquivos.service.dart';
import 'package:flutter/material.dart';

enum FileCardType { grid, list }

class FileCard extends StatefulWidget {
  final int id;
  final String description;
  final FileCardType type;

  const FileCard(
      {Key? key,
      required this.id,
      required this.description,
      this.type = FileCardType.list})
      : super(key: key);

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  final _service = ArquivoService();

  Arquivo? arquivo;

  @override
  void initState() {
    super.initState();

    _service.getInfo(widget.id).then((value) => setState(() {
          arquivo = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {},
        child: widget.type == FileCardType.grid
            ? buildGridCard()
            : ListTile(
                title: TextSmallBold(
                  text: widget.description,
                ),
                subtitle: buildSubtitle(),
                leading: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    height: double.infinity,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.shade200
                    ),
                    child: Icon(
                      _service.getIcon(arquivo?.extensao),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Column buildGridCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 110,
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: Center(
              child: Icon(
                _service.getIcon(arquivo?.extensao),
                size: 35,
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
