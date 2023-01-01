import 'package:compmanager/screen_controller.dart';
import 'package:easy_note/domain/entities/versao.dart';
import 'package:easy_note/pages/novo/novo_list/injection/novo_list_injection.dart';
import 'package:flutter/material.dart';

import '../../novo_detalhe/view/novo_detalhe_view.dart';

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
        if (result == null || result.isEmpty) {
          isError = true;
        } else {
          versoes.addAll(result);
        }
      })
      .then((_) => isLoading.value = false);
  }

  void toSplashAtualizacao() {
    Navigator.of(context).pushNamed(NovoDetalhe.routeNovoDetalhe);
  }

  Future<List<Versao>?> _onLoadVersoes() async {
    final getFindAllVersao = NovoListInjection.of(context).getFindAllVersao;
    return await getFindAllVersao.findAll();
  }
}