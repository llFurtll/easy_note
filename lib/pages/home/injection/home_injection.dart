import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/get_find_all_anotacao.dart';
import '../controller/home_controller.dart';

// ignore: must_be_immutable
class HomeInjection extends ScreenInjection<HomeController> {
  final GetFindAllAnotacao getFindAllAnotacao;

  HomeInjection({
    super.key,
    required ScreenBridge child,
    required this.getFindAllAnotacao
  }) : super(
    child: child,
    controller: HomeController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}