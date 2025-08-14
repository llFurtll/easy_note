import 'package:screen_manager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../controller/sobre_controller.dart';

class SobreInjection extends ScreenInjection<SobreController> {
  SobreInjection({
    super.key,
    required super.child
  }) : super(
    controller: SobreController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}