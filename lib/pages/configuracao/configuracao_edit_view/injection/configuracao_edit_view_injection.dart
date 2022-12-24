import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../controller/configuracao_edit_view_controller.dart';

// ignore: must_be_immutable
class ConfiguracaoEditViewInjection extends ScreenInjection<ConfiguracaoEditViewController> {
  ConfiguracaoEditViewInjection({
    required Builder child,
    super.key
  }) : super(
    child: child,
    controller: ConfiguracaoEditViewController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}