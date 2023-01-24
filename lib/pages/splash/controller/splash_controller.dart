import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:easy_note/core/arguments/novo_detalhe_view_arguments.dart';
import 'package:easy_note/pages/novo/novo_detalhe/view/novo_detalhe_view.dart';
import 'package:flutter/material.dart';

import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_existe_versao_without_view.dart';
import '../../home/view/home_view.dart';
import '../injection/splash_injection.dart';

class SplashController extends ScreenController {
  @override
  void onInit() {
    super.onInit();

    Future.value()
    .then((_) => Future.delayed(const Duration(seconds: 2)))
    .then((_) => getVersao())
    .then((idVersao) async {
      if (idVersao != null) {
        final existe = await getExisteVersaoWithoutView(idVersao);

        if (existe != null && existe) return idVersao;
      }

      return null;
    })
    .then((result) {
      if (result == null) toHome();

      if (result! > 0) {
        toAtualizacao(result);
      }
    });
  }

  Future<int?> getVersao() async {
    final getFindLastVersao = ScreenInjection.of<SplashInjection>(context).getFindLastVersao;
    return await getFindLastVersao(NoParams());
  }

  Future<bool?> getExisteVersaoWithoutView(int idVersao) async {
    final getExisteVersaoWithoutView = ScreenInjection.of<SplashInjection>(context).getExisteVersaoWithoutView;
    return await getExisteVersaoWithoutView(GetExisteVersaoWithoutViewParams(idVersao: idVersao));
  }

  void toHome() {
    Navigator.of(context).pushNamed(Home.routeHome);
  }

  void toAtualizacao(int idVersao) {
    Navigator.of(context).pushNamed(
      NovoDetalhe.routeNovoDetalhe,
      arguments: NovoDetalheViewArguments(idVersao: idVersao, isSplash: true)
    );
  }
}