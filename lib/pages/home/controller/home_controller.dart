import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/anotacao.dart';
import '../../../domain/usecases/get_find_all_anotacao.dart';
import '../../configuracao/configuracao_list/view/configuracao_list_view.dart';
import '../../novo/novo_list/view/novo_list_view.dart';
import '../../sobre/view/sobre_view.dart';
import '../injection/home_injection.dart';

class HomeController extends ScreenController {
  final FocusNode focusNode = FocusNode();
  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  final List<Anotacao> anotacoes = [];
  final TextEditingController textController = TextEditingController();

  late GetFindAllAnotacao getFindAllAnotacao;

  @override
  void onInit() {
    super.onInit();

    getFindAllAnotacao = ScreenInjection.of<HomeInjection>(context).getFindAllAnotacao;

    Future.value()
      .then((_) => loadAnotacoes(""))
      .then((value) {
        if (value != null && value.isNotEmpty) {
          anotacoes.addAll(value);
        }
      })
      .then((_) => isLoading.value = false);
  }

  Future<List<Anotacao>?> loadAnotacoes(String descricao) async {
    return await getFindAllAnotacao(FindAllAnotacaoParams(descricao: descricao));
  }

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
    Navigator.of(context).pushNamed(Sobre.routeSobre);
  }

  void toConfiguracao() {
    Navigator.of(context).pushNamed(ConfiguracaoList.routeConfig);
  }

  void toNovo() {
    Navigator.of(context).pushNamed(NovoList.routeNovoList);
  }
}