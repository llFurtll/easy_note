import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../../core/arguments/novo_detalhe_view_arguments.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/versao.dart';
import '../../novo_detalhe/view/novo_detalhe_view.dart';
import '../injection/novo_list_injection.dart';

class NovoListController extends ScreenController {
  final isLoading = ValueNotifier(true);
  final List<Versao> versoes = [];

  bool isError = false;

  @override
  void onInit() {
    super.onInit();

    Future.value()
      .then((_) => _onLoadVersoes())
      .then((result) {
        result.fold((left) {
          isError = true;
        }, (right) {
          if (right.isEmpty) {
            isError = true;
          } else {
            versoes.addAll(right);
          }
        });
      })
      .then((_) => isLoading.value = false);
  }

  Future<void> toSplashAtualizacao(int idVersao) async {
    Navigator.of(context).pushNamed(
      NovoDetalhe.routeNovoDetalhe,
      arguments: NovoDetalheViewArguments(idVersao: idVersao, isSplash: false)
    );
  }

  Future<Result<Failure, List<Versao>>> _onLoadVersoes() async {
    final getFindAllVersao = ScreenInjection.of<NovoListInjection>(context).getFindAllVersao;
    return await getFindAllVersao(NoParams());
  }
}