import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/get_existe_versao_without_view.dart';
import '../../../domain/usecases/get_find_last_versao.dart';
import '../controller/splash_controller.dart';

// ignore: must_be_immutable
class SplashInjection extends ScreenInjection<SplashController> {
  GetFindLastVersao getFindLastVersao;
  GetExisteVersaoWithoutView getExisteVersaoWithoutView;

  SplashInjection({
    super.key,
    required ScreenBridge child,
    required this.getFindLastVersao,
    required this.getExisteVersaoWithoutView,
  }) : super(
    controller: SplashController(),
    child: child
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}