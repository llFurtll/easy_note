import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../controller/splash_controller.dart';

// ignore: must_be_immutable
class SplashInjection extends ScreenInjection<SplashController> {
  SplashInjection({
    super.key,
    required ScreenBridge child
  }) : super(
    controller: SplashController(),
    child: child
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}