import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../controller/splash_atualizacao_view_controller.dart';
import '../injection/splash_atualizacao_view_injection.dart';

class SplashAtualizacao extends Screen {
  const SplashAtualizacao({super.key});

  @override
  ScreenInjection<ScreenController> build(BuildContext context) {
    return SplashAtualizacaoViewInjection(
      child: Builder(
        builder: (context) => SplashAtualizacaoView(context: context),
      )
    );
  }
}

// ignore: must_be_immutable
class SplashAtualizacaoView extends ScreenView<SplahAtualizacaoViewController, SplashAtualizacaoViewInjection> {
  SplashAtualizacaoView({super.key, super.context});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold();
  }
}