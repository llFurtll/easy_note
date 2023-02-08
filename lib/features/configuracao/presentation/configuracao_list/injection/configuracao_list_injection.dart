import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../controller/configuracao_list_controller.dart';

class ConfiguracaoListInjection extends ScreenInjection<ConfiguracaoListController> {
  ConfiguracaoListInjection({
    super.key,
    required ScreenBridge child
  }) : super(
    child: child,
    controller: ConfiguracaoListController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}