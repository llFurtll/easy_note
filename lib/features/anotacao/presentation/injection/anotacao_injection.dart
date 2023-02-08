import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../controller/anotacao_controller.dart';

class AnotacaoInjection extends ScreenInjection<AnotacaoController> {
  AnotacaoInjection({
    super.key,
    required ScreenBridge child
  }) : super(
    child: child,
    controller: AnotacaoController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}