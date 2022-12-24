import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../controller/splash_atualizacao_view_controller.dart';

// ignore: must_be_immutable
class SplashAtualizacaoViewInjection extends ScreenInjection<SplahAtualizacaoViewController> {
  SplashAtualizacaoViewInjection({
    super.key,
    required super.child
  }) : super(
    controller: SplahAtualizacaoViewController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}