import 'package:flutter/material.dart';

import 'package:compmanager/screen_injection.dart';

import '../controller/splash_view_controller.dart';

// ignore: must_be_immutable
class SplashViewInjection extends ScreenInjection<SplashViewController> {
  SplashViewInjection({
    super.key,
    required Builder child
  }) : super(
    controller: SplashViewController(),
    child: child
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}