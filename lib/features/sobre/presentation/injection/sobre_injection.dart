import 'package:screen_manager/screen_injection.dart';
import 'package:screen_manager/screen_view.dart';
import 'package:flutter/material.dart';

import '../controller/sobre_controller.dart';

class SobreInjection extends ScreenInjection<SobreController> {
  SobreInjection({
    super.key,
    required ScreenBridge child
  }) : super(
    child: child,
    controller: SobreController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}