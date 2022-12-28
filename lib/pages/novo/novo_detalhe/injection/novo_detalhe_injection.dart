import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../controller/novo_detalhe_controller.dart';

// ignore: must_be_immutable
class NovoDetalheInjection extends ScreenInjection<NovoDetalheController> {
  NovoDetalheInjection({
    super.key,
    required super.child
  }) : super(
    controller: NovoDetalheController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}