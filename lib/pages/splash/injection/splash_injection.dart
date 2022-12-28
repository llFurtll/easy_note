import 'package:flutter/material.dart';

import 'package:compmanager/screen_injection.dart';

import '../controller/splash_controller.dart';

// ignore: must_be_immutable
class SplashInjection extends ScreenInjection<SplashController> {
  SplashInjection({
    super.key,
    required Builder child
  }) : super(
    controller: SplashController(),
    child: child
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}