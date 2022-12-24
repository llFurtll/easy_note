import 'package:flutter/material.dart';

import '../pages/configuracao/configuracao_edit_view/view/configuracao_edit_view.dart';
import '../pages/configuracao/configuracao_list_view/view/configuracao_list_view.dart';
import '../pages/home_view/view/home_view.dart';
import '../pages/sobre_view/view/sobre_view.dart';
import '../pages/splash/splash_view/view/splash_view.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    Splash.splashRoute: (context) => const Splash(),
    Home.homeRoute: (context) => const Home(),
    SobreView.routeSobre: (context) => SobreView(),
    ConfiguracaoView.routeConfig: (context) => ConfiguracaoView(),
    ConfiguracaoEdit.routeConfigEdit: (context) => const ConfiguracaoEdit()
  };
}