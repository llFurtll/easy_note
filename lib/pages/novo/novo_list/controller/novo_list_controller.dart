import 'package:compmanager/screen_controller.dart';
import 'package:flutter/material.dart';

import '../../novo_detalhe/view/novo_detalhe_view.dart';

class NovoListController extends ScreenController {
  final isLoading = ValueNotifier(false);

  void toSplashAtualizacao() {
    Navigator.of(context).pushNamed(NovoDetalhe.routeNovoDetalhe);
  }
}