import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../../core/arguments/novo_detalhe_view_arguments.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/widgets/show_loading.dart';
import '../../../../domain/entities/atualizacao.dart';
import '../../../../domain/usecases/get_find_atualizacao_by_versao.dart';
import '../../../../domain/usecases/get_save_visualizacao.dart';
import '../../../home/view/home_view.dart';
import '../../../splash/view/splash_view.dart';
import '../injection/novo_detalhe_injection.dart';

class NovoDetalheController extends ScreenController {
  final List<Atualizacao> lista = [];
  final isLoading = ValueNotifier(true);
  
  bool isError = false;
  late NovoDetalheViewArguments arguments;

  @override
  void onInit() {
    super.onInit();
    arguments = ModalRoute.of(context)?.settings.arguments as NovoDetalheViewArguments;

    Future.value()
      .then((_) => _onLoadAtualizacao(arguments.idVersao))
      .then((response) {
        response.fold((left) {
          isError = true;
        }, (right) {
          if (right.isEmpty) {
            isError = true;
          } else {
            lista.addAll(right);
          }
        });
      })
      .then((_) => isLoading.value = false);
  }

  void onContinue() {
    if (arguments.isSplash) {
      showLoading(context);

      Future.value()
        .then((_) async {
          final getSaveVisualizacao = ScreenInjection.of<NovoDetalheInjection>(context).getSaveVisualizacao;
          await getSaveVisualizacao(SaveVisualizacaoParams(
            idUsuario: 1,
            idVersao: arguments.idVersao
          ));
        })
        .then((_) => Navigator.pushNamedAndRemoveUntil(context, Home.routeHome, ModalRoute.withName(Splash.splashRoute)));
    } else {
      Navigator.pop(context);
    }
  }

  Future<Result<Failure, List<Atualizacao>>> _onLoadAtualizacao(int idVersao) async {
    final getAtualizacoes = ScreenInjection.of<NovoDetalheInjection>(context).getFindAtualizacaoByVersao;
    return await getAtualizacoes(FindAtualizacaoByVersaoParams(idVersao: idVersao));
  }
}