import 'package:flutter/material.dart';

import '../features/anotacao/presentation/view/anotacao_view.dart';
import '../features/atualizacao/presentation/atualizacao_detalhe/view/atualizacao_detalhe_view.dart';
import '../features/atualizacao/presentation/atualizacao_list/view/atualizacao_list_view.dart';
import '../features/configuracao/presentation/configuracao_edit/view/configuracao_edit_view.dart';
import '../features/configuracao/presentation/configuracao_list/view/configuracao_list_view.dart';
import '../features/home/view/home_view.dart';
import '../features/sobre/presentation/view/sobre_view.dart';
import '../features/splash/presentation/view/splash_view.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    Splash.routeSplash: (context) => const Splash(),
    Home.routeHome: (context) => const Home(),
    Sobre.routeSobre: (context) => const Sobre(),
    ConfiguracaoList.routeConfig: (context) => const ConfiguracaoList(),
    ConfiguracaoEdit.routeConfigEdit: (context) => const ConfiguracaoEdit(),
    AtualizacaoList.routeAtualizacaoList: (context) => const AtualizacaoList(),
    AtualizacaoDetalhe.routeAtualizacaoDetalhe: (context) => const AtualizacaoDetalhe(),
    AnotacaoScreen.routeAnotacao: (context) => const AnotacaoScreen()
  };
}