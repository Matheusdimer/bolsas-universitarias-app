import 'package:bolsas_universitarias/components/error_page.dart';
import 'package:bolsas_universitarias/components/future_tracker.dart';
import 'package:bolsas_universitarias/components/loading_detail.dart';
import 'package:bolsas_universitarias/components/spinner.dart';
import 'package:bolsas_universitarias/components/text_views.dart';
import 'package:bolsas_universitarias/model/inscricao.dart';
import 'package:bolsas_universitarias/pages/app/inscricoes/inscricao.service.dart';
import 'package:bolsas_universitarias/pages/app/inscricoes/inscricao_documento_card.dart';
import 'package:bolsas_universitarias/pages/app/inscricoes/inscricao_info.dart';
import 'package:bolsas_universitarias/utils/snackbar.dart';
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
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final message = error is DioError
          ? error.response?.data['message'] ?? error.message
          : error.toString();
      showSnackBar(context, message);
    });
  }

  bool isAguardandoCorrecao(Inscricao inscricao) {
    return inscricao.situacao == SituacaoInscricao.AGUARDANDO_CORRECAO;
  }

  @override
  Widget build(BuildContext context) {
    final inscricao = ModalRoute.of(context)!.settings.arguments as Inscricao;

    return Scaffold(
      appBar: AppBar(title: const Text('Inscrição')),
      body: FutureTracker<Inscricao>(
        future: _inscricaoService.find(inscricao.id!),
        loading: const LoadingDetail(),
        completed: (inscricao) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InscricaoInfo(inscricao: inscricao),
                if (isAguardandoCorrecao(inscricao)) ...[
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
                if (isAguardandoCorrecao(inscricao))
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
                const SizedBox(height: 10),
                if (isAguardandoCorrecao(inscricao))
                  ElevatedButton(
                    onPressed: () => retornarAnalise(inscricao),
                    child: FutureTracker<void>(
                      future: _saveFuture,
                      loading: const Spinner(),
                      completed: (value) => const Text('RETORNAR PARA ANÁLISE'),
                      error: (error) => const Text('TENTAR NOVAMENTE'),
                      onError: showError,
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromHeight(50),
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
        disabled: !isAguardandoCorrecao(inscricao),
      ),
    );
  }
}
