import 'package:screen_manager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../controller/configuracao_list_controller.dart';

class ConfiguracaoListInjection extends ScreenInjection<ConfiguracaoListController> {
  ConfiguracaoListInjection({
    super.key,
    required super.child
  }) : super(
    controller: ConfiguracaoListController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}