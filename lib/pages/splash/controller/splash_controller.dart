import 'package:flutter/material.dart';

import 'package:compmanager/screen_controller.dart';

import '../../home/view/home_view.dart';

class SplashController extends ScreenController {
  @override
  void onInit() {
    super.onInit();

    Future.value()
    .then((_) => getVersao())
    .then((_) => getAtualizacoes())
    .then((_) => Future.delayed(const Duration(seconds: 3)))
    .then((_) => toHome());
  }

  Future<int> getVersao() async {
    return 0;
  }

  Future<List<String>> getAtualizacoes() async {
    return [];
  }

  void toHome() {
    Navigator.of(context).pushNamed(Home.routeHome);
  }
}