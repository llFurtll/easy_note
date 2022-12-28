import 'package:flutter/material.dart';

import 'package:compmanager/screen_injection.dart';

import '../controller/home_controller.dart';

// ignore: must_be_immutable
class HomeInjection extends ScreenInjection<HomeController> {
  HomeInjection({
    super.key,
    required Builder child
  }) : super(
    child: child,
    controller: HomeController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}