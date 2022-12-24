import 'package:compmanager/screen_controller.dart';
import 'package:flutter/material.dart';

import '../../configuracao/configuracao_list_view/view/configuracao_list_view.dart';
import '../../sobre_view/view/sobre_view.dart';

class HomeViewController extends ScreenController {
  final FocusNode focusNode = FocusNode();

  void removeFocus() {
    focusNode.unfocus();
  }

  bool verifySize(BoxConstraints constraints) {
    var height = MediaQuery.of(context).padding.top;
    var top = constraints.biggest.height;
    if (top == height + kToolbarHeight) {
      return true;
    } else {
      return false;
    }
  }

  void toSobre() {
    Navigator.of(context).pushNamed(SobreView.routeSobre);
  }

  void toConfiguracao() {
    Navigator.of(context).pushNamed(ConfiguracaoView.routeConfig);
  }
}