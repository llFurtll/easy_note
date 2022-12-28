import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../controller/novo_list_controller.dart';

// ignore: must_be_immutable
class NovoListInjection extends ScreenInjection<NovoListController> {
  NovoListInjection({
    super.key,
    required super.child
  }) : super(
    controller: NovoListController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}