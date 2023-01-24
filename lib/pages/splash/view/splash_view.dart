import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../data/datasources/atualizacao_data_source.dart';
import '../../../data/datasources/versao_data_source.dart';
import '../../../data/repositories/atualizacao_repository_impl.dart';
import '../../../data/repositories/versao_repository_impl.dart';
import '../../../domain/usecases/get_existe_versao_without_view.dart';
import '../../../domain/usecases/get_find_last_versao.dart';
import '../controller/splash_controller.dart';
import '../injection/splash_injection.dart';

class Splash extends Screen {
  static const splashRoute = "/";

  const Splash({super.key});

  @override
  SplashInjection build(BuildContext context) {
    return SplashInjection(
      getFindLastVersao: GetFindLastVersao(
        VersaoRepositoryImpl(dataSource: VersaoDataSourceImpl())
      ),
      getExisteVersaoWithoutView: GetExisteVersaoWithoutView(
        AtualizacaoRepositoryImpl(dataSource: AtualizacaoDataSourceImpl())
      ),
      child: const ScreenBridge<SplashController, SplashInjection>(
        child: SplashView()
      )
    );
  }
}

// ignore: must_be_immutable
class SplashView extends ScreenView<SplashController> {
  const SplashView({super.key});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Image.asset("lib/images/easy-note-logo.png"),
      ),
    );
  }
}