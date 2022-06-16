import 'package:bolsas_universitarias/components/alert_dialog.dart';
import 'package:bolsas_universitarias/components/error_page.dart';
import 'package:bolsas_universitarias/components/file_card.dart';
import 'package:bolsas_universitarias/components/future_tracker.dart';
import 'package:bolsas_universitarias/components/loading_detail.dart';
import 'package:bolsas_universitarias/components/spinner.dart';
import 'package:bolsas_universitarias/components/text_views.dart';
import 'package:bolsas_universitarias/model/endereco.dart';
import 'package:bolsas_universitarias/model/inscricao.dart';
import 'package:bolsas_universitarias/model/inscricao_documento.dart';
import 'package:bolsas_universitarias/pages/app/account/aluno.service.dart';
import 'package:bolsas_universitarias/pages/app/bolsas/bolsas.service.dart';
import 'package:bolsas_universitarias/pages/app/bolsas/edital_tile.dart';
import 'package:bolsas_universitarias/pages/app/forms/aluno-form.dart';
import 'package:bolsas_universitarias/pages/app/forms/endereco-form.dart';
import 'package:bolsas_universitarias/pages/app/inscricoes/inscricao.service.dart';
import 'package:bolsas_universitarias/pages/app/inscricoes/inscricao_documento_card.dart';
import 'package:bolsas_universitarias/utils/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class InscricaoPage extends StatefulWidget {
  const InscricaoPage({Key? key}) : super(key: key);

  @override
  State<InscricaoPage> createState() => _InscricaoPageState();
}

class _InscricaoPageState extends State<InscricaoPage> {
  final _alunoService = AlunoService();
  final _bolsasService = BolsasService();
  final _inscricaoService = InscricaoService();

  bool initialized = false;

  Future<Inscricao>? inscricao;
  Future<void>? _saveFuture;

  final dateFormater = DateFormat('dd/MM/yyyy');

  Future<Inscricao> buildInscricao() async {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    final bolsa = await _bolsasService.find(id);
    final aluno = await _alunoService.aluno;

    aluno.endereco ??= Endereco.empty();

    initialized = true;

    final documentos =
        bolsa.documentos?.map(InscricaoDocumento.fromDocumento).toList();

    return Inscricao.fromBolsa(bolsa, documentos ?? [], aluno);
  }

  void save(Inscricao inscricao) {
    showAlertDialog(
      context: context,
      title: 'Atenção',
      message: 'Certifique-se de ter revisado todos os dados. '
          'Deseja continuar com a inscrição?',
      confirm: () => saveInscricao(inscricao),
    );
  }

  void saveInscricao(Inscricao inscricao) {
    Navigator.of(context).pop();
    inscricao.dataCriacao = DateTime.now();

    saveFuture = _alunoService
        .update(inscricao.aluno)
        .then((value) => _inscricaoService.save(inscricao))
        .then((value) {
      Navigator.of(context).pop();
      showSnackBar(context, 'Inscrição realizada com sucesso.');
      Navigator.of(context).pop();
    });
  }

  set saveFuture(Future<void> future) {
    setState(() {
      _saveFuture = future;
    });
  }

  void showError(error) {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      final message = error is DioError
          ? error.response?.data['message'] ?? error.message
          : error.toString();
      showSnackBar(context, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) inscricao = buildInscricao();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Inscrever-se"),
        ),
        body: FutureTracker<Inscricao>(
          future: inscricao!,
          loading: const LoadingDetail(),
          error: buildErrorPage(context),
          completed: (inscricao) {
            final edital = inscricao.bolsa.editalAtual;
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (edital != null)
                    ExpandableGroup(
                      title: 'Edital atual',
                      initiallyExpanded: true,
                      children: [EditalTile(edital: edital)],
                    ),
                  ExpandableGroup(
                    title: 'Dados do aluno',
                    initiallyExpanded: true,
                    children: [AlunoForm(aluno: inscricao.aluno)],
                  ),
                  ExpandableGroup(
                    title: 'Endereço',
                    children: [
                      EnderecoForm(endereco: inscricao.aluno.endereco!),
                    ],
                  ),
                  ExpandableGroup(
                    title: 'Modelos de documentos',
                    initiallyExpanded: true,
                    children: [
                      const TextNormalWeak(
                        text:
                            'Utilize esses modelos fornecidos para preenchimento e os anexe '
                            'nos documentos da inscrição correspondentes.',
                      ),
                      const SizedBox(height: 20),
                      ...buildDocumentosModelo(inscricao),
                    ],
                  ),
                  ExpandableGroup(
                    title: 'Documentos da inscrição',
                    subtitle: 'Anexe aqui os documentos necessários.',
                    initiallyExpanded: true,
                    children: [
                      ...buildDocumentosInscricao(inscricao),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          maxLines: 3,
                          decoration: const InputDecoration(
                            label: Text('Observações'),
                            alignLabelWithHint: true,
                          ),
                          onChanged: (value) => inscricao.observacoes = value,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size.fromHeight(50),
                            ),
                            onPressed: () => save(inscricao),
                            child: FutureTracker<void>(
                              future: _saveFuture,
                              loading: const Spinner(),
                              completed: (value) =>
                                  const Text('REALIZAR INSCRIÇÃO'),
                              error: (error) => const Text('TENTAR NOVAMENTE'),
                              onError: showError,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  List<Widget> buildDocumentosModelo(Inscricao inscricao) {
    return inscricao.documentos!
        .where((element) => element.documento.arquivoId != null)
        .map(
          (inscricaoDocumento) => FileCard(
            id: inscricaoDocumento.documento.arquivoId!,
            description: inscricaoDocumento.documento.nome,
          ),
        )
        .toList();
  }

  List<Widget> buildDocumentosInscricao(Inscricao inscricao) {
    return List.generate(
      inscricao.documentos!.length,
      (index) => InscricaoDocumentoCard(
        inscricaoDocumento: inscricao.documentos![index],
      ),
    );
  }
}

class ExpandableGroup extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> children;
  final bool initiallyExpanded;

  const ExpandableGroup(
      {Key? key,
      required this.title,
      required this.children,
      this.initiallyExpanded = false,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: TextSubTitle(text: title),
      subtitle: subtitle != null ? TextNormalWeak(text: subtitle!) : null,
      childrenPadding: const EdgeInsets.all(16),
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      initiallyExpanded: initiallyExpanded,
      children: children,
    );
  }
}
