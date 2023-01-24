import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../controller/configuracao_edit_controller.dart';

// ignore: must_be_immutable
class ConfiguracaoEditInjection extends ScreenInjection<ConfiguracaoEditController> {
  ConfiguracaoEditInjection({
    required ScreenBridge child,
    super.key
  }) : super(
    child: child,
    controller: ConfiguracaoEditController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}