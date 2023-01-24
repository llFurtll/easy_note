import 'package:flutter/material.dart';

import '../pages/configuracao/configuracao_edit/view/configuracao_edit_view.dart';
import '../pages/configuracao/configuracao_list/view/configuracao_list_view.dart';
import '../pages/home/view/home_view.dart';
import '../pages/novo/novo_detalhe/view/novo_detalhe_view.dart';
import '../pages/novo/novo_list/view/novo_list_view.dart';
import '../pages/sobre/view/sobre_view.dart';
import '../pages/splash/view/splash_view.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    Splash.splashRoute: (context) => const Splash(),
    Home.routeHome: (context) => const Home(),
    Sobre.routeSobre: (context) => const Sobre(),
    ConfiguracaoList.routeConfig: (context) => const ConfiguracaoList(),
    ConfiguracaoEdit.routeConfigEdit: (context) => const ConfiguracaoEdit(),
    NovoList.routeNovoList: (context) => const NovoList(),
    NovoDetalhe.routeNovoDetalhe: (context) => const NovoDetalhe()
  };
}