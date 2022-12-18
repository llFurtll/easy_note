import 'package:flutter/material.dart';

import 'package:compmanager/screen_injection.dart';

import '../controller/home_view_controller.dart';

// ignore: must_be_immutable
class HomeViewInjection extends ScreenInjection<HomeViewController> {
  HomeViewInjection({
    super.key,
    required Builder child
  }) : super(
    child: child,
    controller: HomeViewController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}