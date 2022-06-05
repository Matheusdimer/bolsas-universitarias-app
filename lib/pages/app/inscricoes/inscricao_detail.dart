import 'package:app/components/badge.dart';
import 'package:app/components/error_page.dart';
import 'package:app/components/future_tracker.dart';
import 'package:app/components/spinner.dart';
import 'package:app/components/text_views.dart';
import 'package:app/model/inscricao.dart';
import 'package:app/pages/app/inscricoes/inscricao.service.dart';
import 'package:app/pages/app/inscricoes/inscricao_documento_card.dart';
import 'package:app/utils/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class InscricaoDetail extends StatefulWidget {
  const InscricaoDetail({Key? key}) : super(key: key);

  @override
  State<InscricaoDetail> createState() => _InscricaoDetailState();
}

class _InscricaoDetailState extends State<InscricaoDetail> {
  final _inscricaoService = InscricaoService();

  Future<void>? _saveFuture;

  set saveFuture(Future<void> value) {
    setState(() {
      _saveFuture = value;
    });
  }

  void retornarAnalise(Inscricao inscricao) {
    inscricao = inscricao.copy();
    inscricao.situacao = SituacaoInscricao.EM_ANALISE;
    saveFuture = _inscricaoService.update(inscricao).then((value) {
      showSnackBar(context, 'Sua inscrição foi retornada para análise.');
      Navigator.of(context).pop(true);
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
    final inscricao = ModalRoute.of(context)!.settings.arguments as Inscricao;

    return Scaffold(
      appBar: AppBar(title: const Text('Inscrição')),
      body: FutureTracker<Inscricao>(
        future: _inscricaoService.find(inscricao.id!),
        completed: (inscricao) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const TextNormalBold(text: 'Código: '),
                        Badge(
                          type: BadgeType.white,
                          text: inscricao.id!.toString(),
                        ),
                      ],
                    ),
                    Badge(
                      type: inscricao.situacao!.badge,
                      text: inscricao.situacao!.description,
                    )
                  ],
                ),
                if (inscricao.situacao ==
                    SituacaoInscricao.AGUARDANDO_CORRECAO) ...[
                  const SizedBox(height: 20),
                  const TextNormal(
                    text: 'Sua inscrição foi retornada pelo(a) assistente'
                        ' social. Faça os ajustes necessários e retorne '
                        'para análise.',
                  ),
                ],
                if (inscricao.motivoRetorno != null) ...[
                  const SizedBox(height: 20),
                  const TextSubTitle(text: 'Motivo do retorno'),
                  const SizedBox(height: 10),
                  TextNormal(text: inscricao.motivoRetorno!)
                ],
                const SizedBox(height: 20),
                const TextSubTitle(text: 'Observações do aluno'),
                const SizedBox(height: 10),
                if (inscricao.situacao == SituacaoInscricao.AGUARDANDO_CORRECAO)
                  TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                      label: Text('Observações'),
                      alignLabelWithHint: true,
                    ),
                    onChanged: (value) => inscricao.observacoes = value,
                  )
                else
                  TextNormal(text: inscricao.observacoes ?? '---'),
                const SizedBox(height: 20),
                const TextSubTitle(text: 'Documentos'),
                const SizedBox(height: 10),
                ...buildDocumentosList(inscricao),
                if (inscricao.situacao == SituacaoInscricao.AGUARDANDO_CORRECAO)
                  ElevatedButton(
                    onPressed: () => retornarAnalise(inscricao),
                    child: FutureTracker<void>(
                      future: _saveFuture,
                      loading: const Spinner(),
                      completed: (value) => const Text('RETORNAR PARA ANÁLISE'),
                      error: (error) => const Text('TENTAR NOVAMENTE'),
                      onError: showError,
                    ),
                  ),
              ],
            ),
          ),
        ),
        error: buildErrorPage(context),
      ),
    );
  }

  List<Widget> buildDocumentosList(Inscricao inscricao) {
    return List.generate(
      inscricao.documentos?.length ?? 0,
      (index) => InscricaoDocumentoCard(
        inscricaoDocumento: inscricao.documentos![index],
        disabled: inscricao.situacao != SituacaoInscricao.AGUARDANDO_CORRECAO,
      ),
    );
  }
}
