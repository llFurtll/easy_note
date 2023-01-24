import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../controller/home_controller.dart';

// ignore: must_be_immutable
class HomeInjection extends ScreenInjection<HomeController> {
  HomeInjection({
    super.key,
    required ScreenBridge child
  }) : super(
    child: child,
    controller: HomeController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}